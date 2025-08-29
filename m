Return-Path: <netdev+bounces-218393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2FAB3C489
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D387C33E3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B102741B0;
	Fri, 29 Aug 2025 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLEJO8rP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983C264A77
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504815; cv=none; b=bLeoEER9lbkInjHfZkDsUU5HVIOZtHwUIM88KwxKw53Q69Pk8csZbVvStVhkqIreAkR6Oc62RRH68Mwoq7UeBSnOeEpqw78EgQNideIUUDyPRXcqkEEPsGgC4s69stDGoSmGYJpk5jGSG3mfJnjNBUQVhWKNxwXwJlRMYIwMunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504815; c=relaxed/simple;
	bh=/P6RowOz1b0vyseyrjEnqHcevhbD5nENbQPjjjlmckA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IWqGFjVgsQ9lHDjTG17WPRzDcU+qjg2xPK9UyAr+OaVEXSCygy7Ow7G29vFNxQgJ266erKYpYeYw/ClbDcdUZl2PohEnVVoy33wYr+3TcoddZXEWhADoNEO8R1+AQ8jPJUJ7Twa+noZQhBV68d7FedWWLEgzyJNTdtYh9f/A8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLEJO8rP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458264c5aso23495525ad.3
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756504814; x=1757109614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAzCvl0ldkRzudSduBa+UTTFBtOSyy1B+vOLHTPWCIE=;
        b=oLEJO8rP9QaUywYTyQHCghCVwjUTufKjhnpVM581XZbxaMr8JjhpmOSrs/KKVshxiI
         So9RNBnU4Wuk8qc/9LXEh7Kv63sNGcquGjD2B/tpav8Q+LjqOWZTSkx2Rre+Sk+ApMKu
         giITA551Z11F3/sWdrLeyH6PzlZwX2gO/tehgz+pXK3qX1I2CcgwAAL1ZPk79LiW8S25
         nL3aDNqRNobwu4P+1MHYNyPDmo3es6arp0VxXVHvqk6Ij4Mko+LQWVe6LwhRhhJt3fsY
         nZMQbaVz5LKdxA+yh6F/29yhv4cv/gWrt6PQRaujn0HnYIp75kV2lKC5GtwTI2YSqbaP
         RZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504814; x=1757109614;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAzCvl0ldkRzudSduBa+UTTFBtOSyy1B+vOLHTPWCIE=;
        b=eaUZHQow4B8UatmSDO41Iyij0qcUQko90VceQ2+ZAfU+CJKPVbpgSg8igm3RSoTsNW
         /IbV7DWnIuxrflBFEhk/bLB93VkiDjEoLcaO4PSHJMOX9dFPECyM211ljkGl30o5ykEq
         xp9+rNkl6cJf7krN1d/CZh5pRd2EjF8WLk5W9TYU6waryxn7VNZwF9NrRPJNC89eownt
         /+GFFpLUYfpZgzgCqPmCUJ6lnTFMtDkvcQ4FaijiW2dzyXSYCHS/YyHRJJVUBPSTtCYn
         fuesr8DrCzpi7+5N7tyVl7zXnwZAfSGiOVOjSbh8AVb61g76OerQJlF+OZrTfeDVdkDZ
         b1JA==
X-Gm-Message-State: AOJu0YzMSDcxdYR8/kylljavVbobSBtobjDj60LGeBSbX0QOLlZYF5Oj
	3ACz/1sS+Xx/rgyey11VrRJRVqJScEbksb+xoeBDpiInb4cHtNqWZE0L0mYalvhGL1axDtFliLM
	//20ZKZsH4vbnRMEcmvnL1J4S/BFrrjfIlOYR66FBe7dvrWMu5AZrNhfU0UniP5RLxcqsFbUf0O
	EhfMTT6d9p0ukD8fLhEK0hvMLkOdpbv7CQOxHUsYqNmaOOX/1SVwGnH4LnMYNqgR4=
X-Google-Smtp-Source: AGHT+IEKrhZ3OKLQxYoEKQKZHhOayEYySIWPtx97dJ8GVIzQwF9KvqViD5qC8rCJdQxii7XJlUjw1LorWZiSeDav0A==
X-Received: from plcs9.prod.google.com ([2002:a17:903:30c9:b0:23f:df55:cf6f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:120a:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-249448e65c6mr1874055ad.20.1756504813488;
 Fri, 29 Aug 2025 15:00:13 -0700 (PDT)
Date: Fri, 29 Aug 2025 21:59:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829220003.3310242-1-almasrymina@google.com>
Subject: [PATCH net-next v1] net: devmem: NULL check netdev_nl_get_dma_dev
 return value
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Joe Damato <jdamato@fastly.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

netdev_nl_get_dma_dev can return NULL. This happens in the unlikely
scenario that netdev->dev.parent is NULL, or all the calls to the
ndo_queue_get_dma_dev return NULL from the driver.

Current code doesn't NULL check the return value, so it may be passed to
net_devmem_bind_dmabuf, which AFAICT will eventually hit
WARN_ON(!dmabuf || !dev) in dma_buf_dynamic_attach and do a kernel
splat. Avoid this scenario by using IS_ERR_OR_NULL in place of IS_ERR.

Found by code inspection.

Note that this was a problem even before the fixes patch, since we
passed netdev->dev.parent to net_devmem_bind_dmabuf before NULL checking
it anyway :( But that code got removed in the fixes patch (and retained
the bug).

Fixes: b8aab4bb9585 ("net: devmem: allow binding on rx queues with same DMA devices")
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/netdev-genl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 470fabbeacd9..779bcdb5653d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1098,7 +1098,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
 					 dmabuf_fd, priv, info->extack);
-	if (IS_ERR(binding)) {
+	if (IS_ERR_OR_NULL(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;
 	}

base-commit: 4f54dff818d7b5b1d84becd5d90bc46e6233c0d7
-- 
2.51.0.318.gd7df087d1a-goog


