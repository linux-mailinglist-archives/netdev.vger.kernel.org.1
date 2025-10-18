Return-Path: <netdev+bounces-230646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505ABEC404
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 03:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0B803537C8
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23D1F63D9;
	Sat, 18 Oct 2025 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qOx3Unoe"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13C1A9F97;
	Sat, 18 Oct 2025 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752603; cv=fail; b=IfhYeenl6bgM74sRq/Y+2fWApl3MbSxEF7M5+yO12DFKiWPUSt45ApCS47GDmXNP3jOQ9MGXhgsmPy2wwt65XidV3kbK+cqIx81kfTqSn9K9M39clkEgdPDkfBJx7h2Ws7pKYqrWqwPPYM5U5qO0QQnQzaR8pzHPsf0r07XCx5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752603; c=relaxed/simple;
	bh=gZ58gUht+ebGtlvvf8+lfELFDjeEWZciDyjdkg7D8Xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m/5kgybmfC0b8eYU2vnTovD+R8TXn2/J9tWZPRDHiOezt7MLJ55rFka/nH4lSpUOdnweffW/pCM0zGZHRoP6QDb5oz3Lri4YHpP7OeVviOAl9bfBxVfe116XdgFVrZOi2CNmAOyT5s0Cle8TKEgyjOU2qwKTf0lwrsvJiSuVysQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qOx3Unoe; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWS4G28PjZn/FELUJcFx6FS0Zb9Ut+H7tR7T+dkPIrVAWPTxEeYyEz9Bw+LAxDMeXc4ti3x7QPfPZW2/xfEm4mrfh2udhKVpBSgH3bEYvNxGU+VzmLHZer4SoXKEyYT1lfLd9ghycqcsSA/zEMvyyKiJDQjKYuu3W0qjM713Bgka1JN1Bsty6xoKTRYekkfSb7kPv7FQOCsDEs0PkUL01u1OmlLOlkNPXJC3mjcLu0YsqS9O3kHOHGrnarmS6+uebcJyZXiR4mtHOA0sWEAqGNxW08uslBswc4xpD9+9vfZTv6yG0khZYSBaeVaa1s8U+fCPY90xQ3A/W7WqTIjTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ7vLXmWgn8vJcqynIHeEbIIGTPqyr7tXPu+2AlTh6E=;
 b=zI8eiu/ImJXCn7h/MjbhTei0np+W9goLwjAapmQ2r0AQFJH4BwTUgdTOAF8KLVW1UZd+6XabGV82Cbl5HR9Bmrcuw9IaPg8qWZK2YtOKvh6guEysB6gMQivUoAbWtsYRk2N17ccpQOEBzMUt+pOtjzV9+jwLXaj8kV20qXgdKHOBJXuXrXHLWCW2SuUCVirgxcwRIsWerSJ12e4j4HYc/hUbNr9Gg3rHvT50SYVL1MQo1lwlQcpKpeqt7UdmuWFqaCubH/aKtTdTqMQoJ1tFBG9Fj5VYeCtdTqbq3XC2QgooQHDwPs3g/nUu3XACaqUvTxVGHeuA/0XeW/9aftRFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ7vLXmWgn8vJcqynIHeEbIIGTPqyr7tXPu+2AlTh6E=;
 b=qOx3Unoe+NKGCp5mndA1VJ5J/HoovQAHwNAVFLMTxvdEmPkaLdzqoKTd0lgss9K2V9WvcF2wf9rHfW4o9vCe2DSlMyXP7886OxzDYcAjcuL5AUPhlckXhiR2cWlAwxTB6trj2e1YqCVmcr5dXYUhmfsJeJgWzNwy3QSWCHj40mrZ72mewDF0mvoDngnNuG0S04ZixRaSw2Gy7zsa8bjO38LobhhInBTB9J7OFLfZ3PB3AHpDvOmRBMqNOetc7LpNIdS4FWuG93Bl8dDNEZ7E4iDQRHhKZRRLJ7d3G7SefSFLYUAFwS6ZQkbutKQ0A155Yca4LqUKGTta01BpRixtyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by DM4PR03MB6142.namprd03.prod.outlook.com (2603:10b6:5:395::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 01:56:40 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9228.009; Sat, 18 Oct 2025
 01:56:40 +0000
Message-ID: <e45a8124-ace8-40bf-b55f-56dc8fbe6987@altera.com>
Date: Sat, 18 Oct 2025 07:26:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: stmmac: vlan: Disable 802.1AD tag
 insertion offload
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-1-d3a42e32646a@altera.com>
 <aPI5pBXnh5X7OXtG@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aPI5pBXnh5X7OXtG@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|DM4PR03MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ad59b5-3213-4316-1c16-08de0de99459
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1kzUVJ4LzFOZmtjdURtQW5SYy9oc0lmSDBLNXJSZk1lc3lBUFlJeElQQUtN?=
 =?utf-8?B?SkRPakVjUTAwZExVUDFSNGM3UFFTS2xScDVCNlZSRnk1Qnc3cHNpbDErZmdM?=
 =?utf-8?B?d01mZ0tVNTFBcjNhUFowOEc0bVlZWmlDN2gzd1krRlNBQXNPZW80eXRrUDA3?=
 =?utf-8?B?NjNlS3FSQXc0ZGMxM0FvU0JiUU52cndJQ3dNbXlFWjJQK3M1VEsvTGNESm5Y?=
 =?utf-8?B?Y3g3RWVGTFFXckF6cHV3OXR3cGpkWTQvY29WOVNaSnVSOVBzOTQzam12U0V6?=
 =?utf-8?B?R2JWam1haURSK1RFNFg3R1NxdXlpRE83a1djOXZQR3pUbmYraVZRV2ZHUENL?=
 =?utf-8?B?Sk0xbExuciszV211L1ZkWXAvUFVzeWkra1drSWN3RkRJRWE5VjMrcnZSRUEr?=
 =?utf-8?B?cGRLOUVROWlyRTVZbW9HRU9IZjRUQnBNbk41UEN3ZDlsUTNNRjN0VHBpKy81?=
 =?utf-8?B?N0MrZGN2MkxiZElQemJSY2JqdW8yRWFOc1gzbjNHNGxmZ3NJNVpWVEs3N0RC?=
 =?utf-8?B?TmZmL3IwTXhTVkRRUmJWQ0lrSXg3Nkl2M1BVci9WdnpxRWxEakVRZGlCM21W?=
 =?utf-8?B?YmRYWGN3MVBIU1pOWkhMdUxLYUZ4Z3l6QVBPeHc0U1FqVHJqdVhJZ0dGN3Iw?=
 =?utf-8?B?WFFrSEVVOFdWMVJRbHQ2M3BqdWM0UXUrS2pBMU93TVRzWk9YeFJxbUNlSGwv?=
 =?utf-8?B?aUZ5d2VhYlpWY3hLb3B6RG0wUG15cE5lZjRlcm9xMHh3L0xSa1A2RTI5cXJK?=
 =?utf-8?B?Y2R0NHAvYTM5dnp1WkdXQWZDd1Z1dyt3R2RVOUpUNEVVTVlNYWtNMXpmYWhZ?=
 =?utf-8?B?eSt1NXU4RzE4dUV0T1dlZERFMnRESEp2NGxvK1Fnb2hLKzB5RVFIeklCc0dX?=
 =?utf-8?B?cHUzcTdGL3RqT2tNMVBBR1VZVW1Da1FTb3FtZDJlRk1iRU9qSUJWMHJpdGdG?=
 =?utf-8?B?UWZMcmc3d1AxQTFNdi9pZGNIa052MjZaY3paQ1RQUERqVTJFL3lhSHh6VHpl?=
 =?utf-8?B?dW02Tm5qeDZrZDU0bEhBL0VHYk9sK2ltK0hiK1hwWUM2c3gyYk9Db2k0QXZF?=
 =?utf-8?B?K1ltQ0dLZVJDNGg2N2pEajJ4c28vMmgzWVNOUHh4b3JBTnJSbHZnbkE0U2Fl?=
 =?utf-8?B?Y01YT1pyZXliUG0wT2htWEpZcXRsVW5rc2w1VG1hZVhka2NQTWIreEoxSGJk?=
 =?utf-8?B?L21JamVGMUp0dUh3eXVUWkowWXNpZ0plYUdwMVNLaXc2d1dtOXc0bHUvMGd4?=
 =?utf-8?B?c1ppOUt1WnBBdVNyaVF0SkNSYkI3OG1zL21PT3NHNDlVcmVWL0F1a1pzK0M3?=
 =?utf-8?B?S3FSNEtULzlKNi92RGpXWG1tZXp2WnVrN0tTVXdSNVdLa1RIQTM2cVZpSGUx?=
 =?utf-8?B?U2x0SkY0TTFrYitTd0JlWW5hN240TDErNHlPcElJS2RiN2pQUXMxb1dhcy9R?=
 =?utf-8?B?TnBxWlJsMjZoRFljOFpNV2UvRlV5ZGNxZXFZZi9vT2ZNd3dqMXp2THVkellZ?=
 =?utf-8?B?SUNUOGIvWEJyUEN3aUNKN2x6RHFqcHk0LzdpQjQ3MlJhbU1NOXU1anFXRXRh?=
 =?utf-8?B?ZmtTVXNtNG4vV2NFQ1BQdVdTRURXV3FQYU9Id3V2NHZYa0RhckNIUlZsRzJz?=
 =?utf-8?B?ZWRxa2VpditYREl3SzZEV0pkQmM4M1pJek52aE90eW1mbG9aeDBBRGlTWWlU?=
 =?utf-8?B?Wjh3M29jN2NjdTJySVZvY1JCK29Wd0RPeC82L1V5WmIxYkhGbjBJYUx4bFVM?=
 =?utf-8?B?a0dSbEdvU1V2MngvakRINytJYlZvN2ZKUkd5ZjJ6TXUvKzNSOVVuU2FiRXdy?=
 =?utf-8?B?b2h3NHBPa2ZDb0hpQ0hQcmpWaStpNWxhMzB3b1B0dGlOU2ZONElDR1dlb2NH?=
 =?utf-8?B?T3YrODRnSjgwdE9EZzNBUjczR1hOd0Vnb0dhbE5VUXVqMFFJcHpkckx3TUJC?=
 =?utf-8?Q?kPOEmxb94AlVfl6Y1K/zvbWNZ5W+mvuO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2pMaXlPaVBWR3lGZHA2bis5cUNzU1dKWmNHSjN0VHNQUFgrK1d6OHI3YWhm?=
 =?utf-8?B?NzA3YVVDTUpzd3BrbjU3QjNSYnRVT040L0RzbTJwMUFrKzRpWlQ5RDl4aUJG?=
 =?utf-8?B?VzZuYjRDWXhKUVpaOFZoOE5mR1lnRzZiUHloRURDYTk0S2tFR2dnTmNyaWFs?=
 =?utf-8?B?d0g0SVVOOS9PNTRKVDBsMDFxcTh0c2l0MUR6Z3FRTFFQQUZLZndKdDJRdHk4?=
 =?utf-8?B?QU9DcHZzV2JLU25tMFJITFlOK0RmWjA4TWppR1FFZWthRHk1WHBPNDRCd3Q3?=
 =?utf-8?B?a2ZPNVlNU3BKQWF4VC9DclRESm4xcEk4VVRhVWVPT3htUy92NmswT2pQRDNL?=
 =?utf-8?B?elBrSllIRjJsZEFLaHQ5ZzZGcnNEdXZTQVlFZ1JnQklDZyttSTRIVWdid3Vx?=
 =?utf-8?B?TGZ3YVY4eUJ6MW1hNFFudFJEVXhueUdRc0N5RzhaVnBPY2EzYjNwcHBRbGdp?=
 =?utf-8?B?OGt1Rk9BYjNtOG5RQTBNdDk3eVR6T2dINlpiSEhBZVA1RW9YV0Z0aGZoU291?=
 =?utf-8?B?UWpnQkd2enRhZmxJS0NJZnArYmhsQ05TQjdHMkZHQkpGTkJYdjdMMHBXRFF4?=
 =?utf-8?B?VVV6bWJpdURHSkpZZ0FtMG9aVWlKRzdtVFpjOFNVUU5OWnVaUWJTbDI0TWFi?=
 =?utf-8?B?RitzNnhpdXEybHpHN3phSEc0RmZHcFVzcUtBUTl3QzlVUnNTL0JyNVpaYXlx?=
 =?utf-8?B?b0xOak9Wc3dnOU5iSHJLanlvMWNYVjlyOEpFNTZRUmRYZVBUaVhHQUY5SGYz?=
 =?utf-8?B?MFVBclBjOWJtcEdYM3g3TWdjZnUxU0hnbk1DazRYaFYrSmtpRnpSNVpsWDFs?=
 =?utf-8?B?S3lsNlBnQmhXOEFLemtLdHk2ZFUyQy9jS1Q5NUJlODZEbkNhTXRFakRPMWdm?=
 =?utf-8?B?ZWxpdmQvZ1lLVGZVS2NSVW5vV09OOWUrQUFncCt0SVU3dzhNMnJhNE5RandP?=
 =?utf-8?B?YU1JaUJZbjFCdlZtcG1tQ2s3ZlJsOHArYVNqYnovUG40R2szNWF1TmJ6WHMv?=
 =?utf-8?B?d2xibXpnUGN0bWQ2dk9neUNrS2NhMDhJN2M3YVNjb055QnJxM2g5VkNuY2hs?=
 =?utf-8?B?WDlnUnJlZldFdHRnWjVGNFZRcmxIRnlCbXBsSFVKdlRVcjh1VWIxRlVGallu?=
 =?utf-8?B?T3FycCtnb2RNRUZmaUtzalh4dzcxa0tMMDFGVThhY2pwTnRURyszSHBLdFUv?=
 =?utf-8?B?bEY1R0hZekdUYUNtUERVbHZFY3dPRk93UEdiOVE0NWltYnVJeEhHSU50SlEv?=
 =?utf-8?B?RWh1cUZWclZ0d1A3SUhBcFJpRFdGdzhZY0VVQXBjZWFwUGdNZGNnaExvdVBQ?=
 =?utf-8?B?M0o5cHhsaXB0djNxTDFZRnZZbU45OFl6THFmcnRWaWUrMDlBamJlZnJKQmNW?=
 =?utf-8?B?YXQ0cDBqQzVLV0NSSFR2Wktnb1hROXZkakVRUllUV3oxbklxRjRRWWJXemUz?=
 =?utf-8?B?OFUzaHVNY1EyM21pVnlETWJRK1NZUkhXVnE0VDcyaWJ2MlZCbEFaZlM0UG1z?=
 =?utf-8?B?Rjk0alppc3pSQVlRS1FtSmlmejdKczhKMFF6bkt2L1BlZlh5eEJlR2lxL01j?=
 =?utf-8?B?QUZ6Mms2YVdFZUhxUUZ6Mm5MMStveUthS2w5a0lhUXByNzhPanZrL2lBQTk0?=
 =?utf-8?B?RlRDZkpBb3h1L1pDQnZkejk5VHZFcTRtWUNRNlpveXhNWVZiWEJCU3JicUMr?=
 =?utf-8?B?QkpqcEIrQ0RVTHBJOXFrSFhGcktlL0w1MmtRMFpaK1R2MUpQY1ZqRmVCNzFl?=
 =?utf-8?B?UHRNb20zYjNLcU04TnZ0b1RBS0E0U1ZMRU9GSVFCa1V2WGZOSk51QlJTUnZU?=
 =?utf-8?B?UGRVeElvUzd2ZlZYY0EyQ3ByOFF4cXMrQ1c5d3JhejRLRGIyTjdkZ3Z5L1d4?=
 =?utf-8?B?THFrTEdrOCtVV0pmZ3p6cmlseS9iOG5SQTRWbERIcXlydGt3WCtCdnpmaU9z?=
 =?utf-8?B?UDhUSkJrTW5RVHZaS1o3MWhBTFZoRTV4QTVkdE9ob3l2d0FtK2Y1MGlpbkgv?=
 =?utf-8?B?VUp2SUl0clVSWWxPL2tldnBSUU9XaGR6RzJEOVk4aTk1ZmwyT0hyUmc4Qjlv?=
 =?utf-8?B?aXdKUFJsVTlDa3YvOXNJa0V6NXRYNWhFcUViSUN3NWxLT1JaSGU4WmhvSStW?=
 =?utf-8?B?SmlPNnVyYmRPRmd1ZXB1OEJ1eXJKTU05MnllMWtFY2NqTktUaStvZUIrcWUr?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ad59b5-3213-4316-1c16-08de0de99459
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 01:56:40.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNAyS5Wil8GolZOedC7P36w+2XcX6lq6vQNT4NznWvmesXQ6E6yHcziw+oriwcXx4oeHb+jLtvPbhuIsi75aNSoEYGZnRoY6dnPR7k6IbSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6142

Hi Russell,

On 10/17/2025 6:12 PM, Russell King (Oracle) wrote:
> On Fri, Oct 17, 2025 at 02:11:19PM +0800, Rohan G Thomas via B4 Relay wrote:
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 650d75b73e0b0ecd02d35dd5d6a8742d45188c47..dedaaef3208bfadc105961029f79d0d26c3289d8 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -4089,18 +4089,11 @@ static int stmmac_release(struct net_device *dev)
>>   static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
>>   			       struct stmmac_tx_queue *tx_q)
>>   {
>> -	u16 tag = 0x0, inner_tag = 0x0;
>> -	u32 inner_type = 0x0;
>> +	u16 tag = 0x0;
>>   	struct dma_desc *p;
> 
> #include <stdnetdevcodeformat.h> - Please maintain reverse christmas-
> tree order.

Thanks for pointing this out. I'll fix the declaration order in the next 
revision.

> 
> I haven't yet referred to the databook, so there may be more comments
> coming next week.
> 

Sure! Will wait for your feedback before sending the next revision.

Best Regards,
Rohan

