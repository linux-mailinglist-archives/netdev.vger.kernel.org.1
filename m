Return-Path: <netdev+bounces-108416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49956923BE1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1041C21F80
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC93158DDD;
	Tue,  2 Jul 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEwIsnTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3071158DC8;
	Tue,  2 Jul 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917658; cv=none; b=ZSKkmiBWDLsqwLLMJ6WgtuNkjJuZATEXR3oZkK3IujVKPiBklgUctokLjYXFF++S218LRi9H4Qiuth4nbjqSAm7wx/+iY4xMYE9ZC2Z8FQjtWvr1ISGjpLsyO+lQ/fxv++E/z/CBuXMCwocVuthTmhWWwFkmd8dyHXDGEnK1GGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917658; c=relaxed/simple;
	bh=Nu8B5T3JPPoNTLLDtfwHrdmFJU39KKRK+9B2K65Fz/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2JFB9SRGLdO0QkyC4YIZC3GPsWXRmY1d+KlHwrDrvOEjtHg/PS0E8k86vyclFbUhuCc3Ec2H8JeuIwPKU4Ht+Kp0NUfU42mLncRzmIzo9UM+GlD0TaJXzOBNvX0ljsww8QwJIT2vPTZUEFyFnKmWjm2v15t+W8McR89lsgnusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEwIsnTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF43C116B1;
	Tue,  2 Jul 2024 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719917658;
	bh=Nu8B5T3JPPoNTLLDtfwHrdmFJU39KKRK+9B2K65Fz/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEwIsnTs270z1fMt+nZIvziWDZ3zar11CzHZq7+xfW+jN1p+6jbjSzgBSqEDYI3i8
	 dJzVDuUmuatTpHfgjIdwJvxW243AbmSohCvJNvU265Mn8SdO5zAyYXSxv+CfiJGARQ
	 yFGxeWQZ/XWUnwqkzsgOM2RSQox9FWPQTw9bbexW9sXkDikVWO+o7S0bGdQaEzg/CZ
	 942RQgxRaufFkXtcKpihct9H9psd63kaatKJ9dN15hu8nfSO/ZrG4R6RNy7NDkLlzB
	 dTY8Xxqm3Lj3bW9g0KdTnGrPO12yMH+6yBCmzJxf4oVaZby14PbIewL9ke25JZW+zc
	 s/4cMFWisQkLw==
Date: Tue, 2 Jul 2024 11:54:11 +0100
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next v14 12/13] net: ethtool: strset: Allow querying
 phy stats by index
Message-ID: <20240702105411.GF598357@kernel.org>
References: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
 <20240701131801.1227740-13-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701131801.1227740-13-maxime.chevallier@bootlin.com>

On Mon, Jul 01, 2024 at 03:17:58PM +0200, Maxime Chevallier wrote:
> The ETH_SS_PHY_STATS command gets PHY statistics. Use the phydev pointer
> from the ethnl request to allow query phy stats from each PHY on the
> link.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  net/ethtool/strset.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c

...

> @@ -279,6 +280,8 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
>  	const struct strset_req_info *req_info = STRSET_REQINFO(req_base);
>  	struct strset_reply_data *data = STRSET_REPDATA(reply_base);
>  	struct net_device *dev = reply_base->dev;
> +	struct nlattr **tb = info->attrs;

Hi Maxime,

Elsewhere in this function it is assumed that info may be NULL.
But here it is dereferenced unconditionally.

Flagged by Smatch.

> +	struct phy_device *phydev;
>  	unsigned int i;
>  	int ret;
>  

...

