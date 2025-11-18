Return-Path: <netdev+bounces-239447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491E5C68735
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 098482A59B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF18311C14;
	Tue, 18 Nov 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Q+GWs2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42016304BDA
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457190; cv=none; b=oSxXvK8Zy0VYPMfn8tfGa6TUyYp3G40Lqfd8q2hfgWkolpVyk4L+r2HsFVeWmWhjsMhyGwcjMB2Z2o923OEupLau41irvVrwioZ5Dc1nMBBD52CGV80hKDIqcwW+7xqR9M1MJ411e9wDlTTsKIZo6JSF/T4LqvdNvOX+fNhl8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457190; c=relaxed/simple;
	bh=SdqlTpbJJyHy0CnqZckFC0G6Xe2xBCQUl7hLQuseWzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFKFwqRVMpNOZZ6GCwVrea9HSwOicHuzft2N7QfCxWIIix04KorNmL4jyzeRkiWACpu1hW/gnxlw7c1PMcm8D51/fhSrMVs1MbWu8EiVRV4VA5XB2YqkOS7G/i+Q7j12QJSai/Hxkl1kfyPNotFsl6NwZoPqS7cG2Hj4w3xVR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9Q+GWs2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so5900007b3a.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763457183; x=1764061983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFkOpeDn2jRMncnbRni6Etd02PIBihHP7ylWcxC9j6Q=;
        b=X9Q+GWs2L009mwZPy6IOjfaRQycjcX9fjfXcwbrJ4DbWPjN15DiP3EY9uktdfC2IDt
         PIr4Dng+xI6hK6gnhFyAUS0m4cg07q7Plmxjm8ku9/7nrEolsQN8KOGdKJIlNEKIjMzq
         T7Y1sxnhuB0b+kaM4q/I6VV6CieuK32pKiGKl+5R8lc4ERDG8iAGOqXBlhSFv7vGKBkC
         aWJBu1LO0Inv2SYz9tpWbLvyvq3I93/I46GIai2jNKRvuHbUpjPLWSAU+DkNtZ689B+h
         K7TZ9RUsTdkuFRjhAwiO36SekdhCEUXt98eEkY/u+dq3c4/3LLFFas4/otX6mtQYUf7a
         w7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763457183; x=1764061983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFkOpeDn2jRMncnbRni6Etd02PIBihHP7ylWcxC9j6Q=;
        b=L2oSmUj4P7EmijbqOT1rEOWo8CApqrYi+u138COUY6UWyrOftfrKATgNGZ2pT+mQ/7
         hBiSQnjw6uEqMckG4nJeua9TXTmV6M0E3bQ1hwPc4KHVRHpjSqw0EDcJ2nW65tHJqGc/
         YA9Cblq26TY5xg1GnqtjPXXDP+V9I4UE8etZxyTDjVioTAvujojW/gN9owUsXG3OAtRk
         UkQYPUMrvMfCZzg+oz0ujkiTG+CHrTL3u/MkTKbeEoCjBY3iZwJ6gorVfX8+pmnHAz6F
         aUkj6+EH06rz3l3tloOIL9xW7/taYm9yXrsH/S+rTgMoRZVOwI97i1A/Y4pPZezgzaMF
         rxiw==
X-Gm-Message-State: AOJu0YyyYuQDMWZ78Kc8SOzdb8EpJiOUvapdd9vWcfWEZF/Bw7ZoCIN5
	v0PkT/1NZPmCno1Gqx+j7Wj8jaTcg4fnCoDSVzgQW9MlOmGY0j13fC7WjywyczF2
X-Gm-Gg: ASbGncvj3DEUtQ8ZmqRw1C44+RD/chkkpbSe2nUUMZaVkQCmHrqmhcw+UWmwgmGUQFN
	g69r/0BKIsbPRkr3bU0UTPLO8FQZryDsWJOxka+83phg4CzHCURz5mKahFjOIfFw9iE3PGZoLdJ
	G7eDsiWULJRPpS0X0O6zORzn4ZX08sxCPDenBgOZm5vRRSJ5TUsd+w/5X1bmvaVr418m8DspuMP
	8YZLIbBeAPKaMfjN7PoPueyLff7WzTC995FGnPhnFgEL3V3EzIwD+fWj6031AvlSZQojV4KSnmS
	XEzRMIoL9/0jFb4+46d+ZZ9BBo7jmbwx6MgUMXIZSbIqnUF5UEeb5z7p8tTn6NVtjYerWpMbJkg
	YIV7eRQfN+O9LAhPq7rkuSLonrdj4W8yGnX7iS77gbiaww3tLOLwUB6PvVFISeioCs/N1DO3dZM
	DB0atTVts=
X-Google-Smtp-Source: AGHT+IELD+mUOOmyAzNfNMxNVLo7AvHaGl4tLct5UR4tcQdGQzNqWRjSuqIa9bQ6MpfLRzKhYDaiyA==
X-Received: by 2002:a05:6a20:6a03:b0:334:a180:b7ac with SMTP id adf61e73a8af0-35ba1c93579mr19863554637.39.1763457183358;
        Tue, 18 Nov 2025 01:13:03 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9251ca3e9sm15913459b3a.29.2025.11.18.01.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:13:02 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: yt921x: Fix MIB attribute table
Date: Tue, 18 Nov 2025 17:12:33 +0800
Message-ID: <20251118091237.2208994-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are holes in the MIB field I didn't notice, leading to wrong
statistics after stress tests.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 944988e29127..97fc6085f4d0 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -56,13 +56,13 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
 
 	MIB_DESC(1, 0x30, NULL),	/* RxPktSz1024To1518 */
 	MIB_DESC(1, 0x34, NULL),	/* RxPktSz1519ToMax */
-	MIB_DESC(2, 0x38, NULL),	/* RxGoodBytes */
-	/* 0x3c */
+	/* 0x38 unused */
+	MIB_DESC(2, 0x3c, NULL),	/* RxGoodBytes */
 
-	MIB_DESC(2, 0x40, "RxBadBytes"),
-	/* 0x44 */
-	MIB_DESC(2, 0x48, NULL),	/* RxOverSzErr */
-	/* 0x4c */
+	/* 0x40 */
+	MIB_DESC(2, 0x44, "RxBadBytes"),
+	/* 0x48 */
+	MIB_DESC(1, 0x4c, NULL),	/* RxOverSzErr */
 
 	MIB_DESC(1, 0x50, NULL),	/* RxDropped */
 	MIB_DESC(1, 0x54, NULL),	/* TxBroadcast */
@@ -79,10 +79,10 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
 	MIB_DESC(1, 0x78, NULL),	/* TxPktSz1024To1518 */
 	MIB_DESC(1, 0x7c, NULL),	/* TxPktSz1519ToMax */
 
-	MIB_DESC(2, 0x80, NULL),	/* TxGoodBytes */
-	/* 0x84 */
-	MIB_DESC(2, 0x88, NULL),	/* TxCollision */
-	/* 0x8c */
+	/* 0x80 unused */
+	MIB_DESC(2, 0x84, NULL),	/* TxGoodBytes */
+	/* 0x88 */
+	MIB_DESC(1, 0x8c, NULL),	/* TxCollision */
 
 	MIB_DESC(1, 0x90, NULL),	/* TxExcessiveCollistion */
 	MIB_DESC(1, 0x94, NULL),	/* TxMultipleCollision */
@@ -705,7 +705,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			res = yt921x_reg_read(priv, reg + 4, &val1);
 			if (res)
 				break;
-			val = ((u64)val0 << 32) | val1;
+			val = ((u64)val1 << 32) | val0;
 		}
 
 		WRITE_ONCE(*valp, val);
-- 
2.51.0


