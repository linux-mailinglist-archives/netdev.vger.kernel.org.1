Return-Path: <netdev+bounces-123510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F47965225
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD731C23293
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3BF1BA278;
	Thu, 29 Aug 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PyZMUphq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9118C009
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967570; cv=none; b=fbInfGcHSAGn7mqROnI3APw7TeIayzHc07udXkKybVoCwGaNkA7NMytxwyoSLu6Nyv+MwHk3OpkuoFG9RR7rcgWEUVZtdlYMUsjAKRhstmND0QI/fGYNWc7cI3zABr6Gy/J80BCLDqfdWL9L/1mzsg0luOJJCTwxH8p1B0ml9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967570; c=relaxed/simple;
	bh=xWmQ1OxqFQz7lf6SRBxNuo8JLNOt90S3oTCefaPSYZM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WM1H+3c3/gE/knTYrx5pIS7cInP36TTeH/1wYIL+N8514Vsf1Lo9mRi+43YM7DioxuYuSq0NKaLrdQte8iif5RY+fjeh9cn69FV/ZIWAn9a/lpv37EJDAdVM9vSoaBtm9g0Pu4ApCEKkmkn4X7jjowfDAAXQthPVBCLKqvdggF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PyZMUphq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd9d408040so839922a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724967568; x=1725572368; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KcJF8QQgoMkUco4enV2ZPS1HMzsxznWZ0pCfKEnKH8=;
        b=PyZMUphqwF9MO4qOJ4M912fcKTtBIzSrNImkl3Wap/tCM9M+WcnP0fH97HUoLackI9
         iUYLCboWvuejF2ORDcstJUYQKkqje9UBut/6B5M0e0nvc11Dk3tUZp/3HxYy4EK6u6eF
         dkFrbTjc9+Rcx6jyqeF8hIOJPmBTsmtxhCCjmdxg3Lg+wsfSVTgOmX8PT4C6M/Fmk9Bi
         gX126hjAZ/Y97gTGQK7RZQpF4hkqfJsTYX0yEr1wBRn5OMJXsxa1GoJOAy8VB9vkJETK
         QbwdoR7R1BqNNCG6TJmSr11dFtMaf1NqsGvoWBnj7kd9Fu6iFaAT4j8Zr5mHlutwUhGB
         JI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967568; x=1725572368;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KcJF8QQgoMkUco4enV2ZPS1HMzsxznWZ0pCfKEnKH8=;
        b=IMdieYkEk0UuVnTgjjJpjx7RLwMweSK13eRkE/++OubNdk22ayESdKUfTloxlOO2JB
         UWDTDYnkTAxiqVvqSK8W9maM1262uDwuiKSA4mf3m+P1rrj8p3KbdWh6auu8HO6bidBV
         95sPhBieYapO7W4fFyoTgf4T+RDgDDxsryW91l7oSY8LL6aCHWccH7wjIWCjBZR3Aym1
         /nJaP5S5HDsPFAVWUSlp24UBlIaiHFNLPglkf2URSCnB4phTJnWNuQ9wmm1NIhqxJeOZ
         entU9D15eZWlRw+nlYkwGW8zZ9zMmU1cEPFrJ8n5bDrcZu+E2308EdGvaHEWFxjrEV0i
         8s9A==
X-Forwarded-Encrypted: i=1; AJvYcCV615kHqsVrXhj036cDPFpA/YcSLA8nnbuvbcma31+oROv6kMQDgWr8p05t2s3OsXY931Ns63o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbB89aOF87ctQvj82NbkKvTHQVpIJBqT94zfCejj93unqJwLy9
	1fgLXnQuqC0MHaeXkHtY9vS5VFU7AIqGF1piUxz5nId7gKY1EVZ3PnkNViPyvWo=
X-Google-Smtp-Source: AGHT+IEcXzUs8FoS4L8k0/z6Ku0YobbN9cwTJiImNRR4sdcXZ0Np8BqHyO2j7RLzFbPZpoN7+TDUlg==
X-Received: by 2002:a17:90a:fe8c:b0:2c2:f6a2:a5f7 with SMTP id 98e67ed59e1d1-2d8561a16afmr4896336a91.13.1724967567904;
        Thu, 29 Aug 2024 14:39:27 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d84462aec5sm4705298a91.32.2024.08.29.14.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:39:27 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: yzhong@purestorage.com,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump collection
Date: Thu, 29 Aug 2024 15:38:55 -0600
Message-Id: <20240829213856.77619-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Changes in v2:
- Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
  usleep_range() should be enough.
- Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
  iterations.

v1: https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  net/mlx5: Added cond_resched() to crdump collection

 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.45.2


