Return-Path: <netdev+bounces-77084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBCA8701C9
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4339C1F220CE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760813D0D5;
	Mon,  4 Mar 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kdrZa2xN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CB3D0D0
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556348; cv=fail; b=IGE4eRl+ttOFP9szNUWVvrW+ZAvdGsvdu1H6i9LhD/aLHOXVmLPhjUiWPo1O5FjyU1esDlXLRzEsRuVFE18zNE+2InrgqqOq/FGDI9oiZHd42NeoYD7LJmJ5Xl99ejLspSeEn8l2Mq53Y1XDOTehlrand0lqz1Kg0U7VzH8XdT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556348; c=relaxed/simple;
	bh=LmEWYBAEJ2bsqeMZovzFJYC9Xm7ABJngk8LU26k7Qx4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AuQ4+XlSu3ooPT2Vo1IOzUA8V6CIt5TWPWfhRoLkKtnXDEsEP9Jqu3ZpNgkA1xRn5WAQC+KPtUBBzudOguMJVLyuU1pvdSSprCviRkTF3W/F5ns+WOW+CbrvvYhnqbwI8jeYpDPi2vw69GKITSH5tKbO/D2/0h1Peu6yrGFsEqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kdrZa2xN; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVCPX0Lgmoskd+nD0ZTGEZaAUEQlFfJ7nVYbMKx8EjRk+EwpeHpBVchfL1AZxoEGJGqnjf2aYGmn7I2RUm0N8DiyqwIkKGn+zZB5yn8m9Bp+222Tn2hMds8qh+vAB4G8SslpdsHK9X6Heb9NzKdrWZzEux4P3tj7rEan6NN2MhebOtjCQjZwYSxT6nUf88nDJXcF91WvDmb957OQCmR/pJyzQJm6QljioWdDtQTCHPSibpeIIaUTDFXXhE7UV4mBgmWsKoopozOxen2AdJkPeEHVWFpC94qzZeterBPzmI55UGg30nvjuWCd2v3uxCJ7GVUlmVoFPw44h3sdN+YfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdyWge5IMvJDpOACdgfmK+RdthH8xh6ZvZhN8gEVrec=;
 b=iL/jf3H+rjbxhiQStcI35z69AbNDd5dd6Jc8XhVzmImxGo+CQa+Vo56gmxCWo6nmcgGfGq9eYxD/Sfe+bw7DyFVnqGKVXcoAHx3w4X2glirgN67B/ZJSkzInvE+dSCNl/ZiZUzgOqMCgF+7pmhTH9ukyBGnRV7BgE2OJ3zOvfR6GSFXiQaIF07yo81vSVHXbYe0eIT1RAjgD/BcQd6rhjFX2oaj8xoI6KyJ7GZkOl/DWJNRTu3+qwWsgZQvmHjVSB4IdO7rhlY86hdTzuyyQ6qD+FLwyb4icVywKkMmVaAbsvWBLE1E6FhE1lhoZS7YVpTTexFLlIVAJWa9wyz+jbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdyWge5IMvJDpOACdgfmK+RdthH8xh6ZvZhN8gEVrec=;
 b=kdrZa2xNmKWNkyODzCzqiRiaIKyA6xCoWT54ZAs3h3rApohN8BzfSJjwMXg8s4mAMsjxlsmxsnQrGDhVTbTQinGMCh3Y5xKM91jP7mEH2ioIX/A//XI6vo00JuOwqIvd9O4aOQlhJM5ulRmKxxcE8YNFPHcADzEiwH4OpllO+C0N0AA/jNC2YXICB3xnpQ2zn13KIBJUG8scZaTQ8aryD3GRYGQx1V5C8azzP+l8u/0RgXP6JCnIghXiuFxiLWY+5NIFBlpt1Hq/rqxvzy1gSWqtJ5HFfh1JvWj4LDDjCDfuUEwT94qS+GTnMTarA2mrL+jGaTxD13ASK18WO8Ca7g==
Received: from BN7PR06CA0071.namprd06.prod.outlook.com (2603:10b6:408:34::48)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 12:45:43 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:34:cafe::25) by BN7PR06CA0071.outlook.office365.com
 (2603:10b6:408:34::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 12:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 12:45:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 04:45:30 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 04:45:25 -0800
References: <cover.1709217658.git.petrm@nvidia.com>
 <223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
 <CANn89iLDizzEKi7u0NssSXD_rB6c8EeL==ino-O0a2_BxUN5tw@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 4/7] net: nexthop: Expose nexthop group
 stats to user space
Date: Mon, 4 Mar 2024 12:09:41 +0100
In-Reply-To: <CANn89iLDizzEKi7u0NssSXD_rB6c8EeL==ino-O0a2_BxUN5tw@mail.gmail.com>
Message-ID: <87a5nemahr.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 543fa97f-6863-4f1a-f569-08dc3c490165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0fYSSbCn+AFAl2w3GviCCHEe/5qxEk1PEOoScvEAq2F+ZxRSzZ7QPPcJekgcwNiDHvl1GrBBf8nugZIIQ+4jluntBUInuxqlvc7Ddx0gppWaSGs8kvc6IMIpuYuVicYw1TbHnnXI1eHBY5S4d2G8dV/X+UhqEdl6hR1lAxnBbdZhNpoTJwxylOzRK/po9vlxhEI6TyOzukfM8R1XC2PEEsNSBEGs2HLwyAKjMgWTNDRSRftbFGefhW+w2siRy+RBD7bweS7KWjEJGeosNwie/Y0PAhsTC7UUMLfr6VwGYwIR00Q05/6FuTsHcgbNkFxegJLZu9jLlXndwXAOC6Nl9aTrmyNC0BIlY3onY0Q+K5WpgmHyXERVdCoBnUVoRu7I+ThfGq/bQR2WWEoj/+f3P4PJpYds60dDuE8OPFgfu+5bsLQ5zLCaateO5t1TncCr33orxVHladrFxR0zvhdn1cK9MM6j4uHvTyDrAA1iv/jawvr+q5XlokwA/EHpEtUG4De0Msr9dZNc5TAlWeqKgqrB36nj1jQTkq46P8sr43ruHfWd55pkw2klJ9m2K8tQUmDqpDkK8m13K7pn9t6NUadvK7KTMQta6TIcjsUJe+Sd2rehr+HSHVrYwjI+zeTMV/bhxPqhkfRFAU6OcCD7cc+GcseRfYErRvKASG8rMnOkO1feP9d944XDONPLsHXN/DuZC121ACFL0eeNSAQ9Ow+46O9t7zviHfqF+mnKA9DK1bH+RcW++953K7PKGo/R
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 12:45:43.1474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543fa97f-6863-4f1a-f569-08dc3c490165
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380


Eric Dumazet <edumazet@google.com> writes:

> On Thu, Feb 29, 2024 at 7:20=E2=80=AFPM Petr Machata <petrm@nvidia.com> w=
rote:
>> @@ -661,8 +663,77 @@ static int nla_put_nh_group_res(struct sk_buff *skb=
, struct nh_group *nhg)
>>         return -EMSGSIZE;
>>  }
>>
>> -static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
>> +static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
>> +                                   struct nh_grp_entry_stats *stats)
>>  {
>> +       int i;
>> +
>> +       memset(stats, 0, sizeof(*stats));
>> +       for_each_possible_cpu(i) {
>> +               struct nh_grp_entry_stats *cpu_stats;
>> +               unsigned int start;
>> +               u64 packets;
>> +
>> +               cpu_stats =3D per_cpu_ptr(nhge->stats, i);
>> +               do {
>> +                       start =3D u64_stats_fetch_begin(&cpu_stats->sync=
p);
>> +                       packets =3D cpu_stats->packets;
>
> This is not safe, even on 64bit arches.
>
> You should use u64_stats_t, u64_stats_read(), u64_stats_add() ...

OK.

