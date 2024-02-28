Return-Path: <netdev+bounces-75658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CCB86ACE7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A7D4B2279B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4112CD91;
	Wed, 28 Feb 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dyKq/29Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C912127B4B
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119448; cv=fail; b=TnZKbw34tjmhu/RHUzppE2kl21Pq5xI3cSrXnNhKG51i9CFC4PzlNDrGQTQS+o3aa2ctEX1f22y9gCBMKCzQC7fJ9VBFsypB/SqkVW1LO8lTIDp1XI84R7Ccfyn6fTs/Pl3/YtQ6edpvZb0Uw5eORgbOTxkMiEjvjrZfC2bl0IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119448; c=relaxed/simple;
	bh=f5WpmGwIPZUchW5M8kEINEEwPoS4w6fBiN9TqSWM9mY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=in/TjOO76MrAcYgSLKMjPWqaDOdtKu/yxkdJY32WfEnQn06JPEh+z5myKvO9Ur6FBBdgkUBqh2g0ucu49+JkdsbY05PUEJygR9hMKNsyK1etAULlOOkUdrPKosXKgq5+6vs6cajWhlWX2Rwu2P+5xwS4NijjdodvpoISvfsUIRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dyKq/29Q; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgwqo0Bdz9o1WxH7+boYEbvHxZ8zsuuPuTIBYdbF+OmpM1fysIxdcAA+yGrbWSXs8Ktk1uEXPBRjPipnC+46o5o96EsQuvpK6aO9PYyhwXilDr2ZWEthJT5LHHS8716tROTGOhWGNsGo9fNmHYVI74l+51PxeUrTA6rzLq/vPlTinGODyfxQm72kd2Lz9hWDl0zdBrsDn7BgnW/02fdNkSM9jmMV9vvuMFAkiHX4Q4GV5NRP++cYXWi0o8PaQGdg1+nro/ITkoRuRYRp+KpsYxhoW20xlQ3NplV3EpMe6JEGiqrhDA9dgjYp1Z6bAEd32kwOrpUtqMWJLy/FgA8dVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yst6ItXaxrzknQlXGJj8rVYC93om49rGHMC25YbebF0=;
 b=Iifuv6/+4op9GdybjLJ2QVEV8qSxOMNDh0uRKpil5U+nhTGXEd3Ww9oh8Uwtfgz2VvADBQWGm+tx2liVZ4mB6aKyb4GlXDNECODqLyAaBH3A+vFqvjkbhwaksstPW0eIwRkNTfSVPaIsncWbwu5MHkpF1I1FjsYGfG3u1/Ei234dp0cLDABmO/NaV4CRm1cU1Tg+436EH4tDU+8X0W1v1vMaeGh7GVqZLtUuwkLOqZvYRfvK2w9K1kWVIbdfMOgD0IY+009gzJIIg6esQW4ksNubltmeZnzV3eF44Bqp8KZS5M5FZGBNk1gBLCRjPY9Bz1J+rPSilB9kwudIOCD3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yst6ItXaxrzknQlXGJj8rVYC93om49rGHMC25YbebF0=;
 b=dyKq/29Qul1vtgQR3p9Gj4ZZIoabcjB+nXxY2boKjWcN+Xvq0QbTXbdx7r9nlGKZJ1Ed0epvrscHtdYBdYJYGrfRU7cFICb4amrlE87WOIxhnZ8Wvkx2ETPxlqiYp0gfA4cFCW1IFJOF/WN6w7kn13T14U/YRpqKwZazFmhAqPKSeuKnWLPMa9mmKwv9AcFSOKKlAX9qNaK9Z8vQVID0HSaCTtezrduO0CWbbm/IK2XyzbAWZlxPSDpzZPXpHkCQbcf5IHKhP9kXIiIMVHdgmCrN1wZr4+vkl+9ZXCpZ0G0yJViZICIs9NMT6/nJPUKFdRDBDWy6HhenYq6hXEm4cQ==
Received: from CH2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610::19) by
 MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Wed, 28 Feb 2024 11:24:03 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::a8) by CH2PR05CA0006.outlook.office365.com
 (2603:10b6:610::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24 via Frontend
 Transport; Wed, 28 Feb 2024 11:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 11:24:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 03:23:44 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 03:23:39 -0800
References: <cover.1709057158.git.petrm@nvidia.com>
 <4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
 <20240227193458.38a79c56@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net: nexthop: Add NHA_OP_FLAGS
Date: Wed, 28 Feb 2024 11:50:33 +0100
In-Reply-To: <20240227193458.38a79c56@kernel.org>
Message-ID: <877cioq1c6.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: f29cd446-679a-4ad0-eeee-08dc384fc49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2enE1gS49HBG3YvhMRl3IT10O6V729Uct6T0fvTMqeQZV4ujO6hGTj9AxfweOnXdMeqKeAjnU9Ti/TOgaoaX+Eu45SAa/PKsfxnFM3HrsUVpkhSciLOJMnOGmO73gLdEyR+EnmpMYzqrAMNpHxc61BzciV5egxGgoBx/PfwjU1KaovLnQgOseMstLj0qUpUZFiv+2tNs34z8p/dJlqshrjNzp9WaMx4CzAdQrn9a0LrBB+4LghaLYEZ5N0ruRIiiagZi+OO6fPfouUr64Um9XSyor3rKnYmxp3BJG0K4wcLeeQ1UNBiZnZZWP0w6RF+LFCPCxQGkatpeXBYqIGqMWNWLrNB7W5bsGek4vI3qxEdY33cxyBhWOgEOlwLsjJbvLS0fEm/PhhETw9bxOgF6jhP49COpzRUuRzoyUtebtVJ07iajQ4oLPid17MqM7cXXg7y3imyJyRch+XGLkmQwxYfJOdofu/x4F4+hxn8bVQdQBo19f84lDg/MTTWgKseCPEe/flH6IUkFtNmLyMAO2+kTrx3LpXuZcfM86dFFw0CCOJ53q9mjgTdzgbwBm3KNNGSiQAl30KnC4+S1Uuvxs6aRGuSL7g8zxp/0KP7I4SC02D0fSf9cn7DKmHOxOlrWWjcFyL8cHfegTBfyCwEtbVt0im+U2x6mL5GgU/pmpNHAzBj8vc4PRlc6qvJBENpA8ZoVOCMpnpm8Ua6KxVszMf/BGzV+KuJhmLwX09bsguSFN3JFCMIN6y3WvtEPkf7F
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:24:02.9186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f29cd446-679a-4ad0-eeee-08dc384fc49f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Feb 2024 19:17:27 +0100 Petr Machata wrote:
>> +	/* bitfield32; operation-specific flags */
>> +	NHA_OP_FLAGS,
>
>>  static const struct nla_policy rtm_nh_policy_get[] = {
>>  	[NHA_ID]		= { .type = NLA_U32 },
>> +	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(0),
>
> Why bitfiled? You never use the mask.
> bitfield gives you the ability to do RMW "atomically" on object fields.
> For op flags I don't think it makes much sense.

Mostly because we get flag validation for free, whereas it would need to
be hand-rolled for u32. But also I don't know what will be useful in the
future. It would be silly to have to add another flags attribute as
bitfield because this time we actually care about toggling single bits
of an object.

