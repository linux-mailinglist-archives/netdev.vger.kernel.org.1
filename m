Return-Path: <netdev+bounces-94476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D958BF993
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F5DB209AC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AED7351A;
	Wed,  8 May 2024 09:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307D53801
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160814; cv=none; b=rxq04+jQmasazUfaBhrs+rRXGLaYKwcmghlS8U79hpHR9vwOnkvbGYAyxznvrJCzj24NIzajkNd+LNvUDGQVh/v5qwXViPoLIQjy3Z9zp0s/CrjHXBUbcoxlFCghuAccCxjwGoKBcjgk2pNQjhSHzSuI8WrdPZruy9eSn0VVoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160814; c=relaxed/simple;
	bh=hYjgfENPs193RAnlxpzuU1vh2f9jZ7ImChNdk6SAHwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KvF5Bh6ggsXqLlVRJ/fitFZj8EjtRL5z0aCDFgHjjGxQKQXSzOaxSL3nv1W2C7QEljusziag4gRzaBg5iFJiTwSOakIPWHdDszbuZ7/JG7h+4/Fi/LjajLy9NTGu3/G1QqedcbMb71yXFy8VAzBcN3FG3ACN9QvCdoe3SNDTNxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-uDHvtExQM5yYoa8TJzEZnQ-1; Wed, 08 May 2024 05:33:21 -0400
X-MC-Unique: uDHvtExQM5yYoa8TJzEZnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 745D4101A525;
	Wed,  8 May 2024 09:33:21 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0270C28E2;
	Wed,  8 May 2024 09:33:19 +0000 (UTC)
Date: Wed, 8 May 2024 11:33:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCHv2 net] ipv6: sr: fix invalid unregister error path
Message-ID: <ZjtG3iQywq2xll6H@hog>
References: <20240508025502.3928296-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240508025502.3928296-1-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-08, 10:55:02 +0800, Hangbin Liu wrote:
> The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
> is not defined. In that case if seg6_hmac_init() fails, the
> genl_unregister_family() isn't called.
>=20
> At the same time, add seg6_local_exit() and fix the genl unregister order
> in seg6_exit().
>=20
> Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-=
deref")
> Reported-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: define label out_unregister_genl in CONFIG_IPV6_SEG6_LWTUNNEL(Sabrina=
 Dubroca)
> ---
>  net/ipv6/seg6.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 35508abd76f4..6a80d93399ce 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -551,8 +551,8 @@ int __init seg6_init(void)
>  #endif
>  #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
>  out_unregister_genl:
> -=09genl_unregister_family(&seg6_genl_family);
>  #endif
> +=09genl_unregister_family(&seg6_genl_family);

Sorry, I didn't notice when you answered my comment yesterday, but
this will create unreachable code after return when
CONFIG_IPV6_SEG6_LWTUNNEL=3Dn and CONFIG_IPV6_SEG6_HMAC=3Dn:

out:
=09return err;
=09genl_unregister_family(&seg6_genl_family);
out_unregister_pernet:
=09unregister_pernet_subsys(&ip6_segments_ops);
=09goto out;


(stragely, gcc doesn't complain about it, I thought it would)


The only solution I can think of if we want to avoid it is ugly:

 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
 #endif
+#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_H=
MAC)
 =09genl_unregister_family(&seg6_genl_family);
+#endif
 out_unregister_pernet:
 =09unregister_pernet_subsys(&ip6_segments_ops);
 =09goto out;

(on top of v2)

For all other cases your patch looks correct.

--=20
Sabrina


