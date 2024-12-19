Return-Path: <netdev+bounces-153355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982459F7BF1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDA41648A7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE1228E37;
	Thu, 19 Dec 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIX1fzfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA317BD9
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734613437; cv=none; b=bCrKiMcE0TwrL2B48UIEXBRJheE46YHNWKokl0/FbPDHoCxsV0SdCzUirOQIC29Xm9LG1vdvpsAcGOmjp+LIBsPYxMCT5YKfsE5HMtw7nOrz82t0NXHZ53hBiwCJaUmcmtsQOZH8TOCrYyOdXl9NYXUmeWc7IdbSFn+wPS85524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734613437; c=relaxed/simple;
	bh=l993BuhaOemrNpdrbLFkOyhPOUTMU0O43qDzmxDK5C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDQu/9Z57bOEu3Wc5xB8sMqBJ7Cmdf/GQSisCgrFaIDPrEAKk7tuTzBO2K9GojMSMjvS6QbnB2qvahi2zuR2MfqIrhJW/OqP8r1obx1XAJNqUsQT7E8mZ8IBKq1GfW5Ti/cTQpjWmy0s6iCkNr8uzQBwy8nYw+avo5247GIdz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIX1fzfy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216728b1836so6349475ad.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 05:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734613434; x=1735218234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ckpWyywRorf26orlDJPPCy+wE/kAUMKsiVsa+2ev0TQ=;
        b=JIX1fzfyyabxiwLG8MrRYeu0jBUowlnbKngRdO0cVizE2joBs0BewAp+EoBt18i615
         gLKax4ZuNuPJHCvy8m1cnLCD+MKOiwKYcc5h78Dd4lVRoYYyaPriWRQEDXUdVngLRAfu
         oCc5uZgarqON3xG3+WeUtEXiZPfU6l/4bo12B1pzDjujTlFGav4duq7AQDi4gNtoAsTy
         Es/3GY3vilwga5xQnGk22HAMAu8DFDZVltGm0vt1E6Dg7w+V3egKAXwLmsgmE4l/27GN
         rycogzeEJDMSl7rEES2m5nzj65id5FwpQxZ2XmBOanpK8g1fVBzzf4C7O3iBzyX8kZh8
         Gz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734613434; x=1735218234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckpWyywRorf26orlDJPPCy+wE/kAUMKsiVsa+2ev0TQ=;
        b=MnfCFAFpuWKxfiMf7Z30yFXwjJ23hbJ8lpx9UU9rqhQmQPMyXYrn3z2GJ4b4h4ujaO
         yw0vo3IFLK9OKcz+XQ+iU6vm3U/CXtA6e5isLutU/rBwppVa4CNqd0YTHQRX7GEuV4Ze
         e+8bts0dUFpxBvQ7F3D2OUOJ54vBJs8Wxjqa98Rg6vBdYRnYpfgHFimPr61vKnoezU0b
         OuNqy6nzj6NUXAtZxW7Dm+3bAmD29ZO2v3fAekZPO1yOc/R7Ujf8P883XJSzQ9eWxv/r
         B+wk+cBLAdWFhIEZOM1EI9+OOKuatvcQKkmBkfS1h64E24AG1ETCEtplcsUQ5EWTXwVh
         Faag==
X-Gm-Message-State: AOJu0Yx8RihK03iCnJaqHWON8WkmU6j6dxMoexnHIKnxBEQSHvSlLU/5
	LH1AcC5BO5k3xhFUxzBiSLk5nWWVjlCT2JkZSdG59BngH3UhZgHJaZ5a0Ri5u/A=
X-Gm-Gg: ASbGncsGY0U7up/7imrrwGISrGWz4WLFXqdYjPCZyUq/3Lx7rlXb4Jx3xDAq453wGZU
	03l0x0WhN5WP0MB/ZRRp8Bxh5rE3T86Qo0vxSsGxjz/lWyB2Wl+naVMg5uY/9jIS4ttqJRwwQht
	aveSdidUmxQL0BQIVN+5kQ7WiM0wNbWKFtAxpTG8YR7TSsIc7M8Z9xd119XrsVCAdx2GX70QZvt
	t5viiy1KtV4r6V2VNQaltddKJwilMwbi/b/iVkslSTUXZU=
X-Google-Smtp-Source: AGHT+IGh1xUxtMEAdR2zpOrZIxxHJb+EY7+Lt2/5uJjwKSgmVR8gTcuG15Tpc2lX2DPRUtHwGcfv+Q==
X-Received: by 2002:a17:902:e809:b0:215:aae1:40f0 with SMTP id d9443c01a7336-218d6c4aebfmr114306485ad.0.1734613434017;
        Thu, 19 Dec 2024 05:03:54 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f51c2sm11656535ad.190.2024.12.19.05.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 05:03:52 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net: Fix netns for ip_tunnel_init_flow()
Date: Thu, 19 Dec 2024 21:03:36 +0800
Message-ID: <20241219130336.103839-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device denoted by tunnel->parms.link resides in the underlay net
namespace. Therefore pass tunnel->net to ip_tunnel_init_flow().

Fixes: db53cd3d88dc ("net: Handle l3mdev in ip_tunnel_init_flow")
Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c | 3 +--
 net/ipv4/ip_tunnel.c                                | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 4b5fd71c897d..32d2e61f2b82 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -423,8 +423,7 @@ mlxsw_sp_span_gretap4_route(const struct net_device *to_dev,
 
 	parms = mlxsw_sp_ipip_netdev_parms4(to_dev);
 	ip_tunnel_init_flow(&fl4, parms.iph.protocol, *daddrp, *saddrp,
-			    0, 0, dev_net(to_dev), parms.link, tun->fwmark, 0,
-			    0);
+			    0, 0, tun->net, parms.link, tun->fwmark, 0, 0);
 
 	rt = ip_route_output_key(tun->net, &fl4);
 	if (IS_ERR(rt))
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 25505f9b724c..09b73acf037a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -294,7 +294,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
-				    iph->tos & INET_DSCP_MASK, dev_net(dev),
+				    iph->tos & INET_DSCP_MASK, tunnel->net,
 				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
@@ -611,7 +611,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
 			    tunnel_id_to_key32(key->tun_id),
-			    tos & INET_DSCP_MASK, dev_net(dev), 0, skb->mark,
+			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
 			    skb_get_hash(skb), key->flow_flags);
 
 	if (!tunnel_hlen)
@@ -774,7 +774,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
-			    dev_net(dev), READ_ONCE(tunnel->parms.link),
+			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
-- 
2.47.1


