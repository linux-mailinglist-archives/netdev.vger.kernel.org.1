Return-Path: <netdev+bounces-176430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05935A6A3B9
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6CB174063
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246121B9E3;
	Thu, 20 Mar 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CGuXd1r+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6521C184
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466719; cv=none; b=ac36Tmzdkux5nBDGX5E3sdgmhPN2EWjXEiAp8OaksyZGQo3AnZrWJWsmWWqABdBPocO/Ji5havC5QwCh2USqqgcCHHd/r1J+7uvivBzb4XincozggucLA2m5mht5Eo6bmMj1ELP93LGaRaFR1vnyxjf/bYDS/Md9i91GxjCxCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466719; c=relaxed/simple;
	bh=SqBYulgD3zE14pmiwW5PZY8FRu/f+vVUlZbzrgJj9ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S88BwYlO4w+N5E0cglQkBE2uij8tzlga5GhSPuyOR+Lttr4szq8j4V9HXcU4rc6LEKtYsANcyxJNwasowfKQV3QDCwQrmEqKIavhfREvEO/GyHM9vocuT+nKDcHs39XXARLL0gTDHcS8VZR9IAVkI4b01ZNrMZyvsRYZYIRd1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CGuXd1r+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so5809285e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742466715; x=1743071515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF80fvmskExtSSTP2JVLL/xiNDY6eObNK36YmGv+lCU=;
        b=CGuXd1r+8ehhDO1saV5byqySiQQ6BmDuIG2w2XMmFSotaQvYRdqdh+fyzrNX4rbYmE
         oSSKfGsYMVczX5LXDsy5wCda1BXOLEuyEctDrwOh0qMrPY0j5BP4LPX2Bif5pR+Epyiu
         gCbYE+7eOE4ZYKI8/X8IredgluDseZGIOaJRxBGoVNdx1x8LFfV50OlDMJbAwxW3YtsJ
         Zsg6mj7IuPXlRlOGe0wnJhdVRVpJHFq9NQ2HpNYcAuKyxTNumJdEJYViPj4kJBDAbkuc
         32iPHI9pYDk15Jb+hCIvwIs58odN0n/tB7IdeyWGZ442xz2Bp4zclIchJGYJhDbxOTqE
         +0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466715; x=1743071515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF80fvmskExtSSTP2JVLL/xiNDY6eObNK36YmGv+lCU=;
        b=w6Cet5TUgr2r0Thvw6AC7OFbO6jDd9HBsVoIBU2vaewHMrmFeE1bGX9q3zr8/hsadN
         EHsbNp5LiFXaXjsbl7EKRSHp2NAvUdFg5bvIhYdK4vuNW5AiI/Ef6YX5kJEvgOPC81WB
         waqFUiD93JcMtaUFhy9JVt22kcjR0PeWTNiAUsAm5PJMI71VzV9xxUbbTKYSAvKVnr07
         VuJ36Nxv6U2XKbIrXPQ62ZNEWg9aYic25ViaUYQ/l7wkVAgS7113Hwl12/iPbSYt6Khr
         hGcvfS4jxhF3r0QUkdc7m7AqhqjB8OYUFyZSYErL7mexGPV9OsO5yJM5VgaDxLg0Y0W7
         qZGw==
X-Gm-Message-State: AOJu0YynOhDdbMRH222ltZsWiRP6HAyihZz7ypuaAKZ4izCD107F1Hoq
	Dx3xxFQqoNb68VTunhBz24X6dQif/d8GGAozC+7Xhb9gVqZ5cy2O6mITnIbWRTnWiXT8+Z92IE6
	k
X-Gm-Gg: ASbGnctAawIzRn5RRy/72wRrcXTGrz/KueU9IQs+H8mKjtpsCbP9nbJPAuQQdxsNKNc
	/vM6y5Hp3oxOitQAQhpb00Ki4KDa+iS9BirI8Dzc9Z2/eTi24eLqFwOz158Zr3/B7eIz0bol+fm
	MT9FGj4YsjC2YKWz+t3dBy36hmwwh5ZeSjL6U41TeTnm7CK8CmU0hjfXsDD5yVJ59dErJz6NLsa
	ZxejseHzr4619lZWk5xt4b4l1SK6kRraY000Nov1ETdNEXVGitjdpV4eZTTT2lsTC3HANVjFqqS
	cq4CoFAgjL8xDisdmq+5nWWuh0wmsi38bqlvQQ==
X-Google-Smtp-Source: AGHT+IFLBW09z02CEn7y8CSsXYcseAwOcpAsBdNJO+UZMzTHXoHjhDziyILk8soBi8isPAu173sWbA==
X-Received: by 2002:a05:6000:1f83:b0:390:ea4b:ea9 with SMTP id ffacd0b85a97d-39973af8dd3mr7900787f8f.39.1742466715559;
        Thu, 20 Mar 2025 03:31:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997e3eb672sm207006f8f.95.2025.03.20.03.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:31:55 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/4] net/mlx5: Expose function UID in devlink info
Date: Thu, 20 Mar 2025 09:59:47 +0100
Message-ID: <20250320085947.103419-5-jiri@resnulli.us>
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
index ebe48f405379..97bde76af399 100644
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


