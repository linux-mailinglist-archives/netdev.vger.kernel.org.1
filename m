Return-Path: <netdev+bounces-162888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D44A28472
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EB07A23E0
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999622B594;
	Wed,  5 Feb 2025 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8cEwSlT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB022A81A;
	Wed,  5 Feb 2025 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736603; cv=none; b=maV1mLReaZRDP3js+Hjv3qa/hQ2/eWcZ+aV9I0ipEXVYJb5u+GTdZ1wCyj0dHKH/dzpozjHjAmiVGvajNO8rR/QGlA7vRV2f/AnbQpoTwv9A2ZQE0MLcil/+oAb8GeH50gVXrNbU3TeexyK30Z+MKfU+MhdHmQ8xYltKcHxBMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736603; c=relaxed/simple;
	bh=HP9+g74QEkY9kBAOGEAE+ZVm8tC/bXMDrX7XPQ/5eCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1efEgjdOJJf6UoYMy6u0XOH5YKcn/dIbTUyNN4kFTVo6MmWlvr+/AhY3JD7v5+dpYiVsfKtjR6Z+e9MLebRQCjE6O0Nzjf2VX/JChk9Cs8WBCKKLMPJFBJwDtu3jhWGpDTGW0vp+S1sARGwjC76kiO5GZCntRdVKdbmLaeNwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8cEwSlT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738736602; x=1770272602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HP9+g74QEkY9kBAOGEAE+ZVm8tC/bXMDrX7XPQ/5eCs=;
  b=e8cEwSlTMGAmWU+v55sr7xi1ZsTR6AKg72BLnhiyhIRqjgLjJ756JDXu
   IU+CSxiw7tjdsuDDF2Hn32pMKEljctspR74m8MiypSAPEy5kg1y9+nOVW
   gWsFVJstprBEhr0eF5uxCe+1MWQ8ub4AWNDJKPdLLG22dLJRdyGsAEu79
   JOBKYdd8qKpJEJ4gjOOj7QrBsVGIR1D7jyYvX2Zs1hbcDlJSijmVRVNdR
   pyQDyQ0YY6KWZE+5jk9ClqrXwtQxqSMFi7Q59ssp8zkUFuLkeHOWEQhYu
   wvWUAxC3tg8tfWDpV5ccwK9R4ZUHmMGj5C3e4ovi+MpD0Cye5AKqqDix6
   Q==;
X-CSE-ConnectionGUID: hRtmhj0AT1uW69XcsVvUkA==
X-CSE-MsgGUID: H43w0JfrTCGokTQzv5lfeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39187854"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="39187854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 22:23:14 -0800
X-CSE-ConnectionGUID: lNSBHWnpTgCzYu0jrN7DVQ==
X-CSE-MsgGUID: bRJ2CwhTQgWO+oJMETI0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141696589"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 22:23:09 -0800
Date: Wed, 5 Feb 2025 07:19:37 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ
Message-ID: <Z6MC+WUALT3H6unG@mev-dev.igk.intel.com>
References: <20250204194624.46560-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204194624.46560-1-ericwouds@gmail.com>

On Tue, Feb 04, 2025 at 08:46:24PM +0100, Eric Woudstra wrote:
> mtk_foe_entry_set_vlan() in mtk_ppe.c already seems to support
> double vlan tagging, but mtk_flow_offload_replace() in
> mtk_ppe_offload.c only allows for 1 vlan tag, optionally in
> combination with pppoe and dsa tags.
> 
> This patch adds QinQ support to mtk_flow_offload_replace().
> 
> Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
> of PPPoE and Q-in-Q is not allowed.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
> 
> Since the RFC v1 did not recieve any comments, I'm sending v2 as PATCH
> unchanged.
> 
> Tested on the BPI-R3(mini), on non-dsa-ports and dsa-ports.
> 
>  .../net/ethernet/mediatek/mtk_ppe_offload.c   | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> index f20bb390df3a..c19789883a9d 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> @@ -34,8 +34,10 @@ struct mtk_flow_data {
>  	u16 vlan_in;
>  
>  	struct {
> -		u16 id;
> -		__be16 proto;
> +		struct {
> +			u16 id;
> +			__be16 proto;
> +		} vlans[2];
>  		u8 num;
>  	} vlan;
>  	struct {
> @@ -349,18 +351,19 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
>  		case FLOW_ACTION_CSUM:
>  			break;
>  		case FLOW_ACTION_VLAN_PUSH:
> -			if (data.vlan.num == 1 ||
> +			if (data.vlan.num + data.pppoe.num == 2 ||
>  			    act->vlan.proto != htons(ETH_P_8021Q))
>  				return -EOPNOTSUPP;
>  
> -			data.vlan.id = act->vlan.vid;
> -			data.vlan.proto = act->vlan.proto;
> +			data.vlan.vlans[data.vlan.num].id = act->vlan.vid;
> +			data.vlan.vlans[data.vlan.num].proto = act->vlan.proto;
>  			data.vlan.num++;
>  			break;
>  		case FLOW_ACTION_VLAN_POP:
>  			break;
>  		case FLOW_ACTION_PPPOE_PUSH:
> -			if (data.pppoe.num == 1)
> +			if (data.pppoe.num == 1 ||
> +			    data.vlan.num == 2)
>  				return -EOPNOTSUPP;
>  
>  			data.pppoe.sid = act->pppoe.sid;
> @@ -450,11 +453,11 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
>  	if (offload_type == MTK_PPE_PKT_TYPE_BRIDGE)
>  		foe.bridge.vlan = data.vlan_in;
>  
> -	if (data.vlan.num == 1) {
> -		if (data.vlan.proto != htons(ETH_P_8021Q))
> +	for (i = 0; i < data.vlan.num; i++) {
> +		if (data.vlan.vlans[i].proto != htons(ETH_P_8021Q))
It is already checked in FLOW_ACTION_VLAN_PUSH, so data.vlan.num can't be
increased if proto is different. No need to check it again.

Other than that rest looks fine.

>  			return -EOPNOTSUPP;
>  
> -		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.id);
> +		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.vlans[i].id);
>  	}
>  	if (data.pppoe.num == 1)
>  		mtk_foe_entry_set_pppoe(eth, &foe, data.pppoe.sid);
> -- 
> 2.47.1
> 

