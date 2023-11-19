Return-Path: <netdev+bounces-49020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F087F06BC
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 15:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972CB1C2033F
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F690101FC;
	Sun, 19 Nov 2023 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQtkokfB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8211199
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 14:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D134C433C8;
	Sun, 19 Nov 2023 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700402982;
	bh=7N8+AO5RbylkHQ8VIxChK+V+uCnDFu5m8DO1LQeIS6Y=;
	h=Date:From:To:Cc:Subject:From;
	b=VQtkokfBqNQZFdmySJ7BmdDEbihdLD6pV5tBipZsroId7SLe7iqiZhWghV0s4HGpk
	 EBlpU3NZfeRIl1opIDNDZO09G/ZOJ/mERyyoZ4UShU16EOkTB0JMLPSiVtvElD2H+b
	 gEwoHUYoqmmq4f72d95ca+fdJMo+OqPdVsRXvgwN3pWOLLlQ3lK/mJETiG7dx3kUnx
	 sas2WoZjIUnlXU75PYB5nVFhkEtQ/5Pf5fEXadl/OAm2h3Xs1LgWZ/63DiD/iY4SBn
	 2FZEm9UzVh9QgyboN3+hY8mqjY/eecySD1gJWtb2IMvug7MN4gwANk8eaW9wKkg0ot
	 /TCiPLpN53OUQ==
Date: Sun, 19 Nov 2023 21:57:17 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, HeinerKallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S.Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC] support built-in ethernet phy which needs some mmio accesses
Message-ID: <ZVoUPW8pJmv5AT10@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I want to upstream milkv duo (powered by cv1800b) ethernet support. The SoC
contains a built-in eth phy which also needs some initialization via.
mmio access during init. So, I need to do something like this(sol A):

in dtsi:

ephy@abcd {
	compatbile = "sophgo,cv1800b-ephy";
	...
};

in ephy driver:

static struct phy_driver ephy_driver {
	various implementaion via standard phy_read/phy_write;
};

int ephy_probe(platform_device *pdev)
{
	init via. readl() and writel();
	phy_drivers_register(&ephy_driver);
}

int ephy_remove()
{
	phy_drivers_unregister();
}
I'm not sure whether this kind of driver modeling can be accepted or
not. The advantage of this solution is there's no hardcoding at all, the
big problem is the ephy is initialized during probe() rather than
config_init().

The vendor kernel src supports the ephy in the following way(will be
called as sol B):
in phy driver's .config_init() maps the ephy reg via. ioremap()
then init via. readl/writel on the mapped space. Obviously, this
isn't acceptable due to the hardcoding of ephy reg base and size.
But the advantage is it delay the ephy init until config_init() is
called.

could you please give some advice?

Thanks in advance

