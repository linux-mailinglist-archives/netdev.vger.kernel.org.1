Return-Path: <netdev+bounces-196157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AB4AD3BC4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5867AF573
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136A4227581;
	Tue, 10 Jun 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Rj7lFS94"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BC221708
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567227; cv=none; b=EliZMMRvWo8FxwGu+oCwVlT9HvVlXUAFSIbGBkkvpZT+F31qdRHL1Fy4L5oaM5xIWEEdhaOZovFPw9wbtGz/Ntv/1aO//uZXVergiz1rkkjiEKpXgkb/bGYx29F3+lmvo2OXWSYGPqtCgHOUgv/LVKa/ssIFcaZRoI4/GaSywLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567227; c=relaxed/simple;
	bh=49CwuumcAEN0WgHrhZH3PFTEd1GIO24EWOkjrkutSlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLEBQAmgT3Ak2s76k62R8VePpS7lvde0aQe7FuUx3Slq914GOZgt74Vp56PJmcxY0SpbolNh8TfkhAgy3G61fOuB9KvhGN9ri0+XtUSBVQ0Fb1X4pKtUqaWDiDd0nAOQpwqQgCzgCTDdmUkTb2Uv+wRa7Jr2Oldvdm1F1X7lpH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Rj7lFS94; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so67014665e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1749567222; x=1750172022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZenOCv1TK181BQJBXwmVUonYy4Wo2e2g99VbHT8n9yw=;
        b=Rj7lFS94KDaOtfyHPrDL212+u8hY/pX8bRvs0IkWIcSSjfEn1UVlO+0Qq3gFhibFXK
         y3hjuVyi+XksdF9gwEY0c8kH/4nkeWUfIffhWRQHXjH0R4RM20GBT8mh5J0Eu3Dcm/Vh
         YPS9sXayOCNNm4ajxTpUM3wnBFXKsqQMBRS7ZiSiG/txN/d/qxCPHFwqoXkeW99ZW2xE
         xMJQpbFCwMRT6tEUgT6G0d6XjYpLDHiv3yS+EmLmYuAn4tVX9wUleORvoD/ap3hyYq1N
         Pj0fi0tsN/UyVNZTADxZ/SIBTuRX+UdXqBaQ/UtDylM7kHDLRXeneWdGEb8pFlETWLSX
         BbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567222; x=1750172022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZenOCv1TK181BQJBXwmVUonYy4Wo2e2g99VbHT8n9yw=;
        b=Dphmxm8Z70tnQGO2jtzH3NkTMpLYttN8f4hBKHn621oMNRAhhFluIRgXdEU+XV/UM9
         IRUwwIJDcHO6q+iajRfEej5G1MnnFPf0uVTlJJTgxBf2WumpoFpVHemO/h8s1YNxjof7
         G/1x1HSVApdF0oXc505I7Qg/tzVAHNrQIPA3JTW7WAqtN1g0UsBqcwjlEjN2INwnTi+l
         0C0BcMJ4fB5x2rZa9ackav6+Mtth63SoFnCcho9Nc3M8QxG0SDV8hFXlP8W0TIaue2oX
         w9Nq2QBYNCIS38uCMgvDmqmtof6n5CRnUZ8GH/WFjip+zfk4SUQRjpFfn9NNsfjuaAQ2
         LtAw==
X-Gm-Message-State: AOJu0YxRYtS5BRAtyXjb0gN72RZ3RWgD6bR6MX5PCIKVb5rlj4q9TTFv
	hDyJ64aN79yhbw9K68NQK2/3Zz8bP4kQeWZrPxiWd5gIsidPO1lObtwTAAnRFG/I8v/3/a60VF1
	+cX3M
X-Gm-Gg: ASbGnctMsYfOFfgPnopXdMgWdOdV57TckGNx+A8zOuqLx1eWbHqAeoZcYBIroPQqnxx
	raPeCM5ykd9fUuBknRFSHpQwaAf9qO7fbcGnuN+uuAfx5KV3EYgU2NxHIXZOb3E5RuO+8VeU361
	fUDLIAcqecbBTjZOm1xuUJ3MGT59km1LPfFetW59t//FHBEBUNWc42WBX88le0zE0WtIBcFbSYm
	JJ4qC10gr2TmHt7OVR8VX8GamFbMy4tfBruzcHIJywnFxAUU9/ItJ2FPb+cCBHydEqN0ZABVCR6
	SBraIR9CmUNLCN5/nQLif57WwfXhf74+VNLIRXVlKWeiIAuTScaYAok=
X-Google-Smtp-Source: AGHT+IE9DMO9gZR1jYT5IPvQ7DlwJFrvR5R6EGz5vufWtNnUUYO4g8IGd55hcs9tleJhaXS255TYjQ==
X-Received: by 2002:a05:600c:1f10:b0:450:d611:eb95 with SMTP id 5b1f17b1804b1-45313e00be4mr78624595e9.17.1749567222448;
        Tue, 10 Jun 2025 07:53:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324638e9sm12331430f8f.89.2025.06.10.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:53:41 -0700 (PDT)
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
Subject: [PATCH net-next v4] net/mlx5: Expose serial numbers in devlink info
Date: Tue, 10 Jun 2025 04:51:28 +0200
Message-ID: <20250610025128.109232-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
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
v3->v4:
- no changes, solo patch, dropped fuid patches
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


