Return-Path: <netdev+bounces-221554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E14B50D8C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 07:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA281BC45C1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 05:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C826B761;
	Wed, 10 Sep 2025 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXWkB5J3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4345260563;
	Wed, 10 Sep 2025 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483344; cv=none; b=hktZJBU4lwgcxvJf25WmAYatGYuXawLv5MX/GbEh+gJJ9w+pv31BQcCIA0YDBQ/4uGUvN0BVslkjpYAKv+FjAUHnSA0wlnGuKmUF5UU209AC0Lap44KSLiAszngt/jpn3lpVfRteyH3qnt0ApABhstR4DJvnESAMUd923tscDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483344; c=relaxed/simple;
	bh=ztq6Cm7NE4KkCRVD211L15ipQC2l13KqfIBeqOmeSN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dy4fHS6tHZp1HPdWIv654Dm1vy7j17WJbha3W0ZQR8KdshFkQaNMFldkyNOfI+HrgQPnMa10CwfH94mRYx9MJP1pSviea/vSM4jXvRMHrOmZL93OI7oObp8jShOOhbGgJIJ4aqSH89HGO0HtG7ts2jDBuC3dkB4HKs8E+qSEAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXWkB5J3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445824dc27so65200665ad.3;
        Tue, 09 Sep 2025 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757483342; x=1758088142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJhAS7zGa5RZxppwGnUhdpVXVaIfRD2CHSAVQbr9go4=;
        b=ZXWkB5J3iUB5IqvgLV1uduDJrwlVUwFo46lHS6EQCR62UgzZM4WinG5T0ccWH3398d
         wCPL32v2xHO+w9KzVIkCZk5+KKPWB16fgF/vZjz0eZ6E/gwSb4Z20abc0LG46dYUmtPZ
         9r++hkAdBhmLl/GisUDHQ1OfwR45EGBGrd3PVbJmQ7dFZXtHhnwFp3e7fqBoOSFvcBdE
         ZcftjYItVlG77uhKSyVkGBmlBPMJTiYwygtVm/GVZvZMJg3df8x7e2+Co7t/RKdmI2pO
         ISvI22NUv8HY7xDiqjD1J0Bb+EeoqoMFS2A49CXQ7MFLvxtH9020Au2qj+5Y9UxI8Xfn
         WA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757483342; x=1758088142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJhAS7zGa5RZxppwGnUhdpVXVaIfRD2CHSAVQbr9go4=;
        b=PkcTH1hcCP437vnUh/bMwvKAhILdYtQoA4j7uFRGui6xw1Bl70MqVVFqBBkUIefNK4
         WnMto2tIc4qW1SwLd7z5AeOIrNaiOW7GwqNkjCD3Hz00LTe5hYVP/ploJ9eTO3MSjxSE
         kHfnekkcUE4E5RljSqQzmuH7T59jlMM9xaw0BYWLt4aXujzvhNpItJOotvOC9j7cmuJo
         x4sNLn9f5sxAyfwSQFt+oAcd8QQeX3Ao1kgAW/AP53N73GmXoqTIjM7rHLlBde60Si7y
         pDyv2XD8t58LJk7DJzFko/upHc7sxTNuIgI/YTnSotMo0PuzxRhimDWAXE0sF0LOz5oa
         IYgw==
X-Forwarded-Encrypted: i=1; AJvYcCVAN1y5gKC7kls7T1UZ+8yp+ms/yaUKp65aGcq7a44X9CrQF7b0sRrwrvu1IcM71BgEqwYjcRyA6ZXoMk4=@vger.kernel.org, AJvYcCX/CDwimkmqu/ZJcn1MFM0azqsC2YM6OI30MJhQzpSZqIqcswsirbVDiC+rBBdESBp0YcI9ZGLn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WPau144lHyAnW6+VXn43xBuFRgHugBr4XPkgNfvhUPfrUpAM
	iLxztgYRJuQ0Jjb/hWMZ61Bnc7bw10xpTTYdbp2C/jRRzYvot8iYUcjx
X-Gm-Gg: ASbGncsfsTJhEzf996s98uCpBF0N15M2N29P7Ewa4KOPZiSpm/Jg/bAU4cmX2GtbqKr
	FFe1EoPrkyRpedVuROYEcmbmmjSb6cBnVlzRcyMAENZkrA3/kZpMVCG8lQ2k+zSdpKjkMp/pEy+
	ckcFtaDE3t27jnPJ1IiajYn1tIVqQDAihoVEXut+vvfDp24x0hRuUuwdCQK5D1pbWtjfrmJ+RkF
	wKQNIN4sQF7m1HCZPNFoosfxZxCICa0YlqSapUZnyrE13v+s/dRaWqhccXL4RZQWYw2KvCV8JCV
	QNHIXUOihhTwaEz2uIoSSLy8hf+Q18342KH/J6Mu2lbo+7ZS0nKNcqZzmOObEEcv4+7mTNwxsDF
	yueDZ4AVw+6pbmqXMfPPy5kYkKONdSz5bpHlkkdTMPReYwLoROII3ZPsLaMk/rgjSmxE=
X-Google-Smtp-Source: AGHT+IH1eA1vJIm+p6hUXL9PigKz90R1J4VL03PzfzSJaGAMzrbxnUQ+dc8KNSqExlSyCD6zbaa4VQ==
X-Received: by 2002:a17:903:2ca:b0:249:2c76:54fc with SMTP id d9443c01a7336-25172291fe3mr185693095ad.39.1757483341975;
        Tue, 09 Sep 2025 22:49:01 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a922630sm15284575ad.104.2025.09.09.22.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:49:01 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dlink: count dropped packets on skb allocation failure
Date: Wed, 10 Sep 2025 14:48:37 +0900
Message-ID: <20250910054836.6599-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track dropped packet statistics when skb allocation fails
in the receive path.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..47d9eef2e725 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1009,6 +1009,7 @@ receive_packet (struct net_device *dev)
 			skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
 			if (skb == NULL) {
 				np->rx_ring[entry].fraginfo = 0;
+				dev->stats.rx_dropped++;
 				printk (KERN_INFO
 					"%s: receive_packet: "
 					"Unable to re-allocate Rx skbuff.#%d\n",
-- 
2.51.0


