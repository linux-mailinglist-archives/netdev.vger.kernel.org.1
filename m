Return-Path: <netdev+bounces-259456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KVYMNMHl2lmtwIAu9opvQ
	(envelope-from <netdev+bounces-259456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:53:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AD315EC48
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE02330098B4
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4759E33A6FB;
	Thu, 19 Feb 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PySoHfpM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C576261B9C
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505616; cv=none; b=EZUtRogNt8wZDZyZJHLkhvkNNJHGNmwEBerzhK5JDhGxlsE2PDI5Ktc8eTxoG6M1iVTp09go7dCmavjpVBzsWbYofHeEfbZEI9pWSDL2R6sQGgj2wU3b0a+10BKZjKXmlkgOJwobp6JHleCOeDNwv+jinuEbNMWpAcsSCY/Nd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505616; c=relaxed/simple;
	bh=KvKfnnXRIGiSC2qzkC6wSjgCJkoB/qA7zqQFhWOs+0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvRP/uqr4XVx89fn4jB1/ti2N4A9Lqn0vuWbnzfPSgPauNDsG2MtAukG6UcKfAIeflWTmk/QYJ7s3fgyN9HRjSABRW0LAhGlm1KOv4OyWz3kUgBUhcbr1v+PO84qJWBnGZP11QtbZOhVwBt+Z5415/GGtOA1rUiAtXGJRdn5Tg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PySoHfpM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771505614; x=1803041614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KvKfnnXRIGiSC2qzkC6wSjgCJkoB/qA7zqQFhWOs+0c=;
  b=PySoHfpMR88w75cr/TMfFShZN46iWxVehw6+3rgXdBcLOtpW5yESYp2a
   fsFqFQKHBZ2j/s8rAzBaBE+ttR8dEYr++o5YXK1MhgqZhK7P+8K3JO808
   7hgo+utuhQKNVrwgXOq7Tc43fkdN9Wc5hI8hv2gRPDxl/vkt5co/sgGPv
   x1I9T+QIYdf4mRVC2PfJYEx36gsE7jnP6pkxIuK39g7pQyp54Y89tGLLs
   LGBR/s5fCC0EiT79lG3XlqIXICLc0vFC/lCmp9aMZKQ0U4bKKxD58aMCz
   7SAcELgElgvDIFidgOpRdgKIa8OwkI4wYjnkKKWiJ/nsvPt8EN2iyYieD
   g==;
X-CSE-ConnectionGUID: zdxCTzj+RTmfHcRwKYo2tg==
X-CSE-MsgGUID: 5OWkY768R6iz0PgCU2UKxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72765876"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72765876"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 04:53:33 -0800
X-CSE-ConnectionGUID: khK1/qZGTE2Cj3f2xIopWA==
X-CSE-MsgGUID: 7iOclODnQzqetEIeZgKamA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="219511560"
Received: from unknown (HELO [10.217.181.1]) ([10.217.181.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 04:53:33 -0800
Message-ID: <650853a0-6fdb-42cb-9feb-c9166439bcaa@linux.intel.com>
Date: Thu, 19 Feb 2026 13:53:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: implement symmetric
 RSS hash configuration
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org
References: <20260217130039.1802805-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260217130039.1802805-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259456-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67AD315EC48
X-Rspamd-Action: no action



On 17.02.2026 14:00, Aleksandr Loktionov wrote:
> The driver advertises symmetric RSS support via supported_input_xfrm
> but ice_set_rxfh() ignored the input_xfrm parameter, making it

s/ignored/ignores/

> impossible to configure symmetric hashing.
> 
> Fix ice_set_rxfh() to check rxfh->input_xfrm and call
> ice_set_rss_hfunc() with ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ when
> RXH_XFRM_SYM_XOR is requested.
> 
> Modify ice_set_rss_vsi_ctx() to use vsi->rss_hfunc instead of
> hardcoding ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ, and export it for
> use by ice_set_rxfh().
> 
> The kernel requires get_rxfh_fields() to report symmetric hash
> configurations when symmetric transforms are supported. Update
> ice_get_rxfh_fields() to return symmetric field configuration
> (src+dst IP and ports) for all flow types.
> 
> Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2 preserve valid symmetric RSS fields.
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 45 ++++++++++++++++----
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  7 +--
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
>  3 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index c6bc29c..27c97ca 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3008,14 +3008,18 @@ ice_set_rxfh_fields(struct net_device *netdev,
>  	return 0;
>  }
>  
> +#define ICE_RSS_ALLOWED_FIELDS	(RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3)
> +#define ICE_RSS_L3_PAIR		(RXH_IP_SRC | RXH_IP_DST)
> +#define ICE_RSS_L4_PAIR		(RXH_L4_B_0_1 | RXH_L4_B_2_3)
> +
>  static int
>  ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
>  	struct ice_vsi *vsi = np->vsi;
>  	struct ice_pf *pf = vsi->back;
> +	u64 l3, l4, hash_flds;
>  	struct device *dev;
> -	u64 hash_flds;
>  	bool symm;
>  	u32 hdrs;
>  
> @@ -3037,8 +3041,10 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
>  
>  	hash_flds = ice_get_rss_cfg(&pf->hw, vsi->idx, hdrs, &symm);
>  	if (hash_flds == ICE_HASH_INVALID) {
> -		dev_dbg(dev, "No hash fields found for the given header type, vsi num = %d\n",
> +		/* Provide default symmetric hash fields when no config exists */
> +		dev_dbg(dev, "No RSS config for this flow, using symmetric defaults, vsi num = %d\n",
>  			vsi->vsi_num);
> +		nfc->data = RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3;

This is the same as ICE_RSS_ALLOWED_FIELDS, use it or:
#define ICE_RSS_DEFAULT_FIELDS ICE_RSS_ALLOWED_FIELDS

>  		return 0;
>  	}

Thanks,
Marcin

---8<---

