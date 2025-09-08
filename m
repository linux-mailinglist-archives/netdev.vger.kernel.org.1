Return-Path: <netdev+bounces-220893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945CB495FA
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C5A7B0AF6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3B3112DE;
	Mon,  8 Sep 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="51WN6ABh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1C2F7AA9;
	Mon,  8 Sep 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349880; cv=fail; b=bsd+MUZcgHs21aK5MuPNGCqiIOPg+s1bYrFAAyRYiY05CL/d+VmPKTFIbE5TG0ljYIou0JPgFux1wf6rdsSe3ZK1muDGadGSq5cg6vF1dA5AG/UxoG6NiXIcKrpmgMODGS2/BcvEsaHlO9ZAeTKwRTd5B25wwKD4FZoTOlGaajg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349880; c=relaxed/simple;
	bh=jD1uGHi9PQrNHO1/okfLNLJCFXVvmnW/jqryxBHBQ+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D6X/j0H6UVyHnjGB2xmuUd4PJF4voNlIpX5glKquC1s9XOqvjx+zzSpCmCCMHaS8nFjCe7owerfUW8nCAI1HphEzXx7uMUQl+XNAaC0fPuI30N6hXfD0wT66WznGf18L1lF8/waP85OWCjUA3C1Gu4NkvWYWTyLy9gV72lAdw7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=51WN6ABh reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.244.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7yOVIZL2EqwZ3ca3bREtxHwcz4ED/s35uOLQa7Ffhj3B+oW7hifJ+LGbzmxnE3m4slVBI2+2+I4rdvTdsdQXjXNh7ZrRC6NO2ynVtCFR2Tz9koPRlt5hHo4UzVcRytC4+dZMpqLBLPmrzJGYylsLWCPHvg31I0KcO4oH7FNLdlZ+kiwIn2C0JKMvJJVezV3MvTyrvU8SzqwBrJ13awG6kUQd2ldzGylPTz9Hb2nuENGbGJlTa9JcF1yj58Hrea0sgGQtq9gVWP3lzGdxTFZDFFwe4apKkarlXix03btdAg2AosY2vyoj0EZhyVkclc+hMMJnUrnMKfnbKdeTv6dVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wffdnzptUVmWED3au0MmN/Bj3bP6STsdy42HjE7r46I=;
 b=RuEd8dnFWGyTHXSZUl+uo1YJnKGQqnvBO8w5xy+/wJf/ZDaVXRYMcvHH7yioc48B2qMsT89M89pLE5HlwcJW1c+saRO3vvpCUdOO7J8Tfv8e0TN5aGKqoKgL+wWIqqfDIuUrEs0SLI4WGSVJ5ZTVW8U8eAVJ50lQfQJ3KkYg6/VXtwOBZYZ2FWFT6KBdA+ATZbzbeac3OSKZAuDOLxHzwnXAxWV4Khr9BV97fsPfkPNPEZ9K7n3Z1MaCePAw6o8FE6CvyOq3aRIEzlOIlLHqlNszaWwdQQFF4iO45KbbIWYTK7WtJQD/hRFRPY1oa/FzaDvNvJvDgVviv705pVqdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wffdnzptUVmWED3au0MmN/Bj3bP6STsdy42HjE7r46I=;
 b=51WN6ABh/cqvnFySba+XyTMNEeN04z/z0MATCbjDK7YLtYxL2wALGoRPqnCZW83yAbdSD42vkh2N8OerI4djole2xF7GTaxgbf5hKNNfHbA5T5jY67eC+9QkaDufMe5hJBQQn66gqZyuf/SPzbMPFYSrycgEFAsbiWFTd+tbkuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DM8PR01MB7045.prod.exchangelabs.com (2603:10b6:8:1a::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Mon, 8 Sep 2025 16:44:35 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 16:44:35 +0000
Message-ID: <bbe0a7fa-7c7e-4d59-839c-23e8fa55a750@amperemail.onmicrosoft.com>
Date: Mon, 8 Sep 2025 12:44:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: admiyo@os.amperecomputing.com, Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
 <1ec0cb87-463c-4321-a1c7-05f120c607aa@amperemail.onmicrosoft.com>
 <aL70PVhM-UVi5UrS@bogus>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <aL70PVhM-UVi5UrS@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:930:4c::16) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DM8PR01MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 9264f25b-823c-43a4-4478-08ddeef6fe22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnVmSEQ2NTJNbnNPTC9aZmJBTUs4NWhFcEI1N21DM2haYXEvcjM4R1ZsTWtt?=
 =?utf-8?B?dHJFb25uU2xDRzMyTHdsdTBPMnhUR0RBcTVwQnJYVzVZcU1nNXI3UVBZckZG?=
 =?utf-8?B?enh4aHFtNDhSbUhDYlBOR0hmZkFRMWRyNDJydTIrcDU0ZEdsWjE1M0NPd1Jv?=
 =?utf-8?B?YlFGcU1GUXhlNGRqUlFGS1pYUnQvTHlBTTUwdDBzTTJTM2hxb0t5YVhSVFEy?=
 =?utf-8?B?eTRFRnpFMUxlY3FCczdkZ3p3SHBBQitCQjY1STBldUs1QlFrR2lxUzlleGhL?=
 =?utf-8?B?TllXeXdGdXhGQWYrV0ozRzEydmVhNVpHK1F2aEM5MUhHVXpQM1c1ZDdjYURN?=
 =?utf-8?B?MTZFU3pwSjV3cUgzbldhRGE4bkdKQ0Q4bm51QnBqVGp6eFZteXhSc0NuVzM0?=
 =?utf-8?B?anZYQUE1QVhiL2ZYS0tyUE9SYy83U05Qc0Y4WkhiWTR1M3FZN2xZQUZSa0lw?=
 =?utf-8?B?N1VWMjdnb2ZkeUM5YW5pWGpLamgwQjlJRTVHVXNEWkNFbGhQa25teVQvc2NB?=
 =?utf-8?B?ZERFMXB5TFNxb0dtb1BNVEZhRWJ0RVA4d01lNTJ6cWs3NkMrb3RFS1lFdzNp?=
 =?utf-8?B?N21MVm1IUGRaV2Zjdy9hMGY0Q0l5cG5xeXRiQWZYQ0VFSTUxQTFVMThtQ21S?=
 =?utf-8?B?YldHaUJQQVppNlFNMll1RDJuMldHUWtieEJ5Nmp0ck80cjRURit1U09WTytx?=
 =?utf-8?B?Uk10NG1kT084MFA3bDVvOXUrZ1E5OWQvQ0srOVJ6ZVMwSTRvVDgyMWxZeVJH?=
 =?utf-8?B?Q2Y1U2M4ZjdaMmNIcVpPL1NPeFZTOTJpU1NCbjB0K1pjREI1QzhhOWVmLzJC?=
 =?utf-8?B?a0VhN2ZPUlB0WVpxWWtqamRkVUkxRWhrZll6R2VTbk1XQ1o4VW5pQVFVenBk?=
 =?utf-8?B?ZUxqZTlNSDJxL0FMTlBXaVBTT0ltZlQvNHZjZVB1N2JlbHRIV01FSWZoN1FQ?=
 =?utf-8?B?MldQVkZaUjVWc3BHUUNob1FPODhYekZUUzA0T3U5UXJRcEhzdGc0WGo2LzJI?=
 =?utf-8?B?amR0Z21aMVZtSURiSWF1QzZwYWRPR1gxVkJLNlNQZDlkS3hxUDlDckVya29R?=
 =?utf-8?B?SFZhU1FZNzFvYlZmMVhPK2tiSmRlakQzOHlBZUhnWkszYjNQSkUyQy9GY1M0?=
 =?utf-8?B?TmsrbjRkbWlCN3Y5enlQNVFrUCsyM3o1SnkyejBMdldvb0dNd0F2WGdpeEFO?=
 =?utf-8?B?Q3o3bitVbWwyQllGTHllRi9YSVZCajVSSnVaSEhCeE94azhjUDBGc2prbEdn?=
 =?utf-8?B?NWZMUXhCNkdBSG5TMWttVGwrSDNHZ1hWNW1zSU8yTGk3Z3hUWnZHTUExVnlE?=
 =?utf-8?B?YVVMVVhML29yT3J6SVBIZy9pMFpOclJQbUoxWlhvMFVGRk1RUndCcnkxS2ZF?=
 =?utf-8?B?U1Z1UWF1NmVQWnZwdkwyK3lYazRxSi9xV2g4cDNJVE1CUFllM2VDbEFSSlJC?=
 =?utf-8?B?Rm5Gd3NJTFlweldqMjVYRVV6NmNhYWpZOW9ieWMzbW4zbUFVSVFpM2FSVTRC?=
 =?utf-8?B?dUFWb1VhUThGeEtEWHJ6TjdERVErZ2ZSN3lsc0pCZjhQc2x2bEpoZ0gvS0Jh?=
 =?utf-8?B?dlNvQklsSXpqbTNJZW1aM29TSG4rclhkMEt4R1RGWEY2V2Iya0xaWlhzeTlm?=
 =?utf-8?B?bWFHcGpKNUtlTHJhYWlETE5wY2U2bXUzcHNwQjhoaHlEa1R1a09GRFplVE1o?=
 =?utf-8?B?TEZlaUl2alFBbnVjK3ZzSVhuQlQ0QVNPL1F0aUgyM0FsQ3lOTDRGa0tJaVlK?=
 =?utf-8?B?UmxwMnNPZnBSdytrUWFWdUtCbGlEOGl0QmVvcE94dUNkVGhibUlhRmRoRm82?=
 =?utf-8?B?ZU5XbjhnY0V2NUtSM2lFdHBYbVRNbTlvY1B0MFl0TDhQZGNuM2c0b1I1NjNq?=
 =?utf-8?B?NGhSQUQxTlFrYXpVNDljY2FDbkoxQTUydlg4SXl6M3NJMkdtUGZCWFZVWHR6?=
 =?utf-8?Q?MN0jjdh80iI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzhzS3pzSnc5ZVZDekI3T3NNenhKUkZOSFZ0SVFIQnBpNEZ3cnBPV21CMER2?=
 =?utf-8?B?cDFUVXVvWkFZUTNTRU13clhZOXcwc1NBNWtENTFWTzFwdlFzTWZ2MDRYWi93?=
 =?utf-8?B?YmluNGEvNjN5V1pZcTlkdlNkRXlzT3QxWldMV0ZzNjN6eUhNYXRDMDdBR3Q4?=
 =?utf-8?B?cm1LVUY5WllXQlBXTFI4RDBOaUdycVd2b2p6SXFkbWUwK2RpWHRkSE1UL3Ax?=
 =?utf-8?B?MVlnRjVyZWRObm1xZE1RYk5yVENJNTJONHBKSWhKYlBQdDh4TEtDWjVYOVJy?=
 =?utf-8?B?V3lDTjVMTHRiRUY3U3FEQVFEU09wK0RTam9KZXJzbFBUSGdsR2YrN2JSbTN4?=
 =?utf-8?B?b1RyTmJISnVWVXMvNldOcXZoak44QXNQeU9YYkdRM2FKdy9XcmtwZ0JMODBH?=
 =?utf-8?B?enNtQ05FalArZnBBZU1zVFh6RU8xWUlRYk1XanZvU3JDSVE5S0F0Qmw5dGtK?=
 =?utf-8?B?eTJTWVN0UVBCNS9ob2VUaFlVYnpncnA1NFhlNHoydk94aDZ5aWUrR1JwdkU5?=
 =?utf-8?B?MVdWcTlDWk4xdXVzaGtNVzF5ZXN1UlF4UGpCbTA1Q01yMnhUWnQvODFYOHEr?=
 =?utf-8?B?VERWTVdxVThORWFCdXhRb3lmNWlOdHhRejhsSlZmUW5yUlEzcGJBckNWVVh0?=
 =?utf-8?B?U0RZWkJQa2s5eWw0MjIzaEY1c1loUDlyTVNsSExLL283d2NMeitieVY2QldC?=
 =?utf-8?B?eUdYSndVY2JjbEpwRU9DazZlZjE1ZG9FQ2x1b21VdmVHYWhWNXN1SGJkMjZr?=
 =?utf-8?B?RENoV2dMOHdKWE1ucSs5cUFpVmxWem9OeFovWldldTNiYVlXaGVxNDVPRVVL?=
 =?utf-8?B?K2RSVDJORmNqVHpCSkFkeDBCZzRXQzdwNTJWbjZHUUZlSjBUQTE4WkdFUHV2?=
 =?utf-8?B?aVdZam03N1VFVDNwUTF6MjNGaUpmSTJrZFdScXQrTUlHMFdEOExDSEx2Mmt0?=
 =?utf-8?B?SUI5d01IK3p5bStwKzRaZzEwMzFqbnl4RGIrUXV0emR4eW5PamJZK0RJQ1J2?=
 =?utf-8?B?b2FSdjdaV1FVYlU3N3Z3bmVKWFRPRlowZHdzWThLY2pCWktwemNhZkxqTEU3?=
 =?utf-8?B?WDRISEhKcEkvUVVNZmU4UmRVRlVoMnc0TndEcGRYeVZTYkdkdU1EM2lYeDdy?=
 =?utf-8?B?T1Fqc2xLWENYc0w5V2ZXdWtIZzdZWlE1RmFwWGMxTUl5anZQOGJrV28zQ3Nt?=
 =?utf-8?B?aE81dEVyNitEUVNaT3JjNUw3eEg3aUVvcTVSajZYNU04WmIrNTdhYXNzK2hM?=
 =?utf-8?B?dHZibEl3aEVPNHd6UzloVnFWcHNBWFUzVW12c2pWS0ttK1duSGZqVE81TCta?=
 =?utf-8?B?U1dYL0hyU2dUN2JkQjcrZUdwV3ozVVhZaExUOFRwNmZuMEVhOVdWVU9KTmQz?=
 =?utf-8?B?T1h5bktaVDYyOXp3Tkx4QkpEYVVrdS9UdUxBSlNNbXNmclZ2N2FwdkEyb0di?=
 =?utf-8?B?a0JEOHJvMGdxNmxyUktyU0ludVVndkx5SU5Fa0VVd2h0Z1MrYzFOMzlTd3BI?=
 =?utf-8?B?VGZQNTJONjVpbm5iTGxDMG5MK283eVhjVXJ1eDgrR1NCVnV3cjFtbVltbEp6?=
 =?utf-8?B?Vkl1OTBsSUpzZE84OW9qQTNudkhtOFV1Y3ZwcEhQY05QSTV4RXdEY1greWdC?=
 =?utf-8?B?bGdHVkJMS1A2MDB4Y241emxHQ0pjUmdFS0dQZjR0RmtwcmFTc2EyZWpOdE96?=
 =?utf-8?B?N05DcHFiSzRCTVpRY1oxQlExdm1RR3ZGbldxTWlOMGFPUW9yRjNmeTRha2NH?=
 =?utf-8?B?eVcwM2Z0YU9pUmRUUVZTK0Q1cG5PVlp3ZGZkcWVGdFZ1bmh4NHJKMlFxVGFx?=
 =?utf-8?B?UXRLc0M0QThQM0Z0Snd5U1pvYlZ5NmFDbEt5MHdYeWRoeENNTXJ4M3pJbTRo?=
 =?utf-8?B?eWRLMGtuQmNYOVZXMGM5OGZOMW1qUmltc1ZFOTJyU0NTeE91bFliSFhab1Za?=
 =?utf-8?B?V0UvdDM5MHdzU3NpWVZKcnNEZi9OSDFGMnRsZWRDNmJ2c21YeU5HRE1YaDM3?=
 =?utf-8?B?OVc5azY5MXYxbWJaTGVmR2lWVjNtYUpTaU4xMjcza2tUUlpJQzNMTUdrSGNV?=
 =?utf-8?B?MnRRZlJnWnFwVklGamFjcWIwVUVjKzk4aTNuMitDNDEwS2YwNkpaUU8yOHU4?=
 =?utf-8?B?M1ordVp3VFRMQStHUUFPY1VqOEdjWTBscDh4SGpMMFMxaVh2TzE1QnI5cEg2?=
 =?utf-8?B?bHlTc3kwY0FZTG5MNitBc2NtMUhBVzVSTXVveTVVbnIyRUtLZTkrUUF6dzc4?=
 =?utf-8?Q?rbndZFznGLKjxCvHxFDQbqgFBwWCMPXltKIjFWNQ+w=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9264f25b-823c-43a4-4478-08ddeef6fe22
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:44:35.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76JzdfM/F1ouySiP1NrvhXZv4/2IzTt6nQmrHyrHlibpscXeWFhJw7hxJxv0Wd0Ai9I1XzIJ4G0jcH7TWCtL6Eh7zv5LFFmXZK3mZWuTdRNSj9UoaJHC++Ae2+6n9Hu8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7045


On 9/8/25 11:20, Sudeep Holla wrote:
> If you are really interesting to consolidating, then move all the buffer
> management into the core. Just don't introduce things that just work on
> your platform and for your use case. You need move all the drivers to this
> new model of accessing the buffers. Otherwise I see no point as it is just
> another churn but in core mailbox PCC driver instead of a client driver
> using PCC. So, I am not OK with the change as is and needs to be reworked
> or reverted. I need sometime to understand your email and requirements.

This is kindof a large request.  I can start working on getting the 
other drivers to use the common mechanisms, but I do not have a way to 
test most of them, and there are numerous drivers.  I don't like making 
changes that I cannot test myself, but if we can get the other driver 
maintainers to test and review, I am happy to participate.

I know we use the CPPC driver, and I can show how that one would be 
consolidated.

Here is a potential path forward:

1. Revert the current patch, specifically to remove the callback function.

2.  I will post a minimal patch for the change to the mailbox api

3.  I will post patches that modify the other drivers to pass NULL in to 
the send_message path.  These will need to be reviewed and tested by the 
other driver maintainers

4. I will post a revised patch that only performs the buffer management 
for the send path.  This is essential for the MCTP over PCC driver, and 
for anything that wants to follow the PCC spec correctly.  This will 
remove pcc_mchan->manage_writes = false; This path will be triggered by 
passing a non-NULL pointer into the send data path. This is roughly half 
to the current patch.

5.  I will post a revised patch that makes use of the mailbox API 
callback defined in step 2 to allocate the memory used for the read stage.

6.I will repost my MCTP over PCC driver  that makes  use  of the updated 
patches.

Any point after step 3, we can start migrating the drivers to use the 
send mechanism.  After step 5 we can migrate the drivers to use the 
receive mechanism.


A shorter path forward would be:

1.   I will post a minimal patch for the change to the mailbox api

2. I will post a revised PCC Mailbox patch that makes use of the 
callback function, as well as an updated MCTP-PCC driver that makes use 
of that callback.  We deprecate the existing rx_alloc callback in the 
PCC Mailbox driver and ignore it in the PCC Mailbox.

3. Convert the other drivers to use the managed send/receive mechanism.

4.  Remove the flag pcc_mchan->manage_writes

I will stay engaged through the entire process, to include providing 
patches for the updated drivers, testing whatever I have access to, and 
reviewing all code that comes along these paths. I obviously prefer the 
shorter path, as it will allow me to get the MCTP-PCC driver merged. My 
team is going to be writing another, similar Mailbox implementation to 
the PCC mailbox. The more common behavior between the two 
implementations, the less code we will have to vary between drivers that 
make use of the mailboxes.





