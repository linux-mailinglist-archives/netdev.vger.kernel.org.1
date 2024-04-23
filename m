Return-Path: <netdev+bounces-90572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C28AE8AB
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6111C222B7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827CC13774E;
	Tue, 23 Apr 2024 13:51:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B41369AC
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880305; cv=none; b=KJZGXkdQSA/ZcUOkapJKaFDuDKY91vhBd36Vn5dEqPWZEME5tDayBYGRzVuvPJU7uP5VtFBiUQXw0lnR2PP3Z3Em+Fuz0TE+Vu1NvRt3ZHfqfe23lmyjLdFkQaci05CWtWUeznnJxWTAgdLSUej/C5i9VbUItThyM2sq7dpAKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880305; c=relaxed/simple;
	bh=HqWlP2B43ITaNAmdX2M76lS5NeYbBVl1sCNqC1NeAuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FUbUDWwYKK4Oc6QwmAtBnbl/rnev4GdsJNBblTuHwtWvwx57F/iv125g1k3cfn7wW0PlChb2fa5PPmw43pRVv7soJV6PF5wknM1JL2M/bLB+PwpjWs1CwbYGiqYUqsOMuvOHQZNv1wppRZGMQUWoGOcOWD+3MNlL88MVmiKGgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-_0ByQh2pOYmmNHXQusQQfA-1; Tue,
 23 Apr 2024 09:51:32 -0400
X-MC-Unique: _0ByQh2pOYmmNHXQusQQfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EE2D3C3D0C5;
	Tue, 23 Apr 2024 13:51:31 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B9940C6CC0;
	Tue, 23 Apr 2024 13:51:29 +0000 (UTC)
Date: Tue, 23 Apr 2024 15:51:28 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 2/4] ethernet: Add helper for assigning packet
 type when dest address does not match device address
Message-ID: <Zie84KZ--UBnBydc@hog>
References: <20240419213033.400467-1-rrameshbabu@nvidia.com>
 <20240419213033.400467-3-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240419213033.400467-3-rrameshbabu@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-19, 14:30:17 -0700, Rahul Rameshbabu wrote:
> Enable reuse of logic in eth_type_trans for determining packet type.
>=20
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> ---
>  include/linux/etherdevice.h | 24 ++++++++++++++++++++++++
>  net/ethernet/eth.c          | 12 +-----------
>  2 files changed, 25 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index 224645f17c33..f5868ac69dec 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -607,6 +607,30 @@ static inline void eth_hw_addr_gen(struct net_device=
 *dev, const u8 *base_addr,
>  =09eth_hw_addr_set(dev, addr);
>  }
> =20
> +/**
> + * eth_skb_pkt_type - Assign packet type if destination address does not=
 match
> + * @skb: Assigned a packet type if address does not match @dev address
> + * @dev: Network device used to compare packet address against
> + *
> + * If the destination MAC address of the packet does not match the netwo=
rk
> + * device address, assign an appropriate packet type.
> + */
> +static inline void eth_skb_pkt_type(struct sk_buff *skb, struct net_devi=
ce *dev)

Could you make dev const? Otherwise the series looks good to me.

Thanks.

--=20
Sabrina


