Return-Path: <netdev+bounces-72634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D76858EFE
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8F1F21969
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3763506;
	Sat, 17 Feb 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXd7uVNf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B763503
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708168362; cv=none; b=YpoUhP5uklYNY0XlQ8+HmlmmrKTVkyXrqR3FKdP6Y/jRRc16YzTwvmqgbu3LvO699f5zkFtg3wwTjw2u4sqfe+5+yc1GPMmTrryAZGYt+NBrfseyIqMJPlxDjNZH0eE504sxw5QHvxlH7vU7WcJI1AQEIEsXDzvcJ68J4ZV9YDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708168362; c=relaxed/simple;
	bh=pWfH5rxBOCN2yNjYCKQD5rkYB+71010u0O9NwJU5Zm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiE983CO/viwj+EQO/zol2tFch5Lxw/tKfUxthuPvJZQGS/kYxTeEphXJ36xYY/HmIMRQ+aQ2slqNeDgmL7qs4Q6pTHdmpR58cg0THOegRPEvIWK5F8xmAWT0iiDg9fSu4upxPlY0LwY5QXj22z+1Pnw+P7AN2+/WzMh5eSrZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXd7uVNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A125C433C7;
	Sat, 17 Feb 2024 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708168361;
	bh=pWfH5rxBOCN2yNjYCKQD5rkYB+71010u0O9NwJU5Zm8=;
	h=From:To:Cc:Subject:Date:From;
	b=sXd7uVNfST2AGS51Hc88hB2yl45njb5eC+r+jmE2/XG45MVq8x9iDvITOOyE9g+g5
	 ZRiFIB+DHoi8hRpMZu0pS6AKyO2jVu33ox19SGGq2XuzckxICbGn7nqFYrPElgXjLf
	 0Bs0PlkFwZnbZ42UGOuq+X1HwoDTGEsulILMNhivSn2WbO2d35xer2SzCzhg0mvslx
	 6ixxGKKvg/6wYTI4v/omdJ6WecrUzikTtJwhzfwyG7vRMF5Nmt3Qv6IItSGsdEjK6b
	 PwuVUG7P1Ih5EiJyHfQSSghrm1Y5/SAS2kM6IYb5EMy2qBnutAexFhCILOqOR9av/9
	 IXD50uFv/cl5g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com,
	toke@redhat.com,
	jwiedmann.dev@gmail.com
Subject: [PATCH net-next] net: fix pointer check in skb_pp_cow_data routine
Date: Sat, 17 Feb 2024 12:12:14 +0100
Message-ID: <25512af3e09befa9dcb2cf3632bdc45b807cf330.1708167716.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properly check page pointer returned by page_pool_dev_alloc routine in
skb_pp_cow_data() for non-linear part of the original skb.

Reported-by: Julian Wiedmann <jwiedmann.dev@gmail.com>
Closes: https://lore.kernel.org/netdev/cover.1707729884.git.lorenzo@kernel.org/T/#m7d189b0015a7281ed9221903902490c03ed19a7a
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0d9a489e6ae1..6a810c6554eb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -950,7 +950,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		truesize = size;
 
 		page = page_pool_dev_alloc(pool, &page_off, &truesize);
-		if (!data) {
+		if (!page) {
 			consume_skb(nskb);
 			return -ENOMEM;
 		}
-- 
2.43.2


