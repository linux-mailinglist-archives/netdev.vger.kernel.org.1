Return-Path: <netdev+bounces-153968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B999FA5F5
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 15:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424797A2285
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05D41F16B;
	Sun, 22 Dec 2024 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X7IFIH7I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80A1854
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734876675; cv=fail; b=ennKNLzPaowwrX9Aw3tI9nr+tpf7Zj3oVhmCfypNlcvZB8XvwcQfFqVqNKEkZjluvD3XbTB3bqpd24M2PG4f8eFpQHmOe5sYk+Zwfq0CiqR39Ufh7G8Nfg9uke/eDkhK+sPhljqhJfF/KuQzZYhLV3Wf16kc5bggGq9Huq3C/mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734876675; c=relaxed/simple;
	bh=xYdjbooIDU4QhZ8GWt+dNZo//cROc+esKZhc+oCJDqM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=fTkXfvtGsJlq4b84eJjwDG0k38pvtoSDPupN4uXJvo7d/Hpt9CRKkUWZacvYoz3H0qspQ7RlJC8N+P5s6IEAHdGNWyxUg3Za37V5+s/gKLobkBAb3NTbk8bt3zTnkOD370ALOYzJqbaGTRdp2LqQ05O1LzV6M2fIZS/r4XvfZxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X7IFIH7I; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUvE509xK0oPpizhTHboDYoXchPMS94fyD4IPo5WhcgAJge8sRHCXXubMOTxVPyUDKjaPie8bX8ubdDah6YGXF1DB/rUnUeSUui2LjR+Af6t8ZzDOkVCD22R4nDPU15J4TGS+bRbaYkM3ofH00JjYo6hp9+qlvC5T0zNmIrI0oKUbbtrxZnZBJ24JijNJMoETxDkV+t5YfHKscN61hVYZXXoPGUtffKHAX9dlJqTR9XEPlDOuMnTdl7qOdQKay6H2kgYb3XL4LPQ8VrxR72uCxaEEDyPkCjkRNrvaijERa96rkYvxvNa45YXzkA/JRyzar7rlsJ5f8/Klmuf7c7Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWWe8qmehjhxA4ncuX3U+0bGK6gZ0847X8S63UyUmKc=;
 b=IlA9FGqB0Wk/223UsusPcvDP34yT++58R4i21zplkRVf+hfu4u8cfY6GStg70Ns10msEBjKgglIeDVovpkgxmkUp8G07ZdTsmmPkrblOdwxiDX+AH/LSVWG8hgrirNlb8lqMhah/yyfY/zA2Q17cJchr6x5+HMBsIFzqUiFEyGobcNiNHBgiG3Se2lF+XDZ9qfV7tpEj+FOW0M2NFdoJj+GmrR2qKslF7jes+0GAXqDJtjGGyGg8Gpvrs4dYmlU/8DPiNLxLLxRljNtkfi9No9rEabayqJ4fe3w6Pnw5Wn308aR8P54UZ8Df5HC2ySWenKCb9VATkHEFLsWEl5TKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWWe8qmehjhxA4ncuX3U+0bGK6gZ0847X8S63UyUmKc=;
 b=X7IFIH7ItNMIB96c99aVlfNLlshn+P0oSvvB0CEU4a9ARkSXr2Nv08w7eIurxOGRTwib5Tg3/K3vwCXOtSZlto37fF0/KDsr/HGYICg8fXkHStPS5JVB7cxwLkFQuIUqQm0+OPDJTxEAjg2dJbZPQ+bj97EXHSFvmw+ASFSisw4H1OVwDp7OeCYckOX7WQ1C5qYA2SBLuouifvm/ZKJwgoj8MeRqAj2454zY5u6IW5Pz1q/0OEkIGHKAoTlz56CX9BVjY/I4Bb8HvcokVJaIO6ktr26Zj1NzeaEQQmGQWorn3355MagEl+9TMm8tEWV9ptLSS1AetOu2ob7L4MQE2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) by
 MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.19; Sun, 22 Dec 2024 14:11:06 +0000
Received: from DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438]) by DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438%6]) with mapi id 15.20.8272.013; Sun, 22 Dec 2024
 14:11:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Dec 2024 15:10:46 +0100
Message-Id: <D6IAG0OM4BCI.1SCL62SCI2UAY@nvidia.com>
From: "Dragos Tatulea" <dtatulea@nvidia.com>
To: "Vadim Fedorenko" <vadfed@meta.com>, "Vadim Fedorenko"
 <vadim.fedorenko@linux.dev>, "Gal Pressman" <gal@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>
Cc: "Tariq Toukan" <tariqt@nvidia.com>, "Carolina Jubran"
 <cjubran@nvidia.com>, "Bar Shapira" <bshapira@nvidia.com>,
 <netdev@vger.kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, "Saeed Mahameed"
 <saeedm@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: use do_aux_work for PHC overflow
 checks
X-Mailer: aerc 0.18.2
References: <20241217195738.743391-1-vadfed@meta.com>
In-Reply-To: <20241217195738.743391-1-vadfed@meta.com>
X-ClientProxiedBy: FR4P281CA0411.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9038:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 014c4a7d-1c15-4f9d-474a-08dd229271bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0RCRDRqY25jcTdSakFka3JXUzZBaGJzNEtUVTd0T2d6eUFCWGlucjdub2ti?=
 =?utf-8?B?dzJlQkJ3b2dlYVBDV3FXVGFRRG9hdy91VW14MExoVnB1WkJrWm9JcDZpOURw?=
 =?utf-8?B?cmNKMkJ2cjlkak1WajBsRFV4WUp2UVlDUWtyN0JCenB2eFZjSDBibEpnd3k4?=
 =?utf-8?B?bVlOdmJlcmxhbG1HOFZLL1NOditiOXYvWEZ5cXQzYkp3ekdJTVdzZFFzVGNU?=
 =?utf-8?B?SGtVMDlrOExWSVFxeDZvK0hlSWx1UjFVbEZPREx4MHpLZWdwWlBjMTYvdmZa?=
 =?utf-8?B?MllwZ2xPT1Q2M1h4UVZzWTE4ZUJ0czkwK3ZERXFZdEtUUk03WlJDd2hrN1ZQ?=
 =?utf-8?B?RnduVEdiMmlOYjJCV0x4YklCL2l2alhZZE01YzF5M1BWNWNVL2xpd2s4cnJx?=
 =?utf-8?B?aHY5dzFUUXpxdy9IOHh4eFlIN1hzdDN5dEcvOFcrb1owZHZpemlwZExINFVO?=
 =?utf-8?B?TGd3RW84TjVISHYycTVnMUF2OWFyS0FZQmx4YmhMVVVNWm1WaG1wY0REM1ZR?=
 =?utf-8?B?SG5zVlJDTHFQVlQzTHl6VVMzeHBtTFlBQUt2WEFSZzNyYXBkR2F3WGhuUWJK?=
 =?utf-8?B?MlFJaWtMODVrZ0pZNW5DcmhtNDFHMTNXSGNPRVo0c2xzdG1oMVN0bXRmaGhE?=
 =?utf-8?B?bHdPVGczUDRKYXRhQm9QYkxBb2hQd0J2WXJNMkFKZUFVNTZyVWxjakUwOVNt?=
 =?utf-8?B?L2kxTXo4aTEyT3lsZ2lRdVkrVk5nd2wzSUI5amFyai9rSURkS0ROUzhMK0xo?=
 =?utf-8?B?SUUzU0ZwVUNZNE5OODl5SXFFMmpVOXNHSmdzWnl5a0pmSGZGYk9lYTlkdVVV?=
 =?utf-8?B?MTEwL2Iya3FsL3l5UkhjZm4zMUdLck1lbTBXeDYxdjdUTjh6bnc0OGpZb1Rx?=
 =?utf-8?B?blNLWVUwU0Z0OFZZa1U5Zk8xaTZ3SVRtQ25EekwySjZHeU45YUlKS3R1aUpz?=
 =?utf-8?B?OTYycTdIZjJIMGliUGErM2pTdlJiamJvencrTkp4c1BQMmxCWHVXZ1VIRU1o?=
 =?utf-8?B?anlGdE5KZVFnVHA5Y3RNM2dra3JyTkdXV1hONUJKZUdGc1VrSFdyem05dmln?=
 =?utf-8?B?ZTFmOTBXNCtqUVRpKzdHODU5NXRhZ2VvL05ZcXk4bnVYVm9zYUNncTN2UEE2?=
 =?utf-8?B?ZmxleDcvZXh5ekpzcERoZ3l1YXBpcVVvVys1R3poNUErU1NackNHeW90cjE3?=
 =?utf-8?B?OUtGRzVqSXl3aVgvM2Z3QnF2YngwVTBHcWNVWFJJd2tzVy9jSXg4THF6NjYz?=
 =?utf-8?B?UGNDZjhGSFNIbjQ1MVcxRTloWHdXZHZ5RmpPWlI1R0Z2WWhvTlUvNDVmazNv?=
 =?utf-8?B?UitKTVNhYmlrOVZkYVB0RkFKcmRVeVdsYjlrSTM5U0Z6dWtOb3cwdHVqRGJQ?=
 =?utf-8?B?M0l5NWdRL25sZDA1Zk5iS3ZPN1RXY25yTC9zbktOZ2pyMmMzWkhLVVdNQTU2?=
 =?utf-8?B?MDVNcDhMaFc4NjdTY2YzNzk0emJKSXJmOUdxUGJ0VG5hd2c1MVorY0ZIa2ln?=
 =?utf-8?B?YnBpaHpWcW1sMGh6UFlVU0hQeVdaeEtsa2NhSmMrS3FKY3YvS05LckxGN3c3?=
 =?utf-8?B?RGIzR21YWlF5czg0TTdPeDRwU0h6Z2hlTG9FM2F3bmtqZUdmWldYSWFtTzIz?=
 =?utf-8?B?Q3BiZGMzc2l2eWQxNW5hR3RiWEc1dlJFQ0xiSU9uU0dHZWd3bTNnUUZyaGdr?=
 =?utf-8?B?cjhkK0xVOVMxR1RkdUEwYUljYlExYzRxT3BCVVZzZ1c1RE43WWpHRFR4MXBz?=
 =?utf-8?B?OGRKbHkvSmxrUkxZbk4zWnliaVdTcnFtVnlxdUFSMGFzbDVaaTRPZHV5UE9H?=
 =?utf-8?B?dk5ZbkRkajlFTG41TVdUNS9DLzNHSEhPbjlCc2NtUzg0T3hmZGVEeVdqbUE1?=
 =?utf-8?Q?az6NwXoXLY8R9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9038.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTRvZkpNc3cyMGExVWtQc2VsWENxRXFKNE9pRVVYNk4wNHdCSzF0bzZ1RXZw?=
 =?utf-8?B?T0hqQ2Y2dWFUSWc3SnNxRHpDN285ZUptZDArUjFjOWRjMVVMMVlodUZ6UDh4?=
 =?utf-8?B?TW9qNk1sMCtlYmFnVGV6bHhCMmVlN01mWHNqM0RKNUJFZ00wZmNqR3hqOTRJ?=
 =?utf-8?B?T2N1SHVlYzNoeG12eGkzWG1VOUtBRzlQRzNZOUFDZ2ZnUnRNSzFlUk93NzZy?=
 =?utf-8?B?MzBIK08zK2dmWEVCWkNSc3gySFhKWDZiOXBmWWNRVi9RRVNhTDNKbUlORGd1?=
 =?utf-8?B?ZHlvSHE2ZVJaTFlXazBjdTFrODBOYzZyczhEakZEWmdybXJoMU1nK1ArR1lP?=
 =?utf-8?B?VUMyUXBLa01UU0FuUTR5Wm1SbzR5ck9Ba0VwWk9pWm9KVzBhM0pKajBXUkYz?=
 =?utf-8?B?L0cwV0lZN0VPcURGNFlicGltVFc2cnhuREgrMHNSYjlJNXI0S0RyMHZUbWk4?=
 =?utf-8?B?LzJIM09JNmVlNTl0aHlQR1lkWVdWcFZvSHIvc0NBRzVaRDd4QzM4eE1NUVRy?=
 =?utf-8?B?b0pDTXVOaXg2RngwR3NkV1lnYkoyeXU1dGU2dmpXcUEyeE5QZks2NE9vVWxx?=
 =?utf-8?B?WUVoVk1uMW4zbkpuVUowcW1WL3BiSjZUU0psZ2VlbndoVC9YQU44NE90QTdp?=
 =?utf-8?B?d1RvTFRXVEErS0VVbGszb201Q1VwNlVGNGVCenJXOFVyMXhJQm95TUpMRWJV?=
 =?utf-8?B?c3Y4RWl0MnpoTkg2dXdaVWFEQTdKbHJwa0NjcFRNL2paaTBaWHlPSzJGaWhW?=
 =?utf-8?B?ZGtGLzRid0ZHcVcxTWtWNzRDQ3NoRC9iQVo3Njg4RXVOTHhkSFlySEFHL0wz?=
 =?utf-8?B?YWtDNEdUdXhzRjM2Q0xONjc5eExISnRLanY3Q3ExemtUQ0VJL3Ixd0NVbU5j?=
 =?utf-8?B?eGdzdzc3OURkN0JaZ0NJdzFvY1BESFFUNWRLR29iYTlzZVRHcG9YMWsrenpG?=
 =?utf-8?B?YlJhYjJaeUlFOW5iS0c4N3dRL1pFY2tHUi9SY0dOYk51aWdwcElzKzRkMzFC?=
 =?utf-8?B?WTd4YnR0eTV6bC9IMkNlNWV3NE9vSXhKMmMwU0s1TENuQTdQSUthc25sZFV6?=
 =?utf-8?B?MDZ2UHQ5bjcxRUplbTFmQ05wK3U5ME5qVGtsR2h3cXlSOHBsYlFxanBadDNt?=
 =?utf-8?B?QnZJSjJvTTFBOFF4WW5PWGJpMDV3RkN1akxNY25Ja2I2TTZzOGlJcTluSVQy?=
 =?utf-8?B?dE92UHQ3TmFTMnlseDlIUnF0bk45Tm1xeUYycC9QTVZINzgvcWdXOFFNNEFx?=
 =?utf-8?B?dHgwYnV1SVVoZWNYeW9EOEpOTWhkQ1FxeExPdXh2bTZtRVlrcGtrY3BmYmVn?=
 =?utf-8?B?djA1OWxCUFJmMEowMHlMQ0pLYnNXU05sMzdBMzhlSGZadGJjVkliTlRUMjBx?=
 =?utf-8?B?T3B5NVNSUms0Ni9PZnJLNG40Zm8ySVB3NFVzd1N3emZXZDMxL0l4bitqZm5w?=
 =?utf-8?B?anUvbE1TNXU1Y3FVN0JXNVRydFBUOUU1NmNGa05QRlZmRVl5dkxsMjFQNEYv?=
 =?utf-8?B?bmgzcUxuZ0kwd2l1VkRvcTBMSlBmeXR1U1BaekQ4OW1xUGJEaTBVdHBsQzVY?=
 =?utf-8?B?dUh4UGRJSVpUZmpyQmYzdm8ramRzdzBSSDM5WVZTaTRvRU0xajduaGZmWUFk?=
 =?utf-8?B?NC9qQW55bHFjckNwNnlQTFpIS0FLd081QWhIMVlLV01zaS9yTmRiZVRxNjRl?=
 =?utf-8?B?UkF3eFU5N2pDeUo4Sjl0ZVY2cDRqdEZ2dE4ra09nb2VYVUFYSytTSVV2WW1a?=
 =?utf-8?B?YUhwZ3hUOVRsUVA3bjlRemMvTmFVa3ZOTEJ1b0JFc3JIbW1EV2hiZHdhRVRh?=
 =?utf-8?B?M1BnZUJCU2RSQzUzVyt2ZWRyVlJEZkYvNk8vRGNIQVA3eCs5dDRZNE94Nlov?=
 =?utf-8?B?T09NY2Q5UXJXTjBFOHc5TGdGeDlvT3ZWb1JIbjJGNklZMHExOFhWeHgrQnJV?=
 =?utf-8?B?SUNKaFo4Z2FqZ2s0dHFuNUFySFlNTHJGaGMwbFhOKzZCcTlsWW1lekNEMkVh?=
 =?utf-8?B?dHZlS3RkeCs0aERaeTFOZDVsREFtWjhGb0dZSi8xczc5Q1FDMDRZaUhOS3FR?=
 =?utf-8?B?NzR2dmtYVTFHSTJLOFIxdVNFc1R2VlIyeWhlcHhodlFCOUROR1hMbmpPc3dm?=
 =?utf-8?B?ZlNwSnZFejhKdno3TGUzNDhTT2RKSWlXMkl2WFgySmNidDJvTDFUTXUxaUxo?=
 =?utf-8?Q?5rslkwqeukTKc7eMT8xJm8+EYMkFBEBrqiFu+qig4O8K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014c4a7d-1c15-4f9d-474a-08dd229271bf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2024 14:11:05.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1wEX56HoKudDO8nkyYhOKyNgje1mxb3jXVw96Y9PNmmFkdGIdj5ieDJ/SNIh86UWmHx7Q+hbVc0/53AxxmS8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014

On Tue Dec 17, 2024 at 8:57 PM CET, Vadim Fedorenko wrote:
> The overflow_work is using system wq to do overflow checks and updates
> for PHC device timecounter, which might be overhelmed by other tasks.
> But there is dedicated kthread in PTP subsystem designed for such
> things. This patch changes the work queue to proper align with PTP
> subsystem and to avoid overloading system work queue.
> The adjfine() function acts the same way as overflow check worker,
> we can postpone ptp aux worker till the next overflow period after
> adjfine() was called.
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 25 +++++++++++--------
>  include/linux/mlx5/driver.h                   |  1 -
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/driver=
s/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index 4822d01123b4..ff3780331273 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -322,17 +322,16 @@ static void mlx5_pps_out(struct work_struct *work)
>  	}
>  }
> =20
> -static void mlx5_timestamp_overflow(struct work_struct *work)
> +static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
>  {
> -	struct delayed_work *dwork =3D to_delayed_work(work);
>  	struct mlx5_core_dev *mdev;
>  	struct mlx5_timer *timer;
>  	struct mlx5_clock *clock;
>  	unsigned long flags;
> =20
> -	timer =3D container_of(dwork, struct mlx5_timer, overflow_work);
> -	clock =3D container_of(timer, struct mlx5_clock, timer);
> +	clock =3D container_of(ptp_info, struct mlx5_clock, ptp_info);
>  	mdev =3D container_of(clock, struct mlx5_core_dev, clock);
> +	timer =3D &clock->timer;
> =20
>  	if (mdev->state =3D=3D MLX5_DEVICE_STATE_INTERNAL_ERROR)
>  		goto out;
> @@ -343,7 +342,7 @@ static void mlx5_timestamp_overflow(struct work_struc=
t *work)
>  	write_sequnlock_irqrestore(&clock->lock, flags);
> =20
>  out:
> -	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
> +	return timer->overflow_period;
>  }
> =20
>  static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
> @@ -517,6 +516,7 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *pt=
p, long scaled_ppm)
>  	timer->cycles.mult =3D mult;
>  	mlx5_update_clock_info_page(mdev);
>  	write_sequnlock_irqrestore(&clock->lock, flags);
> +	ptp_schedule_worker(clock->ptp, timer->overflow_period);
> =20
>  	return 0;
>  }
> @@ -852,6 +852,7 @@ static const struct ptp_clock_info mlx5_ptp_clock_inf=
o =3D {
>  	.settime64	=3D mlx5_ptp_settime,
>  	.enable		=3D NULL,
>  	.verify		=3D NULL,
> +	.do_aux_work	=3D mlx5_timestamp_overflow,
>  };
> =20
>  static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
> @@ -1052,12 +1053,12 @@ static void mlx5_init_overflow_period(struct mlx5=
_clock *clock)
>  	do_div(ns, NSEC_PER_SEC / HZ);
>  	timer->overflow_period =3D ns;
> =20
> -	INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
> -	if (timer->overflow_period)
> -		schedule_delayed_work(&timer->overflow_work, 0);
> -	else
> +	if (!timer->overflow_period) {
> +		timer->overflow_period =3D HZ;
>  		mlx5_core_warn(mdev,
> -			       "invalid overflow period, overflow_work is not scheduled\n");
> +			       "invalid overflow period,"
> +			       "overflow_work is scheduled once per second\n");
> +	}
> =20
>  	if (clock_info)
>  		clock_info->overflow_period =3D timer->overflow_period;
> @@ -1172,6 +1173,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
> =20
>  	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
>  	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
> +
> +	if (clock->ptp)
> +		ptp_schedule_worker(clock->ptp, 0);
>  }
> =20
>  void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
> @@ -1188,7 +1192,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
>  	}
> =20
>  	cancel_work_sync(&clock->pps_info.out_work);
> -	cancel_delayed_work_sync(&clock->timer.overflow_work);
> =20
>  	if (mdev->clock_info) {
>  		free_page((unsigned long)mdev->clock_info);
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index fc7e6153b73d..3ac2fc1b52cf 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -690,7 +690,6 @@ struct mlx5_timer {
>  	struct timecounter         tc;
>  	u32                        nominal_c_mult;
>  	unsigned long              overflow_period;
> -	struct delayed_work        overflow_work;
>  };
> =20
>  struct mlx5_clock {

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos

