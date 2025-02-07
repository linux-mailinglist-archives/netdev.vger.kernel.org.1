Return-Path: <netdev+bounces-163963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC75A2C30B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5EA3A5419
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2B1E5B6C;
	Fri,  7 Feb 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/YmRpKk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0260E1EEA23;
	Fri,  7 Feb 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932531; cv=none; b=L+2E4U05w52TohFfoNMf/IN1UM9FCzEpfTB7Vrn2REGLvLKLjFafKdGiRosEZAylY1EvsGO6V/dTbD1ZR1rY7Nl/qD2j+gkfGo3axzmyxZMVjhxqCcw0xn/gQI7hZGM/CddevJQT3xlUjfHT4ZOn0RZtWT/N0qh8Ki6qek/MASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932531; c=relaxed/simple;
	bh=cbnM/hFYZBWaVD8aHqo1kem1unmaTy7lG37mTqILvVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOQDi1hmdO5OCAflTszg6Tog9C2ZqtNcu7rUFqsywa04OVPHyWbXDyvJVNaqnIOAxgVwmToM3eJT3RBnqTCCIJF87XUKKKfhBWQqMZAx1PYiGhEfM8/P717wW25h0tu2TehcANseuGA0rQNwnSv+mf/jXUuQt4GPQXbIg5dWpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/YmRpKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83804C4CED1;
	Fri,  7 Feb 2025 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738932530;
	bh=cbnM/hFYZBWaVD8aHqo1kem1unmaTy7lG37mTqILvVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/YmRpKktFYjANUL/NDH7zi7MtNPTiA3LpDBhmDsN9YpUZnG9xO00NT9S3yusrrTX
	 Up7MFwjdabITV7kBh+e+wQ1lRLFAtNuhIqyBewdZJaKeC04/n7mMNsGO5Wu53uAEB8
	 TMDailWpdqqDK0eMYjJPfdeQZl21TuOYDj+bgAb+xBVOj2oQvCnecphRpdK5mG2Fot
	 YswkVZnMiMDPBIp2/WimTdVyYOlRMJJ1b2s1bgIV36szzBZBjU51np/Y85C75HN3TW
	 tGKoeZTPEoP0IvRD2HAVEvL7gt7gLZ+ql2xUuimnT48Q3uElt16CYbg737jA1Q/KU3
	 AZVqSPl/wosyQ==
Date: Fri, 7 Feb 2025 12:48:46 +0000
From: Simon Horman <horms@kernel.org>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 02/26] sfc: add basic cxl initialization
Message-ID: <20250207124846.GP554665@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-3-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-3-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:26PM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a cxl_memdev_state with CXL_DEVTYPE_DEVMEM, aka CXL Type2 memory
> device.
> 
> Make sfc CXL initialization dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

...

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..69feffd4aec3
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#include <cxl/pci.h>
> +#include <cxl/cxl.h>
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	u16 dvsec;
> +
> +	probe_data->cxl_pio_initialised = false;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	cxl->cxlmds = cxl_memdev_state_create(&pci_dev->dev, pci_dev->dev.id,
> +					      dvsec, CXL_DEVTYPE_DEVMEM);
> +
> +	if (IS_ERR(cxl->cxlmds)) {
> +		kfree(cxl);

Hi Alejandro,

cxl is freed on the line above but dereferenced on the line below.

> +		return PTR_ERR(cxl->cxlmds);
> +	}
> +
> +	probe_data->cxl = cxl;
> +
> +	return 0;
> +}

...

