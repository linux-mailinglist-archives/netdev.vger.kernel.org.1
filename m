Return-Path: <netdev+bounces-232186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD53C022FF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673FA3AB76F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10DD33C50F;
	Thu, 23 Oct 2025 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8QskGJF"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7C33CEBC
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233970; cv=fail; b=hV1YrkjR30c81Ey7q+SrXNzp3Iboml+KlmMJGZ0Qs46vLSNu9ST/AN4RPtoI3tU5KVv/UGbwYu2HWiab7n7XLfoMiaotcNLSV0No+btwSZKm6t9Y0nJ1AdpD0POI6zp5O1iytDqfZyDRyYuroggpsaD5+mL94WRgrXpvPe0LoLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233970; c=relaxed/simple;
	bh=V5gOKnuK/5ZSmrRCcNZd2C5Eh7Aia2RE1uAajP3CLp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/9UijsScUytJLJy4rB0gu4KSLzV6W3w/XlnWYvwYSXnyDLGLlrtuwht/YUKL2Pj3vx9TpLuFJGPsrYMUwmkCTf0O4sxIxHkhecvmDAMAHQbT4ajbE/iOVe4+OqkcEDwEroPEmWyKY46azkakONM3u+4e8ZqzqnJFWUhKW1negY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8QskGJF; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8IAjtYYx0tYOjXi8MzYIbvFqnk3d26cwga5WJDokxAMiz9nqqAbH+HbN4eUt7XfV+7P98FpH1RRC65Yus2FOMlNVW7jZ8HFtgJ+JV7XHGj+W0BArHB5A27k/aDUXq53IxDsfqjnLR/mLSSkd4O3vxPCvn7ljCsUpfQGWOc1lPWhFwiCrNzMzIBTilcq8Bz97o02gqAgpvRVGRHt+FaAhcIdaO39s3vkdhcArj7tgW3ID6BT1bQHonp17SQnuoP4nzYL2EnXaISlD9zZpuC6AZJLYlZrvu6Kegsi0rNSDxZqOdV3GDoVhn3gwk0t1Gww25ibH7eH94x/cTHylYd1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV76OJvHtQIu3kVK8O2StoDV/YcLqSHffKvbI08yri8=;
 b=KPtPeRVbVc4Ax9ApxWhQcLJbPodQ/is/FlcLh+4zXkvL/4aoId18d8V9tPosIWOhJdaG81A3RTD6VG7P25QvjkNLTa2gtdyBrP0nPDdH00vcPC570qH+IDdUC0OXPeAmXl/Dt7YNxc4cQoRMs2sQMK9jUqwmTTP4GFp7+j9/4gYRonunH7+/aJLrqwN/9GM0UdMmMOYbQqcv/9cV7sAkEj208E1IomPpV+MHcaU5eqGUUyZSQTCkjA1JRbXjChxfYL4u907zGQgUf5gwGMUq7V7iwxQYPF5/X/snM7KqyI+d6/bNR6IPLodhzC8EODFKBw0dmew0h+CZSS0j72XJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV76OJvHtQIu3kVK8O2StoDV/YcLqSHffKvbI08yri8=;
 b=Q8QskGJFu2eSGT5A/W82wfcHDs1P00HAMyoW5LSPc/IUZT+/04Wovl82forn8vJuJC2cv08S/bNWCEx8a22efGTyfXiHYo2saqC4Tjj33Pjz9Mpe3fsyoRsTKxR1gXAUmWGX9KzCnbJ+VXMxRFkU8OeRAA2m+II/u3+08tSy/N42rx56P6aVwlYuJt03izKmyUJqCA4Yn3dtnU+aglUvVci7AsGQ9DRsQJvyMy7P87FghITqqmSgoPGSO7Ty2QoSeXJGVgL8nAc0DplFkOwQstY2+Bn9SDqfpExHqt1lmQgKJbZ0HLG9zLKo97pnLhagwPWrR/QaKiya0rclijerPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Thu, 23 Oct
 2025 15:39:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:39:24 +0000
Date: Thu, 23 Oct 2025 18:39:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	dsahern@kernel.org, petrm@nvidia.com, willemb@google.com,
	daniel@iogearbox.net, fw@strlen.de, ishaangandhi@gmail.com,
	rbonica@juniper.net, tom@herbertland.com
Subject: Re: [PATCH net-next 3/3] selftests: traceroute: Add ICMP extensions
 tests
Message-ID: <aPpMItF35gwpgzZx@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022065349.434123-4-idosch@nvidia.com>
 <willemdebruijn.kernel.2a6712077e40c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2a6712077e40c@gmail.com>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc6fad8-135f-435a-9c04-08de124a57b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6vwZX0sGZnmRV2gqZifc22Zv4sQdkui0Onn1RgS75N95jjo8XpYrwcud2on8?=
 =?us-ascii?Q?dSHQ8d981ULAA9fXDeV0o9NujeCjUtMetwj5GqqA+E6plCF/t9D5WiTB1bCy?=
 =?us-ascii?Q?YfstdT5MhoPJY7/jg2NfT7U2deVhTgpfVleNiRoGrBTfLJmrMxjGaaUIDWij?=
 =?us-ascii?Q?36eUisrhYPa+Z9zlVIbJ13d6WajELXfbzfrK7LR2i65Fj2m8/9SvpLFJA4zo?=
 =?us-ascii?Q?ISR8qgbiemaiR8qOqGhYb9Kgauof64Ju3zjKvrs2QUB17lQMuVJIz+/G5S+6?=
 =?us-ascii?Q?jQEgbZ0w+cqwq93B9LvuuLunST3WWXzfX3AedqOF0jVEIN6RAzcCFzFh08qc?=
 =?us-ascii?Q?LMSSqMjsCBM7xRR3conIdZUJJoa4W9+5yr1XhLPSiMo95Tbobr8g1+hf0tj4?=
 =?us-ascii?Q?1OK2TFo1oQJzIIgusVZgi/1dfcSGzGU28dZ4Cgn4jGTQ6I0hsfJkcF0Zr9pH?=
 =?us-ascii?Q?QcWcfWLUEHM8ZqbBrg038NEnL23B74YZzJd1z4bMZN8ymBQ6i8M1FAvxoXcl?=
 =?us-ascii?Q?8RHzDn2BrjoPcUmtnZsWfbaRl8p7dzfb+tpCmbBZ5kA38jO+5nVQyoZZmLwf?=
 =?us-ascii?Q?QJrwT6f2fPHfAHqSyZOLaRikl7m2XVjftYwB27G5iXeFW6ijvxXBBwnVsKvU?=
 =?us-ascii?Q?aPkj14SFZtGt4crOPCqiPSo7YQkNZ1+InxXM7AqB/0hhZVyTXcqGeQJTYRLt?=
 =?us-ascii?Q?SGRH+4QlhgB74vAstiw26gQTe6ab0s/c5Ja9KriUBKBS/Xho18pO3c7xB3P1?=
 =?us-ascii?Q?W9MN/LLuz45mTXLLzC8Fe7laSunm862NOmAWY3XcJNLjn6I+FsUl/GDFQHyE?=
 =?us-ascii?Q?hESRfkCbQzXwXnpits4KWQ/Isenpubh8WK2l/PbETeLJ/yGX1JKkUDvLY/dt?=
 =?us-ascii?Q?wuY5+kkVV2KI+2Am/aYSXiURKYJ+Yjoq+5mF5ShHoqjwPyeA4BDG0yT2PWtR?=
 =?us-ascii?Q?wfuwwjwMJ/3gVeZW19sfCJ1g/cw+0HTn/eIi1BRvEofAA8Qx3vCFP6TwW5TT?=
 =?us-ascii?Q?0qQ5uMjj8beI30C6K3DjwHI2H2eZBYuQBvxmaUU/y0j6zSaAoS3r3/29JplC?=
 =?us-ascii?Q?RoNNExLgx+qLAHjz1ya+RyjDTHdGYhd1fxD8jyBwF2eHgAlCLHNDaKdqsh3e?=
 =?us-ascii?Q?HyGSDdh5+l5lBF3QIX7EDGds7yoo3O97+78lKcxsYgjYNwOfX4QSzgoZtHRS?=
 =?us-ascii?Q?mqE0luQ8ZtJ3+IcVJsRGe5QMXIAjkw7VC084c4FloBUxZ1lnXdI/IPTT0bfR?=
 =?us-ascii?Q?hdw/XF2jWJb33JFsKiM5a7PJYEMNNyDDvFjeqWpC3wAb4NV2H62uXXmEXvaC?=
 =?us-ascii?Q?lDvbDitkKBhXj/aeLRPBnv3WTCoj5khrhd6dhEc1EXCOsAkzRg1FZ2wMCMq/?=
 =?us-ascii?Q?QuqlDzMjTvv2vMVByYtVfp8wq6vBYJ7XtAOcKoAO9scR3Ge/dIXsuJgkYpFA?=
 =?us-ascii?Q?NWhJa+rJ5XWAVfKN08W0X6BoXhIOI4Hd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NBJrxKFSEZGX9gMWNzao5EqfkO0Z3+Q79wOpCVvtRTNeOZLaZiKMtjWTQqCL?=
 =?us-ascii?Q?tQs1vxdpNxTNLym5w5dx8tVBNNJkg9pkdN15YNGq0idX+49SHxuiZdqAikNG?=
 =?us-ascii?Q?K8enUYaKg5rWyv8WJ5Lx1t9fh8sRVUAhDxE9Dqwow7vE9+b2boxihouoermy?=
 =?us-ascii?Q?K+Ks3dhUksEPlUWrRwsjguOHWfMNU2v6G4/cqLLcxWt1/Ws1TjsjsRwVKBs4?=
 =?us-ascii?Q?GzCM/+sG+ldcA0R/HPk4MZsH4A8nDzifvyRxmASbasZOPY/PS2MgSSrMlbfD?=
 =?us-ascii?Q?wNSK+1b5PJLmZpvq73L6RLt8e8U9U8TO0e/3tmru4eCoCQi5DZuklHH94lJW?=
 =?us-ascii?Q?DBhZ52tmNlBdPTHMkL99gPUH0jvi1jeK73ckTVaoTBNVKfBjBTlMQxFwrA2R?=
 =?us-ascii?Q?N7QGrPWX2ZR2IlK8bIQwkpY83KPwAVjzM2fAQoEFxmKEplE5C2EHAPgbOQUX?=
 =?us-ascii?Q?ce3fjkhazk7+QG7JTBWYjP1QWnf/C/hyiuNO0dqtHTv8VsKMkvlyOUmwLC7O?=
 =?us-ascii?Q?rEYAZZDGExErIbUdmkIS/1ESrEi6q7sRyw/yqP8xOjyCx8xbnzUwI+GBvu/N?=
 =?us-ascii?Q?LavwJbCvjxyhEOmPNIfemKdZJ6KIVCU0K9w6+vthAHaI3sJ55OI/pJncaN2Y?=
 =?us-ascii?Q?0NmSVWTrwTYCFpoOW8wVA4KM4x3oE2jaqZf5ILUsJnBfn6gRN1nCd8zIzRcV?=
 =?us-ascii?Q?f4qG26sFkfa2jdzXMt0mI5ubWlJCDtVsyW7oQSCj0snGPYcN9jahXQ2ds2b1?=
 =?us-ascii?Q?Sx3agzzc//Q3j2ijUT8IOt1TLLdxWmplIZvGYWRKXV3SN8cnPFxPkp3gN2hd?=
 =?us-ascii?Q?FPCgBl6o61Wtj7/13I8A/TGi3em108vR5zhdl/YviO8AKWJ2eoxYZAlzX3vl?=
 =?us-ascii?Q?CUL2ytZPloJzfEU8QdCEO6zKPmbHK9flsn0Wl4RNmqq434m84Ysass84ZWTQ?=
 =?us-ascii?Q?jkipWMvQzxCKz5WxvP2uQnRPdRFUJ7X57xR/uMt5X0Yn28lzBAejlQ6612bk?=
 =?us-ascii?Q?KwHf/hlKjz+2JSAkSWsnOHkcUQpa0zmfEvWJc4gMl7ExQRi5RicDFv5NkyBT?=
 =?us-ascii?Q?b8bMeGSFXSMf7/TBCSf0+mDQXMfGClpP+wYqMF697B6b/2SciYP7QR3PLjZx?=
 =?us-ascii?Q?jTQdZL7KQW2BywjEAylqZyNUmW6lR+Ox1XV4ITHLxCo99Vx1mo9+b54V0McM?=
 =?us-ascii?Q?T5ZNKzhGg3YzzN33cVeLdbDUnNZDmd6b4KrEzwOsGioc0VO4DC9AqDzJG68f?=
 =?us-ascii?Q?ZRmxdYOzKwYX8FVuvcMZ3XqS+S3UnVuUpaMqPc4PKBqo/HL2DaEn9YVGjABQ?=
 =?us-ascii?Q?XDkIjxMNG+yGW2h51sDhV9m6yYiuqCt2/K7hWQFHdWcrZE17Yp627BlwuMW0?=
 =?us-ascii?Q?DlrR5oRNtuwiTwn32VCMgJtR3q4S8j2jrzQm534rL/7QrDsXM9URy5dT8ehR?=
 =?us-ascii?Q?pExf1Lkjkmk53npNMt6ZWzz/+oxJCK6xSD4e290A9xzyFUPWzkexutzsT+qL?=
 =?us-ascii?Q?5ynBI3ylVaigpdFm+ikSt2ReYj6uPOY0+2nzw712ke2qrRUGM13yETci9OrM?=
 =?us-ascii?Q?ArekEHlcZvOFDeQnpW3MAfslFiEFZwITPWk0dtoi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc6fad8-135f-435a-9c04-08de124a57b5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:39:24.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etGpcEOl9ldPLPvZ1tHuMQx0rzJjLnmpWVRgAymhEE42bGqAjuar8L21TRiLnrohZjMPD32uNHzixYVIQNXkfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768

On Wed, Oct 22, 2025 at 06:12:13PM -0400, Willem de Bruijn wrote:
> Ido Schimmel wrote:
> > Test that ICMP extensions are reported correctly when enabled and not
> > reported when disabled. Test both IPv4 and IPv6 and using different
> > packet sizes, to make sure trimming / padding works correctly.
> > 
> > Disable ICMP rate limiting (defaults to 1 per-second per-target) so that
> > the kernel will always generate ICMP errors when needed.
> 
> This reminds me that when I added SOL_IP/IP_RECVERR_4884, the selftest
> was not integrated into kselftests. Commit eba75c587e81 points to
> 
> https://github.com/wdebruij/kerneltools/blob/master/tests/recv_icmp_v2.c
> 
> It might be useful to verify that the kernel recv path that parses
> RFC 4884 compliant ICMP messages correctly handles these RFC 4884
> messages.

FYI, I just ran this test with this series and it seems fine:

# sysctl -wq net.ipv4.icmp_errors_extension_mask=0x0
# sysctl -wq net.ipv6.icmp.errors_extension_mask=0x0
# ./recv_icmp_v2 

TEST(10, 0, 0)
len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)

TEST(10, 41, 31)
len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)

TEST(2, 0, 0)
len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)

TEST(2, 0, 26)
len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)
OK
# echo $?
0
# sysctl -wq net.ipv4.icmp_errors_extension_mask=0x1
# sysctl -wq net.ipv6.icmp.errors_extension_mask=0x1
# ./recv_icmp_v2 

TEST(10, 0, 0)
len=0 ee_info=0x10000000, ee_data=0x0 rfc4884=(0, 0x0, 0)

TEST(10, 41, 31)
len=0 ee_info=0x10000000, ee_data=0x50 rfc4884=(80, 0x0, 0)

TEST(2, 0, 0)
len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)

TEST(2, 0, 26)
len=0 ee_info=0x0, ee_data=0x64 rfc4884=(100, 0x0, 0)
OK
# echo $?
0

When the extensions are enabled and the RFC4884 socket options are used,
the offset to the extension structure relative to the beginning of the
UDP payload seems correct. In both cases the "original datagram" field
is 128 and if we remove the size of the headers from it we get the
offset to the extension structure:

IPv4: 128 - ipv4_hdr - udp_hdr = 128 - 20 - 8 = 100
IPv6: 128 - ipv6_hdr - udp_hdr = 128 - 40 - 8 = 80

In both cases SO_EE_RFC4884_FLAG_INVALID is not set.

