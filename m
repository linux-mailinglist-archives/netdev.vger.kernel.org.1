Return-Path: <netdev+bounces-181643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229EA85ED9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5F61BC3A62
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59718893C;
	Fri, 11 Apr 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bQUIwyrA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAA1662E9
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377867; cv=fail; b=o8iLF/7jYac5+1K+J1EOhfc6Cenu3lNqFa8FLjlWR//XqYyFX6uq+sse9uhT4HVN2uiAUddcbsl8BoqhRPpshKkbK/8YzwgHIEEjk7GV2wmAV2L+tpL4/mk0tnZX6HalPuBOmHjPN6d3rLiozgqxkNRJVHEY7y0wVM7/FzIyeT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377867; c=relaxed/simple;
	bh=eNQLS0jR56DHCpeL8J/qmrAKTd7wMAWUFVNJ6TjYzrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=lgIEQ0zFVhi1ILfhILbbUZIBcruyulBoFhywJmeD3pdXANOWpQAmUhGKFB5NtfTmOZbn1mr0PdcOH4Hs3QzZfX4cZZz71Z8eZovh/gNTNE8NCrL/PhogFIZRRNas3mdiEMQFYc5krYZGdguZQRTuhrNtaLh8dcKrVusuzTkJgTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bQUIwyrA; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqKDeEHIQ8t+UpoGdcQj8WMCP+e/w3l6ruLtBCFobVbs6GLMqnFZ/+1PvUF0ofKJD88GNKOdP9qjTBjXxVg58TKgTjIjJOwcK15LgILSLDon4tFZO+UGDK05p871H95Tfi+cJ57U+YSdmVUp9iFwffKKusIdEr9SqSDTDUAWXQspo7q0dToGFCz3bWwReYuiQ/Wo3Z+u3pvinQtdtbtg16ozboJ3Cp4o2KVswq25gnUbVpqCBXUjoqi6hSyl2GPlCZiubyAgB+WkpzXywQB+niWaayuwoi0C5DDQrtPW6EOLDpoQco2hjAY0wSMHZWeEOHZO0yV2oOC3pFgVS1emNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNQLS0jR56DHCpeL8J/qmrAKTd7wMAWUFVNJ6TjYzrQ=;
 b=C9N27G5Vp8y/q8EikAivgz4M6USXdN/niHXbG83y2TOTiimjTysOfSAXSrpGpVc4lYV+HjL1QgStY8Ri1FHQL8pxeoxZf6epYx1MoW7y9o5E1MfscGfk7X0X9VuhMg0kmxljvbJNzRCp3PfUi+juuYAgVjAhJY6L8hG9pd0PDF/CpkQhIksibSe5MDL82Tm4qK9MFKVMQ4Jq7VGyfI36mm3SkM8B4O48a8wSpwmgQc32My8AayQMioqBRw8MLcwBlcYefwcA7EfvdRiF4Jk2FbS87tBiE52MZgWfqT+GZ57XQauK8VgJTmuqfnVCZyFR+8eSc/h5u0QNl+uN+nywAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNQLS0jR56DHCpeL8J/qmrAKTd7wMAWUFVNJ6TjYzrQ=;
 b=bQUIwyrAqG7+ELjg0Y2S/wiMCipH9VaW6G5cRZYaL816eRI3JpTmziIMcVh09KuaFYUqpOum3NLDgZ9oEochoS/5szOloo3dvJ+YKiplRcg6hsvAYutRlmfgy3Fw3/5MFque0xfUlEj9h6jbEESJ4RRZNkyiilEGUrDU9EMolFV5JVWTMrhLpumE2Yhrvd8R6WnOUZyYL8DacasXDuvs59BDcyxMx6UVp78PJBWhGw5UhNzGdciWoSQV52oWEwM5R/wnYgGadOtJ9xwDONyRoikwymLwhRL9Gj7vmC8l5nwidt8IC5xgUEqG9Ae+91zj3R4YOeWoYMhvhsVw4703xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 13:24:22 +0000
Received: from CYYPR12MB8940.namprd12.prod.outlook.com
 ([fe80::49b0:41bd:54e0:cce7]) by CYYPR12MB8940.namprd12.prod.outlook.com
 ([fe80::49b0:41bd:54e0:cce7%6]) with mapi id 15.20.8583.043; Fri, 11 Apr 2025
 13:24:21 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me
Cc: Simon Horman <horms@kernel.org>, kuba@kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me,
 hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
 davem@davemloft.net, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 tariqt@nvidia.com
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
In-Reply-To: <20250403044320.GA22803@lst.de>
References: <20250303095304.1534-1-aaptel@nvidia.com>
 <20250303095304.1534-16-aaptel@nvidia.com>
 <20250304174510.GI3666230@kernel.org> <253jz8cyqst.fsf@nvidia.com>
 <20250403044320.GA22803@lst.de>
Date: Fri, 11 Apr 2025 16:24:18 +0300
Message-ID: <253cydizv99.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::25) To CYYPR12MB8940.namprd12.prod.outlook.com
 (2603:10b6:930:bd::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8940:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9cc933-8826-4956-52c3-08dd78fc2bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?08HhBuB/SzZYWbmYxKqLxxjiYAnDDYf8skwUd+3Sn4yrS0kZFAbokgC8DTmw?=
 =?us-ascii?Q?sxWzkNjq8kA0LEBLNIO/kcYBjBKYbjLhw6aIIdBeOczLLGZjLtYvMhVxRz5c?=
 =?us-ascii?Q?Z6JbX2fOpqVcnqlXERT/KpK/ZeoACPg25rrAOdpevJHYmDAyqaDfRF/Rr4rB?=
 =?us-ascii?Q?KG4qi9F1w3RQf1kc1KAZirOkYVWj1u2lE2/JbAeAfpweiFUgkpu0ig0Yh9qm?=
 =?us-ascii?Q?LqffiNajdIuYE38xDZbpIQMfKtLZvDol4mkc/hFjOqwZ6nvh4twwZOKPheWs?=
 =?us-ascii?Q?RuD0vN18uWqEWG/ez6Mb5vGmJU8zt/X9IgnumuphrWnxMt1KwuCy60Q0su7W?=
 =?us-ascii?Q?PUE8BxTL7g31qysh8d4VYPDn4IwiOg7g9Kc4c5MYQ1GpekZdj7dPjpxI5nIt?=
 =?us-ascii?Q?5Rhp1/gZjN9D7Bez1wpsvX9qibqz6GWynE+VgSJW+jxg65QgqPfD+zeoDqty?=
 =?us-ascii?Q?T8whbyVqxHujJmMfLLqvCjosdexc9q9Qqs3BysyiNKkQwXHmYv7ZQnyuXGUZ?=
 =?us-ascii?Q?+1MiUWxB+4sr7DLBCsiZ1d3I6rM8eT8drMcvP+hkNRd9rO90V1et1FSDkFs6?=
 =?us-ascii?Q?xCBXh+5q4YtAU6RWy73SNJ4rWY4ea3gHJAZ5/86WWXePyfA9z2+cIMeoRaMS?=
 =?us-ascii?Q?/e4gDdjJvCylAh7wWbZtUqGPqSE5+/ZiWQGqXIASKltiyjIZLQUfIV0ILC5x?=
 =?us-ascii?Q?5T6iGS0pAc+lD8RO/PhV4g8SA5GxeXqpoajTkLC+6fHifjFBh1p0go3TTxqU?=
 =?us-ascii?Q?7GDxdshH1XXVosiIg7G+Y70RBSihoHigb6pi+VcPBEwIrIFf5kdCatUVxEJY?=
 =?us-ascii?Q?J9o3ZFOYB65ja7Ok/FjsC/MnmE2Rbc9ZuUcVRjDobNomf+rkRt0w6Caa/5L2?=
 =?us-ascii?Q?GD7QUPd6rNvuZOdNSBZt5xyXuUWuYt1XcF0aa72xGLc3QJdtXE0EHXzBC2dB?=
 =?us-ascii?Q?bPi8G5nztD5c8+HBMMuYdJt4V1wKAi3rqrI7PSpPiulhWOdObyQqVa8Dpupd?=
 =?us-ascii?Q?E651Hb4kjpoPpyyeAc69hidWack/FW0u05HXDALgHOvYr8i2mTrxygFZLEZC?=
 =?us-ascii?Q?GAYXdn58PRAttnSwo57mK7JMsch9twDt4zx3WSpFsZef9Tbbcz7hNwwlc8QD?=
 =?us-ascii?Q?LWhX6ydoKbFDCpc3+S369DsLdMo3xmruD/nPnt31ZwxCajTlAPR2kAkaOcpc?=
 =?us-ascii?Q?vsdJ48eyLDOQEcQv0cYqVHT30MyPYUk0QB08fIJTgDWNhFgKdGwB9FPX5x3X?=
 =?us-ascii?Q?RkL/xo2JUyCA4iR7MqA7XPjz0XbuEy1eCCexrnWyaTTGaQ3kqtwL0JifsK/x?=
 =?us-ascii?Q?5heXPfMl2qzuV7Yj2z5L0aPyJGGH7HSRPftnxX05uTP+VB9NZRHTpEhcXVMU?=
 =?us-ascii?Q?KVX7JyVQgNIl+hcc1TpSE7XXoiS/cldTEqdlIE1WlAz0oeAPPF44WVj4NiL3?=
 =?us-ascii?Q?ymTICjPbf3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8940.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpTNIh9Nx51r9tlhK2yRxkGK7iYIsJ/bJmWmF/97Sc7eNX0mjpeSDpYQEKNH?=
 =?us-ascii?Q?vVNBfRSvhNs3+hwzH33B5pOfeHg0vVrWXnTEs4Yk7NWtSarQ1yrUor7YJFA5?=
 =?us-ascii?Q?XvuD1sQzjTXPM9X9V4y7XRitOm70jCQ8XJ3IjzdCFHC0McQ3CbCsvkUIKt+6?=
 =?us-ascii?Q?KoUQoFyHrDLlxcN2xLTTSr/k3OwahwKYQU72C3JzVQaxATpNAyBgVL8qboag?=
 =?us-ascii?Q?pmxlw1YJJYcR8t1aRn0fhubWLoGBZwanVgcZ9OBjUiakfNq0OESbk+SNYDZH?=
 =?us-ascii?Q?VhcipSRtXgHiH7YvrH/CjhtXs6Nz84mwAMarEXSqQRbHx68dgdrp5fofnSkv?=
 =?us-ascii?Q?eF5ktllNrU09238SC9eqBASIrUu4BZfynuxjKSTuWQ6QpJXjE1ne6CiKCfk5?=
 =?us-ascii?Q?1Mb8BjnpcmdMQT41XmqFgSBRTP8LCi8ExIiUUyw9QktL+8eQJBC5ifkQyTUq?=
 =?us-ascii?Q?n0fhX9AStnw9bVvzgC+E1P80r0+5BzSqwoqBY7L8EyNUSVs/H+9P22euyxGj?=
 =?us-ascii?Q?1hXJhL/7n1ghJcjn09miRrq1F4aNPKtKhDGVzf4xniZGTwhnrrHsKqflCxb1?=
 =?us-ascii?Q?KjwofMzcf+3N78Qbi0FW3RTVM7wu6XT+cGGzcykKLIZaiaMDdbIoUNgNoqpz?=
 =?us-ascii?Q?AFYIGzPNcUyPhQ/8IjCBnh7oOJHypOOIq2Et4UHXob9eiZ+Oh/0sx4qoQpKm?=
 =?us-ascii?Q?uXWOtyz9HVoPpe1SIYOirQWMSCA9LHoDBVPEYIyPdjc7ySwPwAL/zwFnJcyt?=
 =?us-ascii?Q?vxRqfgP40k9UUjVJrffMHxUYoIcxJm1xcwtTS10j4lJkse1vHKF/7lZcNQoI?=
 =?us-ascii?Q?pvbyhdULYjGHtpwX6VSh55aRvOJT2TPriyn3vD2PQDfoCYKImMP+CsfrTSrK?=
 =?us-ascii?Q?Yh9JmIWDs55WzbCNCSwajM/8CWTLBPBVjTEB/Vou5N4LS1F2IctumYUYK0A4?=
 =?us-ascii?Q?EWot6sqOlpV+K94NrwhyFhMhvbJpSgLz7CZs1SETBWdUOBUPdRPe0mCG8A4G?=
 =?us-ascii?Q?islMrjL5E9tGMcvW1F1oGDtV9sSYf7Po4b0me4znD7ZMBnWbJNX2F0ltcbp3?=
 =?us-ascii?Q?upe8E2u6c2TuhTfRFl9tUeb0rjciyYN2FXb9XEeKJXLbUWCSa9Gg75pxLaDq?=
 =?us-ascii?Q?2v3kj0ghRTDU7x4281xUzcN5kFjqPc4pinOyjq2yxvj/wUXzxxm0Vdq81x7Q?=
 =?us-ascii?Q?6JihOYiYDHSgCnPNOhIbRbPTXxnr7v67IIXq5DHp2mjnsOxUFJJPCpYwLsz0?=
 =?us-ascii?Q?skv4utXj8uMYTSdqERVcWQ8d7itWIIBElOMEGhEEV8n+LDDFLHK0Dne56QJ7?=
 =?us-ascii?Q?ZEcheGbp6b3ZB75iV2CCWoWGjbL1aVKp/vmTD9OCXcbP4o97O5OKbQfu57ew?=
 =?us-ascii?Q?nYTrj16dzQaVSHbt5C5r5EyoMe90xG5XxocO2CFtxrIyuYnmVcyM/6+PtaSf?=
 =?us-ascii?Q?ArmboK+ljIbef74iYM+mXJkNBiCqQ3Js0eLYa0d/qP9ofq3yS4FiAPMZLldy?=
 =?us-ascii?Q?g7vEUJYTnJvy3sqL8bH86fWFual1u43UmBrBQwqYxJ87bLQiXXfF/Zd1AZFO?=
 =?us-ascii?Q?/x1uVrfuoRrIZ+ro8ZyBHl+jsLBdREOSzfKfqaw3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9cc933-8826-4956-52c3-08dd78fc2bb0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8940.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:24:21.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb5agvQPB/4YKDZB6TzHlmWJ73GdUwAuhi5V3xFUiqv0wapxHl4ocqUsN4vwW91HC5tXKqtnfeA7cQlC7iJorg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

Christoph Hellwig <hch@lst.de> writes:
> Btw, just as a reminder nvme code has to go through the nvme tree, and
> there is absolutely no consesnsus on this feature yet.

Sagi, could you give your input on this?

Thanks

