Return-Path: <netdev+bounces-222659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91AB5548D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140C217E0B9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2DB2550CA;
	Fri, 12 Sep 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy1KOJIS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756828DC4
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693826; cv=none; b=MzmXsvstKsycJtQ4SI/hiVYRU3X8VRe9mtqIBg8m64rxR1MD+JuWcx24CEMde9Yp9uGAawr7c4h0Zlh/dmiJv7hYGh5VuBR41SNC+dKiGQLsqx6ivZLyDLXtdX13gJiyTr7h30THAFrPf7BlxR1NcC5LTytNRJIJGzkfxEMF5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693826; c=relaxed/simple;
	bh=ioSPNb6nbYh/DbycVCR9BC68odbDtZnXs+YVXCxR3Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGrylMaOvECZepb1t56LhgzPM/gXdog+b9CSRnZg5Y88Lmbb1Nddm94bMJdzAnXF77R2NzqmhfQcinPtewBlWvyHXyiQpl25AkS++SbEhV5FADvWRw8Qi2aKI19Bq3zqWNVyXgayb6YicYrf9V5ipmOZt8LbNI++LsPL4iqcJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy1KOJIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E4DC4CEF1;
	Fri, 12 Sep 2025 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757693825;
	bh=ioSPNb6nbYh/DbycVCR9BC68odbDtZnXs+YVXCxR3Tk=;
	h=From:To:Cc:Subject:Date:From;
	b=uy1KOJIS8R7eBbU+ND+VP9EQcDVEkLrQrUwmYhihnFQCuRQS6DZjwGch2l7WuhNdp
	 Fem15bz2uSgJ0YUgsb/9mCkEk+yNjn8rMdVdEe5+EudfqQqVeTPF2uXkQjqgk1u952
	 MJtOdnz6UG4P+5jzRN5QRR+kYy/+TzAJGzr9oYdjg6Mi9HCiUOXB99EW4AZg9v8/Cq
	 lXLk22dH9Ij3h+mizstXKPlxnjt+QBsJlCwRC9A1MadSmJvImS2tT5RVbOMDGiIL2a
	 MRldjbs0RECp4Peqt43td0XloPokk+WkXrBnxzfjWm8NeMcPAOsvI3LjbZCDI2M0UV
	 75A+GeAoPGLIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH net-next v2] page_pool: always add GFP_NOWARN for ATOMIC allocations
Date: Fri, 12 Sep 2025 09:17:03 -0700
Message-ID: <20250912161703.361272-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver authors often forget to add GFP_NOWARN for page allocation
from the datapath. This is annoying to users as OOMs are a fact
of life, and we pretty much expect network Rx to hit page allocation
failures during OOM. Make page pool add GFP_NOWARN for ATOMIC allocations
by default.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - drop the micro-optimization
v1: https://lore.kernel.org/20250908152123.97829-1-kuba@kernel.org

CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
---
 net/core/page_pool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ba70569bd4b0..36a98f2bcac3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -555,6 +555,12 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
 	netmem_ref netmem;
 	int i, nr_pages;
 
+	/* Unconditionally set NOWARN if allocating from NAPI.
+	 * Drivers forget to set it, and OOM reports on packet Rx are useless.
+	 */
+	if ((gfp & GFP_ATOMIC) == GFP_ATOMIC)
+		gfp |= __GFP_NOWARN;
+
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
 		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
-- 
2.51.0


