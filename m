Return-Path: <netdev+bounces-106375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5091606A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD6E28235F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC8146A69;
	Tue, 25 Jun 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd2jvId5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F52572;
	Tue, 25 Jun 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301951; cv=none; b=iFLJaAW+5GadYwUqo+/5ELTlGALQ5Umi+6mzl+saTAgj3PiMnx7Zge5Y8gt9XVePSQIw4IpnoZzhawVy90Aq0Zcuce/KIPwFnb0vm35fjGQKczyOUW3tMAaPoJu4aInEOgMkLqHYMm96QJc2FFo4VrR1TDsHhZsrSBCxJ3vIr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301951; c=relaxed/simple;
	bh=eBY/yARdJcCgwnQprJFJOH4UawzWgnBCScJFZ+cnz3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cp6gg4jJAqQGCLhCxTxUIdUiq/iDuwviIPzfhUbrUQGmoZrF2vUH5/QFxXYAjMYBv0lmyP4zZLVtbd8aUpDv5GfNSvQ+Kq9yV86ur9Ph39hTLj2YC4H30rIiMh6E1mZsqsa3dty3bD998AIB7wZaWWgp9lTrc36GkQsKj3+DY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd2jvId5; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso3980909a91.2;
        Tue, 25 Jun 2024 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719301949; x=1719906749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBkxOAotth2MCXMq1/ur8mR4OnbLwiPMMCFj74zqI34=;
        b=Jd2jvId5/9ysUZjwScStL1riKlgup9JZqUB+hk1n/fbL6lmII24PU4F2lrwvSGtiIc
         4fVBDp9oqout4zFWtMifkn4Vf5nm7YVtY5laIxXKerimFLvfwu2Xwb1yNfUbGi5MNfB3
         UHjlB08SKATZehxRtXPQo2wIBoXAutiE14SfwaYpJ3rzCM9zejpGQLiLGjfKN7+TEo7O
         0RJMJQWhNLn+fvrzLPWpJMHfSAHlKE497P8PAGJCU33s+psLM8SNj14XDXbPfUE7/n8N
         CnyX3OYmLIHIeJ3WBhFyjJjmmrQYSRROHld+8B3dTIEEyEe4N48uixQKf8wyJ/rT5p86
         0/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301949; x=1719906749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBkxOAotth2MCXMq1/ur8mR4OnbLwiPMMCFj74zqI34=;
        b=Buxs0ZMydzw+G/SA0oJo5OgELdO897hwczQP+x/KA+0kk1VgI1Hs0sxeXGywtV2wRv
         YTU02w8DxJ3uO4XG5l5FUvwJoPrht/5TE03h2r/xN4nOl4z4GBjqfoJk7OjWUULQ7N02
         aetSMS6yWaR238VEULUCQiVDYbuddmKan8Ln2P6AivPsPc5bm2sbD10QlJR9ppo2VALi
         n47VGjGrh2ZXKorSRbGgo4m4UvvHo7NcOtfZPtO+B9du6zeMUg1MinRW5J09biH2avMc
         /WZEdFGImV4TL4s8SKkRTa09eiARVawgUL2CH/1KNa/ZhslCGrrsUjqefdHUKW4j/l9C
         EF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2VAmk2qHnXr0xRjD8vgWyNnbIxD6h4pUHXT9nYZ4fbG64thKnV+kPWeilgYd1pg4tIaZ6oi1U5SxQmBXXOiSPlX6g0Sf4+8C4umU9fBPzsLAIoJ+KOs82lEqPX5hSe3TfxsNW
X-Gm-Message-State: AOJu0YxtjJ15VeLUgPTZd8OdMYQCV7RMs2sEPCkh/peLMISPlG85mfMx
	MTceLNnyYbzskqzbih+88BlBY1dUHpIjZGMKgZdwmaAic/LqJGuWSvMqN49noUM=
X-Google-Smtp-Source: AGHT+IEByefc31TOGJcvGD0eNAvZC86/RCkPMZ+OcfMQY6XhsHZwdZcng0lPgh6llqsUUKSl2YEunw==
X-Received: by 2002:a17:90b:e97:b0:2c7:b80f:75f2 with SMTP id 98e67ed59e1d1-2c86126b738mr6182115a91.23.1719301949323;
        Tue, 25 Jun 2024 00:52:29 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dcf12esm7927978a91.49.2024.06.25.00.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:52:28 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: jes@trained-monkey.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hippi@sunsite.dk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH] hippi: fix possible buffer overflow caused by bad DMA value in rr_start_xmit()
Date: Tue, 25 Jun 2024 15:52:14 +0800
Message-Id: <20240625075214.462363-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value rrpriv->info->tx_ctrl is stored in DMA memory, and assigned to
txctrl. However, txctrl->pi can be modified by malicious hardware at any
time. Because txctrl->pi is assigned to index, buffer overflow may
occur when the code "rrpriv->tx_skbuff[index]" is executed.

To address this issue, ensure index is checked.

Fixes: f33a7251c825 ("hippi: switch from 'pci_' to 'dma_' API")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
V2:
* In patch V2, we remove the first condition in if statement and use
  netdev_err() instead of printk().
  Thanks Paolo Abeni for helpful advice.
V3:
* In patch V3, we stop the queue before return BUSY.
  Thanks to Jakub Kicinski for his advice.
V4:
* In patch V4, we revise the wording in the description.
  Thanks to Markus Elfring for pointing this out.
---
 drivers/net/hippi/rrunner.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index aa8f828a0ae7..f4da342dd5cc 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1440,6 +1440,12 @@ static netdev_tx_t rr_start_xmit(struct sk_buff *skb,
 	txctrl = &rrpriv->info->tx_ctrl;
 
 	index = txctrl->pi;
+	if (index >= TX_RING_ENTRIES) {
+		netdev_err(dev, "invalid index value %02x\n", index);
+		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&rrpriv->lock, flags);
+		return NETDEV_TX_BUSY;
+	}
 
 	rrpriv->tx_skbuff[index] = skb;
 	set_rraddr(&rrpriv->tx_ring[index].addr,
-- 
2.34.1


