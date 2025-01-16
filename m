Return-Path: <netdev+bounces-158798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2904A134D1
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0446A18831AA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59681DB127;
	Thu, 16 Jan 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="olchhKeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB11D95A3
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014937; cv=none; b=R/+0jViSffnQZI359x8V8PMZQZl/HDp3wkxAX0H7Z07t80GW3kCLYfltqwnZFQ0JMLQ3hdaawMjx3mikWOItrHV5uX5H5xlmjlLtWQfFeEwRpydU+uI6XwNV8NYDh0+uy0iC1UbfaZ30CCWs2H92i7zd7cI75KlDi9G4obHtLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014937; c=relaxed/simple;
	bh=GaoqUecKAtyQ+qguYmr90B1yeZ/UsTWOKRqkOYcnF54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Fbvy5PxiEzZ/PyMrk2sZvgvw42V+5B2BdmghC6PQkpj9Zb55NBcXu+2yvveBVS7JGzaxQe1fuTk3eN1Y8tYV86mI9PUglJL/w/OK12lrTnnC7O9uuLYwPYWK3+qCvEtTM6aT1ku6NIu822IuAhAOZnf/YAgRtTeXM5964kpQPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=olchhKeF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163bd70069so11058265ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 00:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014935; x=1737619735; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sr3AZgpAWe/4VnOS/hnlHnXvPWA7Ea0pV5fu0VlMHbQ=;
        b=olchhKeF0ORSjOEUrsFJ32BHlvGzk8IdNKAnnPwSI9mH4RctjOvlvmhReG+Qvk+4GL
         p32aODsHZrmIyHNYs0mOl/nkUyochFQyGffR5PRhucz+Zn69wkTEWUf+DvmrIBlu3Fpm
         oq5vvxOa67jtDN2AYHUO4tgxlkipO5/Gsz4Om7nvFOUyEktuSJVy0S65jopX867KJQXO
         lAw2JN+bCxQTuVmF38hLwz6hjLcq2FdRi/K8lvW69XAeXbGdQBTu9gZRFHHYqttYyqhu
         B5MuV3/zZfA7GT9p3PVW19wxDdqG+e9T4uXShI5eSuTH6MOVNioP210u/G9UlcPY6wqx
         1iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014935; x=1737619735;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr3AZgpAWe/4VnOS/hnlHnXvPWA7Ea0pV5fu0VlMHbQ=;
        b=pg7lydnJis6iQIgZ0r75f5b9NKz4uBaQePdrzVytR4398N8yvmUB8onF04CxbrQWoI
         3ilWkSG6t3agMGkHTVwW5lBYcYmfyN8YgNKGiRXC1p7jyQFp81XTk4sMDAa1jAYGmyg/
         rn97Fg9CX2KB0oT1tMkQtFLiVlLBOWRA0aR7O4LY5ja8ZxCDhu5fDJ9uLyCh7ycBSLwT
         7v9BszIbcdmykrqDPppaklR7FH12rCo6uXK3Gna/SXfdkp5fx0U2qFgdDInIH6XJMcg4
         9sIiLns9mGyyTPhYEmHifka9+pq3emco0kN46ZZAEiAXd0UWOMTbKs0gvzxkHEA9Cp2x
         YsDw==
X-Forwarded-Encrypted: i=1; AJvYcCUvSW72TMOJ0+ZtS73YpbX/UvA1FHGwcfS66imMSGGeiAgfhjFHPhNSMWPrEw3NdjOSpRW27Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmATL5p68fYHbh1ar+XBdKm4SyVufb6InRXhR12LEABW/1ynwp
	B5LOAyletu9+uJK8ELVuf6LNBy47KccUDkC8wyzQH64GEFAHtsrB8T8LMZJfHoN3lOlAIGnCIRS
	bMQw=
X-Gm-Gg: ASbGncsiOKDk12G9absJNr0/B4QjE6iWlroeMLDyggt8dR60efNeYWumHop7duZM9RB
	szYYaSdPHI32ylDcDu/CjB8mSiEIdEXK1Y7l7A05aZaRlQq/fgyrwfJvl1IAfxsGzUqiAzES1uS
	ah/65D3RjuW6qsn7HLQ7t0Z9UeJp6L7mZYsRB38ktnMUkN9AB/TpsG/G9kTmIjYw+uiqFBAvOu/
	ksgkAYkyFzvDy4u06aZCOwrYcAEZ+IaE9Fp0vS4Ym5Am1L4ejKfulrPtpQ=
X-Google-Smtp-Source: AGHT+IHS/tQI+KZgiPpOBaU0C7Tuw2h4kHEXmyIHIVzfFUu8R974PCCRg9snVdH9CSEC/VT7pq33OQ==
X-Received: by 2002:a17:903:1c8:b0:215:30d1:36fa with SMTP id d9443c01a7336-21a83ffbe2dmr449801035ad.39.1737014935205;
        Thu, 16 Jan 2025 00:08:55 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f13e9e7sm92600955ad.101.2025.01.16.00.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:06 +0900
Subject: [PATCH net v3 3/9] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-3-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index bd272b4736fb..ec56ac865848 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1746,6 +1746,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
+	int hdr_len = 0;
 	bool zerocopy = false;
 	int err;
 	u32 rxhash = 0;
@@ -1776,6 +1777,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
 			return -EINVAL;
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
@@ -1783,8 +1785,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1797,9 +1798,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
 		linear = copylen;
 		iov_iter_advance(&i, copylen);
 		if (iov_iter_npages(&i, INT_MAX) <= MAX_SKB_FRAGS)
@@ -1820,10 +1819,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	} else {
 		if (!zerocopy) {
 			copylen = len;
-			if (tun16_to_cpu(tun, gso.hdr_len) > good_linear)
-				linear = good_linear;
-			else
-				linear = tun16_to_cpu(tun, gso.hdr_len);
+			linear = min(hdr_len, good_linear);
 		}
 
 		if (frags) {

-- 
2.47.1


