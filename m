Return-Path: <netdev+bounces-82827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A288FDFC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64284295216
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422F7D401;
	Thu, 28 Mar 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDdQyeN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73A39FD8
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624989; cv=none; b=NXVfHkpJom33mxvUyCTafGThLcqKpQ95AbRjBCe9rQMltok/iGTxPtYsfYj9OEc/WUKew2WJySzzXrFlC0miHYKMccY2ptsZ+V/zZ+N9q4QRyEulIEu3eOXPv2Q+tWLAJoIBAhpI2lbJixcd84Z6uaNUO0NLupb6m1XpGnjjwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624989; c=relaxed/simple;
	bh=uivDEJ3UyA5KTnE3G2E+iG6FvC7nZl9WY2+neu5Zf9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mEKGDdYFm9Jvtz9cRAYfZJ8t34BKWoFRQTm3m9j87PYtBISojGBJEpW/fuUlCJqFY1i86bWq3vEdBkO2UJnWDqHbHHGdw20QBrJPo4WWQgKtn3PECAv889x8VbT39Sc7JlIXRMow/BKjogG672kbNZ/jL9OCEnBsvhdJXhJ1fhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDdQyeN8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51596dba562so264194e87.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711624985; x=1712229785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8eXIhQtV/XVUxG4GJO3fUZuDsD4MOMhK+Fb42Xp/Hk=;
        b=fDdQyeN8bM25V78t3dZf68+TBwkUfrm1OHVDsgJ7xZ1oO8V5fzGNrixzkkaFjkqGEO
         t8ZZCQhTM9Jq7bQNvkl7qrgveidynjOcoF7uVXY9Y3J2vj48osoSmfeQU0op5b5K+d++
         iwbjQZ2cXrJzfSsyVQkADWbN1C6xrL5PGLogcLM7/JZAi1b7SRf48lPx1kv7u9UNpUuS
         ppx5vs4JXBb1oR0x8bk1RS6tHd9Gx73sl3wabz5W4PzTUCWTqW1fLWlGYtP9CssD63Ej
         C/Satqacjlt8tm6lLXkyRJx7CW4ZTzQ3OLrYSDBH/3F6sJSQJ1ck97qYejp3tLfhOdEY
         cjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624985; x=1712229785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8eXIhQtV/XVUxG4GJO3fUZuDsD4MOMhK+Fb42Xp/Hk=;
        b=ukXYAPmbtcm5pYN/nEWmL3cSoyUjoKfabNZ98BQNJVWjRG7SWa92TEcV+TexZ43VlE
         UMT4UVW6r0ZLJn3MzRyV5q2oqhiXkVXanNMxjaHboHpacVogTVBkxzBZvtzwp9PXsUKZ
         +jFlgoY8lDZ72yo8+W13JHGGyu0aumr3A5srMEtWP6U5HQI/OYz1mtSkhXUB0rzndlUZ
         G7gDMQ9Ol+Wesf2dHapsGdCJ8+E9uoiy/y3SSyaueapfhuzrDlXvc8/gbTD6NDcG+Mat
         vXx3tY+KcbDTHxqYiR72l6xqr/mOgDbEJeDFITJO4aqA4ISROuurlNtv4JfOmrOrrL5l
         cxCA==
X-Gm-Message-State: AOJu0YzcFmPu2ncGcjZJA/mYf8FGbEpOJGvT81ZK/YindZYfZezYl7qU
	WKcFX2VgCVuCZW6CRC2GdPJKMnTr3BTsodyRquZol/FjZiFVtnV86i4du8nrnVf6XYwx
X-Google-Smtp-Source: AGHT+IHqS3EUw61o57Ee2U4290gFA5pdeKRGgQrFI8C0evvBx5FfgfBFzCL6YujfG9NVw+doPZsF1w==
X-Received: by 2002:a2e:b0cd:0:b0:2d4:25c5:df1e with SMTP id g13-20020a2eb0cd000000b002d425c5df1emr1739849ljl.5.1711624985086;
        Thu, 28 Mar 2024 04:23:05 -0700 (PDT)
Received: from localhost.localdomain ([83.217.198.104])
        by smtp.gmail.com with ESMTPSA id f16-20020a05651c03d000b002d6c051d299sm194449ljp.56.2024.03.28.04.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:23:04 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: [PATCH net] RDMA/core: fix UAF in ib_get_eth_speed
Date: Thu, 28 Mar 2024 07:22:17 -0400
Message-Id: <20240328112218.16482-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

call to ib_device_get_netdev from ib_get_eth_speed
may lead to a race condition while accessing a netdevice
instance since we don't hold the rtnl lock while checking
the registration state:
	if (res && res->reg_state != NETREG_REGISTERED) {

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 drivers/infiniband/core/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 94a7f3b0c71c..aa4f642e7de9 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1976,11 +1976,11 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
 		return -EINVAL;
 
+	rtnl_lock();
 	netdev = ib_device_get_netdev(dev, port_num);
 	if (!netdev)
 		return -ENODEV;
 
-	rtnl_lock();
 	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
 	rtnl_unlock();
 
-- 
2.30.2


