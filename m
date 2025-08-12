Return-Path: <netdev+bounces-213075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D188B233E6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C801A207EF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399DF2FE571;
	Tue, 12 Aug 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="r06eBA22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC921ABD0
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023353; cv=none; b=TKltVRYCVqRGx2r4gyy8o4+KuIZN+cVxGtFYeFJhrs8YTHh8rvsqXyJQmEjIYSUXgHax95qC5CxqB7941uJVCuHgAu30mXrafm/jjHzGG8GXWx+lkE4ZotMQRDO3+DK06bwP63I1pvpulyHM2HD7lu9/lESWna64mgFsYvknsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023353; c=relaxed/simple;
	bh=9cvbpPm70mPTLnQnb8LNgteV2j+EN/EMi23cYTH5HS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXvb7STw5UPpzxzFKLMBvWjkgDLxX6N1zZSqSxycwP9eAK6mI7Z1bTFwXRiXTXOI7cPwcN90Rjo37Rg9dTEZLqrEW2icPude7+JsZzdQgloUzR+KdnP1TGGlf4SgSLcBRibT0VRKKXcYAplm4xGy2iQLQoepUqYrwhGVCp1Q2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=r06eBA22; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-433f984817dso3380037b6e.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1755023349; x=1755628149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1zoRIoChFfpVQ/VzzUdPKbZVPd/NiA//NidJrIFR78=;
        b=r06eBA226rL6Y0uCHoI7rfPawceRXVt9JvH6u+xObW7ulllxrw9xwhGDAvMykfue5u
         DVN86SlWePq9oEt2i0rsNB1hyAeLOE7ePFXcjLq0XJFjK0wfzQMJUJQaq6zJnOCaoeQf
         GMgW+YZOV+hnnfUhAYZBCyjLAd7fqxEDdUyBJhhtQv+gGcIIINg22PpN8U4LRK+Nr66I
         hNsaKcUP1E14rgISBCzo3eJRlfW77cM64z0hth5CMfIq/KVNBRLlEOy21juLO8mj1juv
         TwlGDoy8bzE6jMg7+hHJMLqo6itQsuGFxYXkDBBUjQQPEPZsMp5EeIEGgRGsdlndQxzx
         6eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755023349; x=1755628149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1zoRIoChFfpVQ/VzzUdPKbZVPd/NiA//NidJrIFR78=;
        b=Vv5GgqFnI9aXvuU+Xm0ozlbVNAjLc52JxOhX4/lcU8+P6FCptsFfq4BTHDdJY0nUCS
         KhvmoBBX6fagS8cw8w4hLxLM8qVduSMc421jHgEo07iRcfMo8YpiIi6D/wW1Lv3dI+3Q
         135uTDVnrz87vZC2eXUf2azdMUTCIAWJiqGrdStb2gMOMMWQPr6qTJXHvwMZCdqPW3KN
         8Yofq/pzTqb/yHJQz7agf6XwheOmNyutMi9t4xCPuhSdqcEK/gPA2fAhDOH5jpD1qIPB
         nV0z/LtBg0uCBsnm3Ft82UDLMBNayNR/k6j7cW6wfK+LMs0s6062RsHxffjjgeYqMe8U
         etmA==
X-Gm-Message-State: AOJu0YwuZtXKkiP5+Y5Fztyr+QSH7mLZLSqGYlZpo8jubqmcoq47KLfK
	GC9BLN/v12iSVtiaG6VlQIUMEl33g/+S20GuhqB3myMznej2PV4R+dLbzaSGhI3IMsGDzYxptjN
	MZLwT
X-Gm-Gg: ASbGncvnwWoq+7Hkfg6jWNnovmIa081hfNwkjYzmKLuH5x+cqc+3EZFSVvoiniqyIM/
	dibmoXeiFiNrQFFNlN8P9PwUqZIa1kTcHs7laqXHFjQaPyEzBZMBvONRnQu/9jDn2CJtE5kywJq
	7At9/Y1ny5IAh9wN4aF4TGV6suOkBjuybqYgoEEuR533BFrGatscyRZtKTHqRq9ygOJwMac7YOO
	s+GzrW9jwCT99bj/0EmRDtvvgq4JIhY5+UyP6xKv8rlUQCXc0gfb5ccbqENyVbfgeZ/7ERNr9Er
	avrysoUh6Gg6FF0h0+bVD17WkooUeE3AzOWn1aX34TYLILILDzZ95wFyHeQhR7BST4f1dp0E8b9
	Fu10B/QnY
X-Google-Smtp-Source: AGHT+IGlttcc9W2jmEMajS0OhnGe++xuh77FZzst/YkiW1TC+nLFyH3ZZjkWQN99AwUwobFKl4DZKg==
X-Received: by 2002:a05:6808:1992:b0:434:12a9:db06 with SMTP id 5614622812f47-435d42214c4mr268801b6e.26.1755023349627;
        Tue, 12 Aug 2025 11:29:09 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30bc9ede835sm5739938fac.32.2025.08.12.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:29:09 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH net-next v2] bnxt: fill data page pool with frags if PAGE_SIZE > BNXT_RX_PAGE_SIZE
Date: Tue, 12 Aug 2025 11:29:07 -0700
Message-ID: <20250812182907.1540755-1-dw@davidwei.uk>
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

Fixes: cd1fafe7da1f ("eth: bnxt: add support rx side device memory TCP")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
v2:
 - add Fixes tag

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


