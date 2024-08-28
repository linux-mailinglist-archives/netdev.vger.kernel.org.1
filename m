Return-Path: <netdev+bounces-122886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE896300D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EE01F24CA5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F7D1A4B82;
	Wed, 28 Aug 2024 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O0nF7rIa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077919D8A4
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869979; cv=none; b=uWPneO12Ja4WqSw0fjf+4Jq5Z70heVsggu/K2y4fZ4F8Tfrcha5EyeQQPt9g2ekT3W8wvQfX5q580LeCztyAGqouCYoN9toQGMm0baIQbmE4IFx+ny4uFT9qGuZPtBKqN8ocPyyIhLxeWjXYbWqJ1iQ3xhmZvUYXi8i6pCQdXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869979; c=relaxed/simple;
	bh=1QoVojL7AgLHIDFE70CvZWt92aAXg4BTN69zqshnV5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UB6UiGHQ9x4vRXsc/IwaDdDKIeKRsmII+FSrR26UXpI4gDeAeQSZM1/lhN+EzUIQRWZf3I3LhuxaW5EUDJeytU59e2IPHrsm65XH/cnWbnsypx7eaegRsln1tfCL16TLPTQ3QAZVgLTs8E7MAaLrdCaMyNCeoEM9r2IH31I2xtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O0nF7rIa; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e11693fbebaso7471675276.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869977; x=1725474777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FloWRDOBTlYrF306qltrS/yQ3ym0PC800/zOGo9ZrZk=;
        b=O0nF7rIaO6i2oGNwrjZ3484+PG9zqW7Gftyn32vgIfMJrfbg0OfKnOd3k2O/ShVupq
         ZbQ3qv7I876NTACHX6B/5ExF4Jm8E53LH8kYpseEnLQRo7Pwdxhr3CrVKxs37bO1u+dn
         QLCAPjB6v+DB2PmxEMZAHKEXLFsXLOjouko3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869977; x=1725474777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FloWRDOBTlYrF306qltrS/yQ3ym0PC800/zOGo9ZrZk=;
        b=EBcFkKCqc071Cgmn0spxXrwaIJl56Hm3DAUOU5Jjzf3vHgAKS3oFScOu9ylmbTuub6
         5SslQ23TVxSivTLLGQIJMYCBso+t643cM73Y716oC+gaZnHG/HTDcNZh0rmHMuk58Bd6
         W/pUi4BDrRN09CDhH4BZg+vo7KLp7bbniKKfd3PaYNuG0DiiotNKuBB818rqv1oV8cRG
         lMd6IdAtXWqWga81nx9y8YWkNd/o/iFabFn6T5TpN07qmXN8gJyZltWdg5tn01V0BWTg
         StiOW/4rIylbHpdUihjENBhz+vIbE8FlweVZRmGG4cE0NPCHmbkyvHmIQIfjY6yZeb9g
         GeKg==
X-Gm-Message-State: AOJu0Yx9U4vAPMg2DnP2SA77C/UnOk5590QdxJUJA1/VgGIpwsJWtsWv
	DEv+ZbiFkAV/0E1Ai2x1WjOwzmdg2bM4jZryQXP9Ok8jAerNdv9HkmM/lIcPGg==
X-Google-Smtp-Source: AGHT+IFBDgsu79ksV/TTlA7yCqGhxfvYM2/Zs6ss/6vv8+MURmvC/g2DSfufXhZMji+5sylg/ExpSg==
X-Received: by 2002:a05:6902:843:b0:e0b:eb96:fd90 with SMTP id 3f1490d57ef6-e1a5ae0f513mr307467276.45.1724869976745;
        Wed, 28 Aug 2024 11:32:56 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.32.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:32:56 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/9] bnxt_en: Update for net-next
Date: Wed, 28 Aug 2024 11:32:26 -0700
Message-ID: <20240828183235.128948-1-michael.chan@broadcom.com>
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

v4:
Simplify patch #9 based on feedback from Michal Swiatkowski.

Link to v3:
https://lore.kernel.org/netdev/20240823195657.31588-1-michael.chan@broadcom.com/

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

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 310 +++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   8 +-
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    |  98 +++++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |   8 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  13 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  29 +-
 6 files changed, 279 insertions(+), 187 deletions(-)

-- 
2.30.1


