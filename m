Return-Path: <netdev+bounces-124204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D971A9687F4
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97610282EA7
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004713F43B;
	Mon,  2 Sep 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpuqzOKV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8B185939
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281564; cv=none; b=HGKQeopbyU9XKBehFYmURX7ySRxKko7QfXLAu4xcoTWJjFXQjiKTB0dEVAEsRrgJmI+L0t0lrTaNsYsjD6DeNE4c8RMJhSvXs8l1tmJJG2DHeWs7rKoeAJcJ10bzfharU/YNeNqk60+88iIa1c6EYUuidkQvAhwBNXjnYLaHxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281564; c=relaxed/simple;
	bh=Q+j5Bl7cH6ou3W2kzNmS7fE9kRHevpD//rfikQBDb0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/6Y8Fg2ykQfRwFk7Q/F5OdE2XqmMwLRZFhdxsbi+HnnnqZPqVHpvCBze1Gywkp2bEY9YpG7Hk5TS685tKWmoA7tYxQMmif9WheYPwBBBpQwqveUVGZIk7l0zr5TLLwr/KiluwVTywY3VsmnBUfWcnL2mep0jUwDIgKTKoEHSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpuqzOKV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725281563; x=1756817563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q+j5Bl7cH6ou3W2kzNmS7fE9kRHevpD//rfikQBDb0k=;
  b=HpuqzOKVAnHFla1zuILbPyA4vVm9g96Bxof0cW0lPpUJ5FbngizdYsII
   eVco/ndjHqJ0vB7BCksH/pX9sQCO0b9J+w6WknBiN328Hlys63/T4y4uN
   lJCSZQ2ALFUbCsQR/19fBUaVyAHmeJmqpZNlp11m57AjR+dzJrlMcTo3C
   BywbDEnIqf+IRYoNLMCQWQ/E1KHsm7az9iAIbqKz/+UF/kXb3m4G+jrMB
   7eVy/nhR6RsbXwxhzJrbLoA9AgJxleVLqlGVafStfZ/NTrm/cRDcqoJyZ
   Px58d+1/rKk1n3RPT7YDaW/G7IbbFS621CzebP0lL/xCOChzP3JG4IRKF
   A==;
X-CSE-ConnectionGUID: ytN4FjCmTUOE+qmXllDTvw==
X-CSE-MsgGUID: zQ3vXMZ4TX+buw627aNX2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="13330974"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="13330974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 05:52:42 -0700
X-CSE-ConnectionGUID: fcplad2bTku46m4kJ3zXXQ==
X-CSE-MsgGUID: Y6Rvj8fqRfiQyJLUBGPWng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69469819"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 05:52:39 -0700
Date: Mon, 2 Sep 2024 14:50:36 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, horms@kernel.org,
	helgaas@kernel.org, przemyslaw.kitszel@intel.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next v4 9/9] bnxt_en: Support dynamic MSIX
Message-ID: <ZtW0nDQdlzkHG5Y1@mev-dev.igk.intel.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
 <20240828183235.128948-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828183235.128948-10-michael.chan@broadcom.com>

On Wed, Aug 28, 2024 at 11:32:35AM -0700, Michael Chan wrote:
> A range of MSIX vectors are allocated at initialization for the number
> needed for RocE and L2.  During run-time, if the user increases or
> decreases the number of L2 rings, all the MSIX vectors have to be
> freed and a new range has to be allocated.  This is not optimal and
> causes disruptions to RoCE traffic every time there is a change in L2
> MSIX.
> 
> If the system supports dynamic MSIX allocations, use dynamic
> allocation to add new L2 MSIX vectors or free unneeded L2 MSIX
> vectors.  RoCE traffic is not affected using this scheme.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> v4: Simplify adding and deleting MSIX
> v2: Fix typo in changelog
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 37 +++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index fa4115f6dafe..c9248ed9330c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -10622,6 +10622,30 @@ static void bnxt_setup_msix(struct bnxt *bp)
>  

Thanks,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

