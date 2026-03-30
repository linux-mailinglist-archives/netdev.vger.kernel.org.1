Return-Path: <netdev+bounces-273252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IImMKdeaymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:46:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 286ED35E1E9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAAD1306A8A9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79836C0CA;
	Mon, 30 Mar 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iAET1fwa"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37304368951;
	Mon, 30 Mar 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884650; cv=fail; b=fpZFKgliwfeBoG7VfTs49ct0Da/LAbTZ93oegILf50v2GfDG2PkuDebzDs8jwnmj5+S/GnAD/eoRklb8FnF8hYdrVUcloBUJnAFKJusFYzDCDDRKwBOwvlFb7c3qyj9j22z5MGs6tqqkGwsA3i7zhuykwc3OroibKQ1LOeHL2NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884650; c=relaxed/simple;
	bh=HPHpoNtH8CU4KZCM/h+rFPfUKY+PZlQptRZUuFqlgk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtbJai2H/C0SxsOG4w7xj0fPtvtj1cGEpOoWqUeahKa+W5KQbjfnLbkoEj2xpqYARQSjLSBV0awgU9jmmgHtL5Vj2daavldYKiDEu3IVrAQuYiaH45aJR1p69kRzqPrc+SeLRZ4oRKHac+sDvkBEo14VLHEqPd4IwzwPWktMIhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iAET1fwa; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myitqpISlKVl2ONl18YV3hwbEm2AfSeI8r1Z2GbX46AaWhbdRSAUv8Yp/j9YUeW4P8wQC0vBWpz1+oHxBL0gLD2/RGTFTP4rkBEnTQpU7hquI2TzQv63xwWHUb/wRkqXl7klprvAIqIF4D9Wy1KxdM6QQd8qxYfume0MfY4y0oY2jrfAv45qU1DAmX1OvSmnk0SxI+uNAXaRf/LSR7r8yFuCm/IkTAItvDfdNHfEF481HqtWKFMO61YHWAGrUxyqC/5T18sFV8y7Yvy6nx0ZZyiIhLqCHdXJOJ1W+e5p4xe7oRmXZsa5PRzROUbJJ0CzSoOwGwxybVLRAvOtBa1LDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewkqxQpS3MqkMYlsb6iuDYUivVANRhTnHceBlA8OtoA=;
 b=ATA6jjDFNEIqs/wjxYCS4mydLcoUuF8NmS49Md6QXJg6OV4f7xpuu+vnaxz47GkAOE8UAwZe0SEoCkC+q8km9CIPxgDOUNKSam9bgA58WwWf5IOzL4/2TKsDJJrumCWJ69PEdkFAfPjuoJtfw5W4sTFpMtsXI56cjjX0rnryAY0GA0CY35O2d1lVjDOMaC/mhOo1804htnCZEZoA0GqkEc7YOr2XzHaft0T9kl/4v7iVJEFOJIW4Nym+tfPGfaGtbRvk58bEr5SKM6nuaW05pKk2ml8eqnCt2+oi0PGeR8YhzbJW6QtML96suuGUJU3l6qY28/n6WRUvgnAybHm8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewkqxQpS3MqkMYlsb6iuDYUivVANRhTnHceBlA8OtoA=;
 b=iAET1fwaaUecMpQ5wKGRYJxcUGyg6lm9xryoeys/njx1gB1jTrOLwISKiCbLXA7YORv3r1I+wO+RxZFMI1CRgiZYrK1UN2BbAmF0Qj1QNuK9GnbCsgi2A0gPzor+MtfG508DZ+8Va+8WfB6KMa6WTbQsqh5jvbsaNbRHUoncRyVRw+U3b+IaPTywhUWvmrzrhW1FXCHcgKGWbEwN0G17DHmMPb2/IgPKT1Y98DijT1pSvJISAL6aFdfl5YvOq+eAPOLj7RWfipOwG3bqPL3Phqf3qPOJcd2rE+LEYsf9PM4OkCTIhHbCiV04KHZGTYipkFE27bJ/PbmIoU+yCBVtuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:46 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:46 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v5 5/9] selftests: drivers: hw: test rmon counters only on first interface
Date: Mon, 30 Mar 2026 18:29:29 +0300
Message-Id: <20260330152933.2195885-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::28) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DU0PR04MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb94518-fef4-4019-03eb-08de8e715006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M4FnWD9NMmML3SPI7C0eptkXvfdDHFBzXCtEgpix33v4+uYlI1Ksped/oen3gzdKXreUkXyCO1IqtxWRZ4pFJaSBVFkbn9gdzrzsJNHqxjcedR4FrA4FRfX5Mt3jgTaopysIfcbAICdL/kHuEkPFYglqtkQ2q4M4NrJzWpTSeJ0tqJzZS46dbtx/CO3NmqzwA1CBTWWQt4nourOb0sx9TPeshIiq8Mhxpd5zWgzNuQ2ZWl/2os1sh1bXv1ZVrmm4mDVKJ1cF4khmTA2KE9SnyNcz7ZcGuZZcLcVVIlzCEuRGPS7WWAgcjAg4egszJQxZDjmC1WxLEyPKps17vLznF0Xg/x11lM3Kdz961l/94P2iZrqgHB1hw8wm/ivoIVEoylX8ofcypebHd8y+DJ0sXixxOOHiMqGZls0U1ToNG5ocp7jYUJ4gPoogj03Usm85673M5Biml73sXUecYACZbBWzqTb+VBL+Wm/icmV5wbjjPcPa9M/2LUp6fwRCAJJwbzGIISrM9hrC8QXc9Uj4J0VdPXbg0eAog0i9AzEx+3KJmZcAMe/mz8RH4nes5VEcMRjcSezPjDeFL9oPxscg9JVjA1aF/75nF162kexn1z6fYQZ9G03wKv5tlhRw+USZNVF14RoISyGNjikSEdY2DhawckCMw/o3WXG0II1jTF/FYuPbbV9EjuY1Q3hYs+MJKc8VhFiLx+rsPV1hc+AZe5JbRjFUO/w1fO/EnLLBgco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nNJCBsltTsrlY3bxacbDd02WkgDf4uDFKYv9Q71zet5RqDBX52BsP5AwlFf1?=
 =?us-ascii?Q?CuAaQ++b4tmt3Au+gI8hCbfUmviLPplOGMgmXtjJYi2zdCIUADGWEqodmxbv?=
 =?us-ascii?Q?zhwMe0gdT01JqFXXBQyuaeChybFa491OTEic6RkXvGbElP/PLpgYiG2kkThI?=
 =?us-ascii?Q?WuyFAmFoeXZYKJVYcHzxtt54KcC2H1reE7YlusORu52m02ZvUOy6SfxKhIyp?=
 =?us-ascii?Q?/ZYAh0imoqt68810ZdXY5kVG+sRILbabS2Hr2VzX7TS0Un9ZyMWQsV7SIgJX?=
 =?us-ascii?Q?hcIJS+6/aR/Lse2vwm4uw2kkpqyExsmaYUmTni4dq0dRD4MZzmPn4K+oIaOr?=
 =?us-ascii?Q?xjSxldLGomE8Zy6oC3tXlvj4rK9hfzNC/KXc2RM55O8/CG6UTLWdw8A/eqts?=
 =?us-ascii?Q?30fq/i+fs4HaQCUlSCpZkTnag8Mi+lcf0XBbG2cj2OIIC8TUTefdrN0XKNIA?=
 =?us-ascii?Q?Nx+sijnejMNRn5BremJEJVynvYWM+T+thzbxcEPkIDsejhOWUEvMklBRzEbB?=
 =?us-ascii?Q?Aqh76ngPYLCaZ2J+LODnpIQZ/3bzxuWIC1DwH4V2UGeno7osrm1wLKSEKJsO?=
 =?us-ascii?Q?/0U1ko82g5tSfwJ+lzXCr6ApbmJ1+tRbqq0uLzZMWTXlfmBrEWlEqlX9cZmZ?=
 =?us-ascii?Q?VN/oNlOhiW2NP7wwqHPM9dj1hbp7sHSqaMTG+/ehUWItGQBdO/grv7lzprbd?=
 =?us-ascii?Q?oKhrbv2NkP+nNL02RfiXcnqyNVIBw1alwVwwH11rvEdyvBLSPnYv1YVe0KL8?=
 =?us-ascii?Q?2nGDUvNaqALx7IsgeQU71Xz6IBRCBJB1G8Clt+4B6W5rjkL1/jhdLJHfn54p?=
 =?us-ascii?Q?2JGnyhjWyzEL6k+EJT0n6eU/c2RF+MIxg5GYmZQLmeWn3ukpXYw6KW5Gijid?=
 =?us-ascii?Q?o1QzSSZyCUi2NG0NokZH6F4p0Nx4maeV4tDtba28NkdDhPbEMyKyO++pvYO0?=
 =?us-ascii?Q?AV2c7ad5GZVWVuf3y+Th7/Tc8IxhkcM5/ccUaNoHjylSibmOVL4HBdCbrsUL?=
 =?us-ascii?Q?D8pfWqCQnYyV3oscKX5plsxPjaoirSGU0wUNsy/2I3KOYRqIFhaeLqO6H538?=
 =?us-ascii?Q?zb0XYMtmbpZpXbhc+yZGjJx7JsaH5q+H+PYSozyDSYB/9OXtcYTxHaUIKWlJ?=
 =?us-ascii?Q?ALyCsKS94FrEurslklT2kPDfYUx28Wi+gfFJrxcOB8YtK1A12KZsWbgltrL6?=
 =?us-ascii?Q?0HJ+2WuRNzWTEteIXL7mNeKfCglOSdAMXanHiKlaZsLTi/dRtcT2N4/X1EnG?=
 =?us-ascii?Q?yzDljAXBJp3xfAaJnKs3Je75tBQ6bHGXBKkijwcW/+Q43x4f+HEcdD/UGeue?=
 =?us-ascii?Q?iiYyp7UFTIFZdGRSDes8eW9mVVxt1EfT2HPSqGVxcu+a6X9taIHEe96tV9oF?=
 =?us-ascii?Q?6Sy0cZcBcJxWb+4jTC6+/SMrZgPRXpXC8piVLl23Z6iootil6pZmKFP/s4nA?=
 =?us-ascii?Q?fzaXXDbch1koAeb3OBFmwnXDKSFBja6Ty5/rDNhcE5dVb8S6IYzpfL6yVvt9?=
 =?us-ascii?Q?KlfMcF1UmYeVNUmU3nb7hyUFtk8ysPKjHyAev2ZeM9u6byGPOye0O+SyhJdA?=
 =?us-ascii?Q?TOMDIWMAo0Oisf7DrD1MrIHJvJsvAMVXUANOjzKxNOBatGoq1yaIaUPzq6I7?=
 =?us-ascii?Q?jboqBY558Nseg2r6aB3Md3Rd0Y9571YYYokQgsA9Z1o7sNb2f7GoG+IMbJHo?=
 =?us-ascii?Q?AeT1/oB6QOTRVCJn6sWat+SiTvoV1T5TVTEk/VNg3Ipkc/zUU51EJ3HIKR0x?=
 =?us-ascii?Q?qIgHzeIusA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb94518-fef4-4019-03eb-08de8e715006
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:45.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+xud0C8x9jc0HhSXKVJD09NSIV0uR0rJGHErhUmDUMinKkKDuEcJkiWZN176unWfTXGwFF1lQVwdwb/1GFtQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9372
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273252-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,ethtool_rmon.sh:url,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 286ED35E1E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The selftests in drivers/net are slowly transitioning to being able to
be used on systems with a single network interface. The first step for the
ethtool_rmon.sh test is to only validate that the rmon counters are
properly exported on the first interface supplied as an argument.

Remove the rmon_histogram calls which intend to test also the rmon
counters on the 2nd interface. This also removes the need for the remote
system, which should be used only to inject traffic, to also support
rmon counters.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v5:
- none
Changes in v4:
- none
Changes in v3:
- none
Changes in v2:
- patch is new

 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 13b3760e3a40..80e75b9b40fd 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -106,13 +106,11 @@ rmon_histogram()
 rmon_rx_histogram()
 {
 	rmon_histogram "$h1" "$h2" rx
-	rmon_histogram "$h2" "$h1" rx
 }
 
 rmon_tx_histogram()
 {
 	rmon_histogram "$h1" "$h2" tx
-	rmon_histogram "$h2" "$h1" tx
 }
 
 setup_prepare()
-- 
2.25.1


