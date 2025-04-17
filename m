Return-Path: <netdev+bounces-183557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B392AA91032
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3855A25B2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE291B414A;
	Thu, 17 Apr 2025 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F4zrrPWI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D0145323
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849224; cv=none; b=riaZvprcSotxlp2UrNUJcXwZCLNSXMlz/y/XCuZ2sbnpcUwXfF51du3Kme+pxxskLxOMhDgu24cwE7ux+FoRnd6wUq2HeX9WFRVKdREA0+ydMrtAVcifB1YUuVIKr4J8ydGLs+raaOEY9Ndy/lMHqqHAGfQnn2ZEd+3YO2iUv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849224; c=relaxed/simple;
	bh=VP42e3JZfKvbDI0ooyfOHhztdSFzkob0S0fpP+PH/Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Encxy3XfB/1YUiHSB/ALDjAf5lSu+eqOCko9v2WBCMKV2gS4yokL6vWOkIyhJOpj8emAZMin7/77QVMgnJx0WWgzERU4E+94LUT26GeNCtggoMF4GsHB/sIsDXxXON4Mzftt1yrzFJtt/SiCNmUlo00sMLK199WZTq/hRgDY2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F4zrrPWI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33ac23edso2658785ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744849220; x=1745454020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d1zeenHo/WIdiHzlhPJ54CYp3ToWYLsArkbPVUXbsw=;
        b=F4zrrPWIcguk6SioFjSVXIiXyEy1gtu7ZE2ypRomNPScixTqH2uAXuJ9jTZf87VCmk
         Mh9p5vWCdxKR50xcZujHBmV1mC8RMhGpB6PBuX9zBON0wbo7Oa+J5Rbs2UzVH8zJnS1v
         MhTTbEvU9KnUTXI/4VTdZIJ1DjLslX+pb9z10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849220; x=1745454020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d1zeenHo/WIdiHzlhPJ54CYp3ToWYLsArkbPVUXbsw=;
        b=wVt6e2NYkY9hMuBe2eyGw/64M8RReActBghzetJJutsfumrmI6Di5pwRBzd/SvFTks
         mpyEuj+Q1UTLVIso0golPiwBJ+JvsWV4A4s4rTD5ex4g86wXVXegSSitVc2g+FQBrUuV
         JiJVC3+FfqKUQaU5Noipj6YkHvsA4x6CQp+EKd+pYr9ZqmG9b+8obm6NxmKMNnNCGv9C
         vfGzadrvxTq45aUogMVT8Euo/wGq+hdHzONxaL0mVyHPFL//oQhRXGqdK52+8u6HkpSS
         juEzW+VSmWjhHFSxda89zMwrHJC0tnfO7PRq0Ia76T1IfusUOKPtfTrii8ofRC7seThm
         MdUA==
X-Forwarded-Encrypted: i=1; AJvYcCXWtI6pYztwQpwD9REOoy1QqjHpWowf+cjuv4l5If2K+wwS17yroZMOA+PceFc08juiFjhNcf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdeKfEIPRXEjc8fXUzNF2CVoZ6f38zXDQ/mHTjs0L0OrOdBvFF
	u4RM/qvVxnjprJqsKaStCRq46eVkz+/BVoQQHuJw0Kkkcr132XhvGSS69RANV4gpWQHieoaxLDc
	=
X-Gm-Gg: ASbGnctvZiKhR2IIzv14XKiedfomu/YkxihRbI+0bshdpTWPRILBkDYEYA1zACauNIK
	YSKU5o6Eb5Cl42LIVVul41yCCDp6rPSAihg7n7wpufJnTeQMko0yNtcjNJ2iwISpG/zzKjKiILD
	Aj5nCijCrSySF6hQZZg05l6rxtJgeBYs95bi8e9Kau0Ba5V4uGGo3v/D9nbWiaJ/DRgWvPsoB0d
	Ck66wWNrpTv0ENa/8Ww4hYyKA8ggFCkM3zwGZYDksgPWKqgo6XuHPAkOOjECBMyqB0ChgEi2gwI
	HWhx+95+ZexgBYvFK5ZMNnORh3kp4xP8ZGzjpZWvLX+AIzB5cnGZUxhWXwV08pHrUw4b9NkC6fL
	9eCdYecZMb9XvwKDfoXV9lHxsFiv0f1rC
X-Google-Smtp-Source: AGHT+IFzYIV/9mXR0m0O/AxlmrF16OfOBFQ+0jrJUZKzp7v11JEoGIiIxamuwnoqAODi21WwPq6gSg==
X-Received: by 2002:a17:903:19cf:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22c3591883bmr62046785ad.29.1744849220600;
        Wed, 16 Apr 2025 17:20:20 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd87sm20719205ad.73.2025.04.16.17.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:20:20 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH RESEND v17 3/3] binder: transaction report binder_features flag
Date: Wed, 16 Apr 2025 17:20:04 -0700
Message-ID: <20250417002005.2306284-4-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250417002005.2306284-1-dualli@chromium.org>
References: <20250417002005.2306284-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

Add a flag to binder_features to indicate that the transaction report
feature via generic netlink is available.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 98da8c4eea59..bf9c3becca1e 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -59,6 +59,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool transaction_report;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -76,6 +77,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.transaction_report = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -619,6 +621,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "transaction_report",
+				      &binder_features_fops,
+				      &binder_features.transaction_report);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..39a68078a79b 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		"oneway_spam_detection",
 		"extended_error",
 		"freeze_notification",
+		"transaction_report",
 	};
 
 	change_mountns(_metadata);
-- 
2.49.0.805.g082f7c87e0-goog


