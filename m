Return-Path: <netdev+bounces-106712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20091755C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E543E282F90
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF38495;
	Wed, 26 Jun 2024 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO1sLZOG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471B4C6F;
	Wed, 26 Jun 2024 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363276; cv=none; b=YYVQKn3ZbppRvbPfKTQjA/n1esL4yt/nbp/I7LMhEU2S3qDV/rb9HUiSLeaq2hf/JSAzJJmE/rxdgZ1dxHeAfB9Vc2A8G83m2cdlNVc85ci1aq8wDv1fXBHon06cY2EVJRDf81WAnymo4F/R2vNM9y8C5ZpSnnoS6P5+5Pbtj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363276; c=relaxed/simple;
	bh=xMiXrxWpqFvHwNreomzAVh6+pEq2p+w+8MNiSYQC9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc7y8niurBHfWepRibjQAanlH5evwXu3ciDCKcaSz8MzUuvGkjGI14e04ZUiNox3mBN0pSRx13+88tonG8MxSMLSqj1ZH9EwqQrsael7PulNpiXNvqljC42jxEh0/DF/0sbP2PCPWCS0454zKPjuj5X/TFWI9zjCKE7nBWnKZm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO1sLZOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BC6C32781;
	Wed, 26 Jun 2024 00:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719363275;
	bh=xMiXrxWpqFvHwNreomzAVh6+pEq2p+w+8MNiSYQC9Qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oO1sLZOGd4dn/1GJXV0GO6FkLkQleqtP2qYcRqaQn8B1V7Uo/0/fhQc9nl7XNuPxO
	 sudgtwV/u3fPLA0ocKVD8hf0k0+iUozSZCy3LWl1st9PEGzb4vixYzDk930VPSPmfM
	 p9+crUVwlZsilwstkFxG332R6/BsLJN7aHvHZq2+p5dV7ghe94dvONHOXvVOBKe+Fy
	 nhuDYId/UDhtJrywcxQ+9n1ckEpknb0cOT5NFFHO99Lno+cRrW0qKx0EOmGbyKWrfC
	 Wd92jaMcOlkS9juTlhltYYzQccPAOMgeOsB2Qu2xIyP7cV0cTawoSmIPBpnw42pH7M
	 s7aLsxn2nohXw==
Date: Tue, 25 Jun 2024 17:54:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Sunil Goutham <sgoutham@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, horms@kernel.org, linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER), netdev@vger.kernel.org
 (open list:NETWORKING DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: thunderx: Unembed netdev structure
Message-ID: <20240625175434.53ccea3a@kernel.org>
In-Reply-To: <20240624102919.4016797-1-leitao@debian.org>
References: <20240624102919.4016797-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 03:29:18 -0700 Breno Leitao wrote:
>  static void bgx_lmac_handler(struct net_device *netdev)
>  {
> -	struct lmac *lmac = container_of(netdev, struct lmac, netdev);
> +	struct lmac *lmac = netdev_priv(netdev);

I think you are storing a pointer to lmac, so:

	struct lmac **priv = netdev_priv(netdev);
	struct lmac *lmac = *priv;
-- 
pw-bot: cr

