Return-Path: <netdev+bounces-239193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D117C65735
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FB6B4F41CB
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A4309EE4;
	Mon, 17 Nov 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rb5oBhl3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EFA3090E6
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399511; cv=none; b=Np6DaVUZeuoGramBHwrC78eeSUezdDLCVc0ZhG/7k1NSAhXz5k3L+fXCr6UK6qgK7PpiHnLmbZg+12xBo5AJtkcHHNUlsNpf614+YWP4/LivWzskNZSv+8DXDt2iTUnuuPqfDBsyuC3uGu1SGc112ak4al4Wtra4Qxl5Z0mX1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399511; c=relaxed/simple;
	bh=CGD3WWM4RJsKjiBIKI5DOKn8UKZZLCFREOivv4kIa68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PKVVhnaKezQsggsNtRg47fdr7/ZWl5+nVcN35+mXZJXUmhWw+BwK0eO5u+PhBAQhUttwmPMIUG1thtKXwWZEUA7eLtQ7SgUZKbtoElJE4v7Shmn5LXIx0yWbrkFGBWMl0cNjdqBHJ6slQrD5uc81N8XMUnbq3wl7lS6sPRd2DUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rb5oBhl3; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso4572318b3a.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399509; x=1764004309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PnfIwiIPLokh861WW9VvfFK1qgK6/9Jm139k+AFMko=;
        b=DSJ58ECaB4LJfDU0foUorXPp8foeizjBj8uaTD+plQBkdU92JgNwoFgqPzr/zjh08R
         thMNlSnx4H551CcLXDJ0etYtn32iG+19WKGCNBtSr4y25pGfWUaP3RvkJ4jxJjBKCcd2
         crp9rAcQx48Zzuusv3Ba3Tgyo28DRZhAk+4EaTiPOjS42FulK+Uq7vJpxjnpEJZ8ABpL
         nVWWzCk1bgWIp2dY8XeRSX3Q9F+2Tzg5AHy+BzrPGo9LNOnMy6P2WM2CyyYtXjAULTzZ
         WUd5IC0NKSJzM8HCHjL4l1MvGGWN1WDAfKCTIMPT2tQBmB2ystmt4IzwfOQF8rGZcTrH
         0j7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiQQkPQkZFys7Sjxc8O8CBsNmE46N6aMGGdfXvWYRwGhEbmjWrIKH6phtmkjKJgVIDBtfgam4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqlb9PUw3BuFpOlDsbG1k/m+ngH+b58tRMywzcRcE/++a8NxDm
	AumJcNuidfRNk8LEu3kWnDWQJGf0jXx86hnYsw9NiAzoDQMketl+r5QmwqhtrTFzSBgXcFM/Aei
	dbQyRCNPvqtVSVpixdPHV5pSSofoncuu0wUyJM3lUP3cccU9lWX2H0uFRzL+Rs/D84FWIt5VC9X
	KecMTf3EKpvyQzOm8mAz6OsyDTPkqJnCtLmPb60pMH43O5UEqYRPzzbj6maTnvr/MJMgmCfCUMG
	7rC3gmbuinW
X-Gm-Gg: ASbGncs8r/qdiGYwnWrM5A4dXxofXtgEcEN5QYmzEfo5giXg1OE6cE3m9MspOQdexb0
	O/zRSfvz2smjJqkV2WuUrN/W+jsxyPcn8Zv7JNTN02z9JWbyiII+o6Wnh7nvjhko0xD+WHIgNi8
	piC5ELkiDpFjdUv5tKrShnubdLhbttODA/q7UJQbgN4eD6a0T5RTYqwhVpVG+YKp0M9FNK41juR
	umfMKDG+N0XZyiAk5nwT5pvxsO4eYD/MKBD061PWiHdeCUy+wzpt3gWtbAx8ik44tCN0lWW8XMN
	1ULb6n4WBL7FPoLWg7wBbRdwQqETw1bAr3wrF78HnU8j6PJdDbcZO/u6lv3DK/+Ro22VWRtCTVl
	Ftv7SlD2rWDe57vyipaQXG8BU/XFZloWe1QA4EbH9YzcZbyuHqfklioXQCZWlZiT1TqMqPXfqSD
	+H92MqTW5OxC147fg3jBtaClCARU2sL3xr
X-Google-Smtp-Source: AGHT+IH8I8FT/xnE3r9R6UEXINQiQrTCslgRUqBXQzvt/QWVzZBIqi9dmFF40yitsoSpwMxm89UE7F34R5EI
X-Received: by 2002:a05:7022:221:b0:119:e56b:959c with SMTP id a92af1059eb24-11b411ff74amr6304210c88.33.1763399509154;
        Mon, 17 Nov 2025 09:11:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11b0609138asm1227700c88.6.2025.11.17.09.11.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:11:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8824f62b614so34220526d6.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399508; x=1764004308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/PnfIwiIPLokh861WW9VvfFK1qgK6/9Jm139k+AFMko=;
        b=Rb5oBhl3eD/ngdzcvSDNKaSMiVXFL0NdgVuvBUZDldNP0bn3uPf1BWh7s6S+Sr7MQ6
         IOjxmiQ7IvlrlZb78fFrIP7bOKcrtdle5ug0gpAxwhdpnNApKa/LYv2EROhJ1oa3x15C
         w/rxTb8vqbbwwGpatz3N/KqiQkUunxG9lgIIs=
X-Forwarded-Encrypted: i=1; AJvYcCX3VzL5qSMVqgol3tTtJAGwoxt3dV3P7s/M/7JziO/A/WMKCqPD9q73qSjK2iDAkGAup4vhzGs=@vger.kernel.org
X-Received: by 2002:a05:6214:21a3:b0:882:401c:e391 with SMTP id 6a1803df08f44-882926e0205mr225523966d6.57.1763399507644;
        Mon, 17 Nov 2025 09:11:47 -0800 (PST)
X-Received: by 2002:a05:6214:21a3:b0:882:401c:e391 with SMTP id 6a1803df08f44-882926e0205mr225523336d6.57.1763399507161;
        Mon, 17 Nov 2025 09:11:47 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:11:46 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v3 0/8] Introducing Broadcom BNG_RE RoCE Driver
Date: Mon, 17 Nov 2025 17:11:18 +0000
Message-ID: <20251117171136.128193-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=all
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch series introduces the Next generation RoCE driver for
Broadcom’s BCM5770X chip family, which supports 50/100/200/400/800G
link speeds. The driver is built as the bng_re.ko kernel module.

To keep the series within a reviewable size (~3.5K lines of code),
this initial submission focuses on the core infrastructure and
hardware initialization, including:

1) bng_en: Auxiliary device support
2) Auxiliary device support (probe/remove)
3) Get the required resources from bng_en
4) Firmware communication mechanism
5) Allocation of ib device
6) Basic debugfs infrastructure support
7) Get the device capability (QPs, CQs, SRQs, etc.)
8) Initialize the Hardware

Support for Verbs, User library and additional features will be
built on top of this patchset. hence, they will be introduced in
the subsequent patch series.

The bng_re driver shares the roce_hsi.h file with the bnxt_re
driver, as the bng_re driver leverages the hardware communication
protocol used by the bnxt_re driver.
======================================================================
Changes from:
v2->v3
Rebased the patchseries to rdma-next

v1->v2
Addressed the following comments by Simon Horman and Leon Romanovsky:
Patch 2/8:
  - Remove rdev_to_dev check in bng_re_add_device.
Patch 5/8:
  - Remove uninitalized variable rc in bng_re_process_func_event.
  - Remove unused variable in creq bng_re_enable_fw_channel.
  - Modified the switch case as suggested by Leon in
    bng_re_process_func_event.
Patch 6/8:
  - Remove unused variable cctx in bng_re_get_dev_attr.

Thanks,
Siva

Siva Reddy Kallam (7):
  RDMA/bng_re: Add Auxiliary interface
  RDMA/bng_re: Register and get the resources from bnge driver
  RDMA/bng_re: Allocate required memory resources for Firmware channel
  RDMA/bng_re: Add infrastructure for enabling Firmware channel
  RDMA/bng_re: Enable Firmware channel and query device attributes
  RDMA/bng_re: Add basic debugfs infrastructure
  RDMA/bng_re: Initialize the Firmware and Hardware

Vikas Gupta (1):
  bng_en: Add RoCE aux device support

 MAINTAINERS                                   |   7 +
 drivers/infiniband/Kconfig                    |   1 +
 drivers/infiniband/hw/Makefile                |   1 +
 drivers/infiniband/hw/bng_re/Kconfig          |  10 +
 drivers/infiniband/hw/bng_re/Makefile         |   8 +
 drivers/infiniband/hw/bng_re/bng_debugfs.c    |  39 +
 drivers/infiniband/hw/bng_re/bng_debugfs.h    |  12 +
 drivers/infiniband/hw/bng_re/bng_dev.c        | 539 ++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.c         | 767 ++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.h         | 211 +++++
 drivers/infiniband/hw/bng_re/bng_re.h         |  86 ++
 drivers/infiniband/hw/bng_re/bng_res.c        | 279 +++++++
 drivers/infiniband/hw/bng_re/bng_res.h        | 215 +++++
 drivers/infiniband/hw/bng_re/bng_sp.c         | 131 +++
 drivers/infiniband/hw/bng_re/bng_sp.h         |  47 ++
 drivers/infiniband/hw/bng_re/bng_tlv.h        | 128 +++
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  10 +
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    | 258 ++++++
 .../net/ethernet/broadcom/bnge/bnge_auxr.h    |  84 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  18 +-
 .../net/ethernet/broadcom/bnge/bnge_hwrm.c    |  40 +
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  12 +
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
 25 files changed, 2907 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
 create mode 100644 drivers/infiniband/hw/bng_re/Makefile
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h

-- 
2.43.0


