Return-Path: <netdev+bounces-100326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9678D8913
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF4D1C21AAE
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D61386D8;
	Mon,  3 Jun 2024 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUxD3Ooc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE03139CEE
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441025; cv=none; b=RyDb8GYdof83Y3/YINGO6tOL4t0O7+1lcfyJ0ei4DrSAXxxtS7XC6FJsLoL3Li8lq50ZaMQ0qeqYM6utcBcSpqTF0bnh2SaeupHLHtOP6FSNEaZx2ShMz1PQdyNOC66uRGKLUSF9UgJ8BXfAIlfMP93dBAy73UU6jQCaX7YWyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441025; c=relaxed/simple;
	bh=Ct9vywJmGK1CJloPL/bRZTZdgNRV/LmvFmSZ5WDVHwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzmI8NsUlmcxTmSx7d0UvWKfg/NuHxtzZNREJT4C8SZ2OWdmpYieQpuNU37/sbh2DhjZAP3Dmne9u9FgvqSttLTih54sj7VrnK4pVI1zENE4our4JSeJRNt8Y1lryYiuOlmSXVYDHnYidV02pOh8YybQ+V2At5j/XBvFY8luJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUxD3Ooc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717441023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIDPi7gUErWP223w2FklBtvKymIuybnwzHfEv4BqDmM=;
	b=ZUxD3OocFwxjDIJknKdOkyCUTKMqsq0R96SFFfa682fyGyaKp65sb6IAGNs7KY1nCAzGSY
	9WprLLEr+GgORSxd4ku0uDbOxzQQEa/MAIH9TidKZVA7vlcIxiJ4QK1D9RGXR8aAKlcH2V
	vrYCmB4xzbRpF13UQcEXY1ECv88h9XU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-_gplJciDNQavFqhIJSVcGw-1; Mon,
 03 Jun 2024 14:56:59 -0400
X-MC-Unique: _gplJciDNQavFqhIJSVcGw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 359E81913F40;
	Mon,  3 Jun 2024 18:56:58 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A0AF190DB3B;
	Mon,  3 Jun 2024 18:56:52 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/9] net: psample: add user cookie
Date: Mon,  3 Jun 2024 20:56:35 +0200
Message-ID: <20240603185647.2310748-2-amorenoz@redhat.com>
In-Reply-To: <20240603185647.2310748-1-amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a user cookie to the sample metadata so that sample emitters can
provide more contextual information to samples.

If present, send the user cookie in a new attribute:
PSAMPLE_ATTR_USER_COOKIE.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/net/psample.h        | 2 ++
 include/uapi/linux/psample.h | 1 +
 net/psample/psample.c        | 9 ++++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/psample.h b/include/net/psample.h
index 0509d2d6be67..2ac71260a546 100644
--- a/include/net/psample.h
+++ b/include/net/psample.h
@@ -25,6 +25,8 @@ struct psample_metadata {
 	   out_tc_occ_valid:1,
 	   latency_valid:1,
 	   unused:5;
+	const u8 *user_cookie;
+	u32 user_cookie_len;
 };
 
 struct psample_group *psample_group_get(struct net *net, u32 group_num);
diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
index e585db5bf2d2..e80637e1d97b 100644
--- a/include/uapi/linux/psample.h
+++ b/include/uapi/linux/psample.h
@@ -19,6 +19,7 @@ enum {
 	PSAMPLE_ATTR_LATENCY,		/* u64, nanoseconds */
 	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
 	PSAMPLE_ATTR_PROTO,		/* u16 */
+	PSAMPLE_ATTR_USER_COOKIE,	/* binary, user provided data */
 
 	__PSAMPLE_ATTR_MAX
 };
diff --git a/net/psample/psample.c b/net/psample/psample.c
index a5d9b8446f77..b37488f426bc 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -386,7 +386,9 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 		   nla_total_size(sizeof(u32)) +	/* group_num */
 		   nla_total_size(sizeof(u32)) +	/* seq */
 		   nla_total_size_64bit(sizeof(u64)) +	/* timestamp */
-		   nla_total_size(sizeof(u16));		/* protocol */
+		   nla_total_size(sizeof(u16)) +	/* protocol */
+		   (md->user_cookie_len ?
+		    nla_total_size(md->user_cookie_len) : 0); /* user cookie */
 
 #ifdef CONFIG_INET
 	tun_info = skb_tunnel_info(skb);
@@ -486,6 +488,11 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 	}
 #endif
 
+	if (md->user_cookie && md->user_cookie_len &&
+	    nla_put(nl_skb, PSAMPLE_ATTR_USER_COOKIE, md->user_cookie_len,
+		    md->user_cookie))
+		goto error;
+
 	genlmsg_end(nl_skb, data);
 	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
 				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
-- 
2.45.1


