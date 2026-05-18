Return-Path: <netdev+bounces-289139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGoxGXFOC2o7FQUAu9opvQ
	(envelope-from <netdev+bounces-289139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:37:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DD571B1C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE93030C227A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355B480954;
	Mon, 18 May 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NvORQsGl"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291045BD6F;
	Mon, 18 May 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125606; cv=fail; b=tQ7rfH9hP5ctq/KnU3V/9o6dZAolFW355JKu0dB/3OWY52fUnKN45GGLbM2Wf/wG6ZoPvazUvM0leQJKJX7iFhS575QeytfuDHz87iP3Zw0ah+PYJ83M6PUhCb14ZTTUlbLF/TaDpY9uFntKEj/WrSbnWjA6Yv/QoMs8VWy/kao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125606; c=relaxed/simple;
	bh=Jxtq7bod8I87i5f53W5vLD5HOSWiliwVXWL/kVlaR6E=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gkbVuXEQc+1JIMDNyRwvANuzSP0KSgF8dTMg4JUtoE8Ji3PVVPJEd+lqx+JpBVuozQ+KAgLCnZ2+GdPZ/qMFVDPh+A1+wLAg2XU72BdhyaWaLPbds6HrcQ7ApCkhzIwnyY/1dUi0i+DW1xC+nZaaVZHhJXM1J5xF+eWuaQ06qGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NvORQsGl; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2th+s2Cr+xlVIJqJk2FDopljINrST1x51nclT97zCqxLLCu+a4VU5hxeHhLKtsXwxz7qPzwtgmK6Y4bBRnmkEsqE3HPXN5L1x4ttEuR4trHa72/5sZlquadpvfFVePkKFGEuzeUQo0ncL1o+nxXf8DBil0EgE7r85LNkOkqv1NyTjcN1HiFNc/UWSaX6lqe9Er+SpODE6bzZbLA2nyrxWMOYe8dCxIxWD5HI4r9JupTwE82eeAJrc5b+KteGXC6o03ym4WG3bHDPktYn0ci6IVQeJqdiA9a5vkznpK/N5LLCYCQishGTTz55v7lamjC0ouIGsijArwiK6G7FrNoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jxtq7bod8I87i5f53W5vLD5HOSWiliwVXWL/kVlaR6E=;
 b=HjLJWHGJ/rSFtnFc/PITPG4lmJfsyZE/H4wB8JkGfndjU/VOMPPpGAVUp0ewPURhYLMWjjqd//pc1z35P63y74KGFf54oTri76WG7v6ERu1Isan+hSFyaZ1Me+M0eKvBqlFtMJVKyLluS7XmmXCamqq+Sajb4o+dcyo4diEeztSX2GyuSN24UtZ4zyNLpRqydDkhOWzodW4lhKwCFqPCBoKuuH3rLXsTvFXCUK9Wy5+1r3+rl+MOM3HqEWavT1dZJ1Pl+/H/9SDbJCPEcE3PSM+tYvELTOyjLmH4vxCKvZ9hPVAwNysMAehSRAUQPg23D8ApJHTLM1P/LCHbvZwE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jxtq7bod8I87i5f53W5vLD5HOSWiliwVXWL/kVlaR6E=;
 b=NvORQsGl59lLXCwwHFdlqjpSJ2sJB067sLkZQghzDQAoioGUtawrlsWj0cYhwud/RgkyUjpK7VAXZZLvgc5hMmt40RbTTJthVdGM2JlGsLiKKBYzvua9IKV1mek7KGJ+shqbeQPM64UJdXS1u2ER4VuXt/JZWLlWaHLM/AEBnmyznhdTBYCu4rm+J4gXZdoxxwwFwII1kjiOCeJiCuH7Z7U9nN1d+3A7rgHwTgyi1OE7otT3l1qHbuZPZGHGZ2HqV4G5MoyyVqoDcmpFdeD/93JNKL8gY5mAdLLnuc+Q12bIV1R/FzRAzmRQ+2kzkF7DCbYVdsCEeH9VwdQzJONkng==
Received: from MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::35)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 17:33:10 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::51) by MW4P221CA0030.outlook.office365.com
 (2603:10b6:303:8b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 17:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 17:33:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 10:32:46 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 10:32:42 -0700
References: <agqkMwgM1PdkyMUR@juliahub.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Keno Fischer <keno@juliahub.com>
CC: <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mlxsw: spectrum_ethtool: expose per-PG
 rx_discards
Date: Mon, 18 May 2026 19:19:47 +0200
In-Reply-To: <agqkMwgM1PdkyMUR@juliahub.com>
Message-ID: <87mrxwmxmy.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 533ee762-2c55-4214-97d2-08deb503877d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	1nZpsOdizrGdGrKa/vdHFTh2AeKTriasSHI5ittblsk1qU1n0pwAojvbr9o/pyInRYpp+2u2mSz6FrKFchNsCp0zLF/BD84H1OSFGBhxoBJPQ2ae36YVJzqZeyCAIWHDirTIPy9KgZpKuB2ykjjl20hROqNCZHC5emmgTUKFdYD63l90gwgmwG4a4+NlLEL210LwPsLoD5VZHmDBLYCG5rvcFRAkthN9xx0Lp9iPxTMQqPgMv6whVxfy+hfNbaxz0yh2r6zvT+UyiLNkC9p+VZfInBe2glSfsICU7z1SjAAWfq2hzsowl9Bv3siTgLabOuuiy0GQy+Kg1Qnc/DN3R4zw18TKahZ2UexSqi1e9Qd9AJ14N+sSAOngfywADLjQ/OyT8MNe5Vgqyyi+DGsPpgp5tVFlMA0VPraU7EhxO0qFiw9hChaif5oezP1Z/MnWD4MUzjKeQRWFO8kX1DnqTtdi21G6pksZekJ8AFouJ90gfgOYY//LTzbqMnlyiTVSCXC2drzUSdGVbwxYh3CC5vGdsXP8SSKra/boIRNEwKFmHB9K+OkbVLH99Nd77Ti97jO4hnMr9vsv7C66aDWe50r6bvv2Fx6KmsGPRAnELXEPphhrl6QRtLUfoRxeNIRH3ElU1nksQOqbfKsO1hLjb2qmclAgaicITEX3CC63PN5DfCw4CUCHGXYQuhZzwnpyK2UtmxnSYYRJGR5gW9uK7Ev++z/ZNjIIwdM45lUfgpw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DJ3NFmkPpiLTtb2d0hwFsAR8OaAP4C2YFqTO+zqqOmcDQ4HmX56o/gA90sZQ6yJGL62ggs1UfZBn3rMLwfuRIONkdPWqhlqZp37+gY0uHaLJVoPFeIy30vklIq1DF9tH0s1Y9E/3U7iB5sp9cia8Pp4lz7rg4SrTq5eKwcbZcBv/ua58FuwBoQ0oXHCy6y3OMFPrL1MU+igQn0+YUU5TBuFUms4TszRCdb8Hd/+mz+Y0E57imCqJz3br7SvWJeUx0359iVPDQkGk9woyKXt3fuXYabjb/6mtjUITTvwbzKEgo2hqv6ZPU326eVZ+ynBuEQpcj9pIGeBDBitmZBBBFhT+1a+fxMqwOyZl7+MAI8VwXwXhHim8t16m6ywYY/nkn3fh6OFmGmiFEN04j8EDJsWyol6tVB3otf3BWH/BDzUrE4zueBXDEcqd6Gz2dnFr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:33:09.4465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533ee762-2c55-4214-97d2-08deb503877d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289139-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,juliahub.com:email];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BF0DD571B1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Keno Fischer <keno@juliahub.com> writes:

> PPCNT group 0x10 (per-priority counters) carries an rx_discards field at
> offset 0x78. These counters aggregate up into if_in_discards, but don't
> show up anywhere else. Since there are many things that aggregate into
> `if_in_discards`, having these counters helps distinguish what caused
> those discards (in my case they were caused by headroom buffer overruns
> due to inappropriately configured buffer sizes).
>
> Of note, from emperical testing, these counter are per-"priority group"
> (PG) not per-"switch priority". It's a bit confusing, because the rest
> of these counter are per-"switch priority" and the header file calls
> these "Per Priority Group Counters". However, that should be read as
> "(Per Priority) Group Counters", not "Per (Priority Group) Counters".

I think it's (Per-Priority Group) Counters. As in group of counters that
are per priority. Similarly there's the "Ethernet Discard Counter Group
Counters". These names come from the HW manual.

> I attempted to distinguish this in the counter naming by calling these
> `rx_discards_pg_N` rather than `rx_discards_prio_N` (which is the
> naming scheme of the other counters in this PPCNT group).
>
> I will also note that the mlx5 driver (which already has this counter)
> uses the schme `rx_prioN_discards` (and same for the other counters
> in this group). However, I was unable to determine whether the mlx5
> counters behave the same as the mlxsw counters with respect to PG
> mapping. An attempt to remap to a different PG there did not change
> which counter incremented, but the mlx5 configuration code is quite
> different, so it's possible the remapping needs to be done differently.
>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Keno Fischer <keno@juliahub.com>

LGTM, thanks!
Reviewed-by: Petr Machata <petrm@nvidia.com>

