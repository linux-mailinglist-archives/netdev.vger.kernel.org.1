Return-Path: <netdev+bounces-190988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10F7AB9949
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DC318993A1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2197323182F;
	Fri, 16 May 2025 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OWKJirrq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA590224248
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388856; cv=none; b=FwB1jQjMrPXYG0dhS7VE6lICs++8XCs65wA6rmLnzhk+h5Zhxxv6V3eWqj4XYMB02msWLuWn2fMvVpWP/5Twiluv7scKceJPM/xCzzzVoujpWLnaPlSeG0sA9MVch+oYdw/Chf/piSmRu6feR/Gf5898dNe/aUkGtYr9/K/Ek5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388856; c=relaxed/simple;
	bh=w3TuZJ6QZhvhKEGnrbA4TCy51V/ngPCI2D/Ketl8YRk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxZdib5G0BPpb0jmtrWX9ffyMUXYNOd3rJ/+8h12wJbKf4wkpsW+3KbrQm2J8s4gAsA447r6f3TlZ+2iI3S0VV4s5U3fvJ1XKyqXa+RK41IKhPtATEebmKBRkIPIMm++XmguR+WbEOlWROWwzHWUtpxZPm96GMb7aggcfC80nr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OWKJirrq; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 56D593F182
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747388852;
	bh=NTYKT/ZNnrUF2nxl5cPc8Yu5IEEXLL1/o9RX7f+x5ns=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=OWKJirrqUyzUI3fa9yDwtinjBuPd3Mv1rjVlXPgBpF+MLatbMbTj710+9cfmIzbj8
	 I2aEP5dAmtqCwEPRSi2h98GXILEGMT0PgQXNTZXLrioBYRnoBrvfimtR8Av7zkxbQJ
	 EZAXuQnucMsnKdWCVanvNnumDfeVM2N2as5+U8xmeVp1c0h1Vhkm4RIfdbVb/Ic+ne
	 amSj2EJ69PxR9HCy/0KDkNOue+JkBS4dq9+guzx2KllO/q0f4RvZZ6IUPT6rZjIoo3
	 MREATjVv9wHZM5DciMAtXzzQWZNbttmYQ0U6m9+kZOt+YVEmdS4eZGhHtPnc3zMBh1
	 UjixEjbHvq/xA==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a1c86b62e8so961354f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747388851; x=1747993651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTYKT/ZNnrUF2nxl5cPc8Yu5IEEXLL1/o9RX7f+x5ns=;
        b=w40zK09kR/U3fsRvBOZhkPD2Z76a3y3xkuivPXry6fEq9rvdJL9lGf9kTewBRmkFbU
         Hq28Xf5jUfx/+38Y1jgVai2rkcAWnPqOUp3AyO57PD2LvnBck5gkk3ix9KPKM7LzPoUM
         NVadtnXdszD/Ti4R2KuirWzYQmELrAq3738fVumFgb0NAFnGq8NbxlJmb6WeK+UBOgRR
         h74l0F2393F3rCe8wz6UNGa7cZF44rwA3Ov+emPwiL1P0v3KdwS9QGNsHEYpQkXqhA5g
         qESIs9+YJeAW+o4OR10AqsL8zF2rHif8taee8AJfw2czro4z3OyBncawDks38DWVqszV
         0t7A==
X-Gm-Message-State: AOJu0YzF8nKZr4c76jZvU42wGZCAIcC14zNxidCI8/1XDbMTcvlaNvMT
	yKP/vHeLggeIUMkiWV3Ck5zU2iE9gmVeoxQ0vV8ppGfj2ZLFLto7i7QdSaZG2Uqr4W/B1PcjE7e
	TgU0BTxexOgGhREr+JgtV9vv7C33LPrAjO1bY6EvHWqacxQITkqMtXs0aK9UROcZEVIhRFwjaDO
	g6Ak9nQlKST+c=
X-Gm-Gg: ASbGncvtUMWS2mpbqMM5zjKvzhi2vpQ0XECRpR/atw4TuR7vPq7okIVQRTAuaRHJHr2
	oDDUFlbpWnkGaFbmwlHLeEc6s5XGavac8Xd86OP9edi7fBxwTGVjRhUPjBpxRVRL2oTpuvFvfMN
	3WxoE9tXObXUS2pOCD0eq5+QVI3M+b9lqSFUAKcyN0RiWMzV2veKIfD2wbNnnsx85dcT8Ra0UlX
	B1EX8sHOe8n9NnDGtBV3pOWgDFgbsO2QPNObltijJupvymYLkgZLGoW9tjZ+PvnECBcIrPFD/i2
	q/hOWu8D0KAysQ==
X-Received: by 2002:a5d:64ee:0:b0:397:5de8:6937 with SMTP id ffacd0b85a97d-3a35c840cfcmr2436869f8f.41.1747388851609;
        Fri, 16 May 2025 02:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsVLCp0OAgUC7815/XGK20Z8T28QvsR+G5GV4g/h2gvQcjtasvvILUydm0cm7mwEM5x68ImA==
X-Received: by 2002:a5d:64ee:0:b0:397:5de8:6937 with SMTP id ffacd0b85a97d-3a35c840cfcmr2436846f8f.41.1747388851245;
        Fri, 16 May 2025 02:47:31 -0700 (PDT)
Received: from rmalz.. ([213.157.19.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88990sm2329962f8f.68.2025.05.16.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:47:30 -0700 (PDT)
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
Subject: [PATCH v2 2/2] i40e: retry VFLR handling if there is ongoing VF reset
Date: Fri, 16 May 2025 11:47:26 +0200
Message-Id: <20250516094726.20613-3-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516094726.20613-1-robert.malz@canonical.com>
References: <20250516094726.20613-1-robert.malz@canonical.com>
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
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2f1aa18bcfb8..6b13ac85016f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
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


