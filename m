Return-Path: <netdev+bounces-272070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFWeFQM5xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:47:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB03363BD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78D4731E51CF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE373B9DA2;
	Thu, 26 Mar 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lRMtMaNT"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D531F9A6;
	Thu, 26 Mar 2026 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531748; cv=fail; b=MKAEFdluxcrV8jIwL3sLvDFo89EtA4vzTKSH2iyl8vbOm04gvXghTTCnqCeThXWrCABvca+wuYiFfT+/uq5Wocvm/eKvYryR6lglgmr1eXwGw+qVXH5mxpBYF9CFMVZoZjI1LhIL5jrIg4wI5crwoDUksvJ5QQOplLh5mxGHCvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531748; c=relaxed/simple;
	bh=5GpL+gibiANSECCrzFOrVwcEmRHGmcOammCodPWQt5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDZ98Cj+qJzK3REkeHdvmeOzLHGXWbBkxMgs719J5O9LQ22hW9Do4oKIWe72Gglgtmu106800a7HJ4e2hk9EmGwZk2exi/LMtMbq1NmGPksEHXi5pFpm6bUrt6bkc7w2ZVGUc6wqGce5W+ScNb/GoWLCClTZmzmEe84Quf/eFNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lRMtMaNT; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpa1fkUayle4QataJ3pLxLpGDLYS1vQ/jq6OHhgV0nHKqJDXrvrZJ9SEMSfWe7sIM0kkj4QyUuKahgn6w6zjxfNE2vBSYrCgDq6mPy6d3ByBMv090HXNWon9U066pA0aWOAUfaz7/NADdYSxTVMdE0l74iiMrITRw29umE/94LI5DbsOO8okIAN+UiFtr/HobHoUwLWtz4GcUemCeJE+jTz7ecRdHOyYxK9gcFgJ7HfpreztO+D55M3lGKL6GbTyXnKRvVhk6RimuimoG5PjiTSqnKVFXbJEAv9CN4Q4Ot8Li4ytFDz0uNZ/9K3towUnurNFRlwuhkZnt4+21oijfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ao7gV1Ur9IhbHbwM57Jenkc0Nu0eObmZnj3lToZ96s=;
 b=LwCeUuuZdD9N3MeG4N/YW1lY+PXhXC2eXZVoOJdJmIZ4CFqUuIKoPuw4aNrZsBaLvd6/083Fb4VqrBCkHzK7GER1N/vzHbfR0NDEjTL80yw9CqMOnvwD0swPcJLMw3OlgteSXKasDqI2dwQZmcHyKkqqGBUPddqtfsXoPFxJbAB+bpcl6S8gIMP00DiPDxk1NHK15v482PytFe+Qd3ds1sk+p33Nqn/1cEsxhMZrY1bXIyFehRbfo0ZpFYxTMQFxBlsPfMPA/X2Cg99yEDLQDqPFvu6o5Xy+pZXma02tMbcrcFlvKkgxf3629oJVqCpBvrWP6UAs7EX48jkhroa3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ao7gV1Ur9IhbHbwM57Jenkc0Nu0eObmZnj3lToZ96s=;
 b=lRMtMaNT8W9tS9GhdY4DY4yWfi9zqu8WBNqaR4ujXuBegPAYlfR1m2c11K9FZAui/OSsWIICjH39io59fQCOnu8Ngt9yYnYZoOCeZ4aXDI6rsmmuuTzDUPKd1h5q0C3B4+J8gD4vUwBrC+ual7GOZE3VLuKpZZCv1kU8rMngCtPvB+5yxn+CdI9zQgJ1131PwG3+Tw6TNB5bDM6W9NMjzaiPC4pWnCfHZaBUuKNjPRHG5zTBNWhO6WJyvmURDLEDCwveHwmt0ifVDK3ufn4cfJheR5HxCStDnfaNEyeCBddDLl+GfS53zSe9YTZeBD48GLkqPaHdm+UCPns5Wzelmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:28:59 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:28:58 +0000
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
Subject: [PATCH net-next v4 07/10] selftests: drivers: hw: replace counter upper limit with UINT32_MAX in rmon test
Date: Thu, 26 Mar 2026 15:28:25 +0200
Message-Id: <20260326132828.805703-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::11) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: de0cb714-4111-4c5c-7755-08de8b3ba2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	J5IkDOHSYZGOU32Gq6U7wTHOTeVtFcCfhSN55XGaL3nHWPPq3WJq0XWfN3m7/DOTSxRUVw+i9zHReu4+g/4bf+Pk2ewI6WKNhPCcKfUnG471ZSz7U3+JDUkkWF0JUOQojVNaMAYQXGblq4mZ0fqG+KTcw51ctLtYjO5BI1KX0s2HM9C/QDMk3088QphOi8eYm6czNYnNE6c/y/QwiWFq/T6+Fyc5CBbC/CUf7iqw1wi3MHjCOn9zXh+uO9Kl/hSJU8mpJnKwxC0ZEvFSj+NVdlv0ViF3d4r9I/1gEJuqijBpIED8CXWBQtoIbZ7F5+zrKRESzjcw18exF24aU/v5pSzEvo7HYvJ4MjXQehDLVuA8IHWp2vESxgCfGxsbhqVfgYSclM6M8dlQjCExrpH0obZ0xnlyE5Znj9jag0iNWnLBC6o3WRzswbrfUEDZkprsSMvnGy/g2Oc3QkQNkaD5qP4efhhD0rRHWfGTMS9+gUm3BDvHH3ITPLF7x30iDdvRg42Y6bNjwfuboxptYP4nQ3ANeMtBR3sc8IwwCrvLb2bNW28jay8Omm2lBUB4v1w6xzL/gBqEeisxoMUfIfK/fq4uI7HOajLsmzDWuO1PGFIbwL/hC/+yAdd6RhtZLYBQJGV+Y3wIiYClP8ivnmrwwOrJrFSgL+sTEdQ1TF3X6rB2IuUoL1CBo79aZ6gs/4DdqDeD9vdEwokq4hWGcZLJAvBMYLKL3D+sTAX+V8XK3is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ae6BiXJZ5eR+ZFvguw05l0af1QR1uXKNE8gxU4xwJWxa+bFngslRgHROllCg?=
 =?us-ascii?Q?eb7ClCdU6uzlN9FZ4vbj8kIItt1wOUx5oxZFvPXlySOw8VGE3Z21U3ChFHOp?=
 =?us-ascii?Q?BSUcJKC9c3y0G2NAc/6vdTe3bq3Iss80DhaPhxPTbzYU5+sjSP+XOkH4u3+d?=
 =?us-ascii?Q?gd64Zd/jNUgcTTrm07M/tNhs+OxyK9vAQ0bamUiIhH3loDt8/JBGZrgYXAll?=
 =?us-ascii?Q?5QOWNCQdLu6ckOGM6unvxR+evnZ+/IfVO61v/RvKqYkhMD0tRLuLlQZ6dquR?=
 =?us-ascii?Q?2zp4mQLJBzGBYl/q6r+5+q+lq+ooxiCyQnaUB2S9s0yBZh+JC6g2Ai0CA74f?=
 =?us-ascii?Q?tLyIS7ghEiQFuZ4WPJbXaiDM8kdyKNcAnYCRFoskmvzURBhPF6ip3US1BekL?=
 =?us-ascii?Q?TJ75uweR++CKDXm0feSiK0t1t0Ah3Yd5MWD+Mn3cTKMkO1X+q8FeQxaAJ9XF?=
 =?us-ascii?Q?ouYBJmU449tXaZNJEFkcVZ/pyGV3KEk1L+PZN8u+bAjQpDd7nF3jKU5+R6As?=
 =?us-ascii?Q?w92Av2RMPXr+3OoySjBuuH9frulrQUCcKIrvdmKwDtDjfQPmH3Bm0wkLB0cu?=
 =?us-ascii?Q?vtOqz3yKsoPcohguw9eYyjmSPEuHAxl11SRHGeGmrARkBDaBOt8X6/Hx8mth?=
 =?us-ascii?Q?sm7rcbC0sMLzTfE6cDypI8ZvGzuo7dpU7r5/aQKFzpGZ8aUahWFUKi8J8ak5?=
 =?us-ascii?Q?AUJ6gFFGmsc5y7U7IoEMXIT6vrgOkyZ2pbQ+n2uwaqwUT0LIArfJYXyobtIt?=
 =?us-ascii?Q?HlOBmJbeNeHUN77cXyUr3221IIU+Ep5o8c6P2kPaMlwb1xvd1q9B+tZxjeAk?=
 =?us-ascii?Q?6U1af57V8IdX6X2a1eOaCuWdhKNUBfwzx8qaawCheW3GlB2sHYtq7K3sS2DD?=
 =?us-ascii?Q?2aK3QPgKH1ywU8iqDUIKdgyPGumf7lsO1DazBEAfBbhmNcUf963HJH8WiIsA?=
 =?us-ascii?Q?qfkqWbo00eszZRejQSyRklYq95KNnF1cZRyNukGcN0sfMeX0NYsU1Vr/BoTn?=
 =?us-ascii?Q?gsO/+hZkxIqZmdULg0eXrqt6/vGGWPjxGd78qBA+95hSlDGAxAsRLHhWbUtn?=
 =?us-ascii?Q?cpMyQHTCcPqB0/SWphsu9il2quiztwJQxhtXkV65N4aXmZ4NE7J0eZDD4EWx?=
 =?us-ascii?Q?J6fbZvT/Deri1SkAQhN0FDa/VzsEMqcz9W44fXCl3pkaQnEZoTe69Mkso9rn?=
 =?us-ascii?Q?4FcSrLO9xOBCwJJ+TKfVEiLs7eUs4JkrYiKLaIq4lrlO5qwP4DnKowHEjLRC?=
 =?us-ascii?Q?GSfcn97gckw96xaGcB9UkHEPW27Zxx8ENWJW2DwxIBUrIxJkSz3tVNsI/Av1?=
 =?us-ascii?Q?w9mG36/r/3hg5wfZFoojkM6qVDEJbzT5dEkNioXDfFztTwIbR5ySNUGgLonl?=
 =?us-ascii?Q?thEc5A3Lwqxin7wnFwQ2glb7I8YzGYa5/YPMtR+wignHzgirdUCISs2jT2v9?=
 =?us-ascii?Q?AcYatxOLVOo9HCD96P93mTWiKQQiKwmmjg/gshgL1EIc+ohWASwhshXTkx88?=
 =?us-ascii?Q?cE5WZGBnaMGSa6thtONAZOm8fHOuMklzZhG9pY7DQh441b3kwB/n4IJPEcAl?=
 =?us-ascii?Q?8/lhLnMYL2jXJQy1UaC1l1SEMaolvcVzGkvFeOxEncuO2fchI6djODYgKIdG?=
 =?us-ascii?Q?yNrwQtITCk0685bv2wRjHNrQl5n9p8Ty1IZovIQf2qcVbMb9S2VMcaEx1w/d?=
 =?us-ascii?Q?9iy3/0UU5J0omiyIAKMGfQ4nJrriTmJb5rA8aTBVxsQHTVcrtVAL0reTlHR6?=
 =?us-ascii?Q?Zs6wvebiRw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0cb714-4111-4c5c-7755-08de8b3ba2f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:28:58.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL85/KMuknnah6vjgnYaz5e1fxjgWh6znZQPCGzLYxtlwjhfMGu0V1z9qP7fNd1raaRfpk8NsbY2pxwie2zqpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
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
	TAGGED_FROM(0.00)[bounces-272070-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: 0DAB03363BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ethtool_rmon.sh script checks that the number of packets sent /
received during a test matches the expected value with a 1% tolerance.

Since in the next patches this test will gain the capability to also be
run on systems with a single interface where the traffic generator is
accesible through ssh, use the UINT32_MAX as the upper limit. This is
necessary since the same interface will be used also for control traffic
(the ssh commands) as well as the mausezahn generated one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v4:
- none
Changes in v3:
- none
Changes in v2:
- patch is new

 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 80e75b9b40fd..f290ce1832f1 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -12,6 +12,7 @@ NUM_NETIFS=2
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
 
+UINT32_MAX=$((2**32 - 1))
 ETH_FCS_LEN=4
 ETH_HLEN=$((6+6+2))
 
@@ -64,8 +65,7 @@ bucket_test()
 
 	expected=$([ "$set" = rx ] && echo "$num_rx" || echo "$num_tx")
 
-	# Allow some extra tolerance for other packets sent by the stack
-	[ "$delta" -ge "$expected" ] && [ "$delta" -le $((expected + 100)) ]
+	[ "$delta" -ge "$expected" ] && [ "$delta" -le "$UINT32_MAX" ]
 }
 
 rmon_histogram()
-- 
2.25.1


