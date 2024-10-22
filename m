Return-Path: <netdev+bounces-138016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F159AB807
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 22:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A525B22646
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40A1CC8BF;
	Tue, 22 Oct 2024 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8YON1NK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBED126C05;
	Tue, 22 Oct 2024 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630475; cv=none; b=uB3y0nx/dedqfkNgHRwHU8Dk4ihoU5H/t87oBC522dtx6HYnrB+0fpKrupNWN+p7GRV+fJGQnRwEJumDlM26uJMEXTEC7Pfr8OFhkHGbF9fWay89L7wt443czj3ZW3RdOU45Xbf0p8+c8UsmQUuX3U3BDA3XJ0eu5DNRGYzKzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630475; c=relaxed/simple;
	bh=l6GHfQgoq8Oc0vCDPJdkzBQlc70xqriIeqMYvHsXOHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grMf89gqRBSQJEcG+iCbbICbLAUKcNLEXGsx/8yKKw5iiWa4RTVeEiphHWXqbCvqRsZ66+eBdLQ+Bbnlo+11zv1522WozWjT4nCDtAJtvL/MQP/hWsf/3RAyQ5mfv5mG98wzvq4JMLOYuvxyI8dqF5lkkC5Gx4FW2Fj3uBPpWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8YON1NK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8b557f91so61110805ad.2;
        Tue, 22 Oct 2024 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729630473; x=1730235273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTiwbCiry3kgT1d4J0cIU2GO8YwomJSZvPg0xKIsxQA=;
        b=l8YON1NKqywJ6WJBpzIol56AscjU3UJkmnFnAsF/m4HHAPSu3+H129lFxzSR6O1wC0
         9Z2NC1zVWCQcovDgYHTuwj/6/30xh/44TGuNNu75UuvDGhA6GywSJRMm9m26seG6U1dC
         dw1XyZ/ADxa8QxmNX+8l68cufWLbKWz6bkiGm86K+hzqdO0YD79L2UCpY4FqdfeOsbWv
         3Jkp0UPUX6hqn5Ojg4pqx5WPI94yiTKzNgEmvGCnGXnGqGExkWmgDq3+GLdbSMFg5HU3
         2qr0UOy28OhDfBjSm8AmAvMUsN+J8KvKaTd+PauV5c8NOSknWNO5KONUMWnZv6iBJs72
         n1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729630473; x=1730235273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTiwbCiry3kgT1d4J0cIU2GO8YwomJSZvPg0xKIsxQA=;
        b=bBHo/yj6e2dbOxMbhniMoD+zkhwGW1jyhy7l9BxJRnVHKnoLVV2wbxXOtPJMqr1Y1O
         kH6cbtn08WxtyxWsjmy5pwdZmFN9lLJMhm7g7fQT3LpnnYCfZMaS5JITe9lddx5AKpT9
         ofQbjCphwr4fiLF37X8M5Hy+AAkdR4/kJLrt8GXuxrT2jFWRsoTxMzp1XhIAXGq9ILCl
         /8/ygJneo/sD9Avc3p4P8Epx9zaxiW9lyuBs88X+mVW5DfcTd0Bh9M1PmCHkv7nQ2+WX
         +WGK9CmKgRdxkOzqYNu/2e2PfQzmAtnfbxdeKiUoO7s34X7CZHsPxwBe3bUWT38NnXO3
         zIjA==
X-Forwarded-Encrypted: i=1; AJvYcCUTdv56w31Pz4/GFOIU7lLa1ZUQGDKWcvPzpPwN2784ZblCC6yWNHFzjBGZzDw48ja9giwXUxERobNrVT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt3NgeKZuWKT61bgLglW5h24JUj3ISTOzR5VknNL487LZUZyv
	d+jzgA9UNMzct/SjDzfTdWVMddheVjhWZ5PsJbVD99X7pqCEXdiMDpr2FBYb
X-Google-Smtp-Source: AGHT+IHk2LGyWlT6uWz8M7OK8YTuxaTcJ7VrJe63YuC6HMX7nCDN4autEdnW/oFCiHQyiN/Z8GdngA==
X-Received: by 2002:a17:902:e851:b0:207:6ef:d983 with SMTP id d9443c01a7336-20fa9eb648fmr4592465ad.39.1729630473175;
        Tue, 22 Oct 2024 13:54:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef13301sm46802095ad.118.2024.10.22.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:54:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: fjes: use ethtool string helpers
Date: Tue, 22 Oct 2024 13:54:31 -0700
Message-ID: <20241022205431.511859-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter is the preferred way to copy ethtool strings.

Avoids manually incrementing the pointer.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/fjes/fjes_ethtool.c | 50 +++++++++++----------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/net/fjes/fjes_ethtool.c b/drivers/net/fjes/fjes_ethtool.c
index 19c99529566b..1dc7754e0f1f 100644
--- a/drivers/net/fjes/fjes_ethtool.c
+++ b/drivers/net/fjes/fjes_ethtool.c
@@ -92,42 +92,26 @@ static void fjes_get_strings(struct net_device *netdev,
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < ARRAY_SIZE(fjes_gstrings_stats); i++) {
-			memcpy(p, fjes_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < ARRAY_SIZE(fjes_gstrings_stats); i++)
+			ethtool_puts(&p, fjes_gstrings_stats[i].stat_string);
+
 		for (i = 0; i < hw->max_epid; i++) {
 			if (i == hw->my_epid)
 				continue;
-			sprintf(p, "ep%u_com_regist_buf_exec", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_com_unregist_buf_exec", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_send_intr_rx", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_send_intr_unshare", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_send_intr_zoneupdate", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_recv_intr_rx", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_recv_intr_unshare", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_recv_intr_stop", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_recv_intr_zoneupdate", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_buffer_full", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_dropped_not_shared", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_dropped_ver_mismatch", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_dropped_buf_size_mismatch", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_dropped_vlanid_mismatch", i);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&p, "ep%u_com_regist_buf_exec", i);
+			ethtool_sprintf(&p, "ep%u_com_unregist_buf_exec", i);
+			ethtool_sprintf(&p, "ep%u_send_intr_rx", i);
+			ethtool_sprintf(&p, "ep%u_send_intr_unshare", i);
+			ethtool_sprintf(&p, "ep%u_send_intr_zoneupdate", i);
+			ethtool_sprintf(&p, "ep%u_recv_intr_rx", i);
+			ethtool_sprintf(&p, "ep%u_recv_intr_unshare", i);
+			ethtool_sprintf(&p, "ep%u_recv_intr_stop", i);
+			ethtool_sprintf(&p, "ep%u_recv_intr_zoneupdate", i);
+			ethtool_sprintf(&p, "ep%u_tx_buffer_full", i);
+			ethtool_sprintf(&p, "ep%u_tx_dropped_not_shared", i);
+			ethtool_sprintf(&p, "ep%u_tx_dropped_ver_mismatch", i);
+			ethtool_sprintf(&p, "ep%u_tx_dropped_buf_size_mismatch", i);
+			ethtool_sprintf(&p, "ep%u_tx_dropped_vlanid_mismatch", i);
 		}
 		break;
 	}
-- 
2.47.0


