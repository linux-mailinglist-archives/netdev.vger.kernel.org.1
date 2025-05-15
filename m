Return-Path: <netdev+bounces-190720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D4AB8706
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622353B1B8C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8972989B3;
	Thu, 15 May 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aHMlUOUL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018CF298CA1
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313319; cv=fail; b=BKu+VMRG+7BBEw4UjQ3gg4Tt9thNuaS/0U5i7cMJHTYv1ApCJxfLW+FIqM/qIm7hV7pULL9FvnAw+3Kr0TEALdXXenF0b3fZL+YHftP1z6BYL83HBXQyoyT+eeVEJ82XLyZ+VoccjjFgPXiNEXNKAatqrCYPmVieJBOaY88ZT4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313319; c=relaxed/simple;
	bh=fvO8mPGcsJ9een8P6qTmmYPpQ0M9oOxvgqWmmqNUsog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ciFnpiTVCUDILn7nWhuzYw43I/9yElJWJmS7ct/8puBFCoUai7zh1uf8ZLhm3c5ewK6B3X6AP/N5NJcpYdTirJ4A3f9MCU0zqwacGVeMf+ALtFwquacuoebu9nlS57x/S2BU/xM7GIlV0JYnQmJh4VEQamySl4XbixfjBHr/Rzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aHMlUOUL; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKnnHofE8MBuqIbypVyuhy7hMO+Vw3t8r4jKk7q2CxSjjS6OzAr1kL0OM42C7Q+lW6QRhiTAe0jAL9Z2LYcECb3J2NbEiJWpm5nBev2kR+9UV+EiIlDBfBtuHwOhsOZLQHrMYbsyXBOjqbHid35h0kvQWnAXWDwWRfXtL5DC6DLTAtRuC1Api+WgekDwm2H/qGvyzASuNJTdSctTkmgPYRKsAJdJuYG8Ic8aqo3wnOyZ34jdwRMp83VA5y576uTVuMg3bpcnvly+XI0fsn1lW+D6BFs3QYWVswWuuOExgcAkIIB2Wmvp9xgr5eETXo7+e1Bqr7HvIEr/6D8bdHsi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8gde5lzeTuNskMGNkmxxf0XhTLvVxkGyurci3kzoF4=;
 b=QyXqoBtOvbtwuZVXySasdRJ9SurMlJRIWkudtH2WLhDvNbQpKBMur8Ir8kMUJQb0ZN7UMcATT1miTMv3amFp0gbdq5aLKaZwrBXZ4Qh22VkvN0MUM4sCPVlUd8Sgn3gNasuWAh+2Gtam2cgAi3mIx8IPvfKVjZFrY/a3dvlsMx4hX2uv3qj/GY3eC7qjo584gjpSXxWtAVuaBnTBo+nyEsz3JaPvwoVc35orT3hF09q6SqpNZo85KhCXMTsE5V84QF07jncsbV4olpG0VGrtO1LZk2FQsNIGyE+K+mjRyozG51HFAyX5GesvSiAHyHVYuI19YC4ZTFWoKhol7vY/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8gde5lzeTuNskMGNkmxxf0XhTLvVxkGyurci3kzoF4=;
 b=aHMlUOULy1xFRMSi/tLhLkXef3g2SLe9ZZzFLxtnbAz7+tpci69ZH4/4cJmOx6X9JIuKh2KNP1VZ9hNw/Ht2BY4F9QDeXufMD7sdoXPouB4lo5Om+rlF5ih2ErfCJNTWMz/P/BICMEk2cC8EXK+93XjPpjOWCVf7K0kPYJesITDXPPDHb9MaGvQi+YNqO7AKP//ylfPT8S4Vc8kPGThSa5bUiuB3pZ83KwejS95V3aOCWQTFpemkt+fDWQFe0H+DDz7diMHM2nj3AtvoMl2x5HKcwsmllwvXUS99Bgaj3dhgTMGP5tbzFuIh7Rrnn00uoIEQkFdFJKEyWD4CiVzpqA==
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 12:48:34 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%6]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:48:34 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] ptp: Add sysfs attribute to show clock is safe to open RO
Thread-Topic: [PATCH] ptp: Add sysfs attribute to show clock is safe to open
 RO
Thread-Index: AQHbxN2hVqRGuUR5w0CfZ2fH4oJpG7PSNnwAgAAIsoCAAVXlNA==
Date: Thu, 15 May 2025 12:48:33 +0000
Message-ID:
 <DM4PR12MB85587C371F5C20707BA61FF7BE90A@DM4PR12MB8558.namprd12.prod.outlook.com>
References: <20250514143622.4104588-1-wwasko@nvidia.com>
 <64de5996-1120-4c06-9782-a172e83f9eb3@lunn.ch>
 <c2d4a2ce-8af6-4dda-87e5-2cff14fd14b1@linux.dev>
In-Reply-To: <c2d4a2ce-8af6-4dda-87e5-2cff14fd14b1@linux.dev>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8558:EE_|SA0PR12MB4429:EE_
x-ms-office365-filtering-correlation-id: 507dcfa5-d424-4f4a-f6ed-08dd93aecda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QIGTP+xqj+YU6Y3D6R2nkyxYqZrb9fzHuN3goRFEl1FDu+6vnrF/KMLBSl?=
 =?iso-8859-1?Q?aSOAytVP7yQq6XQQoZDnaXFc7Fl8WGJL3tvfgDeqZ9mxBraVqA0JDuU6fR?=
 =?iso-8859-1?Q?rAhSGe4wSYEUVuXw+f8HjdupBb7Vtf2nEp8THPGeixmjpuvZh7XOimbk2g?=
 =?iso-8859-1?Q?Th8HvsiXZR+e1pEIxhGcwLCKQLk54uXb1KLJhdnyMMzDXOj+xerDgCyUY8?=
 =?iso-8859-1?Q?T9oSfqWueb37aGofV7GG6ybMeFnPTdMNxlJ8XR2Yp9DBazc4QvavqcG7xq?=
 =?iso-8859-1?Q?T2uV7FtYnuAHUYYgPXxcU9oG/ya2vy83pztWBss0dn4Zm+E4TFkDTzxlRg?=
 =?iso-8859-1?Q?j8OINWJrTDhcwdIVSzhl4aqDtNIibHY/gADF9+vTS1txRQC7qjwtX40e+l?=
 =?iso-8859-1?Q?byTIMkwZyPTUNFEjkjaLFx0lJHwFyEwlEb0TuQOa5/VIebS15+OlpAVdYK?=
 =?iso-8859-1?Q?tGxZVYgMmjFpLPS+TBNFuh9doxDlSO5cgJGOy3UN1eSNaQW1MWsz/9sGP0?=
 =?iso-8859-1?Q?c5KWtDVxdeV8EaBi5M52fo0g+UkcfADBkkijMD4JHZEAxYS2B7VXCUOhZr?=
 =?iso-8859-1?Q?XW+2pqRWNHx0rcTujsU6jeSmX4+ZhZjrajUsJ71AR+Ac+LUihkdQTYJKKA?=
 =?iso-8859-1?Q?Ruzmd8NfKTuFzPtc/WbwGyjaoNTDTz8Kg/h2YG8nlawcH7DZRRq9NfyCem?=
 =?iso-8859-1?Q?J2SkEE4RPztKr1N+VD0rYoFSF+TBKtPf74BuJR2spyLrK14x+lwbR+LF3Y?=
 =?iso-8859-1?Q?qRlIGKQwT6/xAwPmcMCa5dZ3rw4/cEiy8K5UdZlAuzKFGyojl8tkkI+kdT?=
 =?iso-8859-1?Q?o7sGHmiiVuHYM8eLenY0IZ6m1MPTZ0mBO1ZGjBlPFwzvILYIo85EToSTAn?=
 =?iso-8859-1?Q?uHvXyEgCkw7CLhIpFB9815AbFcY337TEUeFxl2h82IOWrQWYrPzBp0TtAG?=
 =?iso-8859-1?Q?OZndM0Uv4RBT80yWD1+aNOjjKf70zlhSk81naBTSxg7O/PUxvZGdcYcTW4?=
 =?iso-8859-1?Q?Y1SDvR2r8uwPpglpyfxC70LuOkUOipt2jqVWrG7afYUwohvTuQexTOfmGq?=
 =?iso-8859-1?Q?BvsBbK5WEYlon7iYpGXWOy7pe/Bc6liarTOuN6Dug1qFNRXwpIfpK9z9gf?=
 =?iso-8859-1?Q?jbDpzHAKo8jhCLVmKOxH4TifS3VmOqhl5nFp8/adHVDWKu+H41Qj4niGCE?=
 =?iso-8859-1?Q?/TONaslbxA6fMJ/dbYQVfzOHI+a7qg3Ji/Xr+kql9l/7b9c78OkFx6nL7E?=
 =?iso-8859-1?Q?IHVBxkHTRy+cMwHA8srh8sMszYZyzUHkx8E/lPqPjcbZeKi94LLb8jVTBI?=
 =?iso-8859-1?Q?rDKgn+5EbWauwYBDt6aU3M69aaHCkwzfhB6sJNfaAM4rtg+iRDXZkqOs45?=
 =?iso-8859-1?Q?J00iMNG8cLbJtUFgWmtudY/Aa0XDo8nTK7ih98W2vrrp7a0CFxFxG46Pee?=
 =?iso-8859-1?Q?kHYO+pSU3ROuEvk8iOvwB1IoBNbn9k6C9OLr/K8x5AEky6OTqhlSEhAbjc?=
 =?iso-8859-1?Q?WLEIvCJL/McNti7jlWw0Z0nyjW4/jz4XDRIr4klbuRo2K3GuWOiRJ+16sH?=
 =?iso-8859-1?Q?bkE57Xo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?m02YMufk0Xe2/S6MCEtPnElMh8y4lOxtO7VeYJVgeo3rzU+uo7rmg5BIgI?=
 =?iso-8859-1?Q?OiLHhRnKTBZQKiIHBNj2iDUwZJI85CYzMYBxxFT4/9zqPR1pEu6Fm/axKf?=
 =?iso-8859-1?Q?Ne4n8TkrgTE9ft3umsnIuNlp9zSvvwOI00yRnLaqV9RBgv6FQcKRiWtTfB?=
 =?iso-8859-1?Q?GKp18KuC1sO0ZMSqt/njjJqSvZd60v9rDVMdrafnujXsvhzkxHCpe0Y/GE?=
 =?iso-8859-1?Q?HCDr8NUZMYvbc0x9oWZpBpnObts5Qy9IkiLS1i4UAevL2uRt2L/ENAcqHk?=
 =?iso-8859-1?Q?PYO3Nhh75VFGEBFkR+m0eJe+5FvZ92ARSgmBUkqIOLQViO3mvAh6ERsOCE?=
 =?iso-8859-1?Q?OmJXPIOOr92gYPK3xMRdXKswzyL/6qaNAg3bFOu4k2111GpJW7uIRK7PZm?=
 =?iso-8859-1?Q?HT2l4SPvPm4viqzf/7X0uhsm44eTbimdSmYeu7gOeUR60tlZJ89JKjw5mf?=
 =?iso-8859-1?Q?idxZV+Xv5htCHaDPomsAEhtrTLOWRJZZRK+r7Bf0rTE5nzzmp5P2Mx2lih?=
 =?iso-8859-1?Q?Slx2dCo2Z2rPGWsORPsxoBbFXIjPlSgvxpYnWXVX8sQ06OOzBnQpLUYERQ?=
 =?iso-8859-1?Q?RbQrY+nIJJzEzb7CmE+TYPP/h09yRMIT1bSm47ja9ukEcSg5pxd+y04Nvd?=
 =?iso-8859-1?Q?+B9n6mULXxoR7Z09NofbGaWiYKVExv2bLm3S9vbN4YyDpUmCiVLyR5h1S+?=
 =?iso-8859-1?Q?t5yKjzJUCqAp2wfIClj5f3W/0OT4lbq+jbU+gO03hlH/YxYCFJ+e4jtIs4?=
 =?iso-8859-1?Q?xrqr432YuzVEfeBvIep6Ps6PKT8kNzngJc4aE/Z6Xfe8NvwrVGzKTGRVCB?=
 =?iso-8859-1?Q?BviP0aK7jrpZz45rXaagFfWp3NOw4IKqVLp2qut5GWxknvcIz/9gQp5pFs?=
 =?iso-8859-1?Q?XwRLYmVtbx9t5KxqVF1AxFh0h4YzHqNKjXCFpORlpYmZ95Dx5FuJajja+8?=
 =?iso-8859-1?Q?QjitYtRZ73oKXhpukOblGxGGazi3w+SZR2pYkr6sVa3+EmHs45kGxF8rSf?=
 =?iso-8859-1?Q?7CJHVVNvUP00i1wcXBefVwBu8STQXBgihBmC5Yrss9PVxf9VKRCrN8Mo3v?=
 =?iso-8859-1?Q?QhrE0eQ45Q+MCa9e3EI/+yCJLTkrE8PbXcSIZdEoo/bjHp0BP+y70dxbex?=
 =?iso-8859-1?Q?MFKayM2juq+yJF2uhrwKjT3zKqFnvwVcac56SnzhFkvYJyhEq0bA3oHj4A?=
 =?iso-8859-1?Q?9YFGdtjxDrM7mu7kONLC7oYgRIt8UFt/HK91Kbqx7q2kxXzTRCyNl38+/x?=
 =?iso-8859-1?Q?bYZktWd1QQzFsh220ijCjv32md0FK4cYLqvBUO9M+j+JCECJicLiCWc0mV?=
 =?iso-8859-1?Q?MZHjJoY49Xo0UVOeErL6D4vt4lDZOb9/SeUIz/azf8R+TkCI7W63S7oOLy?=
 =?iso-8859-1?Q?lhul0XaOf4XHYJJQlYgeFV2FVPWI9IsYEkI/5k6JBrFf9GzUl/Dj0F3YE6?=
 =?iso-8859-1?Q?+Tuna2J1kXgyZ/iyC5kEb2wMHNhvz/XprTtdxgkmShZx4tyHYZ8dSw/NBl?=
 =?iso-8859-1?Q?R9mpAU5A9kkKoHJHG/AB4+XrdtP20RkgCClAxjE/YEXK51OaC/QscPNoAy?=
 =?iso-8859-1?Q?SiswHYJMTlH3VSyCQ2Aqqw0NwGRC6eRgUQdUnSoCHS7hK6ukNOR0N9cmlb?=
 =?iso-8859-1?Q?rWBLxIte/c0k4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507dcfa5-d424-4f4a-f6ed-08dd93aecda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 12:48:33.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7Y3fGMzKPquCroq5/sObU+9C6cULiWvpGHbTE4XQ5oxa+JV7wJj/hgkXMtZzQNIb9kVG0Bzv/uSEes0dnwQTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

On 14/05/2025 15:54, Andrew Lunn wrote:=0A=
> ~/linux$ grep -r "ro_safe"=0A=
> ~/linux$=0A=
>=0A=
> At minimum, this needs documentation.=0A=
=0A=
Noted. I'll take care of that in v2.=0A=
=0A=
> Also, what was the argument for adding permission checks, and how was=0A=
> it argued it was not an ABI change?=0A=
=0A=
Tightening of permission checks without providing backward compat doesn't s=
eem=0A=
to be uncommon. One example I found is Greg K-H's cleanup of mtd driver ioc=
tls=0A=
and the subsequent further tightening of mtd ioctl permission checks in=0A=
response to CVE-2021-47055:=0A=
https://lore.kernel.org/linux-mtd/20200716115346.GA1667288@kroah.com/=0A=
https://lore.kernel.org/linux-mtd/20210303155735.25887-1-michael@walle.cc/=
=0A=
=0A=
Another, older example of "silent" tightening of capabilities/permissions=
=0A=
checks can be found in the SCSI aacraid driver:=0A=
https://lore.kernel.org/lkml/20070723145105.01b3acc3@the-village.bc.nu/=0A=
=0A=
> But is this really the first time an issue like this has come up?=0A=
=0A=
I agree with Vadim on this - this issue is a little bit special in that the=
=0A=
original bug was "hidden". In all the examples I could find, security issue=
s=0A=
were exposed directly and so the kernel patches "silently" closed the secur=
ity=0A=
hole.  In the case of PTP chardev, udev covered the security issue by=0A=
completely disallowing unprivileged access to PTP chardevs - a workaround o=
f=0A=
sorts.  So what is needed now is a way to tell udev that the security hole =
is=0A=
fixed and the "workaround" can be disabled, i.e. the device is safe to be=
=0A=
exposed readonly to unprivileged users.=0A=
=0A=
Thanks,=0A=
Wojtek=

