Return-Path: <netdev+bounces-132707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F4992E13
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB1F280A19
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6FC1D54FA;
	Mon,  7 Oct 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxo3YbOM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723F1D47BD
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309584; cv=none; b=c8YElz5Z++boSpg8Aq3+8aT8xEcYd939e+xpNxD//0UWa/zdkJYGSEZxXhx1Ae1ga7gm0Yur7C+pcHcNTvSaOtkSaPkOtakslxqBffr0O0rl/zLppofbltBJ+rrTvw6VpPPkyCTA71qWWZiY8xXFtstYTHYmSlj0cku/fAsEapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309584; c=relaxed/simple;
	bh=j2KITGRUJh2rGqtoamaW9s2IDnoCKVh9a5TyQQoqQ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkJASrfCO/ixhUP+fxqhj4OHvGxWpRbOa8LRzfHum51O9uBmeBUVbQORrR4tux7+Ee+Y1qCjOLNBNP7S0USjn9wHthEX5bnjNoO+mWJnc2OoHDOP4ul0ZQsfA7IaavvYXb04t+HIANmU/OoUl/HtNpG8F2Qw+RYgkh3sP8dTx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxo3YbOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFC2C4CECC;
	Mon,  7 Oct 2024 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728309584;
	bh=j2KITGRUJh2rGqtoamaW9s2IDnoCKVh9a5TyQQoqQ8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxo3YbOM3U4jGqobpzw4AzbqBC7mPiB00NqK1EnxGc/OMB9886B7pMMv75qenhW7z
	 d90Zh596aqAa+AohB+60ixcNs1K5ud30z/7fA5u5EGCs81GvFj8nYMVS4fJ6/lE9RN
	 431MsYszwelYEr+0RNHm5982h9wsPItcGfug5LFNPPqbTWI0ft6YKMO/DEYB7v86ny
	 37hiRwVNb6NCxrRJs3HW0eHpzICpO9kaGmLN68Vez4IRgX2gExPATx6mQNiAYYqEoV
	 6QkuIkx7AEvvZLoBhWA8qrwntxS6dWl9/MMhztaWxSnoTey6lVufVFojBUGdTcXaZU
	 goOaz5QCC+TIA==
Date: Mon, 7 Oct 2024 14:58:09 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Update tx cpu dma ring idx at the end
 of xmit loop
Message-ID: <20241007135809.GB32733@kernel.org>
References: <20241004-airoha-eth-7581-mapping-fix-v1-1-8e4279ab1812@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-airoha-eth-7581-mapping-fix-v1-1-8e4279ab1812@kernel.org>

On Fri, Oct 04, 2024 at 03:51:26PM +0200, Lorenzo Bianconi wrote:
> Move the tx cpu dma ring index update out of transmit loop of
> airoha_dev_xmit routine in order to not start transmitting the packet
> before it is fully DMA mapped (e.g. fragmented skbs).
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


