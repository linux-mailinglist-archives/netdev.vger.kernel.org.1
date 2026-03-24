Return-Path: <netdev+bounces-271017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKaJEs+DwmlneQQAu9opvQ
	(envelope-from <netdev+bounces-271017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:30:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CCB3083D1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BF9A30200CF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A63EF0D4;
	Tue, 24 Mar 2026 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tI78zPN7"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9795275AFD;
	Tue, 24 Mar 2026 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354622; cv=fail; b=AwFQKfospnvMUN/Ftmxnfr1JN4lgCjIAmslF4ObVq4KG6fbiVXCVsdRxWYSKjGnXGp7b7eHJ9wo5ljTVUhJXtWCLNs76tWUAMqs43EiGA/JSDA73obZ2259qMJMgul2/dVqP+/cFe4GcsghkKVr1V+JFkIpWTLinwB3GAzYzgz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354622; c=relaxed/simple;
	bh=7/zoarReCe5ltLe5UEv5NKV0ssGjfDPJpFrnIsVAGxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rV+36ToVP1BgpmYO+cSVUZixEIaAnbHWoopNV/doqXwKONrKcD7GcM8aMzlI7E/GI7chJsIW6Yi1KR/IYq3THHR5LuOh9SHvcWvHSjmbn51WSf81LQzSyqYBVaThUrXVl73wguo9WnfGAm6xDDc3OGDFvTToytXEBCYoLL5CKr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tI78zPN7; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jabWI8jktdbIWL7KbEsNoAfn/K+1GKh1tjb4oDbBpktd2Mzt/AT1Znaz97ypxfNoFsQMOqQ8bK4ldQ884vOMitbpkZbiM+8L8a//Cpq2CgFE66W9CT/6p1DuG4aMV7tsrShcBTrpDossD7TohVA5yJJ4r6pq7iZORxSfAtBM3lcH2gJzI1H8pet8B8fX+MJoeM94Pm+/ctB2lwmyBl3Bl/oQgpVpG/JXabtEvL2db4ZigTW7aljq5g5r70dUIXnq442AQSNwcuEtEMULmvheR8vI/tqYe6EZtkCufkzwgOpHNvWpC7byCWM/G6c9uRSoD4Qnr6tNoGTdn0/GDoVfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/x1jaJUOoT/3onlB8DsJf2GaKQJ84wZlrzxo7+nXwA=;
 b=BrEWxHNttBHhmyVBPHP6x2gWHzLr6SwcEkj1kAXDwGtDyD2YPBrr5/uH2fY5/n0V9EVFcSPXCMWexfMpfH67FUHIPYeGnzW33lcmbcpbBxB+gS1ZsycI6yMuIYa+rJdZigUxRSouscGDAALN9Em9It14xT1Vh02hFxQoTxA8uzLgIgTPC7PpvKytZYYLD60tu7lE8Dx8VlmqdqO28DyIjbXwo+wrLZfLBGP+TQsTmq/dY3H/EfuhXlLJ8JbFbPqJZ4mrDk+xUaxyOzEm/3jN9GTn6RTAKHDC+YkvNr8YteWyFSKj8DdRZkNpptROn/6+8i27WJEyZUkCpAB49pVZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/x1jaJUOoT/3onlB8DsJf2GaKQJ84wZlrzxo7+nXwA=;
 b=tI78zPN7mrWcyef5+9ivOrkVbIoo0Qz/2mHon8hznB/M7vpNlUR/6T/MbIXq1T6xgS3WEix4IxqCoIcfB0zs+6fIGY46qIjrm3Pv+5m0org8ZjVTk/TH4wyEzwuI4JBKg18qsBOFWfm3xOaxvPKKC870ty3NSgxxMOAn2LlfjgK+hyqWXdudFskOLzYSYaLy8FoAORXjCSB3QTFH33MTI/eAK0VkIo5lp1ekNxs/H3G03OvnNU921M5RlpkD+ibxQvURXWf/PwFweduSlYja7e6X2nHumZLiVLi0SiCtxtNOxkvkywd0UUsTSsY+tRY26vQKRpqQ2QA1c62qXJol3w==
Received: from DM6PR12CA0004.namprd12.prod.outlook.com (2603:10b6:5:1c0::17)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:16:54 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::75) by DM6PR12CA0004.outlook.office365.com
 (2603:10b6:5:1c0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:16:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:16:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:16:37 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 05:16:34 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 0/3] net: stmmac: Fix Tegra234 MGBE clock
Date: Tue, 24 Mar 2026 12:16:28 +0000
Message-ID: <20260324121631.771628-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 496af39e-e57b-4902-5d39-08de899f3c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PvtpcvO4raJEW9pXsJSqjrZPGTSHCMZpQq33TmSMUNL2gOXMcM06x+Bjj+zsL7uoJFx7cl7N8b8+r/f7r6p7v5SXWsYCXPQ/FgQoji4+sMxl5+uPkgES7e2QUp3nRDa4Ndep11E5jw/VSLqNYb6QdvxOBVsaklIMEGaytkmNExpW/VFqT7bXf/pFrNF7y4J3d/Mauc8fZqBrc/8w76Rk20ktchdT00+zI8n7FQgKEFuD0T6IeYF7Fi61spDmwqjV6e8p68ZrcD9o8EJCEkN8shqscU0BrNSIeBvtkFo+yd9+JVSCQbQEUH4oCdWLvoUii82fslWTECoQC029SrdMUt1tAd8vdeA13f/4j+icQtI61Z7FlW386Jddg87rzCzSsT13xS0OS+IAp4lClf/DJEgzBGqRwMZJQ53frusx3Vt6MR6ZgZu8j0zr0Z+MJZJk9K5Bo85QLsLcBkzjQ595Z19JzOra/C+Kmr2LLact1VTjRJHy8H78xdzTYbgsOBxUmN8DcLzMOJbme+UsCfhjZIynI9nFgHGSFUnttRwmCnMU8bsRzENM9oyNnStnD1PcfMK2DyGWK0yM3EzQsepaPYlX8TWnponiJ4OMPqZyHUJHSQeT3fC0CYVqQ3agkR+WeZ5IPce9iYjCn3OqlrbWnEyQP++6Y2ypvnLna5DkIrcJOJBXyY2GCAKusPAS+3nxAXcnvsb7Apqvnpp+SyXd+KjnL4+UfTtAP8lpx/9KBdCIVhb+Ph7YiNC1z2wZ7opm2Nw7PK578T3q80WjbPEYlQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s41Ia4Ep9tznzhjQCb3g85wbhfGwHEn3A3ic6zHqEWsQuKPOqdXCfyU/Bk6kTYbkVA5whX3sQvWxri0bnH+K5/sKm2pIyJ2TU8R+JxXhhMl9vgxubG5KVEvUQ7UgFY0kF0yZe/OQbuZNUDztjlPYLSDRcyXEf73dI4Tlo5+vJ+w2fxB9/d2eF5NqcnMkaJn7ydPj08V0hYRFFY1KQKfD2324xy2CQg+not+DsGslvK2XzEhHrOYMTSnBVpz9gTzev0LfDQlEUtfgjUmd0AC40CNwKzeBuD8k+jgWbfxVQR7/ynaHsxpW3CQnhLKpQ+kyNZ49i8Rf/VgZwVZV/T8y137ckUpKjmojFwuP//iHrcRoSqe66UVMLqfFIfXd0aRxlt4Y2cCK+TgHL9E9uROg8Ja9Jrnzbg4jqv33k/3+ZCFJftf/453jWt96oIZse/yY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:16:53.4760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496af39e-e57b-4902-5d39-08de899f3c37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271017-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 51CCB3083D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The name of the PTP ref clock for the Tegra234 MGBE ethernet controller
does not match the generic name in the stmmac platform driver. Despite
this basic ethernet is functional on the Tegra234 platforms that use
this driver and as far as I know, we have not tested PTP support with
this driver. Hence, the risk of breaking any functionality is low.

The previous attempt to fix this in the stmmac platform driver, by
supporting the Tegra234 PTP clock name, was rejected [0]. The preference
from the netdev maintainers is to fix this in the DT binding for
Tegra234.

This series fixes this by correcting the device-tree binding to align
with the generic name for the PTP clock. I understand that this is
breaking the ABI for this device, which we should never do, but this
is a last resort for getting this fixed. I am open to any better ideas
to fix this. Please note that we still maintain backward compatibility
in the driver to allow older device-trees to work, but we don't
advertise this via the binding, because I did not see any value in doing
so.

Changes since V1:
- Moved handling of different PTP clock names into Tegra234 MGBE driver.
- Add changes to update the Tegra234 MGBE DT binding and DT source.

[0] https://lore.kernel.org/linux-tegra/20250612062032.293275-1-jonathanh@nvidia.com/

Jon Hunter (3):
  net: stmmac: Fix PTP ref clock for Tegra234
  dt-bindings: net: Fix Tegra234 MGBE PTP clock
  arm64: tegra: Fix Tegra234 MGBE PTP clock

 .../bindings/net/nvidia,tegra234-mgbe.yaml    |  2 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  8 ++++----
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 19 +++++++++++++++++--
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.43.0


