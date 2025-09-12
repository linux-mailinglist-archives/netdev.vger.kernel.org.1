Return-Path: <netdev+bounces-222689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A9B5571F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B56E7C494B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3D2BF3CA;
	Fri, 12 Sep 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJoqqZmO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A22BF010
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706838; cv=none; b=i1Ppvyb1bciYGuCT/y8rxh682AJpxid6GlSFbRD1eN4npZqBFzdE1J5maCr43gKINOuipUUTFHMo1RGPJTUdDatSybFdtAh4MOkh2iWqvHtNMiqPmwUh8g9kucvLluO1WjXL7TXVd7YObYYlUgz/ra4riIzt2xdrnZaaHitn+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706838; c=relaxed/simple;
	bh=lhd5AYLmKg8v4K7bBXuozBSRlAkojKZ1+DM9PPiC2jU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SI96+cvJfe9GHFKzXfV2h/6i6dxjc8AeCt4XH48wq3rdujJD5DBpF3AWZrcQsh0aqcBcu8jYFiafzevuVB8JT0EVomX2Chy3JvfBLzUB4noO6HXn3zeBq0vb2Wce+CxVlcfF+6kwOpI1n8cW4owjPLbx5a7AVkMbyf3VTX7cv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJoqqZmO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2718cffdso153265e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706834; x=1758311634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdhvlJqUr3WoGW1dbO0ZFsF3L6hbFYftz4yhGQrniP4=;
        b=GJoqqZmOY7G/4cLlS6yOMlnXof76O2fBigIFhHu2/SXCvFBo/2TJhAkZyIM/E0Alne
         QKgveCCwl9p2lEU+uSADoKujeHBN+awNfdBRu8Lua713K6IElfLgEnlVLyYkIdwOlQpr
         gUu3l4YnccAOt2DkJo52vXBNlnDC7ZwGbsDZ0Zmve0485U0XRd/FwlQFpZpiNKQJN7bH
         5tk2K85F0Ra1lVzXNSUDMnpp6P80gQJaS+sPIQovMdlNtJsL73jVr4Hu+NgOcgkqh355
         8zqgIaWZqc4xEd9HRbBYTdgk6R13takIchQmC2JiouHrH47D8jWmezi5XWb/1lnKnTnB
         UkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706834; x=1758311634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdhvlJqUr3WoGW1dbO0ZFsF3L6hbFYftz4yhGQrniP4=;
        b=NwX3LYbtc4KopqlC1rSaOoqdg/2JS8cdIcRHT/Q8A79s51mtH0sT/njnI1MRiaf2Ap
         KGxUA40+Qk9Oa1s7t7S77QW1ByWXm6bjvFu8QV8N3yVqXckhUXNHd76+EfqF2e2YFUsx
         TKC16drsELUW4hlsFxQFwg8mp8WJogztEAJDNo/edNY2H/095gEjADsDceP84iPyVepf
         1tuq6Vjo0Vj3Zi/xBdfzimmI6vbZPZ7YMsxgDLoHEP/vLBNAyp5U2AwZGovUdAGYC9wv
         jetsrFGbteA7DHdBtygtpMuzNBlwG+Pa1bB1pNyfYuQerUh33qio8A3mn9+23w2qvoSV
         oGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcn7pgwYwY73YZdr49Z2T43GvaFfcRr/oUBFYizSXleQw4OWyCFsiALSyryaLmPtYgohpAn1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXQXspHpedMslNe1uDB3e8AeZwdnKG3iH90JW9tT59niwctUc
	9kVXZEgvBVpY+BAbl2NGaTfrEu7OFji0LgT6VYGSdfOZ3aSNn9ybpOfy3MeNpg==
X-Gm-Gg: ASbGncuJrZ2G7j2N20CaH7juDQKJLOEsuiPaLwDee9l3iBy7e7W+Y9LElTsFsZkW4QX
	eDIb+27wV+pLH8PrRvZQNZFFtMKQoGXgdslz6slazNLcBN9mrIcE0arR29u5+qQxSEgJ6HzlShL
	MXDIRc6ofYeITw1MZVRb2BqdcFVGg/T2wbNyJgXMBLF3m7lnK5utTnAdTcGWOHr5YCm/KqRcOpv
	TpkFM7hr2+8WGhgW7snE25YGRNrJ6QUSvON74RGnOOlJYtYjSoPRBiIRTd7ttRot/s5ry769yAN
	G+hxZngtg+j5dvR5y5qB+kWotd7H7Cyrx655lv7U7Ll/1eM5foFLr3ryPChMvFXp7x4iKOsSWbd
	2ZFNkeU5dC2zh8ACxu917aNUoSGqOvwMh9d6cgaxdtL2D6ARl90pb52EDa8FvYQ==
X-Google-Smtp-Source: AGHT+IFqrA3KZsShkhOTFLrSGP4/PH2y/guZeiY2IMih0gP0HYC7djwhcyI0ThOjanigZ0fIM1AgtA==
X-Received: by 2002:a05:600c:4454:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-45f211e5f98mr44613895e9.22.1757706834189;
        Fri, 12 Sep 2025 12:53:54 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:53:53 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 01/15] genetlink: add sysfs test module for Generic Netlink
Date: Fri, 12 Sep 2025 22:53:24 +0300
Message-Id: <20250912195339.20635-2-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test module that creates sysfs interfaces for Generic Netlink testing:
- /sys/kernel/genl_test with value/message/info attributes
- /sys/kernel/parallel_genl with message attribute
- /sys/kernel/third_genl with message attribute

Implements basic read/write operations with proper error handling and cleanup.
Will be used as foundation for netlink testing infrastructure.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 drivers/net/Kconfig                           |   2 +
 drivers/net/Makefile                          |   2 +
 drivers/net/genetlink/Kconfig                 |   8 +
 drivers/net/genetlink/Makefile                |   3 +
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 288 ++++++++++++++++++
 5 files changed, 303 insertions(+)
 create mode 100644 drivers/net/genetlink/Kconfig
 create mode 100644 drivers/net/genetlink/Makefile
 create mode 100644 drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9e63b8c43f3e..2f5f74185da5 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -631,4 +631,6 @@ config NETDEV_LEGACY_INIT
 	  Drivers that call netdev_boot_setup_check() should select this
 	  symbol, everything else no longer needs it.
 
+source "drivers/net/genetlink/Kconfig"
+
 endif # NETDEVICES
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 6ce076462dbf..934dff748416 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -89,3 +89,5 @@ thunderbolt-net-y += thunderbolt.o
 obj-$(CONFIG_USB4_NET) += thunderbolt-net.o
 obj-$(CONFIG_NETDEVSIM) += netdevsim/
 obj-$(CONFIG_NET_FAILOVER) += net_failover.o
+
+obj-$(CONFIG_NETLINK_TEST) += genetlink/
diff --git a/drivers/net/genetlink/Kconfig b/drivers/net/genetlink/Kconfig
new file mode 100644
index 000000000000..e1fd8da50488
--- /dev/null
+++ b/drivers/net/genetlink/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config NETLINK_TEST
+    tristate "Test module for netlink communication"
+    depends on NET
+    help
+      This module provides testing interface for netlink communication.
+      Used by selftests in tools/testing/selftests/net/.
diff --git a/drivers/net/genetlink/Makefile b/drivers/net/genetlink/Makefile
new file mode 100644
index 000000000000..0336eac4cc28
--- /dev/null
+++ b/drivers/net/genetlink/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_NETLINK_TEST) += net-pf-16-proto-16-family-PARALLEL_GENL.o
diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
new file mode 100644
index 000000000000..c50c0daae392
--- /dev/null
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/kobject.h>
+#include <linux/if_arp.h>
+#include <linux/sysfs.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/netlink.h>
+#include <linux/skbuff.h>
+#include <linux/fs.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <net/sock.h>
+#include <linux/kstrtox.h>
+#include <linux/etherdevice.h>
+#include <net/genetlink.h>
+#include <net/rtnetlink.h>
+#include <linux/notifier.h>
+#include <linux/mutex.h>
+
+MODULE_LICENSE("GPL");
+
+static struct kobject *kobj_genl_test;
+static struct device *dev_genl_test;
+static struct kobject *kobj_parallel_genl;
+static struct kobject *kobj_third_genl;
+
+#define MAX_DATA_LEN 256
+
+struct {
+	char genl_test_message[MAX_DATA_LEN];
+	char genl_test_info[MAX_DATA_LEN];
+	u32 genl_test_value;
+	char parallel_genl_message[MAX_DATA_LEN];
+	char third_genl_message[MAX_DATA_LEN];
+}
+
+sysfs_data = {
+	.genl_test_message = "default",
+	.genl_test_info = "default",
+	.genl_test_value = -20,
+	.parallel_genl_message = "default",
+	.third_genl_message = "default",
+};
+
+static ssize_t show_genl_test_info(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", sysfs_data.genl_test_info);
+}
+
+static ssize_t store_genl_test_info(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	snprintf(sysfs_data.genl_test_info, sizeof(sysfs_data.genl_test_info),
+		 "%.*s", (int)min(count, sizeof(sysfs_data.genl_test_info) - 1),
+		 buf);
+	return count;
+}
+
+static ssize_t show_genl_test_message(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s", sysfs_data.genl_test_message);
+}
+
+static ssize_t store_genl_test_message(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t count)
+{
+	size_t len = min(count, sizeof(sysfs_data.genl_test_message) - 1);
+
+	strncpy(sysfs_data.genl_test_message, buf, len);
+	sysfs_data.genl_test_message[len] = '\0';
+	return count;
+}
+
+static ssize_t show_genl_test_value(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d", sysfs_data.genl_test_value);
+}
+
+static ssize_t store_genl_test_value(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int rt;
+
+	rt = kstrtouint(buf, 0, &sysfs_data.genl_test_value);
+	return count;
+}
+
+static ssize_t show_parallel_genl_message(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	return sprintf(buf, "%s", sysfs_data.parallel_genl_message);
+}
+
+static ssize_t store_parallel_genl_message(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	size_t len = min(count, sizeof(sysfs_data.parallel_genl_message) - 1);
+
+	strncpy(sysfs_data.parallel_genl_message, buf, len);
+	sysfs_data.parallel_genl_message[len] = '\0';
+	return count;
+}
+
+static ssize_t show_third_genl_message(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s", sysfs_data.third_genl_message);
+}
+
+static ssize_t store_third_genl_message(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	size_t len = min(count, sizeof(sysfs_data.third_genl_message) - 1);
+
+	strncpy(sysfs_data.third_genl_message, buf, len);
+	sysfs_data.third_genl_message[len] = '\0';
+	return count;
+}
+
+static struct device_attribute dev_attr_info_genl_test =
+	__ATTR(some_info, 0664, show_genl_test_info, store_genl_test_info);
+
+static struct kobj_attribute my_attr_str_genl_test =
+	__ATTR(message, 0664, show_genl_test_message, store_genl_test_message);
+
+static struct kobj_attribute my_attr_u32_genl_test =
+	__ATTR(value, 0664, show_genl_test_value, store_genl_test_value);
+
+static struct kobj_attribute my_attr_str_parallel_genl =
+	__ATTR(message, 0664, show_parallel_genl_message, store_parallel_genl_message);
+
+static struct kobj_attribute my_attr_str_third_genl =
+	__ATTR(message, 0664, show_third_genl_message, store_third_genl_message);
+
+static int __init init_sysfs_third_genl(void)
+{
+	int ret;
+
+	kobj_third_genl = kobject_create_and_add("third_genl", kernel_kobj);
+
+	if (!kobj_third_genl) {
+		pr_err("%s: Failed to create kobject\n", __func__);
+		return -ENOMEM;
+	}
+
+	ret = sysfs_create_file(kobj_third_genl, &my_attr_str_third_genl.attr);
+	if (ret) {
+		pr_err("%s: Failed to create sysfs file\n", __func__);
+		goto err_sysfs;
+	}
+
+	return 0;
+
+err_sysfs:
+	kobject_put(kobj_third_genl);
+	return ret;
+}
+
+static int __init init_sysfs_parallel_genl(void)
+{
+	int ret;
+
+	kobj_parallel_genl =
+		kobject_create_and_add("parallel_genl", kernel_kobj);
+
+	if (!kobj_parallel_genl) {
+		pr_err("%s: Failed to create kobject\n", __func__);
+		return -ENOMEM;
+	}
+
+	ret = sysfs_create_file(kobj_parallel_genl,
+				&my_attr_str_parallel_genl.attr);
+	if (ret) {
+		pr_err("%s: Failed to create sysfs file\n", __func__);
+		goto err_sysfs;
+	}
+
+	return 0;
+
+err_sysfs:
+	kobject_put(kobj_parallel_genl);
+	return ret;
+}
+
+static int __init init_sysfs_genl_test(void)
+{
+	int ret;
+
+	kobj_genl_test = kobject_create_and_add("genl_test", kernel_kobj);
+	dev_genl_test = kobj_to_dev(kobj_genl_test);
+
+	if (!kobj_genl_test) {
+		pr_err("%s: Failed to create kobject\n", __func__);
+		return -ENOMEM;
+	}
+
+	ret = sysfs_create_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
+	if (ret) {
+		pr_err("%s: Failed to create sysfs file 1\n", __func__);
+		goto err_sysfs;
+	}
+
+	ret = sysfs_create_file(kobj_genl_test, &my_attr_str_genl_test.attr);
+	if (ret) {
+		pr_err("%s: Failed to create sysfs file 2\n", __func__);
+		goto err_sysfs_2;
+	}
+
+	ret = device_create_file(dev_genl_test, &dev_attr_info_genl_test);
+	if (ret) {
+		pr_err("%s: Failed to create device file\n", __func__);
+		goto err_device;
+	};
+
+	return 0;
+
+err_device:
+	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
+err_sysfs_2:
+	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
+err_sysfs:
+	kobject_put(kobj_genl_test);
+	return ret;
+}
+
+static int __init module_netlink_init(void)
+{
+	int ret;
+
+	ret = init_sysfs_genl_test();
+	if (ret)
+		goto err_sysfs;
+
+	ret = init_sysfs_parallel_genl();
+	if (ret)
+		goto err_sysfs;
+
+	ret = init_sysfs_third_genl();
+	if (ret)
+		goto err_sysfs;
+
+	return 0;
+
+err_sysfs:
+	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
+	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
+	device_remove_file(dev_genl_test, &dev_attr_info_genl_test);
+	kobject_put(kobj_genl_test);
+
+	sysfs_remove_file(kobj_parallel_genl, &my_attr_str_parallel_genl.attr);
+	kobject_put(kobj_parallel_genl);
+
+	sysfs_remove_file(kobj_third_genl, &my_attr_str_third_genl.attr);
+	kobject_put(kobj_third_genl);
+	return ret;
+}
+
+static void __exit module_netlink_exit(void)
+{
+	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
+	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
+	device_remove_file(dev_genl_test, &dev_attr_info_genl_test);
+	kobject_put(kobj_genl_test);
+
+	sysfs_remove_file(kobj_parallel_genl, &my_attr_str_parallel_genl.attr);
+	kobject_put(kobj_parallel_genl);
+
+	sysfs_remove_file(kobj_third_genl, &my_attr_str_third_genl.attr);
+	kobject_put(kobj_third_genl);
+	pr_info("%s: Module is exited\n", __func__);
+}
+
+module_init(module_netlink_init);
+module_exit(module_netlink_exit);
-- 
2.34.1


