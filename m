Return-Path: <netdev+bounces-281586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Bx7EbgT8GnXOAEAu9opvQ
	(envelope-from <netdev+bounces-281586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:56:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB247C8CD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4220D303FDD0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F22E719B;
	Tue, 28 Apr 2026 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwWWmicU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DE2DB780
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341327; cv=none; b=u7/Z2QCs1JG+V7hP5djE245cY/MXnPZAFWG1dw+7S1lPEDjlNOsSFxXOnBy78dwNQF+AC18zGTo/g21v/Nhc9a8205zBhMGFp8oa9Y6JGubexKKaBqCBpUwwNoLVRV7vYO9Tla6Xbku7NTFui6A+OCnc7bhh+/yjgcFKLthViiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341327; c=relaxed/simple;
	bh=pV74rYbo4PSnOntrueYInbZC2uJly5cb2kmGtmKzl6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAx9+SG7WLYewNypcz1yI2yGks/TbBNmrf/ea/v+CqbMhmtx6I22+ae4LqY8J2p7Xw4RtvH/n6v9d/+4AyEnzDOsXcWgmZf4oNVnZ2p1pktErPtBzWe66m0gVhBcgemUWnBChLVHECmCCtHuPoICZfevanYi0YYmiqXHlZF9oRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwWWmicU; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso11037610eec.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777341326; x=1777946126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+7z2IOdn6pmZUm+ZpjK+hZD0XE6Xe2S5mjthipPTXY=;
        b=WwWWmicUwys5z2BOATb5HbsxIjU4+n++1V1B92iGfVOBkzawckPKXEydd/DW6oYwK4
         col/I9Wbs32Z9vFsLtZ9Qp3i+QZmyiWnFZ05MqVjjVnR47f1mvMoIXqNRiEzpcjEhVs2
         Kh+oTHvOA/x2aX0Lru1Wrk0pb0rADgOyKV65cs5hpojafz5mJwg1QfKIbCLj2jvtD8FP
         FwfF/GtH/f8bnf3AloESrkjTIk2n0yS2Ahq2m/NouMaKh64fRDtv3CmywxO/U1ewi+kt
         Btgx62FxHwCzjQKuMdZCc8TH4zxhjvexjSSvauhOzAWCHXbBIavNxeVvPoESptUOxdwK
         tUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777341326; x=1777946126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+7z2IOdn6pmZUm+ZpjK+hZD0XE6Xe2S5mjthipPTXY=;
        b=revIsCr2iCF4Qq3YotavDzqSGqBrwVJH+HQhqlkHtttOcVd/P/HehiJ3RLrXYXmjqS
         L9ypVKmMvbOr8+8w3gARNMpf1PxWgvlkGVp7fG+dhYK/xxME6145hMl1CksgclsFjNPc
         8Wd2j61s7fyvYWQrM/BXDD4lOFbUjAtuhoUlby/2uiMPoaYn4drAD4e8QVo/mOnAfatO
         bzCTHl2uVjOzYOrZQZMocMitZQusxxMgBoZ6bL+UWcDWJn2sPMi7uwmCptJ+bKKc8pJJ
         iLgKjTW4s7tHA3cOaQJEZP0LcJqvtgmWATFQZ7ClrdQTvenGkpbkCAgEjei9cWhIZ1vB
         th/w==
X-Forwarded-Encrypted: i=1; AFNElJ/vJQmoXOpmfLhWAAtJ0QWjSFrQc5bhadMvL1rUs00GE1LWRkNppNljgH0Xggpn3XgZn2b8mR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3o0KeARBJSAXMai1XcYLj09AaLtyqpUI2NVXeRw3ycHaqQf0/
	PiRwX77/pcNMypUTRan03nMQ2TU4quE7sE08gpugd5GezsHk1E1orQQQ
X-Gm-Gg: AeBDiesdRj2b0rTYw3lvzTIo5H57Anf1+gR8Uv1DJRzYBjyq0hS/lh5OrYzDjWWxXq7
	sCBwqcKi0Zm7WryHIyX1o8ZEZdRaQWFBtFors9eSImofdvkHSHSsyUJ6o3TS371Kz8u01dP2RA3
	xeCe/8DqHU1mgVqXA1L3DWfBHHk41qCjE97oTdxT8+CDSoKUMeTxDu2ooQSt1qwMleHCQ6fMG06
	XSHLGdAdnjbhydFBCieLBlsGCd1JE96Nq9ZoxA4GJ8EkD/nK6KUeEYJRr2a4kQNCueCncryk4Ku
	y7gbgErQbQAVHKgeqnfSKQ6X7OgJ24TYiW1o5x0Z5aA1OC82HO74dJsCV0jsQDX8lSr9hY8A7Fr
	rX3+ucg+OPJJ/s1ETcvY5KEG5+X8/VxABBIR4QA+NJWdjyWEiExRrpWrwP9ngO29IXtseqIfHJ2
	giGoma+oHzuXHn71nSSESsmYs5GOC/X+yhPXUqoKU9cE0IjjZIOVtzUS9FKraUlRxukV77ybgyz
	ZccR3Kuyak5u2dchIhYpkJ1uk6YwX2RTi5ERgJ2acu4HA8AZRsXMQPnypLbn/iHRAlWGMDHrRAo
	N8xlEVay0loKo1tjrn46EZyrk0AzhHahNmdjuF8=
X-Received: by 2002:a05:7300:3b06:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-2ed09fde4b5mr587329eec.5.1777341325650;
        Mon, 27 Apr 2026 18:55:25 -0700 (PDT)
Received: from appmana-001.i.appmana.com (23-93-84-4.dedicated.static.sonic.net. [23.93.84.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09f8a909sm1233947eec.4.2026.04.27.18.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:55:24 -0700 (PDT)
From: Benjamin Berman <benjamin.s.berman@gmail.com>
To: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thunderbolt: drop start_poll guard in tb_ring_poll_complete()
Date: Mon, 27 Apr 2026 18:55:20 -0700
Message-ID: <20260428015521.3454006-2-benjamin.s.berman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
References: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0EB247C8CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281586-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[benjaminsberman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anthropic.com:email]

Under concurrent load on a single NHI with several rings simultaneously
in NAPI poll (e.g. a Maple Ridge TB4 transit forwarding tbnet traffic
between two peers), one ring's interrupt enable bit in
REG_RING_INTERRUPT_BASE can stay cleared.  MSI-X stops for that ring,
NAPI is never rescheduled, but carrier is reported up and no driver
event fires.  The ring stays masked until thunderbolt_net is reloaded.

tb_ring_poll_complete() gated the unmask on @start_poll:

	if (ring->start_poll)
		__ring_interrupt_mask(ring, false);

while the ISR path masks unconditionally via __ring_interrupt().  In a
window where @start_poll is observed as NULL by the unmask path while
the paired mask persists, the ring is left permanently masked.

Gate on @running instead and add an ioread32() barrier so the posted
enable reaches the device before the spinlock is dropped.

On NHIs without QUIRK_AUTO_CLEAR_INT a second issue compounds the
first: stale pending status in REG_RING_NOTIFY_BASE can prevent the
hardware from re-arming its MSI-X generator when the ring is
re-enabled.  Clear the ring's bit in REG_RING_INT_CLEAR before setting
the enable bit, mirroring what ring_msix() already does at ISR entry.

Verified on a Maple Ridge 4C transit and two TB3 Titan Ridge endpoints
running NCCL all-reduce over tb-lo: pre-patch the chain wedges in
under 1 GB; post-patch a 192 GB run (3000 iterations of a 64 MiB
all-reduce) completes with mask/unmask counters balanced.

Generated-by: Claude Opus 4.7 <claude-opus-4-7@anthropic.com>
Tested-by: Benjamin Berman <benjamin.s.berman@gmail.com>
Signed-off-by: Benjamin Berman <benjamin.s.berman@gmail.com>
---
 drivers/thunderbolt/nhi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 2bb2e79ca..bba45ec36 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -389,10 +389,24 @@ static void __ring_interrupt_mask(struct tb_ring *ring, bool mask)
 	u32 val;
 
 	val = ioread32(ring->nhi->iobase + reg);
-	if (mask)
+	if (mask) {
 		val &= ~BIT(bit);
-	else
+	} else {
+		if (!(ring->nhi->quirks & QUIRK_AUTO_CLEAR_INT)) {
+			int cbit = ring_interrupt_index(ring) & 31;
+
+			if (ring->is_tx)
+				iowrite32(BIT(cbit),
+					  ring->nhi->iobase +
+					  REG_RING_INT_CLEAR);
+			else
+				iowrite32(BIT(cbit),
+					  ring->nhi->iobase +
+					  REG_RING_INT_CLEAR +
+					  4 * (ring->nhi->hop_count / 32));
+		}
 		val |= BIT(bit);
+	}
 	iowrite32(val, ring->nhi->iobase + reg);
 }
 
@@ -423,8 +437,10 @@ void tb_ring_poll_complete(struct tb_ring *ring)
 
 	spin_lock_irqsave(&ring->nhi->lock, flags);
 	spin_lock(&ring->lock);
-	if (ring->start_poll)
+	if (ring->running) {
 		__ring_interrupt_mask(ring, false);
+		(void)ioread32(ring->nhi->iobase + REG_RING_INTERRUPT_BASE);
+	}
 	spin_unlock(&ring->lock);
 	spin_unlock_irqrestore(&ring->nhi->lock, flags);
 }
-- 
2.43.0


