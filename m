Return-Path: <netdev+bounces-217014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A1BB37095
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4EF3AFECA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B71314B98;
	Tue, 26 Aug 2025 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQjC0POh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7530BBA9
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226214; cv=none; b=MvDfi+a/U22csMtaEDXHlt4AsENkaMjmpqyuqKsEaNHm74Gtes5IAGPpBdudLVRYtdiYTZIF90hTjUQe6r+s0Rgfiz9fCsKF+RJgIp2Iaw1/fsJP13D62Z1wPWObgyDPeoyfnNz3e/lIopLfLEWoE6F0NVrgaPSdetiTeKO4CRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226214; c=relaxed/simple;
	bh=RUebI+LLPCOnHLuFhlypq+cjnus+GGm+ptjDxaXfbq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvTEPgy2LVFN8SGRsqjvqY+o5Sn1TUYCcHj1z5lPHPU9mGcsXIJxpD2ImY1Q++M9BEcg1FqRHvqYzQcFEmRGLkzvWSwW2sGvXWAtn3J/CWQBlXcLMgWFxsU1z2nEemzLxvY7liVa0WL4lZQcQpOdy7hVmH4KTwB9TX8rOQl+m2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQjC0POh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2DDC4CEF1;
	Tue, 26 Aug 2025 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226214;
	bh=RUebI+LLPCOnHLuFhlypq+cjnus+GGm+ptjDxaXfbq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQjC0POhP2Jf52omzRG8r/pqXyD3uR+hdK4nF8NXRDiufluqzJrkrV24HLIxfl8NK
	 Q39VyyxGu+Z2QrrZZ9kevhZxdJ1W+ROdFqn12LGeq6IjazSRxkg5kK0x+ExkW4HQcw
	 DfXX8qShi0ttEwM2JGii5VNL+oMeRn82ZIEegIRp/+nPhdkCEnTKWd1NmiE00K38So
	 3APgFrD2kyk21EPSIg2SGJwwKy7p12LKoRVoBqEal/TcaIgC+6UxxKIn5ooJU72OPz
	 t5mOKcvdGDjWz9R9xMQ4yRkuFZsrB2aIeAaPPXG/rh+KhRNRIItr8tvdFjTn2KsBOP
	 DsFZIEOhr4Ltw==
Date: Tue, 26 Aug 2025 17:36:50 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 8/8] i40e: improve VF MAC filters accounting
Message-ID: <20250826163650.GL5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-9-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-9-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:18PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> When adding new VM MAC, driver checks only *active* filters in
> vsi->mac_filter_hash. Each MAC, even in non-active state is using resources.
> 
> To determine number of MACs VM uses, count VSI filters in *any* state.
> 
> Add i40e_count_all_filters() to simply count all filters, and rename
> i40e_count_filters() to i40e_count_active_filters() to avoid ambiguity.
> 
> Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every trusted VF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


