Return-Path: <netdev+bounces-289567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID4BI2qoDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EED5837D7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C267730588AB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAC33F8A6;
	Tue, 19 May 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvTbbsCE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7F34167B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214407; cv=none; b=XnEPgSRYr5+usAQ8pH0vfIUWZO/B69s0grovj5t63F0Qqdkv0MBrakTyxPND+pAkqG1y0gXtiTub0GmPnm1nV5cpBRPBmRjejTehjvPFFpCj8/EHxttpmXNay/9yj6guSmY01bPaB0HxlH3/Mq9plbzAqNZIm3HAU8CQvvLUHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214407; c=relaxed/simple;
	bh=tZ51rEhjCGhsr01pIsMpJemlhH/OJfjo4pIBZJ8qjCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2n2Qp2VPnPvF0ddox4cxG1ZBRaWASqwgUwydEbQDF3S2DvKRFx81WXm0VA/DqhHOuArJNbTN/zLzfqd3V0VkPeZdpnD0jcMjkSJvTxwTFsxzbCefjtQHln1bTB3ESQuXWX07/Nh8n9B3dAxPUuoHVV5LAz51eb3wOZeQ+Ad9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvTbbsCE; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651c7ddf514so3635176d50.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214402; x=1779819202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5KuNnGRxNHLJT6/5Dkj0fTR1u1/jY83wU7OXw6mQ6U=;
        b=HvTbbsCEWzhJFVh1BVHXMiaLkJKofd9R26KA0bhWDdmUdP7ZpKAo2aiQBR+kYsHk2j
         aDhUMOrbiNadGm0hHC6JWZO28VmKjFHj9B6T+urtJd6AKP+ysaiCpBEMvrlkXMvB7C3u
         v+sa7HPoM0U4W6iWEm/MPC5eEMhhOK0b/xKHjyHwxORFILVC9owra6F6SizzueqAVSDn
         RtzXG3sIhJqS4QABdcPE+jOdZ2tn51JAu/u8oHL2kSqKthL8sZ2Tz0L1mKEEZz2cC5ZZ
         kVwXd7fF25K9mTZYulZPnE9brzsDyGv0k8MdXLHD8ZxCXaeA9I1u8GQxAOfQucoCnbrI
         iAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214402; x=1779819202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H5KuNnGRxNHLJT6/5Dkj0fTR1u1/jY83wU7OXw6mQ6U=;
        b=cy7cR7W6nkUhCQiJApIselYgbICdDXXlHoQTCUyhynuHInQ3CN48JTuUj4hwaWYveG
         GdxGbZdvdB/g+bBmH9DiaxWNyX7Y9HRw7bUkCu4MMqZD3MGyb9tjURc4ZH3fUg/bC0pg
         th/pc2KCiovfI4Q3e3LGsJxxHwpcp4da0qv+m+woji+de0rhr/0DgtnZlEWBQW8NdU9N
         NqN0TjyYH2mpDNiYo73tGhu7VdbdP6a27GURFwKCSvXFs7AqLyi/jgzqKJVjx0h2jELt
         yNF44Au3FJtwAT6ijqnTrIXTdOt6Q+foaJfCBLy7jQglPvG4kgWNfy6Y3Fj1wkPTFrf0
         U5Vg==
X-Gm-Message-State: AOJu0Yz5ZMN02XetKjAtaFAMYhfWVUvpHZGsKK5BwlkZB/Xk9/n4rQPz
	pgJegBdapxRdrdu9s+T9VyuUfJXm2+1OeftpMVhF69iaIGpyJNEIjKAj
X-Gm-Gg: Acq92OFxTKfoGN4gK5K0DGxI1TxIaHZpVHoIcIkfrDs5I+nWoq35lx+7czmgskZ7Ozh
	9kxLWgP9Q94PmjDyLRYP9pW2nWy018/lVK+T+j7uazNw5MRGNKxF/aFQ2XtbzIh5NFpTFG6ktzU
	qwV5weUQ6DJPWz0kt978R9WHoWx/MLiiyplMfJLwV0XbubQo/kJGSF042fO+weIjkft/YIOBq+w
	WZNM9Ng2GYmiwmy8lhoYyRGn6kKOi+b/yXwjj9wyeA4newOP0XEGsXANnlsfafmNHUw/eu4CQ++
	+bP7JffzPhlehEIm9KLOUQtIzRLY9LLNeYedJTg0s0mkSjqredetnNQkVNVV5FT3p3czZB3eYxI
	sppAosglKD9Xt+1UQ0BnvN6idyHn0iIyXYziVOavKxh5rBM9S+lMc+H3y3bhnc0JOMY4l0aDf4T
	5NOOBnZJ4npq2LkjnD
X-Received: by 2002:a05:690e:1443:b0:65d:7d86:7758 with SMTP id 956f58d0204a3-65e228796fcmr19823501d50.59.1779214401905;
        Tue, 19 May 2026 11:13:21 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:23::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e7585sm8236767d50.9.2026.05.19.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 04/14] bpf: Preserve reg->id of pointer objects after null-check
Date: Tue, 19 May 2026 11:13:02 -0700
Message-ID: <20260519181314.2731658-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289567-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 07EED5837D7
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
index 441950b43a4c..753681b0a987 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15524,15 +15524,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
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


