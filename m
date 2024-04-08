Return-Path: <netdev+bounces-85757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DBB89BFB1
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BFA1F22198
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B97CF1F;
	Mon,  8 Apr 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV/FuN8g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEEE7BAFD
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581110; cv=none; b=YhYzM6WvmTcWvsYWll1z3VluSvOYgmul0JdkvKwb86vX9PGGi1el2vacazUTCkxyfwmyDC0rvja95lsuK13aKB+33pr8qzbJJ/TDrL37ZDbEesd2vSqAQ2rfCD/QoSyojzPD+jvSCE+x9B8G25ckZ1GaUyoPOWkKJMWnhK6vamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581110; c=relaxed/simple;
	bh=kF/bqzz4mzoPphXhTN8LFNIEpCX5AhJnwNEDHHfmvuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUlpr+MaDZgSkx6x67ZkyIUoXV4dCxVOV3Q3wtIwIM/nc/e8+6wjZT2rW2FDaM/p2ANbj/VQ1HZcC0qnght44PSWxlBHLJ1c061R+irpq6eQx1rVoTFuDIsRNMj81f0lJgSxqr6kgVbobj5zEK+I2Ia5Sohtpk7mCQkfYd6/JVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aV/FuN8g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712581108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGVy8Azl62jFM3927f2h3RE43mNDEWmkRx8aXu39BnU=;
	b=aV/FuN8gF8vym005GJRUN0aUwhD2NPsda3GDIUTegL9Usy+sOzgluFCdATCiLiOplWSpNH
	sLoopOtv+bim+MuK9u9X85cmQrRDyL2oLkJGv3XPzdR65wUSU3+HG3ew52dxE2h2cmXs7v
	0oRuxp+oVeZM2EWl1Fh4nF3akWLz/4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-vN1kun-6MXiLjUWOPoi0XQ-1; Mon, 08 Apr 2024 08:58:25 -0400
X-MC-Unique: vN1kun-6MXiLjUWOPoi0XQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B5C9801FAF;
	Mon,  8 Apr 2024 12:58:24 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.170])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D66FC47E;
	Mon,  8 Apr 2024 12:58:22 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	cmi@nvidia.com,
	yotam.gi@gmail.com,
	i.maximets@ovn.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org
Subject: [RFC net-next v2 3/5] net: psample: add user cookie
Date: Mon,  8 Apr 2024 14:57:42 +0200
Message-ID: <20240408125753.470419-4-amorenoz@redhat.com>
In-Reply-To: <20240408125753.470419-1-amorenoz@redhat.com>
References: <20240408125753.470419-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Add a user cookie to the sample metadata so that sample emitters can
provide more contextual information to samples.

If present, send the user cookie in a new attribute:
PSAMPLE_ATTR_USER_COOKIE.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/net/psample.h        |  2 ++
 include/uapi/linux/psample.h |  1 +
 net/psample/psample.c        | 12 +++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/psample.h b/include/net/psample.h
index 0509d2d6be67..2503ab3c92a5 100644
--- a/include/net/psample.h
+++ b/include/net/psample.h
@@ -25,6 +25,8 @@ struct psample_metadata {
 	   out_tc_occ_valid:1,
 	   latency_valid:1,
 	   unused:5;
+	u8 *user_cookie;
+	u32 user_cookie_len;
 };
 
 struct psample_group *psample_group_get(struct net *net, u32 group_num);
diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
index 5e0305b1520d..1f61fd7ef7fd 100644
--- a/include/uapi/linux/psample.h
+++ b/include/uapi/linux/psample.h
@@ -19,6 +19,7 @@ enum {
 	PSAMPLE_ATTR_LATENCY,		/* u64, nanoseconds */
 	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
 	PSAMPLE_ATTR_PROTO,		/* u16 */
+	PSAMPLE_ATTR_USER_COOKIE,
 
 	__PSAMPLE_ATTR_MAX
 };
diff --git a/net/psample/psample.c b/net/psample/psample.c
index a0cef63dfdec..9fdb88e01f21 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -497,7 +497,8 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 		   nla_total_size(sizeof(u32)) +	/* group_num */
 		   nla_total_size(sizeof(u32)) +	/* seq */
 		   nla_total_size_64bit(sizeof(u64)) +	/* timestamp */
-		   nla_total_size(sizeof(u16));		/* protocol */
+		   nla_total_size(sizeof(u16)) +	/* protocol */
+		   nla_total_size(md->user_cookie_len);	/* user_cookie */
 
 #ifdef CONFIG_INET
 	tun_info = skb_tunnel_info(skb);
@@ -596,6 +597,15 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 			goto error;
 	}
 #endif
+	if (md->user_cookie && md->user_cookie_len) {
+		int nla_len = nla_total_size(md->user_cookie_len);
+		struct nlattr *nla;
+
+		nla = skb_put(nl_skb, nla_len);
+		nla->nla_type = PSAMPLE_ATTR_USER_COOKIE;
+		nla->nla_len = nla_attr_size(md->user_cookie_len);
+		memcpy(nla_data(nla), md->user_cookie, md->user_cookie_len);
+	}
 
 	genlmsg_end(nl_skb, data);
 	psample_nl_obj_desc_init(&desc, group->group_num);
-- 
2.44.0


