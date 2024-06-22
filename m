Return-Path: <netdev+bounces-105849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C462F913261
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 08:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4856828463D
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0614F1E2;
	Sat, 22 Jun 2024 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCymJnQr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290394404;
	Sat, 22 Jun 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719037959; cv=none; b=D8WXYCdZSOQPg3iBqVzBB8kTFoUEYGD9QDgsXvXMKr8eFGQ7npqJtKf/jkHLEAGi74C2go+R2P5ALkiGUf4dcOS0crFs8Y2ldnPPbXlNMPXYkCV3ojLteCxzvsTNq72UN79pyRBlaaJU5FadQmvHD2Scfz6D4QeS3gvbj18E8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719037959; c=relaxed/simple;
	bh=WhhOjISMX6FaMTZ2rpNPX0Ax73MYVU1F2jgo3t9NhwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J8Xryssp4A41U6h/Qb9mzpqsti/a2H/jxTLnCUh3WyIZdEN0D+hEXhQ7XIYGcdVIGJkS2ga/ZBccZVMjUOiYwXvdfc+H4eGdaVPE65ee8/XK+Xj7SrDuAt+qThX9/yNC1gdrOtMNrH6cDN6HuQHHbKLA5ITJDc0QvRNsuRJW0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCymJnQr; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1f44b5b9de6so21729065ad.3;
        Fri, 21 Jun 2024 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719037957; x=1719642757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEQGfHR4HYL/Iimx2BXnVEllHb07wSwW3ytxUBhGSM0=;
        b=BCymJnQrg11zYTPAGQkR+GpB7fodwXc4EpcHQjwKOUtW+1qBwuy5Aqx7oXTM59/7rU
         vLd7kO0oregyl8X5dOipGVH92j+U9TqmUrEYiJfy6POHCi89YOdkjZRv7NLWgTVzUm24
         OyDMdTGUxXYoISzQPSAnf2vAqr102kZybjrEq4DiJGgHvrJRexB8JO6mlxHusFu0q+9C
         npXC9t7RWI8BOckNeaMNoirA/Zi2m+H4PznwWhI6BsB6/sNAaRU3u+q0Jpst1CeM3Y9/
         lkFT0G+Odok257zo3xFZHCvgn12htcZOiAo4gubHK+34roCwIfUs8yeJrkt0mX9wSIdl
         nSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719037957; x=1719642757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEQGfHR4HYL/Iimx2BXnVEllHb07wSwW3ytxUBhGSM0=;
        b=xU3NOyP5oAlvS633a8Exxm9zN/E13X5fs9XmymcOTeSygKOjawr0xbC8pIo46QqG1I
         snrIK0h0qQLWyQIF/KjJ98aRTiCKYcGZ/185kSegJYeMUXiOwuGwh0wBZLThVzfKX1m/
         OCV/fRYQ11vBMH0HQcrezvRc6MV7M6VE5VI+uBq+R7G0rCbiMOFNWWjy/MATTLpb1NQe
         OfOTnIZFG+npBk7q3EwW1eIXaP5orC7MiseQucx9JuMtKG3KsOxrcSQ0r78eljHtmP4y
         M1V0fB276YG4jlCCQ8n/C6iwiWw+fABWWtrgl9369dDvbFjY/2Djy358YXyEF3dDe2Af
         H47Q==
X-Forwarded-Encrypted: i=1; AJvYcCXF0X7xcXLWB7IlkoUvaN7l1S5IlSpTO9gXg7so/YSCVqQ9m3xODsUwjC64g+Wu7AMqJnSgImcBkzMx2iuOQk47SIsLKex+PztF9WExVw+tXIojc/l8pDD4cnfIBMcVAEOuu4MO
X-Gm-Message-State: AOJu0Yy4uwqlmw+/IzHdz0D0d2f7YSEof9aFVQs/qXV3bPlKm7E6zMWB
	utljjQ7Wu2Iw+DVF+1GUmieQOHeraNtEYFYgupQQGmvkKuveAJ20
X-Google-Smtp-Source: AGHT+IFcm99hDFPgJkVVz14D7/+Vz2Ow06iag6fcS3AghgArZs5gm6LbKjJ4/JgYQ3WTs2yWFOYDvA==
X-Received: by 2002:a17:903:1c3:b0:1f7:2d45:2f1 with SMTP id d9443c01a7336-1fa158de5bcmr2068335ad.15.1719037957242;
        Fri, 21 Jun 2024 23:32:37 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5a87sm24068085ad.203.2024.06.21.23.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 23:32:36 -0700 (PDT)
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
Subject: [PATCH V3] hippi: fix possible buffer overflow caused by bad DMA value in rr_start_xmit()
Date: Sat, 22 Jun 2024 14:32:27 +0800
Message-Id: <20240622063227.456107-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value rrpriv->info->tx_ctrl is stored in DMA memory, and it is
assigned to txctrl, so txctrl->pi can be modified at any time by malicious
hardware. Becausetxctrl->pi is assigned to index, buffer overflow may
occur when the code "rrpriv->tx_skbuff[index]" is executed.

To address this issue, the index should be checked.

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


