Return-Path: <netdev+bounces-49439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438647F2073
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745E71C21572
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A936B15;
	Mon, 20 Nov 2023 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D9A2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 14:38:39 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ub7cuVfPNN-Hr6ACF8IZ4A-1; Mon, 20 Nov 2023 17:38:35 -0500
X-MC-Unique: ub7cuVfPNN-Hr6ACF8IZ4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11445887E40;
	Mon, 20 Nov 2023 22:38:35 +0000 (UTC)
Received: from hog (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A43492BFA;
	Mon, 20 Nov 2023 22:38:33 +0000 (UTC)
Date: Mon, 20 Nov 2023 23:38:32 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 2/8] iptfs: uapi: ip: add ip_tfs_*_hdr packet
 formats
Message-ID: <ZVvf6D-t7kcg3MDC@hog>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-3-chopps@chopps.org>
 <ZVt7Nud5U5FbUJ3f@hog>
 <m2sf50yxym.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <m2sf50yxym.fsf@ja.int.chopps.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-20, 15:18:49 -0500, Christian Hopps wrote:
>=20
> Sabrina Dubroca <sd@queasysnail.net> writes:
>=20
> > 2023-11-12, 22:52:13 -0500, Christian Hopps wrote:
> > > From: Christian Hopps <chopps@labn.net>
> > >=20
> > > Add the on-wire basic and congestion-control IP-TFS packet headers.
> > >=20
> > > Signed-off-by: Christian Hopps <chopps@labn.net>
> > > ---
> > >  include/uapi/linux/ip.h | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >=20
> > > diff --git a/include/uapi/linux/ip.h b/include/uapi/linux/ip.h
> > > index 283dec7e3645..cc83878ecf08 100644
> > > --- a/include/uapi/linux/ip.h
> > > +++ b/include/uapi/linux/ip.h
> > > @@ -137,6 +137,23 @@ struct ip_beet_phdr {
> > >  =09__u8 reserved;
> > >  };
> > >=20
> > > +struct ip_iptfs_hdr {
> > > +=09__u8 subtype;=09=09/* 0*: basic, 1: CC */
> > > +=09__u8 flags;
> > > +=09__be16 block_offset;
> > > +};
> > > +
> > > +struct ip_iptfs_cc_hdr {
> > > +=09__u8 subtype;=09=09/* 0: basic, 1*: CC */
> > > +=09__u8 flags;
> > > +=09__be16 block_offset;
> > > +=09__be32 loss_rate;
> > > +=09__u8 rtt_and_adelay1[4];
> > > +=09__u8 adelay2_and_xdelay[4];
> >=20
> > Given how the fields are split, wouldn't it be more convenient to have
> > a single __be64, rather than reading some bits from multiple __u8?
>=20
> This is a good point, I carried this over from an earlier implementation,=
 let me give it some though but probably change it.
>=20
> > > +=09__be32 tval;
> > > +=09__be32 techo;
> > > +};
>=20
> > I don't think these need to be part of uapi. Can we move them to
> > include/net/iptfs.h (or possibly net/xfrm/xfrm_iptfs.c)? It would also
> > make more sense to have them near the definitions for
> > IPTFS_SUBTYPE_*. And it would be easier to change how we split and
> > name fields for kernel consumption if we're not stuck with whatever we
> > put in uapi.
>=20
> The other ipsec modes headers were added here, so I was simply
> following along. I don't mind moving things but would like to
> understand why iptfs would be different from the other modes, for
> example, `struct ip_comp_hdr` and `struct ip_beet_phdr` appears in
> this file.

IMHO it was a mistake that was made when include/uapi was created,
they should not have been part of uapi since there's never an exchange
between kernel and userspace using those. I guess it's less
problematic because the header formats are simple (everything fits
nicely into a u8/u16/u32) and they were already used in the kernel for
a long time so pretty much stable (ie no doubt about whether the
split and naming that was chosen was right).

But if others feel strongly about putting those structs in uapi, I can
live with that.

I'll send comments on the rest of the series as I continue making my
way through it. The main patch is going to take me a while :(

--=20
Sabrina


