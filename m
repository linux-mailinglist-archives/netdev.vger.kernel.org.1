Return-Path: <netdev+bounces-247417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6729CCFB232
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23D2B3057093
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5F34B435;
	Tue,  6 Jan 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwe4Tu9b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300334B420
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719970; cv=none; b=T95RFFMry4s89VYwRKZ6Esz3xHnVh4jgM1WMBcRslmpEwZppZStMJ/F2IaLUvoMhwSbo1CCf9+dr3CkrupqG5baHAKdsu0dP8Dqy1ywQJCUzZ0HZ3bqJD3IJy9Fa7tqaY9Q5KU6HtacZxmwVOYG+6VNqME4tO3bTO1rLqjDk/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719970; c=relaxed/simple;
	bh=XCtkft8bohaeimnq+lp2cMogo+aH8B2GI3J6/21tYXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvnH1w9pP3gZHiE/Z47ghfX9tBCDX4rqejgV7DMXdfaiYIPSQGVdeXjb5tfUhNRvdGLes4aoH+T4qu3mdpxiwj8ezrdj/X8Vn1EtREoVpAp/Yz5e3KoTRS7BHc4L3K40iaJYNvBb4GxaiHMT4Jceos6hmOXHXoXv18ypxh7P8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwe4Tu9b; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aab7623f42so1229245b3a.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767719968; x=1768324768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+OyAyzrGoNWAXYfPY2DX52zu0b6XYq9idfXYiJBSBM=;
        b=Pwe4Tu9b0OaLmgLmvZmaVKTP0GmkRSi2lgsvI92d9NCFsr2H7z5Q+T6Oy28n24qt43
         xsxW3qoSb0kUbT8oxK4rXLWgk9L+HdARJ8ddjxiUFv8ilBF29NYLgKlbX3kHDaiZpQ+e
         jM3g+03FP4bC3FYW5IZgHzkLztw5t5OCWgw4L66hF3huiCI9pq2ZuwqSemhdCpX9wLdU
         g1CWdjFmpqOcNFFMmNXalXkF7t+1Vb5Ul5K7sgFrsyjZ2zrqfQNEoRoCuUQJI0Ks5Qzk
         IKlk5OR/vVeQ46/7IGrqQ/WOU/4OQwz9z3sH7tVX4Fidfk9cwr+pEJppDGJ7byI5E+Xx
         njpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719968; x=1768324768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+OyAyzrGoNWAXYfPY2DX52zu0b6XYq9idfXYiJBSBM=;
        b=GwoEAnh3WrxrFuom3mg07PEHS57nOG4EmuOdLcZynKYGo+5D1OPkR1tuakP89BG5SH
         g4h14uCy8FHalCIHRxjGZfKjOwe6WSBMyCjVYSa6WWJQj8nOdu5KqRUFqjpk+pKBPlQY
         KkKJRJKW5hcYYhAD4QCIJ5+/IWoweyBBFvwqYhfLehrCyfS4zRUnJ3H88kFE32qjgcWI
         bp2xA5aGOS5Ej3LpNL54iNMMWTzDovnkVM5N9/Y/2ZbuT1HI4h9sPD4IILJvKvjUWOFA
         LN9nTOT9A6ARCu9LC3SELNvWUZvgJqtRZJ2X4gaOf5ZcY3RMNPWdfDa9eqc3Q0C89dTC
         EZdg==
X-Forwarded-Encrypted: i=1; AJvYcCUL+PRELl7qC1E7HHqRWcxHTGyhlwNTIcJQ4KpjYZJ+RGtOHIuFHCaYP+7eWw6M1WQmZtjMFyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRna6uSUEoPuJMyFrDLfRu3Kk5Cd6QW/sUuiXR89sqmyOJsrU1
	UslOly0xgsh6whyaGSnGtUmkMzo1FHyMFdv7noY+BOUrGVuV4NVhEN9g
X-Gm-Gg: AY/fxX51VLRfYgrkkyBnalMLn2hLpy0wzr2spJCp5i85cpOzPAlcjr/SGDZly0DpKRC
	a+9TF1mh6Ar+OLVkagAdo5FMklAXJsWnx9j9/rC9GTLww5ob76xDi3THUvdoE43PxWoOX/uU6ZA
	pMoe7hXj0D42rqpG84TSE4IqOXHCQoeBEeSTNQ6IQF2gqSc8tm5Yk0HI9W72l6ef6SXs+zhMOuk
	EpbwaiJebMqQrCdf6KHBKYr/6u1GhMXFAhrsnpoK+UnHPCHFCZfrxqpuRSmc2alvjmbIzeNzKj7
	89eiKfzWLACEEH+Uk8xim57C1oczFbIrdnyHMpJINX5e9axUSYdXkSsDV5F2zcFi7UKMWjkvwqI
	6q9a1xH4igyfkLazDvxyeMF5iXB8KtoDPQtUUyH3S5y0d2w6ybYTCSrk0QwJ7QOBYeOEos7qIm3
	7yATdSlZa5f4Vg9RCfwxqP0YhHRHTc54K8phyvm0K+hQ==
X-Google-Smtp-Source: AGHT+IGYSvTn1Ci9vinRdw7r0xeSkSd2eacLOLCfjsA7K6i+z4Vc1na+KoVQcKiKdfAdirkFse65rg==
X-Received: by 2002:a05:6a20:9183:b0:363:e391:38a2 with SMTP id adf61e73a8af0-389823a7fa6mr3325497637.46.1767719968136;
        Tue, 06 Jan 2026 09:19:28 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:8838:65fe:636c:fbb8:d9e1:61f2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2875157a12.10.2026.01.06.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:19:27 -0800 (PST)
Received: (nullmailer pid 124163 invoked by uid 1000);
	Tue, 06 Jan 2026 17:16:29 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: alex.aring@gmail.com, horms@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH v2 net-next] net: 6lowpan: replace sprintf() with scnprintf() in debugfs
Date: Tue,  6 Jan 2026 17:16:11 +0000
Message-ID: <20260106171610.124138-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprintf() does not perform bounds checking on the destination buffer.
Replace it with scnprintf() to ensure the write stays within bounds.

No functional change intended.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
v2:
 - Updated commit message wording
 - Targeted the patch to net-next
---
 net/6lowpan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 600b9563bfc5..d45ace484143 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -173,7 +173,7 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 	if (WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE))
 		return;
 
-	sprintf(buf, "%d", id);
+	scnprintf(buf, sizeof(buf), "%d", id);
 
 	root = debugfs_create_dir(buf, ctx);
 
-- 
2.51.0


