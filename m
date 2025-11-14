Return-Path: <netdev+bounces-238753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6AC5F1B7
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99033B2594
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F52F60A1;
	Fri, 14 Nov 2025 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QNCH92DA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAE2561AE
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150026; cv=none; b=tcT235E/gIRLa5fOGo7bQv8qm/60lMhZ30jgY8yKd0LKVYseLBJRIvMrtFOcdB1la/nMvcg9qdl/iGERcx+11owsRdY6wnIWRpt0nDp2RHXQB7m704P86YHpCY1ZieAGNPux9VOTrrtsgTeSA4w4kmd29dzVPWFsOaEi2o4uckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150026; c=relaxed/simple;
	bh=75MA5i2PBlwpaCYC9FUCDHzLw5XZZq6NnSBqHgUV/CI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pigq7Ff6iRGys1nTatCuCP67j5RWrJjnFBQnYwMt+pe+swObCOzCTUL4PpFFhOZnec4/NI1F2eAN0pG6N/fsi7xbUkBsPxi3mBRdxlUGvHKkUaPUG6cnqFY+w7c4fH3QS/q4pxcfya6nnhRgbLyojXmQid6g3e96Uz0hqJfIdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QNCH92DA; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88244d1559eso30384546d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150024; x=1763754824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPdl0c2x0LgW9HCX1OZIOx2Dhv5vMa4vVebZB/NXryc=;
        b=ATvH/9fuU68J4h2IhQIOBt1Rn47Nmwqhl3QmjUsNBuuC0QBJkKg3H4JS6Vm0rWAEH0
         b/VHxM4q6wETogWHNskHbZGEzKf/FwqHtQJTqhYmgOZj9zR8HS0M2uj6GAv3O4LmxoxU
         AtZmL3rus47zFn7/7lvz/UyV+MKFrE1uzXmi/IsyEYN9cm7D4UUkafDNqk7T3nsEw4tB
         F2lAEbVacg2MDyK55LVE8ZHTapTvRv4RvnbKyHP15IjLYUSQ3mfi6+qQ+ke02msoPeK3
         fgrtTkFeuZX8YjhICev+qw+4fX8382+t5J8xOR323LGJKvesfJnjTv9cIgXaI0NJ64Gk
         UB9w==
X-Gm-Message-State: AOJu0YziwzwfMT4IRdiayw8AgCWQRqDRqcXEdsm6BlhvusxZnv+5fS70
	dylw1W8meb+aRzg17Zr/8KQZu8CkNAYVYh+2o10YzqC7z3HmnxawVs2V2DOp4XZjUSpQM9HU2Dn
	Yqx2vZXBrUR+3ghpOAMzi7ATivdErLeWpdUxTb9IOr97+xu7mjh45Qgcs+deZfdPgV2o7tZDx7y
	4f48Fozh1C2UBw6T0NuDMffZZFtmv8sHsjj5NYDcDwEXlVSS3Lx9k5oKZytgwbVRdyyxiITv9EA
	iNX610grmyODfA9sg==
X-Gm-Gg: ASbGnctK242KM4jYOF7TjeNdvNlEd3TWFFCYMBwni0nJvHTcAqsFF6etD+BRcA3DfYw
	apy3EIb5BmexPiNRMcMBp0OMJ6tfWO9iZf6IOx/Nr/zSouWPnWAr6+aO9gVzkZqT4Ms0EkUfnMS
	Ia4aYQz6OcwZPBGERJ+q9+LfgFztZSBIr/PKuzxqaIGq6gwHhTx8HDnIIdFxkZAwS6jJwMSD4ST
	rKWlLFtRHLnOtfx1bjZoKo61kvRrcBI/ZzTXMlxlvYuyG+eGRZHBr6OsRqy7tzYXfxNk9S3xOGA
	757Wj+pHiwPu9Cr1K/yWlaCThpdQ2+pptRffip3YL/FvZqpH9Ag0ADkoGdDyk6kdcxKVRtoEWQE
	0RIPuQTWGb9XQxo9oVwvy9RYxDgk9miSghGXs9ECKym3vz4TDANMXW3rUtxc0zvmVbYx53UOwOm
	Sfo2h5Ym0z9zI1j8K2202HhuQyrNTAhr77VPzfmMaZWRU=
X-Google-Smtp-Source: AGHT+IFoDij4SfMbTruVhXVGQRg91ao4g+Xqa1NINthPlVtS+8AKtMDx3Gh4zdwGpRgUiYF4Sf9MU64YHd2D
X-Received: by 2002:a05:6214:e4e:b0:87f:b567:e7e7 with SMTP id 6a1803df08f44-882817dc273mr121097896d6.14.1763150023788;
        Fri, 14 Nov 2025 11:53:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8828653a138sm6353686d6.20.2025.11.14.11.53.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:53:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3439fe6229aso3448366a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763150022; x=1763754822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPdl0c2x0LgW9HCX1OZIOx2Dhv5vMa4vVebZB/NXryc=;
        b=QNCH92DA+Ktp7hVqjSIy14TzMGYkOdNEJfpKghrC/ZBuEzGWn39Ck4FyBAIUA4Vsth
         wKRAEe0BuABqcPolV9lOTN2x8uVs8FLDFmuNY6/J5F0ezageUgpeQtx7qLql7W1Gh391
         Hp6zNnxSvz3p/8V9+x25EuXQ1bwY4NxddGRpQ=
X-Received: by 2002:a17:90b:1644:b0:340:8d99:49d4 with SMTP id 98e67ed59e1d1-343eab0287dmr9554624a91.1.1763150022545;
        Fri, 14 Nov 2025 11:53:42 -0800 (PST)
X-Received: by 2002:a17:90b:1644:b0:340:8d99:49d4 with SMTP id 98e67ed59e1d1-343eab0287dmr9554607a91.1.1763150022168;
        Fri, 14 Nov 2025 11:53:42 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea5f9fa4sm3108113a91.0.2025.11.14.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:53:41 -0800 (PST)
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
Subject: [v2, net-next 00/12]  bng_en: enhancements for link, Rx/Tx, LRO/TPA & stats
Date: Sat, 15 Nov 2025 01:22:48 +0530
Message-ID: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series enhances the bng_en driver by adding:
1. Link query support
2. Tx support (standard + TSO)
3. Rx support (standard + LRO/TPA)
4. ethtool link set/get functionality
5. Hardware statistics reporting via ethtool ‑S

Bhargava Marreddy (12):
  bng_en: Query PHY and report link status
  bng_en: Extend bnge_set_ring_params() for rx-copybreak
  bng_en: Add RX support
  bng_en: Handle an HWRM completion request
  bng_en: Add TX support
  bng_en: Add support to handle AGG events
  bng_en: Add TPA related functions
  bng_en: Add support for TPA events
  bng_en: Add ethtool link settings and capabilities support
  bng_en: Add initial support for ethtool stats display
  bng_en: Create per-PF workqueue and timer for asynchronous events
  bng_en: Query firmware for statistics and accumulate

 drivers/net/ethernet/broadcom/bnge/Makefile   |    4 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   41 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   35 +-
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  637 +++++++
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  214 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  395 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    9 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1289 +++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  191 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  734 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  465 ++++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 1604 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  118 ++
 13 files changed, 5686 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

-- 
2.47.3


