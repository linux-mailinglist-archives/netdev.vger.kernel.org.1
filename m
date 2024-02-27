Return-Path: <netdev+bounces-75380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0D6869A8F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A601C245B2
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B1145B01;
	Tue, 27 Feb 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Iy7/XTKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D71145333
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048374; cv=none; b=UJ9xptz2tjKlX27rYGMoH+WtcP+gW0mBLO4GJ9abnS62061IUIBEH4cXRiyQdngyM+mQ3d3KqZCFAJKCaxqwqNtVgbRsLOPDHJkPAO4fFotKMZDwBHQdu69hqWTpoHv/TFw1Stow6M+YeFl3zSfv2sYHZtly/wsWQ7YBR+p+sAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048374; c=relaxed/simple;
	bh=okTGcTlR7j2aaNPRjFLzBl3lzNum0C/BN/dr79v6aeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksKhFr4jWeW6cO//vFXq9FhaFO9W1VVvrfORLWuhnuf2xTyISjXDGRZ3NrmWrpwxNtHsD2Q/H7+c1Oh7pO8DJtRmyjq58RJXz8/fLC000TrP4U+N002icXZ4tb5WecdounlYCOdlE+gNDLCqc/vEzY/GrA4hVsJBjSUdkAoHtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Iy7/XTKg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412a3901eaaso18872975e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709048371; x=1709653171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDRKa1sSPk0Ft0Yo+CMNcU/6RO+9yXRaNDIHU6vUgWI=;
        b=Iy7/XTKgk96wUClSTVplgPoYAXUZzJRh5qSR5jHlk5Eu6LTn6Apvi5Q4cx1bZwxXy8
         gHzjfMuQoDKas9X15nG5ps7p7czbUcahSBoMqRbsAM9CgynAKW/z7qVj73hije4TA4U5
         L6jRX92Y9IeCk7BdjE4p/C7hHsk2molvoszb/R5wKR78C9KJLtfTTdzrrABCK6/1wOzx
         qrCO4mN9Dwk6ljnOWnTswmeFcAc91+8frjlfvUhru9WNKNut8B3f6n3KG5ZKrao7QMOm
         sYY/VilIOKuPVLo+aT2+xEK1R0yQQrx4oeBHm9wvujoykJEYRv5EG7ZWbn1DckChtjE8
         A8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048371; x=1709653171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDRKa1sSPk0Ft0Yo+CMNcU/6RO+9yXRaNDIHU6vUgWI=;
        b=BsHPm9+CLUo4wNQHF1kHmQpAYqRCzGlUtnZMr5XuUpW5QytNLIDKwSWkYKEyrrU6XC
         T+3S8aABTqo60ju7RVStdsykW3/StaaF0MWS2lQAIQTHHR1oPNdxQMNNCbFSuJgQJ7A8
         BeyFF94Zk48Tf926h4ITiTpeI9mAPuZVMYjORCCd9W2Babrj4P5/ZPZ+23v/AJCtXRqt
         Acgl4iAGnlAecI/9M5ycoJOaaFQ2qfYmdzdl65pEoP++1h1nYEBN/vlA6LNW7hTlKdhE
         BxLxEL5Fu4ZsTXGdPau/OCv666hS2YSjgyagL1hoAZZUSBzjZBiGTOrFau9P2tyIMi1k
         rmMw==
X-Forwarded-Encrypted: i=1; AJvYcCV6mQNyOiCCb9x7NWrER0uBkofk4KVwxN7YCu602sDPy6FXji3ckqQSgremnOUGc24YX5zG9EqOza5sbKyGADiATuOLxBfr
X-Gm-Message-State: AOJu0YzoVkpruJNHoONR1aMh1+tv9y4ZT/F57mMJB7wsYdp2L082E8NX
	sg72QrwgEjIgtPdQwyPNGyVZrJPe641nj/dyLMwCC/lZgwubphr5Dx9DgBZWEvE=
X-Google-Smtp-Source: AGHT+IG6Uu2nOKTEpyp17YkwLq6P9EXN6F12O2qhzUyR95K3CCYgIqGR+H+P+KKNbMo+Y5UKs6840Q==
X-Received: by 2002:a05:600c:35cb:b0:412:a1c1:207c with SMTP id r11-20020a05600c35cb00b00412a1c1207cmr4790389wmq.3.1709048371380;
        Tue, 27 Feb 2024 07:39:31 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c19c600b00412a332e1d2sm8108847wmq.47.2024.02.27.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:39:30 -0800 (PST)
Date: Tue, 27 Feb 2024 16:39:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <Zd4CMA4F9ARt-rpv@nanopsycho>
References: <ZdNLkJm2qr1kZCis@nanopsycho>
 <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org>
 <ZdhpHSWIbcTE-LQh@nanopsycho>
 <20240223062757.788e686d@kernel.org>
 <ZdrpqCF3GWrMpt-t@nanopsycho>
 <20240226183700.226f887d@kernel.org>
 <Zd3S6EXCiiwOCTs8@nanopsycho>
 <10fbc4c8-7901-470b-8d72-678f000b260b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10fbc4c8-7901-470b-8d72-678f000b260b@intel.com>

Tue, Feb 27, 2024 at 02:05:45PM CET, przemyslaw.kitszel@intel.com wrote:
>On 2/27/24 13:17, Jiri Pirko wrote:
>> Tue, Feb 27, 2024 at 03:37:00AM CET, kuba@kernel.org wrote:
>> > On Sun, 25 Feb 2024 08:18:00 +0100 Jiri Pirko wrote:
>> > > > Do you recall any specific param that got rejected from mlx5?
>> > > > Y'all were allowed to add the eq sizing params, which I think
>> > > > is not going to be mlx5-only for long. Otherwise I only remember
>> > > > cases where I'd try to push people to use the resource API, which
>> > > > IMO is better for setting limits and delegating resources.
>> > > 
>> > > I don't have anything solid in mind, I would have to look it up. But
>> > > there is certainly quite big amount of uncertainties among my
>> > > colleagues to jundge is some param would or would not be acceptable to
>> > > you. That's why I believe it would save a lot of people time to write
>> > > the policy down in details, with examples, etc. Could you please?
>> > 
>> > How about this? (BTW took me half an hour to write, just in case
>> > you're wondering)
>
>Thank you!
>
>> > 
>> > diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
>> > index 4e01dc32bc08..f1eef6d065be 100644
>> > --- a/Documentation/networking/devlink/devlink-params.rst
>> > +++ b/Documentation/networking/devlink/devlink-params.rst
>> > @@ -9,10 +9,12 @@ level device functionality. Since devlink can operate at the device-wide
>> > level, it can be used to provide configuration that may affect multiple
>> > ports on a single device.
>> > 
>> > -This document describes a number of generic parameters that are supported
>> > -across multiple drivers. Each driver is also free to add their own
>> > -parameters. Each driver must document the specific parameters they support,
>> > -whether generic or not.
>> > +There are two categories of devlink parameters - generic parameters
>> > +and device-specific quirks. Generic devlink parameters are configuration
>> > +knobs which don't fit into any larger API, but are supported across multiple
>
>re Jiri: Generic ones are described here.
>
>> > +drivers. This document describes a number of generic parameters.
>> > +Each driver can also add its own parameters, which are documented in driver
>> > +specific files.
>> > 
>> > Configuration modes
>> > ===================
>> > @@ -137,3 +139,32 @@ own name.
>> >     * - ``event_eq_size``
>> >       - u32
>> >       - Control the size of asynchronous control events EQ.
>> > +
>> > +Adding new params
>> > +=================
>> > +
>> > +Addition of new devlink params is carefully scrutinized upstream.
>> > +More complete APIs (in devlink, ethtool, netdev etc.) are always preferred,
>> > +devlink params should never be used in their place e.g. to allow easier
>> > +delivery via out-of-tree modules, or to save development time.
>> > +
>> > +devlink parameters must always be thoroughly documented, both from technical
>> > +perspective (to allow meaningful upstream review), and from user perspective
>> > +(to allow users to make informed decisions).
>> > +
>> > +The requirements above should make it obvious that any "automatic" /
>> > +"pass-through" registration of devlink parameters, based on strings
>> > +read from the device, will not be accepted.
>> > +
>> > +There are two broad categories of devlink params which had been accepted
>> > +in the past:
>> > +
>> > + - device-specific configuration knobs, which cannot be inferred from
>> > +   other device configuration. Note that the author is expected to study
>> > +   other drivers to make sure that the configuration is in fact unique
>> > +   to the implementation.
>
>What if it would not be unique, should they then proceed to add generic
>(other word would be "common") param, and make the other driver/s use
>it? Without deprecating the old method ofc.
>
>What about knob being vendor specific, but given vendor has multiple,
>very similar drivers? (ugh)
>
>> > +
>> > + - configuration which must be set at device initialization time.
>> > +   Allowing user to enable features at runtime is always preferable
>> > +   but in reality most devices allow certain features to be enabled/disabled
>> > +   only by changing configuration stored in NVM.
>> 
>> Looks like most of the generic params does not fit either of these 2
>> categories. Did you mean these 2 categories for driver specific?
>
>If you mean the two paragraphs above (both started by "-"), this is for
>vendor specific knobs, and reads fine.

Do you assume or read it somewhere? I don't see it. I have the same
assumption though :)

