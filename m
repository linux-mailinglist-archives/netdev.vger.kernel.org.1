Return-Path: <netdev+bounces-273249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOfpBOyZymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:42:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 701E635E13B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBF8830377A1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0EC3644C6;
	Mon, 30 Mar 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZbp1mcR"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3D363C43;
	Mon, 30 Mar 2026 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884644; cv=fail; b=M5IzYksbQp3IMK85GERZmiupaSjAf/prM253wc8nw3shd9COLblg0UcijddSmSr4+EbRt2YdgFqq2fbymW/Hl/oXLcPdDhpz7QfIYbFfKQbYhEDKDYzMTp6AYsJPIxvcrp5GLg32jompoUGJRczed0WeYjwsCwfNldnf43kn5u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884644; c=relaxed/simple;
	bh=VGQbCJ57/hYuXiwU9RCA9Jpdfm2HoQtQwOpC2g3KWSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pk5CsLAZtS4uvyV9eZMBlqdtGOrhX2Zs2anTqCPTihJF+O1u9ifyxlNNLmOhlywcaIro5a1K81NXzlUgfu6DjFSqSDUh0aWthIwrZRlgIkGnTKbnfoVy1i+yMZZKIPHW+X9Yk1nYlJlhT6c+X3CKeQrBEulD89jSVM1zdT+ax3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZbp1mcR; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emLLPieG+DZ6lGubBHLaIBc+CfHlOoxdkAV9ef5ed5k98lxedpzSlX7ysDlQX5RFOU6l6u4lGBohUuH94Iu4pMi35oVj8F0D02d0tb9XaM2oBojiEkZtj9TzrG/7HwUJIDN8X/QwkYej3JdKOHy0rH5AJjM3NWPKMsw9z4XEF+VqJT89eO73h8aGqz15kQfLna0hHTuvoDzY3GudMUxly1KEWKLeuus0/J69lTEupudhJeusVzah8ftJNyNDgrIw32ve0cXuSPnecAhA3o8yq35IPrvHKfnKWhUxvwhWnNGTnSg/BnVPS6rjbkYWJ4MxYKrGn0PmgVjXTohaVq0L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx6rR1Gs31zVWfRdPNW430J7cJVx3au2LCqmo/M1fIw=;
 b=CThIyeZqjM65cM0/dhFEtxBpUeffb8cz8NejBHMrTu6ehQID76rabH2or00BKw3qPG8h7apcoh+Qe51S5l6hugjNasq6YFjBWI3FRATtQij6f1DliEwz3+ZJcDRsnsVg6OxOmWI0/mbkikYGUtU0XpAlgAHtb1R+K8YPwYQzCgo5Tk0YmLEpb0wxLVdWFIHA3qoEi4BK4uJeTWhEGuKWQZ4Ko3fqNsA9FpnakoSBTdRwjNGbZlylPGAF8O7fW5lHJ4ywFpX8nYVHrQfOjZJQeRN9wCKR6Y8I9mYctftTePri1B6KlaieK5iyWfwXeBkMRYwqkYllbGMDarVN9T0lJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx6rR1Gs31zVWfRdPNW430J7cJVx3au2LCqmo/M1fIw=;
 b=mZbp1mcRsJdpoDtCoLDcrbHnkrglkwz6GzRFq7dZUOdwpN5GYqIc111FeRpJbhiccKhCX+92rSOk4ynMtVRKA0JZoBioYLILYjWTGJ7F5bXe03Xj3YSq98haEMK/jvd+/tEzPQOG6f4SmUa4gcICjncG9B/AfwVqM3e1bpTx6jdEp1RCqiJky32a3h//fFnUeNLOVhwfTEbLsomBk+qDh8l9ZVCaCBnXd1ts9FC71xpWW58ohu7nCNxwF6+YSzA3I9NB4FBLviC17qgtH77YDg/bs77QWXR56qL0wze3dBWpyE8as9UxGNjqjrFNlOjzdAY/lux6wbXXhhIfvuvlzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:38 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:38 +0000
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
Subject: [PATCH net-next v5 2/9] selftests: net: extend lib.sh to parse drivers/net/net.config
Date: Mon, 30 Mar 2026 18:29:26 +0300
Message-Id: <20260330152933.2195885-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0144.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::11) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b56391-be83-477e-72da-08de8e714bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hSV/9b6zRDEwDHB/i+/xyTcOs5/5ceWuysYk2MmnaDuufYBbD/ymS0obanv+rEhDaYjCdTT/UALvfSL6xEyPRRzzaT2mC7qa8z/SQ9Q2b4owo4SwJhxOQFlglTMP2n9B61I/QCeVIPj35naNb9iZzf+/NqelIbNlnaU+fLiUTRvcRp6EuxTF3lOCAsirPto1GGf6bA5djG4Yty/g22fLb4ONX/etv8Gb13/zCTyCTXeUKdMfuMR73R8oB74uChW2IG9g32oSrG1xUZwUeWnZz+KJ6l5FN2wqFkUe9LFJIsUkfW8QqM8KJ7rvFQwDGsLU5sLYDGZ4vnsY09cplIp3/zh/Ms0151znjHCtSaEFPdKb2DquQBUNrzctIM0kxWzDBWFpOnZ4vTlZNelL7RRhHzXoc6KppIdf5p11l2K74tgWO+GOQ1X6BW/ngZukFCmY7aplB8N6nlwal2W1AaKoYqMyJWDObCza8NIzkZnzRNewzSGk+mTyWRM7z0UxSCOmoNLR8af8Uj1foiwqnS7az4lcLh/4ZA81JpSVN0XEvYWI5zWZfI9cNB1ibHt9nxikSv9lToGz4evAe1e5+5LS3A4ap2h86Y5V0daZiTUP81lJsKsbRFrtLMzTo20sTtFeUntbqz3Owa1m75srpRFNA4sfzj50WrS1t4VSB6FTkJ1Qn30E0yavwJrkePtIRD1Rty5sR1BnW/ZIWpLgycnum2kfjMZoi83qKEd+NQhUHts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0dmJz1pHJPIzjkhKJN342/lXfM9WAxPOczDZUjDJdzODSH+QG4FHTUhIaT/?=
 =?us-ascii?Q?4y91y/6Hn3rFEEGNRPk5+JmrzopYyCr2l0lnse5YRY5XMC76kmo9UXeAaQpm?=
 =?us-ascii?Q?NzrpQjondSMiooZCjL+RxSBv132wujwWlK9NqE5TcrHIv1559ZtXCj5vwHy/?=
 =?us-ascii?Q?A81sdv2MrESY8vPn34LhlppF4U4nyFWgOBbojhhWRgfcuQ9xLXlEzRWVS8g+?=
 =?us-ascii?Q?wT+ecTlGw4VRuulKrOA+04DSOMvXeJINVcxx8bwRl7yeoiuG43QGXZYqJcyz?=
 =?us-ascii?Q?lSjdEcfutONEWvdrOLts0RW2CTOBCa/YPVQ5//pe3Vf32EEviWStPb5WfTkw?=
 =?us-ascii?Q?J+RzBJIYBNYuR6nNHuWV01zhyWkNuJHhODkSDiMAUJ9x5CpkDYcE5kH/7nJv?=
 =?us-ascii?Q?0WDL/Mc3Pfgov3stFGKOx15Uadf7ES4kfuleYPEDfxW43dFf2VxluxoAC5wj?=
 =?us-ascii?Q?ylCoTmOBGnvyHulChdFGCis8zqSNEuiVXWBTQco0JLc6ZxkqwnlwPRT0P6MW?=
 =?us-ascii?Q?9ABI0BMOYN5q0rF8iVoAalNN/Fl6nHV/MeeW8XPoI6ySN8sgdvVwAazNu517?=
 =?us-ascii?Q?lByh46tDiNxtDnIaiSkkB1u/KhR2YpHKcphaH4mu/J5HP5KlcWZkU4DXWv0j?=
 =?us-ascii?Q?Z0FsjMaSr338xRrpG/lpSjbY2DiHnwCE/SlR7s72Ax83m+CnhkCHh7G644H9?=
 =?us-ascii?Q?RjLkrIQLaDFYp6W0rL75KrwtvBTferUfJIm2Dcla28jEJb4XNACjPJsgnRb6?=
 =?us-ascii?Q?LRVHHzwZBpk4g3YK+fW8kZFZOTzpr9N0ogIapv6ZW10yDsQEKhRxIbfco+Ul?=
 =?us-ascii?Q?lMR2MQ41/GleIEObtVA4y0TwSjBSDXREAl9Ng6Ql+HfZIz0r4ORkguXNcr3U?=
 =?us-ascii?Q?EJmvc6KSZ2Qr2N6XRg7yvI1Ukrp+SPhyRU23ICs7+HRmlJZtRXtTgEUXXbZo?=
 =?us-ascii?Q?v5OXpR2RwgnVML0tCv4VKzlclaNUYrMIt8L3dPdfwrjIiCcNgraZ5ripSbII?=
 =?us-ascii?Q?Hea9KFuZ1+eA0whFIglUzwd+x4vCogI7h8ZH6VhDF+aTw/Wp/Cs/XAGEojp5?=
 =?us-ascii?Q?2ou9ydkdAudg2lbzbGhnqEChCGn9jroYZnf5c8nR5kfDAKh11XjcaRp7mfxt?=
 =?us-ascii?Q?id93FGUXX0dpEiSmGZKVYgQVpTIfhgNkExc+HZhPV96RH1zVcZ1HnPZ0gpGf?=
 =?us-ascii?Q?R0jDNuFXet3FMjv0kk4YGAk3ZmkjqTvKp8SkoNeuk6IxPrphr0x3KbBcEZl3?=
 =?us-ascii?Q?pRmuPZWYsm7YCAtr17c1wayWFx1VSjcKTr4HIxO0gSbKw3Ew2AK4zOiiYs+8?=
 =?us-ascii?Q?P4Z9/H1mAZpnl3gguoOX3kCWqnqxLoPmpRBhoemmATn5tNNn8HcANA2ggcrd?=
 =?us-ascii?Q?Aw2MJZDFDuSx3Lhbdz91gBQNz0ZEn7BholDg+Jo4Og/5nG6rLf6MZgoHWaOv?=
 =?us-ascii?Q?nbwvYt3Dc8rQPXPKx1ij4GNZ5xbtK1ZIi/OonuWcuaKQL5CiLCuh839l0ktW?=
 =?us-ascii?Q?ZxFYR+5wmwmuq0zDrEclseNXUpGXx3G/PMNW47vDqNfNixz7yJtXM9Jt287f?=
 =?us-ascii?Q?lDGe+YTdAystvLlq4cQWgZXrtn8pB8tTRDHBjb6jVJ1KfGFqurRbQg88LRhE?=
 =?us-ascii?Q?j0zt4tqC3YbYCEgRE8FJIoZQnwxvs26eb3PNSk1iggid4F69RD2BQij4mLSF?=
 =?us-ascii?Q?btrwL+LPV9utXw93om7NU9t84mjsgPzKGRdiiGgP4eYiZp1z+yKiLBBteInd?=
 =?us-ascii?Q?L685oUopXQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b56391-be83-477e-72da-08de8e714bc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:38.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFMUkUwi9Z0TGGrX+aStLUnUVE/B3UHku7FKuiO8D22MNhsQZRe59OZakey8ej1GEQZ7A6cEWRfzlpx6pgdlyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975
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
	TAGGED_FROM(0.00)[bounces-273249-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[host:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,lib.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 701E635E13B
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
interface cannot have the same name as the local one. Keep the old way
of populating the NETIFS variable based on the command line arguments.
This will be invoked in case DRIVER_TEST_CONFORMANT = "no".

Also add a couple of helpers which can be used by tests which need to
run a specific bash command on a different target than the local system,
be it either another netns or a remote system accessible through ssh.
The __run_on() function is passed through $1 the target on which the
command should be executed while run_on() is passed the name of the
interface that is then used to retrieve the target from the TARGETS
array.

Also add a stub run_on() function in net/lib.sh so that users of the
net/lib.sh are going through the stub only since neither NETIFS nor
TARGETS are valid in that circumstance.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v5:
- move 'shellcheck disable' at start of the script
- move 'declare -A TARGETS' before the if statement
- move the DRIVER_TEST_CONFORMANT declaration before the if statement
- move the __run_on() and run_on() helpers in net/forwarding/lib.sh
- add a stub run_on() in net/lib.sh
- check for DRIVER_TEST_CONFORMANT = yes in run_on()
- squash patches 2 and 3 since with the change above each patch depends
  on the other one. There is no point keeping them separate.
Changes in v4:
- reworked the helpers so that no global variable is used and
  information is passed only through parameters
- reword the entry in README.rst to mention that the different interface
  names is only a bash restriction and the python infrastructure does
  not have the same problem.
- only declare the TARGETS array at the point where it's necessary,
  instead of it being an user API.
- add a new flags - DRIVER_TEST_CONFORMANT - that needs to be set by the
  test
- rework the check_env() function so that its logic is simpler
- source drivers/net/net.config only if DRIVER_TEST_CONFORMANT == yes
- check that NETIF and the remote netif have different names and abort
  test is not
Changes in v3:
- s/TARGET/CUR_TARGET
- always fallback on running a command locally when either TARGETS is
  not declared or there is no entry for a specific interface
Changes in v2:
- patch is new

 .../testing/selftests/drivers/net/README.rst  |   4 +
 tools/testing/selftests/net/forwarding/lib.sh | 146 ++++++++++++++++--
 tools/testing/selftests/net/lib.sh            |   5 +
 3 files changed, 146 insertions(+), 9 deletions(-)

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
index 3009ce00c5dc..83249aafa669 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1,5 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
+#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
 
 ##############################################################################
 # Topology description. p1 looped back to p2, p3 to p4 and so on.
@@ -340,17 +341,144 @@ fi
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
+__run_on()
+{
+	local target=$1; shift
+	local type args
+
+	IFS=':' read -r type args <<< "$target"
+
+	case "$type" in
+	netns)
+		# Execute command in network namespace
+		# args contains the namespace name
+		ip netns exec "$args" "$@"
+		;;
+	ssh)
+		# Execute command via SSH args contains user@host
+		ssh -n "$args" "$@"
+		;;
+	local|*)
+		# Execute command locally. This is also the fallback
+		# case for when the interface's target is not found in
+		# the TARGETS array.
+		"$@"
+		;;
+	esac
+}
+
+run_on()
+{
+	local iface=$1; shift
+	local target="local:"
+
+	if [ "${DRIVER_TEST_CONFORMANT}" = "yes" ]; then
+		target="${TARGETS[$iface]}"
+	fi
+
+	__run_on "$target" "$@"
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
+# Whether the test is conforming to the requirements and usage described in
+# drivers/net/README.rst.
+: "${DRIVER_TEST_CONFORMANT:=no}"
+
+declare -A TARGETS
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
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b40694573f4c..3f79bf1ec977 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -670,3 +670,8 @@ cmd_jq()
 	# return success only in case of non-empty output
 	[ ! -z "$output" ]
 }
+
+run_on()
+{
+	shift; "$@"
+}
-- 
2.25.1


