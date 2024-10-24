Return-Path: <netdev+bounces-138565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093449AE21D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF181F249C5
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4121B85C4;
	Thu, 24 Oct 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="HlFL6GpG"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958A17278D;
	Thu, 24 Oct 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764470; cv=fail; b=KsQR0EorstHkfUvZdqXVA+DuBFRU4HtJ0lRfNDb/z2Mmo/x+kT2awAETOLolboeg+EjFwKAQeShcTKgcogLNCqMd7aLKSaMTuFLo1EtzHP/BUqiqSF5i/g4hG5Xoy7J+80hobLbJWxNWhQP/kJu61Hsp+m9MMQMOkB8asa8hhiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764470; c=relaxed/simple;
	bh=B6CrHdx045MIaqRJdHQMK9oJgszWfJoCVl8jHEbmTU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:Content-Disposition:MIME-Version; b=n9+cfp3GFyx68H6jdK+5bdwEsc3/5CL7GeZO5RUJ0HgZaHX+20tRgU9l0SqUP0w8AwcvLwaa9kqxAq9KBkYjsNtjtoaW0hFkBmELPRt6vL0nuR06o9fz0rmEnVgaE7uD+A+14gO3SBXY+Fw3NIF8IeC1gSqWtM8/Bfx3gGr+asM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=HlFL6GpG; arc=fail smtp.client-ip=40.107.255.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+fdJTN2TjWH7o9HF6e95VoyHo5BWx5IEw35mtmo/CwpczNOfGA2+uQDmIkivvxeG2PTfJLyFp7Xk828MI/+sjLCX5VDs5EttGXmIsl1UInupJjCoJv37wr4zVnFnaptO1dWdHzYKcDSAbobAgU1OSYxDf3Zyqy95Ud5aa9PO+JCB62Q8CQSy5IeJd1hoPICH/cMZwUQPSiXjvB7V8qnJSUZg9dxEM0icBh6AGgZzWxDExvibCzWrupr/csTZvrM+1AROFGz9+zO0aEcXBpy6X77HH85GG9WScW3jDs72SskCWlWZ4DyOwYQDdFbaIZizhKoZLSsTFaZFWObrN+Q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjYDzjZEYLgCTWa0oP3QmzRVlQqrbWbHzi5nVls3nns=;
 b=u9jmBCUupM8drc+NghIEO1ZVj+cOpJKkg+yeA9dm/3SfKwP75VzvgAHolOBZxG97SmPgNrfLs54LnDiC/7rRT9x2B2maWZjp0fa65/BqJbVAomK6uocTg0GnbIzEqkO8063wsmuhalhPV+8ufFZcvznvjrtwOaQG9b5RZIwasVE7Lm3zZEj7EBL10KqyhiGebQ0SHQDRMPi7zRk5NE6rBpg3ScJ/k5PESaUncCT84geOl4VXU3qt+EdhU6Xjw1qss84F8xXY6YKKrocEAt39zEYOeIetFD/25dlOxoeVJF6T6jHvV5iHYgVTSsPjTsIOF+iRiHbnQuyVW6eddcKnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjYDzjZEYLgCTWa0oP3QmzRVlQqrbWbHzi5nVls3nns=;
 b=HlFL6GpGA9ANrLwv4lfx8dbS2ey3swrK2cmjQA37VUDbz5o1PYbtMC0FLlLJJu7vSamObnxxtvbvAEVPBcgqtrXDG06H/Odplaa8MhAQE0zW9M3WhzSneMTy9xJBFrmVIUsPZSsrVwIoEhrnJKncwnGWaW8DrcHh1of/wU3jJbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SG2PR02MB5652.apcprd02.prod.outlook.com (2603:1096:4:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 10:07:44 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 10:07:43 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: helgaas@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	korneld@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com
Subject: Re: [net-next,RESEND v6 2/2] net: wwan: t7xx: Add debug port
Date: Thu, 24 Oct 2024 18:07:25 +0800
Message-Id: <20241023151514.GA888712@bhelgaas>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023151514.GA888712@bhelgaas>
References: <20241023151514.GA888712@bhelgaas>
Precedence: bulk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SG2PR02MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f0e56d-1daa-4c35-48a5-08dcf413b3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|4022899009|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uk4GGuMV17uTeWvHeTjiFIw+YrfLiF5is8aATwbAN3W2Blt6BSSAYN442kbR?=
 =?us-ascii?Q?/yg96t3bPqrPByhC0N0KDYjMybaeFeGckW1JjceLmmQg6MGcCp77V4HVYRM6?=
 =?us-ascii?Q?/ODLmH8UAbIiXpCEJ+SlxRiqc95L2Iz3YF9RBRYkWfzg3V6VS8QbZdXwrbIA?=
 =?us-ascii?Q?5eg7DRQFRU6YXXmLiad5u/LyJ0fUG+O9yt6s03b8LYx2DrNaXOVukZNH4Lzd?=
 =?us-ascii?Q?QayR3E/n480TNnGfDOxUK+SM88kiiJ+Z1nnBtusPocIDjDm7fFsnZInBjKL8?=
 =?us-ascii?Q?IyK0gOvhZAlWYb1BSynGtGo+fT3YfCzr3L9XbK/OZQhY5j5g28aOb79P/t0y?=
 =?us-ascii?Q?mWCNldeYlV1vg5zq+4p265vH0YeZvfsy4nLsS9e0SUUUrGOvvNZI0KJ9FRlt?=
 =?us-ascii?Q?a4ysgWwTxW8K4jSFKl6JwoW06SWzrWVzpy89kxPwh512m42onqkhg05WNgIV?=
 =?us-ascii?Q?MxGKUe1D0cW+aTw+VMja3+UrkzsG7tTpBOMjzI5sNyyrruMr1stpFZkU0rsW?=
 =?us-ascii?Q?LVYr/Uh+Lp5V+zOEki08tS7KmvH+NqAiXPXn39/mFahikWBEe3DYpwUz7+Bi?=
 =?us-ascii?Q?8uvRYGWAOxd5Pl7eisRIzyHNf0fNiLtwlpEfqnC8xO+ToFAvH9fJGq6UqU5F?=
 =?us-ascii?Q?cBj1UTvOiF8sHzyT8WHGsz1PMxfNtZkHZp0ugYbeXkKCVxQZ7C0kYNwbcxsW?=
 =?us-ascii?Q?6MjF9VnMnRSdYEHV4V+fK4sLbwurZjXr6SA0ZuiidqvUwSjFJgZ1f/s6biqK?=
 =?us-ascii?Q?cIWaKkM8w7kENGw0TNt/I4vUsWRVMsxiIuv8Zfbc+JacYokvPIZnAfKbGYEJ?=
 =?us-ascii?Q?2LetOMeZElPHe+Ok3iWkaYbt84KykALeMbFDzGm2b75+ocpDLENZYNUCbRMR?=
 =?us-ascii?Q?OjDLlrICVcVLX4NlffDzE/5WvB1Y1iZvXICrDTa3EO9ppj0AksJtPJf+vpLR?=
 =?us-ascii?Q?UyVkLVbz6MvqfKPQsewCy/S5NOcWmS0mtdNYl4bYcVS54ub5WpbG74tm4NjA?=
 =?us-ascii?Q?MczS/tZNjBPxOzuVxF+lrb3HReMqwESqmDQR6QyWgcQc1MccL18IUzF26BSf?=
 =?us-ascii?Q?63+MKoW9IrtekDGeQR+DzUYfyvTOWXWANZAGAmFhE/ynwKWkVSO0ZwCAabp7?=
 =?us-ascii?Q?jXA7GoH9XnpNqRMxNZDFbQ8GkT8IRcUeBYjCd092JQhavTlRIILiNREpXpCT?=
 =?us-ascii?Q?lNCMc3JFDte7MNa2eYGtVVIX52BNW+x0yy9t2o6GTPLcX9IOnW2HxftxUd1D?=
 =?us-ascii?Q?C2hpbTVtzGMWzW4JDkmFMC4kVvYtppVMM9+U82rmxwR8G1lzaegO6ukO0xwQ?=
 =?us-ascii?Q?tZAHCzP4qaFsKpoWwIiB7bBI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(4022899009)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ubHdN1PP1RIo68eNzd+7gHhZ4UzHr+TFzR9OiPIabnRaaF/JcH8195VSZl/?=
 =?us-ascii?Q?w7qWlF4dP81qDb2EILN3UvwKEMMfDvCBdiha8qTLkAGLG3irB8K9NhL78W2F?=
 =?us-ascii?Q?FpQzVJ+v8KoBzF8ObsF6ATadhsYUIMkm7lbWPSaYHXjgLP4JMkpAICnNiNmG?=
 =?us-ascii?Q?7B9/W3n3xHUJOt/eOAXhqxW1hg1k09Q6cv9LlP1L5HpfB38ZE83QvAgN7KdJ?=
 =?us-ascii?Q?NLuil4Xzkq2AUhFn4ijacyEN7DF4VhCOGjklzhguE3WpKpSvnaVZHP52rkk9?=
 =?us-ascii?Q?6jFUPSQJfBajMBtxyyKxKHb8DfmLrXLcAnvp8YVr+rxuGjWdEWYFsz15vC9Q?=
 =?us-ascii?Q?cazQcTvK4H1h2A6yerhi0OBqX55nM4doIOFXp8zkn4Ws+7Ai/Ii9xd7uQRDZ?=
 =?us-ascii?Q?4vn47XqSPzd398OupfGYaBK+iAKqWmIcgvx7WcmhJz5VKDvGT8L1yDj2sNLl?=
 =?us-ascii?Q?NFJC9if1MAM2KsB38C8iCCvA2mILd3LRvk/AUJFaeOYr04pojFknwXifVbD8?=
 =?us-ascii?Q?PrhIQFd4YpGS3LZtTjXKHUyCeoPBe5USLW8JutvuTB840d6K+OxzzFkyT+OC?=
 =?us-ascii?Q?rMGRWghZBPkns7GUw9av746NikA6Wzfz55UATbRB7NLnPeRK2wlyD7de4IvO?=
 =?us-ascii?Q?jfqV+acLfADGf1gaJ/sEmKiQ1cmYk0mUm3fzTUwEIoBSNi4AilgQDeIAKYc2?=
 =?us-ascii?Q?YWqaVZuXNCd2IW8HVPsg6AWWJMax4N9MUEmtwWkhDx6MAsRjYMBgFg+TweWI?=
 =?us-ascii?Q?MO7V6f+ASeCGS5YfxYY41dB1l4r2BZraj8DC1Fx3TX8ceTI7IrIJOixeY2s3?=
 =?us-ascii?Q?gJ0+RsMSWjWJp/87uyEbsCkm9Dr5C4rpfxI9Mrk1bcRcD0BG7oY9obWqV0M+?=
 =?us-ascii?Q?E2DptPjievxuWtVKs/tZhaef7MxN2fm4BH5pIx2Sq2jMNQ8jNDBkznjOgnMk?=
 =?us-ascii?Q?chaCYPhSu3Gd62TmCFKEFvR9OLJbyEVE7WmKVQsGnqfYmUVZyf2V6NWy/d+7?=
 =?us-ascii?Q?pqKfnp1WC94Mo4pd4ep4R/dqc75OpnZ+TjzQvLgPu88sjIZAmGKxe8NQSS62?=
 =?us-ascii?Q?0uXVExSZg9LW8mQeHWi5I4L6N92muA2b6XeurBvdYk8bPw2YEw+ESuX6K2+4?=
 =?us-ascii?Q?8wn5OUWI4f19TS/hznclHnqPFMH/OBOxAvcSh49r91eQ4hlxvC5IOCeW36lB?=
 =?us-ascii?Q?/ChtRAJTjJDC8sKrK2j0omFa5LxwEDGSv3U/Q8ntQqhsJOBD0dSbZIJkCsey?=
 =?us-ascii?Q?AF2QL43RmWnFNMCm9X8lD68lGEQlOyxq4QoS+9aYAiGYYAne3BlYfFtxLipR?=
 =?us-ascii?Q?YT6gbnSsjZ9cAIAFAiySaMK6gwl63h3x0/TBfp1PtNOPrtsHrkp2NYhE7lwc?=
 =?us-ascii?Q?VwgHNDQMW1IUvAxnDH8eW4I5LM5MrUtmr+VI8FolxhJrJksRv7ecV4bYg/gK?=
 =?us-ascii?Q?poeRrXF0DcP+U86N9MlawERyR8GP3x0LLThV5x0JTI/ptRfj1PoRfOEDueXK?=
 =?us-ascii?Q?PSmu7009PKUryHVSsXESSZm0Q0NkT7xiujdUZuBngCvf5f7kgx/i78SCnpF2?=
 =?us-ascii?Q?IDUTUlIG8HAHp/yDMxvRASgLsHlf/Aa02G803a/UlBSDE7CitpYXTAhSh/za?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f0e56d-1daa-4c35-48a5-08dcf413b3ae
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:07:43.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKE8hfWHGuPPscSvDgdFL0n8Ttj7v8sOM00/Xykh/ekHN5pi6vZ6ecZfsY9FWUz4/QGh8pO4Ew9Rv8y39Thd5/zEvhCm+QqTcWUShjfKntw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5652

>On Mon, Oct 21, 2024 at 08:19:34PM +0800, Jinjian Song wrote:
>> From: Jinjian Song <songjinjian@hotmail.com>
>> 
>> Add support for userspace to switch on the debug port(ADB,MIPC).
>>  - ADB port: /dev/wwan0adb0
>>  - MIPC port: /dev/wwan0mipc0
>> 
>> Application can use ADB (Android Debg Bridge) port to implement
>> functions (shell, pull, push ...) by ADB protocol commands.
>> E.g., ADB commands:
>>  - A_OPEN: OPEN(local-id, 0, "destination")
>>  - A_WRTE: WRITE(local-id, remote-id, "data")
>>  - A_OKEY: READY(local-id, remote-id, "")
>>  - A_CLSE: CLOSE(local-id, remote-id, "")
>
>s/Debg/Debug/

Got it, thanks.

>> Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
>> 
>> Application can use MIPC (Modem Information Process Center) port
>> to debug antenna tunner or noise profiling through this MTK modem
>> diagnostic interface.
>
>s/tunner/tuner/

Got it, thanks.

>> +++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
>> @@ -67,6 +67,28 @@ Write from userspace to set the device mode.
>>  ::
>>    $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
>>  
>> +t7xx_port_mode
>> +--------------
>> +The sysfs interface provides userspace with access to the port mode, this interface
>> +supports read and write operations.
>
>This file is not completely consistent, but 90% of it fits in 80
>columns, so I would make your additions fit also.
>

Please let me change this file.

Best Regards,
Jinjian

