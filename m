Return-Path: <netdev+bounces-286276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELnlN+VoAGrhIgEAu9opvQ
	(envelope-from <netdev+bounces-286276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:15:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D75F503C3F
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE3F3300877A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABD03806C8;
	Sun, 10 May 2026 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bmy4wSuC"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49464;
	Sun, 10 May 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778411747; cv=fail; b=AJpYfg44RwfPbkFrdySiuap+7a2A2LPqJqkJHmMrZifdr94+Y+iBC3J5bXbfRtW6MjWdC0368xo+5XpziiNBpDvIj9Y3nmZRlMPnTKiRFsi7VAfitAWd/k2JTTf6u+/zRhACGs3aJQ+3KfVUBfJVKT2kLnbwwmzV36MrJbem+tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778411747; c=relaxed/simple;
	bh=DYChM1W9Ezqme0NzNNHVx9oHZd0/br4IDebgRc064ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DRX3CyYxZkvPxPIZoyjGC90iXkCqHT5fOo1RUSTanGt9pyexVo49wc+sQ8AMb72i9x+5yneWceK916ExvshZdH71aq5v1mlqQPh7L2PThqXlowRm5MvzlcBjjVx1qKXpvqSp8gpLDtbxIXQXKu9QNIS4gbFzp7/EhOtO26ZZ28E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bmy4wSuC; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSqJF9S2NyrBlPOyfqS3ZOdm6m0bNrxLE+88nveOiSGco2x3p1DAEe2aICz98c6PNZFUhY+wc1Cib4OgdGio0t58nQXLCqIwUsBCVdoyynQqP0pKekDULEebPu0SKB91ae/nAbRrVQC2eLCIjgRsBXyvs5qJzjgK0YUvBk7sBHmiSbsZe9VfADTuzRu+cIAC3VHvUhVS66CcLssMh3+/VE4R0iqr34l+/N60Mth1PMAfj+GdqwwuR+MFFozBTdSWWO3miJcwpsJS6GLHnbaEzztsI1U9/z9mGG8kLz7+M8AxmjpjcO14oZhqfJfEMt6lfDCeywO9se4k1wsucMik4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnYBgqJx4ctxeEDJZUpR1xv2cvO+eqK1Im+MiH/TRVU=;
 b=OXQzgyZiS/guReUHZAH5UOg9uHXdWe2bvMYCoQhegEjeUw7Nn7/j/qU7ufaSFSDum7yatvnMpAFLX0gLpgkUo68wRbypX5yriRpt25X//RG/AQgroAUPIHgdiOcFfBv99I8k0kRaoc1kythRHa+FDyH2b11VaGEaFpzj621Lhly2dQoQrj29EstrZAQpRW5wAfH+R9IR3nJCD5bXAkcMqIfIRFwZiZ15Swd/DI+EU1pY4feIKJLJmZEEgJgYlX7m6VOS/GTw46p0PUBX99tq//FJn81cvcCqcYfEpz1+DCeYsfspS3Wl73PZIAc0ffrv8zwfZ5r5Si9KLhSb6tXVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnYBgqJx4ctxeEDJZUpR1xv2cvO+eqK1Im+MiH/TRVU=;
 b=Bmy4wSuCtDIGDhzuOc0A8/jM79t2LUzgLiT8fOLJFvw+xod7Lye/XopctCDCK3XUJgVJxVpHC1gaacnnKXs9wtXMxxwU7ovDcQWd9XFrwsFhRgFLmDTUeL5dBb/2Sr0bMo5+XAbhA1yL9Y+tHpmV6RBoNRTGLwCZjcWs8Na9sG3TO87q+W6fuizxLrMqhuNL1ayks9EMEZSut1wWT4V121/alHETweMhMspfSJcxdca7YFoOW69cseT0exOWMDtKQ4JqA5w+rtLOhewBES5B8QZsEVHPDZH/6EnIZ79UsaSJO67VR/I+kL2G5ZG/FJzmj/st2uaAG0vywKvP02Yu3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.22; Sun, 10 May 2026 11:15:40 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 11:15:40 +0000
Date: Sun, 10 May 2026 14:15:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: syzbot <syzbot+ae231e0552fa77b26ea1@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING: ODEBUG bug in smpboot_thread_fn
Message-ID: <20260510111530.GA86145@shredder>
References: <69f88fc0.050a0220.3460d5.0004.GAE@google.com>
 <87qznowlfs.ffs@tglx>
 <87bjerwqan.ffs@tglx>
 <20260507173010.GA977556@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507173010.GA977556@shredder>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: e9705e2c-7a53-4c6f-d299-08deae85783c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7LUUFLbNkAkXw9S9ARjx6sK503pFuFbnR4HSU892fgGfOCP3ilKrbHh95iwqdrQ8KEg20A3RKQBHv1m60lL/5SabKjDzVjIF7TANGSJuJi4Ed3q20rNwvC6jZh6ycGZWhfC7BXHvV1V7JxLesu7Pq1IAP8RyAi20qyZBb3HHzuD5FgEp6Iga0S+e+uWtK/EG9rgxu5sH8Wfv0OUQBO3uXWITQDvyfeZ52gD3ncJI8f1tbiejyU68iKKiSnKeAPDxuE43dcd+R+rR5mf+YBYmy2dTCiCnWoHln8EvfBO+vu5sRZVI2+3nVXSCGqT8248MPreLNY+bkU+GSIeXj2bRQt7yLxZK/56JCSyAXrcdS5QYWkGpoPh3PXxRhWImiC5qnkN1V3Mepoe77oGnw89/iW0iKVssBqn/jJQsKR3gMS1Er9grUW7Agwa3TAWguuGZkTAAyb4mAUrvnLaUjd0QovcAEWT0bOu+UhQJ4Bg3IoVb+xyreA3Je0/W/4mGMsOHOBnFrylKJkhgnf18rxEruDqSdOOL0exlkHEvMV16gYph4cqEXSWHhqmM9MFX4kKzFwrbVUjR4LqdgpFnPXXPVkuCEUpUUDU025Jz2DIUm01wLKZvtfIz5n5Jv0xZfqr/QR03ThLJPbMaptkM24Mt+0Dyyz/aU6TanFn7sFf5QU68q2GWjqUWsYuwN8umMS7X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfTKNkcUsi6HjJIRYl5uJ9PqwB3jU/wd1yOR0kX9YM8RmevGsJBTSoryr9OO?=
 =?us-ascii?Q?ekrcV24upA6qOyL7aYqzxNKAqcnDAA2iv+y9FPudR+e3N1xxz/J//+5brJzl?=
 =?us-ascii?Q?RueFBeyGWPriV4JCwRxSGl0pFucvJ0cQZsFGPQsf/1kK2igYMU1ydO5WItnY?=
 =?us-ascii?Q?vfGw2RKWMtaMP9P0p2AXIb3WcOSiMPnLQiI113bgGLyzNLu2G/9jtfdxtpfQ?=
 =?us-ascii?Q?BVXJ2vHza4nWooHc4VTMM4Wp2+/+0EriZl+lRdm83kRlG1rDvrB5WFKeTU3H?=
 =?us-ascii?Q?J2U9jNBJFTSSwuQw/EjmVDaQSeCWD/aP8sgpcGNiZMLX43S0jVhVsTUEHOdX?=
 =?us-ascii?Q?8j/7ycV4EIZRFeT9XuomUqKug2Gjd6cJDr249vED6e3GeerAxfih95S1+aoT?=
 =?us-ascii?Q?HbJdrvcWDkUEth3sJqOgyHGBktTsBNIIrtI+nn0ClPF2VESQ2QritdBDObmq?=
 =?us-ascii?Q?QCRM/YexbQ2jZ9342xhfeeJ0rLe4kW/j2ijhXrqG9j6cBJvh7Mopd5h6Yttf?=
 =?us-ascii?Q?P1+OjJfZ5Syc5fkZSrPdbevWdOKP11nxxWkqgWw2nNKlgdE0z88pZVO3UELC?=
 =?us-ascii?Q?8Z/1iZneDbEFNUHzngKW3Zig+C2MUeGuNcoAQjKy1qebNhCXv8bV2+3a11CC?=
 =?us-ascii?Q?G3U2Mx5paEQBb5sDaQRxEmhXeht2ffe9F+eXu1Qztu2GCfNucoeubt4eYbP+?=
 =?us-ascii?Q?OREmsE8J1iwFkh9rEZZRB1dPXJf8k5OEUvmxay7JZmsxMbg9dTVeNY4OJr5Z?=
 =?us-ascii?Q?tF5dJ8RFHFUQQDtNVO/YZocAr8mEFMjKC8dZV/3RgoI5rAfrSzZN3F/CoKfm?=
 =?us-ascii?Q?sBqcxU1UMp61zZymc0vfnSnn3mDSR4wr5S8mBQX8ejYQui9gfkQCo85+J8AX?=
 =?us-ascii?Q?gVBBuSlaBYsNJuQpnBdLwC7cyF9eeM3Mvwxheux2OpZl+WwsbCXBI5xlNytI?=
 =?us-ascii?Q?2gaPLLPK61cO5q/KALA9d/yCovvfNqScwuqEaXDACIjbp6gg1ptuCJV48BMj?=
 =?us-ascii?Q?LSvYEsq0ukCu7F5lsTBu3HdJP1ktv2HQ9HUUpmtBpC5LmvtfzOBK/vA1gD/M?=
 =?us-ascii?Q?YzI+wIZzKCRobcqxNMlbGhIlwaeZ5ej5zwKXJk3FZRUMK0iXQA1fg5ZEBBDo?=
 =?us-ascii?Q?tSZa3cv6xBlBPhYpjy7esm/NZ2O4yJI6XbQvdbJXHrFc43v7Fogbi6UM9qC2?=
 =?us-ascii?Q?Dri/V6ZTPTrEIGc6SGGK2sQnENSiykGs75dQOcAlNsckHHSUkyYGna1WYXef?=
 =?us-ascii?Q?rIkDq1WaDD7f0r2WNT2mhMdQlNverMrp12UrrgvCbPRzYUylWbD1BLKIk+dr?=
 =?us-ascii?Q?VvjVXvay3AGiPtQx2QECWf4/MVCKSkGQa8HZUUkYDpsIdasbA9rmgNP6+0BR?=
 =?us-ascii?Q?APf/gyWsiR7JP0dxdUanh2lKiYtjCNIlcAx0CdhxPzaM3X3PXLD5Px/laaZU?=
 =?us-ascii?Q?f7OX9q3ZinR+vI13m09TChmMM15v2KlxK0xpVytNKQHdJ35sJazOMUcMuO37?=
 =?us-ascii?Q?m6Df/T4DZirsMoLt2qZetavrIm/t8yTbj9GXnDAUpILRW3YPGkUAEZbe089p?=
 =?us-ascii?Q?FfEM8IjrnOzxV9Rm1KVU5/XrWuW4I3oFECPPXtmd1XlXMdMFTZI8H0cjfkm6?=
 =?us-ascii?Q?Ol8yAKxpObNl/YdW8fARfjvr4jlAWNtdzGxZLHG19pNtYah+rsbUhn1SVTsE?=
 =?us-ascii?Q?RCAQhemB494XimW3jyxKvyDdPhZ3ZXTd82mku+l9zxGmpRMX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9705e2c-7a53-4c6f-d299-08deae85783c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 11:15:40.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz8bDz/RYTR+cLX3zO5eFDHxAbxt+GS/4aLhh0yUJtQ1nHa3TuFuo+peGTzNv8OJx7YXiDY014Nwpbi+gWwPDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
X-Rspamd-Queue-Id: 4D75F503C3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286276-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,ae231e0552fa77b26ea1];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 08:30:10PM +0300, Ido Schimmel wrote:
> On Thu, May 07, 2026 at 10:57:04AM +0200, Thomas Gleixner wrote:
> > On Wed, May 06 2026 at 18:29, Thomas Gleixner wrote:
> > > On Mon, May 04 2026 at 05:23, syzbot wrote:
> > >>
> > >> ------------[ cut here ]------------
> > >> ODEBUG: free active (active state 0) object: ffff888033a47278 object type: timer_list hint: br_ip6_multicast_port_query_expired+0x0/0x380 net/bridge/br_multicast.c:-1
> > >
> > >                                                                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > An object which contains an active timer is RCU freed....
> > 
> > Unlike the other timer in the same object, the own_query timer is not
> > shut down in br_multicast_port_ctx_deinit()
> > 
> > Something kike the below.
> > 
> > Thanks,
> > 
> >         tglx
> > ---
> > --- a/net/bridge/br_multicast.c
> > +++ b/net/bridge/br_multicast.c
> > @@ -2030,8 +2030,10 @@ void br_multicast_port_ctx_deinit(struct
> >  
> >  #if IS_ENABLED(CONFIG_IPV6)
> >  	timer_delete_sync(&pmctx->ip6_mc_router_timer);
> > +	timer_delete_sync(&pmctx->ip6_own_query_timer);
> >  #endif
> >  	timer_delete_sync(&pmctx->ip4_mc_router_timer);
> > +	timer_delete_sync(&pmctx->ip4_own_query_timer);
> >  
> >  	spin_lock_bh(&br->multicast_lock);
> >  	del |= br_ip6_multicast_rport_del(pmctx);
> 
> Thanks for the report and the fix. It looks correct, but it's unclear to
> me which commit to blame.
> 
> AFAICT, the trace tells us that the timer is pending (not executing)
> when the object that contains it is RCU freed. However, it shouldn't be
> possible for the timer to be pending at this stage since it is
> deactivated when the port multicast context is disabled and it is only
> reactivated if the context is not disabled.
> 
> So, I see two options:
> 
> 1. We did not disable port multicast context.
> 
> 2. We did disable the port multicast context, but the timer somehow got
> reactivated.
> 
> I will look into it...

FYI, I found the problem (and a reproducer). I will try to send a fix
later this week

