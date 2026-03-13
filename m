Return-Path: <netdev+bounces-267402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDdfKVrts2m4dQAAu9opvQ
	(envelope-from <netdev+bounces-267402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:56:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFBA281CED
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97F703047062
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E2383C86;
	Fri, 13 Mar 2026 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gToE92T6"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB534EEED
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399183; cv=fail; b=VZNwAdbHkJ0dmhqCXHEy+WURoFTvrn2P1/UzpXDPxM3T2MLnoOLRpMRO8G+z9+igNJ37Ggo2pRdzqasB0spJda88K3NM1XsPJziVex94iPQXx+K7uqTEwSEPZ9eildqApD9yMP/NN4Qis19eOCbytNbPx4/yuAHcOYHlhAn5muk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399183; c=relaxed/simple;
	bh=Qv+FYXBjPk87XaY3CQ8hcXc13qNnwwfslQ/IYwTmwkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nYtEUWSxNQRzsWyK47T6hOamYR7EIwBmqdv8Y8pp7oXvQffJXcHOCm6lGQ1KGgN+vpuoGK7rIOsLQ1rrddxI6iNS/YHfouBm3zdszUU8a8i5Tfp5V/3J+WSVZErBgrV7STKlYIp5SZ5HGho+m67WaToMwqv41wdgI2ddxTJofiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gToE92T6; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKaiNodxcE4iiFERoc4wZn594FhtNbqlf3UwPvXkgETgwwM/J4cVukt8mRixH/fc5DfeCEjVnqRI+hgzn8Pa1lY9FL2IbURYEISnbQThJQCsv9ioUjsHcQ8D9jhN34ppRMi013m4L3SRx1jWDvFlqcDs2N1E+OP6eSbYrIpkGeEgflozKmjIhnGETI1E/EK1sD1Jh8uCiJeE0SL8fSILg2fn5tpEWMq9IiNJ94y4Vv2usid2Q06H7fHiAuaryZD/QqnYQ5nQxEzf5YpPYzrmyFt582zJUPSIynUJqnI9prrX69N1RJtJOYxd1AJUpyGIGdwbf47Vrdhtqdk2sUe5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W6phtXY50DOpHTXAAYTAeqytjrNBCPSpiw1cwuIm0E=;
 b=hTeAmMKeB//zEvPEuOch8qEigW3A89d2H2yAuRwm9ZhwiiJNkFeAEaQXeWmjw0FvZolypU95daT+19CP5FtlmA+stvCpH7aKt2H2W1iXfz9ztb8Mt9x5th6E3tvd6vRDCwWBfk+hZFAv1EpjRumUj5Orl0EAlWaj+lMQrvJqe9Q8zaVA454sHMBBPskP9GFdh7keyOm/VwDQOEDFwDYSPJo2ZYKc7Sre3ZWB0NYAmHXl2VgHqsEaE7ydZUhiFgwsY61SU+o/h4k5jxxynxo49AlncDSEMhSJHGaUShCT7Ny0Y+ChpwGu5KJLIyw2/RBkg6ttPAUbIBj2G2WGMqdNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W6phtXY50DOpHTXAAYTAeqytjrNBCPSpiw1cwuIm0E=;
 b=gToE92T6PDpYT2LTWHtgah7fALXP98nHTeUT8AsWUBhK7yXCGFnWWgtDD20OIDvY1T22le9xmUIUbCCDc6gvvF5jrdfgEyze/F+4IoJVrVtBxexSzFquGXoPqxvUMzsQd+01Di75yN/y3C+8gq9fxqo1i89yqNLtSEEsM0ybvacfnuNHZYzlzbQdk6rhiHByeAeuL8SRTZ1nhhTSkakQm+Kn8SUrkddYNHm+KzHBixdIcJpDt0YFWvNoJzxYK3fy2dFJQ3Pc9E/jxYSVlQfay8CriFr22ggvLHGrutoqIUT8NXzrgGD5CHQrHWveGPwLv8aOu0wz5f1UZl07DySdBw==
Received: from SJ0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:a03:39e::8)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 10:52:55 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::a6) by SJ0PR03CA0273.outlook.office365.com
 (2603:10b6:a03:39e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 10:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 10:52:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 03:52:47 -0700
Received: from pylon.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Mar 2026 03:52:42 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 0/3] macsec: Add support for VLAN filtering in offload mode
Date: Fri, 13 Mar 2026 11:52:23 +0100
Message-ID: <20260313105227.1884391-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: b14fb4cf-fa90-4e22-6d8d-08de80eeaed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZieuJzhaRW5xBVUt6cjvhj0PL/iOyiu0pfMRFye7gjo3yZ2IMvRkOm1q2YBznauXT9cUtF5WGvKP/7Cwu7OuX4Jell8THqvDTH6R+dEfMDXuVMI9uWtTIxCTWhQ5PmJmGq4rwV5kaCMieiQXQRL1y7m3bqEZAlqS+yxS4mYR4CKTo0oAyhuGnaI51eiyCghPWYNCTywnph1Vfk9xJBD87WzZkZaTz1hAyv5GcAXnh2W0jjIB94lGWULh7FX5TMnTQd9vbdpouHi+6lMfWwdVKzDGv0bd+JE5RSePmdXFlxT3EVwfCRaqN8od+auguFYq2L0WhHQtDOT6yWC8SrhGGZ7LzipKJ5T+ePd/xSWtzjE7igqs9xWMWNJnzSSkp1JQKrJM42g/p9qvgnZJ8B72CDUyX7i7gIEVWmW0sxD9eomH46Pz2n8AEGjmO81CiSndWL799TPXuXUtOx6eQeYw9l4b63yF9vXPEzXLtJoAcgkmfViOMh6evfh04QkXScpWGx7NMEuP5h1YK52SVYcTjRt9m3+mqsLXfhQOkWuhhLuRLKsVn3xn15+/jirUsF47bgAWoYJWFdsWSn+7c74OefwiWc0vVHzymYzIJAHIr2EkCoPmHcPbychEUyBr6snSf4h+sc5vUhOVYfPmT0jS62TcIYTrc+Uwtb/ByrLarSzVYfDvBV8YWRdnTeDMktaj+peQlKPYD29vbmFYzkJNq1VkiRBN/vr69zwtZFfG66nscMdAOkSrqBYYQXLlQGOh5CwUScOVJt10YH52FiE+5Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aR88PYRli+o4lntrofJvdJMLhxbiu+713rIOSwuKtlee4SN3aG4JGFKdYEHyn2Rs4ZvTN9AXyrUdq+JkFysdK9Cz9+YpwhYKeJrWssmy4ac+9xw/FfdCNURC0wivOzMjiAzFXLgpsSkzW2T6BiIoawD1iVg9Qk2pr3LlrkGKEDDyh1tehGhglmCcwSyQQBsY7QAyVpbQL4rXSio2X5i/m8TaNnUPiU2O/pAzTH7nvXQ3Pd0XBTmYRmGKK7MgDKcE7zWk+GOqZAyqWbWPoLG2b6nG6JBx/0fYgt+Tm1cLivTkiuh6mEVagcn1PD1NXRLU+d/07cWIWPtyX2A0/u1hDDizxkoe2iV/asV7q+TRbsA0PTaO4JKXFLwlKRd8GK7ygULjzicw0YAdueMi40x0WJrfb0X6UFMP4iC70mCLDVmxZtIsv1e48ERWZNEPRmwv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:52:55.5658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b14fb4cf-fa90-4e22-6d8d-08de80eeaed8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267402-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0BFBA281CED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This short series adds support for VLANs in macsec devices when offload
mode is enabled. This allows VLAN netdevs on top of macsec netdevs to
function, which accidentally used to be the case in the past, but was
broken. This series adds back proper support.

As part of this, the existing nsim-only macsec offload tests were
translated to Python so they can run against real HW and new
traffic-based tests were added for VLAN filter propagation, since
there's currently no uAPI to check VLAN filters.

V4:
- Migrated nsim-only macsec tests to Python, usable against real hw.
- Ran these tests against both nsim and mlx5 devs.
- Gave up on nsim patches since the tests no longer use them.

V3: https://lore.kernel.org/netdev/20260306151004.2862198-1-cratiu@nvidia.com/t/#u
- Moved back to net.
- Added proper rollback support for VLAN filters in case of failure.
- Added VLAN as a requirement for the new macsec tests.

V2: https://lore.kernel.org/netdev/20260227090227.1552512-1-cratiu@nvidia.com/
- Sent to net-next instead of net because of apparent complexity.
- Changed VLAN filtering to only function in offload mode.
- Added tests.

V1: https://lore.kernel.org/netdev/20260107104723.2750725-1-cratiu@nvidia.com/


Cosmin Ratiu (3):
  selftests: Migrate nsim-only MACsec tests to Python
  selftests: Add MACsec VLAN propagation traffic test
  macsec: Support VLAN-filtering lower devices

 drivers/net/macsec.c                          |  44 +++++-
 tools/testing/selftests/drivers/net/Makefile  |   6 +
 .../selftests/drivers/net/macsec_api.py       | 103 ++++++++++++++
 .../selftests/drivers/net/macsec_lib.py       |  20 +++
 .../selftests/drivers/net/macsec_traffic.py   | 126 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 ----------------
 7 files changed, 294 insertions(+), 123 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/macsec_api.py
 create mode 100644 tools/testing/selftests/drivers/net/macsec_lib.py
 create mode 100755 tools/testing/selftests/drivers/net/macsec_traffic.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

-- 
2.43.0


