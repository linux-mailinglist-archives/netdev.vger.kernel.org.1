Return-Path: <netdev+bounces-232386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F7C052CE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B21A188495B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5D3064A3;
	Fri, 24 Oct 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7XW+Trt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294D30594A
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295792; cv=none; b=h7OsDzxBT4gy6tFZs4xqtEb/bk07UiNWzoGBZwy3cUERhWoVUcwuy+HUTPIipBYn2T22HLxK4Kp0aD21avOaqe69RYddbU6RLfu86T+WuCOd+E7zub1feTPFwUXg415wOpNZLq90L7lPgYqDxj3eyg2PrvWesZaYQH6I3wP+2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295792; c=relaxed/simple;
	bh=7CMLhsyi8RHC5Gc+82TW2aO/QzGgNNTW8Gr54I7T15c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FE0NBfxTK27vHeUtWNE9vph3BlPKtP7trDevdaf8wUg5xetXTbwI/F33PmTxttPbSZkll26IzqrM/L7sB3eAHwwwDq2z7csWz1BDcIkXZjkEhe4bo8gyUkW4YiTei0i3/my4R7JTGAu1H40oNARHU9AoDwQaw3rQOnb4S9yJBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7XW+Trt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cea3f34ebso1301320a12.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295790; x=1761900590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=be9DCKrTHpiIryaMvL91sMS8lgrWVR8oTSh04xQEuZc=;
        b=B7XW+TrtpXGBxRU2KNAfAi/KSExowrbCC206bH4Asx+bPR1/mwtcGvncAOl99sSA+s
         gLT1TpTAnqElejP2yVtjXOIRtN/2PXPCiiEe+FSn3WoRnkAAtMH2tQEMcbib2im6ydcT
         PZuwKP0eeDbgPvCnP9tyR6YP+RZBlrhXnQGmjNonrZeSAZ4LTeXaKHZccfqiF/2g8Yiz
         DMPgpq/yVjSXX5K7YHc2iEyNC05BOIHo6Bx2XYEYsyFH9c1icrskilhYvGKR9GTtLxOG
         21+73XdgSN/Hve5KxXk3p8/IvG+PbRUedF5dxRZhbvc+PdYL8+OYFdsbv6l9vNpXEXlK
         WYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295790; x=1761900590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be9DCKrTHpiIryaMvL91sMS8lgrWVR8oTSh04xQEuZc=;
        b=QqeronJhSPaAnr0CFxfWWBi59v6WSZWUccxodC2s5GDGMzgbe1u8FDtsH6RO/2Mg8V
         2oeg1chGE6mCVGII8+NppjPcAotNj+n6zDbuecIhrwsXEhar9zYBtExVjc/QHqZanLLe
         zA2q9o1477egGie3w2r6kTG/gYsRYPjkalMy/t0haWcQyY5EuNu+ySOFJQ4OBbjev8b1
         oruMZBLIVHH4RwOYq9ewgXR6aQGJGf2+5jFhf8FxGeZ7rnV5k5LU/ENnZ0HphxxlrGmu
         pIxera2G1Ora16PD4UbebAeE+GfC4pY6BHKx2Ho/aTCfqCsWCPs8iTUsYlZu/Okwqk8n
         1hTQ==
X-Gm-Message-State: AOJu0Yxk3G8QxMdigWEZsGx33aCw1OiXKKXbijNWaZMw1QSq69K616DQ
	PfmnEtS1zeAmuBZH9mugwLQv5KjxPAwlyC9VnjaibtX9w3t95pVO9qna6GUWcLjNwtE=
X-Gm-Gg: ASbGncv6hrnID1tpJsr+XiBh7JxQREGlN77226moevmJQH34g3mSXjHiAzgsdfv0t91
	K4aVDJhiQ8QYbVHaO2pb7BUMHX5lvQfYpdgjshr8PUpGkQjEjTH9qzLasXg5bgs8V5lbQL2aKSc
	AJquT0wxarJtnPg39Jl0kldNr0bJM8plVZS0BV6Vt1WjcuLfrK9sXbe7Ihk7Ug563UxxY/yjvwT
	IfrWSUFHYmiUeTPtpJahI6yWo4AdpAkma3n3d0GDcVZQ+W4xm9DoS2JjvbLLRZ8qR0Sa26E48Ix
	yLTUBY6lFEkbGgPvjS5hZo1H8Ef8vdU3AMBfhqN3Hz8Ly3hL95LU8Hvfmcnph7BQWm768oZ1tuB
	06v1G8S0Vg7a8759pUaN3CDw3TXX9YTmVvKoRq7Q+zHvchB9a+lIqeuhM58cF8mHaaNVfJN/3Xa
	YO+1XYYw4=
X-Google-Smtp-Source: AGHT+IErebRAdRvYuPVFvY/KrwtCyAozZVkTU4P0prhGSo763KhyXweOzp7RjW6bXalnbbU1d8GxVw==
X-Received: by 2002:a17:903:3d0b:b0:290:ccec:fea3 with SMTP id d9443c01a7336-290ccecffb1mr335960345ad.42.1761295789977;
        Fri, 24 Oct 2025 01:49:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2578bfsm48029025ad.112.2025.10.24.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:49:49 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: yt921x: Fix missing type casting to u64
Date: Fri, 24 Oct 2025 16:49:13 +0800
Message-ID: <20251024084918.1353031-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by the following Smatch static checker warning:

  drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
  warn: was expecting a 64 bit value instead of '(~0)'

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ab762ffc4661..8baed8107512 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -699,7 +699,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			if (val < (u32)val)
 				/* overflow */
 				val += (u64)U32_MAX + 1;
-			val &= ~U32_MAX;
+			val &= ~(u64)U32_MAX;
 			val |= val0;
 		} else {
 			res = yt921x_reg_read(priv, reg + 4, &val1);
-- 
2.51.0


