Return-Path: <netdev+bounces-166076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6436A34732
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FBB16BDE6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397871662E9;
	Thu, 13 Feb 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEK2OViQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9526B0BD
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460389; cv=none; b=PWtLdT2SZXDSvQIeKnyagNs3RLI6IQ0aD7uhDX8aBN85wgMXbbU7XJTVhA7tBNM2jSBpQTV/Wv+QlwmTCSrKeigzu6fmkIbJxEEuK51TZQw4ylmCmyKcndbEjfeFtGIPpheMKgyg3QkVshd4pTj5/f+EU2usVh3wLgoS4qVVeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460389; c=relaxed/simple;
	bh=KUxFX+4f0Aizw7Mg85WPdNi8c0DEahMb6LLBmtuIvak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPjPW5P2I67WeB5V4QtDxS/s39vKkykOV1WBjnwKza4vGnHuNneNFeG1zMtsH6kwsmTP7yV+cYqkdLVWLQipKxi4s3uGqzfHoSpSB6MUnZftjA4qe2Km1oGhapYOVMbR+0vx4IGEydgxiguDuMqtbiaU/ETe7/6A4/k7Zfh3V2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEK2OViQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e989edb6so2843755ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460386; x=1740065186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=DEK2OViQIDXz7k9j+atWOlt1aeI2gFEBWB8K4XLI3tqVm1ZMWjkiZw+6cZbFA79GC6
         ioLQH+UfX6/tTxHd0Wm9CAZO+fIzmdBvUzdt7nx21tBqWAJVX/2KkOA83iltn5cC+tZL
         uKQ6SkvWNkQfYAO8MVuMbspoKOGAgU35y6Y2LaTCvO+N/TX0M/L6Bi/rdgf1SwDMIvtV
         uh1yRffTlh+EDFzORRtcmZCO9mh4uGoUFDqA5YFgKXBUQ0eb/YF8tINPDA5BpUH9ZPy/
         lQwESN5mbPbaZuX0apk/uR3R4PA/WzvckyyHTDabwtzWYOmubJzQZ0rDssnqMi6pClKr
         Z7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460386; x=1740065186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=G9+NSLNNyzd+Cg63S3cVCUotfeldYbisn5CrnyrM/shvKaSZfc7EDEEJmmMFxmfZ4k
         EBD9WcPU3qQKa7UF7e1Gt5K29cUdkGZBCxIonqccOBJJlQW69yaH56+EPFCR0HbbwNDz
         0zF1zGtPkkzj0jwlU66KDgpLPkf5nJ32SKHdS/htUi7pSy7ZxgA05ZzD/3llHeFVB+es
         C9JArShCYEy/RWf5/OcyxKp+8Z7ElzVmE81CdRWEvCBGofj7Ts5mdNrWHmcjaN04B9ml
         ZEl1hUjaOb+76ci5j/A/HnicEK56E60H1dK/4ZhFsU/0X42jLvtcExEzEI0i2h0jh1wn
         k8Iw==
X-Gm-Message-State: AOJu0YwDGeTzqAb9i26nDVXawJCW6YoR2/lRzuTTqoeFBgn5Vswz9+/T
	caylHrgB1WeH5HwDvEyIYirFsbA+BeF4MUXSrr4CnszUOKpeeZDY7BHKzO9a
X-Gm-Gg: ASbGncvPWCnwvzKWESI8ERchuCvf+f6o2V3K2hMZL61Shm93E5xZHtRycyBHhnYLnSF
	BIk8uOjEN2QBgkVNESvJrJ6h8GddkQFaIoiNfNvFyevxRnL777TDxhJHTpgp/KKTwW7g0/EpkTj
	5fPtNJiUoys9eiMj30JLroL5SrojLV2UfqYDp/v+58LkTcs8KP1I+N9UocsPi70g7KXewn2AXqj
	tQR15jG1QKxjUo0zUwKK22f5Vb/Q48xRFmnyTeB3/l1SVwFfjZLO25FRJpC8dnNDZSoRX0Anmow
	Pz6cbU5OQm0sZnbJdpF9pILRt80SMCjt+g33Vg==
X-Google-Smtp-Source: AGHT+IFipaKcWyFZaSEDZiGw02DfcykMmnnerthm7WE8jzcwMvin1u67jpRAWSD47lXTNrhIZQXsRQ==
X-Received: by 2002:a05:6a00:399c:b0:724:59e0:5d22 with SMTP id d2e1a72fcca58-7323c1f5ab4mr4699239b3a.20.1739460386123;
        Thu, 13 Feb 2025 07:26:26 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c08:585d:6eb6:f5fb:b572:c7c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425806f3sm1403499b3a.82.2025.02.13.07.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:26:25 -0800 (PST)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH net-next] selftests: net: fix grammar in reuseaddr_ports_exhausted.c log message
Date: Thu, 13 Feb 2025 20:56:11 +0530
Message-ID: <20250213152612.4434-1-pranav.tyagi03@gmail.com>
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


