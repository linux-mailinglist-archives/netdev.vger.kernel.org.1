Return-Path: <netdev+bounces-141125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17B69B9A69
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39D91C214CA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EFB1F7073;
	Fri,  1 Nov 2024 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do/nMTSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99A1F5827;
	Fri,  1 Nov 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497717; cv=none; b=LzXOULSAx2mMFsWKZ+m327DILJjeIvt1443KCMS5V/Ok+yNIB4ttRTVnUGUaIG6SStqbBmIsK6gDXYCEoYWaz6zxDtLjMQi2J3WjNNSlxcpgp3Qndgcy7mKvZmr4o5N9gudbrc0A/79AczuMVRMzAScabbgDaYIMbLburjyLOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497717; c=relaxed/simple;
	bh=r7j2WvtsieCpZbMv5XMgyVj6RY6NOBqWFXbpmlBC0Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcOzF79hVTGh7DGJw//AOCeAxebNfzOZPey24+p7lK6p56TAZ8n9COdmee8PrBwpYGIb0L2Prf2NnDTcpu+H2C76xITxGp9gPdvBQmN01jiEaCS2zAxOVaZR3YFu9/fBsywWODBTNRav8guYKav2wI2zDD35wE8RfqnuHdvk8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do/nMTSY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cbcd71012so28387655ad.3;
        Fri, 01 Nov 2024 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730497715; x=1731102515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkCgUid3lALqAkyziGA3/78dlQ1W88S6aeKIVhXq5Qo=;
        b=Do/nMTSYCOUuHUb6raBXJlra9cnAqXor+XP59lK4xMnvpTP/72rWKxhfB6lix7tRXW
         JtKYHBKgP7y0MwRv/QZkDQu0ppY87qVyPDhO1g4UFjT7qHIPJzFPJDH4WvOrEB5cscBv
         azJ9aN54AK1kCYZYFZ6zpKvQ8Tuyois7p80iVaCxjDV1IMoMKmGgrUI0fLJxpnWiaPuJ
         2CrCLcSiBJwac6OSd70sKFBWYQgAMRKJmNlo3X3qi7Rww2R3XtTjs7acHlN90dohMHMZ
         W2UnB02HJ25BY6RKE0tH3BQBu8gnxJjstlAzvEy/NkBTwHj+dUa9vOWS9I9T7MSO+3gF
         lFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497715; x=1731102515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkCgUid3lALqAkyziGA3/78dlQ1W88S6aeKIVhXq5Qo=;
        b=AZIC57rY0sda0mbYUzWGZVvBPyEZFIzTraf2dTBmzqamWuHGBe5z5H7tn5Xr8iF6yl
         nNLxgg1flAy55v+j10eM/O6BQ0NSv34yuIqU2/kusvlAQckDcolPGzS1ecJAi7+hzfnx
         2DRZnyhYgGx1CTd3VYgKk3rcseFYsOh9MX1lQmibEF3EmA9ZmngexRpJV++KyR16juS4
         UcWogJDYyngcF6VFIg8NiReaJvrOwChcedvQuUkgJhyrh5P7CIS8MkDnX+YBNxLWwqh6
         GocQnXo+xehCHkeg416PeoqYCIlpVhUM3hUet+9O71/+0r+Iryd6xXjcV+PXqIKP/X97
         gV3w==
X-Forwarded-Encrypted: i=1; AJvYcCUyHJqYx+EvhqvDW37/cu+PwggmQZtWzqHHL9tqnlJAvimqo/dlCqDBLf86RLu65AyZAm5EfDjmd+fP1uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbifJTAfcoAZ8MV+HHwjeIIGDKSnk7lwUPHSkeKuScpnmcDC4A
	VxodHTnQBHcViESjDNez/RbWG2OvMdxoe34N+CRoS+rWit54oaJvyAgHmOf7
X-Google-Smtp-Source: AGHT+IF7TeB8qbK2O90WipxhJ5So7uylLqr58H+sqar5PQ2+2Kz9JTR8a/Tonh8MQjF4WjwptrcObQ==
X-Received: by 2002:a17:902:ce91:b0:20c:7a0b:74a3 with SMTP id d9443c01a7336-2111af0aa80mr59481315ad.24.1730497715423;
        Fri, 01 Nov 2024 14:48:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057cf273sm25120155ad.239.2024.11.01.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:48:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] net: ena: simplify some pointer addition
Date: Fri,  1 Nov 2024 14:48:28 -0700
Message-ID: <20241101214828.289752-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101214828.289752-1-rosenp@gmail.com>
References: <20241101214828.289752-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ethtool_sprintf to simplify the code.

Because strings_buf is separate from buf, it needs to be incremented
separately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index fa9d7b8ec00d..96fa55a88faf 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -1120,7 +1120,7 @@ static void ena_dump_stats_ex(struct ena_adapter *adapter, u8 *buf)
 	u8 *strings_buf;
 	u64 *data_buf;
 	int strings_num;
-	int i, rc;
+	int i;
 
 	strings_num = ena_get_sw_stats_count(adapter);
 	if (strings_num <= 0) {
@@ -1149,17 +1149,16 @@ static void ena_dump_stats_ex(struct ena_adapter *adapter, u8 *buf)
 	/* If there is a buffer, dump stats, otherwise print them to dmesg */
 	if (buf)
 		for (i = 0; i < strings_num; i++) {
-			rc = snprintf(buf, ETH_GSTRING_LEN + sizeof(u64),
-				      "%s %llu\n",
-				      strings_buf + i * ETH_GSTRING_LEN,
-				      data_buf[i]);
-			buf += rc;
+			ethtool_sprintf(&buf, "%s %llu\n", strings_buf,
+					data_buf[i]);
+			strings_buf += ETH_GSTRING_LEN;
 		}
 	else
-		for (i = 0; i < strings_num; i++)
+		for (i = 0; i < strings_num; i++) {
 			netif_err(adapter, drv, netdev, "%s: %llu\n",
-				  strings_buf + i * ETH_GSTRING_LEN,
-				  data_buf[i]);
+				  strings_buf, data_buf[i]);
+			strings_buf += ETH_GSTRING_LEN;
+		}
 
 	kfree(strings_buf);
 	kfree(data_buf);
-- 
2.47.0


