Return-Path: <netdev+bounces-72289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2A85776C
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402D328188F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492118AE0;
	Fri, 16 Feb 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vggMJyop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBF1AAD3
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071048; cv=none; b=skiPphNBK8iyZu2P/ubdAiUGcq1A9R1N9gBfFzjPb9ald3U39cbEHUhLuX+aPqQtIxlthqFdz+Agx0osCF71z3lmKH9l9h/FPvn6vFuXBm7v+RpSlYGVIzdQnSpvM9BvBFM1w70oKALk2Xg1b59p2Zo5+T0m33WlYm/52qOillc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071048; c=relaxed/simple;
	bh=e9WERtha727XNOE1l0BX6VR7xVsEYnPmbpl0OqWP5s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3cZ0wD74QbqOUsihSZ1lEneSSh5x+RwlL9hnM0MPpSlyHbkkgShiDuVFrvXN0pZuUdr3Ies81Bbk9c0EgkLO83JQZ0d8aTXeJqVQ4lQCf8B/cvdYREkO+hHoXS+w84WSl3XXVsOzmzs7h7gyS42N44gprX5rZor5DPRNTVXpLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vggMJyop; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-411e71d8a2bso12332165e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 00:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708071044; x=1708675844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66P4yfeEYeVQS9dEd0ayA0vEqcIqzG8Fvk+kVYeb7H0=;
        b=vggMJyopgXBsp8VcwSZiIF6nYSbw/vMCuc6toblZXEmhvcIAVMgTPACKtb10+8j9gI
         HxNnD9ftIQpbX+SRLV1pMvuqzidQZowFX/xDOfHA0ytxqgu8m2s+aoZeN6SUNOyE/7cC
         YtsBlRLgQ3AY5FQNjLzIrXyZJchvjXU6PwCdvveGgJHUHupVeWzxQlIR4a50zANyh0hz
         9b6h70IyC89WjnKnZyLK9P7D7ba7e82CucNuT0IKdNzPWFRSU9QdvjgaV+zlrTxedJU0
         lfnYY+hWJuNrOXb4v1lxLb6k6Q6C6+KyCeEjWYWz3a7r9lnhIyvSoVG0OJBEvdUXD/Uq
         PwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071044; x=1708675844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66P4yfeEYeVQS9dEd0ayA0vEqcIqzG8Fvk+kVYeb7H0=;
        b=UbGecNJOCKpqyZtnqOdREx2hXT73MzlaXVzSf4QZ3cQMUa9N77x3mFlIM1wgW/bxoD
         Byh+U7Ribfg0zLSmjvzgBOn8qsY1or78+gSAJ11Flz+Dy2DLjnEoXZMv8m8JYrGJ2+LJ
         ZDKXaUsesQPJBNeATb8sbBip3jWSuofTPGHJ+Uxtt8LaV5GVbaHty1bbEPaF5pXm1uEt
         RFjpEtLz8eqUOjltuVUiDgMt4kcgrtoB6F+VuZJg7CJva2sujYasp68CLv56bz6UzE7M
         tyTECOHeDple3O0W3tArqRj+O/mWN3IUHtnvP7hxteIuGRfdeX62lgcf+yXoWjTiLB07
         D1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuWmfhnY1PDLcqnu9DM3Do37VeSnzjrOwwJyJmErg4qdy5OPxblS/TDFCjTtohTil4AQ2JkNA9IQYm8MVI1zTRc8rTHzf5
X-Gm-Message-State: AOJu0YxknYbbns6dmx9tcs4OBSQUEdaD2wL6jGXghu4KoQhCpgfh/6rN
	pYXaD1iXL4Q1BdmuLzYquLIDoJDBowsylIiQr+GbVFdW0JC7+8Mb9UzJD7U5vA4=
X-Google-Smtp-Source: AGHT+IEOHr6biwucULOlbBQvx+AvEFoZft2RKmJBDl05AImy3Hu1nqy+W5npj6oTxYZRITQytnMKBQ==
X-Received: by 2002:a05:600c:198c:b0:410:9b23:43fe with SMTP id t12-20020a05600c198c00b004109b2343femr2848520wmq.8.1708071043827;
        Fri, 16 Feb 2024 00:10:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b0041076fc2a61sm1572496wms.5.2024.02.16.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:10:43 -0800 (PST)
Date: Fri, 16 Feb 2024 09:10:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, William Tu <witu@nvidia.com>,
	bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
	saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <Zc8YgDOf6jKIHNsF@nanopsycho>
References: <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org>
 <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org>
 <Zc4Pa4QWGQegN4mI@nanopsycho>
 <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>

Thu, Feb 15, 2024 at 06:41:31PM CET, jacob.e.keller@intel.com wrote:
>
>
>On 2/15/2024 5:19 AM, Jiri Pirko wrote:
>> Fri, Feb 09, 2024 at 02:26:33AM CET, kuba@kernel.org wrote:
>>> On Fri, 2 Feb 2024 08:46:56 +0100 Jiri Pirko wrote:
>>>> Fri, Feb 02, 2024 at 05:00:41AM CET, kuba@kernel.org wrote:
>>>>> On Thu, 1 Feb 2024 11:13:57 +0100 Jiri Pirko wrote:  
>>>>>> Wait a sec.  
>>>>>
>>>>> No, you wait a sec ;) Why do you think this belongs to devlink?
>>>>> Two months ago you were complaining bitterly when people were
>>>>> considering using devlink rate to control per-queue shapers.
>>>>> And now it's fine to add queues as a concept to devlink?  
>>>>
>>>> Do you have a better suggestion how to model common pool object for
>>>> multiple netdevices? This is the reason why devlink was introduced to
>>>> provide a platform for common/shared things for a device that contains
>>>> multiple netdevs/ports/whatever. But I may be missing something here,
>>>> for sure.
>>>
>>> devlink just seems like the lowest common denominator, but the moment
>>> we start talking about multi-PF devices it also gets wobbly :(
>> 
>> You mean you see real to have a multi-PF device that allows to share the
>> pools between the PFs? If, in theory, that exists, could this just be a
>> limitation perhaps?
>> 
>> 
>
>I don't know offhand if we have a device which can share pools
>specifically, but we do have multi-PF devices which have a lot of shared
>resources. However, due to the multi-PF PCIe design. I looked into ways
>to get a single devlink across the devices.. but ultimately got stymied
>and gave up.
>
>This left us with accepting the limitation that each PF gets its own
>devlink and can't really communicate with other PFs.
>
>The existing solution has just been to partition the shared resources
>evenly across PFs, typically via firmware. No flexibility.
>
>I do think the best solution here would be to figure out a generic way
>to tie multiple functions into a single devlink representing the device.
>Then each function gets the set of devlink_port objects associated to
>it. I'm not entirely sure how that would work. We could hack something
>together with auxbus.. but thats pretty ugly. Some sort of orchestration
>in the PCI layer that could identify when a device wants to have some
>sort of "parent" driver which loads once and has ties to each of the
>function drivers would be ideal.

Hmm, dpll does this. You basically share dpll device instance in between
multiple pci functions. The same concept could be done for devlink. We
have to figure out the backward compatibility. User now expects the
instances per-pf.


>
>Then this parent driver could register devlink, and each function driver
>could connect to it and allocate ports and function-specific resources.
>
>Alternatively a design which loads a single driver that maintains
>references to each function could work but that requires a significant
>change to the entire driver design and is unlikely to be done for
>existing drivers...
>
>This is obviously a bit more of a tangential problem to this series.

