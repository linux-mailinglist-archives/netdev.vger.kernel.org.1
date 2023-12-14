Return-Path: <netdev+bounces-57300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2947C812C4B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD46CB20D1E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763039FE9;
	Thu, 14 Dec 2023 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCP9cDXo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6E29424
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44180C433C7;
	Thu, 14 Dec 2023 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702547806;
	bh=W3wMJj/fE7ypeh3zjGSazjPb1WJfR/FlhxIOKm/d7cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCP9cDXorxisgUlARQcNK735G1z84WztdwB2hGQeUosm9qig4fRoIkCTRSe7XdJPE
	 JOX85LENwe/8vOiI/YxaaMwM7c1b958CGph+hMb1JIg2X50rfky5wfKZJhQNtUMGOX
	 ljYAGm3+Ymajp1k71gcSNJCyKLBp+6k4R18JiGOoc2UuXWkx6TCaiEVIjoW2wTPDro
	 zrSLNVip6U+qdJxETGP1yMdm0nxlUYVKuJqIGL9P5fjO3Xb53wv0xTrB5QRPotZYhC
	 RL4Lxtkaz576t+XaRhKshgVGitzfRCwzYnXtjI8j/huTCvNo1ZwmdiAjJKLDs6+2+o
	 nfxb4Z/WGQIEg==
Date: Thu, 14 Dec 2023 09:56:42 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v4 2/2] ixgbe: Refactor returning internal error
 codes
Message-ID: <20231214095642.GK5817@kernel.org>
References: <20231212104642.316887-1-jedrzej.jagielski@intel.com>
 <20231212104642.316887-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212104642.316887-3-jedrzej.jagielski@intel.com>

On Tue, Dec 12, 2023 at 11:46:42AM +0100, Jedrzej Jagielski wrote:
> Change returning codes to the kernel ones instead of
> the internal ones for the entire ixgbe driver.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v3: do not use ENOSYS; rebase
> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |  36 ++---
>  .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  61 ++++----
>  .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 145 ++++++++----------
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  26 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |  34 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |   1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  84 +++++-----
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  39 -----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  44 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 109 ++++++-------
>  12 files changed, 266 insertions(+), 317 deletions(-)

Thanks Jedrzej,

this is a nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>


