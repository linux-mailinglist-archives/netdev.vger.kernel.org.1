Return-Path: <netdev+bounces-150938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068DB9EC22D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6D8285AF3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1201FDE08;
	Wed, 11 Dec 2024 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMOIxaXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9E1AAA1D;
	Wed, 11 Dec 2024 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884267; cv=none; b=Rtf9d/1IXeG7YPd8IpJXcW+U0pBqD9T58uNgZQMEv0MMH6vt/jblUFjhxxgjlxCSl8x+7oSqGisWDzqjQeVoPa4WG/YL8JeeWuaalpNn5u8Je1gkyLTnyONjepuT5+XB5tGdBzDv6aQxEtg+Fm0H4G1SnW6JeaNFGIVZoXqSHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884267; c=relaxed/simple;
	bh=9/RMUndcExKfIjoAYXiSrUcS/uugTHcL3EUWICRqRuY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iJ4yGKHEa+fK16pXrsXcbijEtPcDeHmZkD1iHHmkYDOhveHqLMLYd07aerfT9lC05Mewuq2/forOHEywnvHBfn+keqew7PzPwmf657qW8xviO5EMmoxTpxT2OIwc1RiF7UIiKPJOtx0l6vVYyyfFbjLtekgnQczLAVhI8/dFuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMOIxaXL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863703258fso106743f8f.1;
        Tue, 10 Dec 2024 18:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733884264; x=1734489064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtkADtFaW5vFNsFzmyNYgIm6XeqYy3yV6Xm55WGlKSo=;
        b=SMOIxaXL5at4fjJW5Idz1MNJBkwDW7pFirDt7hntYRaT1M/8OwpOtnyHCWnmMyW/RW
         R8UqoXKTmYEXOvcdj2GXwfClrdQB4CO5VvkNKfPd8coFxsoh7yIPx9shE5fNgW1Ugssi
         ISrCHiy4O+fcFv5ACT9lPHCFr6iosJpzhCfL1sNI6NQRZHIH9lzR6M1nC3g4FlzkVYF8
         B9oFcSPW4pxFEV311yVbprEm30gaSUj4MH+SE+gteTruVEwdTrwqBOfTHYZ+9yeVXvzu
         SlqK1uUjqe05Ub7NptmIJcwRRZRYZliIuii8WW3UXn8Jp4VNyVzxWNfUYzCHVHCbzp57
         6QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733884264; x=1734489064;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtkADtFaW5vFNsFzmyNYgIm6XeqYy3yV6Xm55WGlKSo=;
        b=aalItLM1LqqZnFQXHr285KV5FpipBrLiwcUhpM3rXQyC/viWHs3HLpimaRueAdO8P1
         w3wiTwbeLVHvxLUXBGGjKpqBCZ0AHmnE3um/oJ39Jib5Uxix9i4XgCeaINUHXZM9ETmD
         Rw7ciZdzRNNp8tk2km4WnuZhpXUDh+3+uT2pRemmhVRzT3FlHnGJ097CIZ5UPjL/rkG7
         Y70a6Ji0nEJQUU80GhaZ3HmOpI9n/uY/nddQxHfVe/eF/t8Fp+54r75GBffBpQBeOlnc
         mZYNgfRvBQyX6Y3H+eJKIZafMewKAPy3kjlc4/PNEhSj6V7wAfLLs8o8DGYkc9sv5Kdb
         3B1A==
X-Forwarded-Encrypted: i=1; AJvYcCVwm0afzPtgiDx6VE20BF+V9BIOimFydc3uELMV4QVinZCrH3QHSid5Y95MFJgR7YVjp9K77t13pHI=@vger.kernel.org, AJvYcCXpRuABWk5WiCJ5Vg8MhmZIJEkRjPRZB+pjU0KKqDX/NkNEoFqhv0Nl/YqUXtOyH3CWXkCynQfW@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdoTfT8wqxYlp8cvkjr7IwGpLnoW+4yDtKoESQ2H+p2nDOEqz
	bGX81qWH80orT6dXkzQm7YxZbmKAB/WANSYy62NDMXxxcF0NL79g
X-Gm-Gg: ASbGnctv45S/jCEgctmw1S3I5MnD7jZIf2JPTenb6nqklWtuDLbeNkfMmQoJh7QFJo+
	J9coX+ecfx7D+1p71BzWkQlIaOEjAxg7KDALgOacbOyBROLXt7rwFqAgTXkZ6goIfJNgkPf4M+g
	osvI2vaPH6N8fT6teMDaCgZL6Vx+3zx+WRhHSoRK92j9QmXaXfAxG/tdOabat0GaJMyCvPragY5
	XxbHcMmROwFoug1kCPWtmArGgD4ZiJIM6Ger+AeIv65N98MaYLjd4ELsQXFRjRSOBsqiwftouUq
	VLzUYTSEXFVIWmAzY0vvswdTkBlSLe78LqZyWYE/dQ==
X-Google-Smtp-Source: AGHT+IHLe4oFOwCG1X40I8qdseDXMMpZXgckwUjW58XF1YFf4gxQ3VpvIkheqIOqqd82tcCFO74cOQ==
X-Received: by 2002:a05:6000:1869:b0:385:fcaf:841 with SMTP id ffacd0b85a97d-3864dee4258mr495319f8f.23.1733884263825;
        Tue, 10 Dec 2024 18:31:03 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f8e1sm141794f8f.18.2024.12.10.18.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 18:31:02 -0800 (PST)
Subject: Re: [PATCH v7 24/28] cxl: add region flag for precluding a device
 memory to be used for dax
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-25-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <455f8e81-fa7b-f416-db0d-4ad9ac158865@gmail.com>
Date: Wed, 11 Dec 2024 02:31:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-25-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++-
>  drivers/cxl/cxl.h         |  3 +++
>  drivers/cxl/cxlmem.h      |  3 ++-
>  include/cxl/cxl.h         |  3 ++-
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b014f2fab789..b39086356d74 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3562,7 +3562,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>   * cxl_region driver.
>   */
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled)
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool no_dax)

Won't this break bisectability?  sfc won't build as of this commit
 because it tries to call cxl_create_region with the old signature.
You could do the whole dance of having an interim API during the
 conversion, but seems simpler just to reorder the patches so that
 the no_dax parameter is added first before the caller is introduced.

