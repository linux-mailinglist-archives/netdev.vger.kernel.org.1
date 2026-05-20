Return-Path: <netdev+bounces-289844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE2kGHd3DWokxwUAu9opvQ
	(envelope-from <netdev+bounces-289844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:57:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C858A40B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BCFD31BD3D3
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B33B38B5;
	Wed, 20 May 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nfKwdu3D"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAED39BFFA;
	Wed, 20 May 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266193; cv=fail; b=XFvuHHmEk47Uihem+P1xeNPpy/dCj7B7PokbO4i4B8k1mPKR1AVWmYwKGlDMD94l+yc9sysix/VrJrfV1C0ERGCX2APvKgcIAmZk7AnfxaoO1um7QzqUfevdot/xu8QDDCwmIz4H9wk39EtuT1OIwzn7WZadwvOWVJoSZcNjKII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266193; c=relaxed/simple;
	bh=hdZaoTCF6zRHbRwxpdhBx8zHcdvy+3s+wA7HyvhBiE4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=heer2QiC9Tu1ARp2sTUxgTgFSH3gfzUlx3Ty0H9jEjvdgGbZ79i/aUWUXib0xAXTFIeT+pMPNsZ90MaYl21rjHmpKxTVdnOh/8YTvvpVr6KQd4zBY+YV8OxRHfEeeASNNqL7HFdeH7xhTP5IZtW5/f1/x2PP9Z2TLBoHGSQusjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nfKwdu3D; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyQmhdb3rzr2EwPKbf18C9wdzBgdXbwdq7wnUiYcls+vznfIp1zC862CqxhIBw9/oDgefWmGdHmLRjQ8Ay2E8sRF8EjhYGOUtVTfpMg4YB+4ZsZI2Eub0ic6yP3xpmJZTnQPW1uL6P/fvyl27+vFHA6JbRbrKzsEbA4XBTxjcWpr29SIjv65CV2rhLcts1cDd8hILLrmT4vLZ8auygc6H5iS3QuGiy8mm1Oqcc//2FRlY4a9Gza6NCgkNwlH3asCVEMwR4ZxBye0tbaI1e+OA5fRI53VqYGJmqXx8T4CxGKRE+potcKwyTLZDlDawEjaPii59HVIlsj/f14cZ3KUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdZaoTCF6zRHbRwxpdhBx8zHcdvy+3s+wA7HyvhBiE4=;
 b=bqUnd6TBdDavRxjBBR3x79QqdDZYhliJnDT4q2eaHlsV9e41/4eXXeeK12gW/O+QOsyVCi7w6oxy9Rz7isqmpfRE9qx1FaxZbgmptRjy69tXBnC5ETj2Wpm7ogIWcqQI4PPGYvRbn1OILMcCN+0hVAZoJiCYEFTuzMrML5qhWmjRIVHU8SQ/RVGyfiu+oF+Vk524ssUiDou/1wo0Oif7E5cEN93yYQIj4T8IXjb116eB99TZ7dOFtkV1z6zSNihdhQpis9dvf1UB6rVYh5KdZfgfx6bD9xTBzx4JYUCRRCDP0bfB/JncFz4uV8wTfSAXGa6Dqfkc3HrekADDqNLDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdZaoTCF6zRHbRwxpdhBx8zHcdvy+3s+wA7HyvhBiE4=;
 b=nfKwdu3D2k/H2KxsNyhtHgD3jLdbKwJmyqmXVh3vzsucldXliTV5CDDlj5kU5NrUace4Q3b90M6k6bxU3AQooewGq3csmZsyMAU0PUSwDCNDVp2QoCi1Clkrag76gYG8B47tkZ1wlZnI7rKZocfBpJLjILvuBAYoTVWIx+58xpQtjiPLHrWszgnUVTEuqybpm00lQWtSg0YIfFCXmul1h3RzG2BPLV6Z58MnzEPoPHXKnK62MygWCT9xOcpVZKop4hxyBPMe5REkNk9bEWpnZAoHlRWMJWflI09Sa8oo4BlSc4iYCbE0mZI3ujLvo5ETSut5INMooveZawPySgLeFA==
Received: from CH0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:610:cd::18)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 08:36:23 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::43) by CH0PR03CA0103.outlook.office365.com
 (2603:10b6:610:cd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 08:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:36:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 01:36:08 -0700
Received: from fedora (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 01:36:04 -0700
References: <agqqK_6PxbvAwsMX@juliahub.com> <87ik8jmlow.fsf@nvidia.com>
 <CABV8kRwnfmc_xVEP5e_9mq3+DMpz4tC0AYSamiJysgG2GUoaKg@mail.gmail.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Keno Fischer <keno@juliahub.com>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mlxsw: spectrum_dcb: Reject writes owned by an
 offloaded qdisc
Date: Wed, 20 May 2026 10:35:15 +0200
In-Reply-To: <CABV8kRwnfmc_xVEP5e_9mq3+DMpz4tC0AYSamiJysgG2GUoaKg@mail.gmail.com>
Message-ID: <87a4tumqa8.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 370cd85e-cfed-42cc-81a0-08deb64adfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|4143699003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	V+I7P0ZEEYiT1zcweOQk/JQE6I9zxWiUqQ8mfO3blJOOvF/A+AwAtRgA7JoNq+i2+XJ6joocJwiYOgnOA01lY3GL9cyOPdrdFB3zFs1D1oJHWweHYIlWq6DvtdugXH+5B/ie2GL41JvoMB3PVsLraEJIi8jykd9zVCcIY3xn0DGPHOcmn4wU+VwMv2q/P1UZ0UIi0Vv/nEfFJd5ByLq8sFowPJcrunnWsKFWeq6eyu6/ND97J9jZAZOv8QYAlmZi+ZQixD/ojBdPWp91UHA87wdwUh1a6OIb/8Bqg1UsJi1SK9WvHezHOau0k2LAdIxv73jXhGoy9L1zSkQy9enzCtwnlsp8V/A+5lMKJf7NdKYSMwvH4mJEn+Ieio8K5Y17d15lrqRvmIQhhrYbZZTGK3LDzF3x4nr0/16pkVMbpXzkp+8LWvh0CaeoOEYnYzfiPJsx84tSdQXmUjlyHP31S/ckz8e/x6lexMOLodoZ0AVGQbqq2Ktfs46GQBltvYpVPQIZRu17uM/JIBfxWFP7i7SiMjn8x9wJrSdm83P+T3Q5h0fme3v70bCnRuRTPY8cgutujx1sl7cyrB6KDJI0sd5uFB436ZAnTU/OkFWwML6hvsfbT/ukThJrSEkkSj+IyXMbFvWBSjmxuJkWu5hOXW3kEgGCrOkutu6eubqXRk7yGNQBV1bfmZWF+syAxoFIaXd44SJQyjaOkkk1hz8NkuKrsW14Yu5VcguLWwcYKRM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(4143699003)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ojpw1zPyKsjqJ711q02y6EJn82+QhaKiF90VBZ/CQgZZtf5j8XMkpCQOzHzXnBzOgWSAxdJe5pEoxcnjx6YXJJifhOMWOjIQ2IfdUmfFrevd2ykMX2YIGhD8TgC7HMPVR1t2snvhfcyJP+eCah0azhju2FD9khi+U2WfAnfjVbfo14WXnqRZe+wxZt5QfcTIYUxtfbTA4P+tKgrw3Y5ozXCDfW5bPzxxqqj7syStccvbFRtcvs002guMpjxWqU7MHOjAYxTwfXPXhY6vAdXispfo80uYnoXRQksjqD0wzHnMzlXVxLv4dVwSF2oS4uh6Sq0bRrtYiO6nZZ8VgT2UGe95QYbH0EQS4wvf9Hao67HEnDR3z0bh75+bDPF9DJ1LDStxAUf67BMoQRvf9cIxzLC/ECtzobfFxPOyc76FsY9RZJrjMVvK/r4+e+X9nghD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:36:23.1968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370cd85e-cfed-42cc-81a0-08deb64adfe6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289844-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,juliahub.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D18C858A40B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Keno Fischer <keno@juliahub.com> writes:

> On Tue, May 19, 2026 at 12:03=E2=80=AFPM Petr Machata <petrm@nvidia.com> =
wrote:
>>
>> I'll let it pass through a full regression tonight. Overall the patch
>> looks OK to me, but Sashiko found something:
>
> Sounds good - I will wait for your testing before sending v2.

It went well -- no regressions.

