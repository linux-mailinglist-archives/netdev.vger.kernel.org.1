Return-Path: <netdev+bounces-223710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD3B5A34B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39EE4636DA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CDE2EAB68;
	Tue, 16 Sep 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D5T7mjOF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB331BC9F
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054879; cv=none; b=ZHUR8+QVTiD0d/ctjPTW+zVGHmC7/FxCmRSFhsDFLiDZT8XcONYZquiXLwgBaYbd1Vg2CcCW+7ZoddnLIoBYqahgx4+ir8eUTF/8z2nxWhzljgbKkMab6aYdL1bnh48GqCPi09liYEaTqj5SFchMEq0UniL/V3R/4ufQyQGsLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054879; c=relaxed/simple;
	bh=XxXMUa8org3YyhDQ8qXdbekLjzl+NDe07/zWqjJXfeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c/jUoTHupE+pyMtV5xw/4w+jUypjdwxuYHhD5D7kKs0lT/UXh69nB0m+EkbHyZX8un7/0fo6JpoUYDIXW8g5kc9ayWFmxm64h/vMKVnK4wlRH/WSwggaRXwzZegGwytMgBxiwZWPMn/NgXa7A9yWCWKhYAR8kzBSbGGmu4uR5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D5T7mjOF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hm2jdbcUQHsW8ufMe3DPbptkiSWzxcE1eWOftECWj+c=; b=D5T7mjOFcjLgDqKWcauEzHrVY5
	3KnESwXo4lGaRLAsYZm8D0WtRTqdyTi12lEvea3VJgrNfcANvr/y76qE6GDgAJhhbUWd53bdPE+7D
	1+PArtM6jfXsFDNVxq87ER715ry/0wYqP8nJZOl1xu8n/BtaVD7qlgUzDkP1qxbVzHWyxTmIBAlUs
	hYZD9YHdmLbdWJly0PUT2cxdcCTIuxemsigdq+tRDmJRrY6zz9PDP8mjvRt22GIycUBBebRgcza66
	GbRq5g8fSYYBVyrRhEYCqu9TJJizR8SyGxrxLLCO0JgSNHNWeJIqVAA2pHjLvaALxrfuCW8HjSJ+O
	AyEr7W5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36662)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uycNk-0000000067g-2yQc;
	Tue, 16 Sep 2025 21:34:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uycNi-000000007xK-2tFW;
	Tue, 16 Sep 2025 21:34:30 +0100
Date: Tue, 16 Sep 2025 21:34:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 0/5] net: dsa: mv88e6xxx: further PTP-related
 cleanups
Message-ID: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Further mv88e6xxx PTP-related cleanups, mostly centred around the
register definitions, but also moving one function prototype to a
more logical header.

These do not conflict with "net: dsa: mv88e6xxx: clean up PTP clock
during setup failure" sent earlier today.

---
v2:
- Add Vladimir's r-bs
- Remove unnecessary mv88e6xxx_hwtstamp_work() stub
- Better placement of "Offset 0x0A/0x0B: Event Time" comment and
  expanded it similar to Vladimier's suggestion.

 drivers/net/dsa/mv88e6xxx/hwtstamp.c |   2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |   1 +
 drivers/net/dsa/mv88e6xxx/ptp.c      |  24 +++----
 drivers/net/dsa/mv88e6xxx/ptp.h      | 130 +++++++----------------------------
 4 files changed, 39 insertions(+), 118 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

