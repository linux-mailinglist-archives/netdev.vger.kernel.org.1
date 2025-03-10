Return-Path: <netdev+bounces-173556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C72A59735
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88549188C407
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC2922B8D1;
	Mon, 10 Mar 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E2bnLsIL"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011026.outbound.protection.outlook.com [52.103.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA41A22B8B1;
	Mon, 10 Mar 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616006; cv=fail; b=qz3mZu8DooSWAxPAW4TcflMgrqFAdtVDDgh7iNBNzO3sY00ZTm0mQzoGrs/5M3BjMAWbg6tvFcfPMGg9WluEEzVbqL6xamJpVigUh9Om7fTlpLwjpti8cq+JKf84ltBIRGRrwCnKQf5WjoDiW17qfk3FgiPTZjLuoCZeyXxPFSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616006; c=relaxed/simple;
	bh=x0eCd4tDv7gETY816aEwlPslMsyKoNZx8GidL9n32yY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kBNxCSdgX5X9B5k5NB3XNCP4OhhKy5H6Pzwxsco+Kz2ygL3HG1EiDYHR0wRnnqro2/sFzUajUDfoGe9YtE5eBmdycLucCXLwzq16LwiIEMlHj3G9lNET0A4S2qnUJW1DHZ20FoKC7kTqCF0yyLjGdAjLDdrFhAWtJooCBU58o4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E2bnLsIL; arc=fail smtp.client-ip=52.103.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJVRsalG9PaEuJkgfqfuG5YTIAG9gNevOgX2pxBuzR08BVMEDQMfWEUvnd77bBcocC8KD9Q/PYeT2GJx65n+FPlXJTfQHQAwZ2zKgSTRgLiLK51Nz+Rc67qYdHY5vW6aUsdIwJ1acPtNG8hHFsxGXS3NhUMWEwLU9rk4G/FwDs1FiCoJ/OOSyn1HrEArgLFx9fUvnxMyJUjxSbkGRBdSaFMr6os1MG2hU4J2e6wwiLHuZYUTHatx8xzF/eC4tji3pHOnyrrP7m8Ohx2LvwmXbjvDpk1NmmDEobFny0LXzKLYbOf2fdhcmyY9ziQ0Q8yy1mto4oGVHgtonGVhuvnIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0eCd4tDv7gETY816aEwlPslMsyKoNZx8GidL9n32yY=;
 b=ILQ11dZAo2GU9z8Q7KECeKLNTS1HjhcpC1Nh0t8cOIJDLdMdQJs+NFHXdl/oCENNnNsD7Bz7+IAuYAJkvPM4z7wYu/hHrIyTTFo8zqFIF942xqcwOs+0YalPmceel945Ibwei+d4J7G5QWgIWubRgmV4yRTxIm9Vy+PO/RtV9WEjTIFcQshT0/70Fk3xY3magiLGpR6Cz9xfeDIYwJgJ2zdnhTzmspLngGuvUghhqetBHNIpWrYWOFz8qvkn7Ia/300RryTQIL6sFSfdxe1mlZj7O9MSjyRLF5nolB/Zs1m9VgPm96QVrDVgGK4PpAm/lyef27zKjhE/PgDW5uE8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0eCd4tDv7gETY816aEwlPslMsyKoNZx8GidL9n32yY=;
 b=E2bnLsILV7odljN2wrFP50KlJgR8nFRoUDcLviGhdH56HTe4x7pj6nutefCECoYzXPAeNUz/HKyIfb6PcxgFHDNZbrv7wKyeSQEHG6ojV1h6ZB/VkjG12xCLvfuLRvWqKuZzi23tEPZ5QVjE8QkmXief1c3IqOqBvX1ysswXsDJhoqoZhWZkkSZDjqIXtLeJpFnI2TpkNx87L2w285QldQRaiF6peT2c4qAZt3hMWV7dXzHNhjdAGbFFNll1fFypgacrsCww0OneOBb408E1L0BJ4jbjJSiQ70817gmfzt2ZmSjxvxklI/pZXC7gzzdoIIxQ/HY1Q/ih9yG7vpLIbg==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS3PR01MB9737.jpnprd01.prod.outlook.com (2603:1096:604:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 14:13:20 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:13:20 +0000
Message-ID:
 <TYCPR01MB8437DA180663B75AECDEB24798D62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Mon, 10 Mar 2025 22:13:17 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: locally receive all multicast packets if
 IFF_ALLMULTI is set
To: Felix Fietkau <nbd@nbd.name>, Nikolay Aleksandrov <razor@blackwall.org>,
 netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20250217112621.66916-1-nbd@nbd.name>
 <37bf04ee-954e-461f-9e37-210a8c5a790a@blackwall.org>
 <7932cd23-571e-4646-b5dd-467ec8106695@nbd.name>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <7932cd23-571e-4646-b5dd-467ec8106695@nbd.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------90cviyC7MfcmJBCM298VqtXc"
X-ClientProxiedBy: TY2PR0101CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::18) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <e5c02f78-ea62-43fc-b8a8-cab5b29f72fe@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OS3PR01MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca4f3d7-e341-44c1-d96b-08dd5fddb5e8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|6092099012|7092599003|12121999004|461199028|5072599009|8060799006|3412199025|440099028|13095399003|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEQ3QmVPZ0xNQVdTd2hFcHo3N1dQbDBMbGducXhGVG1tTGVVblcyYld4RnVj?=
 =?utf-8?B?eEJTWFoxVVUwU0ovZk1FNDlYekpFNGNrdzNncHA0MWU0RUpYMTExZitzTTBB?=
 =?utf-8?B?THJaR095bUtQYnFZNnNzak9Valo2YWhkS3BiTFNYWng3U3kzVldmWWN0RDVQ?=
 =?utf-8?B?NTMyQ3ZBYmNIZThJWkE2UStCT01jb0Y3ajdHQlRYMitlZjl3anhseThnMjZi?=
 =?utf-8?B?NXh0NXVZSjZjNlMyTDVkL0NmZEhLYy9KUHpsMWZiQzN3bGY1NFRJNk1WS1U1?=
 =?utf-8?B?eDM5RHM1eGtKNHlyc2d6NzRWaHhLUlZPR3M4VHJEVXN4ckZXd3BUc0JGWTR5?=
 =?utf-8?B?b0FwUHlSQVFEV2gxSDkyODQwdWtZUDhOM01QbFhZdlBoWEd0VFZDSTM2NDJ0?=
 =?utf-8?B?L3hzR2c0bUJObUtXSGVYZzFQV293bFlMWmwxMWQzNkxXaVA4cGRwaHRNQXh6?=
 =?utf-8?B?dFh6OUdXSVhUZm1lM1BMMWUxVGR5UVBRS0F4OEtIUnRuOHlBNjdwbncvd3pi?=
 =?utf-8?B?eWo1OG5veWhsK2w3ZEQzZXVydkxLYzUzdzVrbHE1emNJQlY3V3huK040K1FW?=
 =?utf-8?B?d1NqdnpqZGxQUU1McU43Vk5rdmFJNjBQU2o4ckJVd1FGOGQrUjRiVGRDeWl4?=
 =?utf-8?B?cGUwYnBaSVlVZE5tbEtDY1BSK05rT0ZPWlIwUXUvd0NIc3lSeGVJQVYrbDAv?=
 =?utf-8?B?dlVHOEFpM1pQWWllTXZjYTVBczkyWGRreGJSYWJWMHpxMjNIaDNxaXpua0h2?=
 =?utf-8?B?cC9zemxKM3hPeWRQWWJmc2JSM1FXbndyWFowdmt5S0NNdkJGS3p3N0x6WlVv?=
 =?utf-8?B?RjltcUFqYVlqUHB2SmNIY1V2bjdsTGRxRi9DdHJnSGpCcjJOOHIxT0QxOFVj?=
 =?utf-8?B?YnQ4WHg2WnZMcmJlS0ZNWkI5aXdSaGFqck9mTHR5NFdyanVJU25YT25RRy9E?=
 =?utf-8?B?cUs1SmRtSEsyV1VQOXZTY3I0cTBEMXAxd2hJS2liVThFNjN1UXpyQUwwT1ZE?=
 =?utf-8?B?dldKOFNpbmFSNit0VTE0ZlBicTJSUUVZYUdCMFNySlRmbXdqTTJFUVZuUG1E?=
 =?utf-8?B?VVF4STQ2Y0pEK3kvcUlpVEprSnJZVERNa0gxTXRxaXR6VnVGQ1pWRlZ4cjg3?=
 =?utf-8?B?UE05a3ZESW9YWTA5SUxwK2RYWTJRRFh3bU9hMnBGckdLK3IvQ2NHQkNWZnQ1?=
 =?utf-8?B?eitvaklLK0JOUEU2TWE2WTUzN0FBVTA4d1FtVkFMcFpIZmRVUkVjQWJMOUVs?=
 =?utf-8?B?ZFE5Yjg2cVhtdUZYbHBiRGE4a3NYZ3J5SkpteVA3dzlGM2E2STNiTGh3ekxk?=
 =?utf-8?B?UTJWRlhKODBhRnZBMFhhV1hJQ1J5OHRQVE1oYW05cnFZaWRPM1MvMktuRGU3?=
 =?utf-8?B?d1pScWVMUjV0ZjNONTVVR1VNOTNSN2ppeVpVVk5PaGZocmc2cHFQSWoxS1hI?=
 =?utf-8?B?QkZLN1h4bnZXajcrdUdUWjhwNEw2MnZqNkRuYlFSbGFYMXpoYnh1c2Nsd1Jo?=
 =?utf-8?B?ZXdpMmE3SWFQWVMrTFU2OWJTek1WLzVLRTNhTkgxY3VMMWZjOHRUQ1c3NEo4?=
 =?utf-8?B?SWZFY2NNVlhZVWIzczd2NVpBNk1WS0g1LzZJbm5xSnFMRG9Yd0d3Q3IwK0JD?=
 =?utf-8?Q?UIgXSL+3erzMJvVajB0nvjSfN8fCLxjFk1mwBloEv8ro=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnN6SiswTlBBWHBWK2YxaTMrNHF2SXl5Q2hIbk9kYmFlakpNRmhKOFc0RE5S?=
 =?utf-8?B?NE5aMHdlTUZuNTRmTjA1UHNZdDZTcHdwODBvMGZ1bVhaaEE1eVd3OWRta0RI?=
 =?utf-8?B?WlZ2SmxTcnAvN0RsYWQ2UnZvRUFyRHBQOXJ0VE9yMktkRmZFdWpkU3I2QWFH?=
 =?utf-8?B?NjJvdGpBYUFTZWxsMzAxL05ybW13R2kzOU1xYjZmMklOaXhvY290NE9QNGVh?=
 =?utf-8?B?akpHNUlGK0ZHeG14cHYxekY4TTJsVzE5aXdnUDlDbnF1KzdvL0YyWk9zeGEr?=
 =?utf-8?B?ek54YjJqY0dwV2p2akZsS2VPNmh1YTN5YytQa0lmWDN1K1hzK3VlMWF3Smxt?=
 =?utf-8?B?VlpuY3dGOVhHdlNJSmhoMGFHeXVWbnpJRmY3bExIYkVIK296NXZzNzhMQzBF?=
 =?utf-8?B?dUFxTWMrYjFEbDBlZDVxQmJRM050dkVmVzFEWmxVbmRaQXlWMkVLcG9Gb2lq?=
 =?utf-8?B?U3NyYm50amNwRGdHWVZEWkFVVytZWTNFUy9DVVNmcXk5RkthK2x3aXVnM2xK?=
 =?utf-8?B?QVo1YitITWZRdTVuazduN2VUNThYY2ZFR2lMVWIyMEJhcmowbWhOdThJZjh1?=
 =?utf-8?B?R1dOa2p2U0FQeE9DTk81d0tZejdpSk5QNnYvYUFRK2QyZHBnaWNzZzljRTJi?=
 =?utf-8?B?Z2JiaE16OWpCYU04dm9NWTQ4ODNWblRXYzEyUE1aWkp5MkVDZG81S01FRDM2?=
 =?utf-8?B?ZDVlTU9CMTZoRXlKdUUrd3pMcEZxRm95MUc0NzFRR2hud0FzdUJYRzJ1WTdw?=
 =?utf-8?B?S1dHWm95cTExdEtNdGNKZXRpTUh4U29LMDZrbVUyMVlLbDdtMjMya1pHOGVv?=
 =?utf-8?B?OGkxUU5ubDVIbktmVGh5RDdYdHU0d2NqS01TUXNQUnNNZ3g1YkxydHI5c3Vy?=
 =?utf-8?B?Y3VPRGNUSllKb1MzejNlTEk4UUtNN0ZYYkVLNFVrYS83S0taRUl0ZWhiMTBD?=
 =?utf-8?B?RkhBQVlFK0NNKzBmandyK2RnN1BYd3lZL2wxSGZKSUo0b3hXSnJOSjY3Y1dn?=
 =?utf-8?B?VEtCS2RTdk1BcnhIbERUZzN1RXJpN3hJQXNlUGRDbmthbFcrS1c5b3dDemFJ?=
 =?utf-8?B?djJGVzN2WHJIdHljQ0x5Z25pRTFya1dZNVROQ1NxbDR3aXFibWZWekJMTzFu?=
 =?utf-8?B?R0RrTzkvNTRJN1UxY2g1QkhsZ1o3SWVDSzIvKzlSUXM0ZlZKTXpNRk5tUXI5?=
 =?utf-8?B?UkhoOEQ4bzhQUzhqTk9TU1ZDWVJxU3hLVmg3Q3d1SnlYNUhldWJrS1dLVjVK?=
 =?utf-8?B?akhBYW1KR2t0REJFSmNqcFI0QU9ZV2FWL0QvYkpvVzI5T2QwaDlMTGI5TnNQ?=
 =?utf-8?B?dmFmU1YyMzZZTkpiRys1NlBwMkRCSGNrcjFQV3RYVmpmeDlHN2VJNnIxU0Va?=
 =?utf-8?B?VjNicXQwV3F5OHdGTjRiYUEvTlpZMGFxOTRQSWpDaXNCWUdUejZPbmdqU05h?=
 =?utf-8?B?SC9HckJLUktSV1ZKYmdKaitmcFBkZXlBOHBseXBmbFhhVCtSQnpVYWpxYUtD?=
 =?utf-8?B?bVY3S3B0ZThmdVRUUmsyOVhyQ1BaaVFxbnN6NlBBTWpjMytMNlZ6Q1IyMGw2?=
 =?utf-8?B?eFdZR0dialhBME1keXdtZFpqU1NqWkgzclZORjFQT2I2U0pKZ0ZNQ2lhN2hx?=
 =?utf-8?B?SkZ3QXBoU3ZPVC9sNnRoRHhUeStwSlJ3Q3RiZ2MxVHNEcnJWR1JJejNDdjZv?=
 =?utf-8?B?TTJTMGo3L3hlUzlkQmdnYVFhKzYzRWpBRHViMmJxQ0JvUVg0Tm5DOFNiODdK?=
 =?utf-8?Q?v3uauXsFlu/iEOCYBE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca4f3d7-e341-44c1-d96b-08dd5fddb5e8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:13:20.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9737

--------------90cviyC7MfcmJBCM298VqtXc
Content-Type: multipart/mixed; boundary="------------HwmXL0ZhxVv2xX35fL5YIkjF";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Felix Fietkau <nbd@nbd.name>, Nikolay Aleksandrov <razor@blackwall.org>,
 netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: wiagn233@outlook.com, bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <e5c02f78-ea62-43fc-b8a8-cab5b29f72fe@outlook.com>
Subject: Re: [PATCH net] net: bridge: locally receive all multicast packets if
 IFF_ALLMULTI is set
References: <20250217112621.66916-1-nbd@nbd.name>
 <37bf04ee-954e-461f-9e37-210a8c5a790a@blackwall.org>
 <7932cd23-571e-4646-b5dd-467ec8106695@nbd.name>
In-Reply-To: <7932cd23-571e-4646-b5dd-467ec8106695@nbd.name>

--------------HwmXL0ZhxVv2xX35fL5YIkjF
Content-Type: multipart/mixed; boundary="------------ThZoOY2To5LjgGn07tDZlQpo"

--------------ThZoOY2To5LjgGn07tDZlQpo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGluZyBmb3IgbmV4dCB2ZXJzaW9uLg0KDQrlnKggMjAyNS8yLzE3IDIwOjU4LCBGZWxpeCBG
aWV0a2F1IOWGmemBkzoNCj4gT24gMTcuMDIuMjUgMTI6NTQsIE5pa29sYXkgQWxla3NhbmRy
b3Ygd3JvdGU6DQo+PiBPbiAyLzE3LzI1IDEzOjI2LCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
Pj4+IElmIG11bHRpY2FzdCBzbm9vcGluZyBpcyBlbmFibGVkLCBtdWx0aWNhc3QgcGFja2V0
cyBtYXkgbm90IGFsd2F5cyANCj4+PiBlbmQgdXAgb24NCj4+PiB0aGUgbG9jYWwgYnJpZGdl
IGludGVyZmFjZSwgaWYgdGhlIGhvc3QgaXMgbm90IGEgbWVtYmVyIG9mIHRoZSBtdWx0aWNh
c3QNCj4+PiBncm91cC4gU2ltaWxhciB0byBob3cgSUZGX1BST01JU0MgYWxsb3dzIGFsbCBw
YWNrZXRzIHRvIGJlIHJlY2VpdmVkIA0KPj4+IGxvY2FsbHksDQo+Pj4gbGV0IElGRl9BTExN
VUxUSSBhbGxvdyBhbGwgbXVsdGljYXN0IHBhY2tldHMgdG8gYmUgcmVjZWl2ZWQuDQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBGaWV0a2F1IDxuYmRAbmJkLm5hbWU+DQo+Pj4g
LS0tDQo+Pj4gwqBuZXQvYnJpZGdlL2JyX2lucHV0LmMgfCAyICsrDQo+Pj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvbmV0L2Jy
aWRnZS9icl9pbnB1dC5jIGIvbmV0L2JyaWRnZS9icl9pbnB1dC5jDQo+Pj4gaW5kZXggMjMy
MTMzYTBmZDIxLi43ZmEyZGE2OTg1YjUgMTAwNjQ0DQo+Pj4gLS0tIGEvbmV0L2JyaWRnZS9i
cl9pbnB1dC5jDQo+Pj4gKysrIGIvbmV0L2JyaWRnZS9icl9pbnB1dC5jDQo+Pj4gQEAgLTE1
NSw2ICsxNTUsOCBAQCBpbnQgYnJfaGFuZGxlX2ZyYW1lX2ZpbmlzaChzdHJ1Y3QgbmV0ICpu
ZXQsIA0KPj4+IHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYg0KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwa3RfdHlwZSA9IEJSX1BLVF9NVUxUSUNBU1Q7DQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChicl9tdWx0aWNhc3RfcmN2KCZicm1j
dHgsICZwbWN0eCwgdmxhbiwgc2tiLCB2aWQpKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gZHJvcDsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoYnItPmRldi0+ZmxhZ3MgJiBJRkZfQUxMTVVMVEkpDQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBsb2NhbF9yY3YgPSB0cnVlOw0KPj4+IMKgwqDCoMKgwqDCoMKg
wqAgfQ0KPj4+IMKgwqDCoMKgIH0NCj4+Pg0KPj4NCj4+IFRoaXMgZG9lc24ndCBsb29rIGxp
a2UgYSBidWcgZml4LCBJTU8gaXQgc2hvdWxkIGJlIGZvciBuZXQtbmV4dC4NCj4+DQo+PiBB
bHNvIHlvdSBtaWdodCBtaXNzIGEgbWNhc3Qgc3RhdCBpbmNyZWFzZSwgc2VlIHRoZSBtdWx0
aWNhc3QgY29kZQ0KPj4gYmVsb3csIHRoZSBvbmx5IGNhc2UgdGhhdCB0aGlzIHdvdWxkIGNv
dmVyIGlzIHRoZSBtaXNzaW5nICJlbHNlIg0KPj4gYnJhbmNoIG9mOg0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoKG1kc3QgJiYgbWRz
dC0+aG9zdF9qb2luZWQpIHx8DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicl9tdWx0aWNhc3RfaXNfcm91dGVyKGJybWN0
eCwgc2tiKSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2NhbF9yY3YgPSB0cnVlOw0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBERVZfU1RBVFNfSU5DKGJyLT5kZXYsIG11bHRpY2FzdCk7DQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4NCj4+IFNvIEkn
ZCBzdWdnZXN0IHRvIGF1Z21lbnQgdGhlIGNvbmRpdGlvbiBhbmQgaW5jbHVkZSB0aGlzIEFM
TE1VTFRJIA0KPj4gY2hlY2sgdGhlcmUsDQo+PiBtYXliZSB3aXRoIGEgY29tbWVudCB0byBt
ZW50aW9uIHRoYXQgYWxsIG90aGVyIGNhc2VzIGFyZSBjb3ZlcmVkIGJ5IA0KPj4gdGhlIGN1
cnJlbnQNCj4+IGNvZGUgc28gcGVvcGxlIGFyZSBub3Qgc3VycHJpc2VkLg0KPiBXaWxsIGRv
LCB0aGFua3MuDQo+IA0KPj4gQnkgdGhlIHdheSB3aGF0IGlzIHRoZSBtb3RpdmF0aW9uIGZv
ciBzdXBwb3J0aW5nIHRoaXMgZmxhZz8gSSBtZWFuIHlvdSANCj4+IGNhbg0KPj4gbWFrZSB0
aGUgYnJpZGdlIG1jYXN0IHJvdXRlciBhbmQgaXQgd2lsbCByZWNlaXZlIGFsbCBtY2FzdCBh
bnl3YXkuDQo+IA0KPiBPcGVuV3J0IHVzZXMgYSB1c2VyIHNwYWNlIGRhZW1vbiBmb3IgREhD
UHY2L1JBL05EUCBoYW5kbGluZywgYW5kIGluIA0KPiByZWxheSBtb2RlIGl0IHNldHMgdGhl
IEFMTE1VTFRJIGZsYWcgaW4gb3JkZXIgdG8gcmVjZWl2ZSBhbGwgcmVsZXZhbnQgDQo+IHF1
ZXJpZXMgb24gdGhlIG5ldHdvcmsuDQo+IFRoaXMgd29ya3MgZm9yIG5vcm1hbCBuZXR3b3Jr
IGludGVyZmFjZXMgYW5kIG5vbi1zbm9vcGluZyBicmlkZ2VzLCBidXQgDQo+IG5vdCBzbm9v
cGluZyBicmlkZ2VzICh1bmxlc3MsIGFzIHlvdSBwb2ludGVkIG91dCwgbXVsdGljYXN0IHJv
dXRpbmcgaXMgDQo+IGVuYWJsZWQpLg0KPiANCj4gLSBGZWxpeA0KDQo=
--------------ThZoOY2To5LjgGn07tDZlQpo
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------ThZoOY2To5LjgGn07tDZlQpo--

--------------HwmXL0ZhxVv2xX35fL5YIkjF--

--------------90cviyC7MfcmJBCM298VqtXc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmfO830FAwAAAAAACgkQX75KBAfJsRkv
Rg//WQ4A8WHneV+h0Fjp8Y8852kgY/kFxA+vw80FQBKfhCRzY9Panfg9rXxCGzs0OTJ4wGbUO/vS
ND2eu/3joVqCLRLgAcImrPHgjLknTqnEWq3lCcEGNowE7DiVdCcPc90GW8IWTrJQ69NNCf8rd3tr
8ZCAnsaXrH+2pe0F04j4s98CYS0UYH48aFNJnzjScIW448/JYmmZ1dB4as7SENIsxLFiVRi2HZoR
pLg6CJsSpM9MVXrp25/rvO4oPRldNygdW5g2QFdvz0gXTzgld37Ku8n5ZsWd7eCFRW4jTTKtmiGu
XYQIM2wVgSXsoQOJNsTyih2yNIRmdFJG3YfRUI1h5B+M/vcRVoE6GnwoMiRuw1W9PWcepUpIpJtu
OSwwZ4wPFSpBvTwe+t09k17+1BeBJSFBGfMWpdgmjHfX8tLwTPO5paqKwiLNKJ9vjXH0W/+8mgk5
Fcd0w7PrDuCWg5GgsuVmnssw01q4tHby5VwXG/7Y+L+brqCDzPSIuhxMEK3WrOHa3LT9KtJ+J/0s
++Ep17NrNX96EZjyXy0e6xYBA+u9gHOK832ycXiIIMuok+OesJDAwSThEwLPyw9Ui7UoTPtZ8+yZ
TlBOCY1jiSuz0qP0KNyIwp4wRU7cMnuxYnlHE3Ixe/CgYWMqT9D9ck9aK83prY7G1WSRG7KfybbX
90c=
=keov
-----END PGP SIGNATURE-----

--------------90cviyC7MfcmJBCM298VqtXc--

