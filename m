Return-Path: <netdev+bounces-189219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A3DAB12AC
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99B71C42775
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64B294A02;
	Fri,  9 May 2025 11:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5EA2918D5;
	Fri,  9 May 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791512; cv=none; b=eFOWpuduJzlCyJ85jv1pN02eMfI3RcuO578Gk1Fqm4bLok2LHYVpLZ5R5LkgZedEz1lxxWVzCLnjGMrx4fBiXyBCSak2lbzO3UxoTrzSCec2V0KnleWYiZNsVDr0ZxvbBmfFKUXYz7eXENUySDIatmVLBczvrrqLmqfopFd/YW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791512; c=relaxed/simple;
	bh=sibsT374OtjUcS3jJqLxxETwOcudQO7Eq4S6H+J68sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gSKafUZ9CE5LkjNvpT8d5EVRBLQyPhpRQDFcOxgsdpTzlCGzAU62udNAw2Mo180+D79BYOA7UNyA6ZPs5IRdE7eKRy6QxAil8BcKEEWpDfYkqnr+BXRY69wa1qOsSRoHHU+7PGyd4pgrb4+hOhg48RKIHCx5jLG5+P21VyIp4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-92-681dec4a662d
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: [RFC 18/19] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Fri,  9 May 2025 20:51:25 +0900
Message-Id: <20250509115126.63190-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoa7XG9kMg1svOCzmrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyFp9fxl6wgaPiSecfxgbGyexdjJwcEgImEhvffIOzXzw6yARiswmoS9y48ZMZxBYR
	MJT4/Og4SxcjFwezwEJmiSuLf4I1CAukS8y+tIixi5GDg0VAVeL1RW4Qk1fATOLR4iCIkfIS
	qzccYAYJcwKF+z+qg4SFBEwllk1ZwAYyUULgP5vEiZsf2CDqJSUOrrjBMoGRdwEjwypGocy8
	stzEzBwTvYzKvMwKveT83E2MwAhYVvsnegfjpwvBhxgFOBiVeHgtnstmCLEmlhVX5h5ilOBg
	VhLhfd4pkyHEm5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qB
	sb9MV1H8FVOY+WFf7xa3KWeqz/NYvjoqYdubuuLEtg/Tzu+UTdb/bNuqHmKoFuj/8t2kaZ1n
	5r+PLwlZw3O/8EWYzY5bU5vnFlY4tb5smFwlaCzgeF9qemU2f++xwBMvb6uevvu5Y4PkkcO/
	o7cLvZnouSXp6Ob8M0tS52Zd/7mxS6NTaELfLCWW4oxEQy3mouJEADmA7818AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXC5WfdrOv1RjbDoFvDYs76NWwWq39UWCx/
	sIPV4svP2+wWixd+Y7aYc76FxeLpsUfsFveXPWOx2NO+ndmit+U3s0XTjhVMFofnnmS1uLCt
	j9Xi8q45bBb31vxntTi2QMzi2+k3jBbr991gtfj9Yw6bg7DHlpU3mTx2zrrL7rFgU6nH5hVa
	Hl03LjF7bFrVyeax6dMkdo871/aweZyY8ZvFY+eOz0weH5/eYvF4v+8qm8fiFx+YPD5vkgvg
	i+KySUnNySxLLdK3S+DKWHx+GXvBBo6KJ51/GBsYJ7N3MXJySAiYSLx4dJAJxGYTUJe4ceMn
	M4gtImAo8fnRcZYuRi4OZoGFzBJXFv8EaxAWSJeYfWkRYxcjBweLgKrE64vcICavgJnEo8VB
	ECPlJVZvOMAMEuYECvd/VAcJCwmYSiybsoBtAiPXAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ
	+bmbGIHBvKz2z8QdjF8uux9iFOBgVOLhtXgumyHEmlhWXJl7iFGCg1lJhPd5p0yGEG9KYmVV
	alF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+OysyttVlSeF/0fwDj7
	+JncK5zTZjdynjnPlfdg0jV+4/vZ+89rcLtbSi08UKP2x+hS3eopZuf80zex/Y3lS1764VWP
	ysNyZcceHenfnw50MhptaZyo0p0suf/3rrvTvC7xq6Vef9+Xb9t/R2xxCfOp8mONWkrn6+2e
	haSK1xaF3az3OPHmQpQSS3FGoqEWc1FxIgATlcwqYgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The page pool members in struct page cannot be removed unless it's not
allowed to access any of them via struct page.

Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
just wrap page_pool_get_dma_addr_netmem() safely.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/page_pool/helpers.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 4deb0b32e4bac..7e0395c70bfa2 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -441,12 +441,7 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
  */
 static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 {
-	dma_addr_t ret = page->dma_addr;
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
-		ret <<= PAGE_SHIFT;
-
-	return ret;
+	return page_pool_get_dma_addr_netmem(page_to_netmem(page));
 }
 
 static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
-- 
2.17.1


