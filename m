Return-Path: <netdev+bounces-138923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19C9AF6FD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D701A282B0B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937413AD1C;
	Fri, 25 Oct 2024 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPN8LeH+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97113A40C;
	Fri, 25 Oct 2024 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820397; cv=none; b=rHwKB099K96eJeVx/5jJcS6nFLw5UDz4c95U4x2lL+DGal0PYVwUV/981o/WBvr6T/miufzbgsaeUWMxHrc7PWQIn1NTrZLyCRyVON2slJD8zFdpWZ8hMI57QEMrVVU+fDQQ6Lj8LYtlOpedsV2+olNlBjgn457ZEN+s0PQ8nK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820397; c=relaxed/simple;
	bh=d83gFXBRG3Nz4qESQ40kq/AfjnNIiQTlZXdmGplXDHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJt0kOijwdX29r9FG+YggqQs9gFDwyc5KEyQbCvuUtF+0QYRNkdKyXFFQIUvgQxklA2EvjkjgfkOaPWDQi/rSVbyJLMc/kBBuA6W5BJLTW9sejJPavg1mr30lbfasIIFmnvD/X7hIfrHxp0B82iXB8CRofqQ0X9Gl9AbtTkVVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPN8LeH+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cd76c513cso13528395ad.3;
        Thu, 24 Oct 2024 18:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729820395; x=1730425195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tFezwFo6gCZgxkhS3m0Bz40bL+vqBj5E53gWNhWxLYM=;
        b=gPN8LeH+TklrH0WjUA2ci9yLx6gmvl1S9MkM7YYn0L8HbfIE/gFtSP5whOhToa/wAo
         fMhpEdGCfsRFmKKg+zMwXW2GUJk/XQfZ8I80Bp8K07x3WvCtFn0CQf0p3qzY1DiOdgdf
         46qm0Y7tplmaxVrBAUZIaA9qOhQqONPU4903SYZ7nUjo89ySl6LKeoTMq2AEqnJe8du3
         natQA0lwLsAHOO80vdd9s4jueT/mK0D3tp39H+oTOT6SfVYqwuPAx9OHepN9t16IHUQ2
         5EBHWuJ/zw+z8yts/IuHH5I7gKzf6UqWtfqyN4qyqJ+8oWCniTI+ElP4JWQhGUmPBzU2
         i8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729820395; x=1730425195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFezwFo6gCZgxkhS3m0Bz40bL+vqBj5E53gWNhWxLYM=;
        b=GZQRvoHn59dpaXr8TewXVpE2rPZCnloT61E5vd3MGHo4JMItllEiWNIP23OBDhlSll
         icZRn4+J0r96TNGNtYtTExCJQKkQAezXlrk13X/FlkvdFyExxBFmTL2+QzCuWfUGcj6h
         H9qluRLiYHTWrJlypFNuIbVZUssgGI+p7P1xPyyMz8FtFw4BNnytANoTg+70X7/Xar/a
         ErwCIwHKF4H7B0ceybFpdlJXac7M2t4jztenmKv/BhzRsUFYxry7v8eNsb2R+Wv8Gqy/
         ae4uvzulCiB/4Xio47AuwoMbTyEkrW5FYkHTtsrPVu5IjO7rvkElj/AUcgO3cN2flt7w
         oDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg0Zu/A25fTUQqEoGj60se7gGh4hHEV9BnrYHJBeGwJIH35x/QqB3XhdSnKw2XtHZe/AeSVGhNtHah@vger.kernel.org, AJvYcCXEWLleCtZUD6gaXwFJ1BgezW/V9wApO+b+QPsm+GtZN8F7EvxOlikGTUOWAIVFGPP/SSi9GMi8@vger.kernel.org, AJvYcCXZg5C7jXAdGPqcvMlJm2X3RsFi913X7HEKN+WYTUgFmyqqCYxBBNcMcWDmDIOLBwugIFOOSxkU1twqNPhc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1knGMhQkTnpSRtf2fdpYL4BngkgiGZ2HjNKJtDcbmKZjj48l
	apcZ8xVIwG6blLIZOTrNf0xxlWIowkFU8R3NzI/yV+cowoHgMPPC
X-Google-Smtp-Source: AGHT+IEHw2vnCcYrgnHOby/RDV1VCi/V1qVIt7cOTUZOAUPWFAmc5ivhTLTks2UseKSuzasudSeCxw==
X-Received: by 2002:a17:902:ecd0:b0:20c:5cdd:a91 with SMTP id d9443c01a7336-20fa9e99bbdmr109987285ad.41.1729820394814;
        Thu, 24 Oct 2024 18:39:54 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02e661sm761665ad.191.2024.10.24.18.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:39:54 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:39:16 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
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
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <2emb7jimgg4utgecdfhc232qclp5yfiqvlw6gl53niwtgoeb7z@uvoy7kqedqst>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
 <7lcmhspo5xq3numdbrfc44uqppbzigwq56vmqne5ldvg2uac6z@ivu4fmwbzajm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7lcmhspo5xq3numdbrfc44uqppbzigwq56vmqne5ldvg2uac6z@ivu4fmwbzajm>

On Thu, Oct 24, 2024 at 05:37:03PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Oct 21, 2024 at 06:36:17PM +0800, Inochi Amaoto wrote:
> > +static struct platform_driver sophgo_dwmac_driver = {
> > +	.probe  = sophgo_dwmac_probe,
> > +	.remove_new = stmmac_pltfr_remove,
> > +	.driver = {
> > +		.name = "sophgo-dwmac",
> > +		.pm = &stmmac_pltfr_pm_ops,
> > +		.of_match_table = sophgo_dwmac_match,
> > +	},
> > +};
> 
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers. Please just drop "_new".
> 
> Best regards
> Uwe


Thanks, I will fix it.

Regards,
Inochi

