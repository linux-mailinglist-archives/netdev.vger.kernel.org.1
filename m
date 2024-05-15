Return-Path: <netdev+bounces-96481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5398B8C61BD
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B9B1C2176D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6396943ABE;
	Wed, 15 May 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NBbunJm8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6E43AA4
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758458; cv=none; b=FTym/HTMb+okwIP/7pRJyhDgc+4dJPe+CZZKHnDWM1RqHo4j+JJ2B0VP3lnjy8Q+2DewcWRaiCTnkU6YrjwBitz3iIedZIryNCEdn6qAX5s+Vc1wtZHwPZy91aURBnaIxW3RwsVfvNnjgkMWtpt1VNk+U+7pip0MiHABAcLUFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758458; c=relaxed/simple;
	bh=QrPNpXvWtBe6xHxCSukZbnvU65TQ0fHmMLbaLO3xAOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfVIhTuBj/CtJS8gCIwo1pwD3hmCUBRlUMBzMlXn9BVOmEykHbhCMfFHfDSdZWNQ4N8oI+hT6PhWupqnCRZVPyYDpRQTJhgm7K3C34C9Cz+2k5sN07oSEWxwaDVy7A7YNmCjpTI/k3bKp5QqaElkjBMG2NK3zfs8OHwC9DNMoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NBbunJm8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so87027521fa.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715758454; x=1716363254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kD8/1Qg80X1Lu2w9XeEJiUVipNk99bLcKl/O4FD4s+U=;
        b=NBbunJm8Xr045fFCVx/HxyTPXTSDTbJ/55IOShs1YnnrYC06RQ+Qh5Q7Oc+Jlr1Sp0
         +EH7ijsbPMsKYBM5P2bTpxncA7y0laTsA78pnq5Ib+ADYzSP3oQmXihcB2OOtdrtEhjI
         IHtU7MyjwRVcrykWX6ckVPbZsv0fzkjR1JUvxoE9nqzXBN+59Mwid+iPQ2DdBMNWqYQm
         D47QcFNEwN7T0TJl/4dcxcP32YyS16zSyrif2no2l/2LA+qMLbu64WPz6vgTlLfJMToO
         48NaShTxpPfhNdiBuLFXoITSKxZJPuZ+2RVx3BxNhtCmUAf6sNmY5ttWZHEGQdIlnsg/
         pYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715758454; x=1716363254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD8/1Qg80X1Lu2w9XeEJiUVipNk99bLcKl/O4FD4s+U=;
        b=FxeDvGah1SDsn76Ae1+bIqphdOzIvalzK0NNRjytdbb9FIvBcD3BvpFqQpWD3pQKpi
         5Q5zoDrw/WTrcLr40qrxn5EoJYUox8M8pGZUBywmkxQHUsZ9iIB3U+ggedIUbQdfckhr
         dz0na0NovgJ2mKfBVTFK3j3CqVwIdWbCa4xmaWA4MJDPlc01jZyUwbekcyFulq93ND82
         SdB+66rSg19GStw3EoWb+Jihu5vTXPwuycbgJ8fsaFboJe0Grd+0tTjMjecdXiNh0y29
         HzK0k4G7wublFnCGksiTeLO/3VZtLTyR5xAInukyVk7m84jj6vPQUPiEgFsInE12uONd
         yxjw==
X-Gm-Message-State: AOJu0Yzm+68Px9FGfx3g9Ab8NBRhNiMVcECQRNYC9qcB+KPypIfEML0e
	xd6Sn0JJLq/uOM0MvjiN7sBjXTtxDWO/WdwNeBiCaP6KWt69Tm+pI2Pdw3FN5z8=
X-Google-Smtp-Source: AGHT+IGqKKl0cYTL0wrQzzLOxVpGGYXpsmUrxwQj9LAhg/ZB7zM77qtac7G3ooq+SI3f8B3O1F/AWg==
X-Received: by 2002:a2e:a98a:0:b0:2e6:f769:5124 with SMTP id 38308e7fff4ca-2e6f769532emr7988691fa.39.1715758453984;
        Wed, 15 May 2024 00:34:13 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f8asm222070475e9.10.2024.05.15.00.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:34:12 -0700 (PDT)
Date: Wed, 15 May 2024 09:34:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510072431-mutt-send-email-mst@kernel.org>

Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> 
>> >> >> >> Add support for Byte Queue Limits (BQL).
>> >> >> >> 
>> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> >
>> >> >> >Can we get more detail on the benefits you observe etc?
>> >> >> >Thanks!
>> >> >> 
>> >> >> More info about the BQL in general is here:
>> >> >> https://lwn.net/Articles/469652/
>> >> >
>> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >> >mostly I got the feedback from net core maintainers that it likely won't
>> >> >benefit virtio.
>> >> 
>> >> Do you have some link to that, or is it this thread:
>> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >
>> >
>> >A quick search on lore turned up this, for example:
>> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> 
>> Says:
>> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>>  overhead."
>> 
>> But virtio can have one tx queue, I guess that could be quite common
>> configuration in lot of deployments.
>
>Not sure we should worry about performance for these though.
>What I am saying is this should come with some benchmarking
>results.

I did some measurements with VDPA, backed by ConnectX6dx NIC, single
queue pair:

super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
nice -n 20 netperf -H $ip -l 10 -t TCP_RR

RR result with no bql:
29.95
32.74
28.77

RR result with bql:
222.98
159.81
197.88



>
>
>> 
>> >
>> >
>> >
>> >
>> >> I don't see why virtio should be any different from other
>> >> drivers/devices that benefit from bql. HOL blocking is the same here are
>> >> everywhere.
>> >> 
>> >> >
>> >> >So I'm asking, what kind of benefit do you observe?
>> >> 
>> >> I don't have measurements at hand, will attach them to v2.
>> >> 
>> >> Thanks!
>> >> 
>> >> >
>> >> >-- 
>> >> >MST
>> >> >
>> >
>

