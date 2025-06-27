Return-Path: <netdev+bounces-201866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97013AEB4A4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D683B2979
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5C2DCC10;
	Fri, 27 Jun 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k2+CuFGi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2729A301
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019754; cv=none; b=RQnjYNtrDmwngmD/JCd2pZNzL9oOh/g8xcWhsQAU5iPhTbdqP66Ru/eMMYA+NyJTJhezOG9PAf7s/37egV2P8wOwrLEz2MFQNuhrwoVTRmFEFRRXckBaMbSDt6lH3jdq13LRROG3knpnWadiqHMcXic+K8IlAUcCcIIU7THiCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019754; c=relaxed/simple;
	bh=s8ZiiE6pHUvr9gtLMt4WDPecDrQRJim5pyRk8EKuUdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BquViLc/txWOdPPI/uUCT6zgDsYj9yx8krH2viwjARLWpvytAYg3y9pZcYEPvNynEZ+gvZX4bL3iSfMgQzCNs1V9di60+0YCEE8vRf2Cx+upsEspy2wHKNE8D82n2XOiUa9/TSphX1GAZTXvuA5tZyp2+XbjO+FwFwwtTfhjQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k2+CuFGi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0b6532345so581787966b.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751019750; x=1751624550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGUGwnAuhK8MqbgXiShFzJdKHPJL+NaZqgwZsBl0yC4=;
        b=k2+CuFGi50chqJqdmP1/ruwT3KGhSiLY0i8WUBRnGZr8nKFBbfMRr1mQc1D4zsYxCG
         ZAoQkKyX1EyJ2F1jKuHCRjUiEuWcLjNd4RUju4/6EPRlhWcvAx0ZzS1feAHOUHjPY2pp
         rkjL+3txpVJZq48NDVatU0PhMp/x+QaOa5Yt4gPyEtqUAJOXKmnWq/HGQ9Une9i7rx0W
         ZOiZzpRUi5Pu33mniAA3+oU3LIrSS1rYNsmn1jPqOYpfQDK8ghW8/vidPD7r6awQ7L19
         2/ifltrdSJWpMCBN3M3thnQoeXv+fSicfKGX46mNDmSily1FrXXeo8whhkrQZ4moZKtY
         LPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019750; x=1751624550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGUGwnAuhK8MqbgXiShFzJdKHPJL+NaZqgwZsBl0yC4=;
        b=S88W4sJLeL+BGclJuzYkzL+P4JvLh669zNj/mjUWp2jStcrqccGdunHUfTSaA5GA9u
         2DlcZEDUWhuaY3TCBWZyM2eYQOud5R5SO9NCzmbaPxYz5m+B1bT2IrZPlcGNblsiQNpW
         P569kIiboJj78cdW/iheQqmpxbCXzR5LyTbjr/u/Kl4h73uxqwUhT+bn2buN7j51mVES
         HXKmCEwj/G+zh+SBg+1clhUhR2YlW4GHq5I1BM9niKfAsOGsVB8FP8pCgWj2qlg7WfG3
         rmt+cjMj0Vdx7NbFd+lYXdJLKbDZByPQpt1YjjSUuOaRtvk4oavXg7wmt+I3YlKMjEfM
         naQQ==
X-Gm-Message-State: AOJu0YwN/QQW74RSTA1quMejKAFbXmmEHvGCfujc24Hh/B2itOXjGDwO
	11pnPBpsFo1ooYKPipLnsYcjYSmhsN1TtC2eFk2EQF1g/Sn/ogoTeQd/UUfFuzIBfTxuZkA/Qex
	NFj+N
X-Gm-Gg: ASbGnctM8/e++T4qvM8q4KP8syA733eAa4YdsP8NwV1NjN3epRZY9FTkSgSTpJkzdHn
	ENEdlu6VUNcBcPOfvoqJUfS9TgIPHoYymEavWW/qypQQu2ohJNiBbYka3/iQmC1kIY5yD6iJyM/
	fMWL/JiK1yB1Ss6sU9+m4caR6Npv3uODTiYE5nvxoX3xN61hX9pRcpVYzB+utkzDRXCmdH4PPQv
	M3Q7UpUz1G+f/+RKkAaUHX+rngarHngSyyV9UkNAjiw5DkcQOARo9QAxFyMzLqm123Hzrc3tAUR
	QRBN/ww7JBCHvTaGrEagH3sDT4P1ZOtPhj57v8do1PJ5MY8G262/oZJzzVZ5YZz7TBb0ZZ14kkc
	MEYFJWEodwz2uxgfzPqH39ar/gu+x
X-Google-Smtp-Source: AGHT+IE91OPz08IFTkinkt2AHiqhjKg3XMlDuTR8nwgBpzRrkeW2Al5f9bM+VB6od7e4zbBUhZYi+A==
X-Received: by 2002:a17:907:7fa2:b0:ad8:959c:c567 with SMTP id a640c23a62f3a-ae35024fe25mr244930366b.10.1751019749860;
        Fri, 27 Jun 2025 03:22:29 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353c6bbe3sm97297066b.118.2025.06.27.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:22:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH] net: tulip: Rename PCI driver struct to end in _driver
Date: Fri, 27 Jun 2025 12:22:20 +0200
Message-ID: <20250627102220.1937649-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=s8ZiiE6pHUvr9gtLMt4WDPecDrQRJim5pyRk8EKuUdg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoXnDcMjJBYg5gCFIS22jS0XuNYbfDlnIdAovsd FAxr2zVZF6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaF5w3AAKCRCPgPtYfRL+ Tu71B/47n29FL5xDhs0JB0Z6fwiwT6cSBmwA2DKeJN9JTAO52f4BOIn/xG+k4CIL8PDVS1jewQX 4ZxGCTR3gdGmxIUMjPA1XYuao+NRl2J2wHaWPUXh0/QhWIoC1gBaEDKRB+2KR8FYgZLJQbyLxo4 8MCW8ANovTUBEcTQEo2S2/l2PAx6+1Y17ac7WaI7nO6LYBfW5HIm1ki2daioIztAakncfJt6nxT Mi+Np+FwiAY5bFaQ7f7sI09Kjrpe0wdyICVHxk2CvqWGzluN+orNZ+I22mEFD3I5/8EdZ18wY3I 8TD4cWzg4NwQCuxzJP/jpuKey+yk1efSdCTNRW8sjpPc9Gmr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This is not only a cosmetic change because the section mismatch checks
also depend on the name and for drivers the checks are stricter than for
ops.

However xircom_driver also passes the stricter checks just fine, so no
further changes needed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/ethernet/dec/tulip/xircom_cb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/xircom_cb.c b/drivers/net/ethernet/dec/tulip/xircom_cb.c
index 8759f9f76b62..e5d2ede13845 100644
--- a/drivers/net/ethernet/dec/tulip/xircom_cb.c
+++ b/drivers/net/ethernet/dec/tulip/xircom_cb.c
@@ -143,7 +143,7 @@ static const struct pci_device_id xircom_pci_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, xircom_pci_table);
 
-static struct pci_driver xircom_ops = {
+static struct pci_driver xircom_driver = {
 	.name		= "xircom_cb",
 	.id_table	= xircom_pci_table,
 	.probe		= xircom_probe,
@@ -1169,4 +1169,4 @@ investigate_write_descriptor(struct net_device *dev,
 	}
 }
 
-module_pci_driver(xircom_ops);
+module_pci_driver(xircom_driver);

base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.49.0


