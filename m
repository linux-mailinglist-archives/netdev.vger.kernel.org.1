Return-Path: <netdev+bounces-177959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9AA733AD
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5954E17BC56
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C380215F5C;
	Thu, 27 Mar 2025 13:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D8217668
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083830; cv=none; b=CgqGjyLTvkzvTq5BdhlfXW1kbZd7kMxyIRt187moai5VrC0xRkYsSyKsehe4AFaPh8tdxrQsxLasYgBK6KMrRRv3P7MR2uz1A89dh1Kn0ao/yFDcufVTKQWhfUy4u/0YTGtGoMeIKdR6P9OIFKN4QElKgkAXL6hXPhaVSFC6uL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083830; c=relaxed/simple;
	bh=YEDPaib1in0t3FNqP8CqzxLx2cZwNmmLwkBr5DAIR2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJYsW0ExHcC4F0rTztEdOCWN50A9blI4w6ipcvmbsQf9NacNPicFxvFT9jOXhuUgmIl47OhBrqyCnzGI9jTNztZF8g9X+aI9Avjy+Y7nphiOARp3tvTLKnhJ9z35q3ZXfwk+y2YdttoCXwQ0Iiawv8jv0yoRJJuuv8m+Scoa5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so19773535ad.3
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083828; x=1743688628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64yh+WmiMEv8Bz4J35cqLkuK/gFRr8aAu8X3M/MtTfA=;
        b=m5DRPhFGexa1IkNNHtXrdsaKIVFQOXwK0fIh0umwCO87xmv+bwtBffV8OijiDN0r/S
         ilQVH0E/hxRoKZ3AXrZyLAzB1H6y2ODDAS9BC2Wt7UlYN7x568hpr6+fi6MBAzMa/tM7
         RZ7k90qP7UTDSFTJqbYhij9qei6E7rgpGlKSorlhzPk0MrZIMd6Syz33suQd9RFvVKID
         vw9nURuFZcxM5WwFGSATpsOXr6NvSYJCdnBgqbP8xsTmXlE/LGx3qLq5v5ZX6g0XC/1E
         UzwUfujwKKzCpBP13Olm8mE/EXd9pxpw29zJFMiaSUs0QaU1Ly+K2zv2ny3PYqpso9b4
         s+8Q==
X-Gm-Message-State: AOJu0Yz1KV1rgfQv7tauin96KhUI3scpX26Phl4fBooKkTgsQrnPO/oo
	wznW8dfzfhE4udePCpOnhbS/I5RGjXxmBQ1q8EqW9YaISkpLgb22NmqrtfmTDQ==
X-Gm-Gg: ASbGncv4BqbtMvNOBkqMUcyxwJLKj7+zNCrXnm1KrRp6e/r93XA9RLB0xIq7Xhg6Xnh
	tFNDXcf53dyXSlZChO1JdOqzSaTadWuEwRpYK2STJErk2xIvL3Nz54XR0aAVScZNeEcqC4OkERT
	AHtpIx/HmhZGDLgzjrS6j0OgGCX+5SFiDmOhZErWrsOjOjMIKcYovywRzYHS5SUyAbybKQUnJbL
	AEZEabafs37rEhfUmtipa7bVihras+lT3E0ccjubc5A4zg0UjQnNYcO73KZqcWr55MPyD36ZOPs
	Bj/O7Wi78A4HlLUKm6Hq626LIWPb8UtMwlNLrVydcoYx
X-Google-Smtp-Source: AGHT+IG9WmumP6ZIjvTkJj4yAAC9p4DnlK4weyAEqrrkAYlkhQL5AvCgsqTkpiaDIV4kDPOyuGWWmA==
X-Received: by 2002:a17:902:d551:b0:216:794f:6d7d with SMTP id d9443c01a7336-2280495aa5bmr64331865ad.48.1743083827666;
        Thu, 27 Mar 2025 06:57:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390618f080sm14774159b3a.176.2025.03.27.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:07 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v2 05/11] net/mlx5e: use netdev_lockdep_set_classes
Date: Thu, 27 Mar 2025 06:56:53 -0700
Message-ID: <20250327135659.2057487-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cosmin reports a potential recursive lock warning in [0]. mlx5 is
using register_netdevice_notifier_dev_net which might result in
iteration over entire netns which triggers lock ordering issues.
We know that lower devices are independent, so it's save to
suppress the lockdep.

0: https://lore.kernel.org/netdev/672305efd02d3d29520f49a1c18e2f4da6e90902.camel@nvidia.com/

Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3506024c2453..e3d8d6c9bf03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -40,6 +40,7 @@
 #include <linux/if_bridge.h>
 #include <linux/filter.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_lock.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -5454,6 +5455,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->netdev_ops = &mlx5e_netdev_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
+	netdev_lockdep_set_classes(netdev);
 
 	mlx5e_dcbnl_build_netdev(netdev);
 
-- 
2.48.1


