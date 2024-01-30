Return-Path: <netdev+bounces-67326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7638842C9C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7637E28C0C2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09978B71;
	Tue, 30 Jan 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fr0FtgQW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7AA762CD
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642597; cv=none; b=eF7SGqXqP4CRfI+aWU4KmktrHkcsz0+qAScLi8ahT0k9HZNdVh0Dj2Ry+T2bV9SGQGoCXL7DyK12WBcpUgFany0WctEjRLoMuoCkQlPQf2I/NnjroR9+fETEiU1HaZoxJ06NsGbDqS42D7j40irYmo+VSGTE81hnN4nuk0ErxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642597; c=relaxed/simple;
	bh=+FFIhfz+wht4oy3l8eUjZbOK8wsGYZs+xBRBM4HyGT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArS+zU6OH+QYEVMCfVwxwvNnXQtonbYX02aHO5vZAigqvC6Pizp3sAOEdfva5jTAf3nd3kCYGQNsTLt5S3WHKS7Fa7lKRKtxk5fpfKEzqpscmKwm+8GtsWj66drzTUKv0BqJEByTYnc13mdN5Ii7R9tEWEEXyaf3PsVtPiHWBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fr0FtgQW; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36378ce9550so429365ab.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706642595; x=1707247395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFNwh/INCdzrt9jHygu6RrRsOD2iFwLpFavhX93NdeY=;
        b=fr0FtgQWDHEPW8kNK6BHjKKi8jzYClvXuitu2oed7ODxu+6te08K9O/PNLvPX8avOT
         1lRPMHojtqxP1sZewx1IJQDACkVYPyg5uPQHtF6IvWSv/70bY+Ts65481gA8ihYrh7Rj
         BJ49A68MshUHWGTfbgMKomgrADRMJyJuURl2VkLrNYHnQhehFtL2kP8LOkwB1UF9NdQB
         P7rhtTD9BKESjkj9EJUzgtfglqd/FhaVGU+ToUg3vc1+vooIH661kAf9AYXxB1b06VPC
         E8ypoepiUGcdJaDu5ojLwKD9QsSTfGWkp/vYpbv0DejYSF4nD5lZ4TTDCRkFh+S+20b0
         SV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642595; x=1707247395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFNwh/INCdzrt9jHygu6RrRsOD2iFwLpFavhX93NdeY=;
        b=cRBwkGQSOoyHUtdErP5FmuQEK8sImKFb2MN/uiPqsOJJ8pHkH1GVWeqIFOa5fuOaqP
         x2CIBa3qtp+eCbSlXMvVVbNelejayiFj6lxGXbtfqzRtf6+NL2+TnnDEUWQoJYQFlMpp
         bZgGQ1ERDqBwPAP2liB2SADkGxHPTtsVDkv8BdP8WG7zp5KtBzyaaQZxqH0NAnQ/6GgZ
         3yL6+NfxazZUvQE9phuYet2zSwxhwam33lXPBfj62FzS1NfLQqL0CeyyKvW0FAT15CXv
         BgQ0X7Wz59wbxZivqX78qcN1v/P+kwiNYS1sxBtfEhaobMBZeCZwWbWGZnr0LY2dW9/o
         5N0A==
X-Gm-Message-State: AOJu0YxPvuDNvOkKiXQkUbiQJX5f7o+Mv0ERTVDwXYg4IqRLw84eqkaJ
	8gMHid1v6l0lQdh81Ojd06Jz594NCm0VZ5RpjSGh6C9UE8i06lXwc51vNCOk9Cs=
X-Google-Smtp-Source: AGHT+IGP1g36KE5GUEDOa7/UU/iZU4CYUrtPGHdO6oAyW2nko+/0uASnekl2k0ybQr3KQ0knQ0sRqg==
X-Received: by 2002:a92:d6d2:0:b0:363:78a6:9fea with SMTP id z18-20020a92d6d2000000b0036378a69feamr1659639ilp.11.1706642595057;
        Tue, 30 Jan 2024 11:23:15 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id t18-20020a92c912000000b003637871ec98sm2157762ilp.27.2024.01.30.11.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:23:14 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/7] net: ipa: kill ipa_power_modem_queue_active()
Date: Tue, 30 Jan 2024 13:23:03 -0600
Message-Id: <20240130192305.250915-7-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130192305.250915-1-elder@linaro.org>
References: <20240130192305.250915-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All ipa_power_modem_queue_active() does now is call netif_wake_queue().
Just call netif_wake_queue() in the two places it's needed, and get
rid of ipa_power_modem_queue_active().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_modem.c |  4 ++--
 drivers/net/ipa/ipa_power.c | 19 ++++---------------
 drivers/net/ipa/ipa_power.h |  6 ------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 08e1202f12863..0c298060468eb 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -163,7 +163,7 @@ ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	if (ret < 1) {
 		/* If a resume won't happen, just drop the packet */
 		if (ret < 0 && ret != -EINPROGRESS) {
-			ipa_power_modem_queue_active(ipa);
+			netif_wake_queue(netdev);
 			pm_runtime_put_noidle(dev);
 			goto err_drop_skb;
 		}
@@ -173,7 +173,7 @@ ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 		return NETDEV_TX_BUSY;
 	}
 
-	ipa_power_modem_queue_active(ipa);
+	netif_wake_queue(netdev);
 
 	ret = ipa_endpoint_skb_tx(endpoint, skb);
 
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 812359c7977da..fd2abce043fa5 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -227,30 +227,19 @@ void ipa_power_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	ipa_interrupt_suspend_clear_all(ipa->interrupt);
 }
 
-/* The next two functions are used when stopping and starting the modem
- * network device transmit queue.
- *
- * Transmit can run concurrent with power resume.  When transmitting,
+/* Transmit can run concurrent with power resume.  When transmitting,
  * we disable further transmits until we can determine whether power
  * is ACTIVE.  If it is, future transmits are re-enabled and the buffer
  * gets sent (or dropped).  If power is not ACTIVE, it will eventually
- * be, and transmits stay disabled until after it is.
- *
- * The first function starts the transmit queue and is used in the power
- * resume path after power has become ACTIVE.  The second function also
- * enables transmits again, and is used by ipa_start_xmit() once it
- * knows power is active.
+ * be, and transmits stay disabled until after it is.  This function
+ * starts the transmit queue and is used in the power resume path after
+ * power has become ACTIVE.
  */
 void ipa_power_modem_queue_wake(struct ipa *ipa)
 {
 	netif_wake_queue(ipa->modem_netdev);
 }
 
-void ipa_power_modem_queue_active(struct ipa *ipa)
-{
-	netif_wake_queue(ipa->modem_netdev);
-}
-
 static int ipa_power_retention_init(struct ipa_power *power)
 {
 	struct qmp *qmp = qmp_get(power->dev);
diff --git a/drivers/net/ipa/ipa_power.h b/drivers/net/ipa/ipa_power.h
index f51653399a07d..dcd36a6a718f2 100644
--- a/drivers/net/ipa/ipa_power.h
+++ b/drivers/net/ipa/ipa_power.h
@@ -29,12 +29,6 @@ u32 ipa_core_clock_rate(struct ipa *ipa);
  */
 void ipa_power_modem_queue_wake(struct ipa *ipa);
 
-/**
- * ipa_power_modem_queue_active() - Report modem netdev TX queue active
- * @ipa:	IPA pointer
- */
-void ipa_power_modem_queue_active(struct ipa *ipa);
-
 /**
  * ipa_power_retention() - Control register retention on power collapse
  * @ipa:	IPA pointer
-- 
2.40.1


