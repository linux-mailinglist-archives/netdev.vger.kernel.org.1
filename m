Return-Path: <netdev+bounces-151993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B089F24C5
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A34164CA5
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 16:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061411EB2F;
	Sun, 15 Dec 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="KXtqc3Jv"
X-Original-To: netdev@vger.kernel.org
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3E101DE;
	Sun, 15 Dec 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734280475; cv=fail; b=VtE0qUX8Mtvoy+s368Ef3bYZv92XMi/63neQL8UuEgQ+1myix340ta38MTe0XaWYjqrhCghMTWJqixM35MiSjJ2YP+cpIoOrEp7hYIpVIotvxJ9ci4+hhfgJlGzQAM53TpaVeBfarab/2JNDXC7YwzrHzs9e14L/+jnzgM0UEXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734280475; c=relaxed/simple;
	bh=uw38G+e22F3X9lVK6K+EFLTdlnAKf62Ur/hJqtFFKK4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ovLfBoSOiCQbp4ef9h8HyCxGV5IkZeJyk/OFflSSlGk4Mde/ggBRdxLEofz0yv2RxemkE6XnK61gQVF19NzGt4AJRFbCOSPXEJkE1jX09ZmX9TniGhXx3RrsGOmxg8Nk9YtpZ2aW+k4xZUxFQKjiU+XCUrSVyuY4q953xGXaEac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=KXtqc3Jv; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48]) by mx-outbound20-179.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 15 Dec 2024 16:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw+GnY/ZCTm8LR+X7ZH575F/UUjpcN3GLMYe8IFPqdS6SBmHQX3VT3y8Wf8+ebdxOn50ghSX4skJkSaYmQG33Ta/BdhL3ictmrtpBEf+J2B2gpTIo2hzVQVAT1aUpOtvSyuyxZSdV57TLxqNkeK1+k4XyzWaHVjFRBdDd58FSyLmjklj9+AgK3gk8HbvQ17mQ/dzI3GSr6LWeGb6/p22DVdhwyz/ztOBC0bA8dbVjPYHIgoY/u8JITz60c4SChOGbDOnTHWVUxIl6AmemWOJ4ihawp2V/9rTKELVKyMq9N5oH4OS2izgbCjA7HPTtlX6VhucnaEMz1RPMbkAbdLX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FI+mD1SJnccOw4YMVcIeguPUB9RpmnCZzHLYU2hgFqA=;
 b=qwOvKYRZmwqOaNKNRKCOG2yuLhZxK9Uzbdeh8wnijXOpIk6eOHbCTf8tIwkkWo6jYnZcYHCYh47Ym41A5VZ5q/AodiTZ/XfsqV0qcaXy61fq4nah8euxDp9ovkWJRrVxuZvj/LlBymvaMYtRo3/7lkWC1JYe36dy1yD1y3c9fd4mba7vEMZQhef3LvvmhkEqimSR9sHzIlvF+yubXGoDeyPzF1dvyL/7sdM4653pECrH3APAVywfT6YUf8fGyr3NhKXjlDmfEYqHFAtuL21bxjvxAf1J+A2U1O7qB0b1tSz48mWgHG85Hiav9tPWknpmxKzN9XYC7zj7W4Y0Q4hp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FI+mD1SJnccOw4YMVcIeguPUB9RpmnCZzHLYU2hgFqA=;
 b=KXtqc3Jv8HOjNTwgE5bnpBXecu81/ejaiiE07kKPmecgWzBQPjmvBItR/Zk0EsFdXoDFNCn1ikDQVB4YabMD56LG/Y0m6WlqDcK+hrHJgoQisamYhc2RJNNymhBs83esp1+OMp0cQGHbiLpzVM+fQShE9dpJ6lTosYpxALuK4nt4npnz4IT122dNUNA3/9E2TY9/Ii3Gc+/xVXpJPnbmMwIwjRX+7Umw//cv3t1NCj/S498fJB5mXvY7SfJs3L6qlmuMOLN0lvEaYvVrkyy9WSuky58FDldLBLZ3DxcjlRpQkZ0RNz5gdC4HYVhQFPERqJMQbXSAg4dqmypQLzB1Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 16:34:08 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 16:34:08 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH RFC net 0/2] net: dsa: felix: fix VLAN-unaware reception
Date: Sun, 15 Dec 2024 17:33:32 +0100
Message-ID: <20241215163334.615427-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f6d72d-12ff-496a-7963-08dd1d264bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y5ecldhgyRIowGZA7l9A7J2iH/zi6RL7Haxydx9bWaf7m/F59dz4Yl5jAJ8H?=
 =?us-ascii?Q?2464z1ebOe76zxDEhjOP64atI22LIa7hefQtgAuUPsr1uH6LdtC4297gByFC?=
 =?us-ascii?Q?cPLUr3Db2pgMCSvNf8AaLOrgtcHJiRbVO/NubHmPQf1S5f2ROrAVcRG4YzYu?=
 =?us-ascii?Q?+ALqvYf0DafwdOfAEcf9JSsEjGCFAXTvIklEwu9jM1xMzNDqx3e0fFX8XTSC?=
 =?us-ascii?Q?0rehZwwVy03DOy1U4jk2O+poiwGWM3S44k+qIOtkS908DO0wXkvIk0e5qkh3?=
 =?us-ascii?Q?HBG38kleDOEKzFPpFWj+LduquFkcGUEs8H5ge65MQbOreYlmMI+QyVgUEFvU?=
 =?us-ascii?Q?Lb1QhEa2AURMSJv04r42/gfEzpvR6rcNnEkpFV7ry06+A0fR8xpVvAHYX3m0?=
 =?us-ascii?Q?YkOohoS+jw9hAqEnPaa0qSci1HipZHwjcyfEfcd9BL9Jn04UK3oToeZlr+gj?=
 =?us-ascii?Q?ewOGjc+gsOW6QawhPlTfoRkXjZZn2XY+4Dpy1PtyvUSTpYJQKCm+0KpSqrcY?=
 =?us-ascii?Q?MWgtzsYnoLQDb65Mv/DyDPHwl/5W/fWW7WpX4tS/volgokzpKu2pdn/F1cru?=
 =?us-ascii?Q?rCDO8MMvZUqI/h+x81IbzM5KoG0jSw2VDeRGyIbMoUuM0jJZ6q8NZX6Bsu0G?=
 =?us-ascii?Q?+950iYgNO/13zLrnTo3vXEtQcf7X5GgJrORVC9tDg9zpvHZza2N/rFBac/20?=
 =?us-ascii?Q?yN3mmzoMn/RC4WYD3jklQJDe1VeXbIJWr5G8cqpQOvgmRrplTIxf5O0Yfpw0?=
 =?us-ascii?Q?bfKKdStKvRsN07BBTx86oHFd7PaIHx/HbiXI34SAwYkL+PR5If4xkG5SmbkE?=
 =?us-ascii?Q?MOOHzqUgDBPzDZBcZCJEGUIyA24KFxKV40G0N+0qj0V31kh8HsJw/iIcarPS?=
 =?us-ascii?Q?OTf9J5xj7DAp83iCX2mFxZJQ0WNIYbWzbPCicJa5ZJ+cV8jBY0A8iRPfxf6N?=
 =?us-ascii?Q?BxeS6ruIf4RwSX3lbVwkjJvZ3q1s2qM4n4euq0JuegsUPoPlWILaJSJRwpEp?=
 =?us-ascii?Q?Duv2nds2lkO/L4mSqSGx1UWnn6jAVk8wDlMK1biAiZE/NCr1y0sUYwg6Jx4T?=
 =?us-ascii?Q?mHnaEESgtQKQVByTEB3Q4RFIWmrZ41S4P0A6us15tpXdQwOzlIspRNSohk1V?=
 =?us-ascii?Q?om7337iKHrV/ufX0aWL5GF3vYVvxQopjlHbe/iS3Br9EoX8MZh5J9F0I1Eh3?=
 =?us-ascii?Q?S7vZ2xqEkwDv0uT6YBEQ0aH+GcUdM6Rg/4bWH8RHXLTKbtJ3vrc+L8cZdu3N?=
 =?us-ascii?Q?hBQ/Rsz4WGniK2oU7FiAiAlbe/nMFbuaLzF93ZCQruAyUbvyJD90DAOKMVU0?=
 =?us-ascii?Q?DnXGkWns7J/Cogu/ZULzXPA4QszGpxtxm8SPgrIrnDz9aB4loahuX1OEfKne?=
 =?us-ascii?Q?BrXHLfXxg/iSniwDC+Ej68uVbO4whnPbXDSbxSsKQZZKuwGaJY6EO7Uzchej?=
 =?us-ascii?Q?b8umieeZDW9NlAT331adqwcMrAs48ff+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1megUcQk4PhvvVuwbDkV9GUUCaN2ar4RhU3PHm8jxeCx9WG4s7IxGm3vC+MS?=
 =?us-ascii?Q?co33ElHUaLmJUJvN9M9ALrqWUOcVaHBt0FT8Udish39AJS20rIkPFfpJY21A?=
 =?us-ascii?Q?kYINbKtky9/8jE9WqCcASooXwUpsmlvUAAvKDwCk7rTn6owilug07Gy3taq8?=
 =?us-ascii?Q?5W7nIh75f3m4eQMb/oef8frc86ak/ngMVQ/xr2/hoxBJ7C0l8LPeZLTViCQD?=
 =?us-ascii?Q?yafZCu41iv2cpM9sSTGWK6ssLqmAuGY6cHBTNRC3z+kqujmCHdCPCJjTvySU?=
 =?us-ascii?Q?H7QM2PVcjfMBsuvbqciVL3CNnNoopgYDYs8yDb6CmkN3cALArJgL6JNAdqbx?=
 =?us-ascii?Q?8QIMiRmcB9ylZJPow2ln/WuIcj/InrAddZLchabF6O3k2t6Je9g6+STEoGce?=
 =?us-ascii?Q?saq04Rb1+SW1pTbko3MIZVchkqM2fYvn9BkBFcXDNYbhhli+/POykfXh+/+K?=
 =?us-ascii?Q?RxHGvVqxkn87c0H/XNAyPP2tZNBvU9f9hZKmI91s7P0MLcuCqYZ85HDJrfRX?=
 =?us-ascii?Q?fuhtOv5T/sFZGfWHzgC2QG0qrzH5dj+EKv4oD9aHDMNH2cbwj0nPR0psDXAI?=
 =?us-ascii?Q?LJyB/8PGIBB9gFBOi5x2yoXdTW+vYaLu52jG29waRCWykk/sBIrRB+qR+DTA?=
 =?us-ascii?Q?D5wI0dgLy3W4wLN/QPt0QgylqwbvYYxhtU8+HoztnlOoD7pmY+8SnST/8Ol+?=
 =?us-ascii?Q?CycWpCEy2tkRFnJDRZuM3wZV77QSPV0QMqRXvy3zCZhQcKLHe3lMgHh0Vjdo?=
 =?us-ascii?Q?auaiMS5+jjBF4dKmOQLSt56sgAjBxdxg53qNHr9TOQHZm8oenoJMrmtjBpd/?=
 =?us-ascii?Q?ECRicw1pEs/8CsKA5faUn1XcE8OFEUNtH/LuCTdnBiYMyy4sdnUKgqtbZWAg?=
 =?us-ascii?Q?GPAvFwKjZu+PoRgbs5GPzZDxe9q8KQNiQlB51bRiHkfoKyyYIXTf2yA5xZ09?=
 =?us-ascii?Q?PcTTPetX40zB3OEyiL3K9i9a82/ohYGdEwLdSvCcK6utQKf6hQB3m0FNRv6z?=
 =?us-ascii?Q?F+ie/VKYi+LJiqUkf5yNGeiigLq1ApBviLa51bR60kor0HJInJgg0cCD3Rvt?=
 =?us-ascii?Q?4zZ5RsCCisLcmNgCYFagrqYmJIlms1t/fibV5e+09wvOBNyNMzfIvc59o9cc?=
 =?us-ascii?Q?Oy51+yQXw31l78LfVPQhl9Mm8rmaXWLTECIExQ43529P0i+g84LRTuaccCao?=
 =?us-ascii?Q?jZE5Tr4Jk3Gr//yTEVJmiiDlrN18R9wDYWlOI60S7oeNOGGnJmGjGWPhpbGR?=
 =?us-ascii?Q?tnuDN+3V8dNmpGZnWtbqWrZ4PyH+Qg4RdoVEyBE5sesWQQ4ypgw+fl0Zf6W4?=
 =?us-ascii?Q?HQnEZ8/qM5licX4iSRgKxW0mB0bZXrLxg7zcGriiyGTjf0ku7q4xBDtehrNz?=
 =?us-ascii?Q?w/JEFDb0ZWdcsTHi1ouoZ2+XCDO+H2PvWJO28kRi/SsGurNl2U7j2mqzBR9h?=
 =?us-ascii?Q?M9rfPDgaWyYs9ZhTV1lhR4iUbitiVMWBH+Gis9VXch8Udo0/QH3dpzTr7w+K?=
 =?us-ascii?Q?pSUAnj36YrG5v957pIkfljMgo5Nji0RzU7akz/LnCQs1bR1RRiwt4sub3SQJ?=
 =?us-ascii?Q?zqb7z5lsO0s2pxxDwD40ub1V3rsX9f4n66xxYhkL?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f6d72d-12ff-496a-7963-08dd1d264bf3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 16:34:07.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Md6RdR/AShTgmWrwcCx6C0e0ZlOdbAwOzfM+ckjKfa8zklv4dgmHR6nGS2SW9tBONtxNg52inA0695Zv4fvqCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-BESS-ID: 1734280449-105299-13407-1828-1
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.73.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGBmZAVgZQ0DglzdQi0TjZxM
	Ig2cAg1dgk1TjNwDjV3CItKcXMwtRYqTYWAKxYlDxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261133 [from 
	cloudscan21-55.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hello,

This patchset supposed to fix the currently non-working ocelot-8021q
mode of the Felix driver if bridge is VLAN-unaware.

As can see in the commit messages, the driver enables
'untag_vlan_aware_bridge_pvid' to software VLAN untag all packets, but
tagging is only enabled if VLAN-filtering is enabled
(push_inner_tag=1).

Untagging packets from VLAN-unaware bridge ports is wrong, and corrupts
the packets.

It was tempting to simply restore dsa_software_vlan_untag()'s checking
as it was before:

  /* Move VLAN tag from data to hwaccel **
  if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
    skb = skb_vlan_untag(skb);
    if (!skb)
      return NULL;
  }

And so untagging only VLAN packets, but that's not really a solution,
VLAN-tagged packets may arrive on VLAN-unaware ports, and those would
get untagged incorrectly.

So I added a way to mark ports as untagged when untagging is enabled,
and return without altering the packet.

Robert Hodaszi (2):
  net: dsa: provide a way to exclude switch ports from VLAN untagging
  net: dsa: felix: fix reception from VLAN-unaware ports

 drivers/net/dsa/ocelot/felix.c | 9 ++++++++-
 include/net/dsa.h              | 7 +++++++
 net/dsa/tag.h                  | 4 ++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.43.0


