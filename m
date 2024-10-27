Return-Path: <netdev+bounces-139390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E159B1E11
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5D81F2160C
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7EF156653;
	Sun, 27 Oct 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvyydbwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C95CA5B;
	Sun, 27 Oct 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730038758; cv=none; b=Ex/alWTERRhrQEAP+6rZEOuGoWTjyjgY/1h6GKomn+l28KkGlkrDOjppnMbS+IIJiL7nwjGpJdTrfcFMTbkWCCEp78MzPLHcEFm20J0WcKwE369U1nT5qEgEXRMgoP6d6fAmk0izdIO9GgXDJyvJ1uaLIEF/TcHfgQo4J/0PeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730038758; c=relaxed/simple;
	bh=pZmdno5w/h5CLZTmP0ycuh7qjUDnBWjUFcxWgjzzZec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hsW8m2IzrRdcpZLrPVKUOwNyYfFHtzizogFYnNkaO7Vs139AVOGQQkA4jlzelXU2iYQaWKXsuWUW7HsExN5+Nb0s/vWQSeXOU6uH6mYTg2PgPRjz/BFFQByvm5x31ehvBOKi5cM5tSIf9ZwUfCN4Uc/aQz45x1Bd8+uKKeuPPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvyydbwQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eadb7f77e8so532239a12.1;
        Sun, 27 Oct 2024 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730038756; x=1730643556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXPjWYkS1ou6WAfmU+S7znEG1ISKjNgZKIg99AXek2E=;
        b=QvyydbwQidV7h8Fpku5xCGqhDxO/kp043cqfkL9RmheuDZqQp1JP5+cByVZbLcp/Yl
         vwi8ee/8Bffh55juFrTXEuKPBgv0i7f6KBLDcqeLSbQMe90UoH5EsbmyCUCBGM2AOieq
         PLGduHIeCmV2KnewXzXnu2nniVfL7uDnZKpG+SOIUx8PO74JOzCZwxLlYYSfxflr8alt
         7qkYmfrtzyytWadfqLITG57lNvasw+qHXNCdGvkw/+vt4vSC+0t+d1Ad6QQQM48Mnp7+
         ibjecHJRmovFZdo1kHO/6tJ89MsOIlZEe0CMpydaZseWq6vAf/laZCwsueYRn/6n2MaV
         nKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730038756; x=1730643556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXPjWYkS1ou6WAfmU+S7znEG1ISKjNgZKIg99AXek2E=;
        b=R4oQoA+eISCjapKoSJ4HVOeeiu26E5YjtjIcCLwDxyASNcnuV7M55lXIyKvY51+lJI
         tF4R6z30o25+1pXwYGQMo9n2egnJcZddAODLUDDNUJ9Cx/u4jkTem17C6pKCQ0f0N/TC
         Eb/Xnn47l+4qxiCtNLQLd7eYYM/XZi8yxawM0znxc3ChjYn6SoD/nj4jtN+eiOIQcSWs
         EJckBRY2PHJvGZfcNCtUd1Oy+cw0f1o1GcN39vfUmwxeRTGHIqOeg0wT5uDVIhj0aBXt
         g74WNEDk59LiTEeV/iy5Z1w5LHLM4RUeMZJPfUzLVu6brhS5gwjYv9DEH7IMN5dL8F95
         MWfA==
X-Forwarded-Encrypted: i=1; AJvYcCUFPOskI4J48o2Bi1+YoX/AJUxouvNV7t87g5twhEfVF9bDAEH3BSByXF4C/hEJAzDEXlh2Gyz0wXsvJHY=@vger.kernel.org, AJvYcCXnfUwkqtLMyaXB0FHnGgkR5XTRdzo6s526bZpiBKedV4XGX2swfCPbJSTopNblTQAMWH/rJ8O8@vger.kernel.org
X-Gm-Message-State: AOJu0YxeebJ5jSubDhNANnzo+IiIMlbBtWPIMNy50oIvIX0ndckHjwqF
	KUM1PC0yymLLb1CylRpaphQZ0hZ2m/spqsUoIYJZdzEp2vJ8Ki6b
X-Google-Smtp-Source: AGHT+IGdcF+/Dvwbm6ynLf8C2n0Fs1lvcxhZ/buJsFTOqotTyakOouENBfyYD4vXxijoqhpweq464A==
X-Received: by 2002:a17:90a:cb8b:b0:2d8:be3b:4785 with SMTP id 98e67ed59e1d1-2e8f11beea7mr2607524a91.6.1730038755626;
        Sun, 27 Oct 2024 07:19:15 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:1331:92bc:956d:bb87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bba8sm7350367a91.3.2024.10.27.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:19:15 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karol.kolacinski@intel.com,
	arkadiusz.kubalewski@intel.com,
	jacob.e.keller@intel.com,
	R Sundar <prosunofficial@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] ice: use string choice helpers
Date: Sun, 27 Oct 2024 19:49:07 +0530
Message-Id: <20241027141907.503946-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use string choice helpers for better readability.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202410121553.SRNFzc2M-lkp@intel.com/
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

Reported in linux repository.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:396:4-22: opportunity for str_enabled_disabled(dw24 . ts_pll_enable)
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:474:4-22: opportunity for str_enabled_disabled(dw24 . ts_pll_enable)

vim +396 drivers/net/ethernet/intel/ice/ice_ptp_hw.c


 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index da88c6ccfaeb..d8d3395e49c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -393,7 +393,7 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  str_enabled_disabled(dw24.ts_pll_enable),
 		  ice_clk_src_str(dw24.time_ref_sel),
 		  ice_clk_freq_str(dw9.time_ref_freq_sel),
 		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
@@ -471,7 +471,7 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  str_enabled_disabled(dw24.ts_pll_enable),
 		  ice_clk_src_str(dw24.time_ref_sel),
 		  ice_clk_freq_str(dw9.time_ref_freq_sel),
 		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
@@ -548,7 +548,7 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  str_enabled_disabled(dw24.ts_pll_enable),
 		  ice_clk_src_str(dw23.time_ref_sel),
 		  ice_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
@@ -653,7 +653,7 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  str_enabled_disabled(dw24.ts_pll_enable),
 		  ice_clk_src_str(dw23.time_ref_sel),
 		  ice_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
-- 
2.34.1


