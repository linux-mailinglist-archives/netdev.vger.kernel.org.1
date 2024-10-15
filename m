Return-Path: <netdev+bounces-135507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D771999E288
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9715E280B96
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768341E32CF;
	Tue, 15 Oct 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iStoMHLN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F911E379C
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983510; cv=none; b=Sj9YpSYXaLPc7K4pVDKSsYrKvJMvpX8I9QxXrcnOjs3EBl/mzw4QNzsbJBI+SvwPwtQUWQWCtx7bRkDs9AF+VJIH/YBmO8z0RlfJaCRZ3lKyJIVUX8p/8r6WQHyW4B5duZzunbgCHMuSHjiScdhaAVUdv/0uQrc76+ebzhGEOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983510; c=relaxed/simple;
	bh=p7fVzJblWm/aWEA3jxVRzNVUzYm11vtV23L0TNvG4Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd952ybdJKsRwSrPjYtBQyvlOJBqnGRrfm21HHJhJlcXwOYgZG4RUxIXCmsGkkDyHfDW5jD4Dn7DgK3P8Ckb1LBCqwgFlJLvIZ24y0zCuD/goZju/b8UY0Ij+SwV9xyv8Dd8E4m8sIA+8y5l5fWijhr1/CWVS9KDnduX8KVf33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iStoMHLN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhLuySMAmdo78JA+3a46bjlHZTPCrbjc8I3LY3cAXtI=;
	b=iStoMHLNqFf4lBWOI1TbqAwtnDuxTlyghTVyxjo43R3I+hQPk9h1kXiTpWFgW1Lq8d0ibd
	fZo78L+QItqINWDV3y+j+OqDKU8lvEB4VRejZ0E3R8tJ7/SnqSsLfXBvs0Tp1TE87YvlZT
	cWAaDi9YT+4R7Qy+ppB2sPvqoNKWJQ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-xqMyje9MOkG1sm5yG2yvvQ-1; Tue, 15 Oct 2024 05:11:46 -0400
X-MC-Unique: xqMyje9MOkG1sm5yG2yvvQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-430581bd920so33147975e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 02:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983505; x=1729588305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhLuySMAmdo78JA+3a46bjlHZTPCrbjc8I3LY3cAXtI=;
        b=UXcKr3u2qjuSWhCIkP1be9X8Z5DIwxhNxi9KPuLyhHyAkUfQguGDID/LpPeUaYpzG3
         OwYPMquiT89OEeA/rUcIONEV2e2PpHDIOiHiFK47eSPf7GWNdyaAaUvnovVcOh79YkNt
         RqouuK9UTfYUDOvLbT5GD36cWjV4MKhQOpCEIJKaQ1mnN0rOF4NZts9ieMTTAK2NGk1Q
         wf3tgMF5qGwfILDMXw5de6kDDVE2jxkxp4oPYUBMfc2oBnFe8WCc8VZhKd1rXCgy5odn
         E4rRzuJMNyuq+MGKoPO1wGhSzzCXSXjsnEvSy/wwd0bKN6lFtrJ47y5u8c6rj0sWkUxS
         FeLw==
X-Gm-Message-State: AOJu0YxmYNr6H4SKNsOux9n1zFEYC/DAdmOk9Cx8aTGOSQd8ZiNiE8TQ
	TcJbuwRaS+AeTrjWjRUXesy0NRICk2BCyuzJLPJpWUibZKoZRcg1If1o/vL7pU1Xl4a3MNVmq2R
	0cSmCOY3o6GYFImRV+C3IYlgLVYHPuJsT8mJOS8iJIRG4LVpjDGh2oGavu9QEyg==
X-Received: by 2002:a05:600c:4f0c:b0:42c:af06:703 with SMTP id 5b1f17b1804b1-4311df55ca0mr113008855e9.31.1728983504775;
        Tue, 15 Oct 2024 02:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRI606w1bKl8VjZU95EsSmuQ/ISRv+3BLrmHvQJi33JGRkPnLVK0oVk6gabEq/GU8Fplp3yg==
X-Received: by 2002:a05:600c:4f0c:b0:42c:af06:703 with SMTP id 5b1f17b1804b1-4311df55ca0mr113008555e9.31.1728983504283;
        Tue, 15 Oct 2024 02:11:44 -0700 (PDT)
Received: from debian (2a01cb058d23d60030b5722051bf3d85.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:30b5:7220:51bf:3d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55dfa8sm11803325e9.6.2024.10.15.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:11:43 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:11:42 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/6] xfrm: Convert the ->dst_lookup() callback to
 dscp_t.
Message-ID: <df58d9509a22ea12cbdfb312b57eb0eb6ea775ac.1728982714.git.gnault@redhat.com>
References: <cover.1728982714.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728982714.git.gnault@redhat.com>

Pass a dscp_t variable to ->dst_lookup() callbacks (struct
xfrm_policy_afinfo), instead of an int, to prevent accidental setting
of ECN bits in ->flowi4_tos.

This callback is only called by __xfrm_dst_lookup(), which already has
a dscp_t variable to pass as parameter. We just need to remove the
inet_dscp_to_dsfield() conversion.

There are two implementations of this callback: xfrm6_dst_lookup(),
which doesn't use the modified parameter, and xfrm4_dst_lookup() which
needs to convert it again before calling __xfrm4_dst_lookup().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/xfrm.h      | 4 ++--
 net/ipv4/xfrm4_policy.c | 8 +++++---
 net/ipv6/xfrm6_policy.c | 5 +++--
 net/xfrm/xfrm_policy.c  | 3 +--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 18c0a6077ae9..46c82d75679a 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -355,8 +355,8 @@ struct xfrm_type;
 struct xfrm_dst;
 struct xfrm_policy_afinfo {
 	struct dst_ops		*dst_ops;
-	struct dst_entry	*(*dst_lookup)(struct net *net,
-					       int tos, int oif,
+	struct dst_entry	*(*dst_lookup)(struct net *net, dscp_t dscp,
+					       int oif,
 					       const xfrm_address_t *saddr,
 					       const xfrm_address_t *daddr,
 					       u32 mark);
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 0294fef577fa..342a0158da91 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -11,6 +11,7 @@
 
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <net/inet_dscp.h>
 #include <linux/inetdevice.h>
 #include <net/dst.h>
 #include <net/xfrm.h>
@@ -40,14 +41,15 @@ static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
 	return ERR_CAST(rt);
 }
 
-static struct dst_entry *xfrm4_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
+static struct dst_entry *xfrm4_dst_lookup(struct net *net, dscp_t dscp,
+					  int oif, const xfrm_address_t *saddr,
 					  const xfrm_address_t *daddr,
 					  u32 mark)
 {
 	struct flowi4 fl4;
 
-	return __xfrm4_dst_lookup(net, &fl4, tos, oif, saddr, daddr, mark);
+	return __xfrm4_dst_lookup(net, &fl4, inet_dscp_to_dsfield(dscp), oif,
+				  saddr, daddr, mark);
 }
 
 static int xfrm4_get_saddr(struct net *net, int oif,
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index b1d81c4270ab..0c28b22ae3c1 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -18,13 +18,14 @@
 #include <net/addrconf.h>
 #include <net/dst.h>
 #include <net/xfrm.h>
+#include <net/inet_dscp.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
+static struct dst_entry *xfrm6_dst_lookup(struct net *net, dscp_t dscp,
+					  int oif, const xfrm_address_t *saddr,
 					  const xfrm_address_t *daddr,
 					  u32 mark)
 {
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a1b499cc840c..db2e602971fd 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -282,8 +282,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, dscp_t dscp, int oif,
 	if (unlikely(afinfo == NULL))
 		return ERR_PTR(-EAFNOSUPPORT);
 
-	dst = afinfo->dst_lookup(net, inet_dscp_to_dsfield(dscp), oif, saddr,
-				 daddr, mark);
+	dst = afinfo->dst_lookup(net, dscp, oif, saddr, daddr, mark);
 
 	rcu_read_unlock();
 
-- 
2.39.2


