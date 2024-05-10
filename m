Return-Path: <netdev+bounces-95423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70AF8C235D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEEF1F25784
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE65171085;
	Fri, 10 May 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2lsBIem"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4101165FB6
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340437; cv=none; b=dqk8GEJ85qVhmtgZc6ehofy7gEp3nyHTeKbeRjXyfM1w0/21/c+owI6/f2zFfwi5lzjv+dyHF5olkIOCPJAsfjTX+0UEPmurFyMq6TIJ676hwNBdSX9dgjKzuPW89cJjUJgWYtX5I4ltBmikKRMOU+LwCKztYcoQYaxkq4U4nHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340437; c=relaxed/simple;
	bh=1vXN8gl5a8r7UTd15EVbj4/rjwNmtYjpmhhKkt/OoWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sxj5uO2HHm+DEaPEUpVcDJwEJg9Yrn1QjnLRoO8GQ6V7Cvh13qKIrEczzH57fGmUKYEp8AUqOElGqlrn5DUHLQPcU+BqOxlHjo3bGQJMw3FUUrdI42nPEq0WZgrT1nt/SmyJKG0bguNaoOfSJp62akXY2IjnIUV+BQdzYuX+VZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2lsBIem; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715340434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zL54WMHpUJTHp7vtEEd6YRmkxZQS7WvPD7WIyFt9Pfw=;
	b=W2lsBIemh3bt89kNTCN8mf37gXG1GQrGalQLPVC0SCjuQddCpM9+slME+NOQvHs/XrbRIR
	brlgpJ7Xu1Bq6l4QJZ/E/CeUePMf3Ip2Sp/P3b/OR53pQuWupqSm5Kn2mAUTliRUh2yIDJ
	my3WYjAVTr97IUMBJh8PI/bi1vr3oMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-mSY0bZtkO6y-cB6qqoKNjA-1; Fri, 10 May 2024 07:27:13 -0400
X-MC-Unique: mSY0bZtkO6y-cB6qqoKNjA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34c99c419e7so1217334f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340432; x=1715945232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL54WMHpUJTHp7vtEEd6YRmkxZQS7WvPD7WIyFt9Pfw=;
        b=WXr02QKj2zJkAwop5kcdenNpknRchb1RbzgE+u+Q0hbbYy2vYDI9cNRTXgB1JjU0AF
         +h0yFi0uDewkXyhnp6hixPAAQ1VlRuSZiDTRkcM+bBXD5KXVw9YuN+OiqjYUm7T502ae
         cZQlv/9mp1u7Yg0oB0VixTykFOeedUa27hcNKqd4oCYRx+v28uam+MyShutrf2trfi2B
         4gvSSsOqYHpDVyexj5FWI0kkRVUp2MVztYRughrgGcJzJMozZmPzB0ytmEN5P3sEcuPI
         C+ndb0mJEDr14EFCitaL5i6obEQ00OiPs//SeNVHPSTk9apLQjd/P5Kgs83tqvRCHeiX
         kjkg==
X-Gm-Message-State: AOJu0YyIMbIQ4eaaL3jfgZusdaAc+VqrHEup9nUL/QILEIUmVLMFtfie
	Zn/1G64EY/B43AR+eRPp3bQ5foqrQ6/7qQ+fFdrnRQ6623SSp6OlJSsUQ5YN30oZhXF6oDO0gJc
	80hLDfA9+LVvMNl+4y89yJHq4zgCVCWzox2kgoez04a6zNKA7cyPgQw==
X-Received: by 2002:a05:6000:1744:b0:351:4e42:c5ff with SMTP id ffacd0b85a97d-3514e42c78cmr702957f8f.51.1715340432491;
        Fri, 10 May 2024 04:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHapTqABhwzPCaap/HscARYrgTo7yeZ2giVs7KaAR0eDvOvYnpDDqNhFeiXWiRr9KgbHb8FvQ==
X-Received: by 2002:a05:6000:1744:b0:351:4e42:c5ff with SMTP id ffacd0b85a97d-3514e42c78cmr702919f8f.51.1715340431880;
        Fri, 10 May 2024 04:27:11 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc082sm4332589f8f.107.2024.05.10.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:27:11 -0700 (PDT)
Date: Fri, 10 May 2024 07:27:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240510072431-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj4A9XY7z-TzEpdz@nanopsycho.orion>

On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> >> 
> >> >> >> Add support for Byte Queue Limits (BQL).
> >> >> >> 
> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> >
> >> >> >Can we get more detail on the benefits you observe etc?
> >> >> >Thanks!
> >> >> 
> >> >> More info about the BQL in general is here:
> >> >> https://lwn.net/Articles/469652/
> >> >
> >> >I know about BQL in general. We discussed BQL for virtio in the past
> >> >mostly I got the feedback from net core maintainers that it likely won't
> >> >benefit virtio.
> >> 
> >> Do you have some link to that, or is it this thread:
> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> >
> >
> >A quick search on lore turned up this, for example:
> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
> 
> Says:
> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>  overhead."
> 
> But virtio can have one tx queue, I guess that could be quite common
> configuration in lot of deployments.

Not sure we should worry about performance for these though.
What I am saying is this should come with some benchmarking
results.


> 
> >
> >
> >
> >
> >> I don't see why virtio should be any different from other
> >> drivers/devices that benefit from bql. HOL blocking is the same here are
> >> everywhere.
> >> 
> >> >
> >> >So I'm asking, what kind of benefit do you observe?
> >> 
> >> I don't have measurements at hand, will attach them to v2.
> >> 
> >> Thanks!
> >> 
> >> >
> >> >-- 
> >> >MST
> >> >
> >


