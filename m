Return-Path: <netdev+bounces-159170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDEFA149BF
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C938F3A6391
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33B1F7564;
	Fri, 17 Jan 2025 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gykBCx0E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D21F668C
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737095791; cv=none; b=BhkRcVYcdKdbIf6K4f9HWaLJ8yuSPGejJjv07mmhWxcPwi76WMjrd0bt7lSDjFgXI+QUCJI9R1NKCOklWrC7LoR/Wr8q53mOwsvM1m1GQ1ngufEIxMS4rHhEGGYyKDOwhqueb/LE4pzyfrJDYQ/Pstty/cY3XsQIBwqE7IHERGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737095791; c=relaxed/simple;
	bh=YwIhreVPh2hdBCUGkPrWBO1/Ya9F/Plo90ycaKanL1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXT95fdSWo+XLAC4IMvMxHEfbQmcsmfL3TOxXYuwsTRGJ5q50wh913pm2oCl4uc0KzxMq2LDcDrOb9IOwlQPCbY9iTC4kGcWQaovybDL5c+NTCnksnsESH2rQssQE2U7MkOnOPZTqbS0yi7JntNphn2a7FKWWk3eY7VXIQryHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gykBCx0E; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-219f8263ae0so31295035ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 22:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737095790; x=1737700590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TciJ7WpCKsKcwAFOb4Uyn9lYf14vU9pHs1IJBaEQwW0=;
        b=gykBCx0E+nX56vSF0r/AU0bJJf1haODrAGXcW+adrcawz6DtlDK9w/CsV/mShEYsVe
         CA43h/dz1pBbDDcIOoXRA6njQ6pl9HhdVI+up84QR2Gqee9xBRiOHFhsIZGFJdVmIuAH
         Bu1WzfRDweSWoyo99CFRYhuQuSCy3uFfGLLTJsyXH8ZnUXYDEfmggDHnkFPRJDkLBvtT
         /gwkGOEE78iU8SMMmdy4lxf7QjIaRbYrGIbfb6ZRpcihqVa2qFHxAbESxsV3ELgZLaMV
         1Ap0zRw2z59zrrNJGL2Vy4zUn3ljU3pxDtiJCYbr0ds9Az3D9cOJghNrHLINLBm5WEiE
         6Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737095790; x=1737700590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TciJ7WpCKsKcwAFOb4Uyn9lYf14vU9pHs1IJBaEQwW0=;
        b=ElTnohmIDqegCUW13bNuIrS+w5MPC3q43xxcr7+AAfi5dm0tiotqXgUNMiACUX+zqs
         xZQ1PKJRpfNBAjJTx6TrOEIE0IYfcw0/jb219U2LOVifPF3B2L1PIvKGHV7qi03sgnSN
         +11zYZ1w5JJzzAcTn6HryqGbDHVFHD0G/y+B9qVRQwb8YaXTH9OaEmOq0s1r+nEapyxG
         FmAKPoYqTKfAu+kJdc6gRfc1NkxKcUTolbDM0JaoUhu4anOtRs+lRH1foYdY7NaRNIcR
         keOREUOOjv7w4aJjGC2TpAlDuILhIOLrjrJDkcDtB6e6X8sVXDSsoFXp7WrW+zREHNqe
         lPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyF1ucX+kyi+/ti+y86tgTaq94Yvzf51izo+E4HrblkrFAD7i+ptjtxfcx4lJYV6OwsXcVji8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMKcVJG6iN6RjvtpuuOCBxCN6q1gQMPsE24DAWyJ7mqKp0fDa
	gTqwKipO1OMKVpdZAbbFtbUDbNRsBZ9kVjuPcLr5adNrISyX48uP
X-Gm-Gg: ASbGncudPoXTbTjkkW+SxtxK4s4zpAU1TOHLrw1I6sGU+mPJiXdWZc+JaK3Dj1+scHv
	9FeNQNOGceI+ydbMp/qeN6LIN87Be+lBl5SrTtS1MYVFJZCO0jwLmUg5tfcXF2tXUZ6RxakJ2k7
	zPbmh7yAP3eTVg77xQ+0DPpzFjbJL5jBxg7hmclC3PQjj5xyj9+xYekutDg7d7MLMjPQetZDCjm
	OT9ihBYGl6Ul9LX8A9CzUKckQoKoFH2ZW+VgDKooDQHVeCIJboMg6fPOogF/gwGU3MUS/yYnnO3
X-Google-Smtp-Source: AGHT+IHRh5Pyz2eB69wEIsJTEftZxqZVFSUeJiPADmS7C3zexsktiNyIDiiAz9DV1UQPPUm92rzkEw==
X-Received: by 2002:a17:902:c94a:b0:216:2abc:195c with SMTP id d9443c01a7336-21c352dd6ffmr20112065ad.7.1737095789792;
        Thu, 16 Jan 2025 22:36:29 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea0966sm9479395ad.37.2025.01.16.22.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 22:36:29 -0800 (PST)
Date: Thu, 16 Jan 2025 22:36:27 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v4 4/4] net: ngbe: Add support for 1PPS and TOD
Message-ID: <Z4n6a7JB2HmSbqWn@hoboy.vegasvil.org>
References: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
 <20250114084425.2203428-5-jiawenwu@trustnetic.com>
 <Z4aPzfa_ngf98t3F@hoboy.vegasvil.org>
 <067101db67df$422cecd0$c686c670$@trustnetic.com>
 <f387de62-6a61-4c21-97a0-ac0da9e99c58@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f387de62-6a61-4c21-97a0-ac0da9e99c58@intel.com>

On Thu, Jan 16, 2025 at 09:23:10AM -0800, Jacob Keller wrote:
> The sysfs interface doesn't expose the full support for the
> PTP_PEROUT_REQUEST ioctl.
> 
> It only supports setting the period and the start time. The other
> features were added later, and the sysfs interface was never extended.

Right.
 
> To use the full support, you need to issue the PTP_PEROUT_REQUEST2
> ioctl, for example from a C program. Something like the following might
> help you on the right path:

Actually, there is no need to write a program, because you can use
linux/tools/testing/selftests/ptp/testptp.c

It has command line options to set the pulse width and phase:

 " -p val     enable output with a period of 'val' nanoseconds\n"
 " -H val     set output phase to 'val' nanoseconds (requires -p)\n"
 " -w val     set output pulse width to 'val' nanoseconds (requires -p)\n"

Thanks,
Richard

