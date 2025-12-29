Return-Path: <netdev+bounces-246249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE11CE7C2F
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FDBC3014DB4
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403E2D0600;
	Mon, 29 Dec 2025 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bza/5PBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95922110
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029689; cv=none; b=LgtpxZBOn426ESpndAFq7lKb7ZbpHz6w5G3hyiE/Sojh84dgapb3egf3eTjdC2lGQdY+iY7f+pk7DnLusuPI+pQhcqpwQsKuRPAq0FCIlcjgm1Tc5+SP3LrdJ7VDWtL/C5L2Vsr64BZD2S0Gm2nwCSywf5w33GjAyVbxv/2ptkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029689; c=relaxed/simple;
	bh=sdGMk9EB8gqWtqdOUkW5SwkY9/SkqRER3wiRd9OBAtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noY1HC3pB5JC3RK6G3E6fOPWV55Tt/I62af++oMpCGE2wciLUK74genqycywKFaMdlSSeurX0ijQt9tf5K7LAtAZvpCi5Cwc1cCv/y1oYRMq0wrPNZBb3XxEUjdzIosp8FjoV/p/bd+Kitv4AiG956xly+h5bU0IKLsIl6JLUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bza/5PBQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so11344315a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767029686; x=1767634486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/zOeeGYBIiOih39epgwxZku0wEMTrEqOJqJlfEKcMxk=;
        b=bza/5PBQLdNTtIcySoG8BlNttoLcNUKSRWiLutQ04S/dVv5qkM5xnBUiL/vKzaasSl
         bE+lMPFZhGe7NMdxmSBurk4Rlk8gczFWdc42TrYbtvcGyrKAOZ6QlMQ3hL+vrkS50Q2R
         oDuzVhk5ax0iFhWbZ0bMVgQiceNrEuPfrul4EeEtZA7fvPVSS8s+yiv1KeoU33qD1GIs
         PBBAuXGhXCLpYGj3cb9sxZzYt/5GUC1bUrI2lVJxk8gBHYqa5rjoorFGXCp4gt0qW+Uc
         b8Pwo2A0HJe53x1zO1y4it+g2Hh3uInY+aLdPdFJxbuGs4hbwFwu5CrLqJ3BnPYfAKzy
         DkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767029686; x=1767634486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zOeeGYBIiOih39epgwxZku0wEMTrEqOJqJlfEKcMxk=;
        b=mhO6hJrW9IYcnsgrCejiQrW3fFxAYGlWRl/2k6ZPdX+KiQP5Abq97xRwoXGVZV6DUR
         pnveYCLNYJ6lhkxzU2dYR247ky5Us4Y2+YvnxayEC6nN2ITX6xQPF3wCoboaOC17qoSb
         bVOGikXWaKggB0x62v+w+uY7i4HHNBRB3hmCkB2gzig9mOnk+saQfvVmqAcTvqW4L7GR
         O43pxm/QFGScBqU7yqn5zL4FXls7tZS/R0wZAggFGzESoDtGne26+rJVNhs6626Ah49P
         YGqFt/8IjXckhP7DvTXzIv4aHLluec+Af5+kSz8gXx3JulxTyWBkWMh7WUx8s+VRpQVG
         f/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU/rT9yyhibcJL7xPTEHuE6SjJFk9wwGMvoM8xbmr1+QCInz5K6WCsW52qG0msf68/HC2ZEcvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGTsBcuw+/SFeU16YgSkDoRlpvZZ87FAMh5UPrsTJng0p1N0xZ
	cdZrH8svDIMcNd+5ydwhaCw8BP9HTc1C7AUDUfszN/TaL0QUUQktRoBb
X-Gm-Gg: AY/fxX7YZZtIGHA0xuiXEPAOkbH7ZUWOJC8rWMKh9OLwM9rHLaafrQev9j3fsPNrmdi
	gbuLK88Zym7No7xLn7VddIaco/O3mv3gbQsrzPxmjvzR7b1V/kfMFoYYOHqWBGVwK1ukKRYnNnz
	t9sVcxwE/2OyyGPncVC0h3enY/KqNwZe1yRSZF4rRy8NZN2HS7Qu+2rUdPvFxoHGCVy2ULEpXsM
	e3S6WjS9pRU5GY5TC+xzo/PHgf032iGSG19ayCFIHPdhU51EYUbp2R+uqbcr0czDqZr7KpGPDrk
	n7qOSyp0z7FAskAZNnSFZBZoi5yWI0M3jqGc1khyJzh9v8rq5dl7u7nBD8tNA66JZIgscmtQ4m5
	Jtcc9/jNuKQfbm99jTXzvo/NM9IizK1i9CX7poCiLoxZfY+2drIffhtpUlD0AHBDr/eYEr3oG4z
	+8l6bSIRqBqLlx5BbZrHhAmc8QxyCqZleh6Q==
X-Google-Smtp-Source: AGHT+IHgC/ULlKISg2ggpsw0iC6aYKaCX+oKlik8E4+Va0nXe7E0iDbz/6R38zjd0YQ2fB6osREjOw==
X-Received: by 2002:a05:6402:2106:b0:64e:952d:9c64 with SMTP id 4fb4d7f45d1cf-64e952d9d9amr6393626a12.8.1767029685962;
        Mon, 29 Dec 2025 09:34:45 -0800 (PST)
Received: from localhost.localdomain ([196.189.127.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b916adc61sm32815106a12.31.2025.12.29.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 09:34:45 -0800 (PST)
From: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Tinsae Tadesse <tinsaetadesse2015@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix PTP driver warnings by removing settime64 check
Date: Mon, 29 Dec 2025 20:32:07 +0300
Message-ID: <20251229173346.8899-1-tinsaetadesse2015@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
---
 drivers/ptp/ptp_clock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index b0e167c0b3eb..5374b3e9ad15 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -323,8 +323,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	size_t size;
 
 	if (WARN_ON_ONCE(info->n_alarm > PTP_MAX_ALARMS ||
-			 (!info->gettimex64 && !info->gettime64) ||
-			 !info->settime64))
+			 (!info->gettimex64 && !info->gettime64)))
 		return ERR_PTR(-EINVAL);
 
 	/* Initialize a clock structure. */
-- 
2.47.3


