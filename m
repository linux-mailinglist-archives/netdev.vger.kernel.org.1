Return-Path: <netdev+bounces-191031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F4AB9BFB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F3F7A5594
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E8239E69;
	Fri, 16 May 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPdmoIIS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38055A32
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398404; cv=none; b=eMoQjYbE1RKDw//ei3cdkcTrpsgjI3N/DRA2YBkptslRHL06pF2xYeKP10dsJYeyUibe3TSBtvU/Sfo3iYe7ZQy5OqXwc1uCWT7vxXCqyEzXbJrRoofY/9GMcHYfotfeGYrrwxPs9ltGomXRvepK1gcQlceQLqe2ZyqZ+8y6utE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398404; c=relaxed/simple;
	bh=l3A+0C0ZlMZcEXmwmZb2VDN+BImDhjEvJVBJ/1QFA8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwPk0K72CBfgw48HYmFbgpQMAZoBVJ0RKZuUiy2fPfDPkv2e2Bkp4R/jsFpzt/diOL68qc2WXiSnjg2ibI5+2v1IBW34fkHc31zk2pzpqM425/XRXBX5+2A9K7GbQ4sBluiM3gl+qG9MKa3dg51x6b2uD1zbye/u65IMv/oLadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPdmoIIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA202C4CEE4;
	Fri, 16 May 2025 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747398403;
	bh=l3A+0C0ZlMZcEXmwmZb2VDN+BImDhjEvJVBJ/1QFA8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPdmoIISRpPa7rjmhyGgokdv72e1rC9/hs+9SDt8j1usSTqFs/EpuokpwCavVv/SK
	 6OqkcKIMnnUOTkkF7nP1MmVU1C4+ojVNmoFGnSiNUtXnK5zKnLfJVhuNdUlqX6XA32
	 Z2iuB4V/y3JEup+5kZRtw3x6TmI7b1KYasPtT7fdsS1OT/vvsltisErDYmBjPZ0Zhl
	 4hrz5tcK7msEF2qlWGOrZ68gjGk5eLH2R95vUNFerghOXa1EtyzLixi1qFk29tNHt8
	 LhR78xsoyUnu42vhT/jMjmV3MkuzuE1NWnfO174KTh0p/3A15ZtxND7J/f5cd5Q+z6
	 D11yJQubqzn9A==
Date: Fri, 16 May 2025 13:26:39 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH iwl-next 4/5] ixgbe: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250516122639.GC3339421@horms.kernel.org>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-5-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513101132.328235-5-vladimir.oltean@nxp.com>

On Tue, May 13, 2025 at 01:11:31PM +0300, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the Intel ixgbe driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl() path
> completely.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


