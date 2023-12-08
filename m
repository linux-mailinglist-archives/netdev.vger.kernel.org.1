Return-Path: <netdev+bounces-55155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5C8099F0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5BA282011
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8041851;
	Fri,  8 Dec 2023 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPP0Fvq7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98F1FB3
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402E2C433C7;
	Fri,  8 Dec 2023 02:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702004127;
	bh=1TUJ/RVMSBdxOLWXgQk7xpEnkmJiB7OSM2v4W1eay0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPP0Fvq7IJJM/kSO3uKYCoMuJGi4I4xzYGjsnbmZ03Qrfv71tKbG7M9ijTTS8Ts31
	 M23SHJRGaV29csyyspstNdyr68caxTlF+BhfJwnxXqj3mzEi/VZHgUSEqNGz2jbFG4
	 5hdrN0Ny2kIDJUdJ2PBdCMIg2ix+khZSnfBLFWnjZy/yiVRwypIl7vXLyHym9LYTCI
	 nDk+/9ohSRt9Q4V2eiXH0Tk5l8nPdFKPoGwYgxbe3IJakrNL4rmZs5yKpvXooB98Sc
	 44ahFq1yXz+NBShmm5PVCvXKm32bLMX3Up75IqMusMgY+0dErNW7+Nfziut1RrePtP
	 pwC/ucl8q+ikg==
Date: Thu, 7 Dec 2023 18:55:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v5 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <20231207185526.5e59ab53@kernel.org>
In-Reply-To: <20231206182120.957225-6-jiri@resnulli.us>
References: <20231206182120.957225-1-jiri@resnulli.us>
	<20231206182120.957225-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  6 Dec 2023 19:21:16 +0100 Jiri Pirko wrote:
> diff --git a/include/net/genetlink.h b/include/net/genetlink.h
> index e18a4c0d69ee..dbf11464e96a 100644
> --- a/include/net/genetlink.h
> +++ b/include/net/genetlink.h
> @@ -87,6 +87,9 @@ struct genl_family {
>  	int			id;
>  	/* starting number of multicast group IDs in this family */
>  	unsigned int		mcgrp_offset;
> +	size_t			sock_priv_size;
> +	void			(*sock_priv_init)(void *priv);
> +	void			(*sock_priv_destroy)(void *priv);

=F0=9F=91=8D=EF=B8=8F

but I think it should be above the private fields (and have kdoc)
The families are expected to make use the new fields, and are not
supposed to touch anything private.

> --- a/net/netlink/af_netlink.h
> +++ b/net/netlink/af_netlink.h
> @@ -60,6 +60,21 @@ static inline struct netlink_sock *nlk_sk(struct sock =
*sk)
> =20
>  #define nlk_test_bit(nr, sk) test_bit(NETLINK_F_##nr, &nlk_sk(sk)->flags)
> =20
> +struct genl_sock {
> +	struct netlink_sock nlk_sk;
> +	struct xarray *family_privs;
> +};
> +
> +static inline struct genl_sock *genl_sk(struct sock *sk)
> +{
> +	return container_of(nlk_sk(sk), struct genl_sock, nlk_sk);
> +}
> +
> +/* Size of netlink sock is size of the biggest user with priv,
> + * which is currently just Generic Netlink.
> + */
> +#define NETLINK_SOCK_SIZE sizeof(struct genl_sock)

Would feel a little cleaner to me to add

#define NETLINK_SOCK_PROTO_SIZE		8

add that to the size, build time check that struct genl_sock's
size is <=3D than sizeof(struct netlink_sock) + NETLINK_SOCK_PROTO_SIZE

This way we don't have to fumble the layering by putting genl stuff
in af_netlink.h

> +struct genl_sk_priv {
> +	void (*destructor)(void *priv);
> +	long priv[];
> +};
> +
> +static struct genl_sk_priv *genl_sk_priv_alloc(struct genl_family *famil=
y)
> +{
> +	struct genl_sk_priv *priv;
> +
> +	priv =3D kzalloc(size_add(sizeof(*priv), family->sock_priv_size),
> +		       GFP_KERNEL);
> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +	priv->destructor =3D family->sock_priv_destroy;

family->sock_priv_destroy may be in module memory.
I think you need to wipe them when family goes :(

> +	if (family->sock_priv_init)
> +		family->sock_priv_init(priv->priv);
> +	return priv;
> +}

> +static struct xarray *genl_family_privs_get(struct genl_sock *gsk)
> +{
> +	struct xarray *family_privs;
> +
> +again:
> +	family_privs =3D READ_ONCE(gsk->family_privs);
> +	if (family_privs)
> +		return family_privs;
> +
> +	family_privs =3D kzalloc(sizeof(*family_privs), GFP_KERNEL);
> +	if (!family_privs)
> +		return ERR_PTR(-ENOMEM);
> +	xa_init_flags(family_privs, XA_FLAGS_ALLOC);
> +
> +	/* Use genl lock to protect family_privs to be
> +	 * initialized in parallel by different CPU.
> +	 */
> +	genl_lock();
> +	if (unlikely(gsk->family_privs)) {
> +		xa_destroy(family_privs);
> +		kfree(family_privs);
> +		genl_unlock();

nit: unlock can be moved up

> +		goto again;

why not return READ_ONCE(gsk->family_privs); ?
there's no need to loop

One could also be tempted to:

lock()
if (likely(!gsk->family_privs)) {
	WRITE
} else {
	destory()
	free()
	family_privs =3D READ
}
unlock()

but it could be argued success path should be flat

> +	}
> +	WRITE_ONCE(gsk->family_privs, family_privs);
> +	genl_unlock();
> +	return family_privs;
> +}

