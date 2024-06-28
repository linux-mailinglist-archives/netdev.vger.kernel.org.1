Return-Path: <netdev+bounces-107648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE891BD0C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96101C21453
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCDF15687D;
	Fri, 28 Jun 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLC8tyMw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3115572D
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719572780; cv=none; b=H9LKhJJJ+VYEFSEDvBLco1EhNWqN1vJ+dk5PH5rdqorb6SW+K4edfrWijNCn9wc1QNvC0+IAB64+pG0z+YJK761xauIzMoUyuDBqRJHljBabu4aY6X3u9mptWi/RPmk03Z5RMUZkza26lF/mpiqJPrLCT8lI9ItRaxqGyhlezpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719572780; c=relaxed/simple;
	bh=Bh37XELNLBmNjXKxdiUJLrM+GzYsb3yJUGB+3dlp9ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXR0O98pD88Af0QRaLT46+/knT5b852gCmC4r+UeDo9snOSx8np2j8nru6kxaulCPEI9z0LIwOt93nu6Vqc+2as/aN7BVKPUcvlHdwc4AGH2MvUi211kDy4cHZS3x8ny2mV8PCZVQU8845oS+Ht34B6tH2YGyOhSg+H5sTHDod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLC8tyMw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719572778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9DQLwAo1xCe0ZiP8YjZQLvQekEc7XoE8Zz2fPcUAVI=;
	b=WLC8tyMwgVzZNEnGJp9Cey8vPY4Pl1H9UvQzcTCjdZerG7EgTfNP3LXHnVpX2I3EoRVobg
	3zdr9ok1X457UYD61w2qRVP5wQtWAWqsJHTUjhpsr/p3wwRBlISj4y4arFhi5u6zLeMw9M
	Z0sD/37ZTIvs8Azm7DRMoDI0m1OrAVk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-wW2xlZSpNeK6HhR2u5Ejvw-1; Fri,
 28 Jun 2024 07:06:14 -0400
X-MC-Unique: wW2xlZSpNeK6HhR2u5Ejvw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 959A61955DC3;
	Fri, 28 Jun 2024 11:06:11 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 172E61955D8B;
	Fri, 28 Jun 2024 11:06:06 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 01/10] net: psample: add user cookie
Date: Fri, 28 Jun 2024 13:05:37 +0200
Message-ID: <20240628110559.3893562-2-amorenoz@redhat.com>
In-Reply-To: <20240628110559.3893562-1-amorenoz@redhat.com>
References: <20240628110559.3893562-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a user cookie to the sample metadata so that sample emitters can
provide more contextual information to samples.

If present, send the user cookie in a new attribute:
PSAMPLE_ATTR_USER_COOKIE.

Acked-by: Eelco Chaudron <echaudro@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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
2.45.2


