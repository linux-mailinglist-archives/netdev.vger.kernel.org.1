Return-Path: <netdev+bounces-261594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF0/C7W3oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:14:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB5A1AF8DE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82D9530457F0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E7847799E;
	Thu, 26 Feb 2026 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NeGil4Gd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43220466B74
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140394; cv=none; b=qqMz6Mr3AplVKT8XRoExLh8Q97LN0FxK47+KK0cn3L4emvqfbtrIUS3+Dp5bUliSYqguK6umAq1F6FBmkBPMZNoBzuAgBsfkVVDB3EGBZvtlrjuMqvPwMrluy5coyoRluLCl9GbihKakAfZFDA2F53Tw/D/j8v17boH5PlC8e6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140394; c=relaxed/simple;
	bh=MdmSDav4rcCxffkav5Qu4BE2w2g7CdGRYopbzgn1MNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkEpU11bDlYQ7r/e7SUIjpbd5usActX8KAMFbyuXN/no6iKRhPKCeifUozOTN5PRrbuuRcv/3vGQmbzgvUBL2WPAp36HLjJaCCNO9Lv46zyfUmUYDKLpLNT8ZCQZqa2uzPPzkVgcrhT5jo9DOk0bLungImGEg/KEmvFCMXCEoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NeGil4Gd; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59e4989dacdso1733674e87.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140389; x=1772745189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNzGwUdZ6+knZ41f6dzJzlNu6h5Ekihml2eSy0ufkRA=;
        b=NeGil4GdrU1TPRl3uXdALbyQVgrwZ66TZlrxCl4BTEF+ytJyRsbuVLH7G05XwkAWfv
         RJoNHnd4ndh4IMtASBy14HfsYwxjzFmJUycAb9Wa/7JU6xLPUmLPi1FctLWI3jyfbV4z
         fBHBkDIelyeH+b/yp7zdpHnChZAVhE3j/zptbQfEVlfVf4AVX2aCSY5LdZBQ5F2+7Xr3
         rAAmg+FUMuBdhkFKryQ6wt2ESruPdOEEpCIAcDirjX9jP4zJr+Klx6Yw5PhCLL7+Jc9c
         9440Jq0pOqbkSHLEzdBv7BCJHoC0c7/KvP5UG9lSh0AOglVvr6rgdga3obs24eBcrkaN
         5cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140389; x=1772745189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kNzGwUdZ6+knZ41f6dzJzlNu6h5Ekihml2eSy0ufkRA=;
        b=RDiR2K2BynjuiKCK8oPgz5Fz98lge7Xsa9Qv+r/tHG+m4YokZHiW8BGXoY+buE9p4+
         Fb5zf22ykdbm5nifSMwFoE3YCzsnB0gOmPBSFKzgP4ueAfc3J22se8ld/bfqCN1bhZJ+
         RRTZdD/rXw6m6dUEyjzqp/AqhO31mfh2O1N+bJ8/sUVIN9ocexI1s4FZuRQy3DJP9HxT
         V0ib5GDo8UaansDDd9xPe6P11dYf3AgWxy8jNn8+X1y5k1URKlVROAOD/6Iant35x658
         2vYkkIj4kts+fRJBm7huRrJGU46UYocHHtzOBraYhlw17TMVUlUZRIBJs7ZSwUdrBmi0
         gdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb1poH5Dk6QPlaBka8El6Wf8moUd2TrH/7nvOJROVf3Y2DTLo3BNlNWC83ycSpvjiIHX+81iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1jtj4LJzUlyiXD4URkFNozwGJmCOATIUDbdnzEUP6Ou5d5W2
	oo2A8DwPOTJf5SWPh2j5dSLnXhjjKZ9C/CSxz6oaZ1+EmzLSkVcLthebd8g/71Ok528=
X-Gm-Gg: ATEYQzyf90PrtfhviX2cqp4skvyJrDFxULAZdEP15uq9/Vb845lmSntgqZGLsE2g20C
	2T0wwHS2HNib+6nmgcCrrnIiU3LDNT6adGLVukgu+krTCrNv729pVhnJ8HFIHvlTaNKcmAasdUi
	eDVuAq0/o9R2xbVQ1Ot9PUa79C6NnUBHsjhW/1fcyLrAj9gFzUzMAcnoAfnEIOUNf/E3/UhxGM2
	sJnf0YuE1oSfVCvNHbJvPSnPjKw6+vFLM0pZtqySYHJwzthy87yowvtSjzqOT2qTsT9LdmpzSSQ
	GGNdxK7knzF1JRyiqhQZ5SPo+HEj3p2BqJmjCJz7RcJYWkanZ03x4spuJXql43OJfF9Wy/wmYsc
	Rq2PGVelUtd6dA01reqQiT0MeYCFrnMBbwGNpW44O5el0LRt8uYPilWqm8fxou5NRtr639WQhLk
	oA1LzSETszFvxfSjFXIl+BCfH55GxIYncqomHVqPnIBhPI4NzAo3zmeNxlfGNa5MqdjPf2
X-Received: by 2002:a05:6512:230a:b0:5a1:8b2:853b with SMTP id 2adb3069b0e04-5a10ff9992dmr162991e87.12.1772140389208;
        Thu, 26 Feb 2026 13:13:09 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a10f78f3bdsm371061e87.14.2026.02.26.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:08 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 26 Feb 2026 22:12:53 +0100
Subject: [PATCH RFC bpf-next 2/5] bpf: Allow passing kernel context pointer
 to kfuncs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-skb-local-storage-v1-2-4ca44f0dd9d1@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261594-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EB5A1AF8DE
X-Rspamd-Action: no action

bpf_cast_to_kern_ctx() returns a trusted PTR_TO_BTF_ID pointing to the
kernel-side context struct (e.g., sk_buff for TC programs). Passing this
pointer to a kfunc that expects KF_ARG_PTR_TO_CTX fails verification,
because the check accepts only PTR_TO_CTX.

Relax the check to also accept a trusted PTR_TO_BTF_ID whose btf_id matches
the kernel context BTF ID for the program type. Introduce is_kern_ctx_ptr()
to perform this check.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 113e2eaec4db..017071197466 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6474,6 +6474,27 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg)
 	       !bpf_type_has_unsafe_modifiers(reg->type);
 }
 
+static bool is_kern_ctx_ptr(struct bpf_verifier_env *env,
+			    const struct bpf_reg_state *reg)
+{
+	int kctx_id;
+
+	if (base_type(reg->type) != PTR_TO_BTF_ID)
+		return false;
+	if (!tnum_is_const(reg->var_off))
+		return false;
+	if (!is_trusted_reg(reg))
+		return false;
+
+	kctx_id = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
+	if (kctx_id < 0)
+		return false;
+
+	return btf_struct_ids_match(&env->log, reg->btf, reg->btf_id,
+				    reg->var_off.value, btf_vmlinux, kctx_id,
+				    true);
+}
+
 static bool is_rcu_reg(const struct bpf_reg_state *reg)
 {
 	return reg->type & MEM_RCU;
@@ -13495,7 +13516,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_CTX:
-			if (reg->type != PTR_TO_CTX) {
+			if (reg->type != PTR_TO_CTX &&
+			    !is_kern_ctx_ptr(env, reg)) {
 				verbose(env, "arg#%d expected pointer to ctx, but got %s\n",
 					i, reg_type_str(env, reg->type));
 				return -EINVAL;

-- 
2.43.0


