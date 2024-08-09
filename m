Return-Path: <netdev+bounces-117160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008BE94CF27
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B252F282D91
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC846192B64;
	Fri,  9 Aug 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xmh6ohv0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B518B488
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201326; cv=none; b=rOrNr7sqcBeIqmtgaEjjXKx+nl80vKRoesJX74/be03aCL+IejNN6Df98AKmbbFHWlLG6TrEv0Wa6OeENY/ufOjZQA7O2/rPIKDnJ4OSxI3lI/QXsU1hDIjP9jxQYrM4YlH3SNk8FjRIMpOhcTj2/u7fLyYnGiZAmenhVDmfDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201326; c=relaxed/simple;
	bh=PQCgs8EPQXnEt8Ks+VTLzwpQThc6ZyZAdDDqiAGg324=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWqf3XJong99Yl8XBD5hweSHhGK/erk5V7gvSE71oMbGTC5aOhTCgQeZ7Z/nm6ZamWYdXcdwP97LMAODmhU5Kb5vMhHms5D2AQnY2l2qfp5PIIP8XEGUWb3FOsJWPhT9fSp8Ed0G9PFhQHMUDpHs8r3s6OtOzvNiUuRqJM6oCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xmh6ohv0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f01afa11cso2341777e87.0
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723201323; x=1723806123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miIuvoOYUL+LhRfoXof/qQL9PS+Pgr3REb1pNfyuJak=;
        b=xmh6ohv01voF30bSyap3PF2FncrrFRp0mbeuvXNV00KYIR9i2hUyVTcoJ+9dLdTeTN
         WPwMe+MFuG/VAxQ8T6bMGga+/lQk2sGEIxkG2zHXcyZlN/JoOFp5KUtaAyDcWR1SATE8
         DLFHHMjDvTU1cPqVY7CL0ValUhpitZ//FV1j7sU+t1EYEOOTe9mojh/mdGFl791pQu5X
         XqG146al5oomXeKZRuvJm3wYmsVUT2qWEN4unB6ZRyWhIJPVQyFl7+uaX9p8WFoqnT1j
         m7qJlTPNeZ/sKSSkT3S14ucvYocHlHKlQjPGGtkcqKaP8qF6riIQzekoxgFgpuiU6P84
         E/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723201323; x=1723806123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miIuvoOYUL+LhRfoXof/qQL9PS+Pgr3REb1pNfyuJak=;
        b=fysTxVCkHPU6Me3dFeoyn/PjAQk6J06HTmmwpOUzUhWRWKnR5J+IJrX6ASP4+37idI
         D5UGszFc8exfCUvC9oZWVdXmGdsSylY2Pt+Pmzcn6OsFIn6UHnf2zMke2RISyx2PLCve
         l2Oh3UHKDThpH9I2VN8rN+a+oKzpTRE6GvVNJCGli2o60fPCae/vVswLco5up8/q0ZG/
         GcCWH4Mh2D459TrZkEvgk2Z1dk/NwYsawmGDYnajknyTa6FEPO0aZzWI/nbR/wUy1Y+O
         qih5vCwBgFU5+YXfjhu27Y7YjdQwSrTXh5DmSq3FL68S1tLBFUWv5STtwIun3WvgifJJ
         0rwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKpphL61UwB565NE7z2v2ESR3gGcP5EofJh6OmYzsg7KWNQDM7yKtfnf2JJmpdErNeplwwxAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YzrogKIVYgp1HX7B3zxKGx6vQcdcNpiil79LKatATgfVNnU6
	IcfVa43bUjE26PJdrCCR2dwGVSnTR3ot8nXD1k9xT7akUimNHPyoMPRGCvm1TIc=
X-Google-Smtp-Source: AGHT+IG0ai8LXIj/X1xheIoF/lNRsFi5gLt4r5rtu3byQEw/TLFw0WK2cuUxU/aum31uE76Wwp77hw==
X-Received: by 2002:a05:6512:3086:b0:530:e1f6:6eca with SMTP id 2adb3069b0e04-530ee9cf391mr946226e87.37.1723201322333;
        Fri, 09 Aug 2024 04:02:02 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437c6sm829317966b.129.2024.08.09.04.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:02:01 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:02:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
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
Message-ID: <ZrX3KB10sAoqAoKa@nanopsycho.orion>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-5-przemyslaw.kitszel@intel.com>
 <ZrMZFWvo20hn49He@nanopsycho.orion>
 <20240808194150.1ac32478@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808194150.1ac32478@kernel.org>

Fri, Aug 09, 2024 at 04:41:50AM CEST, kuba@kernel.org wrote:
>On Wed, 7 Aug 2024 08:49:57 +0200 Jiri Pirko wrote:
>> > 	lockdep_assert_held(&devlink->lock);
>> > 
>> > 	resource = devlink_resource_find(devlink, NULL, resource_id);
>> >-	if (WARN_ON(!resource))
>> >+	if (WARN_ON(!resource || occ_priv_size > resource->priv_size))  
>> 
>> Very odd. You allocate a mem in devl_resource_register() and here you
>> copy data to it. Why the void pointer is not enough for you? You can
>> easily alloc struct in the driver and pass a pointer to it.
>> 
>> This is quite weird. Please don't.
>
>The patch is a bit of a half measure, true.
>
>Could you shed more light on the design choices for the resource API,
>tho? Why the tying of objects by driver-defined IDs? It looks like 

The ids are exposed all the way down to the user. They are the same
across the reboots and allow user to use the same scripts. Similar to
port index for example.


>the callback for getting resources occupancy is "added" later once 
>the resource is registered? Is this some legacy of the old locking
>scheme? It's quite unusual.

It's been some while since I reviewed this, but afaik the reason is that
the occupancy was not possible to obtain during reload, yet the resource
itself stayed during reload. This is now not a problem, since
devlink->lock protects it. I don't see why occupancy getter cannot be
put during resource register, you are correct.


