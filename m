Return-Path: <netdev+bounces-148926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB209E37B8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734281697CC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBD187555;
	Wed,  4 Dec 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjDb1A7m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37018BC1D
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308728; cv=none; b=uIpKyWGwxyQX/wrQou3BRJsUlNw2McFxle7wqD2vRrRARqPqMOE/ungJdlLwmUN3pXO5A9GFw+JfnJcS7i17tfpSBuXUhb1qRdVEfKRCg4jnS1Ts1dZmLWtSpXxUfeUmUlu+LgpmCPhrYPNw5DniBkOcFXfr5eCwg63tWhNwhOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308728; c=relaxed/simple;
	bh=xJZCFOavZqqDdC/cy1U2w5RXVrSSRIWcefJ+hU2I3Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5+7ujHzElE34pHKvDoJiBuT1B6+8PnyqOal301qeJZEmicyG2m8VOnIAs3jP+n245Sd1PaPoqRGUfjLkajL0Wyo3I3mFAJPVM/wnEayAM4r89v3ky6DZCwJnZEIcnb0wtY/ZpXfXJZKRJGoakRgyfu2crb94BIJW6o8FWPZBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjDb1A7m; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733308727; x=1764844727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xJZCFOavZqqDdC/cy1U2w5RXVrSSRIWcefJ+hU2I3Hc=;
  b=LjDb1A7mZs6l9xtXOCtsGDnV3oEM+bqtniETYqdoKgowQshGFSJyZK7i
   ZIDCmDXnuAalZi2/DjXtldD02R9AGm9/7SaNO3sm9ayNnV1cwe9EWxOfA
   BamctKbFvTHIbvATgVGEBH0shOvMHI3oOT9B5NhhZOkAjieQwgbTjQKB8
   NV9UIFDAIAWEvl14ck0PVVLP5sHxeFF2Ii39ZsQLO9n1Vx4+9LockdVKs
   cOEzw2Ou+CQXjLn/oCQNxkr1Gva1bERuDDb47K5Om19F4pF7bcvDiWD7i
   eXNM//THTTrVqdTsmHCRQQs++UOl5/TX3Yhk0p3rtbIA/FQ6C7JLhVDdg
   w==;
X-CSE-ConnectionGUID: 9TmKLwg7Tga9ss6VHMxq4g==
X-CSE-MsgGUID: fhLc+jNIQem2kU+/0T0nDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37345947"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="37345947"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 02:38:46 -0800
X-CSE-ConnectionGUID: rxf7bRIBTFWInIofk22DhA==
X-CSE-MsgGUID: rw69jEedSU+XfOfEYnWFkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93913895"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 02:38:44 -0800
Date: Wed, 4 Dec 2024 11:35:46 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew+netdev@lunn.ch, pabeni@redhat.com, bharat@chelsio.com
Subject: Re: [PATCH net] cxgb4: use port number to set mac addr
Message-ID: <Z1AwgqSRsHxWgLn+@mev-dev.igk.intel.com>
References: <20241203144149.92032-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203144149.92032-1-anumula@chelsio.com>

On Tue, Dec 03, 2024 at 08:11:49PM +0530, Anumula Murali Mohan Reddy wrote:
> t4_set_vf_mac_acl() uses pf to set mac addr, but t4vf_get_vf_mac_acl()
> uses port number to get mac addr, this leads to error when an attempt
> to set MAC address on VF's of PF2 and PF3.
> This patch fixes the issue by using port number to set mac address.
> 
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c      | 5 +++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> index 75bd69ff61a8..c7c2c15a1815 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> @@ -2076,7 +2076,7 @@ void t4_idma_monitor(struct adapter *adapter,
>  		     struct sge_idma_monitor_state *idma,
>  		     int hz, int ticks);
>  int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
> -		      unsigned int naddr, u8 *addr);
> +		      u8 start, unsigned int naddr, u8 *addr);
>  void t4_tp_pio_read(struct adapter *adap, u32 *buff, u32 nregs,
>  		    u32 start_index, bool sleep_ok);
>  void t4_tp_tm_pio_read(struct adapter *adap, u32 *buff, u32 nregs,
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 97a261d5357e..bc3af0054406 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -3234,7 +3234,7 @@ static int cxgb4_mgmt_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
>  
>  	dev_info(pi->adapter->pdev_dev,
>  		 "Setting MAC %pM on VF %d\n", mac, vf);
> -	ret = t4_set_vf_mac_acl(adap, vf + 1, 1, mac);
> +	ret = t4_set_vf_mac_acl(adap, vf + 1, pi->lport, 1, mac);
>  	if (!ret)
>  		ether_addr_copy(adap->vfinfo[vf].vf_mac_addr, mac);
>  	return ret;
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> index 76de55306c4d..175bf9b13058 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> @@ -10215,11 +10215,12 @@ int t4_load_cfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
>   *	t4_set_vf_mac_acl - Set MAC address for the specified VF
>   *	@adapter: The adapter
>   *	@vf: one of the VFs instantiated by the specified PF
> + *	@start: The start port id associated with specified VF
>   *	@naddr: the number of MAC addresses
>   *	@addr: the MAC address(es) to be set to the specified VF
>   */
>  int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
> -		      unsigned int naddr, u8 *addr)
> +		      u8 start, unsigned int naddr, u8 *addr)
>  {
>  	struct fw_acl_mac_cmd cmd;
>  
> @@ -10234,7 +10235,7 @@ int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
>  	cmd.en_to_len16 = cpu_to_be32((unsigned int)FW_LEN16(cmd));
>  	cmd.nmac = naddr;
>  
> -	switch (adapter->pf) {
> +	switch (start) {
>  	case 3:
>  		memcpy(cmd.macaddr3, addr, sizeof(cmd.macaddr3));
You can use ether_addr_copy().

Beside that and fixes tag:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  		break;
> -- 
> 2.39.3

