Return-Path: <netdev+bounces-168263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B03A3E473
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C603817357D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B440267388;
	Thu, 20 Feb 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EmQo9PuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F5266585
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077786; cv=none; b=Se8qvpeg7x1c7Is/SBqZHvkvVZIKC2+P+wJxF2cb/L19Q699HpwCAoY8FdDuYOA8qiOur1vBQr09+XPO3FUk5z0oZ1KSaDlyE9UbPjYr4e2TwDj1NhtQ0hLgewDw4UBQuFCCvYc9l4Syjtn3J+3yxdohsu3VxHGVnTY8dayXZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077786; c=relaxed/simple;
	bh=4pokzCpm/lUAfMKuosqyIEkYPbh7I36XpLT3BcQvRag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CNgwsHciAhkUEfSm8hldWIIgQX/He+4F1m1g/AHwla0Kw1RYNZx7tFeIOYrAheuU8b7IAzVB9sOGmrvn21VpOkrCudTQxJtPjh+HTSABtfyhjaOYzql6NTbTo7ttKxGnPYVmJ7n9oc8bFbz/ROITDHKvb0tRs304fWGCAUj9r3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EmQo9PuX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221206dbd7eso25880895ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077784; x=1740682584; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WE82c+aiEEEUeKpSOXCYU/WI+Y4+5eTNi2kEnvfIaks=;
        b=EmQo9PuXIak/V3eZp/81+nrMNRvZYjhLMhXsQnRdGJMr2k0PpMfD0wlzOk5KW0I8lV
         jqemdsPa3M2F83mpCZ2EkCyQKaOpiQwuyFkqqIe5tQcAI2I1lD9cu/L7IA/HFmu7ydBo
         TxuWo5khV6fsvbP4K3USLEvTYlsNmmSX4wg0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077784; x=1740682584;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WE82c+aiEEEUeKpSOXCYU/WI+Y4+5eTNi2kEnvfIaks=;
        b=Mu++OV6naBe0nHnIIHO5mNExKwJHubDbRXXy6bumSktNuNYT+HkDOYs9PJn+n7CKT3
         nwOQ2FKdELMJzw36rs/YSXYRmnDhtiY3a0vAE3LVElcMojSgND+aaGljgK6wURGT3wln
         2Be2Q+Vwn8K8U3lMI1c6qLrUr7ADUFe+Q02rFLJrHHqJo3/74+tqZy55d24WViBnOLVA
         CboczcSXJnmHtvdVVZfTJ50x97XTRdQZSyU5CcO8JMDNCDGDdUOPbICHnC/xp5qGKiB8
         WBDl7uYaq1ZSORNsN4Ix+kEXDmP+/S0FjJTWUxKgJEpHMheKsdD5jtXKT4gCivqDNtDf
         3uOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3yxQq9Uz+DBgactzn4kt9HXCVxJTK3Uc+QLU8+dYiZ10JzfVtiwnnymK72SGjxe0+pm4gimc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWkS+oDiF9QUFbmwGW+Uxg8ZDNL8AwsQOxO136mgycB7WDqC0
	uhqMybvKVKs416kPoFs62f5vDJ16mOgLHKd4U19HC1f/0yYtH8U24zHPhogRIw==
X-Gm-Gg: ASbGncvi8rznRvfispFx4mWRYF2bGkalT62dwmYb3sbcfxq93G2K2k1HcIgvIPQkorg
	Y2Hv/HOiS77JakRoxI3HiKVMLlbEpy1jHXpG6ZQh1w+3iW6ONNqwohXCvsXEP4bUJmi7cmbFoD/
	4vUaRmNh4/3fm0dKHPxudOqGn4YB33g1yccZnBVzbta+sEQkx8S4lMnAOD3O/yCqv9vXxX6QlSx
	AUkz5nSw/J6dkRH7/wyfyxTszh9892kxBmF/aTUJCFY0OCithXz0LR2DaAhAqEtSzv01rB7uf9c
	2ZuvT4lDEPWJH0/lkwdkYvrc1sGwbA6f5iNwQ8EU3Rna6eN6He2fKg7z7grmlsU//5AblsQ=
X-Google-Smtp-Source: AGHT+IGEA8WDnrG+ENLZvMkfcpeufwauXW2db4AOLTcqYxDOdLCVeXrL0ymSpYLCNBgTU7qcybsNdw==
X-Received: by 2002:a05:6a20:7f91:b0:1ee:8435:6b69 with SMTP id adf61e73a8af0-1eef3c4908dmr498654637.1.1740077784029;
        Thu, 20 Feb 2025 10:56:24 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.56.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:56:23 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 9/9] RDMA/bnxt_re: Add support for changing the snap dump level
Date: Thu, 20 Feb 2025 10:34:56 -0800
Message-Id: <1740076496-14227-10-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Add support for changing the default debug dump level.

Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  2 ++
 drivers/infiniband/hw/bnxt_re/debugfs.c | 49 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 45601635..45d62f6 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -304,6 +304,8 @@ struct bnxt_re_dev {
 	struct workqueue_struct		*dcb_wq;
 	/* Head to track all QP dump */
 	struct bnxt_re_qdump_head qdump_head;
+	struct dentry                   *tunables;
+	struct dentry                   *snapdump_dbg;
 	u8 snapdump_dbg_lvl;
 	struct dentry                   *cc_config;
 	struct bnxt_re_dbg_cc_config_params *cc_config_params;
diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index af91d16..e3fba53 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -306,6 +306,52 @@ static const struct file_operations bnxt_re_cc_config_ops = {
 	.write = bnxt_re_cc_config_set,
 };
 
+static ssize_t bnxt_re_snapdump_dbg_lvl_set(struct file *filp, const char __user *buffer,
+					    size_t count, loff_t *ppos)
+{
+	struct bnxt_re_dev *rdev = filp->private_data;
+	char buf[16];
+	u32 val;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+
+	buf[count] = '\0';
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+
+	if (val > BNXT_RE_SNAPDUMP_ALL)
+		return -EINVAL;
+
+	rdev->snapdump_dbg_lvl = val;
+
+	return count;
+}
+
+static ssize_t bnxt_re_snapdump_dbg_lvl_get(struct file *filp, char __user *buffer,
+					    size_t usr_buf_len, loff_t *ppos)
+{
+	struct bnxt_re_dev *rdev = filp->private_data;
+	char buf[16];
+	int rc;
+
+	rc = snprintf(buf, sizeof(buf), "%d\n", rdev->snapdump_dbg_lvl);
+	if (rc < 0)
+		return rc;
+
+	return simple_read_from_buffer(buffer, usr_buf_len, ppos, (u8 *)(buf), rc);
+}
+
+static const struct file_operations bnxt_re_snapdump_dbg_lvl = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = bnxt_re_snapdump_dbg_lvl_get,
+	.write = bnxt_re_snapdump_dbg_lvl_set,
+};
+
 void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 {
 	struct pci_dev *pdev = rdev->en_dev->pdev;
@@ -329,6 +375,9 @@ void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 							 rdev->cc_config, tmp_params,
 							 &bnxt_re_cc_config_ops);
 	}
+	rdev->tunables = debugfs_create_dir("tunables", rdev->dbg_root);
+	rdev->snapdump_dbg = debugfs_create_file("snapdump_dbg_lvl", 0400,  rdev->tunables, rdev,
+						 &bnxt_re_snapdump_dbg_lvl);
 }
 
 void bnxt_re_debugfs_rem_pdev(struct bnxt_re_dev *rdev)
-- 
2.5.5


