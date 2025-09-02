Return-Path: <netdev+bounces-219138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22925B40131
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035D9169FC9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4132D3ECF;
	Tue,  2 Sep 2025 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdfOHBzy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E0829E10B
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817207; cv=none; b=XMWJRIRXd6jwugfJB+wXIH434v8lopM6xdfDCbMQD748UiWBGiscJtaQRposc+wFfMmUvkT57SW/xqqhvzPzC4757q6tCuWMdsLJj0SY9Rvqnz3F9lDYfcpwIAUSIWpMAq89k9/e8FjqJ93OxqaqprANt2fw0hxWYcaHxrGI010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817207; c=relaxed/simple;
	bh=3c49xpF3VIkjrmaM6TipqHL1CY4E3XoEdbcBzd+8F+8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WCA8Ir/7F4ZWo2Nx32JdDhFRn1OrIBlw3fumjK2/gw1P63rY4rnTKSiQJV1RKl5UGqSiaUTS0Cg/KMN88JvAsBUIegWqpW053JrbCTITryHldwXnPRUtOEv9bR4AVzYHiXLjazzudbqoCbDrV2Ky6p0i/bUGTrzZ8UsdJTPQ4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdfOHBzy; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b2f78511e6so31263781cf.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756817205; x=1757422005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ocB/5P+JH6484FQbfq5sc3OfYtPIArSA6WLClsRC36k=;
        b=SdfOHBzyQUxWiTJ8vJYvMFcqizLTw0d/DLXUjYCCIvLcgga0D7hziw4nB8HDtMYNwp
         /65257RtNmdjBtnhK4NYV6Eji6kwFZJgyhG8wd+dwT860OXtz409RC5YvROM7aYNO1OW
         20VsYu+GdJKF/dr+PCWEpSFqIeCL8a5nWFalFgyDo1VtkkShRVN3p6SEJDwaxez5Ilto
         L1jNs20fuzkEwidMZfA1W7+jPytQWXJVh8q0lHw89FJUmwJksZpliV3GXxAB1rOj7MHK
         A4beobhDRMUurdqAxkD1mbF2T9EbsyaHKnGlnRfcZfn4THPWh4bEQSkTmYwMRAeD9BZ3
         ixRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817205; x=1757422005;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocB/5P+JH6484FQbfq5sc3OfYtPIArSA6WLClsRC36k=;
        b=l89rOboN3QCnH0AbXD821P5sTody5cIJNVkz4iLM41sKrhyvnRGxCuJrYB91GS1KLh
         pNzZ/JuJe2dOKakKXltxulxNx/9QgcGlmbUIfem5UdEnlQftQn51ANhnoK3w6SwaLpZR
         8l/+QURVFaETkv4heYe+2zceU4oYw5Ec9a21ZI1crR0F5KmBubSlvK/vX+WiMkhOc0IH
         s/z8S8FcxdXE6XwCpJKVn66yFUz4cGbH5EYyFcHHsWPJZQYqDkVLdKDQC7fEz6s/l7Qz
         btSS5YfkPxpis85iMqM4gPSshhXOUkOW62qxGg5OXQZedlucgoIZCXQ1+0ls6yDEplDy
         mxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB68ka9ulpWuHkniOGNyUTEL4uEVZ5BKKUMYhOKAAw9j/kxkAqAe4qlIWD5FANXzcqSKxhB0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMm4i1Sa1RW4vYtwiN/IoqId9aC1yQ6ZHPk/tMLQvc+F0OlkrZ
	m9qKuMr2Z/fQDM0f8pl4lmPNdkX2zdufLuIBmyMgMYIsJaSI2wXTw3nvjhHw1TBVfpLsUAe+cUk
	0d0VpWYqY0GU/9A==
X-Google-Smtp-Source: AGHT+IEohCOlBGvsvsIpiL0yAZKh+6iQqOXKC5NTPYfaD3wxB15UeX4hCneFdy+VNQYS2lp1HypQAm6ZwSAndA==
X-Received: from qtbhx4.prod.google.com ([2002:a05:622a:6684:b0:4b0:93f0:b8b5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:578d:0:b0:4b3:cbc:18c3 with SMTP id d75a77b69052e-4b31d844826mr128525401cf.29.1756817204685;
 Tue, 02 Sep 2025 05:46:44 -0700 (PDT)
Date: Tue,  2 Sep 2025 12:46:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250902124642.212705-1-edumazet@google.com>
Subject: [PATCH net] ax25: properly unshare skbs in ax25_kiss_rcv()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Bernard Pidoux <f6bvp@free.fr>, Joerg Reuter <jreuter@yaina.de>, 
	linux-hams@vger.kernel.org, David Ranch <dranch@trinnet.net>, 
	Dan Cross <crossd@gmail.com>, Folkert van Heusden <folkert@vanheusden.com>
Content-Type: text/plain; charset="UTF-8"

Bernard Pidoux reported a regression apparently caused by commit
c353e8983e0d ("net: introduce per netns packet chains").

skb->dev becomes NULL and we crash in __netif_receive_skb_core().

Before above commit, different kind of bugs or corruptions could happen
without a major crash.

But the root cause is that ax25_kiss_rcv() can queue/mangle input skb
without checking if this skb is shared or not.

Many thanks to Bernard Pidoux for his help, diagnosis and tests.

We had a similar issue years ago fixed with commit 7aaed57c5c28
("phonet: properly unshare skbs in phonet_rcv()").

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Bernard Pidoux <f6bvp@free.fr>
Closes: https://lore.kernel.org/netdev/1713f383-c538-4918-bc64-13b3288cd542@free.fr/
Tested-by: Bernard Pidoux <f6bvp@free.fr>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Joerg Reuter <jreuter@yaina.de>
Cc: linux-hams@vger.kernel.org
Cc: David Ranch <dranch@trinnet.net>
Cc: Dan Cross <crossd@gmail.com>
Cc: Folkert van Heusden <folkert@vanheusden.com>
---
 net/ax25/ax25_in.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index 1cac25aca637..f2d66af86359 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -433,6 +433,10 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 int ax25_kiss_rcv(struct sk_buff *skb, struct net_device *dev,
 		  struct packet_type *ptype, struct net_device *orig_dev)
 {
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
 	skb_orphan(skb);
 
 	if (!net_eq(dev_net(dev), &init_net)) {
-- 
2.51.0.318.gd7df087d1a-goog


