Return-Path: <netdev+bounces-239895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07491C6DAC6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DC4F3A2627
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77F336EF6;
	Wed, 19 Nov 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIZmBk3C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR0IiBsg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE631336EDD
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543707; cv=none; b=aB0msTqZjsgB9UR7pxD6Yel12vod4kP+jR+Ktp8bt6WwoMVEWAJpwIfFcXvara1/npqnfNUYL3Hsl2JDOsRqp9+cRUui2nEH/cE+1JYMq7cw4YMS1xPJWQOag1jIPbUitJ1qff5D/8cE6lOwjQ40rwws4Q7TalVqqfoVLVqDADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543707; c=relaxed/simple;
	bh=vCiayDyXQMeSWQnZ0u5xg0l7ULoxebZX0NUwkzYWlSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaAExdD49iVapV+KR+6Iv+UXzzK9wmrJoiicMt2w/0K9zv5kBI7aLEYY1AJr/yFuUTrIUI3PVvKqhw4R5BiYuce4ue7lyWzqOSKNT0lT2hv4ns9BVcOlcK+3YxY9vo+cfjB8PlzELRjxbkF4HZmTC5Ry8hlUYDFKGDnRHnhlGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIZmBk3C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR0IiBsg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763543704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+iRB2oBivDIJuDbosHNcX/b7vuh1IFrDOEjoVs0d5Q=;
	b=cIZmBk3ChN1My7WoHTQD5b/BMVCCpaJyKeqEbB+lnCd9xl21ndx34GabsXvQxbYbA4yzwi
	1R0PeF/a5de+1p++q1njWVPWmrBjrthZWM8V6OQuIpudNkKdVwNqjBonPNGZVcinlFdlXr
	g7xVPi3ZAwGrllbQQaOiPB3cbo8qKt8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-OgFc9_fiPTWsKN_enB3v6w-1; Wed, 19 Nov 2025 04:15:03 -0500
X-MC-Unique: OgFc9_fiPTWsKN_enB3v6w-1
X-Mimecast-MFC-AGG-ID: OgFc9_fiPTWsKN_enB3v6w_1763543702
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b366a76ffso3386258f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763543702; x=1764148502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+iRB2oBivDIJuDbosHNcX/b7vuh1IFrDOEjoVs0d5Q=;
        b=LR0IiBsgYw4G3MyZRViI8f+0JYsuF81lxFwbBpWaPlVh7wYUOgChbp42hfQG1BuYAS
         BUC4Sey76znhhew7b1Jp5WZXgoB8dcZ3H9pKBtbD8FRvGtIgJrl5EANaSza0aP5mjHJj
         wUu122P7gQe/u/vM3omgqLDi+OHI4on3uOubJWcQtvRZg9hd6LhenKqwbk50Yuw26X/x
         FFhustCcZYApTPxPfEC4TjZsmKxnFwdWHb46gr6Gv8tfqT6ueu2FG8syUCC8rcsrcQXk
         iqM93L5JZoCUwFHvoa3LRUdLIOYNYlVXp+UdWHYpXNHohQrMqJEBCGY59co9c43nzXy0
         j8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543702; x=1764148502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+iRB2oBivDIJuDbosHNcX/b7vuh1IFrDOEjoVs0d5Q=;
        b=pWc70jypN9V0SWygmvoyIStztlwq0LeMImoROBsfQ61VuRN0DszSDcYlZebhqm5FN8
         9aYhIdbalEGGYNSLR64VjB+IwaiOUmFHsWHyd1FCuTmd4eRk0G8PvDvSPLxQb8h67LNg
         lVMoQCcodaoTWHCT7JiD4sInbSdJhLw0Fm5vq4s/xaTqLT+37x6FBsDmti10M4s6eFQb
         r0mI7rVQgRvCFx7EY2654I6Pw/JiS/O9I2sOno0DXy0CXvxgHVVyH+INg2dBLtFsGeLh
         1oAW3JvciUFw4RNPYCOBHCqGHM2KnCkEOPhoEsycYMyK+c91p6WBjOVat2bJON4Z3bUe
         rQow==
X-Gm-Message-State: AOJu0YzFoSgxKg8x8gf2iGQqkLJsGOZQO8CK/3KDJHC8CVqjPu2t1lGM
	vwlRijxbsspIaqjrW9LXW9puAAr/3EUaU3FA6TVW4Oe2vZGVYRpqKLKfzsEBPtwLklwuTGqUoRx
	T0WeKdcGV3bPAYQACakfX5681g/Keu0Q6dMAU1+058uqK+y4m09ZyMjYNsg==
X-Gm-Gg: ASbGncsIOcaMC8nBRo4TbvkmOflqMlxWtyrWbABH011jqu0WFPkjzLdCkMzT1dQu85m
	T9OVyR7gKPL05koRn4OarOvNjSDAGxTVQjgmM2VMp7iu4btjg5RYK3swO6NXrdLtmpfgTlRwXhR
	uX7pz+BnwWVKxkyTNI39XQSqpP/oTZrby3D++Qm6YXmB8m8E7BwrXC+mu2INJlGfYqZWJNZZm1V
	GaaAINb71NX0PHDOo/QWX8NcLY3QI4ZGDp/IaQm+dNrDPXI5bVJRQF2mvTH61vG7bhkZzyWcq3k
	NgF7OO+qoikckl7Uu0TouZBHx8gn+7U+oxbOdfDTJk4ytJZkO7XiatRwemQxhrmrHVxycNjvQZB
	yUBVZQy8xwVMLRZBFij8IT4omd3+n2Q==
X-Received: by 2002:a05:6000:1849:b0:429:f14a:9807 with SMTP id ffacd0b85a97d-42b5938aac0mr18791026f8f.40.1763543701701;
        Wed, 19 Nov 2025 01:15:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpSphKmrAY6KUvFodAB5O56XHMrPtkTG1jHwTLKCUo+5xF8M9q56JIE1Dwzj482I2IEdQ3tQ==
X-Received: by 2002:a05:6000:1849:b0:429:f14a:9807 with SMTP id ffacd0b85a97d-42b5938aac0mr18790983f8f.40.1763543701242;
        Wed, 19 Nov 2025 01:15:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae88sm36177558f8f.6.2025.11.19.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:15:00 -0800 (PST)
Date: Wed, 19 Nov 2025 04:14:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251119040931-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-12-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:39:01AM -0600, Daniel Jurgens wrote:
> @@ -7167,6 +7261,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
>  	case IPV6_USER_FLOW:
> +	case TCP_V4_FLOW:
> +	case TCP_V6_FLOW:
> +	case UDP_V4_FLOW:
> +	case UDP_V6_FLOW:
>  		return true;
>  	}
>  

it kinda looks like you are sending flow control rules to
the device ignoring what it reported as supported through
VIRTIO_NET_FF_SELECTOR_CAP

Is that right?

The spec does not say what happens in such a case.

Parav what is your take? is the implication that driver
must only send supported rules?

-- 
MST


