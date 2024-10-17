Return-Path: <netdev+bounces-136709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525829A2B45
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1260B285B41
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5776D1E7C2B;
	Thu, 17 Oct 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="dRwC+kG9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940D1DACA1;
	Thu, 17 Oct 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186949; cv=fail; b=Csyqg/FK8R9bf2qHmy07WxcEyJN2i3IX+sjUudmWL2ycoAnDlW7xOXThdxcCS0h18Rwy+YVMe1VA025yk9JZOVoShDKi1Ii0djBnt+yBV6mLvOoroZFsFLUEKjPTRWb2cPaTpLqgZPP4SXfxahhzUT3dvP/9wkdmtfcTOoX30bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186949; c=relaxed/simple;
	bh=JfG1QsWhuGlOr4RAim4sFuqX79NyiKi9VBf3jaAUTjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KsHxBd71XMw66NXSeZ276OxuqQhkxi6yqtBiURmSA0Xd/rANcu5UiZ2xW+/uqhRp/+YzGI1MDJaRm/eLxA9lNOn23uFdYh8s+RuAlSLME4aRH6Yt7HBi+5XsbAWoeCuO7oxiajwwX7ErjK24mIfvcZnC8UEMfQzJ5QQ1moT1Jws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=dRwC+kG9; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rx6PyaDv+0r3DE7T1boiIxtvgctVcFUKBy8HwD8yonUdVY6vOPyuX8NW49DQibnKfgXGIoOT2IGRs0lxhegUMOPsunL2PGcBJCaw6Qt/JEH0D3m9lpD0u/aAkpoiYY6D+I9/kEMbu9yunKDbgSMMTGoZp8kyOcCtYBLZuENySgIQ6MhgcNNdhtfPnTgyLvSIa8xx2Sfw+xBTQyCew8d4q1tZAlnMur+R+GO+p6JF85KPL4vEY24eW2X05Fs2iNJ5li5WTyTHRZY9srntBKc4E3haQXoKFm+5aF0LBfVyk0/o7g46KL9wELUxA0MMYEyltFsM3AcFbSwnhFzOXwk1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrIS7wGESh9C8aRQhIZpXsjnwm9dkno6LqxzJFrTWQc=;
 b=ZcQjNBveOuYXRcT69gCJI3IAiIbKbhofpbAEz3vi+iy1ijse5xhepFDEbNQCn02zt3wM1mXBpXvkrshGPvlRecd+GkyIFfPAGiyGXYs+6KBWdFd5vnYxRfWVv9JPBuhEPAUh+SctapeUcuY2qgbVwO4EEskV1JI7+goeziwqXplZCNMeTUheit6izPWZYlyfuhiD+QjgXBcPJ2scQE9zhBVsuhAecQNj2XAqwi966VOCwfxVw42TlFfOj3OuxaJBtYtND0m2RH8l3LZe+ypvQZGN6uXKw8vlGgAyOYYD09Js7WJjydFTL01Z+tmMzNmObiy9GSQCHpIMXi8ESH98dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrIS7wGESh9C8aRQhIZpXsjnwm9dkno6LqxzJFrTWQc=;
 b=dRwC+kG9hAL9QcuSUfHl166Z8D7OuAHoAf/dVp7J1c4rONuzV3Eokc6/66O9WPIDuzxlCdThharhgmU5sgEJuZ7RDVdDM2qjepNkRoQ5Th6CT41YLb6WKVT4/2Y3iV6R04fF4K66jotF90YsYqLPpm3AMZxedQeAoUU0SE05tv80M54Y6e7MB8KEwbqtW12n9ALwgTgI0NxEmHMG6vzHlt1X/W4hr/H8Z7mi0TpAyQU79nt7I/bnL//UogcCM/tQOKNHSfPm1kwYlAR0umaRhYjVNNhFoLx9pnZ/QL/ZfoMD9UKCR4KhHZH2G/B/VOy4bFWJY3M88GpxVvx8oGFBvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:42:02 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:42:02 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 10/10] Revert "ipv6: Fix suspicious RCU usage warning in ip6mr"
Date: Thu, 17 Oct 2024 19:37:52 +0200
Message-ID: <20241017174109.85717-11-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241017174109.85717-1-stefan.wiehler@nokia.com>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 3207dbc2-4e7a-4fb6-4d03-08dceed2f7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jPxtToUBOr78aKCEr8+OD8lpDk4LdJbKB/QtS0hD/WhpN2PScMrcE8pN9x/T?=
 =?us-ascii?Q?wF63Co5drSz7NvER4++eOab0O6+Ebu9cBlpmmXiiH2dQL8KPJUT0PJr+oybo?=
 =?us-ascii?Q?lv7Y0qhHRv8gtDG4u2Cd/LNKYfH9EJ02/H8GyEKXY0gx38CCDu4aiPBpUbVF?=
 =?us-ascii?Q?k5bqi8v5qzU27LvPYupqSQkeM01+E/wqNGLhAfx6i3og/PWS+cAO9HElGJCe?=
 =?us-ascii?Q?vMsvCWDmVkQ6hwB4r//H7ClI6wNfDmI1xycqP8My1GbzDWcy+TZ6wzbFZq6U?=
 =?us-ascii?Q?CAMax41agjLP2VcQHLiCx2EydbDMVabA8y9iIpV60BZtFM7uZZUxREqiYhu+?=
 =?us-ascii?Q?w6osyxMctFrn338y0pTN9kdTvlrDFSA25fsl43AH15XjzlnoKhUcu9ZrWT+s?=
 =?us-ascii?Q?zgILxNUnsh6aPjAa1/5SwSPdQIUsXjyCQLvSWWWXY+JerlAD/cvoKN8xfbTO?=
 =?us-ascii?Q?722j3lcza5dRe/FRykjz53u5x35GpDdGTrCTs2LdFC46/Lfo7busCV7TkpTC?=
 =?us-ascii?Q?k0uYYlCQP+ZpBSUyYCWWYSrYDeDuAlAzR0OmH9ZtX1rb1wbJl80CfOJ29OYw?=
 =?us-ascii?Q?/+0Q3CoDp3RzrP9UEYrRa0jPOv4g5IoYC1LZFWPHcINKlwGEMzT2JpZFXdb2?=
 =?us-ascii?Q?IOHby6Jk6NKIzOTU+5NNYmCPJFqg7+XqSdZiIWSsSJmDpWCHVi1+3sZDGSvZ?=
 =?us-ascii?Q?WzFKLBoVEyplAvkNHskNWC4LKFnB8QE2CyruK/QsHrPwhfJPs2lAgwVtjI8e?=
 =?us-ascii?Q?X6sBMiKTEp/Dbz7p0bLFzUKJoRT5ZIrlvaxClm4oQNVprvAxtXCkXkV3LFN3?=
 =?us-ascii?Q?Q80rwUvhg6EnxKNHRB08tq3Hbr9tJZ1i2w1+FVvY/DMs+VWa4tr9DEmEVUYw?=
 =?us-ascii?Q?a9Xkwhp2gOw2ui8gvliymigzZyu+DEpOLuviWi+Czj131krF5PM857tIQeZL?=
 =?us-ascii?Q?jBNL48omleAl3J8fR+WYgySjiDXnU/OfUo1NgXRksyILlCIGwtJXEDXkGMr1?=
 =?us-ascii?Q?04HUJsmwoPVX05hTJKJsnJNobLQwv4Oi3Xhd2F2D74JUoExx99avPrCcK6GA?=
 =?us-ascii?Q?xCc0jG2T7ai7NxAVPFyEINxqZ5Fm+3a/aIViAQNxeENctlEFOQopssQJBlP1?=
 =?us-ascii?Q?AA7Ee1dZhE6iSir7ku25Ippj779X3qsM0GItsI647LXZZ0DVHcvTQIU5wSgv?=
 =?us-ascii?Q?hSCyRuPLSe12TlhiI5Q00hZDFUOQ46CEEoiNs3TIehJr7kWdqM+GmaAjHNSS?=
 =?us-ascii?Q?UvnS/uoTHjIvj7UJOVO9x2+XlX3q0uYyAdjMafX0bkKNY0XfpzszihwPiofD?=
 =?us-ascii?Q?0/ZPLYCqOdqoa+qmlXDuFYOgv5gyB5WtZdMTH5/87NctOfKmwR8X3e7jhDrg?=
 =?us-ascii?Q?vrLPAUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3bIeCPUn1/n0VK89MpoC4ufFFWjoZ7OJJ1nnGj3NN/vRh55wmj5IJipPW/6P?=
 =?us-ascii?Q?N79lIDBiBVK6nhmFVr46jURQZYgMAWn5FepnftxyO+4CntazdzaAl2RD+Lfb?=
 =?us-ascii?Q?P9gl35zibbdInwQ+ehP6L6/XHDfbZM8VscoNsolkb0mPikymdX03HhrFaf9D?=
 =?us-ascii?Q?wG1r1KeyPzvj0718VXR4KwY+LtJampgKV13lDPmUeg0Wrg4V6yD6sDkT7Ff9?=
 =?us-ascii?Q?enB276OnqVbDiMBYRBfmQFNd9TrLnLHqKg2hfcuNefhynV4CfU6Smna/+fZ0?=
 =?us-ascii?Q?xsG743Vb/wIZRC1toTr7lhKtRrLtvYVkLp9Gl3jsr0EHjPrssP39esj5wReS?=
 =?us-ascii?Q?8kR7M3nZRueXxk5rj0P/hMM1ZYhiFGBI/65SV1lR+qOD1g10V9KV139kLJk4?=
 =?us-ascii?Q?T7+BEaA15f/DfyZfZ0DGf0VWOZmCpD7TMXvMr9lsQOsVkxkhxzxS5kMWHvoq?=
 =?us-ascii?Q?2I/xP6xY0Uj+U83GFoU+AjTBorMR0wtZ0+AFMcc7rZZh4YZWi1rH5mEyV6Pi?=
 =?us-ascii?Q?6KrSndE3ZNTYMBid2MTjEoNcwUO7GJa5fP5NN1q8PZZ71DV31Vb3R1hhJX8r?=
 =?us-ascii?Q?zY+9l4u7TFqsbD55nBec494DPVJGI5p0efXpKTTXvSPhsQVp6N9IFcCeg5ii?=
 =?us-ascii?Q?UlvsbkNwMZfr7d8Vq7Rb2jKJpax/c9f+KTH/qBYw7gdTiXP0qLOb/rnO8lpz?=
 =?us-ascii?Q?n2RX4DPAvAxXUWtTBEg/4jeRFmRV8PJ/96IMkbH/RmqPY++Dp4uq7tsbw4t3?=
 =?us-ascii?Q?danLl422Z2Vy6wpfDHaVyoYfoRd95gmkHLOpLnQEXDiywTQYVeS0Nd4wu+4F?=
 =?us-ascii?Q?Y0uyh8GfbFAwEseOfYEXtIiOfjbGBGrrsoV+qiJ145fUlOOGNckuYAdpvbvO?=
 =?us-ascii?Q?5zufc8Fv3bS4OYEL4ALniR3hWHwxKj0r6PL9UIzetMCjclGSTG3SMGb9D/TL?=
 =?us-ascii?Q?OFIL1VZw1bT/ONigBKVzrJgwVeYfagFVWKNY+Kt+CkarLalTknHa3NjZbuez?=
 =?us-ascii?Q?zoYqJrT0BYHMrdCQkYlvE0WGVVRycP8wwc3mpU8AyH6oAXKYjuWtc88ZABi7?=
 =?us-ascii?Q?nqF5kihvSM9nFV9kW5AR5gWnGhbuC4VT7322wRgdNLLD944X3a8eDsnftrA7?=
 =?us-ascii?Q?wfSV1wQSlfrzFumaR5Vm3/mk7Mz4XWath9leNUtr685ZNSHpCaLAfbNfleH4?=
 =?us-ascii?Q?7Xt4iDU+w4Pd2fv6AJwHNLGTSpUQjiEiN9g5779ZLnN9XjOlAoZFr6CXRkkH?=
 =?us-ascii?Q?4fRlJa/i8jqB6IFNFxmA3kJ8unXGJxEkwheWRgecPgogUwroHWUAeC5C+pfY?=
 =?us-ascii?Q?dCvvJ7P+OwJw42j41CP5VIhL1s3x6MwsvvfNxNS7p4wTYxSftbQCmGBASXs1?=
 =?us-ascii?Q?V9umWr/CGX1CgCFLodDeScHN1Q+e+ENHeLz9AoYCPXHtspZzs3CX2Aa8xABs?=
 =?us-ascii?Q?XBb4A3K9DsURhug10DTx2nDFk9IC4Qw/yz+PIVz31hVmuDbbIO1CIfRhVwuj?=
 =?us-ascii?Q?GbOdlESevgy/3tIoU9E5ZqM2qvd7QXIsAdzx/8E8ea9vp1pLvwJVudj7XztA?=
 =?us-ascii?Q?4nJH5JH+KuBz3i9lHViyeJYG7IakwseWUIgTUiEpi0tamKvP2xybBm+Afng2?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3207dbc2-4e7a-4fb6-4d03-08dceed2f7c2
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:44.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIjvW4+h3v3HXj28Wr1XEhNYDUL6SAu5avnwtpmBtYlu6grzW9T6S9zfWyTO5kbDCizo1Pu5HB18CUjpWTBzyLyVFkU4/btkYlj4VM2f+pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

This reverts commit b6dd5acde3f165e364881c36de942c5b252e2a27.

We should not suppress Lockdep-RCU splats when calling ip6mr_get_table()
without RCU or RTNL lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 39aac81a30f1..66cf3ea344aa 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -105,8 +105,7 @@ static void ipmr_expire_process(struct timer_list *t);
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
 #define ip6mr_for_each_table(mrt, net) \
 	list_for_each_entry_rcu(mrt, &net->ipv6.mr6_tables, list, \
-				lockdep_rtnl_is_held() || \
-				list_empty(&net->ipv6.mr6_tables))
+				lockdep_rtnl_is_held())
 
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
-- 
2.42.0


