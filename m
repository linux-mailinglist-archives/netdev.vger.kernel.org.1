Return-Path: <netdev+bounces-101281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 648A38FDFBF
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD92B1F23E5C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5436BFD2;
	Thu,  6 Jun 2024 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="q1CH7p55"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42442AA5
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659009; cv=none; b=dXtx/4Af80XBmsSCS/ZPQlw4sfcspXNf9T3GwGxafcmItqpOemoj8Nlt2wCvkSUBIuZSPxj7Cgzf612YFGbYl6uKk+ASyR2RXc/ZMM/2qZDbUe0cMyVLX67ifvkg0Il0OlBQX9G6ZIPRtX9hhtfs2AzccjTrTOxSJ8JRdyhYNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659009; c=relaxed/simple;
	bh=354xLDXyXFY0m2uPYIP1Kud2kgE0QA5eAoiCRwxw3kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD1WRfPLCRsl+7QOO+5uY9XFfTlbBGPzkoZGpdgs9wTFfxdQoTlZ/VAqhcKGqxe9QJr/vT36HSWalWqFdwsQOgf1VKHPO1ZDz5h3Hw2nidSMFTPmaF/BoMOtXarvpmHezYLYyKi/Jvg2Az3uvRR7rb6j0gJHhQJRdmMaYvktVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=q1CH7p55; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-42139c66027so7383415e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717659005; x=1718263805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfipsjVfQPfXPB6o4x6k5krpbbSASYu2k6RWVLV/C88=;
        b=q1CH7p55WRgWAYhGTUQu/0h7iR4UcP80gyIgnu4cpJhBEdFlw/R9rtzbtUqWuio5jD
         oiXpxIGCoM1rfHEBD9dtFwnaOUgEL0Lelgf1JnqtsjHhGTrEpiOFQayU7ctLSkhtxGFn
         7/kWhp+s5pRJZ8S+MyebpDxyRi8b8id9i3EjifEk+XnBj9PIJ2VSgh5X8DSUuCXYvbEv
         EHYzvTXPHrGzTeiPGEWQ06qGgSsIske85OLdauV9A6CkR9zx5RcUNy2koBE7h8Ne9OaE
         JYLc936P3yeTw6OtlrwRyjCX0xUrsIrrVqivAtEbsnrGB5Epu29pwAjOMGvT+4GuILtO
         31tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717659005; x=1718263805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfipsjVfQPfXPB6o4x6k5krpbbSASYu2k6RWVLV/C88=;
        b=dTaNlqjbSidE8Hr3YUj+K+0fnGaETJ67lwo/gIzMNjIobfuo2DBSueg0whfRQ1VNa8
         cptYRyjZxBQeIcXW9ZIUE62EN3IBeBvIa5WK5e+Q263WACvqBuY8ab13xAnClq5woEeq
         SMWjt3LldonQ4slSYOSiEIaUO3qB0oVrUaiOufYDUMcuT2AQvt/ZjIbRe9hBKGHcqmrN
         /iyBHWAonW80J50cGE+cpoDouivnYdPre4MNbbtLAIB/gE9vNp+UCoBAygbyak6Daq/8
         YMPhkt6f5DfcTMSbMBPj/jvBcyzPY/UnDfmz7Y/qd6CHcPcVeBbaG3liJKdMoJMK38Sk
         wwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhF/bvYYPKmUA6BGKqegAXwqqJTwBt/5XHXRl7GBbh9F8xdgpA1llNECuQzzx7z5W0grGhJxVmmOxXSo3yMV50Rsk/rN7q
X-Gm-Message-State: AOJu0YzdAtLtKqHvpqt+e4wUV88kObXK8F/LScIHNnOHh86RuGS1WOjN
	QIGguLjhKbYMnAlkH6SLmDPFOK125TQgooT28vr0s5PxKG44ssqUb+SQG5zG9us=
X-Google-Smtp-Source: AGHT+IGE15F3AQxu8QAb/xG2jRKD11YQY86wpTtSob9rNljYBoHl4Jk0N73HDE9kOM+sV9EzM94y7A==
X-Received: by 2002:a05:600c:4986:b0:421:542b:b9f2 with SMTP id 5b1f17b1804b1-42156338124mr37582245e9.26.1717659005060;
        Thu, 06 Jun 2024 00:30:05 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fca950sm780520f8f.111.2024.06.06.00.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:30:04 -0700 (PDT)
Date: Thu, 6 Jun 2024 09:30:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Dave Taht <dave.taht@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmFleHJxHkDz5D3Z@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <CAA93jw6WanAQrPAFZ1hYVTXuWDwP+4J70LnmPOD2ugNwYK6HMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA93jw6WanAQrPAFZ1hYVTXuWDwP+4J70LnmPOD2ugNwYK6HMA@mail.gmail.com>

Thu, Jun 06, 2024 at 04:20:48AM CEST, dave.taht@gmail.com wrote:
>On Wed, May 15, 2024 at 12:37 AM Jiri Pirko <jiri@resnulli.us> wrote:
>
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
>> >> >> >mostly I got the feedback from net core maintainers that it likely
>> won't
>> >> >> >benefit virtio.
>> >> >>
>> >> >> Do you have some link to that, or is it this thread:
>> >> >>
>> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >> >
>> >> >
>> >> >A quick search on lore turned up this, for example:
>> >> >
>> https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> >>
>> >> Says:
>> >> "Note that NIC with many TX queues make BQL almost useless, only adding
>> extra
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
>>
>>
>Yay! is that with pfifo_fast or fq_codel as the underlying qdisc?

pfifo_fast


>
>fq_codel, please?
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
>> >> >> drivers/devices that benefit from bql. HOL blocking is the same here
>> are
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
>>
>>
>
>-- 
>https://www.youtube.com/watch?v=BVFWSyMp3xg&t=1098s Waves Podcast
>Dave Täht CSO, LibreQos

