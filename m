Return-Path: <netdev+bounces-248881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE17D108D9
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 05:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06B09301E6B8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610F268C42;
	Mon, 12 Jan 2026 04:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqT4ntmh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29C3D6F
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191666; cv=none; b=k7E3/d2pnNXChQLc/zw8YMIPAAroq09NbSyWzGy2RtaxdLZrG1Bjejdl3Nqhp8c5vOd1LyMd+C6wYjXI8BuOc1Gw8GxcITGBV5XfMqbZiunfnthqi/GyNdj7HjKJ5Nc3SbsMxuQkkddYe2ST8NQA0fUyv7xDxKRgLU9CrU4epO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191666; c=relaxed/simple;
	bh=Nciikyja+YLcLgGqFwl5ErEmhqrI+gVtzLiqfexGI3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUtFDQpKnQ+VRRVGU43wBXox3IaeXWGJNm2Ltwzp3JyLhOtiV+4n/ESWDxEK7nEU5guBSFO6yD1tlDZT4wktr+moBZjABR5oSbzYavLPktp0kf9ROMZ1Ph3Od/Ikw+vycNBGhzlAkteUKiAF2OwZgR9H1lpoPq58Zaa1o0UGIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqT4ntmh; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81e93c5961cso1780962b3a.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 20:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768191664; x=1768796464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nciikyja+YLcLgGqFwl5ErEmhqrI+gVtzLiqfexGI3I=;
        b=mqT4ntmhg67JUDSPPwpQ5HzL6TB+Ml43UadV/C6Wk3ynwsDnkaceine5ywScrSqGLm
         mnFlHiYfnZAyPp1UsCN4lJgNmBavl0cYIQ9bJtTqnYiN9yMckdeDnh3T+giOBpv+KTuz
         tOTCjb1ziiPW0hwtt3sCszSlP0p+yGMtg5ZdkgAvshnR7wDh8Id6h4Zp9atLKB6A1aC9
         5S2HB9C8InSTbm7t71s5TAw0XkGcXER5UxoR6mFCUal3j5iwrv5tAtpl7GR1UuherZDu
         /8pK3UeC+I/La6fWycQycPgexhe4KoMrW9BxoR1p0gH30PQmxwW0QZzSkfyLb4cSmguy
         rVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768191664; x=1768796464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nciikyja+YLcLgGqFwl5ErEmhqrI+gVtzLiqfexGI3I=;
        b=aI6vBGYLDKlqWxSFN65h+ZCngPVowLzHQFd6XlD4YWIyAqMdRI6GAEukwfZcElogrA
         p7um41QbTJTQIOOiMrlMbHi6IauEejKuks8heE/tqNBJEO1UmWiLnZ53Z5TwcBQJBhLY
         3ySZ4e4Go+XKJtK7WC35nCybpWFBGxsz/K8pBE1BrWRri2QK4D+DI2zzlrMqUU9OH6Qb
         39cxD8xqau61b4hN1pXWXn8+bn0RlbqkN7dcWOEK3FE8FUf5d3qIi+ibopaypOBqqOgf
         Lz99NlQhrd1zsCOrWY/PJRtEoDKT6MT8+mQB1906njjdjecwNoy7yJGpeC6a43DCw/Jm
         3S8Q==
X-Gm-Message-State: AOJu0YwfhIC0IjxhFF/yxsynqZSSajXL23Vw6YBjeM/P43nX5DDXXbVG
	i4qw6wT/Cs3TYXjfp3vYN+kZ18H618pG4jXPX5oOY3RALqUL+XsIK9uPLMRvQDPGRA==
X-Gm-Gg: AY/fxX6r26xdLqsB5AThv+LZP0XgTi+R2qQRyQZ0qNbTM4CzH2ztSFsnefZWL7hIIGj
	FN1MJNuf0iJs2dD3+/4rCsFle1eqClyuVsICG24CjCOilHmtKsWlrKW7QhPwmQTk3SvYujGu0vk
	Y5wOp3QqVwTeTSlEJkTPi4qPpVLxibrqYj4PYq8Ug1NdtQqLW+VGvX/J/HrUWV7tnrEJgVZC3+F
	6Cnt/2q2Lh6BgTJ1jW4qWXglIgV0V3Hfu5BBOrOTHrRF4oLW78J3BCVJkcv/dY8gAVZxO33/U7Q
	648R01e2AcnUPLUIyPe1o4q+5AIMvJJ5WV49FhYYpAdWQuYvGNlH6rX+FCRkn8PSGV7ZWKSfzvG
	SDQ9TDfGwsGOHG2b/f4x5QtmUZ9oXdZYyBtWnovetu2uZQqpMaFM0lE++AwuxPEpKNnwNAyZMou
	VuSgmLqhHH/xz4FsSNmsROr+uQUm9LvpVCcgVyw8is
X-Google-Smtp-Source: AGHT+IHZpT6aWRlZq21jN5DCLVhHQFqWplQ3iw+cygS38lVawxObXCzHdl7LAQF+XQnVSOiw21Umvw==
X-Received: by 2002:a05:6a00:2a09:b0:81f:3957:276d with SMTP id d2e1a72fcca58-81f39572b67mr5108764b3a.39.1768191664075;
        Sun, 11 Jan 2026 20:21:04 -0800 (PST)
Received: from localhost.localdomain ([38.190.47.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c530133csm16120550b3a.31.2026.01.11.20.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 20:21:03 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: quic_luoj@quicinc.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinseok Kim <always.starving0@gmail.com>
Subject: [PATCH] net: qualcomm: ppe: Remove redundant include of dev_printk.h
Date: Sun, 11 Jan 2026 20:20:38 -0800
Message-ID: <20260112042038.2553-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header <linux/device.h> already includes <linux/dev_printk.h>.
Therefore, explicitly including <linux/dev_printk.h> is unnecessary.

This patch removes the redundant include. No functional changes.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
index fd959a76ff43..df9f0cdad626 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
@@ -7,7 +7,6 @@

 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
-#include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
--
2.43.0

