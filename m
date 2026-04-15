Return-Path: <netdev+bounces-278607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DNMAAjh3mklMAAAu9opvQ
	(envelope-from <netdev+bounces-278607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:51:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8385F3FF620
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8291F301877C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F3277C96;
	Wed, 15 Apr 2026 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXeOqfPR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B27080D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214235; cv=none; b=JOqD9LXN0S174VWXT19bc8+acuOYgi/zojVAlB9lSrSQDIIkDaH7dEG4I25muq3T2wXUN2+pc+HMPWZEjgRKgwR1UYJvPIFWaEqBaxniokXYZCZJsSrv0y8nLbMrHnvIh5P8XyTg5QJuWRDFoqgZMk9l7S4gGA0aV9HnKQUCuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214235; c=relaxed/simple;
	bh=0HD1sM/H6vtsyRXMKFt2dw1zMlPDCFSkbhdELIpF2T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqTrhYx5ITasiomcgcigg6rSDRVChdxatBF1pW/HTvhpQEj25Y86sYmfqFqaqo7nNkJQQGhwY1Y7Pr057pSlTcnBhKWnIIYbrwkALVe/RIedkNrqde62gc/e4VndNUrs8dINtuXpOsarupZop81Az+EyRugdfpoW2hsz2m6y4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXeOqfPR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d74086e5bso2275243f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 17:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776214232; x=1776819032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWmbM2eqBTaj0A/LB8ecXRl5QyDwV/1SX44TmFsuPUk=;
        b=XXeOqfPRBKeindy91jbxf+nars1KQ5DFJBl7x1SBTUXTX4V/a9IE8VsAUYXo+FCAdx
         FEmcSUuhRfBGkBIdB6f6U/slqSDmJpBCEMTZoNTSSov18ckGfYmQ8EX7ti/bcg2rJGEu
         w67Lhjf6CgGO2UtxTdKVVxYp/JT5QSjLn1QYtMeSkjkQzKcpfNQhbr2MjzSla5OU8rPn
         foM593Lxok48uM4FwUffpiiumZXeBCUfPK6o6aP+RBoCOwv3RNZnljvzXhr/GrocTBvC
         P1ctwfpVdbGs/yXnsSMjKnmB8mqiUHbS0DITBLoPV4Z12HbeNy79sjiYgzqWz5WSVTxC
         TJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776214232; x=1776819032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWmbM2eqBTaj0A/LB8ecXRl5QyDwV/1SX44TmFsuPUk=;
        b=mzF8Cit68QKmNnfq86STdWB3DyG7aBMNrbWojV70JBA7W5zNOKtln/r4N49G4SSRre
         GZE46JhvBiFkxlfymWUdxOJV2k5c6PxVvzKYT0SUQfewHGvzsnhiWv5ku2b/8+BzAF9o
         7Q0DCUhmH0PVs4Z89gt7CBC3g/9AVF/s3AT682cacxmJ7dj9I1txL2uhYtSsG1A0MJMQ
         j6EIWvlTUbDrHmdBpEqz55CcObfcCkIPdFiHAsgBFa0+aqzH3iqo/hYVE0nIn6SpGMQm
         35dYy/1A+DZpF+Nwy1+XsVFdJIEIujs8lifPhC+DIMfU347+lM4GtW+S175R5sWhBKRR
         4JiA==
X-Forwarded-Encrypted: i=1; AFNElJ/2BZ0Ti+uMwQT5Y5mPrdRKjnU/uihW6As1I+6KxaGFz8pud6Er3m5brFy0LfXmnPek26D3UT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywho7r/MyKvOVgpBTN8riAnylDgvDzdPBMigYb6kQXIpBaEhgKo
	IW94AMJ/NcF1B4/DGD36du/P0TPxhzzCi+4Qw44S2qCrCMaq/l5n4fNw
X-Gm-Gg: AeBDievVKdbaL2kwwqeYOzslw7imNSbk8PPX4gcIvFkjYY9anzkDaiJlPIwV6/OXgdk
	8viJ1yBtsmPvOL9ylFzdWkHsl/A3so7ZEmCi5tWdr62EoKcV4leQsUte444Gw71V80om8gmzib7
	FLRVUVN6frZQA/07E3/CyMnAK1bq/EAdjIst9Uc+k123kl/8dOTf0IUWuEvtky3p1EZGv8Ed//4
	rSCy4bLl8mhEUPg+ZQ+C5qkN6J4D4tQ6FVitMyZqQlNLYRhBdPJsSa0G+bESjPC5L/441mwFD5t
	hAP1iESqtiDr9CdVyXVD8Zy0Kz21OTVrP7yCYFEkjJmZXzuYQsG4lwlapVQX0TrwqGUW6NHLQAF
	MYMRKIEIwb3o+y+Pbwsr5z24PBXbAFPMGXPWImV9FC4yJtUjtnN1IUPWmJxa4PqWjtL3/FjPGt7
	kWt8HFBck10eL0PG6Yf4fpxQAgA3g6Fh3rFM+UsdOqZ2Nwn2sG3UgAgun7h+c6Zf0wCa7RFqJnT
	AoB20Ku1ktNoKBwr4NYjh67kwb2QjnAormase8zhQ==
X-Received: by 2002:a05:6000:1889:b0:43e:a935:838 with SMTP id ffacd0b85a97d-43ea93508c3mr3084403f8f.50.1776214232391;
        Tue, 14 Apr 2026 17:50:32 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3566c4sm413130f8f.12.2026.04.14.17.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:50:30 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix HCA caps leak on notifier init failure
Date: Wed, 15 Apr 2026 01:49:37 +0100
Message-ID: <20260415005022.34764-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278607-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8385F3FF620
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5_mdev_init() allocates HCA caps via mlx5_hca_caps_alloc() before
calling mlx5_notifiers_init(). If notifier initialization fails, the
error path jumps to err_hca_caps and skips mlx5_hca_caps_free(), leaking
allocated caps.

Add a dedicated unwind label for notifier-init failure that frees HCA
caps before continuing the existing cleanup sequence.

Fixes: b6b03097f982 ("net/mlx5: Initialize events outside devlink lock")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 3f73d9b1115d..fab80c79ff07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1907,7 +1907,7 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 
 	err = mlx5_notifiers_init(dev);
 	if (err)
-		goto err_hca_caps;
+		goto err_notifiers_init;
 
 	/* The conjunction of sw_vhca_id with sw_owner_id will be a global
 	 * unique id per function which uses mlx5_core.
@@ -1923,6 +1923,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 
 	return 0;
 
+err_notifiers_init:
+	mlx5_hca_caps_free(dev);
 err_hca_caps:
 	mlx5_adev_cleanup(dev);
 err_adev_init:
-- 
2.43.0


