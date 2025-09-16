Return-Path: <netdev+bounces-223427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0BB591D4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D1A322CC4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A57299937;
	Tue, 16 Sep 2025 09:12:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB99274FDE
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013935; cv=none; b=SGbAwQCMQ2Z05uEC94vrRMUfKIzbWbwn0VFFzy8LoV7vssyvV3QmP7jXSAngSPGAT+0To3nEAX4vDRdfuR/GTYhv0H/wLZqrSNw8BwaaKWf4fZJJrcxjj/lDi1uR1l0LLyW78X54Iv8SYdOIJpZM1odoSRbXdBchj1evnBIxzpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013935; c=relaxed/simple;
	bh=GHuK+PLJQJr02xZ81YhwlytM9kKnQHjixQj34PgCAYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qxwr7nV7dOIcd5l7bLrZ0kQ4TQhdY0c9V9c4pzCdn6G30PQmx6m9qtyhse+fmSz80tNLEAgyTfN1Yu1VHRN3IgAz2fcxxsw+FrevPsZRG400NnhdbBbGufgydiJDn9XEuL0AzqglbDGsDfLS9JDYwfU2aotaKHx3ZQpKVVdYZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyRjI-0002aw-A8; Tue, 16 Sep 2025 11:12:04 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyRjH-001Z3b-0E;
	Tue, 16 Sep 2025 11:12:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyRjG-00BVwu-30;
	Tue, 16 Sep 2025 11:12:02 +0200
Date: Tue, 16 Sep 2025 11:12:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC] net: selftests: Adding TX checksum offload validation
Message-ID: <aMkp4vGilSPbAyun@pengutronix.de>
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

Hello everyone,

While working with the smsc95xx driver, I identified a need for better
validation of the driver and hardware TX checksum offloading capabilities. I
believe a generic test suite for this would benefit other drivers as well.

The generic selftest framework in net/core/selftests.c seems like the ideal
location. It already contains a test for the RX checksum path, so adding
validation for the TX path feels like a natural extension.

Here is the list of test cases I propose to add:
- TX csum offload, IPv4, TCP, Standard MTU Packet
- TX csum offload, IPv4, UDP, Standard MTU Packet
- TX csum offload, IPv4, ICMP, Standard Payload
- TX csum offload, IPv4, TCP, Minimal Size Packet (1-byte payload)
- TX csum offload, IPv4, UDP, Minimal Size Packet (1-byte payload)
- TX csum offload, IPv4, UDP, Zero-Checksum Payload (Verify checksum becomes
                              0xFFFF)
- TX csum offload, IPv4, TCP, With Single VLAN Tag
- TX csum offload, IPv4, TCP, With Double VLAN Tag (Q-in-Q)
- TX csum offload, IPv6, TCP, Standard MTU Packet
- TX csum offload, IPv6, UDP, Standard MTU Packet

The implementation for these tests would involve preparing an skb with the
corresponding L3/L4 headers, flagging it with CHECKSUM_PARTIAL, and sending it
through the PHY loopback. The test would pass if the received frame has a
valid checksum.

As a related question on driver implementation:
The documentation suggests that the older flags NETIF_F_IP_CSUM and
NETIF_F_IPV6_CSUM are being superseded by the more generic NETIF_F_HW_CSUM.
When the network stack sends a packet with skb->ip_summed = CHECKSUM_PARTIAL,
the driver is responsible for ensuring the final checksum is correct, either by
offloading the calculation to the device or by falling back to a software
function like skb_checksum_help().

Is this understanding correct, and is relying on CHECKSUM_PARTIAL as the
primary mechanism for requesting TX offload the recommended practice for modern
network drivers?

Thanks,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

