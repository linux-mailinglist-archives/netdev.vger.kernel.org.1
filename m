Return-Path: <netdev+bounces-84527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE58972BB
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CADDB2F083
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70C14A4CE;
	Wed,  3 Apr 2024 14:28:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32514A4CD
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154496; cv=none; b=ZM0hhfM/+b/s4EVU6o+QjX+MIo4RQHIjQfe/4cKb8W1ezKIddP5STIkY6q+r/hF68XtLgAiCzPoao4hTA2Qvg53pV9Uu6Ox77EdLBVIV91OynaSKySEPF32suKUi/1WjvoNPQU2/kxp/viGOwIx4INTMmaCvDVLiQd5tw4OUO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154496; c=relaxed/simple;
	bh=f1L9pROcoaKSRYijR8o8UtonvKDF6ouM01PeizyBvi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M0CAjFhNBG64bC82mNtayKm2v4PHGVTpwv2/DMFGBlY+sNPktMkj2DjiKDyEGEr20IWown9KgXq9QJRSmLJ1EjJRZ7WaUOBhL8W5xqd0ZUJY0lM09T26YEYRGFBBXdZyCulElnJX8kIlE0zxLJRemrN5A7MhWnUuewbecGFaJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-UrCb4r2EO0-qApy7l-N_9A-1; Wed,
 03 Apr 2024 10:21:47 -0400
X-MC-Unique: UrCb4r2EO0-qApy7l-N_9A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A2B8380622F;
	Wed,  3 Apr 2024 14:21:47 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98BF6492BCA;
	Wed,  3 Apr 2024 14:21:45 +0000 (UTC)
Date: Wed, 3 Apr 2024 16:21:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com,
	Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
Message-ID: <Zg1l9L2BNoZWZDZG@hog>
References: <20240403113853.3877116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240403113853.3877116-1-edumazet@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-03, 11:38:53 +0000, Eric Dumazet wrote:
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
> Add skb_vlan_inet_prepare() to perform a complete validation and pull.
> If no IPv4/IPv6 header is found, it returns 0.

And then geneve_xmit_skb/geneve6_xmit_skb drops the packet, which
breaks ARP over a geneve tunnel, and other valid things like macsec.

> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 5cd64bb2104df389250fb3c518ba00a3826c53f7..41537d5dce52412e15d7871ec=
604546582b10098 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -361,6 +361,37 @@ static inline bool pskb_inet_may_pull(struct sk_buff=
 *skb)
>  =09return pskb_network_may_pull(skb, nhlen);
>  }
> =20
> +/* Strict version of pskb_inet_may_pull().
> + * Once vlan headers are skipped, only accept
> + * ETH_P_IPV6 and ETH_P_IP.
> + */
> +static inline __be16 skb_vlan_inet_prepare(struct sk_buff *skb)
> +{
> +=09int nhlen, maclen;
> +=09__be16 type;

Should that be:

    type =3D skb->protocol

?

Otherwise it's used uninitialized here:

> +
> +=09type =3D __vlan_get_protocol(skb, type, &maclen);

--=20
Sabrina


