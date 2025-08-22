Return-Path: <netdev+bounces-216007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD9B316DF
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1528AB017FB
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299E2FABE5;
	Fri, 22 Aug 2025 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnIjGYcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA022CBD9;
	Fri, 22 Aug 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864204; cv=none; b=pySBJx2IIIBUlhpv83esxV5K3epXkyjicXylfcrJXGEpygwxxu+XQ4BneImtNDugaBe5t6veHFtI03eb6BTckVya5Wes+aDPNMNKQvGjCBpPwLUXT42ENixC9AirvirMj/6ECKSnmjH34Y8Y5tUtSAXykYiXD0YmLXFoHuQCyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864204; c=relaxed/simple;
	bh=9UxPvEhHrMdZmut3OdBnrthHV0xpsdH1wOoNBMPcH8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbLl6W0HJD7hZsAA3lLkim+PDBnwymIf5S4Jc+zSgDx99wkeOJIHn3/OOPUQZWnsCg87/76J3RcfnyndsdleaiTW7xCmFLy67WES6UA5Ec1lgbqUn1/SqYJSpunaERRT3Pi7H7HDpjb+8asf4csA4tDI14KIzgMrl6bne0fLLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnIjGYcm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24457fe9704so19123035ad.0;
        Fri, 22 Aug 2025 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755864202; x=1756469002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZcSYdiDzKo4auxwRhUJdemdmPLgAiqJ2WAJYRlHK5g=;
        b=GnIjGYcmAljHSBGz9PEeTAjeNTcIAOOU2+ceLiENVwJ+iMTed4idGMENG4fhVECzPz
         ewMNjCsFuG0HcGNJlxgHIIOyIO6Ra6BD5rUPHbg71ywm4x2qZ8CIWFyxCRiWpLgSEAtb
         AKQoiEg2b427M8ZLNa4z9w42R9yzmrEPLNgRf4qKAqG4C0lF1TrycwagbsC4lzvDtsao
         IivgMK7hm4o291MdlTx7fxa9twrBvjM6m200wHdDb98j+A31Jj5PRd8lxdV+49Ml3/aK
         J2KApJHGAeXFf/7UgAblmZR9xSbKjy6Fp/I0IGZqoKPessGLL/nTRa6uIKcnFLcWh6Dc
         MqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864202; x=1756469002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZcSYdiDzKo4auxwRhUJdemdmPLgAiqJ2WAJYRlHK5g=;
        b=EeZHimkPmAifrqcA52H2PdjxS2x/3mU8GC9NDlPVoC3a0UW/PwOUp6bEf0fcELeMVv
         pBUxFzm8FWqEWbNOJ2d3DbMh1hED8t/FvYi+eqN8jKd0qfjPAIbX8hCPfKwegk2yJqZD
         P7NTYMusYJBiZCGYys8tk2DSanl4iUkHxJbNUxuumpXIAtCA4xmElZn9Q63rYS8CB5Ux
         e4FoUTTtCaiN/hqeSr6XW8a2JJy51yBOik0OjHOmE2E9AOGtoaYl6eOxjKyDWtnMZEgX
         V5zwTTlejzeOmjCl41YawvbHBZSpznDGbLG89ceyE1x80+kPIdaDDjHXVMT2gA1+haVi
         MRGA==
X-Forwarded-Encrypted: i=1; AJvYcCU0retbqqM0VfnLbm6luos4ZNo0cFTO/GOnOi13fU+nJKn/BOITO3omhTK80QOsdcSMT81bYWiGCZKXZaw=@vger.kernel.org, AJvYcCUQ8EO2o7+0pzb/eimuOB/CfBbpuTG31ZmSvieU5SFe1H0i8yDbnSuxynnIvx1gK500ahAQwNHu@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRzD5BX1p5FUkVXhLi1mPu1qNCjExdqgaaFjtpBEqCdLhk7LL
	vg34tnpkfcaf9NA/bK0gysEH5LxMv7r1/3yDM0Z8USoekl3gbSInKCaw
X-Gm-Gg: ASbGncvWuSL8SztYHuERHESor/c4bK0h90Gy5zOYHfNWRFPLoXOHC8HbdeCBcTxCtwa
	ImkKa0CIpMvLvUtFjn1eI8oZBReH0i1DArNPd516EDjHpKuiLjs2p5BHjWCEvPgBoDWe3ZjYUze
	HJRRJEKBudblVYBbB95G8RiMirNTkVJWjP27mjJ7BGgldsJNSn6lUQsg9+Z3Rj5vmcy+5D4H1oL
	104uwG1JQW7u2pJPb8U3QJxpRjo3rExGVlS+C7nTKt2Rvwe/qSME4FYSug0B4lbh8Oqu2IrNdvN
	HeNTFsOYvZNUsT/2IvyKgJyUYCNXXnfyX4T92Khd8qJVqPQ+LtGcLw/56Z2TI4L5HbrI1GS++1K
	hL54EXeA95gQHk/9Oni1S5A/Qazw3N5kM6w6LYKpQ+QenOI9Qnv1x/Y8zf4JHi6qSYtg=
X-Google-Smtp-Source: AGHT+IEeCsBh7n4pyNwVZphqF2BHfkodaVzsANLnFEM+19+r95tz3I6+KETIyJh40SBbTlEBPYn7wQ==
X-Received: by 2002:a17:902:d48b:b0:246:4570:49df with SMTP id d9443c01a7336-24645704a50mr22344835ad.15.1755864202044;
        Fri, 22 Aug 2025 05:03:22 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245fd335ea1sm50900105ad.110.2025.08.22.05.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:03:21 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: dlink: fix multicast stats being counted incorrectly
Date: Fri, 22 Aug 2025 21:02:46 +0900
Message-ID: <20250822120246.243898-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`McstFramesRcvdOk` counts the number of received multicast packets, and
it reports the value correctly.

However, reading `McstFramesRcvdOk` clears the register to zero. As a
result, the driver was reporting only the packets since the last read,
instead of the accumulated total.

Fix this by updating the multicast statistics accumulatively instaed of
instantaneously.

Fixes: 3401299a1b9e747cbf7de2cc0c8f6376c3cbe565 ("de6*/dl2k/sundance: Move the D-Link drivers")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250821114254.3384-1-yyyynoom@gmail.com/
v2:
- Change subject `net-next` to `net`.
- Add `Fixes:` tag.
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index cc60ee454bf9..6bbf6e5584e5 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1099,7 +1099,7 @@ get_stats (struct net_device *dev)
 	dev->stats.rx_bytes += dr32(OctetRcvOk);
 	dev->stats.tx_bytes += dr32(OctetXmtOk);
 
-	dev->stats.multicast = dr32(McstFramesRcvdOk);
+	dev->stats.multicast += dr32(McstFramesRcvdOk);
 	dev->stats.collisions += dr32(SingleColFrames)
 			     +  dr32(MultiColFrames);
 
-- 
2.50.1


