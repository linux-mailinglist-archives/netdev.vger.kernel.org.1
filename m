Return-Path: <netdev+bounces-96729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430C8C7670
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375CE1C20C6B
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827E97E763;
	Thu, 16 May 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6b3W+hz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D303BBE6
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862732; cv=none; b=s1FZD2A2Poo/4GtxoxtTyFcO4UUpFehJKCzXPOwNhfAwRX99ENdtyBcXM9k8EwdO62jseprBIrC81jDJBhytT5IahgmZhYTinsuD6BvinEH15nz8ARAWBE0OW2y8p7pyftcV+06Wph9sDMLXVyQMwzqrKPqWwRnYe/MvIGMXWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862732; c=relaxed/simple;
	bh=88gTpqB5Ftz6F6woFWb8LTvWrxcCnYccA8e3KlmMLjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToMEPXM+IS2CQbuGq5sKcoCyspgP/YyocFOwquAofvum093mj+CtYrA9XrOd1+MVNNATR4rxQb+99/RO1U8GKuosdiFZ8k4piuOMyUEN/4nQkXFw0XROkf68L0e8G1kTIPgtBmUCqEQ6eoek4EFHgX3hYzVj4ra+bLWUCfhnymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6b3W+hz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715862729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhHbQMjCYZe2tVGaOVo8jm6NxFMaMenPci+l9CbDFR8=;
	b=A6b3W+hzZZldRF590amPkcynebrl5pr0M026fcj17wGFhPnmwBDWnvjhZOBrG0EbPFClAS
	3j0zx+Ui3TDWXvpLZ4h00s+SOeKzNIBb5+kEDTE3YquTxhRPwtUvfW5IgJwOX8emWQK/em
	Hpe5wnuAe416XYdr0zEKc0iIyO99/Aw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-qjzWK89uOqOpD-vW3_dD4g-1; Thu, 16 May 2024 08:32:07 -0400
X-MC-Unique: qjzWK89uOqOpD-vW3_dD4g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-574ebea4810so2724223a12.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 05:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715862726; x=1716467526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhHbQMjCYZe2tVGaOVo8jm6NxFMaMenPci+l9CbDFR8=;
        b=u5qcVfRmDwKC/Pg2WrgdvRL39XvN1mACWwBkbsOQEBAeHUfU/tNIza+3cfoPuPTMQR
         DfDCkdmB0cBfwvAdy/wntXU2sit6o7L8vzZ/Igb5Gs++dXkaM8oLpNOJDpybGwVRB9Mp
         WhmbFBRjAogivp6oizpM/sbxfh/zhmN1t+PXthk+592pZvcqUp+8OMYqcjU6o8F6dulr
         SzTttVyFq5xVE2WR/WNw0ZiKRGIQml3afCqLvRO9ldAuCv70EbMymHI2oGSTa5JhtAKh
         qBaGpMWH1u9Mcj3yHAU2hcfKsSyNWmS2SYBciI7pMGRq6hV9v2VS2hI6ONQ3915OY0qc
         t+4g==
X-Forwarded-Encrypted: i=1; AJvYcCWb3KxxTjtasEX0wIgtUD+/+oRVfOlhP6dzTIaNEUFaPvWAyK1PyoLgxZLsSUhfstb3EyXpBDXX6XOOVtsVSrcWGV0vILWN
X-Gm-Message-State: AOJu0YyYKOc3lAGt3E21zsAtMkU67LH5DhzC4ROnT4Bks+gsoOzZ9Kou
	i5yQUqbQRwsiB9ABXOvrhWiHKXYWUu8ULTiXIdm8vYrFo8OzYb62pqqJh6ZUfVgSX/4CAXaEJq1
	G+L7O37z5KUJ6VgCf8NFRxhmdcwBOCRw4uwsnNpxvCsOUcWB/UY1iCQ==
X-Received: by 2002:a50:9fa7:0:b0:572:a172:be71 with SMTP id 4fb4d7f45d1cf-5734d6f2765mr17566227a12.14.1715862726513;
        Thu, 16 May 2024 05:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFImWIsxwOBVoe62bfajvu5GwknXbPVawtJ1C+lr8xulQduklxf5v3r+XFuu3k3muscwMPhoQ==
X-Received: by 2002:a50:9fa7:0:b0:572:a172:be71 with SMTP id 4fb4d7f45d1cf-5734d6f2765mr17566196a12.14.1715862725867;
        Thu, 16 May 2024 05:32:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb57asm10381581a12.26.2024.05.16.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 05:32:05 -0700 (PDT)
Date: Thu, 16 May 2024 08:31:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240516083100-mutt-send-email-mst@kernel.org>
References: <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
 <ZkXmAjlm-A50m4dx@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkXmAjlm-A50m4dx@nanopsycho.orion>

On Thu, May 16, 2024 at 12:54:58PM +0200, Jiri Pirko wrote:
> Thu, May 16, 2024 at 06:48:38AM CEST, jasowang@redhat.com wrote:
> >On Wed, May 15, 2024 at 8:54 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >>
> >> Wed, May 15, 2024 at 12:12:51PM CEST, jiri@resnulli.us wrote:
> >> >Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
> >> >>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
> >> >>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
> >> >>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
> >> >>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
> >> >>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> >> >>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >> >>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >> >>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >> >>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> >>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >>> >> >> >> >>
> >> >>> >> >> >> >> Add support for Byte Queue Limits (BQL).
> >> >>> >> >> >> >>
> >> >>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >>> >> >> >> >
> >> >>> >> >> >> >Can we get more detail on the benefits you observe etc?
> >> >>> >> >> >> >Thanks!
> >> >>> >> >> >>
> >> >>> >> >> >> More info about the BQL in general is here:
> >> >>> >> >> >> https://lwn.net/Articles/469652/
> >> >>> >> >> >
> >> >>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
> >> >>> >> >> >mostly I got the feedback from net core maintainers that it likely won't
> >> >>> >> >> >benefit virtio.
> >> >>> >> >>
> >> >>> >> >> Do you have some link to that, or is it this thread:
> >> >>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> >> >>> >> >
> >> >>> >> >
> >> >>> >> >A quick search on lore turned up this, for example:
> >> >>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
> >> >>> >>
> >> >>> >> Says:
> >> >>> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
> >> >>> >>  overhead."
> >> >>> >>
> >> >>> >> But virtio can have one tx queue, I guess that could be quite common
> >> >>> >> configuration in lot of deployments.
> >> >>> >
> >> >>> >Not sure we should worry about performance for these though.
> >> >>> >What I am saying is this should come with some benchmarking
> >> >>> >results.
> >> >>>
> >> >>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
> >> >>> queue pair:
> >> >>>
> >> >>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
> >> >>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
> >> >>>
> >> >>> RR result with no bql:
> >> >>> 29.95
> >> >>> 32.74
> >> >>> 28.77
> >> >>>
> >> >>> RR result with bql:
> >> >>> 222.98
> >> >>> 159.81
> >> >>> 197.88
> >> >>>
> >> >>
> >> >>Okay. And on the other hand, any measureable degradation with
> >> >>multiqueue and when testing throughput?
> >> >
> >> >With multiqueue it depends if the flows hits the same queue or not. If
> >> >they do, the same results will likely be shown.
> >>
> >> RR 1q, w/o bql:
> >> 29.95
> >> 32.74
> >> 28.77
> >>
> >> RR 1q, with bql:
> >> 222.98
> >> 159.81
> >> 197.88
> >>
> >> RR 4q, w/o bql:
> >> 355.82
> >> 364.58
> >> 233.47
> >>
> >> RR 4q, with bql:
> >> 371.19
> >> 255.93
> >> 337.77
> >>
> >> So answer to your question is: "no measurable degradation with 4
> >> queues".
> >
> >Thanks but I think we also need benchmarks in cases other than vDPA.
> >For example, a simple virtualization setup.
> 
> For virtualization setup, I get this:
> 
> VIRT RR 1q, w/0 bql:
> 49.18
> 49.75
> 50.07
> 
> VIRT RR 1q, with bql:
> 51.33
> 47.88
> 40.40
> 
> No measurable/significant difference.

Seems the results became much noisier? Also
I'd expect a regression if any to be in a streaming benchmark.

-- 
MST


