Return-Path: <netdev+bounces-102938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BC290594E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 18:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC73B26BC9
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B31822EB;
	Wed, 12 Jun 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TIDd5Z5f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987391822E9
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211503; cv=fail; b=jwrieQWThAYYUJezHKYb0oFSCM6JqwjgXL8pgnOYPwvR+15BfI8Pb1wGG+GWDeGkVihEEYbOW/f4/+xfaKNtuDsC2zRE+/vRJmMweQr15e0x3RaLYv4sIBhQtzR0OmguiR+lI7TL0T/KYK/u2LTlcmXKgFDFC6LsW2YP7IyHWqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211503; c=relaxed/simple;
	bh=yVBvpC/EFsEpHzXaH6XSI482OsH7UBEKNisu+O4sgMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s3NbRAZXeMUZsbTgtAWYBQXeupws0rs9L4iFFIkbNJqXrjA+D6jGRShI10oF3BId1MUuut7I16aGXY2eLtnJ1O8gb1km4Y3KpGUA5pd+89yrU9CbRnzJQABotA5ZY5bRImZ6UQ95aSV7ma6OBX/cqAwIf3GuDLKsCuQMm12lhkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TIDd5Z5f; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrPePeauslAXW4gTHmilFighrh6DovvBQHfWMNWvWxeDeYjI5QCFAjkChoiBbeKP+nXyRe4YhwN3SpJq4TsnWeH+tEfyGVe05gvD/qd/ZIEYDK8/nexjZPhP1F9xQ/P3GAjJiwrisd108SL1XjUNZlrlkupLopbDId8vRxjHAJzXBL+StDDzHMWRkPq6JXLEJu+xiqnsqlCXs1hrbxk1GGamODIK2D16dUq0xysfdwVJiigt9w5nti51g9oY9tqLFLZCNzs2nMpjykN1UqaLrW/kScOVzPNmmPg2APaCy9K6kevCv+Z/fqfW1wqVDlMivUGz8gqoveToyl0Me5k3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06k1QL9KsBjcSIOfBJ3Z2NwXZGdkInJnFMXSh3apvtg=;
 b=Vhfdr3hlzWzBv1zgEgSP14rCk654bkP4BoKFWuzRzeM6j9dALsQjUqanR5TLMVklEm0GkzZGMgQZvvU1UXLmENuw8jczP19xkZrwy8114X6cd0Ku8MkshxJoh3XhyGFn/7qhlh5ApbW+Z+sLyH8Zf57GvakPbZNT5GLr9nzsCHzSadR2Z9LFWS3WJ9QJdkUXyluXj44M4SS/E59a3J4t/osFlobFDNaF4sYReo0ZtdYs4sUlt//LMEotH0Nv1V+boMqIouNioyUdGHfnGGfU7QRjW7mQFQEZwRz+kxZribC7XDJS0hzKOok2LlNpk5jI+9i6DI1h/qJwaIMwLoPAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06k1QL9KsBjcSIOfBJ3Z2NwXZGdkInJnFMXSh3apvtg=;
 b=TIDd5Z5fDVjMmyFwns/lyhzb+LRkrtyUA0SjMi8u6P8VCxRh8ubFzi6d2Xmn0YwdejdXzrdOwibl1KQ+BXO5hnD/zxeAewQTmAZfc60aikRDbb3z97/Rs0xoGxil1r0xMUcrGhphOkuafPaUvWDqbUWmVSIGXLpwQq2E8TOphTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Wed, 12 Jun 2024 16:58:16 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 16:58:16 +0000
Message-ID: <ecc130f8-9dcd-45ab-a9a4-74643353b86e@amd.com>
Date: Wed, 12 Jun 2024 09:58:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ionic: fix use after netif_napi_del()
To: Brett Creeley <bcreeley@amd.com>, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, brett.creeley@amd.com, drivers@pensando.io,
 netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com
References: <20240612060446.1754392-1-ap420073@gmail.com>
 <89643ab3-1950-4493-9993-3dd3d710be45@amd.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <89643ab3-1950-4493-9993-3dd3d710be45@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7a9d62-365b-48e3-72f6-08dc8b00da4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2lDVW9rT1BPdVdNVUlPUHY4aWQ2SC9jMDJXbmRCSUxVYk56SG0rRGpXbUd5?=
 =?utf-8?B?RFJWcUpCQnhKZU5JV2RxY2xUZVJPQW80ZW8vVzREYVZwbGV5TktYTHVxV3Vn?=
 =?utf-8?B?VVd6eEdZcGdvR2RyUnlES3liM2lUOXdCdlZVeGJvT0pKM1cvczR3RGYwQWZI?=
 =?utf-8?B?TlJ1VzB5Q3U2SGIveVZ6bFhxdVN4NjFrK3dVM0hiWDBoYWE2RzZPK2NtMTBD?=
 =?utf-8?B?SkR0ZEJPYm9pTGtVMVcyT0dMVFBueE5WUzM2WjBYYUJoa25zUE0rM1pMRHlW?=
 =?utf-8?B?ZFRDeWlnNmN3Z2dhcTFjM2pUZjA2L0tvY21ycW1kNjgrN295U09xMWljTnhI?=
 =?utf-8?B?dVNxZlQyWnBkWkJTYytuS1J6RXdYWEFBdnIxSjR1bXNOdUxKNzFTSDFUWWpr?=
 =?utf-8?B?NjdtMVBLUTl3elRNREVMQ0haVGZuNUZsektKdHh0QVE0bTBtU2dJTDN1U3JN?=
 =?utf-8?B?Y2krSXEzWlo5RHlCWU4ySWFCVTl0V1ZNSzFrNk9LNXhJQnBRWVlRck45WDNW?=
 =?utf-8?B?dnU1SS9sa1hBNFI3QzU5eXB6b1VhemMzL1hoWFJCQjlFQmFYN1Y0QVI4bE53?=
 =?utf-8?B?UFhHbFpVN1JlVU0vYXA2VkFYZnloNHBYdGlWVnFVSGJVT3M1NDZRaUtRalZM?=
 =?utf-8?B?NVk4c29MT2FKdmtXQmlycEt5a2wzTjdxWXpxRlV2cnJXYXU3VGJ0R0laUEc2?=
 =?utf-8?B?ejRaRHdVbWhjdHZ5Z3ovZG52SlQrTmt2Y2RSMnFrUUQ1M20vTzY4cVNlTUJR?=
 =?utf-8?B?alRCSlJ5UDBuZE5OQ254dmJDWG9nK28rV3kwbkdIS0YyWmpnYmt4QTNYak55?=
 =?utf-8?B?SlRzNnZjNjVSSTJnVUZUbjdhcGwvMkxGT3dXampXUmdoMVBaakZDQUJjVlFw?=
 =?utf-8?B?V2FhckVHOW5MWEtUay9FSCtXbi9sa0loUktsa2tZNkNqU2Vad0EzeTRHY0kv?=
 =?utf-8?B?RHJNYXJDSG0xTjNUUWhCeXJkM0NXQnIzUXdXOXJwTmFLb3MvQy9scEdPUFhr?=
 =?utf-8?B?aVRWVThqZndqbVNhMmZmdndvOGU1QWxGOGZkTXZ1U3BZZXg4ODFnWEkxckZk?=
 =?utf-8?B?NXk3VE5wSHpXOEhYZ0dpbUs5TWZVbGhsdy9QMnEwUzREd3A0TGV4MjR2MXhw?=
 =?utf-8?B?UExQWjBlTjh0cS81cXI4Y21ib0VOY1dWeEFLSTdFM1JSVVR6aVlmMy85dGNF?=
 =?utf-8?B?UWNaR1RFOUFyMjFlc1BJMUo4Q2xLNzlJVlJvMGlyNUc1aUJIbjFGemhvR05K?=
 =?utf-8?B?ZmJpeGY3MkVESVQ4b3BQRUNYS2pRYjRudlIwSVN3ellNUzl6OHg4ak5yWVBI?=
 =?utf-8?B?RG5ncFIwZUVoOWg2dGRSbFBGR2xQeWRCNHBSR0htWFlFcVVDUDNLOUJzQUUw?=
 =?utf-8?B?NUZRNDNnaXVacUxxN09DSHhGNWoyU1hDK2VMVGhLTHFlMjlYK3J2YXZFSEtz?=
 =?utf-8?B?enhGUGVjb1RraHc1OHZXWHZHYUhNOTJEdExWNk04aUNwUXRBaEk2QjJmVjk0?=
 =?utf-8?B?c29lb3JHT2pjTzZ2Ky8rZU8xVGNuZVBUdUYxN0k1aWJ1MnBBanNxd2t1UTFi?=
 =?utf-8?B?WjZNdDNZOWczYUMxQnVvMXZmemt0ekV3N1loMFBqRUZmTkQxM3JmNnFuVTVW?=
 =?utf-8?B?SUdyZkFwWE4wN3BodmZ4QTNTaEJzNytsejFveUE2VVNrR2RCeFBiY05FTHNR?=
 =?utf-8?B?V0RZSFNSRTliWW94ck5CNHFDYldTYjNyVVRyYW9ML0xtRnpxeEFTaVczalEr?=
 =?utf-8?Q?ppi143MuXP83u9R1KsH+/Pe6T0+JxDTI9imVO74?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1h0Z1cxRFFTQVl0emhoK096cE1DcUVZRmhnaVg0bVNDN2V1eFNNRGVzL2ll?=
 =?utf-8?B?YUpBcjRDdXhGNFJzL3E5VW05cUF5SGhIKy9JaGZjbHcxVjY3NlQ3V3NiT3p4?=
 =?utf-8?B?bU1nSmdqRmJPZTRmNmpvMFFsa21sdUY3Wk02MXowcDRDWVdDbUFxNDNJSmhR?=
 =?utf-8?B?MG5tRk5ZMEd5bVQ4OEw2WmdQWkJseStXN2x1Ynh0eW5KcGc3QnZ1MDNsNE5Y?=
 =?utf-8?B?NFc2VHdWRW42aE1PeU50eFYyUVZvVE5jbzhaNFFnQ2dOWTNGR3hEcTJwRnhG?=
 =?utf-8?B?OUQ3UVhnMC9Uam83V2xYUCtKRVZibDFTamkwNnpxMWlDVncwMHFYallkYzdP?=
 =?utf-8?B?dXhXdk1YaTJKTzBYMkpBNmlzUDNqYkhzZWJ3OVlzUW9GV3JhTEFZNkNEd3l1?=
 =?utf-8?B?VGhEVjJaQmZwZ3c1ZURvTU5TbUhaNWVRVEVnYXgwYTY2MGo5NEwrMjM3YlZ4?=
 =?utf-8?B?SlR4WCtlbzF0RU9TUjREODJqb3YyOFdtS2QySmhCR1dJa0o5OFpVTC9ncjNw?=
 =?utf-8?B?VEpjaFVKNFZiUG1vVTM0SFgzS0pXTkdBOGFORzZCU252dDhDVEt4U2tVeERw?=
 =?utf-8?B?azNNRHVkaWI2emIwcDU3eTFodlBuVlcxT3pOQ25EUnBDckpRMnV0TTNUNSta?=
 =?utf-8?B?NTVBNXUzTE92YXJ1c0Y4dERtVkxqZlpyNGQvLzJ0eUNjTTIrRjMyeFZmTnor?=
 =?utf-8?B?cnNyUnRoN2luR0t2QlUxeGhZbFZmYXgrQ1M0VkZEQmhCbTcra0M1OW5CUnZt?=
 =?utf-8?B?bTRpeTY1M0VCTXZlNk9JNGRndjVhcVhLTmlUMjZRdE1XcWk0cXF4aXZhcHR0?=
 =?utf-8?B?U0FicWVtendDdkJGM3FvbVNSZlBZV20yWWZpWkoyQ1JBcnZWNUhXY2tFZDB0?=
 =?utf-8?B?dkgwd0x5cDRoRzBlQ09OL0M4YnZvN2MycFA2NXdSYjIzYmRJUG01ekkrSXZh?=
 =?utf-8?B?TGlpWFVuc0YvVUxHckJTTHIwblkvWDQzdStSb1VhKzFMdWZsa1pzZ29WMXo4?=
 =?utf-8?B?Sjc1NzIrUU5iTGtDWm16OW5LVy8vUlFnZzl6QW5uaXpENnBid0MyQUhSQW5x?=
 =?utf-8?B?Wm1zaTZzWGZEYkZlMlRjK1hGbC93WCsweW1hUlhUam1pK2NTZWJwcmx3MUg2?=
 =?utf-8?B?d1haUDYvRitqa3Vkczd2N24wbUV2d3VvOCtZbFhVNmZ1Sjh1UmdJeHh0Qksz?=
 =?utf-8?B?M1c5eU5oMTRiRTlYR0U5UldIa2FadW12VTFySVovR0ZIYlltckJ0UmRZblZL?=
 =?utf-8?B?TjlDdk4ySm1Udk9rbDVUdTJla2JFOFlBZndPQ3djeWtnWFlsbEg1UVNFbVZU?=
 =?utf-8?B?aFkyWWFGUzBidTNOSlFrbnpQdWVXOHZqZlMycGVTQVJtZ2xHSzZRY1RTbWxW?=
 =?utf-8?B?TWVDSWVGdUd1MFJzMWRtR0o5UktVaXc0S2MvTW9naGtIV0wwTlRWa0Z3STI0?=
 =?utf-8?B?Y0RWQWVmZkFKbzc2LzRSbjVhbkRLb0xZQzIzYnd0bk81ZG16WHo5cWlaZ1VQ?=
 =?utf-8?B?S1gyMlpmZ2J2UEQya0NGOTFVVExLYWU5ZW85WlhTYnl4YVZES0hqUGI3Qkg2?=
 =?utf-8?B?bjA1eFlRTFZEWU1BdlNVSTA2TGlzT0xwV0tXNUprK0ZBSzhGdis0ekdlVEQr?=
 =?utf-8?B?bGVuL1ZDOStqOEhCZkpJYUF4L3FGU2JKNXpaenVtUjFqS2IwVVEwMW5EK3h5?=
 =?utf-8?B?SzVpWlFzekhmaWliL29PSjB6SjlmbVhzazdVQTZ4a3JIZEcwWnRGcXRpVHB5?=
 =?utf-8?B?bExtTVJuMStqQmZyZm4rbE9iRXpnM3NXTTNsNG1LRUd5TXlRbVoxVk4zUmtk?=
 =?utf-8?B?cm50YXM1Q1lDRGlEdnluUEs2V0ZyczVVc0cvVG9wNnd3RXhML2VLeElaSTFU?=
 =?utf-8?B?cGJJclZ1MCtLQ0JGNnBxeVZoOW9kVUxDU0hRKzBIZ3pBUk9vSlFIVkVsMEkx?=
 =?utf-8?B?V2JXY3A0eU1SRDNoekkvL09uZWwvY3o2VXF4TER3Mm5qOGRpSmJCOW5OUDlP?=
 =?utf-8?B?c250TDdKSFlHYkE2d1VrWWEreit1b1B3N1loZWtiUUtCdnI5RW41Zng2VWpw?=
 =?utf-8?B?aERibGkxdEtaQ0hYODlCRnY0QlZhQUlrWU43OVRZTjZxUDRNWnVwZW12VHQw?=
 =?utf-8?Q?1cX6IEnjcUllQLgMTF+pl8V3Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7a9d62-365b-48e3-72f6-08dc8b00da4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 16:58:16.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7wrEJRaU7vNrp92etmVhhqqquKaKxyjYigMzatoEmXSnRZv3q9fkj6y9nfXLQoZLxWH4xdRAxtl50NUvh1Rug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258

On 6/12/2024 8:36 AM, Brett Creeley wrote:
> On 6/11/2024 11:04 PM, Taehee Yoo wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> When queues are started, netif_napi_add() and napi_enable() are called.
>> If there are 4 queues and only 3 queues are used for the current
>> configuration, only 3 queues' napi should be registered and enabled.
>> The ionic_qcq_enable() checks whether the .poll pointer is not NULL for
>> enabling only the using queue' napi. Unused queues' napi will not be
>> registered by netif_napi_add(), so the .poll pointer indicates NULL.
>> But it couldn't distinguish whether the napi was unregistered or not
>> because netif_napi_del() doesn't reset the .poll pointer to NULL.
>> So, ionic_qcq_enable() calls napi_enable() for the queue, which was
>> unregistered by netif_napi_del().
>>
>> Reproducer:
>>     ethtool -L <interface name> rx 1 tx 1 combined 0
>>     ethtool -L <interface name> rx 0 tx 0 combined 1
>>     ethtool -L <interface name> rx 0 tx 0 combined 4
>>
>> Splat looks like:
>> kernel BUG at net/core/dev.c:6666!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 3 PID: 1057 Comm: kworker/3:3 Not tainted 6.10.0-rc2+ #16
>> Workqueue: events ionic_lif_deferred_work [ionic]
>> RIP: 0010:napi_enable+0x3b/0x40
>> Code: 48 89 c2 48 83 e2 f6 80 b9 61 09 00 00 00 74 0d 48 83 bf 60 01 
>> 00 00 00 74 03 80 ce 01 f0 4f
>> RSP: 0018:ffffb6ed83227d48 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffff97560cda0828 RCX: 0000000000000029
>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff97560cda0a28
>> RBP: ffffb6ed83227d50 R08: 0000000000000400 R09: 0000000000000001
>> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
>> R13: ffff97560ce3c1a0 R14: 0000000000000000 R15: ffff975613ba0a20
>> FS:  0000000000000000(0000) GS:ffff975d5f780000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f8f734ee200 CR3: 0000000103e50000 CR4: 00000000007506f0
>> PKRU: 55555554
>> Call Trace:
>>   <TASK>
>>   ? die+0x33/0x90
>>   ? do_trap+0xd9/0x100
>>   ? napi_enable+0x3b/0x40
>>   ? do_error_trap+0x83/0xb0
>>   ? napi_enable+0x3b/0x40
>>   ? napi_enable+0x3b/0x40
>>   ? exc_invalid_op+0x4e/0x70
>>   ? napi_enable+0x3b/0x40
>>   ? asm_exc_invalid_op+0x16/0x20
>>   ? napi_enable+0x3b/0x40
>>   ionic_qcq_enable+0xb7/0x180 [ionic 
>> 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>>   ionic_start_queues+0xc4/0x290 [ionic 
>> 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>>   ionic_link_status_check+0x11c/0x170 [ionic 
>> 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>>   ionic_lif_deferred_work+0x129/0x280 [ionic 
>> 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>>   process_one_work+0x145/0x360
>>   worker_thread+0x2bb/0x3d0
>>   ? __pfx_worker_thread+0x10/0x10
>>   kthread+0xcc/0x100
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x2d/0x50
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1a/0x30
>>
>> Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>> ---
>>   v2:
>>    - Use ionic flag instead of napi flag.
>>
>>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c 
>> b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> index 24870da3f484..1934e9d6d9e4 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> @@ -304,10 +304,8 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
>>          if (ret)
>>                  return ret;
>>
>> -       if (qcq->napi.poll)
>> -               napi_enable(&qcq->napi);
>> -
>>          if (qcq->flags & IONIC_QCQ_F_INTR) {
>> +               napi_enable(&qcq->napi);
> 
> LGTM. Thanks for finding/fixing this!
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>

Yes, thanks.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> 
>>                  irq_set_affinity_hint(qcq->intr.vector,
>>                                        &qcq->intr.affinity_mask);
>>                  ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
>> -- 
>> 2.34.1
>>

