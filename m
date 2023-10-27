Return-Path: <netdev+bounces-44681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F367D92E1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC499B212F5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120AF156C8;
	Fri, 27 Oct 2023 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TRNp6Yn6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6714A9C
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:57:27 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F9196
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD6KDhCkmL61xsC4q9gHWMaBr1f7G4OcEyciM2Wv74ulzy7zrYlo/zxQRmOmKGEhZm+CTE4Y7DhKhtuI8M0SBYnUl7tjifzpwpF1d7I8V9EtJN9BaZYT5aZ4k/j90gK0T/D4jxzulZnjAJ9O3uAcv40DA+81pVcuxfH1fDO72eSC5fNfnl+rJchLWqKoBPt+v/nBypj0eO5VEMrt1g3zDkoHMjDBY8mdqMlkQZTp0eq1CqUzqymYvkmiYDUrOxGNmMhEaAAH/K5h1P6J0V03FpledmFp19vvA6Gg4LUEtB4TGRIpJPZmwYUS0XWfdGbEWDSbZte5B1hYh+aDF+cf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwQXfsgmbkUubjTQieE8prbOP2GEb95d0lopckxyjn8=;
 b=bTgT6SZ6tYr9KzGd/OMZOQxK0ph9IgrPJxi3BvGBxx9zHgOTsn/cQpNrRyVewD2rmSXLKCntdkmKK4H/dA6mBreuBWm+SVcFn9Qx6AMJUC4OOWDvxFT10MKTjEH5xbujqFt9vhLnnH5CNKH3KoPu6jVChAKVWRUDxm5m2hxBBXPLssnex08F+nKBnkbMEp1aBYUzcGFIhOFJU+fpJSeQO787mufpZvTQBlucN+MC5wlcFZyBXv7uJnzha5VPjnNzBpsBtxlzRwBJ0h8NdLvs0qcTXtnGU8jGfVgThA4ZP2JTar9TJF8/K2/jh9oCyDp0iVeuYf9WPC0YiVaVUVnQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwQXfsgmbkUubjTQieE8prbOP2GEb95d0lopckxyjn8=;
 b=TRNp6Yn6EMJPOt4PJSN79zFRcxqjAnJ7+xTuK0O0ME7W9eq/gf3MVE4BQle0Bum76eWy/GS2odisfP6ehCt9Dh5cVq5y2yGhbTrVODj0tHCZFztWjVTIOdJDePe0sEOopnmGP6pDZ7+niXPfFb0pOeRfeOruzD/zoLz3Uj4A5lA4u4drPn8qGmC55S8rbUFkA3ljbpHKFGYfiEXT19qf/TE9QApdNSKgsMCGY5cfCk7dT2fWgqAqohSWLlMBMTiIWeNcKGvfVQyTSo/5xgD4CDOUnH1znKlr9PSlguwE3uturhu9jJGsGIbNFzSOu5JTOFY+T6CZtf0OfpnWIZt2pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB9303.eurprd04.prod.outlook.com (2603:10a6:102:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 08:57:23 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 08:57:22 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: netdev@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH iproute2-next v2 0/2] Increase BPF verifier verbosity when in verbose mode
Date: Fri, 27 Oct 2023 16:57:04 +0800
Message-ID: <20231027085706.25718-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB9303:EE_
X-MS-Office365-Filtering-Correlation-Id: df761ca3-0054-40a8-57d9-08dbd6cabbab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	awUiYh0j4vAV5BiOehIrwfK6ZYv0hZ6uXniXOD2o9ocIFmtHaCDEbKjSZ6GUJzto5MGV1hr9GviQ8qQjMq9d27NiEBusJ1XsB06ri53iH23nwA7ZoHeOF/N2XDaVIYxZUtWFAgoSBLqLFf8qgsLqo9cX0P5GRtQ2LvYj9XF1bOMU2XMOF/6MywQ/7vqQYgkcVB+yn2ajljmSqIZ+9+3l0f17bGW+oubFfCE9mgLc661xsH/6QhXtuV1hDQNlbnO8i9lPNQK3doMWhTKjnk24Mpeoxid4ZQ87X5xT6L33j34PBG3me3iELh0ZGSHPumy7aUXNnkL2YJ6/j0f7z8ACUaqobdThSE3AuBb9oPYBv463mkp1GTfJGh8O9i9CtZHBZLicaAWQtfR5tAKBwMaLEzKix4uXFRSESNr7s5FiBXG6Yz7hom5xC/3PkTyanoCXDz3UV2rhNyJvMdotsWGgyCRRG6D5a6IZmN50JNNY09wVbyavhaGqPTyBwLBdJ8REwQJXzKKYEEeIuaUxsb3vzftMK1kjxtON7poQhYDQRWVRvC46csUryOh3UPbOaJCx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(4744005)(41300700001)(83380400001)(478600001)(4326008)(8936002)(8676002)(6486002)(66946007)(66556008)(54906003)(5660300002)(86362001)(316002)(6916009)(66476007)(6666004)(38100700002)(2616005)(1076003)(6506007)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XlbYGwjLVVXC4pbd97+NwoUhVCL75Ku4Wxy6MqUUWKEbooTuvGnAbikRLnbu?=
 =?us-ascii?Q?ecRabAluqRJ26diQRD5j5/QTwHo0770dcg5fStF5UDUs14Azu+DXRowHx6J8?=
 =?us-ascii?Q?4PZIUpu4HqKGrJlWCfwm7nSSYyfGMqPpH56ihCcQjxfDvXjjHVN+ZsYdEdSr?=
 =?us-ascii?Q?0pPcjeD+5WNn/NY8/1nN3aUwpl2AG8ZWgsOk1aXl4evL8L0eNOs3IR1jKGO5?=
 =?us-ascii?Q?WbqwW/0TYdq7n86IRQU2hN2JyaRkzDELXyDjO5tb1RmDl/7HbxiyUHjhwdsx?=
 =?us-ascii?Q?54zNfJtpN5fLmzGZ8WMW0xc5zGNyNSmzIUvrYLB7I46o+ohPonkMHkfC1FjJ?=
 =?us-ascii?Q?1u+IHImA5tqQ+4R/YobqKfSDNYFPhychQihpRgDmrecCFPL6iO/duVUJPTd0?=
 =?us-ascii?Q?fDTanPM8p6XkqO7DSVCs/alltTHTtPZHrmfY78edPjaPzD1yGgEeiM5Qsxuy?=
 =?us-ascii?Q?tgqheU1dhYVsndk9tDj0rKOW7wsYUDlTNw76UDrzRjGpSeKT2egqZhC0Cgb+?=
 =?us-ascii?Q?ErPjXmpfUmXmYvc9FNU/M9W7FTLYRq7u/Cm12hj33J/QroWGfPz3ZQ4aDz3P?=
 =?us-ascii?Q?bsNlARLG4he5CfJ+8kYGknVuDQil5Nq9WGhjeVI/pJfqrjaNYKXXAOABBdxG?=
 =?us-ascii?Q?2lzAGqLxgckQQOqB6188u+NE15iy6qOCriMWTXd4/EsPuwpC1oLmNzrb8r2l?=
 =?us-ascii?Q?yCtNxubCW6dm53k/ga9kG/KTMIt8JDjrKe4z0IECQZyo+y8yJ35ZLbcGAQYA?=
 =?us-ascii?Q?DJCY9l1bAFbedmEh3AovRwwgou6f7bhJYFHqbtMZh6UqlkDcIMkiDuW95R0I?=
 =?us-ascii?Q?fpFduSXW6aXhCDn26U8VIKx4SjOO4om7XT2l0r9Naji+9/Qo3ZINqpTprpzL?=
 =?us-ascii?Q?jF40Q0zwN2UPmSfBkqOgkEew8BaaXhLIgV5wePJ38I9M5V3r9fTQjW2k5s+A?=
 =?us-ascii?Q?3rVz/x2KIWLQwR8IQ8I1sfoMnJcQ5c7MQB7+ImS/69/3xL0JabGHcM2rBR1k?=
 =?us-ascii?Q?mgtuVXzMCr9g6CqrlsymGnkYa18WPsoeGVBr4cfuqqhditPSstqeqVGCxiXg?=
 =?us-ascii?Q?6pmH3FVXINzeTo5xkYrSxcLCU8K81x3s6ZTewZ/2Jr18UXQJsDSvUNSyjVrp?=
 =?us-ascii?Q?dRMwEEyginHk6ZPP/QBFMxBrtdDS1Q5Achdl6Wj6HHJVH5zlQ/y3M9PksX2K?=
 =?us-ascii?Q?/S7Z/fMv/faD+WW8JHbmwyzlOPZLgH3OQllkMLpObNrzEx5pMKY3fxPhrWnq?=
 =?us-ascii?Q?JkalqnMvgM5apuVPZAjL5qta9vhtx3MK6W6HqNj5xCY8XTc5fTkaOhRe1BTW?=
 =?us-ascii?Q?eSa7RHmTEA01WS3aDYuQcdUIlesadDxZwFF0k1ittklFNyLjTs8y+O7dCSy4?=
 =?us-ascii?Q?UmZZEPBWF9WMV69S4EwK9L/CXHREcXDTPQ38+IRvD8yO2h3WXFs8MvlTU0on?=
 =?us-ascii?Q?f3AYCLuNXhVbpZpTEEdjz+5Ymjb6uyX1fOUU96fYkZemNQrJRAplrhdbdqcC?=
 =?us-ascii?Q?BA7KT1p3bFiRqno2IulFAEErtcMtQOU+pSFWElfBQRBugCj+2Jiq0LyPe4UI?=
 =?us-ascii?Q?rip/08y0CGvVzvkVyEIRQxZl8PXR1MrJq6CVRx9/zqbELS+AwZH6LVt477vQ?=
 =?us-ascii?Q?Nl8J+LNg/7yprDNe1ytZjh40OiAyfZ4uRIjZ0eRZap8kx3ACm6DUdtGwZEdD?=
 =?us-ascii?Q?s4ZP2g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df761ca3-0054-40a8-57d9-08dbd6cabbab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:57:22.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrc5SAqYomOqtWwsZYv+MKmYuozHVjTWRkydLj+9O3GhM67QT+K1KAKrnxmWfv1VsR0msXynFmgY6NyFfzLurw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9303

When debugging BPF verifier issue, it is useful get as much information
out of the verifier as possible to help diagnostic, but right now that
is not possible because load_bpf_object() does not set the
kernel_log_level in struct bpf_object_open_opts, which is addressed in
patch 1.

Patch 2 further allows increasing the log level in verbose mode, so even
more information can be retrieved out of the verifier, and most
importantly, show verifier log even on successful BPF program load.

v1 -> v2:
- move setting of .kernel_log_level outside of DECLARE_LIBBPF_OPTS in
  patch 1 as per David's comment

Shung-Hsi Yu (2):
  libbpf: set kernel_log_level when available
  bpf: increase verifier verbosity when in verbose mode

 include/bpf_util.h |  4 ++--
 ip/ipvrf.c         |  3 ++-
 lib/bpf_legacy.c   | 10 ++++++----
 lib/bpf_libbpf.c   |  6 ++++++
 4 files changed, 16 insertions(+), 7 deletions(-)


base-commit: d233ff0f984a1f9d0b166701b19e1897b05812d6
-- 
2.42.0


