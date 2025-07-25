Return-Path: <netdev+bounces-209978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA1B11A61
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 10:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E9FAC4354
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5625392B;
	Fri, 25 Jul 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1RH+L5ix"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468C2459F8;
	Fri, 25 Jul 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433968; cv=fail; b=JrwuWZi/q/9Rlj65t09EblQz+FY6d6FcaIQ73wM4B5aOlyZScBZ8dF6QHvfJqiGzP3g8mSeARqatTVZq80xB2CstTJdn9DPWJ/SM0Wfri5xlABEaydZwZ0J+18zpf4ZJDQHt/kvO02DuBSTsPm5U9T+eRt8YrRvZJtN5Nh4Re7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433968; c=relaxed/simple;
	bh=q3AxWBRtNBCkwLdIBNoboCQdUcNxZXkaZ6mf54AVbHU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CBTi8jA7DkgYBmTubgAj1TBbgqYrTouU5JHOedVk3KhsZip2/Bcbx+n05TzcAgl+5J6+JGl2WQflWQZ5hsx1KIABzVkMxg5uy1KRxeV+Bb8I4HPY2xKQFts7xXVtFZCVzcvBDWd8BC9OkJg6zarBziAwcawlGLCorK1vWHRc2JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1RH+L5ix; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZvG460eyY38rbaKPU62LKJOH5dg1+k0SIp40FzFtp9osQ5E5mQiMbTErcvsWiMTKSWhvaENhATt4aL8O9hkLQdN+V+6h4PBkEqp1M8eeAcGDPOKaQ8+2rSaBVt2UTwT7v9MWF48JNArk2LPMslFQsroPKxDaf5u8SOzIOPMhWssCJiLExyb0vtL/GRv/ENbhbXHtngg7Pkh07WrnwZESb2RRxIcWUGxLkkhKWpPCD0wltRsw9mU4Abx0ry2WxgXNaWjPA+NVuw6iX+/ti3YgxqN/PbKemzoqe6yOI1qYz+VWNhfkxAsNECOHc6jFne0Y0+qoKJphu9Hfh2MP8puLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfkUjYv8j8VYkoIoYgSo1GVeSTims3mm/tlBtKnhmBQ=;
 b=PDOxIJ2LGD5xQeHnNFtHinajXv7jG6izcXC+Wq6vyXFEgvdsOquJwu5NEuKbBnDfKxrKFphHJSdJLGQRNnHDhBm7VGKkESsqW8pIPqrGEYuNIveKZNtArdlQmWoKGlhObwT5++HCtc3Ysql/H3hUrkMjLxA04eEw9mN/gRPkgLifWTf4iK8pGjZMGRssG7iH0yMZn3ru/aPoydZA4XQlD0ZikIabgztTI+p49j/qIvVn5ScLwzj2VJrr8lkY6hYf7OxumkHzV3DIufxkQteXe8Z/vLqwai2URFUptw3L+O/b2BBjbuiuxMw/QZ3NDb1mCOOb0QGAeguRdNE4cp+REQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfkUjYv8j8VYkoIoYgSo1GVeSTims3mm/tlBtKnhmBQ=;
 b=1RH+L5ixsQxMz2CzUzyZa2i/4ou53D2LM7RoIu6upHHGreO9/uQ5yf+y6Fzq7aNxf6GY2CaAM06tvZtKifmqzVBjdTaL3NA6ID88ZITliiMnBCtQvfmwargfP4R3lZkhCQgUSnatNNREQS5lJIMXnScagFSs7csi13DDO7NtUK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 08:59:23 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 08:59:23 +0000
Message-ID: <06e29d07-e492-4093-88d5-af91c9060a99@amd.com>
Date: Fri, 25 Jul 2025 14:29:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next] amd-xgbe: Configure and retrieve
 'tx-usecs' for Tx coalescing
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250719072608.4048494-1-Vishal.Badole@amd.com>
 <509add4e-5dff-4f30-b96b-488919fedb77@linux.dev>
 <e2ee64c4-4923-4691-bcfd-df9222f2c30b@amd.com>
 <f5e40d58-c956-4ade-9de8-f88c834772f1@linux.dev>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <f5e40d58-c956-4ade-9de8-f88c834772f1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e28a1c-de08-4010-8693-08ddcb598cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnA0QXhFMkxERVpaNzNxSUlITjc0NkdLYWFleUlEOEd1SW1RY04vRVZOYXda?=
 =?utf-8?B?OXFnek5NQkErVExGaU1nSnhlRk9FN3FUVHgzNEtNQlJzTTBHd3IveVBNTXBM?=
 =?utf-8?B?ckNYSFAvWHNuY2RwZ3dJTDJ4Q3hueGwvM3RwNXE0UDFPdlZqQkovckZZUkkx?=
 =?utf-8?B?V2hXMmtpOEVvbjdUeE5hY1EvNW9QdGlyU0pEUC81YjA2VXJxakl3b1cxNGxY?=
 =?utf-8?B?clIzOG8zalNCYWwrQjJuVGhKaUFxTkF0aDEwYVl5WlNNM3ZDWk8yWTAralBM?=
 =?utf-8?B?a1p0bHk3dnZEZEVWTXNvMkVXMHJkRXMwNk9HdHNyMFJ3NVV6OFk1Nm1PMC9n?=
 =?utf-8?B?UWw0RVVWR0thb3lPN3VmRERpeDFscXRJV2k3U3h3bHppZkpHZ1gvdlpwZ3F0?=
 =?utf-8?B?L1VCeSsrOFNycGZLNkxEWmNLQlVycFg2cUZualVBcWdodXVLKzc3YTNRZzFF?=
 =?utf-8?B?M1hoQmR0ckU2S2tvNC9GKyt3ZmRBdXlxVWlJWENERW80UDdxZ3paS0NoUmVk?=
 =?utf-8?B?VHVTSUVYUCtKU2g3VjA3Sms1Umdhek5laXRYVWRNekFacE9IN25xYnNWQVN5?=
 =?utf-8?B?VElxNkZqcURWbUhPY2RDRHVEL3RNLzZmeGc1enZSOXdzd3lWYUYyRjEwc2FY?=
 =?utf-8?B?M3NKMlNjZjhnM0VTVmRjaGJxR2trYWR1a1d2TS8zUGNjZVV4MXpMM0NwVHl1?=
 =?utf-8?B?VDVMUmtuakFwZEVrZGxPWXdJbTlrNDJIUnRMQitxVTA3MEVrK05YcDZKcFcv?=
 =?utf-8?B?UGxLZmJHY2tIR09uVjJvMUtCcUJsNkxvMVk2ZnR1SEx1VkRHVmtWUUR3OW4r?=
 =?utf-8?B?SDJqRUtSNnBkSjhHcm5GSXhWSmNZelJpd1ZzUFNkN1FnV0UzVVBZSjlLSTZ0?=
 =?utf-8?B?dDFycTB2RmpGNysvek1iUkMvVzRJN2xCOUdhS201MGFYUWdLbmVQK24zeThB?=
 =?utf-8?B?NDZhQVNOT0FiRnBkNHByYyt6Z1NpeGozVVRhYkF1L3pEaHdDcE1ocVNCblc5?=
 =?utf-8?B?VmJOZVVMT3JVdUNTRGpMTHhnUG1jMFBWcElvL2Z6NVlXSHNuTGJ3OEc1WVBU?=
 =?utf-8?B?WHJBcUhld3ZoVVRPZVdBdXgwR0owNHNEd041ZU1sc1BoVDlsd2l1S1VKQlpp?=
 =?utf-8?B?aTV3bW5lWVNmVlgxRFgwUUdZUlovV05Kbkd1M0Q4NHpOdmg4SngvSEFHZlVW?=
 =?utf-8?B?ZktnSzlZZXlSQmdTWFRCVFdEV0R4MTVZc3ppSG81bzNJS3phZXg2cGlTWk1o?=
 =?utf-8?B?R25wY0hXTUJ1Z1piRkd6dUR6TTllMEI5RmpUQW9lOVlVUVlkY2ZhUzVldE5J?=
 =?utf-8?B?LzlVTlh1bW1qdzZmTk9QTnpyTXByeWxOWjl2YXZBUkhNeGQzVjgzS1RGVG1D?=
 =?utf-8?B?R3JjVFJCQjFuOXN4NUkvcWJDb2hsbmpOOFBFZFRJWmlOUFc2UTViRW12RDdC?=
 =?utf-8?B?YVR4c2VlODJGRXpzbDQ3NE1jemptbGZmWlF5VlVYWXp4Rm1MMzhiN2lXdEYv?=
 =?utf-8?B?aWFqaXk5aXNFOERLa0RhSHNDemZXeTFqZkVJS1IyYlFYaWZnR3FJSERWSXB1?=
 =?utf-8?B?SDdaVzJzOTl0aEtUYzA5eTRZRGZ6dWFiV2JWUDk4VFA2dGdZNHNmUnkxeUpI?=
 =?utf-8?B?Mk5jcVJRVTBGUlZvTUdFSU9EeVAzeVozZHhyODNUUGwrSTJHK01yKzJ1S2JX?=
 =?utf-8?B?Tk01dlpQMlF1RTEyblUzbnRvVW9XaWVjaUJmVHVSSVZXZlBaQUdVZVduN0dj?=
 =?utf-8?B?N1hhUCt0bFFXL0xubk1ZSTZvbngzZE9Hc2I4U25QQWNYcWx6U0FXeE8vb1h6?=
 =?utf-8?B?NWQ4UjFDYURLb0Q3V1lqOFJyQmZGYXdLanRLMHhCWDZDRFZVZVA0ZFhvK01F?=
 =?utf-8?B?NzdLd2hncEpDaFhaWlM2N0szM2p0Vm51MkNTOE5acXVkd0d5NVViVXcvaFU2?=
 =?utf-8?Q?5NqvZ1TdVKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHB5VmMyZlE1SzB5bTRNMmhvK0lNVXBYd3ZFam5tYUxCL2ZqVU40Zml4RUJt?=
 =?utf-8?B?aU1hYzBwZCtTSUxFd3ZkTDFUajQ1ZU92dkNPRkdHdTFVTWZrajhnYjJJd2xF?=
 =?utf-8?B?R2hpZXZwZWFjbHJDRHZCYVE2U2hjNUdNZGM5VFFTNG12dWloMmFSUWJ0TWw5?=
 =?utf-8?B?Q0liQUovWldJb24wV1g4clpFTFU4UTdwaStrdnF0MEw5cjd4UWtSOGM1eGYy?=
 =?utf-8?B?NHg5NVZkK0VnclRGWnc1NEpKUWFZL2VxZkd5V2NubW9RVFdnU1pGNllDL0Y1?=
 =?utf-8?B?ck5KcFJlM1RzcUZpNkpjOGJjelhEd2Qxbm1IbXFDQURJdEtGb3dzK0F5K2l5?=
 =?utf-8?B?T0dOeVhmeUVJU2EvRC9xN3JvbkR1L2lpaTVNSHpWRVZIRHN6NEF6R0w2Zmlq?=
 =?utf-8?B?dUJHS3NrUlNsMlV2UHltQnp6dFROK0p0bWlhQmNiUHV2dFNId1NQWWNZaFZZ?=
 =?utf-8?B?SHYwOGxzTjQ5cDgyU3k2Q3NTMXZVT0UvY3NxQWNwSXBpekdRd0xjV0U5Nlhi?=
 =?utf-8?B?Mm5vQTVNOUJsQ3VMWUlGS3FtUVMzNm5UdG1IeXA3ZnBqV1FYdzhpVndiYTJF?=
 =?utf-8?B?K2ovUUNVTTloUG8vZFlyQWF0NmhrekJMUVJJT0tBL21TV2JtcUgwR1JBR0VD?=
 =?utf-8?B?S2JMaWF6VC9FM1YzMnhEeVErVGZLMTFqUFRsb2tadmg5OTJtTngvaW5KaDdQ?=
 =?utf-8?B?RHdHSHU0d254emhuTHJSUm5UQjM1azVYU1lsbjVFamYzbUI3b3ZvYVlwT010?=
 =?utf-8?B?TEF6Qm9DVWZMbXVmUEE4UWRnU2dpVzE0dUVMaUVaVlZYemF4N3d4U1JqMGxZ?=
 =?utf-8?B?dmsxM0daQ3VidEFpWUFidk9lY2NJU0dkb1J6cTdobkRLMy9HMnhuUDVDQ0U5?=
 =?utf-8?B?UVFmaGZMOEVrbnVEUWZpdzVBMDl1OXVPUGpORjFHcFZGVGJ6U1ZRWUdvVlpN?=
 =?utf-8?B?K00zUFN0Ni9GRlNjcEt4dC8xb0xKa1B5eDI3aDNkZysvYnNVSDJOZUgvRlpm?=
 =?utf-8?B?c3JIcXJyK3hOV2VBY1V4d1k1c2p3bkVLSm9RUFNYdTl3cGVIR1A3R04wZEMr?=
 =?utf-8?B?dE9uR0tiNXd0UzJsRVVWYlJtak81c0ZhUEVwWXBzK1pzWTFVbmRFa3pzazZr?=
 =?utf-8?B?UXEweE9HajZBQWh0ek5uQmswVEV5dHpYR1NrZHdIVk91WWU1V1R1WTZZcXJJ?=
 =?utf-8?B?R1N4TkQ2cGlSREloQ3Vka0sxVi8rZG4xd1NVRnYrNDF3QWRYQmx3anQ4RUFx?=
 =?utf-8?B?RElUT3l5TVJKN1QyQ2pRL1NlSW1BaHEyTG40MklZL3IycHR6ejRuLzhncEg2?=
 =?utf-8?B?dDZMWWhNRHpBeEFXYWJxNmM5TnBpcFViYVp0dnZjZHZoTGh5bnpyWnA2WXdM?=
 =?utf-8?B?RVNubDVqOWRhY3VpLzNKaGZnVzZBN0ZqU2Z0aGlBcWtZOGpjN3ZUMlV2SWVU?=
 =?utf-8?B?eWoxT3FrdUJ4ZmE1TEZhR00welEzZ2NBK0VPL2hVZWFUYzZYS3ZhTlE1dUVa?=
 =?utf-8?B?NjJ4clZNNlo3eko0aVBHSHhDU1pwVG9wdnZ5N01yL3k2dFBJQW9XbzVUOXc5?=
 =?utf-8?B?cXNGNzRJRUdCNmljb2ZUbnZlVDhJKzd1aE92aDVlK0ovUGYzNjBpYXMxWnhJ?=
 =?utf-8?B?VnpxUWhsVDlITko5MnVQT0hkcDl1R0FqZGdUSHZHcGl1LzNxRDB2V3hHNDln?=
 =?utf-8?B?NHIyeSt2QitKdG9EWmFHemVUelNNVExaV1JWaDhWOTQvdGIyS3Z0WFYyMG85?=
 =?utf-8?B?UlE0RVpMeXhVSTdGdU9rb09saFhVM2J4U09oZ1R0WFJubExDR1VlWkdiZWEy?=
 =?utf-8?B?R0ZsblA3bnQyeXRCZ1RPNXQrODM0TGprcTBnQUFzSXU1S0UzNFNJK0dKMjJB?=
 =?utf-8?B?N0NQZDBQdVdveERGRDJxektLQkh2QUcyYVRTSVNkc2lvTFBlOCtlcVlJZ05t?=
 =?utf-8?B?Y2krcXI3Y3lHK1dRVWRxMGRlMFNuckhsTXh3aHQwR3pWRytDMXE0aTNOYmRW?=
 =?utf-8?B?KzhVeUoyMlpVcUErdjQ0dWhGL0taQ2M3aC9CSzFpc3JjdTJDSkg4WlpNNnlO?=
 =?utf-8?B?RmxicFI5TlVwSzlOTGcyT1A0UmZNVGRteFhWeU5MUkZONEd3NThtVW9OcUJx?=
 =?utf-8?Q?lVwKC20mvEa67LslKMIIXwVLp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e28a1c-de08-4010-8693-08ddcb598cae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 08:59:23.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2la2sERZLmk7JLYNSXu9ZmF3R0kr4Zfk9Bs3aU1c88Gf/PERfxCdYXrvUz28FznOWvd6ZOxMlCkEP83Dx33Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176



On 7/21/2025 3:05 AM, Vadim Fedorenko wrote:
> On 20.07.2025 19:28, Badole, Vishal wrote:
>>
>>
>> On 7/19/2025 8:46 PM, Vadim Fedorenko wrote:
>>> On 19.07.2025 08:26, Vishal Badole wrote:
>>>> Ethtool has advanced with additional configurable options, but the
>>>> current driver does not support tx-usecs configuration.
>>>>
>>>> Add support to configure and retrieve 'tx-usecs' using ethtool, which
>>>> specifies the wait time before servicing an interrupt for Tx 
>>>> coalescing.
>>>>
>>>> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
>>>> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>>>> ---
>>>>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
>>>>   drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
>>>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/ 
>>>> net/ ethernet/amd/xgbe/xgbe-ethtool.c
>>>> index 12395428ffe1..362f8623433a 100644
>>>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>>>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>>>> @@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device 
>>>> *netdev,
>>>>       ec->rx_coalesce_usecs = pdata->rx_usecs;
>>>>       ec->rx_max_coalesced_frames = pdata->rx_frames;
>>>> +    ec->tx_coalesce_usecs = pdata->tx_usecs;
>>>>       ec->tx_max_coalesced_frames = pdata->tx_frames;
>>>>       return 0;
>>>> @@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device 
>>>> *netdev,
>>>>       struct xgbe_prv_data *pdata = netdev_priv(netdev);
>>>>       struct xgbe_hw_if *hw_if = &pdata->hw_if;
>>>>       unsigned int rx_frames, rx_riwt, rx_usecs;
>>>> -    unsigned int tx_frames;
>>>> +    unsigned int tx_frames, tx_usecs;
>>>>       rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
>>>>       rx_usecs = ec->rx_coalesce_usecs;
>>>> @@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device 
>>>> *netdev,
>>>>           return -EINVAL;
>>>>       }
>>>> +    tx_usecs = ec->tx_coalesce_usecs;
>>>>       tx_frames = ec->tx_max_coalesced_frames;
>>>> +    /* Check if both tx_usecs and tx_frames are set to 0 
>>>> simultaneously */
>>>> +    if (!tx_usecs && !tx_frames) {
>>>> +        netdev_err(netdev,
>>>> +               "tx_usecs and tx_frames must not be 0 together\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>>       /* Check the bounds of values for Tx */
>>>> +    if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
>>>> +        netdev_err(netdev, "tx-usecs is limited to %d usec\n",
>>>> +               XGMAC_MAX_COAL_TX_TICK);
>>>> +        return -EINVAL;
>>>> +    }
>>>>       if (tx_frames > pdata->tx_desc_count) {
>>>>           netdev_err(netdev, "tx-frames is limited to %d frames\n",
>>>>                  pdata->tx_desc_count);
>>>> @@ -499,6 +513,7 @@ static int xgbe_set_coalesce(struct net_device 
>>>> *netdev,
>>>>       pdata->rx_frames = rx_frames;
>>>>       hw_if->config_rx_coalesce(pdata);
>>>> +    pdata->tx_usecs = tx_usecs;
>>>>       pdata->tx_frames = tx_frames;
>>>>       hw_if->config_tx_coalesce(pdata);
>>>>
>>>
>>> I'm not quite sure, but it looks like it never works. 
>>> config_tx_coalesce()
>>> callback equals to xgbe_config_tx_coalesce() which is implemented as:
>>>
>>> static int xgbe_config_tx_coalesce(struct xgbe_prv_data *pdata)
>>> {
>>>          return 0;
>>> }
>>>
>>> How is it expected to change anything from HW side?
>>>
>>
>> The code analysis reveals that pdata, a pointer to xgbe_prv_data, is 
>> obtained via netdev_priv(netdev). The tx_usecs member of the 
>> xgbe_prv_data structure is then updated with the user-specified value 
>> through this pdata pointer. This updated tx_usecs value propagates 
>> throughout the codebase wherever TX coalescing functionality is 
>> referenced.
>>
>> We have validated this behavior through log analysis and transmission 
>> timestamps, confirming the parameter updates are taking effect.
>>
>> Since this is a legacy driver implementation where 
>> xgbe_config_tx_coalesce() currently lacks actual hardware 
>> configuration logic for TX coalescing parameters, we plan to modernize 
>> the xgbe driver and eliminate redundant code segments in future releases.
> 
> Effectively, when the user asks for the coalescing configuration, the 
> driver reports values which are not really HW-configured values. At the 
> same time
> driver reports correct configuration even though the configuration is not
> actually supported by the driver and it doesn't configure HW. This 
> sounds odd.
> 
> Why didn't you start with the actual implementation instead of doing this
> useless copying of values?
> 
> 
Since the XGMAC controller does not provide hardware-level register 
support for tx_usecs-based TX interrupt coalescing, the driver employs 
an advanced timer-driven software implementation to achieve interrupt 
batching and improve performance. The tx_usecs parameter is accessible 
through the pdata structure pointer, allowing dynamic updates that 
automatically influence the TX coalescing timer mechanism across the 
driver implementation.
>>
>>>> @@ -830,7 +845,7 @@ static int xgbe_set_channels(struct net_device 
>>>> *netdev,
>>>>   }
>>>>   static const struct ethtool_ops xgbe_ethtool_ops = {
>>>> -    .supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
>>>> +    .supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>>>>                        ETHTOOL_COALESCE_MAX_FRAMES,
>>>>       .get_drvinfo = xgbe_get_drvinfo,
>>>>       .get_msglevel = xgbe_get_msglevel,
>>>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ 
>>>> ethernet/ amd/xgbe/xgbe.h
>>>> index 42fa4f84ff01..e330ae9ea685 100755
>>>> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
>>>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
>>>> @@ -272,6 +272,7 @@
>>>>   /* Default coalescing parameters */
>>>>   #define XGMAC_INIT_DMA_TX_USECS        1000
>>>>   #define XGMAC_INIT_DMA_TX_FRAMES    25
>>>> +#define XGMAC_MAX_COAL_TX_TICK        100000
>>>>   #define XGMAC_MAX_DMA_RIWT        0xff
>>>>   #define XGMAC_INIT_DMA_RX_USECS        30
>>>
>>
> 


