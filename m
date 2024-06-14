Return-Path: <netdev+bounces-103681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE769090BB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4ABB236C4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D8417FAA4;
	Fri, 14 Jun 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b="Yk7mdXjD"
X-Original-To: netdev@vger.kernel.org
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64E17C211;
	Fri, 14 Jun 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.98.226.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383298; cv=none; b=QfeL5yEZR3T0O8/GNK5BlEeyM+qqgsb2kbgjDGdjRInIkvYoXNYsoAwY3sVtSz9F69KfT3emHh8DiuBwXfrVdP7OWtCvQ06hDMz6RUdB4g9sVVghoVoZGwil6faaKcSz/u3e52XVtkUCeo62MdE3mJwgFJIb81y46nJ38d7/S4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383298; c=relaxed/simple;
	bh=u0CLUF9D8xF20KbrpNAnEsmDnRC0WgC8ES3TgUkb6M0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYFtb3LqEzVaaCynMwyYzs5jGLRB7CyHSjmp3x6mYvIBxZSSLnBsgqTDs5KGepU2EXNOd5403ylPFv/RyzGCbb2mnjubotkkPYEHV7slmRB/Nq/yPuXCNioWPjdBIEjtCEEIyfOLoXZQPiqc7BTDU9O9fNxSelyDkdSSSUJLnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com; spf=pass smtp.mailfrom=ubimet.com; dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b=Yk7mdXjD; arc=none smtp.client-ip=141.98.226.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubimet.com
Received: from localhost (localhost [127.0.0.1])
	by mx2-at.ubimet.com (Postfix) with ESMTP id BD5EC811C3;
	Fri, 14 Jun 2024 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
	s=20200131mdel; t=1718383288;
	bh=u0CLUF9D8xF20KbrpNAnEsmDnRC0WgC8ES3TgUkb6M0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yk7mdXjDeMN/IoiKDiGHorP6DgWn/0j+jo+l3JlQHrgaR4QZzyZu3qgfBpZL53Djk
	 AdbAytUNn1PJpQaj0smAQ5GhPrerfe36wIFXa6CWtu8bJMCl6nmih1uWrXUZvHVlcY
	 TDPmg7dd6Y7Yw+q6Sd3cUbySjZuMYOuMIfDQUrSOjlYzP0OlAIDQOcRm3e6J3krihC
	 kWf6VGAA2rOnTCRExMP/hmp0aK1CFNH23steS7ZnzH3rDqD/kVHj589j761TJEajMs
	 yH0Rmj7/+eK7cht5NYVKjFM/IROj7gEK9VeWhYg0UP9d6w9F3MoqjthxVL+iaMjTc6
	 BH6Uv7JElYsVw==
Received: from mx2-at.ubimet.com ([127.0.0.1])
	by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vns50stZxRDz; Fri, 14 Jun 2024 16:41:28 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (zimbra-mta01.ext.dc.at.ubimet.com [10.1.18.22])
	by mx2-at.ubimet.com (Postfix) with ESMTPS id AAAEB80C5D;
	Fri, 14 Jun 2024 16:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 8C28A80762;
	Fri, 14 Jun 2024 16:41:28 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id OY7OjSXvoVcD; Fri, 14 Jun 2024 16:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id A2C8A807F2;
	Fri, 14 Jun 2024 16:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id k-y1-UAd74-6; Fri, 14 Jun 2024 16:41:27 +0000 (UTC)
Received: from pcn112 (pcn112.it.hub.at.ubimet.com [10.15.66.143])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id 56EF480762;
	Fri, 14 Jun 2024 16:41:27 +0000 (UTC)
Date: Fri, 14 Jun 2024 18:42:09 +0200
From: =?UTF-8?B?Sm/Do28=?= Rodrigues <jrodrigues@ubimet.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "open list:ETHERNET PHY LIBRARY"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: phy: dp83867: Add SQI support
Message-ID: <20240614184209.2ea5c9a4@pcn112>
In-Reply-To: <0f7cef0d-b5ef-4feb-981e-c587e08de0e9@lunn.ch>
References: <20240613145153.2345826-1-jrodrigues@ubimet.com>
	<20240613145153.2345826-2-jrodrigues@ubimet.com>
	<0f7cef0d-b5ef-4feb-981e-c587e08de0e9@lunn.ch>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 19:13:27 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Jun 13, 2024 at 04:51:51PM +0200, Jo=C3=A3o Rodrigues wrote:
> > Don't report SQI values for 10 ethernet, since the datasheet
> > says MSE values are only valid for 100/1000 ethernet =20
>=20
> The commit message could be better. Something like:
>=20
> Don't report the SQI value when the link speed is 10Mbps, since the
> datasheet says MSE values are only valid for 100/1000 links.
>=20

Thank you, I will use your wording on the next version.

> > +static int dp83867_get_sqi(struct phy_device *phydev)
> > +{
> > +	u16 mse_val;
> > +	int sqi;
> > +	int ret;
> > +
> > +	if (phydev->speed =3D=3D SPEED_10)
> > +		return -EOPNOTSUPP; =20
>=20
> What does the datasheet say about MSE where there is no link at all?
> Maybe you need to expand this test to include SPEED_UNKNOWN?
>=20
The datasheet does not have any information regarding this register
(or the related 0x265, 0x2A5 and 0x2E5, for the other pairs).
The information from these registers come from the "DP83867
Troubleshooting Guide (Rev. B)".

I will add the additional check for SPEED_UNKNOWN in the next
version.

Jo=C3=A3o

