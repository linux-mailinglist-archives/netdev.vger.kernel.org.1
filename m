Return-Path: <netdev+bounces-163252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE73A29B61
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAB916487B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158D1FFC4B;
	Wed,  5 Feb 2025 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjFBUq7V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05171EE7B3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738788352; cv=none; b=Cji6Zl7UlHJXMt3x0iYJcEjdwW78VTB2pTv44hJk4XF0T1/YxoVaSoLuT8XW36urtzXYga7iGc67YNf2v7ptb3fjN1//VL+crbAq160hBRPzGruTjSaKPXukt9tDK6Jv8VLtwbtuGr13EvmiC7ptTdXqrsJwrB7Hkh3tXTlhf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738788352; c=relaxed/simple;
	bh=//uWnG9TvWTqr2If/A6gaUTJzjuhsAIXJ4fNcNm4KVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkqUFAchDD73fZ2cxH1meYQ9jzlrayYBJ5n+wlel9CbsINXbnKhJtHMpVLYSDrEbyib4LB3B/+x64tZXW0e8UpWpYMLs1XJqiO5+oVkYKLl3PxceuG2tNckXSoTpF2nBEeuElPVVKuIVHANkGtq3NsSC4TxDgPM5ZfiWxydZxXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjFBUq7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444A6C4CED1;
	Wed,  5 Feb 2025 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738788351;
	bh=//uWnG9TvWTqr2If/A6gaUTJzjuhsAIXJ4fNcNm4KVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjFBUq7VFNjKcOh3q8bv7cM+lBMXZ13OVGeDcO2cEJ/16hEp6qVfyqxXmKqNfe/l+
	 BhJ1SLQteA0knGw1GNvhF5f8D24CpV/+/8XmJPYrroM8XpSLOOU4GQw8OiWR86VVV2
	 8ffsfCVo96sy1CHvwTNjnp5S14MxxZKi6icCwZnze73eOY6HL1H4e4Jw4iJpIq2kN2
	 7lMKazDsC4RWvJrGLRZoMmdgJ8lRJjobIIhTASt+2bfbRLuCuan+ajhbXmlwX1xtFI
	 oA7Lwz8O4T42FKwlROkHwSAI5pGQARs5gMzROlCra+q7OKKZYeylWscnci+y4hg1cR
	 5e8SxhRla2nfQ==
Date: Wed, 5 Feb 2025 20:45:46 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH iwl-net] ice: health.c: fix compilation on gcc 7.5
Message-ID: <20250205204546.GM554665@kernel.org>
References: <20250205104252.30464-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205104252.30464-2-przemyslaw.kitszel@intel.com>

+ Jiri

On Wed, Feb 05, 2025 at 11:42:12AM +0100, Przemek Kitszel wrote:
> GCC 7 is not as good as GCC 8+ in telling what is a compile-time const,
> and thus could be used for static storage. So we could not use variables
> for that, no matter how much "const" keyword is sprinkled around.
> 
> Excerpt from the report:
> My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.
> 
>   CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>                                ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
>    "Change or replace the module or cable.", {ice_port_number_label}},
>                                               ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initialization for 'ice_health_status_lookup[1].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
> Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/netdev/CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> I would really like to bump min gcc to 8.5 (RH 8 family),
> instead of supporting old Ubuntu. However SLES 15 is also stuck with gcc 7.5 :(
> 
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Kees Cook <kees@kernel.org>
> CC: Nick Desaulniers <nick.desaulniers@gmail.com>

Hi Prezemek,

I ran into a similar problem not so long ago and I'm wondering if
the following, based on a suggestion by Jiri Slaby, resolves your
problem.

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index ea40f7941259..19c3d37aa768 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -25,10 +25,10 @@ struct ice_health_status {
  * The below lookup requires to be sorted by code.
  */
 
-static const char *const ice_common_port_solutions =
+static const char ice_common_port_solutions[] =
 	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
-static const char *const ice_port_number_label = "Port Number";
-static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
+static const char ice_port_number_label[] = "Port Number";
+static const char ice_update_nvm_solution[] = "Update to the latest NVM image.";
 
 static const struct ice_health_status ice_health_status_lookup[] = {
 	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",


Link: https://lore.kernel.org/netdev/485dbc5a-a04b-40c2-9481-955eaa5ce2e2@kernel.org/
Link: https://git.kernel.org/netdev/net-next/c/36fb51479e3c

