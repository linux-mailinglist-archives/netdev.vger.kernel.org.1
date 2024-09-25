Return-Path: <netdev+bounces-129807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412639864DA
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728C91C2647B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936C71B3A;
	Wed, 25 Sep 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="I58TttfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2615025E
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281861; cv=none; b=WidPYLBVdoEMWOFmq5y2Eho4cYnJv3akJ+/NIfNrMpey55660xOFujovWa6/6LSg8pURM1fooLZ2BpM8e5rUreEbSFtimy+85Wj6odXBfy2MM/8VmXysNhhwuFN8NtpAWxjAJvtxYI0MNwIpxylU9uWGpGjAOgwE37pwzcRu5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281861; c=relaxed/simple;
	bh=uRjf76+ialIXRhrRcRnhdzxrLmruMKeJXsltkA5bYqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2bXewUarsbkLuoedeAdPZ2Qcfhl2lgUtAvfip8b9v6PFaPhFe9cIrnf5+OUudUapyxsUyJmwOTuvsL3Kfie4287B/b1XTO11tRcKY34YZ9KwANLwiw3Sulmv2KJhrMaZLzYExOoD+jk0REW69PNpYIIKgWhT7KCbccLXXrPIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=I58TttfG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-208e0a021cfso41894345ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727281858; x=1727886658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
        b=I58TttfGVOvcWuCV6NMNty8vqlocq56VdEEdYqRmO9ngoGPU6fF67cSkL7r2LahVJL
         Nt4sm7LxltzcxpA1vduFOvsI3WEEGhc88eA2s42jgZxyyWrVOod7QCE0RIIXR7w24MDM
         YjPklsDQGRyuhrC4w7NO0Xem36fGLBtiibnDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281858; x=1727886658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
        b=cRkHW5IfmxLR9Mo4H1Ff16vfdjESeElIdQl2a1KGTdEIBZ1WxjNuvgtoYbjL2qmNZu
         3mwM6b9Pq0bZ7Rdwh+HTvd7ee8bNRMNOtUohg+13t2phFyUb5FhJv1kNLE/YycPSxcFS
         COKuiTDJiFXKMVkoeXm5Kk91Q/18w9IR3m8boOr5kOJhOp4722Fwcap5snGylzarx1Vv
         rxntYLeQrhhpR6jigkD4wR5hiqNRkc4rd2pIZrwCc+3MYZ1AOQniOxdcyLgCuFwTXrB2
         ks9OSZxwLiqwurKTqm+ncU+mZrkCDpFYt6BPW6h2GiP9ONgwsLW5o42ucAcV3T3bSu+p
         OiQA==
X-Gm-Message-State: AOJu0YzyWDjs+N8JwILgIOsKPYFMNmC0LI7axEtmeYGuOyb0G954cgKc
	TjccXd9Q1XYxj5WrQbafVEHfaoV2O45yJFeHmRHTE33s5PC1Lxx8usC2TEb+z7wp0CZPBfNb1GW
	Ga35YdG/vz58NxRfuL4ToNZ0yAWB3Do/07Zige0cUEMedIrXpS3Cj+Yv1lTsrg7iOSO1WIMF6GC
	CGwwO/sGSuwiAn3P22/L8zihdii/jKUxufE0M=
X-Google-Smtp-Source: AGHT+IEM3gPUtOxfd/W3Jnyzn6mZZ8mH6XO7SpWmV1e4jRBezuatggwjJ5DEzXqm0y0ZQlMXfIHvmg==
X-Received: by 2002:a17:902:ecc8:b0:206:ac11:f3bb with SMTP id d9443c01a7336-20afc5ee705mr34902965ad.47.1727281857892;
        Wed, 25 Sep 2024 09:30:57 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e0702sm26345585ad.28.2024.09.25.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:30:57 -0700 (PDT)
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
Subject: [RFC v2 net-next 1/2] e1000e: link NAPI instances to queues and IRQs
Date: Wed, 25 Sep 2024 16:29:36 +0000
Message-Id: <20240925162937.2218-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925162937.2218-1-jdamato@fastly.com>
References: <20240925162937.2218-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make e1000e compatible with the newly added netdev-genl APIs.

$ cat /proc/interrupts | grep ens | cut -f1 --delimiter=':'
 50
 51
 52

While e1000e allocates 3 IRQs (RX, TX, and other), it looks like e1000e
only has a single NAPI, so I've associated the NAPI with the RX IRQ (50
on my system, seen above):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                       --dump napi-get --json='{"ifindex": 2}'
[{'id': 145, 'ifindex': 2, 'irq': 50}]

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f103249b12fa..b527642c3a82 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4613,6 +4613,7 @@ int e1000e_open(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
 	int err;
+	int irq;
 
 	/* disallow open during test */
 	if (test_bit(__E1000_TESTING, &adapter->state))
@@ -4676,7 +4677,15 @@ int e1000e_open(struct net_device *netdev)
 	/* From here on the code is the same as e1000e_up() */
 	clear_bit(__E1000_DOWN, &adapter->state);
 
+	if (adapter->int_mode == E1000E_INT_MODE_MSIX)
+		irq = adapter->msix_entries[0].vector;
+	else
+		irq = adapter->pdev->irq;
+
+	netif_napi_set_irq(&adapter->napi, irq);
 	napi_enable(&adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, &adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, &adapter->napi);
 
 	e1000_irq_enable(adapter);
 
@@ -4735,6 +4744,8 @@ int e1000e_close(struct net_device *netdev)
 		netdev_info(netdev, "NIC Link is Down\n");
 	}
 
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
 	napi_disable(&adapter->napi);
 
 	e1000e_free_tx_resources(adapter->tx_ring);
-- 
2.34.1


