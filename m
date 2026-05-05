Return-Path: <netdev+bounces-284329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Go2H1rI+WlhEAMAu9opvQ
	(envelope-from <netdev+bounces-284329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:37:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0710F4CB884
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 153363083285
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 10:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A305933D512;
	Tue,  5 May 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NFwK1Rb/"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2833D6D8
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975951; cv=fail; b=spLkchFJfoESP+Eikyj5fjcKQbGBBzUhetUDlwvEs+2QvuYN22RXfjlB02kEsNjGbkemM9T5VpJsXYusnE0SgnMKRYQJcXUn9xwH57SGTzL4T+zsc+UEK4iWVnVA8wb/Ff1M2joPNuJXxx1vzkQ13qyod4gVQXE+aL+mCFwnxIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975951; c=relaxed/simple;
	bh=IVY2hKKDYzsYeZ3wGuib3zonE6HvlhYI+g+xBIHzjjU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rZxlGKcZ8jbh+LqOEKnUY9niSvTJVGUPZ3xzdGEvMRG/OTW1SIordv1e9GRcVSeSaQoflETRe/mtDCJl9srvDH3zTI3sMMyosBlsWNf/TqW/LoWLRVmIWlYvzTwIG/JyBgCVvHdFv84QOXZJ/BZtNao3xa6SJMn2FMOZbwldFDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NFwK1Rb/; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezvq4mKJLLqQ8Y8cam9hL89oS+PIvrBNxyjDVYA02ewEfn6H66CHptKc5VhKN2ExaklwQ2AUuzozerWUyGZliliWZdfr16JyqtBqYZMcRFyWRwg4a5dyG7H3cDbvTlWwNo0oG+OtVP2jZpeioap8FqANuoJc0CYpPi18x4mEiDvrZGYuBaT80JzB2lykVHnz/LobjAatvQNR/9pE3f3UiDzEkXZLfIEYfabDI0lRNcrryTjRce9Ue9ZS7k6CVa76HJRT4z4mT3ridMpRyot/1uYnG1gKFa2sL9zyZ7P7GmfnwHzXZjy2lhzadL9DIMcvO9GQUO5p7wOvqW321abkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+GCIO6WOU2AqsVuMMGi7lB0g7tvo40BR9EO6aKtT38=;
 b=ci1odYiPvTF708RlDVNXJZhZ7/feIned+gQ0dYkylUkMnbQGxwihp6Viff7llKRomXHXiXxpu9/He9ahngX97b/XSAU19fQ4BIcqIsa+R6yzvPeegKd07czPBLy+YzjWWvCHJdRd8Ni+eSY8jDYskKA8Bz14zNak2UiUkkfpp40cZIycQkTLZt5rzaIXzE73c20DHec68OEGwBz0p4FfQB6qQnio3aaOHHi70MZotliFFJcFaqMzoSXFAPczxFVT2WoVIuTmfKUCjvm2EZgizwmoYmtP+nnflNORI8XDXk2i9G6ZKnhw248emmcdAeS1d18xX1KiJYWi6nWyFg0vCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+GCIO6WOU2AqsVuMMGi7lB0g7tvo40BR9EO6aKtT38=;
 b=NFwK1Rb/OI9z3cjFEly12P2dGFDtkB8PRc9BCC083O8vCUchGLvFg5V0MVXpDmeX49GC9XmmReTjTquJNzfDiUgBiIevctkdXp2yviRerVLePWF5rXJVwlA0DbOUoH2hwSff15klAJb5IT8FyHsv0/OKOgTTt/f9VG7RAsokmidna8kaqBpe6HXQGCLC5LB8P1STKzjRs+3YHAqAg6oQYDng87YwxB0g4p3jg7sQZdyTP4eMSj9GlP8fK7cA/mtB8VOpE12+2spoKjN/ew1SMb0bOWXE6HeClsIpAIExM9hQhTt4Suy41TIbXP/JL1hFaNONa8k1H5bCWDPBclZ1pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:110::12)
 by VI1PR10MB3710.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:12:25 +0000
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599]) by AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:12:25 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Yan, Zheng" <zheng.z.yan@intel.com>,
	netdev@vger.kernel.org,
	vivek.behera@siemens.com
Subject: [PATCH net 1/1] igb: Return state in pm_runtime_idle instead of power-down
Date: Tue,  5 May 2026 12:11:34 +0200
Message-ID: <20260505101141.2657169-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:110::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB2546:EE_|VI1PR10MB3710:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd3bdfe-8a1f-49f9-0eec-08deaa8ecda8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	7J3nzaEJQHTfQ1xqphIlApaX/eBNky4lk8aGqNAC+QsRdZd/OkRGJkjDKveF7yOB7kANAV9CY/umJD1DuaEvwcNvDexS61EVOJmoWPQTVq6+TOjny10oNiqQY9v/ZHTJFNzdIBP1qTNIXi2pp1MMyG4+jaXiZOGMR4VJKi8+HbMcS6nJjz2EfnryJ0xBt67HXHMhYmO55NDY9EZRHtmWyYoImRyG4JjJ6dKjucsaJvvZytXe4lEpO2+2sm/ZMNlSSsgUoEzvONm1XkZB/YuMKdc/PXa2TE0SL0xI9tpdptmvoJJTGwPBYB2FsJEwTxkRyaY/K8US/BRFNI/SkA9NMpLFjrIbsWVorpax/ifMLfmOPAole5uJHjB6wYQxo6Cm2lrDBIpB3woJGS2TfTvVizHjsPWseEfLdwGGSF7z7mdmzDyDPLvgpB+2NFzirKFxeuZWKte6BrcjIrFRhc+ss5d9JOl1De0kypfNOlBcJpemCv22MmpDhR8bH3Hr5eamxltjTps/lPE2U6jVwpduonq7Er/r0rGRq/3qox87zYRHcYQtuEGjD5GRXJ6amCThQPUSlT/wNC1gUzPIQ0pCO9Ar/aEnDuwkaXY+o5fdhPP+uqJcuSYBPlWQJKDpauq545wC6WRrUjHGSUk9b+5TgWLsgvmJCrOpySxTSYUTeKLUDFlovUrucD0JLuILUR7F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FbcQ4zH/TJBGadntTbrFd4MMAQQf3Olg5zlSgLRq6Dg/cizNILMM6zPOb0yi?=
 =?us-ascii?Q?oYJAUErOtTODy7JF7m+gepv/QMf6wN8WxoR4V8j7OxXntvU+Sngje5XIQJeg?=
 =?us-ascii?Q?6Z6u32muLqbqeLsYuJuHu6mF2w9top7wS/nv5uLLfC61r1gCRSBDJWWl4o88?=
 =?us-ascii?Q?DTyQH8cYqOh/rVTrWkHAEHAH4/9S6qV4yak5NW0ZBxBktMYgZFcntdiiCg92?=
 =?us-ascii?Q?yxvLJ+85XPSbbqDbrLfFMeNGLhYd+93eaajeLySIkR/PSGRwGykhTQNlipM+?=
 =?us-ascii?Q?Ymnfoy/xrVVx0vgll34rg4WeEmvkeBg7PGrJ7R58HBRJhwNu3bc2LTLM/IPU?=
 =?us-ascii?Q?L/NTP5j+RfmBu8WYbGWjPyAh2Nnfzafu8tlVpBCNDtRuO/45NzeXLsAl9vo4?=
 =?us-ascii?Q?r+6AfFPnhf2LaqDq6O/5ultgUsaffXmTMV9neuf8m5h8dhjxa4c9mz8mwUhm?=
 =?us-ascii?Q?lAZKMt8nN0zPkKvG5sVnwJV+8JEteQufJLA9VuNYh36yH2QJLcryHyaSSFy2?=
 =?us-ascii?Q?uATjYteTy/zyXCl1UmUNL2m7X+0eNUN/26EClOW2pzSS5coCNfIryn76TQZR?=
 =?us-ascii?Q?kuUNM1YOtpfoOsimcZ1tUiqjeTeBYfl189ExCbQ4co//tNv6XBG3DQr7HfoN?=
 =?us-ascii?Q?Q6d1eZHxZxd+IZzNbxkMO6ADtpqJmO1G5OWDumDSkiuk8PRIJVdD3E4cA0NP?=
 =?us-ascii?Q?TUH2/TTWMGNEPsWGHxunU8tM/XFCalfrUEmmjiyFAcDKNzH4yWLjrn9PaMIC?=
 =?us-ascii?Q?i4S+2vluJYwT1TYC3LW7s3AXPeodUfZ3kJcDCZoLRwgORypuJaREOHZPt87Q?=
 =?us-ascii?Q?1shzSX7T+84tq119G+Sg/EEAkI9arHQi9Nz0CPs3BTqUoMUFk/3vpMf+3gn2?=
 =?us-ascii?Q?nZ2JPUv4rlFLzid9YeJHPhW1K18Sh71q0stYbK3tA6KI7R/SJXuBWvQS0HV5?=
 =?us-ascii?Q?um4HYU76BRThEmA/fY4owmK5Ko8kHdgUnqdZxjkd5SABGORIF/q6NwX2ux6e?=
 =?us-ascii?Q?Kapb81ClF2z9rZ+BMwK1+4sx/Ha42fFxpbkbAaTH1NXQNEOPaL4bAFtEJ5b2?=
 =?us-ascii?Q?kDsQoaCxYf5UbdWWFlOLsjHzToJ1H/d9p7kKgDC7kpNghkAmxDnlOm5TrDke?=
 =?us-ascii?Q?ySA4n1P8mZOIbgxQJl3hMHJQ1imCWNssQEVw8TYWdjk8bXXMi1F47yDH2Shw?=
 =?us-ascii?Q?EPoKYHKOthYVppqOS1wY7Mp45fSM6b+ckzOKxTRuegOkqGePgJRw7u7UqqzC?=
 =?us-ascii?Q?vLecAOESxPU9H6RyO77NUrlXbHjiSFZONwYkmVdaJGfgLIvwl1o9ifB5REbH?=
 =?us-ascii?Q?LgdfHze11kuluXcoS02CHuJxowB/5UdTpoynVUs+WzZ7Q0i0SOkz47A5Nb4W?=
 =?us-ascii?Q?7UcHNSzItcGWfyj3LZsYqmtUzRR6Sa7h/jgIxc8/DeCw3JXPODsNU1u99RHq?=
 =?us-ascii?Q?3Zd0C4KzeWggPofNtUxy3RcFNusa274vaP32HdUVyqQ1h8ngM/qdpF2gNwk5?=
 =?us-ascii?Q?vTWh8LC6K4SdN92dKuuxPMcTMZjAy2uQfcXH1iDdr9hd1JPgB/YFOX3uJwoB?=
 =?us-ascii?Q?1g36h77WivHUly7AFMTrQ+cFvmv0hk6sPrwbGzjwnF2DYfha0I0LoS0RfgEv?=
 =?us-ascii?Q?9n9bPtRGabVWeH2w1bV+rn1gh1xt+Fxw70CvfkBMp1xQfAzb1/JL48Z9n3yf?=
 =?us-ascii?Q?3xigtViI6bE73bgHx47m0wFJqo5ZsHaMEFbqlK04WgE9Ih5LgwcGJweYjemm?=
 =?us-ascii?Q?rZg9gJokIjMatjmuuXLB1H+qMUH8KW98tc+J5SzJZ40YtM3De1UnRBwlWmyE?=
X-MS-Exchange-AntiSpam-MessageData-1: 41kZ/59Pj/sh1t+5J9sLQhSSGYg1HK+xegs=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd3bdfe-8a1f-49f9-0eec-08deaa8ecda8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:12:25.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf5waZHCVbe+7BFQ/qZZJ1YqTZ6Gg5GBi2+Bmg/nNbh7TA6VzZL7K4C91EKM6n23FYHL2WfPSNOR9MUlGan7VKlyv4+Cr52xxZ9P7pQ4z5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3710
X-Rspamd-Queue-Id: 0710F4CB884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284329-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.moessbauer@siemens.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The PM runtime_idle API expects to get an indication if the device can
be powered down. Instead of returning the appropriate state, we
currently directly power down the device (if not active) and return
that the device is busy.

We change this by making the function side-effect free and just return
the state.

Fixes: 749ab2cd12704 ("igb: add basic runtime PM support")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00ec0e..e8ab0b506a104 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9652,7 +9652,7 @@ static int igb_runtime_idle(struct device *dev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
 	if (!igb_has_link(adapter))
-		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);
+		return 0;
 
 	return -EBUSY;
 }
-- 
2.53.0


