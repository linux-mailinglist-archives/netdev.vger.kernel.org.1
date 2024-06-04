Return-Path: <netdev+bounces-100633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B1F8FB66E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261971C208E9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2B713CA9A;
	Tue,  4 Jun 2024 15:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-07.21cn.com [182.42.151.156])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A79D12D765
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.151.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513255; cv=none; b=LDq5lTbeRUGq+x0+LrP2dp+rAnCAHq3SnHRZzkkqdgpZ6sdbm+82kbLWYcdxuqTaiC0AgiD8L7Hia8GY3yQpB6EW6HKiIQnXMosFSUmvusNkaHWo/V6vhxphpL3Gdw0RqB5gLNFM7WSYqNK2ENFhXv2+Afuaoi9aHCtKyq7r8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513255; c=relaxed/simple;
	bh=mDOxQ0Q+7Kz/UFgo3/xPlIvUC1mQgM8mKRSONdkaE6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM4swVbHrxkN5KnZvtt0lZXCo4vMq7KPa5Ix+5pf4g9ar79KzA3NHk3eUXpYDG9VIANNmixBhKKVKVSfhsLJGVMegyJvkephABFHvHUq5azJ88GrRZu1FaYTm3f+HJ9ooVVlZSqhYAKLz7igMuaTNWhl+4Y8WgqxBtnqSWsXVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.151.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:63982.1038894331
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id C28749BCEE;
	Tue,  4 Jun 2024 22:50:16 +0800 (CST)
X-189-SAVE-TO-SEND: +wujianguo@chinatelecom.cn
Received: from  ([36.111.140.9])
	by gateway-mua-dep-b5744948-nkwsn with ESMTP id 2dcf9165decc40a4b29a93776314ba74 for netdev@vger.kernel.org;
	Tue, 04 Jun 2024 22:50:19 CST
X-Transaction-ID: 2dcf9165decc40a4b29a93776314ba74
X-Real-From: wujianguo@chinatelecom.cn
X-Receive-IP: 36.111.140.9
X-MEDUSA-Status: 0
Sender: wujianguo@chinatelecom.cn
From: wujianguo <wujianguo@chinatelecom.cn>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	contact@proelbtn.com,
	pablo@netfilter.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	wujianguo106@163.com,
	wujianguo <wujianguo@chinatelecom.cn>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 1/3] seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and End.DX6 behaviors
Date: Tue,  4 Jun 2024 22:49:47 +0800
Message-ID: <20240604144949.22729-2-wujianguo@chinatelecom.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604144949.22729-1-wujianguo@chinatelecom.cn>
References: <20240604144949.22729-1-wujianguo@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianguo Wu <wujianguo@chinatelecom.cn>

input_action_end_dx4() and input_action_end_dx6() are called NF_HOOK() for
PREROUTING hook, in PREROUTING hook, we should passing a valid indev,
and a NULL outdev to NF_HOOK(), otherwise may trigger a NULL pointer
dereference, as below:

    [74830.647293] BUG: kernel NULL pointer dereference, address: 0000000000000090
    [74830.655633] #PF: supervisor read access in kernel mode
    [74830.657888] #PF: error_code(0x0000) - not-present page
    [74830.659500] PGD 0 P4D 0
    [74830.660450] Oops: 0000 [#1] PREEMPT SMP PTI
    ...
    [74830.664953] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
    [74830.666569] RIP: 0010:rpfilter_mt+0x44/0x15e [ipt_rpfilter]
    ...
    [74830.689725] Call Trace:
    [74830.690402]  <IRQ>
    [74830.690953]  ? show_trace_log_lvl+0x1c4/0x2df
    [74830.692020]  ? show_trace_log_lvl+0x1c4/0x2df
    [74830.693095]  ? ipt_do_table+0x286/0x710 [ip_tables]
    [74830.694275]  ? __die_body.cold+0x8/0xd
    [74830.695205]  ? page_fault_oops+0xac/0x140
    [74830.696244]  ? exc_page_fault+0x62/0x150
    [74830.697225]  ? asm_exc_page_fault+0x22/0x30
    [74830.698344]  ? rpfilter_mt+0x44/0x15e [ipt_rpfilter]
    [74830.699540]  ipt_do_table+0x286/0x710 [ip_tables]
    [74830.700758]  ? ip6_route_input+0x19d/0x240
    [74830.701752]  nf_hook_slow+0x3f/0xb0
    [74830.702678]  input_action_end_dx4+0x19b/0x1e0
    [74830.703735]  ? input_action_end_t+0xe0/0xe0
    [74830.704734]  seg6_local_input_core+0x2d/0x60
    [74830.705782]  lwtunnel_input+0x5b/0xb0
    [74830.706690]  __netif_receive_skb_one_core+0x63/0xa0
    [74830.707825]  process_backlog+0x99/0x140
    [74830.709538]  __napi_poll+0x2c/0x160
    [74830.710673]  net_rx_action+0x296/0x350
    [74830.711860]  __do_softirq+0xcb/0x2ac
    [74830.713049]  do_softirq+0x63/0x90

input_action_end_dx4() passing a NULL indev to NF_HOOK(), and finally
trigger a NULL dereference in rpfilter_mt()->rpfilter_is_loopback():

    static bool
    rpfilter_is_loopback(const struct sk_buff *skb,
          	       const struct net_device *in)
    {
            // in is NULL
            return skb->pkt_type == PACKET_LOOPBACK ||
          	 in->flags & IFF_LOOPBACK;
    }

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/ipv6/seg6_local.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 24e2b4b..c434940 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -941,8 +941,8 @@ static int input_action_end_dx6(struct sk_buff *skb,
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
-			       dev_net(skb->dev), NULL, skb, NULL,
-			       skb_dst(skb)->dev, input_action_end_dx6_finish);
+			       dev_net(skb->dev), NULL, skb, skb->dev,
+			       NULL, input_action_end_dx6_finish);
 
 	return input_action_end_dx6_finish(dev_net(skb->dev), NULL, skb);
 drop:
@@ -991,8 +991,8 @@ static int input_action_end_dx4(struct sk_buff *skb,
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
-			       dev_net(skb->dev), NULL, skb, NULL,
-			       skb_dst(skb)->dev, input_action_end_dx4_finish);
+			       dev_net(skb->dev), NULL, skb, skb->dev,
+			       NULL, input_action_end_dx4_finish);
 
 	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
 drop:
-- 
1.8.3.1


