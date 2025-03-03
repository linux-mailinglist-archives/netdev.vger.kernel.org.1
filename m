Return-Path: <netdev+bounces-171342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA26A4C94E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DD017C88F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8F241660;
	Mon,  3 Mar 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UqQ4Z0Q3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC8C2405F8;
	Mon,  3 Mar 2025 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021494; cv=fail; b=ru8oLwVEISUbSCj1NB4orPrYJBvufcevGTunzTY/NozdJL8ViWApqB84B5Y/JTzBoIsYokSKU6lcjNezHfA1ltNVH2cQ/PSs/wlbdIhe+GCkkOlpSyUlTr8VkZbcwJ5Iwvj4oHkKceQ6ylSloMgQ0xaxdAQ+b8n+BYgLZVQLD1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021494; c=relaxed/simple;
	bh=wQsql8DZyCSLaGBinBAoP49NJnxpLQ418O2g/LLizGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dLtSY350V8eMxI0BcW5Zi8yLUyCEgm9BmtenTVX19rAuQdhKi16EXCSJ8Q2WldbxVU+4pwtliiRHfh1yHlaTB82vFkwOeQPbd49lMeCDSstSGiD3/O4pipLR3wv5KbU/3s+n2Wpe/lDwhMEDfYeUGsqH0htV6E1eopQrmCYy8Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UqQ4Z0Q3; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWUouruN9Elh4kVe9fVy7iuFT/CKNn0fVRt16ZbjhKFgKKGWBhxC1DPQoFtHiC1iW9Gf+zUEEOKP0mTFgFCslf28APjQj+tcV5jobVX77tfDSubYriS9JC5z1WvC1grLEOn8c8WyzA++20s/IKhm1Qus0RnUPQL6F0uh52vcMPiZjbYSHUDHosm5Jc9DU64Zf6q+HXIuf+Y+pUpOHzYc16esN5IkKPjktEexa1vE82ojboTjgdPCcUtYRxnWuXpmAByNtMyDSyI6w+NJDgoGy0rGn3ovJLQsJGBziicXQr2U+C9ZP5bnZDCZleFym7gRkXHKn5Y2SqdvzQWJIwyTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbEa/qlq5SNLNOHurLCz8VOza07BUpg7g6NCPci0nBY=;
 b=tIZekIgp/e2AlGY5Dm4gSAMt5BkIssrsKTxVqoTSSSuosQmkl/YtIPrEUOnYV9U+sYmAEOU7lHeLkOj8zrrHjjWhEmeITt2QGvvcdySZ5I+ipp1pTvgQa11Q7RoV1MYuOWKoXpJEN85zJ5TgueCK+SolOc1Zei2jYpTZ2jArWee3qY6XHraWMlz7GddM4Sf4cvxeYgbFtRJ26M34D34/Dl3YGNRn3vecJIJTDfGcc94OIL4ycbsKDr9HKNKHqEnTUE5XBakLu05Os8U3rnZ/8MupDuJq+04jG+JN4uoTXS5Kno4RJ5W72WOyBZ8Ev5OJCfPXb8Zrn6QYwDDDbvVS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbEa/qlq5SNLNOHurLCz8VOza07BUpg7g6NCPci0nBY=;
 b=UqQ4Z0Q3fZ9ExIEX5SpYMa4zOH3WwyXREPPh42xrtmE7bHIdQs5fJfjcw6uzHt+mIizB3PxynfYCKDUT/L4e2RN6iE0AdTUukxqihkpXTey5eU/2fjsiwZl0rDPfYJ2attbrWCGz3adFCp+Q5ml14pqdj2eQ8XNo+fJtAz3DvtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 17:04:50 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:04:50 +0000
Message-ID: <dda059ec-ddfb-490e-96f4-08f6cecb7ae0@amd.com>
Date: Mon, 3 Mar 2025 09:04:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ionic: Simplify maximum determination in
 ionic_adminq_napi()
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Brett Creeley <brett.creeley@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
References: <cbbc2dbd-2028-4623-8cb3-9d01be341daa@web.de>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <cbbc2dbd-2028-4623-8cb3-9d01be341daa@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf6a862-c428-4e84-9681-08dd5a758231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzYyZlFLUHZQUUhzRTdiZFJSNGNjU0F5RXlna0w0cDE0VXd4a0ZDdzg3QmNm?=
 =?utf-8?B?bmxsRVl5WEc0VU04M0xha3RicjRzWHFacUhVenVoVTdjNmFubkNqNGoxeFIw?=
 =?utf-8?B?NEdQU3grdk85S3p2OHdCOGQ1bExkVnorQkdGR1BieTVtVHpoaU1ESzFwZXBo?=
 =?utf-8?B?RnpkZUtBYUg5WFNRdW44eVI1bnZwTmRFVDZFTnUvKys1cE9ub0FKUWx5WVNB?=
 =?utf-8?B?am92RXhVUlNzUDRxckhYOWptVTI0aVNGY0pRYnNLMlZ4cGt3MVgyRmVlRjk3?=
 =?utf-8?B?Q0lEK0xVbC9BeXdtdTZqbFJxTWRwSmNzUWc3Tk0wU0NJUU04QTJtN1l6VGEy?=
 =?utf-8?B?UWRqTE53Y0pSSHdHd2IwZ3pMMlNMVjE1TTNVOEsreFQ0UTVzc28xamF5d3J0?=
 =?utf-8?B?bUFUcGJOeUlvWDN2Z3pISlJXRzUxcU1DZFpQSFVXczNNdHd1Y0hoY3pwRWtx?=
 =?utf-8?B?dDlGSjlHcENZZjJsRnVZVU9MSDFjZ2ZOQ2NGZ0NPN0F3RXdwcUlXWndhaVFr?=
 =?utf-8?B?VURScUp1NWVRL082MEFJSWhIc3RLVUdKZXRZYStxekVVbmRuT0RieUVtWDEr?=
 =?utf-8?B?YXZjZ1JlL24rV3BwOVIwc1pScjFRQlRTRmF5SFk2aHJHZ1Z0bGUzdjNtcnd4?=
 =?utf-8?B?R0ZZMmIvNXBMc0pYODNTUU5QeFdhdjArV2xTWnUwbUtFQU5TeWYyb0p4dWp6?=
 =?utf-8?B?NzROYU9jbnJ3SEVlai9NcE04YkJUMzZ3RVBaMWlzbzdhNy82MVpydVEwUEpU?=
 =?utf-8?B?aDFsOHlJWktySUhLWHFzcXFUVmR6SDlOSURDS3orL0h5L09LdFpMbWhTNzR1?=
 =?utf-8?B?bThUeW02aXBNc2tuVjdWUmR3S3REUGR6bU14emkrVG1TMVlacWV6ejFwZjE5?=
 =?utf-8?B?cFJVWWlpSUFlRUhpNjlhekNWanRhSjNqeGpucWRWN2wxelVlR3ZwZUtzc0du?=
 =?utf-8?B?RDFERDFFV3ZNbGNaRkxkNVUxYUdlRUhBTS94Yk5lZVRCakVoWjl2TW9UN1NT?=
 =?utf-8?B?dzhnSXZQQm5XdGwzeFBNM1Y4QzNhSlluRkVZZHplV0ljSGY1T0NBZVZ2TXp4?=
 =?utf-8?B?K3dUQ1ZISkR0TjNhWEJCV084V3Z2cHJLVmhMVnFrNHYwTDRaQklQY0kwSkJv?=
 =?utf-8?B?TnErdWxLRXdmU2JUZnhTbTB0bkhnZXJEWFo1MXl0d0VsdFhERmFqSGhOdHc0?=
 =?utf-8?B?WTE4Q1dUQlowRTVzTktxcXJQU05XRCtHM1AxbW8yM0h6ejF5U3V2d21YMTZy?=
 =?utf-8?B?b1Y2TElvWnJ3WjcwV29zUjJFSHNucmFtYWRkZjJ4WVc3Z0dyTkxiRXdpbXoy?=
 =?utf-8?B?V0IvUlBYZzNaMHc3ZG4xTStrZE9waXExaGtsU3FhVG41U1Y2T0NJQmwwZFZL?=
 =?utf-8?B?RkJSbzhpZlhnZ0plenp3YlI1SGtSdjBDaERKSy9HdUNJVlhkOStYaWxhUWFa?=
 =?utf-8?B?Z1puUXNnSUVtWHJiUG1qYzJOSzBpSUdTZE1sKzc0YStJMUhQTnN3WEpQbm43?=
 =?utf-8?B?blE1RTRROUE3cEVJWlFIV3E1T0svV1o3R2REeVIraXpNZ1ltanpINEJQbXl0?=
 =?utf-8?B?QnlnOFJrZ0JzQjF1YUkxNGVEbVhqTHpvNUkwamZySWRKQzRKdDNqK0NOd3ky?=
 =?utf-8?B?NXJYSGNTUFZtWm9hQUVUNjViR2xSVzZaS3pGM1d4ZUozN21qYzgvZGdZWEpB?=
 =?utf-8?B?ME4xL1ZJbVdieUZscldCc1RvRU9IRDd2SUxYMjBMWHJhcVRBa1RUN2FjRUxD?=
 =?utf-8?B?dm9qSVZxVGVDQ2JVNzBnbzM5c0hEU1pqNnN3dHVTSXZWcTE0OHk1ZXc0bnM3?=
 =?utf-8?B?MmhEblU5U2x3RlViNWwzUjBNb3ZwUUVTVHVvM0dZOTBHTVJLa2JBa1FwZ2Jk?=
 =?utf-8?Q?Z6VpSqwXRA+r/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0dvdHh4ei9hWXJLZkdrQTZ1VkdjSTVSeDU0MVdnaG8wOVlFK1d0V0p2TWxH?=
 =?utf-8?B?Zy9pcWp5QzlZMkk2Ukt2R1RFTXIvazV2b2tUeHJnQ3lXSkMzNFc5VTZ6b2lt?=
 =?utf-8?B?M2craXduOVI2UGltUFhhL3FlSCsxNnh4U2hkYi9LQldscmN2N044a2VaQUhC?=
 =?utf-8?B?RGhBaVRnU2dEMkx0ZHpCZksvZkFkZFgyNS9HcVlEcE5heW9PbFRLNk9vcXgy?=
 =?utf-8?B?WTJqWEhXYWUzbHArdFJpUElYeWdHUVZ3TllXWWZRSnpWTVRXaXN6Tklab2pI?=
 =?utf-8?B?T2FkZnAwbU5DeFFCWjI4TEFNU2VNWGhZSStKTVdzVzA0bmV5MS9kR0FEOUFM?=
 =?utf-8?B?UnlyUkpqUEIwR2V0WUlTZVRpQWlzZUUxQ2tycjFmOHc3Rk1xU2N1LzNtdjdt?=
 =?utf-8?B?cFJkMFlzbjFNa1ltbUQzdWY2VlVBUllObCtURWt5WkN1eXl3M2NGSUpjblVB?=
 =?utf-8?B?MVZ5T3haZzVLMzJ6cmltd0phRldSMEpoOUtRRFF0S3lmWm9zaGE2WGxuVWU5?=
 =?utf-8?B?ZGQ2bTNqSjFZa0h6ZHlzU0JhaG9VVHNEY3BrQkRhQ0hQTHhjcms0S3lOeEw5?=
 =?utf-8?B?dWYwb2Q4ZnQ2UUpKc1NxSzFNWXVhVU54TjNOV0trbWg3KzJzWHl2QTVybEJK?=
 =?utf-8?B?a3hkT2k3U1lnMCtQc0cvZkV3dGpBdmxqM01jUjNFdzIrMWdBdzlBQkNwejFh?=
 =?utf-8?B?c0EzelNjR2RSeHFWcWk2VFpQaTNlaWNCNWo5cnhiZFhsRmV4bGdvTUFRTGsx?=
 =?utf-8?B?bU8xZ3VYWkdCdkJlWHNiQlpmVm9zczl4UWVVbmQwNzJmOEpCNlh2ZFB2M1Ux?=
 =?utf-8?B?Zit4dFBXbXBxWmk2alNsZlVIWFFRQ2FZemxYUHExOEl2RGlYcXk3QUlXNmdG?=
 =?utf-8?B?QUdlSUV0VVpsZ0ZQRVI2VCs0STRHUUIvNlFJS1pUdzFhRFlLdzJSOWZBa1Iw?=
 =?utf-8?B?MmVwdExLL094cW9Hd1MrWGNtVG9HalBxcCtBaHlYbHZIc05hcnZqZUszV0FK?=
 =?utf-8?B?dDJtWDBGRDJvTVFLZzdWUXN4QWwyRjJuSnNZYWlEeWUwd1lPWWo0Q0JmdVdS?=
 =?utf-8?B?THFGYmxrNXVYOUlvV1ozdmFENTZocDVwRFpRNWJRUXUrR0FFdmZpYjBCZ0lm?=
 =?utf-8?B?N1NvMGpKZEFGdEEzbG5PYXVBdDkxRUlwNStsckJuRmNjeVJpcERJZmFwQTg2?=
 =?utf-8?B?WWVYOEJEZURZam10NTBJRjEwcG53QlZFc3VnK0NZOTBVMENURjd1UkFQNi8r?=
 =?utf-8?B?UGRjYmU4WTkyTlJCWkFWdHRicU9adGdQVGUyVEh2TVg4TTRQd1YvSDVSSjlq?=
 =?utf-8?B?a0Y1ZzNGSTA2a3pvYkJrVVJhWVZwQ0NnempuWXlYanZlWG5menI0VmNWVTJu?=
 =?utf-8?B?dzU5dVgzKzRLQVFaZEFqb05TRmRZOE01dSs1cFhYTGNYK2xnZ2FZOFJSSnF3?=
 =?utf-8?B?ZWs0SDZnY1c4Z2Jvd1BmOVdnT042WTIvSkhQZ3BTcFdCbTFaalF0TnN2ZVBw?=
 =?utf-8?B?VmhaTHdBOXd1RHZWY2svajFNNjBFVTYxcXZPRGVrUm5qdzNaZHRzS3dKK1FC?=
 =?utf-8?B?aktSMmZCYjJibHR3L0xqTUxTaGVMRmFmWUhzcXJrNUFhdXAyU0dobDVjOVZn?=
 =?utf-8?B?Skd4VTNsajhhTzB6QmpSbEo0RStCaTdNOVl3MHkzS2NRc1JjREFEWkRiZUw2?=
 =?utf-8?B?ZDlISktCWUp5MTZZUFZUUkgzb1ZDSlcxaEp4dVRBR3hISmkvdzA3aWJybGlZ?=
 =?utf-8?B?WDV1Q1NXUkwwUSs4c2w3cGV6T3F1dktRcE85bFJDbnNFY0R0UHFSL0Z4WGkx?=
 =?utf-8?B?RFQrcWtZeEViZHk5RU9mUjcraUZ3YktaL1dnbmhIVzZiK2NEMExnbzFuVzhH?=
 =?utf-8?B?QUVHM2UrNHNyemRZa1poRkhzYjJpRzhpd2VoRnpKM3R4TXRmcHlmZTd1MUVh?=
 =?utf-8?B?WlJYV2dhM3pXcGkvNXZDRzdXK0I5UVQrczVNRHp2SC9kbHdKbmcvVzJ0dDVG?=
 =?utf-8?B?aXVpSXhxd21MWUkrYnRVUW1QdzdmTWU3eEtLUTlSdU1qdnBad3FlRUpjNWlw?=
 =?utf-8?B?dldla01YVGoxcHBWTzBLaEJrZzhvTTI1QUVDWUEvSElBVVVuY1lHQTVSaWxJ?=
 =?utf-8?Q?7RhU3KCrLlOeDz8InId1sapbi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf6a862-c428-4e84-9681-08dd5a758231
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:04:50.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efuJmvyUfSOZ3sigG4VN0hX+XMWnjfu2WtiEWjIodeKPXmWbBLW7TVJ4wjVgoTb4vJ2BuP93GPLHDLQD4UHkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271



On 3/1/2025 2:12 AM, Markus Elfring wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 1 Mar 2025 11:01:28 +0100
> 
> Reduce nested max() calls by a single max3() call in this
> function implementation.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7707a9e53c43..85c4b02bd054 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -1242,7 +1242,7 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
>          if (lif->hwstamp_txq)
>                  tx_work = ionic_tx_cq_service(&lif->hwstamp_txq->cq, budget, !!budget);
> 
> -       work_done = max(max(n_work, a_work), max(rx_work, tx_work));
> +       work_done = max3(n_work, a_work, max(rx_work, tx_work));
>          if (work_done < budget && napi_complete_done(napi, work_done)) {
>                  flags |= IONIC_INTR_CRED_UNMASK;
>                  intr->rearm_count++;
> --
> 2.48.1
> 

Sure, thanks - sln

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


