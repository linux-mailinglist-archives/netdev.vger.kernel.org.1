Return-Path: <netdev+bounces-143077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F09C10E5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB6B1C21F22
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981F2194AB;
	Thu,  7 Nov 2024 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3Iu36X/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885E218D8A
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014601; cv=none; b=WTpOKzZI18/2Spcx1/SLyuULZWBE6exLtsO2XBlw2etVvWUSXK7Hu8yzx35yK1wR2NbTla0Er4jOugU4vsG/hp3Cw2ZBaVZzTMxThSX4tu+ok3HYe5gPiafKFkLERCQUUOEVFuBsaPTOlPnUDvBa6tgzlUy2uQRfJp+7i6jPoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014601; c=relaxed/simple;
	bh=ps8g7aS9YWdHiljpOSe0iIE7Rn7tIj0JNhfoyBSlYao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0o9Gwz+OOP1pQY67ROKURbgJaZidW69+L49qzmUI8kuxS5ULALYiYbWghCGVOqzC/EO8Di3lvkXIJkylfOrMk8PTN+eqIYWPrpMIkKOzGFJshGhV/zvR8+1A26a9LosLVgQ27huqw9RmoSlv91N29x3cL8IGkh8kWpJDzsvMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3Iu36X/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e33152c8225so3078295276.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014599; x=1731619399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+st140tRnSi1hqWlJmll4Lhmo3xu0I4VHUB3oVubp4=;
        b=w3Iu36X/yN/uxVBPCA0bVFgUHHngQwmlQbGeDD5IQUWdRRQwbPr9u7EERMWBkTjcrU
         czdE26k7JQmthwf5YdeYXKccOoYarRNkLO+dvgyzye8aJFEUZu8+xH7/o7ujiY7ZYE6o
         +sb4WeqZ8xo0Xjcp24l5F6oh4TdYWJi9xNBtbJG3UCw41HQQAggUbsggMULH08IzqB1p
         /5ISuwFpbzX7lOe2DasET+M8J1FRQIubFA4/rY2I5Cq20LeDJ7OEJreTEng8IOFH9OT9
         dZlhEzOXZ2Wb2Y82FPh7tRoeIlTcWHQRPxI5iTkldRF7HCZj86QEccWnMR27mzlQ55Oz
         Nakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014599; x=1731619399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+st140tRnSi1hqWlJmll4Lhmo3xu0I4VHUB3oVubp4=;
        b=c2hXIXVhnPgWi+KACWQGysXhXftrFs+luTI5KpbXm+/vZ5oeDc5cFjqcfRb7hMe97I
         iLvLio3nUIqBKVBdp8jj975KYTv6AoOEUTnfs9nDN2CBhoA1FiFQLgCFo7BzibC7yevs
         +mx+dyg77kC+iNmChZzM10lpKDKEpyZcuvolrG5I6mdTfYCx46nTLmGkJbqJOCE8zuK9
         9WOrcfFZ/AvcKoEDiOA6VXPz0qp+RcDF1aZbXV8MSYQk1PYvCw422iVyQHo6b2LOitUe
         kZzFHoUmAPCPPvrhonLcHYG0U3I4LJSRyIUou0jeCDmyMKfXEuGpdSdWcDnbsn33Airb
         JJnQ==
X-Gm-Message-State: AOJu0Yy5/1a8ENZMzY64VhGquLikdWKtAwZDnFCweMG+I96+4fs2+fVC
	GBqfcvSWdIL0zMnwmVzuXiJG0V68wZa5yKsaT/yTe+3iQM1fi8uONsWWH+u+GqZsnCn0cgOvCBw
	TB6rN0yXHo3SgdeyBHn3pa9PWhFgMyTrkOXtFVJswT8qVxnPA2Z/3cb+OmXGly1HQMzVy1pPBmf
	CrkoKkoehY1BKxv1NIUj/AxsVoHekzTMaA+wD2x0v8Q8pQ1mSuaKJ6A8j+jYE=
X-Google-Smtp-Source: AGHT+IFgLUXTW1oofpX7j+3fjQdPt6Z3JBpPD3P1QknlqjCzkBELvb4f5iD7diwTeje1LMy4ccv21eNPv4d6rFfFOw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP
 id 3f1490d57ef6-e337f8ed8bbmr319276.6.1731014599186; Thu, 07 Nov 2024
 13:23:19 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:07 +0000
In-Reply-To: <20241107212309.3097362-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-4-almasrymina@google.com>
Subject: [PATCH net-next v2 3/5] page_pool: Set `dma_sync` to false for devmem
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

From: Samiullah Khawaja <skhawaja@google.com>

Move the `dma_map` and `dma_sync` checks to `page_pool_init` to make
them generic. Set dma_sync to false for devmem memory provider because
the dma_sync APIs should not be used for dma_buf backed devmem memory
provider.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/devmem.c    | 9 ++++-----
 net/core/page_pool.c | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..826d0b00159f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -331,11 +331,10 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	if (!binding)
 		return -EINVAL;
 
-	if (!pool->dma_map)
-		return -EOPNOTSUPP;
-
-	if (pool->dma_sync)
-		return -EOPNOTSUPP;
+	/* dma-buf dma addresses should not be used with
+	 * dma_sync_for_cpu/device. Force disable dma_sync.
+	 */
+	pool->dma_sync = false;
 
 	if (pool->p.order != 0)
 		return -E2BIG;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 77de79c1933b..528dd4d18eab 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,6 +287,9 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_priv) {
+		if (!pool->dma_map || !pool->dma_sync)
+			return -EOPNOTSUPP;
+
 		err = mp_dmabuf_devmem_init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
-- 
2.47.0.277.g8800431eea-goog


