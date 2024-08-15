Return-Path: <netdev+bounces-118709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8D952870
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0E61F221CD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171432BAEF;
	Thu, 15 Aug 2024 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1ivuq/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AF2032A
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723694022; cv=none; b=ehz0Ch+6Rv2HMNqQ9MOHe1iZlO52/5062V9ZAwGp7dJmX9LA9N4J0RsnltR9EDr2pbe+Eeom4yEmbR+2uXUuyj0Hs7eWOWzhLo4u03DAFdZf/c0xaG/XhKn+qQaUbz+ueDTuEnsMSJA2sn+iWvjZvzwK8nO8LMw2P7rv5tU2V1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723694022; c=relaxed/simple;
	bh=xhpPIXGUPyvAvaEvZ5S3sXpGT+3ekJJfhtXF1DiuFlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm5dR3zRFSA1iqqxkT6MgkFNaul+I40ORjr+1KPOD4Yy2BPPkPJcOWhKX8ZEA1xov5L1aPHNEVBvN19GjnMKTsA5uvZ/GEFxjDdho66MOK2ZQeBOFK6S15WFc7GFIKcWI7xvw1CGe4W851o+z+Y5HycAkLebUU1x4SH8RKs61PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1ivuq/q; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5cba31939so66412eaf.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723694020; x=1724298820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5ihU4/WgUnc0w6u9y1lVBbKtWNjHz9wvPIWm0kTIQY=;
        b=L1ivuq/qZHCZlYNpHlCgTEaa+Rlg03aZsodXPgNXYjZTSdqSOkO0fqGhNwNVaFZmIF
         0tSpdvz2/15zVq+aQ9F4IBxg/QKONmvQzox9WEb//d4R3ZS4yDbAb6vLd3et449F1O6o
         H9RzxXY4Zu0rsASm5qebu+w5WiZKqJni67PLqjEWUs+kvf1Ga1t76N5GvULciD64nC9e
         vT4fkwFowHfjOaILPMq7sJ9688ALfFX4hpbyaOyNchseEVYG3SNFbm48X6aBIdwhPh/i
         11VdkhInFOnuGYMHM7brl5rc5p9T0ty7hv9+OP6igO83Ru+9LKmr5+15Hxl5qwAEFtZZ
         veLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723694020; x=1724298820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5ihU4/WgUnc0w6u9y1lVBbKtWNjHz9wvPIWm0kTIQY=;
        b=ffMxCNaQyUioMETfk1pe8tHYf39KsblB1j1jMAMeKOdBA/yqMIdBXrMDbvzl0/Lh+V
         4u0YjeJI5OTy6tKgF9jDaVrW6unmen6ScqWW/AtavlZnDfFLSImjKjZIICrJ1ZKQQXy7
         duSLQ8J7/9pFH3c83HY6DqslQ/AhvO2vIS08CZX7Aar2isufcU+UaotH2IYCrTt6YqVH
         TGppcSIAee6Em1sq/rwzngeZRX1Dz+ZV9nrznaxpJP5e2S1mB/Gk6gpD0VGi2SRI0ar2
         GW0ZFOupRkGNPIaFTggiebtOo7h16wnpPAAUdxvAV2oOft3Dl1vTLAHwWnVtyOtVE9JJ
         tsUg==
X-Forwarded-Encrypted: i=1; AJvYcCV5il1WXC4ChVPy2qw1/a2shtOnM935SUuD+cltbQCRSHI++IY4PPSBFV/ydQ8E9trY5G6Z5hZttxK86ASj/jL/WmYV4oPC
X-Gm-Message-State: AOJu0YyL162UBUfSu9rIdM86JK1ShrB7h/KaWgFN8ss1fwfY5QzXKpMW
	QlGu++GAzNB9N9/56U5x5rn1jybCme7A0B8xVHQsxcBzXmvuti8HkQxvPg==
X-Google-Smtp-Source: AGHT+IF6UaXslpD7xgwTc706Lysw4c8SUWzD/a8sm59fPAbXtl687nJZBUHEIaaMVBR1i8TgUA7AwQ==
X-Received: by 2002:a05:6820:2d4c:b0:5d8:2c3:f9b4 with SMTP id 006d021491bc7-5da8a5dbb54mr904804eaf.1.1723694019707;
        Wed, 14 Aug 2024 20:53:39 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da8cd699c7sm146979eaf.7.2024.08.14.20.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 20:53:39 -0700 (PDT)
Date: Wed, 14 Aug 2024 20:53:32 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>

On Wed, Aug 14, 2024 at 05:08:24PM +0200, Maciek Machnikowski wrote:

> The esterror should return the error calculated by the device. There is
> no standard defining this, but the simplest implementation can put the
> offset calculated by the ptp daemon, or the offset to the nearest PPS in
> cases where PPS is used as a source of time

So user space produces the number, and other user space consumes it?

Sounds like it should say in user space, shared over some IPC, like
PTP management messages for example.

> the ADJ_ESTERROR to push the error estimate to the device. The device
> will then be able to
> a. provide that information to hardware clocks on different functions

Not really, because there no in-kernel API for one device to query
another.  At least you didn't provide one.  Looks like you mean that
some user space program sets the value, and another program reads it
to share it with other devices?

> b. prevent time-dependent functionalities from acting when a clock
> shifts beyond a predefined limit.

This can be controlled by the user space stack.  For example, "if
estimated error exceeds threshold, disable PPS output".

Thanks,
Richard

