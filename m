Return-Path: <netdev+bounces-249691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57626D1C2C9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D819C3014A1F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518B0322B83;
	Wed, 14 Jan 2026 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8JkkpD9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF59322A2A
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359457; cv=none; b=T3qUyIXgZSdY9yCtR6uX3mj+5k8VDM+sxV22jGQVp2g1ezFeQQezAFgR2u4smWWkWqD1IffSOUidpFGTeFEfQmfwe+2gc+yjtbnO7y2g6uk2/wPP+VLkRiyDqlgnvDBbXkcvyf8cpiS6CZ2iFELFWwslNiY1JAPtQcwgDfNasxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359457; c=relaxed/simple;
	bh=LjBkblyUkULyDT4omYys3dIwv9tE600i8x24LDhgZYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N5eGt5Z17MFqv+IwHjo8+REj7WGDocj6B/pBncIKW1LEHciOGQV9Rkg0iOQ4IsdfzUYFwdoeWYA5eVAqIWuxf3BUcic7CwLTkfOfUsHB062RuZewr0A5rmJY2JarQqJgM0YfxEXlyHlPnvsJs2ZV8deVzIe64LHKXfMeKWDg1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8JkkpD9; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so4833315a91.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768359455; x=1768964255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3wa55kpx6iwIJ8pAH9E5hP+eKzgTqRTpXTNuwbc4Hw=;
        b=V8JkkpD9dqum0XxPpTcktpLl1FXjb8LDbnQ+mNGjgIE1aCPImShhGLaurjOivWwU35
         QQaykQUeFQbR2ja/scNL2SzgM5zsmxHycTxttAupZi0qBEgfOvsCzgOi+UPW1YjX4jjO
         YQSAE+TwjATEGjx1nThBOzpI+tBsmDVU3oTBv5h3izBC93m4FUHiIZlxL1Gzrpw8xCdI
         xoqW470LRJJx9vzbExMtyXPOJJ+jim9JFGFNfaY40cJWMcgLz13jzXDAWOx7QJmC6D2D
         gk36PFSNPhafLcMDB/Bfdd+Q5Gcz8mnMQLhF5v+ZS/7sB1/o65bNG+fdaEleeUOE7cFW
         TlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768359455; x=1768964255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3wa55kpx6iwIJ8pAH9E5hP+eKzgTqRTpXTNuwbc4Hw=;
        b=vf8s6Hb1CCuM9lMjnyxjpWOt3+bWFwqwTL1Op4xlXHBecpnpuKss9E9oJ6fmsmN7UW
         pWqTd271s9Od8ikeg84jpKGlVg09RsCK1MHU4kWWCHHeP+tyJhgzAVL2b647+ZxO4dwa
         OwFBYZTbnHzxD905VByIBsfxr11UZQ4hyL0bwgMhfkJ2ZG4f/EoZkma3bVZKnREC9/KF
         bhhhkXbJiMLaOPvegzYrcIy0p/66OdlljdCJe50npLSNJIkPd/Hc34mXW1fuVG0SwhCu
         F9NE/YPc2Y0nf3i1fnxkPLM9qnHKXD2ZN6Xl993eslWlrOZGjtY7RmVmQOC7f+neU33c
         Pjjg==
X-Forwarded-Encrypted: i=1; AJvYcCUlgNEtRXOAj1KKdvVr7gbuD7hPNaROPasKy/5EPzk0cLpi4DAAd0iG+HYr/EhmUGR0DRYSkiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhhFQ885sGOEGQQlsn9yVWKmciHdjdDoBM36rDiWy/VAG+G79
	Me923og5S89z84Ympc4YK7YJi6KZ+XcVLcfZ2KHmJ8PSJSL5MZ0o1Xic
X-Gm-Gg: AY/fxX5czFmb0LdASxnBhBDTVkWt3JnmJLj9vbHmakswpBnuIuhRv+xmcW1nHpK3HQ0
	5a4wyz3/yxqWMLDuy19LvN9OOAhQJKTatNcODPdZnnOvIPeVjc4kYfllVLIOqOo5ugfJ7+ozIIp
	Ps9/EW06twksQsICsz8uDui1IYtFvN/VDl2X4LASbpIrs/UhuEdj7Bd8xQpW6FtdQqF9x/r/9oy
	sDWGUUFDbs27imifbDgkbCLShMVnIHrcGibNKuQzystY5NSV0hvogXmgIaMgUHu35TEEqH8aWmH
	c2V8WLE6d72FaXHztWfJqfE2t8ooeP61mTg+jc+NQssmXFV3wzFINR2DB2QaIJhkia6Eq7DGBNQ
	NoJkinI+Uol7ZeVy1KqglzfUpFyZ0VuBrdmKGwJnXxPcEsS9yFqiv+ypHmtmK5TdepwxRW2GLnC
	gvFtl47LbZXXJCik44/ixfrpQNQ2O05iNfAJ5vYHbhqHYPVKzH
X-Received: by 2002:a17:90b:2fc6:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-3510915b7abmr1289752a91.35.1768359455374;
        Tue, 13 Jan 2026 18:57:35 -0800 (PST)
Received: from yemj-virtual-machine.localdomain ([111.55.148.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109b1974fsm433166a91.5.2026.01.13.18.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 18:57:35 -0800 (PST)
From: insyelu <insyelu@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	nic_swsd@realtek.com,
	tiwai@suse.de
Cc: hayeswang@realtek.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	insyelu <insyelu@gmail.com>
Subject: [PATCH] net: usb: r8152: fix transmit queue timeout
Date: Wed, 14 Jan 2026 10:56:22 +0800
Message-Id: <20260114025622.24348-1-insyelu@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the TX queue length reaches the threshold, the netdev watchdog
immediately detects a TX queue timeout.

This patch updates the transmit queue's trans_start timestamp upon
completion of each asynchronous USB URB submission on the TX path,
ensuring the network watchdog correctly reflects ongoing transmission
activity.

Signed-off-by: insyelu <insyelu@gmail.com>
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index fa5192583860..afec602a5fdb 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1954,6 +1954,8 @@ static void write_bulk_callback(struct urb *urb)
 
 	if (!skb_queue_empty(&tp->tx_queue))
 		tasklet_schedule(&tp->tx_tl);
+
+	netif_trans_update(netdev);
 }
 
 static void intr_callback(struct urb *urb)
-- 
2.34.1


