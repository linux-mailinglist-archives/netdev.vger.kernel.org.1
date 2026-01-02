Return-Path: <netdev+bounces-246627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 684F0CEF75D
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 00:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63C43300C140
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 23:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C1B2459C6;
	Fri,  2 Jan 2026 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+jbDLYR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865831A3029
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396084; cv=none; b=rwM8HqeDWLu1NnMYUNKM9TIy8uvh67DruozSpPyZVo786e7yMrzU4oepF31Oqk2Coyei/cWV9GorUnflGinryTEi9IbGzCapRBl1wZAT3hLGUJhDuiLbEWSZdWfPpOwJJNahbrbMEONkszc/jxD+L4YSbPSKILk8OJ5oTwv6fE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396084; c=relaxed/simple;
	bh=LODOdPKPxdr1EwABTQ3putGhvukWY4XVL+VZuH8DKwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkMPuv2F51EE/UyIRS0Tpj9LTfxZC1Hr4BytKtZWVJ4crUkObhDGOM9PWyqBNXmg41ImjYaHwI1+wLAcRQV9lL4IrhIvxA5T0km4jXXMhQpLN09kcn8CFZ5gtMbFjEazllXrWDQOQLWLMqUAJvEbXdQ59rOC32sKYS+t32REA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+jbDLYR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43284ed32a0so2578345f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 15:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396081; x=1768000881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0BCkqrSr7+3s77zFvT5FgfHYyteD50Ev53ENDz7yYU=;
        b=D+jbDLYRM1pUqrv0zsLrroYNl04gQC/HyU1gZ63dDDRW8dwV6oon0dEqWxnLdjZyaY
         tyAbl1st2z5BK19AEH2lZcIeN8g361NTJYslm+pMjiQjKZYGdKdkNTujYdME/L9jovZZ
         D3SG6y42U7fP9uyarb3LqSgE2uxt7XqS0fKHlGa922Vj2NfEEDXgTmPS+1uBjkCbm0yP
         Fb1pAlGHZH6zE8B2TSJnoijrFh7Zrqe+VRETe4jfNd3YQQ4bUEgOc3lfIHWEUZiBMgYA
         fU+SaAozu5YpTj0Qyi9kfQ2msSNy0T8pEnQw8FTFMeuw89vzFxww5lHLVGqQ7dPs6VFJ
         B/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396081; x=1768000881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0BCkqrSr7+3s77zFvT5FgfHYyteD50Ev53ENDz7yYU=;
        b=S9pARVEOjcRTzVMZo8RVl4FPJoCDsEjwO9XzurxvNX0DOT/bxGPdf7cUWWOykBP8dR
         qarE+b5cqXLWFwbTSENSnBvm96VQT5L7cIrxa0XTOnhdPzEBMpaQ+mRRSEiraxdyoj4s
         LrD1SzC8Oiui6DkJ/lyR5KDHWHfOtibSvRHM58qYqwrDphOnJP+y5n0zn+nS08xooFAJ
         tky9W6w6r9tYfKuXx/QhlKpZNW1Un4+O67tkYHIvZ5oRiPLJee/JOjVLr35upa8AsC5t
         j5YlD45AiMOQ1R64YJIXM2E9iL57Woi3Qc+o4FnfQdraJLyn7C5E/aKHa87Z4iq9dHHg
         uhkg==
X-Forwarded-Encrypted: i=1; AJvYcCVF2OnbhCVHXRjrwGbVtUF3fMWh8LPUxjHcfslLwQ+5RfuZB0z+RPshwEqLxtW99nCxRnddTX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhdcUWkeMufyVJ8eacBOy08ERA0oBqtGyWmJq577WdJjHsctJ
	mJAGkIkv0jk795rJlL3CpwrpSnQnU7HgF32hAsihsBCMqD8FENSFRZcJAIseoYvZpps6IBd3rVS
	y3DQV0i6pXR2JX+hWzPiy8tprhkEDF+I=
X-Gm-Gg: AY/fxX7IqLrpwQzeFBhFhLz7KBYwdsA8EPl3g4vp8wZhhPKR5w69VyWifUhZOygjsWx
	jeJ3nNbjimzjBcqTr8fzDXUltILWhPU40To1gX0OD8rKm5tlJ2ce49YFGuN4WfOg4qou5WeiacF
	BRaGw1y4oCc50x4tfVRBgEWpdH9dVhePLo1Zldp9TCojBloJmG8Nm+6yYzmgwXWtrGG5r6PQTtH
	/EZWwxDHK4kIEbGoqI0saXCd6DpGB8c7BK/oyjSrJuAuP2BaHbdazhWk+mPdAWmJubCI19WnV4e
	yTFywtJ1LAJWCqRr8oUwExG4rIcw
X-Google-Smtp-Source: AGHT+IGn5P8bsQyBXvGqBtYekNEfmK/G6BKsQJ8hQ4y4/Wzh1oj5w7JrqKdbG1NJbBH+VpwhT1OBdW/3bHrCO26EMjM=
X-Received: by 2002:a05:6000:2890:b0:431:864:d48d with SMTP id
 ffacd0b85a97d-4324e4bf703mr59704764f8f.5.1767396080690; Fri, 02 Jan 2026
 15:21:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jan 2026 15:21:09 -0800
X-Gm-Features: AQt7F2rscT_gj4mowy2CmXVR0NcdxV61KBEbPavnmO85j2f1ZJ9LVc_rSTc2YuQ
Message-ID: <CAADnVQJRXWtt3MY+Z+mZerYjir-735z9_mbLJQF-TyUL9pFt5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/10] bpf: fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 5:07=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Hi, all.
>
> In this version, I did some modifications according to Andrii's
> suggestion.
>
> overall
> -------
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
>
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program.
>
> We allow the usage of bpf_get_func_ret() to get the return value in the
> fentry of the tracing session, as it will always get "0", which is safe
> enough and is OK.
>
> Session cookie is also supported with the kfunc bpf_fsession_cookie().
> In order to limit the stack usage, we limit the maximum number of cookies
> to 4.
>
> kfunc design
> ------------
> The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are
> introduced, and they are both inlined in the verifier.
>
> In current solution, we can't reuse the existing bpf_session_cookie() and
> bpf_session_is_return(), as their prototype is different from
> bpf_fsession_is_return() and bpf_fsession_cookie(). In
> bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> the cookie. However, the prototype of bpf_session_cookie() is "void".
>
> Maybe it's possible to reuse the existing bpf_session_cookie() and
> bpf_session_is_return(). First, we move the nr_regs from stack to struct
> bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the sessio=
n
> cookies as flexible array in bpf_tramp_run_ctx like this:
>     struct bpf_tramp_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         u64 bpf_cookie;
>         struct bpf_run_ctx *saved_run_ctx;
>         u64 func_meta; /* nr_args, cookie_index, etc */
>         u64 fsession_cookies[];
>     };
>
> The problem of this approach is that we can't inlined the bpf helper
> anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc, as
> we can't use the "current" in BPF assembly.
>
> So maybe it's better to use the new kfunc for now? And I'm analyzing that
> if it is possible to inline "current" in verifier. Maybe we can convert t=
o
> the solution above if it success.

I suspect your separate patch set to inline get_current addresses
 this concern?

> architecture
> ------------
> The fsession stuff is arch related, so the -EOPNOTSUPP will be returned i=
f
> it is not supported yet by the arch. In this series, we only support
> x86_64. And later, other arch will be implemented.
>
> Changes since v4:

v5 looks to be in good shape. It needs a rebase now due to conflicts.

