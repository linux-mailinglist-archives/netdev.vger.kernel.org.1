Return-Path: <netdev+bounces-227708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E9BB5CBF
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 04:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03AED4E63D1
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB42D3755;
	Fri,  3 Oct 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAfvXdM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DF2D0C8A
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458200; cv=none; b=lm6S7VMVTH7YTnVUnyXx6D/l4Lx+GbWD1mcVV+fOCoBcPPrf5YwDW1jvqXX6cPQ+RsmZnnetj191nH9mJfFMHJPtOTNxNfnyLq9HhBz006eUqjr7MXJE4kMaKhjYnnnl3DkmveUefiQGSAN4eSUryTf6SO3ROaRm4kw7afUoUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458200; c=relaxed/simple;
	bh=Q/GTZeowJZkPGr6Ii9Db/DUkP7qcFYhns+17KdephwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvP3IeJ94u1oecXHnXsbtjzdD2WTL54SzVSxyrLqpPHJ6bPRFM5QEb4J36HUPyyVSvw9o2Ak6qYq+5OWq2cPTyzEFLlJfBPmF+uRNR2RD0wOyID4EGE/Zyuej/pY5eYAVXevbBl9pPVKC4hu8/kmIXeWDx0SOAqTJH/a1Vq9qS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAfvXdM9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-273a0aeed57so33681905ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759458194; x=1760062994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwM7hNvsHnNSOJ7+Bp5EcACbvFcp1Jo4CMapJ4a9hQc=;
        b=ZAfvXdM9MtsPQLlGgrNQTGRRYCsB2rCLKav4XaCx89caYrpUFjQ3z/yhxJquuYVx+l
         W1XZmadMHYE+VzCzSEczHNOSYy5X1X1SkTjDtscsP15qbRHNQ9e+bvyIq+519i2Lamog
         i4ADlqyO1dsla9Rs+WbrVgKc+62F8J1KG0oEujqhRMj3lTww/Mg/XHQlu+fHZDEDfrWI
         7ZAwehvQWo72oPtuNOXTKrtC/jgTN6XUNpGthC+XL8WIrnm7+txScP0vcSyXaGjajShj
         ijwitm6i6Qi8jMhfQ2CAhG2Qa4wawsMw74xlXrzrxGYC6HCLPTdnnrIucu4962CLLqNG
         CbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759458194; x=1760062994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwM7hNvsHnNSOJ7+Bp5EcACbvFcp1Jo4CMapJ4a9hQc=;
        b=VN1TnK3xROjy43r15ePDafPkhWfUng/llZzsdx0Z+okOYfAR29yTuhAKAvaIe3hygH
         /A1Xq6NL5DXO60ialgcb2g571CRKYfoW3k5xNY41g4coNCdGxrWpkOo+8+rqJ/gV0exo
         ZbqA0JUCx5F0tNbf6GS/W7BOuYoq71zY1yls2FyD/AJAVAAi5sJdF5WC5DhNpjQP8MTX
         Rmb5G9DDTFg3XlwNRQD+S0rO9JxLDwwTHVtrywUqZ96mZVDyx1cy9d6/d/rA2UCx3A91
         hSw9thWWibYYTh8jOVH6lhKNt2b+CxCqHJZ8Z6fxPo2Je7otIm3eRhKnaK09W72o/hfJ
         4CRg==
X-Gm-Message-State: AOJu0YzdWUN/S5ffsgYQc0QNLQ+9WffNaclS6ftwlfQz/ZL53IQrbkQ3
	9IE3Gqnr/xlVRviU7qwOuZJtp5yRVg9cUgJle7vmz3/DkcDqR8M+vFxVgRoVz176lAM=
X-Gm-Gg: ASbGncsVJ7Xrs56rFXlRUcwdcaSX65mNCb3By3SPkKhYDOoDxaC1xjt6/m0AwKm9rcw
	RXb34hEajZ8WLLUa8Kdh6Rp7Q80d8SQ8BTc64CpMsFfpwL5LhCyXnGYifGeCuEHr7LcV8U1ejiP
	CDS8KIuT31uSFNeHJ//p8P5v00nnurGoodtYA6a7ryy1x7aNgkWHPp85x1vtRZAUdyWgrDJ1kwe
	M7s32GcgXkIhN1tKLoOHN73YP5W9c/wO1twraAAj2uKmoCqyIU/MRyTGNAd9O21o0qbb817MJHj
	PtWaSQddZyYYRVFSn0RBtuJyupPfuGHTlXyeZIzRCZAvqKbodLFCNxjohf80V7gUty6rNZUS//N
	LQz0S79tvpuukp8QHHO+sKUEZAiY5iW0OpIVNYxW0gKbVpQg=
X-Google-Smtp-Source: AGHT+IHtD468SsvQKxPqSOP+le5fRPrdW5RE6RHnWgwiYu2bpRmuPfQfabmTIJ6pacAdYun9k/hvRA==
X-Received: by 2002:a17:903:b46:b0:269:a6b2:2463 with SMTP id d9443c01a7336-28e99d87b0amr14739605ad.16.1759458194399;
        Thu, 02 Oct 2025 19:23:14 -0700 (PDT)
Received: from mythos-cloud ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d112797sm33850725ad.22.2025.10.02.19.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 19:23:14 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net] net: dlink: use dev_kfree_skb_any instead of dev_kfree_skb
Date: Fri,  3 Oct 2025 11:23:00 +0900
Message-ID: <20251003022300.1105-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
which can be called from hard irq context (netpoll) and from other
contexts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Tested-on: D-Link DGE-550T Rev-A3
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 1996d2e4e3e2..fcb89f9e5e2e 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -724,7 +724,7 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
 	u64 tfc_vlan_tag = 0;
 
 	if (np->link_status == 0) {	/* Link Down */
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 	entry = np->cur_tx % TX_RING_SIZE;
-- 
2.51.0


