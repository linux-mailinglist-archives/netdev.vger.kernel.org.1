Return-Path: <netdev+bounces-77583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28D872395
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04B51C21A03
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21212838C;
	Tue,  5 Mar 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFEsv4XY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C907128833
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654667; cv=none; b=c/z+ydY8KdTXrDH9Ac+Cp0JOBDeSaCwA2t3AMgMEtJZZWhEFSPhzxnER1bWVu/pJW8PIZRh5c9eU2UwSt5ZXQ4CeT4NQ43mam1IG6uPC/PuiGenJr5xpmo5vtAJrP61yeEV66bmuXd9rc7X3Gjizz0HcntrYKcc3oKfz9/EUstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654667; c=relaxed/simple;
	bh=ClIk7kQtxWQZHnPBckWAKi71GT8HcpiekxkfprrzHdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KT1c3/QtLOjBsa7PZbKDDQQw9BLBFuMzfv20OMhiqX0VrNt7Afh+Ols9gkhQfjeALgUv6qrn9maq7DO7sDNhZJHbsdkoCeoL4WkbeQ4CPY0Cl8OPjb/7HUvUNzP4oI5q2blaP+xiegM8aEDKD8/VjYk0Fo+f2QlNSJfx0CNc1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFEsv4XY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so7580992276.3
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654665; x=1710259465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnrJVah67Ylh005tHnrwHvl3p9vempg6J3tNuVCiAdo=;
        b=VFEsv4XY1/D92+AiKEVANGY1YYfF40qHBlpqHSUJawDtJ9kPXkUNOvnyqWiKPH682E
         AVq1RbGX2ATmL9noxwQaRAvTB5iBEsXFNL3AskZZ7sr3SzuNL92FnF3u+a8WvvKmwql+
         3aP1+lLlCGBCdNO4RgRnNB0bg0EwCQa9nTO8Y5Z5QQ5gX98+VTxntT5EivSZc00QML30
         /H4q6YtBtFcra/S3Ayol7YIlv3JYX16GH6IRrldXMz74gfQoV//yNHEXzueZpPud+xAz
         04vtct0qhhG+FDM1agxY8OLj9mDwJO3zuD6QrJSbi7lqajVM6+yPxUiPxylayVB6OXSe
         a5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654665; x=1710259465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnrJVah67Ylh005tHnrwHvl3p9vempg6J3tNuVCiAdo=;
        b=nS4UOSVs63lQpLgwRXz0YeMIqcVQZAwaG5IdUNPnxZzvU0U9Fo8F9BzczsnPmyCxiz
         cFcltmnKRjOru8WE9raILcmxcibX87T+rSU8QryTLh/wpwbnxW7tqeiZsrOZ4ibHDps+
         G5AeXlC9XpVo1AwIdIEPBv6dwHQ3JesTHWCChYOG8Gh/41oIgqQ6sBXk60u6Y3bz7mHn
         Prsgk+b0za9BWDrbHUGlEgTEzwc04M/fNBx2NNa8boE6T70cuS22FLYH9YYm4OfRwhSX
         S3fRlkoYZ/nfGF6QK4LCBRb0qTbGhGslTysI6LEK8QnRrKx8AwLwPTAWcTOVkW/WO9EQ
         26oA==
X-Gm-Message-State: AOJu0YzraCAHgz/z6Xz5szxi3YFXFNn20tZjAqQjbtI6mDariwn4PPwq
	vcfVzIKXF7yMUAKOnBaMDr2c44RvgA0cQQWnosyvLJvPWnskHtQ8gqt0/dzwY/W34TNxMIOTkeo
	5HTH6jXGUhQ==
X-Google-Smtp-Source: AGHT+IGZ39/TBmeRRiAYM1QUFg9NoSkMD1E3edAmIIN5oACkYKJBss/EEXyNVcLnfHJi1IJxv1sGf/GXoL5u1Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP
 id w9-20020a056902100900b00dbe387da8efmr416752ybt.1.1709654664767; Tue, 05
 Mar 2024 08:04:24 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:01 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-7-edumazet@google.com>
Subject: [PATCH net-next 06/18] net: move ip_packet_offload and
 ipv6_packet_offload to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures are used in GRO and GSO paths.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h  |  7 +++++++
 net/ipv4/af_inet.c     | 18 +++++++++---------
 net/ipv6/ip6_offload.c | 18 +++++++++---------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index dc50b200a94b6b935cd79d8e0406a61209fdc68e..ec752d234c5ed4b9c110c9e61c143fe8fc27089e 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -3,9 +3,16 @@
 #define _NET_HOTDATA_H
 
 #include <linux/types.h>
+#include <linux/netdevice.h>
 
 /* Read mostly data used in network fast paths. */
 struct net_hotdata {
+#if IS_ENABLED(CONFIG_INET)
+	struct packet_offload	ip_packet_offload;
+#endif
+#if IS_ENABLED(CONFIG_IPV6)
+	struct packet_offload	ipv6_packet_offload;
+#endif
 	struct list_head	offload_base;
 	struct list_head	ptype_all;
 	int			gro_normal_batch;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5daebdcbca326aa1fc042e1e1ff1e82a18bd283d..08dda6955562ea6b89e02b8299b03ab52b342f27 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1904,14 +1904,6 @@ static int ipv4_proc_init(void);
  *	IP protocol layer initialiser
  */
 
-static struct packet_offload ip_packet_offload __read_mostly = {
-	.type = cpu_to_be16(ETH_P_IP),
-	.callbacks = {
-		.gso_segment = inet_gso_segment,
-		.gro_receive = inet_gro_receive,
-		.gro_complete = inet_gro_complete,
-	},
-};
 
 static const struct net_offload ipip_offload = {
 	.callbacks = {
@@ -1938,7 +1930,15 @@ static int __init ipv4_offload_init(void)
 	if (ipip_offload_init() < 0)
 		pr_crit("%s: Cannot add IPIP protocol offload\n", __func__);
 
-	dev_add_offload(&ip_packet_offload);
+	net_hotdata.ip_packet_offload = (struct packet_offload) {
+		.type = cpu_to_be16(ETH_P_IP),
+		.callbacks = {
+			.gso_segment = inet_gso_segment,
+			.gro_receive = inet_gro_receive,
+			.gro_complete = inet_gro_complete,
+		},
+	};
+	dev_add_offload(&net_hotdata.ip_packet_offload);
 	return 0;
 }
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index cca64c7809bee9a0360cbfab6a645d3f8d2ffea3..b41e35af69ea2835aa47d6ca01d9b109d4092462 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -419,14 +419,6 @@ static int ip4ip6_gro_complete(struct sk_buff *skb, int nhoff)
 	return inet_gro_complete(skb, nhoff);
 }
 
-static struct packet_offload ipv6_packet_offload __read_mostly = {
-	.type = cpu_to_be16(ETH_P_IPV6),
-	.callbacks = {
-		.gso_segment = ipv6_gso_segment,
-		.gro_receive = ipv6_gro_receive,
-		.gro_complete = ipv6_gro_complete,
-	},
-};
 
 static struct sk_buff *sit_gso_segment(struct sk_buff *skb,
 				       netdev_features_t features)
@@ -486,7 +478,15 @@ static int __init ipv6_offload_init(void)
 	if (ipv6_exthdrs_offload_init() < 0)
 		pr_crit("%s: Cannot add EXTHDRS protocol offload\n", __func__);
 
-	dev_add_offload(&ipv6_packet_offload);
+	net_hotdata.ipv6_packet_offload = (struct packet_offload) {
+		.type = cpu_to_be16(ETH_P_IPV6),
+		.callbacks = {
+			.gso_segment = ipv6_gso_segment,
+			.gro_receive = ipv6_gro_receive,
+			.gro_complete = ipv6_gro_complete,
+		},
+	};
+	dev_add_offload(&net_hotdata.ipv6_packet_offload);
 
 	inet_add_offload(&sit_offload, IPPROTO_IPV6);
 	inet6_add_offload(&ip6ip6_offload, IPPROTO_IPV6);
-- 
2.44.0.278.ge034bb2e1d-goog


