Return-Path: <netdev+bounces-122145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD0960116
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE84A1C22404
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7055F54656;
	Tue, 27 Aug 2024 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AQyk4QSw"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2D8289C;
	Tue, 27 Aug 2024 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736848; cv=none; b=KhpdgUR7IheLuIL42XSr7QrdKwk8Z6UjpmaUmiDOm3X5/BQ9u+ef6Donw2j4IIgCeQ7yAsidFlivuRW/sDOUwHXvXfDJ0XFtWWKqxIKkJ4F/jKenAkaPwEMdqi6J9FilOXcspHsMaITzjsL3208Muz9dAy4qn7+VzxUegFb1iKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736848; c=relaxed/simple;
	bh=/PDv7nmU69Adt/Bfez+pXxVY7UGKVtLBkyuR5p/i0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XM9nZpc1Gr2jskl5swEajfUF9Sa0bkM/JumCcjn0o4LEXaRNI9Ue71GKqo4IERbtvGWveEAICAIxeY0BI4EKEtKPTvmzMa1nNon6ZbWsKkGjtaQXddLnJA1A3HdPd7vX3PAGokjiduECS1W36BkQ8mfNz/ViawvalWMabs9OeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AQyk4QSw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7B3E40005;
	Tue, 27 Aug 2024 05:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724736843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ6dpe98L/8TCUESLaKBikF1ntMfY9wxYyoOQRmWTKw=;
	b=AQyk4QSwtJmE+tQ8ViV6yL1K/oPH4PeoVk0ttW73t8ZO+k7ISm+r/kaR+R3G6PoS1RK6co
	yr+kbxZ0Kn3AhsfO5PxQv6BbtzSmfPihcUMXtMnz2fuKOw51r1lALNwPuew0pTcDc14kV/
	Z9E9sldqZpsi7josy5zz2wBJF1hkSR7QxjSDhw4VUke1koZkA5cRq+SBHRvhB9cz5XIEjl
	wbIkGTnt6w4hHecMVlun/6anNauYV+4c9k4Xx0DJHXyOE1eT13Xlr4s4GGApOuoUExocYg
	Qq/TsgI1tmnLnpdnocSqk4+aohPidA+BS662mM+sbOC/3IcPS1hIsLeDmi2GZg==
Date: Tue, 27 Aug 2024 07:33:59 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 <mwojtas@chromium.org>, Nathan Chancellor <nathan@kernel.org>, Antoine
 Tenart <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <20240827073359.5d47c077@fedora-3.home>
In-Reply-To: <Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
	<20240709063039.2909536-12-maxime.chevallier@bootlin.com>
	<Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Tue, 27 Aug 2024 13:25:52 +0800
Pengfei Xu <pengfei.xu@intel.com> wrote:

> Hi Maxime Chevallier,
> 
> I used syzkaller and found that: there was general protection fault in
> phy_start_cable_test_tdr in Linux next:next-20240826.
> 
> Bisected and found first bad commit:
> "
> 3688ff3077d3 net: ethtool: cable-test: Target the command to the requested PHY
> "
> After reverted below commit on top of next-20240826, this issue was gone.
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240826_202302_phy_start_cable_test_tdr
> Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.c
> Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.prog
> Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.report
> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/bisect_info.log
> bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240826_202302_phy_start_cable_test_tdr/bzImage_1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8.tar.gz
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8_dmesg.log

Thanks for the report !

This issue has indeed been detected, and is being addressed, see :

https://lore.kernel.org/netdev/20240826134656.94892-1-djahchankoike@gmail.com/

Thanks,

Maxime

