Return-Path: <netdev+bounces-180564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67AA81B06
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510571B67F03
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59B13C9B3;
	Wed,  9 Apr 2025 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBx2WXWX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC829D0E;
	Wed,  9 Apr 2025 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165886; cv=none; b=j2iOwiwL/9PUNr4GiANfz5p19ZqPCgtiXrPFljbfPFHzrBhYFC6ao9x9xlCaylrD7k6f870bd0YERhI7w/KkfA5FZaWDWYKkOFYfnZRSh4edjA5tfFRLbFZG+7AuE70TpVzqxoDh9YO3ZJQeAhfmGoH959ti/b3VYnkldEppAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165886; c=relaxed/simple;
	bh=xOPz/3MoJhE0JQSF25YcCRj8bkBsU/2uvbH5OCTlVbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5TQA6JueW7iQLe7Xh1P7VkZH5E/efXvDngNxyPFP0V/GKdsOwu/wB0s+fHX2ShdHPV4pX0eNSmqAwSn41UrT9G3k3/MTeACdUR/TbJ6um2bMEiaOEYDspMWEEFOZVPpMIKnwlVHuDpV3gDZklo9wvIEolgbbzmk9r4mvTcflGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBx2WXWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E7EC4CEE5;
	Wed,  9 Apr 2025 02:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744165886;
	bh=xOPz/3MoJhE0JQSF25YcCRj8bkBsU/2uvbH5OCTlVbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nBx2WXWXgOOB8fM0F0qK5X5pTBG10sj6xNzEYvs8a9ZQsQ5p1scgivjx2kWt3DSUw
	 u9l+joPQ8mZOY2aUQ62iv0uAAWvmYKQxTSPSeYR0roMaZV8Cv8rJfRrP8EIzpvCion
	 qlvcAuJJB1H7hFotrKsWb00NPAZFUxGz3XAh/9+C9ELjjXzr9L9e2B2agWU2ip1qOA
	 xFw3MrpyU0mudUnamkmBpfWHpgv/AO/y6BmyPLZulrtl6dOSn4L4ORZd0uHdmOpcbn
	 2TeoPPpbMo3GgsZgD+9XJKg32mPJ+oZPuUIdrdsKo8/nHkUTVcMZqiqidEx2JH6evw
	 tRW9gNCTJLcVQ==
Date: Tue, 8 Apr 2025 19:31:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, Bharath R <bharath.r@intel.com>, Slawomir
 Mrozowicz <slawomirx.mrozowicz@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>
Subject: Re: [PATCH net-next 10/15] ixgbe: extend .info_get with() stored
 versions
Message-ID: <20250408193124.37f37f7c@kernel.org>
In-Reply-To: <20250407215122.609521-11-anthony.l.nguyen@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
	<20250407215122.609521-11-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Apr 2025 14:51:14 -0700 Tony Nguyen wrote:
> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> 
> Add functions reading inactive versions from the inactive flash
> bank.

Just to be crystal clear -- could you share the outputs for dev info:
 - before update
 - after update, before reboot/reload
 - after update, after activation (/reboot/reload)
?

AFAICT the code is fine but talking about the "inactive versions"
is not exactly in line with the uAPI expectations. 

> +static int ixgbe_set_ctx_dev_caps(struct ixgbe_hw *hw,
> +				  struct ixgbe_info_ctx *ctx,
> +				  struct netlink_ext_ack *extack)
> +{
> +	int err = ixgbe_discover_dev_caps(hw, &ctx->dev_caps);
> +
> +	if (err) {

Don't call functions which need error checking as part of variable init.

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Unable to discover device capabilities");
> +		return err;
> +	}
> +
> +	if (ctx->dev_caps.common_cap.nvm_update_pending_orom) {
> +		err = ixgbe_get_inactive_orom_ver(hw, &ctx->pending_orom);
> +		if (err)
> +			ctx->dev_caps.common_cap.nvm_update_pending_orom =
> +				false;

This function would benefit from having ctx->dev_caps.common_cap
stored to a local variable with a shorter name :S

> +	}
> +
> +	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm) {
> +		err = ixgbe_get_inactive_nvm_ver(hw, &ctx->pending_nvm);
> +		if (err)
> +			ctx->dev_caps.common_cap.nvm_update_pending_nvm = false;
> +	}
> +
> +	if (ctx->dev_caps.common_cap.nvm_update_pending_netlist) {
> +		err = ixgbe_get_inactive_netlist_ver(hw, &ctx->pending_netlist);
> +		if (err)
> +			ctx->dev_caps.common_cap.nvm_update_pending_netlist =
> +				false;
> +	}
-- 
pw-bot: cr

