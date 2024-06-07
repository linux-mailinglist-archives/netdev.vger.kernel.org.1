Return-Path: <netdev+bounces-101862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C87900520
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E561528E73B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EC197A68;
	Fri,  7 Jun 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xXgKvdwz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7B194A7D
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767296; cv=none; b=licnpxxlFQORcL5QrN8vo2ngnlQU/g6Tp+jiYsvXrfLJq7KOHouhNZS2LSt7jYBvBdvKSqwXxlIcimpQvSrVKiA3G9TdKcnAvyK9+OZ5f7laVVP6LXtZnoKj2ektbVwM7Oca6wNZKh59PGPl/c23hJFAoLwbygvq85qii1HYeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767296; c=relaxed/simple;
	bh=bNufWv8vnNTuzQBP8B1FhHjZF16KL0qL0xXs56Trvbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nApcXNIC8r1HPeZtG/FcJcGAXqya7Rf7FeeP8pvaLXNNorck6U6/DC3G313IzIU0E8YKXhsvug8inkAkPuIg6oYTpm4RxJehW+FPBUJtu2o45XQdbPNWYV5yrdeEm+Pob4k8azEUoD1NqcLnvO8ZzqHTztXJ3NSA171xt70qfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xXgKvdwz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42163fed884so10675425e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717767292; x=1718372092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDmNba19JEmqtuQ0a43R5+Iq4qr0QF4IDUZLXDfPhcQ=;
        b=xXgKvdwzdZSoeiR2KDfaYRUnfdMnqnOBtYTG6iHMYcEXG3/7a5lcaMAlmY2Cv9WMVS
         rGDpxSG2JeCv4JlRNIVzdLAgt7b2S7pEjn5bsTzzRJBTjXZpQ6mP5QwNWGjBOsMoYJRp
         hfGmA2LDtV6p925d3o4sAoaHuHLWgzfeXmjHUpJZDK9qjuvslNfLEq+dS88bKIr8aCE7
         5y0Z2eI9GxuDWOZoFWTIUfR4fHxoaOoZ6rRZlvP/vts4g8gbrfDllSXYZP8bMjzI43d1
         ZP/u6ctKk4dLzkgLn8Kc1DHIzfEORe9MgtOvM+IvhG8/d+pYw3vPgDOc/MO4LLZAsphv
         7XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767292; x=1718372092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDmNba19JEmqtuQ0a43R5+Iq4qr0QF4IDUZLXDfPhcQ=;
        b=bWNG2IWmN2qyXkoabpVARg589FN2boLSGFbP6o/9dGYcR2FbP4u/fOo4J7Zna5HAEk
         NRUutH3EMMrF7MiXtsEY6EaIi5F93HvNdHjC50K6XvdetzgR6VRCXOGNtrmQcmrW4W6K
         aGLfxHtxZ21erju2NTpXHmlgvc3GPP4EuyIr3Xic9ufJtplZsbZxAxvWoyFPZJSj+c6y
         Y6IqsWmagBOAMFEIKNyjUeBs3724vTD6Oq7ACwGp35vLfh0UkXP2J6IZNHrg+0fsAEUT
         Q/b5YMF8CUY0Sr4WmNQ5Ruwmf872yMnQ3fnrQm2GH8a5/9vrcylBre07CPtt1kRvE9Ri
         gVLw==
X-Forwarded-Encrypted: i=1; AJvYcCViGTAy3PMd4anZeR/gFeZWatQtwtz0lhJmlzjqzOunU94DOO0gE0u5ZVsicYgv5CerFc9d0xQhVhemcrJM30E4NpArluta
X-Gm-Message-State: AOJu0YwKnGZYZEvztOXnARmNJxgAYOC7C2nKvIap/DGoheKybD6h4q59
	AZRSQyp0oZJsjGPv9MUzOlLYqgOf08J0OwLvLktV1UuUnbgj6SpE5GTH7wUtaVY=
X-Google-Smtp-Source: AGHT+IHi1tHwQBfhV0uUWQFN3GhXIlVN/ECNJD2wDBwLl5ZAgAGIlbEAl/M8FEogX3A94+YwaHC0KQ==
X-Received: by 2002:a05:600c:4f44:b0:421:205f:52de with SMTP id 5b1f17b1804b1-42164a32853mr21506065e9.26.1717767292321;
        Fri, 07 Jun 2024 06:34:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe37csm88361985e9.3.2024.06.07.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:34:51 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:34:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <ZmMMeIuplzZl2Iyh@nanopsycho.orion>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org>
 <ZmK3-rkibH8j4ZwM@nanopsycho.orion>
 <b023413e-d6e1-4a47-bdf2-98cc57a2e0ae@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b023413e-d6e1-4a47-bdf2-98cc57a2e0ae@lunn.ch>

Fri, Jun 07, 2024 at 02:49:19PM CEST, andrew@lunn.ch wrote:
>> >This API gives user space SDKs a trivial way of implementing all
>> >switching, routing, filtering, QoS offloads etc.
>> >An argument can be made that given somewhat mixed switchdev experience
>> 
>> Can you elaborabe a bit more what you mean by "mixed switchdev
>> experience" please?
>
>I don't want to put words in Jakubs mouth but, in my opinion,
>switchdev has been great for SoHo switches. We have over 100
>supported, mostly implemented by the community, but some vendors also
>supporting their own hardware.
>
>We have two enterprise switch families supported, each by its own
>vendor. And we have one TOR switch family supported by the vendor.
>
>So i would say switchdev has worked out great for SoHo, but kernel
>bypass is still the norm for most things bigger than SoHo.
>
>Why? My guess is, the products with a SoHo switch is not actually a
>switch. It is a wifi box, with a switch. It is a cable modem, with a
>switch. It is an inflight entertainment system, with a switch, etc.
>It is much easier to build such multi-purpose systems when everything
>is nicely integrated into the kernel, you don't have to fight with
>multiple vendors supplying SDKs which only work on a disjoint set of
>kernels, etc.
>
>For bigger, single purpose devices, it is just a switch, there is less
>inconvenience of using just one vendor SDK, on top of the vendor
>proscribed kernel.

I'm aware of what you wrote and undertand it. I just thought Jakub's
mixed experience is about the APIs more than the politics behind vedors
adoptation process..


>
>	Andrew
>

