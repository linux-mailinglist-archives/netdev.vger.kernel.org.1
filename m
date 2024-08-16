Return-Path: <netdev+bounces-119142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB9A954549
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF16B24C5A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4D12CDA5;
	Fri, 16 Aug 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KJW6XEBr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF31CFA9
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799775; cv=none; b=frT2j1TIFX/VPfyoO9USB2Pb0YiH793X0LcmIBlr2qZkAdpIopNz3uQqW16vNXksfCYuBWSD3S23Rqx7NGngGp2RkSbLntZ6DLS9CNr50QrpTPtBS3cF7ZZE1AYeUMaGVnu0B39dgHqLr/UMN/bosl+cDDNv6O57VeaV3OZM2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799775; c=relaxed/simple;
	bh=KhFzClpWaYMaY2HGwxdJDdOyQ4OMDkcql7vddp/d7c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICx69j20rCZIaPIvOp1NQwIf0a6GmTfIHs/HqOYkSIgnUdb3vIVfpJtcN+oeY5Kj7fH6vP8pmUsfKwcoKkHnCMeU2C6CVxqoNop9E6Us0j7XuJpik16zW8nA//M18XaSryZQUYTZoI9rsI/f0tLzhYhRoHtYtP16mO/uPgRr9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KJW6XEBr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5320d8155b4so2423989e87.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723799771; x=1724404571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANHRNDsAWTMxllgPfKVftFsax9ZmMYJKKoS4vUy4dE0=;
        b=KJW6XEBrMvm9nKk6x202C+OIJSVJ8O4j97KaED2UGiZKNwaNlymycfSI/3vS1qqJpO
         R1f/Wju2g2iWD/EtDuYpJuA9Flg+ejc+E7mjtr35uaL4a7kV6PsBTWtMS72074fNMGEt
         6AbSzPyiPdyLOsv+00mTmwp2Crk6qqjqNw7nO0sSDm7uOttCtlfE/uK3dqPNWAWbn4Lg
         yLQO9zqwngTMKxGGBLx/IpoYHSqASPziWd5vVsuXDac8X6gY6NQCjQlLsAkefiAt0+3g
         Yy/b69cGq+HvjUF0odlaA7rVP0zQ+QAM2KK/UAsduccH6cL34LuOr7Eoop72aDKolXOY
         V3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723799771; x=1724404571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANHRNDsAWTMxllgPfKVftFsax9ZmMYJKKoS4vUy4dE0=;
        b=nioPAEY/4SiG0PWURFSlMrn9utfufo/PiQasTFPSPm9ByhdocbwEZoEriRy6A8O6W5
         dnjNInI9+VHRetLWpBvoBhAwjXwQ20fDPxEHuyTW+oRpJ/rYl84B44+Z19CaKyCcGvxm
         6/fXvJMLH0baNwCUzrG6RNtlEBtovNoOd1CtZkddmwKsaVMLIP5UBv6Dc2n0TKzwyxv+
         8eS0gLbsmrvjqKqR/wA6KkPzWtDFrAHJnzdcTKUai6Ra8AkVVRQJ7bY3SUrSNTplyAP6
         u/SrTqWumMiTETr7hZ3JwuNizLihm6qwTO99mYBxnLh4glGGtQDaVrFQerCcBkU2KsGv
         sHQg==
X-Gm-Message-State: AOJu0YzhABiWXxdtngMG+FP6YuDFJoWeL9feOaWNRGUyUFLB9WF6qweC
	Qs5e0xzii7pSxC4awApp10Yi1o8lri//z5/E31q//U9gTxcD8AEDRE1nCEn7DKGyW6gss0nRZDY
	Cct0=
X-Google-Smtp-Source: AGHT+IFUs+C1OYvYKzXLIE1QaWlc3HWQM+GCTJundj/GiPjj4hXcr8A7rvNBWMdzlTpP9ZUP5Y16/Q==
X-Received: by 2002:a05:6512:224e:b0:52e:9cc7:4461 with SMTP id 2adb3069b0e04-5331c6900a4mr1422041e87.5.1723799770544;
        Fri, 16 Aug 2024 02:16:10 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded18468sm70101905e9.2.2024.08.16.02.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 02:16:10 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:16:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
 <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
 <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
 <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>

Fri, Aug 16, 2024 at 10:52:58AM CEST, pabeni@redhat.com wrote:
>On 8/14/24 10:37, Jiri Pirko wrote:
>> Tue, Aug 13, 2024 at 05:17:12PM CEST, pabeni@redhat.com wrote:
>> > On 8/1/24 15:42, Jiri Pirko wrote:
>> > [...]
>> > > > int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
>> > > > {
>> > > > -	return -EOPNOTSUPP;
>> > > > +	struct net_shaper_info *shaper;
>> > > > +	struct net_device *dev;
>> > > > +	struct sk_buff *msg;
>> > > > +	u32 handle;
>> > > > +	int ret;
>> > > > +
>> > > > +	ret = fetch_dev(info, &dev);
>> > > 
>> > > This is quite net_device centric. Devlink rate shaper should be
>> > > eventually visible throught this api as well, won't they? How do you
>> > > imagine that?
>> > 
>> > I'm unsure we are on the same page. Do you foresee this to replace and
>> > obsoleted the existing devlink rate API? It was not our so far.
>> 
>> Driver-api-wise, yes. I believe that was the goal, to have drivers to
>> implement one rate api.
>
>I initially underlooked at this point, I'm sorry.
>
>Re-reading this I think we are not on the same page.
>
>The net_shaper_ops are per network device operations: they are aimed (also)
>at consolidating network device shaping related callbacks, but they can't
>operate on non-network device objects (devlink port).

Why not?

>
>Cheers,
>
>Paolo
>

