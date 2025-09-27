Return-Path: <netdev+bounces-226881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D45BA5C76
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2CF1B21910
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2527F2D5C8B;
	Sat, 27 Sep 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fqmTYUJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C65283FF0
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965604; cv=none; b=AwW74RWWLRZSP/vrJp2e5VUZ7u5Wk5/tCCUtoCShOv6uk37aKq4gqUQHdJiBqtA/C2zxN7HvrYXWA38J5Dp1JaECUzv/L0qJAYSJQpr9aApApibPlUm74j+bdG010scmQKKd5ETK5RnIBiIYaQcvybO37W4ig2VqPN8Ab9zD4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965604; c=relaxed/simple;
	bh=Gww0sVZuLcq6Q4gChl5SQLZo5TRoUXgPnFtlZrXpn/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onhnPW3NRFnSSL+agus8v7PGcExcAj67L5zHOwEpmhY0QxGBckrwHc8lRbM9GhHZxJTYJjXcevm7ggT9nTkB/a2LxlizI0orYea7tjuInl2OrbBLqxpTEkbTeOVTW7GiR0qbcxjOaH/Pw5Z1/f0pwu93UXc8qSgmI7sGp6uQgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fqmTYUJv; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3352018e050so2412351a91.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965601; x=1759570401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3G0XyljyRUSkwB9ChatPpegoOeqG70xuyfwuuJZ0lc=;
        b=rP7lZxfyIRDOAx7Q4gE0wqvjcS1uGq997qK8Tj5l59i5zPcbS8TDAZL3lEsA32O3vl
         lDmDd7j8a8TJQGz4H1rib9RDMhJl0q2BrVLta6KeKFQxvEKHJWJ/Cd6y6OYp5BavgiOs
         jPXHu+bj6l6QX/lumTw5Ed/L9EWcqIJlAz1h/0KQLEjBtrE04Orfe42IFqsWIyBbfdSN
         5kLgpSyiY2CSnGvExM9u50tPs06V89XQCQtYE1k5twtWHXNnm39o9kC+khCSopjSQhWv
         Fdt5At8t9a8KO/4zRsOszzJdBd3znPF2xeA1I6Q+EzxJZvRGJl0OfR9tjmBhIPpYHwjq
         Ofrg==
X-Forwarded-Encrypted: i=1; AJvYcCU/R9wkOsdOBZr3mHCoobTd36RZ5XgAh8PUDtxPsWH66xNkulqjnvNlV8ip918ZnnRBNTFPUx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyawB96T+Tet2QZd3s29lvmsAGP1tyKcko28J3fFkT8cJmWe7Vm
	Cc5K7e35njoY8VOD0zKapaZwW5xQWZgIwm46d6ieTC3E1BEOUZdR2penWUU8jar8cEl/M9aj43P
	FWP1BxacMw2a7J0v76+g2R3Cuowir0+jF8KpMmj3LW/1ntPJZZvsj/ozxswYJpp+0fBmB1xma1r
	iay+qtw1M9X2b40UwES9pYda9oHwZC49heC2QlxugduZdgGPY+9P0jHjFYEJVNSSYMyG06brqAa
	lxnCsWWX1LuOg==
X-Gm-Gg: ASbGncvK0Fx2KiCO3ijahLhx0I9QcTQWeq6oB3s0BY/KifRZuolFUSfLpEEoDkPM7ia
	V943O4OVBmxks+FQSe0ahX47KYJ1eil6CF2vs1Hhrt93l3UAery+EFGf1hL6KW64mM1/ej8FIGD
	67T5S1nJm+b0uxqG8e8ei6WdhRhbmqNnV+RBclzI0pJvUGdY8tw2aOLQC7sXvDwsfcyJyGLr/WQ
	JVHhiLbeW65ivIx6ggNcG3gGOPDmPaZXY6fbBAbgDaFy/M/WQIDPidJL1I/kjxQ5fEEQbdcgbDY
	BB4GzEBhksT2zhJ+1jgqCA17do2n1bbVveh6BFAe1gCRaq8REDLqCBG56VawyYa3KDq/f08OKRy
	HhwFSyA6+MLmXhdPqqWvF1lVoB/RWm6fq8jPCBxX4k8LKk0Es5IXbpdddDpGanyJaUagEDPPygo
	y1Vw==
X-Google-Smtp-Source: AGHT+IEhNQXe/Gj3dJxT6spGf0ebFfzWZRjBcSjLXqtNSgpnFeuxv3TLgolmsf6mOh23PP/ktgab4RTsErSk
X-Received: by 2002:a17:90a:da84:b0:32b:355a:9de with SMTP id 98e67ed59e1d1-3342a2f0152mr9948867a91.32.1758965600808;
        Sat, 27 Sep 2025 02:33:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3346d96a701sm424378a91.0.2025.09.27.02.33.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2025 02:33:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7811e063dceso1019134b3a.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758965599; x=1759570399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3G0XyljyRUSkwB9ChatPpegoOeqG70xuyfwuuJZ0lc=;
        b=fqmTYUJvbNbeIsbXjG9OVUq6eEexfs30APQ8inV96tTO9Xe/aNelLTH2yhMIYlarwJ
         nKC86LtS0Em/aL7PHDYH18mYsD6W6s4ixyymkL5g2tYfdjNgOc4aDBQ+QOzvStKOQhHO
         rov9xmjb+q9aGjjqUHmpOU0WJs5SalxYYnEIM=
X-Forwarded-Encrypted: i=1; AJvYcCV62Lmnlj92+/jkTFsQTuOYHkaB8W1p/T1zNiUvIWiaHqfJrclfbkzKsIXT0xolD+g6qBpG/GU=@vger.kernel.org
X-Received: by 2002:a05:6a00:2e89:b0:782:2f62:7059 with SMTP id d2e1a72fcca58-7822f628144mr356115b3a.22.1758965599018;
        Sat, 27 Sep 2025 02:33:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e89:b0:782:2f62:7059 with SMTP id d2e1a72fcca58-7822f628144mr356087b3a.22.1758965598594;
        Sat, 27 Sep 2025 02:33:18 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm6109940b3a.14.2025.09.27.02.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:33:18 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/5] bnxt_fwctl: Add documentation entries
Date: Sat, 27 Sep 2025 02:39:30 -0700
Message-Id: <20250927093930.552191-6-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
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
 .../userspace-api/fwctl/bnxt_fwctl.rst        | 78 +++++++++++++++++++
 Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst

diff --git a/Documentation/userspace-api/fwctl/bnxt_fwctl.rst b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
new file mode 100644
index 000000000000..7cf2b65ea34b
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+fwctl bnxt driver
+=================
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
+uses the Upper Layer Protocol (ULP) conduit provided by bnxt to send
+HardWare Resource Manager (HWRM) commands to firmware.
+
+These commands can query or change firmware driven device configurations
+and read/write registers that are useful for debugging.
+
+bnxt_fwctl User API
+===================
+
+Each RPC request contains a message request structure (HWRM input),
+its length, optional request timeout, and dma buffers' information
+if the command needs any DMA. The request is then put together with
+the request data and sent through bnxt's message queue to the firmware,
+and the results are returned to the caller.
+
+A typical user application can send a FWCTL_INFO command using ioctl()
+to discover bnxt_fwctl's RPC capabilities as shown below:
+
+        ioctl(fd, FWCTL_INFO, &fwctl_info_msg);
+
+where fwctl_info_msg (of type struct fwctl_info) describes bnxt_info_msg
+(of type struct fwctl_info_bnxt) as shown below:
+
+        size = sizeof(fwctl_info_msg);
+        flags = 0;
+        device_data_len = sizeof(bnxt_info_msg);
+        out_device_data = (__aligned_u64)&bnxt_info_msg;
+
+The uctx_caps of bnxt_info_msg represents the capabilities as described
+in fwctl_bnxt_commands of include/uapi/fwctl/bnxt.h
+
+The FW RPC itself, FWCTL_RPC can be sent using ioctl() as:
+
+        ioctl(fd, FWCTL_RPC, &fwctl_rpc_msg);
+
+where fwctl_rpc_msg (of type struct fwctl_rpc) encapsulates fwctl_rpc_bnxt
+(see bnxt_rpc_msg below). fwctl_rpc_bnxt members are set up as per the
+requirements of specific HWRM commands described in include/linux/bnxt/hsi.h.
+An example for HWRM_VER_GET is shown below:
+
+        struct fwctl_rpc_bnxt bnxt_rpc_msg;
+        struct hwrm_ver_get_output resp;
+        struct fwctl_rpc fwctl_rpc_msg;
+        struct hwrm_ver_get_input req;
+
+        req.req_type = HWRM_VER_GET;
+        req.hwrm_intf_maj = HWRM_VERSION_MAJOR;
+        req.hwrm_intf_min = HWRM_VERSION_MINOR;
+        req.hwrm_intf_upd = HWRM_VERSION_UPDATE;
+        req.cmpl_ring = -1;
+        req.target_id = -1;
+
+        bnxt_rpc_msg.req_len = sizeof(req);
+        bnxt_rpc_msg.num_dma = 0;
+        bnxt_rpc_msg.req = (__aligned_u64)&req;
+
+        fwctl_rpc_msg.size = sizeof(fwctl_rpc_msg);
+        fwctl_rpc_msg.scope = FWCTL_RPC_DEBUG_READ_ONLY;
+        fwctl_rpc_msg.in_len = sizeof(bnxt_rpc_msg) + sizeof(req);
+        fwctl_rpc_msg.out_len = sizeof(resp);
+        fwctl_rpc_msg.in = (__aligned_u64)&bnxt_rpc_msg;
+        fwctl_rpc_msg.out = (__aligned_u64)&resp;
diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
index a74eab8d14c6..826817bfd54d 100644
--- a/Documentation/userspace-api/fwctl/fwctl.rst
+++ b/Documentation/userspace-api/fwctl/fwctl.rst
@@ -148,6 +148,7 @@ area resulting in clashes will be resolved in favour of a kernel implementation.
 fwctl User API
 ==============
 
+.. kernel-doc:: include/uapi/fwctl/bnxt.h
 .. kernel-doc:: include/uapi/fwctl/fwctl.h
 .. kernel-doc:: include/uapi/fwctl/mlx5.h
 .. kernel-doc:: include/uapi/fwctl/pds.h
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
index 316ac456ad3b..8062f7629654 100644
--- a/Documentation/userspace-api/fwctl/index.rst
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -10,5 +10,6 @@ to securely construct and execute RPCs inside device firmware.
    :maxdepth: 1
 
    fwctl
+   bnxt_fwctl
    fwctl-cxl
    pds_fwctl
-- 
2.39.1


