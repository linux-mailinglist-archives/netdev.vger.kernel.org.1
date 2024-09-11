Return-Path: <netdev+bounces-127513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22679759E3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D207E1C20BF4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73771B653E;
	Wed, 11 Sep 2024 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8Zfsl5d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325291B29C1
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077847; cv=none; b=GpTpPoglh4ERrQd97jA+tdz/zyWZkIaas1tu4wpGEgsGnd+cYghES5SB2Tx7FoeAbGvs+sOe5W3QAprC3NbgP3EbdfQ3X3w6rynPk3lK0GIraxwcFYu39NnGTDYY6rLGJQwqFgfYPr3FoyeLp5WpiC2OuIqSu3stBlcU65dBVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077847; c=relaxed/simple;
	bh=Rw0HYoUjUK+L3ACEPUXcViiOi8IqipyTgLTRVmCtdpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOyI8glfEO2NLCUVItqAqGz5zBgv3W2gpHoncD5qeYi09aXmBYkcIxo1ZWk+q/fMv9gmtMcj6ITK6hjtFy2+H0YEW0+s+lmPsCPbVn8yAZC+r3f69Kf+m5W/28u3eNM7GRlO4FboQC1Y7FRB1h3ZVXD2o0d7Hl3aR/q8KRTg29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8Zfsl5d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726077845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IH+Ib1b5pn8WaOZaeFGsrZvEitMV86mg5/DLE/udy2g=;
	b=g8Zfsl5dFjjTXGulzhBcLbq881UbkUizKWo5BxgrTzMy9P8IZMd2hyUEcqCD7A+RTR0eM4
	xetL220vYpdSbUs91s4eRTz2iMMiuZ7sQM+pS5O/IuM0h+80sg0clgDvMmJSJhEaheHU04
	3NBEIVkc6dPHI2uRbLpvVBHinll8KnM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-SbphzIUCNHiaofrm33BWVQ-1; Wed, 11 Sep 2024 14:04:03 -0400
X-MC-Unique: SbphzIUCNHiaofrm33BWVQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a7463c3d0so6175866b.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 11:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726077841; x=1726682641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IH+Ib1b5pn8WaOZaeFGsrZvEitMV86mg5/DLE/udy2g=;
        b=KDXwJfpwwhzraZdeu1rr4yfuzBTyiuSc+SHL+tEKMZg69+FZR8besLH4RvPpXY2/GJ
         pGAm0+GUChppMiyDfmvAM/2dfCegCNYdiMHjlvU6ZqdaaCx8bK/g0v8QmWfw7IpEFCsU
         /1ZolB2o17CkRlsccgONzFejxvasGWV39isl4vrRZpXoWPFJnMtn58AZd/p/ojf52Rhy
         m/frc0qX/cODBS0MuA31Y0DIyuSfUuQ47h2VH+gzufy3MVhTkDoNpV6UnyITGrNfOPMr
         hi/99skezwbzcFbWwiNW7lArSsGIbBgpXz46o9zxlDV856525GGQj1el+J8qH8YcZwpp
         0Quw==
X-Forwarded-Encrypted: i=1; AJvYcCU/OZZyfe2lajAcvD1AciRg8vFdG7R7VFmlbfl4oMurF1V58q48gO/7TtNaVnBSC0ET/4TTyYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUHurjX3w4+TEOHueTm9bNKMPknrwe2Gl4bdk7Fa7anH65w93
	eFo3GNmzJEadnJVYEf0/i2FrqY/XCxJ3TigYCbIxzP6NajW8JtFvZNzm2xaPtqP4FKcHUgOxTCt
	vuJrqqPVJN6eKkk1MLz0rftO95LV2xaBkjX7G0Ba7Ik8kMZlVKH6H5w==
X-Received: by 2002:a17:907:3e1d:b0:a83:8591:7505 with SMTP id a640c23a62f3a-a902966f459mr27778666b.59.1726077840913;
        Wed, 11 Sep 2024 11:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGiOUHQziAMSw1ySVvdKoiB3VewkXKRFTMsAed1ndUNhLmUSoKhACnYsZh/d6DuW5PXkj6CQ==
X-Received: by 2002:a17:907:3e1d:b0:a83:8591:7505 with SMTP id a640c23a62f3a-a902966f459mr27774766b.59.1726077840333;
        Wed, 11 Sep 2024 11:04:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a079bcsm638970366b.83.2024.09.11.11.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:03:59 -0700 (PDT)
Message-ID: <bfd0243f-9159-4397-9f8a-e26372ce85a5@redhat.com>
Date: Wed, 11 Sep 2024 20:03:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.11 v2 3/3] minmax: reduce min/max macro expansion
 in atomisp driver
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Narron <richard@aaazen.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Arnd Bergmann <arnd@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-mm@kvack.org,
 Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
 stable@vger.kernel.org
References: <cover.1726074904.git.lorenzo.stoakes@oracle.com>
 <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/11/24 7:51 PM, Lorenzo Stoakes wrote:
> Avoid unnecessary nested min()/max() which results in egregious macro
> expansion. Use clamp_t() as this introduces the least possible expansion.
> 
> Not doing so results in an impact on build times.
> 
> This resolves an issue with slackware 15.0 32-bit compilation as reported
> by Richard Narron.
> 
> Presumably the min/max fixups would be difficult to backport, this patch
> should be easier and fix's Richard's problem in 5.15.
> 
> Reported-by: Richard Narron <richard@aaazen.com>
> Closes: https://lore.kernel.org/all/4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com/
> Fixes: 867046cc7027 ("minmax: relax check to allow comparison between unsigned arguments and signed constants")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  .../staging/media/atomisp/pci/sh_css_frac.h   | 26 ++++++++++++++-----
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
> index b90b5b330dfa..8ba65161f7a9 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
> +++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
> @@ -32,12 +32,24 @@
>  #define uISP_VAL_MAX		      ((unsigned int)((1 << uISP_REG_BIT) - 1))
> 
>  /* a:fraction bits for 16bit precision, b:fraction bits for ISP precision */
> -#define sDIGIT_FITTING(v, a, b) \
> -	min_t(int, max_t(int, (((v) >> sSHIFT) >> max(sFRACTION_BITS_FITTING(a) - (b), 0)), \
> -	  sISP_VAL_MIN), sISP_VAL_MAX)
> -#define uDIGIT_FITTING(v, a, b) \
> -	min((unsigned int)max((unsigned)(((v) >> uSHIFT) \
> -	>> max((int)(uFRACTION_BITS_FITTING(a) - (b)), 0)), \
> -	  uISP_VAL_MIN), uISP_VAL_MAX)
> +static inline int sDIGIT_FITTING(int v, int a, int b)
> +{
> +	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
> +
> +	v >>= sSHIFT;
> +	v >>= fit_shift > 0 ? fit_shift : 0;
> +
> +	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
> +}
> +
> +static inline unsigned int uDIGIT_FITTING(unsigned int v, int a, int b)
> +{
> +	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
> +
> +	v >>= uSHIFT;
> +	v >>= fit_shift > 0 ? fit_shift : 0;
> +
> +	return clamp_t(unsigned int, v, uISP_VAL_MIN, uISP_VAL_MAX);
> +}
> 
>  #endif /* __SH_CSS_FRAC_H */
> --
> 2.46.0
> 


