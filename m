Return-Path: <netdev+bounces-264470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAQtCN+nqWlSBwEAu9opvQ
	(envelope-from <netdev+bounces-264470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:57:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFAE214F7C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 518C8300830C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177FB3CA49D;
	Thu,  5 Mar 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aPLoBARW"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F23A1E70;
	Thu,  5 Mar 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726212; cv=fail; b=iKR1e/ZwbxVu23/gcBxrpA7RjKVJ5TmjHgE+20uZTQaX0/ezcOi1yF67vG7EFOMZDSP0zTmX1+zP9IJJuvM+eNiy97k/ViHSQEp84viNxL+t+AuxFG/ZofrfCNrUIvvYNCU9e18E+3Xm5G6Og4NwqsqY7GZ5rR3b+MdUfU5GUF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726212; c=relaxed/simple;
	bh=O/RyKjs/7YAKg8rk2Tv0zLEhBHMQXCSFHICI2WBVF6M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h5XeDuHtnjCYcvYEfeD+qyFz0qi9eli2GEjrykacPXOduQ6QszmkcCLWMiMZFY5u6QuNYaBs/VGv3bL2DuubYtsZSZ0mZcTm7dtQWMHysrVRBBblgdjA+e1fm+KoE6PNKvy3BNtnJClS9U2z/JSRpACITFpwdRGmARwVcaoi7FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aPLoBARW; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsgrLW9wz56Op8Vu3wXhNTenv+g6jpazfNF5I814uRYjInBN46jETqyF3bOmp2NldSuci0k1UaxqY+laExtkgxICSxQWtLKym+mALVl0HlsaCTgku3aNel1h5h7SbHc09CNg2adA5UJXrf+HsYduz5YhyG3QFzSHarpKfeMSXEPix/AJVX5OQnxsMPzkwLt4HJs33JVkOgsMxYei0s0eFQVNsYHFVGQVuJsiM7EEWpSWmEIQuY0vg5Cllh9LgdUvg1NeSljl9IvBvTE6EWreEeEcjXJjLS1yPkjYBylciALyYi65Cb95EqfWyShnoMmuMNXFBfsd5YycTKdWpVbfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmCJHd8fwrRHO1w6Hmdnd1jdqBGVR8C2ZnZZ0M3JCkw=;
 b=lUmmAGl6qyb53/n6IZwjU1kyuUmfmT67PJGBM+qXc+m1d/Qxhc5z1ZVRhVE/TOepGNtDbY7CGFWOyPa/PpKy0mY/GtdVe8690dpyWGunehCgviTNkwDUnBqTvTUpoOsgy09s6GrY/tKfVRZEyJLup5BwVxOrDPmRfMsNkaypKRqam0Dk4L71OVuCw43KO3pyMPFPkmbRHb/1Eo8iA+uFhe80oDJE0uZa5U/a5owgAq/b0NeSHoCKJjFIYg0HdsOZh4yo0LnSHsbQZ5OW8kUmK6K/nh/J/j8s5ZpJSRfbJW7BQB6bxBBsGUOfyM4Zrd08sOem8mTk/D70ljt/exv0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmCJHd8fwrRHO1w6Hmdnd1jdqBGVR8C2ZnZZ0M3JCkw=;
 b=aPLoBARWByN8CcCVtCZRpjOrRi/Vy6qI3ftLq/wO5LQuFDdLw9f+PTNMoAdrxM7w9ODacmvU3HXuuXIWDjCsiDz9vkks0Zuk/lWd2M75qDUxLQ2oh/90BVCmKzKA3BUMEZpzj99JxQoehtyCheIoA/m7zR/+WA4BuHNyvGtjimo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TY3P286MB2756.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:56:44 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 15:56:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] net: ntb_netdev: Add Multi-queue support
Date: Fri,  6 Mar 2026 00:56:35 +0900
Message-ID: <20260305155639.1885517-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0152.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::14) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TY3P286MB2756:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed810ff-ee5b-4aa0-78e3-08de7acfcbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	2Kym7csNgmNzxT6qCkljtVa8sdmBpFXJiyAQKbFXFa/3RVtI5I6Zkympeml3TS6OFboz0YwORpwW0g3Y4Eqz/mphgTKUVZCDzPxNdUZpDUxz5jPLmT98xK5JXHh1h7zSHEmprZYT0+lmsAoI+B+wy0JmypDPVr1aqUpPOkHgkSVWAihCargmDjnzuL0Xx7g6bCyoDyO2vOGukNVVq0ROH5F4F+aU6fQJcXzsRoiwRH81NwvqJvAZ8ebrLLj5iBBNyVILjh/SzI8qsBTM2i0ycJWBwqc0uwrd4BZVEjnzPVMMtKVFe/e1gRu7EV5w5q1+SVFz+9BVeYhIsWjhYTlF21b9X6ZF5Z0fsaCz0S4upy34yEOXraoYeyG+qZ50gc7nc8ExR0IOHKBPgKTBNrjcimpusDv/l6Yx2VL/q+ibuZANUswxCcEUmSZ7S0pwZHcpZiSSrK6aQmKZ8pfqRi3LGJ1EySIxw449nY11nTAXF0esqjj1nVvMuL6SBCf1bhsjK+GO/mNfEla2l/cR2+qdu41qAPVJNyXFgAF1QvHrukhrkqHkmEr1QcBCmswTN0g86BVOjmDzL0gAeMCAyS8JdezxhLtFp7byMO+MbzeaCJCVsZX91tuxqbCyAU4yO1qRdPNv1mDtTLzBBieNDsbPYRAFWHL80kob9uqU4a0kJlVdh7jLzp/W3nm8BLGxpYl0N09G13xbPdNyZKCjS5gmRV1lCsRaDOIc0Kx1gI2GBkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTJT7TUcAHQY8JPOmrm9LYt/+uKHi05MUd3eKLa82xVKjtNE2xchB9NRqUbZ?=
 =?us-ascii?Q?TJ+Jcy3SLyL2Ie24YKWYqjZ2qVmelCgWeFpitjCycx8fi0wr/gT1QVktAKjo?=
 =?us-ascii?Q?wohsUtv9GBE8WSzI6BSAnPWvKElJd3HLQI3nPmCwe1dBgAEAS3CIGTL4DzEW?=
 =?us-ascii?Q?YOTbBDsfFIucNhco1vS3x7zLLQKpVEsUvAjfg4+SUr/JlG4598Rnu//EpfRT?=
 =?us-ascii?Q?UxXfhr8LDfU5SMnwgUET28xcz/XtDdEAtsFkguJcWVp4XcukL1t68nds8J29?=
 =?us-ascii?Q?6+RCuNLHOcewxNIEefONoRLI9/wgnH9h8MHa/F6KjuAPRthJP0csMmY7Z0PO?=
 =?us-ascii?Q?T2qHAqJMkdwOuRpg2NjaRMKpWKSyml83u1/ZlYNaIxBP87rfwddXmx/qWxb+?=
 =?us-ascii?Q?2p6KV/M1pViL6DZA9zqsgm0J3TW7v15GUsG/HhH60LET5r6ulnVt06eJO9O8?=
 =?us-ascii?Q?VQ8z4gyClYWCmrezt4i180+vhTOZ3qkB4F7C3r1SpuvFXM1ALXsdJskAQJ3h?=
 =?us-ascii?Q?vf/Lsf24HjadAP2SSkZmnz7BXHuzqVAQmOXr65F68gpzrDwvbuAZEYOhAC1b?=
 =?us-ascii?Q?0YuVi/dX0haGDJrUJH5vD0CNzCn3xFQOEB51fEYSavrAYe9gm9Lw0ejyOkTH?=
 =?us-ascii?Q?CX3yeleIOKlj/X62bxDxASOENX/JkMXytS8LfoTAfnW80qBDBZOm2uaeqD9Z?=
 =?us-ascii?Q?w5eEIV7gecwoQk2HCRXdBdM2OtzMLxUM1qOVJbKWecfnb+FYJuiLxNpG70Ro?=
 =?us-ascii?Q?DSKs5o0O2DK2iXOaVLY1cPSNjbXLrppy1cknyvF3cGi6GPTt5lVLC3M1eVV2?=
 =?us-ascii?Q?65SvMo6iQSv0i7NYo/ohAMu0l8rvj9GVbpmiMiCthdA3Ca/+6A7sohwK3+va?=
 =?us-ascii?Q?8CSP+z/xOJRrFt3nzUyTjdvGDQlWVBE2qBgnkOC0eDuaSXSwK3YNbjsy2rtp?=
 =?us-ascii?Q?bEhCc73KS4CaJNabQ1ZLjiJmIAjz854zlaCi9ieCkB87ntyDcdK/TKlNAa0o?=
 =?us-ascii?Q?O8cOG49uNdhQMUA3fY5ZZbZaE+vOhoIqm0igKzc7qZ5tKoEkTfm9oA+kLhfy?=
 =?us-ascii?Q?+kIFF5mo4kqOS7yD3puNLM/N6zkMw3gYuXjithzjaFjP/piPlvCdhibq1Jw2?=
 =?us-ascii?Q?nrr/tCXG8LnOlPFjUP6xivDnPEZXS7W1EO138nR0ia9/9Uc1veulmlY9B+p5?=
 =?us-ascii?Q?8V7eceWHqjn1aN9mOj9Ws98/r7D/BqIXbzGbmYXmQi2JnMkkDJBu8QHM1Nbu?=
 =?us-ascii?Q?NqrLWJXqBiRBVAvwPolNHfuuuYMYHPzblaxDEWPRMWu+jZZH0DgO4l9J4umZ?=
 =?us-ascii?Q?CRyVjEMzU8TeCK9gdMBT3y7juE1m5OPQ85b4a2DUnJUpef4pVvmFUvIEvC2r?=
 =?us-ascii?Q?a9qwHh0Jwtea4GHXrs+rLERb9wusqAfL5D3rL1okQvNGuyrsLVzw86+nO10c?=
 =?us-ascii?Q?JHK2UKgxr2ipwOU83XxywEfDjoVZMaSmb6yEzsKTQfy7lxM+HVdWDMMbLJhY?=
 =?us-ascii?Q?opzdZ8yv33p6vXM9/XexI4CaVgEIoi8tc6MtsVxkhrRK/9bsryhDnXvCAJA4?=
 =?us-ascii?Q?HTP85aOeJJQXKqXx2r+Tn1ldTXF82QkPovOHpFgRkWvG3yvbJB4BkKMmGScA?=
 =?us-ascii?Q?tg6OHZBIY/pfs7TCNcZ520tw8vwsY/leHVSNTHnEghTDjkL9nnrwabnVnPaC?=
 =?us-ascii?Q?MusiMbkjkutFf2vehNDmj8BFYEmAtRfZFlYhiZk9zyI3BHLdVih/+B7aY/O0?=
 =?us-ascii?Q?T7oFQT7jIH+r+20fQkpuBWgAtMZBBBR8yPmw1PF9gEyjyE/pDs9w?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed810ff-ee5b-4aa0-78e3-08de7acfcbde
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:56:43.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uv0vk1JdNtPOz2z3TiYK7tkW700O9H6XLOLwNF5cQCHsCn2FZaNBW2di0pqrN/Mvm7Saj+9yk349NiMF6H4giw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2756
X-Rspamd-Queue-Id: BEFAE214F7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-264470-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Action: no action

Hi,

ntb_netdev currently hard-codes a single NTB transport queue pair, which
means the datapath effectively runs as a single-queue netdev regardless
of available CPUs / parallel flows.

The longer-term motivation here is throughput scale-out: allow
ntb_netdev to grow beyond the single-QP bottleneck and make it possible
to spread TX/RX work across multiple queue pairs as link speeds and core
counts keep increasing.

Multi-queue also unlocks the standard networking knobs on top of it. In
particular, once the device exposes multiple TX queues, qdisc/tc can
steer flows/traffic classes into different queues (via
skb->queue_mapping), enabling per-flow/per-class scheduling and QoS in a
familiar way.


Usage
=====

  1. Ensure the NTB device you want to use has multiple Memory Windows.
  2. modprobe ntb_transport on both sides, if it's not built-in.
  3. modprobe ntb_netdev on both sides, if it's not built-in.
  4. Use ethtool -L to configure the desired number of queues.
     The default number of real (combined) queues is 1.

     e.g. ethtool -L eth0 combined 2 # to increase
          ethtool -L eth0 combined 1 # to reduce back to 1

  Note:
    * If the NTB device has only a single Memory Window, ethtool -L eth0
      combined N (N > 1) fails with:
      "netlink error: No space left on device".
    * ethtool -L can be executed while the net_device is up.


Compatibility
=============

  The default remains a single queue, so behavior is unchanged unless
  the user explicitly increases the number of queues.


Kernel base
===========

  ntb-next (latest as of 2026-03-06):
  commit 7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link
                        disable path")


Testing / Results
=================

  Environment / command line:
    - 2x R-Car S4 Spider boards
      "Kernel base" (see above) + this series

  TCP:
    [RC] $ sudo iperf3 -s
    [EP] $ sudo iperf3 -Z -c ${SERVER_IP} -l 65480 -w 512M -P 4
  UDP:
    [RC] $ sudo iperf3 -s
    [EP] $ sudo iperf3 -ub0 -c ${SERVER_IP} -l 65480 -w 512M -P 4

  Without this series:
      TCP / UDP : 589 Mbps / 580 Mbps

  With this series (default single queue):
      TCP / UDP : 583 Mbps / 583 Mbps

  With this series + `ethtool -L eth0 combined 2`:
      TCP / UDP : 576 Mbps / 584 Mbps

  With this series + `ethtool -L eth0 combined 2` + [1], where flows are
  properly distributed across queues:
      TCP / UDP : 1.13 Gbps / 1.16 Gbps (re-measured with v3)


  The 575~590 Mbps variation is run-to-run variance i.e. no measurable
  regression or improvement is observed with a single queue. The key
  point is scaling from ~600 Mbps to ~1.20 Gbps once flows are
  distributed across multiple queues.

  Note: On R-Car S4 Spider, only BAR2 is usable for ntb_transport MW.
  For testing, BAR2 was expanded from 1 MiB to 2 MiB and split into two
  Memory Windows. A follow-up series is planned to add split BAR support
  for vNTB. On platforms where multiple BARs can be used for the
  datapath, this series should allow >=2 queues without additional
  changes.

  [1] [PATCH v2 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
      https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
      (subject was accidentally incorrect in the original posting)


Changelog
=========

Changes in v3:
  - Address Jakub's feedback: drop redundant defensive checks, use the
    local qp argument where applicable, switch queue-array allocation to
    kzalloc_objs(), remove the ntb_netdev_handlers forward declaration
    and split ntb_set_channels().
  - Dropped ntb_netdev_sync_subqueues() that did more than necessary.
    Adjusted the original call sites by open coding what really needs to be
    done.

Changes in v2:
  - Drop the ntb_num_queues module parameter and implement ethtool
    .set_channels().
    v1 Patch 2-3 are dropped; v2 Patch 2-3 become preparatory changes
    for the new Patch 4 implementing .set_channels().
  - Drop unrelated changes from Patch 1 to keep it focused and easier to
    review.


Best regards,
Koichiro


Koichiro Den (4):
  net: ntb_netdev: Introduce per-queue context
  net: ntb_netdev: Gate subqueue stop/wake by transport link
  net: ntb_netdev: Factor out multi-queue helpers
  net: ntb_netdev: Support ethtool channels for multi-queue

 drivers/net/ntb_netdev.c | 493 +++++++++++++++++++++++++++++++--------
 1 file changed, 390 insertions(+), 103 deletions(-)

-- 
2.51.0


