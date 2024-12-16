Return-Path: <netdev+bounces-152102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584AD9F2AD3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927D0188918F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D81D45F2;
	Mon, 16 Dec 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="RoRWDaW8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C271D364C
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333614; cv=none; b=S4BolUtHhY4iHPj48b9AypdYWEnb3RwZPGGx3J3vFxZn+4MZoUSgkInfCEwrOZ8rKkEbWQrLmHHMZ3zxQXeZS1UysmSwOt3UI4wRmUxaqnAT0Y8UoGlS6F/l0LHMUrNe8W9yyfeFzkoyiHHgxLgr2js15Xq1RjQ0ZOFshZIUTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333614; c=relaxed/simple;
	bh=2tnr8Bwh6X/FYoBAuSdjBG6lvqx9CRulw85LcMBiY9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uujCwrmW78zL71JlGmdHjhkE8G5kpVorlD+fgHQbJpaovy0PMR/lf8C82aPDCi8hnSf8Mk/gL+F2RQ0u3c2aRCkbS9QDgQNppvEwzwmqLO9Wq31WXzOo12kYpyMcRYyaaq1WU2d/Ps/WPHg+Zu5JM5Z9YvVbTC1HSKbhyjvGB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=RoRWDaW8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e3a227b82so3664251e87.0
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 23:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734333610; x=1734938410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDorma76GwDfrQOXtmRW3Vi/QHYCkRM+JtP0H9DhWBY=;
        b=RoRWDaW8BhoHbU7XzolTUw8JLg7TxIbssoSsv0Ren3JnFgVrvuq2OxVCeRgaZGzkq1
         sTK9b3HdmP6nAP95n+UUOlwip8obpCJYGm7ZhovExFNBhxsxWTXzR+DkF385T8hZimyD
         H3y1xHEj7N6lLXD8rTgQpcmFruroFny3jb8HsOf0m8rSBhejyFWhdT9zqMEAfHZcst96
         RYzk2bfGLK1c0s2S8T+CmaCJ7nsfnkPvsTrmcr5cTkCWbmY1ieSuepVbO/ozxEYHu7/q
         CD1r/4+lISBwQJNAZaVU6zDJOGgL43s0TBSP1zvkkBvCsaqFN3vyqDwjZUIzyl9C3QEv
         CBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333610; x=1734938410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDorma76GwDfrQOXtmRW3Vi/QHYCkRM+JtP0H9DhWBY=;
        b=ZlReCJp9/vAePAVstWdk/w5OF5miso/l7+Js9kHMHyDphh6xaj/3Al7Kmn+siEh2Ya
         6lASi77eu3GN9FvvI2y09ri0G3o7lwSdWoH+17vQ+neOsO6U4cWs/z3/4Cgek4hWOmvD
         nIIda21R8vztVcg50sVliXyZB4uxrwrZaeIPYNF5iMHPTkHH4yO7brywBVm1R5zC+Jta
         CnNOabKbPyMN6NxYjL2ap7EDzKWjWNw1JHV1TW6142KzR0EWxGtjIl1gIKFKRE6Ig3is
         /zYdJBIgsmJWjm0/muqVcCakb+f0dX5vLsyNg8uxFtCzo4fqPK1nASxxiNJHngH33t4M
         UMWA==
X-Gm-Message-State: AOJu0YwByqnEFJ6azrfNlwkVcOHHEjdqqtrMu6mzoU0zho4DS2ZD26m2
	oXlM2MhYR3v4WlQuIOraYgxe9tVDMsU2xqQ6FnqiJZdemtTQUDdE8zxHxEeul0k=
X-Gm-Gg: ASbGnctIfm7OauEL4j04jnPEsvuKVcR8at+PuWILXfowI4STnckBJqskFst397Vy76Z
	xlT0WcNhD0yiDuz2H9+krgL2czX7XsmVV2iuUFSgGt6uMT9ucYclpRqgo3PlYSr/5U6Bd5zPqoN
	5N7APxdUkf32oTUdKShkAT+0RRSq7S1Gf09pcsAS2HTQmUEfkwobPRZueInkxSsDBcynGfxSDa/
	IAuh073jw/UnUz34l9lnbXPpBB0PjOsbSc+WMEuEHLCpzINUuu2G97s/NsOTCxEcC1O90k=
X-Google-Smtp-Source: AGHT+IHopqkpGhBw9gHzXw4RFZJ8eHI7vJAH0G9GOleXtOF0VwnbcXx/A2P2rJLeqHcvXE4tjhMdyA==
X-Received: by 2002:a05:6512:2813:b0:53e:37df:6637 with SMTP id 2adb3069b0e04-540905618d0mr3129724e87.32.1734333610495;
        Sun, 15 Dec 2024 23:20:10 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9b2bsm748930e87.94.2024.12.15.23.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:20:10 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next v2 2/5] net: renesas: rswitch: use FIELD_PREP for remaining MPIC register fields
Date: Mon, 16 Dec 2024 12:19:54 +0500
Message-Id: <20241216071957.2587354-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
References: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fb9e6039c325 ("net: renesas: rswitch: fix initial MPIC register
setting") converted setting some MPIC fields to FIELD_PREP.

To keep common style, do the same with mii bus related fields of the
same register.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c |  5 +++--
 drivers/net/ethernet/renesas/rswitch.h | 10 ++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 12efee9f75d8..e1541a206687 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1164,8 +1164,9 @@ static void rswitch_rmac_setting(struct rswitch_etha *etha, const u8 *mac)
 
 static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
 {
-	rswitch_modify(etha->addr, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
-		       MPIC_PSMCS(etha->psmcs) | MPIC_PSMHT(0x06));
+	rswitch_modify(etha->addr, MPIC, MPIC_PSMCS | MPIC_PSMHT,
+		       FIELD_PREP(MPIC_PSMCS, etha->psmcs) |
+		       FIELD_PREP(MPIC_PSMHT, 0x06));
 }
 
 static int rswitch_etha_hw_init(struct rswitch_etha *etha, const u8 *mac)
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 4b1489100330..78c0325cdf30 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -732,6 +732,8 @@ enum rswitch_etha_mode {
 #define MPIC_LSC_100M		1
 #define MPIC_LSC_1G		2
 #define MPIC_LSC_2_5G		3
+#define MPIC_PSMCS		GENMASK(22, 16)
+#define MPIC_PSMHT		GENMASK(26, 24)
 
 #define MDIO_READ_C45		0x03
 #define MDIO_WRITE_C45		0x01
@@ -747,14 +749,6 @@ enum rswitch_etha_mode {
 #define MMIS1_PRACS             BIT(0) /* Read */
 #define MMIS1_CLEAR_FLAGS       0xf
 
-#define MPIC_PSMCS_SHIFT	16
-#define MPIC_PSMCS_MASK		GENMASK(22, MPIC_PSMCS_SHIFT)
-#define MPIC_PSMCS(val)		((val) << MPIC_PSMCS_SHIFT)
-
-#define MPIC_PSMHT_SHIFT	24
-#define MPIC_PSMHT_MASK		GENMASK(26, MPIC_PSMHT_SHIFT)
-#define MPIC_PSMHT(val)		((val) << MPIC_PSMHT_SHIFT)
-
 #define MLVC_PLV		BIT(16)
 
 /* GWCA */
-- 
2.39.5


