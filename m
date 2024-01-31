Return-Path: <netdev+bounces-67479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C4E843A13
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1785D28AD1B
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55A69969;
	Wed, 31 Jan 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="A68fkP6L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2098.outbound.protection.outlook.com [40.107.212.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E460884
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691336; cv=fail; b=DiVz+GSulgbOLtnUQJXQwUUx6hDxWFf0iTrcb83V6Uwex5HHsx7EZqrGwIvtId7Oyh5py9fVjL+bJaY50cfKRGFfA0vLhC6XdBllJCE00aumK2ZqjO0jja8FXw5ZoKZy6UbELx30e6EGcl2kRnrZqUNsXFSxYDq/ilps3qUW6JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691336; c=relaxed/simple;
	bh=puYbhJ+nGxCbmzlZfn68lPDLlHV2kt9Vrjud3V6Qqlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojXVPmcLWsLr84h8iTUjwZaE5kY/8p3uTCxQjUw5uZcLW2OplGG6lG/9EVs9uDTmtKTTydYdIAKv4fK5soK8CBq01SbFb+N18hyxIORV02A+U4J8DSn2bLCYj/0rUXAaRZbzHOXiRAqwFuiaFMLwo2xrUD1lMtseuvxhw0niSPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=A68fkP6L; arc=fail smtp.client-ip=40.107.212.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnMHEIGpiQZcWNB4b4/+nMMhcfbTaMpNrHqE+mZoGPBVjN0GDMNPYbFcePR6iYCRxutUTkbanIHZgLGyrWfxLsyLxsf5HC4dljjB5he6MwIRMiu2SmOHs65zEuXuIo6wTEgYghQiisyfhO2bPvOR8dMI5T8HBZ3gPEWSoO/p/fSNJ41wDMP+9YN5d9QVfg+Ie93rto5d24KH8Sik3AiS2kbSW5o/OTncYZJFprmg+P2Ik9tg5Z8CSWckq2n1ONJ6rV2tCL68lHTXBtw+pTxOztGF2gr4a1zYBEygsunT97mqSexjJP6Vtr4XXEhLm79+nFnf3kQrduTlpyBERc+dcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfKCd5zvOX/Wzg/GntXj1kBW3E6C+Nb7pE2LoZFKW7o=;
 b=AolsuRIo08mDcOIDlgm/CNuTT+upyFmlGRkqRMfp0e5Bv6f6BvQxzlryz11oTutCHAH8rWZLvCRV3HnP/igVmksN7lSVCdBCkXcPv3pOF98Dxzp2/5+IF265X5BdQBxyqccLRk4Sze6eN1ZhtQfT5puTw1bPglaBq+ocM+3Y0XK266r5hQq0onlRABc0VdRlKN2CC5S1zIAx9vKOsFq2j9TGOpEnrzXqo82fN82YrOPIjW5Y41aRvlryJlvtS7p5CPBSSFFFlecCGgAbrJ5jD8HlRAP93PvUwpm+EwiBNwrDHteoBv4a3+MiU6HX9s1epZ2N1MoWDA/qRpemCSoSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfKCd5zvOX/Wzg/GntXj1kBW3E6C+Nb7pE2LoZFKW7o=;
 b=A68fkP6Lov7jR+7SS0TKELdRbeR9mOXOgmIMj2n1reaArWSn02RfnWuZmjfWMuX2DT8uJKEKtj6g0lpGNF3RkljfuwgR+NGy6tNmOOfMnAfHRjsSgrD1nrrTtk6x6j77zbnRNHNYOIF+VPQopKrz3njJYJOtFNKj7IqGQdkuiiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by PH8PR13MB6248.namprd13.prod.outlook.com (2603:10b6:510:238::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 08:55:30 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 08:55:30 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 1/2] nfp: update devlink device info output
Date: Wed, 31 Jan 2024 10:54:25 +0200
Message-Id: <20240131085426.45374-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131085426.45374-1-louis.peens@corigine.com>
References: <20240131085426.45374-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::26)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|PH8PR13MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c33031-ea75-4deb-6fd6-08dc223a603c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HXXPiyG/W6Y3KJs+iIBuw5bzwZRKxGY6gENV+GNNakJLxY3MNtoFO/j32XvImdavVJ4sNic6hjjKJ+u1MTtAc5Y0oStuExgiZPRzv/duWvsf/7PphvhLaGMaqf83smaJ6HQAbeY5lEo27RmfCbVPQHHbA/oR9C1ycPE79JEAfO56RT7TQmtkYy0KtYBn8i1Soh79DugK65ItFpdiZyy4VZ2yy+RWmn0i8a8YR+cw5ieQYWERVl/zbG8zZ5dl6lFy4DtMU6TrvydxaOt5WTu3BdyHC502d1+p75thSksVslE0+CXZEls/YKQCve9MP0qd4QeMpHtHt1ilzdzeNMLZRZSTcG8oYuwiA3pWz8OSKty/YTjJ674i70K3/uBb5MtW8cUHRzVW/uhmOdBaKA3Gz0Ex2bZC8Lccun69axd+BUN591EBIHl3m98ieWEV/jm8fZAqG1eKUZxUZ8pSy0QtyJpviqIUtYK6QvfpmlUKMFamYGghCb4y37md/7yMAXT++naeDeGNO/QC+o5fRB5W23iqGIGTLx82rhH3VSVxPz/ARdk0OUqoHJMDvCddezvRbleXsM1aaXNYap/hiMwrVO3+Hp+d7i98Ectp0xeWRLdokCb6WqkleCFc8nWRCOty
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(107886003)(38100700002)(6512007)(44832011)(6506007)(52116002)(6666004)(1076003)(26005)(6486002)(36756003)(478600001)(66556008)(316002)(66476007)(8676002)(8936002)(38350700005)(4326008)(66946007)(110136005)(41300700001)(2906002)(4744005)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DHm4JMi1tYIiluPt1Rj4Aw0I0UuFuPAKqQtsVZ9/kInMgSknPSRjquYkVYq9?=
 =?us-ascii?Q?1fxEd3GwBf7qalVvWDsR+kIsJmvBxuo61GesZlOdPusIaYBbbZ2/Z1cO80rE?=
 =?us-ascii?Q?UXTrqYdCcey8NJL+ezaA+RTKTrKo2QqubD8KmLmkIPQ1kd8qMSZjdtoflHuK?=
 =?us-ascii?Q?2su8B5CDdt28wiKkcCE87w1VAS693AGi0T+cHMaCjQIqqHxjtg2oXLMBQn92?=
 =?us-ascii?Q?XTaN3An3RPx0u0Jb5UOF0E7/fgaek61Eote4Fpd7QAa7R20pzB9SDbanVlSt?=
 =?us-ascii?Q?WIS6TNWXHUWpSk9ivN3/YRT5aKltekgXLJJwNy/o1cM6ZrzE0uEAfcaVPhTm?=
 =?us-ascii?Q?f03EM2sf3WlXrapOuY+Uu0UIW1sdDxzOWHMs3vYJ1Ah2PRFCneiBp3dKma0y?=
 =?us-ascii?Q?KDha/5vosNX4IFKyIBjFlf8tTRAr7tyfyHjsdBkcNzxu25Tc9r0yGqpjkPHI?=
 =?us-ascii?Q?aUeKu7CuGhOyn+2gexl5r5jTmkp6zaPaLLjD87xPh08dCAp42lKGJo/+GtYe?=
 =?us-ascii?Q?hGJzmo6RbnLSDG/tt3p7Kye4/vq8kQnDC+MbaytuC3sWSc35pqz7UzJrXW78?=
 =?us-ascii?Q?zfAvy+ifojvB/Qrnpjqjpp4ycCWakIq8yAroRvrzL92Bapg+zAa1oJvYza0j?=
 =?us-ascii?Q?67RSRGIfcT/DgHl2e3dBZ/2nyJypJkOg52dsqxyLF22cFxjWMWL5+SkgHAcf?=
 =?us-ascii?Q?FXVMWlVyJjQPZIKxdONsADn9gOujYur3eoxNcKBwH+cIbFLgqlYLr9BawIJF?=
 =?us-ascii?Q?Tx1MDguPozotwaJxYKFPR0zTbGJc0k8tU2XLiJAz+1lrCBm+K9nJ8Z0qv9SD?=
 =?us-ascii?Q?VhT87jRv6qIyZU3PpyndsLRHzyPxPxB+gXUFXW5ApgyVSawiXdzFpch1BYNR?=
 =?us-ascii?Q?Or1jsAqQFEYwp4rTre05b1OBSgH6xsqMUKU8dbiJLpYhzTxMkXIaulQMVs/d?=
 =?us-ascii?Q?CsfnW4l7EkI3qhJFxAUubQLCsb46Y2uFUcrOPHLwKrKnJkQz1zPsAWo2Y3Hv?=
 =?us-ascii?Q?jeugUuLadiGcCMccG/kIg/Ij9r39VGiSFKuUGTwSTc4OOoVY9lRKo5iqo+Cy?=
 =?us-ascii?Q?qtLIuqOeJRA8M5xHY4HPaS+t5Mo1kE5NcAellW7mq8CB+SH//T3zy7ylKWgj?=
 =?us-ascii?Q?AU2fK8k/f6dKU1rUp6apHB4PKxnSFCmTTq2rZ6AdnNteWLD5IzjTULxQxXKz?=
 =?us-ascii?Q?3McplZe+HaJINgLGQV6xABXtTEFtt1jNqE2noG7JVYq/P8vuszPC4/8Q1RRs?=
 =?us-ascii?Q?32OuwjHvtm+INMdZpLCPxdNoWi5H04yGyrXyJXhQsUACT8rVLeoWVR7wvtqW?=
 =?us-ascii?Q?fBu3nbYkKdHcjt54Z2X7GS3D+4benGJ/r1M7C3v21wAmNOzX2mK3berdL9S8?=
 =?us-ascii?Q?y5ZesLn0kl/DWlvbv7FtNgrRNRJ/zSwC3uoLRESzxBcf23IVybPN2gdYQ/bP?=
 =?us-ascii?Q?mj0iV1zIrGVHQd519eGAqpdnWGN+VEokkbVxO8ohPiuVHMStRF8XUbdU1x+D?=
 =?us-ascii?Q?WzqB9X+m17hJpBGE38lMPnP5BOdz4yRBJ8JuK8k7rWsm7MX09IWatQC3Tzr6?=
 =?us-ascii?Q?H/bbI3/Lil13nt9J55oGZMZGd6xhFv+Kp4ep1mWhQ8RTBB/YtvNpYbTeaF2d?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c33031-ea75-4deb-6fd6-08dc223a603c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:55:30.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7Fbbw7zKyxuT0oF2o73O6+73NIjU+SgiUEcmoYflSn1pl5s+aI+MHfrKs0FVrf8Aasycr3HozRMiUwTeSDzpPQKy76WFjI/7j/U9QdiZc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR13MB6248

From: Fei Qin <fei.qin@corigine.com>

Newer NIC will introduce a new part number field, add it to devlink
device info.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
index 635d33c0d6d3..91563b705639 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
@@ -160,6 +160,7 @@ static const struct nfp_devlink_versions_simple {
 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,	"assembly.revision", },
 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE, "assembly.vendor", },
 	{ "board.model", /* code name */		"assembly.model", },
+	{ "board.pn",					"pn", },
 };
 
 static int
-- 
2.34.1


