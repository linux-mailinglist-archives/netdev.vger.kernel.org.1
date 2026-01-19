Return-Path: <netdev+bounces-251325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33082D3BB00
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EEB530389BA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F52F745B;
	Mon, 19 Jan 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEPw6LvR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2223B604
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768862665; cv=none; b=kGcAAnaoAG8wuR/0NoOMMBPPLRFwbJJ8uDMZgcUnPyvPlF3DvPuqsdBRyvDKZdFu/t0yJMd+dxxu10L3TQ1S2kTc/wgkS6zIU/ft637I7kffx6DpyO3nfk3vnFMC60a5dVYjqUD819I5RC11dQjYaGhM8K4fQdwAd7HmBujJzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768862665; c=relaxed/simple;
	bh=FmshIN5A/YVEC+mUsj/3m/ydooR1HwlQS9LBhIM+SvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V01wJ3zCO7syLd458OnpeG2PfQOss4ls1g/E1UFk30174rynA8cID+KgD5j3rsfLJ2t0/CqyrBCstMso6l5eC0Uv+BYB3dorhDgZhAekztGbsIz7HaWm+7MuxXLECtQn23FSbM98v+OR38BKN9sCl/Xju4UcWyrYnmOCLl7iy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEPw6LvR; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ae61424095so4822907eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768862664; x=1769467464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Lc2k50PSIiEpv2u72MLsEoRCul5N0lZhclypIqJ+Fc=;
        b=fEPw6LvRnu5SE4Zz+weMx9Av6c8zFzMUiRJPLKXueZ3jrdURv9D38gAhqvDevMjLSQ
         BGnYJ8Dz0e9c8hzFClfqNIMC+ntOipne7IEttY5OPHU97z47+hB5tgtnqKKU8OOgMbcV
         dFnGK6wvKcWwL9CZ/wLER6bEOlWm0c/w7rBxGQ9/jPS+7zGX/XE451M3wNmk6y/erhsA
         RbqKll3gxfWHa4JrLrq7efZpaCOFER2A9w6fUuuX7v48lJWV5MH8u1RMg+v7g8wLCAdD
         PXVIPivgSNBc9OLkJJh2QM+UDSuA+yMGAmASsemna5wAtHRLR2xowfaLBLBdcKILolh8
         cMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768862664; x=1769467464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Lc2k50PSIiEpv2u72MLsEoRCul5N0lZhclypIqJ+Fc=;
        b=iufCoWdEBwVZUk4KkHuVm3FjDdz4pbjvcE6btAU2aXCFB20SCTh/TzuyOqXpWjzPpn
         cPjs7H2LCP7f6LX2zVkvff1BLtioMfydKPMjEPM6jPd2jebmYyNoFLuZ1A75HMwXODR0
         aeWQbHagvMAym3ek95GTk6BpU/ccczfa5xr0tFriwdUS3M44IzNOgwyx1YlQGjd11eKD
         Q4QmRvJzFSr177wS/ZY8Qxs+BGN/NonCXaf/mHbSt3XdycnMzzYHMw0bYENuGGNyDDDh
         rtKInWH91X5WBbQ+RyN0Mfkf8ICNGVRG+0qgJayKEJoE1zyNs9NFqkNql0YKdgTuqZ3P
         AtGg==
X-Forwarded-Encrypted: i=1; AJvYcCXMWlLuoXxZdpUMa9NgorZ4UEuf4btQD/5deHuYix9Pq3NVIoILwJu7z85D4NypuZCtUxFxQNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe73bgASddTq0xK3ivHVJ+gdtGzP4frkg44zyVCfza51pNjJnG
	gZiOuF1xbqQNimjJUGIa07+Jol0ea4SVWzfL+ksg9pGa1faQBWzQq2kiB7JeoJ8H
X-Gm-Gg: AZuq6aLUYuxWHiv9P685ploI3nzV3P99oK6jtMi5mU3j3vNek70I00DV4KFHf46Yx2a
	ujXqgttiILfVmEMDQx8eH129pGiXT0VbB8IyEHJSLMYlReguRHIWS3PtvruTUh5bMgZ1g8zdS7U
	bRcpZ5nrw4WDRl5o3Ow0T+faBOpL4bodHpUntb13bHJEXXzJ7f6T8C2ccnqKIevhnT0gGXIQTOJ
	MLvKlCfqSdeFIftDdOldBuAYZ6dKr/K0GQTYRCipV9XaJPyCvawsTUlkGqVRwj9goO7IbwPisXy
	4XGKR/v4n6G77e8z9Jb5rpqnnHS8W+8y0+7pHmxmDaiN7VfVTzt3IADQzFAYH67NOsPxxdcyjAy
	wXq3mrXCQM40iVV0tYvxfx0+ILHBBEHoaKxa+i59lh1b/PR+dUFGFSJavmoMSEPf5CFwtEMW13/
	50I1Jb7H6FExVJUlgVxqR5P3YjzSrvdbS1DzuijswtrUfo/1u6II3yu9b0tqbQxIIelK8FxCDZg
	0qP
X-Received: by 2002:a05:7300:d0d:b0:2a4:3593:c7ca with SMTP id 5a478bee46e88-2b6b4708303mr6822414eec.10.1768862662009;
        Mon, 19 Jan 2026 14:44:22 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6beeb4b9csm15564581eec.30.2026.01.19.14.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 14:44:21 -0800 (PST)
Message-ID: <f9ffbb877c73e5655fa6cfc4480624a320fcf94e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf, verifier: Support direct helper calls
 from prologue/epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Amery Hung
 <ameryhung@gmail.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com
Date: Mon, 19 Jan 2026 14:44:19 -0800
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-1-e8b88d6430d8@cloudflare.com>
References: 
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-1-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 20:53 +0100, Jakub Sitnicki wrote:
> Prepare to remove support for calling kfuncs from prologue & epilogue.
>=20
> Instead allow direct helpers calls using BPF_EMIT_CALL. Such calls alread=
y
> contain helper offset relative to __bpf_call_base and must bypass the
> verifier's patch_call_imm fixup, which expects BPF helper IDs rather than=
 a
> pre-resolved offsets.
>=20
> Add a finalized_call flag to bpf_insn_aux_data to mark call instructions
> with resolved offsets so the verifier can skip patch_call_imm fixup for
> these calls.
>=20
> Note that the target of BPF_EMIT_CALL should be wrapped with BPF_CALL_x t=
o
> prevent an ABI mismatch between BPF and C on 32-bit architectures.
>=20
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -21867,6 +21880,8 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
>  			ret =3D add_kfunc_in_insns(env, insn_buf, cnt - 1);
>  			if (ret < 0)
>  				return ret;
> +
> +			mark_helper_calls_finalized(env, 0, cnt - 1);

Note to reviewers:
  `cnt - 1` is because each prologue-generating function does
  `*insn++ =3D prog->insnsi[0];` in the end. Confusing every time.

>  		}
>  	}
> =20
> @@ -21880,6 +21895,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
> =20
>  	for (i =3D 0; i < insn_cnt; i++, insn++) {
>  		bpf_convert_ctx_access_t convert_ctx_access;
> +		bool is_epilogue =3D false;

Nit: maybe rename this to finalize_helper_calls and untie from epilogue_idx=
?
     In case someone would want to add a kfunc call not in an epilogue?

>  		u8 mode;
> =20
>  		if (env->insn_aux_data[i + delta].nospec) {

[...]

@@ -23477,6 +23497,9 @@ static int do_misc_fixups(struct bpf_verifier_env *=
env)
 			goto next_insn;
 		}
 patch_call_imm:
+		if (env->insn_aux_data[i + delta].finalized_call)
+			goto next_insn;
+

Note: This jumps over env->ops->get_func_proto() call.
      Which means that env->ops will not have means to specialize
      helper calls inside pro/epilogue. Not a problem at the moment,
      as the only helper called seem to be 'bpf_skb_pull_data' and
      it does not appear to have alternative implementations.
      Something to keep in mind when extending the code, though.

 		fn =3D env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
 		 * programs to call them, must be real in-kernel functions
[...]

