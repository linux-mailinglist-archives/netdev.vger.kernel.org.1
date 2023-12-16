Return-Path: <netdev+bounces-58211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CD1815895
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 11:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131801C24A4C
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356B14285;
	Sat, 16 Dec 2023 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIGSJ2dc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3715487
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 10:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70517C433C8;
	Sat, 16 Dec 2023 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702721021;
	bh=GR78kp2M52nF0sM0SHOrXYdt45Bz3o9fsu/Czb3BiDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIGSJ2dcK1OHQCGbQH5TgNPW4ooAYhW9QbC9hMrn/r6F1f99dLs4+wWGmjsYPBtR+
	 s7q3SujUNKg3kYyKq6EqmPB38a8eXuY0AGjWzhL1BlgZMITTRP6Btk9EK3EFTAmftL
	 3P9sRz0vfA8UbIaqv5ykkkxewk6aVnuRNBJEzOxg/WexAarzp1YtNJod9AMzyu9nWx
	 aVFmr+n6K0ujcQv7EQJwBlEJ27Rc3C0m51lahJjUA2CTwkgR1KAugOtWF8Eb2Voeb2
	 QLlKCK0ma8f/zZf7bxUEO9w0wfihHje7pa/l7mOsBaWSycHTMsa29uDduo7VsMlXzV
	 zEPqsK9IJCc8Q==
Date: Sat, 16 Dec 2023 10:03:37 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Plachno <lukasz.plachno@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v3 2/2] ice: Implement 'flow-type ether' rules
Message-ID: <20231216100337.GL6288@kernel.org>
References: <20231214043449.15835-1-lukasz.plachno@intel.com>
 <20231214043449.15835-3-lukasz.plachno@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214043449.15835-3-lukasz.plachno@intel.com>

On Thu, Dec 14, 2023 at 05:34:49AM +0100, Lukasz Plachno wrote:

...

> @@ -1199,6 +1212,99 @@ ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
>  	return 0;
>  }
>  
> +/**
> + * ice_fdir_vlan_valid - validate VLAN data for Flow Director rule
> + * @fsp: pointer to ethtool Rx flow specification
> + *
> + * Return: true if vlan data is valid, false otherwise
> + */
> +static bool ice_fdir_vlan_valid(struct ethtool_rx_flow_spec *fsp)
> +{
> +	if (fsp->m_ext.vlan_etype &&
> +	    ntohs(fsp->h_ext.vlan_etype) & ~(ETH_P_8021Q | ETH_P_8021AD))
> +		return false;

Hi Jakub and Lukasz,

It is not obvious to me that a bitwise comparison of the vlan_ethtype is
correct. Possibly naively I expected something more like
(completely untested!):

	if (!eth_type_vlan(sp->m_ext.vlan_etype))
		return false:

> +
> +	if (fsp->m_ext.vlan_tci &&
> +	    ntohs(fsp->h_ext.vlan_tci) >= VLAN_N_VID)
> +		return false;
> +
> +	return true;
> +}

...

