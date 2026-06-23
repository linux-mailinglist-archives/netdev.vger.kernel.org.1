Return-Path: <netdev+bounces-301395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C3/DIN+eOmqRBwgAu9opvQ
	(envelope-from <netdev+bounces-301395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D636B818A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:57:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=oKY7gtSu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301395-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301395-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B4E5306961C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81C03D565F;
	Tue, 23 Jun 2026 14:54:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621853D45C8;
	Tue, 23 Jun 2026 14:54:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226481; cv=fail; b=FlO3o1hrDcAdYoQ3a4jeAl6wAhyqPcuWPBttZl1LaEIiYjSgkBeZnImT4JewGbRFjd8N4F9aZHRAO9C9IC7Md6G9pwaTD+psjsg/ppmVfcYIk7587oR8ep2Cws3uNu0czNls4ml7pB0zoFrQDpG91wifa1XBwmgUY8VkiPCUhRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226481; c=relaxed/simple;
	bh=XDnnyMmFAZXif041sojrP//jNiaI9YY7TFdeboTY2AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HXXRLbny2QAwkVS+jyF941VFgV41D2w+xiSfreoRjfiXLSbLqtQv9RmvtwREr9XWj5OOV4A5jsV61yjK0Nz/FUM8yfT1eF3DPQJoShTK/bSYwGdpqKmtNwq/je0kBc33Avdvk5eUAtGw0de9XnbODKzKctZfvG72Gua7g/+Y8MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oKY7gtSu; arc=fail smtp.client-ip=52.101.52.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Roj3nEDQyvJ+PH0lLLCy6JLs1MErqjPQWArU16eUq12jsedE6II48TfMB2l+zTE3PPtzUq4zMyt/TMW4Gab2HaZVX/Xuttakw5ce08WjWN43Wohr+kB6PsBAGm7ncrXY+irKJLu/L4HeiKK0v6HxstknKpC6Fy54Pa0sHcW2ii74zFB0UT06NylB1haywRkkbKGgBUOsfs8JDfCmVIeU6lVAhmyGuFa84Jyfb50Oyzjms0xBDfRdnI5w2AilzlyDX7+3tJ1ejZbLrALG6kE93/GhxR3szQ4VBtDrlZLe7QHzIJ0yzZ9IdtvS//i6fsnGmnioaxfHU2wphh9PRfxhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+8iecGhQzoIj5t6tLhatrOxfyJ/pVo1hjKtVQsG0LM=;
 b=LPNGtd6BGuojhXpDQnqVbdfqUGwrzLfo0u8g+HRDZRAYQzm3seogE9xp+GM9Nat7j8xM5Cui2disE/Vsch16+4ZEr2QP91vy8DpRW7v9ly4IoSOqclntpN/YE2bnu9lxqH+iLZEVUFe1w4KiPCQZhpfwH0c06wv7GOwzdqAnH4f4azmiYn7aGSUeFZo5xmrSblHc6sXJomH2MSkikXbb2v9TWohfoIUnDSfaMaaRpuVy1ZW3bqCyHIUICYIO5nKqZpp4vbWFP5d5lrz2iNv/o3bRkiZd22zRq3lccSNYn/XPbOOYipp8D66/6oqHGQYpVuTL+hkCEPwyyY0Ct8nZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+8iecGhQzoIj5t6tLhatrOxfyJ/pVo1hjKtVQsG0LM=;
 b=oKY7gtSuWq8oWa4AgaNQ56CggaI6ywme6FPDmOToNUMWu8FAilBkEqtwBeMY9OXik1Gr6QV/e1cbHFz873Y46sllSKpMjDvlD4If+4hPe2ESe04Qc3DZ4J+fWp/46bDnY237LZJOE4yseyV5vsB1aLuHuGnF8tPYHftStOgCqbY=
Received: from CY5PR22CA0015.namprd22.prod.outlook.com (2603:10b6:930:16::7)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 14:54:31 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::54) by CY5PR22CA0015.outlook.office365.com
 (2603:10b6:930:16::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Tue,
 23 Jun 2026 14:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 23 Jun 2026 14:54:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 09:54:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 09:54:11 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 09:54:03 -0500
Message-ID: <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
Date: Tue, 23 Jun 2026 20:24:02 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Andrea Righi
	<arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann
	<arnd@arndb.de>, Ben Segall <bsegall@google.com>, Breno Leitao
	<leitao@debian.org>, Changwoo Min <changwoo@igalia.com>, David Vernet
	<void@manifault.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Eric
 Dumazet" <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, John Ogness <john.ogness@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Vincent
 Guittot <vincent.guittot@linaro.org>, Vlad Poenaru <vlad.wing@gmail.com>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260623142650.265721-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7668dd-d54b-4a93-e9fc-08ded13754bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|56012099006|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ZPz9aVzKbCTuCvLe5gWSrgbuicR2gHz04gzsFH9vh+2LiWob9GxqhGSORbCrUX+KtSk9JSro5AvO4F0KhREk1+i6oEXCxlBizslvbrXI49nFYGmJlnqtQO69jtRkDUcqnbtSIwJ0f1mpgkfg4tcuPH1PPkvNRfDGSTGcuBLknP0khIgCmch30SLFRTq6thLzWA+h+y3eDqoOT9zyetrDx+rqlPRN73wTtyKhQwW/yyS4n08JsE3obKNvswzXz5FdNYBCly/EvutFRZNncZUxhoCp5jbVQYq2rpYib15sPMk/PhQREeE8jvIT9bB5IHkLD0OUkasurDHWZCIuFcqeY1k+7ba2bEPO2ghCFN3dFqDzUvgbYNT2wbTAb6txdTsy080uHUD1dNfjIkYO7RhycAiFt3t+BheLiXrxj0Gteh/RrQL7iwUXBkXcHRuD9cizGg6jTamEic2ImoUXppE7Wl4AdthvQpFgeablJNwwP20y58aqZq84sLMnPmMlrjue1W3jG4XTF72EqFYkXiJ5uyp2aCyUnnzqZe/FinipiNt1iCzKxISYzHszoHBk4CXXcNSlCKwO0AuaLnPhT/77OdAdXyKQZYmcIA3C1dcAGXl7emfEPvZBBNsyUbby6Xmm6VIL5ILSGuYhs6KXFRD8ZuH1W50QRXMDg46mbqYjFOfvyXdD4srOeP7LgfWkkAQu0GcDPjrD5jt1eFQbIn1Aqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iAimVviLFSTUUM6bzBbdWHeOy53GiYaHPWcTeN7XJGOsh5BLqyqm8xL2g1nKBkqtdV1rxE3lUcSk+aAYAN0W/tW+7HcwN3//P+PzdeyIKbRoC2tJ8mZSTd1XUBTZLO5WHlGmJAXh3tSQai11boHoqZU+rMyl5cpq3dmE+IFecL3aaKeQ4N8bAsrr9lxkVmJDMHjIlGhivBFNYSqEbV3MezgauxOznxhYXXcAiGo3HybXK5aCm8mZc9VJOMatswQ05ivsmx94kc+4MJ8IypBzXCv18K8eZbtHpP6gsLjILh/hKAbvEH5b8gzh8uwPqlZaq6VP+r13Nl6ubihPyF8sEhHnsauGr4wsxgnLE/vhBYRbAgd8MWqaQahtWlePxSDpijopJCedJoWlt8jyFRY2cWpbBFctz8231VzF4HBiDC11ELF6Zb9C5LvazBmzdutf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:54:30.7596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7668dd-d54b-4a93-e9fc-08ded13754bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301395-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[kprateek.nayak@amd.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:pmladek@suse.com,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,infradead.org,suse.com,chromium.org,goodmis.org,linaro.org,gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05D636B818A

Hello Sebastian,

On 6/23/2026 7:56 PM, Sebastian Andrzej Siewior wrote:
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -196,7 +196,7 @@ void __warn_printf(const char *fmt, struct pt_regs *regs)
>  
>  static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long bugaddr, struct pt_regs *regs)
>  {
> -	bool warning, once, done, no_cut, has_args;
> +	bool warning, once, done, no_cut, has_args, deferred;
>  	const char *file, *fmt;
>  	unsigned line;
>  
> @@ -219,6 +219,7 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>  	done     = bug->flags & BUGFLAG_DONE;
>  	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
>  	has_args = bug->flags & BUGFLAG_ARGS;
> +	deferred = bug->flags & BUGFLAG_DEFERRED;
>  
>  	if (warning && once) {
>  		if (done)
> @@ -229,7 +230,10 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>  		 */
>  		bug->flags |= BUGFLAG_DONE;
>  	}
> -
> +	if (deferred) {
> +		preempt_disable_notrace();
> +		printk_deferred_enter();
> +	}
>  	/*
>  	 * BUG() and WARN_ON() families don't print a custom debug message
>  	 * before triggering the exception handler, so we must add the
> @@ -245,6 +249,10 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>  		/* this is a WARN_ON rather than BUG/BUG_ON */
>  		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,
>  		       NULL);
> +		if (deferred) {
> +			printk_deferred_exit();
> +			preempt_enable_notrace();
> +		}
>  		return BUG_TRAP_TYPE_WARN;

nit.

Instead of replicating these bits, can we replace that return with a
"goto out" ...

>  	}
>  
> @@ -254,6 +262,10 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>  		pr_crit("kernel BUG at %pB [verbose debug info unavailable]\n",
>  			(void *)bugaddr);
>  

out:

> +	if (deferred) {
> +		printk_deferred_exit();
> +		preempt_enable_notrace();
> +	}
>  	return BUG_TRAP_TYPE_BUG;

... and replace this return with a:

    return (warning) ? BUG_TRAP_TYPE_WARN : BUG_TRAP_TYPE_BUG;

Looks a tab bit cleaner to my eyes. Thoughts?

>  }
>  

-- 
Thanks and Regards,
Prateek


