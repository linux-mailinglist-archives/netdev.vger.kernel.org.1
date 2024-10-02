Return-Path: <netdev+bounces-131103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0E98CA10
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 02:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DE41F222A6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AE0567D;
	Wed,  2 Oct 2024 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fijOsP/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29454431
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829254; cv=none; b=UUoanF5bBiHyoXYCzpeGfeh6nR24EpLh/uisCmqxjKCkvZ8CNuc5Q3ZQ7wgMiIkk5JzVfgW4ttfu5/dhtn80qxDx/IUldKr0nqO8xzySmb45Ho+V39OcnrTtp1oRwVtkRCWECBNyKmd+0VTQCxkXx2MgSczDNmS2GDjBsC2a6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829254; c=relaxed/simple;
	bh=KL3UNVOO+s3nv/aYZ11pPp7hRX34/k3082Gj4LNGNS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6Hm/87aolEM20luo6vGXaiLoV+R6oeQXd6zDet4WJI3E34e0osCHg5GUiKYKcxzvDEtw7D+Z9Ftpax0SJPqstmiXlsRutre7PBhjkIeIZklqIJz6SSABUpPRMYf75YRFr3XQR0ukBIIt+TJkomkaqZ37BP2PDyDOhfKVgE6o8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fijOsP/p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b833f9b35so25471545ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 17:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727829252; x=1728434052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp3VZUxo/lD901bYrs19RJOxa2w8kC8h+z4RpfrjR9c=;
        b=fijOsP/pJNuTnB2ALKwouqLQp28uXao7jLNMXgkFvue8BK1+9WmRUNPzAyBNw5Qrzk
         2wXLJ9hG6FqQUkv+TsZF8T52/+xThcEzNkNRD8Q52mgFJdYduGtv9GF5RNb132LcKMsK
         Vc3J1TkceSIMnVlenaWV6eg84d//JkZs4aHI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727829252; x=1728434052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp3VZUxo/lD901bYrs19RJOxa2w8kC8h+z4RpfrjR9c=;
        b=jJvqj5Gyhfkdrk8zlr4ynP2dtWEf2grWevyh0T2Of4PWAYRltzaIdyT95+ZcBGLzJ1
         3/qUbK1MeriDdUzQbtJjwtPfrH8XSR8yhtcm3kwqr4ANSwJU1hkVgkQspTrzKwnhfeZU
         u7JyQWKNvnCtpIlkjMfD0905h6UaYpZIr0K56nYeXpfyeVQZS7y2+ZZXq9OEnApS01ml
         XZozMWl8XusHV/a7QJHJt1Vvjuok8UTJ/u7f/WUeOEVxLgHWaYV4k6X+NnKmiwcValw3
         CKqI4927acSXH4m69KV15y53+A8EzxJz2T4DIeVWxrK/DgXGNJY2r+tqcmKsnzaHVTq8
         lVuA==
X-Gm-Message-State: AOJu0YwtEh3wbfZpfacbsLl8Nq229A/wEUIjP4C+t95eFlhslsV6LjTg
	zq3oPwsunAWCxLOBAvhTAVRBIXWrRzsptwukvizuF0+O6QTMltumCyJIphElg171ne5oXspXJqb
	tNL5TfkSEmDfCDXqK9aljsrKDt5lbQKlVVIF91/3cz/hXzUKpnuN/Q/ABFDjgkqiaTI6xwliZUW
	crW54XIZ1VDP+Ct/zgs41bvLHobfP2ioho4kU=
X-Google-Smtp-Source: AGHT+IEIekgibqyro99agvc+hy8DZog7aA6fRr+4APIpGVoW11t7pGNTqxGiUlThpzOf0vmpJQ/9Tw==
X-Received: by 2002:a17:903:60f:b0:20b:af36:ea5 with SMTP id d9443c01a7336-20bc59c3584mr16249735ad.18.1727829251677;
        Tue, 01 Oct 2024 17:34:11 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5ecc1sm75521295ad.268.2024.10.01.17.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 17:34:11 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: darinzon@amazon.com,
	Joe Damato <jdamato@fastly.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 1/2] ena: Link IRQs to NAPI instances
Date: Wed,  2 Oct 2024 00:13:27 +0000
Message-Id: <20241002001331.65444-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241002001331.65444-1-jdamato@fastly.com>
References: <20241002001331.65444-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances with netif_napi_set_irq. This information
can be queried with the netdev-genl API. Note that the ENA device
appears to allocate an IRQ for management purposes which does not have a
NAPI associated with it; this commit takes this into consideration to
accurately construct a map between IRQs and NAPI instances.

Compare the output of /proc/interrupts for my ena device with the output of
netdev-genl after applying this patch:

$ cat /proc/interrupts | grep enp55s0 | cut -f1 --delimiter=':'
 94
 95
 96
 97
 98
 99
100
101

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
			 --dump napi-get --json='{"ifindex": 2}'

[{'id': 8208, 'ifindex': 2, 'irq': 101},
 {'id': 8207, 'ifindex': 2, 'irq': 100},
 {'id': 8206, 'ifindex': 2, 'irq': 99},
 {'id': 8205, 'ifindex': 2, 'irq': 98},
 {'id': 8204, 'ifindex': 2, 'irq': 97},
 {'id': 8203, 'ifindex': 2, 'irq': 96},
 {'id': 8202, 'ifindex': 2, 'irq': 95},
 {'id': 8201, 'ifindex': 2, 'irq': 94}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Preserve reverse christmas tree order in ena_request_io_irq
   - No functional changes

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c5b50cfa935a..74ce9fa45cf8 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1677,9 +1677,9 @@ static int ena_request_mgmnt_irq(struct ena_adapter *adapter)
 static int ena_request_io_irq(struct ena_adapter *adapter)
 {
 	u32 io_queue_count = adapter->num_io_queues + adapter->xdp_num_queues;
+	int rc = 0, i, k, irq_idx;
 	unsigned long flags = 0;
 	struct ena_irq *irq;
-	int rc = 0, i, k;
 
 	if (!test_bit(ENA_FLAG_MSIX_ENABLED, &adapter->flags)) {
 		netif_err(adapter, ifup, adapter->netdev,
@@ -1705,6 +1705,16 @@ static int ena_request_io_irq(struct ena_adapter *adapter)
 		irq_set_affinity_hint(irq->vector, &irq->affinity_hint_mask);
 	}
 
+	/* Now that IO IRQs have been successfully allocated map them to the
+	 * corresponding IO NAPI instance. Note that the mgmnt IRQ does not
+	 * have a NAPI, so care must be taken to correctly map IRQs to NAPIs.
+	 */
+	for (i = 0; i < io_queue_count; i++) {
+		irq_idx = ENA_IO_IRQ_IDX(i);
+		irq = &adapter->irq_tbl[irq_idx];
+		netif_napi_set_irq(&adapter->ena_napi[i].napi, irq->vector);
+	}
+
 	return rc;
 
 err:
-- 
2.25.1


