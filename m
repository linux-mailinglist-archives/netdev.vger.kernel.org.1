Return-Path: <netdev+bounces-65131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5C83951A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018B71C2117E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149F811E2;
	Tue, 23 Jan 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDE5fP4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB227FBA9
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028008; cv=none; b=t7dSCan6RZtSmLDDcdCidx2AAJPkEF4+Gf4aR+XdlO30n/aCBKHOZ/CYlnf+KHpY/PjWchh1rp19rkIz8hLNMRzzie7hoH0pG4PYwRjaZdglcykLHoAwWdJTxtjlvu2JqXMQV23R2yc806u6ClyVoBp4O5Ke0J5ESZ2uUhI+KWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028008; c=relaxed/simple;
	bh=RbtmtZYSYDADDdWeocLTVE5+NrBKegBej5TUanerSfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUS9ReHTTr9dIAym9arhEmtg12VWw/TGsyj/IJFN8aeBTbX31yseszhSrrTcOKfjGFsxxFfUbuFnGsCYAmeY/1jjBns8SZOJUUjSoqr33HHVQWXFX7MIJQdX4AuEl0lo1zLM+PHsdhBuIMha7fwsMPZiVVPc4zULuyt/sDQBH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDE5fP4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B54AC433F1;
	Tue, 23 Jan 2024 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028007;
	bh=RbtmtZYSYDADDdWeocLTVE5+NrBKegBej5TUanerSfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDE5fP4WgkoVYZ4rwd+hPaHNq98G0ick68GU1U0IgQeAMRnjlkZGkJeD7gNiz7SU/
	 8JJg38MHREHLV8PXYBIMJGpfGUI/oGWOHfAGXajWkFy+/lwKIAU1bo8jvE5i0zlfpN
	 jeKm36MKLbp72nS3khN/Nmwfw/x4OnV3R8MLnUGRolqnti05F9QDVDf2ohHlniKZOU
	 0lXw1mPd6DcpAi8c+/03f29TPxETDEkdcRO3jkjTH9DOKu23jfngjjt162xH1EMwf7
	 nKoElupQm1vQxJORCd+KzWhT092r1Mnwo5Z5GUeSJBcETjVYJwFf47sbGVtCD+IVWT
	 Q1Ev1izcF9Z7g==
Date: Tue, 23 Jan 2024 16:40:03 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v6 iwl-next 2/7] ice: pass reset type to PTP reset
 functions
Message-ID: <20240123164003.GF254773@kernel.org>
References: <20240118174552.2565889-1-karol.kolacinski@intel.com>
 <20240118174552.2565889-3-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118174552.2565889-3-karol.kolacinski@intel.com>

On Thu, Jan 18, 2024 at 06:45:47PM +0100, Karol Kolacinski wrote:
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

Reviewed-by: Simon Horman <horms@kernel.org>


