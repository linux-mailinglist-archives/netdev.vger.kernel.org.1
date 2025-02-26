Return-Path: <netdev+bounces-169676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE11A4539E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DE019C18D9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4821CC66;
	Wed, 26 Feb 2025 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAoqkI/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DB21CC64;
	Wed, 26 Feb 2025 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538962; cv=none; b=acAcEPBiTZc5GBFbyEiEl21cMJ2Bnmb0MlMCjqZgrvOmjprkgCd7jBKoMyAyN+ldu3e8fE8jqTma+plwObIMj+39ctzxxBZL8Yxw+8syWjFcbNVOeDujTmWpe4Ao5tjLwtFH9tiQI4LlMQ+S+rET4umYLvU/vlKr7FOjCRaoYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538962; c=relaxed/simple;
	bh=3c24Yaa6aoJNA+XE0rs2FKAD32/m13f70OfUYHsvMEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH9nQVj+l2P4vmk3alUoCIQ1OA+U6J8Oc8fIu7SKcOeE3m8mPVHqo68DcCxGX8LxzzmnWlLnXsv4XYw3PYwUZViSToM87h1fnrLd0hzBeBEFn2uwRR+FIHHDT8m/vxgh2egtuLeBZmYHkpxY3quPoBuPR18R3XSLCYWU+P+d1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAoqkI/o; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0a3d6a6e4so585464385a.1;
        Tue, 25 Feb 2025 19:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740538959; x=1741143759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWGPjFHgSWrGIWxwthBdQ/xcx/InimPCbKnNLIXUuQg=;
        b=nAoqkI/oSsQB8LnKhy9urtmqb2akwgDf46KB4x7GT0McIi2SWAKJJVYOMiTdC4LZQg
         HJUdK53yhE4c4obAPkKSUG1A+v/niyiVvXxzZqy1du2HCcMgdBiHfCXu1ormYeLaP8fM
         ockYSMGck3wOdyfwjdIOr5YrO2mirXjSUT2ZX05gUvzOZ5H34ghf/qZhGvl6JCw+nBJf
         /unEBj8gp73CqEyxiuMRDgbInQG+ZiXCSxpmlktkEPrYWsAvgTLF4HQVHksBFK2TvMPm
         7pQpUhovFqrvHDqZnbo5eXe1HV8IKwVEGn8Aa11+e4jfyuIDVe8PZrUFEqWpaNcy03Yh
         yPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740538959; x=1741143759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWGPjFHgSWrGIWxwthBdQ/xcx/InimPCbKnNLIXUuQg=;
        b=vIsEuBEnMBEsLZA5PrvpmesY9OzYNFzgnhptuCt/ajbIhFYn8PjmbdpvZZAywzZi4S
         oIylkq+DsUlY0femLD/ZnEycgDmw/3AalwRZce07R661tZ7v9EJjqaFdaNqAyT40xcuR
         kDF335H42SdIlFQxwFp1MnR7vQFbcgg87xjcFuyOTInl5w/pBxPbTp9fj+1TEp+KTmGt
         ekTiGyl+meHr0FAWELp85WtXFRHLrkSOMXyEfaDNeHxtEizEylaUs0p8pTuvxIoQy3dQ
         3AqfB5djYyIhiwkFQLOkPbWgcNjoHe4pyjUeWdxxkyyDrN0UKF1QChONwqmOvgtd2lhR
         mKjw==
X-Forwarded-Encrypted: i=1; AJvYcCUf1hY/EDYFt9WuWU0iQOWq50ZjGiOdAzLV8ksdx00UVGDNLh5S9YW9Sn/YBmi2yXo7CV+sWv8erFpzG8TD@vger.kernel.org, AJvYcCVQUVm8ptPRelPCdNaV26tukc0sSOKCumLrDEqc01SFejYJSyLKQh0qNLRBwM1r3le/9wovUb5N@vger.kernel.org, AJvYcCWAngN9xk2TJplSRxjrRFLgPO3isIKy8aVE/vSCyvqewod0NqTDDbMMbLZ+/gpvYeDL+UKmyvbhUOW1@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVMF72LAGV6zR15/O43CMhvjOVWin7yurZb8hJZrqr3sNN0oJ
	fNTDw2cGAC55UWq1oOHaCwwJ7ADQXIMoKoksBRo0OCwWzjKUTByx
X-Gm-Gg: ASbGncvYHraXV/nfIRHty6b1J9PiB4nA9IzqA2XUrguhUXxXqIqFZ+jOJBFORdWoCIc
	bnTO5NSImp5WsMHs88k89VHP9u3sOruHtlaNceZ8vM1QPBRGJei9/5612gRCfjCMlzSBgIRhBk+
	Qsz3hyiZx/BMdTFYbyj8PiJXwVWhmffH3eJRfzS3vhsQq7wKVVaOhWi718RnCLqSVm0CzRTGnor
	6TyohAKvxasqgyLxT/XRRAxgYTkZEU7FO/JCjWFhQAaAZ8Na5GzhCvLpPBd+ptFMr8OjDb+3lza
	iw==
X-Google-Smtp-Source: AGHT+IHHpOcJnkRPQaoqWYQ3IiTuUkMc/Lf+N3a5XwCkc3EpHwBEssBvkqtKRau97kDkFIbjmuq4Pw==
X-Received: by 2002:a05:620a:2495:b0:7c0:a3bd:a780 with SMTP id af79cd13be357-7c0cef5d1a1mr3696532585a.54.1740538959130;
        Tue, 25 Feb 2025 19:02:39 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c23c2a72d1sm187707785a.34.2025.02.25.19.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 19:02:38 -0800 (PST)
Date: Wed, 26 Feb 2025 11:02:18 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 2/2] clk: sophgo: Add clock controller support for
 SG2044 SoC
Message-ID: <m724pjlil3ghmgfikfnyp4hu6iwd4fkcj2mnsbl4gzfufpmnov@lu4al3iqpfss>
References: <20250204084439.1602440-1-inochiama@gmail.com>
 <20250204084439.1602440-3-inochiama@gmail.com>
 <PN0PR01MB9166482E059F3C4FC7A6134DFEC22@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0PR01MB9166482E059F3C4FC7A6134DFEC22@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Feb 26, 2025 at 10:57:46AM +0800, Chen Wang wrote:
> 
> On 2025/2/4 16:44, Inochi Amaoto wrote:
> [......]
> > diff --git a/drivers/clk/sophgo/clk-sg2044.c b/drivers/clk/sophgo/clk-sg2044.c
> > new file mode 100644
> > index 000000000000..7185c11ea2a5
> > --- /dev/null
> > +++ b/drivers/clk/sophgo/clk-sg2044.c
> > @@ -0,0 +1,2271 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Sophgo SG2042 clock controller Driver
> > + *
> > + * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>
> 
> I'm afraid you may need to use your new gmail emailbox address.
> 
> [......]
> 

OK, I will change it.

> > +static int sg2044_clk_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct sg2044_clk_ctrl *ctrl;
> > +	const struct sg2044_clk_desc_data *desc;
> > +	void __iomem *reg;
> > +	struct regmap *regmap;
> > +	u32 num_clks;
> > +
> > +	reg = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(reg))
> > +		return PTR_ERR(reg);
> > +
> > +	regmap = syscon_regmap_lookup_by_compatible("sophgo,sg2044-top-syscon");
> 
> What's this? Do you miss some descritpion about dependency (in
> cover-letter?)
> 

It is just a generic syscon device in the device tree
(It only add compatiable string in syscon.yaml).
As the clock dts always require minimal dts to be
functional, I do not add a dependency for requesting
it.

> Others LGTM.
> 
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> 
> Regards,
> 
> Chen
> 
> [......]
> 

