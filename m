Return-Path: <netdev+bounces-101078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D78FD2CA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEB91F24852
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE50188CBB;
	Wed,  5 Jun 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="WmTH1/0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F28188CC0
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604368; cv=none; b=YJnfa0RonHhpCpazY/Qhm1/2b03otjYUkocKEBHldJ5FKcMgrfc91B5tddC8WuP5MyG7X2SebIW0DQhtPU4Uywr3J9fUW1LYlwbpJD/2jrN/5uZXqJowHj0CZaWzqxP9+iSTXIi9xHS/9xoRjcvwa/Eas/rgZlvqZSjEdRFT7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604368; c=relaxed/simple;
	bh=5qUaQkk47mgLGOEF2DXQyb/lq4V7UpIMZhzNEuIylS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dm/Hh89naM12lSqr6W36LfWexHj4E9onY8FDJNUglUNTZM8B/ParREnxu40dg5yRhyOX9l2cTfm4T+95lvA1lwKieUnB6EWOQ/EYzBjC3kuvDVOknSWeZitNX7L7RDIhIxHFlwd2PRwooCITRniQVw9PVH3ZrRmBP4JDbG483iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=WmTH1/0I; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4603237e0so713531b3a.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1717604367; x=1718209167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llUYe07TgtX9pNzx/VwPY9IpXBVRel1c/RAIZQqo230=;
        b=WmTH1/0Idnf9+tBrt9N+xTe/kV0IwW53aPAjLh8RHaUvQ8S+uAmFVbS3b8DFdax+gd
         VlvbRb54B1FenqDjtNohKEt5iW+xPLK4t/500LCuOgd1bXb2Y9h1ymuOw51ign2FkX+y
         cd9c0lkmTD+IlTiIRVgobcow6B2cKAXQdlA5xgR3+FLABuZJvV9BmtVvTgHS7JFslZ9B
         Y4EmnTPKjk/nU5Bit4KoeDFbbgt9WvHZykBJL7MXfCMfEUQAUp74JNSQOviYM1aF46pX
         33ajfdDXr1IKdfrMrNvEoHo3vIJREhoGyV+8za5c9d27mHEsPz2wwIcSBShRhiSXS3n8
         qb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717604367; x=1718209167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llUYe07TgtX9pNzx/VwPY9IpXBVRel1c/RAIZQqo230=;
        b=QvTPbB/jRRQ83a5G3Z/sYMbxhuANUAfkuaVx5l1PZvTqcooo10y2Mfx6P+KLkpGxa4
         G4L63Ox3BoiKgwE8eg/r03Y99C944DRZT3zbnBKxhQSdzUntZsCM+HF/upIkNCN8uXF5
         ESEB/VqkGeXFVoSEPJe+xiUSQLWGwTgTTtOCm0X/DJMvHqHqBHukxz9PnzPoUw4cLGdR
         UTucoLJSNRlEauoUC/lIPcNI0h0aAtu2s3Vxh4qGTNXf4ZY095cSixd9R4sSkbeQGqr3
         7UxZVQZhp5DP4GY4+JjRIseGORJPUYX+FRty7repcU/S8YafCmKGNOXuN1/xpLwWnTj4
         c9rA==
X-Forwarded-Encrypted: i=1; AJvYcCUHIUoZX0gHMSTScRM6omWbcOtmCY6E3igez8qDBcRfbvaicmACK7TEBj1PJz+x3pk5wUhcMzW89b4VyE/FnJ60HYtjK9JY
X-Gm-Message-State: AOJu0YyULRz+7rPS8U1SLxQMBYylhgK2CTpgBHByPBtoxAf2+TTQTCxP
	Z76BPFdlgm+uV77V2ReSx54y0N5SPl17x2rNcfnqaBpz9z+ehMqY2HfLj8O5MRBbRgu66dWt3AO
	kFtw=
X-Google-Smtp-Source: AGHT+IFkjbiChh2PdBp/SYXeqU06TNPqJDBpo2O6aFFs/U/ZFf0fOmtdpyi6Q1BXKe8Mh4NG1Wmklg==
X-Received: by 2002:a05:6a00:6908:b0:702:5b22:531f with SMTP id d2e1a72fcca58-703f8625750mr143886b3a.8.1717604366589;
        Wed, 05 Jun 2024 09:19:26 -0700 (PDT)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2f9acsm8758706b3a.209.2024.06.05.09.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:19:26 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1] page_pool: remove WARN_ON() with OR
Date: Wed,  5 Jun 2024 09:19:24 -0700
Message-ID: <20240605161924.3162588-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having an OR in WARN_ON() makes me sad because it's impossible to tell
which condition is true when triggered.

Split a WARN_ON() with an OR in page_pool_disable_direct_recycling().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f4444b4e39e6..3927a0a7fa9a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1027,8 +1027,8 @@ static void page_pool_disable_direct_recycling(struct page_pool *pool)
 	/* To avoid races with recycling and additional barriers make sure
 	 * pool and NAPI are unlinked when NAPI is disabled.
 	 */
-	WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state) ||
-		READ_ONCE(pool->p.napi->list_owner) != -1);
+	WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
+	WARN_ON(READ_ONCE(pool->p.napi->list_owner) != -1);
 
 	WRITE_ONCE(pool->p.napi, NULL);
 }
-- 
2.43.0


