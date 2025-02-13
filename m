Return-Path: <netdev+bounces-165837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F87A337C5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D5F1884A6B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496FC206F3E;
	Thu, 13 Feb 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvLXfc1f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6E1E376E
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427218; cv=none; b=b4Fgvk1HeoAYm6UY5VsTbjGfp9qhstq7RYWD0zUn/IhV0jSZk1lssLrKNIcg+MN/PV0IK1zA5Iyuqd+TJztfv8kdkq2f9VqUS2FkXsdb+j97KOktgwtTNudncTjuiSI6sWJvVi9ItCoeG5IW8OqoaHVv9EneAzdWVI/KIgO5rUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427218; c=relaxed/simple;
	bh=lfNaQwVFrTTKy7aAzAN8pJ1gDfeblQxw6TxKkig41+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW+uw9aw4+naRsVT6asR6pazrDyYIUHnWFVcaNBvuTO+Fp46IOXHKb6P1QbYBSsKO+VEp8mfbfLL+lQ5wmSS7Lh4YtpsQ7hwGFNq3qG9r3qetRVqzJrpvjbaerbvpAf+4Or/2E/0Ru/Wy+aq+nqS5t99kWXEjNfvVG+C1eWya1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvLXfc1f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739427217; x=1770963217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lfNaQwVFrTTKy7aAzAN8pJ1gDfeblQxw6TxKkig41+g=;
  b=nvLXfc1fa5gWjbaVfLxcDL8mQLHkn3HDasc4R1YXFvrd0wKsbiILxFDZ
   XSZ5CaH4V+phPyqu2ACQX5GimzzjIg4bxEbOSKKkPK9trC4dc5l2akPZm
   gQmXCZAMopsvH77WgODdIOk8rrB3qXFjyEnDiEbzhF+pNZcKs8Qwl3usJ
   ED8yXIktWM0HmpeMgYwoYigYYFO6ealIeqkbt9c06zdW3Dc5NKq+ZTf8T
   80jt7FpCcEH0n3ew+gQ7bt+Gvx0qZ92uKCM/YkUUhYrZgis9Is2G8gfNl
   jnLM1UNSGReXy3aqTGcXRwcithoTVuNCwFLYX5EQeMxnE05ESRmv9QdvF
   w==;
X-CSE-ConnectionGUID: OPkK8uv6RjKsIso7Bsb7+Q==
X-CSE-MsgGUID: m3GUWqjJSdyvtk/dBuC7Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="42952090"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="42952090"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:13:36 -0800
X-CSE-ConnectionGUID: gWaK/4t3SGOvFyQnqvWgNw==
X-CSE-MsgGUID: wU1vd0EwQIG9tsKpTZY00w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117664475"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:13:33 -0800
Date: Thu, 13 Feb 2025 07:09:55 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com,
	horms@kernel.org
Subject: Re: [Intel-wired-lan] [iwl-next v2 1/4] ixgbe: add MDD support
Message-ID: <Z62Ms0EjBeKmt5DX@mev-dev.igk.intel.com>
References: <20250212075724.3352715-1-michal.swiatkowski@linux.intel.com>
 <20250212075724.3352715-2-michal.swiatkowski@linux.intel.com>
 <cadb0151-8713-4bf7-810c-569559afc969@molgen.mpg.de>
 <Z6ybMegMoaoMLfLq@mev-dev.igk.intel.com>
 <350aa6d3-05cd-4a5b-b43a-deb5c9e8f5aa@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <350aa6d3-05cd-4a5b-b43a-deb5c9e8f5aa@molgen.mpg.de>

On Wed, Feb 12, 2025 at 02:09:17PM +0100, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Am 12.02.25 um 13:59 schrieb Michal Swiatkowski:
> > On Wed, Feb 12, 2025 at 09:07:18AM +0100, Paul Menzel wrote:
> 
> > > Thank you for your patch. For the summary/title you could use:
> > > 
> > > ixgbe: Support Malicious Driver Detection (MDD)
> > > 
> > > Am 12.02.25 um 08:57 schrieb Michal Swiatkowski:
> > > > From: Paul Greenwalt <paul.greenwalt@intel.com>
> > > > 
> > > > Add malicious driver detection. Support enabling MDD, disabling MDD,
> > > > handling a MDD event, and restoring a MDD VF.
> > > 
> > > a*n* MDD
> > > 
> > > Could you please elaborate? List the commands to enable/disable MDD?
> > > 
> > > Also, please include a reference to the datasheet section for this feature.
> > > I am a little confused, as the Linux driver should never be “malicious”,
> > > shouldn’t it? So what is this feature?
> > > 
> > > Which devices support this? From the diff it looks like X550? Please add
> > > that.
> > > 
> > > How did you test it?
> > > 
> > > How are the events logged?
> 
> > I will elaborate it in the commit message if it is needed. The VF created
> > on X550 device can use malicious driver for example.
> 
> I guess, I still do not know, what “driver” refers to here exactly.
> 

From PF side (the one that will find MDD) it is ixgbe. Modified for
causing MDD can be VF driver loaded on the ixgbe VFs.

> > I tested it by
> > changing Tx descriptor to be invalid (TSO on, with invalid length in
> > descriptor, but any type of invalid descriptor should cause MDD).
> 
> Could these invalid(?) values be prevented from being set in the first
> place?

Let me explain that. The PF driver is the ixgbe driver, these invalid
values are checked and can't cause Tx hang. When you create a VFs you
have to assume that user in VM can load any driver that he want. In this
driver someone can on purpose set invalid parameters to hang Tx. PF
driver need to know about this and the way to inform the PF driver is
by using the MDD events.

> 
> > It is enabled all time. Simple netif_warn() is called with more
> > information about MDD. After 4 events on the same VF the link status is
> > force to be down to turn off malicious VF.
> 
> Thank you for elaborating. It’d be great if you updated the commit message,
> and also pasted one of these log lines, and maybe a test script how to
> trigger the MDD.

There can be a problem with test script, because it needs modified
driver or but crafted frame in DPDK. I will write about it.

Thanks,
Michal

> 
> > > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> > > > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > > > Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> > > > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > > ---
> > > >    drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  28 ++++
> > > >    drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   5 +
> > > >    drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   4 +
> > > >    drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 120 ++++++++++++++++++
> > > >    4 files changed, 157 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > > > index 5fdf32d79d82..d446c375335a 100644
> > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > > > @@ -2746,6 +2746,28 @@ enum ixgbe_fdir_pballoc_type {
> > > >    #define FW_PHY_INFO_ID_HI_MASK		0xFFFF0000u
> > > >    #define FW_PHY_INFO_ID_LO_MASK		0x0000FFFFu
> > > > +/* There are only 3 options for VFs creation on this device:
> > > > + * 16 VFs pool with 8 queues each
> > > > + * 32 VFs pool with 4 queues each
> > > > + * 64 VFs pool with 2 queues each
> > > > + *
> > > > + * That means reading some VF registers that map VF to queue depending on
> > > > + * chosen option. Define values that help dealing with each scenario.
> > > > + */
> > > > +/* Number of queues based on VFs pool */
> > > > +#define IXGBE_16VFS_QUEUES		8
> > > > +#define IXGBE_32VFS_QUEUES		4
> > > > +#define IXGBE_64VFS_QUEUES		2
> > > > +/* Mask for getting queues bits based on VFs pool */
> > > > +#define IXGBE_16VFS_BITMASK		GENMASK(IXGBE_16VFS_QUEUES - 1, 0)
> > > > +#define IXGBE_32VFS_BITMASK		GENMASK(IXGBE_32VFS_QUEUES - 1, 0)
> > > > +#define IXGBE_64VFS_BITMASK		GENMASK(IXGBE_64VFS_QUEUES - 1, 0)
> > > > +/* Convert queue index to register number.
> > > > + * We have 4 registers with 32 queues in each.
> > > > + */
> > > > +#define IXGBE_QUEUES_PER_REG		32
> > > > +#define IXGBE_QUEUES_REG_AMOUNT		4
> > > > +
> > > >    /* Host Interface Command Structures */
> > > >    struct ixgbe_hic_hdr {
> > > >    	u8 cmd;
> > > > @@ -3534,6 +3556,12 @@ struct ixgbe_mac_operations {
> > > >    	int (*dmac_config_tcs)(struct ixgbe_hw *hw);
> > > >    	int (*read_iosf_sb_reg)(struct ixgbe_hw *, u32, u32, u32 *);
> > > >    	int (*write_iosf_sb_reg)(struct ixgbe_hw *, u32, u32, u32);
> > > > +
> > > > +	/* MDD events */
> > > > +	void (*enable_mdd)(struct ixgbe_hw *hw);
> > > > +	void (*disable_mdd)(struct ixgbe_hw *hw);
> > > > +	void (*restore_mdd_vf)(struct ixgbe_hw *hw, u32 vf);
> > > > +	void (*handle_mdd)(struct ixgbe_hw *hw, unsigned long *vf_bitmap);
> > > >    };
> > > >    struct ixgbe_phy_operations {
> > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
> > > > index 3e4092f8da3e..2a11147fb1bc 100644
> > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
> > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
> > > > @@ -17,4 +17,9 @@ void ixgbe_set_source_address_pruning_x550(struct ixgbe_hw *hw,
> > > >    void ixgbe_set_ethertype_anti_spoofing_x550(struct ixgbe_hw *hw,
> > > >    					    bool enable, int vf);
> > > > +void ixgbe_enable_mdd_x550(struct ixgbe_hw *hw);
> > > > +void ixgbe_disable_mdd_x550(struct ixgbe_hw *hw);
> > > > +void ixgbe_restore_mdd_vf_x550(struct ixgbe_hw *hw, u32 vf);
> > > > +void ixgbe_handle_mdd_x550(struct ixgbe_hw *hw, unsigned long *vf_bitmap);
> > > > +
> > > >    #endif /* _IXGBE_X550_H_ */
> > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > > index cb07ecd8937d..788f3372ebf1 100644
> > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > > @@ -2630,6 +2630,10 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
> > > >    	.prot_autoc_write		= prot_autoc_write_generic,
> > > >    	.setup_fc			= ixgbe_setup_fc_e610,
> > > >    	.fc_autoneg			= ixgbe_fc_autoneg_e610,
> > > > +	.enable_mdd			= ixgbe_enable_mdd_x550,
> > > > +	.disable_mdd			= ixgbe_disable_mdd_x550,
> > > > +	.restore_mdd_vf			= ixgbe_restore_mdd_vf_x550,
> > > > +	.handle_mdd			= ixgbe_handle_mdd_x550,
> > > >    };
> > > >    static const struct ixgbe_phy_operations phy_ops_e610 = {
> > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> > > > index 277ceaf8a793..b5cbfd1f71fd 100644
> > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> > > > @@ -3800,6 +3800,122 @@ static int ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
> > > >    	return status;
> > > >    }
> > > > +static void ixgbe_set_mdd_x550(struct ixgbe_hw *hw, bool ena)
> > > > +{
> > > > +	u32 reg_dma, reg_rdr;
> > > > +
> > > > +	reg_dma = IXGBE_READ_REG(hw, IXGBE_DMATXCTL);
> > > > +	reg_rdr = IXGBE_READ_REG(hw, IXGBE_RDRXCTL);
> > > > +
> > > > +	if (ena) {
> > > > +		reg_dma |= (IXGBE_DMATXCTL_MDP_EN | IXGBE_DMATXCTL_MBINTEN);
> > > > +		reg_rdr |= (IXGBE_RDRXCTL_MDP_EN | IXGBE_RDRXCTL_MBINTEN);
> > > > +	} else {
> > > > +		reg_dma &= ~(IXGBE_DMATXCTL_MDP_EN | IXGBE_DMATXCTL_MBINTEN);
> > > > +		reg_rdr &= ~(IXGBE_RDRXCTL_MDP_EN | IXGBE_RDRXCTL_MBINTEN);
> > > > +	}
> > > > +
> > > > +	IXGBE_WRITE_REG(hw, IXGBE_DMATXCTL, reg_dma);
> > > > +	IXGBE_WRITE_REG(hw, IXGBE_RDRXCTL, reg_rdr);
> > > > +}
> > > > +
> > > > +/**
> > > > + * ixgbe_enable_mdd_x550 - enable malicious driver detection
> > > > + * @hw: pointer to hardware structure
> > > > + */
> > > > +void ixgbe_enable_mdd_x550(struct ixgbe_hw *hw)
> > > > +{
> > > > +	ixgbe_set_mdd_x550(hw, true);
> > > > +}
> > > > +
> > > > +/**
> > > > + * ixgbe_disable_mdd_x550 - disable malicious driver detection
> > > > + * @hw: pointer to hardware structure
> > > > + */
> > > > +void ixgbe_disable_mdd_x550(struct ixgbe_hw *hw)
> > > > +{
> > > > +	ixgbe_set_mdd_x550(hw, false);
> > > > +}
> > > > +
> > > > +/**
> > > > + * ixgbe_restore_mdd_vf_x550 - restore VF that was disabled during MDD event
> > > > + * @hw: pointer to hardware structure
> > > > + * @vf: vf index
> > > > + */
> > > > +void ixgbe_restore_mdd_vf_x550(struct ixgbe_hw *hw, u32 vf)
> > > > +{
> > > > +	u32 idx, reg, val, num_qs, start_q, bitmask;
> > > > +
> > > > +	/* Map VF to queues */
> > > > +	reg = IXGBE_READ_REG(hw, IXGBE_MRQC);
> > > > +	switch (reg & IXGBE_MRQC_MRQE_MASK) {
> > > > +	case IXGBE_MRQC_VMDQRT8TCEN:
> > > > +		num_qs = IXGBE_16VFS_QUEUES;
> > > > +		bitmask = IXGBE_16VFS_BITMASK;
> > > > +		break;
> > > > +	case IXGBE_MRQC_VMDQRSS32EN:
> > > > +	case IXGBE_MRQC_VMDQRT4TCEN:
> > > > +		num_qs = IXGBE_32VFS_QUEUES;
> > > > +		bitmask = IXGBE_32VFS_BITMASK;
> > > > +		break;
> > > > +	default:
> > > > +		num_qs = IXGBE_64VFS_QUEUES;
> > > > +		bitmask = IXGBE_64VFS_BITMASK;
> > > > +		break;
> > > > +	}
> > > > +	start_q = vf * num_qs;
> > > > +
> > > > +	/* Release vf's queues by clearing WQBR_TX and WQBR_RX (RW1C) */
> > > > +	idx = start_q / IXGBE_QUEUES_PER_REG;
> > > > +	val = bitmask << (start_q % IXGBE_QUEUES_PER_REG);
> > > > +	IXGBE_WRITE_REG(hw, IXGBE_WQBR_TX(idx), val);
> > > > +	IXGBE_WRITE_REG(hw, IXGBE_WQBR_RX(idx), val);
> > > > +}
> > > > +
> > > > +/**
> > > > + * ixgbe_handle_mdd_x550 - handle malicious driver detection event
> > > > + * @hw: pointer to hardware structure
> > > > + * @vf_bitmap: output vf bitmap of malicious vfs
> > > > + */
> > > > +void ixgbe_handle_mdd_x550(struct ixgbe_hw *hw, unsigned long *vf_bitmap)
> > > > +{
> > > > +	u32 i, j, reg, q, div, vf;
> > > 
> > > Why fix the length of the count variables?
> > 
> > Do you mean why u32 insted of int?
> 
> Yes, that is my question.
> 

Is it a difference in this case? I am using only positive values, so no
reasone other than "it is usually int". I received comment in one review
that I should use unsigned when signed isn't needed. Personaly I think
it is about preference in such case.

I can go with int if you want.

> > > > +	unsigned long wqbr;
> > > > +
> > > > +	/* figure out pool size for mapping to vf's */
> > > > +	reg = IXGBE_READ_REG(hw, IXGBE_MRQC);
> > > > +	switch (reg & IXGBE_MRQC_MRQE_MASK) {
> > > > +	case IXGBE_MRQC_VMDQRT8TCEN:
> > > > +		div = IXGBE_16VFS_QUEUES;
> > > > +		break;
> > > > +	case IXGBE_MRQC_VMDQRSS32EN:
> > > > +	case IXGBE_MRQC_VMDQRT4TCEN:
> > > > +		div = IXGBE_32VFS_QUEUES;
> > > > +		break;
> > > > +	default:
> > > > +		div = IXGBE_64VFS_QUEUES;
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	/* Read WQBR_TX and WQBR_RX and check for malicious queues */
> > > > +	for (i = 0; i < IXGBE_QUEUES_REG_AMOUNT; i++) {
> > > > +		wqbr = IXGBE_READ_REG(hw, IXGBE_WQBR_TX(i)) |
> > > > +		       IXGBE_READ_REG(hw, IXGBE_WQBR_RX(i));
> > > > +		if (!wqbr)
> > > > +			continue;
> > > > +
> > > > +		/* Get malicious queue */
> > > > +		for_each_set_bit(j, (unsigned long *)&wqbr,
> > > > +				 IXGBE_QUEUES_PER_REG) {
> > > > +			/* Get queue from bitmask */
> > > > +			q = j + (i * IXGBE_QUEUES_PER_REG);
> > > > +			/* Map queue to vf */
> > > > +			vf = q / div;
> > > > +			set_bit(vf, vf_bitmap);
> > > > +		}
> > > > +	}
> > > > +}
> > > > +
> > > >    #define X550_COMMON_MAC \
> > > >    	.init_hw			= &ixgbe_init_hw_generic, \
> > > >    	.start_hw			= &ixgbe_start_hw_X540, \
> > > > @@ -3863,6 +3979,10 @@ static const struct ixgbe_mac_operations mac_ops_X550 = {
> > > >    	.prot_autoc_write	= prot_autoc_write_generic,
> > > >    	.setup_fc		= ixgbe_setup_fc_generic,
> > > >    	.fc_autoneg		= ixgbe_fc_autoneg,
> > > > +	.enable_mdd		= ixgbe_enable_mdd_x550,
> > > > +	.disable_mdd		= ixgbe_disable_mdd_x550,
> > > > +	.restore_mdd_vf		= ixgbe_restore_mdd_vf_x550,
> > > > +	.handle_mdd		= ixgbe_handle_mdd_x550,
> > > >    };
> > > >    static const struct ixgbe_mac_operations mac_ops_X550EM_x = {
> 
> Kind regards,
> 
> Paul

