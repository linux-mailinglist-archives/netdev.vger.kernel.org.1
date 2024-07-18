Return-Path: <netdev+bounces-112043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DC1934B79
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636A11F242ED
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63681720;
	Thu, 18 Jul 2024 10:07:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9303A267
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721297274; cv=none; b=YZOR+4rEz0DTk3hmsvChf5jIFomaEJ+2ThrSxrixp9ZXN0KvaIhiCrcKClIiA7oeGIBvbk+eM8n99xKIobjwH80t+susDdxekixWvT8+InPlxqfPhDdKuaMvQ+nUpSZnztDMb5CpfJU7ns6qBA0Dsrhj8K0bx7XDBVOZYx9Prrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721297274; c=relaxed/simple;
	bh=JKA4iVKWkmwwVCJBbE0hAZq8H1zlgOALFjbRH7uWOWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n2vG4TZRdBdT/ko/vIwVHPAUKyJVKIyvbvomnS413ZB3PL/ifq+aDdZTL+t2//XBHpPbL4TgvEiTjli0hWb0towdvaRJKxLIlz2yXKVbiAqzBNwYH0zntDbQ34M2agEpiX2g8Vxl/ejI9jDeIZ57pbVaaERBtLDjRUOTMbCNSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-3dGsBHUnNFCTI_2XH6YiQQ-1; Thu,
 18 Jul 2024 06:07:46 -0400
X-MC-Unique: 3dGsBHUnNFCTI_2XH6YiQQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 552E919560B1;
	Thu, 18 Jul 2024 10:07:45 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DECE519560AA;
	Thu, 18 Jul 2024 10:07:41 +0000 (UTC)
Date: Thu, 18 Jul 2024 12:07:39 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 10/25] ovpn: implement basic TX path (UDP)
Message-ID: <ZpjpaxKtiYG0AXFa@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-11-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-11-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:28 +0200, Antonio Quartulli wrote:
> +static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb=
)
> +{
> +=09ovpn_skb_cb(skb)->peer =3D peer;
> +
> +=09/* take a reference to the peer because the crypto code may run async=
.
> +=09 * ovpn_encrypt_post() will release it upon completion
> +=09 */
> +=09DEBUG_NET_WARN_ON_ONCE(!ovpn_peer_hold(peer));

Shouldn't we abort if this fails? This should not really happen, but
if it did, we would proceed (possibly with async crypto) without a ref
on the peer.

> +=09ovpn_encrypt_post(skb, 0);
> +=09return true;
> +}
> +

[...]
> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
> index aa259be66441..95568671d5ae 100644
> --- a/drivers/net/ovpn/io.h
> +++ b/drivers/net/ovpn/io.h
> @@ -12,4 +12,6 @@
> =20
>  netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
> =20
> +void ovpn_encrypt_work(struct work_struct *work);

leftover from the old implementation I think?

--=20
Sabrina


