Return-Path: <netdev+bounces-302017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sj1cLOVPPWqN1AgAu9opvQ
	(envelope-from <netdev+bounces-302017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:57:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A906C73A8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:57:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=twoYhD+r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302017-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302017-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE87B3119FD0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E083242D8;
	Thu, 25 Jun 2026 15:54:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021117.outbound.protection.outlook.com [52.101.65.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99415313E03;
	Thu, 25 Jun 2026 15:54:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402879; cv=fail; b=EC+f4FauKLVFuxWebd1TKYfUr1L/wmvIWrIfoYXibjj26CAfO5+18kB5HUrQJOp3LA055KWdzslD/0NA1smbwS3LUQhq/NnXVzf8uWRBQ53FyTa/u70zjjTLtzYFWUo8zSVA/bTBlMbRzsuy4s61yJhLwOk11eyBxXptAu/4e34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402879; c=relaxed/simple;
	bh=sfK9GPZc6qrWtoIoDWzoAN9CWsMSWc616mnRwN6E9jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPso1gPBJ4qzALnphiUZEhI6wW25AIEuPjT8fHBtn6SXzevNM58lWc2nrsptKlnYluIGSOXY3ZfRiJ4gl8Aj+shGpapUgEIQ4m9zAWyvr2zIjheDZ58Shmg1S796OezMfpccnvyZHCyAdvTm80cZOLRenMSWle/oZchgnqncJGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=twoYhD+r; arc=fail smtp.client-ip=52.101.65.117
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHdW+potSge1inBuWcTdXLjnHPzhT56v0bFKdFA8P+90yXwg/1x6tF2YmVnilZO94M/CSy0r59/Ded5Nl22ChpbolpBigr1oDDhoMogC8jUeWxakiGCmGxGD9NFz+AixOFgYUa+YR2rps0uvhV/Jxhrev+/BSKxGiS8voYekAhjCu5ywi+lcpjY88plYSmqGTGRG18tNEPqqFMbFu3anP0U2AikXneXVb0OzrrVqpukh/xwuXUYAY+SBO7CI4cIIOgbIz89V5guIjKjHLWNFleQPfMR7tetepcT1AFQ5HkoukSHGlY45j+m0lCbloKbeqATMhWW7IzXMQY+c+Js1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1LujQxRvPR8YzKlZEVHgsAJ/Ge2B1QOof5C9BfQkAc=;
 b=RPuRwAJ1VemTqLpbgUYTlgtxSboLjRYUhBNcMbKa5F+3UR0vQ9pyR97z7D0/13IfESyQrLl0K1JDiMBf3a4THPtJkstKFi8QYgUSlxiwqvVkUZ6kYbwfz7872aI2YZK7IqsZXbIGKGMnYHBb+DY6414hUqlYZF8IF3wrBnpQhv2v9zb+Q0aU1JL1Uuxdo6NMuFkQCDvIBC6Vc6ljsWRoKGMZiEMp72cd5+NsqaHCtvxq3ncyJViQNZ9wkIilyG22oQvp6S3OPEQAl8Jy0j6G4ZbGNHlranR5klKFQ280WLm3dv/0s/tkJMySqudzOLLycOSAxq61Im9BjoWeFzGUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1LujQxRvPR8YzKlZEVHgsAJ/Ge2B1QOof5C9BfQkAc=;
 b=twoYhD+rWFSDoB5xTN1uYzdEGuxSmVGWxQGJ5v5xMkRQ6+SAVB8+kMunHjVf80xpi3OnmsALE21YTObnbe5aQE6WaD0KV8EUYCDvqa9KJi1Oi/svoaRZ5W3h3BgyILOhDCcAHx5E59cBIs1s3Ak/OC5aOm/l8KT8pIiGTv7a7pBNdJPiCwkAzPV21N5r97bMglVLcF3PYoPK41pKdu/CKA8PdGc0AG3WRXz9kQ1XjJ7gfjuTWYw9dQVIU2HTWm4ZUmPCrzTHMO6g/YMitc6IuPFmqUlz1Mjw44rOPBiwIXadNwdGHjcKX7t7w7tTwpE8iC9TIxlrlFJpvQdfXjnVTw==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8043.eurprd08.prod.outlook.com
 (2603:10a6:10:3e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 15:54:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 15:54:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 2/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
Date: Thu, 25 Jun 2026 18:54:14 +0300
Message-ID: <20260625155416.480669-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIYP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: beacc4be-b9c7-4ef3-088b-08ded2d20b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	ofBRllI/OyImwpd4C3UWGxAe2bjR+e848nc2w8rELwSnEPEPXwLU38+lr43VFzZq/btDyE3p5dyhV6IWi91fYNYQPcVtAyUzaKpyqUMLCWwKxMySAqn3721WXjjZ3jceJZoyp5fNcXU32bT0RY+hrhn/AjeBRzyPDvMH2/n8W2humnVgVHXWRcW5sFvBEQH9VPXW162rXFW/hh0W1MIjcs0luaKH8+p7hx1VUtHn89KkRdt1c8zIksAL1rcilxbjgFzUbC4Gz+WpZqH1nSU5R+gu5ZNZmZrN/85Didp6OigAkITASLpTEHXDGuSTowKNZSniJR64GwF3aH22/Knx/xtQb4yyhLaOs5p6SH9GcoY5U7F0L85VXxlq/TyW39vr67FhMuoRvP5u9E2XkxgDC89CSF28zdjf2PZ89Ypf9COrd2oUT/zT/I54Gd+RD0oSHcDROA8lgvWeYXJaYrn7+WBhq5IiOimxa5+bMVg7WXYicVIJh6AqZ9nPhhb2Sv/WA6mSyZM0NDYMi8qWsJnPx7qiz6qZJPaZEntUAAYNwijEOLS1T2hSnh+SwhxlbcEyB3xehRnXNrLj2Qqk1o+SPa7YoeuuodhTNh/gLcrtAu46DcuIuzNX6GSust+cXTKXY6pwZUym1YDeqV1sR3EWTJwJhDlIOJw2lcjJsYdUddZkJnzrM8nEtfGubfp0DIcVemQ10255fSQ24YFk4wb0E+QeVAVsYas2VJwyP7t+3Co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(18002099003)(22082099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFxDwZBY0Sqg5EVDTnLBAf2jqZzHUpT8qRufP7mOGXwswLLCdP3yj10epYvY?=
 =?us-ascii?Q?dLxwkuTndfQEEIrBDPNUNiqLsxS6TKGm8oQOJ4dZGtW/oLd78Lkzjx2r6sPZ?=
 =?us-ascii?Q?9kgBBxEcpyMzvNLXhibI7SI7V79tmKV9xqmIouL7/iuGebEvnseukTZOx4WZ?=
 =?us-ascii?Q?z+HrPq8hqailCXY7N4pe9p3VhpaxXZK1zoPgXVvxHKzyYikaUfr5VYGbskdb?=
 =?us-ascii?Q?6w62oAi6t8HAq2kykfKiChYmROaps/9izrXInLB+fPHP5BvXFYhgPZnUXO9y?=
 =?us-ascii?Q?M5yCWqodta3JEYBeO8B/66OTnJwX9PFCYGuE9h4dujrhVse5OcqrklfcpEyk?=
 =?us-ascii?Q?ML9UOY26pLwkMAZVGzqCCt3n+surabvY427YviemFZNYFYe3m1F5i4BH+Rn6?=
 =?us-ascii?Q?/GffmCGIOdVs4eSdMGzLVWMvIFlNSVsvwLiqateS4sVO2vcCwdyIR7w/PdoI?=
 =?us-ascii?Q?m+4c2bcUDIHy8v2qS8kZl2eA+3/E0UNEtTkhh+fX4Rs9wnQqg/auhf4a9qpB?=
 =?us-ascii?Q?z3HFLsBHr19qRigrWcJ8ChzLSj/NtYPg+M/w8jHJmYTdPRkVEcM4nEUI85Fz?=
 =?us-ascii?Q?NNlWxav3z0E21ng6rPxwBvEiBDlPIvYD6rrg03UTdkKKG1jz0Y4V7xu+AS5e?=
 =?us-ascii?Q?vC2hPEo897ai65Son9Gqtj4ks0MZ19G9bjIc4vQLmLZ7k8iJ1aMgOirGkaAN?=
 =?us-ascii?Q?+t/D4w7y6/RLb9Myswev/phPKIDFFK3RNgDQ7ZYqgfrPiTKZKDnwVHcqbqyK?=
 =?us-ascii?Q?DXdsTUZ1CvcFp3uhqRbCum/Qrajt9JwZRkFbefBHFUB279p0CCHGo7Wp66xW?=
 =?us-ascii?Q?WTTVZEzhM/7rkm5P9+wdBCEsVuyQPNAxLxcCXeRtsc23DPdl4x8KIUPdDnR4?=
 =?us-ascii?Q?nvTHkxJEplcXkmnO2FFSASjqE/UspoDX4fiDtTwW1adqeC8MbsP1CwAqjGLE?=
 =?us-ascii?Q?8qGIZNGctmRazK7bTgPGsdn8NhLzX1pkSuSFML7omKWnmkNpeDER5cUsHBsA?=
 =?us-ascii?Q?VcWW0bOQAaKIFJ+MRlajZdPQdvHPogIv2wXFhY5jdthnMkgPjSN6wXjFinuI?=
 =?us-ascii?Q?sxQra1dQ2/SDblqJjr3qmganUNR2bC+ZFKzxxrUve+NGjmGFPmCusvlUozmd?=
 =?us-ascii?Q?Q/FzlK/zaEwmn9o7K7UdQrPdyOOTIapO5eg5yu2jDu6sZPjmnLJFZ+i/jKAT?=
 =?us-ascii?Q?Alq8J/QHxR2DLXJCpdDt33NsTC2GdQ72OkBOL6S9tWRpIB93Fa2moUF1MWUP?=
 =?us-ascii?Q?TWZ2fNdDMz4sZXlUmES7LlKJS6ifpcWv5OFdJsWe9G5P0jgPrgfASVmm8L7Q?=
 =?us-ascii?Q?SjaKRKl1KDRHEh3u+fkWhvzTkBXJJARL5AUw525s79d3FxqCrxwtaGG7Qee3?=
 =?us-ascii?Q?slx+/8QfTnKSOAtjr+jWPydimWb22i3l5NyJomdiJM4CPf6YMB11SpMJVnCn?=
 =?us-ascii?Q?jpnAxLu+o65Iy8AT6SxgPzkRRz9FlW1sZT9X2WGwLadlbeCm6L7IY/hE0Y/+?=
 =?us-ascii?Q?cQtaY/iN+0+TWmXV+Rxj3K91bZJyquVC8rl9gUXu+pT5gxccNQkDm9+/HMdV?=
 =?us-ascii?Q?xG/jG9LP0x8utyB18sQ0yh+wfzAwuhJx9NsYyAtb6SzEhjlGEn6poa+ibQAE?=
 =?us-ascii?Q?LWdiJ7VKSXSpXKUfTrdU8yuIJiIcypooHx3d94rgD1fJxkHK8zn6cpDsbHfO?=
 =?us-ascii?Q?BBvPPVbPq5OoWa68otoHzo+dD65gbRZLHE6TgkuSKun2hRlxYqp8wPFVf4/F?=
 =?us-ascii?Q?OLwP+U3g4wCdt7emCM4373gzF+TZTxk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beacc4be-b9c7-4ef3-088b-08ded2d20b7d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:54:31.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUTSVs7VrL3mEs4/sDMS/sw4SAIa+w8/2qX8R2aU1+LIXqYMet1b7rjaxGSfk0nRJPOplx2rIWVLZkCoqLHWqivSYb9IllLMl+HQhjMNvQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302017-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10A906C73A8

Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
immediately when guest isn't ready") added a fast-fail in
vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
until the destination calls SET_RUNNING(1).  The fast-fail condition checks
whether device's backends are dropped, and if they're, the guest is
considered to be not ready.

However, there might be other reasons for backends to be nulled.  In
particular, when QEMU is performing CPR (checkpoint-restore) migration,
device ownership is being RESET and SET again, which leads to backends
drop and reattach.  If we end up connecting during this window, an
AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

Add a 'started' flag which is set once in vhost_vsock_start() and is
never cleared.  The behaviour changes to:

  * When device was never started -> flag is unset -> no listener can
    exist yet -> fast-fail;
  * Once the device starts -> flag is set -> we don't fast-fail ->
    we queue and preserve during any later stop / CPR pause.

Important caveat: after the first start, a connect during any stopped
window is queued instead of fast-failed.  That was the behaviour before
the patch bb26ed5f3a8b, and we're restoring it now.  However we still
keep the behaviour originally intended by that commit (i.e. fast-fail if
there's no real listener yet) while fixing the CPR path.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 drivers/vhost/vsock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b12221ce6faf..bec6bcfd885f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -61,6 +61,7 @@ struct vhost_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool started;		/* set on first SET_RUNNING(1); never cleared */
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -302,17 +303,12 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		return -ENODEV;
 	}
 
-	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the packet
-	 * and making the caller wait is pointless: even if the guest manages to init
-	 * within the timeout, it'll immediately reply with RST, because there's no
-	 * listener on the port yet.
-	 *
-	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
-	 * the mutex would be too expensive in this hot path, and we already have
-	 * all the outcomes covered: if the backend becomes NULL right after the check,
-	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
+	/* Fast-fail until the guest first enables the device (SET_RUNNING(1)).
+	 * Before that there is no listener, so queuing is pointless. 'started'
+	 * is never cleared, so once we're up we keep queuing across later
+	 * stop / CPR-pause windows.
 	 */
-	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
+	if (unlikely(!READ_ONCE(vsock->started))) {
 		rcu_read_unlock();
 		kfree_skb(skb);
 		return -EHOSTUNREACH;
@@ -640,6 +636,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 		mutex_unlock(&vq->mutex);
 	}
 
+	/* Set 'started' flag on the first start; never cleared, so send_pkt
+	 * keeps queuing (instead of fast-failing) on later stop / CPR pauses.
+	 */
+	WRITE_ONCE(vsock->started, true);
+
 	/* Some packets may have been queued before the device was started,
 	 * let's kick the send worker to send them.
 	 */
@@ -728,6 +729,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
+	vsock->started = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
-- 
2.47.1


