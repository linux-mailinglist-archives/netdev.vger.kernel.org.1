Return-Path: <netdev+bounces-95408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F38C22E4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712B8B2143B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDDF16E898;
	Fri, 10 May 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="z3k5TqiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02F16D326
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339517; cv=none; b=OZU4FCu/tfcDJ29uiW0Ts1UrenBC1r781G98VuirIVzV6fDP2Vs/hWLJXVirRgiPSYa/7jzO5caiszmjfhGViYSQ1zPuSaEpdrQdExP8XHDGrPr6dZ2ZdIub5Ms9pegFPwPwU6tsbH7gLhbC8RwxCWQtW5yCeVGKcJ4b2sqmg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339517; c=relaxed/simple;
	bh=yeo8sd8RFZdJ862z4TQug4Oieue2ymTOsLQYxEAdY08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw7ljsT04RLQa22ODpzFQmo1+jhQf6J2uz3floC42V54tIPNzLiZyY4Tp2OR3ACZUaseG5CznpyU92nNos6ENvqHDjbJAu2Emoy9mWsS/yKKqqAeCe9y/S8AzCX+1GmQZuQYj16r2YwT1O0sSOYQ4acVOUccxAuTWnAlw+DIrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=z3k5TqiZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792bd1f5b28so160802285a.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715339515; x=1715944315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzDowZL4O8ZaZ5oGwMtdLpyR1SKzWoUyd2n/48q61cY=;
        b=z3k5TqiZ0miLDhmtzMG6nni1qUmWge9059HmubHklBY5Wxeg8TC9dps77C7kgj4V44
         ntYDclKXCAQYU6YB+LuqWFtdLFoXkvzgnU29Fq4rudFjd45PRcKbUiNq0fIStUVOFtB+
         W1Qb8zufO6BJcSJmeOce8PKubKe5hLNM148vxJBGUWyw2GLK9/cvDgAoY5mkpurMn+hS
         OaSezFfaKwJ8RhYhfi8JPqHADeHl3MfJch9gk0RDWkW6iATV64EXh1vR4aeQzRBnNlpX
         vA1wMvkO/SsEcYw4pCkZB3GlqbcxNlDY7h5DukoNjYgNuHn9GRDeuvNFHz1i4ERnqKTE
         ZA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339515; x=1715944315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzDowZL4O8ZaZ5oGwMtdLpyR1SKzWoUyd2n/48q61cY=;
        b=Zi35CHarXbvuHIPOkv5Xmu0Ui+yuG+PdPkttUNDvO1rh1wTjAm4oiaFCc2a7yASbdz
         OksLtv/RZrhMxwv4Qss+QcjCBEJJ2FregFjltjvlpKgoO50INVGASUf5TKImogm2CnpZ
         0m/ogB3Yi47yiMDaPksyCMmefbYWK9DWPFPxuVbabsAtDGKIISuw5zriSLmaIoBWZz/z
         LQ8+0XbpDMJS/AKyBlLExyORfSV/4yT0vDsAR3LTF4WPS5iVgwGyUoKIsmhxcXfELU+K
         NCp9iupfE6y5NrwgQ3OZ/mRqi21xMVpgTxOmRTYH7S3ZP7FOMMSteNNoMowisOaXz2k/
         h3Ng==
X-Gm-Message-State: AOJu0YwcsCxwxZOg3UBUfMXpAVtuh3YrNyMDbZ/LVK8/CUO8eET9SdCA
	+/4hIP63t+oBuDehdxi0o9hyYh+WwMRKfHl8Z8489owcr7+Qx2auvPbVw7vMNM0=
X-Google-Smtp-Source: AGHT+IHnhjG58jX47vVHtIqP3sRxriUOfdxV+WZjAFYtYRcjCXfosuwppdjvkX6oUiw2FmBIAynX9g==
X-Received: by 2002:a05:620a:1003:b0:792:91ce:9b07 with SMTP id af79cd13be357-792c760083cmr219679285a.71.1715339514921;
        Fri, 10 May 2024 04:11:54 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310713sm168643085a.109.2024.05.10.04.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:11:53 -0700 (PDT)
Date: Fri, 10 May 2024 13:11:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510065121-mutt-send-email-mst@kernel.org>

Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> 
>> >> >> Add support for Byte Queue Limits (BQL).
>> >> >> 
>> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >
>> >> >Can we get more detail on the benefits you observe etc?
>> >> >Thanks!
>> >> 
>> >> More info about the BQL in general is here:
>> >> https://lwn.net/Articles/469652/
>> >
>> >I know about BQL in general. We discussed BQL for virtio in the past
>> >mostly I got the feedback from net core maintainers that it likely won't
>> >benefit virtio.
>> 
>> Do you have some link to that, or is it this thread:
>> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>
>
>A quick search on lore turned up this, for example:
>https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/

Says:
"Note that NIC with many TX queues make BQL almost useless, only adding extra
 overhead."

But virtio can have one tx queue, I guess that could be quite common
configuration in lot of deployments.


>
>
>
>
>> I don't see why virtio should be any different from other
>> drivers/devices that benefit from bql. HOL blocking is the same here are
>> everywhere.
>> 
>> >
>> >So I'm asking, what kind of benefit do you observe?
>> 
>> I don't have measurements at hand, will attach them to v2.
>> 
>> Thanks!
>> 
>> >
>> >-- 
>> >MST
>> >
>

