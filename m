Return-Path: <netdev+bounces-223733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC13B5A419
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923F5523E5E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD222DC783;
	Tue, 16 Sep 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiKilsRb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F12820B9;
	Tue, 16 Sep 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058920; cv=none; b=Rl1ayH5HnHZtwaMpTzQZdZQ+OMJIsHIczrumY3+bhFf3QZaYRsHea3fQw+B6eu97974Xi2bLdjSk1W25GhqAk++HmYu9ysE0Yy/m0hghn9NrpbOSU2VaUAJMATyrEXQmaB0tdMv+qGdx5LoPdsAWUCuJtVA88Mex6+qhbJLcu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058920; c=relaxed/simple;
	bh=tRIfdhsAJMME1a45JIICOi38lqR6oYNtURxnDEmjumg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZCxleXv/YpG6imYdnln+24v0YGazAw/fQuwmXZcgckAws3NHj8NAygd3f4S9LG6K++cF5bWZvfM1WG4NGq8gv7G3TEF8pMPnt0nr+ZQqr1iZC2WjW/QvnoIJYi2oT+1Qdu8dLeD/5la0DYp0yvki4N05P6mjVx5T1mCbThFJ240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiKilsRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60407C4CEEB;
	Tue, 16 Sep 2025 21:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758058920;
	bh=tRIfdhsAJMME1a45JIICOi38lqR6oYNtURxnDEmjumg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RiKilsRb4kpDl0//LUuc+uz2OTTgEllKymx7sarK7K5V2gLsr1ROtovFW0kOsUepf
	 CVUdEQwwFLuSUlqYhn6YaIEwVcdS85CEUrDgYJ/g/48X7rp29GP9CNn6aMIQ33PIx6
	 qMTtsWRCJkxlISgeK+B5r9gsmYQwYK6nqqaFNCyItywRMPpokt8mtHhDOYHRiXCGLD
	 KWtBypRC0GLgKb/k4OKDQX3TcZQszrX6kdAAB5qWE85+zq27Y2ISZzvlf2onQxOUXP
	 eVaTIJcnLNpTPwq+FD10s0x7LBVntsCuIxjWMtNZ14xDhjF+mKr+hGMh5HIGCYjgHd
	 JlE06EhPv51FA==
From: Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Jonas Rebmann <jre@pengutronix.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>, 
 David Jander <david@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>
In-Reply-To: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
Subject: Re: (subset) [PATCH 0/4] Mainline Protonic PRT8ML board
Message-Id: <175805891512.247117.14108545633571750279.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 22:41:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 10 Sep 2025 14:35:20 +0200, Jonas Rebmann wrote:
> This series adds the Protonic PRT8ML device tree as well as some minor
> corrections to the devicetree bindings used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/4] ASoC: dt-bindings: asahi-kasei,ak4458: Reference common DAI properties
      commit: 8d7de4a014f589c1776959f7fdadbf7b12045aac

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


