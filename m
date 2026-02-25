Return-Path: <netdev+bounces-261007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GdLAbARn2nNYwQAu9opvQ
	(envelope-from <netdev+bounces-261007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:13:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C70199515
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCCAC3053BED
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D526B3D6489;
	Wed, 25 Feb 2026 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VpDUgZhT"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE43ACF17;
	Wed, 25 Feb 2026 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032060; cv=fail; b=meZqbO+r7qZtwWzJ0PT02vPX+nm0y8ocHZapW7cOr7CZ6XBm62YRyvH68lQQrLP467w0lH9R0ikNAZAVVrUcKzm8DqJgJkafBiUE3tXIMmER7MHb1tjEbADKNDTfm0El+7EecOYs/aIicPBpRRbquAW7hqhD94hRWa5LemkcU6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032060; c=relaxed/simple;
	bh=LbTtpH68EaG0b4ztqBRSAMcxPI/MGfWOlfIYDuIVKQU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Lnxs1aZ+YDfGJJZxnoJkYR+Ut9tmoDKXVkyPyH7XnoEtTWIayQKyK4b9mFpHGz6vgV0WJPqpIfuP/tR6lt/5KcaZ3Q9lVBu4E5RlolYEEvFltvbx+MeOPQg5mvBBCbG0XefCls6nPjCqeV79WvCVOzMcFNFB+sIkd8GtBiEwOuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VpDUgZhT; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNl1HCwRELxvMg0zr/5eqUP4NDEFcCuAxMdegQhVzhB8IT9aoROA58sSdxIaEJPgLRiQnZtg7BMV116th68I/yvvU9VjK1Kij9iNWwfsvQRJi1O/JCKQbSc1uQoEuhQYAJCKf0E0p1uHvg80L//vpHZzx4uMhLxYkyr7bwDBdDM73vcfFqZeZmFDJ5HtmHdFvifWrqZIgWJKZRvpbFtN07bLxVJtyn34doDilLRouRHStc9rKQVMD2abL/wn/t+aRVqY/ghUidKEq0OohndWE0TvJZJ32hOAeYgy/0OejTgrfc6oxjTPd5J+Fgt6POERxnsyXQbDb2TFRw+Btjljmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYJ2T5U1lAPGUxhcZjpb1tbkR/MnlwmetTSgS4oUPJQ=;
 b=T25p7PVxOdQrqcFo0q9P4G9+L4XAkoYBj4C+bMUFAd+5TekMNNEfn9Msiyd4VUfX2aOz5LmzNriGEc/DbGN16HeB4tuO0RYCz8mbXi553+PU+oQu8QPe8feLUhjd/yl+BL96xAvNi1ydbdvX4n8T/QAA5XUGJx/fJhP1C7Qb7qpzBufL6vRxcaePJ35NwO76tU3BVSM2xN7IzKAwiAOM+miGRx9aBLB1h5S9XNGMuTirp6tqJYPE9qPXPQys5E67aRzl9bhFMJUosMvwit8u2JlWsCEeu8BU0xnzqB/NTg/UVhkhOUR+tXxAPojsNW4utoQBe4x6iwwvzVA/IHB2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYJ2T5U1lAPGUxhcZjpb1tbkR/MnlwmetTSgS4oUPJQ=;
 b=VpDUgZhTw8Q203ZkJ5hQ3qYa7LNU/5BUYvFFC0fgigoEFQJvh2EwXk1VpxvZFEFUp0xyDchLhd2Hs7ZpvRiCy2JQrYrYP1aEgJFGovJpJIIm2VuGXwv7UMFEkA+InF9mCV7giXfIU8sDGlvtZO+Nq3E/+0L6yP360rHUNKLXmw7q4gveMbJAYCaaDrjH94bDeyLP9FaQ8m92ZXJnTp6S/Q4ArPv7IbCsTlSi1kj06jJ8005pldDQOSmv4jVoG+9gRjiGwAL4i/e263kWhqJUaWBQ/7X42Kt7ylVSXR6f+RST5fn7Ntg3mOlJVoEN9A2B146M0B0v0W7dNiiFplisNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:07:26 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:07:26 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/5] net: dpaa2-mac: export standard statistics
Date: Wed, 25 Feb 2026 17:06:43 +0200
Message-Id: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::19) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7cd24b-fb47-4c04-dc28-08de747f963b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	BnYvNJXL1eAq1jL/zJevzA8eI8iFsjTBkDhZyPUu8i3TztjpsO8k805S42yAQjp159wZ64b3AcxT6br/OD9neVme5K8BZwQF4kD6fEvGogEJbtSrQQ7nQ1muCNanBygr7dxMrzOeQZSq2yL1Odms2q+apv7Cf/m37FRBIJmsS+fcjuQoGpcNmzXIDJcvuIonFSiqKMTcs7No0mSn1/Rm7uWxwSqQYl+ANZ+bHe8z0ZCFJ98hDAaqsqh69+i8z43adHwMOUAE2/kd/BLM8Ay/MrLHEuOp42nPMdCY87OUZcwwvEGq1wA5Y0Lw84nW5zDoSyDReI7ibhzdCturXtKV8fFwidZna/P3cmd0bNQh+FxJTOJJQ/rXAK8bpvpQa+pwP/KtF3G6HYk5EvPgqOtrPmq0fnw17zUb5ex88PzPFrXa9aAA1H43wHwiX022GRtyDkiaw07VB5/VjpmYr3emCdDoyr37o7p38izQcgrnVuaviC2EyuzenWYke94Ua22gNG++oS9qALn2JkpGbB4rNoFPlzG4LDRQeJYbQ+bMfnXmHXh6fDedGYzOQrqT51uYNb8dx48BF63yPF0bl+EqnGlmdPbZ17hmCZGpEL9VD4xA4cIt1+93fRZC04qpT7MxwWElVU2/o3/DDZch3Sk92LetFJFOtYimPhOQmOFgAy5gioglaeqPixs4C+m3BxeWtWjlcltOO5/AxgBtDsHSgOhBoYPDtHyHgiEsaTabxl8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GWUNl32lUAjyWXBUXAFBgjSJBa21nc147+JJY4S5sIxCcXLadzcHCjW6Mi9X?=
 =?us-ascii?Q?BsSew+XyUUks3x+efLaC/eORWT3qUd29bMMyesnPavlcD2rJDFZCJmh0HoS5?=
 =?us-ascii?Q?4jhUsnb8mC0x+wI2X3HjaA09v9frxgR5QojWgNLGVZNycqEwC54z41S6ka+O?=
 =?us-ascii?Q?X0TauYrD/FGXBjZivBzyQA/ebzJomBiTk0a3mNQCQatmLv7IbRbWFxh6EtgV?=
 =?us-ascii?Q?6k0xZXHQB6JyNdC2+rxY8zJI33Bwr9uSgjvkCMaU/pdRbSrshGTX9HaFDqES?=
 =?us-ascii?Q?PBSuw4Lr1RGhpLAxIPCkTtMSqKacvmZei+DguT/X+bkJ6qrxmUq7Kn7itErY?=
 =?us-ascii?Q?pVAvw913c7tzvGKAbeYPyR+2YzMDs1FMeaEBcm/q2ireo35K8u9aLMJCXc9z?=
 =?us-ascii?Q?suPQ1Zxb7nzyuSL4LU8/NUA7bSQ+fh4AaVg3FxSXDnhmSDdMe9KIyxMJRsTW?=
 =?us-ascii?Q?eRSz/0uQpcbqBq3BwGaaaJiXeUe3cZUCiIIhF/Svtug9+NcOaE9yVvrkU5qh?=
 =?us-ascii?Q?ukYDaOEdvkzbkqvMmSSmKPn5VYZ9dBgAtD4roG+4IMsX7krHjLtpQQ+K9S6p?=
 =?us-ascii?Q?iLexq+B6NFl7SF/q9Dht9b6tRz9pQnTrzQiod93236flvvqQglFAGjE4L49c?=
 =?us-ascii?Q?qHadZZ12AfXZYYcee2OpomFnKz9mFWBBFWwhWueBnEoNa/ND1FTNxXuMPbyd?=
 =?us-ascii?Q?jYwTfNURurCI0zyt1sVBw/GO3YkLDJh/E57HATdzr1KLVuXljv3Kwgdvps13?=
 =?us-ascii?Q?Vam3p1QNx49KhSy1X/ZO0qFr3b/nvpvzfZvR3fey6cofIvjXPG7qaJ9lY0E7?=
 =?us-ascii?Q?ltC37lvnN5WWeKmPeSKMqjhAzufQIpv8CXC681fKUdN+ciPc44FIx7D5bub1?=
 =?us-ascii?Q?j6GkLOJPtpPE67UrCFuC2/i5YINYuLPkhcPpzlXSwyZxQas9GMBrS96fC/K6?=
 =?us-ascii?Q?x8Ohtc/ycFaDbU+/aGxUqNG++98UA8t6OBQfV3fe+xy5haWRBgECIjCYoBff?=
 =?us-ascii?Q?HZx0rjLQbTBykGbh6Q+7e2HF9dn5wKATqruX+bxPCLaWMgTsqC6ibS6n/sR4?=
 =?us-ascii?Q?/kkOQSxSsyiBRfZhEGixPLbS2eqgT42vOxAgT4rwlOl0BQHi+g3+VyO/f2Z8?=
 =?us-ascii?Q?RbKJUoDmpjkc0lihzvUHJztfgt0KvOKJbRFiVULJqoicsI4Euu4Kmr4HiyPa?=
 =?us-ascii?Q?kBupJEBIbNCUEpWkWeOgwT8ASW9IqWlnpejGn9EvczJ01A6jQ0+OeTxzobxk?=
 =?us-ascii?Q?Hu4AeYirdPqZwcao5h9aaMAOb7NCg7Qm7c3HVfUZpwebVSwN7Kcsva5zNx3F?=
 =?us-ascii?Q?KHyAWSm3F1fMX85R6nzA5cEVFDuxqyanRMS8M0Wir7Z/j3WYjPDqjnHTriA3?=
 =?us-ascii?Q?Ju1p0foDKG7/fcTt1rvVBJ+CFR0ldzdt1lzCvZMQY4spoGrKJk5aFz7OFfEI?=
 =?us-ascii?Q?Ch74HOqoQb4WHnRwmb3E7JNBXOWWCpnzuEwvOcEdL9+2edMUSHBVc1Z9zd4m?=
 =?us-ascii?Q?9lpnsBFa/l7bbG0jxEnd2ALlDjWLLECyZ4ENTA4aNfS/+DitvJyIAnHSbYJs?=
 =?us-ascii?Q?ESAeBy1qobGSVWkeFrV34Rl7AI6jR64iKlCDOeyW21DyWsxxl7EDk3RDJtAe?=
 =?us-ascii?Q?0uVZ6guk1SGkv6SQlzz8rXh16R7RCZD/Tl5oXb3zTrvOd4F8H9ZDepuGer8j?=
 =?us-ascii?Q?47gz9Lk76hd0Wjp1Y2JA7M1/3yC5oUwpierxKOljsmmUG2trrXH2ZaALWGrA?=
 =?us-ascii?Q?VWOV/sUQFQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7cd24b-fb47-4c04-dc28-08de747f963b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:07:26.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z94a9jxMREjYDQTTkwWqKX98U7/XsPL+ExRYfetBZTUTxJCYvavNHnxgqb5UwIb5OdN6t0Sc7kXDfi5nc7H8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261007-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ethtool_std_stats.sh:url]
X-Rspamd-Queue-Id: 70C70199515
X-Rspamd-Action: no action

This patch set adds support for standard ethtool statistics - rmon,
eth-ctrl, eth-mac and pause - to dpaa2-mac and its users dpaa2-eth and
dpaa2-switch.

The first patch extends the firmware APIs related to MAC counters and
adds dpmac_get_statistics() which can be used to retrieve multiple counter
values through a single firmware call.

This new API is put in use in the second patch by gathering all
previously exported ethtool statistics through a single MC firmware
call. In this patch we are also adding the setup and cleanup
infrastructure which will be also used for the standard ethtool
counters.

The third patch adds the actual suppord for rmon, eth-ctrl, eth-mac and
pause statistics in dpaa2-mac and its users.

The last two patches extend the selftest infrastructure with a new
script - ethtool_std_stats.sh - which validates the standard counters
(except rmon which is already covered). This new selftest was run on
LX2160ARDB with both dpaa2-eth and dpaa2-switch interfaces as well as
LS1028ARDB with ENETC and Felix switch interfaces.

Ioana Ciornei (5):
  net: dpaa2-mac: extend APIs related to statistics
  net: dpaa2-mac: retrieve MAC statistics in one firmware command
  net: dpaa2-mac: export standard statistics
  selftests: forwarding: extend ethtool_std_stats_get with pause
    statistics
  selftests: drivers: hw: add tests for the ethtool standard counters

 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  59 ++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 381 ++++++++++++++++--
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  23 +-
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  45 ++-
 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  |  11 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  |  30 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  |  86 +++-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/ethtool_std_stats.sh       | 192 +++++++++
 tools/testing/selftests/net/forwarding/lib.sh |   8 +-
 10 files changed, 792 insertions(+), 44 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

-- 
2.25.1


