Return-Path: <netdev+bounces-112822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4992A93B614
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 19:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AD8285FBC
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217515FA74;
	Wed, 24 Jul 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqUbpi6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AB1BF38;
	Wed, 24 Jul 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842837; cv=none; b=ZgnmzJjorzQ67EbmaeC25Rlaf9PbXqy/NMhVSTi9jFOj+57nKujqKef3fPdzhlfxE4SdArmOVt0fNK2D/ZbxlbCcX/nbGUn5xE+/d+M+K7V+i+cBOJ1jPi6tF3hF11qDmSIuP2pXyJUTurTB9uZNVc1D988pgdm06S8JRxebFsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842837; c=relaxed/simple;
	bh=SOl/CnsBeml/c/uFV3EVy7ROsbF7eOEe3MGPrAA8AiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDHgrlbIymNR94LEOYlLTITODpRMXdsGxZH9yuZVeThoW58vRvgKOrF3ReSzrzV4rpxndsSk4DAjBCPZkrNztrs2al2rYYjmizUOZgR3sPbJ1r7Flk5hqUFC5qXbWLTjRyE5WKahC2B0SzeH4k/3vDpXj0Z8zWes/mJwSPKNNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqUbpi6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F26C32781;
	Wed, 24 Jul 2024 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721842836;
	bh=SOl/CnsBeml/c/uFV3EVy7ROsbF7eOEe3MGPrAA8AiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqUbpi6gNeWL/Lz7GUghvjd66vRZhZGhounFOZLOYDRsEHCjBpc7JiRrSrwPHUt9+
	 Gh5+Vkg9CXtRqozH5m5U3tz3aHpNjP6ZhsvJo0voIXqWO/R2BAXbqIkwVfcpeqCMPL
	 cFhgX33eZNkVi9IdTNekrGVc4XOb6/FoN8H8TRHvz/btOi6KjKe3/5dA1s0+lsemIJ
	 tnNVHb3ldFlDcfdLRIUhwHt2D8dur/ytsbk/TeDahOeXAL2DCT2EY28UiwUgGylg2B
	 LBxAtgEHGuLkyPa5u7awYaoYHf2iqJmE8yQh/7/eZTg6LrSzP7NvzISxlxSEuXh0wy
	 geWMa1w8W4FTw==
Date: Wed, 24 Jul 2024 18:40:31 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	leit@meta.com, Dan Carpenter <dan.carpenter@linaro.org>,
	"open list:MEDIATEK ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net] net: mediatek: Fix potential NULL pointer
 dereference in dummy net_device handling
Message-ID: <20240724174031.GF97837@kernel.org>
References: <20240724080524.2734499-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724080524.2734499-1-leitao@debian.org>

On Wed, Jul 24, 2024 at 01:05:23AM -0700, Breno Leitao wrote:
> Move the freeing of the dummy net_device from mtk_free_dev() to
> mtk_remove().
> 
> Previously, if alloc_netdev_dummy() failed in mtk_probe(),
> eth->dummy_dev would be NULL. The error path would then call
> mtk_free_dev(), which in turn called free_netdev() assuming dummy_dev
> was allocated (but it was not), potentially causing a NULL pointer
> dereference.
> 
> By moving free_netdev() to mtk_remove(), we ensure it's only called when
> mtk_probe() has succeeded and dummy_dev is fully allocated. This
> addresses a potential NULL pointer dereference detected by Smatch[1].
> 
> Fixes: b209bd6d0bff ("net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/4160f4e0-cbef-4a22-8b5d-42c4d399e1f7@stanley.mountain/ [1]
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

...

