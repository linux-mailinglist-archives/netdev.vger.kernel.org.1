Return-Path: <netdev+bounces-83702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407548937B1
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B496C28153F
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE101362;
	Mon,  1 Apr 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuOYfZse"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B46ABA
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941027; cv=none; b=By4EUbMNlp8svjYZb73YbMbZbF7Frnrjx39GfzMSizGJIZC7QltXFj0RKbVffsROPRvhfhFHHGjZQWoBktUfv4ngDXg7J8D1VC5/HZgH+mey4kylqU2TW/kvR0a/baPiNnwz0xetnQlwhGwDPB6AFNiTHlwVGMYkQUtg2NxeZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941027; c=relaxed/simple;
	bh=GO9Bi1wFuxZ0JKZOfZEoYVEb2v5ZwyPeqUxWOY9JwwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQXrLSjOnH0LUwWvMY0jrvypuom9+gs69moGy+pIGSWGP5ewdZsmf1i/AON2Ocp0Xg+4T80hXVjaruUK/hBKN0FfugPj7Wzppzdw3CeEk7l6C0/fd/PSNRPws1R2FGuo/rLaBEFeyaQoualmdSr9H1R6vFNi8Bbt3IAs42EvMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuOYfZse; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e244c7cbf8so6704445ad.0
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711941025; x=1712545825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta6lFKix1FeG0oCBnTR9Exq62WqMGnwL+ghoDg1tdM8=;
        b=PuOYfZseQBcRiZhq7YwfbyIpCOw4upNxnS7ie/fcv9zcUEm1lib2RjwY4D+Z3ePijV
         dl/NyZCTLYKC0mMzE2WZv6bvG5U1+ucoYwJHKJeGZwmrM7eYfWP1HR3SomWoCLevdESZ
         jCt01DQek/5Gx2cVYXXP5TO7UBBM8qKRdW+ttDV7C8a49U4HI8TgE8yyGAHNYIWxAKhs
         jvaV7Hqe6MM67M9RFfORAYZl+5arpzGdesR8CcF9um1xWbsK7spQTCp4vi9+he6pkS0+
         nb6NzLG5aZgJd+Y3Fgk7zJr04jzzeyrbjYqWVNwka3hsdT0ew/2VS/Og2J1huspDXHAf
         NPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711941025; x=1712545825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta6lFKix1FeG0oCBnTR9Exq62WqMGnwL+ghoDg1tdM8=;
        b=arawwqNIbT4gClcqRF+UXFD/I2IpHOHs+9NPK7Xp2OIc1SA/k0l5j1KmbtCdbb12Ns
         sboBG6bMzxb9/L597q1BHKXT2P7V+uh3Vm1PfSFwExGCJimu5wQwfpepHnkukkiAfKpc
         sXsqQuRnsU3CxWsWUxdmLo6ev33nyk4y6PkrgS6HAmzBE/iK9UKtujN2kIefYVXKNkUU
         3gHat+9x3wKfbYLZoXC4xyg0hbtWPTtP7Ihojd4wjMtQ1r2KHEMAvHa7FzZ+kw0vyeZx
         GbtyUVxOM0M2dfQm1keKw0loZscmvlz7HHIxjPCOV3EaqrhyH2xsl82M/GmZW98MnBw9
         6Weg==
X-Gm-Message-State: AOJu0Yz4lUJZWgfRt2octZeTmbLcjlYWhy04VvH+mtWnOTZXbBXObiOv
	k6bMx45h7hHrFGbGMUxzOpvDluLyzEdqwWEywJrR34cZUNPptWbmlEDmDp8HDUrrjg==
X-Google-Smtp-Source: AGHT+IHohQvKnjAhnqVtxoklxZ8D0DT5fXe72oZIxsl8ulCF1O+O4McRmJMJJSct+lr+wjviEtl3pQ==
X-Received: by 2002:a17:903:181:b0:1e0:c91d:448e with SMTP id z1-20020a170903018100b001e0c91d448emr8160013plg.65.1711941024729;
        Sun, 31 Mar 2024 20:10:24 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e00ae60396sm7807464plk.91.2024.03.31.20.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:10:24 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 2/4] net: team: rename team to team_core for linking
Date: Mon,  1 Apr 2024 11:10:02 +0800
Message-ID: <20240401031004.1159713-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401031004.1159713-1-liuhangbin@gmail.com>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar with commit 08d323234d10 ("net: fou: rename the source for linking"),
We'll need to link two objects together to form the team module.
This means the source can't be called team, the build system expects
team.o to be the combined object.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/Makefile                | 1 +
 drivers/net/team/{team.c => team_core.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/net/team/{team.c => team_core.c} (100%)

diff --git a/drivers/net/team/Makefile b/drivers/net/team/Makefile
index f582d81a5091..244db32c1060 100644
--- a/drivers/net/team/Makefile
+++ b/drivers/net/team/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the network team driver
 #
 
+team-y:= team_core.o
 obj-$(CONFIG_NET_TEAM) += team.o
 obj-$(CONFIG_NET_TEAM_MODE_BROADCAST) += team_mode_broadcast.o
 obj-$(CONFIG_NET_TEAM_MODE_ROUNDROBIN) += team_mode_roundrobin.o
diff --git a/drivers/net/team/team.c b/drivers/net/team/team_core.c
similarity index 100%
rename from drivers/net/team/team.c
rename to drivers/net/team/team_core.c
-- 
2.43.0


