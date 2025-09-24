Return-Path: <netdev+bounces-226114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37A6B9C5C9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9892E4465
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 22:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494D28A704;
	Wed, 24 Sep 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzJrlLhi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6F27B4E8
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753123; cv=none; b=WbwO3z0euznORtrRJ0kvAAzlmyQECTIJgTns621T5H1sO5K7Ewi9osDwFXi7v+vE+eN/UrJukh7SXwap5yHMDaV9UZ+zmYFUZcp5U0MpZ3lHVDhvB1suBgedwcBhKOZEA7q8Kvip9mB3Zbf9Bq53gi1+lWAazpvn70/pKJFc/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753123; c=relaxed/simple;
	bh=cT6oNBp8/7IFqr2aUEVAHaBua3aX8Se9Xch61lrDVX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4MZUAWAj6DmxREYoGpgFWYDB8/Kq7oXl0MRDIhUxYGUdARYLRSL+kaHkKLq+ufWOrXo9MnF4/HHQPLSDOFJZscyYbzZ+XHcdJvF5BoFC6Lw7i5aoaK1SN3d5iXJxKiPgLnY2rqDWnbt12mITUsQjUKndqwUoskOn3UceTrmAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzJrlLhi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758753122; x=1790289122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cT6oNBp8/7IFqr2aUEVAHaBua3aX8Se9Xch61lrDVX4=;
  b=HzJrlLhiPENOvKGauAd+GvrtA18Zoza6O/oPx7vg57IcR13fUy6Tl0hG
   G/Y+oPprGA9m8gnpsIkllWAtpWMEc+j/rqh1TG+UlD8/shGI7XGZOfr4y
   c11hVW6k8oPfVdbx+BnOn0D45m2FY/73tO8/DIyTrV+doVuIW3wOI20y2
   Hanf9Z/PMYZos6GCKMIN0n1dR01qHci2/gBgraffPdJTV8OIzftGsyCo3
   svMtpBE1DywVeqjKxbgDIle7M6zTGVW9XhSDrK77qWGgjiVYhwmXnNH07
   k35XU6De0XTaeO5qiOUtChVIuQAoYeiimmNbRBXlJZ7hRAuPPClhz5cfk
   A==;
X-CSE-ConnectionGUID: cj7O62EPTMqbOLoYJ2Nt/g==
X-CSE-MsgGUID: liWuUUS9TYWiEpViQ89A4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61230583"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61230583"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:32:01 -0700
X-CSE-ConnectionGUID: c6FSmw8FQ5arNvM5PiVEkQ==
X-CSE-MsgGUID: 9IlraFBcR+yRs3FMY0YGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176754285"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:31:59 -0700
Message-ID: <548092f9-74b0-4b10-8db0-aeb2f6c96dcd@intel.com>
Date: Wed, 24 Sep 2025 15:31:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/6] bnxt_fwctl: Add bnxt fwctl device
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, jgg@ziepe.ca,
 michael.chan@broadcom.com
Cc: saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
 corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-6-pavan.chebbi@broadcom.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250923095825.901529-6-pavan.chebbi@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/25 2:58 AM, Pavan Chebbi wrote:
> Create bnxt_fwctl device. This will bind to bnxt's aux device.
> On the upper edge, it will register with the fwctl subsystem.
> It will make use of bnxt's ULP functions to send FW commands.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>  MAINTAINERS                 |   6 +
>  drivers/fwctl/Kconfig       |  11 ++
>  drivers/fwctl/Makefile      |   1 +
>  drivers/fwctl/bnxt/Makefile |   4 +
>  drivers/fwctl/bnxt/main.c   | 297 ++++++++++++++++++++++++++++++++++++
>  include/uapi/fwctl/bnxt.h   |  63 ++++++++
>  include/uapi/fwctl/fwctl.h  |   1 +
>  7 files changed, 383 insertions(+)
>  create mode 100644 drivers/fwctl/bnxt/Makefile
>  create mode 100644 drivers/fwctl/bnxt/main.c
>  create mode 100644 include/uapi/fwctl/bnxt.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8a770714101..8954da3e9203 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10115,6 +10115,12 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/fwctl/pds/
>  
> +FWCTL BNXT DRIVER
> +M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/fwctl/bnxt/
> +
>  GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index b5583b12a011..203b6ebb06fc 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -29,5 +29,16 @@ config FWCTL_PDS
>  	  to access the debug and configuration information of the AMD/Pensando
>  	  DSC hardware family.
>  
> +	  If you don't know what to do here, say N.
> +
> +config FWCTL_BNXT
> +	tristate "bnxt control fwctl driver"
> +	depends on BNXT
> +	help
> +	  BNXT provides interface for the user process to access the debug and
> +	  configuration registers of the Broadcom NIC hardware family
> +	  This will allow configuration and debug tools to work out of the box on
> +	  mainstream kernel.
> +
>  	  If you don't know what to do here, say N.
>  endif
> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
> index c093b5f661d6..fdd46f3a0e4e 100644
> --- a/drivers/fwctl/Makefile
> +++ b/drivers/fwctl/Makefile
> @@ -2,5 +2,6 @@
>  obj-$(CONFIG_FWCTL) += fwctl.o
>  obj-$(CONFIG_FWCTL_MLX5) += mlx5/
>  obj-$(CONFIG_FWCTL_PDS) += pds/
> +obj-$(CONFIG_FWCTL_BNXT) += bnxt/
>  
>  fwctl-y += main.o
> diff --git a/drivers/fwctl/bnxt/Makefile b/drivers/fwctl/bnxt/Makefile
> new file mode 100644
> index 000000000000..b47172761f1e
> --- /dev/null
> +++ b/drivers/fwctl/bnxt/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_FWCTL_BNXT) += bnxt_fwctl.o
> +
> +bnxt_fwctl-y += main.o
> diff --git a/drivers/fwctl/bnxt/main.c b/drivers/fwctl/bnxt/main.c
> new file mode 100644
> index 000000000000..1bec4567e35c
> --- /dev/null
> +++ b/drivers/fwctl/bnxt/main.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/fwctl.h>
> +#include <uapi/fwctl/fwctl.h>
> +#include <uapi/fwctl/bnxt.h>
> +#include <linux/bnxt/common.h>
> +#include <linux/bnxt/ulp.h>
> +
> +struct bnxtctl_uctx {
> +	struct fwctl_uctx uctx;
> +	u32 uctx_caps;
> +};
> +
> +struct bnxtctl_dev {
> +	struct fwctl_device fwctl;
> +	struct bnxt_aux_priv *aux_priv;
> +	void *dma_virt_addr[MAX_NUM_DMA_INDICATIONS];
> +	dma_addr_t dma_addr[MAX_NUM_DMA_INDICATIONS];
> +};
> +
> +DEFINE_FREE(bnxtctl, struct bnxtctl_dev *, if (_T) fwctl_put(&_T->fwctl))
> +
> +static int bnxtctl_open_uctx(struct fwctl_uctx *uctx)
> +{
> +	struct bnxtctl_uctx *bnxtctl_uctx =
> +		container_of(uctx, struct bnxtctl_uctx, uctx);
> +
> +	bnxtctl_uctx->uctx_caps = BIT(FWCTL_BNXT_QUERY_COMMANDS) |
> +				  BIT(FWCTL_BNXT_SEND_COMMAND);
> +	return 0;
> +}
> +
> +static void bnxtctl_close_uctx(struct fwctl_uctx *uctx)
> +{
> +}
> +
> +static void *bnxtctl_info(struct fwctl_uctx *uctx, size_t *length)
> +{
> +	struct bnxtctl_uctx *bnxtctl_uctx =
> +		container_of(uctx, struct bnxtctl_uctx, uctx);
> +	struct fwctl_info_bnxt *info;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->uctx_caps = bnxtctl_uctx->uctx_caps;
> +
> +	*length = sizeof(*info);
> +	return info;
> +}
> +
> +static bool bnxtctl_validate_rpc(struct bnxt_en_dev *edev,
> +				 struct bnxt_fw_msg *hwrm_in)
> +{
> +	struct input *req = (struct input *)hwrm_in->msg;
> +
> +	mutex_lock(&edev->en_dev_lock);
> +	if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED) {
> +		mutex_unlock(&edev->en_dev_lock);
> +		return false;
> +	}
> +	mutex_unlock(&edev->en_dev_lock);
> +
> +	if (le16_to_cpu(req->req_type) <= HWRM_LAST)
> +		return true;
> +
> +	return false;

guard(mutex)(&edev->en_dev_lock);
if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED)
	return false;

return le16_to_cpu(req->req_type) <= HWRM_LAST;


> +}
> +
> +static int bnxt_fw_setup_input_dma(struct bnxtctl_dev *bnxt_dev,
> +				   struct device *dev,
> +				   int num_dma,
> +				   struct fwctl_dma_info_bnxt *msg,
> +				   struct bnxt_fw_msg *fw_msg)
> +{
> +	u8 i, num_allocated = 0;
> +	void *dma_ptr;
> +	int rc = 0;
> +
> +	for (i = 0; i < num_dma; i++) {
> +		if (msg->len == 0 || msg->len > MAX_DMA_MEM_SIZE) {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		bnxt_dev->dma_virt_addr[i] = dma_alloc_coherent(dev->parent,
> +								msg->len,
> +								&bnxt_dev->dma_addr[i],
> +								GFP_KERNEL);
> +		if (!bnxt_dev->dma_virt_addr[i]) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		num_allocated++;
> +		if (!(msg->read_from_device)) {

unnecessary () around msg->read_from_device?

> +			if (copy_from_user(bnxt_dev->dma_virt_addr[i],
> +					   u64_to_user_ptr(msg->data),
> +					   msg->len)) {
> +				rc = -EFAULT;
> +				goto err;
> +			}
> +		}
> +		dma_ptr = fw_msg->msg + msg->offset;
> +
> +		if ((PTR_ALIGN(dma_ptr, 8) == dma_ptr) &&
> +		    msg->offset < fw_msg->msg_len) {
> +			__le64 *dmap = dma_ptr;
> +
> +			*dmap = cpu_to_le64(bnxt_dev->dma_addr[i]);
> +		} else {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		msg += 1;
> +	}
> +
> +	return rc;

return 0 should be ok?

> +err:
> +	for (i = 0; i < num_allocated; i++)
> +		dma_free_coherent(dev->parent,
> +				  msg->len,
> +				  bnxt_dev->dma_virt_addr[i],
> +				  bnxt_dev->dma_addr[i]);
> +
> +	return rc;
> +}
> +
> +static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
> +			    enum fwctl_rpc_scope scope,
> +			    void *in, size_t in_len, size_t *out_len)
> +{
> +	struct bnxtctl_dev *bnxtctl =
> +		container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
> +	struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
> +	struct fwctl_dma_info_bnxt *dma_buf = NULL;
> +	struct device *dev = &uctx->fwctl->dev;
> +	struct fwctl_rpc_bnxt *msg = in;
> +	struct bnxt_fw_msg rpc_in;
> +	int i, rc, err = 0;
> +	int dma_buf_size;
> +
> +	rpc_in.msg = kzalloc(msg->req_len, GFP_KERNEL);

I think if you use __free(kfree) for all the allocations in the function, you can be rid of the gotos.

> +	if (!rpc_in.msg) {
> +		err = -ENOMEM;
> +		goto err_out;

nothing to free here, no need to go to err_out

> +	}
> +	if (copy_from_user(rpc_in.msg, u64_to_user_ptr(msg->req),
> +			   msg->req_len)) {
> +		dev_dbg(dev, "Failed to copy in_payload from user\n");
> +		err = -EFAULT;
> +		goto err_out;
> +	}
> +
> +	if (!bnxtctl_validate_rpc(bnxt_aux_priv->edev, &rpc_in))
> +		return ERR_PTR(-EPERM);
> +
> +	rpc_in.msg_len = msg->req_len;
> +	rpc_in.resp = kzalloc(*out_len, GFP_KERNEL);

I think you missed freeing this buffer on error later on. __free() should help you avoid that.

> +	if (!rpc_in.resp) {
> +		err = -ENOMEM;
> +		goto err_out;

calling kfree(dma_buf) when unnecessary
> +	}
> +
> +	rpc_in.resp_max_len = *out_len;
> +	if (!msg->timeout)
> +		rpc_in.timeout = DFLT_HWRM_CMD_TIMEOUT;
> +	else
> +		rpc_in.timeout = msg->timeout;
> +
> +	if (msg->num_dma) {
> +		if (msg->num_dma > MAX_NUM_DMA_INDICATIONS) {
> +			dev_err(dev, "DMA buffers exceed the number supported\n");
> +			err = -EINVAL;
> +			goto err_out;
calling kfree(dma_buf) when unnecessary
> +		}
> +		dma_buf_size = msg->num_dma * sizeof(*dma_buf);
> +		dma_buf = kzalloc(dma_buf_size, GFP_KERNEL);
> +		if (!dma_buf) {
> +			dev_err(dev, "Failed to allocate dma buffers\n");
> +			err = -ENOMEM;
> +			goto err_out;
calling kfree(dma_buf) when unnecessary
> +		}
> +
> +		if (copy_from_user(dma_buf, u64_to_user_ptr(msg->payload),
> +				   dma_buf_size)) {
> +			dev_dbg(dev, "Failed to copy payload from user\n");
> +			err = -EFAULT;
> +			goto err_out;
> +		}
> +
> +		rc = bnxt_fw_setup_input_dma(bnxtctl, dev, msg->num_dma,
> +					     dma_buf, &rpc_in);
> +		if (rc) {
> +			err = -EIO;
> +			goto err_out;
> +		}
> +	}
> +
> +	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
> +	if (rc) {
> +		err = -EIO;
> +		goto err_out;

Do all the DMA buffers allocated from bnxt_fw_setup_input_dma() need to be freed here? Maybe DEFINE_FREE() a macro for bnxt_fw_setup_input_dma() might help since you are freeing everything at the end of the function anyways. 

> +	}
> +
> +	for (i = 0; i < msg->num_dma; i++) {
> +		if (dma_buf[i].read_from_device) {
> +			if (copy_to_user(u64_to_user_ptr(dma_buf[i].data),
> +					 bnxtctl->dma_virt_addr[i],
> +					 dma_buf[i].len)) {
> +				dev_dbg(dev, "Failed to copy resp to user\n");
> +				err = -EFAULT;
should we break out of this loop on error?

> +			}
> +		}
> +	}
> +	for (i = 0; i < msg->num_dma; i++)
> +		dma_free_coherent(dev->parent, dma_buf[i].len,
> +				  bnxtctl->dma_virt_addr[i],
> +				  bnxtctl->dma_addr[i]);
> +
> +err_out:
> +	kfree(dma_buf);
> +	kfree(rpc_in.msg);
> +
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return rpc_in.resp;
> +}
> +
> +static const struct fwctl_ops bnxtctl_ops = {
> +	.device_type = FWCTL_DEVICE_TYPE_BNXT,
> +	.uctx_size = sizeof(struct bnxtctl_uctx),
> +	.open_uctx = bnxtctl_open_uctx,
> +	.close_uctx = bnxtctl_close_uctx,
> +	.info = bnxtctl_info,
> +	.fw_rpc = bnxtctl_fw_rpc,
> +};
> +
> +static int bnxtctl_probe(struct auxiliary_device *adev,
> +			 const struct auxiliary_device_id *id)
> +{
> +	struct bnxt_aux_priv *aux_priv =
> +		container_of(adev, struct bnxt_aux_priv, aux_dev);
> +	struct bnxtctl_dev *bnxtctl __free(bnxtctl) =
> +		fwctl_alloc_device(&aux_priv->edev->pdev->dev, &bnxtctl_ops,
> +				   struct bnxtctl_dev, fwctl);
> +	int rc;
> +
> +	if (!bnxtctl)
> +		return -ENOMEM;
> +
> +	bnxtctl->aux_priv = aux_priv;
> +
> +	rc = fwctl_register(&bnxtctl->fwctl);
> +	if (rc)
> +		return rc;
> +
> +	auxiliary_set_drvdata(adev, no_free_ptr(bnxtctl));
> +	return 0;
> +}
> +
> +static void bnxtctl_remove(struct auxiliary_device *adev)
> +{
> +	struct bnxtctl_dev *ctldev = auxiliary_get_drvdata(adev);
> +
> +	fwctl_unregister(&ctldev->fwctl);
> +	fwctl_put(&ctldev->fwctl);
> +}
> +
> +static const struct auxiliary_device_id bnxtctl_id_table[] = {
> +	{ .name = "bnxt_en.fwctl", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(auxiliary, bnxtctl_id_table);
> +
> +static struct auxiliary_driver bnxtctl_driver = {
> +	.name = "bnxt_fwctl",
> +	.probe = bnxtctl_probe,
> +	.remove = bnxtctl_remove,
> +	.id_table = bnxtctl_id_table,
> +};
> +
> +module_auxiliary_driver(bnxtctl_driver);
> +
> +MODULE_IMPORT_NS("FWCTL");
> +MODULE_DESCRIPTION("BNXT fwctl driver");
> +MODULE_AUTHOR("Pavan Chebbi <pavan.chebbi@broadcom.com>");
> +MODULE_AUTHOR("Andy Gospodarek <gospo@broadcom.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/fwctl/bnxt.h b/include/uapi/fwctl/bnxt.h
> new file mode 100644
> index 000000000000..cf8f2b80f3de
> --- /dev/null
> +++ b/include/uapi/fwctl/bnxt.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + *
> + */
> +
> +#ifndef _UAPI_FWCTL_BNXT_H_
> +#define _UAPI_FWCTL_BNXT_H_
> +
> +#include <linux/types.h>
> +
> +#define MAX_DMA_MEM_SIZE		0x10000 /*64K*/
> +#define DFLT_HWRM_CMD_TIMEOUT		500
> +
> +enum fwctl_bnxt_commands {
> +	FWCTL_BNXT_QUERY_COMMANDS = 0,
> +	FWCTL_BNXT_SEND_COMMAND,
> +};
> +
> +/**
> + * struct fwctl_info_bnxt - ioctl(FWCTL_INFO) out_device_data
> + * @uctx_caps: The command capabilities driver accepts.
> + *
> + * Return basic information about the FW interface available.
> + */
> +struct fwctl_info_bnxt {
> +	__u32 uctx_caps;
> +};
> +
> +#define MAX_NUM_DMA_INDICATIONS 10
> +
> +/**
> + * struct fwctl_dma_info_bnxt - describe the buffer that should be DMAed
> + * @data: DMA-intended buffer
> + * @len: length of the @data
> + * @offset: offset at which FW (HWRM) input structure needs DMA address
> + * @read_from_device: DMA direction, 0 or 1
> + * @unused: pad
> + */
> +struct fwctl_dma_info_bnxt {
> +	__aligned_u64 data;
> +	__u32 len;
> +	__u16 offset;
> +	__u8 read_from_device;

variable name doesn't convey writing to device on value of 1. Maybe 'dma_direction'? Also create enum or define for DEVICE_READ and DEVICE_WRITE so it's obvoius when setting or checking the variable. Although you can always use 'enum dma_data_direction' if you don't mind changing the values.

> +	__u8 unused;
> +};
> +
> +/**
> + * struct fwctl_rpc_bnxt - describe the fwctl message for bnxt
> + * @req: FW (HWRM) command input structure
> + * @req_len: length of @req
> + * @timeout: if the user wants to override the driver's default, 0 otherwise
> + * @num_dma: number of DMA buffers to be added to @req
> + * @payload: DMA buffer details in struct fwctl_dma_info_bnxt format
> + */
> +struct fwctl_rpc_bnxt {
> +	__aligned_u64 req;
> +	__u32 req_len;
> +	__u32 timeout;
> +	__u32 num_dma;
> +	__aligned_u64 payload;
> +};
> +#endif
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 716ac0eee42d..2d6d4049c205 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -44,6 +44,7 @@ enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_ERROR = 0,
>  	FWCTL_DEVICE_TYPE_MLX5 = 1,
>  	FWCTL_DEVICE_TYPE_CXL = 2,
> +	FWCTL_DEVICE_TYPE_BNXT = 3,
>  	FWCTL_DEVICE_TYPE_PDS = 4,
>  };
>  


