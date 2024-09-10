Return-Path: <netdev+bounces-126942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F3973386
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E465285E0F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ECD192D78;
	Tue, 10 Sep 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmp7hrbY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC25188CC1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964106; cv=none; b=mRDABBmlI9FxHGtXAbsQd2THt+o9+iSWIsdF3kojLzCUgq6++mvcIqW6FGu8cj8ouAMw2K4aIRPF+Uv8sspmS+RaOV4Mp8iDj4mLBFgZ7htKPP6virV5XwNaLa2vI6tlscXrszn6IMa15QcKODxNOtpwf9FFvuqmpTfcnI5TF/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964106; c=relaxed/simple;
	bh=HWNthFNF71w9nipoFGTJdMMRzg/r5xSEBcew6X5Fb/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+1D0wXLu03vLTQ6TBWXvfK7K0zVGZ563RHP12IC15Rtn1bYdYIP2IKWJvzkzI+ZhmUuQAVPlwUMP0jziFiqqBvLx12bhDWlCzWkL/FFPYWxA6NFcnC1FqaMRkZQK5yxiiQRMi9EfjQo3Ot8Wvhba29zOk8Ng0X4x/JMmRI7Ch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tmp7hrbY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725964103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1eNsdDeurXKUqT6hdN/12CbCMZoMTT0I3sAzfCQeUI=;
	b=Tmp7hrbYVoU9Qr1YfjCXVR9AzBUj9GgsXim5L+04aDryTBexu0RQwmWH4Ex791EWyFCeXm
	FA0z/dIzkb7R+nwYTrHW/Pgb2eL0OUMOVntIbXBjsJ6GzOXeMCaeHF/QwicInatFPW284v
	YfF77tq4q11CIozPFjydZRABGQE3eZs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-0FNlMV2rMKKOXzjWpFT8Iw-1; Tue, 10 Sep 2024 06:28:20 -0400
X-MC-Unique: 0FNlMV2rMKKOXzjWpFT8Iw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c90d24e3so3720716f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 03:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725964099; x=1726568899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1eNsdDeurXKUqT6hdN/12CbCMZoMTT0I3sAzfCQeUI=;
        b=B/BH7EFwUEa3ikHU43uWFaJlH5WFKEZMkGK+vy+TDwn1FWCmzuHr/tmQewT+fakp+o
         Jc/Wutzn3bPvRg6ppyEobCdyAyPdsW35MYKarO71Sntj57bHvPtfwG8uTAE6wlDz0bky
         FdI3A48lO9U+93Hvg7pIHTAG2K58QJcA9T65SoJFi1pHQ2TpjtOEcGl5ui3aLBrxx/co
         j0TUa9/JuMj2sLQIW46/ypVA4G7df0ndFLPaYFGUWTnlp2mVDMYquttwBgd71nJAMtvW
         6FvRw50shTJF/jY/yIm3S3Nsi1HwNVIMQ+xvjEQeZrhsGE90QkbEdA3Zso+pmr1E7wo4
         hbhw==
X-Forwarded-Encrypted: i=1; AJvYcCV3M7kJK5ZTLeGux2rqhJY6sspAA5rmJf6ynXKfT4SwCE3xV1iY3284pR4g9fAHcaXsTQ841SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgba7HaUegnLGgCRMvXyhRLQCmKGJ3mEnwngCfJIvm2Ad6uURI
	sut6W/nwwWvMOHI8L6yas35IraTIDzitwmotLAUloHCjGeAxFWzvaAnjZz2jQt/EZdkgvSo0BLM
	tXIHxyNiRFrwu1CKo9LCdhhR/mjECi7kPYK+g0q1UD8uDGwYAByg/zw==
X-Received: by 2002:adf:9c09:0:b0:374:c7d2:4d76 with SMTP id ffacd0b85a97d-3789243faffmr8448350f8f.50.1725964099319;
        Tue, 10 Sep 2024 03:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq9L7tDCrvXncqGPJ9wcxUFJfgY3BGhhfaavih3McnT2MdVJsgVLi8PtsJvQJCpIgiX5JYtQ==
X-Received: by 2002:adf:9c09:0:b0:374:c7d2:4d76 with SMTP id ffacd0b85a97d-3789243faffmr8448303f8f.50.1725964098281;
        Tue, 10 Sep 2024 03:28:18 -0700 (PDT)
Received: from debian (2a01cb058d23d6001ef525940bfc7e6a.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1ef5:2594:bfc:7e6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956761c6sm8525488f8f.61.2024.09.10.03.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:28:17 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:28:16 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <ZuAfQFbzYchyrybw@debian>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
 <20240903113402.41d19129@kernel.org>
 <ZthSuJWkCn+7na9k@debian>
 <20240904075732.697226a0@kernel.org>
 <Ztie4AoXc9PhLi5w@debian>
 <20240904144839.174fdd97@kernel.org>
 <ZtrcmacoHyQkqZ0h@debian>
 <CANn89iJ-K82U8mSNW_NGQtzKr70weHrWiFqnBEj-ehhWRHveFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ-K82U8mSNW_NGQtzKr70weHrWiFqnBEj-ehhWRHveFg@mail.gmail.com>

On Fri, Sep 06, 2024 at 02:47:15PM +0200, Eric Dumazet wrote:
> On Fri, Sep 6, 2024 at 12:42 PM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > On Wed, Sep 04, 2024 at 02:48:39PM -0700, Jakub Kicinski wrote:
> > > On Wed, 4 Sep 2024 19:54:40 +0200 Guillaume Nault wrote:
> > > > In this context, I feel that dstats is now just a mix of tstats and
> > > > core_stats.
> > >
> > > I don't know the full background but:
> > >
> > >  *    @core_stats:    core networking counters,
> > >  *                    do not use this in drivers
> >
> > Hum, I didn't realise that :/.
> >
> > I'd really like to understand why drivers shouldn't use core_stats.
> >
> > I mean, what makes driver and core networking counters so different
> > that they need to be handled in two different ways (but finally merged
> > together when exporting stats to user space)?
> >
> > Does that prevent any contention on the counters or optimise cache line
> > access? I can't see how, so I'm probably missing something important
> > here.
> 
> Some archeology might help.
> 
> Before we had tracing, having separate fields could help for diagnostics.

Interesting, I didn't think about it from a diagnostic perspective.

Considering that we now have tracing and skb_drop_reason, does it still
make sense to keep this distinction between core and driver stats?

I find this approach elegant, but since no UDP tunnel respects it and
that dstats are only used by one driver (vrf) I wonder what's the best
path forward.

I'm restricting this discussion to UDP tunnels, as I'd like them to
keep their implementation as consistent as possible (to hopefully ease
code consolidation in the future). But feel free to broaden the scope
if necessary.

I can think of two possibilities:

  1- Follow the core/driver stats policy and convert vxlan, geneve and
     bareudp to dstats (NETDEV_PCPU_STAT_DSTATS).

  2- Give up on that policy, let vxlan and geneve as is and convert
     bareudp to tstats (NETDEV_PCPU_STAT_TSTATS). Then convert vrf to
     tstats too and drop NETDEV_PCPU_STAT_DSTATS which becomes unused.

Any opinion?

> commit caf586e5f23cebb2a68cbaf288d59dbbf2d74052
> Author: Eric Dumazet <eric.dumazet@gmail.com>
> Date:   Thu Sep 30 21:06:55 2010 +0000
> 
>     net: add a core netdev->rx_dropped counter
> 
>     In various situations, a device provides a packet to our stack and we
>     drop it before it enters protocol stack :
>     - softnet backlog full (accounted in /proc/net/softnet_stat)
>     - bad vlan tag (not accounted)
>     - unknown/unregistered protocol (not accounted)
> 
>     We can handle a per-device counter of such dropped frames at core level,
>     and automatically adds it to the device provided stats (rx_dropped), so
>     that standard tools can be used (ifconfig, ip link, cat /proc/net/dev)
> 
>     This is a generalization of commit 8990f468a (net: rx_dropped
>     accounting), thus reverting it.
> 
>     Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 


