Return-Path: <netdev+bounces-152022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49569F2644
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E4B1649F4
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38E1B87C7;
	Sun, 15 Dec 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaoB7olK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA31DDE9
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298187; cv=none; b=TSToBxj6o2ljfofyBHbprZCqCJzNtiXCfF8CcgURjdZsbPITLA8gbB4yEfE0xEzcUd+7ngVf29eSfqq76abBqHi2gundqogtBOfBSH9HJ98AnBfoDZ0kA5vNFasXR6yg90TuKpdB/jTTCFhd3lObugB1nHqaC7vYgdppE1E8MfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298187; c=relaxed/simple;
	bh=JDBTOugmcR6EkR0tuwxzuyGugcPPI5P8HqwathA48aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ler14+VRNULzr2apx1eWy3xuqMKgODz7PZKiuXw885kBrRd3FXzTHh0pGc7Vrtnredm+3v8e+aFdm7oHhp36jv981qRG8BmFFkDsKdgfQhsElN1P2hFGlGztcUuPHXo+7zhNXoDnYE4ewSRgHRv9w4sa/1uJTW93vIM+O5TuJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaoB7olK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06FCC4CECE;
	Sun, 15 Dec 2024 21:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734298187;
	bh=JDBTOugmcR6EkR0tuwxzuyGugcPPI5P8HqwathA48aU=;
	h=From:To:Cc:Subject:Date:From;
	b=OaoB7olK5800WRLRH+GdPVAkEM61kH1oOiapdukJk/S+vg5pmeYshmUhw5ppCJh0y
	 bEBfY07xm3GVqpaDqawMOnHwClD3LTO+66SDM7pdZtZwrEbahuHHoTnkPi3EcuYg5q
	 ikZd8o8LTnpYaM05/wvIMkaEtcOKVogT00GtSgqXeqh9A+UKh7eZhV2/4J7TKhqK7r
	 Gy/2VFkX+aRSCuesG3CtSYei4tNhFLsTIQYfVWw4G71PQuXguOhqxLVoC0QaHo9I0d
	 ybWDp8Z1+2JjGs1zrogsjjQfW/qwKmwwU+H9Lp4IMcJ1EQApmLQw8tdety84H/+yIQ
	 YesPA4EgVWbfA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	hawk@kernel.org,
	asml.silence@gmail.com,
	almasrymina@google.com
Subject: [PATCH net-next v2] net: page_pool: rename page_pool_is_last_ref()
Date: Sun, 15 Dec 2024 13:29:38 -0800
Message-ID: <20241215212938.99210-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_is_last_ref() releases a reference while the name,
to me at least, suggests it just checks if the refcount is 1.
The semantics of the function are the same as those of
atomic_dec_and_test() and refcount_dec_and_test(), so just
use the _and_test() suffix.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Hopefully this doesn't conflict with anyone's work, I've been
deferring sending this rename forever because I always look
at it while reviewing an in-flight series and then I'm worried
it will conflict.

v2:
 - rebased on Olek's changes
v1: https://lore.kernel.org/20241213153759.3086474-1-kuba@kernel.org

CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: aleksander.lobakin@intel.com
CC: asml.silence@gmail.com
CC: almasrymina@google.com
---
 include/net/page_pool/helpers.h | 4 ++--
 net/core/page_pool.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index e555921e5233..776a3008ac28 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -306,7 +306,7 @@ static inline void page_pool_ref_page(struct page *page)
 	page_pool_ref_netmem(page_to_netmem(page));
 }
 
-static inline bool page_pool_is_last_ref(netmem_ref netmem)
+static inline bool page_pool_unref_and_test(netmem_ref netmem)
 {
 	/* If page_pool_unref_page() returns 0, we were the last user */
 	return page_pool_unref_netmem(netmem, 1) == 0;
@@ -321,7 +321,7 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
 	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
 	 */
 #ifdef CONFIG_PAGE_POOL
-	if (!page_pool_is_last_ref(netmem))
+	if (!page_pool_unref_and_test(netmem))
 		return;
 
 	page_pool_put_unrefed_netmem(pool, netmem, dma_sync_size, allow_direct);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e07ad7315955..9733206d6406 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -897,7 +897,7 @@ void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 	for (u32 i = 0; i < count; i++) {
 		netmem_ref netmem = netmem_compound_head(data[i]);
 
-		if (page_pool_is_last_ref(netmem))
+		if (page_pool_unref_and_test(netmem))
 			data[bulk_len++] = netmem;
 	}
 
-- 
2.47.1


