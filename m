Return-Path: <netdev+bounces-249442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F261D19083
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6768300163B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC1538F953;
	Tue, 13 Jan 2026 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2SXvWykz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899038FEFD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309821; cv=none; b=O8nNaF6syRHn5dPUGgQNo9cM40Yixvy5dffW6Ea5etwDrEHQRzK3o9W4UrmiNO+8V/J7MYOY2Thl1XaCcvoYvBBi0aJR5I1MGKHiZhd+KnwwfzPBv32m+rHvnCY6md0S3NE3W5mNA0G98WqUl6PUO+W8kr+yDKoEfvF63QNT2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309821; c=relaxed/simple;
	bh=SUugGjgG+7vEqHmUCtlpGkRukFLpAgMmpUFWDnD8g/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lxFDu9TMXEGxwONwpL5aHgHn7VdTh2+MMIDN+7/Hseml8P3DPls9Gy/3Vua472gRdmb8SR9BZgbGYy89g6z1v5JDojD/YRua2eBNVgfOlHr3kbASuJvWpdh0gpNeP++RezCef2nnXZ4nbtaosS5wA7joJ9lVy1l2Fqk4DzyDF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2SXvWykz; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a3929171bso158048826d6.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768309818; x=1768914618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/srtRv/gdOtsYHQ+DxBxBqOCSfeVGTnOu6cSMjM9zI8=;
        b=2SXvWykzYm+2fdS/kmWsjFEjusOkwD5GVlLnOW1Dida+FbWzq1jZkC+VgpV+GCRfbR
         +v1sQiL8LZ2ToXsZHvw4KsATPmNfCRH/XsheVDHhjvloLjhxA6vpC3vrdHXSQwbgdzFP
         V08WhNHWtixzRGqcBRp65lPc5ci9sDJ8a0vtDjQMk9pvpwltFvog1zIzh5XqRcetqwFy
         3M173lecy9rKN3wlyufhT+HCThucwaaOLy/lqvh07jUpw9XsWlqGyXrCrX+8Zfa/kIt/
         t5XXjSe0eviINAknDDV2DHfrDHrK53el45D6swIIMx2x3C67Sp8tXrIsg7AmDyPyplFA
         jCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768309818; x=1768914618;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/srtRv/gdOtsYHQ+DxBxBqOCSfeVGTnOu6cSMjM9zI8=;
        b=cVgvWMUjxyeRwpaQNP+7b3ZWxv0mryOptfTyZEnFupHIuLxMa6PaKrixK7AK1lZGiB
         IWxPgNj+zMaDZMrC4U0C0BQxBnTv+1XPgJaq7gbUhRy1k4U6/okgKxAi2jg4Q3Qi8r9u
         4p8tlza1rbBywkKxReUlMVBPMkVeFHDOehbACvp0U5At3k7SpXaHkjQzf2XGIjrfARdB
         qQhYiwClJyQcb2GfFEyGn0hg8Frw3Jg9axB7EAQcXcbYy/YbG76SzqM3MCosJRaSepkh
         fTBn0gxALtYXhlmKQnFZ/lo3lCQcc0cJRbD4eYLHmUZNHA1o2jV5GPgkRQhGXzio19rG
         uAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMvBjNl/c3gwwyEkAuvdQYFwBM/nN2dLKNpmS9U6GcelIldgtdP5KjOvBeqz7U7SHQFsIpwh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoJvYKgRJI4LLsCH83Y8nEEObRgGlQofVqMmK8iedOlymCTqE
	qaN5+TVwIoBdEqcb43Qxy2qHm6QSTi1dmFjWmUO7gE7ySUbyBUlE4NFPx7Yrf+zMp1LF3yraG0D
	BnhGTRKD20NvHqA==
X-Google-Smtp-Source: AGHT+IFGDnc8WBZgUMsSMePdVdyUIhlf0lNNZLeTi8fT7ANbXp35eba3gYEyO6N4YZIjs2Z3G3Wp0nO/dCJryg==
X-Received: from qvblh6.prod.google.com ([2002:a05:6214:54c6:b0:888:3b63:e0d7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:488f:b0:87d:c7ab:e5d0 with SMTP id 6a1803df08f44-890842757cbmr320345746d6.55.1768309818669;
 Tue, 13 Jan 2026 05:10:18 -0800 (PST)
Date: Tue, 13 Jan 2026 13:10:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113131017.2310584-1-edumazet@google.com>
Subject: [PATCH net-next] net: minor __alloc_skb() optimization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We can directly call __finalize_skb_around()
instead of __build_skb_around() because @size is not zero.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4887099e8678352a62d805e1b0be2736dc985376..77508cf7c41e829a11a988d8de3d2673ff1ff121 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -714,7 +714,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	prefetchw(data + SKB_WITH_OVERHEAD(size));
 
 	skbuff_clear(skb);
-	__build_skb_around(skb, data, size);
+	__finalize_skb_around(skb, data, size);
 	skb->pfmemalloc = pfmemalloc;
 
 	if (flags & SKB_ALLOC_FCLONE) {
-- 
2.52.0.457.g6b5491de43-goog


