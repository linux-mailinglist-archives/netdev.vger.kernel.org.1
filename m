Return-Path: <netdev+bounces-111859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A870933B2B
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 12:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFEC2838C0
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746E114036F;
	Wed, 17 Jul 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4WyBy4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA38374C2
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212474; cv=none; b=hhAsBsRUXkDZB8MHHl9IcW7y9/LW/wQo9JcyyGU+t3IazhdiCDMNZJwe1Q5waMcanDkkvZT6RZjWqQ9/pR6ojdO7ZhOJDfEVytQNoBOEZVRuahdwcHddTfJT0BBUMZvreQZE9NKh0gL4Yxl2MRyNgyWSmtNJ2Pja56zt2q/TSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212474; c=relaxed/simple;
	bh=BWONjJuPYbLkbk6R0VzOxPRnfY+qcY63hLYiP/w8M6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0qijadKukerM6Fq13ROALbkdEYzsv0750XgVbVklYx3GyqIunj21WzQNA9a3y3e2MiY66IOuw8qeGf0vOhNXTtvYXHNod0Y6cdGWYHRGOnSfkhqjqCRh12mpLjfq769Nw28s8bStPi2kRrckdwY6VK02xVt4Zx/ip2nh8HUo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4WyBy4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608C5C32782;
	Wed, 17 Jul 2024 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721212473;
	bh=BWONjJuPYbLkbk6R0VzOxPRnfY+qcY63hLYiP/w8M6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4WyBy4Ei/gt5vJUhiOfkKUqqE6KaUmmaRt49Qiz1wJcL8fyGpY4ibC/4PHwZC+2A
	 Rr2CBUmytHY6l4x8DAET5agBFWbJDRBivxvrQFjjWZ9b+r0kjjk4UISrhiQDj8aBcP
	 N3TCNcydVxNzq0RkcrdwQqfQ986/W7YvldWa+kBtyq1cHysIl9+rIs6ahVZ4YlPgzi
	 HME9wODGrS/7yneg4GF/OkZ3uBhgAxWKqsKhcGLMwnDYgtPfmYjkwsHT//GKMoHMTl
	 vBEUiLnZESZgvVsrptXQ8NEl38LmTXalnykU37LmZk+HzymIAbeTz6ugHpbf5MMfga
	 x9Jhi37ZhhyjA==
Date: Wed, 17 Jul 2024 11:34:29 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [PATCH net] net: airoha: fix error branch in airoha_dev_xmit and
 airoha_set_gdm_ports
Message-ID: <20240717103429.GI249423@kernel.org>
References: <b628871bc8ae4861b5e2ab4db90aaf373cbb7cee.1721203880.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b628871bc8ae4861b5e2ab4db90aaf373cbb7cee.1721203880.git.lorenzo@kernel.org>

On Wed, Jul 17, 2024 at 10:15:46AM +0200, Lorenzo Bianconi wrote:
> Fix error case management in airoha_dev_xmit routine since we need to
> DMA unmap pending buffers starting from q->head.
> Moreover fix a typo in error case branch in airoha_set_gdm_ports
> routine.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


