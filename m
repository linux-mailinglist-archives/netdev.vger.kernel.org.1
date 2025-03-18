Return-Path: <netdev+bounces-175801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74957A67802
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19CB3BA4A3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9620F087;
	Tue, 18 Mar 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GzJDFQQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FC20F080
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312202; cv=none; b=AvYsWJf5x7IV0CbX8q7U1mSVfbJYzmlX7w6obKT7I7dneScqAmMqhYuk5mm/+mcPi77pD9eJYG1EN0z7uYw4xps7INVhKtrjcgkIYYBCDiFdIDGYeu8PqKMCEstXb7UJlrOJC5DkvSPKReK7yohpj+rHkh39TS4EqjSKIlBmCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312202; c=relaxed/simple;
	bh=7ymDDFxx34gx35rocJ+N5kMEVcblCf9p5CMo54B2U80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaj6dcFsEAoCS4Trfd8UuWdwjVfghzYmeOyuWZ0elmFk8okKDzb0ZNtje//DHKMTwq7JrBIKnQJ/VkHzGUP0hktZ2zYPteFSOvdOptcAD+5QtI//9ehIJ8cRBTY82zwW2xuUm2G+Z3sQKa7k0BYXfAHlu99DeZQJkx98jQ2D/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GzJDFQQ3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so35614055e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742312198; x=1742916998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyb1qp9YAp8Vcuqhs/UTA4yMykiwjQ9hNBOz2naJw2U=;
        b=GzJDFQQ30ixR37hnQEQ1eS4ch/50cVuVdsuIuusC3AxCuvueFGYWvKL6CU4NoI8zpg
         AVodlxiUYZb+FawYODocsX2XtnamvpPgZZidxKUGS9JH1ZQqunNvNphDnPo9nju2GTGN
         FNGJJkT+He5QByTJC1cn4kh3b6t25i7Cfvc352ig882JEwULSFfzEz9vQ7FErW+Xgy7i
         GeRda5Zk2U6LWQl597u7mZoVRJOECAxKh7NYrDOifNyBW/o/pGG0gRXFxpaLNE/gcbby
         UbeGPsAxkycOBhXAUQLlMEKYkMIGbVFzno4bE9sWPi4VRHt4SSwvhu+rLf1yx/OyxHga
         8yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312198; x=1742916998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyb1qp9YAp8Vcuqhs/UTA4yMykiwjQ9hNBOz2naJw2U=;
        b=j41C3/ZWf2EwEqBac4113+dd4CWdI9v5kp67PrBHUmzvinE95OjRu8oeC6uC4pMtct
         aY3JHX1HDd3mPiDN0zyGSiNRInrMP9hHOA19LG3MXqY/C+dncWfiSZFbFHBAC/7eLFSF
         1umJ55TmgJBaazU4etCz35MOgycNGNBF4NtDt6cshpMpIdlMPL9h8Thb9jADHS9IstaX
         Oe6dV0NYPLsfvjhMfjapZN46rPk8tw+OHJKuuOgsHpoCI7yFfvdzmNxIQLy5aq4zcJzx
         G55PSLnt2g2lnEpzBrx8xMGLP+eLqyVgazXID9v3g9Tt6qWrqT8FS14jsviAS/gs6Cu8
         O7wg==
X-Gm-Message-State: AOJu0YzHsb9paYj8Nm37uWPo9Ez42TxTkFV0Rvyv7qH+5AB35q2mq+b9
	RaMQgwZ55nHlvms/K1zX2nnx0vEolQEAl117tusG/4Qal+NCxRvz5jH/1ubOKPj0NYzS+G06XkQ
	j
X-Gm-Gg: ASbGncvR7WUCyHdVTwRqmgt8csxY57rn7oXEMoMtEJ1m3ULCok6hh/h46taYUpQM7Xk
	G8sYZOEg63vpsSsjq3hofWVr+4UitnWPM+m5ALxjeJ7bxvhxulilcsxkdeNUbsDHci124zmj1kA
	MA3Cdq7+ACEfecIuZALvdjKyn6zUoaPsd/NFpIHs33yF/4AgbJT9XCUM3NZWVB0CspItS8K0Atj
	X+Hcp2ru9Dp2kBEutOxuv+wQ0ll5u/BSfINPcaoJ7hmQ5Epaf5DEzj7GBWr0r1wSDRhQBq0Zfxs
	6GWmLq5QT9gTbbiUBNL5z2tKPlrWnqFV6UydtMurMJHQQC2p
X-Google-Smtp-Source: AGHT+IGcnSItZQd+6FisW0GV3iQhp54/kcszXeTE186KEKzazJuLoncasKd8qhKyBILmiJYYoClL8A==
X-Received: by 2002:a05:600c:1da6:b0:43d:b51:46fb with SMTP id 5b1f17b1804b1-43d3b950d25mr28262965e9.2.1742312198584;
        Tue, 18 Mar 2025 08:36:38 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe294b5sm138391765e9.21.2025.03.18.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:36:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	parav@nvidia.com
Subject: [PATCH net-next 2/4] net/mlx5: Expose serial numbers in devlink info
Date: Tue, 18 Mar 2025 16:36:25 +0100
Message-ID: <20250318153627.95030-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318153627.95030-1-jiri@resnulli.us>
References: <20250318153627.95030-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Devlink info allows to expose serial number and board serial number
Get the values from PCI VPD and expose it.

$ devlink dev info
pci/0000:08:00.0:
  driver mlx5_core
  serial_number e4397f872caeed218000846daa7d2f49
  board.serial_number MT2314XZ00YA
  versions:
      fixed:
        fw.psid MT_0000000894
      running:
        fw.version 28.41.1000
        fw 28.41.1000
      stored:
        fw.version 28.41.1000
        fw 28.41.1000
auxiliary/mlx5_core.eth.0:
  driver mlx5_core.eth
pci/0000:08:00.1:
  driver mlx5_core
  serial_number e4397f872caeed218000846daa7d2f49
  board.serial_number MT2314XZ00YA
  versions:
      fixed:
        fw.psid MT_0000000894
      running:
        fw.version 28.41.1000
        fw 28.41.1000
      stored:
        fw.version 28.41.1000
        fw 28.41.1000
auxiliary/mlx5_core.eth.1:
  driver mlx5_core.eth

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 73cd74644378..be0ae26d1582 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -35,6 +35,51 @@ static u16 mlx5_fw_ver_subminor(u32 version)
 	return version & 0xffff;
 }
 
+static int mlx5_devlink_serial_numbers_put(struct mlx5_core_dev *dev,
+					   struct devlink_info_req *req,
+					   struct netlink_ext_ack *extack)
+{
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	char *str, *end;
+	u8 *vpd_data;
+	int start;
+	int err;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data))
+		return 0;
+
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+					     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
+	if (start >= 0) {
+		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+		if (!str) {
+			err = -ENOMEM;
+			goto end;
+		}
+		end = strchrnul(str, ' ');
+		*end = '\0';
+		err = devlink_info_board_serial_number_put(req, str);
+		kfree(str);
+	}
+
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
+	if (start >= 0) {
+		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+		if (!str) {
+			err = -ENOMEM;
+			goto end;
+		}
+		err = devlink_info_serial_number_put(req, str);
+		kfree(str);
+	}
+
+end:
+	kfree(vpd_data);
+	return err;
+}
+
 #define DEVLINK_FW_STRING_LEN 32
 
 static int
@@ -49,6 +94,10 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (!mlx5_core_is_pf(dev))
 		return 0;
 
+	err = mlx5_devlink_serial_numbers_put(dev, req, extack);
+	if (err)
+		return err;
+
 	err = devlink_info_version_fixed_put(req, "fw.psid", dev->board_id);
 	if (err)
 		return err;
-- 
2.48.1


