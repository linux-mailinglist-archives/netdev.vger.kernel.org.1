Return-Path: <netdev+bounces-128828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3344797BD79
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0178288FD0
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4163F18CC09;
	Wed, 18 Sep 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HBllCe5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168D18C010
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667897; cv=none; b=TCA9475FS0PheqDEyoRcXm6GEsecVJssDA1S9m+dU+p195aS5sRWLxO9RbVOGDKtafRssh3R9M3wP6SvAMVG+YCRq/8KCKomQ4U257pVuci0yTDHVaGEUVyyCIrWSuizfw/cCxWptR/EjVEkbWHKe68QauPnolBjSPm6OXrNoIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667897; c=relaxed/simple;
	bh=uRjf76+ialIXRhrRcRnhdzxrLmruMKeJXsltkA5bYqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T+RLS1/hDlqkgrFKRJEAuYCeEtiAldUHjSA6edb9lhaYQCi6fjrlQ94qa860H3j+emCGPYGwDkLfVwUHV+pr3BsTdVyyyf1NnpHrlpcLEaWkY4OB6jpsbEfgirbtbsF/adwOPqME1n28/WGE6sOCV2Zn1VU28XGG/y/87/fpOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HBllCe5s; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso940766366b.3
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726667893; x=1727272693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
        b=HBllCe5sMkM5IkvbFss4nozGoq+z9jbUC079gOJYxhnSsUQt+OQip/BoTa4wzIXAXP
         3wEZfA65XYUsTvCXshf+hWSPrhKU3KRAvsXmz7f9eSM1v+fhReDoZmD2ewoQzouc4MC0
         qC7UVRAJt37KNI9a8HDtTlGoOWTqi1H/3F8Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726667893; x=1727272693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
        b=LreSRJW2zC8XEWuW1kXJp9hebGs7uoJooQRwmfZxjr6vF5F/3ZRSLPrH9zHKxa0dTQ
         owsW3jY2rER7xsgKdX8T4CeUidsamdPDBehK8Ofuo5bTo58y3eeSrrmup/7dGqPkQxi1
         yp6GC/X1SbUyM04UaFCazAHTSzWw/KplI2CkshOSkUeLHIG8zGS8ei1ijoHmtI92hN0Y
         io8vhEXf9bPJajx5bFuHMI2wndmx6FMzQOYGaK1r+8NJBiHUrB2R9xe+AEoJdK6rUDAv
         5CJHkl49MP02EyJtSUDYYGjPSolrJJOAIXpQQcXo5cIzZ3dK33xJrA03kIt3p0HGSTXs
         MxBg==
X-Gm-Message-State: AOJu0YzmZJwTOb6cZOat6R5JaVslMcd+MamuclvuGjl4uKhLvXtHqoRT
	jkIZmSqxGZR1zwoKuofTrMvWNjdIXq8IYKq7MBKEjYOGegUyHhry+juBHPxa2uNfVzfEFnSia0y
	aSV9qjYcUfgpbjSK+iudunA0BcboQBrUKww0obTFlS4tSVsvVhiJvb6DsNhjH08O3aN8iYjiJQ5
	UaQ7jpIN9TOVYE/TL6TX/ot94m/gcnU/Pze/g4rA==
X-Google-Smtp-Source: AGHT+IFmawmX5JiRVgNf/0L0WpQV3DqIK1N/ZTMHGP5g/mV8702xqodsE7+50nL/fybsbo9t4AkL1Q==
X-Received: by 2002:a17:906:6a14:b0:a90:4199:2a73 with SMTP id a640c23a62f3a-a9041992ae5mr2018156266b.5.1726667893278;
        Wed, 18 Sep 2024 06:58:13 -0700 (PDT)
Received: from localhost.localdomain ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613315d8sm595283466b.214.2024.09.18.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 06:58:13 -0700 (PDT)
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
Subject: [RFC net-next] e1000e: link NAPI instances to queues and IRQs
Date: Wed, 18 Sep 2024 13:57:26 +0000
Message-Id: <20240918135726.1330-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
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


