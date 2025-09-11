Return-Path: <netdev+bounces-222055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EFCB52EE6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED99F1B26F92
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09193101D2;
	Thu, 11 Sep 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O7lf+sSx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C11A5B8D
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587594; cv=none; b=NCUMGOrYgmtrNarWE53mokzZI95ul4VrgQtf7ZdozUub+JuN77O4Je0m9Vyv6LE8+X5+VahzQ6xXf3FsFt5a05LuVJ0EHCKx6iMTVJEPvT9dGNxoOd1QpMO5OHlGAxwgu6KFafT2WolJRnJgp2ZdmUbAJXTy6kdADYqG1mC9O5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587594; c=relaxed/simple;
	bh=Or1qv/sEfg+8r1/OAVrkL4T8IQWARujQg5vnAeGQB40=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FW2i/n28ovE6cO/KfqAFVQUH9fWgIVP3ZBHb1eDQ3ExbsaX6WbwHhWv6XOlmoT9iXGviEm9qX+cvN8ZDf3H05FMafwcfC26AtTN65MRCTOjgfYyrCcv7WpBn87mPn0dSgRVNkJUbiPTt/gwRBlz72JV8u6jOvlSTNuoIOgdPSnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O7lf+sSx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q1M8eqYHYtM7cAgDHQ7G7hGcSUjPpqM5Rzwa6rhojn8=; b=O7lf+sSx8J72wMpLOEVF9hldh2
	fDOy6JfaVmnD4dSFtAYp3UPliBZtDM/kpAQnYqIFnzvDxIib3rruDKoahcJ+w8XGAC0fRtfhnFagc
	zTDutsKSRt5OtuXEHunMwmQji0kNX4pO1RJYBJuoIF3NMsnDKL4AQuGO6/OfoTsvNtbz9c9d+FaWR
	+xgagqlQ8RKfgeu9SUYC6xpGBy5Sohnu6gFKbTAX0jzuLpl4vwJ9kLHONBU3LXXSWhoR5qUUsbasn
	lHQDXzm4KYR8/npUZ8UDqAxmiZHVWwrdmfltQfYwBA87gS2P1NZX6Jj7gbYpGYpuordu/p3dUz7hY
	Jpzq3bWA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55828 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uweou-000000002pN-3Q5L;
	Thu, 11 Sep 2025 11:46:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uweou-00000004ik1-0aiX;
	Thu, 11 Sep 2025 11:46:28 +0100
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
Subject: [PATCH net-next v2 1/4] net: dsa: mv88e6xxx: remove mv88e6250_ptp_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uweou-00000004ik1-0aiX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 11:46:28 +0100

mv88e6250_ptp_ops and mv88e6352_ptp_ops are identical since commit
7e3c18097a70 ("net: dsa: mv88e6xxx: read cycle counter period from
hardware"). Remove the unnecessary duplication.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 23 -----------------------
 drivers/net/dsa/mv88e6xxx/ptp.h  |  2 --
 3 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 2281d6ab8c9a..25d4c89d36b8 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5088,7 +5088,7 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
 	.avb_ops = &mv88e6352_avb_ops,
-	.ptp_ops = &mv88e6250_ptp_ops,
+	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6250_phylink_get_caps,
 	.set_max_frame_size = mv88e6185_g1_set_max_frame_size,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index e8c9207e932e..62a74bcdc90a 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -413,29 +413,6 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
 };
 
-const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
-	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_enable = mv88e6352_ptp_enable,
-	.ptp_verify = mv88e6352_ptp_verify,
-	.event_work = mv88e6352_tai_event_work,
-	.port_enable = mv88e6352_hwtstamp_port_enable,
-	.port_disable = mv88e6352_hwtstamp_port_disable,
-	.n_ext_ts = 1,
-	.arr0_sts_reg = MV88E6XXX_PORT_PTP_ARR0_STS,
-	.arr1_sts_reg = MV88E6XXX_PORT_PTP_ARR1_STS,
-	.dep_sts_reg = MV88E6XXX_PORT_PTP_DEP_STS,
-	.rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-};
-
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
 	.ptp_enable = mv88e6352_ptp_enable,
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 6c4d09adc93c..24b824f42046 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -149,7 +149,6 @@ void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip);
 				      ptp_clock_info)
 
 extern const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops;
-extern const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops;
 extern const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops;
 extern const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops;
 
@@ -170,7 +169,6 @@ static inline void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
 }
 
 static const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {};
-static const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {};
 static const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {};
 static const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {};
 
-- 
2.47.3


