Return-Path: <netdev+bounces-96490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE68C62B1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDDE1C21C67
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654BD4DA15;
	Wed, 15 May 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQV+P+ke"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4B4C62E
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761216; cv=none; b=uzxk5KXwsa6omB/WSdaO7CjiIbDLFqbK8FKVORvBzF6/M1yvDnq89sA2baBjsAcWUUHodL95qYb2TEjja99PAfi+nWp+oqQlId45mynlBOExxxvJcomXEPyV/d5UBCoGJz4j5eTrxD/It0wDCzwWqPpQ5yYfm/JixJYEWYCinFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761216; c=relaxed/simple;
	bh=Von8K1hr19jbcxs0QhYjm2GycyfL+IYehPhPIegpbes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4OjcBUHhUp93eWoJsxreTax+ESfUZ4q7XUY75g7GCoIFxyKZ+8918181+zMH9aVhklxvp1WiS8Uh7Pb54RIRrqJdZANjV07AiaNpa3aHWBlc4q+iN1RqZI52C7y7VZ6cJzud7U/A91B/St21BNksDd0NNW7lNQExSluQeZFrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQV+P+ke; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715761213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6GTb6soSug3RyS8kHCdhAkn75spil5Q6oTtvDF3Nik=;
	b=gQV+P+keq/4A693SX4z03YgtSKROuVIdGqYqyt7Jx95CNbKcNzHe7BrqrtDi9P8m0tPxBx
	F1ADU4rvU6hG7gIbqJksprIIPs6fTJI4AKiIJ7n0Wi5vy9yigjNgY2uLjESEJOtI5DXOIu
	tcV6bsw+qx2d+6AHEAnbJa1ekTGaL2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-csQhLiFsNtSuOvqNDxDVzQ-1; Wed, 15 May 2024 04:20:12 -0400
X-MC-Unique: csQhLiFsNtSuOvqNDxDVzQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41fe6df6ef3so25316955e9.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 01:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715761211; x=1716366011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6GTb6soSug3RyS8kHCdhAkn75spil5Q6oTtvDF3Nik=;
        b=Lh3McOUlPPWcsM2qgJVtH6hFkfHQ/x6IWjpK+L6B55ALIArTQcEhBHONIKBx+skKvc
         JKgM/3qK/Kelg5gEFEXzdxjZwfEySKAaGF9S4IPcpHQswO3U9eezpODCna0FU2jtmden
         UyS/VXKopDG1/uV4d4CgJWTCX6eUoq50qELP3dWGudO1tC9PJn0HKbC06l75dCrNnsXQ
         M3QFcF8sESYvUyy8n0JMUkapcAaJKNWfgRGpD7vr6AJyV+Mf6LosE/nU13kSBG/9wHdP
         YO+blLOYGVIlLskmvd+4CKLkHCogOf1pLkOnnSZZ60Jh0quMg7wTMsRgdJC/kNhdFSuR
         20uA==
X-Gm-Message-State: AOJu0YwSJ6Oj3XFdWZS5vT1TsCk84jG5xT+QZOnhrYmPX/ofx7+lbAEi
	bn6LKwE1wJi4m3nLamIkMpSpe+FoTjTxiaxdG8iMJ7CKNXEPeAmgF1ZHHVnzTFgcLX+2Xi9+KXJ
	KgkdUGafkgra6vwVy/OLtpSi5Y58QO/cV4VJesmcvOUt3ToICCcBqrQ==
X-Received: by 2002:a05:600c:4f4e:b0:41b:a271:60a9 with SMTP id 5b1f17b1804b1-41feaa2f38bmr122724665e9.6.1715761210735;
        Wed, 15 May 2024 01:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbkanoozcBNegdjGPA83q//B+n4Fo/RS8QZSaMzBCMK530KpvnilnlCAZ2w8FlImOaSY7u5w==
X-Received: by 2002:a05:600c:4f4e:b0:41b:a271:60a9 with SMTP id 5b1f17b1804b1-41feaa2f38bmr122724395e9.6.1715761210121;
        Wed, 15 May 2024 01:20:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbc5654sm15860263f8f.115.2024.05.15.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:20:09 -0700 (PDT)
Date: Wed, 15 May 2024 04:20:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240515041909-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>

On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> >> >> 
> >> >> >> >> Add support for Byte Queue Limits (BQL).
> >> >> >> >> 
> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> >> >
> >> >> >> >Can we get more detail on the benefits you observe etc?
> >> >> >> >Thanks!
> >> >> >> 
> >> >> >> More info about the BQL in general is here:
> >> >> >> https://lwn.net/Articles/469652/
> >> >> >
> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
> >> >> >mostly I got the feedback from net core maintainers that it likely won't
> >> >> >benefit virtio.
> >> >> 
> >> >> Do you have some link to that, or is it this thread:
> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> >> >
> >> >
> >> >A quick search on lore turned up this, for example:
> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
> >> 
> >> Says:
> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
> >>  overhead."
> >> 
> >> But virtio can have one tx queue, I guess that could be quite common
> >> configuration in lot of deployments.
> >
> >Not sure we should worry about performance for these though.
> >What I am saying is this should come with some benchmarking
> >results.
> 
> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
> queue pair:
> 
> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
> 
> RR result with no bql:
> 29.95
> 32.74
> 28.77
> 
> RR result with bql:
> 222.98
> 159.81
> 197.88
> 

Okay. And on the other hand, any measureable degradation with
multiqueue and when testing throughput?


> 
> >
> >
> >> 
> >> >
> >> >
> >> >
> >> >
> >> >> I don't see why virtio should be any different from other
> >> >> drivers/devices that benefit from bql. HOL blocking is the same here are
> >> >> everywhere.
> >> >> 
> >> >> >
> >> >> >So I'm asking, what kind of benefit do you observe?
> >> >> 
> >> >> I don't have measurements at hand, will attach them to v2.
> >> >> 
> >> >> Thanks!
> >> >> 
> >> >> >
> >> >> >-- 
> >> >> >MST
> >> >> >
> >> >
> >


