Return-Path: <netdev+bounces-128563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2511897A5AB
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFD4B24C30
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4A8155A3C;
	Mon, 16 Sep 2024 16:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C796157472;
	Mon, 16 Sep 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502700; cv=none; b=of5bfX9IKfueMzIOTg3qiM0KTGCpK18063tQVbDCH2GWStD72XiDtpoYCNGX7ry/jws9wgs8DgthfgRejVgqNRD4KTxi84b8vxZ7umGigEcTPGBdXjqeak6Y40Wo0QAFjFseLmTSIgH89nSDpae+CMPpdt8+U5LQlp2cNS9Krvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502700; c=relaxed/simple;
	bh=C2HMx6GYdzwY259ykoR2BfXds/Dm1pRMuSSpPnZ9Awo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DS/LS7dgOfslmOBQ6GYEbXQAXtsXn0tgVhbsePGfWBMbDogBxau1cEiny1+Am3rjGfNDmM1/GBSXj57aduNuwRH6SHBu7Jr2ZLGu8R9woIFHfbWoYK7xhS58A6nV5s20ZspTmmZO1B7z4KQNG3TdNXEikv22hWEMChVgexqVgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sqDma-000000006ml-0EUv;
	Mon, 16 Sep 2024 15:36:56 +0000
Date: Mon, 16 Sep 2024 16:36:47 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: John Crispin <john@phrozen.org>
Subject: ethtool settings and SFP modules with PHYs
Message-ID: <ZuhQjx2137ZC_DCz@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm wondering how (or rahter: when?) one is supposed to apply ethtool
settings, such as modifying advertisement of speed, duplex, ..., with
SFP modules containing a PHY.

My first approach was to try catching the event of the PHY being
attached and then re-applying ethtool settings[1]. As there isn't a
dedicated event for that, I found that IFF_UP && !IFF_LOWER_UP is as
close as it gets.

However, that doesn't go well with some PHY drivers and the result seems
to depend on a race condition.

Simply ignoring the supported link modes and assuming the kernel would
filter them also doesn't work as also the advertised modes get reset
every time the SFP module is removed or inserted.

Do you think it would make sense to keep the user selection of
advertised modes for each networking device accross removal or insertion
of an SFP module?

The user selection would by default select all known link modes, using
ethtool (ioctl or nl) would modify it, while the actually advertised
modes would always be the intersection of user-selected modes and
supported modes.

Alternatively we could of course also introduce a dedicated NETLINK_ROUTE
event which fires exactly one time once a new is PHY attached.

If there is any way to automically apply user-configured ethtool
settings without any of the above, please be so kind and let me know how
that would work also for PHYs on SFP modules.

Thank you!

With Best Regards

Daniel

[1]: https://git.openwrt.org/?p=project/netifd.git;a=commitdiff;h=68c8a4f94cd3cfd654a52cbc8b57c5c9d99640dd

