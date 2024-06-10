Return-Path: <netdev+bounces-102296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D523B9023E6
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A812817FC
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F94984E1F;
	Mon, 10 Jun 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1yPhAsB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606D23B0
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029156; cv=none; b=ZBni6qjN4AkF0hVoE3vkyAwUpry7YfVKG76Vq+QrzEcIS6tvpoRc8AfcxEKm705XAuT9Eq9b9ZVVhLJMA0Fk+gLohklwLGopSdtmkkr2VTguJrGwu6OXiidHGgJL8QX3TJ43KfmFMPBuEigMEEceGzogS7VsleR4SLuV3Nu0FgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029156; c=relaxed/simple;
	bh=Rl2tVPiX9UWvnu+ZPwPmaHdP1YszauJ4RtH4EfVZS/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtnUZAyNEBesKZBiHIan660JJFUmWgZQAIFeVhuE96Q4zNV5o4Ze3VHRxgoLtG8wfww3q9ZP0NidXWPIEQwgabh8h2oWZeZoVmA3q06jE9UrmVfdYHBmeK7m7ROacQ9KKql9jK1AaH0ghWdxYSjg2hZKuTVXG+G5PWetDTek24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1yPhAsB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718029153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fQYADQiwQp5dfNvEaV5J/jkCAEg3Kh2jQNmcpyXbzo=;
	b=J1yPhAsBQfyJHfCPEVbqKjv1AgJuBOnYLrUw2Ce3/ZMdBvoeM0CWQBS0CJa/ZLfU0ZxAua
	pS3NZcJFD7HT3Hk/hDt65dDEqnBSYNkS2j6kWYTrAxkYYKzBBLyHQwwwR01Lba3/mbEB/F
	W04a+cuNNsGR3iuboXDdAFlUoRHIMyA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-QP7oqtkIM2KupHd3_ltSfQ-1; Mon, 10 Jun 2024 10:19:09 -0400
X-MC-Unique: QP7oqtkIM2KupHd3_ltSfQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57c753a879dso887203a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 07:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029148; x=1718633948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fQYADQiwQp5dfNvEaV5J/jkCAEg3Kh2jQNmcpyXbzo=;
        b=hUavHVW6AXdPor/SCXMPuwE8yIuG1T7IfFhPi23KeV2Q4whjTaUauGxwUWqIlKNaQC
         kXnOPkmm9ng9XMnGSgtf85mjqBoBqoUGb3bjuwySqh+UW+9LeAL3iTqfis3GsKfkSxQK
         lo8LBXoH0MsAN2sZZVDSdURz8ssI/6w6qyzmI3XWVKg9AGZB706QI+UmtTLj7yb6KLLG
         GQzTT1VJUM7mn6+HDs7xXUsXHm4d1EuJWma9WBd/BbCiNw77gTkxptClYu1OeW9IN23Z
         IGu9zr4mCCs0XgqD2LOn1jAouzN1jHZLZTItNdfMeTDMNeVLXtH5UvhJ4Vx4OoxkKhgA
         Uqvw==
X-Forwarded-Encrypted: i=1; AJvYcCXT6f8eDs3eTm7k76UJj/ZnoGio7VSiQaUlj+SunCgTnBaEQZ34iG8zoyaRzsvUpvM5B1gQBtekKuqyHzcXVEDDGsl20BPM
X-Gm-Message-State: AOJu0YzN2YiGM04KC3rB74D4fGd2FWqTj0sW0SGEHo3QqfqO6WU0NpRz
	pIDPcI9jXkDopOsrt+59dGE8GA6q4TNRngAIqWtiVSlZT1s9VuPhY0r4GFurq4ThnF3syjQxLSM
	65VGxm/k4Qp+oe/RHflZbf0psqn2//62mBrRkyqwBh9zfQkEoTvpTVQ==
X-Received: by 2002:a50:cdc1:0:b0:57c:7641:72e2 with SMTP id 4fb4d7f45d1cf-57c76417319mr3169037a12.30.1718029147744;
        Mon, 10 Jun 2024 07:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCp3exlBA6B9Bw4Hrp54qJGJT7MsRMusp9B/hD6uoUg1sf4LnZ6GbChe4UfO/h6zYmtLS4hw==
X-Received: by 2002:a50:cdc1:0:b0:57c:7641:72e2 with SMTP id 4fb4d7f45d1cf-57c76417319mr3169012a12.30.1718029147149;
        Mon, 10 Jun 2024 07:19:07 -0700 (PDT)
Received: from redhat.com ([2.52.131.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c828dd0dfsm1807666a12.72.2024.06.10.07.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:19:05 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:18:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240610101346-mutt-send-email-mst@kernel.org>
References: <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
 <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmLvWnzUBwgpbyeh@nanopsycho.orion>

On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> >> >True. Personally, I would like to just drop orphan mode. But I'm not
> >> >sure others are happy with this.
> >> 
> >> How about to do it other way around. I will take a stab at sending patch
> >> removing it. If anyone is against and has solid data to prove orphan
> >> mode is needed, let them provide those.
> >
> >Break it with no warning and see if anyone complains?
> 
> This is now what I suggested at all.
> 
> >No, this is not how we handle userspace compatibility, normally.
> 
> Sure.
> 
> Again:
> 
> I would send orphan removal patch containing:
> 1) no module options removal. Warn if someone sets it up
> 2) module option to disable napi is ignored
> 3) orphan mode is removed from code
> 
> There is no breakage. Only, hypotetically performance downgrade in some
> hypotetical usecase nobody knows of.

Performance is why people use virtio. It's as much a breakage as any
other bug. The main difference is, with other types of breakage, they
are typically binary and we can not tolerate them at all.  A tiny,
negligeable performance regression might be tolarable if it brings
other benefits. I very much doubt avoiding interrupts is
negligeable though. And making code simpler isn't a big benefit,
users do not care.

> My point was, if someone presents
> solid data to prove orphan is needed during the patch review, let's toss
> out the patch.
> 
> Makes sense?

It's not hypothetical - if anything, it's hypothetical that performance
does not regress.  And we just got a report from users that see a
regression without.  So, not really.

> 
> >
> >-- 
> >MST
> >


