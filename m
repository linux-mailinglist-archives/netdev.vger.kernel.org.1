Return-Path: <netdev+bounces-254431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDcuGHdvemlI6QEAu9opvQ
	(envelope-from <netdev+bounces-254431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:20:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C22A86EB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82596302410C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD34D326D45;
	Wed, 28 Jan 2026 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8j92tum";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lgTPi3Wh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555A2EE617
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631603; cv=none; b=MYzj7ZmjC0N4PSxspJVa87gIiX1Ku4x52Lq0RY7I9O5KmAfIILoiIyqOKnDfAgU5ahnuJirN1KAErEwm2B0VXoSdGEejnhCwh59+H+gwLAELsqQwxUY2IMoqm4+dCZf3fAjgeuG0jxP6gVJqN2hcZEQDTZhW8PfsK/wIX9cc30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631603; c=relaxed/simple;
	bh=H8MOGYyVpy4spKBgCPB86YiyYdvqAE0R02Wh7I5HQXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPStRcIvYX2zlhnWMXxuWQD1xUeAkEWdx1C4nJscvvWdnQX4dOIifRamwsaTQ+WWX0Zu77aQPmHSwpGN3XYNGdP94bNk/Ocr1TO9TbYQr2h+ISlMUuX542o4VLcFinjw4tOrDsl24UhhttR0nNLyTUgt3gZC59zWJI3+NGakMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8j92tum; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lgTPi3Wh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769631601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Du6Lg6EMjGRVf9Alie1QVsUprTCTw9C8a2HYgbNcUXs=;
	b=O8j92tumgKbt7pz8TuAePVQkYIxnW91vFvnLYoQvAwEhCu66jXMAGwNQeWkHHrqymWtrCe
	xhXtWVtLgvSNqIwUc1BcV39UwnnXFw3hyfazcwhD+kocW1EAcBGBUGcUhzAC5Ibmdb0xt2
	oWQtjd9YCVrhfO6o44bwQGsyAqrwmA4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-tFfTqbaiODiloVVE7Vbk6w-1; Wed, 28 Jan 2026 15:19:59 -0500
X-MC-Unique: tFfTqbaiODiloVVE7Vbk6w-1
X-Mimecast-MFC-AGG-ID: tFfTqbaiODiloVVE7Vbk6w_1769631599
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432a9ef3d86so112734f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769631598; x=1770236398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Du6Lg6EMjGRVf9Alie1QVsUprTCTw9C8a2HYgbNcUXs=;
        b=lgTPi3WhvEed4SsE7z9Ldb6nVmenZ2Gv0s7t8pZfAYRbSM3Tccf3ei0Cv+ezIYvBc2
         oXpPLy/F3qOb/fLuIy8CCZk12PmuUS63crbWIAl/6OeJ0ATLnE6HGWO0P3G58OLeAfna
         zzqpLJxDIaTqgcGFzVS/YPWExE4/zGG5ju15Iy181pkjtAH9hijgdtdtamd+GbbJ/JmP
         dGUHDM2Aq+RWim8BauwovswWC17X4mh4RwX7WswXp7BhEi+OaviJyy8hBNtigYdAS7DJ
         Y7gNcn3CGo+F+ZU4fu/c+wQPh8315t9ZF5BiQu2INUGBwom1ALXxX9Qx8CDrgAV6QHtE
         Flug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769631598; x=1770236398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du6Lg6EMjGRVf9Alie1QVsUprTCTw9C8a2HYgbNcUXs=;
        b=Z/l3joFe1ZFl9hm+EFonNxm4UYnC6kHxym4CWkYcT9wdjktJEFhTtilixxSoUjvJ3c
         5d2YuPMfyscIbns/CZWPVSZHWggj8mjXDPlo9vlqxySGQ1OoUtOY0ZaUVQtMB3/Gg74x
         yVX511mVfW5MQN/rF6DOaZRbb8nEEIemSdZNQRygK7yjLvRQDLyFGNaaaXy3mBTLSN2J
         JX37E9lNeXU4piNu8AtncvE3vL4xvHAotyHIv8bdGPlc9o9zH5g+oPL6QbAIX62m765k
         yJJeO3pLorCWPfSD2r/62TsuXfW7kkwswj0OmB1SOnrMapyoKmqMxdzZjG6gJO1l++7x
         NMxw==
X-Forwarded-Encrypted: i=1; AJvYcCU6wyjO64M/ESeggwDeBxWHu9Ir1PPEqD1ZMwcISIeWZqaSpfnSDEwqJSPNzrXbIkH3PFxLCvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0OUGwAWPIW6lvqUndKidxUFwk/5URtnwd607pr6Sm+ZDXnyS
	QLrj6D9uaQf5P8tGyu1yY8b0Fvg5AO0oSDgjpc6UI0f3Aub/SvSXy5uUf7EASrz7rXeUT59CQd1
	//F3bhOPXrLq99Pq0zT1zzdg81d6SJBQU838vycHFJ7ghyccCvOB06V1Pog==
X-Gm-Gg: AZuq6aLvp9BNlwoQT9fLcQ9V8kNTpeDK5xIycaXnM9huC8bUTcf/qIT9Qi/gYF2vkRh
	Kc3VI+JYbXubVKwmebMLu6LLNGGKdGA1YLCpWVRylrG+HYNLhyLkZ862tefFlL282WH1RCo9JmL
	vCM2G9RcPsmlLOz3NwvN9sXgmn43+aWvfBYBx89R/FmYCkka8zLTpAy/ZMM5pnpFb7jVewep/JC
	ZjAh8xx5p9Wk+i0jfsCMZgFdg5cfYdd5+Eas0f+XfUrBLYlVu4WwhwTdYAv2FZkiSxbN0t1i4C0
	uVoD/B3TB6DNCVNan4naUO7B7QOyQuSDCupLALjECU1N4Fd8a0KCyElSkYbx1pTHhwZOqtN/gbx
	mLvPDgEyjb+uqeyEzgROEA+G8hpcc4oARDg==
X-Received: by 2002:a05:6000:2481:b0:431:a50:6e97 with SMTP id ffacd0b85a97d-435dd1bd8bbmr8045512f8f.34.1769631598592;
        Wed, 28 Jan 2026 12:19:58 -0800 (PST)
X-Received: by 2002:a05:6000:2481:b0:431:a50:6e97 with SMTP id ffacd0b85a97d-435dd1bd8bbmr8045486f8f.34.1769631598089;
        Wed, 28 Jan 2026 12:19:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm9728183f8f.38.2026.01.28.12.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:19:57 -0800 (PST)
Date: Wed, 28 Jan 2026 15:19:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_net: add page_pool support
Message-ID: <20260128151944-mutt-send-email-mst@kernel.org>
References: <20260106221924.123856-1-vishs@meta.com>
 <20260107032738-mutt-send-email-mst@kernel.org>
 <ecda097e-e3cc-47c4-aad3-61f6af950a71@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecda097e-e3cc-47c4-aad3-61f6af950a71@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254431-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4C22A86EB
X-Rspamd-Action: no action

On Wed, Jan 07, 2026 at 09:23:46PM -0800, Vishwanath Seshagiri wrote:
> On 1/7/26 12:28 AM, Michael S. Tsirkin wrote:
> > On Tue, Jan 06, 2026 at 02:19:22PM -0800, Vishwanath Seshagiri wrote:
> > > Introduce page_pool support in virtio_net driver in order to recycle
> > > pages in RX buffer allocation and avoid reallocating through the page
> > > allocator. This applies to mergeable and small buffer modes.
> > > 
> > > The patch has been tested using the included selftests and additional
> > > edge case scripts covering device unbind/bind cycles, rapid interface
> > > open/close, traffic during close, ethtool stress with feature toggling,
> > > close with pending refill work, and data integrity verification.
> > 
> > 
> > Yay! thanks for working on this!
> > Could you share perf data please?
> > After all, page pool is an optimization.
> 
> Thanks! I'll add benchmark numbers in v2 of the patch.

This never came, or did I miss it?

> Beyond performance, page pool support is pre requisite for enabling
> memory provider based zero copy implementations in virtio_net such as
> devmem TCP and io-uring ZCRX. These features require the driver to use
> page pools for buffer management. I'll update the cover letter to make
> this motivation clearer.
> 
> > 
> > 
> > > Vishwanath Seshagiri (2):
> > >    virtio_net: add page pool support for buffer allocation
> > >    selftests: virtio_net: add buffer circulation test
> > > 
> > >   drivers/net/virtio_net.c                      | 246 +++++++++++++++---
> > >   .../drivers/net/virtio_net/basic_features.sh  |  70 +++++
> > >   2 files changed, 275 insertions(+), 41 deletions(-)
> > > 
> > > -- 
> > > 2.47.3
> > 


