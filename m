Return-Path: <netdev+bounces-204500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73FAFAE9A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5673BC6E1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75728A72A;
	Mon,  7 Jul 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X+hjSDWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADA220F2C
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876893; cv=none; b=KTjO3n1IMZaOy8IY8nmyI0WP5e8JwdqXQpOW+xnm3PDuZ+N8Bb2GqKkRR8a6KgV1FwtYofsHw+3rV/RzGfVENr4D0RnZIw9yQPrwNjeGVPPwn3/UkkPIKpeIUdbT/TurMEVdtX6Ap8FRcl2zo/0aAksFlICZiXhandpmBqASurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876893; c=relaxed/simple;
	bh=7q4L0/HVt7fqu+vGAxu0KRh4POklcFmSqn8hzOULv3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l697u5IoZMyp5p2MAuO7s9dNdTzPryDjZJVuV2+sR6nWG2fyDnMT2Qzeb/9NOunUsg/7VtS1ud5LoM3yKvCyk999m+uZioHI1+FAA1JFVmTXCK+mpw/9Apkd1JG6KgOUWva9AxkQXCSSeyLbo58a/6/kxXiW1NyJtQDF4iFquXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X+hjSDWi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453066fad06so18943995e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751876890; x=1752481690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7q4L0/HVt7fqu+vGAxu0KRh4POklcFmSqn8hzOULv3c=;
        b=X+hjSDWiZ+GRfcVDEgfAmeViHpPZ14WWogfUPTLsEfDaANxl4b0pnkiRneJ51PIcr5
         pav/0Juj8mmn8Y6QzBm44w3dGAO8ZSlNFUUdA936kaokxAAjW5iBWehLYm+E1d2iG6rH
         eTjCmFQmFxvhkUZlb7H5Ub5cZVWpyh5JUtyVCDW0+QRDXNMLHYBi+7v5OrWai5HGAFPD
         42mKyRpbSzQJbMoazfBXbH4iTxYw4mgBvAlx2OuqmL9K1FtKLEVyQ7RceUTLULdmzLX6
         wuk/uAOpdf3LbeJmVTsztKtUeLDfRPH/8HaKq0UxukS0qmk9QRkXc1Zs6cZprKI6UfWd
         d3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751876890; x=1752481690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q4L0/HVt7fqu+vGAxu0KRh4POklcFmSqn8hzOULv3c=;
        b=PEoC4MFZPsnT/q1iXUw0hBKEXUEPgqjKK2GAXAAkxvBhL1bGHD1ROTVRSbb4YBvUsN
         cC+o6LoinI17IFwLEahGXz6AUXq650p3r+9ezb1kCkOSQa8x033QIKPAP82Y3zQLwt3G
         OWfEDehugPUTUsAb66Ua1/HKFyjAqKVkvcWbuZcVYvYfjeCOnE7QJZi+bhSgkNFBn0Sh
         i+nBQvGmjwaBBc34Bt2zPXmhKJzwGwZw9AYxccaBbVkUThUSBI2fkippkpmiib5ysTSI
         HC81S+o0ep7+LhHA80CjQH13ikULDg0KgTT7cimLfZ7p7rWZEkP0kfT6+Lpov8ZzDkbw
         0Urg==
X-Gm-Message-State: AOJu0YxvQmjnSohUyY59GrnOGnDWa9XfVsLD6/gqh0Z24oKk+s8cNz0G
	vWxiDNqz9yzPXl8aR53hd+MaRLYUX1Cmcrbqa4UBXde4CQYNxe5bSUN4efE0ZGppVZI=
X-Gm-Gg: ASbGncsQ/ZnIyibTsCVtZacOtz+k0jsQay/Bh54O9YZk4NhxUL9ifir5SiFIHg/tgZV
	OyDIDzCH/Sf2dNJYLEsuuqkdcUG8ta70DJRynoAjUZRBQnq4f5PlKFA/5rStPcPhP81ZFeptSSM
	xNwmTobcs1iu7OkuV/wpaO4TgnX/CHwwYD7+ef81S1b62/74BZqtlTQKO9nTzSkrr2JbjD7AIT8
	uQ+sGjf9vV1keEeLQV5Pv8Cjt/VaBIVvGekfailVqTdUzu8E6ti3/QvRPBpyC8w1CiAn3qia5wJ
	xDmt3Ms/NbDLLdkiAkBE1rLqBGB62UYvgml/fCyLXHT7PKsq+/lJYkxq+q8miPs=
X-Google-Smtp-Source: AGHT+IFRfk+w0/Ow65OxKmSEQVTq3eVHdoVGjVC18oPqGtD6akAxTK4V4xmuLbMUl30D3BToFnGUlA==
X-Received: by 2002:a05:600c:b86:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-454bb7e7ac7mr65694205e9.7.1751876889784;
        Mon, 07 Jul 2025 01:28:09 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b96726sm9620536f8f.58.2025.07.07.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:28:09 -0700 (PDT)
Date: Mon, 7 Jul 2025 10:28:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v13 00/12] Add Microchip ZL3073x support (part 1)
Message-ID: <cdvecjk7sz66hnoue32nlhwlbghyqkc7rk4ri2me2oioty6aiv@nf7v2bjj63h5>
References: <20250704182202.1641943-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704182202.1641943-1-ivecera@redhat.com>

Fri, Jul 04, 2025 at 08:21:50PM +0200, ivecera@redhat.com wrote:
>Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
>provides DPLL and PTP functionality. This series bring first part
>that adds the core functionality and basic DPLL support.
>
>The next part of the series will bring additional DPLL functionality
>like eSync support, phase offset and frequency offset reporting and
>phase adjustments.
>
>Testing was done by myself and by Prathosh Satish on Microchip EDS2
>development board with ZL30732 DPLL chip connected over I2C bus.
>
>---
>Changelog:
>v13:
>* added support for u64 devlink parameters
>* added support for generic devlink parameter 'clock_id'

When do you plan to add the code which gets the clock_id from the
devicetree? I'm asking as I believe that should be the default.
getrandom/param_set is fallback.

