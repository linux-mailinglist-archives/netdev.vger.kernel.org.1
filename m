Return-Path: <netdev+bounces-269553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N52EV0pvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:50:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF32CF229
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09D1308E5D7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E915E97;
	Thu, 19 Mar 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M6KfFzBY"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF313DE431
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938658; cv=fail; b=PlJi3dozO5zya9tuMXYO5ti9lKBWPNNxqSLRZQWCTOy1SOmrMj0kUAJEtWYhmqrdSc/9UxcslL0zq1Y0fWVnyIi2E/qGll89pDhyVBGb8+SaaYvT1qrw283xxoQFal0ZT2t05tK7IqRY39ITX+JgMSRSmNpldC0t7yhwR3sQeNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938658; c=relaxed/simple;
	bh=NGccjrU0tQ/VYgujaZ+Dr3cXIkl8HEidXaUauZ+Vbe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDFc4i3mAXAdbt4CxZQhfRfElYtnkO1Aw2JQJAfyzncnXgqKe9mJlqxTacWAFhdLipuLAwStigA+VIfhVO2KF51hO02o/PBioa8NaEabdxO2m//gbM8yZjaqV81m1p/JetV8ZdPJo+UWj42NWW7Z3cINJk1f6q7d4Y1bSoTQ448=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M6KfFzBY; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+qnl2uKUGg4oIzkYQ0MTHpkZrf/X05MUijLJacdP2jy35Vau3FhVZykrx3NL7NPjgDehWAeuVzOOKANYCh05QN/aWdNwbSxT4JvrDUxWo27laF0Ne1wXENZvvFELkEEKEESpJKldMoJDwRE97Tpdq7FSQ7nx83w/sPe8dekWuBZi4LCFX4pnuOIIa1Xv9BTiais3Ql/WvX2uVtA+kDjg+U+sfAaKJuc/Xkl5wNYPtG61/6VgwWW+2mCqxTu9FUt+H9jUpzXFmstywvKcuGb9es9CZFFlnCLIemMkc4+x91Fbn9l//W+Hbqx24kOChN13AdYqBcdPLxAA5SciKzj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV6LMCD6ZGkwK0YYw8OdM0RiLOthqWuMWCWVOTnluEE=;
 b=Nw7dvWWUGWYS7SA3u/dqv81zWMb9dLjGgAJ+OrKn23EuP/6VzENHFeShXRlme2zQtm/Xmy6Lg4n2/vWSR2AicoOA4O4NYFBT8xY5QkEAfLqYNcgFRH3buki9BZjXHM8WmhiABGV2qSJDF6Rm2HkhqIvB+e4Rl5Qpb/0y4p0e0nzB0hZzlxZoIRbW6+Lshn9f1tDp72OBnWFlR6TpUghNkggSl/YFKplNBwugXV+EY1w7VLlO948Z/hqWiUsXk3ecvMlC2hqGjArFU46uQe0AN8UUwpvaVJiR494DrPoCD8Mu2nYIBeXUaC+JYwPenE7XibtU2EdWO7+SFHl8kgMLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV6LMCD6ZGkwK0YYw8OdM0RiLOthqWuMWCWVOTnluEE=;
 b=M6KfFzBYvm7mUsE/UTCh8G0ZE+TOZ0gKDRSNyDwQeJluL68hOP/FIiwU6nDQ0JtaFaW9dhrRmCBhoobG84E17W7UzoHnbp0wdhlYFIztzERCGaGQ/fGmCJgVeovKpufOE+iX19VAUt7oM2CXVD7fDq0CGPH8X7nGervrqeC6fA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 16:44:08 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 16:44:08 +0000
Message-ID: <8f257e83-671d-42fe-abc4-9bd151d56161@amd.com>
Date: Thu, 19 Mar 2026 09:44:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: fix persistent MAC address override on PF
To: mheib@redhat.com, netdev@vger.kernel.org
Cc: mohamed@pensando.io, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sln@onemain.com
References: <20260317170806.35390-1-mheib@redhat.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260317170806.35390-1-mheib@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e9af6a-7456-445f-5667-08de85d6bd8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	oDb0l1CSOOUFeKbUNKM+ciPYbVCukPqcEzoChLhSs7zr7nk5zWT1zGCfXtlslug/Rhw0j+JFCTsETEbWqlLj8YQFTVr3/Ho3zxgig16HZzRB9BLcz7do7NkQOIQTKUbR9kUfdsWlOXf8NoiVH3jdSCURIg2gfBoRraYmJ8I9IiYFz2JEyXZlTEXTf5BEatq4SqHnLpN1/Vm8jZKb8N9lW5e29p6w+t8d9z1s9dal66ffO4Fe1UWvweFcrpg2KaYI0ITuU5aq4y4j8/esJpejfiBbxiz0zB6JdYVLK5ao+Lbv624JO/eUBxR8LnrkhjwcEfdcQArte0Axd/mhER0xwkQOnt2GDpes3ouXx4bpXrsmv8f8eIaC+45XW4JaLn9CV891JT5IC+vE0jyIqAySRvGcqpwssqlpmskSXsU9SPKjFCXlmK7wA2QaXax+NPaaes4qXmhOdXeIsQMK1Exxa8nX2VgLkodHheeU/gUkHE1Ry4Ie8ZJ5o2Yp4vASe46R9SDqofvMQS49RDke/jKX1HLbS2LDiusW1KNhIRsb5ELEizaC0lFVmn8pUpYMxk44n1WYAzh7lmEZTlSl00qZ8iA7Om44EYWDlfbJIZw38PLTgX3HUVvIvsmWSVBaLtXneF+KUexzkxIzlXMJJBlyCO0c0avEuYeIE2941gdZUGSn5m4TZtV55kdrI916Ah32vRi9+awU7/teVHgMV/iFal+7LGoJHp96qUioRicd3c8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0Y5SWpuWWRoZW02bE9BaWJYRjhpeVhtdHNVWFB1NklHaitZa08rVlF4NFBi?=
 =?utf-8?B?aDBlTWxUTkdEN2k5cmJBWHlsa01kcWwrU2s0RElXRm1LTXRUZlNvd3JsdE9o?=
 =?utf-8?B?RnI0TW4weHIwTktNbjhrYkdCTEFDNkxHbndFajgvcy91NkJ2bXhUMVFITWQ4?=
 =?utf-8?B?N2EwV0NTMEhsU3pveTMrdUpNVkxOcEtZQkZUemtnUk5yeG9Pc09RelVVSGJk?=
 =?utf-8?B?Uy9POTlnYll1emFRalZzdDBpUVo4Y1IrKzMzUWEzaFBPTFltRHVqT1Rielc5?=
 =?utf-8?B?bTNJNXZsbkU0QXJRVWw3ejBNcWxIT2p5WG80bnU2QVpGblRsU0RGS3BCV2RS?=
 =?utf-8?B?YWZoYUVpenVVOVN5b1dXMitaZXUzSEVxYlQrRStIS29ZTWhnb0x1c3lkMzBY?=
 =?utf-8?B?NWV6V1pTcmtLQlpLQS9VbUdYN2ZxMGNBTzRjeG5pcTZmZzJ3UkRFb0Y4Y29s?=
 =?utf-8?B?QWpSN2Z2OFpqeFJ5NXZIUnVKNGt4QWg2MHhEL2Q1M1NaalFyWGhUNFJxTTVq?=
 =?utf-8?B?NUNaZHhpRVJkSDBDTDdRRVZ4T0l6UElRNEJ6K09sWWtFVnovTEE0RjNacStn?=
 =?utf-8?B?T01FWnVBSkkwcGRndlljbkJnRWQycVQ4RjZnakpyU0x6ZDl4TzhpK3EvcDRI?=
 =?utf-8?B?WDZrdGRvazA3REpTTUh1SmczSmVjWVJWMTFJbkRZeEVFTjU3Q3MwbVZYZFpj?=
 =?utf-8?B?Vll5anRUV3k4NE1KM0t4VStTODVIUWEyemlpWmdOK3JOWWpENzdRYWt4YklH?=
 =?utf-8?B?cDZUZlRCZUdQc1drSjlJbmMwU1V6MEl1N2Q5RVNzMWJSdmErR2l4NENscERP?=
 =?utf-8?B?YWYxYWRHVkNEYUg0dU5KaXN3Z3dOOGlxc0UxQXE3K2FnOXRpUndSL2lTODdT?=
 =?utf-8?B?WHllMGxUUS93R25vTldmemRqTXRtWHpIYTdSeVZrVCtLaERYZi9oU1JpVEFo?=
 =?utf-8?B?SUZmYlhvVGtQajZSci9sYzFoZmcyOTQ0UDlsSHFNNDFaYTVwSjZNbzAxY05s?=
 =?utf-8?B?QzhtZEx1MzZtd0k1REVvM1RBZG9YZWNPNXJ3enI3WGRHY1poRHlZZlg3STA5?=
 =?utf-8?B?OVlKZExGS1U3MFdYamxzcFhCV3JiTUhnbGNpbjJ0SW14Z0l5eHAyNzI5ZE4r?=
 =?utf-8?B?dmNoRkIxMkpzcWJ3ckN5NHBPUnMxemxNRndyQU9GTkpVTVJReHM5YWJQU095?=
 =?utf-8?B?Rnl6YUpnL3ZWZ3ZiemYwODJRcWhLa0Z5eTlWTEM5SmtMekVLM09tRlF1eHlH?=
 =?utf-8?B?TFNjNW0xN3ZQeFBjQUI1TW8rUFUwVmtIV0o4RjdRWUJRc3c1REt4NGo0bzhT?=
 =?utf-8?B?aFd6VDZkRVV4VmtWNlgrZ0d1NExFc1pwcThYMWExTkp0VmQxWmp5UTh6MHVa?=
 =?utf-8?B?SHVoL2N4ZEdDTG5SbkpBRS9UVGc1Y2ZkdFZUMDJlRTFrYW5oR1N5c21GeGNU?=
 =?utf-8?B?dkVjazFzc09ydUpHTElGZkN2bGk1NjI5VTExMzdONmVYUFg4SEIrdXhpT3NC?=
 =?utf-8?B?Rm9WRHo0YnI0cGJhcW9mM0wrU2FRRnBINGFkYkM0TjBmdXJSb0FCd0h3VjVn?=
 =?utf-8?B?clM5Lzhhbmk5NGh4aHk1RmR4N1plMlFybnQwcWJvWW5pZTd0aUtURTMwK0dT?=
 =?utf-8?B?V0pnY1lwWHVwclQ5UkE0cEN5ZU85VHZOMG12R1pPWFFkbVo1eWkzalI0Vzg0?=
 =?utf-8?B?MHFNM284SVdaL2lVYmlSOXJqajgrMGd0RXBSaERuZzdkWUd5RjBhWVRxV1JG?=
 =?utf-8?B?MDI2Ty8yK3JjNHFZd1F1T0UxTExkV0ZRYlp2Y0pMZ0d0b1ROaEhaaDNuVElm?=
 =?utf-8?B?bC9Jc2FweVprdFFzOENqNUlDNHQzSENGa0YxOEtBVWxvYWl1dGYvWlUzYWVH?=
 =?utf-8?B?K2I1S1dNSHBydFJtYU43bUdGMTA3V2tPUG5xeGoza0dmTTY5MWxoejRoclpt?=
 =?utf-8?B?QU5iVlpaQVdyaERlOXI4Z2NxMm1mY3dvc3R5OXI2cXdTUWtudDlmaVhsU0Ew?=
 =?utf-8?B?VENnOTFSQnJGRUJhS3FzeWxMQU96dDhKckpzTm53WE8rVHdsZUhIeHFieWR6?=
 =?utf-8?B?Tkd6QWZMYkNIeW9icGxySFpQYjJVNmk0eE9FQm5JUGsrbFJOYnhtTDJQWEtI?=
 =?utf-8?B?RTFsbVdBT2pINkFnaG1ITTc5bTVEQWRVeDAwTHdWaTd0ZkxLT2hSdCs5OWNL?=
 =?utf-8?B?WkhzRnhHOW5zbk1KWFg2c2xQcE5ZNFlEcCtYbSttSldiQ3h4anc5N1h4VTBU?=
 =?utf-8?B?Z1ZYRnVISVc0VGhjUURZb1JyNjE2Y21KQnllVTlWdkZpWk8yeUZ1TnduNk5h?=
 =?utf-8?B?WkpKYjVaQXdqOGxwdFNvSk5NYjlSQUtmUjBHdzUzNTVhNGFtVHNjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e9af6a-7456-445f-5667-08de85d6bd8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:44:08.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1kg/rALnlpzoqACoAywv9iZ52BNqVAA5CEkMhpouAkly2ex02nBPXppmdyqtZ1zqMqVV4JBCrrJVYdIgVQPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-269553-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: DBDF32CF229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 10:08 AM, mheib@redhat.com wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> From: Mohammad Heib <mheib@redhat.com>
>
> The use of IONIC_CMD_LIF_SETATTR in the MAC address update path causes
> the ionic firmware to update the LIF's identity in its persistent state.
> Since the firmware state is maintained across host warm boots and driver
> reloads, any MAC change on the Physical Function (PF) becomes "sticky.
>
> This is problematic because it causes ethtool -P to report the
> user-configured MAC as the permanent factory address, which breaks
> system management tools that rely on a stable hardware identity.
>
> While Virtual Functions (VFs) need this hardware-level programming to
> properly handle MAC assignments in guest environments, the PF should
> maintain standard transient behavior. This patch gates the
> ionic_program_mac call using is_virtfn so that PF MAC changes remain
> local to the netdev filters and do not overwrite the firmware's
> permanent identity block.
>
> Fixes: 19058be7c48c ("ionic: VF initial random MAC address if no assigned mac")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 8d040e611d5a..637e635bbf03 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -1719,13 +1719,18 @@ static int ionic_set_mac_address(struct net_device *netdev, void *sa)
>          if (ether_addr_equal(netdev->dev_addr, mac))
>                  return 0;
>
> -       err = ionic_program_mac(lif, mac);
> -       if (err < 0)
> -               return err;
> +       /* Only program macs for virtual functions to avoid losing the permanent
> +        * Mac across warm reset/reboot.
> +        */
> +       if (lif->ionic->pdev->is_virtfn) {
> +               err = ionic_program_mac(lif, mac);
> +               if (err < 0)
> +                       return err;
>
> -       if (err > 0)
> -               netdev_dbg(netdev, "%s: SET and GET ATTR Mac are not equal-due to old FW running\n",
> -                          __func__);
> +               if (err > 0)
> +                       netdev_dbg(netdev, "%s: SET and GET ATTR Mac are not equal-due to old FW running\n",
> +                                  __func__);
> +       }

I just got back from PTO. I am looking at this and will respond/review ASAP.

Thanks,

Brett
>
>          err = eth_prepare_mac_addr_change(netdev, addr);
>          if (err)
> --
> 2.53.0
>


