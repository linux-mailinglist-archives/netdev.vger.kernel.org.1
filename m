Return-Path: <netdev+bounces-289566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBg5D1moDGodkgUAu9opvQ
	(envelope-from <netdev+bounces-289566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:13:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF65837BA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 408C3304FFF9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D263446C9;
	Tue, 19 May 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gned0lzU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD9342CB4
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214405; cv=none; b=UVg7i/0KpRaTb6oGdo+2YIZP1A/npJZsGqO6fhTc+WFNQZ7+FntzmFM/IDDDiWr9mflxNdCOGIkav40Ibseyx69wN08GJzNR1Uzr6LFcNVkKFaZrOKYswxWAIFuKBMxjBxbcygv4cZdkmIx9VSP+JsrvvKGOGqHi8aMxVcBzcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214405; c=relaxed/simple;
	bh=QKTf9jiczeUt+Nr4S1iZsRKJwxGf9xWDS0EWw8cuyyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8eQOWrFsH891C9bOW62JSUUwisJxgOS6zTeMfXuSdoo+iPsoYTjCFBeTJmVmfPvm1XR6inWMKKlShr08+8qVpYNmzFHK5bqAihpyikWFZjJRsbet7Eh98uWTtqBVIeiUZA5cVtLs0WjC7Hnj2K9KR9zMdP2BEZJeVCyOtYjkSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gned0lzU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ca947f9b00so34773627b3.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214400; x=1779819200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlmyr3CMyFCWhDTHZENVmDr9qrkuvPXB7zyLVILmNsQ=;
        b=Gned0lzUYaamRrNaBxlsifW7Dr43eCrM0Kq/ngi2xm3omuL8UEfur3sbp3gV0N1y20
         yLZFXDamW/p+Aukizeq7xFMD++5lQsu5ZldVijCguMJwleKFxMALfQyb8y/aq3aJvbv2
         Vg6N+nOfXMPCYCMtfQD/inPKHaY0DSL9j/Wu9fYSLAkKyyGrOGfCymWqRp3ST6bWSW+s
         WVuPtwQEEDx5VKuPw34PB/k/DZBPlDdNpItQTBds1TIdjg1yYi6Ka2oOBW1l9M91KkJS
         BAQvjhGGjTSRHuDryOJ1sj2QULzUR1zyLPAGUPnjiTuXdCPlxoXjyVWE+LHcBeQi45S0
         wSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214400; x=1779819200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rlmyr3CMyFCWhDTHZENVmDr9qrkuvPXB7zyLVILmNsQ=;
        b=X5iaUheDOixODNJ5Pq1d6LceUU5crl9sz6GO+MUkfATaf+pPKn7o9aRhk4jHFBAIsJ
         CGRraWMPRv37JHZacVQhFplrZyh7PHoYMLW3GCUka7q+DyRogL3nKwiqHk/GuDZLtLCV
         K/SC+C7pLcr1CjhoQFzd1mNgxU5qT+GaGUfRZxmO6UgE1SL7DuZiGRLmmhVg5SMCldkk
         mm5nWGVsP0pyjhSvVwagIesA4VZfoq3tCOeUNI9BQgTpwj8WfgLTuH1kcBwN7zeBaOiZ
         yorAIQfzTlM6gaAMDK8igh2v4Kkp38FmqWnwtk4cGevjiuBRBaDEgC4FlaHTBujpV7Ra
         KfJw==
X-Gm-Message-State: AOJu0YyskbU4BAMAq7i0PEQ5z+qbL1aFKAvFWxcKzcvbP2vJtEmhevv9
	+39mJvioN0N8KJ9p5liJg1inQd/nol8Vwv0kxflOb48SOlyOa4ZiHip8
X-Gm-Gg: Acq92OHSdghnt/AE6CvrmluxWwMJuFAzWqTkk5LQYGwEYKbfy2ek1qJFx1mzTBcnrFS
	JxquR3PnC+UcPBazTzAria00zoGrC4rXlSxzd/ih7pL87xjQwVWvKBjFft0xBaWFLaRplO5x5XS
	zLGvQyaPeKA+aG4wTqqGUGT37wNS9k96DY86+oPaqi5aDktLb1bB4R9UEZg4NtE6qR+HfP4o7uf
	HWCVT/HMlbhVTMwft9N0KaNGHUs4Jyf9jzIrQsfb6y6819eFyzT+JAxMRZ8mLVehPVFmRGDUacE
	fZO0KTqldpe+vFew2NHB6EJ+PgnhS2crpmAoaRMUcViVeEM+hxZ/l69tM9F7FG3Uf2BxtYDBpb1
	qk9qa49kY86n5VSbPvc7DlVM6H3Cpf0MRsKsv2udFMwSUWHIMyhpcF01yOONfnfCYir7h0bjSH2
	6cPfu/RYb0ANolCc9j
X-Received: by 2002:a05:690c:c1d5:b0:7bd:6114:4264 with SMTP id 00721157ae682-7c9594b45camr191016457b3.4.1779214400424;
        Tue, 19 May 2026 11:13:20 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:14::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c9bd9sm40744567b3.4.2026.05.19.11.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 03/14] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Tue, 19 May 2026 11:13:01 -0700
Message-ID: <20260519181314.2731658-4-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-289566-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: ABFF65837BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Assign reg->id when getting referenced kptr from read program context
to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
referenced skb in qdisc programs using a new field reg->parent_id in
a later patch.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 564679f70afd..441950b43a4c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6209,8 +6209,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -6220,8 +6218,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
+					regs[value_regno].id = info.ref_obj_id;
 					regs[value_regno].ref_obj_id = info.ref_obj_id;
 				}
+				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
+					regs[value_regno].id = ++env->id_gen;
 			}
 			regs[value_regno].type = info.reg_type;
 		}
-- 
2.53.0-Meta


