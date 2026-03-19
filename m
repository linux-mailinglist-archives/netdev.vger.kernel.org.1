Return-Path: <netdev+bounces-269528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPvcDTkhvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:15:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6382CE902
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8483A30EA6A6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CD3ED5CE;
	Thu, 19 Mar 2026 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Llh8jAeo"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F73ED135;
	Thu, 19 Mar 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936276; cv=fail; b=DiYLXBtvBD369hUAD17e5jwEpjJ9COFZMxL8pSUR5Py/02kuyI00DBpXgKymjqXNtYwkC3drODRsFIXE8e6VNJw1NW/0o6ITYd3JtMaVVLpOw8kzcBpM+5DPbb/uN6wO96/EW96GsG4UYVR02DNc1sBpVHuEEtAVHG72x8q2XkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936276; c=relaxed/simple;
	bh=YoQE+c1IaDsmFGqDWrqicZ1j3azkob3erjbw0glkjNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+GtauA8B6HZwuYz99RBB4L2s1tU7JX4Z1BBeIdm/omWQOEg+fjFKJqjherE6Je4IEWMfAgVnuxNcPrwuuQQP34aEtCSvfnB/dLRJ8ZZ5wGsJbgILDXlNc76hhQO4B97UATU+fRR0C2T1gzmpE+S/73Msxh7KseX4G6/OQYdHwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Llh8jAeo; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXiwAteBKOGqACfkuDAS3zVBHXnrqRlbQR/aIaWLRtsnk9S1tKsPqs+5D49Fhgp9wOG0aaJROYOKamleelrUyBYM5LRewv+ePNyirVe5CwTYDb1I9P/sDv1VMq/3sHMgGqlnzpqMFzVGmy/6RkhQtMP58Lr5Eisr+Ch0DVYcidvY3Gmh7M7V8tpP2PdqVHrltam8OKJpaV8nLXdHnOqO+JoPKgfauE96e5CcqwBLXldfREWJC+7f9dEwpxEYiUkkJX08Hhwpp5SEX0gD3BD3BUSAwdj4lfWXLKjAUMfO4jI5ihWOfSsuruhN69wp1hb4vaRXpAhgTxA3LnrpLUnLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qWeKT6vpSaifUvM9wngNWlnJE+UID5RVNH0oo57qo8=;
 b=iindvfqVp9Nw9Oz+uYcNeRjoVNgcrHRxrycg1u7nz+rnoPr0Xk0o/4vI+3FtZKgZ7wLAIA/ZO5Fk/eWJwVAj1fg86ylxTxx8kefNBzdu1FcFXqP4Pu7yPlZnchtxKRlBabaZJhObEj1q9iFF/GOxJKKhDS6uWT6esb5obnRrh0HjSjYbabV5shgqQwom7ogmToQwUr2ui6F1KAuNy2x/IA+kWT6XcShsT4VoSFjUfIvzfRxlx6Wn92cRtupzumBlZDEqcA0Er7MaQTuxFXvUrHNcxL2lZOOrTY51SdSf7/ZvluYcL8eweYZxXbzIJzlrwiDW68CJkyLP6lTtlEGQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qWeKT6vpSaifUvM9wngNWlnJE+UID5RVNH0oo57qo8=;
 b=Llh8jAeofBxNLGL49DVUUTtMnmcNuqd8DgZPNlvPQW7B9jhhzLKay8hJMxD+xnwx7PXHI5o/5KydYLZPO07HzuHjLTW5DFiHgq80waZIh887moHp/Ql0/33aafHv8IQHOhnVc/puJDFeCAJuVj+GLGNpFwzRe0/1WdXyyTA2PoPk/brAmEFdyeotUcbyTmiqxj2KwMv5l+K/kS5U4Cbo4iRZutVt+C9WU/qWaK7O3NSWn9AaGUP25ABrd7D0PcrCQtXsc8BpwoFKO3L3Oi/eKYDFa/G4KBW3UZKh43sJGNDRUUWJ5u/grT7UPAvQBJRFiuobVIlMZS68/15WAHdyOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:23 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:34 +0000
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
	willemb@google.com
Subject: [PATCH net-next v3 7/9] selftests: drivers: hw: replace counter upper limit with UINT32_MAX in rmon test
Date: Thu, 19 Mar 2026 18:04:08 +0200
Message-Id: <20260319160410.2515105-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: 7966768b-7ca1-4387-a1b2-08de85d13647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u/ixbt6sGt4w1vF432bLE81J2sTd7nNlIY86gfLnN2NVqlA9sHkxlEGVF8fpyCfziqOnbNCi4ThX7hqDNaQuw0fB0jv2FHJb440G7I2T/v7XdrO9uNoIDlk8kLMNJtM+tbDe6T/1eF7ejN/F8KcFNFctAxFUMI2kZnFVKkoM8D3uI0QPMUmelO/QDY2q+p8QRKfXTPxioAuscuRGmDO6uYAxjs3SxI7xwvRKKYPzWGh8h1MJomPgMvXSYsWqOdyTpuvqxZWDC2r5nd4ziGR9FyJ7odG8W3s1m2mBLMtGOSZLng/kl05lr382lMawbpZd1nFXSnty6wcKmairARkEt4084cxko0HlJf5+UPg1FO3EU6DBbstynxAKrYzVUqUiyxk0V4qd1yWu4BLKlOtQxxArCe2uq/AWUoNy48JzjtF7dfStmuGoexJVRrDXhm49TLIH652dhHnUQZm2NyH15RjpdQ+JXNlj13GhPh32sMOXMYoJ5Z3aWC+Yu8jK+F3r+YDQaV3izZvafuJHg6KW6LTvQBzfMYyPVGVsegoXCYqrZEkRxcc/Y8L8jzOkPWnc6fiN4F7VAhl3l2nAgE01Fuey8sSt+eb3zyTD4TS28ThIAGXz2EhSx6Hgwg4uVC1TmtWjQZWS7rQ8Fv8xZJmz4Unm9JfR0DvgyXIRwGA9aIZAQWuO8SDP3Sw12ddzWJitfC+jZynaPljCClRnmQouCt73oP1VSXuVpcRP/VItABA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0al+LB/bAH45I9A0PY6LU4DLCPDx04DwDaakC9c3A3XpNV/k6Ay6gDHErPb6?=
 =?us-ascii?Q?fOrdbeZ7WYXVbi1X+d8eagB/3hJ/OvtbTGq/SlgZGsTA540owBysHzsOY2KW?=
 =?us-ascii?Q?T9mRX0ZYR/jQtoX4GoPhnnmpKN0wfhRw1UHplFayiWQUIjK3Mt3PXzdzAeCs?=
 =?us-ascii?Q?aGZS46bnxBa3cx1fEgNXEbL0qMpQkfP1RHa+gtfM6yyDpQ+atwnHZROjoa61?=
 =?us-ascii?Q?GpFJtH8/px7ymzSvvPDh/z7XeGdqDfT6hO3cSKZN5Sjot2qrxKXM1jvd2+MO?=
 =?us-ascii?Q?HuMozANfKdOHeWSXdIGpFfM3lnJlhLqTSKoUa6pCN0LPh8uwwbNbxZai0g7E?=
 =?us-ascii?Q?s7qrn8NkACERYDMB0LVjW+n/6M0nApKyDunztBsJHdWSFcthammE98N4d2Yj?=
 =?us-ascii?Q?Ok7cH3x+Jr6PUs0N9F8ctkrA7IIyhhdmQeDA0mkYpzr1cJeW31oZIWOzyoMe?=
 =?us-ascii?Q?7bP2gyMrE7zCmksw7vLnjeB5bEWvLtQ7gjOt9esvQ0/aw6mNPwf2mw8RimF5?=
 =?us-ascii?Q?C6apm8Xwpby8E93vA7zwbUmQ9ShD02B4pTUi1AsU/g3L8/1MVhMWR7m1rWb+?=
 =?us-ascii?Q?/ArDwam6ifk3lLePR78Qn69xjDvBMcn5UuyI3UXxG17DmToY/poFPI9L2eVe?=
 =?us-ascii?Q?hzv6NPV3kxfoNrx7zTXuFnjOu3AO0CrHoJwwg0Uo/a2kIgwe4sDD/3NoHS3u?=
 =?us-ascii?Q?VONzcHhOlewiFbYGO0BFpOqzI4F9/LJwbgcDDYADCCAVDz6MRqdt4ZhPyjej?=
 =?us-ascii?Q?hKc+xmkwUlGsrBQVU+PdEzpYLwZAunHijioL7LVtX3TwJxVD6ODfXliK+ITw?=
 =?us-ascii?Q?aKeaQfpVK0sYV1fjjqn9ltbLhjh81693yVb4wwgVgx+OoL42zLxIV7iC8dos?=
 =?us-ascii?Q?yKayorM8IzGZ5NR3e4gn5+A9gWBU1hn2yyh+JRvWXBACRNxqnmgl/0mzMInk?=
 =?us-ascii?Q?U/mis1Tvzz7PM795h8Co7sKfqVJ5UlC/oKNn5yRDLa2oVJ4mY0jPY8gMlWou?=
 =?us-ascii?Q?ob9EVm39tEXCRg9A84l3ZIiOoLPXJAaJgcCGLNtVaEycZxO8IsG5Nb/H3AD/?=
 =?us-ascii?Q?buCXpSQ2N+b44KZr7Bq4Ho1PfRkS/qHYRGtgRosq2pK+qfk8H+QDCuMQdHYz?=
 =?us-ascii?Q?dMlpjaRzs4ZjYI0an/h5HXBCPx+KkkRx7Ph3r48VZqMxfGgsvKn3OWk17E+Q?=
 =?us-ascii?Q?OHeFyPt+tl1fNxHLRfClZ/6FdlOc65TQjhL54TKND+WQLG0xHT1FfSI6+LER?=
 =?us-ascii?Q?zsbppY68OJMVZVyWcbjQ7lpF88FWGs4k67AkVDDid+UlYzzccd0zIxjUOljO?=
 =?us-ascii?Q?VuruZAvru5aAUfgG1EmSicbSmMNMMjhCDH1r+v0Qtf/9F7PExLXs8ed61Ymr?=
 =?us-ascii?Q?hK4sS01PO3Ek8pxNYdou6nacI2Ryjrv8WqqPt6pYr1NnG7hm23O+kdm3aLBu?=
 =?us-ascii?Q?6bq9gKH33RlOOeqZoPXwXdFHuXsjlLnWEHm2WGnXwumBn0OA1NTbCeKDByJl?=
 =?us-ascii?Q?mE/HqJRArDEr3hR6nq4yEpVjj8lKPNVl+CjNRjEwwdhrFASUZYsPD4Z/jTyS?=
 =?us-ascii?Q?6tS9qANBWqT+UsZsJcmFLBSoLjXBWJqAbI4QHy8QrT1+z1S9nM3kOpnrD+Qh?=
 =?us-ascii?Q?m48dQdJqfNZFUIAmgDbc/cnlWpuz2o8q0ewEViJuNQwANrq+l3/1lmcYd/OK?=
 =?us-ascii?Q?O6MKjtqzda5y2mhzRy6O3FSnwOnlQ2nOtRDQYng3WpRZcqkxD1dXUbXnvLWP?=
 =?us-ascii?Q?cJ6dTyY0vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7966768b-7ca1-4387-a1b2-08de85d13647
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:33.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPmmaRbfhMnz4XtIIh3oO7rGztxtuzDzp+k94Gmrtm81VOdOocUGmBihyU9NGs8zwLdH1yA903xq7j9F8xpj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11451
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
	TAGGED_FROM(0.00)[bounces-269528-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,ethtool_rmon.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE6382CE902
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
---
Changes in v3:
- none
Changes in v2:
- patch is new

 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 636429018b6b..1baaaab3c3a4 100755
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


