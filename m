Return-Path: <netdev+bounces-170001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC1BA46D19
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FB41887C06
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0925C70E;
	Wed, 26 Feb 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxfHq/rm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D725C6F1
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604221; cv=none; b=Htcv7ufnpCrB81UNv1D3wmT70IFwH7TOmauAG3hbyudp/nh5hOhuuIMAh+IgtnHlc4jZkJppGoIl06xIWcU0dzpWkUAikdvoxuUfSc9OpGcKrvVGTvUcnvRztcz3gmfyjdye55tKaKH3ESKhzH6kiiezsthIAoeoY4dBywA9HeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604221; c=relaxed/simple;
	bh=iYvzApH6qU60kywYPgEBLorFXiBnZ0dDRWgxRggABjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvBs8p8ByasRHMtFdN3QHVi2j7z5tDvLQHQtCOeLkK8OlSsq+d3ZV794nCOqVTd1BtiGAhHsDPHwDhfgRvAgBqZeUnq0gEgpLzaiDxqwpdZj8EXvi1+m7hYqULCcFDca4qpXRiKS5wjSML6seRWrgPM5TZwmDzBAXtm1wT+8fuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxfHq/rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AECC4CEEE;
	Wed, 26 Feb 2025 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604220;
	bh=iYvzApH6qU60kywYPgEBLorFXiBnZ0dDRWgxRggABjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxfHq/rm5OQA1GMHyMI7o1V4Ypf7iz9V3Da0P2HjlQnjmqIP77k475xRdf78T4x6z
	 4ch5jQNnYxHf302OFkzLr+kVuU1zCUDy6OqJ9duYLg73WlaSTEl5rsRb00z7d4rMQh
	 xt3irNKf4hLXWTBGuTHwDAhJncC4O44jALAuoUC/d7SyMQNgRXQWobadoftdDDnl13
	 forg0NEbsqzgbLCisTfhWevonuZ9H3fy+J/UyC3+2VzHixhW4+ndZi3SQ8ivNsz/yD
	 ikZKAyK6nxgjIXJNW+erCX9IY+PhJPS21vvmZTGvuw3V8Z2NW4Q7p/eThBZ51dwd7r
	 uK3KLF8VKfQCA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/9] eth: bnxt: consolidate the GRO-but-not-really paths in bnxt_gro_skb()
Date: Wed, 26 Feb 2025 13:10:00 -0800
Message-ID: <20250226211003.2790916-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211003.2790916-1-kuba@kernel.org>
References: <20250226211003.2790916-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_tpa_end() skips calling bnxt_gro_skb() if it determines that GRO
should not be performed. For ease of packet counting pass the gro bool
into bnxt_gro_skb(), this way we have a single branch thru which all
non-GRO packets coming out of bnxt_tpa_end() should pass.

bnxt_gro_skb() is a static inline with a single caller, it will
be inlined so there is no concern about adding an extra call.

seg count will now be extracted every time, but tpa_end is touched
by bnxt_tpa_end(), the field extraction will make no practical
difference.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 497bc81ecdb9..113989b9b8cb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1735,6 +1735,7 @@ static struct sk_buff *bnxt_gro_func_5730x(struct bnxt_tpa_info *tpa_info,
 }
 
 static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
+					   bool gro,
 					   struct bnxt_tpa_info *tpa_info,
 					   struct rx_tpa_end_cmp *tpa_end,
 					   struct rx_tpa_end_cmp_ext *tpa_end1,
@@ -1744,7 +1745,7 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	u16 segs;
 
 	segs = TPA_END_TPA_SEGS(tpa_end);
-	if (segs == 1 || !IS_ENABLED(CONFIG_INET))
+	if (!gro || segs == 1 || !IS_ENABLED(CONFIG_INET))
 		return skb;
 
 	NAPI_GRO_CB(skb)->count = segs;
@@ -1917,10 +1918,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 			(tpa_info->flags2 & RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3;
 	}
 
-	if (gro)
-		skb = bnxt_gro_skb(bp, tpa_info, tpa_end, tpa_end1, skb);
-
-	return skb;
+	return bnxt_gro_skb(bp, gro, tpa_info, tpa_end, tpa_end1, skb);
 }
 
 static void bnxt_tpa_agg(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-- 
2.48.1


