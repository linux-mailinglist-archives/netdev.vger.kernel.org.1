Return-Path: <netdev+bounces-303900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VXfoAvWnRWonDgsAu9opvQ
	(envelope-from <netdev+bounces-303900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:51:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB986F27C0
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:51:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=qVZCkBiY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303900-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303900-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC0E03002A23
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 23:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D66356759;
	Wed,  1 Jul 2026 23:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41976347514
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 23:50:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949827; cv=none; b=LWa4l0CXXX2ta6NFQJ8cALTC34W+AOraIHCLFt1GaXuDQ4cga8nPTyPfGzc5eOcOfDLRfBfLrp60zj/+3GGdkcpPAtmrE69z/5RLjR47pr7llMzRF3qoiWFZIk7hPruaGHhnjyjWQVDysnDJd2R34svZtTaICpwZRi1bagGqlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949827; c=relaxed/simple;
	bh=5886wVrZkREo7AeMbbusDaBWMEfw794FAd1FKB0Ls/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PDeJa49JfvyCAuetRxZnzK804NmWsWAaSyCzyUG81Ralrdm81xCecclZrJ7yOisYh4UcbR5tmh7zHrhSVBV22gZoBZn6czBZ10ohJd/q7KtxVmoiiiG3rvpy66mYjMw4SkVxGLBBAQHQJzzvDDbqADUQj16zZekpzQgVV47Q8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVZCkBiY; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a2509456so1476834b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782949825; x=1783554625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xSi6QIt8CogOxeoVQBNr0dLIQQY+Wwg6VCKy7bdtrbw=;
        b=qVZCkBiY6w6gZ9+L7tDQKbLM7U0F+oMxo5FIi37zOhsViNmU8QNWIQhKBXsW92jsK7
         GXA8mdXIAAPoQ2uB8NPcZzJfhNiqnc6Ueq/hEZTZAlzCcvLreenfN/94bug2gDhGKQuD
         glktFhykUFl5qUFZ8wRyzf7l5ygdmTRQqUITW1jPwH7ddNHbaYlkrpgJAxWAE1S1Xcyl
         iPgv+ZOkjZBgcXA2QI32aY9MBG9+jkSHW/MM//Yj4WYu985FMFxX0B/oAmMjRclCqL0E
         /87ZpkOvXMZyynqJgGdveVam+yrISyVN/AuAy7AiEL2PPkTz+j0IAIwkbPwlZhmxc+FO
         CtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782949825; x=1783554625;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSi6QIt8CogOxeoVQBNr0dLIQQY+Wwg6VCKy7bdtrbw=;
        b=XfeCc1rg2BiiYCMbgsi308WUDizxJBeNO6IKV1UjyIsYNDHMx8T4Y1e0j7X0uXaJgm
         fBAVJU42O0pNlzfevUPW7GkD4jqnPdodqZ0iVPoiWxBcEp2jmlVO3rrAd0EqH5o32dGP
         QzjuW8RglmSCKN7xcKLkIUp61GC95YWXpsMQR8pDAR8jlL3J0VWP0D6bE9+26JDCtkvl
         aE3FrDDdXn0ozoOc5BtHpdc34Wtxhw4hRhHxtdIDIgaN3WyhSmB5oXwAfVbDxIqEAoxK
         AvBpMeQAspisXSt8RS05jc3MZoiqaIj3OBuZaGtObl9fTJzt+K9Rn3FiJgK87g/QemV4
         qQgg==
X-Forwarded-Encrypted: i=1; AFNElJ9sM3xkgq/N8O/xlDmZ7XhwQ+LSfiS5ewZftvBIvwcfRsVx12dbpLEhFzPn//nWjEMDZ6gX37g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7POpBu2kqjQlO7TfTpWYrhOE6MG6TOwVbbgSUxCuSPK7HIPQh
	JXuHkMAPpjvNq8rW+GwA8wWKQgEN6tEMJ1PVAL+V3PPY1wBy0E2QvijWKSPz0JrYhg/3ydO5eL4
	gWX0fj72ufvCLcw3wnVTux/SFIg==
X-Received: from pfbho12.prod.google.com ([2002:a05:6a00:880c:b0:847:8ffb:40ad])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1388:b0:847:8f34:cb00 with SMTP id d2e1a72fcca58-847c095110cmr4024562b3a.51.1782949825262;
 Wed, 01 Jul 2026 16:50:25 -0700 (PDT)
Date: Thu,  2 Jul 2026 08:50:14 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701235014.73505-1-yuyanghuang@google.com>
Subject: [PATCH net v3] ipv4: igmp: remove multicast group from hash table on
 device destruction
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Cong Wang <xiyou.wangcong@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-303900-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sea.lore.kernel.org:server fail];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,google.com,nvidia.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BB986F27C0

When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
the multicast list and calls ip_ma_put() on each membership, scheduling
them for RCU reclamation. However, they are not unlinked from the device's
multicast hash table (mc_hash).

Since the device remains published in dev->ip_ptr until after
ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
can still locate and access the multicast group after its refcount is
decremented. If the RCU callback runs and frees the group while a reader is
accessing it, a use-after-free occurs.

Fix this by unlinking the multicast group from mc_hash using
ip_mc_hash_remove() before scheduling it for reclamation.

BUG: KASAN: slab-use-after-free in ip_check_mc_rcu+0x149/0x3f0
Read of size 4 at addr ffff888009bf1408 by task mausezahn/2276

Call Trace:
 <IRQ>
 dump_stack_lvl+0x67/0x90
 print_report+0x175/0x7c0
 kasan_report+0x147/0x180
 ip_check_mc_rcu+0x149/0x3f0
 udp_v4_early_demux+0x36d/0x12d0
 ip_rcv_finish_core+0xb8b/0x1390
 ip_rcv_finish+0x54/0x120
 NF_HOOK+0x213/0x2b0
 __netif_receive_skb+0x126/0x340
 process_backlog+0x4f2/0xf00
 __napi_poll+0x92/0x2c0
 net_rx_action+0x583/0xc60
 handle_softirqs+0x236/0x7f0
 do_softirq+0x57/0x80
 </IRQ>

Allocated by task 2239:
 kasan_save_track+0x3e/0x80
 __kasan_kmalloc+0x72/0x90
 ____ip_mc_inc_group+0x31a/0xa40
 __ip_mc_join_group+0x334/0x3f0
 do_ip_setsockopt+0x16fa/0x2010
 ip_setsockopt+0x3f/0x90
 do_sock_setsockopt+0x1ad/0x300

Freed by task 0:
 kasan_save_track+0x3e/0x80
 kasan_save_free_info+0x40/0x50
 __kasan_slab_free+0x3a/0x60
 __rcu_free_sheaf_prepare+0xd4/0x220
 rcu_free_sheaf+0x36/0x190
 rcu_core+0x8d9/0x12f0
 handle_softirqs+0x236/0x7f0

Fixes: e9897071350b ("igmp: hash a hash table to speedup ip_check_mc_rcu()")
Cc: stable@vger.kernel.org
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
v3:
  - Target 'net' instead of 'net-next'.
  - Add the KASAN Use-After-Free traceback to the commit message.
v2:
  - Add Fixes tag in the commit message.

 net/ipv4/igmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b6337a47c141..d520ea4f6d14 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1922,6 +1922,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
 #endif
 
 	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
+		ip_mc_hash_remove(in_dev, i);
 		in_dev->mc_list = i->next_rcu;
 		WRITE_ONCE(in_dev->mc_count, in_dev->mc_count - 1);
 		ip_mc_clear_src(i);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


