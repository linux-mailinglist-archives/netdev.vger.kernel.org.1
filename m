Return-Path: <netdev+bounces-234316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47593C1F53E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7FD934D8B4
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B933C508;
	Thu, 30 Oct 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP5we5U6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A825F98E
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816992; cv=none; b=IMFO3mxF0ac18WvRommAKmb2RW3wz2OvAfG+jglSkGflfQzv9DzW6z0OgJQyo0ayUl+8sPKlu/efoxBUIZI3OEp6+g5P5cjCNJyMSTTVEoOwpfhfOBGQmktCZhEyypcX5FH5jJ/ZJQR0vxfYLWc++PmjRzOcKF+wLLjuw6gansY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816992; c=relaxed/simple;
	bh=sfqSbMdJvCJp1YjMxi5hsyF0u2V6uwNe3n1xaSR62Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGzyNUX2mCYii8I7cPZTMQLJgf37G30I5ZCOqcMTtuUM9NDZD5VUrdFXkEfUvR19HFvvk++8rHVRCDUhRF9bKT0KEeXOBN5xtkaoR6obEZ5pkuNivIKz94REg+5FN7UrxFkllsQM3SzXGXWOm+YMWvDL1pyeswsbQljHTjodhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP5we5U6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so829477b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761816990; x=1762421790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAGiv6sfeXhaN9XGho18iG32VKPlMqvx7GJaQfDv2XM=;
        b=UP5we5U65nErVbz2Uyp5wIQzvu50EDf/ELjv6em+9jP7EK6b5oFWJnty0rz6R37ose
         pD8RrnjtbB32I/lOIDtznAt3cAw/SJDUUN+4B6uzmuo7reqegolNb2TuuGcHfFBuIlsv
         vprhz/DcomVkLcJAeHb7+fB+xbs8grfOYeQTyUHMJLSX/PCcr3YkEq+h7Ot9QPqvZvxZ
         8xtD6Tal4ogeClGXJQp/n1cFCmyLDpbLisTvt2BnV6SLGePoktQuYzNQ7pLLNhahRzFN
         B5Gg3HASIJxN2pfMVj65znfcadySnFaRRcR9XqzNd4YDFljtEcwl+0Ujf+eNtH/MUY1D
         WFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816990; x=1762421790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAGiv6sfeXhaN9XGho18iG32VKPlMqvx7GJaQfDv2XM=;
        b=Hgk1DlZ0XfR2+PHaCEN0qfwppMXruOQ+HDJag0g6/fWaakmUCb3FFDyqSO4TL6BGtH
         MX1Up9pqdMePhKZusrs5tyTHz4MIeLXnpBxOPTkrZno2toxaX9nPaJEY+1WTnrcNa7Hi
         ajIZGuSeuW3wPwVuC6wz7ejw8hN256MEpCubxgy7dh+LzkrqSgQkOYhGpoRFEBX75Kqh
         hTYJ0rQaBUmRRy3lHGloZBUbBAkUSB4thfZxYx5HDcGXVNQ84fnz1Tyjwnvr/P/PLUn3
         4cZGhbb8nymg99KLxYhGMaG00xbuu6qkKjWan3h4RNRHpyUwrL+5mW9xcL9TwV90UJJ+
         wWnA==
X-Forwarded-Encrypted: i=1; AJvYcCUlC+JBsInZTbrNA/SxM/mEnhcCkD6n2NLPVg9W8tZ3E9C0sMLZX6MKjc5SY1rIrfT4nl2Vj/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLERodap6vcIJjJVQgaHkzbivKWu8qYo845yBcgToZclD5oinB
	k2eFb4wp2dmlo5KQsT2p5hJg9301t5DSfTJnBgBTGanr7dGIJ9a0umwN
X-Gm-Gg: ASbGncsuHQHVNf3z4hImcptlCtvhmDDqJKnS7vFLrj2Y+xoacYNo4OxW06MlC22GXp/
	eJoeGYuCAAofo01IehmDuNGHtUN8gBgeRU6OckttoJwbkDBFsj14ACTNymPQ2U10lvRpDT9LgU5
	A+LxWQXzXU9DwRtA89XUTEkHX6zGIBjazryRXkbm8FfC/RjSxs2h5W53EBfhioPhyZUH+w7jFAF
	GwG8lrRFxjjN8CfRB7MoesQlqnFn+a3kBba9mBtwj/z1HYGhJ6LzYFhVewZqiA6Xs6/5KotEywm
	idyVDrjmmXaCeiH6D9bKcehaObKX/KYCN+0XTCntwoY1G+avzpJBBmWUCG3hHz7BA+Zbvw7QH+j
	gN6QOGNgjidTxONywyJuvc2hE3iCSIK4cIjZzwLufouwDdEe7FL4SdzP19RHEE8bNUtPzRtXvA/
	62g8NUbiLsOZB1
X-Google-Smtp-Source: AGHT+IGdKogiwWyOyyIFYlPsQ9DYU+/bEn7Q1lh9S2aXq6iqPoD0yGhRazUW5aaRnUgYkm8dLjuIKA==
X-Received: by 2002:a05:6300:210f:b0:334:8f40:d6bf with SMTP id adf61e73a8af0-3478768ff1dmr3641729637.42.1761816989410;
        Thu, 30 Oct 2025 02:36:29 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([123.124.147.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128885251sm16003643a12.17.2025.10.30.02.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:36:28 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: kory.maincent@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com,
	stable@vger.kernel.org
Subject: [PATCH] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Thu, 30 Oct 2025 09:36:21 +0000
Message-Id: <20251030093621.3563440-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
References: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool tsconfig Netlink path can trigger a null pointer
dereference. A call chain such as:

  tsconfig_prepare_data() ->
  dev_get_hwtstamp_phylib() ->
  vlan_hwtstamp_get() ->
  generic_hwtstamp_get_lower() ->
  generic_hwtstamp_ioctl_lower()

results in generic_hwtstamp_ioctl_lower() being called with
kernel_cfg->ifr as NULL.

The generic_hwtstamp_ioctl_lower() function does not expect a
NULL ifr and dereferences it, leading to a system crash.

Fix this by adding a NULL check for kernel_cfg->ifr in
generic_hwtstamp_get/set_lower(). If ifr is NULL, return
-EOPNOTSUPP to prevent the call to the legacy IOCTL helper.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Closes: https://lore.kernel.org/lkml/cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.dev/T/#mf5df538e21753e3045de98f25aa18d948be07df3
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 net/core/dev_ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index ad54b12d4b4c..39eaf6ba981a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -474,6 +474,10 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
 }
@@ -498,6 +502,10 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
 }
-- 
2.34.1


