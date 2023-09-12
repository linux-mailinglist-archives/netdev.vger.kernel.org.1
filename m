Return-Path: <netdev+bounces-33354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95B379D853
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51D4281FCF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D379467;
	Tue, 12 Sep 2023 18:06:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1733E9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D81C433C8;
	Tue, 12 Sep 2023 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694541999;
	bh=gQ3h/0qltbegfr5XcLpRJB3u5Gklgxi7lzJ/OKNiokU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9NDNX2zDehjHEvBEt1Y/GZxfI/JJA1uFq9UbFPWmTSQcJkmfuXcvJ8De+NqP4aOA
	 XcOWgQMeFX3ilmcNqdZQvCJ8iUAnfIkVpLaryWCs7sNj+79Qqb6NLbKOrS+5lRCb1Y
	 32J72P8O+X6xJvhYv/Pfo42mD11xOvzg8q9KpkKwDjETDq2LdC491s4qTiCeaDDxOK
	 sEBGv0ABBTHpJkRnhwtP78b14uxt2NWbar0FbCiD3aNcAecC8kCTMfjZwjvJGnNgRm
	 +u6sk1EPdsdmw0lC22/hClC9GIpS77mj5w+tDvfgrFdIIitl9Tu3WVFbo0W7D+V5J2
	 W0aEA4QzCTg5w==
Date: Tue, 12 Sep 2023 20:06:35 +0200
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: do not assume offload
 callbacks are always set
Message-ID: <20230912180635.GM401982@kernel.org>
References: <cedc0a98fb419f3d520a38271628e5d35a01be97.1694507095.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cedc0a98fb419f3d520a38271628e5d35a01be97.1694507095.git.lorenzo@kernel.org>

On Tue, Sep 12, 2023 at 10:26:07AM +0200, Lorenzo Bianconi wrote:
> Check if wlan.offload_enable and wlan.offload_disable callbacks are set
> in mtk_wed_flow_add/mtk_wed_flow_remove since mt7996 will not rely
> on them.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

It's not not a big deal from my perspective, but
I do wonder if these mediatek patches could have been a series.

> ---
>  drivers/net/ethernet/mediatek/mtk_wed.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index 94376aa2b34c..d8cd59f44401 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -1718,6 +1718,9 @@ int mtk_wed_flow_add(int index)
>  	if (!hw || !hw->wed_dev)
>  		return -ENODEV;
>  
> +	if (!hw->wed_dev->wlan.offload_enable)
> +		return 0;

A little further down in this function it is assumed that hw->wed_dev may
be NULL, a check made under a lock no less. But it is dereferenced
unconditionally here without a lock. This doesn't seem right one way or
another.

As flagged by Smatch.

> +
>  	if (hw->num_flows) {
>  		hw->num_flows++;
>  		return 0;
> @@ -1747,6 +1750,9 @@ void mtk_wed_flow_remove(int index)
>  	if (!hw)
>  		return;
>  
> +	if (!hw->wed_dev->wlan.offload_disable)
> +		return;
> +
>  	if (--hw->num_flows)
>  		return;
>  
> -- 
> 2.41.0
> 
> 

