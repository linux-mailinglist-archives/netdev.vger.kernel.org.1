Return-Path: <netdev+bounces-87178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C459E8A1FD6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 22:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB628B1D0
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FC179BC;
	Thu, 11 Apr 2024 20:00:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAF17584
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865645; cv=none; b=k2egUo42hX0gDO38v2C1h8s0sQJCLHXEEVQjaB1T4wQ+aMlYjjuLm052biYCjQSauX83iXOcxqN7ZTc0Q0wVLxXrzeqcBjVWnz4L3z4poIUTwF/eLY0t8uq3G0y9o3uJLqKX2U8+fuyOTIkNfap8Av5HRS4yMSeQzjPiBW1MN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865645; c=relaxed/simple;
	bh=9xLZNm8GpdxtlwGFii/Cw5SkGRrBLNYY8VGMoLIqIto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ms9OPGROAdpqC7lDo1/DMAC4UbHuhC6Bas4p/wo67IxJQ13jPSY1YkRQeI4A6tp74oK1HB4dF+LDskcN3s3c4seTw6CSIcpmmfypDs7zVliR/xuITM9bLbRYBrQfR4kgIZ+Sbv7LZtHek5erHXylmfry6/C/v70Hn3e0LEWwTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-LiwWZNBFNv6R5SMoIp0Cag-1; Thu, 11 Apr 2024 16:00:33 -0400
X-MC-Unique: LiwWZNBFNv6R5SMoIp0Cag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABB24801701;
	Thu, 11 Apr 2024 20:00:31 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 14A9640B4984;
	Thu, 11 Apr 2024 20:00:28 +0000 (UTC)
Date: Thu, 11 Apr 2024 22:00:07 +0200
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
Message-ID: <ZhhBR5wTeDAHms1A@hog>
References: <9e2ddbac8c3625b460fa21a3bfc8ebc4db53bd00.1712684076.git.antony.antony@secunet.com>
 <20240411103740.GM4195@unreal>
 <ZhfEiIamqwROzkUd@Antony2201.local>
 <20240411115557.GP4195@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411115557.GP4195@unreal>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-11, 14:55:57 +0300, Leon Romanovsky wrote:
> On Thu, Apr 11, 2024 at 01:07:52PM +0200, Antony Antony via Devel wrote:
> > On Thu, Apr 11, 2024 at 01:37:40PM +0300, Leon Romanovsky via Devel wro=
te:
> > > On Tue, Apr 09, 2024 at 07:37:20PM +0200, Antony Antony via Devel wro=
te:
> > > > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > > > xfrm_state, SA, enhancing usability by delineating the scope of val=
ues
> > > > based on direction. An input SA will now exclusively encompass valu=
es
> > > > pertinent to input, effectively segregating them from output-relate=
d
> > > > values. This change aims to streamline the configuration process an=
d
> > > > improve the overall clarity of SA attributes.
> > > >=20
> > > > This feature sets the groundwork for future patches, including
> > > > the upcoming IP-TFS patch.
> > > >=20
> > > > v7->v8:
> > > >  - add extra validation check on replay window and seq
> > > >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> > >=20
> > > Why? Update is add and delete operation, and one can update any field
> > > he/she wants, including direction.
> >=20
> > Update operations are not strictly necessary without IKEv2. However, du=
ring
> > IKEv2 negotiation, updating "in" SA becomes essential.
>=20
> The thing is if you want to limit update routine to fit IKEv2 only, or
> continue to allow users to do whatever they want with netlink and their
> own applications without *swan.
>=20
> I don't have knowledge about such users, just remember seeking tons of
> guides how to setup IPsec tunnel with iproute2 and scripts, one of them
> can be potentially broken by this change.

Nothing is going to break with this change. Old scripts and old
userspace software are not providing XFRMA_SA_DIR, so none of the new
checks apply.

--=20
Sabrina


