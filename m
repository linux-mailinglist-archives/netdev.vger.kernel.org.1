Return-Path: <netdev+bounces-239150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECDC649B3
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81A214E2410
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8943164D2;
	Mon, 17 Nov 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NshSsteo"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19927602F
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388929; cv=fail; b=jx8uMnL3Xp1OgjleoNJKkxQSRjKNZrFih5HZzlrkvCNKKDqfTxBenN0BeIvdES+U7Z8gusHuRoAm8uN/vSqvoC+yVxDyM68xR9a/dpnwjx1/c0dCJYyKWkWbwZEMYjx0b2Ly0QQh4nfQh19liQ3+pPcQP0Of9HSHExRiQ6lU5lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388929; c=relaxed/simple;
	bh=9Z8HO44irweNWxjFKTdRs6tv8Fwg9YmcQbjwNoFnwCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bsv8UP8zaT33znvefNI+uxR/ip9ekqpvY5g9N1oDaKWe3C0yOu+2NUl8wJvq6EPJwI5PydvhjBHGEMHHumshad4q1K+zxcgYDcMYYWQhOE9N100EnSt8JNQUOHR3Cccle74sL9n9WuCPI0W0xQpHp+Qe+74BSXyVYmVBzVaAXR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NshSsteo; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/rAWI4d07WHk0IXRPJMVi3QycK5It5Ro87dfENnIAGdcwoTAajr6ymaF4k4JwMCnUByzZ9HNveCGUIezjPzRGRbfJD7AVzzAPdhdb9w1JVqDPiu3OiQ1lo6EuI4XqJplaaqBO1Ue3BukHGmT06x8+XWkg05jeKuw3qugXCG77C8TTLaxf2k7xOnVN1ESNTLtimuIXChUndQxUid8iVeOuB4VY1UCzghfhIvKAXrW4I5rf9kgRFV5lll53z9n4gizJcC830oht1GmXNiLMoGVnMQBfoSivJKooa9PMVy3b0jN6EErXRTD644rBZd/C8BBR18J/dzSaj+7zj23Si5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXU0eRZTr8SgoqMXP6qYteCilwIdNsGMQZBUzDJHevw=;
 b=ZSufrqg8gTb8YMN6frDXL1cZKwmHxsN7/v5SupYwI3GD6Y8A81QNYfHZln5Nk9GnEcBKn4Q9NrEJTaUqj28BI1y8FzzrQkrSc5hSomG7at7/mQ6Q8PYgoG0HKrayf3WU45YYlWH1QgvU7oUadjEi/9Y2QtTobFpGLnovY6OyFpvPJZZPmSJYeNDwQ35lg0S84cIdFlK2ZeIDPvMGMhmeUOBcEphoPK9ygcgmXt/Njs04lZqFcr3BpVsfb9luPMiTajvAnf9FO4pIpUdopuYftzvnT4v8QeOMfRq1NqMQWkk3lVHJZUiMnMYzVL1PpGsviI/bn5rdXg+1vL1JZS8/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXU0eRZTr8SgoqMXP6qYteCilwIdNsGMQZBUzDJHevw=;
 b=NshSsteoicGiDUHq3u/antBXtLmYTN+sT0btTHWPDV0+uA4Oq1h0OtNXb8tETmASsZDEf4MBxqHwvz9qGkl/LZe4DISFpPJ6LBsazZzqR5nHElB7ivLHBWLt7z/BrEkZgLYQLJQLuRcr0A55vQM1rrzAQODHRNZU2/Iv7GY6VUekVu6pzEQ7MB7Dmtd9RsUgkf+4Q9JxmTsTU9gROBE41aIcGbigsPGhaf4ThaFnGywk386UU51g1jlIbJjACgyCLWX8gHlwmgYZ5tPYrqqZfNQJ2UB7KpwHfKVF+skwxlH7NM8k7pSfHrh/59h6TL2tDhqoqCNAtfEoE9fzDAHKSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.18; Mon, 17 Nov 2025 14:15:19 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 14:15:18 +0000
Message-ID: <f93df7a6-8211-4f2e-830e-f8020a19ec78@nvidia.com>
Date: Mon, 17 Nov 2025 08:15:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 00/12] virtio_net: Add ethtool flow rules
 support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251112193132.1909-1-danielj@nvidia.com>
 <20251117050228-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251117050228-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:805:f2::31) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 54caa808-e6de-4225-1f5a-08de25e3bc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk44ZC8vLzNNQUR4MmJZZDR3c0l6YjBhS0tWaGxjcjl2K25sUTJUVlc1L2VO?=
 =?utf-8?B?bExVK1E5ejJZc3F4WXB6M3ZDdG5iY2lEcG9nZGJNbDdXcDl5YlREZ2R6dGxj?=
 =?utf-8?B?RXNRNmdqMTc2d1ZvcmdVQWM5cTR3Q2hZTkhCSFhlN0k5UVdvN1dnV1EzR0Zt?=
 =?utf-8?B?OEpqWEFtdC9qQUpITEtOSlNUUHhDbGlCMWROSnc0NDdFMkR5QTErWnorNTRl?=
 =?utf-8?B?OWFiQi9LR1cvc3NnZ3ZxSFJibi9DR1JUdUVGUCtTUHJNUHBHdlgyMWlNR0FK?=
 =?utf-8?B?TCtodTRCOXJpc2RXQjRRRGhoeU0rcStFbmZtZXlwek9uc1RpbUE1Qzd0Q2g0?=
 =?utf-8?B?ZXo3UDZmZWV5VHJ5WnIvU3dodjdYL1lOODV1aStCOE1ZcFY3djVkNXlNdzly?=
 =?utf-8?B?VmN2VThXbVNpSGloaUluR3BzcEZycHNvTmNGbm1hN0QzcW9PRlM0WmpydnN0?=
 =?utf-8?B?dFdOTzViUnZ4eUZXWW40RnJjSGZ4cjJMR3BaalU4ckwyV2JzZXlyeXgwaEhD?=
 =?utf-8?B?dEtLd1R1TFV2ZTRIaWhKSTJUdHJmeDJURXRKeENjQUNrMkZtY3dFQWUwM1oz?=
 =?utf-8?B?Z1ljNW1CTFJya1gwOFozRzFDMzJFYzljQlBpbkt6akJQZDRBN0t6dWlNdlJE?=
 =?utf-8?B?dTZzSEpnQ2QrWGxscFJ0R2haRHd2WVU5RFNzOVU0NVp4c3ZtSkN1bkpSRXJW?=
 =?utf-8?B?bEV2YThjejF6eVR1azVJOUt6Z1FVRDBDYkluSzlZckk0Ym8vU3J1bjhzQ0N1?=
 =?utf-8?B?d0x2dXNTTURKbEFTbEdQMnVKbGtEcisvdmwxb09vWGxPdlRhZ0ZVdDNmVGZt?=
 =?utf-8?B?U1VyQWFVdk1NcGs1SHNDbDdUb3ZDMnVTMXUzbnBZV1ZHeGdOcVQ1WWFwRzJi?=
 =?utf-8?B?aUNlTlF4NmQyLzdOTk10Z241Yml3OUxJNjk4dHd2dGxuamd4NG1yL3FwN3lT?=
 =?utf-8?B?UVhmZXlNVjlYVlVXakprUkYxeFNya21JL05XZEpiN01NTkdmOWNLZmhZZkZs?=
 =?utf-8?B?MlZ2VjBydjB6bDhTMU05TzNHTGMxWHpBODdBU2lhV2o0dkZxQTdycGUraDFD?=
 =?utf-8?B?RmVtakpVc2xDcTJjOURMd2JYR2R0TjRLVUxaNUdrcEtxWS9pWXE4elJCZmhR?=
 =?utf-8?B?bG51UHR2UVArT0o2SXN2aXVMTkdhQ21VNEF4cUlCQmw2OEFyZFRjK2pWVHhV?=
 =?utf-8?B?bHVqcWlKbTl5eW5sSExmTVJDZHJ0ZVZZaDk5TnZjZ2Q3aTZnNW1Bd2xha1Ju?=
 =?utf-8?B?cDlndnc4b0NadWZyQUhvTWJZWm9EZlc1REIyQ0UxL0NwKzlJY1BKOGgxd1Nr?=
 =?utf-8?B?alFiOFE1NWxaN2xnMEx2WHVvT1FJMnZ1Z3NmR0lYSjQxNTVOY3Q0dXVFWnZr?=
 =?utf-8?B?OGxPTC8zdkFaekhWdVljLytrengvODdvVFB6ZUFUbytqSXAxMWZUd2R1NC92?=
 =?utf-8?B?dkhCdlZwSVp0d0wwaitIMkFCMjR5QmFrWWgxazJrWUp4Qmp4RVppWkdlNnBk?=
 =?utf-8?B?WFUyTkZ1clhEMkdmNmFBSngzU3NpandLZ0ZzYXZsdFljM3IwQ1J0S0U2L2dq?=
 =?utf-8?B?M0Q5VFhFY1BtTmM1MUZXMjJMczhWOTVwekplMTBkZXJRVG4zem8rMVBTeUho?=
 =?utf-8?B?cFpSUDVxSEp3cUtGZVJ5akFwbERHNDJVVXp1aHNrZm81QkhqTkdOMDhRQm1u?=
 =?utf-8?B?dHJndzhRa3ZDQitNWkxuZFFxZVlaelc3cWdPZ1J4TWZxSXg0N0IxN3lsendn?=
 =?utf-8?B?NElzUU1SbTM0eUVQL2d2OEhLQ3VSMDAvSkJIaXlTaU1xbDFlbTNqTGdTVWNu?=
 =?utf-8?B?a3BjcnNGOWRyWEJOd3V6U1F5aEtxTlM2WmdTRmNrVnV6SUhoRnlPUXBoRlg3?=
 =?utf-8?B?WkVqS3hFSjZUYTdZM1QwYzVlNnFySXZVeGhFR0RaY0t0aDFCTXRzaHF1Unpa?=
 =?utf-8?Q?1bU1xZd4px1VWTXUusNXBdvDbG82Q8xa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXdISEZTa2YwTTExMjNldWpxM2xCV3M1dnY1UHp0ZVpsVG5XREhzOWFzTnpR?=
 =?utf-8?B?aWtpaTI2ZzhodVV2eUp0YlBwSkp2b0F2VjB1cWR3NE1xdXBHMlEvVkZLNkV0?=
 =?utf-8?B?T29PQS9SNmI0NFcwRVVMaUljbmRkcVo5R1F5Y1V1ZnM5RjZ0dm9sNFNlSTBX?=
 =?utf-8?B?SlV6SVc4YUptVFBGYmlUME9DUXBHVGQxa0pzV1dvTlNWUmIxT29RUURLWWdN?=
 =?utf-8?B?bGs3MTg4aUpxV1l2b3JGU1ZQVlBQNklzNWxxR05LM21LRlRFWXMyMDBQWU1I?=
 =?utf-8?B?NnVQSm1pb3JVOEZ6dy9uRWJqaTlaRitjblBkN3pjTVhVQWpJaFdnOFBUdXdT?=
 =?utf-8?B?MC9SMmxzWTd0S2Y1TDA2QnBleUk5UVppdm1udkV4QTdMaHo5bHVUYjBoNUx1?=
 =?utf-8?B?OG1nNDE4OWMwZnBXdDVuUEQxZWNnbjBWaUFVRitXVFNpblNoakRYc1JVZTI1?=
 =?utf-8?B?N1ZGczhLNlUzSzJQZmFNdm1tSzFBTFlCWkh6czFOT2JCMkkrdkRqeXh0TDlT?=
 =?utf-8?B?cGJxbXVad0tDNlkvalBzUlhuazBOV3BFaVZDS2MyYldMbExFYUMxVnZrbkhX?=
 =?utf-8?B?Vkd4MEVYVjRZL0JwK2dXR0NpeXBQODFUVG1aYm5rYjNBRmF6WW1TNGM2WjRv?=
 =?utf-8?B?eEZmNVl5Wkx4dE1iQlNXZ0RQbjVtNmFRY2Q2V3pXZWxiUUE5SlB3ZUY0ek5p?=
 =?utf-8?B?U0IyMTJReE5CWW9VT2J2bU5qaE1ISHpPNVZQL05TbVpQNCs0VUV4emlKTWpw?=
 =?utf-8?B?YkIwWFB1MGtjalF1SVgzL3dwWC9kUWxaU3crTGdPSGpPY1pkTGtUOGVTOUhs?=
 =?utf-8?B?akpnOGVpNmNDU01KNU10RVlLQSs2TUFoU2ZYVkRRakp3dXJCSEh5UlBFS0hh?=
 =?utf-8?B?TkYxN1E2MU1IbExaR2hSd2RhbTA3SkY3dGs0N1NkZXJ6QTlXMWN6K3hqVWd6?=
 =?utf-8?B?Z0ZzVWQ3OExJR25ieXpzRXFheU01SFo4U013WnVMNXFaRFN3OXZ5SU9wV2Q5?=
 =?utf-8?B?Y21xTkhhZ0pzVVRiVE5OUDVEdm05SHJCNTc1aHNNSlpzMDRSTjh6SFRZS2Ri?=
 =?utf-8?B?OXdlRHhpaTNJKzk2TDRTTEZtQjdTaFgwTHVaQlpUdkxkeWJQSlNVMUM2L1dH?=
 =?utf-8?B?RzlwZFlmbTZsbmFJdGxjSk1JcUZ2QURQYTZZbnJiMW9ORlFrbWtXZXBDaENy?=
 =?utf-8?B?aW5QNXc5K2FRVDUrVUUzZVdyekpqWFh3MSt6L2w4T3VCQmZhejUvZE1OTnQw?=
 =?utf-8?B?NXdMSnA5ZS9mcCtTVlpYTzNrNDEweHprRXN5YnpyMFROQjB0U0M0b25YR1Rz?=
 =?utf-8?B?UmJsZ200SGtsNi9VSEg5MFRvWkZ1ZTVZbW1CRmN2akViUFU3OHNkNEdJNlVr?=
 =?utf-8?B?VmJWc09ZYXF1ejFDM3UxeW82SVpONzRRaHJzdXYzVCtSSlFZd2VkaENpRFZl?=
 =?utf-8?B?eXVYRW05NlhJV3d4RWhYUjQzTHMxb3lLQmpuajR2TXdGVFRjNmh0b0pibFhE?=
 =?utf-8?B?dUFZQnMyY1VPbFphK20rd2ZtRWMzdFFUeVJua2FzL2NzK1V6TDh4akp0WFJJ?=
 =?utf-8?B?Y2FRL3dPbHRzMnY0NnhVYWg4STRaM0d3QUVlUDN5eHdMME5OMStJZjU2dmMz?=
 =?utf-8?B?dkdVbS82K3d0eEhTbml0cTdqbktsL0k2N2w1Q2FrY2VPWENoUHQ2M3ZTL2pZ?=
 =?utf-8?B?c2xWV0pBWWRFWnhGSnJUTDJrdzRZcEZvYXZNRE01YXlCcU1CVCsvSlIxY0Zr?=
 =?utf-8?B?WVZyUjc1TGE0U3UzSHhEK0hPa1V1WnJ6cnZCRDFGekNuTnlxNDhCZDd1MDJP?=
 =?utf-8?B?TjNoZzRPSXVteCtQcTJtQy9EbUVwS3R0U29FUlZnN2RMZk5JY2FKYXZ6cWVr?=
 =?utf-8?B?dTVLUlFSYjJmcEc0YVNoamUyYzl1NjhGVGVVMW9hQVRQT1dTVWFwZXNxYmc2?=
 =?utf-8?B?OGRXNys4UDEwVGNTZlF0eVRLdlZzaU9pTGwra3ROYStReTBMc3RVQ0RnOWY3?=
 =?utf-8?B?dy9LTFVrK0d0MU1QdWowSDlxcFBjWXJSSkRJY3FkR3RHZUhwR0p1TnR4WEpU?=
 =?utf-8?B?Z1JVVDJJbXp6SGQxVW5kcVBwNmdvMlhhSHAzQUErZTg5OTZ6SWd3d1lva0ZP?=
 =?utf-8?Q?RVE972HEYHx2i1nxeomfj0WG+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54caa808-e6de-4225-1f5a-08de25e3bc86
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 14:15:18.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCTl3fd8CRUmgHKJfMaAzj9tN9EHT+7vMj81tGdifTIzK4ycqPlToRktieOnvBQtroDGPLJQXjJ2sF143v0MAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

On 11/17/25 4:02 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 12, 2025 at 01:31:20PM -0600, Daniel Jurgens wrote:
>> This series implements ethtool flow rules support for virtio_net using the
>> virtio flow filter (FF) specification. The implementation allows users to
>> configure packet filtering rules through ethtool commands, directing
>> packets to specific receive queues, or dropping them based on various
>> header fields.
> 
> Bad threading here Daniel, so tools that rely on threading break.
> 

Hi Michael, I'm not sure what you mean, what could cause it, or how I
can fix it.

The patches were generated with git format-patch, and sent with git
send-email.

