Return-Path: <netdev+bounces-115823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6808E947E54
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993DB1C2154D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80159155C8D;
	Mon,  5 Aug 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHU9ruGw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529913AD29;
	Mon,  5 Aug 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872292; cv=none; b=PFUQ1OMdiOwm4tUb/edYl8HdAQxWztMmQNaQckIZd6LzfNFfkRSrkSgpPsvkUY9LVNJncwUnIZjjqORMEuRjDjC8Goo5SYEm2hqYHSCFuffmLQamiPiMaU2yEM7yAZys3L7OQ7KNzTkWRxWknANsfuhCL+My0CgXimrGXAlAkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872292; c=relaxed/simple;
	bh=CxlzantkCjc7k9CFe+DBFCgGOrJMhgPmZIgLFWhcvb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vd2HnjGOqurFTCNEqbZYA4gtczeGtUZGMmE/6KGHRotpbVtPP6RbdnpBhpMMfda90Nt7PKb3M6Kk6p2LscPmNrXW8mFqIZ8VUkJdZ1yjmV7tdSbmU9IXDEH6Ys8rsm8MqRDDegBUAhwbSORJap6cyvqmqaMS1cGvbHNgjiv9f1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHU9ruGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B3FC4AF0C;
	Mon,  5 Aug 2024 15:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722872291;
	bh=CxlzantkCjc7k9CFe+DBFCgGOrJMhgPmZIgLFWhcvb0=;
	h=Date:From:To:Cc:Subject:From;
	b=oHU9ruGwczETuOHYeIqEzP3smliV3E+lqiydAxRKk32qfmA8yz6LSSz+IEtSs0ruC
	 qllSDuTHsJTmuGSVZq57BFyx6SvSKjdsKJ73RsNRhuyff4zt0jURdIj/AeW485whCL
	 x7GYZwB5wKJO3HOJ6HVQDu3KNrw8eNvtMtQ9THFwq7TroD+6p+ZNqZzpqjhwxjSxU/
	 AhWdQrATl/sU2x3Xqh1mcmZ3DEr3HtFzjnpB5AXXw+GFDmFyoJBzhnHGNM3EqFfl6h
	 NKF/hL40DspZ7IHuv1+6RYpqcAZAazbISvCHmObg5vL7svJm88pBMCSZ9MH3Lbsd3B
	 EE4jrfGNnIzDA==
Date: Mon, 5 Aug 2024 09:38:08 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] ethtool: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <ZrDx4Jii7XfuOPfC@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct ethtool_dump` is a flexible structure --a structure that
contains a flexible-array member.

Fix the following warning:
./drivers/net/ethernet/chelsio/cxgb4/cxgb4.h:1215:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index fca9533bc011..996769857a12 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1211,9 +1211,6 @@ struct adapter {
 	struct timer_list flower_stats_timer;
 	struct work_struct flower_stats_work;
 
-	/* Ethtool Dump */
-	struct ethtool_dump eth_dump;
-
 	/* HMA */
 	struct hma_data hma;
 
@@ -1233,6 +1230,10 @@ struct adapter {
 
 	/* Ethtool n-tuple */
 	struct cxgb4_ethtool_filter *ethtool_filters;
+
+	/* Ethtool Dump */
+	/* Must be last - ends in a flex-array member. */
+	struct ethtool_dump eth_dump;
 };
 
 /* Support for "sched-class" command to allow a TX Scheduling Class to be
-- 
2.34.1


