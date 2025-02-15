Return-Path: <netdev+bounces-166694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3FA36F85
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AA27A24D1
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432CC1DA31F;
	Sat, 15 Feb 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV1jBYvY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54AC1A5B95;
	Sat, 15 Feb 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637861; cv=none; b=Stlg0Vr6oaz3j2mQGfVikhARpoG+IdrxaY8Rt0OoxCgdoS3kA3kxx6gmyqsBNU4O89k+cFjWeNS5KIxyOow2A8ukQZhSzIiK6Y2RJls8MJcKO0/X/nMUmwp5EbS7lN0suK+O1n6GYlOm5N7ncZsYxznvON37bx0XXE/3UWfvQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637861; c=relaxed/simple;
	bh=ViqK2ervE/POO/iJFwLWQY5ukOPXss6ZmDi/xAULonU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOwYDNJilCOAuE6RmJjoRnr2wwjZpgN1JHsiFGGvuWZKoNdtfDWCkEaOL0NBgiwCrNHJtOiM3AIMdzC/H4yBLIOJJ09PExm2JHzloTUkgR+UsnFh9MADN0fbguZaMrpRArqsVxw4BlmaVEm7PyA2EDKmMMhMp0AUF32YYuzSa4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV1jBYvY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22113560c57so5152385ad.2;
        Sat, 15 Feb 2025 08:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739637859; x=1740242659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zen24IcM3djM9YgCwghgtHtMwzQ4LV/2qqQkL+b6/N0=;
        b=eV1jBYvYPeTeefHo6rmjGrL+c0MFbRY7DS3NdGJovmczK3ak9qCC0x3d+ANpE7uk8K
         PhtHL96imlta8UFix/3VD5KIvOFyAp1llPR0RMYZGux8mVQpjbuPnE2Md8UjX1KuX0LR
         pgAN27F5O42OFN4fVz6DEsMcillgYUIvtTrkJxQrr/6jFU3dci05+xEwrgyhlpGcGFaE
         hcb0VUGzgn1WIhnv7LyWaVO6Ah5SSO88KRPsJbCUbgNamVMKwrbxYGV+oYv2HH/EZHdQ
         d0o7+w8XqbxKCL6DqhGfh2C0UuTcca54WnALlpOBtm8+1Niv0VRMVqB4tawmUVVwx4F0
         1kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739637859; x=1740242659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zen24IcM3djM9YgCwghgtHtMwzQ4LV/2qqQkL+b6/N0=;
        b=RVZBqZ8NrQ0kiM0EOcGwJ1WYQRvZESn7AbmTSshg/lRiFuC8mlwoLLKuHH6kzqohDv
         lqfrKSP/X9t+0QUo3LdgGS8clYtEKNDsjsYKtCLVqQ/VYSqyU33DASw6EuvNCocv8F8P
         5X7RnxDEEOlL07o6D0F/1Tje3vPp4NKynVn04ABhQG1XUtF7wgNYTh3P6LUlNefV1fAf
         JiCvba/VCkFQGNAsCuQabFmkSaBD8mxUa9ouNeaz9qRyX1P9UtKR/+xG0zyVfuYpE03j
         qMilS0GG6KSBn2HjrBf56WKOz0wwE2BFPJWp3JNywm2WO/U0WIs3DqZnbIqTG4l8Cldu
         gqWA==
X-Forwarded-Encrypted: i=1; AJvYcCVis64liKrYCJ5x8IF1o+tL2FvsPmC3hgXtXQt7AVqTocX7TUJhRAn1EbXShTAYzawIwgrkoP5wli81sPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGFw0TAZP1mvZN2v//VEIJY9qBmBxqzaCdcmfZMLgcpffov8c
	qbENRDW7HdZ836tFBvwZiIKwgsc8SKNJOyQf4h5kAjBJBLjC69te
X-Gm-Gg: ASbGnctTqCnMrtVdIvk2UqNf3jjeJG9lP3+cnjdKe7cDU7wc8FJoGc8TpH03SN6GIqA
	4Vm/f4o4Kc416x11yPFW2wdshqfK5tUsxQZXdod4SUANi7KJxadYoXITYHdZm/ioE/wFrgdxGtn
	lDrLKKSssPm/pDji+e3N883MCtFCgSg/W1vMWBQ9SgG93GyN6EttBVn6pPd/QpWbqtHOaOv3hRA
	8uBJDmmqfAGRBXmPNcccKkolvbn2+dA4fSaC84KOz5Znshgq2iyKTL3RM5TD98YObaq+o+nGfsQ
	7B3QG4Lk51ecoRfDiNEY
X-Google-Smtp-Source: AGHT+IEB5/OkP6MlT6rURyfDn95k/vC4OmFIg6jcwrba1EZXG0N0SK2ZbXoBU4WJ2hpKhgmrU7THSQ==
X-Received: by 2002:a05:6a00:c9:b0:732:6221:7180 with SMTP id d2e1a72fcca58-732622171dfmr3553434b3a.5.1739637858885;
        Sat, 15 Feb 2025 08:44:18 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326dba6585sm483348b3a.14.2025.02.15.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 08:44:18 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] net: stmmac: Use str_enabled_disabled() helper
Date: Sun, 16 Feb 2025 00:44:12 +0800
Message-ID: <20250215164412.2040338-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kernel test robot reported, the following warning occurs:

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:582:6-8: opportunity for str_enabled_disabled(on)

Replace ternary (condition ? "enabled" : "disabled") with
str_enabled_disabled() from string_choices.h to improve readability,
maintain uniform string usage, and reduce binary size through linker
deduplication.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502111616.xnebdSv1-lkp@intel.com/
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 96bcda0856ec..3efee70f46b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/string_choices.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "stmmac_ptp.h"
@@ -633,7 +634,7 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 		}
 
 		netdev_dbg(priv->dev, "Auxiliary Snapshot %s.\n",
-			   on ? "enabled" : "disabled");
+			   str_enabled_disabled(on));
 		writel(tcr_val, ptpaddr + PTP_TCR);
 
 		/* wait for auxts fifo clear to finish */
-- 
2.43.0


