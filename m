Return-Path: <netdev+bounces-211154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FDB16F10
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F363AE6C3
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13912BD035;
	Thu, 31 Jul 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="LyR7xVLq"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A92BE02D
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955921; cv=none; b=e3MOJckUBHNdQGxV2c+QE0zr4srHWWAHNsj5QvQRwdei9d2mzv+tDWbYW/+xLRCxSazl6D8dLyaIl0D145QcVGmKsArC6lz0Ts4Yi1EVRiBCIuIXVFE5c+AeFPjNsa89d+WMPnytHZCs0K9SN97IzSkWn/XLLotLpN0KDujXSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955921; c=relaxed/simple;
	bh=wpitbf25Q43LaWq0v+YYsq3h35Lk6PcD+IaqtkFbeQg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=sCkhAHj8AnDmA+zQsDXyYinpjLMaWY5WdIiTGfCFiiqR9x2PlwCxKXZDyuKZ+W3ajhGKiU9qD4Ca1JzzYYVybNRZ6zHt96GXRaMKtj9eS7DxkeWkqmNYMCNOB3BD62BpA7B4C7TWWYZ8v7E0itaNny1dNr7NgnOvcdwRCAFbf80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LyR7xVLq; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753955912; x=1754560712;
	i=markus.stockhausen@gmx.de;
	bh=kxYxhi9ECbA5PDKRCuyLeOu2QcQG1eF6h8D1XZIATCM=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LyR7xVLq3cZKSlJCzyverEmBWoTDfGlc4EEMM0h7kBBY6z0Q3ztB/JSJexoXniDe
	 Yq/bNowictb/WSewufWXFck2OTuH3+5F7oTd08k+zVwRIvNI8Nt6bzU7UsdGFe3p0
	 3zbsjx6PA6rSqJPKAktCFZaL6Z3lVefL+HdTd+0/vAl5GT2rxjQ312vp+HQZQzqwd
	 mpKq+f19udcJMcdZSpCtzWJQW3CkeP34cg9tZLIihMSGNMlRzL6MSl2O0vdhJN07B
	 uYQSi3fFrjppMa2x/ZoRC1Dce2phcuVgSO1BD9KyQBtmKWRVbz+iqaKT2nIZE5Abx
	 TK9gShVN1oztlCqSXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJV6-1uDHlp3teY-00jNsU; Thu, 31
 Jul 2025 11:58:32 +0200
From: <markus.stockhausen@gmx.de>
To: "'Daniel Golle'" <daniel@makrotopia.org>
Cc: <andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<michael@fossekall.de>,
	<netdev@vger.kernel.org>,
	<jan@3e8.eu>
References: <20250731054445.580474-1-markus.stockhausen@gmx.de> <aIs2KVi6rYVhTzde@pidgin.makrotopia.org>
In-Reply-To: <aIs2KVi6rYVhTzde@pidgin.makrotopia.org>
Subject: AW: [PATCH v2] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Thu, 31 Jul 2025 11:58:30 +0200
Message-ID: <04b901dc0201$ac06ec70$0414c550$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQFPCO6TL5FzOL/6Ie5b5z8UBtRI6QJENZnptVPOUgA=
X-Provags-ID: V03:K1:6lFSTq+xKSoLUHJEacdXYvAZo0tsqj8SoPqkH8tKQpm9a1Qc8ZB
 W3zaXP4pZnAsofT+Bb5ubSOmCHPIaiY2HYJe511M2pbLsYGTHJGzPOMc6BFUb4+L4As3XQB
 t51kQSTUI8BlyIuGteJTVx5hhzRMQapljyIgj1dc9RV5vsLgkMnKz4Yhvcmskeo/q4ziCRs
 jW5FDV3wESyA8lAuwrp/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VEFsBsUbflg=;oJSVVRev457+cKsQL9lRimhiCeh
 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
 IOdLbu8xZ4Q==


Von: Daniel Golle <daniel@makrotopia.org>=20
Gesendet: Donnerstag, 31. Juli 2025 11:24

> >  		.read_page      =3D rtl821x_read_page,
> >  		.write_page     =3D rtl821x_write_page,
>=20
> I suppose .read_page and .write_page can then be dropped as well as page=
d
> Clause-22 access is no longer needed, right?

Totally ok for me. If no one complains will send a v3.

Markus




