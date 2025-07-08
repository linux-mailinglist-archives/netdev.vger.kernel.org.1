Return-Path: <netdev+bounces-204891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB75AFC6AB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C646C17AEC5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB332BF015;
	Tue,  8 Jul 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etIMp8h3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95469221554;
	Tue,  8 Jul 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965498; cv=none; b=LSgWcvOyVTopMc4BdlknXxCXuOH2CnqgXbeIQ7dtCecBL1elPFtXld++3yCuEpItK7jXDSovN0puO0k7jT/f3LzbteLFt8MJX6PbAwDhGx+6gnVyoMTKuRDjYdQR61pgo5OBtzvmdpl+xm5VJ18yi8Se5FY+p/LphPhD6mVHmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965498; c=relaxed/simple;
	bh=uK9rTdwq3+SmTytorDzAkLiXBoHD6ucYrtal0yWA/T0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g0LlRH2Y+ltitj2+hvRwHDF6tPL28n9KUiPx5z90L/Qlb7dz/LVgCMrRNjiLWIGL2s95v33x3NTdL+t4afLobdm/+AVL70OfL2z/AhwzNMZJ4qq9opHh5zEvQ3hp+TmfBJbmI0Ap75cFgk2neUzFskrkqAc3/wViVqp+dIca330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etIMp8h3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234fcadde3eso59890125ad.0;
        Tue, 08 Jul 2025 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751965496; x=1752570296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xycfwvqEgQNdhrxJZBBX+1ZZOPQm0ZskYOsUQsGWaC8=;
        b=etIMp8h3aPzH+92XWlXrNzI1q+mlkpTr0pU1B6qx8AApNnR3dLSYqBa0vqbAnUjZdA
         whQZisa7rgqHZtS/xrAlXHQa/OVaBFhMl5ey1jPdusklWf5u0toF1BDTzmZdKimPO4Wd
         6IJQhgBlv1t+E6pmxIpGLOZ8GQu8OrxQZeR7iyNUSV4Mr84dyXXhSO6pnjPUJlsGr7xs
         qA6sEwf9bg1fAFPuBPJnLEiEiu3TKCL3A6wFvYSIJ5nypoQDhJ9RRuNHNYJHAHZkYxGl
         GMUs/Bd1rBFWATkRis/OxzNu5+FZc7YHzeowgEeFH6AJcR0Jvs6j3gQNK9ift9bx/8X7
         7xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751965496; x=1752570296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xycfwvqEgQNdhrxJZBBX+1ZZOPQm0ZskYOsUQsGWaC8=;
        b=XtI4QfjSKYzqh+YdyJKM5ucsy4ZLByDoiU2PaN/MBSSvNSuBqlVS6H9m2qOEpHXXwp
         xKwhHPHk+yX8tXtIDmx1Y7XSVXr1DCbBIJtIouYOkCDl4+K2cLUCE5HjI70ijRgAI48G
         s9t0VegqdepjVP2AXg25nZl79l+izomPrQbNFcUf3TZlz+YMkAuaVrwRNBSP5RfYiiw6
         6of6l19aEdwvu8QII/RELUX6OhzH1uJ6omFqIq190TvAyIdn/9h4Q3oKm3TNO/gYP6Mf
         q5qIqffD8bGXvlJYCWr2BFE4yjlDO2z54Rg+tFg+X6iZRUzpABpWLQeXcNj9+XfK/NYs
         Da5w==
X-Forwarded-Encrypted: i=1; AJvYcCUvlsNNqe9lEgk6fG6m1+ViqzZaHz7PinF5DIpc+67GgAqlCVBDLh0Y84yrA7TCYcNqc/msPOtn@vger.kernel.org, AJvYcCX7OTu1BpW93crbbEF8Gk10Q/vVJiSEvjVzo4MXbjzQFRkdeUKSeUBmdYJFO6V6TPopuigWiJhLu8DgbWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLZcNS5z5TgZgsX5dy2TN+3WGE1+TEQxgeCeu5em94DXA4Wqp
	HfLietRT0+71LNatW2y7jUZVKhywqqzOoNa5UB3KeyXtpAH40B70B/u9
X-Gm-Gg: ASbGncur42aU/41txzFI/kxAHJ9hu9QXHBGqmGC0dtClGG7j4LmH1KVASy6slhBeNjS
	VgSjq0+7xVsq+EEDm5cF0C8vHYNKL03anl1jvKLpoDQ6xZBpb6DEER8iKgP6H6RxwFeJI+435Tv
	zCREpPHWc4qckaf7PRT31vlsdxBWuFnxbMy9G/940EfII592zdajdkrdlg5GnxC42REDhFpiWMD
	mpC9dKNxp1lDROV/47vlCn65WMpQAj2ls10mr4qs8UIZsicUpSH5uNtZ9gZXHKrdG7Cw5vhSypx
	uYF9LYBrXydoxxeed4m3y7YnclUerX2Y9OHnmP9SKRyLAZP6DRTLjil6Osul5bRN5/uvtw==
X-Google-Smtp-Source: AGHT+IGxw/QdWH/t5lLNpewU2HMkLtFAjxhlV0kuOOO/I/w/DZhFPUIKFHMjokrZNRIsY9SG7txifw==
X-Received: by 2002:a17:902:d511:b0:237:ed38:a5b3 with SMTP id d9443c01a7336-23c8746d7eamr216932725ad.8.1751965495714;
        Tue, 08 Jul 2025 02:04:55 -0700 (PDT)
Received: from syzkaller.mshome.net ([183.192.14.250])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23c845bf51asm113576975ad.257.2025.07.08.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:04:55 -0700 (PDT)
From: veritas501 <hxzene@gmail.com>
To: davem@davemloft.net
Cc: veritas501 <hxzene@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: appletalk: Fix device refcount leak in atrtr_create()
Date: Tue,  8 Jul 2025 09:04:30 +0000
Message-Id: <20250708090431.472195-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When updating an existing route entry in atrtr_create(), the old device
reference was not being released before assigning the new device,
leading to a device refcount leak. Fix this by calling dev_put() to
release the old device reference before holding the new one.

Fixes: c7f905f0f6d4 ("[ATALK]: Add missing dev_hold() to atrtr_create().")
Signed-off-by: veritas501 <hxzene@gmail.com>
---
 net/appletalk/ddp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 73ea7e67f05a..e5708870a249 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -576,6 +576,8 @@ static int atrtr_create(struct rtentry *r, struct net_device *devhint)
 
 	/* Fill in the routing entry */
 	rt->target  = ta->sat_addr;
+	if (rt->dev)
+		dev_put(rt->dev); /* Release old device */
 	dev_hold(devhint);
 	rt->dev     = devhint;
 	rt->flags   = r->rt_flags;
-- 
2.34.1


