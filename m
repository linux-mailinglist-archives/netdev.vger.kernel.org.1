Return-Path: <netdev+bounces-165209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0DA30F47
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113E87A0706
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540CF2512E7;
	Tue, 11 Feb 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PkMHWut/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6E3D69
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286574; cv=fail; b=CnDjUGdgEgLN+5524woGVpyWFlrZATwtBCuEklViatnTMIywute5x8Dh2dxNMtZJJ+x8lLPIGkBNRUI1LWure9eeHksnQsff/ghgUJ9pziX5vFx0DolWbJE4pCeV83pG3oZL9GCoqHcadXoKW9mHr9uZx4+bJFhj6wUQu0C+XeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286574; c=relaxed/simple;
	bh=a4fVjMsw/SgGJh8eHoSPw8USgMbNCBnCD0yO4puxhVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YmcFvKGOUGjosnb466e8sBppSDenBfMSHzWLrWGBQ4CbljOa06yqHzQxgOzlTMubjF48h4qlOMeys5wZ0w5bmxum77KH4Ayc3ofFvb2Q93BpDGqlnBYpCoezp3hJL5v4rYfVlqgiK6k95dEGYzEwMbnSExvABvVH1/8NQLMSgw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PkMHWut/; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5xGA5pYUCocOafdHpnFepD09WEgBB1s+FhGg2/2qRGpiLG+GN+saEugsQODCdnCcgluAjiA7lgMP1frl5YCbis1I4cYVeR6A6UKs8XoUGhx0fKaiBdO6ZpmrLvkSuVitF5q49G6Y+fkN91h2+FP0riAWBVhOsOqNu2zo/rEP1x47E+8FDFP9b4Mig5uZ+byMjNQJKrg8bIz1Mt2640eFPSQvlpNVrgxu9zzP1b3iNRgDt6diGxe7PFRvmq/nfXMyjCR6uLRqN5gFwZgRY7Vm002im+VM7eILi23UDCHWd3NoGLrefCSOpnQs4YES8gNAoxKUkasTfChzU4osiNhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t62VDqDzF3H1w3UM9AIn7il/Fbd9FXz4Zv3s6wQWrWI=;
 b=kmyKcTy+A2U/V0W+7TraGMvBqq/OXQ+RvN6UZHKdGbxXRDR081hHuR9H0LlWF3TPPhMlg8hznuX43/kRKKr4pL9JU8/SrYnOMthKPEcWQgVgsAm5OOqIYNrm3zPVSXQH2cvSheq+ClFXs6rzON3FX1Rs7SAJw7VgFKK/YAC7/iHTAkM/Jduo6ywt93+wbqntfDhJ7ua9AnNWQuZ6VORAL0318oyPLiLzSmrD79RsYrqxgzGRk4Yr+gRNFbyX0tvIoWnJo4HXhZVc/z9BQXIoPHjk/EiV3Eosfo5szFOPyxV1O5pXa4C0dgxlWHYp5qVi9KHQvcOKvmhLPIbFG7oauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t62VDqDzF3H1w3UM9AIn7il/Fbd9FXz4Zv3s6wQWrWI=;
 b=PkMHWut/RqY+Y27tLIB92YyiQfUBUiVKAQlCH5vVyjP+YwqamFfK47mcWYsG0VxYeWHKdZrM5RXJK9LykrlJckk7rswyglL8yOEtQ6s4UjkvYNUnBwVdrM+Lz8wm0SXXE84sPfLxmflx1aZqz6+wgOPWQhLnM04wB5FXJ5tz65hBlQqQ+Z09IFzd+YoRvoZivP+jOsnTrmqJZnmLPU4UMouElqY2WZgJ5kCYX/dW8KmLEYjsXy+Vw4sY2ppd+ex049rtTS67XE5UWjt3f5/SrjF63p7C5pD9Gc6gLpJujG/ybmXK6lvZrevsPxFCkGse9s/9lcqpMnet3+a0EWDUqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 15:09:29 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 15:09:29 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org
Subject: [PATCH net-next v2 3/3] testptp: Add option to open PHC in readonly mode
Date: Tue, 11 Feb 2025 17:09:13 +0200
Message-ID: <20250211150913.772545-4-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211150913.772545-1-wwasko@nvidia.com>
References: <20250211150913.772545-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1152cd-7221-4cb6-a622-08dd4aae14c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWpudHpaTGdnYWw4d1NUUWdMcDJPVFNHZG9tZVc5UEp5dzNXSnJDazFwSXND?=
 =?utf-8?B?cDVsVGxoRDVxTUl3TG9odmc4N1J3a3R0ZVJKbzIwM0l6NUEvREZQNEVNVFNI?=
 =?utf-8?B?MkZBWk5HSzg1T0Zxc0ttOWJ4YkVDUVByK3BSVmxYcmVhNEpXc0xWUnhPRTVq?=
 =?utf-8?B?bFM4bUhOVXJZVjJ1Z2NXK21LQnV1YlJheTYyVno2OXJKUkRpNkdrTzF6RnJU?=
 =?utf-8?B?Y0RBbk03dXo2ZGNBQVFFVnJ0QitLTUFlMEw3WnhwYXprV0o3dDJaUnRuN2Qz?=
 =?utf-8?B?TElxRW1DWmM1VFJPeS9aRFF5UWQ2dC83dDlWVjR6Q1lmUkJSVG9TcDIzSlJI?=
 =?utf-8?B?RVllWUJ3anFkSlViajdDN1FvcjR5NnB4NmFQVmxWZHpUZU90N3c2NnZoNGs0?=
 =?utf-8?B?Rzdic291NWcwZmgrRjVqWmNOTVR4Qm9sMml1ZEVtZTFTZ2I2azdkczBwYzJJ?=
 =?utf-8?B?Z2d1VW4xSk0vOWYwQzNNYVA2TGlSQ3hGQkMrQmVUVmpUVTM0aHVzbXZ4dFo4?=
 =?utf-8?B?R0JTd2ZiZHYvSTR2Z0dOTStrVFdienhmWVZtbkFFK2t3UStydGhCSjVxbE16?=
 =?utf-8?B?UzhMNTBKSi9MTVJ2cWU2RnJVUGdiS3Q2b0VCV2NJeWFCYWFPSWMrYWZDK1ly?=
 =?utf-8?B?OHpCWXlGcEJqdllFRlhPd2xKcGFpS1Z5cnN2aE5FLzJYNHVlMERlYWhGaU5o?=
 =?utf-8?B?TnVzVzdycXRyOHlaRyttLzdSa0dKWXROQjJzZjIzNk9rWnVTMnhTUEJieGNP?=
 =?utf-8?B?amtaNVRsTW9TUVdsLzZsSU5VZDR1bDdHN0dxTjZFcEtVbjRRQVBJR3p6Mnh3?=
 =?utf-8?B?emgybC9yMGZoS0l1d1V1SGNTV2FmWmFPQzZVV21pTm1BYWlCa2lvK05wc2hB?=
 =?utf-8?B?SHdGMmxGMlYwRDBaakZoVjVQSnNoZlNKK0lsR1hJRFVaWFJTQVRvVjVkNVdQ?=
 =?utf-8?B?bDBBTHFlTGZoT04rREtLMW42c09FL3REakFqWkN2T0ViQ2V6anJGUkdwZ0dw?=
 =?utf-8?B?dXBLekhZMUN5R2FqUHJXczJraFFISmlZKzJlZzJBaFg3MDV6UlA0L1JEUTlk?=
 =?utf-8?B?WVl1K0o5c3pjUlpRbGpnZ0cxOVpFZkc1a3N1L0JCc2ZwZ0hBU3NPQXg5cFlC?=
 =?utf-8?B?MkdBZDNSdkM1bnNrUzN6OFF2cTQ3aHdrbzRnZ1Z5L0kxY0pyZTJObGd2ejQ1?=
 =?utf-8?B?RGpURHc0WWk0YWxROVZiSkJlOHlYUFNLTVpGWGc4ZkNMKzhtU282NnlSdGo1?=
 =?utf-8?B?SHQxTHVUQnlmUkpraENlN3JkOWJ3eXFMUjNQU21jY05ZZU1PWG9LQlBxRzAr?=
 =?utf-8?B?UmJMRS8xN1huc2dGUWRhazRXZTNqeDVKMmltbU1TVHlpQk5KTlE3Vmx5SmlU?=
 =?utf-8?B?TVFyeUkxWG1iTEV0b2xpNFNRQllJSmY1ZzdkamxqSGNXQlNwZ0gyZ2FuK0ti?=
 =?utf-8?B?bVRaY2NoK0tCcGVTS2F3N3AvSDArdVlyUW4zTGpTaTEySUFoaXdWWGhyYmdG?=
 =?utf-8?B?TVp2QTFJVC9MeUlWbmR1Z1phcUszYUJaaFlXOUN3bW02bFJkb3pPSHg3bmlO?=
 =?utf-8?B?R3NOOW02NVA5eVNMYTlBNi93aVdpODFIMS84cy9JdThQbC9UTlp1N3EvQjRH?=
 =?utf-8?B?R3lWTGpzSC9tV1hIbkgrODdPZ05RVU16a2dZTC8rV0FzVnZkaGN0NVlFcXIv?=
 =?utf-8?B?VkpQVEJuNlVTK1BjcHRKeThzbjl5ZEF2Q0NkYldTUmdJUmhnT2xVYzIxUmlZ?=
 =?utf-8?B?bGtjd2l4TzRHN2E2eUlubThGT2g2OExvMElTVE5rQVJTazRYYkgveFBhRm9E?=
 =?utf-8?B?b1ZRSnJ0Q0d0cTN4MGNwQ1ZaSVFvZTFiYUJpY1RtWWVHb2Q5ZktrSmpteTNn?=
 =?utf-8?Q?UmzpdH6X6KTnJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0pOenMzY0NDY1FmdjQyaHJpa1MwNjBvZ3E4ME8wSzlSVHJsNnBubEllTzY1?=
 =?utf-8?B?cnA1NzhsOGJMS0d3dDMzRS9JenZBa3JFNXhvczhWWG5SZDhkY3pIb0hGb2RK?=
 =?utf-8?B?RTArOWVIQmZvQmNHc0lsY1NKN3kxMWVENzI1NGh4SHhtQjBNVmNGQmZIZyta?=
 =?utf-8?B?M25FaHlSczVYSWdjYkc3U2dFNlZRTFBSaXpCODcvRjdRZDZSMmQ4RWFOaHY4?=
 =?utf-8?B?WlRVMGFXeUM2TU5xT0UvRU5KWnRaOUpieElkMC8xa0hBaTNIbm11T2JoVjZ6?=
 =?utf-8?B?QjB6SThlMWlvNW9SaC9PUm5lam5jMi9jSmZyWFZMYXFMbytQbHJQaXVQdGV0?=
 =?utf-8?B?Z2dKdWJHblNielpkNEs3enkwV3J2TEVwR3ZkVkJodTNDV3dMOW15bnlLOWtE?=
 =?utf-8?B?Y1NRMXhGaWx3b2NDRzVEak85NS9CNk9HVVNHamZ3c05lYTFBRGhZRDlFaEh0?=
 =?utf-8?B?b1IybVVrcFQ4cjd2N1ZSYkFtTTFrSUVOdHF6YTdnSHhvcDFXcHNmMTJ5Z1Ro?=
 =?utf-8?B?UExTMWI0Rnh3TzI0Z1E4WFYrWGdoVE94cmtlcmNBNnFYZjNlci9VZCtnRk1C?=
 =?utf-8?B?aDEyMVlyak1odlhvOU40UVpNZWoySUNoenkwdzA1cWs0STlkb1N3U2Frc01r?=
 =?utf-8?B?Nm4veWRId2VsQ0pHN05sNmZwUDl1elY4bmdYSVl5TTF2b3JoTHVDWGpEWmRj?=
 =?utf-8?B?Nk9IaUx2eGZpVVRvaHU4UUxRWEpseTN1MDJ6RlYvOHpQSm9NVmk1LzRDUUpS?=
 =?utf-8?B?VVhTbUROdzU0WTRUN3NnY1VWNDFsNzV0b2VyWTFLcytBM3p1T0h3WC9MQncr?=
 =?utf-8?B?VlJNQlVTaHFNMmlOdGdwdUQxWjYyS3o4ZUJSTHdUd3d2RWNpQjNJM3lYM1VX?=
 =?utf-8?B?RW94cTRJYnVsdHNnM1ltdHZyWHBHZkNlRHpPMVdka2huNU41Uk5obS9UNXZG?=
 =?utf-8?B?aE1XMklTR3AvU0tLSGdQajB6QXA5b3pkMWhBWlNsVVcxb1VzRGNuOVBHQ25v?=
 =?utf-8?B?QlUxcHRmMjJzRFNKNXd1RlJrS1R2cG9JZWMrWHFmaXpUUUQ5ZlUwZWNVRnEw?=
 =?utf-8?B?T053Z0hSYjJZVE05RmgzOWJoOTY5UDFoQ3FHaWdrVk9NTlNWY2lRRkhxazJU?=
 =?utf-8?B?aldMV0VVUk5FQXBLYzNmUGd1QmZCQnYxL3M3N2gvVncvSkJwVlpJTDVWWm1w?=
 =?utf-8?B?djc4a0tSYmVtdnFGOTUzZmtzSkdER01makI3VFh6d0lzNjM4Q0xuYUFqdXRa?=
 =?utf-8?B?bXNzUUdpQzlaMUgxMkdvZmROQXp4M3FKNTZubkdmSVBuR0dqK0tQMWJBRnRy?=
 =?utf-8?B?V3QvWmZtSmhzUE5BeEx3aElmT3B3bkZFbUVuVmtzUHFDaEpMam9NZC90ZStt?=
 =?utf-8?B?OG81MnBXMFl1OGhIZzVERmNmYTZyb2ZLMUVkSGhwYlpUL1JQMWQ3VTlyUDIx?=
 =?utf-8?B?ait5dXBmQU1XK282YTlwcXJiWE9VYU0rVjg1UWNmUk5oU25ZWjR5blh2Vlkv?=
 =?utf-8?B?bzFMZDE3Q1dYY2JSMzdEcnpRaXhVb2lHVCs2UVlEd2kyVG5BTUpSdm1yTm9N?=
 =?utf-8?B?VmpkZmMvOFJoMFVWS0ZkTFB2aVJUd3UrZFN2ZlNUblBYc3Vsc1pkb24rYk5W?=
 =?utf-8?B?dEZESEd2VHlHUG52VXhYQzlUM2xSSGVpdm9KTDhSM3JnRTloV3AyL29ZOWlh?=
 =?utf-8?B?UCtxd3piaGY3d0RMSDBDUDQxdkd4SzBhOHErNHkrVS9xVFBhZVJLaXFIUFIy?=
 =?utf-8?B?MUMralpraWxjMjVMa3Jqb0ZHMWVFR1hCSnJjaTNRaVN6SUoyYUkwdUMwSUpN?=
 =?utf-8?B?b21XRDBoclk3bnY3aFhaZ2lxcmg2eEZIOU9pNnVwY2t1WHNseE05TXFVVVBG?=
 =?utf-8?B?WHM5aTJqOTNFcXJ0MFZXU29VY0R1ODZRQWRJWlFQcWh3cDM5RDRaTWtUUTZL?=
 =?utf-8?B?NTd0cmo5WVlFTk43UFZCdVcwbVQ0UlVScW9BdkJpZzJtalRycHVaYTJCeXFP?=
 =?utf-8?B?Ym1uZDR0d25QZC9iY1plVC9HZ255QTRzb2dHZllPakRaTktzTEZ5VS9ZUk5H?=
 =?utf-8?B?WDM4cy9SS1VueW9yaTQxVCs1azlMam94SXNuK3NsS2RRMDJTclZxNi9kbGNs?=
 =?utf-8?Q?ejFUELcA9h/2fV/MK4qw/cnLj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1152cd-7221-4cb6-a622-08dd4aae14c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:09:29.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXt/x4UUQx/GOhC8nS0N/iPTxpDDR7QYrYe6FekMx87pb1kHZaASO0RmnYaGaZrLjtZIuPQer6uB5u+ZMftdJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264

PTP Hardware Clocks no longer require WRITE permission to perform
readonly operations, such as listing device capabilities or listening to
EXTTS events once they have been enabled by a process with WRITE
permissions.

Add '-r' option to testptp to open the PHC in readonly mode instead of
the default read-write mode. Skip enabling EXTTS if readonly mode is
requested.

Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 tools/testing/selftests/ptp/testptp.c | 37 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 58064151f2c8..edc08a4433fd 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -140,6 +140,7 @@ static void usage(char *progname)
 		" -H val     set output phase to 'val' nanoseconds (requires -p)\n"
 		" -w val     set output pulse width to 'val' nanoseconds (requires -p)\n"
 		" -P val     enable or disable (val=1|0) the system clock PPS\n"
+		" -r         open the ptp clock in readonly mode\n"
 		" -s         set the ptp clock time from the system time\n"
 		" -S         set the system time from the ptp clock time\n"
 		" -t val     shift the ptp clock time by 'val' seconds\n"
@@ -188,6 +189,7 @@ int main(int argc, char *argv[])
 	int pin_index = -1, pin_func;
 	int pps = -1;
 	int seconds = 0;
+	int readonly = 0;
 	int settime = 0;
 	int channel = -1;
 	clockid_t ext_clockid = CLOCK_REALTIME;
@@ -200,7 +202,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -252,6 +254,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			pps = atoi(optarg);
 			break;
+		case 'r':
+			readonly = 1;
+			break;
 		case 's':
 			settime = 1;
 			break;
@@ -308,7 +313,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	fd = open(device, O_RDWR);
+	fd = open(device, readonly ? O_RDONLY : O_RDWR);
 	if (fd < 0) {
 		fprintf(stderr, "opening %s: %s\n", device, strerror(errno));
 		return -1;
@@ -436,14 +441,16 @@ int main(int argc, char *argv[])
 	}
 
 	if (extts) {
-		memset(&extts_request, 0, sizeof(extts_request));
-		extts_request.index = index;
-		extts_request.flags = PTP_ENABLE_FEATURE;
-		if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
-			perror("PTP_EXTTS_REQUEST");
-			extts = 0;
-		} else {
-			puts("external time stamp request okay");
+		if (!readonly) {
+			memset(&extts_request, 0, sizeof(extts_request));
+			extts_request.index = index;
+			extts_request.flags = PTP_ENABLE_FEATURE;
+			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
+				perror("PTP_EXTTS_REQUEST");
+				extts = 0;
+			} else {
+				puts("external time stamp request okay");
+			}
 		}
 		for (; extts; extts--) {
 			cnt = read(fd, &event, sizeof(event));
@@ -455,10 +462,12 @@ int main(int argc, char *argv[])
 			       event.t.sec, event.t.nsec);
 			fflush(stdout);
 		}
-		/* Disable the feature again. */
-		extts_request.flags = 0;
-		if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
-			perror("PTP_EXTTS_REQUEST");
+		if (!readonly) {
+			/* Disable the feature again. */
+			extts_request.flags = 0;
+			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
+				perror("PTP_EXTTS_REQUEST");
+			}
 		}
 	}
 
-- 
2.39.3


