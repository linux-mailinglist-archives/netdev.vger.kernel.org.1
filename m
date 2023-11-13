Return-Path: <netdev+bounces-47420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543A7EA255
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68D4B2099D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836B8224FD;
	Mon, 13 Nov 2023 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="Wb0g/zz9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA1D224ED
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:49:33 +0000 (UTC)
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE310F4
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:49:32 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 0143844064C;
	Mon, 13 Nov 2023 19:41:52 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699897313;
	bh=RLd7CYtbOxJsDnFRd7kaDxKZyPo0aj/FzvTE9nAfQmU=;
	h=From:To:Cc:Subject:Date:From;
	b=Wb0g/zz9WwdVDaGM5a1dhHMrBJ8097vMj2KraGTyzlTY3lIHs9rG8Tt7pWx69zRyG
	 c8U5IujyC1oIPJUpBaTP4+hKTQl0ZA2gxZcEwSLO4ZyAnkldQbk7hOHKXIgPj7sgbm
	 HRNp6M6Olib4Re0CzZ9lc8jOOFV7pzKM32fXFTupHjM84t8PeuLr8pXkVCxoAGOuZ0
	 xoXXhLVuIZ4BF7Q2FMxJn4XUQnso7pVNVXGjL2C1heI+6tEOoeynTtxePNo79KY9M/
	 GtCKp+J2v9zy/E3itMXx5Gy2tASdu/DPR2AADj1DWCvtZua0onVdWUMU6Sk0hly83y
	 aUJhnpbu8r81w==
From: Baruch Siach <baruch@tkos.co.il>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net 1/2] net: stmmac: fix rx budget limit check
Date: Mon, 13 Nov 2023 19:42:49 +0200
Message-ID: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while loop condition verifies 'count < limit'. Neither value change
before the 'count >= limit' check. As is this check is dead code. But
code inspection reveals a code path that modifies 'count' and then goto
'drain_data' and back to 'read_again'. So there is a need to verify
count value sanity after 'read_again'.

Move 'read_again' up to fix the count limit check.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd53a617..f28838c8cdb3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5328,10 +5328,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			len = 0;
 		}
 
+read_again:
 		if (count >= limit)
 			break;
 
-read_again:
 		buf1_len = 0;
 		buf2_len = 0;
 		entry = next_entry;
-- 
2.42.0


