Return-Path: <netdev+bounces-178203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFAA7578A
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534A17A5698
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029F1DED51;
	Sat, 29 Mar 2025 18:57:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71B1B3927
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274638; cv=none; b=XGFOTcuf5laI4tJEpTT6rOulREhIfGXQ9nEYaondRE7//UoB/kubnkhatcyInirfVG26T8JI8JJzvOXy+gN2gn70Ap9r68x73WE7HVUzbDkpLCKVe70yvzXlnly15RAGDVQ+TPUfZ1GScxG5sDg5a+EHz0shWMkhvGPOM2+e2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274638; c=relaxed/simple;
	bh=No/0VfPK7pHniKtbbaQJ0cyWQL9HoLVC3b3WbWBLe4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHZaTRlPUYEYZoLsf07kGtree5gOUBfGvuZoo2caHQLHlEMmxAA264flJ/Yprm2rx7Z9k3puk8vCX3UjxQ7gTRQRnKYffMAgyXJoMa1R3UD/HT+2qa7Y4mGpdxOFRQKZYnsmK2gKds8OFRaotc4Fm5yCK9Exy1jANDjtkRjNPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264aefc45dso86359435ad.0
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274635; x=1743879435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOUxfu91P1ktbOKHx7UEPpGlhg2bkdrt6E9z1Gl/UMk=;
        b=SfA3PvGhJFci1qS4DgYoP4zFDDNjOje66jovG6NrUP8bXE5WxS10FOWeorCoHAlplI
         CTR1MoxZQqfsH5unkwRZ8xI226lLuL8z/aVl1pTprOt4M/qIsKA1HRsC4CrAFo6ydCY8
         5IC5y7N4NRbR4dLAZLjlq+izTOHdnNscO35i4xGWOrKcUPGkX1vbuuyiqg1lG0UaGtHs
         RrNa51Q3NDRz9fwGTEmBHMAATnIULS7HCS3SGxMeFF5xhvV3F1a1dZcX+sGmHYxsrQfS
         q95qiVIf7lv5GLOMMEMILp7A/wgwsKoPDrS6ZkuNMQmFvmD/UdqeVjQnfpANegrE4tiA
         oKbw==
X-Gm-Message-State: AOJu0YzTSiCh7cEU/SyH6VNOEaS1joL09tQQzQkqVtyqFpF1kDUpZ0iH
	z5eULujvLTmGaKSRyt/1eB/fT308gs+J+Slfg/gCgPjKTqfX3e9vZ0VamOU=
X-Gm-Gg: ASbGncth4/ZRLsJYvhjj+aRphixEL8TiCzVevG1I+Ro38hoe6F7Kw6kIgJHiavTcwxM
	ooaPJFQpRm2kalrIS/WIB/ARz8aK5k4hZXgMNrWVUxWbO4nsVA1nufPx93ntBXGu7JEnfEZ3hes
	sJIilTnJsBqmYlkcdRklRdTWF17+NCze3/RKPfgIWVjb8SeKv4FFtyiIR/hheUe7j+VzA05FIEJ
	/od/ZFJA8P6HRx1b7xx6CmPf7JGk+DJ56m5t69i1nLD1q+EGbSOdLDGvUbZiJ25Ukgg9ncCrvjW
	r2Beo0jXWJ+VW/1EtDgmTCt3vCuY3la6bE6ftD9G7tbk
X-Google-Smtp-Source: AGHT+IGZvtq83+08cQjj/sm5hUpeVF3X2nUYvKDW3jBFoq2C/jNT4RqlhcC2hYVIELdnZJ3s6vzIqA==
X-Received: by 2002:a17:903:2f85:b0:224:76f:9e45 with SMTP id d9443c01a7336-2292f963a1dmr45699325ad.21.1743274635025;
        Sat, 29 Mar 2025 11:57:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970dee851sm3936846b3a.26.2025.03.29.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:14 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 06/11] net: dummy: request ops lock
Date: Sat, 29 Mar 2025 11:56:59 -0700
Message-ID: <20250329185704.676589-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though dummy device doesn't really need an instance lock,
a lot of selftests use dummy so it's useful to have extra
expose to the instance lock on NIPA. Request the instance/ops
locking.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index a4938c6a5ebb..d6bdad4baadd 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -105,6 +105,7 @@ static void dummy_setup(struct net_device *dev)
 	dev->netdev_ops = &dummy_netdev_ops;
 	dev->ethtool_ops = &dummy_ethtool_ops;
 	dev->needs_free_netdev = true;
+	dev->request_ops_lock = true;
 
 	/* Fill in device structure with ethernet-generic values. */
 	dev->flags |= IFF_NOARP;
-- 
2.48.1


