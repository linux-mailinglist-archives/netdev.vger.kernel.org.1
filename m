Return-Path: <netdev+bounces-154552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711439FE910
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4CD18815A0
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065E1AAA2C;
	Mon, 30 Dec 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbfd4Fqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393E19ABA3
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735576134; cv=none; b=foK0Tjp0AqIJ1SH4vIXY6mpVXdD+pZKEIOx9wEZ6e4RFTtbbH+IwulK9ITKkoiTMfzdvUPtETCkyqQzSRiCdW/2R3L/vGoDaO4kHlDbp3JfmYzQrLeIlyZtbZYeaMfcMcOo6w5AktYRTZ8Pi28/Jpp5/7e7qOPtgY6v3jw0KY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735576134; c=relaxed/simple;
	bh=tKOHkS+JeSwxVQpbZMIZbFPi8ta8tIhy/sfCTXanF4g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vEOZoSg3126TyQxp6BkTRRjemucRq5QN3F+BMP6f5LYXXnZR2Ou+h6LtX5LV5LLpNnyRDQuRzP3DrOtxIZ7sgpnsJWXVC24PAJbHB+eGBBo2PJY6Ad26iv2uAHO2RBUfOEv3oFm6Y73xyyrIR+BWjd5K8iauHnO6r6aWsBH1MZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbfd4Fqw; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-468f6f2f57aso120211021cf.0
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735576131; x=1736180931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fu7PdWMoO6J7wpLVfMyYrq3wWi14PwgUBdokzlbG+A=;
        b=cbfd4FqwTL6lFwKGG6vaK1O3d/9HjZgEPXho4+bhHHJhoiPogn5Iavciu1iwhgGDts
         WIZa5qOlDLO1Ime/VqBvyGNUOluQlAkelyURA4hSkXcQmD74zbO6yFpLYf3MtQNogfzf
         vauritKBzxc0NxLxNJ/iKREVqgQut/mwWvlkp58tS0p/FTR6YHKzQ1yW8b1ll/NlGM6T
         fzQCwZqL+bLKLVNDDEFo6BX0vFnUKat0vgn8oR/zg3r8U4MDRsjVaImAmXJAkDPXURSe
         +YBmpfgUB08tbwtTC8gPp2Qirv0CjQam/i8gSfb6l98PHpIOTeGRZntfGwfdUSlwO43W
         HDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735576131; x=1736180931;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fu7PdWMoO6J7wpLVfMyYrq3wWi14PwgUBdokzlbG+A=;
        b=M1Y7IsrdkDND4iyRggvSGxaRcw7H1gpvpVJ8x3L8jrxIIuYV+oWap9qJQ55dRCPTSn
         51Z3y7iw35/520X+9gZHtzCZ1ws67PTddD4L6j1yOC0mj4Cr0cdzLiTrhEHNj4iuzVKH
         Y9r4hvfDT2fZyiLffFe6anfj3QA/H2KuHgrZIhDvD1uZ5o0eP7FxGPpx8dUNiYyRbRti
         z0btvZ3ixgVn++QACBy8wsFUDzYcBu51obWP5+qR2FFXKYnL19djgUPoMOxTXMmxvn/2
         WwgN+QdGEYxlkEcMUApgocntiPWHJS8Aq1rm67YXxcdqrQWJThK4pZo861+TKcV9rvS2
         1xqg==
X-Gm-Message-State: AOJu0YyO/3q3HkkMB1JyGCgqyGJccg9aI0mc1Ff36QON4ufvOrXvDuTn
	C65axxMXWl/Rt3kRU4/Da8HAZvfeNYL7Ard4dYtoz+fBojDka9lvbZsU2/fqjkO7TFiUWdH2sJq
	sITjb9dvg7g==
X-Google-Smtp-Source: AGHT+IG4deDuPdkBWkzVVj3ZKljAavSNFECLxZimITjTDb6SVXOl2AvFSX4Q0I3tIfzWPsCT1qpc4i7kW6Z1HA==
X-Received: from qtbfa15.prod.google.com ([2002:a05:622a:4ccf:b0:466:9f81:8c8c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7e87:0:b0:467:86fa:6b72 with SMTP id d75a77b69052e-46a4a8cc553mr518231161cf.12.1735576131398;
 Mon, 30 Dec 2024 08:28:51 -0800 (PST)
Date: Mon, 30 Dec 2024 16:28:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241230162849.2795486-1-edumazet@google.com>
Subject: [PATCH net] ila: serialize calls to nf_register_net_hooks()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+47e761d22ecf745f72b9@syzkaller.appspotmail.com, 
	Florian Westphal <fw@strlen.de>, Tom Herbert <tom@herbertland.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found a race in ila_add_mapping() [1]

commit 031ae72825ce ("ila: call nf_unregister_net_hooks() sooner")
attempted to fix a similar issue.

Looking at the syzbot repro, we have concurrent ILA_CMD_ADD commands.

Add a mutex to make sure at most one thread is calling nf_register_net_hooks().

[1]
 BUG: KASAN: slab-use-after-free in rht_key_hashfn include/linux/rhashtable.h:159 [inline]
 BUG: KASAN: slab-use-after-free in __rhashtable_lookup.constprop.0+0x426/0x550 include/linux/rhashtable.h:604
Read of size 4 at addr ffff888028f40008 by task dhcpcd/5501

CPU: 1 UID: 0 PID: 5501 Comm: dhcpcd Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <IRQ>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:378 [inline]
  print_report+0xc3/0x620 mm/kasan/report.c:489
  kasan_report+0xd9/0x110 mm/kasan/report.c:602
  rht_key_hashfn include/linux/rhashtable.h:159 [inline]
  __rhashtable_lookup.constprop.0+0x426/0x550 include/linux/rhashtable.h:604
  rhashtable_lookup include/linux/rhashtable.h:646 [inline]
  rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
  ila_lookup_wildcards net/ipv6/ila/ila_xlat.c:127 [inline]
  ila_xlat_addr net/ipv6/ila/ila_xlat.c:652 [inline]
  ila_nf_input+0x1ee/0x620 net/ipv6/ila/ila_xlat.c:185
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xbb/0x200 net/netfilter/core.c:626
  nf_hook.constprop.0+0x42e/0x750 include/linux/netfilter.h:269
  NF_HOOK include/linux/netfilter.h:312 [inline]
  ipv6_rcv+0xa4/0x680 net/ipv6/ip6_input.c:309
  __netif_receive_skb_one_core+0x12e/0x1e0 net/core/dev.c:5672
  __netif_receive_skb+0x1d/0x160 net/core/dev.c:5785
  process_backlog+0x443/0x15f0 net/core/dev.c:6117
  __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6883
  napi_poll net/core/dev.c:6952 [inline]
  net_rx_action+0xa94/0x1010 net/core/dev.c:7074
  handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
  __do_softirq kernel/softirq.c:595 [inline]
  invoke_softirq kernel/softirq.c:435 [inline]
  __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
  sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049

Fixes: 7f00feaf1076 ("ila: Add generic ILA translation facility")
Reported-by: syzbot+47e761d22ecf745f72b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6772c9ae.050a0220.2f3838.04c7.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Tom Herbert <tom@herbertland.com>
---
 net/ipv6/ila/ila_xlat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 7646e401c630439c972b35a621cb9311fec19bec..1d41b2ab48846ca77623bb0c18b113cbe95a4440 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -195,6 +195,8 @@ static const struct nf_hook_ops ila_nf_hook_ops[] = {
 	},
 };
 
+static DEFINE_MUTEX(ila_mutex);
+
 static int ila_add_mapping(struct net *net, struct ila_xlat_params *xp)
 {
 	struct ila_net *ilan = net_generic(net, ila_net_id);
@@ -202,16 +204,20 @@ static int ila_add_mapping(struct net *net, struct ila_xlat_params *xp)
 	spinlock_t *lock = ila_get_lock(ilan, xp->ip.locator_match);
 	int err = 0, order;
 
-	if (!ilan->xlat.hooks_registered) {
+	if (!READ_ONCE(ilan->xlat.hooks_registered)) {
 		/* We defer registering net hooks in the namespace until the
 		 * first mapping is added.
 		 */
-		err = nf_register_net_hooks(net, ila_nf_hook_ops,
-					    ARRAY_SIZE(ila_nf_hook_ops));
+		mutex_lock(&ila_mutex);
+		if (!ilan->xlat.hooks_registered) {
+			err = nf_register_net_hooks(net, ila_nf_hook_ops,
+						ARRAY_SIZE(ila_nf_hook_ops));
+			if (!err)
+				WRITE_ONCE(ilan->xlat.hooks_registered, true);
+		}
+		mutex_unlock(&ila_mutex);
 		if (err)
 			return err;
-
-		ilan->xlat.hooks_registered = true;
 	}
 
 	ila = kzalloc(sizeof(*ila), GFP_KERNEL);
-- 
2.47.1.613.gc27f4b7a9f-goog


