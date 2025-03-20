Return-Path: <netdev+bounces-176428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E237A6A3B7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0DD17D677
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0C21B9D8;
	Thu, 20 Mar 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f6Xk7G/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5C21B9F5
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466709; cv=none; b=FmhdUhNVGgmmc8lKlILPx3PvhfGpkqJ6HFo58OjkY2Ipa5EaR9PohMFf7VABbvl6w9YgVw1FFOcAkgz9L4DyLEBn1uN0OMSpqkZ94NuppbiUNBtRxR+EWEX6AqLM+Tp41j2YPg1pIC8CSCxV0ac2vV4avUf2ngHq6oFOwGYkkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466709; c=relaxed/simple;
	bh=s4S4jTGx5qixqgLu5sHfWGFYB82CsVFp2/sz40Q4zPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVpIYyyHDZyA7YysWNfYWFJ0EjlI1tG1npG3JI3HXyWSXlkla/68mRpwP0IFBs24Isb5NpHH2uIrTfnMnYCNLrhDXwvlHS3HF8xcS8781aKlwJplA0i+laLPL7t29ZxpeGopWBApRWHJb1lbWQniT59F8OnNEG5hDFMoPPpV1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f6Xk7G/q; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-399749152b4so237538f8f.3
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742466706; x=1743071506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g8Jp0Loxz2ADN89J6jPD3It5EGs/rQdCxrWoeVqtIw=;
        b=f6Xk7G/qBrxkzJd0re/117yRPdCLHhrLE5zj7sHfKZcgT2P+ZRQ5tUL6YDVniZCL0I
         3YrJlD0q6/kbnhK2PZeSEWj4d9OH/afMAsgqgXB6CgkXYWIBdhGr38QeS4V+CQzBpunB
         AbkYrMeF/aUJZpYI1wSwralMQeSmv0S7snyBqnEhMNMcvCCtoMcCaJ/P6LYZxvy71kVY
         MlhNw12Y2p80NV2di59U4HWnBC3mGNorU41Cx+8KS+o2dFWjJnLKIN7YPl+QOMPl0ciV
         o5B23kftkZ231zRJzG54V8rJXvjZV90/93ROGhtaoklHmj2c2QzRrPpo5MUKfYUylSIG
         yVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466706; x=1743071506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g8Jp0Loxz2ADN89J6jPD3It5EGs/rQdCxrWoeVqtIw=;
        b=gM+wTKb2SvPTZG15y4MKjOPZTTMZWSB0xaLZQuLa22luK4Y6Mrd7l7C3Pg3hTDnh1t
         n+L5L1u7PQjedvqz8VbEtxMKJv1VyqtlnwpeeVnRY5hmq9iB+NybDr2723QTjxl5JcHE
         mQ0oXSB5+8uO/XWtKOxk5ojaLhwupCh3HRGpXxXAxEQMDgFd1/3mlG1HO5tvPFA7f/i/
         bhSIeew5ts7XR+vd9+Bgsh3ijVVMENDxD/JHo7OQs7dq2o70C1ththu0Ss97q2iIKzXG
         Av6dFeiftxBXh/GIJ196IMCxUaxik9i0bb8/I0DnDLkSJzr79ohnFRIoaeAqgrv+uTRj
         AmLA==
X-Gm-Message-State: AOJu0YybBkJG39uvHmtanuv///t8Wh8QCv5ZBiqVRE6BBdwYbsG1hP0F
	L/UxLOYah58h4PFPc17hDe8xOY5rT4PsPvn2jY9oqHzH6YRS5t/z7TWsVWFGMxaBMsuLjMj4hcw
	H
X-Gm-Gg: ASbGncuMs8YC2+v2SIrheeR0rfhPv17ITUI1E1MK7SRCLvGa4V4CDOh5/f51Yo850h4
	3vWup9WgIXdYG0gYxuewSTJG9wEtx7kp6Sw0KpgzNT/GGJre2MM5H8FMzB9w2TZrKIGEu/0LGm6
	HNgicYvU/ooleSeGCfo/U5H48aUiKYZE9GQllU/OMbu5RdVisSc+fCO8s/2lYgv8nYA78IOuOdv
	V+y9JRtYU07hzCYtE78AAASCMXbl1kMljwLHSvUfmpzljakmTkLqVV02KxEFF2zDCpWSuc4N9Tz
	+qfvYjXYeglg9LrvrXCQXSxyIkjLhksnw/x4gg==
X-Google-Smtp-Source: AGHT+IEk174NhH4zB1H/CPGU7Bm+A/4kp4jOYPxKwbw4jNygkbG3nQfKoT3oFPQwy6Kepq+IWrCyIg==
X-Received: by 2002:a5d:59a7:0:b0:399:6af3:7a77 with SMTP id ffacd0b85a97d-399739bf15emr6018081f8f.19.1742466705794;
        Thu, 20 Mar 2025 03:31:45 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebbb7sm23999244f8f.92.2025.03.20.03.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:31:45 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/4] net/mlx5: Expose serial numbers in devlink info
Date: Thu, 20 Mar 2025 09:59:45 +0100
Message-ID: <20250320085947.103419-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320085947.103419-1-jiri@resnulli.us>
References: <20250320085947.103419-1-jiri@resnulli.us>
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
v1->v2:
- fixed possibly uninitialized variable "err"
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 73cd74644378..ebe48f405379 100644
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


