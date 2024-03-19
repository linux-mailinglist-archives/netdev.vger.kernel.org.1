Return-Path: <netdev+bounces-80578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23DA87FDCE
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80079B22C13
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD36F3BBC1;
	Tue, 19 Mar 2024 12:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A603CF5E
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852617; cv=none; b=NHCVrB2ZUJL4YhRqKn6qyrRM5hfYYlqdED90XaBu+fMG9a8kfsQLus9yps9O1vyqwc7Ivbok4gk7Gd/yknBpOCxuk/pBeWgftQASCP4ZpSSdie7L5AEElV224UTPbfGH2PubMM5gfd3Cg78iXK0Vg9QWvQIx2TLMD//9guYrSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852617; c=relaxed/simple;
	bh=gYDrkvK3DAgGY8Y5tTKj3kUwRxwnGyuteKZd7IZfdYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ksFJYxckBbUKwLQKmxeLiatwUusb8Gmh+wgVa8FRFZUXQptebT6cCqMAZE48j//yuRbnygfLDu4Y12h6A96sitRtIwVPE4RnhYAxrcrFUlN45hdOQJ/MqR7bUK4mfdle9VoDcJEoDw5d4+RVT1ZcSaG6+NF6Cb2jQxcBSE+AHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rmYun-0001oK-Os; Tue, 19 Mar 2024 13:50:01 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rmYum-007HHn-Nh; Tue, 19 Mar 2024 13:50:00 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rmYum-0072VC-25;
	Tue, 19 Mar 2024 13:50:00 +0100
Date: Tue, 19 Mar 2024 13:50:00 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Subject: DSCP support for KSZ switches
Message-ID: <ZfmJ-O8XMT8oO-TS@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello all,

I'm currently working on implementing DSCP support for the KSZ switch series.
My efforts have led to the successful implementation of several callbacks,
including:

port_get_default_prio()
port_set_default_prio()
port_get_dscp_prio()

However, I am facing challenges with port_add_dscp_prio() and
port_del_dscp_prio() due to the KSZ switches' limitations on per-port DSCP
configuration. Specifically, the KSZ hardware allows only enabling or disabling
DSCP as the source of internal priority on a per-port basis. Additionally, it
supports either global DSCP remapping or using a default mapping, where the
internal priority is derived from bits 5:3 of the DSCP field.

Given these constraints, my question revolves around the appropriate tools or
interfaces for managing DSCP settings on these devices. Should the
enabling/disabling of DSCP per port be managed through dcb or ethtool?
Furthermore, concerning the global DSCP mapping, would devlink be the suitable
choice for this task?

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

