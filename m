Return-Path: <netdev+bounces-258592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Kf8TISX6jmljGwEAu9opvQ
	(envelope-from <netdev+bounces-258592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:17:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9164134F64
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A85A301CDA8
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAD18FC85;
	Fri, 13 Feb 2026 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h1h9YM+z"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558E74BE1
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977825; cv=fail; b=JA9rYh6rtBQ0IvsLQOGirrGEO0COL62BnJbR5jk5SRWKmvE+5rrsswZD4tjBZYbfEY/opgkzPcNZqKfrSpE+j2XcsOp8idbagVlKii0u6xmDaa0HJtI5RL+kggyDr/ZZKW6UxzqG6gh+gMwC6fTjnumrrSxDzbmq+grn1FZ6IEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977825; c=relaxed/simple;
	bh=A/5xszGJAmW2OlYMqsa2labPUs9lYx+KmzsTMyN8WeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bNUzonQbXlZF4O/I8z4wXp0arc84hObD9S52pW9wU4eRJ6X8Z2YhdQx1M7h/dcWQfT0OFgVMS5ocaf8G4JzrGq4asMwIL+I7CDWFCER1kUS+mmyY5tmRsh9Nl88m+isFbys3QpGg3lUXIQw0o5Z/9CsnouwHjGGZFgbQMM+UHt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h1h9YM+z; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF5Dexjn4WturrX2rwDhSJLK7fcu57OyQ+CPVb8WwYHXYYVt9ILAKK+YficO1Iyq8Xa+oOiYjPQh8a3J48KdYSzWwdDbLsDygKqMAC120ELdmb9wTiJus9/DrB/BbQj5GCw/orZZhuJJQxAMHKMyRv2tfpnVR6huA2ew9uZ2FLEf81Ljbb/bFuPpO5YKMP05yo3Ime0cc4JehXzHqVYR894T04rP8HO2cFynWl9zkZ64eVdZL00Cvj4ABoxnJKbPM3X9xumeetnTpfcYGc9A5WnfWwHFvwEYuPRsPdEGmqi8T+hbVEXMfv0F/ZWUYSRuAJfAivCbIQAdomknlv1eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrp7mbOgoPtNRg/KqiOHRuOoQmKcvobVpWUzZttVmSM=;
 b=Wo8neC1wx0yX++yIUcpw96seDCL8sRYev+YcRznrBgsuk0ERPy027xqfGoXtt4a5etIbKx4hvz46Ozgp5+v5RDh2oRHIIyg3uoJxJviro3ihgEaAOPcQGh6+zLdpxb+P22RDhU/Zy0BEdGHLfNELo/Cx8ZqvnM/hCIFRY97UAdm0KULD29j7AehcRi9mcuTF0aFb/YfHUT0xbIkXtJoUbHow81VbHVNw8vz76ZPYI2TC3a8ANV62be2Lu7OuBFffuxKL1BhCXKqhkVb70ca2Lz4Y8bx4y2x4y42Fu1pB5smaKD7xy0LD02TlTZH7yrXDRLDwVJ9shB9mtrX8mKqieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrp7mbOgoPtNRg/KqiOHRuOoQmKcvobVpWUzZttVmSM=;
 b=h1h9YM+z0+5hZzpeSastQ8JeUsRCh8HPjix3o7A6Rt+08QBRQtJpRUWaVUAyZAS5SpHttaq2+HxztuPVelzNdVVhDBxcLz/sLDJqtjZ63VBA6Thqr/VckvU0CH1fIbwOBCOglH8dfclvYkuVnpkpnN2oSpwdusRuxjRFv709cywbh0UXD1FvJCRWJKay64SzZizdhb0wW8TYoneUMRcp7ryx5EX3FaE9B3Q6/qrywJTuQfZPsKydq3INMQT5oBgBFr9kvlF6p4v5n7PFupbhnneDigHnGUl//1du6VAethHn0yeLJaxd2pXOIAgD6sz+Jm4yWkWEUeEJ+ng43p3eNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Fri, 13 Feb
 2026 10:16:57 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:16:57 +0000
Date: Fri, 13 Feb 2026 12:16:53 +0200
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <aY76FfhYi2jcZcaT@debil>
References: <20260213095424.84636-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213095424.84636-1-liuhangbin@gmail.com>
X-ClientProxiedBy: SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::21) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffa4333-c615-4b60-fe7e-08de6ae904f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?45DMSFVp7lVHciw8GpJBrroZ2ynYlPMC6zqO+URgtt4FlgUJQE6j91EqlwUL?=
 =?us-ascii?Q?xGxW9qH1By2zSC03N7cO/WaS42MOdMFdB6gy3dvTojFtqwJWWk9SJw1EIPBz?=
 =?us-ascii?Q?aWN1wRoIW+2A8ju2FAz6mUd29PIlbtb674lv8ZE3pDblPtAPpOFexmi08y1w?=
 =?us-ascii?Q?9JdgQfjUUtje8D65sONdSLpqtyCNQYl+8UE00oWmswD/Jcob5jo2JG3H7Xcw?=
 =?us-ascii?Q?bB/FgJUxOLwqBzEqWs9nPF7tDP267VP3Flm09wPY7Lt60gKJtOXsV2HvQMeL?=
 =?us-ascii?Q?LmPJBJ+TYC1z8JpPtsxBPbGZrBuumhnmfX9f7qd4tcc7lhIrqPnCwiS1LJaN?=
 =?us-ascii?Q?Mu1m83pR6tvmlq2nZOC0EI48EpgVUNrKiQduLY4QXt/ytbDYS+TsVWyJjE0H?=
 =?us-ascii?Q?FdezjK5AOIhNC7aglu7w+nqOWOVbj9QWVMFhxmZnP4HV6yZhtwzFDmpbjYth?=
 =?us-ascii?Q?5ldHKHcWFjW5UxmbAMBcvG//OeaIUV6ddwhYHDH5J/COTSEz5wNC5FdhzSNC?=
 =?us-ascii?Q?jb8Qqy3rrJeXAa9VwUAjZUGj4jNW9aP53JEJAj3FcfDuvSRFAfQYkmSGkZZ1?=
 =?us-ascii?Q?FAKFa433Mfr/nsip5ihbPdJwWzz/qLKfAutgprHW55Mt+yzvF+l0oZRqP+O4?=
 =?us-ascii?Q?aApEJQTf4CU7+ok/A0/sTXMfC7HGZHN/ngvj2VKQ5nBuZwMa/+xBsa8G0OXe?=
 =?us-ascii?Q?+uvbbPyNTVD+MjBLuygnKa+P8mC9Bxalrwm5kinJWL15b9e+Ubg3OOIEkxzx?=
 =?us-ascii?Q?YtjWVOu+cmqHj3HMDYuXk+2b4zyLwfvjNQWhkUgrpben+Ya71t3uOHePq4XH?=
 =?us-ascii?Q?+CkpldeBgbodwxjw7z3ENgYK/5uaySs1af/ezVFDuCZgdrmpzHAyaCcy1mxc?=
 =?us-ascii?Q?Gp0ErT8Sx+XYjYqwvwK12T6BRY3mChymxOMT/p4o7E3W5p9egtEirsKm2HS0?=
 =?us-ascii?Q?UekN1cb1BHEY1UO6gcVxviY1WtxHsG+25pAPSCSOGV6gjIkpg2BhOZ8GHLSM?=
 =?us-ascii?Q?M5QvzCTz400OD2CC6UX6KymsWMIQdDTgkp1UundusDO2J9pIrYlxn9HC9Et4?=
 =?us-ascii?Q?ZD2sfowkkVaLpzEplpAMyzXPYH5A6Bc1AGn0sFCDQKpipzW40gVvkszRXJwA?=
 =?us-ascii?Q?TvU7MjpxWVPyKte/WIROD8l2eqei3/Us1M+Umv5fQhWf/MBThqwW1lXZEb96?=
 =?us-ascii?Q?iATsLd4ZCkFWY2VpIGF1WuvqI0tl6SI7CUTggSwWepbIBSi96wIEjU385R1j?=
 =?us-ascii?Q?VQN2xNMRBbl3Fos7MwHhMj6rpc+tAgJIvRj+kGvtPTNxqC6cd1IiUeSNrSHn?=
 =?us-ascii?Q?d53wGNdAcRJ7QFUgghfRY3LN+fz19bq8sUTnySW+bMye+q1V8NzO/d/lPHKK?=
 =?us-ascii?Q?Mejs9oRn1TJ1UdgMYevtPDqUrxgaWwn8/Dv8qiAZ/UD6nIRKsNErZr0R7Nlh?=
 =?us-ascii?Q?NUVRTichGKVIHhHGBSivHr1QqIzXRLH7j2E3vTtSa9ayQucIIgcgsDWEvFWW?=
 =?us-ascii?Q?5mnLU7upUz7EF4apMEI1zmaFTgCL5Xox7zFleHrX7kZWUVXHkdT78JxcBPx/?=
 =?us-ascii?Q?fiCtxUUs8Mk2R1CUmEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZgc5vcOv7SmCtsDf3hVVw+MDeNDzf9xZhUkLvftaaHjr8ihPdfQb+Xm2AWk?=
 =?us-ascii?Q?NPufLVy1h1xsnv8aQ1EbQDMTw4oGpzR7ykSnxO6jRNB7Re3ZUOc4D/8YdHJh?=
 =?us-ascii?Q?IsfWcXRrjermHqeZJHQ3i5Ml2a1gZ5DLg9nRkW85B0BG5S8QlchbsVslMhJN?=
 =?us-ascii?Q?4K2eGTRa/2y0FvylGDORvv2puODRhz45Y5pZD2e4gNFsfF5CECxw064eH3cE?=
 =?us-ascii?Q?VcKbqzsK2fcpxcMM8XYo5fNdQJWl7+Tfmhg9BYyFp5MaXi4oT54++5UQCoQe?=
 =?us-ascii?Q?d5TrSgwRmiRinWeSXVc1MNKiX1i8OEaVgXzP6oEimHQ2U9Jh189NCtG+wbHs?=
 =?us-ascii?Q?9T3Y1SlT8TTPGJBtkK8vixe1Dt/NTfaceZ6us0ZPXeVz5IcnbpzaViUCWM6D?=
 =?us-ascii?Q?CCYEUNWOplTqBRdAZUqibimUFueNOkMlqVgXjih9OlO/QOI+MSprL+xt8LKx?=
 =?us-ascii?Q?1Rkh2k5j/2F7tk1QtN+M0pk/nMu/ej+gEIMmozh+SdmYN0NTI9jv+abR/QYr?=
 =?us-ascii?Q?fKqG5y0YrnCy3PPqBPTv5Qw2Lx1xgwNrqbzOpdjV2NFVfn2PL/GqbQgvB0xF?=
 =?us-ascii?Q?/iACz9OKQUjpLP3eYesJhBSwFRcHEmmQc9jABCIc6l5B9iALZxys/P4IICto?=
 =?us-ascii?Q?yZgneXsRGeG1bJxQhA3cBrcClt98q+xelqtT1vBWpgHxsGTICidDr6xsPSlh?=
 =?us-ascii?Q?ZZYpZtZcIuCONVmzrsJ2LY2NXOCeSPUlGd+Tg9tqPJiZUYXlID+UqKClHuxw?=
 =?us-ascii?Q?HqQZOodr19mcklN+EnwiLB6QtcopQdKWh2xmsr912qsbmk/BuhTg/hmV/O0o?=
 =?us-ascii?Q?Zlw2YafkbGS8i8eELzEGZLq+D38vlkrY0+TnAhD7j9p3Z7SEPBmsufocsqz6?=
 =?us-ascii?Q?QJM4VzxDjRV2jR2DyYeb13rcEFikcLxCN0kI25cGPnETEbn8+Ay8LmrJCaSU?=
 =?us-ascii?Q?/kWBgqALMMJnbFS2NG5Rl6HPw0zVyBXrpfEJQgnARUGqj123gi0tFjE5JQdM?=
 =?us-ascii?Q?UeaOeHCYpk3y3x13miKQZA+JDTR+Afw2q7UJYhlcj7KRwmXBi9yk38jGsV3A?=
 =?us-ascii?Q?z+JVvO7EnmXrctoF9yE4W4Kh/RMfVR0vpc654ZgtXhTPADJuYzP6xjxPp7/E?=
 =?us-ascii?Q?eVU1MZmTnp7sV5GYDoNx2YI/Dz09e5wwqW0JB6dVWDb1SGPfA9+fBZz/eylg?=
 =?us-ascii?Q?Mya89vs8cJQk4WRgbYbLWtybBSZ7qbZlijXWdcO43RX1XMLCXE1jc68cdaOx?=
 =?us-ascii?Q?xdkEr9P+SoJPEQAcBREL0kbNUc2PW5dwMia7knNlQhWz+HQ5ALNgR8AGh8/m?=
 =?us-ascii?Q?ZieMFuLevd/faFc+uiaAv8pwnGQDFGx+FOI4zKKc6ysjUCQdOtUFgswEV5os?=
 =?us-ascii?Q?4m8XEYrNl95KP5VMFUWa2bjp7WPUkNzqnhM3fPJIbpqK55t6F7AhzQe8/ZPF?=
 =?us-ascii?Q?leMS92l0PFdiEA020aRU3RlfDE/LtkkgE5hV+6wlX5rRbksxeJCwGyYXYv3G?=
 =?us-ascii?Q?+XHZXP2nNeblLHKBvzpVEFRb6o8kWKZ2jPNJQ8beMjhUUVXIRAfKPSGHPF5r?=
 =?us-ascii?Q?OcfN7jkVqqDYD2eosfjNWFzSR3IYNfcYtMBugWnj7qjFfWJNcPQryX5/iTWJ?=
 =?us-ascii?Q?/55KsXmK6xjKlVvB4MsJQQwpo5rs3WTzYy+Yq5qvqGBBRDBqMwcZZD/lozXo?=
 =?us-ascii?Q?TUdaG22MPMx5Yw9dssw+Vpvy6hq0COUV07QLdVuVg23AtHlCYHOd/WZVeW7w?=
 =?us-ascii?Q?BGHH9oqp9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffa4333-c615-4b60-fe7e-08de6ae904f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:16:57.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je/Uns9eYrEdLJu0OaRqUiTsyXWyZXhO6ZESH2mNx4CX8jf6gViBDmT+qvtdFPM0hUPvsjKLeQm0AgjYUNTWnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D9164134F64
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 09:54:24AM +0000, Hangbin Liu wrote:
> The ALB RX path may access rx_hashtbl concurrently with bond
> teardown. During rapid bond up/down cycles, rlb_deinitialize()
> frees rx_hashtbl while RX handlers are still running, leading
> to a use-after-free detected by KASAN.
> 
> [  214.174138] Oops: general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] SMP KASAN PTI
> [  214.186478] KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
> [  214.194933] CPU: 30 UID: 0 PID: 2375 Comm: ping Kdump: loaded Not tainted 6.19.0-rc8+ #2 PREEMPT(voluntary)
> [  214.205907] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.14.0 01/14/2022
> [  214.214357] RIP: 0010:rlb_arp_recv+0x505/0xab0 [bonding]
> [  214.220320] Code: 0f 85 2b 05 00 00 48 b8 00 00 00 00 00 fc ff df 40 0f b6 ed 48 c1 e5 06 49 03 ad 78 01 00 00 48 8d 7d 28 48 89 fa 48 c1 ea 03 <0f> b6
>  04 02 84 c0 74 06 0f 8e 12 05 00 00 80 7d 28 00 0f 84 8c 00
> [  214.241280] RSP: 0018:ffffc900073d8870 EFLAGS: 00010206
> [  214.247116] RAX: dffffc0000000000 RBX: ffff888168556822 RCX: ffff88816855681e
> [  214.255082] RDX: 000000000000001d RSI: dffffc0000000000 RDI: 00000000000000e8
> [  214.263048] RBP: 00000000000000c0 R08: 0000000000000002 R09: ffffed11192021c8
> [  214.271013] R10: ffff8888c9010e43 R11: 0000000000000001 R12: 1ffff92000e7b119
> [  214.278978] R13: ffff8888c9010e00 R14: ffff888168556822 R15: ffff888168556810
> [  214.286943] FS:  00007f85d2d9cb80(0000) GS:ffff88886ccb3000(0000) knlGS:0000000000000000
> [  214.295966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  214.302380] CR2: 00007f0d047b5e34 CR3: 00000008a1c2e002 CR4: 00000000001726f0
> [  214.310347] Call Trace:
> [  214.313070]  <IRQ>
> [  214.315318]  ? __pfx_rlb_arp_recv+0x10/0x10 [bonding]                                                                                                  [  214.320975]  bond_handle_frame+0x166/0xb60 [bonding]
> [  214.326537]  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
> [  214.332680]  __netif_receive_skb_core.constprop.0+0x576/0x2710
> [  214.339199]  ? __pfx_arp_process+0x10/0x10
> [  214.343775]  ? sched_balance_find_src_group+0x98/0x630
> [  214.349513]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
> [  214.356513]  ? arp_rcv+0x307/0x690
> [  214.360311]  ? __pfx_arp_rcv+0x10/0x10
> [  214.364499]  ? __lock_acquire+0x58c/0xbd0
> [  214.368975]  __netif_receive_skb_one_core+0xae/0x1b0
> [  214.374518]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
> [  214.380743]  ? lock_acquire+0x10b/0x140
> [  214.385026]  process_backlog+0x3f1/0x13a0
> [  214.389502]  ? process_backlog+0x3aa/0x13a0
> [  214.394174]  __napi_poll.constprop.0+0x9f/0x370
> [  214.399233]  net_rx_action+0x8c1/0xe60
> [  214.403423]  ? __pfx_net_rx_action+0x10/0x10
> [  214.408193]  ? lock_acquire.part.0+0xbd/0x260
> [  214.413058]  ? sched_clock_cpu+0x6c/0x540
> [  214.417540]  ? mark_held_locks+0x40/0x70
> [  214.421920]  handle_softirqs+0x1fd/0x860
> [  214.426302]  ? __pfx_handle_softirqs+0x10/0x10
> [  214.431264]  ? __neigh_event_send+0x2d6/0xf50
> [  214.436131]  do_softirq+0xb1/0xf0
> [  214.439830]  </IRQ>
> 
> The issue is reproducible by looping ip link set bond0 up/down,
> where rlb_arp_recv() can race with rlb_deinitialize() and dereference
> a freed rx_hashtbl entry.
> 
> Fix this by setting recv_probe to NULL before calling
> bond_alb_deinitialize(), and then calling synchronize_net() to wait
> for any concurrent RX processing to finish.
> 
> This ensures that no RX handler can access rx_hashtbl after it is
> freed, while preserving the existing locking semantics.
> 
> Reported-by: Liang Li <liali@redhat.com>
> Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 47f13d86cb7e..8e1057a2a061 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -4314,9 +4314,13 @@ static int bond_close(struct net_device *bond_dev)
>  
>  	bond_work_cancel_all(bond);
>  	bond->send_peer_notif = 0;
> +	bond->recv_probe = NULL;
> +
> +	/* Wait for any in-flight RX handlers */
> +	synchronize_net();
> +
>  	if (bond_is_lb(bond))
>  		bond_alb_deinitialize(bond);
> -	bond->recv_probe = NULL;
>  
>  	if (BOND_MODE(bond) == BOND_MODE_8023AD &&
>  	    bond->params.broadcast_neighbor)
> -- 
> 2.50.1
> 

Ouch, good catch! By the way I have a (very old) patch that properly
converts recv_probe to RCU, currently it's missing any annotations on
the write side. I think I'll revive it when net-next opens up. :)

Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Cheers,
 Nik

