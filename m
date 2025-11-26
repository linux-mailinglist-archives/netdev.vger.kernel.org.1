Return-Path: <netdev+bounces-242080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF2C8C20F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BC71351AC5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23312DC35C;
	Wed, 26 Nov 2025 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gAzic4y4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC57322DA3
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194258; cv=none; b=tFp044v/tRMg5PHeZCObq61Lgp/mmuXvHZhjwiis927bzmpQC2Tbv1DFOCvVCRPydo6MCwQRYt4CD5lhLz9RJebQx3RjnhPtHJnU7duPoKZh+Smsg/9Hc4fUG4yRZMB1+0w4Sz9RQ6llN7fks0Z986nW7TBaKkqciGRDqNZ/jyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194258; c=relaxed/simple;
	bh=q0735M21RlHxByrV46ifCXrf3fvDlSRAO2f24OyWsf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+BaO6fseqFoF9cVL9G9fGnxV1ADcB+UlCVRLcrEpL/gIn78nfYliFaesoyFAGzm0MFKZKo1nEzPBYWogut4ncZrSK/2YzVSEqLyxDLTNdjeLATaLh5M4f+m3xi2OuMrl5ot0Tjry3TQI/+YaJzAyHhba5YXVaD6hYkSx7ArTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gAzic4y4; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-948da744f87so12078239f.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194256; x=1764799056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZoe8FIOKIhZdcQ9UOoYRdFEbVExihOehzqF5pivtek=;
        b=Zy7tMcc0q6fozHM2jcuGeq5EZlWVAsaB1VlERZujUbEI8aUKXZiXLWBPMX9O4tz2bT
         /2vbwaXXs8/DtnaXy9npPMtw96DLKeB8Ahff14X3EloAGngR4Xa6zB/SdrCu6PpGu76u
         DmzLqBsyeqzW/9rTW8xdBxufs3Gas0olSx7fL+76VQZwksDcDiw9cKPQJYi7CMSEsx5m
         FVTf8WFTgwSEFBgwhs+ZFXIppwRFJeXpRgtaGoSWyLbp70KVj/zhqUUUBv3IG2B3Kxzp
         0jTg8eYmUCu1JtcQA50oF0EUOtPrwi0vt0D/iNp8o/MlghjEyAhdbuDHpEzwovVNJctT
         zMLA==
X-Gm-Message-State: AOJu0YxqbN6qsuWN1Dz0+sgjFjWY0shbBH2iccZM4yXSYtRdxs/yh6EQ
	S+B0PK9gKHTBlerDoWHiR8vGVFcgdHenGfODpObp8Ae64RGDGg9RIpVu18BBeymeF+D5SN3LeJW
	OjsGUvZthEeJDMyBHea9KgsSJV8TzS6QBb4N41FNCNhQYqYJQhPnTxh3qAIThw+Y3SM0kr5NIw7
	/NHY6IXGMb6wGMi42l1YSPPXBBiYsyED1xv15leKKHcwG2gXoDN0tjzP1PN+PckHyGa07eYmgSI
	wIC7A3sJIY=
X-Gm-Gg: ASbGncuYoDn2Rw0ABOkSiAneDrul7+q6GX7Eav66LBe3AfHVhx9mV2rEPkhltAGBQHW
	vvH4pQnhg4oA1S3wi/6xDt8bTOtWQ9vSpMHporODbO/ZGiwvRYm95xy+V3+BSfl2DUh0HhZE+dL
	KwkzzxX+ntdG8R10DG+/N4tPTTQvuZ1qR+Ud+ga8I3x9La7mLYg0wzNJskNHpg31NxO2TsuD6pC
	kY6nD50imfKKtivPjZhclCPiPQYS7Y3CPV422vsEyfkm0Ufsci7OmxHLWJ1UGl3utMZJ3zQpdux
	U2iUaHHkACYTM3rSOPQHxWe8ljXm8jlgXPOkhWO26Gggg0/FZPsS/Tl9WpFg/rJPAsb5N/oPr2v
	aeEgDPBvJGCYG1NkqvCQfUANjPJfc3cnP5qLxqsmBLvd4/NPfQo/qsNEb/RJ2DC/Q2OHA69kj8y
	vdwt4h053QzCHhRF4aULQkCdnvbmCTRhIFzqqKAijGXle5
X-Google-Smtp-Source: AGHT+IFTv9km5/JpnCL7WbkbnBgOH4jfS5BNkCKRkZzNB/ggk/Sh9RCzOxRkhgx/ci80QSJSqjcQE4rtTc70
X-Received: by 2002:a05:6602:2c05:b0:949:305:fbb8 with SMTP id ca18e2360f4ac-949776beb36mr700769839f.0.1764194256227;
        Wed, 26 Nov 2025 13:57:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b954b1844fsm1817061173.28.2025.11.26.13.57.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:57:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a1c15daa69so57884685a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764194255; x=1764799055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZoe8FIOKIhZdcQ9UOoYRdFEbVExihOehzqF5pivtek=;
        b=gAzic4y4fqsG22ZvALdSY2GNONxpR7v8SINrrimIZVLjuvLG59aLR1lXef1rpHCP/n
         aNLvgSNdRLjnmh/0hLQ5cBpO+i5grkXcf3dnkkKMC2e5EFazo23HWpfF3hZvBAQuNSHy
         M+ecIIOJ3/yYSp8yDjyRBA9wfDr9ERK1T0gYk=
X-Received: by 2002:a05:620a:444f:b0:8b2:33a8:5030 with SMTP id af79cd13be357-8b4ebdcc644mr1086921885a.90.1764194255257;
        Wed, 26 Nov 2025 13:57:35 -0800 (PST)
X-Received: by 2002:a05:620a:444f:b0:8b2:33a8:5030 with SMTP id af79cd13be357-8b4ebdcc644mr1086919685a.90.1764194254853;
        Wed, 26 Nov 2025 13:57:34 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm1473933185a.37.2025.11.26.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:57:34 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 0/7] bnxt_en: Updates for net-next
Date: Wed, 26 Nov 2025 13:56:41 -0800
Message-ID: <20251126215648.1885936-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series includes an enhnacement to the priority TX counters,
an enhancement to a PHY module error extack message, cleanup of
unneeded MSIX logic in bnxt_ulp.c, adding CQ dump during TX timeout,
LRO/HW_GRO performance improvement by enabling Relaxed Ordering,
improved SRIOV admin link state support, and PTP .getcrosststamp()
support.

Gautam R A (1):
  bnxt_en: Enhance log message in bnxt_get_module_status()

Kalesh AP (1):
  bnxt_en: Remove the redundant BNXT_EN_FLAG_MSIX_REQUESTED flag

Michael Chan (3):
  bnxt_en: Enhance TX pri counters
  bnxt_en: Add CQ ring dump to bnxt_dump_cp_sw_state()
  bnxt_en: Do not set EOP on RX AGG BDs on 5760X chips

Pavan Chebbi (1):
  bnxt_en: Add PTP .getcrosststamp() interface to get device/host times

Rob Miller (1):
  bnxt_en: Add Virtual Admin Link State Support for VFs

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 34 +++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 ++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 +++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 46 ++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 55 +++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  7 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  1 -
 7 files changed, 148 insertions(+), 18 deletions(-)

-- 
2.51.0


