Return-Path: <netdev+bounces-72036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D42985642B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BEE1C21E5D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB72212EBCD;
	Thu, 15 Feb 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rw3hMdWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84012FF64
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003187; cv=none; b=lK30OrHjYHe+YneBpwQdWYdj0qk91RCysp1dmAkTRFqYLwfTz/Kk+2wI+NOnAmgd0Qy0DxvALj6srThl0DSh/bj1Fay8HbZ8dXn1cH1nt2Fl2jq1vxpmc3XvOm+X2aUyft+/QEwRdO8HPVYZqfUERqEgp5ZEmBd9+vJ2QoLCfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003187; c=relaxed/simple;
	bh=ZnQQx7DmOUPei5ZBUK6aFPkWEKS5wn1JSyTl2ai2/UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfq22T94qjJCcCXpLhFJ5LSLVFsnW5Spb+mRRFVN3a7ZT92V448Z+zMDsH/HR3TovZi6X1BMjfS4SIkazmJQUt/mNf5QcpLSUjrruMzVkcieKC0BQcBrOMW7T4v73QL6FxJGr2XieIKHlr/kDwK5pNWRTKFp2axPgkqwkB4iWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rw3hMdWM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5119cfaeb9bso920634e87.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 05:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708003183; x=1708607983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gnG03kz/eXsl3jb1j6WsCdWQoBVjyPAlNZb5aSU1khY=;
        b=rw3hMdWMeGaSzM8UDaK8x9XrLimbru3MT7jgYNNX0QbAT9DCJA9Q32JYwNcxgE9ZxP
         gQ6NjW0ulgbeJNKp2t7URIyIdypxLLXfEElAINEQ/1s9eAJOGecFAOTBDWBGLq3rMyIB
         vwT/4W+IyAOIXOrxGV8MC0FVt4KDQkX8IGxkInXAjJcDNIj3a2WNC5Gd5aVzFHo2uXLP
         5KFAJVeFqKLJ2KRyUUrBq1e7T2Ib9rX2Iuxhrthy/OAuSHC/ehs2s1o66PUDPIRNaPdX
         ApcHa28dPlEMT2Z4LeS/U0YExnbyb3i3oLBOK0+BO7X/hN4v+aMQu2ZlkGGOibTv/8FC
         9NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003183; x=1708607983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnG03kz/eXsl3jb1j6WsCdWQoBVjyPAlNZb5aSU1khY=;
        b=vZlN9HYcR86c/f8lQW2ScyKkf9a+tXktLuUkLzohsCYefGIKL/KuWaNTRfSS543G0H
         wvtiPLrA+yRMtyjpqhQtp3EHLns3msVeLyBfCaBTJnVJrj53Vtbt1EnIB81Q9RO3Y4De
         zxdpP/C50Mvmt/NG0wYNrYGYmGmKvA2cEko7sWjEJPZ7HE9HgzQn9zeu5vfmE1DE5cZx
         afwoLx6OcYA4eyjh6HTGGY7qbzpmNcMVgzM3WUL6amliiABi0qxNBagbeIbew98H7poF
         tTs/nUUkJRgjvURuLqkpzio8Yn61uzHDNUvncG5IxiU8vINejMgg49fDwjAPRHwGEF2F
         Wufw==
X-Forwarded-Encrypted: i=1; AJvYcCUYPJz4zLrBsZlF8b4mpuDgOhTpZbYDxVwIzMETzMBQlrfRlzDHEe5BisPxws1zRiZnSwxP4UXEdWio5ARbkZmhRuW5GuIn
X-Gm-Message-State: AOJu0Yzy9Rwv3vb3CcM24BQ6/AiAoaF82tmbEN33zAiaM28JXLhYWd5S
	VuCLbhUaOVoHy6XCA8wRIfl9HO1eXEnL1AVZvBOEmtjjgpvfxBfeBib1FalMTWM=
X-Google-Smtp-Source: AGHT+IF87Yng2sbaIbh1iEi2rlzjmoWyxSkszjJm80RN1WA678PGoxGeF1fLGTs2EsMu9v+3/ed1cQ==
X-Received: by 2002:a19:e041:0:b0:511:7c27:9655 with SMTP id g1-20020a19e041000000b005117c279655mr1237656lfj.23.1708003183495;
        Thu, 15 Feb 2024 05:19:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b00560e72d22b8sm532306edb.2.2024.02.15.05.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:19:42 -0800 (PST)
Date: Thu, 15 Feb 2024 14:19:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
	saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <Zc4Pa4QWGQegN4mI@nanopsycho>
References: <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org>
 <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172633.010b1c3f@kernel.org>

Fri, Feb 09, 2024 at 02:26:33AM CET, kuba@kernel.org wrote:
>On Fri, 2 Feb 2024 08:46:56 +0100 Jiri Pirko wrote:
>> Fri, Feb 02, 2024 at 05:00:41AM CET, kuba@kernel.org wrote:
>> >On Thu, 1 Feb 2024 11:13:57 +0100 Jiri Pirko wrote:  
>> >> Wait a sec.  
>> >
>> >No, you wait a sec ;) Why do you think this belongs to devlink?
>> >Two months ago you were complaining bitterly when people were
>> >considering using devlink rate to control per-queue shapers.
>> >And now it's fine to add queues as a concept to devlink?  
>> 
>> Do you have a better suggestion how to model common pool object for
>> multiple netdevices? This is the reason why devlink was introduced to
>> provide a platform for common/shared things for a device that contains
>> multiple netdevs/ports/whatever. But I may be missing something here,
>> for sure.
>
>devlink just seems like the lowest common denominator, but the moment
>we start talking about multi-PF devices it also gets wobbly :(

You mean you see real to have a multi-PF device that allows to share the
pools between the PFs? If, in theory, that exists, could this just be a
limitation perhaps?


>I think it's better to focus on the object, without scoping it to some
>ancestor which may not be sufficient tomorrow (meaning its own family
>or a new object in netdev like page pool).

Ok.


>
>> >> With this API, user can configure sharing of the descriptors.
>> >> So there would be a pool (or multiple pools) of descriptors and the
>> >> descriptors could be used by many queues/representors.
>> >> 
>> >> So in the example above, for 1k representors you have only 1k
>> >> descriptors.
>> >> 
>> >> The infra allows great flexibility in terms of configuring multiple
>> >> pools of different sizes and assigning queues from representors to
>> >> different pools. So you can have multiple "classes" of representors.
>> >> For example the ones you expect heavy trafic could have a separate pool,
>> >> the rest can share another pool together, etc.  
>> >
>> >Well, it does not extend naturally to the design described in that blog
>> >post. There I only care about a netdev level pool, but every queue can
>> >bind multiple pools.
>> >
>> >It also does not cater naturally to a very interesting application
>> >of such tech to lightweight container interfaces, macvlan-offload style.
>> >As I said at the beginning, why is the pool a devlink thing if the only
>> >objects that connect to it are netdevs?  
>> 
>> Okay. Let's model it differently, no problem. I find devlink device
>> as a good fit for object to contain shared things like pools.
>> But perhaps there could be something else. Something new?
>
>We need something new for more advanced memory providers, anyway.
>The huge page example I posted a year ago needs something to get
>a huge page from CMA and slice it up for the page pools to draw from.
>That's very similar, also not really bound to a netdev. I don't think
>the cross-netdev aspect is the most important aspect of this problem.

Well, in our case, the shared entity is not floating, it is bound to a
device related to netdev.


>
>> >Another netdev thing where this will be awkward is page pool
>> >integration. It lives in netdev genl, are we going to add devlink pool
>> >reference to indicate which pool a pp is feeding?  
>> 
>> Page pool is per-netdev, isn't it? It could be extended to be bound per
>> devlink-pool as you suggest. It is a bit awkward, I agree.
>> 
>> So instead of devlink, should be add the descriptor-pool object into
>> netdev genl and make possible for multiple netdevs to use it there?
>> I would still miss the namespace of the pool, as it naturally aligns
>> with devlink device. IDK :/
>
>Maybe the first thing to iron out is the life cycle. Right now we
>throw all configuration requests at the driver which ends really badly
>for those of us who deal with heterogeneous environments. Applications
>which try to do advanced stuff like pinning and XDP break because of
>all the behavior differences between drivers. So I don't think we
>should expose configuration of unstable objects (those which user
>doesn't create explicitly - queues, irqs, page pools etc) to the driver.
>The driver should get or read the config from the core when the object
>is created.

I see. But again, for global objects, I understand. But this is
device-specific object and configuration. How do you tie it up together?


>
>This gets back to the proposed descriptor pool because there's a
>chicken and an egg problem between creating the representors and
>creating the descriptor pool, right? Either:
> - create reprs first with individual queues, reconfigure them to bind
>   them to a pool
> - create pool first bind the reprs which don't exist to them,
>   assuming the driver somehow maintains the mapping, pretty weird
>   to configure objects which don't exist
> - create pool first, add an extra knob elsewhere (*cough* "shared-descs
>   enable") which produces somewhat loosely defined reasonable behavior
>
>Because this is a general problem (again, any queue config needs it)
>I think we'll need to create some sort of a rule engine in netdev :(
>Instead of configuring a page pool you'd add a configuration rule
>which can match on netdev and queue id and gives any related page pool
>some parameters. NAPI is another example of something user can't
>reasonably configure directly. And if we create such a rule engine 
>it should probably be shared...

