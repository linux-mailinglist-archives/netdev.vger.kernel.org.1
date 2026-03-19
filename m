Return-Path: <netdev+bounces-269529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHFLDXsgvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:12:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7872CE836
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2212932536B1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BFB3E556B;
	Thu, 19 Mar 2026 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cAsQC2Sp"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11F3E51FA;
	Thu, 19 Mar 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936283; cv=fail; b=fGCo2Rb45bHIbsrwGs8Gg4xkxmlRd+DapavNfF9386KxRQcp5Uikazee5lVovtcI34+9JP8LgrG2mQbBZD8UuONdSgPjOjkjtKHx4g7GzpWgVYPD28JGg4mBgi4FO9iRQEzPXWe5HTxUBHt8g+rVQAI6sS5L2TtxZrSfreM/mUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936283; c=relaxed/simple;
	bh=Jvv5dexW0pzkzlnH0RYvt+iZDI1xs7s9F9ymUwyi1ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCvqoJGxHSB2X3USgkvbTqJR9nUln8rAL0wfcnV76leCUQ2VAoLyHav0Ko6Dbv6Zqvo7yDc3JChjocnGWuHnAVIbdgs2AOKtAeb6f68xGWxOpaO008LFaOARn9nUqtaKh6zwhj7vvA+uNxSn2Xx90SHOa3NjKxxTYHhvF/5dRYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cAsQC2Sp; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfbWI5AneNFFxct3f5Vf8WKCvY3WvBCL32il9/SHMFCvGCR96f0rL79/l4Isl7HNkjuh5AOVEFH/qL8OFCkeUiomWrKSxU2kfi+rbuDGqYJCTUhim3Hu7IL3GGJCxTMs1rdcoG0f9yLLv24CwjrRL9Iu9GlD+WHUl6Itv5Cp0bZ7Opl1AYS76Wzb87Ta8qQwBK53y/Z+CQeHaskGS+nNF5kDuEOWevBaThqS4VYHSx1FuOZ5r2WqE7PnljTy2C9X7m+hTKvhLjJQj/fx6EgaUL02WqRoaPVNi7xAfb8YWnRcoRGEqRjf5JIewkhlZ3ZlC0nTkaPSW5sivRcMucI69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLZUKmTgMdx4Ixp1pzn3I+AG1YipQrSITXWyeCng4Vg=;
 b=NRNYKI+B7g95y+9wazML0P2GOdnRPl5Rnh/V22Irh3Z8K57zXGXwcHoYyA4M31x9VOEhaPWiWh+ZxgzZ8QZ/L3g69nKHwJ8fgTAm9Csbd76LyAgVPXozUg/AFzZrsO5KXg7TIwrQTcfC5SWD4MZw8GCjjSgG2jD99QlGdmUGejCBH4UttfakdRdFdHiTv+OBMOcaSN9mvqVzUhKv+qjbNyuxJHJ663oBPvHQs7ZsukWZvFvhXs4dMh847D8ulL9z4o5kuXMwj3wIVuo5vj5VrqZWGEicrWIJmiA8eKX1N+5IIDyDH9pwg7/iBwtpCPgsY9W9RRc9HdY25PBQpQ0n2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLZUKmTgMdx4Ixp1pzn3I+AG1YipQrSITXWyeCng4Vg=;
 b=cAsQC2SpgKejoRL75lJQHAZ1JNILRsgSmmpuS5OxksJCg+Ecd5o25a0V/v2/AL641jSuT0fo3SU3cHBk/h2CzmrkSqOal73HKyitTleVfpb53T3Yi6xPhz7Tq6IWTe4I9Eaenud4dl+AmGtjVkzoLIqi3LTlDjv7on95+BviLKxK+toY+2V7UQlFqTtiVho/ReflTdWWGT6UEcVCarv6j7sk2QUCcE24jsupEJcFSxyDAd1qCCpJUJRK4AToWkNuDwAfv6d9kpbuxBjG4ie2tkxetPw8/l9vD/x5Pjmyp69TOrMZDHg0WhaKvDwpFlekCWcHp2O+J6JZmcNKns2mCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:28 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:39 +0000
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
Subject: [PATCH net-next v3 8/9] selftests: drivers: hw: update ethtool_rmon to work with a single local interface
Date: Thu, 19 Mar 2026 18:04:09 +0200
Message-Id: <20260319160410.2515105-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: 15aa0da5-7fd4-4ff7-7c0c-08de85d137b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sBqKwBQnKhAgIIVUlf8rnWUXMHCCVPrkxS+WQRGFM/De9YnwOGaj2ajEjJTsapiia3smlFpudlDVx4gTZMVvFa0K7w894srmNP9g8GdJ4Lv4sPOUCXsNVllPG0SW91rd6Xt2olfMvjyP0AkX2XwOAXnF2FATRlnWO5GrkFFyUGYTRa7wvvuIUCBqQI2/QrkWi/pLiwDF3Wo8seGUFodDpgLqeOBmvwpu/bPa+DR8s2s6c357DTPztHrJ8xyRlG0Ir7zV7YDH01OLvlMVVCSav2XmwUtYh4QLliamuilH4heeVyGTZikkKdmEDeftB7cT4ipbuH76/Axhm9RhOwoW6rKvAvQ4n6RbtTqYjdXVE1EUOsP1rxZoX4WcGoXOdCaobx2+CG7XU4OTll8mVyLwRnv7huY5JTuWBpKZ1nFGA6yKQfdU5P4kiNbGq2TxKaKj59f4fb94Ccd13LsT0E4tWONjncywAC3Hmgsybd9g5+rGR01P4e/d/3hgQHt+bd72rHawSUjo8KeeYOpKSpNUVISn5UEk8VW8ctj45PWJXOhF2XhH/MWHjRmRe110Yv4wW3Wd0qnsY/8oGS3YobNEC99W8rsvUImb3x59cLj1Dd+TxGDFWjahjs5zurA+rh2djmXN+J8Ml2NIQAaAG6Tj5k+PRDEBrs1RFtsChFsdfQahewHfkDudlja+/9ZzM1UxOmJ9OjHZAdJUzzhQzVM8SRpkjoW6BoogLYnKo0JE5r8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X7uFX5SZUvGbOR7MQJRPqCkmyVyb/rcuDBtNC7BE1ekfirV7GOp6OeD55Cly?=
 =?us-ascii?Q?UO6w3Q8z+VRqyDBal9LiOnWmesWwNVLBcU4lS8wvxwZac2vH3ZfaYfltT15w?=
 =?us-ascii?Q?jQDozYanAZ+3NLHclUKVfYDrHtZHNRdUjF0kRtsAVVDewD6Uyd+WbsQerU3O?=
 =?us-ascii?Q?oMyDcR9sp2CKuBWAswdE/989vflBejH9EMFw4w1zNcPjuiwt7qfYsVXICdX6?=
 =?us-ascii?Q?yhmM3GqZxfyemSyITFa3diBckLFVZCFTwViVRJu7BiZv2qHv7phhNY155NT4?=
 =?us-ascii?Q?W+cwh5vM2bqATsz02Trfzr2HDGTpIzJ7F/ckQlf5hFpiWh10jZ0cY93LK8TG?=
 =?us-ascii?Q?uo0OWUdd7f23HU4aYUoKGEB6UOMZVWGXHqeM8kLchZ9n7d7CFThEw/BsVQyB?=
 =?us-ascii?Q?/CKiIYEegazxuXozrgfagH0BasPKwqmgcoIEL6kEn25snKzfZBJD50YBNJSj?=
 =?us-ascii?Q?kFaWUbZzFUuKViNhmaeaV5eMBFqHY8vRxzuiAMcBA/OcsZql2cLAef7oGiCk?=
 =?us-ascii?Q?ps52oz34z/nNv+LA2IymxcPp4YiJWPVSNx7I07qig6WxW0h8ESAVVTkx5KU/?=
 =?us-ascii?Q?MQMvnfLUr9zOex+r8ov8cZp1/eiBH/3XM3apzkXGBg6ZuZmAkYXQ4vHuVcSV?=
 =?us-ascii?Q?iiFmTPQTHnJx6CC986y7DrrOmws53waL6Swxrj/Mi0C7yn49X1bDJkg9R8Oi?=
 =?us-ascii?Q?957losKikyhuycQL1pz1DrDP1QH1+TloJUInLXACsTDYGYQgP8BcZI+hoi8W?=
 =?us-ascii?Q?Zbt7he+DOoEpxKV0I+WLyLfh+OkVCVZ43dSJNoNuUn4GKOrl4sBmk1C8frqg?=
 =?us-ascii?Q?Z0q5EFUg2BR1Y/uNRykgl16qLF5dsxj3sCgHReVlGXTs3wdGaHKVauKznz+H?=
 =?us-ascii?Q?bQ5jl6lMvqURIoiT7iu64B2hlNR7x2g5kmvNNaYfTqEb6tXc/StgPebGAt2e?=
 =?us-ascii?Q?8WB4XDCqaLfcxhJguNmRQYv5IYPh6WBlrZumRzurI20Qe8f8S/X2GV+B5/VO?=
 =?us-ascii?Q?D6zzUBmcSz5GIkS5pw+b2EUVzoC6OfGWLYnsx+uXbSRM96tSQ1sO2w4Gmi2g?=
 =?us-ascii?Q?9zBFApytWdFLsv5JPaHoDMc5C4uG6oJRoS0lWMxB95d/cqL6WwPA+yfBJTs+?=
 =?us-ascii?Q?PAf9SJRch0zQIwYqYJjUD4rDdFSR2a74e81UBZfXZBjvcIWagObT2rQueQ+a?=
 =?us-ascii?Q?ku9fvmR8PdOoKr7FEZClVCQWesXxVUhWuLlC23R5EatCR3Xb2RJH15ZqLt7Y?=
 =?us-ascii?Q?phhqAbd6NKhPu2dJsoBDd4ZbGh3yTqJSRbqYfZfnX7Xkvu6afOEiRmwxRbSF?=
 =?us-ascii?Q?Fap2olmqlHTCcp/C3jMOV810OIyqbyvauoaJenPeMprgvsKn00KQnOYqql0g?=
 =?us-ascii?Q?RsDfjLzRZXrRUFQbhRbhjjXkReJjfjifNwtSfTdhwX/iVByHGK2hVzwn5EeC?=
 =?us-ascii?Q?JDOZ/L+JVla3Z30Bv56xAbxQIhtduOPS5QEijUS2T8l9VWHKIXM5YZloazbz?=
 =?us-ascii?Q?gHoTXkgsi/pqhxh4L089nHQknqfIc+2JlS3lLHqgklGxeTm3Hu1/KdBgBa8Q?=
 =?us-ascii?Q?ObRyAJ7GAu23nXumjdhcNx1jEkeNfbWWCGbimL2E9B7ymqTtEJecK2M7WCb2?=
 =?us-ascii?Q?wUxEh9O4R/BNaGu5Gc/s3ytXO7b7vrY6qKO/0wlGfv/cK+JwaQ7l3BKMDaNq?=
 =?us-ascii?Q?EFO/z2QPz6y47UDN8ePJsVHh5EziUbfqMpyr7Ks+lJJZSDXDypi7yNMtn8xw?=
 =?us-ascii?Q?Z9DyJCoaLw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15aa0da5-7fd4-4ff7-7c0c-08de85d137b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:39.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGSl14Cn5t8Bm/54vNmiuI/lXQhnJb2IUkWyFhQJNo/MitR5aAwZHotBYbtCYXjgqb5arZE1Gf6Gc5FjLMD3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11451
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269529-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: 8D7872CE836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch finalizes the transition to work with a single local
interface for the ethtool_rmon.sh test. Each 'ip link' and 'ethtool'
command used by the test is annotated with the necessary run_on in
order to be executed on the necessary target system, be it local, in
another network namespace or through ssh.

Since we need NETIF up and running also for control traffic, we now
expect that the interfaces are up and running and do not touch bring
them up or down at the end of the test. This is also documented in the
drivers/net/README.rst.

The ethtool_rmon.sh script can still be used in the older fashion by
passing two interfaces as command line arguments, the only restriction
is that those interfaces need to be already up.

As part of the kselftest infrastructure, this test can be run in the
following manner:

 $ make -C tools/testing/selftests/ TARGETS="drivers/net drivers/net/hw" \
 install INSTALL_PATH=/tmp/ksft-net-drv
 $ cd /tmp/ksft-net-drv/
 $ cat > ./drivers/net/net.config <<EOF
 NETIF=endpmac17
 LOCAL_V4=17.0.0.1
 REMOTE_V4=17.0.0.2
 REMOTE_TYPE=ssh
 REMOTE_ARGS=root@192.168.5.200
 EOF

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_rmon.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_rmon.sh
 # TEST: rx-pkts64to64 on endpmac17                                    [ OK ]
 # TEST: rx-pkts65to127 on endpmac17                                   [ OK ]
 # TEST: rx-pkts128to255 on endpmac17                                  [ OK ]
 # TEST: rx-pkts256to511 on endpmac17                                  [ OK ]
 # TEST: rx-pkts512to1023 on endpmac17                                 [ OK ]
 # TEST: rx-pkts1024to1518 on endpmac17                                [ OK ]
 # TEST: rx-pkts1519to10240 on endpmac17                               [ OK ]
 # TEST: tx-pkts64to64 on endpmac17                                    [ OK ]
 # TEST: tx-pkts65to127 on endpmac17                                   [ OK ]
 # TEST: tx-pkts128to255 on endpmac17                                  [ OK ]
 # TEST: tx-pkts256to511 on endpmac17                                  [ OK ]
 # TEST: tx-pkts512to1023 on endpmac17                                 [ OK ]
 # TEST: tx-pkts1024to1518 on endpmac17                                [ OK ]
 # TEST: tx-pkts1519to10240 on endpmac17                               [ OK ]
 ok 1 selftests: drivers/net/hw: ethtool_rmon.sh

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- patch is new


 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 1baaaab3c3a4..5e5fc80867a0 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -25,9 +25,9 @@ ensure_mtu()
 	local required=$((len - ETH_HLEN - ETH_FCS_LEN))
 	local current
 
-	current=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+	current=$(run_on "$iface" ip -j link show dev "$iface" | jq -r '.[0].mtu')
 	if [ "$current" -lt "$required" ]; then
-		ip link set dev "$iface" mtu "$required" || return 1
+		run_on "$iface" ip link set dev "$iface" mtu "$required" || return 1
 	fi
 }
 
@@ -50,13 +50,13 @@ bucket_test()
 	len=$((len - ETH_FCS_LEN))
 	len=$((len > 0 ? len : 0))
 
-	before=$(ethtool --json -S "$iface" --groups rmon | \
+	before=$(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	# Send 10k one way and 20k in the other, to detect counters
 	# mapped to the wrong direction
-	"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
-	"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
+	run_on "$neigh" "$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
+	run_on "$iface" "$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
 
 	after=$(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
@@ -94,7 +94,7 @@ rmon_histogram()
 		fi
 		log_test "$step"
 		nbuckets=$((nbuckets + 1))
-	done < <(ethtool --json -S "$iface" --groups rmon | \
+	done < <(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
 	if [ "$nbuckets" -eq 0 ]; then
@@ -119,8 +119,8 @@ setup_prepare()
 	h2=${NETIFS[p2]}
 
 	for iface in "$h1" "$h2"; do
-		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
-		ip link set dev "$iface" up
+		netif_mtu["$iface"]=$(run_on "$iface" ip -j link show dev "$iface" | \
+			jq -r '.[0].mtu')
 	done
 }
 
@@ -128,10 +128,10 @@ cleanup()
 {
 	pre_cleanup
 
+	# Do not bring down the interfaces, just configure the initial MTU
 	for iface in "$h2" "$h1"; do
-		ip link set dev "$iface" \
-			mtu "${netif_mtu[$iface]}" \
-			down
+		run_on "$iface" ip link set dev "$iface" \
+			mtu "${netif_mtu[$iface]}"
 	done
 }
 
-- 
2.25.1


