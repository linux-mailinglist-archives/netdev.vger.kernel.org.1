Return-Path: <netdev+bounces-170361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F80A48582
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7F017E972
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511B1B0421;
	Thu, 27 Feb 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IxbInHWV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF801ADC7B;
	Thu, 27 Feb 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674021; cv=fail; b=SrLJK+odi+djFpCOdhyqT8/L3A7kBMmMjpn5sss33QOPN+g4tBNB473k8SAz2D0c7IufklxCkYStPQ7K6pIwHluDpwDWCUpIW4xiRRPVxFT86k1AWqbCEB6NjCBo1aiEPmjD2fkxPUtAhtjZ4n6KtMvAxJarQbO4t0kunbmulUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674021; c=relaxed/simple;
	bh=YNz2qurMTE6COVaq9N6UQow46F51+u0ImobhSYguksc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGMj5nBtVhZM84TVHxWLBg9q3F4LVhQ4yRF0KVJxFz9DqGGXUVUua7X+YxMMd93bKXPBPDuChY1ZXuIshIH6EHSYfL/u/kTwLX2PcvvbXWb4S1aRHwRZ3NSZNxps12CV1YN6JSk2d7dVH2M9fWgLJaUf8xL28GmFCNM/hxrET+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IxbInHWV; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcNNoPECBTeOQCZJ8oSUOL8jXDll3uzi/z/MJI+orh7tz4jkNLKxpclZ61GetyWEoo75VOAZuAm0qpD9OC9K2uaCg7mIaLKn1d58HyfG8Xpo9Lym+OIUfmZJHd3NGcfouXzi3CicvXlNF1qYMrqkzaTYpsfPXWsLAkaL6N9/MFflNxZiOH6nCAvClEDdPqVTrroAhxGnu+31wvoaTGYaRMghNSVrIxHtfvUWYqEjLea340aqRIVKCAQU75/Qy5tJ/9JowRmSYoTK7lGcLCCHYxpqnLCjCbXoQ2T4hmyO2uxR7kf2owt2nAvWYsSM559qu2jTKqU2d0N9U//jR2mi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neDtrb8betE9xyMCfoGFoacNlbRjnP0icmM2UBRpWRo=;
 b=aJ0f2oVgeuR4Hnazt9Fx89qwrnDWimikqYSH93lVk2Hq3TC2+PTyheDbF1pjyLqU+h3PTPhqMhgrF+IZmbxT0gUE28v2WLqBi4L50XCtbJlI3WaUSyvvnj7jqbOjF7GkUT0AmubYmE+TUY0tOemE79ttdu9taYqa+N6dlgAA5VSBFFjeRfgAjBc3Z2ujAOgoIBD7HTuQkyP2oXLyAAFVMSW7hviyFDHq7AkoYLCrqAgC0XZhWyKvQVNUyKv6LakZMTW/VSOUFXJDZsqnqXNfiaH2BSyuC7AemfyDdhfLkQ327oIrtnyqABrNoe+hHqVY+Q6iGEHeAwz96SIIyXLwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neDtrb8betE9xyMCfoGFoacNlbRjnP0icmM2UBRpWRo=;
 b=IxbInHWVm0NjsyuZokRisnN+hdjqnWJMXcfTxPRuHdH5ppmfq7dmC9rU6bzsu/LUMdwD4fNYbunjwMUwZ77a1ebxm3XB8Y0GUtw3UFh1KXe+PplrJ4s1KiE6yUZGq+d9Qdz4fevYB9Rf58pY5+ctgOYrWjZTAb1TeCgNN9H2Nhc82thl9+GYpxgaya+oNJHwdpD04FxdzpPcidu+sm98SJNwOGPVuJdZiXxJUDuzEwO3sPPqPvybIc6dpCBFES+rQUK5ZOrUkQFByh/2bmnRq2g34AckdPQiug5zG2AY16G8NPfjhRtBKn6hWY8uTIZh7PbPZ46lUvgCFKjxMdubZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by PA2PR04MB10188.eurprd04.prod.outlook.com (2603:10a6:102:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Thu, 27 Feb
 2025 16:33:36 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:33:36 +0000
Message-ID: <7f737895-339e-4a0a-abb4-cec8a61ba3b8@oss.nxp.com>
Date: Thu, 27 Feb 2025 18:33:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: phy: nxp-c45-tja11xx: add support for TJA1121
 and errata
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
 <6c37165e-4b8a-41fd-b9c1-9e2b8d39162f@lunn.ch>
Content-Language: en-US
From: Andrei Botila <andrei.botila@oss.nxp.com>
In-Reply-To: <6c37165e-4b8a-41fd-b9c1-9e2b8d39162f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0220.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::27) To AS8PR04MB8216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 173bba99-e72d-4a47-745e-08dd574c7b94
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkllcENtcktJK1dmNEhEVC9HTUdEZldSelliVUkyZTdlbHVGd0tDZGFKRFNN?=
 =?utf-8?B?dWRKaEd6V1dPTnBRV28vdXpTSHhBcjFKTW5ZSUtpU1piSHlrUU9wSFloay9K?=
 =?utf-8?B?ODJQbWdTYjArUVE3U1NrZThFeXZhMVlPakZ6bytrRWczUllPb2gzOUovOHdP?=
 =?utf-8?B?WlBQWjlKb3djR3J5SDd5THBUMElxRWpPZExrZnQ4SWxwWnNaRG9pNlZ4bXBj?=
 =?utf-8?B?ZzA4UFRWcElWWmxEclkrcEtRamdodlpzV3FCSVp6Q0I0NHdSL2lsQWxpZ1F4?=
 =?utf-8?B?NnhJRVNJUHJjV2tTcTRiTzMwMGpFVVBZQ2x1UWowYkZoelpkRlhJcHYwUzh2?=
 =?utf-8?B?SVFMRkhwOFJIbFVMcGVHVkVuWXpjUFQwR3g0TDZrdU80YzJWVkNHSUxHTlNw?=
 =?utf-8?B?RTdzWGNuTWc3bUdJMGgvL0FpQ1kwOWtPL01qOEN1Y084eWpqY3dBSlgvWW5o?=
 =?utf-8?B?aGhTRXc4UXhzaGxsNVE5N2FxVXNnYnExNVZzRENyQmM2NGp4R1lNNys3VUVN?=
 =?utf-8?B?TjI2ekE4QXkwdFJOeFBOY1VBVlV1MUVwRkpVQ3JlWGlJVGkxL0FKdTlJRk9s?=
 =?utf-8?B?OEdJWTZQY2o2dzFHdUxPQkpQZ3Nhd0hhSEo5SkF1Z1ZrTXdTaGdGTmh4UHFN?=
 =?utf-8?B?Wit1L1hnMDdNSElRZ0NCMTZESHN5U0FySXgzVXV6bEc4MEEyOVRqRjJVeWZL?=
 =?utf-8?B?NjRYYW01V3ZyZlZ3R243bG1BZDAycGNPVUNpcjhXRnkzelpoTy9QTm1nT1Bh?=
 =?utf-8?B?Rk53TzNrb2F2d1o5aWRnQ2llclRhcGxjVW5qTjN1M1RWYnY5WVBGQytSRmdM?=
 =?utf-8?B?TEZ1NlhFRU54a0hHRnVVanVGN2JzQnJENks0UHZLZE1SMjJLV2VUZkphMVZD?=
 =?utf-8?B?ZGZ1TW1yLzh6V2JjdlpFMmlFNE5qNnNCSFZPZWpZaHpyWjFYb05aSG1MMW82?=
 =?utf-8?B?ZVlqdytnRXhWUFhsU2M3QmxKZFJOdXZPYTdJRXE0cTBEc2VCWXhrT281b01K?=
 =?utf-8?B?L2IycmhyakptbmRtdG1kM1JXbmVEYjBLckN5Q01NK3AvdW5MTTZRNmJPN0hY?=
 =?utf-8?B?cHlvL3BOT2VUU1MzTlJpWmFwN3RJdDBOelZpUEpVZWVldUQ1WDNBMTJuQ0NJ?=
 =?utf-8?B?NFU3MzRsMG4wWlhSSGhBZWpiZ1NzMER2ZGhDQkdvU080dmxWZko0UHdJLzVs?=
 =?utf-8?B?em1LR29mQ0VEL0paaFFMV1ZBVDlIcENoU21SYkN3NnZkOGxseWJlZ2pCQXJB?=
 =?utf-8?B?Z1g3anAxRWkyMEc4eVFUZkJIRHE1VjBDbG1QNHNlVnJJd0dSR0xtWENQNmVL?=
 =?utf-8?B?eEhUVWhKWS90b2dHWHdmVy9LU0hHdjBTa25LY0Y3UDdvTGg4dFBuTXB6a2V4?=
 =?utf-8?B?MDkvQlRaRFh3QmFEdUNtL2VNSFM2b2FnUzUyY2s5Yk5lSjJyUTc5OWRyaDRa?=
 =?utf-8?B?Qk8xcTRuVHZhVXNRZ3I0bnJJTHozNWRLc1FWM1dKbTV5RlMxQmdZZmNidU9o?=
 =?utf-8?B?ZmxGbCtoWFhLdU9OZ2M1RUM5Wm03am5lM25ES0V5RmhPVC9lUDdkcmcyME9o?=
 =?utf-8?B?YzZkVEdYS0xhRThLV3NCaDZNMklnL25YSG1VVTFRNGRDaUhNbWVvYnRlRWdY?=
 =?utf-8?B?b2dOMXkybUlrdTJ4SzdGZno5UmVjTWZxRXJRWm05R1Y4R0l4aUw2Wm10cE84?=
 =?utf-8?B?dTJKS2lZc2RuK2NVNUJBQjFwYzdGRG9lNUlDWldiZGIzSElhRGI1TUErL2hO?=
 =?utf-8?B?UlBRZWltUUt3bk1BZDgveTFmYkhMNHhHZmlrVXEydXZCWFdIeENjVFVIa1Fv?=
 =?utf-8?B?ZTArM2JjSTliUG1FRjgxcEZiWDQzUElsT2wyTDliTmhXVGxrVXdySnBUeE85?=
 =?utf-8?Q?67r58ce3oh2vz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjVHVmo3b25jYWl5Sk5CQ3hzSjlBSmVya0Y5ay9SdDlQRUVlVms4WWs5ajZO?=
 =?utf-8?B?YXBLKzlRakRIdG1aT2F5a3B1M0ZtTDkzQWZMU29adzNBSTVlRHRQU09CWU1a?=
 =?utf-8?B?Q2FNdVFvdXkwd1dBcEpBNTFBbzlVc0RNbmlUYm5nd3UxSEFjbk9GQlUrYm0x?=
 =?utf-8?B?OGE0QkJLUzNSOWdxMXg2aytvanlEeWEranpsY2VrSHVVTDBiWGZEa2dzVS9o?=
 =?utf-8?B?dzFZajVkbTJ5aGRJeUNrekhRYmZhTDZHaEN1OWZBQUJNM2VtdVpKMkpuV3Jk?=
 =?utf-8?B?b2p6clZsZGQ5bm9MRUw4aHFRcEk5eTY2N3JhT0hBdmIremJyQ29oR2ZWYUM3?=
 =?utf-8?B?NEZKUEZXZTZOVzJHSHYyS0Jzdy8ycjNCanR3cW5EQ0tOVXlTeXdVVVNGcVQ3?=
 =?utf-8?B?YmxHeUFWaGR6RE81YlpuWlNDZ3R2ejI1K3dFVlZaaUVmTENBZTZGeHJNY3dy?=
 =?utf-8?B?c2RxNDVoTnNhek80QXluNVJjTUJEcllTblZ4c1NXdHFQcmRLVHJVU3NSeXRp?=
 =?utf-8?B?dzdCN1NsSWthUE93ZGhUZEVCNVdCeWd5NWFVNWo3d0FoQ3JXeUZOTGRvdGxp?=
 =?utf-8?B?dlBFdk9UVzB3dHZJeldqc2hUM0xiVHlhOWNPZmp5d0c4V2swRE9qSDYva2Vp?=
 =?utf-8?B?VWJhVHgrdk90K2JWdnpsUGNaaUtyTWwrQ0grMUxqdTE4N0FFK3U3ejNuRUZV?=
 =?utf-8?B?ZDVrZ0lYb082cnNYS0FObWNvU29iNVQzNTI1SkUvTVk3V2x6NmFBYWxyMkhT?=
 =?utf-8?B?RjhlWjZCWEMrQkJSM0RDRUlzNFZFa0k5eTFBbG9CZTc2ZjBaMEYwaDZPdjFP?=
 =?utf-8?B?dFlmV3JVNmNGd0Rzb1dhRXQzS09iMmdIdzJIOGdZS05YaUFvMGh6a1ZrU1Vn?=
 =?utf-8?B?Zi85bnlQUUI3dTU1VCtSQXpIOFVrVHZxT25lc2RpUm5CcG5hczluSGs1WjMw?=
 =?utf-8?B?TzJ5MDdIZjBzblhQclFoNDlwaGpWYk4wTFBZS2hHSVdKK1owS2hrNU9BK1Ft?=
 =?utf-8?B?alRsSHdoc21wRHZQa0cxQk9vTkNhc3hXcXFud09qMEdhdVJqZkNkRURCWWE1?=
 =?utf-8?B?UGxDdk5VczVZdjhJNkdUU2NYYmxEb05QTDhTeWFCTk5qRytBNUlxdkZQYTAy?=
 =?utf-8?B?aXBBczl6K3J5YkVzdldVNTNvR0dGK3JncEJPdC9JZE9nSGxFOHcwSVIvVzc3?=
 =?utf-8?B?cTRxUW50UHRKY29lQXFTbWpFcjZoUm42SmpQVTBQZGFUaTRlV1N3ejgrOFA0?=
 =?utf-8?B?UmpJTXdpWXRELzhnN2tWTldHZExKSWwvamF3Y2Z5eFRsTkpZSzB6YlJ2NkU5?=
 =?utf-8?B?L05SODNrVlR3dzYrMjRZOG1sNnNUU253RTQvMWp3MURwTnlXcEZ3dE5FTklm?=
 =?utf-8?B?MldZWHU4cmZtZTl4eWNOWDU1VGxWWGJQMUNnZ2hrSG1tS0tyZUpFYi9wbUpG?=
 =?utf-8?B?MzgvdUZrSEtRSGVGRDRhWkNocFBKZVBiY3pTeDBVajN0OVh2czhaazJhNnVh?=
 =?utf-8?B?OE1OUEg2UzM0TE5LWHp6TGMyYWFpWEthL3EremduQWxzTHRtVHBGaXU4RW8x?=
 =?utf-8?B?SUMvUi9Wb0pEenF3M1B3cXhjTlRqbGx2cmQ3R1prQjdkdDRDRERMaEVRNjBF?=
 =?utf-8?B?ekM0YnhqK0lTcnJ4bGtDVlF1TU41V1Z3eXRBZ2F6bnNGeEVRSFJCYWRscVRw?=
 =?utf-8?B?S3UzakZoL3hacjBZRzBjWHZzdWlBQWtMM3J4NVlUMnQvWSs3UUllWmFqdk1M?=
 =?utf-8?B?bDdPVHV5K2RPUVlnYjY4d0xJOVdJWm1RYUJJY2w3UDEvbURWajhMRERFeG8z?=
 =?utf-8?B?aHpvMDNZQ25GMVkzckdWazljVlkvdkp4RitSTGhpOC9XbVJSQ1JTb0VCUWVF?=
 =?utf-8?B?QTdXWjlGeFVKZEFyRWxXYTNJcE56WEhISG5qM1NsVm1FK2RlOGxldVBEK1pa?=
 =?utf-8?B?Y29nU202ay9LWTRNc3lLUjhHSE9iVWpscUNWYlF4N0FBQWRacy9MbUdTZE1J?=
 =?utf-8?B?eXJOQzgzMWlsTXpaNEZWRDk2QkpaRFF0T1lQa0RvblZIY21OSUYyN2dldGVl?=
 =?utf-8?B?NCt5QVo3YjR2endzNUpaUXU2RHlEcUdYeFVXcUZDc3Y4OGRKcnMreXJiOGVV?=
 =?utf-8?B?bW4yeVVxZmxYYXloUG5iVFhjTTFIOU5zZ1REK0xsMDBxSXVMcitYVFl2dWwv?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173bba99-e72d-4a47-745e-08dd574c7b94
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:33:36.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0I119Co1RUGFpsSVKrY+J9e+0N1jxQZIQ+OFqne25DehPe3MUQR60msNr5UZ8iRXTUrtqJTIBOgZ3XOZ5Wm6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10188

On 2/27/2025 6:11 PM, Andrew Lunn wrote:
> On Thu, Feb 27, 2025 at 06:00:53PM +0200, Andrei Botila wrote:
>> This patch series adds support for TJA1121 and two errata for latest
>> silicon version of TJA1120 and TJA1121.
> 
> Should the errata fixes be back ported to stable for the TJA1120? If
> so, you need to base them on net, and include a Fixes: tag. Adding the
> new device is however net-next material.

The errata fixes don't have to be ported to stable. I've made a mistake 
by not putting 'net-next'. The entire patch series targets net-next.

Best regards,
Andrei

> 
> 	Andrew

