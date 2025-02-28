Return-Path: <netdev+bounces-170486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D8AA48DE3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34063B6B4F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF812CD8B;
	Fri, 28 Feb 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwY52ewI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369083CC7
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705940; cv=none; b=Tx0ySpdx+IYGdvEPyKmX0FY4W3mfhwRLH/bBerLTZi4n6VdwK4TVkgnsgsPECxMjp8Q1NMFzvr1nb7jNC168QMBkebzqxbIm+j0CjTU/I7Vd0GO9O0I7rKiZVY9UiXheKUDgFJesUHseOO2zjxKfr+69umwZ9bqt6kcxP7i3Gfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705940; c=relaxed/simple;
	bh=rPu4Nxyd868c8K2rrv54fo5Fl0/IOOX9E9WYzTt3cCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhbF8pn2vHrzM24e6UUvEJEOTAYytcUWFEN1N/6Z9rFPNicvUT2fbM8oiWsXf964PdjJaV+Jrse2bPsEA48PSOFIb6naby9Kl2CliqonhrSIb8dg/iEnttf4LxF13JFUQ9oqBzkxO0ayfqtuHDE26aJKpdw5NgjrP5moUEEkCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwY52ewI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B8CC4CEDD;
	Fri, 28 Feb 2025 01:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705939;
	bh=rPu4Nxyd868c8K2rrv54fo5Fl0/IOOX9E9WYzTt3cCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwY52ewIPRmFR9aIt5xSaXcvcjfC2N0to/mrNVDw21tM7Aakf0H/W1uM0EJioZQuC
	 ThBJs22b9OphvW3HoeG91+oQuRXC/gVbnlpDQVRBFeRLLVOdzaaimQmeNFyq4f8hal
	 W/irYrc0Ou+xeEx/cxETVF5dc4iEekuKkF+hZXt1tTNUacx8yXM4T3P59gAGM6Pv/t
	 ppaHALmteW0KHILbzmLROBVtd9ZyXoGZPCRtCG0upmXSQfRzpS7UZOHz49xYMrdfhP
	 Eu+AsG3kCTocnKJ7WQY0lqCz5qv2yDtVH8PS2tZ7jISDakCjMXBa4ASCOrC2Xpyy9o
	 U2D8ac9vnPT/w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/9] eth: bnxt: don't use ifdef to check for CONFIG_INET in GRO
Date: Thu, 27 Feb 2025 17:25:30 -0800
Message-ID: <20250228012534.3460918-6-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228012534.3460918-1-kuba@kernel.org>
References: <20250228012534.3460918-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use IS_ENABLED(CONFIG_INET) to make the code easier to refactor.
Now all packets which did not go thru GRO will exit in the same
branch.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 854e7ec5390b..d8a24a8bcfe8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1740,12 +1740,11 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 					   struct rx_tpa_end_cmp_ext *tpa_end1,
 					   struct sk_buff *skb)
 {
-#ifdef CONFIG_INET
 	int payload_off;
 	u16 segs;
 
 	segs = TPA_END_TPA_SEGS(tpa_end);
-	if (segs == 1)
+	if (segs == 1 || !IS_ENABLED(CONFIG_INET))
 		return skb;
 
 	NAPI_GRO_CB(skb)->count = segs;
@@ -1759,7 +1758,6 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	skb = bp->gro_func(tpa_info, payload_off, TPA_END_GRO_TS(tpa_end), skb);
 	if (likely(skb))
 		tcp_gro_complete(skb);
-#endif
 	return skb;
 }
 
-- 
2.48.1


