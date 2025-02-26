Return-Path: <netdev+bounces-169996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 212DFA46D14
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA6516B465
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739BA258CE6;
	Wed, 26 Feb 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+bVolqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E82586ED
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604219; cv=none; b=ICXR/QWQ8KNU0lGCQF3+Qq/EVqeCTB9JxAMIWwcWe5c0CE5V7Awv/6G+dyOcdi27BPk1/YuqgvKRQS/l2dorQ1bCdgHZlmwwHtVkfwGa1zSX26YbbbiyPwAggBCRpznaFdi/LfsFXl1I0plFRjMwwWGCDF5oWLxaRgAZZ0LW3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604219; c=relaxed/simple;
	bh=xlfesCAYFJuORciIZ6LM+t4QFT/GvQSC3mgpWimbL/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NY81NysGEN2lb1V6EnSP4ikFXfxR0FeGxYYKErIbRK3QuV84+3GDeRGvJoA3xW5qKh9XRJPartWy6I+XlkR9yXvxL5+Fmhi/c3q6aTe2Hn46HGHJq15UOHnu/b6S6B/m82TJ+g9EjlolC4VVWa0vgXcb7uE0fTYBWSXVZONceSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+bVolqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867CAC4CEE7;
	Wed, 26 Feb 2025 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604218;
	bh=xlfesCAYFJuORciIZ6LM+t4QFT/GvQSC3mgpWimbL/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+bVolqZx5kBorTC6tmzK334j46J9CimKYKEUOoxxvFH/k8juFqwgbUn+lZ0qFHk+
	 dzW+hI84FZV8LO4vFvM3oJfCTSWahskR0qDF98dC4OobcVL2fPWQciImaZONVyz2TG
	 PLHrYwwj+PCv/EsCyT+EnGd50fiJe+kWbchwyTjsh0mbhsFtBQEj335rMr1SjhVKIN
	 vFfDAI5bXjqOLzO75hTpTXklgoqbeuZk9zL5WZ0ZNRYIdCWYQkmJJRlJJQXYqbAWpS
	 eZQGMD8A9enqw9INS1LwLjtQGfOebUMvhkBBUPPZlLAcSSiDOPku121dPlb2IZLEEI
	 w90qUwsvWwabA==
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
Subject: [PATCH net-next 1/9] eth: bnxt: use napi_consume_skb()
Date: Wed, 26 Feb 2025 13:09:55 -0800
Message-ID: <20250226211003.2790916-2-kuba@kernel.org>
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

Use napi_consume_skb() to improve skb recycling.
__bnxt_tx_int() already has the real NAPI passed in budget.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 15c57a06ecaf..f6a26f6f85bb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -855,7 +855,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 next_tx_int:
 		cons = NEXT_TX(cons);
 
-		dev_consume_skb_any(skb);
+		napi_consume_skb(skb, budget);
 	}
 
 	WRITE_ONCE(txr->tx_cons, cons);
-- 
2.48.1


