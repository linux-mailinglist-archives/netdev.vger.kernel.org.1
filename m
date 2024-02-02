Return-Path: <netdev+bounces-68275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3378465C6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33304289A20
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0534D8839;
	Fri,  2 Feb 2024 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz6yYBtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129FBE45
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840752; cv=none; b=Pu9Jcw3C9oRFnR08BGrMVfMjoUPSIe2/It2JF2in2/KgSH2r8HkUMNqj6kRM+ky7n4LTn5106alw3fM4Tl3Jt84R3O39M81FGbPj2oduYiGcm+7MyhvUHxzTzr/+YYX8WGoXI9FTxh50I2cftfdE3n4m3tg3bfAwe+vOm3GcWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840752; c=relaxed/simple;
	bh=3yORcxd+xpueA4z7Bijm9hqEGEcXRqYXA69iKG9mrK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDTAaYkoL5mqm6ONIqg8N4DJEK4H4AmYtogg3Eu/nkj/kf3aO3gOQtSsvoHG2VY6eDZ1v0v5MeiZ7c045qkjUJKvVTn7drmr36GcRz9MXhF7ZPekVy879KBXkoyeaAYksvEgNgt0GmQK5AmhPjRnMwmHHO5p/A0C81BOiVwyWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz6yYBtC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6df60be4a1dso1187364b3a.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 18:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706840751; x=1707445551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0WLlOFquUGLZU7b5whU/RrHcyoJ3HcNcc+l5vn4mVQ=;
        b=Kz6yYBtClfUeiEAIaV7KLgKZumsv0GxcdH7a11Rqro5gYu5OuKgbhLXMSqS4l3wWcJ
         i+3f9jw9oaPYfTV7fzuRfIy1TyCoPBPfmN27TvqiyEuRQoLucGwH1Y9d+N1ovWH/qQcn
         bgHETZjOiS9+hoqFTsjWqmKlRzpE6mUePSjrxm8eImv58n7zbFJ5CoCsb67+YTeuZ16N
         3wEYmVkxHsQ++W3dXUqy+TQF+ZmqZBMoP/pV16nEOLRf3JCl8SBPZDbVlfzb5i1AKUkm
         6YigCMRnY2SFA2/1YouceBAZ1lW1jNE6zECq27Zp+IkGmu2F6yRzyZpl3oha0WWMVGCw
         jc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706840751; x=1707445551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0WLlOFquUGLZU7b5whU/RrHcyoJ3HcNcc+l5vn4mVQ=;
        b=BONYBV7jCdsiCnV3Jn7kJ5XRD6gt+ysguNlTLWn5Y7QyiJ+vuuVxD1GYRr7A9hwt1/
         SoyPqfs78Wu7v0yp86xKXMXLUOurvPJSt7are6eJwhHUXfTtsM71lnXatUF0LIXdOKf+
         QX/vdGBcgd1LTsHZ5IaMwAQQwSxNKIs19fsMiYFeZdacaMPHusDUKDcuwnYQ0DiZ9aas
         DQ8tAvscJp5R2c5FQ78dS3XUnXHznrSuYw3osZgtclMOpflj9I4iaILwiagaxIBVQSG+
         zVmc6Tjd1D171heioMkAmhjDi89sUshBYWH/DKC2jZA5HD05fuXQ0Ij/+7M5I+NWA+di
         jjYA==
X-Gm-Message-State: AOJu0YyG3I/go4WVsE5HVFTzccStl3NMlA1vTdQoicvF1n/CjxZzPNJT
	sHEuqYwYXu0mbUTw4yOF/H6+W17ZLldTHMoAK0FSIcP8/HVpFu96
X-Google-Smtp-Source: AGHT+IEkaTWmnN58XDwsOM3FPt/lp8K7+0sHqo64lMUqcCgHC8SJdVp/rK+2gvIkR6iRqdYMoPW5SA==
X-Received: by 2002:a05:6a20:1450:b0:19c:6b53:6328 with SMTP id a16-20020a056a20145000b0019c6b536328mr5563774pzi.1.1706840750739;
        Thu, 01 Feb 2024 18:25:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsAwo7BcGMmY63QHiGd8Cp30K78R9PFQ57E8h1QwnjasaaD/FuPL4eAcV9MPzf0JRrkrBovyHLIAJVhK/MpSgbgQzCL8IXf5s8sW9iFZ+X9FypEhSCHXlP7XCUijlzAZogQ02wrlfH6NFQlxK6eXFqRbOewFWulM26MBgNqTP1bAlD0hmf19u1mWGNhZk0JttFFJAz6meDLmvtU0OLL4zKORGJnxZ0MnWsvm4ZeCIrrlGwRHT6PNBTwRj6OV5xy6IxMXwV7UPM1ZOtc6Cz8OdvbfonOziMi/6Kc0iif4MxW0ovyZsc6XNtGzBmWkb1DWg81Qpv5mE=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u27-20020a62d45b000000b006ddd31aae37sm468152pfl.33.2024.02.01.18.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:25:49 -0800 (PST)
Date: Fri, 2 Feb 2024 10:25:45 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
	martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kuifeng@meta.com
Subject: Re: [PATCH net-next 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Message-ID: <ZbxSqfD_UP44h_vz@Laptop-X1>
References: <20240131064041.3445212-1-thinker.li@gmail.com>
 <20240131064041.3445212-6-thinker.li@gmail.com>
 <ZbtabpEr7I6Gy5vE@Laptop-X1>
 <22cc962a-c300-49ee-95ee-76d9f794e23a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22cc962a-c300-49ee-95ee-76d9f794e23a@gmail.com>

On Thu, Feb 01, 2024 at 09:14:17AM -0800, Kui-Feng Lee wrote:
> > > +	N_EXP=$($IP -6 route list |grep expires|wc -l)
> > > +	if [ $N_EXP -ne 0 ]; then
> > > +	    echo "FAIL: expected 0 routes with expires, got $N_EXP"
> > >   	    ret=1
> > >   	else
> > >   	    ret=0
> > >   	fi
> > > +	log_test $ret 0 "ipv6 route garbage collection"
> > > +
> > > +	reset_dummy_10
> > 
> > Since you reset the dummy device and will not affect the later tests. Maybe
> > you can log the test directly, e.g.
> > 
> > 	if [ "$($IP -6 route list |grep expires|wc -l)" -ne 0 ]; then
> > 		log_test $ret 0 "ipv6 route garbage collection"
> > 	fi
> > 
> > Or, if you want to keep ret and also report passed log, you can wrapper the
> > number checking like
> > 
> > check_exp_number()
> > {
> > 	local exp=$1
> > 	local n_exp=$($IP -6 route list |grep expires|wc -l)
> > 	if [ "$n_exp" -ne "$exp" ]; then
> > 		echo "FAIL: expected $exp routes with expires, got $n_exp"
> > 		ret=1
> > 	else
> > 		ret=0
> > 	fi
> > }
> > 
> > Then we can call it without repeating the if/else lines
> > 
> > 	check_exp_number 0
> > 	log_test $ret 0 "ipv6 route garbage collection"
> 
> If I read it correctly, the point here is too many boilerplate checks,
> and you prefer to reduce them. Right?
> No problem! I will do it.

Yes, thanks!

Hangbin

