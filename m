Return-Path: <netdev+bounces-218831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69876B3EB9C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8F33A3CB4
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6E2D594D;
	Mon,  1 Sep 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlrI4CBq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4AE2D594A
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742105; cv=none; b=Q+5x/HyMS8o/DbtssgNvc6dSHNumUOfmZxWsndAp9CVJgn4ImI22ESO+4ITEIAYJvRqEZjnxD4NWBwZgeR4HiHpx3NopaJcjazuaMafmO/3XQSGbAEm+k5aunAKtQrXPioXK20Hn5fVpe+HmXtONcIqkfkWEynvZ9m+62nf84as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742105; c=relaxed/simple;
	bh=zfMy4L8Y4bkgqkt5WUUFvLAnVkXewiemnAZWXsimGjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOh47QAADvbSBPdh382X04kJ10k1OXuCush8+YIRh0g637bcEUtR+1W74hWwSSsz4hQSLYyQK+1fNO/Zvj1wUlp7YFVt1wEv9DXy9E0VhM5ncJuC1zGMxBxWlskpJbtZvo08nIq92GOrYKD52JvmMVuqigekGpll8sesdQhsqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlrI4CBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF66C4CEF0;
	Mon,  1 Sep 2025 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756742104;
	bh=zfMy4L8Y4bkgqkt5WUUFvLAnVkXewiemnAZWXsimGjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlrI4CBqajyi9YeFcjxMUn/6gI2z4AJVjeTgP8YnF1sb/jekhXnl0nXcSuCFJLWEL
	 6BQkBjQr9IZWww5sqdjdrm304HhCh6R3f2hrUYxK/H2K7fNpOw3b+Nw3mAjggZZ1Rl
	 UglkPhGt0q/hQ2ySBEY6C+tanTq98WCv4dGyVOfliiB2IXKBKz0Bd2O/jv8254pbfy
	 zCfjwaIkk5KqAv+GwmfNYMQhv/Efgg/Znor10eeNkK5mlym9FjjKvpDytKwaWUCqGX
	 0JEiYLFvsee1PVR72umIANAgUzKSoIPxJluhu/VpgBFBVyM7/oQvxIji8sDJ2h/o7/
	 dO2I8/WdB16Lw==
Date: Mon, 1 Sep 2025 16:54:59 +0100
From: Simon Horman <horms@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, hacks@slashdirt.org,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Lee <igvtee@gmail.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix tx vlan tag for llc
 packets
Message-ID: <20250901155459.GK15473@horms.kernel.org>
References: <20250831182007.51619-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831182007.51619-1-nbd@nbd.name>

On Sun, Aug 31, 2025 at 08:20:07PM +0200, Felix Fietkau wrote:
> When sending llc packets with vlan tx offload, the hardware fails to
> actually add the tag. Deal with this by fixing it up in software.
> 
> Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
> Reported-by: Thibaut VARENE <hacks@slashdirt.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Simon Horman <horms@kernel.org>


