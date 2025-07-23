Return-Path: <netdev+bounces-209194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E6B0E928
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C374C7A909D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827542472B1;
	Wed, 23 Jul 2025 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4zDhxbJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA682472BC;
	Wed, 23 Jul 2025 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242070; cv=none; b=s76I/+5lCUrmpdl8Qm0h4PVln8XKqE166VJZ2oJ6P1M9WquybwNlCVeESozMjkufaqu2+WMUQkKV6BJlwHXz3vpyUutUtwMEpvVQxItPeofL8Jwng9Cb8Rng1itQrhOlL8x/MARO9CBQOXAqasNyiCRYTCvtJ9R+IHaBwvAPccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242070; c=relaxed/simple;
	bh=df075Tefb06yT/gPB+wSV37RFhDzvwa7mJfOX3S6rno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yb5x96mOrMYmztDUAG5smjQQHcP3MDVG9CJxgqZN/Lfw9SW2JB2gNmgmW/aSnBZLYdfX9kwZdWj9ofcHMB0qgW4EAxixWX8HZVQ5oaop6OUlAByoSpqx4yB7fv0bGfEmMUYe8lF7KCwYGjKPkt4Paf1zscxi2OOEcVYYA5l8wok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4zDhxbJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fb57fe217fso13633676d6.1;
        Tue, 22 Jul 2025 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753242068; x=1753846868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qpo8tu51HXqZANrhzRb2Q69KGNvJWb9swnQtWIikds=;
        b=O4zDhxbJQPYZ80DsOL9F9QZ0MaeJyB/69aPekKRiWZlD+LF1iKLF9bSWEuce8G1vBN
         BqPCsNkNsFVBhuZxdK3BLWNAmBSE2qgBSnu5kkImjfMOTJMkfz9mBCf9sWhBDOTmXcCY
         zEgTZnTgir9ZLx2bH39ztZ1XXOzydoF+LqcGMbe5yOe57+DWDnB7Ar3AzuoQHFKbKFC8
         T05fT7QrTY47Gr2G5l0Di3d2GFOP1o+BgWwK1H7518G8O+zu5euXCZAJab895TQ46VpK
         76k/a76zUjE92sGzZ1hgDt8grSsQBD4TyHQsOmcsoLKNyc/9K1KsnG0Ov07hbqVfkdAV
         /w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242068; x=1753846868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Qpo8tu51HXqZANrhzRb2Q69KGNvJWb9swnQtWIikds=;
        b=QR0DfpZp/N9hUrzSJ+HUBL0RD2MV6O3kilL0RonSkMia/J15hcaCrujYYFvnsMoORy
         whBxP/HGpHBkpCecbO988GA4Xn51R02bGxfL8dSYjycQW3FuGi7ac9XgE8gKuuJdECE7
         /Qkl8WuFG1hr0tCYgiTrATN6AMs39Fut8wEOkOO5PdHMpt+N+w3+43Oj3rqoLNuqxG0K
         4ez4VQJw8vztaxpZxLqd2zgOyZDn8bSLJRmujxxGFS4Ggs4l2z+JVJ4ayHE4Mb4z4vbt
         DNcJ2/XHLj0Uap4MVZRyINBFDlGdvo51gz93QPPdN31ec3zDI9Jm6xykSaFmJceqta/h
         Zu9g==
X-Forwarded-Encrypted: i=1; AJvYcCWFNCIQuIQQVH2ImFzBxDm9ub4NzbhbF+zcpMkOP/1QTt44nHll/IvDRMmqELFHGmo6l/ilIUsYo2n0g40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHQMo9xWNp7NgOfS6aiI0lk3XuAU2m2P4gOPTvpfvCWfmIcel
	hZEEMdZ+YQ0uauX7AEPRknxmCiz9Sjw0lXRvfpfoSr53XaAMKd3+VMM=
X-Gm-Gg: ASbGncsSSg0Ma8T9rJ5NWmK9VaRp9bmNiImQdWu/8WFyRMaX6BEmZoiGihYhgasG6DT
	6bP5gXTPU+XK2r8PGauM6fhRZ7tHdio48JjbLuBtVCm69YsJdUp5vYmQeqhQ9IOhzZwFuKrsUU/
	sdk3bwTxRrvBSBFgx41VapkDQsxTpKABIj3iVextTjTZof3gD/ftTYi5d/AQrDTvRNQBi8itsUV
	tn+A9BBtdchkBlUqeEv9JSP82F2phwruk+zJGSfUm0YyG6cekLncT/YMPm1qmBJYn+Ll5aZ6VwI
	QPSi+SdRwjLtnKwxA4MrIAZLdh3+nwyme7gsd3j3bbiTpRPdx8Gd2IOo7oeYGVAeHiyFoFJ16w+
	PNwMGSL/JoSGnJfJi9Pk=
X-Google-Smtp-Source: AGHT+IEB3BgU1ioTtolfr30F79t+QzIv3AfMezRUofMID7/poMYRpFzwCLsiJDD0BA/Y17WB7cqwGQ==
X-Received: by 2002:ad4:5aaa:0:b0:706:695e:7fd5 with SMTP id 6a1803df08f44-70700624cc7mr8482026d6.5.1753242067618;
        Tue, 22 Jul 2025 20:41:07 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b27b06sm596568785a.17.2025.07.22.20.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:41:07 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	mingo@kernel.org,
	tglx@linutronix.de,
	chenyuan0y@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pch_gbe: Add NULL check for ptp_pdev in pch_gbe_probe()
Date: Tue, 22 Jul 2025 22:41:05 -0500
Message-Id: <20250723034105.2939635-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since pci_get_domain_bus_and_slot() can return NULL for PCI_DEVFN(12, 4),
add NULL check for adapter->ptp_pdev in pch_gbe_probe().

This change is similar to the fix implemented in commit 9af152dcf1a0
("drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()").

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index e5a6f59af0b6..10b8f1fea1a2 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2515,6 +2515,11 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 		pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->bus),
 					    adapter->pdev->bus->number,
 					    PCI_DEVFN(12, 4));
+	if (!adapter->ptp_pdev) {
+		dev_err(&pdev->dev, "PTP device not found\n");
+		ret = -ENODEV;
+		goto err_free_netdev;
+	}
 
 	netdev->netdev_ops = &pch_gbe_netdev_ops;
 	netdev->watchdog_timeo = PCH_GBE_WATCHDOG_PERIOD;
-- 
2.34.1


