Return-Path: <netdev+bounces-124087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C24967F2A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA68B1C21A4C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 06:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3BA1547DB;
	Mon,  2 Sep 2024 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vd6MYG19"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535462C1B4;
	Mon,  2 Sep 2024 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257447; cv=fail; b=hV9mUkRglCIILmIq5QGU+n6qW1dmy8UQifpEmtyNdkMpI/75KQbJkSOl7NTT876PtT+b2z8KMJinGshLjZlC5SNXDklG0489pGugi1lYZntziSFCdyqy+tum1Zdqe1azag/CgZ6YNCag8L2KlxZ2IlIGdwl4bHx5vqXAXrN5yzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257447; c=relaxed/simple;
	bh=qUIAMj7j9tiDhezJaNNOSpJur48c2MdbOaSIps5lAoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=btYxrDFeA1Zu00Jti5jeJcg6speOnLBZAaCoZuX85H3dzuP2AdFyeblx8AZcaJw/6y2UI/BapHZY+0zJO4jZOtut+HDLsj2L0ufs4exHSnWm4ToYotHIRhlmCeRzpb4OeQk3H5JsEivGpWkmgzbdeZ3ul4km9VC0l7URr3q0Qtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vd6MYG19; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whwwR4aD/1MEcfHMDsBwWYt2oUa4bErRcLpXjAq9/KEeUeQZ8oNcb8L458UtBgD09uToNa+GAs3mGfsguyj9QuJMEmlJLA9FA+qfkNP2oo6sA5SFO5t2TzPbvQhvxDKEJuTW/30TiL61r3Io8CMeQTNHbckkB5HMRxJkDTZe9qtNQuqv+D7EKcNyZ21ZWPLyxWAczVG+4U4HGbMHRw29Z8SBT+8AdgtULPtdMB6FiK/GKRQSvtPmYbh79SDaW7MNGAhHwcQsRq6IUunj8m9ocLBDgWVED94xi9gphJHRqprgC0gJCzWKkoa8w28XU5Sup9YOKxt6d3Of4no236mPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5dvnn6qUGAcZGcJMnWFvBqb0uUbIvVK3ERZVnnQqA4=;
 b=HtVjk9ns1MW5Hw4+okxZSZmqng2/QmEcA/Z60W6W9Yn00KpSKqhXHzuZydePKs10IfAc3vuu6LeEa632aJj53m52BDSes4p8kpU8ffeD5hTee3U8XdSN/2z+oCe+AW7Zy4haYj73ciXEvU577W3J2T2kSqQefSjFfj1GIebNgDTegEdkfHZhFQi2PBRzYH1rbR0n0d+c57lPmCdFGxuF6jou1DPkv927oF19n+ZfP7bz0C/qf+Vk1xSgpXQwzQPflnlFt8cL15drV1lXpMRRN44XIYIwpTIe8agPMdU27C/Pz6hqtr1Es8xqdxmp+XXxPjfLH6ZpkGJC3qk4GAs9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5dvnn6qUGAcZGcJMnWFvBqb0uUbIvVK3ERZVnnQqA4=;
 b=Vd6MYG191dEipVpI8H9mm5g5OJYchPfVpL3+0fGtbgnp59rddqojlAUeEVhAwfLTQ49McMnbi4EKEtx1fV3HQHF/w6vYC6nBApj3eRh2Hxt4dZYAM3VFZktgwDryQ1W08f144+2mWrHyXjGWMopP5wxD0qQzaemb4Gp/sz4M3rOZ13e1i7GZIUO6yqQ0jmMeLthAH9GKSESMyZJfO7dgofXKWuySklBSxy7qud/LjL99CnP51//C79J1sQuqJpEZuMitW+Jjol5MO3tzqX/kuT57FM52z6Uanu2HwYwcSiS2/TDJTll2qeHkQtcEgUGHIH8TMX9YYevhaw8hKO3fGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:10:43 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 06:10:43 +0000
Message-ID: <3360d021-6290-4d6a-9d83-cd4c2d47fd0d@nvidia.com>
Date: Mon, 2 Sep 2024 09:10:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
To: Jakub Kicinski <kuba@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Cc: kees@kernel.org, andy@kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
 <20240831095840.4173362-3-lihongbo22@huawei.com>
 <20240831130741.768da6da@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240831130741.768da6da@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: def63d60-6929-4db6-8235-08dccb15fa29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWVqdVlodjJyditaR2VLWWlkQ3hVWlFQcXkrRW5DN0p1dWd0MWsxTUhPL3VG?=
 =?utf-8?B?eURkd3RtQ05pMU0wY0NzTHVySml3d2hHSllnQlBDZVc0bzVCVjUwczlWaGE2?=
 =?utf-8?B?MWJtemRjUldXMlBPVGprOVh5Vi9YTnV0TFhDNkxuVTRXdjltejZxTzhndGxT?=
 =?utf-8?B?QjBMY1BITXVhelRQYWo0YnBGbm4vYnhtMlJ5RmNjdCtzOUNPWHcvMitlZmpL?=
 =?utf-8?B?YzBNbUVMS3lmNUJ2N2pDQnorRkd5L2RoVURuSHNHa0E3UEM4ZW0yeWhzZVls?=
 =?utf-8?B?NTVjdDlmS0RsRjNwcy9ma0k5NFNPak55U1Y4MUNqRklNaE03dEp4VVNoUkNi?=
 =?utf-8?B?Y3dIa3Z1ajRUcS9URGxtZmk4WHhPbTNqZjBXZklPOGRKdVNMMkJyTVNhN09y?=
 =?utf-8?B?M0lWWElEWTJkTDRCKy9XQ3plMXJiSUdwZlJUMk8vbklNaXhBcWxFQWQwaTFx?=
 =?utf-8?B?WVVWNmttSlNGdTk5QzRQQThNNjFkMGNhTVdpS1NLNTRrSzh5L0xkVjUrYmpi?=
 =?utf-8?B?Yk9EejdoVTJ2Mm5jREFvTXNQS0huY2lOVi9LRVlFbDVycFFOeUdWSHlHaWxS?=
 =?utf-8?B?cVpQT1RhdGJYcDdIbUFXNmJWN0d0TjRnR0xvSVRIT2NpZWxRdG5XWFJvSFdX?=
 =?utf-8?B?S01qT0w2Qm9rSTBUbld0MFRZcDZtcnFkK0w0QXZxbjIwRC9lSjV1VHdtN0Uv?=
 =?utf-8?B?TkdZbFJIODBJc2V0eGpuekVvSkRZcTFac3FXbG5BcEZ6MDIvVVcrcmxhY0sz?=
 =?utf-8?B?NmRDV0FOUjBERFU4eEQ3ajdxZHJyT1BWQXJDTWhuTE5xQ2xXSUdQWldMSmJw?=
 =?utf-8?B?QjgyMVBuRS91ZW44T04rM00zRjg2ejhIZ2d0SmpocXhwVU9XY0F0azVBVm1r?=
 =?utf-8?B?RlNUaXdSVUZNZ2xPYVlRTHZ0UVlBVG1jZit6a1ZvSWtHNDBIck5MSi9vaERh?=
 =?utf-8?B?QlJMcks3Y2lJa0t6WGpHd0FYejV6RWZ5WFdidVg4TWcvS091U3ZwNHdPNnBM?=
 =?utf-8?B?NEc2QzFEaTNlVFhlVEJxQ1BsUzJLTy9OcUM0OXZtanl2Um9WeFZhdVA5RGdx?=
 =?utf-8?B?NVltbGhkbnpHeEFNOXhpN1ZYdysvRlQyR3FaczNTNEZrVWpLNXlUWXdkMElP?=
 =?utf-8?B?OGlQdG9HRmQvbzhIa2IrZGhJRC9kZDlxZXBKNXF1OTlsWHRLWHFJZFY2aDdR?=
 =?utf-8?B?bGorcGJXNStQTG1hbi9WdnJMbm5seXdqWXVMNDNKNmliNVV1dldjTDQ0NkFT?=
 =?utf-8?B?U0tnTjBMaTlLZnlvcDRJNmRFaDh3VTZaRDlvL3NaREZ0Nm5kWmJBaGc4WjZO?=
 =?utf-8?B?WUJNcmI3c0JOT2ZpMFA0VWcrZjNzUjUvVGZPajRMUzN0QjlsNDRieXNGcGpq?=
 =?utf-8?B?ekpUVndQN2JweGJ1dW5lMk9hcFprcmVWeHZzMWtGcDZhelg4ejFTakQvZXJx?=
 =?utf-8?B?TkdXb1NVVkx1VUhsdXVJdmtSdnQxazhWSkwwL25JdVZudTRSV1BQTXZFU0dn?=
 =?utf-8?B?NzhVSGpZZFdSYTlaWHBhNTNLZThrOHcvSmlLYmF3eWY5SU1WMlZTUklIT3pu?=
 =?utf-8?B?MjN6Q1pnM3lZN004dFg2ajZ1SEtuT1lVbXAxZ3U3cXRZTFM1NURMVzB2NDhD?=
 =?utf-8?B?aG55L1FNclJtaHR4dzBzNDIyT3RhcUthNVh1Y2NkbUwxNmNab01NZWJzWTJn?=
 =?utf-8?B?MW5haHJRa0FZRHhQSjluZFhKWkxNSCt6MzdqYkxJQ3Vwa251cGk4TTlxZ3Nz?=
 =?utf-8?B?d1hUNmtPZ0x4MDBnRExCMkNMK3FxOGNGalAyQnZUa0hrME51M0RQd3J5N0Q1?=
 =?utf-8?B?K0hyOW9vWXdUaHRyZXIvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjFOU0lSM2NnMTkxanlQZkFhakZyRHpmQ0pJbUlvS0Z1b2llQkJBTmt6Mitl?=
 =?utf-8?B?N2E5RWRRWERlMkJpSGpOUEZSajM5aFlLT2V0dFlZTlgrUTZRSW42TVZLMzRo?=
 =?utf-8?B?UVRWeWR3RS9UR3VqVGtyb043UytJWnhsNTg4blRNR0dQa3NDQjZiUUxkT1ky?=
 =?utf-8?B?TGxFZlUyQmNJZDhlWmV0VDdIWXZYWnhCYnRwSGlGdE9lUUFFbkwxREZ4aUhi?=
 =?utf-8?B?WVc4QlpGOERhaUlUTGtkdkNyUXBXUnFEZkxIakZOWkVjYkFQQmlQOG1qekxK?=
 =?utf-8?B?ekt1K2NuazYyeitQUmZYM2VlWWkrTENBbG9jT3hWU0VmS1V4dis2Q1pORkJ1?=
 =?utf-8?B?ejYxNjhtRDNybGc2eWR4SUo4L015aFdZOWoyaXFMN2FFTURMZFRtZWZqamg1?=
 =?utf-8?B?blVEdDRGNVJodFBCWHNsZ2Ntc0wwTmcrOGszOFA2c05WN1liR2hEV0I5M0FR?=
 =?utf-8?B?MndjUHJtQ0JYVzlvZE5kYUdpdSswVVdpS2R3akRXYjR5N1JDcnhOR2lSa2xx?=
 =?utf-8?B?M2xjcGdieWtLWkF5SzFZSm5tQ0srVFdHS1VjdzllMUoyZzZjQldsUlh3YlMw?=
 =?utf-8?B?YzRQeGNQZk5JK1l3eE0vWURtaXZualVFNjNiK2ZUeU5MRnltbUVNMGtLVWkx?=
 =?utf-8?B?bHJyZkhNMTY5ZjExTC95bWpxZnU5UE44TFA5NEJxamdiTnZFbjMyVUVTWDg4?=
 =?utf-8?B?N2tieTNoN1BQN1BoOW5iV1loUkFYaFE0d1FhVEd3clIxeVJoOUFhazNzWHdR?=
 =?utf-8?B?T1ZWZXQvZFVDYTlkZXNhOWd2aU9FRFJuWG1lWjNMSUZxSzZ2dk5YK2ZqT3lU?=
 =?utf-8?B?MTdIRDY4RThRanUwOXZUU2RrVkxOSjI5V3VoSVlVVmZTZ2lQWEpiOTJpSnRh?=
 =?utf-8?B?cDJlTEV3bTl6cE1KV1RmVXFBMzZuTG1aVU5Qdld4NHVOM0JMWUJwSDZCRmln?=
 =?utf-8?B?OCszUHFMeWdUazN2TXgydUZmRFdOWElhZG8wUkdlbndMaVlkUzhtdnlxeGMx?=
 =?utf-8?B?ZXVmdEZYb01WZXVYamthcnlIbTlPTXVRZXlZbjBWOGRFUkRxS0dPQkplek9F?=
 =?utf-8?B?bTZIUlpTcnorNnJ6ckMwVmU1S2V0MVQvdEVac1VzK2RIdlc1a1M0U2xPdFlu?=
 =?utf-8?B?NEdTNTNGSmVZOHQ3Q3VtalRFVkdlZjhMNWRFNVplZkRCclNBaDArU0psSHRL?=
 =?utf-8?B?SENxUkRtczY2WGpNYTNEcVBtN3JVMFREOFFGVnZ2MXBCNDdQbXpGVjVZbVUw?=
 =?utf-8?B?VzZPQ3V5UTN5cnJnZnhjNEduUUxDWTBNTlFCa25FZ2V3WDdyTUxRd2JXNVd4?=
 =?utf-8?B?bXEvKytrV2NQL2Q0MFhscG04QzRzZ2xML0tuV0xBcjJPbUxKR2s5TGJ1aURa?=
 =?utf-8?B?bnhPekQyR3plMkxCdlJmZTYyQ0hLTDAyZHZpQ1pWVFJpeTkvVmtRUWVSc0NP?=
 =?utf-8?B?YkNjWDFpTS9BZ3hORUhvM09VZ2hLbVdzWk1ib2hDOG9yUGpnaTRUejR4YXk3?=
 =?utf-8?B?ZWEzOWkyWDRwSjlhU3liZkxHWlJQelBDVzdtcVlQdnkyemFMZXZTd3JIY3M3?=
 =?utf-8?B?M25IaHE4b2JjV2wzN1c2aktjTnFnTm1IODhrcnptamhxM0RtcXd6VW14SlQr?=
 =?utf-8?B?aFZJU25PN0VpT25CRWFvM0JmT2V0eUNBbmhpVDA4SGJxRC9mWkZFdTNQUnRh?=
 =?utf-8?B?Y3d3dk5OOVVNRVgzZ2J4eWN1TWVFUHFFamU0RU5HWWQ3eWlIOW9MVWEzbHNK?=
 =?utf-8?B?TVRwTDBzN3RoNGVYdHhwY0ZRL1I5VU52c2Fvdi9meHNVMHZJTEtFODBTNnQy?=
 =?utf-8?B?V2w3R0x2L2JyZnh0YWVZTE9OOTROL01EUml2b1hkZEs1VzZOaWVjMCtISDRR?=
 =?utf-8?B?MWo0eHVFWnQxRG5QU2pEMFBBOHNrMFQzYmJtUUh2NVpmc296R0xwNXlBMjR5?=
 =?utf-8?B?TkpXZkdkTTRZVzR4V2UxYTFnR0JZQVMyVHcvRWRjMUw0dW9BM0VmUndMR0tI?=
 =?utf-8?B?VXpXYVdqR3hZQjB2bzE4clJ3YWhiOWVrWHRFN2hrc0hEU2ZsNGFsK2Z1amRl?=
 =?utf-8?B?c2MzMDA1eVZEOGRZWTYyVUJUeVNZZnBCR3lDVktOaHN5eDhlUU1ZaXdTdEhy?=
 =?utf-8?Q?rShRrlgT81fKPQbxVJcSVrEwC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def63d60-6929-4db6-8235-08dccb15fa29
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:10:43.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfviGk3Y2jR1z6sP3rSJEgmdxdpcbzV0kbbkFhAJdB4oyl+hunwB+kkDHGwaCq/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

On 31/08/2024 23:07, Jakub Kicinski wrote:
> On Sat, 31 Aug 2024 17:58:38 +0800 Hongbo Li wrote:
>> Use str_disabled_enabled() helper instead of open
>> coding the same.
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 6fe5e8f7017c..29647704bda8 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -3178,7 +3178,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>  
>>  		/* [unimplemented] */
>>  		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
>> -			   arg ? "disabled" : "enabled");
>> +			   str_disabled_enabled(arg));
> 
> You don't explain the 'why'. How is this an improvement?
> nack on this and 2 similar networking changes you sent
> 

Are you against the concept of string_choices in general, or this
specific change?

