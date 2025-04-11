Return-Path: <netdev+bounces-181540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EC7A855EA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7074A4A8C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E4E290BCF;
	Fri, 11 Apr 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="id69kXJo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C01E7C0E;
	Fri, 11 Apr 2025 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358066; cv=fail; b=q+i4uY0NwmZ0KQRIQkbN6YFj0JLZ1UFv/NpPkVeYWo2WSG/vKgH1iVD9Ag1bvJqWLlTXE3QyFhUAgxcLDfCaVAENQznMgHLA8aDLv2hYaHjDIxAY4E0Pny+/7bBHxNm9EYyqheXm1nLcvb17DUzPxjwO/AJnEiK6TJIJYLePfT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358066; c=relaxed/simple;
	bh=bOq5ku8PltudUCSw1jfioKWzfCCC+lA7l95rWuPcIg8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WVw82in/UNJIN/TsxbFBTyg9N1DNHY9PikgEzNM60Cf8P+bEwUV2E1FFdf3e2LgGmsnazjbaJlLKP2pDWLPr7Cd7NlruR7D0x/Kr3ysSjG3iA1TpiysfBFec/S/56F7MvmHgWfRZgx9Ln/5ZHJY3H124yxU666ZAtmSe3fBDevw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=id69kXJo; arc=fail smtp.client-ip=40.107.247.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncsR4a4m2VUy854BVopJX4i3b75kYqcUFXwRevv+X7CCJj25SqGOyrP6HEnmDzhh/agW4vSVMsuIb0U6mcrrUTjXa2Cs2BAluiWN93SeWpowTZdveeWgALO0Wk+XKc5X7UkZ1nwNliBDjPauaqOh1k7ALKVBsaK0dflmZjbXJB/nIZ/zex20DJVfL3b0cvbHG34BTKIn55YJqTlfNG3cg9LQ+9NAbKR8S2W/kW9x5tZc9ev88LCvFoWV81ny62J5iIBkTHdbqXvssZMDih6nC5hVGVxNl7uuZkIg08qa1QTPJ4WOd+38oDiKDrMSS5X9QUjUYJNMaZX9vvSKkHwLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOq5ku8PltudUCSw1jfioKWzfCCC+lA7l95rWuPcIg8=;
 b=cqLLyrXs8VyNwjvm24zDl8PmthI8OGzoI6zEoxcWpTkwaPeJSIoO3kxDqN+x+cSkovjlCUb+v/pQpuUNPw1wkhLvAWOomzJvVsKrktowGl1dUwZUDTsluPcJGgmCFIisHpign+oQiNVrPeGanfA27dAt+KxZhUJyqr2tpkncL8lbLxfse2tduTF15QgZSezfx8HZhJb/CtqoHTwE5QObBq+VdA0Vfz18JaiDHNK7NYVStXlzE8hyKiTTJLDAQWzmB/x7KiiSjlhpeqjeER9L0nDuRt+4+UM8/z/g+WvVN3f/QN+SG2l2dFdUjToQq5gffbb68fesVNdlUfyVsEiC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOq5ku8PltudUCSw1jfioKWzfCCC+lA7l95rWuPcIg8=;
 b=id69kXJoqTSn0TlANfoHiQ1M55hxBLlp6/S1FC2Cef0MBm5m+5TO+dqoRFNwol9pPpSWdpXPn+gmD/0bqYsRXdJHQeMvEy55icYejga+QLxG1nm6HbNCmiabYAJiiVW3GfBR6bhZ5PnMcDeR05/QGOl+s9VO+64iNeg1TVi62DSVFzqe7wOvCdyzoS9vjEzLDtylYZa3CF/AGDj5fETiP8mcdUxnQ5851rm7iUgifHEWuspdPbQUczwXHsY/JDzWuFDMIz+/UONHG7Z6+m+41d9ZZUQUc0qKuSfT3Qj66E92Pnl/t9XX8QkLtXH2ut5WXBzBf6HalSZHkSvQS6YGHw==
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:290::22)
 by PA4P189MB1312.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:ce::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 07:54:21 +0000
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4]) by PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4%4]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 07:54:21 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>, Kevin Paul Reddy Janagari
	<kevinpaul468@gmail.com>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] Removing deprecated strncpy()
Thread-Topic: [PATCH net-next] Removing deprecated strncpy()
Thread-Index: AQHbqqg2fKRPQg2KPEqrm5rJStmyB7OeEwbAgAAD7aA=
Date: Fri, 11 Apr 2025 07:54:21 +0000
Message-ID:
 <PRAP189MB1897261C37B1E27196F2188BC6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
References: <20250411060754.11955-1-kevinpaul468@gmail.com>
 <PRAP189MB1897052C5306AC237EE5154CC6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
In-Reply-To:
 <PRAP189MB1897052C5306AC237EE5154CC6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP189MB1897:EE_|PA4P189MB1312:EE_
x-ms-office365-filtering-correlation-id: b2c7c314-0a18-4bdd-ce80-08dd78ce11d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jrguiCsdrUVUsVhmf+z1mwNJluVWT2HWzioJk1H321wqb+9JXTcrtiYzEu3E?=
 =?us-ascii?Q?Giw/xxSeHecZ85hbhqtmZlXWbuqSvY085eDC2//O5Kmh5rMHI3kkj8lSgGNt?=
 =?us-ascii?Q?g9v50UFTWOTSxLUNV6/JsmIoRdF3Ud5LBSWAo0vOQIMwtqnpH7bKABCl902o?=
 =?us-ascii?Q?ioDvIBbus3Je9fKnI1jWlkUp4U2HXA8eALTFTTHKT2Kks0Nf30CRCD3nHikc?=
 =?us-ascii?Q?zeSyGlZ+oGO/wyz3NKvJdIamUG0vWVWttrTO+gAAFM9QHx/bjpkhUylbMT4v?=
 =?us-ascii?Q?mf4tAxTdu73JnBG+0vLSpbtToh3yJqtRFvCk4z1VnslsQ0QssrQt2gVEjrzg?=
 =?us-ascii?Q?0gEBOnul/BKdkLttA9A8c1c+sjg/lHU2jU/p5KzVYp5TBZtqjPE5Plwt8gkv?=
 =?us-ascii?Q?oZQghCslcxgvApOZZNG8fHw+/5Fxsfu3j87ghZUEAQ9nfXKLqhX38e71/Hyy?=
 =?us-ascii?Q?noqbIQAKnztGWXJjEGuPcgIExvylMI5ecBiKwT65w6fJVj+jQXCpR9BEluXs?=
 =?us-ascii?Q?GJq96/yC8ACR/hvAkISU4roOLyzKM7vta6bhdGLvUgQq/8rHhhutMYJisR5r?=
 =?us-ascii?Q?tcxHzXpcCeJ2Sf653xahWcWqVNERxKUEltTq99vl/XPw2BDny+Wo2E0CZvDh?=
 =?us-ascii?Q?CeV1S+NcjkNa1ogXIKO0ajtocrhRQdmeLqE97tiDctVyNdYc1XWSE7bHoNiu?=
 =?us-ascii?Q?SXauwyi2Uo31xS24A/16w2JMQz2uBxU36jD11g7rir5tKcGv6ClJf2ko0EGL?=
 =?us-ascii?Q?kIBra6bMpQmPWFXeDG5uauSRP23nvYGLjNKQI0VXdeuQtY2GTnKr5p1Kk5TZ?=
 =?us-ascii?Q?KYpyY1J7JT0NKaYIbeCK9XFRSeecCEW+Mrlcl1yoLThERCUczyO2JibcLi/x?=
 =?us-ascii?Q?7z3AmchlnuyN1KNjJHZ/VHYT3kNU5s7a/w4I+2rWGiVSKrxRtDnb+h5oRqel?=
 =?us-ascii?Q?IzZL8T1xkNiKAqdHv2JiKGS7efu72ejsC76saLYSlWwcZlM+qWeoPMQ/QMOn?=
 =?us-ascii?Q?JMCQphFL55tsgBJnlsNJ1/4Bb98ss7gj2EtfRdCJQNReyiCJGDAztgFQiBfB?=
 =?us-ascii?Q?RCFqHaEpukDpOUaMfk8pXp/W3PImgG5F4hEuvNTclxo8FA+Bj0lQPyvqtTvr?=
 =?us-ascii?Q?k5fKudzWUWpNO0VMkefcGNdBacMJ1+4nQq8AiMjWBni1HTwS8bRJOJA1KM05?=
 =?us-ascii?Q?p3qogPeKgxdMquPMvRGdr3yEYr9LYF4fsP1qoWQ2Pmdwnw0MVMiDLZ3VmZCK?=
 =?us-ascii?Q?vUE5OfNbblCSmwdk+3ysk2zjqihIKv7aoTb/WGNNm4JK4GWr3mAWEjTylnka?=
 =?us-ascii?Q?tgvTf2X4l/DpPY53AaqYlwMlsxusZ4NBl/Bld8/52sZmS+Xb8n34FCoEqG9v?=
 =?us-ascii?Q?ToE94zs8T32KUR4qy1um8gYdr1xjHxBlm7EV8PE3NlLCVjfwYLru7QzzmShV?=
 =?us-ascii?Q?8ndtupA/bNdcXmt4EbmUjeQkzkNyDd3b6Sd0HQSh4wNL3rHMHGC/riyRSg+k?=
 =?us-ascii?Q?F96mGvnYyfEaAGI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1897.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VsW+WD1ERSaFtixZPFWJlGQlP1OHhm389D9o9IL4a6/21G6vDQq9aorjVKtV?=
 =?us-ascii?Q?qmYnE0ss/w6EM6xOgJmJF5VX/E3XJRi313pRWtEXK0C4UHonA9Oap4U6+X3y?=
 =?us-ascii?Q?hsRx3NL/wV9Dl0Bev3Lig52tbU396hkdPAW+LrS7v77SD0gvodL+sDzyCwnT?=
 =?us-ascii?Q?zNE6B9rcMEKdgtZCB59Yz/ur0BvHKYEtNO0jSAVS99kDflNFE+GvlQmcKIk6?=
 =?us-ascii?Q?EY2R2yCQVidwJS5U5lzQU3BKA4RAFlFIfkEeAYluXivFmetqdnc0XhswZP83?=
 =?us-ascii?Q?845FnM1PpWrxTnqcCtG+Yqa4uIDr7lrRttxGlRpG8WesULZ2hFNPJVXMVfG5?=
 =?us-ascii?Q?wMw37dlTiYqZTMFwRY/syxC4UQ7rbJFtGCq2sqUCOvnWtUBDPVMw+5fhUHD4?=
 =?us-ascii?Q?SCTlRdLrHJsAtjAusjOyazuoxD+2cCspMeKMuALtFiar3jEFRvFcX2hIfEHU?=
 =?us-ascii?Q?cnWgGIoBwlvUgJkq+GdLZePDOZvBG1Vg6u1X/gvqtZakxASJNBgY4qHdwNgR?=
 =?us-ascii?Q?O6tx/eyMTw7NEK298QfZ0irjY9YCDSgsRxl4AVBWe3UI8pgSfzgWD4wI3ppz?=
 =?us-ascii?Q?AOeZTlR44KoG9xnVy50rBHSi1ExEZTs1Spta6Qt05+gL8gi0V0zxbvzyVCTf?=
 =?us-ascii?Q?HH2CsvKRlpFitmh4fgvQakOL41ZWw1hQrM6aLbCFkOjeTx/XyvKNTQCgl6Or?=
 =?us-ascii?Q?4Edh32q7W0DKqOHRJjzEStg46Ooe93+EiJHbDZYtUjnD6US7AVRHUylYpsOK?=
 =?us-ascii?Q?kKLmZoEywOgae9TLvUXpRIDAZwmCa3NYyX0zKNgP04hfXrcKnUWatWv5PZGJ?=
 =?us-ascii?Q?cN6VfI4qUXsDmxJlNVMgNlRQA1Tpzuu5vWLNhnfRm3wfxZLU4oeQ5MrEtYe/?=
 =?us-ascii?Q?jpxS/oxlDQ4GyjFZrky3WolkNqeLJws/8rSO6la5knQJAw2psRgkBUu6rOm0?=
 =?us-ascii?Q?ZjwglVOO5PwnmumJ9IXOpB02mTyNSSyJ+gk6f/j8Mp4dCYSdUuIsA/o40rgR?=
 =?us-ascii?Q?viH+2bkMCedNbUN/P/3LrTQfJWCyjK8eIB9IHSs0qnVcze932USrt7V2aLzj?=
 =?us-ascii?Q?O1Bnw4DKgpdRrqGv1wKtSkzd23DwZ6A1ELF4HbdfF8d0Dy1j3MGMZJks+T4+?=
 =?us-ascii?Q?bV+hCYl+ss3rP+FFWF+kLf/Hw+9APU3K2jitWb7meTP6ghQiz1d3syTXUhcx?=
 =?us-ascii?Q?xUF8xvKS0o7r190ccBaW2PQeHqesvJpDY1Iwp1qhYlNAq7B9JEmvY81XwPax?=
 =?us-ascii?Q?y/QqtVDwlQVJ0bw/FMwnvhSGoC5LqBPBjwaygjkDPGQVu2R3Lw/d463pUs85?=
 =?us-ascii?Q?ERmhQ6Pn4b2yTZU8t+sciH+SP8VoxwXtnSkBZJ8k6rIyTAfpNdmTNT3TM33d?=
 =?us-ascii?Q?bEG+i0Wql3zkcUgl6CvcEPNpiaTlhC7yoiS+1RgGOr1ueEPF1LrHz1fABGaw?=
 =?us-ascii?Q?+oDBQf/KSGC3AMeRRuPuMWsVLQ+xo5O4ANPjqw8Xx6HVHLGTw4ajXJu5fZxG?=
 =?us-ascii?Q?TMn1iw4bsXHfIKQBymB69kVvGhMLnDQ4bI6hKyEoaZ3J3dx+Ng2fNTaIvODc?=
 =?us-ascii?Q?zKZepOsEGvR9+5xxdvfPD6F0QEp1DIMIktLjqhVY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c7c314-0a18-4bdd-ce80-08dd78ce11d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 07:54:21.4077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSmhjo+qM2vszQrfCgfUpyXPNqX4tVi5KCsvS6oxutyzQ7qImERrJOqCq2iCRCwnWSgwwW1viCNv8+WyBG+3CEgRJwdh3vJSrAwqQMgYeEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P189MB1312

>Subject: RE: [PATCH net-next] Removing deprecated strncpy()
>
>>Subject: [PATCH net-next] Removing deprecated strncpy()
>>
>>This patch suggests the replacement of strncpy with strscpy as per
>>Documentation/process/deprecated.
>>The strncpy() fails to guarantee NULL termination, The function adds
>>zero pads which isn't really convenient for short strings as it may
>>cause performance issues.
>>
>>strscpy() is a preferred replacement because it overcomes the
>>limitations of strncpy mentioned above.
>>
>>Compile Tested
>>
>>Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Sorry, one more nit you need to change: Please append "tipc:" to your subje=
ct like this: [PATCH net-next] tipc: Removing deprecated strncpy()

