Return-Path: <netdev+bounces-235171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE3C2D128
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7758A4606D6
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC2423AB8D;
	Mon,  3 Nov 2025 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNNaSSUZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1813F275AE8
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184437; cv=none; b=gTI1txtg/dd2EEf+9kl5KbRhhOyjuOx/ZPlMY75aP8r4gS3SLxAcH9mKvBWXF5npHxwbd7PYgp1GCtuK4ZtDlmRS7bPlNEH9z0t6n8+grX5GKFbKNfVUSAoLupypwlaoRZOHk/H8ovA8G8nAPJV6LcQqr5Nyv6acAfqQivgeSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184437; c=relaxed/simple;
	bh=X0wiVDoDQ/lFIVflb6+x+uwRmf/djAYzNvf0460O2tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUsibMN/qZ/9UkWi38K6CSs+CBIUAB6rTc3Oi0izz2TGg1B+wstmFtfU4XCQ7SurYjChXj1p+VA9xREHy/FNya7GEiDB9wQySvFvG1db3hJS/ehEHfTuMz9ObV6Cth9fgF76Gu5Ici2TtWeSn8Cwj37iAX7uUqAt738ESdzT50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNNaSSUZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762184434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o9wfXsJS9xOV8WFM6Ew+60eZBPyQWXtK745crlrG0W8=;
	b=VNNaSSUZXw8xkqz2vcXLG67RUZ/TB82xMDYYJ9aAOWcv7ypuNHNneNFfM7wDtBUqtNXNV1
	O4P3yRIbeZxsf9C7ILs3Lvbv5VAPToM1Yok7Cx5Qv5eSkVdbV1a/HYOyF/5MhzEJF2mToX
	VEpp3uoqeE6D/Sutdz3hq93891xHACQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102--LThxPVfNm6oI7BQImudPw-1; Mon,
 03 Nov 2025 10:40:30 -0500
X-MC-Unique: -LThxPVfNm6oI7BQImudPw-1
X-Mimecast-MFC-AGG-ID: -LThxPVfNm6oI7BQImudPw_1762184428
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 003DB180AE37;
	Mon,  3 Nov 2025 15:40:16 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.33.211])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67A7119540DD;
	Mon,  3 Nov 2025 15:40:09 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	nicolas.dichtel@6wind.com,
	toke@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
Date: Mon,  3 Nov 2025 16:40:04 +0100
Message-ID: <20251103154006.1189707-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Gathering interface statistics can be a relatively expensive operation
on certain systems as it requires iterating over all the cpus.

RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
statistics from interface dumps and it was then extended [2] to
also exclude IFLA_VF_INFO.

The semantics of the flag does not seem to be limited to AF_INET
or VF statistics and having a way to query the interface status
(e.g: carrier, address) without retrieving its statistics seems
reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
to also affect IFLA_STATS.

[1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
[2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/core/rtnetlink.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8040ff7c356e..b2a8920df1cc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1270,13 +1270,13 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
 static noinline size_t if_nlmsg_size(const struct net_device *dev,
 				     u32 ext_filter_mask)
 {
-	return NLMSG_ALIGN(sizeof(struct ifinfomsg))
+	size_t size;
+
+	size = NLMSG_ALIGN(sizeof(struct ifinfomsg))
 	       + nla_total_size(IFNAMSIZ) /* IFLA_IFNAME */
 	       + nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
 	       + nla_total_size(IFNAMSIZ) /* IFLA_QDISC */
 	       + nla_total_size_64bit(sizeof(struct rtnl_link_ifmap))
-	       + nla_total_size(sizeof(struct rtnl_link_stats))
-	       + nla_total_size_64bit(sizeof(struct rtnl_link_stats64))
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_ADDRESS */
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_BROADCAST */
 	       + nla_total_size(4) /* IFLA_TXQLEN */
@@ -1329,6 +1329,12 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
 	       + 0;
+
+	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))
+		size += nla_total_size(sizeof(struct rtnl_link_stats)) +
+			nla_total_size_64bit(sizeof(struct rtnl_link_stats64));
+
+	return size;
 }
 
 static int rtnl_vf_ports_fill(struct sk_buff *skb, struct net_device *dev)
@@ -2123,7 +2129,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (rtnl_phys_switch_id_fill(skb, dev))
 		goto nla_put_failure;
 
-	if (rtnl_fill_stats(skb, dev))
+	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS) &&
+	    rtnl_fill_stats(skb, dev))
 		goto nla_put_failure;
 
 	if (rtnl_fill_vf(skb, dev, ext_filter_mask))
-- 
2.51.1


