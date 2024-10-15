Return-Path: <netdev+bounces-135505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE9499E285
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237BE1C21CEF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F001CF7AA;
	Tue, 15 Oct 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKYVyrEa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C41E3789
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983500; cv=none; b=WnmGDI+P0SHPKQUiFtQx99Oq1qlRyubnVto8VrfySyf6sMQar4mVydDNiJwCZyQZTXv6mDYcmurI2bI6LlE5HBToqED6pXsPwiFmVrwuO+hqMLWa1p4Gr1QwM/zMul2RsfXaAxtAseiK+5BqSqKzt8E6Wnhx715hXW4z0mX1LRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983500; c=relaxed/simple;
	bh=D45yL0Nju2kzfdQUmpMYjnkDKhPHxNDRiWQdBByaQVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2yKvdkNQFS7X8Wv6mKTwUXaQ20rxPf/9mI1elTAwb+XWhQJ4cfbO+ot3thxkWY9YfqpRhZ6C1xxLnAKuAkT5A9s1QeWSGf9jd1uuo+6I7FMY8mJ8ynFtpUHNr31g4c7Wfe4fzlkbjqSjV2+3v8AUdpLe8jolHn1PcVdl132e00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKYVyrEa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWSRCepcrvlsxye2pWByyEa1SGiFttt8FSXGegJlNpA=;
	b=BKYVyrEa6Cz0S8VW6d3MCAyaLgs++6O/uEBD1yRmEqXSi03/KXHBRqI0KRqjGLce2doup9
	Xb49+oy5FJzZ85SRJFh5gA8p2GfSPx4OPpCNRGfSAohgMnc+nO6JpdcmiglCo25X9aYv0Q
	Wp8NxtYahaT3D8DPoLS2UM6APjzZFPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Cr1g_R2pPH6vBk-tq963pA-1; Tue, 15 Oct 2024 05:11:36 -0400
X-MC-Unique: Cr1g_R2pPH6vBk-tq963pA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4311c5e8c02so25243205e9.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 02:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983495; x=1729588295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWSRCepcrvlsxye2pWByyEa1SGiFttt8FSXGegJlNpA=;
        b=HwHfX1DA0Zsh9rmZvxDbRW3LzQcViXViJwU/T2TyDCN1GGJaVV1zLodQ6DsMp/JJwv
         6oDO/lx2EujLmLSe1g6zlXgKMro0fVTlWUnEO+eQv2+Wr5wOkxnBBJ1vjz7QZ+cAfNn3
         69cX0x/a2rMoV/sQF/TV70hj8TEe1fkEOul/ZkQVj4RMCS0iQWr73YBsVJW4YFlbieb5
         KHZt40PHTugvGGaIT5YbF/BrtY3UY6PiVblFeTCRHy1l/dX7RqJ6OoYjCehrlEZB1liE
         5JdRjOk7hz8Z65M9Ux6sHQQ39YlEW1GiJuhZYKtSaZ7d1oTzIXRrEXADWfPkhLW1/9Nm
         g2Jw==
X-Gm-Message-State: AOJu0YypjBwyzNVMHvjumbNkfXSFkIEhkadstfJPYqg6mEWs4NP3RmZT
	ZDtyD1FAwfe56Wu9N9GkYK4vwLU1DnQMvUGU+hPQy8YiScWiOce5Lz8OFC+AGDucxytydJq/v9Q
	vxACqI0ZXhm6xlL+jtOxCVXCiCNJVpis24rnZZHME7ogEtwOeeDEBzw==
X-Received: by 2002:a05:600c:1ca3:b0:426:5269:1a50 with SMTP id 5b1f17b1804b1-4311deca951mr121116995e9.11.1728983495325;
        Tue, 15 Oct 2024 02:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Gojakidof+JbRocyzjez9WGX2iWcFsxWM7LieLAfsxobmd6zuSq0jnECBlYGNu0Rd2+ZVA==
X-Received: by 2002:a05:600c:1ca3:b0:426:5269:1a50 with SMTP id 5b1f17b1804b1-4311deca951mr121116825e9.11.1728983494963;
        Tue, 15 Oct 2024 02:11:34 -0700 (PDT)
Received: from debian (2a01cb058d23d60030b5722051bf3d85.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:30b5:7220:51bf:3d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56eab2sm11562235e9.26.2024.10.15.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:11:34 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:11:31 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/6] xfrm: Convert xfrm_dst_lookup() to dscp_t.
Message-ID: <4c397061eb9f054cdcc3f5e60716b77c6b7912ad.1728982714.git.gnault@redhat.com>
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

Pass a dscp_t variable to xfrm_dst_lookup(), instead of an int, to
prevent accidental setting of ECN bits in ->flowi4_tos.

Only xfrm_bundle_create() actually calls xfrm_dst_lookup(). Since it
already has a dscp_t variable to pass as parameter, we only need to
remove the inet_dscp_to_dsfield() conversion.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/xfrm/xfrm_policy.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c6ea3ca69e95..6e30b110accf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -291,7 +291,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
 EXPORT_SYMBOL(__xfrm_dst_lookup);
 
 static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
-						int tos, int oif,
+						dscp_t dscp, int oif,
 						xfrm_address_t *prev_saddr,
 						xfrm_address_t *prev_daddr,
 						int family, u32 mark)
@@ -310,7 +310,8 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 		daddr = x->coaddr;
 	}
 
-	dst = __xfrm_dst_lookup(net, tos, oif, saddr, daddr, family, mark);
+	dst = __xfrm_dst_lookup(net, inet_dscp_to_dsfield(dscp), oif, saddr,
+				daddr, family, mark);
 
 	if (!IS_ERR(dst)) {
 		if (prev_saddr != saddr)
@@ -2695,9 +2696,8 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 				family = xfrm[i]->props.family;
 
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
-			dst = xfrm_dst_lookup(xfrm[i],
-					      inet_dscp_to_dsfield(dscp), oif,
-					      &saddr, &daddr, family, mark);
+			dst = xfrm_dst_lookup(xfrm[i], dscp, oif, &saddr,
+					      &daddr, family, mark);
 			err = PTR_ERR(dst);
 			if (IS_ERR(dst))
 				goto put_states;
-- 
2.39.2


