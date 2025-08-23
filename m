Return-Path: <netdev+bounces-216231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED76B32B79
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634CB3BF53F
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE520AF67;
	Sat, 23 Aug 2025 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPrSFxDr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43A1DF247;
	Sat, 23 Aug 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755973974; cv=none; b=EVf/HqINwxhesgapS66IRnZe22blCWlcJ3twgp/EK+CfAMH+S4ZLvbo4YSOqzEkP3lY28mKmX2V8OiXEJfoNi+/ovqEtX6MmFOHMVXERETZXEFkOPicl9BPiAqD4XcaV8X/iDxHwQxNHJAB/Vx1csq0Fs7bXaghuCxncvMgxNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755973974; c=relaxed/simple;
	bh=aky10XdH4z1GJYT58eFzMQ0RV1473ZNoDqsCN4S1B4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpRbU8MGu0b/dlbKnlfDfC+JeyIGcG9U2Z5ZDEqXvIxYCEUP+WrHzLPylxlkEQzodtQi9mBf03Vzfq4UQin65RVgbuXwZT7Kf8bARVwjkP7v56pychBjMxDrmyafOsYPkWxf59+Ye9On9eMjV/HfW7Z0buKZPktrIn5UkIP2rYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPrSFxDr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so3024676b3a.2;
        Sat, 23 Aug 2025 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755973973; x=1756578773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrLGxP0FzW5aC42LhHQgFuaQh+ylY+xDXgAsW+i3YgY=;
        b=QPrSFxDrchrUrXNV+iToap0zAtcyALoHplvXF+ydPBxfdIYW61texcH52MeYex6EfQ
         BNLODenXXKwV33GOTdupVdAtBWlTHvwYL4AncV4ab/7vvaPXQRLmKkceiE6OFiz2WOEB
         1RLlPl/n97a+tpWXbBxi6kMsOJxk4nP/difxjSZHgnoPTSSdYrawAgl6rP9VwhfFdhDb
         rjjtp3OxYfoFH1ek+7nELscpZhiDoMFaczaVCn+MgWxTfQ/1G2xMJBBNUJuwH33gtwJd
         jD39u7KAx9ghSGXU+yox5a30I4SbrOhcVWuwMKfwxv0b1Pat5XNkcNqyOU4oGmhQKs/Z
         ryAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755973973; x=1756578773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrLGxP0FzW5aC42LhHQgFuaQh+ylY+xDXgAsW+i3YgY=;
        b=KMMRscsbaE7YsKhF6duoq+Ro4XrU0N9V6sjxDt0aK2fUa1byMWj6dqStdj5H4KdcA4
         1icyYM9qJiwpOnJsGMeL79GJpX9BcNZ5q86b6VgH4UNIq1qHW3N6XuXkY8LaJHLX/fAa
         ipN5Ya5X6KE0J0Z5aQ2cRdY93lcKYGvjAzHKNTMKMECY4fNDtGZSA9h62fEdj9v6qCBI
         mbBG6a7SduO+/etrDVcS0va3hKUdb+e/oWI/t6qIO5eqSQVq71Nde0B27ZUcpCBugnv7
         4xQORpsyK5H0UHEAizN8zhn61K0K0e2FEhMzgU4GOrYbuc6V1Esl8auIfWCHIa9LwzG4
         ZDyA==
X-Forwarded-Encrypted: i=1; AJvYcCUjuQoBMDhQW5X4f13wYqGpW7AzOpAqR3Q7zeoUkGekPeE4ZwMSLt8Jfnj5ercBJ8vr1w4GqMK+qc2igi4=@vger.kernel.org, AJvYcCVfr+2soJoSq4F5jrT07oWhvgo1PUuJukEU1o7LTdzAMPxLlebgNbnXayc3asBlC+ooQ8aA+jxj@vger.kernel.org
X-Gm-Message-State: AOJu0YypIs+Axe9tQZSXaBPYy4fWUCCwIKInCpaqSt3c9YmLFa/X0MaC
	v54HUN5UdV+QI8UmC45MrSu8sApiyomcyZgPaqaYRhptR7DZMBlyZjnR
X-Gm-Gg: ASbGncufsb106eBBWc8xBUosuee/SFIiKKgrSHKJOZk7iYDDWonD4oDXLI7Nsrq9pu/
	rLAQAxSH4JnM6/Vab2QL5RXP5xM2cGLvk4uLX3voDqOM9f1KNZEwRHj1ANig291NfJtRxExr4K4
	md/s5V9NrTcCEHtgAHl7LoYR4XmGEKzrwhoUfgVVFPfEd1xB8hsojbw4f/YSGaWHvW751xFt5X+
	kvAd0roYLiwlvdGcwbUeuQGmF+ZUk39axjizdHV0vWBUSbrlmCWiYCOZtWsuodIuWUdL3GEZ03i
	ihccs1h+E3X0OsfzJJFSZUR6wQrixqOxXYCCUNd+q1ycXKPFEerqviJZ+2JchsbmE6hCCsuOsFr
	qNqRliKpW6jkO+Gh6L7mKCam6h7A+BdObnwBszlr4YZvYeOsRk0LkTQ4w
X-Google-Smtp-Source: AGHT+IFwWxk1s5YPhKGw33Kfe7fIVavSzsVWVgqRR+0TmOEr9GPrBuseBdyx6V1CG+iTzHNCpnk1eQ==
X-Received: by 2002:a05:6a00:a02:b0:76e:987b:1dc with SMTP id d2e1a72fcca58-7702f9f5b6emr9585603b3a.12.1755973972577;
        Sat, 23 Aug 2025 11:32:52 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704ff442a8sm1133029b3a.32.2025.08.23.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 11:32:52 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: dlink: fix multicast stats being counted incorrectly
Date: Sun, 24 Aug 2025 03:29:24 +0900
Message-ID: <20250823182927.6063-3-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`McstFramesRcvdOk` counts the number of received multicast packets, and
it reports the value correctly.

However, reading `McstFramesRcvdOk` clears the register to zero. As a
result, the driver was reporting only the packets since the last read,
instead of the accumulated total.

Fix this by updating the multicast statistics accumulatively instaed of
instantaneously.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250821114254.3384-1-yyyynoom@gmail.com/
v2: https://lore.kernel.org/netdev/20250822120246.243898-2-yyyynoom@gmail.com/
- Change subject `net-next` to `net`.
- Add `Fixes:` tag.
v3:
- Correct commit reference in `Fixes:` tag.
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index cc60ee454bf9..6bbf6e5584e5 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1099,7 +1099,7 @@ get_stats (struct net_device *dev)
 	dev->stats.rx_bytes += dr32(OctetRcvOk);
 	dev->stats.tx_bytes += dr32(OctetXmtOk);
 
-	dev->stats.multicast = dr32(McstFramesRcvdOk);
+	dev->stats.multicast += dr32(McstFramesRcvdOk);
 	dev->stats.collisions += dr32(SingleColFrames)
 			     +  dr32(MultiColFrames);
 
-- 
2.50.1


