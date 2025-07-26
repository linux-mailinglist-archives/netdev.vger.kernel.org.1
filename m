Return-Path: <netdev+bounces-210278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC2B1295E
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 09:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF72B544C73
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8341E9B0D;
	Sat, 26 Jul 2025 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWc/vGPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55E946C
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753513445; cv=none; b=MwzNCVTUXSJrBcOKFBPihKI9i4TMWoiG+lIeH37EbPpdG+pk+sYFZ7CukwosYkkcxgRdIs8RKnyfN2+n8ZxGThZ5UtPUIu71x0T44m8pidWfIg5anfpxtZz6ce6mLnyU1wCiT+3qznAe9ZQKlRlWKaJpy0DyAHOIWd7FsxhaLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753513445; c=relaxed/simple;
	bh=BL+EfgNMkPUAntwcnK1Ia/wwE95aC360ctPnoRK8qG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C+NFKKVCQgb1L6kwKxMBStY8Yox4RWSVF+Po+v/U2RnzWLcJxuiUTuCLCAGyUQyWowmuTNJR++r6WkLaO1D/PFWLRv3HR89TUYLsfBgJm7jaMs47obqc5FUP6K3cotAZ8rujfZTaXMNHZOvKdod6yBoe3kjzzjF/SAYOVCkjUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWc/vGPA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236470b2dceso24717815ad.0
        for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753513443; x=1754118243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzxyt4n75ioi07l8a7XMpiZyFP3lgEvZPPzPSNVfOHs=;
        b=HWc/vGPAYQP9/XzNdmlQ7hvCk6m/lTMy5TFqq7DBs3eZrTV0PwFdl7H+Kr49VoQ7ha
         CY+tLovzuG2V3gw2Bgd0qd2dgkj6FSZdJoTX54RzMWAzcMEURaZPI4ft1EOdFvXwcX6i
         P/ZIYi5JRQr5UpCGYjvVExuuZ1JcxqWYuEtchoXQMKYRWvqDCDRLNH0/BVkCtL5A9r24
         vXNeWqnbDw60pmOYevnXKfDJLZCDi+ARRls5/pTLFpBz6ma+eM73MIlH9L/b/Rqq+/du
         jtXWu6zS/4H0ZKDIhTQoLNw1a8xXTVTWWVQPb55ug9uwYt9hPPFROMvkcWELEhlhLbuq
         UrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753513443; x=1754118243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pzxyt4n75ioi07l8a7XMpiZyFP3lgEvZPPzPSNVfOHs=;
        b=kQvBtuYLWneNiCJHZWY841wuqJ7wDQ4snOjP1m5SLln8qXyQ8YYcV0tp2TrEs9lX2u
         Z7MWkp6Ls5V2GazPV8Ze2Szv6IWJZiwSsp6PKlv/nk3C+zbxGnqHnnsJSyWTcHsJdyNA
         LYrwNDaqLVHssrGzstYaTNGV3kTjVwoMrNPuv0tXX0DL6bYa+BtMncvTYGlFGlYXm2Km
         kNMS7BehDzadui+9cSF7OMJeHUL+BeHKKnl3avTDwpzpyYG+uuzas047p3kZB/d+buBd
         sS+7TJwBRuSWipne78UpysvftFOCDjvPCarqhlffPd6q5y05QjulkWxpeNq+OLgUEJkL
         ZYRw==
X-Forwarded-Encrypted: i=1; AJvYcCVezgN/YjMmzN1NiqKXS/r1VJG1f+0FLDLIh4aMROQQ42I5/uuAsilZUwG+FXhc6bNBu1ak8Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOLqSouu1MMPg4dTXb1zvzxdBg+qhs7jvw0a92XRtwg2irtDs
	o8j2b9hVmUjWmcV6UYSHTXDktjKBJYIBL+TOC/lHQn+WTyE/cvs/i0Gi
X-Gm-Gg: ASbGncu43xMN7VDq6aFSc5JG71yjDANroaDKxZuQ9zNkeaRyKJv2aMOIqiROnlRak32
	GEWbdfUKNOkztBEKjq9Mmt3Y7/Ahl4tL2KTnGNp0uEuEW6Ymd8v65XsFCLkw8XhktOvdJftEOuJ
	v4YyBwSo26+0flejapV8SuTDv2UdiEzvO+l6Eb/l9T+29VQ9+px2wfjNbKutjIq3BBAuZZO1pFF
	E9nOxPWpWMJpdiB3JbMlgrAvXD/8ZVoll3PSb/jCHQUpQ36+33DDbEVBGxNuM+dritLWc8ZNz8d
	zQ91Nms0YNXH0PEUO2nQhXDUhGAz+PHzr7n6sDSIFg6VSBJJMwnRv9587z6NCWLE7eBYWogmKeA
	aHRp0DuALhdKLoBV1Mk6htjxDWC+a09UA4mbQlgRQPaN2mZsB8K54s1qBdsg=
X-Google-Smtp-Source: AGHT+IEJHo4UWqF7gjVF86zH2isjnCfKqpnMnFffjQOMthHWa3P0OJj56JLYUczRy0a9KAK7aDGL4Q==
X-Received: by 2002:a17:903:3c6e:b0:235:779:edf0 with SMTP id d9443c01a7336-23fb31c303fmr71032055ad.50.1753513442738;
        Sat, 26 Jul 2025 00:04:02 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe51408esm11216075ad.139.2025.07.26.00.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 00:04:02 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	larysa.zaremba@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 iwl-net] ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc
Date: Sat, 26 Jul 2025 15:03:56 +0800
Message-Id: <20250726070356.58183-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Resolve the budget negative overflow which leads to returning true in
ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.

Before this patch, when the budget is decreased to zero and finishes
sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
and enter into the while() statement to see if it should keep processing
packets, but in the meantime it unexpectedly decreases the value again to
'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
true, showing 'we complete cleaning the budget'. That also means
'clean_complete = true' in ixgbe_poll.

The true theory behind this is if that budget number of descs are consumed,
it implies that we might have more descs to be done. So we should return
false in ixgbe_xmit_zc to tell napi poll to find another chance to start
polling to handle the rest of descs. On the contrary, returning true here
means job done and we know we finish all the possible descs this time and
we don't intend to start a new napi poll.

It is apparently against our expectations. Please also see how
ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
to make sure the budget can be decreased to zero at most and the negative
overflow never happens.

The patch adds 'likely' because we rarely would not hit the loop codition
since the standard budget is 256.

Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
Link: https://lore.kernel.org/all/20250720091123.474-3-kerneljasonxing@gmail.com/
1. use 'negative overflow' instead of 'underflow' (Willem)
2. add reviewed-by tag (Larysa)
3. target iwl-net branch (Larysa)
4. add the reason why the patch adds likely() (Larysa)
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index ac58964b2f08..7b941505a9d0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (budget-- > 0) {
+	while (likely(budget)) {
 		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
 			work_done = false;
 			break;
@@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
 			xdp_ring->next_to_use = 0;
+
+		budget--;
 	}
 
 	if (tx_desc) {
-- 
2.41.3


