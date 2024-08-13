Return-Path: <netdev+bounces-117919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE994FD5C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305CC1C22849
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1FA2C19E;
	Tue, 13 Aug 2024 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EIq8E9Yq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E13BB21
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527715; cv=none; b=NSj3ARxdJ4LhDcyHVv/0Fz/Z1XSXcTRJTNjz7gLUlPFztqEI9S0fC9in2sQLwD8B+OMeyAWwuwQX+MYZrdtJJWoMmokunPx2XuBip5qqKiSK44t5yppkZ7EJ2jOhnMxTo+khL6Xgw1KPIGc6doGZb66rUV6LyP8HaYvrTToGLQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527715; c=relaxed/simple;
	bh=fY/+L8l5ii+AgzZtNjqwOV5aIJKUFkgY7GEi/jLl3fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n02aej0R+xzZFMGOC+WXSXfreIYOxrPbYL7XXA5Xf+xvoNMUviFLCY1RMXNcEB+G0kO7IvRSpnEz/SmEvrziSFR7dhr54zVnge3PiYpGa8hzoJaRiM98CC0ULtBJQp4pU31wzFP4I8UlweX+We2pZJ1DVdFB65WoUrn43h1XgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EIq8E9Yq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42809d6e719so39068635e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 22:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723527711; x=1724132511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vu66s/MTj9mzSOP2T0sqELP/S3U/U+aUqAs4Pl23wBI=;
        b=EIq8E9YqqwPdh2AchpmCC0yfHaukCk4jZYbHntiQde89VwRzdGejDLBdoKoSzTdzCt
         YA8U7qecI4ER5r6M9TrFOiU38isNiFhy7Ac8EmGShRY6q2cfNqPjEygbNB62sxEKWwli
         6IeauXnUjM9FTWCUebhbSPctieQ7Hvg7356YGG0ALK2OtGN9DOYOFinAvuHf9Zn+7HDD
         7tKk8PDnYRkpN/DBmMdDZQV+xMKZBzkjyen0tRBcKqqxlub8/NnZLYtem9ZW403rlwng
         wFXlNwYCHv4EbI4kZRRnMCRKSAsPolMPfjF9xX4StuZ93ltS/3Wg24q3Wa95jGlTgXsL
         uYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723527711; x=1724132511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu66s/MTj9mzSOP2T0sqELP/S3U/U+aUqAs4Pl23wBI=;
        b=pvy80TlmXyciORWbXe50IEd+1qZ5J4nbDJslrFHC+SvOJ2UEugkdihHT9EazCh6uO/
         KKqQSz1k1LfNNYu68pqK88Iox6nKdew38ue3AtFReigTaxFPIVgkWCoRnuGG5ChUGyjY
         6gwH76iZ5a+M+15YhvWdZNFMLLpwi+sBqtJCUb/1okp96MotaSmbIv9N7x8NWrcO4grE
         Rozuav72/m3amM5+pmYqzU8rXKkcwzZdiJNtP0FgBHF55FOMixqpy9qt4xsVynESnCv7
         3T+5hT9yEz219U7xE0m3+wOHw4j72GydQyx5FjJ/CcfVCKELXZUhlieHKXLiywLhmqXW
         Yjqg==
X-Forwarded-Encrypted: i=1; AJvYcCWrzACRzYcpPpHH3N50jLRWdBVMTfm0i4duXz0rC+++1R/OAtJ57zsWUiisQxRh9V+O7aDTy0hFQgY0/nsuIUw0E8pCUJj0
X-Gm-Message-State: AOJu0Yxs2WKKzqYJPtn5GmZ6TJj7Ztzdx6qsdF+7O/g8vdlQ3aBUNaMO
	SxRjX9Q2ZdPiC5/AzmskbrK3iI7jDAUZzBgsFuZOzxwZ80zZpxymNNFaVNj4JVc=
X-Google-Smtp-Source: AGHT+IHV0row3uLNcJDWvblITgnetX5YEnxG01/khyJPskb8RTxM1tIYbNpzxFrW94vyED6ZPdgVPA==
X-Received: by 2002:a05:600c:1d02:b0:426:67ad:38e3 with SMTP id 5b1f17b1804b1-429d47f4295mr17448965e9.3.1723527711349;
        Mon, 12 Aug 2024 22:41:51 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738eb4sm210792575e9.14.2024.08.12.22.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 22:41:50 -0700 (PDT)
Date: Tue, 13 Aug 2024 07:41:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next 4/5] devlink: embed driver's priv data callback
 param into devlink_resource
Message-ID: <ZrryHH4VbiPSdFzx@nanopsycho.orion>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-5-przemyslaw.kitszel@intel.com>
 <ZrMZFWvo20hn49He@nanopsycho.orion>
 <20240808194150.1ac32478@kernel.org>
 <ZrX3KB10sAoqAoKa@nanopsycho.orion>
 <589aed8d-500c-4e92-91ca-492302bb2542@intel.com>
 <Zrojg-svvDA7_OUV@nanopsycho.orion>
 <2c38d704-f018-4bc6-b688-a7a7ce4adc0a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c38d704-f018-4bc6-b688-a7a7ce4adc0a@intel.com>

Tue, Aug 13, 2024 at 05:45:47AM CEST, przemyslaw.kitszel@intel.com wrote:
>On 8/12/24 17:00, Jiri Pirko wrote:
>> Mon, Aug 12, 2024 at 01:50:06PM CEST, przemyslaw.kitszel@intel.com wrote:
>> > On 8/9/24 13:02, Jiri Pirko wrote:
>> > > Fri, Aug 09, 2024 at 04:41:50AM CEST, kuba@kernel.org wrote:
>> > > > On Wed, 7 Aug 2024 08:49:57 +0200 Jiri Pirko wrote:
>> > > > > > 	lockdep_assert_held(&devlink->lock);
>> > > > > > 
>> > > > > > 	resource = devlink_resource_find(devlink, NULL, resource_id);
>> > > > > > -	if (WARN_ON(!resource))
>> > > > > > +	if (WARN_ON(!resource || occ_priv_size > resource->priv_size))
>> > > > > 
>> > > > > Very odd. You allocate a mem in devl_resource_register() and here you
>> > > > > copy data to it. Why the void pointer is not enough for you? You can
>> > > > > easily alloc struct in the driver and pass a pointer to it.
>> > > > > 
>> > > > > This is quite weird. Please don't.
>> > > > 
>> > > > The patch is a bit of a half measure, true.
>> > 
>> > Another option to suit my wants would be to just pass resource_id to the
>> > callbacks, would you accept that?
>> 
>> Why, the callback is registered for particular resource. Passing ID is
>> just redundant.
>
>Yet enables one to nicely combine all occ getters/setters for given

I don't see the benefit, sorry :/

>resource group. It is also straightforward (compared to this series).
>You are right it is not absolutely necessary, but does not hurt and
>improves thing (this time I will don't update mlxsw just to have
>consumer though, will just post later - as this is not so controversial,
>I hope).
>
>> 
>> 
>> > 
>> > > > 
>> > > > Could you shed more light on the design choices for the resource API,
>> > > > tho? Why the tying of objects by driver-defined IDs? It looks like
>> > > 
>> > > The ids are exposed all the way down to the user. They are the same
>> > > across the reboots and allow user to use the same scripts. Similar to
>> > > port index for example.
>> > > 
>> > > 
>> > > > the callback for getting resources occupancy is "added" later once
>> > > > the resource is registered? Is this some legacy of the old locking
>> > > > scheme? It's quite unusual.
>> > 
>> > I did such review last month, many decisions really bother me :F, esp:
>> > - whole thing is about limiting resources, driver asks HW for occupancy.
>> 
>> Can you elaborate what's exactly wrong with that?
>
>Typical way to think about resources is "there are X foos" (resource
>register time), "give me one foo" (later, on user request). Users could
>be heterogeneous, such as VFs and PFs, and resource pool shared over.
>This is what I have for (different sizes of) RSS contexes.
>(Limit is constant, need to "get*" resources by one at a time, so driver
>knows occupancy and arbitrages usage requests).
>
>"get*" == set usage to be increased by one
>
>> 
>> 
>> > 
>> > Some minor things:
>> > - resizing request validation: parent asks children for permission;
>> > - the function to commit the size after the reload is named
>> >   devl_resource_size_get().
>> > 
>> > From the user perspective, I'm going to add a setter, that will be
>> > another mode of operation (if compared to the first thing on my complain
>> > list):
>> > + there is a limit that is constant, and driver/user allocates resource
>> >   from such pool.
>> > 
>> > > 
>> > > It's been some while since I reviewed this, but afaik the reason is that
>> > > the occupancy was not possible to obtain during reload, yet the resource
>> > > itself stayed during reload. This is now not a problem, since
>> > > devlink->lock protects it. I don't see why occupancy getter cannot be
>> > > put during resource register, you are correct.
>> > > 
>> > I could add that to my todo list
>> 
>> Cool.
>
>I guess no one cared about it yet, as resource register and occ getter
>register is much separated in code space (to the point of being in
>different file).

