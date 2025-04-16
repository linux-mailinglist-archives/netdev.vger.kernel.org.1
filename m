Return-Path: <netdev+bounces-183692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC370A918FA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8BB460866
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6018A22D4D0;
	Thu, 17 Apr 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GrSKXIBV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9D22B5B5
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884859; cv=none; b=PhpKVSysgF4pk/fBhWzIRt2wjFNMMYGpOYprJzvNRmGWOkDBL+bAJ/MJLgMHXTAIJaZ91WVih/Nf6ZvvEv6Eh/UmPJ85Mw9gqi4gcu7+0/CfMTCtdSei++ZVHw9KmhWnuEGQHlrxBEzQnVXfOmkr5Ji4gr5Lc4/pyZE8jcWHUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884859; c=relaxed/simple;
	bh=yuBKB5F1xxTcBVtR6dshTMhNOoc2QskdeL4oHDc/e7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7RDKxhCl/jfuDdm8so32/kgMuj/hYFdC72YWWzvdyUOJu1N5Trc1kUsn8e+nHJgeW3IeCMYvW6b0JcKaP8oftHmohumZQHTqPw8CQjMXl6TLiy4ZUs49REinpcma8LJrp7usbOy8LFC//2QyOTxCdHbh0FslSeDpgRsB8OcaSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GrSKXIBV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so4337775e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744884855; x=1745489655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSbJvphKhtV8mfmUJ+DjEluf1DEIsa5Ni2vvDcwuDeY=;
        b=GrSKXIBVGdHw4gH9HgjD+qoQbrd3sXq99/CUsYa2TUJr9Y8Kna0VdzkQmK93i46ZsH
         OJacXYswDdvXH4wYTyaEEU2UDvoxwZyVcDLv0zWqlX7Xz7Y3TjWuLGOpMoCV2UXmdCap
         DssXQx2/EcbAUvvM1H9pyKdjou1tx4GJz2eiPqdxbsivvx3JiSAV/uAdz87nXbBpGRPI
         YNk53VuPll+kGtGuMW9P7pxQKGEjRCe4nTgZFRIFjVi+0z6BbNIz7Bd5ahdZ61c+kXz+
         yqm91AjDeJfDXNEqKsBpDGgxdcN7TzvFQ5VrVp9nPfM/+7RBUKXeHJoNAlfked4KJuqJ
         vWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744884855; x=1745489655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSbJvphKhtV8mfmUJ+DjEluf1DEIsa5Ni2vvDcwuDeY=;
        b=aIKC1VqiOxqA0tW4G6AIjZQEadcKIbnUapp6bTWCRSBclIDTeCAzRUcYUA60KPRo5I
         gtE6ir/pN4kJqb1t5O0qaYHPoYWnitm+IJF5RpdM7E/KkVdf5NQbKflF216LtAU9RGZL
         7PFDL6wA/7V46ZfsQiKGJJ3Bl4Xi3Vw21e87SwFx5m1B/K5ahdcnyuoJl5M/ynQDvyOi
         I/CHSusr61EWqd5qpixErSzB2JexiAW+PVNmDF0FjAlXbpetZWHGgv/s9IducpsmcNrA
         M/wkp0UjumMmNf4sRwBMWsFBV5RhQSl664e6MZp55zazCUPpuV8qo6WhGR4u2jf8+wT4
         nC7A==
X-Gm-Message-State: AOJu0YycdHXqmTncnvU8Mhl0NpwuW56JVMrhH8ZAUi9KGQiTPt7pEQ4+
	nKM5h/hmV3IDv3u6G0laG43jULbBs1bYVnyooVB9xKF3wI8v4UO4TRDZuqYQhvcpES10a/qsvaT
	u
X-Gm-Gg: ASbGnctYQxNE9s889fH5KOE/kcwmu/M0pqPMjIDKhsZstihSjopNSk3i/QULc3Ybc60
	RHmzFV6GLpddogBBMStloHZQv1Y5DpyDRkS/PH3A6tv01jaX27J7WlCkvsJmPuEFezc8UbmgjYd
	VcQEHNkQTw16b31gfXOHhsn76tjUqIqrosX0WruVrVIzMtMFnhaP9yrUIuqF3TNa+T3qIoKlLfH
	XV6CgJgxrwrzUUG0HeNRipomorfuzTlB+oCPfuxb9A0zYaCxobEwxyChNY3K1AwoOgioxvsHMMl
	gX3OOn8jn4X9mBzfXNA1RnRrgb+8a3e+ig==
X-Google-Smtp-Source: AGHT+IFtH1EYIO8G72x63cQmefNMtuxlqu62nzXPuHUia+049ncycCEawzZ9gj4ARrFWs7mjnISVlg==
X-Received: by 2002:a05:600c:1d86:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-4405d616afamr47043475e9.11.1744884854650;
        Thu, 17 Apr 2025 03:14:14 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b5abc3fsm48280615e9.37.2025.04.17.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 03:14:14 -0700 (PDT)
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
	parav@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net-next v3 1/3] net/mlx5: Expose serial numbers in devlink info
Date: Wed, 16 Apr 2025 23:41:31 +0200
Message-ID: <20250416214133.10582-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416214133.10582-1-jiri@resnulli.us>
References: <20250416214133.10582-1-jiri@resnulli.us>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
---
v2->v3:
- do not continue in case devlink_info_*serial_number_put() returns
  error
v1->v2:
- fixed possibly uninitialized variable "err"
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 73cd74644378..42218834183a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -35,6 +35,55 @@ static u16 mlx5_fw_ver_subminor(u32 version)
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
+	int err = 0;
+	int start;
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
+		if (err)
+			goto end;
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
+		if (err)
+			goto end;
+	}
+
+end:
+	kfree(vpd_data);
+	return err;
+}
+
 #define DEVLINK_FW_STRING_LEN 32
 
 static int
@@ -49,6 +98,10 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
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
2.49.0


