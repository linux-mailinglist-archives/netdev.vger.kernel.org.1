Return-Path: <netdev+bounces-131233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DC98D675
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C521C22422
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763C1D0BAA;
	Wed,  2 Oct 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICpUWMUD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B01D0BA7;
	Wed,  2 Oct 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876371; cv=none; b=Jq+882ISQt8tY4zFj//wGH6TKO52b0b9p+SU6dZ26cbsN4x9xlvWgEirJParyerLI3YbS8VBTI1ueXSKwIPJg9i6vTG41mr5oxP+Ql7qyr+Wz80NNmWqTql+sA50PcfhCiV/8MkBbMV8Awj5J+eDejuEX72QO10Psv/oyW90HoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876371; c=relaxed/simple;
	bh=CGCzzzQ9dSBtd8vRh/YwAHCQHlE6eRshRNhZnKLO3mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4/TXZqEnuHLF7PGmBWGx7qkYy0ICjoB0Q6DkKElaIjrGOoHMxGB5QXP4/heAYHUh48vlR+FgfvV3gPHauUJhMYZ7yYZ+YXajcFoxhzW/ub5u0tnUeazFOqDDyaaEYH8q9I014pSZ3k2DzBSNszmkvxzunPRa/Solmo/swxUV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICpUWMUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E599CC4CEC5;
	Wed,  2 Oct 2024 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876371;
	bh=CGCzzzQ9dSBtd8vRh/YwAHCQHlE6eRshRNhZnKLO3mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICpUWMUDIy/ik7NwN6UcqWNirKVKme46XWpLxkxaQh6Uze7ALqjJD2OfWzYWBmB19
	 Tppfj80vGRXnAxToHEhEVwmNHYrGG1Z6bx8kVUlc4KZwxewMNss1opUju6ERLY17If
	 BouUEm5ZE7SaXvv57elMSfqbNnjBAZ70wXq9vvNofqPcJxg0y+YV33jLT6bQzevAUu
	 SRSV+pxiMU+epGwwPkOGE4jrs0A/4FLSBqDOh9DWQLYF9ZzR1vwRnO+3P0J2XQFGnx
	 wL6f+lDV1zIpr55AzK6LBpj/MlNS4TWodjHl0dEKWUfLHz2nnn8BLFuO6m3Vsyl9je
	 d8IIoPH0Yul6A==
Date: Wed, 2 Oct 2024 14:39:25 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 11/12] net: vxlan: use kfree_skb_reason() in
 vxlan_encap_bypass()
Message-ID: <20241002133925.GG1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-12-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-12-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:24PM +0800, Menglong Dong wrote:
> Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
> skb drop reason is added in this commit.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


