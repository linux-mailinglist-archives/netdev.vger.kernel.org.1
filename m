Return-Path: <netdev+bounces-200756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F7AE6C80
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833871C22240
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2172E2F19;
	Tue, 24 Jun 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJzCLe6v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB02E2F13;
	Tue, 24 Jun 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782922; cv=none; b=WzK5w2RHqZpiJy4XSlHOYlNcOu5qcl9SFrBj45uLbiIRhdbJrOtzms+dMPLId58a2apvE8OE/tvjs99d+oLvTUdu6nldWrUYfIu0yKasAK4h/tTn5OmnECgG1bxi98Cvpei49RVoQVOPBuq0sI0E91Lz8JIE0JAtSjo/+hSaEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782922; c=relaxed/simple;
	bh=D0kBtQioBvRgs3uooJIz8gMkV3mDK6d8t6NvwidXjTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NtBuC5ALVld2hYrp45UELhVyGgmo6Si4RN9pm38SHmuxZiqauHEvy0pby3yN0K6cYqZNUrZArAnhHebXubl0+pipPDWIdTECv+2Kh3Bzk2l0eUHAOECmTECkV3V2wkLmZWyD/MU73fKTGt1lPQa9wq5KkBPAlOrd3ORiIr9aBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJzCLe6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CCEC4CEE3;
	Tue, 24 Jun 2025 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750782921;
	bh=D0kBtQioBvRgs3uooJIz8gMkV3mDK6d8t6NvwidXjTE=;
	h=From:Date:Subject:To:Cc:From;
	b=JJzCLe6vS5DxgSBqUuvg8/4mkOG/wfe35bPl/UTkQov12S45OR91nqfvdN/u6Qipv
	 CZWSKayi7gr7a16AJCPX3ZL8fUBHjHy54U3hVkMuVTH5kc1yHHBMj/CeuYM1APr1ye
	 j3tKCXLzCHbVLo/mGdOGwgXf6Pv9/xNrE3ESHE7T7wrmu57PlUj1zaUgZgesrz2IbZ
	 c8fBYoqc2iYpTBhs1MTBqdI5cSqe7NjE9FMBZHvh8m1ILdrYNEaKN80nNDenBo/MJj
	 9RnoBHm+nDqFDE7rcmVh8nfxUJsh9vtD7sftlVGw+VMhzlSJgPqskoRS7n7GTf1MpW
	 7ZrNo9IPjMvxg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 24 Jun 2025 17:35:12 +0100
Subject: [PATCH net] net: enetc: Correct endianness handling in
 _enetc_rd_reg64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL/TWmgC/x3MQQqAIBBG4avErBNKRomuEi3M/mogLFQiiO6et
 Hzw8R5KiIJEffVQxCVJjlCirSvymwsrlMylSTfaNFazQg7IXu1QLRs3gdka7qj4M2KR+38NVBC
 N7/sBq/v+DmAAAAA=
To: Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alex Marginean <alexandru.marginean@nxp.com>, imx@lists.linux.dev, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

enetc_hw.h provides two versions of _enetc_rd_reg64.
One which simply calls ioread64() when available.
And another that composes the 64-bit result from ioread32() calls.

In the second case the code appears to assume that each ioread32() call
returns a little-endian value. However both the shift and logical or
used to compose the return value would not work correctly on big endian
systems if this were the case. Moreover, this is inconsistent with the
first case where the return value of ioread64() is assumed to be in host
byte order.

It appears that the correct approach is for both versions to treat the
return value of ioread*() functions as being in host byte order. And
this patch corrects the ioread32()-based version to do so.

This is a bug but would only manifest on big endian systems
that make use of the ioread32-based implementation of _enetc_rd_reg64.
While all in-tree users of this driver are little endian and
make use of the ioread64-based implementation of _enetc_rd_reg64.
Thus, no in-tree user of this driver is affected by this bug.

Flagged by Sparse.
Compile tested only.

Cc: Wei Fang <wei.fang@nxp.com>
Fixes: 16eb4c85c964 ("enetc: Add ethtool statistics")
Closes: https://lore.kernel.org/all/AM9PR04MB850500D3FC24FE23DEFCEA158879A@AM9PR04MB8505.eurprd04.prod.outlook.com/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4098f01479bc..53e8d18c7a34 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -507,7 +507,7 @@ static inline u64 _enetc_rd_reg64(void __iomem *reg)
 		tmp = ioread32(reg + 4);
 	} while (high != tmp);
 
-	return le64_to_cpu((__le64)high << 32 | low);
+	return (u64)high << 32 | low;
 }
 #endif
 


