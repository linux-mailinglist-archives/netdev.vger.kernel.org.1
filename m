Return-Path: <netdev+bounces-138033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01D9ABA1D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E939DB22A33
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9618DF6B;
	Tue, 22 Oct 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StyPrB72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13712B93;
	Tue, 22 Oct 2024 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639927; cv=none; b=St3g7r/5OeC69rDVu5WgnkC3vt0YMiiNf3uFnM5KUJ46SrSR0YDFY1M0rgm1RIVhQ4YJgU4uVWZvI02w+joUt1u5INphkVUdRsIepmsqS/mSFjuuoVnkeoSmfKJiki1RPF5k9ZihDJ9AiFq/TTT6wlJf8ziOMN04LR00RNP54OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639927; c=relaxed/simple;
	bh=C00ceNiFNmuW67Y2ug44OoCT6p3dI5jQN6tfvmc8x4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFoA5MZdKHl/Nj4PC1YeS2L+bYHS8P0FZMFlouhY2pRlBUupcc+AWRcrpfpfeQf5jcKVD2YzMe1jkzdEkHx2/GSoVzQZQwYAD+4U4WcDEUcv5nwlfcEp4OOGr1DOPgLEpuJPF3fM89jA95TSMwjU/tskoXgdHieDJtZNclOfWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StyPrB72; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdb889222so60077655ad.3;
        Tue, 22 Oct 2024 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729639925; x=1730244725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2lPaeQtc4g7Ff4NX9AHqn0dcN9dhEq52WLMZgIk1rSk=;
        b=StyPrB72z5AhOz+skoYqqPBIqlTh/OBTSVjMuRMAdLxzIrKowA7pkw9mvVi8tYOkLE
         9kwhB0Z/omubMiVWGzpAfvl99jcdyghJVEsxIJ+H/ychNY5TVtpOSGCgjkhxRbpckxCz
         UzPLbrcVAPd6Aij0yCyxPtVJeMc0+ofVBvWWf25gPpMMbhDtCljIBqQvFYuUOtHQzeEJ
         qdbgWLGzUS22gWkyff7FzwkhF2mvCaapx4GAqKAua1mM6TZyIyxw74AGEewjr5K1UTCK
         phzsa28LjcseE+vCDeAhY2eNoTe9+V87auJcxlngRp6/1oDx2RFMYTBjwaSuzYVhHBJe
         +YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729639925; x=1730244725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lPaeQtc4g7Ff4NX9AHqn0dcN9dhEq52WLMZgIk1rSk=;
        b=NWS+gREiTki4ViURXX2QhCx0CYN68uZQRSwLGKZYRtXk8tyMR9aUP2ClOxh7QImdI+
         NbXbu0G30JxqPcqcimIFKMBnGTf5XWBaT4R98i0mue0Iq22E/a5biJGJtyY/9qBONtJ7
         aZCdSbQXtDUh7szeF8g5FI2yDq+9VSV2FCMr3LiQmqolZPB/97X0zvDwTTIuserOclZI
         IY7sSSVbn1+vOWgkJQ8pyQFUxc0sy4aXDULfmduKiaCewg180nZHhbJ3J3/2j4EzhkJ3
         7wFZ1eQJkv6HKYidQI5oWnepY59QPoOq9S4QijgjQfXW/5HhGp4vYZUtm0V/5uY5osIk
         bDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8rPzJ1wa/Wd9BimufOTFWwjadKgeP7KQ/zGUpIfiTrofwR8pVp3nq6K/vtE5/TIq60rB02/SAO7ai6Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyPCQ19b/0kJ5TEsI/UN2E349/yzexk1Q5eiOqVHU13i68UTs
	RsHUgAjKc0eq/w9Yr+8CxCPthak+bOW2YEgEfuaZ7nRg6K1R4FZY0aK2nvAU
X-Google-Smtp-Source: AGHT+IE5XEQQqYe6p/XaZB4ezEd6BuPXF/pDClu6xpEbNZC/x3zwGTy1b8mGKFPC5NUrgjPnrIZjKA==
X-Received: by 2002:a17:902:f693:b0:20c:ee48:94f3 with SMTP id d9443c01a7336-20fa9e0977emr10789795ad.14.1729639924756;
        Tue, 22 Oct 2024 16:32:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee3c7dsm47530975ad.35.2024.10.22.16.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 16:32:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] amd-xgbe: use ethtool string helpers
Date: Tue, 22 Oct 2024 16:32:03 -0700
Message-ID: <20241022233203.9670-1-rosenp@gmail.com>
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
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 22 ++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 5fc94c2f638e..4431ab1c18b3 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -195,23 +195,19 @@ static void xgbe_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < XGBE_STATS_COUNT; i++) {
-			memcpy(data, xgbe_gstring_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < XGBE_STATS_COUNT; i++)
+			ethtool_puts(&data, xgbe_gstring_stats[i].stat_string);
+
 		for (i = 0; i < pdata->tx_ring_count; i++) {
-			sprintf(data, "txq_%u_packets", i);
-			data += ETH_GSTRING_LEN;
-			sprintf(data, "txq_%u_bytes", i);
-			data += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "txq_%u_packets", i);
+			ethtool_sprintf(&data, "txq_%u_bytes", i);
 		}
+
 		for (i = 0; i < pdata->rx_ring_count; i++) {
-			sprintf(data, "rxq_%u_packets", i);
-			data += ETH_GSTRING_LEN;
-			sprintf(data, "rxq_%u_bytes", i);
-			data += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "rxq_%u_packets", i);
+			ethtool_sprintf(&data, "rxq_%u_bytes", i);
 		}
+
 		break;
 	}
 }
-- 
2.47.0


