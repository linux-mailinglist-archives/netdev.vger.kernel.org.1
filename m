Return-Path: <netdev+bounces-283921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOuLL028+Gnh0AIAu9opvQ
	(envelope-from <netdev+bounces-283921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:33:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C574C0BA7
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A8B2303E2CF
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4684B3DF000;
	Mon,  4 May 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpWhz5FX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D813DEFFE
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908758; cv=none; b=aERVCvV1pu2BpuZToTK4+XX/ZttimnJfrrlUOpdrTWA/yZcN+i8Lnydn48fNhEi4ObtMylhw2o+0m/Q5L/GgOMp0Ficrrciskv35JaN424GHzLu7rOJuQD8vnJwsyhBAxVBTbSFzFreqdn9keKqV4tRyjJjFF5X3dVeJEKwYPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908758; c=relaxed/simple;
	bh=ExXcA38vezcQHgwnf3BvBqnCDaZeP+9Yxadw0uwN0Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUx5lSsd/+CiiONZn1bog02Lmw70N5MmmiT1B8bGDBLXbctjETSgjlnjE1nq+6qa+gBsCUZHCeSs0yRXpH96DO50sEcuaEZtuMNfbWNjqa8gPdE0UDNxQlV1GlTPvK0VwsndcHVRwGae0/rjSyJuKa28mxeQ/994+mVk7xHYqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpWhz5FX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1F3C2BCC4;
	Mon,  4 May 2026 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908757;
	bh=ExXcA38vezcQHgwnf3BvBqnCDaZeP+9Yxadw0uwN0Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpWhz5FXjGmPpaeQqKzs+ZcjtYrYbjDXv1g86T5CU7Y78cdwwaZ7Wap/HB6eHjQPk
	 OKCOmYSJg5HxnjOZecJuZU5VFmzSjwkhg20CLZSKRvJ2KN1yuvmmUP+/eTOrRKNK2D
	 JFcOAdL0bDzrjxlL9owD2W7qhU3JzNQOa9vCcZ5ACvB3oNHnU1R9HVUgvTVWnPRKhF
	 WEYu2FrWyrTP2j7Ah4vWQplY8P/O51NJwvD3/fleLgcsfhSYm6k3KiolbYjLiekuuo
	 P3rKZzOM1PWajRr3nAJLiGEMC0UTsTKTPL9mYY0677n5tlpAGtDiBWqbNKOoDtn8Kq
	 maUVCxCV5Fe7Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org,
	Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 2/5] net: dsa: mv88e6xxx: allow SPEED_200 for 6320 family on supported ports
Date: Mon,  4 May 2026 17:32:24 +0200
Message-ID: <20260504153227.1390546-3-kabel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504153227.1390546-1-kabel@kernel.org>
References: <20260504153227.1390546-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29C574C0BA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,waldekranz.com,vger.kernel.org,ericsson.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The 6320 family supports the ALT_SPEED bit on ports 2, 5 and 6. Allow
this speed by implementing 6320 family specific .port_set_speed_duplex()
method.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  4 ++--
 drivers/net/dsa/mv88e6xxx/port.c | 15 +++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 338cba0c8364..78799666e6b7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5168,7 +5168,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_link = mv88e6xxx_port_set_link,
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
-	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
+	.port_set_speed_duplex = mv88e6320_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -5221,7 +5221,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_link = mv88e6xxx_port_set_link,
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
-	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
+	.port_set_speed_duplex = mv88e6320_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 74cfc0bb7b5b..ea1fab71968a 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -327,6 +327,21 @@ int mv88e6250_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 					       duplex);
 }
 
+int mv88e6320_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
+				    int speed, int duplex)
+{
+	bool has_200 = (port == 2 || port == 5 || port == 6);
+
+	if (speed > 1000)
+		return -EOPNOTSUPP;
+
+	if (speed == 200 && !has_200)
+		return -EOPNOTSUPP;
+
+	return mv88e6xxx_port_set_speed_duplex(chip, port, speed, has_200,
+					       false, duplex);
+}
+
 /* Support 10, 100, 200, 1000, 2500 Mbps (e.g. 88E6341) */
 int mv88e6341_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex)
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 44b100dd618b..5b6cde9f7406 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -493,6 +493,8 @@ int mv88e6185_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex);
 int mv88e6250_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex);
+int mv88e6320_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
+				    int speed, int duplex);
 int mv88e6341_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex);
 int mv88e6352_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
-- 
2.53.0


