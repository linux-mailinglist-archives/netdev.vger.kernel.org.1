Return-Path: <netdev+bounces-135740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB599F07F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEBB1F2679D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7341CBA18;
	Tue, 15 Oct 2024 14:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A001CBA17
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004207; cv=none; b=Qn2qpO4vHnnHajokhmoENsvex9PpEo6Kjz196rzYxL3jRyeeaDcGChhdS5DRcjYPqfIgibnrmFZkxUT12IzbTaUrc1dEeRPdPcLJj69hK3l8O+kebvmuUvTmi1HGwzCN93bAHeiioI7P85t+KND+zdxk+pNcoUHlt5meeaWyVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004207; c=relaxed/simple;
	bh=X9btPnUG5iHj+ntNHZziBO3ZaOCP80Sc7jqzqFo36Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JE1NhoWqUL0diKsHyQdf3+1gjt1IqctS7UbHnVuE41E0XtSRKKJx/yb30hZD5v0dvwOjvfwlQRIkpiO9B4xRSkQy1BDkR7Ltb2qNnRGmax5LOj/VowbGhvvVNuEMi0gBfsBLZRgWV5jGRx635rwX5+V1YD0dtoA9qmeJ5a+N5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-cU0F4A74PoiRqbFMGD-nDg-1; Tue,
 15 Oct 2024 10:56:40 -0400
X-MC-Unique: cU0F4A74PoiRqbFMGD-nDg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2A7E19560B0;
	Tue, 15 Oct 2024 14:56:36 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D429919560AE;
	Tue, 15 Oct 2024 14:56:32 +0000 (UTC)
Date: Tue, 15 Oct 2024 16:56:30 +0200
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
Message-ID: <Zw6CntwUyqM6CivS@hog>
References: <20241014090720.189898-1-tariqt@nvidia.com>
 <Zw4uRHzqS05UBMCg@hog>
 <89ccd2ac-5cb8-46e1-86c0-efc741ff18c9@nvidia.com>
 <Zw5DwvIlxyL5n_T1@hog>
 <ded4f325-e83d-4b34-b96c-656fc3c0845f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ded4f325-e83d-4b34-b96c-656fc3c0845f@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-10-15, 21:46:26 +0800, Jianbo Liu wrote:
>=20
>=20
> On 10/15/2024 6:28 PM, Sabrina Dubroca wrote:
> > 2024-10-15, 17:57:59 +0800, Jianbo Liu wrote:
> > >=20
> > >=20
> > > On 10/15/2024 4:56 PM, Sabrina Dubroca wrote:
> > > > 2024-10-14, 12:07:20 +0300, Tariq Toukan wrote:
> > > > > From: Jianbo Liu <jianbol@nvidia.com>
> > > > >=20
> > > > > KASAN reports the following UAF. The metadata_dst, which is used =
to
> > > > > store the SCI value for macsec offload, is already freed by
> > > > > metadata_dst_free() in macsec_free_netdev(), while driver still u=
se it
> > > > > for sending the packet.
> > > > >=20
> > > > > To fix this issue, dst_release() is used instead to release
> > > > > metadata_dst. So it is not freed instantly in macsec_free_netdev(=
) if
> > > > > still referenced by skb.
> > > >=20
> > > > Ok. Then that packet is going to get dropped when it reaches the
> > > > driver, right? At this point the TXSA we need shouldn't be configur=
ed
> > >=20
> > > I think so because dst's output should be updated.
> >=20
> > What updates the dst when we're deleting the macsec device? And this
> > is just a metadata_dst, it's only useful to hold the SCI.
> >=20
>=20
> You are right. It's not updated.
>=20
> > But I guess we would have the same issue when the macsec device still
> > exists but the TXSA is gone, so hopefully this is handled well by all
> > drivers.
> >=20
>=20
> And for now, I'd rather focus on fixing the kernel crash caused by UAF.

Ok, but please take a look at it very soon. Sending packets
unencrypted when they should be encrypted can be just as bad as
crashing the system.

--=20
Sabrina


