Return-Path: <netdev+bounces-167513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5937A3A937
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935DC1898BD5
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3F01F4195;
	Tue, 18 Feb 2025 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2oGGqop"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F11F4199;
	Tue, 18 Feb 2025 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910400; cv=fail; b=k7c4Conet7Ko8FzMA5Pl9tOei31uHKuxCdrr7FhRfrCGqjBmozXFgVbGUHxJ4iPZKKPyTRAyg364TTHAukCAOe9prkO7CizrZbfM2fXb4dJrSKSmK+iHkQxNknoU45WETsTu78PpfUo2fJT25lkOsWeCxqkNxUzk7uQ5lBvWqfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910400; c=relaxed/simple;
	bh=NP2fllgVRvO1dF/5x/4f6o5pYSGKi9WYpBFHNshd9Wo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s58fBiv2fz8cPg/SGdVU5hSOJQc2BlBD7Fg8O5o8voV3GBZJorp5NdL9HexO8gxeM9tSzkp4Adf8SUUyjwFc7f6sYwoPMtIODt8n2rLdDZ1nL0k2pIp27A4Ys9Yj6U6eMR07m+9XzFGLnE+mR+a1M9xdMA2415T8vIqTmh2TXQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2oGGqop; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFRyy54CFF9y7X0zO72896fM3xTr80oItJt3xaX57H43jDgnmdztHEd+ofDMNWtLsYptWAo0WJ+Ju189Ytw8QTzmvwc9qPoHnMRyUnA2MNM4A+BmTJ+0slMmW4MMZZqdofXQUSPJn3PX7qAnbL4Dh/sWav5pYfDEZC/5hcyDjsndARTHQoT0S5J7I4r4mML/sWIiyfBNFPG/zoOLQ6tkZvsNZ5pog+/QgT9zum70cq8K+pMJY2wxNAsXTQDkVuW+EhKuEWhbQh7Kd3LIDzNgivdycnIc3hyReTv7wv0oPRacGSH/cOw/ngRAQy7kS0H/D+3kpxf6wOaLwuWaqqjK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amuv3d97S2ZjiKOd/8q0T6PNHXeWkhzdMMm97BUrE6E=;
 b=Nr65uCpUajRNZdArc1KGzfqS/JN3wJbEl+LJKzm2iKO+Ji+ZXlCVFZndJZMKo5CIa3GY+ceg34DS0kOeERUdsSAg+B7nV0/UzXKhwCpxWmhaeOWmNgKO7+rVAbqlpMBg91OGhkhdWnuo2xm1C8Cgagg8Br07yK2KX9r1wIdGGxDVv7wlQzBbXNQdnyQhQXQlD7dmRGL6NQ2GI4J5fka156JjlQLhlvBAvOrifZ8AT/vFGAsI7pRZ8b4TFMOVdbO5b1n59HO0mRRBfvO8GZtjB9yspc7SpVKA4xtc4nM6oFsXSIayQ2fFhljLfVxiCuW64IJKzxPHKvr7DYUMnc1q0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amuv3d97S2ZjiKOd/8q0T6PNHXeWkhzdMMm97BUrE6E=;
 b=s2oGGqopp1Ju5ani+/d1Z+0q9iEPNok0z3AnaI0JnUW+Y7QSx9WoOVCeor9wCOhP6VEuWQgO86IBI8Baw2QyhLRIlP0uBMNQVx/b+g2tdehkSngSKeV61QBj5TJ8kuvgxudRZ0GZWipKhj7TfrjTOdqwgD/KDJzK/LqVVIjbVtySsO97xpvBWm/I215PXpWTuJT+cS3U+yqx1VKWGiefN8HZShO2yIk8Y1R4yF82QjGuNlv56NqBdtrKZjuNGPmJxLcflfk3L4aZlSNsUOcUzpxorU9Z+No7J0mFQ86pCJjDzPjnkv9+OcFM4ZAsFDVRxDP9zbFY+MW7JakmYmm/1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 20:26:33 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 20:26:33 +0000
Message-ID: <9eb3db1a-514b-4fcc-8318-7af0bd0a62df@nvidia.com>
Date: Tue, 18 Feb 2025 22:26:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] selftests: drv-net-hw: Add a test for
 symmetric RSS hash
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 linux-doc@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
References: <20250216182453.226325-1-gal@nvidia.com>
 <20250216182453.226325-6-gal@nvidia.com> <20250217161954.57fd1457@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250217161954.57fd1457@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0018.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::32) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1bf36f-390b-4ee4-0edb-08dd505a88cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnZpUjM2VXR0dWlhdjRpR0ljOUtKcU9pU1FpaDJYc20xNEk0emdheXV0QnFY?=
 =?utf-8?B?QkFJZm1oeDlwaHcrQllpZXljbVFnUWZ0YmEycXBqcHJZa0FNZTNOT1FvbGxM?=
 =?utf-8?B?YlJ0Q1RucjZobW9KeEgyTENXRy9QM1VxTEljam42emlBdzJZOUxiaXpKeEls?=
 =?utf-8?B?Qms1TTVUa0J6Lys0TFBCdFBJMVRLY1VaZkNTcS9CMlU5Rk1tNmxkd3dWeXFV?=
 =?utf-8?B?R2pSTFJuMnd0aFpOb1d2OTlrRnZuMERtU0pZMlB6Y1dnYlN1LzZ3NG5JWjJD?=
 =?utf-8?B?a3V4RXQwMVJZS2VoQnB5RVVVTHBVNVJvNEZIQ3p6dnVab3NEdFg4Y0dqYXNi?=
 =?utf-8?B?SnI1RUVyWmtVNVI1U2JBWkpmMGNnaXFvSGt6WFM2VThTYkxFTExsVGQrZUg1?=
 =?utf-8?B?ZlM5OS9uV3kreEVsWXJiYzJHQnZZVUZ6WTFSTWlVUmk4eW1FNFNpczRvNWxJ?=
 =?utf-8?B?a3djbVVrdU9JeXpnclMyM21qTFN0VTFvNUkyTVJDRzFXUzNVY2NpbFZYNGF0?=
 =?utf-8?B?U2pzS0l3MEkyQWZ3WjRNRzV5WTVMNW5Kb0xMTjc5U1RZZmc3YnU4eVUvb2d3?=
 =?utf-8?B?dTJabnIzY3pmR1hLUXB0ZFVQYkFiT05wYmp0VWd0QlE0TVdjSzEzdm1ySUJv?=
 =?utf-8?B?aFJSYjJZN1hvQ3JDS09YdWF6RWtDOGROUUpmQlVUSUNteGc5SnpzUUR6NmJk?=
 =?utf-8?B?N1BjL1BxRUkweWMrUlJza3g5bnhnbm92bE8ySWgraVpvSGUrUDlMYzR2T0N6?=
 =?utf-8?B?WmFiN3BQK0RXbWF4OUZUNjhySWFva05UMmREWUI2SFB2MGxscDEvcWVjRkZr?=
 =?utf-8?B?OEVpaFdwSEFXUy9BSHBIVWF2Z0p4d0kvVkV2WXFjMXo0WWkwUk5LRjRVRkpa?=
 =?utf-8?B?QnV3UTRVbW9OTS9aVXFmQ0tKbUs5NjhVRXRkanBLVUozMjM3ZkRQVWl4S0JN?=
 =?utf-8?B?OGhNa3ZQcHhrU3VFTktVU0VXZjhJQTdGRmhEQ1FQSk1UYVdxenZXMDA5VDUy?=
 =?utf-8?B?NXFyN3M2TTBMNW1laERjT3BqSTNoWEtUTFJlVnFNTVR3R1k0NW5JbzhDTlVi?=
 =?utf-8?B?WTlpY0VyN1VOMzJ1QnFBOWZXT0F2RzVmck5QazcwVjNmY3RRMkI4Ui9KOGJS?=
 =?utf-8?B?aXlCS3drSU1sWld6Q1dCUEpmU3Y3YllaTnJtTHZKbm05YWplejhuT2pHOTBk?=
 =?utf-8?B?QXZZbDArcE04OXV0eExLK2RiYm1aay9tQjg0M0RtUzd0U00xMmg1UW4rdHc0?=
 =?utf-8?B?VWdrZ3NGcTJocHJYd3FCMWhOczlqTDJhVkVhZjdIdkxMSG1GNmIxdGZKTkts?=
 =?utf-8?B?UEt4OGZkdS8vUUpDLytHWTFIYVg5aXFZWWN2OGJhNFZpVkFUWkVpVlQ0MVM5?=
 =?utf-8?B?RDhxQWtGTC9OaDB2dGp2VUhRekRNNVc3QW9KQmMrSElPYTYrK01vOFJRZm9K?=
 =?utf-8?B?UDR0eXFzMVZnV0lwOCtIQUVvY3VFenpSUWdxOXFFVEthY1I1RmxXWU5lamFw?=
 =?utf-8?B?cVZrbDFtZGhwL2dDeVdHRnBveUN5VmdLTmtKY2tGOGI3T2NOeGtvUjlpTDF0?=
 =?utf-8?B?NGJvVkdzbTA4ZFJJUEZIdnNjTHIvS3g2cHdOSDJXMjN6UXJUYm1nRVZnQkY4?=
 =?utf-8?B?THBZZG1xVXZBOUduN0hIeEUydkFQTmVZOHJCMXpmTjhwWlphYWNnR2IwZnlt?=
 =?utf-8?B?a0FhN3NIZzVmOTdieWNnaU9hOHNhTXNQNHhKV1VVeHk3QjYwZVN4by9Cd3ly?=
 =?utf-8?B?WmhDMkJQaVY4SzByRzJSQ1k5UDFIc3hNY2ZDU0liMlcweFgyY2lVTHg0U1dW?=
 =?utf-8?B?OE90c3ZFTXkzVWFySUVZR2tnVGNJZVlyUmNtTGw5L3NsVWU5V1dzQ1JRZDNq?=
 =?utf-8?Q?M8kkHbtwqnf+A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHczdWEyckJsOUVXRGg3TENLSWtlMWpMa0xsaERXa00zVGVKNTRpd1RabzZF?=
 =?utf-8?B?dFFlaHhWcURHdm5pVXdxSWtUMXB2YitoNHliTzNqRUVzOUFKM3dGYVU3OXg3?=
 =?utf-8?B?bllhbkhnYnBHV2NRdVBGUnJmdHd0TkRLR1M5Rm44OVF1b0VicW4wSnZGeVJJ?=
 =?utf-8?B?Q0dtR2J0bllYU3RvZCtWSXhONENzR3RCYkZCRGt3ZGdWbjlON1FjQlpDa3Vh?=
 =?utf-8?B?SWo2UmJNL094U3pNb2Fna2poOWdyZlJpVlUxazd5OWx0Lyt4U3pOYUd4eG9B?=
 =?utf-8?B?WDd6UHRUQ0h1MnVUcXlPS2tMU1U5REdYNUx1L3Q4R2NjN0NoOExVQUpxdHpK?=
 =?utf-8?B?eEJzc0pjSW5Gelh2a0Y0Vys1cWR4QU9SbkF5VEUvLzhTcGZQRUp4NlVmY3NW?=
 =?utf-8?B?MzcvSDlEUDE5TjVlaHY0bHVFSC9YaE9BeStodXpPQWdyR05RYWFHdmhOb0VG?=
 =?utf-8?B?dVVyYnEySnhZeFFJUWozb0xlN0JzdmxzRkpjR2JlVUlqSjd4ZkwvNWpjM0pV?=
 =?utf-8?B?dVNnTXpDeDNGWUpSOS9uQTZVUmxMbmhFdW1uMitpejZVUk12WElMREgyUnRp?=
 =?utf-8?B?ZVF4YVhSajVvR25kRzF4bXhhcHNxMlNDTWoyL2F2K3JaYzAxNkpFYlF2NlZM?=
 =?utf-8?B?VE1rd1lnMzhoQzlXVFBJV21yQWtabjl2VXdIanlrYlFmUnFkbGZrTjRyN2Jw?=
 =?utf-8?B?bkc5Z1YyYUgrS3RxRERwalpPcW8rZS9RRXFTMG9CS3FVRW1IR1dGMVNlM09C?=
 =?utf-8?B?bVoyWlh5b3NmbkhyN2ZhalpLd1J5SmpGdmJnQXByY21wWkprYmpSUVR3Z0V5?=
 =?utf-8?B?THBJYVN4UUJPNTI5MGFXbk5sdzZHd3REUUxLTXJnN0U3Q0JDRk9NamVnVk5y?=
 =?utf-8?B?SnlnbDVFT2R5T1dIQ29sT1pSVk85L242SlZYRHlpVStCRWRXSUl5RGcxS3JM?=
 =?utf-8?B?Sk5kMVJxRGxlbjlybXNxcFRSMTVQaHBJZytMQXhCVDZJQjRQRDJDeXdCREYx?=
 =?utf-8?B?MHBWWGNUem5VYWNHOWJpa3VzUGtNbmtvbHNVMElJT3IzMGlvT3NUcGFzSWo4?=
 =?utf-8?B?Y2I3aG9MVDhMRlpNemxHSTNDdFZOUHNtN2x4c0NPTkdtTGdRVDZhdTQxYWpo?=
 =?utf-8?B?NkFkUWVyZUc2djJOdGVxYnRPdFlyYWFmak8wTEtVdGxuai9KZ2NXNDRmajJv?=
 =?utf-8?B?RWNkbXdjOGxRZURxYlpmTnQycXkrWFNZSWNhNzU4TTdPUjZDZkwra1d5R09i?=
 =?utf-8?B?MmtMZi9pZHZsR0hlZXRwUDVRS09vNm5oL29rS003UTBVV1hjaVpmdUZzYTE5?=
 =?utf-8?B?d2o2bWtCNHp5V1d5RkpEMElDcUlDOHJpWGgrSU9JQTdoNVN6VWlkRVdmQkN0?=
 =?utf-8?B?K25xN2J2Y0JwZGNuUjNzN1IrRDV5TVFKLzNzWXdPOUFCNHdKb0FyaWduY0pw?=
 =?utf-8?B?YXRKUUFLVlliU2JEbXRKdlgxV1krQ2ZTUUt5STJKQzNhWGdaUmcvM0xUZTZM?=
 =?utf-8?B?eUNrRlFkLzZEcWN3VnhxUjh1ZkRmL0pJMWxaMmd3NUY2Z0JxWTE2T1o0ak5G?=
 =?utf-8?B?Q2xUc3hoN0lSOVNBNzhXSWJWb1ViZ3JWQ29kZk9yN1cyQ1hHYnlxK3RGSDBI?=
 =?utf-8?B?Ni8rRkNzRm9zOG9wK1M1cFVKcEZERHR1WWRBdFJoeUlwV1IrY3F2eGpSa01L?=
 =?utf-8?B?TVh6Vm5kd2gwT0UrOXVtNmRPRHExMExVOE5SbjNkYUovTjlhZHI5bmdBelY0?=
 =?utf-8?B?ZDBUenBqK1ZDQlVNNVJVY0xoam5kV2tYOEl5STNMK3g4OTdWVWFMcG9zUTlj?=
 =?utf-8?B?YWdRV1IrNGFwTG9jMzdMRGFhcndUeGU3QWZpM3NSMVN5SFBSMGI0RUJBWHJm?=
 =?utf-8?B?aGh6MkpVSFkrSllQZmRxSWcrbmdFdGhJdTgyN0phUHhUNE1RU0JBUzdacDc0?=
 =?utf-8?B?OFpoQXNnTmZQOTFBa1dmdnN0U1hXTzhHOGpvNGhYSWdWN1llUWVMS1Irdm1X?=
 =?utf-8?B?TW82emExbWlUK3Y3TDEwTERtUnVGaUpXeFJsWjRhOHNFN0JqWExaRkQvQ05W?=
 =?utf-8?B?SVgxUGVUL2lSNlpvNCtRMUNyaHRZL3dhRGY3Ky81c2VicGR2QWZITjJqQklE?=
 =?utf-8?Q?wUho=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1bf36f-390b-4ee4-0edb-08dd505a88cc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 20:26:33.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm547K91FGo1p/YDlw3ZDWaL6BrNWzzHlMY7YBAZ1F5rGwSqChnLTJbOIZarw19D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035

On 18/02/2025 2:19, Jakub Kicinski wrote:
> Wouldn't it be both faster and less error prone to test this with UDP
> sockets?
> 
> 	sock = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
> 	sock.connect(cfg.remove_addr_v[ipver], remote_port)
> 	sock.recvmsg(100)
> 
> 	tgt = f"{ipver}:{cfg.addr_v[ipver]}:{local_port},sourceport={remote_port}"
> 	cmd("echo a | socat - UDP" + tgt, host=cfg.remote)
> 
> 	cpu = sock.getsockopt(socket.SOL_SOCKET, socket.SO_INCOMING_CPU)
> 
> Run this for 10 pairs for ports, make sure we hit at least 2 CPUs,
> and that the CPUs match for each pair.

Thanks, I can do that.

> 
> Would be good to test both IPv4 and IPv6. I'm going to merge:
>   https://lore.kernel.org/all/20250217194200.3011136-4-kuba@kernel.org/
> it should make writing the v4 + v6 test combos easier.

Should I wait for it to get merged?

