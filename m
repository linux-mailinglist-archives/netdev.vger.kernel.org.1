Return-Path: <netdev+bounces-122083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7790195FD81
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877061C21E53
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D319E7D0;
	Mon, 26 Aug 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GDk9DFy1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63DB677
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712572; cv=none; b=PDB5de3jrwgQmewOcUp7L4xYpDYHkkhWbkTQ3Z90+4qgssWzi4AlbRi/pc/q02GJWiWu2qgd60J++YchCcoRYInnKZvuoX/3C5oXP9fxxI1sx++TQP8eOkiz8vMPzdUVMOVppNeabHnn2U2k20VraseUy9iR1RBXNyohZxqhVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712572; c=relaxed/simple;
	bh=4riBHCy/ul0psyvOkTn7BvHgTDelnSNQyniXCwOavsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tU/BCJctidU1NX04RboUx/8P29ktP7WG+ySGwkg4gIgI1vR3oM49o5rKUZ0tcM99tSj1cEbsejZu2gfJHdDmddfk8h7aukGUqzGyy+JS4UPaIfofy8nJYA/tFwmNc19kBLN1ExrscygrXk7K53y7LtOr3S1R+iDyzeBcGlf8edQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GDk9DFy1; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e17c1881a52so1819361276.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724712569; x=1725317369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWTFl5f8OPZ9kYIvj+M7W9eYYEXfjlTCvvmN9eeNnFM=;
        b=GDk9DFy1uU5DEevxf++6WuIvZZ73OSd9X3L1keRyQJcWJE1u6gMs9mSkyo+wW34q7v
         3Qc1tPefjxRgoUEoNXahf/fPq115S7AyyFTtmSD59YXxRTKb+u3yaSoRA2w//KesDMOS
         K6xV0y/d/7tx8szAfjEupd2n3oRYlldJMEY+vEo4UIUW/cw/kprydvfFUn17TmGxx2pM
         R6NefIsW1LMf7WJI1Wee+mSSKx9wnlL4p5TM8v0lOzxMgQ0JaU7IMC3RIbdXYj/X6i8H
         TMpNiuD+0Nd32e/eZ1HAZo4EouMkv2OcpkeAhKxX1nrHlLKKboztdWFnXzJVCmQGAREN
         c9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712569; x=1725317369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWTFl5f8OPZ9kYIvj+M7W9eYYEXfjlTCvvmN9eeNnFM=;
        b=HKsy7iWxjQBbgSVyGES3XEdA6GT99LD9M7WaMZcjIqGqkSFsxS3RT+asxmSLVprW2+
         pTXvzJCRFc6n+eqPVCqk8sOlmKdgHDT7YnF0JkWY6iC/zvYryJaYdGl79d7wyVm6AxjX
         ue9OnMLbSr9pfVCHuVwP1Ym/LglOWBdhmcaifG1kkYewe5fstBJnT2e8ZsdBLQTQU6aY
         IiApyZ2IghU8dPxQetfwGt98KXynOAaMKSEeQ+/IKegmKBR8ZbwGHjB5j4ODoaKYmwJ9
         3FV23wbtQIaWsC51RRJa3wh25k5O0uzzI2AD5NlOU/LMlmGriUQlqMmy/W73ie134Vag
         jVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUtDH8Tt6zWxjUK2Scs1pRHbswNKgxGbLLkF4/B52RVc5cfE5YE1DGFakwzZBM7Osb31Ao27rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7q571+3oZQQ4j5RJhsiu+vTnJeN9Bh3lO/Wp3QaKWWSfrMbwo
	pv2qduOBqnOvWfQuFJyIrQg0ga5+2AfTURe1qcgtvRFBC4+HtMTelsvcI75Jo8Gu/ExFKjYFPX+
	aJx3toLzUboYzAm2+q2qO7GSGF0KYbIFBXPBK
X-Google-Smtp-Source: AGHT+IFdXwGDNkQJWX/aeiki5niUl6YsOZL7hcKl1t9UskkQFhTdxuBmqzMkoxujlay9La0l7/VeNVTc31ug5dspjrg=
X-Received: by 2002:a05:6902:1283:b0:e08:6373:dfc8 with SMTP id
 3f1490d57ef6-e1a2984666bmr1176664276.23.1724712568754; Mon, 26 Aug 2024
 15:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826120449.1666461-1-yukaixiong@huawei.com> <20240826120449.1666461-8-yukaixiong@huawei.com>
In-Reply-To: <20240826120449.1666461-8-yukaixiong@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Aug 2024 18:49:17 -0400
Message-ID: <CAHC9VhS=5k3zZyuuon2c6Lsf5GixAra6+d3A4bG2FVytv33n_w@mail.gmail.com>
Subject: Re: [PATCH -next 07/15] security: min_addr: move sysctl into its own file
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jmorris@namei.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:05=E2=80=AFAM Kaixiong Yu <yukaixiong@huawei.com>=
 wrote:
>
> The dac_mmap_min_addr belongs to min_addr.c, move it into
> its own file from /kernel/sysctl.c. In the previous Linux kernel
> boot process, sysctl_init_bases needs to be executed before
> init_mmap_min_addr, So, register_sysctl_init should be executed
> before update_mmap_min_addr in init_mmap_min_addr.
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> ---
>  kernel/sysctl.c     |  9 ---------
>  security/min_addr.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 41d4afc978e6..0c0bab3dad7d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2059,15 +2059,6 @@ static struct ctl_table vm_table[] =3D {
>                 .proc_handler   =3D proc_dointvec_minmax,
>                 .extra1         =3D SYSCTL_ZERO,
>         },
> -#ifdef CONFIG_MMU
> -       {
> -               .procname       =3D "mmap_min_addr",
> -               .data           =3D &dac_mmap_min_addr,
> -               .maxlen         =3D sizeof(unsigned long),
> -               .mode           =3D 0644,
> -               .proc_handler   =3D mmap_min_addr_handler,
> -       },
> -#endif
>  #if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
>     (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
>         {
> diff --git a/security/min_addr.c b/security/min_addr.c
> index 0ce267c041ab..b2f61649e110 100644
> --- a/security/min_addr.c
> +++ b/security/min_addr.c
> @@ -44,8 +44,19 @@ int mmap_min_addr_handler(const struct ctl_table *tabl=
e, int write,
>         return ret;
>  }
>
> +static struct ctl_table min_addr_sysctl_table[] =3D {
> +       {
> +               .procname       =3D "mmap_min_addr",
> +               .data           =3D &dac_mmap_min_addr,
> +               .maxlen         =3D sizeof(unsigned long),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D mmap_min_addr_handler,
> +       },
> +};

I haven't chased all of the Kconfig deps to see if there is a problem,
but please provide a quick explanation in the commit description about
why it is okay to drop the CONFIG_MMU check.

>  static int __init init_mmap_min_addr(void)
>  {
> +       register_sysctl_init("vm", min_addr_sysctl_table);
>         update_mmap_min_addr();
>
>         return 0;
> --
> 2.25.1

--=20
paul-moore.com

