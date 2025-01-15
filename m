Return-Path: <netdev+bounces-158363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C72A117CA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23441889742
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9922E3E6;
	Wed, 15 Jan 2025 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9B0ecly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D422F394;
	Wed, 15 Jan 2025 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911659; cv=none; b=VkMDCH3wtmgtAF3GBwxbAlO8e0iOuJW8CLGhij3vUNpR9/q9a232nZ+u/ldjllnb6q/64uJ8Syqnxe+j0bHxOkYhEgnjhKZtEFjheL6KftozgDCWoq7YX/tnjSmE+sw/q7jrMJEjhuEGaw57xSl2+xT74bYS6I/NFh+DrnWojKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911659; c=relaxed/simple;
	bh=uMwbCf7sFcsA9X+hAd0RGlXwIc3DrBZUKSKTBT/eyVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnSjupKrvSeU+tBT9iw/5jJ/+F9/CDc5HCy2yvrf/Qe3mGkbu/2CC2SXFmMJApY+49clIN10spcbXUOxgyUM9hoFz0LEqrPwE/zxTKkmAU05Pgu1gzdtn1F8GeHZyrFJxBvVWT5q+r8nF1gZNYscoI+/9B9J47iHJ3SYQBLy3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9B0ecly; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163bd70069so113495845ad.0;
        Tue, 14 Jan 2025 19:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736911656; x=1737516456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UUplh7fAcpeM7Q5zE9FRPEWMTlb68cB4RMo0G5W1ro=;
        b=j9B0eclyP5w0qZbwI+em+Pqt9W2B5qf30fyAHSFkZHpvF7Xu4sx5//eCTGyxUK49l+
         AJSNEiq6m46F/kK5DpNcRkHTnm9Or+AnsJ+kzoQIyD7W0c26UteBC9n9ECnjnbPbKPvV
         Ywu8mv1gcEpMOyh7k9r7JDu6JCcC0+hJlQy6q/9ud2SRZnN0Erh2RhvuL338GM3T29vO
         dtIW6pELewKneAxaj2QwnIjmdVXgA86tA9NuTDiL5I8IAkeFIn5vIaakpInJUrX5UjcO
         Ali9SGR22/Ah40fMIrhn0683qpkLwKvgYV15i6RHTi156xGunGCmm4/jSR9V3HS03ozC
         jpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736911656; x=1737516456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UUplh7fAcpeM7Q5zE9FRPEWMTlb68cB4RMo0G5W1ro=;
        b=d8FbkNoWe8KIQYWyVY64G6+IllH9cP8Z0QfDYpDJsq4Pje4Dc7XUX+KKkqAnQQT01y
         vX8FxHj5FTrkppVaE9w6zrTq3R2eUw48QrDQF0eVVsFSkTHutgOMV1hs39Qx41HPKLSn
         mkqfwS3oMYJScsc50FTptd8poxya8m73UaHVGNeQmZPwtvdbwgZuUNY1yW5JUbWi2w4b
         CcHuFwRxLIeN+FF1IqR9M78bURVnQHNyVqbYePa47l4AFew5fWRALrAvUosKjgZirYqy
         Meu87/TSnkoi+qYX9mYgvwCl3CBrgyRZPYlHK8acahWPdQB6hHFQe2os4cP1EQf/e16G
         zs+g==
X-Forwarded-Encrypted: i=1; AJvYcCV2x+Tjo5iDjl47NPe/HOtH4HeygcPmypLJhnIbOZyi51TAO21Ypv+GQ6S+9eHvUf2mjZnhqcBjMMYH/b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ydx9r+KHPV8Q8lWtPpdplkdX+ayD9ROfvpfGfoPd+LZMKFSV
	TWfBrcqZ1f8Xd4ytiFZE37MZLuveXIA1TqDPTafHFg/+FfYI9oKRNOnOCA==
X-Gm-Gg: ASbGncuGywbx4s4rwzm/zpsJaKRJXnEZhYeFIRLgjfZP+b0Z8n/z63U84hzSKEHyRcb
	vo7KtDlmfI7PwF6vHNzqZNqOEFeANg8dse3FUzryyJZLZHOf/+vikRGlRXY8VOabAUYwBRL0YAd
	EQfN9hjOl8JHy5/2QUMT5gGI/GW9c/rGqs5cTTp9Y9P/8D2Za/icV/WVx266GRw0NlNWWt9HQA+
	oCWqMF9kW3cQaEYXwOBcDJqojpLzfY6Lo5nUyKao6YAzphrjIU+S/tzlc7eLfJM5uPbKw==
X-Google-Smtp-Source: AGHT+IFNvLpuNXbqq/IV5KYaf3Nik/z1qK9SvaIPNMSsFV2O8gjEl3T3nKlKoNCJXm0ou755RaN0PQ==
X-Received: by 2002:a05:6a00:340c:b0:725:e015:908d with SMTP id d2e1a72fcca58-72d21f459b9mr35478358b3a.1.1736911656332;
        Tue, 14 Jan 2025 19:27:36 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d405493basm8166452b3a.27.2025.01.14.19.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:27:35 -0800 (PST)
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
Subject: [PATCH net-next v3 2/4] net: stmmac: Set page_pool_params.max_len to a precise size
Date: Wed, 15 Jan 2025 11:27:03 +0800
Message-Id: <538f87c8bdd0ba9e2b9cb5cd0e2964511c001890.1736910454.git.0x1207@gmail.com>
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

DMA engine will always write no more than dma_buf_sz bytes of a received
frame into a page buffer, the remaining spaces are unused or used by CPU
exclusively.
Setting page_pool_params.max_len to almost the full size of page(s) helps
nothing more, but wastes more CPU cycles on cache maintenance.

For a standard MTU of 1500, then dma_buf_sz is assigned to 1536, and this
patch brings ~16.9% driver performance improvement in a TCP RX
throughput test with iPerf tool on a single isolated Cortex-A65 CPU
core, from 2.43 Gbits/sec increased to 2.84 Gbits/sec.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1d98a5e8c98c..811e2d372abf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2059,7 +2059,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	pp_params.dev = priv->device;
 	pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 	pp_params.offset = stmmac_rx_offset(priv);
-	pp_params.max_len = STMMAC_MAX_RX_BUF_SIZE(num_pages);
+	pp_params.max_len = dma_conf->dma_buf_sz;
 
 	rx_q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(rx_q->page_pool)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h
index 896dc987d4ef..77ce8cfbe976 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h
@@ -4,7 +4,6 @@
 #ifndef _STMMAC_XDP_H_
 #define _STMMAC_XDP_H_
 
-#define STMMAC_MAX_RX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - XDP_PACKET_HEADROOM)
 #define STMMAC_RX_DMA_ATTR	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 
 int stmmac_xdp_setup_pool(struct stmmac_priv *priv, struct xsk_buff_pool *pool,
-- 
2.34.1


