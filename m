Return-Path: <netdev+bounces-301150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IcvmKaFXOWpyqwcAu9opvQ
	(envelope-from <netdev+bounces-301150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F18F66B0D0A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:41:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=uJEoGpgz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301150-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301150-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 775D73073724
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2945E3C0A12;
	Mon, 22 Jun 2026 15:36:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D713C0626
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:35:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142560; cv=fail; b=YVFzj+6mePHG0edTKtf5hijISoR+kyuISqIfJbBtE5gy9bDTtQ1BJJAArlSxjCoBZCIsZJSReFmAvobB5iDeQ55pgwZuanBMDkTyoMe10V0ehvrk+C7E6PbCwFkEWop9/eXMEgO0bdw/MGe003FPcyTplT8UNkFKRii5ZgLdZno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142560; c=relaxed/simple;
	bh=Nu7spyszUeH1o0cIR0hEujtfZpzM2RKzhQ2qMYicNHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pZMWIHDL3E9UW+oG2mrpW6pjx/2Cc4XKc2AQp0Wzp9y3eBb2+MS7omoZmNlfkTleliQFIIZlLgXj3pdVhTIUQPJoaNh8SRH+ANtqCPhjpcztB7iYWgYx+7C6RW6ioJ7qg6SF0iNJ2rxZsKIfLKen6Hx3FCZuT0+ZuRdVxYAJ15E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uJEoGpgz; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVJyV6c9XXeCvFqnTsmaOmt5dgav1G2xC2q5CiG6izaIAy95+mglusw61KZ4SPumUhBeLqWksSCmHNVU+JP3z25AGQbnqffwUXrNj8hqfuXMxvvQo5D5/2Zisl0hWOyWTICqobQAbe2TnzTRonk9IIV61H6yJ1SnYPz7Ms8bgA9x/dv8cnF7iovOrU4EzbY5Qsk3dwbbvNw0x7vn2z1zxvkvy/bcMxPDkjSYqNURVFfXxDGHwAIvDa1TKWDl2QzTn6n0zun8EdZPg75NrUMNhhN1vW02wNGnCESmeGRN/FYoNZVicRJQoNjSdAaZfPe1yH2ireESYrkwnWz5uMtLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu7spyszUeH1o0cIR0hEujtfZpzM2RKzhQ2qMYicNHI=;
 b=Qc03CcmN1K52VHFyskAAq7XIzKbXKtKCyoSDrNDHDGf1ZoCq73zqNphct1AMB+e1pJuxrCScIbu/fo0wfn9WbcIoVASuTtO66Ni4N2kVkbXXVrd2kBUdYHCykoeP9yDphwkdFgwVVv+sVZt1dE+aUTNVP3jTru3DXDAHAXxwGkGnEoeARJpjWlK7MHkC8hpIXk3op5Z5QDBcUHyGNhYYPOH9PUuKiQumWJG1p6vPG44aBXmWxhnIOs4IHdfpYfN60Sdc8Sgr23UY22XtyS0/dvSl8Jq97CoGOOdkEA3Zj8+1O7uH/VVJHN/dgEDi5mJ7kH/ifUXdpyd7WgdPogcyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu7spyszUeH1o0cIR0hEujtfZpzM2RKzhQ2qMYicNHI=;
 b=uJEoGpgzd0W//jxUXARKr2GIUyZwIh6ZXkP98x8m7wm3qVDp3xBOiByzXudKfmwPeW3Yklb2bY4Nso4h8JpV9/e/Io096pvJfOmjuAh/B2PpDfWS+LaXTMH+01VmxcXk7RSpajWyzl1DcVRedxmIwZReCoQgZ1jt/GGbYmUmnUT8WWL5lEG2SPVwI8Gkk7g98rMptXfLrbFFsx47G+2eZRHdJ+l4WODDMnInko5a6auqnh5QqKar/jvuZG1axc0LWT/+jRjJEPgA3xfHU1W/pdsCLVGMezzeeF4xiTpv81i60I7QktcsEU3CQUqD/YYOGo64SIMy0u3VeaGGCFti8g==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 15:35:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 15:35:53 +0000
Date: Mon, 22 Jun 2026 18:35:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	stephen@networkplumber.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org
Subject: Re: [PATCH net v3 0/6] ipv6: fix error handling in disable_ipv6
 sysctl
Message-ID: <20260622153542.GA354968@shredder>
References: <20260622130857.5115-1-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622130857.5115-1-fmancera@suse.de>
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a2da99-a8d4-4438-0519-08ded073f1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vX0RZjCBMxTHCZwun2rVOCqWWFME4BqOamkDkVWVy1YC9veNkg7p8hpd/xAzB/U1OgRdlWV8Zf6e+/BHy2DltihXgKqEcVMzDX9w8Zj87YKcOtBp7LST6OOYp2EeiqeAPgBaFPfgrDOvxoWk44aVeBUgdVCYF41Bj8I1MjNNq8tqk/AYz4HKqyfE0wopHRCAfKMONKfIuKbaXuOa008bUqsrJ2HqoXRvjbtftcn9hchpq+zCqO2awqquIpN+LTbc7jV25sTotE2MNy1bEWKoX74jMcxhW7EWKTsUeMnvKStmZgLpOi/gCZN2heTwzKoCnUaPmR+d5zqsBFJlm6ENJomIEjseEmuyR8W3jnYVIojPPdjQKNZL7ONrP3lOTTAa1iK6nriPoW50wxOqxyVdx/FIj5NJmjVJXxoWKPWL1lT60kLfLwX23myODUlSMCEBwoD2bxoPha/Bq1AGDSZHm6Ejq+Jwmvia9qZEjSPbCa3CARfrgLRD/Dfp0JrQKWvrwFYNtgiRpIn476yHMNXyyCkMnwbo5OYEsbm7FzHHcU1XpDKV47yK5EhyCoKTH5HtB4iYM+NuTXgSKas5Y/e+dE5ieLOBCWGjEGv1MtscOOKYZe92KEGsSfCNHpNmRgzulkYUMpmprx7gkCfMOKcVvAs0+wrWGAl2AX4aaVTH38I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iyAVWBzwFC673QDnHqbJKk5FR8QvMoa+UY4X+syQYmozEmBlTGU50GvfY03S?=
 =?us-ascii?Q?MRYdVczRKuotXet//m89Fe/i5i8GPZ/wvwQklRkftR5BoGpaGELeh9m7AI7V?=
 =?us-ascii?Q?LZKUB/hYjD4DoqZRRqKoQm4a/ABBqISgPahgGZqbMEk0UW8TW31HSrlPIV7j?=
 =?us-ascii?Q?MaXr5N5ECv0hftfhbL1oe7InernZjnX124DsMlUrdOShLhoC7hyT2cdNCBdi?=
 =?us-ascii?Q?GtyMW4asWBZsyX1leYwGUNcEwyWtjbMRW9XKSHfsOnM9/rks23K/9PqRzVaE?=
 =?us-ascii?Q?2hxetFjJhWYpzTh2Z/doFhrpWcOqb4Ca8fZOlw3LVT+mGhWlFnrSuzYr4l3L?=
 =?us-ascii?Q?iMijJGdwGwhIc9U4aBoNfWE/XHP6rHYglYigJst1+mOOjZShVlLlSy6W2ZIa?=
 =?us-ascii?Q?zRZy0XQ8S+gTRscT07grIDi4L1vTILi3hUp/FclT3WG6A7rl4MLYhD2T5S7+?=
 =?us-ascii?Q?6v5Dq8AsRX/vaZZcfnZkBjcOHIxZckpTy+4PH+fhJ8ETgC5Y29U6ngeVheOr?=
 =?us-ascii?Q?tSZDd2H2S9OO7YeufiIG4SHhpYGWN7POdJw/umxTEggs4nHH9OFbQbx3pO8D?=
 =?us-ascii?Q?4L5D68qGC++fnBxnCpfEiZw4voi5KCKBoL4wSDWa74P9RXeMv5bsK5cHxzSd?=
 =?us-ascii?Q?52MVLKj0PqKZ1GiT0D8p3awFfdbfczMLv9TfY+h6+DvC7GI7j6IkcI55mH8X?=
 =?us-ascii?Q?/x5Z1RaENtELXl56eOTssQlJEfIGXPqizBlUJ9dkHhAQ/6clPgCsrQymKLBO?=
 =?us-ascii?Q?/fQucUUqL5ToCTQk4pO5bD25LMdlIrTEDgQXQ2hkByOvj6k15N9a7OigLacj?=
 =?us-ascii?Q?svkfYBhiwSwBH3YNMLU2J+AnCYmHyWfdPTXdcEIgiI4+3IfLFvasVtc0K7E/?=
 =?us-ascii?Q?DUECvqgkdS/8d0DmeRwyxZd5rqNJ/Yc/tYCuKNcdlSS9RUSZfB/Rb5q3V3Wb?=
 =?us-ascii?Q?QCrNjdbhGtPx4+2ZSIRtGX1z1AFifKzs7jW/SLN+pMdMBGvR5lI2EW/JG4tv?=
 =?us-ascii?Q?JsbSpnQp3goR6PSeyY2GbvH1kfS6r0wpfYfeJTNukhRJ6Y1ndlNsadYG652F?=
 =?us-ascii?Q?xVSq36YoTP6yJ9EaSiZdEhr5nFOcsMKy9A/cSbO8NOrDbNl2TVpAwxQxjEVd?=
 =?us-ascii?Q?1ZfqghnZQxCPcZF1NuJUbaE4shGwd+z0Ch8Pov4Dgsjnmzn+c6893KsNTRZg?=
 =?us-ascii?Q?hW2yi9Jr4IVwqn2VuxaEP5X2mla1j1nzP7OAvagQsjF/9YkwusESY5e0Ssa6?=
 =?us-ascii?Q?IwkM0Zvyoe3oh9tu7rNEPT96JBB3R+qxQP85rYaZIvZV0EnGRkvq+nw0pps+?=
 =?us-ascii?Q?lIlKmUYR2rtwwDa1nafvhxdc1hSLgiih2NtNCsyadqcGJGUVYTbCvpV2ZkUL?=
 =?us-ascii?Q?aJGBjRjSIiytV4yNnYVejYEHfLLTm30OcCyiQXx0jWHbgKlWH08UmIav5G4z?=
 =?us-ascii?Q?Dj0eaytBZkhm1FXVVuvv5LNTm4PRraAJDU2F3R+CVd2iLoofzJY+ItTIv5Qn?=
 =?us-ascii?Q?j9F21YQc6d9m7mawPGY5xELk5iLUYUtaNl5uVwT6FsiKKHqFw9HDDRmq5l9X?=
 =?us-ascii?Q?UwX6KTP4eJd7GzZzk9zhWUHdb5LFnoV8PlvSVwrLahwu+O/NAc1hUX7UDwgM?=
 =?us-ascii?Q?+PmpH0HRFD3KaiKg27N/e80jdziVZ8nU9cMsQm/Nk1+/tzkG00t2rJg+4RFe?=
 =?us-ascii?Q?POKU0FBT3y193WD3wSPjKGm7ZlfbwyPfNCm0ZERxoKjTZOA/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a2da99-a8d4-4438-0519-08ded073f1b1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:35:52.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72eTV0DImNDJLqvJBX4XFV6ZrcfUSuIo35zox9akhq9wcf8dH90lsnWj4fXEtVj02W2za9pmpR32vsufxTxTTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301150-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:stephen@networkplumber.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F18F66B0D0A

On Mon, Jun 22, 2026 at 03:08:51PM +0200, Fernando Fernandez Mancera wrote:
> While working on a different IPv6 patch series I have spotted multiple
> minor bugs around sysctl error handling and notifications. In general,
> they are not serious issues.

For the series:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

