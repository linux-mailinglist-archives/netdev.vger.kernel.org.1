Return-Path: <netdev+bounces-215705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7BB2FF2C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C06E7AE989
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A62D0628;
	Thu, 21 Aug 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BsKIjGVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA827702B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791319; cv=none; b=ChV2iSZHKVxRHI1Y8u5MV4GF0PLdcsY8q436X5/wa90HgOYfr4J0IXaAcHaJiKcYumvJ+kZomd3FaBkV5AiNtkPyfOd5uWzr6iU94NZbcWKmYou70mQeqSAqLAUXMbcX5vHBzP8h7kt7cHyhvl4Td5mN08BIp6WmDYeKm/KCdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791319; c=relaxed/simple;
	bh=QxMezdxGdBtB5eRD0pROjljUigKSdcuW8FalgQx9w8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucyCpnQ2MVdn46puKDGUNq8LH3RjC3jkLtvmVme8m/UXgnisOIgEQpxZPK21bCEpCP8yRQXLhDPteb04aoxRAuKxyxtd7kzaIBS9kHSWdn/3fWAakm6GlUU07L6l77eKmEPjQWSmwdhH+ifgIx08AMSLwH/aVWWdm3HiujH6qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BsKIjGVV; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3e57003ee3fso5024195ab.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791315; x=1756396115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnMi0sjBhZE4uuElmYuknC/E7+AMHFdyHEwqPSdU9NI=;
        b=OeLYXtgkJAVC5Nj+MCkKV1A3+wtDVSTSBZQeInoyyH4oqJ0hGa1Fhclm6wr8s6UyzU
         /40oL3nuvHGSqyf6KFhKdR7aYJ7KbGagHyRHFTxnrZqsY1W6RjN4gI3xnDWG+3acdrYM
         239ysV8acFRTwlPzyfOJYp9JzONSsG1nH5zjdlWog6L5p4x4KoNaT0yM3+KF6QcGlmoD
         /0cchH8omIEtqVrwQnw39kXa71Q7Tx7bGmPjyVv6Mk7kxE4z26Q1woM97rF7Eq0b62W8
         IBBMKHZx3SWIYMlQklJou61+voqsc7rWrZJrDp8YlIGfOpGOqUYeNH9WIh7oIrqX3l2z
         A5SQ==
X-Gm-Message-State: AOJu0YzjR+JPm5iKZJ2pn48XittVyYn036oHMekN5ssDEFGaDSc5a/JG
	o1G4QsMw6tneIbHnf+ZNuBDetjNi4stQ4XyzQftG6HjX5D3UOTWeYubwjYpK7WUYw6Vj2tQ252A
	vUK5fvVpoguZZr2Voe6ExedVx1S2fkCqAyEeMQvSRlK2q7/7F74zicQmWNjwtuQyzOykScT1W+F
	8fcXaIMZrwGc7C04Clj9zn++CF9E2f3CBCRmVIo9QivY5b/s4WNCPECd5hgPrkGp0whlgDvi5Zf
	952lI1Ps7CY/y8IyYoZ
X-Gm-Gg: ASbGncte5Pya5DvUvV+2igTYYGkLOYEzyx9Fb0/CWA+Zbk49EtOSU0oO34sg5r0WaV7
	eNd+TDX0HLnbtsd0LYMtVQI4sviwIEzEAygpPZZkTmvUPTHQPbtIMbZtaIrl5AmMljFG/JgISe0
	cpIjAYGIOogLI3rakLoKVBjza0st9b3HGMPeD4fgQOy3Q3f8mN79WtFl57l5xSOzxFgVXgaNTuW
	1IiMp1WWSxajuZfPHtPrrbtiT1fdH92fvZWNGxeIAJ5ztnsThXo3aRMrFddkqzXByw312WdV8kY
	O+yyQWjEKlpamH3E7O7rOHHDqpQGAsPOW/a9JEv1qhESmR16xi29Yy/V488sRWm9P6S8KGxioqm
	o57ms4WyVOzHsmtkn9XJl7IsASabjhhLvVSIFpNzNGoKUFg2p433OjpIcMVXNCXE0uKrxngah5K
	wT9fyVBQ==
X-Google-Smtp-Source: AGHT+IG8pS56rq4KYwIUbQE4Zdh+YLEwBmRjVx8pS7ZgiUdnhJD8pCR/079fQNOXp6PtrlDl5MK8+cvIcvAb
X-Received: by 2002:a05:6e02:1aa9:b0:3e5:5937:e54d with SMTP id e9e14a558f8ab-3e6d747d8ccmr49023155ab.15.1755791315494;
        Thu, 21 Aug 2025 08:48:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e67efe3294sm3171505ab.22.2025.08.21.08.48.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:48:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323267915ebso2478053a91.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755791314; x=1756396114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnMi0sjBhZE4uuElmYuknC/E7+AMHFdyHEwqPSdU9NI=;
        b=BsKIjGVVQ8VCgZgVIvQ4xVrtirKQTzllBPLn/+HpA8xkaCM0mgfJtYuq/TGyib5hpn
         ir+SueLMXI6UQboU/EnC5Wle0merdyM+zV0KZBEw5kGKHMgX1biRVPzYriZoc2mOOAN0
         KUEEVBIT7VZtxFVU4Qw1k/M3FNRGWpOXjGuEY=
X-Received: by 2002:a17:90a:ec84:b0:31e:f3b7:49d2 with SMTP id 98e67ed59e1d1-32515d21177mr84868a91.0.1755791314050;
        Thu, 21 Aug 2025 08:48:34 -0700 (PDT)
X-Received: by 2002:a17:90a:ec84:b0:31e:f3b7:49d2 with SMTP id 98e67ed59e1d1-32515d21177mr84839a91.0.1755791313505;
        Thu, 21 Aug 2025 08:48:33 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm5046894a12.46.2025.08.21.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:48:32 -0700 (PDT)
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
Subject: [v3, net-next 0/9] Add more functionality to BNGE 
Date: Thu, 21 Aug 2025 21:15:08 +0000
Message-ID: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2186 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  253 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3106 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


