Return-Path: <netdev+bounces-200997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E89AE7B50
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53625A57FD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBA429B20E;
	Wed, 25 Jun 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Agurw7Lq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554C29ACE6
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842084; cv=none; b=jJ+2Pj1m6efxdn6tf8rflQddqN2Bpq/7+6h9J1eXW2qIboNFl6TL6jf1tZn1IxY2erdo772pws2l0kJ4k0LtpSYRyYTK+YlAgNFbWPGRr0YFSmLWrSWsRCO58ScAapP+z+mVQ/Pu9aXJJ/kmcKjevPSG33IAqhEGccveXFjcAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842084; c=relaxed/simple;
	bh=J3LRFCdKMHDJ3jfOLnnBbarNlAuSi67YvUjOp7gGJUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsvCEg8yCWBUhsIUcKErwZFxjs6/BDarD6vMi4vQ8YLxcsQqxc7BoB9LURcT40OhNOEEAaBB3mpcfeblY35l4gBqHO5arZJ1AbBWSyicGuMP7xW1pfElwJtxu3eebI3CHhwOddL6mWp/SWwc4Q9J+9FaRwWVIa1aaaJHeCexsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Agurw7Lq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750842083; x=1782378083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3LRFCdKMHDJ3jfOLnnBbarNlAuSi67YvUjOp7gGJUY=;
  b=Agurw7LqRJ5BLIGGRy7IurJuAGoEscw4WqDjfZ/l7Q6UiqjK/RY8dfRW
   2odCV4sNO3bzeg4MQ+H0mgMzPxK362Ix7OtyK73I8OwupnXRd9cifP5yb
   g7YzchBX7UVixlfWSF3NHO+55gZmBtZM2gVZ1C/dR9lwQP7yvP6AOFvTl
   6SWFgMONfR3xhpC8z0qdcadbzlezlaltA+sRhwPWGY+V30kAn+5C0Avxm
   UV5/1OWgRasU/qB8kjUYLFDJOCF4XIuL7W5ZokHPbfROZW4oZycC0BCrE
   kgZm+DjgUKOhp/GCq0FGE+4mOrLqgG9x3QVprvEP4Z3quHCPqdUlbVW9E
   A==;
X-CSE-ConnectionGUID: awhkuWDDSUKWulVxvCZcwg==
X-CSE-MsgGUID: tPH6N+rARUW3G5bhAJhQiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64461538"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="64461538"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 02:01:22 -0700
X-CSE-ConnectionGUID: 6zJV9Ft3SbG7BDUZEIyhaw==
X-CSE-MsgGUID: HyseNS8VSMWR+OqTOu1V3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151671160"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 02:01:20 -0700
Date: Wed, 25 Jun 2025 11:00:22 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 3/3] net: ngbe: specify IRQ vector when the number
 of VFs is 7
Message-ID: <aFu6ph+7xhWxwX3W@mev-dev.igk.intel.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com>
 <20250624085634.14372-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624085634.14372-4-jiawenwu@trustnetic.com>

On Tue, Jun 24, 2025 at 04:56:34PM +0800, Jiawen Wu wrote:
> For NGBE devices, the queue number is limited to be 1 when SRIOV is
> enabled. In this case, IRQ vector[0] is used for MISC and vector[1] is
> used for queue, based on the previous patches. But for the hardware
> design, the IRQ vector[1] must be allocated for use by the VF[6] when
> the number of VFs is 7. So the IRQ vector[0] should be shared for PF
> MISC and QUEUE interrupts.
> 
> +-----------+----------------------+
> | Vector    | Assigned To          |
> +-----------+----------------------+
> | Vector 0  | PF MISC and QUEUE    |
> | Vector 1  | VF 6                 |
> | Vector 2  | VF 5                 |
> | Vector 3  | VF 4                 |
> | Vector 4  | VF 3                 |
> | Vector 5  | VF 2                 |
> | Vector 6  | VF 1                 |
> | Vector 7  | VF 0                 |
> +-----------+----------------------+
> 
> Minimize code modifications, only adjust the IRQ vector number for this
> case.
> 
> Fixes: 877253d2cbf2 ("net: ngbe: add sriov function support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 9 +++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 4 ++++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  | 1 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 2 +-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 3 ++-
>  5 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 66eaf5446115..7b53169cd216 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1794,6 +1794,13 @@ static int wx_acquire_msix_vectors(struct wx *wx)
>  	wx->msix_entry->entry = nvecs;
>  	wx->msix_entry->vector = pci_irq_vector(wx->pdev, nvecs);
>  
> +	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags)) {
> +		wx->msix_entry->entry = 0;
> +		wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
> +		wx->msix_q_entries[0].entry = 0;
> +		wx->msix_q_entries[0].vector = pci_irq_vector(wx->pdev, 1);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2292,6 +2299,8 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
>  
>  	if (direction == -1) {
>  		/* other causes */
> +		if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
> +			msix_vector = 0;
>  		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
>  		index = 0;
>  		ivar = rd32(wx, WX_PX_MISC_IVAR);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> index e8656d9d733b..c82ae137756c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> @@ -64,6 +64,7 @@ static void wx_sriov_clear_data(struct wx *wx)
>  	wr32m(wx, WX_PSR_VM_CTL, WX_PSR_VM_CTL_POOL_MASK, 0);
>  	wx->ring_feature[RING_F_VMDQ].offset = 0;
>  
> +	clear_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
>  	clear_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
>  	/* Disable VMDq flag so device will be set in NM mode */
>  	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
> @@ -78,6 +79,9 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
>  	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
>  	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
>  
> +	if (num_vfs == 7 && wx->mac.type == wx_mac_em)
> +		set_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
> +
>  	/* Enable VMDq flag so device will be set in VM mode */
>  	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
>  	if (!wx->ring_feature[RING_F_VMDQ].limit)
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index d392394791b3..c363379126c0 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1191,6 +1191,7 @@ enum wx_pf_flags {
>  	WX_FLAG_VMDQ_ENABLED,
>  	WX_FLAG_VLAN_PROMISC,
>  	WX_FLAG_SRIOV_ENABLED,
> +	WX_FLAG_IRQ_VECTOR_SHARED,
>  	WX_FLAG_FDIR_CAPABLE,
>  	WX_FLAG_FDIR_HASH,
>  	WX_FLAG_FDIR_PERFECT,
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 68415a7ef12f..e0fc897b0a58 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -286,7 +286,7 @@ static int ngbe_request_msix_irqs(struct wx *wx)
>  	 * for queue. But when num_vfs == 7, vector[1] is assigned to vf6.
>  	 * Misc and queue should reuse interrupt vector[0].
>  	 */
> -	if (wx->num_vfs == 7)
> +	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
>  		err = request_irq(wx->msix_entry->vector,
>  				  ngbe_misc_and_queue, 0, netdev->name, wx);
>  	else
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> index 6eca6de475f7..b6252b272364 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> @@ -87,7 +87,8 @@
>  #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
>  
>  #define NGBE_INTR_ALL				0x1FF
> -#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
> +#define NGBE_INTR_MISC(A)			((A)->num_vfs == 7 ? \
> +						 BIT(0) : BIT((A)->num_q_vectors))

Isn't it problematic that configuring interrupts is done in
ndo_open/ndo_stop on PF, but it depends on numvfs set in otther context.
If you start with misc on index 8 and after that set numvfs to 7 isn't
it fail?

>  
>  #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
>  #define NGBE_CFG_LAN_SPEED			0x14440
> -- 
> 2.48.1

