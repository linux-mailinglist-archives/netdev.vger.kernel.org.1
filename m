Return-Path: <netdev+bounces-166057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D7BA3429D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88047A5890
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F323A98F;
	Thu, 13 Feb 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1fT0tNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF318221552
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457427; cv=none; b=nQuGVQEsci1dDHTdSO4BMsE7vvNmjyf3408TYHay+PSSBevEZk0I+sNC1/Iz1HKyfx8gWeBOmuxBWeucmx6JVreqjyWFFvE9ff6bRJ/a8T3c4ZL7Hxm5KuOIKCF7lREU04r9ZdzA398vblpyQBxIGm+pcdnxmyVoCXeEZjuTEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457427; c=relaxed/simple;
	bh=oO3CHfKpW6Oi/rSTeSXd/Q0m2FqUXJ3mReCxg8gF8fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXCVFLHgDMwpgNgOkJFFI7FNaAJuLK4lUmTqGYycUTpd3D+Iq2NXV5A5U5tXvzAoXqDOkedEYRK9LX0o3PwsXnAct+cvJNcF/9s8XW8Bdp7dQ07HdF/X5xfwah+Hyi8F974rDuQMJ+FsJ0pWuco33NsbD+Wg/5HNjZEZb5evncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1fT0tNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC02C4CED1;
	Thu, 13 Feb 2025 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457426;
	bh=oO3CHfKpW6Oi/rSTeSXd/Q0m2FqUXJ3mReCxg8gF8fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1fT0tNSkJfPIVvU9jzR93pDaEkJ0cV5acn9O+OrD4HdWXfcNJC/Y4AK9tgT3yfN3
	 GZ/+ocVjmFEQhcQLl6RVpLQGPNXGowXHCPAWz1zkN6vLxEUxeDTeaikW9/GKoU4ROY
	 SS8hSWSHgvEY00zmawje2/n+WFDKDt7O5W1gtB+uxPEshpckOzJ06Zozy1aXP8IY+G
	 57XyOLkDxF7EibOsIDj7m9MgtFaPqRDkXT2p2LCAeTj8mqn+NKbG4Z4T4ihjcxmpWI
	 cUBETUHTu2HErL0iRpjJGfHqGU1wjkN+bYNueLRvYe2WFps75HXVvTSeQvB8JM0VhZ
	 0uEYvTJl1QExw==
Date: Thu, 13 Feb 2025 16:37:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com, horms@kernel.org,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org
Subject: Re: [PATCH v4 07/14] net-next/yunsilicon: Init auxiliary device
Message-ID: <20250213143702.GN17863@unreal>
References: <20250213091402.2067626-1-tianx@yunsilicon.com>
 <20250213091418.2067626-8-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213091418.2067626-8-tianx@yunsilicon.com>

On Thu, Feb 13, 2025 at 05:14:19PM +0800, Xin Tian wrote:
> Initialize eth auxiliary device when pci probing
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> ---
>  .../ethernet/yunsilicon/xsc/common/xsc_core.h |  12 ++
>  .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
>  .../net/ethernet/yunsilicon/xsc/pci/adev.c    | 110 ++++++++++++++++++
>  .../net/ethernet/yunsilicon/xsc/pci/adev.h    |  14 +++
>  .../net/ethernet/yunsilicon/xsc/pci/main.c    |  10 ++
>  5 files changed, 148 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h

<...>

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
> new file mode 100644
> index 000000000..1f8f27d72
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/idr.h>
> +
> +#include "adev.h"
> +
> +static DEFINE_IDA(xsc_adev_ida);
> +
> +enum xsc_adev_idx {
> +	XSC_ADEV_IDX_ETH,
> +	XSC_ADEV_IDX_MAX
> +};
> +
> +static const char * const xsc_adev_name[] = {
> +	[XSC_ADEV_IDX_ETH] = XSC_ETH_ADEV_NAME,
> +};
> +
> +static void xsc_release_adev(struct device *dev)
> +{
> +	/* Doing nothing, but auxiliary bus requires a release function */
> +}

It is unlikely to be true in driver lifetime model. At least you should
free xsc_adev here.

Thanks

> +
> +static int xsc_reg_adev(struct xsc_core_device *xdev, int idx)
> +{
> +	struct auxiliary_device	*adev;
> +	struct xsc_adev *xsc_adev;
> +	int ret;
> +
> +	xsc_adev = kzalloc(sizeof(*xsc_adev), GFP_KERNEL);
> +	if (!xsc_adev)
> +		return -ENOMEM;
> +
> +	adev = &xsc_adev->adev;
> +	adev->name = xsc_adev_name[idx];
> +	adev->id = xdev->adev_id;
> +	adev->dev.parent = &xdev->pdev->dev;
> +	adev->dev.release = xsc_release_adev;
> +	xsc_adev->xdev = xdev;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret)
> +		goto err_free_adev;
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret)
> +		goto err_uninit_adev;
> +
> +	xdev->xsc_adev_list[idx] = xsc_adev;
> +
> +	return 0;
> +err_uninit_adev:
> +	auxiliary_device_uninit(adev);
> +err_free_adev:
> +	kfree(xsc_adev);
> +
> +	return ret;
> +}

