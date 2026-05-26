Return-Path: <netdev+bounces-291487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDm/NQ/sFGp9RQcAu9opvQ
	(envelope-from <netdev+bounces-291487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 02:40:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B55CF4EA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 02:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A473017C16
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F2274670;
	Tue, 26 May 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha4OP5Xw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AD26FA7A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779756044; cv=none; b=BkQpXKmXxg4vuPRELiKxHrokeLO5mImCy6C04e2GXhdR8kO56V0s5QKxwzZwwG5kbbyvKSsjIaP4Wya6Z9+yersns6mZai9Denl0tEtrr3PYDg8oQOQHTDtLDixeiGFMdYdrEn6OZdj/s1dy3JTOllapO4UY5WE1PyzE4dnO0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779756044; c=relaxed/simple;
	bh=aI73dLAsoMnIz2OoRYSyNZeZBTVcQgWYmXKRdLg8hGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCklk+xjIbTGHjFMEQoS7p/uHXIzSWNIr3tuLxfHG6VAdE03kNL/EzRMI1K5rfEBa0mrzUppywVa9e2aEax8EYDZ4UB+lFUG4kjF8jsY7kb2JounsHxDg6bxaf40sYWIrL0znU3Q22cj1/tHkROoEiylVqn1qRSA5N9SVcx/dEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha4OP5Xw; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-57533363201so3317888e0c.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 17:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779756042; x=1780360842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBgWuooGCwcYgQ+uND+oHD3Fi2ceyxPTaalSlSWEF5A=;
        b=ha4OP5XwDhrA523lX4bzijXg2HUoWfx8fyvOcZIZ4DGN0A5vE6Jmx/pzpA+QZ3u1QI
         735lHTnuqCJFnGWJF/ZL+EM/AXZpVHOxA9+byPd/nT1yeVA3f0TUvylIYJ+wmJmT4iH+
         erdbPCio1lfKDz1Tl/fTLqlwLB2x6yiMUDEVtVec/oJ6nhy/NDSJhUZlbtSEpzoHpSYj
         T5E6L9rNugcezTds+KhhmSpJYQzGCcRWieYXqVMtX0MCghdJoNPDN9jR5qho+lYZnAAx
         fj1SMqjmIfSqwuow84OBMv0/Nxq3FO2FKJpZYb6x317NlNq8ioP0bPaRkeJs1h1Ucsr0
         CKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779756042; x=1780360842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBgWuooGCwcYgQ+uND+oHD3Fi2ceyxPTaalSlSWEF5A=;
        b=jVzCiOsdApA5/lFNvfJhm5njaO3V3iyvkmjY7WEsV74L/NG9iRhGoSAbhExDzxGTIv
         c+Z7y+GVKn4blsAvDKbMxN1XArCTWoHIlWVAJhkbyItAfk3tXf5VkLHopx7Nzj8xVLpS
         PMT5DVg7ky9LqfZBS+CNQCT22kop48rCq5SFI0330at4qMPjyYe7RyIu3H392RRBO8M0
         c6vDVSqxdKfrs/n1Oi56lwEx0ie2Q41CiUoDHrSweXVR1EplJZYitl53X2EObXyr7Pcx
         pQDZqaFpp8bC47RnqawDRGiNG9GPlMeLpMymPTz8rRj4CmXfNoC6JPqu5dTjm70lbERB
         TdMg==
X-Gm-Message-State: AOJu0YxOurcmEHXRFc2h8ipPlQOTY5xuImQmNmbbx4Rnva1/QM9NfBo4
	LO5XPn9bE2uo9wgAkVYXcYgS+69ogTKat71IiOxVP50YcfQI7KDbFP238IZRmwSDpd0=
X-Gm-Gg: Acq92OFGS1LAny6Eoydv1TAMV2zDRTjFDIJBS407rB5hZEaezp3RNsTfeiFqC04L9KB
	byZaN3R5AuCRlWhDkzCeIYjmyhYE7ZlAXrqGZq+Kp5+OHb0UfoN4fV7LNe/YR9zh5b4MzYq3Dwh
	DdbLYkvLV4BdYVq6vgzUnGPC5PpAmH3GtGAk7XR/OmS1Geinkb3k9wPZKAtcGEumzken3ULf9Qd
	ZqhqDFPiKYLNjBMj0oWIgItAD5Y/FMi5kNeLkHEW66KXdqLjRoqjlMgCfuKaGXxbrEJ+fINYtyx
	l9Cfv2b9ze5iFO9LwRSLC7/cFUUk4cnzvnnQa4yxKh9v7fle8mhD77SsCktyd4z3h0fRzyx3tMb
	RTcaQO4KzUKnlpdgfean+wO+h4YCXKFyBWjFQWZFGo37HLJbQp+ujPZrKySc0hEitQhB/t5ikMJ
	qCwXcy8ytMNe/gJaROd7Mr3Fx0siBLvz2nIIvELDyuYFZ6qLbvN1JKSlewt9XLjyo+jdKUtSIEq
	GrfsHXXl0HInnH2LmPNNj5pg07oNH01OCe0lgLtiFDL6NQNycGNt/5gVQtV+mE1
X-Received: by 2002:a05:6122:3214:b0:56f:2609:cd95 with SMTP id 71dfb90a1353d-586626bd8acmr8961529e0c.9.1779756042074;
        Mon, 25 May 2026 17:40:42 -0700 (PDT)
Received: from sekiura-Standard-PC-i440FX-PIIX-1996.. ([186.122.244.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-588c129cba5sm11799269e0c.14.2026.05.25.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 17:40:41 -0700 (PDT)
From: Takao Sato <takaosato1997@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	w@1wt.eu,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	chopps@chopps.org,
	pfalcato@suse.de,
	stable@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>
Subject: [PATCH net v4] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
Date: Mon, 25 May 2026 21:40:35 -0300
Message-ID: <20260526004035.1023696-1-takaosato1997@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,1wt.eu,davemloft.net,gondor.apana.org.au,chopps.org,suse.de,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291487-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takaosato1997@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 284B55CF4EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_consume_frags() transfers paged fragments from one socket buffer
to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
the same class of bug that was fixed in skb_try_coalesce() for
CVE-2026-46300: when fragments backed by read-only page-cache pages are
merged, the marker indicating their shared nature must be preserved so
that ESP can decide correctly whether in-place encryption is safe.

Apply the same two-line fix used in skb_try_coalesce() to
iptfs_consume_frags().

Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Takao Sato <takaosato1997@gmail.com>
---
Changes since v3:
- Corrected Cc: stable tag from "# 6.8+" to "# 6.14+". IPTFS was
  introduced in v6.14, so earlier stable branches do not need this
  fix. Pointed out by Pedro Falcato.

Changes since v2:
- Removed security impact paragraph from commit message as requested
  by Steffen Klassert.

 net/xfrm/xfrm_iptfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e5..4db85e158 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
	       sizeof(fromi->frags[0]) * fromi->nr_frags);
	toi->nr_frags += fromi->nr_frags;
+	if (fromi->nr_frags)
+		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
	fromi->nr_frags = 0;
	from->data_len = 0;
	from->len = 0;
-- 
2.43.0

