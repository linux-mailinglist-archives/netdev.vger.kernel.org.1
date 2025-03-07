Return-Path: <netdev+bounces-172735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29DAA55D46
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92723B38D0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6051494B2;
	Fri,  7 Mar 2025 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pot8byB4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF82F32;
	Fri,  7 Mar 2025 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311982; cv=none; b=QRlO35tbxL+e34G1mEdXz6swQDokbsMyJhNYNSYOrTrzMA1A87dDa61lMPLgtABn4n4iT/LwGjoa78q4WYCf76+8hVZjKKVARcMQ72k02NM3nYNFJ8NmZkWbUwswAujfKXXKIyUuhb7cSdKCbiGjpNxl1OABQvEbwO7PHKORACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311982; c=relaxed/simple;
	bh=3fjEQVZj5R/i+h10au+bP7+11MkXIjAB6AmVfGlPLws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc1abhyD9xMu0ZuXZihbDQ3rtYX6VQ0xmGUJ55A5S4nYPKfGRvDtPpDyWgKV3/kSrt/HeBo78AD4QeF6Io6CODmQWyVIvKZjfF5QyS+qUlZY4DRMlPHefYDRyUtc5aQqRtE7k/XNwd3Vs88ems++p8I3n5JpTMrEFgAMCD3XnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pot8byB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62127C4CEE0;
	Fri,  7 Mar 2025 01:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741311981;
	bh=3fjEQVZj5R/i+h10au+bP7+11MkXIjAB6AmVfGlPLws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pot8byB4xcPLsXtXad9TN/FS7fjYQKJfCeJndIHQfwYHIoAS0hL6wfEb5eislpJIV
	 1F8Axu3Yu1ic4oisuAKLHkxVDUeZ72BVJgX1e6KrT57uhHnuLYFRoAgA42ZlPGnz7D
	 jqV1p+OZdX0nwjt0guwilO62HAZT4rFaTt0BuAJ/Kw8l52ZtzbY9EBYJRhU2XCsiUC
	 DmEHGQjTt0zNmNTyUavEpnlUVMi2lBcFP8rn92dZ84PZ/uddAsKNlOpGq7haL/2cCR
	 dB7sKOuvUzuZjJPwn0IVnROFBqsY9NqpbSKN+lVs9GCdPLJThj+FBaIf/dX4PdvmA5
	 fxHRDfD5QqXQA==
Date: Thu, 6 Mar 2025 17:46:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250306174619.2823b23a@kernel.org>
In-Reply-To: <20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Mar 2025 11:18:55 +0100 Kory Maincent wrote:
> +/**
> + * enum ethtool_pse_budget_eval_strategies - PSE budget evaluation strategies.
> + * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_DISABLED: Budget evaluation strategy disabled.
> + * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC: PSE static budget evaluation strategy.
> + *	Budget evaluation strategy based on the power requested during PD
> + *	classification. This strategy is managed by the PSE core.
> + * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC: PSE dynamic budget evaluation
> + *	strategy. Budget evaluation strategy based on the current consumption
> + *	per ports compared to the total	power budget. This mode is managed by
> + *	the PSE controller.
> + */
> +
> +enum ethtool_pse_budget_eval_strategies {
> +	ETHTOOL_PSE_BUDGET_EVAL_STRAT_DISABLED	= 1 << 0,
> +	ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC	= 1 << 1,
> +	ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC	= 1 << 2,
>  };

Leftover?
-- 
pw-bot: cr

