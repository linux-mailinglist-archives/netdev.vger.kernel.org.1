Return-Path: <netdev+bounces-110516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E14B92CC8F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F093B21BED
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7483784A51;
	Wed, 10 Jul 2024 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e3QZBEEK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731782C60;
	Wed, 10 Jul 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599099; cv=fail; b=EU6q3RK/mKC1dVLyJZFGDwIp7YE/kQL7oZIfB2gI2lCG9mDWsaIaAWR2+v6tHHfjznjirjHl/QKHHDKzpijtPPHEDTbGq39oK+3f09Yq0f6Ixl3c7nxa90FNAdlhDRV3Ra7F2S6ve/C/zVK2IBmHqhNESN8Qz+ILHGYcRm+JTRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599099; c=relaxed/simple;
	bh=w5YdMNc/RQtxnspAC+nZDiv/jmZ9ACMc2duigZRh5xU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCJOAs+sPlaOCx+arT0dzSHjT+vDfmiM3/ULO4bZdqQh+wkNevlOQ0WxcU+0w6QBDETnYjSX8ef0xvk2lKTn2Il74Jgd6nmbjVw86Z/2Cc8+oqkmGmVATFdfrj9Gyr/QKbNwLvuoivAeBqmQyGZ7Muv368x2DWHrpftt1R7nJMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e3QZBEEK; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWJyfMMMlszA1nb79xKA81NJMspmkRphhRKOI2av5WXkeeLXDm6YJk/zOYTQhN2LmWDCPlhey30TsT5ALI0JOhhvVxytvLzCQijNmfdTf4HiuNKUfdXytpvuNJQ27BEYiiCMnMFcjf06AM+7xZwLvVywcHYrEF9Edy1Er69EmXDm78JaungHj+avNLrBNmC4VSqENmfPvJ+zG6eLf7ThGZDvOPHv7ZbdmmZTUOuTTnj6FH8iA7IE2unheIVXlMjpFt/CTGthNditfsa7jvrCZHRMe5zOw/pDz6qfIM5yjROD0Plw/lO4i+AFRBUEwjJ6VYa6qqueIPRoUPagwLCuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG/bdtgGAAAcRBDnu7e168YlH4We0avNu5UCn8njEFE=;
 b=kXjilLGfdaYtKolcTVcy5d22hWTpDmmDaGVJrf3mE/lFTyfnBIudAhoVsAkqq9cKsrTQwEbbL3yzc/IyeOqjiZAT+FSePU7Jl+MEVJVQn8XFLZ9YNDyQeuONFDtbx9fXG1dmDea1yKbAGpr7iF9xisz3fSH6b4R0cpTWp3Ou/bO5D5fGr6bxy78eYdpc1FANKDhxRPECLkccmQki+rnS+cNr0fGfRaLYcxOvallQEJewXbtPh0kJZg2iCsF2lSkn4ePOJXc/vE7OX6a23DMkXeJvOzzCjnnNf4+JCc2QsEqUjfEFz3qcqeTiAdFuXqbaIAChDCRurPi01l1Sf7qtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG/bdtgGAAAcRBDnu7e168YlH4We0avNu5UCn8njEFE=;
 b=e3QZBEEKQRCXnhfwGOod7zc5/kthoeXAYF0B8S1wz9c5iKqTjt7sbzb29qYiVwuCdkjjMzPjOv71UPgLetGDJehJnq7VXlY+BiJXQ4c4GmNI9KX/B5j+Yfra9tASQNlj0qltnf/qfZQCBx/UW4Lr6xqOj3TexHEP+XliryQIouk=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7151.eurprd04.prod.outlook.com (2603:10a6:800:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:11:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 08:11:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stefano Garzarella <sgarzare@redhat.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] test/vsock: add install target
Thread-Topic: [PATCH] test/vsock: add install target
Thread-Index: AQHa0gXDNBM9iTbnZU+dNaZg6A0BnrHvkzMAgAACM/A=
Date: Wed, 10 Jul 2024 08:11:32 +0000
Message-ID:
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
In-Reply-To: <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB7151:EE_
x-ms-office365-filtering-correlation-id: bb723345-5c1f-494e-ef20-08dca0b7e946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5WDnf5vcS12h3mxBTZEjlP+2+HZIrpIKqR233wXyfgA8+gpRtM2jrDyvxudL?=
 =?us-ascii?Q?uAegKg/8GeTvdlw+GRhyg4XGQcETl/rUBMM5dGQaYuMZ9Ce3/WCQxjk9Erre?=
 =?us-ascii?Q?hLSgaPnqlVeGdfot12E2RXc11P14c3YmUjRZuJLfbJvd9Hd7Y+fZlBhmlmGm?=
 =?us-ascii?Q?fZ1SJiR8LoMHE+qx4Thlcedhqf0zdBpuJEzp4HQ5N5lxEvitplWuFk0shYGE?=
 =?us-ascii?Q?dk/jSUvdlNU1o6S1igOT4lJ4u9dUOSTrftRCbgCSKr9LDSbrqgiXBRoiCS/u?=
 =?us-ascii?Q?ZDYxii7NS3BXuV9b77ofS0bn29fkbZlE42dL3dv6y2FKu/44Nf+ZfBefqBE7?=
 =?us-ascii?Q?eWoY1QVKPtoBiU2e1DdOHNbyRDknB6g83eRPsZidzkhV5JxD6lQRVxzYK3dW?=
 =?us-ascii?Q?mWMYp1akaIBZdD/54kh5NFfOl6JmvKg/3RA6WoG1owdX2ArAphqjsEaskYsQ?=
 =?us-ascii?Q?CHE5WwiXRyciavm5OO6ch73OsLNkxKqJGOWqvP1yxDIenYci/wvqAt7PC0E2?=
 =?us-ascii?Q?wI2owOxtzBAeNpvSXqY/sazDcXLmDg3NPyjAIiPbxJkwoSUs2bDqfxRZCJeJ?=
 =?us-ascii?Q?6vJSdXzbsr3PyRW+teF0SHkCM1KwjI799mQp50TlR59LTAtsyLYytSpCLglv?=
 =?us-ascii?Q?5r7W3gk/ZzvA2aazjg5++tQ6iLxPWsF6gQAdTDpgsfRUn7Y8+rqiL5L8A+pX?=
 =?us-ascii?Q?5dqR7foGIco1flZ02s/MVVf4EFANt6pddRWfLldEnoKCw5pEy8vUNZXweK7R?=
 =?us-ascii?Q?BiD6mLOlHxvSciHoQ95MvIFzfb/rQbTVliDqb095aJdlnkdOiAqWc8AuCLS6?=
 =?us-ascii?Q?88pNZ5JZ4GL6pVFmBi0iVYTEALQy8UrJmaZVCFarQPHy94YqTcGTyHxTjD31?=
 =?us-ascii?Q?pPHZ9qtTd4GR4wyBIhwhB3yktvmBahBczLHbTaV3PSOKaf609q+BcSDjXOJK?=
 =?us-ascii?Q?bBv6T3Cm+IAuDP+v+3M6zezY/S1Jdgbmd+TQ8C5G77GO2iK+FgEzLxU8U1Qp?=
 =?us-ascii?Q?kPpBBcGiBSnrEJid422H7YTjfbNKoizAqkzoHtFa2IYUs1kdbSMNnSlA+q8j?=
 =?us-ascii?Q?wHRYK5QqDlO/vifcGPM7esvpDKiwU+DVOCZujgbAfODDUl9sOyQpXY8Tho3U?=
 =?us-ascii?Q?4F+Om+se/lyQEq26DJg0JJ4Ap84al1dOux4osm120RDxV86JzQXet7YwHXqy?=
 =?us-ascii?Q?Qofpn3vtEnzEYP0DnoaurcUWjTcyYann5U1SWzdk2rbIbZ46QNowbyzxL9xR?=
 =?us-ascii?Q?Rfv9fsnvD7qEOT1tknGrljeNfRyJvOCTL47+4Ds/ok8MBtfWfQu69riHYCFV?=
 =?us-ascii?Q?21Y9dOvN/WwvfF5GeaySi3dLlJo0+6r7DpIS6VtQMr7j8IVkIJwOq4nA1sTU?=
 =?us-ascii?Q?itD02Z3AJBk5ahs+zseLy63hniXm9HPTumsQJn3tRB585RJKsA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GDyoHrXYI8xV97cu2+LyQgrVBTphXlLnt2ZTVgycJkHR2tjho+jAo0F/9j8O?=
 =?us-ascii?Q?H+9p1mBnadeEoEuAFb2AUkgRpZVcJ2FY5uaFXJZK9mTrj/goH41il2R+YrW5?=
 =?us-ascii?Q?z0RYGZauF2CjsH1YrDUjuy3OR+6Wv3oODXUiUJmR4i4oOF2twcxZc73Qm60H?=
 =?us-ascii?Q?wHc3xdqVu/os2cvnDZqkPbrgYuFB+nsWFaH7P+1wkyzL3WaZmL2JPoxsxBIM?=
 =?us-ascii?Q?H0zJQl3hZU3c6AGUceEyMLbepEv2irL5Tisqach6uL1IWvb9Q84C9Q7Zq3xV?=
 =?us-ascii?Q?w1g+ZjQcXPXo36jF981LrDY827vGd5RHvv2d9BACq8+Mu/U/TMxxPNVv+SZ8?=
 =?us-ascii?Q?QLtzEVLnKs6LOPaZW/GqPtLXtRzGPMf9i0FkoP1t2UgtWzSniXYqGOWmiTIR?=
 =?us-ascii?Q?aPf1oWwAOQlZX5o4d62zx7blEIQP1E9XYA3x481cqdyd2IAg256rb+QN1/my?=
 =?us-ascii?Q?KPl4iMIvoaDaqJHpD+eg2Mh1sm9GftO+x9ZJJbRB42IXEkJlf2p2y94zCaw6?=
 =?us-ascii?Q?ctke0TKYBehEGPnSqp0qUpbc7CFHj457DlAXNOH2AeCblqdolkI4xZC3yai4?=
 =?us-ascii?Q?3x9LJF9MQFL+ikVrtIWr5S6M2Gz2J378MIgnb0vBiBlsQ1WsFoa5Z768ufsh?=
 =?us-ascii?Q?6y3UoREakki+HKzlRwm/P7s8arZJ4Q2PtxmH7V1P3t1W/ctiLnZAm8WVj8IY?=
 =?us-ascii?Q?KXCW4mnA1tZt+1yjDaBdzld6bPHo/C0IP1QXC9PoxfU/yjCP2B5ZtaR0PaHA?=
 =?us-ascii?Q?feIYjfLyHQuJBe3/MdeP7esdOmuZjMWPo6RTBjTB2nx8wEOAvb0YnpxY4rO4?=
 =?us-ascii?Q?HqmoSLIt/mfyWz37Y1LyMdSMsjwhjPwLNJ4CdFMH9bCcaFs/1v7BnjC13S4w?=
 =?us-ascii?Q?XG3l7kxWS1vGPXAuR5Z61WxNuhB71+I6sd/hTakMTOldh3UvAol9qj2ppgn6?=
 =?us-ascii?Q?VMghf4wQ4lE83iQWiyMe1gmp1S2ngxo0jcuG7ek1ZRfkepkuPeqF7KZTdv5/?=
 =?us-ascii?Q?qmcSaKshvyAz/qFVdrhKmxXv7Fld8MtmK4namOXMAkyAHGmOLL2f9P1k9/ux?=
 =?us-ascii?Q?86J4Lc/WWB5WO6Oh0uU+KsgsiFL+LmMx8PnLhpu3gEd+B2rHaeiDV56jKGCx?=
 =?us-ascii?Q?jGHoIrB9j9JbGkjDE40OCV0GwSYUkw3Tk48NCgassKqNdRpG0auUs3BmZ4ea?=
 =?us-ascii?Q?JkwbtHDOvTfUO/9wM4VBJHx4MYeI4p8OUrn/k1pxbhgyCWLNT551kzOE6RXN?=
 =?us-ascii?Q?QXHE7rTw/J8/z3IejGbHHY4msNEgaAMzm6yhY5Z2KyyTk/8Gy+5R3RXtwRU6?=
 =?us-ascii?Q?vj9BERpy0eV1mxRlDP+9xYxVPKPgHwKnJXzZQfmisv/jzDdqAgzO9xiTBbDJ?=
 =?us-ascii?Q?CJJWzleUbTfQSR6AyWeB/yblnqKornhHGbpmPSSoYCR8C55VWqOUnGzfD2hV?=
 =?us-ascii?Q?0ovLxZT7lVGT7xiDNYxDB6Kj3SvoM6SyiqUt/5MXG0OAcyL14qUJYajRe9/7?=
 =?us-ascii?Q?s79XjCBCebUwYqluwSeOadrQg922AU3B829ulVojHacHtb7MVI56Y434CpTh?=
 =?us-ascii?Q?yVRL03lMHkYAcLK1EUM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb723345-5c1f-494e-ef20-08dca0b7e946
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 08:11:33.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZKd0tBdTFdXv1WjkG63CK1XiDI3n8vFVjR1csYSkLRvHRwD4eXcmIXc2s5zvEB7FZHtp9Q8WyCqmfXD42R2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7151

> Subject: Re: [PATCH] test/vsock: add install target
>=20
> On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
> >From: Peng Fan <peng.fan@nxp.com>
> >
> >Add install target for vsock to make Yocto easy to install the images.
> >
> >Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >---
> > tools/testing/vsock/Makefile | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >
> >diff --git a/tools/testing/vsock/Makefile
> >b/tools/testing/vsock/Makefile index a7f56a09ca9f..5c8442fa9460
> 100644
> >--- a/tools/testing/vsock/Makefile
> >+++ b/tools/testing/vsock/Makefile
> >@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o
> msg_zerocopy_common.o
> > vsock_uring_test: LDLIBS =3D -luring
> > vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
> >msg_zerocopy_common.o
> >
> >+VSOCK_INSTALL_PATH ?=3D $(abspath .)
> >+# Avoid changing the rest of the logic here and lib.mk.
> >+INSTALL_PATH :=3D $(VSOCK_INSTALL_PATH)
> >+
> > CFLAGS +=3D -g -O2 -Werror -Wall -I. -I../../include
> > -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow
> > -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -
> D_GNU_SOURCE
> > .PHONY: all test clean
> > clean:
> > 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
> vsock_uring_test
> > -include *.d
> >+
> >+install: all
> >+	@# Ask all targets to install their files
> >+	mkdir -p $(INSTALL_PATH)/vsock
>=20
> why using the "vsock" subdir?
>=20
> IIUC you were inspired by selftests/Makefile, but it installs under
> $(INSTALL_PATH)/kselftest/ the scripts used by the main one
> `run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
> So in this case I would install everything in $(INSTALL_PATH).
>=20
> WDYT?

I agree.

>=20
> >+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
> >+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
> >+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
> >+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/
>=20
> Also from selftests/Makefile, what about using the ifdef instead of
> using $(abspath .) as default place?
>=20
> I mean this:
>=20
> install: all
> ifdef INSTALL_PATH
>    ...
> else
> 	$(error Error: set INSTALL_PATH to use install) endif

Is the following looks good to you?

# Avoid conflict with INSTALL_PATH set by the main Makefile                =
                        =20
VSOCK_INSTALL_PATH ?=3D                                                    =
                          =20
INSTALL_PATH :=3D $(VSOCK_INSTALL_PATH)                                    =
                          =20
                                                                           =
                        =20
install: all                                                               =
                        =20
ifdef INSTALL_PATH                                                         =
                        =20
        mkdir -p $(INSTALL_PATH)                                           =
                        =20
        install -m 744 vsock_test $(INSTALL_PATH)                          =
                        =20
        install -m 744 vsock_perf $(INSTALL_PATH)                          =
                        =20
        install -m 744 vsock_diag_test $(INSTALL_PATH)                     =
                        =20
        install -m 744 vsock_uring_test $(INSTALL_PATH)                    =
                        =20
else                                                                       =
                        =20
        $(error Error: set INSTALL_PATH to use install)                    =
                        =20
Endif

Thanks,
Peng.
>=20
> Thanks,
> Stefano


