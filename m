Return-Path: <netdev+bounces-226619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500FBA3053
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060C9386FD9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB829ACC6;
	Fri, 26 Sep 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P1YbjCvQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE229AB03
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876710; cv=none; b=RPVB7Uotzwoi+dKjX0dVeLB/sBHWXvgh/7FTrUGQZAmNcqmoCB75RST/i7H3/IM8PQ/iWMHeag0YzTMLZY+gCtMphJmJMALSZU0EK3dRPdgbXbHFb9vUWJweOLIas5nk8GFeJGm3hbiulcf3L964d+hui1Q1jBKIMnOsys63j4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876710; c=relaxed/simple;
	bh=xQ+jxqijZdrXTEPXNGRO6AYokOzbaATM2PU29F+z53c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMrU7udkjO4X9ouO2ZC/MXUWAmSa4v9TNja00GkvwBPSSIwAwjPXMwMWil93xqkm2B4iuOtlYa2P2zls3IOO/mld/MDzAd89VpiddgZyZq9YNFQX+WXvGp2EcuDh/X+NZJlLfA1RgMsfMg41IbdgFRKD4ezsAQRLP8iBMHsp7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P1YbjCvQ; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4db0b56f6e7so14397721cf.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876708; x=1759481508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuGhGu7mYILdwcyzy2nKqwyZ3T5V3ZZNSNmYryYdH6s=;
        b=mKsYNPaHO5NuSHYGWt+oBYTEVA4J/rXD9RCsU6mFImTfwiMxw68OPhpfgF2qsEIODy
         XEnkYHiyU3Wb1qIBSqc93g1NqBGozEFbYQx3wB3s7YaKevKre8ws2LtuvW7OhSszahZe
         /BGX0jRI+/okWQjkyO4sxysiglw2YJu8DfQxhsx+rVGJexQ/58r+vKNLGN5JDu8hnj7k
         +pULXFHtKrT3t+CA8sYGyVECBdXEPi4SO/pZxxjRtOfWCmi0hATQTJwahuAj0Xo+JCNh
         OrLMnF9kSs+DPWG5qXSwowQH6uYa6rJr56lfUI7C6vx/cD6zbrWDXSnuhMTW1X2RG9a2
         TpfA==
X-Forwarded-Encrypted: i=1; AJvYcCVAbFv0SxW+StuXMONHSuE44Bwm0MmyvyKm+59n5sWVy/Dpcr/bC6ai/OqDYutlVPvU0kXMs5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gzB5fot3FX2IeO/ojzgnEDJ5/RBcuw/SEIT5Yo8wg2vblH3P
	8S6jfOAg9eySXnZ7HMSAoIB7e91BM+3geFph3w+o5ZAcAcwa2Vpdb7A9l3t19jlht8q2Gu6IjOZ
	eCKeBp62oF53KWihRKDTUeqbLZuRp3OySD2E1fxzEKfwZNmjI86is0acmNyHPCFrOTnl98Epha7
	wcl5j1YJAOrQjtB1yRJ0yNMsiOHwUStwVxPCQN6AMagtV9ZBFyxDp6Jf9FFfkS9LfU/JsblXMGF
	1kC9OqS+4w=
X-Gm-Gg: ASbGncuiNUfWKdihiU6iAjmQlpjUWidaMaXriRYsE5jRPf0ObuuiW+BLHOkkcwjkjKd
	hqVP/wVEs0eoYSAdoEw/lhrxXVtDajaxyd2UBgZe1ZnrRbP+Z/i3oEjz8TP0GGoRhs5MTGMBJu5
	Twcp29WD899jO+aIebiGQlGwCWxkz8dTprQCiiNh0M56hWU3SGXv0pfwLPcnELS2hraC3qQ+2L8
	bwOqk5EgxzhUFu/jOnOJmC0CAXmnu9HBUypGjMLFkh0Yt895HVF8/th3yvP26u9k1XzrwTSVyBe
	8OeuRxdjEOaeogQmCx44XNM4uMKNWT6cahfjisqpt6cBSGudRyhhs9sbcDU+4knJmOypLxEbBEO
	0ZQY2k64+INgbTjC7MzsAZAGgTiGHAfByJiBM/kNQOzlPbYkfvifsgECqthMjImz5ibLh2AYXQq
	xMKg==
X-Google-Smtp-Source: AGHT+IEguPmPlJappJMaxSB8DkTv7v3I3eA3hDB4vPFE8qdtClZVUzuOT9abrerE3TH0+Ich1zbJNtqJlcED
X-Received: by 2002:a05:6214:e6c:b0:78d:1d55:cce0 with SMTP id 6a1803df08f44-8010456578dmr60888056d6.27.1758876708247;
        Fri, 26 Sep 2025 01:51:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8016193d064sm2842156d6.28.2025.09.26.01.51.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:51:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78108268ea3so1289794b3a.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758876707; x=1759481507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuGhGu7mYILdwcyzy2nKqwyZ3T5V3ZZNSNmYryYdH6s=;
        b=P1YbjCvQxNH5C3nTvvp5XBYWh3z907TxbxFR8Ou9W+rMktCr+l8bm0ydK5cDZnzrsZ
         WbOX1Z3Qer1JQZ/A2JSjhUAzMAwBu35MX0/N0VLmJFZuzYbdSCGwhCwX/LU5OuzHMHj3
         /1bhH1+XcVOmGlNuOZN2mK15DFlzRG1N9OYFI=
X-Forwarded-Encrypted: i=1; AJvYcCXqpiiJA7Jxj68Ytz+Eu17N6M6x7dPg2FsDj7j98t7Xjfi2yPyWnTplrLPs36rRfA+KOG+Ov/g=@vger.kernel.org
X-Received: by 2002:a05:6a00:3d11:b0:77e:76df:2705 with SMTP id d2e1a72fcca58-78100faf313mr5961708b3a.7.1758876706961;
        Fri, 26 Sep 2025 01:51:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d11:b0:77e:76df:2705 with SMTP id d2e1a72fcca58-78100faf313mr5961676b3a.7.1758876706508;
        Fri, 26 Sep 2025 01:51:46 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c1203fsm3959896b3a.92.2025.09.26.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:51:46 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/5] bnxt_fwctl: Add documentation entries
Date: Fri, 26 Sep 2025 01:59:11 -0700
Message-Id: <20250926085911.354947-6-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
References: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
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
 .../userspace-api/fwctl/bnxt_fwctl.rst        | 38 +++++++++++++++++++
 Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 3 files changed, 40 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst

diff --git a/Documentation/userspace-api/fwctl/bnxt_fwctl.rst b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
new file mode 100644
index 000000000000..2d7dbe56c622
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
@@ -0,0 +1,38 @@
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
+uses the Upper Layer Protocol (ULP) conduit provided by bnxt to send
+HardWare Resource Manager (HWRM) commands to firmware.
+
+These commands can query or change firmware driven device configurations
+and read/write registers that are useful for debugging.
+
+bnxt_fwctl User API
+==================
+
+Each RPC request contains a message request structure (HWRM input), its
+length, optional request timeout, and dma buffers' information if the
+command needs any DMA. The request is then put together with the request
+data and sent through bnxt's message queue to the firmware, and the results
+are returned to the caller.
+
+A typical user application would send a FWCTL_RPC using ioctl() for a FW
+command as below:
+
+        ioctl(fd, FWCTL_RPC, &rpc_msg);
+
+where rpc_msg (struct fwctl_rpc) is an encapsulation of fwctl_rpc_bnxt
+(which contains the HWRM command description) and its response.
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


