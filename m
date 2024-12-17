Return-Path: <netdev+bounces-152641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF329F4F58
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478E47A5BF9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F7148850;
	Tue, 17 Dec 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E5EStgBX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C721F755F
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449088; cv=fail; b=NxoY5Dd47TAQugLAZct+WsQyqBlK0KFSkDg9XNdanzto0YiBnZ7kQe9cab+6eKqTHFnA+8/HpuIIhVGa2XWBkMlR6UpoZYQyPUbJqEvM2rcIfLNbbghPyNF717O0i5Q3UUqS44gDOU/56kCYa8IWVRotrseRWzYsyNHnxY7mOdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449088; c=relaxed/simple;
	bh=fs1bWXMh/6f8qlpyeO0WH76srL1+O8DlzyAjn4koxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VzMeKaauLvzIKWZQhpF3hpDlohGF2R5mZT1KtmueP+pQEGFriPZ7MTejcHqcNJpdp1NJ3+cj1o3hCKn2EuRAy/JnjZMCQWrh4g75zU7BT6ipx9A62aasaMmxYjWbUsKvE4zcV7wzIJG+supaZI7YBrldBdwmFbbRJ5v8kDhQLaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E5EStgBX; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSTw5UjIM9XOez1LbZeXuQCjvN8B0oaQtSxaZTbEdz4Wh8WIc+fl46TnUDSOxdsvj9IMHu5ZusLWFOFaurrExxdj2fpIJ/wcMy1zgpqvwe8TELr3P+8qYGEDUkHoRjpooHAl2fZYTRxijImWmYNCfnoYG8qYpktUouMwsSmZbc8r/TkF/0t/NDhV+ClxXG/lTK5RAK0NAYXBWabjui4Z6Ap69cgAyxuwn7ObBbE0opJVurf+fRxXJYIRKgthDaTr0oW71pKSQFAZ/qS3B+FXkERj3evE0twfCh+gQD+FlRRaFcnK7ZVOnU+iJ77LxWQs/Aje5wMb8yBaxC66oiZxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6nBOnV+TvJPhAhSc/XFl5uOZfUw6BhZc+058WUGF/4=;
 b=A9pH5w1C/JV/2rGkkXDd4GkeXdQAK+T/MEjrW3vHXMZ0UEjtyD9MTLJ1KiELG5ypm7HXsu51QlZ5CYzxAVTitd5mBQRoXULueLHajz9wMyRAF76Fwl7L7oSGCWgVvPysdOvckk31eU5mXrnGenMpbmQOZHGLKnUyRiETd0x0ZnYnr5Bqz1EdwHvy0+ccg3Oqk/1CoWGE03koFX7FME58lzztXHxXuFE4CWPALzecFyQ9Xh+wWZp+SdTHeCH1cRUdagdy0oeL+T4d8jddZuqDWPPYpt5mQ1rEHQgZ28xo6igES/m/DkV7vfoeDMFKq5Cohg6h1Y+xRM/USxFrP9f7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6nBOnV+TvJPhAhSc/XFl5uOZfUw6BhZc+058WUGF/4=;
 b=E5EStgBX4JQ+VEtjXF3CFPEIh9N4u3dRWw+uekkGggQyXc4l/WC4iOya9z+5JG24eZSLOB+x5kwpQ2tXGgdhU4WGIshyQ5FNc7uDxCz9OynX1qYoNY66+/h2pNmwOSCZIYthzP/t25khwSamZ+uXxAwSZUOqxHcLpF4mupDgYsCL6EpkMJy2BPv7MmJHOuAblfragNrqYGinuv/sKbwcTuN0OincILLAt8tVl2iYaNiOOHa0w0gvtwbuM6F8Tejfh7z94M2ghjdYkjOfX7+DMVYQ8U+vHusSu3epWvvgVgY2HTw2H002ndYOPlw1H0IUxTLK52nuZY69JXgnUSZMzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 15:24:44 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 15:24:44 +0000
Date: Tue, 17 Dec 2024 17:24:34 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 3/9] ipv6: fib_rules: Add flow label support
Message-ID: <Z2GXsiHPjUDGl6TU@shredder>
References: <20241216171201.274644-1-idosch@nvidia.com>
 <20241216171201.274644-4-idosch@nvidia.com>
 <Z2GDt+5piTRsumVd@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2GDt+5piTRsumVd@debian>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bc25bc-c170-4572-97e0-08dd1eaeef21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EKIElWS1eIuoQcpX8GWhBqsK3MS/enzmsS7ywcnyRvaavs4aLqjntpjWNfll?=
 =?us-ascii?Q?Koiy6jvx/5DzjRzLPP+NZyz70uY6U5yuPeuL7SouWWmijsPKuUmH+HXLMDJG?=
 =?us-ascii?Q?vUjuQ+i069BUeCTWpbwe+Pfh/jVvbNhrjHLSFClPdBc9n0dqXRcFNTGzbJwS?=
 =?us-ascii?Q?nk1nFGYk2gaYf4fUD9fZ9c3sv1YejtFgBSu/WLpbm3Jb2g8DNiKZo9WT20gy?=
 =?us-ascii?Q?ZiV2l8mXRw9s8UDgotrZDrA69iNAL6UjAlZZd2o4KC4LB775JMWPLwwIBMLw?=
 =?us-ascii?Q?QVUHvgE/gOE0F3PqZI5YAEY57gzZZMmCYC7CzMCKIN7mpOocktrNk6tfclDD?=
 =?us-ascii?Q?Nd9jCoZU9IuocETZj2hVFyNRyGTl8yVrWkf76wR4E9KF/zaWEN7xs/WHa0MR?=
 =?us-ascii?Q?X2JBnW6AvPMfxoxK/XL1ezveeVmowfqAhH2VRSTEEUzi02NtfMGQWnzJQTJU?=
 =?us-ascii?Q?mbO6chfiNtb100VZWbiMLMKUqfPSWhHV/S2UBug3h05q5GLHaK+qNTJf7IZ2?=
 =?us-ascii?Q?5yLNcx7u7gy7IqYXq/E/I6avzeX7994bOPZqeP7KRFH2YBDIeyspK9s70VL0?=
 =?us-ascii?Q?zEQH1lUfxUizvhlxLkI3sHB0is74xp4UONrocxGbvkAf8Fkqjj/4TV/PZmRG?=
 =?us-ascii?Q?q6m+CQ6iK7WmNvmv7f+yd+1cRH2MBl4TtH3iKMzwnBL/8txPywbcXWh0HBII?=
 =?us-ascii?Q?GqPOOCKHXff3dDrw/virsaTK3u3HuXmuH3nh1lBD3DW8C7/YMdWO/ZxwVQUU?=
 =?us-ascii?Q?FOb/cAg1J65UcEZeIPt7mxuwLQI/vUKvde1/HcKDFqwY3C2zFmIkvHb/PZcZ?=
 =?us-ascii?Q?S2Fx4tUpASf58bZ40ltA76pSDIqwLG+JXwkamZBIoS3iO8gxE7HtQPs2cZsV?=
 =?us-ascii?Q?C14RW1CfYIjgLt/cj7lItVTkwVlZty9OJ5+n3QG8GMniWrvwNzFYhJPxdnpG?=
 =?us-ascii?Q?xAJCzg9VMEJd6Mgn5GvxOgdl1xsgNHeO1zjGmcCC/ZCpx0OBYM+uoQF3SJRq?=
 =?us-ascii?Q?n4utltSd6Ozi1pKYd/nmO2VjVQatyF6mGO8VUaQneIr6GUbBHE1Imc3QP1MV?=
 =?us-ascii?Q?COZrKjjMMfuYLfNrjJ1DrK9kCvtD4wJIgP1xU3aGaeJVNj6u9VzcNZpBgJ9S?=
 =?us-ascii?Q?c5geYRgzeENCa0KGO3EdW5SYzSnYJrY8VKXUBhNXbpCkouBaVYXsKUUXHshf?=
 =?us-ascii?Q?tMZixQz0z8T1bdO7ujIR1eZKZIy8/K06Wh5Z3WXGalf7zEoLYTAsjOMvhIKB?=
 =?us-ascii?Q?YdzOhp1bfLfVa59CfTIiQr+nLAgyDJEQTONouLLUJo2vweQgs3DX/2Ya8fkX?=
 =?us-ascii?Q?rJFh9anFNRfvxnz4D7lI5/f8+G3SUV+IwdRIhGwwFhGksIQlo6DQSVZc6C22?=
 =?us-ascii?Q?2AYIc+YlqmQd8D6zw0uEcB5LJMoX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cLcU98koZlhn9gAJzWMafDM45axahp6faPDS0SNa2CM2oynBm+RQ0wXXaa/U?=
 =?us-ascii?Q?Tl3soG6NBQnyeaeIJpPzFcjosp3V1XZN1Qi6EqfVV2kXOD7E7XfC9a215cYg?=
 =?us-ascii?Q?s/sibfloM6fISX4CERVuAsCTLwEEDyC8xCOURFsPWUSfDc4klLUBMPbvwphH?=
 =?us-ascii?Q?qhUHYou7m1tLv7hG9zFJjHqqb+26FoIHM3QG2enrHew63ozDNcJsqdioJNJJ?=
 =?us-ascii?Q?ls6SOKpQFd3VU0grN6p432bZ1LY8YfHhGD+d7C+mVOlcIC/iH+RwgF3KrtDj?=
 =?us-ascii?Q?PpO+LT1EINP0UYY1XpvgnYm5cfAEz4/lOG2TqMmOAFh+I3J1EOEsS8pnwbo+?=
 =?us-ascii?Q?SgkP7Lgi1kDvxuHc1SyGVzCXVr6A/NIx/PaZ7hstCPgviucCXWCEkuxk//w6?=
 =?us-ascii?Q?WbU7mKKPdZeG6SxSDtUHsVT0PxykzZsJEQ6EebyXwetk+Oi8e1FnMK0h88F8?=
 =?us-ascii?Q?8MdR2uSqLufDg6IgUruDhOBnb8sKozzwum5HdrrYm5N4F6N1iiH1bACfG5B+?=
 =?us-ascii?Q?VW+k/zLj7jDOpnRxT3eNUiB6RiM1isR2htTBuycRf7A+anopgGSx0wb5Qotn?=
 =?us-ascii?Q?t0wK0/phx6ZeFNIEHIn1ysYpEMTiwNiM8LYjDnsfGRPxLwYg9ST52gjK+KVI?=
 =?us-ascii?Q?9/DgyObnhLYoLf2X+E3LSjMyX5cWSdcSSMBe4t2KDwIvUE/8nD6uKyF5iGm+?=
 =?us-ascii?Q?YLWIK1ciZyzD7GxhhcnxIqO+WKcDKsNSBl4E5auO4W6GkhEwSspJ0OeCFdeT?=
 =?us-ascii?Q?w2wqgOer0vjTGdqHvLh4CkF0NKKgzTLIBTAyFJQrwk/aKHmO6uSUK/cCqb1p?=
 =?us-ascii?Q?Ljy3WvGveYtGBP24nXC0ZM2DT8Ns3Jqf9KxQC8QwGoBDe9o7WHm1mdQgz+O+?=
 =?us-ascii?Q?7yw48pu37uGX8+81zSt9NCEeQcj4M2j/xBTUQNxghBZPKFcHIxBcDGdhA1Ru?=
 =?us-ascii?Q?tDTJHweg2kKE4VMepPPcgv1Jdn6wwGOs5rY5afyB4FKSvGcB2h1hbY/ZLSKS?=
 =?us-ascii?Q?JtS0LG0Q+M9Iakelga9f6CA+IHe7zyOv65fghTSBLXCBmHyj5wD2SsCQPzwU?=
 =?us-ascii?Q?JwX1lBJQv+/TB0GB2Hm7VhjqJMxAo4cOQqAgqDRHc29+0XmRjtoyZ3oa8TLZ?=
 =?us-ascii?Q?kLQUyJr7qjyNRMOlJ5fJT2HC3MQDkjL4tUrSja/1nq6ZnoZ9IpprLDBzrSSh?=
 =?us-ascii?Q?Qt21zvaHJVlHMflBJt/g8MWvIl8mbcY+dW/HGIg38cLYte1B3MnEWqA3C7m1?=
 =?us-ascii?Q?6GCnlfCidRpXMJp8ZcKjMUY2w7nOads66HmIk3rnqKG2rk4wHFv8dD1pKG+k?=
 =?us-ascii?Q?Eo5kbKiJza+p+Rrmys95Bwb6220IOiG6ktAReDl0oXjCpa77l658qLfntJ1B?=
 =?us-ascii?Q?LJbYctuhvwBmfLeD8cKvEtWXmp0dUHKYfGlZCN09s6Fsc3tGlCR20Sm0O1Sv?=
 =?us-ascii?Q?OUfO6bXvp2t1fR4q/Vr8C9HKnC9RNuCurc+MunNCpQ1u9zao2roGwKeRBWWm?=
 =?us-ascii?Q?2VqopkLeaTsJaqc3sGkN/0grq3TOpR6XZwWcwCbX9y+GBeSUxvH2vWU6qi3v?=
 =?us-ascii?Q?+ZDdpqGiHGu95off43HPvbHKkRGnQMUDkM+nUivY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bc25bc-c170-4572-97e0-08dd1eaeef21
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 15:24:44.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1L4INK1Iv3uOXt3+JxZDYQ6ANbAJiExglMrIdJdlB0K0faSPk/ce7m4iCTlAX1C1n+w3xKhA0UxALQB+SfP3Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

On Tue, Dec 17, 2024 at 02:59:19PM +0100, Guillaume Nault wrote:
> On Mon, Dec 16, 2024 at 07:11:55PM +0200, Ido Schimmel wrote:
> > @@ -332,6 +334,9 @@ INDIRECT_CALLABLE_SCOPE int fib6_rule_match(struct fib_rule *rule,
> >  	if (r->dscp && r->dscp != ip6_dscp(fl6->flowlabel))
> >  		return 0;
> >  
> > +	if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
> > +		return 0;
> > +
> 
> Personally, I'd find the following form easier to read:
> +	if ((flowi6_get_flowlabel(fl6) & r->flowlabel_mask) != r->flowlabel)
> +		return 0;

The FIB rule code already uses the XOR form for other masked matches
('fwmark' for example), so I used it here to be consistent.

> Does GCC produce better code with the xor form?

No big difference.

Original:

static inline __be32 flowi6_get_flowlabel(const struct flowi6 *fl6)
{
        return fl6->flowlabel & IPV6_FLOWLABEL_MASK;
     b85:       81 e2 00 0f ff ff       and    $0xffff0f00,%edx
        if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
     b8b:       33 90 c0 00 00 00       xor    0xc0(%rax),%edx
     b91:       23 90 c4 00 00 00       and    0xc4(%rax),%edx
                return 0;
     b97:       41 b8 00 00 00 00       mov    $0x0,%r8d
        if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
     b9d:       0f 85 31 ff ff ff       jne    ad4 <fib6_rule_match+0x34>

Modified:

        if ((flowi6_get_flowlabel(fl6) & r->flowlabel_mask) != r->flowlabel)
     b85:       23 90 c4 00 00 00       and    0xc4(%rax),%edx
                return 0;
     b8b:       45 31 c0                xor    %r8d,%r8d
        if ((flowi6_get_flowlabel(fl6) & r->flowlabel_mask) != r->flowlabel)
     b8e:       81 e2 00 0f ff ff       and    $0xffff0f00,%edx
     b94:       3b 90 c0 00 00 00       cmp    0xc0(%rax),%edx
     b9a:       0f 85 34 ff ff ff       jne    ad4 <fib6_rule_match+0x34>

