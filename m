Return-Path: <netdev+bounces-148532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3C69E200D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC6AB339FC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71A71F4283;
	Tue,  3 Dec 2024 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ+n1zPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0921F4276;
	Tue,  3 Dec 2024 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236744; cv=none; b=lMThUMkjxcwUdCXcxv+cvawypPVxYa5oZY6oDgX7JZ5X9XSxlC3K6glTyxSPwJX+nJz2W0cAhsc1B4Uw1aTpURtBaHBIJlY04ISqpOxW+BAcnK/kdoym0vRKj0oqTeH17BZILnpvVQGtdOiNfy23XQIzKpNDR7uQcr9zsBn5kVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236744; c=relaxed/simple;
	bh=JRUF2YYZXxdXrz7I32BM4v5XuVUT6Fq44Xh0KgTFXnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxJ6WsIGUZeBha0E00RHiXA38VBJHGmu8RAHvee0BMpzhuV/Ot6dSwjnkLtF1aflUE+NICJnhwaBcBPZqeZLwXOuTyxTsfpivURjWNrX6Apv9ClT1CXtZ0pl0PJY7HbSzM7TjB8gGkGAoyTKpuhgX1XcgJH/O9PRKBFKzlrmYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ+n1zPQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso801119266b.2;
        Tue, 03 Dec 2024 06:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236741; x=1733841541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXiMR/eeBEdPABRQPOzGnpXDwIUuwMlFOAFFfmJu2H4=;
        b=IJ+n1zPQtnscmcCfW/NxDccZBhmxebR0RT5NPXwIrEIwtGu+MLdbXFLmjsqAO5aI6J
         qYlu+deMVy0g48fQok6X30WWCJA9Ln4sP3gt8E653ACyK4iHaA6lOm8VhltJgjNSdDIt
         I6Nbbfe55SR2pZyWQzQCo8ILDxrB3tXPU98l+FtmDcp8kyscf3YrJZUs3o/ACAsiQukE
         nD/4Rq2bRiOGKNAYnX9gCftlC9qQkOyOgQUgxbgQXlBCNq0859tfHgHJzP+5sp3d0Ucs
         IWtdZbZP6MurFmZxAMQuHJAxu/V5/T+6GTocoYG0dYXTHpdXQKzveStU38KwpgH8dDnL
         SXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236741; x=1733841541;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXiMR/eeBEdPABRQPOzGnpXDwIUuwMlFOAFFfmJu2H4=;
        b=cQZlScHNmlgZirXQ9lXPpC52k84Ezw7bk2B8uJjyGhgklw5QDnou5+DoW/yweDxsBq
         74guJUju1BFaQUKM1jFtn4nNW0VWP1t9aSmWLEbcPCtYFDVUZm4fVz/Zq9okhTCCGZSE
         V2ZECBolc13hSjnDw/yMR1h+YRJ+J62uo/JQwgiq6QU4kgF5zgB5nSMx/xBLKKPuOMGy
         /qfzY/7kH4SL/giYWjuIwmD3Itzv5TuxiAW04BSM9fRT49r9KHs3RGru6WLH7dJLBRCw
         NNifFhlICXZPX5Ae/g7TPXIyigFJa1Wh+3gfuM/nhig8eTe78ZGD8lfZPlOlbR8YjReO
         ++nw==
X-Forwarded-Encrypted: i=1; AJvYcCUrFGWm4j2dkCXmqreoc9krQ30RzD3iOtXSCGLvhRpaNbDDQxI71Djzpgf+KOIW/jiQsd9+5/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrx7ggY7cV3uQ/a8vM1682ZHRiQaSZ/VvqmtnS+PuwoxY/DedT
	OFmdmLxci1jxXw42oSRshFRa52Pf7a9Hu/P82cXN8Lw9DE4F/UlqoH6BnYdS
X-Gm-Gg: ASbGncsz1u14L+q42Z5ANDYGIq4dA8X2ZXmfKhpxTjiQ7dv6zfy0/xgONJpP/U/KJIB
	uTkJQGlz6tU1UEwaXrzPWFC8s5XaK44TE4jVWN9qNQQ6IHim1/YgVIjNhQW5oWnjGvKTKeGWz7h
	qTBDcZIncGFJGUKqKMmv0tAzB1s7CdyybEHB/TBp87YCET42YhdTLj2zGvJ1fy21U57/FFvMfsA
	2k+9Gq79xRFmwP4mHuOR5h478nHca8pAP5784wG0mNjRI48WL4=
X-Google-Smtp-Source: AGHT+IEa9KutWzjLrO7MeghOkyv6OBvhWEVGY4WywoaolxJDNckg0/rP3/hPHKPZA2oolMH/y2rD5A==
X-Received: by 2002:a05:6000:705:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-385fd3e9e76mr2531220f8f.21.1733236730546;
        Tue, 03 Dec 2024 06:38:50 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a5f7sm15669359f8f.54.2024.12.03.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:38:50 -0800 (PST)
Date: Tue, 3 Dec 2024 14:38:49 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 25/28] sfc: specify no dax when cxl region is created
Message-ID: <20241203143849.GI778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-26-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-26-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:19PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> The CXL memory should not be used by the host in any case except for
> what the driver allows. Tell the cxl core to not create a DAX device
> using the avoid dax at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 3e44c31daf36..71b32fc48ca7 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -128,7 +128,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> -	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, true);
>  	if (!cxl->efx_region) {
>  		pci_err(pci_dev, "CXL accel create region failed");
>  		rc = PTR_ERR(cxl->efx_region);
> -- 
> 2.17.1
> 
> 

