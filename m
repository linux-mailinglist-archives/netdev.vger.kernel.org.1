Return-Path: <netdev+bounces-156852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D533A08025
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0CB167D17
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896919995B;
	Thu,  9 Jan 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+vSYcKD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00ABBA2D;
	Thu,  9 Jan 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448607; cv=none; b=NViD5PYej83SW66Xy37fj1fXRjojHnSA8CLIHDQ7JKbXiLtbdhmvHx5Jv+4RPae3rs9JuOeLeSMhXFqDCPOCKoeglrgQhXZNv+fv2oV3Lhk06mG2KwPCRLRrJzqByyOppBiKMUgS26ZHGAn6+Rm/0NHFUAi9SlaQL0/P04zxeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448607; c=relaxed/simple;
	bh=UClqNLtusno9FK1RIdTxIMZbW6/20UwXTM8vbXW2VvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MsMz8KLZRWD73QyghQyfLY250+0A/Ik01GdNOOpyQM9GuKkqb+IqYRrwC9yCQ4mLQMmbeSWjhHNQ4v3xzduGHg3/K7qKekN7JSijIPk7IY3/L4xkgLyoDr1YFL4LdHVjrWdfV0a+Iq6+NBPusOy4vHcCHXcCjQUvWRE5ALxLL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+vSYcKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A92C4CED2;
	Thu,  9 Jan 2025 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736448606;
	bh=UClqNLtusno9FK1RIdTxIMZbW6/20UwXTM8vbXW2VvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e+vSYcKDhm2wendrwZ3MiSWH/16MBFCsT4eNrH67kEGxIfDQS1oRxf/2XlzhZsYKO
	 lJNSUYJYmcGVOPZqPv5CLAML5lwXBtMJ0Y8iYTUSlGJCJDhR8LR7PrRdxLc+uW0Hpf
	 00gW5Yj2smQkiRzlMrRB1fXKOp2G4LAQ6T59AFy51rE0qXvT7Lp2B67X1NY+t58jvM
	 gl16hTvqoXB8j4FgegJfpFhp+nen0nIlhrS/w/ys4TL142B2PZcPtjXFhOlJ4/HKlu
	 Lkq+jEiLsD6UQk2OJr0ZMRYiVyPbhwYMdtyQaGstp6+ziQeeHi2ArVBqMYObNVdQx7
	 k1QFpI+aiwQ6Q==
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
Subject: Re: (subset) [PATCH net-next v2 00/15] Arrange PSE core and update
 TPS23881 driver
Message-Id: <173644860244.654853.1911781164332852260.b4-ty@kernel.org>
Date: Thu, 09 Jan 2025 18:50:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 09 Jan 2025 11:17:54 +0100, Kory Maincent wrote:
> This patch includes several improvements to the PSE core for better
> implementation and maintainability:
> 
> - Move the conversion between current limit and power limit from the driver
>   to the PSE core.
> - Update power and current limit checks.
> - Split the ethtool_get_status callback into multiple callbacks.
> - Add support for PSE device index.
> - Fix PSE PI of_node detection.
> - Clean ethtool header of PSE structures.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[13/15] regulator: core: Resolve supply using of_node from regulator_config
        commit: c3ad22ad34f81a8906dba02ea8cc9756d2ce7b50

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


