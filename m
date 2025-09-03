Return-Path: <netdev+bounces-219647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C66B427AE
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF75E3800
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD36315761;
	Wed,  3 Sep 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0UAb1Ps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09112D8DA6;
	Wed,  3 Sep 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919637; cv=none; b=FBOZOXncV0oHWHgFQrYi53bkJ/e93cRXj/rjLMpa0hr4+vzKRIyFkvUzfndZb312fdExxeVphn59SbKe2WVReDmG7oLeadYMw3QXqQx0zPvSkBc6TXviOutbnQl4fYnOVzxzhInXYJ2Yj5fEkRqNztKSxyvs0jh4E+lPsVIjE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919637; c=relaxed/simple;
	bh=C2hAY7INmvGsaTMg5VSZEHBuZuox3UqW8ARZQkVGI0w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z/faoJzDzYzmH3ewReIgsdmNS9stUpUGD1Gy1DwDgaDtkWJFOs9XSE/eSiSLKaSEsxPkPy6Qek1p+ykkIlWIGD1r57YTwkpPn8xToqjKWzzFOwECqU2V8f1mxtLCXYM7qeG9q2+gfaVw37YZIIy/lhr1Rgal6ddcYs2CMgbvrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0UAb1Ps; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7f7742e71c6so17414585a.1;
        Wed, 03 Sep 2025 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756919633; x=1757524433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx3EdG8+5CrX23Fe+Kej5I4NIXOHb8mYU2LURNAI8JM=;
        b=m0UAb1Ps7qf7W0jqqwLRfUTXN42QzjvyH2O+Pyxw/Lfdb9LGy9FhtiVagjsSF9Vy/9
         4GcYd5yICFefcUkgfCAk8uxRwhfFXvcAqPmwmWmYGeSJoSzaSvoMksR7m9/mt4LxqwEK
         8njgB63LA6U/LTVrXbYKQg9F0z8kivKOHjCi/qFu34KN3h5tE593zsccrrTh4egeL5AA
         gq+IeU5Zy6bFOhCPWWl32+jKTFBXARUenhiJx/6sxLFg5x5AkrJ1riFfhAxCb3KKnRU+
         t5Kcwkp+usIHmzoDy044E7Ti8giVfxkMeLP4GBnB8wI+iztCAqLNR7Tix/RPrKJ8yRPw
         Z8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919633; x=1757524433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nx3EdG8+5CrX23Fe+Kej5I4NIXOHb8mYU2LURNAI8JM=;
        b=ixW7w24gExg9hQ5b4PIOrt6V2o7jY2GwTNbrQgVYSh0pNRxY70WUa9zapkfnzL1Gxr
         6ml0GwdjnVLXc7yG4L897LkTOPdrFGoGxH7AyhO0IyK0tO4lAflRlg1lZKAsFLUq8cMb
         c8CHRJlTt3i1R2nSbkt7bRd2chCNQ+9EUs1DdmewNPDaOljboLVJr9BPiFrGdAWLduiJ
         YpXcDL1IJjM6tIcEQUK3pUpPl2T1rrqkmOWElHshlzVzx6QTT4lVkDP/CAixaXNBFY9V
         l2kgKyKQ035kTVXGMZk5JjqfdBCU2Kx4Mt6axsRLYmYTkD8U5uQ+9Ze43acEl//lsnYu
         kgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf6MdhNoc6aAifhLPG50HfZNSV4v2pwALTJTWSFF70I0V7vZ2WDvkvipaPcdfwFRt0Xt7GPq1H1v/RgfM=@vger.kernel.org, AJvYcCXrXbZzkapNTmku47BntXmMBsiLHMo9bcngjTT7F77gMOOQS7ejlOpiEjXIeLGXZ3P03JfN1XI3@vger.kernel.org
X-Gm-Message-State: AOJu0YztLf9hV6VUoGI1AeDHX5X+qDjiK1xbvaDzraqGMdbmE+MC4srL
	EZn8Z88lVdqfZEq07sSYSBLmtnSzRheNI3sYvYYci1xI0JldwMGqS9Ac
X-Gm-Gg: ASbGnctg94JJZwNKPdF5hc/GoMBYGJjeiY57iJ/I2cWiy5R1Wy7s/j8RzIN7wi+GUcG
	caamw90aNj+a689zp6JibTsfgHWKQpX/nS4KCbSHEmmEH4S/+YUVmrdD5b+rd0+6DYqGnqZII/2
	0czV1gAJKbn9/+wmcpT1RB0qzo2M2zvVwPNeSYhH5v+dk/QIrMnOQMfJfhH6jCDC3cIXY9jow2N
	DNqqdpumiPcoWdOEaV8OEq2iS+By+9hJFg/K/KK9x9cWPJ734IOKw9SW5vARABd0Eln9OQzW+4+
	tzWDhlVpRc9idp5LsmE0bSWlfRVv6GiHC4kfgfr+1MT/FqsDGxuH1WQOAVYdyjjNQQsDCSvPz9d
	ZfHpp14yUSUbOY1o1+PxuE/0aoM6oiXGYiDXUXW5MOjgnNT/h1VGA1rNoGOvOP4Bluafnq/Qvxj
	Hb4Q==
X-Google-Smtp-Source: AGHT+IEyaVSC4HdW7YbvHVPqoMIBDbFbLTOUFyGpAyq4No9jI8fwuxQGryVgkoZi197op4qNDs6+Yw==
X-Received: by 2002:a05:620a:2544:b0:807:1e23:8100 with SMTP id af79cd13be357-8071e23923emr706686185a.36.1756919633490;
        Wed, 03 Sep 2025 10:13:53 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b48f501690sm14876011cf.0.2025.09.03.10.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:13:52 -0700 (PDT)
Date: Wed, 03 Sep 2025 13:13:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org
Message-ID: <willemdebruijn.kernel.14cd8a5376059@gmail.com>
In-Reply-To: <vxad5ijytxk66i2rja2uzmueajzpbccy3xcc4nokfnc6chapqb@j2kxvpyb63rh>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
 <willemdebruijn.kernel.2c7a6dc71163b@gmail.com>
 <vxad5ijytxk66i2rja2uzmueajzpbccy3xcc4nokfnc6chapqb@j2kxvpyb63rh>
Subject: Re: [PATCH 3/7] netpoll: Move netpoll_cleanup implementation to
 netconsole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> On Tue, Sep 02, 2025 at 06:49:26PM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > > Shift the definition of netpoll_cleanup() from netpoll core to the
> > > netconsole driver, updating all relevant file references. This change
> > > centralizes cleanup logic alongside netconsole target management,
> > > 
> > > Given netpoll_cleanup() is only called by netconsole, keep it there.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > What's the rationale for making this a separate patch, as the
> > previous patch also moves the other netconsole specific code from
> > netpoll.c to netconsole.c?
> 
> I just tried to isolate the changes in small patches as possible.
> previous functions needed to go all together, given it was they were in
> a chain.
> 
> this one netpoll_cleanup() is more independent, so, I decided to
> separate it, making the patches smaller individually.

Sounds good. Thanks for clarifying.
 
> > And/or consider updating prefix from netpoll_.. to netconsole_..
> 
> Good point, and I agree with the feedback.
> 
> In cases like this, should I rename the function while moving, or,
> adding an additional patch to rename them?

In general, it helps review when move patches are entirely NOOPs.

In this specific case, if this is the only case that gets renamed
*and* it is such a small patch *and* it is a revision of an earlier
patch that has already been verified to be a NOOP, then by exception
it's also fine to squash.

If there are more renames, it might be best to bundle them in a single
(otherwise NOOP, again) patch at the end of the series?

