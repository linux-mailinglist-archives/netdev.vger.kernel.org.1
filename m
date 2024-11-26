Return-Path: <netdev+bounces-147488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675049D9D1D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014D6161CB7
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB171DC05F;
	Tue, 26 Nov 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUO7QwRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FF11187;
	Tue, 26 Nov 2024 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644500; cv=none; b=aK5TD93yIJIQS/RisP0UX43Xm6U5gp2CX/22w+cPcsb6MRik5bsEpgvN0+3jP2+iBu4opPSWodElYo/EznMl7S5JbXFufVfR6s6v5pasaztqnly1rOLDFcLQKgoYcKAxPtqgaPgzKftT5fyYwtW+FW/huzCR61vRLy26GrSIf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644500; c=relaxed/simple;
	bh=uTpMIG27nq9/n0AhWOmqsVR8DfXN0z+SeDYIP/jNcQ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSJnVdufnERa6361kx49Os3QRXuDqCW15WcO3kP8IaVz9Ld4swE9dwQPiOeL+AzusYnyr9I3onPxp9Z2OMjZBZAXJuMaNnSkhwytPk6Og3a/5n/FM2S3Onuaf3KmeFGPVBTHe+cLz5qM+ZydN9UaoBLSMKtdNulqK1SKKK6wLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUO7QwRp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2124a86f4cbso53028825ad.3;
        Tue, 26 Nov 2024 10:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732644498; x=1733249298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0FWcA0PLr8/Ei0bdAEOBOvGFwy/TKJtGRmS0UhbD/g=;
        b=hUO7QwRpSApzqMAFhdzQBVCk+oaSQqZW6ZHjuMcdgYNqWnxI9Gmmg8HUBL+gDYmrKV
         NgHuUK2v/eqf3E1/aCUfafrQxNPosvt2xvs6MBbuuIZd3gfut/CtlKJ8lqWSJ/ajUEbW
         Ug9jNWgfbTxK4Ev9ZDUoKCe1BNHlchP9kuSRmPhF0uNMPwQQhWH7h26lgFIklPZFKrXB
         mn45nEWiSLPXbrth7bqRP0th6icVJYS1EdEQUINwKM8ThwrF6IxPyO7qPKXDHVUOZX9F
         rkkI/xV3n6+fCcjZbjnliS/vyCGWVJW0fuqb27O2sv/FeTN139kg4ApAlZs571uWwZCu
         0QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644498; x=1733249298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0FWcA0PLr8/Ei0bdAEOBOvGFwy/TKJtGRmS0UhbD/g=;
        b=n7yXp3oSSK0zmFgkPXeD2uTDWapg325PAUx35/FCfZ5vNQH+tp6mfjJdEvGnI/NBkG
         V+kG6vzSzhDIuTbUjQC5uAyUsi1uFar73C3yNJGvlzDr6lfLsys867ZIoOH0K2QTZEXD
         HjiMzd1UiHaPQOpEM0hp9qvPgE5mXRpvv5C6PdKELBcob9RdPKMWdyzOejg1TN9EKTLZ
         42dVHeDITvRBc85aY65nW6I7Cl/SJJ1CWVUEEtxE+JTatSbeIfzd8Kq4EeQyO7MI+NAl
         cff365urVSM0peggMxXeNY7Uf/a3aNaHem7QDEsqsgjePcy9nkBockBJ7aTeNMxKM+Xw
         1Rsw==
X-Forwarded-Encrypted: i=1; AJvYcCUYLQidSn2mVdRGNv/s1UqQtTbsL7wn7tYCpn6IuOH7SmtaIii+u/I4nKkPAWv00Bkr5IVWHjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtUgtF6gw57XYGmKSC5mWh3tmYVcLsTXbVdiHqDyFBeRTNHys
	zwgfkipiiu0pQUWFKKAW7UuxxdBF576Pho+Tj8JTyYpfZlu0/xf4
X-Gm-Gg: ASbGnctuJUgWA/wVYovRlwTzYlqQ2LHDRSqScFWSNHt9wQtJjBTUceWbByDrZXkp7c9
	GAQYjZnTboPHaQ2TIF5mFZE1Ei0ZNV+hc74E7XQMAgGW3lQ8gz8Gfk2ESNgcq54pmMM1KF/duAv
	Ngzz/xxI9v7cjqRJIheRnGK8+R1ExvBy2oI7cceepnLq1VKaR/ISTmBZKOwXj22X42yKRE6n3Wq
	2ohCE+orIxG+GUbHC4oG4p+UHWqdWla9175FPzEw2HS89Kulfv5kA==
X-Google-Smtp-Source: AGHT+IFHCCb0CwjOQeLSqtQ6Dg2s1ly9mGQTKmORcEGHvb+6F+KOYQLWA2rByQ3x0T4aPdtxp5MzgA==
X-Received: by 2002:a17:902:e5cd:b0:211:eb15:9b6c with SMTP id d9443c01a7336-21501e6ce57mr1166025ad.57.1732644497682;
        Tue, 26 Nov 2024 10:08:17 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de456436sm8715042b3a.38.2024.11.26.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:08:17 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 26 Nov 2024 18:08:14 +0000
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v5 02/27] sfc: add cxl support using new CXL API
Message-ID: <Z0YOju3FaSSCJRRr@smc-140338-bm01>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-3-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118164434.7551-3-alejandro.lucero-palau@amd.com>

On Mon, Nov 18, 2024 at 04:44:09PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependable on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  7 +++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 24 +++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 88 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++
>  6 files changed, 157 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
...
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
> +		rc = -EINVAL;
> +		goto err2;
> +	}
> +
> +	probe_data->cxl = cxl;
> +
> +	return 0;
> +
> +err2:
> +	kfree(cxl->cxlds);
> +err1:
> +	kfree(cxl);
> +	return rc;
> +
Unwanted blank line here.

Fan
> +}
> +
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{
> +	if (probe_data->cxl) {
> +		kfree(probe_data->cxl->cxlds);
> +		kfree(probe_data->cxl);
> +	}
> +}
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..90fa46bc94db
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef EFX_CXL_H
> +#define EFX_CXL_H
> +
> +struct efx_nic;
> +
> +struct efx_cxl {
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data);
> +void efx_cxl_exit(struct efx_probe_data *probe_data);
> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index b85c51cbe7f9..efc6d90380b9 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1160,14 +1160,24 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects
> + * @cxl_pio_initialised: cxl initialization outcome.
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +	bool cxl_pio_initialised;
> +#endif
>  };
>  
>  static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
> -- 
> 2.17.1
> 

-- 
Fan Ni (From gmail)

