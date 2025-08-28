Return-Path: <netdev+bounces-217814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A00B39E8D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9475164345
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7DE3126C0;
	Thu, 28 Aug 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gryf6Kba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A126311964
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387137; cv=none; b=WdUKy9p/4vVl8r0Ta+z+RSId30tTVSW1lvu0yBvplgBLnnnxlNwgXk+aROa3IUR5zQrbFfEi7L1wLJvTjbgek7FVp5QNGaWnilBhvZyv4S8ybAylSD1e0Ek84QsMJdhq2+HL9RewpCEa0m5znLpdyP3nb1cgYteoCDW5kpcI9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387137; c=relaxed/simple;
	bh=QEW+OhFN+T4FmSnzJQJw9bi/llAhDxc5UsY+Ui2/fc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSapoKJlrAQGMSHrMrBAqGIZuBGK7FEJfyh4slLN4Dtr1VtjFywIur+mfOy0o9r/e6Fwi/vJYKszXgZulWxi1hV5LPqPQhGNEmXYzVRBbxTdBuLM2ivroMcnZ4//nqfKMe/fBUNwjcex6fklJ8dX2jVon0nfzuz+4eLqQewkzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gryf6Kba; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-7e870689dedso61447985a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387134; x=1756991934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epXRCa0/NqmWmZnYhhismgrmqJPJFawMDtKYxeRatMA=;
        b=kZ2JqqjM+DRx+u4yul5xwutDSYFnBzEpmDj1nZnE1r5VCADtShAfGDjDKygNPoJbdK
         J1kuDpoI9VLLPCYQrC8UTcZmsuoHPBONgvv/2dzujJtp0u5GQOs3zieQUIexZbL+SsOd
         pOc2/0+GlrVo3f/pCNmBup5Y2eW/WuDgqbHztS/Cn2OdE5Jm50/Iwe39gSfJnulxnv2Y
         86fXGAhzIP92NwyLOy/KaIIcnu4OWXNI3cx704hVLV6EnIn0GA/4emlUJ6hCQSeaSzW6
         1KnZparI7VVvwZFRAeQ3W6shrStqHe54op3rCVVf3azzljiaZ26O0F+iQ4lILiZE1/+b
         UOuQ==
X-Gm-Message-State: AOJu0YweIDBftf2F/p2rW0dZv9rfuo3P9/G6te5BxL3yCCZDh/H5r2f6
	m6sKKbBk73Mce6vIVPjDFAsMOiLZBWCqrbHNpX1pVBK2kc/vYg3ZVXSht2KG86tS7h/rSAMkqbB
	984oqwmJ1HnZuu9q7HCTw+EE0OIRnchghuUXAwWD87QRsd8DO7dGd0AigO+/cNLL8hzLgXgdKuD
	p3zjeG1+pA4FUbCb8GmWDOGbP18osPPbA7mSmzYuic7ujGVjslpH8HYVLHhK8l/zCKoh2zq6kev
	BOHQg/tGlLsi2gTYA==
X-Gm-Gg: ASbGnctXxygEWNKMvn7f2ErfZj1BHrCbPe557TzIMu11UIXGoIF8zGrLE4VCFw9m4cX
	HxHHTZqoHpI1Mu9U2pdKKvmiVugVs82xEHb89o1tIa9bry8Op5kRUhGRZlVd5zqp7bp5x652kao
	YxG+9pPL/TfSM0+kSEpuTDa7rB2AA54r+pjgESBcmr3GgdyJ62Qz8eNoA/3YzOAh31M5Z+Nagch
	H+rw4oQ0b8GD/UUufT147oPOteEijbTS4P9W57WYMZUtU9/JKOfppwuMh4AtnzVuXQ51R7HFzqf
	W04ANZFTGTuxTI39+HtOB1JO03nIPbPpZ8yphaOYv9nd7i8hRPHp7NMTS9qv61Hxq/rrb9sPpmk
	7kAHBls/i76WwS93HCGQ6k2tgCYZ5oxYXF8Jk2ao6+InwNdgV+9MrFPqosIT9NRQ1xd64qxkKnq
	/i1PbMiEVf
X-Google-Smtp-Source: AGHT+IGxDSeKUFedcIpAufVjiF0u6bfPurI7QlklSS5bV6v1H6ezw1UvRqUqJBUo0Ht3w/Y8Trq2UBV+igYP
X-Received: by 2002:a05:620a:4305:b0:7e9:f81f:ceb4 with SMTP id af79cd13be357-7ea1108e2bfmr2436064485a.78.1756387134132;
        Thu, 28 Aug 2025 06:18:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-70da713a209sm11165926d6.1.2025.08.28.06.18.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:18:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47174c8fd2so1467399a12.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756387133; x=1756991933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epXRCa0/NqmWmZnYhhismgrmqJPJFawMDtKYxeRatMA=;
        b=gryf6KbaEGptA5b+vrY0WOwmavExY8VwvPPWJC7Y73LZCEQmM2RJMSIiC21TDsj4Rz
         WcbMl82sr1VMnktdfWQs2w4lw38xaBwjO3CPaUYVVkqxCP0FtWoFUSKL2ZvIuCuehs6o
         N6cOHh2aObx+AY9FU4lh2wViRsy70rvvi6MMg=
X-Received: by 2002:a17:903:1a88:b0:240:671c:6341 with SMTP id d9443c01a7336-2462ee9bb60mr369059915ad.26.1756387132669;
        Thu, 28 Aug 2025 06:18:52 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:240:671c:6341 with SMTP id d9443c01a7336-2462ee9bb60mr369059585ad.26.1756387132278;
        Thu, 28 Aug 2025 06:18:52 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm36468705ad.137.2025.08.28.06.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:18:51 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [v5, net-next 0/9] Add more functionality to BNGE
Date: Thu, 28 Aug 2025 18:45:38 +0000
Message-ID: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
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

v4->v5
Addressed comments from Alok Tiwari:
    - Remove redundant assignment
    - Fix print info

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

Bhargava Marreddy (9):
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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  485 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   31 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2201 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  252 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3121 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


