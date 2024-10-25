Return-Path: <netdev+bounces-139256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E89B1345
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 01:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA55B21920
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155191EF943;
	Fri, 25 Oct 2024 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X32EbKVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22005157E99;
	Fri, 25 Oct 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729899156; cv=none; b=AoD/l51SkUt16dNWaOhVrdBmapoCx+uTSdTyfcAZVl2L1lhkEdfElqr8yfPqP9Ud6uE/W6fQiq74L7/O5d5idIQXJtpevQk+R2NLVQLu7ZOlcHQQt4/7rw3F2QxBd3FBHRdlFFhpT255rKZXilMwvKUJu/g7cChWp3vPIJuMuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729899156; c=relaxed/simple;
	bh=HQ24BCw0Yd+wMuNuCr+vHzj1uSpA024X5gNetuoRnac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7+lLBZCVE4flhxYIbbg46jsx2K1QY7oOQg8ycOfLDRE65X2aezElQaYGXXJIWtoOo1ZM3ESB5tJL5Fcc6dYqwhmNJtVucbh42hNGBYa/76AQpWABu+y6d42g6SsMIEM96vZU5/67tkXfRIvvfx3SrMcjlXfIkeOnhd74JWxoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X32EbKVA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7206304f93aso296688b3a.0;
        Fri, 25 Oct 2024 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729899153; x=1730503953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp1HPOnz6KaDGaKZ01AnsiVak0lO4QvTbnFD63srZug=;
        b=X32EbKVA/dH5LRxkiIYvr7iZJCA5FZih0wjKL1XFXezfEBjT0VYpZTaV55Zabyu1al
         T6sgAoaghZOVrlg7nu2vAujBG6oXIwG4KoLJnwYhVJLloBogZQFWFLD65FL3q8Oskpk/
         REoG0kPR59gHOYcM9jXHqxOtkEgSr0XXsG9FCQb1YiNa4FbpJOedU2S3ACB/k2UrbP54
         QzNdij+7UhjNiS2BpahZ32Aw+Smw760RiQTSX6Y0lRSzz9m33A2qRjMfh8w8prK9Y8ba
         E7TBhyI4i6xLOeN6HRLmspEUJSJNbCnCnSUZapO5m1dRYBGcTpuDiuYf9drPS5ycRsnN
         //Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729899153; x=1730503953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp1HPOnz6KaDGaKZ01AnsiVak0lO4QvTbnFD63srZug=;
        b=Jroias6Zvcb9lUj7VuH2sg5uJHbaxewwF4yVxbDAvyDljgD3RC3nmZZIXd6ocJdooS
         ns8DsfKjHwR44gvb/HEdQdNp9+PWIUFQYHgT+9niyd6E4urRANda78saHjfs91eEUdYM
         v8Lml6zi5DPm+qeOiYSelYRuqXCp1iEeStFBL/Y9qRwluPbCboZmUIaeibk37VK5plSl
         9uGcuxJqbl73PqRq2+kdettcOuDpOgni4zI8w4N+0EZusD61CxozlZyYEfPY1A20Jaub
         2fafwFJnNPBcOf1HXf31uF6/XUieTnCxV2mldU4dhuRU95HknWlQ9dNVsMiX7FGT75Vo
         1T8A==
X-Forwarded-Encrypted: i=1; AJvYcCVNz9DtbIKY7znZoV/D6xiMXXZjEnqyj3dePpvBbXkocYpXyle8DV5kkdC/Fhg03/S2gvzt+OYnf5Hs@vger.kernel.org, AJvYcCVS9zDy5ENV9tbXEO6q4JrbdAUOROFUVwG+MEp2RTwkedF8zN/Fskm/X5IGgJCwqRTqnSr3RLdf@vger.kernel.org, AJvYcCX3359VlmN93hxgKAPu2FZ55Nzp6u/Lappa/qKzyvzshgvQhijvP/4QHe8K2LS1KZG61MKIEkACWSCyaxwA@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHbjiuDZd5vu0VcyWxFvjFpKRJ+TcDOHHstUPGF6C2NMrudrW
	T0+WyDy2UeviL0g7hRwHZ+FmZtLj5FVA5XrMVoxyxDbgiDeE4Xim
X-Google-Smtp-Source: AGHT+IFEMrLhc1Bg4iRCP4q4hozIJt6Sp7huOuGxcV+yJK49RmRzhj24Vshw5AfU6IcH7rJlxKNWYA==
X-Received: by 2002:a05:6a00:b54:b0:71d:fb29:9f07 with SMTP id d2e1a72fcca58-72062fc7c5dmr1589435b3a.15.1729899153356;
        Fri, 25 Oct 2024 16:32:33 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931e2csm1641781b3a.63.2024.10.25.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 16:32:33 -0700 (PDT)
Date: Sat, 26 Oct 2024 07:32:12 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
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
Subject: Re: [PATCH v2 3/4] net: stmmac: platform: Add snps,dwmac-5.30a IP
 compatible string
Message-ID: <lsy4wjdce3bhnqgpnu6ysby6ghlzro2ghp6z3jzmwu6vuisr5m@dbljy7b3dhgs>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-4-inochiama@gmail.com>
 <2b691bea-3b2a-469b-bf5f-5e80b9b9b9a8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b691bea-3b2a-469b-bf5f-5e80b9b9b9a8@intel.com>

On Fri, Oct 25, 2024 at 04:44:55PM +0200, Alexander Lobakin wrote:
> From: Inochi Amaoto <inochiama@gmail.com>
> Date: Fri, 25 Oct 2024 09:09:59 +0800
> 
> > Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
> > to define some platform data in the glue layer.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index ad868e8d195d..3c4e78b10dd6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -555,7 +555,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> >  	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
> >  	    of_device_is_compatible(np, "snps,dwmac-4.20a") ||
> >  	    of_device_is_compatible(np, "snps,dwmac-5.10a") ||
> > -	    of_device_is_compatible(np, "snps,dwmac-5.20")) {
> > +	    of_device_is_compatible(np, "snps,dwmac-5.20") ||
> > +	    of_device_is_compatible(np, "snps,dwmac-5.30a")) {
> 
> Please convert this to a const char * const [] table with all these
> strings + one of_device_compatible_match().
> 

I will, this make the check more clear, thanks.

Regards,
Inochi

