Return-Path: <netdev+bounces-175478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB0A660D2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BE13B6038
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3D20409E;
	Mon, 17 Mar 2025 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ma7Apm3w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27F2036FD
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247708; cv=none; b=GsnTztiQ7BDlA5/xLeUO3JQnMOzQTmxIsrF5NhZDKu79kz00ldsIERiC6md5ei/Lr5BmngoEs/t07QT6jm8bEFRoe5JISS0uaQhyjl2XWEVkgsk1H9SoSs9FGNQQkdri9MnNASkJ6lMj5Yed4wgphcSy3XjNdJa2+cdLTf86KVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247708; c=relaxed/simple;
	bh=rWjsX3fFqA6bmIfSaxgyAO1zC4N3dVQ6uElBa1TNPlA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ho6d6BVQp3hyVqEooHU6KE5bpt1euicKjOzXtvCuGyK9YeLsdtvbJUswbPWU9/xQmH+SpB570iQecGkaZpNQrZVBrnSZIEY8lp3Wt1bsnFhOzhY+XQwj3ysY/CeKzN2N7KTMK2L/YTrLkYc6+jRhbvqmYE4hjLonakOLbU7tJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ma7Apm3w; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso6415753a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742247706; x=1742852506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vAuLB9yhasIYeGdFy6GEtR/y77QYYCbZKgQQARSv/eQ=;
        b=Ma7Apm3w0VNV7tqHxXuPhkkBxUp8ziRHodlzwjcyaRBjkRFAOTkB5RK2cEnDYcNWrr
         tjEBiQ2KR3TTh2XKS6sF+IhjE5ww4JD8hsO0EVZjUsoGXAgRO0O0xG5xlvq5NGDhNDAO
         uOphLi64O26EeXaCQQ7sob3RERXy8RxXdIay8PTcCqKN6VLsV1X979RwhYKVBlFAREoA
         UDtYHw1XmYfJoDHfnOnsruV0Rn1KcYXsFKaEF8GRaAhiDgJf9EK0mZNl7VFAAZHLtrx9
         3s9LJYUIzv1ipfYQ2rlsbRY2LhJn6TFZ2C7nRSIVzqQ9yq+2aWN/jrHIJDjbrapVG0ay
         BGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247706; x=1742852506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAuLB9yhasIYeGdFy6GEtR/y77QYYCbZKgQQARSv/eQ=;
        b=C7IZttjXl3mLQmHuAg2IhAPdLqpLZyfP1lr3N7Phsm5mnw+SPOFuvAyaUGN+CEhk2b
         LccTQ9EETrfzwofJBTjBJ4CpAlVqcrdbETO4dm3zOwwP4otxVO6jhqJJabre/GMX2+/r
         JRxgkIg8VBboY7dAbVS3kuQB8Zt2yWYUPlXpKvUGrghAqKK7ZKfiMLb/meZmKbpnO6IE
         3jynHjyI0EFtrtvgnkR2amvbUIdnw3/vnVhjv0XsO7weyhlaw84wdCOSHJQPpuduWohe
         A4TOei4NrwB19FdwiEQyKP2z/wfuoc/344wA+x09IVO98UTEYyyAfWWP5/0D6Qo7ufnE
         u7zA==
X-Gm-Message-State: AOJu0YzmILGLLm3LS7cCOg8Tja/FGMrBqvBaN1GPgHTbrcR399YPTUvW
	MSZUCrJgnC7zZbw2jkCE7/8ga/EgqOPyWv5oUi6PbxGzORS1eH7aBulEd4aDLxGpOqUY4rCv5Lp
	qZ+DiF93fvNATqERzNr/+b9U9kU66TO2DLyTyfFzXxiLoTCYYx79HqjMvfmTFQdgfhK17G4wZAr
	nTUvi7TLhgn8UiMWuCdU96QfsfX1T7NxlhSFtsUPhVBRUbkCyZouzqrtVh2gU=
X-Google-Smtp-Source: AGHT+IHV2parlCfkXlW1RqUC5CzSsgz7d1VNJdqbSQLUNs1qprSzGznj89/+LkY3VXxqSq8aMvQGVAF67nu2A+QTGg==
X-Received: from pjbpl12.prod.google.com ([2002:a17:90b:268c:b0:2f9:c349:2f84])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5144:b0:2f4:432d:250d with SMTP id 98e67ed59e1d1-30151cff08emr15675001a91.21.1742247706476;
 Mon, 17 Mar 2025 14:41:46 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:41:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317214141.286854-1-hramamurthy@google.com>
Subject: [PATCH net] gve: unlink old napi only if page pool exists
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pkaligineedi@google.com, shailend@google.com, willemb@google.com, 
	jacob.e.keller@intel.com, joshwash@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit de70981f295e ("gve: unlink old napi when stopping a queue using
queue API") unlinks the old napi when stopping a queue. But this breaks
QPL mode of the driver which does not use page pool. Fix this by checking
that there's a page pool associated with the ring.

Cc: stable@vger.kernel.org
Fixes: de70981f295e ("gve: unlink old napi when stopping a queue using queue API")
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 2c03c39..0fcf4c9 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -114,7 +114,8 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
 	if (!gve_rx_was_added_to_block(priv, idx))
 		return;
 
-	page_pool_disable_direct_recycling(rx->dqo.page_pool);
+	if (rx->dqo.page_pool)
+		page_pool_disable_direct_recycling(rx->dqo.page_pool);
 	gve_remove_napi(priv, ntfy_idx);
 	gve_rx_remove_from_block(priv, idx);
 	gve_rx_reset_ring_dqo(priv, idx);
-- 
2.49.0.rc1.451.g8f38331e32-goog


