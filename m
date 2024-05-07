Return-Path: <netdev+bounces-93996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A428BDDD8
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12D81C20B07
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479A13D52C;
	Tue,  7 May 2024 09:14:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D410E3
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073297; cv=none; b=VDS+g/FeHW/0D6aFpDi8Vp3An43bpo3DcJpfyVzwEDTiChkeU7lVpqNhtdLaUg61+mMm5Gtb2gWojOOeE6cql+LWN2IlIdELSHMW1mM8wV6lcNw/wIC5GguBxf5Yw3HxTqPWNYg0BF5wrzo899nkTNtzHB9ncgu0zQvNCfP3edU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073297; c=relaxed/simple;
	bh=84PzSkVoxsxqnDfdk4SwskS87IcYHsVzOtDxcWZitvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WVuclXESRcfp6b83sv3CWSx6ltp9ok3PvmlfWpZGoQWHydaN4VOU3yXdG1el+J6bYXI1q/N5pGFFTfWCh62bWLrwn2DjV3o9DK1JpILMaNPrZidntf4pin0w8AIqU1fpC2uZ0eZjXndrbtJuSIbfq5xW++m15ZkGSBQcSaOhCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-bDl7cRjoNSSYkQZOs43efQ-1; Tue, 07 May 2024 05:14:48 -0400
X-MC-Unique: bDl7cRjoNSSYkQZOs43efQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E38D38007BC;
	Tue,  7 May 2024 09:14:47 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B7B72022F10;
	Tue,  7 May 2024 09:14:46 +0000 (UTC)
Date: Tue, 7 May 2024 11:14:45 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net] ipv6: sr: fix invalid unregister error path
Message-ID: <ZjnxBVJDNkyGgNE6@hog>
References: <20240507081100.363677-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240507081100.363677-1-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-07, 16:11:00 +0800, Hangbin Liu wrote:
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
>  net/ipv6/seg6.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 35508abd76f4..3c5ccc52d0e1 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -549,10 +549,8 @@ int __init seg6_init(void)
>  =09seg6_iptunnel_exit();
>  #endif
>  #endif
> -#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
>  out_unregister_genl:
>  =09genl_unregister_family(&seg6_genl_family);

That label will be defined but unused for !CONFIG_IPV6_SEG6_LWTUNNEL.

> -#endif
>  out_unregister_pernet:
>  =09unregister_pernet_subsys(&ip6_segments_ops);
>  =09goto out;
> @@ -564,8 +562,9 @@ void seg6_exit(void)
>  =09seg6_hmac_exit();
>  #endif
>  #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
> +=09seg6_local_exit();
>  =09seg6_iptunnel_exit();
>  #endif
> -=09unregister_pernet_subsys(&ip6_segments_ops);
>  =09genl_unregister_family(&seg6_genl_family);
> +=09unregister_pernet_subsys(&ip6_segments_ops);
>  }
> --=20
> 2.43.0
>=20
>=20

--=20
Sabrina


