Return-Path: <netdev+bounces-120447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDA395965C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6646A1F22ABC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3EB1B1D6E;
	Wed, 21 Aug 2024 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DEVYfAsN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E801B1D57;
	Wed, 21 Aug 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226530; cv=fail; b=atUPek93w37IYMnQ1A45NZre5fQgQV6bO0cHc7qNM06i1s2rWaPv6RQPGpW5FZLzJ8oL+or+kpQQPaj16xvI5iDfyepiX3kwQIkiJiXv647t5uenLEvpLggqF4o6Ct5l4sKabHo6tiHIjHpHyLB8bhjMysEzw09DmspEBHrZLNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226530; c=relaxed/simple;
	bh=iGFqWpbICXrDxxBYfdR24LEDCOZjErQ8gobVybgYAP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qax0NOvFXXVg34IZc8CQahlwVtjpNnk4g9aO28QgvDMFh9byEtu10HeBUWF+NS5FgfycHjsqG2Qjo5zhR/rznVTWb3JdAf+P1rX3iKNRvKjYBt0KxV8R4pcaVj4ohpX++M9YXbsbLnMNIJ0UNIrH5pcpXrKCOmC+aF4q9B/uFXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DEVYfAsN; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjdZtEME4RbMEo49byjvyK4QpoKBSVXZ3CtvADCPwGPJqIIPnRmIFbYi0lJ2+PFHdtB3hvmlCTwqJi7OTqAPTppiqjih5qHGjsoQHVdkzagmJZVw3GNo3CavntbvJsryfXGUOAN0wyH3eNxLR/hrB5EhJTzBOgg5pfb30J/kSbNzUEYz45D598hoLHvBS7LVuRRU4vZ7y01VtDY4dzxhrKSKJHLyjHvotfNop0t8lOYl53Y8ZIi8j9B8XgbvI35IObuQwXIaqZsf4/uDjmKa1GJQw24y7Y1V5BFGn6L7udhTpVxlwMhbVEW8PjQuiXzuX94UQEl1EoJ5YWoBEpB+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eNSzDNeL26SXcwGLIdqRR4rRXZ8um6qTdvuq9/NG6w=;
 b=sSVtAfduBoC7szy6M+/qs+tnl8pRiMo6yUEMfKcqZBTnF+WmuZB0nGp0ewuoaQxCX9jzzdZAhtgPsYoAccKAhbI+dWsRPxb4b0/slFt28vGKvqBqvRs0Z5JDWbxG7dLH3MCRxoDwIvyZj5wXgmQ1bhBEq/zsUU8j7lJiGKUDMOzBnaGNY+ALIWj+EPBHpVGVNu+skSu2BIxSxeTN5N07yXCiugk8TtK5oHxjaf6sthM6+1RS6+t9CvsJdZmUiEp/wFD3B5IQhs/v/oy7XsR6p+5S5FrzsSKbzF6XMU0VIc++wovkZCQl+A3de0LP5pyZSJM1o91fMfVRpB7XeN35aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eNSzDNeL26SXcwGLIdqRR4rRXZ8um6qTdvuq9/NG6w=;
 b=DEVYfAsNcUBbD77oGx/2UUIcebBQ7aTprZn0W+25LseG2/aR8kyEpsdCcDJ7o/4dHjsdBRXXB6W00xVQ9pATEQnYzwilIUc7x7SvV2TE3D71NUJp5ddPJhnVjAJcC/BVrCKyNHYbR2Sd7tVd/ZmLZm+koZi9dOjQoOGjC8QagLOJvjZF8JZGmV9r9YJd9rU9/FwvpKctTke3p+qwYQnenrXE8ukaJVz4kveoDf4e9+PErbhB7GMsgDSAbxp3htwA+yR6jBV/3TCwVyDkuRwICGAoP2Y3WU2pT3B2orOQZC3ell8m1G6rDF9zTYkkdRGTOm8nbH3JPTj2Oj4XToAfrQ==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by DS7PR11MB7858.namprd11.prod.outlook.com (2603:10b6:8:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 07:48:43 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::a624:b299:5062:5ab0]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::a624:b299:5062:5ab0%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:48:43 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <linux@armlinux.org.uk>,
	<kuba@kernel.org>, <horms@kernel.org>, <hkallweit1@gmail.com>,
	<richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to
 configure fixed link state in phylink
Thread-Topic: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to
 configure fixed link state in phylink
Thread-Index: AQHa8fh4uC5D6kLwpk6HNkOhh85KxLIuwDcAgAKYgiA=
Date: Wed, 21 Aug 2024 07:48:43 +0000
Message-ID:
 <LV8PR11MB87006B1F64E014A476B9214F9F8E2@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240819052335.346184-1-Raju.Lakkaraju@microchip.com>
 <beeeb1f9-a194-4001-9cd0-f8045fb9e0e6@lunn.ch>
In-Reply-To: <beeeb1f9-a194-4001-9cd0-f8045fb9e0e6@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|DS7PR11MB7858:EE_
x-ms-office365-filtering-correlation-id: 8767a2f6-fa2b-4fbc-31e7-08dcc1b5ae38
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zmCNE884mL4gtRB6njIBsjOO20JwYy3U4a6l7xG+1MSvp0fjxSRTr3unYzNR?=
 =?us-ascii?Q?xpNHHOWEkGhfhSa2y9LaQMnkcRf2NmUsmwq0NWVCyqDR9rxck5peDPnCTtmQ?=
 =?us-ascii?Q?P6w2dHx9PR641fQ+cQyi6XtY+SlIBSRD8dD4C787LyyADwdtRjtxjtvUYsOm?=
 =?us-ascii?Q?fYJftX2gpkwnhXIDV1L0xnNjFWNtIxBeHIDCbtvzjELLBmsgy5R6Ry424xwz?=
 =?us-ascii?Q?HYbSibDUfvf1gtAMZsKKdfRsmwyFjev/6liAJSDIjE8jVSummJBcD/9Nro93?=
 =?us-ascii?Q?yOn/Q1r3oWX0sFM9+W8J0fjCr1Uu/hPo6jJEYw7o2wFMb1KQQsF0OUjb/7Ns?=
 =?us-ascii?Q?qDLWLMyustT3DOQuvDyilMB61Uk4yRFZh2m//LMACPJIeJ46w6vNePRpOeTT?=
 =?us-ascii?Q?8EKL8E5UJGFxIe+9h0gJTvMWYd4nd4zP798F1zHTpAWXjVJ5LiAQuhM6UXcS?=
 =?us-ascii?Q?ztSg2YZAEcqiTN8COR5KY0Wg92Z6Oti/8KTPG3wSO7K4CGbaA07bmhRpCd0s?=
 =?us-ascii?Q?KtfZTPakBmU+MTkSJt1RNfe+6RnIlqa2ynrM7dI2K0MS3wkPP01zl4E32K8M?=
 =?us-ascii?Q?4FnUTB3Xge7U8mp6jNSFXcTOedjqDcIvoChWVYodoY0kxZASX6UKIW+W26NQ?=
 =?us-ascii?Q?5UURR/I/zHnfnEHfpIuZ4DTYe1Pk0VjaW6qDqTLbNb4ULHX3uURMNoxbphDp?=
 =?us-ascii?Q?BoL6nLa4jyEhI/aRNTH+um2gHvI/7NpVO0j8TW3Rfh3rzqhvJzARtKmN7Tje?=
 =?us-ascii?Q?lW+slTTdhqBTIPiT7REN/0jfDcbUhH2s6d+5YmCUZQJpp9x0JQrle1hbtOGf?=
 =?us-ascii?Q?Mj/QDrmvWrq+0gkpvAokwPKYutxk7oZFEc2hh34poYOEXb7XTR27g++Gyv0h?=
 =?us-ascii?Q?3HHvpgW1394KBVvflFrt7BZm2kJKJP0mNciZE+K26b1iVVyWIv7HaWHWGafB?=
 =?us-ascii?Q?9fXeJr7bPv/OHjMM3HNp7fAssV5auFXXCdaR46H/rViaQb0UbV7qTIBQ8WBw?=
 =?us-ascii?Q?fJeZDCR0tI15cT5lTbhaczsqeLmfUxRs1uIs9YZC/qWDWb2yE1r8cPK3R8y0?=
 =?us-ascii?Q?0gRLxkh69crpFlI/bVu89bTt6QcRVOSXUD/zFy27JmaBCX2Xa6hc4johOoyj?=
 =?us-ascii?Q?Gg6p2672W3iUQZ+hpHUGIG7HOzHRhflbssG+yvCTyzBtRK4801SJ4qqvuRCI?=
 =?us-ascii?Q?TGvHlIwkSlGw6pXCPqt7NsQFix3plQ3mnT6ubb8O+X66c+I1Col4B9hfl6Co?=
 =?us-ascii?Q?RsEYxTf6rgd0nGhNMD1po8762sOA7/yGAe/ndwUJh+11y/M8KzUwnwRS6hwJ?=
 =?us-ascii?Q?73J4hQZOR4zrvCDwYrOvQYxGNQdiVbhxIXuXuxzyvtuQjP/fs7qmYF7ufm6n?=
 =?us-ascii?Q?QzLI63zbapqoNRN5PyhuFgUwflQavbmsRgplC23ea8BCDQektw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KBmwPswjVUUUzvGiEi+X38zRmK1CQbTQBZ1bfBORakEKiNsba2PbE00Dj5QU?=
 =?us-ascii?Q?vMTUcVmHEBnZeVAu8rNAXYF2V4dCtVzTM6jhlkKWLuGKeYEPl/dPDXvr7bC/?=
 =?us-ascii?Q?F91vHq3Ah/bwHIoj6qjN80fdlxsW+qMRwpwHdBdiNvmSdcV3yf0czsC6aTYt?=
 =?us-ascii?Q?zBJO2x/u/4ie9sbtDNjUXQM9jVrE3TlUv4HUWXLR+4WLdbxYBtAoAQi6UpKk?=
 =?us-ascii?Q?z+433/UpCHdDJIeLG9qPWuYHLeWwzIl5YhkcEnqZ4OSrBxwcTVSXA30c9t4p?=
 =?us-ascii?Q?D4DEj3KhReDzjQc9FnsZ4mkW4ngcos6PbKEs03tpi5nrB99CRd6jJUbkjOFD?=
 =?us-ascii?Q?YqTziB2AWfgHnARt95QSUq+XNMJxMP2p5bs3N/Oa1m9tsFfaXULP15mK2V1T?=
 =?us-ascii?Q?TKB21QbxGLmpVzrasUvQfNDYFDbIWRye80AqV7dF3Y7gtLEJjRW3raCBZ6hs?=
 =?us-ascii?Q?yZWQljaMynsCyLHf7lJjpwHCSEHK6PKv7jzlS+vw1A8yz2YRBTDmz+PmBW96?=
 =?us-ascii?Q?165zlyiki9nwbPkbg/98cETpjkLGp57BVWFu0lmbMvfU+UIMo01fjrl1Tcbs?=
 =?us-ascii?Q?T+uGRSL4cMfFJ2jJb2sjPNrF3Xd6q3LeaTljJGUu3y9xQ874jL69SkHte6dt?=
 =?us-ascii?Q?zFo6qNvPiccv0gGD6v89Y1XFUFPdsVOCWt7hPEascOqssdDRNhNfbBgnEatc?=
 =?us-ascii?Q?xx+lBvpFNLfifP0u/npo4XQ2eXxDc+f/a/n0DO7MKIISENm2jUF84hn7MzW0?=
 =?us-ascii?Q?HNFlp1bexbTrYLYGhGcQqOjtjLwQnYTBqPqLV0u5YPWI3WqLzBJDeyXTwLwM?=
 =?us-ascii?Q?iI8uaK6332pNn/WUYRmQ1lwC1p54QBlAWisSRYvoB1x43HlGsY7Z2VCCOpHX?=
 =?us-ascii?Q?IE/W0/4C1+qN+4oxyisXu3PSy+9POrbtDpm3jf1ciOn5rCb/pUVDzjES3GHE?=
 =?us-ascii?Q?nxom1EjaWtMPZGpPl6AEt0OFnI6BX8nWiq39bUNxiseukV0GnekALtS4NlWH?=
 =?us-ascii?Q?enIan99TAP5r+rp802V8MTiEwUj2TK+97XYdbbJbsEg/OqB/BONoUm/bdzMm?=
 =?us-ascii?Q?QA9CLwijDbGR3GCqVh1exxoKSj09rSQVk//0al+XyXoddnKh5tabZIOEuKBE?=
 =?us-ascii?Q?C4jpR5l7hc4Xz3RTWEYW8+1DvRy4HuyTHMOBLZaCkWgsPutV/xcFqBuC1UVG?=
 =?us-ascii?Q?ghR3IG/316/HMhIWLsvD3hZy2pOyzyaw6PqXxtaHC0i1snpNdFH+RHzsKaiK?=
 =?us-ascii?Q?bKPM4z5xXVAQdNbYh35/aijCYDqBbz+woCQKEzVICeeDXcCVACv1lJQA693Q?=
 =?us-ascii?Q?y00srLQn/PfznvowoEvEVL5TP9yWR0V2qfD1TZk/iEajFqMm5ZlYXe00F70d?=
 =?us-ascii?Q?j6iu1Wn+zRGlt36mE3f7232nrcR8jw1jGMlz0DG+SwFWc7UaVtKFZOEbMlzY?=
 =?us-ascii?Q?VGMsYPiaWbRXZDawlOfqzC00ygbzZD3c2OaPGdxlGY9QrCBXsyJy+r4w/9pJ?=
 =?us-ascii?Q?m15r3vrdwYbhmhKTHAgpatt5qC4xBGmgikvVxLjBeCihIhof8lPYesXUL1HB?=
 =?us-ascii?Q?U1lVpKp7c8rHSev0nrEwvqSmkRJwWhfOUY9CWTrqiMa/nBOLXbGulXDwSlQH?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8767a2f6-fa2b-4fbc-31e7-08dcc1b5ae38
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 07:48:43.5466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENobtMr5XWBnJKdYmaWzYer15HntDgZzg0IgnNeEez8YaDDG269Wdp4Zs08MS1uNCRGoCxtowrvE9BgqFRDsbDtNvpKtcfyWjfsgAjk3UFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7858

Hi Andrew,

Thank you for review the patch.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, August 19, 2024 9:39 PM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; linux@armlinux.org.uk;
> kuba@kernel.org; horms@kernel.org; hkallweit1@gmail.com;
> richardcochran@gmail.com; rdunlap@infradead.org; Bryan Whitehead -
> C21958 <Bryan.Whitehead@microchip.com>; edumazet@google.com;
> pabeni@redhat.com; linux-kernel@vger.kernel.org; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to
> configure fixed link state in phylink
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +/**
> > + * phylink_set_fixed_link() - set the fixed link
> > + * @pl: a pointer to a &struct phylink returned from phylink_create()
> > + * @state: a pointer to a struct phylink_link_state.
> > + *
> > + * This function is used when the link parameters are known and do
> > +not change,
> > + * making it suitable for certain types of network connections.
> > + *
> > + * Returns zero on success, or negative error code.
>=20
> kernel doc requires a : after Returns. The tooling is getting more picky =
about
> this and pointing out this error. But there is a lot of code which gets t=
his
> wrong, so you probably cut/paste a bad example.
>=20

Ok. I will fix.
You are correct. I did copy/paste the string.

>     Andrew
>=20
> ---
> pw-bot: cr

Thanks,
Raju

