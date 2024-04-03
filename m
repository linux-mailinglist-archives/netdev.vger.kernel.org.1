Return-Path: <netdev+bounces-84559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43309897512
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E154128D6A9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A97F14F114;
	Wed,  3 Apr 2024 16:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A21947E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161284; cv=none; b=aQNJIHyKQbkwbLXA3RpbOdO/nnNHErY8FV0PK7rlSnv4thH8e9wQLiEK0aigyQ33phx57lYJOLjc939bsfVy9/TPAnsQXk61i8UGfhT7TqR6iiTXw4jB2bcsoj99x/zFmh28j3wjgMcBvq/nqFPpLT0ATwmuax4+XL46GxjM2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161284; c=relaxed/simple;
	bh=TYy+T1x6y3Wb4pK29y2I8wFKAgeg0HxECAQiZGdqZ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rlb1zJEf41bJwkiR6EqvtN26F6/GEGjeLsuW+8CHvOgsxAQqmP8qUZK6lKASlQQbRi66B7IsvF3tIu4DvSumE7yJBTRQN4gBBQgUJfCwGfNxUV5qYxbEn1GjaV4L8RLkn5xed/9bVWT1iXzneEgaChP/dlf+/H6dS/2cNK4lRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-dc50YU_LMxG1tmXMBHUYuA-1; Wed, 03 Apr 2024 12:21:17 -0400
X-MC-Unique: dc50YU_LMxG1tmXMBHUYuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD68885A5BB;
	Wed,  3 Apr 2024 16:21:16 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 977D28173;
	Wed,  3 Apr 2024 16:21:15 +0000 (UTC)
Date: Wed, 3 Apr 2024 18:21:10 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com,
	Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH v2 net] geneve: fix header validation in
 geneve[6]_xmit_skb
Message-ID: <Zg2B9iFLlADuzlBs@hog>
References: <20240403153017.426490-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240403153017.426490-1-edumazet@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-03, 15:30:17 +0000, Eric Dumazet wrote:
> +static inline bool skb_vlan_inet_prepare(struct sk_buff *skb)
> +{
> +=09int nhlen, maclen;
> +=09__be16 type;
> +
> +=09/* Essentially this is skb_protocol(skb, true)
> +=09 * And we get MAC len.
> +=09 */
> +=09type =3D __vlan_get_protocol(skb, skb->protocol, &maclen);
> +
> +=09switch (type) {
> +#if IS_ENABLED(CONFIG_IPV6)
> +=09case htons(ETH_P_IPV6):
> +=09=09nhlen =3D sizeof(struct ipv6hdr);
> +=09=09break;
> +#endif
> +=09case htons(ETH_P_IP):
> +=09=09nhlen =3D sizeof(struct iphdr);
> +=09=09break;
> +
> +=09default:
> +=09=09nhlen =3D 0;
> +=09}
> +=09/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
> +=09 * a base network header in skb->head.
> +=09 */
> +=09if (pskb_may_pull(skb, maclen + nhlen))

Missing ! in the condition.

Otherwise looks ok to me.


> +=09=09return false;
> +
> +=09skb_set_network_header(skb, maclen);
> +=09return true;
> +}

--=20
Sabrina


