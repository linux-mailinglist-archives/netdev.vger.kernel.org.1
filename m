Return-Path: <netdev+bounces-165762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43254A334CB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4453A6DE8
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4A81AC8;
	Thu, 13 Feb 2025 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dolxS2fu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B61A29A;
	Thu, 13 Feb 2025 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410688; cv=none; b=q7GruWAnzqXW/bgEHm8RiaBHli7Ke+IIY7H/za06N9JzIhljl727UbAli6IT6nLgMx4Gk+dwHxPNJpQ5FHrSTzEtzvZgksaKoydCFB525aBYnvH+Uresz3GnrMhqdbEO7N9plxGORhYnM+Cap6VuZ0WrAvcBcEXpEFLUKu4qEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410688; c=relaxed/simple;
	bh=kS/XO5vcl4OfPRYFfWjffsQVbaAMbXMg9Nv5WVbWlU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zdl4SQLwB6TPooGRIkKMz2Ft72eSUWsqB1GaV4trMI99Z4Pwfy1MIRYWNuMQDVr9bvA5/D7MMbhtYBh2+j2BnnRtS1QrAaPTSg5gJ/d9aABzWIVVpujs4QgzB5J8kdLmefOxZbAZ7CU+iz6Zhw917IPB5sEZ8xFw7WQrEdK6wMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dolxS2fu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220d27d490dso801495ad.2;
        Wed, 12 Feb 2025 17:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739410686; x=1740015486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3qnB+BjgvVqudxLGCEV8ahQDENtwWQvSoLgLc6HJ5w=;
        b=dolxS2fuE82nHvwNcV+yXAmSAORW6Onc3dl3jJJ5W+HAkduC6cFJMAdiRMiHxXbbDy
         bHTUI0mdcylll27YrIIdBC8VVsSzUoIMVITjZAmaWhG0UujwsolBepZEM/eNl5iIyu6f
         5EDozEf19k3E6XTkT8mpc7WmiPkwDq59moQCu3OuMMxUpwVHKwUaeB1IoH+2cyf2q1fn
         yR6SAn0bcESk6kAUjvGbvVLggYcsA3xdQgfjPPAcB2LKWfsgYXnoixvaNliOeLnQyQHB
         b/JEWKvYg1j05hHSJ22hjmT6y4izDVekkNwWDKH+Lz5vPyHBFelyezjjlax1lTioghLv
         KuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739410686; x=1740015486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3qnB+BjgvVqudxLGCEV8ahQDENtwWQvSoLgLc6HJ5w=;
        b=Xq5lm3OrKGnVBnjudFsPVNr60gc8VKldCrKsDAyhdI4SKpFTqteeE9cyxkSmhzY41D
         9MR+rFf6yhnS5/KX96prJn2Ehw/ZEZNkuj1jY6x6u7d3l4N6z/MYBW62C+drF8IV9DZu
         gyup6nufaFza5D8PBafTxYOS8MxMjxV1EnknyTAa2oe+s/7UuaD7hI/sxZp8QsNKD7mq
         GusO1Wcf+RqH4bLORSdJ6EiMNaDUtKe/32BC2WIvs5W4iP3WGw28kchmV/pagmebVkNE
         ppHed/viKD3MokOV8R4ukI+dBssqUEGet5n4OmMT9LvLCDtmbiJF0GTuMpM9lOoDfYnh
         +KCg==
X-Forwarded-Encrypted: i=1; AJvYcCVWysTWkGapqFG/Mwa9fg9GdFqtM/9h5k8VHsVOT9AbmyEYqFgtrvAZ0UzN/yA9F7vv4nUQlUcz@vger.kernel.org, AJvYcCXoSjbPRED2KX5BBt6WpYPrJAS1zoSLxUoL2S7ySedh9V4HL4FCGtHjWKAoyoRCDI1VIwmVkviiyyt4dg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgTVzUzpCMN148igY5q4xohtqZ16ywt//ebVSMve9OwtHYK7n
	7fy6eq+Jp+uwVcbNnWWVZi6usNkh4+j9v2TbonCBbezp02+Dv0yyyW9bIdPUv8gINajJVQ2dnUB
	vJt8AvEEcWkP9wfpMnxjwAVk2gA==
X-Gm-Gg: ASbGnctonbm3nUxJ7cTowzpCDC4GTtySdbtE2P8ryAaF6uUkB8+jBkysV+gQcIs1rwD
	jEHJNI2I3H8jOn04y1CNKD8KY56EHvvCUUcFfM1dPlLXkhGPidTk1v9pY0CLpbYS6r75e0p5Sew
	==
X-Google-Smtp-Source: AGHT+IGNSf6rGtM/0ntuhaOil/OeR7IwjOWYFQDUAqkZMflXOFRT9qKkIxcKzWOWjZx79tkVLAIyz+1kIHTsJrDn3wI=
X-Received: by 2002:a17:903:2b0c:b0:216:32b6:cf0f with SMTP id
 d9443c01a7336-220bbb58176mr34931005ad.12.1739410685858; Wed, 12 Feb 2025
 17:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212212556.2667-1-chenyuan0y@gmail.com> <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
In-Reply-To: <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 12 Feb 2025 19:37:54 -0600
X-Gm-Features: AWEUYZnjQUUyxNUV0VBU760EACS8AzZdfQ6WtL9mWgDhcmj_152WjiAils2-6oI
Message-ID: <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in aspeed_lpc_enable_snoop()
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, richardcochran@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for your prompt reply!

On Wed, Feb 12, 2025 at 6:21=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Chenyuan,
>
> On Wed, 2025-02-12 at 15:25 -0600, Chenyuan Yang wrote:
> > lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
> > a pointer check is added to prevent potential NULL pointer
> > dereference.
> > This is similar to the fix in commit 3027e7b15b02
> > ("ice: FiI am cx some null pointer dereference issues in ice_ptp.c").
> >
> > This issue is found by our static analysis tool.
> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index 9ab5ba9cf1d6..376b3a910797 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct
> > aspeed_lpc_snoop *lpc_snoop,
> >         lpc_snoop->chan[channel].miscdev.minor =3D MISC_DYNAMIC_MINOR;
> >         lpc_snoop->chan[channel].miscdev.name =3D
> >                 devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME,
> > channel);
> > +       if (!lpc_snoop->chan[channel].miscdev.name)
> > +               return -ENOMEM;
>
> This introduces yet another place where the driver leaks resources in
> an error path (in this case, the channel kfifo). The misc device also
> gets leaked later on. It would be nice to address those first so that
> handling this error can take the appropriate cleanup path.
>
> Andrew

It seems that the `aspeed_lpc_enable_snoop()` function originally does
not have a cleanup path. For example, if `misc_register` fails, the
function directly returns rc without performing any cleanup.
Similarly, when the `channel` has its default value, the function
simply returns -EINVAL.

Given this, I am wondering whether it would be a good idea to
introduce a cleanup path. If so, should we ensure cleanup for all
possible exit points?

Looking forward to your thoughts.

-Chenyuan

