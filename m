Return-Path: <netdev+bounces-296264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ka2pBxemJWpKKAIAu9opvQ
	(envelope-from <netdev+bounces-296264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 19:10:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF6A6510B7
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 19:10:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=baU2Q5al;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296264-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296264-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57025300CCA4
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772932DAFAF;
	Sun,  7 Jun 2026 17:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FC45BE3
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 17:10:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852225; cv=none; b=Rd9nddzDzbyFGqFzZo856JjIXbbbD5ZoVHdhG33++Rcf8AjUBTK8JGV5HM3fgAzwORxmSfB7HFlxRAq7QpOjb2/lynYpav5lhySWLDbfYYklfyfoIuNQ199yVzA0Y2Dje8IZycRVvaUM5lxBTIOadUL5d4SNKLivqjcDhx+Ndv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852225; c=relaxed/simple;
	bh=R0B+wsENjA8ZzQNVV41noFQrCBBvZhllbql1zNNXSuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uf9pef4EMwNsRuqNKHQyPBQq6SraySZ4FnKBHnoUAtYUJw0obqHldI32VkR04jqWlowZyT+D9sQty7g23AIsxTB9OdzmLw+fj2Las8dWaAc42y1rM+UigQH0Rg7zm4mQklk9TjWtzmGjZ7W7ocFKb15dgK5wGicdw7UcmToUOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baU2Q5al; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c857fba35cfso1618714a12.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852223; x=1781457023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yGPIIhFZdTIFfBstBwjXBL054wfOH0HNW4mEikIzLI=;
        b=baU2Q5alPeotmoK9isaPu9rDpA+7We4H0jmNGUoj7K64MPkKe5jXMVLJRZysLpkCdf
         WVETRxojIcHJrsWxQ3BD2KPrhB/Xy/bDAQ7aDowOthkZQFf3qMZi7lnPM6QHwNAikdFn
         lIZJekZ423/1zPncQRjCyMxkuMF7CVwzRYFd8NYj9G353vPkZcw7uG0t57bFY+cNm7ft
         2SaTb6hlnqCibXXLvKS1tZyagFUsWITYHI2xyBbemuizq27Hrp1bL/dWHM01JmqWc6YA
         4Luqwj/tiw6utOueeQ5xr76tk/MJFFRCTyyYh1T6rg0zS7Km66UdmGZ5fR2+5gB3cSxC
         0IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852223; x=1781457023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yGPIIhFZdTIFfBstBwjXBL054wfOH0HNW4mEikIzLI=;
        b=hdrU6BVd86AGwUyQr8Nhj0+ALSBVPja9ampgo5u+kVuuL9oZVESgBzoLep2Xt5OPBR
         oHirMRJAOX07NYwyE113a6hVedkQOVzegsneUy/9RdhfLSBKCG9XK4itW+Eq6DALcM7E
         eeuj5JaI5h/PvvPetU+x3LZ5JrOkbaf+GCINroMGW05XjGphIjFg3vzA9SDdtYLG3Z4S
         1t8+A10pJGdVgplad9bvtWrhQ+0l6DE79f6quEel1jlLlc2NojLwU4g6qdo8OwMwDHIu
         1vXM0Js4QDgaqBrTh0Nza+glDvoJP3IZwhp6lae89IqD2mJg+/2LtwgVJUKoBbhRVFMT
         A6jw==
X-Gm-Message-State: AOJu0YxUySfYK44GbDdOCLqpm2EaZmyFtI4ws7H1HWRRFEp6tIRgtzVN
	1hfMqFuFn4F2a6ffcbHXfCA0V7/YbSpPrZHoivb7NRRvpsb8qiepuBFE
X-Gm-Gg: Acq92OGUEgqxrBkDZTU9otgzhy7+v42ubUnPWlFm3oqy3DBbCMz0DD9lmXTF0eLIdFX
	/1Krv4MUB9G4JbEXVEddjLrrGRsrtkClpOWBTidTRQ50CwKwh4W9p4EAmeVOQSeGrzX9Z7pe00X
	shvX/LU8Fr24F8uvOwvMatBa8BOAwJKLkrFylRwab5iVeeH8lUuYARMp0nZd9a4UxFf1Ot04mzx
	pfJqCrsNnK7Lgo+hGpEUEvxyD80QOeMmiSy7Y2OWD5wY5ftAyIdDkDsKEpoR6THCF0f4iMMajyR
	PZzv0TqfGTIeb2I99sY2yPrEhCQFKsW/N2KoCMaOt4/BadL+qb3jLh375ZjdjjbczsGxYokHnX1
	TXgVkaFVsd4FZc5N1qWrk+bg91XG9tUgGsWasSLfx7rAgIFUXSoyVSpBceenQdG5FD+9iMTQEWq
	CgVliQ43r9VFQEkh5AdeHefEDg6qACs45epu3G3XUJyw==
X-Received: by 2002:a17:902:d4c6:b0:2c2:5446:30eb with SMTP id d9443c01a7336-2c25446352fmr26955575ad.11.1780852223265;
        Sun, 07 Jun 2026 10:10:23 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm155375265ad.31.2026.06.07.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:10:22 -0700 (PDT)
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
Subject: [PATCH stable 6.6.y v2 2/3] bpf: make the verifier tracks the "not equal" for regs
Date: Mon,  8 Jun 2026 01:09:57 +0800
Message-ID: <20260607170959.823755-3-jt26wzz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296264-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:sdf@google.com,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AF6A6510B7

From: Menglong Dong <menglong8.dong@gmail.com>

[ Upstream commit d028f87517d6775dccff4ddbca2740826f9e53f1 ]

We can derive useful information for BPF_JNE when one side is a constant
and the constant is exactly at the edge of the other register range.

For example, a > 0 can be compiled as a jump if a == 0. The equal branch
marks the register as known zero, but the fallthrough branch also needs to
preserve that the register is not zero. Without this, the range can remain
[0, max] and later verifier state pruning can keep an impossible scalar
path.

The upstream fix lives in regs_refine_cond_op(). The 6.6.y verifier still
uses the older reg_set_min_max() layout, so express the same branch-edge
refinement there: for BPF_JEQ, preserve the known-equal true branch and
exclude the constant from false_reg; for BPF_JNE, preserve the known-equal
false branch and exclude the constant from true_reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20231219134800.1550388-2-menglong8.dong@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ zhenzhong: backport to 6.6.y reg_set_min_max() layout. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f94bff12..de4f46796 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14169,18 +14169,50 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 		if (is_jmp32) {
 			__mark_reg32_known(true_reg, val32);
 			true_32off = tnum_subreg(true_reg->var_off);
+			if (false_reg->u32_min_value == val32)
+				false_reg->u32_min_value++;
+			if (false_reg->u32_max_value == val32)
+				false_reg->u32_max_value--;
+			if (false_reg->s32_min_value == sval32)
+				false_reg->s32_min_value++;
+			if (false_reg->s32_max_value == sval32)
+				false_reg->s32_max_value--;
 		} else {
 			___mark_reg_known(true_reg, val);
 			true_64off = true_reg->var_off;
+			if (false_reg->umin_value == val)
+				false_reg->umin_value++;
+			if (false_reg->umax_value == val)
+				false_reg->umax_value--;
+			if (false_reg->smin_value == sval)
+				false_reg->smin_value++;
+			if (false_reg->smax_value == sval)
+				false_reg->smax_value--;
 		}
 		break;
 	case BPF_JNE:
 		if (is_jmp32) {
 			__mark_reg32_known(false_reg, val32);
 			false_32off = tnum_subreg(false_reg->var_off);
+			if (true_reg->u32_min_value == val32)
+				true_reg->u32_min_value++;
+			if (true_reg->u32_max_value == val32)
+				true_reg->u32_max_value--;
+			if (true_reg->s32_min_value == sval32)
+				true_reg->s32_min_value++;
+			if (true_reg->s32_max_value == sval32)
+				true_reg->s32_max_value--;
 		} else {
 			___mark_reg_known(false_reg, val);
 			false_64off = false_reg->var_off;
+			if (true_reg->umin_value == val)
+				true_reg->umin_value++;
+			if (true_reg->umax_value == val)
+				true_reg->umax_value--;
+			if (true_reg->smin_value == sval)
+				true_reg->smin_value++;
+			if (true_reg->smax_value == sval)
+				true_reg->smax_value--;
 		}
 		break;
 	case BPF_JSET:
-- 
2.43.0

