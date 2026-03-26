Return-Path: <netdev+bounces-272063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CBDAxk1xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:31:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 546ED335FAB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7F130182AC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F82DCC13;
	Thu, 26 Mar 2026 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQNAX/4f"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73BF223DD4;
	Thu, 26 Mar 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531726; cv=fail; b=CzYcTBCXYFdkQcpjjwoT9G9AtFhQv7qK0Yp5rm1yQGZerFv4SVwNHK3cMdyfOvzvdB4IRbK2dpfnoANNTaBIxDPdhSMan6CK+8PeIjChYt3WbRMYcVrQtXGjiwuZv9VMIQsf8reJ24TfRYtrRZs3otT/BlgD2fciWf7vd63Mvos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531726; c=relaxed/simple;
	bh=wBPkIf574gS4N9LdyXzz6eKObjdgP9V1ZZsI5kM6deA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=vEF6i46gKAdfWzRYnIkmhysa+3pokShd3W6Umxp54hLaPmOYszJPRTOA5aKcon7qkw7G+obnayo2n0JfDOKTAT+ACFWyUEiiYAuaCLsAodNKmt5BLxvbhBv/I+TNy/ql+WD7DrDfoSJY0CrW+xHCWSLxqX9DOtk8wyaXttM4JO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WQNAX/4f; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwWcUGLlsNM0Og6cHR07Cjh6hLZvREO2xPhI3gD+QOPWTr17xTLMDKuMPY1alAUylj8oYvQASUvNvr9CJat+rHxEvBcKgK5UnPCJ5EzuTfTOvTX3uw/Y/qzAyfZjotwZmS1rag+N34Lz+tCclmxY7q9jZMou4KocMBC1bIXooe6lfC3Om2MrCh3+HfLeEWtvFsxjqrbEUicpkvnraUHHwqfETXg+ZOorUjhaMBmoUBX3bF4p7CWnFqSw5J6qVmuCVIe2MB/6TbPWGxhs1tSLi6hlqcWZ06MA2Bj5dgiH9ZcKxr3aKPVH7FePdQyONLHzn/lzeQrrn2dwRP5IOECoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNmVAhGmZkUG4pCdYyaldf9iK2kpPmviuQZuHsT/Rnw=;
 b=j8su4jBM75V4ukwJuberUEYiGZSfmuXmdwPaeD1RnUC5QEziHJ7VCuS4LjRaOXf6ujuvpaUJGBfkdvBH2Q9PQ9gmaEEhG8Y6VPvDFObS+UglJ//oeBFCf2CjkusRVXNSnh9YC0nm0Etkbfx8qmg4I/oPckbp+klsLWfxtjBMhtBF+M/nJEPPtXpWtT16+rQxGHNx6b9jgzo1ybk+Q+PfuiWb73fiz5K9ryffLkvy48b18w+DPdvvg2ie9BT5Z7yaezQ93USjp4k1F8QUIFOsFUTMPn0PwP8HLC0MYtEI4v9gRy7RxWvP+p7c8kJH4S3ehee1R2qZmEGHZEdapPZKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNmVAhGmZkUG4pCdYyaldf9iK2kpPmviuQZuHsT/Rnw=;
 b=WQNAX/4fsH2xWFgvLnEEXtVlhO91Y4wZAb56xqDK/WkzBAq3j0XL5T4FR9jbWgCzP1Z2NvQRigZzNuyII5jp4Noy2FygugyDpE1Wnv6zCSAUFfccFQdNfwXigHENYIKAuw4MYjiS3OmvdxIMJQ94ofjPJB84r3MJy5CjXhc7X2KIxZRhnWbuQziajWaCStRhUZK1TzM2F3G0KSPbVjgF548Bw39nb4huSa3/aXsYEmWsJ/76A+LgXnGHv07ehuKLb2jd/nvNRM9KYn7/MIenVpOTzNhfmuuu+304cG9KB95I1gk3wlOMYSCDOQMm3LFcafwtJmisM4DyFnVYL5xVCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:28:42 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:28:42 +0000
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
Subject: [PATCH net-next v4 00/10] selftests: drivers: bash support for remote traffic generators
Date: Thu, 26 Mar 2026 15:28:18 +0200
Message-Id: <20260326132828.805703-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 7134252e-b5f1-42ee-4502-08de8b3b98e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+xrfIDUCDgcf8xPh1pkDt608qQ4LhrtIc31dX8OIggTX0gNkn7C+5LYajiTFTcTyLv4TJrZ2TTtojct5wMSO2dMR/VcdS2/oEyI3SYomnryJLMhrQPIYAvEHnnsF3RSWjDHluzf3mqqdDkSh0edTNiDxZONGoUf7qQjvQlc2qp8H4s6hGtrZHiMpc+UJnOqFFbcnD3oxRq6j3QUWEhTd6KdEZ3Mxkgjm8rlUE8U5rci5jZB8bzJl0gSuANuzEkBpQPLxTuoKEicsjzKyA9uASuLL9NV+JUIyooSDu7/sc3JeosBQ4vb0aXoSXShShv2fBp6TESwP7z7LS+S1mc433kkZdg88oAt7bUZy9GK0th4GSJu592rsvZSqcnVA80EKlCoreOlRzo9gkiL1MCmBRkpyL4bCFmZ9wCNDNMEf8bclctHThU/K66avynMWedhFvSO75d+fR+YPSJeK7N2xnTakO69AUABNOot12PNKfaZeOPanlI49BoBjExCFbgxyKwxbS3Di2yjwbHc9AWBNI7h/6iLJHdHdiMPpeWVeBvKcP3QIqs/JN5mMYTreuIjonvG5LN5WkYdErQuQDrCk/5/lC1KAOecphwmqZiJ+jc//x8EwhJzcOAplP04SBNh979Xx2E0O6ugAk5v9lUb9XaaUmF5tArqxGCrFrIhFnneGmLdq1yy5REna9lZrJHcakHsogOln0O2U3RlH45eWiXqHAzmOYfn4Tg9LU5kkF0g7atQ+M/EmH8ZqCU89a2YC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?icyHL7K4+24+8kxsNyQfOA3acNYS+hZ54OytIiXQHSA1Z2E6w51iJe2WdhDW?=
 =?us-ascii?Q?ZwM0ib6iS6dW1ltygEuHgj95Qw88PpnIKlwNUJskDLq9UUbSqCWMymM5ogli?=
 =?us-ascii?Q?7FBy0eM7ZP+GJWMSXe+gEwysg/vwxSS7nlDOFj+mYp2RLjuGD4Ia367TgL1D?=
 =?us-ascii?Q?bURgDdrtlpaxfcNOkXHRMJPWcvBHbREdlxaIdN8ydtbTMdavOFK2us4Sf3+1?=
 =?us-ascii?Q?q2DrycFdIW5qmYtIVNEvy7zM8MRSQjkGkbu9fipuqmmdKpyjHAntEttTIJqW?=
 =?us-ascii?Q?WTir/Tyxd6WPOBbjT+Nj15G0Ktc2zpApOdfihR+HuEMfsJ05HscQTVmhIFB1?=
 =?us-ascii?Q?9qblVQiaKya031CenGUbQjmB7xJbaQcHtIkKI3rA3MDOAE9lsSsXNINAtvRe?=
 =?us-ascii?Q?LAaFZF6whR30YOU6ypwiTaV84Yv5ndpXZLrGzlM8/IHbWJsYUePuR7YqU5bG?=
 =?us-ascii?Q?1IP8zSVkIf8x1aDmZot9CBloOXjkzFBw1NlTKCiaAw++Yu6WVKZr44OzMle2?=
 =?us-ascii?Q?9GuJjqi8OnFfW+ABfhagDg1d2bIxaRUsoyTl7yPxYr0n2UnHrUt4GulF3jEE?=
 =?us-ascii?Q?YT+/CeVGvADsM26WqrlUIkaqtrDSUj6wYzvh45dl37zXIjhsyZC6zBRbMpUp?=
 =?us-ascii?Q?GxR9iIZmbLikJOoCQvnsE5C2cKIvbfgthEGHWpeUNemrw8l/R8E0eVPVGAp2?=
 =?us-ascii?Q?i1UEhUtunUQVcH6CxILRdzOr52d9Gm5MEO/dlO1Q3eHkrmzI19LIkoW1cV8B?=
 =?us-ascii?Q?MA1aSZ9V0ayphOZm85gz1EYwuzQD91xL72Kt9yKrOqHtzfKRPVyzHIQRGXQv?=
 =?us-ascii?Q?IUCzue+Ou/dI24ylsA3nxFnOx/ClX1wS5oxyWLEn4a+W3kfJOFmtiO9jhKBh?=
 =?us-ascii?Q?bHsTLLHDl4nsfegVO6o241hsMQBgaF5gbRFugCFXmeKCTOU21xaHn+LHCBig?=
 =?us-ascii?Q?caUeEkwY60WfSJ1+oL49ZscBPVuAxZL6KhP0GIzdOUw0SOsry0i+PhSzOpvq?=
 =?us-ascii?Q?hDcAX+H8zSqr1b76lEa5gLPFlYbdZFrUERnKuJAm1cD420EfaU3akS0LYTOI?=
 =?us-ascii?Q?nEiku+QKW0L92J0V6bHRSNe73ucHzNLjqrUTicu8TPinQtgfzb94CrV4qihp?=
 =?us-ascii?Q?uadnKJRrFPTapTEi9i2npuXCKNjw+arB7+Al/Utfi2JR4dLnqHtRBcHazJPh?=
 =?us-ascii?Q?gYTAzExjXjCpf0CFFZCYlghryQCETezEITyA1HNT6ppqsNfp2seXtKQfKit7?=
 =?us-ascii?Q?mv1PPmT9KvLl9v9K1yceN+9KGwkG5lpTf+6xalAGbw7yNgHsLEIkDtvrhea1?=
 =?us-ascii?Q?wF4fUu4WlM9e5vrkGn9Vg1l9f2SAwbDxbuMY3byzFAOqVtZ6IGJNdhznQ2h/?=
 =?us-ascii?Q?tMWbDCqxmefIspT3HMcj5YdGHgwMq9xMi+pwGihrig90NNzbnWiuHpXRs/1u?=
 =?us-ascii?Q?9H/9jkCAUPVffEZ2v19QlKjuyur/akE2O0UEg+y6HCPsK3JBpPjVce5IdT06?=
 =?us-ascii?Q?GofmfxzMV1Y7OFXCrad83mwnH2WJYZovWd3IpHF/iJrwndP6lprGNCtYMGBs?=
 =?us-ascii?Q?rF5TOBzcUD6xf7T+EmBMuaybL6K25SvD7UcSphFX2Xe/xKBomIL0GZHS/J7N?=
 =?us-ascii?Q?gfz5twfagoA2VOaEhTetSCBQpEBsNetYtGGtbvBjdhMPSyKurrgCQOXLAyDP?=
 =?us-ascii?Q?supRMyHuwxiyftpEsQWkRKTjZbuqQiYwoLNgtA7H3LJxIPwzU8fBP8WTg9Rz?=
 =?us-ascii?Q?l6M22m6xZg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7134252e-b5f1-42ee-4502-08de8b3b98e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:28:41.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqHwtQmx60wD2zDbhiGd7d2SXNW4NrEuBzAfDX4EXMALgnheZYtO7JE4MPEmp88TW6NP9sEdiy2iwVsrSHsAGg==
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
	TAGGED_FROM(0.00)[bounces-272063-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[run_kselftest.sh:url,ktap_helpers.sh:url]
X-Rspamd-Queue-Id: 546ED335FAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set aims to add the necessary support so that bash written
selftests are also able to easily run with a remote traffic generator
system, either be it in another netns or one accessible through ssh.

This patch set is a result of the discussion from v1:
https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
Even though the python infrastructure is already established, some
things are easier in bash and it would be a shame to leave behind the
bash tests that we already have.

This support is based on the requirements described in the
tools/testing/selftests/drivers/net/README.rst file.

Mainly, the drivers/net selftests should be able to run on a interface
specified through the NETIF env variable. On top of that, variables such
as REMOTE_TYPE and REMOTE_ARGS define how the remote traffic generator
can be accessed. Patch 3/10 parses these env variables and constructs the
NETIFS array that bash tests are accustomed to. This is with the
intention of enabling already written tests to incur minimal changes.

The second patch also defines the TARGETS array which will hold the
necessary information about the target on which a specific interface
is located.

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

The values held in the TARGETS array will be used by the new 'run_on'
helper added in patch 2/10 to know how to run a specific command, on the
local system, on another netns or by using ssh. Patch 4/10 updates some
helpers to use run_on so that, for example, lib.sh is able to ensure
stable MAC addresses even with the remote interface located in another
netns.

The next 5 patches, 5/10-9/10 update the ethtool_rmon.sh script so that it
can work with the kselftest infrastructure and the new
NETIF/REMOTE_TYPE etc way of working. Beside updating each ip link or
ethtool command to use the run_on helper, the patches also remove any
testing done on the remote interface.

The last patch adds a new test which checks the standard counters -
eth-ctrl, eth-mac and pause - and uses the new infrastructure put in
place by the first patches.

With this patch set, both tests can be run using a net.config file and
run_kselftest.sh as shown below.

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
 # TAP version 13
 # 1..14
 # ok 1 ethtool_rmon.rx-pkts64to64
 # ok 2 ethtool_rmon.rx-pkts65to127
 # ok 3 ethtool_rmon.rx-pkts128to255
 # ok 4 ethtool_rmon.rx-pkts256to511
 # ok 5 ethtool_rmon.rx-pkts512to1023
 # ok 6 ethtool_rmon.rx-pkts1024to1518
 # ok 7 ethtool_rmon.rx-pkts1519to10240
 # ok 8 ethtool_rmon.tx-pkts64to64
 # ok 9 ethtool_rmon.tx-pkts65to127
 # ok 10 ethtool_rmon.tx-pkts128to255
 # ok 11 ethtool_rmon.tx-pkts256to511
 # ok 12 ethtool_rmon.tx-pkts512to1023
 # ok 13 ethtool_rmon.tx-pkts1024to1518
 # ok 14 ethtool_rmon.tx-pkts1519to10240
 # # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/net/hw: ethtool_rmon.sh

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_std_stats.sh
 # TAP version 13
 # 1..26
 # ok 1 ethtool_std_stats.eth-ctrl-MACControlFramesTransmitted
 # ok 2 ethtool_std_stats.eth-ctrl-MACControlFramesReceived
 # ok 3 ethtool_std_stats.eth-mac-FrameCheckSequenceErrors
 # ok 4 ethtool_std_stats.eth-mac-AlignmentErrors
 # ok 5 ethtool_std_stats.eth-mac-FramesLostDueToIntMACXmitError
 # ok 6 ethtool_std_stats.eth-mac-CarrierSenseErrors # SKIP
 # ok 7 ethtool_std_stats.eth-mac-FramesLostDueToIntMACRcvError
 # ok 8 ethtool_std_stats.eth-mac-InRangeLengthErrors # SKIP
 # ok 9 ethtool_std_stats.eth-mac-OutOfRangeLengthField # SKIP
 # ok 10 ethtool_std_stats.eth-mac-FrameTooLongErrors # SKIP
 # ok 11 ethtool_std_stats.eth-mac-FramesAbortedDueToXSColls # SKIP
 # ok 12 ethtool_std_stats.eth-mac-SingleCollisionFrames # SKIP
 # ok 13 ethtool_std_stats.eth-mac-MultipleCollisionFrames # SKIP
 # ok 14 ethtool_std_stats.eth-mac-FramesWithDeferredXmissions # SKIP
 # ok 15 ethtool_std_stats.eth-mac-LateCollisions # SKIP
 # ok 16 ethtool_std_stats.eth-mac-FramesWithExcessiveDeferral # SKIP
 # ok 17 ethtool_std_stats.eth-mac-BroadcastFramesXmittedOK
 # ok 18 ethtool_std_stats.eth-mac-OctetsTransmittedOK
 # ok 19 ethtool_std_stats.eth-mac-BroadcastFramesReceivedOK
 # ok 20 ethtool_std_stats.eth-mac-OctetsReceivedOK
 # ok 21 ethtool_std_stats.eth-mac-FramesTransmittedOK
 # ok 22 ethtool_std_stats.eth-mac-MulticastFramesXmittedOK
 # ok 23 ethtool_std_stats.eth-mac-FramesReceivedOK
 # ok 24 ethtool_std_stats.eth-mac-MulticastFramesReceivedOK
 # ok 25 ethtool_std_stats.pause-tx_pause_frames
 # ok 26 ethtool_std_stats.pause-rx_pause_frames
 # # 10 skipped test(s) detected.  Consider enabling relevant config options to improve coverage.
 # # Totals: pass:16 fail:0 xfail:0 xpass:0 skip:10 error:0
 ok 1 selftests: drivers/net/hw: ethtool_std_stats.sh

Changes in v4:
- 1/10: wrap the lines to max 80 chars
- 1/10: replace the if-else with a simple if and return in order to be
  easier to maintain the 80 chars limit.
- 2/10: reworked the helpers so that no global variable is used and
  information is passed only through parameters
- 3/10: reword the entry in README.rst to mention that the different
  interface names is only a bash restriction and the python
  infrastructure does not have the same problem.
- 3/10: only declare the TARGETS array when necessary
- 3/10: add a new flags -  DRIVER_TEST_CONFORMANT - that needs to be set
  by the test
- 3/10: rework the check_env() function so that its logic is simpler
- 3/10: source drivers/net/net.config only if DRIVER_TEST_CONFORMANT ==
  yes
- 3/10: check that NETIF and the remote netif have different names and
  abort test is not
- 4/10: split some lines to 80 chars
- 5/10: split one line to 80 chars
- 8/10: patch is added in this version so that ethtool_rmon.sh is
  converted to KTAP output
- 9/10: set DRIVER_TEST_CONFORMANT to yes
- 9/10: update the commit message to reflect the current output
- 9/10: split some more lines to 80 chars
- 10/10: move to a the KTAP format output by using ktap_helpers.sh
- 10/10: update commit message to reflect the current output
- 10/10: use DRIVER_TEST_CONFORMANT

Changes in v3:
- Change the TARGET variable into CUR_TARGET
- Always fallback on running a command locally when either TARGETS is
  not declared or there is no entry for a specific interface
- Swap patches 2 & 3 between them so that the run_cmd used in now patch
  #2 is defined in patch #2
- Add some more double quoting

Changes in v2:
- 1/9: Convert jq to the --arg usage form
- Patches 2/9-8/9 are new in this version
- 9/9: Use the new run_on helper
- 9/9: No longer checking that each counter has a 1% tolerance against the
  target. The only upper limit is UINT32_MAX.
- 9/9: Check that both the error counters and the collision related ones are
  zero since this is the most probable scenario (we don't expect errors
  with the traffic that we are sending).
- 9/9: Removed any checks performed on the remot interface counters since
  that is being used only as a traffic generator.

Ioana Ciornei (10):
  selftests: forwarding: extend ethtool_std_stats_get with pause
    statistics
  selftests: net: add helpers for running a command on other targets
  selftests: net: extend lib.sh to parse drivers/net/net.config
  selftests: net: update some helpers to use run_on
  selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
  selftests: drivers: hw: test rmon counters only on first interface
  selftests: drivers: hw: replace counter upper limit with UINT32_MAX in
    rmon test
  selftests: drivers: hw: move to KTAP output
  selftests: drivers: hw: update ethtool_rmon to work with a single
    local interface
  selftests: drivers: hw: add test for the ethtool standard counters

 .../testing/selftests/drivers/net/README.rst  |   4 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/ethtool_rmon.sh  |  82 ++++---
 .../drivers/net/hw/ethtool_std_stats.sh       | 206 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 131 +++++++++--
 tools/testing/selftests/net/lib.sh            |  41 +++-
 6 files changed, 414 insertions(+), 51 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

-- 
2.25.1


