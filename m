Return-Path: <netdev+bounces-167667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB4A3BADC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDDB1612C8
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E01BD9C6;
	Wed, 19 Feb 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JRh1/31R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F461BD01D
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958344; cv=fail; b=nylG9Fudi0RLB1xUAdI0qe6GbOT4kySCOIIE5yPWbQPte5kf8t/tlaqa8zP2QflgHnEtazUOBuwWTDInaYvM9dUHCiFp7seOmzxSLp2XBPbwsUY6sBXCaSGos7TQ0DFxY27FCeFO+/rIRRPxIDanUOhPQELLpCDDls1zyMg6W0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958344; c=relaxed/simple;
	bh=rEmJg9DGexWJU5rwYev/F/Sf09GolBhVY2PyHd2qKWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hzfbvDyHUoravng9rxOsZ4t1eceyDBqoVN2TivIFs9JyWGO8AN2l4d3dvUpaLl1lUMwTGHG0lOxKR2oFAqCDVAmh+3kWM71mpxkXxx01gRDPskvi5gygw5Ixy58rH/tbxYg/W0ig+fgD0cvGtRzOgxaoabsIM+ZyRYcX25ajZDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JRh1/31R; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycaTgx4gBhwNDcOdokRX8lybAtnaOUrHnUtoObWs6J+NIkUH8oAQLQYSaWOR3MvfwCmOrqpvo1wVL/ibGYgp6ui+LJolEHwI79FjJtGawsc3tDGgz/KLvHX/yMA/1vF8mRJ3Hdz8nff//HZ9sqIX+YksF5C8Uy2q6+vgJRDt5aDu8vdNGZJxXghxMZwKuC7ZSSmLIuEfeuHSCzGAIg/tdakfwPV6VAyyIqW6MYcIv3vlR77kggDowI7NKIGsLPteyn6NRb5iB49i84RTrhZBUCgojtdvg/zB/ewmyZbAnRyll//kSHYuRLfUutys1YznClNoCuULD+SBCxsNq8Yp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6cDwAj2ramk/F4tHNIKBSKOdP8yqRLjoBJEcWdUL+c=;
 b=W8xmeSsPEhulWxollcaTMkZUVAEFSijDRbql4LOPPFFncJz/NSz6mLwzYaZGTh5NRIgXEF35oj2iALB7zcp9A9zpkXRzfHlh3D1OwaodExcUK8Ji28pOiYIkYvUZ5fv/YuDopYZ5G+qZeM6Et59uYcczvUv9wpE4PJgqUp0bWUjabu0Q/kSJLkzkAo5xVqEQrRnv2OhbwZ1Urk3+lkJwtQefdeVHAPMR5R3gILwk70bTrZ6hdMxqdQ/cLM2vkNG0ctUFlwD073wGQb9Mo0OCq2CyX/O8NoIEx8OCTVaGb5LFRth1RDBl9W2MECJM7XLGC8FhGuJtVWl4s/D6z/3Jiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6cDwAj2ramk/F4tHNIKBSKOdP8yqRLjoBJEcWdUL+c=;
 b=JRh1/31RmeTPzaM3umqlCuQW9X5CmeiC4/xOWHD7tDWVXf+WeiBsaz5VYHKOfmmWL9yiZhLYHgEZimqKgGYImY9gFS0xef2NRN6GhJrLTnu+wrTWa6dF62+wgDgPF2YbTl1FG+deyDQHgkZCwtTQ+OY/rxK0DxHvCrkFmekuXJ3xUYNMiep38LCoTvUWz7dTCsEcyzN/fBLHXqZoKUrsP6tiO3+eVYu+0Tns4+PADITf975KxP26tA9WhLgEYG1lIggDXp1NVGVkibF1l98VAMv7/3JaAJ5Nf13d9QSFW89/tzRdi7qhib+BBpDQOq7rIyBbmTb6Fgh+xEPrsssndw==
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Wed, 19 Feb 2025 09:45:39 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 09:45:38 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "kuba@kernel.org"
	<kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>, "frederic@kernel.org"
	<frederic@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next v3 2/3] ptp: Add file permission checks on PHCs
Thread-Topic: [PATCH net-next v3 2/3] ptp: Add file permission checks on PHCs
Thread-Index: AQHbgSFY9WT8Aenod0SVG3gbvZBmTbNL8ZqAgADX9nA=
Date: Wed, 19 Feb 2025 09:45:38 +0000
Message-ID:
 <DM4PR12MB855850D05B3332C4DDA0D76CBEFA2@DM4PR12MB8558.namprd12.prod.outlook.com>
References: <20250217095005.1453413-1-wwasko@nvidia.com>
 <20250217095005.1453413-3-wwasko@nvidia.com> <87cyfgjp54.ffs@tglx>
In-Reply-To: <87cyfgjp54.ffs@tglx>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8558:EE_|DS7PR12MB8289:EE_
x-ms-office365-filtering-correlation-id: 7a83fc27-2228-4938-7a70-08dd50ca2ab5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LQWphysgnvUpfzJC0CVkxSnlyM2fxF6KE13lXpf8QWxZQKUcW3SMwLo3h4?=
 =?iso-8859-1?Q?P45ds2M84/mmR/BHZ1OWom0YHTnK8XCYKtbiKCs1fywF2TUmvZH/pEel4Q?=
 =?iso-8859-1?Q?mqvFJp7SE2b++SVOIGh/NJesTP71b7YfARahC5SS1ZVh7hpNackHNzSYjl?=
 =?iso-8859-1?Q?V/L3jSC/Ff+B+dKOkzVUH0AGtCNh0zrCGL6mKaEzLL40M1j7UBEst2mD95?=
 =?iso-8859-1?Q?JxZdNgafko3lEBJjOHYa5wCdVSVCFaBrccM5jKaTTPKwcIIjUSF5Zct5Lo?=
 =?iso-8859-1?Q?jD7LYPj0jWH//GaYzXuuDmUpterjjhaZW2FpJskS/pzwIGExMaBkOphchB?=
 =?iso-8859-1?Q?+t2SHvSlquLZ98nhV5npb70Tbvs2TtLiKAgqqlRNE1Xe1V/GGBgjXhpU//?=
 =?iso-8859-1?Q?kHT6vLmSiH2BWm4Qb6FeNk+iNZxQkKY6UmtPleIEDRxlabQCHBb58ClTxd?=
 =?iso-8859-1?Q?Vyi84YqAOztbtU6wfMeBx0QeBythLaQRtQuakNEaxbnEWG031iRiwvuoMF?=
 =?iso-8859-1?Q?CHN1euB8Qn5WZw+W7t6bnP8bYLCs0MCyMPtzFF05fi17DNUWgsZ05S2SsE?=
 =?iso-8859-1?Q?OqnJpp0VRTYWG5apFwX9su8l7J5dkVzp9P2kIAwxE/PJ6DAJlUL1DdEDiL?=
 =?iso-8859-1?Q?XoT/yzu1z2NHEePugJXAnaSfrWlknPbmLDHVjx1GRB36JUoyDwwn0S4y2i?=
 =?iso-8859-1?Q?qMtbeJyUxV90+X35JsnltUfMfjfO7+eJO6oAVCTR1UNMjSpkDVTsXvapp0?=
 =?iso-8859-1?Q?c+LAoKlgaweTa7zBgDOcYfxQ19KCq1uSfYjRdn+8Bgblc+/OZgslD/zCrA?=
 =?iso-8859-1?Q?1Gdu6otVbFZFmfuqvn+fLJ7yk9FI+vZ7AZ++sCmXCxXtsgL1EMg/sdDpqS?=
 =?iso-8859-1?Q?wYxKF8PrFBHNevzBmL+1SwPzV/MztQcaA1bla0rpuKucQ4DbpSzmFu1oiU?=
 =?iso-8859-1?Q?tUaygb6dTTXVTZ+WNzET+3LqqhLINdhvS58dRyQLmIsrohaYxbAfOODolB?=
 =?iso-8859-1?Q?gm4DVJtQx2TrD7FeNQ1kXpTUvMqyATXn7PgachjrWFHO4Ek0coxWG9nknP?=
 =?iso-8859-1?Q?deD0J8b6WXtkA2o2bbIzBLBLDuduy6SUquozN1TELpli87p5byIp7/WF36?=
 =?iso-8859-1?Q?uu94J5U6feXB27j56Vsiiks7LfLW/2Lq6g5BJTWR0gP/e6Wgpce2DJLoY5?=
 =?iso-8859-1?Q?LmQ3cWLqvTpHK4NTCKFqaRX9VQKDLdZrtizui8I4qmQ3gF0jRaZWGo/94v?=
 =?iso-8859-1?Q?XpzmUl+jqcaGCFp4QJsiT8C5kcnwyonciTPG15Vs/iPAGZlamP0GibEvcT?=
 =?iso-8859-1?Q?zP2P51OxvYLHnT9GwIi/GF+g9MYKhPyRHxe6y3jJ7UAq1SAiK8PdaNLdPN?=
 =?iso-8859-1?Q?YA+A60/G+jql435mwrAtCmnIVtC9Jp0hyZqIs7lntZNGq/RxSfuR++N+0n?=
 =?iso-8859-1?Q?ADjr3uBj5AmK51vdXd5o5t1nnZsE92wXwMKgVC7WqjebLj3cM4+ccExdpt?=
 =?iso-8859-1?Q?8CJMaMI4vA3T8qijbKeCXP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2hlcPvao44vckYObfPDAwmEsLHuzwdO0Hc4EG0x3mAFE+KAvbw0gnSu0rt?=
 =?iso-8859-1?Q?wmN4JfL6w1kvKiOZJwM0oKI001oB5Qw9kPtDxNx3Y/wSC7BhH6/XQFhXnq?=
 =?iso-8859-1?Q?qHZzLsW9fFqOozbEKgi8flD3imZnAWCAKfaxzMDGq3fsXKFZJWws17uIxg?=
 =?iso-8859-1?Q?ValSLMnE3qb94wuznz9C8C24xNkK0n5lSzEwpFbuounBLvbwK8etB8RY4a?=
 =?iso-8859-1?Q?9wG5gnE01HSzHgmT3Z4arFMcGQVMA406u1zqPUVQp2cnGnGvrBvaFerciv?=
 =?iso-8859-1?Q?gdh2eOTNPLilQwbzeb4ENpWzNTpba6D3dWLbzUeRD8nqGgmoLGCx6gGaiH?=
 =?iso-8859-1?Q?hOTw/ANAimbzTuplr9GrwKxBqzwGNuuy0WKu/1mX4Xcwi2hAbusagmMocw?=
 =?iso-8859-1?Q?Uu/yZUdQeam2YTMUtHplWXvCj9hijiuDcs3IEXJ9x2pQzG69AsGe2U89qF?=
 =?iso-8859-1?Q?QdOiHECcWD8STO5oDJoQm3wwg+e6qgBZ/QOODdO6levp+Hp39Wt03NeJKC?=
 =?iso-8859-1?Q?t9NTiTjihLdNmdkXx3lSVraIaDsODjZY1kJHb76e8Mg55ND0UUNRi9jyo1?=
 =?iso-8859-1?Q?5gG2ekQT4+1sJoO8vp59QgtJ3HmpEBrIdahyVZmCX1jP4OArd9UdY0NufL?=
 =?iso-8859-1?Q?rztJyRXmUr1Xsmny0+7bRV4igZyjUDAcXClZDnJ1cdnm7/nuUECXqyrThZ?=
 =?iso-8859-1?Q?cjKJQJoadUTT3YBxPGTXXxrJmbVRBG271l7UavYqMNQAed5kPfF0t3pdGn?=
 =?iso-8859-1?Q?Qd0zeQOj5uqlPedSGhnl0Zr2YF4vZcW31WiZ9RCehiLlUnc+waxzWY+EVu?=
 =?iso-8859-1?Q?kxO6pwdhgvhIsaLql90htho8eBFaEY349Gy+aChqhxCmB3nx/g/ddIM0VL?=
 =?iso-8859-1?Q?v/Wjx6DgIWfWaHa8jFd7gAVgrJCBGaQCTs5Eiv4R45hDwC+Hqna1jGndeV?=
 =?iso-8859-1?Q?WnFer5LPWGREt0gmucSMxGlcy5Dl1vqKoB6N/mD96zsUUFkwwtEspeMQZH?=
 =?iso-8859-1?Q?S/24ErFqSU/xYeqHqNtjEPhXIg34mtR6s8R+4rVjTuwa3TCVQ3i1sQZcB8?=
 =?iso-8859-1?Q?9DFIi+PB956wL22PJIu2Rtm5QBMKql/Gbl9TXqnW0P/tcvfwLrIdRm5s1e?=
 =?iso-8859-1?Q?2Zq8DrDS3QYM7QlPuxvPsv4NB4Gx39KBLx3S2FVKFLLoagUETSTqWBcqnS?=
 =?iso-8859-1?Q?feeRmVMNrZWfhvkND5oq0EbxFQNQccK8ldKXgUr2kg84ZTq/GfNu0mXPEc?=
 =?iso-8859-1?Q?jKOW+Q2MdM6iRaoK3mimqQGBeG9fWXHElGOfschG/5E/2pNWdxqLr3gK/U?=
 =?iso-8859-1?Q?WgSEPrk6pp7CshAhuFKwoS7gLnmR5F/efwZCUbPPNjpYCxiNia1oK7wUUP?=
 =?iso-8859-1?Q?M2B5xjdCSeNr1VQO7QSm+qsBt1t8ULgaYm+OfMTLvdQyRc2mawAWG/AGI1?=
 =?iso-8859-1?Q?EF0/Lu3fv8etGKnBo6lHE5VQQzWqxFi+bx7+b/1SrZ/aR+qOMXMnw3koNV?=
 =?iso-8859-1?Q?4ld8uothqzmcsabc0weUagDdYoZn9J1nmc7IHFwqqMvAeqITm4uwNX/fvp?=
 =?iso-8859-1?Q?GCU7RD5clzsX4lD6lMcYuj5ahE110jfBGLHPgNxuZvm4v7VaxDR/p4MuM5?=
 =?iso-8859-1?Q?q0jtr7EM6NpPM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a83fc27-2228-4938-7a70-08dd50ca2ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 09:45:38.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNs40sCleVYASkafBk4i+32mPuvSVDDHQOnv5cbPH/ijk4CpsiqTYdowN9DCxBuzi/4XUP2Pp4GMjHM36pwRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

On Mon, Feb 17 2025 at 21:24, Thomas Gleixner wrote:=0A=
> > One limitation=0A=
> > remains: querying the adjusted frequency of a PTP device (using=0A=
> > adjtime() with an empty modes field) is not supported for chardevs=0A=
> > opened without WRITE permissions, as the POSIX layer mandates WRITE=0A=
> > access for any adjtime operation.=0A=
> =0A=
> That's a fixable problem, no?=0A=
=0A=
Absolutely, but to be honest I wasn't sure about how to properly change=0A=
the access check in adjtime given it's a "generic" API. I ended up with=0A=
something along the lines of:=0A=
=0A=
   if (tx->modes & ~(ADJ_NANO | ADJ_MICRO))=0A=
     /* require WRITE */=0A=
=0A=
being that ADJ_NANO and ADJ_MICRO by themselves don't mean the clock will=
=0A=
be modified. So the modes field is not really "empty" per se and the check=
=0A=
becomes less self-explanatory.=0A=
=0A=
But then maybe I'm overthinking it. If you think the above modes check is=
=0A=
the right way to go, I'll send a v4 (using the opportunity to add the=0A=
Reviewed-By and Acked-By tags from v2 I missed in v3 - I'm new to kernel=0A=
development, sorry).=0A=
=0A=
Thanks,=0A=
W=

