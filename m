Return-Path: <netdev+bounces-72291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA585777F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209F1B22F9B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E31B946;
	Fri, 16 Feb 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3Lphuj25"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730F1BC20
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071339; cv=none; b=sW1yNXUnS9kfk9O8hdRVWFzyInE9zHpqTa4H6jEMMa1U2OzMMy1Fnz8mGDVf66gYjFETCEWMeY7e3hRxOGDZPcb0mZOqVPvTWtKn+6ZUi0uVtkk1/5MjPtD28E4sqi26Xn0lEA5dKDpX4fLJdjhnYu2DzJ2w4kvz9tiIcEWV69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071339; c=relaxed/simple;
	bh=3L/hz/lf/7MFoLStZYx4UGhXUVHf0EGVI7Cc7cl5eKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObcMZhiYO1IjvED94c1/gKEgyIanMHZV7GNvCNqBVC3Rv9bf1S1qltN0PsxVDYdlhHvDbYGH5Q/miCVOEwMC13U6OOoD9MDaXe6mAUn9xy1EHCrXmkgnZL8UUQRlc8dVQxpN/nySZeWjP8kKG1Q1nqrNNeJMcXLNuzCtOFM/9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3Lphuj25; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-339289fead2so990631f8f.3
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 00:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708071335; x=1708676135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GL4WmqvqiSIskyW4xR+Yk3Ow1yO5qB6abu8KWxhW6lM=;
        b=3Lphuj252zshFsxhjVlArkfrhkuBMQyhGGt+zBP+lLBCC9tKK07xeA8ICXThZ09EhG
         DVrnGIdHLYXtMNTkIVGz+GyP5Lz/KMp6Ib9KDtEIOCxstRx5SlgpiKmqZQJL+Agvj6TZ
         BFWAB3zEqlAwivNnalpZUSFxddvujBHniFm5TO730LD5n5+jpi2D0yLB2cGz/Zh/FwXE
         /F5DiPvBX7yztogum16bPqBfz67WBx1NgcMTBZpqtZkYjLykbzce/MhEYySk96ycL4V+
         kxXvxmDC94tICGCJbyDcSqt99Twdo+NagnmpT/zv4A9KivgUAz7WmCiLeBA3ynqodUko
         RN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071335; x=1708676135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL4WmqvqiSIskyW4xR+Yk3Ow1yO5qB6abu8KWxhW6lM=;
        b=tBLj2WOZa7taqAuHl6tBrKr2UttTRZ95KZ/y3bw7p5y5gFoMBOmrvEaEu06jl39Z2U
         fafctHOG3jr9A8PZClIpNFMVL/ufV85dSi6SzYItZCwsL0wOrbMzuOKn5ykrbZCefwXs
         ULM4NtzIwwvl8eqHbl4Zm7LNRugS9/cABrSBRO8rMT4iaE5x8JfMUvQnhSAC4Q09tjwG
         WMV8HiIDaJeKH4dqyDp8vGgH2lVhY+J6GvCaT6eXVhapWTRX164spcqQqtB09A2uwjzS
         e31BW9gG7A2oUOuXUvz6tMSGQNq5eQitkz8Ne8S3jpig7eKSLwyzuAUcCL0Macv0mX5u
         YISQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlsbGFD5eYeo1TDhUo6UmhzApaWaQ90xrXE72q+dGyi4aAJ5bSDT3hYZkLV/o9tpZyKCsW8VfjUNNY+ULLqhAmENRPJ0iQ
X-Gm-Message-State: AOJu0Yws3oyc9kgAFrvm0lvluYCjQAYLhnrDXhVl2IG2WXvUx3A+wHX6
	28teUAUVI6H1KlPSKPVTQQ2GTQwPJcBv+KczsDZG7OPUtSBSJU0De2Qsmpupnbk=
X-Google-Smtp-Source: AGHT+IHv3//RnTodpaQsMEJGkv4jyxWYdYjIp5FFAbcGwVYWV0We3jDvSurl+nxeBOYudt1DGkgI4w==
X-Received: by 2002:adf:f892:0:b0:33b:2300:9cdc with SMTP id u18-20020adff892000000b0033b23009cdcmr3590635wrp.46.1708071335111;
        Fri, 16 Feb 2024 00:15:35 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g1-20020a056000118100b00337d5cd0d8asm1457101wrx.90.2024.02.16.00.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:15:34 -0800 (PST)
Date: Fri, 16 Feb 2024 09:15:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, William Tu <witu@nvidia.com>,
	bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
	saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <Zc8Zo0rCBzmGqTLf@nanopsycho>
References: <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org>
 <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org>
 <Zc4Pa4QWGQegN4mI@nanopsycho>
 <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
 <20240215180729.07314879@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215180729.07314879@kernel.org>

Fri, Feb 16, 2024 at 03:07:29AM CET, kuba@kernel.org wrote:
>On Thu, 15 Feb 2024 09:41:31 -0800 Jacob Keller wrote:
>> I don't know offhand if we have a device which can share pools
>> specifically, but we do have multi-PF devices which have a lot of shared
>> resources. However, due to the multi-PF PCIe design. I looked into ways
>> to get a single devlink across the devices.. but ultimately got stymied
>> and gave up.
>> 
>> This left us with accepting the limitation that each PF gets its own
>> devlink and can't really communicate with other PFs.
>> 
>> The existing solution has just been to partition the shared resources
>> evenly across PFs, typically via firmware. No flexibility.
>> 
>> I do think the best solution here would be to figure out a generic way
>> to tie multiple functions into a single devlink representing the device.
>> Then each function gets the set of devlink_port objects associated to
>> it. I'm not entirely sure how that would work. We could hack something
>> together with auxbus.. but thats pretty ugly. Some sort of orchestration
>> in the PCI layer that could identify when a device wants to have some
>> sort of "parent" driver which loads once and has ties to each of the
>> function drivers would be ideal.
>> 
>> Then this parent driver could register devlink, and each function driver
>> could connect to it and allocate ports and function-specific resources.
>> 
>> Alternatively a design which loads a single driver that maintains
>> references to each function could work but that requires a significant
>> change to the entire driver design and is unlikely to be done for
>> existing drivers...
>
>I think the complexity mostly stems from having to answer what the
>"right behavior" is. At least that's what I concluded when thinking
>about it back at Netronome :)  If you do a strict hierarchy where
>one PF is preassigned the role of the leader, and just fail if anything
>unexpected happens - it should be doable. We already kinda have the
>model where devlink is the "first layer of probing" and "reload_up()"
>is the second.
>
>Have you had a chance to take a closer look at mlx5 "socket direct"
>(rename pending) implementation?
>
>BTW Jiri, weren't you expecting that to use component drivers or some
>such?

IIRC, turned out that was not suitable for this case by my colleagues.
You have to ask them why, I don't recall.

But socket direct is a different kind of story. There 2/n PFs are just
separate NUMA PCI channels to a single FW entity.

