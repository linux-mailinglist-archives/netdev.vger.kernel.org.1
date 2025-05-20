Return-Path: <netdev+bounces-191765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDB1ABD203
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA1189CDE8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7A264FA6;
	Tue, 20 May 2025 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TIS4SZxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA85264A7A
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729934; cv=none; b=QC/TjQg2SFmGWoF7LmWljrnp0yzSfWQ2hLEyGDKpQvkQqKP+S6NGDXziKp/zoFl/8sXloZvoVPhL+wwbcqDQ4ljc/QOnKNLRcQAh/3v2VQf787tk9iviutpXCTRCJvEjubBOt9pqejeRkzBJUTFi3X9TMtgf/1mHMewSIFRx+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729934; c=relaxed/simple;
	bh=CTm4CVu5n/oiBbi6Lje+Uz28FZG5mt55czRfCQDLFQI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URlrpUnLRDQPa9JiBNLAw45bH2iKr2Uduy3YZql6z7Fbl1poHXl/RLPNWSUZ/3OKVXbk5bM8Yff+5uDI1JgatVSEa2vtgVCguSEzpstGTrHl0AjH8wHKyWC3OGo77sTMod2gpWLgaiml3LckLCquZ2eRq62lhORlqLYUdPcSrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TIS4SZxa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D21933F47C
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747729923;
	bh=QYwOZSsI8hjs35UBubBF8ilnkn0uGGlIyWCa07KKVXo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=TIS4SZxaPr4rvva9vwgyuIGWS+MdkGwPF6HmkIj55PZO8/5osquk7w/Mk6ehRg4eG
	 yTdg/HkY3ADuBodFlJu94RyyY+CM+UCPwB1cpjpdeYFvxie8y7niVEN+uur3k4GbMt
	 mNo0/2RiZWRPjKKkILGHIoZuTqtpt8Gzyfs0NPiv1N1H+eJQQ+f5vAsDSk2nCZipV1
	 lpFAm3LApZAzNNDT3RpCE1gyAfPEJJxjfUmmgPKvROxwNrjoOszsPq9I2RW7Qgf4F1
	 6ftnBBV7+loaye6ONTLv5qTwih7J13K3+k/u8egO07WKVt9UDgwNTwHwS/9Dv6EIxU
	 SznXAfaTgH6Yg==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60179d8e964so3592174a12.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 01:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747729917; x=1748334717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYwOZSsI8hjs35UBubBF8ilnkn0uGGlIyWCa07KKVXo=;
        b=ctfvD7f76avOSGFCR8ANCU0b0BDNGj3gLqkABt6gGPh4OYmzZVCPTlAYlrnPEcKON8
         b31ZIXZ4B+gjZwTAOiiAfG4sA9LKIKcH3P70R8Sn2TjYTiEQJ6SPXIUAXPAAMrnNJYJV
         /Rk9Mra8r4uOvy4jd6O+s3TyqDUAMZDiZKDdKeACQY86HmIMNL3r7CHtKM+gJvrzC/vQ
         zl6caKbbWeJ7E60slu9l9ykiIlf0Rz0MlaISe9vGiz7TY90ErM8yWUSIH92W54fWexIX
         V40q8xe0iWa/WnEK+YWWnThNRLsdG9qiqU1+eCM+U4iD2cNKtPs05xxnjSZ32KHseOPG
         oz+A==
X-Gm-Message-State: AOJu0YyhXq+sw0iKtdPKyTqYDk/GPf91vsD4kKWNe9ROLV6+r1pWbjbs
	O73g3E0IiJH26FvTS+2O3UipN7p624kW+ylLQfVPtm+MzZnSoVhLF2AL3nXaMiOmgzH3orOWIFs
	tW6xMOdDLxOjMcnD+gQUHOqs/QpqXKlDiLQp69yCo8hJDov6+F6z16UuDt7SAmG4sOVuzHqUlQE
	pTMjj0JdTi
X-Gm-Gg: ASbGnctRlvhUFLdjOO84KhkRrFiFaWbb/o/orD5Qev17FGW7nD58Bzo78mcLHlZbwZS
	tlprjZMIlEArc6UgIFSxJsiL2V4GJh6pKGDrcoEsDzCUj3KcBi+w0gIlNgH7FdpL+cHZHZPT8iV
	37Un1fDV1z38SKXtIS72O4FsYj9Fj6WVgHHpR/1jpd6RhlQeN548+ZeYXvSQsREk+brIZb26hh4
	+AhATFoFOYcPKCCpvIAy3zzpWmjQJI7387wAPor9UnSwEW8UQQpCJVRkEgWCd/gl0cW7wSVWdx3
	e6/MR+gqtvs=
X-Received: by 2002:a05:6402:5cd:b0:5f6:4a5b:9305 with SMTP id 4fb4d7f45d1cf-60119cd4192mr13301406a12.33.1747729917592;
        Tue, 20 May 2025 01:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1syGi74PV0b9b/ga204Wjx80qf3qBYeXuyNyUXirykm93ZieIuHmEWg/iwg1FYse/VIYaeA==
X-Received: by 2002:a05:6402:5cd:b0:5f6:4a5b:9305 with SMTP id 4fb4d7f45d1cf-60119cd4192mr13301383a12.33.1747729917237;
        Tue, 20 May 2025 01:31:57 -0700 (PDT)
Received: from rmalz.. ([89.64.24.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3b824sm6857875a12.79.2025.05.20.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:31:56 -0700 (PDT)
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
Subject: [PATCH v3 2/2] i40e: retry VFLR handling if there is ongoing VF reset
Date: Tue, 20 May 2025 10:31:52 +0200
Message-Id: <20250520083152.278979-3-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520083152.278979-1-robert.malz@canonical.com>
References: <20250520083152.278979-1-robert.malz@canonical.com>
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
index 22d5b1ec2289..88e6bef69342 100644
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


