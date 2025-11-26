Return-Path: <netdev+bounces-241758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E8C87FCC
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DAD3B551A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F121B9F6;
	Wed, 26 Nov 2025 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omwPyLTT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1928F4A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764128909; cv=none; b=uw49cK7BgeXF7XXozEYw6QbSV1YyR0TP34eh74e53Ms+Y9iQCC/QRyy+Ras4nWb3KayE4FVKexazBrqSniUCEqWWPekUeH2yzFt7GV4ikkGpbaglEBCtzdHgavMgkz6bkA4LEwllPqEFi5IxmUPZaJURcF1IfPJ8gDfUOK7Rx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764128909; c=relaxed/simple;
	bh=OdMN/FDBC80O8eYSD4SG8XhyHgk14P0ZHOoLxwGbU3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hks/RFvDWgCWrnbhPk1CVWCO7O7+81jQ2+qpMIGYwx5aXAn/MnFFAZBfgrLzSjqq6qUkqoTOcCfKj5L5ec6e5U3bZvtRc6ZnSs0xRBLkGa7mR4vFmMBbNJ1cI0SQLuVBYmWitEgXHeJkFk0VQ4A1WfnyrQn0BuhcF0ajnmLIZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omwPyLTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1E1C113D0;
	Wed, 26 Nov 2025 03:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764128909;
	bh=OdMN/FDBC80O8eYSD4SG8XhyHgk14P0ZHOoLxwGbU3U=;
	h=From:To:Cc:Subject:Date:From;
	b=omwPyLTTBOadwUvasqRTydAK9UsgZVvDqLxYUGP3xA1S9aWVZzywZQO+ET0qzPfoZ
	 2DcbX4qn1JPFaIscrOgdJ6ntBg1nbOaMJketlcI0bSYhQz73oNE/dH9GDFhR+U/3D/
	 fmFAnx76lRMPJDbOHMSX96Jedfon3F5oM2YGZ86gqBlWEFQOuqQqOZRmrErMIP61Ul
	 nL44l9oe0V8jDN1hHKEtqFUWUvn2PqBR4W3Q7jzDnFDujwGVctVkiWlS91YzjVW6gZ
	 l/Y1jOeX7RYEM8t0Mz3z54mnh9OQlNzt0oUwB40fstceZ6T6eTiL3syXv2aamlGIF5
	 VBC6oBgGdyleA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next] eth: bnxt: make use of napi_consume_skb()
Date: Tue, 25 Nov 2025 19:48:19 -0800
Message-ID: <20251126034819.1705444-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As those following recent changes from Eric know very well
using NAPI skb cache is crucial to achieve good perf, at
least on recent AMD platforms. Make sure bnxt feeds the skb
cache with Tx skbs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a625e7c311dd..8f95f5f29e00 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -877,7 +877,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 next_tx_int:
 		cons = NEXT_TX(cons);
 
-		dev_consume_skb_any(skb);
+		napi_consume_skb(skb, budget);
 	}
 
 	WRITE_ONCE(txr->tx_cons, cons);
-- 
2.51.1


