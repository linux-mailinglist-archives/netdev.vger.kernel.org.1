Return-Path: <netdev+bounces-81993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A506988C061
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609892C28ED
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C618481A5;
	Tue, 26 Mar 2024 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWai1kEz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQQjC5Xd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B538FB9
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451803; cv=none; b=V9MPUakacM90eNDdv7bAi0VSP47gDnXDf2sLveRe8Lv7L7opk7pbCPK1juvl2feOVU8XxOnD/qMYk3LoiUN0I/YnthPGPnP1c+6biEisLjKvCd++uioyMK/pth/yFNWp8kZm+W00zK+C8UbUH/w96KfRGaFJyPmKeeMPSv2LN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451803; c=relaxed/simple;
	bh=BGPk/lQ94xri38fSGgvTuCQrQuMSuPAAGLXAL0WnRX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EpyTX5ExtsoyabFrntxlbUXDdsxnhPVPjT3MRIeO/Huar641QB/SLnfI/1VgJg4Jm8COhGItnV9tDeqfhxC2MJiSPKPiuv/bCG36+1dvNHZgEj+JRSdLOGbiN5RJB+ZV5mPdCu5xjdml7zMwdjXJKQAE1ji67kT9zkVUY7rstdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWai1kEz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQQjC5Xd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711451796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EsKYMbXwOpsKW3uXTMFE8ZstpdsUhdOtB3Re9kwEXsQ=;
	b=KWai1kEz7cMDyfkSX2zpvst0S9WuATcZocEJjeM8SwdIO0TpZvKJ08qzG7Ui5pInY5qxLY
	0Mjfn5Iy3cmPurHya+ifVoQPmgpPAaFpIHBkuXXFpoQb54xo+zA4rSmWdYY0utOYhKXFPo
	QMXp3ukkFZkVJgg+E+1K+2uR5pUatgnEL1eNBF6n3va0XgEQLL41Jhc+Vkxpo2PqnoqfR6
	awi8PkOojiK+ExZl9SMmDNQMZ/FGZorCdWXKQa6YixtSo4Vj3HZVPY60W0Mjvvfju4Dx1y
	YPAgR9xG2HFoztBaM8I/BBwGA+DlHVObp4p8xBXlDjxyCpTctUD+DjHS6SX9sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711451796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EsKYMbXwOpsKW3uXTMFE8ZstpdsUhdOtB3Re9kwEXsQ=;
	b=AQQjC5XdiLJPr8XJ/qnKRFlOPVX55uF/lanVWkkuohHiU1YRLS2+i+lEkb6GYKAr5enabc
	DlpyWlbWlqpW46Bg==
Date: Tue, 26 Mar 2024 12:16:36 +0100
Subject: [PATCH net-next] net: dsa: hellcreek: Convert to gettimex64()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-hellcreek_gettimex64-v1-1-66e26744e50c@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJOuAmYC/x2NUQrCMBAFr1L220DTtKl4FRFJ47NZbKNsggRK7
 27q5zAMs1GCMBJdmo0EX078jhX0qSEfXJyh+FGZurbrW9NZFbAsXoDXfUbOvKLYXg3joM/WjMZ
 oSzWdXIKaxEUfjnh1KUMO8RE8ufx/V4rIKqJkuu37D+Xnte2JAAAA
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4301; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=BGPk/lQ94xri38fSGgvTuCQrQuMSuPAAGLXAL0WnRX4=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmAq6U0tcql6QzDabkMUY2cvA/Mm1pyUw1FdtUD
 GKhsb3e3lSJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZgKulAAKCRDBk9HyqkZz
 guMNEACGD2PB483aKtKIp74p74UbdwkXbFhG7330/JHdEuNMUI+xbxScR+A8vm/9CSpVa2i8PFv
 Mrufcucfccqu6w4M4Itqtun+Yq3+WFqL7/GgB9+U6Oh6c+Irzq5nV6s+6YTIteZdOVpFaIx8xhH
 VeeexP686gxshbQr6X1GI7zwUZ/12w5GzusesgX6kWY7YSj9QW2HmWMsyn+tfCqKDGSdxtGJX5i
 Q43HXWcBd6a9IWk4ER1eU4YD8BrC7mXOAFgeF89F0m5gCHnoHsnELpxXLn9w4FKZ3WiJCwLgUJQ
 FDu2xjax8azdSojpKmZvFHar3bd0YRGl7Ncm73MXWbn0aAYAgYXlamycMHVOhH4McLozn5fHhIo
 YQZyfhdzx01jRhE5sv8CCmapDLNKZT361bH1QTufzetUGl8IeUFMmVyVfpS1RPYFQParjX/DYBm
 XSE+PaYngZ73vMYOnR2HTt2pMQt6AbB4sazFIG3ZbET5JAO+NJGiHopC66xDMtYQOVVheVyFAJb
 iqqhfuIqk9DuOtUn0cvJcP1bJPLhyFlBmr5o8WT5YvAjY5N0FG+i83mO3t7n2VWgcPkeyJTmdvo
 Md6/rBEZsfH7xbbSwV18Lib6D0e0nfFuiEaoe6xav82P9OLIdAZjS0vbihkKuvMnA+9jisFSPQG
 LOsFmeYz90JlVQA==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

As of commit 916444df305e ("ptp: deprecate gettime64() in favor of
gettimex64()") (new) PTP drivers should rather implement gettimex64().

In addition, this variant provides timestamps from the system clock. The
readings have to be recorded right before and after reading the lowest bits
of the PHC timestamp.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/dsa/hirschmann/hellcreek_ptp.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek_ptp.c b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
index 5249a1c2a80b..bfe21f9f7dcd 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_ptp.c
+++ b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
@@ -27,7 +27,8 @@ void hellcreek_ptp_write(struct hellcreek *hellcreek, u16 data,
 }
 
 /* Get nanoseconds from PTP clock */
-static u64 hellcreek_ptp_clock_read(struct hellcreek *hellcreek)
+static u64 hellcreek_ptp_clock_read(struct hellcreek *hellcreek,
+				    struct ptp_system_timestamp *sts)
 {
 	u16 nsl, nsh;
 
@@ -45,16 +46,19 @@ static u64 hellcreek_ptp_clock_read(struct hellcreek *hellcreek)
 	nsh = hellcreek_ptp_read(hellcreek, PR_SS_SYNC_DATA_C);
 	nsh = hellcreek_ptp_read(hellcreek, PR_SS_SYNC_DATA_C);
 	nsh = hellcreek_ptp_read(hellcreek, PR_SS_SYNC_DATA_C);
+	ptp_read_system_prets(sts);
 	nsl = hellcreek_ptp_read(hellcreek, PR_SS_SYNC_DATA_C);
+	ptp_read_system_postts(sts);
 
 	return (u64)nsl | ((u64)nsh << 16);
 }
 
-static u64 __hellcreek_ptp_gettime(struct hellcreek *hellcreek)
+static u64 __hellcreek_ptp_gettime(struct hellcreek *hellcreek,
+				   struct ptp_system_timestamp *sts)
 {
 	u64 ns;
 
-	ns = hellcreek_ptp_clock_read(hellcreek);
+	ns = hellcreek_ptp_clock_read(hellcreek, sts);
 	if (ns < hellcreek->last_ts)
 		hellcreek->seconds++;
 	hellcreek->last_ts = ns;
@@ -72,7 +76,7 @@ u64 hellcreek_ptp_gettime_seconds(struct hellcreek *hellcreek, u64 ns)
 {
 	u64 s;
 
-	__hellcreek_ptp_gettime(hellcreek);
+	__hellcreek_ptp_gettime(hellcreek, NULL);
 	if (hellcreek->last_ts > ns)
 		s = hellcreek->seconds * NSEC_PER_SEC;
 	else
@@ -81,14 +85,15 @@ u64 hellcreek_ptp_gettime_seconds(struct hellcreek *hellcreek, u64 ns)
 	return s;
 }
 
-static int hellcreek_ptp_gettime(struct ptp_clock_info *ptp,
-				 struct timespec64 *ts)
+static int hellcreek_ptp_gettimex(struct ptp_clock_info *ptp,
+				  struct timespec64 *ts,
+				  struct ptp_system_timestamp *sts)
 {
 	struct hellcreek *hellcreek = ptp_to_hellcreek(ptp);
 	u64 ns;
 
 	mutex_lock(&hellcreek->ptp_lock);
-	ns = __hellcreek_ptp_gettime(hellcreek);
+	ns = __hellcreek_ptp_gettime(hellcreek, sts);
 	mutex_unlock(&hellcreek->ptp_lock);
 
 	*ts = ns_to_timespec64(ns);
@@ -184,7 +189,7 @@ static int hellcreek_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	if (abs(delta) > MAX_SLOW_OFFSET_ADJ) {
 		struct timespec64 now, then = ns_to_timespec64(delta);
 
-		hellcreek_ptp_gettime(ptp, &now);
+		hellcreek_ptp_gettimex(ptp, &now, NULL);
 		now = timespec64_add(now, then);
 		hellcreek_ptp_settime(ptp, &now);
 
@@ -233,7 +238,7 @@ static void hellcreek_ptp_overflow_check(struct work_struct *work)
 	hellcreek = dw_overflow_to_hellcreek(dw);
 
 	mutex_lock(&hellcreek->ptp_lock);
-	__hellcreek_ptp_gettime(hellcreek);
+	__hellcreek_ptp_gettime(hellcreek, NULL);
 	mutex_unlock(&hellcreek->ptp_lock);
 
 	schedule_delayed_work(&hellcreek->overflow_work,
@@ -409,7 +414,7 @@ int hellcreek_ptp_setup(struct hellcreek *hellcreek)
 	hellcreek->ptp_clock_info.pps	      = 0;
 	hellcreek->ptp_clock_info.adjfine     = hellcreek_ptp_adjfine;
 	hellcreek->ptp_clock_info.adjtime     = hellcreek_ptp_adjtime;
-	hellcreek->ptp_clock_info.gettime64   = hellcreek_ptp_gettime;
+	hellcreek->ptp_clock_info.gettimex64  = hellcreek_ptp_gettimex;
 	hellcreek->ptp_clock_info.settime64   = hellcreek_ptp_settime;
 	hellcreek->ptp_clock_info.enable      = hellcreek_ptp_enable;
 	hellcreek->ptp_clock_info.do_aux_work = hellcreek_hwtstamp_work;

---
base-commit: 537c2e91d3549e5d6020bb0576cf9b54a845255f
change-id: 20240326-hellcreek_gettimex64-575186373316

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


