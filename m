Return-Path: <netdev+bounces-144361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5129C6D2E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21DA28854E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349951FB894;
	Wed, 13 Nov 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjW5Zfr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3C1FCF7C
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495254; cv=none; b=AEdNFTfVskHZZhUPNs3vp0I2MGUKjXh8tHLuG0JQDp/t5lG1fKdp6JG8LB2uU9PTWF9WCzD6kkCUyCOLuVBKZouvp4EIuyqNj5ToDv4UPBtMx1JMYRz3ZdLNb8NgNBFV35RPMk3IM1Y7Q41bLu15ofEDIjbYuL6LhJE4o40me8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495254; c=relaxed/simple;
	bh=CdQ/0MODWdYUSHKXtV+Lt6i2lCsadJ9tnEqCFBcDAUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZxsV0ARqpSp4yBITi8qds1llwnPIB/ZAl2jVPd985HCFoFUMbro4h+Pjzz+gpD7IIWqkDP40yr+ZvaBXHMlX0bAJEuBujAocIjExCP2PdOOBcJEcf6FmdlSveacu2zFQmo+Z4/r6Yk0qD3b+raLiZFdc4mH9AnqLcvoryx6ZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjW5Zfr2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so80071751fa.0
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731495250; x=1732100050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lkg8TlS4djh4c0e38jV9L87u2vEe2wZ1OSOsXyuvnk=;
        b=hjW5Zfr2oEvrxcUqSvFF+VcpVeOz9hQ4j4iSWtLJKcf5+tM4RV9jABT/ty8SyO5Jun
         +BshAxGeBlFaqf12W03xD3wObIW1C9vj8twPPTBhrWspcF5+4G0fGSU/RCOJbSE3mxPR
         GyAomxm6KMH+XwcPsa4T6qG8QmBomh/O9CfBMHslOP1Q0BdWunhJsdajW8P/YCmrejsq
         A2iFHH4NXVsm+puI2O83RBzQZCqhtFsU/F3ucr+7ahQiE4izb2Dx+Aqmsz7lz6K9tczc
         zgoAQDCsoXOd+tDpbDT0cLq2tUMsbbqzRoq64eMlnwRSphF/nspNQXDXsRJ3qqw3vPby
         I97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731495250; x=1732100050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lkg8TlS4djh4c0e38jV9L87u2vEe2wZ1OSOsXyuvnk=;
        b=T/WP8+DzQNzI07cbhA3uFNh1zzHEjp0PgAhiUylS7mylz4WHfBTg/rJwjgK6ZI9Ni2
         lmaRBVsl1xg9GB4M5xXA5U24UaaqgiUWBZ9nCvCxjpHjucuRNgsrGBx1RXBkQWQnb971
         P38FLIuXAm+eYtvUVAmIlxCHHyexgVbnnpMizeAb1Qy/uLtzR2Oest3ufljiyY1orEQd
         7MNAXYY+a9y4Aw5rBcpef2VLkyDdGzq0sfvm0a5wCl1JGy9HRuliViuijQ4ZFICSwjYI
         0dxV0oEfKVWzF3z6NU2T15tyYknJo06Hjbh/boh5w/rViTgmhqkBn45VYVtG0TfNsLGk
         lfOQ==
X-Gm-Message-State: AOJu0YxUxdZ0tAYtFwNvGWy5e98+nC0ZC9nu2Cd6GWj/tlOCSQcNcaQ9
	tztAe7OqKRlsd37agtybftue7u2WBpVjIrOQXaLU2Pbp6vKzWXLn
X-Google-Smtp-Source: AGHT+IE7xdiqp+KVyE58KsKKxfbb+5iy/yGtWN5zlpIpccV2m+JRYvNu3cCQuBD2xKSgUF4QfJ4krQ==
X-Received: by 2002:a05:651c:e12:b0:2ff:4f73:c306 with SMTP id 38308e7fff4ca-2ff4f73c4b4mr8260381fa.35.1731495250222;
        Wed, 13 Nov 2024 02:54:10 -0800 (PST)
Received: from localhost.localdomain ([83.217.201.225])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17991748sm22940511fa.73.2024.11.13.02.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:54:09 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [iproute] lib: names: check calloc return value in db_names_alloc
Date: Wed, 13 Nov 2024 13:53:49 +0300
Message-ID: <20241113105349.29327-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

db_names_load() may crash since it touches the
hash member. Fix it by checking the return value

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 lib/names.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/names.c b/lib/names.c
index cbfa971f..4ecae92b 100644
--- a/lib/names.c
+++ b/lib/names.c
@@ -55,6 +55,10 @@ struct db_names *db_names_alloc(void)
 
 	db->size = MAX_ENTRIES;
 	db->hash = calloc(db->size, sizeof(struct db_entry *));
+	if (!db->hash) {
+		free(db);
+		return NULL;
+	}
 
 	return db;
 }
-- 
2.43.0


