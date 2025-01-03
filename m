Return-Path: <netdev+bounces-154948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125ACA00725
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3843A12F2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5CB1B87CF;
	Fri,  3 Jan 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V07MT69Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB624315E;
	Fri,  3 Jan 2025 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735897080; cv=none; b=mPAQ970z5OnknXLWERBz1GniP+buluRJHCx+WGq9mVnw0mDvXmqlefiNu1zVCgik9N3Y7IY7XcMXWg6KC3s5spvjr88cnBHbjdo1MzeG4eZJBjzUVuqdGBzptk0L4z9Ahyzx1p+7yPgzO9aHriT5Rdanp/kbI43D8wPJyY+VCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735897080; c=relaxed/simple;
	bh=95xZT4ClH5R9sYNg3yq1+LLqscT6urcKZs3KEToytsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RWJBjnxnkETSoq9khWa1777dAFkf4gkQCmn+bEoSxb6GksCXx7AhwrrxoNNvHsHh6x0oSvwYpz8/Yy40fO9snRZldnemOW0FhOjDwZeWk13y/Oa/QXqMjkEI0p0SF6RelAFzPJgZkplyHUGBrEFXV/JWnEbrKLeANEQjvNUkQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V07MT69Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166f1e589cso202880665ad.3;
        Fri, 03 Jan 2025 01:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735897078; x=1736501878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tIWKiLB8KnEZOm+SI6dbLJmqYzCWnnlF58g0NlWh4Tg=;
        b=V07MT69Z9NejO1JMQLSo73uT1nou7tSSsLZr0C6ZxQ+RvYi8z+5bk1eJOJ7spNhwt+
         FQmYY2asJNpOgSVx93krJZjhGVX0wYjB9a+7Sdd82y/gh0eOIa061D6M2+8MracJqi7+
         p3InqClk29dziNxwNRgvdaTBDSCfs20RUi9hmE/Tkyx78UA7viUDDQCdHP8F/8F5WAYO
         iTMA9wiprVCpos5taFbXKnK7G40HtQufHHxx07L0KEV2tw7FH+amFSPG5IlemVG7PXF5
         ZgFj4nBcBpmlDbAtHVF3X4CROCUaDbR8dEuAFO4S9sRqy5lh1aESBUHLVSF9QRcBUtuk
         g1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735897078; x=1736501878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIWKiLB8KnEZOm+SI6dbLJmqYzCWnnlF58g0NlWh4Tg=;
        b=OgduOvQA2WODfnXm/qubLfFlYfzS3pD2uwp+KSw8wEfnj/DBsIWkzdg0wpJz2gNu8X
         aQih2nW5mBxNrr2G0hot33M/EwBhSrBTiywfsEk8sjGt0tdZ6tD8rjQg/mi62X42p2I/
         Fpfo6v8hcaShv7BtsTkV6q1gvlxubXRWlABtih+KSpX2o1ITSh9A9yvI5q21FqknHEmu
         G+V9gFAHScq6+YOjcKo5J96c0Wegk9cslQlQ51Es1b8ikRObxtwuKhrOnWKrgzjmHQji
         AcczcMzykwKEgKhxXbI0rvvbTHpuQR4OEQ+U1HW6mzIy5evtW5ownbyOTJKV/h6Pr7Ya
         SvXA==
X-Forwarded-Encrypted: i=1; AJvYcCWr/s0z5mp6tJ7JQRchFdl/qQOfWrf/5zHHSw35FVMJgX+4TNJer4K2oTJtv6RYOpuz9zh2ZSHw7oi34zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdURCJc5XJ3rrsSg/bnPD1hdqqd0rZSCYK1xzYrIaVmEGY3IQs
	1ukSx89SpBfryeujnPXgEr9uXPTVllK5ODnzzyamFj/cSuWa7e+GR+2pKQ==
X-Gm-Gg: ASbGnctXG19MQathK9pKukqhqnzBy6yzdXO6FE6RPE5ZxEfPVfivXfzi96aaNBlsbXt
	dc36s+jBOOVEQZ95q8zlR8O3/x5vrkdghJWj7R0pmo2foj2vXu5gzH8Zc0/avc/yTzSsb3OYgNp
	C/dR7FMt0+PiWTYWHmrLexKBf2Us140euq1xawz1CRLqa4gBx+0xXKRvFX1a0x5bk85uH4zcRwQ
	/qzNsp4YLR420wI0IyvQp8N0yJYfJKlJovmb/RLNkm5dnHcw4AVoMfBW5fhtpG8wH69Sg==
X-Google-Smtp-Source: AGHT+IEsfYK7/PGJhM8Gb1hlU/h+2ggzuQZhcjiI2RfwOotYgSfS9FXc9Ht12SveoR4AdIe31Pb6mg==
X-Received: by 2002:a05:6300:7113:b0:1e6:5323:58d1 with SMTP id adf61e73a8af0-1e653235b45mr18248605637.26.1735897077548;
        Fri, 03 Jan 2025 01:37:57 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad848020sm25860479b3a.81.2025.01.03.01.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 01:37:57 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: Set dma_sync_size to zero for discarded frames
Date: Fri,  3 Jan 2025 17:37:33 +0800
Message-Id: <20250103093733.3872939-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a frame is going to be discarded by driver, this frame is never touched
by driver and the cache lines never become dirty obviously,
page_pool_recycle_direct() wastes CPU cycles on unnecessary calling of
page_pool_dma_sync_for_device() to sync entire frame.
page_pool_put_page() with sync_size setting to 0 is the proper method.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6bc10ffe7a2b..1cdbf66574b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5472,7 +5472,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
-			page_pool_recycle_direct(rx_q->page_pool, buf->page);
+			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
 			buf->page = NULL;
 			error = 1;
 			if (!priv->hwts_rx_en)
-- 
2.34.1


