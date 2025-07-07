Return-Path: <netdev+bounces-204502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 030FFAFAEC0
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9567A4A7F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4644C28B414;
	Mon,  7 Jul 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="M9HPD12S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEE28A731
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877527; cv=none; b=SVabUnmFXIs6Gac1jmUiMRNH+TXFVknVpJEfj42kQa+NGrIaf5ilpAJcOxa7sPOS4qL2+bmA/UARGLsO8hY3i/VtA29SSByP9W0GXCMsJQp/M2nnvg+gwbED6IH7hQLJdDU+kIAz/cFhKaV3KzrGckxzaPzUj7jPKvOnwYuxOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877527; c=relaxed/simple;
	bh=9xBalXmnJgD4RmmIV/V6wnjZTZ9oSv6heR/g4f/2kZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8l/9fYCWDuEuj5c151YhuvQQbJBy4S3MqMNbJ7pVLosmHEsqPkM1o0/cWLQQ3yMvkDBTzhF6LsqZENeMZrUsKv0iWOfDo0XYKd/AxucDW94Xdtbc1D32Jx8JXMvhCKheyTbLY2+agLvjcN5OcQTPQb12U4MFL3pmfV6chAj6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=M9HPD12S; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so2340269f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751877524; x=1752482324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7aL18uBiZMw/FWxoKoVSvm/jRO6BDbywt1DvLbU3XB8=;
        b=M9HPD12SaZJS9ElrYZwvnTw1s9jInt7WNp/e8hYRFlSnM4NDnrHzWfQYvbvlxkqqVN
         0FJtHpS55fXWw2A57xnWoo+lTBHYbEqOpjHuxsz6RZHbP/F8Kqjsfu30EyciP0XVnJG3
         q80/A3D/4XrbljezffxiAYrodcZFgGgJ5JkT60z1COEcD11IjPPyrvrfLmJau/RFsT30
         f3IQlO5uw4QMS2FwYvp32AThq4nf3Ll/qhA+zjecWJnjD8P4f68JenX0qZI2Jw6aFZg8
         Tk62dIhYC8n/ZEAIfPmKKUgxgh8/9IkW54z8hViYhdqcNzGT9B7Rg32g6s8CogXw2xiH
         rWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751877524; x=1752482324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aL18uBiZMw/FWxoKoVSvm/jRO6BDbywt1DvLbU3XB8=;
        b=WOtyVU2qzA9kUPRTXThYnoeFl1Qry5IetCF0u1qzwZxNk60VsmsWAmQ+uSFy9ipWdN
         FzNx7OWuXTi7jgVDY/z8N9d0MOaIeH0IEsS/AFgIJUKyIGw1hFN7I+2yg15NHhNZkznK
         794HRuSxUcaA3SyeoLLcPf6LT1KYPujOV4y/Fn48tCBjwgzoEVgFv0mhS42YcHLFtw+/
         n/0fOP9g0V87CJvntzWQAAOJ5aPQgQFWUGbgHLk5vfbYq5qqVCv2foclopQgIOcWibnj
         dmyVys3DDQltFf5YJXUjdaJ0snKsWEL53/n31wx3X43VJuwxcMcQuBzOmDxSnHsljFqu
         qPOA==
X-Gm-Message-State: AOJu0YySg8JWEZMbUWZJf+mS/Eb9dvwRPN/e9Np8GpI2wHFYJ78gY4sy
	L5EHc1iirbWt6hTaSAl8uZfBZ7jGyk1avcytqcLUc7wP/kK8l0fuIWcqAEVR1nw5Q1s=
X-Gm-Gg: ASbGncsgZe7Vcc6n75Cbc9Www0UqCHYILOwrxwOErMg87Mq5JUHXgF70xIAt5Ii3o74
	fADmjOID/5M0LfgvjCAd53lVnvmMtNsOCw02CQIrfREk8D/9kAfVrZWM8fNrrSuq67F/2+KBJjD
	k6JrHXcqzhM+pnwBrQRB7kcMEycNt8W9pYM4UIK8cvTyhW7KPQer4TfSOWI4zJksJGW6NlYSrYy
	KSV+7or2X++s7NAORW0zBcBba2JoGjZRztd7HX+QSOqGi6H3bE9WmgBN0VaM0vNEOlE8HYhJ2f9
	urEshcZBKhC+elGfrC2d7uK+mqCr6PRHuxeBFBRQ4f/WwLZ6E8qxDkEzdmiSGNg=
X-Google-Smtp-Source: AGHT+IHOL134zxv2M5TIxjn1JcbIuqigNn/BoslUPqMt07/pkuCY3NvzphTd4fkc6LrVVlovNM0TJQ==
X-Received: by 2002:a05:6000:24c9:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b49700c57cmr9041350f8f.9.1751877523572;
        Mon, 07 Jul 2025 01:38:43 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1696ca8sm106595425e9.28.2025.07.07.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:38:43 -0700 (PDT)
Date: Mon, 7 Jul 2025 10:38:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v13 00/12] Add Microchip ZL3073x support (part 1)
Message-ID: <cuqmu4cy52vj3njjltr3uf3ozsnmnhmo7v4lzzztftvupnf5wu@eekmg4a2wkla>
References: <20250704182202.1641943-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704182202.1641943-1-ivecera@redhat.com>

Fri, Jul 04, 2025 at 08:21:50PM +0200, ivecera@redhat.com wrote:
>Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
>provides DPLL and PTP functionality. This series bring first part
>that adds the core functionality and basic DPLL support.
>
>The next part of the series will bring additional DPLL functionality
>like eSync support, phase offset and frequency offset reporting and
>phase adjustments.
>
>Testing was done by myself and by Prathosh Satish on Microchip EDS2
>development board with ZL30732 DPLL chip connected over I2C bus.
>
>---
>Changelog:
>v13:
>* added support for u64 devlink parameters
>* added support for generic devlink parameter 'clock_id'
>* several patches squashed into one per @jpirko's advice
>* renamed devlink version 'cfg.custom_ver' to 'custom_cfg'
>* per discussion with @jpirko, the clock_id is now generated randomly
>  and user have an option to change it via devlink
>* implemented devlink reload to apply clock_id change
>
>v12:
>* Using 'return dev_err_probe()'
>* Separate zl3073x_chip_info structures instead of array
>* Use mul_u64_u32_div() to compute input reference frequency to avoid
>  potential overflow
>* Removed superfluous check in zl3073x_dpll_output_pin_frequency_set()
>
>v11:
>* Fixed uninitialized 'rc' in error-path in patch 9
>
>v10:
>* Usage of str_enabled_disabled() where possible.
>
>v9:
>After discussion with Jakub Kicinski we agreed that it would be better
>to implement whole functionality in a single driver without touching
>MFD sub-system. Besides touching multiple sub-systems by single device
>there are also some technical issues that are easier resolvable
>in a single driver. Additionally the firmware flashing functionality
>would bring more than 1000 lines of code with previous approach to
>the MFD driver - it is not something the MFD maintainers would like
>to see.
>
>Ivan Vecera (12):
>  dt-bindings: dpll: Add DPLL device and pin
>  dt-bindings: dpll: Add support for Microchip Azurite chip family
>  devlink: Add support for u64 parameters
>  devlink: Add new "clock_id" generic device param
>  dpll: Add basic Microchip ZL3073x support
>  dpll: zl3073x: Fetch invariants during probe
>  dpll: zl3073x: Read DPLL types and pin properties from system firmware
>  dpll: zl3073x: Register DPLL devices and pins
>  dpll: zl3073x: Implement input pin selection in manual mode
>  dpll: zl3073x: Add support to get/set priority on input pins
>  dpll: zl3073x: Implement input pin state setting in automatic mode
>  dpll: zl3073x: Add support to get/set frequency on pins

For the DPLL related code:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

