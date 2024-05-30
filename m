Return-Path: <netdev+bounces-99311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333738D464C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2DF1F2116C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB674044;
	Thu, 30 May 2024 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pSKnIIRr"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5C55886
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055063; cv=none; b=mVNKXL3eRPlAyzxvUAUMJ/HnATDzjnRo+wKZ4JSCLejxktvhT1inc9U0/TPhEPji0yTAed9ukYUOEasjGVHQnVYXZV81fIg3PaQF33NqjquIQYmmtLKkCI47a3GYmDDDdffYs44HGcJ4LgrdoF8Zo7wLmORbIM/HB+qBDn8NyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055063; c=relaxed/simple;
	bh=7HHSgFtDX80mybV7gy5+n+NOv74rRRgcavOq94QIsB4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BQ6P8RZpU0Be7WSBS8BmmIDUlii5rp6Fq3J6DFOJ1ejMsPtzJfoGV8MOP8ewv7GTh2PFZL90xa/RpoIGEuluY+ck0NzXV+BcJFRVgqHmoxOHoC0tZL/XVdmIHQh0llqvbf7/cIgSm7pzTE5HxwsVFl7GSHiTRSdZp5lkt+Adzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pSKnIIRr; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:
	Content-Type; bh=deJIeHlC9ylWg3ZiHg1ftYFx8ASyBAc5ms/mh4oCOLU=;
	b=pSKnIIRrJfivCZvIXcKdID+sJ9kXK1o5uDX03eZYADPLarO8FnLb8xe4v6MK4h
	89uqYLQCxplWeb8U0C0VgoDQlEFpkIIXo/Uxj5UA0iH0VmYGi+c4GViDRnSG+K3N
	RX5EBixm9sKDT+3BTbC/yH8k6jnna8dKmC9tBNJpD/xXU=
Received: from [172.22.5.12] (unknown [27.148.194.72])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDX_ywoLlhm6cdhBQ--.18191S2;
	Thu, 30 May 2024 15:43:37 +0800 (CST)
Message-ID: <2a78f16a-0ff5-46bf-983b-9ab038f5a5cd@163.com>
Date: Thu, 30 May 2024 15:43:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev <netdev@vger.kernel.org>
Cc: contact@proelbtn.com, pablo@netfilter.org,
 David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH net-next] seg6: fix parameter passing when calling NF_HOOK()
 in End.DX4 and End.DX6 behaviors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDX_ywoLlhm6cdhBQ--.18191S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWrGr1kKw4fXF1xCry7Awb_yoW5Kr1DpF
	15Cw1q9FWrGF1xtr4FvF4DZrW5uw4F9FnxCrn5C34Yv390qr1vyrs2yF45Wr1UJrs3CFWY
	qasFgr4xKwn8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnDG5UUUUU=
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiRBrtkGVOC-FRGQACs4

From: Jianguo Wu <wujianguo@chinatelecom.cn>

input_action_end_dx4() and input_action_end_dx6() call NF_HOOK() for PREROUTING hook,
for PREROUTING hook, we should passing a valid indev, and a NULL outdev to NF_HOOK(),
otherwise may trigger a NULL pointer dereference, as below:

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

input_action_end_dx4() passing a NULL indev to NF_HOOK(), and finally trigger a
NULL dereference in rpfilter_mt()->rpfilter_is_loopback():
    static bool
    rpfilter_is_loopback(const struct sk_buff *skb, const struct net_device *in)
    {
            // in is NULL
            return skb->pkt_type == PACKET_LOOPBACK || in->flags & IFF_LOOPBACK;
    }

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")

Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
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


