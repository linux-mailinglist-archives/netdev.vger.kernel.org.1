Return-Path: <netdev+bounces-106376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE57916072
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991F3282005
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B6146D55;
	Tue, 25 Jun 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV7jORiI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F2146A65;
	Tue, 25 Jun 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302006; cv=none; b=SdKDoFFuCNxVIVM6jf0ywn8r/GCkKxtBG8fR3JLeA77e4i1kXzU9wLTdlMEo4O/hoJxZYT4bYPDZv46qlDdZSnMUMFiudOJMe8In1mKZtfI+DqFw6kAMP5nWteEivr9GgX/Mnq/Hus1Cf6E8Cvw6o36y0ambcVti8feMBxLxAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302006; c=relaxed/simple;
	bh=eBY/yARdJcCgwnQprJFJOH4UawzWgnBCScJFZ+cnz3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dA7qFQyFjH0t0qYEQD/8Bkp9q5jpEuqlt38KPxrJelq3EmCq/0kt/uZBHh7IjWd0TEgk2ypglrWmJLI4tP7i9AkMfeXiaTNDic/qIm/jEm9UhvD6mvhpSg1jp+/Opw6bQ+vxpVevhNFUdzb7+/Jjn89mT3VEWBxVc2CFTFP95/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV7jORiI; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-70df213542bso3710680a12.3;
        Tue, 25 Jun 2024 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719302004; x=1719906804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBkxOAotth2MCXMq1/ur8mR4OnbLwiPMMCFj74zqI34=;
        b=CV7jORiIbE1nTSWCPoZKxBB99VgHR6iwV2EGHXU6zyyyGKV1cgpW6bjdOsqxXJpM+e
         7Rbd44OLJ/HW4o3gbjXIjAjJfYXo4RYILb21zrNtEkNrOvRMOGkhzrDYo2kQKZMaeiXZ
         8ON/L4TCdc/6Q79IL22WV1SFhXWQQ706f/UkOCHE+l0EA1jrd36SM0xLAEFCWCNxXJQG
         ATWWXvswxc++WB1uAFeUyFi+0vJ3YbL6rAsfzihkZuIMtmD1vzrvIzxsTgQ0YBkXPZEq
         ncc+5vpfTCiB0D4ZrpVd3SDxLR7uytachcih3q93Omd7m9h1oTBJW++2qfPK89xyxVs+
         9fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302004; x=1719906804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBkxOAotth2MCXMq1/ur8mR4OnbLwiPMMCFj74zqI34=;
        b=DzBkJdVWuMgW8RxVwPT+LHzHnoY4pTsmuRV3OxOrwx0Rcuw5cVaydp0SpDZaNuoLjQ
         DfHwHbnjPhp7I6R9eJx43J5i7+iChR51PS0z128zymxFBCDSvaWRKqBpUDv2eXSYlEP1
         UGdX7QNyIVXC32P0w4s8XX5l7u2qZtDE3J6N/ZLTn69ip2UHMpZiSywGvJhFCAvLVpdr
         rc3awwtaY7Fg2F0A40oPolIM81kOyPzQEV0KV42lifvwQ+QGmDDF2igwvIe3Uim2Lgmn
         J5p7LXJvIzQ1Z0m7nrdALzrOOt7Wigk+7UQVZkraGJGqM6RoljlU+0Y8BmGfoz/8sAoe
         NtGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO4DA1Rgz8DQ1EpVW7PZl7tZMumfQKj6/edcaxas1ehVHo5y39/2gn0GbUBf/WEa2vY9kGtTEk4VRNwWanZf+dEZWxnJlsN7y+yVZwFJAqHSkbRhurv5+50QHPMump7J6t2OiG
X-Gm-Message-State: AOJu0YyU3zmvzh2ZU3AbQRzPJfJNeqtvWhOp/uph//Taw8nNQJWo1K4z
	MMti3lcEa2BZO7OqGeWUqwMK5QCdipT13sw+ad+2/DKomWQ0+Cou
X-Google-Smtp-Source: AGHT+IHCvXX7eSnKUt2ZP+Ua7TrW3neCoGQg6w3kvEbjL72tm1/MBAF6A65+lFY04pxb1a96jbFRXg==
X-Received: by 2002:a05:6a20:96c3:b0:1bc:ba48:15ae with SMTP id adf61e73a8af0-1bcf7ffa863mr5277637637.58.1719302003902;
        Tue, 25 Jun 2024 00:53:23 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc3185sm74558055ad.289.2024.06.25.00.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:53:23 -0700 (PDT)
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
Subject: [PATCH V4] hippi: fix possible buffer overflow caused by bad DMA value in rr_start_xmit()
Date: Tue, 25 Jun 2024 15:53:14 +0800
Message-Id: <20240625075314.462593-1-qq810974084@gmail.com>
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


