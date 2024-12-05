Return-Path: <netdev+bounces-149354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652559E535E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5728C188287F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C491DE2A5;
	Thu,  5 Dec 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GBawBv3U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5A1DB929
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396869; cv=fail; b=s0Sf2F/X+FcnWPhHoOjBP9xZmv4e4026h+dk2iITVPpKg0eSNI24NzGzGe3uHomYYjvvAk/YXVvlVSfBGwklLfV51wwm8aBhl5ohzxy4fv/vgxyruC+Q/QXW5FmkWLKTaInrVhqFoF3fPYoLyC3uJK/MnsWHuqm9VTMqibkQ4vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396869; c=relaxed/simple;
	bh=kyjC0/Y+L7AWQLYmJhPy4v2XVOdeTXA2lmyeZV/7fI4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rBdqlosm5aNOGcPNpLaG6UCTfR8n02qRgbqGSORkDb4u5ZTREovDFHYF6xEyjl32/1bZKrswDanw4OcZ8Lzxsj5bwzW8t6Ajbau/ibsCHLQR7cQCEOgfOBLeIQkl1R+75NXCM64IQhsKdwDpGiQiy6i7iviTnftVT40mpEioayM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GBawBv3U; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwtdRRzsUYhkWiwDpKpYKuSBEsiSqdRMzPexk26qI/WIlOpM+/EbbKh5Agt0VOLcjNleHXdXNWwf3RswdMzY/+tFJQyOErFvy/3Id1MOM2J/zfrOiNfQcx2yZexPx+vtnDGChznb9JJTIS6HDNo9wNsy7bLLYYlQZwQTr3tQnv1ao7NmTE99vhGcKis78g3/jbGnW+iutvWSGFlg/msgL4yP+PmbFZwvEyRE23yDap+HG1q9Etv0vnPdEvVhF6UF77M4POKpuVmWXm4zjWs5r4h2kYd+H167xEWd/QnpIwlwKdxq7obUTAT/uVtc16rwiMF2/vPveBjKIfCND89bSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW8/F66PlgbILuiA2iy717+UPRtOSx3sCbI3S1J6VVE=;
 b=yt6pOVc9stRcyxt3sF9j8HE4w9z1+F+90u8Ycvb1QtimZBFUXXkb6vzkoHXuQe+VJijwYO+7DP1airPozE6uFr79vYFcIfNX2V9DHoaAO3r9FDqT5vBTnljmgcjJ2mEQg1jaKbPe2gvm83HXoAjQm+J7sRfn0NUNoIanBmW4SaONQ0Cq7Bluj40SiomAx2OlRJW1mkwl9SnxFeWmMzKcRSKiewoqwlxpzyx0P5LYhaCMBsJw0g28OcADrKCDuNSf+xtxrD+P1mdzdmy+NdHqVuOYUd5Ti+3MUeq4VEZPJfDxjHenPcy48uMR4xxKD0MPkLDbkn9fJLYECcMtwDOL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW8/F66PlgbILuiA2iy717+UPRtOSx3sCbI3S1J6VVE=;
 b=GBawBv3UGZKc/BjACW541A5QZTzcvYiVMDoV5Nu3cTr4lFg82712wUvt9Zhxs0BVpkGCwZfY5L/5GZ1sqiPNPzYaOD5UEYVnH9SLkMKeO9LgHcswg/F4fTYS52wZUSY+ld2BbyQPorBsmDzlsf5AAyWI7kP+klxIvN2TM797liiHK/A89PXyEiSREpCGAGHe2HlPSLZEXpdufO6hDBkYHdgsrDbt9bDfFHp1MZqKc1PvU6WNGSwLAMTRTuaIP6y+OmpJ4S4b07Ot7hOcNBM7FiU4+DETLGP1ofkmMDMgoQkKw7w2CsEzbrBSNwIPEbCMMBhsBZKCxIL3jl41Ng4g+Q==
Received: from DS0PR17CA0010.namprd17.prod.outlook.com (2603:10b6:8:191::26)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 11:07:41 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::7c) by DS0PR17CA0010.outlook.office365.com
 (2603:10b6:8:191::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 11:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 11:07:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 03:07:32 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 03:07:19 -0800
References: <cover.1733235367.git.petrm@nvidia.com>
 <d28c09cf04d210255882d7f370862f60e8f7fdf3.1733235367.git.petrm@nvidia.com>
 <6d317ad7-84f4-4cfe-b7d5-22eafada0f17@intel.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, <mlxsw@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net-next v1 04/11] vxlan: vxlan_rcv(): Extract
 vxlan_hdr(skb) to a named variable
Date: Thu, 5 Dec 2024 11:44:25 +0100
In-Reply-To: <6d317ad7-84f4-4cfe-b7d5-22eafada0f17@intel.com>
Message-ID: <87ldwuie1s.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 980c136f-bdd9-4a80-e891-08dd151d095e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UhEluFrTYXXk6z8/vkXDL30TC9EZCGbRxDYDzPmN3HxmdRIg9o0g3sqovvi?=
 =?us-ascii?Q?6cP0I4ZpUSyfuno5Xzlgj7W4CC4nzLHoQxLeP3VqN8PoKslozSLYGZVe5nKH?=
 =?us-ascii?Q?3c2ssLYjoitN0LPjgtkLKFHhMV3dS+kaufd6j/28v4M7T0wB6r8TB7hyUuHs?=
 =?us-ascii?Q?HGfcndzHeclcuCA1l3xz78v4+lIyGYgVk0Nnx1wsyE0SFYRe4AS+XyYt5URw?=
 =?us-ascii?Q?s7RcKu2OfJZidkXZI53II4zlUoql5fhb+aFAEbG0CofeFqXCIvqsBUwVT4Me?=
 =?us-ascii?Q?voliPeH8jaq5XVt5rdxycCOUpiNwATKR+d2d02NhfkyAGurLE5LVODdjq/uy?=
 =?us-ascii?Q?XYd7DHbU4D65UcTPalTpF42bOSP/sXhrKFQDfA0O883CQtRgUQOjYcNOCfD2?=
 =?us-ascii?Q?2Ql86Ph6BN+w10+CVQuUrOxA+2UN8zfjEnTQV8FpFrpKUMWvoUqLmhX7QdM2?=
 =?us-ascii?Q?Ni5Bc/HEGnNohsBPd19R6KkNfWZaPvvpAC+1pm5QUoI/UVUjgKVU4Sfo6i/X?=
 =?us-ascii?Q?smplFTuUs86MJPkdvny1yI5S37m3p5+0D6XhCjM4Ai3VSHpoAm1G2ZGXLXpP?=
 =?us-ascii?Q?Qt+83/tyeeaAFyBXB7ZEN3F3Wjpww9jesm1i2Fc6Ks4NfgO2njx5Jt5PUdFs?=
 =?us-ascii?Q?TUhYMelBPxUI6gzy+owWq5vngyyknRRjPWVenIAX7Ga9TafrFXuXNcIVTdoT?=
 =?us-ascii?Q?UQ+C6PXOj5MPA8splfYg5ypHEtDboyIQwXk8nY8zIJTqMfgoyjBtp99qNJa7?=
 =?us-ascii?Q?pmslTKDlvWjjzKnn3LHbmVsa2WyD6IX4swrxyV79raDylqx0BsGfxQxAlZ/y?=
 =?us-ascii?Q?tqFovUszkPRjtFjl58dQqTlj35Tyab7gmSNg2om+TJISDHNSrJ/JndBomlO0?=
 =?us-ascii?Q?VM71PRDwaEK451k6JJxXvwnIg1rJO8UCpWksW+u6mdPndfA+HS7NMbnzenz9?=
 =?us-ascii?Q?sHCPF4gi8trB5asiDplWPXIT8A5zM8cV3t1Nlvlx94eG0zIV63j8T09bXxkV?=
 =?us-ascii?Q?/9QQKJG6diDFl2iMryvR1eeTTOOu0vUubbU7YEUsaYk0oz8KhP804b7uFMUM?=
 =?us-ascii?Q?fwUU4sES3JgbquVrRFX+I/Aqq8WtrmMVEk7tRslxDOvpY4mEIDZqFX6NkO7v?=
 =?us-ascii?Q?z5QXadLBdK148KAvrziQf5MSpDN+iERlDT7BDfGyR1VzUdT379cGoD0NIzxI?=
 =?us-ascii?Q?EidGL3omcYNb9ZJrPhmC6L6uxE8YENZ3219ls2XS5UARTEn68csXANAt1lT7?=
 =?us-ascii?Q?wgqAUkSQQwdSdZtoa7qtLmESqi5mrjSx8X00bepR/inh25XZ+VTaDYI2M6n1?=
 =?us-ascii?Q?ozXpgB2+upks7V9L1U2Hxknr8YJZF90SE90LmIDPZ4uCil3fT4uUOH6wu7+Z?=
 =?us-ascii?Q?kyCvTBU5/Jw0Q+kK+Xf5CUp2QPu7tKMG4jmQQQkQhOBr7bpYhCAGJJyp0rti?=
 =?us-ascii?Q?3GwFZ3G7Kr7d/aE3Vl/RevAbNhRNi1d0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 11:07:41.0521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 980c136f-bdd9-4a80-e891-08dd151d095e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522


Mateusz Polchlopek <mateusz.polchlopek@intel.com> writes:

> On 12/3/2024 3:30 PM, Petr Machata wrote:
>
>> @@ -1713,7 +1714,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>>   	 * used by VXLAN extensions if explicitly requested.
>>   	 */
>>   	if (vxlan->cfg.flags & VXLAN_F_GPE) {
>> -		if (!vxlan_parse_gpe_proto(vxlan_hdr(skb), &protocol))
>> +		if (!vxlan_parse_gpe_proto(vh, &protocol))
>>   			goto drop;
>>   		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
>>   		raw_proto = true;
>
> Overall that's cool refactor but I wonder - couldn't it be somehow
> merged with patch03? You touch vxlan_rcv function and the same
> pieces of code in both patches, so maybe you can do that there?
> Squash those two patches into one? It seems that in this patch you
> change something you already changed in prev patch - maybe
> it should be done in patch03? Or do I miss something?

Look, I'm juggling various bits back and forth and honestly it's all
much of a muchness. There's nothing obviously better whichever way you
package it. First changing to open-coded vxlan_hdr in 03 makes sense,
because it's already open-coded like that several times. Then we have a
clean 04 that replaces all the existing open-coded sites, including the
new one, thus everything is done in one go.

I'd just leave it as is, largely because I don't want to touch something
that works for frankly cosmetic reasons when the end result is the same.

