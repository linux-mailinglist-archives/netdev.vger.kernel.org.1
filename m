Return-Path: <netdev+bounces-265098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGsHKafKq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:50:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A950622A7CF
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CE23304244F
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A33793AD;
	Sat,  7 Mar 2026 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opp7fMVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633237B033
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865888; cv=none; b=aKoqeyXoyhavk9fuxVRwOgPqaIfagocqg59ymuLofiwLsWumKgsCw0Y9sRRJzJuoV48qLjBoyrMk/+tFQT8hOULtMJ47G9QwUZskE5RVzF1gAKyhbrZGBwZ8rtI3UrKh2P22QA4ymbFbowKbmNwol7v3RAlMPu1EvBO4uZz204Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865888; c=relaxed/simple;
	bh=zg54N2RacaNRzv4xPjUQtK1TvbPGS4ttunAlGHbREgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUNrQ507mEp5U2YGA7ze/yrK81aac6YFyhFafEdGxi9p96uST0vj1dhVDoI82NmGlTViyLNPwhjlZDQy2tzjT7wc8eR1s9SVt1EGUwLjEFHThtm1qtciuo8Ew+/t53LecC4+isdDN9tF3xl/5Xvr9EIPEsnKxGmHleb18zX+nlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opp7fMVR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso1453892a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865886; x=1773470686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IveTH5JWf6wbbtWrNvYx1p+e/Ua/aGYSxO2nKBZt0ag=;
        b=Opp7fMVRMSgzvQOBIW5uplifqY7+bsg12ZFcyAU06KSExynb6/DoBDyxUI2QYq1H/9
         KMuF+zRAOT33l0dqsiENjAkIt/C9ZR0iMAAVaa4gDhMnm51eIJRN42BgsoHAGe+Qf1RK
         OoLeXjPfBmsY2ejBIk5R0knza4/3uiFZrSfLAxnK4UNwUWSp0An1ETAOUigIvoCs5DEG
         TxW8HDcyAd3yL8PZ1M0wBNez8C/LmNBX1e4hZlWr6KXYhJod279WK6w9p3svngHxgSLp
         PqPiWpg0XI5CZTAwX04BhFVxUKC0zV6+gj07qaAlaEQ4D0RELRQ3lX3etwVTH4wIWBEn
         EkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865886; x=1773470686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IveTH5JWf6wbbtWrNvYx1p+e/Ua/aGYSxO2nKBZt0ag=;
        b=XiuddLosEsqJ0iawlaEYWz96xVcSNhpaVQ7jb1NE8VfvvZoGgFO6mCZdwWr3wnYvpU
         QX6y/jJnza8jNZgDrct3oYzMnjCKHXp3B57UORWyNQ2UOOiFP8Tqr+O0nQSCa7FjBkiX
         UH2vTLBtuozFs6fSgBGaCvAHh++CwABsCeuiN4I83Dizx4EeN9vYrDXttCsIwn0TuC6s
         0+TjqBpgmBA42Cyv8BJDiRepvYZrrwW/FXGMz2TdevTCgFBdjvWGzIdj8qAUcsU7Na7g
         xEuVbO0gnFxEabvIR7OFV+cPCKW95fw5tqkkild1FtuWzCDDROIEzPaAfQBpraHIiNRX
         WRaQ==
X-Gm-Message-State: AOJu0YwMVDMoY4AU+qscjSbndddL4amlBjfSQ7aGDKFBH8TEv6JmhcxS
	kTUOCehBrnbyNCQZGg31quBrqIWkJcI5USXNb46LVt+11t8lSEc0vKAp
X-Gm-Gg: ATEYQzyomX4JoJPfAcE7yjoX0GoC05aIj4Rcckao0KN5PxdHx0i0p8LRWESqx3yELJw
	4OPEm+iMRo3V4M9wc+gM6nJFFaeDg6t+r7HCbuod5IEbRLP+3KDIdwngh6vxGs0LpnriwqQrxPk
	ormEAdl5EOIZXylkXnMIZm/pHLj4Ke1KdgxbMklEuXLUQtC47wMYc4lEhREJwq22ilxgrRjgP1h
	5kWn2pm37koUQ0XDGVJYzVJQo/3Y6yl1FO8lrFuMazmrNEQxL5PYoxvShz3YajkFjT4fLyxVS7D
	NQ29jmM2ZNDsEgCqlgkOqgl4bEznqgEX7SFVvQ5B81RI3v2JeiKycvJ81y5UhSaQkM0U9Dc+OnP
	UVykuZfChi6hzmnfVo7dHjnL5jgrP8TxysQJcVlaB/ko1K3uFuhG/oCOJu80ql6hYMNW5/f4dkf
	LCCZqWFxiGGILnIw==
X-Received: by 2002:a17:903:ac5:b0:2ae:4a6b:68ea with SMTP id d9443c01a7336-2ae82466961mr45232935ad.43.1772865886243;
        Fri, 06 Mar 2026 22:44:46 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ad894sm55101425ad.80.2026.03.06.22.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:45 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer objects after null-check
Date: Fri,  6 Mar 2026 22:44:33 -0800
Message-ID: <20260307064439.3247440-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A950622A7CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265098-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Preserve reg->id of pointer objects after null-checking the register so
that children objects derived from it can still refer to it in the new
object relationship tracking mechanism introduced in a later patch. This
change incurs a slight increase in the number of states in one selftest
bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
states is also negligible.

Selftest BPF objects with insns_diff > 0

Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (DIFF)
---------  ---------  -------------  ----------  ----------  -------------
     7309       7814  +505 (+6.91%)         394         413   +19 (+4.82%)

Meta BPF objects with insns_diff > 0

Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
---------  ---------  --------------  ----------  ----------  -------------
       52         57     +5 (+9.62%)           5           6   +1 (+20.00%)
       52         57     +5 (+9.62%)           5           6   +1 (+20.00%)
      676        679     +3 (+0.44%)          54          54    +0 (+0.00%)
      289        292     +3 (+1.04%)          20          20    +0 (+0.00%)
       78         82     +4 (+5.13%)           8           8    +0 (+0.00%)
      252        320   +68 (+26.98%)          21          27   +6 (+28.57%)
      252        320   +68 (+26.98%)          21          27   +6 (+28.57%)
      119        126     +7 (+5.88%)           6           7   +1 (+16.67%)
     1119       1128     +9 (+0.80%)          95          96    +1 (+1.05%)
     1128       1137     +9 (+0.80%)          95          96    +1 (+1.05%)
     4380       4465    +85 (+1.94%)         114         118    +4 (+3.51%)
     3093       3170    +77 (+2.49%)          83          88    +5 (+6.02%)
    30181      31224  +1043 (+3.46%)         832         863   +31 (+3.73%)
   237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.01%)
    94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02%)
   237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.01%)
    94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02%)
     8103       8108     +5 (+0.06%)         459         459    +0 (+0.00%)
     8076       8079     +3 (+0.04%)         457         457    +0 (+0.00%)
     8177       8197    +20 (+0.24%)         459         460    +1 (+0.22%)
     8083       8086     +3 (+0.04%)         458         458    +0 (+0.00%)
   237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.01%)
    94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02%)
   237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.01%)
    94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02%)
     8103       8108     +5 (+0.06%)         459         459    +0 (+0.00%)
     8076       8079     +3 (+0.04%)         457         457    +0 (+0.00%)
     8177       8197    +20 (+0.24%)         459         460    +1 (+0.22%)
     8083       8086     +3 (+0.04%)         458         458    +0 (+0.00%)

Looking into rbtree_search, the reason for such increase is that the
verifier has to explore the main loop shown below for one more iteration
until state pruning decides the current state is safe.

long rbtree_search(void *ctx)
{
	...
	bpf_spin_lock(&glock0);
	rb_n = bpf_rbtree_root(&groot0);
	while (can_loop) {
		if (!rb_n) {
			bpf_spin_unlock(&glock0);
			return __LINE__;
		}

		n = rb_entry(rb_n, struct node_data, r0);
		if (lookup_key == n->key0)
			break;
		if (nr_gc < NR_NODES)
			gc_ns[nr_gc++] = rb_n;
		if (lookup_key < n->key0)
			rb_n = bpf_rbtree_left(&groot0, rb_n);
		else
			rb_n = bpf_rbtree_right(&groot0, rb_n);
	}
	...
}

Below is what the verifier sees at the start of each iteration
(65: may_goto) after preserving id of rb_n. Without id of rb_n, the
verifier stops exploring the loop at iter 16.

           rb_n  gc_ns[15]
iter 15    257   257

iter 16    290   257    rb_n: idmap add 257->290
                        gc_ns[15]: check 257 != 290 --> state not equal

iter 17    325   257    rb_n: idmap add 290->325
                        gc_ns[15]: idmap add 257->257 --> state safe

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ea10dd611df2..8f9e28901bc4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17014,15 +17014,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
 		mark_ptr_not_null_reg(reg);
 
-		if (!reg_may_point_to_spin_lock(reg)) {
-			/* For not-NULL ptr, reg->ref_obj_id will be reset
-			 * in release_reference().
-			 *
-			 * reg->id is still used by spin_lock ptr. Other
-			 * than spin_lock ptr type, reg->id can be reset.
-			 */
-			reg->id = 0;
-		}
+		/*
+		 * reg->id is preserved for object relationship tracking
+		 * and spin_lock lock state tracking
+		 */
 	}
 }
 
-- 
2.47.3


