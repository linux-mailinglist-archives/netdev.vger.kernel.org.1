Return-Path: <netdev+bounces-96750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D748C794E
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EB91C21EC0
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832314B97B;
	Thu, 16 May 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BOdDqJPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFFE14B978
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873129; cv=none; b=pXslzZIud5EnNWKKrLwKj4ALDTprCH62TNhAAxZM4SwMyNpx3I2vduwnlmO2jCtXU+ThpsKPDghtob81tm5lvqYlxz2fjkK1Kj9MRg+W8k1Iey6RB0/v1qrMiqtsL3iNv7V/uKgG827T4sgk+wcr1lX3CbYluSgFTIQfiPSuP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873129; c=relaxed/simple;
	bh=f3SS1eFWt0ACAdjmZS/GbnlBgkVs0UinCkd30Yl50cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEh1Q9doezVZaH7gommOHQ8WpnnfTQ+8gWB7nyEGVaVPWdIucSRRorW/2vigR0lDuBeFHvZ0Vu9pO1PN8hDKR7rFGVeH9QcKtYJnnzFTh9zLeml0+W4d+6ngmJrRFdtEo8vzzSSq1DTGHGybqmT3zCZ9IDJrcr3GCJXeGOFC9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BOdDqJPW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so2901390a12.1
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715873126; x=1716477926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iMEsJHMiD/X46uJXawQgYh9V4HrqmWeXXkDDfg4vbl0=;
        b=BOdDqJPWWeDYqRkH9oKHu1PGzkc2R+A4pjrTfFZs+V2dvMGxdyhck1dLeV7/bQfVl0
         4T40GswY/XLxMLxn2zUK0qm5u6D4F2lT8UDLX2DUMFsvn620pP2lQcB3fBAulV4XITHY
         eEq+z7TxIc4h1eEKaRaxe3YExhJiHdQKT5zwrA63+fqrt50WX0OWXmy5WjgHudNDXuP+
         pJsUdJNOxboHxGKnsB71Y4iX9YXDFz2uEDwH5B4yYO/wpFrzN8TXs7ILN6noFFgQuFhw
         wMQ/F/1SkDLm/+s5MMF4rtMRRbn6hYHynjynpfJTyDsgJ+C1FXRgJUYxsSEy/J64W1fS
         SEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715873126; x=1716477926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMEsJHMiD/X46uJXawQgYh9V4HrqmWeXXkDDfg4vbl0=;
        b=AmHitxQSrIfaEEEgB+v9udMrczHZ2hQnjEVhN0EpwamQ/l5wRbVsAsB3T5J0g3rYGM
         JBwmkwoJiJfGpVbFJqsSAeTYxEUiaGEJDpUjy6o6sN8+way6DyJS7EqEHBwDDUTcKamn
         n9PJ7q3N9m/xp0po3BhJRPZzc7HYu88n2ocY5/ZxiEQpjXX6JeFc7k8GEAImxfcfKwYg
         ORkZClYTiAp0IuRmHSGxnmS/Q29Uxl/W8nee+NfGeteNMIGwAigiWk4Ljz5yxCB51D0y
         hG5rzTBUGplWrqPTAIUQ7W4yVCNcVkrH2WkHPAZM+5qKqA6bq7iEcNX4AJHKdC/iRTqQ
         bXGg==
X-Forwarded-Encrypted: i=1; AJvYcCWPBWeAM8ktov0plUoKwgs6Bhh4vQLJli+UdHHeggPWik4GOjrWA6FGRfZxxYpR3aPlIFIiXdXNk00ktup27oOVXbp526aN
X-Gm-Message-State: AOJu0YwG5py6hnSvHns352bAlu4gHjhAfr6kJIgxmA1OzOAt83FR9nhW
	coKKi8l4mnV7CkCfuiOoic+zf+1KhZT+5xsiB33Cac21ItOndaQCxi7rIDLEt58=
X-Google-Smtp-Source: AGHT+IH6QhUzPVp4eNTpup0OheM47LaT+Z/ki9a3NhbHKFKIi97/nvnM8TTY4J9sQHrYRWv51epAMg==
X-Received: by 2002:a50:aade:0:b0:572:9b21:e0c9 with SMTP id 4fb4d7f45d1cf-5734d5cf9damr20696976a12.14.1715873125834;
        Thu, 16 May 2024 08:25:25 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-573413b2ac3sm10377997a12.38.2024.05.16.08.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:25:24 -0700 (PDT)
Date: Thu, 16 May 2024 17:25:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkYlYLFthXVmHOaQ@nanopsycho.orion>
References: <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
 <ZkXmAjlm-A50m4dx@nanopsycho.orion>
 <20240516083100-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516083100-mutt-send-email-mst@kernel.org>

Thu, May 16, 2024 at 02:31:59PM CEST, mst@redhat.com wrote:
>On Thu, May 16, 2024 at 12:54:58PM +0200, Jiri Pirko wrote:
>> Thu, May 16, 2024 at 06:48:38AM CEST, jasowang@redhat.com wrote:
>> >On Wed, May 15, 2024 at 8:54 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Wed, May 15, 2024 at 12:12:51PM CEST, jiri@resnulli.us wrote:
>> >> >Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
>> >> >>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
>> >> >>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>> >> >>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> >> >>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >> >>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >> >>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >> >>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> >>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >>> >> >> >> >>
>> >> >>> >> >> >> >> Add support for Byte Queue Limits (BQL).
>> >> >>> >> >> >> >>
>> >> >>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >>> >> >> >> >
>> >> >>> >> >> >> >Can we get more detail on the benefits you observe etc?
>> >> >>> >> >> >> >Thanks!
>> >> >>> >> >> >>
>> >> >>> >> >> >> More info about the BQL in general is here:
>> >> >>> >> >> >> https://lwn.net/Articles/469652/
>> >> >>> >> >> >
>> >> >>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >> >>> >> >> >mostly I got the feedback from net core maintainers that it likely won't
>> >> >>> >> >> >benefit virtio.
>> >> >>> >> >>
>> >> >>> >> >> Do you have some link to that, or is it this thread:
>> >> >>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >> >>> >> >
>> >> >>> >> >
>> >> >>> >> >A quick search on lore turned up this, for example:
>> >> >>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> >> >>> >>
>> >> >>> >> Says:
>> >> >>> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>> >> >>> >>  overhead."
>> >> >>> >>
>> >> >>> >> But virtio can have one tx queue, I guess that could be quite common
>> >> >>> >> configuration in lot of deployments.
>> >> >>> >
>> >> >>> >Not sure we should worry about performance for these though.
>> >> >>> >What I am saying is this should come with some benchmarking
>> >> >>> >results.
>> >> >>>
>> >> >>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
>> >> >>> queue pair:
>> >> >>>
>> >> >>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
>> >> >>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
>> >> >>>
>> >> >>> RR result with no bql:
>> >> >>> 29.95
>> >> >>> 32.74
>> >> >>> 28.77
>> >> >>>
>> >> >>> RR result with bql:
>> >> >>> 222.98
>> >> >>> 159.81
>> >> >>> 197.88
>> >> >>>
>> >> >>
>> >> >>Okay. And on the other hand, any measureable degradation with
>> >> >>multiqueue and when testing throughput?
>> >> >
>> >> >With multiqueue it depends if the flows hits the same queue or not. If
>> >> >they do, the same results will likely be shown.
>> >>
>> >> RR 1q, w/o bql:
>> >> 29.95
>> >> 32.74
>> >> 28.77
>> >>
>> >> RR 1q, with bql:
>> >> 222.98
>> >> 159.81
>> >> 197.88
>> >>
>> >> RR 4q, w/o bql:
>> >> 355.82
>> >> 364.58
>> >> 233.47
>> >>
>> >> RR 4q, with bql:
>> >> 371.19
>> >> 255.93
>> >> 337.77
>> >>
>> >> So answer to your question is: "no measurable degradation with 4
>> >> queues".
>> >
>> >Thanks but I think we also need benchmarks in cases other than vDPA.
>> >For example, a simple virtualization setup.
>> 
>> For virtualization setup, I get this:
>> 
>> VIRT RR 1q, w/0 bql:
>> 49.18
>> 49.75
>> 50.07
>> 
>> VIRT RR 1q, with bql:
>> 51.33
>> 47.88
>> 40.40
>> 
>> No measurable/significant difference.
>
>Seems the results became much noisier? Also

Not enough data to assume that I believe.


>I'd expect a regression if any to be in a streaming benchmark.

Can you elaborate?


>
>-- 
>MST
>

