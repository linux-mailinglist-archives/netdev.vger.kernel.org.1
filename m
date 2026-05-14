Return-Path: <netdev+bounces-287841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMleJaZuBWrkWwIAu9opvQ
	(envelope-from <netdev+bounces-287841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:41:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73A53E6F5
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80C13301AEF3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47503D1A9F;
	Thu, 14 May 2026 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kQKDxVyM"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4473D171D;
	Thu, 14 May 2026 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740898; cv=fail; b=ezhAZMjcj+vodf+UC27wTlpijKrG5giomHUC+dw3uamMXd2OXRbcVhMl0ZzDwzXbLrU9O61SHGSdol61pXPAi5WLDTIo46kzbdhvs7FPactN16zIJNnUS43tECZTsntZNkDW/jOEZ5F63QKpAY0pEzbxoiImN4onO8jVCNbuanY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740898; c=relaxed/simple;
	bh=1qDu0xtIuYL5VFyRj/XROLBJW2wT/ESyzwnxmWr2hL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mM1vnTW42gW7AnxQDcINzxbLuLlz3fwhVyJUZhNVkLK/Emh51Zcu7YQ6nBaUu5kkEBc4ZdoN/TPJXFlRgdWc3yELRKFRkHVYf3MPFNPTRN0bqAP13vZZtaaRwOtim7ykzbrDabfV9YnVTfgBBd70XaZfif3zJlV8m6BapxAK+30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kQKDxVyM; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR/hlRqSX/MA9xpPzCgV3kR0Pi9X8Dlf8yVDuMYBmXW5UiS59lUHhmJrXTgE19XutNsKNR1c2KAgeHGHXmKAQCwgZTmSGSQgQ5GcylpzXKOXNGzLrVmxcp+YSXMgY2dl/EBbF1cG/aJDguitRviBNd6g1tN9eLux6ECroaPhb4UIeQoidyjbYj8OrTz+2G4SpW6mubUkdEE6IsTBgQDc8vUrHrRGzudhuDEd9rM9QwjPaVkEpbVLw2HyUiHpEvQsiFC9UZlyJKbENyx1Vs1dxahqv2RV+IhwcK/dPUA/AvJah5YCnm73KnPNVTl5Vw+G7EoY1nasxIX5JwZuM+Xlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVDW/20nLzYf3FU1VmAHpeCT/14qT4QeZQFSG+/KkEA=;
 b=qC6Ccl+jeTz2/huYLidV3m02FCLXSBJPx7DtbMQ1rS4+SRaI0DyebQpZyWjjAubnJ9WtrtIB6K4cbm1T4BrNbHwtCklsChCM1N7tyteV17g8kHdnwIgY1U/uv7GFv9FfFzO3Ak8Ec5OhaxcKwkWqJj6CO+JJH29JLxZs/GYqgbVjsvNlWqCqqIAaz9fjyGoklX1gO65lbrkv/p55jPJSufVwErIUlXqhloGyxzCVFbMtaQGVNn7Q2eORm2vmY5/6GNak69tqLpLgu2WoaaIoHJsc0OFuf/X7Ui4AuhV/Bcc53TpnXXHs0EecXdJ95bZ6SK8Q9StNdYDTkOIuTXeJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVDW/20nLzYf3FU1VmAHpeCT/14qT4QeZQFSG+/KkEA=;
 b=kQKDxVyMUtJ3+q6ThblLVRFXMlkytFqc09LzWPIln4ePs97Rhj/wYWp/3kTmR66POtOInyuq5oEEGzCDljBk7ZGLI/sX3o3E1v4aqBaoGrjelJSTMUTUD427idnTfOEu7oo/UVR8XmILemmnnhCANouJfyLiNG4VOT+q5TiKvPIzQ7AZtKj9f5uAFZRRyuNmNIPoGIGJXZKcizgGouU2ajyMoSFI5qB5EZgi6Wdq3hB/TtVnPaJ6iF/PiAdcnzgDJj0jTnk6LEss4lZC36jayBPqZwEc5R8C5p3XgWCtjCalv74gyZ1fy7gK/6DUGCVYVSdLuAfT7POivUn8+Swrww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 14 May
 2026 06:41:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 06:41:30 +0000
Date: Thu, 14 May 2026 09:41:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	stephen@networkplumber.org, hannes@stressinduktion.org,
	sd@queasysnail.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5] ipv6: addrconf: bail out of dad_failure when
 state is no longer POSTDAD
Message-ID: <20260514064118.GA451826@shredder>
References: <20260513025509.3776405-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513025509.3776405-1-lilinmao@kylinos.cn>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: ba66433b-b1af-4f06-9cd8-08deb183d4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	YX+pLUGinuaKMO1vH55rVxWwZ/xUXdrY4IuMHH3M5TwQ17LleShkIFtqOt5zxl2qEquPnh1W8zDt/t8nzfMNo7xGWp5x9mKodpi65jARH6WvFdA3yJjy3LGf5N2YouBzMpLoJybNx2w1KvagANKSsnrIBCOkhjXEOiEzZrIeHpzGwdMj+/fn7yakmkaVBAaDdjldAFkgovPr28hPQStCMvZ6gACI5bfvItRdd0hfJWu2/V0k6KGs6OgKC/I5unL5oEloYFOWvK6XAv2CSyQ3klY9LB9h/1QZcxk2DZnVHBeUWIA3rRj8LubUJzLwOewZsWrC2trf0jf8Kn3iqU09ZWBaNOM352MbM211vZCvfvFuI/xhqemex7uK55FJe2wOBF50vzRibQA1DRWKM4IOpUP4inDB8q6oh9XTwcyyIX11uSTvqzweuopuXzTFPYBcspKW9k130+34L2GplFnfWUxjorkOYou5/XLW7zMCz85Pl9jC776iiVuiuXyWXbrdow3YOgzBQK+hvHa6FZDXyvlKMFv5KbxYVX8dbC0IFCYL0+Vbb2l/rPVNIvNLZe/f04NElPttqPjRIcYQBzklT7PTlDW6qjSA149l5FGmRqMiVXDowHKz0DL6uLz3H/Gy5lgqdrte+KxWppOwoSGm3VQ4HgPqQ59va7033I+1E0b4rIBvxYvR9WagWCuyVfwm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DBAbiUrs53DVVsPVyfZdrFXaq9cr5AATbHF9r6k4sA5EmTwEfxbMmoAtA19J?=
 =?us-ascii?Q?X9jdHsGgflyq4NdkQqjtE78jZcTOv5ZNtUrr3fTOmG3opjaE2dNr+yTF8biS?=
 =?us-ascii?Q?eduT2rBqzF/ACvvW/VWHr1tmXyBPaiWjJ8r9NoOXVemYcfBupkkxTU3Qo1GQ?=
 =?us-ascii?Q?2ilD7z6qeu+D2QAdRcsRCRZ6Z1tZWD0OLHR/qxfH+1AHKbDHVOmUnuiVM7aw?=
 =?us-ascii?Q?uyZLEgXlpo6PSqqCeN6F2Kx7p4UrIXdB4sEIVWlCHE/JsaqYnnPy21D0PnvR?=
 =?us-ascii?Q?C9PjRLDGFqQfMwQex3LRcpwgPi2dqu1nsVtKl9KxhHmPBHYvxFyke5BFY90U?=
 =?us-ascii?Q?IupHSxYU6HFFH93X+kI5BDSjOA8xhho4IA9CI6Jfty8IDOm/znFS9Z3qbJiJ?=
 =?us-ascii?Q?JcmZKEWMvIeUSAJCU7Azh6uISIJdLnO/r2C2zYaYZ0ji9phr5LA1ZFL8iqvv?=
 =?us-ascii?Q?jTiukIcHph2ZzalvB19P/8WrDkvFAQwn3r1l3OacKwCTajBg8EK6KO1GirI+?=
 =?us-ascii?Q?ickqFfKby7gvfNbdqjFpd5EK5O5cCPIgQPWrcCFnE1buifHHPGxdCBhgKePs?=
 =?us-ascii?Q?BhIkRm3epvxO/eHsTQxxZLsMsRoCJBJ1vmwkiXC1HbkRIfO7C7ibCE/QcAhe?=
 =?us-ascii?Q?1iQOFkFesteukZrfBnC4MUvSAgHqGTCuseFXzAX1rkZdu+NdZUZXWsmoWegO?=
 =?us-ascii?Q?lKjPhy6mHpxPNhcxxybo4EYcu2JHHn7+wfEUdyxnCyk4z6HOClEA5GGMWf2q?=
 =?us-ascii?Q?6RoruqbSO3xQoH6F2pdiZMDsoLiHuuQxFs1tT6rqA6w0X/Kbdq5ny0tgUoHH?=
 =?us-ascii?Q?3gusIREeM3FrIe7AFesER/4hfErSsfNRZPZWZmuhT2Q1NcKvvnP7KYkELiTj?=
 =?us-ascii?Q?E7SQQQImo4mfNnMkU8AIuuUTuXIuCYB0JnAdCYlZtAXE30V5455fn+uipiFx?=
 =?us-ascii?Q?6atA2nG35IgvCtkuhk1QNxbZdO0E5VdMey44B8Gwmpgz4J0hOX3iHrIgF1eZ?=
 =?us-ascii?Q?y6zC7snLjIA716vG/GF+LCDohn5HgFQjkWdBqmU6ak3Ca27Cp4U9RYGX9smb?=
 =?us-ascii?Q?Gli+uUmbIF8byEe6MIDzBVua+Uw4PsTcOKR6Y4uJQAkQ1Hp83hmHcafdx7Hb?=
 =?us-ascii?Q?LpTn1GRjTCiKXdZ+GNNfARPH0Ra7s6LD3tw5XZDUat0mpuRYVE29t6pfx42g?=
 =?us-ascii?Q?J7UBfRa15pWldB+3cx6l9KLGy3wlutHz/zkB/l3noPiYTiYRxX0Q+UdloSu/?=
 =?us-ascii?Q?RFBeHCNKCgaWsqLwy3accX2Z2O8IhetvHJ7XskmqDqcbExju8NxuVu6ScXeg?=
 =?us-ascii?Q?5Cynqe9IMPu6+BC7tr9JsiWBTbt5vzZehPLA2gmSHW7Vw8Cc53QqTVrZfnDR?=
 =?us-ascii?Q?0F4iY2OUXuLp2ipUVUyNOfqiE3mnOWcBlb2CQ19gkH+KyUzGw0OaVFjqXVkP?=
 =?us-ascii?Q?qbWTeLWkjPEWJHOQus0YHoHaShNJn1ClsTapFHW1+zdIJH5naK+1dN4qWIDe?=
 =?us-ascii?Q?8UY0Eqi2xg0o8diU+d01Nqn28n9TJ3YVBysDdCDyY5whaRBDSJOeTYIep19C?=
 =?us-ascii?Q?3nrGzLPLYeDa9BRHi8tkD44EzFpvfX8776sGhmCAnCblbG0jVl37JqL1T1kJ?=
 =?us-ascii?Q?JYgilozwyN7WuaJl9tSd7OBWv3yaJAiDtAX6QIw0rNKy/d2p2ahPsMw7fS7b?=
 =?us-ascii?Q?OMxe0YccQbhJ7p1BHCa1MPAYCfZ9VYAcUuflcjMnrON0iM0d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba66433b-b1af-4f06-9cd8-08deb183d4bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:41:30.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6U8DYMPmnCau0anZgOvelZvj0t9/VmWrI3mct+1n0kNXzxholLigZhNDs28gskoR86LFazB5GPPRsi1NtfLVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
X-Rspamd-Queue-Id: 3C73A53E6F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287841-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim,kylinos.cn:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:55:09AM +0800, Linmao Li wrote:
> addrconf_dad_failure() transitions ifp->state from DAD to POSTDAD
> via addrconf_dad_end(), which drops ifp->lock on return.  The lock
> is re-acquired after net_info_ratelimited().  A concurrent
> ipv6_del_addr() can take the lock in that window, set ifp->state
> to DEAD and run list_del_rcu(&ifp->if_list).
> 
> addrconf_dad_failure() then overwrites DEAD with ERRDAD at errdad:
> and schedules a new dad_work.  The work calls ipv6_del_addr()
> again, hitting the already-poisoned list entry:
> 
>   general protection fault: 0000 [#1] SMP NOPTI
>   CPU: 4 PID: 217 Comm: kworker/4:1
>   Workqueue: ipv6_addrconf addrconf_dad_work
>   RIP: 0010:ipv6_del_addr+0xe9/0x280
>   RAX: dead000000000122
>   Call Trace:
>    addrconf_dad_stop+0x113/0x140
>    addrconf_dad_work+0x28c/0x430
>    process_one_work+0x1eb/0x3b0
>    worker_thread+0x4d/0x400
>    kthread+0x104/0x140
>    ret_from_fork+0x35/0x40
> 
> Fold the addrconf_dad_end() logic into addrconf_dad_failure() under
> a single ifp->lock critical section.  The STABLE_PRIVACY branch
> temporarily drops ifp->lock around address regeneration, so at
> lock_errdad: verify the state is still POSTDAD before transitioning
> to ERRDAD; bail out otherwise to avoid overwriting a state set by
> another path while the lock was released.
> 
> Fixes: c15b1ccadb32 ("ipv6: move DAD and addrconf_verify processing to workqueue")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

