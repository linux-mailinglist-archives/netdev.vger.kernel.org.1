Return-Path: <netdev+bounces-90837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7798B062A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF352858AC
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95928158D79;
	Wed, 24 Apr 2024 09:38:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53025158A39
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951501; cv=none; b=hZNtR68vuSnbixX21FCKdNog5KUZIfcOX90ss4ocFLeBCmbzoQ39sy5+MCL7TBEWryCCoF7nFm2p7tr+xd5GXNBeSxkemcADJZHwD5zSoIME5CLc61L2S0HN7c1eZrliDNl14kcHyILt2a/ricvV2+rw70idCty0dU+y/PQs3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951501; c=relaxed/simple;
	bh=P8ldp0KdTR/3/C0aQaZ3OMNmoWsnxtTBgeZjDpVAxA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UTCEz5nnBGX5S3pgwcSoAHLFqWtBngAJr8inRmiRfHjlCrgpJJvKdDUZppZxE/TZix5CNi4aJHRPCAwLnLvC3UQSUPV0Mqr2sN/GeQzp/el2wbyLj89i2S5P8ma/tAqmA9gLD5O4hboCKScoYUewp+2U0b9lNkx6nH3GcW5eJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-RXs0JHMCMv-ioyFKDv1Opg-1; Wed, 24 Apr 2024 05:38:12 -0400
X-MC-Unique: RXs0JHMCMv-ioyFKDv1Opg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68B6A830E85;
	Wed, 24 Apr 2024 09:38:11 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC7511C0654B;
	Wed, 24 Apr 2024 09:38:09 +0000 (UTC)
Date: Wed, 24 Apr 2024 11:38:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v12 1/4] xfrm: Add Direction to the SA in or
 out
Message-ID: <ZijTAN_ns1gRU9hz@hog>
References: <cover.1713874887.git.antony.antony@secunet.com>
 <91580d32b47bc78d0e09fccab936effc23ec8155.1713874887.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <91580d32b47bc78d0e09fccab936effc23ec8155.1713874887.git.antony.antony@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-23, 14:49:17 +0200, Antony Antony wrote:
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 0c306473a79d..c8c5fc47c431 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1292,6 +1292,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const =
xfrm_address_t *saddr,
>  =09=09if (km_query(x, tmpl, pol) =3D=3D 0) {
>  =09=09=09spin_lock_bh(&net->xfrm.xfrm_state_lock);
>  =09=09=09x->km.state =3D XFRM_STATE_ACQ;
> +=09=09=09x->dir =3D XFRM_SA_DIR_OUT;

Would that make updates fail if userspace isn't setting SA_DIR
afterwards?


> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 810b520493f3..d34ac467a219 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
[...]
> @@ -176,6 +200,7 @@ static int verify_newsa_info(struct xfrm_usersa_info =
*p,
>  =09=09=09     struct netlink_ext_ack *extack)
>  {
>  =09int err;
> +=09u8 sa_dir =3D attrs[XFRMA_SA_DIR] ?  nla_get_u8(attrs[XFRMA_SA_DIR]) =
: 0;

nit: extra ' ' after '?', only one is needed.


> @@ -358,6 +383,64 @@ static int verify_newsa_info(struct xfrm_usersa_info=
 *p,
>  =09=09=09err =3D -EINVAL;
>  =09=09=09goto out;
>  =09=09}
> +
> +=09=09if (sa_dir =3D=3D XFRM_SA_DIR_OUT) {
> +=09=09=09NL_SET_ERR_MSG(extack,
> +=09=09=09=09       "MTIMER_THRESH attribute should not be set on output =
SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +=09}
> +
> +=09if (sa_dir =3D=3D XFRM_SA_DIR_OUT) {
> +=09=09if (p->flags & XFRM_STATE_DECAP_DSCP) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Flag NDECAP_DSCP should not be set for =
output SA");

That typo in the error string is still here (extra N in flag name).

--=20
Sabrina


