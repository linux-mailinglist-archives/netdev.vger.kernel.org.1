Return-Path: <netdev+bounces-139444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC49B2894
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 08:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED346B21166
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 07:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F318FDA9;
	Mon, 28 Oct 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwSYCtcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605951E517;
	Mon, 28 Oct 2024 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099842; cv=none; b=r8hepBaFUWSwKCTff3XqNZ8wPoidrgkooKmN3sMnhPPHvENZwvJGe+OwFg30d6IwQk5H2Ed+CDXRmGc4nmcEJTB61cNy67oiOtmr3mx67cHQ3dcWey0LO7l8dnsr1ftnAsoY0ZHjEczNLRBwZbosApHtC+x0+GBT9vzF7GZUzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099842; c=relaxed/simple;
	bh=8tuaFEHw3gd14bd6i5uZJEEY5FA/5gDCV4eRFXdy/dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn8b2FHbCej2ZSsPisMNxUPIvMIUhuV44phNpG76xx/vaw/+cTOk6kg0x9jiXPiwRahmp1rhJoJegAF6d5+gI4+Owmag3GAVCvHAx2nbO3hyaibfA9FmXR/9maxnif5A1cRH4keP373m4c9mGvolOjhYlc2zR8FqXUR9pvkozVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwSYCtcm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so2926071a91.1;
        Mon, 28 Oct 2024 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730099840; x=1730704640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+Lv0cqccltbLrN2cRosIlLw7fZjxncTIQzMOXjL94g=;
        b=TwSYCtcm48pXmRU+arOsA6E+fqs5Dxj4PvGqj0SVH+W0b8Mx4KrdpURxb2kwumzWR0
         HYBKZzYtHIcN/4d/6uS4r4EATU/xwEnq6wkzi4quZmNDcMQdvzZf/tPMT1oSL/Ejfl6M
         M6LVyYvCgyDO1XW/V412Q+qYjlTpkQ9Cf97IWvymW4fY/4Ne0xxQdLs9rSFTNzhZq6/F
         0qTIKeaqyMqQFbINxk5bPOkUezj2C4tV0KtB2dS7J5zblBGUVJltBPJ2jQoYzSQPokuT
         7RkjAzIeBxeANEcHCGSsZdNtFNq3x+9VXhp4Ed9HhpohKBeTxfrKx6kFnHDNPc08KzCw
         dGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730099840; x=1730704640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+Lv0cqccltbLrN2cRosIlLw7fZjxncTIQzMOXjL94g=;
        b=sLTEQ92Typ7tsQRv7NzzHyfKG8HuleaydhiQBpIEHkURiR6TKi03754lQFXMZ5QrwV
         di3BKTiAcwpx16ce7JcbNUBc5n+UYxPKkRDL1KU7il6uujDjpDkGHkCBW6UBC0Zr3FGN
         PVbwxTBObrvzFyNHmcWECPTFpZGr8vBuZvuouJBanjg5a+90MaPmXsNwptuJXma1zNIF
         hi6rbIqBHBvxhwqvdaFiR4/iYiSaNic+gcNw7SeRVlNazAl0RVvJ7ipSaHfzd8NCeT+q
         5yS9Ld9p3EV2SF1E3idz6cW79k22r56rNp6Uapbq0UpJitlzE2mCN0aRq0sMCr8yRRNN
         wxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCULq8uMrxomVIG1aJv9vsyeeXqgCBf6nQdgbXseOFm3o3+r7G51Y/+mh3c5EbSJSSlYs0i+B/6wqwue@vger.kernel.org, AJvYcCVFRsPICoTJKuc762p13OYWtwSF+d7ZdO0Y+O6yHSfGcN+tDvEgp0uJfK0yY99n45i5StMowIeW@vger.kernel.org, AJvYcCVeVE+FxNDQJCcS4DMn8Glg+etJLUcHrgqDVYvBRc10psnWkuYMK9wT5OVpUATcwMUDDt+PLskmGGtYVr9t@vger.kernel.org
X-Gm-Message-State: AOJu0YwS91V3DPS/NSjrLCU2o1mm2ikqjlu8tst/X3qsFLWIRYKr+8Vi
	vxwKnCTjM63vbyR5oFxtKNZj9TiKrBZlXT+9jJcBYVP7Nj6UKdVo
X-Google-Smtp-Source: AGHT+IHzWBoCJf/unr9JRCs10+RBX8U2VlT071YJUNmeAJD/FQLj2WyaOuVYdAuzuRY5sIOEG1ACqQ==
X-Received: by 2002:a17:90a:bcf:b0:2e2:effb:618b with SMTP id 98e67ed59e1d1-2e8f106f63cmr9468469a91.13.1730099839533;
        Mon, 28 Oct 2024 00:17:19 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e36a4860sm6374761a91.32.2024.10.28.00.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:17:19 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:16:54 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: net: Add support for Sophgo SG2044
 dwmac
Message-ID: <gcur4pgotkwp6nd557ftkvlzh5xv3shxvvl3ofictlie2hlxua@f4zxljrgzvke>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-3-inochiama@gmail.com>
 <4avwff7m4puralnaoh6pat62nzpovre2usqkmp3q4r4bk5ujjf@j3jzr4p74v4a>
 <mwlbdxw7yh5cqqi5mnbhelf4ihqihup4zkzppkxm7ggsb5itbb@mcbyevoat76d>
 <8eeb1f7c-3198-45ac-be9a-c3d4e5174f1f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eeb1f7c-3198-45ac-be9a-c3d4e5174f1f@kernel.org>

On Mon, Oct 28, 2024 at 08:06:25AM +0100, Krzysztof Kozlowski wrote:
> On 28/10/2024 00:32, Inochi Amaoto wrote:
> > On Sun, Oct 27, 2024 at 09:38:00PM +0100, Krzysztof Kozlowski wrote:
> >> On Fri, Oct 25, 2024 at 09:09:58AM +0800, Inochi Amaoto wrote:
> >>> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> >>> with some extra clock.
> >>>
> >>> Add necessary compatible string for this device.
> >>>
> >>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> >>> ---
> >>
> >> This should be squashed with a corrected previous patch 
> > 
> > Good, I will.
> > 
> >> (why do you need to select snps,dwmac-5.30a?), 
> > 
> > The is because the driver use the fallback versioned compatible 
> > string to set up some common arguments. (This is what the patch
> 
> Nope. Driver never relies on schema doing select. That's just incorrect.
> 

Yeah, I make a mistake on understanding you. For me, I just followed
what others do. But there is a comment before this select.

"""
Select every compatible, including the deprecated ones. This way, we
will be able to report a warning when we have that compatible, since
we will validate the node thanks to the select, but won't report it
as a valid value in the compatible property description
"""

By reading this, I think there may be some historical reason? Maybe
someone can explain this.

Regards,
Inochi

