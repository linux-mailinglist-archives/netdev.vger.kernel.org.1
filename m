Return-Path: <netdev+bounces-142533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8D9BF894
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218F11C216AA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC020CCEF;
	Wed,  6 Nov 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Js+oL5Uh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E820CCC8
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929067; cv=none; b=ned4+C64smVBY5jbXJceA4OufTvrfqfF1viaKVySrJxOB2PTENmhRLyc6nxrqOHORlOOiXs88ckg0tLRt8NCMtPg0Hlrim0t2MnJaVQnBIfb7KGxeGaGyBPBHUDCUdhmI3wkBvZH/VCUQjHBec/+PWAPmlCMp9v8LIt+Ek+AzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929067; c=relaxed/simple;
	bh=ns67C/BQnqLU+rMKxn2lZJhID9Ubh/mo990c7FfSSd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BObkEhAxoqnsU4tXMvK1X5O1J8c8zSXperOUDK+wLMgLMe+2UdN3ssPZplZTrHB4MBmfywEFLg7ZRiWwuNWvznjaMIsgouCp2EUh+64SflkjT4s/vph2f9cMgiStKHgZ/mEkOgRsYgSZAEe6xbNyJRJtW6VZzHmPMuCO9/t4fb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Js+oL5Uh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730929064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YV3axQsGEJ50qpHJdWfIL4Kylk3egm3V/oNR8O82ej0=;
	b=Js+oL5UhftzRlgAguCncP12ETuWsHDwE6X3AIpqRMaVzhtjay7GPwlrXMfqUDJ94GfDKYv
	37V++yPY9vbBZ1XEdq+2NgVu/brxFIYWXseHQ9x2Prn1IkQh+b+KDlybDwMaq7ZXM+nHw8
	sEY60CfMUu4oRmzfF35obLAevbgsipo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-phd4JFHGNiSxMiuL_RXOSg-1; Wed, 06 Nov 2024 16:37:39 -0500
X-MC-Unique: phd4JFHGNiSxMiuL_RXOSg-1
X-Mimecast-MFC-AGG-ID: phd4JFHGNiSxMiuL_RXOSg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43151e4ef43so1817405e9.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 13:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929056; x=1731533856;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YV3axQsGEJ50qpHJdWfIL4Kylk3egm3V/oNR8O82ej0=;
        b=DfEKSSHI14gP8+bytz5duTCTq5dlruj7QI4dP59W/6F9pPuHqgSL2QKVs0AYRzxiAh
         lYcBgV4qbfvZNe+AzuiNQZFdURnCNvXuSX1lKhbEGyn8dtNo2K8IN8BN47tAiwdDsa/r
         UhHsDzSbqfNcECfvSAYfv145k6i2w98NkE8Df1arkOqoU/mNzB6tIYU/8kF6LrMoZ6P0
         zlEbqh3L9r0vXEblhuz1FTle2IwrWZ1kvgRhvW6bjP1Mb/B+u/JFn51yvSCbBH5u3J2A
         7fCioeRt557S3mD7tNbnfjlEoJr1dCFKyUU+EzoOmOgT/Ym5WDdaIQq0iIZz5JIazOCf
         gG7g==
X-Gm-Message-State: AOJu0YwJjf8zlmGoDmPyC5MnzWTmdcqImmupG8UAJ6A1ZAmx3e40uKKs
	8c3um/AfwT8JkAIt+8D15Gp54lzXsBr/GVFafbyD7QrxBZFdkEILJWNZ35E4x+mkCpUp//rlDKq
	qo/qndSrO8Q3HLvpMTlS/S5phH6s4AuslC90stCTIEMDNfAWwyeX+Mw==
X-Received: by 2002:a5d:64ae:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-381be776602mr20876083f8f.17.1730929056510;
        Wed, 06 Nov 2024 13:37:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbkpQFHUZRdXmo+dnhte4YYrdw5L2sWqP9Fq7zpQvehKn9Ej9pPuiDg3MYJtL7c++nP6QDCg==
X-Received: by 2002:a5d:64ae:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-381be776602mr20876057f8f.17.1730929056046;
        Wed, 06 Nov 2024 13:37:36 -0800 (PST)
Received: from debian (2a01cb058d23d60051d26877cf512a7d.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:51d2:6877:cf51:2a7d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e747csm20226026f8f.64.2024.11.06.13.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 13:37:35 -0800 (PST)
Date: Wed, 6 Nov 2024 22:37:32 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] ipv4: Prepare ip_route_output() to future
 .flowi4_tos conversion.
Message-ID: <0f10d031dd44c70aae9bc6e19391cb30d5c2fe71.1730928699.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the "tos" parameter of ip_route_output() to dscp_t. This way
we'll have a dscp_t value directly available when .flowi4_tos will
eventually be converted to dscp_t.

All ip_route_output() callers but one set this "tos" parameter to 0 and
therefore don't need to be adapted to the new prototype.

Only br_nf_pre_routing_finish() needs conversion. It can just use
ip4h_dscp() to get the DSCP field from the IPv4 header.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h             | 6 +++---
 net/bridge/br_netfilter_hooks.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 586e59f7ed8a..0a690adfdff5 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -156,12 +156,12 @@ static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4
  * structure is only partially set, it may bypass some fib-rules.
  */
 static inline struct rtable *ip_route_output(struct net *net, __be32 daddr,
-					     __be32 saddr, u8 tos, int oif,
-					     __u8 scope)
+					     __be32 saddr, dscp_t dscp,
+					     int oif, __u8 scope)
 {
 	struct flowi4 fl4 = {
 		.flowi4_oif = oif,
-		.flowi4_tos = tos,
+		.flowi4_tos = inet_dscp_to_dsfield(dscp),
 		.flowi4_scope = scope,
 		.daddr = daddr,
 		.saddr = saddr,
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 17a5f5923d61..7f2f40cef5fe 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -406,7 +406,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 				goto free_skb;
 
 			rt = ip_route_output(net, iph->daddr, 0,
-					     iph->tos & INET_DSCP_MASK, 0,
+					     ip4h_dscp(iph), 0,
 					     RT_SCOPE_UNIVERSE);
 			if (!IS_ERR(rt)) {
 				/* - Bridged-and-DNAT'ed traffic doesn't
-- 
2.39.2


