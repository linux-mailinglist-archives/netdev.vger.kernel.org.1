Return-Path: <netdev+bounces-117749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD794F10E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7E91C21FAF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1116136338;
	Mon, 12 Aug 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WPpFYtQF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B901DA26
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474827; cv=none; b=Qj2GPr0zsSGopFSD9VF+kD/ke9aULI4/wifkCwcWsC3cIIAgTGpkUJTt22/SSOHMLhdNmP8dnzlet9rJMj1mUjVeQVQLdyctb+cjH3ylKXo4VIfqX4EQdUf3jITTKCp15i4vGBwQifEa5A1Z5N4a71WR1Fsty/k50wiuVP8ps4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474827; c=relaxed/simple;
	bh=jXsUGPM0azQ6am5O8rphtsE2f1Jcfrb9gSmaxsgAgsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ9lmj3jWIOlZHkaaP96Gi+evOD06GQNqO1t/vsqaPTLxhqDCSRUVRlB8OKhC0TPYiU/FmNsTp1XGFVIsctw6nqRdiiMfVJ8SbJ3wVCEs+dXKCiWQsvIOtTmDfEDznlYyhoQlC9Gj6pjrfo3XdIUU5suXRLqCnGr4qiCp6fB9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WPpFYtQF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f035ae0fd1so48444761fa.2
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723474823; x=1724079623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsXc+ldtXWa4NBhL0Q7NRwI//WcOKP+JGSRaCC+SwPo=;
        b=WPpFYtQFDxGmpp6dhm53wq1+4DxJ8ihaqviR4rO6AIsZlc8aAptychCDyOEbjqNMo/
         nov8i1rZ1HAxzJjmmVbDWhXb2LChllUW/tUg3vozGHp2n6jxusiglEIhCJQt95YQIbWI
         wyKYMuiApNqempuTUaaU0esp6xkz43TJ4DRkp0m0h5xwGAC6dWkif+s4/e8mlVM+vVaG
         gxy+39/jMBIqTvlS6L6eTkAV5ReUTslMfrjEKqbJ3eEtGtRki48HXo2toFBq2Nc9Q8QS
         d8/q0ZoFf3I8JkmSrOQA5IizQBjkyqrChhpXPGRecX+PV1K5fuBr6qBLdplVvjZQh2gi
         cR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474823; x=1724079623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsXc+ldtXWa4NBhL0Q7NRwI//WcOKP+JGSRaCC+SwPo=;
        b=ncR/wOaMu5cH4syeuaLavM8D3p3Ux8T8Vw0dWOK0SrM8h5lx/zoBxPZ28v8F366IbO
         jw6tpnRkxtBBiJtg37w2QZGb3wkcf0Xpvh5Y0B8RFrVex8ry98+gQj00tkgBYTWumQNa
         /Ua5rkX8x4HLm7q+anQ0ysf5wIojMpAG6yS4rpAuMheOijvte0gpFD8BOAaNHSbOF5mh
         iS2jSooifVrC96o7rNFQssOAPvVjJ1rcwuOQsLpO/HT+unnunAC521gqX0NYERFrfwBv
         7itTJ1fqX+VZeL54VxfhzNaYlLy26zZ7W/iFMmjMaA/6jU2vnWdcW/PdcsYJcrYbt4WJ
         FJUg==
X-Forwarded-Encrypted: i=1; AJvYcCWXSgDW6BpQMKgQWFMAVrxbjY5XSPDvTCHRpdPpf4UrEVd57GGle+Nd5ndFaumeO0VMiZkB14INZFoobJL//5Tzu3imH4rB
X-Gm-Message-State: AOJu0YxZXaIkBoILHMZpDhQ/bQE/x0xAXqeF+hyMnXSXNm40Y+Pansmo
	5o0ZiZvMe2QJfQhdGPjsNPv9s1X3k4MX/2VklvxtSO57VRud3ar9Oaf0gFRgZjs=
X-Google-Smtp-Source: AGHT+IH+duTYa24F+IU0k9EMbBDn9oDxIknB2g8xOkbeeuAphSGH6pT178MTlEj/sz8f7whhocUh4A==
X-Received: by 2002:a2e:602:0:b0:2ef:2525:be90 with SMTP id 38308e7fff4ca-2f2b717a4b4mr3947401fa.31.1723474822823;
        Mon, 12 Aug 2024 08:00:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938280sm7758811f8f.36.2024.08.12.08.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:00:22 -0700 (PDT)
Date: Mon, 12 Aug 2024 17:00:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next 4/5] devlink: embed driver's priv data callback
 param into devlink_resource
Message-ID: <Zrojg-svvDA7_OUV@nanopsycho.orion>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-5-przemyslaw.kitszel@intel.com>
 <ZrMZFWvo20hn49He@nanopsycho.orion>
 <20240808194150.1ac32478@kernel.org>
 <ZrX3KB10sAoqAoKa@nanopsycho.orion>
 <589aed8d-500c-4e92-91ca-492302bb2542@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589aed8d-500c-4e92-91ca-492302bb2542@intel.com>

Mon, Aug 12, 2024 at 01:50:06PM CEST, przemyslaw.kitszel@intel.com wrote:
>On 8/9/24 13:02, Jiri Pirko wrote:
>> Fri, Aug 09, 2024 at 04:41:50AM CEST, kuba@kernel.org wrote:
>> > On Wed, 7 Aug 2024 08:49:57 +0200 Jiri Pirko wrote:
>> > > > 	lockdep_assert_held(&devlink->lock);
>> > > > 
>> > > > 	resource = devlink_resource_find(devlink, NULL, resource_id);
>> > > > -	if (WARN_ON(!resource))
>> > > > +	if (WARN_ON(!resource || occ_priv_size > resource->priv_size))
>> > > 
>> > > Very odd. You allocate a mem in devl_resource_register() and here you
>> > > copy data to it. Why the void pointer is not enough for you? You can
>> > > easily alloc struct in the driver and pass a pointer to it.
>> > > 
>> > > This is quite weird. Please don't.
>> > 
>> > The patch is a bit of a half measure, true.
>
>Another option to suit my wants would be to just pass resource_id to the
>callbacks, would you accept that?

Why, the callback is registered for particular resource. Passing ID is
just redundant.


>
>> > 
>> > Could you shed more light on the design choices for the resource API,
>> > tho? Why the tying of objects by driver-defined IDs? It looks like
>> 
>> The ids are exposed all the way down to the user. They are the same
>> across the reboots and allow user to use the same scripts. Similar to
>> port index for example.
>> 
>> 
>> > the callback for getting resources occupancy is "added" later once
>> > the resource is registered? Is this some legacy of the old locking
>> > scheme? It's quite unusual.
>
>I did such review last month, many decisions really bother me :F, esp:
>- whole thing is about limiting resources, driver asks HW for occupancy.

Can you elaborate what's exactly wrong with that?


>
>Some minor things:
>- resizing request validation: parent asks children for permission;
>- the function to commit the size after the reload is named
>  devl_resource_size_get().
>
>From the user perspective, I'm going to add a setter, that will be
>another mode of operation (if compared to the first thing on my complain
>list):
>+ there is a limit that is constant, and driver/user allocates resource
>  from such pool.
>
>> 
>> It's been some while since I reviewed this, but afaik the reason is that
>> the occupancy was not possible to obtain during reload, yet the resource
>> itself stayed during reload. This is now not a problem, since
>> devlink->lock protects it. I don't see why occupancy getter cannot be
>> put during resource register, you are correct.
>> 
>I could add that to my todo list

Cool.


