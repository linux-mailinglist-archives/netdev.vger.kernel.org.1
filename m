Return-Path: <netdev+bounces-141418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650629BAD9E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253C228168C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CECA1A0B1A;
	Mon,  4 Nov 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="LCNmWTb1"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02C19D8B2
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707509; cv=fail; b=uxAsP7db5tV0VXhVCnrvroeSOjhrb1Ewx13s19bYSZFZiTaOn5T2W+7CWlLXKbU96AvY5hbkKt06xeqYhClNkIlYZgApUPfaXkCBkn6VO501WmtQxo8IOk0MXHsjfl4luW5gZ1u03OOC6abE/XDMuWUKPq1+SesRATmzv6GzHUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707509; c=relaxed/simple;
	bh=unQClmdb7DhPMqlNnd9Q0r05kE24XEkl/yMpvtJGAOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJMFfknV8w4K5AH0BLL6+ryPs0E2bqyxj2dXhDZqrtOs50g8EDxxYY35BmQ8FAqAJ9bKoAVia7T7aje7c6I9UzhYTeNBpsu6OIF5CrTqJ7b8ZTV03xQrFDmg5fyye6T3siljKh2dvV7Y8+IWHMU+IXu2hZeDvy+C86vDsTOadCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=LCNmWTb1; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 33E62340065;
	Mon,  4 Nov 2024 08:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgR5T6R78pAMQghEYw4Aj6SdsEWgMjLSTZ6CikOA4MQqHSiT3ziHCbgH2rNziKRLMRvKV7fUQ9QOWb6vdWdV9XzHoI82C4hc6axxfGiA/+bARwFnHd3f6i5hEK3iUGvn+QYjpMafX2fI/Go+4FbulTZilWfrA30VTdIXcdEaTUXP0dCkrgo8seNhtdEE/uxlbLuLomS8CoDISrEow2WQydyaMHfuuKcLuLAJGZ6l12AEhy/phLOGoqfuEX7o6EG711sTsAz6NwfdqXLV9w/zE6GGXME1GmwPrRPQdrJ3FSRtABqujnGuBg+tliwObYfgLLnNfuigvOWOrztkmyMWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLEf7WzQYguIPSRloqAzAB+4WoiA2ddyb8jtyIftuyk=;
 b=beNgjBxfHyDl3FBhfO21moysORStoJyQ1Z6Q75+ESNKSoOPOiRWShf6+tGm4yIostN4xp3W3fDExCXjUttwH24rIcS346uyw6RXwYRXn4Nf7CXGhqw9GUHpln7LrhBRI0B9goDONj01N25ddHQQJPdyUVL008h9RkXQuBwB2ux+EYYzE7tkM6tdGCNtJV+BmttSt0jvO7oATPqujoXvb/afvQzb3QeetVIia8smbCnFUKk5yOOTwE//fcUJRjPTdk7GOnD5/RSWAyxw6X1Yukf2yTvNUjIGO06oBXHc2z12ewnA/EGyAVM5hJMyXF0VH/eOPpLGNfxjx/dkNUo13BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLEf7WzQYguIPSRloqAzAB+4WoiA2ddyb8jtyIftuyk=;
 b=LCNmWTb1qz/d4pEq1BzncBJNrD8YFhdhR6i6TVHYrLWB15dbwqDq/0sl7FhA9Rl7xDG434EOSj1MLuk2oEULJWzI8wmZpoeCSEUc/QCS40asegsLJkYSuNfuqpNhNDbqvaT8ctEY7i3GTOnfX2DCcYcLjupor4wuc29yM9FaSeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB5553.eurprd08.prod.outlook.com (2603:10a6:20b:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:04:56 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:04:56 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v8 1/6] neighbour: Add hlist_node to struct neighbour
Date: Mon,  4 Nov 2024 08:04:29 +0000
Message-ID: <20241104080437.103-2-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104080437.103-1-gnaaman@drivenets.com>
References: <20241104080437.103-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7225e6-5af6-4122-60a3-08dcfca75ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iaPXklG4L5aL04chtclWgOyk58UAZU/k2tw31gPLcliJlCu0X+5rq+ioLA3m?=
 =?us-ascii?Q?COi6RxCW70WEqQOvc37TTzsPoLJUKolJz1OMPKRFQ3yLmGPXLBXeMXz0WPZ2?=
 =?us-ascii?Q?Kho/cRMR65yCuHfnpUjNCWAMLLvE3Ym70wkI3mDj7X5mHuCtvnc8yEgy7uT/?=
 =?us-ascii?Q?1p+PpMgicjTw6hSZVWFmWEttu/Gpp2poFjwj+Bz1NrUDK3WmfA1Rk2ytEQ8b?=
 =?us-ascii?Q?ZSd75Bcd+oX6tfEO8N04ARDXIxlz5RGywgw7TZRDgJ+7SjkBzSvPSya2e3tJ?=
 =?us-ascii?Q?P5+/JmjWwYK5dBimHccvlUT/d7JaoMtEY4peLIJFrlmzSa7jzrf+0EVv1FX8?=
 =?us-ascii?Q?R78/QeGmOvUvJrEYSsQgCaH+7jUoTmEh2gSzPuIhEKGjH+bDsweprPHYg4rS?=
 =?us-ascii?Q?lshyuz2Q7W4+lXS5WKBTOuAp6Qb4PXPGg0Vn7WXjxzuFh9KNlbzlQagZmcOp?=
 =?us-ascii?Q?SyKdEZFDdQJn5mLLgeCcYWQXt3Xxc+QOtgAKYYSh8OeaqOsc3Vg+Ve6yhUo/?=
 =?us-ascii?Q?VA2YNXGVF7pocURH9o65dSnN82nJLRcr79cch5uBx1TeKKMCQNPUFsYQvjGo?=
 =?us-ascii?Q?eZnLbp2I3cSOy+8y70BKt0Zqqx8lAm0HFGORGv6PWSvm2S+eZBAeVl0SZiJ5?=
 =?us-ascii?Q?NZYJNmRrPfMVKFDUmOlS1YWvAovYk3nAJEkTic5kNIFVn530A9VPXPkE77XY?=
 =?us-ascii?Q?luDTSqLud+6/aycseDge8Ue4vGGgZXPKWN+IHetP1Vc0zT+PQCtQcoXgoQPX?=
 =?us-ascii?Q?HHR9ywmHZTjc36r4WZCMZqZGDxzeIicufByUBbJl8esQ5bIjBA2bSdLFwTO8?=
 =?us-ascii?Q?ePY19rH5cDYsblrtWrK9TI4ISkIEEpKOhzvEx4903izw+/pYiF3JhD/lCq8M?=
 =?us-ascii?Q?0kF28CfmUUxOBt6yLePgwYH4SxJoZ3jskJEEBaFG99qJwuKpIEbPALhUAfhH?=
 =?us-ascii?Q?0akXQnnFEULaAG+iIp+tpEvPbMHjejLXQ37offdX3LI0AEq3HtwgLBVN2WvU?=
 =?us-ascii?Q?O4ypYdNbNSbXu8+uOY9ypKdGpd3S0EiHmmwjx9as41tu9zsnVkqcb/wbeLqB?=
 =?us-ascii?Q?tv8SpsxVixh/vd4+1CcomY/GVGvrSdgfMKgg9hdvHn6f5HpPbFUfZP7lBBrd?=
 =?us-ascii?Q?doHLobs8rZJJgnIGCz/krTT2Ov+bxjLJKZpyvr+Krsva2HMCyc72o+gKU12g?=
 =?us-ascii?Q?wM4iI8coN8/P5gmRPR12pAOtAVs1oY2acVAwXnQgM3yPUaomX7L+3tYm96FB?=
 =?us-ascii?Q?ZGgDx1Q1qTpETn0NIwNhbqY5ORn9UX3K1GhXiOrmcigM1sAM+uKVcR9QDPPH?=
 =?us-ascii?Q?hDH0u97RJ5lc9nv6/1S4vPaa4YBU3r3a8JUDMBfrMAQ5J7xtQ731Xe/tuR9K?=
 =?us-ascii?Q?hCmcaTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nnMhkFSEFse3SGfnSec28+r9gDq/+frNh7FZO7fkyzoR0m1ecCN9fPfVX4sj?=
 =?us-ascii?Q?knenIiu4cj+coQBTE9kt7w1hkmVizfnRgB0l/Pvmo7QadRANt84jnvAR4Y/+?=
 =?us-ascii?Q?f3s7ApzTChjx8mqUgHD9glp+U3HBNRDPi5xyIRrZ/ruq4FXDiX4GPJYZCJt7?=
 =?us-ascii?Q?EjH0Q+h9QqG/YRGra7kt/QdswGFBiYOg0xMsXyTjur+WNidT4+wi3jBRMqEN?=
 =?us-ascii?Q?WBeFWTuVKa0oVgCoNi5p8V5ytvDYvlndNvfXpEMK/jTui9i9PxLsAjRWnKhf?=
 =?us-ascii?Q?j6DrM5Rc8BCWIwjU4h1vaXYoqJkuwiISOsaJj6wKiCnKUsEbhP4o0Nc9Uokx?=
 =?us-ascii?Q?TtSaBIFTS5QT/jBWGxBQk6uWbd0wgcSmZF86u7UF7UfudLRrgc2ctfGhmjuM?=
 =?us-ascii?Q?/3qF7dBQqJOI18opnfGerua3vxY1X1KINVAqdv0YfjSZS5ND9xuekEmZPm05?=
 =?us-ascii?Q?aTMtI8jiQru9ZMqf8VvgT+Iv9gjdd7X6HTMcmH80qjkLUOmXJjWbUCGBQGYK?=
 =?us-ascii?Q?1EcuD2sViF7MIqwoAeI96YcWIDOXp7xF65ENMySyVIMzxYOCoX+tF/8GnOkp?=
 =?us-ascii?Q?qWPZxkNRceHvdB8HlS6BtmafqCITPHKF/463MrdtuZRt2hXExq+2qgViw5mY?=
 =?us-ascii?Q?rmwA7D1ls78uyScL0/kUsrAqbt4CTHH7qd4lF1wcSqjYlYQgZ0FQZjQodWdo?=
 =?us-ascii?Q?2huycOcAuRT34kHU0pwpo+oi1AXxkY5rk4eNMinc3/a7BWhpX7X1TmWXgHXN?=
 =?us-ascii?Q?7KR6dE7OaEAA0iWe4j+1Z7ZGfyUKN9mtQCuHP4YToVcJn80pzf6LaZ/c6jht?=
 =?us-ascii?Q?4eoy4K4DnxwQ4hirvSBLhiRsFM9CXDxzhOG5HKz5m2JqhOmiGsVWsv1rKsHi?=
 =?us-ascii?Q?sHQ1UhxcFOHF/PH9CYDpoOHGfpDjfH2NEuDzhtUdM0jdtHE4OxCIbMfwl87/?=
 =?us-ascii?Q?8GIXDdd0COtP/d1vLruSa32J15R9wu5NA6Q6ucsOrX3kkvBCgiKMdaWuPI4A?=
 =?us-ascii?Q?P6mRX7QHsy4B/ZdIu7d2G0JJylLlDHxkSZAM5pNYRisLO88s3HmDFoYp3rGs?=
 =?us-ascii?Q?NH99cOLuBGMR/MP7Mh5CaZpCSVVEjVkR4gi6cBa1JNt7F2VWTBBMqNZpviPT?=
 =?us-ascii?Q?FB9wGNiqkoL6W7c2tZvfnCMplg5fiM8M/2KHNycIHf/TEtg7aU60ZXEFe31J?=
 =?us-ascii?Q?96Iudw+Kz5yMpWj3rOFrdvOYvqZuDC20pufF/KIhBJspQtsHBxzwKxWRcEGX?=
 =?us-ascii?Q?OpNupoK/iJ23RSLFrwg1VZ7mm64s/SWiXGGcYMXdm9LlreUIaMhyQInuNcFV?=
 =?us-ascii?Q?1YiJYZqFD3JCTh2rlQyeJcQBSAikeTJ+nxOfI6MAUqDfa3G9FyQvRFmrisAy?=
 =?us-ascii?Q?wGtoYBFFxh4AzWb62bZu6mnq2lxpY4CcOY2flL5JW8iAHCvg0TjW72lUGrv/?=
 =?us-ascii?Q?dS/nUNMISvu9A3tZJZhbTRFvMJgTy3/Ej1KrQljqJrNpGVyvyyUb9xrJMtET?=
 =?us-ascii?Q?qbu7caHzMPQxwA6Id9jWcfqOUal9MyQdg180YHaSyRhLvxuDS45e611ssLto?=
 =?us-ascii?Q?nPJDTa5JwlfWQ1t+acoVdRc7zXi1ku8IMtCfqRN6mkxJK0XJ6yigkWsQZUqI?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N0zV/3gHhcuR9F2CEM7kLeWJJ8SJt3I581hOrCwb6Zrp4v8LTujZzMPVc6alwiKuYmgR425P4LhqMJBA1mip05R9/iWiJBAnk3sa5LhXQfyVgnbS5lQSEw2kwRynms384mTLStIfhZE/niBaUUlqHY+GbXB9K7BSMI/moL6jyLIUNvA4i+B9a+Vi/1Ew5FX2w+OHGuI8ykAZewCfGJyXGvxNkNK1kHkEeuFniArfZGece2XUc1BUM+8XBxtAYjMkp/ErMrP9J6tSZsB04+2DzGqPHeVj/V9uPVelmaACz9Fj9Y/o0k9fFB8kkRQCKzj2aUnxDPpFdd6ROU6P6HoADWdz11mridjeoNHAb/RXX0xh1jQqzJz5aid5NOHpzF0CM659m/YwAYq7AkDSM/IXH/ffrgINuNA1JuvhFNYSZiDG8R3grvMqn73a1LyCypjN8WaarKyPgOg1rBUP+fAddyVNWI+tPrTXYgSmFN4KZ5kcgNDol/kSez4YMmnW/TD2R9sVtHSkQe42LGVo0vRO4A4TbwmF+9egaa/jDdSXbsHIp38eISNC1R+eVmcxf6yr1Okc4U5cs1psKpPazItNkkN/5E0cIMZ23rYvyShyRauPxnJhV/cudNKGbXTkBTLA
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7225e6-5af6-4122-60a3-08dcfca75ee3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:04:56.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnKd4JUcGKjSLZBcHprFAmurv1pS4XtUxwy75QqY+PmmSJaYX2ZyBtbWvh5HE0vffOgQGofqVTGct9YlULdz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5553
X-MDID: 1730707499-5q1XUtbhKssC
X-MDID-O:
 eu1;ams;1730707499;5q1XUtbhKssC;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a doubly-linked node to neighbours, so that they
can be deleted without iterating the entire bucket they're in.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  2 ++
 net/core/neighbour.c    | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 3887ed9e5026..0402447854c7 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -136,6 +136,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct neighbour __rcu	*next;
+	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -191,6 +192,7 @@ struct pneigh_entry {
 
 struct neigh_hash_table {
 	struct neighbour __rcu	**hash_buckets;
+	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
 	struct rcu_head		rcu;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 4b871cecd2ce..5552e6b05c82 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -216,6 +216,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 		neigh = rcu_dereference_protected(n->next,
 						  lockdep_is_held(&tbl->lock));
 		rcu_assign_pointer(*np, neigh);
+		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -402,6 +403,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			rcu_assign_pointer(*np,
 				   rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -529,20 +531,30 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
+	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
 	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neigh_hash_table *ret;
 	struct neighbour __rcu **buckets;
+	struct hlist_head *hash_heads;
+	struct neigh_hash_table *ret;
 	int i;
 
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
+
 	buckets = kvzalloc(size, GFP_ATOMIC);
 	if (!buckets) {
 		kfree(ret);
 		return NULL;
 	}
+	hash_heads = kvzalloc(hash_heads_size, GFP_ATOMIC);
+	if (!hash_heads) {
+		kvfree(buckets);
+		kfree(ret);
+		return NULL;
+	}
 	ret->hash_buckets = buckets;
+	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
 		neigh_get_hash_rnd(&ret->hash_rnd[i]);
@@ -556,6 +568,7 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    rcu);
 
 	kvfree(nht->hash_buckets);
+	kvfree(nht->hash_heads);
 	kfree(nht);
 }
 
@@ -592,6 +605,8 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 						new_nht->hash_buckets[hash],
 						lockdep_is_held(&tbl->lock)));
 			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
+			hlist_del_rcu(&n->hash);
+			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
 	}
 
@@ -702,6 +717,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 			   rcu_dereference_protected(nht->hash_buckets[hash_val],
 						     lockdep_is_held(&tbl->lock)));
 	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
+	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -987,6 +1003,7 @@ static void neigh_periodic_work(struct work_struct *work)
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3116,6 +3133,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 			} else
 				np = &n->next;
-- 
2.34.1


