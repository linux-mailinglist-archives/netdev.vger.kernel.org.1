Return-Path: <netdev+bounces-239897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D634FC6DAD5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 050632DD17
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247C33D6E3;
	Wed, 19 Nov 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/ClbgOi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0RvHfVq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5833C1AE
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544022; cv=none; b=hPP7jCnRa6D66Gej90ffThyLPv5c0ybXcfM9YOTkyGkPFP1z624E4LY+o8bZP4sSSfUNN3rsfrTmzG24uoO1k7hTt3agoXJr0QMTjSUFY/Vj4hTTIFeFnnOJCCZaiJPhG+aGUiS0q6EIWP4o+ktUwLZA40KGi8U1l3d6goqZeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544022; c=relaxed/simple;
	bh=efBNnvAjenT3ydeuHvhZ3DPeJKGBTHhPQVyKb3mVB3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKwaaQnk7d6+osjrmWybf2c/7PhLTTtuZyFPTq0I0OCOE1R6Nzfv6aTfIQeMK9e94m/RYAyiSRy2nm0K8zplNaeF1hHvAMZ8BF6+xg1KZVIzQcpanw97GxkIrlFHxpeDj3unzuocNqBJcX1PxD8soa+tYGljJYZHSLX8nxqf+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/ClbgOi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0RvHfVq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763544019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4vo3A+zEqT6r4yHEPPmlJtSIbXl0hcYVxsto02QGrA=;
	b=M/ClbgOiQo43Y9ABGNXXGAdSqubMFMkFqxwNw9QD3uBRs52ivV7P7MlSTIsSpsgrg8dZkU
	gNt+RsyCQU2fCsQMDD2QL5INl5y8ipEwwStFP9o7/0Imzuy5ytuIzq5w2UgBkAao/tIOEa
	ncSodRx9hPZ69mYyInB7etY95d37eaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-33BoINJYPqe_0dzOba2xhw-1; Wed, 19 Nov 2025 04:20:18 -0500
X-MC-Unique: 33BoINJYPqe_0dzOba2xhw-1
X-Mimecast-MFC-AGG-ID: 33BoINJYPqe_0dzOba2xhw_1763544017
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so25989545e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763544017; x=1764148817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4vo3A+zEqT6r4yHEPPmlJtSIbXl0hcYVxsto02QGrA=;
        b=Z0RvHfVqzx5gqLv2D8GY+A56bjHedU2SUBBIKWRZ56JKlE2BvUDq6EpjlFMjUUmEvz
         XWkZdL3e0nEAbrZri6BAqlNJLPmQrqz4RjLn/RELtW3/CBYjD/SZMrvpRWvUe9fHe8Zt
         oOZotQ0gbQmqNMTCOYdV6tRa0anGTqoS3Cjiii1WnbSsuCPQ08V93MXrpk8cMIsFNuO4
         NmuyUtrZUv+v55MM38NcS4b2p8hv/ctn5Uckocw8RdWWJomJvcvnriZSsR7aoC2TP+FR
         l65Eglzi6sjJAdBmZiGlVt/lbXMV+tsH+O1x7bqWXwFx1nXgLqAa/4/Tzic23mNeOx0K
         ev1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544017; x=1764148817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4vo3A+zEqT6r4yHEPPmlJtSIbXl0hcYVxsto02QGrA=;
        b=lxJFKJYL6AQVdC9l0EVQZtCRKg1U7xxLYzFxYL4G5GR7Ey+miEPnPGyov8Q6YpdTek
         MSGCcvKQIrnhev1bjLTw+heRrfJDzczDnZ8v9IpzVjphrenzryNtD9i1EsEO/s8JpPHv
         svMMVdm6JqLbKisKgtYn9ti7ym5rS1sbYFaaF/jPZHhAPIvYKgSiv1k1+PwbjvTwzhVy
         YoObegFbLAp8CMNA7iDtUFy442KU0KM2FJSEevtIpPF8LQgfsPmHhZ3ZW2SqgZlzqvDi
         aebhrmylG5hryNw+7kXAGTT8aqmVE0G5F7CjPBj4exEp8RiQhYOG9X0Ymonm8Cp3ebHU
         ZOrA==
X-Gm-Message-State: AOJu0Yyy2UI3fT2vRgvytFuUBS0xZAH0dGetkZz5pfO0yw8Koqyac8h2
	XRLm70LjADnweKpssTuzHVSA/Wsnnn121N7wOTzW+5vvznDrG3l8eC4XOPJYolMMCIIf3a5PJ2e
	g6onBk/fMycmZwdl3RDk53g8b3jLvvSlkIqCpRQohH+g9OwA5akhWgHokng==
X-Gm-Gg: ASbGncurJjcjcEHHY5rZ3Na5KwGDokxdEZVBbIZsUlMuN3cUinsOTi+cUNbr18HuaZd
	Q8Oz8/gaQZw2Y6IXZOB2h98d+QvkkvGBZoxHk6cZ2O9+Cmq3Rx7oSCd3HXUl2nWGnglKZKcXvUU
	JEiphDMe4BgaRHuw5kR8RwcdFiEs5OpzboY02njgrR6bpnlf9N9JjI6maAgo4A74luYAw04dXgM
	U6ypEyfEFyAbA+CAOaybHC2aBfYOQ021s8yVpxM7HSDLUkWb2FSdAoYbge4S0swugRF5hQZp2rm
	Lcu4/ZmOt7Hto4POuJRm1IfdzGaAwAubpu3OaVKTmQu4v8g6Lej5Rbn6dql2e1KseHeZdVPQNL5
	cRQEV0cg5ma3CObL29Cm6BhOq/F4roQ==
X-Received: by 2002:a05:600c:a05:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-4778fea881fmr187270425e9.34.1763544016820;
        Wed, 19 Nov 2025 01:20:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYNHoQb9TvPImOLwUq6zgeQEbx+Js8WQF4KWo8jQc7HHGmjv+JhCzbPRI24y5phGaKhkTJ7A==
X-Received: by 2002:a05:600c:a05:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-4778fea881fmr187269845e9.34.1763544016210;
        Wed, 19 Nov 2025 01:20:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9731a75sm38335635e9.2.2025.11.19.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:20:15 -0800 (PST)
Date: Wed, 19 Nov 2025 04:20:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251119041932-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-8-danielj@nvidia.com>
 <20251118135634-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118135634-mutt-send-email-mst@kernel.org>

On Tue, Nov 18, 2025 at 02:01:27PM -0500, Michael S. Tsirkin wrote:
> > +struct virtnet_ethtool_ff {
> > +	struct xarray rules;
> > +	int    num_rules;
> > +};

btw if you are using xarray you should include linux/xarray.h


