Return-Path: <netdev+bounces-190343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D7AB656F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255C88C0B93
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138121CC41;
	Wed, 14 May 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdxJuyTl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3521C197
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210331; cv=none; b=eiSXH1nURXFD2MVpB0WJUeDFjVDBDQToGBUq2X8Sc93zV785JgIWm9bsdRYChVlOZ/FnLoRJulop65SczFIPkllDHypPjHlcpkyqeR4hYEcnIfdyf+mqr0UoOYJb8RcB4ExLZsVhuYuku4qxPZuTqHeFJhhe8rTEnVIu6C49m4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210331; c=relaxed/simple;
	bh=KtVXCOPJsKrUJtqNtnCVuNOP8wF5HAZiBuD9dGz2NCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/uEzzWjf8YUYaWqP+enmhkViW8ItPrPiFC6qGXgHUinX3bLhw48jOVn7SKE4eDiDOCTMzNzQHBlhLWkdj8azfUXwoVgIDYB6eaC1xYFEyxhvAXq9PPNmIvgf4X5UpXJiYJGKQUcwfRN7XPPDnxQFC05L2ht7OeVUYPtLRFXM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdxJuyTl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747210329; x=1778746329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtVXCOPJsKrUJtqNtnCVuNOP8wF5HAZiBuD9dGz2NCo=;
  b=HdxJuyTl2C8RvCtNyV1bHwSuP4ChM5TWGASMu2M2x4540ybnAQrvfp08
   Uu58ISs6PtGD2u7UP0+DHPdl0uwVD6ZzFLR+W6Ll5bql4SY4ODh7DtdsT
   EzjPMiOdSHh/vc7Uhh2hw7RvLmZTFXN4a6b24k0xOzDpu1E5gamCkk/0Z
   vL1XBlI3XUIfXRhfhWgApfAt/JCleGTziQ4o/GPlG3r4pkLP7ZBnwwPLO
   yaqIvM1GX7d3Am3HIE+BVE16l13CjpTxjpSXEEWdFLbxrEGhb/dF2Wzcw
   KjFtjUILC2A9ZL9eJTgiM1ORLkW5u97EQ2ZxzLfzEzNC/UO4VPrNnO4cY
   A==;
X-CSE-ConnectionGUID: gBt9ijJFQwifDqtvLebetA==
X-CSE-MsgGUID: qW9Hd8jHSomHfcHnqWpCwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49026898"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49026898"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 01:12:08 -0700
X-CSE-ConnectionGUID: WCXUNYJ9TZ+HITeb1XFS8g==
X-CSE-MsgGUID: zuu6+vd5QLi0eanqksPxcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="138458324"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 01:12:05 -0700
Date: Wed, 14 May 2025 10:11:32 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
	lcherian@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] octeontx2-af: Send Link events one by one
Message-ID: <aCRQNJbYL2ORGmMh@mev-dev.igk.intel.com>
References: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>

On Wed, May 14, 2025 at 11:58:28AM +0530, Subbaraya Sundeep wrote:
> Send link events one after another otherwise new message
> is overwriting the message which is being processed by PF.
> 
> Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v2:
>  No changes. Added subject prefix net.
> 
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 992fa0b..ebb56eb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -272,6 +272,8 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
>  
>  		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
>  
> +		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
> +
>  		mutex_unlock(&rvu->mbox_lock);

Fix looks fine.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In rvu_rep_up_notify() the same send function is called (and
rvu_rep_up_notify() is called in do, while loop in
rvu_rep_wq_handler()). Doesn't it also need waiting for response?
Are there a message that don't need waiting? Maybe it will be best to
always wait for response if another call can overwrite.

Thanks

>  	} while (pfmap);
>  }
> -- 
> 2.7.4

