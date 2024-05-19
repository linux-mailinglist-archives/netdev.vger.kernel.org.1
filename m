Return-Path: <netdev+bounces-97122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2798C937F
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 07:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273D91F21356
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 05:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35423D60;
	Sun, 19 May 2024 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6cfHBRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B95DDC9
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716097305; cv=none; b=sw5TWy8XxbXY70npZzA4drxhNCMlpW671q0A4gmB/c5ahSVbv1dTZPfj2gqrnXL7BUse1Ga+JM0ZWhaPiCdbobFpmA4q7z0nGTcK3X+ki3RJA1hGFMvhP9qiSYsdxANXx1OIi4LrJsZ99OdsgeY/SDbFQRzz9S850/DwFj+V27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716097305; c=relaxed/simple;
	bh=YBaxIvg6LaayBA3k8CcarnyV3/utolkhsD+rdh6PuLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+68tqHZDWCbAsHfkl8HSKWpYO/5Rt4dAbtuxfM0Ivd4XI+2KiwOouOcwTFk5VsgZjQUKKMVQE3i5Kb7M3QRacX25ur/o/1uQCVBKPXTGZO1eMijsg1yQFRZ74nrc0++nCnDhSX6PUPXaq/h+0T//YyRHMhyhFZKwaL+W7t6T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6cfHBRT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so4410803a12.1
        for <netdev@vger.kernel.org>; Sat, 18 May 2024 22:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716097302; x=1716702102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxPAwXTJG+xnHfY/5PV/IioqbrA81KrcsLy+s0VytTI=;
        b=N6cfHBRTScoeGhtj3U8XBTTXHS4/9S7ZPd2ZYAGSWgK6Hbr3PCIbBSye/j/K/1kgdT
         nI7ub902Wf380z6eB8BqB56eyQnSv/Ril3fWyWvTWWHTYvKxInnfXn8OFJG+rHB1DeOO
         g42LIQcz+RYGFJVvws+ybX+c+6/SPmta4ySbNJlOnW+FCFZ8tfcXseqMbCvQtcKCUmjo
         VKgidjlBFqBjUUfc98GlIYf4e1Mf2uAoSyd+QLaD3b7UnpXJNGAEYVVpc8GgQu7aUbUM
         fRItcEFvQpYr23o/Zhs2HVWlem/+5gQJe9kpNl2AgZWkRH5eBzKn/EGHaPKqG0z6p/to
         SD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716097302; x=1716702102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxPAwXTJG+xnHfY/5PV/IioqbrA81KrcsLy+s0VytTI=;
        b=mzAYuKb9DbVwkq+VnWW3DL1imqSzaQVtbfxdPR17QxSgRHZHkysjLz5G0EZVJaPmKI
         /fO02BXvUOA+aMIr/OhUgrhYiywza1c2Qmvqsq2wI4wG880WrKhdurH0vQaoYc6pnqNl
         N81v3CrnhYq9w9fZKr31N7+jG9n2e00gBLPW4Ne83qdXHW0YPWZi034nLPGKSUFYggLv
         6bGrgcPd5vNjHF/cgYTw+RpxQQbr6AJ94XvLGvndiQoD0Fx1pVpoqN1c1CB1pUyjUlPm
         5aWOiw4dO8MeLSTj447sFNecbEoZlrUTTHqGOKg1hPzX7ZCIs+/10onjpRkvsxy8OGzL
         AhNA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8J/PMqNb+KerMofxa/F9xA4sPvdq6pxfX0Z4NQLE1mYcygzYivgd1scaj9RI7os2QE/5Zo410ctqCVXTOasZIDYnRIbJ
X-Gm-Message-State: AOJu0Yx5UUd3m7ezkGJjPpzNFdcUnr2c46LgggKc0fDiivJk/XB9Celc
	eU19wLB6FbNTrJO18dnnycBx/dRWWVUrVfusYPQqJyNtHSSNHvw=
X-Google-Smtp-Source: AGHT+IFcKC5snse/Lf7EaD5ruE7/Iwk7WCLIMM5IiQ1qMJwbFKDLCjH8CgOfJEFdegI91uGeNymyIA==
X-Received: by 2002:a50:d503:0:b0:56e:215b:75c2 with SMTP id 4fb4d7f45d1cf-5734d5c137amr17679240a12.17.1716097302296;
        Sat, 18 May 2024 22:41:42 -0700 (PDT)
Received: from p183 ([46.53.253.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb54csm13530628a12.60.2024.05.18.22.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 22:41:41 -0700 (PDT)
Date: Sun, 19 May 2024 08:41:40 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: set struct net_device::name earlier
Message-ID: <bd68daa3-b8bd-4124-8a0c-dcc3c14bba24@p183>
References: <d116cbdb-4dc5-484a-b53b-fec50f8ef2bf@p183>
 <1c1dd2da-9541-4d9c-a302-0a961862cedd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c1dd2da-9541-4d9c-a302-0a961862cedd@lunn.ch>

On Sun, May 19, 2024 at 12:04:05AM +0200, Andrew Lunn wrote:
> On Sat, May 18, 2024 at 11:24:57PM +0300, Alexey Dobriyan wrote:
> > I've tried debugging networking allocations with bpftrace and doing
> > 
> > 	$dev = (struct net_device*)arg0;
> > 	printf("dev %s\n", $dev->name);
> > 
> > doesn't print anything useful in functions called right after netdevice
> > allocation. The reason is very simple: dev->name has not been set yet.
> > 
> > Make name copying much earlier for smoother debugging experience.
> 
> Does this really help?

Yes and no. One could infer names from stacktraces and overall ordering
of the allocations but it isn't convenient.

The snippet works everywhere except small number of functions
but it doesn't cost anything to make it work everywhere.

> Instead of "" don't you get "eth%d"? The expansion of the %d to eth42
> does not happen until you register the netdev.

Expansion happens later, yes. %d is fine. It is immediately obvious
which type of device allocates what.

