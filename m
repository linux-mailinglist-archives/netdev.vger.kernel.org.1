Return-Path: <netdev+bounces-132970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68B993FF9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320D11F25B9B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2B1E47C7;
	Tue,  8 Oct 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fqmv9pvY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F71D0488
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370490; cv=none; b=gk6l9o2Dp2b87poNqSPbRppwzArfp4BDPmyGtSNlWt14gzOpS854l2c6zhJN2gjpn8jNbjUKOLUOnMM0Uaa1V5FgyFwhu1ty7RRqKU33myRcgYOErkOXLE9sHALHH0ct9Z0Dcr5/68XU5YjkIWgtTjrBBUNNUrX35sLvNdrnClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370490; c=relaxed/simple;
	bh=uaol2IGqvlm8ZTxu7WxkWiZOHaSPhvJu+1yhZK+cfFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=A0zlUK2R0qETmZmh4X+opinSl2928IPrCixK6eB8nH5lX+9C44O5FMu8jfOc7mYEabYYcrv/zK9qFN8lRQyknerV5XZEul4v+MVigg0FIEqx4LEtUV9vCwY9uCqJ2f3y4dms8UX5izfqNymXYuOP2MjRbc4sp+Zl9M5z/FUzxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=fqmv9pvY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e02249621so1314728b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370488; x=1728975288; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUS5KMA/ewmQfZHiSllXFCUo7ZXTGgrN42vxjEBIbqQ=;
        b=fqmv9pvY8o9ipB+kE/rimSv/RWtXp9Zt7Zk088OiBWve03Jeyw3r4yukwWurgEX08X
         kjxPa4uGST4v/qU5GKPnCMwYQkhvqoYjFoxQv1FkrNTJAeIVGwuVRERB9qGNTaHVw2oe
         sUDAgPl/s+Slbpea/GS9wWepvx2SQTFEHaRlJRurp+TrL87gMen7NPDqNJp7DPhMv8xs
         omd+KMgS4JPNsPjnQsWX/o2kETJSAp4xU8m/rO0H5BYExEOVQvElTxbymh2pBeHKMadU
         na7+hEHkFwBAJ3o+YDcKig5xw1WRieOOt2vnCR4QdWitYP8bGoH8EonRZdRn4CoX84Y6
         l0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370488; x=1728975288;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUS5KMA/ewmQfZHiSllXFCUo7ZXTGgrN42vxjEBIbqQ=;
        b=Dy4NE7Xow8VKcPvydlqcs/Vk0c/YiecSFjtcgxrQIfDCUDAS/+pMF3J9jueOnxZhq4
         8p5DvD/e29GWHOZWtw1AaXOnQxnd/BjLrTrwwS4r8CRvx9Q8uOVAQpMIFobL1XDg9QFf
         mumkhGYjrdzo67JttEiD1nKB4HfiEJvUwajzhU+kDxAv6DUqUhMXlk8xzRlWGRM6NSn5
         1hncwAjNONuSHoxsh1Yo8KC8giyx7siFZZuz10r873dlWfactgcP5fG95+KMYaOkbza8
         wkmC4KTP72WepCOXpKqfAzKy9SgO6mgDDVwT99LN39VrNaV2Ucm/GC235okqnmvlIMFd
         x9+A==
X-Forwarded-Encrypted: i=1; AJvYcCUjcBnLAn/gRGo0914H1Bla+mJIo9YVXrnY9n8E+7EekZrsDBGfDmgqdoMyanYLrHtx0zn8Mz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqgaM3iJidG2NYie+hKgTDD7GnQ0VciV3KPo4YiTCa9+A5LzAE
	HmIGwJ56fatr5Df1CFr0ccRdxYmgyLxrpJF/gSjbLSQC+XmhmvO+cIuImsKwR/k=
X-Google-Smtp-Source: AGHT+IEKcNMiY7wzLXe5eQDoa0aLQOUol5zSII/XfgY6pIxMP/K/JQLspO3LpuBtTgX1dSRwe3ohkA==
X-Received: by 2002:a05:6a00:3e22:b0:71e:21c:bf1b with SMTP id d2e1a72fcca58-71e021cc1bcmr11161687b3a.14.1728370488090;
        Mon, 07 Oct 2024 23:54:48 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0d6521asm5477837b3a.166.2024.10.07.23.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:54:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:22 +0900
Subject: [PATCH RFC v5 02/10] skbuff: Introduce SKB_EXT_TUN_VNET_HASH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-2-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

This new extension will be used by tun to carry the hash values and
types to report with virtio-net headers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/skbuff.h | 3 +++
 net/core/skbuff.c      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 29c3ea5b6e93..a361c4150144 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4718,6 +4718,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
+#endif
+#if IS_ENABLED(CONFIG_TUN)
+	SKB_EXT_TUN_VNET_HASH,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..f0bf94cf458b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -64,6 +64,7 @@
 #include <linux/mpls.h>
 #include <linux/kcov.h>
 #include <linux/iov_iter.h>
+#include <linux/virtio_net.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
@@ -4979,6 +4980,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_TUN)
+	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct virtio_net_hash),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)

-- 
2.46.2


