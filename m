Return-Path: <netdev+bounces-153310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BDF9F794E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07446169D3F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807A22258A;
	Thu, 19 Dec 2024 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwvhEYeM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724978F55;
	Thu, 19 Dec 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603262; cv=none; b=VxsD41ioxseXU97462lVV7DRebD9eJREGD8AucWo0DVcGA27CweAIK3QTzEkxH4nRObltVBHr78sJHhSBi8EFUxmCmqZCN+BtNR95g2EyMAFQRlkPMssxwBJywB5PCbwyqYxR7iKl376LTjUdD5D9sOumMXAgR8mV+czu5ReFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603262; c=relaxed/simple;
	bh=8dZGcx1HfFCEgOMRg4RVUZQF2Z7W0oeDzjERXe30cJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHigV/AnrG/r7RtEKPkfzJcjrHQN5DOp1Kn9qTWnEZpwZhxo+/De2Ggr6TV61TrO+HjAcpSwnHp9tnmaeMRz4BJtxrM3WavXqjkOZ8qHTCP0DJR01e/29Ox6UURUJBQilbrKXQlXtaG6LCtk0dUaBJoisWOKnnV0gjficrfUZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwvhEYeM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734603259; x=1766139259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8dZGcx1HfFCEgOMRg4RVUZQF2Z7W0oeDzjERXe30cJM=;
  b=WwvhEYeMF3vFbWqucddDvS2DtAL5KzIpCIz597Xp5EpCY5h+h+GMhsqr
   3xMJtard8zk36sSpu/5/tNghIspCTqaikUZTPx4CKgtu4COB+qhXm47ZG
   4Pqln7/I3Rk5hRaCapEfUoUFYQDL5sK6zlmJ9Cj9XxeSE6spN14QHN8OC
   dK8zigS7n6yCjYaJnZgK/mDCD1mMYClrbhtmeqvxTfP+FqO4mRJxwE0gj
   MVSLFQ2m/pHv/Pu6H33oULPXz80MEOlDBCa2iCKh7CZcZjf9UlDbdThEm
   er/T2Lm6/GKEWkT3IUYXead+MiYiO/ux+jzoohSzijW8MJMCz/OQgzeUg
   A==;
X-CSE-ConnectionGUID: Eoxxhyp1RVeSIl79ozUYmQ==
X-CSE-MsgGUID: 1e0ytGaYSIqc+4I/hFigRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35006545"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="35006545"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:14:18 -0800
X-CSE-ConnectionGUID: OZCQLSGBQV6hpQuHiVwXtQ==
X-CSE-MsgGUID: L2lm6D5ORAKocKGZXbqBsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="103230046"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:14:17 -0800
Date: Thu, 19 Dec 2024 11:11:15 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V2 net 1/7] net: hns3: fixed reset failure issues
 caused by the incorrect reset type
Message-ID: <Z2PxQ8A5DObivci8@mev-dev.igk.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-2-shaojijie@huawei.com>
 <Z2KPw9WYCI/SZIjg@mev-dev.igk.intel.com>
 <8a789f23-a17a-456d-ba2a-de8207d65503@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a789f23-a17a-456d-ba2a-de8207d65503@redhat.com>

On Thu, Dec 19, 2024 at 10:41:53AM +0100, Paolo Abeni wrote:
> On 12/18/24 10:02, Michal Swiatkowski wrote:
> > On Tue, Dec 17, 2024 at 09:08:33AM +0800, Jijie Shao wrote:
> >> From: Hao Lan <lanhao@huawei.com>
> >>
> >> When a reset type that is not supported by the driver is input, a reset
> >> pending flag bit of the HNAE3_NONE_RESET type is generated in
> >> reset_pending. The driver does not have a mechanism to clear this type
> >> of error. As a result, the driver considers that the reset is not
> >> complete. This patch provides a mechanism to clear the
> >> HNAE3_NONE_RESET flag and the parameter of
> >> hnae3_ae_ops.set_default_reset_request is verified.
> >>
> >> The error message:
> >> hns3 0000:39:01.0: cmd failed -16
> >> hns3 0000:39:01.0: hclge device re-init failed, VF is disabled!
> >> hns3 0000:39:01.0: failed to reset VF stack
> >> hns3 0000:39:01.0: failed to reset VF(4)
> >> hns3 0000:39:01.0: prepare reset(2) wait done
> >> hns3 0000:39:01.0 eth4: already uninitialized
> >>
> >> Use the crash tool to view struct hclgevf_dev:
> >> struct hclgevf_dev {
> >> ...
> >> 	default_reset_request = 0x20,
> >> 	reset_level = HNAE3_NONE_RESET,
> >> 	reset_pending = 0x100,
> >> 	reset_type = HNAE3_NONE_RESET,
> >> ...
> >> };
> >>
> >> Fixes: 720bd5837e37 ("net: hns3: add set_default_reset_request in the hnae3_ae_ops")
> >> Signed-off-by: Hao Lan <lanhao@huawei.com>
> >> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> I haven't signed-off this patch.
> 
> Still no need to repost (yet) for this if the following points are
> solved rapidly (as I may end-up merging the series and really adding my
> SoB), but please avoid this kind of issue in the future.
> 
> >> @@ -4227,7 +4240,7 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev)
> >>  		return false;
> >>  	} else if (hdev->rst_stats.reset_fail_cnt < MAX_RESET_FAIL_CNT) {
> >>  		hdev->rst_stats.reset_fail_cnt++;
> >> -		set_bit(hdev->reset_type, &hdev->reset_pending);
> >> +		hclge_set_reset_pending(hdev, hdev->reset_type);
> > Sth is unclear for me here. Doesn't HNAE3_NONE_RESET mean that there is
> > no reset? If yes, why in this case reset_fail_cnt++ is increasing?
> > 
> > Maybe the check for NONE_RESET should be done in this else if check to
> > prevent reset_fail_cnt from increasing (and also solve the problem with
> > pending bit set)
> 
> @Michal: I don't understand your comment above. hclge_reset_err_handle()
> handles attempted reset failures. I don't see it triggered when
> reset_type == HNAE3_NONE_RESET.
> 

Maybe I missed sth. The hclge_set_reset_pending() is added to check if
reset type isn't HNAE3_NONE_RESET. If it is the set_bit isn't called. It
is the only place where hclge_set_reset_pending() is called with a
variable, so I assumed the fix is for this place.

This means that code can be reach here with HNAE3_NONE_RESET which is
unclear for me why to increment resets if rest_type in NONE. If it is
true that hclge_reset_err_handle() is never called with reset_type
HNAE3_NONE_RESET it shouldn't be needed to have the
hclge_set_reset_pending() function.

Following that I suggested to check if reset_type isn't NONE before
checking other things.

> >> @@ -4470,8 +4483,20 @@ static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
> >>  static void hclge_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
> >>  					enum hnae3_reset_type rst_type)
> >>  {
> >> +#define HCLGE_SUPPORT_RESET_TYPE \
> >> +	(BIT(HNAE3_FLR_RESET) | BIT(HNAE3_FUNC_RESET) | \
> >> +	BIT(HNAE3_GLOBAL_RESET) | BIT(HNAE3_IMP_RESET))
> >> +
> >>  	struct hclge_dev *hdev = ae_dev->priv;
> >>  
> >> +	if (!(BIT(rst_type) & HCLGE_SUPPORT_RESET_TYPE)) {
> >> +		/* To prevent reset triggered by hclge_reset_event */
> >> +		set_bit(HNAE3_NONE_RESET, &hdev->default_reset_request);
> >> +		dev_warn(&hdev->pdev->dev, "unsupported reset type %d\n",
> >> +			 rst_type);
> >> +		return;
> >> +	}
> > Maybe (nit):
> > if (...) {
> > 	rst_type = 
> > 	dev_warn();
> > }
> > 
> > set_bit(rst_type, );
> > It is a little hard to follow with return in the if.
> 
> @Michal: I personally find the patch code quite readable, do you have
> strong opinions here?
> 
> >>  	set_bit(rst_type, &hdev->default_reset_request);
> >>  }
> >>  
> >> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> index 2f6ffb88e700..fd0abe37fdd7 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> @@ -1393,6 +1393,17 @@ static int hclgevf_notify_roce_client(struct hclgevf_dev *hdev,
> >>  	return ret;
> >>  }
> >>  
> >> +static void hclgevf_set_reset_pending(struct hclgevf_dev *hdev,
> >> +				      enum hnae3_reset_type reset_type)
> >> +{
> >> +	/* When an incorrect reset type is executed, the get_reset_level
> >> +	 * function generates the HNAE3_NONE_RESET flag. As a result, this
> >> +	 * type do not need to pending.
> >> +	 */
> >> +	if (reset_type != HNAE3_NONE_RESET)
> >> +		set_bit(reset_type, &hdev->reset_pending);
> >> +}
> > You already have a way to share the code between PF and VF, so please
> > move the same functions to common file in one direction up.
> 
> AFAICS this can't be shared short of a large refactor not suitable for
> net as the functions eligible for sharing operate on different structs
> with different layout (hclgevf_dev vs hclge_dev). Currently all the
> shared code operates on shared structs.
> 
> Cheers,
> 
> Paolo
> 

