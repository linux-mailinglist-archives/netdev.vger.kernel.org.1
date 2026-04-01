Return-Path: <netdev+bounces-274204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDd2Ht5VzWk5cAYAu9opvQ
	(envelope-from <netdev+bounces-274204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E98D37EA94
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 726E2307D059
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2CD47DD6E;
	Wed,  1 Apr 2026 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lZXXNCAP"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1147DD40;
	Wed,  1 Apr 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064181; cv=fail; b=P9S3rBIqwmPgbSYJggxVhNYmlAt247lkMquvu1NdZm0fKsIRnFU2gEWnPt84SxDYdaeG+CEM4XE3Yc08H/YCN+XTUH7xpOICK3DkyD6mGuviJhOAPK6YAsFVOpnQFCeGWcmsqmcYvOBGmaDAtII+uybpyklgufMsxKXS3/i2DO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064181; c=relaxed/simple;
	bh=W00AdsPeQGTknSHyZ/2oXNXkuo3jxtPlBVGaIr21Zog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IocYU+XnOBoOWjdBQlRfvzicNlV/361EYKu90AGdXQA8OjsmA7kpYc6bAQaZrWjhKO7+cq3YishCxCJXvA0eoxekvAvmojvS4lIYMq3cTeUPnoCcyegerv3RgAt4RcLn4Ote5MgCc8gS5k2amW5s/DFAmMFJTmerMDU6UBHYcWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lZXXNCAP; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfOsvWM6RPYKf4Q9d4FEYSHRt1mTzAZK/5yKb/JuJdCUGEeZpoiKyurPLyeq4dqG+W0UXTJYd+kwPQAe+8oL6YdcxizBmlJTk8s8Y3hYgI8ugOLnFZEjUQtc39QLxfGuO953Elb4XxZvG1BuysNvtw1wP/pPUzNjU2WEHcErOY+m5BXYbKLLOEepiTmn1p/IzJig5j0wxsknZW30P8nsn13czrJzNxdMZSHsIdIKd8ybRyZ066lJfSocmNZqEwclEaFhopRW1KTQhDvOoC72WE9zWzeodvr3GbdSzZ1XEkQqvQtbu9Qd9f2t5cIKOtVbPHnEdbVyQs1zpbQyVew1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrXjLTLvDLnX2SPG2pPV3JpDAU6Q+KL23uVP7bjeou0=;
 b=y1dcGy6+zKyChoBCVPQk1eafxBR3Ib4ycu7nudqAUA/paD5v/YUu5sbN/ZwuPQiUUI8NA8wOnPlrLBmf+0SfikT1dAWSlxvl3kYeYMF2NiJVuLK45lAqyEMzfe5LAX6PtLomMbyBZ3WwxB+G4ImfpkdE+uRC1AkGCcfHQjIeO/96rIig970QKsv8O5+4Koyle9oSPwUPXWkVVtARjBSn4szVSL7vAD0I6NR2kas4kA/W9TX6sGgqu8qhXbPzlw2QrDCy/UsZlK6z88aa4/fEZu/rS35h+Ib8+XSrRINS9V2aLbstqA4XyT1K+tJ/k9e7P9p7j1CFpelGa1G6wSmu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrXjLTLvDLnX2SPG2pPV3JpDAU6Q+KL23uVP7bjeou0=;
 b=lZXXNCAPbixgpAyEL6fXMoE9McBFyZP+fH922Bxe+XTpuMUGYu9/m5ZOwHGUiUSrn+W3U8RbFolOvWg4LYZjerIDVvjf/ToYQI+BuhkmvlBU0blrjCijAWn6hnZPP2cxpZUf2MRc2oV2CnytPzv44w14gyp44WtDd00o+Rv/7z4SjfpwdAdjEYhL0O6jrZUMCdDkz7IDR9hre5ahZqKVqXPrZY2Co6JJQ6gWx+7dQqEoPhAuX0+WarY6HjwMY5Z0tQeVL96Tyt106PV2yY6L3vG+VGQ7j9sn1ksANUYSur8oviG61c3zuxjhzTtasR9Q2t0sNKvlEI8OGR7o63RFLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:22:58 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 17:22:58 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: enetc: pad short frames in software
Date: Wed,  1 Apr 2026 20:22:45 +0300
Message-ID: <20260401172246.1075883-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401172246.1075883-1-vladimir.oltean@nxp.com>
References: <20260401172246.1075883-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: baa07d77-df7b-4e4e-2aea-08de90135163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|19092799006|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PjWjZOZ3EBw8GlaY7TX5ldK0e4q55c3FlLIVkseyB6vN7AaGwwViv8h0AZTOO0UhNiipXAk/i4lKZgk0m9lSqhtABnT0zP6XUUUbOtb+MOG83sVcGrqQ2T9Y4mNLw59YMdUxH3Cs/i4wewa7uPin6RiNRH3lGhMhlOOXhbtlKfcmwoYI6QwlFffv5pOGF9nwCFpeI/H0A6yrfcUX3vymvoKEy3WR50SgiPaI7b/VxATATJ+/JhKphHLMVKGw3EEE7kB3wVERhgHPYKCAC2UHb+uPkOR862t1onWLLhzVjdh5+vm7e52IPrTZgiL4JkNsRqq/fz2ZzW+/++c50EFqUTs7d/yg6l8IPMzrFCXv5ZqyZBAE6pZ8veceNJmh3Ldkq/ZbuaTuLYykFf5JAiYqabR2hRzzlvV52bHjjKAPSnu4bdAXFj/62jkTIEWpS8CkDzZTF8mpgC10CUwPKxK1vk6M8NPHS9fqw1KFTQ0XvqLqCBrNrk418SxMRqL0tLdFOraP28xXQsVfG9MzJ1waiLYKCeU8mMjrouQfT1dHjVSVMsoWRw+ebUWMju5z9HNEFV7QXpoxXRhcudGuT5j96osi37S/O8wRHWEEcyPLIoi8+kxVka/DVm0OJ2ZM1Uc1u2EbAOhqEoOvBz4cb0DLarnZWW8h0LYZMC7omj0ypQUJjzrL3OAwY1fWI5CzR0VW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(19092799006)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Juhhd1wPR7/khHTO+MOGSDZp0jrZEJHRg3KNzwdHkuV/BZLLr1BG09eJFVKx?=
 =?us-ascii?Q?ivBCjXK6Lh30QuojyKLv2WKUol4ooSbH+U+Fzao2yW/ddtLc3aG2ocgSPf/Q?=
 =?us-ascii?Q?tH67nttRDkmldQPmiHMG41KWzjpOdJbQeXQ2yd8wA9zLZNqBpYl6RcASXgib?=
 =?us-ascii?Q?F9NUGSswS6hr8HUtkyedtvemNt5bwZuWc++VJAR/vTJy9urIX16y3V9LeboY?=
 =?us-ascii?Q?3OtnQYMqt3ZF+nm1MeX+SoWNphN/luZDsAPmX5qMqTGhfeu7Ikbz3GG21Gfe?=
 =?us-ascii?Q?lutvEoAlFnUxTSYq4w7ZBVUCXde6nWL3mwp0aZZ79OXxbs6+fGtN5GLpyeTf?=
 =?us-ascii?Q?MHuU/lmg9qh0jynY5QSQz1VASUfxVA+MdVqXeN758/1z0JHVxUXUgKOeX02R?=
 =?us-ascii?Q?Ra0t3DlyxMSgLgHpOis44gIYrYQQUXpMcmxnxHfgje7BYMIscF2cmxGGgcu3?=
 =?us-ascii?Q?rK3bFfdm0IMgpbEHaxVINsp1+vzYFLfyLFZ1FYQEIDAG4XbxyMknhGNSzcNq?=
 =?us-ascii?Q?1ux8kHxJ6U9p6Mi2VaeGl8bI3b8lD5Y6comqXHKtzDD6FuaGprcNqfm6Z7yq?=
 =?us-ascii?Q?BvWjCUDzuDywNU/Z2cCwlipGTXxELM1h++nK15rLe5vlFLDuDeJi8XKIKZmU?=
 =?us-ascii?Q?8yD9u9wW36iGaChetZxkU/8RItHgNzxo0Bgcj7VYDDLBao53nbj4stbK0q7L?=
 =?us-ascii?Q?7HCBx19cBCD9rAPzhmfhz+LAQ2R0JKtoVtE4gW9ZLqfiMOikHdZCv8lOqmbq?=
 =?us-ascii?Q?/NUEgqqvTRfltAo3L6VyzIe5Wh07tM4wd8cvMIf/xUGTr4t5ciz1lTOA+Rgh?=
 =?us-ascii?Q?FpZneoujp8exnhm+ghd+MOCPSsNyw4t9MAPYpKvNqSUUJLVLjxhsg0gkAXrQ?=
 =?us-ascii?Q?ixvVktyf00WnFZr8Hzlxxb3muT8QfKRurqqY1XkMTM0+I7UOp+CTvrmJs+5N?=
 =?us-ascii?Q?iDsAJKgSrniAAGLxL2OkVjeJXAFS6OoCbz4U/h0QIR1neqAUnS4RQ4fadPro?=
 =?us-ascii?Q?x2h7NGZ4dqrp/2OLSlOCJ6gh3KKdY/qDq50sLAUi7WSHZsfVhTha+DE3Ds50?=
 =?us-ascii?Q?0elLCmmGdmFD5t/64hotquZo1eIeiyR7QjN/YEx8cT+A+eKf044ELMPbS/YK?=
 =?us-ascii?Q?HGLGUt2pESNaKT9tBxoyG8F7sAObkEH3r9XNoHV2SLXa8+DxhjE3UUjt7Alw?=
 =?us-ascii?Q?DhxXqW+gvXo2+8tL3hedgN5IBjZFrwweuV77dkxcE9kMrmjYcjNIp90NR2XV?=
 =?us-ascii?Q?t9Yta6UvU52SnUegm5tY76EdHtFbimWauZXbXoHfo9sHFldis3qDm2PKpVlQ?=
 =?us-ascii?Q?43vnkH4q4uj53UV9ibqPoYLeFYVMX/E0HuaUFkbKmuIy8FIrsH6YAnkYXeF/?=
 =?us-ascii?Q?qbgxoMwneJUo6UnDtrFFt9lm5N7Pzx3Uave9WXj8GcVjiQIjjtK5MCUxpreZ?=
 =?us-ascii?Q?1V6W5Fa8WoNdM87JDqC66DeYFh9tkaCjU0OG3jaI/hHFy1hyevZsgNTggHo9?=
 =?us-ascii?Q?Jq4niephtraZr/6xvgb6GgI753WhPeOW5CM9MNpsjuzAweOMwCGxt4n3/PYN?=
 =?us-ascii?Q?q8NudwIqnIe1kSWhQVUGCClJQzdRJuwQIY1t/4iTubN47839criXixICt2MQ?=
 =?us-ascii?Q?eqP7to7qDPv6IRMGKwF4FtUgdYhiaz7PXkUq1SGkbCRUF9ZmEEjVTjI/bTM8?=
 =?us-ascii?Q?knI4cuAhGTrzGB/DG2oj1uQ8B2mxWZwiXub4uKo481kY8YdZrHKRypZQWHfq?=
 =?us-ascii?Q?T6W1GtVOsnml/LE5+NNkGEANGmhm5QvfVxkqKUqoEeQNQ5mdOvAP778xXIza?=
X-MS-Exchange-AntiSpam-MessageData-1: syXMHb4cMjIPFR1zvvPROKpCHQRTmWyHlQ8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa07d77-df7b-4e4e-2aea-08de90135163
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:22:58.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S28+d9yphAkd3TOkNinpIb4rr7xNBXT/JwJsVt+Xrh+d7OkkHB4bzKdK5pq96KIEeFNeOHRxtfOWDy0duW3ZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274204-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 5E98D37EA94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
less than 16. This is written in the reference manual of all SoCs
supported by the driver: LS1028A, i.MX943, i.MX95 etc.

  Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
  0-15 bytes are not supported.
  (...)
  The first descriptor in a chain must not have a BUFF_LEN that is less
  than 16 bytes.

I don't think proper attention was paid to this during development, we
found the text at the end of a bug investigation. Therefore, the driver
does not enforce this.

But the frame length is out of the driver's control, and the network
stack can actually send packets with skb->len smaller than that. The
result is unpleasant, as will be explained below, so for simplicity
sake, we just pad anything shorter than ETH_ZLEN.

Zefir Kurtisi found a case where transmitting L2 WNM keep-alive frames
through ENETC would soft-lockup the host through an IRQ storm. He later
distilled this into a small enetc-killer.c user space program which
sends a packet with MAC DA, MAC SA and EtherType IPv4 (14 octets in
length) through an AF_PACKET raw socket.

The IRQ storm is actually a curious effect of a chain of events.

The hardware behaviour, when an invalid BD is put in its TX ring, is
that it would transmit the packet as normal, update counters, raise
completion interrupt as normal, but it would just not advance the
consumer index of the ring (TBaCIR) to signify that the BD has been
consumed and is available for software to free. The ring will also get
its TBaSR[BUSY] bit persistently set to 1 afterwards.

It deserves an explanation why the behaviour above would lead to an
IRQ storm, since ENETC interrupts are message-based (MSI-X), and an
unhandled interrupt would typically just be lost rather than retrigger
itself as a wired interrupt would.

NAPI processing in ENETC has 3 steps:

I. the enetc_msix() hardirq handler disables RBaIER, TBaIER and sets
   softirq processing to the 'pending' state.

II. the enetc_poll() softirq handler for the IRQ vector walks through
    the TX rings affine to that vector, checks which ones have a TBCIR
    updated since last time - enetc_bd_ready_count() - processes those
    completed frames, and clears pending interrupts in these updated TX
    rings by writing to TBaIDR. (I've excluded RX processing due to it
    being irrelevant).

III. After the softirq handler does its round of checking all RX and TX
     rings for updates, it re-enables all interrupts in RBaIER and
     TBaIER that were previously disabled by the hardirq handler, and
     exits.

Because the TX ring with the short frame is skipped at step II (TBCIR
wasn't updated as part of HW malfunction), its pending IRQ is not
cleared in TBaIDR by enetc_clean_tx_ring().

But because enetc_msix() disables TBaIER at step I and re-enables it at
step III, another MSI will be fired upon re-enabling it. This is what
completes the cycle and the driver goes back to step I.

So the driver misinterprets the mixed signals it's getting from the
hardware, and ends up causing a software-amplified IRQ storm.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Reported-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/
Tested-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c9cdf9d11212..4b87fbfde0d6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1050,6 +1050,9 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
+	if (eth_skb_pad(skb))
+		return NETDEV_TX_OK;
+
 	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
-- 
2.43.0


