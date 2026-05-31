Return-Path: <netdev+bounces-293460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ5oFq9lHGpjNgkAu9opvQ
	(envelope-from <netdev+bounces-293460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:45:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA32A6172AA
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 278C53012C86
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0785390CA6;
	Sun, 31 May 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G3njdyox"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7B3914E0;
	Sun, 31 May 2026 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245930; cv=fail; b=REFJyfnDh1zUC0g6HhZLzXoFUq9PuNZ1gf9B3J66aKMb3ZmVylIrgm5Xui3B2cEGDeBsx0d7CdONTWrfdMooxcikavdULUi+PVRMMJ3KMrwv/XU4RnhR8oYLCH+/kKVHpDPZveWTrgKz6AmQA3xa+nI2fcfNJwm93Jai6qF0uEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245930; c=relaxed/simple;
	bh=BW5wTaT4ISdgRUPRQV2sKj+f29HFhWrMCWHP3s1yIWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vcq/ubZTuAb9ciHXnkD6kIAPEtXMsSXTqZYVzc24tfllvVgySd2G6Til3ybi28O3/GDkO0ooogNZ6wyjJ2W6MmR82bqpxSOd4MDABDidIHLyhtGDBE4LVUxpFxOxWyylqrWLlCdJ+z2CP2QETHmYn/73E4kf4MwS7MMoka+wjv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G3njdyox; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3SRj0O8T2xAzJ+IubGUfguj1ONJpW/klRfvnenpW4ebk1nLCzqYyHvCfYjDukM4bJQvyEYN1B5fT7O7SyyOpjb+h+p9dbqPC/MxHFlSLFRATUm34yv2wPnKHYv1Oixsd/tydFsmmf0he+rMNAfDogbnHrYygyrk4mWqC/akJSLd0Xw5nczVi0tovFRT3lndvGnFWa/U075Rj9739w0X1L60hGDqonwGX6Aigq3FSvM2LXT73DnQgZncR7UKCY2JJQ6ZPH0VMIEI8EkuqkBIc70HEjL1xox7R8jjdjpasEhTxDXfzwRIfovKgL+lqcf4JbQwcQUY3HMmfSBeZ3Q+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANJizjQljftgXTaHbe6BRk19bh/U35TMUQjhhF5Oz38=;
 b=tlusKixbHoWkltr9fT1VUrHDFGnPoeNMLELz74LQNZA5/mZuPpgJ8G35gEj26nIW06RFUE4i1/y9k4+wLKeq615XAReWqdFkod/qf3bTBi+Wbpz2ysGOgxLR4FstlAn8tfvYtXHJNv/w5vdFDnwuns/uuJJnTPYTS7ny0GyX7UtfW8UbRpSva2hcyXYTqZsy8qhVV4YKlX/6ezFIHtRx9v3OzJophumdiQack711GzvAnH0DpfMqFKZNpyANQaWVNQVl4PCzsr4rAKj6A1qggpwm/YHxAVIfQo+K9uKUGdWOLFfp535ayu8jHUBKmjHARabZZ6aWmd54YfDGu298bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANJizjQljftgXTaHbe6BRk19bh/U35TMUQjhhF5Oz38=;
 b=G3njdyoxz4eCqQZHxP9LEdQM8STNzPhaa9uX7zZLJ4Dtw3hd4Vk1Xusdy+WsUg7+cnNtfo5uK5Ea7mi29sy9ADs94Gsa4aYn6yRb8X+1DhYKs5ar1vFqquQUo6tt83EvQz1xDkzl888F3MF5jQ9gLiuz2ezBwElc41cgRi2qYht3AYtP3PZV9ujZJtTQLOk0/QjkKYbksbldgYJZtX0HDKjTf6C1h+/8sK6epJzQCMpGej9yCa7y+r+GguSiDi6PYkOqjzOPc8L6Pjt0yTEG4srlGtj1MYzgMq3dwt9G2jSMqaHVjlharZNzH7WQRgTTf0HT7vEJQusTnALGBNESHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 31 May
 2026 16:45:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 16:45:24 +0000
Date: Sun, 31 May 2026 19:45:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org,
	syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: anycast: insert aca into global hash under
 idev->lock
Message-ID: <20260531164515.GA232188@shredder>
References: <20260529152219.235475-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529152219.235475-1-jiayuan.chen@linux.dev>
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: f9076d61-ae83-41b9-dc0d-08debf3402f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JaOcq91TRJDhDFzPDm0aIrFD+MAVZFAav6OyKX2e8Lzyc6ZsN1M+mNeE4zYZqxAvxCUxLZDTiWzecUeSbLgIExRYYjYteISdNnbi8SIb6udE79Sd/DbFp51UefulTtiishz4Y/KXZi1fmIll/cnHl9TXpbKB1HbRqdmzepRdgZ0CYzUolz+h0VymOf85LEyuMgtVcT4xNvIeLXQUPrdNY4X3A7vo0FEuaznF4jfpr89RXYBSxTYK8ogDdfukCiVdlaNeq1griFbBpBJtjpRqe/XUtN/Px0IvTb7acYNClN/Gx/L1n980C5inD6ba5wI8YhGADCSGqVqpkQr3B8IH0+zssqbMT0LABr8ryA5Zb4W5bECcLPyVNJBWRPxXyaDYpLcgPD8nNxRUZM2W1YgVbqUSQ8h+FJ024k5N++/XiYFrQ27ovAnt64LAadn7KCz5hh7262USKcQMkmskZwD0AMPrHYayoVIMGVwahLSUekyQZXeSRjmRT4m6R0rh4DqkhEoKgel9Eq1ypXgweE5VtZSCRz1uk8fTt0ZR1Y9uH614Uxexo7xm7AXUUky4MR+Q/RMYfxLJZbi1lpEuHjO9qghbN5+nNSzlQbGJyLylbDgvSEr/w1WYGy+jZl2D2gQklq0qWDZelKgLXcVp7HsfYVguThdgVjGscC6kesg3zJwAUFv5/GC0HGC6xnq5HvTs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qg8n+Zcv1c9sE4aec6u1suOw7k2cmcireHztDbYD3+Oe+aikr6O094lBVAxE?=
 =?us-ascii?Q?FdajGLJkx/N8EiNld8NgTyOc7MGD+3CFipKuVdZf7vG4fvyffyMvxxCZVku6?=
 =?us-ascii?Q?xcEMXdhyOvMv9jzosa4GOfip6pN9ilVeS4zyWDZplMvQ86U+nsJ4pfJi5t7b?=
 =?us-ascii?Q?lS3r99t6qDYE7iRDi0SbeJKem/NABEJZUAW58km0KTGjjIVb4IUoOQf4YHPI?=
 =?us-ascii?Q?Ldu6+Ga9QOlLSlehKVSsEQOEZjp0jfjeprmBjJAMn1v7OwZKHUJMK0qL8Rio?=
 =?us-ascii?Q?YFl+3xJLLqO1RNxV0sbj4VNwcYaTiUPd5IxRVHolulu0LvxL5V2YB2aFpb31?=
 =?us-ascii?Q?ys4H2b66B2UQRMWQ/CDu7+4Tddl3zIe/uHStw3u5uw7qQRt86jW/BJclSYfx?=
 =?us-ascii?Q?VNsU8UzfoHEWe1TTPavTacQOwLdVZH1ja69NFkTVs3bXVvVNS065aKa+9hVI?=
 =?us-ascii?Q?kwy2vP2vyZX2u9U7FXOiUS5HycyAtZqktBCx8DEOg5vpJ+qiA3FMfHQudgUr?=
 =?us-ascii?Q?MXfHdhQO7jNe6FYkRZm5ru91PlT+oDyU8fb/Uxc8Kp4iCaLDsYJ/GZzx7xN0?=
 =?us-ascii?Q?oxMwX3PYMIPcVfDzCAkqOQvG7ajFivbzp8BLD1gyaWbNAGyeiqhvLef8VtfG?=
 =?us-ascii?Q?cbuCgpdGrUtfPwnw7jW+NrrWWtXCXJuGcNFPcYI10lE+FSPmMUX6Sj5C3lr3?=
 =?us-ascii?Q?mRTbbXO4lZ36T/fIB8g5k1gy+nnvYlXvPqFlybx/Jy2S1G0HxcogCf+S+8/E?=
 =?us-ascii?Q?MH8YtmB81lbIaaoGcTP6764X0AdhpCZ/95ebZUpV8Q/19uF1yrDqKer/9as1?=
 =?us-ascii?Q?xw+/CGyfmJBiycfU1x7FD060Ct+AVmvSUw4xj8h1WtGsyWFFP2UY0tH/dGsR?=
 =?us-ascii?Q?uktAAZRgkCWyJIpCDZTsXNeKCB4/jkHDjJ7O6AIPYHyRRXMbGoZWXx1NCrt0?=
 =?us-ascii?Q?HoavUPFKdaDWRbNtO5uOxaixZtTQz+ppWtpOvl18Bt2NVAi4kCDIpLbh/Rt9?=
 =?us-ascii?Q?kZ0vn/vC5drz/EJgQGeHmBiQ6uhS7PxNQqwDkNAk3o1LA+2ul8UtL7wrKKFS?=
 =?us-ascii?Q?vTehiOGCdzZrg9wbW8Nb3ZT9S5MzlHAP3xkPjOPq1hRgdWDEE2wW0MLTKnbn?=
 =?us-ascii?Q?m/yBpJWt27mAXhCLokXm9J7mJu4pExgtLfBbX2BZeqOmSHeCj6eCP7K5Pqdl?=
 =?us-ascii?Q?JWZjww24X66t2J0AE3Y55Qu71LNFRaTyCfauFVUDLQgOKNgJbRkmMP22jPAr?=
 =?us-ascii?Q?HR7Ibax5UxztSjQRMRPpcCkaTen7qhcU6aHl7gcNPmgTEdEGkTHmw1MqAeKp?=
 =?us-ascii?Q?v2hq6G6vNGQJOyVPVYrhXL0ZMu6IqInRhAvSdYHxUNGsrKoam89N8PYJF6Ie?=
 =?us-ascii?Q?4X/tzO6YIMczldP85SdtLOFHZBmIdgzLHSLyczzbW6q+RWYlg2rJHqDs+JW/?=
 =?us-ascii?Q?kKopYw2LV07m1wrj0HNLwOdwwwxVgKtu9D7Fhj688Cz2DmlbCiAWsiFVCD92?=
 =?us-ascii?Q?spXxemmM+gg5Cz0nTPpQK1J7S3uLoxT7dQpnGXH7vObL7SuBV6ahvfA5bT1P?=
 =?us-ascii?Q?nf6bw7sZthmBK9z7K/sBEawyzb4pcQyFK7EHlN8fZnETL+JUNUMm93yg5agR?=
 =?us-ascii?Q?tXB4meIj/HcnUQZenpUN2+zGkCHMuH3di//WXuX1y4Ubm1xF9jbTwIt2faSZ?=
 =?us-ascii?Q?svlfV73igyG8Q9v//Mr3S3OqPKqEiD8wU8jdFD8/M66mLFEg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9076d61-ae83-41b9-dc0d-08debf3402f9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 16:45:24.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t56s2HMAQrJk1yKTL1WSa0dXG2WyxhiKNEoQLVBXsaUtAfoJd0MRerL7TThj2gAI9e8Du+i5B7wdQPKCZCXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293460-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,819eb928d120d2bdad0e];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,Nvidia.com:dkim,syzkaller.appspot.com:url,linux.dev:email,appspotmail.com:email]
X-Rspamd-Queue-Id: CA32A6172AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 11:22:18PM +0800, Jiayuan Chen wrote:
> syzbot reported a splat [1]: a slab-use-after-free in
> ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
> under RCU and dereferences a struct ifacaddr6 that has already been
> freed while still linked in the hash, so a later reader walks into a
> dangling node.
> 
> In __ipv6_dev_ac_inc() the aca is allocated with refcount 1, then
> aca_get() bumps it to 2 to keep it alive across the unlocked region.
> It is published to idev->ac_list under idev->lock, but
> ipv6_add_acaddr_hash() runs after write_unlock_bh(). A concurrent
> teardown (ipv6_ac_destroy_dev() from addrconf_ifdown(), under RTNL)
> can slip into that window:
> 
>   CPU0 __ipv6_dev_ac_inc           CPU1 ipv6_ac_destroy_dev (RTNL)
>   ------------------------------   ------------------------------------
>   aca_alloc()              refcnt 1
>   aca_get()               refcnt 2
>   write_lock_bh(idev->lock)
>     add aca to ac_list
>   write_unlock_bh(idev->lock)
>                                    write_lock_bh(idev->lock)
>                                      pull aca off ac_list
>                                    write_unlock_bh(idev->lock)
>                                    ipv6_del_acaddr_hash(aca)
>                                      hlist_del_init_rcu() is a no-op,
>                                      aca is not in the hash yet
>                                    aca_put()           refcnt 2->1
>   ipv6_add_acaddr_hash(aca)
>     aca now inserted into the hash
>   aca_put()                refcnt 1->0
>     call_rcu(aca_free_rcu) -> kfree(aca)
> 
> The hash removal becomes a no-op because the insertion has not
> happened yet, so once CPU0 inserts and drops the last reference, the
> aca is freed while still linked in inet6_acaddr_lst[], and readers
> dereference freed memory after the slab slot is reused.
> 
> This window opened once RTNL stopped serializing the join path against
> device teardown. Move ipv6_add_acaddr_hash() inside the idev->lock
> section so the ac_list and hash insertions are atomic with respect to
> teardown: a racing remover now either misses the aca entirely or finds
> it in both lists.
> 
> acaddr_hash_lock is now nested under idev->lock, which is acquired in
> softirq context, so switch all acaddr_hash_lock sites to spin_lock_bh()
> to avoid the irq lock inversion reported in [2].
> 
> [1] https://syzkaller.appspot.com/bug?extid=a01df04303c131efbf3a
> [2] https://lore.kernel.org/netdev/6a194ef7.ba3b1513.1890b4.0000.GAE@google.com/
> 
> Reported-by: syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a191f87.ce022c6e.138e56.0003.GAE@google.com/T/
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: eb1ac9ff6c4a ("ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

There's a comment from Sashiko about UAF / leak with regards to the
associated route, but I don't think it can happen:

"
This is a pre-existing issue, but could a race condition here cause a
use-after-free of the fib6_info object and leak the net_device?

Since ip6_ins_rt() is called after dropping the idev->lock, what happens if
a concurrent device teardown via ipv6_ac_destroy_dev() intervenes?

If ipv6_ac_destroy_dev() acquires the lock right after it is dropped here,
it would find the newly published aca in idev->ac_list, unlink it, and call
ip6_del_rt().

Since the route isn't inserted yet, ip6_del_rt() fails to remove it but
still calls fib6_info_release(), dropping the refcount of f6i to zero.
When this thread resumes, would ip6_ins_rt() then insert the 0-refcount
route into the FIB tree?
"

I don't believe the reference count drops to 0 since the address is
still alive and aca_alloc() acquires a reference on the route via
fib6_info_hold().

"
Since device unregistration has already flushed all routes, it appears this
orphaned route is never removed. Would this cause unregister_netdevice()
to hang indefinitely due to the held net_device reference?

Could ip6_ins_rt() be moved inside the idev->lock critical section to
prevent this race?
"

The kernel will emit NETDEV_UNREGISTER until the netdev reference count
drops to 1 and the route will be cleaned via addrconf_notify() ->
addrconf_ifdown() -> rt6_disable_ip()

Racing addrconf_{join,leave}_solict() also seems fine since
__ipv6_dev_mc_inc() will be a NOP due to the in6_dev_get() check.

