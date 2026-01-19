Return-Path: <netdev+bounces-250950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EDDD39C5D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 03:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AF6A3007DA5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631A2246774;
	Mon, 19 Jan 2026 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNSe2uln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B523717F
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768789693; cv=none; b=RscepuPrKFnKX225BcRjF3k3YAXcTMIf418MnT+p8LMyw2id5vpI+f5/RPEVsR8NQAEOlIWDkGaklN9Yumq2o3tQzEM+e9Zo7yb9uRaddxE31uJhW8MI2IRVMzhA2wZotIAm/DsK+W27P2NOOf7hyX5vpFbFF/BZmvDdtar4J1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768789693; c=relaxed/simple;
	bh=9w14KZHWbtXQ4bZuOIO1KWG6UqHqkSJxbWGAEo86CBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hVdAJYbrO/xZET/cXLfO+c88mVydYE+4Q/cSzz1VykCjyPjPo0Aab7ndt0BjJNy5N33FA2HLJneeXS0x3nyCUkUr8RrUnCq0YsxEV2H1R7azYek8QQJxLWmxFM9AqBI643VfphSJ90xK5OUngm4TsKbqDwiyXJeEGX6OqFNagmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNSe2uln; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so1829443a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 18:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768789691; x=1769394491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnggbONwgIdaiaOJGG3BcWc+1OF/p9b8lGQ6zKeztQI=;
        b=cNSe2ulnUI2AqIPHOnCV5vwsSAEslFP1jgPBUdVwwXIKxu5rsO9SATra8Sywu9P6hJ
         LdmBr2EFPJQp0rIRhyoaG9/LCzZfXdhBTS/3pzvAw/ideiyONMv3YpRqxQ/zWWA67uYN
         JfARbd1X67/Dt4BPT1H0hSGW9ldUReuW7WYHCW6uSU2bw1BjW2iPN/Aj/ynU91kyxGx3
         Bh9o09zZjNQyh2/reH7oFrThXgxg+9w/jTLecmnDGMbWRR/JRdmMiG7l/IV1MfQ/a9yg
         DK6ukjCx1ygUjndNX2b6tcpR3/RmQnBdsyW09y0LkV/UKoFSiZ4qK3FpVpK4PKhKuLlD
         plOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768789691; x=1769394491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnggbONwgIdaiaOJGG3BcWc+1OF/p9b8lGQ6zKeztQI=;
        b=V4a1QU22sSwyqOqDnzEaLXheG35ZVtjKsffxeBinNoHvyzKvaF64oa23DuyoXUhkpZ
         mCRiWWifq72FCt96oxYzv2iHk7ctDpTRQ2758hzE12fIBGLiMrvv9mH0LYwAjvt6nt+F
         4DsSj6YRYH3T2l/6igXFIUGQOe1Wt2LC1w80u76g/8VWtW94XzqJJKEMy11wRfs4GGkc
         Xlum6jlcC2LGiGqO00sk9F2OlZvHbph89UJydUu9N7kGFbQ5cL9ktNTONBlmvR8zx+5B
         degCcabHsExhjy5EztWeStxQpJomSHQo8hHoU/gyAPHT9cH3i5CFYsgLFUUgysZQJJrb
         5gVw==
X-Forwarded-Encrypted: i=1; AJvYcCVlxnfnshsa3xHKYxvuxZh9/dPOId92/D7obL9oStcPzqe8RPRLyVuZf4eXfS+/Ycd+MFlerao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wZry1X/xZxOWIKxq/ZtWKDpWC62QyVmonLgdJqhk1JYRepvt
	p1yj/hmfj9uM7Afh94wIUnDdPwm5hqaUU+WWan65usuHEmxrIVsYnxpV
X-Gm-Gg: AY/fxX5d0pdQmHs+dHcOv4ws3LXeP3jUmyQahjOVjje0lX4rlOYizvSxuhgravVC8Gs
	+2O80btkNRmzMgnfUWd7/15lCOVLbgsxYFvf6PO8NN0ATN6ebN7R6dW9wi1q/2yM6vfR94P3mBz
	6J9lXCONyZ7HWOao1BdEygFSXy7em6ncG+5NkzPBVCSCloxZ0UJKLbTZSF7m1ZzEB0bYskvpY4h
	Pgybp8LyFrxVkdAExRLGE5BDuUX0Tr4OTEsXULXXjT+SF+VKBJ/2ew4v9q/eoYG0zGDJzeSIY3l
	e2z1yHQmQ3J874nYhK9Dp7bTOuyUMjMAsAp8Xxtiyej/hy4ZW0NtVrQMMu9xOH4XM/k1RFwk/es
	2IscjzhXyA9ZIZ8HKd18xLqnk31NTFB972X11GSlAJgTdaMN1g3Eb4z6SbcMFzB2arQ0MK1CVyR
	S5MDsZdHJ63VIWPnMA
X-Received: by 2002:a17:90b:5245:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-3527315bad7mr7512269a91.1.1768789691050;
        Sun, 18 Jan 2026 18:28:11 -0800 (PST)
Received: from insyelu ([39.144.137.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35273277f68sm3811876a91.0.2026.01.18.18.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 18:28:10 -0800 (PST)
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
Subject: [PATCH v2] net: usb: r8152: fix transmit queue timeout
Date: Mon, 19 Jan 2026 10:28:02 +0800
Message-Id: <20260119022802.3705-1-insyelu@gmail.com>
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

This patch updates the trans_start timestamp of the transmit queue
on every asynchronous USB URB submission along the transmit path,
ensuring that the network watchdog accurately reflects ongoing
transmission activity.

Signed-off-by: insyelu <insyelu@gmail.com>
---
v2: Update the transmit timestamp when submitting the USB URB.
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index fa5192583860..880b59ed5422 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2449,6 +2449,8 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 	ret = usb_submit_urb(agg->urb, GFP_ATOMIC);
 	if (ret < 0)
 		usb_autopm_put_interface_async(tp->intf);
+	else
+		netif_trans_update(tp->netdev);
 
 out_tx_fill:
 	return ret;
-- 
2.34.1


