Return-Path: <netdev+bounces-209244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55EEB0EC9D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CBC1886683
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D12494ED;
	Wed, 23 Jul 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="yHOLiIzq"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416A278E6A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257849; cv=none; b=Br9kNfu/YstoRvnyCNoV2h2WOfJ1QHPX5cYADI6Sda/XnVZN/x+v9sjPA6aWb7z3G8e5NraiotFGOTx13ZlPYCKSXJiPgjxRS5KpaGNQhmi17IVm67jyK1WNfY99MvZ8FdBDmh89UbwQAgWCxGG1qPB0z3luJri1jvf+Br68+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257849; c=relaxed/simple;
	bh=IL+/zDti816FDJQftGI74BTxOWyCXWrxDXWdigYR+Ss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0l85j61R6t+L63kczUbT5otPGYcnaUdJqIb9flI5/ItgIJR5CFW8rC7oFgPVwe354fjC3/hg16JclSewFgs8TvaaMeee1nVz/Wk4KqQ6UPIKnVpIOYQnnocrpquBl674GkvrFi+kE+Tn5aZ7XX7kZkgm1gbhMjiI5yi9fteW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=yHOLiIzq; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8256120839;
	Wed, 23 Jul 2025 10:04:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9fscL6q9GP6; Wed, 23 Jul 2025 10:04:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 800A92084C;
	Wed, 23 Jul 2025 10:04:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 800A92084C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257845;
	bh=BqkTbYJRQO9DBwHCu6io59OjWZYyh1mMlTwSzvCMSfI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=yHOLiIzqBSYgUkYsWYkamORXOdecOJbF7DI7DwnTY103tPgOw517ryco21P9JGtZ+
	 8rqMlCKd1So9L6FtM7btgcU5OP8R+tK5bIYK3FhM/vV5au0Yr2u+jWqEpXPpLLnw3u
	 cH5aZmk3x+arFLbbZmlAItKEhHPk2Yx0TtF7hUYhg1FQDUzUeG8KJInBRiUeEMeoZr
	 /RW2UglE4DqI0lTbpzTluX9KrEajjO+GAStwjiGnuDaHu5pnDRQOa8fF/s9tnMnFR0
	 mn1Ql4hPYlkmDHtAgxTz0wV6n9u66hc+vjh8XLIw0rIMkLcUpXT3ce5RJ4BQJe3RWD
	 YXqwZigcD07CA==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 10:04:05 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A171D3184127; Wed, 23 Jul 2025 10:04:04 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/3] xfrm: Skip redundant statistics update for crypto offload
Date: Wed, 23 Jul 2025 10:03:50 +0200
Message-ID: <20250723080402.3439619-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723080402.3439619-1-steffen.klassert@secunet.com>
References: <20250723080402.3439619-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Jianbo Liu <jianbol@nvidia.com>

In the crypto offload path, every packet is still processed by the
software stack. The state's statistics required for the expiration
check are being updated in software.

However, the code also calls xfrm_dev_state_update_stats(), which
triggers a query to the hardware device to fetch statistics. This
hardware query is redundant and introduces unnecessary performance
overhead.

Skip this call when it's crypto offload (not packet offload) to avoid
the unnecessary hardware access, thereby improving performance.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index b3950234b150..f0f66405b39d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2282,7 +2282,12 @@ EXPORT_SYMBOL(xfrm_state_update);
 
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
-	xfrm_dev_state_update_stats(x);
+	/* All counters which are needed to decide if state is expired
+	 * are handled by SW for non-packet offload modes. Simply skip
+	 * the following update and save extra boilerplate in drivers.
+	 */
+	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
+		xfrm_dev_state_update_stats(x);
 
 	if (!READ_ONCE(x->curlft.use_time))
 		WRITE_ONCE(x->curlft.use_time, ktime_get_real_seconds());
-- 
2.43.0


