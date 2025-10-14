Return-Path: <netdev+bounces-229091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD4BD8171
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBD594FACEA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEBB30F819;
	Tue, 14 Oct 2025 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cZFPPFD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D730F81C
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429074; cv=none; b=OxqFno6aPBI0JNx+dtblx2o2H3FZGg7uMk7FzAKFXJoM7c/8GeZZEWgoScZEtL17IgGTGDJ886vJDYHq7jkxGDkdKXvWoAIcz/0Gn79YT96sxTHZNrrxBkbdWGXAejQTsV5KFQD4u3tuRP1CizGeu25HdPbViF21EChp2meeWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429074; c=relaxed/simple;
	bh=K60G1Fy6Ebxc2tRaiGnlgZZJ27g0iHp6+MuDOcZ2h44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NV53mSG83pE9X3c9MTHaBjIS61yQUJLi9J/nJVDH2nrwdeWBQURLhg++CcaqU+QF1Ft9xEPNKGc9VlJCYas1hqaKDECPojwvQFE1VG8KIved0A97uC+0H7/QEQbyet03w1JFJd8P62QJrcKyFfSpL54T87WKrnCXmH4IHrpNjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cZFPPFD7; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-42f90b88beaso19038645ab.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429072; x=1761033872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4N34mQakjK5A0wsSNl63fctr/WBwY9kyXumrq1SlNVc=;
        b=jcm3Z+9g4YD9N5UiF7LaP1Jv3MeOjkYiwARwglZd6LW+MwcUTRCkHrFpKBBmLxt/A9
         NfBtKlMAMfB2GpUKdHGOYEq1ViTIjCTYEAfrva9K/iLay12iBACitQeEYO+eXpn/wAfL
         HRGJk8yUVxyHqErc9lbCk1eMH0TJJ8Up+ETcgoDS9a6Osots47rORQalqWZ4/X7GBtoZ
         1nzjk3OdKQzeRRMzLJ2p0S7txNAUJCQroBWE8QnRtrHGfTjZDl45oPKv9nDdFDnXfspM
         qhv3Ik4HJqMj1XuKBhNptoLvjFKOU0oBM+EWrVUQLRca/Zs0WkYh9aTIjJ2y/Lf8usOr
         a/UA==
X-Forwarded-Encrypted: i=1; AJvYcCXOcDHDEkQWvdZpuXBVF8vDpEbfRaOFZYdh8wZr0kJ/28D8iVtA/h8WI7iyfLLP/UwGQbVXvxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPS6/Ouce/XD5SdpXWK4Mz8C2NCHGEZqvMBzRULaPAk/jEyzC
	OuOs0xE09+fsifpW+0M+8coLZ25Q3aMmLISqOgekaHNzcyvGbVPY3ci3JB3X2Un0XD2vz/nSo+s
	q7Eu2LgstZ17moz9tIG4ARYQg0SQYdQs5LiRWLbyC7FSAbmFPu51b/SuELbupuruGbad6Isg9Jo
	yPt612s4BgA+eR13OT+SAOUBzmeQuy2Qpy2LTTa1tW6jHXvJ9A8CbUzshR//6d0POeZ9LmXgadf
	G7VjA0xwcsHiQ==
X-Gm-Gg: ASbGncu0vfPDCe3gXF1f//n7QcE6eGe/fAzcYoYmcCseUEZD1sU62z/O4t09B+/+hob
	NT7Q/ZQ0tPRr5Dslz5if/efTaAQoJdtvjtEd1C4KzZ2VXD0mD1Ojz8JsDmpuI1pENXpB/zCFFNr
	zw9Ik/SNbEZVzf/Bbp4MlQzLsCoZBQJOGwmWVZp4785tUJESjt1F+5Fhcehu096grDhHRj1Xh63
	8F+ftZBIRf9Fyks7ismIgezJhoJKtNPZYM4UKcN9dhUQmZVByUe1lCHN5WatSkvUYClq1unL53Y
	fbi4CeKejjDzt6+Vmhx8cuHHEFnHOWIcGt6UlQzRunRdDJ+SS8O2X2BM6JhnLS4vqfooJt56Dew
	jwX+BuVeIBEwl9SxcVIzo1LrsCIhwR+iJ66TyqqZzqbCRxWD5rE1sSNlKGnOBqBxWPH2wE7GNxx
	ZSOg==
X-Google-Smtp-Source: AGHT+IGm/s6GzDERCS8F+T/NLdDqwZKolU4pmRNXLrTlQH/RRb0drXNKz8ZonDB/v9giZ8tNWBO7Rpt9Emsw
X-Received: by 2002:a05:6e02:12c1:b0:430:8bff:c5a1 with SMTP id e9e14a558f8ab-4308bffc74dmr81121715ab.4.1760429072124;
        Tue, 14 Oct 2025 01:04:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-58f726e364asm956736173.44.2025.10.14.01.04.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:04:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78038ed99d9so12465853b3a.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760429070; x=1761033870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N34mQakjK5A0wsSNl63fctr/WBwY9kyXumrq1SlNVc=;
        b=cZFPPFD7eoNx1Zp5cCBQdLJCy2oNRLiWeVPqpnejxuOZoknG//RzChFLrvAaSN/Vhv
         RTgUHgg2yI6tkJgiz5f3vRjKJXXTczA4pPkfUJGrIDbr0xF9lwqYLOLu0S/T7hLPzWss
         ZbpPZTPEBj1U2aZ8yXJpqlgr/HsprNMukQytw=
X-Forwarded-Encrypted: i=1; AJvYcCVFwCEOzmLCJoPz+ggK2y9+CmIOv8YCOxRtl+uge1QYtBYcWDuSwZVX4U/9B7+0TuybEalpNao=@vger.kernel.org
X-Received: by 2002:a05:6a00:1149:b0:792:52ab:d9fe with SMTP id d2e1a72fcca58-793823b6278mr31213578b3a.0.1760429070370;
        Tue, 14 Oct 2025 01:04:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1149:b0:792:52ab:d9fe with SMTP id d2e1a72fcca58-793823b6278mr31213528b3a.0.1760429069707;
        Tue, 14 Oct 2025 01:04:29 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-799283c1a14sm14329716b3a.0.2025.10.14.01.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:04:29 -0700 (PDT)
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
Subject: [PATCH net-next v5 5/5] bnxt_fwctl: Add documentation entries
Date: Tue, 14 Oct 2025 01:10:33 -0700
Message-Id: <20251014081033.1175053-6-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 .../userspace-api/fwctl/bnxt_fwctl.rst        | 78 +++++++++++++++++++
 Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst

diff --git a/Documentation/userspace-api/fwctl/bnxt_fwctl.rst b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
new file mode 100644
index 000000000000..cbf6be4410cc
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
+(of type struct fwctl_info_bnxt). fwctl_info_msg is set up as follows:
+
+        size = sizeof(struct fwctl_info);
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
+requirements of specific HWRM commands described in include/bnxt/hsi.h.
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
+        bnxt_rpc_msg.req_len = sizeof(struct hwrm_ver_get_input);
+        bnxt_rpc_msg.num_dma = 0;
+        bnxt_rpc_msg.req = (__aligned_u64)&req;
+
+        fwctl_rpc_msg.size = sizeof(struct fwctl_rpc);
+        fwctl_rpc_msg.scope = FWCTL_RPC_DEBUG_READ_ONLY;
+        fwctl_rpc_msg.in_len = sizeof(bnxt_rpc_msg) + sizeof(req);
+        fwctl_rpc_msg.out_len = sizeof(struct hwrm_ver_get_output);
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


