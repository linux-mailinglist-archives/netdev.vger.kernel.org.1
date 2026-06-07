Return-Path: <netdev+bounces-296263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZyhSLz+mJWpbKAIAu9opvQ
	(envelope-from <netdev+bounces-296263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 19:11:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C946510CA
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 19:11:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hjmLcIhQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296263-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296263-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5902F3028372
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB702FB965;
	Sun,  7 Jun 2026 17:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F07220F2D
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 17:10:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852219; cv=none; b=K+84Y6nHxUg4CYTwVf3f/zW/uOODvBjxNP+lQlxknq0l9GUFDXOLlzTsQBNHhz1BUscrDfdiq7HICCAhZhYvnIkKUBuFKTePW21+lPOWVhy6DDI8CTt94kPBSOoVrPPhHLf/he1ajLyC1ARetnDwi7z1/VEN53Q+w+JsyvEMIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852219; c=relaxed/simple;
	bh=Wj6INcB2ZWn71vsSX+uGeQfK2gKV41AKUbGx7CRisFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie1vclPGLNSocXIJRjzi7j2HqtEo70mJ6Q+6MvYyhINqskOvgrOGZfVXTgHj3XEsonWlF2OotQxMPdvgy8dDDBfnYhRakvRSSaL1xPDQkuv8TQxAwZ145jbxh1uaT0IbkKtg9Jah9GxcnZrn9nCYX1nTvF2xwzkyR31W8lSMCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjmLcIhQ; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so28446595ad.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852217; x=1781457017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPsuDEC4emnE4igPvpmuWKON1k829WThn64znvg3mx8=;
        b=hjmLcIhQEYPmillRFf3WucOCrckndMbn9ijwD4YnlaMuuBWzHgV1i0kDpjLNX55YOm
         UXPdABmNb6vunD9ZOGmX4xZwaX4oU8hGBJSz0Pi4xSct5kEEdLrQBC8qqi+tOQ9sFAbA
         yu/DIh/FJDtat43b7Wz9zAvLg075cuD2Evwiht84mTGxO9oWfkMOPP4mQTU2oh/5imcg
         FRIpKIbubsEXdhcrUYQHf0FbmCqB+1XwyRm9N41dE3jQcz66dVLkKejc0tbHoXZUmzDG
         6lyiZDwgBMiZaE348OsoeZ+ktaPvntrRPnR6s1ZPnmotMQhmR41bLcA+zAcGZbxhtlZp
         oB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852217; x=1781457017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OPsuDEC4emnE4igPvpmuWKON1k829WThn64znvg3mx8=;
        b=EaagmlKhvGIIo1bIW6OK1KK2Pi54pOsxnHtkK5lfRt6DQqDNkmZJp3WW7rQxYGPR0D
         Nk0yaHq1I5BihEb0xXeY4mncVlXlcfAGvoHjSI7BSGtA0ZJTXiYlG77wbITUUojJAhvI
         Ek2tOfzU/3ZzZ2rUIT2ByQS8q2gGmVU2dshDsg9Fw0NR+s1le2w6shY+kVBfNfhyh+3g
         Bnt4xfc5s0fYS1ghrNQ4zILWDTsVY0nVx1RtP7hzxHryL9HJNkZF5h6l0QtRHVN2UoLx
         Bo4kKQzZRbTxNhdn5JDSt6UELsi7MxhyhJQTTPjzlb3t278Km/spPL1zr2QHfVfbbl8z
         V5Hw==
X-Gm-Message-State: AOJu0Yxstq7dH96TwRoz9IKjQcAMqWrMgrzbdqa4Qe0HQqI5PbmyeWVA
	mkNBYNd8QRqAKDVZU1oUjc2cCH/Oqio9lRYok+9AT0Lft7JoCqQv+thM
X-Gm-Gg: Acq92OF8nR1AXm5QNnd6azYxA0ec5xg3scQ2A9LcW5BrNqqhO6edLMI/QOGtbPqqRAl
	uq3snUGf0fd30JWVxe4Om180WXSPfbaVck0Ou/hjTcY1Ic77wTd0Q6H5aLjZP8ROlNgJcs4pKXu
	LmchcyQBhMIHs9zqk+GqkQr/W9fgf+c06I/T8jvyQvbGIbt7vS2KLuVe3D4w4wJUOlkJ9C3NF8q
	Ewuj0MJfQ8eBMAFMd1UdIZX0Y+9R4CaG3/uXKX+twpGqg57f4k9AeOjL6AhVvI906/58qUdj1JD
	6jupuW4CbsrLnSjefhnLqFFzHF5aMwz7o116lS6EWNjcny6ZoIDEMOsxczGTPZsXdYws+MzvrLT
	w5DgKXV/MnWvzVjE5/eZh17Gf/lJ+hg0ISyYerbyc9R75PtMHRAmpDybA2g6dzW1Xbkd9UOhO29
	S6TO7y2sTj3ymC2fycvp/ldpx9k8Ir5zOitoiWv88p+w==
X-Received: by 2002:a17:903:28e:b0:2c2:5446:30e8 with SMTP id d9443c01a7336-2c254463524mr29394155ad.18.1780852217123;
        Sun, 07 Jun 2026 10:10:17 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm155375265ad.31.2026.06.07.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:10:16 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v2 1/3] bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
Date: Mon,  8 Jun 2026 01:09:56 +0800
Message-ID: <20260607170959.823755-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607170959.823755-1-jt26wzz@gmail.com>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296263-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:sdf@google.com,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28C946510CA

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 9e314f5d8682e1fe6ac214fb34580a238b6fd3c4 ]

When performing 32-bit conditional operation operating on lower 32 bits
of a full 64-bit register, register full value isn't changed. We just
potentially gain new knowledge about that register's lower 32 bits.

Unfortunately, __reg_combine_{32,64}_into_{64,32} logic that
reg_set_min_max() performs as a last step, can lose information in some
cases due to __mark_reg64_unbounded() and __reg_assign_32_into_64().
That's bad and unnecessary. Especially __reg_assign_32_into_64() looks
out of place here, because we are not performing zero-extending
subregister assignment during conditional jump.

Replace __reg_combine_* with reg_bounds_sync(), which derives u64/s64
bounds from u32/s32 and vice versa.

For coerce_reg_to_size(), reset subreg bounds for 1- and 2-byte loads and
then use reg_bounds_sync() to recover as much information as possible.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20231102033759.2541186-10-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ zhenzhong: backport to 6.6.y verifier.c layout. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c | 60 ++++++-------------------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d90236d0..5f94bff12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2448,51 +2448,6 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
 	}
 }
 
-static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
-{
-	/* special case when 64-bit register has upper 32-bit register
-	 * zeroed. Typically happens after zext or <<32, >>32 sequence
-	 * allowing us to use 32-bit bounds directly,
-	 */
-	if (tnum_equals_const(tnum_clear_subreg(reg->var_off), 0)) {
-		__reg_assign_32_into_64(reg);
-	} else {
-		/* Otherwise the best we can do is push lower 32bit known and
-		 * unknown bits into register (var_off set from jmp logic)
-		 * then learn as much as possible from the 64-bit tnum
-		 * known and unknown bits. The previous smin/smax bounds are
-		 * invalid here because of jmp32 compare so mark them unknown
-		 * so they do not impact tnum bounds calculation.
-		 */
-		__mark_reg64_unbounded(reg);
-	}
-	reg_bounds_sync(reg);
-}
-
-static bool __reg64_bound_s32(s64 a)
-{
-	return a >= S32_MIN && a <= S32_MAX;
-}
-
-static bool __reg64_bound_u32(u64 a)
-{
-	return a >= U32_MIN && a <= U32_MAX;
-}
-
-static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
-{
-	__mark_reg32_unbounded(reg);
-	if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_value)) {
-		reg->s32_min_value = (s32)reg->smin_value;
-		reg->s32_max_value = (s32)reg->smax_value;
-	}
-	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
-		reg->u32_min_value = (u32)reg->umin_value;
-		reg->u32_max_value = (u32)reg->umax_value;
-	}
-	reg_bounds_sync(reg);
-}
-
 /* Mark a register as having a completely unknown (scalar) value. */
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg)
@@ -6164,9 +6119,10 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 	 * values are also truncated so we push 64-bit bounds into
 	 * 32-bit bounds. Above were truncated < 32-bits already.
 	 */
-	if (size >= 4)
-		return;
-	__reg_combine_64_into_32(reg);
+	if (size < 4) {
+		__mark_reg32_unbounded(reg);
+		reg_bounds_sync(reg);
+	}
 }
 
 static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
@@ -14329,13 +14285,13 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 					     tnum_subreg(false_32off));
 		true_reg->var_off = tnum_or(tnum_clear_subreg(true_64off),
 					    tnum_subreg(true_32off));
-		__reg_combine_32_into_64(false_reg);
-		__reg_combine_32_into_64(true_reg);
+		reg_bounds_sync(false_reg);
+		reg_bounds_sync(true_reg);
 	} else {
 		false_reg->var_off = false_64off;
 		true_reg->var_off = true_64off;
-		__reg_combine_64_into_32(false_reg);
-		__reg_combine_64_into_32(true_reg);
+		reg_bounds_sync(false_reg);
+		reg_bounds_sync(true_reg);
 	}
 }
 
-- 
2.43.0

