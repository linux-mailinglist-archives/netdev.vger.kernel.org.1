Return-Path: <netdev+bounces-248221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30067D05A5B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C87AE300D497
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589E32FD7D5;
	Thu,  8 Jan 2026 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVc14Opc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E75238D54
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896098; cv=none; b=FUyQQRv3qSe7itIIpTYVdzAIuc4eRv1ylKUrV/T018gi/fGt4Y50ixvyz28qOvNZH9ovCJacaUEt6IqkM6fCYN9I+KCOyigywXDcBq7amsjrJuD1CPrHfx8Ta2KYGSY9rG5gpvbvUHfdjL8E0jnMt2y1uedQjCEVCMHconddZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896098; c=relaxed/simple;
	bh=P+VNpoWXn5StTNI90Gk2MmeCjVvVQPCMwGG15E3L0fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+JCYhhysJQPw2rSj9KhC/b0NNmk3gbD1ZTxrjy1QXt78F4iNVhs4Y3gjoyvvzSRXFT3X0YUHeeZrc2TY0hIvGiD8dLaQpevImheAdOMulow7LiKjyRTUfByTVohlbhYVH6ybsOZg2FVK5UqgAWMuaA3T4cjmhw3I4OapE/mDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVc14Opc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so628755f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767896092; x=1768500892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9nrVXytCUOxRtBOG/U2u1E3dN/2Yf8ykIJFaTP4VqQ=;
        b=eVc14OpcQkAOM7ZqvWsd3+gzi6leZSgSSks64YTmFgu8Sgtl+nblM63eoH9NDh0AcS
         WBZKtwJbCzSmV+gUiFIKYaPVQ+mfHBCmO/h174JNQaXLZXrHGemyUc19cmmV9WW4kBLu
         6KklH9YHTncsPj/JirAEFBbaahQO1xmHD9/2szwnx2XM6XaDZR/NPVABWvHPfmePLlB9
         4JzWf85dqnX45wCdOLaOz5QNqc8AflmuUQwH9BzIXp1pWsq93GAtNjtH20g+tHzBQVKy
         NHNsmlmqPh2LEFwc+hYaeS/uHWywkM8u6QBFcscpulffTSu+BgopDCVQXPqcicLSjhno
         N1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896092; x=1768500892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9nrVXytCUOxRtBOG/U2u1E3dN/2Yf8ykIJFaTP4VqQ=;
        b=pDWBuyT1g63pLl7zdtmMbKz8RZvXYcUzPwWA6fJiucpRlqNck99UDQjlV00UZuRaQ/
         7/67pkgylrDuvWrE3F1Cyp8Q98Rm3atcR4+5aVE2qPM4urYch3Tnlu4oufw9brKGAz+a
         EIpiiEuJlyFrTvoNorKOgtCv/9XpL3FCoODJN1KDw52zZ2zhjKwwUDZ3isttxX0UfICR
         fyOKiN+pU1r862Np39bzuNmtsfTjin5Cb1PU+AIIP7Dk68jMx0yCdOeXdUVbtw9Iis6x
         D1q5zEt3Mnp9hyXdDQtLM4Bn1sep69JKRCILuOQ401NyAbjODOPNMLtbyYUw0mWL2DjC
         fKRQ==
X-Gm-Message-State: AOJu0YwxL34EgQgTKJSQSzaEfY0MI8xLwvhIJ1VVnd9w2023pg30YRxi
	9DPWj5CALf+YNPfBjWiVJ93P8Gb0QQ2dT0KN/rTGWn7QkGZHvYADJJMoRCW3uTTCmKYgn/Y=
X-Gm-Gg: AY/fxX7icD7w3nPblvr95OX81Z+NkyjlD+CDgs4WRkMG9A5FiTreS/IuQUze2lAask/
	uugRD0jWSPRpLdfxs2mj0YXGuKMIkJVhi33f2iVxG8LhvrX3zk/FKtTaCDzSPs6hB+CTE1MVVht
	hSsQxmDdE8DnMGLiwiuqoz0VV/dBnGdNRP8Pmsg9sE1s6FPjJUNDn/lXCslH4fwJ02cWfw462R1
	vA1O3YvdjTjms/sx1xJ12gunoirkACpLpbFJmi7nn2Tq+dbCbCxa52TNogEQAUeB0iVecLMu/6n
	BMQjomCpOEtxjNz5dd9t0QGfWhq7CWVDHnaphmstbeaEbxbcFDsWjbDCqa/Dcujo/KNzrIwpJFg
	mnqfvcQEXGqGDaBaZ+C30iMnL/WybJgo1OSFMZ0SgCq7FgB/lp5RtWNH3h1hD4Dc4PwruSZF9OH
	qiQNZGVM5pcHOk
X-Google-Smtp-Source: AGHT+IFQHa6wezPcsYFb/lxvIinMaM7P0t4SusqiKYdrMW6g1X57dF6NFL0Jh+psOWvCodWYLcZeQw==
X-Received: by 2002:a05:6000:400f:b0:42f:edb6:3625 with SMTP id ffacd0b85a97d-432c379ba9cmr9280547f8f.53.1767896092363;
        Thu, 08 Jan 2026 10:14:52 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.43.86.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5eesm17833645f8f.34.2026.01.08.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:14:52 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: alexander.deucher@amd.com
Cc: netdev@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] drm/radeon/kv: Avoid UAF/double-free on power table parse error
Date: Fri,  9 Jan 2026 02:14:24 +0800
Message-ID: <20260108181423.1772-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kv_parse_power_table() allocates rdev->pm.dpm.ps and then allocates a
per-state kv_ps (ps_priv) for each entry. If the kv_ps kzalloc() fails,
the current code kfree()s rdev->pm.dpm.ps and returns -ENOMEM without
clearing the pointer.

The load error-unwind path will later call kv_dpm_fini(), which
dereferences rdev->pm.dpm.ps[i].ps_priv and then kfree()s rdev->pm.dpm.ps.
With rdev->pm.dpm.ps already freed in kv_parse_power_table(), this turns
into a use-after-free followed by a double-free.

Call flow:

radeon_driver_load_kms
|-> radeon_device_init
    |-> radeon_init
        |-> kv_dpm_init
            |-> kv_parse_power_table   (fails)

radeon_driver_unload_kms
|-> radeon_device_fini
    |-> radeon_fini
        |-> kv_dpm_fini                (deref/free rdev->pm.dpm.ps)

Fix this by not freeing rdev->pm.dpm.ps in the kv_ps allocation failure
path and letting the common unwind/fini path perform the cleanup.
Fixes: 41a524abff26 ("drm/radeon/kms: add dpm support for KB/KV")

Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/gpu/drm/radeon/kv_dpm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/kv_dpm.c b/drivers/gpu/drm/radeon/kv_dpm.c
index 4aa050385284..ee1889ecbd97 100644
--- a/drivers/gpu/drm/radeon/kv_dpm.c
+++ b/drivers/gpu/drm/radeon/kv_dpm.c
@@ -2472,10 +2472,8 @@ static int kv_parse_power_table(struct radeon_device *rdev)
 		if (!rdev->pm.power_state[i].clock_info)
 			return -EINVAL;
 		ps = kzalloc(sizeof(struct kv_ps), GFP_KERNEL);
-		if (ps == NULL) {
-			kfree(rdev->pm.dpm.ps);
+		if (ps == NULL)
 			return -ENOMEM;
-		}
 		rdev->pm.dpm.ps[i].ps_priv = ps;
 		k = 0;
 		idx = (u8 *)&power_state->v2.clockInfoIndex[0];
-- 
2.34.1


