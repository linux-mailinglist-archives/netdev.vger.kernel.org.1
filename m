Return-Path: <netdev+bounces-168230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659FA3E2F6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD717D0B6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA804213E66;
	Thu, 20 Feb 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lr5bdchZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80A17BCE
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073558; cv=none; b=J/A51a4/xGUPOqvhOQ5cES4CMe0a6Zm8+QzG4JfUJ2JMKYykCHcjOfOHrrnsTtwHrQ8ds7zwpaLPV/JM0+s3TzquO7EqzxTL8jY4KQrnMg3hfXP6N/uAFBCHAY361qiL417VcZpnr/qlNQwfcboNJd4yE4FiyiRw6JcR/RR0TPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073558; c=relaxed/simple;
	bh=WT3E9LMaecZvUqLKdYhgMSYZeRDbSuznL9az11TO0HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk7V++lQZT7lOqMgZt345ZLffT3QWuouZ0umykl9nHhaU7d4FKPEv3TM4niH79mhqR0V3cQhDiamnGwt5+zllGXE5FoJY3OommMlwjae3DkH+HX/G/uGawm6JRe3gRFAMH0jdjE3wV1UggUS05pmAmMaM+QlwccliTn4WnccqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lr5bdchZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471ede4b8e5so5925431cf.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740073556; x=1740678356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q65KuVeFDoBSf9o7eu2h+uBlQXnTdja3BWn8UTAF6W4=;
        b=lr5bdchZ/rqp/pvduJstRRpBXvWY/L+eaYWdj98c/EnKusIRU1wPxlnwuzaeK74V4E
         TYbkKrOJ1awlEEl8INuCOlxpgfJBEtEmIt1DDMRMUUzQ+kYohLO6J5oOgKL9DBIcJsGV
         rrXUV0HqL7nUsBHXxrjK0zYhPGnKAGbtVblWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073556; x=1740678356;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q65KuVeFDoBSf9o7eu2h+uBlQXnTdja3BWn8UTAF6W4=;
        b=P4EDAhVOBorF+iSUBfb8FYUhMwRlM2elyGF877mSStxlEMi4WWL+7ROmAqa30v+jjH
         1tsxGYrvYUn41lnBlCzeVYnuD+Vyd0gX/++CMCLCmy0eCh6n/2KDzA2vdxvgN6YdbKgm
         8KuRzxtnDD/Hw1E/8DSMtAgjhcbn8XANg+9xCALd/UF+wp65JgPAQ3P6Tl3SKdcmed7B
         xwn0TYMDEwhv/ug1ioA0+mjib2gOGg6jmM8b6zAIZDuscxA1L7d62zBPIcFmhqcByKnM
         gYy8HYns6A2IlSCinpaov217GO4n4+JmIRoBVhDZ4fqE+GDn8dgGGn192uoPxkHhD+wJ
         ogQg==
X-Forwarded-Encrypted: i=1; AJvYcCWtA4PtbN8Vl8ANRV8Vsl1QS6WHQuridZIdPFJKto0xAH2Bze4j/EmY7qYhi+lu0NuHVuXtQf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4pGXd7yt71o0FhlguYeJQ1nvf6nNiV4+W4H6o1HEEe0QZcJr
	oMNY66UTZiacAnxZHxGvv1YOzG7dYghhSRyURh24l7XbGdhrUcn0TLgcqKQ1olplViOw4PNL9lG
	L
X-Gm-Gg: ASbGncvP6MfgJbQpuAiR3/8t3YxxPtzToeOZ4HBMcy0SKgktgNKWyUUtDiJPw8M2Q7F
	XIKbF67lrgvfxEfOwJyKODUTLd+R5RIbFA9UpQm21jKsUtdXu0+CeIfUfBSP7UOUXdSIf9cz5QK
	h5IgrQ+DqvVMUxhTA2qzSvkA9hC4xZzVB3I1+QjyazbWRkjVkzzaGkbebtF9gXc9hDSJ5rhqGGd
	+da2PwtEB6Yr/je2h8GgLsC8J9rMbDwgSencga7itCa50z4iM7M7WrKgeoznofGHIzeT8RKIsHI
	or1xLG99VFnNeRibAHdb+JWoEfbPhZ7ehtSQzwE+QeZt6JN94N4gdw==
X-Google-Smtp-Source: AGHT+IFheQ3EPjbLh27TB2LPT1Yc54jToB46mZ+hFWP9MZBD+fYaA5iUj1mIlA9Pxfz4z6gOyVLkXA==
X-Received: by 2002:a05:6214:2528:b0:6e1:5076:c400 with SMTP id 6a1803df08f44-6e6975bd122mr108577396d6.39.1740073555993;
        Thu, 20 Feb 2025 09:45:55 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a439esm88443506d6.67.2025.02.20.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:45:55 -0800 (PST)
Date: Thu, 20 Feb 2025 12:45:53 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for a
 local process
Message-ID: <Z7dqUfPc2N8LZgJz@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, petrm@nvidia.com, willemdebruijn.kernel@gmail.com
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-3-kuba@kernel.org>
 <Z7UBJ_CIrvsSdmnt@LQ3V64L9R2>
 <20250218150512.282c94eb@kernel.org>
 <Z7Yld21sv_Ip3gQx@LQ3V64L9R2>
 <20250219144844.1206b1fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219144844.1206b1fc@kernel.org>

On Wed, Feb 19, 2025 at 02:48:44PM -0800, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 13:39:51 -0500 Joe Damato wrote:
> > On Tue, Feb 18, 2025 at 03:05:12PM -0800, Jakub Kicinski wrote:
> > > On Tue, 18 Feb 2025 16:52:39 -0500 Joe Damato wrote:  

[...]

> <snip>
> > [pid 448278] 18:27:15 kill(448303, SIGTERM) = 0
> > [...]
> > [pid 448303] 18:27:15 +++ killed by SIGTERM +++
> > 
> > But pid 448304 is xdp_helper, which is still running and should be
> > the one to get the TERM.
> 
> Very interesting. I dug deeper into this, and it turns out its shell
> dependent. I'm guessing you're using one of the cool shells, I use
> bash. bash does a direct exec for "sh -c X", other shells fork first.

I am using bash, as well. The version comes with Ubuntu 24.04.1:

GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)

I wonder if it's something about the environment that causes bash to
act this on my machine and NIPA but not yours?

> I'll add a warning in bkg() for combining shell=True and terminate=True.
> 
> > I have no idea why this would be different on your system vs mine.
> > Maybe something changed with Python between Python versions?
> 
> More digging still necessary here, as NIPA also runs on bash.
> So your problem is different than NIPA's.
> NIPA runs:
> 
>   make -C tools/testing/selftests TARGETS="drivers/net" \
> 	  TEST_PROGS=queues.py TEST_GEN_PROGS="" run_tests
> 
> which runs thru a layer of perl for output prefixing:
> 
> 	tools/testing/selftests/kselftest/prefix.pl
> 
> which in turn send a SIGTTIN when we call read(), and hangs the helper.
> 
> > > We shall find out if NIPA agrees with my local system at 4p.  
> > 
> > Sorry for the noob question, but is there a NIPA url or something I
> > can look at to see if this worked / if future tests I submit work?
> 
> https://netdev.bots.linux.dev/status.html
> 
> With the disclaimer that we discourage people from looking at it. 
> It tests everything on  the list combined, we can't support the
> corporate "try until CI is green" development model. Not that 
> I'd accuse you of such practices :)

Yea I wasn't sure what the right process is for selftests; the ones
I've hacked on or written I've run locally until they passed, but I
suppose it is possible that in cases like this upstream CI will fail
for some reason or another.

