Return-Path: <netdev+bounces-292934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHZVAcPwGGqrpAgAu9opvQ
	(envelope-from <netdev+bounces-292934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:49:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3A55FC1CC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9292B3026E75
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA3036492D;
	Fri, 29 May 2026 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGl28ADs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A5363C5A
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019387; cv=none; b=OmtAo2OvBAeE+kk0xKZZ1RVBdNRP+9hp6M8hSpTyoMYLl67Le440i5gBBM+nS6oN2GTP0gYWYhvUjZBI/9cvpTAYAdtsZX5e45msSXn5cGWXDFDFwzeq9cmlZcuv4aSzdCvZJLfuNc8kjGPHhxbqN0PAEK86ct1Pfi5WfNcpkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019387; c=relaxed/simple;
	bh=Ol0IcP96iZaNVq94nPErOkDY/wSaji7+/ljrUes0cIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCCTPsxi39z/VasX3xDxxMYGSu1Xw1H/W+dHLXjEH7NFG2BPIU71myh3qfCyplYDozfCH5gAmeThJA3BUtIsbyLpfl2OkJo2u7y3UzLMgdeoDxE9cCO34+fqbStWrllw7U1m/WvrEkAKWRqUOVUJRiuch9Q5nfvpW/RNYN7ju8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGl28ADs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so139480395ad.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019384; x=1780624184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oClv69B/E1oDBe27Jpiv2e1r+T6XlJsfNyynJB6bK84=;
        b=WGl28ADsl0YRm9yIavOfj0sj9cOPsj0hylWRoEs4NrpjwBEL6DlBC/5B990tkMWQ1r
         bA5J69Grsa37X21BRiLn8rbqN53GDEMkIXdVnlOFiLQV62hPYSexkIMBUbDliCB2fltb
         Pj9c7nmqbpRPbAAbGZB9Zfs3fMkQV9xr13phmRUnMip2u7iYSFAkSBIW927w+3Zew3G3
         LIO2OpgxbBkR6Z3H82+vzVG6gI7fus5x8i1XzUCKQ7oXZ3TETHBl63kP39/lQBpN6mTs
         Lf4Kq319KY0D8Ysj3eGS9iwt8/CeqRvnzh/uVffl2gctFbpG2LmRDK7icPRydKJQItEv
         JKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019384; x=1780624184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oClv69B/E1oDBe27Jpiv2e1r+T6XlJsfNyynJB6bK84=;
        b=adQRGtWn4tGw3cpmYqdaOpEdGBGttsFj+oL8VAOH90Kyt5NXqN4CWvJDkunROYGXvR
         hoOfII4B3uqQ8lB/medwTNig/3VmRjxAYq1GnwI4EkEaW9MHHo4dYD4bwWv988SmuQv+
         aOgWKyKKbDkYHoA6XiKun7wddD6WW0Tda/i1Gxn9U8pFf8F3X8c+cKh1+54/M8GuSdp7
         BQaL++M2/TvMBUFqmjjWNy1yJzq2BwpzQKsChNRApjASiuuEmMxghF2BvxgKfNzwShNK
         g3A3hgXMWe8tEXWYPrLi9zhTvCKH0io+Zip2C50i/5MAmSdaROqXBl/Z2xZKtPTfTBUj
         pMzA==
X-Gm-Message-State: AOJu0Yxl1o+LLiNhQY0hjhKGevFaXS/g61NSVHOqj3RUrudTJd0R5Zdb
	vhX0gVTGrF2se3Ay4Zy0k/GtC8enFAdzds1e7CucEIRP+We8DB9dLmef
X-Gm-Gg: Acq92OFhbWOvqVd1zvc7dd9V5NvwlPuY3F5b9lmVBMi3Xv2GL1fkY9c6PiZ2Gnw5a7+
	MaSmlmL5TrcGJXwYmkp+D4XrZKupTGxWAUN5VO1kXjt7+EeKcCzKwPQRAE0cpn3tPhGrPvfO+0l
	qftDGLaXrw4tIkvqzykhGFmQkkdNqWbWoOISeL5J4Ix3q8oYSejbGosof3d8AwX2oeq3i5o6kx+
	ZRBvXbsq8N1hfhebNvTT9QH9nZniifyGxznz4xUEjus93+YTuuJtz+pDLA4dGoJ6wD7O7s7dvaQ
	L+B0fK0LztinN+u6ZJKU8yXb+xOE24i9m1XDwOgml95h+s/+o43rvS5JjuGjMlE9EhN6G0FLM7C
	0XxBexKVNwvTBIsXjX28II0JjADcAI+l89iy8awpp3FlPqG7Kje71kHbcLhzdLLASxaKGHXTLsj
	m59Q1DgUezsAM+q7qZAS0zqYb9FPPFx8W215o=
X-Received: by 2002:a17:903:178e:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2bf20bd7e82mr11505955ad.32.1780019383925;
        Thu, 28 May 2026 18:49:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a10165sm824725ad.31.2026.05.28.18.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 04/13] bpf: Preserve reg->id of pointer objects after null-check
Date: Thu, 28 May 2026 18:49:27 -0700
Message-ID: <20260529014936.2811085-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292934-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6F3A55FC1CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Preserve reg->id of pointer objects after null-checking the register so
that children objects derived from it can still refer to it in the new
object relationship tracking mechanism introduced in a later patch. This
change incurs a slight increase in the number of states in one selftest
bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
states is also negligible.

Selftest BPF objects with insns_diff > 0

Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
------------------------  ---------  ---------  --------------  ----------  ----------  -------------
rbtree_search                  6820       7326   +506 (+7.42%)         379         398   +19 (+5.01%)

Meta BPF objects with insns_diff > 0

Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
------------------------  ---------  ---------  --------------  ----------  ----------  -------------
ned_imex_be_tclass               52         57     +5 (+9.62%)           5           6   +1 (+20.00%)
ned_imex_be_tclass               52         57     +5 (+9.62%)           5           6   +1 (+20.00%)
ned_skop_auto_flowlabel         523        526     +3 (+0.57%)          39          40    +1 (+2.56%)
ned_skop_mss                    289        292     +3 (+1.04%)          20          20    +0 (+0.00%)
ned_skopt_bet_classifier         78         82     +4 (+5.13%)           8           8    +0 (+0.00%)
dctcp_update_alpha              252        320   +68 (+26.98%)          21          27   +6 (+28.57%)
dctcp_update_alpha              252        320   +68 (+26.98%)          21          27   +6 (+28.57%)
ned_ts_func                     119        126     +7 (+5.88%)           6           7   +1 (+16.67%)
tw_egress                      1119       1128     +9 (+0.80%)          95          96    +1 (+1.05%)
tw_ingress                     1128       1137     +9 (+0.80%)          95          96    +1 (+1.05%)
tw_tproxy_router               4380       4465    +85 (+1.94%)         114         118    +4 (+3.51%)
tw_tproxy_router4              3093       3170    +77 (+2.49%)          83          88    +5 (+6.02%)
ttls_tc_ingress               34656      35717  +1061 (+3.06%)         936         970   +34 (+3.63%)
tw_twfw_egress               222327     222338    +11 (+0.00%)       10563       10564    +1 (+0.01%)
tw_twfw_ingress               78295      78299     +4 (+0.01%)        3825        3826    +1 (+0.03%)
tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       10584       10585    +1 (+0.01%)
tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        3825        3826    +1 (+0.03%)
tw_twfw_egress                 8080       8085     +5 (+0.06%)         456         456    +0 (+0.00%)
tw_twfw_ingress                8053       8056     +3 (+0.04%)         454         454    +0 (+0.00%)
tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         456         457    +1 (+0.22%)
tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         455         455    +0 (+0.00%)
tw_twfw_egress               222327     222338    +11 (+0.00%)       10563       10564    +1 (+0.01%)
tw_twfw_ingress               78295      78299     +4 (+0.01%)        3825        3826    +1 (+0.03%)
tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       10584       10585    +1 (+0.01%)
tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        3825        3826    +1 (+0.03%)
tw_twfw_egress                 8080       8085     +5 (+0.06%)         456         456    +0 (+0.00%)
tw_twfw_ingress                8053       8056     +3 (+0.04%)         454         454    +0 (+0.00%)
tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         456         457    +1 (+0.22%)
tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         455         455    +0 (+0.00%)

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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 552840d8d2bd..ec10f9b896d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15570,15 +15570,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
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
2.53.0-Meta


