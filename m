Return-Path: <netdev+bounces-284876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK0RJzlQ+2lFZQMAu9opvQ
	(envelope-from <netdev+bounces-284876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD694DC2E8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0073300827B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4348096F;
	Wed,  6 May 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0MBuTuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5392480359
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077641; cv=none; b=nZuw0s7KZJvPccdURXW81PJ/iIyS7HxbHiNhk8sgMnwnkxy4YJQpMbYaE6qowJ4OCou4zPAlJCEze5jEvgx0JzX+9Dc+N7YyTV9efxgjVOhD2UHU4qYqwcFasbeEHrCwpGjntMpR8C+MdJtZ0JzomZC1WyG38YP1etPGoFWgc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077641; c=relaxed/simple;
	bh=wmdUGf/93UtDgB3jPl4ukhsU5LqgxbxRvydj4y9Jy4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBDdTW2WcDrtpuWRwOuV0IO4e/waRvtxTRw+XeT4OG1fxB6hiMX5xnekCYN/loWbNNljh6bC3/xyAbS0b/6zBBvG1LN2VH/8jkEYAcPfuAPvCuLIUMaXLh4QVAr+lB4Xx+zuDZZyLLUf+dbi+FVCFOYWdlyjdm6+Ehr+mRK/zAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0MBuTuV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so11080516d6.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077636; x=1778682436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M97x8+tCYMnMtmQ9rpSLuRG7Q0JR91etii+VlH9NO4=;
        b=M0MBuTuVhBJLMzU0Ozanwxnt5qjFGcrpPjJnZLkHz5VtyhIvZ8U5V656ZnKkWAuPNT
         V5GD7q3JJ6aRynnvPPWaA07dEBEWO+iQRTtcisjCFj6IqAkcqHEyHe1kMRfzXjg194TY
         Bx3BaSjyUeZkm4GfyatgZp6wg4Sy9f2V+QQRDQIK50h7sbDC/LKukXqmxEav1J/lqkTK
         3dqrn4LkDGgAzS3cWI3i4NQiXR8q1sTIxbD62T58KIBmbM9Zca3imMxVApsDF6T1VuWg
         uKpyO6a6Cnhs49tWVUsN7DSQnc5aFcEyKWHgy/P0MbMT7Jji220qSlYAOWwPTHSWzqcM
         Eqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077636; x=1778682436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7M97x8+tCYMnMtmQ9rpSLuRG7Q0JR91etii+VlH9NO4=;
        b=fz3oKkhdOB1X36BAf2iksKgy53zehGhHLMNzCkaSuWAWldwnCyn9w0PXtf061XTXWX
         f599J+/v5f76ph7QpiEqbGG6ac1HNhBYC4xBigrlNohBAsHJSHazGKcTG8FrOT3MPQzs
         xv2mpMevMNQLAbK+DGD3izUdM+HYZ/QXBmoWGRgp1BdryFhirP4yGUeuL8VN+LWhR8Al
         uOOPDrBVHucofanHrsuC3P4x/acJbYMktpep66M704sJ/AtK5kLgPQsNx6o0n1RxUOgy
         ERvjd0wD98jZdh6vuyPthoMJ2uA1mdYDtOpV8dfE2jSKLYOynoR+XHo9hJaSMqrnPjKm
         Awmw==
X-Gm-Message-State: AOJu0YwbYxeGg2tSN/bHSZB9cZHh627gg5G04UOA3mEQLRNeOsdsUUjR
	ktVelAiGM7ycJbev6ckPQkw77/SBLcWTNCttpV8AdzpLpSqzk8/c+wbE
X-Gm-Gg: AeBDiesq8+x7IEcOyuUGI+WAM94Jau/Fi1/usM8gFRcwQKyPfVpT8hgyf8zlstTneOW
	s+XLjxH+45IRFDNF0WVtSwTUAobEW1DcnSvYs8XhmEq9JzwsGghmUY0WZ8VZ59MFotMBtiJxXsj
	TLN8ou/k8JqI8KoRtHerzQHQTt8ybonQUkBa19IPidvQRGijILbm2S701tNhRW+BPRpYiF9cFKg
	gXhH11Cg0VlJ5Xuidt6RG100wg2uCbvR4XS4FT3JXSHLByu7GMV/mE5Y+jwjirpvNzbF6wNyYL9
	09E475K26KKg76gQ829Ib4C3khXj/OyN4amei8r1CRGvVWhzzzESggmPc5qQ/Qoo3qr5Ql5wKv3
	ZnRxyLBeosV3HqKLjs993DxPVdyulTBpVSr8fsru5xquQ71ZnwihdfBuTaYXWinFFYe3erJTdQD
	EsFgFvoM97Z2EogRE76j8Acp+x6hE=
X-Received: by 2002:a05:6214:1d2e:b0:8ae:61f1:c562 with SMTP id 6a1803df08f44-8bc41bca521mr55140206d6.6.1778077636160;
        Wed, 06 May 2026 07:27:16 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:28::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d953sm204888676d6.3.2026.05.06.07.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 03/12] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Wed,  6 May 2026 07:26:59 -0700
Message-ID: <20260506142709.2298255-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CD694DC2E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284876-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Assign reg->id when getting referenced kptr from read program context
to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
referenced skb in qdisc programs using a new field reg->parent_id in
a later patch.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0bee6279c38e..0891a3ac4d51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6057,8 +6057,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -6068,8 +6066,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
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
2.52.0


