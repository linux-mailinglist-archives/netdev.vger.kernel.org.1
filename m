Return-Path: <netdev+bounces-183694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7BBA918FC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB88D17CD86
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6098E22DFA0;
	Thu, 17 Apr 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Yz3eXjDe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1E22D4C3
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884867; cv=none; b=pxg/lby7JRZBdfuTnXAR5g+iTUzHeOYFgztSBmhmnYid6bq+yyQcUZBsNznWl/haSQijtZH/4bmVmP9Ga2Lt57LAk/cjzLS271HYBxB+yU+YQ0c25P9yWBsrp1BG4njOJ/fbst7MF08sfa3YajuoIU2y5X4nPVnblJZEuUIzJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884867; c=relaxed/simple;
	bh=bzV6fcWZXtviJFecIdH+4FWEvBdsX5ENw/cnrisySpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R24nobacuKsrJQN7/Xy3FK1t8ksizB2uwMchJr8r1pfZ/z/IKZEX9bCkERBrIzVPvZH1gykO5Tp1MqWoPc+UtUW4rcpuwlW6M0EajgxrpBSY6042i+So+cRzzfXKDaD/T/COCcH8AzdEKPS3dZeBXnSAFn9U1ZDxxkIc07Cpj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Yz3eXjDe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso5769555e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744884864; x=1745489664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4ZB/gV1wmFw+78kuVh8efwdsnURVwVY4fkiwGcxVGQ=;
        b=Yz3eXjDe6blbBumYvOxojr3qiZ7p7O8HlPXfxAruMrnXxn36QV15uoNh5AIwwDqKHM
         4sNMOIBu/q9kisSBe8+Q5btd/LC5sgrIPlYsNxNxon6Sr5025LJxjqiPG1uurVb6y9T/
         WBG06ffPc1hp0N1HdzPyAAUTAJMGTMTcegeX0RdNX1G80n9xryViZl2g3JE9ln8sWhOy
         I6tpx85z2minaArY8IQX/H0Huc5oT1YP8tXzJiihTKKxcLhgOi2SOK8Jj3en0rejEC4i
         HtpGSs8kk6futyDqWvjSSg6f7XH6vF+IE4GDQWWtpfCXu6USAelPMVNEkaW6ViGqgTmz
         rsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744884864; x=1745489664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4ZB/gV1wmFw+78kuVh8efwdsnURVwVY4fkiwGcxVGQ=;
        b=Fhgh3P5fk2KC0aSSunCCQzixh/sGV/adDC6NGZhlaZIj8U/nXEpu0V76iCs/V4fkk3
         6DGhISIfb5DaKARUJn71QAAlT2lY9yzlXVNOKbN1EAiyXDp8ihNbT7JDcRGFBomKNNQY
         N7Nl8FenG/LXyCSz+GsXSJHpzWqXn7dmtNJyfbxmTsXKpufK9pNk6fi9JC9gYEsVcvDV
         BvgqFG3iOvmzjQQp6vIpQY2axv7Y7SYp7JGC0ADztrHlS24BoslZW8UKVbiaCiEaD/8g
         AAmvgnWiyQ+nDaAYREGCAKM7ygMY4f/o9D6l3bxyqkXES6PQh4HkyTlWVj4ByfL9WziX
         XlaA==
X-Gm-Message-State: AOJu0Yxi9vWuBQsMXypKjG1dbj3zzsqOlQZ9bL/sWi2rwaQRBSTI2zfW
	tCdCDUgoj/XCMjt2ElkKZN3XLQV4z5rHfuo3Pqv+11YLQ1xTf5P1YwRQxCTR4XTEgG8+60ooyF5
	7
X-Gm-Gg: ASbGnctYXULOcpCXm3ZHxqySkvBpOye0pVsh6bvyLFf+62I242KG5lQLinBSQ2gF2GA
	8Q0l6ffSA2ohNzxfr0chrZXIuwmOjbWg1B7/wOrUGwsHdwrcnp9PVRpLk2phZ+7acu2ppolL8Qh
	dI5mZqgymS6NDAbnAtBugO+1sl03DpsMnhTDgQ5Bu5Ymox2t5Py565kjxHG0L92Q+8EEo/RCOUY
	9O2gRQXv5cmR7MRFx6ugnnU5jVjh2cekH6VsL/8yVl5wZFKR8yZ3yGWH4POjAFN87R9dMlHicd6
	/S9ZF2TacC8Iwo48h2VkY0/XQD2SyjStog==
X-Google-Smtp-Source: AGHT+IE2ydrjS+s2VPGiUd+ESX6XztTnZ6UUu0zE7sDxXBCOaDZ2wemdMUpdXXH/cHPwFFMTlOI8MQ==
X-Received: by 2002:a05:600c:b98:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-4405d5fcc9emr45146215e9.6.1744884863951;
        Thu, 17 Apr 2025 03:14:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4d1236sm48383735e9.13.2025.04.17.03.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 03:14:23 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/3] net/mlx5: Expose function UID in devlink info
Date: Wed, 16 Apr 2025 23:41:33 +0200
Message-ID: <20250416214133.10582-4-jiri@resnulli.us>
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

Devlink info allows to expose function UID.
Get the value from PCI VPD and expose it.

$ devlink dev info
pci/0000:08:00.0:
  driver mlx5_core
  serial_number e4397f872caeed218000846daa7d2f49
  board.serial_number MT2314XZ00YA
  function.uid MT2314XZ00YAMLNXS0D0F0
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
  function.uid MT2314XZ00YAMLNXS0D0F1
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
- do not continue in case devlink_info_function_uid_put() returns error
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 42218834183a..403c11694fa9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -79,6 +79,21 @@ static int mlx5_devlink_serial_numbers_put(struct mlx5_core_dev *dev,
 			goto end;
 	}
 
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "VU", &kw_len);
+	if (start >= 0) {
+		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+		if (!str) {
+			err = -ENOMEM;
+			goto end;
+		}
+		end = strchrnul(str, ' ');
+		*end = '\0';
+		err = devlink_info_function_uid_put(req, str);
+		kfree(str);
+		if (err)
+			goto end;
+	}
+
 end:
 	kfree(vpd_data);
 	return err;
-- 
2.49.0


