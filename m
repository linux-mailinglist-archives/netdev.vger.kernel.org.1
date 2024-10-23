Return-Path: <netdev+bounces-138073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3B9ABC37
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DF21C22570
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA14F21D;
	Wed, 23 Oct 2024 03:34:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A998D27E;
	Wed, 23 Oct 2024 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729654482; cv=none; b=PFQfysF5NEAeLcLCMD5LsfYHqfXtFmG7RCURDCuVlI6aXHCPw383n9uvKVZnpRdLgZrzSoXNs9S2iDLej7AY7n4F6cT+NNIZDjSO0j3JrLzSC6idKuAHS1Bah/+KaFnBfrTaIEZZIsndYUy14BQ3ujqRWsQRiqo7V7f21TaHvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729654482; c=relaxed/simple;
	bh=cwNLnGMQy+quViV2dgGWgSSa27q77pz609jdpw9rMqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O50cO7XPrLtAJZg8XzlJBPG4Tx1TiHc5kEcZcoMm1jz5qSlXVWX2hGeQDUv1gEKlM539muau1ieu7AzE6hIVBg9pzf89UwvUH0h52uFwLA+lxy9Y6pqmjUfk+CofA2ccIo9arH2ASG9Z7zAKLVHFT38quxKAp95d/avK0Z1g4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYF3k6ggsz10NwB;
	Wed, 23 Oct 2024 11:32:34 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 79908140360;
	Wed, 23 Oct 2024 11:34:36 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Oct
 2024 11:34:35 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <kuniyu@amazon.com>,
	<stephen@networkplumber.org>, <dsahern@kernel.org>, <lucien.xin@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: fix crash when config small gso_max_size/gso_ipv4_max_size
Date: Wed, 23 Oct 2024 11:52:13 +0800
Message-ID: <20241023035213.517386-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200005.china.huawei.com (7.202.181.32)

Config a small gso_max_size/gso_ipv4_max_size will lead to an underflow
in sk_dst_gso_max_size(), which may trigger a BUG_ON crash,
because sk->sk_gso_max_size would be much bigger than device limits.
Call Trace:
tcp_write_xmit
    tso_segs = tcp_init_tso_segs(skb, mss_now);
        tcp_set_skb_tso_segs
            tcp_skb_pcount_set
                // skb->len = 524288, mss_now = 8
                // u16 tso_segs = 524288/8 = 65535 -> 0
                tso_segs = DIV_ROUND_UP(skb->len, mss_now)
    BUG_ON(!tso_segs)
Add check for the minimum value of gso_max_size and gso_ipv4_max_size.

Fixes: 46e6b992c250 ("rtnetlink: allow GSO maximums to be set on device creation")
Fixes: 9eefedd58ae1 ("net: add gso_ipv4_max_size and gro_ipv4_max_size per device")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/core/rtnetlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e30e7ea0207d..2ba5cd965d3f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2032,7 +2032,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_NUM_TX_QUEUES]	= { .type = NLA_U32 },
 	[IFLA_NUM_RX_QUEUES]	= { .type = NLA_U32 },
 	[IFLA_GSO_MAX_SEGS]	= { .type = NLA_U32 },
-	[IFLA_GSO_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_GSO_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_PHYS_PORT_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
 	[IFLA_CARRIER_CHANGES]	= { .type = NLA_U32 },  /* ignored */
 	[IFLA_PHYS_SWITCH_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
@@ -2057,7 +2057,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_TSO_MAX_SIZE]	= { .type = NLA_REJECT },
 	[IFLA_TSO_MAX_SEGS]	= { .type = NLA_REJECT },
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
-	[IFLA_GSO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
 };
 
-- 
2.34.1


