Return-Path: <netdev+bounces-65138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CBE839572
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2841F307A0
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08186148;
	Tue, 23 Jan 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8OS+XSo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8585C7F
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028515; cv=none; b=D0MgSmjgrGQ5R7zpM/sW5dDXSanM/S38FXB9I+vatYbUPbX9vVEUq80WfJ3YqWjChVkm/6/JhlcsyRu5oXSb59kd1XVsLAlR8+34WtFd0RYoOAzz54DYRyF+x6aBKCyqVOfLBdK9lRh10A+fjjx0wZVXxRdHz8QlxYACXTBgXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028515; c=relaxed/simple;
	bh=RYoO9jDumV+r59op/XZ/ktXEsNIugdrzJGVKIDBudlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+QLkMwVZXSfhsFn1DFc+le16YpbjdrAwl2kVVwD0KiF0e4t9DPQ2iAb6uBD8VVWx7DDu3GUpXhL63/hCQ5YIuILcAEG5TZy+ovSpA1JN3eoLzhiIU0uTOy5JsIlYFqs2wGWQNQtTOuS2LGMcpah9Q6XbUbNyftREGlLjP+kNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8OS+XSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6B0C433C7;
	Tue, 23 Jan 2024 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028514;
	bh=RYoO9jDumV+r59op/XZ/ktXEsNIugdrzJGVKIDBudlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8OS+XSoMyeAvG8ypAPS00QpS8EBN3IMbf/k6IKeiZyhF1K4yzFUCD2AEDdCwv1Av
	 Uo/JGhX/77ZqdpfXkJg3nOGNIQX8yS/pxWYbdfNFH7rTleIiuTJol6LEKIkC6MD8EK
	 en17YNG0181OxkQz5fW3VuDRSVm9KFR96kPTGptsVxGBYfZeyjNc3HWdwRjWx3UZgw
	 +yRSfGFdR58bPHBVLwUtkWhMVU3D75TB33nfRLDsLZJmpvQLSy66m6Tqg6HjKfgHe/
	 GH7QEysBK668Z/r7pCpYWc970nLeUab3y91EB4qL1YJtFTIj0Qm3PHCMvd24gR5pdP
	 NA4wguTvkJcEQ==
Date: Tue, 23 Jan 2024 16:48:30 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v7 iwl-next 2/7] ice: pass reset type to PTP reset
 functions
Message-ID: <20240123164830.GH254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-3-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-3-karol.kolacinski@intel.com>

On Tue, Jan 23, 2024 at 11:51:26AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_prepare_for_reset() and ice_ptp_reset() functions currently
> check the pf->flags ICE_FLAG_PFR_REQ bit to determine if the current
> reset is a PF reset or not.
> 
> This is problematic, because it is possible that a PF reset and a higher
> level reset (CORE reset, GLOBAL reset, EMP reset) are requested
> simultaneously. In that case, the driver performs the highest level
> reset requested. However, the ICE_FLAG_PFR_REQ flag will still be set.
> 
> The main driver reset functions take an enum ice_reset_req indicating
> which reset is actually being performed. Pass this data into the PTP
> functions and rely on this instead of relying on the driver flags.
> 
> This ensures that the PTP code performs the proper level of reset that
> the driver is actually undergoing.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Sorry, I sent this just now for v6, not realising that v7 had been posted.

Reviewed-by: Simon Horman <horms@kernel.org>

