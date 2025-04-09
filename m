Return-Path: <netdev+bounces-180601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A5A81C4B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38CE19E6D9F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD051DE3D6;
	Wed,  9 Apr 2025 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP6EiCzR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925F1DDC1D;
	Wed,  9 Apr 2025 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744177504; cv=none; b=YAY7CPrijgW+ZRGuUDyHbZAV/GTlFkT7u+prd9tOLTUjBIdak41A6it2MpEJc4g4MdfjCMy2VLGz2YFb0FxcxhQGikCy3qtFCJiBkhu9gR2EL11N1uKoJ9wcJG0sTVNa0qi3Lo9Lt3a0Se8duLP5nq8lQYF43/5GEcdOlqGIKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744177504; c=relaxed/simple;
	bh=RrmIT8YtRyH5uciU+APhdTifQitGVirWpHrFa5NrC9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyUY5uzKSuSrLM51fZ+2Uk/jjPhkvrVQQaUrQ/mmAJcleWJgfJPZRvSK13nKmBm+TOcajqQVSeG3Q7vNCZjmAWot3kcsZLUtssOzRyJYBANi3y8tLbBaJ5G5Eg6w7MKyJ9nxz8KWcaBifKqI65zEEC+5Dh8iFxEXixkBEXZE6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP6EiCzR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fb0f619dso64193815ad.1;
        Tue, 08 Apr 2025 22:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744177502; x=1744782302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4tdLXA1FzEGiJuX0pStB4CaIgSZYq1B1XInP1qa+NWU=;
        b=jP6EiCzRL/SuiD45ivqf7F8L/pq+YhoUB8We/eE06mz9ke8pgxJn094kJHwuc4+fUu
         rj3tWWdDsm6L1NjdZRKD/uhx5llGGxmJqeUU/4isNpeNXrqglojhZmJ4G1zcl1lIrGg+
         Cs8YeUsCKOTi4aB88ZV2NOv/yZX8QdV04BT59PqwzT7/voEZOAsCNMe0LW8X4wJq84GC
         /I9IaR0USm7vCe4fd3dw36cS2HBsddm9EexDyPBYaATj0dxrmz8vWwfgEToIL8UQ4EzR
         dudP2ObKZ8Pa3JxIS39MPQCRd4BLMgbwH9N4MDEvcKebx4Te1nE0mQLES2ZrlkxwzDyQ
         Vn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744177502; x=1744782302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tdLXA1FzEGiJuX0pStB4CaIgSZYq1B1XInP1qa+NWU=;
        b=LfMIxiYNKQnsDwAg8n8gAVKgad6/KYKtAVk7Hf0GAYGGpby5kUR4476bXQPtDCNddl
         ORGmWOEez/i7YA/iPrpQmYlkMLrt7B0clRyNMDr686bj9okjYGdKhBqBf6P/l1PULDBN
         UP450kHHpeBGxW5pPU3/tlj70BWPo7TXsO48D7B9mufXtbbn2hsbo4bssGhl/WWRid+t
         guT75s48TIV+P90A6uAz6d/AnBYo8R8qKFa6jlQEtWIWRSfSe3LLxATNwvzzwsB9ryhR
         VYOIIopqXTPR1yVWb/i5MBSwU5pJWNRYEn9Ogyeq33blIpwgCNtKvKTNGy+S8izXdMs4
         ctWA==
X-Forwarded-Encrypted: i=1; AJvYcCVdVQHp4Wgw31O9L82fEfiXrqy4eWmtNeCYxAQPFyxNc7Dqb3xjOy8yer33IzHTps6orBmhqcRbBBXirKA=@vger.kernel.org, AJvYcCVqG490fga0/6ZmZuhyUiR2jDsg/Oe4xO61WIxrcOM5Ks8F2dKn1JytOzEpYVLBJWO1+xldcHGu@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5w3IKEvfaH+Ig15nrJ7Kgu4kXiP4hqe8F3ZIV74pgXfPsy+P
	GeA3dp8soo6/eRJbKiPJwM7pHnbCXHJWpwwmdxqjodtLL5aFbeoV
X-Gm-Gg: ASbGnctZb3V7VrK4PigfXPz6xqsd30r6zeLfEZ+VQnGqXBH1/twNfd6qxC8NpvQ5Kky
	BNoX6DCWSh0Skpdv0JG8m+1XOTlPrH01XYMIwwKQchKILGTqHJGrYBcvOoqWoZYzEgBbxiCE0Oz
	x4bLitjssvJ5zMopykiAfOXc0hvqA+sni76CqAjqU8FL18jlaHbGB56SJkbURbK3iGk8a41pEgh
	q2690KeesvDQoZx3PffIpkdfHHEamIVwo0BjVsRt7LU18P8VlXPaYiCjjsh9HMJ+gNIEQRbdW0v
	4H3mCjfRUCHaYVrfS7grDeuPX3o/qweNwtUVv0oN5KgIbJ6zplEJ
X-Google-Smtp-Source: AGHT+IEFqcxtZ/CXqP3CS4wtlZCcbs1pKOROAMByy7c4S3MzEaeHVv2C6tLDy4ndskpcJl012BF5aA==
X-Received: by 2002:a17:902:d487:b0:215:4a4e:9262 with SMTP id d9443c01a7336-22ac296e727mr21281165ad.8.1744177501998;
        Tue, 08 Apr 2025 22:45:01 -0700 (PDT)
Received: from nsys.iitm.ac.in ([103.158.43.24])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306df06a71fsm471316a91.8.2025.04.08.22.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:45:01 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: shannon.nelson@amd.com
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] pds_core: fix memory leak in pdsc_debugfs_add_qcq()
Date: Wed,  9 Apr 2025 11:14:48 +0530
Message-ID: <20250409054450.48606-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for intr_ctrl_regset, which is passed to
debugfs_create_regset32() may not be cleaned up when the driver is
removed. Fix that by using device managed allocation for it.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/net/ethernet/amd/pds_core/debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index ac37a4e738ae..04c5e3abd8d7 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -154,8 +154,9 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 		debugfs_create_u32("index", 0400, intr_dentry, &intr->index);
 		debugfs_create_u32("vector", 0400, intr_dentry, &intr->vector);
 
-		intr_ctrl_regset = kzalloc(sizeof(*intr_ctrl_regset),
-					   GFP_KERNEL);
+		intr_ctrl_regset = devm_kzalloc(pdsc->dev,
+						sizeof(*intr_ctrl_regset),
+						GFP_KERNEL);
 		if (!intr_ctrl_regset)
 			return;
 		intr_ctrl_regset->regs = intr_ctrl_regs;
-- 
2.47.2


