Return-Path: <netdev+bounces-175829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF0A67A10
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D0017CA3E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C70210F44;
	Tue, 18 Mar 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j7hTOOiS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC91865E5
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316712; cv=none; b=OAgsdAimwacEIpdJGGoIaW8/UBFNxFzndoM+Kt8NbiaSBvC00WMDLIr1WASfSAewHUaDaMt+jZUyJ3UqMvrkD7Zz724Ckutx3nvl+1Ei5tpcj0xc7QA+zl8h4ilK3TbnFuTRozaZTdEbJ4wg/eH7b/tX05wjt7b/7qqkZnYww2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316712; c=relaxed/simple;
	bh=ri+MrH/QvEhcuJwQhTNMn0luZh65IW5aFmBW9G45Q6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDVL3/LXJwQrYx2bpQIwFepztEX/ku9SLnIla/07G02P87+Xxm3BHVqwv7q4ze9eyjC7pfnk6xx5Pzu9215uuXmNeBieGiqgfIoBFof/fPYdOV5c9706Yy9XByOxiEaTnx7waFyc8xpniMJ9Mk6FBn5gLVy+j2itBpi3rO6AW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=j7hTOOiS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394036c0efso24649735e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742316704; x=1742921504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd7w5FEi6lJ0WmuOJ4HeWnhU/eOYM0fn3bzYP/oNRkY=;
        b=j7hTOOiSCWiEPBfwCaqf5IP4lbeAoTokhA69+/J4YalNXWI7eqpgZRFneGJvCJy6Ld
         Q68Q112zdcBzAaUitpoJO6zXt+UNgl8vP/QBh5aMlY52P1K+rT2O7xokvgaKz64RjuJW
         XdJGGBW/3ZPQ4TdtDM6rm9eER7+kF5SZu5AI89RoUPObZ5a7Mc+1T6X0g2tQE+FLVb/s
         ElP4xXbvbXpDFBK+u4vqdZVI4t27D3ObbkwRhFl2g872WrOuA29hT+pRHEcmTuJxT0f7
         hSdyhmMCZduZ8OCHZqY6tHFMnusD64MnzorOhwjy+4RQCLK8zM4uPgq9ZTx1oyatjOiY
         JBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316704; x=1742921504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd7w5FEi6lJ0WmuOJ4HeWnhU/eOYM0fn3bzYP/oNRkY=;
        b=go39wVdehfXaBe4O4Q/MMUoF4a0t6fc+uOCBMzNWMiqN2jDJ62myDcqYf42SlCO8hn
         dYyLPVIILKombQ7EuL0Bf9Ub56AIBGeBWgSx+2FtDdt/53BQxiVl1YJp+rBgRGtpVw3I
         uMi020FXN9ZXcUsTDowyGrRsb/Mdeg+puxMvcW+K+HI1IW4PNPxI6BPwG8M0gppRjXYA
         GDZH+Y+TevpGgQ6tLQRba89CiMi3lMSnVfB42Ltvrnl9OhffHVeoj5bnqAE3SGK5DL1F
         wLUEBDLyr93K0RENTwdSOOvkUJNCF/wqsfRb/E0LNCO5TGnOnuZrTIZ15ktev//dqd/V
         yhKA==
X-Gm-Message-State: AOJu0YxoiQcHUhk9D5c+M4xInOgp+q5kb7IT/sbPj2HS6uQeXBaBA6Yo
	M9Zt4++z6yS1jgWaBTpQLCj9HdacGxcS3VuJ3Hd7vurHv7TtXn83ca+HENT8YOA=
X-Gm-Gg: ASbGncttNJP0YxOohuEszcYUU7sVI7ERvQikoEBpgvR4BjwcX/jOxU5S2zl5+ORIQX4
	Z1C9PCPkWm/RiLy5+RLUnm7PilEIFqIzzsEkLrTF5HBs50uZel8NU17defGLzv9myw7Z4yX0SzC
	ZybMvDrgqMdrFM5Yr/c8BPzE0tLaygh7+4YMZAVetQFcZeweBZ+kQX3Q+I/LCfP3XyM18s7ifA/
	PqzJDlBuD2nf+FPvNugmZdaZ4+z6pchIvP+eQ/b2lRdQ379VOt5iOKrMzdKwN1F8zmQZBXQYKOK
	H3Tke7skdyxyFvaYJ0Xk/Z00uUBxVQesT+huqZgnJ03BjSauzhiC2XBoa483xGvZlW4fDQ9DDCy
	c
X-Google-Smtp-Source: AGHT+IE8xdnry5nupdwCoroX3xogrImmKRbRtQk7LsfUS0zkOxJ2nm+5qpdQQI0ZOZvHwEthUuYDGw==
X-Received: by 2002:a05:600c:83c8:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-43d3b9a00ddmr34949145e9.16.1742316704555;
        Tue, 18 Mar 2025 09:51:44 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe292d0sm139772245e9.20.2025.03.18.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:51:44 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:51:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, andrew+netdev@lunn.ch, dakr@kernel.org, rafael@kernel.org, 
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, cratiu@nvidia.com, 
	jacob.e.keller@intel.com, konrad.knitter@intel.com, cjubran@nvidia.com
Subject: Re: [PATCH net-next RFC 1/3] faux: extend the creation function for
 module namespace
Message-ID: <paftiyrmjuiirv7j26eenezpqlszva55w2lmsutflmt2tfwufp@za2pg2q7t43n>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-2-jiri@resnulli.us>
 <2025031848-atrocious-defy-d7f8@gregkh>
 <6exs3p35dz6e5mydwvchw67gymewpzp5qyikftl2mvdvhp3hqf@saz6uetgya3l>
 <2025031817-charter-respect-1483@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031817-charter-respect-1483@gregkh>

Tue, Mar 18, 2025 at 05:04:37PM +0100, gregkh@linuxfoundation.org wrote:
>On Tue, Mar 18, 2025 at 04:26:05PM +0100, Jiri Pirko wrote:
>> Tue, Mar 18, 2025 at 03:36:34PM +0100, gregkh@linuxfoundation.org wrote:
>> >On Tue, Mar 18, 2025 at 01:47:04PM +0100, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> It is hard for the faux user to avoid potential name conflicts, as it is
>> >> only in control of faux devices it creates. Therefore extend the faux
>> >> device creation function by module parameter, embed the module name into
>> >> the device name in format "modulename_permodulename" and allow module to
>> >> control it's namespace.
>> >
>> >Do you have an example of how this will change the current names we have
>> >in the system to this new way?  What is going to break if those names
>> >change?
>> 
>> I was under impression, that since there are no in-tree users of faux
>> yet (at least I don't see them in net-next tree), there is no breakage.
>
>Look at linux-next please.

Sure, but it's still next. Next might break (uapi) as long it's next,
right?


>
>> >Why can't you handle this "namespace" issue yourself in the caller to
>> >the api?  Why must the faux code handle it for you?  We don't do this
>> >for platform devices, why is this any different?
>> 
>> Well, I wanted to avoid alloc&printf names in driver, since
>> dev_set_name() accepts vararg and faux_device_create()/faux_device_create_with_groups()
>> don't.
>
>If you want to do something complex, do it in your driver :)

Yeah, I don't really want to do anything complex, that's why I wanted to
take leverage of dev_set_name()


>
>> Perhaps "const char *name" could be formatted as well for
>> faux_device_create()/faux_device_create_with_groups(). My laziness
>> wanted to avoid that :) Would that make sense to you?
>
>I wouldn't object to that, making it a vararg?  How would the rust
>binding handle that?

Why should I care about rust? I got the impression the deal is that
rust bindings are taken care of by rust people. Did that change and
we need to keep rust in mind for all internal API? That sounds scarry
to me :(


>
>thanks,
>
>greg k-h

