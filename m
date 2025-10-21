Return-Path: <netdev+bounces-231268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA5BF6BAE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828F5483969
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF633710E;
	Tue, 21 Oct 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="b6aHvt4s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1133507E
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052845; cv=none; b=X2WWxqQl/31uSIgDq+9dqTAI4FYXRs5kShk2XGEcXwaiWqhS8vMz4mTwjsfzZjF3hLYPkC9bFJzpuiXff3yTVrcQazo1ulQVUElVRRp6VdErOwTKvfFzjQzyOSamGxLmeKekDg9ww5opUC64MDRBmTIJUgJ4YbL04Nuu/ZAVwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052845; c=relaxed/simple;
	bh=bRW96s5K6QK1fhMIG4F+/LZV86w+m746kxeTcv+vD6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gW2oqK4NoUd7+OL1F/+q4C+FbM6a3g/gVGC5dLO04/PRuTufzbq69jF3pHBWA8nB0cNWNrVT9+0x7MOioLlMc7jBHR2x2udMb+P1FuGdvO5CdMTF1L7TJedtVZfaHiEkZKKgc3ym/qfWrtwcnLfzyMlaqnzTg1VwGzcSc8n4aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=b6aHvt4s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1076597266b.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1761052841; x=1761657641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1oycTZzUoDkyJ6pS20q3YjjueHvpdaaRdxxEpcgucsU=;
        b=b6aHvt4semsPi1UX57Ejx4zzuClW0umBw5uppbI9G4bh+AhcnOIf2NwXvhXYIZ2NQq
         cEJq2nR3SAKSsHP/EpWsDObyIPxrySKGjd1DwBK21mYJwuqsPLqWk/lpB3CDaztkUuq9
         GwDFYpgF+n+5Sb9F8Goy/gnqHut3ZJTMIcBsW4hxRbCv6VIOhRpqzBoVe41nxQLzDura
         /4RntuVBvWxSs+Up+/YN9xkeI+sui6NODThFBor2lkkR95mcHJbG9fRT1w6zlb9TUzgu
         FrLZ6UkGn/0fRuPf54mjiGB71AvRgnyELQVwKqVmL8+L2IgqsckjVYFWgFJNo6GEzZgi
         UEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052841; x=1761657641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oycTZzUoDkyJ6pS20q3YjjueHvpdaaRdxxEpcgucsU=;
        b=N72StXfLlREnxuYEqX1KhVGA0RVBdraqIXZHbHa2iqsloSs98Yd/VLGNTCq7ATrEID
         flQbZLTOGkhwjvMK2q4GzEzqtXAe2OG3LTP223gjrSAuX2p+D7/Gpv91FxJSn8xNIg62
         YBl+tDl7EYxn5LURYN6rWz2cmB0JfTA1y8gMSfn4fR5eyY4Wdg4V+p9pcSqFnY1JxNHm
         9IEJtUl0EL2bby98N09E/Ujv2y0+nbjpbyt63CmfvD7KHgkrWxTPRrCEe0tQtLcVrQkx
         W6RVyn1/2wOx06kp9RlcW027VUxtTDTn9tWv3/3F5uuSzz9+tHfD+9a8jqYIWvTPq676
         CqTg==
X-Forwarded-Encrypted: i=1; AJvYcCXayJZXsJIUuaI9Zj9ncS6FdsRj3QbWW2+FK1XM93WpO9kxUIsiMYkRcYgsfQLbS3KKp1Fm/xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkghBuOGBlN99ElCOjuP5baS/91ZjV/MAKYzHpbNxyiCeZ0P8
	9oCOpCAh7uA+R25kXrVGN+1gfosdY+Tf0hxY8DVQPRymRuOlRPGtB5ul84J8C9zbUqk=
X-Gm-Gg: ASbGncvos50U+dWDI1C46CibUj+G+WUnZFaAbUJX7j9bNk/Gq0C1RSkomdNeYJ3/UT4
	t4/aESd27wxaEZrvNA5GVVtw554BXgAOy8JMjcx19rZYJc91BE6QrXbdLQea6QkCoNypPK3mOfS
	0dWhZAwcTplClRMGOBJSHJJm2JoEqFIcpvwN3ArXGwxgB/4Utu5zdMgpYRFe1JkVMpczrbjr7Q6
	0CFfXBKyQzHaFgpkHT0dABrxObxS7nj/nBLLvLFlSUlrihCDmOonQ2rGH4ROqIKwPvcfsqkA8xp
	F0mgkZ4FATnlbYILvy4SxJLRe80/rdijX0zQdR+TU3IUJgwkse1S6dFVSgH4OLvyLSk0Tk7oKjP
	NPbz9lqval2e99bSREo/Ll29pch5R0O6C+b98bd1+SjS1KNviFYAiaa6doEufogpURYRzdOJIPl
	H5xneVM8wJoyivWg==
X-Google-Smtp-Source: AGHT+IHnkN9J6ls3cCQo+Po0+g62l+AXaT/giOLW+xSQzumCyw88Vb6sghpJAPP8D5BWv1wyco3vDA==
X-Received: by 2002:a17:907:9607:b0:b04:2452:e267 with SMTP id a640c23a62f3a-b6475705103mr1935315766b.56.1761052841452;
        Tue, 21 Oct 2025 06:20:41 -0700 (PDT)
Received: from fedora (dh207-14-87.xnet.hr. [88.207.14.87])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b65e7da2bc7sm1057788566b.16.2025.10.21.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:20:40 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: daniel.machon@microchip.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	horatiu.vultur@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net] net: phy: micrel: always set shared->phydev for LAN8814
Date: Tue, 21 Oct 2025 15:20:26 +0200
Message-ID: <20251021132034.983936-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, during the LAN8814 PTP probe shared->phydev is only set if PTP
clock gets actually set, otherwise the function will return before setting
it.

This is an issue as shared->phydev is unconditionally being used when IRQ
is being handled, especially in lan8814_gpio_process_cap and since it was
not set it will cause a NULL pointer exception and crash the kernel.

So, simply always set shared->phydev to avoid the NULL pointer exception.

Fixes: b3f1a08fcf0d ("net: phy: micrel: Add support for PTP_PF_EXTTS for lan8814")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/phy/micrel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 16855bf8c391..4929f9b81f54 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4285,6 +4285,8 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
 {
 	struct lan8814_shared_priv *shared = phy_package_get_priv(phydev);
 
+	shared->phydev = phydev;
+
 	/* Initialise shared lock for clock*/
 	mutex_init(&shared->shared_lock);
 
@@ -4340,8 +4342,6 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
 
 	phydev_dbg(phydev, "successfully registered ptp clock\n");
 
-	shared->phydev = phydev;
-
 	/* The EP.4 is shared between all the PHYs in the package and also it
 	 * can be accessed by any of the PHYs
 	 */
-- 
2.51.0


