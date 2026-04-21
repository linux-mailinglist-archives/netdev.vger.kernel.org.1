Return-Path: <netdev+bounces-280260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDeHEJL252kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:13:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D9044007A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CDAD3084F25
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E913A5E82;
	Tue, 21 Apr 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV/yELyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913523A4511
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809423; cv=none; b=c87ePUoLzugQFYQ4VkhwDYPPxicog4whHyeZ+WLjVnIfWd/Gg3djLBVQ5E4l6u2Ngd/meL9KId1TmGMbGV9dN7HQEpN9bOKzeGZa0iR/PzqBy/75MH8eOFemFOF3sboh1gbql8rmr8+1WhS2EJIG1GFgAbx/M9UlgtZ+X29U+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809423; c=relaxed/simple;
	bh=wEKBaIcZaGICrYDZVcwKG88aZwiyYV2sOSwemrrgU9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRVEne9to6S157rPgSSTtLy0YYk713emr8SrkHLxzySSU2jKljutApdSz5eKTzmNSfH1CMmiRp9TvOfSH3ZIQbyOCnBsEQuTl2kVBlxRCkxjW7w9NUgQoKAqqwMnzv7zGEtx8WZNdKSDUqESbhIzo8QcJp9a3J+bIcwWATsYWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV/yELyg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so4546535a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809422; x=1777414222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7WtMgyARQCg7ZvW2sjb3ATztaa73Z76UTWHf0LfROQ=;
        b=VV/yELygwRbKG/Rz4sferm3bhZ43+irooREgDSffJnJTDvPQ7+VPoomkE6Q8LHt8e+
         wNEspZdm9qdP231USPE8FKeCrSiwIUsORnkQU7yZ+D8/PgjUMyQCYptTVlqiexcXnBsv
         i7sXYpwm1BnAKMUmOdy5FdbjDWSMh5zoFZgvZdWKDRXtiRA8gWMWD4GJnk5TJzj0x1BW
         Lw8gaQOFT1f97YzCKs4lUiDeOQIpF+FJEo3aE4+CVvpZNzSuQmXO/JdHOqq2JHoFZqMh
         aAEX1BZb5QYdUSY/lEb2IKzzqXsnoC5eCmlvsh+AVaFX5bu/oLBB7BsOQREfvmTw1hXv
         W8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809422; x=1777414222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7WtMgyARQCg7ZvW2sjb3ATztaa73Z76UTWHf0LfROQ=;
        b=PFzrWb43F0CHQqfFmZPpAbV7KJU44vgjmzP599cbuRGuwqaRGAs7SrIruxW0+viZp5
         KdAWTGuD6LU9J39DHscTVh8dBwz/T4yTSdczvg2zuPT5agi5VG25bWTw4KU6bkL3uMz/
         +38/S/QgSiB+emf1wmsUANfh/UEopTxlmIbcTMO7DHbRLk/T9YWrJpytKWbVfBT8Nau2
         4OVK4JK4Tf2kDtBN4RXubVAkJe69iCyBHQpXv6DV274H8YiAQj1pUieP3GbV9Tmf2Hgi
         TzSnVrG+e21aMVqIYwXVRu6GEGfnK3UCSF98ry3c7gx5Wy0lKkl/LDwZf/In83zvMP8L
         QLMg==
X-Gm-Message-State: AOJu0Yw4IVy9xDP/suUerPNn7sfnjzTQV/jn4wMg4ZIqUjmXt7J2WMUY
	u+qoOsexyo0NwuCO2mHttFaTw2eOmZanWaLq4EkecVsCCHOgfInNKNmN
X-Gm-Gg: AeBDiesxtiQJV08bZlPcsR6HHdDrDbV2+Jd+wj86KdNbfQeI088Lm283Qa//Jgr7FO4
	UhhowBoybq7yOZXEYOFKdJtd0Ubg/czht+mU67Vj13WLFc2x9YgNxXOWkHd8gySop9kturLkP7d
	25BboIqGb4SmEbsw/EEsblnJxfOAStlUisWaIWHG8K/A8DQT9Gkp3WSFD6qugSPxSaqoUMeIKya
	eov6J4StvFuAAw7F9Towo3xbMD/9CHME4v7sN5eG/oKLhglfWll3XiOtKX4+b11oRZjPD8p96fq
	X8B7MyO889F3MytS+CBXZkDZIiOV4d72z1PRXsw2cVq80d2fRAdU+FKzGJh6AtSyMWeQuIIiKcL
	dElOow+uydTNEFkhht9c8d6XLai0Ab9R0spxbwYh6EUtDtklVfPgDFroZUbxuFYgZp6zJk/+XDZ
	ztIgVyTYc9we5+q0lc0G8M86Tu
X-Received: by 2002:a17:90b:2fc4:b0:35f:b6d3:da7d with SMTP id 98e67ed59e1d1-361404635e6mr18770341a91.17.1776809421976;
        Tue, 21 Apr 2026 15:10:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fab1c32sm5688614a91.5.2026.04.21.15.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/9] bpf: Preserve reg->id of pointer objects after null-check
Date: Tue, 21 Apr 2026 15:10:10 -0700
Message-ID: <20260421221016.2967924-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280260-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0D9044007A
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93003a2a96b0..0313b7d5f6c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15886,15 +15886,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
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
2.52.0


