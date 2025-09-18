Return-Path: <netdev+bounces-224561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE73B86443
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E9A7E0793
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3231A80B;
	Thu, 18 Sep 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qp5otcrv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE631A57E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217161; cv=none; b=kyGouVW5bBISQrQ9QEVDQ6hkyeMkiDgV6MVzLRiNr3KALzfs7EeOjnWwJWbHAi/rMeBQttZguCk636MTSdwSgWI3B3rtxLMbhrF8bTTRpKrs1qklRsolZRIEzebSgYHCmw/AeqG4mOvsSXdk5b71qGeSe5rE6pQ/+gcDieVA95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217161; c=relaxed/simple;
	bh=sclMrJy8rrU0H2dBrpfyUcdRoTAKlobYdzkAhVQN/Ak=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CVL/3pXZFp3nvgYO9VRoB9G10yGrqI8dpz9LVhbxbfmxUDGVAcy5S+1Kg//OO5XKT2f0YZO44l44RmiF8GCs7Z2RwQSgEBoBcznbzMgOLVr3TsF2+94/T43o0QyDuW/0GVczZETAOG3Me8A6WNLAYZVg940IIiKEPGV7hC7YRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qp5otcrv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=10RHlDUK5bMtiVyELKrPhyJAF7jRxBSFU08ayKFWF4A=; b=qp5otcrvvc8OKgNLOopyJafnT8
	a5b72uD2lme1YbgN0nHn3YyX6HRPn3H9Fogz2AryHgQeHoruHdve6FKF07nDtvCK5TmBiIUuidnw7
	OjTG0YacQNOZ1wH0ygVgazRTQdqSCVKEDueAmnqwBhWG3yuon+KaDiEXJWBQ5dSKJyojYRpIuN07F
	gP/v3NzOvVdY7kRrYUrt1zSwhSSFRwM5FDmJFut7uGO9zq0yqf1ZYie2wYza3SGzb5CzrG2my+2zZ
	Jt+meLUW9zkj3R8Jhz/2gBLI5Ft3lwrlPSRL9NHYh6CvuxW6J57Wbpw7jOlo+yod+CaD9s4fN7eJ+
	GQCf/Syw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57356 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbB-000000001ar-0XDg;
	Thu, 18 Sep 2025 18:39:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbA-00000006mzQ-1B8y;
	Thu, 18 Sep 2025 18:39:12 +0100
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
Subject: [PATCH RFC net-next 04/20] net: dsa: mv88e6xxx: split out
 set_ptp_cpu_port() code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbA-00000006mzQ-1B8y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:12 +0100

Split out the code which sets up the upstream CPU port for PTP. This
will be required when converted to the generic Marvell PTP library.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 42 ++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index f7603573d3a9..b60e4f02c256 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -444,6 +444,27 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
 };
 
+static int mv88e6xxx_set_ptp_cpu_port(struct mv88e6xxx_chip *chip)
+{
+	struct dsa_port *dp;
+	int upstream = 0;
+	int err;
+
+	if (!chip->info->ops->ptp_ops->set_ptp_cpu_port)
+		return 0;
+
+	dsa_switch_for_each_user_port(dp, chip->ds) {
+		upstream = dsa_upstream_port(chip->ds, dp->index);
+		break;
+	}
+
+	err = chip->info->ops->ptp_ops->set_ptp_cpu_port(chip, upstream);
+	if (err)
+		dev_err(chip->dev, "Failed to set PTP CPU destination port!\n");
+
+	return err;
+}
+
 static u64 mv88e6xxx_ptp_clock_read(struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
@@ -473,7 +494,7 @@ static void mv88e6xxx_ptp_overflow_check(struct work_struct *work)
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
-	int i;
+	int err, i;
 
 	/* Set up the cycle counter */
 	chip->cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
@@ -524,22 +545,9 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 						     PTP_FALLING_EDGE |
 						     PTP_STRICT_FLAGS;
 
-	if (ptp_ops->set_ptp_cpu_port) {
-		struct dsa_port *dp;
-		int upstream = 0;
-		int err;
-
-		dsa_switch_for_each_user_port(dp, chip->ds) {
-			upstream = dsa_upstream_port(chip->ds, dp->index);
-			break;
-		}
-
-		err = ptp_ops->set_ptp_cpu_port(chip, upstream);
-		if (err) {
-			dev_err(chip->dev, "Failed to set PTP CPU destination port!\n");
-			return err;
-		}
-	}
+	err = mv88e6xxx_set_ptp_cpu_port(chip);
+	if (err)
+		return err;
 
 	chip->ptp_clock = ptp_clock_register(&chip->ptp_clock_info, chip->dev);
 	if (IS_ERR(chip->ptp_clock))
-- 
2.47.3


