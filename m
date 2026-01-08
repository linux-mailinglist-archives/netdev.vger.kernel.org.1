Return-Path: <netdev+bounces-248246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19998D05AF7
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97A213007699
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34E27F00A;
	Thu,  8 Jan 2026 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH/vr4KI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBB230BCB
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898115; cv=none; b=eAGcJcKJnMO6bu79V5BvNS5XzqgDnMHfr7S/lM02HqNExNVrt0S+iPpUzUhFKm7TIqzNZiy4kJmFrS/IqMYl19ry4EQeDl+nG18HC/PcUmiaGkxp/nfwH33XfwspqJ/zZl66R9LuQfH2VawlrSbqy5svY4uw8ULJ1boxjnbuiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898115; c=relaxed/simple;
	bh=cwp1Mrwqv0eoxdv01wEfOpLvzIf0ijJYV3HVq0Vl6hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTfkvEHS1d+6qgP/gTew1goQlXSqv+81FZ3Xq5seeE6Opmp6v4w/R4RxGGJz7dTaymKi68fRtqggtXh0J8sxgYnweUCZ6df9MB1/jYLjZCxNv8YabzTBVVgtGFBkij39Q1OqAbfEueNe4pGzqcy+uCl87K5s9sUcI974H/7G51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH/vr4KI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so21236645e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767898112; x=1768502912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6byj3l499CYP6Jvy37bW5MCtNkOsDXtvYU9D7/Vhs8=;
        b=LH/vr4KIUVbrnKvOkg/oQMVIWFixyiUQzkJbXodW1nrR7VkiqOp2dHUdihksTUnsso
         trwt3yhbvHyMT7n1UkrwDEYGsg5gBHJlkcn8gLtaiUQRozAxIyYjFH1JAkGtB8LeXexs
         srNe0vy8qDuCalmfki8J4cRK1dQ+gae7L53DVgWV/HOjX22yf/QLCUTTRqcPJh4NSHCi
         gfn8HNTHU6pCH0AaGB4k+8Lqz68+k4K2AVwlQXXEdwkbSIJH5a1befIN9rkIIfQXNujh
         ZvVLsvnEIIIBvrA1vXnWwrMFmtZA26gYqzKF5MHBPY6AcKrY5ekwsUY2fzggV9upcHDf
         kICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767898112; x=1768502912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6byj3l499CYP6Jvy37bW5MCtNkOsDXtvYU9D7/Vhs8=;
        b=iTyQKuoOAmMQxPabk7LZGTOuC0FBGlD0Hg/ZT7FyrpNpOvOn1V2EW766eqNSBEELJK
         iD3xDHyL5UT/8ssyI/DXns5LBnUX/ryAbSc/yv5leWzlGu/DMACxG7ZNMnx6wEDiqQqn
         5U7Q1xV2KBDxK5xDRGQ9rshvMJrhnxq4aqsaWYiVyJM+KjEMHZrfOV7Drh40at8kfRvh
         lZowaKgKamRlvtBxANIx1UXwMhIAE+CVT4PWewZWQ88fK+oXDpwOus3ejt+T+YjvkKhF
         JMMq8TAxQtahBhFZHECSLBeMgMoXnKh97v1MXdGeYExfp9KxRY5uRUbYwYfGr+g5ZidZ
         LtgA==
X-Gm-Message-State: AOJu0YyCLIHTuEhUd+7PiEZ5pdeOsY2DbhdYhjeue60R/35tdy8MlA34
	TGtc5lBaGfKpGb/rfFE9kPkkb/T30ZH2ifaFY8PB5p6VsrjmoXJXhtc=
X-Gm-Gg: AY/fxX7X4EAiRhlhUPX1AeAYuAY1jhmCrdyXufE8KPv6fDRxtJWtDc5JdgUg0hiRwNd
	NDJHI8niLcQ0UvNamTZSh4g4rFnGlbMuBf5TU4hLUPApxZwUvnnvt8QheDiezicTOlTWrX2Ghsp
	TvryVa0SdzFhH2BqV/tPe9Axd5lOb/GD61Knl8eGjDx7jCdxNwiSaOE0nsbpw3ks3VtXWwx93/p
	W63M4l+VrwOn82KmStNHupAiEsXnVLjTjeKvbDOm9WNLlCW85cNfZAxSHijN089eSWKJg6kcTiz
	dchprlxKrFRAOxYvgClV5u7EuaFun4clSBQKKgQbJI6jHNcKncPYKwlQKRTxzbyWzzgXHKOQvQy
	JK+kv7OAe3KW7bY5CCylXLoucEUTSRjv+ix/O2kBikiklARRghbps5CqxU1BfBYDzfHlP0+E81i
	jrWFtCb1rQGUe2
X-Google-Smtp-Source: AGHT+IHK+F1RmoP+kpgDGVhzwngbhxjIUsHyn7D7h8MljBg/QOnpBdj2zXVwzk87U6dp2EJtUxklXQ==
X-Received: by 2002:a05:600c:4fc6:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-47d84b0b320mr83819425e9.1.1767898111702;
        Thu, 08 Jan 2026 10:48:31 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.43.86.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8661caffsm43013065e9.5.2026.01.08.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:48:31 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: christian.koenig@amd.com
Cc: netdev@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] drm/radeon/sumo: Avoid UAF/double-free on power table parse errors
Date: Fri,  9 Jan 2026 02:48:23 +0800
Message-ID: <20260108184823.1795-1-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sumo_parse_power_table() allocates rdev->pm.dpm.ps and then allocates a
per-state sumo_ps (ps_priv) for each entry. On error, it currently frees
rdev->pm.dpm.ps in two places:

- if (!rdev->pm.power_state[i].clock_info) { kfree(rdev->pm.dpm.ps); ... }
- if (ps == NULL) { kfree(rdev->pm.dpm.ps); ... }

However, when sumo_parse_power_table() fails during the load/init path,
the driver later unwinds and calls the corresponding fini path, which
dereferences rdev->pm.dpm.ps[i].ps_priv and then frees rdev->pm.dpm.ps.

Freeing rdev->pm.dpm.ps inside sumo_parse_power_table() leaves a dangling
pointer that the unwind/fini path will both dereference and free again,
resulting in a use-after-free and a double-free.

Fix this by removing the local kfree(rdev->pm.dpm.ps) from the error
returns in sumo_parse_power_table() and letting the common unwind/fini
path perform the cleanup.
Fixes: 80ea2c129c76 ("drm/radeon/kms: add dpm support for sumo asics (v2)")

Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/gpu/drm/radeon/sumo_dpm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/sumo_dpm.c b/drivers/gpu/drm/radeon/sumo_dpm.c
index b11f7c5bbcbe..af649b7b2e1a 100644
--- a/drivers/gpu/drm/radeon/sumo_dpm.c
+++ b/drivers/gpu/drm/radeon/sumo_dpm.c
@@ -1491,15 +1491,11 @@ static int sumo_parse_power_table(struct radeon_device *rdev)
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
-		if (!rdev->pm.power_state[i].clock_info) {
-			kfree(rdev->pm.dpm.ps);
+		if (!rdev->pm.power_state[i].clock_info)
 			return -EINVAL;
-		}
 		ps = kzalloc(sizeof(struct sumo_ps), GFP_KERNEL);
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


