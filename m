Return-Path: <netdev+bounces-109946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A9B92A6EB
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED92F1F2189F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89523143C47;
	Mon,  8 Jul 2024 16:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4CA78C73
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455083; cv=none; b=DFaN6x7ktrRkNoyOhpl9jiG1F2hkDGZCXBT2fplsxgORRY3A+KjHo0wiRJ+kWvzSO+/fNvT5BLPvdXGyoUyPom/GcFACyKVaFzMeDg0vDHpGbaLWJkA/RaYe5WFxo3oVu2vERjb4HH9+qOr0zTYgUJI8/3cJObr6MMuCNmYZgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455083; c=relaxed/simple;
	bh=d5Z7700suhYnI/kekhkKFt74iyGNElW08zjcjIY7kvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RszGK046iHi/YnCqdGVT8H7a2FGh/duyWx1qN6c61LO6KvYL2DYo0DvPDAxY8rnd9MH/zRbYGA3sx7l5rmqexz0lN2tTmn5Xe3LR59Ih7/7/a38zLEy1lOaWIguJFxWNSdxzBQv/FIzz6enXH3yle80ac3oJ9RV0N7E2x/L7YLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-n82nZwhTM7yxbeUs9vVJKQ-1; Mon,
 08 Jul 2024 12:11:10 -0400
X-MC-Unique: n82nZwhTM7yxbeUs9vVJKQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C21F19560AE;
	Mon,  8 Jul 2024 16:11:08 +0000 (UTC)
Received: from hog (unknown [10.39.192.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F5EA3000185;
	Mon,  8 Jul 2024 16:11:04 +0000 (UTC)
Date: Mon, 8 Jul 2024 18:11:02 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 11/25] ovpn: implement basic RX path (UDP)
Message-ID: <ZowPltmxMLBaJa3K@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-12-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-12-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:29 +0200, Antonio Quartulli wrote:
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *sk=
b)
> +{
[...]
> +=09/* cause packet to be "received" by the interface */
> +=09if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
> +=09=09=09=09     skb) =3D=3D NET_RX_SUCCESS))
> +=09=09/* update RX stats with the size of decrypted packet */
> +=09=09dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
> +=09else
> +=09=09dev_core_stats_rx_dropped_inc(peer->ovpn->dev);

Not needed AFAICT, gro_cells_receive already does
dev_core_stats_rx_dropped_inc(skb->dev) when it drops the packet.

> +}
> +
> +static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
> +{
> +=09struct ovpn_peer *peer =3D ovpn_skb_cb(skb)->peer;
> +
> +=09if (unlikely(ret < 0))
> +=09=09goto drop;
> +
> +=09ovpn_netdev_write(peer, skb);
> +=09/* skb is passed to upper layer - don't free it */
> +=09skb =3D NULL;
> +drop:

I really find this "common" return code confusing. The only thing the
two cases have in common is dropping the peer reference.

> +=09if (unlikely(skb))
> +=09=09dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +=09kfree_skb(skb);
> +=09ovpn_peer_put(peer);
> +}

--=20
Sabrina


