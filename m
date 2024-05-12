Return-Path: <netdev+bounces-95821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA88C389E
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 23:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2885128159C
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 21:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0294D5B0;
	Sun, 12 May 2024 21:35:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (unknown [170.10.129.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F325548EF
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715549743; cv=none; b=fGJxwSKv/3krk7Njzx3UzvQnouHQLvjDKqERq9ZrvMBaSwnY+4hezXxfDYFGzR1koTRnpCdqDlPYPDdNL45eUKip7gxnhX4D4VMxbsBHv1CgIcYmSVEG+YiC+VMlm3DfSQlEcufYggyFQE/NrjVinLVUOKxdclsdmk9XV92jsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715549743; c=relaxed/simple;
	bh=NKEyY2+yCOviPT+SWGh7kDMM81ohfCxWyOiIcNFRaRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YGUQjvu3vydtE9aT9XJFF3IkTw/W0UdQL5Ns1njYafP7nDGaWqYAi+nEo94ZNW/cOZJ3k0zGg/TSwQAaL4URgfXQOjH+ltWhH6Hh0k1xIsb/ryNUroOUfXxk3cExXsnIHIFLQtA5UdT7H2/Dbhd/SNExTSOK3APCOwP8XhuiJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=170.10.129.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-0sHqjJF0PWOLX-sMoFzzqg-1; Sun, 12 May 2024 17:35:37 -0400
X-MC-Unique: 0sHqjJF0PWOLX-sMoFzzqg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3E2A81227E;
	Sun, 12 May 2024 21:35:36 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 91A1740EF99;
	Sun, 12 May 2024 21:35:35 +0000 (UTC)
Date: Sun, 12 May 2024 23:35:34 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 09/24] ovpn: implement basic TX path (UDP)
Message-ID: <ZkE2JmBCj-yJ3xYK@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-10-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-10-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:22 +0200, Antonio Quartulli wrote:
> +/* send skb to connected peer, if any */
> +static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb=
,
> +=09=09=09   struct ovpn_peer *peer)
> +{
> +=09int ret;
> +
> +=09if (likely(!peer))
> +=09=09/* retrieve peer serving the destination IP of this packet */
> +=09=09peer =3D ovpn_peer_get_by_dst(ovpn, skb);
> +=09if (unlikely(!peer)) {
> +=09=09net_dbg_ratelimited("%s: no peer to send data to\n",
> +=09=09=09=09    ovpn->dev->name);
> +=09=09goto drop;
> +=09}
> +
> +=09ret =3D ptr_ring_produce_bh(&peer->tx_ring, skb);
> +=09if (unlikely(ret < 0)) {
> +=09=09net_err_ratelimited("%s: cannot queue packet to TX ring\n",
> +=09=09=09=09    peer->ovpn->dev->name);
> +=09=09goto drop;
> +=09}
> +
> +=09if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
> +=09=09ovpn_peer_put(peer);

I wanted to come back to this after going through the crypto patch,
because this felt like a strange construct when I first looked at this
patch.

Why are you using a workqueue here? Based on the kdoc for crypto_wq
("used to schedule crypto work that may sleep during TX/RX"), it's to
deal with async crypto.

If so, why not use the more standard way of dealing with async crypto
in contexts that cannot sleep, ie letting the crypto core call the
"done" callback asynchronously? You need to do all the proper refcount
handling, but IMO it's cleaner and simpler than this workqueue and
ptr_ring. You can see an example of that in macsec (macsec_encrypt_*
in drivers/net/macsec.c).

--=20
Sabrina


