Return-Path: <netdev+bounces-222261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABAEB53C54
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574801C28331
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857A725DB0A;
	Thu, 11 Sep 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NcuaEI6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C423D28C
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619323; cv=none; b=Zh+8yrZnuV3nmTNVjdbhAI68Y3pVOOrE+QjkXE3vB1vMEN1Xq2gdS9u6OEB1AH7XugTCW1MJ5lq9MttmZ3Lcl7tHd37I+WbXw5twT0hqJ/KcQsLBsEWKX4u+j054S56KMfpqdDfz0kLtl3m8l+6kVlCnpF95QDjH1Gt6gA8et60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619323; c=relaxed/simple;
	bh=S4/aOHGQqTUAIA0XcvGx5wKQh909FOEIhCW0/0Pc6/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICBJCgN/Rmo46LBPfFWoxWI824+79BOQODuLi7U9JVnZn3VG5gW0lnVolUJvcc4OLyiTJVqDBIlSQzkPYy3re39FoqRJyZThl6bRp741WYu8gC4mwGfItgKurI1lKW+oNmFPxgDMiUq+wbt2vq3EiEnEZRlI3/7tFsSjMCsosWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NcuaEI6l; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-72ce9790ab3so8190577b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619321; x=1758224121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4DDAQLElHWgn/kO6TEgJJZR7NPyqBFo1FrDy3LSQVU=;
        b=bDUq/jxTcyrFGyNJEUVmcTw8TOLHdbxzn1RBd+VtSljVUK3pZj2AZYLBLv9ZbgakVL
         /LYTWHPjBGgP2hk/W/KI+UouDj/6x7QibI9D32R4/io98rwVkco8sCz+rgGiF3q9UsqH
         M+sUeLhHkNwesgeOKtCO7VkKdwWhUloQO0LlwgcNIi+gysXkAh2Q/Z88xl0sXn324cj3
         +FCbIM//lr60nqpk5dJazvapd87CI5C86CMdU0xG+XI85IoBHIIccC1M+qjb0a3Tq9TB
         QUkcL0xqwA/vqhdKs3LXZmWFVVpJMW2HRIlwy8nPRpHgLTSpCbtHEZfEDqlPGsDoOTIc
         g7iA==
X-Gm-Message-State: AOJu0Yzt73l82KF2AZC4+EL3XY/ZMuyVtjldx24MdqLPllopRISpEqQA
	MMtj4bHcqG2v5b5idqEKby8HTKhJzsUYbPsA4KH0U3KflKPKDVqoC3iaA0Yz3F7O1lTKnL1Xh/P
	JaADVxEIe8mOwcw7fZEO8OHA5rdopVWOk+RagR10djNkKKqC2MNWHrpx9p0mhCb6uvwB4Vv2mxy
	5AdgJ79r7sV6w4Ag8AkZq20+Eg0YUM0l2V4ReUasALmjhlLgGdihHwwD3t+WRUJ2p7QjCizzzpJ
	xDmrs8raWUjN3KCzMgV
X-Gm-Gg: ASbGnctgr2C5PsEgBquFUeIU857yihvm6xROF7u3q9pKyeubcO9BcRymeBMo6bd883l
	giA6wcoagF4m9YGP0j1bmH7yNLSE3dt27bwYgGaxHBEj8r71bleEHaTWpGi6uWtBDiC5yObmBFy
	fZ1kps8vUTN87Zm3H2+zH3FhOwfncJ8rTm3RO62lkxEmk9lrdV7ag4/T8SgFgX8K8cWjwe07tHO
	U5cfqJT9mXuTC6jdQxCCU3QboFyZeT0cTOnSMAS9fqRJ7rNou3r4Bd0GLZ0tzOEg1ILuZtueEWZ
	3NxcWVd5reNUykyk4SeRPPC7ee7fm1jqn0k2t+S21EgKs/NN49mB/baHXOjSoQCZawF3I+fSvk5
	/voKaSEsfN2Rgg0qc94kQ9ln16Jm4Mm6kNWswME4BEV/L/OT2QSQmcKUaaxh4g/snn41KhLHT8Q
	gl1jXN7IyJ
X-Google-Smtp-Source: AGHT+IFRS7Gs01Hw8McAKFala6JswKuCF8ojN7cACsgGD6XJjmVv3oShVtXurTEgzpFMmXQmRflqfDRetz/h
X-Received: by 2002:a05:690c:9c12:b0:724:bd2d:ac97 with SMTP id 00721157ae682-73064cfe244mr5860287b3.32.1757619320665;
        Thu, 11 Sep 2025 12:35:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-72f7a06f39dsm1426547b3.43.2025.09.11.12.35.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581953b8so13071065ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619319; x=1758224119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4DDAQLElHWgn/kO6TEgJJZR7NPyqBFo1FrDy3LSQVU=;
        b=NcuaEI6lWk34Cg/18prgCDXq3PGaYnfJjm1+llHbYojpEgDMia2LcuCwINzqiwRm0I
         sFqNTMjkfuGsxg6X5tMjuvGgZ/ROpyutlHZoJcpF4i+5dJgH8A1ZkgtLl+OGP0g1hWss
         Ny0AQYKI+uFuL6YHJ/7Ep+MnzuOCgSGryAYHY=
X-Received: by 2002:a17:902:e809:b0:24c:ecaa:7fa with SMTP id d9443c01a7336-25d26a5ac9bmr5002185ad.48.1757619319326;
        Thu, 11 Sep 2025 12:35:19 -0700 (PDT)
X-Received: by 2002:a17:902:e809:b0:24c:ecaa:7fa with SMTP id d9443c01a7336-25d26a5ac9bmr5002065ad.48.1757619318976;
        Thu, 11 Sep 2025 12:35:18 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:18 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
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
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [v7, net-next 00/10] Add more functionality to BNGE 
Date: Fri, 12 Sep 2025 01:04:55 +0530
Message-ID: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patch series adds the infrastructure to make the netdevice
functional. It allocates data structures for core resources,
followed by their initialisation and registration with the firmware.
The core resources include the RX, TX, AGG, CMPL, and NQ rings,
as well as the VNIC. RX/TX functionality will be introduced in the
next patch series to keep this one at a reviewable size.

Changes from:

v6->v7
Addressed comments from Jakub Kicinski:
    - Removed NULL checks that are not applicable to the current patches but
      will be required when additional features are introduced in future.
    - Handled unwinding at a higher level rather than in the deep call stac

v5->v6
Addressed comments from Jakub Kicinski:
    - Add appropriate error handling in several functions
    - Enable device lock for bnge netdev ops

v4->v5
Addressed comments from Alok Tiwari
    - Remove the redundant `size` assignment

v3->v4
Addressed a comment from Jakub Kicinski:
    - To handle the page pool for both RX and AGG rings
    - Use the appropriate page allocation mechanism for the AGG ring
      when PAGE_SIZE is larger

v2->v3
Addressed a comment from Jakub Kicinski: 
    - Changed uses of atomic_t to refcount_t

v1->v2

Addressed warnings and errors in the patch series.

Thanks,

Bhargava Marreddy (10):
  bng_en: make bnge_alloc_ring() self-unwind on failure
  bng_en: Add initial support for RX and TX rings
  bng_en: Add initial support for CP and NQ rings
  bng_en: Introduce VNIC
  bng_en: Initialise core resources
  bng_en: Allocate packet buffers
  bng_en: Allocate stat contexts
  bng_en: Register rings with the firmware
  bng_en: Register default VNIC
  bng_en: Configure default VNIC

 drivers/net/ethernet/broadcom/Kconfig         |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   27 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   16 +
 drivers/net/ethernet/broadcom/bnge/bnge_db.h  |   34 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  482 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   31 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2155 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  250 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    6 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    2 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   67 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3078 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


