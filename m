Return-Path: <netdev+bounces-115669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451749476E4
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A342B22D7F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B18214B09C;
	Mon,  5 Aug 2024 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwZxJGhG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2729145FE2
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845229; cv=none; b=QTde2rAHDajKXqlkAuXEsnau9jqB20Js6fX3TJeFcmlKV49n8pduUxjtYWHXQrsE8Jv+ypQZiA9ao7md5Dfl+K76ORBqJBWL6jZz7DqYevXNWlPZ1RgKaT+QB0ephIvolSxWALBDYpHk23wb04Wdcfo5ySiUr5s9ZPZ/GvcFYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845229; c=relaxed/simple;
	bh=phuPVwD+wfac66YATqtp7KK0hsJ1HIi7c+DdxjIUmH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDTE5cYU8tmVN2VgVHCh+VdRKUe6MEWTmwiD953+wEnwmNXVf/BaypvXmtMWq6XqQLA5ONgD5nwCD8SmaVqX5Oz+u/INqJu09DI5uCI1t7j5qH/mrHYu2utPiwpU2LxX/CKaocbqVQycEGCc2lWoiih1GWXR/+vhnQA3qLEM0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwZxJGhG; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f9339e534so370505939f.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722845227; x=1723450027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phuPVwD+wfac66YATqtp7KK0hsJ1HIi7c+DdxjIUmH4=;
        b=QwZxJGhGKrxu5KNA5mzrrI1OeTxNDB8bQvxNlz672ewxiMpUY/mZSrogD59p8N2t6V
         b6Lyb9CECigGa27wt+MAKXt3BDy7OwBHpXjqmIR4PE/R86bnRK8pfmEdmm0HMQ7TmacI
         xhidvZXWDIPm60JPiuwWj8uHeLoaSF48PXmZrhh2sNrlkAcoIInp+1lU64nCi9PEZMdZ
         42dsWy4YNzQaMc2MlgTpy77Bqgj3qiKuZT4wk7/CNqCK8jDMgV9vJ9rsuS/YSOXd5xuZ
         FI4ZUKUU/fErxRsHaEVPZHpdQlR8aHidP60X37UjdE09LUfwQ99hLzdgrewIl53oMQv5
         h50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845227; x=1723450027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phuPVwD+wfac66YATqtp7KK0hsJ1HIi7c+DdxjIUmH4=;
        b=VO1UIbR9ftr4W/xbxp9HBPg5//TsPLm8LGFE6V4z1Lz7cWdh91W3FnkWm/5NDICp8f
         xACS471X1b529N3UBCuJrsIWfOnwyYBKPggNk3oqb7dTzgnhQAEA5U9Du0uDhhJhzfpo
         qwTiiUwCSBLePv99jGmJ5We1jXPlsiviWVK9k69tJhg31kZmi4wDmZ2+gfpwJLJSNgqe
         zPYhS4KRtHSR0zcYYS81RTfYo2RurdxqCGJmHQGeeDLVV5/oSYb+Pw+GQ3do36k+8juB
         ZSKYhKpHKHKwQJVUpHo+nTGvv4NrE5iAXut1m8yPGWUYVWUU6+1hc1NtpapU6s2jFeDh
         TL/w==
X-Forwarded-Encrypted: i=1; AJvYcCX9CWDLwiTivNPijU9EjsHw875v7ZW6YKiO0cYALGSTfx+V/doZlVT+p6n7Bd9M08kzZ31rfSuFHlyIQC3Q9aUGYnwSqDaz
X-Gm-Message-State: AOJu0YzKERjxA9TGKK58L9WnVCq62jKCf80yALTU3EqtqXIcQTQ4sGX0
	fXiCaUFCQ138IxiBvDf8t80uvi8rSWyrg3S9Rs3s/wtX6F/KkQuJ9X03ZoGS2tk36zgStPP90FT
	W3qHyuV5WzG8e3dl5cUktGHSoQXc=
X-Google-Smtp-Source: AGHT+IERlTM+Tgfv9Rh0G7iiUx9D/lHy7eAx5+6wceSN5emHRtrmZTCXP148POpZRdB0EckTIAUsx+uNp2yqmrnGwlw=
X-Received: by 2002:a92:de10:0:b0:39a:12d7:2849 with SMTP id
 e9e14a558f8ab-39b44b54d34mr3288975ab.5.1722845226978; Mon, 05 Aug 2024
 01:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802001956.566242-1-kuba@kernel.org> <CAL+tcoBNPUCCBhH_7iy4cNXQ0Mtrpe597DXos+s+NS7FVQ__zg@mail.gmail.com>
 <20240802074822.403243ef@kernel.org>
In-Reply-To: <20240802074822.403243ef@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 5 Aug 2024 16:06:31 +0800
Message-ID: <CAL+tcoAokKv9SLrNJksz5Vpgwb_Z4qCPfadFWJnnaBdnBj1xcA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skbuff: sprinkle more __GFP_NOWARN on
 ingress allocs
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 2 Aug 2024 12:52:06 +0800 Jason Xing wrote:
> > > and there's nothing we can do about that. So no point
> > > printing warnings.
> >
> > As you said, we cannot handle it because of that flag, but I wonder if
> > we at least let users/admins know about this failure, like: adding MIB
> > counter or trace_alloc_skb() tracepoint, which can also avoid printing
> > too many useless/necessary warnings. Or else, people won't know what
> > exactly happens in the kernel.
>
> Hm, maybe... I prefer not to add counters and trace points upstream
> until they have sat for a few months in production and proven their
> usefulness.
>
> We also have a driver-level, per device counter already:
> https://docs.kernel.org/next/networking/netlink_spec/netdev.html#rx-alloc=
-fail-uint
> and I'm pretty sure system level OOM tracking will indicate severe
> OOM conditions as well.

Thanks for your explanation. I see.

