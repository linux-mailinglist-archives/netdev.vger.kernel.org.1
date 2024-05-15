Return-Path: <netdev+bounces-96521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9468C64D1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5321A284141
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28159B4E;
	Wed, 15 May 2024 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Gj4Zjxvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6857CB5
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767979; cv=none; b=JbsmMRyUJ1+kh1E1Wl2y6zeA1lnLVgUffobpxUd6hEzp4o51HopU9HQOuiQ67ridYRoM7B/Ea+s5jamDB5TJ4uJecr7TMXOWJq+P+Ow2dHJkblllEofPZNBJlBxtLtGkN5aewFZHiqhdnhCieB2eoBli0imEmA6GnXyVbzTElQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767979; c=relaxed/simple;
	bh=Jm7RUfQw4CI3zJvXTakCTGu3NPLqBKOAnFDP8rBj+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz+Zuy5Dlifc4vRlWohzXILqzFCv2d0yUY+4sH7gAUPqXOg/ptmylT0+NddF+2nrBol9YK8qvcAjKWCq1dx4puqbV5EBv3iwRmTKvYVO0Tn0FPNo0P1lY/EVMJpjgTdw6p+//0+Jj2PddbsNb6ilzDK9V5h9yqBRqaAGjfJhnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Gj4Zjxvm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so125272166b.3
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715767975; x=1716372775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYflvmvoD5h3ewENkkvrbhvA0VaewsbmI1fciZbLpdg=;
        b=Gj4ZjxvmSyEtsMBk/S06CJgpt5a+8azbHHmJJm7eu3Yr4BlxEbP2rhQg3QQQa+HKhn
         wABZlMC/QrltYgLAb6dDDEuVn/+btJ0St3BvWxBHSCqGs8+lcKQBo4+bGxGlpGITshRZ
         vvP/dRS9v1gFpVXwp6vmu83WL9Y4i0wHaxGRXTi37oQfjpwsYUWBI5xvMImx2nsvrz/W
         jsvfPhEkBiUs5qdASFRwfnsf/HmoZB4T5yf3vQj48MxP7K8JWZSLRUjhX91bbX4AcPMP
         il4JJoU8pEETF+czwN5WETQxL1kIYNHzA1eB1HEceE9uctwZGwtvyHi1ooJtPpwo96N0
         SOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715767975; x=1716372775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYflvmvoD5h3ewENkkvrbhvA0VaewsbmI1fciZbLpdg=;
        b=evSrMUTJgWOtQrAozMyHoiPwSdHJSulgPBukSb4kJIJp2X2KuhbbeVmi+zD4FCjMld
         tlERcv/McmMufnab4cUKmcZ+MwzmkgWDtz+hFUxvPEf1yMzMyU28uRRyit6vSwWgFK/n
         iIU4WX9rAumSUlmFEHSQ5dHJXTsGnYO72dmFOr1mig6dEle0PmD1fr8FuhedFQbbdqEs
         bx5TZRUFBG/E4A4NnCcPbXvZcRgJRfiYQnVCOa0H+bTlzTt0zDNjo8tpH8jey0oGQw3m
         KJDL/wZzh+ldFHH2UB54VMjO7dD1f+xFICcuYYGx8cFrdazozg/nJM7c7KaameEDDGD5
         ZrcA==
X-Gm-Message-State: AOJu0YxzyE1CZ6ijt/8ZBd5KP3rgT4Uy/QN/zZDoncg88op6A5aA+GBw
	hUBXxfABQjWuSF7aAWlRlJ87TGgPkxMoQk0ro8LVz5lCizPsuOHR9OmWfkgObE4=
X-Google-Smtp-Source: AGHT+IFXM/EspvfrIN/leickGNyOyUDoR9NHpWMfb2KyTdB2EMc6DkXzoqqVxze0KUhTN+XxLqzKiw==
X-Received: by 2002:a17:907:9952:b0:a5a:1e8f:37f2 with SMTP id a640c23a62f3a-a5a2d66aa57mr979553466b.52.1715767975311;
        Wed, 15 May 2024 03:12:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01602sm846675766b.147.2024.05.15.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:12:54 -0700 (PDT)
Date: Wed, 15 May 2024 12:12:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkSKo1npMxCVuLfT@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515041909-mutt-send-email-mst@kernel.org>

Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> >> 
>> >> >> >> >> Add support for Byte Queue Limits (BQL).
>> >> >> >> >> 
>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> >
>> >> >> >> >Can we get more detail on the benefits you observe etc?
>> >> >> >> >Thanks!
>> >> >> >> 
>> >> >> >> More info about the BQL in general is here:
>> >> >> >> https://lwn.net/Articles/469652/
>> >> >> >
>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >> >> >mostly I got the feedback from net core maintainers that it likely won't
>> >> >> >benefit virtio.
>> >> >> 
>> >> >> Do you have some link to that, or is it this thread:
>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >> >
>> >> >
>> >> >A quick search on lore turned up this, for example:
>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> >> 
>> >> Says:
>> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>> >>  overhead."
>> >> 
>> >> But virtio can have one tx queue, I guess that could be quite common
>> >> configuration in lot of deployments.
>> >
>> >Not sure we should worry about performance for these though.
>> >What I am saying is this should come with some benchmarking
>> >results.
>> 
>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
>> queue pair:
>> 
>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
>> 
>> RR result with no bql:
>> 29.95
>> 32.74
>> 28.77
>> 
>> RR result with bql:
>> 222.98
>> 159.81
>> 197.88
>> 
>
>Okay. And on the other hand, any measureable degradation with
>multiqueue and when testing throughput?

With multiqueue it depends if the flows hits the same queue or not. If
they do, the same results will likely be shown.


>
>
>> 
>> >
>> >
>> >> 
>> >> >
>> >> >
>> >> >
>> >> >
>> >> >> I don't see why virtio should be any different from other
>> >> >> drivers/devices that benefit from bql. HOL blocking is the same here are
>> >> >> everywhere.
>> >> >> 
>> >> >> >
>> >> >> >So I'm asking, what kind of benefit do you observe?
>> >> >> 
>> >> >> I don't have measurements at hand, will attach them to v2.
>> >> >> 
>> >> >> Thanks!
>> >> >> 
>> >> >> >
>> >> >> >-- 
>> >> >> >MST
>> >> >> >
>> >> >
>> >
>

