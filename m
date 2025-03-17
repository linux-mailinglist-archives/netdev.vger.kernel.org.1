Return-Path: <netdev+bounces-175346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79BA6551A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48973A59B3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8B23FC7A;
	Mon, 17 Mar 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXVYyhb+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273321CC5C
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224156; cv=none; b=bLdNh1N5TJqYU/b1E9sr1r6OSZs4reewTvaN4tg4iXmllm2/y/dVNDzPk3mxSmWsql5+wCJeZlv9eQt/G7tvzU3Jyu+Hj9RxokJCU5hStU0lxBA3fbGdRPNSX8Uqah9/5evrhjoZTVuRcTDuavEBc0rs9mbV7295n4lDOwYF7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224156; c=relaxed/simple;
	bh=XmZSmQt3hmnAlvicryuljMp90xcAMZcIBCJeFedXzpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZhMkKzk+qPeFF/Qlvuy+9uquNnkPNsKvtkc8KP8JKpdcn9vCXiLj5YyracVPiFytglfiyyLj41ETnpzwp0W6qvquQbSc2m69FxE+nVHBwU04xag63PpeskhTxFZPgyhc6DQKr8Rf+bsTIH3sWOmgJqOzjzkvGjoi2NR8E7CPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXVYyhb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9D2C4CEED;
	Mon, 17 Mar 2025 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742224156;
	bh=XmZSmQt3hmnAlvicryuljMp90xcAMZcIBCJeFedXzpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXVYyhb+JqizRf6A8vpy0Q45wbF7wV01oXaYgXd+rhIc66+yzqHnswkPxSO5B7ol4
	 2km3pyRkhNUTPyh0bQN1T1674Dd0/tRG3JoEW4NkgR4nHouqAJq8xlxpMvF+21MFmD
	 qfE74efWUCAADT4C5zXxFy9Yvdp9M4ofz68GCtHtQVirpHMZBDWeq3IvcCXgV9EJSA
	 e6Bmi6lMPcJFpdNSU3Y3083yRTzR0tn6vkwXYtPs4E7ENMVSvfv6Ukcg5+RXC/JREw
	 GZ3RjeoDfizNP3mpAuYxjF2tvO9CGipq0t805rUHJHhiHViQz4+m5TSorGe84+DOpQ
	 +gINLAmc2uBwQ==
Date: Mon, 17 Mar 2025 15:07:41 +0000
From: Simon Horman <horms@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
Message-ID: <20250317150741.GA688833@kernel.org>
References: <20250310072329.222123-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310072329.222123-1-gal@nvidia.com>

On Mon, Mar 10, 2025 at 09:23:29AM +0200, Gal Pressman wrote:
> Symmetric RSS hash requires that:
> * No other fields besides IP src/dst and/or L4 src/dst

nit: I think it would read slightly better if the line above included a verb.
     Likewise for the code comment with the same text.

> * If src is set, dst must also be set
> 
> This restriction was only enforced when RXNFC was configured after
> symmetric hash was enabled. In the opposite order of operations (RXNFC
> then symmetric enablement) the check was not performed.
> 
> Perform the sanity check on set_rxfh as well, by iterating over all flow
> types hash fields and making sure they are all symmetric.
> 
> Introduce a function that returns whether a flow type is hashable (not
> spec only) and needs to be iterated over. To make sure that no one
> forgets to update the list of hashable flow types when adding new flow
> types, a static assert is added to draw the developer's attention.
> 
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

The nit above not withstanding - take it or leave it - this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

