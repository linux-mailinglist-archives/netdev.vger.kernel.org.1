Return-Path: <netdev+bounces-99574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4778D5575
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12727283CD4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7C1761B6;
	Thu, 30 May 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gt8j6+x4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EA1761AD;
	Thu, 30 May 2024 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108449; cv=fail; b=UOu/ufJy16Ur5ggQKb10CtWVQpgkHRokL+KEt/R5lVZz0Jrf76nqfsx7MsKOWbh322Zu8u95t34Qv795+Xq4bqNKd+0KDpqmSVihKH/5xn+Y70IYou70emBklegqeBVKa+N1w0xG3y08EABzoJROHfNGLuMo5TdrtagaX3MhlxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108449; c=relaxed/simple;
	bh=5HWWJeZF/A4opi5moOgJleksULuKBvcZp1WqnYo6VgU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmp0tvBZMXDYPcinZWOo/cZxCyk6IbQ8ZwKF7rRxir1ECW6tDr+X/Z5fMureZy8xCBT4ucHl6psFxFcHSDPafZJIvnKaYT+7Uup8BcE1ETcHQUTVVfYyC6iK0oCD7BhGfNrrdtbPUgqb1PigK2v4JdkxOJbTQ97YjzxE+MhpqTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gt8j6+x4; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYguSJvAyLO9ZHv4v4gXzuqB3JGDHyaIeYSiogktfaQaeDAHF0UFYI6wRjFocnQ7YYgfepDpFuKVpUPJsEJef+yckEPQCs+PX06c83yntMYTKheAYPuas/Y3GWY2u/G6PWhhXW4LJxje/7zU1qFM+AR1EA+OV0vVKRpdHKPFHKpNvgs/4nbYoXTEJI8iKB+CkPH56Ciof7sD/PB046tXdPeC+15+y7Tat3NTXrGct4CN6f2mBKBI1yyDhxvzJof5GLawJPBbHQOYyNNS5ksmVyXFdoBde0RvFE8s3xG7NRVClpgWU4cwqkVzVcdpslHtqo6IqN5ZIiYySnZ9MfSQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3suKOkBGaXD/XpajDHiSmFyriQM+/I3l2WPjCcREFs=;
 b=aC80xLiZ8dyIx3qYTryHxyrQL/pNq9aficHNezvm0LcLQBpm81zJFI1eJcIeIX+BuBS6f98JU6SXTf616PB4lY3wff5SUYqUI3chUkQSFqTGTZ9a7DrdkGuJR4P0g81FEMK/hrXkKzS3EUdqW+7/Wy3nx9MjXyHMsLHNHJynJDTwZIflXvkyIgPoxuyCo5hSn4aSrhxq8QzCm8G/y4ofNA58Oi6RYqsY/qduJjcMiTuOCZasal5V1NUtlY7Tzs0NE7fUyC/JLeaTpWnNWLxJPlnFrbQ+QlWPNQoJTme6Pwg0j8p3QsS6SM5DTcJs/r41wgUdX5SOpxWdxVv31+vZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3suKOkBGaXD/XpajDHiSmFyriQM+/I3l2WPjCcREFs=;
 b=gt8j6+x4KLE1QvaXykSoSfeQlm4117AhRwqwE0fmAUC3pj0oMjXQ3v4y1tR7mGGOnOGM5EctFluQ9R3sHX3wcIpc1uk4uJHB/gYtP2CexQPwz/Vui6lXw8fPLVaPXFWi1q8l3Wxz4wZJkpBD3XnWviIrOKJHTcZRJshQhJkFYLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 22:34:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 22:34:04 +0000
Message-ID: <462c0b21-c800-4b9b-bd79-72ecd135ad0f@amd.com>
Date: Thu, 30 May 2024 15:34:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ionic: advertise 52-bit addressing limitation
 for MSI-X
To: David Christensen <drc@linux.ibm.com>,
 Brett Creeley <brett.creeley@amd.com>,
 "supporter:PENSANDO ETHERNET DRIVERS" <drivers@pensando.io>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:PENSANDO ETHERNET DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240530214026.774256-1-drc@linux.ibm.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240530214026.774256-1-drc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb43aec-d9c8-4316-67bf-08dc80f89c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDlsOVd3ODRGalRya2E5QlNUdG0zRW4xVUZrajAzMlFZMHBXUjBIanAyS3V2?=
 =?utf-8?B?dHBxcHBWT2JJbkI4eXVpSmdOVTRCOUx2bS9uZkQvTWliR2JRUjU2QmhjMUtV?=
 =?utf-8?B?ZnpPMTZra2QyRmN5ZWQ2STJiSk12UWtPRURHN1ZIQVMxbU1Hb0c5b2FseVF6?=
 =?utf-8?B?azI1bmtEcXFjdzFUQmErcjNEcjNTZTdTN2w1eE9kaENGQmU1aklHNWlORmxN?=
 =?utf-8?B?YzdEUFkwNk9EdzRnZFZEV1B5aVQ5VDNEZ1AwMmthb0l4bUgrdkppMFZ3UEhX?=
 =?utf-8?B?RFlqMnNRMnBwdURLUHVURWJuRVpEMXV0TnRBc2lqN2RxM0lLN3RQUC9abTZ6?=
 =?utf-8?B?aEQ5OUVSaXZKVHpsNHRyZkw1ZXVyK2J2ZXdIWXovR3JBNlZXNWlkbmY1MVZB?=
 =?utf-8?B?T0M5NXptcG02TEpVZ2RYVUZybE9wQnRMOXpJWndobm9jTThqa3pCN1czN2Fs?=
 =?utf-8?B?RTdjWENpdWlHNzlTY0NSZ2pKQ3BBOWY4RTd5clhjdGhRbFZwVWo4dU1NaU9G?=
 =?utf-8?B?RHRrNVJoTFJwWHQzdDkxcUJpWXYzOVpYTERaejEwTTJFL1pZNUdHTnNPOElk?=
 =?utf-8?B?Tkp2bkNCRjdOT2t6bk1meWV4TVgrN1BSWVZLQ1lsbFo1aFJWZks3SWxya0JM?=
 =?utf-8?B?U3JRRjNOeXhoSDc1RXhLbGVKK09nSDBpV3NCWElwVXQ3b3RWMGMyMDZtdjRH?=
 =?utf-8?B?WjEvcnc4WnFxZ0JVTnRiRU4xbVFsSDJaLzlNTmkrSnlIR3lUeVZNU08wZ0N4?=
 =?utf-8?B?cElDaXcyaDcxZmNDV0w2S05XaWwyeFVRY0dsRUQrcWdwR2o3Zm8vQkxHNnVl?=
 =?utf-8?B?MUFJRk5PeW91aDFEOVVuaVBiZy9KMFgwcEhSWXdNWnJXMUNUNjJ4RXh6ZTBj?=
 =?utf-8?B?Z1owSnZkbUJvUy9taDlwZWNFK1FlWTFtbXcrem1mRDRiN2FCSW1EVFBKSUtZ?=
 =?utf-8?B?YitKeEhPOVMxT2lUTEpoRmNwcStLRUdmT1oza012ampVVjZuYzlIY1M5bGNS?=
 =?utf-8?B?cmJudHcwOHFtaVJ3ZnNvMjRJMVg4dm1MTlY3bDVOSUF6L0Q1RmZVY3hXTjY5?=
 =?utf-8?B?UGZtVVNpOC9pNmd3dCtFTFlSUnEzNStjMkNrc1lJNlpYVzVodzltcXFpTWZW?=
 =?utf-8?B?QzBmY1k0N3pHTytKQXZuWGJBalJnMGh6VjdiNUQwNUtWOFFHWUJod1phZEx3?=
 =?utf-8?B?Z0RLbTAxaG5TZlg3MmxZczZuR1RZU1A1cTRzbVBHWjZhL3BSVFlHQ2hKN2Rk?=
 =?utf-8?B?TUljUVl3eGpVUTFvZVBVVE55Vmw2R1l4bUNpVG44SzcwQUFoWFBxdUcrdXZ0?=
 =?utf-8?B?RWo0MkdEK2JaQzV6QXZVYTVCa0dJdWFFUkNuOGRmMHh6VTkwcE1vUW1ObDM2?=
 =?utf-8?B?OVZhanNQaTh5WEpaYlJaWlhwS0wrTXR4TWJRSFlFbHkvZTRCcml5NUx1eEgx?=
 =?utf-8?B?clJnN25WRmxCMEUxa3ZaRlp6MjNqelhEbDRTTlY2ZTdpaTBGUjJvdnJWMkZt?=
 =?utf-8?B?WkpmOHNRSnZsQnZ4VHpuc3BBL2dXWXZWZU1zTmZUVlZXNUk3WGh2VFp5eFdV?=
 =?utf-8?B?eFU1b1hzM01BUkZDNHlUc2pjZ1FtMlBaVWYyYW01cDJkVzBjREMvc3hFdXhM?=
 =?utf-8?B?YnJTTWVOZzFqVnRCVThMYWREcHRZTXpRUjdEOUMzR1Q2K2N6MXdTZnVHcCs0?=
 =?utf-8?B?SjFWS3RGSTZ6MVNOa2g5RUxOeE91WkZJMjA4YmNhaDUwNGpNbTFtbTBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUdTdklYMldRNXRmckJwdUVpOGQ2OEFORENXdEt6MXpqSVh4cXNWckwwZ3FG?=
 =?utf-8?B?Q3U0L08va2hYWVFoQlRJZVljaWRXcDVUeU9rVFJYZzJWamZONWk0K1o2Q3li?=
 =?utf-8?B?SW9PTzBmZDBtMlcvYlhzSTlGcmxQeEhxdTdHa0NxN1RHeVAxY2VvM3pQU2Yz?=
 =?utf-8?B?ZGk4Y1phTjNsNU9VcSszcjBHekRtUnl2Q21qTEF2N1J6aW0vM3N1Sy9uVlN6?=
 =?utf-8?B?cm1tZGRSQzhpRXRzOUFPRWpwQU5uOWNjejlLVlIyUkRGcXgwa1FOc1NodURj?=
 =?utf-8?B?THkrYlExdHVjbVFqOTJPY3hlV2haYTQ0aWo4MndZU3R1NUVrSDNQMm9wQ1N1?=
 =?utf-8?B?c2Q4MDl4dlJkbzNWU0V0TlZ5WG9kMVh0am92SXlDOHdYdUxXUXFZYno3Vm0v?=
 =?utf-8?B?bzRxdlQyeFMrUUFzaEg2OVdZcWpRYnhzODdBN0UrbnlLTXBqeTBhdDN2UDlD?=
 =?utf-8?B?M0MrZ1gvRkRFTEpWVnRrWXNLUzNrNmFhYWQrQlhxUWpTekhESVgrRzJObGRl?=
 =?utf-8?B?VmpLdVNiWXVlREZWVHVDR3haMTJvZGtKSWhscmJIMGVuZmdKdzYzSkRlV1Jo?=
 =?utf-8?B?blRXcUFXWlJMeDdlVmVETUg1MDVpVVVuWGFQV2J6dDUxUk9qL3hlRndDT1ZR?=
 =?utf-8?B?Mk5RK01Ed1VZTVRtNHlxdDhvdkovbFo2MzR3UTBleTVsenpBcFBDUm1jSEVJ?=
 =?utf-8?B?cW54dnRUVEQydy82Wk5zTmRlRTlwSjNML2diajFrZm1vYS93MCthL1UxTXdI?=
 =?utf-8?B?RnZhS2FmRGVQS1ROZjFUYWQxdytBVkhvZ3FpTDJPNHNBalAzNmZpcU1YWm5y?=
 =?utf-8?B?UktkYzFpcHAwTkRGVS9QMlltTWxFdXFiU0wzbVFsK256T2k0cGUyZlRTbDZn?=
 =?utf-8?B?Wit0ZFZPTklVSzBReVJNaEw4Ymg3ekpMdGIxYkNWUVFOL2NMc0ZPZ0toMEY4?=
 =?utf-8?B?K2VmbkJxQmkwQ0hJZ3RDUVpyNmNLellIUzVmOGtOT2k2OURqSDF2Nkp3UDRZ?=
 =?utf-8?B?aUhlb2IrcGlpZzJ0NDI1Wmc3amNQUnBud2FCajBpcGNOenE1RUEyZ3BlTEp3?=
 =?utf-8?B?ampBRUZ1dlN4dmxGaVJRRzRmSllrTlBnOWhoYjFUUXpQOUZpODczMHBpRkFi?=
 =?utf-8?B?TE5FQkg3V3ZsUGxNa2FCUHNVVFBPSkZMaTd6QVZNY0NZTHZYMk4vdm5RM0Rq?=
 =?utf-8?B?a21QcndydXRYTEl3eEpFamN3Mk1sSnpWckJKV2xGc05HNWRqdFArNERycFc2?=
 =?utf-8?B?ZmVwUlVoZkxxN0xLM1pXVXJzMmZST1lYUXBldDY1VSsvaFJscnBUTDhLTjV2?=
 =?utf-8?B?QkhEZ3V1WmR3YnlYRnhFRVJzVm1pQ2ZUWnF0akVaUlFaL1F3MTQ1aHVsYVpn?=
 =?utf-8?B?a0VUSURNRHFaK1loRTgwOExvRWpmczBWSEhZcVoxOTlxY2duY29peTZjRytv?=
 =?utf-8?B?TWdqZnY4alZJSjV4SFQzRi92Z2FiN0diZmFIRmtqWjZQVEc4UldnV0JxOVcy?=
 =?utf-8?B?U1Z6MnVnRk9TZkJHWXV0M3J2Z3NQVlNhQ0UyeUFsMEVOSzJjQmRnTXBQSVBJ?=
 =?utf-8?B?cktINk9UTGRXdGR4R0lOV2JDUXBYdkdLTitkZkZ1WHhpNU5oVDJRdHJaUFRT?=
 =?utf-8?B?RmRucURNSkR5NDhmemFqRnRETDJJVWdBZzlXZDViVmxaSEhmelR6bEZrcFZH?=
 =?utf-8?B?NDI4cHhxbmJiaDVuT0V5SG13WGZaSC8xUVBvbHNGTHVJRUJ5eVdDNWhUUkt6?=
 =?utf-8?B?RTBWbzh5Wlc0RWFVMEtGTXVEcDBDbkluZFBLWi9EdXF6blUrUzk4OXpqR2FK?=
 =?utf-8?B?SmdKYWVtWmNXWWE5bXYzSE15cUhFR1VMNjFoR2lSSDVQNWZDcGpnd3RpdW1x?=
 =?utf-8?B?Ulp3RTZwRGl6NlBaVTFEdnplbVJUVFc4YWNnK0g3N1JqWmdPUHhGQStvZU42?=
 =?utf-8?B?b2ZBc3ZhckNqdUVxd3lqd2hqTjdmb0dUKzNVZHVwU2dmb3lzOWN4UjhVZ1lI?=
 =?utf-8?B?eERvRWlOcjdBR2MrbXAwR0VIdGVNMmw3MG00VDlMRWlpSHZ6YkRFUXpGOUJq?=
 =?utf-8?B?Qk44VHdLWlFFNHBKTFdMYjBkUWVOa1dNUW12bzBtRWtmL3o0NUFncHByOVNn?=
 =?utf-8?Q?LblxI8c6Uch0QceUkThl4ovhL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb43aec-d9c8-4316-67bf-08dc80f89c1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 22:34:04.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+4kRvlnPaUus+v6LTQDXi8DbsF2IVTTKWV0d+qVTZwRZgor9+WgcEOcuTGkLybLGp1/nhSihXAv82tiN4Sj1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

On 5/30/2024 2:40 PM, David Christensen wrote:
> 
> Current ionic devices only support 52 internal physical address
> lines. This is sufficient for x86_64 systems which have similar
> limitations but does not apply to all other architectures,
> notably IBM POWER (ppc64). To ensure that MSI/MSI-X vectors are
> not set outside the physical address limits of the NIC, set the
> recently added no_64bit_msi value of the pci_dev structure
> during device probe.
> 
> Signed-off-by: David Christensen <drc@linux.ibm.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 6ba8d4aca0a0..1e7f507f461f 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -326,6 +326,10 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>                  goto err_out;
>          }
> 
> +       /* Ensure MSI/MSI-X interrupts lie within addressable physical memory */
> +       if (IONIC_ADDR_LEN < 64)
> +               pdev->no_64bit_msi = 1;
> +

Thanks, David, for the reminder that we have something like this in our 
out-of-tree driver.  I'm far from being a DMA expert, but this seems 
limiting for those architectures that don't need it, and I would have 
thought that setting the dma mask would already be the way of telling 
the system what our limitation was so there wouldn't be this problem. 
(I'm sure someone will point out the error in my thinking...)

Perhaps to solve your problem with less limitation on others we could do 
something like:

#ifdef CONFIG_PPC64
        pdev->no_64bit_msi = 1;
#endif

Thanks,
sln

>          err = ionic_setup_one(ionic);
>          if (err)
>                  goto err_out;
> --
> 2.43.0
> 

