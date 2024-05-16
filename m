Return-Path: <netdev+bounces-96720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6228C74D9
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2161F24F4A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891A145343;
	Thu, 16 May 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bo6ZjQ0e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6514533E
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856908; cv=none; b=txXsxIXnDI7xq9eejvsbx+CLG6FOhGXn2v20IJhC+MISu9Vpr1lLdRVtEy3/4iQCNXnKgLAZXyRxzoawoX0/HBN/bM/o+kyo0WGk6Oth7a4jwU+e5NH06Fb2RIhi2tCF2lkqmJ7rXyp0nLgavstaBcsoNRKM9bU/ioRbH55mZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856908; c=relaxed/simple;
	bh=5TnSM+LWP5s3qTntfFdJesDBdSw4kLbabX601vj8+2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2kW/rN9CvoCNMUVXZ6UY2XfhMoJtxi1XhHbXoWz+Xdmiu6R+JwqJcWbzcwiCE/65BwIVFT5cZVmri0ur3jjzSm8YtduVTpcKzs52cwcKIPl5JSU6jYO/S/LRffMTwYB0GuTIJnL8qEzrxsCsr/obkveqF39ZulAWwXfA19z7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bo6ZjQ0e; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a0168c75so328659266b.1
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 03:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715856904; x=1716461704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7X46XyBGn7YI/BzWmEXgP19rZIcDWdKduEjY2/PLLYA=;
        b=bo6ZjQ0eghh6ds5Te5vnknajYF2MxKoNTXyI/c+p4bU3WcIFmuQWJOXoyXEHSDsbOh
         ISkpbNge3z7OdUeRDcKVoV0Qk9w3FHU6oQIEvSlkyT2KEcjBCw0XC19W1WE6poNb7Kmy
         fH5FXMxyVv9F9oVz8wJy0duaCRx9MD3W3JFrqD5TthO9quI6hvFr5ea0rYg1F4PFKNWy
         afe0o+oZ/ICajYNmS1o0UDBLkjFX6ufL3N5acp6mva0ocDSRBgZ/VpHlgkYjFonOA+yR
         qd3UpsNY8NOAxPbGfJdwJ2Iv2LuDwB1ZAfH28/HS5ck8rnwGQSGwiMIAzl9NBmdQVi+x
         q7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715856904; x=1716461704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7X46XyBGn7YI/BzWmEXgP19rZIcDWdKduEjY2/PLLYA=;
        b=uLM6hcBZt8eGRnDDuEY8VyM0KcqzO9dnN21J6Vg6kJ/2uqsqmKTf/QidSW/LWWWSo4
         fGPaBe2W6NN07l+/9zC2Pso4twKXWq0SMHmocb03B5ctU7DjWM5jdvKJOb8DylH7LME5
         V5XDqG9rid4IKC7s+9phL3LA/LeGW0pLFmC+X/cfNRN43noDa0NWK/5SGJA2huYkFTYy
         r5Z33DkHZ8YogVAheEqFUb4MrWIK09Oayq76eU5UdWGDqQKe6YpukFPMcZgIIL9jJyX2
         MQQPQPuPTu21L62VXPMwW6q4KZ1XwoZ+IPL7Z66WKHCIgAHfaODqtpK4eS2Obvo1B+Qy
         ke3g==
X-Forwarded-Encrypted: i=1; AJvYcCVsY9e7eG80x3/P/3Wj7HOh5FXZy3AJvDWmLj8bl2jJtVApJAgW9XUmFmCy7eymGcxRvP28ZoEGowynA0eWur9dEfWHSxf/
X-Gm-Message-State: AOJu0YxFSpS3Xa8F75fhMWZLcka9Sz5oCMDL9s9jdJuA+jPd+oelCnWj
	zdOq/mGcTxY8CsUJJw41Uv35fCOB+Xib3ibkzfPdADGViIa4cHrpqJKFipj1fPY=
X-Google-Smtp-Source: AGHT+IHgsVJM0AOUDBKv17oOvX5pJUDHqBdgDGUos1raZMomhZpyV6l+jo1rL5I6arawRvoNKMzthg==
X-Received: by 2002:a17:906:3a8d:b0:a59:be8a:bd6f with SMTP id a640c23a62f3a-a5a2d65f272mr1144732066b.61.1715856903985;
        Thu, 16 May 2024 03:55:03 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0125bsm981316366b.143.2024.05.16.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 03:55:02 -0700 (PDT)
Date: Thu, 16 May 2024 12:54:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkXmAjlm-A50m4dx@nanopsycho.orion>
References: <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>

Thu, May 16, 2024 at 06:48:38AM CEST, jasowang@redhat.com wrote:
>On Wed, May 15, 2024 at 8:54 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, May 15, 2024 at 12:12:51PM CEST, jiri@resnulli.us wrote:
>> >Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
>> >>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
>> >>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>> >>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> >>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >>> >> >> >> >>
>> >>> >> >> >> >> Add support for Byte Queue Limits (BQL).
>> >>> >> >> >> >>
>> >>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >>> >> >> >> >
>> >>> >> >> >> >Can we get more detail on the benefits you observe etc?
>> >>> >> >> >> >Thanks!
>> >>> >> >> >>
>> >>> >> >> >> More info about the BQL in general is here:
>> >>> >> >> >> https://lwn.net/Articles/469652/
>> >>> >> >> >
>> >>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >>> >> >> >mostly I got the feedback from net core maintainers that it likely won't
>> >>> >> >> >benefit virtio.
>> >>> >> >>
>> >>> >> >> Do you have some link to that, or is it this thread:
>> >>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >>> >> >
>> >>> >> >
>> >>> >> >A quick search on lore turned up this, for example:
>> >>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> >>> >>
>> >>> >> Says:
>> >>> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>> >>> >>  overhead."
>> >>> >>
>> >>> >> But virtio can have one tx queue, I guess that could be quite common
>> >>> >> configuration in lot of deployments.
>> >>> >
>> >>> >Not sure we should worry about performance for these though.
>> >>> >What I am saying is this should come with some benchmarking
>> >>> >results.
>> >>>
>> >>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
>> >>> queue pair:
>> >>>
>> >>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
>> >>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
>> >>>
>> >>> RR result with no bql:
>> >>> 29.95
>> >>> 32.74
>> >>> 28.77
>> >>>
>> >>> RR result with bql:
>> >>> 222.98
>> >>> 159.81
>> >>> 197.88
>> >>>
>> >>
>> >>Okay. And on the other hand, any measureable degradation with
>> >>multiqueue and when testing throughput?
>> >
>> >With multiqueue it depends if the flows hits the same queue or not. If
>> >they do, the same results will likely be shown.
>>
>> RR 1q, w/o bql:
>> 29.95
>> 32.74
>> 28.77
>>
>> RR 1q, with bql:
>> 222.98
>> 159.81
>> 197.88
>>
>> RR 4q, w/o bql:
>> 355.82
>> 364.58
>> 233.47
>>
>> RR 4q, with bql:
>> 371.19
>> 255.93
>> 337.77
>>
>> So answer to your question is: "no measurable degradation with 4
>> queues".
>
>Thanks but I think we also need benchmarks in cases other than vDPA.
>For example, a simple virtualization setup.

For virtualization setup, I get this:

VIRT RR 1q, w/0 bql:
49.18
49.75
50.07

VIRT RR 1q, with bql:
51.33
47.88
40.40

No measurable/significant difference.

>

