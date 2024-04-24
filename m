Return-Path: <netdev+bounces-90813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F348B048E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEDB289836
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE581419AA;
	Wed, 24 Apr 2024 08:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A421D52B
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948075; cv=none; b=Z28pz4IzHaGjNlKkN5bW7ZYaF8joZDM2Zy/lVH0nexSttQ+rW3Zdj7H7z2Aa5BT/W5iT4539+fv5KmAfJrtL1/WjD8bl0QH8YtGZKPAWG4tnBlvHeU839NbILwWRAXOq+9XD/3fSb3udn7rjx14boJ9OFgXzlKZ8Mm02m8WQjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948075; c=relaxed/simple;
	bh=h5p3hofOyYqXQ91hEmRTT2xYN8HxTirAAUv7GSvnrs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g/lghU+mPPtCiRF3n+F3aEl2kGgUUqy2Rnvx4RR/hGa2U5M33YbU7hOW98v8ziJ7ZVtN21q7NfgigrJFqj1WMhJYtZSktL55J5oZOxoaczhYACbGi5FEV46vnMbG5nJXnb5I/jFRLqx2fDou9PLbmUY0ySXXeugXsQzPSNgZiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-pto2sBD9Nb2sDGPcNG3oiw-1; Wed, 24 Apr 2024 04:41:00 -0400
X-MC-Unique: pto2sBD9Nb2sDGPcNG3oiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41171830E85;
	Wed, 24 Apr 2024 08:41:00 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 04AD540BB24;
	Wed, 24 Apr 2024 08:40:57 +0000 (UTC)
Date: Wed, 24 Apr 2024 10:40:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v12 3/4] xfrm: Add dir validation to "in" data
 path lookup
Message-ID: <ZijFmMDST_ksUUnk@hog>
References: <cover.1713874887.git.antony.antony@secunet.com>
 <f7492e95b2a838f78032424a18c3509e0faacba5.1713874887.git.antony.antony@secunet.com>
 <8ac397dc-5498-493c-bcbc-926555ab60ab@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8ac397dc-5498-493c-bcbc-926555ab60ab@6wind.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-23, 17:27:37 +0200, Nicolas Dichtel wrote:
> Le 23/04/2024 =C3=A0 14:50, Antony Antony a =C3=A9crit=C2=A0:
> > Introduces validation for the x->dir attribute within the XFRM input
> > data lookup path. If the configured direction does not match the
> > expected direction, input, increment the XfrmInStateDirError counter
> > and drop the packet to ensure data integrity and correct flow handling.
> >=20
> > grep -vw 0 /proc/net/xfrm_stat
> > XfrmInStateDirError     =091
> >=20
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> > v11 -> 12
> >  - add documentation to xfrm_proc.rst
> >=20
> > v10->v11
> >  - rename error s/XfrmInDirError/XfrmInStateDirError/
> > ---
> >  Documentation/networking/xfrm_proc.rst |  3 +++
> >  include/uapi/linux/snmp.h              |  1 +
> >  net/ipv6/xfrm6_input.c                 |  7 +++++++
> >  net/xfrm/xfrm_input.c                  | 11 +++++++++++
> >  net/xfrm/xfrm_proc.c                   |  1 +
> >  5 files changed, 23 insertions(+)
> >=20
> > diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/net=
working/xfrm_proc.rst
> > index c237bef03fb6..b4f4d9552dea 100644
> > --- a/Documentation/networking/xfrm_proc.rst
> > +++ b/Documentation/networking/xfrm_proc.rst
> > @@ -73,6 +73,9 @@ XfrmAcquireError:
> >  XfrmFwdHdrError:
> >  =09Forward routing of a packet is not allowed
> >=20
> > +XfrmInStateDirError:
> > +        State direction input mismatched with lookup path direction
> It's a bit confusing because when this error occurs, the state direction =
is not
> 'input'.

Agree.

> This statistic is under 'Inbound errors', so may something like this is e=
nough:
> 'State direction is output.'

Maybe something like:

State direction mismatch (lookup found an output state on the input path, e=
xpected input or no direction)

It's a bit verbose, but I think those extra details would help users
understand what went wrong.

--=20
Sabrina


