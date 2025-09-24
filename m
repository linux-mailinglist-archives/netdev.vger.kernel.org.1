Return-Path: <netdev+bounces-225976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3FCB9A16A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60590324D81
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605D30595A;
	Wed, 24 Sep 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkxO9eUm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1687305949
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721450; cv=none; b=C1iqg0D2UY+Sjg266pMjaU0kBOaTOJzOJ4LJeRI6tdP9hqErP6F21HQ60iRtsAf4IuebRPB8v1v+3UNs8JjhM1jzRl7q0Hs2fBC6agTD6la7vCyW/KDNKhFi7Hu7FppOFPdB7gkDID69o5si0MwI72abHeuSmVJ2lRKST8wPbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721450; c=relaxed/simple;
	bh=4wLHZd33H8ehWtqgfz/soUMTx6YkXPchLkux0RhTQvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKjIbpWOPWuecaqmwdcHv/FEVvxrMLrHO717ziVoa/GvJOmhrHZNaZYu3KEDi43D3JGmKupQDLbDiDCLLLMQy4UXqffASqh1FSaNbSJxaEHxS9IHkXCQIapkqra+sInZjvRHMuUuOre1pqBZ5vUgixGfH+sFZv0ePCQb53VOzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkxO9eUm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f358c7b8fso751031b3a.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758721448; x=1759326248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4ERu7wVLsz3ac7e7KRVwhrDHIHWN9PyFzkY9Sy5iLE=;
        b=kkxO9eUm2Ku2Qjpp8lbdcYaAvBnJIGyLS9CDBI7UA7+uOg0z3ro/1pVjObvJPpQ50r
         D5MwIV1FJaP8A03X+KdEksfQdr+jS24wSqKTw/yoaUc/WXFxG7tMnfSTfgYkSO8JQC+W
         ACKJMKomxTnx2mHCvGeTF2x4txyI+gllDSvZKN+bea1LHf/RKjLeGeWVn0+eifiH5ePK
         Z+CHBIJk3aSJEQUpC6rLrh4qXQ5etSErvpiRGfW94e1aMAcZUSUIlD0WAIKUd6xxxZU0
         I1chd7MmgkmvAceYl2pO3pQFC+DnAfncgDvWREXUwpGbX/7Ttu14lvp/0xoXRCstZzPm
         O/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758721448; x=1759326248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4ERu7wVLsz3ac7e7KRVwhrDHIHWN9PyFzkY9Sy5iLE=;
        b=XVYRr+0l8TJm2L82Kct0MRYf8j04t/nTHmDKV9hTinMPioU11GwYWfQOn8Gcu2521A
         qR+UEz10sdy94cHOTGSdhF9VX8dIMFTItf+dwTup8yENUgxh7PlorIrxH5wpHPBkB/bO
         20SsMgnfFWUmFaBvWQZ4R3tQm1HRemc+IPSyAaIKh0N7nMHJ2La7UouKRRH/M9xaVk/e
         acoWX+ERKNrNNYl7pNE/c2MUExdUy+r0corMdxBaO3gcl+mAc/DB5yONolyjYz810OxX
         0Mq28zap+LV3sLPuOsXbiZn4kyypQGHdH5zY1wlkbLQ4x2PwC7ZFoXxIisWo1SsdVCt4
         tScg==
X-Forwarded-Encrypted: i=1; AJvYcCV0wptKuhkEgu1GA9LD7AaSf9uRPoG+dE3sSSouMLt3f4UVZS44n6/1jPkw7DBtfBzFE/Qnm8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNqCk50/iODZfaovy4gjke3txD4kJYgeTAWxkLfVvTdIy+skB
	0GrhXPIK4Bu2nRcR7crEm7to5MIfFbGqJ0mVN3GTjLjejXRTRy9wuZv4
X-Gm-Gg: ASbGncsPFSpUxBm2x3GXkHVXfwJpi3rYu0EIcOX1eU34V2Pevghn+xUzk9RhuBP8P+L
	YliYXHbCGmGPXExvfegIS0KfH+kz25ywpLr25vOyPEzWRlPR2hJgHpghAVwqfNJQUaWEPSHubzn
	tqIRSUci7iw63faVaMP2eOx44zfEdkoJW45jhtRbv2vxh3eiYw4rRM0ZXihHnkFyqNhnOPsXU/y
	j/Gkld+84AdVsmy8StoPGNN2gEq7xRjXPMx7GyJuyYrlhXh4gDkItCFNbSfVNtvoDymPdu6UV8p
	sFkJRFylR9l0wSS8UQUwYN3DMrgB/1+eRVWQN/HKtJ0MNirq10WOs7vNFneW6angK1kcmwfdbjd
	HVAs/NFZm+31+1HTVPmg5zoZOyG/jXidJWTmA2JiC0fdAVqEs6mQzpaLZK3eochkel3NgVuVKTV
	vvtnNXqmkGNIPU
X-Google-Smtp-Source: AGHT+IE/4+SM58UU/wqTR/yIT31R0oJ4u37QZEN5c3JMJpyuvVeiCRq+ypyCOhvw3JyqJDdBS271KQ==
X-Received: by 2002:a17:90b:3fce:b0:32e:dcc6:cd3f with SMTP id 98e67ed59e1d1-3341bfeffbdmr2681721a91.14.1758721447987;
        Wed, 24 Sep 2025 06:44:07 -0700 (PDT)
Received: from debian.domain.name ([223.181.105.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be45620sm2486219a91.29.2025.09.24.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:44:06 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	michal.pecio@gmail.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	petkan@nucleusys.com,
	pabeni@redhat.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	I Viswanath <viswanathiyyappan@gmail.com>,
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
Date: Wed, 24 Sep 2025 19:13:50 +0530
Message-ID: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
This is the sequence of events that leads to the warning:

rtl8150_start_xmit() {
	netif_stop_queue();
	usb_submit_urb(dev->tx_urb);
}

rtl8150_set_multicast() {
	netif_stop_queue();
	netif_wake_queue();		<-- wakes up TX queue before URB is done
}

rtl8150_start_xmit() {
	netif_stop_queue();
	usb_submit_urb(dev->tx_urb);	<-- double submission
}

rtl8150_set_multicast being the ndo_set_rx_mode callback should not be 
calling netif_stop_queue and notif_start_queue as these handle 
TX queue synchronization.

The net core function dev_set_rx_mode handles the synchronization
for rtl8150_set_multicast making it safe to remove these locks.

Reported-and-tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
v1: 
Link: https://lore.kernel.org/netdev/20250920045059.48400-1-viswanathiyyappan@gmail.com/
 
v2:
- Add explanation why netif_stop_queue/netif_wake_queue can be safely removed
- Add the net prefix to the patch, designating it to the net tree
Link: https://lore.kernel.org/netdev/20250920181852.18164-1-viswanathiyyappan@gmail.com/
 
v3:
- Simplified the event sequence that lead to the warning
- Added Tested-by tag

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


