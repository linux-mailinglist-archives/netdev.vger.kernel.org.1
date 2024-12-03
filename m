Return-Path: <netdev+bounces-148513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F099E20B8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8272DB603B4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE41F4718;
	Tue,  3 Dec 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc8WF4VB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78971DE2DE;
	Tue,  3 Dec 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235970; cv=none; b=rzOsus/sw0HVb4FKsOP2fV2u5acOb5NOey1sTiBCUmstxpZ+yCY165UbBq6XYXQK6KRz/QmUgcCyF78hB6hjAp5wD3HL+KR8MTurFw/taZ+k8vcZe+cybqNcJYvso4tuqsDEIDpbwMIHr/RlaPTsaarBdJ6576HxKjy++q61Dxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235970; c=relaxed/simple;
	bh=SjIpZvxUP/Xw1rVU9+bM4fxhVtC47azclmv4WXmHavI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHiuRxZ89gB2sVD7PDBQ2AWfYG5kFlZZZeLq41xBZ/VmO/c4eKy0OMTh3BfRoB+LVcLYbDeSx4+AKwx09ReTU2+GHan2cpwEOuJzKA2jCLJldBuL6koiH9lC1NU4I2PTBwY0Z50zJt7DrMcjeQlu4MeNt85ZS0i/9ZYe2gvcT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc8WF4VB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385dfb168cbso2715499f8f.1;
        Tue, 03 Dec 2024 06:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733235967; x=1733840767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3Rx3USMs8D3yDkTpH9HBLXesoFr4hiPxolhkfDInHc=;
        b=fc8WF4VB4QmRwIc519okV5ZJE2BX9lfvhdDR9rH/dptsBwKP1Sm5zebdeaToeWMif5
         4wba6CL4QtPdt4FuK7kS1Cy1KY4Kyu3tSwSu1F9APcLJAoA2YdcKrTocNlrgGwVFC2wC
         3IGb06jtj7f9GR4SnhZV4//fKu1r/ZUnITrQZiTBAEMoNutaiGMVsKFqPOSW2QPJ1ejQ
         GWC3xD0XhfE5ihCtna8Wfheh9PCpbYJ1n4r+QFz0vM/8qETBzZkG9aKW2jpy6ALjnZP0
         bOpaObO+Dc138rdX53WDCa7ZUe1AuQxWFBBoL/LW6lxUHOnnYhU4G8mc5c3+6Fhx4RWR
         PDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235967; x=1733840767;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3Rx3USMs8D3yDkTpH9HBLXesoFr4hiPxolhkfDInHc=;
        b=OYAdahs4fPsOsq3wckB94UUWvwY9rzVGkIm3f5yUcOP6NQagZCRDfD6xmUyJfiTbgF
         s2L6nURvU5bgMQpUa4MfQy6XqZNVR/ZI4xnl7T9w7bIPxPvfOVjmw3A//ZwJm09OHnth
         R8D0PkCMMAr+nS1Np+KameDv9824BQXmNU1AZySJkAs3Xx0e0VMLMwqlWwIn4aoc9BMx
         sB57oJDaymBKm8cvURU3MksxKbNjWN8MRnUIWw9GvnmmmQKYfFqPyIDqusC+R1SBFnff
         5tK8lo5dPX6LAnKjE0y4IcNEmnctCL/RQiQSd6pX776z5Y/yUxy4/BdfcUov1UnBp1oR
         /z0w==
X-Forwarded-Encrypted: i=1; AJvYcCVYnXAmYnkvm5quvjANBa9ah6rA2KozlbXwEDQmPuVqEgu5fuSw3YLBiv6o00q5gIebYlXzlcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGNk4VY5ACCuiqWnizzsTbY0YSQieuuUNn+TiX9uRM50QMKO0
	Xy25KHry42n7wcQQDeCd3hRCzwk0ILZ+Z8Krhokfpoi76STOgYzF
X-Gm-Gg: ASbGnct9lUKEPx+GtAszd6x6WNAV5OecahEhrBth4NXxM9+fNXsN6wfvFStAHf8as7C
	hHRxXrkGX5Z64G3XZrmEcfO4piY05pl7xMNCcmiu1VYbX591LeGx0k6WGGJNCdft3cDG2VkgP+a
	sbntNJ7Q8GEba7TN/cFcKblQshH1meLhvRMWjY75q9v8qMgC5dngvBOvFYpZUedHRotRCmk/nmD
	Jbg/Jk1EelpFLVuwpLfmXh+a/CYWhbQ7qBl9EwZEv+S/HpPnlA=
X-Google-Smtp-Source: AGHT+IGbQovxroW+m/UnJ5EZ/ROJ7MTxCmUPL4jCxFUmSM+5TZ6TiAk8pkoviwkqrBKI3okWm9INHw==
X-Received: by 2002:a5d:6f15:0:b0:385:e01b:7df5 with SMTP id ffacd0b85a97d-385fd3cd05emr2642387f8f.14.1733235966902;
        Tue, 03 Dec 2024 06:26:06 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e13e8eadsm11470328f8f.28.2024.12.03.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:26:06 -0800 (PST)
Date: Tue, 3 Dec 2024 14:26:05 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 12/28] sfc: set cxl media ready
Message-ID: <20241203142605.GD778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-13-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-13-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:06PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api accessor for explicitly set media ready as hardware design
> implies it is ready and there is no device register for stating so.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 76ce4c2e587b..aa65f227c80d 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -90,6 +90,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err2;
>  	}
>  
> +	/* We do not have the register about media status. Hardware design
> +	 * implies it is ready.
> +	 */
> +	cxl_set_media_ready(cxl->cxlds);
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> -- 
> 2.17.1
> 
> 

