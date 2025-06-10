Return-Path: <netdev+bounces-195958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BACAD2E6C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4324164BF9
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57B27CB38;
	Tue, 10 Jun 2025 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rMCU8ori"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820BD1A8F6D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539707; cv=fail; b=QRdwi+qPSaHAtHsPq6pjVLXwam2KFqpltqb8hVszCFl2R3y8dIWozGR1XMEjB7xQqRH6Nw/aEAkKo0ijEzwhxCJzfxv/GIpx05SZ6+11EWs9PwbkBSr++3k3DlJCf0cXChw8PB2qf8eIhwUM3M+/RZLyjUeBNeXnKUx6JbW9UFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539707; c=relaxed/simple;
	bh=FROQwyKN1UmbDVBVjmFxbb9htb9fCymN74Hwc+fRYRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EbO7L3Vq6ww9E8WlpdX8rfuImmMmhIbomY5nB1p0BmmhLdxTKMYyD9Es0UaZvlO9GopKjqhAOONTH7rcZRK061uOqkEi0+4P8Rx3Ju9RchZe7j2YP4H9A7P6FYuDs0xoX3FyOKPywMF+TjJSD483zDu23cwjfpztRHZ/H2MknRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rMCU8ori; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuMjwuO4QBMsP5RZjGoZB4ktpEKsDpOgJ49z5deZljoV7aRw1h4cj3Bi0nYS6iSZLpttC8i7+nMrhWbKNgu2M7nDpXI+LHIUaGFBEHBzNGiGgtNI2X58nTp8ntxU4Tex1ENrVc/i5QpTcC2JNJ6d/HTlf2K8VrgXO+80lCVgC4m6LjAeXJyJm7VKQGT44Fu++UWfCuJJmNfhtDRuWZfI6JAdZ34ayOckXv/4gCrakHUy0yrNd6VRlmimF/NNDjG1fuGn5walNZA1K43fS09in6NlFn/CwtVllK8emI13gBlTkMgILy646dHqX87c+ik6t6IJJkTUI21oz/M/fI6QRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njwsDFKFMQDhNlY7QGwT8JhKxu7IQB8w9PaLclRQUWA=;
 b=XSUw/cR494qEQt2sArjvuUdZU3VlrUcY7gkhGfBRsShJSRSFbgQGzeU4RMoe/eKONP+bYaTtiWYAY02CQA/CrZU5gI5qCww9hEv3PKeOluYrgKoDHq1NKlYGfbxbcgx/OBjKvEai27awcO0W/FkcPEPXetAuOZOoRry/fEtu4qd5wW4n+x1DUv1jsqnwtna18dKLz6OR/Ls8cNP+Wt6/uIAGzB/1CmWPcREggt4tgCI8ZAm+r0pxfUFRTjGf8yn2DT4H5sMtjid9NF3OKK9perXbRjJG8foSg9BXRWCCBm9dzNFhCBKrUrzif+3FbnoTA1c5AWv7yfXXWiRY5iXa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njwsDFKFMQDhNlY7QGwT8JhKxu7IQB8w9PaLclRQUWA=;
 b=rMCU8orip059sc30WFdG34SU0zLoxMUYGQ2+ZAYRL99rk4mnUiJ8JXi9LFhzt62M4vrWTxfawUzRKLXVuCdQVGNHK6fxWLUO7TlYEAMNcKD1/YZkrXuiYwro8XruYuFWhrr3GceFqFv1SxC6IzvRFYV7fUIXUU8H4hzr6HGCIef1puXPfQS8YDuBW3ZtdmVRT1sKQjavASNRI1RpadwQstHLgOEM3K+ENt9XkMH0qypxq4lbNjKW5zw4yczp6wD7O9MZ2leXRo1ct7IA5M5ttkdLusK0hJOLu4+6uW66/4vlwGVv8Cc1mEyPyNSfiQsOmmmobij53SHR+byW5cwlOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Tue, 10 Jun
 2025 07:15:02 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 07:15:02 +0000
Date: Tue, 10 Jun 2025 10:14:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v2 1/4] ip: ipstats: Iterate all xstats
 attributes
Message-ID: <aEfba37PsZm8s99u@shredder>
References: <cover.1749484902.git.petrm@nvidia.com>
 <e8834ec759b3e7f94545fe07a219ca592e84e402.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8834ec759b3e7f94545fe07a219ca592e84e402.1749484902.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: e621b27a-18ae-424f-a19e-08dda7ee8400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3X34VnSxKbUTNJ+bgrxqDAgwVhDdUJiLJiftbja1Xxb3HE12rEEtH5TV6xEp?=
 =?us-ascii?Q?SrOEjrRDIrI4TY9p81hBPIIbjrG2fhKakI+oiIExj2kdVXNPDpPulRn+pbBI?=
 =?us-ascii?Q?JjL5QPZxulAsuBOvZkNvSoKgHr3IrkW/L/vmkJVpt9oPILEgCYRJiyr8Mlfl?=
 =?us-ascii?Q?k+qn/tZMJqohBoptTJWzCQdTOK2XVFSLONd0vX61RyYj9zk4oFH6P4WF9Pyg?=
 =?us-ascii?Q?nLIx9a2laRTE53sJ1N0jxcta2qXn5jZJW8AOZvoqsxz8Xs++nfEc8assNeeE?=
 =?us-ascii?Q?y5U76NFKlWgZaTSTf9OGUfVnvjTC3jQ8iovER1NQ2JuRVziOaWFd2XNQJmN9?=
 =?us-ascii?Q?bfJsYtPko3mMiSfWH7Zqco9twAk9LaaYorDD2uTPdToEylvQA9ielM7rzkhM?=
 =?us-ascii?Q?5BYqbKPQQ+xDZVBVevoP6XEjin1wSfBribWRkHIXYFtix2Ax1ZLbgBdgdoB1?=
 =?us-ascii?Q?Eg1dc5bnRIyQr7xaibHU2r/QVmhs9hXGTdwvrNMfYHKWxd0N2FPyLSoyDv/v?=
 =?us-ascii?Q?mohCFDxN62oW+22RS0uclPmf6ZAtPMEP5Mbg5H3B9mYB5oFrfleeelkT68MF?=
 =?us-ascii?Q?yiXqLtyEHWlzPrTc9IRrW4QCPINDhKTLIT2v/4SZ1yUPp7lACLCpxWX2Xz7q?=
 =?us-ascii?Q?aZT+4C3IyjoVB+ZQ8oj1jN62pUjKsJgBh7atdbWOPoSR/uTtOEHFvbd7hHkR?=
 =?us-ascii?Q?E+uO3y6NybqebkTcqr0qziP7EgSCOIPNcVdQBFGCmzAiTOL7BR+VTfcfGxqZ?=
 =?us-ascii?Q?Uf5/MeX6BzF7hZ7mkAw5Qu983hF9KiGhWxcGZ64oDBefTWGqsbZQVl8UutIL?=
 =?us-ascii?Q?y3XgbOANQMMh3PavoaDaPQKIkTO/uMcSwuJvPnHwH0qyPRPIYuelfuDudKmw?=
 =?us-ascii?Q?2zlrgP01Rng6TXZ/mU0HPsGkI8b47ZKHFKDGj/ZNNXP03t5BSBPdBL8P0TIL?=
 =?us-ascii?Q?rnQECK+6dLXuvPfh2zXLnXbVoCjUogVxAj6PvyopwSU6KWp9bV64gijVjBM1?=
 =?us-ascii?Q?CRL8bP4uxu7zrJ9g+V+ycTLuO0PpDuu2bLf7wJBFQBC+P1BTxpoZ/wPikQSv?=
 =?us-ascii?Q?Q6imr45U0V1BmZvGeN4pSwd+hP3peIkscWVZctNrdkL4pCtXxfxyuCCS5bnH?=
 =?us-ascii?Q?/WXMl5+3BMarldzfwWFRkezajxMf0AGNdRgSqrsfEuYaY/uW2mAPVht4pxRO?=
 =?us-ascii?Q?SdRf0hTH/Fpankh/1oodRIEnNjiaqr+zvi14IvmCgcGGWoB3Ou95Yo4BWjOA?=
 =?us-ascii?Q?r6K8e1J7egmYm0va5h8oWIo33KM//QwtoJT3xTt6OOBB1Be5ZJPsw0HWYWM0?=
 =?us-ascii?Q?SeFTiJFNF988JqD6GOYUpiHGQRy5mwbYSFB/w8YJoh+X3fg+rX/0CuDEq1X8?=
 =?us-ascii?Q?/5yA5XnLKkC623Ta8BTk5jj2bk/J65dmHKlTfroKpxLDJHA9U3pepT/JJeaP?=
 =?us-ascii?Q?KIgWFib/xVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?srwbJrGtGRtHLJLzXLUG1PahA8DvOXs5u/k0j15iQ67S0OpputCYeuo+KbnL?=
 =?us-ascii?Q?YQ+JrWUy0AXRh3cCL9F+feAedaJFzooddxn2T3WV3ypDytCeit+O0gVHR8xw?=
 =?us-ascii?Q?RLe2Qr/NM4sLvZPzckdYw0nFZE4hGfuT1QXirnCc+/6wyns0Ptwu6bzwlohw?=
 =?us-ascii?Q?0q4Zok4GVYBugtxwA5oWBQVJeFT82IKXoQIRC5w2zxVZp7LbYQmG9zzP5QiM?=
 =?us-ascii?Q?otXKZW+zQq9k5CA1NnhzlmLBELjhqurJ5RdbRvdMxmXRcDFvlwkPoiFkdOP2?=
 =?us-ascii?Q?VIfr0JbMuq3oZ/lZcSsKAQ0anW6oUqrFAbIwZEGgwqVxytj+iC5pda2f9FzH?=
 =?us-ascii?Q?EnHrXLq7aSxX3Kq7yOSnB8zEnfxDRRFW2vByBOTSwIa5fv3pURQ+Y7v0bkec?=
 =?us-ascii?Q?kJvAdJhCBenN3PTmq78NH852RKY32xynex8BDuGg+I6YDU5UdzicFPvbxfyW?=
 =?us-ascii?Q?esl2SYn67e/PP2evIo1C4U3H5DxrOFCmC3ioa4cGsAU/bwfUH75hE7GdvLBx?=
 =?us-ascii?Q?nxxuOaFMGVY7HgPSDMV1RbwSeDnRFz+mpzl6X26o7KWZGKCZ9WUrTKSXc5KH?=
 =?us-ascii?Q?pNxSg0Ao1iwNYnchci2cOiGYGkNk7DNcmOlLMcNnNoK15TsCyQGzmzFn4cWT?=
 =?us-ascii?Q?7hyBgD7g2T0aPEt3ZfWj/MYAWs17Sz8L4gYCrxQrVrfjZBqrIVR4Y3EtXOQk?=
 =?us-ascii?Q?TAf6reO64ZXKdcYozLgaLLtvH5DS85wzsJmhM5jHdHq9JG8wxYFQbMeOO0AF?=
 =?us-ascii?Q?ik3YwLka6T9dQbut9TxaLB/a952cVyZYCVUcpgfcYKbMSt80fUHM+tUSWos3?=
 =?us-ascii?Q?LpjElRh6f66QeZkKH10Q62+5eWo+NZF8xvfKtyvWQM9iDCHp4+2981aE4k7g?=
 =?us-ascii?Q?9K6bGZPfU/CZZ9J9aOCUVhmlr17SOYBc/NbDYVdezSuMyfGgWJHFr97JbMbg?=
 =?us-ascii?Q?8xzt3E6mMvIO81YO000Mei9gPj096asBoQ/z7dPjowi2Lgjpmpg4HwcybQz9?=
 =?us-ascii?Q?Gicd1c6QRzoeGcavzCmKcusN0mfvEe4NsPIlN3vpd0n0i8ttrwQ3uGTGQXDu?=
 =?us-ascii?Q?c+2Gjz5AI33YamzcdcZWC+xzu75PixR+Ku5rnAhIw7A/gAdXpRnCfE7ct9ki?=
 =?us-ascii?Q?LfGR5yQVSCPIZh+PnjQH/vREbc5YNcQ0smgonQj2INgTEo7zO8Pfvl9L148a?=
 =?us-ascii?Q?hqgw7dEbHcVmSXdvaj7E2zgk6DtdsTujf/DfBZRIJJQxZdeIyGOGcfvLHcpE?=
 =?us-ascii?Q?av1EY9PIbaGa2aDKM0+Vwuybx8KKHRv0GZ6DT4xg5KFIK5sRVMeR702KdudV?=
 =?us-ascii?Q?cir6quIaw+Sta+OFiLCX2vYaL55onAZ9x2Acdu6bQfe9B3gNhBXmwmyrB8IF?=
 =?us-ascii?Q?vfXotII3DnJcn4Bar6dfOvPCzACcDV33ozUfcmbjqsljTIoGZFTj4tJrTkgb?=
 =?us-ascii?Q?kew6FFWtkvs48jaZgMigcrxgMx49pc1HPa574s2mu/mtXwuZRGZrqnUL7ZDH?=
 =?us-ascii?Q?WEb/Y1V0kfEJhlow3P35hB5ZIhsOjKZ48MVYUkGzWA5k6Nu+uljtQS862suh?=
 =?us-ascii?Q?63ojL/GbgXOGn1IEfetaPncpJc6ds9q1FMnL4FbG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e621b27a-18ae-424f-a19e-08dda7ee8400
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:15:02.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cs4S2L5UZt9W5f8Y3Y22RctpyQLRHwKY7nB5/3oQm6qyge9OLGz/Apyr4xfl9A0/0oi2DcydvlFK6VJUqRVSdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

On Mon, Jun 09, 2025 at 06:05:09PM +0200, Petr Machata wrote:
> ipstats_stat_desc_show_xstats() operates by first parsing the attribute
> stream into a type-indexed table, and then accessing the right attribute.
> But bridge VLAN stats are given as several BRIDGE_XSTATS_VLAN attributes,
> one per VLAN. With the above approach to parsing, only one of these
> attributes would be shown. Instead, iterate the stream of attributes and
> call the show_cb for each one with a matching type.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

