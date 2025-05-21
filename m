Return-Path: <netdev+bounces-192125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AEEABE985
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5797C4E31C7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3522AE7B;
	Wed, 21 May 2025 02:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CBGtQuQX"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1F339A8
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793143; cv=none; b=PCy0WDowPZH5SaB8YtJWl8kdEJFg7PXqQg9ohBEMuo2Q/tSaPA/z7jN6cUjAwDDejoXUPq6Xvdb1xEUrqesFAilrtNq61Z2l2xi2QCz2u0c42OI/W0Lq5l8FcNQWk4OLq/aC0bGLtfo7SD7N1GifXUhJrUqdnIcJg4DZtzT+5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793143; c=relaxed/simple;
	bh=xx6MxA8zhMdH9d8be9mKpkQROtxa7S64T2NQuH6Ml1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxI6Fjj1iAnkKzFKufiDznD1EDNh9NNFVkCg7ZS4qHKhPIYwbKSSjwkFMO9fsZ59hsWkpj+x+taPPCWJGzqhivrpuYopHWdWDqtywGlG5SZjAU4zIeK2IG6Ij10SY5xDe5e4LS+xD6RMsw71ovCsDyIUQFL/46lsvxQH1GAuDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CBGtQuQX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1747793137;
	bh=xx6MxA8zhMdH9d8be9mKpkQROtxa7S64T2NQuH6Ml1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CBGtQuQXqUBYVlw61nXchVHWO2fiiY+d8GtnoO/uK5kM8MptCx55+X6YTjfIdEPbw
	 WXXufTtXCyDycAfHiNw1zlvIplQYU/Tt9lFg9ZwbctPVD+++uQX7ZTOSoeGSKVlUqv
	 e86BwdJPGv+LLjmZgKYHQSnQ1c+aTFSW+zJHTL25JIV40UgQzjP/vwMjwriis8Ve3M
	 0J1+FRP47wdSYb4eNXtMtWZme7Ds040LmznDkG/69B+H9fdZpRgSDbJfP8NGSntk+s
	 rrgaj5cQRfdxAzKJbzPHhJq/A2v3MaoaaUTmrdcdjil4jjUR6bdusInVwsK3EqJHOr
	 cHsy2+cxdAg9Q==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1EB48640BF;
	Wed, 21 May 2025 10:05:37 +0800 (AWST)
Message-ID: <c41a3d3d22c078eab43f8ccd4eeef25d668fa9f9.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: mctp: use nlmsg_payload() for netlink
 message data extraction
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Simon Horman <horms@kernel.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Date: Wed, 21 May 2025 10:05:36 +0800
In-Reply-To: <20250520152315.GB365796@horms.kernel.org>
References: 
	<20250520-mctp-nlmsg-payload-v1-1-93dd0fed0548@codeconstruct.com.au>
	 <20250520152315.GB365796@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Horms,

Thanks for the review!

> > --- a/net/mctp/neigh.c
> > +++ b/net/mctp/neigh.c
> > @@ -250,7 +250,10 @@ static int mctp_rtm_getneigh(struct sk_buff *skb, =
struct netlink_callback *cb)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0int idx;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} *cbctx =3D (void *)cb=
->ctx;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndmsg =3D nlmsg_data(cb->nlh=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndmsg =3D nlmsg_payload(cb->=
nlh, sizeof(*ndmsg));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ndmsg)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > +
>=20
> But is this one a bug fix?

At the moment, we cannot hit the case where the nlh does not contain a
full ndmsg, as the core handler (net/core/neighbour.c, neigh_get()) has
already validated the size (through neigh_valid_req_get()), and would
have failed the get before the MCTP hander is called.

However, relying on that is a bit fragile, hence applying the
nlmsg_payload replacement here.

I'm happy to split it out if that makes more sense though; in which case
this change would be initially implemented as check on ->nlmsg_len (in
order to be backportable to stable), and then a subsequent rework to use
nlmsg_payload. Let me know what would work best.

Cheers,


Jeremy

