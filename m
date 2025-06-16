Return-Path: <netdev+bounces-198013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D03ADAD08
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1783E163957
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938C275B05;
	Mon, 16 Jun 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fofte9rN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487D231835;
	Mon, 16 Jun 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068426; cv=fail; b=Yqmuxw508W5Tlgsd4/IhkvB58ct7G1YdLa7LtnpxZBmwvorWk2OIPZ+3xVJ48fH1cdketeJ81LkdTRNIiB7ftnjnfAkFh2epZViZScxbwbliWJm7T+eFBS/wkCqyXFQQp9fQuUxIfM5m1CLJS+FA8qWLPwK+Ke8cPQJU7rOu1p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068426; c=relaxed/simple;
	bh=ETKa7M49bCzhoQh6CLLmBZnu92PBTLElj328VqCIE9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NUy8msSWf2pRUkJT135w7GETwMAKaSKMpXcSy5g5xD02kZJQi4Q1Bw+YflBul2LuuZSDdcI1vuj/fy+K3YVLTnJm+wdWGddF1UcBiw9yvfYy1FBXAvWKtTeLYqgqR1bWsd41CeWt9yGd1gWPJmwuRz5ULoXefvdtGl1fKWEjLK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fofte9rN; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idMNCRX7ciwgqA5C/n5oJnpUM9XG3hf5vYPsaInw5IryS7dWq2fLLLFxgB1CbzifFmw+NP3KwKPpEKeDpzFaUbcnOomsQeKc7Do6LLB/lGLy3R41YMd3Q9pzDHejEB8/PtIlY0vHFCWyxbRx/j0Nu6LZqgNsfDJ4nu+P+6X8+akteUuSHNuN26yPLt6NhYeoEpkTjKgfew1Eup89ZHoWiJcJ82NdEuxAtl6IUSsV8yr4ILGfyoT8r+qGjtrbiQzJC4/r//rWoZhdMUWxJ0803kJEBliZOr8vC0gx8wJBDTPJlGmH/ZjhKK4rB/jZ+4Ml0BKdN74hbuOOgOaqfYEkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBZl8le4N59k0nk3A6OQG7eRt4coMrfllZNX9cqMdqU=;
 b=h//Dtmsd1Ysdgjh5+TJiijOnLRBnJDWsVZMKkxe3DKxq+0BumV8Sgu3WDZ7UQUmH/yNSGZVz6fkf56511ZZ/KK0g7glAmNkKvmHkxe37UAwNMDfLHvaiBddn49ABZO1Zy2II8UIWLwrnz+dl4+VcygbvAzh0Qhq1SqHrdxCBEPmfkWA7c8P9QM/DVuHhnn13VQW8TQFblrN+kuPQgXKnBAVaqASk2PBz5loYwgxLJrvgfyuR8/MTT1z2CRcgm15Z9ogej+r6FKWGz3naLn2joCug96nWPbXaQTaU47BDr/O0APZIy3VkUfgjssA+NXwvvOg74jHXbPhG0TPaQeqMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBZl8le4N59k0nk3A6OQG7eRt4coMrfllZNX9cqMdqU=;
 b=fofte9rNbgVG4CwolNRcsdCtRzFZw9d56IK2MzbV0qK2NxM8w0GEvpaiTOkMn5yXWxqdExwU9omJ4NouWTIj9HpXIclas7nPtUoO1/MEKQf1wSLDeIdDlc6PHhRIVYRC1ioVWLPwTwrh8yXXpIU32Rs9LGYrWvqSTieU569qx4gQQLH7HgI5i8G86SJxIe72ihT92rO+QzI4X0BzTfbYdCZeKzpiiwyZ5LiTAIldg8znER4cZizmUTphe5/YvV+4J59a4it56nv1d806tj1o6rLc6Ypf3+rgt8bDAGza9d8I4WsCV31mqDkYCNcqEpMF6Zg5pR6QkCVANk6nAyZ18g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 10:07:01 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 10:07:00 +0000
Message-ID: <f769098f-2268-491e-9c94-dbecf7a280a4@nvidia.com>
Date: Mon, 16 Jun 2025 11:06:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
To: Andrew Lunn <andrew@lunn.ch>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 Alexis Lothorrr <alexis.lothore@bootlin.com>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
 <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
 <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>
 <353f4fd1-5081-48f4-84fd-ff58f2ba1698@lunn.ch>
 <9544a718-1c1a-4c6b-96ae-d777400305a7@nvidia.com>
 <5a3e1026-740a-4829-bfd2-ce4c4525d2a0@lunn.ch>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5a3e1026-740a-4829-bfd2-ce4c4525d2a0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0187.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::12) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bd8423-69ac-46ee-5a54-08ddacbd892e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDMrTWpqMlBxTjdvS2VLT0VKU2pGdnkya0pKWkZDNC9tbE9xckwrdndlZG1H?=
 =?utf-8?B?Y08rQmdZMXdTb0hNTGVPRGtqZHdlbDM4OGdFOFpBNlM4QVVrT3d2aVlBeE44?=
 =?utf-8?B?VG92VExGeCtzcGlRNExteHJvWnpvdmJrbENXNUNvbEIrbWQxaGdRUThza1Uv?=
 =?utf-8?B?L28ySXM2NXdzZ1NRMjRNYnZDL2Q0RmZ0Sk5ITG5LK2NQTWdqWXRhRldFZWd0?=
 =?utf-8?B?NlZJYVpCUEJvMnNyMzFybkM5ZUxQcTM4dlpia3czamtuMzJmNkxZQUhraHZt?=
 =?utf-8?B?b2YxejN5dElTNDlZSGVWODJxYjg5akw4TkRFeUhMMXFDcURYeTFYWmJmN3h6?=
 =?utf-8?B?U05iUVh1WVpjWWkvSFpaaDh4MDVzdVA4enhobDU1OEhrcDI0TkN0Rnd2eHZt?=
 =?utf-8?B?dVAzUm5LTGRab3pWUERDNmpLVWxvUm9mY1pMRzVlMHIvZndreUtuZGJVNytn?=
 =?utf-8?B?NFdSMjF3ZlE2YjRiY0NyMmx1Vk5IRitRNDRuYUFrcklRTi84cjJrUHl0d0lC?=
 =?utf-8?B?cFBlZjBNWko3ZGdoQnNSNnJBZzZtODEvbXhqdWFmNERObGNvSE1oTXZSNU1S?=
 =?utf-8?B?TlY2SjdVSzdYNWF0bTJDRm5uOHR0TWs1YmQ0a0pPa0pVc1hmVEZoMVhHSG8w?=
 =?utf-8?B?VkVTY0daL0kyRGpKOEd1QjNHMmZhUWJuOFlTMERxYlUwTHI1dUlta01NQzFI?=
 =?utf-8?B?RVYwVENUSSsybStRSmM4NGtaZlI4ajdBUGNGZjdKbUxEeXRhK1lBbG9jMUZQ?=
 =?utf-8?B?U0g4bVQ2UTNNQVAzS2dYRTAveVppU2xJN2lQcmhjN2xpNUIvZ1ptOEJvTENB?=
 =?utf-8?B?WFRCLzBRd2hzbWZOSUFadm5CSFAwRG80L25kWEFMd2tUNklpdUF1RXN0ZmpU?=
 =?utf-8?B?RVFZM1JVZXNLRWoxOTFrWHdjbUpsZWpHRXBVMTNUTjhFUkd2YmhFNFZweW14?=
 =?utf-8?B?RzRHbGNWYkhlSGhXd2VvQnNXazBXaENoekRXbHhxQWQrNUlyUGl2VVA3THBj?=
 =?utf-8?B?dk5TTUJJT1VJbW4zWm5YV1NVT0RZMzYrc2E1M1NwTGtyRTVybmJxcG4ydHBi?=
 =?utf-8?B?WUN0VTVlTVJqRTJTK1FYbHdPbnhCOUR3M2p1cXlab25zRWllUXc3UDhvSUJN?=
 =?utf-8?B?M3p1Z2lOZUQ1cTRWbENKV25sTUR0V0NRNSt0ZHo3R3VhSGpVVm5kQS80OExy?=
 =?utf-8?B?SEJrS0Y1U2pEM1E4dmszck9IUXBpZExZeExFR052WkJaQlliOExqT2VSYTh6?=
 =?utf-8?B?ZHdHN25PSzk0NnVWK2NJMUtVTmQwaXZZZGFqWTVVZFRUdGpHSko0TmtsSkVI?=
 =?utf-8?B?cXhiMDlLMENkSTlrZTl1bUMvRmJlRUpaRjNmQVo0WCtVVmVERTBHQjVtYldJ?=
 =?utf-8?B?NllRNHp6TFJXVys1SCtGamlONzAzT252T292aTl6OTc2cmVXOHZ5bnlwWlcw?=
 =?utf-8?B?bWUzcm9YMy91elNhUjBkald4L0V4ZDJhMlFsMEJLOU5UZDRoalhvZ0NPd2dl?=
 =?utf-8?B?cktoYlFNOW9GTmluS2E5UGpoZkhDOW55OXVkYjFicWVaTkZuUHV3QjZnQy9G?=
 =?utf-8?B?VDhYZnJoWGFWdkVkek92WXBxSzlENlZwWGZWN3JKU21GYWt5UG5GakswSjR0?=
 =?utf-8?B?RGZvVkdFT3h0ZG9jQU14cFRlYWZVblhxNnFYaHowRmJKZ2hIaExNVTVRRzls?=
 =?utf-8?B?Mm16ZFhNSFRxTUpEWFQyRThrVU90QTV5R0pxNnBJVHowakhPSmducHZMbmxv?=
 =?utf-8?B?c1Z2SWpBOWRJam5iR1VxbmIza2lmS3NyaHFFclI0TkcveDdTSmVGSncvdjQ3?=
 =?utf-8?B?MVlpL1ZCdzJXNGp6MmpIRVVLUDVibitxWEdua0RxalVWUS9uNisyZ2s1emo4?=
 =?utf-8?B?S1NrU09VTDdveUJMK3BiUGpnRmttbTBTSSt1NlJkd0NEeFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGwxcUNCcjVQR2lNdDJXdWhreGVqL3pRc2lqdXk2clQxbUtCL0Y2cHp0OUN1?=
 =?utf-8?B?YVhPc1pPdi9xYk8yUVVZWnZEL1E3cms4QnlFSmpNZC9mcjZ0T0oxSks1L1Iw?=
 =?utf-8?B?aGNQdFZFTERJQVcyS0lTR1V5Y2R6bEIxdGJDTUNoQTQxWCtzWmRqV2lhWk9W?=
 =?utf-8?B?ay9ZQkJIOUVqa2M4blRZc0dlWDRRTDRUQWF3NUN1WDBkcXdkNDdnUGsyblNC?=
 =?utf-8?B?THo0OXhrZmRVZllPMUU5SU4xVTArVlh4VUlFeGttOE15aHkyei9WWFVhdUZM?=
 =?utf-8?B?WTZHN2ZhSkJKZmEvZ281Q2NLUnpHaE4xQ1FrYkl0WHMweVVoTVpBQVdWQzJV?=
 =?utf-8?B?USsxRTNaSElGcCtWOU5xVVZkYlNkdG8yM29mQXdNbUVySkNqSmQxM3c0UGN4?=
 =?utf-8?B?bHdIbXhyc2xhbXdiL1NUQk8yaDhXV3BLcUZ1UExmSDAxSVJ3bndkK0M3Q3V0?=
 =?utf-8?B?Nk9lTjBRQzY5Yk8wUThNbjh5Yk1QdTVuTVVHL09LekJ2WWUyenJIZWU1ZUxv?=
 =?utf-8?B?Kzg3MHdRRFhpZUJ6VE16dnFkengvTis2S0g4S2tGSm9manNGMWhKQkl3RHFa?=
 =?utf-8?B?N2xjSUZscml4TXFNU2NBaEpjcEJNLzhMdzB3Z2dsMDVSbStmM3BudnAxSmR1?=
 =?utf-8?B?eW5LQUt4aVp2ei9WTG9XWHN3c2JjR0EyK1gxd2RDd083ZTFzclJwdzRhYWVG?=
 =?utf-8?B?STNEZGhHMDZacnBnektJRFVPMmVKY201MWpuTWd6TzVXUWRyYWdiRmtSbnRT?=
 =?utf-8?B?K0Y0Z29pVXhJQzdEV1Q1V1pOci83WERoOVBRSVZOb29Ja0VObjYvR3o3UjFs?=
 =?utf-8?B?ZThGZHVtditYUVo3WTJwVmJqWVBVY09DWFRMRjV0VkNlWXk1YUFiVHVyeEF6?=
 =?utf-8?B?TjQ5R3BPWFBKSWRjMVcrd21FWkRWZUtwRFc4Z0E1MmZpbXo1aWJmMEZOVFJU?=
 =?utf-8?B?K3ZQRVphRnBLVGVDM016bllyaFJHM0p1dVVjTUNQd1VhWkZXUWoyUWxSd0VC?=
 =?utf-8?B?ZE85OWs0MWg3U0RqaHRwOUVuQ0lWMXNIWEF4aHBTbk95c1ByTnJueG5vZzg2?=
 =?utf-8?B?NTJTQU5ITGdyRjVJWVhxbEdlcjBZRzBkaXFFRWZ4NC8rOFVQU3lFSjdWL0NI?=
 =?utf-8?B?NDljcmw5cTU0d1hLeStJYkV4czQvMldPS0JFaExuT1FQT25vVDU3SUp4WXVN?=
 =?utf-8?B?MzRObENmRjBXanFQUkRDd2lyZklsSXZxcDBLVHM3d3RLSGRpSUJxRzFobEdy?=
 =?utf-8?B?K2ZXM25oN25Ka1pMVS9SZEJ6VStWQlZUSStUeVJjUHZlQmt3WTJkcFluRXk5?=
 =?utf-8?B?L3djajZKMFBIUFVkRC92UDlaR0wrc0lId1l0bFczLzk2Q0Y3WEZiTmZsYzls?=
 =?utf-8?B?TXFhVnhjN2k3VWtTdkhyN2crYmJySzJ4RDlnaVFodHE0Q3FXL1BuODNKQzlJ?=
 =?utf-8?B?dnhWZm9vL1VFeEdwRDJtUmRSZTNEVWFKWDVVTE1qM2dCYXY0Sk5NNFBvY3Z5?=
 =?utf-8?B?a2hFakRaZ0hzYytjUnJRc0l5YWhmNklpVnNxU3JGaG5CL2xKY0hlL2lqNzgy?=
 =?utf-8?B?L3U1SHVybldYengwbWZqWHhhQXl4aEZVZFJER252cjBrODZjREREYTZOd3Rz?=
 =?utf-8?B?OFZrbVFsVml0TWFWdzBPOUh6U0svNHdUV2h6MWVoWjdtNlZVaklpQlBTVkt6?=
 =?utf-8?B?VmozOWc5Vzd6Mk9XdTQ2SVFmZDd0OVdJeklXWm16Q2VWRkRydVExT01UQWpo?=
 =?utf-8?B?cUdBT2NHSnNnWG44ZTBxQkFnaVR2aGtIbDJhd0YwMG40dlN3V0pvQW5sSnY5?=
 =?utf-8?B?OVBuMFVDRXFqdEl6MUE5UVc4Yk4yZU9zOG9rWU9seVBSSjFSMnFUYTlqSWJj?=
 =?utf-8?B?WkdhWVJTdmlJMk5IcDQ4YkxzQmgwWk1rV2JYNGQ0ckxmY1c3Wk0yYVRXWDVN?=
 =?utf-8?B?cFFoMFlZK3U3Q3d0S2xiSklxZXFad3RWaTJZTjhnaFlYSXljSVNyQlpIWk8x?=
 =?utf-8?B?Y0ZLKzQxbGE5c0NXaWJYbTlabVNwWkg4bHZ2Q1VRMVVBcSsrTll6UklTL05j?=
 =?utf-8?B?Q1lKUVFzUXpDSGlzSlNTSTlyS0J4UEp2ZVpaTHQ3ZVo5SEhuVUpnZTc2cVRj?=
 =?utf-8?B?RFZJN2NZOEdaV3BQajBEK3pyYlhhcCsySThITXhwK0s3NFk5c004Nml4eUNX?=
 =?utf-8?Q?TF/a4pDdlot61aADiLJgh6KDiXPoJxQOFxlyznfBqopK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bd8423-69ac-46ee-5a54-08ddacbd892e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 10:07:00.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CLMdrg3sA/ckfVCvi2dNcgAdxISVNUJnI97eiQcj+BeMxTCX8ZSTDOw25SPXsOl+mIZvbVm50dK4fF1kKzEew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475


On 13/06/2025 14:22, Andrew Lunn wrote:
>>> So you can definitively say, PTP does actually work? You have ptp4l
>>> running with older kernels and DT blob, and it has sync to a grand
>>> master?
>>
>> So no I can't say that and I have not done any testing with PTP to be clear.
>> However, the problem I see, is that because the driver defines the name as
>> 'ptp-ref', if we were to update both the device-tree and the driver now to
>> use the expected name 'ptp_ref', then and older device-tree will no longer
>> work with the new driver regardless of the PTP because the
>> devm_clk_bulk_get() in tegra_mgbe_probe() will fail.
>>
>> I guess we could check to see if 'ptp-ref' or 'ptp_ref' is present during
>> the tegra_mgbe_probe() and then update the mgbe_clks array as necessary.
> 
> Lets just consider for the moment, that it never worked.

To be clear, by 'it never worked', you are referring to only PTP 
support? Then yes that is most likely.

> If we change the device tree to the expected 'ptp_ref', some devices
> actually start working. None regress, because none ever worked. We can
> also get the DT change added to stable, so older devices start
> working. We keep the code nice and clean, no special case.

Although PTP may not work, basic ethernet support does and 'correcting' 
the device-tree only, will break basic ethernet support for this device. 
That is what I am more concerned about and trying to avoid.

> Now, lets consider the case some devices do actually work. How are
> they working? Must it be the fallback? The ptp-ref clock is actually
> turned on, and if the ptp-ref clock and the main clock tick at the
> same rate, ptp would work. I _guess_, if the main clock and the
> ptp-ref clock tick at different rates, you get something from the ptp
> hardware, but it probably does not get sync with a grand master, or if
> it does, the jitter is high etc. So in effect it is still broken.

Given that we are seeing the error ...

  ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate

Doesn't that imply that if we did attempt to use PTP on this device we 
would hit the bug reported by commit 030ce919e114 ("net: stmmac: make 
sure that ptp_rate is not 0 before configuring timestamping") and 
therefore, I would not expect PTP to work?

> 
> Can somebody with the datasheet actually determine where ptp-ref clock
> comes from? Is it just a gated main clock? Is it from a pin?

I can ask.

> If it does actually work, can we cause a regression by renaming the
> clock in DT? I _guess_ so, if the DT also has the clock wrong. So it
> is a fixed-clock, and that fixed clock has the wrong frequency set. It
> is not used at the moment, so being wrong does not matter. But when we
> start using it, things break. Is this possible? I don't know, i've not
> looked at the DT.
> 
> Before we decide how to fix this, we need a proper understanding of
> what is actually broken/works.

Yes that makes sense. Ethernet definitely works. I am not sure we have 
ever explicitly tested PTP with this driver, but I can ask.

Jon

-- 
nvpublic


