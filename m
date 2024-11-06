Return-Path: <netdev+bounces-142422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A859BF089
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06051C210DB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377D1DE3DC;
	Wed,  6 Nov 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w/u4ju9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F98C11
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904049; cv=none; b=B4AmQmslmeK7s8OqWFtEcDlMNMI2E+PLb/Z4IMfRfOg+4qIG6Ef+pwUNV9PSsjKi0bXwlP+yQjqA1tpc1eLhXpCYGZQl+KQTY+woqrmBuP1NoK4POLNrggGCr+zot6F5JMMBOiYucaS0KUHvE6Tr7FT5bAOxQaT9HyasN6bzCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904049; c=relaxed/simple;
	bh=99fCRKPid8lzY1gxZb7aplekWpsFLmLYAz/6VnB+cE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNcRV3Uy5LUVYeeKdrMbTbyfpwiH+2tlLpsrRl6toBQFIs+NReAFLATWm38tFrhTIJeYlHnaseuJOgZRiAPzPFqh5FAkw0ZtA1SKiUOQs6B/JQF6TPw0pQ90z5lNHxkamXx1cOk2XDVTfRGjkValpM3EIr2fsTKFZqIjE8tlDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w/u4ju9w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315abed18aso57188945e9.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 06:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730904044; x=1731508844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yH4Bg+CaY/B//+9hbGIsvk3Cq/q1sqWXGfdu8J6uLwE=;
        b=w/u4ju9wEqfj7UT1Y6TQmuW8F8bywzy4ltWP5y3+KZiuwmqrfYywZ6Qyxzib7s1AbK
         nzlj94JsIuThWAaLl4AEwKmIiwDT9zEOgLPLrMrA8UlwtOoTfKHRcrZs/90d1YZvzbde
         RnHEiAuzJbPFSXzp8LLdQ5dB/yPAs6N7gZFgwGSo50Rs+Ogdkr8YdSkisoBec+4kHCQh
         uZqxzDHKL7v+ZYP22bjsvkPP4soogLKLzJzmSQwYAlwA40MLr0sTKCQbNZk37pzR01hG
         kmbbeFiU4SHSnCUsrdi+TFCwQM7Ri9AHy38xmr+kOQTseC/m6JyzLnzN4KBcgp6foinh
         9p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904044; x=1731508844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH4Bg+CaY/B//+9hbGIsvk3Cq/q1sqWXGfdu8J6uLwE=;
        b=wJ9EyBFsg3kxmet/4tpPeXo2Lc8+pz7NQdyjHluH3AMtsL1AHvyMrawsKEcXSs2Ny9
         ePYTbiFRoBSKH8gtjKKfeIIeZQGCWRHoRg8doALKWADMeRJdn2M+AiyPCWyNfCZxxOc0
         6Q58Nb5KxfO73GAIlMI90kXzix7CDHf4Wi/1T5hImOJOHAz2oBwDj6Vs2jz4LvVcSFtd
         j8Zb7o1K//c95ICmIfFKgEJ9FgZ9Pq/AOw7UR18as0ShgGwmmiWQv0SEmyM72/xSDQ8G
         sm22tMPBuNc1n8SE7f96xGUzQ4u+Mlpmdm6KuNIpBU5jR3o8RMh/rI7h6AjKoG6sNoLH
         taUw==
X-Forwarded-Encrypted: i=1; AJvYcCUOC69fyl4BXT1GLJCSfphUD2nMlW91qTs1yyILPV7CDWUueMp1Lr0rAA3lAdtl70mPQqYqbuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHb4X1dWUnT+Y79fGEIwZy9yptA4Y9zTYSkWFqu+C40sCi7NJ
	UKixp2kS0lnzKAGfBzwG6clBsCbjUb1ZOs9Asby+B39T/mk5CL+87c9klPh2ztQ=
X-Google-Smtp-Source: AGHT+IG/epgpIGkPh0Q5EJMKbDGJ7yS1lgbQcl+Yh7JOLFvr/rm4jVhxbvS469EJQu8b8yLsCoq2/g==
X-Received: by 2002:a05:600c:511c:b0:431:5533:8f0b with SMTP id 5b1f17b1804b1-432832972bbmr159644995e9.32.1730904043893;
        Wed, 06 Nov 2024 06:40:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6f34easm26531655e9.42.2024.11.06.06.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:40:43 -0800 (PST)
Date: Wed, 6 Nov 2024 15:40:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org
Subject: Re: [Question]: should we consider arp missed max during
 bond_ab_arp_probe()?
Message-ID: <Zyt_58BFKnZvtsHx@nanopsycho.orion>
References: <ZysdRHul2pWy44Rh@fedora>
 <ZysqM_T8f5qDetmk@nanopsycho.orion>
 <Zys2Clf0NGeVGl3D@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zys2Clf0NGeVGl3D@fedora>

Wed, Nov 06, 2024 at 10:25:30AM CET, liuhangbin@gmail.com wrote:
>On Wed, Nov 06, 2024 at 09:34:59AM +0100, Jiri Pirko wrote:
>> Wed, Nov 06, 2024 at 08:39:48AM CET, liuhangbin@gmail.com wrote:
>> >Hi Jay,
>> >
>> >Our QE reported that, when there is no active slave during
>> >bond_ab_arp_probe(), the slaves send the arp probe message one by one. This
>> >will flap the switch's mac table quickly, sometimes even make the switch stop
>> >learning mac address. So should we consider the arp missed max during
>> >bond_ab_arp_probe()? i.e. each slave has more chances to send probe messages
>> >before switch to another slave. What do you think?
>> 
>> Out of curiosity, is anyone still using AB mode in real life? And if
>
>Based on our analyse, in year 2024, there are 53.8% users using 802.3ad mode,
>41.6% users using active-backup mode. 2.5% users using round-robin mode.
>
>> yes, any idea why exacly?
>
>I think they just want to make sure there is a backup for the link.

Why don't they use LACP? You can have backup there as well.

>
>Thanks
>Hangbin

