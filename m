Return-Path: <netdev+bounces-86416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A917F89EBD9
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB67281E3D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4CF13C9D6;
	Wed, 10 Apr 2024 07:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66776DDC1
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733990; cv=none; b=qV1hMsoL4f8j3oAjz/ZDQuHYaJawpANnW7eCT21EYqRM4d1BsCkl4hK3vcGkQepS5Q5JKR3ZowXJMvsmUfutsMRbG6T0fqH1D0kOpRYapGkgbvSrd00tVraFVmKhxL0imH7I71urZ/aKHX/MN2r2tqe382KlQRZlqT1xC4gJaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733990; c=relaxed/simple;
	bh=6vPjaXEkswnGGT01XH7s0YHBQwnjtElQyh+Kt1FDWnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=a4wu9oWsbKvPimhSUmKvS3CnTXjEVzpqPUuamKEPfGVSJ+UCvZgHj4DuOKn1bWvI12asllcc+HNlOBAAnt4j/ArCAScqNH/F4p6Ya9zpszIgdnq6mtj/Coy2BHE90FASMlPu3rr0DWO+W979sTFbvQinvXhE4zpJ5uMy9DYr+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-dtbLwR1fO6aUrH7x7AQoFQ-1; Wed, 10 Apr 2024 03:26:16 -0400
X-MC-Unique: dtbLwR1fO6aUrH7x7AQoFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2E38806626;
	Wed, 10 Apr 2024 07:26:15 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A7B1C04227;
	Wed, 10 Apr 2024 07:26:13 +0000 (UTC)
Date: Wed, 10 Apr 2024 09:26:08 +0200
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
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <ZhY_EE8miFAgZkkC@hog>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-10, 08:32:20 +0200, Nicolas Dichtel wrote:
> Le 09/04/2024 =C3=A0 19:56, Antony Antony a =C3=A9crit=C2=A0:
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> >=20
> > This feature sets the groundwork for future patches, including
> > the upcoming IP-TFS patch.
> >=20
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> > v8->v9:
> >  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
> >=20
> > v7->v8:
> >  - add extra validation check on replay window and seq
> >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> >=20
> > v6->v7:
> >  - add replay-window check non-esn 0 and ESN 1.
> >  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
> Why? I still think that having an 'input' SA used in the output path is w=
rong
> and confusing.
> Please, don't drop this check.

Limiting XFRMA_SA_DIR to only HW offload makes no sense. It's
completely redundant with an existing property. We should also try to
limit the divergence between offload and non-offload configuration. If
something is clearly only for offloaded configs, then fine, but
otherwise the APIs should be identical.

And based on what Antony says, this is intended in large part for
IPTFS, which is not going to be offloaded any time soon (or probably
ever), so that restriction would have to be lifted immediately. I'm
not sure why Antony accepted your request.

--=20
Sabrina


