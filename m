Return-Path: <netdev+bounces-224958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CBBB8BF69
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 06:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F045C5859DC
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 04:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473922A7E6;
	Sat, 20 Sep 2025 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlqidWoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96ED4A21
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758343925; cv=none; b=VtiRN3G5Fhq0wWkKHMT1PRsSXWj6UcY4oDmwONkmj2YP5VmpFzg1jOh4AKshlAK6+wuCt5MV391rq9lq8hLzhqlstATZ3AJePQZUaSrW1ajK1iaRFJozVLqpIOvHR7dB1iR4FFswZu9LfmwqovtHo0E7h8zjmI0ClahYLoe3YPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758343925; c=relaxed/simple;
	bh=WN7syAcJjhlULwaP/4Xo2Ytf7vzgMmwSdXXWwuslg+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agF3GEjNOzhzmPY+OxVLHVzPoZouA1F7T5YAhnEiZHZXFiAYDOnJCvdp1suhK4bf8LmtHXewhDzkKGpN5Ts5w+SVQyaS/fI/nHo/vA37b025uJhSVv/MjltGwL0DXCjUS8LbvNQsPebzJZM1xvK3F7Px15NC/Y4wVmDyqch6qdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlqidWoJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26f0c5455e2so4021055ad.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 21:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758343922; x=1758948722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Scl7/ytKRP3iThro/p3ZtlDfxCKkscpWY86iDRO/ZlI=;
        b=ZlqidWoJxcuGcXuL+gL3esrYW5tFo0na9AOpSXNtgWfb0Yg25iqsEb5Jq8piV6ETFl
         knxi66pdlQemc/VjpAd3oGfllBjxluoQ4Jt9Tm3UW6J4zV1ca3vxs8RLR9WPVvbAISw2
         ALJZ+7rhchg7gsH+iS5Rcd15JvwCWtFjqLiqBc8MwdKNAy+9r/utQCPP9qMmqgQQ0DFN
         FZiQqs6c/OCB89jpAgwHHdSw9al3/7v8Ul2pWHSsQGQMwzhIzrl48yk9mdE6NP7m/2Pw
         t+w98GteU2EQyblAd7QzeH8lr4F3xhelYpITYPPZv2gO1A3iWHGQ7Yp5bzJ1k2oisO6o
         xc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758343922; x=1758948722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Scl7/ytKRP3iThro/p3ZtlDfxCKkscpWY86iDRO/ZlI=;
        b=lNOrbccpWjWJtcknkmnm7W9qeUgvXK7ISL9kMf+GvqxWEbTGx+ozTU2W6rKVHHadf2
         pdaxD6WM+E6FuPj4Z1lQjUfvChqXIXrs+EMXDvq7LRYiFW9cGs08HItEYT9TJixkcVR5
         spvnMqwiZ9z1H2zmFsvcio41gnaaVZhl5SKAs7oyV5yVxACdCC3uP+sYjPwkCJn9O4up
         2s0Nmh88UQrHLfq3Dl9D1QpS3QFuK58PhNvsntz6pznT/nFsYbu8xXwgIvtbHqyh/ypn
         oRawvl2Zl4+ChcJzTHXj7dEnStkDpFfvnWr7TrMQun8/TEgM7bCjtI2U5WYqM0tik8we
         x21A==
X-Forwarded-Encrypted: i=1; AJvYcCUcRG90MqHh8fv4HKWhka7uwFx/5tLav71G6EdbRKPud/8fYURgyOQePCCpQutvfr7rGB5wSUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iFzel25GdzjvxREl5qUBN+VUXOEQs1oJeNolzH7ilM+51tSL
	B5exCHyArG/gRHCso7tSwcES36l2tTc36UVV0bo4vNRGUvrLw9O/DFUI
X-Gm-Gg: ASbGncvwaoZh3V+nR6DG1GSgQvEvNDhTxGjAZsoGohqaoJ5jX8ijt/nzcV1C8GoHR75
	7lNzlz3w5Xe+ay+Wx/KPr5hjiH0/OZTUKUT5aswYm1TKBfrLeKOpxUMIbWz5ewl9IJMr9A64BrR
	d8gByRkYMGIdaA4ig6xlbZLlxemTcc1SnIHQ5FiR45+fYxL+hyic1SAJSr0oERjktWwwlsh1tRo
	tcWGAGNwAoFGeohWDwHL3BeHEcGfsqEAcQ8oBhwiF3F2FdQx6RAsCDb7cMOyVFly2Ed61SwgbG/
	aWqJ+xhubS1VskSiwXmd2NDsWncH1D4EE+/HvAKXsNWErjKFZ/OZRJZamw/RT0NDz8DiIQz6jRA
	xJPImNBIKMzJDKPXJUZPQOQxa/hJQ5ohy398/3jZIWmfG1QkPz7Uy5YQTyIiXIyj1mnEuiN/ES3
	aJQBdNAe+FFleSJg==
X-Google-Smtp-Source: AGHT+IGlDL3meUrjWPh8XY00Z7lI+5NCXfWA95NkUgQ/36jV2EnYS75qSm19Zq3LWRDvSpHOtmoG2A==
X-Received: by 2002:a17:902:ec8b:b0:266:3813:27c3 with SMTP id d9443c01a7336-269ba441c40mr84447675ad.13.1758343921975;
        Fri, 19 Sep 2025 21:52:01 -0700 (PDT)
Received: from debian.domain.name ([223.185.130.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368fe3sm69258125ad.151.2025.09.19.21.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 21:52:01 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: petkan@nucleusys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	I Viswanath <viswanathiyyappan@gmail.com>,
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: [PATCH] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
Date: Sat, 20 Sep 2025 10:20:59 +0530
Message-ID: <20250920045059.48400-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
This is a possible sequence of events:

    CPU0 (in rtl8150_start_xmit)   CPU1 (in rtl8150_start_xmit)    CPU2 (in rtl8150_set_multicast)
    netif_stop_queue();
                                                                    netif_stop_queue();
    usb_submit_urb();
                                                                    netif_wake_queue();  <-- Wakes up TX queue before it's ready
                                    netif_stop_queue();
                                    usb_submit_urb();                                    <-- Warning
	freeing urb
	
Remove netif_wake_queue and corresponding netif_stop_queue in rtl8150_set_multicast to
prevent this sequence of events

Reported-and-tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
Relevant logs:
[   65.779651][ T5648] About to enter stop queue ffff88805061e000, eth4
[   65.779664][ T5648] After stop queue ffff88805061e000, eth4
[   65.780296][ T5648] net eth4: eth name:eth4 SUBMIT: tx_urb=ffff888023219000, status=0, transfer_buffer_length=60, dev=ffff88805061ed80, netdev=ffff88805061e000, skb=ffff88804f907b80
[   65.790962][  T760] About to enter stop queue ffff88805061e000, eth4
[   65.790978][  T760] After stop queue ffff88805061e000, eth4
[   65.791874][  T760] net eth4: We are inside Multicast dev:ffff88805061ed80, netdev:ffff88805061e000
[   65.793259][  T760] About to enter netif_wake_queue ffff88805061e000, eth4
[   65.793264][  T760] After netif_wake_queue ffff88805061e000, eth4
[   65.822319][ T5829] About to enter stop queue ffff88805061e000, eth4
[   65.823135][ T5829] After stop queue ffff88805061e000, eth4
[   65.823739][ T5829] net eth4: eth name:eth4 SUBMIT: tx_urb=ffff888023219000, status=-115, transfer_buffer_length=90, dev=ffff88805061ed80, netdev=ffff88805061e000, skb=ffff88804b5363c0

 drivers/net/usb/rtl8150.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index ddff6f19ff98..92add3daadbb 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -664,7 +664,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	u16 rx_creg = 0x9e;
 
-	netif_stop_queue(netdev);
 	if (netdev->flags & IFF_PROMISC) {
 		rx_creg |= 0x0001;
 		dev_info(&netdev->dev, "%s: promiscuous mode\n", netdev->name);
@@ -678,7 +677,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 		rx_creg &= 0x00fc;
 	}
 	async_set_registers(dev, RCR, sizeof(rx_creg), rx_creg);
-	netif_wake_queue(netdev);
 }
 
 static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
-- 
2.47.3


