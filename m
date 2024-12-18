Return-Path: <netdev+bounces-153131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFE9F6EF8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464D8188AA8D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AD11FCD08;
	Wed, 18 Dec 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I3P1IsHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1901FC0EE
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734554271; cv=none; b=UHO4ILbletxsQFA58gbsSh2UjDqXWNT3B2EJe49eJ0QFn2hzR/elgNCbBti1dloi20l6M9+LPDXVPp6iItwMUwcRR7aIswlYRVgCXEJYJWuU0qhpGYCYpwWt1jP9hKgJGv7WuY6uWhexS4bMLIn9qQtv3CbQ5QxNQssFzNWM1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734554271; c=relaxed/simple;
	bh=8tcZxhWcZygS7/RIPssR7Fug0TVf2r/WdlbveaQ9jm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LePoQZYUQOAcNopADwhrh7+8wh4uz+Mcqx1kSOHLC+lGCTI1yzyP5Z3TZ8WMpfuXL5KSO8NlhlvwYu90CgMUq1Y65GzEpxbAjY7HbdJ+AcCN0f01UScVUt6bcCcpJAIohOtxUFV/t1F7K+xf93u6SCRHqtkUhzILtBHL5UZWLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I3P1IsHZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-218c80a97caso1050535ad.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734554269; x=1735159069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt/KivLNHAmnWSoTGp/wlEAy9HXZLD1WAOHB1I7E5r8=;
        b=I3P1IsHZ9p7BdnrEGRlqjgDziuDxQH81eNpnymld+85uSyuaIcV41y0nbkEhY7IYI7
         alEs+7a0+melb+VCOhnGB+thW1oFBkvi+3T63NmllGjWF/WxN6cJj3Ef+J95oPfwDJl8
         4fuONHts5jI/00FaWLQ0Heg1/cVqfnAowrESc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734554269; x=1735159069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt/KivLNHAmnWSoTGp/wlEAy9HXZLD1WAOHB1I7E5r8=;
        b=Y1pyME8tamBFbV48m5gdZcY+sUcfEsjboHJUHx3NIRaUC8KQC4dkYaJpYSNaNbaIkV
         3EZO7vKHfSxfFhnVP8PQLxNnq2YeHwWVHzdLpdsC5csLscsbeHds098Oi6D+e1NYXAnc
         6vX+IhaPkDvafiKZ2efyqMlWreBs1lSvNSXKfy+UGc44TNeUX9za30rGVvcxKBehmA9I
         ooBWc0u9GBAwl+OuXzZYg0vZTRLZoZOfo88Xm8d6VA87Z13uFTbRk7cP4nKCIJ+r917D
         HPKcIgt+mWmYdQf5YpleM62sskEu0nhMmVtyKSJvIA/ZaBXir/sSXUFT9iCiwNR0Glwq
         D60A==
X-Forwarded-Encrypted: i=1; AJvYcCV7LVzYZyQXv7O1IVkg8y/J39v/xYBb2Q/mTpat/3d4L6is7UdT7+P8L3WSm0LmkIUjerPYS0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLk24Y5Vtyr0RhRBVDNGvfubadsCrVH/nIgj187VD/pO78RkJk
	PfYqyDE8Jpgbo717HTYwfpA4C46sZ6G7zAwYyh6a8hWShOZFh/drwGlkQy4Teg==
X-Gm-Gg: ASbGncsc7O0tAAp3da0zuMZpjKVGHWZVRs447Ia7l4vlJ1g0Oq6geEb0NYrCCMb5288
	WluWw+ZZVx/4gXKvZ15u14QHoybhqG2AWHpUbySse2GVgiSx/Efz3ujhYoP9cHjHJvC7IjCf4Ny
	mKFCOFj2w8Q3rmfl0kz2A2KevJdlYez/eLue7Bwaj0flLM7IGwjzwQpgEhnYbaSRcOZRH9Sp4CK
	dUyzkEyyNnR6gNwWkdwTOIJzlozjhNJ2mdTpJCPQUhs8V2/3Yi8mBLyZ4P5W5dKa1nE4FfPB3op
	LOfKLw/dSJFwl7r0pPXUXRvlXQrD+4fnxwQwyF29pRnO2w==
X-Google-Smtp-Source: AGHT+IHd0cuOvpW2UMayTES1kmaWVQZ5wSFvdx/0uDKEvf07IwJVL8mS6eaN4I09PyDgZ59Tt+GZLQ==
X-Received: by 2002:a17:903:234d:b0:211:8404:a957 with SMTP id d9443c01a7336-218d7252802mr63558955ad.41.1734554269401;
        Wed, 18 Dec 2024 12:37:49 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (200.23.125.34.bc.googleusercontent.com. [34.125.23.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64672sm79920155ad.216.2024.12.18.12.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 12:37:49 -0800 (PST)
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
Subject: [PATCH v11 1/2] binderfs: add new binder devices to binder_devices
Date: Wed, 18 Dec 2024 12:37:39 -0800
Message-ID: <20241218203740.4081865-2-dualli@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241218203740.4081865-1-dualli@chromium.org>
References: <20241218203740.4081865-1-dualli@chromium.org>
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


