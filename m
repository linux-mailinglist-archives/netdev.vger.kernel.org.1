Return-Path: <netdev+bounces-135534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED2C99E3D8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C91281F7E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A521E5021;
	Tue, 15 Oct 2024 10:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A21D5AC9
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988114; cv=none; b=rqY5KZwurRiGMiisTD48k+2o+C/w4fpzeyVEbK4BXxSzQ7wOcco4V3sUn1+YVc5aQZyLnpwK0zDjGcoC89hWiHRIYdLxXuoLarZB5jSsTbEezZvh0VpBOxgGcgiubIRxDPBdlECOrmLr8KiyRkydaQfKWINkC3BxE4DneCKik4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988114; c=relaxed/simple;
	bh=Z8qUG1gqu6HdLvuKmiAROp/AIfr1K8BzIJ2KjubJkxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mH5P2+dGM8OwesnaJnhnJ+wMK15Y65F4Reru7LCATFdWtF1ASBL+qM798tZrL31qzZFaGt8KxlALSyCtx51EA8vO1Ehxi+FYzf6tVCDa5jqvixnHD9RDjHyPu6H2hXBPzwGZx0NE3DHCVs1Hqwob0VJhPYETsm5j/g10+W8uc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-56JXC-70OwqQEvoZOjuufQ-1; Tue,
 15 Oct 2024 06:28:28 -0400
X-MC-Unique: 56JXC-70OwqQEvoZOjuufQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C9D1195609E;
	Tue, 15 Oct 2024 10:28:25 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1818B19560A2;
	Tue, 15 Oct 2024 10:28:20 +0000 (UTC)
Date: Tue, 15 Oct 2024 12:28:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>, Chris Mi <cmi@nvidia.com>
Subject: Re: [PATCH net] macsec: Fix use-after-free while sending the
 offloading packet
Message-ID: <Zw5DwvIlxyL5n_T1@hog>
References: <20241014090720.189898-1-tariqt@nvidia.com>
 <Zw4uRHzqS05UBMCg@hog>
 <89ccd2ac-5cb8-46e1-86c0-efc741ff18c9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <89ccd2ac-5cb8-46e1-86c0-efc741ff18c9@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-10-15, 17:57:59 +0800, Jianbo Liu wrote:
>=20
>=20
> On 10/15/2024 4:56 PM, Sabrina Dubroca wrote:
> > 2024-10-14, 12:07:20 +0300, Tariq Toukan wrote:
> > > From: Jianbo Liu <jianbol@nvidia.com>
> > >=20
> > > KASAN reports the following UAF. The metadata_dst, which is used to
> > > store the SCI value for macsec offload, is already freed by
> > > metadata_dst_free() in macsec_free_netdev(), while driver still use i=
t
> > > for sending the packet.
> > >=20
> > > To fix this issue, dst_release() is used instead to release
> > > metadata_dst. So it is not freed instantly in macsec_free_netdev() if
> > > still referenced by skb.
> >=20
> > Ok. Then that packet is going to get dropped when it reaches the
> > driver, right? At this point the TXSA we need shouldn't be configured
>=20
> I think so because dst's output should be updated.

What updates the dst when we're deleting the macsec device? And this
is just a metadata_dst, it's only useful to hold the SCI.

But I guess we would have the same issue when the macsec device still
exists but the TXSA is gone, so hopefully this is handled well by all
drivers.


> But the problem here is
> dst free is delayed by RCU, which causes UAF.

To be clear, I'm not objecting to the patch, I'm wondering about other
related issues once we fix that.

--=20
Sabrina


