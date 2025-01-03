Return-Path: <netdev+bounces-155063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77827A00E28
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3EF7A05DD
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098531FCCE9;
	Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7gUAA2v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483D1FC7EE
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930800; cv=none; b=jXxQYvA3YCBP8DetWUF29CCgh5H9z0I3DWZGZg4svl351xlk6PZ5jAo/TChi9Y/fnsenVhLhUbVwIxqntY/uWoJd+wMC1QeifLUasLJVSY2OZGrf4/T8Xzqzy6plEA7j73yroVnXMMH2c9aemKx6YIOUiBnzVAM89xRJdJ3If6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930800; c=relaxed/simple;
	bh=tV5zLWFMk8yMVzcMw10uFwKyi2eIAuQKaTNRMYjBWm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMQHOTA3Ei1vpTgDBac06hkhgdaMkL+qRCzatWBVvBU9oXpky717pJoY+9Mvvm1tvGs5NO3O7HSTYIeAyicv+XiVB/q55eOov7JipoJkjTu9Rsl6QLhQVgGSXjhGIwmADkjUYzmfiyhNUJpPF5+MDAujfAp23L5dfT/QNGJJX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7gUAA2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4763BC4CED7;
	Fri,  3 Jan 2025 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930800;
	bh=tV5zLWFMk8yMVzcMw10uFwKyi2eIAuQKaTNRMYjBWm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7gUAA2v87H4oZ1lM5rk0Ttv53daGpVzh4SJS+eaThmYRPdRPPm4mTrsku/vePSSL
	 TQSgumoFkFaX5mFcaTorOkh34JV6SraPvhygyXYCTGdCJsACm6N4oPtgE08FHXh1TQ
	 n4n2rlOo2gZaYGXfpKOxL+xb9Fgg1t6MKkym3eQlNIRFjtgLNLGD+5ib6c2V4ilGMw
	 guAzZ8x8i/DVvx+zGblDJ3iXqozdYHSKRG8MIwQ1GFdLztjvjg7yRPc/mrBHaG4SMg
	 MfugaYvnrHJrQ6RijoAVeSVlf2vqmM2sXsPSw5q2QSLh4rbAARBAk011+92xlTvKeb
	 JTfa8L9i9ubDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/8] netdevsim: support NAPI config
Date: Fri,  3 Jan 2025 10:59:48 -0800
Message-ID: <20250103185954.1236510-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103185954.1236510-1-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link the NAPI instances to their configs. This will be needed to test
that NAPI config doesn't break list ordering.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e068a9761c09..a4aacd372cdd 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -390,7 +390,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = &ns->rq[i];
 
-		netif_napi_add(dev, &rq->napi, nsim_poll);
+		netif_napi_add_config(dev, &rq->napi, nsim_poll, i);
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
-- 
2.47.1


