Return-Path: <netdev+bounces-291639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJJqNj5zFWpbVAcAu9opvQ
	(envelope-from <netdev+bounces-291639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:17:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 786405D409A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F7AF3010BAA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61AC3D9035;
	Tue, 26 May 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnv5CC8A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57119231829
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790652; cv=none; b=gLWh3kzrI1qEA0G+eueainDdEstWfPTM3q8/rE+FZgRqUX2ug6DENLgnT9BrPpbHJY40P4O7kKPXBCOXvbXHILYZ17e7JXV6sAnXy9lbLFariuN6bm5N5aAjXf2YnFMT6NeE3d7Ewj2OpU37b9//wKqK44c1TMjPTQilQrPBvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790652; c=relaxed/simple;
	bh=6N77agkMlPlDs2FQWT5UHiMAbCGXqJ3ogGviMdt8G/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QboAzml5ikBOEb5tVp3ATfpgtiNLv2BDTp9rsdm6X4vnmW6H5TJf+TMb9bV7kuWPn3kAUKsNERMSzCmdZaFBriK70zzg0kkejsHpyNg6I7HS0PhorILYM06u2d50J5GVE/UCXtQY0E5v9FVnzMAAfzjM+w117DvP394EpnxsL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnv5CC8A; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8354461da74so4726733b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790651; x=1780395451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+uIV2cz4HzSSZVOFRjcZFH+o3S0t/SI2v9CRVV9MLk4=;
        b=cnv5CC8AzJUPKhyPjhTqbGDU16xbyZLjMrfSp3T+5/ZIEXiSsCR5yeLfCzLVh3TKZL
         Wkx9zrFuw65nl7nGvrDJofxMSVIaxKIrsSYMFab6nZ4Vyiwpvd6jJNNuzAf0z03Qw+zb
         nBjK/2UzBVE5kmea7oeHEdpVr/YizQxIRfVu/BzuNXH9LAUP1U3I6QFT7AnzWpHpbRVT
         D3K2KRN+x6BR/AvcNvcDy6LLFIWnAyOdt/cmqDe38YQ6KHBNEYwqgdWGOxw0gYSSanc8
         f6s4zixJYYWLhzxJ/Bv83+ihsemFrOmKmM4guDpQY+F6xHzqYth3q9QabRz6Zn4VZbrO
         79Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790651; x=1780395451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uIV2cz4HzSSZVOFRjcZFH+o3S0t/SI2v9CRVV9MLk4=;
        b=iiHQY9BJFtXob3nE0K7qtlI95Fajb4sjKV2no+1kS6k6CkHcJysG3YA4/MNSKE0P35
         vWUI0a2uH9I1vdlqJ50zLTmgBDIDuU8rsq3Mhhy0i7IbC7xhvI+iL811vt70e0v00K2e
         3pj3ZYV/gbhTx68vfR/RWF9I47OduNpM2ZaAT+W6W5pCTbsGxeV+n+H1giZ0IHhL6E/1
         DttAG8ZxZ3phazFngedbcbP7FWTG04gRYtRCAaCx+d9Yqo2pbrsI1+99qx92sSCDBZyd
         8FzKbW7q8SsTz41VKX1qkrXP8sBkI5biJEBeyAJudzj6yH1I2bTqIm6SPGnzXZwL4s1q
         hgrw==
X-Gm-Message-State: AOJu0Yx2R6lU+tBeYNMO5Jg6wVZ/UciAhX/t+YbMKYEstMecVP2ebfyF
	yk89EjlXOJ4vVsQkpJSw2BFj9usnf2xLc6VPfSE/bF0bKe3H1PyCTq0z
X-Gm-Gg: Acq92OHE+3Y9URyCg+sYhXRBott0jR0n7phoV1dDF1dQ7f9LREwVtNLeCf01ajsojbh
	b5MUiu8xUY7NkVEfMGLPMtSjqkD5Z6pYUZm7Tj02RKP5JRsLHqQr2NAcYe37506CvXbVkjE3rpx
	5umxNtpoY3XFXhZhkQRok3M3xj34LUkgpkQl8hKh09qZaL1p3XJvkK0IadVnCfFAGcswhkRXyH3
	gKCRUdOk4YuWiirVyJrOAtu6UV1hxOyHaQ4KSN3H6LKg8aH/WelzIDH/c3+c87pIFeObZzvP3qP
	kJp5X25C/ky5d7jmd0cMQ4SQV2HG6Gakke7aBTrsoqWVG+XBBlodSUwxQbdrOmxVNLkAL5URwZ6
	p1qq1s99ve1J61iRQZrrpw3tr9xsBaABuPDc+ixOZanztzpjHp8HE8unSV0y8OHkGqeYveghS66
	GF4xp+6YOVpbIVkP8GSj59wd0LLdQliig6f1vw5yeHQzthWOxus/RaYMA4FiQI
X-Received: by 2002:a05:6a00:2e1f:b0:82f:5c3f:94c6 with SMTP id d2e1a72fcca58-8415f5a60f1mr16937977b3a.28.1779790650578;
        Tue, 26 May 2026 03:17:30 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164e9e635sm13333206b3a.38.2026.05.26.03.17.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:17:29 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH xfrm] xfrm: vti: hold device reference for tunnel pointer stored in skb cb
Date: Tue, 26 May 2026 18:17:24 +0800
Message-ID: <20260526101724.69508-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 786405D409A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vti_input() and vti6_input_proto() stash a tunnel device pointer in
XFRM_TUNNEL_SKB_CB(skb)->tunnel without taking a device reference.
When xfrm processes the packet asynchronously (hardware crypto or
pcrypt workqueue), the completion callback vti_rcv_cb() / vti6_rcv_cb()
dereferences this pointer from workqueue context. If the tunnel is
destroyed between stash and callback, the pointer references freed memory.

Add dev_hold() when stashing the tunnel pointer and dev_put() in the
receive callbacks after use, matching the existing dev_hold(skb->dev)
pattern in xfrm_input() for the physical ingress device.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/ipv4/ip_vti.c  |  8 +++++++-
 net/ipv6/ip6_vti.c | 10 ++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..3be298c5a80c 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -62,6 +62,7 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 			goto drop;
 
 		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
+		dev_hold(tunnel->dev);
 
 		if (update_skb_dev)
 			skb->dev = tunnel->dev;
@@ -112,6 +113,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 	if (err) {
 		DEV_STATS_INC(dev, rx_errors);
 		DEV_STATS_INC(dev, rx_dropped);
+		dev_put(dev);
 
 		return 0;
 	}
@@ -125,6 +127,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 		if (inner_mode == NULL) {
 			XFRM_INC_STATS(dev_net(skb->dev),
 				       LINUX_MIB_XFRMINSTATEMODEERROR);
+			dev_put(dev);
 			return -EINVAL;
 		}
 	}
@@ -135,12 +138,15 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 	ret = xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family);
 	skb->mark = orig_mark;
 
-	if (!ret)
+	if (!ret) {
+		dev_put(dev);
 		return -EPERM;
+	}
 
 	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(skb->dev)));
 	skb->dev = dev;
 	dev_sw_netstats_rx_add(dev, skb->len);
+	dev_put(dev);
 
 	return 0;
 }
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..367a3325cf9c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -317,9 +317,10 @@ static int vti6_input_proto(struct sk_buff *skb, int nexthdr, __be32 spi,
 			goto discard;
 		}
 
+		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
+		dev_hold(t->dev);
 		rcu_read_unlock();
 
-		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
 		XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
 		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
 		return xfrm_input(skb, nexthdr, spi, encap_type);
@@ -356,6 +357,7 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 	if (err) {
 		DEV_STATS_INC(dev, rx_errors);
 		DEV_STATS_INC(dev, rx_dropped);
+		dev_put(dev);
 
 		return 0;
 	}
@@ -369,6 +371,7 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 		if (inner_mode == NULL) {
 			XFRM_INC_STATS(dev_net(skb->dev),
 				       LINUX_MIB_XFRMINSTATEMODEERROR);
+			dev_put(dev);
 			return -EINVAL;
 		}
 	}
@@ -379,12 +382,15 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 	ret = xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family);
 	skb->mark = orig_mark;
 
-	if (!ret)
+	if (!ret) {
+		dev_put(dev);
 		return -EPERM;
+	}
 
 	skb_scrub_packet(skb, !net_eq(t->net, dev_net(skb->dev)));
 	skb->dev = dev;
 	dev_sw_netstats_rx_add(dev, skb->len);
+	dev_put(dev);
 
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)


