Return-Path: <netdev+bounces-15983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C387F74AC8F
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3576F281606
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE78477;
	Fri,  7 Jul 2023 08:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492D6FA3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:11:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26531BD2
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688717500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9ihG9pFICLSI2SUXNAIanwWCC2O8soSQsd3qF4Hi6Y0=;
	b=eP3qOrA0pUb6V6KgYdylbl1Wkt1rLHLsMHh2rM+VsEQ5SeF04I2o5P4+SNtUH1qVqZ6QHY
	QWmHD8dyRWMz8KMBa/UqJKvRqVH5TTD3MsaVW6tEzEP5f9uJ31VPI8yCZJu3gv4QLzOmyo
	L+4ADqyXW2tA2i6FXuFrlQKASl6cc3o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-8A4xoJviNtSrHgaZ7VUA1Q-1; Fri, 07 Jul 2023 04:11:33 -0400
X-MC-Unique: 8A4xoJviNtSrHgaZ7VUA1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57F313C025AD;
	Fri,  7 Jul 2023 08:11:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2D07F6401;
	Fri,  7 Jul 2023 08:11:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH net] net: prevent skb corruption on frag list segmentation
Date: Fri,  7 Jul 2023 10:11:10 +0200
Message-ID: <ecbccca7b88acfd07164623c40f93cf0842645d3.1688716558.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ian reported several skb corruptions triggered by rx-gro-list,
collecting different oops alike:

[   62.624003] BUG: kernel NULL pointer dereference, address: 00000000000000c0
[   62.631083] #PF: supervisor read access in kernel mode
[   62.636312] #PF: error_code(0x0000) - not-present page
[   62.641541] PGD 0 P4D 0
[   62.644174] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   62.648629] CPU: 1 PID: 913 Comm: napi/eno2-79 Not tainted 6.4.0 #364
[   62.655162] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F, BIOS 1.7a 10/13/2022
[   62.663344] RIP: 0010:__udp_gso_segment (./include/linux/skbuff.h:2858
./include/linux/udp.h:23 net/ipv4/udp_offload.c:228 net/ipv4/udp_offload.c:261
net/ipv4/udp_offload.c:277)
[   62.687193] RSP: 0018:ffffbd3a83b4f868 EFLAGS: 00010246
[   62.692515] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 0000000000000000
[   62.699743] RDX: ffffa124def8a000 RSI: 0000000000000079 RDI: ffffa125952a14d4
[   62.706970] RBP: ffffa124def8a000 R08: 0000000000000022 R09: 00002000001558c9
[   62.714199] R10: 0000000000000000 R11: 00000000be554639 R12: 00000000000000e2
[   62.721426] R13: ffffa125952a1400 R14: ffffa125952a1400 R15: 00002000001558c9
[   62.728654] FS:  0000000000000000(0000) GS:ffffa127efa40000(0000)
knlGS:0000000000000000
[   62.736852] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.742702] CR2: 00000000000000c0 CR3: 00000001034b0000 CR4: 00000000003526e0
[   62.749948] Call Trace:
[   62.752498]  <TASK>
[   62.779267] inet_gso_segment (net/ipv4/af_inet.c:1398)
[   62.787605] skb_mac_gso_segment (net/core/gro.c:141)
[   62.791906] __skb_gso_segment (net/core/dev.c:3403 (discriminator 2))
[   62.800492] validate_xmit_skb (./include/linux/netdevice.h:4862
net/core/dev.c:3659)
[   62.804695] validate_xmit_skb_list (net/core/dev.c:3710)
[   62.809158] sch_direct_xmit (net/sched/sch_generic.c:330)
[   62.813198] __dev_queue_xmit (net/core/dev.c:3805 net/core/dev.c:4210)
net/netfilter/core.c:626)
[   62.821093] br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
[   62.825652] maybe_deliver (net/bridge/br_forward.c:193)
[   62.829420] br_flood (net/bridge/br_forward.c:233)
[   62.832758] br_handle_frame_finish (net/bridge/br_input.c:215)
[   62.837403] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[   62.851417] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[   62.866114] __netif_receive_skb_list_core (net/core/dev.c:5570)
[   62.871367] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[   62.876795] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[   62.881004] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3191)
[   62.893534] __napi_poll (net/core/dev.c:6498)
[   62.897133] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[   62.905276] kthread (kernel/kthread.c:379)
[   62.913435] ret_from_fork (arch/x86/entry/entry_64.S:314)
[   62.917119]  </TASK>

In the critical scenario, rx-gro-list GRO-ed packets are fed, via a
bridge, both to the local input path and to an egress device (tun).

The segmentation of such packets unsafely writes to the cloned skbs
with shared heads.

This change addresses the issue by uncloning as needed the
to-be-segmented skbs.

Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
Tested-by: Ian Kumlien <ian.kumlien@gmail.com>
Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6c5915efbc17..a298992060e6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4261,6 +4261,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 
 	skb_push(skb, -skb_network_offset(skb) + offset);
 
+	/* Ensure the head is writeable before touching the shared info */
+	err = skb_unclone(skb, GFP_ATOMIC);
+	if (err)
+		goto err_linearize;
+
 	skb_shinfo(skb)->frag_list = NULL;
 
 	while (list_skb) {
-- 
2.41.0


