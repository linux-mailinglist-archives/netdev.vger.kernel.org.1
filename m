Return-Path: <netdev+bounces-285257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA3LFuhx/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:05:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF224E7359
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCA5B3023BBD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B636212C;
	Thu,  7 May 2026 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mbdYDddM"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC435C19B
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151633; cv=fail; b=YBrHM3ZmZf1c7g+/aHpTOtQHA4EVf97eUamQhwajXD7ewZFOnoz6S33o8hEaoWh9u7L5W4taMNscsqmzopoDrxa0K1Uh5sqx3sDC2lLk2VRRTcvTPJEPYgcOCjjVBmKsOVGmCiu3TlmSNr6d0hm56d1Sr35U6JvBY2TJd9f2cKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151633; c=relaxed/simple;
	bh=cCrM9qPgp15NSDB3eh2Th3jCNh2Jy+gxyGlVzk2Wg2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGZPcwP+mSgMq6G7kqU8nPOQGYnA3HsY03ZKWzKDS9EzlXnc72gSMQYj62WpyNaJhf4zu74QiO2elWU2TQg/9qILcMrAfQp2ME/7ZV2CbJOdDnXnxWrORuVXBaGiQL66rIBqEQvoPy2oCiOyM60OI7RtKBw16SJ2wVCdWdeHQNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mbdYDddM; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSPkph8lOHDADp11qqTxgc5oSh2TabgK0/ICX62LPKHmbuTsYhQ1gWPziLrvAiyjb8EWTIiKzLv5R5xLjFAqPgmzXF9qlnHGQ3VjS5Fo4NahbglnR9nb3pcAty5DPQEzhTDVCXKOQaxZS+VlHI2xx5UpNRdHOM7gxb9mJsMgtqiN5zkO1qFuudbEZrS9Bnih1ytwxCiJ5Q4Q6R+0GmQo8keXXnjoXq8nzgpIO8hrUpi2d01vGx75w/gmE4a8bPOgUK+ul+6fCqROWStvdTlbFzC97tfKP5e/1BNs9EfJe0YgMr5HcEeryUIKpUJpjNgl6u1lo/Z1KidYIJQIS1/WZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn2ETf7KCbY3ht8GH4Ps0N675pjfr8BIVyOUW6Lo+0A=;
 b=dcHDdMatGKFJVK7H+FJlvVQMbJIoksWLECvEpuWqrZx8N0LLiBIK6psVkUJbA1DWh+Z6GaW4SmEAnpL6imCWd9n7BIJ2zgwhayxOKoa19gPwfjryNH5c43sDiQXgLYmrwbnxHdG2b4Hwpi4Hs9iT2+4yYRLgMiMn7MzqCyPPcW1uz+/Y3m8JFpdf+DMXPEHnlfH1DYn16rJM6tbbYLGqjWrDEtoNf19FL05p3J/+8zAx6xOWy1aSMRB6HQNWw3+/9EhsJlnahTSZFGr4aRMEMo/g8quRIg2oUMAptUMUONdf5UwEd/DcGfECLsA0cpp7BEdOUbEHCsozV64OlRS5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn2ETf7KCbY3ht8GH4Ps0N675pjfr8BIVyOUW6Lo+0A=;
 b=mbdYDddMS87XGiOVYbNm4jF0M5TOygTLBmQeBOqs+ZWjsEmCvit1nWMkm1AXz/btfc6dkSSZSBUiExxP6HdNhFGIGvEsiardQ2QSPdzRJvfPrsoe7WxKDPzqYsDGW/Orn2t08c/LqOLUW08DR69sVaAiIgE32iqo/pQGQdOhtxu+BBt2gWB06eFy+cXxIt+3ckaRrV7AFmDitqASwGOp3pcEZPuRRPXFX6GrRV7NGNdLALsV1q35VeUo7B3t3LvdR5YZe0pI38hyj7SLUATggTquWrdBnoRco8LsdJKVZ9uFonxvpQWwh+kEimolWPNR6aoKsbAQUmtXl7DjxTbLrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:00:27 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 11:00:26 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 3/4] net: Do not unconditionally turn on carrier when turning off protodown
Date: Thu,  7 May 2026 13:59:05 +0300
Message-ID: <20260507105906.891817-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507105906.891817-1-idosch@nvidia.com>
References: <20260507105906.891817-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: aa415022-a406-4a7e-d359-08deac27d860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+K0dTtqXJtxVickvuiu1bLiyjTmz0NVuhr3pV1u8dP4EF/Bvmx7uLNPw+XsoRXUkO8gHCBxemA9A4jzEyZYdAf7MQ3g7nS+yXV+u1p8WMkzR93EHy1l6zhOAXmdLpZVkAPcAWkJLGAWSk8zrsc0fvyOx3SxFR1ABwwRS+qRk4wM6XzthbZY3/Zkta/TCBeMibWiunpJTEZUP/TPmnVjhY3Y11J0mgArUegJnY5JKIxM50fh3f9B237DlIPdmj4nwL91DSCgnwpBfBLYIpFcp8HmyLNhSonOg2dUYhz5gwlBt0O7blVgsLpXes4R3MJY0jHRxLDJ0fVwkThF63zYQPl/YWanDoAEO4iuAlraj5Uhne6uJTBUVK8u8gslWyu40a5bGluNY+g0h1Bf+HUzChw7W7b56i8qorRIJo6dnlIa/6eh3stUUqeyjo2/8gbjarKAYi7ciWu0/dWSKADiFQvV3O6O3Nb6e3sKH7N0XQ6Cz2Ur9uEJ6md3XUtFnDhvz+IA+l8S8rp6gAZlAsUxJp5lJMRrgUq6GAnm/ftRV3+QXzQXmsqKjrGrKypZz7OHKH/rTQw+z92mpRkH18h9W4Cq60Hwk4JnfznNUSEAUuOThne0t7rbAL95dxO29mjLSV8nPNEOdAaYXFNkNRLSNhziO+o8oz+g+7j1Pi47IQViTru9O0BrfzwOEOlCkinlr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wa4GFJWisxqBJ7sDzjhyqpvr7tNE7cxNsrEeuJGIh1iH0oPq+RXttVEGTcor?=
 =?us-ascii?Q?KECr3+hIAIGZEHP1P5So505FbRo6Bf/DChjkQUFAsB744ptc9/0t/+QJKEIE?=
 =?us-ascii?Q?zebNFx+XBpQQWiYT9abCIOYvrl/IM/AEtzl611tzt1GA7nTlekugPJsldYhU?=
 =?us-ascii?Q?IPOHEUo7Rpq2kMKYuzHfOMNTFB5Shmx+Rp6P5qj5CxNmd6Ekhl0bb5dcdPPe?=
 =?us-ascii?Q?PYXG2DxQBSPC1D0lmrDQIu1RwJohWSjKpo6p0bge/CKOuV3yEflrHEaCjIbE?=
 =?us-ascii?Q?1fR04c5I+58cvhuT1bGq9uIC+wxTAFTMyDsANMMpdejzowRuNq39yoVV58Nw?=
 =?us-ascii?Q?VWgrZ76Y7OV1IJFg3f3XuD8P1H8Z0M/+yM4Tsu0H+nCc3Q/Cv0itotUwN0XI?=
 =?us-ascii?Q?FtegcO+/VkRHcDbb4ifsywVmfBQtj8uCv5TGJyPBWorZNz2uqtgvMVFxTywW?=
 =?us-ascii?Q?ofoEw2kymDBYuqorFS5p+mGWOpLGcarQ3yq2BYWjR9eR7k5JS90sxpdB0iy+?=
 =?us-ascii?Q?BCcm9J05sjnTEt/3+VgddvcO/g/eT6bj3KIQkP2YgHqI4iIu1UKgyOQLXv1A?=
 =?us-ascii?Q?B25QlIVa5X7X6u/0dZMHvte6j0nzi8nQ0bxCw/POXT57sl7s1GMhk3gQ5EOg?=
 =?us-ascii?Q?N7RqW8WsiCQYMPoaczUsX6tZ1T+5xmNRXxA0YBRpNot7f4DfqGXHZAphI/E2?=
 =?us-ascii?Q?seFAxbb3yi/nowzeW28a74wvtnO3sHPPeLekPMbP7390NQ5iYNpatAJbrZXV?=
 =?us-ascii?Q?EnbjZcqYmSSeIsFX+OhB2/M0MxyZRKYqCZNY94+AQw5XZ7QApcn82eetwFPR?=
 =?us-ascii?Q?C7qldNhoQZi1vEVu5xY2+C9xUw1/7WDoNNcZqSrYX+hbYV2MYCyDJJK/gLxG?=
 =?us-ascii?Q?HBnE6zR4x4p46CPgsesk5hj7C32cDVS136j+5nfi+xHuyOIrtzvAR8JhMJfn?=
 =?us-ascii?Q?FxoGFq3jr/kLxB9U/BbM3FABdj5Z/kFw8sr+l0oTr4AG2tHv+hVXZdLX7iRf?=
 =?us-ascii?Q?dmvKFKZhk/HvZiHqrcrd1JmAc4vgULB6gfLtyTgkB59zED7lGObeh0qa2HMK?=
 =?us-ascii?Q?+MK6bg24OHRbXjlWO3h9tCSVYUTzd+6btVWylg+2F+lexedZM8b+GykeoSN8?=
 =?us-ascii?Q?TFd7KCNR8pUF+I5v7NTsp1R4sbjlRvXQvoOIf3Dx7CdRZKk7vfuHd2UhBp0S?=
 =?us-ascii?Q?uCR46AqpZbJ6xGnC4RNzb5CU4y1l6avKOOvhbIdvDX5qKdy749+5eBJ4sjD9?=
 =?us-ascii?Q?AH2SW+lIsVoRk2Sl7/bKUHJak9tuSqeHXjN5xL8kZPp3IjsvD8QVDQOV7hR/?=
 =?us-ascii?Q?uULQHoLn2JXMtP1K7P9hpxb4hOXTL+xz7NUtytLU2biz4YfzzMUiI+Nld9ap?=
 =?us-ascii?Q?l8tjLVqEiWgAvYHkKLgWLy0/uqGM+kMMjvVmPX8/DerBAmoLRdlrSIeS2Cvi?=
 =?us-ascii?Q?jr5uTZwFeldD4zSIUkv6ERbH4Iw57gdeDcrlhDW3SedWJ6YcnTha05kl6d9p?=
 =?us-ascii?Q?n9MbYMjUU1InX0aB91Eb1Dlq6KEzq/lnRoOzoOq0av/ZihsQHlpm2qPZ4jEL?=
 =?us-ascii?Q?am0caVGfWW7anB49lpAaQ+88j2iWBrSQIQmBw+v4giV5yF/mnWXdXUf8IC/v?=
 =?us-ascii?Q?fOJ4utIiBFcr2qkVezfMIkeUi61lZhVfY2hRvQF8RRwBO21BVFNEThoA2VYv?=
 =?us-ascii?Q?wzfRhTuELXXZX7Y2QoixweydaF8LV/XrwEV9wn0MjYKdeAFX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa415022-a406-4a7e-d359-08deac27d860
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:00:26.9277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbsBpLCaPetQXfnzWypV67ZKQoBdo/q8Wl/ZdL7akmF+AsU2aaD6waFCe3o54ULlRfV+TqqiwFjb6yspic5Csg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Rspamd-Queue-Id: EFF224E7359
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285257-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dummy1:email]
X-Rspamd-Action: no action

The protodown functionality allows user space to turn off the carrier of
a net device:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>

When protodown is turned off, the core unconditionally turns on the
carrier of the net device:

 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

This is wrong as it means that a macvlan can end up with a carrier when
its lower device does not have a carrier:

 # ip link set dev dummy1 carrier off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Solve this by resolving the linked net device and if one exists, inherit
its carrier state when protodown is turned off. Otherwise, if no linked
net device exists, as before, simply turn on the carrier.

Resolve the linked net device using a new helper and have it return the
device itself (in a similar fashion to dev_get_iflink()) if the device
does not implement both ndo_get_iflink() and get_link_net(). If the
latter is not implemented, it is unclear in which network namespace we
should look up the linked net device. Currently, this helper is only
used for net devices that support protodown (macvlan and vxlan) and for
both it returns the correct result.

Output with the patch:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev dummy1 carrier off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/dev.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cb6e90058619..0c272f6e9aaa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10141,16 +10141,35 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 }
 EXPORT_SYMBOL(netdev_port_same_parent_id);
 
+static struct net_device *dev_get_iflink_dev(struct net_device *dev)
+{
+	struct net *net;
+
+	ASSERT_RTNL();
+
+	if (!dev->netdev_ops->ndo_get_iflink || !dev->rtnl_link_ops ||
+	    !dev->rtnl_link_ops->get_link_net)
+		return dev;
+
+	net = dev->rtnl_link_ops->get_link_net(dev);
+	return __dev_get_by_index(net, dev_get_iflink(dev));
+}
+
 int netif_change_proto_down(struct net_device *dev, bool proto_down)
 {
+	struct net_device *iflink_dev;
+
 	if (!dev->change_proto_down)
 		return -EOPNOTSUPP;
 	if (!netif_device_present(dev))
 		return -ENODEV;
+	iflink_dev = dev_get_iflink_dev(dev);
+	if (!iflink_dev)
+		return -ENODEV;
 	WRITE_ONCE(dev->proto_down, proto_down);
 	if (proto_down)
 		netif_carrier_off(dev);
-	else
+	else if (dev == iflink_dev || netif_carrier_ok(iflink_dev))
 		netif_carrier_on(dev);
 	return 0;
 }
-- 
2.54.0


