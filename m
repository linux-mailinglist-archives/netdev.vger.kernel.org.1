Return-Path: <netdev+bounces-247050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F97CF3BE1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 243FA305F642
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF0C2586E8;
	Mon,  5 Jan 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dIujRnnI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AA23EA87
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618511; cv=none; b=Zm9mQzqwxXJ4YsvmnaGAZRwGB0oYtwZFea5nitOr6pxnbzEjcXlxtERuzJuZOu7sXkcH9KYz2JnBwTD+rwKl4brn0SU4OvS4aj4xFayWvqTkiWxD+L1kq41pkEha7G1JFjadZ6D3NO5dyKVOGp3fhoPY8l3mtaG0HXTS7Q2I5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618511; c=relaxed/simple;
	bh=DqXNHoSVeiBSzUBGHZQNwk87Yh6YiCRZGHlYpQtZwYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILSUe0H55CLEG7+2UFFObgkEo67Rh/UpGUG5uF+dkvY++eNGcAjR5NchPcOhDBnpwhE1qfo9FoVCTYSDRB40AbzZOpTL6Ae2ZoYVJQUMnqiLrwPwekwcG+G9u02Nlc8dbCN2my/FrApuIbJRFv1gcibAQYfc1XvQ3IZgGPMxv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dIujRnnI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8C1651A2602;
	Mon,  5 Jan 2026 13:08:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5FDC760726;
	Mon,  5 Jan 2026 13:08:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 748EA103C852F;
	Mon,  5 Jan 2026 14:08:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wTCLUmid6PG6QzdXFMwdqPdThJYrHMsol4xSmttF/zg=;
	b=dIujRnnIXBYqkWTKFyT/I+eteAOf1ct9ZQ36uY0wleS93w/23npYDDI05hbwHz/BwG/4gk
	kjbqbK7MsMvJ3/6rVSVl0qAwSy5k4FOerf02SMP7ToEtwfL2T1Hz24sKSfMm8MuCpZz8fo
	2Zq+QVe3Srf9AOEDZDrfSWWONf1sbvrBIpODFHF06WMr/06x3HMxr1SQXQD3z/ufGzAmKi
	tI7tZjKYP0PRhS36Gf1l/eHkvYleVaMiH7BIZKBE6g/68tjhe1vNFtChRozZxjF2zFq76q
	D0wfTAzBhsIJxdAdTc1sVq+SCco0B9W2jUd1hKGk1mTE9+See3pVXwzGV+LuBA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:03 +0100
Subject: [PATCH net-next 4/9] net: dsa: microchip: Use regs[] to access
 REG_PTP_RTC_NANOSEC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-4-a68df7f57375@bootlin.com>
References: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
In-Reply-To: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Accesses to the PTP_RTC_NANOSEC register are done through a hardcoded
address which doesn't match with the KSZ8463's register layout.

Add a new entry for the PTP_RTC_NANOSEC register in the regs[] tables.
Use the regs[] table to retrieve the PTP_RTC_NANOSEC register address
when accessing it.
Remove the macro defining the address to prevent further use.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c  | 2 ++
 drivers/net/dsa/microchip/ksz_common.h  | 1 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 6 +++---
 drivers/net/dsa/microchip/ksz_ptp_reg.h | 2 --
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d7f407370c1cc59402d444e27ebe44e7a600b441..d400a4ad57b5691d54bce7680fc831475535a85c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -570,6 +570,7 @@ static const u16 ksz8463_regs[] = {
 	[S_BROADCAST_CTRL]		= 0x06,
 	[S_MULTICAST_CTRL]		= 0x04,
 	[PTP_CLK_CTRL]			= 0x0600,
+	[PTP_RTC_NANOSEC]		= 0x0604,
 };
 
 static const u32 ksz8463_masks[] = {
@@ -805,6 +806,7 @@ static const u16 ksz9477_regs[] = {
 	[REG_PORT_PME_STATUS]		= 0x0013,
 	[REG_PORT_PME_CTRL]		= 0x0017,
 	[PTP_CLK_CTRL]			= 0x0500,
+	[PTP_RTC_NANOSEC]		= 0x0504,
 };
 
 static const u32 ksz9477_masks[] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 8033cb9d84838705389e6ed52a5a54aaa8b49497..6d100f1f5e6efe8b43969845ca517625ea825314 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -272,6 +272,7 @@ enum ksz_regs {
 	REG_PORT_PME_STATUS,
 	REG_PORT_PME_CTRL,
 	PTP_CLK_CTRL,
+	PTP_RTC_NANOSEC,
 };
 
 enum ksz_masks {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 68553d9f1e0e3a3cd6319d73b7f9bf6ee2fce7ce..226b10d0f89a6d58c9b329a66ee25eabc9d294a9 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -600,7 +600,7 @@ static int _ksz_ptp_gettime(struct ksz_device *dev, struct timespec64 *ts)
 	if (ret)
 		return ret;
 
-	ret = ksz_read32(dev, REG_PTP_RTC_NANOSEC, &nanoseconds);
+	ret = ksz_read32(dev, regs[PTP_RTC_NANOSEC], &nanoseconds);
 	if (ret)
 		return ret;
 
@@ -687,7 +687,7 @@ static int ksz_ptp_settime(struct ptp_clock_info *ptp,
 	if (ret)
 		goto unlock;
 
-	ret = ksz_write32(dev, REG_PTP_RTC_NANOSEC, ts->tv_nsec);
+	ret = ksz_write32(dev, regs[PTP_RTC_NANOSEC], ts->tv_nsec);
 	if (ret)
 		goto unlock;
 
@@ -778,7 +778,7 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	 */
 	sec = div_s64_rem(delta, NSEC_PER_SEC, &nsec);
 
-	ret = ksz_write32(dev, REG_PTP_RTC_NANOSEC, abs(nsec));
+	ret = ksz_write32(dev, regs[PTP_RTC_NANOSEC], abs(nsec));
 	if (ret)
 		goto unlock;
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index bf8526390c2a2face12406c575a1ea3e4d42e3e6..9ab918c7af4b46a73e00846950ac09917c65db5a 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -29,8 +29,6 @@
 #define PTP_RTC_SUB_NANOSEC_M		0x0007
 #define PTP_RTC_0NS			0x00
 
-#define REG_PTP_RTC_NANOSEC		0x0504
-
 #define REG_PTP_RTC_SEC			0x0508
 
 #define REG_PTP_SUBNANOSEC_RATE		0x050C

-- 
2.52.0


