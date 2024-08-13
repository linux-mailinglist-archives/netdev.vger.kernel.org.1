Return-Path: <netdev+bounces-118118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7895092C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D0F2813EA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949D19F479;
	Tue, 13 Aug 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwDayWft"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C3194AFE
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563112; cv=none; b=QTmbbYSsg/+UuH+W1/dlTBc1hc7r4mCiGDY5Rroh1jHwYbkFacwAW8K1hA3wy9gE+qcjW2l+fRJHrwZf5ZM7iNwHRiQD0zO+8VQ2KYXMme5iVCkFXmfyh++GtovLigOuSaEpnt5VEV8/nWtw1la2Rblg+GiLOPKWVW0ZaRxXTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563112; c=relaxed/simple;
	bh=q1Fbv9kYJD8YduTv5pSps0LqCNpWxgRip9oCIXzAb8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kq60+lpL7Y/Ns1BzdfmYjs9L15jMRlwS4G/VZrzyU2rBHqPA5UHO4MV1/o4YjiTaQsiLKivSc8IKMWrFolcwRvSRgdJ97QzUFc3Zz2KfaEjn9ET4Bu144zmGMQawqCkJF7ta78o1rO29M/N/cCVmbrfvg8MnYf6GMXe9neF+lB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwDayWft; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723563111; x=1755099111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q1Fbv9kYJD8YduTv5pSps0LqCNpWxgRip9oCIXzAb8U=;
  b=jwDayWftkYYvg7+xEPO295SVqjAmrLpT5HeUDtxhepFiGLP3ITXS7O2Z
   kiUK9WbCJqsJ5Z2MyhWplyk3ZHQIGJCn9urFHmmk67kev6iDVVj1W5Pvb
   c+/mLIFtBsM3OM6vgNiLx6W4b1pVCQgEolfexwhLCNuvADoecwKJxEvhi
   Dmxtb8u9aETDSBtq2ov8TAiGYkBxpvyAgwuDoLUXtbl2k8gKGnrMA0olk
   UxMWnOuAV8N0n079yX+D/6GHVi7SyP+BuVKxEd+hwuzZAkUspeG9SZMUd
   4/8NRlUO2XJye1XarS5TNnfdRdGgo8GaW9mGXQVXknzC5KoZPLNt4u2Oz
   g==;
X-CSE-ConnectionGUID: 5W5xG5uCQv2niBzVuVCPZw==
X-CSE-MsgGUID: U4yxuPe9Sj+hz1StqdWybg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32879937"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="32879937"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 08:31:44 -0700
X-CSE-ConnectionGUID: 4Y+QaE7mTeSdplh4nLkVzg==
X-CSE-MsgGUID: WMHq63J7REOVJFrcKSFZ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="63122719"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.245.130.66]) ([10.245.130.66])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 08:31:41 -0700
Message-ID: <1c0db79b-dd8c-4ab8-b108-42395a737836@linux.intel.com>
Date: Tue, 13 Aug 2024 17:31:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: Add netif_device_attach/detach into PF
 reset flow
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Igor Bagnucki <igor.bagnucki@intel.com>
References: <20240812125009.62635-1-dawid.osuchowski@linux.intel.com>
 <ZrtIO2durwKP7ue/@boxer>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <ZrtIO2durwKP7ue/@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.08.2024 13:49, Maciej Fijalkowski wrote:
> What about other intel drivers tho?

I have not performed detailed analysis of other intel ethernet drivers 
in this regard, but it is surely a topic worth investigating.

--Dawid

