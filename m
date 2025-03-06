Return-Path: <netdev+bounces-172305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5EA5420B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515F516CCC3
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4319B3CB;
	Thu,  6 Mar 2025 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0PXE4xR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C22199396
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 05:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741238760; cv=none; b=oIXGobeuYEvXe43RPLkzX9LK4D4r5Yl45YqLcJiS6CkgJ3nnU8x6KbDO9xuu5I+7iGb0GHen0V13k5LtVHc3B3Zmg+6RYIIhED6sERElGxZ/cPW16Fahd2jI7Tr3+TMr38LYescFthLmPxlZeRWDeok7hkQzLQ8Os9/iuYugnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741238760; c=relaxed/simple;
	bh=sSCGOuOt3161EWY1JB9M5WL0tgYUT0/ib6PvYSw/uGM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=obMv0+gOdL3/W2mJuMiJq1KR8sniiZZthn0ZLxeuNQy3v1kHCHz+RrX7srPU1xA6W6jfEK9cPHmKFz3bwF9K5NVfJ9QTrUjKWJ+g4+9nmCprrvB8lN2SWYlBAOYn8YmXPAiPgT8wUp1gSSVJ7oHk+uugjFlRZNHzSLosw1Ov0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0PXE4xR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223cc017ef5so3649295ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 21:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741238758; x=1741843558; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QDabgt74hchcw11vM5ZQO4fhwXVE7xUCtKdYmU3HQA=;
        b=c0PXE4xR58L+wVatM/XuzCBEioXdsCMtGCoaVZRX4PRs12nYGPrZr4/FFSHSH84l1g
         I4628VDGCAoXhoaj0tFLUit6b/lPfSOPhdchwiEfxkx3atqqrE4+t9YXDasY6U9B185p
         VxNQc77q4MP4yZWcMllRWnH2+yrcDmdxZ//S9g/P6ku36A/rUx3X7J6cjANctAKr79zs
         XZClPDH87JX/2p2xP/Ttn+WsNlsFYVYMLcFB9iSPzyAMUpZFtlCEBqHS0ZI1dfUF7pNV
         79dGx5CAziZ1/Bp6YLkc3nbDwd2fUwfN/6XjCMssG1/3KtsyX0P6AXOqKQX+uckZ6Ora
         Kvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741238758; x=1741843558;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9QDabgt74hchcw11vM5ZQO4fhwXVE7xUCtKdYmU3HQA=;
        b=bd7vds/bbsrZ9oVG9i4rudFWISPpEJtng5WyA3PQaQLdGRKS0w7dsrmfzo4XYBCZrD
         osMh1Mp5MISc2D6MqX37UtMGnoNaVJU0FviXuOEnZJsPcuCZCRzsWLUqX4to6Ky1OTge
         ofx8AaRBqKcbCTQ4KB9RI0tGrUOdvosrpxlgsG0xs/mBXvtleXbUIOhjR3O7mH1m/BS7
         9waDmIeO5Z4fHJp83b7xsPcDyS+6BqIvehdromBLodnh826fa5K8oShzuC7EqXmNotB4
         j+tUecI11EmBD/9bXJstZ1fbhNC1ySaKvIvAg44KCd9I6tCsLb5dvBNC/xMrDfRYYmY3
         A6tg==
X-Forwarded-Encrypted: i=1; AJvYcCWuF1QCqeDfKFHnW8fY9KUyCw4zxidKg8JXuK2ccXHjn25MRS/8kJrjroAR5sKuKlkZVuGvWZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tRHMtYErauEsbX0j42Yt+PWzcSD9PbCYuiUl7M64RyfM9+vc
	9IyJmqe7dZH7PvUA/qZP1GPz55+rEvyYRtoxVkiQEGTeISNqORsQ
X-Gm-Gg: ASbGncv09rqb76c/FYfs3RhiHESlnU3Rz4tPcmNhXM1Dc8mKpMqvw4I4yTUNfaf/l1+
	zzQ8qb0iBYrCXsmhqILNuOFOw02nxqFDOFrJDFPArj885qp3FYr5TkiXa/nNjcyEa54w1mMXT1M
	qY3fGjoVv24AcnK2A3YcrmWXGdM9vgk00J/r9iPyClOQEEzZkR6SAw7LnQzACWZvr7/NT+K5QUU
	uXCf2dlA85hiLMzbLXQzLIPwZ21y+okkNELxFxBRODiJkt8BnPAUgvlw9KlDnS2Au4dQ90V6TUw
	1S/edkA2j0e1jDFL7r9036Iiif0A8uE4XN+rsqyzEg7yFoxVnJzxIIE=
X-Google-Smtp-Source: AGHT+IGnEX3Pf3lGI9K3Fats2RMMy6ant6SEVTbN2BeD72fY2StFq63MptV+0LfkddSY93pqHLTOzQ==
X-Received: by 2002:a05:6a00:244f:b0:736:6151:c6ca with SMTP id d2e1a72fcca58-73682b4aa32mr8352042b3a.4.1741238756195;
        Wed, 05 Mar 2025 21:25:56 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f7268sm394020b3a.116.2025.03.05.21.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 21:25:55 -0800 (PST)
Message-ID: <55acc5dc-8d5a-45bc-a59c-9304071e4579@gmail.com>
Date: Thu, 6 Mar 2025 14:25:52 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
From: Kyungwook Boo <bookyungwook@gmail.com>
Subject: [PATCH] i40e: fix MMIO write access to an invalid page in
 i40e_clear_hw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In i40e_clear_hw(), when the device sends a specific input(e.g., 0),
an integer underflow in the num_{pf,vf}_int variables can occur,
leading to MMIO write access to an invalid page.

To fix this, we change the type of the unsigned integer variables
num_{pf,vf}_int to signed integers. Additionally, in the for-loop where the
integer underflow occurs, we also change the type of the loop variable i to
a signed integer.

Signed-off-by: Kyungwook Boo <bookyungwook@gmail.com>
Signed-off-by: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://lore.kernel.org/lkml/ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com/T/
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 370b4bddee44..9a73cb94dc5e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -817,8 +817,8 @@ int i40e_pf_reset(struct i40e_hw *hw)
 void i40e_clear_hw(struct i40e_hw *hw)
 {
 	u32 num_queues, base_queue;
-	u32 num_pf_int;
-	u32 num_vf_int;
+	s32 num_pf_int;
+	s32 num_vf_int;
 	u32 num_vfs;
 	u32 i, j;
 	u32 val;
@@ -848,18 +848,18 @@ void i40e_clear_hw(struct i40e_hw *hw)
 	/* stop all the interrupts */
 	wr32(hw, I40E_PFINT_ICR0_ENA, 0);
 	val = 0x3 << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT;
-	for (i = 0; i < num_pf_int - 2; i++)
+	for (s32 i = 0; i < num_pf_int - 2; i++)
 		wr32(hw, I40E_PFINT_DYN_CTLN(i), val);
 
 	/* Set the FIRSTQ_INDX field to 0x7FF in PFINT_LNKLSTx */
 	val = eol << I40E_PFINT_LNKLST0_FIRSTQ_INDX_SHIFT;
 	wr32(hw, I40E_PFINT_LNKLST0, val);
-	for (i = 0; i < num_pf_int - 2; i++)
+	for (s32 i = 0; i < num_pf_int - 2; i++)
 		wr32(hw, I40E_PFINT_LNKLSTN(i), val);
 	val = eol << I40E_VPINT_LNKLST0_FIRSTQ_INDX_SHIFT;
 	for (i = 0; i < num_vfs; i++)
 		wr32(hw, I40E_VPINT_LNKLST0(i), val);
-	for (i = 0; i < num_vf_int - 2; i++)
+	for (s32 i = 0; i < num_vf_int - 2; i++)
 		wr32(hw, I40E_VPINT_LNKLSTN(i), val);
 
 	/* warn the HW of the coming Tx disables */
-- 
2.25.1

