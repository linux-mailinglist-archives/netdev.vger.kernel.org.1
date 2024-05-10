Return-Path: <netdev+bounces-95296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1DD8C1D4F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450EF1C21C01
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E23149C51;
	Fri, 10 May 2024 04:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipqmAhVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5C142E66;
	Fri, 10 May 2024 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314026; cv=none; b=KxnTMNcwNrvktjkYBh1N5TWNJV7nRH68o0gQNZzK84W/MTlwK2PPlEG0J4aroOHK8ycUAOXdZYdrJOtCAQQO9kbMNig3HPGE9vFvmGrItgiOTVV75wNQVOtdoTckilBwvfFZ9UoSqnnVDeOJu3Sw9+DtW43nKxuXMKNGAM+/B/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314026; c=relaxed/simple;
	bh=0q8yaNH1A/SfdimQk6S6iL+CGfUXVf8m1RNrCjILjxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebg6DMD/MqNPvdv7g2lnrS0kSaigp6cU1FSxsAsk8n0eQWnsvFkd0dcnQPscvSBFv6vpDvTv4Tv0sCu2QlvQ7ohmKWPkNQeNCmmlMCtu7RtLbYpNVVCPREHM68G/4iPLoF4aYw2jV8xs9C+W/in+zj8pmkYeRRnUAKyIi8Kde4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipqmAhVm; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b27cc76e9aso194686eaf.2;
        Thu, 09 May 2024 21:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715314024; x=1715918824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ7ZoNviSnHC/g2meGJKV3qnWk+1KxyO8OjUrJK9GVc=;
        b=ipqmAhVmbrPFnxJJm/bqqq7M+D5qeS7HY2LvzWX0vVC7/AcKU+BemGyZCtRDWGMxAm
         PzS718Pq06Xw8+vGc3rLaDlac8H/hlbnbH3hh5Tx+YH5dmQ4ZVzDvc4kcjbuloAYM+gS
         vyalme9bb4raZ9/BEg/NH4RTL8aDyOP2QlfZ8gXoaY4D7MOzFbi+9fp5KO0LbtjJ3nGQ
         gA14efgtNChoO/cx9RFEMuc2q/f0LU7wXmlMoDdVsr5cIq+6LZgNs1MdgoWmFrwovXye
         HICd8D0mVg+P+FjYa4E96FsWqD8shExeIJalXoA56hujEJqfU8xPANuGqyxFZdpVMypl
         tEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715314024; x=1715918824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ7ZoNviSnHC/g2meGJKV3qnWk+1KxyO8OjUrJK9GVc=;
        b=fNutedZuGIaod1V79xYzj8Dj9N1/VQEpyr362prZptVr9hGL0gb2Yq0i5buXG5WW0U
         Gkh1ZG/Ptw4zjMukMfb3TcRFKKOOXQEu5Dd45BQF0mcFlFA1jSxDQwh/4GkhhrtrTiPQ
         RawgDph2cIOEafhOmSY/U1Y8FPVk8GHb3P0Dj4cSCOl0S66aWdZxjreQko3TVGBeLORE
         q0GJvHnbVcMaSWFf5XUpV+pDxT5kDVOFO2EU9u2UgmFwuUnv7IrEwrEzAe1Uacufrzkc
         DAgPcl282GqfxB2IwdA1Km0JlAKUvjyfTk43B/KKt86NEWGwmeBL1rM65QRD6oSP8Yip
         BYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW99NS1Vj3uwBkFmJK+LLDnC6D8r3NgSrT0K2oIHaseMhlJsVVhDfI8pBOShNIYzSyYk5voEBZDl6cxkCdSYu3URem9ITn3mrmD9h7cULFbqIKzN0RU2dpCeDZ2qJIvXnDciEME
X-Gm-Message-State: AOJu0YwYt/sTTsH9jhKmANTutxzy/xDaaFZfijA1pqx35v6NlKSEOr9Y
	QRJHJgFJliXe0GPTbAQpEPClbK3ZKQqo2o2nj1o+PoVinTYE2gn1e/M40w==
X-Google-Smtp-Source: AGHT+IHof3l3bj/wMmMu4y7yYHakp8mH1JiJTRdJUXrQe4JohJLQ7OjjKxvFtg6N4Otn3+YSejVRUA==
X-Received: by 2002:a05:6870:cb94:b0:239:6927:6826 with SMTP id 586e51a60fabf-241721ade50mr2031899fac.0.1715314024076;
        Thu, 09 May 2024 21:07:04 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a679cfasm627099fac.26.2024.05.09.21.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 21:07:03 -0700 (PDT)
Date: Thu, 9 May 2024 21:07:00 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
	Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
Message-ID: <Zj2dZJAfOdag-M1H@hoboy.vegasvil.org>
References: <20240502211047.2240237-1-maheshb@google.com>
 <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org>
 <87cypwpxbh.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cypwpxbh.ffs@tglx>

Thomas,

On Wed, May 08, 2024 at 09:38:58AM +0200, Thomas Gleixner wrote:
> On Tue, May 07 2024 at 21:44, Richard Cochran wrote:
> > On Thu, May 02, 2024 at 02:10:47PM -0700, Mahesh Bandewar wrote:
> >> + * History:
> >> + * v1: Initial implementation.
> >> + *
> >> + * v2: Use the first word of the reserved-field for @clockid. That's
> >> + *     backward compatible since v1 expects all three reserved words
> >> + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
> >> + *     CLOCK_REALTIME is '0'.

...

> I agree that it wants to be in the commit message, but having the
> version information in the kernel-doc which describes the UAPI is
> sensible and useful. That's where I'd look first and asking a user to
> dig up this information on lore is not really helpful.

But writing "v1, v2" doesn't make sense for this code.  There never
was a "v1" for this ioctl.  At the very least, the change should be
identified by kernel version (or git SHA).

Thanks,
Richard


