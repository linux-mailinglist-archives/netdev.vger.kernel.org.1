Return-Path: <netdev+bounces-173411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F5A58B30
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 05:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8C8166580
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 04:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6041BC073;
	Mon, 10 Mar 2025 04:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij7J4rCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29735976;
	Mon, 10 Mar 2025 04:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741580661; cv=none; b=PWNvHRDPDYb0xwfrIyjM/6qegoujb2dbOA8Q9vq+dsgskUSGttduojyOIG19ufNiMn9v+TNE53KrfHaV3B/7SMl5BmhHruXiJZV7fNBx4vP9Dd9N+AuLCLVTZNh9EGBGc3Dsp+n8B1z0N0Q/K2f4hHQApHv70gXdowLhz+kPjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741580661; c=relaxed/simple;
	bh=jpU86pkBhtmDVDFVaA7jCQ8Jvz/mFXJ/l+BRat8AQ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4CyyOE2XRSkWKskaOn3VgYLKSrvMhb4MR5swv3BffSYh98zRAIyc+hQdoEf4FesvgMJla/kfCguNTC0rnCUfyD3qhcph7upSY0KhNDiFni43wJJA4iTrlppzobZ50g0ekT4ix4IwjU98yupc0UVBapZseRbXJ0Z7bimwvlCl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij7J4rCo; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c554d7dc2aso71611785a.3;
        Sun, 09 Mar 2025 21:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741580659; x=1742185459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLR4GYl4C3Y+wOWYOwtCtosLZeJRF1LxY+mVHw8wlLg=;
        b=Ij7J4rCocSShFSWCVGSPhGy/QuSrHidBaI+M/UKAm4b1z5zU4t4OYHFGWfVlYJCev4
         g+GBhj7wJCfntxmYVQKYLh/eDrh78fmzthOj0WBDHYiRtfDeUIuuZ9sXXcxSH1gItKn3
         AHiq2XjRYizlVq8uAZWAVzqgl378dplnBSK9KmM4tZg5zqa4fg/OwGzRjtPde2xIvG7n
         DFIkcaazUZKs17wW4hfW1bYGgpFI4GGwNGPaB2yzc/vI5Lmv5xl5c+aahikYyTRd6vl9
         uvvENVBVbCkpEqr7Cz3rPFBw4iO4zZfNgCTfcRIjxLfh+p7uKYKnSINCaMfZMmQLul+0
         0HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741580659; x=1742185459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLR4GYl4C3Y+wOWYOwtCtosLZeJRF1LxY+mVHw8wlLg=;
        b=nvpiR2S30+4+EHKh78qNoDPKBxG0j+zOyNMzZg7oou8i6pg0l/Wj7QBvjM/JKU+0KS
         FrvASHsP9NAsnSGHCa2HXdUw2+KzeDs8GUq3RVnpBgApibAPUoo+J0SRR6jW14mUakIE
         fIDKatf7EYRgbSA0aVkY6QBvh3kgkh+0ARLvBMbN+RXfdtOoKfmu6NLxNnp0vedNXuD5
         LzWCbiueVyuJhKb/AoI3w/J7yQuPXfGJtH9gCP/orWX9YO96rVpIgYCvtzN0EYpAM2r9
         YAL3O4Kn9AeyxjSa4JZj0wVbvv3Xw6AXR02sxHrQRTuPb6L/6baIiHpsRyDxX+o0WGqd
         Jo1g==
X-Forwarded-Encrypted: i=1; AJvYcCW5CR9urMXOpkNh9k/LjgN5GVEEr2yux+86ssjC4eCdUD3uc7pB3e9rkfY2P7AEDFchG3xEBmHa@vger.kernel.org, AJvYcCWBdAXuucwt9nhbcnhZV+N+lqFwXJfdTESk+zOh+734g36jB5P4obI/lbruCkcScBQvJbrFJLaTvKtXXGfM@vger.kernel.org, AJvYcCXaMwni7Cg9c0SVqkBf/EmW07q7qRI7f7nFWupytgcajjQgTZ7lOMJzPUt70oXYdpr4ZY4vr+3NdFuN@vger.kernel.org
X-Gm-Message-State: AOJu0YwMizjWXb/Ow1nARLFZ4SXP3T7YnJz19/OsP2SZPNDoqORPF/R5
	+vXaBVuSqqNs8/AvcUoU6g6QqEM1a4JRInMh62gc8I9oAVDeEZ4k
X-Gm-Gg: ASbGnctoa8HzdQ9lYw+XoShkGZfznObMRfvp74Op9j3I8Iui2hxmzHwbP4/Lx8D86Kb
	6Ytc/WJEdyfT3bOgOJzobuG9vVbUAJ2zbLUv2mOAj8NCpwxrgIUrSaJNMdcWJ9IDGpTqUhjtRm6
	mA3nLX1xWUyWMB6wW6BjF0blN5QelB4O2TCCDrkiQHP9LB9s4SzftoqG0V2aUcv8K0Ct55/SGIS
	WV9GWL4JfocmcJjavNmJRgiEjfj5x5YJs0mYYnCAOoTpiwsoPcTa0olSl6reZGL42j5cBcQvYDF
	MeYhJJJYAz0H48Ow3524
X-Google-Smtp-Source: AGHT+IFsDYZoGNLIvaPkQwDrN6zTxprNZQsviyohgK7rizxV8r0HlGSZdidW+iOJcbIbr0KSYUqg0w==
X-Received: by 2002:a05:620a:1b85:b0:7c5:4b24:468d with SMTP id af79cd13be357-7c54b244796mr538035285a.2.1741580659215;
        Sun, 09 Mar 2025 21:24:19 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5550be065sm107353385a.63.2025.03.09.21.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 21:24:18 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:24:12 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Richard Cochran <richardcochran@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 0/2] clk: sophgo: add SG2044 clock controller support
Message-ID: <q5776ely5iwzv7uqz52fbzqybujnjfmhe7ujdj6kwqdj5wgaqe@pkkyuptjkmln>
References: <20250226232320.93791-1-inochiama@gmail.com>
 <174157953239.287836.12496608762621997429.b4-ty@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174157953239.287836.12496608762621997429.b4-ty@gmail.com>

On Mon, Mar 10, 2025 at 12:08:32PM +0800, Inochi Amaoto wrote:
> On Thu, 27 Feb 2025 07:23:17 +0800, Inochi Amaoto wrote:
> > The clock controller of SG2044 provides multiple clocks for various
> > IPs on the SoC, including PLL, mux, div and gates. As the PLL and
> > div have obvious changed and do not fit the framework of SG2042,
> > a new implement is provided to handle these.
> > 
> > Changed from v2:
> > 1. Applied Chen Wang' tag
> > 2. patch 2: fix author mail infomation
> > 
> > [...]
> 
> Applied to for-next, thanks!
> 
> [1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
>       https://github.com/sophgo/linux/commit/0332ae22ce09ce64f5e54fc2a24ed22073dbeb9d
> [2/2] clk: sophgo: Add clock controller support for SG2044 SoC
>       https://github.com/sophgo/linux/commit/fcee6f2173e7f7fb39f35899faea282fd9b5ea30
> 
> Thanks,
> Inochi
> 

Please ignore this mail, this point to a wrong url.

Regards,
Inochi

