Return-Path: <netdev+bounces-282489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLgXBxdy8mmJrQEAu9opvQ
	(envelope-from <netdev+bounces-282489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:03:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED049A545
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571F43074295
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F9383C83;
	Wed, 29 Apr 2026 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vf0eiIUy"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012008.outbound.protection.outlook.com [40.93.195.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB49343D66
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496468; cv=fail; b=fcTb9DBYpJWV7PIDT4JTcozjRB/QuC3LE2xJyRwCXTp7CvnP9Ys7uJgV+1y9rwHai4EfixZnueFLZas3rliUSrMZpkMLWwlaUlbuvLSMK9dazOLu6LnQnXqpf6Vf0YkWyO2HjYyuGvRGfTCC+cHHTAf5W/D873j8Tqa6faAZ9yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496468; c=relaxed/simple;
	bh=P0QjgXI95CeUARarehn0tONAdcZcenqgQneJ/QoIGKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOI45ColRwNGima/TWC+qz2wcLbbkkRy9I1CmF3goq0XiXASN7DllFw84QgTi6IIvLN+G6MVB7vgwUT5l//vb38QDYyBg7Ku47f+aZfNQzvVJ5rT7bOW9Yhri/8xdOu9kTqfg5r6qubmKWv/53bg+5ErtWjp3OKtG9G5skuZe4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vf0eiIUy; arc=fail smtp.client-ip=40.93.195.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXek7TD69b66vKbfMqNCMZ7LksPt47e7xGDgrE4KA6aV4KAl8eCltAjmLIK+aqCuQNdHy9RXDWBEOciurn9Kxaoctg0NR2CX8koE0c39L9xubbJEn4AoQr6nz97Ji6fUq+N8D3XUthtVMFUnpiEllqzct8XQXy1KwAj7Q0UYO41EP2mIp26uFdLp7SnCTVEjpdZ3XLksr+xo2VOkEEOXJ1ZFg6wFdaduo1qWII54j/El/prhizmrj1gYoVhu2e0+SupUTvyOKTVaMFARlpJtoPNkwVP299GvsSbyJNZnID7bT50KumEYJVa4bwPikT+JF+Rn8CQhR0aed+r7At8HjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoufF3Kx0xaEmU1HtuDdmk6nfz+mE+RfQupy177E6d4=;
 b=ILW6XDT6JRSkjXCfSQhQjaj8YcGur7Hh9kDrzNgMqT2IjDPzHlscyoI+UZjuPJFMyEWLTxUGa22SOvUQUjXnsIabt0WqDFgoF4W3SoUJgs5gB8u+aYxrwmk9kyW23D0eYTrBD25SoXFdNSYgTsN+8XjFPduHk5aEuY8O5pXAvT2eKnaMYSfdqoPChztKwgs2dhp1kWvpw9O60fc/rVTStZRCHmWGwY479dQ/fxyVBHnzpNJet1Wgz1R9FssnnYjnYnrXZMKr63N+NMuvulCx8rUrEUhKYzWHmkuYkWN0fZ139HexE340AYI689vLlNnBwRcAkGxTj9HIprx7F2+JhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoufF3Kx0xaEmU1HtuDdmk6nfz+mE+RfQupy177E6d4=;
 b=vf0eiIUybb3aZ2B0HUgYYALiQX2g/rwUPh9YEOt5ZTukS3/Dtf4BLfKSEfd+x+XvItHbEobYL4QZ7EXuKbe9vr8WGikatfv3STZ98XBvmB9Pt39UYtrkNKJagP0yrOM9BDgkrPgV0OTeaosKbTdbt6q0f+IdbAmdJvB4YsJZml0=
Received: from SJ0PR13CA0233.namprd13.prod.outlook.com (2603:10b6:a03:2c1::28)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 21:01:04 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::8d) by SJ0PR13CA0233.outlook.office365.com
 (2603:10b6:a03:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.20 via Frontend Transport; Wed,
 29 Apr 2026 21:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:01:03 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:00:58 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 3/7] ionic: Fix unexpected dev_cmd failures
Date: Wed, 29 Apr 2026 14:00:03 -0700
Message-ID: <20260429210007.40015-4-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260429210007.40015-1-eric.joyner@amd.com>
References: <20260429210007.40015-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: b049516e-150a-4161-664a-08dea6326ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z9yuJaL4uTvNmW3eEs6Kdy0F5cI4ZKgymn8G0ykMh+aqAssCv7SxzimwQYnqpTbvsllbx74jS2nhNbzLl1Y4k/EZ61A8FQp8ggPEu33MAaJdGxJqhd1zfIOWyntegncWmjO9zZxQpSoS2hUWgQQx+UMh4zQ8MAiiI7jK4Qt1CAumyaEGYw/vonNp5gDFfmw//dzWJestxfRzTMiWSaBk/xdvOiJ+hI5NnK1LWBj4MNCybonmQo17klKN3GPqzl0x2+X7iZTIroEgEx4x9EN8PXCT5cM1PkT/EHtUR+gBJ6Ct7zhfNSCzfiPaT+IDOLKNZVtaSS04Vd8uDqkbJFo2vnf7eBlx+/Hei/Ewqt0GOHl3ZgxmH6VNmkbnpyMFCpSNQQjHZF+fP0kuOQNErOMtMsXeEZVxCgUogwOtGFLs9ZQlXbI7cYzoQrtI5Osuu0tly82y+qrX993gprccUx28dY0ytg8JCbkibtBap4AcNF8g39ZeVExsa6q/AJuxqJo/E9AIAxsiSnGWI5dUK6Ee8FZ1qHu4jJnvLWq/60gxKjP4aZEU4TZ9Pu+GOzTdEo2i7lxsP+ua6Db7RvTj/MieeKIfzcmiA3mjnH/SRv1cH9F8DrHQ+rxtK9UA/Cb31dwJgYnNFqrbbrE41ummBJCTPORvIIMG2p8JXoiQfWmbHmyr8NHoknHdnr5QCZkuPMJDI7rlcn7MuDT+13CXC5dw9oCDXdwuDYYWDEpI409Zrblp5yzPhv8hgCJasV3kuP/S+R01KqnIFllvNvpx/Rl/nw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XiN7/L5QBcuUiHT6EbXKWuA94/y+RtMudZwky4QQ2BwlG2sy8AUsXPP7TN1yQrRCOHcJpwgW5y7RkG8zjeGYKAvOz5wXMh1uYdn1nr2rPvPG/XQe+2XBvypmEOzLefJO2novDlHN/QF452QWHJ/khEZvvzfyUa/muI+lRh2KrboLSzibdLceFYHsDkVSBlAtylJb7jOyINgkle+qGibx3CIbvnGIVS3kZmXBMt9ajIS1EagqODsMnHV9HjbguG8yUUH+9Ix5kWoAqf/hhZPwhIzQC3N3caF2XN6a4PDd421G18S8YKzaCn0rUEEZ/XrN0zBf/rUXga/SjlvudH4T1uhyCsaiD14sUx5VWjZc4GuuCiF2JyJ9wLEuCaZEchUSx9M6uQSD/PuDuHM2cywJoc1zNXr9oypIKF3A+TiRsxXSn5ESHx3cqNqoz3e5Y+KN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:01:03.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b049516e-150a-4161-664a-08dea6326ce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
X-Rspamd-Queue-Id: A0ED049A545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[amd.com:server fail,sea.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282489-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

When polling for a devcmd completion it's possible for the driver to
timeout the command even if the dev_cmd has completed. This can cause
unexpected failures and device probe to fail. Fix this by reading
the dev_cmd's done bit one last time after breaking out of the poll
loop.

Fixes: fbfb8031533c ("ionic: Add hardware init and device commands")
Suggested-by: Neel Patel <neel.patel@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 91f89b9ff807..810cef0fec93 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -541,6 +541,10 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	}
 	duration = jiffies - start_time;
 
+	/* one final check to prevent unexpected timeout */
+	if (!done)
+		done = ionic_dev_cmd_done(idev);
+
 	dev_dbg(ionic->dev, "DEVCMD %s (%d) done=%d took %ld secs (%ld jiffies)\n",
 		ionic_opcode_to_str(opcode), opcode,
 		done, duration / HZ, duration);
-- 
2.17.1


