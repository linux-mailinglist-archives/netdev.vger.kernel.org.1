Return-Path: <netdev+bounces-234357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC88BC1FA2E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D331883741
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15E313552;
	Thu, 30 Oct 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVn6MkF5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B23002B3
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821393; cv=none; b=g8T9cqPPaPd96sAuhULlAlgH6Db5UC1P1V+TySdlsUTR1uZ+1kyMT0ZhkLPja6RYwvM/491Agu76B6zqRpd7UWeDkBSFahckNDBanIDdO98rR+R4uj090pR8vLU+MxRUTHEVpEADos/3Ce+NxM9kS+s3rH6W09kXqNWjUh2Z248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821393; c=relaxed/simple;
	bh=VTIGLJoqL09T3qdqKCWT95vPfPOyfhp3sKIJURo8kec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jb2KWDrFyPbt3yLBwlsLDB2Z3FAdz2mA1QI3ARDURc9TzVv+FGFZJrhG2NQuZcKgi1c9RC/6fXrnk3EbyolICyROlwxtAsNk1h9+GKOvuT2A1NeTwmsa2+ddRg5HR7u7QqJYO7fq0DVVUFS9mP2wsFlnD3cnilMdFRAPdpn5yAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVn6MkF5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a2852819a8so865049b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821392; x=1762426192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3p2yqAWOCqYWEXlmFTpGQJoAadTNkNOwJpC5qXOYbs=;
        b=PVn6MkF5bwbrksfoO7vlX8x/1JzAkAOf/4MbPNeeb3558hEBSyEstX7WP+fuyy8dGe
         +lSt2nL4K36uzzbfMWgbrv9n2A/JuSyJ+rrG+l0YILSmP6BUTV1z9JY9gPRZie6C/1p8
         BmP2O0k2d+2GcPKXFKBLdH4C0JIWrt/EBtC7tEf8EHWFzCLR/fF7BYchlMBtmWf0JKSH
         GjSgLXwRVbD9WqSX7ERxzw0ivWQTpK8oW5H1mo8urSVbxPDuKlwh5DlgEMNXKyhuuFjs
         Y970H5fbV13iScc4HnGtM+kBCzJK3dmEZwC/suGQskNntYQCWlg/WW3xmFEOr2Im+ybz
         UT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821392; x=1762426192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3p2yqAWOCqYWEXlmFTpGQJoAadTNkNOwJpC5qXOYbs=;
        b=Xp2y+2Yubz7E/Rg+hecSpAXLUnk+t1vrB0KR9tFpw3BzSJRwJsWFnQow+CZeaSLuLx
         vGM8H3OE6xIGV8C0I2kaMDJ8abbWkk3/+jFus2+fhJbqvG06Ny1Gqj2iFS1FS3f2Pw3i
         ahE4p6Fk2dz023NSUTnonvoCqrjnyXv5zoxSFvHCWqCCGVTSKEelNnn7UNFM318iyo7t
         RZQhPp3eYKgh56sConcZiUccwSqikbBoRUV5VQHI3oerjpMRMJ94wOabaH3+EpsEO5uN
         YQHvi7XldHxod4I7XKQ2bRNadNraP/N8G3YbhAVxAKxS22qw6hu/J0iX9SVYhgEBip2g
         GTuw==
X-Forwarded-Encrypted: i=1; AJvYcCXRrxbLvxMjBl4ftPY/x8NdcZg26rOZ4/PF6MVAZy9qY66Nic/RQvraNmKi31Jg7qWhpiBnRoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeHXT5iSiArqzvqj/Of6RCmOeAQTGHo82v3E5uYbOcDu1JWAK
	xecrF7XfCEEuO8LWyIQNllCJazuSH0ClO/DZsw9brTBGUM9KAm97Cdzi
X-Gm-Gg: ASbGncuiPBl0qK9bEgS+ImWpGx9y7y9MgYWZd8UlT5xtlngJSl48pEJC3KHhha8ms/H
	sXKBXefGTIDEgfTueVnR23ysAoHTvnvWzFKSNOIpx35pC0a4lCgAAY52v5FO1N9j/RsnzcqXG9k
	DdrEUzeE8Uc7kGI0M8WQMJStZxYV/HgXTYvHH1EV82xkJ28tZY84sZfrP+3jQ6NZgwSpfVx9qCa
	Ru0D9C1awugskAy+7Tf/CSQKW83skmTa7NxDOdONwKEKcTx3Ivwe17TgUEU+gzahWvtgDc8J9gk
	fOtphsfT3yPFjLfcJq+Dw1FI9ZAn8jnuTSTzDxwSAblUkp26IwdYV3kLqJoKBDmfcmujj1dgGcc
	hjt6h5hQU3YGKUMztc2UKvez4aw3/CFo5rzWrueAG6c9qatX7hB79f1zTUDk2AWc4n8zMctVqje
	np0KA8G6dr36WP8GGJXuG8/g==
X-Google-Smtp-Source: AGHT+IGU7fXKMPGFniTXJxT+Y1B4SNOc8ney/kiF1ZfNDyydbRHCeKanSDnjrz8dd8tokm2NLVK8SQ==
X-Received: by 2002:a17:902:d512:b0:294:ccc6:cd2c with SMTP id d9443c01a7336-294dee491f3mr72004445ad.22.1761821390964;
        Thu, 30 Oct 2025 03:49:50 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d273cdsm181053915ad.55.2025.10.30.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:49:50 -0700 (PDT)
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
	stable@vger.kernel.org,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v2] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Thu, 30 Oct 2025 10:49:42 +0000
Message-Id: <20251030104942.18561-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
References: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
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
index ad54b12d4b4c..a32e1036f12a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -474,6 +474,10 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted lower driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
 }
@@ -498,6 +502,10 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted lower driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
 }
-- 
2.34.1


