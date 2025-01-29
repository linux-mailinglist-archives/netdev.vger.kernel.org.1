Return-Path: <netdev+bounces-161540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8331A22285
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D81645DE
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC191DEFD6;
	Wed, 29 Jan 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="JwbRHUO1"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023142.outbound.protection.outlook.com [52.101.67.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F884A21
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170479; cv=fail; b=O255wobPUUSMru/UElfYlIxBicZr7WhT1mfq8fJgD9xdqRHtiQdoxm5LyDr9kQO7qDDl/RuX5W9C3N7iJcwxwX8jvohzm87bHfvMy2asKqlDZDQHYe+rg7ap2GY+YcIgg6pU/bRwLDP70DFWI8v6F5hAz14Mux0vIhvMvWnJRpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170479; c=relaxed/simple;
	bh=5JiRRW11FZA4/5oPhh7xN8dfU906+0fqf0EbQzQLLXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sCFF5bTQxtITNOfrj3cLtR6dixNFYKyNfcm/4GhXJPgc0eJfNVbPSwZqLSFrzlkmXelQr6BWjLft0dowtWOyO73awtWMyL4moNvg8cqL9zstL8h+rqWJw+tLL971EHBrT6KdiFq0C/F5AzfUlUZOn0Z0iUBWolT+fDfsqJyLck8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=JwbRHUO1; arc=fail smtp.client-ip=52.101.67.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFyzO9eBR6niMRVxYqPlO7OUPUrDtWWgtif8+UM2GhTewkYBtJa5sxPgD5iESIcoFcpK0haV7Vsx1Xodk/AYlERGLMgFsk2boqQyp9qPYwhICNo0Ioi1YMG1Xs45rEJPrecna+hmD8x0G6SJtKDOyRf+DqaKxlDUtfVEA7BJmDegm2ISj8pAx5cKmE4Bk0PJtdU3leeQsA5Qf6Un5wSajg0Oo4bkfRclOudgPgg6ijaS/QMeKAjpWZbjbDnUwS3PSFkc8WGtXovJK8cV5IcOxAuAf+DWRvbqjc8xsM+/Ix3ar2uJ3PlTe30x6Hc5JiTs9eFHZQQ8EDhSAQn/siIwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9zBHC9mEW3jX/W4i07B+cWbOiADP7JpAOWbNHx/Jmg=;
 b=zMAzBKvL32zK2cCvbkg2XVY9JorpqZVKgtf2AjKcs1HVme5ozIzzsDjOAnhES+GCcfat2jy+4pcnFxWAzqa2SeJRQbAhMDF77XF9h+lpOG3e6aA0xhoqyJNT+R328s2CppisWlvEaanEgvULxvEZ3LhQhaBOIbiAX2uCJFEbP/TWKaM4c6fvxbnWQqBD/tXk6jixb59HM5mKCq8xgUQpowXOVnxETb3/IEHWqaE1vwXVo/OsaICdV2j3YAdKHFsY1IF+XTPuwLIs+RiIqniG5gOXb0XE6gLG/YGq17lVfUJ6LLho+ePr5oErRQlVhtWn6Zs8PmA2H5EFplnB9SCy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9zBHC9mEW3jX/W4i07B+cWbOiADP7JpAOWbNHx/Jmg=;
 b=JwbRHUO1Xe5kauoxk7cjwHVU4/1mRUJclGsxAj5N/0/QKMr+KDjycphZCAh6Zo4bJCXrjAgzyYXrPADlgpu4stVJ2+0CX+l07RebNgh279GVQtcUJV0HL/SjhQv/EakydJ3KEPHnAHWK+wG2OfGSaiX4dlOz0rV1WiTo96IgZso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM7PR10MB3605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 17:07:52 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 17:07:52 +0000
Message-ID: <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
Date: Wed, 29 Jan 2025 18:07:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250129145845.3988cf04@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM7PR10MB3605:EE_
X-MS-Office365-Filtering-Correlation-Id: 54707a4c-ce60-4fab-09da-08dd40877767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXVYK3hCaUdkcC9xZys4OVBuNXFDaWZmWEMvMEprMUtyRFNNS3JyOFVTRVB0?=
 =?utf-8?B?emhtSzFDdWFSUlhMSW50SVEvZWhiNjJ1RVdSTjAzbURMY0tLc0dhV296ZXFz?=
 =?utf-8?B?M3ZOdDRIK3B5cGxLSGgvR2N1U3JIVDNxa2ZXdFp5NUFMUTFJbHBlZUFrSDll?=
 =?utf-8?B?N0xKSm1WaTdsMHhHL1k2WFp0bnROMFZXYzI1VkxvUlc0Z3pqWEFrMXVWOWov?=
 =?utf-8?B?Z25IYys5WGY3ZjZOZkNPbjE1UHBOYVJJMEs0U1ZVdHZmY0ZzZUkwc0FLU2NK?=
 =?utf-8?B?Wkg3WjR3YTgvTlFCYnQvWHdwZkJsSlY2ellzTHA5VXlTWHZPV3VYSzNWblFw?=
 =?utf-8?B?OUJaQTViRkp2b0NQUW5HNWorOG1WRjNNMXNFYVYyV0tEVDIzMTUzUUt2bjVC?=
 =?utf-8?B?SGFhWlMydVNFaDAySFlrelpKVDFPMXVZeUtxNUQwazRiYXIvbFNZQ3Q5dXJj?=
 =?utf-8?B?aTluci93eXltNmJONDVpRGdzblRvcGVzR25uR0lSK3RTMERhejdkZDJzWWFC?=
 =?utf-8?B?TEJDMitIYk1NRzV4WEhadkxCUlRBekJETjNJOEVqNmttbmplQy9UNVFoNWJr?=
 =?utf-8?B?bzVEMGZKUUJ5clBYNmxDcXNJVjg5NThDWDROK2pKWTdCSE1mSHM3Q1ZPQkJR?=
 =?utf-8?B?RlhrKzRQMStpYm9sanZUSUpwTGNlcktDOU9xSC9yMmpzcmNzeHUxN1FKM3hI?=
 =?utf-8?B?SUZWRzlDZUdRdmhOMjBhekQ2WEh5TDhPSG9PdmRnTUc0TEFUb01EYjd1UzlY?=
 =?utf-8?B?L056aWNkeHBWMWJCT2JsTjZ2TUxST3RGdXZmaEZUaktVcWxvSm5mMitoSzRp?=
 =?utf-8?B?aktNSklmWUNDeStRektSVjcwUWFZQUxMRDJwSWhiclhBMWViWWM5TDhpTkp0?=
 =?utf-8?B?MkNVWWprdk85TTZZMXpQM0Z3Sy84QUZoa2xWVmRpcHRZT3Q0NmRNNkdIbHdv?=
 =?utf-8?B?YXdSR1pXdGJ4aStNdysrWDhsM1QzOUZaMHNwMGlNM1g0VW9sbDVuWWRiR1A4?=
 =?utf-8?B?SGo1dWZQbGFhZkdhYkh1aW9GZ2ZRNXZnVzNVc2NtaWdiVEliVXVzTW1Zbzkw?=
 =?utf-8?B?d2RscDc5cWJnMFd2ZjBISE82QUZXWGx0ekVUenltZVFOTy9kbytsSFl6STVP?=
 =?utf-8?B?NFRDdzIvdW5tTUYxeGd3NDhQVEp4WmZuTWgrajBOUE50QXBsQS9QY29ndUFY?=
 =?utf-8?B?TS8vTkxyMjRGZzNTcVY2OEMrOVZ3QjByUmlpQWVpT05ERTJWVDJxM2pJZzZZ?=
 =?utf-8?B?NDJqWHhIQmxyQnpqcDlwbXpQQkdBaFRoTnA5U25MTUdNZmlBWGdZSll0MVoz?=
 =?utf-8?B?SEhCYzFid0xUdmhrYTNzeHNOZ0JwSEppQXZrcHpJOVpvcUNwUHh5TXNSYmlU?=
 =?utf-8?B?OFRUcHRjOWppQWp6NUFRV29DMmJPWURrcDlJa2w0aFROcTVKN1BBVEsyVnVO?=
 =?utf-8?B?TVp0SzMrd0xVL2N5WU5IWmZKRnRHZVFnNlhvV1p1a0xrUkVTL3NiMlJ1WFN3?=
 =?utf-8?B?WHpWQ2JVWEpxdW1JQWw4dXdNQWpBQlN3NXI1c3gwamQwOE83MlZGS2w5SnNW?=
 =?utf-8?B?ZXZKSWdUZ3hJRGVaZ3pZZ1dVU2FtemVDQnF3ZGJHVFZyMkhGT08vWWMwMVhI?=
 =?utf-8?B?eEYrRHVtZlVsTjl1NVRhQ2tsTk1rSWdMeit2cGNHdytnMmRORTVTWDIxb2to?=
 =?utf-8?B?MEJwOHh2cVV1ZHhEcEkzc3k2Tit5aEJBMlFDR1ZDY29QcWJ1OVNwQWR1eVVF?=
 =?utf-8?B?VFNFTCtLc0dEaG9iaG9neEJhTUtkcnZmS3pzYkx0N1BDTGxidm1mMzhxY3My?=
 =?utf-8?B?Q0JIUDlDcWxWbTcvSitrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3VYdE1WcFQzRHpWSHhBK08wQVZlbVVBaytmVU11ZjVOOHQrL1FGREUwcG5Q?=
 =?utf-8?B?ZVV4eVVCb0hSSnVOMmNCdndvMWlOMmNtaks3UXZ4Y1RaMDNzcmxDUkV6dWk5?=
 =?utf-8?B?R3k1WEdaYlZ1enVUZUs2dGI5MllLWFdLQk1GMis3TEZWeW1aeW9vYkZnNlZD?=
 =?utf-8?B?RjJobTZmeVdSdWVMSzZ2bDBXMDlkOVVBM1FUSGl0bjRjeWQ1UG9mOVUrOXB3?=
 =?utf-8?B?Sk1uMkVibnVTeXVSK3Uvd3VlWDNTQmxxOWlTQklwNHpOeDQ1V1RIRXQ4bEN1?=
 =?utf-8?B?WU9vNlA0dU9UTE9FOUkxNjZiUi9RZXl5a0x0aG5qZ3dSZGkrUHp0aTRPSjNv?=
 =?utf-8?B?ZUpkbVB0cWVJSDB0RFlBQWxuVWUvWjJrM04xS1dyYnpieFFsMTFZY0wwOENX?=
 =?utf-8?B?b3E4WUxFTVNmTzBPOUVSVVl3eTIxQmRLdHhHY0w1R2JvY2didHBEZ2FUNUcy?=
 =?utf-8?B?M3M0WEkxc2lhR0l1eUxhTTFVUHUrNmJKV1BpOThRdkM2K3QxRmVuY1doOGVa?=
 =?utf-8?B?Q2VjcitQVmdPUnhacjMzcnRUNnJHdElXeU5MbHJSRkx0and3eHIyaEowMEtD?=
 =?utf-8?B?UUUxV0pwakk4QnRmVzIzSDF0R2Z3ZjloVlp0ZUFpc0dvRWFZOTQzWGpFSVdi?=
 =?utf-8?B?YnBFVTJGc0JaMWEvZko1dlFubHpSWHUyYVVmUjdpWHgvd2ZYN0J3YnJjZXll?=
 =?utf-8?B?K3JyTm93SktZT2kzcGhwRVBSMHgxVHhTTDVvSnl3bTlxMHhLd09QeVpZL3FZ?=
 =?utf-8?B?VEdOQ0p3eGJUYzNKeWdsbFlHdWdGLzdHYkZic0NMRlhOb0E1bk5EQmFBbFUx?=
 =?utf-8?B?UjlZMEhLNzVmSmNVOFUrazRteWFSNkhDb1grZFd5c3B3cWxMdVFseGhmVSs3?=
 =?utf-8?B?ZGc4OG1ndDljTlpSU3lsOEFselIrdjhRSEFFMWtrVktRalMzY3YwREhpQVoz?=
 =?utf-8?B?bUdiSkhTckt0YXBmVWVJVXBQL0JuV0NRdnBobXMwSHdEbkg2SFJrbWF5Ny9T?=
 =?utf-8?B?Sk56T0krTU1WV2xtOHJLZVNKQ0ViZWpYSThES3F1MlhmTDY3WlI5bVk0VTIv?=
 =?utf-8?B?Vys5OFc1RkZJSEM1dGlFSFd5RlZlbkxQQUR4SUR4MjZqV1hVdm1EK2RLZWtm?=
 =?utf-8?B?WXMwSHI1bi9pNWd4cDFHdUNCTDd0VElvZ0ZaOG1ISjdYUzA3Tld6S1BWdUZo?=
 =?utf-8?B?TTNJNE9iNXl6RHlUU0dUd0xpZkh0ZnNFZlFFVW5ic0Fyd2R1eUxhSWRTNVdp?=
 =?utf-8?B?SnBwUTlqbENKaGVkRUhra2JXeUVlTFM4MEY2S2JnOEQ1Q0RDWDRxdTB4dGRL?=
 =?utf-8?B?d1lDdGxEY1plTkVacWlvcTJTVzNkWlkySE9SWmJWSk9FVlIzWVNxQzF2ek92?=
 =?utf-8?B?Mks0dDc5OUp1K3QxZGtBdC9rN29FWXdNd0VDenlVbDN3YjlEZ3ExTUREZEl2?=
 =?utf-8?B?T3JrZFV3R0RTbWd4YTdvdmtjOENJK2NvL1lXY01XVHNPM0JhbmlwNXdnSHNQ?=
 =?utf-8?B?djFPeE9nRE1ZTnpSY3FtVDJnaEQyTHNJeHJJUlVYUS93MkRlVjE4ZmtDWHVI?=
 =?utf-8?B?MnVhU2YyRlBvYnJoeVdycmJOZjU2dGpWVlJwaUpBSXpTRFN0NklNOUdwaHls?=
 =?utf-8?B?WEJKZWhwaDhaMFErRENZNUtIc1pzY3AwWjhnL3BoS01hWEpoSnR1V2lCS0p4?=
 =?utf-8?B?SThLMnY3d050cFZSVGErTkZWNm04T0dzM0IyL09UZXR6cG50azlBOEg0S3N6?=
 =?utf-8?B?SEJERks2QVNXRngzMnI4VFB2a3FuZHk5M1R5NmxZeXdqQk0ySTVzeWpCc1RD?=
 =?utf-8?B?NW1QaWszbW5KRDhROGNicUV3OFNsU09QQ0h4ZWdVUGh5NVkzMWd3SnpQWTRX?=
 =?utf-8?B?QnJlc2oyMUJ5aHRWbWdUUUg5eDNSejhJemFpM2xsd0F4T1RQcWp4ZDB0dTVr?=
 =?utf-8?B?bDVySUpoNHNHTTRPY2U0RzVzdmVFRlVoa1UzRnFSSEdOYjl4NjEzYzNEd0pN?=
 =?utf-8?B?bDFuT3lneTFWbjAzNmI2QkdCZ08xM0lydWY2Q3Bva1FTR1M1ZUkrOURiY1hR?=
 =?utf-8?B?bWNxWXN0UnNEVTJlWEh1TzlqcS8yRlRwQ1lBNW9zZ2IwTTV5QWhtTEJ0b1ds?=
 =?utf-8?B?K3ZCR0c5UU1sMUhKaEFoT09IRkdqRTZMZi93U1JrQUp5cDF4Q2lvdzVCcFZK?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 54707a4c-ce60-4fab-09da-08dd40877767
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:07:52.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d+z9M44+Wv9C7WkO8J+x8Z6hUbVK7tHOH5H5w4Ce1vmVBpw/V2h1WnSLsDC3fFtgTiEDj3w+0JTgNffXOXKVn6XXJwwqoYr7D/nu4Agv8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3605

On 29.01.25 2:58 PM, Lukasz Majewski wrote:
> Hi Frieder,
> 
>> Hi Lukasz,
>>
>> On 29.01.25 12:17 PM, Lukasz Majewski wrote:
>>> Hi Frieder,
>>>   
>>>> On 29.01.25 8:24 AM, Frieder Schrempf wrote:  
>>>>> Hi Andrew,
>>>>>
>>>>> On 28.01.25 6:51 PM, Andrew Lunn wrote:    
>>>>>> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf
>>>>>> wrote:    
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm trying out HSR support on KSZ9477 with v6.12. My setup looks
>>>>>>> like this:
>>>>>>>
>>>>>>> +-------------+         +-------------+
>>>>>>> |             |         |             |
>>>>>>> |   Node A    |         |   Node D    |
>>>>>>> |             |         |             |
>>>>>>> |             |         |             |
>>>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>>>>>> +--+-------+--+         +--+------+---+
>>>>>>>    |       |               |      |
>>>>>>>    |       +---------------+      |
>>>>>>>    |                              |
>>>>>>>    |       +---------------+      |
>>>>>>>    |       |               |      |
>>>>>>> +--+-------+--+         +--+------+---+
>>>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>>>>>> |             |         |             |
>>>>>>> |             |         |             |
>>>>>>> |   Node B    |         |   Node C    |
>>>>>>> |             |         |             |
>>>>>>> +-------------+         +-------------+
>>>>>>>
>>>>>>> On each device the LAN1 and LAN2 are added as HSR slaves. Then I
>>>>>>> try to do ping tests between each of the HSR interfaces.
>>>>>>>
>>>>>>> The result is that I can reach the neighboring nodes just fine,
>>>>>>> but I can't reach the remote node that needs packages to be
>>>>>>> forwarded through the other nodes. For example I can't ping from
>>>>>>> node A to C.
>>>>>>>
>>>>>>> I've tried to disable HW offloading in the driver and then
>>>>>>> everything starts working.
>>>>>>>
>>>>>>> Is this a problem with HW offloading in the KSZ driver, or am I
>>>>>>> missing something essential?    
>>>
>>> Thanks for looking and testing such large scale setup.
>>>   
>>>>>>
>>>>>> How are IP addresses configured? I assume you have a bridge, LAN1
>>>>>> and LAN2 are members of the bridge, and the IP address is on the
>>>>>> bridge interface?    
>>>>>
>>>>> I have a HSR interface on each node that covers LAN1 and LAN2 as
>>>>> slaves and the IP addresses are on those HSR interfaces. For node
>>>>> A:
>>>>>
>>>>> ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision
>>>>> 45 version 1
>>>>> ip addr add 172.20.1.1/24 dev hsr
>>>>>
>>>>> The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24
>>>>> and 172.20.1.4/24 respectively.
>>>>>
>>>>> Then on node A, I'm doing:
>>>>>
>>>>> ping 172.20.1.2 # neighboring node B works
>>>>> ping 172.20.1.4 # neighboring node D works
>>>>> ping 172.20.1.3 # remote node C works only if I disable
>>>>> offloading    
>>>>
>>>> BTW, it's enough to disable the offloading of the forwarding for
>>>> HSR frames to make it work.
>>>>
>>>> --- a/drivers/net/dsa/microchip/ksz9477.c
>>>> +++ b/drivers/net/dsa/microchip/ksz9477.c
>>>> @@ -1267,7 +1267,7 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device
>>>> *dev, int port, u32 val)
>>>>   * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as
>>>> HSR frames
>>>>   * can be forwarded in the switch fabric between HSR ports.
>>>>   */
>>>> -#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
>>>> NETIF_F_HW_HSR_FWD)
>>>> +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
>>>>
>>>>  void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
>>>> net_device *hsr)
>>>>  {
>>>> @@ -1279,16 +1279,6 @@ void ksz9477_hsr_join(struct dsa_switch *ds,
>>>> int port, struct net_device *hsr)
>>>>         /* Program which port(s) shall support HSR */
>>>>         ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
>>>>
>>>> -       /* Forward frames between HSR ports (i.e. bridge together
>>>> HSR ports) */
>>>> -       if (dev->hsr_ports) {
>>>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
>>>> -                       hsr_ports |= BIT(hsr_dp->index);
>>>> -
>>>> -               hsr_ports |= BIT(dsa_upstream_port(ds, port));
>>>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
>>>> -                       ksz9477_cfg_port_member(dev, hsr_dp->index,
>>>> hsr_ports);
>>>> -       }
>>>> -
>>>>         if (!dev->hsr_ports) {
>>>>                 /* Enable discarding of received HSR frames */
>>>>                 ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);  
>>>
>>> This means that KSZ9477 forwarding is dropping frames when HW
>>> acceleration is used (for non "neighbour" nodes).
>>>
>>> On my setup I only had 2 KSZ9477 devel boards.
>>>
>>> And as you wrote - the SW based one works, so extending
>>> https://elixir.bootlin.com/linux/v6.12-rc2/source/tools/testing/selftests/net/hsr
>>>
>>> would not help in this case.  
>>
>> I see. With two boards you can't test the accelerated forwarding. So
>> how did you test the forwarding at all? Or are you telling me, that
>> this was added to the driver without prior testing (which seems a bit
>> bold and unusual)?
> 
> The packet forwarding is for generating two frames copies on two HSR
> coupled ports on a single KSZ9477:

Isn't that what duplication aka NETIF_F_HW_HSR_DUP is for?

> 
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ApplicationNotes/ApplicationNotes/AN3474-KSZ9477-High-Availability-Seamless-Redundancy-Application-Note-00003474A.pdf
> 
> The KSZ9477 chip also supports RX packet duplication removal, but
> cannot guarantee 100% success (so as a fallback it is done in SW).
> 
> The infrastructure from:
> https://elixir.bootlin.com/linux/v6.13/source/tools/testing/selftests/net/hsr/hsr_redbox.sh#L50
> 
> is enough to test HW accelerated forwarding (of KSZ9477) from NS1 and
> NS2.

I'm not really sure if I get it. In this setup NS1 and NS2 are connected
via HSR link (two physical links). On one side packets are sent
duplicated on both physical ports. On the receiving side the duplication
is removed and one packet is forwarded to the CPU.

Where is forwarding involved here? Isn't forwarding only for cases with
one intermediate node between the sending and receiving node?

> 
>>
>> Anyway, do you have any suggestions for debugging this? Unfortunately
>> I know almost nothing about this topic. But I can offer to test on my
>> setup, at least for now. I don't know how long I will still have
>> access to the hardware.
> 
> For some reason only frames to neighbours are delivered.
> 
> So those are removed at some point (either in KSZ9477 HW or in HSR
> driver itself).
> 
> Do you have some dumps from tshark/wireshark to share?
> 
>>
>> If we can't find a proper solution in the long run, I will probably
>> send a patch to disable the accelerated forwarding to at least make
>> HSR work by default.
> 
> As I've noted above - the HW accelerated forwarding is in the KSZ9477
> chip.

Yeah, but if the HW accelerated forwarding doesn't work it would be
better to use no acceleration and have it work in SW at least by
default, right?

> 
> The code which you uncomment, is following what I've understood from
> the standard (and maybe the bug is somewhere there).

Ok, thanks for explaining. I will see if I can find some time to gather
some more information on the problem.

