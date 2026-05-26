Return-Path: <netdev+bounces-291712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDacEB+sFWrgXgcAu9opvQ
	(envelope-from <netdev+bounces-291712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:20:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFFE5D7592
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8AB2304648B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B53FFAA2;
	Tue, 26 May 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aMG7L3pl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70C3FF1AC
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805085; cv=none; b=oXsErDVnrDzdxySgW0Bt2Cyqe7f/tz/NtEIx5/v3ldCwDda16XkgZ+xP3yRGA4JVxlX9lNrjLx81TYicg2M8uwbaweGnPp3bMU6zUT+LDR7KXV+K5ueowJ8qTR+8X5Lz02UkE9kr1w6rLrZIodZMayp2b7q9CUdKzjEMMcMdLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805085; c=relaxed/simple;
	bh=c0RNn5qb9vT6IIijXBbTxELaRyRjMTkDCyVB2jC4SqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEWi0Rglq2q4CgYXwYciN6g7bhKDJi8T1DtooKBWhWUUTLN029aeGUqUCOnRa/M6EffmTlLegvDwsJJM+7xPYe9RbFLbztemJ2Cu5sdMuswCv01fPuIT1RxszWzah+PTfjBFeUzi6PjVueHByrwpKgTcwtEuNOTQa/0JtknyrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aMG7L3pl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso26516825e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805081; x=1780409881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRc0rg9JcNLCZHd/xhMyDX0vGds8lGNNIFHieXRVgTg=;
        b=aMG7L3plHaZEUQSQ8cnUQ5RdSYI251JsrTDqXoRPrGw6vDM1N64YAYZ1JxZHGYaUDm
         N/UtNam/RnTrR7syj9Ch1SYtsKXhuc2uTRm4XKonf5ffz9txprVJcIcAERzDeU23hkRu
         Y+D11ihjJKSLw7JOnY5X/NwLEHdyFOLRwKkVSvVBqu8fgljKG5HAduK+PvPQxpX1vtwM
         G6llLUIWjmMc8m8c1DSUOUScskmer+hcCKiPdXQWngnqzVlujaiJB5kDd3MxPqW2rJH3
         RYlvATG0TYkHEgqVlqzqsct7EsFtpJ77kxpSEdv4Zt8o3G2vDrHVPsm3lSIWVCmzeXi3
         ZZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805081; x=1780409881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRc0rg9JcNLCZHd/xhMyDX0vGds8lGNNIFHieXRVgTg=;
        b=i6P6TJedVZiUgQ3VHLUeafSazJ+Ec+/JqMrrm0Tt8pfnIM5vlkXmaBIPpsukDyeqYk
         tEIkTlALUnyZmSTVDud5VxT/njrv0T1BYdck+02MmaJeTxG7/fT6ZSIretR1QLhENe/3
         w792q3Ur1UzssjK9QaZdS/QMz03QZKDM+TpdekY+Y126TQMEPKVqPH4p9LugcmOn63P3
         ZOwdA3hIN1CdZ/AwbCRmD5HzCnn3Tpais0xCL/p7rdRy47/X/p0TwjJYNcwYdQH/kjca
         rgbCft6kke9H4uJLigcOcHVhKUQYVZzf38SqVQjoCyRR0JPqe6CpHzJ9fQ4p30a2g2fj
         HXbw==
X-Gm-Message-State: AOJu0YzMFR1cmEX0CgOCZpLBMJChA9ATDFk+J7SLn40Q5YRSMoRggYDr
	YFEl95BpEzYz5bHL4h+zY3ip7WabBuuyIZGEV8uj8fGo8AIH13VAuNKQwwcSKdMbkA4=
X-Gm-Gg: Acq92OEx2SJAiJX6sBUzCDT+5Y02M9BQPIBc9VYKdV5G9UuH/I9vx8rH51Zm4+D/ivq
	l0bapmJZF6Xym3YStoFU8O7mIuWAAkhNhzuZ0+vJ6YamMnQCTaS/e7UqCwCRWiaKxLmvDL7Fu8J
	qD/UClGjoT7KjQw+VidAtgQJ4rXqd4vMvmoXhV0hjvH/SFWTYVKSCQCQe56PyLRso39lhJ71r2y
	flJ2E06KXJhOnIb3DIWtCaXfEYzeykpre9Z8idn6O/WZfIwNacAy4oLQwCS5DPjsDBg0sCBpy8U
	KMJmwhxs79bQ+R3s+V6KVeXlqs4kJYMLKKnPrWglhXxCRWgiRl0Lld4tngCCBFcDNyj978lqKs1
	pxkxMoIEZP8oeKvtq9YS1wNZH4YmrUHjpsOm9i+SVYmMZsv49k4spe9PE5xmG4i0bcyzU/Exb2I
	f5mk5U10XqOmxWKeIg2SQjxSuu2w4Q8cR6UKqSf11rDRA017ITjFkSEJlkQ8nNuEmeBtaEUkLf6
	++K3W7sFwB2XBk=
X-Received: by 2002:a05:600c:1992:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-490426c5416mr299770605e9.17.1779805081242;
        Tue, 26 May 2026 07:18:01 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6cd10acsm29951620f8f.15.2026.05.26.07.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:18:00 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 net-next 3/8] net: Use named initializer for zorro_device_id arrays
Date: Tue, 26 May 2026 16:17:29 +0200
Message-ID:  <2243204c0f57f79750de00c072914354d4f65707.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3543; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=c0RNn5qb9vT6IIijXBbTxELaRyRjMTkDCyVB2jC4SqM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFat9t5Xx1kUno4MeYd8jN4x+EH0x/XZLCiAiA QYtErFip2mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrfQAKCRCPgPtYfRL+ TnlXB/9uag6CPS55Tq9egoS+k41Y6rFMtl62uNYC0TUlGM9uOKwjfMasmqsDfNj1IolJs8i1x1h NDdjNg8SUnyw9vBBvdpVZkts+PWd4Ls7wYgqioZTWu2jncx/t38Zp88blXJxW5IYW0Qao++0CID OfQk2MLqOmkMOSJ98Dh2HJUyK10UC7H3Dg2PXot79yLY8NYai0+AwW3Wt0dEACfHJYOswUPx0l2 ykalikN7h2MK1AvxQZpbvZnKR9K82plh+P0z4KOSSXwxvMARTUpegSipQGfHeezmXDckky13etF Eg0mFhHpFGuX4GXZQqQabD238N+yk9uRxRnYsHmyzmjDZo/a
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291712-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Queue-Id: ACFFE5D7592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Using named initializers is more explicit and thus easier to parse for a
human.

While touching these arrays, drop explicit zeros from the list terminator.

This change doesn't introduce changes to the compiled zorro_device_id
arrays.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/net/ethernet/8390/hydra.c     | 4 ++--
 drivers/net/ethernet/8390/xsurf100.c  | 4 ++--
 drivers/net/ethernet/8390/zorro8390.c | 6 +++---
 drivers/net/ethernet/amd/a2065.c      | 8 ++++----
 drivers/net/ethernet/amd/ariadne.c    | 4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/8390/hydra.c b/drivers/net/ethernet/8390/hydra.c
index fd9dcdc356e6..9a59915436d2 100644
--- a/drivers/net/ethernet/8390/hydra.c
+++ b/drivers/net/ethernet/8390/hydra.c
@@ -66,8 +66,8 @@ static void hydra_block_output(struct net_device *dev, int count,
 static void hydra_remove_one(struct zorro_dev *z);
 
 static struct zorro_device_id hydra_zorro_tbl[] = {
-    { ZORRO_PROD_HYDRA_SYSTEMS_AMIGANET },
-    { 0 }
+    { .id = ZORRO_PROD_HYDRA_SYSTEMS_AMIGANET },
+    { }
 };
 MODULE_DEVICE_TABLE(zorro, hydra_zorro_tbl);
 
diff --git a/drivers/net/ethernet/8390/xsurf100.c b/drivers/net/ethernet/8390/xsurf100.c
index fe7a74707aa4..370c19aa5fb9 100644
--- a/drivers/net/ethernet/8390/xsurf100.c
+++ b/drivers/net/ethernet/8390/xsurf100.c
@@ -357,8 +357,8 @@ static void xsurf100_remove(struct zorro_dev *zdev)
 }
 
 static const struct zorro_device_id xsurf100_zorro_tbl[] = {
-	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF100, },
-	{ 0 }
+	{ .id = ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF100 },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(zorro, xsurf100_zorro_tbl);
diff --git a/drivers/net/ethernet/8390/zorro8390.c b/drivers/net/ethernet/8390/zorro8390.c
index c24dd4fe7a10..cb1d5ed20874 100644
--- a/drivers/net/ethernet/8390/zorro8390.c
+++ b/drivers/net/ethernet/8390/zorro8390.c
@@ -262,9 +262,9 @@ static void zorro8390_remove_one(struct zorro_dev *z)
 }
 
 static struct zorro_device_id zorro8390_zorro_tbl[] = {
-	{ ZORRO_PROD_VILLAGE_TRONIC_ARIADNE2, },
-	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },
-	{ 0 }
+	{ .id = ZORRO_PROD_VILLAGE_TRONIC_ARIADNE2 },
+	{ .id = ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF },
+	{ }
 };
 MODULE_DEVICE_TABLE(zorro, zorro8390_zorro_tbl);
 
diff --git a/drivers/net/ethernet/amd/a2065.c b/drivers/net/ethernet/amd/a2065.c
index ce9445425045..672c4996b30e 100644
--- a/drivers/net/ethernet/amd/a2065.c
+++ b/drivers/net/ethernet/amd/a2065.c
@@ -647,10 +647,10 @@ static void a2065_remove_one(struct zorro_dev *z);
 
 
 static const struct zorro_device_id a2065_zorro_tbl[] = {
-	{ ZORRO_PROD_CBM_A2065_1 },
-	{ ZORRO_PROD_CBM_A2065_2 },
-	{ ZORRO_PROD_AMERISTAR_A2065 },
-	{ 0 }
+	{ .id = ZORRO_PROD_CBM_A2065_1 },
+	{ .id = ZORRO_PROD_CBM_A2065_2 },
+	{ .id = ZORRO_PROD_AMERISTAR_A2065 },
+	{ }
 };
 MODULE_DEVICE_TABLE(zorro, a2065_zorro_tbl);
 
diff --git a/drivers/net/ethernet/amd/ariadne.c b/drivers/net/ethernet/amd/ariadne.c
index fa201da567ed..ec6e7e8c14fe 100644
--- a/drivers/net/ethernet/amd/ariadne.c
+++ b/drivers/net/ethernet/amd/ariadne.c
@@ -693,8 +693,8 @@ static void ariadne_remove_one(struct zorro_dev *z)
 }
 
 static const struct zorro_device_id ariadne_zorro_tbl[] = {
-	{ ZORRO_PROD_VILLAGE_TRONIC_ARIADNE },
-	{ 0 }
+	{ .id = ZORRO_PROD_VILLAGE_TRONIC_ARIADNE },
+	{ }
 };
 MODULE_DEVICE_TABLE(zorro, ariadne_zorro_tbl);
 
-- 
2.47.3


