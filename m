Return-Path: <netdev+bounces-137679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E22D9A94DF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167B9B21506
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC78287D;
	Tue, 22 Oct 2024 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaQVuxJA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BD2BCFF;
	Tue, 22 Oct 2024 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556570; cv=none; b=CRdUEg9ouSvAu4ZGmJLVhGlDy9hVdZpYiTX18P9HDyBcEi3a65KUt9FrZVPoDsbQb8emAQyIHmx1DkBbmWc0gpAPrTlLZiK+GXI8CtK5HsS2W7bHdpcc0R5Ax6hXtSBfXB3podQc5txR/ocmwx5WVyvW/gn0dKeIEFtqMxgwA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556570; c=relaxed/simple;
	bh=kU9Qfs9jHR+7O99NBlCk1pShL5+gWZ4kBLat3S5g6Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=loPGAbVtzFqcLW447MhrkFg39uW7U7IGuk3Go/+p3XubZv+yBEBnih3boB1wDxp7CQOQeZZDtbfxbeYBrlRVXm+RvwAWZy5Eck3eII00X2fUEJsTXk1M+BmtUd0v2Dd/l2oCeAqs1lPLfc82s4iENYqGPs2a+CnpyTURq45DQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaQVuxJA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso3340312b3a.3;
        Mon, 21 Oct 2024 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729556568; x=1730161368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELc2VNfYGfCeK2UF42Ln3Fj3tKuv/pEZ7/0ve5/dU8o=;
        b=GaQVuxJAB4xyapM4KcN6bYE0UkebKR/PwrAv9N+8ojLq4QBKfPnovotx5ZFI9VNiMF
         aj7pn81uG6TjSrmad2yiNWPlxxAOVy3lhTj8oAXUVPYIDLmJGgbMSBHxD8mMQftRbpDH
         if5yhciG7d96wXbE1aqE8AFb6KbWsr2nxswo3WZsiX9o6wnMAauslb1x/24LEvC00CXs
         +n9fuwaXtAGZJ3rBYfRMJ/tC3JNFYd/PyboljyKZEwepd/W55bxitshFIE+x+AYv61Zn
         TzsF2uJPzIk/BNxsaDI3Ww2dBwpR/zF//cbURgkSAnWA4cGmZ2WF4WWV+I451CQ761A+
         FoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729556568; x=1730161368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELc2VNfYGfCeK2UF42Ln3Fj3tKuv/pEZ7/0ve5/dU8o=;
        b=gOg0UtTspKS0gqCXXi12xzk+zp2LVDdu88dHPVAzLICTdPlUCpAQE6ZxP3rC5L5n6W
         yu3j5Os6vjONZ/S47YyddkXg+LyhLcd3erT4+wf6oksFuV89ytaGyumuBt8nx9ack7pl
         QcqCjZgemGOknnN/wwPjRaLxg6OnBRSiGM/dZZPIuByENc2fAYrG5Am/TI5zG9XOjDiG
         eM3pb6fTz7DVvN6tq6r1pz3lWpROfaUG2qzVKMYpYxj3qJx3BZH2saGA4aDVkp2yzJc8
         GTqMjr8VD+UDwwUJPNhm5iE5zahxVBk2teER9TGXnY2oyL5Vi60zWOYN/dNPh3xuZG+R
         fosA==
X-Forwarded-Encrypted: i=1; AJvYcCVIC4l/4e8Du9NTRdwMh9S/P8ufMNBDwt8YX+Z+D32y7oHJAYsDTotg+XxRopowI6EC9YT+FXvw1tezh+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXkt0vPCv0h35p2JaNlDU6G4b84R6RVJ7PtcCdgaEr9+lH1EY
	D9eBZ/30/chZqGJtr5ElGWRtvO42nL3HlPVM2Hb+iHJZU5ga/ZtYosu01MB+
X-Google-Smtp-Source: AGHT+IHFBP2mhM0NByDq44BULF5QWXLyzJB9hTnq/zptRd7s5shJfDpgOzS6rZ7nWE6xpRy7IZlopg==
X-Received: by 2002:a05:6a00:2196:b0:70d:2a88:a483 with SMTP id d2e1a72fcca58-71ea2f31fc3mr19997612b3a.0.1729556568013;
        Mon, 21 Oct 2024 17:22:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3515828b3a.46.2024.10.21.17.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:22:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv8 net-next 0/5] ibm: emac: more cleanups
Date: Mon, 21 Oct 2024 17:22:40 -0700
Message-ID: <20241022002245.843242-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on Cisco MX60W.

v2: fixed build errors. Also added extra commits to clean the driver up
further.
v3: Added tested message. Removed bad alloc_netdev_dummy commit.
v4: removed modules changes from patchset. Added fix for if MAC not
found.
v5: added of_find_matching_node commit.
v6: resend after net-next merge.
v7: removed of_find_matching_node commit. Adjusted mutex_init patch.
v8: removed patch removing custom init/exit. Needs more work.

Rosen Penev (5):
  net: ibm: emac: use netif_receive_skb_list
  net: ibm: emac: use devm_platform_ioremap_resource
  net: ibm: emac: use platform_get_irq
  net: ibm: emac: use devm for mutex_init
  net: ibm: emac: generate random MAC if not found

 drivers/net/ethernet/ibm/emac/core.c | 42 +++++++++++++++-------------
 1 file changed, 22 insertions(+), 20 deletions(-)

-- 
2.47.0


