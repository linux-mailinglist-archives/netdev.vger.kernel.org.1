Return-Path: <netdev+bounces-164584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399CEA2E5B4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4DC16297C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200CA1B2180;
	Mon, 10 Feb 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F141LZyr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D52F22;
	Mon, 10 Feb 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173609; cv=none; b=sK6Za12+/N04v18oJlmcmSKFF9oijSqApvJQw1hewXApRAK8x2xBfAImLiYYy/OFEE1P8yOLimF9fAZ7oC0BOxxk0W0rA5nj0PMoElBAYYCNtcxLnTRp5O7w0ScCAJPebxlHdv/IFgJW5aunWdQs8JD+hGekwQhZlHemXBWsvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173609; c=relaxed/simple;
	bh=57FsZbFOLUMSsYGliPSMD+RfYyI9b+xhfGwhfTv6VoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwbCDLxOpRZaSEtkx7ZRgDUj8AnkAITqT79oVIiM5z9WfUeEyClQQuvpYQVs9BYmaGcuxMy0Sa+KFI10mivYOpkqjPdVT0c3l62cKWvGU4u0wMWmz5RvKnrF6fZfAe0PCeYkG1Gg31z+q7PSUGxUKK9qcxy5iH0J0ekarM8Hbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F141LZyr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739173607; x=1770709607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=57FsZbFOLUMSsYGliPSMD+RfYyI9b+xhfGwhfTv6VoU=;
  b=F141LZyrA60WMKlKILeGmPqXKM9a8bg774zLiEVoMCCDzRISI4bdvOPf
   RGUmYP2JiIUiL5M/5w0SH5mrWyxG5sCQFlLOfRRlOZzwsQ+JLmrteJpj0
   6jX3e6jCK8MZMf0xhnk0ePfJbWTFke3c4xdAOPW9eEhwbJhjW7vb79mEg
   A0S3pISenmyOMNXP5858sRDUo4UDv7yX/dZsTXZQLglxQaGIsGYKimJCM
   i+/yjm57ufLfTuMYqixa9OLwBDta+KT2rA3kkrGmuQxkLve7zXHFRNdYg
   uOhDv9RMBwWkbj2pyTH/AWU2vY+xyQfeKtpAXtnhD+lObcn5TKlUv50g0
   w==;
X-CSE-ConnectionGUID: yX6VJDKXQieem4OvBDolBA==
X-CSE-MsgGUID: 3okIMeZiR6GRR42qIVlC4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39868187"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39868187"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 23:46:46 -0800
X-CSE-ConnectionGUID: 168nfPuIRfeGYDg3PECo0w==
X-CSE-MsgGUID: cljx2HRWQAuLmpH7eaD5VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112994147"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 23:46:42 -0800
Date: Mon, 10 Feb 2025 08:43:07 +0100
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
Subject: Re: [PATCH v3 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ
Message-ID: <Z6muC7WshGlaY9Ft@mev-dev.igk.intel.com>
References: <20250209110936.241487-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209110936.241487-1-ericwouds@gmail.com>

On Sun, Feb 09, 2025 at 12:09:36PM +0100, Eric Woudstra wrote:
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
> Changes in v3:
> - Removed unnecessary second check for ETH_P_8021Q.
> 
> Changes in v2:
> - Unchanged, only RFC to PATCH.
> 
> Tested on the BPI-R3(mini), on non-dsa-ports and dsa-ports.
> 
>  .../net/ethernet/mediatek/mtk_ppe_offload.c   | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> index f20bb390df3a..c855fb799ce1 100644
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
> @@ -450,12 +453,9 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
>  	if (offload_type == MTK_PPE_PKT_TYPE_BRIDGE)
>  		foe.bridge.vlan = data.vlan_in;
>  
> -	if (data.vlan.num == 1) {
> -		if (data.vlan.proto != htons(ETH_P_8021Q))
> -			return -EOPNOTSUPP;
> +	for (i = 0; i < data.vlan.num; i++)
> +		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.vlans[i].id);
>  
> -		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.id);
> -	}
>  	if (data.pppoe.num == 1)
>  		mtk_foe_entry_set_pppoe(eth, &foe, data.pppoe.sid);

Thanks for addressing comments.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
> -- 
> 2.47.1

