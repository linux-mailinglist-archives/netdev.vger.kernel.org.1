Return-Path: <netdev+bounces-299442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rRqEFp/0L2qeJwUAu9opvQ
	(envelope-from <netdev+bounces-299442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:48:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7741686625
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:48:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=JjRwq0tE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299442-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299442-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AC9B308EB1B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8E33F4103;
	Mon, 15 Jun 2026 12:39:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978C3F39C5
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:39:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527183; cv=fail; b=KrTo49NswRoL2vBRwz2h7qkTx1P+iWSjTMULPSsXlpJEfLd5PVV/6ZF/o7OIEB4mNBlWyhQNzwyeU5EZrtbK9dHXMlYZlidiRX8oxRp7xt9S7svMbW5SMF113AkNnLNHxxuHNNmMZwuZQzG7YqeBoklpQegoynMpmK5ggrNkUIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527183; c=relaxed/simple;
	bh=mXSYKzG6av4y0tgAWoUofkd3+0243LIRWRU/3q/fxfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TRGxeWMBQ97jmPxnra0dY0WlPH81IV//wbWTrpksLqZwd/Wc15s67vqJg79+OL2Uk0naG++KXjtwRWtP/IDK2RvTdKUJT7rKznMBv0kZeUKLAlY15qujy61p6qOzYE3Q0aCFyk/ck7vunnSDo3FkSP2saLalpsj9VxxovLDo4NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JjRwq0tE; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdkQ5CiLBmwMAa4op4J/LTgzO9CQeZvWhMv7ZfJ2Nv45ZcuV98NYN9lVeB66D9UHeAT2LDUQcm4HYLOQh4Vf96hr2fjOKtME5ukmmqxcmu4nhPC3eWgqOWn/gz5U8v1rj+CtcLSLs8v1qX+SiFta/JjWqMSLM7OL0oDQ0xuMESLSRPfRQJ1U/aNodd0wEeA+pWjEKiNEEt9NpDlD3yVrnL6pz7P0rljqYDRctFN0gQUJ1+cWeB8jN8IYGuboaH3f8mqgzSvDRemmhhleSuWZzl1MJhJhCYa5xIjjihLxF3NHuRzwyU0Dyj8fvtY7PBni5LoPVEXOZSEADjcaPUfNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5fL9bcYa8Ajd+cJKKSjq5oun5ERgRKyLbYOaRCXkW4=;
 b=EGtIZwD/iqOArpnQAPU1psYTGLwEr9WtQR1+9pTKc/1zK/wNITQGgBDVBnC8PhXboyy9BtPBDS71wZ1LVGzJSfQEyFHgWrLZGJQNOwPpjjKK1zf2bGRLKEnEVNeN31nJYT71onA/XITdd2iAFelKIVNFeOpflE5s3W9xzT7r5zViHdoUUeEOlqKXc8ueMIa/JCHb91c4fPlqjbobwxNvTRnZqKiLXZGcwWVP66CaFBK4N6HZpiv8MOiDxb6e2ltLH5cLFjSKADkkNVm5WU71+VAJWsVGIRo2a1Ns5ml16fj7u03O9I5lLh2mzQq9xphbNdjobj3vzA16mx66LIuRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5fL9bcYa8Ajd+cJKKSjq5oun5ERgRKyLbYOaRCXkW4=;
 b=JjRwq0tEmkwTAWOcx1xGxy7Sh45U9yaCzkmbhwiwRQk2Gu3lPWLUkEMuhKyXxQFeBblDaVdSz/mb4XnsAFED7wAFJqJQmKtXFYWM9PiyTGj5E3/3VouPWUnAuhLeDxqK5Bs+BL4lTMk8sds395POFrWInjUfX9sDUNpn1nZxncjgE4/MqoFTPy9vpaNPF4QQ8abrv6mTWG7+AVtUkJ/51Glw8zOykW+fktRIhUuD6a69Ioes1ecfvdQ7Yjfg+QHfpcLvGSad4KgmG1eSrH2Vs7dbl14CG0sM8Cr5hjtBEllV406PZR5buG5BjrjhqljxRTC88in8FxsPGFR3X4GwCg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:39:38 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.014; Mon, 15 Jun 2026
 12:39:38 +0000
Date: Mon, 15 Jun 2026 15:39:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 5/5] ipv4: fib: Convert fib_net_exit_batch()
 to ->exit_rtnl().
Message-ID: <20260615123929.GE485439@shredder>
References: <20260612063225.455191-1-kuniyu@google.com>
 <20260612063225.455191-6-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612063225.455191-6-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 761f19d3-fdbf-4f05-1bab-08decadb2a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V1jhj1OpWpsExKlMSBpNKlZ3yyrk2MPbaQir0fxRjCTucD90vNQR53fYB5xcFR+a1Y4ZPPZqVQ7cy8Je9bhY1Kwzaji75+DvVfPUZVcqqWCUjjJPtvFWrsaxOeQcrp8gHndJVwmBgaJAROuXr58/b74p1axJk2G4z3aPcQdFGQQtaiMRX5RNgjyGvWQIY0dijmOTIqAFlX/2KtpZfQLU+FNL764+u+mHSjzvqu15rJUWnhLSsdfrIk465RJIhbxZb+D+7GXusFVcJBWzMHfX1nL3hT0/LGvqdjQj0KrF4nvXNhgaiT03Y46svA9vOfLxcLUZjSGIwcMMjWkr7nswlt0JYICyTwv7+kCJFJpVc0YYB0XEOLG/W8s5yzPfX9LHxjaIJfLBFn6Mc/m5C1awDau5Hs7Kway24/e7aPFlKXmwFjYc/erA5FOXzPVlChEGYO5PYTYqRjQpoarc0hSNaNRf4bhhYa4a93jh82yAms5YVmVFHv38YEfB1bs/mUwZtN2+1KJMxlFvLzlZ7kioJ+xHtio7mOyuNMEmdvq0c7uJzJL/qG35Zh5JMHmQl5O7gAHP33AfdoY6pxtIqBufDndI1i/dtMms9B9cZXdD7T/3rHjxSvVp1m+mOkODNgShAqwAPM0unxQbo9s2w1TkJWdqttWxq44rkvikk9WsV7xB0HDHkSCc8Yds0GAI+0Hg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZ0YcAc16mMFSP749XpAr56+sH7waeWePHT5jcB/P9NlLsecNjn/icanUwTu?=
 =?us-ascii?Q?0Mzis2jX992fCE29xOAwzumnk6mucFiyc7OZXt3kinfbQB4rSGRsRKbP5Y8E?=
 =?us-ascii?Q?geZ+/qVCaDr2+xpT8jlTav55Uhaw/ieGggSRQwqPu/G2Vy0UQ/ybBgVoUxTI?=
 =?us-ascii?Q?aQIS6hETxbnx5wf4KYi2/ZePhG77IZvDlaZvToc6s4cSfXsPA+tuEAQyJwc3?=
 =?us-ascii?Q?7Ovt12tVF8qGltGXAupITFaCZHewKdb+W1uVLjDMimurYSfUQHCG6renF5oM?=
 =?us-ascii?Q?XF0qybrm+xKyxb3MzwlwvokTbh89kLQeipbRMz9Imn0YHjq9e4WfcpTP7F+w?=
 =?us-ascii?Q?c7QxG+Z+UeSAzsIWa6HC/emnmRKZCMgZmDqUcW/SsBPOYxIJdii9YStOJ+yN?=
 =?us-ascii?Q?8onxI89/hAZc9dC1mfbp9hWncHgd5DUecJxSNWevwzlThgs8ZrM/uif/906a?=
 =?us-ascii?Q?gLl9s+HIPYrHbpfftkycTSCIcDDwRizyXvezAZo54AQOZK3Lnax01GuHtgOs?=
 =?us-ascii?Q?/mH0c5Pr2VJvZigujA+em3HxL81nZCcgVG3R8lLTL5aw8iy/WELNlSRPeQ4W?=
 =?us-ascii?Q?VYDyZWZoNK5HXtxjCF/Nxs3x9VQYbRdx35i5DDkwewM4xs+DbcUY8TPvvu0b?=
 =?us-ascii?Q?jYtbg1oHQK2sBqBVK9LmC4vM9o0gaNBrC6aRvZqqVUs8LiEib6EltVr+RQ9R?=
 =?us-ascii?Q?MZgzctr6ql9kTosP3IdDRqLRAJY+kIbG0zdEq40B6h4FxzZdF/0HXfeDisni?=
 =?us-ascii?Q?xxJi6v8xLs96fXnmKsICv6yU7QZR7leS0QtDbabgZdi8P7dnB1jX9p5ThMzt?=
 =?us-ascii?Q?qL6YhPGc6ujiWxhoFBJgBWZwPMCN6PEhgr/XgQyucwH/MB0i9gCb72agRG9C?=
 =?us-ascii?Q?dlTg5LeRfsbjuOO7ptg67ok+MJfCZGBqwRkEh7t3V7vVuKFfEEhFbf6fCKe0?=
 =?us-ascii?Q?CVvvj1aUeAmTUI8+0Y+olfDQuaUZL5ah+NN2gm2/3M8cm4nW14L4QtxLPTVA?=
 =?us-ascii?Q?oRXs/McG5AAFmzteHjC/l0QwfMaMcJJJdFXIxJmZcHyi7j8tqDK0IcYNH1i+?=
 =?us-ascii?Q?wY1dSC9naqyQC2klPnD4/Vw5uO1++2C7pm2zAMjQZWQH4J+PvC68bSexnWOC?=
 =?us-ascii?Q?MlDiC3AOu9b/Lm4LrZW7a+dUhiygxYqerp+HG2EthjlJViCvOhPvy8iIpHFW?=
 =?us-ascii?Q?AM1MO32YjrwpxAin1M0M282bmujzoduZXgm0xRvOEtNq4L6U9HgH4xCdwN+5?=
 =?us-ascii?Q?DWFGF9KhvxJSRDsr1QtwVq/fZnqXyNF/lUQFqKNM96Zlnqfvwlt+4jvIInhF?=
 =?us-ascii?Q?aTt9/qnLyk1JcA4TMDvhMu+YWATnKU593iP7wW0cz0La94zkRD0BnxCv9t17?=
 =?us-ascii?Q?EpYKaUGvE5o/LNHD8ReV7fkMJ0MkGKeicMWaImIDHS2Tr5YIZFQ5BmwCOgEZ?=
 =?us-ascii?Q?ep6oMzbKdGw/a7eJVgwwbwDUcloELuCsdaordfdvSAwQbOaQep1gFxMkY18Q?=
 =?us-ascii?Q?qhxnw2J7XmgziPtc9ZSfxZOFxzJ5KP+RjOVU6fjqlP/GMbRmer5r7v71bpP4?=
 =?us-ascii?Q?9eI8Q/+21h+azIUV6By1Z2u7sY8dusYTE2k69ZGWbI5hp3z2iZPBtW6uJIoH?=
 =?us-ascii?Q?eF/desNRfNCloLoOpf9kmAJUp245Vast00zQIeVb/itnifpbErv3M1Mr1pQg?=
 =?us-ascii?Q?me4GDlQPPootKMgjCWr5ahOaa0a+AfwNSvU2PORJ3TjynGFJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761f19d3-fdbf-4f05-1bab-08decadb2a20
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:39:38.8285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65HHp1DggF4ce/R8wVdIcmv5bl+VVxgOSndw5GE5nF05P64nidM7cAY6Cmw0Q9803DMepQ9FLZZAgYfkfkvZhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299442-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7741686625

On Fri, Jun 12, 2026 at 06:32:08AM +0000, Kuniyuki Iwashima wrote:
> Currently, IPv4 routes are flushed in ->exit_batch() after
> all devices are unregistered.
> 
> Unlike IPv6, IPv4 routes are not added from the fast path,
> so we can flush routes before default_device_exit_batch().
> 
> Let's call ip_fib_net_exit() from ->exit_rtnl() to save
> one RTNL locking dance.
> 
> ip_fib_net_exit() must use list_del_rcu() for fib_table
> for the fast path on dying dev.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

