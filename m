Return-Path: <netdev+bounces-225166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62295B8FACD
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB0189A206
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAB155326;
	Mon, 22 Sep 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AdGLfreK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01A271443
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531702; cv=none; b=MrtsETMjaCRFE2QOH1X04hOxTBqDshu54VvsQEjJ7VVeCN9JLcyY63AjYDOGsUy9hZpB8NXH9GNDA+hG/GtSAO+1EyspL/L2cI3iuO+LBvcP9KdeJn/VEy43fy2Xk/u3ZMZyDAgjEx059Ws2JEO1BEg2PfNgn25Z5JOe9bY2f8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531702; c=relaxed/simple;
	bh=TOIzxHnD8azJMyks8dj+0Bgw7zq9WIFh1IqTUTQHvnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMKWGMPF5+0SjI9CGIvWiuyY5/7Qo1ytbBJbAY67mo5raIZ8NBtaFAjJg9Bg+rl8sWosm3ucU86WKLn1y+M2D+rbBlNU3mPkdN57sXG9xB6Die/cqf9fxVEb3SFoVXfhcA2x6XXNjn1nFNJNfZoLdIEEWf5l016tuNzN2dCPjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AdGLfreK; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-74f6974175dso6083857b3.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531700; x=1759136500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8ahRD5h4PIIPw1I1TySZWohjvVeAAasu3oQp+8Rxc8=;
        b=whQC0g+B7hHdCOCi3oKqFiQzOZUywTyf7KMy/oF4Ge+4QWmhIkHqruh9fLQL1FuvIL
         ik/pUR5vRKKqr0vQvqBP6MWC25KHG4ZOVEHZvb/zc277n9djNTdtKqjjyGRaXTicgXvB
         C4F1tg8KsZMutr5ICCMMWiK2tN+5ToUTZRcEeEIj94XiOSkNM0+Cfh55ex7QADyOmHSx
         v4/KjwucLgR7HrgJhyHYBdeGYzYKYnOL0scEv74mLnOlBNeiruYtU2TEO2HVd4oXara9
         ISJDfD6G/rvc+OV5ODDC9AJ2HgkTxSUb/uC7mVek9j7Mp07hVTog/cLq9u818tX1ildI
         6Ifw==
X-Forwarded-Encrypted: i=1; AJvYcCU/UhE517P2GxVvoOBRDPnl6hEv+naTEIAsvXUotcZOWY5uw+we1Q3SyTe5ZdSLI7x/PUYhNUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMjab5i7mA1AaJe0lBqC7mLTZ2RoBlO8Ewb0e7hR/o7dwSzDM
	fJl3Nwk2dr6XtGC8KaT7obOQUtUVh7kY9mzpYX7TeFcj68BeUxSG92JfXed+j5sWxmlHXagLXVv
	Fe5Et5z5ZLlLmMCyLyDh66Zeb4INDwBxG6i4ysR7tistJDsutEUJKv5tetG7LnjsAn63vJrgrQc
	M4ZjmQF+ic5OnWwBRR1e0ajQPebRICXjHWrLXtcJYZzeNpWBxLOOitvceSxLbV2ZjCTR0IzBQvy
	wZChRdhkQk=
X-Gm-Gg: ASbGncui2DAOH54Ks+/+VQppoQDS1nj5sZR4cH6SMm4DfkP4r/pzFbXmBsnmBbzVa75
	NhSNF/k4nBPOzEL6sc4et3wf/8ut5nlgeDYQAAysvPMsNNsrW0NI/88jb8/XjIZzS+9KxllLrTK
	BCCPe7tbbm08Q3gMAlRXiAETwA/Da0JLmuWAhjEB0KN0ThXsggQ2Rhb4RB4e2qhV/2GrjIrWxMW
	GFtlw9qH1rIMkb4diDExnqAQkAx2LztWyXLZlZrKNfq1zWJz44CPanIzsyv4Ue8N7WnaaMqAdhj
	DaqBPtaB89KFMfcv3WZ4zs7fibxJBxD25necatbP87sZjQaS4AgQwvC5QC5E9mJj3d1XNS5uBpb
	NtR5CJmG71oRnman0DavNI70id7WML7XL5ou3v9Rh5jfMG2Rivb+jIpAZQoRs3hvG7qFltKz+HI
	NBWw==
X-Google-Smtp-Source: AGHT+IGpYdu+Xyr6WlZq2pEM+8bxksU/Ksgfsl2uk0SibJm9+qAxwwVEanFatXgmVp7yv6rk0U+k7OW2N/ae
X-Received: by 2002:a05:690e:249b:b0:628:df16:3193 with SMTP id 956f58d0204a3-6347f5512bemr7035771d50.24.1758531699824;
        Mon, 22 Sep 2025 02:01:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-ea5ce864190sm564725276.18.2025.09.22.02.01.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:01:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25d21fddb85so74205075ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758531692; x=1759136492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8ahRD5h4PIIPw1I1TySZWohjvVeAAasu3oQp+8Rxc8=;
        b=AdGLfreKXbXWCF7BYhtQpaY2gtx5gmYes3ASmL3+QGRA1I661om8nuPdhTAuDARgy6
         LWZaw+7OR8i/G9S+k0C/UCDVvjgbVMWJgDhyZEbVMSmvl+Vj9veMJsrQfJHQqjGwA5Xj
         b4XOZRS5aIf45j2rJrj+UKAYTL8h3/1m6Ceis=
X-Forwarded-Encrypted: i=1; AJvYcCVtvemXq2pz7K27xkIZTy4Oooz3Czk4KeRdlfMGX85sSappYovYyfD8i1CWrX+FI6k+8lwabRI=@vger.kernel.org
X-Received: by 2002:a17:903:f86:b0:267:16ec:390 with SMTP id d9443c01a7336-269ba447e48mr178283585ad.17.1758531692022;
        Mon, 22 Sep 2025 02:01:32 -0700 (PDT)
X-Received: by 2002:a17:903:f86:b0:267:16ec:390 with SMTP id d9443c01a7336-269ba447e48mr178282805ad.17.1758531691477;
        Mon, 22 Sep 2025 02:01:31 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803416a2sm123309615ad.134.2025.09.22.02.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:01:31 -0700 (PDT)
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
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 6/6] bnxt_fwctl: Add documentation entries
Date: Mon, 22 Sep 2025 02:08:51 -0700
Message-Id: <20250922090851.719913-7-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
References: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
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


