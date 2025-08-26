Return-Path: <netdev+bounces-217004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D1B37032
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78FE1BC20F5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303563164C0;
	Tue, 26 Aug 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyQqJ/Y3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065C30BBA9;
	Tue, 26 Aug 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225551; cv=none; b=eaDMhlfRdIqnxdnguaP61WKD8LkCn7+L24V8HBqhEm4o2yukt/mvqOSaX98rNuD+vMc7CshoaYNvggxj9MpVxtdv3OkoPuRftUpCS3O3qZ5jY51pKvw2jsGPUfDhCDjbj2dL9Q2UOswbF7y7JPH2CX/zCefEBkBDP+sRujU+Wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225551; c=relaxed/simple;
	bh=HlecRIw67pAp5poCPfrus4ZNYKndhJf68o/6Jd5qT8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ujd4TkowtZ52QrTD5nc/WHlQi9INyqi4fEQCu6+a+cr5TW+nCBHvm/2AHGEbodNBk3OwUtY1XXztq35uVcaSMlcvYxF2A9VgKYKO0k2Ogdn1shk//ZQ4Wy1oEgXr8fNlYGKr7fxeGb16LkynuZKoRpoAMNJmFXZd+iD+HgfWPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyQqJ/Y3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so3798392a12.0;
        Tue, 26 Aug 2025 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225549; x=1756830349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4hwMSWkFKvIkVO0RU7YO/luDgoIsCOGIlfvguNRUx4=;
        b=XyQqJ/Y3rLLhtZqJFCQP/X72KPALGXpMsDIDoVWZwlkrFPw24WscTN2Uej8aEiqLFs
         GpyuEQntz37SPkvAxY4q++dcknhnVdhBelevHUOZlxOwf2sYQOykvu8Nxj0Hqhm6v6h4
         29YZhAMtglrWI8ERMEfdJT9eYoxuUf2MZCNvoXRJ6impNKozv0PEM7YRKZv4ifHFnRuk
         Av2w4UG29ra05jWr38IhhfCAk1smo1HvcSKL+C6N+cJnDJnAwvzDUtb2E4pSNDNtcjbQ
         QngCk9D55/fK4YPW8SjUk9091HF6/VITAh4Ud7/MpJqoeRMjOzc62RovycTHaOJEZsYo
         /Ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225549; x=1756830349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4hwMSWkFKvIkVO0RU7YO/luDgoIsCOGIlfvguNRUx4=;
        b=m9F0/3c2ILUbo76vz/RmVa+EecdypY+cGIJem4HUsZ6cb0WR8ccYCL4JWqcIbUf6qo
         lelkiE0GxaZpgOO8d32mi7Q/oL/Q5IZgJ047OZpfOTo3TLaD+9+vxzzvhNQ/EzuGckx4
         99m0MZ724vWoLiBjl9R36yg5Zkmsq0Pb0Z3WZ+x4fKfCp77JUB116OosU+ev5KT4S3Hs
         EWV3RdH57Kia3yoAnSR+MqYXDOFIpNku/eNwzXnexy/Wc6pOQ21vxZ/H7nsB90ddz0xZ
         CVrZOLtF8OfSU4G6OIgz/LEns0ikDB8ORNmQdnoozt9vEU6ymc7Y8nuRARqXf1LL2DmN
         Fcig==
X-Forwarded-Encrypted: i=1; AJvYcCXBf5pFqyDyKhq4ysGxjweqe7Qc+mDTLSvOGW5d8YOd7Aq/BhfAvLDorpNvQzKBoZkW6s4zpIzBAQ62HoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbE01qXJW8qWTBD7hOAXB2pxFWEd3UKwNRxe8jon4ZMjzr3ylW
	4nDRGT0kK/eqwqZrWjLgL4M78XyCoIAlLwMM40ZwVrLZ/X5o7nwvlsUmkPSOt6u00CkAMEgY
X-Gm-Gg: ASbGncuHwztSKSbwHb4lpMkmu9nuTXLQeQ4PimpFQA4uqL8E/iV+6JjiI3CQuX6/AOe
	GEvFOg7hAzDiIljtnZeACCjFMrHllKdd/JcOjl6lSIxRrl+fp1oYJy234GKsNnF37e04WyaPylc
	eD0vLub0/nxbkjnbx/7D2j5Gihxh7pHe4jFuyGfHV1ClTXh1WdZ/bjobd84bfAbBlb7+U1YEuMe
	mgaHRJ5V9u1Qopkz7qeoz0+ZG7Nh79x0/wrkm0wwS9Bi1Bs5dJF0VzGShHt4ecZmJp1gdiuG7+f
	CUa3svFIMhlgU/iZnabpSQSiaCjdT+NNXwielC4hZkzsPGzc8/5kGHnhtbZgydiPUt8oBkkdq5/
	j4OKjFZ47ASoP+qmJuFSlPOW2sGXHCuCpgSpGJ+OvLzWI2x8Psq3idwcN+Yscjqs3p0D+U0Blhv
	u0
X-Google-Smtp-Source: AGHT+IE8+aaT57yva/CiX1UPjZQV7m4gj1JYI1bG56fZxydlN4wD1RtVDoBRR8qkOCmZx+1fnGqYtQ==
X-Received: by 2002:a17:902:e94d:b0:248:70b9:c0dd with SMTP id d9443c01a7336-24870b9c2c3mr33262765ad.2.1756225548729;
        Tue, 26 Aug 2025 09:25:48 -0700 (PDT)
Received: from localhost.localdomain ([222.95.6.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0c61sm100172345ad.56.2025.08.26.09.25.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 09:25:48 -0700 (PDT)
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
Subject: [PATCH 1/1] VF Resource State Inconsistency Vulnerability in Linux bnxt_en Driver
Date: Wed, 27 Aug 2025 00:25:41 +0800
Message-ID: <20250826162541.34705-1-qianjiaru77@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianjiaru <qianjiaru77@gmail.com>

A state management vulnerability exists in the 
`bnxt_hwrm_reserve_vf_rings()` function of the Linux kernel's
bnxt_en network driver. The vulnerability causes incomplete 
resource state updates in SR-IOV Virtual Function (VF) environments,
potentially leading to system instability and resource allocation
 failures in virtualized deployments.

## Root Cause Analysis

The vulnerability exists in the VF resource reservation logic 
where older firmware versions receive incomplete state updates.

## Vulnerability Mechanism

1. **Incomplete State Update**: 
Old firmware path only updates `resv_tx_rings`, 
ignoring other critical fields
2. **Missing Hardware Sync**:
 No call to `bnxt_hwrm_get_rings()` to sync complete state  
3. **Inconsistent Resource Records**: 
`bp->hw_resc` structure contains stale/inconsistent values
4. **False Success**: 
Returns success without performing actual hardware resource reservation

## Missing State Updates

The vulnerable code fails to update these critical fields:

```c
struct bnxt_hw_resc {
    u16 resv_rx_rings;      // NOT UPDATED - stale value
    u16 resv_vnics;         // NOT UPDATED - stale value  
    u16 resv_rsscos_ctxs;   // NOT UPDATED - stale value
    u16 resv_cp_rings;      // NOT UPDATED - stale value
    u16 resv_hw_ring_grps;  // NOT UPDATED - stale value
    u16 resv_tx_rings;      // ONLY field updated
    // ... other resource fields also not updated
};
```

### Attack Scenario

1. **VF Configuration**:
 Administrator reconfigures VF network resources (RX/TX rings)
2. **Partial Update**: 
`bnxt_hwrm_reserve_vf_rings()` only updates TX ring count in `bp->hw_resc`
3. **State Inconsistency**: 
Other resource counters (RX, VNICs, RSS contexts) remain stale
4. **Subsequent Operations**: 
Other driver functions rely on incorrect resource state information
5. **Resource Allocation Failure**: 
Attempts to use resources based on stale state information fail
6. **System Impact**: 
VF network functionality degraded or system crashes

## Comparison with Similar Vulnerabilities

This vulnerability is part of the same 
**firmware compatibility anti-pattern** family as:

- **CVE-2024-44933**:
RSS table mismanagement due to firmware-specific logic
- **bnxt_rfs_capable() bypass**: 
Validation bypassed for old firmware versions

All share the common flaw:
incomplete logic paths for older firmware versions
that compromise system state integrity.

The pattern appears to be systematic in the bnxt driver
where legacy firmware support consistently introduces
 security vulnerabilities.

## Proposed Fix

The vulnerability should be fixed by 
ensuring complete state management 
for all firmware versions:

```c
// Current vulnerable code:
if (!BNXT_NEW_RM(bp)) {
    bp->hw_resc.resv_tx_rings = hwr->tx;
    return 0;
}

// Proposed secure fix:
if (!BNXT_NEW_RM(bp)) {
    // Update all relevant resource state, not just TX rings
    bp->hw_resc.resv_tx_rings = hwr->tx;
    bp->hw_resc.resv_rx_rings = hwr->rx;
    bp->hw_resc.resv_vnics = hwr->vnic;
    bp->hw_resc.resv_rsscos_ctxs = hwr->rss_ctx;
    bp->hw_resc.resv_cp_rings = hwr->cp;
    bp->hw_resc.resv_hw_ring_grps = hwr->grp;
    return 0;
}
```

## References

- **Related CVE**: 
CVE-2024-44933 (bnxt resource management)
- **Linux SR-IOV Documentation**: 
`Documentation/networking/sriov.rst`
- **Broadcom bnxt Driver**: 
`drivers/net/ethernet/broadcom/bnxt/`
- **PCI SR-IOV Specification**: 
PCI-SIG SR-IOV 1.1 specification

Signed-off-by: qianjiaru <qianjiaru77@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 207a8bb36..2d06b0ddc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7801,7 +7801,13 @@ bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	int rc;
 
 	if (!BNXT_NEW_RM(bp)) {
+		// Update all relevant resource state, not just TX rings
 		bp->hw_resc.resv_tx_rings = hwr->tx;
+		bp->hw_resc.resv_rx_rings = hwr->rx;
+		bp->hw_resc.resv_vnics = hwr->vnic;
+		bp->hw_resc.resv_rsscos_ctxs = hwr->rss_ctx;
+		bp->hw_resc.resv_cp_rings = hwr->cp;
+		bp->hw_resc.resv_hw_ring_grps = hwr->grp;
 		return 0;
 	}
 
-- 
2.34.1


