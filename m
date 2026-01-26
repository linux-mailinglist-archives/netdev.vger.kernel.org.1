Return-Path: <netdev+bounces-253365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOw4Htkld2kUcwEAu9opvQ
	(envelope-from <netdev+bounces-253365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12EC8573E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05AD2301FF83
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B825431329D;
	Mon, 26 Jan 2026 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uepyBXEr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394031282E;
	Mon, 26 Jan 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416067; cv=none; b=AAdKU9jW+mYEPhFuaJ8oizZIGJkNW9ogLYw7MKND+HkTPRfNT+c5T+q1vf66n2vomnIFZzD9k9E7dMgLbapw89aGuhQVXf9vvSLear2rzF9yo2Aq31s/UtPC60zljS2tHGxwJ+G5gSbE2OMHK5L36IJ+dcI9uVCsOvW3dPmauts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416067; c=relaxed/simple;
	bh=0NmEGGyH7g7H5B/eZVztpNdNx8l4A7JBT5m3MHC5pgE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qs6HtJHbYZAIEySukKksevgeyfkCERG9CrGXrDXachCWer6RQa+Smq6nY3aL6bzpQ+Upu1NLdquzE3dVZSdlR0+9lws/ZiZzUpVZLEo/Gd2VE4e1z2M7JclmThy6L5R2HJbNVcWv5fm5EKedfOs3/9RKeyqKPu9QQaD4nON3Ztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uepyBXEr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3ABE94E42295;
	Mon, 26 Jan 2026 08:27:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D65260717;
	Mon, 26 Jan 2026 08:27:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E332E119A80E2;
	Mon, 26 Jan 2026 09:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769416056; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qfSzuZ/oXqR/bU2qrtyPcgTd6j4GILTJZ/5fTdNadD4=;
	b=uepyBXEr5rS3MrYmP/47310GWkkiYafsrp+gy3uoVgY6HYLn4A7/QtqPlBkdGkvuj3j6gY
	rJ9RiJSkdEWY6AKJRHcMy42QAvVYtjxdED/MNOIhQJiS0oMq0fwV2vS5xdBXvXrxJs62Oz
	o8qi/y4D0K4ACOM62kf/pkbk9ZxYpo8+vqQTElkpB03Cmd/x3x1RUrqloCtOtphJ5mnsK0
	JwVN6NeX2PjPq6srvrKrG133wAMqkq3K2Zg9l0DogMFNsgblaYxqcDsVe18jQOeocCeGYz
	yiAYomIR6qx3eANXksZ8yBQA+I/LjBbQl+qsxo4cnWhxEQxKPH5qCk/hIelawA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v3 0/8] net: dsa: microchip: Add PTP support for
 the KSZ8463
Date: Mon, 26 Jan 2026 09:27:28 +0100
Message-Id: <20260126-ksz8463-ptp-v3-0-9f092aeb8492@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAld2kC/1WOy04EIRREf2XCWgyP5jGz8j+MC6DvdYgOtICd0
 Un/u8i4sJeVyjlVN1KhRKjkdLiRAmusMace5MOBhLNLr0Dj3DMRTGjG2ZG+1W87aUmXtlAfjJD
 BGXRhIp1YCmC8DtszSdBogmsjL/emwMdn17e/2rsKNOTLJbY+52ZEYTQYxZniYIyHaUY7iyM4z
 wMyqzR6HK5zrC2Xr3F55UN2f8fV7t3KKesXEYSVLKBiTz7n9h7TY58dplX8o4XY0+KX1tpKVAE
 U83t627YfJU5whDwBAAA=
X-Change-ID: 20260109-ksz8463-ptp-bc723ca7fac4
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253365-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D12EC8573E
X-Rspamd-Action: no action

Hi all,

This series aims to add two-step PTP support for the KSZ8463 driver. It
depends on a previous series that was recently applied to net-next:
https://lore.kernel.org/all/20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com/

I've encountered weird behavior with IPv4 and IPv6 layers -- maybe that's
related to the incompatibility with the Linux stack mentionned by commit
620e2392db235 ("net: dsa: microchip: Disable PTP function of KSZ8463") ? --
So the support is only added for the L2 layer.

Patches 1 to 4 add IRQ support for the KSZ8463
Patch 5 adds specific dsa_device_ops for the KSZ8463
Patches 6 to 8 add PTP support for the KSZ8463

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v3:
- PATCH 4: Fix the unitialized value reported by clang
- Link to v2: https://lore.kernel.org/r/20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com

Changes in v2:
- PATCH 8: Disable PTP by default.
- PATCH 5: TX path: remove timestamp handling
- PATCH 5: RX path: zero the PTP header's reserved area before
  forwarding packets to userspace
- Link to v1: https://lore.kernel.org/r/20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com

---
Bastien Curutchet (Schneider Electric) (8):
      net: dsa: microchip: Add support for KSZ8463 global irq
      net: dsa: microchip: Decorrelate IRQ domain from port
      net: dsa: microchip: Decorrelate msg_irq index from IRQ bit offset
      net: dsa: microchip: Add support for KSZ8463's PTP interrupts
      net: dsa: microchip: Add KSZ8463 tail tag handling
      net: dsa: microchip: Enable Ethernet PTP detection
      net: dsa: microchip: Adapt port offset for KSZ8463's PTP register
      net: dsa: microchip: Add two-step PTP support for KSZ8463

 drivers/net/dsa/microchip/ksz8.c        |  12 +--
 drivers/net/dsa/microchip/ksz8_reg.h    |   1 +
 drivers/net/dsa/microchip/ksz_common.c  |  95 ++++++++++++-----
 drivers/net/dsa/microchip/ksz_common.h  |   6 ++
 drivers/net/dsa/microchip/ksz_ptp.c     | 179 ++++++++++++++++++++++++++++----
 drivers/net/dsa/microchip/ksz_ptp.h     |   9 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  11 ++
 include/net/dsa.h                       |   2 +
 net/dsa/tag_ksz.c                       |  70 +++++++++++++
 9 files changed, 335 insertions(+), 50 deletions(-)
---
base-commit: 3adff276e751051e77be4df8d29eab1cf0856fbf
change-id: 20260109-ksz8463-ptp-bc723ca7fac4

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


