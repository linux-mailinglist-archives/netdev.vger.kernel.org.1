Return-Path: <netdev+bounces-75293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5286903B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEDBB29CEA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74B13B2BB;
	Tue, 27 Feb 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Utisyiot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81213B2B2
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036273; cv=none; b=uI6MkaR2zUc/5Pb0JDxZBogaY5Ea1ZnfU1CC86doJad9MHP9WyEYkKUgVdZhgPucDzqaHh9Wed5qVb7malpsNisLnm+Kk4d/Y5vnrsYflqfIXqSBY8tC6CMAx1x5VRx7+SiJ0HmVHC1NTUTwYI/BCG0LDVTN37xMMOWqBLNagQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036273; c=relaxed/simple;
	bh=cfcbfeJPglJ8pNRzdwnrfq08sE8b1vD503Z7UMAiU9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urs7fy1bm+slAzfX1i1L+seYjWtRtAHMKD9qxfOQvRLgMoT0xlmLTfLsb3wqeMedgaCmRFfStVYzjeL3Domv5drJ2mYjBrPjwLsAburMV6DSfxLM12S5TG/KE1H4qsxPEhrSzyMZ75fgBQ1yCQal/HW2TlVmwEnezLqwPtAGHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Utisyiot; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso1602651f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709036268; x=1709641068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuXDHId7fuKEY2MA5rzWQfyKuPAeNZD0D18+VnJhFgw=;
        b=Utisyiotpwssr1bxavDwFmLvAHmy+wqREQekR+heJcobKCbueAxk552u+q4oT/HFRL
         ZtJ/5FzbX/woXg2vCEnKFTa6h6sdbgZ6UO68qybMSGB1Msvw/xstfEVRwSv9BT/deFWd
         KV2ChwIhdXJxGdu46uB9pEtZeZn4UyXQjg+uLpN4NlCtxgFZzFQ5m0MQ6QHoZlHUnWVq
         4U6WQJx9DhpDJ8jnj4a+D2BK3qtYtJB53Vs3EV+aLMJdBzKQJoC2D2LalGakt9y6aCwW
         Ka6J9CpqHt3WjnSYH3NErUEW4k9KerIVN5E1M8/5vwl3LS/udZPHhQa0SodgfWzYWKSY
         Je9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036268; x=1709641068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuXDHId7fuKEY2MA5rzWQfyKuPAeNZD0D18+VnJhFgw=;
        b=fniSvEYuEf5p+s1tWtdSgWTq0kRGf0sx2/jCgtCqQiS2lBbYsZTpK+GMS/Gw4gsMvb
         f8or0PA3GNq04OQQKqrtl3zDCFHWzfjJSDc5i9OE8GaXC6Zf1WexS7Hb1rILTANXjyYn
         c6hyMECvAqDMbVDx6AGfE/kPegTDe5qjPY8H/+a8tMUCywHImjQl22ENfDDyV/A8zlRN
         S2Z0vjKBn3GKKQxwzrxlAY6ETXVPi38tBftYokzQyP77D0ZQx2DApCOw/oDYBHGPNMRE
         BU3/YHmUeTPwM50zIz1wWcxMUOf+jeaEELUQQ1QJ61OUzEc68uVEoq41N4XqyrQaCUd4
         R+rw==
X-Forwarded-Encrypted: i=1; AJvYcCVbNnM1hH+fJ7C2PvjeUMKy431pyz98i7rJW0jXu0fh1ZJbADzd8FfnulWF6QXWz/2Y8AWay7MUlF+LH8TWsyUcS0QYQKOD
X-Gm-Message-State: AOJu0YwtTkfR2dsBhHTZ8S9+bEwxXNn0JENNe9gP6nhDOhQg3WCtIkkC
	4E0h75LK+cW5hKC4ec36qdGaymF1KFU1PcLX43UgFH0M+AgFVz5ZmBEYukRuXPg=
X-Google-Smtp-Source: AGHT+IFdqWRjtqXQv6YmRyak547KLI+WLKcZ1zHDH3jhuWGZ4wzZwZEGEm/LpsWnxUSzxeaCwJPiOg==
X-Received: by 2002:a5d:634f:0:b0:33d:39db:a0f8 with SMTP id b15-20020a5d634f000000b0033d39dba0f8mr9564225wrw.7.1709036268506;
        Tue, 27 Feb 2024 04:17:48 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f1-20020adfe901000000b0033d8b1ace25sm11326560wrm.2.2024.02.27.04.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:17:47 -0800 (PST)
Date: Tue, 27 Feb 2024 13:17:44 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, przemyslaw.kitszel@intel.com,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <Zd3S6EXCiiwOCTs8@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
 <ZdNLkJm2qr1kZCis@nanopsycho>
 <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org>
 <ZdhpHSWIbcTE-LQh@nanopsycho>
 <20240223062757.788e686d@kernel.org>
 <ZdrpqCF3GWrMpt-t@nanopsycho>
 <20240226183700.226f887d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226183700.226f887d@kernel.org>

Tue, Feb 27, 2024 at 03:37:00AM CET, kuba@kernel.org wrote:
>On Sun, 25 Feb 2024 08:18:00 +0100 Jiri Pirko wrote:
>> >Do you recall any specific param that got rejected from mlx5?
>> >Y'all were allowed to add the eq sizing params, which I think
>> >is not going to be mlx5-only for long. Otherwise I only remember
>> >cases where I'd try to push people to use the resource API, which
>> >IMO is better for setting limits and delegating resources.  
>> 
>> I don't have anything solid in mind, I would have to look it up. But
>> there is certainly quite big amount of uncertainties among my
>> colleagues to jundge is some param would or would not be acceptable to
>> you. That's why I believe it would save a lot of people time to write
>> the policy down in details, with examples, etc. Could you please?
>
>How about this? (BTW took me half an hour to write, just in case 
>you're wondering)
>
>diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
>index 4e01dc32bc08..f1eef6d065be 100644
>--- a/Documentation/networking/devlink/devlink-params.rst
>+++ b/Documentation/networking/devlink/devlink-params.rst
>@@ -9,10 +9,12 @@ level device functionality. Since devlink can operate at the device-wide
> level, it can be used to provide configuration that may affect multiple
> ports on a single device.
> 
>-This document describes a number of generic parameters that are supported
>-across multiple drivers. Each driver is also free to add their own
>-parameters. Each driver must document the specific parameters they support,
>-whether generic or not.
>+There are two categories of devlink parameters - generic parameters
>+and device-specific quirks. Generic devlink parameters are configuration
>+knobs which don't fit into any larger API, but are supported across multiple
>+drivers. This document describes a number of generic parameters.
>+Each driver can also add its own parameters, which are documented in driver
>+specific files.
> 
> Configuration modes
> ===================
>@@ -137,3 +139,32 @@ own name.
>    * - ``event_eq_size``
>      - u32
>      - Control the size of asynchronous control events EQ.
>+
>+Adding new params
>+=================
>+
>+Addition of new devlink params is carefully scrutinized upstream.
>+More complete APIs (in devlink, ethtool, netdev etc.) are always preferred,
>+devlink params should never be used in their place e.g. to allow easier
>+delivery via out-of-tree modules, or to save development time.
>+
>+devlink parameters must always be thoroughly documented, both from technical
>+perspective (to allow meaningful upstream review), and from user perspective
>+(to allow users to make informed decisions).
>+
>+The requirements above should make it obvious that any "automatic" /
>+"pass-through" registration of devlink parameters, based on strings
>+read from the device, will not be accepted.
>+
>+There are two broad categories of devlink params which had been accepted
>+in the past:
>+
>+ - device-specific configuration knobs, which cannot be inferred from
>+   other device configuration. Note that the author is expected to study
>+   other drivers to make sure that the configuration is in fact unique
>+   to the implementation.
>+
>+ - configuration which must be set at device initialization time.
>+   Allowing user to enable features at runtime is always preferable
>+   but in reality most devices allow certain features to be enabled/disabled
>+   only by changing configuration stored in NVM.

Looks like most of the generic params does not fit either of these 2
categories. Did you mean these 2 categories for driver specific?


