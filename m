Return-Path: <netdev+bounces-103150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A895B90692A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32DA8B24981
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED913FD64;
	Thu, 13 Jun 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V8bugMtz"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BE13F452
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271817; cv=none; b=jNY14aH1i+Da9o1b07KmOTprEA/62jcg9gbxHzHC1Q79NDTq+Hi+367QdAytw/jndUQ3m2fMd52moZblc+AeRbrDkHMMBvJeEKXaOM92gtKbRR526nNQjV00Ef71JvZ5kRk72+NdsX+5iIdftKKKZYOpFFnFKG9kJPvUFxBX7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271817; c=relaxed/simple;
	bh=R0KvaWh3crVUHX8EMkqspv7bz8v+Sxh3YJgTjxlHjSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bv0o81FjjG6HutM+l0rDjmsnD4wb8RnpQ8lrAMFOIku2s5rSHd3EeVcCgaJkNY7Lu+STsxCowFfXrZY571CIKIpo++xHK1Xv1daJ1EagGZGm6zgiLAHeVEjbVWVJhbkr+4k1+HXgAOkL3MBwm2rs85lP2aa+0Zjq+7E6DqUrla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V8bugMtz; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=vghtZ
	gM/I4qE4RVHbnmwg/074QuUoEB3tTs+OilKGy8=; b=V8bugMtzkkVCnVSV3uA8T
	U1zsflPyPnoUil7Zip/mXNBNEA2nV+DarrMJIwrHyBDk/+ojTrZyOheAZeJ69tzM
	67kb4ybhJ7ZLPbpwcjWwqT/9X0MtG1CU5BSUj3ze9w9zLnOkf8vAqBbDyeSg+Sxq
	zgUah+JSANAysLUmXxvQwg=
Received: from vm-dev.test.com (unknown [36.111.140.9])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wBnNyApv2pmg1QMIA--.14264S4;
	Thu, 13 Jun 2024 17:43:07 +0800 (CST)
From: wujianguo106@163.com
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	contact@proelbtn.com,
	pablo@netfilter.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	wujianguo106@163.com,
	Jianguo Wu <wujianguo@chinatelecom.cn>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 1/4] seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and End.DX6 behaviors
Date: Thu, 13 Jun 2024 17:42:46 +0800
Message-ID: <20240613094249.32658-2-wujianguo106@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613094249.32658-1-wujianguo106@163.com>
References: <20240613094249.32658-1-wujianguo106@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnNyApv2pmg1QMIA--.14264S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1rKrWfJF18JrykAw48Xrb_yoWrJr1rpF
	15Cw1qvFW5JF1xtr4FvF4DZrW5uw4F9FnxCrn5C34Yv390qr1vyrs2vr15Wr1UJrs3CFWY
	qasF9r4xKwn8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEDUUUUUUUU=
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiRAz8kGVODNfP6QAAsy

From: Jianguo Wu <wujianguo@chinatelecom.cn>

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
index 24e2b4b494cb..c434940131b1 100644
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
2.25.1


