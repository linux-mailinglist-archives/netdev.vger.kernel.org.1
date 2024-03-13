Return-Path: <netdev+bounces-79601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558C787A1C0
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 03:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E951F21561
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 02:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506EC122;
	Wed, 13 Mar 2024 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnvmPDS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16BAD5D
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710298308; cv=none; b=t5bbf+Zd8HrD5uiSvMzVSQv88qiwbhSXSmB+X/2kWPhg9DSDlFzIIjpnPa6ODWe5/s0RCZE4nH7aDtosqx24aULC7iOsTqeMUQ65pMnFhMyBzMB2gQH0JFPJ+cX8f6MWewYfEmLDkiAwtnBvkmXAh/BgabpWHVBWbGmJqWBq1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710298308; c=relaxed/simple;
	bh=MjQXyfp692GO4NsrH/8xJYjQGzYpz4P/DAfS0GYxE4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4jkYxuCtv4rFsMFrsxDKjjBeJlOK7BBKOP0daONPlc0N7per7NsDp/ogQi85rZhpe9LKNeiQdXHMePnR2XBFEXbf9L9mOCDV5VolcQL2yncQ+3cYRhxgUTLPdP7mJt4yvDouij4mUyBuyna1TjvSjOLb+fDJNQxr1mHM3xeSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnvmPDS7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6afd8da93so935207b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710298306; x=1710903106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvUP5Ud9UXZnOrr8XoFx3vmNIdlVhQ09mNCR2p3QNgU=;
        b=RnvmPDS7GVoF06t2fSX8gYnmpebP/bHDlDIIip+strd1j4HUa+t5TlOayKTfsk2dh4
         QUfuXCX4G5EqiIgFOph4PxzOK5Gl5h93STNwvuDHoAzK6voDxxRKBOa7P6101eF1jnKt
         1BBuFYaLYREA0dYLMC5SqsYGxttqQBWObLhE3B8qPqosaiNY0zKN/2m2ZKiqVuk096AP
         F83LJbOnFEygtfnI2FwRhcFs7a3RMbS8ndzSdCQiFxMOR/kVT6+8CYF9dWW6YI2D2roP
         Z9UAxPJRM7IVm6mhQ5yM8YbglUbzK4KUicH/7/9IyJ0bxj6/9rqVyG6fhUrcRuOYE9Ac
         KvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710298306; x=1710903106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvUP5Ud9UXZnOrr8XoFx3vmNIdlVhQ09mNCR2p3QNgU=;
        b=u3K7dNmkalKZ/PLfi/hUvYI88peqH02poA/085c/AbXOKwhxJuO66o3DYigK8HUrgS
         fKMg8TiUf67OEkcGeFVgiOhXeon8Jy6n2GmsSCWixnPk7V6uWz8asxCOiPGgzsS4w1yc
         Ggkpb4gC031AqeKEUHX7Fvmfi5l/9uwHSEb9Ee2LjM/XD6388tKHHFYKhJGc36nkaLhR
         pOEn2MTUnpnGMPPDl5wPDiQ4bBTdYtyrj99/3LpQGTk+aB7/kUH3q3mFlAAJYNakTZHS
         w+ud4/3rJV6MvjpOsKbPmGiwsafzPcaIw3t1SBzSH5QiKQkfSC+ZMeYu7Gs6ozW6fkMX
         jAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/+bGdYgjmL17SA65JVuRja9dlbHrVjrSx0VeuvRgGi1iU8ByT7SLKU/gOnLrbj/+z3qa1Y6HuGSRPM0kha1292cHQGIz/
X-Gm-Message-State: AOJu0YwA983OxkhqT2IFIIQ54uV0cumUhD3yIRdwKSZ7wVVLAQxjzyFq
	5AR04v6juuSJrL7O9j6SDO29QLHteVVzfy/awepINREOp1E9Yrg54oJg+/inXo0=
X-Google-Smtp-Source: AGHT+IG/tp5ijZ+DPLkZb5jY0fTnWU7mrrtelv7Zp/rflP8ID969a82hrWpOdFkP2AIUi1OfTHmoNA==
X-Received: by 2002:a05:6a00:2d15:b0:6e5:6971:55f with SMTP id fa21-20020a056a002d1500b006e56971055fmr1309678pfb.28.1710298306341;
        Tue, 12 Mar 2024 19:51:46 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y7-20020aa79e07000000b006e66c9bb00dsm6949068pfq.179.2024.03.12.19.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 19:51:46 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:51:42 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: Re: How to display IPv4 array?
Message-ID: <ZfEUvmD8V1Yjwmk5@Laptop-X1>
References: <ZfApoTpVaiaoH1F0@Laptop-X1>
 <ZfBGrqVYRz6ZRmT-@nanopsycho>
 <CAD4GDZwxS1Av6XNkKnC-pmOWTwuc_u7JRLRkCXO5kJyy6wvwkA@mail.gmail.com>
 <20240312100105.16a59086@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312100105.16a59086@kernel.org>

On Tue, Mar 12, 2024 at 10:01:05AM -0700, Jakub Kicinski wrote:
> On Tue, 12 Mar 2024 16:04:56 +0000 Donald Hunter wrote:
> > > "nested-array" would tell the parser to expect a nest that has attr
> > > type of value of array index, "type" is the same for all array members.
> > > The output will be the same as in case of "multi-attr", array index
> > > ignored (I don't see what it would be good for to the user).  
> > 
> > I'd say that this construct looks more like nest-type-value
> 
> type-value is sort of a decomposed array, if we have all the entries
> under one nest I reckon array extension may be more appropriate.
> 
> My gut feeling is that we should generalize the array-nest type,
> when I wrote the initial spec we didn't have sub-type. How about
> we replace array-nest with indexed-array (good name TBD), and instead
> of assuming the value is always a nest pass the type via sub-type?
> 
> For bonding probably something like:
> 
>   -
>     name: linkinfo-bond-attrs
>     name-prefix: ifla-bond-
>     attributes:
>       -
>         name: arp-ip-target
>         type: indexed-array
>         sub-type: u32
> 	byte-order: big-endian
> 
> how does that sound?
> 
> exiting array-nests would change from:
> 
>  -
>    name: bla
>    type: array-nest
>    nested-attributes: bla-attrs
> 
> to
> 
>  -
>    name: bla
>    type: indexed-array
>    sub-type: nest
>    nested-attributes: bla-attrs
> 
> But that'd mean updating all existing specs and codegen.

This looks good to me.

Thanks
Hangbin

