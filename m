Return-Path: <netdev+bounces-198678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2CBADD06E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008571897B60
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A812E3B16;
	Tue, 17 Jun 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElYL2pmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361122CCDE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171372; cv=none; b=NgwcGG0pbRYR19861aqzVi/TdtnQqSxByh6GwpInvU7cLUsE+/+JRyXJqZMCrpdEv0MuDsKUM4xdLtlXthHqObLBzMU1+JVGe4UA/GiauPGA8BBuUoQqt7dDidVrwv4cNbcIUHsuqJAK1Sq4rGMQik7JD1DsPC/ZIiw1cMPKCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171372; c=relaxed/simple;
	bh=KK/t6b3gNlRNgE9uO1RD0IntdYMNCCDLxLTflKhly6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opOyKsyXOds1xKPLJNke2+cbojAwWW+84pMLqUaNHuqa4R+U+fB7g9aI36tNGJ5qAYY3DzkXzXYscNYGQDNh3ILW183dsEUvBqHpywWtCzVXaLnDU/qjyLzXY3au4EGmkzLF3Gmrz3WqD+Tp0LD2LzMOK0cnE+1q3vmXET7aUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElYL2pmA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade58ef47c0so199622966b.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171368; x=1750776168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i55BT1L006HrGhVcvb2n26kZj8pR+Cmx2Y69lfEqZZY=;
        b=ElYL2pmAhDWwAIxJeNm4vjRidibcdCRwHhrtb2NPJP81pvuq8gyvXji8Y3Zsx1Co6o
         1YkJljrgGLSc2vhu9iA07Bhu7CJd0v4uS0u8cMq3X1YnOlIoFezXH9B3+AZHfaGDOPrv
         4aK1l/u0Ju4ZvC2u1zERbxmNP5Ij+S/DckLgjX5Uxb8NyHtEiJv3AsJ6AZGK3OoQhcxt
         bw+iuncWVjMffeUrimgHS+eWXAEGtemEIr4NoSo1t7GEoKo7l0+8Udg9ndc6pHnv0Fqu
         9+hyE2CQUqH90WIfJjJXIYXloN6beNG82Bb3gRr1+c5UrcHf12Ky6Gwn/wdlau10040F
         TKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171368; x=1750776168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i55BT1L006HrGhVcvb2n26kZj8pR+Cmx2Y69lfEqZZY=;
        b=HB4WOCypJSMDCVuuLS/65k63252H6BtC5f0ALsR/ymIkpRBYyQBdeInQdLj+e6vv+z
         UU/MCZK5gF4Aq1BTVzg4r+HGXdTge7MDiPXQ0YVrHfqZUgglntJ/Lk8jjIa/Htv/JrQD
         JVWZNX6dgyFGZLrhD+qIJbTU6iSoFD8LZ4vc1oWDbBfQ36w2YCA8xgveRBve7N00P/QT
         BQQ2gYYmEXfz28S7crUGyNmtYV47iTKDiQlxDykgYrC9saMFBYRMBHo3XN+PBfg8B+xb
         uHGMLxQoF7GnwAdx/iqnKk3ZOIsxqY4q287uNBRmyEnBX9K0TVwLaUsovQc3JpOuucDW
         Ub7g==
X-Gm-Message-State: AOJu0YyoLhniLngksjhOwPTGdv0/xiC4E3jgzCt0puK0SkeIgDTYj0IP
	18tudYrK0dXOWPtDTk+aKk/xyE5a5GbQfj0Soog5Iq88nDCsKEjQBptw
X-Gm-Gg: ASbGncsUJ7YiarMI9YJOZEHGx7fbt+i4EbvfhyDESLRPjkAWaWeqCC5KnXvA1PZRO21
	y1Bfoh8wmm5aYIfzsmt96/R6fGMMCJQVvN2KTvWRNkv03V9/Qs4KWLrBnS0cDaM7eywlj5hM0m6
	5LgNFosmM8OrEaoLpi89rcwOk0zM2mvpgjNVF3cxLhRhcUwv7V9Renqib4VCQuEZ6nFMuaq4Bex
	5+GH4R42b9e3d8Wdfn/r3akKRMZMWctM2wZoyLsi1276V5ZURUv/LozVsCAL3g60RuIlzqOjyju
	+y+3A1sX78Soi20XYpw12yPJtbhBbaWVeB6mdpgtQMh+ty9cQyF+X+kd3yb5gWtswonpq00ZITH
	z6W2U444sXlRsa4wsbriV+s0=
X-Google-Smtp-Source: AGHT+IEyXJp0xglxZXN+MKDJMGlMmkcen5TBPGxdy9AftTTCpUUxU/VQmDSnwn4XuBz3cLkc0torug==
X-Received: by 2002:a17:907:3e14:b0:ad8:826b:fba6 with SMTP id a640c23a62f3a-adf4f0dd2eemr1642497066b.18.1750171368400;
        Tue, 17 Jun 2025 07:42:48 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec899c757sm877660266b.183.2025.06.17.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:47 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 10/17] net: mana: Remove jumbo_remove step from TX path
Date: Tue, 17 Jun 2025 16:40:09 +0200
Message-ID: <20250617144017.82931-11-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mana TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index e68b8190bb7a..f91bdcb00b51 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -262,9 +262,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (skb_cow_head(skb, MANA_HEADROOM))
 		goto tx_drop_count;
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_drop_count;
-
 	txq = &apc->tx_qp[txq_idx].txq;
 	gdma_sq = txq->gdma_sq;
 	cq = &apc->tx_qp[txq_idx].tx_cq;
-- 
2.49.0


