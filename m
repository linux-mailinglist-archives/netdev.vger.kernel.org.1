Return-Path: <netdev+bounces-167637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D135A3B2B3
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E530174549
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6891C4609;
	Wed, 19 Feb 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acIw1C0C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA91C3C00;
	Wed, 19 Feb 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950877; cv=none; b=FFukJDdExU2KSlIfjIisJNbf9PdN16uWYFk1GzBz37m0ZQyRRtRVj2Vi8opVqGou/PdiaHBaBw37la3YcvSe14Zuo4aUc/qA2rruedXmo5wDopw5KGHhV5BLTHvIbdtjJqOJf4nh1kwLCVv+w+4/YcQkFzNsGhADhTX9jVDq734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950877; c=relaxed/simple;
	bh=QHxIJH5epUxZjVu5h2cfuDcM2p1sRKJAbrzZJcGNvMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJnwJSYKR3aFyWjNSS9DEw/iIvnKtevh9jk5XJW1ExLM39rCb+EPHYkF9L9YpGVEsIraOaTK2DBTtbdVjruAtZFhM5u8qF+fZli9Ddrj7BHl8TBAnV6jnnfWeuGlCwwpUBHZlrEc3ckDoHqvrMeBSuGjYnWYH8zFzq1y+q+ffAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acIw1C0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ACAC4CED1;
	Wed, 19 Feb 2025 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739950877;
	bh=QHxIJH5epUxZjVu5h2cfuDcM2p1sRKJAbrzZJcGNvMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acIw1C0CjsMJZs0NxvaNXZEOwph9coDZ00MyuVN+p4ffygEocuFmym4KFUBjB2lUH
	 6t3btTiLolR9mDjRtbEphLvcoMOXP2Mx+wxKQ9eBC7DyLAuRRgXO2Au1KWAOupAGYE
	 s03oiYSBHdSnA7j/zANmahH4ncsFs9y8yFhGxhbVVv8vYO+hsmn+3jOydAqZN80AEP
	 SAg71euKcsel5m+86EEOWXtfawEtEhEGausZHuBKUnwOA1YjLfmYnzCCyrTnO1VHij
	 R5RnvKhyqnyJsLnInjbxqPVKY8Enww1EyyOJV8y0Q/E3YI0wR5K4CHPwyre44xa5qw
	 9sKKD7/cWtqhA==
Date: Wed, 19 Feb 2025 08:41:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
	Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 10/12] dt-bindings: net: pse-pd:
 microchip,pd692x0: Add manager regulator supply
Message-ID: <20250219-wild-denim-dodo-fbfc7d@krzk-bin>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
 <20250218-feature_poe_port_prio-v5-10-3da486e5fd64@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218-feature_poe_port_prio-v5-10-3da486e5fd64@bootlin.com>

On Tue, Feb 18, 2025 at 05:19:14PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch adds the regulator supply parameter of the managers.

In the future:
Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> It updates also the example as the regulator supply of the PSE PIs
> should be the managers itself and not an external regulator.
> 
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


