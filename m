Return-Path: <netdev+bounces-186958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D9AA4444
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774A77B4F45
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA0126BF1;
	Wed, 30 Apr 2025 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="rz8IMnxV"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021135.outbound.protection.outlook.com [52.101.129.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE938FB0;
	Wed, 30 Apr 2025 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999156; cv=fail; b=bxhY3oEYl1Tcn+sSdTQo8yjDkLXSXJRKSgGCOKb0TkcG7ZbbZkB12Xk5UqSzDBNPEuQBoG6ll70x+2M/n2u4bBopfbiTxEoNlkhzetIJQ2NBO6O8BvF8OBCLUcAzPdSO0PvM4JOsswRg/gfAR+/GXRIDczhNCap77uPAN1jf5WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999156; c=relaxed/simple;
	bh=Dlm/BsXBWvG1bIeoU4p/6Klv2rfxdMTRIvMw2+4WmRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHyqXTx0XMnU6sgzJQIv18yDj7jghlooATKdy/QAV9QWKQkfzQwqrQLwJ2iLlIDwEfD5eCfHUBePLEy8rXz8zJ4vTnDJYO+Y28oR8M+HVaB/AWLlvBBArWY52G8DaOf5JLOKxE1zSfRt51kXO9naJotrVXvs958iM8UTp3It5eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=rz8IMnxV; arc=fail smtp.client-ip=52.101.129.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxWEcSZA+94+ofcbjlfjPo39uKVTkiJMhXd8tZSibOS2UdMAnliSVtyLUh4bczq8P6Kckzw1mQFMJJnM2i6vjr+6C9DLD4Om65kRUvLaVRuP+JJrSYsV3ux+m4+h0MKu4XE8RRQxdLU6G/DeGFvk9IuK5xgzN3SVErx8aeOLU/1f0uUu2i4tacsqjUiE9P3Qc7xmluFTWMeIel50HQ1y1fFLIJlX+BHJzG2eoSy5SNQ9WkPQm5DgqCpbwrLvG48LtsbVIkhaqj0H36BlSr/t9LPLwPaOris9rFFyikt3nNeMJFbe4p/2xlcAVge7ne8bORlioqXFLphxVrwqSOIFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTGStQrU/24CU8EhNbPcAE+er/10xZvabePIx2oAs7o=;
 b=ShIO7j9vW40JAmUtQux7I3VHEpvEAoxipizILjfBOiXM/GFMNwjdwYCDzurCcanISbIaS8awVtYRzSLK/U8rHiTYPC/kzAImB/jrrG+n5Ph3T75AIXN9FNl7MoQGlaNpdbVB1QJtd79iMI1dagYwbdLdE51wf8Gsx651t1PlfvH3gBd65xkqCOZujOGxaGbbSk77isasSy/NfOxrdOnBN6rm9sgIu0gGmpwadjosR70e5FdglWQVsAOWidXVngTsdhDo4S8mk+vVHAw+QybV0D6KAoxxIaUulDUPmlSvanohn3I9ZmBVFMTSxpLYzSf/HIvr0pgivZPtnUTo1kqr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTGStQrU/24CU8EhNbPcAE+er/10xZvabePIx2oAs7o=;
 b=rz8IMnxVrdTYIVe2g1aLlXdBezvhTxrKmLYOBV4hnz231ejK0lov5SPiofR2oMXI0pizfZIUPAxn8uiIwifRV4nrd4UdyChnnbl0+mmeClxY4iie2RRJDyVqCTIrlezIr17A0jpCRdy+dSutRWcW4cvFCpn7BCBRO1qtcSTTv2Zqf0tlgVcovRUNVb5FWO+9NAerWYjv7R7x+CFOw6LQTt31j7EbqJgJpU0Oaqb05GfeEpCPKvUbPkhuhOD6DK2AmXODCaZeEiiPLNd6TieE023vKbHOJYSpjD9bMm+QIGA5o+X5Io9NGF98T929R3jgyzHGfWBd55zfvvAS1wZeHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TY1PPFC94CEC410.apcprd03.prod.outlook.com (2603:1096:408::a6b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Wed, 30 Apr
 2025 07:45:48 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 07:45:48 +0000
Message-ID: <d10f3fe5-b4f8-46aa-8033-2c548c8959ce@amlogic.com>
Date: Wed, 30 Apr 2025 15:45:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
 <e8190a3bedc0c477347d0799f5a4c16480bfb4e9.camel@iki.fi>
 <d68a9f4b25f6df883a75f1a44eb90bee64d4c3bc.camel@iki.fi>
 <CABBYNZ+StxjHC4f_JmPdJg2iv+o+ngyEuSvsBZB7Rrr=9juouQ@mail.gmail.com>
 <86F23E2B-3648-4EDE-8FAA-96C6DEA84813@iki.fi>
 <CABBYNZKKJE05c3037Pab-GpJK0P2NoYNm=eYa9g93NpshEaHXg@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZKKJE05c3037Pab-GpJK0P2NoYNm=eYa9g93NpshEaHXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TY1PPFC94CEC410:EE_
X-MS-Office365-Filtering-Correlation-Id: a218aa6e-55f2-4269-bc4a-08dd87bb05ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW5pTGpXb1FvQXgxY1J3eXFhdlBmSWpHTFZTVUtYN2NWSTIrWmlWeDhCcFBv?=
 =?utf-8?B?MjM5Q1cvdWdJME9uWkU3M1U1SHZQRk9wYTF6Si81NUlGR1FTL3MrcjRDbjcx?=
 =?utf-8?B?bDNGSGx0ZkJ4eWp1SjBiYnEwS3RpMXZtZ01aaVR2eldvbmZ4VFVJSDIyTzFt?=
 =?utf-8?B?UnZ6UnUycFlRSXZ6WDE3a1dEdzlkaXpnL2c3UFdhVlNDcEVpRXlVQTZ2RDRV?=
 =?utf-8?B?UFIrcHlYa2MwcG53bmUzUGlUY2FoTmtPZXRMV2MxdGdwU0ZvY1FMWUtGL0J2?=
 =?utf-8?B?MFJIV2UxSENpbTZrK0dJQXZnTGRhNlArdlA0VVFXM0JYQWxsTmpKazV3RDdz?=
 =?utf-8?B?bXNSdHBpZHpQTDh3SE8wTnNQVUxEd0NYQ3g3T3AveUJqczNIQmhPSlYyT25m?=
 =?utf-8?B?WnZVZjRzZnMzaTRvcTRpcGREZEhyeGNGYmJxRWRqOTVBRWs2OUFoOFRNaHBo?=
 =?utf-8?B?Und2dHlPejArSG8zY2tFMlFVSmxIanZXYUgrc0ZRNXhFN0pMaUJ0OUhaM3J1?=
 =?utf-8?B?ZWtJUXpZT3k0OVk1QTNDSEttbE5MVzE3OVpEemF6bkRCMld5QzBQdllzbEpn?=
 =?utf-8?B?RHpHM3EyM1RTaGFIaXBsSzZqVFBmai9BWkpJZ2R0QUl4eXRHL0oycUp0ZlRI?=
 =?utf-8?B?R1A4LyswSnpSSEdaa1dXSGZabjRoTExqTlRLWXJtK2ZlTGpxelFKWkc2RzNl?=
 =?utf-8?B?R05EVU8waERHd2NER3h2Yk1tcXhZQmNDamNXQ3ZIb1hCT1IvT0h4VE9YVEV4?=
 =?utf-8?B?L2lFL2Q3QzFndi9QLzJOZGlWSUhZUVU1eXBPRkhyRm14ckdvMVYydWhoZUky?=
 =?utf-8?B?c1BVdFhEV1VuWUpxb2pFVTNPcEMyN0RxTURIQWkzd2hMbW93WERhNkt2NFNI?=
 =?utf-8?B?MG1Nb1NTd3drTUxlU0xDMlg0L1Q5bHcwbnRFYlg0TXRUcGp2N04xTWRsOG9R?=
 =?utf-8?B?YjhwTHFsS3cxRmUyQ1pzSEJpREk0dUh6WUtmOW10U1JMek5mRnM1NHpZTldX?=
 =?utf-8?B?eVdvc1ByVDhtN21ubHpVcHJrclFxSnpsaG1RaDNIcGRBRTllMXYyNVhQei9F?=
 =?utf-8?B?eEk4Y250NlhleTY2ZENCRHFqUUlIalA5UGZZV0RtQ09GdGhqK01zRHJzSld5?=
 =?utf-8?B?TmlPc3VSV2xaQnZZbGtNdEVSUXNhOXcxQ25aUnUrM1RTcUphQlArMk1mZ0lR?=
 =?utf-8?B?SHZsZ1hPQ0RNZ0wvZE1vdHpUU1N0NndWSmhuSjAyOHV5MC80d2Yrd2xzM29R?=
 =?utf-8?B?TWxFNXFvNHlvQXFZcGZ4MlBSbnlkMkVZcml6TCtSQTZKaCtXU25JTGFIQ0xu?=
 =?utf-8?B?R3pDWnZTSmdOYnNqZG1IcXhscy9TSDg5VFlzemFjOFJrRjdRR0FMUWhneHlW?=
 =?utf-8?B?cVdjUzFndTBaNStDckpYVkMvL0hJbEhoSnpEbnM0czQxaTBtSTBOOVJ2MmRn?=
 =?utf-8?B?cWt1RndZcy9FNUlMZnZhNkdHb0RMTnBuUDU1VEtuS2VqaUdOSDBLRktSV0NC?=
 =?utf-8?B?dWdPMFlZRE1pTWQxUXFkMDA0Y3hhMzdMMGhaZVM3djExNFdiRkw5TXpZdUFH?=
 =?utf-8?B?RUJsVU1GV2lWMzRyeU5vcUVVN1BPVkY1QUVnbngyaEY5N3dzMUloWjRWb2RJ?=
 =?utf-8?B?R01BdlhDRFdmU084MTVZMmdnRlJ5Q3R6ZENaMlRnZ0VTS2d3UERXdFRCdTNB?=
 =?utf-8?B?eGFIekdqMk85eTJvSGdMZHI5TThPdURnUTgrR3FOd3JuVnJxcmpJZHBGL1ZY?=
 =?utf-8?B?SHpTZ2hac1hFcmFJdW1JT1UwZXVNZGMrb242bkI4ZHgrVmpHK0tjelhvSkl2?=
 =?utf-8?B?VlF3S1JGYjZnWmhkQ3ZibTVENC9ZNzlOVDVaT1B1MTh3OTN2TWhuaVNEU0Rn?=
 =?utf-8?B?QjZ3aWYwbDRWVGU3eTVDWjlSbUlZM29razNvTFN6RVRYVXM0QkpNeWxHOHdh?=
 =?utf-8?Q?rmiRi0mjPpU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDF5QzdpelBJK3BIYTNndktrWU5QYUdCNEpTRmVQVEZyd2lWSTBaVFhCcnAz?=
 =?utf-8?B?MzZGczl0bHlOejhjZVFkdnJZZHU2T3RBR1pIb25JOThoSmFHTTg1QXBDeEtL?=
 =?utf-8?B?djMrNXdjWjc5RTA2M2EwT3pLcVdyMktFbTltSW15RUl3WVhtdUF6ZGRxRGYw?=
 =?utf-8?B?cXdablBVTVpMYXFlNnUzYXlJVmpHaGNpcG92clhZb0V2OWpOYjRFaXo4N0g2?=
 =?utf-8?B?VUNOT09jSklwMlVXWnlUUWpuODlVeWpGWlpDOUN6RU5keXJrNml3Q1hMcGZC?=
 =?utf-8?B?dDVHMzRoU0tEY0crV2RqdVRVM2xZVHlTeUVyTjEyL0pZM29uVzV6dFlFSzhJ?=
 =?utf-8?B?WnJoMVpXZmNwc2lMLy84MW83ODF3NEFxRjg1Nmpob3c3bVo1bkJzR1FKcFYz?=
 =?utf-8?B?bmRTa3VhN2lCWlNNQ3c2eVN2bXBEajBPbFdUQ1l1UEZQOWRldE40c1pmOStm?=
 =?utf-8?B?ZGVMbFNGRGVWaWY3Z2ZObU1HSmZ3YU4vbzZNZ3puS1dDMmltY3ExMEZkRElT?=
 =?utf-8?B?SlVRSVlKSVYvcEpiNFh2c1hvbUhxZVZZdkt0bDVkY05EcHNUNS9nTmJKclNo?=
 =?utf-8?B?VG81N3A5K3dhZ3d2VFhuUG80anNjMGtwUnUwR1hmSHFnOGVkbGM4NFFxQ0Iz?=
 =?utf-8?B?Q1VjYUFobm8xSjhCbm11QkREeE94YmJETmlrNGtxL2xnaUJnK3hyVlBiZ0Qv?=
 =?utf-8?B?WnNpYVBHNzY4d2hGQXU0WFVSL2pYeVo4YnlkM21WWCtRYnRaYjRobi9vang1?=
 =?utf-8?B?elJodEJqckdNbHgxNEFFMG4zbDRiSWZHWFVIWEdrOXB3YVlqWkZwVlRqa0li?=
 =?utf-8?B?ZXpySlhPMDRlOGNkcU5WdzhTeUFJeWErZG9vQWJMejZDWk5VMktiMTIvVzhZ?=
 =?utf-8?B?Y0hMcGVKa0RDbk9UQU1BVmE1aWw5aTVPaG5lYjdWbURnWjRnVmZyL29rQjFI?=
 =?utf-8?B?ZTZxbWpjMHhlMEFqOUJPcmVmUDZQZUxQbitENXp2eWFOSURwSnFlWDZreUd5?=
 =?utf-8?B?SXpzUzFXRS80NjFuazNxd0Y5VU9GdExWY1pxMm80VDZJMnJ2cUJyUGJTUHNq?=
 =?utf-8?B?M0JZT0ZRWklrb0tCaWZEcnI3ejNpc2M2czZ0UFZjSjZWOWR6bWJ4Tms1VTZC?=
 =?utf-8?B?S3lGWGx2S01xNENUQW44eTZybGxMcmVLTEtKbWZnTDk2NWIvSXB0c2Y1ZUw2?=
 =?utf-8?B?cjlXaDB5Qkc2c2VzUWxRWU12YVJESDN1cm9KdGdxVnh0YWtYZDl0NG5jNlhX?=
 =?utf-8?B?ZlRza1doQWlsYkEwSytuTGQ3MkxzN2l3dGJLOXF0Q1NvUWNnaW5hSnJxbjlL?=
 =?utf-8?B?dFZRMSt3OTVrUkhOYVI2VDhVd3ZMeDMrR3hwTVYxTXpneFF3QUc1a2F5M21l?=
 =?utf-8?B?R2MzOEJ5THJ6ZjlYcVVmNndQZGlQekYwWjNMY083amRtaXd3L2dTSWxTVy9Q?=
 =?utf-8?B?MDBvQ0dXR3V4SVUwZ0YxeVp3NmhBWHNydlo4aG04b2ZwRS9va2FCa3JkK1E4?=
 =?utf-8?B?ZDFKNEljK3BiVDJsdnYxZ2xtQ3RmSGNENitpR1ZpeWZpcndwdWkrWkIzeHow?=
 =?utf-8?B?NktKdnlpWllJSUVSSy9US245MDRmNjRCaDlFR2UrTktwNUZJQW9kZlY3UXNM?=
 =?utf-8?B?cVVZV0psblJqYzBiK0FGRnBNR0ZtZHh3ZFlLa3NwOEFYTUpUNnY5ZHBvWEkv?=
 =?utf-8?B?WWpFbjhPb2hCcWhGczlyOWRqcUlvRVJEMnR3dDdnY3Y3dnJRaUlTMFZrMXd4?=
 =?utf-8?B?QUJRUlFkR21ZRlJicTB0MERza0V1SEZtd2xtQWR5NU9CUVZqUGlxVGwwNS8y?=
 =?utf-8?B?V21PZlZmR2RPTVRDSmN5ckxMQ1d0TGlnZTJjaUNoSGt4dkNwd3RMb1BqQTAz?=
 =?utf-8?B?Y3FQejhjQmxJMW1wb25UMG52SVExZ3dOVDlQNUxobWloMjNOWGl0WW1aN1Mx?=
 =?utf-8?B?TlZiZ044alZ3SGJxZytlaVAxMFpPeHB3aitMNlBKOCtSNFJ1RktNY1VkL2lu?=
 =?utf-8?B?UzV5R1BTQm9EM0ZidU1BeG9ZRnFPZW1xWHFwcTFBTnpOT0twbjl0blJORkdW?=
 =?utf-8?B?Z0R6TDNzL1BpTlBKRnAzblArOXg2akpXR245REpCN25hSUhFa0JwU3cyRVNR?=
 =?utf-8?Q?WetaYXqyO68tvyXtcXLslKcHe?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a218aa6e-55f2-4269-bc4a-08dd87bb05ce
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 07:45:48.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emORZxSztflWDtgJunnX4i/EHjKJZxLik+fdI0bsGsZE4xUd84Dybosw/kXlSEhWvya8V/05vIdZN0YSn4uTZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFC94CEC410

Hi Luiz, Pauli
>
> Hi Pauli,
>
> On Tue, Apr 29, 2025 at 10:35 AM Pauli Virtanen <pav@iki.fi> wrote:
>> Hi,
>>
>> 29. huhtikuuta 2025 17.31.25 GMT+03:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com> kirjoitti:
>>> Hi Pauli,
>>>
>>> On Tue, Apr 29, 2025 at 10:29 AM Pauli Virtanen <pav@iki.fi> wrote:
>>>> ti, 2025-04-29 kello 17:26 +0300, Pauli Virtanen kirjoitti:
>>>>> Hi,
>>>>>
>>>>> ti, 2025-04-29 kello 11:35 +0800, Yang Li via B4 Relay kirjoitti:
>>>>>> From: Yang Li <yang.li@amlogic.com>
>>>>>>
>>>>>> Application layer programs (like pipewire) need to use
>>>>>> iso timestamp information for audio synchronization.
>>>>> I think the timestamp should be put into CMSG, same ways as packet
>>>>> status is. The packet body should then always contain only the payload.
>>>> Or, this maybe should instead use the SOF_TIMESTAMPING_RX_HARDWARE
>>>> mechanism, which would avoid adding a new API.
>>> Either that or we use BT_PKT_STATUS, does SOF_TIMESTAMPING_RX_HARDWARE
>>> requires the use of errqueue?
>> No, it just adds a CMSG, similar to the RX software tstamp.
> Perfect, then there should be no problem going with that, we might
> want to introduce some tests for it and perhaps have the emulator
> adding timestamps headers so we can test this with the likes of
> iso-tester.
Okay, let me try.
>
>>>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>>>> ---
>>>>>>   include/net/bluetooth/bluetooth.h |  4 ++-
>>>>>>   net/bluetooth/iso.c               | 58 +++++++++++++++++++++++++++++++++------
>>>>>>   2 files changed, 52 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>>>>> index bbefde319f95..a102bd76647c 100644
>>>>>> --- a/include/net/bluetooth/bluetooth.h
>>>>>> +++ b/include/net/bluetooth/bluetooth.h
>>>>>> @@ -242,6 +242,7 @@ struct bt_codecs {
>>>>>>   #define BT_CODEC_MSBC              0x05
>>>>>>
>>>>>>   #define BT_ISO_BASE                20
>>>>>> +#define BT_ISO_TS          21
>>>>>>
>>>>>>   __printf(1, 2)
>>>>>>   void bt_info(const char *fmt, ...);
>>>>>> @@ -390,7 +391,8 @@ struct bt_sock {
>>>>>>   enum {
>>>>>>      BT_SK_DEFER_SETUP,
>>>>>>      BT_SK_SUSPEND,
>>>>>> -   BT_SK_PKT_STATUS
>>>>>> +   BT_SK_PKT_STATUS,
>>>>>> +   BT_SK_ISO_TS
>>>>>>   };
>>>>>>
>>>>>>   struct bt_sock_list {
>>>>>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>>>>>> index 2f348f48e99d..2c1fdea4b8c1 100644
>>>>>> --- a/net/bluetooth/iso.c
>>>>>> +++ b/net/bluetooth/iso.c
>>>>>> @@ -1718,7 +1718,21 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
>>>>>>              iso_pi(sk)->base_len = optlen;
>>>>>>
>>>>>>              break;
>>>>>> +   case BT_ISO_TS:
>>>>>> +           if (optlen != sizeof(opt)) {
>>>>>> +                   err = -EINVAL;
>>>>>> +                   break;
>>>>>> +           }
>>>>>>
>>>>>> +           err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
>>>>>> +           if (err)
>>>>>> +                   break;
>>>>>> +
>>>>>> +           if (opt)
>>>>>> +                   set_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
>>>>>> +           else
>>>>>> +                   clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
>>>>>> +           break;
>>>>>>      default:
>>>>>>              err = -ENOPROTOOPT;
>>>>>>              break;
>>>>>> @@ -1789,7 +1803,16 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
>>>>>>                      err = -EFAULT;
>>>>>>
>>>>>>              break;
>>>>>> +   case BT_ISO_TS:
>>>>>> +           if (len < sizeof(u32)) {
>>>>>> +                   err = -EINVAL;
>>>>>> +                   break;
>>>>>> +           }
>>>>>>
>>>>>> +           if (put_user(test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags),
>>>>>> +                       (u32 __user *)optval))
>>>>>> +                   err = -EFAULT;
>>>>>> +           break;
>>>>>>      default:
>>>>>>              err = -ENOPROTOOPT;
>>>>>>              break;
>>>>>> @@ -2271,13 +2294,21 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>>>>>>   void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>>>>>   {
>>>>>>      struct iso_conn *conn = hcon->iso_data;
>>>>>> +   struct sock *sk;
>>>>>>      __u16 pb, ts, len;
>>>>>>
>>>>>>      if (!conn)
>>>>>>              goto drop;
>>>>>>
>>>>>> -   pb     = hci_iso_flags_pb(flags);
>>>>>> -   ts     = hci_iso_flags_ts(flags);
>>>>>> +   iso_conn_lock(conn);
>>>>>> +   sk = conn->sk;
>>>>>> +   iso_conn_unlock(conn);
>>>>>> +
>>>>>> +   if (!sk)
>>>>>> +           goto drop;
>>>>>> +
>>>>>> +   pb = hci_iso_flags_pb(flags);
>>>>>> +   ts = hci_iso_flags_ts(flags);
>>>>>>
>>>>>>      BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, ts);
>>>>>>
>>>>>> @@ -2294,17 +2325,26 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>>>>>              if (ts) {
>>>>>>                      struct hci_iso_ts_data_hdr *hdr;
>>>>>>
>>>>>> -                   /* TODO: add timestamp to the packet? */
>>>>>> -                   hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>>>>>> -                   if (!hdr) {
>>>>>> -                           BT_ERR("Frame is too short (len %d)", skb->len);
>>>>>> -                           goto drop;
>>>>>> -                   }
>>>>>> +                   if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
>>>>>> +                           hdr = (struct hci_iso_ts_data_hdr *)skb->data;
>>>>>> +                           len = hdr->slen + HCI_ISO_TS_DATA_HDR_SIZE;
>>>>>> +                   } else {
>>>>>> +                           hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>>>>>> +                           if (!hdr) {
>>>>>> +                                   BT_ERR("Frame is too short (len %d)", skb->len);
>>>>>> +                                   goto drop;
>>>>>> +                           }
>>>>>>
>>>>>> -                   len = __le16_to_cpu(hdr->slen);
>>>>>> +                           len = __le16_to_cpu(hdr->slen);
>>>>>> +                   }
>>>>>>              } else {
>>>>>>                      struct hci_iso_data_hdr *hdr;
>>>>>>
>>>>>> +                   if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
>>>>>> +                           BT_ERR("Invalid option BT_SK_ISO_TS");
>>>>>> +                           clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
>>>>>> +                   }
>>>>>> +
>>>>>>                      hdr = skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZE);
>>>>>>                      if (!hdr) {
>>>>>>                              BT_ERR("Frame is too short (len %d)", skb->len);
>>>>>>
>>>>>> ---
>>>>>> base-commit: 16b4f97defefd93cfaea017a7c3e8849322f7dde
>>>>>> change-id: 20250421-iso_ts-c82a300ae784
>>>>>>
>>>>>> Best regards,
>>>
>>>
>
>
> --
> Luiz Augusto von Dentz

