Return-Path: <netdev+bounces-98743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A78D242F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E425B24FC2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3F181CF8;
	Tue, 28 May 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LT2tnmYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA232181309
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923051; cv=none; b=FHmFpypT+OuwR2ch+gwTUwVG8dbpMi6w0UK+B2z9otknSDx6kieOBqPebPcrqD6s2AnFaUpvPUSpYmv+pFxGPOJOIa4PJfIZX21Czuk46GT4M+1JsBJHxgIqTW5JHs/wtGVuHXRPEmAjT0N84OQSGRXohMQsAuUDfyrKE5AmRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923051; c=relaxed/simple;
	bh=Ktt2chxHVmf/NT6RXlWvzdDGnqCPL5KmvxHVj506Psw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOeYIVLCYWUKjfwNZtndPrYM7giiyt/K1BfoW0kjW3Di+VQNAD1gdlL+Fptvlk2gZ/Wyqf4uYwRNv6wNeuB/nDcBsZkAG/erdiqqU0WmhJP/rMBHHNoTBIcOuLSZDTD2BeoUyRMY/qmFmnLB/EAQ9xUVlpV5FwjcMJWEpk1qGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LT2tnmYU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42120fc8d1dso6944325e9.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923045; x=1717527845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOio7KxeuelYGQGCOPUzhDxltxXo0iSvEqTPnlEwle4=;
        b=LT2tnmYU1LjtbLLv3LhJ6SFo7GIzIlndHf/MbMlmv/nGD50FKiK5AeyKzy6/2Qrn6D
         FIKgdHQGOvmTLK3t7mHOAFRqI63X9Ud37VkflWpJuosYWEK4s5A9avriOEFF+bD3K5/A
         TZZq1W9Tf83a2Y7OeWeUqQzfbtCChjbbSBkkt1h16psY6HcsJnzoVBqV4/YtqFVQzveu
         uCBdYiZR8sOs1Y/sh8GvSdnhqcMYB3XS0ahDEcNxny76PnOAAljleOqWFHX/vV+uj6UY
         Wetf3agv4/qKLZC8BwW0fLwL5LwNTY3CFA59zORfkecpV6+wqqUtmDaiRGMUV4/SCUml
         kgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923045; x=1717527845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOio7KxeuelYGQGCOPUzhDxltxXo0iSvEqTPnlEwle4=;
        b=pbVZt0MlUFeaYsIuJg4K/OT6XCzxsyWM5zEYdM4hD8JPlEmgX6WbivNb+Z/8a1aZlD
         U7qAEEpiayfRYnUMdcMXleyx9SZsPEnHG0i+cjybfQbG44OtaFAHCMvbRG6VBHlfq/bQ
         drJqMvKJXptxPuv2tQYGmWKMqgDwH5bj9egKNKpiKv4Ozu6oEwd6jNHFkUoKuzeYoIAA
         SLHljkztTFOMdJp2G59ryeKIKrse8emeryts+OqciRH36Z6cLb5xEaEkb69NVGKVLFxQ
         BIaTGXQ8VDZ2mTbzpL9i8m63S2RV4ZEZgf0NYHJYqML8YyTHMnurd9oYa5jrMLLqCk8O
         /xUA==
X-Forwarded-Encrypted: i=1; AJvYcCXkCMziB0lRkNJJZVt/nk51ZjTyITzfQ6prf41sBPKQ4pmzMATRq/tcBHBwNC2vRrITALO0ZRnkdcYchpSyDt7I5nDHXFkA
X-Gm-Message-State: AOJu0Yzht8v8i47yaW/TXsRJxZtnktLnCSyddKywT/OA07H4Gi08U1ji
	3QrOQ4NNrvmaBX+e3Uq+iLgkOKTSLLK8gjGPwE4IHjI4N4BB2B7ASwuAuLeKjgw=
X-Google-Smtp-Source: AGHT+IFmkQU5z/NjNRbTvi69k9x+UO9H7tI5buIPv2H3GZSdzyYURPFjsjVaBq0Uz646z00KIwuhFA==
X-Received: by 2002:a05:600c:63d5:b0:417:fbc2:caf8 with SMTP id 5b1f17b1804b1-42108a7a3c0mr101292595e9.23.1716923045541;
        Tue, 28 May 2024 12:04:05 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:04:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:21 +0200
Subject: [PATCH v8 13/17] PCI/pwrctl: reuse the OF node for power
 controlled devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-13-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Y7OeFprz/Vcrv+LqGfLVY2kADqOCusmg0pTxdfuWyrw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqQlowqris4OXk74HDsTXkEu2fb7ceXtIZ3t
 /1F4SawtlqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqkAAKCRARpy6gFHHX
 ciu+D/9gNcUh7shLnVNjWY/dgJjWjWqDorXUw/wX6sJBNrxubSO/gyKc9jr+AWug2lgBqlQOp+k
 CdVkl6SrVCko/z9s5SrcQrVFUBVrWq1hC8w/GWKtZSHuzDKHab8s3sdzs3Y5pnLrak0kn25osA9
 D1JYD3NDkY803OYw0RHiGx+GCXTuPj9I7Ld2/eYTJXL8rfJxhX5Yo7Iectb5BNvRaMhrveN0kJx
 52sOrp6To2YqkPkRo5zcBVdcs0gt2d2/yL7LcFe0z7hSzDDgYlae6zUPC4eDqPEoSdWimDfp5pe
 kA9A5ci2MG7VwRP86OiKpcO8jcMX4+1Fz610EvQ8M7Z2adXIvzF1xrN9Qk0Cp+sQuD+w7WxWheC
 lY0eFf9MpFqLS+lJIDGAvclGtlhP1fCT69UwRrY/Qo7ijTsj/R0eMwHWnKOxaLwtgvplTWT16sX
 nZ3/83iFmyg4unCn8iYVrq650oBohZgiKMp8JePv/KInST3DHQ6HiCfgBcodc3GbX9P+Ja8OCVp
 8fM829/xJlqWbti0o9rRzYslm7y/ZvEH0VH0MxaN7giPt1WAxcMtSifoKQwdzcyNxuvHi3Btsim
 e66eK6rvw6UD6V/avQlxkr+wgJ/DLZhAi0Zofr+BPGpvxgz9AEEMCZm5KQaxZj6S3mbgMlMBIl+
 h5eAPbGFHqC6OQw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With PCI power control we deal with two struct device objects bound to
two different drivers but consuming the same OF node. We must not bind
the pinctrl twice. To that end: before setting the OF node of the newly
instantiated PCI device, check if a platform device consuming the same
OF node doesn't already exist on the platform bus and - if so - mark the
PCI device as reusing the OF node.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..b908fe1ae951 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt)	"PCI: OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -13,6 +14,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/platform_device.h>
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -25,16 +27,20 @@
  */
 int pci_set_of_node(struct pci_dev *dev)
 {
-	struct device_node *node;
-
 	if (!dev->bus->dev.of_node)
 		return 0;
 
-	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
+	struct device_node *node __free(device_node) =
+		of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
 	if (!node)
 		return 0;
 
-	device_set_node(&dev->dev, of_fwnode_handle(node));
+	struct device *pdev __free(put_device) =
+		bus_find_device_by_of_node(&platform_bus_type, node);
+	if (pdev)
+		dev->bus->dev.of_node_reused = true;
+
+	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
 	return 0;
 }
 

-- 
2.43.0


