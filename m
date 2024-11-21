Return-Path: <netdev+bounces-146693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866B9D50A0
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 17:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C820282B53
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FDE176AC7;
	Thu, 21 Nov 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dovdj2c+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFB15887C;
	Thu, 21 Nov 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206134; cv=none; b=IS04P0wLYmkvKGizjI4mxYmGIkcJLTxIY3MN6TJEb4Hg8gOVI/0ve8NBXCSUdll0PvCQoZ8ZVSxqlwcoOsqDnaaqX0XRtDv/0l3B4yP1CzvjLVO4tMkAKsbEGE5OH0chUrxVyp8kTUS+7ZcOWI2ndXxFycrfbnnbQaqqDQsqQcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206134; c=relaxed/simple;
	bh=H1+/v69Y29iO+iPKmKvlxQEFmdjRRhh/mQ5uCJ4AIvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NpLmJIM6V+OkLDaUvMnnEZ6LEADFSffeYKP0hFvy0H4emSMvM+VjdlOZJJW1Mxhai2cPIElu/pxhct1PKeyB3IcUj+FpCfxe+SKaEe3RKO1RrkazoMiv65tx8rsHdltJY1+tpj3/Ns+7irN4iKBMHpFe4nGqaQby40mOMQNJJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dovdj2c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93057C4CECC;
	Thu, 21 Nov 2024 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732206134;
	bh=H1+/v69Y29iO+iPKmKvlxQEFmdjRRhh/mQ5uCJ4AIvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dovdj2c+5J7fqEEeeUylh2nLnUWY/2lgquAe+dbqIDcuOjqJ6z9RecrjchClgRKa+
	 DuR/czvObjWEAEteCwc97FSRMSTUqAuXQNiAT7TVa30BZDW234O/XNpIV3O13N/xAb
	 gAoKJ71wMA1XJ8SV9SpTRweMtp57Oij2C5RfShOSWLfmnIgMUbOXQM8ate+jqh2fDn
	 iB9rlx43bYWgh4CJKUqulRMRw0+NI338tGsmY+myaFs9q8vctuHCmc/jDg/veQIks3
	 hiolOMnombWLBnAc6mNwB98MmGNiw+U74basdO4CvxfkpYzEvo8MTKZL/ueJQhX+Ij
	 4TAKk6+uKBSfw==
From: Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
Subject: Re: (subset) [PATCH RFC net-next v3 00/27] Add support for PSE
 port priority
Message-Id: <173220612933.70192.11350146406993913453.b4-ty@kernel.org>
Date: Thu, 21 Nov 2024 16:22:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 21 Nov 2024 15:42:26 +0100, Kory Maincent wrote:
> This series brings support for port priority in the PSE subsystem.
> PSE controllers can set priorities to decide which ports should be
> turned off in case of special events like over-current.
> 
> I have added regulator maintainers to have their opinion on adding power
> budget regulator constraint see patches 16 and 17.
> There are also a few core regulator change along the way, patch 3 and 15.
> Not sure if they have to be sent with the Fixes tag.
> Also, I suppose I will need to merge them through the regulator tree.
> Will it be possible to create an immutable tag to have this PSE series
> based on them?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[02/27] regulator: core: Ignore unset max_uA constraints in current limit check
        commit: 351f2bfe6362c663f45f5c6111f14365cfd094ab

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


