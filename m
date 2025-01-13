Return-Path: <netdev+bounces-157761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C692A0B950
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CF1885603
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88132451CC;
	Mon, 13 Jan 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPu75jIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AEF1CAA80;
	Mon, 13 Jan 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778069; cv=none; b=qh959P3JEHLR+cx57MNQFSgRED0yQRxftUMqu83sWOKT68jR8gQn6Vj4o6Mb6ATZRqETJxaaWklqdaK4HTMHKH3ZMumJ9UoKQS+K7Rvv9H89ANIqYF9XGI6hQQy15Fldp+plUUr3jkfllvE/TAIlPU9NuH5LI5TPOSyNch4giLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778069; c=relaxed/simple;
	bh=MKWAKejBR93uTWtWIK4+DOobUQNzCP/ozdxmNfH+pkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjM6cA/Uvw1z/+CNJhzUgoMtFeK9IItmlFChLXUPR5O3T9q+6ONoRcHT8DYHUuRCAE0T+aYUFTAfm5sPEcmWVacOqpTID0B8VFSh5llQ7P7jLh5a2f97rB/dG2f0gjyb32Ob9UpgXrIxX1x1aTqa81osOsi3ly+wcrSm5sB71bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPu75jIu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163b0c09afso78197155ad.0;
        Mon, 13 Jan 2025 06:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736778067; x=1737382867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y3BfZz7MekY1Z7yjTuQ+MWMRBeT+ElDKi7mbMigxYQ=;
        b=KPu75jIuz6D2Q0kjnPqE5fImfBGRzGkmix77AzM5BKdAxyt2mvcUCXKtcBNFO6sdaa
         gmXJXTKeKTUFShaS7QFtDGN2UKE2aiKmC6VEYiifpwxdvnH6cwzdm2RqJxcmFl5QrkwS
         utQPzEWkJ+m+TAS9ONLFvPQlAGoZCIoeY5yoSLJZ4wDSSDxc/poVSElqwisvwIYw5M1k
         1biqwty/Ms8NikY1FDSHHzowMHXjUugjC7wEMD7ogR9hZY3cZzosfUX4DedDWKrsSdNH
         MnFbrXuzcRhRbyI0SYcpq90TuD2P2J6BXFLT4VlefxcaUi1WMaRYyqeh0Y45X56dpaa9
         iq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778067; x=1737382867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y3BfZz7MekY1Z7yjTuQ+MWMRBeT+ElDKi7mbMigxYQ=;
        b=rYYU5OefXU3DXhiwchGYCgMlfj6w/cuiP8VSuIul1tn24/WrmgMo0cuN0xGlheMb9m
         P+k8b+5K4jb6CAWzuQ3c0LouG9s0rZALJ9Sm1mX6Z8PlN8e9igMKV5Jhn/yQg9Jg92gm
         KvbBpijPILV1pyLnqiO7oeHJdIGOgwcGTzAMIC1Dh6+MWOs5lI+xFN76dR6a/S7M5/cT
         fr2KE736Qxvb7gPNy+ZC2o/5upk/g4rA3zHlyWkBMbqtnJDSzxlhQVqF/BoFi7BDfDuk
         1GPy/c8eWWaliSLrdzpV45ui4SeL4JD7rf2/eGqNnJd/4Z6QU+t1B89YVNEeZGB0+Eao
         6XCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZGo6nSNku1P6A9Qg8nmQiMbda6E+AeiOd4OOtp7FycMHcKwcqE5jIaiauNTZq7lVf8AN+uetUxgns+nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdVKpCEavBhYh9d/Jp6M64G8qbn/Ys+F/Sp+W+M6eqmYE/lJXv
	/2Nv4x9O/fdEF7+7B8nxrBxiFVXwS7mrp7jOvESmqerLjVM61grlQBBvkA==
X-Gm-Gg: ASbGncswHnKLV9K/QjmysSt3KHI/v0bp0rdLgaAknyjMMlDi/6k+1+hHtl4U8alhmRe
	GyyvUEe7Kn1yMP8o+l/c3sXIdM9wGjUkU8RW8Bz8ujdi0gZygcwgSHy907IeODdk3HYQkvyN6uC
	QMKZdO7K29j6cNGvWaH7iJ5vhbmX0k2Fh2I56RTpIYUGH8qmftu8Zbr753osWddsIfVl9xvAUl3
	EJiatBcPoPR1MgIfYbiEi8M4CG+FzhpWhxT63Yoswt6H84omH6CM7aWqYP06EIcSu4JBA==
X-Google-Smtp-Source: AGHT+IFg3sXPhg66pW+bXzniVJ+GWukBtXItLNm4Jyw30Z7qC0CWxK5D402KdXwOTZ+TRgV9PNNiUg==
X-Received: by 2002:a05:6a00:4603:b0:728:e745:23cd with SMTP id d2e1a72fcca58-72d21f113a1mr32141933b3a.3.1736778066667;
        Mon, 13 Jan 2025 06:21:06 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d4067f0d1sm6089222b3a.136.2025.01.13.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:21:06 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 3/3] net: stmmac: Optimize cache prefetch in RX path
Date: Mon, 13 Jan 2025 22:20:31 +0800
Message-Id: <668cfa117e41a0f1325593c94f6bb739c3bb38da.1736777576.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736777576.git.0x1207@gmail.com>
References: <cover.1736777576.git.0x1207@gmail.com>
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
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ca340fd8c937..b60f2f27140c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5500,10 +5500,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		/* Buffer is good. Go on. */
 
-		prefetch(page_address(buf->page) + buf->page_offset);
-		if (buf->sec_page)
-			prefetch(page_address(buf->sec_page));
-
 		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
 		len += buf1_len;
 		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
@@ -5525,6 +5521,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
+			prefetch(page_address(buf->page) + buf->page_offset);
 
 			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
-- 
2.34.1


