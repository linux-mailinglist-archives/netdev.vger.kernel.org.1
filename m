Return-Path: <netdev+bounces-165649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E56A32EF8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08C83A6874
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64841260A40;
	Wed, 12 Feb 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etVUXp36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FB260A33
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386467; cv=none; b=GzSfRj6CrfOIc+cCf+W0Sl/zwWzKDp0PPlrB3af3UoTER7RjxyzN54Y1OdPPh5wwIxIWveZME/NHQr6qkTavr6GPmoY7xs2MZteDLQMePoQah4rG3o82LOzE4CCDf3Pwoob5v2NM/WPdRhDg5qN3P3ggP6O3cgl38KrH3D3dAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386467; c=relaxed/simple;
	bh=KUxFX+4f0Aizw7Mg85WPdNi8c0DEahMb6LLBmtuIvak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peiiWJHw47c5exislAg4k6QMgH4mGlKU47P5EVGUlF8EF3/gUR5VPG7vARF3Uer878BU6jcnJIsLSOmUi3IjJV3CHTxpw8SBUYttYWQ5q3EfrfS46QOauNURkW59a3m7FAcAW2irxx0IrVV/BnWUfTl1eEtWTPQc0c1ogSsImCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etVUXp36; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so112995ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739386465; x=1739991265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=etVUXp360fdF53C5UJ0yrE6R4nsTsHVNuDJc1qnQyuN54/yID5EZxC8NrXYrBlETI9
         j8jbDJ1R1bpCaKnpYcMBt2BaOx9ODoJ+gYxR18GPInQpGW1Y+BfWd4L73yccHOyAU/ir
         24SuyP/kzDEaun9QiKCzhPjBjPmTiEK2J0SMQva8xeiI72kpnOVkhLOIqBx/Ak+1uA8n
         LK0AgE/bHGULi0wFk5EfpAaTWnGNOj40kz4/gXiCwUWmUMN0lYBDVZrR2QldkHXREuVi
         t21GIzsiiqbp69ffJoQSrBkwv5wABp5o24DHMVuUMt7CE5v98hoDAezvcNL5mNfL7mjG
         pMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739386465; x=1739991265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=aIkHBs3OfTQ6oAbxzrX6/ihyGt65mxvchP7GB1lIQ6exZ0na3M4Za6chrknc/0cPyx
         WTwfrz0wYrORSk8Z0bkgwA9lvCQd/GyOxKUKuLJbxifLt/vUORtB7iQtivgS0HmXPYA/
         i2k82N+q4mn6EE0m7CsEv/24H5wBm0BWA25B7bFKWMklURHL49YPU7G1GEqqr44XkjC4
         vU4jz9vMt397N9B1pKYK/EQ9TKPh0dfw99Svm1mMCEFBuFuPdLgzilj7qTs5i0ij7OIh
         AYpq4bDYAG8Eg3p6aQSqgXq9KjA/8Y7Jdw89TEk+gpna3HCnTGSrGKpWSE2ab7K8+wlK
         lOTA==
X-Gm-Message-State: AOJu0YzSz7d5/WIsc11QHF+npU9dLDmcL2i8IQyRv/CE9FtMBIc++4Ko
	UE5yixvPZ12nPvMNKa9jobZFAhUtEzBix4SXQzP6ZyXOZ71/0ABImSVF4QdR
X-Gm-Gg: ASbGncu2Aos9A91uJNIg58c7pdHGbuccRHtxCu8T3vg32r30WBJbfasb9e0lZaE+4d9
	ewKu2DgWHthpqp5yUKcE26BuxdUl30TZvEOtPZxWfvwEzgCvfZAGOG0EleYFh9tOqa1bgpwDcFf
	PN4bMqIMsDtMT7U3k7ZFFWQU4iIOSGL9tlIOkzfTDt3/klvEIoVzmkGuPaRCLpyPONinhNC4DF/
	bYsf/+vO8I5WVI9TG2hiiPk2wDb1ufGPHpCT4QdGdpQr9426ZwFZblQ5XhRORuzr4lTpvhh8hWT
	qlc3JmDSuQnhYN16GsGdoGfIc0/AqhKxJGersQ==
X-Google-Smtp-Source: AGHT+IGXe/W9685rj5LjzlOaNi5KhdOrLQ3CCIQLai+P+93e2wTzifN3QOHnzLzv/sce7do1q75GNw==
X-Received: by 2002:a05:6a00:10c9:b0:732:23ed:9470 with SMTP id d2e1a72fcca58-7322c418131mr6041484b3a.23.1739386464461;
        Wed, 12 Feb 2025 10:54:24 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c08:585d:6eb6:f5fb:b572:c7c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73086e6636csm6757499b3a.135.2025.02.12.10.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:54:24 -0800 (PST)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH net-next] selftests: net: fix grammar in reuseaddr_ports_exhausted.c log message
Date: Thu, 13 Feb 2025 00:24:12 +0530
Message-ID: <20250212185412.3922-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a grammatical error in a test log message in
reuseaddr_ports_exhausted.c for better clarity as a part of lfx
application tasks

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/net/reuseaddr_ports_exhausted.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
index 066efd30e294..7b9bf8a7bbe1 100644
--- a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
+++ b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
@@ -112,7 +112,7 @@ TEST(reuseaddr_ports_exhausted_reusable_same_euid)
 		ASSERT_NE(-1, fd[0]) TH_LOG("failed to bind.");
 
 		if (opts->reuseport[0] && opts->reuseport[1]) {
-			EXPECT_EQ(-1, fd[1]) TH_LOG("should fail to bind because both sockets succeed to be listened.");
+			EXPECT_EQ(-1, fd[1]) TH_LOG("should fail to bind because both sockets successfully listened.");
 		} else {
 			EXPECT_NE(-1, fd[1]) TH_LOG("should succeed to bind to connect to different destinations.");
 		}
-- 
2.47.1


