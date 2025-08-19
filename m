Return-Path: <netdev+bounces-214935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A4B2C0C4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73EF17BBA2
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3F532BF49;
	Tue, 19 Aug 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ibu7j1Hy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD527464F
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603754; cv=none; b=gw5yAgTDT1h9lYiXrqwfc1r85LB2R16EEvpMnvE8kTvI06BS72sjKu0eyihhgftymer2Hn+7ypoh5HIjQLdP/vTF+sXc8KZJlMG6wetkrvKvvzH6YYGfoWMR0Y3SH2dPyPVIJfK6+XXEFtDCfuVsWTbwTa3pK7447LfYvdDiCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603754; c=relaxed/simple;
	bh=i6/FFx4o9rXet7U52TFbFcsr48kAqmv5yfVusV6aOYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmnwMg30WiT5RnV5a4VSB9ktzni5501gC9n09Io8TKTLvxULUilonCJM9Jc9lYLXJkZJ0x/WAQFZhhRC+5knpgwAJLwg7J4+LBZ8JXgJv6CA5RJmg1lVhhzl8ZwpSrqgDyu7RVPgMSvQiKXnyYpwoWX1E6H+g5vW9+5EQ6OnPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ibu7j1Hy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755603752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CDY/siFmYcwlrdkt8B8vowtvoh8A+BRqaxiLLG+Hp8=;
	b=Ibu7j1HygIFCLFNgKCQa9+phfTOkB0xMQjQ1yyJ4bt3rGr/bmIRPhVbsnb47DUNavUiAjq
	JJter4MinK3kDVxVirly4nv9yHiNhUqs+26dIko2TH4Wem/uAgDIGHvJV8ZGVdgt9Tsn9Y
	CnkxoopGXFxPETeJE2AKyN8zT3sZQDg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-8WdoaadNMFm6nstW1JaUIw-1; Tue,
 19 Aug 2025 07:42:28 -0400
X-MC-Unique: 8WdoaadNMFm6nstW1JaUIw-1
X-Mimecast-MFC-AGG-ID: 8WdoaadNMFm6nstW1JaUIw_1755603746
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87FE81954B1C;
	Tue, 19 Aug 2025 11:42:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.68])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BE1D19560AB;
	Tue, 19 Aug 2025 11:42:24 +0000 (UTC)
Date: Tue, 19 Aug 2025 07:42:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Hillf Danton <hdanton@sina.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 0/2] Fix vsock error-handling regression introduced in
 v6.17-rc1
Message-ID: <20250819114223.GA37216@fedora>
References: <20250818180355.29275-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EiAQxVZfWL66lhJ5"
Content-Disposition: inline
In-Reply-To: <20250818180355.29275-1-will@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--EiAQxVZfWL66lhJ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 07:03:53PM +0100, Will Deacon wrote:
> Hi all,
>=20
> Here are a couple of patches fixing the vsock error-handling regression
> found by syzbot [1] that I introduced during the recent merge window.
>=20
> Cheers,
>=20
> Will
>=20
> [1] https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.c=
om/
>=20
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
>=20
> --->8
>=20
> Will Deacon (2):
>   net: Introduce skb_copy_datagram_from_iter_full()
>   vsock/virtio: Fix message iterator handling on transmit path
>=20
>  include/linux/skbuff.h                  |  2 ++
>  net/core/datagram.c                     | 14 ++++++++++++++
>  net/vmw_vsock/virtio_transport_common.c |  8 +++++---
>  3 files changed, 21 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.51.0.rc1.167.g924127e9c0-goog
>=20

Stefano Garzarella is offline at the moment and may not get a chance to
review this for another week. In the meantime I have reviewed this patch
series:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EiAQxVZfWL66lhJ5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmikYx8ACgkQnKSrs4Gr
c8g6vwgAk0tzl/aU8i9ne8GgOXpF111xADxfNnaedXr6oUD9ZxeTTq5yUesC8mN7
/DWT6dh3PuEb6bJLOGVHW8Nu57WjYfr7fIso5L3BnXvB3bZm7Ft98dESLl7RIF+7
M7gy+28m7+jjgkbJ0u4EuQovGWRG6geEjqeHmo8XHefVlqaFl8YXnMwu8a4Q08xk
ud9GQ7fcQGnJF2Gd7N37jGVZVN59XfBdwYyzCh6lWvHyj/U3CDDa5kqfeGWqXCyd
AdPFM2DmWaO1U0IaKoHNa0v2F7oEYgouf/dkvsR6QfBxSWtNdysJ8AL8prYjarLU
xR+U5eqHwm7YoUVh9ODH1RxZ4N3jHQ==
=6Pi0
-----END PGP SIGNATURE-----

--EiAQxVZfWL66lhJ5--


