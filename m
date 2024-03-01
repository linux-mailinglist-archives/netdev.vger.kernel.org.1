Return-Path: <netdev+bounces-76544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5494886E1F0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 14:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BA0B210D5
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5496CDD6;
	Fri,  1 Mar 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+Q2+3Fy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9F6BB4B
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299555; cv=none; b=uyFZY4RiUYRmbPRWzMkEv2krKjWjDy8E5hPsZbppR7dQDAwID4Xxt8za9Vtm5ciaL8Pl+wce976IenP9F7EEc8Ul1+aXBOoYNPntjuuGaISwAT1gaM0ONbbbarpJ60/wqVVxb2VTtFCyBcF4NBb9QlGSrx9YdqnJXd6COfs9A64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299555; c=relaxed/simple;
	bh=JHWldWA6nNHKcTRlr05zV/nwVzVNIlbYVSMFB9iJlos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBKe1p4UzdedMrg2VqmHE5bujpGnUj2ZHK0aRoXR9sL2+wv2MCycgMZxC3Ni5EoJ1AbFcp4n65qVohGsQk0X0v+wY1UeG8xM+UB23YJZFydG4Z0gK2OqlxWCh05fDvJlAzgi6a9B6ra9/4MxrynF0cl4kW8loRBrdxz4/dTuXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+Q2+3Fy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so5946a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 05:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709299552; x=1709904352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1teAiWc1jVGCssi6rgN3jeMMtmC7N9NmiOj97TQSRI=;
        b=B+Q2+3FyhzzHOF8F2GLt2wkZhMidxgsedxhsBtInm8nvf198JXT1DWUuF0u/356Wxn
         bHie3f4Uu/XHdrg+Vfa953FWhqx8oTkSxkHOqiW2KnCzAx7R4cD2NPj2TsXquakIjDcE
         76UQQglv9A6OGSz2uwzZkR8KRPH8tPj4ZZe2hogP5p7bxSCh5+f3aUvhHjuq5MZHp8P7
         7M2KrYJhNfbtyRCQP89PQJ/FD9VfpkinyagzG8V2v+DAKiZ7P84LOwrPvC5bXiBAILiy
         Ra0kWb1lgODBF7kJQfvGMA3m9OzYX4TpQbrPd4MRKf2eJIzvsx2D4eOV8BvrxHB8P7Su
         094A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299552; x=1709904352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1teAiWc1jVGCssi6rgN3jeMMtmC7N9NmiOj97TQSRI=;
        b=Yf6mvItgAbF9j7+84UpuQJ0PQuimpqa3zeFmlSz65MNP+bG7NBdUuN8qGeIRqXEBds
         DM8PJ9y1JJFZ9AWEg71XiulcbDsyMDkmNoSsgK1AVMnbUzDae/OI0EJKsGgxbTCai669
         7XTGZS+ykw8kVKatP7wTAEcsetDSjiV39DblYqjKWMh1/fe+WBngljefx2cK3ni7OII/
         WH2cFYZBOMTXj0cFYAt6wFeqUCRwkcifB+p1IjQqU+woYIeIOILGrXM6NqFcBtSbgiS6
         pOwyIGVL66rfHHWzRXWR7f1W+0oCUNckwOncjqO2zYSE+hxm+uDqjwpPWBCisADK14Xe
         QgzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR79kvy38lNTBZgKrAyHhN4E3zBdf8qGS8YjL1g3cest4M1FZ33cufF8hLAfWVtZACTL8TelFq90onXtWgd9Ka/2+Rf/z9
X-Gm-Message-State: AOJu0YwGYU4ek6Z0EWQ+OnhNlULRPqb++bSe/+dV2QWkw5mIVlJAsiJf
	p5DDQsUxOWBp30sUf4IrHnbdo0iUo86eoAAPhlkLADjH9m8notnKEF2/6cMwb/pZZtfV5c5CwSc
	jTcTZ3TZp8NFvnoG2Gyh4bxIjPc0eZLOqCTyd
X-Google-Smtp-Source: AGHT+IHAr/zt6nB351plwUC26OzlBDCvnjhX4XuWJqRSF9vysrKL8/mndZ7DIMKjrKSevJ2zGGPoqI2B9cbCF0OdxRw=
X-Received: by 2002:a05:6402:350e:b0:563:f48a:aa03 with SMTP id
 b14-20020a056402350e00b00563f48aaa03mr141224edd.2.1709299551406; Fri, 01 Mar
 2024 05:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229213018.work.556-kees@kernel.org> <20240229225910.79e224cf@kernel.org>
 <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com> <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
In-Reply-To: <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 14:25:37 +0100
Message-ID: <CANn89iLSLPn5PyXNQcA2HO0e5jGYvHKhTh_9_EMmfbTJKZPfbg@mail.gmail.com>
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li <lixiaoyan@google.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:59=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Fri, 1 Mar 2024 09:03:55 +0100
>
> > On Fri, Mar 1, 2024 at 7:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >>
> >> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:
>
> Re WARN_ONCE() in netdev_priv(): netdev_priv() is VERY hot, I'm not sure
> we want to add checks there. Maybe under CONFIG_DEBUG_NET?
>
> >
> >>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>> index 118c40258d07..b476809d0bae 100644
> >>> --- a/include/linux/netdevice.h
> >>> +++ b/include/linux/netdevice.h
> >>> @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
> >>>       NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
> >>>  };
> >>>
> >>> +#define      NETDEV_ALIGN            32
> >>
> >> Unless someone knows what this is for it should go.
> >> Align priv to cacheline size.
> >
> > +2
> >
>
> Maybe
>
> > #define NETDEV_ALIGN    L1_CACHE_BYTES
>
> #define NETDEV_ALIGN    max(SMP_CACHE_BYTES, 32)

Why would we care if some arches have a very small SMP_CACHE_BYTES ?
Bet it !

IMO nothing in networking mandates this minimal 32 byte alignment.

>
> ?
>
> (or even max(1 << INTERNODE_CACHE_SHIFT, 32))

I do not think so.

INTERNODE_CACHE_SHIFT is a bit extreme on allyesconfig on x86 :/
(with CONFIG_X86_VSMP=3Dy)


>
> >
> > or a general replacement of NETDEV_ALIGN....
> >
> >
>
> + I'd align both struct net_device AND its private space to
> %NETDEV_ALIGN and remove this weird PTR_ALIGN. {k,v}malloc ensures
> natural alignment of allocations for at least a couple years already
> (IOW if struct net_device is aligned to 64, {k,v}malloc will *always*
> return a 64-byte aligned address).

I think that with SLAB or SLOB in the past with some DEBUG options
there was no such guarantee.

But this is probably no longer the case, and heavy DEBUG options these
days (KASAN, KFENCE...)
do not expect fast networking anyway.

