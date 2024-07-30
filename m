Return-Path: <netdev+bounces-114105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97FD940F77
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E92B1F25FE8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F551A01A2;
	Tue, 30 Jul 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwrMR20J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15471A00FF
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335334; cv=none; b=gu6c+edV2NwDUBxFCAWw5BE4ypbqPDl5XRUI/OUaBX2d3wFFs5NkzEdqM6hYOEiei6mkpv+9Pa3A6Qv6ttcpl88BU6bYPrMWaIEz297siJ66H1hAX72eYID1YNLWWMpz+u/yAuGPZ8oLo6jBDHv8KB2JifrzOZi5mYdydr3S/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335334; c=relaxed/simple;
	bh=Yd+bFiBGSdyUAsFPoD3rjwVsN8k4aiUTyN/gHuNRwgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsYkEWXBoDGMuBLX5Au5sYjc4zy56l6iyiBZ7b9ZbxHPrELGgVj4XaL5M3t/783k2M20z1VPLKnDJOH32guBJAoiYTOWkHKzb9IO9kWFcBEak8DwVgjvxKpjLnDEcFIvRkpw1WK3y+8eRr9iamzVDMB2XCsL8bHGkOj1j/GC8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwrMR20J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26D0C32782;
	Tue, 30 Jul 2024 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335333;
	bh=Yd+bFiBGSdyUAsFPoD3rjwVsN8k4aiUTyN/gHuNRwgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwrMR20JHV3l9hUYKC6oOCVwzywWsF0UBP3B/hJQh8r73Wpi8P97Y/yPiP7rFLx6o
	 5Ss2j2FA+WyJ8/fge8RcebwW1eF/0+4Kgo1zTQlJDOqSYRLZgqXPcYBUqwqLHjQsBZ
	 CoHtMfyrzma3GvQrB99VNkL9U/+8jKxGHD5NxQxLHSLeetrssXMvuendfKFogqIAXn
	 gu+Krbrtxh4y5h0anNQuH66zsGFWxgqmHs8CdWi9MHxk6rG5iLhe1MXPD5PdsWmznD
	 OLsROdameDBpIlWRK4Wm+U3YHrTnr5WzvMnvl6L5qQHLIF+L4uoJvmAYGa8d70O5HL
	 Q4LNnyl+DX10w==
Date: Tue, 30 Jul 2024 11:28:49 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	hkelam@marvell.com, Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH iwl-next v5 12/13] iavf: refactor add/del FDIR filters
Message-ID: <20240730102849.GY97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-13-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-13-ahmed.zaki@intel.com>

On Thu, Jul 25, 2024 at 04:08:08PM -0600, Ahmed Zaki wrote:
> In preparation for a second type of FDIR filters that can be added by
> tc-u32, move the add/del of the FDIR logic to be entirely contained in
> iavf_fdir.c.
> 
> The iavf_find_fdir_fltr_by_loc() is renamed to iavf_find_fdir_fltr()
> to be more agnostic to the filter ID parameter (for now @loc, which is
> relevant only to current FDIR filters added via ethtool).
> 
> The FDIR filter deletion is moved from iavf_del_fdir_ethtool() in
> ethtool.c to iavf_fdir_del_fltr(). While at it, fix a minor bug where
> the "fltr" is accessed out of the fdir_fltr_lock spinlock protection.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


