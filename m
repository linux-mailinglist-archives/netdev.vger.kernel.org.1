Return-Path: <netdev+bounces-42574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C17CF609
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DD5281EC6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD918AF4;
	Thu, 19 Oct 2023 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+7FsFNC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6728F79
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB0FC433C8;
	Thu, 19 Oct 2023 11:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697713394;
	bh=zY9cF8mbZRSxzjix0LhENXRdl/sBcy/WeskJlstFPKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+7FsFNCxcg0PwNeEFV1iEoTv+cPapHn4jdyrZJRLOPtT3gcdGjSxhwB35m2VWQ/N
	 iac4qyyV9dtzHn+cW79DxL3+6iM5ZooyCAJ7xkl+YlocgZVva1d6RbILXknc3yqNXO
	 ytm9P7jyw1FWa8ytlIA3j04oMGMrjNBv66rJxSsvNnVURz45fwnMrcaf7Wzp9BZyVK
	 o6yX4Hx3RfaFh7cWEJKEqpjiZX0skMj6IqUL5QHanzVRRElrMymp+3gTegzCchnFOw
	 GNHhQ04jYlAX61rZ4LaOk29hBeLKUce+4v5XD2EDFqDwyi+5KAuPlp46bwcfHjCqw5
	 M9emycO2doh1Q==
Date: Thu, 19 Oct 2023 13:03:10 +0200
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
	Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH net-next 2/2] amd-xgbe: Add support for AMD Crater
 ethernet device
Message-ID: <20231019110310.GB2100445@kernel.org>
References: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
 <20231018144450.2061125-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018144450.2061125-3-Raju.Rangoju@amd.com>

On Wed, Oct 18, 2023 at 08:14:50PM +0530, Raju Rangoju wrote:
> The AMD Crater device has new window settings for the XPCS access, add
> support to adopt to the new window settings. There is a hardware bug
> where in the BAR1 registers cannot be accessed directly. As a fallback
> mechanism, access these PCS registers through indirect access via SMN.
> 
> Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Hi Sudheesh,

some minor feedback from my side.

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++++
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 33 +++++++++++++++++----
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 32 +++++++++++++++-----
>  drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++++
>  4 files changed, 63 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> index 3b70f6737633..e1f70f0528ef 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> @@ -900,6 +900,11 @@
>  #define PCS_V2_RV_WINDOW_SELECT		0x1064
>  #define PCS_V2_YC_WINDOW_DEF		0x18060
>  #define PCS_V2_YC_WINDOW_SELECT		0x18064
> +#define PCS_V2_RN_WINDOW_DEF		0xF8078
> +#define PCS_V2_RN_WINDOW_SELECT		0xF807c
> +
> +#define PCS_RN_SMN_BASE_ADDR		0x11E00000
> +#define PCS_RN_PORT_ADDR_SIZE		0x100000
>  
>  /* PCS register entry bit positions and sizes */
>  #define PCS_V2_WINDOW_DEF_OFFSET_INDEX	6
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index f393228d41c7..da8ec218282f 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -1176,8 +1176,17 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>  	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>  
>  	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> -	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> -	mmd_data = XPCS16_IOREAD(pdata, offset);
> +	if (pdata->vdata->is_crater) {
> +		amd_smn_write(0,
> +			      (pdata->xphy_base + pdata->xpcs_window_sel_reg),
> +			      index);
> +		amd_smn_read(0, pdata->xphy_base + offset, &mmd_data);
> +		mmd_data = (offset % ALIGNMENT_VAL) ?
> +			   ((mmd_data >> 16) & 0xffff) : (mmd_data & 0xffff);

I wonder if it would be nice to use FIELD_GET() here...

> +	} else {
> +		XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> +		mmd_data = XPCS16_IOREAD(pdata, offset);
> +	}
>  	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>  
>  	return mmd_data;
> @@ -1186,8 +1195,8 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>  static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>  				   int mmd_reg, int mmd_data)
>  {
> +	unsigned int mmd_address, index, offset, crtr_mmd_data;
>  	unsigned long flags;
> -	unsigned int mmd_address, index, offset;
>  
>  	if (mmd_reg & XGBE_ADDR_C45)
>  		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> @@ -1208,8 +1217,22 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>  	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>  
>  	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> -	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> -	XPCS16_IOWRITE(pdata, offset, mmd_data);
> +	if (pdata->vdata->is_crater) {
> +		amd_smn_write(0, (pdata->xphy_base + pdata->xpcs_window_sel_reg), index);
> +		amd_smn_read(0, pdata->xphy_base + offset, &crtr_mmd_data);
> +		if (offset % ALIGNMENT_VAL) {
> +			crtr_mmd_data &= ~GENMASK(31, 16);
> +			crtr_mmd_data |=  (mmd_data << 16);
> +		} else {
> +			crtr_mmd_data &= ~GENMASK(15, 0);
> +			crtr_mmd_data |=  (mmd_data);
> +		}

... and FIELD_PREP() here.

> +		amd_smn_write(0, (pdata->xphy_base + pdata->xpcs_window_sel_reg), index);
> +		amd_smn_write(0, (pdata->xphy_base + offset), crtr_mmd_data);
> +	} else {
> +		XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> +		XPCS16_IOWRITE(pdata, offset, mmd_data);
> +	}
>  	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>  }
>  
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index a17359d43b45..90ad520d3c29 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -279,15 +279,21 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
>  		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
>  	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
> -		   (rdev->device == 0x14b5)) {
> -		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
> -		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
> -
> -		/* Yellow Carp devices do not need cdr workaround */
> +		   ((rdev->device == 0x14b5) || (rdev->device == 0x1630))) {
> +		/* Yellow Carp and Crater devices
> +		 * do not need cdr workaround and RRC
> +		 */
>  		pdata->vdata->an_cdr_workaround = 0;
> -
> -		/* Yellow Carp devices do not need rrc */
>  		pdata->vdata->enable_rrc = 0;
> +
> +		if (rdev->device == 0x1630) {

Not strictly related to this patch, but I am wondering if we could create
#defines for magic numbers like this one.

> +			pdata->xpcs_window_def_reg = PCS_V2_RN_WINDOW_DEF;
> +			pdata->xpcs_window_sel_reg = PCS_V2_RN_WINDOW_SELECT;
> +			pdata->vdata->is_crater = true;

Is 'is_crater' necessary?
pdata has a pointer to the pci_dev, AFAICT.

> +		} else {
> +			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
> +			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
> +		}
>  	} else {
>  		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
>  		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
> @@ -295,7 +301,17 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	pci_dev_put(rdev);
>  
>  	/* Configure the PCS indirect addressing support */
> -	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
> +	if (pdata->vdata->is_crater) {
> +		reg = XP_IOREAD(pdata, XP_PROP_0);
> +		pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
> +				   (PCS_RN_PORT_ADDR_SIZE *
> +				    XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
> +		if (netif_msg_probe(pdata))
> +			dev_dbg(dev, "xphy_base = %#08x\n", pdata->xphy_base);
> +		amd_smn_read(0, pdata->xphy_base + (pdata->xpcs_window_def_reg), &reg);
> +	} else {
> +		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
> +	}
>  	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
>  	pdata->xpcs_window <<= 6;
>  	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index ad136ed493ed..a161fac35643 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -133,6 +133,7 @@
>  #include <linux/dcache.h>
>  #include <linux/ethtool.h>
>  #include <linux/list.h>
> +#include <asm/amd_nb.h>
>  
>  #define XGBE_DRV_NAME		"amd-xgbe"
>  #define XGBE_DRV_DESC		"AMD 10 Gigabit Ethernet Driver"
> @@ -305,6 +306,9 @@
>  /* MDIO port types */
>  #define XGMAC_MAX_C22_PORT		3
>  
> + /* offset alignment */
> +#define ALIGNMENT_VAL			4
> +
>  /* Link mode bit operations */
>  #define XGBE_ZERO_SUP(_ls)		\
>  	ethtool_link_ksettings_zero_link_mode((_ls), supported)
> @@ -1046,6 +1050,7 @@ struct xgbe_version_data {
>  	unsigned int rx_desc_prefetch;
>  	unsigned int an_cdr_workaround;
>  	unsigned int enable_rrc;
> +	bool is_crater;
>  };
>  
>  struct xgbe_prv_data {
> @@ -1056,6 +1061,7 @@ struct xgbe_prv_data {
>  	struct device *dev;
>  	struct platform_device *phy_platdev;
>  	struct device *phy_dev;
> +	unsigned int xphy_base;
>  
>  	/* Version related data */
>  	struct xgbe_version_data *vdata;
> -- 
> 2.25.1
> 
> 

