Return-Path: <netdev+bounces-113028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A323A93C5D0
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D36B21570
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C894A19CCF7;
	Thu, 25 Jul 2024 14:58:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E91DFF7
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919516; cv=none; b=asNBJVRz02A0Ab2419VQUirADlt6YXaC9Fc2ywVMXppPm1ifWUvXSyMEjZwIHiVXqEh7MVgOG059JFYXXskhFutQ2qqNZbGAOCH3Dm2sJMgmmBEODGabsB6ITGcn9yM5bmgr8dTUk0hN04dwK/chW+xsOF+LychgfBKNEe37wMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919516; c=relaxed/simple;
	bh=8pisSiz3cq4YoSV4O1tKhNxL5dywQGML0+8GF5avzUU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lbkpuv2h1GssdJRtEDvqT3qEz1IB9fYXklVT20p0F9w8qP2CkTdEHM+8PceciqcS18KW1hjvRSAskEO54vD0v/Qa/IIBhAN7xRcjJkTvZrYm/yCkN4zFk3JmIV+/3pnwU6QtysmbpdZKPfIzCiWf7RkKsy7bDSjfRJqJao2OVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from dhcp-9273.meeting.ietf.org.chopps.org (dhcp-9273.meeting.ietf.org [31.133.146.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 919FB7D064;
	Thu, 25 Jul 2024 14:58:27 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-9-chopps@chopps.org> <ZqJUMLVOTR812ACs@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 08/17] xfrm: iptfs: add new iptfs xfrm
 mode impl
Date: Thu, 25 Jul 2024 07:56:23 -0700
In-reply-to: <ZqJUMLVOTR812ACs@hog>
Message-ID: <m2ttgdv7qm.fsf@dhcp-9273.meeting.ietf.org>
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


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2024-07-14, 16:22:36 -0400, Christian Hopps wrote:
>> +static int iptfs_create_state(struct xfrm_state *x)
>> +{
>> +	struct xfrm_iptfs_data *xtfs;
>> +	int err;
>> +
>> +	xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
>> +	if (!xtfs)
>> +		return -ENOMEM;
>> +
>> +	err = __iptfs_init_state(x, xtfs);
>> +	if (err)
>> +		return err;
>
> BTW, I wrote that this was leaking xtfs in my previous review, back in
> March :/


You did indeed -- that was the review you asked for the commit split. I've marked unread that previous email now so I can go over it again and verify I didn't miss anything else.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmaiaBESHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl6x0P/1AW/mAMX7wb3JaFyJJJHvXUa7TUjxtQ
zuPJ/zhFt5+zX8Auz9jKfRmkdmm7R8TUu5K6JnftTmBFyDhfNqnFlfaFYdyys1zh
J1TYiIGsflngVhe1DKTvBVHBjqHQF+hw8g6Q2fBMhMGK+7FC+0d2xCaD6r99nZpz
+WM7zKhpi6OB3k6kCDVW7ssjN1EdPg7SI192QwbDPG7k1gncLFeXjR3VNIw4Tnwt
Y/r5/4O/XOj0I9RvtojYsTQx6S5euSw3kg6nTt+dUt7ugHvH+gEMeEr+qiREB3hk
754hqWePXSRMqBwBVSBzftBobgo9V9xLSHt7/Jt6SPBMNIV9Ehh2tUPiNG2UtUPT
N2r0as/VvISP/VUIT4dKecl9ItySYr2Ci8ZXXBGPMx8yjOb724wMsdszFrKQBFhz
PXkFX9Gni8ixMhl7c0RWv8WU1OCzf/Jv2JkS4nnPLrA3Rgr2VuOvUgu6eW7odTaV
m6X68AtJx7FFJmnjSEcvpMLstzUvPnxmd/m0n+iAuesW1qh++XkJYY1OaORALGMF
CARCrOLZm3smNT91wZdzZ4kz8SIH6KSDXwMRyt5a5ZlBHRNo7966sF9RuUUWAEto
ujX2jhxgl4FpHBz3sat4hyLNHXbKibqxePxd7uMRcyPkjbXyjOAhpjcO8XJpxjCV
+dHimETrogDs
=TtVg
-----END PGP SIGNATURE-----
--=-=-=--

