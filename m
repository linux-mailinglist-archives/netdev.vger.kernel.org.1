Return-Path: <netdev+bounces-20978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C805D7620A5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DC0281352
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF225928;
	Tue, 25 Jul 2023 17:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C125140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:55:05 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D810F7
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:55:03 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-aGyCCybsPlWyTKE70uC9HA-1; Tue, 25 Jul 2023 13:54:46 -0400
X-MC-Unique: aGyCCybsPlWyTKE70uC9HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1165101A54E;
	Tue, 25 Jul 2023 17:54:45 +0000 (UTC)
Received: from hog (unknown [10.45.224.100])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 77E5B40C206F;
	Tue, 25 Jul 2023 17:54:44 +0000 (UTC)
Date: Tue, 25 Jul 2023 19:54:43 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, mkubecek@suse.cz,
	lorenzo@kernel.org
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
Message-ID: <ZMAMY0MTj7PbJazi@hog>
References: <20230722014237.4078962-1-kuba@kernel.org>
 <20230722014237.4078962-2-kuba@kernel.org>
 <20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
 <20230724084126.38d55715@kernel.org>
 <2a531e60a0ea8187f1781d4075f127b01970321a.camel@redhat.com>
 <20230724102741.469c0e42@kernel.org>
 <20230724120718.4f01113a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230724120718.4f01113a@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-07-24, 12:07:18 -0700, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 10:27:41 -0700 Jakub Kicinski wrote:
> > > I still have some minor doubts WRT the 'missed device' scenario you
> > > described in the commit message. What if the user-space is doing
> > > 'create the new one before deleting the old one' with the assumption
> > > that at least one of old/new is always reported in dumps? Is that a t=
oo
> > > bold assumption? =20
> >=20
> > The problem is kinda theoretical in the first place because it assumes
> > ifindexes got wrapped so that the new netdev comes "before" the old in
> > the xarray. Which would require adding and removing 2B netdevs, assumin=
g
> > one add+remove takes 10 usec (impossibly fast), wrapping ifindex would
> > take 68 years.
>=20
> I guess the user space can shoot itself in the foot by selecting=20
> the lower index for the new device explicitly.

Or just moving devices between netns?

Scenario 1:
- create lots of devices in netns A, last ifindex is 100 (call it dummy100)
- netns B isn't creating many devices, last ifindex is 8
- move dummy100 from netns A to netns B, it keeps ifindex=3D100
- create a device in netns B, it gets ifindex=3D9 even though we already
  have a device with ifindex=3D100

Scenario 2:
- create lots of devices in netns A, last ifindex is 100
- delete devices with ifindex 10..80 from A
- move a device with ifindex=3D20 into netns A, it keeps ifindex=3D20
- we have a new device in netns A with a smaller ifindex than the max


I think with this patch we could still see states that never existed,
if both a low ifindex and then a high ifindex are created during the
dump. We could see high ifindex without low ifindex being listed, if
the dump was already past the low id.  Or if we delete one at a low
ifindex then create one at a high ifindex, we could see both devices
listed in the dump when they never both existed at the same time.


> > And if that's not enough we can make the iteration index ulong=20
> > (i.e. something separate from ifindex as ifindex is hardwired to 31b
> > by uAPI).
>=20
> We can get the create, delete ordering with this or the list, but the
> inverse theoretical case of delete, create ordering can't be covered.
> A case where user wants to make sure at most one device is visible.
>=20
> I'm not sure how much we should care about this. The basic hash table
> had the very real problem of hiding devices which were there *before
> and after* the dump.
>=20
> Inconsistent info on devices which were created / deleted *during* the
> dump seems to me like something that's best handled with notifications.
>=20
> I'm not sure whether we should set the inconsistency mark on the dump
> when del/add operation happened in the meantime either, as=20
> the probability that the user space will care is minuscule.

The inconsistent dump mark may be more relevant for changes in device
properties than link creation/removal. If the MTU on 2 devices changes
while the dump is running (one low ifindex, one high ifindex), we'll
see the old MTU for the first device and the new MTU for the 2nd. Or
by adding/removing bridge ports while the dump runs, I can make it
look like bridge0 has mulitple ports with the same port_no.

I don't know how likely those cases are, but if they happen I think
they'd be more confusing than a missing/extra device.

--=20
Sabrina


