Return-Path: <netdev+bounces-284607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPNwO7OE+mkcPgMAu9opvQ
	(envelope-from <netdev+bounces-284607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:00:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9B4D4DA4
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4050D304F008
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880652C11FD;
	Wed,  6 May 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="mZhCMiXo"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020110.outbound.protection.outlook.com [52.101.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DB1E531;
	Wed,  6 May 2026 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025629; cv=fail; b=EkrI3ca/j5dW3xvfK1jK7Tdy98KWtG1H0B3nYDmgT3q2MYDIvOQdIcYwVEVtwvYAsV8/BDGjraO1IZzWwm1avmlr5nyI1jMPec6sLc0qVsgxAQDQQTJgr/KPiYdjQhiexH10Hq6XR8pNSqu0o7OPBdezmqLGJwel36RarAAiKck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025629; c=relaxed/simple;
	bh=hf8bkNQVVikLr2esfN8d8E8akp4BwQkgMfLqmnByJqw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kNkPLLSquDQMg3luFP9OkoFkL+D5hbny+EUS4apX+qF0LZOI685ej05OmCbsfVGF3GXMXXh4okLM/Jmv/OS8xmT76dNEr+THzPX8pZJL6tBTJwZ2xFyogvmQQHsv1ibCqLP+8KLA9w9zSC3hB0OCZcrUvcn7bXGLALlrmGdwEvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=mZhCMiXo; arc=fail smtp.client-ip=52.101.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOllEwp6DeG/eyRZXCgBb5tIfMaTa9j/DdNJ6/74ON66j9exOapw+J8wBN1OojSNs97rKofU8B/v4D2V1ndpis5v/g0iLwZ5wiVIjPpnb+RCSt3o2wZ5J3Wda2atIq+pA1ZSKJIjmBrr6bCBzbFLCO54hlG1FAZTW3UDopyCpJzvZTodseumZWm1VcSx2cSE0CyueaH0LEbNdYMCRG7PfedauD5Ol1r4IGiiisLG+Ykk6s7taD59grcSc79MQSkj9Ye3SXIAZbw2ljOMyDQWI58VgNTU8iOSWOkka3Eq1I3aFiBv8e4ZecwP8oXnCgOgT+EnM0HYXJjs9Xcr7Xq0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YNIUtYOAEzFl5jRvxqILmZomuAINmo2Khle6yMwqNg=;
 b=JPe6pFI7H8I8LltszQLOlI2XacAiePnoyUIfxYtpPoxkgUTjAuUXmYz0ZvXoBaZ+dmuDN3oV199R/Eu/eW6XRNl1PRvdl3aJugvb9RJauG3UBpOXpI8TReJcnKJVWpU3mXPuov3MXdr6PX67U0wZsWx0jhe4oMnuZmhPNeWdhFf2+79FsLduvcJiLk2Bk/VXOsvt+iVnGmG4WffmNp/VC5wYIioFNObCjipPdNML2aex/HpsDscfLrZ1SI953QJuZG92xSnW9ts05B+C66k1fwcZqlPf3W5U4yrnuxrBdu6H8Mbe0RXPLLY9sFG82OvmEgtqMX6awQGpmt32JAxECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YNIUtYOAEzFl5jRvxqILmZomuAINmo2Khle6yMwqNg=;
 b=mZhCMiXoWVk2Xi5CXnCoZrKdsRta7vcB9T6mm4uXlEET14tVtf6GZyBt8CoiNJ+PaKUuB/cDCngZIHsWs/KPv6tNIsMQv+6zsfAJpLmAFGFgYOlgxLfqM7Pj37pCUahbSqyXUOghl1zcBfaAOCjAs4P5SkD8yKOZUqU97gyjPbVSgOnOmMUqBb57gtJrbUCaUNmKioPbg67PDuhgQ6ZNivH42qjVyoY/2qTfU4hcbh1AA8mwSXDkIAWhVWHazu5bkkghctL9gBikqnyELwtcgdzB3nnIDvG9Qhzr+FuXxAx+eLCfZFmsc4ZAY0VgB8yBH0QY0549BI1CTHkd0vqFEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by DU2PR08MB10132.eurprd08.prod.outlook.com (2603:10a6:10:49a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 00:00:23 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 00:00:23 +0000
Message-ID: <5f3b3b38-1b53-4b9a-9673-de4ca321b3f1@genexis.eu>
Date: Wed, 6 May 2026 02:00:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC PATCH v5 08/10] dt-bindings: net: pcs: Document
 support for Airoha Ethernet PCS
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260505182713.27644-1-ansuelsmth@gmail.com>
 <20260505182713.27644-9-ansuelsmth@gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260505182713.27644-9-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::8) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|DU2PR08MB10132:EE_
X-MS-Office365-Filtering-Correlation-Id: e881d99e-7dcf-45e2-c583-08deab027849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AtjM9YpRxieDJ5F7seLmYaefnBV6lXyaCcoJEFalH5uSETeGUFIwLmx88rRUedRwBztN1WbAht/+oXqPeE+6vg3Xx71/r8G+pNe8o8uOfKe1i37vN6GrL43POxdR66kIzVinXHHLSBHeeiYz/5n4M613s2PuMPsjqVKMAPZHjOF/SqJ3+xvkVWK9DsKb/PSRPOcbx5iolzNxpqrfGII+cEApvIva3XaFHqrJ6YL2jkSY+N0UjlfChGpSV9JFwwgb9/b0XdjlODB6GD07hofUEddabnMeDa7HFPgbiMl1vF/MTXlRwsHLw0XgtvhzScjNCU0oLImqc7kBeIlhhM/H5xe4+8/bQ+lS/N3wJC3pqcBWK9RjUObVJEJK9uPxfH3yYXtmgtvQrOROkeyJNHUaElI1e8MiPf3+zcbei0k8AM0alnus3l0EFdH2K3HwA+FVj+5YVOqo6ltl6Q/3lzJxt3WOrkxOFIMNQigZ1eaBvaZnPT9NiWb9wMHhgj27rMdNlv070Q1JUNGpecy8yo9Knuciz966h6J2MW68H1teE7y1Yy5r2MTisQ6ebxm9LqfcUiLmydh85vF9Cot83QiVzDAtzNuIewEa7HTR2vvG0xz8DOcixot6YanwxnM0RO3qVpXJn7luFIVj7F/Yp1kJbahtP5KiqHxsh7wdrnG/JL2yni3F4Jy5QamzJDRsh4T1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3VhV0lpZ296VS9SdEo3RWs3NDVWZTYwaGNPWHA3alNOaEdhS1JNUkpDb1hC?=
 =?utf-8?B?SGpsdnl0eDdRUWFYSzVteHc1VGk2QWZQbW95bWhsL1UxVjZEWmlHakVhbXp2?=
 =?utf-8?B?T05xMEw4MGFJRmZMamQ3akRocW0zNnc1L21UaEdBdk05YXJ1VHE1VzBGQ0tV?=
 =?utf-8?B?bFFjMnUwTmsxbEd2QzV5Y1M1cG1mYUZuRTJPL2FYRFJTOUcwYzNkZ09yWHhZ?=
 =?utf-8?B?T3hsNnQvbGpQU0xjVjVNRlZhRk9rbEhIZjk5QzV3elZ4SmtCUmNVNEozUXhV?=
 =?utf-8?B?YTZJTzVxVU1FRy85cENCdW9iNy9UcjhqZUtNcXZQWVBPQ2d6TStJb1loa2Fw?=
 =?utf-8?B?Z0FRcThpVmFUaTRVSmh3eUhVV2pQOGYxWjNRQ2hIaVFiR2lIUmM2QWxRY0th?=
 =?utf-8?B?eGd2bFU3Y2ZPSFp5MlJlNW41VVc0b1FpY1dzRld0Z1pDK3NtbXphdE5FNnlU?=
 =?utf-8?B?V1llbmcwTm1acmRBSGRvWVhCWTErelJPdGtzak5sL2dWYmh1RFFVdXhzVDh4?=
 =?utf-8?B?eUZqTDQzcGtZRjJSMHRwTlVqUzBQMHMvM2RaTTdSWitDdndEK0RGMzRDNzc2?=
 =?utf-8?B?eFc2RDl1dUl4Q2xaWUZvaDU5cmlZVUU4MUdlVHVGZ0YyTFptM0dtMjlRQ0hx?=
 =?utf-8?B?RmZpOHkrc2hlUHdkQ3VYbXFTVENKWHNHUjRPOVRzT2h4SUR2QThENWdNd1dJ?=
 =?utf-8?B?YStHNFlha0lrMnJBOTA1MmxsZHNqTmZEeWRhZ1NmbUJJZkpWdi9qb3VnTVhZ?=
 =?utf-8?B?THFNQ05RbjJkS2xpQWlYWjdxclpDbFZrSzh0dUZscGdka05Rem45WG56NmxX?=
 =?utf-8?B?dWhPSzR6R084UEFtME9wQjF0VXBFUUdlV3RFcFNSLy9yVkhxV1NOcXNveTdF?=
 =?utf-8?B?cUFGTE9HRWtLZnp3VWVJei8vSnFBcGF5NnYxM3oxSmVkWHpua1M2WktKN25q?=
 =?utf-8?B?YUtGZWhQWkVOTDBTcFpwdUgyeWVsQm1jNitHVmNyRGNFSzRmaGZlUUxBQ1J1?=
 =?utf-8?B?S1JvZHFaTjlYcmttQ2pMNTR1bEF6dk1pdXB0cmpTOGJ4amU2N1k3c0h4aTQw?=
 =?utf-8?B?QmhLbTd5alFtRDJHQUdkZWowY1JiN09ZUnpkM1NIOS9meDUyUFhDdy9acjcv?=
 =?utf-8?B?N2w3TjFGZS9iZEpVUUhNR1JMRlRYd1FpaEJxbGsyOTJwWkhxbk5MODd3UnlQ?=
 =?utf-8?B?RlViODdVWXAwTmtqNi9vS2E0U0pyWnFBVWJnY0NpbWdrbEsvNndmZmpMR3JE?=
 =?utf-8?B?WHh5T2JjaVdNdHBrT3B3VTRnTHFTUHRoRkFPd3krOUluNUxnREg5MXVuZWlC?=
 =?utf-8?B?a01GdkV2c1pVTEJWbmJSazNjRVFoaFpBNDFJalFHUjNLU1dnOEUwT1NXaHdW?=
 =?utf-8?B?SStIWERPZVpkTHRJTmNyYkszcm1xRENodDMwdHZnMlhyVVhwNkZyTForaEpy?=
 =?utf-8?B?OVZLOVEyeGtjbVByc0pOaVhsV3ZVWmQ2bWt3WWJsS2pMTmdUYTZCOVVQSWZC?=
 =?utf-8?B?NnMvMEg5MVdEZ2ZsMWFVeUpoSGlXRSthc2Fkc2xvd0lmNkp2TDlmUGhCNmo1?=
 =?utf-8?B?Zm51RDBlYk95enZoM3JIdCtMKzgvWTU1L21QMGg4eWs3dVc4eHRUZ1FJNy85?=
 =?utf-8?B?UlhtSktQSlJoT2MvdGZKYkVUVVQxbnp1TlJHNHZRZDFQVklsMHd3alU5dkJK?=
 =?utf-8?B?ZEZBWU1saHJOaXFOOHdoQmllWS93QmthdlczbVA5WitJL2VVMGRad082Rllo?=
 =?utf-8?B?ZjZVczE4aU55dzFhVVU1M29uV3pKcmhidStPeHl1ZmtJWGpBbzFROXhIVzg5?=
 =?utf-8?B?c29FdWt5QXE0dkJrUEVpK3RSYkdPbUZQd0ExZGgxL29ITGVPSnlxbU9rZkFF?=
 =?utf-8?B?eEpXdjhJemV2bmQ1Vi9oN00zUG5sUW05c09EWjdlZGtFQnJEQXp2ZzFOajlh?=
 =?utf-8?B?cjBvSEhLSWNSamhDRjIvdCtMSkxQM2UrZlhhaWF1VHYwS1BHbC9uTDRRc2Uz?=
 =?utf-8?B?UVZLR3BkZGM0Mnc5MFIyRXNFMS81NENQamt5d3RXVjZFMEc2eXA1aUhhSFlQ?=
 =?utf-8?B?TUhzRFFxZDkrVUpaancrWERCc2pTaStQMnVkMTQyWXQ0cDFRM0hDQzBDQ2tL?=
 =?utf-8?B?V201bHVxTTNSUVBtMGhDTlROaW82dFBOWGVvVnpVQ2pURTJiSlkzeWxrbG5x?=
 =?utf-8?B?VDdjZ3lXMXBBV3FvdkZrNzNmUjdNM2REWlNMNTlvYVAvdkxhcUJWOFFMcU9Q?=
 =?utf-8?B?Rk5nblIxanM5SlpDczNKQ0xvTERMOUFNOWhNTE80VnFSZHNoOUJmcngrNUdF?=
 =?utf-8?B?Z1RaaWNRRXFoNmhvaGhzcWRLa3pPZEtBSnUrVHVxYjJsUi9XOUlTYjlpVkNw?=
 =?utf-8?Q?nhfJ2Qa1qKr1ul0c=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e881d99e-7dcf-45e2-c583-08deab027849
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 00:00:23.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfaybxIm3fCPu3JQQY2hV5/l8xWNE7VTzBbc3q88hHQ81bkYN9/Bz/7sj/BMaGyH1rvrngbr9Y61B/V3aKOBA1jEHZYpYQboNylIiWYGQyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10132
X-Rspamd-Queue-Id: A0B9B4D4DA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genexis.eu,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[genexis.eu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284607-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[genexis.eu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.larsson@genexis.eu,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,genexis.eu:dkim,genexis.eu:mid]

Hi.

On 05/05/2026 20:27, Christian Marangi wrote:
> Document support for Airoha Ethernet PCS for AN7581 SoC.
>
> Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
> the various Serdes port supporting different Media Independent Interface
> (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).

10GBASE-R

> This follow the new PCS provider with the use of #pcs-cells property.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   .../bindings/net/pcs/airoha,pcs.yaml          | 112 ++++++++++++++++++
>   1 file changed, 112 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> new file mode 100644
> index 000000000000..8bcf7757c728
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/airoha,pcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha Ethernet PCS and Serdes
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
> +  the various Serdes port supporting different Media Independent Interface
> +  (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).

10GBASE-R

> +
> +properties:
> +  compatible:
> +    enum:
> +      - airoha,an7581-pcs-eth
> +      - airoha,an7581-pcs-pon
> +
> +  reg:
> +    items:
> +      - description: XFI MAC reg
> +      - description: HSGMII AN reg
> +      - description: HSGMII PCS reg
> +      - description: MULTI SGMII reg
> +      - description: USXGMII reg
> +      - description: HSGMII rate adaption reg
> +      - description: XFI Analog register
> +      - description: XFI PMA (Physical Medium Attachment) register

reg or register ?


MvH

Benjamin Larsson



