Return-Path: <netdev+bounces-85361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102ED89A604
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 23:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD792B21671
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9D174EDB;
	Fri,  5 Apr 2024 21:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4F1C687
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352001; cv=none; b=UEOM5bZEn7XUyXIHoC+GxI3WRJ7JcWs5WfCQdyDTicOxr92P5AKVyjlHUunHsPBM2AKuq4ARLkORuKL7KrvU46EWLRziBOdi7B60GwF8iHNAlET5B9laut+KNtsYd8aAnbzd108ovZX59EjBJGhPS3wPyvv3UtKHroW9wYV/H9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352001; c=relaxed/simple;
	bh=DmWLO9dxq30HbLw9pWZItRdax35PdcRdrilzTT/8IFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E+r+0zNdoHbFelgn+QmcoON9QzetGNtr6feJBJUB6qGP5WhfEfLssUltO60+SRyArUlXjfX+CSqEjU/wlbZJeu/lKHJOgQARIxXioCJzEkFKmzo8Rb50FEj5dbBckOrmYj7Iu1M93wPXNBF5rPP5HBxkZyGHJyxQ3j4o91i750Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-B0yS12P1NjOc5eOOiUbggg-1; Fri, 05 Apr 2024 17:19:48 -0400
X-MC-Unique: B0yS12P1NjOc5eOOiUbggg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 331A5811E81;
	Fri,  5 Apr 2024 21:19:48 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B52AE1121D;
	Fri,  5 Apr 2024 21:19:46 +0000 (UTC)
Date: Fri, 5 Apr 2024 23:19:41 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com,
	Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH v4 net] geneve: fix header validation in
 geneve[6]_xmit_skb
Message-ID: <ZhBq7fe_pN90gJkX@hog>
References: <20240405103035.171380-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240405103035.171380-1-edumazet@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-05, 10:30:34 +0000, Eric Dumazet wrote:
> syzbot is able to trigger an uninit-value in geneve_xmit() [1]
>=20
> Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
> uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> skb->protocol.
>=20
> If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protocol,
> pskb_inet_may_pull() does nothing at all.
>=20
> If a vlan tag was provided by the caller (af_packet in the syzbot case),
> the network header might not point to the correct location, and skb
> linear part could be smaller than expected.
>=20
> Add skb_vlan_inet_prepare() to perform a complete mac validation.
>=20
> Use this in geneve for the moment, I suspect we need to adopt this
> more broadly.
>=20
> v4 - Jakub reported v3 broke l2_tos_ttl_inherit.sh selftest
>    - Only call __vlan_get_protocol() for vlan types.
> Link: https://lore.kernel.org/netdev/20240404100035.3270a7d5@kernel.org/
>=20
> v2,v3 - Addressed Sabrina comments on v1 and v2
> Link: https://lore.kernel.org/netdev/Zg1l9L2BNoZWZDZG@hog/
>=20
...
>=20
> Fixes: d13f048dd40e ("net: geneve: modify IP header check in geneve6_xmit=
_skb and geneve_xmit_skb")
> Reported-by: syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000d19c3a06152f9ee4@googl=
e.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Eric.

--=20
Sabrina


