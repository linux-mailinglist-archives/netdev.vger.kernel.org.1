Return-Path: <netdev+bounces-305954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gDawL5OZTmpKQQIAu9opvQ
	(envelope-from <netdev+bounces-305954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:40:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB117299AC
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:40:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=paNm7O8a;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=Rzj9YE42;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305954-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305954-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C429C303ADC1
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4014C9006;
	Wed,  8 Jul 2026 18:40:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858B4C77AD;
	Wed,  8 Jul 2026 18:40:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536008; cv=none; b=Ne7ABl7TD5YnUeFRpojVzW/QVXycD7+Bzfsvno0qsLSQc0jf1ooN0t1Zf+bb20EQN3C44DQ0Stmn51JpYnLobEnWlgxEZxdwrbzb4o1N8YR1mkYz+mShWBymyVevnW+vplpW29JACZAq+rarH24qCCDC7ff9t5pfPhvGHows22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536008; c=relaxed/simple;
	bh=lEqPa+K5sRA7grl68cay5/oe3+WcycKRkSmKFlfn2DE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e/KqdwhV3EHHs1hPYTX6l9O430H9h0R3fxMzwjynW0pO6qsqdIfx2L4mjIhwZ37bXE8rrb+SYgIbcVJIwf94vk3WOF5BsWmzy8qKiiOgHGsbX1IDYe6kuahJ9AsvuRUjo3uIBFxUH1uds0gJTFcnqsZmtoVj7WqjYFx58cmn+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=paNm7O8a; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Rzj9YE42; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536005;
	bh=lEqPa+K5sRA7grl68cay5/oe3+WcycKRkSmKFlfn2DE=;
	h=From:Subject:Date:To:Cc:From;
	b=paNm7O8auFsi6o17Pv99+4nPKlx3485Q7So3pNCSnkbJBQ5fHRFUqvIBpFQEzjA61
	 t18I0bIj8F0vQsOEXYZxClrP+voj7HmLUtawJ4MDSl4Id9vC/giL9oLDf83iTqA6Oq
	 KWLyDGA8oT5RaY7Qs4YlUUqwPxYZIqRh7TZHyJBuQ02k3NLskA2+I7rCbNoVUJMvRm
	 D9XbvTns0ey9SG3gUThqzadQ/KbONNdgwWj48vTyt5F78Niq8F700T6qZshtKLWxFH
	 6Enk0NEgP9qIJF0VJSnD/XLM9fR4MqSRCqWImUKNEbBmQPzsm1H0kw76muQSpb+Ryl
	 /sYCRSwXB9+tw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E859649441; Wed,  8 Jul 2026 18:40:05 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536004;
	bh=lEqPa+K5sRA7grl68cay5/oe3+WcycKRkSmKFlfn2DE=;
	h=From:Subject:Date:To:Cc:From;
	b=Rzj9YE42AlWCC5aZTMME4ZMPwVvNMvVjlFdQFxL+F+QxuxsroHMcbgaDTeNUDV9kc
	 t4xMWbbIY4RTvUCWca6y7WsquvcmVhE7iqdPDZ3mv6hp6HSkb6s5pbs3+sRf1Lb/Dk
	 5X/tUUnOua3y5HONqpYpsCUaLg5tXQ82EzC5SWPt5YLc6TTHTSRavbAnCjlMRGj6eL
	 V7SSmn74UE0E+vDfH4c4Trmqq/dBLdd69lOcushV1N/8wy64YJJgLBBPqMj9ABcLFx
	 G3qtJFTp3s76fj8dXAxa3BMmXF8aPtfmwMCNNJAgHJodSVfcsGwbkquyzO7AQQobdq
	 qGudvzW6adcyg==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 95C89493DD;
	Wed,  8 Jul 2026 18:40:04 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v2 00/12] ax88179_178a: Add support for
 AX88179A-based chips
Date: Wed, 08 Jul 2026 20:39:06 +0200
Message-Id: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqZTmoC/0WNQQ7CIBBFr9LMWgxDU0BX3sN0QWXaTjTUAGmqT
 e8uYePy5f28v0OiyJTg2uwQaeXESyigTg08ZhcmEuwLg5JKS91K4TZr0VyccOjtZSSFppVQ5u9
 II281dYdAWQTaMvTFzJzyEj/1Y8Xqa85I/OdWFFJgq23nR2067G4Dx4mieC7Di/P37An64zh+b
 D8n2LIAAAA=
X-Change-ID: 20260630-ax88179a-a1d89fe21730
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305954-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mail@birger-koblitz.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CB117299AC

This adds support for the current generation of ASIX network adapter chips,
which are based on the AX88179A. This includes the AX88179A/B (1GBit-PHY),
AX88772D/E (100MBit) and AX88279 (2.5GBit).

The AX179A-based chips all provide both a CDC-NCM compatible USB interface,
and a proprietary vendor interface with more features. By default, the
proprietary vendor interface is not active and Linux will load the CDC-NCM
driver to support the devices. If the ax88179_178a module is configured by
the OS to have precedence over CDC-NCM, then this driver will switch the
device to use the vendor interface, and the device will be controlled by
the ax88179_178a driver when the device is probed again after an automatic
reset of the device bringing up the vendor interface.

The following hardware was tested:
Delock 66046 2.5GBit adapter (AX88279, FW: 1.2.0.0)
TP-Link UE306 1GBit adapter (AX88179B, FW: 1.3.0.0)
Renkforce RF-4708614 1GBit adapter (AX88179A, FW: 1.0.4.0)
UGREEN CR110 100MBit adapter (AX88722E, FW: 1.3.0.0)

The driver supports the following features
- EEE
- TCP segmentation offload
- VLAN filtering/tagging offload 
  (NETIF_F_HW_VLAN_CTAG_FILTER, NETIF_F_HW_VLAN_CTAG_RX/TX)
- RX/TX checksum offload
- FC/Pause configuration
- EEPROM read access

The code is based on the ASIX 4.1.0 out-of-tree driver published under
the GPL,, the aqc111 driver which provides support for the AX88279A,
and some tracing of USB-transfers of the Windows-driver.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
Changes in v2:
- Correctly use net-next prefix
- Fix compilation issue in HW support patch
- Split MMD support patch into patches for EEE/new chip support
- Do not use ADVERTISE_RESV but private flag definition
- Fix pause configuration to keep track of settings when autoneg disabled
- Fix issue with unitialized variable reported by kernel test robot <lkp@intel.com>
- Avoid white-space changes

- Link to v1: https://lore.kernel.org/r/20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de

---
Birger Koblitz (12):
      ax88179_178a: Fix endianness of pause watermark register
      ax88179_178a: Add HW support for AX179A-based chips
      ax88179_178a: Add MMD accessor function for AX88179A
      ax88179_178a: Add EEE HW configuration support for AX88179A
      ax88179_178a: Add support for 2500 link speed of AX88279
      ax88179_178a: EEE setup for AX88179A-based chips
      ax88179_178a: Obtain speed and duplex from Interrupt URB
      ax88179_178a: Add support for ethtool pause parameter configuration
      ax88179_178a: Add VLAN offload support for AX88179A
      ax88179_178a: Add ethtool get_drvinfo
      ax88179_178a: Add support for AX88179A/772D/279 EEPROM access
      ax88179_178a: Add AX179A/AX279 multicast configuration

 drivers/net/usb/ax88179_178a.c | 1435 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 1298 insertions(+), 137 deletions(-)
---
base-commit: 1a9edf8be190decb17227e3cba540513d93ebb85
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


