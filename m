Return-Path: <netdev+bounces-119898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA49576BC
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD295B216F3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFE15D5A6;
	Mon, 19 Aug 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ez5atJOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF514B945
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103801; cv=none; b=MG2LYjh0EBFrbv5uYIpBQHtRMm9LDbC+MF7psdth2jPBAj2Kv+JGnhcC9Zg+EY0VCo/NhdtROwV+7tHlXXDdqbPDRKugabBruYXXMmqfERTpZlHVNFyJkYaJWrgWhlTSyY0bNurC3zCkXWy6FTIiQeUKVsEDgu5PBrBwwWpkaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103801; c=relaxed/simple;
	bh=AF7FA88IJZQJIDztq3lyuQNCNcFdr30knN8inBc5GPU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ifNSmM83TZ3gGVQGEMupDfU76ht02atLIrQc1wVLTyxvDqWxueAWg1h4SIxO28Ldb7IOgwNZBXclUALAI8OQIK9c7fa36OXWTTo+KysAJ8/74F143JfgVMAxip4pHcvsKTEsoD/hfCbqdk76pdlVrEgXUSZNlP+hJx6qM9GLzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ez5atJOK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-713dc00ce9dso2101207b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724103798; x=1724708598; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTqdSUqce5GEmwG9R6Aq8XgjY4jDrfouBPveXJQ3bng=;
        b=ez5atJOKL+IdO8dA8HSJUgJcSWKLuZF3e4BQp4QQIN8G87rLszhgyuwCELCedVaG8r
         ElVr+CqpYKw1ofoAQ6GQ4spXK7KzqzXUWgd9el+AWVjKr0/RRvIxBMKMaaVR4oy8704h
         aBUWi2kj3y8oOohNh31TR3FFMlBK+CqgNMPmmqqnV88L8Yl3wW54vWpETKuiob/Jz+4t
         VYdjcmFut/EdXxDQ7E5u4rQe/EdgvZBO4N7Wo9al2EMf3ma9inmHV9gNOrRuIwUyWMGh
         jXs0de51TXQYfPSwudNLBlBx7tBGhyBBBsdqvnbHJjAtjJ2/j1Mm6z/hdIM4am/9tGm2
         BZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103798; x=1724708598;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTqdSUqce5GEmwG9R6Aq8XgjY4jDrfouBPveXJQ3bng=;
        b=kzz6Wibi0eVXQB9BUnjy5oZ7s/Mmf2VZgQg3T677UKcsmo69NHfE1brWVVj0Nq8YlI
         SVWSopub+Bs1XNqFOPykmztOanYLtUM5a7oVdc6NRoeJ0BQ9xNJlpO08GrrRoEcqPV1/
         BCH4vC6x2nJppC95/4HE2adwZAIMD05hxZJKt0TzIz0w15PqNesB6XwqC5WCGYloc1On
         BIlGms6qCZtAHMQm6WjYqpV92mGDZzVS/H7wSO7DcayPruXg/Hp+lWdIMRyPB7qaUQsE
         pNYXdBTZ+bL9iHeUkHwtnC03gEMoEmuGkDmyW+RE2zxzK5gw0rj2Zl9jFRPSVV0Szc1y
         ikDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKdVT1iDw54yEK641NJCe/iQfYIoswS56147vJHuOcZFEKZeAa73aR0ShkC3CH6v1sNPA7B8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1MT84nWy7+ZscUw0El1CNkzyaPJYTpYoB519NUJ+++J/OiiW
	shvr1MiFmhLIdivFHww6OjwgDPlX6vBrCw9jW0sjORwGbY/M0fhut3X5sbNEJ/4=
X-Google-Smtp-Source: AGHT+IG+Xm+3BkxWTFsrHJE7ZjxPdu8qYymKVWMYp/liVXK+trlqOrMMuhOIo0qSpmSbcv8n2ut5Yw==
X-Received: by 2002:a05:6a00:9296:b0:6f8:e1c0:472f with SMTP id d2e1a72fcca58-713c4e379damr15568374b3a.8.1724103797592;
        Mon, 19 Aug 2024 14:43:17 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127add6db6sm6989801b3a.20.2024.08.19.14.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:43:17 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Shay Drori <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: Added cond_resched() to crdump collection
Date: Mon, 19 Aug 2024 15:42:57 -0600
Message-Id: <20240819214259.38259-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Collecting crdump involves dumping vsc registers from pci config space
of mlx device. The code can run for long time starving other threads
want to run on the cpu. Added conditional reschedule between register
reads and while waiting for register value to release the cpu more
often.

Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index d0b595ba6110..377cc39643b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -191,6 +191,7 @@ static int mlx5_vsc_wait_on_flag(struct mlx5_core_dev *dev, u8 expected_val)
 		if ((retries & 0xf) == 0)
 			usleep_range(1000, 2000);
 
+		cond_resched();
 	} while (flag != expected_val);
 
 	return 0;
@@ -280,6 +281,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 			return read_addr;
 
 		read_addr = next_read_addr;
+		cond_resched();
 	}
 	return length;
 }
-- 
2.45.2


