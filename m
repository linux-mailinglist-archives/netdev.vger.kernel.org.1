Return-Path: <netdev+bounces-86582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC689F3C9
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB022B271CA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512915CD6B;
	Wed, 10 Apr 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8reJPlx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62631157A43
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754879; cv=none; b=P0D9zux2vy8f5I3U0tzkdZAuxffLfw6O3MEJj86966rwYCTcAc5jMfd2/WopbdEvYSaSW5ORMVI/n0tiVgW1ByujmiSOJROkkDpj/NegzVM+n3UgitwvdSLbYp7Gj2VzaWPN77bOpFG7/PTx63Afk2CDSCCyl2cK1va2nIvXPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754879; c=relaxed/simple;
	bh=alx2jJ+qVf6a7QI9itf9aoW8GsBX1lV0yMpqbfRa/fs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DNHGBg7c8isvsIDwyPVw8He1ra1Es2B7jdmR4P9Qo0mPIK8Ra410Kra+ybevpZ8K8kcrSdHx8mBsjOuM/Ys3wvtzpzz4s3LdeIoUm/jj8ANpENa7jT8TAMxxwWrSgg5NPxLi8p/HJv3xs8WPTmciUqEihcUrUv9ebtHhOE/cPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8reJPlx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712754876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=e6J+fCpvjONQ0JpxjZD/UsYaaTCaXUi9/60ijaIaeFE=;
	b=E8reJPlxkZCft+FDTPIlkXrO0YEbfGDdVKO9+aPuGyov+mXPXssd0/J7aHygeUy08MAJUv
	uLaiTqjCNiTmUhxpFf1Z5PPxqOQyfZWPVGfA6y11qYQsVFNLtij3TCmCfrhfA1rKFHRJ7H
	En6bJErHFefuUQW2gfDvldOU1MY2yOc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-zNOH5l_3Ooid_o44U75rbw-1; Wed, 10 Apr 2024 09:14:34 -0400
X-MC-Unique: zNOH5l_3Ooid_o44U75rbw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-434d4339f98so16503681cf.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712754874; x=1713359674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6J+fCpvjONQ0JpxjZD/UsYaaTCaXUi9/60ijaIaeFE=;
        b=Jy0wMDqgDXs1sl1/3MJMrS0OKp2bUfBJFw6q0g4ylYC4ZHKc2eHiLgITm4zhI70SAW
         zqDZvsXwe5k0XgvAhY8oWxFJnMXXR84zBZQWNJBORlCRov8qOZpCiSZUYwL8QCVj5bd8
         V4/0xfEexSxv6QphrIYFtl3YeyX0ZmbcJCRDgBTj9tNbSU41je/X6jZ57MVXgxON+9mR
         8x65F6u/Oyq543WwAucnNC64A6jEpDhnqDrti6mwK74n6HdN7LhZgFD4D+dxKyzxqvOt
         ul32aLIGBH/z8ChBkPuDx8LErqLz1gtne42x5is0+cjv2VIH4TTGP4WU5zlP6qdToXdy
         nHFQ==
X-Gm-Message-State: AOJu0Yzo0gFFTpjnGtJuFmQKflfGz2ND8Ds3AWcrEAjT5YliRl7vFgpY
	OANRjK8vMoYtwlM6e7dG4/AOt0w9pVY+jSekSEI83i1kvktZCPIK0C6XevpjQlX75wP3lmQCqtU
	3VeGtBizXVGv4Wk3XkOI73AQCBOykZy+ysTj0anBrW8YhgUty27w27w==
X-Received: by 2002:a05:622a:1911:b0:432:f472:5e15 with SMTP id w17-20020a05622a191100b00432f4725e15mr3068973qtc.22.1712754873763;
        Wed, 10 Apr 2024 06:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqlndBSSPHaHoRVEoeyZC99uo60vEVGe5qc82AGNY4ZLwaizkMSPNu0cc4sxhSvyHQr9R9Xg==
X-Received: by 2002:a05:622a:1911:b0:432:f472:5e15 with SMTP id w17-20020a05622a191100b00432f4725e15mr3068949qtc.22.1712754873468;
        Wed, 10 Apr 2024 06:14:33 -0700 (PDT)
Received: from debian (2a01cb058d23d6001bf7e3274e0488b9.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1bf7:e327:4e04:88b9])
        by smtp.gmail.com with ESMTPSA id d19-20020ac851d3000000b004364d940d3dsm93870qtn.96.2024.04.10.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:14:33 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:14:29 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next] ipv4: Remove RTO_ONLINK.
Message-ID: <57de760565cab55df7b129f523530ac6475865b2.1712754146.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

RTO_ONLINK was a flag used in ->flowi4_tos that allowed to alter the
scope of an IPv4 route lookup. Setting this flag was equivalent to
specifying RT_SCOPE_LINK in ->flowi4_scope.

With commit ec20b2830093 ("ipv4: Set scope explicitly in
ip_route_output()."), the last users of RTO_ONLINK have been removed.
Therefore, we can now drop the code that checked this bit and stop
modifying ->flowi4_scope in ip_route_output_key_hash().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h |  2 --
 net/ipv4/route.c    | 14 +-------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 315a8acee6c6..630d1ef6868a 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -35,8 +35,6 @@
 #include <linux/cache.h>
 #include <linux/security.h>
 
-#define RTO_ONLINK	0x01
-
 static inline __u8 ip_sock_rt_scope(const struct sock *sk)
 {
 	if (sock_flag(sk, SOCK_LOCALROUTE))
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c8f76f56dc16..bc6759e07a6f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -106,9 +106,6 @@
 
 #include "fib_lookup.h"
 
-#define RT_FL_TOS(oldflp4) \
-	((oldflp4)->flowi4_tos & (IPTOS_RT_MASK | RTO_ONLINK))
-
 #define RT_GC_TIMEOUT (300*HZ)
 
 #define DEFAULT_MIN_PMTU (512 + 20 + 20)
@@ -498,15 +495,6 @@ void __ip_select_ident(struct net *net, struct iphdr *iph, int segs)
 }
 EXPORT_SYMBOL(__ip_select_ident);
 
-static void ip_rt_fix_tos(struct flowi4 *fl4)
-{
-	__u8 tos = RT_FL_TOS(fl4);
-
-	fl4->flowi4_tos = tos & IPTOS_RT_MASK;
-	if (tos & RTO_ONLINK)
-		fl4->flowi4_scope = RT_SCOPE_LINK;
-}
-
 static void __build_flow_key(const struct net *net, struct flowi4 *fl4,
 			     const struct sock *sk, const struct iphdr *iph,
 			     int oif, __u8 tos, u8 prot, u32 mark,
@@ -2638,7 +2626,7 @@ struct rtable *ip_route_output_key_hash(struct net *net, struct flowi4 *fl4,
 	struct rtable *rth;
 
 	fl4->flowi4_iif = LOOPBACK_IFINDEX;
-	ip_rt_fix_tos(fl4);
+	fl4->flowi4_tos &= IPTOS_RT_MASK;
 
 	rcu_read_lock();
 	rth = ip_route_output_key_hash_rcu(net, fl4, &res, skb);
-- 
2.39.2


