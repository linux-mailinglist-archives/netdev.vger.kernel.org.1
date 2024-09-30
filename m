Return-Path: <netdev+bounces-130597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0831298AE3D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B296282733
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41911A2C29;
	Mon, 30 Sep 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7dZgwMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3E1A264B;
	Mon, 30 Sep 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727882; cv=none; b=X25FvtlLs9Oa2Im3yUqK8UrvMKuDJdvSMiv8x60+zs9wp+yRjMjxOREPHxIRibo0NDrSJZGtJ1MRf1cUuw9PQinfwVjRuA8ZQgTeYCT3jXoV5QkZXq8kg1jrlonTBMScG8pxWlsQPBETbvBOdlYCD9Q6Ka7ufrSKEGeINNnnw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727882; c=relaxed/simple;
	bh=XMZZXO5l6NipfKIdLr6cm7zLTJYjdhmkvhZ5r/61hts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2ekqyRy0/K33dNp8SIFqRET4MY/MKwAHd2UEfZIajh48XCpn4MHwtL7ecuFr87AKGVcqFHAB2zVAJx0x+UfxIZAWkc1Jgzy7LWNtvKYJeazXBMx8PiyNQCIbxo3XG7SiRmrz3+kszNhAfU2AAIPSKWq6icYWnbj2Qmr/dSaLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7dZgwMk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71b0d9535c0so3343564b3a.2;
        Mon, 30 Sep 2024 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727880; x=1728332680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz281jisbQJ7kmb0zJYVwza4XnRAymVyKYSwGboTVyY=;
        b=j7dZgwMkToubQqm+SjEMvzSaDGzW7FFGpnoj+P9A1YnSWLs0r7RFeCGRQSe/6ylBLe
         gTZDdqIzwMCJyDI8O9okLuZNyPmxMcRM4RfcpfYCs4kSUl8YSIozOzsgxfX1Jn3/Lfo7
         0/3wRsv+TpitSxUh/rfqGsAOi8/KcUU1VCjAE6h0X7nRIDO7k6oIkbXBpdP7O1gqXAkJ
         QD/QuMkRxOG/4Ued/zgj5PRSeSCMLciTr8AZY5xXmy6Dqn5zI7LdNjXqhRa9ELkvM5iy
         QRfwhDZE52Co8HfBB0aAPJKIE1N+o2uNzxDjL9IrKDmH/5lzdAbZ1ruypW6GOd82k64L
         kjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727880; x=1728332680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz281jisbQJ7kmb0zJYVwza4XnRAymVyKYSwGboTVyY=;
        b=B/+5ZzsBV7qCbpoYmLGpBTUeC18H9r5qlntjxQ+iQry6s8WYPmD1FKwQoWykWort3l
         5duW10cybA0hqmybs4reNbu08TC4QcUQ0/RKYTHEdk3iTybgZwunb2npQLZy001U3vdW
         ozgLASEHF2Z5uTlV9cyjGwwy/pUPeJwb3NdL/NlyxZuTvjJNjA91xLUcogADiSX7DF2h
         9YELki31DE+B+YXwx+zXUb3HIQ5GRY/dcMEfqH3srx2h6lEZ5NEMihMUFUXi6F1NBKcu
         XDxyqZTUmbce3JdBiqn41ks07LbjZsjeCkjRM8YmIj91smUHVYG+BfLXRSP14oLuc83R
         KClA==
X-Forwarded-Encrypted: i=1; AJvYcCW4OKcabe1laQDm+6Dxgyjot7SyaNmawSLxiHMdpToD22KMa/fHnujQi4lj/IIFkQ/5HBzbIcUMQ7ifzyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmttayKCZfxvbWV7BbcNpAFve0AqTQmDHVQqGt5FDo7/9CpSB
	pTgeQuy8/qAIHjArtUCMhqmVxQ5MA9pCmMXnrljh673Swzgc2ZeZ+9Qm7FiR
X-Google-Smtp-Source: AGHT+IE1qXS4vBd4sepWW0WI4ZrL+y9d7GGuSnH12YEE4QQIVCXGZfHd8YCBRVODg3PZTVcoEPxeww==
X-Received: by 2002:a05:6a20:e617:b0:1d4:eb96:8685 with SMTP id adf61e73a8af0-1d4fa815edcmr18935506637.45.1727727880367;
        Mon, 30 Sep 2024 13:24:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCH net-next 3/9] net: lantiq_etop: use devm for register_netdev
Date: Mon, 30 Sep 2024 13:24:28 -0700
Message-ID: <20240930202434.296960-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the last to be created and so must be the first to be freed.
Simpler to avoid by using devm.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index de4f75ce8d9d..988f204fd89c 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -587,7 +587,7 @@ ltq_etop_init(struct net_device *dev)
 
 	err = ltq_etop_set_mac_address(dev, &mac);
 	if (err)
-		goto err_netdev;
+		goto err_hw;
 
 	/* Set addr_assign_type here, ltq_etop_set_mac_address would reset it. */
 	if (random_mac)
@@ -596,11 +596,9 @@ ltq_etop_init(struct net_device *dev)
 	ltq_etop_set_multicast_list(dev);
 	err = ltq_etop_mdio_init(dev);
 	if (err)
-		goto err_netdev;
+		goto err_hw;
 	return 0;
 
-err_netdev:
-	unregister_netdev(dev);
 err_hw:
 	ltq_etop_hw_exit(dev);
 	return err;
@@ -709,7 +707,7 @@ ltq_etop_probe(struct platform_device *pdev)
 		priv->ch[i].netdev = dev;
 	}
 
-	err = register_netdev(dev);
+	err = devm_register_netdev(&pdev->dev, dev);
 	if (err)
 		goto err_out;
 
@@ -728,7 +726,6 @@ static void ltq_etop_remove(struct platform_device *pdev)
 		netif_tx_stop_all_queues(dev);
 		ltq_etop_hw_exit(dev);
 		ltq_etop_mdio_cleanup(dev);
-		unregister_netdev(dev);
 	}
 }
 
-- 
2.46.2


