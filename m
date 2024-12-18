Return-Path: <netdev+bounces-152866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4339F6102
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAECE188AC05
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C481A2384;
	Wed, 18 Dec 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IReszp0X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09A19F41D;
	Wed, 18 Dec 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512771; cv=none; b=j+HgfIMXLeRbmknyxqoRjcJHdYEXzBlBKxriuiP0Ad79o3XrKBHCPYd8B9AGqS2Foil/WzPi95p2pvQ7Xl8eWicAHS0VKQOL+2o0KoxwCInLO/225n9J3GyiaQ+JAmjWkGKOs2MmJciwCetG7SreJjBk8nFqO8qQFWFKJYNgg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512771; c=relaxed/simple;
	bh=RKs8g8cJXoiaW5GtQzdcafbnKZUBamyZjFRIr0xGmC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ4RjxlP51cEbBh/bvx80fnhJBgde6bVFLhgpMlqzxqFXErbJ9Uw6BsYvpoQkD4fTQEmUKLHLKBWGU5BJbEVSbEzr17k2bbjCLXr0Cscxs8cFCu5pvOkNvgc3c0rLtZ3W2pUw6LAQwTXIKXIgkFNynuPsYalWo6BSpi4oRu8KBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IReszp0X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734512769; x=1766048769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RKs8g8cJXoiaW5GtQzdcafbnKZUBamyZjFRIr0xGmC4=;
  b=IReszp0XpOzbaMVPGOEQgduCjz7jYla8aGcQEOFk6W1LHzmVAYjPiA0N
   ErwVQSFHkyl8pVgU3Rd27Qrihn6H5mAoVdjaec9iT6xGRXeNnIBMKcvCz
   NhGIXvvJMGgXjOuDvt+Ojr0hUlseUp38sVZPDsRZr7hl2w8VOHI+h8E9P
   MRKV8kUVCfNSG2pEUKOKHtmOmGHY6EWz1UW9jEklt2X2FTXPDH+HN4WSR
   ya1y1f3ECLEMT1bXJA4lw/5cLYfaDn76OJy0t0MfmD3XRIIw0Jj3bIj7Z
   XQCnuPVmTgs2u/ji/xwlfleBRrs038265jLdlRmeDAXKyLuWkosVzgKT3
   Q==;
X-CSE-ConnectionGUID: zgLu3coERL+UnuXsMt/XEQ==
X-CSE-MsgGUID: 2PpT0l0UTrmZ5CXHL9n3Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="45577421"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45577421"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:06:08 -0800
X-CSE-ConnectionGUID: mu4IrPtMQv6PP0L8+g4xMQ==
X-CSE-MsgGUID: MTjyH+A6QSeXjgV8IviAzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98267551"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:06:05 -0800
Date: Wed, 18 Dec 2024 10:02:59 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V2 net 1/7] net: hns3: fixed reset failure issues
 caused by the incorrect reset type
Message-ID: <Z2KPw9WYCI/SZIjg@mev-dev.igk.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217010839.1742227-2-shaojijie@huawei.com>

On Tue, Dec 17, 2024 at 09:08:33AM +0800, Jijie Shao wrote:
> From: Hao Lan <lanhao@huawei.com>
> 
> When a reset type that is not supported by the driver is input, a reset
> pending flag bit of the HNAE3_NONE_RESET type is generated in
> reset_pending. The driver does not have a mechanism to clear this type
> of error. As a result, the driver considers that the reset is not
> complete. This patch provides a mechanism to clear the
> HNAE3_NONE_RESET flag and the parameter of
> hnae3_ae_ops.set_default_reset_request is verified.
> 
> The error message:
> hns3 0000:39:01.0: cmd failed -16
> hns3 0000:39:01.0: hclge device re-init failed, VF is disabled!
> hns3 0000:39:01.0: failed to reset VF stack
> hns3 0000:39:01.0: failed to reset VF(4)
> hns3 0000:39:01.0: prepare reset(2) wait done
> hns3 0000:39:01.0 eth4: already uninitialized
> 
> Use the crash tool to view struct hclgevf_dev:
> struct hclgevf_dev {
> ...
> 	default_reset_request = 0x20,
> 	reset_level = HNAE3_NONE_RESET,
> 	reset_pending = 0x100,
> 	reset_type = HNAE3_NONE_RESET,
> ...
> };
> 
> Fixes: 720bd5837e37 ("net: hns3: add set_default_reset_request in the hnae3_ae_ops")
> Signed-off-by: Hao Lan <lanhao@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 33 ++++++++++++++--
>  .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 38 ++++++++++++++++---
>  2 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 05942fa78b11..7d44dc777dc5 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -3574,6 +3574,17 @@ static int hclge_set_vf_link_state(struct hnae3_handle *handle, int vf,
>  	return ret;
>  }
>  
> +static void hclge_set_reset_pending(struct hclge_dev *hdev,
> +				    enum hnae3_reset_type reset_type)
> +{
> +	/* When an incorrect reset type is executed, the get_reset_level
> +	 * function generates the HNAE3_NONE_RESET flag. As a result, this
> +	 * type do not need to pending.
> +	 */
> +	if (reset_type != HNAE3_NONE_RESET)
> +		set_bit(reset_type, &hdev->reset_pending);
> +}
> +
>  static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
>  {
>  	u32 cmdq_src_reg, msix_src_reg, hw_err_src_reg;
> @@ -3594,7 +3605,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
>  	 */
>  	if (BIT(HCLGE_VECTOR0_IMPRESET_INT_B) & msix_src_reg) {
>  		dev_info(&hdev->pdev->dev, "IMP reset interrupt\n");
> -		set_bit(HNAE3_IMP_RESET, &hdev->reset_pending);
> +		hclge_set_reset_pending(hdev, HNAE3_IMP_RESET);
>  		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
>  		*clearval = BIT(HCLGE_VECTOR0_IMPRESET_INT_B);
>  		hdev->rst_stats.imp_rst_cnt++;
> @@ -3604,7 +3615,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
>  	if (BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B) & msix_src_reg) {
>  		dev_info(&hdev->pdev->dev, "global reset interrupt\n");
>  		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
> -		set_bit(HNAE3_GLOBAL_RESET, &hdev->reset_pending);
> +		hclge_set_reset_pending(hdev, HNAE3_GLOBAL_RESET);
>  		*clearval = BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B);
>  		hdev->rst_stats.global_rst_cnt++;
>  		return HCLGE_VECTOR0_EVENT_RST;
> @@ -4052,7 +4063,7 @@ static void hclge_do_reset(struct hclge_dev *hdev)
>  	case HNAE3_FUNC_RESET:
>  		dev_info(&pdev->dev, "PF reset requested\n");
>  		/* schedule again to check later */
> -		set_bit(HNAE3_FUNC_RESET, &hdev->reset_pending);
> +		hclge_set_reset_pending(hdev, HNAE3_FUNC_RESET);
>  		hclge_reset_task_schedule(hdev);
>  		break;
>  	default:
> @@ -4086,6 +4097,8 @@ static enum hnae3_reset_type hclge_get_reset_level(struct hnae3_ae_dev *ae_dev,
>  		clear_bit(HNAE3_FLR_RESET, addr);
>  	}
>  
> +	clear_bit(HNAE3_NONE_RESET, addr);
> +
>  	if (hdev->reset_type != HNAE3_NONE_RESET &&
>  	    rst_level < hdev->reset_type)
>  		return HNAE3_NONE_RESET;
> @@ -4227,7 +4240,7 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev)
>  		return false;
>  	} else if (hdev->rst_stats.reset_fail_cnt < MAX_RESET_FAIL_CNT) {
>  		hdev->rst_stats.reset_fail_cnt++;
> -		set_bit(hdev->reset_type, &hdev->reset_pending);
> +		hclge_set_reset_pending(hdev, hdev->reset_type);
Sth is unclear for me here. Doesn't HNAE3_NONE_RESET mean that there is
no reset? If yes, why in this case reset_fail_cnt++ is increasing?

Maybe the check for NONE_RESET should be done in this else if check to
prevent reset_fail_cnt from increasing (and also solve the problem with
pending bit set)
>  		dev_info(&hdev->pdev->dev,
>  			 "re-schedule reset task(%u)\n",
>  			 hdev->rst_stats.reset_fail_cnt);
> @@ -4470,8 +4483,20 @@ static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
>  static void hclge_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
>  					enum hnae3_reset_type rst_type)
>  {
> +#define HCLGE_SUPPORT_RESET_TYPE \
> +	(BIT(HNAE3_FLR_RESET) | BIT(HNAE3_FUNC_RESET) | \
> +	BIT(HNAE3_GLOBAL_RESET) | BIT(HNAE3_IMP_RESET))
> +
>  	struct hclge_dev *hdev = ae_dev->priv;
>  
> +	if (!(BIT(rst_type) & HCLGE_SUPPORT_RESET_TYPE)) {
> +		/* To prevent reset triggered by hclge_reset_event */
> +		set_bit(HNAE3_NONE_RESET, &hdev->default_reset_request);
> +		dev_warn(&hdev->pdev->dev, "unsupported reset type %d\n",
> +			 rst_type);
> +		return;
> +	}
Maybe (nit):
if (...) {
	rst_type = 
	dev_warn();
}

set_bit(rst_type, );
It is a little hard to follow with return in the if.

> +
>  	set_bit(rst_type, &hdev->default_reset_request);
>  }
>  
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> index 2f6ffb88e700..fd0abe37fdd7 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> @@ -1393,6 +1393,17 @@ static int hclgevf_notify_roce_client(struct hclgevf_dev *hdev,
>  	return ret;
>  }
>  
> +static void hclgevf_set_reset_pending(struct hclgevf_dev *hdev,
> +				      enum hnae3_reset_type reset_type)
> +{
> +	/* When an incorrect reset type is executed, the get_reset_level
> +	 * function generates the HNAE3_NONE_RESET flag. As a result, this
> +	 * type do not need to pending.
> +	 */
> +	if (reset_type != HNAE3_NONE_RESET)
> +		set_bit(reset_type, &hdev->reset_pending);
> +}
You already have a way to share the code between PF and VF, so please
move the same functions to common file in one direction up.

> +
>  static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
>  {
>  #define HCLGEVF_RESET_WAIT_US	20000
> @@ -1542,7 +1553,7 @@ static void hclgevf_reset_err_handle(struct hclgevf_dev *hdev)
>  		hdev->rst_stats.rst_fail_cnt);
>  
>  	if (hdev->rst_stats.rst_fail_cnt < HCLGEVF_RESET_MAX_FAIL_CNT)
> -		set_bit(hdev->reset_type, &hdev->reset_pending);
> +		hclgevf_set_reset_pending(hdev, hdev->reset_type);
>  
>  	if (hclgevf_is_reset_pending(hdev)) {
>  		set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
> @@ -1662,6 +1673,8 @@ static enum hnae3_reset_type hclgevf_get_reset_level(unsigned long *addr)
>  		clear_bit(HNAE3_FLR_RESET, addr);
>  	}
>  
> +	clear_bit(HNAE3_NONE_RESET, addr);
> +
>  	return rst_level;
>  }
>  
> @@ -1671,14 +1684,15 @@ static void hclgevf_reset_event(struct pci_dev *pdev,
>  	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
>  	struct hclgevf_dev *hdev = ae_dev->priv;
>  
> -	dev_info(&hdev->pdev->dev, "received reset request from VF enet\n");
> -
>  	if (hdev->default_reset_request)
>  		hdev->reset_level =
>  			hclgevf_get_reset_level(&hdev->default_reset_request);
>  	else
>  		hdev->reset_level = HNAE3_VF_FUNC_RESET;
>  
> +	dev_info(&hdev->pdev->dev, "received reset request from VF enet, reset level is %d\n",
> +		 hdev->reset_level);
> +
>  	/* reset of this VF requested */
>  	set_bit(HCLGEVF_RESET_REQUESTED, &hdev->reset_state);
>  	hclgevf_reset_task_schedule(hdev);
> @@ -1689,8 +1703,20 @@ static void hclgevf_reset_event(struct pci_dev *pdev,
>  static void hclgevf_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
>  					  enum hnae3_reset_type rst_type)
>  {
> +#define HCLGEVF_SUPPORT_RESET_TYPE \
> +	(BIT(HNAE3_VF_RESET) | BIT(HNAE3_VF_FUNC_RESET) | \
> +	BIT(HNAE3_VF_PF_FUNC_RESET) | BIT(HNAE3_VF_FULL_RESET) | \
> +	BIT(HNAE3_FLR_RESET) | BIT(HNAE3_VF_EXP_RESET))
> +
>  	struct hclgevf_dev *hdev = ae_dev->priv;
>  
> +	if (!(BIT(rst_type) & HCLGEVF_SUPPORT_RESET_TYPE)) {
> +		/* To prevent reset triggered by hclge_reset_event */
> +		set_bit(HNAE3_NONE_RESET, &hdev->default_reset_request);
> +		dev_info(&hdev->pdev->dev, "unsupported reset type %d\n",
> +			 rst_type);
> +		return;
> +	}
>  	set_bit(rst_type, &hdev->default_reset_request);
>  }
>  
> @@ -1847,14 +1873,14 @@ static void hclgevf_reset_service_task(struct hclgevf_dev *hdev)
>  		 */
>  		if (hdev->reset_attempts > HCLGEVF_MAX_RESET_ATTEMPTS_CNT) {
>  			/* prepare for full reset of stack + pcie interface */
> -			set_bit(HNAE3_VF_FULL_RESET, &hdev->reset_pending);
> +			hclgevf_set_reset_pending(hdev, HNAE3_VF_FULL_RESET);
>  
>  			/* "defer" schedule the reset task again */
>  			set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
>  		} else {
>  			hdev->reset_attempts++;
>  
> -			set_bit(hdev->reset_level, &hdev->reset_pending);
> +			hclgevf_set_reset_pending(hdev, hdev->reset_level);
>  			set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
>  		}
>  		hclgevf_reset_task_schedule(hdev);
> @@ -1977,7 +2003,7 @@ static enum hclgevf_evt_cause hclgevf_check_evt_cause(struct hclgevf_dev *hdev,
>  		rst_ing_reg = hclgevf_read_dev(&hdev->hw, HCLGEVF_RST_ING);
>  		dev_info(&hdev->pdev->dev,
>  			 "receive reset interrupt 0x%x!\n", rst_ing_reg);
> -		set_bit(HNAE3_VF_RESET, &hdev->reset_pending);
> +		hclgevf_set_reset_pending(hdev, HNAE3_VF_RESET);
>  		set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
>  		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
>  		*clearval = ~(1U << HCLGEVF_VECTOR0_RST_INT_B);
> -- 
> 2.33.0

