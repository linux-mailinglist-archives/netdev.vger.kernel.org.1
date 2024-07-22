Return-Path: <netdev+bounces-112440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D13939158
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C935B21332
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00216E86E;
	Mon, 22 Jul 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWpUUgGj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A716E863
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660734; cv=none; b=toP43HqjJ0oyKuFu7BvE3QOAwK2hThVtRh2anA8xgncQ31Z4TcBcdMh8ohSEDVVuXu5N00wHkK7BO+PeE6BtAH25FL8vLmCV07pFZ4k1g8Bf6NVpw7WM3OOE9e7XiY6V9RhBb+lN06LaPtxw77DTOZsb0yyvvwpvuoaGper7ou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660734; c=relaxed/simple;
	bh=QLK+aBZ7KtdrjUdjLucoN+29ohXeB+CVID27TKDB1fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZd5OgzOGkTz2t3pIb9SolaFY0iUR5LiUyJpJ6vZGXbelsS7Wv/zDwDlZTOOMBkKraWrwCOqG4Xp4J7h/SS2X/9mdfuhT8M1ymNksfWLQOSd09r5ilOzllBd62f0sAq4ERprn7I1Fdkql1hyocdQbinV//P4cjguv/NtBt3Ca7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWpUUgGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D6AC4AF10;
	Mon, 22 Jul 2024 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660734;
	bh=QLK+aBZ7KtdrjUdjLucoN+29ohXeB+CVID27TKDB1fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWpUUgGjvhEwSL9Mz/yL4Aaibwvl6kcql4vMgV0PWt3QDNKdMHQ+hEd55f2hWTNco
	 HuW/dgKas8mfYi3JMjtfoI3qqJrGyWerMveW/HX4JPChToxp9ervgBK7sNf1iZqJoR
	 nCKpOaYSJTBedpjGmen9Jz3O6TjRUzGp8YYrpUqhuY5MbE0FuzSleCf8lZ7RKHSFfW
	 uZl+IMy+z86stp1yW1Nm+vIlqjAKhFVG5Qg87QaHk76Uo8+PawW1oW1+t19USNzvIF
	 fA8frsnhvjP93yi7ITn+SvENxffBZlzlKcfg0j7bANaZJRJp3kSjPPlonthtKlvuWw
	 PB8uQQ/ieMDBQ==
Date: Mon, 22 Jul 2024 16:05:30 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 13/13] iavf: add support for offloading tc
 U32 cls filters
Message-ID: <20240722150530.GL715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-14-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-14-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:15PM -0600, Ahmed Zaki wrote:
> Add support for offloading cls U32 filters. Only "skbedit queue_mapping"
> and "drop" actions are supported. Also, only "ip" and "802_3" tc
> protocols are allowed. The PF must advertise the VIRTCHNL_VF_OFFLOAD_TC_U32
> capability flag.
> 
> Since the filters will be enabled via the FD stage at the PF, a new type
> of FDIR filters is added and the existing list and state machine are used.
> 
> The new filters can be used to configure flow directors based on raw
> (binary) pattern in the rx packet.
> 
> Examples:
> 
> 0. # tc qdisc add dev enp175s0v0  ingress
> 
> 1. Redirect UDP from src IP 192.168.2.1 to queue 12:
> 
>     # tc filter add dev <dev> protocol ip ingress u32 \
> 	match u32 0x45000000 0xff000000 at 0  \
> 	match u32 0x00110000 0x00ff0000 at 8  \
> 	match u32 0xC0A80201 0xffffffff at 12 \
> 	match u32 0x00000000 0x00000000 at 24 \
> 	action skbedit queue_mapping 12 skip_sw
> 
> 2. Drop all ICMP:
> 
>     # tc filter add dev <dev> protocol ip ingress u32 \
> 	match u32 0x45000000 0xff000000 at 0  \
> 	match u32 0x00010000 0x00ff0000 at 8  \
> 	match u32 0x00000000 0x00000000 at 24 \
> 	action drop skip_sw
> 
> 3. Redirect ICMP traffic from MAC 3c:fd:fe:a5:47:e0 to queue 7
>    (note proto: 802_3):
> 
>    # tc filter add dev <dev> protocol 802_3 ingress u32 \
> 	match u32 0x00003CFD 0x0000ffff at 4   \
> 	match u32 0xFEA547E0 0xffffffff at 8   \
> 	match u32 0x08004500 0xffffff00 at 12  \
> 	match u32 0x00000001 0x000000ff at 20  \
> 	match u32 0x0000 0x0000 at 40          \
> 	action skbedit queue_mapping 7 skip_sw
> 
> Notes on matches:
> 1 - All intermediate fields that are needed to parse the correct PTYPE
>     must be provided (in e.g. 3: Ethernet Type 0x0800 in MAC, IP version
>     and IP length: 0x45 and protocol: 0x01 (ICMP)).
> 2 - The last match must provide an offset that guarantees all required
>     headers are accounted for, even if the last header is not matched.
>     For example, in #2, the last match is 4 bytes at offset 24 starting
>     from IP header, so the total is 14 (MAC) + 24 + 4 = 42, which is the
>     sum of MAC+IP+ICMP headers.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h

...

>  /* Must be called with fdir_fltr_lock lock held */
>  static inline bool iavf_fdir_max_reached(struct iavf_adapter *adapter)
>  {
> -	return (adapter->fdir_active_fltr >= IAVF_MAX_FDIR_FILTERS);
> +	return (adapter->fdir_active_fltr + adapter->raw_fdir_active_fltr >=
> +			IAVF_MAX_FDIR_FILTERS);

nit: These parentheses seem unnecessary

> +}

...

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c

...

> +/**
> + * iavf_add_cls_u32 - Add U32 classifier offloads
> + * @adapter: pointer to iavf adapter structure
> + * @cls_u32: pointer to tc_cls_u32_offload struct with flow info

Please document the return value with a "Return:" or "Returns:" section.
Likewise for iavf_del_cls_u32 and iavf_setup_tc_cls_u32.

...

