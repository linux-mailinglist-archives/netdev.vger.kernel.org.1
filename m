Return-Path: <netdev+bounces-253912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLQNIDrSeGmNtQEAu9opvQ
	(envelope-from <netdev+bounces-253912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21022961EC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF19830FCEC9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B21635B652;
	Tue, 27 Jan 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dz+GqUTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741335CB68
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525081; cv=none; b=kluZorY8W0ePcieDTpDG4rO+DCfW22aJRnkqmn+BSmXvNnS3U947niDFuAK/gHIWCHeREQwlMT2L3ukWsGuHYCWW424+zP/wv6vuTG9ZcfjAOU6D/Kgl4bppyRlOJfi0hp62Qdiibh1YpJ5kXLDmbvDW/ro82bVR+eLH66WP/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525081; c=relaxed/simple;
	bh=tbjryCvGSbVz+/+ID/TwWu44tWlMGxawi7FNmKxbZPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rKEDmkUFUA+JHFtY8+Z3ZWkiEiEEVf7E5O+eg/GWwXi9WTE/sRLTo9yaLZJO/ynQ6u7bT59bi3wkpdDT6rQjM8sERtgKVUdFmtXm9Hf0n1HeL6028VA10mpmwDxaOlgy4az5m2eHuW4YA5TI7F1wXDD6hOAQ6oE/SrNn775JFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dz+GqUTd; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8887c0d3074so219946086d6.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 06:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769525078; x=1770129878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUxMK3RyZ7onYCTyk54Qu0gTKpFdeZkk1I+Lt0kQM9A=;
        b=dz+GqUTd07IDL0VckCS94X/4/2sWxcnSUBg9Qs4iGvbvu+4nCZBmWMdGrXHHezLUR9
         h7pZ/sm/aDVuqTc79C2FfQ5sCG8ZQmRVtb3fyyYPWhL4A9iTk6cZxmKp4hju1w1Tt9d4
         hDcAsG5b7zbSLaUfxmrB3FeVD9bAdscnghxmkB5L+lk2aH2zgpo34hoYx1TPmgP9GwqB
         HaICj4Xw0hdA64fjgi52JEqF9G5FYO22JVeKwvPIrVotGF5/NU8iQi/Li4WY72kUEshL
         SESMU2PHDEyVx1Wn4ma8KIRiiRyICJ+zcL+qBRhdvIS8UjTK8gLiV2RbhZOmugki1UZb
         DmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525078; x=1770129878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUxMK3RyZ7onYCTyk54Qu0gTKpFdeZkk1I+Lt0kQM9A=;
        b=mUV7NaSChUdivEUYLLYQMI9VnVncAz5scXXG4R21GIjMZw83dGfCVz/FS6nd+w9XhY
         4jiSkK6GF6v+B+06/tP8Z7R3nZbDLOgivLCen0pRMRUbCzLNXC0D3LmOtls9xLzJ9TPk
         0LIVVmELnuBlySchrHAZ6zTGbuz45QYHd5KCU12CdmhRgVyDPDCfXl3lNSVKrbaf33VD
         uPBmdEKOp5G0qXmyQNcNFbqTX8SlH8i5FRCUpA6ZLanhqA4Kd08f/cnlcMlrysUIo0ae
         ohaixB8FjL2advcsdkM9cf17ui2KBHBpCl1rlUs4YL41604bYR3Lqs4IoXm82fZkOEgh
         E0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUeM4LgoPhZbFNZ7MedNzp0kMQPOCvE0sH+Vats73Na61mOP+FdOzZIMFu5MH08If8EerWF/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nyf+rPSjSulwOyYhYCHGH0Nic70M/vFd1CkIWmsM6FFati8Z
	VqP/9cC1DZoYsH/CXNHHmMOStDuToRdgVsM1KLNGEOwcX9+BLfHWQjDz70hl4uvfEP4C9fCugA8
	aN/hByqQRvU0rIw==
X-Received: from qvbjs5.prod.google.com ([2002:a05:6214:2aa5:b0:892:70e9:634e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:301:b0:502:9da8:818d with SMTP id d75a77b69052e-5032fe1c63emr19501721cf.82.1769525078477;
 Tue, 27 Jan 2026 06:44:38 -0800 (PST)
Date: Tue, 27 Jan 2026 14:44:33 +0000
In-Reply-To: <20260127144433.196836-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127144433.196836-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127144433.196836-3-edumazet@google.com>
Subject: [PATCH net 2/2] net/sched: cls_u32: use skb_header_pointer_careful()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	GangMin Kim <km.kim1503@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,gmail.com,resnulli.us,vger.kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253912-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21022961EC
X-Rspamd-Action: no action

skb_header_pointer() does not fully validate negative @offset values.

Use skb_header_pointer_careful() instead.

GangMin Kim provided a report and a repro fooling u32_classify():

BUG: KASAN: slab-out-of-bounds in u32_classify+0x1180/0x11b0
net/sched/cls_u32.c:221

Many many thanks to GangMin!

Fixes: fbc2e7d9cf49 ("cls_u32: use skb_header_pointer() to dereference data safely")
Reported-by: GangMin Kim <km.kim1503@gmail.com>
Closes: https://lore.kernel.org/netdev/CANn89iJkyUZ=mAzLzC4GdcAgLuPnUoivdLaOs6B9rq5_erj76w@mail.gmail.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/cls_u32.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 2a1c00048fd6f4b700bee11c80502aa3ff993331..58e849c0acf412d3a5ed5cd9a2b32929a720cb17 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -161,10 +161,8 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
 			int toff = off + key->off + (off2 & key->offmask);
 			__be32 *data, hdata;
 
-			if (skb_headroom(skb) + toff > INT_MAX)
-				goto out;
-
-			data = skb_header_pointer(skb, toff, 4, &hdata);
+			data = skb_header_pointer_careful(skb, toff, 4,
+							  &hdata);
 			if (!data)
 				goto out;
 			if ((*data ^ key->val) & key->mask) {
@@ -214,8 +212,9 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
 		if (ht->divisor) {
 			__be32 *data, hdata;
 
-			data = skb_header_pointer(skb, off + n->sel.hoff, 4,
-						  &hdata);
+			data = skb_header_pointer_careful(skb,
+							  off + n->sel.hoff,
+							  4, &hdata);
 			if (!data)
 				goto out;
 			sel = ht->divisor & u32_hash_fold(*data, &n->sel,
@@ -229,7 +228,7 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
 			if (n->sel.flags & TC_U32_VAROFFSET) {
 				__be16 *data, hdata;
 
-				data = skb_header_pointer(skb,
+				data = skb_header_pointer_careful(skb,
 							  off + n->sel.offoff,
 							  2, &hdata);
 				if (!data)
-- 
2.53.0.rc1.217.geba53bf80e-goog


