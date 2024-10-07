Return-Path: <netdev+bounces-132781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00908993281
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EE4B2475A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897381DA0FC;
	Mon,  7 Oct 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eojz/ph1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200EF1DA0EB;
	Mon,  7 Oct 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317219; cv=none; b=uXMwGkZ6j0yl32Uh3CyNUcg9UL6jDpzCLiXlUb6yHASHs9enJH2oKWSOhNYn91s//c4oBVbBFHuQ0MWRpf4d0FTn2+5ZDx9qBqjketFyo8VtAkGc6yAl1FiWJQDBZ0BnyxhoOpgtnAROj2zyyiaBKWStWeRyGKHguXe4IaNJdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317219; c=relaxed/simple;
	bh=tHxOVl6yyxhBtmf6brubWmR0Vv+AWpuqnMgAqpriaDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrQXAezXUqXA1dqITRTmyc2Sirr/1oawiz6W4lbvlow2XFojB79K6CXbZmtgXqjG7GGqJFCDe2WfuA6Vg0u7kYlU6uPb0AzCORsAH86SFVfodYZa1EeEFDXiaqg9utlAumI9m+Z71SERkY5kTp9ZEbQZ7vH90koJwJUCp3t1EyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eojz/ph1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b9b35c7c3so48321045ad.3;
        Mon, 07 Oct 2024 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728317217; x=1728922017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf+PiJeuT5YXR8uf468cVOB4GwgU6SzIkTri3Fs5PWk=;
        b=eojz/ph1LEVK81ILYjKHf02rhJuxHYQeAFIGpMMw4o8/HiXGUnG+IKxtk/q5/8PFDa
         2fpMJITHb1FASyATVZi+cvWPL737B5lkzPXKUa8QopeROJpUUriulWt0mpowHhuQaPG8
         sBzXN6TjrRsNOgIP6GEmL+2E/+FpyfUoem9+F9rgCPtTyEp+kY4+bZgA8xE97hXYquKT
         EeIQM7wAxquMXM9XBVgMzvzz5DDL8HX/EGK9f5SNLMsjNSv2SYODIsqDuSlUXKCruPEG
         zn+G/QjGjpzXGxYZGAbLVdEFgIvvIWqvDGFBVh3dn6WBgAgw+V35NMhV/GlpEsQm606m
         +K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728317217; x=1728922017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gf+PiJeuT5YXR8uf468cVOB4GwgU6SzIkTri3Fs5PWk=;
        b=jV96/xPMCw0d2Vb/QZEu342VYECSl4JlRwZgEeO71njte0W2wqwTKw1UVS0An4O1zR
         dQYL0eBWZimWKHup9zYn+K9srmXQttpU1c2+05LpuApMnCDVpKueAyROmEe3PFDu4L2c
         aZexFRdAmyCmgKco4uPE8R8Pp59CSmjPcbOOfTi0BkjE5JpB2qTQIRBpxA3vdmbYjCBa
         mgxP2Z4v7Zmr/PzKoC3FUNZk4Vx/j8n/Fuo0W7HPB8/J15IOs5cLv3D4zQrhEmmkfYC2
         Zx8WZrP58xAxxzEVqpcsEZ/0N6cCHsP6C9Yq4peJFOH7S9MYuzdYXfnLZOAprc0Rt55J
         Bt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW33CGfQCIZRJ3qn7LJlBbSd9D/u4WAzJ1cxJLmaYYAUlX2vgBNoNXEhv6AyQ9aHrOEyFNx4EGaVp4gas=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJkFS1LoiMjkQxHKhkQeyqIXzG+W3cUazydf9tQpMNdos3801
	Tn9T/xOcic1bHXf4WRG8mBYK7BGbjQbQ4T2mnN8YyIud0fX2bWim
X-Google-Smtp-Source: AGHT+IEGwDAT9Cv1y8WQER1FRIlOllCMCIASgGerSdmRnTWkgRQSganVf2GcG1sGdzVp1JMLrYG0ew==
X-Received: by 2002:a17:903:244e:b0:20b:ab6a:3a18 with SMTP id d9443c01a7336-20bfdfd4372mr211059575ad.17.1728317216962;
        Mon, 07 Oct 2024 09:06:56 -0700 (PDT)
Received: from hoboy.vegasvil.org ([198.59.164.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afd1dsm41264245ad.36.2024.10.07.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:06:56 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:06:54 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [RFC PATCH 0/2] ptp: add control over HW timestamp latch point
Message-ID: <ZwQHHmLeBUBpH71p@hoboy.vegasvil.org>
References: <20241003213754.926691-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003213754.926691-1-arkadiusz.kubalewski@intel.com>

On Thu, Oct 03, 2024 at 11:37:52PM +0200, Arkadiusz Kubalewski wrote:
> HW support of PTP/timesync solutions in network PHY chips can be
> achieved with two different approaches, the timestamp maybe latched
> either in the beginning or after the Start of Frame Delimiter (SFD) [1].
> 
> Allow ptp device drivers to provide user with control over the timestamp
> latch point.

This looks okay to me.

Sorry for the late reply, but I'm travelling untill Oct 11 and may not
response to messages right away.

Thanks,
Richard

