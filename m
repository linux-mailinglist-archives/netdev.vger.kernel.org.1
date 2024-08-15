Return-Path: <netdev+bounces-118835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D45952E83
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3714A1F239CD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1019DF85;
	Thu, 15 Aug 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUiIZjJA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCF1ABEA7;
	Thu, 15 Aug 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725984; cv=none; b=hNAv376+JugzdtNNwrrFNmjBQ4bXNPvrcjvY9GK5cFdLIFsfE9RglXpdXVadiZ7PmK4MnTwatibVNAWVqa5dwHQ7Meqvb2BecLimIISFsNcMaWsArA15HsfZ8V1S266xyKa48EjJTHlLUrEbk13Hd/mmEpZY6zSQ4w+3FnZUJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725984; c=relaxed/simple;
	bh=DuiUksGCsUFlX1i6Q+VvSu/IajJRsDMDDAETiqCe05I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/wZFxIHTRX8OQJLlc5+ZH5M1O1sFOTC78+0rUt0u5gXAC1edS1+J/jdWDrcvDp6CRBBNan0mQJvnpYwRVMOU0PAgOcDF32ykVw3WGiQ+IyWZTC8hlMYs5Xhdv5w8hFshKPqaQ8OkZ0N6RLeq5cbXaSXCf3DMawB8wdwqXOQuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUiIZjJA; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-70d2ae44790so653276b3a.2;
        Thu, 15 Aug 2024 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725982; x=1724330782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SerQC29iHMyTIJeHsYTg1ulNf2UurMYXmMasoWFZmko=;
        b=lUiIZjJAohgKANybo9LmUrsppRmBopWT+rQ/pq2x2MjxSrnHhyk1qzKxFDn0os4flT
         LY86xqYtPAoPxb09ZFgEF9uWywNulzKTxk88X2eg1Lj8VrW+fO5YcHckt3q8VmzVpq/p
         jIxWyQyfIlFg/smD/JyrWILXo3HxyKS2a47zxbLuHl7W1Adl0DHQWEXBNNg+nM5GjMpl
         4ntFIUH/6UUPNUF8HaTyIvOInJ/Q+oKMTgRPdR1BlCHSgZG78Bk+Qxe9qqJk4htEMovv
         EEMsSbaQw7YCq0NJPsY7lyXDEZnenlVe9zZRu2NTWlOUF0mroYF3wKwzSw1wCzF6IoaD
         yYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725982; x=1724330782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SerQC29iHMyTIJeHsYTg1ulNf2UurMYXmMasoWFZmko=;
        b=sRGr0I0nsJT70lQ3JjSfEI5/F+efdiPm6CwnJvMdbm9UhvcczS+VvhXbj/mDzGCPQL
         NhW2VAKHqKWhZkA1bQqLbiFXfcXvLie2tqjTxr+4OU3No971+XK3ZAJf9B16RTfpCPxy
         veIDrYvgIabcH25S/0DdV9k+gFT6wwUq3bHngXPLCQ8LYg7g+IZaf6+UQOWyxJG9gTNO
         NHuMwZxRvyK0nPwB+KyB34M6YQSGz8Ezfvxi59C+sHtSpe/8CMutpwFOGzSFZQtX3bRT
         7Az3yc41aDSRQ0QxnlBS8F0yL2kntKmgB23uKJKgr8sgcCpbtBb6iq6qSYLkqtHW7OrK
         5siQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxnny0K19Pwmpp7A8fyYD712NAHUCotn0sz7a2K30W4LdtkYHlHZKhsgdSkucSrhQhL3LWGoHbS2mDCXmzGVZvGGYkr/rn4RDC085dIpwy0alCblRTN+LqVnm4lZw5GsHK9Ei1
X-Gm-Message-State: AOJu0Yz+gHjZIT7Z/jcC4qQtoz/lNNYIosSByG5FURSJR+7qTa4ps9cv
	v5fBUvcUVVyM2PlqWsooWbqPSG5Il1zkwfAlJSt8y5gpbXbIcqA6
X-Google-Smtp-Source: AGHT+IGSdS7P65poLeQgstaqbBr7YkCBoWKv00pc4D4dA3y+15Gr6i/Jx7D+nfQEOEhDQWcdTqZLcg==
X-Received: by 2002:a05:6a00:1910:b0:70d:2fb5:f997 with SMTP id d2e1a72fcca58-7126711aa53mr6470288b3a.16.1723725981629;
        Thu, 15 Aug 2024 05:46:21 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:46:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 08/10] net: vxlan: add drop reasons support to vxlan_xmit_one()
Date: Thu, 15 Aug 2024 20:43:00 +0800
Message-Id: <20240815124302.982711-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb/dev_kfree_skb with kfree_skb_reason in vxlan_xmit_one.
The new skb drop reason "VXLAN_DROP_REMOTE_IP" is introduced, which is
for a invalid remote ip.

The only concern of mine is replacing dev_kfree_skb with
kfree_skb_reason. The dev_kfree_skb is equal to consume_skb, and I'm not
sure if we can change it to kfree_skb here. In my option, the skb is
"dropped" here, isn't it?

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/drop.h       |  1 +
 drivers/net/vxlan/vxlan_core.c | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
index da30cb4a9ed9..542f391b1273 100644
--- a/drivers/net/vxlan/drop.h
+++ b/drivers/net/vxlan/drop.h
@@ -14,6 +14,7 @@
 	R(VXLAN_DROP_MAC)			\
 	R(VXLAN_DROP_TXINFO)			\
 	R(VXLAN_DROP_REMOTE)			\
+	R(VXLAN_DROP_REMOTE_IP)			\
 	/* deliberate comment for trailing \ */
 
 enum vxlan_drop_reason {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 22e2bf532ac3..c1bae120727f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2375,6 +2375,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
 	bool no_eth_encap;
 	__be32 vni = 0;
+	SKB_DR(reason);
 
 	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
 	if (!skb_vlan_inet_prepare(skb, no_eth_encap))
@@ -2396,6 +2397,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 						   default_vni, true);
 				return;
 			}
+			reason = (u32)VXLAN_DROP_REMOTE_IP;
 			goto drop;
 		}
 
@@ -2483,6 +2485,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 					   tos, use_cache ? dst_cache : NULL);
 		if (IS_ERR(rt)) {
 			err = PTR_ERR(rt);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
@@ -2534,8 +2537,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
 				      vni, md, flags, udp_sum);
-		if (err < 0)
+		if (err < 0) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto tx_error;
+		}
 
 		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
 				    pkey->u.ipv4.dst, tos, ttl, df,
@@ -2555,6 +2560,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (IS_ERR(ndst)) {
 			err = PTR_ERR(ndst);
 			ndst = NULL;
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
@@ -2595,8 +2601,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		skb_scrub_packet(skb, xnet);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
 				      vni, md, flags, udp_sum);
-		if (err < 0)
+		if (err < 0) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto tx_error;
+		}
 
 		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
@@ -2611,7 +2619,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 drop:
 	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
-	dev_kfree_skb(skb);
+	SKB_DR_RESET(reason);
+	kfree_skb_reason(skb, reason);
 	return;
 
 tx_error:
@@ -2623,7 +2632,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
-	kfree_skb(skb);
+	SKB_DR_RESET(reason);
+	kfree_skb_reason(skb, reason);
 }
 
 static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
-- 
2.39.2


