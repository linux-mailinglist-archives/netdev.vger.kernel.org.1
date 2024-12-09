Return-Path: <netdev+bounces-150299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB479E9D2E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DAB1886DAC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5C14D439;
	Mon,  9 Dec 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYOa4n3x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72A233151;
	Mon,  9 Dec 2024 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765996; cv=none; b=alc8Gc3ZmIexJybEwOOUFTl9rYsnhD79FttGxPKqWkZpQbTLh+nLJ1hYO4Pqc6mgp3V/WAlJEHIHeAJxgfCADUeV2DI7jzjqEJ+s7dy/F36kcchg5U85oKDPKcoNQ7PX2/bGDofxcz6ByVh0LyNDqDfLJl4xrbOXLEhmw5nvquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765996; c=relaxed/simple;
	bh=JUO3i9BiZsfv6aLYbkNAHlyPEoTrCJQmBloQh+fyl7o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm/9Oq4svKc2fYfzAdrPrxOO9kqwALhX38nIRrHCyM3NXhjGJ6DvTgWN+S8EnCVz8TCEJvlz331grGl+CNIUkPKWV7z3TwNfvh1lzLeCCMJMjdkGuoymRIu31pyc67IdyGDnOFDpeWIPge2y3XsbsKhDdIeMPMDUvKoinfbuIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYOa4n3x; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b662090so12155565ad.1;
        Mon, 09 Dec 2024 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733765995; x=1734370795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=23+EQ26ggORVwj2Hkygu02oSXs5qJRg7jADqCgmz4uQ=;
        b=dYOa4n3xTPds2uK+JPyuFIAJdIGW2C+HN5e3ed3u0j8Nk678V8V6+nG/D4wFAwF5gN
         shYPw6kkPe/ISkabPOhAFbYFFLSsjhcdgvNE/sNLDh43MqsqleFZ6ordEWi1Z7ubGhR/
         h/Mt2TXETXg7QdOWNDTLi/nEOO1KCRWn/qkDhIdCbl61H/YYwSesYpseBv4foGPYqJuQ
         /eYW1/SeIvvZJM2JRa4hUdY1DY21C+1vkIfAQDAPwxKWqVgB3faEIusfuWmt89b/cy9c
         aGSa1HK/6dWb3t6w5TJtzCCXbkqe3+KUe0fNvNQVaKe0A1RqKrsJUeM875dtDJH+RDbr
         pRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733765995; x=1734370795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23+EQ26ggORVwj2Hkygu02oSXs5qJRg7jADqCgmz4uQ=;
        b=lKLN+eXI6zGyAWxx/dsz54LoX4tFKlldzeA4QVKKvUl9xGgaOyZjLZn9dAi+2fIZx0
         VawqjvgLeBMmAUTIC30c7moWPh/bPK6p7qamO2a2ZTNIgBZ2e+GEzu6AZw2pR5jK3cI3
         +Mrh0icmlxIdAz64cUJczgyNSwLr28HylYXDDIdCtU/u4I3hPORbswt3T5fkIX02CQ7d
         zCuBxukH1GGBBZfGQMbx46/SXobJ6RUmIu7iwTUBEP0pZ2NXZ/0jc1KWWzNZVf3tFsFV
         j9h39hv0zHEKnKBU8KssDIMJlTDDHLtnE8FFqbnH4lOfYgt7fs/dSSdxjN4JV2ROZECg
         7u9g==
X-Forwarded-Encrypted: i=1; AJvYcCUhTI/JcAZMsLNrpuxt5Ae60AKOz/5d7LqnUAN8yyVY/6YeY+CBvqPD3oSHRQGREQUu6As5iOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddKkarRe6SDay8cbZWvBksRlQLVxPBjcNy5MhNs7p1P66Chq9
	AqFm0ryJBeZwZo/84NJww6+Azc1CSB6UowoylMnmOqDRN5N1wXMA
X-Gm-Gg: ASbGncsQsc6TYdWnz3GM7Pp33Fbd47kzFEHn49DJ4AFwDOBKBKQFYCZNOvc5vrDJVlP
	o7+bCCtm3oE+jKCNlpciZPcWvryD67d/PkOkK7uvYiFf03rfuP0FFhZ7MHBDfE79E4VY3bqHW8c
	0tgf/sDr/Q0d0b1MaZvnAvGBj1kVEP3fYykL2k6vrca5VZx1kai1CESlJSeOx3TcfHXfVxfehvV
	WoLRaD5fzt6Z2X++CbJHdV6rcE1H6KRDdauKM2RWaUtv3I5Avuybw==
X-Google-Smtp-Source: AGHT+IFt0b41XSdONzoY/AFdvkkf7EEMS28wwwvZpp3g70j+q7/jOqblpmwt7KKtlNw5y1yme4fgqw==
X-Received: by 2002:a17:903:249:b0:215:89a0:416f with SMTP id d9443c01a7336-21614d767b4mr206512185ad.30.1733765994669;
        Mon, 09 Dec 2024 09:39:54 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e6042dsm75149445ad.87.2024.12.09.09.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:39:54 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 9 Dec 2024 17:39:51 +0000
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 18/28] sfc: get endpoint decoder
Message-ID: <Z1crZ9QLkK1zd0MF@smc-140338-bm01>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-19-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-19-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:12PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 79b93d92f9c2..6ca23874d0c7 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR_OR_NULL(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxlrd);
> +		goto err3;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -136,6 +144,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);
>  		kfree(probe_data->cxl);
> -- 
> 2.17.1
> 

-- 
Fan Ni (From gmail)

