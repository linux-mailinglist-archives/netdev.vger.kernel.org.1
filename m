Return-Path: <netdev+bounces-171494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C3A4D2B6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 06:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB3E18933CA
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 05:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D81EEA54;
	Tue,  4 Mar 2025 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CmJyw/OT"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2088.outbound.protection.outlook.com [40.92.107.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF0126C03;
	Tue,  4 Mar 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064480; cv=fail; b=RMkM5wMbLuVhBxnwBIoWV1mTfLFNkFUsxY/5RtRKQMUknshjWXQuBo761Bre0KbJpJO7HfGiAr2Au1lOxtRzkViTpFMqGen8FWjhf6RxkCIjDhjKgQq7DeklT+iNOloe4YmUbO/VEHv/wlKT0hYRgQC7+jkXbGffc58a7XSkpUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064480; c=relaxed/simple;
	bh=MWjvhMjQE3P3NmO78RH0zP3bc9RdIqrQWjwMHKN04o8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7U8Zc00lHArY/u69QJeZaVWtUc+LRfd+KTLrN0Yc9g6tIvw7zRjV9YnGrvPo/6wvv/cyO+HIGkkKbFYRaP9CELab0mlUhDLsUBrZZ1mx5BUR4BTUMTtjmrTIqjDbvmz0mqB+Nn5Z411u9xA0w+GuXz9MXr2C2pG2vw6Pd6HcC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CmJyw/OT; arc=fail smtp.client-ip=40.92.107.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osJxHBqgtriIRqXhe7LuBYkpnZjFR2ElfUsLERpvXkVSIMLR+eU/XNPhG8i5RNn8ftraHN2xCmMDVFJWPWnrwE+ACnKbb19C1R7qnGCs8foHkVlRDVF9gFTI8DIk9/ZZQRZHiZhnhoJ0jjwfiEC+/H/ai/zCvRaa7jU+IguNeKuyf6ABSx7Y6CwGtvUwTCvmzli+gnOBFqBFg42DzTJvYxhr/q9JXz85x/6M1Av3KFVa84nsQ6V5PGVCZ208vY6bEjkdyAejW54c9WBzlXZ0B6Kg3B5imXNAGh+j7JXoWgMoLHHy7atBsyR4ZjGehQpZOxs6CI88V2Gdqa+tFVbKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbqAchl8sQ+ILPVN2Wk4dGR5XM4EttQlIoUWu6JnD+w=;
 b=rgo5TYzaoAn1GnLFEu2Bc7dzicJ6v092d1jClg8UdGcQaaMR3N8Kdnynd6Of3gey82JHUgOzUSn51VKdhHiFtvVG6UXpr3pvKjNdysUYTNqYQlCccRKpc+15WjRgPt2eZo0qYc+bNr3cCcWjSgMgVZwuxNrXkjZRMgYQ/EW/c5YOfM7Tw4wgV1FWiUPxH2AkLRJ5cJz2xcVe5fD+PEmJegWvZkj75XGwV5Ga70adBgz90Qww0C4pH5t6pRd+tPHvdzF3is7xmYpvK01OT6+wwq+jjiVggb3vRPBhz5UPM+VUWVaIz58TZGEt+oB1/4kFyQsyocdXzmQZ4fJCi4FQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbqAchl8sQ+ILPVN2Wk4dGR5XM4EttQlIoUWu6JnD+w=;
 b=CmJyw/OT8m3A1meCAkRu6OZdvk+HfouNXLPOrJU97/AgtdwhBeDbdbgPnyncuE58W0bq+RHYMH4SBFAbUm/uJfsiu2NDIxNa02eACeSxF//PrNUom+M/dXC2D3EvMkVJ58GIhfsWMHJ6jUs8RrCxQ7tj4X9Hn15yUUMkUmrA0HeKduxBQzsMu0MMPMtlXTJSGp+XyVTHWKfFh9waY38kKLoPbs0ONe3xK6prvuOF/VMkP8hlfzBOUsk2MFhAt4/wzCv5oh2HJirfzDlwPYokOZK6BZ07xQUcTrMkfI+FyZ8E605bCLTNrshWt5A0eh5SBOwn7YAXUgUbks+FSMifZQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SEZPR01MB5422.apcprd01.prod.exchangelabs.com
 (2603:1096:101:a2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 05:01:14 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:01:13 +0000
Message-ID:
 <TYZPR01MB5556A170A7D60C75FC134ECEC9C82@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Tue, 4 Mar 2025 13:00:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: net: dsa: qca8k: add internal-PHY-to-PHY
 CPU link example
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rmk+kernel@armlinux.org.uk,
 javier.carrasco.cruz@gmail.com, john@phrozen.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D90A3778BDF7AB9A7030C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <ae329902-c940-4fd3-a857-c6689fa35680@lunn.ch>
 <TYZPR01MB5556C13F2BE2042DDE466C95C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <55a2e7d3-f201-48d7-be4e-5d1307e52f56@lunn.ch>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <55a2e7d3-f201-48d7-be4e-5d1307e52f56@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <3fff1fba-2631-49b8-b419-f0e4f3aa8646@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SEZPR01MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 03863fb8-0641-45f1-cb6e-08dd5ad9965e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6090799003|461199028|5072599009|15080799006|19110799003|1602099012|3412199025|440099028|4302099013|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDF3cVRraENSd2pYMVlraTJYUWxUREl0YmQ4Yy9hbklqNU9Eb0RQdVh3MmR5?=
 =?utf-8?B?WWNOQ1dDMGhWV0VFdmhnRnI4ckFuMFpVTlFSNWxTaTM3eDU3dmM0YlYvUDhj?=
 =?utf-8?B?dHRxOUpCS3UvTU44RTdXZlRMVS8zem40WmUyNWFBOGUzY2lyMXhBc2trMDVU?=
 =?utf-8?B?WTV0RFo1OGsxSTZhdVlxQWp4LzF4cVhWOHQrNHhlbDUvQ2g1QVl3ZDBxS203?=
 =?utf-8?B?TENUcVVReDgvRHkyZDFxa3FBRWpLRm0zcTJxTWQyUldQNTlpYisvYzczeFlH?=
 =?utf-8?B?bWNEc0NYODJZL1ZPb1YxR2lvWnBrV3JmQUdKNE1DR2xHWnhnYjlsdnJqSWZO?=
 =?utf-8?B?N1pZb0d2M21tSEZnTms1dXdZSnZMK2Qxa2p1blV5dFdwak1nWG9MT3NMY2Nr?=
 =?utf-8?B?TkdWMkVRWHg3NTdHdERtQVdrZFA5bjQzdWZ6L1grT1MyVHZ6cVdYb3Y5ekZx?=
 =?utf-8?B?ZGo5MmplVkZsNmFLRDczMDNiVnRJMFkydmRZdDFncHlHcWg5Yjd6UmpIK2cw?=
 =?utf-8?B?NG42blR4YTVMOFdOclZIMHlKSSs4UDZTNUJGR0o5TGxISW1pNytoMzNMemFH?=
 =?utf-8?B?ME1lTXBaUnA3b2QwMkorbnc1czNzYkxveVJycWk5SWc5SEcxYkYwT0pSdHlC?=
 =?utf-8?B?UHVJWVREN0tsMWFiR3kzRjk5WFhvWFhXa0hLVVh5K2IrNmVoMTlyVXhqL1do?=
 =?utf-8?B?VWJNWG0wSGdzRExOZDJGSklsakloR1B2dStmamZsb1p4VC9iWnZyOXZ1c1Z3?=
 =?utf-8?B?aUdpQXBLb2dSMFlMc0pjbGw5a21NeHR2bHpwY2RCZEZLZ2ZrdlF0ZlBabjVs?=
 =?utf-8?B?V25ubk5haG0wdVhRa09NbmpheHhIRXNoRi9IbExkTUkwamFqbWJjU3ZGSTJQ?=
 =?utf-8?B?TU92b3FtN2gxQ0hldDVJMnJSNGR5WkxMWkltUm03TVprT1NZdnltQlhNbG90?=
 =?utf-8?B?L2hnNy9hVDhadEJHcHlBZGhxOHVWNU9yK2Zmc0I0amdFV29jSmlNTytaR2N4?=
 =?utf-8?B?UFdQcFlRd1hTZFZVOXBhaEZqOS90UnJ3ZEd3Ykc3cFgxTXhhMW83R2dkYUdY?=
 =?utf-8?B?V2JvN093RDVIa25OL1p2M3N3SVU1OE1FbzZCWHRNdEM4endqeWNQOWR1TVVE?=
 =?utf-8?B?NnVTWVQzOXA3bmRsYlFOazUxa2NTVEZpeHVRRkt4ckV1MU5xSlEzTVNtVlBZ?=
 =?utf-8?B?TTJHRnU5ZGQyVXRKWWF2ZTRybXVnVDZVN0lWbTY5dE0vNDFUQzcvWjRCRXJB?=
 =?utf-8?B?U0d6bDQ0Q3dWM3E0MGlpVlgrZGwyR1lxbEtuWjZ0MEg5TkFOdGgxbkY0M0lM?=
 =?utf-8?B?RkJQSzM1Z2NjcjQzcXhFQlNkTVZTK05rN3RPY2w0eUNFMVNsT0NDVGtoR0lk?=
 =?utf-8?B?d3FMZCtwMEhBZGx1UXhUYmhBQkJGVE1Ha1daRVJZS05WYWtVWjZLRjdzRWtW?=
 =?utf-8?B?Si9nVUg4OFErSGJTL0paVTgvT2ZLQlVweExpZjJ2UG5vcmpLazRuaDN6ZE9u?=
 =?utf-8?B?RE81L2F0elZaRlFVZmJCWjE2Vk9MdXErc2hBanpFcmxYQzI3K28weW9rMmxM?=
 =?utf-8?B?NFF3aEpuSmkzdmpqcWtYTTB5Rm50dTVWcCtWazIxQUJiRGpISUJwejFaM1Ey?=
 =?utf-8?Q?5iAHKNyA3TXDxt2/OpJTEdjgm/rWsSTi5MYKc6+9oqhA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDVQQVlQcEdIMEJhSEFnWEgrVEM5T1VJRDFrQStTcGhSdkpqaDBXVUVNNXZh?=
 =?utf-8?B?MDk2cCtuRjlWVGlqMU1Yb3gvYXZ3b3FWWDhVenNCbXUrTFFRb2VTd0R0T0Fm?=
 =?utf-8?B?c0l5S0lFYlo2OXYxbDhqK2RPa3RzREJ5UUV5QUhDYjQ2TytRMGVNNFZYZm1x?=
 =?utf-8?B?SEpMQUlxMXh6Q0pxOTZ2TmpQTjZoZ28vMEZOdDdhM0hMTjV5Qm9sdFlsS1A5?=
 =?utf-8?B?WVRGYURtQk1rWlNrZ1ZhNDc2N0FQQ29RaUlsRGZLVHdaRWxkME1aRGdMejNL?=
 =?utf-8?B?MENMYUZrZWNtOTZDOWN1NUYvckJnVTRlSEo2amJmRmM0RjdRMitubEtZekdy?=
 =?utf-8?B?cWE5N1cxMVhzTHplZ2hTMkxFaWlTT200d1hNTVlJM05hN1p4b1l3Qks4ZUZi?=
 =?utf-8?B?S1p4VEkxN3JvMXBQMFR1TDAvMWV1N2JmMlJXWGJvMHlDS3BheG1vbzl4dG1o?=
 =?utf-8?B?Q1I5ZzdaclZETkRhaG0zWFcrZTZ4MTRrL24rLzdyRDhiK0lyT0ZRNXkwSHJN?=
 =?utf-8?B?U2c0TXJHbW9LMHJEamxmRDgwZkc2NUtVYk9NdW1BcU1PTVhiSGUreXE0eURG?=
 =?utf-8?B?bTIxbXhJNU94eGhhSy8vVUt2NGphODJOczE4cVpqLzNHSlppeGJtVGlXbS9v?=
 =?utf-8?B?U2tVSzdXbmxDd0k5ZVpjRTBwWjduUDhwNUJjbzJtTXF6Z3dXcnhDSGs1K0VK?=
 =?utf-8?B?TjBwdWozYWhEZFlDLzFBYXl1eFA0aVhMa1JDZFRYR3RPZTdwZU1HcXovNWdo?=
 =?utf-8?B?MlJLVURHbXhsQVFoVHlBZ3J6L2tRTStPWDExbnhLU1hJSmVSdGhwRzF2akYx?=
 =?utf-8?B?QUNyS29jUXZKTWRrWDRBdEs1TWl3bG5RcW9DQVQ1c0pYWG5RZjI1dUM3dzl5?=
 =?utf-8?B?VUdwZzREWVA5NXVGTDVDdTNYUi9tYzJpbnFEMDZVK0pPbklvSC9CYlVjMzM2?=
 =?utf-8?B?VzhseFlWR0d1L1YyRjY3YzQxYUV5VVNROG54OHhwMDdNenBRNzZDUklad3Vs?=
 =?utf-8?B?aks4bTlRdHVZUHR2cDFmTndlalJBeU9raUp3SlNya3ZKa2p1UmQ1ZTM3NTlP?=
 =?utf-8?B?V3BFZ0hBRjVzSW1Sa3hXMkRJOXBXSnlLZWx5RDdYMmNyTDloNFlCZUJuTlR4?=
 =?utf-8?B?OHJxMTZha0Y2My9KRmM4UnM1TlpuWUdGQ25MQ2Fla1kwS0Vsb1lHYlhkczVS?=
 =?utf-8?B?QmZQWVNyV3p0R3lVTkhxWE52eXRtb3UzT3BqQ2xUMWhLRFJoZE42TVpjYllr?=
 =?utf-8?B?ZnNCSmhpOFFjS3AxQXk0UjkwczZsR291ZHlyTUhJWVBrMHhxeVBiS0RlZmFl?=
 =?utf-8?B?VkZOZGx4NFRHSENUTlZoZGhKbXlPWmx4RXQ3enlPTTFNS2tYRnNtUmJ1Tkpq?=
 =?utf-8?B?bmt4UHY1ZVNDbzBBNG10andKMTVMODBPYnpoMTlyOWZRVGx0VDEzejJxbjFT?=
 =?utf-8?B?M0c0SFM2MlVVUEovZlB6enRlN2k2TW9LdkpqaE9jQWJRczBHYUs5c1M0TFRz?=
 =?utf-8?B?enAyNDVkUGZINXJRQTZmV0Z5NjJXWHhQRENLU1AyUWI1bjhMMjJ4K2kwWmlN?=
 =?utf-8?B?RXdKRm52dDJCTGVoWWFqbGsxNUJldXBlR3RoSUF2emN5dklBWURGY0NqSkFv?=
 =?utf-8?Q?z8+z0kvCrBQsYP6OLzch3FsZQkzNBfLTF0T2bnO0pFJM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03863fb8-0641-45f1-cb6e-08dd5ad9965e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:01:13.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5422

在 2025/3/4 1:15, Andrew Lunn 写道:
> On Tue, Mar 04, 2025 at 12:37:36AM +0800, Ziyang Huang wrote:
>> 在 2025/3/4 0:15, Andrew Lunn 写道:
>>> ...
>>>
>>> The previous patch still causes it to look at port 0 and then port 6
>>> first. Only if they are not CPU ports will it look at other ports. So
>>> this example does not work, port 6 will be the CPU port, even with the
>>> properties you added.
>>
>> Sorry, I forget that the following patch is still penging:
>> https://lore.kernel.org/all/20230620063747.19175-1-ansuelsmth@gmail.com/
>>
>> With this path, we can have multi CPU link.
> 
> So you should get that merged first. Then this patch.

After checking the code again, the demo 2 has already had 2 CPU link
(Port0 and Port6). Could I just keep this or should I need to add a new
case ?

>>> When you fix this, i also think it would be good to extend:
>>>
>>>> +                    /* PHY-to-PHY CPU link */
>>>
>>> with the work internal.
>>>
>>> This also seems an odd architecture to me. If this is SoC internal,
>>> why not do a MAC to MAC link? What benefit do you get from having the
>>> PHYs?
>>
>> This patches are for IPQ50xx platform which has only one a SGMII/SGMII+ link
>> and a MDI link.
>>
>> It has 2 common designs:
>>   1. SGMII+ is used to connect a 2.5G PHY, which make qca8337 only be able to
>> be connected through the MDI link.
> 
> Please do not call it SGMII+. It is not SGMII if it is running at
> 2.5G. It is more likely to be broken 2500BaseX, broken in that it does
> not implement the inband signalling.
> 
>>   2. Both SGMII and MDI links are used to connect the qca8337, so we can get
>> 2G link which is beneficial in NAT mode (total 2G bidirectional).
> 
> So is this actually internally? Or do you have a IPQ50xx SoC connected
> to a qca8337 switch, with copper traces on a PCB? If so, it is not
> internal.

I think I known which point you are confused about. Sorry for my poor
English.

The "internal" is used to describe the localcation of PHY not the link.
In current code, qca8k has supported to use a external PHY to do a
PHY-to-PHY link (Port0 and Port6). This patch make the internal PHYs
support it too (Port1-5).

The followiing topology is existed in most IPQ50xx-based router:
      _______________________         _______________________
     |        IPQ5018        |       |        QCA8337        |
     | +------+   +--------+ |       | +--------+   +------+ |
     | | MAC0 |---| GE Phy |-+--MDI--+-|  Phy4  |---| MAC5 | |
     | +------+   +--------+ |       | +--------+   +------+ |
     | +------+   +--------+ |       | +--------+   +------+ |
     | | MAC1 |---| Uniphy |-+-SGMII-+-| SerDes |---| MAC0 | |
     | +------+   +--------+ |       | +--------+   +------+ |
     |_______________________|       |_______________________|

> 	Andrew


