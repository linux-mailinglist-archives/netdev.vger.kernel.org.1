Return-Path: <netdev+bounces-187336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A0FAA676D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC0816FF59
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9F264FA5;
	Thu,  1 May 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO/ei6N9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560671E487
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142201; cv=none; b=ufRDkLTv9YXJQRf3wYRjLpEgPjC7yIZBs0Tgd7y5838tVmOecqmvnWrX6cfxg0abR8A8qVdjxBdTIh4PwPl3TQ8GxdZ3D2yjGpfs20c+Q5Fv6ts1UwIQlLBUvopeFJIZvRgMSFmepxQU61JhjF+lRpm8I5W4hV9C2N5MW3ulQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142201; c=relaxed/simple;
	bh=kmX93pXnKx0Mm+fTs67uqDCLbZ4X2Is6xiQd4rnoUVo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVd+2LX7UatmLvgYf9AbM+ZEyWeRA9K0suXIG8CCzxHwIO/VUBIfgFsOF+MQwFdCQky0653xCNn632SUxj7puldcHApE4C0lEnf0X11/XZlWDBl9p38SvgEH79GCLt3zBWvqK/q2zx2zt7XN7rRqdC3Z0MdR4VcenN3n0RuJE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO/ei6N9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af579e46b5dso1034235a12.3
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746142198; x=1746746998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5JYj/6BYsRVyXdgmgvTHLzBbTkC1Snip38zMmCNL2iU=;
        b=fO/ei6N96AX7IFNKZUs7gDWe/X+v8esJRjJ0USBd5xHQAZkLXYob0iXJ4K7/nWkxyd
         UZ7aM51sHQg5IyIIL0mIaS0MLieVHxQKKCFEp4we6Q5Sy6Bv0LkMjCGgX5Kb/zlVcWkd
         s5Nv91n5elMi+iR9Jqs0LeJ8D/kxtSiJhtAUr7lMrUpTxymw3CAsq8WsvQz396a6/PyD
         JV5c7omeYyF3nu8C7sHtxKwLr4qk6C8V1qWEwFpF/x+HYiJmzpBnScYylTl7a2fs1CIZ
         t7sHDY2/dr3/Wf6ocAYaQdaqg/acINvBRN2aD+KWXb2Z6ghEPx/UewsZ4xl9S01/Irst
         hLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142198; x=1746746998;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JYj/6BYsRVyXdgmgvTHLzBbTkC1Snip38zMmCNL2iU=;
        b=dGoMLL3WgQegcExqvwACi68sgSb+m6w1jx3YW1NEXE6X+aKF6LU519ExiMjutcz48S
         oezSLgmR6t/Wt8Mk/baQXHXByzveKBQHbCw1KKo1QqLGJgcrwrDTsOA8413WcY7QYQyB
         qOlmRBJt0F8PRwUDvXFgapT1heLWI6nZMQ5gcPPyauNcmisy9uf7Kz9cGo+lyVWeakop
         Fu9WNVwpIjkaG/pwwd+eVr7aBluytWBY5crtgmRG4/uQyr3ducGpTNm3CAp/JLI4vJlb
         kPEmZCcdO70SjdlLVllepVBBqB2aKi/GaKjtJNsliUMh0c1G5lkM/c7U5wsTxZzNBPoA
         MdBQ==
X-Gm-Message-State: AOJu0Yzf5VIJqVDNdsVgPqqXb0iKss4fNpQrEDjKin004B6YQwABhO6c
	NIKggiahZZtfVHMunA1FCT+WZD6PMVFm5LOYw+EHkveIxz5ttyoBNKvfUA==
X-Gm-Gg: ASbGncvmzvMYz2J3214kNuhNgYFZO1+WWwXNwLoqJi1pupO05xq399WoLvYFuik8tom
	vFD3AsJJLu91mLWrcyJsfrNmIGmYVWeg6nkZZSldKjYpoLRG5GQ8z2FokPQHjR5MZ5UoiEWsjdD
	QxNagcIvr0XGJCy2fHnov2a6p7FcfgBbi5xRoL2Bq5h6NpT9Zyz16FVNiMm1e12Rksy2xsT5/Ts
	X3pEhwtvUetE3JkTABQakJQflZJ3CAxOv8ENCeAKPwB1gcQCMbjPza772sDzwSW5cb/odBMLv1H
	zj/vKi2wCJ4NgVmGLzmI2+2DnfwbL6PhL7QmbW3MlaHDy6SlwIJVN2UxxuH+qelE5eM5AeDxA+U
	=
X-Google-Smtp-Source: AGHT+IGRagOVKV+KkJKB3y13YPL2B422v2HUAg0xN774OL6zZ0eE2a2/lxVlUVpewlkQ0hFaiJ9I7g==
X-Received: by 2002:a17:90b:2241:b0:2fe:dd2c:f8e7 with SMTP id 98e67ed59e1d1-30a4e5b1ca5mr1309110a91.10.1746142198460;
        Thu, 01 May 2025 16:29:58 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3476f51asm4262869a91.22.2025.05.01.16.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:29:58 -0700 (PDT)
Subject: [net PATCH 1/6] fbnic: Fix initialization of mailbox descriptor rings
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 May 2025 16:29:57 -0700
Message-ID: 
 <174614219719.126317.5964851599064974666.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Address to issues with the FW mailbox descriptor initialization.

We need to reverse the order of accesses when we invalidate an entry versus
writing an entry. When writing an entry we write upper and then lower as
the lower 32b contain the valid bit that makes the entire address valid.
However for invalidation we should write it in the reverse order so that
the upper is marked invalid before we update it.

Without this change we may see FW attempt to access pages with the upper
32b of the address set to 0 which will likely result in DMAR faults due to
write access failures on mailbox shutdown.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   32 ++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 88db3dacb940..c4956f0a741e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -17,11 +17,29 @@ static void __fbnic_mbx_wr_desc(struct fbnic_dev *fbd, int mbx_idx,
 {
 	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
 
+	/* Write the upper 32b and then the lower 32b. Doing this the
+	 * FW can then read lower, upper, lower to verify that the state
+	 * of the descriptor wasn't changed mid-transaction.
+	 */
 	fw_wr32(fbd, desc_offset + 1, upper_32_bits(desc));
 	fw_wrfl(fbd);
 	fw_wr32(fbd, desc_offset, lower_32_bits(desc));
 }
 
+static void __fbnic_mbx_invalidate_desc(struct fbnic_dev *fbd, int mbx_idx,
+					int desc_idx, u32 desc)
+{
+	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
+
+	/* For initialization we write the lower 32b of the descriptor first.
+	 * This way we can set the state to mark it invalid before we clear the
+	 * upper 32b.
+	 */
+	fw_wr32(fbd, desc_offset, desc);
+	fw_wrfl(fbd);
+	fw_wr32(fbd, desc_offset + 1, 0);
+}
+
 static u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
 {
 	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
@@ -41,21 +59,17 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 	 * solid stop for the firmware to hit when it is done looping
 	 * through the ring.
 	 */
-	__fbnic_mbx_wr_desc(fbd, mbx_idx, 0, 0);
-
-	fw_wrfl(fbd);
+	__fbnic_mbx_invalidate_desc(fbd, mbx_idx, 0, 0);
 
 	/* We then fill the rest of the ring starting at the end and moving
 	 * back toward descriptor 0 with skip descriptors that have no
 	 * length nor address, and tell the firmware that they can skip
 	 * them and just move past them to the one we initialized to 0.
 	 */
-	for (desc_idx = FBNIC_IPC_MBX_DESC_LEN; --desc_idx;) {
-		__fbnic_mbx_wr_desc(fbd, mbx_idx, desc_idx,
-				    FBNIC_IPC_MBX_DESC_FW_CMPL |
-				    FBNIC_IPC_MBX_DESC_HOST_CMPL);
-		fw_wrfl(fbd);
-	}
+	for (desc_idx = FBNIC_IPC_MBX_DESC_LEN; --desc_idx;)
+		__fbnic_mbx_invalidate_desc(fbd, mbx_idx, desc_idx,
+					    FBNIC_IPC_MBX_DESC_FW_CMPL |
+					    FBNIC_IPC_MBX_DESC_HOST_CMPL);
 }
 
 void fbnic_mbx_init(struct fbnic_dev *fbd)



