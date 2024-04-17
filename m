Return-Path: <netdev+bounces-88834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABF8A8A86
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BB01C20155
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBEF172BC2;
	Wed, 17 Apr 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZK0NIJHY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C8172BA8
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376446; cv=fail; b=aTaV2QH+/aXF8hpomSFE/CKr4qL/m5GeXgsn+JBDtlKZ85RI5wDSyI2XdNTwwwqkJLBHwd8fU8YCbLHwWDdFs7sujrGW7XybA7kN7FdW6Zy5kMQ5QwDvpYfqOnh/i7yZ2EhZqHF5mF8NKTK8/22K+4RKqmhqQ1iVsIWfa3/F+K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376446; c=relaxed/simple;
	bh=2OxR86wzecK5KWDLVgwOk8mc47kevCl3fZ9xfRkhOak=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=PsGA5nnZM7nqUNXvW832Man4Xlrmrl+93Lv+JzWPR7d3GcX6ToZXq8wYXkp1XH/jRMB6QSFoSgvfqroE0F6DBRFXbE5cDwniI2+V7ZO63imPjbMGq4hhH/1x9Jnr//DFWjiG77I+AxW3TUb0ye1L9koM4b2sNU+OKAkIF+qlAKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZK0NIJHY; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkeLRIjm0kh5Qt976jXNcBhD7Jc08V83L3ptccFIcAih3m0B0ktywZjiVcaOKH4NIzEen4dBvgYX89ELlhD3g2zK/3zCMFNnYusbORgTJBkId0Outtrqkp7V1IvNwzjz6DbqeSZuaHkmu2obz+b3KuFWm7MCQzx+N3miNyu+bVpWsWC02vU+Rfrt5nlJHSjcQefPvaLZgBddl4Il+0p0DNdZttDQ9S1MrX4C+08Ya6ozMes3KMcr1F8IYuRGorIdesGQrfsoRccIhux8cwiEh51SwudjbAy+NUh4D0VxsLYRq7o1DKXR1iS+CzdVlF1i+BZe3HRUEvpoz6tiiAiM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OxR86wzecK5KWDLVgwOk8mc47kevCl3fZ9xfRkhOak=;
 b=HYA2xqxlIL9jfe8iAbiOWCI01IwlFduFzmoyj3Qp6AhGb1QnmnlmVgi4SyxiQyUfjb8TMcLGkAPMpTad8p3OyyJplqAu3MgNypaDe+mWzdYWaskYMiXngPeFQ29iyXM7Fyf78vSGGXe/oRME6U6zTXhKRG7V3SB5+ZQ3R2nB56DisLDzcWd06L7nSXcD9FdgFNdMW8XOguojScHIq9eZ8Daj6fUYapoullgMCbr/OkJ3OZfBcjKxhYDn9QZ0lQjBN1DkLuwgmFy/48rYpucSqthsTp3lurVUxopFHaqn5Uc/dG0V9c03B9FFnM1kWpy+0nTsSmb4fBrCJbHBnaxK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OxR86wzecK5KWDLVgwOk8mc47kevCl3fZ9xfRkhOak=;
 b=ZK0NIJHYckdO1BcLLDI6uB7gWPOqukRMV632q/20dhy8mxD+JwR4EtHu1w4wqp/zvC6eAa+nlIHquWi10W9sz8gQYB2u5vG8MitXZ9gL3wJZKZB6EnZQKMLQp2FgJQzYyz5znyhi5A4uciyXPt0gY0EgWI/Om1mlaUmXr56Db5M2XGhIXtPtayI6Hxu54jqipjgNdVLegIEVsDtJA4NyuncUlNU5za/oHtQS7LurmdOYiUQf5V3qjGcFqFpMU0bdKxRvWBY+I1ibYI1pzd67zDFSDx3s9q5XXUbaNqWA5rQ8RroxiKRO6nmDGZSqx12cp1oMvMMTlI5Za8iYc8FjIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 17 Apr
 2024 17:54:01 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:54:01 +0000
References: <20240416203723.104062-1-rrameshbabu@nvidia.com>
 <20240416203723.104062-2-rrameshbabu@nvidia.com>
 <584f28ff-597b-4ab5-b363-a5f142905fcd@linux.ibm.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Carolina
 Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Michal
 Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH ethtool-next 1/2] update UAPI header copies
Date: Wed, 17 Apr 2024 10:53:05 -0700
In-reply-to: <584f28ff-597b-4ab5-b363-a5f142905fcd@linux.ibm.com>
Message-ID: <87il0fx4co.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a845e3-2577-4f74-9ff6-08dc5f075d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GHaxU3tiKc17iuNbwaaB97C12jsDxJJSnDZxGsKGk0XIvQAa2M7KFz9dEc9YNJ3Fyy1ycwIktoMcCW9cpw9mHwfx8vqY23uHs4P2q4r+HWhlcNtKDGkgBSIm9tPvgp7Qj+Chj8TtRw5Qd/XaS91nQY76rS8G5zdWhP+23Sd+q7pbuEBa6x/cwhz8UWvykqJrnNs4tzCZll7Y1S+d9CDaz4NCXg7vFT29JWdjHmEr/H7DK3jl62iqXm27ZyOYUh4ddWymhsxCf2zWh2lZMp4cyZhWgkmnbdhPCsS37neSMdhzr9unpirUGu+bNr6Z4ai1zqgbiSHouy4weoauz2qBUqk4vMCkO79SWOjTURNhysign53/O80NqmS/PdN12gjOzPtGXyI49y28R3iDgeXX4gurZ1uZwqs1G5H72tnMMwkzKVWZIMEMZsx3NhXigKdQoLH+iqRJecuATcdStC+D9m/16KGzNHkyBeRY7OBdry6+toq5Bbh0iTDzOCTHhI723555E0RailoNbVCyGeVaTuWFTCi/w+9qf4vnA9U9++sFLuA22v5o6noGk0au3uW4bbttASx20iTs7SEomcB7xUgaUq7S/kDYPmxqtuoVh8xX1N+t4d9Wpb/FQAgF9z7CQYbiQj344VmBWnhXWiliepnwOkcMt1vPahXNvG8tCD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xU1PO6R49lMplYhSZ/VYvr4Qyw1bDAnCaXAeD/TX2dzcI9/GVUFH1QnBTSDZ?=
 =?us-ascii?Q?KJKozI8VJu+cKkmAtxFujvHNsUpzHt48BV+M2TJt+633T6M01MtL7Y+NNuKl?=
 =?us-ascii?Q?U/tL1GA4K692rAuppLKoajshKUDsex+WLdsKIffjyW00jo/k4JajG94Z4OS2?=
 =?us-ascii?Q?+Br2ig1Cvd31+3074HR0lYxluGnnXuSgjwO0nXDo8rElzbo+LHNGjDX4UpuC?=
 =?us-ascii?Q?yVcsmgW+mEbU8BP9vWcFCj/UvZHRGCmqiv+tavrgjqAtxMg0uyu0iAVVb2FP?=
 =?us-ascii?Q?aVhGyVGGtHuMv4P+RTrOOz/d6Qkzq2aaaRuxxJwj5HrtCtBt3sUNirVtWn5I?=
 =?us-ascii?Q?SquSt2mpPlp0qMp4/DyrACYKggo8vOipPhf9SZAnpUhWS4XK1b3wWfPpLtsk?=
 =?us-ascii?Q?8xapgFtAfT7HFOjFCSnxTY3PI/+RliiW5ft+xfg1M0jgVcy1hJQJz0hmk8JV?=
 =?us-ascii?Q?UlSE0xFNiY2XUkdwi5N2Dij6VXVEHs1kMuJcVRt7JnErqb0vMtzV9ZvsNOmn?=
 =?us-ascii?Q?R1xz1GzXF9RoUtwOxa7u0Op09+sPOq5YrD2EbIk16CTyFvl6rkerQ4sSpUlT?=
 =?us-ascii?Q?6o4gW5AkCfmwJ6REhVdKseWAKGM1BSMTri/1iOxFg6xb7WJVOXnT6GUJ85dA?=
 =?us-ascii?Q?2EvG6fZfX2Vn0Jo+ch+BuWdPABGWldJbjQn1cOaKQfKLx5VySZBppvwCJZB5?=
 =?us-ascii?Q?KWHOSvoPt2JTc5Unk5hDNe+JuqR+Tg+qoTS/wlu43LsvTfy5HhmOCISAIYuB?=
 =?us-ascii?Q?cxBlz9tddMIVqBmGzah8vj/EZMuUI/22WVhm/YCR40hoXaf/4eeJajDOXq0t?=
 =?us-ascii?Q?LvT8tYtxVRcNJcy5kDaIUebB7MtEdSDCRgR4J6qqvI9SY+kE25CAp570Hgoy?=
 =?us-ascii?Q?sG9WjavH17RPu3ZHh0bsPC26fn+fwb8dVU4AJxQivDn6CAJprPL2jc6QZefA?=
 =?us-ascii?Q?cOBVxXorWJzX16hio3vhCHxlYsPKGZAUH/qZEGCETnJF6vO0jNE95ECalOO7?=
 =?us-ascii?Q?dwu5WRRAE6sVLMv6NXrQqdF542qs4KsDOYrkPHz4/X6uuDhNxZ1geyQHD/EM?=
 =?us-ascii?Q?8u7OoMfkG1YPa+uEWcijk75c6TEh8pgv1xjg+o4wmat3b7Olfxo3I6BbkvBD?=
 =?us-ascii?Q?4BpsOOFy4d5lz6Bp1PR3cPT+pOpB3RquL91fyMdiOo5y6iXjphd5iVE0hK1F?=
 =?us-ascii?Q?bEwcl2JoBcDgHCyc3ex/XnyPRh80WiFZHH3RS7VL6BiTzF5hfl+KbBR2Pt+C?=
 =?us-ascii?Q?bHHTou0aoOkpOCBYw2GlBpdcclI77kX3QDkrzy7dOpjaq/ELNe1CF3/mqmKw?=
 =?us-ascii?Q?+mO1HQ025hbr3r6Anep3GEEnFZLEMqdnIl1EqHZJfiWZn5h3JygvqCDigJJF?=
 =?us-ascii?Q?hNBPYU8WwwBgTu0KlATrav9EtIY0boHyNVEH/RksV5UZl0JK6aOPuGKmPTbu?=
 =?us-ascii?Q?62NbROnJQJjSEyK1C8ur5gvTWfqLm2RYcwk41wSzAk1AGoY59dQo+lREVjr5?=
 =?us-ascii?Q?YZavoOhWmFUt0c+hLmDXKUTEPk76rJsucpUc42z1UNnFUq5NijwuZlwxO9Nc?=
 =?us-ascii?Q?SrD5qT1TKWy2Afnfjdqz891xCTZHvjVbXvfqwDa3i+8XA4OLjgXeaZnRYFH8?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a845e3-2577-4f74-9ff6-08dc5f075d13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:54:01.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6ciWX735JMw96gtHe6iC8tQQV2LnyPIjP/7t5VUvALOlKwDxdqoTaNRNKkjtGF92c9z/ouOMmh1Efuej+Xp4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447


On Wed, 17 Apr, 2024 09:55:57 +0200 Alexandra Winter <wintera@linux.ibm.com> wrote:
> On 16.04.24 22:37, Rahul Rameshbabu wrote:
>> Update to kernel commit 3e6d3f6f870e.
>
> Maybe a user error on my side, but I cannot find a kernel commit with this number.

Thanks for the catch. It's an issue on my end (accidentally applied my
ethtool changes when I actually generated the latest uapi commit). Will
fix this in my v2.

--
Thanks,

Rahul Rameshbabu


