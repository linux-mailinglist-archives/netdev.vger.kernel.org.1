Return-Path: <netdev+bounces-245289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79532CCAD55
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A641C3002D26
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D252E8E12;
	Thu, 18 Dec 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9hHXYDH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041E32F745
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045928; cv=none; b=Np09AKhA3NrvGm/ViS5Quo1dHC1dIuQ09tH57wTP4V/o+h+KIUAu6/eqUp7AXIPA2sKoU1GdZl/khTz4nFZ3nDeYg3bZZA0inf1yYu3L5s6znlEbrs2908+Nr1xGeHjCh27+orIGR7q8xn8xSIvTLoeCLFaCBgk7FJdD/wFi7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045928; c=relaxed/simple;
	bh=xWK+ImZm0Hm0a4MPxMi37pRUVOBi4/oQTzgcb51o8S4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sHWQvECS+0hL+ERpSn/C5XMEBQWxvDZOFNIN+b5F5zNb1muruJj+B700KHUiKiUFsEpdlYDUtDNzWUmbI9rYDyd8SYbI/yQXE+bksgY3rza8xlYlwLxepAFS4Te8COc+NdkRAT/mxMh/2Orepia7C8bUgYekxZ0Wv05Ix2t52Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9hHXYDH; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88a344b86f7so12943966d6.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 00:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766045926; x=1766650726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ok3a49KpYJFioOVqecbeAV5QMc1Yv3NHsXkcoN17NoI=;
        b=y9hHXYDHsP98VpxluyspxWebumKQF8QbH07dKp0Dvyef0LGpzyFSPKwQJMQVvgM3pj
         bedJazhH69j62ty8051BT+5+Iz015YvufMuStUE666XBCzn3gZeNISDLvJF8PgtO3o8Y
         t/taLeG4H6M7DrgAZwTLx2WugKDE7jEOt7Kf/LyM7cLXRIDP3uZdfUSfGPCd8N0lUwCT
         mHiqmrwM60etjBDToH/Q1aTXJbOjFPOLbLxPn+/EVrdt969xd7tR2bh01KItbArvbjbl
         buX1n5qkp2yYcCSw8Qy0hQunqjWCEQAUDmuPN20VDlADxCbxC4cIDDUPzw7SE7c8VJRW
         zFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766045926; x=1766650726;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ok3a49KpYJFioOVqecbeAV5QMc1Yv3NHsXkcoN17NoI=;
        b=YisLYAnAbDRAKw8W3OpxSnIM5Ft24cx6aU+YtRV0J/4eRR/vpPKuxnYpGsdDBLi5yd
         Pb7xC5jXLGa/XJEVcEDRnc4x2LmJfQ7TiNPk+9H94jhGY+7iqNubcjL+h3R1neBktYF4
         CDvIAnRbF5k0UyqDUh6FIA7GVAX771II8MfjxUp/7tkGvXJi+9uLag4Jm2TYkvifpi/m
         P3/8RTF7Dl/e1crbcmsADncSNxu06qaoVNdiYpV/KNftelFFYYwEri4E+aNlXNEvX77j
         7g6ArE4nSwTOoEGUo9r5HscqA+sFCNTVJAsSYec0H4gdGdqO+9pOcqdunK9ERbfHxvEq
         IJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXPJS6sf9OGaXkR24wLK0mZ1AeZZZlAVOm5W2A6M4UIRW9V7JlfuEcjM9IF0M9j7rPJOXcUMiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sVEXoNku3q+CPCbgSOg0eTMtWRvPStcQDcuJN1I6WjK/PCvO
	kf5tHuTBm4yM0ttwl4whfmGHGbLfso+L2VblyES557wOwhJsld388GEAUE+3e8rIYdwEaKsI9UY
	5xoYspIPdR+8dlg==
X-Google-Smtp-Source: AGHT+IF+GTXPF6c987ASuD9U5kX0Bb5wdCPzUkUfBqiYyTBMJqAHCSVs1jU+901ZHiWaTXWf0oFL8k5zTaGETg==
X-Received: from qvbqm19.prod.google.com ([2002:a05:6214:5693:b0:882:90d3:a0ba])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:469c:b0:88a:57b6:3b88 with SMTP id 6a1803df08f44-88a57b63e60mr58245916d6.17.1766045925758;
 Thu, 18 Dec 2025 00:18:45 -0800 (PST)
Date: Thu, 18 Dec 2025 08:18:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.313.g674ac2bdf7-goog
Message-ID: <20251218081844.809008-1-edumazet@google.com>
Subject: [PATCH net] net: avoid prefetching NULL pointers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Aditya Gupta <adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Aditya Gupta reported PowerPC crashes bisected to the blamed commit.

Apparently some platforms do not allow prefetch() on arbitrary pointers.

  prefetch(next);
  prefetch(&next->priority); // CRASH when next == NULL

Only NULL seems to be supported, with specific handling in prefetch().

Add a conditional to avoid the two prefetches and the skb->next clearing
for the last skb in the list.

Fixes: b2e9821cff6c ("net: prefech skb->priority in __dev_xmit_skb()")
Reported-by: Aditya Gupta <adityag@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/e9f4abee-b132-440f-a50e-bced0868b5a7@linux.ibm.com/T/#mddc372b64ec5a3b181acc9ee3909110c391cc18a
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9094c0fb8c68..36dc5199037e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4241,9 +4241,11 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		int count = 0;
 
 		llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
-			prefetch(next);
-			prefetch(&next->priority);
-			skb_mark_not_on_list(skb);
+			if (next) {
+				prefetch(next);
+				prefetch(&next->priority);
+				skb_mark_not_on_list(skb);
+			}
 			rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
 			count++;
 		}
-- 
2.52.0.313.g674ac2bdf7-goog


