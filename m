Return-Path: <netdev+bounces-201088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D4AE811D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B67B05E2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00C2DFA47;
	Wed, 25 Jun 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfA1jad3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269A2DECD1;
	Wed, 25 Jun 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850728; cv=fail; b=IS0CXFtztJZmrLUFn8lQokY0TI6IP24btdJXf78CWMByzsUxdtxZ54wCTCuLDo2YIBaTxQhwgwzx0EXHWf74FdEOutuJr6/gf0oKwbQzPXIAY0xyg/ZWRGtr9cgrrbmfvgtcJQ6zt4hNZRs9Q7MmomKsdHnfhSgTiy366KNqtpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850728; c=relaxed/simple;
	bh=9yyaMyDheEgUfc+o9vYzxKLZTqyHLs24kfyvzpie5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNTqKf43sHW2FdKcVmIwCD/H85dn0O+VrpxE9mHqMiJNT2aVsa76vwBIpcBmeTvG42J2hfskYt7r4E+vssDLjO47iVXjtyt/ntDtuOGgrev8FREY6XxbeUSsXMo3bs1mpp9CNA5hcpCaWQdl2lY4O/uTZ0BnbGEGXYQQYIqF0TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfA1jad3; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUi+DlNdX75elUyUDbPfpBBmUi6zsC5YLgghmaRDoep37zajycn4+hKV4Xbi4M9Z9FwcTGiB2JgOJhru95jz3/LfPt8Krbnwp/46uRAycv9PNATf1tNRSDn8OVakf+vwPsLZ2O2BHo+mQ5emHtE+Z+yc+tVV/0TUEzBnMX+XOzhyr8fuHRyqHRL12Cc7PHYe+S097QMtU4frK3LuL32li/PKdszCfwGoJV9vMg1dIIbCrWE6Dk+xd6y4zVIhKfAAbc2nazPjDJGSZ+czN18Jb0Tq9Z3b6Hb5HoCKnJ8xGJa/a0yzQYwzqDChAShGIoDb48oSanEdsbt2Qwh/1uvgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQbvbPfBU2rysM+2CxvERo3qEc/mVkd735DWn4Td5NY=;
 b=fPv0hWRdL20vQ7vsK1nVTqkaf4vsmNjDUFscHQOPj8VyZ2yGvXr01sgfm++1fIVe79WQrCYZyzzNU5Lm/0NC/5y/rDqocgYTmi+xTUpgUwS3/1LFZbjuF9qyreiTxrZ+qWlbOX6rEGRYYeSyyu3zCChQp6kHnUy4HRxu92W5a9lezJscLTsSst3j6Ks5qSSOkyoqXAu/VQFq4MC3J9A4Z7AswZYq1nbVl+cux8SGB5hsy7jHZF986GrFVl62N1coxG953Qq/lvemQErJjM9xvgVT01mjZTvNe3uPFRaovXw09UFsWtq+ZauF5OaYxzx+KXnhFQ3km227cBF7fI1InQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQbvbPfBU2rysM+2CxvERo3qEc/mVkd735DWn4Td5NY=;
 b=mfA1jad3IYYIl4AXst1+WONmnzvcarWPMxUbWlH/2So18O/OsIFKys9vkgJGDu+00qyh4zS03jhNtHQRU3+cPp4B/uFScPpJ1oMCAV36Cg/AWRDlJSlZYJHgsfvPicuoh/XqzQhxEuDNARHjZxluRjMs1ZM4E+WcZpJ8sO5sIYucDGRHVarq46mr+GKR126EWevoe/ScI1ALBm6vHAsrhP72/8YezRzFjrMTYhPPvqP+L2bE9CoT4aOpijoYPvEx3AMx+mIIEHVQKdJKv76nizKLS+BYoqyLLDmTr25nZHk/6K+8SLzL2u+medcjbY45/2tGUtN9jFQH5u+F+f7LGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 11:25:22 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:25:22 +0000
Date: Wed, 25 Jun 2025 14:25:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: syzbot <syzbot+f53271ac312b49be132b@syzkaller.appspotmail.com>
Cc: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bridge?] KASAN: slab-use-after-free Read in
 br_multicast_has_router_adjacent
Message-ID: <aFvclK0Qy6KyDO17@shredder>
References: <685bc100.a00a0220.2e5631.00c3.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685bc100.a00a0220.2e5631.00c3.GAE@google.com>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 85deb790-b4cd-4040-3bda-08ddb3daf90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uoich2tnR6IxpnXbYuTzcLmeuv9vlwyQlIHdJ2vzrpZsDRMBGvbreoAjxsJq?=
 =?us-ascii?Q?9xsv1sOIu3ltox1YFEtK90XEbQNof5oKjZAET7KxViWKODD80he5PpyMSSOT?=
 =?us-ascii?Q?r1gCoXfvIUul2ThwEyj9ZXgIVpAQEAT0qUlvcc5v0HKBQgwnQoM+ul8UCLK2?=
 =?us-ascii?Q?V2yXTqZCSEwp5sxMh1QMNdhzmvjjtUgb1akCZYTEuhY1ZA1D0sDrVM0LlsTA?=
 =?us-ascii?Q?556jEnhQ6siejjwiRDVGI21NPsTjtTT57+wajrkdlYHi7d530LZPNVY145R2?=
 =?us-ascii?Q?O/bm/8tLQbb8UgS21hU800kWRCpj0jIAQuhcC79Yv9ykgSzWKmVWqta9+ff4?=
 =?us-ascii?Q?k5sy2BVd6HbEqsPN2gQI50H6SsigTRRwPaqUvX9FqlSfswPgf7KeP2HM7iko?=
 =?us-ascii?Q?uF4kXD9oOwrP/FIVdLVmWgbH6AS73QL/8av4L4HynFehNJVpvllabsvzodxx?=
 =?us-ascii?Q?KXoqtb5Hpr0Q2+ch5Osx6ePIbzDtiNo554pRXcBRZX4U6ctfGm3MsgmneRaK?=
 =?us-ascii?Q?5kmssXVLVhrPwnvQyP/Bs3E594cr2wdKcvgHzz16/LXalatMlnxqyJ4X5cGd?=
 =?us-ascii?Q?BLy7ROxK1M1fTcHNzPIqmc8aVUDa7tt2Dibn5X/LXcXNYOqGUDCuzDOXkOmV?=
 =?us-ascii?Q?7WfwyUk7Hf9XlS0l9aa6kGu4NubYgBRH2XzsfKi1IFcqwBDByzp0QuUnnLCi?=
 =?us-ascii?Q?XoAwfDt5PQGvtGCTt85EdSaRVyh7iuKNbR/rbKA9HFAEHAXhaMgQmsxttb1T?=
 =?us-ascii?Q?BLMzdIouUv3AD4wDJxKSxUVGMAwSMJSLA1K3NuahT/imfTiCy8mfusHhQZA+?=
 =?us-ascii?Q?N2Yd6sClDz7TMUWGaWxLXWUXb+bus4UdZQ0F1ftVB0L6mYaxC35w2N/9jqF3?=
 =?us-ascii?Q?TX2DSiYmSBEpCzbWGWfz7AEmPaf9/Aj+7TX1aNRp7AX+Ir4GYAf8XW0MwuVu?=
 =?us-ascii?Q?E2hNI6vd6z04++YgMnux39k0HxTzKLVYXwYp9J/neA4SPP5yp1Fu8Ut9dziM?=
 =?us-ascii?Q?Y2LqYlHwS+H6r+Id45YdQIEqSieG1FKULRHHTriBwwdgk95hASVm1wDkj/JU?=
 =?us-ascii?Q?YllzOXl3EmdMrX26yC6zLdzJnf6wRgQX7Lm9xU1AyLzKbvaJbgIKnzEaj6Il?=
 =?us-ascii?Q?fDziw2QrCBOVPbtY8Kbs97H9ygz0wxygLs8DzUe2DV1CmDNRLag7mU5oDQG/?=
 =?us-ascii?Q?os6a27JpqI6H2f8ghVfwMv1BPkrQRUi+5xdLRTgOSIhyIGKqjS6LTT292l7O?=
 =?us-ascii?Q?zQZlKZ6x9r4iWiBYa3QavBnV2YrLkVlJym1yV9MKTV+nOuXQ8xJm3B6JU2GR?=
 =?us-ascii?Q?STkT5hMu6UqZdSzmjhprE6wmtReBceeVoFwTzS+foyQcDjCk0WL5p8UAh6fQ?=
 =?us-ascii?Q?AiZZsuMLS0uJA8AdiXfdtgdwKXRP619gcbc/KBjeM1z4hIOp56fCwYq2dXYo?=
 =?us-ascii?Q?gAwbdqdTuhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Ro2myvAxBJB+LZx7EBJBZ17wisGjzCXpwUALt/dAiqUDXBi3Bw/8cY5GtCy?=
 =?us-ascii?Q?Wh/GENNgetmT2F6v8Dy+F3pnzlJp4d3fgrYYoeSN3e8xqPa5F/kQ+oGlE/se?=
 =?us-ascii?Q?eeUnaR+aEBEQMGRqlxXSvlgnW/lkidsxGZVwbRM6COsXieO7kvq/HaZ2ajyw?=
 =?us-ascii?Q?Ou2MItEDt3PWg2r/Nc3TVBY7PdJdHBZ3mML8MfLESa9nbTjzc+u5Nrjwsm0E?=
 =?us-ascii?Q?BbiLyosV7mMkXiCYZNvrRGdzAvkA8z00iZzWhM/g1Xclj8E/ODGbXnTomszo?=
 =?us-ascii?Q?PAeWJNjChg6OqiPSjlwkiWNglBsobVzxcPFv0tHu8ok4W7nWbbrtZDQM5qVz?=
 =?us-ascii?Q?Ayq1Y17mDcdxSPu+y7fgqQccP4gtwI4K6nDvE4SKCMm6IC7kw/VNlgqSpXOq?=
 =?us-ascii?Q?CI62iX7THtjPIo9qSm8TiKfWEKlJPfSTAqZqXP2XG7pwyP7/PRO0IWyHQjbA?=
 =?us-ascii?Q?ajTICiPzfeTys4oo2LS/UV8Z9WZwx8jqLSrH1+6fjzfULI5xgSqjJGNTELAV?=
 =?us-ascii?Q?l1VWtDfWfoAkkYiY+ppAp9haM4H7qsP9+ULWnOsNIAPvTjrz1v1b5hly00pe?=
 =?us-ascii?Q?Xbe4Xo7WO3szKv8SyAJXHIQmIZJmjSUyVBx9ZjIDN7TKJz0DzV9ISF7KpiAc?=
 =?us-ascii?Q?rdGd3vQ1daUx9WUxKQ3nfHDO4cxADiPiRDSZ8EsarpemtvrbO+QTVTvk45Bd?=
 =?us-ascii?Q?e9juX8QXuD1C5CLRoB8kg672PoD+wO5qs9dgUFx+H2U2p5h1hyrTJgcDP0PY?=
 =?us-ascii?Q?8YHTeKs5Y4qlRA+Mhp30BjP6iK/8cOdGo0WPWum4aUcelbjanHVCJ97+qI7u?=
 =?us-ascii?Q?W2vTCDp8HJSwWzH4FVgtXHm7HzKg10Or+lAf5M1rMyxmEPGm3SsWAE7IPVEa?=
 =?us-ascii?Q?Ke9k85AHYE7qhntOqdINx/2YlprCAjqoXo5Sk4Oi3KqMFFefPDtHoiHCmk6G?=
 =?us-ascii?Q?Wx8bYTSUEPfvvLcm+YEgUkmpgDIOc5MDUHrDqiDHDj+rEv5+UsEaQUU97/X9?=
 =?us-ascii?Q?U5d2jNKgQs2IfUcLY0y27OybF5nfgOw1zyRGA6qQBldGy6eH9A+zw+pRo2M5?=
 =?us-ascii?Q?md4HW0yNEpAkvFPDFpttwFX+wtG/4dOyd/njshWEBBwEHtvPl7DOkUO7nuVx?=
 =?us-ascii?Q?Le/n9Fmy9JoK6MbUrIBKjT2p29vwf7370IPAycVTW10YyBN1kOb9YTblOcUZ?=
 =?us-ascii?Q?3okqBBQvefoq3wwS/S0zGZ+1AdR4TvvMxd7UVJowVyh4LG3bRRPKoOgOF3Lq?=
 =?us-ascii?Q?q+RPSXNJQSZzgqXxfCbsxVI2Xo1BXnFFoCYh5HMYo1iVIjkZqhpaKtUCnDjl?=
 =?us-ascii?Q?E25vHrL/28iYsDY5BBVYo2HtvsSAapeczedYES0+UfZkeeTm0p7xYOIa6xvI?=
 =?us-ascii?Q?u/g/IL+ahmch00REOyjSvuyzXj0J4HgGmcwrNKojYbh21yyWUoAaxwZPyVBA?=
 =?us-ascii?Q?EpJdjK73NftOvJHQ9TSh/qVHDIXjPoXKm0hA+lJjO/gAW+nhBeqvCooFS9cQ?=
 =?us-ascii?Q?8gVWH+vlMHU/uIkBYt4UzdqPDr7BYZp6bXT3bO/AA3ilaV8O0mfyatqr2LLb?=
 =?us-ascii?Q?/Snt/XOkvi2uUTh9lf4nGJJcanSOXWv8XI0uVl1r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85deb790-b4cd-4040-3bda-08ddb3daf90b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 11:25:22.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPJ4b4gscNdDYmGnaDJW8JnRxCB2JMn9NpcFjdDbYd+PYuQzDCK1SvH+mwvazmzFmGtGPMuI8b+O/h57Dp2GJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843

On Wed, Jun 25, 2025 at 02:27:28AM -0700, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    714db279942b CREDITS: Add entry for Shannon Nelson

Which does not include 7544f3f5b0b5 ("bridge: mcast: Fix use-after-free
during router port configuration").

> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a59b0c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
> dashboard link: https://syzkaller.appspot.com/bug?extid=f53271ac312b49be132b
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4af647f77fe2/disk-714db279.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/df9d2caceadd/vmlinux-714db279.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f05e60d250ae/bzImage-714db279.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f53271ac312b49be132b@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in br_multicast_has_router_adjacent+0x401/0x4e0 net/bridge/br_multicast.c:5005

Use-after-free in the multicast router list which should be fixed by
7544f3f5b0b5 ("bridge: mcast: Fix use-after-free during router port
configuration").

[...]

> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz fix: bridge: mcast: Fix use-after-free during router port configuration

