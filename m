Return-Path: <netdev+bounces-175117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73734A635C0
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787F8188FDB8
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 13:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC90D101F2;
	Sun, 16 Mar 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQCpLDxs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A6C2E0
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742130950; cv=none; b=b1gzwYz/KCf24TBxjIdMJmYNymOnB9KGbmpdS/ErR5R0wgF5LANf2218ke4cxmH0uBwFoVcnnCP1S3Gjub5sSZd1323I7m+YcolhyvhYEaebHnDQXKx3hStiKfEUlGQL/HR3o1ljex0ZAM9VFWqlJzdmhsdT3y0+/+hA18pxqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742130950; c=relaxed/simple;
	bh=S8k6hZfMd8wUHCgq21ZTyZehbZz+gKZmfe5iK5Dpr0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbHA2tjEPg+Hi39KEHFbjvUbUhXlo4EReNl6QdRmjXXZ9IeB342pqxYl7nGHZGdZjJECvmXDcBscxCz2y+Y474De6D9/25MhrSPPEN9T9P+0eskqionL+wWmCEfogP33dQuxtTPjKfixeCWDfOx17Ae10RZWdtlM2Ho36XChDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQCpLDxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A1CC4CEDD;
	Sun, 16 Mar 2025 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742130950;
	bh=S8k6hZfMd8wUHCgq21ZTyZehbZz+gKZmfe5iK5Dpr0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQCpLDxsVkKe6ypR3DTVOWjEmidOBmT7ecCm3ke/XeXb3mBUskRECSW5KIzULq0YT
	 9OtFXsgOGz1y4nQf6J0aYb4sPqgjOW//O3oOCfFBjNT1ht7VGxQsmaQFXK/bLLtIZy
	 M8ACT4RaAKI0xg6DtJdOxSLmByrpERq+3efiIw6ye0PbaKC9uqHop7626BVcSsz+dd
	 fyU74KUJU3STWnm6h7qPRpw5YmQINjchx9RczsycfDJSIwZBGyt+pv5+MdJh6K4dUW
	 9NXQDCPSiI7klqgTec2ls3OKGY5KCfT/ByNDadzANxNstjkPEWc0NUW1lu4Pjf7S9v
	 TrqtwVvQbZbQw==
Date: Sun, 16 Mar 2025 13:15:45 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [iwl-next v2] ice: refactor the Tx scheduler feature
Message-ID: <20250316131545.GY4159220@kernel.org>
References: <20250307132555.119902-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307132555.119902-2-martyna.szapar-mudlaw@linux.intel.com>

On Fri, Mar 07, 2025 at 02:25:56PM +0100, Martyna Szapar-Mudlaw wrote:
> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Simplify the code by eliminating an unnecessary wrapper function.
> Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper
> around ice_get_tx_topo_user_sel(), adding no real value but increasing
> code complexity. Since both functions were only used once, the wrapper
> was redundant and contributed approximately 20 lines of unnecessary
> code. Remove ice_get_tx_topo_user_sel() and moves its instructions
> directly into ice_devlink_tx_sched_layers_get(), improving readability
> and reducing function jumps, without altering functionality.

Thanks, this explanation looks good to me.

> 
> Also remove unnecessary comment and make usage of str_enabled_disabled() in
> ice_init_tx_topology().

Sorry for not noticing this in my review of v1,
but I would lean towards these changes being separate patches.

That not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

...

