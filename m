Return-Path: <netdev+bounces-109453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D4892881B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD571F23A0F
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59601149019;
	Fri,  5 Jul 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LiWqRxUe"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D92146A96
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179752; cv=none; b=DYkIq8LQI6TRkkhMpaQtFiYDwD4WoPPLOSHmNiT6dRZVW7uV1UNuPrIEwnkb25d6dhcMYUois1YKyiRcrs5NaAu8thNRpql00h3stDcoeKYeQkCb9ZPfJwL6fb8lxVndSUriYFVKnRjrmC0Kvnb6Sw+K6+OFkuWvCV2HBSLSYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179752; c=relaxed/simple;
	bh=UIyMiIdy6IRaxlbmwAJIfPYGtEIS8FEbwXWFhICKiNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhGnei3ppsRMl0oz6Lb+BH5Yn+XX/vsc+8rlRQvwzMOD8v45u2e/ZSQSMsNZZX1I1ENJXNBBSnd/R+XxQhU243F3s8Ev6Un15Fo+4XQFQgZ921UsDEjaFY9GAoxJ7f+1Y4pyzHVzCc+haq/G4mFCdyKuw2UTTqU/ECzx+3GVr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LiWqRxUe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=bIS5rMIkVECRrxBMAr20cXNxcmYsc15MKjTt63SCJJU=; t=1720179750; x=1721389350; 
	b=LiWqRxUeLzEc5Sa0zRHNQIaM58G0Qaid4R5wW+qyfRmZkEvHRhTdUxBHyMlV6DXHTNJSiICsWc/
	BCPMZSuK9FDBU0tjVGM+owHESYff+bKV7UbgI7610JCYpFFamWOs/IHlvAgLxJ8PHUumDnKUHjg6R
	qseTgpXSzkoO633torJ83VPSsLtG3FttPuTMb2KlNGyWWj2QgbyHK5e1upKVaXHbI8lwbb6FVT3mU
	YWfRVIU2Ld8Ssb691KQ5CvN75n4oVcOLh2uO6pAnTO1/z4PN61FHTGPMzh2JEneZ3y5ztfEZUWT1Y
	+cUeo1pDzf/HJbnntmOYjWejyJGLDjbS4d3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPhKb-0000000GFDs-2Jby;
	Fri, 05 Jul 2024 13:42:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next] net: page_pool: fix warning code
Date: Fri,  5 Jul 2024 13:42:06 +0200
Message-ID: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

WARN_ON_ONCE("string") doesn't really do what appears to
be intended, so fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3927a0a7fa9a..97914a9e2a85 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -445,7 +445,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	return true;
 
 unmap_failed:
-	WARN_ON_ONCE("unexpected DMA address, please report to netdev@");
+	WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
-- 
2.45.2


