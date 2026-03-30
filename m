Return-Path: <netdev+bounces-273247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBoZMjeXymla+QUAu9opvQ
	(envelope-from <netdev+bounces-273247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:31:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943B35DE0A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 194AB300B5A5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C551346FA7;
	Mon, 30 Mar 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N9l1fUw9"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADE343D8A;
	Mon, 30 Mar 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884640; cv=fail; b=GHrWEol59qN12NYd6MoJklS4MXXhc2XCYbEv0cbIFs56j3e26w8IczKe1tgAbFkoA+hqvmvaYrhOJ0B88MIK+nPXZAtrmYjY5Ol6E+IJCad5iLo/Jzx2TJztx1HkogYf8ZrZyF9y5kNtJmp4tfyEwlmaKXHS1gVu7fD2jHhFBFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884640; c=relaxed/simple;
	bh=QsF02G7b8guSuAMxjbWqpr9TsVwOSzsR/vZtBil4kVo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ppH9zKHIC0XLTMwFWBHHHGs3RLhzE2R0GjMie7tV+Wz2XhhCSHHTnwGIVym7+P99lRzeI3QAaWlzk7O1CqLcQLknWvcgDWQl+m87g71V1bx+kjj9SpCNE8a26v/NgrpZeTmFQdr2C4g9vAyPQKp/5/iplxeA2Zj+DMPB+V7RLHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N9l1fUw9; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+otnd8fVM1m/LrQ9YlEzaJQBayGFCrn9nl6xGLWin24h+Qb53+1oXrdu65oS/LENNmYlNDRAOrI7n26dTEP3kzyMY9KPgC7bErbAKgiHzdDFx1ascXydgR/SFKTbJVCQqXRST808IYTPtWRmjTeQF2UZe1UhVeya3FbkDjs9dbwPocm2n7LDEuFfR18AzRglh4lhhpcaREJ6rJdkCdTd3XkLEkm+W3eb5xr8eLti6g3bHouySQzrXkPla6FcUQHihnTVUa36GyyzXtkjiihsNYtDAAakGgszaa0vM4cqJCEfxo4AW+FrWtW791y99IUj/fkTMDcvLbmD+GUt8c16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnLES9gqvZ/ki1Xf7RmSuolUdpwJN9xlCWyUOD1XUZ0=;
 b=gijMIH9mbkPahSHyq66e/wBpfVS24tAbkE66Tc3PzZIhu59B3HQIMZMqQa0WJ7ibwyYVm8PdS13YWkmOcneRwGwkuq2Jp15pbPhXUCaiJF7DdlQ9wjDZEKTC6TGiHNUQIAooukpD7degr5hKjPhNHDHRB03i12U80XKFWkkPq123C1jb6FR9veuim3WoEvbXph4TOvV6evqg3GCx2Ht7WFyfKWFwukZcIczViPFk1a7fGVAyLCcIACO9LHcN6ErHz28LY5Lb1LGgM9l0e3Xusb0lhI+0PRSjggsrEE61dJticUDDiSyHPDcE1kH86J8dHCmO4thTNAnIcTBfDiZImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnLES9gqvZ/ki1Xf7RmSuolUdpwJN9xlCWyUOD1XUZ0=;
 b=N9l1fUw9CDMLasFkl1vNSVBgqNYbiZ4bej9yVbXrWW38iCFJrDdCOgHGCxU1PqX4m5FYAx4B8ideEGgkzq5V20zk7ca1zm7E1r4/NVpho1+xEfoBvd+fom6NYwuGDztcUSLIwdf9z9KYH41xwbqEp5DxH5faEFlnubL61l9Z9BxTO8DoHL9Sc/FY2ZitgpAw8dxdAJEZGkLiZMAoLgH+H1dMietmyD3BTzrKDJXzMVk6y7e58q7zCE7AKGPR5UUHsLK8hnONAp/VO4jyx/ccgRd8gFbyvW93UxitMe5cfODR5SWcweivF03c4xDW7YErjTz+2OIJ4oo0Gh13uKkQPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:34 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:33 +0000
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
Subject: [PATCH net-next v5 0/9] selftests: drivers: bash support for remote traffic generators
Date: Mon, 30 Mar 2026 18:29:24 +0300
Message-Id: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0166.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::33) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa0b4e0-f36b-40cd-5ea4-08de8e7148d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ijz/3uMxYieAwmo6f8sJlP+pMQJRIQxPOvlSS2DjIFnA9IGZfX+VfijEIfM2fweytW/5YRwKvkOcqPk6Yj/U9e3DZTT4xickEtbfwNApJUtwZNzwXL04Y/op6UKPH+nujAbn/eFt22cN58aqNRMc05e3fN3aQGg9ZFRYDGJQRaDSdWP0slZG6ioAKOtjgNf7DrPXdbHqDFvLNhkNjy2MQB1rKqddgfcXuJ/hgtMDmq0m4LTuRnqzRq3tJjs7UPsCPhiLDwN/puAaN/jaEjD2gxD3FX44Ppn6bV+pd6OY5tVj24AvypMWDOg3NwYo+HZUeu53b6vHO3127VMI/BmwJ/c9Rq4yDtBSRE6CgUnz44xe/gf02RH6PwdK40G2cFQE9g27IW5ZxMCQ+B47Qj/GsGDRgQgRUE5cgnaEck84euGQuklugixYGuUGw5ea9RF1qFWvnAx/HVd0djHRe+SLWy4LcbZ4tmr2HoFVW965yf3T/YRlTULk00rkAIh/8kCaQ2rIM6brjHa7RBPpZynzdqxYEcutCKJ2ePfSv66qNFHTJGQLMgbQ++wJWRTpY2EA5fnn5KgjSjWwIym7kqyfSzTosLmuP1a5Gz2BgYwmeLrjXjZ44nTHhJw9KZkoauD5+znvKQxY1xJTjwITjt4Fv3Xp/2U//krKieCzeIBqa5c1iJ4tFhIYvvEB9sVe9gFgxXp9OEUq8gs0zsrYhAukcLIT7WiCvxmMxB4GFL+r+nj+MCnW+7dayTYP4cww9GVs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PrkXKdz/38hOgA4V2GZN/Z46RaG/gzCa7RSh8HSMNSwBkdmUDb3GTm7dwhyY?=
 =?us-ascii?Q?hQbuRhyWkbTsp508bVExbGiGWSWmxB7hwoaC0Qph3/XC6DX4KBgTIec9s71c?=
 =?us-ascii?Q?RaJhPufpSWvqQnOuiQ/k1I6HbHMavDEdDC27GfzeBEX0/Yw/ovVIrsvctHcb?=
 =?us-ascii?Q?7RjHPK9vRLHoJUD0rk3fswzHkBpVT+9cwBKY5Vq/qgNPBdplUeGUDO1PzyHP?=
 =?us-ascii?Q?E6nL33oesOwCm22eZCDOdoPZ4pq8NJ6YiU1pqD8MXWI3lqDUa0VlhwjTAB5h?=
 =?us-ascii?Q?J6WMeL83sm46Anv8MU+aTUhCBKO0CWjQ8AHJ91FDjG7kAdpdeee89u3xvpn0?=
 =?us-ascii?Q?3FwErzx88EvQqqjk4yssuHuE5Q0S0BxOd1A9x4/Gep4Ra+ygvh4C5aXKbK/I?=
 =?us-ascii?Q?/k7Q31yYNxJ8CFClfxt4H4mjXk4cJemvxRWRBigOYiMjPWe1rE/0uwyB+/w5?=
 =?us-ascii?Q?MZUUKFkC2F0Kahip05g/SpOUmZqAmSmxV1WTEZsN2Yeun59bGPdjj7FpVYbm?=
 =?us-ascii?Q?NnLo83n4YST32GP60Tnhn+V6CgpA0zVlWDJHKPu08Uyslw/Gec6evgLwiBzs?=
 =?us-ascii?Q?4dIbQZ57iu3OT5sM0EnhafsYnwvtQciQlnRoMtebFOdIHjpvp+E5fyitmB1G?=
 =?us-ascii?Q?XYO/Q1PTlfG95ZO7gaa+v3ALQtNifj04XuMoAbtOXRncmTM1V5OTxF1YPnOS?=
 =?us-ascii?Q?C3shFCSdjVZwhnezqjOi3cdSQNqb/M+K2+6GNRyYLETzHpVDlk5tajg4ZgEv?=
 =?us-ascii?Q?Tu1szdj8y2io+Tejgc+eXTURWpUZ3+dJuyQUuV/leACLzzmVfygj/NUKhZpS?=
 =?us-ascii?Q?KdRianClo0RW7NVtkZfD7UMDzw8xLQtgw7UFZhlBx9iDn3MlegnmQgqjFRLX?=
 =?us-ascii?Q?L3scUOIW69+kaCaowWb7l6Axj95UFHrzYy3NUNmDgKAwlx49YME8l1+YW6wg?=
 =?us-ascii?Q?nuse2BGMxgT0RWNZizULANp/4qHL4g25NUbSXGb4ORq8LQuDDGsT0s1KRWbw?=
 =?us-ascii?Q?JNY2/iW81zbkZJY4gHbcGDObGIBogJqW2WjCoxKR5o1MXd9TcoE0bwJcWqhr?=
 =?us-ascii?Q?yzNbjm9pjUdsdgjkYPec4SGuNJXf1c040PW1G3SVTdmGyPSG9WiJor/BmAo9?=
 =?us-ascii?Q?H5lAT67Wz3Dpx7oqnGkK7gSk/TQatQvFGVuZkX2b1pbY2AWNGzkwkSixGYDL?=
 =?us-ascii?Q?q+P99C4iwjQW71io2+Z2zkOn7aqsa8a0yaDdfDYErlJJoexSV/ynVBmxdEYE?=
 =?us-ascii?Q?qJDoSeE+2vND7pH2HJarsj5NBE6bLbywdYqS+SiAS+KXG6X2puM+lbQL13F2?=
 =?us-ascii?Q?Csf889LL0iO5G1QYjKfoVsmRraNfdK/Sh1Gdfb9w8DnjZ3aQEcXqI01avoT2?=
 =?us-ascii?Q?vdUr489NfrT8biKUBr6wMbKfIy4dBwh8joPoTnL7KEFz039V5cBY2V5te0pF?=
 =?us-ascii?Q?/FfX0vEnbTaLqF2DMWlIe4MAgfI0Jt5YXmDCEYAM4cyO4xgL+Dz520g5Ota5?=
 =?us-ascii?Q?HqqDPu4LyjOFF/U/2S+uMVn4N5Djwk9GveY/H3HdopIMGx4xeaoKuWNHT2c3?=
 =?us-ascii?Q?4bh2EJnlqETXa10D/53ptVDI8sDiR6Te8I2EVG4d+tYGzJ3I7QJYSYSpjb3J?=
 =?us-ascii?Q?KDVs5BjKBZIdo2pToU8nAESWp7tF8qCB22jy+WFCTX0TqYXyq7Y/xSx6Elkm?=
 =?us-ascii?Q?uYW7q3o0SdZJnJzeyhFU2uT7o0Q2MKipnXRsFa3SZRPXRNxIROXk6giqvzH0?=
 =?us-ascii?Q?99To5g3ihw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa0b4e0-f36b-40cd-5ea4-08de8e7148d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:33.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fez8NsP4ofEt/kAjAemz3c8itzlPC0zVBDjHZj9YyovPNHhMRsPs4CFYQcplkXS+prrUiTCYszwQhtMwT0uqFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273247-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid,lib.sh:url,ktap_helpers.sh:url]
X-Rspamd-Queue-Id: 4943B35DE0A
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

Changes in v5:
- 2/10: move 'shellcheck disable' at start of the script
- 2/10: move 'declare -A TARGETS' before the if statement
- 2/10: move the DRIVER_TEST_CONFORMANT declaration before the if statement
- 2/10: move the __run_on() and run_on() helpers in net/forwarding/lib.sh
- 2/10: add a stub run_on() in net/lib.sh
- 2/10: check for DRIVER_TEST_CONFORMANT = yes in run_on()
- 2/10: squash patches 2 and 3 since with the change above each patch
  depends on the other one. There is no point keeping them separate.

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

Ioana Ciornei (9):
  selftests: forwarding: extend ethtool_std_stats_get with pause
    statistics
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
 tools/testing/selftests/net/forwarding/lib.sh | 171 +++++++++++++--
 tools/testing/selftests/net/lib.sh            |   8 +-
 6 files changed, 421 insertions(+), 51 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

-- 
2.25.1


