Return-Path: <netdev+bounces-110850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB492E9BA
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2511F23132
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B306161936;
	Thu, 11 Jul 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaEgDfAN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7BA161320
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705091; cv=none; b=CnsnkaakQpgz/K78nkZ7XjjPZYmZ9GniRSRt+x5jS1esaxrYjWplqo1Ujs24rswj/VyvRai2JtN/cjBMvBwJoY1Sj85nQtEdCOBCJ/TgOCJzmdO67sX2MG/zEcRRV3qeTqDdds7DFMxF1zVnYHGsVNK7me9hGaUL4GUnr8Jl+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705091; c=relaxed/simple;
	bh=EUsFeFJtD6xeH9Sxe7QtYcIevnVs7b2h9IxbYziaxUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW8yGXfBT8T9TwGMqHRxAhOl7hBvjSc61XMuYxIu+LZB3bz3izI496Hy7R00aOcfmj81DJESNhY6TsiuEW6SX0LSnSZit6WVoJUIATfnZ+Q3F/QP3NQ1z33oOtJ6ucCthSq70XhcIdkELS+uqdaTC+3ORCk5ikILpqFxlUtuXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaEgDfAN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720705088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qgzQsYGB4JKEy70K5sd46pDt/3qz5dHw5T0wigzEDA=;
	b=YaEgDfANFrzaUv0KizmMSz9GynLXFha8zNe1r7paiyZlljzLTCflMU7D5UiBm8lkv+q66r
	zAhR89fMTjcPr9CDJWXi5qyWprbEXZPZCcvgVav64aHwX1BmqWcnJdTWegnMteBUikOKnE
	e7YvQYs0nJ7BMT532zVbUijcRnSYGgU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-0TRKcD4aNquaFSNVMLj_-A-1; Thu,
 11 Jul 2024 09:38:05 -0400
X-MC-Unique: 0TRKcD4aNquaFSNVMLj_-A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 292D11954207;
	Thu, 11 Jul 2024 13:38:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 903393000184;
	Thu, 11 Jul 2024 13:38:03 +0000 (UTC)
Date: Thu, 11 Jul 2024 15:38:01 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <20240711133801.GA18681@fedora.redhat.com>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
 <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
 <20240710190059.06f01a4c@kernel.org>
 <hxsdbdaywybncq5tdusx2zosfnhzxmu3zvlus7s722whwf4wei@amci3g47la7x>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7W5Usnz/8DI5Epo0"
Content-Disposition: inline
In-Reply-To: <hxsdbdaywybncq5tdusx2zosfnhzxmu3zvlus7s722whwf4wei@amci3g47la7x>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--7W5Usnz/8DI5Epo0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 09:07:04AM +0200, Stefano Garzarella wrote:
> CCing Stefan.
>=20
> On Wed, Jul 10, 2024 at 07:00:59PM GMT, Jakub Kicinski wrote:
> > On Wed, 10 Jul 2024 13:58:39 +0200 Stefano Garzarella wrote:
> > > There is a comment there:
> > >=20
> > >      # Avoid changing the rest of the logic here and lib.mk.
> > >=20
> > > Added by commit 17eac6c2db8b2cdfe33d40229bdda2acd86b304a.
> > >=20
> > > IIUC they re-used INSTALL_PATH, just to avoid too many changes in that
> > > file and in tools/testing/selftests/lib.mk
> > >=20
> > > So, IMHO we should not care about it and only use VSOCK_INSTALL_PATH =
if
> > > you don't want to conflict with INSTALL_PATH.
> >=20
> > Any reason why vsock isn't part of selftests in the first place?
> >=20
>=20
> Usually vsock tests test both the driver (virtio-vsock) in the guest and =
the
> device in the host kernel (vhost-vsock). So I usually run the tests in 2
> nested VMs to test the latest changes for both the guest and the host.
>=20
> I don't know enough selftests, but do you think it is possible to integra=
te
> them?
>=20
> CCing Stefan who is the original author and may remember more reasons abo=
ut
> this choice.

It's probably because of the manual steps in tools/testing/vsock/README:

  The following prerequisite steps are not automated and must be performed =
prior
  to running tests:

  1. Build the kernel, make headers_install, and build these tests.
  2. Install the kernel and tests on the host.
  3. Install the kernel and tests inside the guest.
  4. Boot the guest and ensure that the AF_VSOCK transport is enabled.

If you want to automate this for QEMU, VMware, and Hyper-V that would be
great. It relies on having a guest running under these hypervisors and
that's not trivial to automate (plus it involves proprietary software
for VMware and Hyper-V that may not be available without additional
license agreements and/or payment).

Stefan

--7W5Usnz/8DI5Epo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaP4DkACgkQnKSrs4Gr
c8iW1ggAjas57lTw+3EfQEDdanCNFcInunGuy0TQukAHhx725Wi50yukkGR6JtCt
JX6at7va17XupvfR70B1zvZowCw62W6hBtLbxK5XaXrmOF+iwvgDkjZpB+E8PdvG
IkFMbbKMe9DJvTk2hyjlXjCrfNFInp10fAuANBy66z0u8CZAgqtsEWYt/EHo02J1
jKxzzujpBI0EUj1EfLddXK4Ik0Jmj8yB+JyHI97lIQsNcQHc9AiwLy+m2O65PO9M
3+TfgX8+8aFiG4TpnrXptV9keSjPkfr6YJFiyBbSjL00logC+KroRwvJVRDQO3SH
YEhVfTftKvYemA7aimTwOhxeDob6NQ==
=rCe0
-----END PGP SIGNATURE-----

--7W5Usnz/8DI5Epo0--


