Return-Path: <netdev+bounces-119179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C7954848
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD11B20DFC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFDB19DF4F;
	Fri, 16 Aug 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2hfyfYZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E61A4F04
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809082; cv=none; b=kKFq7g4BXatwylAM2WMRKiwsfFCt4rTlZJr22GKg6Yd69gZRoZid4SGM6/RwLSHnkH/L8dUBcq/aLHxwQLN03gtR5aeilrpy9CLol2zQcOAMpFpm84HnEzP+Q+JnXHLLNnc9/DHBAOys1zjzkMcyiYfJWR8k5m9+PEdOZat4ztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809082; c=relaxed/simple;
	bh=e4yCprVhrRgw9grxhItSNzy/3aPExuxQDvLJ+oDK3Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMVW3WhyoS6rautM3gCUh6b+7QFOorn38dFqx7H0tKVyvfAjgSZNlHxcOSwW7tYBZHJxe4Z9RvR7waNgj82Z2ii5dpbtnh7+AMT2hsJ0rOd+fc8iF18zzifpvvUTSlh2ATghe8z7W/lCQQymb6+RAvghA/Kx/VdLL4LE1Ea6TI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2hfyfYZK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3b8eb3df5so18666601fa.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723809078; x=1724413878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsP6OZY8FtG8kzDC28hz+qK5+Ulw5BlZI/hR6ZEydh4=;
        b=2hfyfYZKo+QndD/foFjPxjWVZOzg1s8EIGKP5Dsy32ZOc/bcMeIUvP2X46S5GbnGQK
         7kivW7JJI6XtBEhR/VghdHj6ZDARwGPG2qLaWt9Ub9uRewg+2IEBi1SMgcCCnT/iAE2L
         i0wRweJtMjgYH2OJqK1MFN30T4TYPmmeeD02Rz6YQ0875oUioOPNQ2CTvhfKH13UsYvP
         FpdWEZ420l1mO6S2VIEcQGx/F8vB0KGhtqdSLFlzyyllSdDrF+3RxxCAYkKCa5JKw/na
         91onFZHhBg4eLoWSNyfCB5MmU7aBLghmMMBQEs680mmJorBVN3hiLOMBjs4WljA8Jnty
         mqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809078; x=1724413878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsP6OZY8FtG8kzDC28hz+qK5+Ulw5BlZI/hR6ZEydh4=;
        b=ueKI6hiT8SOZfWgrfXp5FP+91eSvPUrFT871ely3GDdlEcCRZTRVJbVDqZdbVNnuY8
         p2bvtIpw9wU1OGKQRMLsKLwQLDgtkwb9b7ErGVrvdVx/5c1l1gdJiF3l30uFLgd8BIs3
         ggv+CMbb1sYSJHSxDie5YiajJoDNcazqEJPPWuF2Zb8WgtiYtc0G8xUNuxIB0EyMlXWc
         d5x3dqu2PnOqpuI1srIp/zOU9AD/pcDO5N3BCZq0jm3vhRvNtOq885kF1br7XFiG4Zl2
         N2miBzK5oiuRwSmLRfAUhODb0f0ozlBZenewABylW4nHHhMNA0YfKSDWX4qp0UhxZs51
         39ZQ==
X-Gm-Message-State: AOJu0YyYLxAj+5U+rHUQPacPeqJK8nIwn99BEIqs9y8n/Goi1G4kFj+r
	tjRRYn2qxx7x2p1u5Mhnxn1Zw1fPOwHajDn6PDI8c1IKymvfnaDevngh6UqV43C7KQA6MHOrGFz
	u
X-Google-Smtp-Source: AGHT+IG6CxhChwVrT/Qat9JiXfnPgV4L91W7mQyYBy8kFsVtGShhXw4KYTqnsErboWW/51T8Uah86Q==
X-Received: by 2002:a2e:9d18:0:b0:2ef:26ec:44ea with SMTP id 38308e7fff4ca-2f3be60118fmr16538221fa.39.1723809077405;
        Fri, 16 Aug 2024 04:51:17 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde7cd4sm2152845a12.39.2024.08.16.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:51:16 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jarod@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 2/4] bonding: fix null pointer deref in bond_ipsec_offload_ok
Date: Fri, 16 Aug 2024 14:48:11 +0300
Message-ID: <20240816114813.326645-3-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816114813.326645-1-razor@blackwall.org>
References: <20240816114813.326645-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must check if there is an active slave before dereferencing the pointer.

Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/bonding/bond_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 85b5868deeea..65ddb71eebcd 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -604,6 +604,8 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
 	curr_active = rcu_dereference(bond->curr_active_slave);
+	if (!curr_active)
+		goto out;
 	real_dev = curr_active->dev;
 
 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
-- 
2.44.0


