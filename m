Return-Path: <netdev+bounces-226876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A3BA5C65
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CEC1B21831
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC2298CC9;
	Sat, 27 Sep 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R4QtR28W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758227A915
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965575; cv=none; b=qATNWlmTd/9MWl/L94UauhNfQitRwKP6qJ9wMj7LzxTgmHrMTOJCxblrtaMbxeTqIhE5znh6SaZDi1zS0kytMSlr1YXL6yVZkwHkGyN1pfL4WaYnSoZpayVEtLyYu5Gdx0FBPVANQTdvq7gyWT8g3V7OmTHblNC8Av8EdD5KDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965575; c=relaxed/simple;
	bh=2CpYa9QTCtXR/h7Nws5qEahu7IgBybMRxBMna7Um2/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MQUd+FX9T8mr9XiMas3oL9L01qXv9VAJeyp0vqC1nAmdBiSp2ckdontmgIOxCVbsdh6ONmQA504mYK92kd+ZeCRqPyoJK4rDSjBrP+ZnEHgj1SQPq0t4y/OimiC+fjrK1XpnGeoE9UMe8pqi6P9q5LfZgx4keduJRVO1Dx41jHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R4QtR28W; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-77f1f29a551so4013059b3a.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965573; x=1759570373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUGqO867qPXqCU9nRxWJmcotzVKjlhhUCRR7OPbF9cU=;
        b=VJG9xLFWQdhkSE2FWDOcp/dqHZZXtOfqZwcLY18wH32OIN0sZ4JEwWfj9l/AohsA5f
         NcjHleqQR8uVP3+6xcKM/BgrOQVj71vcvEj9DBy/xfYeqXkfvJoxRIVRLMcv/CUtZTBd
         TFaSs+folqC8duQGv2UxmrsIvpnD1w20VGt6WCFcvDK/ZCfYqqWAE5/GsDroLFGLVsal
         ajsiENHNZv7d7VKUOpWDiDH2xfsfEg6LDD8397+AcP3CEpc2BReVtP+4ifXiQIs+FcY5
         /FbBf/ucn5h95ZOKK9VLAK+9AJQBwr/MFKd+f+Id49qnxPgQhS6f1X9RW3i+QSKmwf/2
         UxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCkmdO9Yei6XyxOMVMi34VWKToJF/2Bi8TNoA/reLKBAdsMT0wlhyZdZ5j8+8aAM1s4qKzNAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNy4+38R1vxvrYMHlVlCw6+cjpPMlsVc0JmHGKehWTaQ5r/YQ6
	RLQwx+2ydAjYNuyr9OUTRQNxHVjPpluEsU5R52lU1/PbTEdHKvklJxS6jVL/W19Z5r91MYnErn/
	8CubBVU9Agpj6MJlQ1G7fvugFy46DhX1KJLzVSfmfSksKDrWjZq7FSf8hTNqxJIk5r+Tn2S1yHp
	cftBa5VmBHhQYKQ8LumhMIW+/VndZyuHN6wB4O0YRHZPOsaY0ZcHsJgJxVRo4V8a3YjW+u6n3my
	bBf/hUk6ltb6Q==
X-Gm-Gg: ASbGncv/UEQWxd9lfEB1Zw4wEfZaLjIGuo3xw6Bw7NPtsWJAi5FNrt/zzwUDXijxvTT
	RGJUQqEvTKucQ7huPq7oIBahqVwbq4yNnDqBISxl6XQMQrAEx6XRbvp02TjrrtS9I5u8XorBnK9
	s9Hoh8eJlKyzH8GFKB7ushixrEqGYt/eO0mtOOQ8q2vWQmBnJB4W7WqLpn8kHNHymEVVyyKa3t0
	1tv/oP07QShYzObu5sTzSOp65LPTP/Bj9IauSWfxPkaE/Ihtu6NaEnGS2e6urodI31lDvh/8ZOi
	q++NiHOH86Y3oPd2TsW9nmj5jwgu10oIJuSMAhDQyoVm5T6asXOsvyRha74nQ0WdZ2YsmUerafo
	UOhxuMMkNJVoUwXBmjUsjyfSeNGlLt15H+Z55hqYoCLHWCUvKezohvO2XllTZmewQSrLOLA9sCE
	YuSQ==
X-Google-Smtp-Source: AGHT+IGKkBFrkQ/gPX+xZO6QDSSW3GM3C5XhWuYVlmJXcIC9gSKB1ZXB2liZ7V1lDS8EqoSlBF1ic2LX1K2q
X-Received: by 2002:a05:6a00:1954:b0:77c:d54b:8c86 with SMTP id d2e1a72fcca58-780fcc98268mr10758610b3a.0.1758965572818;
        Sat, 27 Sep 2025 02:32:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-781023da629sm342006b3a.1.2025.09.27.02.32.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2025 02:32:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f2e48a829so4819786b3a.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758965571; x=1759570371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUGqO867qPXqCU9nRxWJmcotzVKjlhhUCRR7OPbF9cU=;
        b=R4QtR28WkusylttaY7suFYqSs9Y0tBYX9KmtmsHr646O/NduWPHKK42SP+NJ4odQZ/
         /eRpJnQCaRGgk1w3obiUV4E43j02SMislM3RBMEpU4AU6DkF3o4mEtZt1IAKJ65QAhbn
         K3EjuUL6nP+wbmxW27Qxil/PS8+Wz8uH3vTME=
X-Forwarded-Encrypted: i=1; AJvYcCW8VFrIKHepJ5aoVlrmTl0WYMQdQqR++YGofoO2iOTHMSjRSrtYT1AaiGvZo3zB70EQXwFw5Xk=@vger.kernel.org
X-Received: by 2002:a05:6a00:3e13:b0:776:1de4:aee6 with SMTP id d2e1a72fcca58-780fcec2c91mr9196689b3a.16.1758965571065;
        Sat, 27 Sep 2025 02:32:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e13:b0:776:1de4:aee6 with SMTP id d2e1a72fcca58-780fcec2c91mr9196670b3a.16.1758965570669;
        Sat, 27 Sep 2025 02:32:50 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm6109940b3a.14.2025.09.27.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:32:50 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/5]  bnxt_fwctl: fwctl for Broadcom Netxtreme devices
Date: Sat, 27 Sep 2025 02:39:25 -0700
Message-Id: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Introducing bnxt_fwctl which follows along Jason's work [1].
It is an aux bus driver that enables fwctl for Broadcom
NetXtreme 574xx, 575xx and 576xx series chipsets by using
bnxt driver's capability to talk to devices' firmware.

The first patch moves the ULP definitions to a common place
inside include/linux/bnxt/. The second and third patches
refactor and extend the existing bnxt aux bus functions to
be able to add more than one auxiliary device. The last three
patches create an additional bnxt aux device, add bnxt_fwctl,
and the documentation.

[1] https://lore.kernel.org/netdev/0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com/

v4: In patch #4, added the missing kfree on error for response
buffer. Improved documentation in patch #5 based on comments
from Dave.

v3: Addressed the review comments as below
Patch #1: Removed redundant common.h [thanks Saeed]
Patch #2 and #3 merged into a single patch [thanks Jonathan]
Patch #3: Addressed comments from Jonathan
Patch #4 and #5: Addressed comments from Jonathan and Dave

v2: In patch #5, fixed a sparse warning where a __le16 was
degraded to an integer. Also addressed kdoc warnings for
include/uapi/fwctl/bnxt.h in the same patch.

v1: https://lore.kernel.org/netdev/20250922090851.719913-1-pavan.chebbi@broadcom.com/

The following are changes since commit fec734e8d564d55fb6bd4909ae2e68814d21d0a1:
  Merge tag 'riscv-for-linus-v6.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
and are available in the git repository at:
  https://github.com/pavanchebbi/linux/tree/bnxt_fwctl_v4

Pavan Chebbi (5):
  bnxt_en: Move common definitions to include/linux/bnxt/
  bnxt_en: Refactor aux bus functions to be more generic
  bnxt_en: Create an aux device for fwctl
  bnxt_fwctl: Add bnxt fwctl device
  bnxt_fwctl: Add documentation entries

 .../userspace-api/fwctl/bnxt_fwctl.rst        |  78 +++
 Documentation/userspace-api/fwctl/fwctl.rst   |   1 +
 Documentation/userspace-api/fwctl/index.rst   |   1 +
 MAINTAINERS                                   |   6 +
 drivers/fwctl/Kconfig                         |  11 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/bnxt/Makefile                   |   4 +
 drivers/fwctl/bnxt/main.c                     | 454 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.c       |   2 +-
 drivers/infiniband/hw/bnxt_re/main.c          |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  12 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 245 +++++++---
 .../bnxt_ulp.h => include/linux/bnxt/ulp.h    |  22 +-
 include/uapi/fwctl/bnxt.h                     |  64 +++
 include/uapi/fwctl/fwctl.h                    |   1 +
 21 files changed, 858 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/main.c
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (87%)
 create mode 100644 include/uapi/fwctl/bnxt.h

-- 
2.39.1


