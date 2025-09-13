Return-Path: <netdev+bounces-222800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D61B56274
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 20:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383687AF897
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3807720E011;
	Sat, 13 Sep 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb0EuTHn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7A1F9F51
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757786497; cv=none; b=CPhnLkirOd9lxwOhrsghTrtxG964AhSV5MmPNF3ipkt7NDiA0j3G1nsAUrxu79r+CRvDyC0pzLmyt29VFPzCxorWnx31XggrKrK+xwnmGpd61ReqrXufa5/gJcTrdKCB4fmfQhTg9HRujSSp7NXjj23082MLbSs9UFxlHEZeIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757786497; c=relaxed/simple;
	bh=UnaOqYluKu28oBnwPH0vnbCU+O6jr21CjF1YCAIsvFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UX8zcacs2KhjEEJmnHFoIyZufhWCSn1gcuFI/N+51+qc1Gg8B9phf9rqiayWFPPaAktyMl2+ThvPhDO/eG9LZjLgtdWn/CwR0qoRsrgF9L4qz18WgzItFwFQnXU+tesFdifd0wgqaXqoliboi3KKKAp+gsucSbrldFtWBN0YAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb0EuTHn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-723bc91d7bbso23819717b3.3
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757786494; x=1758391294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjHrIrhN/4pjfGuGdsD+5Ie4bMJa+37LDUXsJfR1WJM=;
        b=Nb0EuTHnk1rU4+sqHEk9Mz5mpnQs/KBTBTng1Hhz678Q9HwjDl1TLzA0KsKQkGCzYA
         jvJLACHZmVq69So4rWVOwFZlioYw8vsQ7nvMjkniKntOa312AJjbZDzqnknXXLfvWeSR
         +/WdVba6LWds6ExTHDYbt5ZgrWi3CdtQPxdzq9j9UTvkoCx5p6EChzRxjrCkl5nrLG65
         xycttFw6HPHGU5Npw+rEOdC26IQMI4/85fbcZ3ET87A6735jla5h8WJ64hc7KpvxcffE
         Qa99/97mOmQ7QE2tJiZLd9XrT5snjtLqazOCoVelfzi69R/VqJ1GYcaBd/AnEjHt3TMm
         voTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757786494; x=1758391294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjHrIrhN/4pjfGuGdsD+5Ie4bMJa+37LDUXsJfR1WJM=;
        b=pUF1xLgsjXia2lmP/UDu4SqPmQ4w77+W5hqgU4dSOpRHbUepgyNABDSnksQ72+6drX
         cTd1HaIf5wQxEAWTfJIFzHKDRDROsL822YcE8QTyT81Hf8TtMp0R9PL28tCqZdNlS83G
         dEeBlTpXjKkr/i2Yk7ElLjEOdeVmZfqIXjRrNfpHSDJoPIR+ij5BwC76fzfAlIRt0QO3
         s4TJ9AS5QkJSYkRs5ZRAJ8hbFj7SuOU4ksJG89i75xVZmhl23o43Y7g5WZbV66W9wlxB
         Ca6YgRpKOu1pKm88N4jazDD7z8OxI/+1R+NNllNY+WEtF1ixHiFcm/6XGxQIUbRRDTtK
         URxg==
X-Forwarded-Encrypted: i=1; AJvYcCWpO2lG8ceYn9r4Ehgb8v5b1CK6D0YjV+v2un2DaXAH4PPIH4NdF5bC7qz3qWelKerTULFUALM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFmHTJR0zFmWkU6tiFl5+Z9iW6odNGx5zFTVsWVYY9Fe9knnp
	Aark1eESwM/2ga4bWJdhNjvkAhnKUI7tFLcN0j2+fri3db86IPgPuRD5
X-Gm-Gg: ASbGnctRTUT0a7mZfWYjo+bVtTbt6jcQN9XW0VYNcYbxIN5GQ2frqS7czoN7t5KTEDB
	cORGvYTzAPnTnSFlJtq4bh3X/dhdD+kNrht5NBCV2YrT8xL+eCaHWN1zF34dtdFQkE5+lP7wdKM
	JI+NCoy2Z8y9ZSn669iaQZFDmWcsvbpCiC2mezHN96kbj2iLVobrJ3jQHjbFCiVtNksJq2yEl4J
	GAMkWSs0H1ADWXhdwewNRp55fVhLy9Chjht8JqWiPybuurwebeBuDYGpWOje6DFGQlhEZrPj7Oo
	X9RU7RbJIO/MBY37UT3/O/jFZPDrQdxipVAfboXIGgycymSSl+d1/rD06RbiYZQtmp0f1hNJ+/h
	yRXxKt1Gke8ZPjxbJjIvo/0yhMcgpguInivRQGblaAlroRjGBJM0QZVlaMg==
X-Google-Smtp-Source: AGHT+IHi0t1g25a3FWwQ5Y/nJHat0XL4SNgFHd21Ox1E7oZI7Dop3SdUOK6vuMiPxpkEVNb3sGWL/Q==
X-Received: by 2002:a05:690c:620d:b0:721:28ef:8b5a with SMTP id 00721157ae682-73064cfc35fmr58784437b3.31.1757786494286;
        Sat, 13 Sep 2025 11:01:34 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-62484dd3e12sm1900016d50.8.2025.09.13.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 11:01:33 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] mlxsw: spectrum_cnt: use bitmap_empty() in mlxsw_sp_counter_pool_fini()
Date: Sat, 13 Sep 2025 14:01:31 -0400
Message-ID: <20250913180132.202593-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function opencodes bitmap_empty(). Switch to the proper API in sake
of verbosity.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
index 50e591420bd9..b1094aaffa5f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
@@ -170,8 +170,7 @@ void mlxsw_sp_counter_pool_fini(struct mlxsw_sp *mlxsw_sp)
 	struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
 
 	mlxsw_sp_counter_sub_pools_fini(mlxsw_sp);
-	WARN_ON(find_first_bit(pool->usage, pool->pool_size) !=
-			       pool->pool_size);
+	WARN_ON(!bitmap_empty(pool->usage, pool->pool_size));
 	WARN_ON(atomic_read(&pool->active_entries_count));
 	bitmap_free(pool->usage);
 	devl_resource_occ_get_unregister(devlink,
-- 
2.43.0


