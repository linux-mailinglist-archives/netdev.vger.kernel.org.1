Return-Path: <netdev+bounces-159169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38FA149B6
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C8D188E349
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16E1F707C;
	Fri, 17 Jan 2025 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUoqoekd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24E76C61;
	Fri, 17 Jan 2025 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737095318; cv=none; b=t4HydAvM0Nwl5uBtqXxAZLo2bJw31hNrj6VyM7+MEpdrGINjUZrzz5Ud2DEi02LEH3+wZz4sZwuf8QUCvvwKDzPdMv8KzhZff40tYv/XHriBfrdezMHBnBZgkySbOzeulkoJCyTLI74n3ryE69qK7mSdM2zgde1yjdJq+kA7MEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737095318; c=relaxed/simple;
	bh=LhoVCGrcd6NZUR2AHKpxDNRJZt4Gt4rOQbuC9tMVLS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pBQObns3KvWhQNSwjQmF8jp83RwOipVOLMGPdteZut8Gkbb3w/97rDHoW3UDyepDQrdyHWyfSsaDOiA7SSZEM27hNclBpQB5/aAsmFj8IGrP2/p2ZTr3UEacGAnqN+F/j9wWipkJ8QlaCGLrT0Jn/NUss2YezLuHcUgks/uK6Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUoqoekd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165448243fso39528155ad.1;
        Thu, 16 Jan 2025 22:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737095316; x=1737700116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6+Wm5CZdNlKmE1tVKo1ksQSIgVDbHTd1rV+5hkxZOM=;
        b=jUoqoekd+kq3zPwYoB0TJ3vR+Ha6gfsk+ACUy+a6zsVMNAAnScLWUD9YWmIauIjw/5
         DG55wwpZTfGpNd8Isk8uHpCRrp6UO72vfPFQWVGmleXUMDLYFqgoQ9c2ANCv5fVu0LAz
         2YJxqWVDecCzLdLfNujdxaux8HaogtslA9FV/H/5QxaRv+Yer+hw9tW21b5d1yC8IhaJ
         z98H4Q2qjIXOQKew72wUNn+01l/WBg1JX4Ubz0jJU45lMgUi1MR8bQ4dVDBkYJSK/cdV
         hmrtpZJFs4WBnf8Fht/np1lcmexkPO6WhVw/fRtNOQTsGOvCM+R2Ma/XgCCX2LqUx4Ui
         tBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737095316; x=1737700116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6+Wm5CZdNlKmE1tVKo1ksQSIgVDbHTd1rV+5hkxZOM=;
        b=Q8ue+XJ2ciYjUyXR9R/7qTdoxIls7ltacspEwZX3eAyCBBuh0rhgwnvakViRTk2Za1
         +MAIFCROI6MHz9qILucfxlx4GeKG6hxGv1kSI33+tDAEAuI/tZ9Wr2r//CLfI2/H5PTN
         77U/4nTFBBevk1tfL0RjbTLyyVe/XmI7pzkjvxBGhTLKRkdn0VjBHlkYgAgr+V0ezyAp
         FnN5ZEfND265gqueW5HX0OHS/gKx4j14Q7Y5yQKcC0HbBpFKeQM01cmKP+ZpliPkBWUo
         cI6ZiPDvXE9oFWOMiGoc4yCz9iqubgv5OWKaXevCraEXHjt5USwioXDcktV4LrCm9ovF
         Vrlg==
X-Forwarded-Encrypted: i=1; AJvYcCUihRKwODCG5uuJy49stC+GbeeKDr79vJh7N/OgQcjyehiz2jLIZOsB3z+VLafCeugXtyhtvb1037ofYdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQCjin0oXb4LhORVW0GBV57ji7MJ+Sp0iFXCXHelHJFrV0OGX
	H2v/VbLH2x7HCkTZjFSM23R1qIqVjAfdfp0BaOWMP1CYjJnwx30oQ11pTQ==
X-Gm-Gg: ASbGncuguujfgR9EfKYeobgHhJgb2zF6/4Wx0LFwQSkyP+kJyiQ6SIojGWnMWh5EBz9
	z6AKBDXkiPl/S17xaInxyUDMPl3FSqnLEDm3Qs6Sgsu/3UDmQgKSukshdr/kIonn+OYVSZX5VH5
	UUk+KcVDCCmkq4Td9PENTdkv6PtSaE+V+oci7iOBEuWvYx8KS9RRVGJ9EmSYs/J94JMT+vHAWh7
	Qlf+isf5lOoTAI2FrmSDa4XCnO+tOoE7WHm5AhVKllsDppVrmZi//4Npfq1aHCOS3EkJw==
X-Google-Smtp-Source: AGHT+IHyjC1e6YwY9YHvuL+IbiKZAbT/cPRhYH50ITXRrN4vHsd3qn4TLfhYEAimdjDDwE5QqrH7dQ==
X-Received: by 2002:a05:6a20:8428:b0:1e1:9f57:eaaf with SMTP id adf61e73a8af0-1eb2144d54amr2419536637.6.1737095315722;
        Thu, 16 Jan 2025 22:28:35 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-a9be08a6186sm1018808a12.78.2025.01.16.22.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 22:28:35 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: Drop redundant skb_mark_for_recycle() for SKB frags
Date: Fri, 17 Jan 2025 14:28:05 +0800
Message-Id: <20250117062805.192393-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit df542f669307 ("net: stmmac: Switch to zero-copy in
non-XDP RX path"), SKBs are always marked for recycle, it is redundant
to mark SKBs more than once when new frags are appended.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d99ad77a8005..edbf8994455d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5644,9 +5644,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					buf->page, buf->page_offset, buf1_len,
 					priv->dma_conf.dma_buf_sz);
-
-			/* Data payload appended into SKB */
-			skb_mark_for_recycle(skb);
 			buf->page = NULL;
 		}
 
@@ -5656,9 +5653,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					buf->sec_page, 0, buf2_len,
 					priv->dma_conf.dma_buf_sz);
-
-			/* Data payload appended into SKB */
-			skb_mark_for_recycle(skb);
 			buf->sec_page = NULL;
 		}
 
-- 
2.34.1


