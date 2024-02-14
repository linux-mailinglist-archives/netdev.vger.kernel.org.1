Return-Path: <netdev+bounces-71591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1469854165
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1942827B5
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 02:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BA05398;
	Wed, 14 Feb 2024 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktWfJ38Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4546AB
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876833; cv=none; b=trzQMw3GOOp5BvejmtZn93Jy8+WWEqfgFlu+iWtQAK685YlDi8bBenDYFPphgnuqcvgMRN7pUJHl2nbhLVsstTp1Y8pBtdYloedaqJpowS30u9aELGis7ouOJGzX70F9tFO50OohI4Qha+Xn3IjFCMpOR8ncVmtJkFWaYQJLsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876833; c=relaxed/simple;
	bh=lQNXSwJuhMO0vRmlUmCazz/caFJslTJfAuXVjDyef38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+c477/Zj6lB/PhUdfUq4UewvAntt42zPh0VY6PXLXG5dl2bEQswwyQDEw3BZMSo41a0WqpjOSXR7qmiLlcdURLnTFm5t05bbsN217j9nRVXRBlcRwzENhcrK6RwmbQ0TTe5fovrxSh0CdvX6BaXdtLi43WtNZB57CiqGXDlpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktWfJ38Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5E5C433C7;
	Wed, 14 Feb 2024 02:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707876832;
	bh=lQNXSwJuhMO0vRmlUmCazz/caFJslTJfAuXVjDyef38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ktWfJ38Q0dUcH6T8zWlNcGLYs5b3IJvc150zAC4qCHw5tyPOvu/uRZIARkgukup9h
	 h5J74yyUEi2STrwPxKIhZWiSYjPOcWZakudrEdp9LT5UfXS+twIETx7ykqNko8M/+S
	 rsby2D+opQllO6xLe8E1ObdSSZA+UXu0U3GeH6TNkQoZxzMeWKrQLsrMbLQ+blm4V2
	 787si9fYmxol/1PUoPgD04cfRFq/H7MQvVwc7VOxvc7D9Eq7qJ5D0Yl6vYOYpMk/Cv
	 I63/CqTZ89z3lw4O7uRfbcPH0b44A5wa4ulTcEcRusFkHcT39sFDGIPpwPBrFlqCkO
	 4tH6+CKzowvZA==
Date: Tue, 13 Feb 2024 18:13:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Ariel Elior
 <aelior@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, Manish
 Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Raju
 Rangoju <rajur@chelsio.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Jay
 Vosburgh <jay.vosburgh@canonical.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Richard Cochran <richardcochran@gmail.com>, Maxim Georgiev
 <glipus@gmail.com>, Emeel Hakim <ehakim@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH RFC net-next v1] net: rework FCOE and RFS ops
Message-ID: <20240213181350.1755f669@kernel.org>
In-Reply-To: <20240210021000.2011419-1-jesse.brandeburg@intel.com>
References: <20240210021000.2011419-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 18:09:57 -0800 Jesse Brandeburg wrote:
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10416,14 +10416,11 @@ static const struct net_device_ops ixgbe_netdev_ops = {
>  	.ndo_setup_tc		= __ixgbe_setup_tc,
>  #ifdef IXGBE_FCOE
>  	.ndo_select_queue	= ixgbe_select_queue,
> -	.ndo_fcoe_ddp_setup = ixgbe_fcoe_ddp_get,
> -	.ndo_fcoe_ddp_target = ixgbe_fcoe_ddp_target,
> -	.ndo_fcoe_ddp_done = ixgbe_fcoe_ddp_put,
> -	.ndo_fcoe_enable = ixgbe_fcoe_enable,
> -	.ndo_fcoe_disable = ixgbe_fcoe_disable,
> -	.ndo_fcoe_get_wwn = ixgbe_fcoe_get_wwn,
> -	.ndo_fcoe_get_hbainfo = ixgbe_fcoe_get_hbainfo,
>  #endif /* IXGBE_FCOE */
> +	SET_FCOE_OPS(ixgbe_fcoe_enable, ixgbe_fcoe_disable,
> +		     ixgbe_fcoe_ddp_target, ixgbe_fcoe_ddp_get,
> +		     ixgbe_fcoe_ddp_put, ixgbe_fcoe_get_hbainfo)
> +	SET_FCOE_GET_WWN_OPS(ixgbe_fcoe_get_wwn)
>  	.ndo_set_features = ixgbe_set_features,
>  	.ndo_fix_features = ixgbe_fix_features,
>  	.ndo_fdb_add		= ixgbe_ndo_fdb_add,

If we'd be having a vote - I personally find the #ifdef far more
readable.

