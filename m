Return-Path: <netdev+bounces-112860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727693B885
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187E2B24BD5
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 21:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D813A863;
	Wed, 24 Jul 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA4uWSIz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D066F068;
	Wed, 24 Jul 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856334; cv=none; b=V3oK/vGH/hhuQ+AQDFD8M3yGic7ne5FBpStBYePfenaeavlLZs3C6nbIOs/uZyEuwS+wyUJj8crr8HQ/VO0b0pS/XB7N8vx09uihWJltBAIncrVofZXFZP8GN0pRGzXuJVKMkdStNvwNdB/nd6SSVAGNzrJiytdW2t5BFRZPudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856334; c=relaxed/simple;
	bh=1NH08U6BGBVe8khrqnXgkPBVMo9qPyuXxOiZxEmiL7A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrgCDhHxpnzz71UONj0ZyiP+TaUl8xgvU5S2t5qpdOh7U9CEmFtPoSgxLidTtIRFE8PO7y18CmRYIyupQVJWlsOpkMMAYVojUCaUHvuWKULbuQPnxGTqVVJhLL2b3Xw13ZZ6UNqzvrl2f5Xk2ymwTEKvWrTgjtbSprGlqAB+Ycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA4uWSIz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-65cd720cee2so2553747b3.1;
        Wed, 24 Jul 2024 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721856332; x=1722461132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXMzawJgF7d8QM1EjmcWHU4EhRglJETzEU0mZ5bhStg=;
        b=aA4uWSIzAUCOXQchhHRvt/llWp76jYldvn7AGn6J4sJTJ7txIQdu9WlRjaXW4KeRUY
         AF0tPNQBZtQcsePtVT3ck0mSm0vt8cDgwaGemETMxs4bJQ9PTgqPu5ztBEQzoFX45+fA
         GiIZo0137D7CiWFZ8m/z6j/6R3eHPiOeBu2ef7QZXq9+bqbH5IpFU6arkw8Dloeh5yl6
         5st2i4Vz6UxZYIPUjrpLW+9b2D2FFZNtexlqjBapVF1sXP8o+T4AVa7vjTOkXcJhp60I
         oSyfK1/Z/HC38ZXtkGNxTo6/FjHVZG8tOJw16MBWvS34Ptq3TfkL09ngx29v9BcIlyAq
         IVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721856332; x=1722461132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXMzawJgF7d8QM1EjmcWHU4EhRglJETzEU0mZ5bhStg=;
        b=wtwEH+qjFY9e15AUXgvgxMr441wyUlcMy4ec4LVJzCQtFKztvjo0GMj73Cq5IofdpD
         5Akvcqev5vl+avHYJgk1w3GXtPjgT1I6jQ9WUHrodGruyuAlA7zLHrveT2N55YbIr2q2
         xVMLa984p9530fTPSzHi2zKxEQKAYLJEn8mLdf5Qt3BK7TSSwkihGR5auSXe6vEuhMeu
         ViF9OD4I0/bXvObBKI2l3ldFu98zZOwhGx6TNNNlOx1cc20qMPWiiDrksqB0mvQAdMzv
         mYiBkv3I8kH1fZJWi9m0OAQAWEbKkJbBzFcL/opJc1QC0VJspFdKgRJqDFe6/ovJD4u2
         xy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKVRgprx0bQ2fmTUQBErMJFs8qL8Vah0CBVUTvRUMZouK+gQRKq3puKN183PaLIDj37zRINek9zAd/anWG6yaLgX93SmL5
X-Gm-Message-State: AOJu0Yyp3VIgj2Lp0zlpF+KVOTMYhEfF6tTI1QLUybrvWOsSmOEwu5sD
	cVve4a7L0JnmQEs5EtQUGYqY+a6V5jpukPta6l0Mg5mt3bmPTMe4
X-Google-Smtp-Source: AGHT+IEoAl+CJ57tB/r7tBH2TfairOoFqMQSaQgbYQvoiKceckzLiGz7uqh8WrlpD1uYZnNUeHpSvg==
X-Received: by 2002:a81:6e02:0:b0:61a:d846:9858 with SMTP id 00721157ae682-67511b60918mr8104047b3.20.1721856331852;
        Wed, 24 Jul 2024 14:25:31 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd9000sm360627b3.27.2024.07.24.14.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:25:31 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jul 2024 14:25:14 -0700
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 05/15] cxl: fix use of resource_contains
Message-ID: <ZqFxOge1S654X4Uf@debian>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-6-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172835.24757-6-alejandro.lucero-palau@amd.com>

On Mon, Jul 15, 2024 at 06:28:25PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> For a resource defined with size zero, resource contains will also
> return true.

s/resource contains/resource_contains/

Fan
> 
> Add resource size check before using it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3df10517a327..4af9225d4b59 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if ((resource_size(&cxlds->pmem_res)) && (resource_contains(&cxlds->pmem_res, res))) {
> +		printk("%s: resource_contains CXL_DECODER_PMEM\n", __func__);
>  		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	} else if ((resource_size(&cxlds->ram_res)) && (resource_contains(&cxlds->ram_res, res))) {
> +		printk("%s: resource_contains CXL_DECODER_RAM\n", __func__);
>  		cxled->mode = CXL_DECODER_RAM;
> +	}
>  	else {
>  		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>  			 port->id, cxled->cxld.id, cxled->dpa_res);
> -- 
> 2.17.1
> 

