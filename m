Return-Path: <netdev+bounces-87919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6D8A4EE9
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 151B2B23242
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7AE6BFC2;
	Mon, 15 Apr 2024 12:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2A6BFB8
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183733; cv=none; b=MPdJTlzB2lvFNddQZOSR3TWpl+/FgH9V1x9wKnM1Jsn1RKfCldAbkj4c1iaAgnvNvqMYn+wSI/xmn01t6RZs1PXkGAa4/69nT0vv3faEBLqzJ6SdapqE7stO7a+5D6uXRi2uEM/YH9EY3uB661gwivzaZnfixXLWANe9JThmflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183733; c=relaxed/simple;
	bh=l6JgDNMOCGq4wxme6HFv1jpyE76+I27nK76NZeONtgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IrCHAFgfJkovmmFex9COZYVVrVHlVHAm11/ZaE3HmCSJFveVoKm+NkBpWH6rCdeaqrAmQPBABjot4ll/uCK4NnjupW0JaA5WQAD7G+L+Ie5zBwQUxqrqwyb8lCZrLMBQDI83Ptckilkbd9/B1OA9JG/smsTT4hGm6fD0AUiOWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-xHmWn5ncOZeS-lI4XRuv_A-1; Mon, 15 Apr 2024 08:21:58 -0400
X-MC-Unique: xHmWn5ncOZeS-lI4XRuv_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C626881E61;
	Mon, 15 Apr 2024 12:21:57 +0000 (UTC)
Received: from hog (unknown [10.39.192.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AACEA492BC8;
	Mon, 15 Apr 2024 12:21:55 +0000 (UTC)
Date: Mon, 15 Apr 2024 14:21:50 +0200
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
Subject: Re: [PATCH ipsec-next v10 1/3] xfrm: Add Direction to the SA in or
 out
Message-ID: <Zh0b3gfnr99ddaYM@hog>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-11, 11:40:59 +0200, Antony Antony wrote:
> diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> index 655fe4ff8621..007dee03b1bc 100644
> --- a/net/xfrm/xfrm_compat.c
> +++ b/net/xfrm/xfrm_compat.c
> @@ -98,6 +98,7 @@ static const int compat_msg_min[XFRM_NR_MSGTYPES] =3D {
>  };
>=20
>  static const struct nla_policy compat_policy[XFRMA_MAX+1] =3D {
> +=09[XFRMA_UNSPEC]          =3D { .strict_start_type =3D XFRMA_SA_DIR },
>  =09[XFRMA_SA]=09=09=3D { .len =3D XMSGSIZE(compat_xfrm_usersa_info)},
>  =09[XFRMA_POLICY]=09=09=3D { .len =3D XMSGSIZE(compat_xfrm_userpolicy_in=
fo)},
>  =09[XFRMA_LASTUSED]=09=3D { .type =3D NLA_U64},
> @@ -129,6 +130,7 @@ static const struct nla_policy compat_policy[XFRMA_MA=
X+1] =3D {
>  =09[XFRMA_SET_MARK_MASK]=09=3D { .type =3D NLA_U32 },
>  =09[XFRMA_IF_ID]=09=09=3D { .type =3D NLA_U32 },
>  =09[XFRMA_MTIMER_THRESH]=09=3D { .type =3D NLA_U32 },
> +=09[XFRMA_SA_DIR]          =3D { .type =3D NLA_U8}

nit: <...> },

(space before } and , afterwards)

See below for a comment on the policy itself.


> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 6346690d5c69..2455a76a1cff 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_=
state *x,
>  =09=09return -EINVAL;
>  =09}
>=20
> +=09if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir =3D=3D XFRM_SA_DIR_O=
UT) ||
> +=09    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir =3D=3D XFRM_SA_DI=
R_IN)) {
> +=09=09NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> +=09=09return -EINVAL;
> +=09}

It would be nice to set x->dir to match the flag, but then I guess the
validation in xfrm_state_update would fail if userspaces tries an
update without providing XFRMA_SA_DIR. (or not because we already went
through this code by the time we get to xfrm_state_update?)


> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 810b520493f3..df141edbe8d1 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
[...]
> @@ -779,6 +793,77 @@ static struct xfrm_state *xfrm_state_construct(struc=
t net *net,
>  =09return NULL;
>  }
>=20
> +static int verify_sa_dir(const struct xfrm_state *x, struct netlink_ext_=
ack *extack)
> +{
> +=09if (x->dir =3D=3D XFRM_SA_DIR_OUT)  {
> +=09=09if (x->props.replay_window > 0) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Replay window should not be set for OUT=
 SA");
> +=09=09=09return -EINVAL;
> +=09=09}
> +
> +=09=09if (x->replay.seq || x->replay.bitmap) {
> +=09=09=09NL_SET_ERR_MSG(extack,
> +=09=09=09=09       "Replay seq, or bitmap should not be set for OUT SA w=
ith ESN");

I thought x->replay was for non-ESN, since we have x->replay_esn.

> +=09=09=09return -EINVAL;
> +=09=09}
> +
> +=09=09if (x->replay_esn) {
> +=09=09=09if (x->replay_esn->replay_window > 1) {
> +=09=09=09=09NL_SET_ERR_MSG(extack,
> +=09=09=09=09=09       "Replay window should be 1 for OUT SA with ESN");

I don't think that we should introduce something we know doesn't make
sense (replay window =3D 1 on output). It will be API and we won't be
able to fix it up later. We get a chance to make things nice and
reasonable with this new attribute, let's not waste it.

As I said, AFAICT replay_esn->replay_window isn't used on output, so
unless I missed something, it should just be a matter of changing the
validation. The additional checks in this version should guarantee we
don't have dir=3D=3DOUT SAs in the packet input path, so this should work.

> +=09=09=09=09return -EINVAL;
> +=09=09=09}
> +
> +=09=09=09if (x->replay_esn->seq || x->replay_esn->seq_hi || x->replay_es=
n->bmp_len) {
> +=09=09=09=09NL_SET_ERR_MSG(extack,
> +=09=09=09=09=09       "Replay seq, seq_hi, bmp_len should not be set for=
 OUT SA with ESN");
> +=09=09=09=09return -EINVAL;
> +=09=09=09}
> +=09=09}
> +
> +=09=09if (x->props.flags & XFRM_STATE_DECAP_DSCP) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Flag NDECAP_DSCP should not be set for =
OUT SA");

                                                     ^ extra N?

> +=09=09=09return -EINVAL;
> +=09=09}
> +

[...]
>  static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
>  =09=09       struct nlattr **attrs, struct netlink_ext_ack *extack)
>  {
> @@ -796,6 +881,16 @@ static int xfrm_add_sa(struct sk_buff *skb, struct n=
lmsghdr *nlh,
>  =09if (!x)
>  =09=09return err;
>=20
> +=09if (x->dir) {
> +=09=09err =3D verify_sa_dir(x, extack);
> +=09=09if (err) {
> +=09=09=09x->km.state =3D XFRM_STATE_DEAD;
> +=09=09=09xfrm_dev_state_delete(x);
> +=09=09=09xfrm_state_put(x);
> +=09=09=09return err;

That's not very nice. We're creating a state and just throwing it away
immediately. How hard would it be to validate all that directly from
verify_newsa_info instead?


[...]
> @@ -3018,6 +3137,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
>  #undef XMSGSIZE
>=20
>  const struct nla_policy xfrma_policy[XFRMA_MAX+1] =3D {
> +=09[XFRMA_UNSPEC]=09=09=3D { .strict_start_type =3D XFRMA_SA_DIR },
>  =09[XFRMA_SA]=09=09=3D { .len =3D sizeof(struct xfrm_usersa_info)},
>  =09[XFRMA_POLICY]=09=09=3D { .len =3D sizeof(struct xfrm_userpolicy_info=
)},
>  =09[XFRMA_LASTUSED]=09=3D { .type =3D NLA_U64},
> @@ -3049,6 +3169,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] =
=3D {
>  =09[XFRMA_SET_MARK_MASK]=09=3D { .type =3D NLA_U32 },
>  =09[XFRMA_IF_ID]=09=09=3D { .type =3D NLA_U32 },
>  =09[XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> +=09[XFRMA_SA_DIR]          =3D { .type =3D NLA_U8 }

With

    .type =3D NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT) },

you wouldn't need to validate the attribute's values in
verify_newsa_info and xfrm_alloc_userspi. And same for the xfrm_compat
version of this.

(also a nit on the formatting: a "," after the } would be nice, so
that the next addition doesn't need to touch this line)


And as we discussed, I'd really like XFRMA_SA_DIR to be rejected in
commands that don't use its value.


Thanks.

--=20
Sabrina


