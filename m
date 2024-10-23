Return-Path: <netdev+bounces-138427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEA69AD75E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186281F233B8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD71F80B8;
	Wed, 23 Oct 2024 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cx2hV6EW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1411E2836
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721513; cv=none; b=Q6ZnBnZ7l4CYh032ud2QWLfHBEHHI4v/KOx00j386fbgO6dNfNh6TiEwgwi3zsGzU3EmvdYB8rncE7pdJnej+wHg44y0Bp3ngFHsykr6GySwRrJXLiQjtAjebVjcXrNs68JzJDUj9UT6KobDOWJ5ccfWgNcAA0Ehw2WKYZokYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721513; c=relaxed/simple;
	bh=2NPcfSh1uoL1PReEMYSQs0VLESRvMrGgT9kP5uaX6r8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bUh4aG7RO9qyqThbPy4MPzsItxEaaLRTpOeVjAnxLPYG0RRZY3chlj6+cEJuYFlSDXn94jDQFm7WAAm/kJ5Wuohjb83ZnPvKQxUbLpCKi3yl9ooHvZfqKvsWMq7O1Ok/DmpG6haFD07oVhU1gPqPDoe8izOYLVo/oNPaFFd2EPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cx2hV6EW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ed98536f95so171148a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729721511; x=1730326311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lwUmwsmnHWCMeHuWQPBpAmSfL8WSDh1Ybn7+Iij+s4=;
        b=Cx2hV6EWgtLyvWGRWTmPry0zFzhiyiotlfrKHRthFbKcCEEkTy2LUd1IyrZ3rIdvlZ
         ictv1zXTLDafmxe6sU9J0ty/A6l1tOPeGMzaaBx36BuqG0Xdg1gzU58A4ntiYUQX9UsH
         O0gF+BKjJxymtPhuuXqtgSZkQl1QNKg5oJ8bAH9hrsARWMU6aXaXCkl9+x+AdsqmHtWV
         95m7M6nqpAvMbYwk7eNqVHd4sv8KHcho7zyTLvVeQvCvxwp0PniHnvKo1YGnEX6qHfps
         eWa44cg4cE4tO0GuE2g/Xuwwqd4PKnRmgIxwN0SjDH3hZoPwrgvKCL066+DJS6sPQr5S
         V94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729721511; x=1730326311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lwUmwsmnHWCMeHuWQPBpAmSfL8WSDh1Ybn7+Iij+s4=;
        b=YGXksCYlHDcEHijmbDWHmOpqTgP8Jhkvzolw0hZg2THMMsuVGyPMbPSXrIn7UZRpzq
         K0vckxmfPB5Zu536OBUooeP/wRoBfT7M6JTaoWcPjZ/6rU8cGXAGujG8uG1HeHsX8Slq
         7J4c8wjHNPuubjuLeUWwnlI0Ec19tbcyLTVuTkSR+Cd9kzlDTUNNCNv1UMmajDO/UUur
         B3jX/kjuMpx5eYM18aVs/rdPYVKtsOx30sdMb1QJ5Fwxt8Xw8emIuHo2ZYHQH5VVTzzG
         yDdaZwJ82EdBpMTgBbxOHoGHQOnkwR1OOjzqZMNLOxr2crHfsP6FY0DDhjAF8tHFhOM/
         ZcKw==
X-Gm-Message-State: AOJu0Yxo9hC30AAEQWvnfpO10YQvH8QXTzoXyZUtNA3ogTkAXvGVT9Oh
	7J2fWoK5tT71jZtr9jyq/iIlLeMR4vCk/BmiHZenogZxDdOrnsRpTLP/yUJrWR7rg1GII0b3xZP
	yNTF8SEY1yoxdkAmAd37FiSL11CUipuHXctY6k13B1NUGweeC4LwGhv0NPjkJyeO6t/vWsJ2LxA
	/xwjpPewr6C7TmtM2ohAA3adKjreHdlECvU81aZDimyiabFeNkGqDh6JcnioX5Jui4
X-Google-Smtp-Source: AGHT+IGKFkxbjuGkfHDoeY0M1W0R2msA80ns7fcRBmil7r19YPvsmfbscEmxLo/nrj/p7DoESmKZaoh77vwiVsYlWkA=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:9db6:f9e7:4fd8:c827])
 (user=pkaligineedi job=sendgmr) by 2002:a05:6a02:4085:b0:7db:54a0:cf3b with
 SMTP id 41be03b00d2f7-7edb2230984mr3a12.0.1729721509074; Wed, 23 Oct 2024
 15:11:49 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:11:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023221141.3008011-1-pkaligineedi@google.com>
Subject: [PATCH net-next] gve: change to use page_pool_put_full_page when
 recycling pages
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, willemb@google.com, 
	jeroendb@google.com, shailend@google.com, hramamurthy@google.com, 
	ziweixiao@google.com, linyunsheng@huawei.com, jacob.e.keller@intel.com, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Harshitha Ramamurthy <hramamurthy@google.com>

The driver currently uses page_pool_put_page() to recycle
page pool pages. Since gve uses split pages, if the fragment
being recycled is not the last fragment in the page, there
is no dma sync operation. When the last fragment is recycled,
dma sync is performed by page pool infra according to the
value passed as dma_sync_size which right now is set to the
size of fragment.

But the correct thing to do is to dma sync the entire page when
the last fragment is recycled. Hence change to using
page_pool_put_full_page().

Link: https://lore.kernel.org/netdev/89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com/

Suggested-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 05bf1f80a79c..403f0f335ba6 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -210,8 +210,7 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
 	if (!page)
 		return;
 
-	page_pool_put_page(page->pp, page, buf_state->page_info.buf_size,
-			   allow_direct);
+	page_pool_put_full_page(page->pp, page, allow_direct);
 	buf_state->page_info.page = NULL;
 }
 
-- 
2.47.0.105.g07ac214952-goog


