Return-Path: <netdev+bounces-38200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E7B7B9C02
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 11:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BDE8F281B53
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ABA101CE;
	Thu,  5 Oct 2023 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsHEmEf1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E97F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC60C116B7;
	Thu,  5 Oct 2023 09:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696496636;
	bh=YW6AMXhottZLumoHEFW7rvYANSuUdiOjTDc6Qo0lWAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsHEmEf1MGy/Jj7Imi0CDQiWuMUVS6WhBd8F+dN6SbaIM2InUesrbdUIBzVDaVZ5E
	 vX1DXxcbtAGT2JsTUKSJVYsqWcKzSMf/D8FQZJztjkf/7CtjO62syY68dZpjXjemMB
	 eqMH7mGsFxYzwtnpEoaVqUziagOYtELKouDwJPLF69tnixkTb37wT1lWO7LO6J3IeG
	 5eCGOnZd/FOdSwjM7dVLZYRpL/Yu/J+aUOXaoxC6Py4NN6mzv8hdubxpWiqRgITiTt
	 XzrOXcasrA0Rl4OdzUzETr7u2u6hjD3c9kmcePuzJvEXgxE0xqYig/k6a8jWbZhRSx
	 LMrLZor4aETfg==
Date: Thu, 5 Oct 2023 11:03:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
	jlayton@kernel.org, neilb@suse.de, chuck.lever@oracle.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Message-ID: <ZR57+cIx6t/2lURA@lore-desk>
References: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
 <20231004100955.32417c33@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wwNqDGKJgf2QrUnW"
Content-Disposition: inline
In-Reply-To: <20231004100955.32417c33@kernel.org>


--wwNqDGKJgf2QrUnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 27 Sep 2023 00:13:15 +0200 Lorenzo Bianconi wrote:
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> > +{
> > +	u32 nthreads;
> > +	int ret;
> > +
> > +	if (!info->attrs[NFSD_A_CONTROL_PLANE_THREADS])
> > +		return -EINVAL;
>=20
> Consider using GENL_REQ_ATTR_CHECK(), it will auto-add nice error
> message to the reply on error.

ack, I will fix it.

>=20
> > +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_CONTROL_PLANE_THREADS]);
> > +
> > +	ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> > +	return ret =3D=3D nthreads ? 0 : ret;
> > +}
> > +
> > +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callba=
ck *cb,
> > +			    int cmd, int attr, u32 val)
>=20
> YNL will dutifully return a list for every dump. If you're only getting
> a single reply 'do' will be much better.

ack, I will fix it.

Regards,
Lorenzo

--wwNqDGKJgf2QrUnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZR57+QAKCRA6cBh0uS2t
rKI1AP9YnWau62lwbFjDZnsQcxH8VUlxuKPPjUzqvmgU3w9e7QD/Wy7QqL2w2EXT
J+3t8IEkfYq6GO9AVb+bMEolnsU/ZwY=
=3tsm
-----END PGP SIGNATURE-----

--wwNqDGKJgf2QrUnW--

