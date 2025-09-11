Return-Path: <netdev+bounces-222057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECDB52EE9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1337BA971
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11D26E71F;
	Thu, 11 Sep 2025 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sIW7hl3u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567242DF712
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587605; cv=none; b=tBct76oUpgLQK/slCxLX1Y1DAgXQB3h1c6IPjNXyd1QAK7N3wgijedKUctUvZ0NHkhwQ0tTL48omqAklmwzBBiB6ATFvMPVm7I4sEQe8L4LCOeo0U2jP8q4Y59/v4UIqfONpoY2BUB1YDEVwDg28WwCFsV2g49jfcRxa5t0emMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587605; c=relaxed/simple;
	bh=FI1KNQB21oubjqVbp1WgP86VP6P3KLDviKNgpTMAESA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cSIwbsWk2KL2CyIdvMsyP5O8DrOLqa6sAqQPwMk2M6ddebRbyCIxC8MD48MIIdfkD29VRf0kmO3xWXZEpkKFV1wbtOUFDSRFZ8kezfVjRyPNOjWgodiUDEJ19ggfAyeO0kWdI+m83jVjCB+y/Tii4jiWqTZmPfMBxs53tMvZb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sIW7hl3u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PhS0k5w+t4wcdZ8ivI3uNScBKLQ6fVB8+OiuYalLoZc=; b=sIW7hl3uPzJLmSKveQNxw/d0eT
	K28LoO+1Bzrf/YBsvCQjwzGLbom0UGfWHAtX31kjib4CzIl+m7HQXn6oW1A7xSPr/9JFQakZIylNq
	4mNkW/ufEQpgwbfOygcC6FPdXdMuGQJKjQ3vI/+6QBSIlZFguF/MmGG3L9LNF4EhLJLVTyOIxZhnR
	ExQNV/uXM4wIz08BzXkwAaHLdOvh+AraIqwAB8quzx4LNY1QkpXmieE3cEnygy6Qpj6WB+Ewe/IWh
	BbPgKRhzGZq/Y+C3w3anZ0/HVWgwR3YLSiaCh9hAM5tz/X+aeLQ9AAd1iSIsUe/0J7zp0uDLoEjFD
	UQViUdYw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44428 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwep5-000000002pp-0gQ7;
	Thu, 11 Sep 2025 11:46:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwep4-00000004ikD-1ZEh;
	Thu, 11 Sep 2025 11:46:38 +0100
In-Reply-To: <aMKoYyN18FHFCa1q@shell.armlinux.org.uk>
References: <aMKoYyN18FHFCa1q@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 3/4] net: dsa: mv88e6xxx: remove
 chip->evcap_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwep4-00000004ikD-1ZEh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 11:46:38 +0100

evcap_config is only read and written in mv88e6352_config_eventcap(),
so it makes little sense to store it in the global chip struct. Make
it a local variable instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
--
v2: fix evap_config typo
---
 drivers/net/dsa/mv88e6xxx/chip.h |  1 -
 drivers/net/dsa/mv88e6xxx/ptp.c  | 11 +++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 9beaffb2eb12..2f211e55cb47 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -424,7 +424,6 @@ struct mv88e6xxx_chip {
 	struct ptp_clock_info	ptp_clock_info;
 	struct delayed_work	tai_event_work;
 	struct ptp_pin_desc	pin_config[MV88E6XXX_MAX_GPIO];
-	u16 evcap_config;
 	u16 enable_count;
 
 	/* Current ingress and egress monitor ports */
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 402328b9349b..350f1d5c05f4 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -175,17 +175,16 @@ static u64 mv88e6165_ptp_clock_read(struct cyclecounter *cc)
 static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
 				     int rising)
 {
-	u16 global_config;
+	u16 evcap_config;
 	u16 cap_config;
 	int err;
 
-	chip->evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
-			     MV88E6XXX_TAI_CFG_CAP_CTR_START;
+	evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
+		       MV88E6XXX_TAI_CFG_CAP_CTR_START;
 	if (!rising)
-		chip->evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
+		evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
 
-	global_config = chip->evcap_config;
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, global_config);
+	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, evcap_config);
 	if (err)
 		return err;
 
-- 
2.47.3


