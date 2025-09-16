Return-Path: <netdev+bounces-223713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D18BB5A351
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D401651AF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A952F90D4;
	Tue, 16 Sep 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A13U4g5p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCD31BC9D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054904; cv=none; b=OBhUV+KervMTCv93f0BCoOEeGfkdWpTbovRw0AUSx99dPYwTX84WszUKBfjbtTXq2IMya73ksn/0gaVPe3lxFvw+1MhgFzUOBESh0a7KmaV23s24gZM0uhLMGI37HCTgpJbTZNkrNw+/iVjBTNcqBrjbz//bDOy+yOxw5VB4xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054904; c=relaxed/simple;
	bh=yLivdPPA8ecn7//JxEEtgqN07NPegxE0qbpoxHVSICk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Dv4tsK/7w3s/8+W2PnFlpb0A77ikvVq7JbRRWNoQ3FMr+VZvbGCKnHQA9pkUpeWIwLyt4MQZHbQM6e/Ogf8WVEPBnbM+6nSEmj6iz29bVadjiOORZIGULcrzGCFNLtSUSQqbP30uTMfZ7/AhGWzgiIOCsg6Bhv9rtwfbW4fDuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A13U4g5p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=El1C3xsDlYGm1FeMsvq6k/owjHp3QM5Fs8eLAFa2Axs=; b=A13U4g5p6EpnEsmYnOwN3jEZeF
	caiku/x4Z2At3/JtA059teAlI7LiUXNE5rtDOcn3xS0ysFMM1iRwYc17cAhQkKSknvbEP59QXGzkv
	JNJJuUsQIj2B8A6FstBfqr5HiFxel75bynA/TJKU/lz2351K0eD2xcil32tfG2mQsqlXEoKS9979h
	K8aC/OLsZa4jH9MwD7ubHMnPkrZrSnE9MUXRL3itawwXWIXl8usU5P2i5IExE8xlOpCoxDZpnEk2X
	590L0l3/u3T5F3IYR2RsA0quWEXsX+O/pmZtYByGbbnHXIL616P8hgpQy5zcl5zYb0Br+45pU8+ii
	lYFcs0Sw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60620 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uycOB-0000000068I-1kQE;
	Tue, 16 Sep 2025 21:34:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uycOA-00000005xb6-2qG0;
	Tue, 16 Sep 2025 21:34:58 +0100
In-Reply-To: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
References: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 3/5] net: dsa: mv88e6xxx: remove duplicated
 register definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uycOA-00000005xb6-2qG0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Sep 2025 21:34:58 +0100

There are two identical MV88E6XXX_PTP_GC_ETYPE definitions in ptp.h,
and MV88E6XXX_PTP_ETHERTYPE in hwtstamp.h which all refer to the
exact same register. As the code that accesses this register is in
hwtstamp.c, use the hwtstamp.h definition, and remove the
unnecessary duplicated definition in ptp.h

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 2 +-
 drivers/net/dsa/mv88e6xxx/ptp.h      | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index f663799b0b3b..6e6472a3b75a 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -570,7 +570,7 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	}
 
 	/* Set the ethertype of L2 PTP messages */
-	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_GC_ETYPE, ETH_P_1588);
+	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_ETHERTYPE, ETH_P_1588);
 	if (err)
 		return err;
 
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index d66db82d53e1..a8dc34f1f8bf 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -44,13 +44,7 @@
 #define MV88E6352_TAI_TIME_LO			0x0e
 #define MV88E6352_TAI_TIME_HI			0x0f
 
-/* Offset 0x00: Ether Type */
-#define MV88E6XXX_PTP_GC_ETYPE			0x00
-
 /* 6165 Global Control Registers */
-/* Offset 0x00: Ether Type */
-#define MV88E6XXX_PTP_GC_ETYPE			0x00
-
 /* Offset 0x01: Message ID */
 #define MV88E6XXX_PTP_GC_MESSAGE_ID		0x01
 
-- 
2.47.3


