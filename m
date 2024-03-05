Return-Path: <netdev+bounces-77439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C0871C64
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6698B1F257C5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06075C5F6;
	Tue,  5 Mar 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qHN2amRv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FC5C5E2
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635959; cv=fail; b=HFfwR1kdssxAVXBDLHgtmISLjUUateoimPMFmaqf9HxCw/Nl8zUynqiItxzWw9iRfuSoQRdh4eN/EbWzQodzq/fQOdjSx/Sswlwii3udQqdoIYM6BkTCALFVp1PKEM8QEVkqdBMja5n2NkfTuh5eyVhd+zm4ELDobvYvqJzocjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635959; c=relaxed/simple;
	bh=rIesRL55WNHr3I9u3UfuBnRUgOgkmi7MX/DRnLBdO+A=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eIiwwSiUzPQdXAYBSGIzjHFWAFyZq0RzKLMg2o03+FFcIHx2+S2pypEUE9NJ8KTAiX3wrHmzKNrm+hbhV44GELCggFdXkvpjrQhVoyDYkvww+j9x7XNGCBc0QzAD44PfOOr8Ozj0mWlRuSNulADza6hr2glveVqJgKLmjQtQFJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qHN2amRv; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD5w9/WMBwswJhOD10yL9DXvjNFu/ehOnwk5ntPWB3Vos6oDJAiJGgTe8kODzo/Woqea5/g+BzfgK5ar/94b8vH5g2SgfktyvT1JS8tzuhE6ZpP8zhdCdiv2rNYTMVjQ+9AmGxEqMgDvVj731VGXp+OeuqERc0l4oHajt88Pi79pBnp4EqKY9eaP4XBJ4h7s2nNkD8H3/shBWlG6Y4vMBdZ9NJZ3qrdQgZjrb/PR788H2mdKKbgkkaMp+XpPC3s58VC9dztrpTTgiwznNnX9S9hkDP2kNeqZSXwU2UvIXjG0F5twuXuRqFEIv2jXH4avXPvmIIlQqZ6sB2DOWOCLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNXB8IRQ8+0hD4z2q14ZQ8uAfhXTMQ0J6P/NC2vIcLw=;
 b=kSnMS0FhbG2bSCrxV0ixoQ6d8AV8i9nhfYwdCvS/I5yPnVTOg8ePHTzwv95DCQ7o/n0KkgJ6Coc6RbOrIK4IVJqg9ZMYstTQrP4i/h0Kf8svQCTMsqio4D8hJM+I6vQl9BfAL3gdTSlNJkI3CTdZ9URqQAcVvehkd+JETmMOImFHEVY5LkvFbxl0q/A98U5CqMOK7yKR3C0SPVGgCZscFjkhbqAFz4kG7NfX5BFO4V91ZWAZWeXUeSCj7kEokI4d2bBkAPkpA+c2uUWNVLZwbympipxFOCwwcQQZRm98kSpDIhxw/utacCEyT5isJwtHsykydDDpM4vx1YNPHm3a2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNXB8IRQ8+0hD4z2q14ZQ8uAfhXTMQ0J6P/NC2vIcLw=;
 b=qHN2amRv5/JssVci6wav38ZjA0KJ/UXAvYPXVQ5xMxCH+LwVAjPXC78TKipvOt45CK1DYB9/dNQjn3zJJoPaNMU6/uFgKHt6bTWvBn4X76kOOL2XWtZr5hErxj252d4gS3UyRLEdGkbdKsPbBgIEfzigF5kyIyEu0sNd9xT3ThudIctckJ5uzl16sF3M8XBocSNq1Li0iTkw6hu7JJj5oDrpy6bVenj3Dn96dsE0dxea+VpNW6oErXK4s66NsDJI7UyZzYPhT3XWxKXAx2CzPlRZ5eS0frJag3fZ7ddpqxma1oEvVHpOa3wKp0/y0deNI5Lf84KlMap/4bEg0XMRrA==
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 10:52:34 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::ea) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 10:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:52:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 02:52:23 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 02:52:18 -0800
References: <cover.1709560395.git.petrm@nvidia.com>
 <46fd3a32ea411c65a66193b7e25833ecf8141326.1709560395.git.petrm@nvidia.com>
 <ZebaUyYfghHnwG8C@shredder>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v3 2/7] net: nexthop: Add NHA_OP_FLAGS
Date: Tue, 5 Mar 2024 11:42:24 +0100
In-Reply-To: <ZebaUyYfghHnwG8C@shredder>
Message-ID: <875xy1lzmq.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8296ce27-a391-44a6-5bdb-08dc3d025d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5+Mg4miSSLyKjZqOPd7SzwnQQTbhDjzcYeBm25SWR1UK31y776l9JWhYZ647wirROrgs9fPith2JlGBTGN24zb0qgZEQ8A35F5z1bzLn2ZYA/g1im9wzpyF/CHdoMWe6dSLncvvPPf51tQ9XBZcvHF94//0WaD135QgyvRjZ2hTamDgK3MOmfOncgEsJlHSx8T6SjVPc7XRNVKghSTZaS2Xv/+LQVAaX5NiyeF1R/zJWhxpyfQ4jqsoe9MvVoPL+79NJ3vuO7ZmfifPYAsF3OIT2B7UojnBF+sK4ZpNszmy2C0HEeune9v2vPTHx7gvGrzkc7Io26w82G6kS92OLeeSQBlRkq/6u6Iaopi/+ZHirLhubJg4Q24vpxOr5NpphObuc+ksO8z6D15j+h7CUnyIOanRBRDMcGtuvLKB9A38fArTXAmKaKpV4VM1Kh3gGcCZKNUJOqhszf2TVc50ss0M0oAfi0UY1B3qEUjT4KlZTiiJfV2z1O1gif8kJ4DyGij1ZrQM0Zyg+SE1EyuhKvyRpiDnbhKnrUAqmDoX9scQd6AOCR9CbRjsADueLcR0Rnv/E50bbYkZPmiXYMF/CKiTk6T03EzjfXmznzi1w3pFcT8/mdPA9ACJ4S0P2Nfml0U7Wu5q/mMumUJDqyMrYCGcsp0d24rpqvQAPjsQMGus8G3sNuVz97H3DO56xNxSa6fcZwMxNnAS/td0lFA6PckmYuvxnbTCBjd35yhxLrtiKnyEqXs+1CasX0IknSM6R
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:52:34.6248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8296ce27-a391-44a6-5bdb-08dc3d025d89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451


Ido Schimmel <idosch@nvidia.com> writes:

> On Mon, Mar 04, 2024 at 09:51:15PM +0100, Petr Machata wrote:
>> @@ -2992,6 +2994,11 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (tb[NHA_OP_FLAGS])
>> +		*op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
>> +	else
>> +		*op_flags = 0;
>> +
>>  	return 0;
>>  }
>
> [...]
>
>> @@ -3151,6 +3161,11 @@ static int __nh_valid_dump_req(const struct nlmsghdr *nlh, struct nlattr **tb,
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (tb[NHA_OP_FLAGS])
>> +		filter->op_flags = nla_get_bitfield32(tb[NHA_OP_FLAGS]).value;
>
> Shouldn't this be:
>
> filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);

D'oh, of course. I'm 99% sure I changed both instances, so I don't know
what happened. Ghosts :-/

