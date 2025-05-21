Return-Path: <netdev+bounces-192259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26BFABF246
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB24E4E2C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB325EF9F;
	Wed, 21 May 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epjASSky"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B62356C5
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825292; cv=none; b=pMocNkKpCXUIM2yQK92sPnN5UmwtOa8pGBsK4HCWVUEeiNDlJx0v5KNe+6t9j5iPwcmWBouJ5FHY9P5R1h8RAF+FW7efDr5SxS52l3QfR67RjVTFwDb4f6rrUDXlQ4NAXAbKYDsXnOKCeHMS61kabUj3mmXx5nB4ewOM0EQJJ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825292; c=relaxed/simple;
	bh=RqKls0iNyTNgKqkeSoOTio0/g/q9aTTh19wt2/kwB9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2u/Gd5aZCq5ox+5GdHv3fCnAzurM5339QTa32WPk7RYB4IYDogZ5J3V3Syys47GZf0xuDWqyjlBvYCZBfk69gxSzoiZCGNxjC6HQzX86IHNA5qNFMfgIqoXRNMQSBV22QNUN1bX9cqKKg4MHWS8SheDAx4GHyVZoUCrTD/7ilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epjASSky; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747825291; x=1779361291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqKls0iNyTNgKqkeSoOTio0/g/q9aTTh19wt2/kwB9s=;
  b=epjASSky5IP+NHPgNU7rmRYf7kG5tPfH9VmY1Cu1ErywGGX0PfL+YGbb
   8pnptUvFXHR4tq9Y4u3YhM0Uth/Vv2Llpmjam+nQcCtLTzvSYj0hYPS6z
   QUAI5Nz3HzchNPRLqYSy/ty+YQDRlEXH7INEY0o4BRT1PcVixzd6HhGsL
   VwgTMDpAmm/BhoZDl7KTWF9T4rHAa256yEOkcYzvad3p9MZr8Wh34Ph8W
   QX9poiPMlJu9B8KwBxrO7tBJLJ1prpeqiQXE4ocMhk87JNqe8W+LcinoF
   cem005s2mw1Zk2dHNKgj5DEadodEc9lHSo8h8l5+OoZyUNMog13T7EzU6
   Q==;
X-CSE-ConnectionGUID: C5Ii7yTLQD2jVFER7xKc9w==
X-CSE-MsgGUID: WrnMwAftTz+zvEGFLCjGAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="75193501"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="75193501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 04:01:30 -0700
X-CSE-ConnectionGUID: qu46rtrJSVqT0fbVoxBTYA==
X-CSE-MsgGUID: +x0dHZVnSOSgzS1slCV1ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="163300477"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 04:01:27 -0700
Date: Wed, 21 May 2025 13:00:55 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	michal.swiatkowski@linux.intel.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org
Subject: Re: [net PATCH v3] octeontx2-af: Send Link events one by one
Message-ID: <aC2yZ6PqKf5lmJQk@mev-dev.igk.intel.com>
References: <1747823443-404-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747823443-404-1-git-send-email-sbhatta@marvell.com>

On Wed, May 21, 2025 at 04:00:43PM +0530, Subbaraya Sundeep wrote:
> Send link events one after another otherwise new message
> is overwriting the message which is being processed by PF.
> 
> Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3:
>  Modifid to wait for response at other places mcs_notify_pfvf
>  and rvu_rep_up_notify as suggested by Simon Hormon and Michal Swiatkowski.
> v2:
>  No changes. Added subject prefix net.
> 
>  drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 2 ++
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c    | 2 ++
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c    | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> index 655dd47..0277d22 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
> @@ -143,6 +143,8 @@ static int mcs_notify_pfvf(struct mcs_intr_event *event, struct rvu *rvu)
>  
>  	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
>  
> +	otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pf);
> +
>  	mutex_unlock(&rvu->mbox_lock);
>  
>  	return 0;
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
>  	} while (pfmap);
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index 052ae59..32953cc 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> @@ -60,6 +60,8 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
>  
>  	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
>  
> +	otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pf);
> +
>  	mutex_unlock(&rvu->mbox_lock);
>  	return 0;

Thanks for the change
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  }
> -- 
> 2.7.4
> 

