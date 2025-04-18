Return-Path: <netdev+bounces-184251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97395A93FD0
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA2F8E1991
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD941760;
	Fri, 18 Apr 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="t1lgGzuO"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021127.outbound.protection.outlook.com [40.93.199.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A7253F10;
	Fri, 18 Apr 2025 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014503; cv=fail; b=ZEQ8qsxG/15v77t0RqB9Nl4ZM/xRgTqLZibN+DhpDTF5W89B6tIYQrnGuLgR0/057m3F9Y1l1RMYAyAttQMdqbdhRxtSD/+rndt3LSe1eeovdCwbEhPlm7sJ/kzfMaDLogYQQe3VRCNa9KmEDGvziEqIYT9zzyWh0FfTDkRtcrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014503; c=relaxed/simple;
	bh=Ip7bhtPZdK7uRbg7XGt3oxty0X+x7RpNaNCqK2qPOps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AsI4xX3dMsu2n+grH5Qwin44ntAbZrdahl9iTmuPnPQc5o/ADp1bMyZcLv84WaYFp3ZQnySqbi7I7nITc/cGelvhFTjuyuKhbSlc7ULnRYll97hagVhXe4+/09J1fqrVW4QOQHa6CGRpMqsw2Mq8dIhNPI8Q0oK/k8aYkDw7ICk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=t1lgGzuO; arc=fail smtp.client-ip=40.93.199.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYjXK9rNGjVNBOvAK9inio1Bp19kQqnYef+hbSseMFpUMybyJoV2Rqsj41YYGcKJD9gDsbc4YkLg3M0O+EQJ/HPiBWHdfV+N5yHwFOmYqsFJOIUXP9g2AGCRrIPnMzm/fytn/fqT7LAHwvZA6NVoLfGq77I4YTNV/ht9K/w3sJJtBeb2s8sObYzbjsPRQo3dEgGhmUvpz20ZCo31mrP3p0N4PyOWExKWZ5fvEgyltBZ/3aB8oVgfOJU/wE9xsOEVXZr7UTzTZu8/QWn333f0Zuv5X2KoBlGn04nUcDuaxUolx2uc9k5BR6+bwZJa1qojo6T083Ba/5WV6J3FjZC3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbLE3dy3KxP6br99NgTVRIOFh9ho9ihzZnn/DBYkbaU=;
 b=h2nHiRf9qqjl5O57y0IOWqw73cXIfqH6R3rp9WVlWQhdHoMAGQmdl+mrU/N9KnqmlaASb75jWOhuDoP7VpNeWNyDw7cXzWcisJyHtxs3NHsUApj0HO94h8DFFDsXHTxsMLgEcxJlhiUKteTIV+qn0FDnlnKlEAIokqlpnxvMFlrsBzGdJqfuin1Dm+B/D41jtKhARQPxeBE+dfEYZuRJtU5aNw37bTZa9rlNPEmfAWEmCY/UqfIz+7kKCzs524yVFw4hCqKyAJURVG5/QgNqm8dpYYd4waCbhcH6K7GKrwzxUz+6AuEOitPdqeAWRFA325v58jxdCoZEoveb5F9stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbLE3dy3KxP6br99NgTVRIOFh9ho9ihzZnn/DBYkbaU=;
 b=t1lgGzuOY0dNOcCR/U8SXFvux8QJgkL65vWW2H2NiUFNvz7CbJVR59FyQWeCM+l0Tg/q/WWzdZY0WbdM9VrenD1Q+k1Ck20sHXG1Qthc/WX+3u5Rx9+oXA1IXIrC4jIunbchj4Th4912/T7aYZ7IVTqSnKjWUGasbWY/v1salj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS2PR01MB9277.prod.exchangelabs.com (2603:10b6:8:27d::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Fri, 18 Apr 2025 22:14:55 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 22:14:55 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH net-next v19 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Fri, 18 Apr 2025 18:14:35 -0400
Message-ID: <20250418221438.368203-5-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
References: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:b::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS2PR01MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f6c8fb-8eb3-470e-383b-08dd7ec672d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PYLAVPqttucZjvoyFqZF+ho3JM8I0ZjrxRvLJqbHKHo9dI3yIDDQULkcYE8R?=
 =?us-ascii?Q?ms9Q5n0H95B6ftMnegCk+s00CeKoxZzPHYnVaKG7Az08sJdWUKsxy6NX1Bec?=
 =?us-ascii?Q?tJVWE9S1Wy6uoo3Y45EX3o9FWtz45KLkZEcQDzRW/B3L8j8dna7DJzQO+/sJ?=
 =?us-ascii?Q?ohglKlpDmEpDsY+4J3vQXF9JDe4VsfpypMDZ/8iWHq4TKFlq1X6tDUgW6pgc?=
 =?us-ascii?Q?1FYBfEeIqTQPCsCiVekmQvxAHkNfuF0yrM4CuKdKxv9ciIhGpOcX65EsA7wq?=
 =?us-ascii?Q?Y7f1jpvHPxsts1oQ8NQiJw3StzINkWZqUWCusGsxw4dO3TqEbn/GviOwrGUb?=
 =?us-ascii?Q?6VUUU1qnWA2jPFXuhQNqhXXxKxUTskzASQiOz+c9HHIwqfBsX4TZidq0850P?=
 =?us-ascii?Q?J3ZcUwmaXza+sZ7wSeVq4zyY8/nZK/hjIA7cKP5FUrjr/wpfU6aWCA4PIw4J?=
 =?us-ascii?Q?AaOpt+TBxFPQ5d/bhvHKwKIDAobsjlV9E6tjsPbGr2YA6MK+a97fyMXqhP9j?=
 =?us-ascii?Q?pJkXRCL15H2Pme1nNziXxzA0VAzwrNwNYot0PXupaTK2eQvP4wWvZwySh37k?=
 =?us-ascii?Q?xYlRFJdIBMznnpPvjuYWVzxQLGMscTbJvc6Xuzt1XF1Okx0/zS9W/b3SlbS8?=
 =?us-ascii?Q?fN6DQfyHGbQmhYYgrEmzIAUl386Y1LgBiwgvwNMCTt46sIFb6jm+CMax04Qx?=
 =?us-ascii?Q?f6Ijejl21vRi5s4s/B3aJ/05cTqOi2Nqv8ehBRWtsrBPvcKwhEDcAtBC5OvE?=
 =?us-ascii?Q?Yg7c5X90+oXHVrr6S8kMzs8ZZMwtBfkdhfU/Cxe+ALjYbID3/KNuyJvVZXA5?=
 =?us-ascii?Q?RzWUEadKJlkTU7f2x15j7dSlK/j80Enz+R983tIudYOCfpW9losyEXdSfIW7?=
 =?us-ascii?Q?e4bHD5fLP4OJgQekuTdwDUIfknTvLX62HUIRcIn5u1cRwk7H6vti50CCqwow?=
 =?us-ascii?Q?SoeEGbEZh/lE+d41Vx9wohRAiuWyFKJQFBTS4FYgbpSZkPlg+1o4QSeGQIlQ?=
 =?us-ascii?Q?jMD7H9GBsqn1zvOZh0uk/pyPocPpdMEo5dwKieQNG+TZFo1A1rW2LX0zh0em?=
 =?us-ascii?Q?kGsjXMDOBRfNWMPLZAMzTFfqnaqR1V/su0mh42ERCth7Z7ReRuY/XY12J0Tb?=
 =?us-ascii?Q?Czc7d6TMeQT3a4Hs22lKRlX+vktRasG1HaUpI6tKurLBURU4HExfX7QutRUH?=
 =?us-ascii?Q?F5qbWq357nkQBTpgh3NPHMOLjkK0xzVJe74nXKZTY+pVLbI1qF6e4QX8oC64?=
 =?us-ascii?Q?Yc90HKYYbRwwH3L48R4dW18lmLy60x4fuOfxSHIq5bHpPGoYbIYdVrebmv9s?=
 =?us-ascii?Q?6N0nJGb1nchQ4ysO8znSILZossOeGr6vQpZ048SsN/ofG2D/gR1GxFvTGZUY?=
 =?us-ascii?Q?B83wUIg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P6b/S4Qb8QguEghZpItaLovrkuHP9ovcj6vgnl8ffi3p8CSytUtDuNSb4Qx1?=
 =?us-ascii?Q?1Gc8508/HN2BBPrUgp9U9+/qjkrKDOlvSJr5WpyN9ELk3y9ZRHA47hRHRcea?=
 =?us-ascii?Q?1hRUb7ZP5JRKLAI7mWy4T60kWL5khpOKxWvywQR7aZOm2pgVJTirrCihCsDz?=
 =?us-ascii?Q?qJ884BsWEKVqptXgILKQeSE4FxQQVd/3NMlA4UqzZM316gnfH4HCKQfUkUzG?=
 =?us-ascii?Q?9IN55c1Y8gwh4ZKSpK1L1Zfj/B+CQUO2uhDs25rMzokLznT+tcDQZxPcH5ed?=
 =?us-ascii?Q?9L0vhV/8e7GIzGFMcI6e5mvlQvrTOWY4edENycm1bs7sbdDMLEn4QOzd5/Ad?=
 =?us-ascii?Q?F8uREsNwTqhghV5oDfCIAclO7MDfMfLV+DbBwtdBKpljy0smKGQ1ozvpX/Lj?=
 =?us-ascii?Q?ZEzPDDaygbF61PHrrERMW0N6Zo3oMg9isbf0swUdKF9MBa920oKc1LtvAtue?=
 =?us-ascii?Q?PcC6ns5WPDqoAKPExsqVSvKOiYcNrv31Cf4Cnz0cd+fswIpM2cg+rUK1Rwax?=
 =?us-ascii?Q?5Ny3VlamlzjAmTK2EWDg2Gb9yRbgA/sZnrBXh/9JHEdgP8Eo0yOwqy3IxtxZ?=
 =?us-ascii?Q?n39GXco1yC4wRs/cRLNXS3FYw4pFelqRxey+RxeP80XP5iJsd2kTo5jZUDZi?=
 =?us-ascii?Q?+h/9dOemFwPbZUW1TEoQurXia4//hJ+X3iuFz2rVASK1zePvY8D9Dc8BZTSA?=
 =?us-ascii?Q?myg7klhmEcGw3Gdbj2fxLyeSzQypfGBDCbDdMS5gO1w+NHZS5vOoP3r5DUuV?=
 =?us-ascii?Q?6bLq+6cJSiBea2uT/t/vVrE1yl9bjlvgFNz6RN9v+1aKN/5DrTUMMrt0P8bF?=
 =?us-ascii?Q?WrfiNfh/6ZDfAI0sCXtZ/IBbW0SUhviNHdUKNB5Xf/fnmywBnXntfPog3L5Q?=
 =?us-ascii?Q?+76ZVqbuXRhmKdsX23nZfvXEBYugZ0/0HP6VKDb+PLECj42NAHSMyOW0FUAF?=
 =?us-ascii?Q?qDbMGcI+N2JvBotRdYkx0jDgRroITC3zQp5lG7KAqPkOohgKpkb9yGo7sAlI?=
 =?us-ascii?Q?CgeTrhJBpJbluocmtQOi6AjPyAtzfM/S3diRO8Cg9zxIjHCOKlmC4ZBfzRE+?=
 =?us-ascii?Q?1pznq1sw/BMLhf0vPSX7KGbWntSS8VcuWJwZrmVQIk8YzTxjMAr0m9yB2qJD?=
 =?us-ascii?Q?ZZRomhYzG6tA9NHeXhUp+BOZfW/72PWnd21QaKuT+NAvgOFIV1CHMST+S9sE?=
 =?us-ascii?Q?OwN+5g650LOaXt5OdgQqmvrJmLH+6lk8UFmuvusP92nP783X4UIAlbhM5s0C?=
 =?us-ascii?Q?WNEK9A1/gEiBC1DUse2OOvmdVzDoNBRivqoebx40BAdpRHzDb2JZ910JXzFb?=
 =?us-ascii?Q?41Cw8NyuM3dD4nvDYeiS2HeREkh/sCIsyd8Tx2zIZ+aIKtaqu/+VI03CEl6e?=
 =?us-ascii?Q?0TmfZ0uzRuUy06pDtCHv5Xj3cF9Ut8Z6azePLczo+kNyCYbZAdGqxtdkq44v?=
 =?us-ascii?Q?pBQ/yT6ZiG8T9OlYEMvuFagwGe7uQe/GQ5wgYBFQzai+VOu86lZ4pAzGgeto?=
 =?us-ascii?Q?OZvucsZ0QEymzDlNNwReIQ9Yx0EZohcXo2wcTPnn5ligYhqd6YkGWXqUu1rS?=
 =?us-ascii?Q?B4oo6VzJjPJoY7HMJfy9QmjODWwZKa4SoJpD9v8U6USWtoyyfzGlL3WWNz2E?=
 =?us-ascii?Q?7k9p8wIoWa1FXqFQsbwlA9NCPeGZIrpT2jsGPfos6FCM5j+BVRePMNBXVu6w?=
 =?us-ascii?Q?WdabisY30jjvzANUVctH/6okXF0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f6c8fb-8eb3-470e-383b-08dd7ec672d5
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 22:14:55.3635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGVjxmIh45ItcJ3TXGkhwpz5ESxNUoBHr5DMjG/Nc+xGbZN3OgSeNrXwHpG7Qxhxjkdnk4bnPZmjmXonfgrJ4coQTDEEZQ8IYMf6zZIYX6IkwcflsfIeoC2EDG2KxOO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9277

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 314 ++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 657a67f9031e..7642afb18092 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14200,6 +14200,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..f69d0237f058 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..2276f148df7c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..9332a070cabf
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_HEADER_LENGTH      12
+#define MCTP_MIN_MTU            68
+#define PCC_MAGIC               0x50434300
+#define PCC_HEADER_FLAG_REQ_INT 0x1
+#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_hdr {
+	__le32 signature;
+	__le32 flags;
+	__le32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to PCC outbox buffer and registers
+	 * Note that what PCC calls registers are memory locations, not CPU
+	 * Registers.  They include the fields used to synchronize access
+	 * between the OS and remote endpoints.
+	 *
+	 * Only the Outbox needs a spinlock, to prevent multiple
+	 * sent packets triggering multiple attempts to over write
+	 * the outbox.  The Inbox buffer is controlled by the remote
+	 * service and a spinlock would have no effect.
+	 */
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = le32_to_cpu(mctp_pcc_hdr.length) + MCTP_HEADER_LENGTH;
+	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+	dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_ndev->inbox.chan->shmem, data_len);
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct mctp_pcc_hdr  *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+	int rc;
+
+	dev_dstats_tx_add(ndev, len);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
+	if (rc)
+		return rc;
+
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	buffer = mpnd->outbox.chan->shmem;
+	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
+	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+
+	memcpy_toio(buffer, skb->data, skb->len);
+	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static const struct mctp_netdev_ops mctp_netdev_ops = {
+	NULL
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static void mctp_cleanup_channel(void *data)
+{
+	struct pcc_mbox_chan *chan = data;
+
+	pcc_mbox_free_channel(chan);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	int ret;
+
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	ret = devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+	if (ret)
+		return -EINVAL;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	/* inbox initialization */
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto free_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	/* outbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+	mctp_pcc_ndev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001"},
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


