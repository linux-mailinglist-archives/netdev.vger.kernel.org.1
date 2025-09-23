Return-Path: <netdev+bounces-225553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E249B95529
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62821188CA77
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA948320CB5;
	Tue, 23 Sep 2025 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AuyQqYXO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5028850B
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621016; cv=none; b=cFkI4LjI0MpHDGWp1H3yT+gjN8l0t2tyFKeHo1b3Q4RYZpKoMg2UinsAoy20+MChHfQbTbEHIT6kVp+tPA2baO1P0yQCKHX+Jg5gtozTeqOh+iDzbyj8K6JsYp5/zu179SUso6zqlFNholrLFtEO1DBKyZJLVgo/UYs1J/gd0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621016; c=relaxed/simple;
	bh=TOIzxHnD8azJMyks8dj+0Bgw7zq9WIFh1IqTUTQHvnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqYMiSQRFbPaC/yUfv6qSOzpwfLvoYDdwkRoParSycdmNxXfzV0k9Z5p5VOTEjMTXBAYlWF/nxWXMqJCfoRy9V3yoH/ngyknjA87hzCFyL2bHVnaQmUm4eVdVneAcOg+XOedDCilq1VWJf2yboa8txL4IgXZF+2VYXayT+wAYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AuyQqYXO; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4b5eee40cc0so53042851cf.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621014; x=1759225814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8ahRD5h4PIIPw1I1TySZWohjvVeAAasu3oQp+8Rxc8=;
        b=lEs2s/Pj8n2AsuRXE3277lKQr7rO7nfBLkgMH0a4eZKfTKBKCeGbfAdZeKxLTefGE1
         N5mvDquvIDrrYEEk9DoJ1xybKsHectndIzStxJlKSbLbeF1o2k4sG5COdO64DfcS1OpZ
         0NWjv4MqlF4fj4WyxHpznWaJW+GTwoYU8wRvwfmI5YjZIRuJC0jn25KO89qYtKwLJreW
         IFpZ5IuzdCd0srM9AW+g9vtbaKkcnpCdNNM7GmVofiRqb2lPKbzeR+JBB9Go+SJQgkkX
         7bc5MWAD5cZuaP0eaiwEw5m3bVay6BV2qTpmZCUJbTsxlpgiCg49dDwnh/MMXAZ4RaFX
         EZyw==
X-Forwarded-Encrypted: i=1; AJvYcCVIjxH6QaTG6UjPrHiPZJrEIFpAHs6l9iCu6/ZfOn0HGNmiqZmjSlalGtRlmrjYP5Y8p3/rFPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqQQsN873MKafq+geplZL1iblgaIZqAk5kCds19v5EhTlP4lr
	l90oghuN7J8/Uw7y7/vrYxeQOFJ9V/mjZ/3pFqoPFImI4SIllCcWMsq4pHEV0N51FLtXJHH5CiD
	AMwhJB+Hqu9zWBOwEMUfMLI/Jds4kQ1PIElY2JMxNiBvPDnHwVRrGjvq+Sc3krgknQZxtaRYPIE
	CIg940KOaKKDmgxAAhPT/DPI9+v+B/iFvKmil3OUoi4k4NsWh4/acocBNZSe3gvbxVejm28KxiN
	y1E5AOHwvE=
X-Gm-Gg: ASbGncubME7DfxNikP1lgZwBdsv811vzf9JYkTBvd98Z4R6zB5nTIYOvLmXBtwcePOY
	NbP8NJWySwTvrNNe7z2wIpFeo3RbhBn29wsBG4WBJadTWuSMrrcfixrpt8woBYHkYK+wtwgGqdC
	HzsYmG+AO2reR5EAlFKt8XWtQNh+5YRBCyzgS6xjjRbZt5njjt+a38HiveZ6whHrGpgolRg9sog
	b7ZbK6q3EBHG4vVGpfOQBpXYxzYONv3NooVw/g9/R2wfa+Y3skEF2QHBC/McJNTCTU7ffjw4ShC
	1rqe80EBfSE0yVUdxpgS9cqzb6+wT33y/ffOzncYp14NRgRAeio1jnQ4R+/7Wxa1+ombiak+rvO
	nE4WIoEL/Khn4Gcw9joHmEhJBA/uEu4ypZcoArmqgpMK7ea+bxeL8gQdcvZif8sjIim380tIOBd
	FtLQ==
X-Google-Smtp-Source: AGHT+IEXffx+m/hS7Lp3Tcr7HICsUU+cjjK9/tKWXsAFY7i1HUHXzqPrWbLjM3pGDu63dyI1Nwr0BF2Ov+Zl
X-Received: by 2002:a05:622a:a949:20b0:4d6:5c76:43a7 with SMTP id d75a77b69052e-4d65c76489cmr490501cf.66.1758621014037;
        Tue, 23 Sep 2025 02:50:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4d00f2cb812sm1518791cf.13.2025.09.23.02.50.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:50:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54df707c1cso3276781a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758621013; x=1759225813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8ahRD5h4PIIPw1I1TySZWohjvVeAAasu3oQp+8Rxc8=;
        b=AuyQqYXO2mkYd7DHGmu2vKYLAdV9k6DWg1UGDo7tTXS9AnkY5Vp2IDvK0VD6tj6eai
         vrWNALwQWUMiz7rAPN5mhVuJDk2pfpojjS75uT44ylEszfkedOePcGwW9LwvKdPWWj+R
         NYbpq+owZI9pJIZxVade/OOIZr3TBGxrpao7U=
X-Forwarded-Encrypted: i=1; AJvYcCVmHwEvy1/M1uKFujM00t3hxIU/aq1Gz/fDyalvpK1u92bg98JrkehfBm4d45Pju7uXH4ebEwc=@vger.kernel.org
X-Received: by 2002:a17:902:ec83:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-27cc28bed7fmr28836285ad.2.1758621012785;
        Tue, 23 Sep 2025 02:50:12 -0700 (PDT)
X-Received: by 2002:a17:902:ec83:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-27cc28bed7fmr28835945ad.2.1758621012290;
        Tue, 23 Sep 2025 02:50:12 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269a75d63eesm139105945ad.100.2025.09.23.02.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:50:11 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: jgg@ziepe.ca,
	michael.chan@broadcom.com
Cc: dave.jiang@intel.com,
	saeedm@nvidia.com,
	Jonathan.Cameron@huawei.com,
	davem@davemloft.net,
	corbet@lwn.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	selvin.xavier@broadcom.com,
	leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 6/6] bnxt_fwctl: Add documentation entries
Date: Tue, 23 Sep 2025 02:58:25 -0700
Message-Id: <20250923095825.901529-7-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add bnxt_fwctl to the driver and fwctl documentation pages.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 .../userspace-api/fwctl/bnxt_fwctl.rst        | 27 +++++++++++++++++++
 Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 3 files changed, 29 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst

diff --git a/Documentation/userspace-api/fwctl/bnxt_fwctl.rst b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
new file mode 100644
index 000000000000..78f24004af02
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+fwctl bnxt driver
+================
+
+:Author: Pavan Chebbi
+
+Overview
+========
+
+BNXT driver makes a fwctl service available through an auxiliary_device.
+The bnxt_fwctl driver binds to this device and registers itself with the
+fwctl subsystem.
+
+The bnxt_fwctl driver is agnostic to the device firmware internals. It
+uses the ULP conduit provided by bnxt to send requests (HWRM commands)
+to firmware.
+
+bnxt_fwctl User API
+==================
+
+Each RPC request contains a message request structure (HWRM input) its,
+legth, optional request timeout, and dma buffers' information if the
+command needs any DMA. The request is then put together with the request
+data and sent through bnxt's message queue to the firmware, and the results
+are returned to the caller.
diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
index a74eab8d14c6..e9f345797ca0 100644
--- a/Documentation/userspace-api/fwctl/fwctl.rst
+++ b/Documentation/userspace-api/fwctl/fwctl.rst
@@ -151,6 +151,7 @@ fwctl User API
 .. kernel-doc:: include/uapi/fwctl/fwctl.h
 .. kernel-doc:: include/uapi/fwctl/mlx5.h
 .. kernel-doc:: include/uapi/fwctl/pds.h
+.. kernel-doc:: include/uapi/fwctl/bnxt.h
 
 sysfs Class
 -----------
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
index 316ac456ad3b..c0630d27afeb 100644
--- a/Documentation/userspace-api/fwctl/index.rst
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -12,3 +12,4 @@ to securely construct and execute RPCs inside device firmware.
    fwctl
    fwctl-cxl
    pds_fwctl
+   bnxt_fwctl
-- 
2.39.1


