Return-Path: <netdev+bounces-257568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIhJAKsBhmlhJAQAu9opvQ
	(envelope-from <netdev+bounces-257568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:58:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F82FF5F4
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 068FB30041CF
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2752423A64;
	Fri,  6 Feb 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BWOumcnM"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186E346A0C;
	Fri,  6 Feb 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389926; cv=fail; b=VMocYvwoFQ01Ok9KnItfYW4BFW0P5ezs/qSudffM+mgKZ87BEFFQyhW1MY6VScu9IQ791Nrm6agK4jhBd1b5IuIjjlTCv3iIkwFP8yN7P6/unh8X3z5k0g5tS7Lksau8rEMKSecmHJA+qS6eKoazWen+uW1D/pk9XIJqwPVZFAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389926; c=relaxed/simple;
	bh=PNzR+Kd4LiiBgQfiPTRLaR4ftN+ecy+HA/wwLZ0/6pU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZoYMGJZfwzrXCLeVoEKsQ1ixtzL2VoajEv0q/mUBVVbbEK6DfHEzwo8Azyc41dlK9QprTTbktdzSvZfY5v5Vjq8nDdLNVGhKQGbJ3gevg2Z/iMzVifHxe3h/ssGSTddrYoOAeaJ3+IAmn5/LZjEovXsDmPR/G3btpLzl8S0dlYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BWOumcnM; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKhxuJmPj0Pcgv03n/SOhO36wzkM+evXOj84CLjep7KzZx42tFzilgE+VfqDBg+olPlDCVPFm7Z4MmzUnaEHnBfAMj6sTvJe9VGCuWHJtz7GQtzHgloDWkfsjfC0WM0BCLk8sSfyJy5WSXd3cMoHieIUFZ1ict/n+EAkjjU30ky5ly4ukdXJcK8Ro9NyXdcKpZo0xvF79O3BvMV1xNuc+SgXb0PprLulV/PDVP/18TxMcker4FsjFYvYFPPQL80EF/ywt+2o6wmUNL4DvqeiLrsPnxYdVpBBq7MHtAqm0fjvz1Mwk4HotIkOtp3DcSRLD+J2SjC+L8x0k/mnYReVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L/SqOgijRyMuLSeymtqENajlwQ/INi22znuA5CjBJM=;
 b=h2reR9vK7e3ss/Pe1IuK7Z2iak6vOFvt9CSamL4HsjOoWe49bwV0TMJqmKHy75VqjUyV7Gxz7zZrop4s4iIa2ELMLAmArNRwvI17SRf8gsLdCwCXd08BV5iDK3bMXOUoo8i31DWh05Xh/SQETigSNVKmTFNtEEWgi3ellNw9qeRuWwoMzMNBWwNGR1w+dgXNFTu2u8Ex17sIXG1hJFyd+DzWs+pVFxXUfRQmzrssDOB3miV612cPhmx/LHYamlI/QTALOKOcsBWkqGqFCIRAiYZZ4lN4zF+EzzjmCuDiso6QRDd9IJF9wbQ8RK44LDptApF7ezU0K7ZWiMVv4cLT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L/SqOgijRyMuLSeymtqENajlwQ/INi22znuA5CjBJM=;
 b=BWOumcnM99XHQlDJO/2FCIP0bgkRsCxQJvD5ITfsbvPnk5zA/YZWuaX5fSEZr7Phl77AGdM5/ZklM1HI38NDrBYlTka1UCxrxrS7agPOs8ezORXoD0N632cDcBgXnA6HiZATzfJwBslIFeCYQ8F4xBdVNST6xt5M3IZGlTdQjWMhs2eOhCys1XpfPNVv8b3ejpXfdNdB492ZCU5AlXdt0rH1vgcQM5pBbntcuI7hlcgOswNUX3QdJ4GwkkNrBZ6+bpYyHpT22GaHzWXF99VBtwhtEIPLgS9BOqqZKBqYyOOMwGxprkhEKVfGmeh+VHXdsd5pQ21y0hitzwNoKDTeMQ==
Received: from BLAPR03CA0126.namprd03.prod.outlook.com (2603:10b6:208:32e::11)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:58:40 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::f1) by BLAPR03CA0126.outlook.office365.com
 (2603:10b6:208:32e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:58:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:58:20 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:58:14 -0800
References: <20260205220541.2992807-1-kuba@kernel.org>
 <20260205220541.2992807-4-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<donald.hunter@gmail.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 3/9] tools: ynltool: add qstats analysis for
 HW-GRO efficiency / savings
Date: Fri, 6 Feb 2026 14:44:34 +0100
In-Reply-To: <20260205220541.2992807-4-kuba@kernel.org>
Message-ID: <87pl6h2a2l.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c3434c-f268-447f-0b67-08de659036aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMqi46NEAVWAZFe9z+CRApMZI5ZL7l8pJ+Npdp1go019V/o2N/BTgtFKBvzq?=
 =?us-ascii?Q?39nCNt8hMhBfCvDB6ccYoa29hNPnB3H1fwMSdr0L6iQaM+96T7GffXLKJbKH?=
 =?us-ascii?Q?7/XUrvfAKuO1QTYbaJky8Yd4wYZIVwwixZ0G5oolZnmk57z7vmm2+M1uZkWL?=
 =?us-ascii?Q?Ij/OkoT+7pGPLhLm9IJtrU/VbH5k6JZheWhQg3rKlg07N2fgymo4iEFhcso5?=
 =?us-ascii?Q?Mr+UklpSPgJ+lZtmLYEC7vRpPc2gjU+k9io2OEtrQUpShMjEL55xCxosBtcQ?=
 =?us-ascii?Q?D1xyrmmyOkDeKtNlNiLTvQcH11fNypKrKjiUHYtJr7Wu5e6+LMUaxeqfWBFx?=
 =?us-ascii?Q?u0Az5QtmDokT+ItnfiC2yqCEf8iXEDfjvrshOiTeCG/q48yXWdledT5u0rh/?=
 =?us-ascii?Q?Vz6yl+QExZNiJel0sOb1dxmAJI7m7XuchQbdbs2TWebrB2m3fy2nEdZONagh?=
 =?us-ascii?Q?Xjfqh0bdnsSq6Tir9ZAJDVvsVzSQKjaOuMVy9sCZHl6lPYmLpvuB7I7/U6sj?=
 =?us-ascii?Q?Uak5Me1wr/CAFVtW6F8Od3ebInZuvSAa71/Kb6hZkELVls8aaPg15T5uYfAZ?=
 =?us-ascii?Q?IyuA0GdikXt/M1yyrZY3Y9vGowIYv3RBLgkDYtkk+7zvMEtz/V1TVUB1f4T0?=
 =?us-ascii?Q?2mlQrDRIygIqSrcybrtHNcoaGqKJw9i8nJL0LTeDmCxD9bnTqkb1G6EpBRty?=
 =?us-ascii?Q?Hy75EdELyrF8ThaOWR7fYPjkYNHb2AFol/AOfU0x3vJHdXAIken71c5pMjcp?=
 =?us-ascii?Q?k/bcJOqOQi4WS9+PG+dmnpFAyBJGiY8ikg99+onU2rVIQyCey98Gm5INAstT?=
 =?us-ascii?Q?ZcXvX3a0fdoUzVLBpm3i4bQHWrO/jePvEf1Vil31aB598sxVjJ7HDMqYhVw8?=
 =?us-ascii?Q?xQN6QGhVuyC7ALemGy2hsnayZ4z0KzU5jpEP/SzZEqiIEVFxxKj3OlMJbcx2?=
 =?us-ascii?Q?dztjLd/eHr5Q/L0rBtEcT2WoXaKAKjgpN5PESld/RxOmGbOwB9/vmh83dIgT?=
 =?us-ascii?Q?j1fRUi13mODv5gE3WwtBTTwZ+J15W5yVid+K6WrlVLGMHUW+F85iUqC1lIbq?=
 =?us-ascii?Q?5oRACkH3yTykM/KHPw9VzG2LaVyxO5sPDoYY/gPGV0cY0vS8n/2FMnFa0AzS?=
 =?us-ascii?Q?SIaxuo9iVsxIPFocBNzCPWsZZc5+JoEiw+ss5B5N3dJUy/JkqGPJoG8xzaoK?=
 =?us-ascii?Q?DkSR8mSXVVHn6GIqRruYuLSs0KUX+8J45lx3sD6x6zzsXANS3Gn0x7wq8UH9?=
 =?us-ascii?Q?VhTy5nf2mK8toQXsCPUU0sxxSSWQssO6FBwg0zTXo6sx6CWShi+V/WHbS/b2?=
 =?us-ascii?Q?QyZwCjVQ+PWKJZ0VdGyioQEKEb9H/R8hw1tEKA4u96O4F4VRKoLws3ISSXSc?=
 =?us-ascii?Q?nQVEIAE/NPRck4ZgpT3TTd4CxfSEJe9YIkyxOCZz+1qwGhdg7XFvxth3yGHw?=
 =?us-ascii?Q?QCJ+ewUSL3KKd5izhoh7FOeWiioixi7V1KmjOCMKnfC87M6zNYgGX1/veZgy?=
 =?us-ascii?Q?JstxoOiaRgsMpZzz2pVvyWlg2DgUIB2zhueRhhOMk5j5sJ8rR7OrGvI2xgNd?=
 =?us-ascii?Q?FZorxvPbEzyOaZQFvjxR44+hximb6WvGFNwWl81Br9F0+oDuhp776DceN4gU?=
 =?us-ascii?Q?wTgiWev/jl/Qdxndx1kZGr39RKnXXLbNVp0HJPtcCAVCxYfD997iQTcb8cVG?=
 =?us-ascii?Q?sC7Daw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MIhJk9XwCAZmM4xi5yatw8iF4Sm0bj4gIVuLLq47aerkuuRKlFfwvKr+SU5bn8Gh4Df5Mrxt2Pxi2zebahCWedWu1W8gUmQJ+LgYzsk80D6R1ny2yOhL09Jz3XnjLmYulmUqJMN22ljfAFnnqjK/m9rim1cdC0H9ZvTJJzmeIXJZnTUoftW/7rMdQNAXj0cqRqyOBNqYDcU07Jrk7zzNYEbLUF6fAd4vmZr2mBVDN1kQqcCygb75mYDFVMM2hTCNeFMEVeIuYQ1vUxvYrETuG7gO9fVeeGIVhfMXTleWtIerG3CTgYdAFv7oiQ5N/QuM17zPA4Pshnq81nmP065Yv36Uiqbf8aTwzXyeRgno5lXnWTS/jRRPOECrlzqD+4OrZU5/p5iHFzfnfBvvt7ADGcTj42+BGMKIN1nC+F4rk98TvGcObuMP3SmyiaxL2AB1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:58:39.8122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c3434c-f268-447f-0b67-08de659036aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257568-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 97F82FF5F4
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> Extend ynltool to compute HW GRO savings metric - how many
> packets has HW GRO been able to save the kernel from seeing.
>
> Note that this definition does not actually take into account
> whether the segments were or weren't eligible for HW GRO.
> If a machine is receiving all-UDP traffic - new metric will show
> HW-GRO savings of 0%. Conversely since the super-packet still
> counts as a received packet, savings of 100% is not achievable.
> Perfect HW-GRO on a machine with 4k MTU and 64kB super-frames
> would show ~93.75% savings. With 1.5k MTU we may see up to
> ~97.8% savings (if my math is right).
>
> Example after 10 sec of iperf on a freshly booted machine
> with 1.5k MTU:
>
>   $ ynltool qstats show
>   eth0     rx-packets:  40681280               rx-bytes:   61575208437
>         rx-alloc-fail:         0      rx-hw-gro-packets:       1225133
>                                  rx-hw-gro-wire-packets:      40656633
>   $ ynltool qstats hw-gro
>   eth0: 96.9% savings
>
> None of the NICs I have access to can report "missed" HW-GRO
> opportunities so computing a true "effectiveness" metric
> is not possible. One could also argue that effectiveness metric
> is inferior in environments where we control both senders and
> receivers, the savings metrics will capture both regressions
> in receiver's HW GRO effectiveness but also regressions in senders
> sending smaller TSO trains. And we care about both. The main
> downside is that it's hard to tell at a glance how well the NIC
> is doing because the savings will be dependent on traffic patterns.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/ynltool/qstats.c | 75 +++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 5 deletions(-)
>
> diff --git a/tools/net/ynl/ynltool/qstats.c b/tools/net/ynl/ynltool/qstats.c
> index d19acab0bf2a..e5b83cf9bf3b 100644
> --- a/tools/net/ynl/ynltool/qstats.c
> +++ b/tools/net/ynl/ynltool/qstats.c

Since I see there's going to be a v2, a nit:

> @@ -580,6 +638,7 @@ static int do_help(int argc __attribute__((unused)),
>  		"Usage: %s qstats { COMMAND | help }\n"
>  		"       %s qstats [ show ] [ OPTIONS ]\n"
>  		"       %s qstats balance\n"
> +		"       %s qstats hw-gro\n"
>  		"\n"
>  		"       OPTIONS := { scope queue | group-by { device | queue } }\n"
>  		"\n"

I think at this point it would make sense to convert to %1$s throughout
instead of pumping in more arguments.

> @@ -588,17 +647,23 @@ static int do_help(int argc __attribute__((unused)),
>  		"       show scope queue      - Display per-queue statistics\n"
>  		"       show group-by device  - Display device-aggregated statistics (default)\n"
>  		"       show group-by queue   - Display per-queue statistics\n"
> -		"       balance               - Analyze traffic distribution balance.\n"
> +		"\n"
> +		"  Analysis:\n"
> +		"       balance               - Traffic distribution between queues.\n"
> +		"       hw-gro                - HW GRO effectiveness analysis\n"
> +		"                               - savings - delta between packets received\n"
> +		"                                 on the wire and packets seen by the kernel.\n"
>  		"",
> -		bin_name, bin_name, bin_name);
> +		bin_name, bin_name, bin_name, bin_name);
>  
>  	return 0;
>  }

