Return-Path: <netdev+bounces-112005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE429347BE
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B521F2233E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5183C6A6;
	Thu, 18 Jul 2024 05:56:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2732C20DE8
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282213; cv=none; b=C/r4NBasyu8fjd6cCSffOVtHO5fJ0oTqsbhuy46w3dL/6tNiSaPN3JayIv3kp06uR3al2ylq2IubXLw3cxy+NAumih2uF34yISG9Z89pols1o06cEG3sld961IZIL2e2DgLAcw1sxHz+Px12rBdMBPbwdXHT6CDredGkLWl3iXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282213; c=relaxed/simple;
	bh=5rs/onZmRWXujxMIBOcC5yrhj1JjIJZm6CImHvZBjJ0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=aSx6rUkN4OojzLlHZProLd/xHUCQLxVUrTzd4sDemDIj2s/0LvhwXnBtLb+9JENlVRIjP9b7euOgE5JyY0mNdaNVuvmWj0oWreh1Peoxo4/x/0AheFqfJfztyMKp7yiTrgFbMMW7jVXgp6OsVooMSZJ9lmBN8oWQzVzh/OO68ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [50.229.122.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id DE6A97D06B;
	Thu, 18 Jul 2024 05:56:50 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-9-chopps@chopps.org>
 <20240715123923.GB45692@kernel.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 08/17] xfrm: iptfs: add new
 iptfs xfrm mode impl
Date: Wed, 17 Jul 2024 22:56:04 -0700
In-reply-to: <20240715123923.GB45692@kernel.org>
Message-ID: <m28qxzdyzi.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Simon Horman via Devel <devel@linux-ipsec.org> writes:

> On Sun, Jul 14, 2024 at 04:22:36PM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
>>
>> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
>> functionality. This functionality can be used to increase bandwidth
>> utilization through small packet aggregation, as well as help solve PMTU
>> issues through it's efficient use of fragmentation.
>>
>>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>>
>> Multiple commits follow to build the functionality into xfrm_iptfs.c
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  net/xfrm/Makefile     |   1 +
>>  net/xfrm/xfrm_iptfs.c | 206 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 207 insertions(+)
>>  create mode 100644 net/xfrm/xfrm_iptfs.c
>>
>> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
>> index 512e0b2f8514..5a1787587cb3 100644
>> --- a/net/xfrm/Makefile
>> +++ b/net/xfrm/Makefile
>> @@ -21,5 +21,6 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>>  obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>>  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>>  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
>> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>>  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
>>  obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>> new file mode 100644
>> index 000000000000..414035a7a208
>> --- /dev/null
>> +++ b/net/xfrm/xfrm_iptfs.c
>> @@ -0,0 +1,206 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* xfrm_iptfs: IPTFS encapsulation support
>> + *
>> + * April 21 2022, Christian Hopps <chopps@labn.net>
>> + *
>> + * Copyright (c) 2022, LabN Consulting, L.L.C.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/icmpv6.h>
>> +#include <net/gro.h>
>> +#include <net/icmp.h>
>> +#include <net/ip6_route.h>
>> +#include <net/inet_ecn.h>
>> +#include <net/xfrm.h>
>> +
>> +#include <crypto/aead.h>
>> +
>> +#include "xfrm_inout.h"
>> +
>> +struct xfrm_iptfs_config {
>> +	u32 pkt_size;	    /* outer_packet_size or 0 */
>> +};
>> +
>> +struct xfrm_iptfs_data {
>> +	struct xfrm_iptfs_config cfg;
>> +
>> +	/* Ingress User Input */
>> +	struct xfrm_state *x;	    /* owning state */
>> +	u32 payload_mtu;	    /* max payload size */
>> +};
>> +
>> +/* ========================== */
>> +/* State Management Functions */
>> +/* ========================== */
>> +
>> +/**
>> + * iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
>> + * @x: xfrm state.
>> + * @outer_mtu: the outer mtu
>> + */
>
> Hi Christian,
>
> Please consider including a "Return:" or "Returns:" section
> in the Kernel doc for functions that return values.
>
> Likewise elsewhere in this patchset.
>
> Flagged by: ./scripts/kernel-doc -none -Wall
>
>> +static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
>
> ...

I've updated all the doc comments to include "Return:"s.

Thanks!
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmaYrqESHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl45kQAJFtJtDAMjKPZY1NuDKMMzhNPVmJlaBz
Q4Urli/gkgX78EDCzsxuQDYUra0Fy/7KfDlgs+O5KGlPshpdgz40C/P5GsM/3wxg
dxTgAb9EuiOq2iGO4Sq4hmBo2K3V9QCMaJtjaA1Jx9fT4vKI9gVuu3hXUSoNoTvs
SjGelRTLAy8Ui8VUouLTKwlT6jyTWMAmazAj4SbDDe8976LAtm9MayzqUML8fD2n
t98sweLRjYtLqFQyoJTGuhZtT7TilNX3YcGzvyxkhaCpKy84KebM/Bx8AnIbqj89
pYE8hxm66u08o8V4Rf4XuzkPpX8wFYmMZI/JnFNnohNz9NJsXULxhj8PiY4Rkvig
8cbYTKE+YMpoWRnHZFSJlSsdkUU+dttwBzGL456Me8GjgkcbtQhKbBT/3MZMIFak
ITn5n5mlmt4TNofRIhdD21J+NwwzVY6v6zfqtIdK2kjLjjKjloe3H28UPbgEG/9N
pf69f4WGTc6EDBtilJauxfn5l/sznwBk2g+dIw8/CA8SrgI5Wqremuvzt19QT2OQ
GxUMUuIHJ1xDscoeZguJijHLHKhofQ9Bm9S4sM+TrBUJ/F85Fr5+ZEmV+gDcxUtI
kWJWaXwVW7NOUW1+FR7x3WDS6NFjHhyNYj4IjR3DuxaCPw359l2a5De1thItyStg
lrvUZZS6zAqF
=Cz0t
-----END PGP SIGNATURE-----
--=-=-=--

