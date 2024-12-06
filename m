Return-Path: <netdev+bounces-149682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBC49E6D40
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6993C2839B8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA321FCFC8;
	Fri,  6 Dec 2024 11:23:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419161D2F74;
	Fri,  6 Dec 2024 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484219; cv=none; b=kBgcNpZYu6wtue5H/sJSZ693YoCtjepbCmhZq0Rurc6GY7a+XZULVZJRBugPk6mZx6gGALOBnh3Svs2Jl5/4o6LjEgi38irYaS+oarjIA1hy/AslrWFAmIMSc4DTmQ/Rs2PQTJ/IXxtzL7+n6NF0zzxuLyXgsgzaSCKKv/4dEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484219; c=relaxed/simple;
	bh=XCd2GkCj5iFxClGU0pgjRZ1y5tlkkQN7mxYMh8vPiWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTjwDMBMBMKUm/6eYZCeZ/OecRoHSS2UDh0k4W8QG5AXR6O1QJlog0q0scQ2Uk7pX9TPeneYgRDvWEPwDrJm5ki+aOM5WweTtTDn1Jvw4sS3HNi7J6F6o2UosaaT8wyKbcd6oenSZvJ+Qp07EsUvECP5VGOH4cteQy+3g3UEqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y4TMQ4m3qz1V5kB;
	Fri,  6 Dec 2024 19:20:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C73B414035E;
	Fri,  6 Dec 2024 19:23:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 19:23:32 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V5 net-next 1/8] debugfs: Add debugfs_create_devm_dir() helper
Date: Fri, 6 Dec 2024 19:16:22 +0800
Message-ID: <20241206111629.3521865-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241206111629.3521865-1-shaojijie@huawei.com>
References: <20241206111629.3521865-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Add debugfs_create_devm_dir() helper

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 fs/debugfs/inode.c      | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 38a9c7eb97e6..f682c4952a27 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -610,6 +610,42 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
+static void debugfs_remove_devm(void *dentry_rwa)
+{
+	struct dentry *dentry = dentry_rwa;
+
+	debugfs_remove(dentry);
+}
+
+/**
+ * debugfs_create_devm_dir - Managed debugfs_create_dir()
+ * @dev: Device that owns the action
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          directory will be created in the root of the debugfs filesystem.
+ * Managed debugfs_create_dir(). dentry will automatically be remove on
+ * driver detach.
+ */
+struct dentry *debugfs_create_devm_dir(struct device *dev, const char *name,
+				       struct dentry *parent)
+{
+	struct dentry *dentry;
+	int ret;
+
+	dentry = debugfs_create_dir(name, parent);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	ret = devm_add_action_or_reset(dev, debugfs_remove_devm, dentry);
+	if (ret)
+		ERR_PTR(ret);
+
+	return dentry;
+}
+EXPORT_SYMBOL_GPL(debugfs_create_devm_dir);
+
 /**
  * debugfs_create_automount - create automount point in the debugfs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 59444b495d49..19d8c322debe 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -139,6 +139,9 @@ void debugfs_create_file_size(const char *name, umode_t mode,
 
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
 
+struct dentry *debugfs_create_devm_dir(struct device *dev, const char *name,
+				       struct dentry *parent);
+
 struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 				      const char *dest);
 
@@ -286,6 +289,13 @@ static inline struct dentry *debugfs_create_dir(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct dentry *debugfs_create_devm_dir(struct device *dev,
+						     const char *name,
+						     struct dentry *parent)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct dentry *debugfs_create_symlink(const char *name,
 						    struct dentry *parent,
 						    const char *dest)
-- 
2.33.0


