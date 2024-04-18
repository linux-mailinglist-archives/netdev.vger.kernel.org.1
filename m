Return-Path: <netdev+bounces-89439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE378AA44A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1911C229D9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1291A0AE0;
	Thu, 18 Apr 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYjQt/ct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265B19DF41
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473264; cv=none; b=KZzzrDBIRxOhDPqjT7z3knW6UOwp3jNX7j5T2cAWOYwSfEd8bch8D0GPJWrAy1SU0pfVotJjDfHECxq45boIMusoVvVIdrBDKg0kCRNFeZ8lKlQVvWDPloZKJd4POI0M8VHR1+decZMqltFjV1m8+qjt61td9pCU2PkvPKd/joE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473264; c=relaxed/simple;
	bh=/O26O0SPwaQndb7Gk11BnaA079JRAE9KvwG8Uy+fgkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQHfgVB6Qy+Q//+wDZB/b2TZDsrhTdk9h6xOWjKr/bzNb6OULydqpPL5Hto3lAjQSgGU0aRzu9KlxWNNy6VRUPBiCVq2BzEMOmcDwOVgDaWFTszz051Pt3fkBVnqvQtGLFlWYopzaxKwgUl8A2CsSvYcEaDHcFum24CRggMQLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYjQt/ct; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8ad87b2acso34750139f.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473262; x=1714078062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3Jy4pWunk3gIi2kTc2gXOgQDTDQJh8keviaOUz7uIE=;
        b=ZYjQt/ct3cSn6dvp1SKUcDXcgH2FKAR52Q3W2nIGlJJGgaTvC/4zZFVFT2etV6rday
         O5mKZshbjyXK9iXvziVoRcdPICnO38fguID/IFrxhMRrtK603J+pUvfajz3BXmE2UlqE
         1T6pi4HzGsjrprgJBxGgUqc7PnRb0Rzvv0FDNATLKqny6+sZUl+eZzhE5IRZLjbQuRm/
         1mnYhWBVDFhyQzarDCAoP29U/nR+xl/E2HVPstkqsVIFmAGa6MayucaK+p8+dFfJZjsO
         xbl0+Lqqt1DMFHytNbr1JoIickSFBT5IjubMu8NEHI3RXlAJYWz1EUczTZHVt4+OEf6j
         E9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473262; x=1714078062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3Jy4pWunk3gIi2kTc2gXOgQDTDQJh8keviaOUz7uIE=;
        b=QT0TyUj9OKlFitXWf0m5nyyYbOPHYK3Ykza9gxUjHvnGFLwPENLxUtrjoQRb7KtGe0
         A1ASAAtaJusxbXmrJu9h8U9kKE+n3/+LJW50eDuUlkJzJ+jJ69q++wHMeQwa/JIy7EtM
         VA8+ZTvVquyqJGjwLnZ+tJweqlINMZO4S4zbIuuTG7hJuLzEQ+ry+2x7LuXpBHBzVzks
         p6MLzR64nUYaIq3eqddej9ElVHjb/TAAwXbWhZp+Ov0fSMOHjV7rBglybSCvUliFHt9N
         eDsK+ifWNfZGW83+SlHuDh1IC3MqufQN6eSvGpRqDhkF+VKwbkWHRXXbSkmcy775ULVx
         fpPg==
X-Forwarded-Encrypted: i=1; AJvYcCWC3bK/qLN3hoHAVbdPW8mgtcI/LP5fAoluKFCSjBIQxHXTl3xMBiFunTBFghiyfCN69d1Ldp1p+oEi3fcEOOPOTAvXPRk2
X-Gm-Message-State: AOJu0YwoIZlD3j2g/BEh7pskvR0mTCqzfwlCU/VLTdWUkQDFzi19rkg9
	7/uvXRFFUSDZSuRpO2+eEjey8rBvRZ9aO2Blh3FrDOiyWsEeij9M+DR6KNbXevM=
X-Google-Smtp-Source: AGHT+IG8BLSKKt4Z+OUV/Ccbn8w8o09vBKQ7lL5VpQxMYtcdH5yIUGgB0k1msp2eDPQ+0DIyHdZwIw==
X-Received: by 2002:a5e:8b04:0:b0:7da:1911:8a9f with SMTP id g4-20020a5e8b04000000b007da19118a9fmr468131iok.4.1713473262075;
        Thu, 18 Apr 2024 13:47:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638300600b00484948cb8f5sm626998jak.91.2024.04.18.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:47:41 -0700 (PDT)
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
Subject: [PATCH net-next 5/8] net: ipa: make ipa_table_hash_support() a real function
Date: Thu, 18 Apr 2024 15:47:26 -0500
Message-Id: <20240418204729.1952353-6-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240418204729.1952353-1-elder@linaro.org>
References: <20240418204729.1952353-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the exception of ipa_table_hash_support(), nothing defined in
"ipa_table.h" requires the full definition of the IPA structure.

Change that function to be a "real" function rather than an inline,
to avoid requring the IPA structure to be defined.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 8 +++++++-
 drivers/net/ipa/ipa_table.h | 7 ++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index a24ac11b8893d..9b4bb6d3f152a 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2023 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
@@ -161,6 +161,12 @@ ipa_table_mem(struct ipa *ipa, bool filter, bool hashed, bool ipv6)
 	return ipa_mem_find(ipa, mem_id);
 }
 
+/* Return true if hashed tables are supported */
+bool ipa_table_hash_support(struct ipa *ipa)
+{
+	return ipa->version != IPA_VERSION_4_2;
+}
+
 bool ipa_filtered_valid(struct ipa *ipa, u64 filtered)
 {
 	struct device *dev = ipa->dev;
diff --git a/drivers/net/ipa/ipa_table.h b/drivers/net/ipa/ipa_table.h
index 7cc951904bb48..16d4d15df9e9c 100644
--- a/drivers/net/ipa/ipa_table.h
+++ b/drivers/net/ipa/ipa_table.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2022 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 #ifndef _IPA_TABLE_H_
 #define _IPA_TABLE_H_
@@ -23,10 +23,7 @@ bool ipa_filtered_valid(struct ipa *ipa, u64 filtered);
  * ipa_table_hash_support() - Return true if hashed tables are supported
  * @ipa:	IPA pointer
  */
-static inline bool ipa_table_hash_support(struct ipa *ipa)
-{
-	return ipa->version != IPA_VERSION_4_2;
-}
+bool ipa_table_hash_support(struct ipa *ipa);
 
 /**
  * ipa_table_reset() - Reset filter and route tables entries to "none"
-- 
2.40.1


