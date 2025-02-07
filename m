Return-Path: <netdev+bounces-163907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCAEA2BFF1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DDD7A06ED
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104F11CDFCC;
	Fri,  7 Feb 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTBC679Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C1199385
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921958; cv=none; b=qScH89or6bvqshfSDGZRUEto6CJ3vDYGev8yBUTuFdyJ70rwWquqPcMext9EDmg4lVJFXfArWuneviRILd0If/gUPq359Z+MUiM0mOP1TOi91PCJ8NcYU9ywb1aJ0EYybIGrhKvEobfQj5H7KGXcbHNS2dnmgmWvwNHoPieefhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921958; c=relaxed/simple;
	bh=ozVyJ7cTy7If5xX1T25j3icBhBhcMNuBTKqE71SN3Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOAw69UwHMyeLtJWagU0Ur04DUIJdZgJRAUnfs9wOgN1qub3L07N+N9HTthMwyy5DlGkaYl3NN4mu5F2hL47XKoylHw2weknYiuNCPERNWpTjUEs20tnIWz/W3YxidBPC3O51iLgj2QxfYMk4MDnJVzl5E2FVCZbtEQpuFGcLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTBC679Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67907C4CED1;
	Fri,  7 Feb 2025 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738921957;
	bh=ozVyJ7cTy7If5xX1T25j3icBhBhcMNuBTKqE71SN3Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTBC679Yis2+F+KclVsIb0rzgmPgeke9+S2XewYsPVyEnQXGkpS6hDmIhMUa7bOut
	 PccN/JQiwt1/yY2Cq1qY4LD3SpB+2i9c7y/dpALC8jW5ifuDC5AE6k53n1vUKOPayW
	 dSYo2OSLvQx0ZyHdsHTssdc4ByOrfRkKh/prEu4XX7mXh+05/8+jueZdNpgkinLmMQ
	 MjUTJCfk1+BoHBhSWubTEQmxP3azWLTBL5/Dvv2V6Al2E7NSZFDt8bz3WgzDXzz0hS
	 GTa1WMq5pTVImXhy8nbGssOXMsAIkgLOn4N7Ssf7IhddKAPNSlYyyCthvg7Qp1dXBv
	 AEecz12BlxZ/w==
Date: Fri, 7 Feb 2025 09:52:32 +0000
From: Simon Horman <horms@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: ethernet: mtk_eth_soc: Use
 of_get_available_child_by_name()
Message-ID: <20250207095232.GG554665@kernel.org>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
 <20250205124235.53285-6-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205124235.53285-6-biju.das.jz@bp.renesas.com>

On Wed, Feb 05, 2025 at 12:42:25PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> mtk_mdio_init().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped using _free().

Reviewed-by: Simon Horman <horms@kernel.org>


