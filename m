Return-Path: <netdev+bounces-131828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F92398FAAD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AF6281A7F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED11D0DF7;
	Thu,  3 Oct 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nReqn2Cs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9A1D07A7
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998749; cv=none; b=m2PTiuZIiXqbWqho6GHhYC3sui0RbQXut80/fDCqLRV30DJkQ5N1YXs7t3fxEyfiR2TkpO/si2FZoTchw7j/kZ3QbZo1XbqXhFHFwJB5dQzBRiDT75YZX062Wm66JgHokE0NhbOh9GUvEhzzY5Lh4nqAsXGWjW+7EBWZUdo87XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998749; c=relaxed/simple;
	bh=4bT09cAu2qhfAav0tDdUjSpZJuBDzgUwRyW6i3IdhQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOs5efvy1ernCLOcWIcpRLDD5eEf9eLEJlkrGo9d3tQu8Q3UN/8QQUUpK94Y+sJAPbZc//nRjJwWFxBb4pwRDO4JQtppBNEA7yrfCy6CqP3vnbagQr600Hg9l8Ja0iFpZxmuKmW1hcddnqOIrdTVdLOaPWixkWn8Ddx8qaunA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nReqn2Cs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ba9f3824fso12298795ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727998747; x=1728603547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpDtgFKpiW6n7Ug+1YSP06l0kr3SHis2120480WaYUs=;
        b=nReqn2CsKP/Vspc+0IxehZ+Apr6pBWNxLuYV0ssoLUV1p0k5WlouxTmg9Y5vpoHez4
         DuRDtm4BnsLPGz77NRlTXgkTr7C/pQBqBBwoYLYK8vXwg3BAOtAhE25oFQaIx7DaOmY3
         UETnB6DW4LTlKV28Wu680jy/rnLmPnZA2H8mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998747; x=1728603547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpDtgFKpiW6n7Ug+1YSP06l0kr3SHis2120480WaYUs=;
        b=MMqokCzLYxP7e5w/Qs4iXmna68Q247xSJ2CqlNS/w22JVxFJLfWje3Uw3jMV3BLIrh
         HQILJA+rgl7grCBrgzc9pCyrsb310uTEqruub89sng1HvMI0pMF8sK9e+dMHYYOjMYor
         ACrJWEHjtsrj1og2dFpluEnTStgzpFmqEh1u5xQl8Vlmr1Cjsbj7ZdzUZLDd8NdJzXV4
         G46jbdQrPpsZBlw7QISQfX/ZR/57ExJNAM55pT/DqzXecs6LMH+BzmxDQRR5flL+07H+
         RbFXQBhEWqH+edAzc4uWew5ihTKiS6On8xkciGpj65UDZh6gD3+GJOHNQfZe/G4Hh3Ta
         wC0A==
X-Gm-Message-State: AOJu0YzEO0CaxPeuSECJl4q2ktf+PLLO3GTGUDHngVHNjw5ChoEBFpv6
	aV/IHuTYGVetC5S+nMf6MRyJhY+/D9q+2JFtBHnRrrSVL2oDwjzlXv8K0f3Ycl0/IusumYAtkha
	2XhVXsRIvPLfjcG7VElLJ08E5YB4kN4dUbHMvpWU+Jw5+ks/83jL3xVd/hC/FHIV6Nd+lQM8bxo
	GvxJ3E4JUp1XH+6z+YW1B9cndmmj9blPE2UkE=
X-Google-Smtp-Source: AGHT+IEscOgAVx/0YG9i/MINtF9xq0NivswWkuBxhiN50OJBwJky40grr6JNhThn+Z2xOj8C0ihYvQ==
X-Received: by 2002:a17:902:e742:b0:20b:b7b2:b6f4 with SMTP id d9443c01a7336-20bfea5417fmr10500325ad.47.1727998746571;
        Thu, 03 Oct 2024 16:39:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8ec6bsm13960705ad.158.2024.10.03.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:39:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 2/2] igc: Link queues to NAPI instances
Date: Thu,  3 Oct 2024 23:38:50 +0000
Message-Id: <20241003233850.199495-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003233850.199495-1-jdamato@fastly.com>
References: <20241003233850.199495-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link queues to NAPI instances via netdev-genl API so that users can
query this information with netlink:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]

Since igc uses only combined queues, you'll note that the same NAPI ID
is present for both rx and tx queues at the same index, for example
index 0:

{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 30 ++++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7964bbedb16c..b3bd5bf29fa7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4955,6 +4955,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
 void igc_up(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int i = 0;
 
 	/* hardware has been reset, we need to reload some things */
@@ -4962,8 +4963,17 @@ void igc_up(struct igc_adapter *adapter)
 
 	clear_bit(__IGC_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&adapter->q_vector[i]->napi);
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		/* igc only supports combined queues, so link each NAPI to both
+		 * TX and RX
+		 */
+		netif_queue_set_napi(adapter->netdev, i, NETDEV_QUEUE_TYPE_RX,
+				     napi);
+		netif_queue_set_napi(adapter->netdev, i, NETDEV_QUEUE_TYPE_TX,
+				     napi);
+	}
 
 	if (adapter->msix_entries)
 		igc_configure_msix(adapter);
@@ -5192,6 +5202,10 @@ void igc_down(struct igc_adapter *adapter)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
 			napi_synchronize(&adapter->q_vector[i]->napi);
+			netif_queue_set_napi(netdev, i, NETDEV_QUEUE_TYPE_RX,
+					     NULL);
+			netif_queue_set_napi(netdev, i, NETDEV_QUEUE_TYPE_TX,
+					     NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
@@ -6021,6 +6035,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct pci_dev *pdev = adapter->pdev;
 	struct igc_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int err = 0;
 	int i = 0;
 
@@ -6056,8 +6071,15 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 
 	clear_bit(__IGC_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&adapter->q_vector[i]->napi);
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		/* igc only supports combined queues, so link each NAPI to both
+		 * TX and RX
+		 */
+		netif_queue_set_napi(netdev, i, NETDEV_QUEUE_TYPE_RX, napi);
+		netif_queue_set_napi(netdev, i, NETDEV_QUEUE_TYPE_TX, napi);
+	}
 
 	/* Clear any pending interrupts. */
 	rd32(IGC_ICR);
-- 
2.25.1


