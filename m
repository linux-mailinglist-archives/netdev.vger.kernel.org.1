Return-Path: <netdev+bounces-88513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0268A7862
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 01:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914F51C20DCA
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCC413B2A9;
	Tue, 16 Apr 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaQfxPDK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674413AA48
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309036; cv=none; b=sMTpfqtkJUNrGwugl7mTgUKAbn1be+dyy7PRxTFcUf8ffvprcQ0wU4lv+Jxz/R7FN6CGMrW0yZddpnFsGK3/h8GVlSJ4bY8+vMsDce7/wJ01qf0b4n4kdjp1Ojj1Xocr9/z27cZD3tiqCVTNkxDCzzYjMrQCVPe9OH7vklpgPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309036; c=relaxed/simple;
	bh=pDIFH5Nui80QB/OsE0XuG8atQ/4Ispy93r0OYG5EBAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7D1EWup+JRPHOEpCHsYgBem0gZ0wlZBM320igzk502v1DdoRJfhhaB7LTZssLIVy8iWF3hVLRy7Iu2t4t6f+8kBDJPBqCQ08K9bdpUaaNER6rmoY1AQ6sJQ+IkelZs/fJmWn4l2PEUhUa1AQyCyRZDca/qODLNwEtdytaHmIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AaQfxPDK; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d95f2a2dfaso136647539f.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713309034; x=1713913834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/czbVFltjLc3JL/OguNyYjQSM1WrT0Zhxvso4G7Tfg=;
        b=AaQfxPDK53QmvXrL/4rh5ulWnvCvOYz5emGJ/ZwcJFWk5HY0RF4nUjtDhzMVP7XXCE
         aNzDLRKmlLV5m3/Oz07QCAANiZxolA8PVfjZ7fYIF7MMVBejY2/uDZzcZA0VqCSljFBF
         pw8n9QbeFUEBPolKYwAKvbxwIExrbUK5LgvfegUm6ZWNNU5kbrWFBWuRnS5T2wZUk1sy
         tuvqPCTbEI6jhB6Lso95XoaRiXMwxCXXbwTDC6r02wjuVT0Gy0wMvY6QsFv+zRnc4I8l
         FoRgd/RhyhKNLUKp87rIs4mWqV3pEBBfRLhx1UvZIudSSioQTOk+645Wgbn6iEKMj4Tp
         HHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309034; x=1713913834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/czbVFltjLc3JL/OguNyYjQSM1WrT0Zhxvso4G7Tfg=;
        b=w7iAdA9bW3rvWKeAPTJV36CmYnYpTCokT9mjcD69/Ncgx3M9g1/RwQGQDC309oTeHs
         RDWOCwEEro0Le3z5xZX+hWPBTILbyk0cS21LPtHtp36xgbycbvZIU2dxsXm41ZFKrAbI
         4LK/ySzKsFBaLoThGpEVbgSlW9Z1lJ+qEZ1/YxQoWPRHkfkDBbxSnVJo7rzZdaDKvgOo
         4+KKQcRU0gLCwPsr/4e4S8c+hmCrbYNuIl5Yi7ykTE8bsg4tHOG+dqGU5EgBWVQxu5YY
         8Cpd2vbjmzPhVMLHNvCm3cp055/qdANh1IVHFtsTbJJopDejR2+lbj/2dS8fM/Qsi9FT
         5A+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4uieLvG2ML16a+rCfCUREPrPFd42ZWE05aZJaQcSJ/i5eEz2lB3WfoktTbmkfqbGjPA2n4swsrrEBCccE05ANSFF0tLXZ
X-Gm-Message-State: AOJu0YxtrYI8s5QfE67YXQEejvnmoVxNfK/eid2kM72ByR4Jd2CAy8rS
	DR6QjQ2azaVRtL8JkvrW8c/Wpl7MBMXOGD3mkw55/d6JrDzGVTz/NYaQls2qHnk=
X-Google-Smtp-Source: AGHT+IFXSJ/9AZsIhFKLj06UwIx2tCWr8NjdqezkaAjB9TulX7fLK0pC/miXkM46bt9+p2xOr443mQ==
X-Received: by 2002:a05:6602:4990:b0:7d5:e78b:fd1d with SMTP id eg16-20020a056602499000b007d5e78bfd1dmr18320154iob.6.1713309033993;
        Tue, 16 Apr 2024 16:10:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id le9-20020a056638960900b004846ed9fcb1sm372170jab.101.2024.04.16.16.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:10:33 -0700 (PDT)
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
Subject: [PATCH net-next 3/7] net: ipa: include "ipa_interrupt.h" where needed
Date: Tue, 16 Apr 2024 18:10:14 -0500
Message-Id: <20240416231018.389520-4-elder@linaro.org>
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

The IPA structure contains an ipa_interrupt structure pointer, and
that structure is declared in "ipa.h".  There is no need to include
"ipa_interrupt.h" in that header file.

Instead, include "ipa_interrupt.h" in the three source files (in
addition to "ipa_main.c") that actually use the functions that are
declared there.

Similarly, three files use symbols defined in "ipa_reg.h" but do not
include that file; include it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa.h          | 1 -
 drivers/net/ipa/ipa_cmd.c      | 1 +
 drivers/net/ipa/ipa_endpoint.c | 2 ++
 drivers/net/ipa/ipa_power.c    | 3 ++-
 drivers/net/ipa/ipa_uc.c       | 4 +++-
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa.h b/drivers/net/ipa/ipa.h
index 968175019a5e3..cdfd579af5b94 100644
--- a/drivers/net/ipa/ipa.h
+++ b/drivers/net/ipa/ipa.h
@@ -14,7 +14,6 @@
 #include "ipa_mem.h"
 #include "ipa_qmi.h"
 #include "ipa_endpoint.h"
-#include "ipa_interrupt.h"
 
 struct clk;
 struct icc_path;
diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index 2e7762171e480..969b93fe5c495 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -14,6 +14,7 @@
 #include "gsi_trans.h"
 #include "ipa.h"
 #include "ipa_endpoint.h"
+#include "ipa_reg.h"
 #include "ipa_table.h"
 #include "ipa_cmd.h"
 #include "ipa_mem.h"
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 4e8849c1f32d9..8284b0a1178c3 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -19,9 +19,11 @@
 #include "ipa_cmd.h"
 #include "ipa_mem.h"
 #include "ipa_modem.h"
+#include "ipa_reg.h"
 #include "ipa_table.h"
 #include "ipa_gsi.h"
 #include "ipa_power.h"
+#include "ipa_interrupt.h"
 
 /* Hardware is told about receive buffers once a "batch" has been queued */
 #define IPA_REPLENISH_BATCH	16		/* Must be non-zero */
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 41ca7ef5e20fc..42d728f08c930 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 #include <linux/clk.h>
@@ -15,6 +15,7 @@
 
 #include "ipa.h"
 #include "ipa_power.h"
+#include "ipa_interrupt.h"
 #include "ipa_endpoint.h"
 #include "ipa_modem.h"
 #include "ipa_data.h"
diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index bfd5dc6dab432..17352f21d5f87 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
@@ -10,8 +10,10 @@
 #include <linux/pm_runtime.h>
 
 #include "ipa.h"
+#include "ipa_reg.h"
 #include "ipa_uc.h"
 #include "ipa_power.h"
+#include "ipa_interrupt.h"
 
 /**
  * DOC:  The IPA embedded microcontroller
-- 
2.40.1


