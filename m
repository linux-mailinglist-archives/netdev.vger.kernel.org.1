Return-Path: <netdev+bounces-148031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCD9DFE14
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01131B24EB2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9181FAC53;
	Mon,  2 Dec 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7+1yoon"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949215A8
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133972; cv=none; b=MvfIJ1XFEYSCnMCP2Kf1VQp2fnaadziRkzwD9QL1+fi/4HlFjrUQvtd2qe2L5xymwDQYLsKkNH1YkYG+85S1petfxs1gYG8q1tam4whjHp7cGQshCaJa2OFZ5uzJAZcdoiwnzQVcWtNUcpwuNrXgvzwvFAvNblMmie4ivFlKk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133972; c=relaxed/simple;
	bh=5nOZPBD3Vx6GHl5n97MHFDY351/MKlKGxJqQBuoNtj0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VuOQigWSUYFu+1KxmrXL8lPWpR17pvRH2ov7A8lEvB4V31Lu7C7O5CMwkXbmxMvKe47oPbx+vU4DPGR61o9EMD0TNlX/emoM+bRFXxCaIC2KU+n4zRzfQu0Gv+/jUBdcrz+P9sUJG7YaH9Ux1ss9hpavKGcAF/ig3E+y0eZed58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7+1yoon; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-466c542d9aaso59382761cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 02:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733133969; x=1733738769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywCclidRWeClV2kj/avDCF7N2hGmTl8/CdlDjCBNeoE=;
        b=i7+1yoonAS2RNuOJhI9891skOIBZwyBbaBNIBihNc6Q9PJhwEhVk1iTZFR0CpfjWew
         dqCX4r3JuBPqTmV7ooH3fDS5ke49bpZscK08TXOJU0121WPHZeG4eRzBb7qwX6r3gBqK
         rLKClN0UEM1jI+V1PeOmt913BbmcOhvhS//tVq6JISNMiIPCxBjwy746QCoEf1Hmad19
         GaHo153vUePAXPu3X9SEoABxiv5aq7CGgTch1hWGgYkl4HKwc8gPkLDrS3di2S0SxILU
         DSQj5WFoYpso/vejft6MnvvQ1brRFUD+uvh/ksY01wsSqdf8nwenDtgeZECluIpX2no6
         wjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133969; x=1733738769;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywCclidRWeClV2kj/avDCF7N2hGmTl8/CdlDjCBNeoE=;
        b=fAi56+nkr+4XDhkmiRO2//LJWK5acKbw2UQvg8oIKCLxthfuKJdUW2EDHkD9r/7yAm
         M243mOIZ7O+ZWNmQBswYevex8Tzfg5HY/d1anhAOX8mxoEoTMxSnkQLhMFDSxWY/28AX
         EboU7GXTjW4yTa3BIdHbZt8LNCkJVRZceBGSdwkCQv5mvxunb5ZYk3nmBrYawH0qARy3
         0Yyhvkohyi8CY8femgSvvhrqeXu2WQabKI8WaPgEeR0/c1tp9MitF5ZvX5YRZ5+eaTlk
         jgTso31tihHDpv23pB5G7SBBLY4WeJND9AYmNuijUtbKNHhBYi+Jz010on9Au3UigOkz
         ooYw==
X-Gm-Message-State: AOJu0Ywg29NXB754jYjo0q+kMvejZt2pHqYVVEhWRghyziAeh1sEBHU5
	Sqi06NXUm+0eayftUd+1Mrn8/e1x8h3mMk0UEiN5b9d4EJ9NQEKPGbB46eYyEb3DAsaY+2d7Ofw
	MmykWvMoi+w==
X-Google-Smtp-Source: AGHT+IGa6x0y8rqRnEsT1432NdPOacZWVkOrXrN/ytOB+A7QpSHA4NTDOiVEsv4JX2RrlExiK+DcbnPsCNKHvw==
X-Received: from qtbbb39.prod.google.com ([2002:a05:622a:1b27:b0:466:9a35:77a4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:594e:0:b0:461:161b:c178 with SMTP id d75a77b69052e-466b34de30amr370347551cf.13.1733133969480;
 Mon, 02 Dec 2024 02:06:09 -0800 (PST)
Date: Mon,  2 Dec 2024 10:05:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202100558.507765-1-edumazet@google.com>
Subject: [PATCH net] net: hsr: must allocate more bytes for RedBox support
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+7f4643b267cc680bfa1c@syzkaller.appspotmail.com, 
	Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"

Blamed commit forgot to change hsr_init_skb() to allocate
larger skb for RedBox case.

Indeed, send_hsr_supervision_frame() will add
two additional components (struct hsr_sup_tlv
and struct hsr_sup_payload)

syzbot reported the following crash:
skbuff: skb_over_panic: text:ffffffff8afd4b0a len:34 put:6 head:ffff88802ad29e00 data:ffff88802ad29f22 tail:0x144 end:0x140 dev:gretap0
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 7611 Comm: syz-executor Not tainted 6.12.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:skb_panic+0x157/0x1d0 net/core/skbuff.c:206
Code: b6 04 01 84 c0 74 04 3c 03 7e 21 8b 4b 70 41 56 45 89 e8 48 c7 c7 a0 7d 9b 8c 41 57 56 48 89 ee 52 4c 89 e2 e8 9a 76 79 f8 90 <0f> 0b 4c 89 4c 24 10 48 89 54 24 08 48 89 34 24 e8 94 76 fb f8 4c
RSP: 0018:ffffc90000858ab8 EFLAGS: 00010282
RAX: 0000000000000087 RBX: ffff8880598c08c0 RCX: ffffffff816d3e69
RDX: 0000000000000000 RSI: ffffffff816de786 RDI: 0000000000000005
RBP: ffffffff8c9b91c0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000302 R11: ffffffff961cc1d0 R12: ffffffff8afd4b0a
R13: 0000000000000006 R14: ffff88804b938130 R15: 0000000000000140
FS:  000055558a3d6500(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1295974ff8 CR3: 000000002ab6e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
  skb_over_panic net/core/skbuff.c:211 [inline]
  skb_put+0x174/0x1b0 net/core/skbuff.c:2617
  send_hsr_supervision_frame+0x6fa/0x9e0 net/hsr/hsr_device.c:342
  hsr_proxy_announce+0x1a3/0x4a0 net/hsr/hsr_device.c:436
  call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1794
  expire_timers kernel/time/timer.c:1845 [inline]
  __run_timers+0x6e8/0x930 kernel/time/timer.c:2419
  __run_timer_base kernel/time/timer.c:2430 [inline]
  __run_timer_base kernel/time/timer.c:2423 [inline]
  run_timer_base+0x111/0x190 kernel/time/timer.c:2439
  run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2449
  handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu kernel/softirq.c:637 [inline]
  irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
  sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Reported-by: syzbot+7f4643b267cc680bfa1c@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_device.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 31a416ee21ad904f68c9f1c99110153b9236ab07..03eadd6c51fd1f80f8c2fd0889625d5da79d11f6 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -246,20 +246,22 @@ static const struct header_ops hsr_header_ops = {
 	.parse	 = eth_header_parse,
 };
 
-static struct sk_buff *hsr_init_skb(struct hsr_port *master)
+static struct sk_buff *hsr_init_skb(struct hsr_port *master, int extra)
 {
 	struct hsr_priv *hsr = master->hsr;
 	struct sk_buff *skb;
 	int hlen, tlen;
+	int len;
 
 	hlen = LL_RESERVED_SPACE(master->dev);
 	tlen = master->dev->needed_tailroom;
+	len = sizeof(struct hsr_sup_tag) + sizeof(struct hsr_sup_payload);
 	/* skb size is same for PRP/HSR frames, only difference
 	 * being, for PRP it is a trailer and for HSR it is a
-	 * header
+	 * header.
+	 * RedBox might use @extra more bytes.
 	 */
-	skb = dev_alloc_skb(sizeof(struct hsr_sup_tag) +
-			    sizeof(struct hsr_sup_payload) + hlen + tlen);
+	skb = dev_alloc_skb(len + extra + hlen + tlen);
 
 	if (!skb)
 		return skb;
@@ -295,6 +297,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 	struct hsr_sup_tlv *hsr_stlv;
 	struct hsr_sup_tag *hsr_stag;
 	struct sk_buff *skb;
+	int extra = 0;
 
 	*interval = msecs_to_jiffies(HSR_LIFE_CHECK_INTERVAL);
 	if (hsr->announce_count < 3 && hsr->prot_version == 0) {
@@ -303,7 +306,11 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		hsr->announce_count++;
 	}
 
-	skb = hsr_init_skb(port);
+	if (hsr->redbox)
+		extra = sizeof(struct hsr_sup_tlv) +
+			sizeof(struct hsr_sup_payload);
+
+	skb = hsr_init_skb(port, extra);
 	if (!skb) {
 		netdev_warn_once(port->dev, "HSR: Could not send supervision frame\n");
 		return;
@@ -362,7 +369,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	struct hsr_sup_tag *hsr_stag;
 	struct sk_buff *skb;
 
-	skb = hsr_init_skb(master);
+	skb = hsr_init_skb(master, 0);
 	if (!skb) {
 		netdev_warn_once(master->dev, "PRP: Could not send supervision frame\n");
 		return;
-- 
2.47.0.338.g60cca15819-goog


