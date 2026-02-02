Return-Path: <netdev+bounces-255781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPRlK/FkgGml7gIAu9opvQ
	(envelope-from <netdev+bounces-255781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:48:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E8C9CDA
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 341BF30097E9
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250E29993E;
	Mon,  2 Feb 2026 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.abb.com header.i=@de.abb.com header.b="DqGHI0BA"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2D2765DC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022052; cv=fail; b=jmaUOV2faNTkA/Aj+OZxWHfVYnegEePqRXZ+juWnjxEy/wZXDOibhMcIzZh4epU2Yg+PeyEKMpOCwLQ95h2arkpXdykKxZQ5dGEs+tywG1BvUU2Qk+YhMRoXr349nQlIcOBwAsWFh4fG0ccBwEsDoU8m7CQkkzPRxuUMtyhgSeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022052; c=relaxed/simple;
	bh=ME9CYhodmEACP62QDo9gAfaXzPRlnDHgmVVIk1C7hbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twOSIQjHmTkVgJdVtjY+QkVMGJtO37EWjzti7umkb1Yl/FguGIcLc6M3jcTV/Io27ztctWlCQ8cjceCNg58ShUVnnR3eIdlga5KoUdSA+UpYoUTg8xcev2hQAjiAV97i8MFF2t5po3PnFhL6fFYpsSbi7GdO3X7rugRUhmGU1Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.abb.com; spf=pass smtp.mailfrom=de.abb.com; dkim=pass (2048-bit key) header.d=de.abb.com header.i=@de.abb.com header.b=DqGHI0BA; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.abb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.abb.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLYQXVvNpS6UhObE1URumRElqRbd7j/XoIEiaMVuV8DPZr3Om7hAzpAdh1l606BDNWmsvLXH33TpCJxy7r1eD0b02sXXyo+PdmN3Yovrwlf4D60+Ak7Co+FCY1t3J0TqHa2ZdhZj+UueIHOh32SMksjO8AazK2vlCOt1+4yinIZGYv+0pzvCvZo8kvx7zppVNTzZm3CycWZETHHQWQk3aCGL2yYTFL98XOhTG/zUmV3CpyJL7WDIabGKERbEBi095Rgm9GgnnXX+tfnmYZzJ/o7OrNVz6Rqx4vj916/sJFZ9hMoTd69t6rltqHLHexY8vDwOfXOUuMx1DvLyGlyHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxf6IDcvd3jZWGRJ3jo5T96I3VrNPQFoa1Nd4JRP3GE=;
 b=fXntfXEzrxj9QFOYuWzcXl5MRVr8w5EBBmb9aC1gwLCskXh4lpQMNboJLbm2PF9ykHbxNCDGWGQ+vi+UT4hhgdj7hujc18dvDrSBSwqFyDTDyoo9mal1S43VBwB5yt06LnjAPHDMX2sAYCaC6PfFlwFashf70cLIjAzKXLdthJsR2A9xwuS4Klh5oCj2IlLVu0LFgsL6/t3hZSi4L7HCng1cg2gK8jGOADG2GHfNIL5blHDe5v+56pJuCVNMW9nyzUdSSumA6ZrzF07aEVRcWysG38M3GLR3K7ekixf4nicVBJKOcN1v81aAhp+5ejPC9p6pku/xtorERvAlYHIJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.abb.com; dmarc=pass action=none header.from=de.abb.com;
 dkim=pass header.d=de.abb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.abb.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxf6IDcvd3jZWGRJ3jo5T96I3VrNPQFoa1Nd4JRP3GE=;
 b=DqGHI0BACCDLjPZZ2K6ed+88x0Xn1blpqeFIX9wZ1GNZrjGkS3RiMILj05ri3UTM5sEJiWRS4LIc+5FasMUi03vAM70ZqLv+TDWHoIaLkVXYU2W8N949vn+phHDaKNTIharfP5yYMZ68VESuygxJl1UOo/LyU2BPVVbAMfc9F5a5pZa39J9+REVIkPd1L5It6JNnwRToGP63eThpE6dD3GarFYu30LRSPul/X+jCFkKPOpU2CSyi5uo5z9ABmVhHORUly48OEHmejE+UdZr6iexDqdPLPSVXfraRxe0tXWtOwh97DrpJKyP3BF6bg+y/+5AM+lQ7UCaQR6x+OmwhCw==
Received: from DB8PR06MB6538.eurprd06.prod.outlook.com (2603:10a6:10:127::16)
 by DB8PR06MB6363.eurprd06.prod.outlook.com (2603:10a6:10:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 08:47:27 +0000
Received: from DB8PR06MB6538.eurprd06.prod.outlook.com
 ([fe80::c8bb:bfca:40bc:516d]) by DB8PR06MB6538.eurprd06.prod.outlook.com
 ([fe80::c8bb:bfca:40bc:516d%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:47:27 +0000
From: Steffen Lindner <steffen.lindner@de.abb.com>
To: Felix Maurer <fmaurer@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "jkarrenpalo@gmail.com" <jkarrenpalo@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org"
	<mingo@kernel.org>, "allison.henderson@oracle.com"
	<allison.henderson@oracle.com>, "petrm@nvidia.com" <petrm@nvidia.com>,
	"antonio@openvpn.net" <antonio@openvpn.net>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Thread-Topic: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Thread-Index: AQHci6989OcVQxjQgEKGlQf4akOA77VvJ08h
Date: Mon, 2 Feb 2026 08:47:27 +0000
Message-ID:
 <DB8PR06MB653870262ABA5E6752871B72CA9AA@DB8PR06MB6538.eurprd06.prod.outlook.com>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
In-Reply-To:
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2026-02-02T08:47:27.213Z;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard;
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.abb.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6538:EE_|DB8PR06MB6363:EE_
x-ms-office365-filtering-correlation-id: 0dc2978c-97ef-4225-982b-08de6237b1a2
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bKRoxkXgtyoVpeJQ3uAawywiubs2mS3KT3SQsVE+CVTENP/zGNdeQFxL1z?=
 =?iso-8859-1?Q?S4rIA9e2pOA7OtmEnbSaxnLu7+DpMavS5MEMCRGX7lJiBv6nxVBMV9hL0f?=
 =?iso-8859-1?Q?av13eGr7Er4TD2n6zxpz2uKYYdQB2yi3HwCSTzf1xPo1GaHx1zQJFPLrUZ?=
 =?iso-8859-1?Q?LsKyFS5zIM9IhBK4L7eOnKIrfOhiCoG1m7BTGxF5U/BnYrD4Y0IJX6GYI5?=
 =?iso-8859-1?Q?7BhImwoQPx9I8FwMLCALr6WA9z1LoG/tAAto4FTDd9ClK6U2ZXbUTJ9wCO?=
 =?iso-8859-1?Q?bXDH1iVhgs5lXA9Pd4kYithgKDA3vS2VFL9krcwx4BLHZupSSFDjzLtSec?=
 =?iso-8859-1?Q?ZVTN+2QZb499ffhBeVO1YXLuwEUUwXuvw1J+WwWdlhc2TfPwDN/5nZNQO9?=
 =?iso-8859-1?Q?Cpdwcu+C2srpY4936VTmQo+hJtN9dGWr5Kg/3pWkX6gpok1QTkWnzEYGqz?=
 =?iso-8859-1?Q?7p+6fVf8SLwceP2UACJXfmmrtZLwCU4xjymimy+/cSXvZpJhI3tCglyEmS?=
 =?iso-8859-1?Q?ezN+t4dO9htdWUi+ZdxwTkI769mWApcVykbZEA6i9QeietUUM8PkJgZyVJ?=
 =?iso-8859-1?Q?VVKPb/bLh+bnRJ9GUHz+UeIUObRjwR2oZpV/6jziq6nxbCfoP4+YL0tMXW?=
 =?iso-8859-1?Q?NlcO/vhbAgu8/7F2fnTCk2FWRmrK0TgcRelEOByLKuhYgIzdTV9QT26U+w?=
 =?iso-8859-1?Q?HIh9RhTEBttLLjpeCqa1mwuHWcn8/Tz/rygBqcfwsD6Y9Z3QsWgmqZlaxJ?=
 =?iso-8859-1?Q?QtUecMofVMmD2yqAyVFo7zqRE+uKvxKe8AdT359OfTTXNiEEc6b4j1J2kP?=
 =?iso-8859-1?Q?ySi0goZ1hTZR32Q3FWkBDDtA0JaE1WbfnVW4odPkZr+dM/VZE52MhDFaxD?=
 =?iso-8859-1?Q?JZ7Hsjotjj3PfvyFQ8I4z2XQ4BRscPBhEMT2a0fxykEQdS0m9xEyZjbczI?=
 =?iso-8859-1?Q?rXmlgXAsvft4f398Y56GpLuZoL9d2UPeR0JgB6J04wMaS0vWHNiTXLkxUd?=
 =?iso-8859-1?Q?1k007ZaVedZvCjdK2bIZYn5CLxDcjnzSgt6AqeYMddjtLh4gl/7fd3XsG9?=
 =?iso-8859-1?Q?AU+Uk6cyqwMw+8KxzrL+Oq09xWWPuiygjAMGskyX+QUrjFpsqn/Xpg5R18?=
 =?iso-8859-1?Q?z1d85qmAvwPCQdc+TrQ9ULcWyV2RvPltTrQYvl8JEDEvQ5ibmWLi13KRjp?=
 =?iso-8859-1?Q?cKQh6FneKpAatWZwUizKKTEhH3KzadiAuRuH046triTMTXYRcE+qlLpd1z?=
 =?iso-8859-1?Q?COim7NgcsmYecdxLx0dbZ3L5i4C9O0H+JOfEl2gx7SIrk7L66oCBeeM553?=
 =?iso-8859-1?Q?wPEN7LSbFhCSGbcyAaS3b1NzuvxU7aNkn2znLfw9v/p6/MEQJ6ATqFvq4b?=
 =?iso-8859-1?Q?4tpCEBYi+djmHL2FR14dLuDvAXwFo2iOBW37WfsoE3jF3crlXCgpHrE3uE?=
 =?iso-8859-1?Q?/0tAW4HZdxChffE1TTW4m6USyHitrlf0rJI+Ce4qLsPpTHH6MWl4ZbaToG?=
 =?iso-8859-1?Q?z/oJeKQbA5DMX5JFo/myfjItITnJs89SdpSHHV9BDxLqjBeSLtlgNpqjFq?=
 =?iso-8859-1?Q?XR2V3IiOlCN8cr2d407VlfOw5+3Aj9Su8Db1QkZzJPsJxq/BsqH6N6duAW?=
 =?iso-8859-1?Q?CIHqv1IZ5FcX1GYLEXs0PKkl/u7/RiieG1b3nNMgdDqJT4RkSlRcd6cHkG?=
 =?iso-8859-1?Q?W+x/9k6LcEm9u8vCwB0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6538.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0Xa5kQNYiX6sexzMZW4u8GXweD7kR6vO2QDCCgH4+BMSkcg6yE3KtXmKIT?=
 =?iso-8859-1?Q?wpqmgmiCVAbOAzIesJfUuke79Mx5uo8288GcMnSF7KiccVq1zwAizyjaU6?=
 =?iso-8859-1?Q?eyaj/4eqDPJlhAP0lVuijQfK6jo77QmDzYnbtpAhqEdEjEHaHaO5vyrMUH?=
 =?iso-8859-1?Q?bo5C+L3LRxqQjC9mc7TNpAbig/I4dsCqfSmrxvM4Zx/F5N9NlJxzNnV6HQ?=
 =?iso-8859-1?Q?Q8jQJu4njDOoE30ABkOLGitvCuViAdVuOFxf4spclkZoa0eB+sX84y803B?=
 =?iso-8859-1?Q?/UPkX7NyIugS6653dAZhqMZZ1SuFqFqz2bdGgWYYRcvn77HLqYKMhu+XF8?=
 =?iso-8859-1?Q?923Rf8kzeYFX3/oIb60s2W3Fi/Rmx/RkghvKcJyuHt2mQMO2UvyH3CK4Zz?=
 =?iso-8859-1?Q?aJFfwFrJ086KmTwZYWEwxCIKoxa7Zyz7I7kFdzj1sdGIzSJ1VoUvVRh/1R?=
 =?iso-8859-1?Q?mm19bUPrTffna2crPiwF2OqXJjEwWNODr0Nv2n3dU053VoPgaUVo4Ydzfu?=
 =?iso-8859-1?Q?9EoWYI1ymQaF2nhFWNoGhmhVdRgajIfgq9Mw3BLEMmnp/EJyI42L1MVR+0?=
 =?iso-8859-1?Q?5tQoccrGWVnNBrEgZEYChSji7foB2BClSpUXs5fdU6YI7+SKIB0bmEf1jb?=
 =?iso-8859-1?Q?yiKznAf/5TgI+0ugni1O7xQn6o9SNkpHKq/fg1m+lFOwvzr+IBDeVirD4Q?=
 =?iso-8859-1?Q?UtM+jl+Lo32wxJ9yYjnptWDdMPVvwAn4B//Kh3aH2cey+479MOaqEJYmfA?=
 =?iso-8859-1?Q?NNucxdXvI1gbWd0yye5/vzi7Yu9nUfebvY12/NvkNyraK5Y41WZRiViCPO?=
 =?iso-8859-1?Q?eSy/zUk43FqLn5DM+7pc4ci2TEpARq6Siqbr0XTEdAEdc1ayKmYpxbJpLV?=
 =?iso-8859-1?Q?EDMVdW6aX+ekJVtwVtFDslmeJrXz7hhEsZNx/c8roBm5JFBgJY62mn1Oat?=
 =?iso-8859-1?Q?qFVzb/QjC+p6oGLswIsGaE+4jJ1UPfqQK5DrReokp74LoQtTmSNvDwiIdn?=
 =?iso-8859-1?Q?vzVjTakqbNcoIe/NIa2A76FPqVNEp7c8pVnZx57BlpBmhD4uK53xC31gfB?=
 =?iso-8859-1?Q?UKXObEA50T5zXeo/CpAp3wBx5gIk2NP+TGU586QBCpPXlnuy/c/nS0HLz6?=
 =?iso-8859-1?Q?pNOg+KkRm1LlYzrpGzJdk+KGhY6EIfyn8jZcMw9hIQluJK5Di0vqoXX1pS?=
 =?iso-8859-1?Q?3meOhe/tl+Gr3JG+oBOwSV1r0/PATW/C5mTIhYVez/aIF8SIVfmNNJ7uLo?=
 =?iso-8859-1?Q?pSZ2aCbuwJsvHuzMfoH5mvedpTQkWTFd1AM8/f1vYOCVuEkkyT+HZl2dQn?=
 =?iso-8859-1?Q?1f9jNGqS5fU9CxnFRjdZ/0P/vYn7f/aQwuqiNQVgIyNqTjEXyr2cvE5Ewt?=
 =?iso-8859-1?Q?t6nTw/HM9cw5fkKMafSzkoNmucQRT1CbDpel7Qv36Ava49tWuJoV6Kxt5m?=
 =?iso-8859-1?Q?sMZb4YYo8NXVQFNJxgI15Z5x4Ak750xZoDmFjAFdPJ6FGkTpEbdnRFthMS?=
 =?iso-8859-1?Q?hEQCEMKkT3oxosW/8jOY5xOVIWgY+Q9OfNxFPRcT7YEUlJs1MSq160NEGo?=
 =?iso-8859-1?Q?Pkt9PdArXSzPSTDaG78mI9NT6CWmXgi4lHV4Vb1GclnAIKvYNhikaVI8NQ?=
 =?iso-8859-1?Q?3Bd/S+DDrWs1mwxj4ATiWtPidtaXt1jC8UY60iqssrlAPO32pSoutAe2IX?=
 =?iso-8859-1?Q?89pLw6ryZZiqWTVleth0SC74+M2YuHf0HNnSERGitdsyQPP/eQVp9ba1EY?=
 =?iso-8859-1?Q?6BMtWVCofe+TFmSoN3aRONVPIXWGyToVXvcOkMWEHZEKvOq7In7mzUmebZ?=
 =?iso-8859-1?Q?8JPO8m066cccq6jVm6rRZoSX256KTZIb0RA5jclUWWOYGWF3xcH6V+6JKQ?=
 =?iso-8859-1?Q?py?=
x-ms-exchange-antispam-messagedata-1: DNT5E82807acJg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.abb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6538.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc2978c-97ef-4225-982b-08de6237b1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 08:47:27.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZcbzSOfRT2GvbMpLwcG1G5ervpk5mu7w93VMNbzow6I7vrbCTDKpTBsATqZNv46z+raPQtWaKCMqCczX3gntkIJlsgaKvP7W0XeObNT06g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6363
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[de.abb.com,reject];
	R_DKIM_ALLOW(-0.20)[de.abb.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	TAGGED_FROM(0.00)[bounces-255781-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[de.abb.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.lindner@de.abb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0E1E8C9CDA
X-Rspamd-Action: no action

From: Felix Maurer <fmaurer@redhat.com>=0A=
Sent: Thursday, January 22, 2026 3:56 PM=0A=
To: netdev@vger.kernel.org=0A=
Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redha=
t.com; horms@kernel.org; jkarrenpalo@gmail.com; tglx@linutronix.de; mingo@k=
ernel.org; allison.henderson@oracle.com; petrm@nvidia.com; antonio@openvpn.=
net; bigeasy@linutronix.de; Steffen Lindner=0A=
Subject: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate disca=
rd for PRP=0A=
=0A=
Hi Felix,=0A=
=0A=
> The idea of the new algorithm is to store the seen sequence numbers in a=
=0A=
> bitmap. To keep the size of the bitmap in control, we store it as a "spar=
se=0A=
> bitmap" where the bitmap is split into blocks and not all blocks exist at=
=0A=
> the same time. The sparse bitmap is implemented using an xarray that keep=
s=0A=
> the references to the individual blocks and a backing ring buffer that=0A=
> stores the actual blocks. New blocks are initialized in the buffer and=0A=
> added to the xarray as needed when new frames arrive. Existing blocks are=
=0A=
> removed in two conditions:=0A=
> 1. The block found for an arriving sequence number is old and therefore n=
ot=0A=
>    relevant to the duplicate discard algorithm anymore, i.e., it has been=
=0A=
>    added more than the entry forget time ago. In this case, the block is=
=0A=
>    removed from the xarray and marked as forgotten (by setting its=0A=
>    timestamp to 0).=0A=
> 2. Space is needed in the ring buffer for a new block. In this case, the=
=0A=
>    block is removed from the xarray, if it hasn't already been forgotten=
=0A=
>    (by 1.). Afterwards, the new block is initialized in its place.=0A=
>=0A=
> This has the nice property that we can reliably track sequence numbers on=
=0A=
> low traffic situations (where they expire based on their timestamp) and=
=0A=
> more quickly forget sequence numbers in high traffic situations before th=
ey=0A=
> potentially wrap over and repeat before they are expired.=0A=
=0A=
We tested the provided patches based on our bug-report. The patches=0A=
significantly reduce the end-to-end packet loss in different network=0A=
scenarios compared to the existing PRP implementation.=0A=
=0A=
Tested-by: Steffen Lindner <steffen.lindner@de.abb.com>=

