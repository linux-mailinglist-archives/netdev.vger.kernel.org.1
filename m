Return-Path: <netdev+bounces-182812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28042A89F60
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3826C444769
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7A29A3D7;
	Tue, 15 Apr 2025 13:25:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78129A3CE;
	Tue, 15 Apr 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723520; cv=none; b=N3XwYZgdYJC/Qcqo/zsRCe7QBK8oQbi+SBOjujoL47dM7+cMhciciEyMWx8pxILn/jIEIdGSx8EMOOTvVthwKDpuzHOIvFJVAYyuMffyDz8FmLxqVmqXB0inJ1ec60/3GeFBz5EKQ+a9HPHZ4XrgIfogyKrYQTrRlbkjtQVKABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723520; c=relaxed/simple;
	bh=If28B3JjdxCFnpnc5LxmELzQzUJD8LU8DUALcTdrFz8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0CVYP34ntqddPsqLKI7Wx7lWmiAqK8VOSo0rOvvj+XHrHXLt7W7uVd1eHp3uRlTIIiPbgurq7eDydr/RWBaaYeMTmHSnUYT3Ad95/f9TG2C6TcWNuRDbURZJ+mVVq3/BNXRMTwfdO3VJ8hA9H7J4ccxbDhm0O4Vsr8dOumGqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcPtR3KzHz6K99P;
	Tue, 15 Apr 2025 21:21:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E069F140133;
	Tue, 15 Apr 2025 21:25:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 15:25:14 +0200
Date: Tue, 15 Apr 2025 14:25:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: Re: [PATCH v13 06/22] sfc: make regs setup with checking and set
 media ready
Message-ID: <20250415142512.00004edd@huawei.com>
In-Reply-To: <20250414151336.3852990-7-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
	<20250414151336.3852990-7-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Apr 2025 16:13:20 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Set media ready explicitly as there is no means for doing so without
> a mailbox and without the related cxl register, not mandatory for type2.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 753d5b7d49b6..885b46c6bd5a 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -21,8 +21,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);

Can do the = {} trick to avoid explicit clear below.

> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);

I'm not immediately able to find where found is initialized.

>  	struct efx_cxl *cxl;
>  	u16 dvsec;
> +	int rc;
>  
>  	probe_data->cxl_pio_initialised = false;
>  
> @@ -43,6 +46,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	if (!cxl)
>  		return -ENOMEM;
>  
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_RAS, expected);
> +
> +	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		return rc;
> +	}
> +
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (cxl_check_caps(pci_dev, expected, found))
> +		return -ENXIO;
> +
> +	/*
> +	 * Set media ready explicitly as there are neither mailbox for checking
> +	 * this state nor the CXL register involved, both no mandatory for

not mandatory

> +	 * type2.
> +	 */
> +	cxl->cxlds.media_ready = true;
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;


