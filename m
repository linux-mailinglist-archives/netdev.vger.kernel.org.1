Return-Path: <netdev+bounces-197825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332AAD9F7C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 21:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E1516A121
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB22E3389;
	Sat, 14 Jun 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmH7zghy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859C18CC15;
	Sat, 14 Jun 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749929593; cv=none; b=oq9XgiG0NCCuqOXjJX0RVOC60qe7MtZlHmyAEaySPx/VVmpJpXR5Rd2WDxwhMMnQ33vWq4mpWhI5II5zyzKGxfg6qs0fmMERjrwPSnC3n2i1pwd8IwThyA4YUCU/2Q3rhcABnNaA8523+FxBKZEn0/veUZYrTPtI9DuCeQf3Uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749929593; c=relaxed/simple;
	bh=lRBwJOZdbkaly461dzvAns5fuWNebULyT/8QZagD5aM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P68jjX66ioBd2QobYRkS1W6bRJ/xfe76gNg+CZHoTQ+O224yificGxu9VzVG/Rf5RznutAEINW+Hp99s0EwrUA2yJT6+tb0OnSPVEl1rAAvdD7tNmdHlnXrdtaQVdUGKaPuucWiUpq5rENHwHUMsfbI4/7vZLbE3qc/EYG+oyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmH7zghy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D9FC4CEEB;
	Sat, 14 Jun 2025 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749929593;
	bh=lRBwJOZdbkaly461dzvAns5fuWNebULyT/8QZagD5aM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DmH7zghy4eHRoyEIPttgt0JR8O8cWbC+kAarABX9ChVNWxiUXQZjWd3F80dIaSVzl
	 8JfDdMzKUGemygnuZAug9aRcymrnCTSXCZT+qm0yxMvKJ08Lob3kiPA5WqcDQk/jKV
	 ZCQrsSn4FrQZLiGsFeLgWCodGG2sJIwPVbeQnNrV4CoIPyb4bEOdj6qW4/tY77WlsD
	 biDbYxn78PF1fGWH7yPkdaiTq8wvNrzAveaqUpbaPyX+fH6gMlkWZKsq3jCCgc5yUa
	 tPYZTL78A7JS8QAJRmn3in9X84YQwojBys9dHoOUXXtYJ/jzno2G7/prv36EwyIbhw
	 d4xnmEWx8/Z6w==
Date: Sat, 14 Jun 2025 12:33:11 -0700
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
Subject: Re: [PATCH net-next v13 07/13] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250614123311.49c6bcbf@kernel.org>
In-Reply-To: <20250610-feature_poe_port_prio-v13-7-c5edc16b9ee2@bootlin.com>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-7-c5edc16b9ee2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 10:11:41 +0200 Kory Maincent wrote:
> +static bool
> +pse_pi_is_admin_enable_not_applied(struct pse_controller_dev *pcdev,
> +				   int id)

the only caller of this function seems to negate the return value:

drivers/net/pse-pd/pse_core.c:369:              if (!pse_pi_is_admin_enable_not_applied(pcdev, i))

let's avoid the double negation ?

> +{
> +	int ret;
> +
> +	/* PI not enabled or nothing is plugged */
> +	if (!pcdev->pi[id].admin_state_enabled ||
> +	    !pcdev->pi[id].isr_pd_detected)
> +		return false;
> +
> +	ret = pse_pi_is_hw_enabled(pcdev, id);
> +	/* PSE PI is already enabled at hardware level */
> +	if (ret == 1)
> +		return false;
> +
> +	return true;
> +}

> +static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
> +{
> +	unsigned long notifs = ETHTOOL_PSE_EVENT_OVER_BUDGET;
> +	struct pse_ntf ntf = {};
> +	int ret;
> +
> +	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
> +
> +	NL_SET_ERR_MSG_FMT(&ntf.extack,
> +			   "Disabling PI %d to free power budget", id);

You so dutifully fill in this extack but it doesn't go anywhere.
Extacks can only be attached to NLMSG_ERROR and NLMSG_DONE
control messages. You can use the extack infra for the formatting,
but you need to add a string attribute to the notification message
to actually expose it to the user.

