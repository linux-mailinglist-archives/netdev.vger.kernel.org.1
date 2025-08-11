Return-Path: <netdev+bounces-212450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FAB20812
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 13:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF19169A6F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D09B2D238B;
	Mon, 11 Aug 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l05c3Iet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEB26D4CE;
	Mon, 11 Aug 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912551; cv=none; b=uK9xEAswSDxqXLvMbH+ADdogYD7pRnfG0xrOJhHf3v149KoAWwp+Q67scVayh+dO8349zeAUuJkrvnHOYXpcC1ZqVMGEpcmf3sz/VAyz92cSwCKbtTYs1LbzB2mUjSngaJVz39Jtv7aWYSTUZeDqarOv8fxXazMZNNuqw8V6dRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912551; c=relaxed/simple;
	bh=92pnGTQrz+zO3/oreSjFVvco/JJXH5mTHzloKbZEDDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mzdGxfbEy3ykIoVGh5elHYukHUPHRf1/BEAK9S9hqfIeWfUZ9MaZPuRS4VsUzfJQD4QbGsbgDR/6Ye3OiTb1Z43vEyj1rq32mDeY92Nyzy0IB6lTgVmTQ+KaZRicWRA8k9OaMYhs8xNPSV65G240UkeFa0D78ANCfUsbyBatMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l05c3Iet; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76b8d289f73so3810548b3a.1;
        Mon, 11 Aug 2025 04:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754912549; x=1755517349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLOXzas+wSBYP/Dbt2E5ZmVdeWbyYZCVVl1/5bGLwyA=;
        b=l05c3IetCxCkOFP1j0mRs91NrReTdv9PDXl3NYwc1l3f/lzEhrUlJLgLqKhtueXdfL
         aXeqDbTbcEId0kQIB9DkN1EHjJHjvtBuZwAXPzsmetjTayRIViomS0EZTn5ORiUO5eIS
         OUS+uhMuMOpGGEdwhiZD5HlxOQMq5CINZzWiqyr7mZSGsM9I3pOKs4OYA+N9hlKMyt22
         umjNgc8PJV3bWMMQa4fXbHlNeixNVT9yjvU20R86/ZiNm8PMtEQo0ijI14KnEgQ4ewiK
         SYqOOJs1MgXbwT8A+/J184ROJaIkuZMfMuLXuPjMbioKhIlreTuTRyW9BesVbLqiApeZ
         BEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754912549; x=1755517349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOXzas+wSBYP/Dbt2E5ZmVdeWbyYZCVVl1/5bGLwyA=;
        b=ZpiUC11vtnM14zxWCSQ+b2WDgoy8lF5EYt0RwCApZbmFwqPnsAfJRU0jXsXavNWHa5
         8lP+AYr2MOik/fk4rLaY3eYaNhvAhAnBFuPPPs41N2tzQDWThkqu+Jb8dREOrUIwjwj0
         4O772dloQ/DqJmkT4kFMfnPl6VnwMATMJEYRO8ML0lHox9Yqu2CaR2KeXGf2hqAxRJCs
         jRcY1X5tLB510BhOQwxTNEw58CJWuDYA9Ri6D/3c+aBlhafaRzTYAQdEHy79QXZxtEm7
         euT4X5udOl+yqYEGrknYR3AEI4LBiCcmLnJ/Vk9eNe8TWRchIu1GaEUrWz8c7qrOPimU
         b3GA==
X-Forwarded-Encrypted: i=1; AJvYcCWqOQitT+Twz0xPH4/w6RVwJHYgspsh63a50O3buwCJeRc/1CD7oqiXeRlH0BkA4OD3AGF2Q83jhs/nkaU=@vger.kernel.org, AJvYcCXDikMIWwQ0H94GPzt1Wfy4oETFz0kNUdBEx7j56ouHbpBndcroQ2z36wGOap08ho0KCIg9z3Ks@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WbgiT0QuVmH0ohsjt6xXRcWZca85wCK9MGt/Y+gvttpeuA/7
	ydGzZM3Yka6reW/j8yCAwdEDfGhbHBoulziwFRJN4eNiqN5/sqq/XsHefMom5B2w
X-Gm-Gg: ASbGnct98I0uxohGOHqxkrQn22IG2QGt2MymRH+cQLI7Ddwo7AKmjkWRAc5JEN5mxYg
	2CpMDl8TyCoi+CwKsnrFFtrMyFg8RR8pF1GSktoSqliIwZCrk44Hvt2JJvG8BMFpkL0zo+S2BQz
	TRAmF7ma0qLz0bRP4/hXQ/dquNQR9CEhGvoactwMYcAYT5xORJXJ1FGBePHcv87/DLsIRAn1/Ql
	iFngVGFCo/rkAmBGZIxeu8CsZ29gglIiwxhIWxhp1Illo2qIGAQfv+13OPezY4qj09C/kzHoBz3
	hYVPa6WWCDv1HiaDNh22eL0HPLjhW0w6o5e26/5hORzVEihWCcT7LgYV2yWuO0ThVMedrDkHQ1L
	JXnpk79t03XQe1RHSqzd1Tz9TrLbIM/et6aUwzZ56Ij9kENrFZOMZPkzb2JQH0faIsA==
X-Google-Smtp-Source: AGHT+IGEGrseVraUSU22uXaupkDe1Je61Gbat39FnhjpWvLrAWx5qR7QPiB6NlCHNXu5roDejR7COw==
X-Received: by 2002:a05:6a00:3c87:b0:748:33f3:8da3 with SMTP id d2e1a72fcca58-76c461b7e3cmr16458419b3a.19.1754912549391;
        Mon, 11 Aug 2025 04:42:29 -0700 (PDT)
Received: from TIANYXU-M-J00K.cisco.com ([2001:420:588c:1300:513:ebe8:5ec0:cab3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd1d8csm26569120b3a.101.2025.08.11.04.42.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Aug 2025 04:42:28 -0700 (PDT)
From: Tianyu Xu <xtydtc@gmail.com>
X-Google-Original-From: Tianyu Xu <tianyxu@cisco.com>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	sdf@fomichev.me,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tianyxu@cisco.com
Subject: [PATCH] igb: Fix NULL pointer dereference in ethtool loopback test
Date: Mon, 11 Aug 2025 19:41:53 +0800
Message-Id: <20250811114153.25460-1-tianyxu@cisco.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The igb driver currently causes a NULL pointer dereference
when executing the ethtool loopback test. This occurs because
there is no associated q_vector for the test ring when it is
set up, as interrupts are typically not added to the test rings.

Since commit 5ef44b3cb43b removed the napi_id assignment in
__xdp_rxq_info_reg(), there is no longer a need to pass a napi_id.
Therefore, simply use 0 as the final parameter.

Signed-off-by: Tianyu Xu <tianyxu@cisco.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a9a7a94ae..453deb6d1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4453,8 +4453,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
 	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-			       rx_ring->queue_index,
-			       rx_ring->q_vector->napi.napi_id);
+			       rx_ring->queue_index, 0);
 	if (res < 0) {
 		dev_err(dev, "Failed to register xdp_rxq index %u\n",
 			rx_ring->queue_index);
-- 
2.39.5 (Apple Git-154)


