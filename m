Return-Path: <netdev+bounces-90960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C687A8B0CD2
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11472B24D14
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701A15E5CB;
	Wed, 24 Apr 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wmM4zqcP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1D15ECF2
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969670; cv=none; b=mw8JK8enoRjWu50P7XD54ooMhg48W7p+DnaUjHDtxT54jzz//nDVhEqckjD65YQkepEu+KyK77R6CfKImx5TVJ1Wwgks2QRVVsHZa1IngGI25qoIL/MbOw+nxTgl0ZAEV5EnBuMQPioLoR51jwx3xLhtskOjR6u7LXupi8tRhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969670; c=relaxed/simple;
	bh=R5YaSZHprDE8SJbYzldKqQqGLClysTumsGk5LNMrrlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQteOQcU1xp51MoSbNK+Mr9qdYEPt4yVF5f0vmkazbMKK3YOMlP0IEWpkZ7icm2W9lBe0zeYMyx4vgW1xtEjOZViERsc1mkADtMN0PcHfGpTysVgXWrXRxUMLQEsAxtTrJHe082EHFxxnaw0X/Vz5xtBK5QVBRvQgURBc1UpDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wmM4zqcP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso28957325e9.2
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713969666; x=1714574466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1X8jzwc/J0aEfOen/Jzf7KM7nb+jdJmLOBgsiHxUrvw=;
        b=wmM4zqcPiDffO+/iLhba4Yr/r9aPDt8ldPxTe/jnNSfXDzwAOH0ahpLiF8nz4uGDJd
         K1nK35Z5Aq+c3rEv7r6CFlmCoC/i7kUrgD8HLUzwQKtJvZhw8xjKDnNaCFWVKDSOR4b3
         x9GYDsJ/K6+5PUym/tmBrVNbsQgySx3r166zJ4XJM4f5UhxX1IviGFQYnKVu4pYVkJlL
         orbQv0CDqjwCzmIESEzP/5qQtHxBws4kGQ8VA20FkzflfMptda4eqmVaauCfsLbW+F9d
         gmAsJkYtOH7o4UY0Hya5TdR2mCd4EzxRUXrW+TCb6Fw+UTY33OVA4ErU3qkFSpBF8CYF
         tvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969666; x=1714574466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X8jzwc/J0aEfOen/Jzf7KM7nb+jdJmLOBgsiHxUrvw=;
        b=B+8Kergq5tGpwRaW8iUQU8a0lvilKnJzMZhGXkIbdHKElvbhhqRF7EqJIwZ2mETcpM
         QKj6R3+5e2HJvfil5le0AM98Vxii+5NsVEGPU2EPIba3zaHOVGDNyTXTaQIFQzew0ByR
         c7RAvlK1ujzy5Y+uz0jVLZlDg6AYk7xsC1BitHE9SoqX8eHV1098z4KzpJj81pmNI/m6
         fWw/QRVwTtJjERMT8apiB6iMOUyspS/cel5hG+LWftCUYWCKxHc4l1WwMhAPqqA4hys5
         bY5k1++yKY8i9vFHvjQv0SBsLYkawdLUVMQMiTRTz3aSjH0n5CakL19oue1tg+kdBw+X
         jQOg==
X-Forwarded-Encrypted: i=1; AJvYcCWIgG6TGfqikUda7cm/wdqIpVM/fkA39UZAKUPozI9yZxcxlFv9eJSs538vTyu9TyEfp2AZST0cRe2kMnq/b7f91h0jsxDt
X-Gm-Message-State: AOJu0YyTWEDqpbzfwfGtTyuf1MFU3Wjn52APNMumr4Gqpe5l9jst0KkK
	vpwMhGDpKqjOJxLw0aVOtEx17x6GgSHwME5VlGw6dyLXnuCDOk3RiVlkAIErZ6U=
X-Google-Smtp-Source: AGHT+IEUIo8GejnCeZrD5zw3F3haHwaq5mAGTNjcOwYC2zFN3xTcdlE389RLK6tFmH0VnvUuKJke4g==
X-Received: by 2002:a05:600c:474a:b0:419:f241:632f with SMTP id w10-20020a05600c474a00b00419f241632fmr2164107wmo.31.1713969665517;
        Wed, 24 Apr 2024 07:41:05 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm27978565wmb.41.2024.04.24.07.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:41:04 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:40:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"Wyborny, Carolyn" <carolyn.wyborny@intel.com>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Glaza, Jan" <jan.glaza@intel.com>
Subject: Re: [PATCH iwl-next v4 5/5] ixgbe: Enable link management in E610
 device
Message-ID: <ZikZ-5O9Ta1mkT1O@nanopsycho>
References: <20240422130611.2544-1-piotr.kwapulinski@intel.com>
 <20240422130611.2544-6-piotr.kwapulinski@intel.com>
 <ZiZzdAX-qI-7wCMC@nanopsycho>
 <DM6PR11MB46105E83E5597982F1EF02C9F3102@DM6PR11MB4610.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46105E83E5597982F1EF02C9F3102@DM6PR11MB4610.namprd11.prod.outlook.com>

Wed, Apr 24, 2024 at 03:49:09PM CEST, piotr.kwapulinski@intel.com wrote:
>>>-----Original Message-----
>>>From: Jiri Pirko <jiri@resnulli.us> 
>>>Sent: Monday, April 22, 2024 4:26 PM
>>>To: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
>>>Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; horms@kernel.org; Wyborny, Carolyn <carolyn.wyborny@intel.com>; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Glaza, Jan <jan.glaza@intel.com>
>>>Subject: Re: [PATCH iwl-next v4 5/5] ixgbe: Enable link management in E610 device
>>>
>>>Mon, Apr 22, 2024 at 03:06:11PM CEST, piotr.kwapulinski@intel.com wrote:
>>>
>>>[...]
>>>
>>>
>>>>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h 
>>>>b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>>>index 559b443..ea6df1e 100644
>>>>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>>>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>>>@@ -1,5 +1,5 @@
>>>> /* SPDX-License-Identifier: GPL-2.0 */
>>>>-/* Copyright(c) 1999 - 2018 Intel Corporation. */
>>>>+/* Copyright(c) 1999 - 2024 Intel Corporation. */
>>>> 
>>>> #ifndef _IXGBE_H_
>>>> #define _IXGBE_H_
>>>>@@ -20,6 +20,7 @@
>>>> #include "ixgbe_type.h"
>>>> #include "ixgbe_common.h"
>>>> #include "ixgbe_dcb.h"
>>>>+#include "ixgbe_e610.h"
>>>> #if IS_ENABLED(CONFIG_FCOE)
>>>> #define IXGBE_FCOE
>>>> #include "ixgbe_fcoe.h"
>>>>@@ -28,7 +29,6 @@
>>>> #include <linux/dca.h>
>>>> #endif
>>>> #include "ixgbe_ipsec.h"
>>>>-
>>>
>>>Leftover hunk?
>>Will do
>I think it's better eventually to remove this blank line. What do you think ?

Does not seem to be ralated to the patch. Whatever.

>Thanks
>Piotr

