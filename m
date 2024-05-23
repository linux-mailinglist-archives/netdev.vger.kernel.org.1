Return-Path: <netdev+bounces-97678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9218B8CCAB0
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 04:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B34C1F2135F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 02:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685563D8E;
	Thu, 23 May 2024 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WmBaZe0c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF8469D
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716430964; cv=fail; b=HMgwcwgYIpjw1LClOQyCIrJBSi4Dn9IzSuRCFy+7T9xx4GtKJMVswQ/BukgFm3i370dF27rXhIzy89L5LrTNTWxMi1ZPKF1XmS82jgzrumYUOPlx9YPKV72WRy0nZfbiKIbqKENcw8kIE4XDQGrFIDKiLwFzNP7JapUQ9QDDkqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716430964; c=relaxed/simple;
	bh=usezEp8DXIeysX5dq/RS5IMagTaYkYD65sYZlpz+9Xc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n5z4kuZ3cR6R+IPufNw+wZ7ESephnxzAIqsvTfr2jaNccGkzKINw1jLhJdVXeb9Xr8LmgHjtOLohYMicozdYWqQM9jdBf//UBYSCc72dDTn4eEcXVCQatRdqzNTlVd0ek3YVmIohELEQejE7/ck+Y6ZubWa+uUFJjszG4Cdqh8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WmBaZe0c; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhl3D2VkAQNi4NfmWHwX+pGEd+h41pEPxjMxM0WYMOdX56M0wYuSjOcIyhdtR9FeaXL2HtEP3YZtB12224Diy5/z2r2mQBXjNGfOQ5IG6tUMjy6BXBdl2g9FFLLJdl4W22a+kNannsJMRSoBXDYzCZrwNL5v8vchC8O1Pe73N+W9MWU/DY/5QHodhudcHYgS/cDH9LH7ixNS5NR5Sp+N+Xu8oYRSBSElEnuZyTPy+M4w7WYUkefJBPSZcV35aRmIcu1GGqmB6i58CJyhdXqQULtkGj48Fn12r77PZTuP6axmTNDaiU8oHng5KBlWu7nMQx8DOcZqotYwImIbAn1d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usezEp8DXIeysX5dq/RS5IMagTaYkYD65sYZlpz+9Xc=;
 b=Awae5qy2KfQCUnmlqPqeQjNRxfuie+CNKZTGrpiUNqXOlEkc01pjIatx3SogREPEFIa+t7eFszp1R25zI5VGL3gjsFbqLfoVOJrir63se6ZmVa16xM/qayr29y7lyB1n7PoEnE2xrfsdIdHOZLsR+qYWcrETyz0reDD2v1LDZOY/4YVphZFegZWa5gBVIg3yhCnBPT2Vm00ogQgT1JGDOYr2IfpTWe+FeffRbiLjuIMKCp9U/3RT+kYvMjW+YFA6yt4OA2PSUwbe+SrePkcygw6/KN+ipov7gt8qongo6z6h2ygPvEYG0utJFE3M6DqyZEQCAfuwpz7RLUPLnK/l8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usezEp8DXIeysX5dq/RS5IMagTaYkYD65sYZlpz+9Xc=;
 b=WmBaZe0czHBzK8ez63k7KHdzSeWRuskSYNw9Gj/Vjd+vIPLpZh4moCJV+TBhha00fWMsui068X0E1/TtIvveBegFlkRecmbl4+pLGARKThNDjm5Me18GcBmt1T8PmVpgKC9ru3UT1fWHRvlzw/H+RoZsUdtcVin+JD+F+nbpzL/8jyOayz36DERowCi6yEdgtny61fFH9xol1YJLej+9h/7An9N9GREtoDLvtFgZaZvr6AxqIeuxN2zkWCqY9vVL/FIx6WVB9XrImHXKarvO70hMZUoRwVvJ3QzqzS3HNWibbeyZq1nLrjjpoCWD02kUKlOby8OKQfd6PGpnmqY9TQ==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 02:22:39 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%6]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 02:22:38 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Topic: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Index:
 AQHapRztf+XVv59L3kGimcbRJBg/jrGU9qgAgAFhhICAABVtAIAJgugAgAMbzACAARmhgA==
Date: Thu, 23 May 2024 02:22:38 +0000
Message-ID: <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
References: <20240513100246.85173-1-jianbol@nvidia.com>
	 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
	 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
	 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
	 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
	 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
In-Reply-To: <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|PH8PR12MB6892:EE_
x-ms-office365-filtering-correlation-id: 7c4b74f6-78b9-435b-5267-08dc7acf3791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDNKZ1Y5aHBpR2xZTFRTQUxLWllhWjFCOUlkdHduNUFhbzNlUGprS0w3NWhm?=
 =?utf-8?B?UkY4cUtVRDdnS2tuMDJpenZKcTlyOUZKQXdzSG5ZUlUrVTVHWSs5WUF2TTMv?=
 =?utf-8?B?TXpBUmVkdEtYYllJYWRQVDY4aUwxcGRpQU9ZKzI4em5ucU1FVWlUdzM4ZTg5?=
 =?utf-8?B?dmthMzBHMlppd1hvc2pyLzVRTmdBSWtDeVdDdnlmZlE0ZHhNbWRoVzh5cE5N?=
 =?utf-8?B?S1VmVkhjMy9mY0JrN3QwbFZkTDlEVjdmVmxrZVcyOG5YZHhtNi9iRmhLMjMz?=
 =?utf-8?B?U29pbHlGSXpLZzcvTVU1RGhvYU04TnVRaGJJd1VKODlZUWJ2eU85RVN5S0V5?=
 =?utf-8?B?Z1RESHdHbkl4VUFMZlpsK0ZJNXgvcHE3MkRmNU5KamRMVGw1eElsN05IWVd6?=
 =?utf-8?B?KzlWUmhYNVc3K0cxL2FKWlBlajd2c1dackNQc0NKeWt1QVpHRitCN05kVVlG?=
 =?utf-8?B?TzdZWTBFRFphdEJYOHppOXV2b01tUnN5YTFJNmJpaEQzWkxNVHdKU3F4T2Fk?=
 =?utf-8?B?N1NkbjVhSHFKV2trR29qejFZN21rb3p5Nk1za1huVkVDR09lWHYxbVNTQS91?=
 =?utf-8?B?NXR1Smp3V3RFMUkrdXA5TUtHdDgyQ2VMN1M5eVV4YmdGYW5RRGRrVFdOWm8z?=
 =?utf-8?B?cEJlZUo4elNJWVY4eEZhR3hjQTQyd21WYXNmOXNoUHNVY2tWc015SFJFbkdV?=
 =?utf-8?B?Z2crNExtaGdMRnFQdkRiZlR3QnhnaCsxd3RTbnk2dmVKbjRXZlp0NHNJNHZI?=
 =?utf-8?B?T2pabnYxUWhWZWZGczByTEZRdFV0M2tqSlBXeXdIMVI1akZKZVV4a0dlSGl5?=
 =?utf-8?B?RlV0b042cTNPMGprcTJiUGlNaWdXUVhQb082UFMzK0NwbU9Lb3dDMEpRZE5i?=
 =?utf-8?B?WFJaQTFrQnB2d3JBRTFaQUtCblZTbTVzcnJvRFZPalQvUHZsbGYxSktxZE1G?=
 =?utf-8?B?RlJYSmRGMDB1dTJncDd3S3c1UUsvNS9DbE50VmZhZWkxOGozTzMrU0FtZTlV?=
 =?utf-8?B?UXpqQXo1U2M5dlhkakpoek1wbWQ1M205ODE0emN4dkFxSzZQa3N5dk5uclNa?=
 =?utf-8?B?dFZDTTQrM3F6alZUa3JENzZwU1ZmSWZNQXUrWlBOYlc0L0xWYm8wYXQ3amdX?=
 =?utf-8?B?alVJVjRyQS9lS3NXenVvYk11WTk0ZWsxSUVCMHJWc1hhQ3RiUzdiMVZpTEFY?=
 =?utf-8?B?N3dXUXh1N1k4aXNHN3Q1SWVQcGIybWpQVVJMTlVPbTQ5RDlDb3Arb3dTYnFP?=
 =?utf-8?B?K0V1S2tTOXUrRGlIeWZaWGxQUlVCZFMwaUlRcnNJdzZ4cldablJ2QXhoVk5C?=
 =?utf-8?B?YkF1K0pjS2Y1Yi9EQTZ6ODExSjNTQjhHNzdVZ0Q3RWdWZ0IxSHZYTm5ZSEJs?=
 =?utf-8?B?VUxISkszSnFPd1IwYWw4UkE4ajFFc0FLa0NOcE5vdHVkVW1LRVVKRm0wUGI1?=
 =?utf-8?B?NUNSeVdpQUNwdUFpbVBsMjdvOXVkN3JHU1U0OTZITlBYVlFydzhHaTBwck52?=
 =?utf-8?B?QWd3UHJIOC9hcWduSm9Cc0JjYVlMVkhWa3FQMENXRlNCQnp3Sm9GaEFzWE9U?=
 =?utf-8?B?YUovSDVEbVVHdllWcjMyc1U0V2tUbUlBMHE2MVBmVmNBV0RvU1M0ZHhNS0Fn?=
 =?utf-8?B?aDVsaDl1czdrc1QwTmE1ZkpNbHFoeVlVVnV6dXFFSEw0QmtMdy9VSHk2cUxq?=
 =?utf-8?B?QXpCR2NLa3dkWmFtRlVkSUJNR2hNK1E4UlRlL0VFQURMY3VQMkQ2Uk1yZThl?=
 =?utf-8?B?WGhjZUxyWnp3aDdCcnBDTDdYMkNIR0tTbjFiRS9HelFVTEdnNXFzcTc4K3Fq?=
 =?utf-8?B?dEpDSlM0dXFVczFScnBUdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K25ycEVJVXFza1Bqa3hhaTkwQ0dzNCtJNVhKdWZxMTFCb3ozc1Rnay95Y1RP?=
 =?utf-8?B?bFFQbkpSZVh3QkxjU0U5ZWtud2U3eExHNURXYStsend5dHBrQVpaWW5ac0ZV?=
 =?utf-8?B?SlBBempjWDNiVElPOGpDTEdxMlZyQ3JlWWI5clk1NzFMWjUrZ0NCNW00K3FX?=
 =?utf-8?B?aStiNG40THpWcExyQVNlT3B0cVl6eXdvdkdqVytOeTZXQnRwODlRSUdtNFNk?=
 =?utf-8?B?WXVhZndNa2FMeU1wOGowRU1MWkRoTkhvMlRYZS9BMWc5OUJ3NGdkODFnZkYv?=
 =?utf-8?B?dTV2dTdyR2cvMXBhNm9seXdFMktBbnIwYldKanRmak1TOVBlOXRGVHMyc2lV?=
 =?utf-8?B?ZDZQWU51MjBrSUwyVDhySERJTjJKZERseGxlYVJzNVZRZThDY2VoME5lWElu?=
 =?utf-8?B?OWp3MXhZYXpsd093WlZTTW1MUjJyMFd2VWxBQ3gvZTdJOWtJK0d0TEY5ejZo?=
 =?utf-8?B?WituYUFkNGc2dXpYc1g0dlV4V3hrMENBdFdSc09FS2lLSDhPUVpudDhCTXZi?=
 =?utf-8?B?R1A4WVR2ZlJlWXBpT3FOUklqNTVsZ2pYcmlxVHNjWmN2Z0JuTzlJaEl0Smlt?=
 =?utf-8?B?RTZVUW1EQUVGQXVETHh1UExGZXcvbUtaL05od2svVDNvYy9nbFE5QzJ5L3pa?=
 =?utf-8?B?N0oxVWhDWVBvRzZnNWgvY0dtTWQ3YmFMTnF5K3k4NTlwZndudmk4QlNwa25p?=
 =?utf-8?B?R0lndUZyaEtHMG9yOWlNYjNRWWNKREhXYjVQQ3hFQWZrcFZsNmxXNHhsTkIz?=
 =?utf-8?B?dVl3UTlOMTZuOUwzcWU5SmF1UHJJU3JJVzJrbXRDNUF1Zm9ZY21nempkQU9n?=
 =?utf-8?B?dWJDa1RvNitkU2N0RFhmbkVaM0NKRUw1WFZuM3IvMTl4NFhNZy81am81dE9i?=
 =?utf-8?B?cE1senl2ZlpKdGhsbUVlaXRFcjc0a2lITGRSQklCUU0rbk12RXhyTllTaXdK?=
 =?utf-8?B?QktHd000N0NwOWxBMjFzNm41WnFKeFRzbW5QYnFOZWhUMWR1Y1dyRmd3TlhB?=
 =?utf-8?B?T0dLV3oreHhyS0sxWkkycVlBZDh0Vmlud0gxT204VHU3WDlJbW1DQWhDUFlI?=
 =?utf-8?B?dkxtMkIrdVp5M3IzWmd6Wmx1ZEEwRFFFSmlhLzJGejgxdWdLUHVsWERvSDU3?=
 =?utf-8?B?aENxYmdxMVF5VzZ5emJVMFl6QURmcm9qYmk5RllXb3Q1dXhLZ1VEdFdmTlZW?=
 =?utf-8?B?bTVzUnhWMWxGM01JOHZ2WXhvcHUxUHhKMEppZVVpei9vRGZSRGF5czdub01J?=
 =?utf-8?B?eUhHR09pVXI4WTZsNURqYmd3UXJRK1VJcFFaTDJvTS92WSt2Wm1OWFppbTdo?=
 =?utf-8?B?dFhxNG04Vmgvc2FPOWZFNkJ5TG5SVHpxOUgrUElMOUlVeUw3S0dhZmNHVG1I?=
 =?utf-8?B?aHhVclM3YVpnQ3A2NEo3VEUwT1Fxa0lrekY3NzlsL0pUbnZxM1YvRUwwUVdG?=
 =?utf-8?B?aGhKNEs0b3QzS3QrZkV1YVJOcHVHN3o4Q2dUZVBkbS9FZTlJeEVnVGdRK1pC?=
 =?utf-8?B?Y2h4MWpGQ2lSSnNqUzNEeitPSlV4dW53SlBIL28vZFR6Y2VVT05iUDJHdEtX?=
 =?utf-8?B?R0RFdmZhbDB0RVlFRU93cnEyZG1GNkozdlNJVGY4SkNjejRnb3VkWUJKeEJO?=
 =?utf-8?B?aFowWTdJNXNZM0hJOEFqU2ZBWWNxeDhid3VmNFVoUEpQYzhvMzVPd01oZG83?=
 =?utf-8?B?cDJXaHRONFpOYWZGbHVsVGtaWkZ4SWlYZWtRNmNCYVBNVE9XbzRKa0x2RjFi?=
 =?utf-8?B?bmdYdytRYTd4YlQzalEzZXF3QXc2L3doenVwV3BrODVkdld1QWFXRWpFSFVY?=
 =?utf-8?B?Rktma3BDekZ3M3pWRkQxZisvNkNIMnBsTXVQakljNjE2cVk3UFR3YTd2QkdI?=
 =?utf-8?B?V1dYa21LY1RnWE1JQlUwL0hUcm9sa2tOZWhRWGh4YnBwUzIrcE5RaDNEU0dD?=
 =?utf-8?B?eXI2SFFsbXBNbFkwc3liSnB5azVNTE8rdDJmc1Bha1Y4dXVpNUNTY1RPM1ZF?=
 =?utf-8?B?UFFsZWNRM2RmYXIzMTRxYkhBMDdlRng2VkZMaTQveHFPdzRPZjREdlJDRmgx?=
 =?utf-8?B?TC9PemNoR095S25hVEFaRDJSSWNkcTcveW1KTlhlQmQweWJNWGxUMFdBMDEz?=
 =?utf-8?Q?HaQJKhroGXgRz1ddkBaFz1cpH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DFCE6BFDFBA4740958BA1BC35FC9472@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4b74f6-78b9-435b-5267-08dc7acf3791
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 02:22:38.8279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUXxA+U+9QwrrJyrNQqv8dUIWt394vclcnbgdldR+5P5VDxZ9LTqnhE08je6yLRM553jKsYfY/FNEJ65Pa7YEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

T24gV2VkLCAyMDI0LTA1LTIyIGF0IDExOjM0ICswMjAwLCBTdGVmZmVuIEtsYXNzZXJ0IHdyb3Rl
Og0KPiBPbiBNb24sIE1heSAyMCwgMjAyNCBhdCAxMDowNjoyNEFNICswMDAwLCBKaWFuYm8gTGl1
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNC0wNS0xNCBhdCAxMDo1MSArMDIwMCwgRXJpYyBEdW1h
emV0IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBNYXkgMTQsIDIwMjQgYXQgOTozN+KAr0FNIEppYW5i
byBMaXUgPGppYW5ib2xAbnZpZGlhLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+
ID4gT24gTW9uLCAyMDI0LTA1LTEzIGF0IDEyOjI5ICswMjAwLCBFcmljIER1bWF6ZXQgd3JvdGU6
DQo+ID4gPiA+ID4gT24gTW9uLCBNYXkgMTMsIDIwMjQgYXQgMTI6MDTigK9QTSBKaWFuYm8gTGl1
IDwNCj4gPiA+ID4gPiBqaWFuYm9sQG52aWRpYS5jb20+DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gLi4uDQo+ID4gPiA+ID4gVGhpcyBhdHRyaWJ1dGlvbiBh
bmQgcGF0Y2ggc2VlbSB3cm9uZy4gQWxzbyB5b3Ugc2hvdWxkIENDDQo+ID4gPiA+ID4gWEZSTQ0K
PiA+ID4gPiA+IG1haW50YWluZXJzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJlZm9yZSBiZWlu
ZyBmcmVlZCBmcm9tIHRjcF9yZWN2bXNnKCkgcGF0aCwgcGFja2V0cyBjYW4gc2l0DQo+ID4gPiA+
ID4gaW4NCj4gPiA+ID4gPiBUQ1ANCj4gPiA+ID4gPiByZWNlaXZlIHF1ZXVlcyBmb3IgYXJiaXRy
YXJ5IGFtb3VudHMgb2YgdGltZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBzZWNwYXRoX3Jlc2V0
KCkgc2hvdWxkIGJlIGNhbGxlZCBtdWNoIGVhcmxpZXIgdGhhbiBpbiB0aGUNCj4gPiA+ID4gPiBj
b2RlDQo+ID4gPiA+ID4geW91DQo+ID4gPiA+ID4gdHJpZWQgdG8gY2hhbmdlLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gWWVzLCB0aGlzIGFsc28gZml4ZWQgdGhlIGlzc3VlIGlmIEkgbW92ZWQgc2VjcGF0
Y2hfcmVzZXQoKQ0KPiA+ID4gPiBiZWZvcmUNCj4gPiA+ID4gdGNwX3Y0X2RvX3JjdigpLg0KPiA+
ID4gPiANCj4gPiA+ID4gLS0tIGEvbmV0L2lwdjQvdGNwX2lwdjQuYw0KPiA+ID4gPiArKysgYi9u
ZXQvaXB2NC90Y3BfaXB2NC5jDQo+ID4gPiA+IEBAIC0yMzE0LDYgKzIzMTQsNyBAQCBpbnQgdGNw
X3Y0X3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB0Y3Bf
djRfZmlsbF9jYihza2IsIGlwaCwgdGgpOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqAgc2tiLT5kZXYgPSBOVUxMOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIHNlY3BhdGhfcmVzZXQo
c2tiKTsNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChzay0+c2tfc3RhdGUg
PT0gVENQX0xJU1RFTikgew0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ID0gdGNwX3Y0X2RvX3Jjdihzaywgc2tiKTsNCj4gPiA+ID4gDQo+ID4gPiA+IERvIHlvdSB3
YW50IG1lIHRvIHNlbmQgdjIsIG9yIHB1c2ggYSBuZXcgb25lIGlmIHlvdSBhZ3JlZSB3aXRoDQo+
ID4gPiA+IHRoaXMNCj4gPiA+ID4gY2hhbmdlPw0KPiA+ID4gDQo+ID4gPiBUaGF0IHdvdWxkIG9u
bHkgY2FyZSBhYm91dCBUQ1AgYW5kIElQdjQuDQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgd2UgbmVl
ZCBhIGZ1bGwgZml4LCBub3QgYSBwYXJ0aWFsIHdvcmsgYXJvdW5kIHRvIGFuDQo+ID4gPiBpbW1l
ZGlhdGUNCj4gPiA+IHByb2JsZW0uDQo+ID4gPiANCj4gPiA+IENhbiB3ZSBoYXZlIHNvbWUgZmVl
ZGJhY2sgZnJvbSBTdGVmZmVuLCBJwqAgd29uZGVyIGlmIHdlIG1pc3NlZA0KPiA+ID4gc29tZXRo
aW5nIHJlYWxseSBvYnZpb3VzLg0KPiA+ID4gDQo+ID4gPiBJdCBpcyBoYXJkIHRvIGJlbGlldmUg
dGhpcyBoYXMgYmVlbiBicm9rZW4gZm9yIHN1Y2jCoCBhIGxvbmcgdGltZS4NCj4gPiANCj4gPiBD
b3VsZCB5b3UgcGxlYXNlIGdpdmUgbWUgc29tZSBzdWdnZXN0aW9ucz8NCj4gPiBTaG91bGQgSSBh
ZGQgbmV3IGZ1bmN0aW9uIHRvIHJlc2V0IGJvdGggY3QgYW5kIHNlY3BhdGgsIGFuZCByZXBsYWNl
DQo+ID4gbmZfcmVzZXRfY3QoKSB3aGVyZSBuZWNlc3Nhcnkgb24gcmVjZWl2ZSBmbG93Pw0KPiAN
Cj4gTWF5YmUgd2Ugc2hvdWxkIGRpcmVjdGx5IHJlbW92ZSB0aGUgZGV2aWNlIGZyb20gdGhlIHhm
cm1fc3RhdGUNCj4gd2hlbiB0aGUgZGVjaWNlIGdvZXMgZG93biwgdGhpcyBzaG91bGQgY2F0Y2gg
YWxsIHRoZSBjYXNlcy4NCj4gDQo+IEkgdGhpbmsgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpcyAo
dW50ZXN0ZWQpIHBhdGNoOg0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC94ZnJtL3hmcm1fc3RhdGUu
YyBiL25ldC94ZnJtL3hmcm1fc3RhdGUuYw0KPiBpbmRleCAwYzMwNjQ3M2E3OWQuLmJhNDAyMjc1
YWI1NyAxMDA2NDQNCj4gLS0tIGEvbmV0L3hmcm0veGZybV9zdGF0ZS5jDQo+ICsrKyBiL25ldC94
ZnJtL3hmcm1fc3RhdGUuYw0KPiBAQCAtODY3LDcgKzg2NywxMSBAQCBpbnQgeGZybV9kZXZfc3Rh
dGVfZmx1c2goc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3QNCj4gbmV0X2RldmljZSAqZGV2LCBib29s
IHRhc2tfdmFsaQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgeGZybV9zdGF0ZV9ob2xkKHgpOw0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91
bmxvY2tfYmgoJm5ldC0NCj4gPnhmcm0ueGZybV9zdGF0ZV9sb2NrKTsNCj4gwqANCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZXJyID0geGZybV9zdGF0ZV9kZWxldGUoeCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9ja19iaCgmeC0+bG9j
ayk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGVyciA9IF9feGZybV9zdGF0ZV9kZWxldGUoeCk7DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhmcm1f
ZGV2X3N0YXRlX2ZyZWUoeCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrX2JoKCZ4LT5sb2NrKTsNCj4g
Kw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgeGZybV9hdWRpdF9zdGF0ZV9kZWxldGUoeCwgZXJyID8gMCA6DQo+IDEsDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0
YXNrX3ZhbGlkKTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhmcm1fc3RhdGVfcHV0KHgpOw0KPiANCj4gVGhlIHNlY3Bh
dGggaXMgc3RpbGwgYXR0YWNoZWQgdG8gYWxsIHNrYnMsIGJ1dCB0aGUgaGFuZyBvbiBkZXZpY2UN
Cj4gdW5yZWdpc3RlciBzaG91bGQgZ28gYXdheS4NCg0KSXQgZGlkbid0IGZpeCB0aGUgaXNzdWUu
IEkgcnVuIHRoZXNlIGNvbW1hbmRzIGJlZm9yZSB1bnJlZ2lzdGVyIG5ldGRldjoNCmlwIHggcyBk
ZWxhbGwNCmlwIHggcCBkZWxhbGwNCmlwIHggcyBmDQppcCB4IHAgZg0KDQo=

