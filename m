Return-Path: <netdev+bounces-252357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LRjGh48cmlMfAAAu9opvQ
	(envelope-from <netdev+bounces-252357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:02:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0C6846F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7C24708BE9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689EB30F53E;
	Thu, 22 Jan 2026 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aHoUH1u3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6F304BB8
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088466; cv=none; b=K15+xp2VGHikMkCoPgxe9aVYa1sWcW/LxwPTHpVtaP9lmcv1HT3+wIY+6b/IZv+jQLtLSJ0VHQ1iYajMc4hapS3+lhbwicqhEVyu1u8+8P3H233rxPf1uDgSD3Gjowi0lawFx7OJfjRbRdei/0qgc5mf0PbBVKUAOm0IAdhKvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088466; c=relaxed/simple;
	bh=o+0sYaDWbcxbL1IUCfUS3F9isBG7ly8v8XxfAaJNUYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tHIncbXj3vdP4WANFL53lU4HEJ77tqzPYSe59FBqzSuactM8cmerAO9JS381o6ypHEmQg+yHVcHF9ynrWznTYfhBkVqg1kLsRxuqoUz8wAMMx8fnJBM+PYCIm4tfYqi+64qNey7DLd2wzi7SxShenBgltC8uY+0gOcwfZWGrUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aHoUH1u3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 679401A2A73;
	Thu, 22 Jan 2026 13:27:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 34533606B6;
	Thu, 22 Jan 2026 13:27:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CF26119B8144;
	Thu, 22 Jan 2026 14:27:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769088461; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CA8OXyKadhTmmwjRU/BOu0rwuxEB8uj2vlrXZgfunFg=;
	b=aHoUH1u3tAIkWYtH+s6M+RhjgnNvXvb/G95QYxaNlkq0g5/lGj4jtwcbKqvMp9tzXAwLO0
	musQLvWYv+HLIbUebQeB4wjVdZfrhhZNsPmDd0rm7yk19WEIkMt/jbVH8os3KFngiL/97K
	cT3CIi7sObyb31MIcGkO26Xr2keQqRWqob80UUzTYFKG439FrK54L84/l2Roea/+IBJBvH
	9SDKFVC6biG6zDXZS1Dg1knabjUQRjB8VjGFTAMAjnIXV+ySpjD04+YZdEkGeOVpnBEl2x
	r5aBANfIp4OIG/CVMrlzLGI9BRmN7bIwx4lmNyuKwtw1BpHxGkVvKcnjHoyyCA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v2 0/8] net: dsa: microchip: Add PTP support for
 the KSZ8463
Date: Thu, 22 Jan 2026 14:27:34 +0100
Message-Id: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMYlcmkC/1WOzY7CIBSFX6W5azFAS6mu5j2MC6D3jmQUOoCNP
 +m7S6oblycn5zvfEzImjxn2zRMSzj77GGqQmwbcyYRfZH6sGSSXPRd8x/7yY+j6lk1lYtZp2Tq
 jybgO6mJKSP620g4QsLCAtwLHd5Pw/1rx5VNbk5G5eLn4sm9aMxJJ3aNWgiuBWlvsRhpGuUNjh
 SM+qJ4srayTzyWm+6o8ixX2thPqy24WjFdFQjm03JHiPzbGcvZhW2/huCzLCxG0WtP+AAAA
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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252357-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: E8E0C6846F
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
 drivers/net/dsa/microchip/ksz_ptp.c     | 180 ++++++++++++++++++++++++++++----
 drivers/net/dsa/microchip/ksz_ptp.h     |   9 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  11 ++
 include/net/dsa.h                       |   2 +
 net/dsa/tag_ksz.c                       |  70 +++++++++++++
 9 files changed, 336 insertions(+), 50 deletions(-)
---
base-commit: 3adff276e751051e77be4df8d29eab1cf0856fbf
change-id: 20260109-ksz8463-ptp-bc723ca7fac4

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


