Return-Path: <netdev+bounces-241649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDDC87320
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 192B5350CE2
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46462EB86C;
	Tue, 25 Nov 2025 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuPWx+Q4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494C21ABA2
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105434; cv=none; b=IO6r2uj0Uof7MbhGFcMT+Bs4UvChMt2Z6gpU9AEIXjW0DZqBb/UzC57NH6TjkXgEwobMuLxGZ+AmuwUcQpwILT5jp0attjwn7H0oknskvbDtxLUxjPHtxrjTBWwq6++wyh1OOQKxQ4CjaV9TSYEfqs2eBwh41wj42tIylgU8bBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105434; c=relaxed/simple;
	bh=BloZNbmfVPrQk64VuxzcIIsV7modmFSWWNIH0fNtBlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXbgH6f0qaZmE2sA6/PwHs8vQ5s18zIxTP82rslDimxL2nrlLpSc2FF7hXaLIYyu8zDxx+0iA0Fe6vIWwp9XOb81LXRn7knB4hcpHGwSDr5XlOl4sF/PFNeFbPwko1J9purlDzdZ8sghME/Es0zwh3tQjAX17uQx1DOQskx/9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuPWx+Q4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47118259fd8so52854945e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 13:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764105431; x=1764710231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHDXPr7K7R8BHczjYOAg+cr/Tx3BrbqxzVuPOs51T0k=;
        b=DuPWx+Q4SKPaxRxYHsdCM57etMDPmZ3MGzvD4WYhZqqo4ifjxBPeuIUlFxYE8uo5qm
         a+JFKlcQtf2yHbLW2lnJUNWqGGd6tLuHYlrUX8L/1XiSi8irGLIxiR/aV4rVfvcg6Mvd
         jBRmHQ7agh4nB/hNpgL3nDUk1vQL049iNvuW5/8uP1Wspc67zlTpJkEbSoJf3nWAi2XA
         ruoCroSzXIziSRz2Y9qN/ZqHgdoFhPN7OaROnQyAcN3I6rZX50X/C1uJr79G+DValhN/
         5he/vb9VmjMt4owIuPB54Oh4ZXW4L5uN5ZhB/jhhTd9ewvA9d90EMw+wud+AohbfLtpa
         wK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764105431; x=1764710231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHDXPr7K7R8BHczjYOAg+cr/Tx3BrbqxzVuPOs51T0k=;
        b=YVWZMji7W7t/L8sLdClHAUSRtqUOLCT/Z/nBbUJPq2fJnqMBn5m6DjK6vYLJw0uP0m
         I1WRbvJHjs+5ozmGbbNgUr50DCXqWEFz4IMJRuQoAkcfj/ptEUmjjUHddED0W06LrOOF
         GbeHUi/wfoLypMnqGViE5jDN5SZCl22TKYy4BOM9K2G3HwxQ/FTx1yj6n0HR4qHsoIW7
         4jS5Au0Iugoeky5evpNMGTzfYCvRGWLYz/2ZMHYNiz5mtt1s2uCmVOJHoB8gJo5yGvle
         2RyoORKstJ2lBLqhszZ95/O8Az3TfLqM6j/3ubofzLMWF7toSgfVbwu9WJ5i+9LQLPYy
         mOtw==
X-Gm-Message-State: AOJu0YzC1U6rHYQQSvcdhew141p1QlXRbzjfeQ5J9KCG4xEFT3kqVN3D
	ILI+lXM+cdrqEi8eApsPsS+BaMx48YaGuk+fDOgZnHIB5Rv+ZE4MJH9cVvEq+wYN
X-Gm-Gg: ASbGncsku343rS1irhVtU2STOD4AtNFav3n90ir/d1tZ3WLIa0nvVNCKynTPRruAdLD
	tDi5OZl18aWlaCz6F7Kna0jYEZT6m5z35ffJ2ooV+qqwDSKITvB/PBGJg343YKB9kAm23cNupsg
	ClLgDPPYNpBap1EZGgOLgkh4Qa+uQ5Y/2UKcGCeTzafqOn5rOFtWoZcio/+1jSNZO4FUG49fFYQ
	xxv2buqJtHGVnXDUzOV1IDyoYodvZwvMyqCGePVxVh3tvH4cG7wttJam4tnhPg0OIK7OySs2W9C
	DSW7USB4QkbsesV0+w/wSkjXJ7OHf4mIrD+xho6e3kGYMq00/LUtUt1o53iB77fc1qMlXVCtz1Y
	K9iE2s9QcliGl/3xYYNyYlCrpHCMCigRqCfgh3FzxWPrMuGujY5F2dLqe1QVcAHXU4v85mGkLf+
	+7hFkv91T+aB4sGabN7wek/1krZwz/Etg=
X-Google-Smtp-Source: AGHT+IFgACi5TmdnQeQ4+ZCFC2Tx1YLMC/kXydGEHtkHRox0BOzR1R3H0groj8Ki+M0YROchL3XyXQ==
X-Received: by 2002:a05:600c:45c5:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47904b2bcccmr52261965e9.34.1764105430852;
        Tue, 25 Nov 2025 13:17:10 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:49::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0cc186sm7172135e9.13.2025.11.25.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 13:17:10 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net] eth: fbnic: Fix counter roll-over issue
Date: Tue, 25 Nov 2025 13:17:04 -0800
Message-ID: <20251125211704.3222413-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a potential counter roll-over issue in fbnic_mbx_alloc_rx_msgs()
when calculating descriptor slots. The issue occurs when head - tail
results in a large positive value (unsigned) and the compiler interprets
head - tail - 1 as a signed value.

Since FBNIC_IPC_MBX_DESC_LEN is a power of two, use a masking operation,
which is a common way of avoiding this problem when dealing with these
sort of ring space calculations.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index c87cb9ed09e7..fcd9912e7ad3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -201,7 +201,7 @@ static int fbnic_mbx_alloc_rx_msgs(struct fbnic_dev *fbd)
 		return -ENODEV;
 
 	/* Fill all but 1 unused descriptors in the Rx queue. */
-	count = (head - tail - 1) % FBNIC_IPC_MBX_DESC_LEN;
+	count = (head - tail - 1) & (FBNIC_IPC_MBX_DESC_LEN - 1);
 	while (!err && count--) {
 		struct fbnic_tlv_msg *msg;
 
-- 
2.47.3


