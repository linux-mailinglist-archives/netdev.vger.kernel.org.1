Return-Path: <netdev+bounces-64914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1B837749
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 00:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2AB284E69
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E1920DFE;
	Mon, 22 Jan 2024 23:01:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F429418
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964508; cv=none; b=DvcMD3CtzdwZq+wJJ5Q86N4djzjQJXE3RUaA/skPsIUnhwZM+CQQTi1WfiEzKLuaWEFqfi9mWqczqZJzcLq8WF1I7ZD8Si7NLNmC/7LEsDPSmRDtmRAUKygu4wxhIRnpfF0g4rvZ4HjELYm4avS0kK+zxGzgQ94KVCRnVOQkn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964508; c=relaxed/simple;
	bh=4Y1O19aIkjnrh7iWPwSjt3Dx9rM9Rsai/h3SSsAEhWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=J7opGuzkIayC/lKz9wAguencoh+k5olDAnvtWTM+icqwZ8R0rW+tXHi5HUagDSNeE2fLrM7Y5E86KYTX7HglLeuC5prluO7rBBjD79n1ChlHRdXov3V00jGHjLi0cXpwFb3MN9dBC40dgDjc71pqTRunUwj1IGpwm/QlZEel2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-264-ONf6tGPgP0OPbYr6kiE2mw-1; Mon, 22 Jan 2024 23:01:43 +0000
X-MC-Unique: ONf6tGPgP0OPbYr6kiE2mw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 23:01:26 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 22 Jan 2024 23:01:26 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tony Nguyen' <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Pavan Kumar Linga <pavan.kumar.linga@intel.com>, "willemb@google.com"
	<willemb@google.com>, kernel test robot <lkp@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Simon
 Horman" <horms@kernel.org>, Krishneil Singh <krishneil.k.singh@intel.com>
Subject: RE: [PATCH net] idpf: avoid compiler padding in virtchnl2_ptype
 struct
Thread-Topic: [PATCH net] idpf: avoid compiler padding in virtchnl2_ptype
 struct
Thread-Index: AQHaTWFBsLvpW2qyg0aKfzhRPlIpObDmck7A
Date: Mon, 22 Jan 2024 23:01:26 +0000
Message-ID: <87cb8a4405724ccb9a00cd23dd07915c@AcuMS.aculab.com>
References: <20240122175202.512762-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240122175202.512762-1-anthony.l.nguyen@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Tony Nguyen
> Sent: 22 January 2024 17:52
>=20
> In the arm random config file, kconfig option 'CONFIG_AEABI' is
> disabled which results in adding the compiler flag '-mabi=3Dapcs-gnu'.

Isn't the arm EABI pretty much the only value used for the last
15 years at least?
Doesn't it also change the size of enums?

So perhaps it shouldn't be possible to unset it?

> This causes the compiler to add padding in virtchnl2_ptype
> structure to align it to 8 bytes, resulting in the following
> size check failure:
>=20
> include/linux/build_bug.h:78:41: error: static assertion failed: "(6) =3D=
=3D sizeof(struct
> virtchnl2_ptype)"

And turn that conditional the correct way around...

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


