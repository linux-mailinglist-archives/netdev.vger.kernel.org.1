Return-Path: <netdev+bounces-245455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 753E1CCE18D
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 01:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 378C33031313
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 00:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE321257B;
	Fri, 19 Dec 2025 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqFz5/QJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C40213E6A
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105753; cv=none; b=cMQyURQTqeTctVipNT4YCN/n7aRAvOpoYQltg0TlMCBns38V3yMAMu7nj3QdizazIyHCKpw1m7ilB6f2m4i33En9q/82zr8BtJaE6KVTA/KF0bUob2icFUEDqk/lNfy8+doveZi3k+wGx17h4yL/bYMwAaR00sanyVcJVehJxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105753; c=relaxed/simple;
	bh=4RAcodl/eGdtET8fBGuXT6g4azXzFiM8IaG2uTunEu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnTh/IZtkxXOWLv9crh5pAMihPs1cO53Cp2ikrzuQv+p3HQj92x7l6dIBSYYtYXvJMrN2QnejE0y9cep40WCedAeZRu0z7LAo3DIoTPUVaABPTqsGs/zf16qZrFxsWKsPr+Eh61KXXvUYgCgTS1H+TKgt7I1jo4BZNgbNL7E8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqFz5/QJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0bae9aca3so17191035ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 16:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766105751; x=1766710551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpn2QUmwDCR998TnoC/Xpytkga++ENlSGhiL5c9mOTI=;
        b=CqFz5/QJ7QNwpZ5P6krNpCzeuNqUtu4U/wN2M0ktKP1clBzAuOJm2CundKN9l31Des
         KYlscm+y/KAoZaoBtt2IeJ6jgizIOUOf48YON+smqw04gVygj0mBGyYMu1PTrgpII2wv
         u+ds1BdlrywGm4jQpAzF1xw0yaNCLfk/HErdtvUn4gqg3OvCi8dbxFEpatXNodTd0oLC
         y2HW1XdmGgnh+51jOPVVioTj9horIhbgzCaC6jw6fNwvno0/6SFR3IFo52vEDBPoGn67
         kSPsWPZw5UH8ayUVmY7QJjaHaipFHshOKIFy1nLzMgx4i/u/4lOZDEA+/j8crL8A8JMJ
         /lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105751; x=1766710551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rpn2QUmwDCR998TnoC/Xpytkga++ENlSGhiL5c9mOTI=;
        b=fuMNa53bHmYjh+LUDjjbIJzUdwlRXs18AJE8cqr6OA6KM0VoJ+dGrGI2/pS5c+DKfS
         cb25k7OUv790JKuN+iRuUrZ/0ZYpLkpM4FLiU5CB6xwqvmspgI82HsqAlDlMZ10RqwlE
         I/ZArl4gkf4N3hh+Cse1cdrdgd9XX6Po7h5XwAo/ieFczXE8SjxiYtqcwnWDQUS+9Xas
         itEHLJgFNufRgLFjDipi3IARhqjxltl1P+0yMCFetoLpfHCb6r9FrQRVH/rB36y46UNE
         cKliadEDOxxuuh1sXikD7zZqAvDFzp2dfQTX6nhisvDt70+iJ3+Gofzp/ClMZZ8YoshU
         /g1A==
X-Forwarded-Encrypted: i=1; AJvYcCUbW+FNN+HT0Wo3Nb0Wi/QEyOGqd9eGCXInt23+F7TfhZk3ghDLIG6MmugC5Wpw/Oi0EPnfspA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+UTvshY40aFRjGfbYbel5cVRoiVg2M2YmPFnnIpOVIV0MQA1
	ig0zAmOAHrzjKNVYD83V5bJebzl9UGbT3NpOWLp8t1SVkladHibHWRr4XabX0qAGAlmVq5ME8oK
	/rvIjFc1RLC05/EM5/K1MFa4E38bB9ZjCWA==
X-Gm-Gg: AY/fxX7blMQB3+PXCCmdtpRwVLoZs/iC5EO5tvwyBi5u2g/ClyUXOuc10zVFK4NZiFv
	yJrqYMOetFiKDInpRTLsCVeXdiLP1PQlw0Nsnk6ryYMZwDMq5omKkxZ0JrAqplQYGQbvr5upbYz
	jhxr+da+tv9odv6f34SSquR2w7/jIuKstXq74F4c42TCDDnSa5xnFsvOt7Bv/evCc56S7ZJyETC
	9M5IKCuZRcuBShO4JGyxFdyYrtw/iCEaMIrIIqrI830MloHw/5u/F7WXquhwm7i0n956q5UzO5a
	M6tJm9VNOAs=
X-Google-Smtp-Source: AGHT+IEHPAchLPH6E9v6GclE3i5H+4yvKyuvCA+lJOJFU6TjF+jp1U+Yeo8B2p3fUMZBlSW9Y15AkjbEG3qEngeLQJQ=
X-Received: by 2002:a17:902:e884:b0:29a:5ce:b467 with SMTP id
 d9443c01a7336-2a2f2a4a3a6mr11924335ad.54.1766105751181; Thu, 18 Dec 2025
 16:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217095445.218428-1-dongml2@chinatelecom.cn> <20251217095445.218428-5-dongml2@chinatelecom.cn>
In-Reply-To: <20251217095445.218428-5-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:55:37 -0800
X-Gm-Features: AQt7F2r9N-0i9m28FxGDRSRN29gGIWrcemvOQAYyxpWW0qMiJLfjzEipD0SBC54
Message-ID: <CAEf4Bza=Cuu-3LZs7XuK-d7FLKAU8ppkLneiuLqDejzfweHqqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/9] bpf: add the kfunc bpf_fsession_cookie
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:55=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Implement session cookie for fsession. In order to limit the stack usage,
> we make 4 as the maximum of the cookie count.
>
> The offset of the current cookie is stored in the
> "(ctx[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF". Therefore, we can get the
> session cookie with ctx[-offset].
>
> The stack will look like this:
>
>   return value  -> 8 bytes
>   argN          -> 8 bytes
>   ...
>   arg1          -> 8 bytes
>   nr_args       -> 8 bytes
>   ip(optional)  -> 8 bytes
>   cookie2       -> 8 bytes
>   cookie1       -> 8 bytes
>
> Inline the bpf_fsession_cookie() in the verifer too.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v4:
> - limit the maximum of the cookie count to 4
> - store the session cookies before nr_regs in stack
> ---
>  include/linux/bpf.h      | 16 ++++++++++++++++
>  kernel/bpf/trampoline.c  | 14 +++++++++++++-
>  kernel/bpf/verifier.c    | 20 ++++++++++++++++++--
>  kernel/trace/bpf_trace.c |  9 +++++++++
>  4 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d165ace5cc9b..0f35c6ab538c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1215,6 +1215,7 @@ enum {
>
>  #define BPF_TRAMP_M_NR_ARGS    0
>  #define BPF_TRAMP_M_IS_RETURN  8
> +#define BPF_TRAMP_M_COOKIE     9
>
>  struct bpf_tramp_links {
>         struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> @@ -1318,6 +1319,7 @@ struct bpf_trampoline {
>         struct mutex mutex;
>         refcount_t refcnt;
>         u32 flags;
> +       int cookie_cnt;

can't you just count this each time you need to know instead of
keeping track of this? it's not that expensive and won't happen that
frequently (and we keep lock on trampoline, so it's also safe and
race-free to count)

>         u64 key;
>         struct {
>                 struct btf_func_model model;
> @@ -1762,6 +1764,7 @@ struct bpf_prog {
>                                 enforce_expected_attach_type:1, /* Enforc=
e expected_attach_type checking at attach time */
>                                 call_get_stack:1, /* Do we call bpf_get_s=
tack() or bpf_get_stackid() */
>                                 call_get_func_ip:1, /* Do we call get_fun=
c_ip() */
> +                               call_session_cookie:1, /* Do we call bpf_=
fsession_cookie() */
>                                 tstamp_type_access:1, /* Accessed __sk_bu=
ff->tstamp_type */
>                                 sleepable:1;    /* BPF program is sleepab=
le */
>         enum bpf_prog_type      type;           /* Type of BPF program */

[...]

