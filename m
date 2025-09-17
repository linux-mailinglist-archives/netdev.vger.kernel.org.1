Return-Path: <netdev+bounces-223841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD9B7D67B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53541BC0EE6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90882F39B1;
	Wed, 17 Sep 2025 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M+sNGFns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E119ADBA
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082160; cv=none; b=tq9lS4ZC+eJo3KIPLm94u3nVcZKcAGZYFR6lErWzHj2akcDz1RGVlVcngNgfBksuxhicBide27N6orX8QeO5+8oUkTWqGic9fEZB8Xn6DERWTmYihxMxm2OP4ERYGfkmWwk4BrAt9BGaWAZr/CUxhASA2jVKbVsbpQfm6NjdQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082160; c=relaxed/simple;
	bh=OqpmWcfQpIWzowwfgnTSEuE0pKjtwmsXivLKFdggmUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITgbVahv0//lHfaW0CeKD5xjR4pjkeo4l9ifpLkQm5Et+t+GhFOPn63ah+exkYYgkyTj0uiC+oSLneF2ahEzz5JNJMqZSsK81OEZ5QWBphWVQulYexaN9gznOMzlBj3Hly5CgVmy3M98nFCrxSL02zeFUstSQfqzQhezAYJ8eME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M+sNGFns; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-827ec18434aso388711685a.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082158; x=1758686958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfjcMjQlghaWTUng67xvOB04SWBDZxY53+pp/EKB0ZA=;
        b=YVJ3sCJHwjPmL19dikO3eG3EuvUpie7nkG8Ax4GAqogIOEkdovsBiWNMCVigFMuthO
         87IrsAZOmeHpw2f6IN37/4b4PfItwbVnJcTGUj70EIfOYzfoKfBH3oGyItOuMEU5Dwr5
         qwGGFls/a995/1eyJ+VIBHDK+OgJySDAAJgLwgirLl4vsbDJujsVFAmkfAoZ5THjZRWQ
         8Q7bwLPta8kxZB29t1J97XuwnsGxDcySQlsdG071Nmi4N7D8bmAvahy+HpE3cJ+g9654
         g2sISh3QEIeLBO/x7pMMvsqWs/Ndprm8TnmpgEyxFinc+KKZiiCtWuEACJ1Y1uOXW6GL
         pvRg==
X-Gm-Message-State: AOJu0YwiGUGGhvFJUfPKxGQUQKBoBJlQ4efE578TRm+A/NyQz0v8TqoF
	F3GWzlU3NVbkx6xeqyRk9QsyzlDgaJ8SQ6kpMkxZ/mv50VTuUocl69go6yurYWul//LF3Ms5Nsq
	ZaXdlYBgjlnDyv+UrVvSmGcYv5ne2w+4Vq0DyrzU7LSCpoxc47pes2Y3ZC6r18XL/tVoUhCPk83
	Bp6cSOWV+T7SQA+u3JdBuvCVmYlJiPt79MDdXYqA3qGNT8z2hw8Rue4w1/7e8ppMyYeRVub2WHk
	/AhQ+FHlWU=
X-Gm-Gg: ASbGncsBZd4DVACS8XUQceJSkT36V/KxMq9Bupel5Ppujr831wjRhq/vAjnU7xCyBnY
	6RRMd2t6jMivHtIf5P4KDG5qTesvK8nUgo8C/h9jQjv5+BCsGT5zZ0ftpjB0hD0VOBGYN9uBNNN
	gd6IonFN1uNNxKMja6puiTx2uAzRwmO9Xid1pEK97ba07yttEDaY5kdUJ3RAaJyiaTCWqpbt4PQ
	SuI1bnviCqjt39j7YYkmJV5lCkknxbr6eZUjRbJmfqylNdktKS6rhoQGtXLgMVi6bXDVsPC+/HA
	3PjX+E2+Nabq9pwY9bbT42dK84TOx0QovOJDpnv2+5jVDZ+HAvjV4A12UeWFOxsSbkfn6ft91+Z
	wr2DG9vq/+bE33/NYPc9BCI5l3T4+jAc7Lcj6DZiPA1rhBRxi/K4Z7X3ls9Tc/621NyTcBvyf7Z
	fs0g==
X-Google-Smtp-Source: AGHT+IEBLPXR2BGGB+qLViKHpTl2txIIjsaVXNWjgdobhN2itT5RoBf1qZ5lRTmcu2qNwQ/aqHumLAhujDp7
X-Received: by 2002:a05:620a:45ab:b0:7e6:9644:c977 with SMTP id af79cd13be357-8310b59ac08mr79179885a.27.1758082158072;
        Tue, 16 Sep 2025 21:09:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-78cbf225b26sm2948416d6.1.2025.09.16.21.09.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4fb25c2e56so4185759a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082157; x=1758686957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfjcMjQlghaWTUng67xvOB04SWBDZxY53+pp/EKB0ZA=;
        b=M+sNGFnsIn5YrRX3YkpL75ZCWD6n3VbOc2O1at9IrGlcxhDc4HnVNclohLpcaH0rOn
         pqmk3sZaXgegTpzvPlZpITi05OIVIq4O/pPlW+r1m/XspPwGo2x80nputoyltHn3XBQw
         yjR6lb3LmrYwroT0SVfx3auRK6LE1xGxXTjlM=
X-Received: by 2002:a05:6a20:7d9d:b0:24e:e270:2f53 with SMTP id adf61e73a8af0-27a91b22c9bmr815531637.13.1758082156821;
        Tue, 16 Sep 2025 21:09:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9d:b0:24e:e270:2f53 with SMTP id adf61e73a8af0-27a91b22c9bmr815511637.13.1758082156392;
        Tue, 16 Sep 2025 21:09:16 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:15 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 00/10] bnxt_en: Updates for net-next
Date: Tue, 16 Sep 2025 21:08:29 -0700
Message-ID: <20250917040839.1924698-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series includes some code clean-ups and optimizations.  New features
include 2 new backing store memory types to collect FW logs for core
dumps, dynamic SRIOV resource allocations for RoCE, and ethtool tunable
for PFC watchdog.

v2: Drop patch #4.  The patch makes the code different from the original
bnxt_hwrm_func_backing_store_cfg_v2() that allows instance_bmap to have
bits that are not contiguous.  It is safer to keep the original code.

v1: https://lore.kernel.org/netdev/20250915030505.1803478-1-michael.chan@broadcom.com/

Anantha Prabhu (1):
  bnxt_en: Support for RoCE resources dynamically shared within VFs.

Kalesh AP (4):
  bnxt_en: Drop redundant if block in bnxt_dl_flash_update()
  bnxt_en: Remove unnecessary VF check in bnxt_hwrm_nvm_req()
  bnxt_en: Optimize bnxt_sriov_disable()
  bnxt_en: Use VLAN_ETH_HLEN when possible

Kashyap Desai (1):
  bnxt_en: Add err_qpc backing store handling

Michael Chan (3):
  bnxt_en: Improve bnxt_backing_store_cfg_v2()
  bnxt_en: Implement ethtool .get_tunable() for
    ETHTOOL_PFC_PREVENTION_TOUT
  bnxt_en: Implement ethtool .set_tunable() for
    ETHTOOL_PFC_PREVENTION_TOUT

Shruti Parab (1):
  bnxt_en: Add fw log trace support for 5731X/5741X chips

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 57 ++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  9 ++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    |  4 +-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  2 +
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 13 ----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 45 +++++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 21 ++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.h   |  2 +-
 include/linux/bnxt/hsi.h                      | 61 +++++++++++++++++++
 9 files changed, 180 insertions(+), 34 deletions(-)

-- 
2.51.0


