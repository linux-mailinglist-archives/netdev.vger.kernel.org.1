Return-Path: <netdev+bounces-158364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D292CA117CD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAB53A4F9B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6022E414;
	Wed, 15 Jan 2025 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnyK9GOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D40155303;
	Wed, 15 Jan 2025 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911664; cv=none; b=CMfQ+OLzPXnjWWBROBZrGkzuS1F8fFmayo8Ef3HTtdo/FMfaOoNRbc3a4ujlmW6DiLHu289wKG0tNHw64zytQDpSlOUXknZY6gOUFZz5exdgdVimmi9LaJMFhGT+fI7F8/ETIliOkqYVKiz386saPnz1Fd+16LUwzVuCNUFjYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911664; c=relaxed/simple;
	bh=h95hPWBFG1aitrl/HabWmrPaBlEQI2s8HlYWGMIB7CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4KQscxHiUPubgoE/ev5E2HxJtkaRf42NzU1QgBg4UcA8CgyeunVg9qaZEbUCMsPgsFTKpKfM6+Bmleq2mb4+fxXqS6Vix5pVwfkhzdo7T5vy+gE921rf/pB4BEnY6o7+kUvhl/P9Eeo9L7rGmlcDoekulXE9s1+XEeQGuhFG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnyK9GOT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21644aca3a0so137136565ad.3;
        Tue, 14 Jan 2025 19:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736911661; x=1737516461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8jofsVUx8ZDCJ6z8E8sSP3dj56gjS3NJDcAVJdYxeo=;
        b=NnyK9GOTZSvkXnW17Rvk84x+BfnV8xuBmM3RkpLgO9SiKrCHChyEHrl+NO8NKR9IKq
         tgChWglc//wg11swdwUrmaOA2VcjaSoLUyxBcmvy7PWP4ZQ9wA8foieGOClnldaG3zPw
         EkS8Qs0o/1U5rdZhAESPVJaiUUcCsWAhxGR3BoDIyOd0VX9OxHBzvm9vpwwMTgfOGNhd
         2AJjRGorr3C8QtNY+8Z2ZjstVklNifod6pAjx00eYAn1VeILbOh0dW7wwSzyayFFpi86
         coipYkYZU1qVrOU582l0pZoYOIq0fD8/JLO5Qe/SP8U3WQOCJyhjwKvW5aHeCeKmgUuV
         Fgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736911661; x=1737516461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8jofsVUx8ZDCJ6z8E8sSP3dj56gjS3NJDcAVJdYxeo=;
        b=bY54g+5UgQNkrtiB7DzgvzID5sI5Y5zUgFKBm4Xf80ePJSz0kRZhokKvFNUveB0GlI
         l6nD5/r97Z9MF+5VOYGK2ss4X0iSESHfgP4GIyIdZ+VdSb3HzDY5EwzPHR50Dxd9jXAU
         6oxxL9iI+o5oQLndEmOwdVmVhxflyc0TymehmfHSkVD5bfJes2RJFJLCDEBflkPAKG4l
         o0opzR+9wiAy+/IoSgE6PKL+TJGrVDXdlvIu07CBGFA6aXZZdmvq+nOuCEIoO6m0HwUD
         PvckXCNBOS6hy4RvA0NFQXq5aaquTKJ71qAw1sOJ3xDdj27pwT01y9x9OkLNkvmGkIDz
         OYiw==
X-Forwarded-Encrypted: i=1; AJvYcCVCGTpQ55MnGhNsMoLNVI+IBLs/atPLywbaWTO+BGTK2KsDqrdicxzn7W9JeHeRYZ3JvSh0bKEUYua8JCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiqteE9rw9YAP2/rCZRBD7ta7jdHcaBF+/XcZ2mgiXeKI0Rhkn
	n5KMyqhNv5h68Ez5PYg79/4LF5P2jurHVEAPQp7o/JoUcZBH2AjlsdS5Dw==
X-Gm-Gg: ASbGncveiXkHV/3xlQFjT9nR1+LfzDXWiuazjhoCgAQy2EMLNlus9eCROz+8VPT2oO7
	q026hn7yCusyv8+NM1o8fH2/JqejTtbmbI9JyXDtnxB0mNsakcJ+FgoXq2COWlcTcZ86cthrdzq
	PfoFN4JrmkMdOUTCzojhOFsZNSWT8l/C0/oDBZsCeJBUJ5taINRGOIYo3U8pavqkKNOgpFLd4NS
	ZSYP3oD1RQKAiL4K6tYTK5C6cY2waLNkPXroXtfVaQQ2D3Pqa6j/zbcO9s+bDMLc7EVXA==
X-Google-Smtp-Source: AGHT+IH3vKpIs9HEB7OG2AlV/K4DtSeYgzdkPcn7TCEV2c0jCWcevtA7LwBwelnqC2AKojzBKBFAxQ==
X-Received: by 2002:a05:6a00:3c93:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-72d21f4537emr43075844b3a.3.1736911661159;
        Tue, 14 Jan 2025 19:27:41 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d405493basm8166452b3a.27.2025.01.14.19.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:27:40 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 3/4] net: stmmac: Optimize cache prefetch in RX path
Date: Wed, 15 Jan 2025 11:27:04 +0800
Message-Id: <2574b35be4a9ccf6c4b1788c854fe8c13951f9d5.1736910454.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736910454.git.0x1207@gmail.com>
References: <cover.1736910454.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code prefetches cache lines for the received frame first, and
then dma_sync_single_for_cpu() against this frame, this is wrong.
Cache prefetch should be triggered after dma_sync_single_for_cpu().

This patch brings ~2.8% driver performance improvement in a TCP RX
throughput test with iPerf tool on a single isolated Cortex-A65 CPU
core, 2.84 Gbits/sec increased to 2.92 Gbits/sec.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 811e2d372abf..ad928e8e21a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5508,10 +5508,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		/* Buffer is good. Go on. */
 
-		prefetch(page_address(buf->page) + buf->page_offset);
-		if (buf->sec_page)
-			prefetch(page_address(buf->sec_page));
-
 		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
 		len += buf1_len;
 		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
@@ -5533,6 +5529,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
+			prefetch(page_address(buf->page) + buf->page_offset);
 
 			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
-- 
2.34.1


