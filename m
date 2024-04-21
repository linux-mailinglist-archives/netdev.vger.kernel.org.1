Return-Path: <netdev+bounces-89872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DCC8ABFB4
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 17:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56911C2039E
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5318030;
	Sun, 21 Apr 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pY6/V6jn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4A17BA2
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713712903; cv=fail; b=vDTFNV4vmwU57AzsSSwnpOJMf0HXhKewnbti03fkAeF4JPjiqjNtSNQbzENKNyylDsatsQCS3DK0duegCZeD7Av3eZG+Bq7BJsL9gGpgSxE4D/ryJPa/280cxPtd+QHZnGKAyGR9n4KdyLixBgJYV6Fe/EItyY/M+CgjkzGJTiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713712903; c=relaxed/simple;
	bh=y5BwR34/XS3Be5vC5kISZKvfLqChD91SzMkvfbnB9IE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=bffHBZ6i4Y9kyACp/l8u9WmL+osTZ/Rz6i9JjCxThN4SNrYHYr0bY6C5UdBgCOGfFy8/z4QLrJtUdART90kAzQcPsd6AuyhTVCbBvoXIncK66wJ1twgwUfgyTk5asM2GR5nqIj0B7pX1aW7boStCas1M01FrpgIP5K8azIVUsM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pY6/V6jn; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe2zOtO6oQWww2zulTaLDK9h+W5o/y08G3Yf5bbXzSEyHx2gfI+gAfr33gKVDUFGa/mcyBlHyv4dcOYHoG0rQUcOjHMvRRRS8M+aMiOsgQfzY//4rySnwWluNcivDgvrC7MwKHklGy6patwyQ6wJhwOYgbA0LWaWwg48qbAi4GyoqhB3qYdo3ceCENuXrvI2FVT09YxluodUPds4I9uTKD/IYiTELXc9Prd4SlWpmaCWx/SWSp+OHnMpirdIasx2ZhEt8nXgdqlBJu5o8JxON0a9FxucEFdc19HKNoK62hgBryM6Ag88w5hba1Exsclp7U2hEFdWDnlwRWGEhUjEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT8J5jew6DzObJesL8pX7IjWLkL0u1raUdDB9dRGMDE=;
 b=UqIiN2L4E3rdN3vjFlJ9oA9rjPY3oaE1jaOxKKnYz5KmENkujTTRDKPTe7IyS7I1q6PMC+G3oUOLNbXgM1z+yAGvcMsHLApOsU+dpf1oEoDl7wxPVwF/3ML8f0anC8l+vr30HtqyYXp96TXifnKEGYoSyZ4+ZHAZ/+1KqDNN7C0fnPptXNFnB+cLK/T4bYhIUmsq/yhrLMHSQg+Ejs/I2l8876e7/z8LoSqnIr1qjsdXYb5/+Gc5O4yqW+zVsH/6Ol2JYMd0HCkBQdWOCiZQL/RwnNAVrIJSix/vVf2YiwVF9B4cSL+OUUID/fvgy1tH0eAEDes0sTzEjJ1zXqYfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT8J5jew6DzObJesL8pX7IjWLkL0u1raUdDB9dRGMDE=;
 b=pY6/V6jnW50MtuN4XkzhnQ9v4rYGLrdkadC95hW8yt8Kkd9QYaoQqtqrChpniQQgUgyFm6XqPmdFjgzikxst4yaI5/07wHnhkUtDt0+PjkdzBzkkewiKXXNtKamhQWnB7JP5T+E6qug1hb2ze9z4H+wNRKj1IbQgJqAVykqiQ3BCc4zpgXi+bGaWPX+FKXSLN0Ai0LXqqsWSyqpj+kPrlj6aEoWxcJ29jV0tVIcPsztJoA3VfTYG2J2s2/BnspUjaNR/ex3qyCX12gTHMNJ4eU6nMOb7NR382Lb9TqhX5xo5d4mBEbU5qgo1lwMyVkjexVPsRk5hj1Wz6BSkl0jEdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 15:21:38 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 15:21:38 +0000
References: <20240421143914.437810-1-tariqt@nvidia.com>
 <20240421145414.GF6832@unreal>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH net-next] MAINTAINERS: Update Mellanox website links
Date: Sun, 21 Apr 2024 08:19:24 -0700
In-reply-to: <20240421145414.GF6832@unreal>
Message-ID: <87sezeaghq.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:a03:100::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 2925e10a-4b5e-4dbc-b45d-08dc6216bd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHIbzWvUgaRYty8GQsD1Qy29VpZZhnYeGHBOjvfSHm0a9ssdfy67b3a+ZkRd?=
 =?us-ascii?Q?ZBCIOBXq1wiOkCupRYr7MYQ87FwgA3DY7TjixzTKmH58ngF37d54fIxwn8a7?=
 =?us-ascii?Q?hZhCW+/U9N/mLw+/tVOVqrYxLzlv11QEtkNKfIkyVjs7Njmc0P5lHeNGmjOp?=
 =?us-ascii?Q?CH3RsjC7Y9n0pk8h/gIS7Dq66EjkFze8kDAsKW/FWtehi7xIhdB5HPevTyVf?=
 =?us-ascii?Q?4EedVb2TIAmBdTPnIhFMocIW2Dz/o7CWJ3fj1ENucAu64MuevJcK/5tBANmN?=
 =?us-ascii?Q?dZ3D70KNhVOr99sdzkajnmogKClWXg0K+ObmcBzklF4xrkg93KpzZHRZr4IY?=
 =?us-ascii?Q?/LZL0jt5RPGogoVXjI3R9KE8NJ3yqOcXETqCc3fkkvpLBUUIEvP4MTH9EHzw?=
 =?us-ascii?Q?xibtCaWJijnmlXDDcunDl7mrwxCO7iWmgjtiSpXGGC0wdx12v7wxwYrZGjgM?=
 =?us-ascii?Q?iVaLG29gdEbVgSAXjinL36mjP6aUW+Kmggjt7DM3C+lE8M5ALjwADBpyPttQ?=
 =?us-ascii?Q?8IVsnopjujV6gB8il5AJz8fDE1ILYS/x8pwSbBhpOrsoRsbQiHOANV1LwRWV?=
 =?us-ascii?Q?ocOCRJ8wAqEpMcaCnE+PQzr5fuYI4W0R3BLmx+oD+hMcWFdD6EsJaaQyISR7?=
 =?us-ascii?Q?9LONxKOnaV3HDRgfPg96lItHdZGTEDt0k0noW9ULLGDn7mIWCON048X5P+CH?=
 =?us-ascii?Q?s+cu3L4lRoPhv6eW2O4SLsxs59g9DwM15Qtz9NABstZcYsed+OGf/iibJ7+M?=
 =?us-ascii?Q?y8bGPKx4MW4pQr1ZjfYbK725wNlhLOrJTJtPGhTR2bWZTdNWYmYE8eHW3XJm?=
 =?us-ascii?Q?Bdh3UimhPCspv0eSoIyM8Sa1GDQVetzSS4ZawC6L65P718kBkd8v7l8HC7Lh?=
 =?us-ascii?Q?5T67VS7Cw9+Sr0/T+fbzUfkScmdpS7Hwvg1ASKKVZgPbEAmkNPJDjBgx328f?=
 =?us-ascii?Q?HcLLk5oBZ9t15/tm3ExQc2Te+fe/Wdb36mnT4K24GEeBN1H9RBT8RlfODKIp?=
 =?us-ascii?Q?JPtxOEcqQdksd9d7/Pl/BKlSTKxJim1qGhPDzhrAPQMFi9Ft14YFLdb5tKav?=
 =?us-ascii?Q?L984YGuk64wKsvbKA2e3zq16cJMH5VeDyRUOkgd4ld+HHCxD/6GwxyzJHAIi?=
 =?us-ascii?Q?Zhzw13kAZWr1tIg6hAIBTDzyd7VQIqbkNhKVKeku0ATc78uz5yO5UQ+njxT3?=
 =?us-ascii?Q?fDfy3J+1Dr9CEXa69jSWhO+OovQKpomagolwZtHEXWp8uVIJoxV+8obpC92R?=
 =?us-ascii?Q?qeG80ZR6fswkYVvdLHBWVyQWQVxzg8+v/SyP/pL8/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k8ZBsqwU5aEMjjX7zg/orNcwJEANzdsKcyA9f79tatkLA+E7S4gNecxfmfqj?=
 =?us-ascii?Q?qWJIqTBYcoQDCXwS8iNYO74OSsLdSwTzwIFwNozuMYaYxqYkzLK3CrmnjGSS?=
 =?us-ascii?Q?luVQP9rdN0qmDCCMmxVHW61fncdgHfvQIa12usNk4zqP6bn1wgGqK97hgfUZ?=
 =?us-ascii?Q?zaI/lENfBDOeIc6HcpAQA1KqlrxDp7/7ve5Rlmw83p8o5PnqqrxwjCXZcjH8?=
 =?us-ascii?Q?W4yqk4oUsh/zoQWjsY1Bz24qmnDp79udzMmGo68br2EjJDcneKPO8tb8gdLB?=
 =?us-ascii?Q?Ac8kZUjDKdyEpq5+EUOCSo0PgRaFo/hl825dIcXscRDgvK9kaFJdpZse43dX?=
 =?us-ascii?Q?r9lvzzf/HMiqX4Fg2di6SUCgnqTqRfNd5VHqst8smIO1hBJJL/kdyyapTYBk?=
 =?us-ascii?Q?KFpOYgmF0IXhUHKJujEJ3L+PcpQtI0QCQjxxuz94MjQk1DbMsiIS20TvFxAM?=
 =?us-ascii?Q?VKXuWxeDokfzC2nXAY4Q/msoj/Cwk3E/8k6kz+neJxefu7mmctKKaYirs5sJ?=
 =?us-ascii?Q?5zfzac8irZDVmcfijOVCgHxB6PqCH/pEsQVoBpLlM5TslTmZWxM+9tily+HU?=
 =?us-ascii?Q?GpTyiWm/Nw00zKVKm4SiMjxttM1H7Hxo7oHkkowkuNok8hwxWhdsqMZ7MCtX?=
 =?us-ascii?Q?CmrkLcyl/eeKHZyAS++vL0u236h9faXvbB35YTlXMAiWFgAS5ILXaPBR4FdL?=
 =?us-ascii?Q?tt0/2g7Lve/liwTafyswQkHEOEcuBCl8l2YlaUSdPWfITXxkONM5eex9/Ezn?=
 =?us-ascii?Q?5j92knhqpt9EYTzhNIWPEwP3pOW7CQ2xrTGm7lLMGo/mZp5wySqWCgnIPzeL?=
 =?us-ascii?Q?4qWmeC0X1tD7r0hU6bBOMQhaQcCDWyJpTjlUrCda5TBLFTtphJMK9eKx3Pa2?=
 =?us-ascii?Q?vZMaM/drEauBuGxHk6wbWQDa5gD6PpzETAXNkEIXOebaaJBt/OAfVoghf1Bm?=
 =?us-ascii?Q?du4iKtP4euJmBGtVL4QkNoywDGbgVn+5Y2Gizy6ydnKNHL5AxDBQ56q1NnjL?=
 =?us-ascii?Q?v9wh2w+pbE563Sc7C036Li1MLGfH2UplBQrqVpXpcBgxmHJoT2p+RFLdsWzd?=
 =?us-ascii?Q?v2MGcQ/hrQ1oWgxuBPQioTFyAgnmrZZBtg9WXc7HIB5CUl5fxnGphDr20QRD?=
 =?us-ascii?Q?XLSvNtemGx1y/IwFFQxLlbmfZSA0wyH/1jJoQRS0GNQev10vDi5/EMk1J7g1?=
 =?us-ascii?Q?AQSPcPQG6yGD4jWCBV4WEgLuQgOSl3yj35CUqeX6uh9gFPba3gJpDBdJTLFF?=
 =?us-ascii?Q?aj3GE+VPv7Zl5RsTGIPYfLvKMObyctZig8ZJ4rcoTtlbReWd3Nx3X1yDX+6+?=
 =?us-ascii?Q?Sw3PiAD12+SiqMk1hRlgPQ9Qb2awPB2VPcEERANdSJQA+k9nYuiWsKCcxx0r?=
 =?us-ascii?Q?eRjNbO9LqjCTk3De/11LXykKwDsLuji+9tEP1UL1FzHzFH1V93GEU8X63uZu?=
 =?us-ascii?Q?7tlAnMdw1XsrxbbKR+TBlvisDkNJF1L7ITuKjHTiC61Zl7SbLrZDSmnMNe3f?=
 =?us-ascii?Q?F9dhHv4drIkrEUgZqFSvN2ohz/j/4x3dXY7JNMgHRB6TQMbk9GI23nSUeWw1?=
 =?us-ascii?Q?TXKOgPinm5P8SFdhNYl327AQDO7zEl6mIRTRd3Ee2TKpmR3hhzIo/DJbOR1r?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2925e10a-4b5e-4dbc-b45d-08dc6216bd55
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2024 15:21:38.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8SF35Cg6i62CNDfl0hvMhWXRqVORjHll+3uYdqD5de4TEPOIFym2kcLrgB+eajYcy32ChbIULZ9EJnewrZWtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609


On Sun, 21 Apr, 2024 17:54:14 +0300 Leon Romanovsky <leon@kernel.org> wrote:
> On Sun, Apr 21, 2024 at 05:39:14PM +0300, Tariq Toukan wrote:
>> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> 
>> Old mellanox.com domain is no longer functional. 
>
> It is not true, the domain is still functional and www.mellanox.com
> redirects to https://www.nvidia.com/en-us/networking/.

I am not sure I consider redirecting to another site to be functional
but will update the wording. Not sure how long that redirect will last.

>
> Or change all links to point to that redirect or leave old links as is.
> And I'm not sure that this patch makes any difference for mlx4.

I am opting to use the link below so it will pick the
language/geographical endpoint correctly.

  https://www.nvidia.com/networking/

--
Thanks,

Rahul Rameshbabu

