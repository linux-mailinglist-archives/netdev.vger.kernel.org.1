Return-Path: <netdev+bounces-302487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XgElH4weQmo80gkAu9opvQ
	(envelope-from <netdev+bounces-302487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:28:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAED6D7000
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:28:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=r+qMY8Yx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302487-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302487-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D5D13010262
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C13CD8B5;
	Mon, 29 Jun 2026 07:22:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA993CD8C5
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:22:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717768; cv=fail; b=UIJd8ZX2nr6LVRcyr5M0Ud2PERyyxeZWoHth8+mg95QhZBPxDEOLWbAWaXRydM8KxAO8hEgyIRvMwSbTOSqYDHGyTWOE0gkZRtFv/TLcrJ/fGS0eekrr1gxPaub3VsVCvQDM4BCEdUAzbntIBPSta5t63qjaNyY0IbeRTTl6li4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717768; c=relaxed/simple;
	bh=FjpGL/08uhK457Wo+LvbcVHQXgrLdY0mlgAFyWRQCbs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ssn9If668rMK4wAIRUY6TONvVfG9cA2WrfCB+cwclKc5ADOeVkjkvhx+2/sIbi/NBEKwHEpu9ajJ+1AqP3it23lxsFrJ6JLc/NKczdYM6ngVDl5fbT125soPLbtMzGp7Biz9TXjkzMdbcSa6y9duwB+WEp5Bugt8mjOOqfj0+Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+qMY8Yx; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkIxfvzGRrhnsJ11nHnSw1Jpg9CqksV/fQFjwaK/yUQKlBf1pI0973HqnxGuo62fvT08/BRosx23nfPTQX1Jh2ISQ8yXXKHxMJXAra80ftbba352pCIp1ohbssPGyc5EgDILNGIwSaJWrl3dlIUNnntjXVa+kkOVnUmAULhRS0RJyMbTVPko3a+OHirHfOG6yA4e5dsnA2cPg85y8N7P2D5tHmou0l53Oy4M51Y6YsSIRkSRUvQya1rksaHx/IhHtaMvU1XB2YhySKvx8BE5Pz9G4t3mcS3dQTLPn54cVK5u429XbU5lyPkF8htkVOmkveJwriKSSe9C1Pf8aUH4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME48srm9Z6xmABH5+MrYIAFJV7cKwrm2wukkdJyu+I0=;
 b=HmUkNdRJVY4QD2j/u1SHm0CnPF4ryQ0QmQjN4M4QDyRh0JwCt3CugQXl85NjWTUQlK00z/MVIvsFMHJy5TgcHpVVgteNspjMChz6/noWAEWQCYDtROznuHqULE1Fcy/FNNMGDgbp09x20MTrTPGuEn6wp+sa6fX6PWeqpsLvyRWzElaCxbZ5FK1Z+IRVpIIRWMJW46Wu8rA+cB5jcMeHzKdGhohaO61oX0HgyF7lAlVbylWtStZ4F38v97sukcQVUlp7njTcq3jSEUG7uj94EWJXA1f7iUbP0wEjUqYem6sepcVrkDkqCtty0aqLz5UnQjjFNgVSVWTzQwN4ZQZdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME48srm9Z6xmABH5+MrYIAFJV7cKwrm2wukkdJyu+I0=;
 b=r+qMY8Yxx9ywmoUgba7azttILzkyEyaY+IVqr9xiIOMVGS/doz99yT1qikg5WMIQKeuBDIB62EuXkdUKOUmuzYV22Td6evokRH/6N7+LCtiVc+XOrIcxuc3jizi3NkrWxViL3cjy6TQULcvqKLvfPqrY9wLI1ZA1TdghoSkuzodOnkWXt7zllmjUimuGBZtjqagtKoJnQGpJIsag0k4kcyjTEIesuuKO2G86RdoG5zs/haZhWDikSU+dMVBAcX9hIVY/gS/4Bxz+a8DypoNiUDFm7ZLMmkyWLP2Ven7bKP1V2vPdktkAp70cVgUpgV3VL/JoK9jwh05CcYmMvAr2wg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:22:38 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:22:38 +0000
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
Subject: [PATCH net] bridge: stp: Fix a potential use-after-free when deleting a bridge
Date: Mon, 29 Jun 2026 10:21:17 +0300
Message-ID: <20260629072117.497959-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aacf0c7-c975-484a-4825-08ded5af3316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kGAcpi3LRdyNQ0/BTYlG9WOaFLyllNMpTciUpzBRNULcZGfWGA/WOoUhwUSMnPw8qJgdXYkN3ddP9r7KAtfJ6h6/6v78TGOGQKnbhGXNAdCHjzn+szKPZdEsEgrjSkB4q1GpURSYD/ybtZv2HLXIdzkMoi+K+fjVOTV+wpyGsy5YpcWtef70MFbHSthAKqpD/AhOm1nLoEoOkjTrjYcCnD2hZry6GJT+MQaAh3gC4mY1H045N9x1zZhpC7LnrohC0Guwyt3+4iCUUeg+EnPAIT8HzPY01RUtBBtfQ812I23Z/ky65PnJDVOyLBCZfID0YwE8SUtjpk61x+1p9REJMNl+V/SFkWzjp0P9EKZ7MHm+FNhVG0DfkPLbgmEJCYeh6eWN+tZhIU1uDzqiwhd7QM11qNQnGTKoMNqJcRbfe+oanVhMEhp2GWkpsNCYiGVtZ+mcwopny8GPvwKvczAoCNQP9ZUvOji2D9bMZhEmTr+GDS4Q0dZ/4Nsk9LANZKDjG0QIzpnUOKyqPv9h1W9qeY4L/5cERaVYopE1UcE3Vp+k4Rm7oKamw5uwT0fA+9kS1nFnH6MfBUVVq77TPGJZL341UA/aqy5blTnIlsHzqF5uGruG5gOXTtcO1EnMi0oqArCgWPt8CbxKLRNjb6BkNeGPWuSMNjuAH4PHO5rJ34U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXYbrqFo6rBFx3WZekN7S5c9TgNMDXlI2g8wMHiCtqlH3y7hnPnFg04T/hoA?=
 =?us-ascii?Q?lonEXfBmC4tkzdctOFicjuQQ+8ejovhjGDuJyYlrvQ0OZ103D7bCYVw/20me?=
 =?us-ascii?Q?tDtfTymt/TBUTAe9PeTq/MBUMh6c409odNIvRLI9X0Dt2YDTfDaTR54J1R2l?=
 =?us-ascii?Q?+liSaqHFnttcAnxzrbJe+kcoewaUt1qIoW8rxCWyoJ0He4oNPk4u8L85WCNc?=
 =?us-ascii?Q?dIW1l9DjXZ2oEv0bg/yYju617AlaYE9HUHo9TO7wX582r8uVNEMcwR/2MkLZ?=
 =?us-ascii?Q?efsRGOEPdztu6B1CHG03t5sM0deT4+JlH1RwzpmJZfahcpm3MBa0Vt9JxMlK?=
 =?us-ascii?Q?CwWqk09oHh8gMldufA0MwLzrFXjEHTs6QrOirAu4ENtlgLOenIZ3whW/ISRJ?=
 =?us-ascii?Q?Q0Nh2yGUxCPn6BelEZMnXaaJwxN812jUCahDW02w3Lz/yiaju3Xji4ttIUxX?=
 =?us-ascii?Q?PXyOKOCVIOqeDdn2QAkGS4JxERHfF/PV9A1c4uXTFiwceAayzfxQT+1ubk9s?=
 =?us-ascii?Q?3hEg3DwuMQmX/ivIjhGzQfRiOvy/jAcQijOSfIUpobOYXGl919gW+ngOUuIK?=
 =?us-ascii?Q?Uai66Ptnly9Uj70XXCdoMK2QCQsMFYIQ8F695Qb0eVfHmdI1YDF10C1CJ6H2?=
 =?us-ascii?Q?wk+5PpdSX/9apn11VFu5fveq4aURsdw3pH/LMb9wd0QCmhP2RI3DRq0/wOHm?=
 =?us-ascii?Q?MzVfLphhWVbivi2j8g8qXs/8fuF6rUTEvTxgXWB3TZJYk0v8GfvUa/10/Rnw?=
 =?us-ascii?Q?V3DCiap4iOg3EceeSHz0bVdDqjkYZNacCSofYKKMIJr0g1STeGihi+0JOkjd?=
 =?us-ascii?Q?dPsaPgROPF7AZTH96d67NvS4z5PtuIokT3zHQrgGae2UiSTAD0qLx9gSZgND?=
 =?us-ascii?Q?9Rbq/DYGDT+CsYVvI6N6naWn3IWaq3ZkglAcgvaq9+2bhyzckne08M3I/R3c?=
 =?us-ascii?Q?Iu3vSciLauXCgvAWDdjRrEsZ7tezrwZkY51rhof+63zZ+obxCsiEKywbPSsK?=
 =?us-ascii?Q?BPFE59sI/gOjPTA2OP9dnlhdrwvPnogfyjIAz4WG1EMAbqZ+8/ojZImzryJT?=
 =?us-ascii?Q?FAx1jzGb1lfm7aJOim/XGy7q5UAkaSGUJhXBW/Ka1B0hEvFaaK1h+9lK/zAv?=
 =?us-ascii?Q?DN8i5wJsRhNJN/3FgQ5UZJtt9Ff2aS/uWryd53Q09YcaITbYtmYslIJTvCAi?=
 =?us-ascii?Q?HFkcerN6JlQjOjfj/4QlhgVmwLevH7vEla75OHUAvij3jJL1LTaUQ/nISUqW?=
 =?us-ascii?Q?ChNVKbQt8izTAJLS2ZM9JGeTEVWdb59q9gcVjwJDgSNzIZ4mZDn+NHN5PPvV?=
 =?us-ascii?Q?85yZ/RobrX5NqiXqsXaDmDOsv5zOzLxqxcjECFZopVlLfYDm9+D/nUxnnBJq?=
 =?us-ascii?Q?/84KkaiIYT6Z818l7ZRrV04xNXqVesQdRItwfHmuW+fucSyFNlLJ0b8pFKZ7?=
 =?us-ascii?Q?Oz5QjTPJjgtdVot0W053r1QpmmvtP2aevlEpqX9w0UuAoSbRhEvavtv/I8xz?=
 =?us-ascii?Q?uLyoinnhDzi7OZ9qWqEaNFna/4bUxyGq6d7ueuDB5ruZorqf+dKMYKgUsUyL?=
 =?us-ascii?Q?Wgomyu8TNadWY/23hskKUkv92+V25OFV+05lLw3Q+V7VGsnRXcwJkRrZI3YH?=
 =?us-ascii?Q?I+g205V0zbldWtQASKOL0CrtFs52llJx3g9ebTzOGCLU1ZnI1/lOgNG9lbss?=
 =?us-ascii?Q?Ubk+vP0xh8JpzBXCU1YYYIzlNCeVPjLK5UUTmbxKGGYzIFsYMYpsl/VhMnoJ?=
 =?us-ascii?Q?fISEEWZ6TA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aacf0c7-c975-484a-4825-08ded5af3316
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:22:38.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoDBlXB8igUt7mKY+/YHiJwgNBTXJ6gZjf2IQC7LltyM45p7/K0IIJkOoV+g+VXjGEVFrKhH33vmmPg0dnmF9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302487-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:razor@blackwall.org,m:horms@kernel.org,m:idosch@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDAED6D7000

The three STP timers are not supposed to be armed while the bridge is
administratively down. They are synchronously deactivated when the
bridge is put administratively down and the various call sites check for
'IFF_UP' before arming them.

This check is missing from br_topology_change_detection() and it is
possible to engineer a situation in which the topology change timer is
armed while the bridge is administratively down, resulting in a
use-after-free [1] when the bridge is deleted.

Fix by adding the missing check and for good measures synchronously
shutdown the three timers when the bridge is deleted.

[1]
ODEBUG: free active (active state 0) object: ffff88811662b9b0 object type: timer_list hint: br_topology_change_timer_expired (net/bridge/br_stp_timer.c:120)
WARNING: lib/debugobjects.c:629 at debug_print_object+0x1bc/0x450, CPU#9: ip/359

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
Reported-by: Neil Young <contact@ssd-disclosure.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_if.c  | 3 +++
 net/bridge/br_stp.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 7ed19aa8ae59..c52613431f88 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -392,6 +392,9 @@ void br_dev_delete(struct net_device *dev, struct list_head *head)
 
 	br_fdb_delete_by_port(br, NULL, 0, 1);
 
+	timer_shutdown_sync(&br->hello_timer);
+	timer_shutdown_sync(&br->topology_change_timer);
+	timer_shutdown_sync(&br->tcn_timer);
 	cancel_delayed_work_sync(&br->gc_work);
 
 	br_sysfs_delbr(br->dev);
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 46919d73d42f..c7e7e924f155 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -382,7 +382,8 @@ void br_topology_change_detection(struct net_bridge *br)
 {
 	int isroot = br_is_root_bridge(br);
 
-	if (br->stp_enabled != BR_KERNEL_STP)
+	if (br->stp_enabled != BR_KERNEL_STP ||
+	    !(br->dev->flags & IFF_UP))
 		return;
 
 	br_info(br, "topology change detected, %s\n",
-- 
2.54.0


