Return-Path: <netdev+bounces-224562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D0B86458
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF4E565CE1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C631AF1C;
	Thu, 18 Sep 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1GJ4A+mO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDD3164D3
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217165; cv=none; b=UuoFMAgV6d7LRASelAvZcCgHxnNMGCmQUlcU8fkKw2niFaE+4GOfpPOhjNg4FbRRhmAPV2snuTMkp3pzWBGwGiE7xxrXXETz9D0pe1gLFkca081+RTigbwaj4AtFrzYPPvmPG2FtSFFMl916dsvK69NZFEeTMcPF3hyUT434KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217165; c=relaxed/simple;
	bh=nqSfGphQdib49xGhSNHfhe2kI8nbFI2cITzifAQ4Cfg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Tf2LA4wgVR4eBsowCGimd8rQNy+3H2rWhDY0tNDTZnA3Lz0uokzLugbP+SNEkKLOYrJ2Mai4bIPSMiNgHqSwRbNpaA5U64Aes7WOR+1vqqvJ0kTCCpG/Sa2BVnqRyeIFByG0i7b8jtiOKfyOd4p0Mzzy4iz+OukEqbeXsxSIvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1GJ4A+mO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gt3aknvaxAiwIYMxR7crRl11qqh5dvIzDxuZoKGkGK4=; b=1GJ4A+mOeI714u28Za8CwzKswl
	GUn2bm67ZpgOK5uy7H62T6gmg4UBf+3nM22nkeAg/7B7igNT2dd0VtokRHfFCqFalDyVCFxs2S2ee
	XtmneQ5JkakGtyfzpXfY8QnMakTi9UsNrl6MGdIlD6AeBo83O5kvxHtZaME7ef71R2TNX5WH0nFEv
	TavRjS8mAvkhyjJjGwRGDjO7jUtuDpIrCCAa2gxvS4Q5lG46cur4UkpPsQZRUrz5lmA9XjIodUW6Y
	j6MfiB+XY9R3LaqdCbAeIiQaYH59fbOFK5k36ZWwmdb968Xe7dHikrKbjBDk11zO6UbfmlfSOy+Kp
	/bZJkfuQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57368 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbG-000000001b7-1DHK;
	Thu, 18 Sep 2025 18:39:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbF-00000006mzW-1gww;
	Thu, 18 Sep 2025 18:39:17 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 05/20] net: dsa: mv88e6xxx: convert PTP
 clock_read() method to take chip
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbF-00000006mzW-1gww@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:17 +0100

The various clock_read() method implementations do not make use of the
passed struct cycle_counter except to convert to the parent struct
mv88e6xxx_chip. The caller of these methods has already done this.

Pass a pointer to struct mv88e6xxx_chip instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h | 2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 2f211e55cb47..fd91d2252735 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -730,7 +730,7 @@ struct mv88e6xxx_avb_ops {
 };
 
 struct mv88e6xxx_ptp_ops {
-	u64 (*clock_read)(struct cyclecounter *cc);
+	u64 (*clock_read)(struct mv88e6xxx_chip *chip);
 	int (*ptp_enable)(struct ptp_clock_info *ptp,
 			  struct ptp_clock_request *rq, int on);
 	int (*ptp_verify)(struct ptp_clock_info *ptp, unsigned int pin,
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index b60e4f02c256..d907ba04eddd 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -138,9 +138,8 @@ mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
 	}
 }
 
-static u64 mv88e6352_ptp_clock_read(struct cyclecounter *cc)
+static u64 mv88e6352_ptp_clock_read(struct mv88e6xxx_chip *chip)
 {
-	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 	u16 phc_time[2];
 	int err;
 
@@ -152,9 +151,8 @@ static u64 mv88e6352_ptp_clock_read(struct cyclecounter *cc)
 		return ((u32)phc_time[1] << 16) | phc_time[0];
 }
 
-static u64 mv88e6165_ptp_clock_read(struct cyclecounter *cc)
+static u64 mv88e6165_ptp_clock_read(struct mv88e6xxx_chip *chip)
 {
-	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 	u16 phc_time[2];
 	int err;
 
@@ -470,7 +468,7 @@ static u64 mv88e6xxx_ptp_clock_read(struct cyclecounter *cc)
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 
 	if (chip->info->ops->ptp_ops->clock_read)
-		return chip->info->ops->ptp_ops->clock_read(cc);
+		return chip->info->ops->ptp_ops->clock_read(chip);
 
 	return 0;
 }
-- 
2.47.3


