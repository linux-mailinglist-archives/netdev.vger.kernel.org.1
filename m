Return-Path: <netdev+bounces-117157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D394CEF5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27381F21B95
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA491922D9;
	Fri,  9 Aug 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DnIBUGDL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C517993
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200769; cv=none; b=h/KKAYyBH0JMC0c5LqFbv4mTnjzy54HdZbLYUdUmbFE5bs8MRxAOOxhbshVNZDySKWQjUOP4eUw2JU0j5YAOyWUKqhL2NzoIbYHkx3OP1k3kspuYy+hsQ3Bm0XCGv+F03vUkn9eCmot9ANiLucXt3FfZXWmzxUiJFbNnM1nVl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200769; c=relaxed/simple;
	bh=gihui08yI9Qy6NdrbN3T0R5qkXvNZpLT3UWM0+RyjQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbk00QGb80TmzWaxhQWEyj57HDwc5+SODYFClP/Iv7Tyr8G1joUfCaOL9nAlRbirip0XQn7VOgNgOXvh3zy6g3nVt/8dlIevPv9fx/vmpHOqBlX4hf5Oi7WKaTFc5mu6DhMspbmnBwvYANDHsgdIMqxVDxWAK0bpJ8LKHBnP1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DnIBUGDL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso1891421a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723200765; x=1723805565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kiWJE5/8pGLVo4Gm+PVZVQJBpcxBPR8cvNhJKGvGcfs=;
        b=DnIBUGDLM6RxQnWhEpjBiPnxHDZ2Gb8hT+2w0T/NpkP1cJiXnGPjFA4wn1U8feSx8V
         qHgwtmCI80gCx3agaxDPWJiSxPZ6c/Xo5fnDEALs7iE1W0z4g2JByBwV00A/1di9Y3b/
         Lrl0vi3SNlrD03uCZybysxx7lxToVPPl9X9CuOgJ99xCgL2IPC68FECYLPAgJnO7/gyQ
         bL4P8u0u8mYuV4hCcUze48eRc08FvrOFYViJiTHRBB2byvp8adQSLfpX3Yc8u8/qz3if
         f8ESAXV73Xgd5POKEExoADU2gO7UMahXfoYZ6qSm490690vHguwKi+J5RbmgA99SV/eG
         oIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723200765; x=1723805565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiWJE5/8pGLVo4Gm+PVZVQJBpcxBPR8cvNhJKGvGcfs=;
        b=YUbJCBUpQxT5EeKE/36VDM4fq5Bzjbji8NXwUaUP9PTOUMdaVgNyepDti6xZvfd5+a
         99zX2g6V0tQ/EYQYWKld9A5LkzsIWQmLZqp7EELOjvKloSus2L7bnW7FUV06nbhGC4iz
         jRIdtKZ9PO2BoeJh5ft70kSVbvxKiGt6p3hgYAh0Lvx3nNxLoLVPSpbmhB+WYeNy75KL
         mapaFHWX3Swr06lQOmKxBmFueGWldE7BkKP2AXQhakoM8rkkWLw1i91lkmXLhllBeu9w
         9FuGKmCNQ4GRxCWzr+qIWwg+zAd4G6qb6cTQJ919BYzhYyDWShKfXLy8M4x7m5cNmX73
         Qixw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/JoDgyxg5T8177ez32MXCL/PBKITQkFOdqrOtbapdGtBUfIsK6kccUJoC7PPT20nT1Oi87mVRMqEnRfMFAJOVuLDzT4z
X-Gm-Message-State: AOJu0Yxr1+PU7JwkRdj5nzwaiFD/nTA2fI5dozni4/e7b6voWL0IiWb1
	GizLWXHHwf4S+yU9X81KKvgjkBf9KEaQ9Eb8UKPvxGkk8xAMzSefbKx8xRwDUTk=
X-Google-Smtp-Source: AGHT+IHIjSqUukzlL4ZOQy/Z78vTSNK4/Bb7hQdjn9oY4m/EVfxnr+qH/0fi0DE8JWDE4pjrMmHT8Q==
X-Received: by 2002:a05:6402:2790:b0:5b9:462d:c52b with SMTP id 4fb4d7f45d1cf-5bd0a52d861mr1088651a12.12.1723200765091;
        Fri, 09 Aug 2024 03:52:45 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm1437475a12.33.2024.08.09.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 03:52:44 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:52:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	wojciech.drewek@intel.com, marcin.szycik@intel.com,
	netdev@vger.kernel.org, konrad.knitter@intel.com,
	pawel.chmielewski@intel.com, intel-wired-lan@lists.osuosl.org,
	nex.sw.ncis.nat.hpm.dev@intel.com, pio.raczynski@gmail.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v3 1/8] ice: devlink PF MSI-X max
 and min parameter
Message-ID: <ZrX0--lPBusR_aKE@nanopsycho.orion>
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
 <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>
 <ZrTli6UxMkzE31TH@nanopsycho.orion>
 <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>
 <08fbb337-d2f1-47a7-871e-3890b34a782f@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08fbb337-d2f1-47a7-871e-3890b34a782f@molgen.mpg.de>

Fri, Aug 09, 2024 at 07:18:38AM CEST, pmenzel@molgen.mpg.de wrote:
>Dear Michal,
>
>
>Thank you for your patch.
>
>Am 09.08.24 um 07:13 schrieb Michal Swiatkowski:
>> On Thu, Aug 08, 2024 at 05:34:35PM +0200, Jiri Pirko wrote:
>> > Thu, Aug 08, 2024 at 09:20:09AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> > > Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>> > > range.
>> > > 
>> > > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> > > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> > > ---
>> > > .../net/ethernet/intel/ice/devlink/devlink.c  | 56 ++++++++++++++++++-
>> > > drivers/net/ethernet/intel/ice/ice.h          |  8 +++
>> > > drivers/net/ethernet/intel/ice/ice_irq.c      | 14 ++++-
>> > > 3 files changed, 76 insertions(+), 2 deletions(-)
>> > > 
>> > > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> > > index 29a5f822cb8b..bdc22ea13e0f 100644
>> > > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> > > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> > > @@ -1518,6 +1518,32 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
>> > > 	return 0;
>> > > }
>> > > 
>> > > +static int
>> > > +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
>> > > +				 union devlink_param_value val,
>> > > +				 struct netlink_ext_ack *extack)
>> > > +{
>> > > +	if (val.vu16 > ICE_MAX_MSIX) {
>> > > +		NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");
>> > 
>> > No reason to have "PF" in the text. Also, no reason to have "max MSI-X".
>> > That is the name of the param.
>> 
>> Ok, will change both, thanks.
>
>Maybe also print both values in the error message?

Why? The user is passing the value. Does not make any sense.

>
>> > > +		return -EINVAL;
>> > > +	}
>> > > +
>> > > +	return 0;
>> > > +}
>
>[…]
>
>
>Kind regards,
>
>Paul

