Return-Path: <netdev+bounces-275992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K7WOr7/1GnOzQcAu9opvQ
	(envelope-from <netdev+bounces-275992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 14:59:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E883AEC2E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 14:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 639E4301BA74
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235DC3B6354;
	Tue,  7 Apr 2026 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hzSA9XlV"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC23B2FE1;
	Tue,  7 Apr 2026 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566766; cv=fail; b=JE1tVVDmXLt/55v+YUZldy0y1MInloPDhPZSQBZMVeZQVaTLIE39BQn9PkfrA2m5PicfjWboBJab1K0yhdUstjF2iLFm7oLHJDhsEuQ9CZUkskNQV+9jrkOjV5AZOJqFycMH6WEGJtopqtZKNdGei+QNjpoGUwf/Oqyj1ihf9+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566766; c=relaxed/simple;
	bh=WvL0jhENM6LtQ455vrhgSCRxvhJ6AV4Sb4AmCLFQCZs=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Pzi8J195h0PNFULsBI6B49w9GRuSu1zdkuBgwvhmg1nMvdybvB6zuBpE/WPKPkC+e5/kNvgMpTDyIeNmXsxPso0jJryM6uM0KKm60sGs9ZeKj1+Cbc1Wz1WciZ2buF63rAaWUEaL0LePVpKsp3TI4xK+o4UB8XDpGF9mmUXLVr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hzSA9XlV; arc=fail smtp.client-ip=52.101.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh9soHN/TZNdyohAI2Wg9ujeAr433xqxZMuiF7jMIu5fkdZZB8CzCkxRSswwrLo3v0/cM8CW862pUpgBjc4KzJmobvlxWj82ZgnLdAypPWx9oBrs3c01gx/REQrRXAcwPzMz4U1zRD483BvreSBIetdWevlCne/s+NnuHuIfWsijOTYQS/jtm7NW+XDW2ulszQVuUv3wxzZDugWpqXjRAbqI+unkmKJ4eOUqaN9T6LRyqmi3Nhrgup/fEpWKrE+JtesQVHNysRv/LG7/itiW/cvYhuRyLPXRg5qs4W1p1hHLn/DKffxKzHs/q9QwJjGVbVmNgWad4S5Yl+tamyR7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvL0jhENM6LtQ455vrhgSCRxvhJ6AV4Sb4AmCLFQCZs=;
 b=uN+nyIsOvYYX+jD1fqzie1j6lbfRmHlsXBqilS6Y0xYNV5imH5ylXvqGUfrcHue6TrJHw8iLKLN7POWyGt838ZNxaVc9GrYyPq/XKRCGTNTmG1mcMBeHGhn0iAzKhBpaZJ5xx1WsSvT38VoGr75km2FG5Y2KfclbHJcG66dTVX7leW8Vk0lKjXHGc1tYnRAxBbfh6TCuC5byxDP20jkBuTw64lEcX6XU3fxlUeXdLGDDPQ6RVye3xRGo6EDG8thy3g5l8oEz2vsQbu2zhK5b2srZmUJvTZD8DI3Yaizww7CIYhc++sc7OilRPYguM54X1Hd70SS0MMPzilJyEfrFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvL0jhENM6LtQ455vrhgSCRxvhJ6AV4Sb4AmCLFQCZs=;
 b=hzSA9XlVYMu04G78zGDlEF/mKjzo8nOhzmn9qtlcYslGnp3QZaqyO0Dz0eRX2uRLqk++3huj0efmqPkgVW5hWrIcIXKvAMaVEaX4qpCJZ8M0yz+uHEA+rMbt2avi3rKb+2K90q8b0UNCRi5BgK7u1Y+JdVXNOA+gTgQKvaaRY4Ofpz+590H49xbo4a/bGBzpvmJd9nMwiZWCJ+dVVgWF9JomZmz2ZSzwuUSpp1tmebg83P7hzrTvbpPMOd6UNzWq7G8gnPMaJjfrHFrN5hNpOyRLM1o+FNxv3sqDT5on6HW6FvB7vtK6nwEexIiZov7BwT1UANH4Mve/FhdRFxgRtg==
Received: from BN0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:408:ec::34)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 12:59:18 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::5b) by BN0PR04CA0119.outlook.office365.com
 (2603:10b6:408:ec::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 12:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 12:59:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 05:59:00 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 05:58:53 -0700
References: <20260407102058.867279-1-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>, <linux-kselftest@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next v2] selftests: forwarding: lib: rewrite
 processing of command line arguments
Date: Tue, 7 Apr 2026 14:57:51 +0200
In-Reply-To: <20260407102058.867279-1-ioana.ciornei@nxp.com>
Message-ID: <87zf3f0vw6.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc96d52-3c81-4099-d160-08de94a578b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	30n4ENIFQqXlRoTUQjdVZND0japWeVMns52dqp+6SVZMMkcCYcI/sEL/O8b3qAaMmapAYsF5hQiRMb1k3x4IqKws/Nt/fIOxyzen5LD5JHhCOh4WlbUvHUlWTUH87LcPUQ6FtjaJ/4GtmROpL+2g5WGvuF2eLru9YyDzR4rCeh0fK7cyXDAxuj+I+fzVJM462ubuuyUIdwya09UymX3Qhec7gjS/NdlDhpK9B0Sz1xzXjyhoWPOQZk7LD4oZqgl2/iylJu4lxdIqP94tPQZjGBE879JOsOUy5D8G1zwpkq9ZUfRYgoyz/0mlwBNPk8ryoSziRvftpnWg63opuXGjZcjfIozlR2oSKFHKEeFA+plzwTNvUmOhnhn9iqGQ1/h6ZUwYXy2PTdvAApc4/i4eD8SFGG2Xxtfixjfcp62pfWyi2ii/IsgxJJntHWwEAUEsXeXpTz4+Y+tLWwtttJ+32O9c+6CzqyDpoGhExEZe5Vq2dgqgTM1eeGhROuFJLpX+R0hK+MT1q6ypMxtodZZFImH7W6zAgaMXdhsHHq4pEMIiMzC34SxXdxmtSJc93huWtqhswwWeMyUlDHAwb7kmsdzGAJLOJBts0l6mXhlCv6ozIz+ccnXbSPDBCtPI87JmN6Fe36KT7tJ6g4/v2H1osm+gCJFB4SN2gozlj8PYpt30cLKmBhMvMpvvSMrn+4kT0bNEMueiXzRcrmPNkvUDnF5v8hKe1Tio0b21Jy/BcFOGCh1VEbbqM1vaKR/fRvDrOQI7tgX3XWaZt3jpTqOPIQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z9AEnDTKPd5Abd6sCAVZbtS6PNTMmtZSdHZATSc20bjHQtuGHo0VAXQY58xx+ng0EXfOz2W7ijA511A14FNMtPR6p2E3P3jhaa9qG538t74p089BAsWOReFFYDhRyIkL0rWWy+/2sJQfWouvg1Me1q/OONxHYuODGEx6wgzWsQMIQ//eApXJXEHQVPuE7Tudz5SjahzT+xzAG+lliC2/rI/8jcIOuc3ceU5ZTbe+oRfuempEFaD3ZSQ1krPPR0dh95TGMldkz0jqSwzIUfxyBLiq8SfpEtIHTqtV/ebuGPZ9F/Aza16eIy23reEGqoH9eyou1DSMOr9r1bFXzvRpTsTdmHnsqIomZo1Avxi9jnwwNftXY6YlyKFtf9hXsSg+eYrv/Q8hMrdRYapNscGSWAkIVHH2hkA7RcqjDRfU8bKAkIgIbXly/YNt726SoRF/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 12:59:14.6632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc96d52-3c81-4099-d160-08de94a578b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275992-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 65E883AEC2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> The piece of code which processes the command line arguments and
> populates NETIFS based on them is really unobvious. Rewrite it so that
> the intention is clear and the code is easy to follow.
>
> Suggested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks for cleaning this up!

Reviewed-by: Petr Machata <petrm@nvidia.com>

