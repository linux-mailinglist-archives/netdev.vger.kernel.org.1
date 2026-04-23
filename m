Return-Path: <netdev+bounces-280655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGjoF3rR6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ABD44E416
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B209301548F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF58B34D4FD;
	Thu, 23 Apr 2026 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zenlayer.onmicrosoft.com header.i=@zenlayer.onmicrosoft.com header.b="b7lz7m/B"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021116.outbound.protection.outlook.com [52.101.57.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9C7349B1F;
	Thu, 23 Apr 2026 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931190; cv=fail; b=RKXcHWnBCbVSbGThcbdFF9dE9sw1e+p+9HeuUGp/Tm3KPXW8m7xenmkNltmaw8AabVau8lcbak7T/xrWUdjEZ5YEMQJ4/S7TircPmHzHFy9ntuEN4ZPDsmaTJypJeOBQBUf0WQDvgDDLNRkoHlVd3TwW7lvZ49sVyg68Kkkde10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931190; c=relaxed/simple;
	bh=+/VtO9LlOqBxQoL36qaoP8vvs/4OaGB9T/GlGe+GMM4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IFF7N4uZXPn1VXeuoJUo6X+D/DiuvwQTgnlSzH0eSMcx/8EDjDztEiad73Co+tv3kNpoBoJoN7MPvgO8tM+rHHPwhAQ4E6L/HLyQE/PhUAK/6OxR37UnhHWmM5Tdok3k8OKOU7tfW9pczoAmSpEOPkCiWSu30HFCB7kogqe/6hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zenlayer.com; spf=pass smtp.mailfrom=zenlayer.com; dkim=pass (1024-bit key) header.d=zenlayer.onmicrosoft.com header.i=@zenlayer.onmicrosoft.com header.b=b7lz7m/B; arc=fail smtp.client-ip=52.101.57.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zenlayer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenlayer.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mg76hqzcPl2vnqQNjKuKoN9wNTkC5FbVKpULYoWsGxRHFQy+Djuf0/8cryJvnBVeUBlKrwGYWNeCal90dgqI2nudE0NkrkLMdn6zPqMZl9A8JZKEaxpxc/v2HdgCNO0SK9pEYyw5Nsv3xW1qe4ojfWIJNhr575BkbbLLmjCYYufNeeP7QwJYXdJ6IalVi6FndV3gR4SHb9znzYOQD0v/6qFof79SvJtRODQ7bGb+6pwFrHT2Ue16TsCuGVWACKrcrEGseC9YJ6xO0MlbtqewnRPmgcO731rBJSsNkP8xcaZNVIoMjxT+Qf7IviLjEH1bSYNjno2Rs9hzAScGNt6LFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VdTUYm3SqZ/VlYEhYuNlO4v3fOjX7mr/8uRbdS1hEw=;
 b=BKtAFdIDBH/ETslx1x/d5+92muTSZzbiBAcy+srjk9nsSrZ7FZc0gub0ax4WBRZuMmRT1ptuLvPHkHfbSAFtQ7oBGJ2sGoenojq8SBpGR9DXz0kUcW6xt4hlQtbQkWuRGpQDjxt9xtgmerXBWkn/BHNZ+PL9DhALZdjLI05pSg40REf2m+8ELEPUUDXyypUIKwVRbAV9MZijQJVjWSaJ8uOeUZdIRsu+YGPj4dbSH7m5kwGK3yo/6ArIerzXEMAKWAiqZJZRfZAT8+M3gic8oIkIMMXcGDndNG20HrD0E0ruW3z5EatSqRPi/HiOto2vbV2e5d5STAAqmzhwPUdtQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenlayer.com; dmarc=pass action=none header.from=zenlayer.com;
 dkim=pass header.d=zenlayer.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zenlayer.onmicrosoft.com; s=selector2-zenlayer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VdTUYm3SqZ/VlYEhYuNlO4v3fOjX7mr/8uRbdS1hEw=;
 b=b7lz7m/BedseE8R3xmEafElH54NhTOSXI5P6L+jmigD/hcTamWBErF2pdXqAvJfd1qVmDiFVvscSI9vHeVam5BztgOwb5AYOzlD62n5M+DxdLcidHlmTM1wPNvLrnVkS/gt3MG8+lNauymeIX7Nidc1NeeL0vuWwLK+Pn+J6qoY=
Received: from PH0PR20MB4352.namprd20.prod.outlook.com (2603:10b6:510:14d::20)
 by CH3PR20MB6491.namprd20.prod.outlook.com (2603:10b6:610:15f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Thu, 23 Apr
 2026 07:59:43 +0000
Received: from PH0PR20MB4352.namprd20.prod.outlook.com
 ([fe80::7b1f:ae02:3feb:7733]) by PH0PR20MB4352.namprd20.prod.outlook.com
 ([fe80::7b1f:ae02:3feb:7733%4]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 07:59:43 +0000
From: Faicker Mo <faicker.mo@zenlayer.com>
To: "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "sdf@fomichev.me" <sdf@fomichev.me>
CC: "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] net: net_failover: Fix the deadlock in slave register
Thread-Topic: [PATCH] net: net_failover: Fix the deadlock in slave register
Thread-Index: AQHc0vb1WqLSawZDM0qeuKlUGTpEPQ==
Date: Thu, 23 Apr 2026 07:59:43 +0000
Message-ID:
 <PH0PR20MB435271FE3258110CE77261BBFA2A2@PH0PR20MB4352.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenlayer.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR20MB4352:EE_|CH3PR20MB6491:EE_
x-ms-office365-filtering-correlation-id: be44a7ca-84d0-45dd-f733-08dea10e479d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 jao2yCKXMWzWcsAS23ejqXvHKk2h2FRphfAPVeBVLLLTI77jZm1Pa1FnU8vs2kDK0/tJAZJ6J/yYGk5tKpe6H6RyrVVnmKnriBuBgiEi1TFCHipWrhEJa6lrv8uONRmO/d41/txpsOGevbLWEzRVx/Tp5YYPbAWY5c2K/UsLSjWmbAEYz9wCRqhtl0zDMm0pi+3OBa3VCgoDzCwj9XEGXhiFh8eeLbQhiebSMNTub2TJE8qNbUgjBwGE2V15xpNKmnmF4+fSnNj3Kzre/qFVygvGAS3Dc8c/ZaL3E1F6R6fTJDyfUhfAf8tu5zep0LtOrom3Y0ZU21tmBhzXKxR3cBMDr3uwrNCvV81qtTPJ57qCt0HZ9OOjgCIruh9DkQlUe1m+qRB/nEw1KtUmcJlgVSzMC0LHwOe4SNVu3MndZqBuGoT+SLS4ojegnz4ogImjOlXwry5/TiCccpskq8HLFIOps3rJ8MrgR6z2xhtW9ra2AxO8ELMa5AhlJErQr0mb44UKdCaGJZ6hLKZ6voY46K+r5oynbs+tofdlWO9KHjP/LsnGSzLa68wahAzuaRr1oyqU3T0a1kc7DiH1cT0pO90s5TLS2SXNzi07LMfMRQehflVWmDiiQyl6kWkQ6wA01X2U0MCyBJ56+TNNPiRcDbrwpupVabV1ol9Kt14FjJtTA2BhetIFr9b+o0WdO4JTI7KHYSkfBmKUJMM8IJ2hrknm/O00zjAcbyXiAKEo4sG9UdnjY9zb+TzSt6J+Df/zZp7WuwJnG1HO+GHGQ7V9OfPSIcY7Wn4z9S+togjHU4I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR20MB4352.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hx6jrjMw4jROnU93HfVqjA+XvfYD212WumbGXQZJnE3N0/YWLLKa7+q11h?=
 =?iso-8859-1?Q?0nWZGfGkHIcMC0FKJU9pYpxzkwEzk6gPne7lDJLD5TbifJeVg4N9SWkbWC?=
 =?iso-8859-1?Q?nh3zmwhOnGfN4PeJ6PKlfigMNt6Km1DhhQEuw05c+bP0PlhVrWPvUVm6wB?=
 =?iso-8859-1?Q?oKW436IobTGo120LBEHVYhoKn2Amnt4CkZ/0l+XODRgRF2I5Ug17oK8Gu0?=
 =?iso-8859-1?Q?WV+nhREJqsjEAVjwlq3kaRC9M35w263aIzcn1bs47xgwUKvNoyTb2pjcVa?=
 =?iso-8859-1?Q?bsVQXVczAgRMdhQyAKZsvthpAO5qppOEGJpfvSyQt/VVdpDhpvirOoClGK?=
 =?iso-8859-1?Q?84jDE/41vCipRVeEDzduYu06Bq6pf7dO7MRE8nAy5EJqChYN9q4vyyQ9F/?=
 =?iso-8859-1?Q?S+MPmXeUMi7mkVj6mC1lBpuQ7wzBLRlv9aECaL9n+J0yh6SSE3miFu4PgL?=
 =?iso-8859-1?Q?ze4TFbZe897zdwibinzFMXMTiJ34CMMaLsPym2vDS7sALDomwy9+6BMqDh?=
 =?iso-8859-1?Q?On11iKDYBX1JIR8AYwwwFAZTED/zw+8qkKdq+swGijC6yTpxU/wr9JiKac?=
 =?iso-8859-1?Q?NgeXhO3eSf2IgALq04932aPyqdcF0bJDpDZ/nXS+3SyK21c2YojLcH9jFf?=
 =?iso-8859-1?Q?/B6IaQfq/iolyWpMX4P46bnRDGCb4Vv0rzOfyxQAFAi3KhG34liSjdAudO?=
 =?iso-8859-1?Q?3PWrVL+8yAJ/j0kf98aJhuJ4kiAinf0B2lI351h9gXB6yb+NsSs+mYkROo?=
 =?iso-8859-1?Q?34Blb5ueEfMvYp8kqs09iVvPIR6JMEfr304jTqgJsgUNjilQUPi2n1WI1g?=
 =?iso-8859-1?Q?YnT5/vZU6KmmD8TPZsJaN2oQU47AXsOD24+upqSDjyGPOaiB3LXZTm4jEf?=
 =?iso-8859-1?Q?/OMs1y+C/S/cdCVUOFZBiTsKB5o+rG01Kp6FGpyzF5NZk7rFtJmkzj6txU?=
 =?iso-8859-1?Q?3Kp9asIafo3gtkN20dWCuIvcTVnMqzywAxaz3UipR9w9cv6/WEtmGp5FOf?=
 =?iso-8859-1?Q?DKoZS+arovTkQY8IuZIiZnwoqd5GJxkkIZwpgJeGiumQh5d6F0ddSok3VW?=
 =?iso-8859-1?Q?K4jughxWiyh+82kZQ40HDxXb63V9+tFmzpD3xh6EcPsQtIPmwazPxZYmkf?=
 =?iso-8859-1?Q?TsUjl//VpitjVnyBpDl384fldQDi8uX2qrQQX/D+h3MwW2pTi45cT3fvtc?=
 =?iso-8859-1?Q?zlUNTEjbiHBs2A/aCe3sSrPKcBft6wZKvw9TQZivEvXZpavsBbM5qz+bpr?=
 =?iso-8859-1?Q?1v16dpymGsJ9BiNyxOS/GMAFzs9kmKM7/WdGBsmiTy8YetzmMAAePFWpGj?=
 =?iso-8859-1?Q?vH7dvThaCYETB0Dh//aLEH9bE0w7u3OBs5cBpSRAezllYvGhQLHQUfJC+B?=
 =?iso-8859-1?Q?JzZlUlVIAIa0iPnS/5oRhYXN21wSMEMllu1jydzeeWLORcKzi0n8SemYhR?=
 =?iso-8859-1?Q?rNjvoz1NUXpsk4SHqjVjCmhrZJuayR9lOaY7NVwzPNfuyhJY6FyIDR9gjd?=
 =?iso-8859-1?Q?z0w6XzMKTBge/wmk17tqTc7NWUTHSg+Bt4AF33nO8x79l36/3k6BxTd8cd?=
 =?iso-8859-1?Q?ZFOKIIKKyIIs2Pt17q61YC6Q//MncxfR0Mc91QabrtBkuVqSE6YeRHN4dY?=
 =?iso-8859-1?Q?1cMcMFixUvnV2P/CVGLO0X9xJkv9TZIS3Blb5aXelrEp1MQSfmP2QRE15B?=
 =?iso-8859-1?Q?GELyYg9yzrCc2DU/M6WVbhZGuaag2f9O+khyLQh3NCMEOW+VggcdbfXEpv?=
 =?iso-8859-1?Q?ZE/UAuN/+bplyYIZWjL7U90gDat2K+oces3CJE/z4Qi68fGBLQ0/leRD6N?=
 =?iso-8859-1?Q?ANQeUeWKbg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zenlayer.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR20MB4352.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be44a7ca-84d0-45dd-f733-08dea10e479d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 07:59:43.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d27725c-b11d-49f0-b479-a26ae758f26d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vzTxyQyhZT+w/1d1A2Gv/A0/+Og4GzALZTQ4d5hRSUhgYp8lC8E/+VmPG756oIimXxXCtMpQbzCMLrSg3b9Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB6491
X-Spamd-Result: default: False [3.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[zenlayer.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[zenlayer.onmicrosoft.com:s=selector2-zenlayer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280655-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zenlayer.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faicker.mo@zenlayer.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zenlayer.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: B4ABD44E416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is netdev_lock_ops() before the NETDEV_REGISTER notifier=0A=
in register_netdevice(), so use the non-locking functions=0A=
in net_failover_slave_register().=0A=
=0A=
Call Trace:=0A=
 <TASK>=0A=
 __schedule+0x30d/0x7a0=0A=
 schedule+0x27/0x90=0A=
 schedule_preempt_disabled+0x15/0x30=0A=
 __mutex_lock.constprop.0+0x538/0x9e0=0A=
 __mutex_lock_slowpath+0x13/0x20=0A=
 mutex_lock+0x3b/0x50=0A=
 dev_set_mtu+0x40/0xe0=0A=
 net_failover_slave_register+0x24/0x280=0A=
 failover_slave_register+0x103/0x1b0=0A=
 failover_event+0x15e/0x210=0A=
 ? dropmon_net_event+0xac/0xe0=0A=
 notifier_call_chain+0x5e/0xe0=0A=
 raw_notifier_call_chain+0x16/0x30=0A=
 call_netdevice_notifiers_info+0x52/0xa0=0A=
 register_netdevice+0x5f4/0x7c0=0A=
 register_netdev+0x1e/0x40=0A=
 _mlx5e_probe+0xe2/0x370 [mlx5_core]=0A=
 mlx5e_probe+0x59/0x70 [mlx5_core]=0A=
 ? __pfx_mlx5e_probe+0x10/0x10 [mlx5_core]=0A=
=0A=
Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")=
=0A=
Signed-off-by: Faicker Mo <faicker.mo@zenlayer.com>=0A=
---=0A=
 drivers/net/net_failover.c | 6 +++---=0A=
 1 file changed, 3 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c=0A=
index d0361aaf25ef..6702490eb4ed 100644=0A=
--- a/drivers/net/net_failover.c=0A=
+++ b/drivers/net/net_failover.c=0A=
@@ -502,7 +502,7 @@ static int net_failover_slave_register(struct net_devic=
e *slave_dev,=0A=
=0A=
        /* Align MTU of slave with failover dev */=0A=
        orig_mtu =3D slave_dev->mtu;=0A=
-       err =3D dev_set_mtu(slave_dev, failover_dev->mtu);=0A=
+       err =3D netif_set_mtu(slave_dev, failover_dev->mtu);=0A=
        if (err) {=0A=
                netdev_err(failover_dev, "unable to change mtu of %s to %u =
register failed\n",=0A=
                           slave_dev->name, failover_dev->mtu);=0A=
@@ -512,7 +512,7 @@ static int net_failover_slave_register(struct net_devic=
e *slave_dev,=0A=
        dev_hold(slave_dev);=0A=
=0A=
        if (netif_running(failover_dev)) {=0A=
-               err =3D dev_open(slave_dev, NULL);=0A=
+               err =3D netif_open(slave_dev, NULL);=0A=
                if (err && (err !=3D -EBUSY)) {=0A=
                        netdev_err(failover_dev, "Opening slave %s failed e=
rr:%d\n",=0A=
                                   slave_dev->name, err);=0A=
@@ -565,7 +565,7 @@ static int net_failover_slave_register(struct net_devic=
e *slave_dev,=0A=
        dev_close(slave_dev);=0A=
 err_dev_open:=0A=
        dev_put(slave_dev);=0A=
-       dev_set_mtu(slave_dev, orig_mtu);=0A=
+       netif_set_mtu(slave_dev, orig_mtu);=0A=
 done:=0A=
        return err;=0A=
 }=0A=
--=0A=
2.34.1=

