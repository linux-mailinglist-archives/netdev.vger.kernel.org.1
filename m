Return-Path: <netdev+bounces-121468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF895D48B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EB0B211AC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87232190055;
	Fri, 23 Aug 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I4aMV6gL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D518660B
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434886; cv=none; b=rYSudb9g1gFOgBUmP/krJUpVtgJPkz4ApoZs2GmE0VKuTjHsS+6wXG/JYR5IxuaLV1fGuOZ1Zi7k+pYO31R6qW+VGfF8waktmmEQgrVFpfIUhsL5Y1gOmmqXPZFvV9KUyIiLNsPmC24r+2UKWVPArVNxUAvmmbAaq9SyCr8dDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434886; c=relaxed/simple;
	bh=lIqkNIyNJyLgbcbvh21dnMmtgzdcZolNai3S1f6KvHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y80oImD28OJ1Tny9LsFuyy57lpi8RI8EURupgZ4G80FYNX1rKKBeOow9GOXmldH6r4lYFxSRvS7PjzdJfflG4hqEwgImgO87NaChJKDaEq3TtQLHBQQ0c6iruqEJSJbSXdl/d9RlimuErf/rLpgJ98l0PgB8TjzNaAu4ptKXP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I4aMV6gL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7163489149eso1349867a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724434884; x=1725039684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xtMVN+vRroxBFlgqNQCI3vvJiuqktRgAN5GJPHFAoM=;
        b=I4aMV6gLsiHkpKRpoq6jJbAe23SEkKeYc4hQwZ0yfUvP0Q1+XMxs/eEYXfTx+X3R+x
         mZJQTPdoRbI4SUdM7qCudz++7Xr9k1Ae9kBhOllGWR50NfylV2+04WQ/afUTpkYUmTGw
         cnZHSDIByg0guzUyWD+Z7Mplz8SUnJJnCo7y/9iV+u+H2wHTsdc+y/DUH+GfVZofBRaq
         lTLi20RxpBgBwEA4SGXDW4g1pI+Yw79++jQPFd8gkO1psUo5Csy4hH7020vvt7+aHRll
         +QuSyM7mG6sl1UDlE1K1p7MWdFlpbIy6JVV/JlgTjmwGgSjx3VYGjnOx8EiszqTT1I1F
         VwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434884; x=1725039684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xtMVN+vRroxBFlgqNQCI3vvJiuqktRgAN5GJPHFAoM=;
        b=c3UtsnEX9DonrKFwxVQ/77RQ/pWi028i/2aUD4/vKKTiA3CZRYDKrf0UZGhpjSQhCI
         vQGbheT5cCAY5+FZHHYg+TtVG8KIwN5ZovT1SaG6TWkAFV33StDwGzkkmBD8731z3GZ0
         YMQ/JzMMSYiNKCYnXPAZWqx0PUB/jPj6IKYiELWLgfj4RChy8Mvwz7seReeb1EgRClhe
         2KB0Q4fGBEqg09BLw2C0HyGr+CLy6EnmItt0t4BSSR36N7d/oCukBPCVBMw70xINvL82
         O0/kaF39kEGQe203sdn+ryILstLFmaohTLka8MGNbm0pEQlCCzdD9iRawNSZM/EAQ5n5
         W0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ7tz+SFopqTe7gNjGDAa3e+uh5/uHjkHHrjQkxQsX86vddNVhL00QKu0m7KdYcx9AYHzLc28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fZqZyeNXLNwnp61Jbj8Dt5Y94JegoU4PGpAiPUP9+VO2v6b/
	SokbnadV4JhZvOlxBfFE/E9uUMWf5IlM4g4jaxg3bhe9MlTJBA563RNzbeEazZE=
X-Google-Smtp-Source: AGHT+IF/90uc4CLcrgkR1xHgH2zkjOIkO2gZUVdIAEPQtVESEiRy6dgBgU69xQL/RbltWK9J4jWZOw==
X-Received: by 2002:a05:6a20:c887:b0:1c3:b1b3:75cf with SMTP id adf61e73a8af0-1cc8b47df27mr3061748637.14.1724434883829;
        Fri, 23 Aug 2024 10:41:23 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-714342e0a61sm3287219b3a.134.2024.08.23.10.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:41:23 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:41:21 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Drori <shayd@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Added cond_resched() to crdump collection
Message-ID: <ZsjJwcKAaKRyEHuU@ceto>
References: <20240819214259.38259-1-mkhalfella@purestorage.com>
 <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>
 <ZsUYRRaKLmM5S5K9@apollo.purestorage.com>
 <ea86913b-8fbd-4134-9ee1-c8754aac0218@nvidia.com>
 <Zsdwe0lAl9xldLHK@apollo.purestorage.com>
 <1d9d555f-33b7-4d95-8fbd-87709386583c@intel.com>
 <5fc5d450-b77f-40eb-b15d-33939719a124@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc5d450-b77f-40eb-b15d-33939719a124@nvidia.com>

On 2024-08-23 08:16:32 +0300, Moshe Shemesh wrote:
> 
> 
> On 8/23/2024 7:08 AM, Przemek Kitszel wrote:
> > 
> > On 8/22/24 19:08, Mohamed Khalfella wrote:
> >> On 2024-08-22 09:40:21 +0300, Moshe Shemesh wrote:
> >>>
> >>>
> >>> On 8/21/2024 1:27 AM, Mohamed Khalfella wrote:
> >>>>
> >>>> On 2024-08-20 12:09:37 +0200, Przemek Kitszel wrote:
> >>>>> On 8/19/24 23:42, Mohamed Khalfella wrote:
> > 
> > 
> >>>>
> >>>> Putting a cond_resched() every 16 register reads, similar to
> >>>> mlx5_vsc_wait_on_flag(), should be okay. With the numbers above, this
> >>>> will result in cond_resched() every ~0.56ms, which is okay IMO.
> >>>
> >>> Sorry for the late response, I just got back from vacation.
> >>> All your measures looks right.
> >>> crdump is the devlink health dump of mlx5 FW fatal health reporter.
> >>> In the common case since auto-dump and auto-recover are default for this
> >>> health reporter, the crdump will be collected on fatal error of the mlx5
> >>> device and the recovery flow waits for it and run right after crdump
> >>> finished.
> >>> I agree with adding cond_resched(), but I would reduce the frequency,
> >>> like once in 1024 iterations of register read.
> >>> mlx5_vsc_wait_on_flag() is a bit different case as the usleep there is
> >>> after 16 retries waiting for the value to change.
> >>> Thanks.
> >>
> >> Thanks for taking a look. Once in every 1024 iterations approximately
> >> translates to 35284.4ns * 1024 ~= 36.1ms, which is relatively long time
> >> IMO. How about any power-of-two <= 128 (~4.51ms)?
> 
> OK
> > 
> > Such tune-up would matter for interactive use of the machine with very
> > little cores, is that the case? Otherwise I see no point [to make it
> > overall a little slower, as that is the tradeoff].
> 
> Yes, as I see it, the point here is host with very few cores.

It should make a difference for systems with few cores. Add to that the
numbers above is what I was able to get from the lab. It has been seen
in the field that collecting crdump takes more than 5 seconds causing
issues. If this makes sense I will submit v2 with the updated commit
message and cond_resched() every 128 iterations of register read.

