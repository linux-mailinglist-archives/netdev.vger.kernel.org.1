Return-Path: <netdev+bounces-104602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C390D8C2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509C0284C61
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741113D8BC;
	Tue, 18 Jun 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q1T77RF7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7113BC30
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727094; cv=fail; b=CoCaU7YvCfbQV545xt4KOh2TUa9mAhnyuY22AinkTeAL9mHeigQ/PKiP9jj8zFiCrntVLm1BZtfsakfnFLxrit45XfiMRLcmEgkV2cXoJQ7Ord2NqFHVBXYyRWt/9HGx7/+FSpdRoVi7ezarhAynbYa/pfjYTsSN2SKsqaZmDsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727094; c=relaxed/simple;
	bh=DlF6UL/B1dwMMSy7Bf/BDkQOltEdXxeQ/1ZA5umFAsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z80DcGTU/f/gv8XNjIComJxhVs4lTcHEUiqVG8HsviMpmCZu1ekZWuOhCaBFyBYfV182AbnD43580vPIvAL7YbnLXMeHqRJdTXEWQfuKGHfWnaiulqEv6CXXKKyGDnIjEYfvRN+2grguaUjTHHUvhIgLDcrh3KPcSHHBSUdPKOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q1T77RF7; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAoQCpRo0/v0QfWN/UqsVA668llL9N8q+6pA0Ure/ZjWM9wg3PNKr+BLS06o5lHRNes533fAczsV10+MwvAj4nfatGZicAsI49goIgNJOwpai4xlgq2MLtrUgIFVR3oJczhEfVB2c9tKLP9wmeR/oY5IixyHN/ANmGuNRrr+wFcwW2VICzwXa9KA9SkmM6kUSAda9xxmoXmB3ZlrLIgJJtTbNvvW8PTpTmTBW4ai/xTnjVxWKOd61+6x+tmjmijWOTkBvC0Zfy66Bp10Pq0953bAvGYoGAhFrpH6zJ4Kt+xtcPW4XIOdOthFeDM02G2Oot7CNdiEG+7zAIYa4h4OYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dekKcIJa/3Yo8fKyfJ44sjGenWqjVxr1DjQTaS/lt+E=;
 b=XDBJ6NJ9sQdy9fqBrAp7YZg/ZfLc48DjnqZQn0+hJj845gAZJpFw+bK6U6KZMFqGWKAkZv0QdzlS3gO7QuKYtc2Z1FsJHICOA4C8jYK881xavCPqndO5w/NFv/GHKMm9rqZfkMV5Ji89HYplVzpLAE+b1zg9urKX1gTl+Qe4WwB14fOqnlV9UxCMOP5pi2wrsbj6HTONWZAxSXPu38DlL7MenYGZB6u2tmEO22FVmlaJFyHEjsIaV2lEzrW+K8HY81sXiV9cg70MYjngyf01U9LqVO0OHamxSpsEo4E/0UPP4ejIKvN9cxvq2p5zwAO37t6I8Aya5rtNKBfjhO1J5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dekKcIJa/3Yo8fKyfJ44sjGenWqjVxr1DjQTaS/lt+E=;
 b=q1T77RF7zBuMgFwMHv9/ytNpqsXhufcPAYWqHoY9/ACJNfhsc8ssOZWtS9jZlsoBJNlVUli9bEcNc6UUhYVRRQXl19b0BrBfbF+X+eUxyJVYAnBn3eJbTjlw/pXXoA0sq8/wbUktbW7/3+Ah7zIFR3CUei9GPjEZgNYJu48fvSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 16:11:29 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 16:11:29 +0000
Message-ID: <2d6e088f-f9aa-45f0-8c89-1db9700d6692@amd.com>
Date: Tue, 18 Jun 2024 09:11:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
To: David Laight <David.Laight@ACULAB.COM>,
 'Shannon Nelson' <shannon.nelson@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "brett.creeley@amd.com" <brett.creeley@amd.com>,
 "drivers@pensando.io" <drivers@pensando.io>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-8-shannon.nelson@amd.com>
 <1cfefa13c8f34ccca322639a05122d6d@AcuMS.aculab.com>
 <64876a57-9ac4-4725-8af3-67944ba6ea95@amd.com>
 <0cdbc7079c5640ad9cfd2ea8a36eb54c@AcuMS.aculab.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <0cdbc7079c5640ad9cfd2ea8a36eb54c@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c972490-0c6d-4164-9a50-08dc8fb14fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUUzbHo5ZW1YVkpJU0c1bEJyZDRsUkhXRjAvRzg2eHZLK3U2TGlmclpLNjlX?=
 =?utf-8?B?K01sMFM2QXdHdzdVdHpjVHVpUnlaN3JNY1MxS0srTGFxZW9BMlM5UVYzak5X?=
 =?utf-8?B?L3VLZFJ3UXJPaFJNUWlPY3htWUtQdEo5citEdkUydTRVL2ZiQ0g2KzN3Ulhv?=
 =?utf-8?B?ZXZES2J4WmZsWVp6dG9pL0c4ZnppblVFMWNmNHN3YnBlYUxyRmt0WHEzNko4?=
 =?utf-8?B?R3ZXUGtxekppK25NOHhtbTU3S0IwbnE3bWwxUVZzZTNtdjQvZEF6dm9OY1JQ?=
 =?utf-8?B?TVBjVzMvK2RLYlMzS0JCOVVVVWsrZzhMRzBiUzROS2htSEFHVzNCWmx4Tktw?=
 =?utf-8?B?NUxpcS9UYXROYlphdE1BdzBIVU1rRGF4dDdlRzllMURMbllUVWx5NFE1aFVw?=
 =?utf-8?B?aDgzTTlnbHE5bmNyclEvalJVTHJwcDRMV0hwZzJpeTVvM1lHamxNbXI1OGl1?=
 =?utf-8?B?OE5vYXVGWVVNdllDcXNLSDB4a2VkTnpwYXBGSHBzUG4yYU1rZExpQVBpS3o4?=
 =?utf-8?B?cWxNMk8rSXBmZFlLTXkvSDhoRzJTb0d6V2VqeFpPaURNbWpDdlJzcFhPUTRx?=
 =?utf-8?B?Zm9EdUZna2xFYS8wRGdYRWpaMWZkd214UTRtSGlFajlmVTVPNjl2MXlUbEg5?=
 =?utf-8?B?Y1NJN0JYY1VWczk3NWZSbUJCM2JKRysyOTlRZkVaeG5STWZtSDZTTDc0Z1E4?=
 =?utf-8?B?c3I5YjFLRm9tNnF4UGdpLzZhK1QvSGhYNUdNR3ppSWV6Z0FreEpEelJFZHhY?=
 =?utf-8?B?YkUxaG95YmtvcUd1MUM3YTRVUFhqei8wYk9BbThDMlhLbDVUN3NhY2kvamxl?=
 =?utf-8?B?M1Z3Y2k5T0NPV1NCYXVvMTVkZDB0dTBWL3hPMWtTN3N2YWtheGxEUVhiVHA1?=
 =?utf-8?B?UDVSWW1vVTQzQ1QveDF1WHdKNTdKN1IxZFI4SFRzK0tKUjlNbEVvT3ZvQndM?=
 =?utf-8?B?OXNVbjlPbDB4QkhxTXVxZTRER2VXRGVGQmovRXQ0a1FSUHJvUVR4VmFJYkNP?=
 =?utf-8?B?NVM0R0FscU1MMjMrZ25NZnhXNjhKeWMvN1pMYTBRNXVZNVlMcjlVY3BIRE93?=
 =?utf-8?B?MlpoQ0VRKzFtZ1FPMzMyUzhiTmtWYUJkdmVnN29KZ2ZJUlhmVHZINUJ2b0la?=
 =?utf-8?B?MkExV3FMOVZyK09uUERHTTJXU1gwV1NHek5rcHdhOTluMExRUklQUjFZWGNH?=
 =?utf-8?B?MXA1RER0WmdzazdaZXVDc1piaUhwci9VS0VCcEl1bkRVNDNhbTlEWjNFL2FR?=
 =?utf-8?B?RThqVjByUTQ4alhoamdUT2NYK25oZWtvQmlLUklXYkVhUUhHUHExUm00NWRT?=
 =?utf-8?B?QkhuR1RUS01UODNZRDJnWWlPcG9hODZWT1Z2b0UzKzdHZzREa2JkdjhNSitS?=
 =?utf-8?B?ZUE0RG1sYnh5dGd3dHU0b2dMYVp2WmlNUjdIbnd5SFZIaENzVWM4dlNUdE1K?=
 =?utf-8?B?SDRHZ21hWEoyRldudWZEOVVGRXlhd3Z5eGIrN0lHWkxSNFVVdGJSSmxtMWwz?=
 =?utf-8?B?ZDM4VE1lZTlHMFhmRDA2TmN5YzFvZ0l3b0lhRTZrR2I3TW1NekdnaEZsbUwz?=
 =?utf-8?B?bitKVGZQU3hISkYxN2FOYW0zS0g4aW5jejFVYVJPWVN0MGE2aEVHelZSWHRN?=
 =?utf-8?B?aS9DVkhZekZ1V2ZvTnhQcEthTVp2dE05a1JpdEt0RmpkSCtJdE81clczTnVo?=
 =?utf-8?B?SkJGcE5ZNEJPSm5QYkh1d3pIRCs3RStDRXhkWTRqd1RoNmhPaGpEZkxVY3pv?=
 =?utf-8?Q?ql6Wuxj2Iqu4nKro9E5kKrn5bA/U1kCAzjc3THu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzRQN285ZHU2TC9UMjJyU05PTWU0ZUNyejFWdFYzNEUwNGRCSS93VHBlZExM?=
 =?utf-8?B?ckU1eTdFK1U5YlFvcXRDODJGMWJmT24xQ0xSUk9tdjlNMGZTZm5LaHF4SENa?=
 =?utf-8?B?TVlxR0R5OVBmWU00RkJodmdkM09oNW9xRXRiQmJHRDFFMTVndThFeDF2WHR6?=
 =?utf-8?B?eG1Ndmo2R1MyblpHU0dOK3ZUMWNjRXR5Q2VwaCtoUmZKUWJTUHNlL2UwRHdF?=
 =?utf-8?B?alF3cVh4eDdHaCtwQUtvQ0RLOVNKZFlkTmhwME5BcEZMZmM3dkZrOWNTS2No?=
 =?utf-8?B?Q08zQlB0eWg4U1Q2RXQ5TzVjcWRBRDJ2ZlhXWkE5WE1kTE9sdFIwcWx3WlZm?=
 =?utf-8?B?OVlWakV2WDlIeWJqVUlRcXRaRktheEE0cjJEM0c2bDVVMUV2TzMwZlFUTDNF?=
 =?utf-8?B?R1BsNmdvckJUWnI5djBQWmx6eXBlQXhqLy9ZRFRlbjlrcGR3L0dRY1gzbXIx?=
 =?utf-8?B?dUkycEcycGo3b2s2bU5mdzB5a1dlNUdRRGlEMnBaVzhBNitzQ1JGSVE5Q0xC?=
 =?utf-8?B?eUdvSm9URkV6dy9hc2cyVWFZWjNEOTdoQ25RUkJTbnh5NHNRcGFoZURieHc4?=
 =?utf-8?B?aXFmcE5JZHM0bHhxN2RVamdtU2ZKa1BLeWhyRkg1cnBnejlDTk5CaXZJS05m?=
 =?utf-8?B?Z25zUEhSckJ3NXVJUitnSnVMWWhxb1dQN1I1SU5QOFErYWhOYk5PUjhRbFVu?=
 =?utf-8?B?cTNzS2VZajR6dVZRTUVpbHk1OTh3QVNLMGpHOThGdXBqWEE3U0h1RFhTMEpl?=
 =?utf-8?B?QTNncWVESXZGZU5SMTlRdjJYOXBpdG56VWcwc1NabG1mc2g3a21VaUN4UmJN?=
 =?utf-8?B?eWxPaXdpcmFzVE9FMWZZLzdhY3BGVzgycGZKa0s3VTR2OC93MW5WQklMSjFi?=
 =?utf-8?B?M1ZCRDBJb2tKdGxQKzA2T0hCY1B5eE8wTE5LMno0ekdCYnNSd0tEa0oyeVVq?=
 =?utf-8?B?MXJrT0xKbmpRTVVEMi92QURqaVM3aFRXRTYzTVQrMXp3NU44Vkx3bml4eFhm?=
 =?utf-8?B?S1VjejJxWHhOYmZVbU1kNUxFUmlkbGY4bmplNUJzRy92Wms2Y0Q2NUdFeVVO?=
 =?utf-8?B?ZTlIVVRwak5tVXVHSXM0NlNkZExEL1Zvb0FsWlhTWk44bVJKUENDR0RFSEtX?=
 =?utf-8?B?ODBpZU1POE9aaUlrOW5TYWlqRlNXNXFKQU1nTDAxK1U4eXJJZ3dnbGRVREg0?=
 =?utf-8?B?TnBZVklrY29XalBqNzlCTGN0bnI2RnQxRENoSmk2YjdEclJKK2x6UzJRbjVs?=
 =?utf-8?B?SFVyaWhtSTRic0lxS2R0QklRVEFpcDhNcWFYUUJ0ZEwzQi90S2grQzg1NkxQ?=
 =?utf-8?B?SzJYQ3BTT0RHZnczdkVsN3hHd3BmYUtTVG9SQ0pzQnhNczgrMWx4TkJhVjR1?=
 =?utf-8?B?S3AyMk1IanRFU1JwTExtMjFzM0RjZVBOVmVEaVkvSWdLc2poa3ZxUWZnTWtO?=
 =?utf-8?B?M1dNcUdUcUF4T1VyTUhrSFVCTGpENFNSSFkzTGdNaXljbkFoMWw4Yi9FRm9t?=
 =?utf-8?B?YlNlR0lMQnQ5Q1E4eXloM2NBR3huUzh3TmNmM2FnSDVxMWpPb010MTc2Wnk3?=
 =?utf-8?B?V0c1L3FrYTFqNk9pbnRwR2Z2WFdIU3BHNFlPRnJkZSsxNGhpUnR3Q1E1a1Fu?=
 =?utf-8?B?VERCeXFJSUg3cDNmOERGaUhSWEpDVFEzZllNWUp5R1JvalB3NGZKV3gxR3lH?=
 =?utf-8?B?Tlp5RitQLzg3dkFZY2RzYTBrUjloaDZjTHRCSmEvay96d2poRzZBQXlUWGZU?=
 =?utf-8?B?WTBsYjRFZGpTVUhvVXBiWHAvRE9SRi9FdU9LRitUTGJUdFFqeHd1b1hFdTJG?=
 =?utf-8?B?bmQvdGFGQXIrbTNPWlNqZkVTV0x4NzdKWGJ4VlRESi9ENElqNDNaSGdpWVgy?=
 =?utf-8?B?MzlpVVBkbWtld1FmekxGRTZhS3BsZVM4b1FUMDc4L1JLOWMyUTMreE1nMzlo?=
 =?utf-8?B?RlMrOXRMYStZaGVCdW1ZL2ZBUWRxaHNEYzZHai9DTlVhS3FnQ3FxZi9DeDI0?=
 =?utf-8?B?bTgvSm5TZEROQzBRa09qSjJlenhkWWdscTkzbGpuQ0NVZWhncjhzNVNHNVJh?=
 =?utf-8?B?T21oMFFydlE2VjlLbTRxRkxOcm9EQmNRZ0FXQnNsYjBCMjVCajV6cGVsQWk0?=
 =?utf-8?Q?Lz3vred8QzFUsZMLieGtWUSGE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c972490-0c6d-4164-9a50-08dc8fb14fc3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 16:11:29.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRp6W3Y6mR96IGMt7ASTF/lg1fXL8UtymRrVPHLmJm0exGQdMip+jwCn3Zl2TN3+ItozVEatMDy397SU7abKTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849



On 6/18/2024 1:16 AM, David Laight wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Brett Creeley
>> Sent: 17 June 2024 17:25
>>
>> On 6/15/2024 2:20 PM, David Laight wrote:
>>>
>>> From: Shannon Nelson
>>>> Sent: 11 June 2024 00:07
>>>>
>>>> From: Brett Creeley <brett.creeley@amd.com>
>>>>
>>>> To make space for other data members on the first cache line reduce
>>>> rx_copybreak from an u32 to u16.  The max Rx buffer size we support
>>>> is (u16)-1 anyway so this makes sense.
>>>>
>>>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>>>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>>>> ---
>>>>    drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 10 +++++++++-
>>>>    drivers/net/ethernet/pensando/ionic/ionic_lif.h     |  2 +-
>>>>    2 files changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>>>> b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>>>> index 91183965a6b7..26acd82cf6bc 100644
>>>> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>>>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>>>> @@ -872,10 +872,18 @@ static int ionic_set_tunable(struct net_device *dev,
>>>>                              const void *data)
>>>>    {
>>>>         struct ionic_lif *lif = netdev_priv(dev);
>>>> +     u32 rx_copybreak, max_rx_copybreak;
>>>>
>>>>         switch (tuna->id) {
>>>>         case ETHTOOL_RX_COPYBREAK:
>>>> -             lif->rx_copybreak = *(u32 *)data;
>>>> +             rx_copybreak = *(u32 *)data;
>>>> +             max_rx_copybreak = min_t(u32, U16_MAX, IONIC_MAX_BUF_LEN);
>>>
>>> I doubt that needs to be min_t() or that you really need the temporary.
>>
>> IMHO the temporary variable here makes it more readable than comparing
>> directly to the casted/de-referenced opaque data pointer and then
>> assigning to the rx_copybreak member if it's a valid value.
> ...
> 
> I was thinking of the temporary for the result of min().

Yeah. I think a #define would be better yet. Thanks for pointing this out.

Brett

> 
>          David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

