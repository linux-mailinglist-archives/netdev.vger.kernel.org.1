Return-Path: <netdev+bounces-175802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB79DA67803
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C3D3BBBC9
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29519C56C;
	Tue, 18 Mar 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xAoEVvyf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95828FD
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312208; cv=none; b=eD4jsYF51PaYjhaekljaT6ZAeDgCJWUl2EaEeNWqNMl8aqQJ38W3P4Bl6VvQKSlVWbVF6GkqFWWZfwcH05p0fMWAzMMufF0QPAN1dyujS8q8qhgoFNgm3X6SDLLUutKbPLl8+4MqMyHwn0JeOlz75OKdfoz9n9mh1xfdsCR2FbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312208; c=relaxed/simple;
	bh=hCzI46TOxf0whbHlZzAK7Y9ErzVtzl/XtM9h25zqMm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjVZg2jKQJuiUQ7WpjnORU6lG5cOp8Enlkv0qL6UdVQTnF4NVuGaYRRopKMUlM92q6AmFqGGxWnXz1KH5UyoVm3Kz7Naw70Hlljy9/SVpRi0hjA34+BjbrXg75+Z/DvgN96y/mJy+PUVva0x4b25KvP6BvWyUINcno3kfJ30Tjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xAoEVvyf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so35788625e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742312205; x=1742917005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At6+XYAcNE+hfaNmHjS9408JCFLx8zx4kdKac5P8Z8M=;
        b=xAoEVvyfRD/c0DkOceXESGVx8Shd9gF+iIlkz1yXTSZLCjz8efxFIOIL3zmbTb0dwi
         XZGv2lpPU2c7sdWuPl1IHGP38A8Mp66ylbrLC3pLJcM1snRxWYMJHPlMriIwkSTCyiQ7
         jhq21ZICgwxBxCVxZ6RF43FPj09hiEPsc6984vkqU6nsxyF5Ogg4LoHs8tDJBYSsAjqA
         GMZkdoefejJfYWFanABQbOGjogBg/JHiZJXD6W9JhNJ9NYB9fh+ic6DEFB11GjL2iJO6
         rZCvrZN4GOarxUFJYbKS7WdXOrIJ84NOGtvJ9+YUO98PKcfPpEbGQrnqookotLxsURZ2
         LETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312205; x=1742917005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At6+XYAcNE+hfaNmHjS9408JCFLx8zx4kdKac5P8Z8M=;
        b=lxoUyTFxESGmkHz1lsV7XJOsr0/fiWPCDrqRbn0TEPnSLeUFX3t6HlitL997YuoC1g
         w4Qb6yX/2SvgYo59+d/1D7jD8EykDC7GpVP7VzvccD93ZTnVzxZOOcNlVYRu3ZenIo1u
         6UUfta7WPfl4U1aGYucZpbwBPlON08htryeSZ0hPx4GRrFdG5X/LBczVHdBI6fvGello
         ia/vRi3K3pMCL9wm1L0fwU9+mnT6HSaYq8u0zYMnlGQ0SpHCzAZlw9hDIaL1rpT/BDPT
         jZA4ae/+Ja8c7di0JR5be7pcZ5SQTlmpxGELvosDa8Hr/jpTPa/NK+7u7jaovqpJCYHn
         eing==
X-Gm-Message-State: AOJu0YwKVpBPnsdAhFsgTWGwV0qJNu8488GB5w0EFYXkRKFxOUHI1TZu
	bFKrvYprkcXm8+aXFI0bcoyuRrCYVuVp7czgWGpyYieon8ON2AGW6Uxqol5P2Ls6pZe7H2kpjSk
	U
X-Gm-Gg: ASbGncuaEg4CRSCveaK3kyzOf/dhtr+0J9GXNWIvIBz9x9Z3iFrGRST50mfhEuVgzy2
	8b8go6ikiJsTaTPoS24+sDImsgdjyZAUvWKByQS1lDa0TrcSGgNxLN2rDdJqvUnApebGWYdqmjm
	zX2iHclTCCVTNiwLLM6AOJ0uThDg34hnfzoRDhIrf/991Zlhda6ke1XJORX8wArVWv6fnRzA+wi
	xqsoMyMk9MyRoQSFKWTN+BnzyPDdvRXJYXzxreeHNIQcmOHMXb0TAHcUI0MEHeNljxbwgHCt0wU
	olxNAzEASdimN16/k8Q3iTYlR+lxDgGPNC7RDg==
X-Google-Smtp-Source: AGHT+IFAHyg7X6M0U1I6d9cr5SNMGMLTLyD4bdbfak2m4L4DZOyzdIG49U9HDVuL7Qll8MwGOQs7Cg==
X-Received: by 2002:a5d:6d08:0:b0:391:4940:45c3 with SMTP id ffacd0b85a97d-39720e3c9bcmr18462645f8f.54.1742312205214;
        Tue, 18 Mar 2025 08:36:45 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ea16csm18289257f8f.82.2025.03.18.08.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:36:44 -0700 (PDT)
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
Subject: [PATCH net-next 4/4] net/mlx5: Expose function UID in devlink info
Date: Tue, 18 Mar 2025 16:36:27 +0100
Message-ID: <20250318153627.95030-5-jiri@resnulli.us>
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
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index be0ae26d1582..6caaf174f44d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -75,6 +75,19 @@ static int mlx5_devlink_serial_numbers_put(struct mlx5_core_dev *dev,
 		kfree(str);
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
+	}
+
 end:
 	kfree(vpd_data);
 	return err;
-- 
2.48.1


