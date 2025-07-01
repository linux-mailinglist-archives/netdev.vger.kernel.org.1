Return-Path: <netdev+bounces-202838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE13AEF48A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7E43A5A89
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2172727F1;
	Tue,  1 Jul 2025 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrJ46z+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEF27145E;
	Tue,  1 Jul 2025 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364287; cv=none; b=J1Idenfz3Xu2Lb5+0gxTumghIu+sA0/5AhDgvFLvDY//4z1DjOyNEA2UYhvDv0lh8MoQQ62u7ehZ8uSKtK2vsXCj0Zcg6r5wIitsdt+13bxvpnE2vlDCOTlFsFRoCt7BYdG5KwT299pwofxfMPmiGC0qoY1DzJue4Qtod4bn1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364287; c=relaxed/simple;
	bh=gdgJ0pLM0UcV8oL609CbKelSnZQmL/t6Ju0O6BeBF1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiqCmWpl4EzVWb5D9n8D7oGEfHXH3Qls++U6wsRIIgjqyk6jXtgoC4ywNkWRLSSW3e4Bg+PInpYPPuoaX+C3CdTLLc4LlvIPGX3BBr255tTIFF0nIkBB7cj3+9YCtYYpYVe7M1DDINx83z1hdfYjuCVHjMTbg1I0jEZPk07WUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrJ46z+L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748e81d37a7so3869396b3a.1;
        Tue, 01 Jul 2025 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751364284; x=1751969084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71QusJ5AouGsm2mgHkr3YzuD0h0jCWeTyt1AC4+RDvs=;
        b=lrJ46z+L1LCB+HgMyGUVLG3F1NWzhIoxl/E0uDfkdOAQXBxVP6jMm02tQ5PzbC7NfY
         hOQGEXwV2KqWFJTB70OEpwdfp+WwEkjlYSoe1WnhsPifZHYvAy966MiOEqfDSz5JnEbC
         8xZVmUpDal9q2z2wBWlhpJrmisFv4gl/AFPeoOSOTQ9/nz3a/jEpUlZCa8eAWUcu5nGH
         6hITI1zTNe2BR/w8H1jDjO5O48/pQsHH45AQk94igei/5bXnggjrnbgZYuPvJHnEmR8L
         y4FohKgOM8iG+2Ce75IVmJulPZ2TeW7yInSoRjTkfbxD8NKPAOvvUpBOTmGn0PGtgH5o
         Swqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751364284; x=1751969084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71QusJ5AouGsm2mgHkr3YzuD0h0jCWeTyt1AC4+RDvs=;
        b=bVju8q1KHsRql9iGB08S19laqm1HI3sQiGfYTD2kxqxQHSl4kbU762cziyjo6DjkrB
         81Yc6bBSzE4kahFlOjMzRmt2Qd4Mv8TvwfcK+lkBiEiKOoPFnlyHai56T9x+mOgsoumY
         mhlHXrY01b+WFTH8pl7YB+xCw+dnnlFVA8nrIe+kx0zauTEkG0Y9X/rJkV39vcMDO6tJ
         w5Tkg6Y/sjzmoSdDVwEYfk/oaEla5THFMVx9WOgcyOtDTtkLGYcwYa37gx2m+x8p1LHZ
         icfMOrBrVLZeyyu5qn/9wBBi0SIHhpqGStCb0/fxcL+rIQcSNZDR+57p6LW6smlz4Hho
         3/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHNH+f7/YDNtGwO9npsTpLBXA7ag5Blcp2wFjbZGxG/x6NHzm9kyMXg4mca4iGKez7OeZNxlrkNgGR@vger.kernel.org, AJvYcCVllnvQ/nVJeJV/iTyt3P0HgRF2EiwlM841RoxnCDr9goXlRPlg3/xCZpxm9YLElVYiL0KJCGKj/dzbz3OB@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBTykaDzPOmKgL7L9rgtDntQOeRR0/ADSQCtod8WmelS9lpGY
	RVmwORZ/xTkwMhdhSEoWDjQ8lV0Nb9yczZ+E9TKJknP3fQOsxWNmew86
X-Gm-Gg: ASbGncvSp7DIWgEgAWSCDcsEIYavDlNM0E9V3pl4Z9jFluaQGcHMsQ8r/SG5maBUkBM
	Faol9gX9DDXhUOe/FZsEkRUHwxvv9YH7Y+BW3aHeNNMu/7bRcWlltsWbCFN/y1/fB1ytuJ1FmM1
	6TurQ4jCjjJk8noXICCc5v9lanxnaS3jS7DhXtLVi7Y7/SU1E2P5YRkYrX+C0+OmRvVcSW3GE7t
	dmooiydGRaAr7A2YLz9XYNropUjWiDPX7abuBAUvnlWH3MosrlrxLXshx6DOM6AfCa12qDK0NfT
	Xiz53Y1aJw0+MSYqe/VnfLrP7HVv98gSpNGsrQvXdqLqHXAmeKA/V5p+Bt+Vzw==
X-Google-Smtp-Source: AGHT+IHie6mqvlaJorzA6xUxii2gAFC0YaJ/JvpPEZQX9X8fCXiwrRfXuXkWDPVsvQUlpXtMG94W6A==
X-Received: by 2002:a05:6a00:2195:b0:748:f80c:b398 with SMTP id d2e1a72fcca58-74af6f08c99mr21158524b3a.15.1751364283601;
        Tue, 01 Jul 2025 03:04:43 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af57f467bsm11309945b3a.170.2025.07.01.03.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 03:04:43 -0700 (PDT)
Date: Tue, 1 Jul 2025 18:04:24 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Yixun Lan <dlan@gentoo.org>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC v4 0/4] riscv: dts: sophgo: Add ethernet
 support for cv18xx
Message-ID: <gkyq4gakaji6ddx5btmd6fzehfu5mzfhdy5pch32idoio3jf7g@7zlwkf2bvhac>
References: <20250701011730.136002-1-inochiama@gmail.com>
 <vxnvovuetfd6rzgaenwplpkhxm62fhw6t3vi4wkyigul7p4bkx@pwlprna4pyul>
 <a5107266-853e-4658-ba90-d6a08882d2a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5107266-853e-4658-ba90-d6a08882d2a8@kernel.org>

On Tue, Jul 01, 2025 at 08:26:31AM +0200, Krzysztof Kozlowski wrote:
> On 01/07/2025 03:23, Inochi Amaoto wrote:
> > On Tue, Jul 01, 2025 at 09:17:25AM +0800, Inochi Amaoto wrote:
> >> Add device binding and dts for CV18XX series SoC, this dts change series
> >> required the reset patch [1] for the dts, which is already taken.
> >>
> >> [1] https://lore.kernel.org/all/20250617070144.1149926-1-inochiama@gmail.com
> >>
> >> The patch is marked as RFC as it require reset dts.
> >>
> >> Change from RFC v3:
> >> - https://lore.kernel.org/all/20250626080056.325496-1-inochiama@gmail.com
> >> 1. patch 3: change internal phy id from 0 to 1
> >>
> >> Change from RFC v2:
> >> - https://lore.kernel.org/all/20250623003049.574821-1-inochiama@gmail.com
> >> 1. patch 1: fix wrong binding title
> >> 2. patch 3: fix unmatched mdio bus number
> >> 3. patch 4: remove setting phy-mode and phy-handle in board dts and move
> >> 	    them into patch 3.
> >>
> >> Change from RFC v1:
> >> - https://lore.kernel.org/all/20250611080709.1182183-1-inochiama@gmail.com
> >> 1. patch 3: switch to mdio-mux-mmioreg
> >> 2. patch 4: add configuration for Huashan Pi
> >>
> >> Inochi Amaoto (4):
> >>   dt-bindings: net: Add support for Sophgo CV1800 dwmac
> >>   riscv: dts: sophgo: Add ethernet device for cv18xx
> >>   riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
> >>   riscv: dts: sophgo: Enable ethernet device for Huashan Pi
> >>
> >>  .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
> >>  arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  73 +++++++++++
> >>  .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |   8 ++
> >>  3 files changed, 194 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
> >>
> >> --
> >> 2.50.0
> >>
> > 
> > As this is mark as RFC due to the reset dependency, now it is OK
> > to merge it as the reset patch is taken and this patch is a minor
> > change . I hopeif anyone can take the binding patch so I can take
> > the devicetree patches.
> 
> I don't understand why you target net-next with your DTS patches.

I just want to make them all get reviewed, as the dts patch is
related to the binding.
 
> The subject prefix is here not correct and probably this should be
> split. Anyway, bindings have issues, so no, it cannot be merged.
> 

Thanks, I will separate the binding patch and fix the issue.

Regards,
Inochi



