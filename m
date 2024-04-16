Return-Path: <netdev+bounces-88514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B53F8A7866
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 01:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4811C21653
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF813BC1F;
	Tue, 16 Apr 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQu4G2sa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DE13AD2F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309037; cv=none; b=BIgGuSQB+ux0KNBrwxHeRfpVt/WpC4jK91nzxkOW1jJsrMoAu3nLplgKjm4eCX/n1boijVndKxMqL6MRHMkRAYl+UVTJ8Kcd3kYyPnZAviqMp1Wl0HYp2HsccX4N7JFgXyGkpg4L4GZ+hG37vyA2GW5DkyBSmTvWjhILPICPgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309037; c=relaxed/simple;
	bh=EbIYGk++rgx+7NmztvVdLwSFy7KqI+W3KHG9jDFNs9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbghZIiJQKxISbevTZSQmzbrlUMSlmm8e2yI8stVsDbU7y9bEJG6bYZZ8RtBj+cRphhDwA466XarUCGsUqmIt4zWIPm/7WcLw3M8cQ3vKYbCMAYCGK5D/FKbVc/4Asa8ElMDfMZh7bLYzGvicva1IgktESf8bQ+Adc7cfxj/gRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQu4G2sa; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d9cdce41f0so44147339f.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713309035; x=1713913835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojvGKcc7AAkbvn6SYuvIFckxsha/qXH2nNMIJd0yE6w=;
        b=RQu4G2saxogsehrb1pFyerWHXtJ2xMdE7NXCqgZs+we7V+MXf61A5kZrij3VBaGu7A
         oZGFS6+0nxHXewFO2xWW57izhKEg7qoCbyb6oN5XuLQASsC8g1bJppP9tzuvCQ50aLFM
         Ja5HDrUaJZEWDxOwh1STNenvle/XScy3uAaCBShkEiFOQj4qTWCMb/3ty6bxm5XD0ziK
         zY+hh87Xglw8sUOW5NJio2lFH/n7LfC+vv1crukox6Mgq6zGSTgCKlBf9e/NHgoCZgxR
         QVM/7VANx1CO8LxBNHD/Cff5oUHLj27UJagoc3qQd6nMMyCeRYh0CtJcKD77r+NVNNR6
         mEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309035; x=1713913835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojvGKcc7AAkbvn6SYuvIFckxsha/qXH2nNMIJd0yE6w=;
        b=pb98S61WEMHlOiUMCZmgWTxmEUIRmESTm2z4cf1h8sWMtQAIAJzpG4beZ2BWToEc99
         DxZU/svJK394ud9I5kQAM43VsPdVhS7Awt8P/+tLqSaj0PEdOBM2sdG9msG9LphpQzjU
         YAazTN4DdgITocZBn7eJVNVRbDQ3pfRK8DWv1QMdvAEeck+IgljEQ68BdbsEbIk8Bmi0
         W2Ar7BVDStoMGwV8va+7jsjfD8XGKwutG/5ea7mq1w7QR26ztfa8rfgcL3VQliAs0bOM
         B98DKVOyu0I+adWwd5kiUuJtqNq3/aaqFkrF3gsExGu4rILE+UdFcm6cJeOxsDO0y+CR
         t20Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTa2AyDBbfozD3F901epXdFaSzvEpfsruWbTUmwj6WzMtECCBNwYMQuxAoxKNd3z/HgBgHH53w6S129NV14bnCc4BGReIN
X-Gm-Message-State: AOJu0Yz1cLO07HtV7zCr6TXx9CL9FMIDC31I7cpPdJLQQadQsR3Reiwu
	ALNNa3yA9fsLXZiuNQpYO2My8x5Ie5UkF0rNaC8Ex0gPNHVh3BoOmQH2bwYglkA=
X-Google-Smtp-Source: AGHT+IFi3/gmplobIjS5SJfn0KyHlODX/EQBn4/S2xiJvgSIWALbxR27pts1oOqmmjMW2djZV2atNw==
X-Received: by 2002:a05:6602:389b:b0:7d6:65cc:cc05 with SMTP id br27-20020a056602389b00b007d665cccc05mr20170496iob.1.1713309035312;
        Tue, 16 Apr 2024 16:10:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id le9-20020a056638960900b004846ed9fcb1sm372170jab.101.2024.04.16.16.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:10:34 -0700 (PDT)
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
Subject: [PATCH net-next 4/7] net: ipa: add some needed struct declarations
Date: Tue, 16 Apr 2024 18:10:15 -0500
Message-Id: <20240416231018.389520-5-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416231018.389520-1-elder@linaro.org>
References: <20240416231018.389520-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare some structure types in a few header files where functions
declared therein use them:
  - Functions are declared in "gsi_private.h" that use gsi, gsi_ring, and
    gsi_trans structure pointers.
  - A gsi_trans struct pointer is passed to two functions
    declared in "ipa_endpoint.h"
  - In "ipa_interrupt.h", a platform_device pointer is passed in the
    declaration for ipa_interrupt_init().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_private.h   | 7 ++++---
 drivers/net/ipa/ipa_endpoint.h  | 1 +
 drivers/net/ipa/ipa_interrupt.h | 2 ++
 drivers/net/ipa/ipa_power.c     | 1 -
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/gsi_private.h b/drivers/net/ipa/gsi_private.h
index c65f7c5cdc8d0..968ab1e596e87 100644
--- a/drivers/net/ipa/gsi_private.h
+++ b/drivers/net/ipa/gsi_private.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _GSI_PRIVATE_H_
 #define _GSI_PRIVATE_H_
@@ -10,9 +10,10 @@
 
 #include <linux/types.h>
 
-struct gsi_trans;
-struct gsi_ring;
+struct gsi;
 struct gsi_channel;
+struct gsi_ring;
+struct gsi_trans;
 
 #define GSI_RING_ELEMENT_SIZE	16	/* bytes; must be a power of 2 */
 
diff --git a/drivers/net/ipa/ipa_endpoint.h b/drivers/net/ipa/ipa_endpoint.h
index 995f12af1623f..47259616c679d 100644
--- a/drivers/net/ipa/ipa_endpoint.h
+++ b/drivers/net/ipa/ipa_endpoint.h
@@ -15,6 +15,7 @@
 struct net_device;
 struct sk_buff;
 
+struct gsi_trans;
 struct ipa;
 struct ipa_gsi_endpoint_data;
 
diff --git a/drivers/net/ipa/ipa_interrupt.h b/drivers/net/ipa/ipa_interrupt.h
index 7f8ea8aff7fd4..64bd8cff1a041 100644
--- a/drivers/net/ipa/ipa_interrupt.h
+++ b/drivers/net/ipa/ipa_interrupt.h
@@ -8,6 +8,8 @@
 
 #include <linux/types.h>
 
+struct platform_device;
+
 struct ipa;
 struct ipa_interrupt;
 enum ipa_irq_id;
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 42d728f08c930..9569d35d899bd 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -9,7 +9,6 @@
 #include <linux/interconnect.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
-#include <linux/bitops.h>
 
 #include "linux/soc/qcom/qcom_aoss.h"
 
-- 
2.40.1


