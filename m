Return-Path: <netdev+bounces-140770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA189B7F18
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC71C2090F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D413AD26;
	Thu, 31 Oct 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMXkEbGm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D9137905
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389985; cv=none; b=h9aaPy1E0POiZxkUwfLrsygg7nh1itDfAqfX0EPNz4ou7arqRc8NcppU8mdjZjilc2AoCO8A+DDBBJr4vAKFzOLR9LA2JwdkOYR1ELLzk7lHgQQrkohCbCbH3xA6oigjwUXBWuyBs5HKqpJw2gPdxCUjHzmFRjlwoSs5ZLxRzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389985; c=relaxed/simple;
	bh=OAWs+LgzczxS6iySJUfz/vQZHxno4osYUha0mn37+6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAzanpRfFGa1iV3EgiWY4mozD1DDrXt+rX4KvPIfp17ND6vt8hSBaZMt3kyH16EbjY2BUeMmuTkK0sULT7/nk703Nsba6ae7PoUtPkc9cpoyRPzudp7KtZAsxfXPbYxElISo/8U3dJf+c/SGQ8Z94ntB82CrJvgsQJm13jsavxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMXkEbGm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730389982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rllN4UI447JTGvoLW+1vTEHQ3gJbfCMqlBAQAvzlylI=;
	b=hMXkEbGmg976uPnVH5AzIwVu9ktKIU4o02YKv4nnbJLvG3+nUukF1HeRu3dD8ojS6PNqdX
	/ycM6jSCLXAZ5xdMnc8Sr/572x8cVf77hM39dJodkitjEA3sJ6la4emoa2MTRXS/FWwDel
	yMJHrEKlRxob+4UytAq+SJ1ZqheGXvk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-zGvF8GxxPpuXDIp-gXwVsA-1; Thu, 31 Oct 2024 11:53:01 -0400
X-MC-Unique: zGvF8GxxPpuXDIp-gXwVsA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-431ad45828aso7238985e9.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389980; x=1730994780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rllN4UI447JTGvoLW+1vTEHQ3gJbfCMqlBAQAvzlylI=;
        b=kHPkgjnKEyPS0u31ihGWDy+a5ScPN6CY8eynSlzu+efCokiVLK/Oh7j/QlJfO5reDV
         lVEhKf+Zsj9Ey/LZbJqfVF1yctvac/lkKXgGeShE6rb0xJPfRk6jEo2lX9DxWgoKkn6t
         f1Wg3foLsgUdqtn/rRaHznmqwlvOcG68ZGFbL9JqGEkSwqynYqLHrlLsL75rcnptqyjc
         TC1yMmEjNQF2AxOLDDOMKbt0rCj/XthXzhc+fYGYovFKRu3ExtQaixcK7xzSlctau1NL
         dCyurrtLRLabZ9H5QPIOTbjhgBLPhQ+cpmk8dqgxfE35Qk54lIrcQZpFTVaHusggYFty
         BkiA==
X-Gm-Message-State: AOJu0Yxho86sOgvQQ9i4zclG19DKFviAx4bAM9SHBvA5PiOUzXoxMPAs
	i0HAeBZv/Agh90mcQPTpwy6ybXag9i7xNJchTZza5vuB8qE6qTq+Gfaa6FeheiqkMsICFGq0ktq
	lxjca2Btsz9Ii+YJHRrG9GGdXSG+NPJdJKUVuVvp4ORs0kfX2mWRPS2oHs26jhg==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-4319ac70754mr191131025e9.1.1730389979860;
        Thu, 31 Oct 2024 08:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7aAFQyGb4fMINZILJtO4y97DAhF+BL+vxQo8NXrxLAJJf7/4i8eYbmfcy75lN0cDuK2D71Q==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-4319ac70754mr191130745e9.1.1730389979516;
        Thu, 31 Oct 2024 08:52:59 -0700 (PDT)
Received: from debian (2a01cb058918ce002753490a7d66077e.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:2753:490a:7d66:77e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e7d23sm60349095e9.7.2024.10.31.08.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:52:59 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:52:57 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec-next v2 4/4] xfrm: Convert struct
 xfrm_dst_lookup_params -> tos to dscp_t.
Message-ID: <8b7dbe727a3aae1d61a2a43ec4a7f932feed70a0.1730387416.git.gnault@redhat.com>
References: <cover.1730387416.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730387416.git.gnault@redhat.com>

Add type annotation to the "tos" field of struct xfrm_dst_lookup_params,
to ensure that the ECN bits aren't mistakenly taken into account when
doing route lookups. Rename that field (tos -> dscp) to make that
change explicit.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/xfrm.h      | 3 ++-
 net/ipv4/xfrm4_policy.c | 3 ++-
 net/xfrm/xfrm_policy.c  | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a0bdd58f401c..48ec4c415e98 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -19,6 +19,7 @@
 
 #include <net/sock.h>
 #include <net/dst.h>
+#include <net/inet_dscp.h>
 #include <net/ip.h>
 #include <net/route.h>
 #include <net/ipv6.h>
@@ -351,7 +352,7 @@ void xfrm_if_unregister_cb(void);
 
 struct xfrm_dst_lookup_params {
 	struct net *net;
-	int tos;
+	dscp_t dscp;
 	int oif;
 	xfrm_address_t *saddr;
 	xfrm_address_t *daddr;
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 7e1c2faed1ff..7fb6205619e7 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -14,6 +14,7 @@
 #include <linux/inetdevice.h>
 #include <net/dst.h>
 #include <net/xfrm.h>
+#include <net/inet_dscp.h>
 #include <net/ip.h>
 #include <net/l3mdev.h>
 
@@ -24,7 +25,7 @@ static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
 
 	memset(fl4, 0, sizeof(*fl4));
 	fl4->daddr = params->daddr->a4;
-	fl4->flowi4_tos = params->tos;
+	fl4->flowi4_tos = inet_dscp_to_dsfield(params->dscp);
 	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(params->net,
 							    params->oif);
 	fl4->flowi4_mark = params->mark;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9e231c1ece3f..e91607fe45ba 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -312,7 +312,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 	params.net = net;
 	params.saddr = saddr;
 	params.daddr = daddr;
-	params.tos = inet_dscp_to_dsfield(dscp);
+	params.dscp = dscp;
 	params.oif = oif;
 	params.mark = mark;
 	params.ipproto = x->id.proto;
-- 
2.39.2


