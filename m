Return-Path: <netdev+bounces-81507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B18A88A0AA
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007341F3A846
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10715E7F4;
	Mon, 25 Mar 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="OAieKyps"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2018.outbound.protection.outlook.com [40.92.102.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0291487E9
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345775; cv=fail; b=rIyIZsH3UeZwXJNKG9trY9WjEHnTtKRygIZcj87+yyOA+dqK/HX//gMLfQhGk3OyAzZTMSGjJcPsP0vPvNhN24BBKOkjTstcvatDxlpBgewNnqTJR+7uPOUcdKe6XMUmni+jVgXZU4KKpaWLK0hhPwmtssaMS/fxcHnogbmTp/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345775; c=relaxed/simple;
	bh=rqVDVeVXwnt4m3SKsUtkQKCcSoTMJmjF523xVt4yRgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jpzYzo+ZwYhri6/T8yP3cU8YfjcIjZy1DqegTjnjYCY5ISMa77W2taQBD7XiWJDccmBBw0ClIsLbU9WW3tcnmxS+J1kjo0r1FWg7HmiFcS9CRQiknfsbggJBm4WSyKDnfXOcLdHslsvBia22ruNl7oJkkV70R7a2x575j/ylLW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=OAieKyps; arc=fail smtp.client-ip=40.92.102.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7W801JpGhuXtu2awSUQ/XC1la3txrf+GBAROZAcedtbbBbxPBk/vVzkXpDafLkPq22Psw53UBSu/fYULzUv+G1p65Xb4AN6VFqi1KoxYcrlCNzoBccHpE1NdFnGLaZnpfx77bsOP8Bq8MwiMqHP8MTwOHT1G23XViq7uKn2Y13zefdahmK5yRkQtL7GSCqYi4ukGogxFwjG861teAGy1aqsq58HBEqmsSUb6r+wBv/UchUOpyLcO5DVBzdOpjhqTL2hu8Pg1Vi3PNGLXWhdECQAwfo9Cw8W3lHc+TITv9m7TTZ2jDZ0ncE3BpZ8N+3HT5e+Z9qg21qscncjaeeB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD4wfgvCq6QhPkiX0yJxaYFYOKl1N2n5Qr3l9JsldPI=;
 b=GV4YsUKMre363bDZ6Tq/OTFhes9qiuI1k06m2d6RUb+ClWtxxWfInBog7Jc0NutHbkq+LuOI1K+vw5WbepplepXxqevrSFHjgQrm8kZ/aHuvjEaIq3cDjyaYql2tQBXLycLSZrSyuCy4Mwk3TJZU6Ctk4Uem/jXqDSNYcv32rfPjqrJdqBR6lE5i4Z4HwbdsTmbliES0hKbZsM9vHTlx2CRiN//o8ecW4U4Jb1QEQ/TcW0yAevfp9sfsc1b1As020UcgjUhzeO38bxRSLaEwvn2waDTavVL2xtDKyIoF7JCz1IdIM8E3+N07FUKN5VH+WGZ1iFG1mkfY1D+YLp1eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD4wfgvCq6QhPkiX0yJxaYFYOKl1N2n5Qr3l9JsldPI=;
 b=OAieKyps2uCq36e70Ddg1gHS+3zAPQkEKl3/VwkESIlBInBFoEhwgx0y++fY8GDHDMv6JiRhwTqYP9mTCbHsR1MjCU8KsnSTggB8Rga+hcs+3pGLgiuH4hFb+68Zecs33QugBwQ04EMgiuzv4lP6aXsewpjdkw0KTx9k1PO+55sLdEM8TPed76bBH0SvkaNZt5TdtggoUunTWUIVwIls73nyXoYfzX3cMK8IKKlUycTfsK1blbXMuY7JslUIzM1xuIJP6rXHpgiGmi9w+YiDUhd/dVjZVLpyQcVgKquHA1QLdEIzSYDFN/4xvCMokwUoM4fH+V4eh1olRz/V3GWXzw==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 PN2P287MB1744.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ac::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 05:49:29 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 05:49:29 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	tjjh89017@hotmail.com
Subject: [PATCH iproute2-next v3 1/2] bridge: vlan: fix compressvlans usage
Date: Mon, 25 Mar 2024 13:49:15 +0800
Message-ID:
 <MAZP287MB05035FBFC9A954A55A67790BE4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325054916.37470-1-tjjh89017@hotmail.com>
References: <20240325054916.37470-1-tjjh89017@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Q1tAvA4drrePPfxYQ8Melxm3DaugXX2z5ApQWRhPIqQVdUEov3ju3fDfl7pIpGCE]
X-ClientProxiedBy: TYAPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::16) To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <20240325054916.37470-2-tjjh89017@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|PN2P287MB1744:EE_
X-MS-Office365-Filtering-Correlation-Id: 219062c4-0ce9-4dc0-6581-08dc4c8f5633
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnqkjmXb1vlddM5aSa/Epk3AjG5lqiwNHkFp3cf2RhGoYfQGW0jZulDR9DB/qyL6idhFwfCqn/zeDTTmlpdX19+ctrEZt758YzxcJMWmZ2idpFv3to2M72RTUBxrmBfe/fJLcoB4fcE/z9zj8BE+Q1ykxDrO7L95VUpVqUJ88ZFiwgVF+MKRnb5XE83TDUtkqZ+wnoGktG/NQQGyniWtbD/CquQHKElG2E2wvyAhb9f2asNQNN6puXhwrYhPgFl28dB1M1bKHepg8dW1erzYn1o8ZU1W2xdpfqdd1Fa/PZfd3V00rhzqIUC+v0K9JR8g7Yi5AtdItdq54PP8UWY/BjHr81R5KQ4M/W9F2dP3i/FLuyEpFrGHcmAZJbrOl37qHdGS+oEz5qQyeU600TkVAEAGuKemnELbnlHxgH52L8QnPA2FXF4i4TWAyumfeLJMpnVOOkJTDPD3B3FzrjeaE32rRbw3/vDUK3xiQ9XwG6HrpGEwv+oouB/x2K0oIZM2OEWMSqG8dNDLTn28xv8PjvZf5wgbImPnBuv/grpTOg+KdhtsTVNJ3Ua5UP2umITLpDVuHLfsclOh72Jpk0wnmVR1k+PRt6nz5+aqYk2bs07VO2oupTQGMRrczGUuBsWBswlIlWENPM5IJWDmhK3w7WhNKfpHHtkuGXLmri1lAqGC1dimE7LA5zcUefeejgxyDBpN4J+Ob/3F5TFC0hGPcwmqOPJV6rfVStDzbXIF4s38YcXMSPwUGbdZxlyaXapZIKk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BYAndbaDgP9Y6gZjNHuOX+C4YL/OQ0U4U6k/iljloZ8IAFL/5O4WgGq0bPthrGxMZZlGsElCx0Q11q3f0AmwdAJS21+zqYthFcjgdnbT/6wUeygAK8LJMATFC15mAgDxjGjcXgCdrxhpa+W7qu2iezBuiRyvxhN/c34NuSkcFTbrDoHHdv3PJvVPI7C2kFg1dM6BK3uJsKx0oQZ/bQ9btUT3ng5ECsYtQXZI8Y1r13g09KvBboJaPNQ2VGXNUjP/LkctlZsnFVdOzle/O88ZD++gyZm4PUyNZ++nYidYzPcoBNbvSCTTfn45v9NfszHAI0b+G1uEPRybG5RqZu7u1VgzbM8TwSI+0l9pLd/WYKFCi6WWnSMhpJY6JfXkIH02hWDKD745tU1gorLlNh9MONWmku498xPySas0jEm+xNaIFK6cYeGk8+OrTRaMGGL2W/vf43xieYNcPnzYaRqI9MeeqWng69PYUs0tV58T3uS8Pdwgy5alZuDd8dYnzeX3SFBHEc5JzR8b3bA1dFIOfJsoM2fs270gqc0irdMsqx+W7nepQ4/5c2vxdexydIam6bAtET9pxdMH61ee/6Yi5XMRA3Hw8hAGidV65JYMwYHjmU42tjXiqVaAgAEKP9Fv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7eaAxJyso59o5X/mFWK4Z5P1tzMZFPph4MjzmlLPt+qMtvl2dWOjIxvnCmn?=
 =?us-ascii?Q?TMqJM70R7toFBzuYM7u8mMzcvADNNcnwhYKx1h/H0AUtz+7kJY5xj0VmdgZh?=
 =?us-ascii?Q?mL9r9BZsxSxQLleYuEBfOfDX//UHXh/8ZCwkENKw8MyC6xAEO/aUkxD1nt55?=
 =?us-ascii?Q?tfLjiINjeX0Xdqk4Imfuncb2B5FOuXB9Vd4VMSJZr4LU7EbuqDm1YQR1xqBA?=
 =?us-ascii?Q?/Ksj0EVdd9P52vG0225d7IdwKmCZtrSKsdhJFTz+EJ/eKpXbFK53gxu9Av5i?=
 =?us-ascii?Q?nJlDdtob733kRoQOfGvWxn0e59yOZpLbLm51s/a8IUICdHpb2CYIDIYePFv0?=
 =?us-ascii?Q?rVg/00qiSBCQ3Y3JsgGfHN9ryQxMlcZVm9I/SA8cKOcBdObMpcx6SBjYb9GY?=
 =?us-ascii?Q?2FTJq1scN0HxDzD6w6W5P0xKghEsPSEOKS7ZOBBeuGhyGl0AKJbK2SBXwJYP?=
 =?us-ascii?Q?Jjma7djq6CSy2z97S06m1wbbyIgaM3/cvTW4qMlO46vPx0MNTYRDFDQ3Yxvs?=
 =?us-ascii?Q?C2SEGGXXhbWpmggDWu+GFAvM9dsLdJNP/BDypvqQDLFSD5ASUI+hLsSfrw/p?=
 =?us-ascii?Q?BoE1ZTP9S7JchWeXYrJ1X5YM/0cRiXRclxwAQjRBHq4/fHUwyUMN0lIKm2Ex?=
 =?us-ascii?Q?bHiCbBGFXBziekkXu2duyOoXSBoQD2BE7f/Ty9dOm2jDirTiGiYkCOXMK2GE?=
 =?us-ascii?Q?Bxcb9pkqhB7UeyXLoxsUmdietxSRsi089+C+/G9l+qVidu+e5vsQaE7J7eeZ?=
 =?us-ascii?Q?9bnPX1T7ok0BPnmXMQ7mmuoiTyxvN44Wvok0fI3pJUyQjbBRygP7fQPqqSZE?=
 =?us-ascii?Q?mdgPbITEi/SlVSKaQKFxUdMkjwUe8sWh651vxoqNYRqm9rePMGg+jiUXzycY?=
 =?us-ascii?Q?vfJSrvIZ4CIDpzT5ioK0/3X9jOgR/VJePQCS1xcFkRQNAXxfKc9XhHrtaPQ6?=
 =?us-ascii?Q?Yya5Xf8earFEgACE01kUTItD8nqp8RqEtXRVqKlq6nEhgn8PmFh5O06qicBt?=
 =?us-ascii?Q?9aqlVzIULyppBbyvYykSoahqdwt3hTK2Uk0j7sVOo3QhK0OUiRQhinuwonTD?=
 =?us-ascii?Q?Dh8KBXR4CMwPOspUUMMvd9GFW1EMjemkRbXnvAYmagUfy256htPlZqMwj44P?=
 =?us-ascii?Q?+y+hTvLnCa3hg5I+5/svKNqwmR5cN0QOPvWqR+8aCvK+SXHhF23b+SNHUcqM?=
 =?us-ascii?Q?8adVn6eJ0yDar000giAyTd1Ql4XU4fcljS1h2u/pmjIc19TwWBSQ12GJZznx?=
 =?us-ascii?Q?ZESK7zMxhnpFn1RdjAt5FekSfolr0oFn3e+pw19AOPWhxl+OWatpLHBlOaQr?=
 =?us-ascii?Q?Uiw=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 219062c4-0ce9-4dc0-6581-08dc4c8f5633
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 05:49:29.4335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1744

Fix the incorrect short opt for compressvlans and color
in usage

Signed-off-by: Date Huang <tjjh89017@hotmail.com>
---
 bridge/bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index f4805092..ef592815 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -39,7 +39,7 @@ static void usage(void)
 "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
 "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
-"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
+"                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
 	exit(-1);
 }
 
-- 
2.34.1


