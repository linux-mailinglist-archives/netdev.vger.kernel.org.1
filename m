Return-Path: <netdev+bounces-222056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEFDB52EE7
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7214AA02633
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D780274B57;
	Thu, 11 Sep 2025 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ictSRcDO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4D26E71F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587598; cv=none; b=f06EZ8NmG+FVdl1tv58Kmy46emABaBU3/O/aKi1XfSdf6hNgJivjuWK7g3kfOb40G/V94Hb7xbIzcm0a6Yv/F0uYpZv+q/E0+Wp5z1yacvsX2mJHOfppTa0NxX/fn1NTWE8DPI9SGxJDGZdTmIWaQCn2F3BI51Av3NPWxh475lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587598; c=relaxed/simple;
	bh=Wac7CE8qZejoTi10r5nwvo1WdNnyzaNFV0HJXNWM0jQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JMzXxjlAxNvDhirSLJ3U8kL9oDg8H9QWM3wV0SU06pbSU9zdHClXzlTVLYPNVzfW7T+VivqpGwUI4vaef03y2MabMkK2e1PFrsmHYx5gTKuSG5ybmNUixLR354uoAsUnE9Nxcxi7aMD/diNr9B4bjYVgDw0l93unQEYyNLIwB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ictSRcDO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HWaSaPen4rEfDoKac8UT2tb4mgh0QvgznmruNImI3H4=; b=ictSRcDO8dg3ytwd1HC4MUR8T3
	U9t2vpvJI+EkZyS2ZN2UuCBDCn7nAhg9xYeomm7ZK+Qr1YgR2mMwpw5hd85sX7Ni6Mx9QNWtBN4UN
	G9PG+Q1GdsctWKbBpg13AfqwUjKRFbTVHjhFpmm3GnODMEaSdnHY7poB+NvGYcSJjxO1u8CGjWRPO
	Q86Qks58vQTY2klwGERNIiE9xhf1bqobiyIKoFgekMQOpzZ5fhQW+Vi/E3otZYE8nxj+YHsMTQD2e
	ANJe1WHPPi7JWA9UU8dDpjo2R/HapwZt9F+wSFvDiTzZVRSb4bY9olBPmgs78ehfqyNOc2/FQAklq
	sSV/x5gQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41620 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uweoz-000000002pX-4AQz;
	Thu, 11 Sep 2025 11:46:34 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uweoz-00000004ik7-13Fl;
	Thu, 11 Sep 2025 11:46:33 +0100
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
Subject: [PATCH net-next v2 2/4] net: dsa: mv88e6xxx: remove chip->trig_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uweoz-00000004ik7-13Fl@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 11:46:33 +0100

chip->trig_config is never written, and thus takes the value zero.
Remove this struct member and its single reader.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h | 1 -
 drivers/net/dsa/mv88e6xxx/ptp.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index feddf505c918..9beaffb2eb12 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -424,7 +424,6 @@ struct mv88e6xxx_chip {
 	struct ptp_clock_info	ptp_clock_info;
 	struct delayed_work	tai_event_work;
 	struct ptp_pin_desc	pin_config[MV88E6XXX_MAX_GPIO];
-	u16 trig_config;
 	u16 evcap_config;
 	u16 enable_count;
 
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 62a74bcdc90a..402328b9349b 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -184,7 +184,7 @@ static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
 	if (!rising)
 		chip->evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
 
-	global_config = (chip->evcap_config | chip->trig_config);
+	global_config = chip->evcap_config;
 	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, global_config);
 	if (err)
 		return err;
-- 
2.47.3


