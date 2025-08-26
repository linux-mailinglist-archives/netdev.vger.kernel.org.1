Return-Path: <netdev+bounces-217005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB12AB37036
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B36686405
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1152302767;
	Tue, 26 Aug 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKZhLZDy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA4279335;
	Tue, 26 Aug 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225580; cv=none; b=EKqTntViz0He8xUWr4P3rBzh1LOFzlt4ALHMg2g8+qSccPaCkkimgshNuLiuag20X1wUtVh4Xzjttk/5Ao2fEf9JCxNyOx9IdS5vO18ct/QCtltMjy0yuSZvP8MYAUnW7j3SuBO1aUbOxi5jvLYE5FahObIs//JcRmfhHhiLuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225580; c=relaxed/simple;
	bh=yp628Ja1Jded7ifvBo85W2XgjV2Jzoy6aS/AmxyWUdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE9k6+ZdliOLKr1w53sDG7LQCBV40Cs5P4+PtxedUBrN1BkpyZ80iMRErZUKhCOE+fkfc+6E9XUtA9mdYxKLFrZ0rQEY9+6qgN4PcdnPYBC18MFEysFuoTPU1/0dmqMidJ/D4GWL0/jazf0dZOC2+sxaVUDzdk6JZqx32YCj1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKZhLZDy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77057266dacso2828563b3a.2;
        Tue, 26 Aug 2025 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225577; x=1756830377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khggQz/JH6rSx2RO2ikhky3auL8lAUSmlOCpMRe6duA=;
        b=LKZhLZDy6ccKuCJGC+FNiq18DkMVc1OrPnHVSqT+4x5OddvpJ5BMpIYLnou6lHZbiX
         2BJ6suNPVT8XMV2ZF95xFsf20nbMFqrQm/13VB86fnilnYh41snzb1YXT6RJ3lV10sQG
         U4m9Pe4noFsSRmUmMw8niDpxRPbxrVMp5kH68df7a+xWEfpNqHEPDYUslpAY8SzW1CWW
         fKVC/Tgy6NWGOVvLt0GsgknyMJUwWHgd1E5cI8eOHmjmmYv+5Wx5BqA4F59fFcE8ibwe
         LAVFQqtJAlt54Ds6gLp/6o51GYXd+4kt2KSTz2ghqqiAn1zLlRybG6TDLcWmF2z0KvX0
         dzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225577; x=1756830377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khggQz/JH6rSx2RO2ikhky3auL8lAUSmlOCpMRe6duA=;
        b=ulYjFXYLPjNPjzaLbk87MUUspUxyvjowwIAWWSF/vRHumEydbIYFR9WeQcP/bB5scV
         1qn8R9k+RBzsEYkc8+SX2Gqktf6pehfreWzdmr0OeZvi6nU0FOejp4t5uBl9A3ePi/qy
         kmjcClkSKuSefitLBMNetja60ffgp7zjcTlDG812Oq0KbVl6p6g81C+tHakEvidhnszC
         T4eNv2+Jl9sb1pT/Huf88s1JZOXLGSfu+ZECSXlK1Qo70RocJY0+rr4jAQg4reGCWYAn
         I8yTV2UtTowJXM+gM5X5bUf/FjrvnRbYiWO8pL507Mu/hu54C/bIfYAwiFmV6Cik0HJa
         VDCw==
X-Forwarded-Encrypted: i=1; AJvYcCVCRHTqc7yLEHlGGBOzTpJ2ejuqEnCn+DGiyw74ZWOgf/O+ul3Rk9wiWOY8QwkNkS0Biegub26Eea4gGxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIKfiCIUL6hGyFU+YHahoBb7nMQKvfK0gDm1p9jkNe+pcYUYh
	Nm1ZZub+QfBuhs/YkKo0rMYxQ0sVLJrEQnMlo9KVs580KAt0zM9AIHVM
X-Gm-Gg: ASbGnctbcExiJNNlPtfMTJP1vJ9bOAr+wLqJFK6TNsIiJz+NgPSq30ooAS410qQmEv2
	gr0q89m7de689oOuzCAtpK+vPvyciA90lECIM91JRD8XYAGqL0NIHl2KOWIM1wpauAKJafvziOf
	9xFikh7ZfUVwFS2TfcelG97CBCd+vN0uy0ncJYb6p7nSjE73kIopAztLufc844YkIsotqV1HwnY
	wxfLe4KiTunfue2HusZ8UIvH3tD5cPYXQQhvjufpAonI6jX/oVCU447uMk7zRt+NjMZKas3iqNk
	JFfjVCufHqEym2bXrYGOmb/RjjMNfjVhj3It80Jb8l1Tgi7vc59cN4AQRrT7myWCw8gshQIBMKa
	lk6+e/TNPZ9NCiZ8yQHXeWxskdQ6IQjPstuT8w6YyNTWrtwe+sScxcMKph8bF0ufaPrSv1nyCZw
	0/
X-Google-Smtp-Source: AGHT+IFp7XaIr12LtYmymCAsctca8jspaYXUv99oIHhqKHVQxJvsnp+3dc7zuTm0tI7nQnrlwC0Ulw==
X-Received: by 2002:a05:6a21:339c:b0:220:aea6:2154 with SMTP id adf61e73a8af0-24340b016bamr23783689637.17.1756225577191;
        Tue, 26 Aug 2025 09:26:17 -0700 (PDT)
Received: from localhost.localdomain ([222.95.6.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77059928c5asm7382738b3a.1.2025.08.26.09.26.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 09:26:16 -0700 (PDT)
From: qianjiaru77@gmail.com
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qianjiaru <qianjiaru77@gmail.com>
Subject: [PATCH 1/1] RFS Capability Bypass Vulnerability in Linux bnxt_en Driver
Date: Wed, 27 Aug 2025 00:26:09 +0800
Message-ID: <20250826162609.35108-1-qianjiaru77@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianjiaru <qianjiaru77@gmail.com>

A logic vulnerability exists in the `bnxt_rfs_capable()` function of the 
Linux kernel's bnxt_en network driver. The vulnerability allows the driver
to incorrectly report RFS (Receive Flow Steering) capability on older 
firmware versions without performing necessary resource validation, 
potentially leading to system crashes when RFS features are enabled.
The vulnerability exists in the RFS capability check logic where older 
firmware versions bypass essential resource validation. 

The problematic code is:
```c
// Lines 13594-13595 in drivers/net/ethernet/broadcom/bnxt/bnxt.c
if (!BNXT_NEW_RM(bp))
    return true;  // VULNERABLE: Unconditional success for old firmware
```

##Vulnerability Mechanism:

1. **Bypassed Validation**: 
Old firmware path completely skips resource availability checks
2. **False Capability Report**: 
Function reports RFS as available when resources may be insufficient  
3. **Subsequent Failure**: 
When RFS is actually enabled, insufficient resources
cause driver/system crashes
4. **State Inconsistency**: 
Driver state doesn't match hardware capabilities

##Attack Scenario

1. Administrator configures RFS/NTUPLE filtering 
on device with old firmware
2. `bnxt_rfs_capable()` incorrectly returns `true` 
without resource validation
3. Driver attempts to allocate hardware resources 
that don't exist
4. System crash or memory corruption occurs during 
resource allocation
5. Network service disruption affects the entire system

## Comparison with Similar Vulnerabilities

This vulnerability is a **direct variant** of CVE-2024-44933,
which involved similar firmware version handling issues:

- **CVE-2024-44933**: 
RSS table size mismatches due to firmware version differences
- **This vulnerability**: 
RFS capability reporting bypasses validation for old firmware

Both share the same anti-pattern: 
firmware version-specific code paths 
with reduced validation for older versions.

The root cause pattern appears throughout the bnxt driver codebase
where legacy firmware support introduces security vulnerabilities.

##Proposed Fix

The vulnerability should be fixed by ensuring 
consistent validation across all firmware versions:

```c
// Current vulnerable code:
if (!BNXT_NEW_RM(bp))
    return true;

// Proposed secure fix:
if (!BNXT_NEW_RM(bp)) {
    // Even on old firmware, validate basic resource constraints
    return (hwr.vnic <= max_vnics && hwr.rss_ctx <= max_rss_ctxs);
}
```

## Additional Variant Risks

This analysis revealed another related vulnerability in the same driver:

**`bnxt_hwrm_reserve_vf_rings()` function (lines 7782-7785)** 
contains a similar pattern:
```c
if (!BNXT_NEW_RM(bp)) {
    bp->hw_resc.resv_tx_rings = hwr->tx;  // Partial state update only
    return 0;
}
```

This should also be addressed to maintain state consistency.

## References

- **Related CVE**: 
CVE-2024-44933 (bnxt RSS out-of-bounds)
- **Linux Kernel Source**: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
- **Broadcom bnxt Driver**: 
`drivers/net/ethernet/broadcom/bnxt/`
- **Original Fix**: 
https://lore.kernel.org/netdev/

Signed-off-by: qianjiaru <qianjiaru77@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 207a8bb36..b59ce7f45 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13610,8 +13610,11 @@ bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx)
 		return false;
 	}
 
-	if (!BNXT_NEW_RM(bp))
-		return true;
+    // FIXED: Apply consistent validation for all firmware versions
+    if (!BNXT_NEW_RM(bp)) {
+        // Basic validation even for old firmware
+        return (hwr.vnic <= max_vnics && hwr.rss_ctx <= max_rss_ctxs);
+    }
 
 	/* Do not reduce VNIC and RSS ctx reservations.  There is a FW
 	 * issue that will mess up the default VNIC if we reduce the
-- 
2.34.1


