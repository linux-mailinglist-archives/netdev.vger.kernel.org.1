Return-Path: <netdev+bounces-152861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7281F9F6073
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6E16EB27
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31118191F75;
	Wed, 18 Dec 2024 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQCz2p4/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CB165F18
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511683; cv=none; b=hsDct3wwp8Vb8rZRNSDpiGqD+Ka7TosyMEC+9mFQghgzf0fEwCAXBhGZlCsUm24h2FyMN38Q1WuE21ISadTbmxy/fkWllkldSITcI+utEzQPFedBute4nABrV29EbA35LrFSFqZJm4OT0FQaI9N9+7MPOC0dfSrOwplUcaIFdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511683; c=relaxed/simple;
	bh=2fvPiTAZv5rqk+bWLmfDgpuhpEwEB5pNg7b841vmRCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAdjVmi5GRC8q7F2DLbYg5uXm+O8TJy20YltvTkd3vJDcQhgrULsGq9sPOkbf5u2vmMujYgoK8wD/3Bqs4ka3rjmed0KsgYYt3SOR4enj4h+e1k+UohzjhwNEeU3wQx2bfQoTy1QMTTfUsfLONUqN5lHizyNrc6ikvlIjGyNonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQCz2p4/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734511681; x=1766047681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2fvPiTAZv5rqk+bWLmfDgpuhpEwEB5pNg7b841vmRCc=;
  b=gQCz2p4/ysQjjnumNz7XjiuBJOMnuLWeswcw5PS1RemQsBvDTBYS2+rO
   DSZftoNQn2k91sgqvVIsQvK8dtaOK4w+HjErXd6qUAoG1UkqsB1Jo6jA7
   LTHGKiYhu4EHc/Fuy5CgSdI0GziXWtv5G/oSUl4auTu62VwP1wxusp8kI
   1NYxmfk+yjARxVaY9V/7ijNlD5K4PHQcnjKa1dVOrbT9+vxO7Fn+JKTdh
   jnarAFDQzYBR1l5RoAJgd1qAmtzQfnBhNVdWvRaIrMHC/d50v5QTDl7Jm
   EPjUvGXhCedw/SQSQZaoSKSDR1N5T8B0v21o2HJ+l1m9A3ByvWLBJuPAk
   Q==;
X-CSE-ConnectionGUID: D2rhr7BYQW2M6Ee0ri6MeA==
X-CSE-MsgGUID: 0ag7ZFRNRUK1LYAFAeMF4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34261085"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="34261085"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 00:48:00 -0800
X-CSE-ConnectionGUID: elgY9zoyQnGGt0yRCyyPaA==
X-CSE-MsgGUID: bQ+JWCTUTpiiUswZJOKy2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128776490"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 00:47:58 -0800
Date: Wed, 18 Dec 2024 09:44:57 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v2 4/6] bnxt_en: Skip MAC loopback selftest if
 it is unsupported by FW
Message-ID: <Z2KLiSYjhQjboHMw@mev-dev.igk.intel.com>
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
 <20241217182620.2454075-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217182620.2454075-5-michael.chan@broadcom.com>

On Tue, Dec 17, 2024 at 10:26:18AM -0800, Michael Chan wrote:
> Call the new HWRM_PORT_MAC_QCAPS to check if mac loopback is
> supported.  Skip the MAC loopback ethtool self test if it is
> not supported.
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Change bnxt_hwrm_mac_qcaps() to void
> Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 24 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++++
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 +++++----
>  3 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c0728d5ff8bc..46edea75e062 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -11551,6 +11551,26 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
>  	return rc;
>  }
>  
> +static void bnxt_hwrm_mac_qcaps(struct bnxt *bp)
> +{
> +	struct hwrm_port_mac_qcaps_output *resp;
> +	struct hwrm_port_mac_qcaps_input *req;
> +	int rc;
> +
> +	if (bp->hwrm_spec_code < 0x10a03)
> +		return;
> +
> +	rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_QCAPS);
> +	if (rc)
> +		return;
> +
> +	resp = hwrm_req_hold(bp, req);
> +	rc = hwrm_req_send_silent(bp, req);
> +	if (!rc)
> +		bp->mac_flags = resp->flags;
> +	hwrm_req_drop(bp, req);
> +}
> +
>  static bool bnxt_support_dropped(u16 advertising, u16 supported)
>  {
>  	u16 diff = advertising ^ supported;
> @@ -15679,6 +15699,10 @@ static int bnxt_probe_phy(struct bnxt *bp, bool fw_dflt)
>  		bp->dev->priv_flags |= IFF_SUPP_NOFCS;
>  	else
>  		bp->dev->priv_flags &= ~IFF_SUPP_NOFCS;
> +
> +	bp->mac_flags = 0;
> +	bnxt_hwrm_mac_qcaps(bp);
> +
>  	if (!fw_dflt)
>  		return 0;
>
Thanks for changing the return value
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[...]
> -- 
> 2.30.1
> 

