Return-Path: <netdev+bounces-287454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIqnHLMoBGrGEwIAu9opvQ
	(envelope-from <netdev+bounces-287454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:30:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B452EA50
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C9623005151
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FDB39479B;
	Wed, 13 May 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Twenx1jL"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF63815FE;
	Wed, 13 May 2026 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657450; cv=fail; b=hVhuMu13/6OZQoB9MvPUUHECDILYAh2KueQ9DTGbZLgPm70Y9rCkFtcPE2OtkFiUgw5m2ydNUl3h2XmSCc//NPU8sOZ5o5CESsO3YkHWwVqBFk8pS2VM38bdI3NZElHiNUqq0r6iM5hgyjGOem3DI5hBArvjaJ76f8r/7lblYOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657450; c=relaxed/simple;
	bh=wKVzIqV/3Iy5JSlW6ZynO4qbrOMSi5RBgZOf7CEUSBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rRxTwSsQXqqb2x9PcPMLzqlFARfn+42o1enO1inwGcMSUVDjoyD6jvHIMmEU/H37kBSpUPMqPWYW5Q6/016ZxULmkNF11q1nx4uZxS6AmerLkFQBGAY0iGLOG2sIznndYd4v+nI2Wg/+VceNI7BS+2gpzNrZIlzfSGA2//pubQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Twenx1jL; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvtLs2ZAnUi9gd7F5Hr6f9BCbZnBVP7hzOASymYpgZKYyrBpLSEshJuk/GWzvOfXj+EGBeoRV1gB4+AAWs5voOX3B/g28VFedatmG50+DP2wvazJi9eVyNAH2omuWVLS0ztvUdAccxxgE1XgA7q64kGo9inUDxNuRP3Lifsgz+7El8ev9ogpfxNo6ylo7rKAmQcYDSa/0nEQZwSG8AJ8EVvOJ4z4NVyHQwcI6rys9W/JaVjn+lbbVDwX4vl1a4c4Re4HcGSDvPM4CI8CKj6SchuyV5+9I8hsRvld2txj6gntHbdGLfQrx7Ujhs9m2U9o4XtK6a+kjxgaSFlizTQL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoSJq4X+cYfFhoAIYpSYCNcLR2/n5WnJ9fifeeTYmko=;
 b=d2RWqUHEdWSExHs/3ZnPhYKt3ml+bsBXhI5IWY9gJ3wJu6lkeTI13BMQSTHnANJYDogQ4hRRlsmZ8keInFGYZYHogrYfE8Q5rC+uL7XaCDwiu0Pig5j0bEwzqaT1T/sKNzQSCZyFZRrbR/s/TT87fTjQQlvJnSnRBmk+Is5Mxl9nHjjqqMmQ90oISC8HOSREb4CAriED6ySWirpG57JkOtvU1lo18vZQUuBSo4vQ+mifZvvKbWejo4806BXKzZh+hc3IEWLPAdUPB033mQ4kcFpaFzZbEX5OQl0FrKQPp3d1ywrXunf8lZYgrNXoiUzNNrVzK8fcy22VldDgjgMKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoSJq4X+cYfFhoAIYpSYCNcLR2/n5WnJ9fifeeTYmko=;
 b=Twenx1jLL0FPhjWY/9UM5Daz+WzZ+Y1IY1fQptiX458T+Os+lg8Ph1hc6R8CMxcSItiA+ncF3h6Vfd8wNkuk3sN/wT6oG6TQ2E/AU4xE2TF0hl5f+wJUNIIIJp5rStwE088CMb4bIZhs1VDs7o0tQVHtqihjtEH8gCX3hl+MALqHIoLrYkDovG0ov9HhEqKE/5+pitH2VKP//8DZw68/N9wkJfjaMWzPXAKGRIi4mDiGEMbzK5iS8nKrpVEDmAj+XpfZ+skPjihr+58mf1B7R0lizV+Z08vj30icfGPsdacDL0UZKnbuWH+QVC2hIN+YCRKA8QkVJQL2qvldEiu3/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:30:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:30:41 +0000
Date: Wed, 13 May 2026 10:30:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xu Rao <raoxu@uniontech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
	willemb@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dsahern@kernel.org,
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] ipv6: addrconf: skip autoconf on unregistering
 devices
Message-ID: <20260513073031.GA344043@shredder>
References: <1BEC9A31C1E03F38+20260512124410.719476-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BEC9A31C1E03F38+20260512124410.719476-1-raoxu@uniontech.com>
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 150684ac-ad21-41ee-53a6-08deb0c1894a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dsNtedD8FgstXnsYwKKWMoerTPf+Y4NrKIEtpCzw1ZvP1sHj5EAUQGt9dWLWVmEjwbds/iPiOwh4+Qhvt37o6+vQDEr5klRKccSELtbhEC6Pz9268RmsP95+HfvVgkB32khAW/EdIjXAd5fQKpFJy+2tGDKXDi3u8M1Hv5NgH2RSnRT9+CCuf1qXHhJnvb0zq1RoTbtvuec5g9/2H3gN4MjWUQMTvzbVgYhAZqr+1SaPIus6MrSdHh/6ZfcPIVbC8T/barwzrM/mB3nAYUcPs2OsPlNA8+hVdOoLI5YkZTumyNbMZaAw76OirY5x6Mf+DkAddx8ZLTgsWYIt0Q70x7ocLGMc9VjKDodyKwD/0jetfoS8U5amPn2HAQbOgWLG4kvPljosHQRVYpd30oLSzbhfRYjYM9TxBYmQaFL5+qqjcOgVOo4aB5ykIk7EMxA/JJQke584hWC1l0G8lyh8fU+Bsy5BcZJW3/QaCrDIyqlA6k3fwIkPB2zI2S62W5Ue7e6FA+sUzBmfzilOTTfBRSqEFWN+v34uGEvFfN9JAjav0ZLdsr1hs2sJ1Z9RKzDUCCLBQqhWsGorn2QXr6JmcWBvA4FNGr8UqROVp7tEO5QKXaNGtnT7CQZVV4tkkn/p8oaEJIDBaFXragmqVXpq0HMCdekZzRlq3rzkqFTdtmnwn1rn3Hup5tb+jJsF9pay
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cOGerD5hjSgQQmem75Q7kcMj84oG5+fSz2daOKOum3gjhHXe7rBS1LptH5K1?=
 =?us-ascii?Q?w09syK7Av+2bW6poJ4gp/vqKpgUIa3mE+9PWi+faco9o/Dzsgn1Ow3cofWhe?=
 =?us-ascii?Q?gR8Z12TDJVCoK5Ccy8vzz7da23fRUZ/NLTjj/lSXNY0cWkiqQ8EW70ixrr4E?=
 =?us-ascii?Q?7cDWGAqKpTlPwYE6LDlV9q3lYldImq0s5ONjuZ4l3sM64o+dWlm0j0nKsUMS?=
 =?us-ascii?Q?BkNUX4chVmnhgeG1waB8ZcvO/X7Og/4iQoawWRFFLYV7wiZ7Wud8BaNp8OTU?=
 =?us-ascii?Q?CPkmFhsigibybzDLKEZuSUBaCt/RFmDJN3aIevV9UPXZt8bVV/i3vZiSbhy+?=
 =?us-ascii?Q?Cyoj9KpoG3aERLa0J7lThBAqlOLvWMm7//jldytnBEWoVeA+z769rzbk9kea?=
 =?us-ascii?Q?QgL487Rt9tzq7TReTbH6FS/pHkqUxCRcc5MZAN3/n9EfqNlAoKDSoN4F+RP5?=
 =?us-ascii?Q?+Zf0D+odgUjplvVtjdhCFhiy73wkI0yFqkNOKtUOuB6Y76s0xGaf06VxbK7s?=
 =?us-ascii?Q?0zGdnQNNtAX+6ND0I3ct7LrWZyJgbJrQZu0KWDg+MtMp7qqhNjr8wLJN7JKx?=
 =?us-ascii?Q?5ZSuoYqupUvgk7udP5Oqgx034bMn2McnyyptFr+9/pkrfxZ4OkGjwqOywmeH?=
 =?us-ascii?Q?nbFpnD4iOxDtyWGiuPw/2ndpILRAby0aA1JwVLV7Jx+YCsWAAmAhf53joPDB?=
 =?us-ascii?Q?K0DAINUAiirdz0kcpI2KZX8cZepSsCJo+c2SrVJka1fCGh6VDQL4lOxE3ci/?=
 =?us-ascii?Q?y+wKbjLiekRZ6rLznN4axAbpFb+l7oI+rt6slJisRSnnrJFzKexWpUvStrqS?=
 =?us-ascii?Q?8mahDi8PPgpBD8g6O6+YDwpjjfvgZjTVQ0PTbuxSOMVaZGaB6wUI3E5gBJHF?=
 =?us-ascii?Q?tZEpnxAYhuBzqw09cw8D/eF0xlZquuN5DMghTmm9nOjycFYUDuI1vDg8Xsc5?=
 =?us-ascii?Q?pmhXAfsdZwKTSPesA7mYdsX3DXzhAS0sooPbln3Pk3rK8aULat17I3J1idk2?=
 =?us-ascii?Q?F05BhUwoZu5B05PGgp/lHPOpCM7jwDEYMrVE6Pi2xzCVQu1HVSW+OhSd5frt?=
 =?us-ascii?Q?1wnZPQ9TpyFyG4l99FEzqiGPLZSrxhJk54Tt5D4v8lXNp6Vsh8u0E4/2fKwA?=
 =?us-ascii?Q?LzLrEnmIRxZBIOlnxIsC+7ndoGrUMise5Wm1N9j22aRX8i6AGkaD/L9CLmzo?=
 =?us-ascii?Q?NcXFUDe+EB6lo1D7UaBTcCIs62CsetJ64PsbCRI4K3PAY8CXt7wEm3VNVh0x?=
 =?us-ascii?Q?06Mo81rAHLISbsxWqlkZ7AMNVBvWh2p3G7WFJtAXkHFjsla7vh0GHEzc0BzS?=
 =?us-ascii?Q?+Mvq8FpxbcwqaW7RNf301WHYzbbq0f9//zpCBEhz+LWWz6cxaLfadQ3OLRQz?=
 =?us-ascii?Q?ikh7XlOb/yM3fLm0XX4+TGFM+RE3XtZVYbZZLDftHDxr/UfPyA2CJf1uYMY+?=
 =?us-ascii?Q?3p9gz4LIy4ToeOAtDF1Tv4aslZp1xl7DPItajTcalMftYtbKnEsmrEC7DhrI?=
 =?us-ascii?Q?lx7guj2GiaqXei2b1jWTB/2fuNe9pSj67k8In74cK7zIbpBmESm1erP2asOv?=
 =?us-ascii?Q?1uJXae0vJ2s9fX2EcA3VZwnn40+wdZkqoqZbzAznrRReU5oBreBae5s8t82n?=
 =?us-ascii?Q?PzXEZv5chzDjDx2qaDsYGdaah+tad35eDgMgnivpvF1mdaNsFfdUCz0IQuFp?=
 =?us-ascii?Q?zmTE++ZA60T6B8rKuL28SiKCi/O/R7k1fRHuCbZKpmx9Hklq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150684ac-ad21-41ee-53a6-08deb0c1894a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:30:41.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kinxh4NeZGRbtr+I0kHOh+1RyIdr812ZCMqZzxHK9J2BshS+ZwA28ae0ODSSgmtWJH/R87kUK1JFAbwpeyf8sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
X-Rspamd-Queue-Id: 631B452EA50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287454-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,e2af46126e0644cbebdd];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,appspotmail.com:email,syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniontech.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:44:10PM +0800, Xu Rao wrote:
> syzbot reports that unregister_netdevice() can wait forever for a
> netdevsim device whose reference count never drops to zero.
> 
> The leaked reference is held by an IPv6 local route created from
> addrconf.  A late NETDEV_CHANGE notification can still reach
> addrconf_notify() after the device has entered NETREG_UNREGISTERING.
> The handler can then run automatic address configuration, add a
> link-local address and install its host route after unregister teardown
> has already started.  The route nexthop takes a netdev reference in
> fib6_nh_init(), and there might not be a later ifdown pass to remove
> the newly created address and route.

Do you have a reproducer?

The kernel repeatedly sends NETDEV_UNREGISTER notifications when it's
waiting for the reference count to drop.

> 
> Do not run MTU, UP or CHANGE based IPv6 autoconfiguration once the
> device is unregistering.  Keep NETDEV_DOWN and NETDEV_UNREGISTER
> handling unchanged so the teardown path can still remove existing IPv6
> state.
> 
> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
> v2:
> - Drop READ_ONCE() around dev->reg_state.  addrconf_notify() is called
>   from the netdevice notifier path, so a plain load is sufficient.
> - Do not add a Fixes tag.  The issue does not appear to be caused by a
>   single commit, but by a long-standing unregister-time lifecycle gap.
> 
>  net/ipv6/addrconf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5476b6536eb7..a517e57cf86a 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3666,6 +3666,9 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
>  		break;
> 
>  	case NETDEV_CHANGEMTU:
> +		if (dev->reg_state == NETREG_UNREGISTERING)
> +			break;
> +
>  		/* if MTU under IPV6_MIN_MTU stop IPv6 on this interface. */
>  		if (dev->mtu < IPV6_MIN_MTU) {
>  			addrconf_ifdown(dev, dev != net->loopback_dev);
> @@ -3691,6 +3694,9 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
>  		fallthrough;
>  	case NETDEV_UP:
>  	case NETDEV_CHANGE:
> +		if (dev->reg_state == NETREG_UNREGISTERING)
> +			break;
> +
>  		if (idev && idev->cnf.disable_ipv6)
>  			break;
> 
> --
> 2.50.1

