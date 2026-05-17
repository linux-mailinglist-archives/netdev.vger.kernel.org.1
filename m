Return-Path: <netdev+bounces-288725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDGNJM2rCWookgQAu9opvQ
	(envelope-from <netdev+bounces-288725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:51:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C49560D64
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8DC9300D168
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31435A3B9;
	Sun, 17 May 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uDlYeZB1"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1C2DC798
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018657; cv=fail; b=koEIWXSZg/BtpRozWXY/JWIsO+/JyohFQAbibtTcEpf+5VdjOWpn/Ht3q0br/OKaGsg3C6dVkte6S9khF3RCC2uE+wIVbpc+Rq4OFqOCYPxiWO/Tytj3x+0Pa5pJBytHgXI25em+UwIK9d6qIwbwOwW0kW+po+IVpkODcAFhafs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018657; c=relaxed/simple;
	bh=xZKLNFVLFwWVl5PF8A4mbG5mtbR0gCaBS+SsKN+AT10=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ehiOs+4QkXtnQBIOcQO+ydyu9aG1FEip6QnlKVgMNm6ideLNAKp2QvVBsvHK+PFWmgZcIYEW0/Ams1HFQ438VlIx6Jdes9MNlEx8z//J57VIKwFzYjndy45IcuduU5Yoq76G9rZK+MDY4gvnQ29giPmJgz6ldm8Iigu84qYnI5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uDlYeZB1; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H97vGt+CzOdlApRGttk+crybJtFoiu3b8+2ne10dQm6zugToegIU3KKQAmgsrFNXkhyjWoq3dxfXM+OJfcOhsW8u+f+xq9swzMyMEuhfmAlNnDPvllRZyHv07oBUAmp9EGUiFQWZayfzR6NT5eokR+svef5j3j59TSkkBSUb1kcvqr8iSgqxnHuTRsDy+IW1cdRCndM05GWkzIya+6NU17WdPLncc79f5wp2cIwRHl+OtqyQmkU/T5CkPUQ47R5bXTL+FYAIeZZXDs3bh7HcbKZtSoc8jaWU7MTCi1qYPm25SFF4Zf++F1xeb/89cd41HnZiLoqxl7IjMpTFED/8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iai0ad2x71KOxTgMWXLRrX4j3JBHRYeAAOVgzegR9pA=;
 b=l7U3Us95vVzcbUXoXC20pXIh5DMsCYdwlwFI8WZdwZ/l1Vy5zqfVSMqpiEngXaX5XtJDfeBREHpYLEehPsuDafARAHtqf/yX367gPSGhVP22b++L/Bjr5iNOuSoixpUS/sHRDRQnW10aYs7kP4HRfF8K53GPMJ4uOP1enMnGDCTCypFDf/7V/aoeNEvFzaE95/JOzjs7APOBYOyevIb/7YqOcWJrzaNJDRYia2OWQSAPLZZCKJyjJiJ8Tv5zTCl/SslRSxCtBfbfBnmAVmyf82wyO18BpyeWetRLtWTj85QBNX9OGi/WJGNUUEQkDB0Rcbs9vgi2FVqezbG7jOGwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iai0ad2x71KOxTgMWXLRrX4j3JBHRYeAAOVgzegR9pA=;
 b=uDlYeZB1VuYwvCaI/P5RhVxE73Qvv6WbydfbvaV5Mj3Ux0OIk1t+srylcQKJhmHAd3mQcOL5uwlNYiwccYBnQJKH6DGe/9U/04NKLtbNrRvFJvSCPkhnvsDq2SCabOvHyXPxjAvvhG18T1kfJ3U0bmfHj/BVVayJ4usGxjxJa8w8oblQWEB2x1Lm3K9e0TsjjKc+PzX8TxClztMEWOmhDffogCYJokDdcqZpnKS+z6NCBoGcskehQ0iG8usAPT5hjWTXwyU+DwSeRbvN4uaAuNeZ3BybyTvWHWBPaDuQqCcMEbRKJv5J/1sf05HmfTX4g39OxFFeBtqatNMPEKbUew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 11:50:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 11:50:45 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] bridge: Add missing READ_ONCE() annotations around FDB destination port
Date: Sun, 17 May 2026 14:50:09 +0300
Message-ID: <20260517115009.175163-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d04966c-ac06-4a5a-861c-08deb40a8785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pZPRoT+rcUKmTZV0N36Xjwqgp+nfwUF2+G01U/dJcuyJTte+Cqr0VGOTmHPcA2u2nNhGkk2oG6Gax6/P//cjjpT1MVPBZhz/vM8Cf2saLNB2qtMsZyM2QtjTp7pn83wFeCYrlKyUUtTxSJQb/kKRi84xrZ2s9WUSzhFURtHhmLHsGwumgIlHp0evBfaE9vbhhbaoUpLHnAGVxiuguDpL1eeFktQrtSBNk4imRwBtWWQzne3H7/L6x9V3DWSOlaPwUHaeyLXIWuTeZBy5VRTUfW0qxtd7pyhaHAP8tEfkm5dwmk82ZAuS9cwVee1SJAEZ+7cuzcRBrcp0O7pSCO3VQTX4bSfa+OgUiZgIhIYkNyaRmZEFoAskI5pimyjwEL31wsKYNW8FDke5Hgqs2XUhddGhjFxa6f+PsSKQ9CiqPIGeBKdaOf0IqdLR/uYnD9XX0MFcnbC5KluWqKCBLRDMMfFVFKJQyquA1u0i6RnYiFH6X6yMXYRNB6hyeQpUuffHycHcMA0ek0wvRJWIW3x9XFOwxrVJp3e4DoPTUU1DrIi/T6Tolcw1tNP3AQMScaMhMiOnuPqTrycrkoYiTD3dEICnRdVJr8aBVFwpgX1wlOoBfkbBCLRxX5zSpZdFPdpeVqDI/ZbWS08Ejce5WXsrTMIiYPlXi6+SuLpV0H1UOm9Y0FTnh/DIEzK9SRF7rVZj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B3wjD5oLz3pygSPxkUQY8ajWQmtgG/qdgBjGWygFM6DUxSohYU9rNLxpyre/?=
 =?us-ascii?Q?ywVouj67FLtOS7/QZVLnpewVsasRJjyJyTfKFr1LEdEMwpJbji6+DWwXibRk?=
 =?us-ascii?Q?F7IYJJYQjPSdCg3/ZyoI5mfTMvjDJhv5TBbWzWT+FrAnIivaceDm/mfWbHV1?=
 =?us-ascii?Q?vQBHCbAgtDmjzl6nwUvUh1+agn4kGYMTXbHB5CrjPkaI07BW7xy5QNwAbdBo?=
 =?us-ascii?Q?tgyOKYaVgnsVeSECo99ZqF3kzKPp+Oe/rs0FYZhu3y26CGViaiBr1Wq2+QFA?=
 =?us-ascii?Q?VT5dNnL5+7/FEBLgWI8Nkb9eOcMpcdwOVR0UC/Lr1Hl/Dfvx1Q0t4RS0RCH3?=
 =?us-ascii?Q?HujBp9dc0OHzGbEp/plq5JCBJCMx1xyl1ARN2zAIOw0V9LeHx+SSXiIjyWpQ?=
 =?us-ascii?Q?JjeGzgEPa1EXEhOy4JmRDBXa2GYc+bfglIYnATHjtezgLD5iDkDCa0+6QXs+?=
 =?us-ascii?Q?3EnpfAIrbpBsZKgOckwio9kx+346lNYMx9OeBqqaKWlZKiWRMsXPMDG9Dn3s?=
 =?us-ascii?Q?/l3aadRlDOzIKde/uT/P3RoctlqUXRn8PAd1DyN4YzL4rWgubkXvvZmeuFyf?=
 =?us-ascii?Q?PpGYqXvvdfzQDi+e+e/JYO9ngWaCATaZlBeIs4EWE+EkRKu4gncwTOHQEQ/G?=
 =?us-ascii?Q?twReOS//3NiGCT/PuTv9oMxEwVwfIbhjRTMdjB64WZWI5mvv8ts/WryAHXQs?=
 =?us-ascii?Q?rScpS09eyvw5MThZNZfX3ZjDqKI3BawCqL7ai6QqutSFh9MS0oRjNHJQgjRz?=
 =?us-ascii?Q?8hfGCvnS+JRqpiFv8EdALHfsOQHK8iU0eTP76U9iWQ2xAKQ7A6MwyD677MMr?=
 =?us-ascii?Q?f2M08G07mIhrgtQ0HWf57XkVKKmNwVbwQstRGJ0tpuD9gh+1KSgJygbcNMIe?=
 =?us-ascii?Q?9lzlpYGuTXplxMtvm1tmmp5BfgTlRoL5D4yvSoZAeO0brJjKyOpyQ2aVkouZ?=
 =?us-ascii?Q?LuVRuJ7JQ54uteQzl0bsweOUQc9D5sWpRtZn2WRNfvoT0YiVF3T2y3+IUnh+?=
 =?us-ascii?Q?GMOJvYesaQtdLxaq8/vO2/dTNrJZr4JS/2HJXazYFEFTqqI8sUKlbfKzsU4j?=
 =?us-ascii?Q?5m+ZveLtwSvnFGb0cW7/LsSjEVLuhabTqium0xdlCB2s4n0HoFtWjf0DtuZx?=
 =?us-ascii?Q?FwigAZIG2cBAeXwDPpD0yNtgfsljHBNHw8I8ObmTefp7nSZPRp07FY6JYkq7?=
 =?us-ascii?Q?SVcMbOz3d14rdihObOQ2bG+ojTrlHmcgHyik65B4wDi7flU0/8pi3n+h/B1X?=
 =?us-ascii?Q?TPRt6wrUaf6HeqqiK0moZQgw9ng2jnWHja3sKq5AvX75L8qVjKAmP7tcxjNN?=
 =?us-ascii?Q?NlariRg7PGc9QnRYMTfK6TGPhwj+v4mAHwhZaziLrl5VN9TZajglcvm6DKAb?=
 =?us-ascii?Q?lmpqR5vEXm6KyDN/aGUnypW8jCnHoDIYHnvgGTfDWwovDNgX8qfbtxXPM0y4?=
 =?us-ascii?Q?JU3ZIyngAz+iWrwJ4BVZarJR6LQyAAIyHdifRzZmpg87lZ0Tzv7P1vfH6FSs?=
 =?us-ascii?Q?IOK+kV0Ko8B4iBiq5jivl6ye4AYCesKiWaXh5vWGwAh21O8kkxo+18cOPEln?=
 =?us-ascii?Q?U4ItixsPswhYwT+j1SGvsaKi57xvgAnGtLBuZDIzYy/tr/FCFgmfCNYti3oj?=
 =?us-ascii?Q?2Fyat5Hh1Nh+h+Xa5rbYA5QTKaoWP5PxOS3Nzyf1dvzHndhGtCk9/Y0LrezX?=
 =?us-ascii?Q?SafDXOAlWP/AcYhdb4FJOFUYIceaQFH7a2wz0PO8YSaF44Sl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d04966c-ac06-4a5a-861c-08deb40a8785
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 11:50:45.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lLzZ2cKk9JhTEjJiGsBzXR+xbcXCr1dGDPVMASBQvCn888GW0YoFm3V+Z9XjsugsBhxw0gtm6Dudr0LaGCstA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
X-Rspamd-Queue-Id: 29C49560D64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288725-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action

When roaming, the FDB destination port can change without holding the
bridge's hash lock. Therefore, add missing READ_ONCE() annotations in
both RCU readers and readers that hold the lock. In the latter case, the
annotation is not needed in places where the FDB entry was already
validated to be a local entry since such entries cannot roam.

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_device.c | 2 +-
 net/bridge/br_fdb.c    | 7 ++++---
 net/bridge/br_input.c  | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a35ceae0a6f2..e7f343ab22d3 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -107,7 +107,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		else
 			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
 	} else if ((dst = br_fdb_find_rcu(br, dest, vid)) != NULL) {
-		br_forward(dst->dst, skb, false, true);
+		br_forward(READ_ONCE(dst->dst), skb, false, true);
 	} else {
 		br_flood(br, skb, BR_PKT_UNICAST, false, true, vid);
 	}
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index ac81e58d5f70..a114373c9816 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -470,7 +470,8 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 	spin_lock_bh(&br->hash_lock);
 	vg = nbp_vlan_group(p);
 	hlist_for_each_entry(f, &br->fdb_list, fdb_node) {
-		if (f->dst == p && test_bit(BR_FDB_LOCAL, &f->flags) &&
+		if (READ_ONCE(f->dst) == p &&
+		    test_bit(BR_FDB_LOCAL, &f->flags) &&
 		    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags)) {
 			/* delete old one */
 			fdb_delete_local(br, p, f);
@@ -878,7 +879,7 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 
 	spin_lock_bh(&br->hash_lock);
 	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
-		if (f->dst != p)
+		if (READ_ONCE(f->dst) != p)
 			continue;
 
 		if (!do_all)
@@ -1631,7 +1632,7 @@ void br_fdb_clear_offload(const struct net_device *dev, u16 vid)
 
 	spin_lock_bh(&p->br->hash_lock);
 	hlist_for_each_entry(f, &p->br->fdb_list, fdb_node) {
-		if (f->dst == p && f->key.vlan_id == vid)
+		if (READ_ONCE(f->dst) == p && f->key.vlan_id == vid)
 			clear_bit(BR_FDB_OFFLOADED, &f->flags);
 	}
 	spin_unlock_bh(&p->br->hash_lock);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 2cbae0f9ae1f..470615675bdc 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -223,7 +223,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 
 		if (now != READ_ONCE(dst->used))
 			WRITE_ONCE(dst->used, now);
-		br_forward(dst->dst, skb, local_rcv, false);
+		br_forward(READ_ONCE(dst->dst), skb, local_rcv, false);
 	} else {
 		if (!mcast_hit)
 			br_flood(br, skb, pkt_type, local_rcv, false, vid);
-- 
2.54.0


