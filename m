Return-Path: <netdev+bounces-176987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CB1A6D2DF
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 02:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6483D16CDDC
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 01:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190253A7;
	Mon, 24 Mar 2025 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CEl8xcFi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1C1362
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742780810; cv=none; b=DuvKiwxAglc9ZjWeNacH4zSqT8q2JeD3kO8s5IcfHIvHwwAOQgxTCsYLSK8Pp8edL++aLU/h14fmalfcebovSbszrw4KU4e5Uv2wUf9r1kn1Q0RNMTGCKFrsj2Ng4toYOoSJswu2Y0pnjw9UMBdiLII5i0PBXbxaQwwQZab7mFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742780810; c=relaxed/simple;
	bh=E8s558hMfZA95GvDf0x1tm61DwXiB+CQRcH0QNGOQxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zu3Ff0o440j5F3/nVAIJ2Ks11zaNqaXetSiVC58BuAS1zQN9NbWidlY8/0a1q4YKxZVonn1y+jbkvrBIG8Y6+8Fg3rIzL1Koi4bSq7fvB7HO9D2y3yGydy3jcdw3U820dahaQ0UlLctp8iBG3jlfKKIib3yAl2Rye6zh2azyk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CEl8xcFi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225df540edcso92360905ad.0
        for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1742780809; x=1743385609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzD1RoPoHzjImY/JJy6IgeTM6Z7l8z2vdfvwrnemfBk=;
        b=CEl8xcFitGXl0mNilGxatI5fBJE68iVZFSgXRZip4S569tAJc66JI1mHucz8WCTsjc
         0C2pFnYdMEnukWpXMt5sZOgaUI6XdC80bEuBgNbmRhrckHTpVtXUWDO+YcYMWCRHtCw1
         zJDwGgTIowm+XgOLWhHhfL7gpQmY10hGf6LxgUNBJGeeVn00AGfYYGI1SwAQM3OB1Ujp
         l6Vm7HvlFxIP0tWNdRKDQCPCx8UC/mf/iE8Uq8eqUk8W0DFt03hp6abGWk6OGCXgok6r
         zYtUyi9fUcxr2uAIlGaNgFk6gVqwUfBYk1IPrXnB82EDuhB4UbTSTo9VmALrz7zroo7s
         A5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742780809; x=1743385609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzD1RoPoHzjImY/JJy6IgeTM6Z7l8z2vdfvwrnemfBk=;
        b=tlYVVNCqZe5EpYrko8B5ypqL1zYfi+h2A2DOfHU2MkWG0OpUvji7A8o9omhMjFxnnI
         TSkWYF/Up1mJCUP8i6pbnjPbZigiySSAaxNuyf5gT3amy7pk5RkFCzImAoyshbKr8D17
         1kGFgx40GFSol6AW57IUOE/TaxvW3Xp93jmqSxfEcvikB1I1R3OcYZaM8NJrPoGEzQHh
         uDJlbK2cHkuVnkDxNgMxRYHzoIkbx4zvZv1Z8XWvvhNyHvjv3xPxTs8w5UhLO/3fVuKn
         XXjo0qY47ey91PV2M204dQb1jGJU7DGt2fj6nvzL+/JnekPyHhMWx96qzUiXuQNN3Wqu
         vSYg==
X-Gm-Message-State: AOJu0YwPUau8M8C2PImjSOBVOe8stYgtBmd8PzVuwdRNcLO5Hk0jH3TQ
	aFrfAj+XZul9gT5Mt5A/8hABEZqbQPkfRasDbDmRbfW2ZUF4bVhndoN+7e11d8n8nHWaMByys2K
	q
X-Gm-Gg: ASbGncuuavkP4pkOY98AZtMN7Q03QLd6RW96l073p1FeW5nTpHYptKhiHMmx80TGY6F
	m9G6Zc34PULtaXZfRI1Or/ZhRr8rXejk0wloZnnyY5Mu+Pjjo74EdUG3Cpbh/92dXkAoj3w4AKR
	bTA41LKg22kbWhP7Hnf+rS1w/Rf5iu2jIy6bK85oie1KPPviWt7/IXpiB+5F3FlEDWugWw5vCBh
	WEXgVx5YwAjwwZEqY5Sdue6rSfHRyR84YEYf8eIIqslbRPCE5YQlUymlw7krZbYYNYgqj2u+9Wk
	vWakhAj1H+14FiP13ZB0aTP5oIXz
X-Google-Smtp-Source: AGHT+IEcwZms5o0MLW02QgwQ+0uyuBEj9EHqnd8tty+yl0mA5rC6C7YtLBVNQpygj41o18LM96WxuA==
X-Received: by 2002:a05:6a21:4d8c:b0:1ee:47e7:7e00 with SMTP id adf61e73a8af0-1fd0a5820b2mr21907820637.13.1742780808615;
        Sun, 23 Mar 2025 18:46:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4c905sm5892116a12.66.2025.03.23.18.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 18:46:48 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net] net: page_pool: replace ASSERT_RTNL() in page_pool_init()
Date: Sun, 23 Mar 2025 18:46:39 -0700
Message-ID: <20250324014639.4105332-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace a stray ASSERT_RTNL() in page_pool_init() with
netdev_assert_locked().

Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f5e908c9e7ad..2f469b02ea31 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -281,7 +281,7 @@ static int page_pool_init(struct page_pool *pool,
 		 * configuration doesn't change while we're initializing
 		 * the page_pool.
 		 */
-		ASSERT_RTNL();
+		netdev_assert_locked(params->netdev);
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
 		pool->mp_priv = rxq->mp_params.mp_priv;
-- 
2.47.1


