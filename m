Return-Path: <netdev+bounces-138445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD59AD9DF
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA92B22E04
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 02:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FEE150990;
	Thu, 24 Oct 2024 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrwYUgAX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3314B965;
	Thu, 24 Oct 2024 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736555; cv=none; b=ScGZQIoYCNMG/bcI/fPfubFbH7S3+NieMxTPKe/oRIUXBoacEr7CbYEz2fhx8cehArCarU9iSoFdmhEO1Fwaaqw/GsjBAeBwgPy6VH7nnBHQRIFeMvjyG6Ct3aM6EiKe/wy3M2wSsri2w0nWoJub5hQGOdLhowMDeKqxolq61oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736555; c=relaxed/simple;
	bh=vmUFnKmPNxRCh2Lbv2VD74FepxKxO30Xo3H2Wq+7pLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFWczoTug4hfAGloKdfTC3pBoXWIrPCXINGR1qGXXq4CcFi1VOw9/1OgxRSNDQhATGpCCGbWJ8d27zYUBlToV3mngb1Fj7NhdzRMIWZjsdzXVwlEvuPFnqk1LJxBdtdDtaqAemdopZpanMpygw352jSwIceapAhCv4Wh8qYqtJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrwYUgAX; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4a482cb53bdso145978137.3;
        Wed, 23 Oct 2024 19:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729736552; x=1730341352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL+Jh3cevUDP2bfsny/t51qOv6L7T1pXEC+sXApUzzY=;
        b=LrwYUgAXRx7Had0Sxlj4cTChirSdr3BECgWGFtho7/rBSDgmMBHUy4vxB8kecCYdU4
         8DJnQ3sGk8Pna6CthkCyG6rTsxdLXVP4IhQFjlnUPl6cdL4B2lH1gSXYY2MNo0znjhbS
         2FIOGnBJpJD+oNOemOc8X08EEGLN9+nDVObWVEaSKlL6uGJ6fSXAPuVlEbAnEQHQDVv9
         vn3dXi69kwAXvHqGHcj3XwAYbfvmf8lDqiIEpKtH9AcKsRC3KpROtp8x58HOP6Ct6fm6
         i9paowldW9rChFy4VvJnfzd8lONJl2AHwwZzeKMbVwJh2zjnymsDpe/WN/bEmY+joegQ
         x/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729736552; x=1730341352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EL+Jh3cevUDP2bfsny/t51qOv6L7T1pXEC+sXApUzzY=;
        b=wE4mgUnbFcn4mimo99kLLxMiEtQRWAauZ2GmpZnvJFy5Y7hI1cRtloKGRGWne6CP7c
         HSujIzjN6NZ006Q2hXygoTLdLJ/aC+6U53UGb3HhlB09IYuyLtJcDbhkFuy71Dd3LPIP
         xXActViJK90KSFXgwsAWy/Oko4COmnUJQ9NzIqIHyMY18wfG/ZiegMo/7MTohI8IfxnH
         mzp38vw9LpwAANx0jbKRPr2FOySE4vIroXlUuyLTECmEDmrlcQe3BDztyL8PcsTQyvYs
         vyPP/jmACIuCbEIwHw/HOsATJ78yJy84PHAM+NQdRiMpqjZ3sHbdSpet7bPME1tarLcd
         dPaA==
X-Forwarded-Encrypted: i=1; AJvYcCXEBL144XqriFvVWcF4vFPlpeixNO9DH87s8Ql7FXJp5BW8fqb8longx27pWqF8oq6NZBfjN1GM@vger.kernel.org, AJvYcCXr7ZhyR55xrta3bDReOHIvwqDIgXxk3tCIdYv13JcIbZodjXQ9lpLftcV6xOn+TTRIBLoa4CBlRLhXqF+qiVqDkk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6axBtWb0i30/WL7Y7e6e3w5DkJoLnIVXrAI294BLPvH8wLWp
	VjxGuSDnqIkFcgh21xWZjT9zaWzslv96nWBaRlUA0is/hIS2SN0qthl+V2ErtBlG2h6pZ49Q4h8
	BWhPJMzR2GduQ1n0FrozSY91oe44=
X-Google-Smtp-Source: AGHT+IF+cbz3S+v9L9DnwGcrm1QU3OCCOXDNGkMZPaTxA8LFri84dZpD1NJbiFJnQjE+momRbNJGfgKqCnaNaV6HVBQ=
X-Received: by 2002:a05:6102:358e:b0:4a3:db98:4458 with SMTP id
 ada2fe7eead31-4a751c92503mr5978507137.18.1729736552021; Wed, 23 Oct 2024
 19:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023123212.15908-1-laoar.shao@gmail.com> <CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com>
 <CALOAHbDk48363Bs3OyXVw-PpTLc08-+MEo4bq9kXq1EWtyh24g@mail.gmail.com> <CANn89iKvr44ipuRYFaPTpzwz=B_+pgA94jsggQ946mjwreV6Aw@mail.gmail.com>
In-Reply-To: <CANn89iKvr44ipuRYFaPTpzwz=B_+pgA94jsggQ946mjwreV6Aw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 24 Oct 2024 10:21:55 +0800
Message-ID: <CALOAHbDiev7-mosZL+1D8N4vr4pkJTPdQAdR4+GkOYS6BygSPQ@mail.gmail.com>
Subject: Re: [PATCH] net: Add tcp_drop_reason tracepoint
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:43=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Oct 23, 2024 at 4:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Wed, Oct 23, 2024 at 9:01=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Oct 23, 2024 at 2:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > We previously hooked the tcp_drop_reason() function using BPF to mo=
nitor
> > > > TCP drop reasons. However, after upgrading our compiler from GCC 9 =
to GCC
> > > > 11, tcp_drop_reason() is now inlined, preventing us from hooking in=
to it.
> > > > To address this, it would be beneficial to introduce a dedicated tr=
acepoint
> > > > for monitoring.
> > >
> > > This patch would require changes in user space tracers.
> > > I am surprised no one came up with a noinline variant.
> > >
> > > __bpf_kfunc is using
> > >
> > > #define __bpf_kfunc __used __retain noinline
> > >
> > > I would rather not have include/trace/events/tcp.h becoming the
> > > biggest file in TCP stack...
> >
> > I=E2=80=99d prefer not to introduce a new tracepoint if we can easily h=
ook it
> > with BPF. Does the following change look good to you?
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 092456b8f8af..ebea844cc974 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -4720,7 +4720,7 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
> >         return res;
> >  }
> >
> > -static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
> > +noinline static void tcp_drop_reason(struct sock *sk, struct sk_buff *=
skb,
> >                             enum skb_drop_reason reason)
> >  {
> >         sk_drops_add(sk, skb);
> >
>
> I would suggest adding an explicit keyword, like the one we have for
> noinline_for_stack, for documentation purposes.
>
> noinline_for_tracing perhaps ?

Good suggestion! This approach eliminates the need to add comments for
each noinline.

>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index 1a957ea2f4fe78ed12d7f6a65e5759d07cea4449..9a687ca4bb4392583d150349e=
e11015bcb82ec74
> 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -265,6 +265,12 @@ struct ftrace_likely_data {
>   */
>  #define noinline_for_stack noinline
>
> +/*
> + * Use noinline_for_tracing for functions that should not be inlined,
> + * for tracing reasons.
> + */
> +#define noinline_for_tracing noinline
> +
>  /*
>   * Sanitizer helper attributes: Because using __always_inline and
>   * __no_sanitize_* conflict, provide helper attributes that will either =
expand



--
Regards
Yafang

