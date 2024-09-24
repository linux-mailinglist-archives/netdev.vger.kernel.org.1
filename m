Return-Path: <netdev+bounces-129492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5EA9841B7
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5041F249F4
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DB6155314;
	Tue, 24 Sep 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QBFFeYIS"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED08156F24;
	Tue, 24 Sep 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169094; cv=fail; b=qHnUZ3Y1ZHvXrB8HZwl+Oul5U0GUl7wmblgy0oTjnFn6IU9KY4y/xoy2V8jtxwceKX9XlBBJAgomb/TTgKR7FT7Bp42hyyIJ4hoZzhAcLZwSjPemmjU9APWEoxERmV2yJlasL2vZapjBFDfv/FNocofb3ObKjBJoD0N6EEfQB0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169094; c=relaxed/simple;
	bh=CTqiR66hMBuc6G1q6rcXRGKpZa5hdthIu0lFeq5L6Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=szA7tMXfy1OlzgZqjtoNom0rkoPQjkYJX6r19FAIX6booEjuHi+q8iwjGelehExQ9gFhdtCwieLp7jquDWEUGi59do+uQkC+8+BCKZJ4RNRGBxDL8OCPw9sh0CA9R92en44r/zELhE/RfNDT8ssJxkfFCe4t5oWP4a1TB9KU11w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QBFFeYIS; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBe72GTB1iT5I6SvNuKxycmtYT4YuDblN3jxrSEQnbr9+1eFbiuSeLIEMh9FpSfY9EEiH8IRXoR9WlXP1dedcKlm8t2fYA3t273Cg8WI/wcCkTmsB5b42FMLNzjuuULgJqu2slQsB3nc6TtEYPAWAX+03SYd3wr4ezSQDcBpsB6VtX0djts2x0Zk4kcJyKNGnUPh58fW6dCxOjvVRCo2n36wsSbozyIvrOr+uDta6l5ht51d7tr3QgAEO3hMKEokaEH7c7O/Uib7Pk8YB4qozOkq76DIq8qtBY/nw7kO4SltET5ILKIdDsMQrqJ8AiE2NBNIoKZyVOMldY/7U5G9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlTG8RarmhhYxGmzGZe8m25AFmOcb9UmBrXnHZ1/0qw=;
 b=VZCKyDPhSCwie7jE+udhmSks5w2+rGkc7U7FHTj+rCqQ8WTSysONnya6iJMAozwY0lkUQeiWubm/yWKPEs1g3GAYutwkv1hbLgIsfGZpTEmlc8MbInUNsGz43DyguaZt1RrG198Knrjpuj+8kMaQsdzV183EF6y+1KRzQVVw2glfVniJ4Voqpi6UVPRk7ymGtPPljRmrvFRir6ayJJBto7+avj++PYVMLnXcc5K/QL/xhR9EG+RItsOPwVlUOf2wqQRNynTuLiEUXS+4uyZmHeFl1JnB/40z7dHjtzCyn/zwmuLS3VHdBagFLi5W7+pxCr5CFRR3nF4T4zbmeTbotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlTG8RarmhhYxGmzGZe8m25AFmOcb9UmBrXnHZ1/0qw=;
 b=QBFFeYISKuWFIDkIDoyhCip+/5b6wQG9GOEk3M5PvU3u/RfEQvKA38hQN4V27m8bkKAECg0+chYCxBBEA82KrOlnWNM3LfeTeKwYBK0HOGeYbrQPFxk0N5bnuo/MLsb8NDqIHQ0ZIMAIw3yDxILRaj9K30ke2WU5JxUutCeQtED+MgQmqyBh7Aa5OdgbzGplfPDl43rL3WaoNLQt5YdDThaSxk+/tmjwxrQttA8PRxIax7g6IoLTvKL/hHwk4vqyR03/eSWR1XIpYa9JJpmdhDjN1uRimDYCggMqduy6KEfQM1JrFg7l9OtIMrHVhrkC/tQzlDRAq8BHxnajWBs/cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYZPR06MB6513.apcprd06.prod.outlook.com (2603:1096:400:452::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 09:11:29 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 09:11:29 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: isdn@linux-pingi.de
Cc: quic_jjohnson@quicinc.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] isdn: mISDN: Correct typos in multiple comments across various files
Date: Tue, 24 Sep 2024 17:11:17 +0800
Message-Id: <20240924091117.8137-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYZPR06MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d26acbf-b8bc-4274-6308-08dcdc78dfbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kBIPz2ksZWTv5dKC8228ug2dGOh5Qq4csIDTH4VDSnBrXZty7RI7cHRcR8rU?=
 =?us-ascii?Q?gwSfHT0hhK1Wgci6MD4RBs0jQvhRTQxln8WFBAYsF+D/bHjf7XSzEqJDkwz4?=
 =?us-ascii?Q?UmYJOnf6dGd2NE8IXBTxIy1m0vAlzy1tZZX+GNMrWvwKr87iXvFWgrbI7pBQ?=
 =?us-ascii?Q?OGc9PvIdAmwkw9tC1KPk6kVUi0v0HLdjiMXVpYqlyMmvZfBQafolwFjAjjGk?=
 =?us-ascii?Q?mOjvRdlDZ4iPVkMAdgPc7Numd4q0/fWf+OZTwCWleAuNxU+056ex94h1OJdh?=
 =?us-ascii?Q?h6V+bwOT8GRtxbEP4RuNyUBRBeXfMa7n97c8TMG4+dojHKdLG/ujrrfOUALw?=
 =?us-ascii?Q?z2xPPcjeov4Ji7dSxefEVQAagKzA+wuIz3V6JEgpEKvbsDJUWB2t5S4skLZ6?=
 =?us-ascii?Q?pUZWx2J+mHCAec1FVcXrgnxXMLZTcMu9OJmvHiGkvweIsoZATJGv6WvIBx64?=
 =?us-ascii?Q?KCyhhbL8m+Mjl3r4XLIeSvvAoQAbRnLdc93ZYtMB3dsZB7sMIIxwSLAPSJvP?=
 =?us-ascii?Q?B+nGeVLDLrm1Xc9qi8fYHZEhUuzkcdm7/FLkIlqlHrVuByiKCRpf15SJFssr?=
 =?us-ascii?Q?RndToPqx5rS7zB5yg9l2WoFRsDjvmXjBpRVFK2ZzJAjvGbApVH2JjDFGWnx8?=
 =?us-ascii?Q?x05ZezJ7Lbeo47mzGtdLIcmAhC7RG/DcBFIxWnWNf2V1V2qDu4b/eBC6MgGr?=
 =?us-ascii?Q?5e3rJSLf7YAO+8Pp4U1PW0RAcWSfyPb5DWQ5/joc6oRMs8qvNlIpMni4G/dm?=
 =?us-ascii?Q?K0wR7DDS0wbCoP5fhPmiLn+ayT03utA6BtJDCtQINnSwpG4Wn21GuLWyGH9x?=
 =?us-ascii?Q?ISeGTIWgJ/4alhr7UAUTRujmrNL5hWvvxQuzaitwKo/hj963XHxhTSuYOKFX?=
 =?us-ascii?Q?s+CtoNaXx2OTaC1iY+8VpWhHWKRX+K5zM6EnksI+fSvbh1UVUud8qNZ3+P14?=
 =?us-ascii?Q?XHUlbVe5+jxX96dsgxbBhfVZd5VgdUMSPprp7w5TeiI3/fiUaJxiROKP080O?=
 =?us-ascii?Q?0OCKN6tVmJHoVF1QsAkTIO+JO6g3fhYGo/AmyKdHt8Wye9RK0XeO4IzYu5sI?=
 =?us-ascii?Q?ZSWZgzw8gOJ9xBdfWZrJVRpwgnSbnKDlBlAvJd+H1+lWaPZVMwd9fYwHmqOJ?=
 =?us-ascii?Q?Em8w9r+g69NWQHGKiY46OO5D+jp9Fho0oGq9d9BOnNAF9QpITPTrHVVB0tFa?=
 =?us-ascii?Q?ndQAcQR3kLRLbo8LY3jvESwI2p6MJ6j61YTPbgBj3BntliYLekPb1WRFsW5i?=
 =?us-ascii?Q?cUrV6shJXDQBTaZrg5kPJE9aedw+8Nn2St78MDIeTVJFKMXZWqj6VKHONfQq?=
 =?us-ascii?Q?e53L5P6PP1FUBAMiD7T1vT0JqvGI1ZXgyXXgST44QnSSHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GtxLnQeIBrC8QA56zhuPVUWsKqDQzL4YbiiQP8XZ1nfLDJqHBWFM465ITONQ?=
 =?us-ascii?Q?0CIyBv24ST7D2LqZFRrgrYTccrjDORl8gfIsC1fv8/o40j1074n1kOUebEDj?=
 =?us-ascii?Q?3UPQrJtDr44tJFx9BEIxz5QPVf6U45QwyGpcNXDlE4dazWibyq+lSmCBm72L?=
 =?us-ascii?Q?PBtqyVljaeHNm0iaeObqXKdQu3h8bgHpq5XQMHnTEQhS6es3qS1Sw8F3032f?=
 =?us-ascii?Q?PYKtxsxudiNWrbmuSd/xbgE6B772Hpty3SYxoGEivH1UXDJhud/6kqEXLxj7?=
 =?us-ascii?Q?FcTPmiecW2Fqfo5XvWyQs4cXF8I0rxfBPAPiws+yn5Mf1IOgtyr1W//VcJrb?=
 =?us-ascii?Q?MIR0I5Qcmorg15TpFLniIF1WsGqi7hNkgjJJIAq3cRvQK4zrkOsSmsM/HCQ4?=
 =?us-ascii?Q?+z/d3HuB+jKfZ+Pbtn93dYdgXWj9ICUpLMxUvvx9a8MslsItg8G0ruzW8PL+?=
 =?us-ascii?Q?IhrTjAA883QxUmy9/gK55gzl2KXtj3icNRfOW6kkd3/zZRZPwJHoCMGw7kms?=
 =?us-ascii?Q?q0K4lMHQgTWLm1gWvTXSvJ2DAh/FyQxPdSiSnraIAkexPWjhHltIFUz2fXef?=
 =?us-ascii?Q?DGC/YnU1pEOaC5rd0R9ndSGr26y7vufwEEl5SBZ+K1tB+gpgk0/+WhM/aHnA?=
 =?us-ascii?Q?wOnzsZZWCnB37Td1+danJug13urZVlMOoXRIkNyBW2eQ4n8HwixpUcbNxzTS?=
 =?us-ascii?Q?23U7TmFvWoxu3mzjmvgKcCysCM5BD35TX/H17K+obSXVaorbPW/kDNAc/6c+?=
 =?us-ascii?Q?2C5lUSeZIj528xQeZzPWhBXp4IMvncqHvG7f6uF9nC0zZgnPdKn89yaENqca?=
 =?us-ascii?Q?QXx5l88TirFxt9kRHl6MtOjHm1tyhhNvWs/YKCV/LGzS//LUCKNRUcp2vRij?=
 =?us-ascii?Q?b9mvkWrhRwGp3Ca06JNGEcO2tTeYE0r9DoW5CAcpslzIunTqQWLIaCejnt12?=
 =?us-ascii?Q?CW8j32kvfM8cFRFefhX+y8Q/urTtH9cHFoj4ZpmTA4297EZYsOitodyFaSXA?=
 =?us-ascii?Q?xfRQxTAajI3UmjY1WO03d71jB3QYMjGU4nW/+QLu5RWybw3Rk9ckXoFFl9wK?=
 =?us-ascii?Q?bufGh+YKx74bo+1WIO2AJQRRltiUkpZ89uvXo/5Scgt7Q9qjPWM2Rh2E81Jl?=
 =?us-ascii?Q?LxGxpNKzUq3DXgplLVg3J+leBo4gsHsq6K7IILozlC7gJCfSYL9c1sKIF/2K?=
 =?us-ascii?Q?9ZpwzCjZ4jTBgNpEJvkJyipFbrG5F66Ri1IqHUtj3xKsqHNBtdKuLpINipz8?=
 =?us-ascii?Q?wB0BHHDNzsiwrE5+9T65KYcCJdTYbYtN2ddPt0WC8pjKK8JmPRMycbqUEgyf?=
 =?us-ascii?Q?gqIeD460UWUyvvIF5YiG9YnbxDSOnA2N4ZkO6sBN4QpJ7ufB2TmhCMXLePY8?=
 =?us-ascii?Q?eCssVkMY0Jd276XA8C5Zc1fuhQjCXb8YHKdRanoEn9R+5JUyYhfhQUSCVdPi?=
 =?us-ascii?Q?bUAZkwef0j6Y7CcfN1KD/wdUWNoegHN28KxMLJZYDOT91EFZZhKog6U9kofd?=
 =?us-ascii?Q?kKWFxQrxj4oQpkC6nMyrQ1cQtnQAZnsK+pE2crpuS9yOcB1kGQZl9RrHmcZL?=
 =?us-ascii?Q?ckpsmYTQhGUB8XveD0V0qguBJOUqZpSYk9tXonyX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d26acbf-b8bc-4274-6308-08dcdc78dfbf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:11:28.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzx10CcP4+OUlGswPX3BLCmxkxIHlTdNykN30GTWJyUT2wSquWAV0JgzI67SHTWtfekvins+OlfGNyJvHvzG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6513

Fixed some confusing spelling errors that were currently identified,
the details are as follows:

-in the code comments:
	netjet.c: 382:		overun		==> overrun
	w6692.c: 776:		reqest		==> request
	dsp_audio.c: 208:	tabels		==> tables
	dsp_cmx.c: 575:		suppoted	==> supported
	hwchannel.c: 369:	imediately	==> immediately

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/isdn/hardware/mISDN/netjet.c | 2 +-
 drivers/isdn/hardware/mISDN/w6692.c  | 2 +-
 drivers/isdn/mISDN/dsp_audio.c       | 2 +-
 drivers/isdn/mISDN/dsp_cmx.c         | 2 +-
 drivers/isdn/mISDN/hwchannel.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/netjet.c b/drivers/isdn/hardware/mISDN/netjet.c
index d163850c295e..ecf20159bb4e 100644
--- a/drivers/isdn/hardware/mISDN/netjet.c
+++ b/drivers/isdn/hardware/mISDN/netjet.c
@@ -379,7 +379,7 @@ read_dma(struct tiger_ch *bc, u32 idx, int cnt)
 		return;
 	}
 	stat = bchannel_get_rxbuf(&bc->bch, cnt);
-	/* only transparent use the count here, HDLC overun is detected later */
+	/* only transparent use the count here, HDLC overrun is detected later */
 	if (stat == -ENOMEM) {
 		pr_warn("%s.B%d: No memory for %d bytes\n",
 			card->name, bc->bch.nr, cnt);
diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/mISDN/w6692.c
index ee69212ac351..314f8ff42bbd 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -773,7 +773,7 @@ w6692_irq(int intno, void *dev_id)
 	spin_lock(&card->lock);
 	ista = ReadW6692(card, W_ISTA);
 	if ((ista | card->imask) == card->imask) {
-		/* possible a shared  IRQ reqest */
+		/* possible a shared  IRQ request */
 		spin_unlock(&card->lock);
 		return IRQ_NONE;
 	}
diff --git a/drivers/isdn/mISDN/dsp_audio.c b/drivers/isdn/mISDN/dsp_audio.c
index bbef98e7a16e..4ec8418215cd 100644
--- a/drivers/isdn/mISDN/dsp_audio.c
+++ b/drivers/isdn/mISDN/dsp_audio.c
@@ -205,7 +205,7 @@ dsp_audio_generate_seven(void)
 		sorted_alaw[j] = i;
 	}
 
-	/* generate tabels */
+	/* generate tables */
 	for (i = 0; i < 256; i++) {
 		/* spl is the source: the law-sample (converted to alaw) */
 		spl = i;
diff --git a/drivers/isdn/mISDN/dsp_cmx.c b/drivers/isdn/mISDN/dsp_cmx.c
index 53fad9487574..b4fbf4a7af65 100644
--- a/drivers/isdn/mISDN/dsp_cmx.c
+++ b/drivers/isdn/mISDN/dsp_cmx.c
@@ -572,7 +572,7 @@ dsp_cmx_hardware(struct dsp_conf *conf, struct dsp *dsp)
 				       __func__, member->dsp->name);
 			goto conf_software;
 		}
-		/* check if member changes volume at an not suppoted level */
+		/* check if member changes volume at an not supported level */
 		if (member->dsp->tx_volume) {
 			if (dsp_debug & DEBUG_DSP_CMX)
 				printk(KERN_DEBUG
diff --git a/drivers/isdn/mISDN/hwchannel.c b/drivers/isdn/mISDN/hwchannel.c
index 8c93af06ed02..9e8decdb44b6 100644
--- a/drivers/isdn/mISDN/hwchannel.c
+++ b/drivers/isdn/mISDN/hwchannel.c
@@ -366,7 +366,7 @@ get_next_bframe(struct bchannel *bch)
 		if (bch->tx_skb) {
 			bch->next_skb = NULL;
 			test_and_clear_bit(FLG_TX_NEXT, &bch->Flags);
-			/* confirm imediately to allow next data */
+			/* confirm immediately to allow next data */
 			confirm_Bsend(bch);
 			return 1;
 		} else {
-- 
2.17.1


