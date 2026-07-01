Return-Path: <netdev+bounces-303679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qKbPC5oYRWqs6woAu9opvQ
	(envelope-from <netdev+bounces-303679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:39:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9442C6EE383
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:39:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kWT2MM66;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303679-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303679-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C628300E264
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64048B373;
	Wed,  1 Jul 2026 13:39:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227A480343
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 13:39:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913160; cv=fail; b=ldrkI1nr6PcytF7rFrWP9yZN235jOfDMiKCiZQDarhiFViiE+ajcyBPhiJv3PP/lpq35VwM7ZIFzHW8NeSFVdjN7ZbaxwgyumQdU8I0KlUDTyYkZixEaY9YjeYxAYvii9XN2u9ovcvrVBTmZY1kHrIiOCywLN9aAG8FHB6LNTvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913160; c=relaxed/simple;
	bh=AuL9/evNvdTTDUdJA0gG8kksuk/xiJBg/M0LZiZa4Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WmrSPQzdHbEpGjuyNcHWKUIXcZZLqBGeq7bGqELicN4ZWMjwC0VlqGXalxUtEch9zwuNaGALbh/f1/Mw2CB6e2gSvcLKSzaaWDZB2GaYpzmm1etcnK4b1puk32yFgGLs2NrxnW1Mf3jUF2jE8XyAc0gEmWpoM0bFb9G/V4pQoeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWT2MM66; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD2TqJH8H73lnLXMJh7McZ1O67/ymv3sRdUai2TQWhU3TMFlhn3W4o84zMZMV8XH4qz0c82QtqfI/GIqNSIeBEsrOGE8JJrTCQqfj8akuxcdG68maAB9wErS60BElEBmgfC4VOBU5pcrh5ZDScGua/ZPUX7A5AVeBDEjH1gpx75LAIXVPdO0FhCHnxR3tJk1yl5s/OjLOzfbJQWyvLmndNG55e2O94k3C97kZpsVZ8MO7ntSBrr0VUlJckLtcak3nSOvhObVa7jog0SxNHdC+c1yDtQ9GbutJVXwpOcZVDWNcX/PHgDWCKla7iLui3W2DjuVQEV4GGAOEI8cWas/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdAcA5/L83pXd6EuqlBUYyBKbi8AXilyiiNWm8Q4Rfk=;
 b=jLho93CtuGdTxATD/HYGDZysfoLKF3ycbQkHGxfvfWm1PDDNryK79bBFK02LngMatJ2EuaIfMX4CGYVxCYKQObCLpkwmFgzQ13gEiuL3e8b7j1jC/lN8EqyQLjkP8P+mQaNHGMJRg0MqET+1MwOmRAfrBSTzZvypQEDjuxMLY9nRoByo6lPpnXIGy/3biQwg5d5hnqmqksjk9GcTUgcrIciOeduJuAfWE3XCKkcH8KviOlkXKUsvO6vOtri6aBOnDxQOPSEDytTMD4jG8lDWLtt8Ke8Pw4Ru9MUUfUtjrPSuHLrM24CqMoHN0Ihpy1v5aYXyBTsniicz6pfqlphk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdAcA5/L83pXd6EuqlBUYyBKbi8AXilyiiNWm8Q4Rfk=;
 b=kWT2MM66W1fCaoDMXAzj/7QLbK+BhVhAnZhKjJST1fe41P667JlXPYAmv99/wthu2g9Ou8f0WxDxewQxhAFAzrrqyg1K3gGBjsH1yzX2cI+kt8/vSMl92Kt8c+RVFEzVy/gqi+DwTreIc8nuWRfWBh1H5zZo+Hq6rL/8OTeMLOZjHkjlJWVwKjXgTxm2C8c7zSJoaRN1J0Mzd3aWxwzDoEMEF/Ff36q5HljdSLCCIw97hf1+mxeCuFNIncOGzrBNqPIFZljfEPGMK21EhFyQT7Vf3AM9rke8Z96KUMurLlOa/RG/Wl8Q5rqkXEBZlQrLuZ8LT59ZutKPYMFjFi9BJQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 13:39:09 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:39:09 +0000
Date: Wed, 1 Jul 2026 16:38:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 00/10] net: fib_rules: RTNL-less RTM_NEWRULE
 and RTM_DELRULE.
Message-ID: <20260701133858.GA1439085@shredder>
References: <20260629181226.1929658-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e5b213-af92-403d-8417-08ded77620a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pYJfjE+vkN8cTnRT5joxO55et472CL+X89Hp62Rn3EQCk4q4BrsEG+qi66Vz7gz1xcbph390+EQuWwCmyUP8dGvHbMFcrYIRu/NB1dt8uQPoH/jVJvcaMwYHwx/+y6TCR+xNsSsRxFQcAOeTeK3Sl5fyRRqZkeqkhzDH31bko20BaVFi2GdfPNysPI2rgTnLYt3HHkoHQ1QXblcJLrDQgo/A0tUNJcMwHRiAGMfHvxD44xWucejRgkN0Ya9OyQCXQH2rmqeUrAvW7eKNPaE1aOR3TMVG5Nqy0ohbRKG9edpl1c1/WwjEVN+2XsYtgc9tXK90THmRLugcyzJSFnlN8N1NuIWYZRajynPXI03kA3To4b5nrupPZ9irS0AtGNyToO26NP8wN1GjilfoA8FZptedJmJnknEGhPpCvoRb4TDHe3q5IDJSUWdx7nTkBTa6ORd++cTAuUrfRONoNLJVBQE4RUgnzXRsofjKsvYuKgaq/SJp4BriY+4V4eD+OgvXyhD64E/Pb5ZUDcrBMJ2WbLGelOhesqu0oEEmpTHoo54qqREDJtZKmCbkWO90c675c57ms+74F8ZaZWBPZ6JA/TPumN3vfcuChlN6hGtU7+HKKBROY+JVqiCA8nwaz2wbqe2KgVgoEYRyCXT7ALTuTkIPrc3Z4dx/Gg18RIu+DOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMOohXv1Ea+D6i1g3PgZ4ND9ygaX+iUgxPxNV1cbiaPHeiRe71xPi6chKg5V?=
 =?us-ascii?Q?zwz2J+i13dQmEwuhqrNjNDADzBmpXnA3uWI/FRXfMWrhvB11824gOZPxmNae?=
 =?us-ascii?Q?gZzPQY6WjxqOlw0vxxdyNTxlEtu1uvvZl3k8VPdWPlkdEUMOpYoYimXfDJAu?=
 =?us-ascii?Q?Xtvr08sLjwUTA1rxjN9fVwNoEpD9Zkh5KCC2tJbvFV1tBvls5+btokmJba44?=
 =?us-ascii?Q?PhblF1i3oDo/MyohIq8wID/6XZHWxkQ5ZLgslT13UMALcwY/4SfgtU1R4Io1?=
 =?us-ascii?Q?+h/1qywe8idV5ISJ38kiLDkN2AP3q494aITv49Z2yWX4YYMfbVc4liW5S9zh?=
 =?us-ascii?Q?ZDTgbW02oDmt0K+3RYFZE2B1kaKcx30MKhizMqwes/+El4/kTVSb1GnY7elp?=
 =?us-ascii?Q?ItrXeBx0nOwuViwWgoRUwRoW5Aqvo3WZmIKjpTWNaHXIkLf8CihvAKW7GMwy?=
 =?us-ascii?Q?6LU4LIXTgTy4CTyluVlUnjeaSZt2hypaF0/ryXLrfnJvHqLE/DMZuBDDQYje?=
 =?us-ascii?Q?L6Hvi4DS3pqAsWxU5kVPsDq6ak8XR/Ixml5yRFhIzBeLoSaeWbnNwXJgPcIM?=
 =?us-ascii?Q?1nYtpjGCV6sdlRPW6WFfeiNsjZx7LJBli9INnfcfAYlIyjNST5ytXCycsdX3?=
 =?us-ascii?Q?2z3lNE7HEyfoPKviFqecNbUWaZToDoYi69vlHq3Y4mBnK2G54RPG3yZDmJJX?=
 =?us-ascii?Q?WkdWbKm4otk+dpJMVDTQ6Hh++EIfBTsCgAANXN4o+10OF8C1SwgP2hpVuUkH?=
 =?us-ascii?Q?42134a+PwlxcyTb2SAV/tjrOclK0jBn32dI6RC+0oQKFmwltNcwoUSkZREkw?=
 =?us-ascii?Q?Ukqj9KOP+Z5Su2R2OkvqpWCPDnwWbR3UJoQiw9DNRHQamxUcQyLaUVBxmQkr?=
 =?us-ascii?Q?3vHS0ASBJaHAtSBOXx0wPj7w6yWrvB28ZjW/xMrAZ/+nkAA+RNsfKbZKM2E/?=
 =?us-ascii?Q?0Nqc9E0Jk/MmkkFfeuLg7ZkXL9IvlIKcMEz9Oby/Dcu78qrTQq8J+r6/yF7Y?=
 =?us-ascii?Q?ylepVPYhNdqVqX1FGwzGdzNV0eBQIFSMpeUpCRUTTthi3DowzuPpRTST/pUo?=
 =?us-ascii?Q?RPw21dG0t1cSXKiy4LrLTPrKp9sq6by+1cl00EJoPiPVbugwDOP5UPG2OxEj?=
 =?us-ascii?Q?xrq86a+CncRiJoR/G6oK+GDVMavGHVR8vCwRzkjXamNc13lB7aRtmlhZHm9h?=
 =?us-ascii?Q?nRoOOZNdrWOiI/7KzzPhV2dWnD/SEFEKvI1BRM3kKR8abcQL9HWQxTFvh4gK?=
 =?us-ascii?Q?LnjG8T3sznN/rFKCswgbEEWx18IqmQqRBAYfyhnoHAIDmIJbgbJ0TXezhers?=
 =?us-ascii?Q?6CbFLokDJ/kUxkDA13k3UTh1D8igW6e4G6O2JmQomx1XqOknFEmcEI5wVApN?=
 =?us-ascii?Q?1LAKXVyJbRBa0yvKLOyMsblhW63yLVVk0Oan9Zq/wXZTIdJG8M+vgM+SynOM?=
 =?us-ascii?Q?dVl+g/auaBEiT/BQG7nKQGrjm2Q4Wxl+rkghe/t+NMPy01K2iX2rPgksL7V4?=
 =?us-ascii?Q?Z07sgXKPAqSUV8RrqPz05m5kH8l03kHAFe7Euq4Y/GLGv3p8Xb9l5Y4BAUR8?=
 =?us-ascii?Q?mu5tuL+q6qhg1YFMbvv2k5HTVDQcAZtY9BvgudxTLz4aHqZKthQxaZ/4ELPD?=
 =?us-ascii?Q?i3Gv6xHyq2jiJ0cOabkfGdRTGDgxqEhleJ9+yr9yf2JokPrKugTazjPAbtMX?=
 =?us-ascii?Q?+/6I6rQlD+ep11ZE0aoJMmpaEmYpJu0xKBpuEoM4Vz1QxKz2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e5b213-af92-403d-8417-08ded77620a5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 13:39:09.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NE3chI6R9cVEcsQMQoAnw7rG4aCtlTxyuCM62bWQgAYHpXkMP82uvvSSS1KeaDxaGlti00ymPKRhx8NanHUw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303679-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:from_mime,nvidia.com:email,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9442C6EE383

On Mon, Jun 29, 2026 at 06:10:52PM +0000, Kuniyuki Iwashima wrote:
> RTM_NEWRULE and RTM_DELRULE acquire rtnl_net_lock(), but this is
> only for fib_unmerge() in IPv4.
> 
> Since commit d954a67a7dfa ("ipv4: fib_rule: Move fib4_rules_exit()
> to ->exit()."), RTM_DELRULE no longer needs RTNL.
> 
> fib_unmerge() is one-time event for each netns, so we only need
> RTNL for the first IPv4 rule.
> 
> This series introduces per-fib_rules_ops mutex and drops RTNL
> from fib_rules code except for the first IPv4 RTM_NEWRULE.

LGTM, thanks:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

A few nits that can be addressed in a follow-up:

1. Patch #3:

The comment at the top of netns_ipv4 suggests that we should document
the new lock in
Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst

Related: Did you consider moving this lock under
CONFIG_IP_MULTIPLE_TABLES?

2. Patch #5:

Sashiko suggests a mutex_destroy() in fib_rules_unregister():

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260629181226.1929658-1-kuniyu%40google.com?part=5

