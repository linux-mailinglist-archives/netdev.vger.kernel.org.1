Return-Path: <netdev+bounces-236189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0895C39AC4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2313BBF08
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA683090E6;
	Thu,  6 Nov 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1Uri3dl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A66305044
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419304; cv=none; b=l8phfjEh1zEanivKqF9R+cF2Am+91Yi5nXmmET0bXIfWOwLQUl9ZPEBOu/hr9R/Jghwd7dGmHnGHxN6AdvTfbI0VnDzPe6gQqZ0TzqB8EtNpes2IDHd3/+SwPVJ52Cw4tZBDpGcXq+SBQ8aM72BNNIunhAX14uWeAwkV+z96ZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419304; c=relaxed/simple;
	bh=GX4og614HH64NOcGuK/fdqCuh15xqzDUlwGlcxQPzpk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=thPuM4IK/s5BdASFCN6FYfOzZruQhrngneFi6z+YOfguE6C+i815Gk8A/RrrmJiHX5Ia5NqgC8PttvSz0NnywJWk7YBgsP7l9dvhnKiUy714ylqi2SLw2I4w8iiZudw9qsXFqj7dcNAv/ioP9ztbmIhP+Ef2hfifeqgNFldfqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1Uri3dl; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ed74e6c468so8550331cf.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 00:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762419301; x=1763024101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZZnSJaDq1+wBb/1aXsc82txSSUrDqCDTDcLlIoj23E=;
        b=r1Uri3dlQNBCodKCB2yaYF77Priut+Sw05tDSmXK1ldDqetWkcqQSl2oH7AfW25eXj
         skgLz+p2COtij9maMvPOZjX1VC6+Bk1IK3uTje4ho9ksM0dOl5qqDHGM3awOrSMnvmtY
         FR0OZa9Uo6Es8A2u3BA/GpPd7uX6NU2C6Qp1gc4YBr5kUTCREg9uYxH+wVZxPbD1vjFX
         GxlHkMuqMNZ2gf6Eot8bYQ1JYUHYMWJ+1dV1pwk1g5+H3TTDWfb2kArQzBm7PenK1Bwp
         OXbRYmH+0ebYKphfL92q/ku8dhZju8fmOf4SY3S1ivsoxYjPrCqaYHABZspDSzh/nfsq
         SIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419301; x=1763024101;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZZnSJaDq1+wBb/1aXsc82txSSUrDqCDTDcLlIoj23E=;
        b=halxSDRqbSfB6WW9RRQ34hN0ypRgnR96JvIEutzYbDB71j8oaJLzwG4+mJhOcK7LuL
         paKaD8uw8UrR7ups/cX2dgCnxQ3COx9YU7HiSNFG5C9bNs4KWaMqelS5omNss3wM9xsw
         UxiHKvOAxqRQGfciWC6o5sW6UkzEfD986M3fRvJjLinxJncTrKDBJdDgezq1s6cumPKJ
         M4LH4fj+0xGZzUmxZHZs3NnrvYo5lmItRtQ7cuguvfDrWU45fe9Am2ZoOzdFBVryf6ho
         T9jJPbiOxs7ZlRKbnNRr02sHv1FXx1fDWOggRqPXxXFjyWVh/0p+EvPTS9fQMFyKGAbP
         5Jyg==
X-Forwarded-Encrypted: i=1; AJvYcCXfS786vvViiGtVGaIxkVqSZq4L5DcetCZKNO4Kk0jeCAy4+oYQ7mVaIpbDoFMPvyeDuI3+CLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLP0jH+FuUBjhNm0hp/KTo21aPCd9nqggMMcIg7fxjPciiJcDf
	BSvLk9zM7g3EQAztvdFWKxllQ7btsZXSnZ+6uJf6mAmyR29SNCuBMBlB5tpRxF/GKdIDfLFaCI4
	664UtVxrK57WglQ==
X-Google-Smtp-Source: AGHT+IFLeuxl7kr0ZDshyPTP57LHR51VUod9QFAMsS51C2oXiBJcINKcw2dsxKLxwozjOqt4+8wX9SWN2uurpw==
X-Received: from qvbnh18.prod.google.com ([2002:a05:6214:3912:b0:87c:2644:8d27])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7dc5:0:b0:4ec:f477:60e9 with SMTP id d75a77b69052e-4ed72645113mr76834131cf.76.1762419301567;
 Thu, 06 Nov 2025 00:55:01 -0800 (PST)
Date: Thu,  6 Nov 2025 08:55:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106085500.2438951-1-edumazet@google.com>
Subject: [PATCH net-next] net: add prefetch() in skb_defer_free_flush()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

skb_defer_free_flush() is becoming more important these days.

Add a prefetch operation to reduce latency a bit on some
platforms like AMD EPYC 7B12.

On more recent cpus, a stall happens when reading skb_shinfo().
Avoiding it will require a more elaborate strategy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 537aa43edff0e4bfedb42593146cfdf7511d8c37..69515edd17bc6a157046f31b3dd343a59ae192ab 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6782,6 +6782,7 @@ static void skb_defer_free_flush(void)
 		free_list = llist_del_all(&sdn->defer_list);
 
 		llist_for_each_entry_safe(skb, next, free_list, ll_node) {
+			prefetch(next);
 			napi_consume_skb(skb, 1);
 		}
 	}
-- 
2.51.2.1026.g39e6a42477-goog


