Return-Path: <netdev+bounces-106572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0B916DBF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42F8B274BE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC1171E75;
	Tue, 25 Jun 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="mU3E5QnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5ED16FF5B
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331622; cv=none; b=V0n8TjeKHV6ckQytMWr/O++0fR4QT3KnMTr20i9oedRjqBUxdJ2wcGpJMdlrvlvCv0B6U3t9ER9oDGpku9DwBsxBqVjCICDNARM467V50YNGOF3z8tPGGna13uEhgvUkByMjtqaIvgrelX2HthQGUbPIU0VE/lgYU9pqojXDYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331622; c=relaxed/simple;
	bh=tI5wgxUIR5ttYXBLnZidjpdPzjcs2hMqzD9JXZxFLmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjuZdCglKwyQpyJNrgfy17hAUwx7MZy3saxe7pwMtFxRBbyyJE6a/sBHWYp9lbLv3VzJTvzWK9OpjA//sUjM7n37h093JSRy45/dY/fjiP8VLoayz5cVhR8hCttWIIyIfo0Cq4qGOFviL/xmJu1ar93Irzw3nSyk9kFSQI0tdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=mU3E5QnD; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1CE3C9C5B61;
	Tue, 25 Jun 2024 12:06:54 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5CQg7G5I8W9y; Tue, 25 Jun 2024 12:06:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5985D9C59F2;
	Tue, 25 Jun 2024 12:06:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5985D9C59F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719331613; bh=v87H5fOt9tHSV3TRoD4XrpJJEo/VOf6RrMnyDae28Js=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=mU3E5QnDB4A2xC+qu2B+VC0ScG+ZK7vHHIFCuhSAjdNRHnGNZI8YmiNy+KvQ1O0Bg
	 QnOlWtQLAFjGSwrKA7sJdcmVpu4fv+ReieZ7USTvQ17dMQswFUqRZY5GYrn4PIxKoC
	 R8dkJQdf6B0WNq1W0DZOgclJ3KvO+iQHMbldyT3pBLnYnr4watPGJjWQikRcWbQoHE
	 odd2Kg3w0Peb5MQvO5NfSQBSQa66AxMyD4bbN2rRMAihJgD2Twhqb7XW4RZGzIxT7k
	 DdyRtGf7jH0wM1MNRQ6XCVtAeziE5zIiOeoCn8p23PJNkt+VpzwnHc2gT6v+HSGCR/
	 VxEavpoObh4Lg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xVPGEaagme0L; Tue, 25 Jun 2024 12:06:53 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E63D09C5B61;
	Tue, 25 Jun 2024 12:06:51 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	horms@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Woojung Huh <Woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net v8 2/3] net: dsa: microchip: use collision based back pressure mode
Date: Tue, 25 Jun 2024 16:05:19 +0000
Message-Id: <20240625160520.358945-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Errata DS80000758 states that carrier sense back pressure mode can cause
link down issues in 100BASE-TX half duplex mode. The datasheet also
recommends to always use the collision based back pressure mode.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
Reviewed-by: Woojung Huh <Woojung.huh@microchip.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v5:
 - define SW_BACK_PRESSURE_COLLISION
v4: https://lore.kernel.org/all/20240531142430.678198-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - rebase on net/main
 - add Fixes tag
v3: https://lore.kernel.org/all/20240530102436.226189-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/dsa/microchip/ksz9477.c     | 4 ++++
 drivers/net/dsa/microchip/ksz9477_reg.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index f8ad7833f5d9..c2878dd0ad7e 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1299,6 +1299,10 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* Enable REG_SW_MTU__2 reg by setting SW_JUMBO_PACKET */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_JUMBO_PACKET, true);
=20
+	/* Use collision based back pressure mode. */
+	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_BACK_PRESSURE,
+		SW_BACK_PRESSURE_COLLISION);
+
 	/* Now we can configure default MTU value */
 	ret =3D regmap_update_bits(ksz_regmap_16(dev), REG_SW_MTU__2, REG_SW_MT=
U_MASK,
 				 VLAN_ETH_FRAME_LEN + ETH_FCS_LEN);
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/mi=
crochip/ksz9477_reg.h
index f3a205ee483f..fb124be8edd3 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -247,6 +247,7 @@
 #define REG_SW_MAC_CTRL_1		0x0331
=20
 #define SW_BACK_PRESSURE		BIT(5)
+#define SW_BACK_PRESSURE_COLLISION	0
 #define FAIR_FLOW_CTRL			BIT(4)
 #define NO_EXC_COLLISION_DROP		BIT(3)
 #define SW_JUMBO_PACKET			BIT(2)
--=20
2.34.1


