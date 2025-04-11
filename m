Return-Path: <netdev+bounces-181833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BAA868AB
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 00:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EDE19E7CF8
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE626658F;
	Fri, 11 Apr 2025 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gH746SF3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764E202C50
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409103; cv=none; b=LrXz+yeOGbQ9VJdI4bl2BBF1tX+6chEIBk109vIQlBP5UDlwL0zCaACve8jbTD1g4QODIQj+jeibm4hfao9AS1/roUzieKrt3yUkRny/mohOnoU3RFaiPX7lI9SYvP1B0VSQxB3hcxupWxKHDSNPrQzvmDY5RW68DaOcIQjuM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409103; c=relaxed/simple;
	bh=wbohtW8du9c++uelivNkziIgUjHOt9gQeKUzqx7GUd0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=QhyWuywEg7Rs5Ko4oSVuvEiuU24iz5S2E6W/GPZhZVNS6YZ91b9AYj2p5HU+lumObtp9OCI5iA19RMN0469eQH8Koob0BewnDiHp2CgwPn/0FNshrNH3BG7AVnNUufb6F5I/mjx9PCEVlo78au8iWnd98uxZyiuOUdCl3O8BJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gH746SF3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q0ExrBsO0KkkUKsR1ewzxEygaVvEzNnwruKwOYE6pls=; b=gH746SF3zmcUkfm9zD//Zy4d42
	E78AqmCGEWrTc2bAnyptLik5OPdiO1dE3dGuvhaiuNWJgCEWX2NoILk0e6dDdulomRYUS3a/NDJNv
	axASUaaDGWTDCU/XvZNhBjyfe4IzZLoF8oU4yeDs9Nml+o+3oH6crTPtlIk6tIRaAJqXfBJUUyms7
	QdlDI/xOapLz7tKuqyYD2oOb40biL6QhgVmzI/ABxsfLJMLgfg3SFpX7U15xMJ6UFWRBj8ruTWcJ9
	5Dz7KMRZqt//Faz8FIavAr3dod60ta/qkZr9RkaryyFo0ruqeVjcRRoaxgpiaPvTrczg47OK3QpaX
	pKBbrX/g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60848 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3MUa-0003uU-2F;
	Fri, 11 Apr 2025 23:04:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3MTz-000Crx-IW; Fri, 11 Apr 2025 23:04:19 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] net: ethtool: fix get_ts_stats() documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3MTz-000Crx-IW@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 11 Apr 2025 23:04:19 +0100

Commit 0e9c127729be ("ethtool: add interface to read Tx hardware
timestamping statistics") added documentation for timestamping
statistics, but added the detailed explanation for this method to
the get_ts_info() rather than get_ts_stats(). Move it to the correct
entry.

Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Is it worth adding a fixes tag for this and sending it for the net
tree...

 include/linux/ethtool.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 8210ece94fa6..013d25858642 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -926,10 +926,11 @@ struct kernel_ethtool_ts_info {
  * @get_ts_info: Get the time stamping and PTP hardware clock capabilities.
  *	It may be called with RCU, or rtnl or reference on the device.
  *	Drivers supporting transmit time stamps in software should set this to
- *	ethtool_op_get_ts_info(). Drivers must not zero statistics which they
- *	don't report. The stats	structure is initialized to ETHTOOL_STAT_NOT_SET
- *	indicating driver does not report statistics.
- * @get_ts_stats: Query the device hardware timestamping statistics.
+ *	ethtool_op_get_ts_info().
+ * @get_ts_stats: Query the device hardware timestamping statistics. Drivers
+ *	must not zero statistics which they don't report. The stats structure
+ *	is initialized to ETHTOOL_STAT_NOT_SET indicating driver does not
+ *	report statistics.
  * @get_module_info: Get the size and type of the eeprom contained within
  *	a plug-in module.
  * @get_module_eeprom: Get the eeprom information from the plug-in module
-- 
2.30.2


