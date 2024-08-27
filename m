Return-Path: <netdev+bounces-122103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B195FE93
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE79B281779
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 01:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96AACA6B;
	Tue, 27 Aug 2024 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NEPKGZ8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DEFC133
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723803; cv=none; b=Wf0iBZi7t0ZROxQ5LP2jdEqbIuT6/EmD4JeKLiA8jGvVD/aHgs/b7QZkHWF30PTEwFDUTXwn7smQ7PAuFigvKcHfLqXRHQiwr5foPDc+g62GvXjNjOE0cDbuSiNnEWCFr11hVGAZH0MUCJD+XncVn5fpDq1+f2k2v3VbMPQOgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723803; c=relaxed/simple;
	bh=1fwivF5Kntd8INxTCggymxiPWNXgH985IU6YIXH/YaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsqhdCDp7N4VRQv6B6TlJC3uHHtrvTLhmmHc7NG6n0QUX0YOorxY54/RTDaRGhJ/SbFV8xCRb6CDMyfx+hjwca2vePrcW5Lp01h5yC/6f58uimx35AmXt3AEGAS1rYIFjhxTAsLCMtlNpepOGsmW7bXMq1kY3UGw6jgLRrUTxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NEPKGZ8n; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b4432b541aso43772257b3.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724723800; x=1725328600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHkpf2eW9vtVI3uQimkDc6XD8VPV3xIbNHiNaLloE6M=;
        b=NEPKGZ8nzpUOkImZ7ja0ABxwl/OiJQs2L08CcPqkwkJUb34RwJiViY/7few+zUnx+Z
         TbJ58ykwrjhgQ82Bw71/fmJ8L7i3Pz+hHgL4KMA1snzNgn982gLd2/BnWvyFOBkO/0pF
         KdiswguzJh8UPgTcryPGb/N+2994x3qHVv6r7rCdNDKk5dSZTH2ax1fTHeMOrzJdCiee
         oRQdbAoUMh3eUitInSkPbY2ohT3g184MMEqTa0Y4rJY29V0DOaCZhhVr19euqgUwWSvz
         sFyCIOs6CS3MQRa3tAQjsR913E3KZ2nO8an3mmnVStPQJoOz0ZRAPtFE2xLuYP+LJ7jT
         b4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724723800; x=1725328600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHkpf2eW9vtVI3uQimkDc6XD8VPV3xIbNHiNaLloE6M=;
        b=BZhO5MWg3nlNPLoBI3fPC1PqaDuVyqvtAIhahHzsVpVUj5RCdAJBKpphrXqbBWxVbU
         Qanuo3UDo5ZiRXLZk32RAk+xYwKuQHrbUzFFyBCP6MTm8tWeSGv1kOGaqvy0Y4BM13/o
         n/dhOD4BOAkqBkpbdJNlN6B9XKmGB4KMqQ5ZRO90+WDrt8KJJeuT4U2YT7Fyj662tJaY
         IMqSAtWt9KPmB3j1RYlwRHh2N6cXBGLU6r4slecg2LL56dy2pChwjhSAMxyCGFPpprD4
         Io+ZHU6J8PkAAHI4ZxOBGd42kZNl6Wl18cYKvYovEyr4qbePpkqYXzU7x9CCGojwyqaE
         zgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1QkBUKSQEgWZd4m2/Pi6FmwlD8Dh8zMK7PXdNQ55yt29OF37TNHtJaDLma8zsLVtrC7XmwEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydz7kNf+CXIOHWQ1pbMGhOAc6zjKKrBo+PQFSwl2khTwPQRTmD
	kBifpA7XH308JT3zIyse3vTouerUWmOfBWpCVOlLLAjv5wFA/YMz3Wzi32P6sxwXAnoXzjr9nbg
	3oTtvLMZ+K7QDBhqdvCc07KcTsSobTCIjlhba
X-Google-Smtp-Source: AGHT+IGAlsSd5u0kuXsprdwgpBWXtwruGr5DEyvE3wl7DuUl9p6ZRcHG5g6fvYorBxc3UuC0PA06wNMuggPIcc4VLCo=
X-Received: by 2002:a05:690c:760a:b0:6b1:2825:a3e2 with SMTP id
 00721157ae682-6c629159d06mr130236787b3.44.1724723800391; Mon, 26 Aug 2024
 18:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
 <20240826120449.1666461-8-yukaixiong@huawei.com> <CAHC9VhS=5k3zZyuuon2c6Lsf5GixAra6+d3A4bG2FVytv33n_w@mail.gmail.com>
 <aeb685e9-3a2d-13b4-4ec8-0752ded06d61@huawei.com>
In-Reply-To: <aeb685e9-3a2d-13b4-4ec8-0752ded06d61@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Aug 2024 21:56:29 -0400
Message-ID: <CAHC9VhS4TKvTyUB+H6cQNjRFbssGRM-U6S-X7011bSv7bHiQqg@mail.gmail.com>
Subject: Re: [PATCH -next 07/15] security: min_addr: move sysctl into its own file
To: yukaixiong <yukaixiong@huawei.com>
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

On Mon, Aug 26, 2024 at 9:38=E2=80=AFPM yukaixiong <yukaixiong@huawei.com> =
wrote:
> On 2024/8/27 6:49, Paul Moore wrote:
> > On Mon, Aug 26, 2024 at 8:05=E2=80=AFAM Kaixiong Yu <yukaixiong@huawei.=
com> wrote:
> >> The dac_mmap_min_addr belongs to min_addr.c, move it into
> >> its own file from /kernel/sysctl.c. In the previous Linux kernel
> >> boot process, sysctl_init_bases needs to be executed before
> >> init_mmap_min_addr, So, register_sysctl_init should be executed
> >> before update_mmap_min_addr in init_mmap_min_addr.
> >>
> >> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> >> ---
> >>   kernel/sysctl.c     |  9 ---------
> >>   security/min_addr.c | 11 +++++++++++
> >>   2 files changed, 11 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >> index 41d4afc978e6..0c0bab3dad7d 100644
> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -2059,15 +2059,6 @@ static struct ctl_table vm_table[] =3D {
> >>                  .proc_handler   =3D proc_dointvec_minmax,
> >>                  .extra1         =3D SYSCTL_ZERO,
> >>          },
> >> -#ifdef CONFIG_MMU
> >> -       {
> >> -               .procname       =3D "mmap_min_addr",
> >> -               .data           =3D &dac_mmap_min_addr,
> >> -               .maxlen         =3D sizeof(unsigned long),
> >> -               .mode           =3D 0644,
> >> -               .proc_handler   =3D mmap_min_addr_handler,
> >> -       },
> >> -#endif
> >>   #if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
> >>      (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
> >>          {
> >> diff --git a/security/min_addr.c b/security/min_addr.c
> >> index 0ce267c041ab..b2f61649e110 100644
> >> --- a/security/min_addr.c
> >> +++ b/security/min_addr.c
> >> @@ -44,8 +44,19 @@ int mmap_min_addr_handler(const struct ctl_table *t=
able, int write,
> >>          return ret;
> >>   }
> >>
> >> +static struct ctl_table min_addr_sysctl_table[] =3D {
> >> +       {
> >> +               .procname       =3D "mmap_min_addr",
> >> +               .data           =3D &dac_mmap_min_addr,
> >> +               .maxlen         =3D sizeof(unsigned long),
> >> +               .mode           =3D 0644,
> >> +               .proc_handler   =3D mmap_min_addr_handler,
> >> +       },
> >> +};
> >
> > I haven't chased all of the Kconfig deps to see if there is a problem,
> > but please provide a quick explanation in the commit description about
> > why it is okay to drop the CONFIG_MMU check.
>
> According to the compilation condition in security/Makefile:
>
>                obj-$(CONFIG_MMU)            +=3D min_addr.o
>
> if CONFIG_MMU is not defined, min_addr.c would not be included in the
> compilation process.
> So=EF=BC=8Cit is okay to drop the CONFIG_MMU check.

Great, please add some text about that in the commit description as it
is an important difference in the code changes that isn't currently
documented in the patch.

--=20
paul-moore.com

