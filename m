Return-Path: <netdev+bounces-217012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC114B37099
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5177018960D1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B802C3261;
	Tue, 26 Aug 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpB6Jgm0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB8196C7C
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226172; cv=none; b=mFuQgWGH6Xd3cWpsUnje+S8Indq8YOR0M95prLSLN49W47iiQ08qMgf4o3vxz2nnpWYB+x6mxKqEBsjpGCyHiTWsGbwvZ7s0c82EBlThOfW5mYLlbd7ITbFrFEP4rdSc4nVc1oEDtJ7b/sTtTNNx4/pLVl7w61Q9zvpgubGFBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226172; c=relaxed/simple;
	bh=EJ98GjaezkjirbUv6wCZyS8npF4TyMEdwhhAxJrJCOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+7Mn4fOV1u5RvEJKpuOV36Wh5oqZUQ+a1fknf0RAZINiM5bxmPfgVnguklO9y6TBXALaQlh0bQhyuR9qFq697R0CaSuxQ8PEFGylET0httNXCHWUfC2x6Z4uv/0VXJjaqC/idFLt+iGtQVXk3AOxu5S21a3NOopNQNixa3oukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpB6Jgm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28523C4CEF1;
	Tue, 26 Aug 2025 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226171;
	bh=EJ98GjaezkjirbUv6wCZyS8npF4TyMEdwhhAxJrJCOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpB6Jgm0sLzZHvpEcduIawO+NsugFIOKapOChDSoXIquWEWUU8JXrW372q0bnYprL
	 +/vyFz3DunFXxHXkEFbbRSZssbZsc+mLuChpzs4HYdRj69ulYrKausBJme6DYyq4GL
	 GVFEY4rsjdv3pfivdlrOYp7hCerK49IZ0gIvFCpI5HcHCR2cvqts941xMl6kz+Tfue
	 cdtLEZEL2yknRDHfcSTDfsaqe8d0StuJzPhIwKiJlW5JLLm1w1mTQA3eKw92C3fgPr
	 BEZahZl9ZivuKaDpCjB3gruALkG93WfOYQJOubYPmsbBZkxfTR916y3AkcKLp2whtV
	 pIU/tUr+S5pqg==
Date: Tue, 26 Aug 2025 17:36:06 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 5/8] i40e: fix validation of VF state in get
 resources
Message-ID: <20250826163606.GJ5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-6-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-6-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:15PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> VF state I40E_VF_STATE_ACTIVE is not the only state in which
> VF is actually active so it should not be used to determine
> if a VF is allowed to obtain resources.
> 
> Use I40E_VF_STATE_RESOURCES_LOADED that is set only in
> i40e_vc_get_vf_resources_msg() and cleared during reset.
> 
> Fixes: 61125b8be85d ("i40e: Fix failed opcode appearing if handling messages from VF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


