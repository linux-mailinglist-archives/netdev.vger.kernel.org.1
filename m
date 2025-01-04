Return-Path: <netdev+bounces-155144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D10A013B8
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C237188484C
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB8175562;
	Sat,  4 Jan 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rirzpp8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26228FD;
	Sat,  4 Jan 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735983810; cv=none; b=bHW2FLdRGqPVTlX3oDsZ5q7Ugds8pJVKshWkwENL7HhPeLkIE/jISgAQt46l7PJcxrbG8a1jaWZuvrvJvVYuuD0+F7b7F3M+CNo2eMFSQi8YU8mmNmtZC6VUpYvt5E9yHM0RWdwssAQ3nszVwO1k30fwuZLghxJI6Vn2Fg1/Dr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735983810; c=relaxed/simple;
	bh=7o1KDL0/Pp1k1rsgqECxFs7t0+g4muSAFRzNddK8Ge4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx5jcs87G7VKnX0IQwBN2PhZu0jcaiCS7Wn61irHVnhdAJR9yubb6jlqmOiB7HlAucsF0H5ltYYN7scRK1MHvey76r+sgg7Yl56bR+TM3m9unODnp4Ox7hDF4QnWNUXXzde9FD0BxAMgDGA13VVvCRVimEt5VXCOla832YY/vK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rirzpp8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663ECC4CED1;
	Sat,  4 Jan 2025 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735983809;
	bh=7o1KDL0/Pp1k1rsgqECxFs7t0+g4muSAFRzNddK8Ge4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rirzpp8U9tQZh+kVM9NxzBonD26P+qfT2XrPtOUJ1vYgXDv32G9LZh0kl5hevTr1s
	 BiJDQU7BNtuGuzvANoUQK0MOZBifvO2nJQjDJ0ppeZIbIQH6KJ1p4W8XkSz6cpmXrU
	 8mynR2b2KWPEoS+AFhWAxS/f4SEph795FoL2EnED4LmYj9obmlmWV3bN3qXirTQjTa
	 5qF1SIlgA1/DlWBbfgivP1Mu/BJMLa5Xc7DxEpjMJOZG1pOSCAU9nvwCYJCMAvfM8V
	 n3tLwzNFJLk0I+T/yntB9XPuYlER0mEk6tpkK1XMIPo1oRroqVD4vtYuH5TKaZi+RI
	 ucmTV5T/bxl5A==
Date: Sat, 4 Jan 2025 10:43:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	Kyle Swenson <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>, 
	kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 18/27] regulator: dt-bindings: Add
 regulator-power-budget property
Message-ID: <sxan73paedcp3jm2y3uchnl7c5qgbasgjt4tjv5pobamzxgqf6@ldx3hor6wrzx>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
 <20250103-feature_poe_port_prio-v4-18-dc91a3c0c187@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-feature_poe_port_prio-v4-18-dc91a3c0c187@bootlin.com>

On Fri, Jan 03, 2025 at 10:13:07PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Introduce a new property to describe the power budget of the regulator.
> This property will allow power management support for regulator consumers
> like PSE controllers, enabling them to make decisions based on the
> available power capacity.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Please use same SoB as From. You might need to configure your Git
correctly, first of all.

Best regards,
Krzysztof


