Return-Path: <netdev+bounces-173492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDA9A59315
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8E1188F302
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE05221729;
	Mon, 10 Mar 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j76WQi6x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFE221703
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607552; cv=none; b=UFf9NK29j7SD17NK+t0kKzbUT8An12I2oPh3HGTpmDNjKQrLlhSri2Gt+f2N5JwEq5G2Y72CWk0n5LddiXH7WHyRZsEw3M8ez4Vwl0ngU2Fj3CD+6HBohZ7hlG5sbT8WyiduaUHAoP56lPUbTMU7EhS8Ql8tfeXaBLse0qgpyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607552; c=relaxed/simple;
	bh=bDbbjIFBTMdLmSrKqHb5L8FN+CBPaGDUQD9P2jWhkM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF7Id6oIbjTGIzmSRrnOL+HdISHAenDPIFOQi13CTin26yOL6YgCmNJnd+ezLQJxVddbAlz4bAQcg0EIsDD2QoRPN6pkWapvtRwsV3XggsNlfkbuW900hZowC2XsY4YV7rdGXIYPVxomIKuieOv3X/9d+2ku7tz0uIbEdSPngKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j76WQi6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6293DC4CEED;
	Mon, 10 Mar 2025 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741607551;
	bh=bDbbjIFBTMdLmSrKqHb5L8FN+CBPaGDUQD9P2jWhkM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j76WQi6x+70j6HC/GkHeYahx+JAXsdZkJzEca02hYjhmO9FoLvV3xywTPb3sQWRbM
	 F9kGVR0sYiM0W6MZoF/GNqnlxwwIPVl+gDHRjHS9TIFotp390f5AdURk3wpqk0Em5Y
	 SC//6jtSgdZ/VCiYuMYvWj80DLtQgtbAd7SoXQGn06NAh7sStZPNHrFyHOFBBMfrqZ
	 Mu+oJ/PSF4j+qCsXqNXxHGxdY2QAD5xoBrCW4R+S8mJu0xk8shrxuKyQrAKblV5Lz3
	 z4D5EVTPoBSrgKjLnacpfQ19Mk30JQhfc8JS2WrSpHUigPNvHxB1Xt3F8a8oAiIrlG
	 BVwpsXYDDz0cA==
Date: Mon, 10 Mar 2025 13:52:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chiachang Wang <chiachangwang@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	stanleyjhu@google.com, yumike@google.com
Subject: Re: [PATCH ipsec-next v4 2/2] xfrm: Refactor migration setup during
 the cloning process
Message-ID: <20250310115226.GD7027@unreal>
References: <20250310091620.2706700-1-chiachangwang@google.com>
 <20250310091620.2706700-3-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250310091620.2706700-3-chiachangwang@google.com>

On Mon, Mar 10, 2025 at 09:16:20AM +0000, Chiachang Wang wrote:
> Previously, migration related setup, such as updating family,
> destination address, and source address, was performed after
> the clone was created in `xfrm_state_migrate`. This change
> moves this setup into the cloning function itself, improving
> code locality and reducing redundancy.
>=20
> The `xfrm_state_clone_and_setup` function now conditionally
> applies the migration parameters from struct xfrm_migrate
> if it is provided. This allows the function to be used both
> for simple cloning and for cloning with migration setup.
>=20
> Test: Tested with kernel test in the Android tree located
>       in https://android.googlesource.com/kernel/tests/
>       The xfrm_tunnel_test.py under the tests folder in
>       particular.
> Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> ---
>  net/xfrm/xfrm_state.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 9cd707362767..0365daedea32 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1958,8 +1958,9 @@ static inline int clone_security(struct xfrm_state =
*x, struct xfrm_sec_ctx *secu
>  	return 0;
>  }
>=20
> -static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
> -					   struct xfrm_encap_tmpl *encap)
> +static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *=
orig,
> +					   struct xfrm_encap_tmpl *encap,
> +					   struct xfrm_migrate *m)
>  {
>  	struct net *net =3D xs_net(orig);
>  	struct xfrm_state *x =3D xfrm_state_alloc(net);
> @@ -2058,6 +2059,12 @@ static struct xfrm_state *xfrm_state_clone(struct =
xfrm_state *orig,
>  			goto error;
>  	}
>=20
> +	if (m) {

Why do you need this "if (m)"? "m" should be valid at this stage.

Thanks

> +		x->props.family =3D m->new_family;
> +		memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
> +		memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
> +	}
> +
>  	return x;

