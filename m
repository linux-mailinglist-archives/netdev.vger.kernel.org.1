Return-Path: <netdev+bounces-261008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H4fIMkRn2nNYwQAu9opvQ
	(envelope-from <netdev+bounces-261008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:14:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED76E199542
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A96D331C26A4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FE43D6662;
	Wed, 25 Feb 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ift/ib25"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C93B8BC9;
	Wed, 25 Feb 2026 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032061; cv=fail; b=AgLng15+G18CmMsYIvTcX1n8yqogpnclKj0XUSOD5w4mlrT4gmslivQn1dNS/NBmCx+CFY2BFNa8qJJk5YETCFqy/qzfn93wRD8sIvkyisv9RNUeZriRkh5R6XWtHfabALLBS4+GDBUHZEt/qsFAzyZncpKENm4exuofCYd17wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032061; c=relaxed/simple;
	bh=4KQ8V5LqqvcaF9WAfU9jNNU8iSU4H0Mm8zAOIM5A5zM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caZBJjKY3nnWplOYXMnGCcOLWwlGlscc3RinJ2N70E1A0YCxYTLk9a2a0FcNJwvIUNQeQXab225RzmFxRSCtEQrEAs7GwdTSwqxoQNtyXiFPu397nbvm7qoUDFQ+C0E7yeUnJssBJab+uFUpDcUJfJgDfootUfo9WNhPgLnju5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ift/ib25; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhGctFetJhxQ4YIcAM0PrNVhOjinD5P3TkmgutIAox385Z0GklebwE/ZP+5RLTQcibf/WiqsRLSDqXHq0fuaxXJ6zunKJkiDubbMuqUn+b1qC4WxU2A4rGP3djWlxnnOHeQtfzE+7WvLumKL7Pyr7b/g7ZrqWvGZBwgJY3ir9875u40GGoKJ2Jm2ZfeWqbwL4neD4aq4y+nuuF8YnkrbwUd5B++AEJ7AaKaj4kZfdUnN2/DQO/7HtSpk55zkFIJrMCC94azq9NO+IqDpO6nTKRvo/rB4j5PgMxPrYuS60WWXLm5uB7ZAixfrP7zZm1Rct78ibMubPbGwtRi4O0h5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAEbMx2D+blp6W6tdazybPWFMM/l0NYokUq9RpKNnBo=;
 b=bHiRpe9CeEZ+NjNCS0zBIZ+Gp3Le8yjKtjvwT/1JnXaaPvWzkZUUjmxTt50kiqyCdqz4HM4KHI4q2aTebzcFYqSYJz0WV10ojJUwzhCFgC/nPFFoN4NOJUalK5Qyfzye6VPUwaABjKYzOKDO/uQX5T6UGdTvQVuueNUzN06/WyDkb9t1IZDmFeQMs33K4ybX5isBk1E+tUp3D8ODlDD2GZwJh6RqWUgsAy+6m2KVEg9YWxlRnp6SwumRhuNXtPZ779bAa7hYlxiakB/FA8OX4uKopb9qhD3aJWTfkl+9m2e9dQDXyJgtCL4R0gFSEUPxlIKdPjp0CuyPdShfbjaVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAEbMx2D+blp6W6tdazybPWFMM/l0NYokUq9RpKNnBo=;
 b=Ift/ib25MMGSbgNt8B1+teioJ2I56OWVfB0FFMgY2l0WzhlitPPGrbhudjsN+ZB21XKKgxtinYtBWYED89TjZ/eLNzHyWHQEFQNOHBNOqtJrKXdhfn/2UCB9yjOQK761N/CAJc+7pc95ErIwzbJkXR/3WseWfZS2lP25buYoHKCTztavv47Ua/aXw9UKZuE+X0hlvBgwtngvTTXzRO+DjK8N2zamTg7AAtHivMG4q5BkCaDLm4+KsintZxdihTiAnaVQ+9PIvFqWJXAKXkrkB6cEtjqrksuPP7l8N381w/ejFk7xZ2maVAKkXS3Sxx7I6K2xmkxzx9dBTqYw1YbSKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:07:37 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:07:37 +0000
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
Subject: [PATCH net-next 4/5] selftests: forwarding: extend ethtool_std_stats_get with pause statistics
Date: Wed, 25 Feb 2026 17:06:47 +0200
Message-Id: <20260225150648.1542206-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::18) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: d93a78e9-a626-4b19-bdaf-08de747f9ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	BrFSPZgbNklUYgu+oHXwI8CLJ48uD4wnxJ18LVCVXQHpa0yhFBNfN0uVqGBAXzTOe+mm2GXf5kJ/1UjcDW60/6B/8COfHiIJYTN9W0Bn0dvOrTVIo63K547sRD8tSttElvVjNnMY0tTblbRt3Tu4TGGfrPBZnU4UrnYpZ60xnD2XH5IAiwOq0nQwvwaPj4WpQCDGthm8q4N4sNkAYrCFfaJSJlASpwPnjrcnIdD8wGj4OfQ3AIMbHvctcHBIIbIT0/v++qrdnIbfmCvAce9wttiDi3iBkaH5BXO1aU7GsvhsZeyPyUPaRVcVQPZyEG5SDulOONpx+TfgPYevj5nvi/SLl4hwlmczupCRdi9LZoz1biq0/hyRaBwTo92bSfxmSY2Om3ce3BGshXajKCbJEdE4VVXBFRC03+NWYd7eFZ9JAoLLTVr/HTk5UQDwudCdhQ1r6j143MDLvHjg//n5i/Xy11hEXTK+rZJWtD6nWQFeY5tCNxGqwcN2XpJ+T+twtfbuxzJWNf/qKyVmSDBHKs8MXIaEKUg4372de77OZ1BsSTGtnK6pX3dwzyBYyNu1WSabfk/BxoyJ0FcGpu0BjwLN0nOv7fwg5B7iu2uPdNJbi2QC0ql5JR6oxD9jnKVbyI/qv9shSQeZYUyH4qHU0V5ZVFb3RuYdRB4Gmr8VhbHZElPF8yWqYyy42u/FzjChWJZ54U6yAPECv16WV5tTcdIgOsgR9B6f86NADcHCLqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fmvOBA6vQR6g+ODtci+l4GzKvZ8mWRoWN+TRgWtgA6LeULtrLrcfq8h0f3PB?=
 =?us-ascii?Q?jP0P+EU/RpSn1gLaYYFUBhvK/ucFCFB+9FQs2XfAd2V1JzGAJAceFJZ+W7pE?=
 =?us-ascii?Q?QAzjns1c4Q+yci8PELaj0Aaz2ktsvdxQKeFPXsF+TJhN0fN3KG+gVxeJamOg?=
 =?us-ascii?Q?6P32mZksXKcuOqFHAPZJxxum5ZcreJBtMtAvaxX0lp/xm8U86+HU1n6Mw3Rf?=
 =?us-ascii?Q?1ceKboYQk+8/hHrWTJzXGJ4XXP9YShhvLWOy8OMbcPg+JMu0zmUySr1TvSRA?=
 =?us-ascii?Q?lzY1ZQX/ugIKfuPOZNE5YIWx4DHX/68LwJrkRKYfcoSi67WJqxHBg3w/GTnb?=
 =?us-ascii?Q?Ejd0x7hJ+aO6I10DihUxZnSIN1TGs/58JePpVdbJriAOaWRNGH8BGAzDD6xA?=
 =?us-ascii?Q?w6KLvBnjLzgIcghSUHn6PzUWJ9n0yT6Eguoi+dBn/djMFYgJ4Z6vmLQkokGr?=
 =?us-ascii?Q?IUVL6WaxMM3JvG1PAN61f1GZxEUX4OgpWOQuuK2ETEc0zHtn4xmYpSQdDrS0?=
 =?us-ascii?Q?QUJhB7RJ3lMI54zUVXv4iE1cu7MJ0YKpeCD01NkkaMjZtR6rA5sMgv5YqKX7?=
 =?us-ascii?Q?gCWczSj8xmIoMXsaUpGvv5wNeqq+Mm0hmHxphlskAZVBMzBYwhV1vDetNqvB?=
 =?us-ascii?Q?/gE2Q2WuyjVE3/if6iN++vFPry3gDc1kym4MC4gd+HB1WZR14CWuTkWoBdVn?=
 =?us-ascii?Q?LCVH5MVWHT6M+u5CzIDyzBHtMvEYKnK2LDky8M4ux71eif2gN4Jun+LmRDBg?=
 =?us-ascii?Q?8K9N5VDOUBiLVJBz8+iVXj3abj2dvgqC0fajgsmcqXLJ+XNfwB/fMQ02uMUv?=
 =?us-ascii?Q?GwcIlf99sbHXm82MhcbJwt3qDDsZzsKj57YiNSUWEF7dQLfLHhHMX5kOUgN0?=
 =?us-ascii?Q?ZGSJLhjtiYvlzIIe7U2bq4wb0WD3w9w+xVgpVdW22CgL+T9VBLq4Zk40JvbD?=
 =?us-ascii?Q?YiLiRW4O7kSWRmrm6xzGTBzyub4V2wc/97Lte8eY7JAYJ3EZK204F+lzOuxi?=
 =?us-ascii?Q?7K9/WqhoPPD2YJ/AQCc3sFB04NE1xxYrQRUEubfuEzdOZO2f0774ZWb7MF9u?=
 =?us-ascii?Q?gYoLYZfP2pgCdDh1c7jbhWjWwbXscrjlY35//qXRVqxWGjujfx2GNPuIm1/v?=
 =?us-ascii?Q?ygt/4ZBiE4YeYKAdSzRgWs3YEYpWCCHL4618MEcG/sL2HtjtxJO98va07dpy?=
 =?us-ascii?Q?gwGr3J6XXx58BL6IGR9WAtpDlDUAp8oD2Olkqs5cU8lHmbDXF3Ni+YdK7aI5?=
 =?us-ascii?Q?BzLz6r62alL5hrcsbnEUEUYVxT51cevHX6rzv58RgtVYy9ov/Tm0WZhxhq1t?=
 =?us-ascii?Q?jGzc0ypffFQn516GohBjQT5Xrc2iba2OF9oCZXVGdVGiOLiN07cTXWo7vJTf?=
 =?us-ascii?Q?QNLAiXS1vb6ADoMoaZFo/kscpPmR6O4tqG03WRIWa6EYM5ZPz+3CCgFEHq6t?=
 =?us-ascii?Q?pr193Z44024yPOZLQyWOREfIQiFbeqg8zKR8lGe6navbnAhMGCDWEe9Wp4UY?=
 =?us-ascii?Q?2WON/uY9hk+Zr7iL7gJFJh7Rde67KQJ+XM0lphl2QViT0QtNMWPjdKZQV2P5?=
 =?us-ascii?Q?yY7exFOAleOk3AmocMjoZGUGJFhSARpsVs4rQ1WEcXFS1eN/b6fhPMUITsyT?=
 =?us-ascii?Q?ECgQ8aNGLDz4cdR3jUr5cCOrdX41dXUGVaiCxGQcaWNe7BVPESW311Pdql3s?=
 =?us-ascii?Q?JAAG+750qfv/+/z3ilmiHRElYxJf2n4PudMfjlhlDX8H0JGOOI4G4vWD3cEp?=
 =?us-ascii?Q?S/jEZez10w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93a78e9-a626-4b19-bdaf-08de747f9ce8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:07:37.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJu6QG211zC/5/zxVJUERE3pPqYuF3esyKLQUOgOQFIqymSu2VWU0WzDvBj6JvDIGi5JV95ZPFaC2OcSUEz/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-261008-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED76E199542
X-Rspamd-Action: no action

Even though pause frame statistics are not exported through the same
ethtool command, there is no point in adding another helper just for
them. Extent the ethtool_std_stats_get() function so that we are able to
interrogate using the same helper all the standard statistics.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a9034f0bb58b..efd236ae1c28 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -831,8 +831,12 @@ ethtool_std_stats_get()
 	local name=$1; shift
 	local src=$1; shift
 
-	ethtool --json -S $dev --groups $grp -- --src $src | \
-		jq '.[]."'"$grp"'"."'$name'"'
+	if [[ "$grp" == "pause" ]]; then
+		ethtool -I --json -a $dev | jq '.[].statistics.'$name
+	else
+		ethtool --json -S $dev --groups $grp -- --src $src | \
+			jq '.[]."'"$grp"'"."'$name'"'
+	fi
 }
 
 qdisc_stats_get()
-- 
2.25.1


