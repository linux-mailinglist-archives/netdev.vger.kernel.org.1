Return-Path: <netdev+bounces-86481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5489EF06
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573BFB2120E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34CF155722;
	Wed, 10 Apr 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ctk2lFD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BD15531D
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741882; cv=none; b=mJ6yefXSRjS34kg+F3ZSwkSS5M6Zo953ewUJiYcrL2g/XlaNP/XbhWwF+7tEH5LhMDI/aEzUedjgUpuWssM8EjsE1Extj10UDZ0BTTVNqjXQc+xVwqdx0SC8mwRfTgFJc0ckb/PEuPHCsthgbjlygr14up9YSRxj8+h5ROf5pJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741882; c=relaxed/simple;
	bh=FPPQxv+2P1fn5u/r9mWDFT2/PqyWIZK1squrhbuAEXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBUpxE39PelFFZMl432WGztpbYNCTinolIv2F84IgMAvE6vZ11EGGZq2Z0tynY7Y2ytOtt+7CJiW0cotzuByT2v10cNktHl5Dm+ouLdg5HBsOi9Od3kAFZI2GpqR4r9gaPr41ILBneJSPSciQsvzJtTM2g5KZAAg1RFmx+Qn58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Ctk2lFD0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso9643215a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712741879; x=1713346679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QZbO4+aemJ7P9l3lIGisrWA6ah2/B9LOPcIoIcGkmmQ=;
        b=Ctk2lFD0xcN7xiloFryNpmPLAAyWMcFDoGCt1ShnUFv+WdpIaLkfFvxcXt4QfK26qC
         Y4IrVOuNZo9H87lgbCAyobz8FhRV4oG0BimjRgaz+ufJeZAukkKYemHwbvrMxx/Y6Eqc
         o4+6cmhMVTrZS8bagoIvD4tIFnwqGupCa3gK/bNaA726ea93x/LGXP/zLuAUtCJDZ8GL
         sjt3EnHILy808lu5SOd4M7muZHmC7m6yy3M5zOnON9kYd39oKExUW8rBr7K6Kyi8PsgD
         Nj7psXKtSFGkx2MpaV4g3rKhVCBQPGg1lCMAUtb8+qIEMZOvaN69g5MayKK8qufYiVmd
         LtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712741879; x=1713346679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZbO4+aemJ7P9l3lIGisrWA6ah2/B9LOPcIoIcGkmmQ=;
        b=J4Q+Nk1swNoJSYMPfez5TGTOAFElovdJQVNGzi/mqSSkLl6j593tQ8QgyD9+k4TuTu
         E+sGm2PeOODQgw7lXnJrFI83zYlpWgD1mJFfy7ke+OauOHPIOWyvnzVgRb4DOLod/tC/
         WR8vSdaO2fHKcC0TW299tqinzjPeXjhrTOzmZIYxq/mnFJOB4fn1cGCiRquM3Em5CFTk
         Dhcbvl3FCBbA3CgJNGzhFuJ59nE8ODbMF/oNsVH7xDcuiZ8HlDeh85XnjZH9pR7fVSwO
         xSrIxyHDVlNN+oUnlvUTau9bwt56hDNnHCW0j/650QvXsn3mlKNGlAITf51X/ymf5hJ9
         Byug==
X-Forwarded-Encrypted: i=1; AJvYcCXdf/LpQBaBvg8Y+cv0rQW+RXENPaVg4LjofZbRRBb2o/qaZsIGXy3yjERrIigoHPOoEgbcYN/bt51aJN5RRmyoj7A+PQTr
X-Gm-Message-State: AOJu0YzCj6gJnlYXymag0zIiLGkC04oWapHyMldYpxb5E8kc7W6bUhRq
	+qbkNwCQPZrRcqK6nP6FyYr2MAFIIq/SzJbqhCrgO3Ic9xjAn1f8EyoYaemGgi8=
X-Google-Smtp-Source: AGHT+IFtYge95QNga/wjRnD7KwWq5ETL8PgfLE8RBv3uSS4wr6U/WMMwmKP1aKBGaA3YJd3fmC1zIQ==
X-Received: by 2002:a17:907:7f88:b0:a51:e5a6:2f94 with SMTP id qk8-20020a1709077f8800b00a51e5a62f94mr1593969ejc.12.1712741878396;
        Wed, 10 Apr 2024 02:37:58 -0700 (PDT)
Received: from localhost (78-80-106-99.customers.tmcz.cz. [78.80.106.99])
        by smtp.gmail.com with ESMTPSA id qa34-20020a17090786a200b00a519423fdaesm6672415ejc.122.2024.04.10.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:37:57 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:37:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhZd9CxQxL-up7kA@nanopsycho>
References: <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal>
 <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
 <20240409153932.GY5383@nvidia.com>
 <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
 <20240409171235.GZ5383@nvidia.com>
 <CAKgT0Ufc0Zx6-UwCNbwtEahdbCv=eVqJKoDuoQdz6QMD2tv-ww@mail.gmail.com>
 <20240409185457.GF5383@nvidia.com>
 <CAKgT0UcqJr4s8jMGW0a4BA6gUs+ey9X2JAOpeEP9cBW1qHmizw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcqJr4s8jMGW0a4BA6gUs+ey9X2JAOpeEP9cBW1qHmizw@mail.gmail.com>

Tue, Apr 09, 2024 at 10:03:06PM CEST, alexander.duyck@gmail.com wrote:
>On Tue, Apr 9, 2024 at 11:55 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Tue, Apr 09, 2024 at 11:38:59AM -0700, Alexander Duyck wrote:
>> > > > phenomenon where if we even brushed against block of upstream code
>> > > > that wasn't being well maintained we would be asked to fix it up and
>> > > > address existing issues before we could upstream any patches.
>> > >
>> > > Well, Intel has it's own karma problems in the kernel community. :(
>> >
>> > Oh, I know. I resisted the urge to push out the driver as "idgaf:
>> > Internal Device Generated at Facebook" on April 1st instead of
>> > "fbnic"
>>
>> That would have been hilarious!
>>
>> > to poke fun at the presentation they did at Netdev 0x16 where they
>> > were trying to say all the vendors should be implementing "idpf" since
>> > they made it a standard.
>>
>> Yes, I noticed this also. For all the worries I've heard lately about
>> lack of commonality/etc it seems like a major missed ecosystem
>> opportunity to have not invested in an industry standard. From what I
>> can see fbnic has no hope of being anything more than a one-off
>> generation for Meta. Too many silicon design micro-details are exposed
>> to the OS.
>
>I know. The fact is we aren't trying to abstract away anything as that
>would mean a larger firmware blob. That is the problem with an
>abstraction like idpf is that it just adds more overhead as you have
>to have the firmware manage more of the control plane.
>
>> > It all depends on your definition of being extractive. I would assume
>> > a "consumer" that is running a large number of systems and is capable
>> > of providing sophisticated feedback on issues found within the kernel,
>> > in many cases providing fixes for said issues, or working with
>> > maintainers on resolution of said issues, is not extractive.
>>
>> I don't know, as I said there is some grey scale.
>>
>> IMHO it is not appropriate to make such decisions based on some
>> company wide metric. fbnic team alone should be judged and shouldn't
>> get a free ride based on the other good work Meta is doing. Otherwise
>> it turns into a thing where bigger/richer companies just get to do
>> whatever they want because they do the most "good" in aggregate.
>
>The problem here in this case is that I am pretty much the heart of
>the software driver team with a few new hires onboarding the next
>couple months. People were asking why others were jumping to my
>defense, well if we are going to judge the team they are mostly
>judging me. I'm just hoping my reputation has spoken for itself
>considering I was making significant contributions to the drivers even
>after I have gone through several changes of employer.

Let me clearly state two things this thread it running around all the
time:
1) This has nothing to do with you Alex, at all. If John Doe was the one
   pushing this, from my perspective, everything would be exactly the same.
2) This is not about selling devices. I already stresses that out
   multiple times, yet people are still talking about selling. This is
   about possibility of outside-Meta person to meet the device in real
   world with real usecase (not emulated, that does not make any sense).

