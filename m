Return-Path: <netdev+bounces-143201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22AF9C15FC
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 06:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097411C22322
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB421CB333;
	Fri,  8 Nov 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="upgZhTsc"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D61CABF
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731043582; cv=fail; b=VStTtWxIDv+8kbfPNB7Hk9A8GHVM2Ncal7y4aQtx47e+4Acl9n8VGZ05tQVw4NT17A5r4FhTBlFWHtcDgPMRdhKCHdNfCMuZYSEO3V8QbX3WrICtyQywHdm0pyRDO209O8jGqxRcjb0wwseRZJoLAMtDD9oadDledE81Tl9i3ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731043582; c=relaxed/simple;
	bh=AdTvBHNPou++MKnjPpwSAYAuw801yB/i1FyCNaDBKkU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GfKBm5D5oe0+chds0rVCXob8UyuCud7ZcJEsCetMI9GXQD8gpJPTGxKBsrvNdahnTLdct6+JF1wc8Xd8t6k5Yh6CRwYYPzlRhFmBvZ2Kik1xVw6qFn6wmtnVDVa830mkTJd/B3EKaK2F0HPC439cxW0S9GqvI2ATY0A/IFIMAw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=upgZhTsc; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7A9B134005C;
	Fri,  8 Nov 2024 05:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPKK022+66tCDuSjK7XrSMkepDElXJvYTH1BA/OhhEWY7WQEeZKDgGVYifAjdXykuj8c8CF6PXxnayvsB9ZPxISbmTfUuHQUi1govAcU19gcE3clPgueMhwenVMtPB1/rf+Atm0mB2Gg2XPtlPPT4ltm+TnQJvp0kScxqICxbuDBiacWX27cXzLADmE5jX9hva/7eA0LvNl8SANok9aXCTz+uE4cJWKmfeaYDL6CvFvmhq6pPBKMvoUbfUEbReiFZNDOArzXWIW3vvPF3by1MwCSt357oXWX0nKpWQlV5zRpipcm9dglGabGEnwIxUfSHP/0UDHDLoigxQJSsoq7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUUJxUNsjA8ER48Bh3Rgg/pXpal4/2IrLcVOD3XriQQ=;
 b=Z4lifnG4zCUz7ZIyVAevVYqxdhieEwCBY69KqdxsiVw30w6saA9Rq9BS92JZYY/2K6kLpLDXgy17m61rK4XNv7ZkIo/y8Dv8WhOHitavwUwcZarch9Naj9NVp+nCovvNHjcOGWkfMujVM0aHpfCqHFIjjiGFEH6ErMzBazyQEwPajkU4nCHX6b+jfqk894ZrQdfVlvcgt7n1AlZzHumIw/dDJz9ayeOlfa4rWMr6cgSg28t/XNwOiMScs7g8McDPvEatkjtdbPBXxNwG6RwniaWnsal3ZtV5SAwKsnW0Gbpthy3BoszB09zz7BQHxWCm9Rrni4g8cpe1bIFJCEnZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUUJxUNsjA8ER48Bh3Rgg/pXpal4/2IrLcVOD3XriQQ=;
 b=upgZhTscN5CvJr6HTYEHheOv7kmDNIb7BAWNtaUhaBb+tUDYac651fAtqvMuXEJO6+LJ2xwcW93BC8bLlrfEPIedzfsgy2xYcU/zxjI/c+TJ6pLv03eegVpNGkj1wTJbp3Vu+voQhBLD7L+hQWVG3V3lCYbFNXcYxu65Zn72CQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PAXPR08MB6431.eurprd08.prod.outlook.com (2603:10a6:102:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 05:26:15 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 05:26:15 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
Date: Fri,  8 Nov 2024 05:25:59 +0000
Message-Id: <20241108052559.2926114-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::14) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PAXPR08MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: f2841071-b50c-40f6-80d4-08dcffb5dd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UkVLZEk1NlXAgWCZ8zsZWyGLv/gBIKqVm00987Yna/UwqX+LGyflzkL88ynA?=
 =?us-ascii?Q?2EAwMrLJJ8KiqN311y0L8Ds4+ZdqezRSVe47M5I27vjAMOtK+xiyFQFl79vF?=
 =?us-ascii?Q?j3QqjT5VLsElZzl5OXJksg9NVrOkRKUGa+ev03Dij23cE+z5QTpiCWYgK+BH?=
 =?us-ascii?Q?2U/0BmI/22+nLpG/nqEXK2WCEZVXZJorDiMojrvPtFcqh4R7slpN9eo7qSid?=
 =?us-ascii?Q?qlGUV3m6be6DpoNew2jlMiUUA53itqmEjt2wUXyLmrcMWBawuCiNAtdhXXv5?=
 =?us-ascii?Q?z0Qd2TEbUQzoFAC9BL4M4O6XhFJmjo+OBJZjoEiYOU1HtqRwVm4X3vtu5lYy?=
 =?us-ascii?Q?QnPAl/TUVpi9s/J3E+Fv5h6rjrjnS2KV7s/dN4bvHOLZ5vLIFZg7E+EgWSYa?=
 =?us-ascii?Q?WzroJrnApVwblv7A9PaDx2/CIlOk4IMxBrFMCL3MvQwmr/502SranlsD+DWJ?=
 =?us-ascii?Q?Q8ialGrRvi8gM5bbLjiEqzP3KMY9NQM3Z8TCmKS5q5h5yPrLUeRszeukIcQI?=
 =?us-ascii?Q?I3osKdDQw/GlOKljkHV02WT7DZbmobTMKMOYqNvXr26p/vVyqG33xxLL3tM9?=
 =?us-ascii?Q?ehoJ/hQuNcPyFSIkPMLaFrHMMqjE49UmvDMRhcKoskep48Tl/lBl10hU4I3V?=
 =?us-ascii?Q?4femwhkPgoJRqxli3+R60DgpLAzckmKBv3OZcvJSjjE2jEtdtMBiG5Zl9orc?=
 =?us-ascii?Q?RNCNeI5XXNP62Bimu1tAy6Hm3dwddzL6IsTe75zTp92OgTnirS4hRWVIFIZs?=
 =?us-ascii?Q?3SpilJCaKu+ydksEqdduEZ/JnaJDfwNytBLPIipRteJhSNzzf+LZlrqyR0rM?=
 =?us-ascii?Q?Md9dUdMvx4bKnUSAcsVtr1ruU996Wl/5O2p4Wn4Zs2ERx3+S0DRpUcxqdWjo?=
 =?us-ascii?Q?MnWYD/6Qu6RCt/19+O6ZQvWVntM2WFIqziKxJDlWyJafjjFWXasmKPaVhCyv?=
 =?us-ascii?Q?CmDjiydJY1Xu8zC+T7GW5cIfUg/mXHKw7z3xEGz61LO8JXcT4qRN5bipk0RD?=
 =?us-ascii?Q?ZhV6dpLM30/ayg4tFAFJbBPzYf8FnQQGvoNHvQrUPe2PPdXY/C1Ti2345Hfv?=
 =?us-ascii?Q?xcnuOprjyDw1CbbZfxutciJmonqPCo4oV7IBLobiGsYqx3qvvJyzLCRZfjqg?=
 =?us-ascii?Q?cMnrSHhRpM+coeGXo3b3bNLQBXHNh77vdU9T1S8/W6fAJUcPFNaI73ZdVZZ+?=
 =?us-ascii?Q?c0dxgjWggoZ9Azz25O2gHtGW9mol7ZMEuOeH2RybvW9iAttbi0gDGORw6dUq?=
 =?us-ascii?Q?7A39SK/6L1HZz8cb6BKnoGNBAI9clERcHbJ70pbGu38elWLbEfpq033kkhnh?=
 =?us-ascii?Q?sTD6AwaM9seWw0dJPKpAqCMuO9luLcOMsWgen6lHBLJUe6phGTwhDLBoUmZq?=
 =?us-ascii?Q?gzqBCXI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wZDswWwITIpnKUOy7ARgOqNcsSKY+10GLHAo0MAhH9KmiGJT7yLCbuONWr3Y?=
 =?us-ascii?Q?ouxw+XYPYD7fjYll8AR8Uykn9FrNT0idGMYfxejCf9Z2ugotHg81JxKv3ayn?=
 =?us-ascii?Q?i/Ks/KbdyIcpad/ksoyqY5UtdkT/f/OzUHMM8q1xEA9PDOQ/fkrGz+SQ3Pki?=
 =?us-ascii?Q?Z6aA+2kld9i8Gk4Ce0SWh64nRqvOr1ezSEZ5oyzbkD0qlMqnCjbBSQ+qbzqE?=
 =?us-ascii?Q?XEcd/PVG1OkhUcC+pgt2WQhTZMntQo9akX1LdMOHXNB8319adAFF0FNRUl9E?=
 =?us-ascii?Q?tyNf91yFA3Zc5BtlcZlrZfuCtLZ9ui7cePtifJQ5oeddNAE3mAM8SvdRGXXr?=
 =?us-ascii?Q?bjUkgXk967cbExGBFLlfIXfxmwxzMttQS1+ccQPsRhI1TOtqqPyfUU9JZqMu?=
 =?us-ascii?Q?uZQMBmQ47n3oqNGOzdSc5/Rz3eJLVDGJFBGdwSP/JInykMtD7bQ6sR92OgaK?=
 =?us-ascii?Q?l963+eOHrv/6WYHgcrlvLH3djveKGLA8oCxxdwzkJtJGOcPEeGdMMNFeEMzz?=
 =?us-ascii?Q?pa3yjuk9bLSqMTItNZJ3ONWyNVTyuJUVq6wOksFJwZ5MF3TfmbQC1pbLwPXf?=
 =?us-ascii?Q?8NuaztbbaneQrp9hybsexy0eXm3D47Ay3tqgTzQAmJ4yWm4J1XUW0RJ3KeXp?=
 =?us-ascii?Q?tfmj4WzlAMqniSoxbVcM1e5uswrjSuIgSztpZSZoKy7GA6EVAoUy9Iq6wIAN?=
 =?us-ascii?Q?pge5Jwa1D4CVhR7wtp23BbSbue64C2o8cPfoQAxoIGAUik9sK7FrU/mHZDpm?=
 =?us-ascii?Q?PaXj0/lQ9xfYZ+wvwmk7RcggqHZuwnuxuAQuML4dlaX99mVZiXo4C9XWMkEe?=
 =?us-ascii?Q?BECZB/sjp+FWz/WQmYb4hLKWmM9HplquC959YQyDpC7NUhB3C4s9krwaerA+?=
 =?us-ascii?Q?I4gGYBKSUYMuA43ftgzOCS1KyAmVhsjsBYeyG2bJ3c+aCqlT45S8CkMVBYoO?=
 =?us-ascii?Q?TGUb6OrCxADFXTzLHDdKOloLdZhcSE/x1v1jmKrj2k2tig6mXEfy8HgK8YFI?=
 =?us-ascii?Q?ivt9APiU170HjyphkpjAClfSb1k6MaUvvEF4hdNjtw6+XwL0BR/9u6l40SoS?=
 =?us-ascii?Q?XrROdcl+Zn3ymNr3WtAim0zYObPJY8nM1uOMuxLHOue4GvYLKoIUavos1FsE?=
 =?us-ascii?Q?RhBWnUOlu0p9DImDxh0uPm/lgBnay+wJVofW6r38OkDI81qDblFQkmZDT8vs?=
 =?us-ascii?Q?smWM5VZKfLh4n6KUMSyKqTTosmPfgYVA5iXl7J+dVk3OeK4LpX458bZPS+eE?=
 =?us-ascii?Q?lpruRhWFTudwarumq5Y/WNwroUUBTYGNfhkhP0neXtsK2CBj9lTYILnZExpP?=
 =?us-ascii?Q?4SPQbTmAu/FTpUt/dYbTMzrVljIrVb6kqPakEs4F779wvN8ArRg62g2trN+q?=
 =?us-ascii?Q?VhIv1sNVw2KVmkdQXeZrOX5zDY7eY1W2v9XYhJJ6ycc3GKVdMmzfrQtPsJUz?=
 =?us-ascii?Q?PGLNLm/sjQCyJqllcOjHkNGgnyhkrcFWwWXjCciyTG84k6BoZkBJnhNWz0LU?=
 =?us-ascii?Q?prGeX8SMLe7xkhEwpDgaSG6lFHKTyqdoyJDvJrfZ1Obab1qSOD4FzOMDE/6O?=
 =?us-ascii?Q?NeNnRROLop7hK1wvDFR1BkwFazePwZBhaoIxwB6mgrtmhByMoB0CTPu6gbZl?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	msJNpq67+4BVoYE6eDtd+jLFECCOpfiEtSGza5qBdmGVLQ55m0gjjdaCUHqUscNyXqCqH42Ge4Uau3b/PRwu6mN9UlDK+/bMNWp6g11/e0DH7J2H7MHv1z+6CORCN/BoohSoEmxyoBfxXmJiJQUA3uA3NcdDD4NIFbowzKZJb7VN6kb8HCioD/1VgUTpHmM+QAaT7QudDlkSjLR1znqpE1AO36IsqYF6VkCSe1YpWhwKj88dxnc3SvouvBv1wbd/e+s6ZbH/JG9RLTNlWbdRlDzDUVs1u4QNLU5hkMqAwFWCEIM3IHotpf0ZXSWP8oPWs6BhGBta96Db4SDPp0BoFEt88hzJdMK2orKHdbofEs8lhusBiKscN9Opt8Kh+29sSONH4lj2Eb6pt4UT3b7dCBR4086Ygim3vG36FjFao2tcIWodRi36xu/bXgcZWIL2xBJmbsgW7GmH0qKcPxOrXdyklI2DtQLATb4pJek9ecyDxl4kOcRpTZaSHGiZcD19jArZG+3nR2N/CJHvxN6+UkOxSHCC68rA+VRSOhCt9FdmPd8zS5PWrCTBlQhJrEYDBJda+b77K7LqcbkeIR3aus/1YpiY6K5/PGHWAGAeEHrbZm8C8OkdNrhD53l/SJ9C
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2841071-b50c-40f6-80d4-08dcffb5dd86
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 05:26:15.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgtihQFB7zxjzyfkfS8Gr70BIRCkKDvTXO594qE1ecx4fJ0yxTFw8s82vpgDCcmJwyaZNBuyBbpglqb0fpwzjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6431
X-MDID: 1731043578-n64g4K_PuzBg
X-MDID-O:
 eu1;ams;1731043578;n64g4K_PuzBg;<gnaaman@drivenets.com>;3d1c658def2edc17f2dc3c0c0047d85f
X-PPE-TRUSTED: V=1;DIR=OUT;

struct inet6_dev already has a list of addresses owned by the device,
enabling us to traverse this much shorter list, instead of scanning
the entire hash-table.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
Changes in v2:
 - Remove double BH sections
 - Styling fixes (extra {}, extra newline)
---
 net/ipv6/addrconf.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d0a99710d65d..c6fbd634912a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3846,12 +3846,12 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 {
 	unsigned long event = unregister ? NETDEV_UNREGISTER : NETDEV_DOWN;
 	struct net *net = dev_net(dev);
-	struct inet6_dev *idev;
 	struct inet6_ifaddr *ifa;
 	LIST_HEAD(tmp_addr_list);
+	struct inet6_dev *idev;
 	bool keep_addr = false;
 	bool was_ready;
-	int state, i;
+	int state;
 
 	ASSERT_RTNL();
 
@@ -3890,28 +3890,24 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	}
 
 	/* Step 2: clear hash table */
-	for (i = 0; i < IN6_ADDR_HSIZE; i++) {
-		struct hlist_head *h = &net->ipv6.inet6_addr_lst[i];
+	read_lock_bh(&idev->lock);
+	spin_lock(&net->ipv6.addrconf_hash_lock);
 
-		spin_lock_bh(&net->ipv6.addrconf_hash_lock);
-restart:
-		hlist_for_each_entry_rcu(ifa, h, addr_lst) {
-			if (ifa->idev == idev) {
-				addrconf_del_dad_work(ifa);
-				/* combined flag + permanent flag decide if
-				 * address is retained on a down event
-				 */
-				if (!keep_addr ||
-				    !(ifa->flags & IFA_F_PERMANENT) ||
-				    addr_is_local(&ifa->addr)) {
-					hlist_del_init_rcu(&ifa->addr_lst);
-					goto restart;
-				}
-			}
-		}
-		spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
+	list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		addrconf_del_dad_work(ifa);
+
+		/* combined flag + permanent flag decide if
+		 * address is retained on a down event
+		 */
+		if (!keep_addr ||
+		    !(ifa->flags & IFA_F_PERMANENT) ||
+		    addr_is_local(&ifa->addr))
+			hlist_del_init_rcu(&ifa->addr_lst);
 	}
 
+	spin_unlock(&net->ipv6.addrconf_hash_lock);
+	read_unlock_bh(&idev->lock);
+
 	write_lock_bh(&idev->lock);
 
 	addrconf_del_rs_timer(idev);
-- 
2.34.1


