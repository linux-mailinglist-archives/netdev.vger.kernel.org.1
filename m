Return-Path: <netdev+bounces-295812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hRYLO8K/ImqHdAEAu9opvQ
	(envelope-from <netdev+bounces-295812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67548648145
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:23:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bXK6rN+R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295812-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDFC8308ED5E
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967C30D3FB;
	Fri,  5 Jun 2026 12:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD02EEE86
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 12:15:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661742; cv=none; b=fMi11IxXs51+Mkx8QKGPIUc0ZmxYlKMh2XBDAFP8LW+Sp9ad3u71v8ZQTwmUA7XYkJzHTtXgNqp7aylKq3JQUyI/ItYTAXU+ACKmGqeDNFCCVkUc2nTvqw0QLvIcetHXv9dtxMginyOrdf4M5hRxGX38qcNhe2EZtZZlf3eqyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661742; c=relaxed/simple;
	bh=fXx6yGbTzyV9r4+8RIi/cY1NomiwKfkeqLs2lx+MlLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HU3DqMTmbXlGM7h0XMfEUBKTQyvsO41N9wTWc3t5GoMNtplwas4zl7KCAh5mHIoPXyaMVzeXSAGRcQSNR7Oy1My34uxYNBUVs8h2RyiOULQSqnEmn45D0XjV+15gJBkOvjfRm/AJLvOtQx3H1MN2u/JC8fT6mW+AuAuMq1KB510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXK6rN+R; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842358aaf36so772678b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780661740; x=1781266540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BtuG0pULy2ESLzHtqYqpkGxYxsqgbLcJ3DpU7JXoV0=;
        b=bXK6rN+Rs93Wf3M7m2aZnpktP/eYSnZ+x14FkP20cby09Hw98X2uS79PFC7zua+wDl
         V6iADps1Zh6joUs504JZlEADmSWtOWqWvg78kkDSNYwnTh/52VnMAzbDn0GlkRCuXHBB
         DANnHbAvvH1xPzebasbiadrz5wA/d72o7pKBLtQGgMy5B8fWd8VAIUNS6IzyE9sOa+/t
         QvL/dVE4qOLsGsP4mZVLcSuqIIVY7+FXsJ0SuslfwrMWiOMqfbWRykvuVLk8jzRtRl5o
         Gn9IAMjGIzZGLmEzKaDxnmFr3dTu4+8P/jpPbZjTTXtutVrZctrJIka8xnhgbP0QhMen
         KJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780661740; x=1781266540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BtuG0pULy2ESLzHtqYqpkGxYxsqgbLcJ3DpU7JXoV0=;
        b=qzV6z6d9CKZJ35w82dvlHJjdk4dcUj9GyrxoWCSZnIDolOnLYZuUr4Q/EJ9kr/715j
         OBptvRCzVOoI07KPpOOV//5MRQEWylYv/pASYI8sPm4vbeqhRt9T8uWuqvhTZ6qag6CM
         uLWpGuVLwSz0K1jPtM5FlfqktJ7JSYRdrbTZP3yfKcunbtL3hl2SjDsudA34aAcEExXh
         wzEbvo77TMtwr/E4sys9dEL0JMpfGHQ5oJ2Kz/GprXEmmIFFzgWSNFNM5WpmW3V2DtUt
         qkJwE5k4Aj+wrDys/fxgUPN+dOiyfEe+qFehGpiigjE39K/yvzUkIMFx7tGCyBRlV/2P
         UiXA==
X-Forwarded-Encrypted: i=1; AFNElJ/c/miCWy50CNHIiXIuzmdkWLEMDnR2pjNUrTMMHz0QknBj/Cvx/zwJZuxr5jj9XLcx3ph7yYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnFeoLt5P8s+WLl0oXFEvVv3ArXTQU+cTmA98H/0Voj2qmoM7
	hzu06ejXMjxclrTwKFIhUmxhCpPYMHTd38TiQhYZSYOdbRdNtdYx9ZDV
X-Gm-Gg: Acq92OFOkSi7eVSPkSsaN7tRga+KOtfJJRoa3Ydby2oawLSeBkvPQoQ21PDdpQ01RlX
	XueY1omema5DQs+xsuiyhJCXq2+oc5NPhFPU/SWFgt3xvMBVHosia34mdv4uWYQI28RT5MD+QwJ
	nP2RtC6ZU0tN++ekTdMenMnxcQYM60jyrdIoUU3HL0achKfaxwWPBxC6cFwJigTx7IT6igaQiKj
	H3R16eCsChyf1bLRhROWToD7FPhPR2Ps02+kXE0G0Xi1HLXULtBi3CajJ//zu5TeTPcCtUFbXpf
	rEM0mSEMU6ZzGkeSwfeCV3MsehmEd9F0OAm272HbU4BPPdekmDL+n9ZGwhaSz4XJqHJYr1t3lUt
	CQJrbBDn5iObJJE84lIt5R0XkI7duosQREshIrYX9nUh2ghKJ+Ip5sbi7QXSjf4R/KSyn853/V6
	SkeOUMUECcPn5eaZDQcSYrYcx3zJ/AwyDt9g==
X-Received: by 2002:a05:6a00:1d91:b0:842:2ddb:e305 with SMTP id d2e1a72fcca58-842b0fc0c71mr3240988b3a.43.1780661739544;
        Fri, 05 Jun 2026 05:15:39 -0700 (PDT)
Received: from ltu.. ([171.245.6.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282374300sm11241583b3a.20.2026.06.05.05.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:15:39 -0700 (PDT)
From: Nguyen Minh Tien <zizuzacker@gmail.com>
To: stable@vger.kernel.org
Cc: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Subject: [PATCH 6.6.y] net: usb: lan78xx: program MAC_CR for LAN7801 fixed-PHY link
Date: Fri,  5 Jun 2026 19:15:35 +0700
Message-Id: <20260605121535.51414-1-zizuzacker@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295812-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zizuzacker@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zizuzacker@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67548648145

While bringing up a LAN7801 wired over RGMII to an MDIO-less switch, I
hit a link that the fixed PHY reported as "up" but that could not pass a
single packet: every frame came out corrupted at the switch and no ARP
reply ever made it back.

It turned out the MAC_CR speed/duplex bits are never set on this path.
lan7801_phy_init() registers a fixed PHY at SPEED_1000/DUPLEX_FULL, but
nothing programs the MAC to match: there is no PHY state machine for a
fixed link, and lan78xx_reset() only sets the auto speed/duplex bits for
the 7800.  So the 7801 comes up at 10M/half, clocks RGMII TXC at 2.5 MHz
instead of 125 MHz, and mangles everything it transmits.

Fix it by programming MAC_CR to 1G/full in the fixed-PHY branch, to match
fphy_status.  Only that branch is touched, so boards with a real external
PHY (and the 7800/7850) are unaffected.

Mainline fixes this differently via the phylink conversion in v6.16,
commit e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved
PHY and MAC management"), which is far too large to backport, so this is
a small fix for stable only.

Please apply to 6.1.y, 6.6.y and 6.12.y, the pre-phylink branches that
still carry this bug.  Built and tested on 6.6.y; the touched code is
identical on 6.1.y and 6.12.y.

Fixes: 89b36fb5e532 ("lan78xx: Lan7801 Support for Fixed PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>
---
 drivers/net/usb/lan78xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index f5bcf150fd9e..6b94f6026472 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2325,6 +2325,22 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 		buf |= HW_CFG_CLK125_EN_;
 		buf |= HW_CFG_REFCLK25_EN_;
 		ret = lan78xx_write_reg(dev, HW_CFG, buf);
+
+		/* Nothing programs MAC_CR for the fixed link: reset() only
+		 * sets speed/duplex for the 7800, so the 7801 is left at
+		 * 10M/half and mangles every frame it sends.  Force it to
+		 * match the 1G/full fphy_status above.
+		 */
+		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
+		if (ret < 0)
+			return NULL;
+		buf &= ~(MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_ |
+			 MAC_CR_ADP_ | MAC_CR_GMII_EN_ |
+			 MAC_CR_SPEED_MASK_);
+		buf |= MAC_CR_SPEED_1000_ | MAC_CR_FULL_DUPLEX_;
+		ret = lan78xx_write_reg(dev, MAC_CR, buf);
+		if (ret < 0)
+			return NULL;
 	} else {
 		if (!phydev->drv) {
 			netdev_err(dev->net, "no PHY driver found\n");
-- 
2.34.1


