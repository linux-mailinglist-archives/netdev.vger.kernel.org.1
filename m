Return-Path: <netdev+bounces-209069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C36B0E26A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B121893CA5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5127EC99;
	Tue, 22 Jul 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="gmRxUazu"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023107.outbound.protection.outlook.com [40.107.201.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C56AA7;
	Tue, 22 Jul 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204212; cv=fail; b=bKjzYJ4vnhs71N7Btw9WpZe16YwmstEpH484cIHXijN21LPWvxGC9vJGwihK1fgCx0FoE+rJAgKc0rgSN2qMGA8QhOaL6gMBydyBEY6JbuZBudD0/JGGh81+bCxZP4QREFi6W4fMUay8Tb04fV0YGyaozxItsu+2ZicfDMhBpPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204212; c=relaxed/simple;
	bh=82Md+ltrChnuRDP0Y7ahK1CJTz1OChSCOu0RU6RWnLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xft61tx8HI881Z2/CRswr7/+Bh+5qa4mk+8FcbzT3Cr7IRcc1evsvJSt0MwooVLbVz03FgtnkvZmSNNt6dd3lQZjhkvNdigJZz6OrG3EmkSueKP9WAnO1+kjbjCVUx7Nl+1L8eRJYpKL8u7lHVV85wdi1LbT+oqrTPNpKUwE9tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=gmRxUazu reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.201.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwEnuaJEfdIRns01JYyMXkNn16FzgpcX0ANacp8mDrc9ubm7vAr5oaX6zGL23NMGo0SFl+PR2+Xv075jrHagHBKYFtbcCYltGlyJ730UdGiJG4AL0bCPgTAQKqfJAkcdK9f1Nak8XCaoHpialQH8HKWQmGCa4/Pr8FyPN7mqZajawurCgrRcfvIGE+tD88PIsgw8sN55PI1WAH2Ln36rsZPs83ItfLVogw9BvwWa3L3V+zIBHTljiSDcckIplD4ZrLrUD2mfNFbU5BzgNh6nRtDEAFApzyJpb2eoUAYiBKwjE6XFAtZb8XXbChdlSH0ljWPG3dJIFvnx9ScAipFFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM3o5WkXWS4yQurTFdToa6Q6MJd04aEEWW/sFtUldUI=;
 b=rPxN1gUwenA2jEs4+QtSqHSIhPsQR3QtSMwof26BaIZwyXmzDB+Z8qqk2t6axkyEbBqL3DuEVAhOlt/j9uI6pKHhrX3N8hhJ3mghIu7Ku3ZvBz0XE2Oyd54jLzKihFSgFsd9wbVH9ouab8KWbfaDY5xR4Mozt2vhpCz4jDfNWLd0Ea81ds1OLwZbLx3UoDMwyYYRiUy5H26Yf7H53cQFXM8LJYC4WN3VdUY4GaWeetKE4pf4f9Sr5gymZXwQ3nBr5J9rQsPFTKogjjE1TBquuBOVQD6Ct1xGvk67XUKC00eFYQ7KzUQ9xkrlL1oPbS56RU1ecFdkzTUBR1Pkk3Lzww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM3o5WkXWS4yQurTFdToa6Q6MJd04aEEWW/sFtUldUI=;
 b=gmRxUazugGWyb0uOiy/qKjx0QcwskRVCCMhkvcFVp2m7LEHy5c4a0bntTvR2SGaBKN3vInLt/3JIVsI0N2IU97nCrHxTvHoy0gkOyTMdztOQFsQnmzGUZ0qRD31GZQCiMHyWs+WVwBNCvo4yhIdaxmrHtoSJ1KY+gTIo/TpQr+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ2PR01MB7956.prod.exchangelabs.com (2603:10b6:a03:4cf::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 17:10:05 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 17:10:05 +0000
Message-ID: <bb544194-d8af-4086-b569-4a4b4befd6ad@amperemail.onmicrosoft.com>
Date: Tue, 22 Jul 2025 13:10:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250715001011.90534-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:806:122::32) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ2PR01MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 534e9920-bfc5-4d39-d142-08ddc9429a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGFSYUlIQStOMmJ0bERLbDZ0eHdFT1ZSc0VpSEdZNnhKRzNramwrZ01KdE91?=
 =?utf-8?B?S3NZNm9uSFkvb3czK09VZTFBcUxadmtSOHlNRHlEMVY1aXI4aVZQSTdvK2dL?=
 =?utf-8?B?aHYzanJuWmw0YzlIU25HMjFzOWNla0RoS0RZazVSVGlCT1o1UGJQL0NYcTNu?=
 =?utf-8?B?VytrTXJFTGhpNW9pRWtnWkVWOWFreTQ0RG1VV3I5dWhxdnBYVVRKKy92QVBm?=
 =?utf-8?B?QjNwMW5qK05lS3VvdTlHcVo1Y3g2T1ZpU0trNGw4QjdubTFhYjJ1THVSVndO?=
 =?utf-8?B?YTVPZTVhck5kZnN4c3B0aVUyaWpuNnpMa2g4dHB5NG5jZVpUQWxCVnhlMmtM?=
 =?utf-8?B?a3MzRC9yVUc4TTRpZ0FwWk5TUFJ6TWZsdGdleFU0RzBxS1FSbmh5N25pUzk2?=
 =?utf-8?B?VXFIaGNSVHErTnh3dEo3OGdWV2tLL0grbVpGZGY5TFFOUHFxejMxMFBIN3Ey?=
 =?utf-8?B?eWlsaHlTUm1NbVpqbUVFNGhjWHNrWkVsanhOSGU4S0NORWtUbWdsb1c3NUpT?=
 =?utf-8?B?eURRVEd4L0svVExnbzhqN1pncFNMdW1ZaW1nckJwOE9jUXlTcGdiUXYxQ09M?=
 =?utf-8?B?YjZsSWxKb05zN1JPWkY5eFhZVEpiMWdKNy9IUy92ZFc1d0lLTFRPTnJIT1dG?=
 =?utf-8?B?K1YwQUVnb1pMajdCMk1vVjF1WnJVTFNOQWFqbkFmeG1SeDlsVjZUWmJML2di?=
 =?utf-8?B?NTYvM3MrOUJLVkEyNzRBVmNRZW9oNHJsOTZGVU9kWFFBOEUzUGZNbU0wUzlF?=
 =?utf-8?B?VldXdHRBZUhrTkIvNUh0cUdlTXdURnhFZGIrMnovVENMTFdHblZzZWphdDZ3?=
 =?utf-8?B?dkZGNVZ0Q3cwd0pWendGSEE4RzJFSUZnVXF0RUhVa1gzQzZzZ3F0bzlEeE4x?=
 =?utf-8?B?OHZjUlFJamZKazAxcHRXdUt6Z1d5bzFkellUMjNlcTFodEQvUGZyU09kMzJZ?=
 =?utf-8?B?NGlyZStVU3lIeW9GYUhoT2JBT2dEd09QQ0xTSDNkS21PQ0RVV0RQc2NWL2Nj?=
 =?utf-8?B?TkRpU2dvdzJDR0tQRnA0YXNaYnBMaTVQTldtVW1va0ovMTRVa0QveVdseFJz?=
 =?utf-8?B?WjZ1K0cvZlFDaWZNZkQvM1c4RjE3a3ZKUzV4UUVQMVpNZ3NGR0JYVHdHTDBa?=
 =?utf-8?B?S1pMY2Qvblp0NEhoYm1tMWlZakZNUUFLUUh0TXEvVmF1SytLT2h6VkYwWnZP?=
 =?utf-8?B?YzNZNlhibUp4NXZCRDNHK0lQYnhQNVczdXVYbmNZSXpPcmREcGdtWWVpSXM2?=
 =?utf-8?B?V3VlUWp3cTEzR2RET1RvcC93NVZXRFRkdnBNUmR2N0YzYy9zb1JuNHk4eHBC?=
 =?utf-8?B?V1ZQcFozdkQ1d28zQUk4WTNnR1o4V0lvemxZaE40OVFjTWtKZDVrTEVtWUYz?=
 =?utf-8?B?QnI4SGp6RFVkbnBlNTgzT1A4TjRsaEdOKyt3UUpJVys3OGl1L3hqdUtyaHBG?=
 =?utf-8?B?RXU3UTJRVUFLYlNBL3BZL0FmalEvMFNuYkdqTEJwbTN2S21UaDNGcUYva08y?=
 =?utf-8?B?S0wwN3A3Q25kNzI0bTROOXpFc3lGOFQ5U0poMnEwaUJ4Rit6V3FHQkxVZW9X?=
 =?utf-8?B?aG1WMXFWWWlCMUFHcllKdEVyS2xZWE9tVGgrNEVtNzJRL3B5bEtuUlRZY2hz?=
 =?utf-8?B?dlA0QVg2Rld5NmhyYnpudlovQit0QVA5MnRZb2U5RnRGOUtYSmlHQ2xqME0v?=
 =?utf-8?B?OU5JWVlCT3puS3VhWWN0Wml1Ylh4SWRQWkNKbzgvVUZ1NG9kM2VjVWhtOHox?=
 =?utf-8?B?bmJIbGZaZ2dqTDUxblVqWmRiZUxBcDB0VWcydGY1YllUT1Vkd1RWaHh0WHE2?=
 =?utf-8?B?UDZSTzNyWHpYVDRZUVZscnlxenhFMDZiZlNRVGVuRTRlU1EwSzlzbEphVUFE?=
 =?utf-8?B?bTkxZVJXUjJJc0xabG9nRGdHRnEzTHA5MUlydHg0aEFFL05zSSsrcnBhUDVj?=
 =?utf-8?Q?SsO5EnW54Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sy9tVnRTdmwwM0EvbkNOUTlJWWJHWStBSEdHWTRmV3UyS3VweHJJU3ErUENy?=
 =?utf-8?B?Zm1XYkxPaURWTG84USt0b2Q4b3FsellSZWdwMUF2WDQwSkJrVlU4b0dBWm91?=
 =?utf-8?B?L2JjSTU2UXlQMnhPR09jNkxNWTZtck41YlZMU0c5ZGcrTFNGTjQrRVN6S3hP?=
 =?utf-8?B?OWQyWmVxc3AraWVVRWc4bVptSytQS2JqK041eUVpazIzeVRWS0tBWnUrZXRa?=
 =?utf-8?B?NUxDa1l0cjR4dFdhZzcvVFcvSWtyd3Z0Yng0Z3hCdHgzOFMxU3ZkTlpjVmow?=
 =?utf-8?B?QTlsdEpkWmN1SUVEaVBzWWp2bk9kUjdObTUzTHRoaU1rUVgzVmFNK3U4eU0y?=
 =?utf-8?B?Y1hmQ1FORktvNTRGY05PajNTTHY0TmNZQVpFZVlmMWpGRmh2bENRSnZqSEI5?=
 =?utf-8?B?ZjBhQ3Zyb0Rwc0w0QmI3Qy95a2hNbVNCRVkxQ2FReUgzSC9yNnZjc0kxczZv?=
 =?utf-8?B?WXZlWkxUQ0RRYms5ZkF4T0cvV3hnQzFwSi9HTkJJRWFhbUkvcDNCR2JpN2ZK?=
 =?utf-8?B?RG5SRkYvWUJoZWhHVUdRV2pvUGUzMlY2VUMrMnRsU1pBeFpTbHRraE5naGQ3?=
 =?utf-8?B?bmVaZTJOK2Z0aGVuWWhkTHp0VExYM0VvbXpCQjBlN1kzeStMd2treTMrMG1E?=
 =?utf-8?B?b2tHcVhldmhHaUNEZEVjZ2tjczkzVkZhYjhabzZpcHBoNUJvYW11NDAwRXVs?=
 =?utf-8?B?d0Q5ZHlPdzAxcEJkd1NQZWl0cVBkRU91V0FUcytMZXN2WkFLRVd4cVVsRXF2?=
 =?utf-8?B?K0hZdUJoRE9QcGk0NCtTeEFpc1EyWkRmNW4wcmJ3aDZSM2NPa2RhSDFHWC81?=
 =?utf-8?B?QXBIZ0JlZmQ3TVVzSHc3VXk2eFNMRjJtM0tvZE1OcUl1azFxZFNyR1Fwc1B1?=
 =?utf-8?B?bkJwOWtzR0xJTW9nZ01YTXdKVHIzQnpFelU5UXJ2ZGdkNFBYdjd3NWJDeWJn?=
 =?utf-8?B?cThMZkFqMG5WblNxS2tvMkhUYUljWC9tQUlJVEpFd0JJK2dMcEFUOHRJa0NT?=
 =?utf-8?B?cGhvR1N4SnhXbkpvNE5zZXJlVG9mZXB6M0Jhek1mWmZmSlYrczV1Zmx6TVdP?=
 =?utf-8?B?bndnVURSUkdHd3dLUEVSMlU4d3VMWG1LZEs1ZEV1Uy9KZUtlbld3OUZ0KzdL?=
 =?utf-8?B?RlcvOUl1T2Q2MzU4amYwL2pkUjQzVTJFOXRTcGlnMHhRQ2RDK2lwcXQ5aEpJ?=
 =?utf-8?B?MU5STC9ESTQyT0xGbERPcGhDQkdKcHd5OUFNZGY2YkdwMTcwbzZEenZBSGVE?=
 =?utf-8?B?WW5ldTBzdmJqM0FWdTVENkQydGpQNlBMUlNNam8va0xNU1UwamxEaFJHRjVl?=
 =?utf-8?B?ODVyRGlVeGJ5TTA2WGQzbzhvY2cwcXIwVkhCQ2JvQTlQWHRyWFd0cGdNMmhS?=
 =?utf-8?B?QmQxMWZnRG12UENDRk03Z0lRS0dLdlZISjFwRE5WUmRqeEZ5V2ZBVUFRYUJx?=
 =?utf-8?B?bHRXMUNkRGFyVy9YM09VOG4zYzBOOGp6Z1NEbVdkalljWmhId1JZODBYREdr?=
 =?utf-8?B?WWs4SGtYVUZkN3BOZk1LdVlVU2dkeHFhS1N3R1dZNXFLQjd6eFpjTlZvSkIx?=
 =?utf-8?B?MWdCZFh6K3NXeGgrazNLdjBBa1FlL3RPUXRKeE1kaG1OQTM4WWNlZ2FteWE3?=
 =?utf-8?B?d1hCbHhxeXZOQkE4K2d6blc1eXJhNlFGSlh2UWhWUG5saFUzVkkzVW9BcHhE?=
 =?utf-8?B?emxzYTlBOXNta1dwUk1MM0hVckVISE1sblpuVUtFbVZ6bnBzeUNHU0s1bDBQ?=
 =?utf-8?B?WXgzNndDQ2NHVW1TZ3YvTVVTdEFSdGNYNGNRQWhUWis3ZFdyV0V6Y2dGV0k1?=
 =?utf-8?B?N0w4czRJRDE2TVZzZU5tM0QvUE5XNDFsOGZBeEdWeVVnYTNhSy9pQ2M4YXJ2?=
 =?utf-8?B?M3JCc2pqKy8xdTM3MEdEeUVUcThFbFFaYkUyQ1o2ZkdNQXJvb0I0TFgyZm5U?=
 =?utf-8?B?N2VkSU5tWS8yRXJqaWlVc2JoVEtpTjUwU3ZaVE81MEYzelQxQ0VWNGpKeDFW?=
 =?utf-8?B?U3YrazJtVHhJZXp5NStKSGt1N3RuZHNKbGpKa0NZQnFiNjJSRDNYR1RIUzZ3?=
 =?utf-8?B?eEhRbWlndkh0dUZYZk9NcXpuM0ZxeHR0VnhLdzVPeTZkMnVHbTE3Q2JwZEZr?=
 =?utf-8?B?NGlLOEY1dWdkYklpS25xVERMdzlSWGp4dDhGYlVONHNTYnJlY09vaTduVUJx?=
 =?utf-8?B?ejRmbldvMDM4bi9wREIrOUtGT05PRmV3OWxqMU5ZT2pzY0NjellrWWVLYzRJ?=
 =?utf-8?Q?RHMeT2o8QVzTfVYPgmFRbN2I5Jb+acXQL3Fkjm2q8g=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534e9920-bfc5-4d39-d142-08ddc9429a58
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:10:05.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvyFbvFGmYd9wabUrxHr+7GgESlPxby1F6tbd95N8Riq0cKQ6qqOJ8BsR/PaqDn8KZCA4ltQvXD5ExZ53CY288oeFttM/MVkel6wYI08CMzoHi/mttkY8/YfKwxJiIfH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB7956


On 7/14/25 20:10, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
>
> Define a new, optional, callback that allows the driver to
> specify how the return data buffer is allocated.  If that callback
> is set,  mailbox/pcc.c is now responsible for reading from and
> writing to the PCC shared buffer.
>
> This also allows for proper checks of the Commnand complete flag
> between the PCC sender and receiver.
>
> For Type 4 channels, initialize the command complete flag prior
> to accepting messages.
>
> Since the mailbox does not know what memory allocation scheme
> to use for response messages, the client now has an optional
> callback that allows it to allocate the buffer for a response
> message.
>
> When an outbound message is written to the buffer, the mailbox
> checks for the flag indicating the client wants an tx complete
> notification via IRQ.  Upon receipt of the interrupt It will
> pair it with the outgoing message. The expected use is to
> free the kernel memory buffer for the previous outgoing message.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   drivers/mailbox/pcc.c | 102 ++++++++++++++++++++++++++++++++++++++++--
>   include/acpi/pcc.h    |  29 ++++++++++++
>   2 files changed, 127 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index f6714c233f5a..0a00719b2482 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -306,6 +306,22 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
>   		pcc_chan_reg_read_modify_write(&pchan->db);
>   }
>   
> +static void *write_response(struct pcc_chan_info *pchan)
> +{
> +	struct pcc_header pcc_header;
> +	void *buffer;
> +	int data_len;
> +
> +	memcpy_fromio(&pcc_header, pchan->chan.shmem,
> +		      sizeof(pcc_header));
> +	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
> +
> +	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
> +	if (buffer != NULL)
> +		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
> +	return buffer;
> +}
> +
>   /**
>    * pcc_mbox_irq - PCC mailbox interrupt handler
>    * @irq:	interrupt number
> @@ -317,6 +333,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   {
>   	struct pcc_chan_info *pchan;
>   	struct mbox_chan *chan = p;
> +	struct pcc_header *pcc_header = chan->active_req;

OK, so it looks a little strange to re-initialize this later. Would it 
be better to not have it initialized?


> +	void *handle = NULL;
>   
>   	pchan = chan->con_priv;
>   
> @@ -340,7 +358,17 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	 * required to avoid any possible race in updatation of this flag.
>   	 */
>   	pchan->chan_in_use = false;
> -	mbox_chan_received_data(chan, NULL);
> +
> +	if (pchan->chan.rx_alloc)
> +		handle = write_response(pchan);
> +
> +	if (chan->active_req) {
> +		pcc_header = chan->active_req;
> +		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)

Note that this is the counterpoint to my earlier patch that only 
notifies the platform if the platform requests it.  This is part of the 
specification.

> +			mbox_chan_txdone(chan, 0);
> +	}
> +
> +	mbox_chan_received_data(chan, handle);
>   
>   	pcc_chan_acknowledge(pchan);
>   
> @@ -384,9 +412,24 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	pcc_mchan = &pchan->chan;
>   	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
>   					   pcc_mchan->shmem_size);
> -	if (pcc_mchan->shmem)
> -		return pcc_mchan;
> +	if (!pcc_mchan->shmem)
> +		goto err;
> +
> +	pcc_mchan->manage_writes = false;
> +
> +	/* This indicates that the channel is ready to accept messages.
> +	 * This needs to happen after the channel has registered
> +	 * its callback. There is no access point to do that in
> +	 * the mailbox API. That implies that the mailbox client must
> +	 * have set the allocate callback function prior to
> +	 * sending any messages.
> +	 */
> +	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> +		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
Is there a better  way to do this?  The flag is not accessable from the 
driver.
> +
> +	return pcc_mchan;
>   
> +err:
>   	mbox_free_channel(chan);
>   	return ERR_PTR(-ENXIO);
>   }
> @@ -417,8 +460,38 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   
> +static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
> +{
> +	struct pcc_chan_info *pchan = chan->con_priv;
> +	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
> +	struct pcc_header *pcc_header = data;
> +
> +	if (!pchan->chan.manage_writes)
> +		return 0;
> +
> +	/* The PCC header length includes the command field
> +	 * but not the other values from the header.
> +	 */
> +	int len = pcc_header->length - sizeof(u32) + sizeof(struct pcc_header);
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> +	if (!val) {
> +		pr_info("%s pchan->cmd_complete not set", __func__);
> +		return -1;
> +	}
> +	memcpy_toio(pcc_mbox_chan->shmem,  data, len);
> +	return 0;
> +}
> +

I think this is the pattern that we  want all of the PCC mailbox clients 
to migrate to.  Is there any reason it was not implmented this way 
originally?-

> +
>   /**
> - * pcc_send_data - Called from Mailbox Controller code. Used
> + * pcc_send_data - Called from Mailbox Controller code. If
> + *		pchan->chan.rx_alloc is set, then the command complete
> + *		flag is checked and the data is written to the shared
> + *		buffer io memory.
> + *
> + *		If pchan->chan.rx_alloc is not set, then it is used
>    *		here only to ring the channel doorbell. The PCC client
>    *		specific read/write is done in the client driver in
>    *		order to maintain atomicity over PCC channel once
> @@ -434,17 +507,37 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	int ret;
>   	struct pcc_chan_info *pchan = chan->con_priv;
>   
> +	ret = pcc_write_to_buffer(chan, data);
> +	if (ret)
> +		return ret;
> +
>   	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>   	if (ret)
>   		return ret;
>   
>   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> +
>   	if (!ret && pchan->plat_irq > 0)
>   		pchan->chan_in_use = true;
>   
>   	return ret;
>   }
>   
> +
> +static bool pcc_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct pcc_chan_info *pchan = chan->con_priv;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> +	if (!val)
> +		return false;
> +	else
> +		return true;
> +}
> +
> +
> +
>   /**
>    * pcc_startup - Called from Mailbox Controller code. Used here
>    *		to request the interrupt.
> @@ -490,6 +583,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>   	.send_data = pcc_send_data,
>   	.startup = pcc_startup,
>   	.shutdown = pcc_shutdown,
> +	.last_tx_done = pcc_last_tx_done,
>   };
>   
>   /**
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 840bfc95bae3..9af3b502f839 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -17,6 +17,35 @@ struct pcc_mbox_chan {
>   	u32 latency;
>   	u32 max_access_rate;
>   	u16 min_turnaround_time;
> +
> +	/* Set to true to indicate that the mailbox should manage
> +	 * writing the dat to the shared buffer. This differs from
> +	 * the case where the drivesr are writing to the buffer and
> +	 * using send_data only to  ring the doorbell.  If this flag
> +	 * is set, then the void * data parameter of send_data must
> +	 * point to a kernel-memory buffer formatted in accordance with
> +	 * the PCC specification.
> +	 *
> +	 * The active buffer management will include reading the
> +	 * notify_on_completion flag, and will then
> +	 * call mbox_chan_txdone when the acknowledgment interrupt is
> +	 * received.
> +	 */
> +	bool manage_writes;
> +
> +	/* Optional callback that allows the driver
> +	 * to allocate the memory used for receiving
> +	 * messages.  The return value is the location
> +	 * inside the buffer where the mailbox should write the data.
> +	 */
> +	void *(*rx_alloc)(struct mbox_client *cl,  int size);
> +};
> +
> +struct pcc_header {
> +	u32 signature;
> +	u32 flags;
> +	u32 length;
> +	u32 command;
>   };

Fairly certain these should not be explicitly little endian IAW the 
spec. It has been a source of discussion in the past.


>   
>   /* Generic Communications Channel Shared Memory Region */

