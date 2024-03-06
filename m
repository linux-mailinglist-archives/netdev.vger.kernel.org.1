Return-Path: <netdev+bounces-78186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635B8744A2
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1B21F29675
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F11D554;
	Wed,  6 Mar 2024 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmSbYH6f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469221D529
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768572; cv=none; b=ePBCttGGmBUIQrlb2LWJakWKhwvtOhXfX51X7CLwQUifWcpCUjBO5BSgL3i8susUcdaILYzyBdxwCUEMIcgwl88oFDo/XiZJnlRCS48SPwohLDUEWIs6PxZuWSQs8oBmw8ZkdPkiu5B7gJ2DBxky+dH4HIEB8NKc2qRLct7Y69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768572; c=relaxed/simple;
	bh=1uAjtmVUg8TOo5XCruda8HusbcghSINaRVyMFyYA2J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnNGUnp8xB4+b2SWME2jrU6V6otJ9+Hbc462zQpHPd6+TbhBySTmVuc4qszyVwPZssC8KyBJHNLjQQNsJu6M85C8u1fMSDDKCow/TLlLdCsGxtyasgnqiTN5J7dozZlZv2eBxVoDV8rpaFUynoHK+YXGwtPlp2DLpRh7UPj4Ukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FmSbYH6f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so2314415ad.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709768570; x=1710373370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXRCoET8aNW/39aRLX1D1ZOWhLKJAW+cDfFuNbY9XEo=;
        b=FmSbYH6fycrBViC7DCGpYBQTBNKeiLm5BFgumllN9wfDs9gtX8DjA+H2k+7xsw3uZh
         dVDfu9e02ZMkLJebbKwQGddns31OuD4WcmFXqqLYzox4ntB6UaHyv9djld8SEyOQScJr
         /jvP+RRIS4GVngcdsgUr5JwcyrGtNEeWI8B9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768570; x=1710373370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXRCoET8aNW/39aRLX1D1ZOWhLKJAW+cDfFuNbY9XEo=;
        b=p5D+lqYlYA4ZqVn/kAwTOlFUMqfhs1G7Tk1nlAH+gA5YriaaNCL/hZEeGbQyrO90tx
         Sdt1k2Y1zYlcpcMdyAY4ggXBdlO6Y79bd70jaxcb8BbubPk8DildvsJoU61lUOHBNA3b
         TJMvy6Eovet1q2DrvwsOEVwFPdddrc6xmWgVqFvn89hNjP9yQF758nmzEURc1UYqrcWT
         lGbClHiOYLU7Vt/DaqyRYonSVs13KjVH5L0ZYueIQ1R2TbDWvELq0M/aNGYMvm4O5MGP
         Q2ARznpXUgQHRjQhhj/D0bG1XzX0ewG8ekWWLmLOdvZksVD67AzgSzrbOYLs0tMadrX6
         9MTw==
X-Forwarded-Encrypted: i=1; AJvYcCWYm2u+ar1lUN2sB1YP9JMIw/nHfB/hVwQQiR1cVXvG9EY9XVuWYMYD8ZTjITI9tQOLk1awYJYRAxJtLidodOtmGWy2rVh9
X-Gm-Message-State: AOJu0YyVy+Vtv0les0HHklLSzuqRt1yvHIQQac/IdLPoN7RwZofivZac
	QzHpyeIUQjJYhgPX9nuN/APuFcgF5zbiLYllBWPadO0U2aD1uH+UAXn2g/Qubw==
X-Google-Smtp-Source: AGHT+IHADupVs6FRdhDggj0sTct4wDHOWb2w2b9Auv5+VfZEeMw6HDOu57s1NGT+WKYASYmgqSVHgw==
X-Received: by 2002:a17:903:11c3:b0:1dc:d8de:5664 with SMTP id q3-20020a17090311c300b001dcd8de5664mr7564197plh.33.1709768570588;
        Wed, 06 Mar 2024 15:42:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b001dd0d090954sm7330904ple.269.2024.03.06.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:42:49 -0800 (PST)
Date: Wed, 6 Mar 2024 15:42:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Coco Li <lixiaoyan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <202403061540.A8462E9@keescook>
References: <20240229213018.work.556-kees@kernel.org>
 <20240229225910.79e224cf@kernel.org>
 <ZehsoPb/WZzUcFHa@gmail.com>
 <20240306070658.4216fdf2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306070658.4216fdf2@kernel.org>

On Wed, Mar 06, 2024 at 07:06:58AM -0800, Jakub Kicinski wrote:
> On Wed, 6 Mar 2024 05:16:16 -0800 Breno Leitao wrote:
> > I've been looking at some of these embedders as reported by Kees[1], and
> > most of them are for dummy interfaces. I.e, they are basically used for
> > schedule NAPI poll.
> > 
> > From that list[1], most of the driver matches with:
> > 
> > 	# git grep init_dummy_netdev
> > 
> > That said, do you think it is still worth cleaning up embedders for
> > dummy net_devices?
> > 
> > [1] https://lore.kernel.org/all/202402281554.C1CEEF744@keescook/
> 
> Yes, I think so.
> Kees, did you plan to send a v2? Otherwise I can put the cleanup on our
> "public ToDo" list :)

I found the requested collateral changes that popped out of v1 to be
rather a bit much for me to tackle right now, so I think adding to the
TODO list is probably best. :)

-Kees

-- 
Kees Cook

