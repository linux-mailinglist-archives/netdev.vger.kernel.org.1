Return-Path: <netdev+bounces-289515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C6IE+GQDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:33:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A4458272D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF76303A52B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5662E2DFB;
	Tue, 19 May 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sSCLvZ9U"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C222DF153;
	Tue, 19 May 2026 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206618; cv=fail; b=llAIP3Hq7n7XdyrdmKFoQfTzV/j9DU3/b0lvJr6pRUls9xSc8VwbDjyqJ9zC/YaHYCMgttvwuiu6tz7aQqTemITh04ddl3p+84DLzk6A6wmMjIizcVAt8IUkkXn0VRc8kAxiGSWMEZJ/ox2hPTE2XWQ4jLE7S7KginjyKFNyV/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206618; c=relaxed/simple;
	bh=JgV+Y8a/U5HTQuwV4SI8+j4bl13nKeyMADiZ2D5uglE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m1/FIPQ/e4KH/RVG+AT00sXALISR7MgQRVX3gniUu0el8kbzhynjsfQ4T7r2dyNNc32nnc3aIwArSE3sGhCAUEsysxxW93JFHgx5dNm7aylbJXrs0D3wIbcAertgHFCkMfXNB4r+CeygkA1+egH1icRSOxMgFQdfnnUHb4lgKsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sSCLvZ9U; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2mRZIrdPXHAkwlhsXU8/YjVu4D5t53nFmk9zSrMFGb9HQAxERVCiTQIzCS6xzK0fRm+fW1nkyt2Qo0OZAUMQmHCTL9I0HjxooME0sYccgwaNUjRaUfH3KPIotgbyxGw+ahAhwgHiHj90m3jxPRiQ2IEIlvtVGQxsRLkLkUPNlqBjql7olSVKGntXnTfJWdVf0sLzu0U4pq9Uvl7amGnPAFj4/nxscsfgljlLLHcKf2Q3MHA8jn0x/ajLrexIEOi0KKAPYF/ZzPWlLWebwDVjRCrfrDjP2P/5iU9Vf9Lf951GjQn80nwghAcDFkYoVU0EgdCfrf+NCUPf1Qf2C62cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/Ig8+Gc8GyhlMFsDvndSipNwRU0S3b3/VVQddws5GU=;
 b=B5fQW4hZB5AgXSop/D4kb/YxDuscTVEVl4DBRybIUVdpBrlamq3GQSxISWQI7T9Ndd5k320OjU2hH3+qzP6Uop1lDNBt7tirHHyuNcMfnbkCV/gG+wODbqzDTHVG0GlA6LRgK4579KK+XBKsXyDIzxP0GMhjrOUjpmSLs5DgBNFFkoyC+PBNh02+9AgzzVLC9RaZt2Zzg5+0+tqpCrZTaTAItTMjqMdHzWILR/cU1OCtFrScIHrEUeAcN6mB2FZ6/0YyX/FY/p79CuAPJc0gCvNRvt01iu0OfR2IgkpxJ1LMMYmTt1dQcQB4AYzXIiuIstEJop7NZ6dH28C2Xfsazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/Ig8+Gc8GyhlMFsDvndSipNwRU0S3b3/VVQddws5GU=;
 b=sSCLvZ9UFZCWiYM60iqOmLKeznDqgHgnU1F87RAZCOpn41dAlOcTJ2xZMDnPieVZpB3/0XGp6qVP+YNUHs0s9Xd2i4c5vSYo22NssaDzhPvZyDmXphuQUdDIEFTPUjjJ2ZBfkzF6WTSdL1MSgxXsrwsyiQRydSwNpNpNYd0vjVo36AYHqUvKyPXpRA/lxHWBOMwjM0aYs1zbiSvZGCBHoSdjN2lD+N38ZhZuDY3ajjdDUb6Vrds9ewBulSmDUJ1sr5/zP0fgo442qqDc2fnlcZQXyQelGCUza5qg5ZZZyJqWhqh1HVu4vz2+iwkFk0OyHuwSXtp1WgJbz6AuIukouw==
Received: from MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 16:03:30 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::4d) by MN2PR03CA0011.outlook.office365.com
 (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 16:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 16:03:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 09:03:02 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 09:02:59 -0700
References: <agqqK_6PxbvAwsMX@juliahub.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Keno Fischer <keno@juliahub.com>
CC: <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mlxsw: spectrum_dcb: Reject writes owned by an
 offloaded qdisc
Date: Tue, 19 May 2026 17:14:48 +0200
In-Reply-To: <agqqK_6PxbvAwsMX@juliahub.com>
Message-ID: <87ik8jmlow.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bb0758-1a1d-4608-e9e5-08deb5c02b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G5c1WFOl569z7a9ERFoUPESasKe7EGbBtCdtJNG60SZkiGAcKs47jPv5a7tPvFbslh175zKgzK40xGfZ+EIQ1AurGl60mHFW0NwtcMYE2qpuDp3FnUwk03jF2mFdNLVeJcrVJhfLgrWp3le+HCDf1k0RGRzCS8dPgIvwkhdMLwJxyiSkNGXrmrZ/VKg4GLH8Q93oBz+PZhC1NwIVpnZPbifMKkzPc5Ca9JBFsuPl8WqKXVb3wpEJUmoESoTaK2QAsTFAhGYn+yfHz42xHKI0HRCk7P6iFuKS0tLqXHN5mcbeip/JkGSfPDfDajx8jCsdvoIdzICWcVfj4T/qA31sNGd0araeJz7mXdbDtykUU+Nh/TV1uGsXPBcgqxos9UZeP214bL0oMuAhWnDWg0PUQzJX2Er0ZNaKefn8mdIogjGMgcF07Kuz2PJu9vcYR4n6GlTk+hpFOVwZtT+vYalCLfwCLHJYoJvYhk11CBSHeoKaGJ1Wk9UAT1fzL11ndUfYnDCyLsWa+oorvrds/YrIQy17xqera1cg9sTrsDhQtZTZcVwUZ9IZq7S4snDGAAJo8sz6iQl+E/OT5yIb3BDuXDCvYgP0lzchn99FK+NL200Nny/aK5WI+hLuRzcY13hEW+ts7lGVuPLZxd7760G24/RMcI+eKYbhOdJdY+E1t7p0SyKQ3SeGgDwuEbCaKMmpOEucj/gLez4Ai2R+4akEuIIgER/CD/PF8Rn2gok5Qt8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rrq+777cn6yxtRhosaFcoXlGa6+gghRkd19r3ww8dfOyS5StbdtZFlfQaTAveCuMRzM9vXubIhuGbVFLQ337xGPxIqZWAswu7wXdi0bbq2U0SfBqzXy6pAasPviVRUz5Qy+/V4lTnp6Yoq+Pa3F3jCrlqsOKufCR2KwEJze81RMszYYB13ZP5j2TiAlLIr2t3u/f1VfYqmzCTe+kPhd+avIRJBL1Sxb/dq6/BCQpP5zwoWbllVQK0+ECP3BZPTsRkViGaVuU5dVRpQgWc1S8jW5c8mkS6sEtfRVSPRNW3s8mOxRYDrPqpaFJNkLvT6cCadWMiZc9+YDT6I2rE6om0PjdTbcQJ7dL6QRGbc19eGO1gWplaTNVwmxk/o3jnvsNaC0R5Dq0HLXASzz1UlR2kkg9dnw8yitRum3bSKjC5b88XY3YGMYJUQ1vvCE6MGtW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:03:29.7398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bb0758-1a1d-4608-e9e5-08deb5c02b5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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
	TAGGED_FROM(0.00)[bounces-289515-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,juliahub.com:email];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C1A4458272D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Keno Fischer <keno@juliahub.com> writes:

> Some bits of state in the mlxsw driver can be controlled by two
> mechanisms. The first is the DCB netlink command set (RTM_SETDCB
> and e.g. DCB_ATTR_IEEE_ETS/DCB_ATTR_IEEE_MAXRATE), reachable e.g. from
> the `dcb` userspace utility. The second is via the qdisc framework
> (reachable e.g. from the `tc` userspace utility). Because they touch
> the same bit of state, it is currently possible for the ETS config
> to get out of sync with what the qdisc expects. One hard-to-debug
> consequence is that a config script becomes non-idempotent. E.g.,
> consider
>
> ```
> dcb ets set dev "${port}" prio-tc 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> tc qdisc replace dev "${port}" root handle 1: prio bands 8 \
> 	priomap 0 1 2 3 4 5 6 7
> ```
>
> Here the user made a mistake and put the priomap in the wrong order.
> The first time this code is run, the `qdisc` specification overwrites
> the `prio-tc` specification. However, the second time this code is run,
> the subsystem sees that the qdisc is identical and does nothing, causing
> the `prio-tc` setting to stick and the final mapping to be different.
> This can be very confusing, since the same config script creates two
> different states.
>
> I think there's two reasonable ways to fix this. One would be by
> reflecting the ets state changes back into the qdisc, so that the
> qdisc subsystem notices that it's been changed. However, I think it
> is clearer to just forbid the non-qdisc API from trying to make
> changes while the qdisc is offloaded.
>
> This is similar to the existing check in mlxsw_sp_dcbnl_setbuffer,
> which does essentially the same thing in reverse (buffers are only
> explicitly managed when there is an offloaded qdisc, otherwise
> they're managed explicitly).
>
> I hope this saves the next person a few hours of debugging wondering
> why their tc_no_buffer_discard_uc_tc_ counters are going up.
>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Keno Fischer <keno@juliahub.com>

We do have this overwriting behavior documented on the wiki, but I don't
think it was ever really a deliberate consideration. I think it makes
sense to distance the DCB and qdisc configurations that way. I ran the
mlxsw-specific qos / sch tests that we have have, and everything passes,
which indicates that at least we didn't rely on the behavior in any way.

I'll let it pass through a full regression tonight. Overall the patch
looks OK to me, but Sashiko found something:

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> index 73519301b744..c2ce4f3f562e 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
> @@ -2316,6 +2316,49 @@ int mlxsw_sp_setup_tc_block_qevent_mark(struct mlxsw_sp_port *mlxsw_sp_port,
>  					      action_mask);
>  }
>  
> +bool mlxsw_sp_qdisc_has_prio_ets(struct mlxsw_sp_port *mlxsw_sp_port)
> +{
> +	struct mlxsw_sp_qdisc_state *qdisc_state = mlxsw_sp_port->qdisc;
> +	struct mlxsw_sp_qdisc *root_qdisc;
> +	bool found;
> +
> +	mutex_lock(&qdisc_state->lock);
> +	root_qdisc = &qdisc_state->root_qdisc;
> +	found = root_qdisc->ops &&
> +		    (root_qdisc->ops->type == MLXSW_SP_QDISC_PRIO ||
> +		     root_qdisc->ops->type == MLXSW_SP_QDISC_ETS);
> +	mutex_unlock(&qdisc_state->lock);
> +
> +	return found;
> +}

From Sashiko review:

    The check here only examines the root qdisc type. However, a prio or ets
    qdisc can be a valid child of a root tbf qdisc in the offloaded
    configuration.

This is correct, ETS/PRIO are offloaded when under root TBF as well.

