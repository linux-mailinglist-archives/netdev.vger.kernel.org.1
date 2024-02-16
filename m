Return-Path: <netdev+bounces-72287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D1857759
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B1281FA0
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D62B175A9;
	Fri, 16 Feb 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JrWN3R3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D3C14AA0
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070805; cv=none; b=ZI86Z8ch2/JLES0yzFQCzB/HokLhc7RSmlTrQHHQGeOW55qpLZnQMezz0u8+pLUp05rodhIbGdiTr7xXr5uFbb8y3pSI2obMFC7GIUWfDaY5+tiLDJ3+7lEVAQY9G+Hc48AAY40BZhAWCbK+aESJv3h5Y3Aj4u6mVyuFvE4Px84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070805; c=relaxed/simple;
	bh=BXUi/fwVJuYazr7pNeMxBtNQQT+mDCZHCw4bqYxiAEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apH7tEDsr/8iIv2sRc+gvpvmfgRWJb3kne9PazT/7tUJxpKhqB/3ScuNIeztc4+jGYXzVfthf/Ep9hWXtH2GYYnNZXbXawSh0n7SDy9GU33OSzWg08fRxbL9fbAECGdboQFBfa3X53aVWk1f+hGXMHclbArDX0hfnsl442Lbis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JrWN3R3E; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0d95e8133so21057731fa.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 00:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708070800; x=1708675600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpTrSNsOIiUcM148E57K5OrzbBVz0+mSBYrP9Sq+6KY=;
        b=JrWN3R3EOl1Nu2oLyWRo/gewcNY4gO5wtWYndpDelxHp5hTiJZeUc2QUbM4nEBG9uP
         Nw9Em+r6SfA41zhl9bn8oDNJ705DXvaOWfd090A+SOgBW9NKNCnK/jLr2dr8SXwfaycN
         Qq2KmVK5YboWgdAzSluSA6i3KmTOJsHJMP0gx29gr/StQ72DkUMGZsRKbHhA49GE2kft
         WFixUvfkqVJppJQLoQYom9bUhpkTPV9adSRgmyPcxsBNpNboLok8jftD8iVc5PjwFrjQ
         2oSLu51PhQDTuWW3WOoOj8bM5aWFMlu+S8qigDHW2TczFBqqaXjHpghz09rLyDpLLyhP
         Prgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070800; x=1708675600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpTrSNsOIiUcM148E57K5OrzbBVz0+mSBYrP9Sq+6KY=;
        b=nLwa2nqxbzQ+jgeTpgiH1Z7wbZMEAgymqjA3l7L+1PIf8RP4UM2N9rpsjsaQNpXC2a
         eoFgoXYTTY5AgAipEXijX+ZeWZYoFSom5QchsmIPI+s1ZaA4mK6FDAbfzC7OwWvYEL/n
         t0dbsxq928/vq/EZ86fckvXdK5RqTTdH1k7W2f74cjpTdhhwV1x7a5NSCDpclPa1ECWV
         k7pBj2nwBvn15pSYe8CQNoDIopEboqxYfACzgfftBaj3ac+djE8JPj18fNL+38YII/it
         c/ikKBtmqlMmPTvSyq/oQycO529sZpUqORGeXaYwZKmM0B3cZ0OWrhZ3D0mTCWh/GD9m
         nVtw==
X-Forwarded-Encrypted: i=1; AJvYcCVFuMAUGok128PN9ZhwNt6rPMip1Mz+0Y4kkjYD25kmjw9wKNG1LrDnE0qpgG8Gv40z7XQtDAr9UfRsoPlrKoneMKfCd8jn
X-Gm-Message-State: AOJu0YymAMjDaRTbC6aQrQnpLgSmcTI2Wn82q8aXCzmjFXwKYl+/Ah5X
	ExXVqqd6OcQxydhpCqENY4wmJtBekySJE0DytgqS74zrAL/ZT0yXiUqmxshKp0c=
X-Google-Smtp-Source: AGHT+IFl2a8Hvfiubm516elCaU3chcExPWApkgi8u2IG0AG2YbugM6Bvn8w0FBVN0lyvjvoltBjJlQ==
X-Received: by 2002:a2e:2a85:0:b0:2d0:c95a:f31b with SMTP id q127-20020a2e2a85000000b002d0c95af31bmr3041555ljq.24.1708070800271;
        Fri, 16 Feb 2024 00:06:40 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d460c000000b0033b48190e5esm1444074wrq.67.2024.02.16.00.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:06:39 -0800 (PST)
Date: Fri, 16 Feb 2024 09:06:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
	saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <Zc8XjcRLOH3TXHED@nanopsycho>
References: <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org>
 <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org>
 <Zc4Pa4QWGQegN4mI@nanopsycho>
 <20240215175836.7d1a19e6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215175836.7d1a19e6@kernel.org>

Fri, Feb 16, 2024 at 02:58:36AM CET, kuba@kernel.org wrote:
>On Thu, 15 Feb 2024 14:19:40 +0100 Jiri Pirko wrote:
>> >Maybe the first thing to iron out is the life cycle. Right now we
>> >throw all configuration requests at the driver which ends really badly
>> >for those of us who deal with heterogeneous environments. Applications
>> >which try to do advanced stuff like pinning and XDP break because of
>> >all the behavior differences between drivers. So I don't think we
>> >should expose configuration of unstable objects (those which user
>> >doesn't create explicitly - queues, irqs, page pools etc) to the driver.
>> >The driver should get or read the config from the core when the object
>> >is created.  
>> 
>> I see. But again, for global objects, I understand. But this is
>> device-specific object and configuration. How do you tie it up together?
>
>We disagree how things should be modeled, sort of in principle.
>I think it dates all the way back to your work on altnames.
>We had the same conversation on DPLL :(
>
>I prefer to give objects unique IDs and a bunch of optional identifying
>attributes, rather than trying to build some well organized hierarchy.
>The hierarchy often becomes an unnecessary constraint.

Sure, no problem on having floating objects with ids and attributes.
But in case they relate to HW configuration, you need to somehow glue
them to a device eventually. This is what I'm missing how you envision
it. The lifetime of object and glue/unglue operations.

