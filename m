Return-Path: <netdev+bounces-266308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKQCBEJ1sGnJjQIAu9opvQ
	(envelope-from <netdev+bounces-266308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:47:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633EF2571D2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5956830172E2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719A359A83;
	Tue, 10 Mar 2026 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLPxcCnp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C3359714
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172027; cv=none; b=COAA7pYRYAjeIDyHVL8s2FG07lXHERmi1ZSAyb9+a/FDdSN0OkKMg9fZ79AuE537hqMcByhzv6qkoxUyNpn7KPOsMcyyZ3IlytH+mBrPNYcJSU13Cpbopczb8ugXTB07xWTEFGxpZvCbxM5t/T3K7AMMsmMVUHcFGnQlq7yKd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172027; c=relaxed/simple;
	bh=S6icAiA8dhguxmXeT7PZxJHaPmFV2Dg6g7dxnB9Be7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQP1dke3dczGyfWjih1kVefyR3HZAjT+6XSSmc/r21qPEZM3FBKAz/GaBSwuOBKXXs3NFYgyPVVNgas1Z502rCTQIaHBe5dPxXUfSOYiwzyTcGlZlBwcwtgo7whwHon4eZIzwSe2pyUsGvEWf9/oiqRjum/QtRPL+3su4eGh+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLPxcCnp; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae222d87dso12249292d50.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773172025; x=1773776825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nAWNRcrPLh4NOKUzVn7/SjtpjBoGF+ow6W32XLnTmWI=;
        b=YLPxcCnpiZikSzEJuo0s3aFlf4vKWjKiWEbmF1I+4B7ABHyubeu1XWG5/zxcwjJDfK
         y5pbkXPA2OUOjhf6SH9aSt9un1jpEqBideD3O0PbT43BBkeSofjim41G6gm4KAAYvJDh
         GygibSoijimA779Pc2ixHsNi5qiDyMcHprBZCuTeM3qmWc2MTgADLOkM4HQefKUjznO1
         w9lQ/p+mbBHDv3bU4t8qelS2EPq4Nj2o/pTLXRhzNeOfde9n/HGGhBif17kknyMimeuE
         6ZWNz8U2VKceubXYvyoY6x0znBAXYsx6H5qZs7Lj6SW9N4RzRNDe/TkGW/6qHYJqw16m
         +mGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172025; x=1773776825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAWNRcrPLh4NOKUzVn7/SjtpjBoGF+ow6W32XLnTmWI=;
        b=QA+LmaMrdJZ4b5mBIt7UbcDgWpFdAbOBZV8L1OQa+pNsOGmS7cAmgSOeqP6ckby7Hd
         +aiwMcALyzwVFZqphunutozob1oYWRSvsOI0kSeP1owcg98kOzA+/ue2C+CQ5fhEYOen
         FmMJYWDHgbiz0tm3otcRi3u3YjaCYldUHAHMs1MxzOWIfdeN0aAB+2sLS0QKsaxqpH3T
         k+V/RM94g39j9wFVWYEydL+cc8wCjSHa2CyWesZRNFztuSFTMiUWlfyBHfdAnf1JbVY0
         fujQjtNyr3hGf26NVUudsigEgij3Pe1wMcEsj+P/BwcYRrAeQ+EbgXejWGcvHyCYffy0
         zqgA==
X-Gm-Message-State: AOJu0YwkoyZm6xY2Clx3wsjxBkHFT2jHjI63VgUKwzrHQYag1FJB1F5C
	q2kJuY1bQYk7sDtcCZOIby11bkmzGg46ZX9Sy86QwM/zZQHYujFE/Jk3kblHsGR6
X-Gm-Gg: ATEYQzyBVKj0ZkqBNLTg2fCzjpaGS8FYw5j4srQeYJ4az7a1cVgPWti0yyqdQLFXwI5
	zxnhaLa1AqLw2s+9uXeVn6om8CDh5wE95gk4mpO3Ktit6AitG/SPrDRGQ6ALuv0SmW/DvvUUqnp
	SmsutaIT8BaQLu72TWnfrPSx1gFoX8gtIAkcukVvcccu8Xafm7ye3DwVwOkTrIDLNHnesbc4Zd3
	SrahK4z3o2C56otwj7Ayk7yrWIitX0+e9y8Y6A3SGVsCrWqaKhf3c0Qre52q/pK27frJrLE1UO9
	P4Dmvsw39Pd037a54c1kNiXAHl47nZrPCnL17NflOeV9jFKQbzWQlXxrrMGx3gA4mzu5D1FVa2S
	NmLBR5dyC73uhCIpjU1bajdOtmpw3lvMH+YsPPU9RuibPJE495lWpTtp8Br0JwXWJpHDx+dTtvi
	Juol7+rigrZ4FtSMVKYAA2ygzok5GALZkNw6zV1PX4Ctne+maafqO6Kg==
X-Received: by 2002:a05:690c:6604:b0:796:6da9:bfa3 with SMTP id 00721157ae682-798dd6706a6mr151321247b3.7.1773172024914;
        Tue, 10 Mar 2026 12:47:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a518c9bsm21152987b3.10.2026.03.10.12.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:47:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 net-next] net: xgbe: use device_get_mac_addr
Date: Tue, 10 Mar 2026 12:46:46 -0700
Message-ID: <20260310194647.3794-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 633EF2571D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266308-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

device_get_mac_addr is basically device_property_read_u8_array with an
is_valid_ether_addr call. Allows just checking for ret.

Remove XGBE_MAC_ADDR_PROPERTY. device_get_mac_addr supports more
properties than just "mac-address".

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: remove unreachaable !ret condition. device_get_mac_address sets it
 to that.
 v2: remove XGBE_MAC_ADDR_PROPERTY
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 10 +++-------
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  1 -
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index 47d53e59ccf6..0debe015073e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -252,13 +252,9 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 		dev_dbg(dev, "sir1_regs  = %p\n", pdata->sir1_regs);

 	/* Retrieve the MAC address */
-	ret = device_property_read_u8_array(dev, XGBE_MAC_ADDR_PROPERTY,
-					    pdata->mac_addr,
-					    sizeof(pdata->mac_addr));
-	if (ret || !is_valid_ether_addr(pdata->mac_addr)) {
-		dev_err(dev, "invalid %s property\n", XGBE_MAC_ADDR_PROPERTY);
-		if (!ret)
-			ret = -EINVAL;
+	ret = device_get_mac_address(dev, pdata->mac_addr);
+	if (ret) {
+		dev_err(dev, "invalid MAC address property\n");
 		goto err_io;
 	}

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 4333d269ee84..e57e416a1d5a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -96,7 +96,6 @@
 	min_t(unsigned int, IEEE_8021QAZ_MAX_TCS, (_cnt))

 /* Common property names */
-#define XGBE_MAC_ADDR_PROPERTY	"mac-address"
 #define XGBE_PHY_MODE_PROPERTY	"phy-mode"
 #define XGBE_DMA_IRQS_PROPERTY	"amd,per-channel-interrupt"
 #define XGBE_SPEEDSET_PROPERTY	"amd,speed-set"
--
2.53.0


