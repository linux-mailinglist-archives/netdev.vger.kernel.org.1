Return-Path: <netdev+bounces-189636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 318C6AB2E6F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 06:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFE218912BE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 04:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06D253344;
	Mon, 12 May 2025 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYCzzn/X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E413CF9C;
	Mon, 12 May 2025 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747025333; cv=none; b=hulpzqWDWvBx992cppyWZ6+elmYFcMUZ+os9A7RH/bN/PhKHpWKzbrQANu0Rc9JRlJFD9wFM09sdBthn5AHJopJ+/eDqX5C9LuXg/R0ZtYV5e+0mpUE06ZCukf1+wuNLRKjbV5kI5C2wiWO5Dy5obfUJ9FPnX6HVBvaFPkALYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747025333; c=relaxed/simple;
	bh=nsLmkuVPnb/28CRHfCMdwT7g2qlCdW0XWQ41Lga1Tk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSR8gP0Z/sk63/z6Ox0CttXi0yb7V7PTNqyXQf4YdyHRKUlaX0fAAhEKSZRB1vssPMkz13vW+CGwJY+z9Fd/6DLmJDzl+An3Q6nx9kn+PwaZrNutGNd1AxacVcp300LbgFB5zaGhMORLbmhy8100jybE8ugTIspc2Qhf/xt4x9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYCzzn/X; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376e311086so5624728b3a.3;
        Sun, 11 May 2025 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747025331; x=1747630131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRrUBCGbVbquyMG2FItuKkkB+CmLoXA4P5uBzV0yYfw=;
        b=UYCzzn/Xtnl1fJlkiIipNq5Csn8B3Ca8Yce2/F17oEDZKq3Fu+lh6orOjWtDz+uyVw
         uppP/AYRbhpmB/xT1VCfsy/B/wD9fcWIRpZtSm644gB4lC9broc278KFAS/imMBlw1+8
         VyqhyOUkwK+SG1auIeCOGVFn73vgzXU283dReaYK/NzwJyTNu2I1dVoNn6aa7BLPPmFT
         SjhxIcr3YMEpLkb4lAoNaQQL995kdQWjgFGyEZ2F8ehTnEd9Fzy61qud4ABYU3Gs725N
         TouRJ331vz8Q4AHp8trrycfOt82Ruc9k+d081v9lB4QUdJsC1sSUSzb6xXGqdWNQ6mKq
         +O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747025331; x=1747630131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRrUBCGbVbquyMG2FItuKkkB+CmLoXA4P5uBzV0yYfw=;
        b=O08IwS4jXoZpqIp1lw1mABbT/AImfmLV2XnQDC/XEEIXBuP7zASK7gpUdYzMmkKMDU
         uX1wJh/rBdi+jGyIWu0+BRBKQKzzGTT/7Tep1goVsQ3lfKDu5lLo4qXqELdFUM/nuyYj
         +bQFI8qgOo6WoLCwcvanNTlddOBqbwcyYNfHPFzhPXKXmRdEQJIaISXIPHoMJBswVbNi
         ctjHhDA4U3LkZfr8iT+nLhkWhNgHxdCOqhx5Q+BxS2uZXRcy20cAeBDWcQR2HhYwtdGa
         g531Gd0f+HPx/y3JhelVKzjAjU2+rE14ZF0fb2YYjYltJaLE38BVj/TS/ix4AflhZe94
         YuJw==
X-Forwarded-Encrypted: i=1; AJvYcCUUan40iT2Ij7FZ2S/6LA9+UolgbMy7BMd8XXOBOOxu1KxH+ycAQ0QhzrSQvwpbdUZrITNB7xO8@vger.kernel.org, AJvYcCVRSbAnt4Lluaolzd6/S5Lu9+pW3z1PRWn85pdOA45zjkSNgIMgVBcHGjwlg35nC7OhUvHY9mORPNkjeeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywq6BKs4jDpZwkGjPHlGW3nzpuqREbLQZ5CPulTHN77j1X5sPM
	PyddCDavfedlhgeiMCK1x21lJnnBZs2z65WEBtcHoilIjYktZRK1/bAT9w==
X-Gm-Gg: ASbGncvcielHo6CfELgsI7CLPA3DHejiKQRpTOHoYhnL83NwWDPevmmtWbudS5wHKJy
	R2+EgZj1qhg1WNPh178fqUC6+7JynY9NN+xTN2nwPouMcd0sSZq3nGaXcqj35DyeVNZ19hxTSvx
	DK9Y4aQP//mmKDwqmDqSYiwprpyVA9ZGf846U7c/vioMXwN/HO6YvVejHCQa+W23vqsBkAyaojo
	bbBqldN1vpOjFFuHYyAJ7Ags2wk0Y9wVkrsUs+q8oGtU7W5tU3EcLIr4t609eFAoXQHrOA8UZwZ
	1GzuUSuuQuUBRn3ZI/ZgSVVGGUZ1tp+h9ZMyoVp056r1kHLODwq2d6e6VBg=
X-Google-Smtp-Source: AGHT+IF5aYVaVS1Sv7vYrAOH6rCU1390+vmDNMoz53hzN6JGYcYvVfemYIWGz6WSYFL62CC1L5i7rg==
X-Received: by 2002:a05:6a20:958e:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-215abbbba99mr15944647637.11.1747025331539;
        Sun, 11 May 2025 21:48:51 -0700 (PDT)
Received: from nsys.iitm.ac.in ([103.158.43.24])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-742377041bfsm5370854b3a.12.2025.05.11.21.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 21:48:50 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: shshaikh@marvell.com
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	horms@kernel.org,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sucheta.chakraborty@qlogic.com,
	rajesh.borundia@qlogic.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()
Date: Mon, 12 May 2025 10:18:27 +0530
Message-ID: <20250512044829.36400-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one of the error paths in qlcnic_sriov_channel_cfg_cmd(), the memory
allocated in qlcnic_sriov_alloc_bc_mbx_args() for mailbox arguments is
not freed. Fix that by jumping to the error path that frees them, by
calling qlcnic_free_mbx_args(). This was found using static analysis.

Fixes: f197a7aa6288 ("qlcnic: VF-PF communication channel implementation")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
This patch is only compile tested. Not tested on real hardware.

V1->V2 : Added information about how the bug was found and how the 
patch was tested, as suggested by Simon Horman.

 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 28d24d59efb8..d57b976b9040 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -1484,8 +1484,11 @@ static int qlcnic_sriov_channel_cfg_cmd(struct qlcnic_adapter *adapter, u8 cmd_o
 	}
 
 	cmd_op = (cmd.rsp.arg[0] & 0xff);
-	if (cmd.rsp.arg[0] >> 25 == 2)
-		return 2;
+	if (cmd.rsp.arg[0] >> 25 == 2) {
+		ret = 2;
+		goto out;
+	}
+
 	if (cmd_op == QLCNIC_BC_CMD_CHANNEL_INIT)
 		set_bit(QLC_BC_VF_STATE, &vf->state);
 	else
-- 
2.47.2


