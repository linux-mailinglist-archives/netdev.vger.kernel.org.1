Return-Path: <netdev+bounces-230224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA414BE57F5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5343B65A9
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA52A2040B6;
	Thu, 16 Oct 2025 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YwwvQjND"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023138.outbound.protection.outlook.com [40.93.201.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF921ACDFD;
	Thu, 16 Oct 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648558; cv=fail; b=mCqVSh03y/G4XmmH+DqHJNzUWwxx0d5ykL8cv3gLjEBQIsHCxgvjvpNDe5YwRj6DHh9LuDzSQffd/b0bE6Z6LUv/eJf4W9hRQASXXk95AaiJPV/Qrt7UF0+q9075MMJuhQlI9KQJ4V8FbOscjoezusaoJ3rsRt9EXmfnLjQwoZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648558; c=relaxed/simple;
	bh=b5199S5VNCWj/5dmrG8C9ic4OKwF9mMBm8mW2t4f6UU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JFdgn1FOHd8TvF6IWIFXVCaZhsR80YXhqMJJt8+llXZ/DnHOIsn5NY8yyNTrIPVAGjgDDL8pBAyznPcygwnGitV3T+wKgxYJ/otcnIlTlcZJR/3pCk+XZrqqaBqn0hz09Qf/RAjpUU7KfIyPG49UIJr9zN7U3yUug1Q9/HBQYwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YwwvQjND; arc=fail smtp.client-ip=40.93.201.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY/dvy+eRHsBYYm/79HAzhoSHbscTG+bQkyiRq4ignqQqNQ7jUFdmgefbRbtWf2yoqkgs/MfIzdMcWfxtls0eK0nUfYu7bzUP6SyttFLpyHjzeXxsJO0ULnjZas8MbQlDd0I63mWrq8H3RO8MryK2bJt7xEvSpwtIRDtnyrSAHIWOMDn98vg7FG+rDq94bbzWisGDlYQB23PpxMgo5l5Pi3kFs8T2HMIP3FGKwnZDU7j+Gi8XLBO8lQYiHA24uV6I9fS2wB76Uz9ASP0h8Gz9jGWAgq2DIYBunWRvMon2mGlE486yVnN2EfTTxULNEPmSuCyEDWZ06jVybKBDgYWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGb+PcUC685rCIyU/i5qvfLV6gEroHlFOwQZeueQBzA=;
 b=dF1tpWE1amkV04aU8v1p59QhUT9nrkKwpV1QDEk8F/axIMyL6EbPMb4UrbbQo8jfSv1g+CK0M2iIcHg9kkPFouVfu7FReYwWop8VAsp4SiebKsSwgyhN+eVybFQjPeYLBuzKMuw6deFM/7Zkx19rDKH3IxO4r4miFC3jH1/MQcWUplSOLuzdxisVHyT/eCLIhz8DVFYi6+0w2AKgMZZqWoEuJa7UBZLan08uNwNtgpfsDM/DuGPLmntYFx5idC9+uercPsr0ELt1Z18Xf7pZCM5kxdIRsJtAq6/xIvqAh11vRSbhxeDhDHK0Qk0cXhCHmjPx13sXDlYTAlB49I0YbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGb+PcUC685rCIyU/i5qvfLV6gEroHlFOwQZeueQBzA=;
 b=YwwvQjNDcp9luuF+z+nDzAjyrLXcySDKV7Lcm4EVQiL/iRnVo12MFW4FVp6cYb3o3dor88jaxZgun8fpsfoOX+bGyt01Fg4JNVcLy1b3Jmb7WYjj0MdLBtWDLGTC3gq8jLj0XOfkZRsbBJaemfkKF82Bbx8HFqGlJtNjp7Lk/tE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV2PR01MB7813.prod.exchangelabs.com (2603:10b6:408:171::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Thu, 16 Oct 2025 21:02:33 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 21:02:33 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH  v30 0/3] MCTP Over PCC Transport
Date: Thu, 16 Oct 2025 17:02:18 -0400
Message-ID: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:930:8f::17) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV2PR01MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: c34803f8-28fa-4c3a-9ec5-08de0cf753ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXKqPu0i6j6FDIzoj83xnJMmsvTg6cEPRZQyOk5zlcxqfmRWeXBzT+7gn+HB?=
 =?us-ascii?Q?aViGeEN5Z/To5CUw6RuGv86nvmsyK00xM7FeAMcJsHKhBnL6CyAicfQSQPbQ?=
 =?us-ascii?Q?KA2CoV05T+C8X/PjbBWsdQkSUxp8CkKdzsOQydQS0cdQKDhKtMxqUS1WpCPu?=
 =?us-ascii?Q?JNfs77bJoocfLK/eCij2g1uvVp4i0kijFYct/gIcmUCgC9SFkZp+GZoCAMNk?=
 =?us-ascii?Q?i7E1gL0alRy2OvUYpSxKNCkjudUhcbK7HjzGQ09MYi9UaS10brMttJHAX+RM?=
 =?us-ascii?Q?DZT3gSPYsGKN67Zzq9sw9ALdk6NgnhPt5JUDigHMNibYNYvS1lMRWvcT83pK?=
 =?us-ascii?Q?37MGLdyBjLNWV52uzjjGJBWVRkOu7WX5NpB3rgFAbTy3Jqw5zz7c4ZkrYUWQ?=
 =?us-ascii?Q?7ZsMm3vYdQX1kD/QWHtsAYFT2QxoHWCW35CiBGLi8Kb8z5ZfFpQqWf1cBfRK?=
 =?us-ascii?Q?YPg74XyA1SigEZRKMg4fApKM0QYkj6hi52e0PDsbheohyMxgb2pDt28gruZY?=
 =?us-ascii?Q?iXtahx1DR0DbvvQOrodIh9gAVFL1FhBNVRhZ0+JvIWRRFWVbK3TanlSaP8/J?=
 =?us-ascii?Q?VS1hLyTOX9xgu48LJ3dwOP5m8orjh4h6nfXBm1QKULtkOtmX3ZTEdTyXc/HW?=
 =?us-ascii?Q?8+mAasqz9+1MhepOzg+gidfWE8U9afFAZzpEWVDZCVQ7zL5dfjUf+iQSAQLc?=
 =?us-ascii?Q?hAL6eZvbYERxUJaASpQG6YsjqqocafW8VSEIb6ktg+1lD7qArK4z021U2dLk?=
 =?us-ascii?Q?gzIOywmwvFQtpSxSuQ5oHFIfs2HfgD9k4c0ZvxRQkY1qpE00dKpKaHCf6sZA?=
 =?us-ascii?Q?rTZtHUjAbKInx6G1hPU4mjXJElqkcEm4qTmCOmzeawzKmOp+1whD4lHE0Ncl?=
 =?us-ascii?Q?CgylmvZPiwz4WsPekLpqx4iKzW2OEnNoSbljSe00gnGQofoo5cmE6+VHawJY?=
 =?us-ascii?Q?Av5hasw09hpBiBbM3kXMLEE40DhHOW++4jXDa7/uCTO0KyuKVK92rjDEGXeN?=
 =?us-ascii?Q?RVxSjCwBT6Vqutaw0a44QahjEnD9zWufme1hpz3nhuklyjdataLCiLF5Wnoa?=
 =?us-ascii?Q?pmXZGy74GJA9hTuPnyc9GvMBiwulzVQcpbCKSSVCnr01hvQhvbnUviJRNhAb?=
 =?us-ascii?Q?lz9EscKRalujBMDlOd97vx/gDXAbrbaLT8tSo/dQAbIp7OkPw0rGUOLIr4E4?=
 =?us-ascii?Q?kDz+SNesNcIWSmPJ0RIwHpsbmlOC8mmRFS/ZEwBgPp9UcLm+H+DbekqG/uyM?=
 =?us-ascii?Q?ef8IiIpKUoeMjMmpiZgYuDEHV8N2eHKEnECmA34acr9R7zKaGHHU53NdjdzY?=
 =?us-ascii?Q?Wad3nHZkyYFUizHpiE/w+NMQgA1QjiUTc1gBYdvRRoqX4znxJ6OlDMEUBFQz?=
 =?us-ascii?Q?sAsdlg237ceo0csoEtRA0Vfw3OjOSOkH86xTjlsNR9HdgqWyQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aGAe6/70xnDDqkAgZMFj92yXP0BkbkuZvWIssEB6p5kyeo0Ivs99/NdD5WoR?=
 =?us-ascii?Q?XkQOQTEVNxjVgmVgqApUcciiCBVBss8jaXvG9CTwv087/DCaqDWOScTAwlFT?=
 =?us-ascii?Q?0gqJds/Pt2c3h9F6MrzKQGT/J76oXZPN7mOBpDoltFdA3yziURx2WJvlyBhM?=
 =?us-ascii?Q?w3/fINlxQ4zQXHW33CNVwwy2hwzuDwB7HOq5kRPlJ6TvHqFjIz4mPR/gvOZw?=
 =?us-ascii?Q?HfML1lJbt6J5p5jB+6UzLoVgBsgH4lB0zjWCCgpibNaed2Ea6YWSInk65A06?=
 =?us-ascii?Q?c7xW9isQjNbYKg5D1V3AB4ITdck553yeFVPkiNU4zATsAOyeRMmDxibOkg1G?=
 =?us-ascii?Q?mu8CXSJoeb6BqueycJLXQOhPqKs4wTbIDEF54gjrRIgFhTtXJ5GO0KgepWOR?=
 =?us-ascii?Q?CjsI0zM1/FPFbt2ZjpKlmLWjwv2YDr8mURqKfxZTO7+Bd4WYd2ldmVrnVVB6?=
 =?us-ascii?Q?qB8A7RW7j+qOkxDcMH9w9sTQJOKEhwhSFpO20PACZHICQ7aJXxC8RKjUB3ia?=
 =?us-ascii?Q?Ubz+WhgU/SKDYX6u5wfSEJKZknCuYxdja83cJpQEEZnWJQ8HRJETP13MI0fw?=
 =?us-ascii?Q?BucW9Qo0Rpv4gZKFJBUFbQvqcMs54XuZ0A1jOQaT0fGL0onOB20wK/MQDGBo?=
 =?us-ascii?Q?I5tjPuHNKB8dM8QLgNSyQTfEzgIXQDL+RAiXjbAuGMxEZsBzA5/JwiJOXs7g?=
 =?us-ascii?Q?2c5gSbDs97Lkq+KWl7Gtg3HZdnAnQfHJfdVh8qORk2oFzL//zCQRUOtbnN0W?=
 =?us-ascii?Q?9a26iY1iopWmJ1tc9MVKRE1L9UnD2eN8PU/n/bfRMc1NU2EyIoyUaqWoKfX0?=
 =?us-ascii?Q?W8Ufbu7IqcdYXIaDWrREEaMHpFySKu7Qv8A5dgJVTEqKVQTgJD4zjs8bKdqP?=
 =?us-ascii?Q?lSdFhs6qCcIl9u6zbx/JcABkadIpCBWTMDuvrDSdEacc8eH42nfwSPeJ1rRz?=
 =?us-ascii?Q?d0naYzib3FD/AytO2hLsRtdDL8c3yfT/Pbcdckpvu12i+2g/elpWoPrnjpyE?=
 =?us-ascii?Q?0J/WNSuerS8QC+DQnV0jMMH2AV0DIK1/toXIvBOH/p35F/S6Stx12V4+UBVo?=
 =?us-ascii?Q?Qc8M835ovrNlEsqYwEloNpq64/V9DRh2uCuv5pCM3kHoEDZCZ6LQcNQSrnl7?=
 =?us-ascii?Q?ZKktGStd2aQ7GcmzU6oLJc1iMnw+YvJ2OS+I5fSjUPmS9Hsg9cxRtix+6qef?=
 =?us-ascii?Q?FWzb5MN6AcRaTTjBnZxbyzRLz8mM6Z9YIHUjish+mkdWNETbkf17zj4QFLpU?=
 =?us-ascii?Q?E14L9FBbtaMEtRVHM2i7c4vmUzNKqz7IbkD5bM1Orspr1XK+1aiAWzj1/0AC?=
 =?us-ascii?Q?zVLtpoWMiOiQmVI6HKI+pydrHiPHU67WjuwixAX/XdHl18YJsgfJ3IepQKvn?=
 =?us-ascii?Q?UFPM31L23nbn9lOwUcC+vLeZXDi7k3qr0yhIOVUluP3PJnCOBfUgpWpradl1?=
 =?us-ascii?Q?dSM4dOCnMsPg8/V4JJXpvqI0cqdoyyXKushUJxpLaCyNaSu8CS/SpLb29NY8?=
 =?us-ascii?Q?e0+kcoUqdp1NFCN7DchmLAZ3q1s0Fv8rkP3HqgcwXLasDxb5W5RIe8x0VkfO?=
 =?us-ascii?Q?AF1TEoRlxUBgFRVgJ5WS2TLY3nF2GPy8cJNEthZGG2BcrQjRWv/of56mSjCh?=
 =?us-ascii?Q?pCUYM7ZJhzLaPzMqpPjQtGFEi1jKKXxxr79/fImhzftIso9fPCQ8IEZAP9lf?=
 =?us-ascii?Q?1WdzoFdxN2zBrmUbx56jon1+rUg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34803f8-28fa-4c3a-9ec5-08de0cf753ce
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:02:33.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfE6zwXCYJ4IUKoMSkjVwioeGqpxFppT6/d3Np3paR5Givj1TUgaiNbkaVfzd2NeySRNg6nFbZjnOzdxJC/yOPpeYfpvf6pAqOGQBco2725sCM/Ak4iM/aqksLs0ziKk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7813

This series adds support for the
Management Component Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP defines a communication model intended to facilitate communication
between Management controllers and other management controllers, and
between Management controllers and management devices.

PCC is a mechanism for communication between components within the
Platform. It is a composed of shared memory regions, interrupt registers,
and status registers.

The MCTP over PCC driver makes use of two PCC channels. For sending
messages, it uses a Type 3 channel, and for receiving messages it uses
the paired Type 4 channel.  The device and corresponding channels are
specified via ACPI.

MCTP is a general purpose  protocol so it would  be impossible to
enumerate all the use cases, but some of the ones that are most topical
are attestation and RAS support.  There are a handful of protocols built
on top of MCTP, to include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session
establishment.

PLDM is more likely to be used for hardware support: temperature, voltage,
or fan sensor control.

At least two companies have devices that can make use of the mechanism.
One is Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of
the ACPI spec:
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has the
ability to ignore an MCTP link that they do not want to enable. This link
would be visible to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. Thus, if the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hard that does support
PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would thus also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

A Previous version of this patch series had a pre-requisite patch that
allows the PCC Mailbox to managed the PCC shared buffer.  That patch has
been reverted. Instead, the functionaliity was moved to helper functions
which are explicitly called by the MCTP driver.

Previous Version:
https://lore.kernel.org/lkml/20250925190027.147405-1-admiyo@os.amperecomputing.com/

Changed in V30:
- rebased on revert of mailbox/pcc.c code
-  Explicit patch for dealing with PCC Type 3 ACK Interrupts
- PCC buffer management moved to helper functions
- PCC helper functions are explicitly called from Network Driver
- Removal of sk_buff queues
-

Changed in V29:
- Added a callback function for the mailbox API to allocate the rx_buffer
- The PCC mailbox to uses the Mailbox API callback instead of the PCC specific one
- The MCTP-PCC driver uses the Mailbox API callback instead of the PCC specific one
- Code review fixes for language in comments
- Removed PCC specific callback

Changes in V28:
- ndo open and ndo start create and free channels
- Max MTU is set in create
- Reverse XMass tree rules complied with
- Driver no longer has any auto-cleanup on registration functions
- Tested with KASAN

Changes in V27:
- Stop and restart packet Queues to deal with a full ring buffer
- drop the 'i' from the middle of the link name
- restore the allocation and freeing of the channel to the driver add/remove functions
  leaving only the queue draining in the ndo stop function

Changes in V26:
-  Remove the addition net-device spinlock and use the spinlock already present in skb lists
-  Use temporary variables to check for success finding the skb in the lists
-  Remove comment that is no longer relevant

Changes in V25:
- Use spin lock to control access to queues of sk_buffs
- removed unused constants
- added ndo_open and ndo_stop functions.  These two functions do
  channel creation and cleanup, to remove packets from the mailbox.
  They do queue cleanup as well.
- No longer cleans up the channel from the device.

Changes in V24:
- Removed endianess for PCC header values
- Kept Column width to under 80 chars
- Typo in commit message
- Prereqisite patch for PCC buffer management was merged late in 6.17.
  See "mailbox/pcc: support mailbox management of the shared buffer"

Changes in V23:
- Trigger for direct management of shared buffer based on flag in pcc channel
- Only initialize rx_alloc for inbox, not outbox.
- Read value for requested IRQ flag out of channel's current_req
- unqueue an sk_buff that failed to send
- Move error handling for skb resize error inline instead of goto

Changes in V22:
- Direct management of the shared buffer in the mailbox layer.
- Proper checking of command complete flag prior to writing to the buffer.

Changes in V21:
- Use existing constants PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY
- Check return code on call to send_data and drop packet if failed
- use sizeof(*mctp_pcc_header) etc,  instead of structs for resizing buffers
- simplify check for ares->type != PCC_DWORD_TYPE
- simply return result devm_add_action_or_reset
- reduce initializer for  mctp_pcc_lookup_context context = {};
- move initialization of mbox dev into mctp_pcc_initialize_mailbox
- minor spacing changes

Changes in V20:
- corrected typo in RFC version
- removed spurious space
- tx spin lock only controls access to shared memory buffer
- tx spin lock not eheld on error condition
- tx returns OK if skb can't be expanded

Changes in V19:
- Rebased on changes to PCC mailbox handling
- checks for cloned SKB prior to transmission
- converted doulbe slash comments to C comments

Changes in V18:
- Added Acked-By
- Fix minor spacing issue

Changes in V17:
- No new changes. Rebased on net-next post 6.13 release.

Changes in V16:
- do not duplicate cleanup after devm_add_action_or_reset calls

Changes in V15:
- corrected indentation formatting error
- Corrected TABS issue in MAINTAINER entry

Changes in V14:
- Do not attempt to unregister a netdev that is never registered
- Added MAINTAINER entry

Changes in V13:
- Explicitly Convert PCC header from little endian to machine native

Changes in V12:
- Explicitly use little endian conversion for PCC header signature
- Builds clean with make C=1

Changes in V11:
- Explicitly use little endian types for PCC header

Changes in V11:
- Switch Big Endian data types to machine local for PCC header
- use mctp specific function for registering netdev

Changes in V10:
- sync with net-next branch
- use dstats helper functions
- remove duplicate drop stat
- remove more double spaces

Changes in V9:
- Prerequisite patch for PCC mailbox has been merged
- Stats collection now use helper functions
- many double spaces reduced to single

Changes in V8:
- change 0 to NULL for pointer check of shmem
- add semi for static version of pcc_mbox_ioremap
- convert pcc_mbox_ioremap function to static inline when client code is not being built
- remove shmem comment from struct pcc_chan_info descriptor
- copy rx_dropped in mctp_pcc_net_stats
- removed trailing newline on error message
- removed double space in dev_dbg string
- use big endian for header members
- Fix use full spec ID in description
- Fix typo in file description
- Form the complete outbound message in the sk_buff

Changes in V7:
- Removed the Hardware address as specification is not published.
- Map the shared buffer in the mailbox and share the mapped region with the driver
- Use the sk_buff memory to prepare the message before copying to shared region

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper structure for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unnecessary null initialization from acpi_device_id

Changes in V5
- Removed Owner field from ACPI module declaration
- removed unused next field from struct mctp_pcc_ndev
- Corrected logic reading  RX ACK flag.
- Added comment for struct pcc_chan_info field shmem_base_addr
- check against current mtu instead of max mtu for packet length\
- removed unnecessary lookups of pnd->mdev.dev

Changes in V4
- Read flags out of shared buffer to trigger ACK for Type 4 RX
- Remove list of netdevs and cleanup from devices only
- tag PCCT protocol headers as little endian
- Remove unused constants

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header
- replaced custom modules init and cleanup with ACPI version

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.

Adam Young (3):
  mailbox: pcc: Type3 Buffer handles ACK IRQ
  mailbox: pcc: functions for reading and writing PCC extended data
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   5 +
 drivers/mailbox/pcc.c       | 150 +++++++++++++++++
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 319 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |  38 +++++
 6 files changed, 526 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


