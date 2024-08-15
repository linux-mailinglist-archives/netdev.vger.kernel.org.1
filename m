Return-Path: <netdev+bounces-118950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C31E953A1B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7023B24802
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD71547FF;
	Thu, 15 Aug 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRdpsfQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57E153837;
	Thu, 15 Aug 2024 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746588; cv=none; b=nop6MOv/NrSwqalaP0ROEsDrO6TXSsDphEB8Hv5w4vTm4V4D88DpQFxlLwLeETmNJhAvHAA+fl9qMqTkTLEW5pvd1AWxTAyuXJkCo6f7weklS7TaXUR9YKXzGn/5FX8UfdhApDjtTdk+5bh9Tr3LDuCJaI8V9ouRTEZeDZimzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746588; c=relaxed/simple;
	bh=qnk7k4HDDGkZoFSO8IpFZuu5vCiPAJLRX3jzzWccaYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OM9BpKZjQN29E4xLluQ1XHFlyruWj5DZ6/XGp7wA4/tfnETtQdHMNnopBs0QfvIDVDVJJ+DU6tgsqo5ASiEPuL0gt30CUKVn+Dj2B0YJNB0dZO5hyMOGC3yDvS9TSqeOC9m4jksrQsXoU4UQrLgTiEdRzoP7KAKX/nUWh7d2zFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRdpsfQ9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710ec581999so1070737b3a.2;
        Thu, 15 Aug 2024 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723746586; x=1724351386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB8A2+Y35t17lg44SzaxZqI5HJVqbqkWh0aRgxli2G0=;
        b=HRdpsfQ9dSnLirq0xkm3WAH7qoG7o7qBVBLrzqEzSKnZHQeFc9xK1nwYqIfSdC/5F4
         uV/YiRNbNWkqPYkOBrIlhPN9QiI8SwPsz9CqytAJhHJOeYAD8Ff4QUt+xKEoG7rBhJ7N
         ijZ+kW2s9OTVQGRBv33Vw+6gdz7nV4JLs40aNWuoLMSCmv2jOJoLq7b9OFMt2hB8Vp1M
         I0jwQRpd58Dt7vwXp1vwrGEJ0tcOKU08wkrYyTjWZpkWkB11xL/7rbRrAwDeGwfXFxEp
         JSxPdidkJNPyYH6abQ3AmRggoRUSqnkKH/hiQE3dBKOmwHOdfvyevG//TGQkX4mjkmBF
         M2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746586; x=1724351386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB8A2+Y35t17lg44SzaxZqI5HJVqbqkWh0aRgxli2G0=;
        b=ZQUiIP5mbc3zV3B8cXqDwu6os0FQvOjnc32SiodyUl9+J96h3RIUibmAv6QiU/Gr0G
         BSD1uDaLusMKaSFMMgJKcxEu6BIkw07UuILh8xPn8afoTNBOvRUPPlZsOdtOuwzm64GK
         cvreLGmyEbUvGoTVuUo9Uwx2e8rQfVI/InDDiCi5/bIa1rCzpo4ATmznUvx1/amQpmCb
         NyH4aobE8qPGN33Ihw3Z9vy1I675/mZVrCJ5PtEOc9WVxJY6QBw39EmQWx01Y7wCRXYT
         VGq2y67spXOaj6b1JeonpJwp/pj8GYVFHn5VsBWsC2oFKm/f5TIHe9BTHop9SxOlCH0m
         OcAw==
X-Forwarded-Encrypted: i=1; AJvYcCWogZFFqjjw2PQdTx6OFkkeS7rcQc8n6gz9oJ7TO8KcfuHL3OopjwmSkgvDD+uXfzGkj2Hns1rKdWJOwAFbEbcJjdgVfe4HaiCPlGzxXYpBY9vk+i16sKOwOB/r+ezgHrhu5HS1KQr01Nop71WbiKr6U5c7RKXDKHd2hc/x6bQ+D282hGni+xKBh4ix
X-Gm-Message-State: AOJu0YwjA2XI5aSg8LfzQxr2cH3sPcUX/A5YBod+DPTQi/NOgqqcuQtk
	9taNgqaZbFxQdHyWMye9D5mtHiZbvNoOmGmAIeuWTv6D0nEHaphI
X-Google-Smtp-Source: AGHT+IHhUcnSE4tNQTfofPuCwTWx0qmX/19gly0HrhSf4hLYSpIm3FPQoVdv6nfNh3SJzMM92aglkw==
X-Received: by 2002:a05:6a00:2192:b0:70e:a6b5:d80d with SMTP id d2e1a72fcca58-713c4f34736mr806264b3a.26.1723746585898;
        Thu, 15 Aug 2024 11:29:45 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356c76sm1431683a12.62.2024.08.15.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:29:45 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: outreachy@lists.linux.dev
Cc: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	netdev@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v3 4/6] selftest/Landlock: pthread_kill(3) tests
Date: Thu, 15 Aug 2024 12:29:23 -0600
Message-Id: <f9ddc707873b30f440779feb1f284fc2a4aae40b.1723680305.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723680305.git.fahimitahera@gmail.com>
References: <cover.1723680305.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch expands the signal scoping tests with pthread_kill(3)
It tests if an scoped thread can send signal to a process in
the same scoped domain, or a non-sandboxed thread.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 .../selftests/landlock/scoped_signal_test.c   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 92958c6266ca..2edba1e6cd82 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
+#include <pthread.h>
 #include <signal.h>
 #include <sys/prctl.h>
 #include <sys/types.h>
@@ -18,6 +19,7 @@
 
 #include "common.h"
 
+#define DEFAULT_THREAD_RUNTIME 0.001
 static sig_atomic_t signaled;
 
 static void create_signal_domain(struct __test_metadata *const _metadata)
@@ -299,4 +301,31 @@ TEST_F(signal_scoping, test_signal)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+static void *thread_func(void *arg)
+{
+	sleep(DEFAULT_THREAD_RUNTIME);
+	return NULL;
+}
+
+TEST(signal_scoping_threads)
+{
+	pthread_t no_sandbox_thread, scoped_thread;
+	int err;
+
+	ASSERT_EQ(0,
+		  pthread_create(&no_sandbox_thread, NULL, thread_func, NULL));
+	create_signal_domain(_metadata);
+	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));
+
+	/* Send signal to threads */
+	err = pthread_kill(no_sandbox_thread, 0);
+	ASSERT_EQ(EPERM, err);
+
+	err = pthread_kill(scoped_thread, 0);
+	ASSERT_EQ(0, err);
+
+	ASSERT_EQ(0, pthread_join(scoped_thread, NULL));
+	ASSERT_EQ(0, pthread_join(no_sandbox_thread, NULL));
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1


