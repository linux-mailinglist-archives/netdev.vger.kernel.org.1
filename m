Return-Path: <netdev+bounces-190481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D7EAB6EA6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B001BA00A1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743561C5D4C;
	Wed, 14 May 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j8SlTzKF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65F1A4F2F
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234654; cv=none; b=n8eFFPh0LlV0gCfOZYP7OCpvmqwouSO4cdO90zDNLrbhbOu+wx1LDKIrJ7QGyqHPLMnab+g5aXFu6GkgKrLsbM8yjrBSzglLK+xSk3DMk6ND3SJtO+klNzRxrT8h+nHj2ToP3cQWO6LbZ/3UbdBeAVRSlmSWPdHillXV51eGCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234654; c=relaxed/simple;
	bh=e2SK+Xcx34MUUnXo1D2UwfuX6cPlxe368TyiAsmAY+Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eer4fP43inQrUxdco4tyK1G0ynm4Z2eRU/E/G/dEXLQ7Gp6+fdFT0WlxXRyAywGC6I1ja2vzSSPBfolaNi1PKnJ9K4agGNFElOjtyZt7p/SEniewOZ1oVRf1Bsw3nVSv3zyry/UnhlrCqGcjw+dTrl5jZLiw0UQJXQ/89Gxie6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j8SlTzKF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 892883F528
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747234644;
	bh=eJ6Gly97PUQf39g4PYqAseTk8kpWDYMCJC9Zl5UsN4o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=j8SlTzKFTkFYbWDXv6Kiipu1nO0dgpD0f6PPsFDtsIuPtkGAvZdBuYVgQh8IM6Vy2
	 OsXahudFuNl66qBwMai3zglTn8y552QExlavH4FcCaXPkg+OYORZHAy0h2Hgysj5qw
	 q2j7nmBTggPOkLi1ChMmZwk6hawASZtBrBtk4C32WEnLP/KIudNZ6wDaN6IQh0LjXU
	 /RTQNKCg/uGy9KaaYZ9nAmSOPzS5gmne0xUbT7MUtCy4VWWSe/lZg+7WMraHpQ4mgP
	 hsOSAgfUE0YLlO6v6IPRbq5yjHJtAXFDeayu0RqsE5+7HrPtBRZvWiquL7CdjIaN2Y
	 UyuZxQBQfrqDg==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so34016965e9.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747234643; x=1747839443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ6Gly97PUQf39g4PYqAseTk8kpWDYMCJC9Zl5UsN4o=;
        b=fpeLXoPjOC8qsZNDR0/o64XUOd4C3yhYDexhbjW5q07eWJjJXpabU/qkAciyBJ8ysV
         DDYVud+Kk9rmBPhMjAvw7MDE03fJ8P0cy9JDg8pF24v+n7yHu1Ww2W0Uzoec6bYnlbdg
         XaW/pl1IYeD8l9wZsdznDhvljz4xqzgDmPKCG9PJgCAn38IrUUXxffzExBgc61L6jkns
         lp2bNy8GIy3YK6OKhfsDwC5Jp7RECwaph85F79TAi3ijtG3XQ3CLsQ2Yf5ljp11M5pCa
         9/dBw9ygx/NalKmAnmeEnaZMoixZPfr4XbZEcM8KUNvvWwLcNvolOcfyiPBlCrpRNdgX
         8LBg==
X-Gm-Message-State: AOJu0YwpUfi23TSmXzQRDR0CncgJJk6A1IDk+WPLzRdQhVdL3DsAC9CQ
	LCGJ2iq7uochf5x/MJGqk+Oc/feoMUTq8UiDpGeJiFZ6Dk2VdpmrSViGhMWlQ42SRhgbUfTywI7
	ejWLYrf0s9siMt8EnnkUTl1/6Lce5ofmQ80n3KJUZjhNrzhWHK6PKDhUVsO70J1VahIke9sikHA
	KAqstKVSs=
X-Gm-Gg: ASbGnctahWGv0XYrHwhdilQ8SjH6m/jqsfSnyRnlidakNM7MvyvcSa330dvfz2ddQ87
	mnZ/nUYEz3p87PcLVuEWO4LfJjGPWibptQSe9/hJAI0jreJmukMhoBJ3tjvTqNqNee1NLPsB+17
	RzShvNzX6t0ZVUwB4V5xT9p1GxfVk1KHMeRT0gBcMDNeHliSIrC9KAMb78k7aP9pDfwhuAZNGGg
	GCY6zemHwDQfcGV7K7JuT8cWH0+xpYCzux4RjoRY4fdwfuzhkOiOiISB90C39aROYT8lSNWUbph
	V6CRqHPb0VRicw==
X-Received: by 2002:a05:600c:a40a:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-442f4a38df5mr29989575e9.10.1747234643449;
        Wed, 14 May 2025 07:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSuB7tXsDIbAHlX6PMrLvGckFWYgd4dOo2H71kbxEJ7QeEIn4un94uLqKVeEVE2OesAMwOGg==
X-Received: by 2002:a05:600c:a40a:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-442f4a38df5mr29989245e9.10.1747234643098;
        Wed, 14 May 2025 07:57:23 -0700 (PDT)
Received: from rmalz.. ([213.157.19.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3369293sm34512765e9.6.2025.05.14.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:57:22 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sylwesterx.dziedziuch@intel.com,
	mateusz.palczewski@intel.com,
	jacob.e.keller@intel.com
Subject: [PATCH 2/2] i40e: retry VFLR handling if there is ongoing VF reset
Date: Wed, 14 May 2025 16:57:20 +0200
Message-Id: <20250514145720.91675-3-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514145720.91675-1-robert.malz@canonical.com>
References: <20250514145720.91675-1-robert.malz@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a VFLR interrupt is received during a VF reset initiated from a
different source, the VFLR may be not fully handled. This can
leave the VF in an undefined state.
To address this, set the I40E_VFLR_EVENT_PENDING bit again during VFLR
handling if the reset is not yet complete. This ensures the driver
will properly complete the VF reset in such scenarios.

Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on another VF")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index abd72ab36af7..6b13ac85016f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1546,8 +1546,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
  * @vf: pointer to the VF structure
  * @flr: VFLR was issued or not
  *
- * Returns true if resets are disabled or was performed successfully,
- * false if reset is already in progress.
+ * Returns true if reset was performed successfully or if resets are
+ * disabled. False if reset is already in progress.
  **/
 bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 {
@@ -4328,7 +4328,10 @@ int i40e_vc_process_vflr_event(struct i40e_pf *pf)
 		reg = rd32(hw, I40E_GLGEN_VFLRSTAT(reg_idx));
 		if (reg & BIT(bit_idx))
 			/* i40e_reset_vf will clear the bit in GLGEN_VFLRSTAT */
-			i40e_reset_vf(vf, true);
+			if (!i40e_reset_vf(vf, true)) {
+				/* At least one VF did not finish resetting, retry next time */
+				set_bit(__I40E_VFLR_EVENT_PENDING, pf->state);
+			}
 	}
 
 	return 0;
-- 
2.34.1


