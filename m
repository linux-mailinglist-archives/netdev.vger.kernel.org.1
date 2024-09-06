Return-Path: <netdev+bounces-126065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BC396FD5C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0861CB252FC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDF15B11F;
	Fri,  6 Sep 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXTR9ZSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B815AAC1;
	Fri,  6 Sep 2024 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658221; cv=none; b=H2dOb3mOK2w1ZUNPgUVaPbbFTZiyJsryW/DUy8WkBCKVsAHe1eCtMm3B6U6LCJyayjL0rp6xvy6HaI2wmKO56M8shlMZuvZu8TnZ3jd+P64G8fyojVTsA4Rh7d7YFionVCIOuMG2zmagwMmhDXt2fG6BuUjfbPh3hBWdyUws6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658221; c=relaxed/simple;
	bh=OQW6FWTTeP/odGH5xBbHF6QQMouh1FibutawAbL3TQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9AxCwV3YKzN9m94EyJ1XIZiJmgDkW5D0uRVlJR5gT/Z0Lvfrg5oiqRRIt06nvs1gP5nkmWVPlos+NuXYu4u6bEPWv3FeYHFxyr1Sg2PFfJyDa1DzI/n0HJRMnHXbTZchRiZX0oiWgS7UzRaRuNy3pQ1xE85Lpht79o1WQw9vJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXTR9ZSv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so23594425ad.0;
        Fri, 06 Sep 2024 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725658219; x=1726263019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+RDbmLG5ftR+4D9+bzNx00wKA7Lfj8/VBn2Mhtp0TI=;
        b=kXTR9ZSvEiZYoXQ06OEoM98uBnkPb+Uj5mqZ341UGdaX6+4CiD+f7b4c0REB8JKDw0
         uwbE+vu+Y2Ei7lbptpeHStp9apcuz8pNeYKkMzUcDnXbVAredg2ht+hT2xder75FzVKq
         Fg7+u5rERueZHeuyl6NOEczyY5wVfXodBDoIY98nSqPiIAYMYCitx5sZDxAmkUKrTkIP
         mLed14XGMFVwp5JzcGFU7xYGx6lLqmYoPBa5QhIWixwT9BkfWIonAy6J7uKez0GEFDfX
         gn0t6PRjgEz7YI1be3NS0SDO+4IL5Y7zuuQhmU/+rotuqxhb5GqyeWAjtytEvxqz5b+z
         Vckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658219; x=1726263019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+RDbmLG5ftR+4D9+bzNx00wKA7Lfj8/VBn2Mhtp0TI=;
        b=Utx1HcF7i9UqpvfBY1PZSRBokfwnXFhtXOmLhT4AqSfEuTB3tBIo2G7+vXgGY4JDtu
         KzvfkGX7MnbeoXpctLPuCW9mecMqqqeQqR4Jrlcw/GKvd6JswLNIo2oC/XfVf97tXCyV
         Fp2PJWTKC1Dz7jGTBE+o+FG6lIVVr7A/RepO53wgdNvsdaMKTqloEyDjlLwOaz1AFstV
         m+Yy1f0sWq1rwhnMA/Oza36MladLeQztaERj9igRyGnlqLzth5rRoi/xiuJMNm+EXbYT
         WVXS1HMNtCs9MCeL0PEekNhXpieXzeperMYjIwdAtmK0pGdsTIksOKC1tu3mL8jLvwzx
         H7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIMseWm3W9sRTUOWb1RjcKZyP5e9kmXwib5L4SoZS99MKYEXiOPbR020NUdLeGMdPk57aRHCs4pD/WFA4D5VjQdFmYNBBE@vger.kernel.org, AJvYcCWXedVLhrWapBcCkGZfna6jzec6zs1gAmsSE5ANnzSNAm47ZtTG1tf6coabiklQzwGeC+EY3+ukxKI7pk4=@vger.kernel.org, AJvYcCX/RljKTctrRDkqqTuH6uET6tz3j9BhCusTLQjKysmwFBF0HDUIzheMfO7wCbY8j7WFFAqbzK5x@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKx85CEEb8NaKrloSgtOAuXohI5vNI7foABChhAhxy5hr3EOQ
	ml5oULsj041EPpKDWZJ4mjn2KxZVkXeuoiDBrIbkvvOveu15Gd1ELU68mxm4
X-Google-Smtp-Source: AGHT+IGM3JZ+Lev8wxl9T4KEhEMpWi8iBiesB0op2Ql7krI1fjunce8/lAR3UJf1Cl6z4rgpt8lV0A==
X-Received: by 2002:a17:903:41c9:b0:202:2cd5:2095 with SMTP id d9443c01a7336-206f04f6845mr41217845ad.18.1725658219131;
        Fri, 06 Sep 2024 14:30:19 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67bd1sm47081065ad.247.2024.09.06.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:30:18 -0700 (PDT)
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
Subject: [PATCH v4 3/6] selftest/landlock: Add signal_scoping_threads test
Date: Fri,  6 Sep 2024 15:30:05 -0600
Message-Id: <c15e9eafbb2da1210e46ba8db7b8907f5ea11009.1725657728.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725657727.git.fahimitahera@gmail.com>
References: <cover.1725657727.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch expands the signal scoping tests with pthread_kill(3) It
tests if an scoped thread can send signal to a process in the same
scoped domain, or a non-sandboxed thread.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
V4:
* Code improvement, and removing sleep(3) from threads.
* Commit improvement.
---
 .../selftests/landlock/scoped_signal_test.c   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 8df027e22324..c71fb83b7147 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
+#include <pthread.h>
 #include <signal.h>
 #include <sys/prctl.h>
 #include <sys/types.h>
@@ -222,4 +223,50 @@ TEST_F(scoped_domains, check_access_signal)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+static int thread_pipe[2];
+
+enum thread_return {
+	THREAD_INVALID = 0,
+	THREAD_SUCCESS = 1,
+	THREAD_ERROR = 2,
+};
+
+void *thread_func(void *arg)
+{
+	char buf;
+
+	if (read(thread_pipe[0], &buf, 1) != 1)
+		return (void *)THREAD_ERROR;
+
+	return (void *)THREAD_SUCCESS;
+}
+
+TEST(signal_scoping_threads)
+{
+	pthread_t no_sandbox_thread, scoped_thread;
+	enum thread_return ret = THREAD_INVALID;
+
+	ASSERT_EQ(0, pipe2(thread_pipe, O_CLOEXEC));
+
+	ASSERT_EQ(0,
+		  pthread_create(&no_sandbox_thread, NULL, thread_func, NULL));
+	/* Restrict the domain after creating the first thread. */
+	create_scoped_domain(_metadata, LANDLOCK_SCOPED_SIGNAL);
+
+	ASSERT_EQ(EPERM, pthread_kill(no_sandbox_thread, 0));
+	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
+
+	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));
+	ASSERT_EQ(0, pthread_kill(scoped_thread, 0));
+	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
+
+	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
+	EXPECT_EQ(THREAD_SUCCESS, ret);
+	EXPECT_EQ(0, pthread_join(scoped_thread, (void **)&ret));
+	EXPECT_EQ(THREAD_SUCCESS, ret);
+
+	EXPECT_EQ(0, close(thread_pipe[0]));
+	EXPECT_EQ(0, close(thread_pipe[1]));
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1


