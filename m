Return-Path: <netdev+bounces-170360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F88A48522
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147D13A68C4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B11B4232;
	Thu, 27 Feb 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XEAEYMvw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5191B0420;
	Thu, 27 Feb 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673854; cv=fail; b=B2uQmkQBpoZeYg/O1JIlfNTDvv5v6tLXvRLp7QOubFpziZg4kQZ2Wp8hk/3xblzJTz4DqnpabfHd6xFCx6/NvLZ6bcVwg87Q78Im1dQqXJRh7H7cQ7IcZ08piGQ8SY8vTHg0rttHNENxP2KxKiq9wy9Lb/0hHrrq4oQzXRcFYhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673854; c=relaxed/simple;
	bh=LMCCo1iY/QJKnFkSECYvun4oQpSUpf4xbXFtsi8gzNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nj+/ebx9cyXy3JbuM4QPf2socqtYKvSQcQ2Ftw7J5sLQOdmvL3+VFjaY5vVsWFQapEfs8fUMYEHSCT0N/SYUOmW1puSWk30t/EwEDMx9Q11vf+xkEK8BwjxbdtItOgxHqSvJNBl4CoXfX6KvIWdHvwdTkzT0qffjK37IYLTL6C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XEAEYMvw; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwUna1C5riqxteEfeW43ZPzSkOReVCv93TTw0mZ9JArK9asVsukrxuOjop6X9xgHHYU0kqb1OIe61L/tZlmQ5/FgsVDE96zQv6TwjA0dDFNzwQ439m13TALGs86arpGPijDvC3agASs/IUMSpySrITr5rcqqr5VIGuFbQCfzZIh/lg7hQRvAJkHI3FkSpV5t6lkgEPwDBGLMrV05pLbNXxQ3YlA2JDiZDLxLJOt2zHlg/Zk0lrOq/38OAzWpSKD0ZV5OWZ7FwQkyRhouxwKvi/6xsfgmLVPz8cJLQdz/TRHYAxoMjtEu5vt3if8G6UWFT8ccOKhynM/ifrnKRK22Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQoSuMi3iybX7fwUEQw1pacHO3VkLiOpVbSfHSzikt4=;
 b=uoWsLKZzY8sO7l8JSI2mO282yINvPbxJ7hOvc5HQvX8YDIM4YEB70oXLfp3rXiysXcyZGkq8VdjS9tQICC2ETf6pjyrBTE+9aKYiSsE2/QPFaOu/ItmlQc3SRaV0enZ7DRd+jwsThPpb7dPSTPi3PjO7qjZZfki2tn36y8rR7ze2BBfr+gWEMjQ9LVHGqVvgWd4zwIUBhW4o0F2F2EtRzsCb50mn6cbJ2c1LmV4YlRh6epaguDwEaFHTw3YA6vuBhSXddzIyUiAPwJc4l1UGIcB+YIM/tBQ/UY64QQ6b5LDvjR99UDv/WYZTkQWAmlObV0EskL3FeL6/vp/eu6pZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQoSuMi3iybX7fwUEQw1pacHO3VkLiOpVbSfHSzikt4=;
 b=XEAEYMvw8wXW7J9rRvLLz3ZmrYoLRnAz4frR7unWnyb1Bka2fxgIZeb41nQIvuHPhwr1rp1s6HiJ1PLZsIXYSfjZX8xgmUUPEAPnOChZ4g/L6clFVZQPsh0WfbGf9JYIAip0/+4i6HG41hMTlzNAhMhZbFffCRGP8JPD6Wlhs4PYd1uHkI/NCYlUl+1JTPeTOeHzF1/GtNeV5Nnd2YNyH7EjykJRMpo4PsYIYkiB6i0Uy+Ok4JJEWT1ilmIpH9TcTGWSJoDG/qOdu2cj7MUdQugTPGT3dnTHOotSAd0awQvEEeb/p8DVIlsIecoF9J31Qpeh6CmC9q5ufVl1QDS/uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by PA2PR04MB10188.eurprd04.prod.outlook.com (2603:10a6:102:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Thu, 27 Feb
 2025 16:30:47 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:30:47 +0000
Message-ID: <9de3e4c3-9f9e-41c0-9e2a-19e95e859c98@oss.nxp.com>
Date: Thu, 27 Feb 2025 18:30:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: phy: nxp-c45-tja11xx: add support for TJA1121
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
 <20250227160057.2385803-2-andrei.botila@oss.nxp.com>
 <a9c98f2a-c5e9-43e3-b77a-0f20eb6cfa98@lunn.ch>
Content-Language: en-US
From: Andrei Botila <andrei.botila@oss.nxp.com>
In-Reply-To: <a9c98f2a-c5e9-43e3-b77a-0f20eb6cfa98@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::34) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|PA2PR04MB10188:EE_
X-MS-Office365-Filtering-Correlation-Id: d44c2606-ee90-4700-4aa5-08dd574c16d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGF4WmNJSjVFbWxVVGltTm80Zk03ZWlScDloUVp2M21JY09MS2lUU3V1ZWRY?=
 =?utf-8?B?VjFVMXdIVFRSY0pwRlVzeFpPaVdZb3lkbEdBT3luZW4weWxFOEszc1I3VmFo?=
 =?utf-8?B?ZlpIa2Rnck5iak0zTFZwai9OMENXWmU4ZzdiWi9wY3Qxam5OSzdCMFpRM1Mr?=
 =?utf-8?B?ZG9UR255VnFlTlNTdGtRZklDM1JyUnRPZlJPY1RybnJBc3p5Vnk3cXNwNEU0?=
 =?utf-8?B?dFVqL1NDd0FaNDhGT2dURUZveFl6Zkx2WlQyNnZoRjhjQ0toYWkzU2d4UTBr?=
 =?utf-8?B?bXFzWDhUQStMSEd4SUhoRkt6ZUg3d3lCOE5CbmQ0WHBiamkyZnZweGR4WkVv?=
 =?utf-8?B?NmFEK1pwUVptNnF2ZzhaWFlTR1NJaUhjcUJSZ0lwUy9KVzVjWUxEOTkvbnJW?=
 =?utf-8?B?M2lSUzcya0JDUklWT3p0OHJENXI1aytjQldHRHRsK0I2NjVMN1YwYjhyUzF6?=
 =?utf-8?B?ZEpsNkxUZm1HUk5Vbm85cHRvb1g1WlV6OXlObU9SL0pOaFFqeHgvNm9aSEM2?=
 =?utf-8?B?c21EVWNjSlNHdldkREM4TzRSR0ZrckhiTDVIV25OV2J3cVdDSUpYVzdTNXJV?=
 =?utf-8?B?R282U3lnRHJOL2VkQXQ3VnlZcGgrVnBzTVJycTA4aXlYYmJWcGJ1OEJsc1RQ?=
 =?utf-8?B?VVB4eDhBRXBOR1JhK1B2clpuRWdCaVR6RTYxaHdUMjJwKytMSUhYTmFYZ0dY?=
 =?utf-8?B?bHJLRmczV2ttMkFzRFp2S3FWVWJ6WFN5VGNtaFpNZVlJZnJ2Nm8vWWkwQ0tq?=
 =?utf-8?B?ZmxkSWNtYjNqc2VjRDJCR2RzdkZBTU9aL3RkbERQbnNaK0xqRExyZ0p6bWcr?=
 =?utf-8?B?b1ZqMmhCc2xoU3JFM1Q3RXZXVm00ZlVTL1JBenhQRnBDNm9tWkFibHRLY2lT?=
 =?utf-8?B?Y2RtbWgvQlZxNUQ0cTJEbklWeDJIczhWb0Y1SHBlWmN5SzhiWmxaVlBvV3RO?=
 =?utf-8?B?NUxtTEhLcjlRajd6dnQ0RXJVd0dnOEdPVUVpUGw0b2FIeHl0eUt2VVBOWnk3?=
 =?utf-8?B?TlJlT1FwMTRoNkZ4M3ZLWUxPYzN2MGR6Q0g0ajF5STMwb1NaeHVxaFFhL2oy?=
 =?utf-8?B?NExXbmhlMUkycDJMeTAyNmZJTkFJVWJFR1lqZFhLZStGZGFoNjBQL3VyQU5S?=
 =?utf-8?B?YWVpOGp1SW9semNac09JK2xuZVJScm5OMkNIbC8yVmZVYmdEWUNUQ2ZtUXFs?=
 =?utf-8?B?WUNINVBvYVVMTW40Mk5tbnBhWVNZaGFTcS9BUFNzNlEyOXQwdVlaMnZTcXpT?=
 =?utf-8?B?Y2xwVDQ2cUhSdldYNTZYTWxBeDJSMTJvc0ZBYXBmU0pqS2lwUE16UEtPWXY3?=
 =?utf-8?B?MCtXeHM3Zm5HRVdadlBwQnJ2VGUwbnBKd1BMQVFGdU13WGtvbGpKZmdhOSto?=
 =?utf-8?B?d3dabkVxMEl0cjNOeXVrR0dCZCt0RHY3a2tBSGpIc0xTY0pMcmhNVElCUXJs?=
 =?utf-8?B?NkQvT1gzekJwcFdzQjlqWUo1UE4rKyszVzV4TUs3Y25wRDVhRzdJN3lhRTNK?=
 =?utf-8?B?RnlJV2Q5eG1hY2pUR29VV1ZTMlFhSXowcDYxZHdmeTl2TEdFUWZBditGbnBq?=
 =?utf-8?B?S3A4Ykdjam5lUlFyNDdua1pjVTQyNWVidjZBR1dpcUZpbjlZTVN3QkdaU0Iz?=
 =?utf-8?B?WSsvVUFQaTVycU4vOGJJRWk4QzVIKzI1OW1TS1l0Vy9sMkc5NUxBN0FQWnZE?=
 =?utf-8?B?V0RNdlI0bVpOQUF0a0IyaDU1RStIcyttUVVsMW9XQTd0SzhkT2UrS2pCNWJ2?=
 =?utf-8?B?dmd1Nm9TdFh5UHVwSFN0YjA2dzFYY1Q1TmhmcFNsM0RmVW41R2pIb2FzbUFp?=
 =?utf-8?B?REY1UUZBU2dBVi9xU2tnU1c2NjBBbS81Mk5YM0l3Zkh0aWlUMGFHVXpnK3R2?=
 =?utf-8?Q?WksDnq/pmwEjL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmdpaTN0VVE1UlJ5TVhmVmpna0JEcmJFaWEzYjdFdTFla2pSR1RyQ0xvMjFp?=
 =?utf-8?B?V2JUdEJlT1BHQk4rcUF2ZDJsWDlGeXkzaVRRZ0FURVlYdnpPWEMrT0p1NzIx?=
 =?utf-8?B?eWJWZEtHTGtBTEpTTW9GRU14OThFSDFSUFZjUTJjSVF6WlhlZ3lmNWl0YnhF?=
 =?utf-8?B?YnNpeDBubzEvbW1uY3M3MU9FK3AwMGpLUFU2czZaUW1LVWxWRUJYK3N0NmpB?=
 =?utf-8?B?M0NZdjJXNkNaaEhQSGpCSGtMdGJmSnNBUzY3YWUzdjlsV0ZrRFFDa1liaE80?=
 =?utf-8?B?ZjZ5b3JWRUJPdHBrdHJpUmZDUkpwK1kwTDY5d21BVVhOYlVkL2MyTTg3R2hZ?=
 =?utf-8?B?YlorY21VcXJJUDBBSGY4VE9PR09Hc055bFZQbThwZE91akkwdzVaTGhHRS92?=
 =?utf-8?B?alZ1OG4rSzljLzBlUGxxb01wazMyWFl4UDlOYnpWTThMRWlRN2dFZW1kNnV0?=
 =?utf-8?B?R3ZwSEZkWjU1Vk1NbXB2NEdOVzlTWGxtcTkvRkRHRXAvQlFpNmhxejRuTmFI?=
 =?utf-8?B?cDZ6MEJpbTZla0RGSktBVFp0c0lieVM3QU9OWWtyL3gwUFNjUUhWQlRJZTJy?=
 =?utf-8?B?Z3ZkL0RQYVhmZ0Jtd3JiTVVGK1pRYXVROVRXaXdkdHRocjlvS05PNXE5SjNE?=
 =?utf-8?B?d1FORmRjRFZZMWViRlgzdk56cFM5M2FRaFVTMGErcTVremhZazV0Q0NWcEJP?=
 =?utf-8?B?cFQ2RlJ5RS94cXM3VnJmc1oxQ3crVVYwV3dFWlJ4eVhGNVlrSGJ3YVk3SU9r?=
 =?utf-8?B?Q2FVSEtlblNOcVJuQ0EyOEVTbVZwNGgrMS9EZ2pWRzNYbUxHcUZNOFkrM3hh?=
 =?utf-8?B?TXpBSGlLS21aWTNtbE1LbjNpcFI5UXQ0ZFY4eVVpUXBJNnhWZGdMaWRUVDBm?=
 =?utf-8?B?bG1SckROa1g1NnloUmhWT2JtUHkyR3NnRVdGR1ptN1B2VjNkb2dOZ2syMnpi?=
 =?utf-8?B?NkZIOFVMM1pQSXUwNStKYWl4NFQvU0FVendBcllPdkxzN0l5MHZjOW4vYlZ4?=
 =?utf-8?B?R2lPNWcxd1BUTWpiK0lhMjdDRFFEd0V0RXlZV3gvU3JJOFVSZG54azYvV1M0?=
 =?utf-8?B?VHIwZnBuT1d1MTNsSVN1aWFYK2pTSEF2RXV3cElFUlk1enl6L080eWJYRm9s?=
 =?utf-8?B?djVBNno2eTRjMEZMRk41bGk1UlZFVGVyNDM3S25FL1ViWVRobFhtZldHVDdC?=
 =?utf-8?B?dDBpekROWFlDdWlDNGJsQ0RHUUVKVzlFMDdDNHA5ZFZ0clM5S2hKMTVEQ043?=
 =?utf-8?B?dFBEc2tsK3Q2VWFJcG9uNjBKYkttSGNJb0ovU05WVzM4UnlpWTh5MExCMGk5?=
 =?utf-8?B?dGZiZG9ZWFYvdnRRV3E4aFdqVUkvbGJVT3RnZDdlb2VhUzN6NktQSzlIVjk0?=
 =?utf-8?B?ZlVneFFSWlBKUHByUmFLRk1kWXlSQVQ4ekJFbXQvbmU4dnFSSXRyeENpYzgx?=
 =?utf-8?B?YkdYTS96OUh4NG9rSHM4cnFaT1hCeHZLMHMwTm43WnBYWHowUmRmcUVTYzFZ?=
 =?utf-8?B?RTA0RXh0L2JJbDRPZzJYelpNOGdJb2NuWVRtTENheGVJNEpCYk5XTlBXcDRp?=
 =?utf-8?B?TTMxa0dJVkhxcUF5bXZQUmg0WDgrT3FsY29iUE9CYkgreWp6Wi9zMGhwVUVG?=
 =?utf-8?B?NGNzMUxnYnp5S0FOOFZhdktpaGl3R2ZnSzBVcDBUWVZmMHdpVnQxWVNNaGFl?=
 =?utf-8?B?Z3BRekVGSkFPbktLNUFwSDdJYy9XNFNvajI5REVFMHErWWpTZXlqWWZlSy9u?=
 =?utf-8?B?b0JKM1lPUGRlYmlUeS91SE1RK3E5ZnpoeUJtZS9iVld1cXZlbmhVWGloTlJj?=
 =?utf-8?B?bjBsQm5GbWJabmJ4cndGaXMwakZNUGJubm5rQ29MLy9ZNVRUV05oZGZlQThy?=
 =?utf-8?B?dTZvR3JscUNJQ3dwdHFJY0lHd1VHTjZ5TkJPRnVDU2VNdU9MZVV0S1UxTktR?=
 =?utf-8?B?Vjl1Qm8zNk1HTWV1VDJYUDlZNkgxVW9aQnRkaHZmR1NxQzFTTS9nbFVpYjBY?=
 =?utf-8?B?QzdXbFRyREVkWWhHSW40RHRSa3RSci9jUVpNbTcwazBMMzJhenRlYVFUMWdz?=
 =?utf-8?B?SVpKNUc3UlloVVkyY3lySUZJNThyKzhlclVOVVpHU0tLbXRvZUplS0lRNity?=
 =?utf-8?B?TlJnbzZtWCtKOGZ1Z3dIS1RaRUJZU2ZSSm9KTVZ3SHozU1RPNXZZT1pVaStK?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44c2606-ee90-4700-4aa5-08dd574c16d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:30:47.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03LGjSO7+F4rs69Y7LeMDlZ2QPNzVRi5lEpVtLpY3jUPoKJh+Wy1MJpAV+K4Rzt+dmQbLCzWKRhvX6smiHGlgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10188

On 2/27/2025 6:14 PM, Andrew Lunn wrote:
> On Thu, Feb 27, 2025 at 06:00:54PM +0200, Andrei Botila wrote:
>> Add naming for TJA1121 since TJA1121 is based on TJA1120 but with
>> additional MACsec IP.
>> Same applies for TJA1103 which shares the same hardware as TJA1104 with
>> the latter having MACsec IP enabled.
>>
>> Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
>> ---
>>   drivers/net/phy/Kconfig           | 2 +-
>>   drivers/net/phy/nxp-c45-tja11xx.c | 8 +++++---
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 41c15a2c2037..d29f9f7fd2e1 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -328,7 +328,7 @@ config NXP_C45_TJA11XX_PHY
>>   	depends on MACSEC || !MACSEC
>>   	help
>>   	  Enable support for NXP C45 TJA11XX PHYs.
>> -	  Currently supports the TJA1103, TJA1104 and TJA1120 PHYs.
>> +	  Currently supports the TJA1103, TJA1104, TJA1120 and TJA1121 PHYs.
>>   
>>   config NXP_TJA11XX_PHY
>>   	tristate "NXP TJA11xx PHYs support"
>> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
>> index 34231b5b9175..244b5889e805 100644
>> --- a/drivers/net/phy/nxp-c45-tja11xx.c
>> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* NXP C45 PHY driver
>> - * Copyright 2021-2023 NXP
>> + * Copyright 2021-2025 NXP
>>    * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
>>    */
>>   
>> @@ -19,7 +19,9 @@
>>   
>>   #include "nxp-c45-tja11xx.h"
>>   
>> +/* Same id: TJA1103, TJA1104 */
>>   #define PHY_ID_TJA_1103			0x001BB010
>> +/* Same id: TJA1120, TJA1121 */
>>   #define PHY_ID_TJA_1120			0x001BB031
> 
> Is there a way to tell them apart? Another register somewhere?

Unfortunately no, TJA1120 and TJA1121 share the same hardware the only 
difference being that TJA1121 has MACsec support while TJA1120 does not.
It is the same for TJA1103 and TJA1104.

Best regards,
Andrei

> 
> 	Andrew

