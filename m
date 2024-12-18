Return-Path: <netdev+bounces-153137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478189F6F75
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 22:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1188A7A263D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2131FCF62;
	Wed, 18 Dec 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Napi8/Zp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055611FBEB6
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734557386; cv=none; b=Jdhfwq8tfVmAIUqXKZDiRsXPTP+DQY3xmQjXe8RrG2ZsT6uylF0FA1zjNBMY3kp7NdntnmTRnLWYs5NIRH21E5iBII2ty8hklugbS/dT2bUgAhjpXtLuJpjgwODxeCmxXkfFb/awvlW6EGCsPBThp1j0moe67Tbn2DTxjvfILJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734557386; c=relaxed/simple;
	bh=8tcZxhWcZygS7/RIPssR7Fug0TVf2r/WdlbveaQ9jm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHvzTpE6y9zVAUFp0lOMpx2BUAM2hHM2CqVBz1dGaGC3LNOXPOEGKDKbsCR7zCtd8rQQZaATq2Sy2WfJcYW707H8MkjVMjx7t9qAb66wP1PpX2QyjVQfVHUfKdSCMJ6XUuVXR4JHd8g/iv2bw5UmORvEQ7iDzl+tW5SsA1zkkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Napi8/Zp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21619108a6bso1005535ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734557384; x=1735162184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt/KivLNHAmnWSoTGp/wlEAy9HXZLD1WAOHB1I7E5r8=;
        b=Napi8/ZpSEFWsNHoQdXPIqMH2DGnTiwDSqlGi+2SF+/QT3bRDQJqr2zRTjSkgQGJWd
         WvsLZAD7RwEynRZ3//+zht50RMro6japUzb9ByzQYeMkC7GM6xCSO3DZPUyp02aPyx7C
         Aw8TTJkDcTKNPkVCo9BImVq0wl7ee597Cnz8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734557384; x=1735162184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt/KivLNHAmnWSoTGp/wlEAy9HXZLD1WAOHB1I7E5r8=;
        b=U+eQu6UfomeZA7nH4pyKhxnNrM4A123YmXnDfGDdbENpAMpNvx8xjjDjlVlcheXObP
         6F8pAmjkk6X70xrnOVCsBWIb9XJeJ5DDIj1P72LihIwhbttRWTOFyB8ICLfjM+oaj6Fy
         Dq04Rs9a53MB49wbnSi2e4kU9E8AfkE/Qb9Tf5sKCttGFF2KaTIarHowWp+ztVA8AjyQ
         jkF1ksOA5usexiUK0ISMn8tGHSy4skQPHy6ce55s7ogn1hgLsd4onbCtjJ/lgfhb9Abd
         3UsWctPcXKPoeq/w+QMOESNlxrO0Bt3si/6IbWja78rOR63cSSiPBx9osgumBpCIVGhn
         /iLA==
X-Forwarded-Encrypted: i=1; AJvYcCVSWRzPx4b4BYZkk8NXQp4QmEHBPyarWzSy/7rf6DI3+lkkqWnzhPniwM9PCt0HY7OftLclTBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQtecIGNgb0sK5KA8y+OF+BmYhwUsCOlDcLo2rDuX/EecwAu6
	bEn8anT9cH7syNCq+DFFNskC8MLN0mjvWs1n8KuXKCiOj6rvdbB5+PQMybcdXA==
X-Gm-Gg: ASbGncsVPnlv0ECfo7Ssp8DLyCXbXQvFYDjCYcI1mxLQxE7NHLObjQSYWjVAFqXfM2o
	sPgFea5VACbDVgEcWckn2ohFScrXPkNo/pf9YXyxaI7Ts+HDP7UDd9JNgLXntUJUrp9kq9wgxRm
	Q9/r0twxTjW5bJaWR/UPcMlD6enYtir4M3X1YUagVyip117jqD5iZ9a7UP123Rxdi7D/ckyFBgu
	vqfhd45Mt8l/GB/n44aYxvRuKjLjWSvbeMLDxfUawDXrANCdOz2chNvEUB+pCZQIapxz3ydFnhI
	2wqRw5l+E43uc9N4hm1S1kZHSPJyNJDmwzNuR6jarN3FQQ==
X-Google-Smtp-Source: AGHT+IH6vrFAj3IOk0b9NS9oSsCUv7IWVvGa6vyL9CDd/qOIIcWgVO6fANyY0NBZxuvfiOjsRm4YAg==
X-Received: by 2002:a17:903:283:b0:215:83e1:99ff with SMTP id d9443c01a7336-219d9649cdamr12749075ad.27.1734557384391;
        Wed, 18 Dec 2024 13:29:44 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (200.23.125.34.bc.googleusercontent.com. [34.125.23.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50455sm80506145ad.159.2024.12.18.13.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 13:29:44 -0800 (PST)
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
Subject: [PATCH v12 1/2] binderfs: add new binder devices to binder_devices
Date: Wed, 18 Dec 2024 13:29:34 -0800
Message-ID: <20241218212935.4162907-2-dualli@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241218212935.4162907-1-dualli@chromium.org>
References: <20241218212935.4162907-1-dualli@chromium.org>
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
Acked-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c          |  5 +++++
 drivers/android/binder_internal.h | 11 +++++++++--
 drivers/android/binderfs.c        |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

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
index f8d6be682f23..e4eb8357989c 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -25,8 +25,7 @@ struct binder_context {
 
 /**
  * struct binder_device - information about a binder device node
- * @hlist:          list of binder devices (only used for devices requested via
- *                  CONFIG_ANDROID_BINDER_DEVICES)
+ * @hlist:          list of binder devices
  * @miscdev:        information about a binder character device node
  * @context:        binder context information
  * @binderfs_inode: This is the inode of the root dentry of the super block
@@ -582,4 +581,12 @@ struct binder_object {
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


