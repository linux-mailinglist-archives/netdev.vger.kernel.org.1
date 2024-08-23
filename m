Return-Path: <netdev+bounces-121488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A011595D647
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC22B21B8C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32B192B65;
	Fri, 23 Aug 2024 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FwJOG9FY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967663A8CE
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443066; cv=none; b=qfQ3xqu4kF7sIhB54nlOUcEz5x/a4ThH06xn+kQuOhsj8IuNE4eX3iIfpySAGJXJv2+bi9yHsVICB718NJ2cRPI+1K2Y1WdM4Z21FZza6oeLeqyd6NC7LicOLO9KPuII3svCs0ShgHoBR6aVu6jTp7uEe9m3udGjdmIK26P9f2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443066; c=relaxed/simple;
	bh=LxpAzFDupW7x5PD1gg9uAeOPWZW77EF0cjxK1B2IClA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DOM/K5EcOgDCTUlrjFnUzW6GY710hhPOEkm5asSgZiVutCHBak2rCdOWNVypQVWUmju5ko0cP+ldUh1990MGE6p8O6P5f9fVB39dFUqeAS+lG/yBGuQRC3fMBBWv9xQAh832+GkrKsuKemInA5M8Bf8boqHIhHE3t2WemrQVzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FwJOG9FY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1654069a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443064; x=1725047864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn5MjTDlLBN55psFCNa4XvqzGs4BqMgMCLQ3DWMfwU4=;
        b=FwJOG9FYZX5H6Cx5ypbTUw3pGa+1vLacZ3S3lkADWjqBXGJGbVcS0zNLpT8U07f548
         QgMwrFF5lpOSd68LKiJ7MKc+ur+yeA88y+zBlQQg1hdp6o+YUmrOy3UMD8StHui87Pel
         rx3O8DcKMPQt+FMOFVfW9AncVoNNnFeF2puEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443064; x=1725047864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xn5MjTDlLBN55psFCNa4XvqzGs4BqMgMCLQ3DWMfwU4=;
        b=ik8GjgLrvW1VWjFtQfyuh/BMMlriVJK/ZcAXBdo533DlQ5GgPQgmA35f0AxlhHZtMH
         H1w5MRzkFDvC/DQ1K09x2f4oZW/OgArXLow9qi96MfLYwPx1XMIKP/JYaUCQJbvpeISU
         enK/F3rdcRUuMvBXMwZ1vb4HjOzgUYwckCa2Mn7lSRF22QKGs6QU0VNMCVLkennFJwC7
         Cm7CxP7HJMrf1/DqHI6Fhcizf86xgLDDPzWY7R/XdJEhRXbSYzntam2Fl29VnIu5oL1V
         9XenPK1l+oFe4rWndiMzVKCznPbuW2/gb7jmEme3h4uFm66LmeJISft1cotpWbI0tTmp
         TNIg==
X-Gm-Message-State: AOJu0YznU9RnhoNOdeVdLb42IDX2DMKwlmxaXc9yUQ+zulXjy88/69VA
	Y93sXaVIoiDN0Xc4+L40qdX0wkCbHNs0H4nzUjeAs6rOZ+PBI+BIKsAkgAA/Uw==
X-Google-Smtp-Source: AGHT+IE9Rfssa0/N53yDvYSU41NTyWBkQiPo1teyTjHi9/2a103EHQUHhEhw1T+Y4Qn5pWS12PdVMA==
X-Received: by 2002:a05:6a20:4394:b0:1c8:961c:4143 with SMTP id adf61e73a8af0-1cc8b5de053mr4523730637.36.1724443063621;
        Fri, 23 Aug 2024 12:57:43 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:43 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	helgaas@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v3 0/9] bnxt_en: Update for net-next
Date: Fri, 23 Aug 2024 12:56:48 -0700
Message-ID: <20240823195657.31588-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series starts with 2 patches to support firmware crash dump.  The
driver allocates the required DMA memory ahead of time for firmware to
store the crash dump if and when it crashes.  Patch 3 adds priority and
TPID for the .ndo_set_vf_vlan() callback.  Note that this was rejected
and reverted last year and it is being re-submitted after recent changes
in the guidelines.  The remaining patches are MSIX related.  Legacy
interrupt is no longer supported by firmware so we remove the support
in the driver.  We then convert to use the newer kernel APIs to
allocate and enable MSIX vectors.  The last patch adds support for
dynamic MSIX.

v3:
Some changes to patch #1, #2, and #8 based on feedback from Przemek
Kitszel and internal review.  I'm keeping Simon's Reviewed-by tags since
the changes are small.

Link to v2:
https://lore.kernel.org/netdev/20240816212832.185379-1-michael.chan@broadcom.com/

v2:
Only patch #4 is updated to fix a memory leakage reported by Simon.
The changelog of some of the MSIX patches have been updated based on
feedback from Bjorn Helgaas.

Link to v1:
https://lore.kernel.org/netdev/20240713234339.70293-1-michael.chan@broadcom.com/


*** BLURB HERE ***

Michael Chan (6):
  bnxt_en: Deprecate support for legacy INTX mode
  bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
  bnxt_en: Remove register mapping to support INTX
  bnxt_en: Replace deprecated PCI MSIX APIs
  bnxt_en: Allocate the max bp->irq_tbl size for dynamic msix allocation
  bnxt_en: Support dynamic MSIX

Sreekanth Reddy (1):
  bnxt_en: Support QOS and TPID settings for the SRIOV VLAN

Vikas Gupta (2):
  bnxt_en: add support for storing crash dump into host memory
  bnxt_en: add support for retrieving crash dump using ethtool

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 330 ++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   8 +-
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    |  98 +++++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |   8 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  13 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  29 +-
 6 files changed, 299 insertions(+), 187 deletions(-)

-- 
2.30.1


