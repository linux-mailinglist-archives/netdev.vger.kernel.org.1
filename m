Return-Path: <netdev+bounces-151552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B99EFF79
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F9F188B1D8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41191DE4EA;
	Thu, 12 Dec 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mc5sO8/3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF291DE3AC
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043285; cv=none; b=LAiLfCmtxf2xW+Pj73akAfZHkYuFrGeHPPHnKnxgFTRu3fCoZng9akdwo13NuohEUem8o2sobd4ogFKh540rDIt8BpEvmCfvCNBj0CrHt4ZLfjh9euFfh462ciiybZOi2rjVRTJoZO4phtgvXCx/HitXfQhxP4lkVO/eclbYukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043285; c=relaxed/simple;
	bh=QnID2Nngias2laFlMVHINRNQrpY+Vv1z4BU4mytckzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=matSNKjDyaJxSAXVZva04J4XYasPi4sF80vD63hIBGWJYZwQmSg6opp96SuKxzQz/1YYFTFeRmsBmSaaqDTTSdOH5+6jqUe8b+eAJ06f8pOlFh9RZWDSU284o1/AVBYm/CiMneb9yIuqaaRJ4kXJF7Eoakq0/sSXYbA1VQMQbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mc5sO8/3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so10345935ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734043283; x=1734648083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTbCEHQ6hia/KRivi/ryuMVv6+i9eA+M0miy6FoyLNI=;
        b=mc5sO8/3S6Wp08VWV37d0JDfLVG2ESqb4yYByKOyUXCchu6TnKx3FYCHDJNYxn8JMo
         ztUeVaUcnL+gcS/QxnW0mJYhzRJA9OcWJmmZTi9AqV2pSGjLa3fIm5H/4wzJyvKSF+9m
         hyin09IheCPJ4YhK+dcD5AOor90w/DVh1WKcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043283; x=1734648083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTbCEHQ6hia/KRivi/ryuMVv6+i9eA+M0miy6FoyLNI=;
        b=fz3CNDwj6+cz6xUu43wUpbVRRjR59m+jwaPFJQDHJkHPnRthbcO8pqOR/FVIV3IRFX
         JbczLNviuBeLElETNuUbt1tfBCsoX17J07mmyXaQ0KvUyWzTfwEm+QuiN158KPJ62/aa
         qSRb8Wm74dU/uY4S9dTfiQmALYpCGZ75gV7FefFaEEWbMFhgfWcuVQENCNM5I28APrp5
         XJkAvgB3fTq9dcUXJfq+PnbxwO/RoRstijW2dn0XqK95a7oHCiqURU3a/Sx/X7+dJYJW
         3izJBHtDRKTIqKjLwz3mhV/cFLS5XAKhlwgtkW40nHLJitSO5HsUIJhaSq9RGxADc4RY
         PYnw==
X-Forwarded-Encrypted: i=1; AJvYcCXblzbKm64DVGWOYmkQlwWDkRDxhHU7JAcCTp/iZFaTPfoGrJzXQ6LKqQQopWMeLkjXKH3K+fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3B0M1/KQZ4JCyJHx7AZoUSmPDY3P8voyBWG1zNMkBmb+2XjJ
	FmEG5hNgflsFc8QHLbnMnC8DmfFjOzsWZufyT/XMSVBFy9AylcMEjGVIvemZfg==
X-Gm-Gg: ASbGncuJCwty9x1+naIRHjNmuGEnAuZpPUEEiYBTtOBe2EyBb5jDXV6/XbQ6WFWAOtv
	jU8JC5IPrtwbpUb3rhgzKrc8fkI4+c9RcvdOJVSPsMLy+k9QcjmrWXWPAZfsPwk5Zr/QS9GjGE5
	BVbS1dmdSvxzVD/lKwozvPuPhLCs3sJImwx3HCSeJCBwWCqv5O3ViAX8oIZ7NebVULP25VyGRcz
	OaJ5RXhkcFmBHp24rMsQWMWlAvVze/ojEqHJwRPyx2jBGQzRlsyzUt2HlYezducMJ69mKCK7dxg
	dFmtwYEPYMk+SsXehMGhNsLHkLlr9HbKhVJSEqD1Wf5WAA==
X-Google-Smtp-Source: AGHT+IE7mpoXxnTF8cVAExncDjTsgRkgtqF/AwV3t/7KpNuP4yvLpiYHGewaXEWkm9gaAI1GF97u+Q==
X-Received: by 2002:a17:902:f546:b0:216:4fad:35d0 with SMTP id d9443c01a7336-2178c7d5224mr66505915ad.9.1734043283528;
        Thu, 12 Dec 2024 14:41:23 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (200.23.125.34.bc.googleusercontent.com. [34.125.23.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216281f45a2sm98579785ad.250.2024.12.12.14.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:41:23 -0800 (PST)
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
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH net-next v10 1/2] binderfs: add new binder devices to binder_devices
Date: Thu, 12 Dec 2024 14:41:13 -0800
Message-ID: <20241212224114.888373-2-dualli@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241212224114.888373-1-dualli@chromium.org>
References: <20241212224114.888373-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

When binderfs is not enabled, the binder driver parses the kernel
config to create all binder devices. All of the new binder devices
are stored in the list binder_devices.

When binderfs is enabled, the binder driver creates new binder devices
dynamically when userspace applications call BINDER_CTL_ADD ioctl. But
the devices created in this way are not stored in the same list.

This patch fixes that.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c          | 5 +++++
 drivers/android/binder_internal.h | 8 ++++++++
 drivers/android/binderfs.c        | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ef353ca13c35..0a16acd29653 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6928,6 +6928,11 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
 	{} /* terminator */
 };
 
+void binder_add_device(struct binder_device *device)
+{
+	hlist_add_head(&device->hlist, &binder_devices);
+}
+
 static int __init init_binder_device(const char *name)
 {
 	int ret;
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index f8d6be682f23..1f21ad3963b1 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -582,4 +582,12 @@ struct binder_object {
 	};
 };
 
+/**
+ * Add a binder device to binder_devices
+ * @device: the new binder device to add to the global list
+ *
+ * Not reentrant as the list is not protected by any locks
+ */
+void binder_add_device(struct binder_device *device);
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index ad1fa7abc323..bc6bae76ccaf 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -207,6 +207,8 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	fsnotify_create(root->d_inode, dentry);
 	inode_unlock(d_inode(root));
 
+	binder_add_device(device);
+
 	return 0;
 
 err:
-- 
2.47.1.613.gc27f4b7a9f-goog


