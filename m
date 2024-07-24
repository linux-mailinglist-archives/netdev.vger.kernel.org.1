Return-Path: <netdev+bounces-112709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C9593AAB0
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 03:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FDE1F23781
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD86C138;
	Wed, 24 Jul 2024 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRlgJSf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621AA1AAC4;
	Wed, 24 Jul 2024 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785640; cv=none; b=dr0QPOpj6VkPzFNUBQTGUbcgloVqvBCFMec9gHWGYIbdpuvqdkGwvG8SMj+LUpoMsOKrc9Wcc7HqLmq4UIqBhXlTxGT9qtY1RRi2gZrAbYpyg03iy6AGtAG4JBw8Gygfy6O1oFERYdvhSBTUue1gUUsQ2TkKqSUpZEMMI5dBsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785640; c=relaxed/simple;
	bh=c3GncpxPZcA1taNUudoTyAcqB+R4JU5v2hVYCyR26mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsEwm59/EZLyBH7qpHzNxmKI7Vy+4FXw4YbwXBRCC9/AGSjcFyqcpMig9QfVDdmJqZOSqV2U71XJBVQ92KSGzahX90atJNgwCQOrAKsaHBtnuJe++lEvIHkDOTL5ncDGAjxtn+QQs+VSH0dJ/k7HToST3EUnUCNPip93X0uRXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRlgJSf2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso293987a91.1;
        Tue, 23 Jul 2024 18:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721785638; x=1722390438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzoaOAE8mtc4ll9mWUV2yqA7g11y//aTQ0G+wfCrhNk=;
        b=mRlgJSf2J8jfus5pRxHfp/BLzYeTIIKMTEsnH/M3sUvSxRms9wbE5m5SakYRuHKqkB
         7205lsCrYrpK714bR00te+tXmqj30lSEfQHcVqfV1qwcrY7mqMpo4Rj7aiKiQHifw6Fd
         rIQsfmPDhOJJMn/oRHwrAYXvj4QtDj3mh6IZdBAjZracitgGmNN3eanv2IMJqA2bDQNs
         EbLGPb8EoMHfAuGaKA8dpPEeWPF9RsC2xYEXYMdAuZO07cEM6iyRw9VaOoBggtY9MMn6
         dNcraBaL9VOHkWAZQdetJVZI+Ud+eDLI/ONTgzQDO54ISJReQQYTYuaHdD8zUgX2UGsj
         U8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721785638; x=1722390438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzoaOAE8mtc4ll9mWUV2yqA7g11y//aTQ0G+wfCrhNk=;
        b=tKsIe+KgHJn3BHSZatUKQn9v0A1gUuX89BGC1lDR3EuAUwvueJrhz86dWt4BVwQNv8
         5mL54zCMFlzSOjdPgxO/0BCEm/5L71QdFZQpe+W27vNtrsCQDnOJX+biycygHts5oyI0
         pQpOd1OzFFJfheQAXVkGKOcNElRWL+ac8Wi15/Evf6pqlZ1Z9/GaXLnxmQw9qDc31rah
         mcR+vejr13LCxFoX5K5qFyZBTimfNeDg3rr8XCOamOk7REkhFhp8k1vbJfl15xsywDXc
         gu9C/VJnaCA4dC2WLDV+ws2Utm8hsC06sxW9pnR1anTn8ki0Ayj953tcuCEWoEMDO2Jf
         4rZw==
X-Forwarded-Encrypted: i=1; AJvYcCWKg0INRbgcsBYgRI3nd6bLEfc6n9hSczK3MNEPcNwf6p7hRwSbndOza6q0PqRTbnzprwwlZGaeOuC1rKCIgHcLVqvVIYjYhrq0m/aC
X-Gm-Message-State: AOJu0Yyg0ajkN1XUiD+i1ZkJW4krRKiettEGwAQOLFy1aVO/JoiFd3y8
	qgjlSSC46FDU/wMWDJvpgVm5hBxR39K5XR3ATc77V8zdwLEvEi0Kv7CHySiK
X-Google-Smtp-Source: AGHT+IERHuUZtKUvDN6QlVo1a+k+ACP65aDBdLCNUACZKnA1Cw0PbBgvOz/ps4ZWrTlpsQxKn46yMw==
X-Received: by 2002:a17:90a:3484:b0:2cb:58e1:abc8 with SMTP id 98e67ed59e1d1-2cdb941f681mr635135a91.21.1721785638297;
        Tue, 23 Jul 2024 18:47:18 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73a5f5asm314564a91.8.2024.07.23.18.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:47:17 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] net-sysfs: check device is present when showing testing
Date: Wed, 24 Jul 2024 11:46:52 +1000
Message-Id: <2a96f450e4150e9b8c39fb000d82c17987c5bbc5.1721784184.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1721784184.git.jamie.bainbridge@gmail.com>
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs reader can race with a device reset or removal.

This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
check for netdevice being present to speed_show") so add the same check
to testing_show.

Fixes: db30a57779b1 ("net: Add testing sysfs attribute")

Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 3a539a2bd4d11c5f5d7b6f15a23d61439f178c3b..17927832a4fbb56d3e1dfbed29c567d70ab944be 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -291,7 +291,7 @@ static ssize_t testing_show(struct device *dev,
 {
 	struct net_device *netdev = to_net_dev(dev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev) && netif_device_present(netdev))
 		return sysfs_emit(buf, fmt_dec, !!netif_testing(netdev));
 
 	return -EINVAL;
-- 
2.39.2


