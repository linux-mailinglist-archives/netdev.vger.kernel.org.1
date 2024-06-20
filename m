Return-Path: <netdev+bounces-105248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD69103E0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A23B225FF
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F8517C21A;
	Thu, 20 Jun 2024 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKvSNuFS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A14FC0C;
	Thu, 20 Jun 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886203; cv=none; b=AUfOI8wcnS8p09Kf+yDd82JZ1IIPdKTGrKme9WdZj5wGFtWmeib8JRSZp4jSH6g8lAJ4LqscmAX63uQmXCzpu71pj8GaShoBCN3HHk7PRs7OhP+s3f5U165qzx7hbtv6pHrDGOtSIiHq8L62PfTmORwSZWGsZP8zCT9OMVJilbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886203; c=relaxed/simple;
	bh=1m34kSCng+QMH73UT8NpRyVZiaxjG7pMPeqXTPrJAGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xc7ws3K01dilQ0tUeO/QBoPja4jj6oSDsBXgrE9U4WVmeEtMalgVxcuNav0N+5wGZigeXrLVSZRHW8yTyL6jH1r6CjG6yeKPBcJsnmuB4nqx1EvxL6V/Kw0Rq4IW7Wm4sjlMiWp0R/MYVUo4eNQNbWkL0avVwupkxPO3Wi1k9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKvSNuFS; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1f6a837e9a3so5523145ad.1;
        Thu, 20 Jun 2024 05:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718886201; x=1719491001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAPCa0MvFiAPsj7YHALM2ydyfWyLdEGMk4YW4r8hjMY=;
        b=TKvSNuFSEYG93NFweHAsRUlb7GXuFln+KZUIAfqcGTON99tBfhSLXNhBR5GnljE68o
         fnWz6LFfjN0+5kG7WLt+1lIoNniMLLdyC1QyhurY3dhCVSKtN5Rws1vhM9rn/sG51Xcv
         12dC6M3cJcp+PJIbsWR0nIMHZf79SozL+//wshrs4b8uMKf/T1bNyZZBVS4qfqnmnotB
         rfgBFFM/Z+j+8u4VAvmfsFuAU58W7QGXgL6Ijs4ytM1t/Um2iGW2tUMiDA1jgHG2RRXG
         CVkS9pnz5GeuF6jgrjTfsW41t52/hXmsiqtTOUOe5aM7n4u85nWxzGH/IXB1XWRnKBQ3
         2NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886201; x=1719491001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAPCa0MvFiAPsj7YHALM2ydyfWyLdEGMk4YW4r8hjMY=;
        b=C2KN+3skUud5iJ85G11HZbOoL0+3cA9a3DW4Hk6FUJW/97y2ijgjoNY7CF0cqDEPrN
         S/0O73E+6Y+bQQbWmyvnyfkU1JYSAoQ0DXRPdDnGbED7R9nIfv+9BtLW97PXDClKoo7u
         lQUAIEDC4pnBbxUqMpwqAy1+Y2tSgQ4cmT/kP7yc1zBaVeaBGgdwsuE87brL06+g5nwF
         Xz5gGZi77oTf2xq2pReNtHzqtr/2f/RGpmb0LvJhmY80OlgwPudBz2Pvzoo15olyuElo
         EtecKwow01oJNsO3DQu6sUmYvWihahuUp6IhsDRnenanSnlZOdQ5Nqn1Y9u/aauHhJHT
         LegQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaWmyPtBoagLQ9/kwAVEwPCUV0RIB00XWrnTKwP1XvINI2N7LjMyK/5rm3R48NNn9LxMsRk2/aS0LKah4ZGsVMMRAHh/gxqQV5VmObFS1YesKD6/S6PX2aIjoshkSlKoxsiNZ3
X-Gm-Message-State: AOJu0Yw1h7kPY2dJeTaDJZ6BTzaitozUsnmogmaY/d5LxTAGFkEf72E0
	CWHtAFlgP2d9LpjgCN2gUGl24LK5qao/scXv6LOOP46mKDnECqIs
X-Google-Smtp-Source: AGHT+IGbs8FFmVep1Hv/BZX9eKbKKpz0IFFRCOFjuUSzjm5eR9dX4BHr3DlLx8gsPJlwRZfm2n49+Q==
X-Received: by 2002:a17:902:b187:b0:1f6:1780:f7b1 with SMTP id d9443c01a7336-1f9aa3d23camr35948275ad.17.1718886201023;
        Thu, 20 Jun 2024 05:23:21 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e77sm136344235ad.12.2024.06.20.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:23:20 -0700 (PDT)
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
Subject: [PATCH V2] hippi: fix possible buffer overflow caused by bad DMA value in rr_start_xmit()
Date: Thu, 20 Jun 2024 20:23:11 +0800
Message-Id: <20240620122311.424811-1-qq810974084@gmail.com>
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
---
 drivers/net/hippi/rrunner.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index aa8f828a0ae7..6b0056ced922 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1440,6 +1440,11 @@ static netdev_tx_t rr_start_xmit(struct sk_buff *skb,
 	txctrl = &rrpriv->info->tx_ctrl;
 
 	index = txctrl->pi;
+	if (index >= TX_RING_ENTRIES) {
+		netdev_err(dev, "invalid index value %02x\n", index);
+		spin_unlock_irqrestore(&rrpriv->lock, flags);
+		return NETDEV_TX_BUSY;
+	}
 
 	rrpriv->tx_skbuff[index] = skb;
 	set_rraddr(&rrpriv->tx_ring[index].addr,
-- 
2.34.1


