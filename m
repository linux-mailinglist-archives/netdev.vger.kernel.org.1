Return-Path: <netdev+bounces-269521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNSmEREgvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:10:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 945A02CE782
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8310832C40D5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8883E3C71;
	Thu, 19 Mar 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gz31hwCC"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064C3DBD6B;
	Thu, 19 Mar 2026 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936262; cv=fail; b=hKj+YPd5nMLMikZv1R0b9fWM6ualLX6Bp6FN82lNvUGTPUi/GdPuHfPIcrNPgUM0TKMogQhzCiNt/b/XRK8i6TXYPWOs+T0e3d0/3Yqei1iGDQIu2UiVQnh19wxVUI86nOk1qrlfP5Djau4XLaZcSf7Ht+ef5VqYlARDqxELjRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936262; c=relaxed/simple;
	bh=WhmhmCtHt8MdycW9yMxwmhDoa5HFAxlFfLwqO06HuYI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZXISBqbqkkYM+67IKEdAJ2QMZv3M4ELxSmYIRvllIxvhOkTV+TmGucCRay/Z/TrodxlCNQ/4UjaeFMTfDt9HmkutzCGxtDG0iocoZ2QxvD6lQkgAkmyKRzm69XV7jIL0zl9jpwoKTF6AhdGSvwzjRyrNmC+xrHWwK/xzhrHDgoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gz31hwCC; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZhYWMIVZBLCSZNnLElYU6HXuvqBjFCG5OfqgyHLj77Kc84CP0XGZThVoAL3KGIhAvGPW88tNlnRPFIZy1MIe0mnN1ft0RYhOZJ3JyxMqtIfgrLoOtfE3e9DJ+dDFIEpb/ztdjegiZELLFYNBu4sKH4Rz7kmICTI/m9RAj59P5sIoBY4KQ59jVQfIULBUXqN0uwxz1cnVJ6TPf5xGjXHzKIoCIhL34AXrs/BoDktsxmPLSM22btbEhSz0tWutr7CTShGClYDQgZ+bvvCQiRFLnkv378ymz6Dki0NgetSuXiRoS16e0xMogVa3aBqGeKhl/uis09ZXiHNGJr4OUzbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI+TH4Ggitsc0ZelXTv2W+1dOFxo3esByVaLY8d5hkE=;
 b=ETqFLvVvBmC6mML8mUUeKAKClU6V7DvDGjTiBPt+sSyweyf6eqr7orxOPfOuR5o/6WPa/1qzaC/TbmbYJmtU/Ilc8Tk2mOyFF+Qwdh1kvaQWbNqGazHZhBWTYNYPP5c8CvMsKnZib5R71zfWc5r+Oq/wP25/LOidsuPBzp5PPe91FLV3k51xGWwsJppoPFfmSnaI3aXfUPl5VE1gKrPmoo3xtyPYUGMRJmmPHjAdel4Ixiod/swniWzfWLvfA8gHp0iLbQeFI37ZtjgxiX+Eplb1Oxm12o2aGpT4A8G3V6ypEK4wTBCvHj/faw+LeCkzSBj+wSB1TENQbI8WKnC5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI+TH4Ggitsc0ZelXTv2W+1dOFxo3esByVaLY8d5hkE=;
 b=gz31hwCCM3e2Mi6E5fnqwon4pf1vS7mQCvaP8d+S5kuQ8E2iB29friBwYuz/5tkUFySwWopX4UInt2UASLWbZDrtlCQn4yobclo4Eb8qtapFcGGlwvzjNZi+L0odTpdVTOwhD7TiwC3n7/n9fxgRyDtcE0Ki2BUwUUFyfphnkIg65fK5CinryWvRbl6h9BeM1O3PvaAw/hjpC4TpovggChl94M/2L8CO3HImHnZuAARJCAt6ijH2YqaxjbexDQsj6F1hQNvUxL4vG1Sw6LbDjc9reY8m2FimiHs7nGGbwv4GXb9+DFVLzTvdPvWbLOXzz5he/LfILKw8AO66BuOt9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB7505.eurprd04.prod.outlook.com (2603:10a6:20b:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:12 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:16 +0000
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
Subject: [PATCH net-next v3 0/9] selftests: drivers: bash support for remote traffic generators
Date: Thu, 19 Mar 2026 18:04:01 +0200
Message-Id: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c2ea91-41a2-4fd7-741d-08de85d12bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	t+RCwtAqjMaEvR6+9VPeDsefW8Dhe9d4sjGj6+bTPuV/W/DtoX1GUkRpvlB6S6TuwoXIf5Zh91vPkqEt+fK6Lj/tj8ZdnpgKyONKrOJLAy84mo2AatkqqCQmnnMa4xS4g+FlGscj4QrnFH9TJQVrKv2euC3MvKKS8yFyp/Mdiy9xAvG5120cCT2JNa3Ci+UppJ6qA6fPfS0aEvHbgl0e4NXM+7AnIWS48LxsoL5er4DohZPQ4rNLkB03ph1XTOJeypqwBMIokrz0ZwINLWqrWaGfcLm1nqh0FmUIGlYBRgV/DET9c9N/PP+FzSKEAMtkLadTtTzpysnoOg7XXxXDU/+QUKgBDS1ejM/eMuxwB7yr9GZbeL+Q75T/XiFnUzi4Vd3OH71fzuCXwZDP7CtXBFfg1BxI95ZGljmRkZmYMyJcfWvQd72tohsllXxZZ8Xzs6FK/jwwkeYatzjbzj0wYn12xGw3JfiY32VV4FnxEbiE7YUvqHZS8DNiLrk6ldnmWdgOg8ZbtNmEkJG7M1Nm2LsqzXdpPZXxoT9VwpvDs7UNxJq6mYAsIZsDwx6cqovLeLwN0wZoMtqZIrlXAUpO5JVuZ0zu12YuSppeZcBet8EwylmW7dIP2z7PKSWtiAEZbyjNREnfS5hhzM45kat8brCL6wYx1xSs35rAqj2Ky1DdBaz+6+1Tvgmi1ZzjAURZfGftFhMszFBctQUCqIHtimW7jOzwTExlKNUck4IWZ2S4yKOFHRGYAof0WRyBaX3B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmFKbyzfZuC/8JSCyJ+FuAsXL0QS7lr/RiWSRImNL/RJVHoRj4eAIcpn1yvg?=
 =?us-ascii?Q?6TT/LgZh1d7sraGXiYCM9P8vDeDJzGQdRqUHrCbcG+r9T/Sh/XWabuR5++ZM?=
 =?us-ascii?Q?Gg5uaYEd+zKSkm0TIFSGEogDHz18uhEoV5kSHFQh3BCLvl/Ro+ZmA8P7oY6L?=
 =?us-ascii?Q?2fG9xcDp0sWZZK4xv/PZDMrslKqthLgwFUlkLRLzjo86EFpX+it5TxFhO8fa?=
 =?us-ascii?Q?yDJa01OwTcIOTLmQCyDVUxGJO2tbXRFWz0eXgp30VHXiEnq8dgepcYwgGqu/?=
 =?us-ascii?Q?lPJEreSJo9ACzt5xY4NRSevnrkwBC/45B6SVBWCoULpnXJB+75sr16iPj2ZZ?=
 =?us-ascii?Q?WCdahFKS6NRuHJI3Jshpea+hnV8ZabKf8q6knbmJDmPbkNVeki982U69CpM/?=
 =?us-ascii?Q?OZgCrv+pRGR3lY0zoLP+ATWnlcgL7QZY3xiWybyLwvywnsKvCUeupmEp8mLb?=
 =?us-ascii?Q?2GJ8N5liH5J7kvzRDnL0/j8W8L/opMyIzN6TUSGY93TQMm9grZBNLEjZdrKl?=
 =?us-ascii?Q?S1eOWYheq4UlXVbBZ+PalZMMf9K/jkA9KIDf6+Zh79m8+MCuu17USpHZJdpQ?=
 =?us-ascii?Q?hZ/4hGgaF/TlDb4Ce9o1EmUm5p/cl7PIn2DAyA607NEOT+rO12EHpUJEmJzm?=
 =?us-ascii?Q?KWy0sASi2NlDVmUq+vZDOa5xD4F30D4cdFnbJFt/JoSr5vGPP+r9GeVCRvO2?=
 =?us-ascii?Q?zHIMrgWoYq6qL2UWbEPAXIHj/vNjULJ1YHIT91QbJaftwSALI/oW+lNLq+zy?=
 =?us-ascii?Q?Crz3Z6D0zJposnZKzuiPUdhLIy19Bv2FRIuiR3CMMjsHGHBJHQYPS153jZl1?=
 =?us-ascii?Q?XbyJnA6zFcTVF7yjZDQS3k5rQOXmWCxTOHU3nn3mHZY44RNpZK2yhomGKpPA?=
 =?us-ascii?Q?bIcfmbcFvI8JgZMKawvKe0mn7mvQjC0nq2w42Xjt0PnFEupsaMTE2RSLN7uF?=
 =?us-ascii?Q?QTCpePYoG4iApZvS/WR+UsveyM0xvmd6H1ui4v5Yd/XQTC29RdV6lbnFLFZT?=
 =?us-ascii?Q?P6seEVyTisx5jJS6balVBI4/3EZOjiohpfbbzeWv/zjWn0FIQU9XEn17i3bw?=
 =?us-ascii?Q?mlQzOvlSQFFDmY7JY06IHQB3AQHW6Bg9Z0IDufnAD74oKTZ02zj8FraRSyW3?=
 =?us-ascii?Q?Ke1yazvfjSXw7ttgl9kp/TvPtvXlYiFXK7OZqlZxZO1qvetERNgeKHD73Ylm?=
 =?us-ascii?Q?lyFihEVDrJbCvAHngHF1Lp0wmMX0Vcf+IPJugGWSqpqp9Mlzv6s9w7yz+Z4n?=
 =?us-ascii?Q?tTnO3PJiehSl2AJJQfFbEpVLROgBSSZKYauoeP3pHFtcWPEKG4J6KHZWtHlL?=
 =?us-ascii?Q?L4pXygZFCuxWsJle7Ph92SEF0/Q0JiveiFDpQQJiwOnsb/X8NBU36IQ34g6l?=
 =?us-ascii?Q?A9wcm1KjyUNIjnNMHolfu1zqets/7scs7Yc9n0Mcmhs4wEoP2BH7nq6sl1bj?=
 =?us-ascii?Q?IIXhCBVHLzkV750SkteSKmdD/AJneotYAYMO8PKeN1i+tjPm7/qXA4VGB/S/?=
 =?us-ascii?Q?gPAHDyOqal3IeWl4k/aRuaC0k6nCLZRTflkl6NprEtk3vO3PjaqkbC59Xs/j?=
 =?us-ascii?Q?E9foPqZ7R/WaH+6aiTvC0djXzSfiU8h6Q27YRDyLhuNHbwzw/ocNiN9ejggP?=
 =?us-ascii?Q?Q251wm/qnM937nVLVRwXYg1fwdj5VbAQWBHeo9bK88bsI21um6gC3fgWDFKE?=
 =?us-ascii?Q?9M6GjjuABfb0i7rsSg8VKXOQP08dfJQP6kxQqYV/CMLQcmjIMqS7KcCGK5F7?=
 =?us-ascii?Q?YSidP84q6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c2ea91-41a2-4fd7-741d-08de85d12bfd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:16.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsu23TRUmCTmpwF5coe589saog1LtJZywaMlrmghNsizNX1oT+3bocZLM8fg8/IENGfwa3jHdibq89eqMws0TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7505
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
	TAGGED_FROM(0.00)[bounces-269521-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ethtool_std_stats.sh:url,lib.sh:url,run_kselftest.sh:url]
X-Rspamd-Queue-Id: 945A02CE782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set aims to add the necessary support so that bash written
selftests are also able to easily run with a remote traffic generator
system, either be it in another netns or one accessible through ssh.

This patch set is a result of the discussion from v1:
https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
Even though the python infrastructure is already established, some
things are easier in bash and it would be a shame to leave behind the
bash tests that we already have. Version 1 of this patch set also had
patches exporting standard statistics in the dpaa2 drivers. Those
patches will be submitted separately so that they do not depend on this
set.

This support is based on the requirements described in the
tools/testing/selftests/drivers/net/README.rst file.

Mainly, the drivers/net selftests should be able to run on a interface
specified through the NETIF env variable. On top of that, variables such
as REMOTE_TYPE and REMOTE_ARGS define how the remote traffic generator
can be accessed. Patch 2/9 parses these env variables and constructs the
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
helper added in patch 3/9 to know how to run a specific command, on the
local system, on another netns or by using ssh. Patch 4/9 updates some
helpers to use run_on so that, for example, lib.sh is able to ensure
stable MAC addresses even with the remote interface located in another
netns.

The next 4 patches, 4/9-8/9 update the ethtool_rmon.sh script so that it
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

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_std_stats.sh
 # TEST: eth-ctrl-MACControlFramesTransmitted on endpmac17             [ OK ]
 # TEST: eth-ctrl-MACControlFramesReceived on endpmac17                [ OK ]
 # TEST: eth-mac-FrameCheckSequenceErrors on endpmac17                 [ OK ]
 # TEST: eth-mac-AlignmentErrors on endpmac17                          [ OK ]
 # TEST: eth-mac-FramesLostDueToIntMACXmitError on endpmac17           [ OK ]
 # TEST: eth-mac-CarrierSenseErrors on endpmac17 (not supported)       [SKIP]
 # TEST: eth-mac-FramesLostDueToIntMACRcvError on endpmac17            [ OK ]
 # TEST: eth-mac-InRangeLengthErrors on endpmac17 (not supported)      [SKIP]
 # TEST: eth-mac-OutOfRangeLengthField on endpmac17 (not supported)    [SKIP]
 # TEST: eth-mac-FrameTooLongErrors on endpmac17 (not supported)       [SKIP]
 # TEST: eth-mac-FramesAbortedDueToXSColls on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-SingleCollisionFrames on endpmac17 (not supported)    [SKIP]
 # TEST: eth-mac-MultipleCollisionFrames on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-FramesWithDeferredXmissions on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-LateCollisions on endpmac17 (not supported)           [SKIP]
 # TEST: eth-mac-FramesWithExcessiveDeferral on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-BroadcastFramesXmittedOK on endpmac17                 [ OK ]
 # TEST: eth-mac-OctetsTransmittedOK on endpmac17                      [ OK ]
 # TEST: eth-mac-BroadcastFramesReceivedOK on endpmac17                [ OK ]
 # TEST: eth-mac-OctetsReceivedOK on endpmac17                         [ OK ]
 # TEST: eth-mac-FramesTransmittedOK on endpmac17                      [ OK ]
 # TEST: eth-mac-MulticastFramesXmittedOK on endpmac17                 [ OK ]
 # TEST: eth-mac-FramesReceivedOK on endpmac17                         [ OK ]
 # TEST: eth-mac-MulticastFramesReceivedOK on endpmac17                [ OK ]
 # TEST: pause-tx_pause_frames on endpmac17                            [ OK ]
 # TEST: pause-rx_pause_frames on endpmac17                            [ OK ]
 ok 1 selftests: drivers/net/hw: ethtool_std_stats.sh # SKIP

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

Ioana Ciornei (9):
  selftests: forwarding: extend ethtool_std_stats_get with pause
    statistics
  selftests: net: add helpers for running a command on other targets
  selftests: net: extend lib.sh to parse drivers/net/net.config
  selftests: net: update some helpers to use run_on
  selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
  selftests: drivers: hw: test rmon counters only on first interface
  selftests: drivers: hw: replace counter upper limit with UINT32_MAX in
    rmon test
  selftests: drivers: hw: update ethtool_rmon to work with a single
    local interface
  selftests: drivers: hw: add test for the ethtool standard counters

 .../testing/selftests/drivers/net/README.rst  |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/ethtool_rmon.sh  |  55 +++---
 .../drivers/net/hw/ethtool_std_stats.sh       | 187 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 151 ++++++++++++--
 tools/testing/selftests/net/lib.sh            |  41 +++-
 6 files changed, 394 insertions(+), 44 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

-- 
2.25.1


