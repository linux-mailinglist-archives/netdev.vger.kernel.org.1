Return-Path: <netdev+bounces-96544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB958C6690
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DED283DBD
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACD284D14;
	Wed, 15 May 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Qru3J4zy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68DB84D22
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777654; cv=none; b=V21Ywnrhkt5sxLigV2pWIg2hVgh+FTwHpBO3KxME/0Xpfp7zbw0iw/UgRqQtLTuOYM+SNT6nkMpOP6pzyUk6G28fqsDQMlGPNEspduNEUC8Z9YWlftL1Q4VV632HNEceaA2/20Z4N9k40I1nsR/jykKaB7dPeVf9lbIFgmNFd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777654; c=relaxed/simple;
	bh=fa0lk4wrnn3s5FADJjPgnJrV+uzfIIxTSfTO+n9aVOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDC8id96LZrYY30nAxHK/hw+2ZI6DRcCRbxbBdfCT2U04FuHeijp+pvq/3oSMuX0cn7fOOa6J4YEY76vsp0lfBNnUH6Li04cA7lmRkCVXyhBiC4/aYGNF9rNOxPDSMvFFZoT2Qo+QVGF7tI3jY9AtsjJMMZOarRKpOi/igkiKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Qru3J4zy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so3940344f8f.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715777650; x=1716382450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=399YWrOQm2u/X7iwRgitAignXFxnAABjsBtmCgGDs6o=;
        b=Qru3J4zy2tBxa1HUOCFfXYdLB7V1WzuiloDhH3saLmb26QHg0e9mhLNSo4s83Oi9Ht
         XBgxPMJgzYeVkPLIs0fw5BNlhgTwgYMz1P0gc3ULkEtm1+2Moiz1PW09FTJFiJGWvhna
         nrhuuvjjYaBDfl84nPWaGYIQKfz8clWhxO99onmDW3IWQTDsdqlM8HEAQSfz2KhlArsa
         B38jTbp4COJH3HdeW9shvnt6VeOM04cInne2TFtna5ddzhWmYrMosMlRMj0Ya6+0zrd8
         yYLNhQPBi+3v88UjukamAA4l0CTBDmXWRPvMujLW+O9fCnGRJLTAjGoRycAo8UDlUF4C
         d3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715777650; x=1716382450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=399YWrOQm2u/X7iwRgitAignXFxnAABjsBtmCgGDs6o=;
        b=P8bNjo7/725F8rs33abDx2JlcfKwXHBlqyI3NHgeO0vJXbI4c4HLBOdAVUgbKtMRiG
         OZVksfmHuFlqWHe9KX3ir/dVGMJCUqG6Q1VnBfmuXpayzZv+nCcKnozytymwwGRTpfPp
         Fd5ESIUTknuybPtd3z/NmHIxf0BOi/f41W50hJPiiJtSytjBU38oHe5baDMAqhAZI7BQ
         O+0ROuOGRSyymG26BMoBUfg7BEevtyuNe9/jZ4S/jvRVYmbPY9rtbCG84AYjfTk7ZQHW
         BpCpGkBVujOOIgL7E1XRzdobwfr/kJHD1GUbvDzP/iMWIObOYcprZ1DnuM3kcus172y1
         Q3Jg==
X-Gm-Message-State: AOJu0Yz3HWq/RBkXl9vP5t8mU5FDMJajZRbF5OyA4UGL8FByz1OpXHmK
	QcRPBWmw1wBD64KnZ9/XLevPRjiZfBKszKOivFKitg/fe8obOvDmvURWm4b9+FgD3rVvb843aKr
	5
X-Google-Smtp-Source: AGHT+IE4YrrtRuAFNWww2vR5w1DpfKkKPKDKWLHkD81iqzTV9ozJs4BXxNZfFL3AHXUrn1Eq821Dfw==
X-Received: by 2002:a5d:6e0b:0:b0:34c:cae0:c989 with SMTP id ffacd0b85a97d-35049bbf662mr14131125f8f.33.1715777649820;
        Wed, 15 May 2024 05:54:09 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc3bsm16388034f8f.13.2024.05.15.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:54:09 -0700 (PDT)
Date: Wed, 15 May 2024 14:54:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkSwbaA74z1QwwJz@nanopsycho.orion>
References: <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkSKo1npMxCVuLfT@nanopsycho.orion>

Wed, May 15, 2024 at 12:12:51PM CEST, jiri@resnulli.us wrote:
>Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
>>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
>>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>>> >> >> >> >> 
>>> >> >> >> >> Add support for Byte Queue Limits (BQL).
>>> >> >> >> >> 
>>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>> >> >> >> >
>>> >> >> >> >Can we get more detail on the benefits you observe etc?
>>> >> >> >> >Thanks!
>>> >> >> >> 
>>> >> >> >> More info about the BQL in general is here:
>>> >> >> >> https://lwn.net/Articles/469652/
>>> >> >> >
>>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
>>> >> >> >mostly I got the feedback from net core maintainers that it likely won't
>>> >> >> >benefit virtio.
>>> >> >> 
>>> >> >> Do you have some link to that, or is it this thread:
>>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>>> >> >
>>> >> >
>>> >> >A quick search on lore turned up this, for example:
>>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>>> >> 
>>> >> Says:
>>> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>>> >>  overhead."
>>> >> 
>>> >> But virtio can have one tx queue, I guess that could be quite common
>>> >> configuration in lot of deployments.
>>> >
>>> >Not sure we should worry about performance for these though.
>>> >What I am saying is this should come with some benchmarking
>>> >results.
>>> 
>>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
>>> queue pair:
>>> 
>>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
>>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
>>> 
>>> RR result with no bql:
>>> 29.95
>>> 32.74
>>> 28.77
>>> 
>>> RR result with bql:
>>> 222.98
>>> 159.81
>>> 197.88
>>> 
>>
>>Okay. And on the other hand, any measureable degradation with
>>multiqueue and when testing throughput?
>
>With multiqueue it depends if the flows hits the same queue or not. If
>they do, the same results will likely be shown.

RR 1q, w/o bql:
29.95
32.74
28.77

RR 1q, with bql:
222.98
159.81
197.88

RR 4q, w/o bql:
355.82
364.58
233.47

RR 4q, with bql:
371.19
255.93
337.77

So answer to your question is: "no measurable degradation with 4
queues".


>
>
>>
>>
>>> 
>>> >
>>> >
>>> >> 
>>> >> >
>>> >> >
>>> >> >
>>> >> >
>>> >> >> I don't see why virtio should be any different from other
>>> >> >> drivers/devices that benefit from bql. HOL blocking is the same here are
>>> >> >> everywhere.
>>> >> >> 
>>> >> >> >
>>> >> >> >So I'm asking, what kind of benefit do you observe?
>>> >> >> 
>>> >> >> I don't have measurements at hand, will attach them to v2.
>>> >> >> 
>>> >> >> Thanks!
>>> >> >> 
>>> >> >> >
>>> >> >> >-- 
>>> >> >> >MST
>>> >> >> >
>>> >> >
>>> >
>>

