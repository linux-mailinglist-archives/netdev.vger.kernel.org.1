Return-Path: <netdev+bounces-87819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34688A4B93
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203BD1C208A5
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7FD3C488;
	Mon, 15 Apr 2024 09:36:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F21DFEA
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173795; cv=none; b=cxRcrdrxog/d6+h4um3a7VuYIDVtbIYvXasMUCCM6J/+7tOz9vcJhbjx2PSpfU60VvskJf9pDlPzRYpGH4NoLV2yM5Wq+X5fXiopEJCHWh8A/rGmBwH+nZu+eixKrwdWe7h/3dP1qizW09C+uAuYbtl6KxE9DpO22htrR4q0j5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173795; c=relaxed/simple;
	bh=4Axruc3xUGj7VtpYpL82w5mHi+EoPbnaoSDV3EzttyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T869Wavmxz9YgO7NRNFCdZ/EglrMvxGiYgwM5srMl9z+0PSCSu49u7o214EJOy0TiYQT8nfQ6qKKpudpLCWp7GsB0MJnqKug3wC0A8feTR8fjj5nT/i4AO6TQBXs/Do1W9/dEIpi9T3NoIXxajjuudPd2ZdohpscObN2uDzNLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-wCD6qNFIONm8U0YWlJA2yg-1; Mon,
 15 Apr 2024 05:36:23 -0400
X-MC-Unique: wCD6qNFIONm8U0YWlJA2yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F27F1C05135;
	Mon, 15 Apr 2024 09:36:22 +0000 (UTC)
Received: from hog (unknown [10.39.192.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A4ED2026D0A;
	Mon, 15 Apr 2024 09:36:19 +0000 (UTC)
Date: Mon, 15 Apr 2024 11:36:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: Antony Antony <antony@phenome.org>, antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v8] xfrm: Add Direction to the
 SA in or out
Message-ID: <Zhz1DmZZCrMq__B_@hog>
References: <9e2ddbac8c3625b460fa21a3bfc8ebc4db53bd00.1712684076.git.antony.antony@secunet.com>
 <20240411103740.GM4195@unreal>
 <ZhfEiIamqwROzkUd@Antony2201.local>
 <20240411115557.GP4195@unreal>
 <ZhhBR5wTeDAHms1A@hog>
 <20240414104500.GT4195@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240414104500.GT4195@unreal>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-14, 13:45:00 +0300, Leon Romanovsky wrote:
> On Thu, Apr 11, 2024 at 10:00:07PM +0200, Sabrina Dubroca wrote:
> > 2024-04-11, 14:55:57 +0300, Leon Romanovsky wrote:
> > > On Thu, Apr 11, 2024 at 01:07:52PM +0200, Antony Antony via Devel wro=
te:
> > > > On Thu, Apr 11, 2024 at 01:37:40PM +0300, Leon Romanovsky via Devel=
 wrote:
> > > > > On Tue, Apr 09, 2024 at 07:37:20PM +0200, Antony Antony via Devel=
 wrote:
> > > > > > This patch introduces the 'dir' attribute, 'in' or 'out', to th=
e
> > > > > > xfrm_state, SA, enhancing usability by delineating the scope of=
 values
> > > > > > based on direction. An input SA will now exclusively encompass =
values
> > > > > > pertinent to input, effectively segregating them from output-re=
lated
> > > > > > values. This change aims to streamline the configuration proces=
s and
> > > > > > improve the overall clarity of SA attributes.
> > > > > >=20
> > > > > > This feature sets the groundwork for future patches, including
> > > > > > the upcoming IP-TFS patch.
> > > > > >=20
> > > > > > v7->v8:
> > > > > >  - add extra validation check on replay window and seq
> > > > > >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> > > > >=20
> > > > > Why? Update is add and delete operation, and one can update any f=
ield
> > > > > he/she wants, including direction.
> > > >=20
> > > > Update operations are not strictly necessary without IKEv2. However=
, during
> > > > IKEv2 negotiation, updating "in" SA becomes essential.
> > >=20
> > > The thing is if you want to limit update routine to fit IKEv2 only, o=
r
> > > continue to allow users to do whatever they want with netlink and the=
ir
> > > own applications without *swan.
> > >=20
> > > I don't have knowledge about such users, just remember seeking tons o=
f
> > > guides how to setup IPsec tunnel with iproute2 and scripts, one of th=
em
> > > can be potentially broken by this change.
> >=20
> > Nothing is going to break with this change. Old scripts and old
> > userspace software are not providing XFRMA_SA_DIR, so none of the new
> > checks apply.
>=20
> Right, but what about new iproute2, which eventually will users get
> after system update and old scripts?

I suspect that new iproute2 will add an option to set the direction
(otherwise it'd have to guess a value, that's not the goal of xfrm
support in iproute), and only pass XFRMA_SA_DIR when the user gave
that extra argument, so nothing will change there either?

--=20
Sabrina


