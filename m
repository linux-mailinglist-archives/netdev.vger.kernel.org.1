Return-Path: <netdev+bounces-273147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBIrJvhoymnG8gUAu9opvQ
	(envelope-from <netdev+bounces-273147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:13:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D435ADEF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD86B303C582
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CDB3CCFC6;
	Mon, 30 Mar 2026 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q2sjwQ1D"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC33CB2F7;
	Mon, 30 Mar 2026 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872182; cv=fail; b=hl0cgm/EO/WtE1IxPvtpRrfEm/e4c0i1Oliq1HSvzXJdDNolERuf6oz0mNnTUM4Hiyb0QKNwuCVKCJmRePBxz77CH3bKn+6gj/1arQoCnSRDabfIs7/PlmgaJE44iJ7RrpoWXL08F+Mpnly2ZNXWmg4IB9VpOpLI/ntKK/rRYDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872182; c=relaxed/simple;
	bh=K28GwuLKS4RQygNzau6w5pFLGRkbH8NFIIFnoYjV5xU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jeySm5yi9nDxIjHqq/3kq0+FIgpjbsrrDOihCj60iQPSSzcj8Sx+8haS/KM+lyJ6NTTH+NPlnRlEO20QG4p55bW4iKfH+vlu/ssZoQq4msgsOtoju2TAZLlLxNAzDpN3zC4T9iLUQFOnbMQQI2FR8saP1CwI82DNOtJ+SzbTBrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q2sjwQ1D; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3jkBtGIxXn7UnuKBYE+qwLHfGsChMUWKQkCUMT2H3nh597FwN3v0+DvZ9w0LMoaZf+4VmwYJ7XLOWvoIFEGsjLTO8ayWQt0G4g5+wEMlkWDLzxymUtBEQA/tcZm157dlZwt0/zo0puMoawh/iwl0D0sBLpwb/oGYKiAlvuzwIJnC7JAJoBaNvta9LpDMly2H+Wd1Cmzkrztqz7GTsoNrVX1vPhOdMAm/JIpxXBGJye00538NYV7NcWHCNmXlYcHa4GW7gcBhIxxkR12PObW0IVnQF37kO91wUc47YQ0M8XF4Or3wdnkMjp5p6ApiORQ/mlUTQjoDVrw9+8QvBujag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOlTI6SinZLsJV8lldJaNWJOtw+tlTKg26eYKKsrL4o=;
 b=veS2W89WG6F9ctxOLJxtBhDFvx8HTrn0N1aPau6mfaT6cu+DjTtUYG0AsAlYisSRuoVgT9JfhHpkNTdraVgtvXGy7B5rP6S30zg0u41eUfEK4WxnDtEvOzQLyPeTsxR+/MV9kq9IxV9KvfnvVYMIqxjqrF3DX7UAn+CLdILSozQummNyJ3KkKK8ZARDYy0Nf1ncGzJBX/MwT/WC/qWjs6jhP07zbfTGRhDlOdEtU6ls3RWKXaM9gm1Ve1BJYarlSAHlRM92qbqtfBbgm3KKuQfanCEcP67SUiSsdMb1ZcBFgCznK/EcYKZ+Z9XOidFK8ASsu649/uMZJM1AsU/H94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOlTI6SinZLsJV8lldJaNWJOtw+tlTKg26eYKKsrL4o=;
 b=Q2sjwQ1Dwg3fodgYftDnv70945wFMT6wpvnZkO2vGbsUy/6ve89nJuOMpSflc4wEC8jRSVxJlsa6Ilgt3YU6VQ5thK8G9KlsjqPZwDY8Tf1btVjW5GocodfSSAsDpHfh7nZg/8wILGNu2ML61H5s4sMiZ7DwY4GIRMWUK7umq66maQRmV9XQT4mlTU3+Par1jeAC3sxncxMWfCMeEuk+XRhhQuYJ0quLptM0D1ErrX4rcFGYW+n/n3VTsPDYLtAjitzzKoA9gk0a5Zv8DgHifRG78yM4EYadG28z+OI2RH1YfNXmb+oCCXmR/pt3b2F235bjidsJs0moD2Vi/pZ7ig==
Received: from MN2PR05CA0048.namprd05.prod.outlook.com (2603:10b6:208:236::17)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:02:54 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::1a) by MN2PR05CA0048.outlook.office365.com
 (2603:10b6:208:236::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 12:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 12:02:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 05:02:34 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 05:02:28 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-9-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 08/10] selftests: drivers: hw: move to KTAP
 output
Date: Mon, 30 Mar 2026 14:01:43 +0200
In-Reply-To: <20260326132828.805703-9-ioana.ciornei@nxp.com>
Message-ID: <87fr5h4jao.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 169ba680-a3c4-4fbd-e580-08de8e544674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s7TmFndIu84lyqcpWFDWSc3ZVkY6oghgRQV8dt+rgPKoK5IPHTmkpQsX0XfMC/DopUignZVg3t5W/AFVCe2unxWO+5M9uBD8R1rOJWOJDivLxsziJF4EZB9M9WRdsh38+HotrdVyzrN5ztNMN/ATsridX3MWIml8hp9vdXAScX2bssvUzVe3a4ajk8JFNw4eFzyBmuZB4nPL9Iykx2HqbCL1WkQlRrlRxDmfCZ0b1wYM0V4A30iyLZhZnTGwm/3z66Ur4qY2vrKDuErSt2PcvRzPkFKlrNLKMGLGaTSeZ1q+8zMoaM/29JXyMcSNAdj8cM9Ur6nBWvmUlc7ldwrI7LIDAakGFH7R5MQGg/fryF9vRFEAfgvgV0EqMqdt8wol/fI1m8sHX6gABJUY3c+7IdAXlU9Jf6S8eUQyXI3qtXVP44wHOAwoNOJi5EweSHveVgQKw44mXKMl23BtgLAAKUlt0VuMs6pyprcvuSfj07yLdsnogmn/BHXmSblFfletL2w+nWerMm7jLyOxgFtu1mUoIbzTgFhRtnS8OYP9Sf7WKqAv/AJBqa6kKy6lJBHq1vBlTdmv1MSWHwbcq7yNDo40Y5FpxxOxrXTSxN4YZ6ljPDj3EekiTuSuytba0d6GpreO2ehDX80vHuxzrJnrobH4f74OpT3y6CHCTSiC7Oj9hGiBJ2glnP1QWdlUieipYRbj1HL9J5iKhIBxMrp7z5aUvm+fwAMNpXXhgZIK06ED5RVO3q+4UgJERewhfB5zGONug3oPpmD+Ug9WjuFiMA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wAv4Ecah8y4JFfvzSzfYyKyD6UqsL6pRZC5vHYBe+MesZw69KEtXZQBUDa7dr50TrtXAvDaYHmY865i09APybpLQIcqenLZWdmJotKP7JRCyv8sa/sSW2ShzeYcusRhoHLW9qj2QZpbQxtn4XHQlO4Stwsn0fmfUqGIakA4gAkqc2OSF5vY8Lu93L6Ji4XR/qRWahSO0dKrdAwuPqkuV2HOLsof3dcQ9aAj1S6pyoVoHH5nTVN7xtoBCYhvFnpd8iCQ0IoMYwQH2n/vBECvFhRHXrr2VRMYTaVybGNZL7yyeb7LNkVJQJ2PPOSVGzqLq52X1UvFVyfjHOjtvc5Td3ur3KFk/nFRKNjC6/IqaSp84fe+VX0Vm9QBBcktr7FR0ksjJrUZNBdCUBxHOF0fqfHJPVEvl/W2mybZ3YLKlaL1PaKCow8dl7mWD/okorxGB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:02:54.1784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 169ba680-a3c4-4fbd-e580-08de8e544674
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273147-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ktap_helpers.sh:url,ethtool_rmon.sh:url,Nvidia.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0E7D435ADEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Update the ethtool_rmon.sh test so that it uses the KTAP format for its
> output. This is achieved by using the helpers found in ktap_helpers.sh.
> An example output can be found below.
>
>  $ ./ethtool_rmon.sh endpmac3 endpmac4
>  TAP version 13
>  1..14
>  ok 1 ethtool_rmon.rx-pkts64to64
>  ok 2 ethtool_rmon.rx-pkts65to127
>  ok 3 ethtool_rmon.rx-pkts128to255
>  ok 4 ethtool_rmon.rx-pkts256to511
>  ok 5 ethtool_rmon.rx-pkts512to1023
>  ok 6 ethtool_rmon.rx-pkts1024to1518
>  ok 7 ethtool_rmon.rx-pkts1519to10240
>  ok 8 ethtool_rmon.tx-pkts64to64
>  ok 9 ethtool_rmon.tx-pkts65to127
>  ok 10 ethtool_rmon.tx-pkts128to255
>  ok 11 ethtool_rmon.tx-pkts256to511
>  ok 12 ethtool_rmon.tx-pkts512to1023
>  ok 13 ethtool_rmon.tx-pkts1024to1518
>  ok 14 ethtool_rmon.tx-pkts1519to10240
>  # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

