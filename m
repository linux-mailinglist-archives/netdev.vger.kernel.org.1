Return-Path: <netdev+bounces-154201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 432259FC0E8
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91D17A1A6D
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24519995A;
	Tue, 24 Dec 2024 17:24:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630B14D433;
	Tue, 24 Dec 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061045; cv=none; b=luVcOlayJ/t6V1W80akKqYdeHAw9Cmea88MUeIqy6xIZb35KSh/7iW/8Nwkg4jD0O/IU82dZr0BCPf/7D96KxL+k9ivSwmLq7waI4mQSPvqpfQe2Ox09co3jpwGvSxDRLmQ1qP8qDAAhrJLlBnPmu/1SBlLW4WgUPfhmq3e88Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061045; c=relaxed/simple;
	bh=c34q6M7o0HhNzbmGU7CqWGW08FDaarg1HnbSzyvOmeg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J85qen7Zuw3woG4cEAlERpY+j1n4dK53OIqHZyTX1oJvAscMUHzSON0GuKo46Uxl3WmqxZrKkZAmm+6frQ+DsOIo95H6XcqJ8egzj4MlVqMBCqknS/L0p480gz1IRPWLTiAP0hvKbNZlagUuoN1+6SeSU+pWYoo6Nw0VCgDuaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhZ56wxqz67SS7;
	Wed, 25 Dec 2024 01:23:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 38C3E140133;
	Wed, 25 Dec 2024 01:24:02 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:24:01 +0100
Date: Tue, 24 Dec 2024 17:23:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 07/27] sfc: use cxl api for regs setup and checking
Message-ID: <20241224172359.00002a2c@huawei.com>
In-Reply-To: <20241216161042.42108-8-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-8-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:22 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Similar comments to on the earlier bitmap manipulation.
It is simpler than you have here!

Jonathan

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 356d7a977e1c..d9a52343553a 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -21,6 +21,8 @@
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct pci_dev *pci_dev;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> @@ -65,6 +67,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_resource_set;
>  	}
>  
> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		goto err_resource_set;
> +	}
> +
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
set_bit()

> +	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
> +
> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
> +		pci_err(pci_dev,
> +			"CXL device capabilities found(%08lx) not as expected(%08lx)",

bitmap format strings, not dereferencing the unsigned longs.

> +			*found, *expected);
> +		rc = -EIO;
> +		goto err_resource_set;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;


