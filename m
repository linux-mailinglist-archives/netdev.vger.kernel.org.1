Return-Path: <netdev+bounces-123735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0599665A0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00F21F228C7
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F91B5332;
	Fri, 30 Aug 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkaAofJ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382221292CE
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031876; cv=none; b=JXfVEcg1Cv/kAH/ipbbGE74o7EmY2D/FbmGVubVSNc1tTaEOW2MSVNsiCQtsc4BqiG3R8RKaqFmiWajgKBZ44w1yHKZL09rBlA4zzUD7DvPnnjEXFyxMgGj/eOYZuB6a9eBap2ei+HSbtTXVnHM2kbH8SwpZkibziPkXFEgPh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031876; c=relaxed/simple;
	bh=BrmX0pBtzeLraIQNjBltWbyqQinSQN+LmeG84gbUyc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eqYmAkRJqL3akoIcbmSQkzhSOzSYnqRl9FY7YzubB8OESvoDL+XZ1ehYIKhJhZLbIMesYEnAoxN2G+RdxFnuMySyhhPnx917FW09BO7cemIjC1o8FEV4zRPbZ8T7ubkYDp2ogO55qgRaC43TiG8UdcjvvApvMTZdV8N488PJpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkaAofJ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725031874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zdLhKatNCFhpvKmDGDPJBGbbEE8d8TZntfC3Is+GuB4=;
	b=DkaAofJ9ppF+0ll4Rv2SbCSRoVSzwwnPdu3Kczaw00c1XvOja7TkBAikKfnK5Rc78FlKnp
	813/sG39RPyagA0Dje4/61LrcdIBZgHwF3sdM43vmGYbznVddIAmGA24RUtGj5cVYrUkoZ
	JCDdfdqlwx1OPBeJ7Dr46naur2pZ0Tk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-tU01MVMWOl2DjcBP1AbOrA-1; Fri, 30 Aug 2024 11:31:12 -0400
X-MC-Unique: tU01MVMWOl2DjcBP1AbOrA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371a804f191so1291345f8f.3
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031871; x=1725636671;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdLhKatNCFhpvKmDGDPJBGbbEE8d8TZntfC3Is+GuB4=;
        b=YUwErgscuD97Cd5SZptwtbQ6qx0BwvcpAzr91DcMG+JTTk5mmG9O5AOFaD1qgVLTE5
         xOemro2/DLh1z8EWZqCMW7hUDuTWv+6RkPCYW8n9deao9daizlBvjG/ofDhdBgn33lLI
         tqnEfkZkTKHsZ6cTfiUnsFkuGPlTP1sIGAqp/rFEf4KVNCbX8fYnq2ZzLmp5sG7RmKVY
         nkM+IqWspMpBdCIftLs3rG7VVefPhwf6M4Lle/rPOqQUNCxrfRG/v8Ek/6OVTZhwLJvD
         DleZqBvf22LCZw0EyopVpx5opuTrIZNIgU4Mya94+cuiJlAiGHjdQi2OJX4Xz7DLdhsw
         Ag3A==
X-Gm-Message-State: AOJu0Yxxx6Z4HyHPkkKUqYi1XP3Iie0wXXNud1TUu0s/wBOwbrxLXc26
	l/qIaGhbsFDUD6gRokbKLcaJnm64/xNhEgyj8s8TsXEvuPCdzuBK1/QQHHV77Ur5yeFWjedwI3l
	S0ZwRthJXXX5/gRmfBX9S3omYSljFU4+GxxJ3OAqDnG5JX4AlAXaJMg==
X-Received: by 2002:adf:fa44:0:b0:368:6598:131e with SMTP id ffacd0b85a97d-3749b57eb04mr4910958f8f.38.1725031871308;
        Fri, 30 Aug 2024 08:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS/mQVDrHW0AZ9Xr/Es8W5vJiCjHXCScasaQ2EUD6Khyb0RvyxrjE4hy+dqxOEjRv1oQekPg==
X-Received: by 2002:adf:fa44:0:b0:368:6598:131e with SMTP id ffacd0b85a97d-3749b57eb04mr4910932f8f.38.1725031870453;
        Fri, 30 Aug 2024 08:31:10 -0700 (PDT)
Received: from debian (2a01cb058918ce0082efdd5a87b482df.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:82ef:dd5a:87b4:82df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef81265sm4280531f8f.79.2024.08.30.08.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:31:09 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:31:07 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bareudp devices update their stats concurrently.
Therefore they need proper atomic increments.

Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/bareudp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index d5c56ca91b77..7aca0544fb29 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -83,7 +83,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 		if (skb_copy_bits(skb, BAREUDP_BASE_HLEN, &ipversion,
 				  sizeof(ipversion))) {
-			bareudp->dev->stats.rx_dropped++;
+			DEV_STATS_INC(bareudp->dev, rx_dropped);
 			goto drop;
 		}
 		ipversion >>= 4;
@@ -93,7 +93,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		} else if (ipversion == 6 && bareudp->multi_proto_mode) {
 			proto = htons(ETH_P_IPV6);
 		} else {
-			bareudp->dev->stats.rx_dropped++;
+			DEV_STATS_INC(bareudp->dev, rx_dropped);
 			goto drop;
 		}
 	} else if (bareudp->ethertype == htons(ETH_P_MPLS_UC)) {
@@ -107,7 +107,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   ipv4_is_multicast(tunnel_hdr->daddr)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				bareudp->dev->stats.rx_dropped++;
+				DEV_STATS_INC(bareudp->dev, rx_dropped);
 				goto drop;
 			}
 		} else {
@@ -123,7 +123,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   (addr_type & IPV6_ADDR_MULTICAST)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				bareudp->dev->stats.rx_dropped++;
+				DEV_STATS_INC(bareudp->dev, rx_dropped);
 				goto drop;
 			}
 		}
@@ -135,7 +135,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				 proto,
 				 !net_eq(bareudp->net,
 				 dev_net(bareudp->dev)))) {
-		bareudp->dev->stats.rx_dropped++;
+		DEV_STATS_INC(bareudp->dev, rx_dropped);
 		goto drop;
 	}
 
@@ -143,7 +143,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	tun_dst = udp_tun_rx_dst(skb, family, key, 0, 0);
 	if (!tun_dst) {
-		bareudp->dev->stats.rx_dropped++;
+		DEV_STATS_INC(bareudp->dev, rx_dropped);
 		goto drop;
 	}
 	skb_dst_set(skb, &tun_dst->dst);
@@ -169,8 +169,8 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 						     &((struct ipv6hdr *)oiph)->saddr);
 		}
 		if (err > 1) {
-			++bareudp->dev->stats.rx_frame_errors;
-			++bareudp->dev->stats.rx_errors;
+			DEV_STATS_INC(bareudp->dev, rx_frame_errors);
+			DEV_STATS_INC(bareudp->dev, rx_errors);
 			goto drop;
 		}
 	}
@@ -467,11 +467,11 @@ static netdev_tx_t bareudp_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_kfree_skb(skb);
 
 	if (err == -ELOOP)
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
-		dev->stats.tx_carrier_errors++;
+		DEV_STATS_INC(dev, tx_carrier_errors);
 
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	return NETDEV_TX_OK;
 }
 
-- 
2.39.2


