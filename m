Return-Path: <netdev+bounces-272066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AYmKdM1xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:34:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F0433607B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF6E30AB171
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72802DCC1C;
	Thu, 26 Mar 2026 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ELHA8Zgz"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFE33F8D4;
	Thu, 26 Mar 2026 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531737; cv=fail; b=MR92Vw+nIrXx5pdgKTP6RVZrMZqhbM3vF4ghkQ3nONVLc341zhjQKwu2ZiPqbCmP0PbVshpj0FONTw7gxF6HVFGA/L8E6ih7aWuHKYo0vhPubZeksttFW2hIJmVap/5Jjx4sufnLL/1h1iVSekftkxbrJXHXxf2+tGiGnSTN6BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531737; c=relaxed/simple;
	bh=XvpEUhcK1ePcCYD7Pq56rIW/wMvkkD8jzAfyAKDxn6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4+De76jd8dvJcpP1oAO8P+5AMJt21BM5wuKIuFv2rDs0JSO0uD72zPZOBGR+TelX/LLge/ryNfpT+0+8lL4eq8zemJAhuKotntgioG3Mnwh0vZSY1Z6VdgkyWzw7DLrePLdSlQAea/talCHyorU869N5tydjA+Ds0rLrgg5Dqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ELHA8Zgz; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ykbo9CFIz3HbTXKsJSoIf1W8G0AExAaKHNSWpoqrhCqsQloTzAyBEeql6QrHRQYyrrKGQoAkrBgXc9YczNSL7QVycpmyPftfpQ10rwuUkkpoi+y/o7pzE4tIwtMKDGUlpzpc0XpHRjPXYfNiXsgkt5l6+iPN2SQMyu2/HNEXArPfjfKjqi+5sf+/4w821ANuP+ggZkSYZWvJWgXULY5V9isqkivmzE38A/KV1CNrj+mnmboQbIaMFG7B9PomnFatwSNjxzc6FGoL6nU6LbCp9d1zqmGMLuxvsYyWOQJMiP4E/HMDVbCNCxtXy80MUbIyWKCTowofZT10xYjYFmGWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpZU7XenEwRtOrm415jsB+tc/apgBdi2B6MPXWSxwMY=;
 b=EcOvZs7fOU0g1LR7Ob8vT2s5i42xQ+lS7QFjX1uh8YQI3wNHJjcV16qMEhHEqvE4ONAqhgVMUollFqlDMowB4v2Wj5t7auaolv/A+OG6SrHkVOEBPKnqFCkNWfVvgT0JXvXpV4/DXKIerQeQVrNZnyeY5o2du5KodtoZmY/K71+pZxdywgl+TGEaGG1am2i7o5fLFYCb3WEplywmSqfjKBv+BqI8K2QsKuOFmRsIQhY6TuBNZ82y59y7j6xwlsE1yO8YzPYpOf2j8kJ2FO657YLRClq2NbFKnB0oQgcv4sj8LcVB3ocA0LWnDA2KgZ+KfTbZ/OAJnz+Nwp7TknsHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpZU7XenEwRtOrm415jsB+tc/apgBdi2B6MPXWSxwMY=;
 b=ELHA8Zgzswd/6/B86r3iWWF6EAkTfnJ1H/tJ5mJU/s/HcGMdfuSAp9n9SrrXiJevon6snlO4coUxPv2MRtL+2p1K2zpXaLk2bXu51cDV5wN5KE5JdGg5VEEe2X7eI06NuNo/cSs7s4zXgVjl8NOIYS5anRrE0WWPXPpar536AveoGOP5FHxKGdTXRF9QzmyQKc2GP2d5dwN242N9N/U0h4nAuh81rYJOhEg5FTx+uvvNbTVE1m3RUnYZzX9EIqWMKozI4sdilK9+7lsiGOcdRHXSIWQ4ObKsP/I/mfk086Jc8GesL1uKKmL+parqpTg8vv9moZk9enduDh11G0d/+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:28:49 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:28:49 +0000
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
Subject: [PATCH net-next v4 03/10] selftests: net: extend lib.sh to parse drivers/net/net.config
Date: Thu, 26 Mar 2026 15:28:21 +0200
Message-Id: <20260326132828.805703-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 590ec73f-d505-4f80-351f-08de8b3b9d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	C5L9xjqPsy1FMKJAK64DbSRd4+l0HZTyL7tK6MD8So8Me5YOUBZAOLzgM9ExIETruXfzvXuPPs+jEm4OP5bGpvp2IPZS925t0OYh6/SnCyxq+hoLe/fstsAWsilREMueRvTjoajGcqo0Ka/yXALnswkg0t6sJKZz3foNWNaHHn0SYxsweKNyWvWoYZetarBLQY97mO8IB+a/RyMTn6i1kzR5mFFkKFsaaLRhW3PfVQwxc/JTFC6HVxzKlBcpsoLoX7xZVdo2g67G3noWnt5VJmToich8SQzvFn9k58JxcsOIQg5Wu6vicfYepPKlBEma9hA3Ee8Y6Ttso5rCT4A5+vPIt4s/ZUFAU1nbjTBdtfxSuT7g1x4CCuYuTpXUwQZAEZSapTFvVRTeW9H8Bilq6cFONQH/NPIQ4ijlAPSiEEFGzlQrJ8jPvG3XCa89M7sGiWk4skXEEoKtwVf9aa6CMbdTe2GU4eft6kBqx4tGESsHystp60/CJXSFTA/pLjpVgZsEv0HOfv0rMLM81EIRVO7pPbPBHckwf6P2DdEt43a1J1q5nG/GvYnRgFcSa5Hqc/O/W1uxH30elkvvhmDV/8WJamoXnfdJjOeXFoA6DEOrnu3CU9i3YHFFZKh8vx2obEa4TeWq5dInGALlFj9Qrl/BGJUK+XiKoacIARPsLfrBK6LuDgchNktWvM1aGcSd92W+OCatkQQFkp3G4lQf9cKrK+1a7fJnl/d4fBBl3yk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tNJ9MD1Cu5mHdt5/jFjoICsMd+1TKhOy1x8j7M+xWgtESEWsfVme9TyUvln/?=
 =?us-ascii?Q?pfncskYvK4Jh7e+LXHfeGA3eCr+My4bFtiGGezDySNyNjKhU21TvMY0MAbtu?=
 =?us-ascii?Q?1IXTv0dT109ELbEt2Lq8E8GHlX1f30O0jvGCVIvyfCFVrHMQftHvyXNZa7I7?=
 =?us-ascii?Q?Ewy0x4RS8sBoyImbnwWIy57La5JsqSKOS7+xs57zFPYhaj799t4S5SagYNUd?=
 =?us-ascii?Q?1JB/XAQ7XaCUCo+OV+uUbrxJYGq7gjO0QsXvlS109owf29sszKZOwxKP5FHS?=
 =?us-ascii?Q?K4RhSwSiCXxuaZmseJ8JBElmUeemTwouxGA9La46PpCWs2uRopMMlKqVahak?=
 =?us-ascii?Q?vVRRaJ/Px61YX332EjQkSQTGuhXlBvAVicTlVU83d+btPIf4D0CC+ryfHnv8?=
 =?us-ascii?Q?gbjh+ihXyVUF8b1cNrqZnUwfbYDFdlEFeOjzG380kX62f5Xt4Rg5RT2KpEer?=
 =?us-ascii?Q?R71xNuthfZgV5OOTfTiE15Y/Ty0pL+3Z8mpT6IPllCBKbror/NvvzCZj+7/D?=
 =?us-ascii?Q?zG8ZqP9nYSl+AJUcyKw06uoqNcI185sB/H0D77t/G0C28omzD35pMjPcg5CJ?=
 =?us-ascii?Q?0Z9HrTawm0g5L09gvDzSTdTu9/Yf3HJZL4leKMMIvcU5MfDGg3xDbMknaahz?=
 =?us-ascii?Q?N353/fmP01PHFEknyvgEQaO6VE0d5skRd9rwlooTj6ZI0J5/bz93WxHZ8Olf?=
 =?us-ascii?Q?aZ87VV/tua6Ad4+FtztvHhhjxjJBbmXGfaw6vI0P0/G7nuA6WgtKfVU4GhXu?=
 =?us-ascii?Q?rwNpSWT8qIXSkLW5SX06eJyxOFfXrO+MjKblRBjgnWhqLMe+TVMqe9S0SzOl?=
 =?us-ascii?Q?xRGMlGqzX495xdGs/vBbimzYFkra8d2W47vMrVmcWbysias4rg3tw70p8/sM?=
 =?us-ascii?Q?tGix5Ev5XpEXps7ALMETCorziXsWGscY7S7kkPgODWBMJhT4yyK5q7q8nCci?=
 =?us-ascii?Q?0MLiVnBxuMfXX7sF+b96ttUFYtqdYWFqComLSv+Xdx34Ulyk6mXCAm4vTLU5?=
 =?us-ascii?Q?Ty6QWpF8ddwH+2IQeSSCW7+HOMI2eYG/wnvhmJTO8QMzlwns6aTw9TB6vCBi?=
 =?us-ascii?Q?3sfu3f6ZAzJoxg8FL6SKJ8LpCUWkPHA0dUPiDw/ltc7JWELjZPZaLJDfGcxp?=
 =?us-ascii?Q?0B9jhh4QeoR+UhXsLzTjBndbGjMilp0OLBmOZ1BJh/lxkK4/nYnDMRLRTjyA?=
 =?us-ascii?Q?/H0r0lzUix7VI6I/a2DUrYsqjZk/6KEvTiIVmh14Z5KlrgIbQG4n8R0EWtN+?=
 =?us-ascii?Q?UXjPaFQ+AptwO11P6s/7vn6Vjt7OfgjoXVSVx7qkTYzW/Ifc10EM9FWSgQxg?=
 =?us-ascii?Q?StkHRzbbu3vkaVhT6iy3NXEC2ar3yxoDRVKNS+QlxC939m50I5CQ+oqzQBnT?=
 =?us-ascii?Q?raKDw2phMyhg+L02B15QwqEnJotamFmkrTR8NbaEOeelnpyNMFrG5BkoZKWB?=
 =?us-ascii?Q?8l5Io0GLNrbpJGA3IcIrNGEEpMTp3QS13X3uxf+9RtkwL8QDkiQ3Lna2lY3Q?=
 =?us-ascii?Q?bDifnhCCHXrV8H+/qh+dSyUs/8CAv8Lgd5ulA5zFAMO4Nc1Ra2PDlgJG0SYe?=
 =?us-ascii?Q?DaKKdL0vGGWZNItGcwms0lCBhfmg6X14I1niCEC2I32xW3hzDG7jLpJaMZdA?=
 =?us-ascii?Q?c4DSFSg9tcsp07kfoD9Uf0Bn1YjGKI45yG4o3L2NXp4dLm1RK+2Qt9WsvgXK?=
 =?us-ascii?Q?L+5no0FfjRhPt5jNhFFAxkGlNrrZVVXi4RoWd1P+bHUBmfkomsSrwiyc5OFK?=
 =?us-ascii?Q?en2r7537eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590ec73f-d505-4f80-351f-08de8b3b9d2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:28:49.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /s3/kzeRuHcT1ksWzmkfnLoZjHLdat6ybQDk28upGgUlDqVANck5AfuzJkbE1GmZQ8KwZGvpbEUgEClI2ULKRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
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
	TAGGED_FROM(0.00)[bounces-272066-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.sh:url]
X-Rspamd-Queue-Id: 01F0433607B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend lib.sh so that it's able to parse driver/net/net.config and
environment variables such as NETIF, REMOTE_TYPE, LOCAL_V4 etc described
in drivers/net/README.rst.

In order to make the transition towards running with a single local
interface smoother for the bash networking driver tests, beside sourcing
the net.config file also translate the new env variables into the old
style based on the NETIFS array. Since the NETIFS array only holds the
network interface names, also add a new array - TARGETS - which keeps
track of the target on which a specific interfaces resides - local,
netns or accesible through an ssh command.

For example, a net.config which looks like below:

	NETIF=eth0
	LOCAL_V4=192.168.1.1
	REMOTE_V4=192.168.1.2
	REMOTE_TYPE=ssh
	REMOTE_ARGS=root@192.168.1.2

will generate the NETIFS and TARGETS arrays with the following data.

	NETIFS[p1]="eth0"
	NETIFS[p2]="eth2"

	TARGETS[eth0]="local:"
	TARGETS[eth2]="ssh:root@192.168.1.2"

The above will be true if on the remote target, the interface which has
the 192.168.1.2 address is named eth2.

Since the TARGETS array is indexed by the network interface name,
document a new restriction README.rst which states that the remote
interface cannot have the same name as the local one.

Also keep the old way of populating the NETIFS variable based on the
command line arguments. This will be invoked in case NETIF is not
defined.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- reword the entry in README.rst to mention that the different interface
  names is only a bash restriction and the python infrastructure does
  not have the same problem.
- only declare the TARGETS array when necessary
- add a new flags - DRIVER_TEST_CONFORMANT - that needs to be set by the
  test
- rework the check_env() function so that its logic is simpler
- source drivers/net/net.config only if DRIVER_TEST_CONFORMANT == yes
- check that NETIF and the remote netif have different names and abort
  test is not

Changes in v3:
- s/TARGET/CUR_TARGET
- this used to be patch #2/9 in v2. Swapped the two patches so that the
  run_cmd used in this patch is defined earlier, not later.
Changes in v2:
- patch is new

 .../testing/selftests/drivers/net/README.rst  |   4 +
 tools/testing/selftests/net/forwarding/lib.sh | 106 ++++++++++++++++--
 2 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index c94992acf10b..1897aa1583ec 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -26,6 +26,10 @@ The netdevice against which tests will be run must exist, be running
 Refer to list of :ref:`Variables` later in this file to set up running
 the tests against a real device.
 
+The current support for bash tests restricts the use of the same interface name
+on the local system and the remote one and will bail if this case is
+encountered.
+
 Both modes required
 ~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 3009ce00c5dc..93b865681840 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -3,6 +3,7 @@
 
 ##############################################################################
 # Topology description. p1 looped back to p2, p3 to p4 and so on.
+#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
 
 declare -A NETIFS=(
     [p1]=veth0
@@ -85,6 +86,9 @@ declare -A NETIFS=(
 # e.g. a low-power board.
 : "${KSFT_MACHINE_SLOW:=no}"
 
+# Whether the test is conforming to the requirements and usage described in
+# drivers/net/README.rst.
+: "${DRIVER_TEST_CONFORMANT:=no}"
 ##############################################################################
 # Find netifs by test-specified driver name
 
@@ -340,17 +344,101 @@ fi
 ##############################################################################
 # Command line options handling
 
-count=0
+check_env() {
+	if [[ ! (( -n "$LOCAL_V4" && -n "$REMOTE_V4") ||
+		 ( -n "$LOCAL_V6" && -n "$REMOTE_V6" )) ]]; then
+		echo "SKIP: Invalid environment, missing or inconsistent LOCAL_V4/REMOTE_V4/LOCAL_V6/REMOTE_V6"
+		echo "Please see tools/testing/selftests/drivers/net/README.rst"
+		exit "$ksft_skip"
+	fi
 
-while [[ $# -gt 0 ]]; do
-	if [[ "$count" -eq "0" ]]; then
-		unset NETIFS
-		declare -A NETIFS
+	if [[ -z "$REMOTE_TYPE" ]]; then
+		echo "SKIP: Invalid environment, missing REMOTE_TYPE"
+		exit "$ksft_skip"
 	fi
-	count=$((count + 1))
-	NETIFS[p$count]="$1"
-	shift
-done
+
+	if [[ -z "$REMOTE_ARGS" ]]; then
+		echo "SKIP: Invalid environment, missing REMOTE_ARGS"
+		exit "$ksft_skip"
+	fi
+}
+
+get_ifname_by_ip()
+{
+	local target=$1; shift
+	local ip_addr=$1; shift
+
+	__run_on "$target" ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
+}
+
+# Based on DRIVER_TEST_CONFORMANT, decide if to source drivers/net/net.config
+# or not. In the "yes" case, the test expects to pass the arguments through the
+# variables specified in drivers/net/README.rst file. If not, fallback on
+# parsing the script arguments for interface names.
+if [ "${DRIVER_TEST_CONFORMANT}" = "yes" ]; then
+	if [[ -f $net_forwarding_dir/../../drivers/net/net.config ]]; then
+		source "$net_forwarding_dir/../../drivers/net/net.config"
+	fi
+
+	if (( NUM_NETIFS > 2)); then
+		echo "SKIP: DRIVER_TEST_CONFORMANT=yes and NUM_NETIFS is bigger than 2"
+		exit "$ksft_skip"
+	fi
+
+	check_env
+
+	# Populate the NETIFS and TARGETS arrays automatically based on the
+	# environment variables. The TARGETS array is indexed by the network
+	# interface name keeping track of the target on which the interface
+	# resides. Values will be strings of the following format -
+	# <type>:<args>.
+	#
+	# TARGETS[eth0]="local:" - meaning that the eth0 interface is
+	# accessible locally
+	# TARGETS[eth1]="netns:foo" - eth1 is in the foo netns
+	# TARGETS[eth2]="ssh:root@10.0.0.2" - eth2 is accessible through
+	# running the 'ssh root@10.0.0.2' command.
+
+	unset NETIFS
+	declare -A NETIFS
+	declare -A TARGETS
+
+	NETIFS[p1]="$NETIF"
+	TARGETS[$NETIF]="local:"
+
+	# Locate the name of the remote interface
+	remote_target="$REMOTE_TYPE:$REMOTE_ARGS"
+	if [[ -v REMOTE_V4 ]]; then
+		remote_netif=$(get_ifname_by_ip "$remote_target" "$REMOTE_V4")
+	else
+		remote_netif=$(get_ifname_by_ip "$remote_target" "$REMOTE_V6")
+	fi
+	if [[ ! -n "$remote_netif" ]]; then
+		echo "SKIP: cannot find remote interface"
+		exit "$ksft_skip"
+	fi
+
+	if [[ "$NETIF" == "$remote_netif" ]]; then
+		echo "SKIP: local and remote interfaces cannot have the same name"
+		exit "$ksft_skip"
+	fi
+
+	NETIFS[p2]="$remote_netif"
+	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
+else
+	count=0
+
+	while [[ $# -gt 0 ]]; do
+		if [[ "$count" -eq "0" ]]; then
+			unset NETIFS
+			declare -A NETIFS
+		fi
+		count=$((count + 1))
+		NETIFS[p$count]="$1"
+		TARGETS[$1]="local:"
+		shift
+	done
+fi
 
 ##############################################################################
 # Network interfaces configuration
-- 
2.25.1


