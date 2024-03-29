Return-Path: <netdev+bounces-83331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A6891F5E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BD41F30C63
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695DF1422C1;
	Fri, 29 Mar 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRpzkkk/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FA85C52
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718506; cv=none; b=m4OHNU+Fceo4lmLPPYYwhG984O2N8H1zLQS17k/VoaBtoJJnrtda41+vjvKzDV9lGu+tOgSuHraIy2T/Ji3Xql3EislpiCQ1Xl/92ACW2iQLhAwXrBm4r+D4/Cz51ekRtE3V4rKFLpBIYoJaerW6w8DQCKHjbxcX/djKy2mjj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718506; c=relaxed/simple;
	bh=RAhOseKWHqjGtVoiQ7a2nR2D+WRBJpAPx8SCmHJSxcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD+JpT/EuUSjAe8P0EdZMnNsCKCrvYZzbvg7hIS9ZDs3cPVAenWYpSH9w6ZPkHQEOW+wyrdr2jWyT2XhAoeZcuE28xqvwCZX/eGN6MbbL1ppgXUn8BVtbomo3uoFpaYLrGRPz+dtoCnsEs0vJbDh43yvtxjEJjWvSkFvgTfWq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRpzkkk/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so8008a12.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711718503; x=1712323303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6Qr+2wZkDiWc+QhngmAmneq974QF4QT4bvvKPeEeCI=;
        b=mRpzkkk/qOu1huMf7Y1GSiuMGohxIBM4rnlP2tBZoxrQY2yoJxd3ADqafDnSUdQYOp
         MpzADVyy9tn0zskIXC//tGWfCK/4wBmfYJxQPW5tF4MZY+Nvg3QiZy/rRVelNbg1Uscc
         Llhi1aZ+jZizXWES7IMGcZAtAwbyNiLeOE1lHXespehUyIy4kKpk+5h0+fEIW6wcnarh
         8FbWrhxF9Esm911DWgFBqbpHvgHrAKwIDpbm1WHkr8Q8tB/VXO+5UiKAE0/bHuTBEp92
         XZ69dUpYiANFfyUzMr752lXHxksyRyCwXjB4i382sYGFM1F5G55g4twyKY5pMJ/AoGZ9
         2h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711718503; x=1712323303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6Qr+2wZkDiWc+QhngmAmneq974QF4QT4bvvKPeEeCI=;
        b=wS8F2ZglSVQp5uFJZRV5maw258QIj9PQpDRGcQNJOOz4JEWdUyg8SBmGhAu0EPO6/N
         gi2QsVIfz4FpVYJMxJTAMrGaFj4RDzm+zwhDghoMUMKBkDPWutEWD1SWp+crjBmvgkjc
         uvSYuXYgOV9VTDrJzcL1jNgmtm+4eSuo0shQmN8Tw2NLI96Ej3yEeEXs6j35/1f0Aqoi
         GgmauJQ4bT2CyxykH0O6YmBe1aqfNHiEgboUsTOhCiA5vQPY3Rrbits+HgvUTE0I601r
         D7TIomE0lK28rbvU9h7TQaCP5YxbwwRefiE5VMqHuuEU2Rwic7rZtcIPsA5urb+RnpIk
         5Ldg==
X-Forwarded-Encrypted: i=1; AJvYcCUm2PqfTJnSndGGcClUDbtDpSdqNC0bZoxiLYrFNPPzpRB2kw6LqbddsGFjZ5MneeYQVeckCH51fSkfOyZJy5eLaBruOBUT
X-Gm-Message-State: AOJu0Yy8MbSrLwG4d4gE+wxOF0jrhxLvmEH0kNB7c8VjdfzPanTjwg00
	LSE9dG+ZiSIVVZqhh2a55FqmoF/acFdlgOALlcmJ0rM4H5GbyMXzNG+Dqo8OccdhaEKVlQkbUKr
	hykt+djq6b6vWYHaOJxGP+Jqq2dn/wNlXbuhm
X-Google-Smtp-Source: AGHT+IFyUO0LdXXBQqKbbrkev8q9MSFk85GtCswxxjiFZg14xnRhOn+ConDZ24SXfudvkm8YB3u16z3CQV5DlRSNzKM=
X-Received: by 2002:a05:6402:35d1:b0:56c:63dc:c02b with SMTP id
 z17-20020a05640235d100b0056c63dcc02bmr106182edc.0.1711718502598; Fri, 29 Mar
 2024 06:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329105610.922675-1-dawei.li@shingroup.cn> <20240329105610.922675-2-dawei.li@shingroup.cn>
In-Reply-To: <20240329105610.922675-2-dawei.li@shingroup.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 14:21:28 +0100
Message-ID: <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=gK8Aow@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/iucv: Avoid explicit cpumask var
 allocation on stack
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	ioana.ciornei@nxp.com, wintera@linux.ibm.com, twinkler@linux.ibm.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:57=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn> w=
rote:
>
> For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
> variable on stack is not recommended since it can cause potential stack
> overflow.
>
> Instead, kernel code should always use *cpumask_var API(s) to allocate
> cpumask var in config-neutral way, leaving allocation strategy to
> CONFIG_CPUMASK_OFFSTACK.
>
> Use *cpumask_var API(s) to address it.
>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  net/iucv/iucv.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index a4ab615ca3e3..b51f46ec32f9 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -520,14 +520,19 @@ static void iucv_setmask_mp(void)
>   */
>  static void iucv_setmask_up(void)
>  {
> -       cpumask_t cpumask;
> +       cpumask_var_t cpumask;
>         int cpu;
>
> +       if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> +               return;

This can not be right. iucv_setmask_up() is not supposed to fail.

Since iucv_setmask_up() is only called with iucv_register_mutex held,
you could simply add a 'static' for @cpumask variable.



> +
>         /* Disable all cpu but the first in cpu_irq_cpumask. */
> -       cpumask_copy(&cpumask, &iucv_irq_cpumask);
> -       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
> -       for_each_cpu(cpu, &cpumask)
> +       cpumask_copy(cpumask, &iucv_irq_cpumask);
> +       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), cpumask);
> +       for_each_cpu(cpu, cpumask)
>                 smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
> +
> +       free_cpumask_var(cpumask);
>  }

