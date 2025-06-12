Return-Path: <netdev+bounces-196975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FADBAD735E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B99C162234
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38E22157F;
	Thu, 12 Jun 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="r08Pb8at"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC718952C
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737575; cv=none; b=Jz4G2ArhujCTf/soxvKbJTdcgNlzrh2YxugO7VK0oQyksxLupjkPqOOXL6HtSCGGl+a93OF87MCaoNV6tsFgySoh7my9kGgA64VHLJCddRm1eqm6fmylS02J4XmudrYal05/DRQ8zTUCaGFHcTe0Kkclca994ATsqhsfFCyK1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737575; c=relaxed/simple;
	bh=LZbMld6BzHGILlIgf66HaC3NP9UK6TgOAVrYfhtRoh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk3rgA8D5Io5M2HisVRKviDUSF+n/MDPxRKgbBz0kQ3zUxPEADxMv4/GIr6oT0H2TF1JO8cirdSip12uRQh3OOBC5WN+h0cxKbFplsPmZBU+cRl/KVGmYdHacChPvD2yExxwGaTfvbZqBB1tiZvpfBMYvFWda3NETPBnexCLuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=r08Pb8at; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1574704f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749737572; x=1750342372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+m7vYBsU85tLjESg73MFdmLBCg20+wdtbP1Z8Mu9gw=;
        b=r08Pb8at6TMubRhspo20s87DkBBMJqfSpJQ7KF8oaYst2wmc//XZzWWbc+cq9AUPC1
         7XczUL9FMl+XytepYgwSJWBlZ6Kxzmsf+gYLXldQJX54BmULpuzTcdXBlgoH0JXwpKzy
         MXtPYg+x1aG2l+G6wkQpvboIMRK+pvP5prusYp+XiLhEsVKeljFIgnTUdlB2E+pzwAh7
         WnMl8VGtJP31K518n6Pxo2DxVxZPFvGZHFeD2JHY+3sU9ptVNDxDOF+5+Gg1vO+3Ei3A
         uWrWuthUdOEqAvKx8iEciBbaCfxN2H/YNlZ2pR21csKDxJTgwXMGHkvs1NdIzrMwUddk
         Z9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749737572; x=1750342372;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+m7vYBsU85tLjESg73MFdmLBCg20+wdtbP1Z8Mu9gw=;
        b=qHIw9B3GwHfWlXiIJLFZ8YoKS3fgFuYcqY9ok7k8YxYF4cDVpabyV3Uc+sjizwVtzT
         edbSIghbgG6PQMlEmdxSpKvfexhSpwOkyXctslya+R4icQohwHh3xf/aAUFHoH0YaiJm
         nOIwxPDTFtlfEJ2rCfOBPfhsED8VY+YnkeStlfl5WJj5gl84hPwBgDyRe+BmanIbZGSw
         uUJYeT3Q+26y8Dqyu9vQ5XjCGZ9RFNceSSdx911dB2S3lGORs1WQLbLSrZdKYSBqhFXF
         KCEkgyFc346Xif9ZwsfAafF3aJUkD15+je9ncQHS5ZErMEccEnh3DbECF1xVVfsy7sUg
         +1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDFQ5N/gfFGT+oHe40e8UAtNEeCSpQGrzliCzDxS6zffA5gTdnC+d/mGhCBhgG4Xwy+qS2iM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1XIcaug7Q9C2ZNfU0OCtk7bCrkbeEBeK3ZfB/1KsQ8tgyKa3
	oqGbBLaGn5sATHBeb+PkYIuraPF2Qu0bqVLjgozNFkigj1lLcgUysfraNLRIx0RlXRz7Owo9cyg
	Qk9H+gaQ=
X-Gm-Gg: ASbGncv2btBmlfrmlYK5h6yVkJuUz3X6c86drDdOcBbjeYB+hFB6MKQKk3iZPFIZgs7
	lD6VgCscQrDgsEiAj3xPmf0gEU9VL62pAZboOb+zsa3rSNb0pcWmnyBqQ28LTzpDxsxCxx0diLo
	27BeNRZrgTyfbWcNlrqGW9GqyHEu9C+BW9noqCa0cXEQujdXjKRAK6/5NpKqsb957PmWMha3raB
	qyntJanzIiQyVnj9nPlOG4VHZ86kalj2va4+2KA3ogJszlUCemr9M2MWkx4BZKjX1Tot8PPZuR3
	vyeVDB3oYevwGOs+8mswrzaCr7A8mLLu91NsmlIPW5KHPq4y/peMy8yt9n3kwVr13N8=
X-Google-Smtp-Source: AGHT+IE6AmCf5V9oHfWOt9dYuSHqj1qzlXCkWSsFnnG7NUfV5Z5SKBuMKwud/rOH6HANsQ0sthmKhw==
X-Received: by 2002:a05:6000:178d:b0:3a4:da0e:517a with SMTP id ffacd0b85a97d-3a5608135aemr3279107f8f.23.1749737571906;
        Thu, 12 Jun 2025 07:12:51 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2446b0sm21538585e9.21.2025.06.12.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 07:12:51 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:12:48 +0300
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 1/2] netdevsim: migrate to dstats stats
 collection
Message-ID: <aErgYLGwLjoHxCLv@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
References: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
 <20250611-netdevsim_stat-v1-1-c11b657d96bf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-netdevsim_stat-v1-1-c11b657d96bf@debian.org>

On Wed, Jun 11, 2025 at 08:06:19AM -0700, Breno Leitao wrote:
> Replace custom statistics tracking with the kernel's dstats infrastructure
> to simplify code and improve consistency with other network drivers.
> 
> This change:
> - Sets dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS for automatic
>   automatic allocation and deallocation.

Ignorable minor nits: "automatic" repeated twice in the list item above and the
other items in the list below do not end with periods.

> - Removes manual stats fields and their update
> - Replaces custom nsim_get_stats64() with dev_get_stats()
> - Uses dev_dstats_tx_add() and dev_dstats_tx_dropped() helpers
> - Eliminates the need for manual synchronization primitives
> 
> The dstats framework provides the same functionality with less code.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netdevsim/netdev.c    | 33 ++++++---------------------------
>  drivers/net/netdevsim/netdevsim.h |  5 -----
>  2 files changed, 6 insertions(+), 32 deletions(-)


Reviewed-by: Joe Damato <joe@dama.to>

