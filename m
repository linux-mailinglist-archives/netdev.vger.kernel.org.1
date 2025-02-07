Return-Path: <netdev+bounces-163906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B615A2BFEF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A1B16801A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310F61DC99E;
	Fri,  7 Feb 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBBuhvBr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD48185B5F
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921915; cv=none; b=bmhJoZ342ObZK7Jos4AeHXHdun5PRfUjen6FGt5jz1ReyS23f0cjp2QGFzGBRhwLlhbTJKXmzyYdguaKEEvAHpLY5XUd9sxS6iDcPtECnA/mOq9X8QZt02Y3O2ZhqqOp3mDQs+Br13xtTE2KUWGd7vLmhoVdJtukvlVCgeodxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921915; c=relaxed/simple;
	bh=pGp9qmyuezgS3IHcjWS1ZLSejdTrShrKN2qIfrysIzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzpG8i60UQFadiWBhka61/7E/RMyTdY95ktx+UANli/r6epMfR+f/qKxqDHJRiCrpkz+xAoF6msVXjgfBgTAv1zWJDsnjTF5D8pz3va7iIkOFznFbTJo1yCacJnvNhLCqdXCZgcvs4V0Q2mhR2CxC6u4V0qa2Zyg/ipuSn8LzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBBuhvBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7713CC4CED1;
	Fri,  7 Feb 2025 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738921914;
	bh=pGp9qmyuezgS3IHcjWS1ZLSejdTrShrKN2qIfrysIzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBBuhvBr4yJ59FMW5bgFBDQz6RpDE9LmaYDwu20N5kZRPUKW8HAgyQvKKHX/edC6O
	 lKP+TlJni+ZFh9y+8xRARleZbWjY1sHQzgmED/NPyZ+6FNSWSC+9z+zbfrTCTBmcrt
	 GgWybv88IJEBO/XF2swByM/A8YWmRh5JRWkc+8j+OBz1SiDpsk1VAWDfSVZrISbv7g
	 Z6U0hsgBcUBdh2c887D2NHOBnwC9fo4OX/x/RDDihl272pLVGvgHawMAGwg3x0EXC2
	 NIu58nAMAEhEFAZf5OlgoQXx5PwriWdaPCwxZfQAHyefPxaVL7W0VMvUrQeqdcK6YE
	 1ouXbHCZS7e8A==
Date: Fri, 7 Feb 2025 09:51:49 +0000
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
Subject: Re: [PATCH net-next v2 4/7] net: ethernet: mtk-star-emac: Use
 of_get_available_child_by_name()
Message-ID: <20250207095149.GF554665@kernel.org>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
 <20250205124235.53285-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205124235.53285-5-biju.das.jz@bp.renesas.com>

On Wed, Feb 05, 2025 at 12:42:24PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> mtk_star_mdio_init().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  *  Dropped using _free()

Reviewed-by: Simon Horman <horms@kernel.org>


