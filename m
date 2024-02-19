Return-Path: <netdev+bounces-72841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01450859EF0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4931F23115
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B422092;
	Mon, 19 Feb 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2TquvYp0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0141400D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333151; cv=none; b=D9TA+DnS9t1F91QPv2teglaQ/e8IrgYC8o4lN4HWp63aT3/0s8OQ/9XoEwFDEel1iGmjcWSajlKa7RxYabKVyxc4PseW3W8aTR1sJwUOljtwKCN8qOIVDWjzHoFTGHEnUrdBnFxDT5w4aeMn7g0r/9lXjJTwtsit84rUlFbfpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333151; c=relaxed/simple;
	bh=cjynKTEcIH/0tfiYC4IoSxGknrYD2wk3mr1ODpGUo0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlCrMl5NwOHs3UO0+yBDjbX0mlzJmrERJmQGKpbIFQ+kIHJRHTMW7Xqu381r1dWXLkxh/XrcPhqMzYnaxtf289ai3GkjDqpZENm24Fy6/49IeAnrhzMrz/uTRVM2WdajHgG7QUrqSaxQWA3zQBzGCq01cwmsciIfkTJthy8PCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2TquvYp0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394b892691so2249360f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 00:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708333147; x=1708937947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7lwZJhTKYu5cOtBmwy3+wIrlTmXSmJK4ZA6IM7VbYU=;
        b=2TquvYp04eUy2OsVO5EmTB1EThXNAdub8tkfLuGkinBmwTlC/NkJR0Rb8v+e+x0cuv
         iU5hE/on6mHAxC5oliaPOUCKc8cfj+tCNzLdJXpD1kQ4q45ScP3DXXCBAgOJev3waqF+
         Y+Ao/D8CAlKFUkwB1jsfWk+o3ydTwj5ecBtuKEFBXp1OcbPmkN053OHY7LvUqPXqUaFG
         4BURRp1lCSFwQ/AS8SATeBmo6NTkgu44Jbg/CkY/OU2n4he7Ad1X5wZjcZQgEBPXUMWY
         veDmxsM8RsCxiAdgR6J3vw+0vLArv0KMfycMRNpeXUso0g/YzDIKpkDiEVgKCayuoc2t
         rG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333147; x=1708937947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7lwZJhTKYu5cOtBmwy3+wIrlTmXSmJK4ZA6IM7VbYU=;
        b=cg9yj5XwXdzd1lj/qrkOVjtRy/ZBZZMjinVt7j0oeK9z58Mnn9sl74TaF+/rBRJ4Av
         8/K916uSPYLLvcA0D5tfQRanTYUEZLc3Y3SPwlMLBV5147/XNS2Mp5VEAyP5Un85SC0c
         76aovRBYvsUSmH0EZgL3JHn80cEWNMPPSKssAqdHcEi8BgZtGnbNuXqGkvC33MuiNd27
         Y8yDugaXmG8ml5rI4IiSTa1a5NUbBX7+N5n5EiyeKnupIFulruMtRAImSJJRyroJaeil
         h7E2eUaeItjy1q+vCbEKchlOlNdYTFEkMoJLFZXfdnyBkDHLlBXfH97SGAp+3dq1PZ2H
         HPsg==
X-Forwarded-Encrypted: i=1; AJvYcCVkLlMZ/uPnMjOtyhcy4iVvH3TU9/pv89pvEmthwR5yDbmsE1WHUNUq6+DtUzflwsRR+HygiEmqTH4iNVAyjxPLc0bkjxFz
X-Gm-Message-State: AOJu0Yz94XF9hr2n7XU7cTGD7G0mcQgQFMfrrIuhNUQxGLRi/+5QRDpC
	CmZFT+7eHrEovqpEeE9eTXlQBhxdNtIL0eZD2tXny3brLEjPHxvQyoJMSvITNxA=
X-Google-Smtp-Source: AGHT+IFMszW94K1/ehzCCOiMpjqcOKYH2pWqXPD1dnl8yEEtOQSNcgR/wS40u/lfk/EaIKaK8BZhNA==
X-Received: by 2002:adf:e28b:0:b0:33c:e081:1ee9 with SMTP id v11-20020adfe28b000000b0033ce0811ee9mr11387236wri.9.1708333147122;
        Mon, 19 Feb 2024 00:59:07 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600003c400b0033d22852483sm8655284wrg.62.2024.02.19.00.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:59:06 -0800 (PST)
Date: Mon, 19 Feb 2024 09:59:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, William Tu <witu@nvidia.com>,
	bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
	saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <ZdMYVzJd-nu0OlL8@nanopsycho>
References: <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org>
 <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org>
 <Zc4Pa4QWGQegN4mI@nanopsycho>
 <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
 <20240215180729.07314879@kernel.org>
 <efc51aa7-9d5f-4c18-8f06-4a8df07a831a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc51aa7-9d5f-4c18-8f06-4a8df07a831a@intel.com>

Fri, Feb 16, 2024 at 10:47:50PM CET, jacob.e.keller@intel.com wrote:
>
>
>On 2/15/2024 6:07 PM, Jakub Kicinski wrote:
>> On Thu, 15 Feb 2024 09:41:31 -0800 Jacob Keller wrote:
>>> I don't know offhand if we have a device which can share pools
>>> specifically, but we do have multi-PF devices which have a lot of shared
>>> resources. However, due to the multi-PF PCIe design. I looked into ways
>>> to get a single devlink across the devices.. but ultimately got stymied
>>> and gave up.
>>>
>>> This left us with accepting the limitation that each PF gets its own
>>> devlink and can't really communicate with other PFs.
>>>
>>> The existing solution has just been to partition the shared resources
>>> evenly across PFs, typically via firmware. No flexibility.
>>>
>>> I do think the best solution here would be to figure out a generic way
>>> to tie multiple functions into a single devlink representing the device.
>>> Then each function gets the set of devlink_port objects associated to
>>> it. I'm not entirely sure how that would work. We could hack something
>>> together with auxbus.. but thats pretty ugly. Some sort of orchestration
>>> in the PCI layer that could identify when a device wants to have some
>>> sort of "parent" driver which loads once and has ties to each of the
>>> function drivers would be ideal.
>>>
>>> Then this parent driver could register devlink, and each function driver
>>> could connect to it and allocate ports and function-specific resources.
>>>
>>> Alternatively a design which loads a single driver that maintains
>>> references to each function could work but that requires a significant
>>> change to the entire driver design and is unlikely to be done for
>>> existing drivers...
>> 
>> I think the complexity mostly stems from having to answer what the
>> "right behavior" is. At least that's what I concluded when thinking
>> about it back at Netronome :)  If you do a strict hierarchy where
>> one PF is preassigned the role of the leader, and just fail if anything
>> unexpected happens - it should be doable. We already kinda have the
>> model where devlink is the "first layer of probing" and "reload_up()"
>> is the second.
>> 
>
>You can of course just assign it such that one PF "owns" things, but
>that seems a bit confusing if there isn't a clear mechanism for users to
>understand which PF is the owner. I guess they can check
>devlink/netlink/whatever and see the resources there. It also still
>doesn't provide a communication mechanism to actually pass sub-ownership
>across the PFs, unless your device firmware can do that for you.
>
>The other option commonly used is partitioning so you just pre-determine
>how to slice the resources up per PF. This isn't flexible, but it is simple.

I will cook up a rfc for the devlink instance to represent the parent of
the PFs. I think we have everything we need in place already. Will send
that soon.

