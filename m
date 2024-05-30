Return-Path: <netdev+bounces-99433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE038D4DBE
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC11A1F218C0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF431482F6;
	Thu, 30 May 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GuxQ7xrz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54160186E2F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078909; cv=none; b=gi7/s3wLuQKPvT7mqRgsvByZm3Vo0ULxvyWQ4eTiYQYq2vNi5dZtlnE00ALR+og2G3geMEksvR2w1fdedAH4BjzcaAyvUqlLLMmKZOOHL6aVKNo6xDQtymwl6nkSZG3Ze4ZNaNtSGmhc8Jv3UBS+Mofv+3hFZzYj0T357TABzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078909; c=relaxed/simple;
	bh=RqN47ZM5bKCA/FGdPPZEAuL99IE1ghaZ06QREC2L+nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UB/JIz9qM/Jn9WI0KgfVMn6krjERehZUHm1UKzyeq6wZlzn/JqRwWD3uI/eo1PTV2lhuqzV8kQ4V9UMijp+GrxJwgi3R+ki9u5A7DdHeGgsDjNbvz2ppyQsvYG6Xk1At09k06WYE7YmpzmRyG0AAAkD+FdELPkN1BrMRQxQ+f14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GuxQ7xrz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F8D83F8E9
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717078899;
	bh=B2vGdF2dGkt21QsIPszG+5j1gbhrGScywHg+DXLmaj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=GuxQ7xrz1nI0Dvkc8cIa3qufBmJFpGHQwIEark+91R7hevP3vvODWrGeZ6cwY2DQ+
	 rod0ErNiU8L1WSEj8xeDLH3qkCSePSCxfJ4DIQR5mSkMvi9gerA4RKJW+ynnrFxFMO
	 aGYofT4Aoq7UGl4c2kO6ABwnMCvSqw1gW+jDcW7VwwF+kQdHLkh7eA0ixUQEarpdyX
	 tj8lGAQ++ot4yYHmnf+bXme3mNR64KxIPmYoWxHnnXR7J6dQXcCzODPcNbLiJjFE5H
	 zc3b00fUNnShTk60em/T7mB791H0+BDmYyWbw4lPs/VtWvlEnUbJqGE9JhvrxLTJMb
	 ii69fxePczU/w==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f621072a44so4805355ad.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 07:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717078898; x=1717683698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2vGdF2dGkt21QsIPszG+5j1gbhrGScywHg+DXLmaj8=;
        b=g361JIE4IImaJ2SR/4y7Kszij/BjKa3VeEGBvwSWxBCYNgYFbx7saQXmC//TIjmgu6
         3RnNi3h0N7TCoj1rDqDq18GJDVbVFS+eNM+qxvo/iGFX8QVtVHB93NdgJIUzlsVA3FQ5
         o8CFqzbGlkJoRRygdUf1Y1BIhDoBLAWpKXcROtGnXo9fhbIsdN74bx0o3k/JNmfQjVFt
         uFxj/maqpbY91UMUPpLZFBBK5aSgKqRuTkMXRWOfJqw0vZYtyWgyYZP2GDYIOnjKyEet
         q8yhqwYY0isc13TzSltCRNhkAk/0EGuAS/5pkuRrx9NlTb30N8t4O3aS1w0ZdSWpWivD
         yxOA==
X-Forwarded-Encrypted: i=1; AJvYcCVQvvWdwzLef/c6CQFxf0YAYzv9V74XFWSJTl5T9g9ViZlUp5hkEbxOOYqWZ0Tpa9otMtjpEr35QCBKreF4DRGqilyfxvnY
X-Gm-Message-State: AOJu0Yy80jSLUL7PoCPAXRbHJtFI+U43EYjL8mqAO5qDSBj6f3oa6nQb
	mkHbL9mukEDJX7htFcUmcVkbPAFYa1m6lIfG52x3y/apX1fDpRQh+XxujZZrNGmYyzn6KsNRZPq
	SGOwo+ddQF2ZJO+9RoU+Vj76rVxS4E9SrTdF9pjwM+trehT4Ov8oOeVftsxwt/TvYEZeX8g==
X-Received: by 2002:a17:903:234f:b0:1f4:6252:dba9 with SMTP id d9443c01a7336-1f6192ed35bmr21911605ad.9.1717078897718;
        Thu, 30 May 2024 07:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj4WhAEo6jH3/j42l91y2guETPciufxMGGZdNuOrkvNj5+sjOxoLTEayUXIdr7icIln7gdog==
X-Received: by 2002:a17:903:234f:b0:1f4:6252:dba9 with SMTP id d9443c01a7336-1f6192ed35bmr21911375ad.9.1717078897341;
        Thu, 30 May 2024 07:21:37 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. ([150.116.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967cd2sm118577925ad.166.2024.05.30.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:21:37 -0700 (PDT)
From: Ricky Wu <en-wei.wu@canonical.com>
To: jesse.brandeburg@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rickywu0421@gmail.com,
	en-wei.wu@canonical.com,
	wojciech.drewek@intel.com,
	michal.swiatkowski@linux.intel.com,
	pmenzel@molgen.mpg.de,
	Cyrus Lien <cyrus.lien@canonical.com>
Subject: [PATCH net,v2] ice: avoid IRQ collision to fix init failure on ACPI S3 resume
Date: Thu, 30 May 2024 22:21:31 +0800
Message-ID: <20240530142131.26741-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bug in https://bugzilla.kernel.org/show_bug.cgi?id=218906 describes
that irdma would break and report hardware initialization failed after
suspend/resume with Intel E810 NIC (tested on 6.9.0-rc5).

The problem is caused due to the collision between the irq numbers
requested in irdma and the irq numbers requested in other drivers
after suspend/resume.

The irq numbers used by irdma are derived from ice's ice_pf->msix_entries
which stores mappings between MSI-X index and Linux interrupt number.
It's supposed to be cleaned up when suspend and rebuilt in resume but
it's not, causing irdma using the old irq numbers stored in the old
ice_pf->msix_entries to request_irq() when resume. And eventually
collide with other drivers.

This patch fixes this problem. On suspend, we call ice_deinit_rdma() to
clean up the ice_pf->msix_entries (and free the MSI-X vectors used by
irdma if we've dynamically allocated them). On resume, we call
ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
MSI-X vectors if we would like to dynamically allocate them).

Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
Tested-by: Cyrus Lien <cyrus.lien@canonical.com>
Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
---
Changes in v2:
- Change title
- Add Fixes and Tested-by tags
- Fix typo
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..ec3cbadaa162 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5544,7 +5544,7 @@ static int ice_suspend(struct device *dev)
 	 */
 	disabled = ice_service_task_stop(pf);
 
-	ice_unplug_aux_dev(pf);
+	ice_deinit_rdma(pf);
 
 	/* Already suspended?, then there is nothing to do */
 	if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
@@ -5624,6 +5624,10 @@ static int ice_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
 
+	ret = ice_init_rdma(pf);
+	if (ret)
+		dev_err(dev, "Reinitialize RDMA during resume failed: %d\n", ret);
+
 	clear_bit(ICE_DOWN, pf->state);
 	/* Now perform PF reset and rebuild */
 	reset_type = ICE_RESET_PFR;
-- 
2.43.0


