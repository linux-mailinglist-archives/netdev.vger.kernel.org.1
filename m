Return-Path: <netdev+bounces-198951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86BADE6C4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1037A7574
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4B728032F;
	Wed, 18 Jun 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WoLFDR8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDC280334
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238665; cv=none; b=qek29W/ghUNK5jsk49CBGJ0esFU+EPY09+TxpsvtUIDa+yXM0fhppd+WEpOanTkkC6kGb7pkuV+4+I6KDK/UO3sxzCENZhazfvQ883B5vf17iTQmj/aRioJUo+xWEY4Sva4E+J+VUwEBfe1jgS/2pQcfH3TfydKI0SpMKY0A8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238665; c=relaxed/simple;
	bh=stlKD8TMt2RHQpIMrF+XfM/1DcDXWqKH+tWALVeME38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ieYJmEoX6z1R0dU5Q/+QYM/x2l0pZg6EXKkY6IV+kEaBZFiNI2J9SRiDgIU6p+p+z/NWf3uFJHflX4vHNxpDoSCGHFM9y4Za11GlCZaoVUxIhaobtkNctr6DPWcEl821CGVXCCYdUaIghvAZ6//oZqPX5ckPS5P+rwUUCKn1Fvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WoLFDR8i; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4919137a12.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750238664; x=1750843464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POgVgQOHyY5JFhC7ZUirzBX59J0Bo8DjMxk+7VX8j3Y=;
        b=WoLFDR8iJLt1OL5SDXnzr2iMaObNxbXNHST8XWvSxMZvSZ7KOVIWCZdPzmP0f5/swM
         oMZCPGoUz2u+KnapF+Rrt+h0Pb+L60SiTxgvNU1KngrrVeFm+/KhoGa2aDPQm0cFaXXh
         JWT1JOH0nCbVcPOX/NP2d5/tw18XSDEZgeE9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238664; x=1750843464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POgVgQOHyY5JFhC7ZUirzBX59J0Bo8DjMxk+7VX8j3Y=;
        b=oIv4KepGnOk4T4mLLF+W4kuLCtx7qCQ2lota49nU+TGa8kp3u9V+FHVZQPR+4GFy1y
         5fzRvW/qaDqNDiyAv/f0/b+uMHAP58lQ/Eu3IpRxMYrC55j/uaZYShWWG6PrWcNoQphx
         qkSXLg9Taq6jIdy0HvkaYbxXBNYtl48d4+7kNTnH66dKJ4sxIeEy4Q6yEXWq1ctA0SeC
         3wSrl7aJHiEpngmAk97Wda40jcSh0jLIXnaY/VdCkcVdwQlgY1uCIiCUupQqOqU0HDK2
         eRtcny/ZgSSbMGH+HOykoPCskmatVTmaOPcZ+nhaCuGz8mflgXe+yqEkoXws8uUV5X1G
         ttvA==
X-Gm-Message-State: AOJu0Yx1oCPI/JErB/rImjqMmyY2TxsohnX2Xe/G615R9/xwbHAOziak
	N9pDCiZxdvh0zyu5k9iUqtZsPaglD7bB7cTcV4WUB2JQl7I66kVFf2FiWCOAU7JhBg==
X-Gm-Gg: ASbGncvoaq6CAuCo3NzQrIwXCCGzwIqyiNhzLn8Ewr1f9Vj21rUJJ0Nipe5EfwHGI0s
	b7pQJXggAHl7y/LMVUADyw4IxShn5UczRSrXQfKJ259oDPam2uCwxz37bbncwPjQQZmOTSvbMiY
	defmgAWs/GkEQSn1iVIYNDh0sXl5qMP8v9FRcegKn7j658SycsgSkUTuFkYmb+W8dPAhAMKZ7Gl
	agQaO0nUowxaTZDSuC/rJUWZpshjsjwCvQcLU/P3QYB1iu0MpIxE9UAvwQKbncIv8Lur59WxK9P
	kVA7qkezSRDr8b9aSm4GlhCqU4Hd51xKl7KytBSS6V61gqGjDkMO2TG9APRmrDjdG0ECJhdDdpu
	pUAJlY3VamzilaMBRUs3ZH5/8fj7aVNQ8Li2m3Eg=
X-Google-Smtp-Source: AGHT+IEEXCf9tYsKSdb5r4gM4NhS9cCtxK0XcjZ6Yra6MbUTOtw6mZPoZlZe+86e1KbOYl4Ew/DSEw==
X-Received: by 2002:a05:6a00:2181:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-7489cfc37a3mr22044526b3a.19.1750238663731;
        Wed, 18 Jun 2025 02:24:23 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd08sm10408993b3a.27.2025.06.18.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:24:23 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, 00/10] Introducing Broadcom BNGE Ethernet Driver
Date: Wed, 18 Jun 2025 14:47:30 +0000
Message-ID: <20250618144743.843815-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch series introduces the Ethernet driver for Broadcom’s
BCM5770X chip family, which supports 50/100/200/400/800 Gbps
link speeds. The driver is built as the bng_en.ko kernel module.

To keep the series within a reviewable size (~5K lines of code), this initial
submission focuses on the core infrastructure and initialization, including:
1) PCIe support (device IDs, probe/remove)
2) Devlink support
3) Firmware communication mechanism
4) Creation of network device
5) PF Resource management (rings, IRQs, etc. for netdev & aux dev)

Support for Tx/Rx datapaths, link management, ethtool/devlink operations and
additional features will be introduced in the subsequent patch series.

The bng_en driver shares the bnxt_hsi.h file with the bnxt_en driver, as the bng_en
driver leverages the hardware communication protocol used by the bnxt_en driver.

Thanks,
Vikas


Vikas Gupta (10):
  bng_en: Add PCI interface
  bng_en: Add devlink interface
  bng_en: Add firmware communication mechanism
  bng_en: Add initial interaction with firmware
  bng_en: Add ring memory allocation support
  bng_en: Add backing store support
  bng_en: Add resource management support
  bng_en: Add irq allocation support
  bng_en: Initialize default configuration
  bng_en: Add a network device

 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/broadcom/Kconfig         |   9 +
 drivers/net/ethernet/broadcom/Makefile        |   1 +
 drivers/net/ethernet/broadcom/bnge/Makefile   |  12 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     | 218 ++++++
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 395 ++++++++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.c | 267 +++++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.h |  18 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  33 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.h |   9 +
 .../net/ethernet/broadcom/bnge/bnge_hwrm.c    | 503 +++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    | 117 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 703 ++++++++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  27 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 266 +++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 206 +++++
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 604 +++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |  94 +++
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 438 +++++++++++
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    | 188 +++++
 20 files changed, 4114 insertions(+)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/Makefile
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_core.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_resc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_resc.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_rmem.h

-- 
2.47.1


