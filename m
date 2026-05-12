Return-Path: <netdev+bounces-287154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPEhHsM2A2pL1wEAu9opvQ
	(envelope-from <netdev+bounces-287154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:18:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E40DA522329
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86C93350A782
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E839AD34;
	Tue, 12 May 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tgi5B8hz"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE425B0AA;
	Tue, 12 May 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591778; cv=fail; b=sWk2BxRlOZIoOYKnqDqLkkl/Lwy+Goy+RTZ8lxNFfV7WHJ/altszHUGFQyzHJdlwRsSlgxLKRnV4SuvpdwT859PUTBLTfhe8uK7Vu/68Z8WHGx/zuH0axN7hupcXbpCCIVyzYJaFjd5/4CV/DR1FvwvqceT3XEEZ0T746b5R0TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591778; c=relaxed/simple;
	bh=0glDteqD47rwoizZxTjtTybUd4ToGI+EYiYSI4vLMfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2l9O+qOVdjQqJKXN2E+LcT97X+6NXBuPnd7T/TMbNkqnGtqZTy0/S2tyluwJLgtH52Q1lOqgy8EZc/yAZYJFngN+oSpG1muwPAX7to1MKY4G3muf/RCqx0TkUsorGhnwUZSHTIuvdC3yllEhQfve5pCDE9VsSoYTt6B6UvKKW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tgi5B8hz; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKC4H13m6P3DjAFOUEmqqdkvEZPWk/GPC+znR842mBh2gbUzbTrhigauJ6Wktw0LXkfeURv1sYiDOAirOv2Ng+a21darzLRN6SAE3ZIaG3CSPr7T8yaOyxdBKyBw/G9PlhXztbCkKIb7n+jEYv7vn0GqRr3Tx/ZZopy9iCXpN8hTKbVSIJ+7rGszlXZaC+YEof5jOh6kmOKfRg8si/y1B7oHdeFFx6qqEGfGZdBbQQO/bWt6FXZo0xhIo+gt/0aIF717o1CWVceNfkhsLgWoS0w+9PSy+rUwcP9ASXGraWBM6UI7e5WNIVT5vepzbejgCrqhRGvxYZAu98Q4UmuTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FLZRy1QpVQuL4bT4aTn+X9ExqfMUHaJhvwhAuqRATk=;
 b=pNmhyilLPyb1wHDkvRlCcs7IdfEaW/CdDwzfJyD8Xr21wDdS7w+6L2KpzRyAIoUB86Q3gSRZGLhWLSsDK/qumSdLVaPohWThJ6qmiAU5vfrl+I9u/IPektVTBFptfck40lybDB03IKC0WbyAbuQx5xVZtDcA8Y5+jpy/yZqVWLjFWOpfSTCX4LvcIe928XQ1jscA6stwTK6pUU2DbX7WGjrjALauHtNs7C96ewxx+wyH1avlC67dhF4JjRt/Qp0K+lRNPbWWHn1Gomoo0I3BrwstPWIxHxWJnMx0LTOIHzcVdvX1i3TtZd8XVLnfbs1NZxNmXzO4b3UZA+s7JtRODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FLZRy1QpVQuL4bT4aTn+X9ExqfMUHaJhvwhAuqRATk=;
 b=Tgi5B8hzeIP6WsEoou6MNo6cow50x2L1d7CbxDm3vX2wVN9atmKTFFuzxq0kJYsHdH9zmb5bckYGftRBQlAOTl5QlUImJqPpGtourmQwYWNipS90O2idMedizay4ypCZ6N0QZ6m7+lelFnp6uYSCErV+0eb8p0K1n+rc0p7EK7pXgqaWml2xlbN1Hrt4w3IbK6AnKR8uT2Q6AkDXcjtWcmNcZy71a9Pu11S6IEUFqQNtjmbLee3qBSkfojui7gNUzBPcbGWALy82DcenvUizBzTPcGB16/nmTs+vjMj6XuPa60CkQ9AZ+MwZcGYqy2l5u2AGyh8WrGDzjH717QxbsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7657.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:14 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:14 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 03/13] dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
Date: Tue, 12 May 2026 16:15:44 +0300
Message-Id: <20260512131554.952971-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4622e468-e2a4-4af8-d4f7-08deb028a4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cP6mcnSUJI/VEkzEbb+4FVDQxG9W7C9wipdeqRDFy6DhpYYsURP7aRxen5tfYzdDEjt/6g11BmLo6gGSeLcskk3Cz+ogRN0KUqXPvgn8LpXtT+NU1+hyxiraR3+IEt/Nzh7hqhzPuGbUBYs6V5TWUKews9jDV3TVEjbdv/j15KW0sPgOljfdFBEv6W7i+PUc62VMDY8lKDbHUhOe39saYHdI2GxnoTfEBvwR0xPoKEsKcFi20R0CfHmfVFajPOCy4HvM0fx1aPpeDgosEAGckUq99+dHTdGq+87nN0DSkLMdnBnPeqkcmj4QXmDeVy26s52MxLroe7q04AJrh7Qf2rOl2mm9kFd3bt8lzL/AYQcv9CW/Q60blE4o8vhbpzF5Nl0S8jAK7nZViYpKYzH/YIwtqF9bshJgc7LzgOEajpW4VloUNdo9QEMkrvadpPk6hQ8L2CqRPeFny98F6e/pjOfi7r0w6OGNZaLjTEvEPhlAvU1ih0uEZ9iu0PDnyZx+RdxiYE0R0mQy9oJyCx3jJB8EgFYiyzNAlDeOBDWFP75okEbIi0XtIs1YESOUr/2oThfKPUzeWSOTLVV6cV+LpMygWBW8vmUERyuRX9/6FMl2GJYq9uS3QYl79joCUn5AfRYcQK2N3SnWnb5/kjpjPwX2qMduGmca1Mx31/itnsXIveaJtPtVHf3XNMXi2c0f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HIRVlNCQLl2jPI9nIO3TvTecpSh8dAocd4N4WNqVrpguzBYq/wu6EV0EgHSZ?=
 =?us-ascii?Q?L1UQwxBfJ96PlzCWIO91/q4LEiaGwGDf3GVH51oW9vKVmLSBBW7FCPM/BKcm?=
 =?us-ascii?Q?sMdw0aa5v9O8sfZVpntgqUpkByRrpEoGkqquye5gsSPQwRYaMIRo3gQoGcUj?=
 =?us-ascii?Q?zmAOvmGqGbCN1/g3SP7vujbG7+OkOsKjEQ6k2tHSKmJBAlQUT+qNPLdj/YQ3?=
 =?us-ascii?Q?jWNyIgDbGNsgx9HaHTs1TKNaJjB8O1ZHPxZ6s2n5XXIeSQIqX8psOiJ0gvKf?=
 =?us-ascii?Q?lIELSTS3VoM2LLBreG1Jb0pVviy7yAhmoMW4NeZFDCMbO370FE4/tJuOPuJr?=
 =?us-ascii?Q?f3kciSdoGvyPGgs8/uWHD7qHsGNnb0IB2W/GDukWDKLpPClmw28z3smejuys?=
 =?us-ascii?Q?87llKWrrmRKPW4NczSKzfh5VabSrKggg5Utjysg/JQvFKey6CAxXxUUXHl0q?=
 =?us-ascii?Q?AJaKQVdV+yIP9Gkf1L/LCNVZlwYDxuwVayQP8puYvn9AkK6zA/iW/JmQymTK?=
 =?us-ascii?Q?gFTmmx5mi8FNGAD/eX+IYR0W2K1NceSn0KhudEABtX7RH/swgohkHCYWBr+N?=
 =?us-ascii?Q?gfQpb9YF6KTKD4gPVXm6pYr5cCLFIZcdFBbps/MZjcOMbzvSdsjmT0E2lUHI?=
 =?us-ascii?Q?J1mSQTQx2nzIup5s+6uAZUFecIsz7KY5LSJ4A23fFqfu/ham1LkTh15Bltm/?=
 =?us-ascii?Q?YOfLFfY+qAXOU54EvbXDQK7xDY8RUD2ukQdsdTqXJqUwO/1mpBr96piomQLk?=
 =?us-ascii?Q?ob+rMoxOvooGfDr0RMUEC/tZhnYDUJCShyX/2tPSjKbs6ekYKOgSouzPpaII?=
 =?us-ascii?Q?NanvPeOZB7pjfNX9flSPLD1yMH/7IGz1Kca1L7Jc8pdBt9W0XfCWX/++afPX?=
 =?us-ascii?Q?TpXv6fDbNCIo6lI+yuTSjJbhvYm4fZxnekqksJdqDbquJkDAUkv3HeVplK7h?=
 =?us-ascii?Q?u4O4CiwwvFxiY4jt7USwYbKgr4MUkY+9YCWeyaHVJjS6PX4SLiAFX6cPuskD?=
 =?us-ascii?Q?E/2xGa0UzRlbHzZzy/C+l3GESqGOkuHOmabui3fjGNvfyuPktauVCtqcNIQ3?=
 =?us-ascii?Q?xcrlY0OXs6nIsmXxM1cqDT/MN3tMfGbQM8OYdZSl0CbPad/uBQD2mzCEdhpB?=
 =?us-ascii?Q?50FgspV4pqWuzZi/Xm1iTBA+UGQ49b84crxZ/5ECdDd/TxQFBUbSPPjIK5Au?=
 =?us-ascii?Q?aHtOlaY6B39Spxw9PqVnTwTyxOcnj0e/EsK5DOukT/z0dLF81FzO/zEO0ua+?=
 =?us-ascii?Q?WQSL3zC/6kNz8sSwlxpikPY2SH2hH1gWusQswGKqWFpM85YAC0la9hXmpGpj?=
 =?us-ascii?Q?85mGXSa0eyTHnZ3YgbWGctZEvRV7NmkSujt6D0h5CLEYpF/qtT1/rXtGlnHu?=
 =?us-ascii?Q?2fwRzQP/HPg7E47m1KkVo62dKakFd++1y+/ggmZpYIOK6sYbSjpYvM9BHpZy?=
 =?us-ascii?Q?8mBJVH622sZolsM4RRMMslkxVnJfs7UlCpLoDapO16sqCPrRry7KAK9w17bJ?=
 =?us-ascii?Q?AP8Gk7nEOEOM0D9GUhQUpJyuC33e8Caft853G62fvBX/2ZABqntyzdeXfS/c?=
 =?us-ascii?Q?lN6rD09B+PnBYfHzqQuC6Str+GzyEB6C1HrW2mHg8vrQQ5a5NLi/nPGkvpKy?=
 =?us-ascii?Q?GA1Dq+wZUidKgK2JwjrUAmVJoRcDjhod8IpcCca8VoPDBqmTiUavc7DvWl+Y?=
 =?us-ascii?Q?jcIfx7Gitc2+eJgYXzN9r86CQ+phQU6IFrOD21gWdh3Qxi0UrssROxUzXJ35?=
 =?us-ascii?Q?Qm6w/0z0qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4622e468-e2a4-4af8-d4f7-08deb028a4d9
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:14.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8XYfGSm05KHrJKXVi+7rq+F5p+uTo/q2SyU41QqVQZRNNYvxD+FWghJTVQIEP/fwGYGHl+xUtSqQp/tY9K5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
X-Rspamd-Queue-Id: E40DA522329
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287154-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Since there dpaa2_switch_port_set_fdb() never fails and its return value
was never checked, change its prototype to return void.

Also, instead of determining if the DPAA2 port is joining or leaving an
upper based on the value of the 'bridge_dev' parameter, add the
'linking' parameter to explicitly specify the action. This will enable
us to pass the upper device that we are joining/leaving in all possible
cases. This will get used in the next patches to determine what kind of
device the upper is: a bridge or a bond.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 33 +++++++++----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 88f52ac04c0a..91be5a12a006 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -62,18 +62,17 @@ dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
-static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
-				     struct net_device *bridge_dev)
+static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
+				      struct net_device *upper_dev,
+				      bool linking)
 {
 	struct ethsw_port_priv *other_port_priv = NULL;
 	struct dpaa2_switch_fdb *fdb;
 	struct net_device *other_dev;
 	struct list_head *iter;
 
-	/* If we leave a bridge (bridge_dev is NULL), find an unused
-	 * FDB and use that.
-	 */
-	if (!bridge_dev) {
+	/* If we leave a bridge, find an unused FDB and use that. */
+	if (!linking) {
 		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
 
 		/* If there is no unused FDB, we must be the last port that
@@ -83,13 +82,13 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 
 		if (!fdb) {
 			port_priv->fdb->bridge_dev = NULL;
-			return 0;
+			return;
 		}
 
 		port_priv->fdb = fdb;
 		port_priv->fdb->in_use = true;
 		port_priv->fdb->bridge_dev = NULL;
-		return 0;
+		return;
 	}
 
 	/* The below call to netdev_for_each_lower_dev() demands the RTNL lock
@@ -101,7 +100,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
 	 * to be present in that bridge
 	 */
-	netdev_for_each_lower_dev(bridge_dev, other_dev, iter) {
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
 		if (!dpaa2_switch_port_dev_check(other_dev))
 			continue;
 
@@ -127,9 +126,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	}
 
 	/* Keep track of the new upper bridge device */
-	port_priv->fdb->bridge_dev = bridge_dev;
-
-	return 0;
+	port_priv->fdb->bridge_dev = upper_dev;
 }
 
 static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
@@ -2040,7 +2037,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		return err;
 
-	dpaa2_switch_port_set_fdb(port_priv, upper_dev);
+	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);
 
 	/* Inherit the initial bridge port learning state */
 	learn_ena = br_port_flag_is_set(netdev, BR_LEARNING);
@@ -2066,7 +2063,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 
 err_switchdev_offload:
 err_egress_flood:
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, upper_dev, false);
 	return err;
 }
 
@@ -2113,7 +2110,7 @@ static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
 	if (err)
 		netdev_err(netdev, "Unable to clear RX VLANs from old FDB table, err (%d)\n", err);
 
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, port_priv->fdb->bridge_dev, false);
 
 	/* Restore all RX VLANs into the new FDB table that we just joined */
 	err = vlan_for_each(netdev, dpaa2_switch_port_restore_rxvlan, netdev);
@@ -2398,7 +2395,7 @@ static int dpaa2_switch_port_bond_join(struct net_device *netdev,
 		return err;
 
 	/* Setup the egress flood policy (broadcast, unknown unicast) */
-	dpaa2_switch_port_set_fdb(port_priv, bond_dev);
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev, true);
 	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
 	if (err)
 		goto err_egress_flood;
@@ -2441,7 +2438,7 @@ static int dpaa2_switch_port_bond_join(struct net_device *netdev,
 	port_priv->lag = NULL;
 	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
 err_egress_flood:
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev, false);
 	dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
 				   BRIDGE_VLAN_INFO_UNTAGGED |
 				   BRIDGE_VLAN_INFO_PVID);
@@ -2472,7 +2469,7 @@ static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
 		goto lag_cleanup;
 
 	/* Setup the FDB for this port which is now standalone */
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev, false);
 
 	/* Setup the egress flood policy (broadcast, unknown unicast).
 	 * When the port is not under a bond, only the CTRL interface is part
-- 
2.25.1


