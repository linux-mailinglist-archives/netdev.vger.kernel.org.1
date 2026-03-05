Return-Path: <netdev+bounces-264471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDqkCvWnqWmbBwEAu9opvQ
	(envelope-from <netdev+bounces-264471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:57:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A315214FB8
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8435A300ACA0
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95093CD8A2;
	Thu,  5 Mar 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HU8DrQef"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C753CC9E1;
	Thu,  5 Mar 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726213; cv=fail; b=Y191zLulA0pmqMDoLKotofv9TrMmcKFV3t8dUTpSHLag0IngtGACrfIadeMnMrXE8Zr8lnOpDM3woDSi2HVxFqw671AP7GJOldXCfDbddfA8NfpOp/IRYqiHR2rS34YKYREoPv9hG15kTp1ouhWEaVpBdF3j0fb1r4QzT6fGknY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726213; c=relaxed/simple;
	bh=krrV6ZYfVKk45vHdtQPRvBLAbouZ59ifnsi8MdZoZ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oh/pLqqTg6TD1dHaeNWEQzvRSyUNaJjaDm3hUPre6cUQFoSs630XFt6CCd+mls46NYOLhkBkdBW3JT8OEvBAxkCtlxCN0Fw4+R/RfGDIAR42Qx0CGx08BSAxjzMd0EDiZU+UpEqzp5tXSTXZ3XG4oA7vKUQ5IF5Wh5RQ1f1Hn5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HU8DrQef; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nN0yZgNOson9h4+2/NWiolLLUS0/1kDq/FV1fRViEED5UeLjxjZ+02NRcafuAxUVmPkffPQAW9DQkfwfaqY0fcdewWDDvDv1o+8HAh52HEofOuAtOFt/8tqtm/i8xInql4r9cUNkct4krajzybvNXLi7eSOhe24j9kkNAqDm6RaqHTiiG8INElso/3NYRGrmoo4S42eB4nETcI42QzzxzjzxjrwEJ3/8gfh5QbiFVkRydj1Yg7oCHw/3qHikLq/ly0QfCxZpkDeBhOFj42dX8UecE6ZsAKklb06Vye1bGHoMSAaAWhHxevpDOfJluBQXI2QTqKAhqfVjxMYjRBSk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0FAvOE7qZ9togXTMdRH0hDHKJIQFkfDNABzoGVYCwY=;
 b=m0ANyHquXw0ZT2YWfhLyzL3y4bOldA9qM04Uyp0+o6MoH3epLI7Pips9y2XwKI1rAfIyTQoUsOh8Oo7+DYcgakzQFolNk9jUBg8nmUXOzS8DuFXJjtML9YuLnMZ+XktuP/q7QXlYa487vwfp5cAV5Q9liP2uvx4cZSPfSWBG2TsHx1/3FvkDfrduocoyIRuVdJwVk1MISD7HURz/GoCvqUgQk/gQqKO9WnYM0dgktFcftTktfn59mKJGzYBdpr/lmaM1O8YGlq7BHvKpTupIsqmRdWY7vJNROudBbt1NF0uHgyyvsAizaj6usFWBs5zkBypZIY2Ug2U0rnzgE3zcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0FAvOE7qZ9togXTMdRH0hDHKJIQFkfDNABzoGVYCwY=;
 b=HU8DrQefFy3/MEynJ6bZcFiXDiQmzlJBcVHuRKWfPDC6Gkb1NiYdJsPYqzDFb5ADY3e3WgP+cvdNxUCtIGrmmUBLfW7xJ+QtDNuwRI9Ely2xnGApF+HEP9sLzKJvgnIMkuG5XCNB/ggMXZfhaU46gI+1vc9vkZU1SEr3ytIuNVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TY3P286MB2756.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:56:45 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 15:56:45 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] net: ntb_netdev: Gate subqueue stop/wake by transport link
Date: Fri,  6 Mar 2026 00:56:37 +0900
Message-ID: <20260305155639.1885517-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305155639.1885517-1-den@valinux.co.jp>
References: <20260305155639.1885517-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:403:a::13) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TY3P286MB2756:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ae41c1-d177-4d00-09ae-08de7acfcd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	XUM0/Op1YYdkdNOHNWf3j/qknEccK/rJXz5WCj7q62b1rk16iYUwwqgtjBrATMCU6kmdyHxIBRjcWiVuZgjWFT85O5aTQdKARSbj3JqBYoK9uhTYlrvvZUMBrCkV7HqyYMXJW/ipl5+o52IurAZxyLudtAr9ggQs0lLNdZZS6TiWeecNx1NY5Bfz/1q6Evb2s2fWKK37xrgTcxly0odmQRCAsQwcrSux2aW5FGejmbzS349LujazBvHk2W78mv7Yr6ceUDvCBWqpB/jDCvfEppLWG82WvN23uV8e3H7OXLgg/52HU1qsh2CsrvgpTNKib+Fv5M224MbuJMd/sOnwWAybKre99Y1SmHexYP3EA+mIL3nDbkxue5Jt3NY4cllUfA1etpMcgdeDZH7LuNNQoxzAThXUwiNlWCfmh9u7Btf42zzwTzqf7stdSbkX9Q2MyRT4rie+bgep1P3Q8xS5EMz5oudVne51ixyHVbLpDFtIKF+DWcm1GBlauuzn/BfFdkLX6cZhR4gNQNXhZ64Mjo4bjpnXkDcgZkwQTYuq8RWz0rxGCkRgN93/IA1x3+aNRKOYSsLhze83dYSQQO8Q9p94S/gTq69zYPwLvqD9bUH/MNZxEKZ6XHTR0CLejEeRHKP3not/sU4aMyssCLKDi43ZVz9GErQkI5QLFlItg8USsvhhVdjBJ+IftM30+CCfR5GKI+PpGZfdBnj77vVCpH6fAMAM2q4zHJg5/7C4Qr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t0qc5ZguckjDrLO2u7DwGtlBn/s7rIVDkQbrTHufoHBTuhfx/V2OYSfmdaep?=
 =?us-ascii?Q?UY9y5gwCEwF8ZDbeEuD7mH9jNy2uS9bOP7fky+f9iROSfTQ7V3i5oPhjbLTU?=
 =?us-ascii?Q?oM0HUbEDChrQyBA7zmGTBhppKWo+FPJTPj9y1R/YtSNsOG42E9/KBNvqrGlm?=
 =?us-ascii?Q?G+33wCkzPwHqLw4dsqNEiTCkvs/DEGnqZ1MsS0iAXvTPWzVM0tbyJ9GdsmCE?=
 =?us-ascii?Q?pT95VEbyY1uZQ4reho1BtSGUOpUmSp8MiRkOKqJBv9Bt+RVfnusPwV6xAS3P?=
 =?us-ascii?Q?uL4Y+vyvqIRvDbyZMebxNFMQxoNNW1ljdx2aHjnHnkUt8JV8uUGxL0mxMCO/?=
 =?us-ascii?Q?jTZOwfmCdNasDjm4fRzQcwv0Y7ZO+xJsrQaTCzfBypu6zbW6Hq35Mb3DeiXx?=
 =?us-ascii?Q?ZTPz2J07ZbZIlJVxpwSrgo2HGd7TDYc6iS5v1VGnc7iWFXjYubzKp7VQcZ9I?=
 =?us-ascii?Q?1qWFd/PHgnHfs1tfdRUtTysqso+3YhWGLqdQ4pd/4F/jjvC6bc11S6ZxN0qP?=
 =?us-ascii?Q?lD1GOZeqcOFLx9yeeYEE45S3zJOf2Jk7m2DgoWkHO6mm+N3aIktA6rKwgnPb?=
 =?us-ascii?Q?ed/gyIU9wuXMf1BuKDUBi9fCswSYNTvi+vdra8tBO2XL9D9nJzAGGpki9Uw5?=
 =?us-ascii?Q?toGd2uKefaKrSsxccq1YW0sOXEpB8uFD4uNTq1LApq7ZDEIcyZuq5qn87vnZ?=
 =?us-ascii?Q?JYy6iFnLdJeRjJOe6wEoB5lq5/HpjrM8Q0VooGc47RQTOlspchFuAHfS4yeV?=
 =?us-ascii?Q?ao0+H4kcwIJBAFufRrdzHs1r6HRJND1aYwJxZqVh5htEZ+Rud8t1gPHOP2vU?=
 =?us-ascii?Q?NCa3iH4bNCSxJ1+XziUimvZg8nwy7UrMqoQ6eZaybiUsGOkC/qAx7B3IjPlq?=
 =?us-ascii?Q?BDZ+CjKxr9HG9NllYgIJEdbRqFsOw8w+pOzEo90UxpSs/Ca4YvjGg3Hu2jFM?=
 =?us-ascii?Q?jZGqKauqUw9H7S1kV6+VBg1erghPOGC9L8HhsPjhUbPUzlTMhEJIkbh4FtVq?=
 =?us-ascii?Q?h3+nTC/qKTTWqDvz2eZcrAsRojBDtYwszTOkz0JFULBAbGycUmb1Vr8JDiWr?=
 =?us-ascii?Q?5WCXYg230TxYXFkh2yLKlP19zJJsrFFaMaxpvkW/I1MEL128YivAKNTDz/w6?=
 =?us-ascii?Q?5fCMxBnKNt0FCmvtQ+FqXOTkCZTZDWHrhHjIJ7HvVKZxJhPwUkJGDdnypor1?=
 =?us-ascii?Q?3ng6dF7amC9mvUwCmPOr28LvhOF6aAdDq6rqM+UD9M/7KVd/NWBsKvvfronk?=
 =?us-ascii?Q?6ikt+Dt9R7gMiwUWQKYPcX15danSAdsz3zK89yzMWwF7SbbiWW5A2KQJqiwV?=
 =?us-ascii?Q?+RE+5w8HMGDaHgk61kgGgkPwfl0jSUdWR2oMGKbgHPxC8KXcHSbTArsyPgtY?=
 =?us-ascii?Q?rrZp+BdiwaI24Rg8JhqmbsI9D0DAzDNiBr955+j5MXjkGgfZ0NJbWkFQy8TL?=
 =?us-ascii?Q?NztAwYk0QjQWBKpZUwS7AlGsbMTuzEDxfj31ttjLOAMrMsmfwAZm6HR6Dxqy?=
 =?us-ascii?Q?qNVkhh0vMDGuIgt30Ot5CWAsiEG3DaHYpwSOAY2eCp1OgbYVypEzKH+0EVw1?=
 =?us-ascii?Q?C7aibmrwYjSQ5IaBRB4ww3tznoagJTaQ30KZIy7FlHRqJhIs3SzvESuwpw7A?=
 =?us-ascii?Q?g/7UPlHbL7EIg+4LHFLgI+Etb51Dv1BMF6bO/oRA9z2xQPxuyX4tlAUoAkJn?=
 =?us-ascii?Q?08bxNu/WHeYpxzWchqn0XXJ+TbV94oGsr3VCAoKvd635gdSG/fB0+qYSpp2r?=
 =?us-ascii?Q?yXaTmb2zab6v+KdvuXQIS5M+UXJ5tZaH6frSovmJ7+sAdFdRL7GK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ae41c1-d177-4d00-09ae-08de7acfcd56
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:56:45.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndwwOaybYinGPc2a/V7MxCGMwCuFk9C281K1AEugzn40JVnEAH2pVSEM5bWU6r3oQLEYZ+92+U8MAGBfUmTsTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2756
X-Rspamd-Queue-Id: 0A315214FB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-264471-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid]
X-Rspamd-Action: no action

When ntb_netdev is extended to multiple ntb_transport queue pairs, the
netdev carrier can be up as long as at least one QP link is up. In that
setup, a given QP may be link-down while the carrier remains on.

Make the link event handler start/stop the corresponding netdev TX
subqueue and drive carrier state based on whether any QP link is up.
Also guard subqueue wake/start points in the TX completion and timer
paths so a subqueue is not restarted while its QP link is down.

Stop all queues in ndo_open() and let the link event handler wake each
subqueue once ntb_transport link negotiation succeeds.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Adjusted context due to changes in Patch 1.
  - No functional changes intended.

 drivers/net/ntb_netdev.c | 42 ++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 4b65e938d549..e4c1422d1d7a 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -99,18 +99,32 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 	struct ntb_netdev_queue *q = data;
 	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev;
+	bool any_up = false;
+	unsigned int i;
 
 	ndev = dev->ndev;
 
 	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
 		   ntb_transport_link_query(q->qp), q->qid);
 
-	if (link_is_up) {
-		if (ntb_transport_link_query(q->qp))
-			netif_carrier_on(ndev);
-	} else {
+	if (netif_running(ndev)) {
+		if (link_is_up)
+			netif_wake_subqueue(ndev, q->qid);
+		else
+			netif_stop_subqueue(ndev, q->qid);
+	}
+
+	for (i = 0; i < dev->num_queues; i++) {
+		if (ntb_transport_link_query(dev->queues[i].qp)) {
+			any_up = true;
+			break;
+		}
+	}
+
+	if (any_up)
+		netif_carrier_on(ndev);
+	else
 		netif_carrier_off(ndev);
-	}
 }
 
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
@@ -179,7 +193,10 @@ static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
 		return -EBUSY;
 	}
 
-	netif_start_subqueue(netdev, q->qid);
+	/* The subqueue must be kept stopped if the link is down */
+	if (ntb_transport_link_query(q->qp))
+		netif_start_subqueue(netdev, q->qid);
+
 	return 0;
 }
 
@@ -221,7 +238,8 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (__netif_subqueue_stopped(ndev, q->qid))
+		if (__netif_subqueue_stopped(ndev, q->qid) &&
+		    ntb_transport_link_query(q->qp))
 			netif_wake_subqueue(ndev, q->qid);
 	}
 }
@@ -268,7 +286,10 @@ static void ntb_netdev_tx_timer(struct timer_list *t)
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (__netif_subqueue_stopped(ndev, q->qid))
+
+		/* The subqueue must be kept stopped if the link is down */
+		if (__netif_subqueue_stopped(ndev, q->qid) &&
+		    ntb_transport_link_query(q->qp))
 			netif_wake_subqueue(ndev, q->qid);
 	}
 }
@@ -304,12 +325,11 @@ static int ntb_netdev_open(struct net_device *ndev)
 	}
 
 	netif_carrier_off(ndev);
+	netif_tx_stop_all_queues(ndev);
 
 	for (q = 0; q < dev->num_queues; q++)
 		ntb_transport_link_up(dev->queues[q].qp);
 
-	netif_start_queue(ndev);
-
 	return 0;
 
 err:
@@ -330,6 +350,8 @@ static int ntb_netdev_close(struct net_device *ndev)
 	unsigned int q;
 	int len;
 
+	netif_tx_stop_all_queues(ndev);
+	netif_carrier_off(ndev);
 
 	for (q = 0; q < dev->num_queues; q++) {
 		queue = &dev->queues[q];
-- 
2.51.0


