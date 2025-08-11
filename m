Return-Path: <netdev+bounces-212563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40896B21392
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F66D7A2F23
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62D29BDB8;
	Mon, 11 Aug 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Ge8vB8I8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36400311C16
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934230; cv=none; b=qLQjlIsJE+brZKUpdJE+ViaZG05ypfGUNmW7C1RGkIsd4uv+NK3o73PGfPABn15NgQnMuO01IoD4/uu9b3rnjf5U8n/B6R78OTYAYoHWBLEfQ6RyDIYiPX+eALWUZZU5wWfybsDbVRurzW2T3j0XftKIjtDi7COpBUZDe1fhs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934230; c=relaxed/simple;
	bh=mIAghI0wEXYqIuYQnY9zcJxlwfuD1LQxODCLs6QxX2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cT87jRSUYgLjvX54zsAXBBvrDsUb2V7GZlLhLGBDR8XfU/L3MIiHbwK1X3pCwkG2QAik78hPbspm9f3qBqQyRlt8qmYA36WylJaTuYjYfJ1iqRgb0Vo5cNdG3RKZXb7gwouYs7pqCou1JVq6+QKs87+p6ajgGunTO8Geb1SRjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Ge8vB8I8; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30b7448b777so2824706fac.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1754934228; x=1755539028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7p1iwTrm0RW00nIdc/Ry6JTYnwNgoafuVaDrbknP3U=;
        b=Ge8vB8I8tLbeLSGOWK2Yq9oJy3CsZ/nOsuO7jU39Lw1hgP6Ln+LOATLEdkccADCzVs
         bEWp55P2irS9Ib4McYi8oqI4s0uMMsnAhrtjLAuErthSw8ZXeT806a0eyUbIlkDcypYj
         JIKscgK3BJp6GvHkzNxzUjW98o0zJh7BzGpJEN1UIKYGgxvmar7qQBsfsEImtgVW3IfC
         LzuS82/bNaTWzeWH2GaFff01vr44AguByGDgaRmnfvlqp2F0rr4cydSVnV22pRwPf8bN
         CChVB6iOtbq0sysOS0Pfbl1pADp6+ol7ZNOWrXzUrqz0MpzeVjR+n4KxIhjbHsWSzNQb
         QxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934228; x=1755539028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7p1iwTrm0RW00nIdc/Ry6JTYnwNgoafuVaDrbknP3U=;
        b=p1TTKENCfRirqlsGPe2IIh5IE7X9aKUi4p24rbWv0wq6gxCEOCUCdL6oO05yBLzYsG
         oKtdPBCArDxeXOkAHpVtp84PqgMa/zvGgwE/75VCNml7svtTO3p+VBO2poeRmjfJQ+AD
         j7JuqX+dvAuKf/iPp5lW0ZRjqhtgIfiWC6pmuocjfePa+RGUUUIevPUfjfikefgnlwLS
         U/qZ9cuEHNC4YFw6nCOAcyyp3711QRTd4IudIl+MJfRa/LbEdRYx1u04lyNaHj5w3+uN
         /I4PBph7lFEkgP+35WH9WahePihsitrCWc123Du3fljtN7EqPJ7mjQJbTbqRsfq7OnOP
         b1VA==
X-Gm-Message-State: AOJu0Yy7beTnHp16BmuTPfBjPG+pklyAzPQRPcDo17HNQgHgcHG1Jfjb
	JbaJlujrqjtb75VGT2AXQzaOnflGOW9KQfam3GqOpjCpbW/aVIy/S824eZzEjxi4UBKd/WC6U1K
	VUfRQDKk=
X-Gm-Gg: ASbGncuVXZncpd0Mb8+02nrAMAoEyd7FBVhoH9oheiQ+dOXpSxo3FSpGrblKgNK7h9f
	UXsherwBa+XneyyE6qTjPcaE28TxqtY8rSljb3ZM9wbgTmaA36ZhvGU3klasm7ClLPSP2u63fTw
	jL2rTDRGKpCCwtuk/AxuBPdY34wsxDX6lodUTbAgc/wV7KhRiLyTdHecSr7qrzzygHqFFbOHzoa
	FNPPClkc2cWJzcdqnRsB11nRfk1kHIP2/tH/f60QVxTAot5R3cwfZXjdOvlyjGGUUhmduZTO3Tk
	Xa+KHkl5I5U0xgIRyct2STil01TQbpXlU3FbW5RF1Swr8KK0PCKK7hT7hSybGUjX2Lefv3RXWwY
	VEiph/Q==
X-Google-Smtp-Source: AGHT+IGuDWCMDodfirubfHoQH+Bv15H4SSkRLxrz0iacBK9Q96DGHZP1v0JaBLhFVML0QDWoWW59Hw==
X-Received: by 2002:a05:6870:6b90:b0:2bc:7e72:2110 with SMTP id 586e51a60fabf-30c94ed08c8mr300681fac.13.1754934228218;
        Mon, 11 Aug 2025 10:43:48 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30c3a9d071csm2445138fac.16.2025.08.11.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:43:47 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] bnxt: fill data page pool with frags if PAGE_SIZE > BNXT_RX_PAGE_SIZE
Date: Mon, 11 Aug 2025 10:43:46 -0700
Message-ID: <20250811174346.1989199-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data page pool always fills the HW rx ring with pages. On arm64 with
64K pages, this will waste _at least_ 32K of memory per entry in the rx
ring.

Fix by fragmenting the pages if PAGE_SIZE > BNXT_RX_PAGE_SIZE. This
makes the data page pool the same as the header pool.

Tested with iperf3 with a small (64 entries) rx ring to encourage buffer
circulation.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5578ddcb465d..9d7631ce860f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -926,15 +926,21 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 
 static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
 					 struct bnxt_rx_ring_info *rxr,
+					 unsigned int *offset,
 					 gfp_t gfp)
 {
 	netmem_ref netmem;
 
-	netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
+	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset, BNXT_RX_PAGE_SIZE, gfp);
+	} else {
+		netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
+		*offset = 0;
+	}
 	if (!netmem)
 		return 0;
 
-	*mapping = page_pool_get_dma_addr_netmem(netmem);
+	*mapping = page_pool_get_dma_addr_netmem(netmem) + *offset;
 	return netmem;
 }
 
@@ -1029,7 +1035,7 @@ static int bnxt_alloc_rx_netmem(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	dma_addr_t mapping;
 	netmem_ref netmem;
 
-	netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, gfp);
+	netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset, gfp);
 	if (!netmem)
 		return -ENOMEM;
 
-- 
2.47.3


