Return-Path: <netdev+bounces-187582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840EAA7E39
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 05:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E24B980569
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 03:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57817148827;
	Sat,  3 May 2025 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wHsjUTW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1D2904
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746241477; cv=none; b=umAziMjPxHE3ihj9QudVkeC1h9je/9aak+umXf1kRTWTAZhbiet072XC/2dkxdAq+k81IF27CeDanwVk4IPV5UOfcBxG9pXkIbhEepQPISNo9AkUH8pfoqDRxXw0QDFt1Oce535wjwYnAscen4/f4Onb4i5MQlmwINHglXbdfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746241477; c=relaxed/simple;
	bh=+9rqUUCI7wT5PVxEVv3eeYqCqiHYb9KWnZF0BZ7n5dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVu+wCla8LzrfCLIWgZfDdRXeq15pXtGnxccNIgP9MxV99TCOmGvkNicdR5zMPJ+KYlF9/wXln4omR9Ea3dkxOacibxn0yEN95HQCjisCxp1X9oXZWMofnm0adZc+ohKBxAMNsox9pIreWEsiktGyOC0Mb4PMxZOG+Xh5hZk3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wHsjUTW+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fd89d036so33075735ad.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 20:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1746241475; x=1746846275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spAJx+6kSOZnAKo534qBccv91Qak8FbrMr/za8+bbuY=;
        b=wHsjUTW+H/iqLiGMveCbt1x7+t4SAVCcyQZ2mc2vcGUFUzxGjamcSECwOxbYQc/IN+
         9oGp4T6nKjiYu3mlSZK+g/0uh7+5AbRSFT5Na7+I9WYzk43fXHiszHNs8gu3MDqaRZMG
         14nBqWiTVuQovxuXW0D7AS2Z0ii4VJ/cZGVEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746241475; x=1746846275;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spAJx+6kSOZnAKo534qBccv91Qak8FbrMr/za8+bbuY=;
        b=CMBAph62ovM8zZT/tKqos2yOtmDuTCQIjE6FI5aib61dpAj4iwFmjaszK0Q+H4SHBB
         iaWb+vz73AgWR20BNe0dWVFDAR5i5RG8XDu8Mmkp9UoYVEReDc8EoThQ5Cc/e/me8qFf
         0WeSv+RFgYO9pR9L4i3fhXOH0OEuMsgP3i61FxYRu1Yl3PhJZtXVhw/dMh64Vzu85J0O
         SteMRRPz0LD65Ejd8snLElMp9MXKcc0QNlrdBW9xJidVhJxnLD/h4D+VeAXGS3pLFATj
         plve5K1YthpZqJU2crhMWJwKrA+RQ1Z7migRMpiIKNGGrJ5o7fboRHOoCbQ7QN/VtrDy
         ezVg==
X-Forwarded-Encrypted: i=1; AJvYcCUEGRQFxHuxJXMPR91YKA3SHUGdiG+g+XOIpIndFv/CqRfm3eGjTdDrF4n9ERMCHNotyOqFFsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExpzWDjL4JSKnq3MnYGp8j6lJ0KfA2kEmBuIAWBxr+tlCuejI
	iflhNvjuHP581rEIj6fywaRz+3SgsDom0vJL44BZhoML1uo1R0B6VEtgB2NB3GI=
X-Gm-Gg: ASbGncsnmvYkw+WgrRfyM0CtGkJGghIrWyDIAjJ0YA0NsW7PE1ma7gfBPvEzNAdv7s1
	N5R3QnKvSFEmOddgAojEZsy/1NC65exP1CiXMFSfHlGFaZHSuEZC0l1vxBKeBnovZKSYOeSZ84U
	AtVJGY3wTDu4V88DjQrv8n86DsJ9nKtjWjfm9T9cGJZs0p31fDuV1a+9JGJ1Vde02TLzdB/PgbF
	jacSkZaQagaYL1SjTDqYkHBTl9XAGPUSo1vLMgJ5Bsl3HDo76o2B+xR8vXjmYuR3dKfxoX2qVw6
	uEGuccvBJEzKa7JQbWdvKZoZraIYokEqCcw0lESwSQsqy3DtqrfvPCATQUi/4nJDLxhMaNCtDzP
	YGfDrMFk=
X-Google-Smtp-Source: AGHT+IG3VNpdxfLND4HU0xp9nMVgtZLT1KhYE8XW782kfMwyoHq4++10+eFaT6qEWzpcLzsHrmuCRw==
X-Received: by 2002:a17:903:2343:b0:21f:45d:21fb with SMTP id d9443c01a7336-22e10308086mr80536105ad.3.1746241474709;
        Fri, 02 May 2025 20:04:34 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fd07sm15124305ad.153.2025.05.02.20.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 20:04:34 -0700 (PDT)
Date: Fri, 2 May 2025 20:04:31 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <aBWHv6TAwLnbPhMd@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250423201413.1564527-1-skhawaja@google.com>
 <20250425174251.59d7a45d@kernel.org>
 <aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
 <680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
 <aA_FErzTzz9BfDTc@LQ3V64L9R2>
 <20250428113845.543ca2b8@kernel.org>
 <aA_zH52V-5qYku3M@LQ3V64L9R2>
 <20250428153207.03c01f64@kernel.org>
 <aBFrwyxWzLle6B03@LQ3V64L9R2>
 <20250502191011.68ccfdfe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502191011.68ccfdfe@kernel.org>

On Fri, May 02, 2025 at 07:10:11PM -0700, Jakub Kicinski wrote:
> On Tue, 29 Apr 2025 17:16:03 -0700 Joe Damato wrote:
> > > The way I see it - the traditional permission model doesn't extend 
> > > in any meaningful way to network settings. All the settings are done 
> > > by some sort of helper or intermediary which implements its own
> > > privilege model.  
> > 
> > I agree that is how it is today, but maybe we are misunderstanding
> > each other? In my mind, today, the intermediary is something like a
> > script that runs a bunch of ethtool commands.
> > 
> > In my mind with the movement of more stuff to core and the existence
> > of YNL, it seems like the future is an app uses YNL and is able to
> > configure (for example) an RSS context and ntuple rules to steer
> > flows to queues it cares about... which in my mind is moving toward
> > eliminating the intermediary ?
> 
> Yes, AFAIU.
> 
> > > My thinking is more that the "global" settings are basically "system"
> > > settings. There is a high-perf app running which applied its own
> > > settings to its own queues. The remaining queues belong to the "system".
> > > Now if you for some reason want to modify the settings of the "system
> > > queues" you really don't want to override the app specific settings.  
> > 
> > Yea, I see what you are saying, I think.
> > 
> > Can I rephrase it to make sure I'm following?
> > 
> > An app uses YNL to set defer-hard-irqs to 100 for napis 2-4. napis 0
> > and 1 belong to the "system."
> > 
> > You are saying that writing to the NIC-wide sysfs path for
> > defer-hard-irqs wouldn't affect napis 0 and 1 because they don't
> > belong to the system anymore.
> > 
> > Is that right?
> 
> Typo - napis 2-4, right? If so - yes, exactly. 

Yes, a typo -- sorry for the added confusion.
 
> > If so... I think that's fairly interesting and maybe it implies a
> > tighter coupling of apps to queues than is possible with the API
> > that exists today? For example say an app does a bunch of config to
> > a few NAPIs and then suddenly crashes. I suppose core would need to
> > "know" about this so it can "release" those queues ?
> 
> Exactly, Stan also pointed out the config lifetime problem.
> My plan was to add the ability to tie the config to a netlink socket.
> App dies, socket goes away, clears the config. Same thing as we do for
> clean up of DEVMEM bindings. But I don't have full details.

Yea that makes sense. Right now, we are using YNL to configure NAPI
settings for specific queues but clearing them on graceful app
termination. Of course if the app dies unexpectedly, then the NAPIs
are in configured state with no app.

Having some sort of automatic cleanup thing (as you've described)
would be pretty handy.

> The thing I did add (in the rx-buf-len series) was a hook to the queue
> count changing code which wipes the configuration for queues which are
> explicitly disabled.
> So if you do some random reconfig (eg attach XDP) and driver recreates
> all NAPIs - the config should stay around. Same if you do ifdown ifup.
> But if you set NAPI count from 8 to 4 - the NAPIs 4..7 should get wiped.

Yea I see. I will go back and re-read that series because I think
missed that part.

IIRC, if you:
  1. set defer-hard-irqs on NAPIs 2 and 3
  2. resize down to 2 queues
  3. resize then back up to 4, the setting for NAPIs 2 and 3 should
     be restored.

I now wonder if I should change that to be more like what you
describe for rx-buf-len so we converge?

