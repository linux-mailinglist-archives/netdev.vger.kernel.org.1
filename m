Return-Path: <netdev+bounces-124281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7A3968CAD
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35F91C202E2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3D1AB6ED;
	Mon,  2 Sep 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="yQUXHPzw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFDD1AB6DF
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296780; cv=none; b=OkL0Hk/i6Xm2eQb8Rl0aQ5vR2Pdu5QiaMAVqPJ2VPjIzr4DhOIzx0IEAFwIKGb/xle+40xJ8x4I0IhYj429eOeB7aSARyyqCVrhTVzl7h1MoH163oq6DwZ/I3ewVeNleJ+oKwIK1joqczslUOkmjb4Zfhdbkf44h0ZlshmOq9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296780; c=relaxed/simple;
	bh=m/Hl05dGE8DG9LV4d7LMKZdjId9IkoBTCyuBgmslKIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9p67XbBmnJVb5YW+F56qM+khxZ1PPF3wO0cZ9Pz/CAIncr9xYyICjr9kX+jBTeBLqfut6BgrItBAewwfWugmJpfxCREaAbUE+8CfhjDxaxTRXSC2+jKM9WC7WQIy1yZN2CztdoN1N3gybDLBKkKZa3IJj/C0MTikZSYiM+WTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=yQUXHPzw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a868b739cd9so529847766b.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725296777; x=1725901577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7M8BT8N6vTwP+D5Hjg4AMJAeuxuEG1WY11kk9v24ceA=;
        b=yQUXHPzwLakaHPlXkCRrO7aUae8f5P9dSXdXRoBhuFclC9S0bOMhP2XckKQIwQJY1G
         e+FgxkoxrD7MZED9W94hzfslKWzxVOwr50I44Lev2VSVriG/ZTp1gzQjxxKx82A7bXtW
         INwcl5qaPc4Qyq64vuqPBYVdGKiGziQd94m3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296777; x=1725901577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7M8BT8N6vTwP+D5Hjg4AMJAeuxuEG1WY11kk9v24ceA=;
        b=Lblk8g/lqjODEYlx8+QTYEeP2NdLXBuiPdrlATIf9v3Dw3H/BQH9qUoBIZgYn+B6PB
         fSn5U1s6Q2jWlKV1eGVW1Eu5mxefYN07SiJmUQEifTWr2MvRiYVEBFwfiFwjo3XH5HqG
         Vkq8Ih7afzSm0hWHwTO+kg0TKI1B18g+arUTdGouvb1YR/haVqNnCEKiUnZXJgVowuYv
         MecZ11NJBubtFDDUwiMsxfZ3vjx800tzGeJT+PlWkNW1ETCRrCYpReQ5ByJYWmXFyxEk
         tLKxLI/fyzaLWV1fhSPZA+1tDz/lgC74S3yBdro5FpmDCjbo+3xizqoFFupGbDb6wuuU
         pcHg==
X-Gm-Message-State: AOJu0Yxoulyr5rXODRjsCKaVEPpXSp6qZTB8CfeQ8+IfrmBrEREoghBI
	3A4UWma2IIvaJsR1xmv1cwwVZFQRmXHY5vRQELUN4RDFOn6AA2h8r2NP+rpYKqk=
X-Google-Smtp-Source: AGHT+IGWJf9Avan9MoUFQ6Ai0+z5nn+fJXzqwnGlBi2FTipYcSbwZOLN+wfh53hpdVGR9SMXe/vXdg==
X-Received: by 2002:a17:907:60d0:b0:a86:acbe:8d61 with SMTP id a640c23a62f3a-a897fa71c13mr1003988366b.53.1725296777056;
        Mon, 02 Sep 2024 10:06:17 -0700 (PDT)
Received: from LQ3V64L9R2.station (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989092143sm584447366b.96.2024.09.02.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:06:16 -0700 (PDT)
Date: Mon, 2 Sep 2024 19:06:14 +0200
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: napi: Make napi_defer_irqs u32
Message-ID: <ZtXwhnVzR6ofBJhb@LQ3V64L9R2.station>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240831113223.9627-1-jdamato@fastly.com>
 <CANn89iK+09DW95LTFwN1tA=_hV7xvA0mY4O4d-LwVbmNkO0y3w@mail.gmail.com>
 <ZtXn9gK6Dr-JGo81@LQ3V64L9R2.station>
 <CANn89iLhrKyFKf9DpJSSM9CZ9sgoRo7jovg2GhjsJABoqzzVsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLhrKyFKf9DpJSSM9CZ9sgoRo7jovg2GhjsJABoqzzVsQ@mail.gmail.com>

On Mon, Sep 02, 2024 at 07:00:48PM +0200, Eric Dumazet wrote:
> On Mon, Sep 2, 2024 at 6:29 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Mon, Sep 02, 2024 at 03:01:28PM +0200, Eric Dumazet wrote:
> > > On Sat, Aug 31, 2024 at 1:32 PM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> > > > napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> > > > added to napi_struct, both as type int.
> > > >
> > > > This value never goes below zero. Change the type for both from int to
> > > > u32, and add an overflow check to sysfs to limit the value to S32_MAX.
> > > >
> > > > Before this patch:
> > > >
> > > > $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irqs'
> > > > $ cat /sys/class/net/eth4/napi_defer_hard_irqs
> > > > -2147483647
> > > >
> > > > After this patch:
> > > >
> > > > $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irqs'
> > > > bash: line 0: echo: write error: Numerical result out of range
> > > >
> > > > Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> > > > Cc: stable@kernel.org
> > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > ---
> > >
> > > I do not think this deserves a change to stable trees.
> >
> > OK, I can send any other revisions to -next, instead.
> >
> > > Signed or unsigned, what is the issue ?
> > >
> > > Do you really need one extra bit ?
> >
> > I made the maximum S32_MAX because the practical limit has always
> > been S32_MAX. Any larger values overflow. Keeping it at S32_MAX does
> > not change anything about existing behavior, which was my goal.
> >
> > Would you prefer if it was U32_MAX instead?
> >
> > Or are you asking me to leave it the way it is?
> 
> I think this would target net-next at most, please lets avoid hassles
> for stable teams.

Sure, that's fine with me.

I'm just not sure what you meant by your comment about the extra
bit and what you are asking me to make the maximum limit? I have no
preference.

I just want to prevent overflow and then make the per-NAPI stuff
compatible with existing sysfs code as much as possible.

