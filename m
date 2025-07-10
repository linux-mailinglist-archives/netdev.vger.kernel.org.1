Return-Path: <netdev+bounces-205591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15539AFF5E5
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79E97A70D6
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EEEBE4A;
	Thu, 10 Jul 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj5PV3vH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DDBA34
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107110; cv=none; b=W3KxuXSvL0T+4eopAl2+NYFjsj3xSqw8yrgxArGvNSu7mPKmsquwXhuseJpOwCjLVqMeqpsyNwnAfS00sLGNkEjvghbDu0M2HSjzI++1H6WZUu4DqSV1KMPeW83CWmz73YiHDPtKxxvC4TgMKpOn+Q2DJp0wBRuylc/o5IdSJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107110; c=relaxed/simple;
	bh=KLpGpaUJ4fjP1ZcxNAcPjs8WSSeWBvAAz1rdG3SBmW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=io9vxEdEVoC4VRl2a3oFYg6NSLWf364RochH6AtyxXciC7LQWbkuKctO4ryOpuTIziMZriwtSBcrFEYlYupcHlZAYKkBLLKSm9E2nm8GNKlYF2JBDuwUiKeCYH4WisRYyTvoOhoPh3KIq8lAxUB2viMEqARIp3YYzlCd/wilIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj5PV3vH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61159C4CEEF;
	Thu, 10 Jul 2025 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107109;
	bh=KLpGpaUJ4fjP1ZcxNAcPjs8WSSeWBvAAz1rdG3SBmW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hj5PV3vHwjWajR9PTucmd2WCXGVrxsRbi2Htl9um8PW/N3AbOpJEKuT5o17hX7IH7
	 1pxC/445IMAMkJpf1O7ZUnWRsQ9ftbc4u+JW4UX6KnDvRrEs5YIsEFDRkOBbu2jVU9
	 0W2U9FIDM7dBlr0SxUTpGDGMqXjyjOMmEbdwOxkIvdWS8lhalRmuuOIXWESmTx6URh
	 /BgaRy78k46dlHj0AKmZirdj6jDy8VvH3mMVbQ32VDmQqEGwHVYUdGRxZj6FGZwZBZ
	 yncj0AvXeAJMN69VAWmhixqJHoh4HfDnZPOlLclkkBD8ntwHgM6Jn9teqCzIq269GJ
	 5LqN/RIEHn17Q==
Date: Wed, 9 Jul 2025 17:25:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] ethtool: Fix set RXFH for drivers without RXFH
 fields support
Message-ID: <20250709172508.5df4e5c9@kernel.org>
In-Reply-To: <20250709153251.360291-1-gal@nvidia.com>
References: <20250709153251.360291-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 18:32:51 +0300 Gal Pressman wrote:
> Some drivers (e.g., mlx4_en) support ->set_rxfh() functionality (such as
> setting hash function), but not setting the RXFH fields.
> 
> The requirement of ->get_rxfh_fields() in ethtool_set_rxfh() is there to
> verify that we have no conflict with the RSS fields options, if it
> doesn't exist then there is no point in doing the check.
> Soften the check in ethtool_set_rxfh() so it doesn't fail when
> ->get_rxfh_fields() doesn't exist.  
> 
> This fixes the following error:
> $ ethtool --set-rxfh-indir eth2 hfunc xor
> Cannot set RX flow hash configuration: Operation not supported

Ah, thanks for the fix!

In this case I wonder if we wouldn't be better off returning early 
in ethtool_check_flow_types() if input_xfrm is 0 or NO_CHANGE.
Most drivers will have get_rxfh_fields - still there's no point
in doing the check if they have empty ops->supported_input_xfrm

We could add a:

	if (WARN_ON(ops->supported_input_xfrm && !ops->get_rxfh_fields))
		return -EINVAL;

into ethtool_check_ops() and we'd be both safe and slightly faster.

WDYT?

