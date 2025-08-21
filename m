Return-Path: <netdev+bounces-215684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB80B2FE59
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3265C1BA7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A0271472;
	Thu, 21 Aug 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MuD8TxHr"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A6270EA5;
	Thu, 21 Aug 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789679; cv=fail; b=TPGKMa7H6pP8THeJI6GQGMHNaYKixCvGwWl7w/brLSfsewAtsxPtNuXpBGfKsG7qph/C+w6546EPGq/v775EOfbHlsQYgwIRmskcos2pyLbgd6DPatEzyFPgTI53XHPD8rutQjBn5TS7Kiv6EGzpdeRaJVITyW5W+yqFF0p2irI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789679; c=relaxed/simple;
	bh=jRDmGY92bhedqNsRSnHPc6iu5e9MsrOwp+lRfcA6vsY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NXwwIuu7DNkdxgY8U6MqKwYtOTX8SpUoUflwTIgWbCe981NpvyV0P4/YDZoAEExauW+eT5fdFKY3cy5q46uJysCXKYB1ZK5o1p6e5sCjPhHtogyfvOlblqFKxzh5DRS/uqZsspru0byu1g9ZmwGuavfc3PAQJVgmQvYTuK3qCEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MuD8TxHr; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRfifc+ANyj2FyKuEuS1XvqeqvUGDES5+YBL/8tWgHstJ467ahH2jDSvnJLkd6I9xhx7rtm5uUYRHtxJWPm5hXidc+1e+1jJDOZDwM3WLtXXpZnUBf4OIj+TrrMZ+ncMzlzHa2AdhvFX7fQe+hc8vk231H9xsk8c8Lz+GXpmsbXXBF4Z9iDqgkg8VrJrbMY3rZk3N5ibqal5eqQ36NvQvYu8pFVxAKOP548XnwSgzk7gGgGEWHXBTCjv3FmWb6Yley3+MoURRWcZ791IIUqdbD9r/dGgZ3FTeYidBbmppfCtztELy3kw2nq7K8Zv3bdSuE5AIuPs/Wn49qyY9v6SLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbE2LnbUR3B4zkZAOMTt2MiMR+4lTFgimIUldomNLMY=;
 b=vRAKFNVhRNnJj3+prH+m83dFS9kmjWqLkLX5fr8AjqiPy6cjGZbj9slN0DTX9d8GTCjNBgXdu3/g6XknESiNSh6cReXeFmy2Z8q8rV5GhHKrjfIbZXgYOFhp29bQDnmCg5Ig7ZK6pDCL1GzS2d+8/tAzPgm3BJ5eMOm5/lKq1lElwmHFa4ogEoi8pr2DbmgACOMmAPKkbniOO9Eisn51V6efY3b2u+hExlvbNWIQjhVGGhEx0kxATWDkHJugMKVgTARY5acPXXOnrhgxvLVzUUsjb3yla1n13UOOk3DsxiVxCb8S07Xi+WNG3FGWAb/wlsevMprRLawbB3CWg37F6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbE2LnbUR3B4zkZAOMTt2MiMR+4lTFgimIUldomNLMY=;
 b=MuD8TxHroTPRTqEvfi1Yxfuf4dgBK8Q39vh6utFmlf4m5sQsE/fG0X22tEgsWkrgXKLZEGOcqdwPth+gnJvTa/5C1vhDB4/esFMwWhQiqdRCKGOpBso8noaoLsG9wHfUgpEgiDf3pT65/+eVpqMFD69js/WKbeErn43w+MGK88H3J/OZ2R7HtRXN05yVD11tqg6OP+MmgyDc1ZfXiKgQDpZ2I+lIOEi2ahlQqhfPXazWZEwn4lkOOkfGq9cr8FYspoo3sFbpHEM1fu2xnw9STHe5xhCJtaNBgS8tixcYNX7ZmAsYgZPua7SMt786CG8K9cVYNUfAW5gU/0pFjAoyFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:14 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net-next 00/15] Aquantia PHY driver consolidation - part 1
Date: Thu, 21 Aug 2025 18:20:07 +0300
Message-Id: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: 474aa94d-07d7-464b-b38a-08dde0c65dd6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TVRibW5EOWdmNTlKY0g3aFNCblhZbWl6NWlwbTZHeitSL0RwV0JPR0tVLzBI?=
 =?utf-8?B?SnltYkJkbUJ0anVhWGJ0dnRORE8vREo4TTgwQkZ0bFpOTzlrTGhPRVBHaWtF?=
 =?utf-8?B?S3daT29KbXpRRWhxcTZWWXB6Ri8rMnc5QXhoWHZZTEpPUUhnWmVxWVV1MGhK?=
 =?utf-8?B?cFdxZWdyN0NCT0hNQ1ZSVG1wWDVsNGRYRC9OU1dPQ3lJc2ZJeVpwZzNHZFY3?=
 =?utf-8?B?TTBPZUlpL1BJMHduclZxQnZ6QkpMK1B5Z1ZxWXduQXQ2cDVrU1lCVldVTGUv?=
 =?utf-8?B?cmhmSUJuckgvbStTTDBhZkprQ3FCZllnRkNWZWc5OTBQSHFZZ2ZGNTdQYTJx?=
 =?utf-8?B?LzlGYzBYQmNMN3RNekNQS2xaWThub0M1OW02SS9WME9BOXlPR0NpcythWlJB?=
 =?utf-8?B?K3dmZ2lqWFkxWEVid2lWOEJWZi9BWVhqTHBZamdKQzQ1MGZoZVc0L0hCUC9n?=
 =?utf-8?B?QURPNjFNbGhGN1JVUzl4RFRVZm1SRjR2NVplTG5iOVEvMi9wNVlFcHdydEtD?=
 =?utf-8?B?RVh6TmxiaXdscCtDRHpEVFZENXM4L0p1cmt6elVlVm80TFVYcFU2bHNTRGl2?=
 =?utf-8?B?ejRIRnZ0Z1d3SUNkTE1mamNNWTk5d2FCT2ljTTc1RW9uSm9JbmRVT2FCdXpX?=
 =?utf-8?B?U0gweEp0RG4xaGRwRzNhNG1UZ3JkSVpQemJodUpZazJKbmY0N3pnVDBMREQr?=
 =?utf-8?B?ZCtBUjFGTHkzbWpwQlVDTEpMV3ZkcHI1SDNlcGp2aTBaejF5Wk0vTXI1R0h3?=
 =?utf-8?B?NTljb2R3SlpvLzhMaWh4T2ZIRFhLSW1KQzU4SFM4WGp5RXZoZGp6eVprOVpV?=
 =?utf-8?B?ckNIUnFKeHBmclFEZmhUYkRhaWMzV1N3dWVXa0NwWEZjN3lHSGlaWisxMXV6?=
 =?utf-8?B?YzNSc096Y09mZGxyTklOTENSdDNTTlBNejY5NXNWalFJa2I5ckpIL0V4am4z?=
 =?utf-8?B?MllVTlVTbVQ4Uk52SFNJejZxZFljRWpwd0xkM0c1KzBNMDgwRnBSZ2NyUzUy?=
 =?utf-8?B?VTdLZjQxQ1czSWdVV3gyNFl0RUE0RUZBbk96d2l0UHNtUEtoajRuN1RFRkFV?=
 =?utf-8?B?K2Q3K3dweElzamJBU3VEOThoZkFLR0FObHIyZTc1YWt5c0FhVVVXNkJyZFZO?=
 =?utf-8?B?VkhYa0VXTm5DSmZiV0FOZnlzSFpGN2FGYlRFSTE2WWNXLzVELzZpSXE4cjUy?=
 =?utf-8?B?MDUzZlJQMXRVc0x2NUM4YmNDNjdiSzhiUysvbmNkUjhmdXJETEN6cjlTbDhV?=
 =?utf-8?B?SVJ6dFNKZ2RrM1IwRnJhVmo0eWJwM2NsYlpGb2dXZ3ZNQjR0SjZHenBhSWhZ?=
 =?utf-8?B?Y2dlZW96eTdMcGtJc3p3bzNWNTZmajZxTmhBNjNBck5teFZaZy9JZmtvaUta?=
 =?utf-8?B?UStzTGJIN3hGY2lNc2VackFYTTZXMWYydUF5ZzZzcGpKdkJDUHBZRUZaQ3hX?=
 =?utf-8?B?M01vNmQ1VFQwMnRtK21pM05DM1BRZTZpSUNTUnkzV1J5VEkxV1hFM1d0WGRM?=
 =?utf-8?B?aTlDdisvUUdsd0IvdDJjSjdldEtwREIwS01yTFg4d2xLQmxQaXZWZGZaS0ps?=
 =?utf-8?B?T2tldzhIcEEvaXkrOVlTMWxFQ2t1bXd0d05JWGI2MG9oc2wydGQyY3g5NkpE?=
 =?utf-8?B?bjhhVk1QRG9NVVNQbmNhQUxtQ1R5WkNCbmhpVnZyTnFhbVdUSGRaSkcwRFpq?=
 =?utf-8?B?MEZTazBPVDJ5eU14Nzg4MWVobXJuSkoySlg4WENqODBnZFlXeE9FWTVPaGox?=
 =?utf-8?B?UU91dUpNd3NyQXdZMVdBa0RUSEtWYlA3SXN2bUNMUm9xS3VGNSsySi9FcmRB?=
 =?utf-8?B?TFBRQkJBRnhaRUFoSmt1UTBxUVpVYmtVbWtaWWlEcTlFeHFkeHd3NlkyR0NW?=
 =?utf-8?B?ZllqS1FlUjhqUThDUStrTUh6eklLMHZTS04rdjFCekhYS0F4ZjBvY1d5city?=
 =?utf-8?B?TTZoVVdLMmF2dDNLVUhOOERoMys2N0VsUUMyS1Jvd0toKzRPMkVXamRNL29L?=
 =?utf-8?B?cGVQTnNNL0FRPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?azNjUERiWFpIZ21NUmxSTTRGSXIvY1dXNFN5VFErSGVkbTVVcWl6ZGZXT20r?=
 =?utf-8?B?Q0VGcWpQOGNSLzFMZU5UQlZTNkJzd3EveVVIbGh5OXQ1bHVuTVZ5REtmaUxU?=
 =?utf-8?B?OXkwWjd5MGZmNEVrQ1ltUkt6a2ZnbTFBQ2JWbWxvY0IzcnNsd0wyWW15MUR1?=
 =?utf-8?B?V1pTMlc4Z1E3YXlhVlpnQ2xIbTlOU2FRS1BlWUtxRVhtdElHOGM4WjJUSDFD?=
 =?utf-8?B?UzZUNzJzb1BFYXNuVEVxaVhUV3JQdUFtWlZZdmY0c2g3eFpUYy80cm90WHU5?=
 =?utf-8?B?R3FEcm85QnN6anBqVU5iS29QaE5TNFJXVktvT0VUL2U0b0xMR3I2TGVQc2k3?=
 =?utf-8?B?dFpuOEJHYitrOE44cjJJU2wzTHowcG5TaDhaSHEvZktWemI5UHpyalVwY2JP?=
 =?utf-8?B?RmszOGNnenlxN0I5R1IwNkZFRm02Ukx0WWN0L0VyTkNaRmp1MUlhdVJrYWRN?=
 =?utf-8?B?Q3crankvOUpxWldrUmg5ZVhHc2JKdnlxN1E4bStNeCtMa0lGa29nNGVFRnpv?=
 =?utf-8?B?dzV6U2pZdmZTZkUvRHBBSzRpcXlEdXVyd3VsZ0hvcG05cktkQ1lnbTRzTVNw?=
 =?utf-8?B?cnZrNnVxVndsbnkzd0RiS056US9NcGlSVk9iZDcxOXhZRDQ1RWo4Wk9KNHVK?=
 =?utf-8?B?RWR3d0N4ei8ydDI0d2ZsUkx0alhKVzM4aTNCZzVWWDQ4bEFjSEsyZVgrb09o?=
 =?utf-8?B?TFJrWjVEbHRGR3JIay95ZVM3bk56UU5qMHVWb3BVemxjL0VyaU1uK0RBdXpF?=
 =?utf-8?B?UGxzQk9PN1lYaEN6MEVaTDVDMlV1cjJ5eFcxY3FZd2M3RHF4Q0xuTHpNSXdv?=
 =?utf-8?B?YWFTa2w1MGs4a3RqWnpPaVdGU09KTVk3Q0lURVN4L0haczBZS1BtbmpBbnBx?=
 =?utf-8?B?R3FRWGtoR0Rwa0owM2JNTnlnL0RJTG5CWDd3V04xVGliaURmZ0syZG1oU0Fr?=
 =?utf-8?B?RHAwek9pVWUxWDRUSXVCUDk4ZTE1eEFCajNremdEU0Vkbk5CdXJGUjU5WmNz?=
 =?utf-8?B?b2dlUFYyTGRFNWV0QXN3QXpQbStCMFo4aEx2Q0hFaExhVTZKVHRrMVFWVDk2?=
 =?utf-8?B?TW9QaWJ4S3FkVmNtY0p6bm9HNHorcTVJSmlzWS9IQWoyVFdPZzBsMnNYbWcv?=
 =?utf-8?B?Z0wzZ0hvY1ZqZ0VSZXhNNnB4dXRnemJic09TQ0dQQ0JvQ2VtWXhRMG9MMmZu?=
 =?utf-8?B?SFpkTGMrSnFMcFNaaU8rOUcwREhjWGh4bG9YWUxxMTlqOWVoWDZHL3hiSUhy?=
 =?utf-8?B?NzUzamZiRTJCNWRDaklWOHk0ZUlhdDB3UmxDc0NKa09jdG5kQWpzVyt4Z0l1?=
 =?utf-8?B?aWhxSitpSmUyRk5Vdi9BdWVzMzBwVitmeGFwZmJtSklHNE5kaktjQlY5Nlc0?=
 =?utf-8?B?MXdtcDVLaHUvVGVMSlRyMEkydFhsWmhKdFN0U2J4VmlVV1F2SDRyM1BsZ2VI?=
 =?utf-8?B?UGtSWHBXS2RPSW93azdDdEVNRUdrNGsyRXQ4WUN2NmdJKzZ6c053MUZJTXlw?=
 =?utf-8?B?bGRCdEt4NnpaaG9BYjIxalpkNEZucEJaelFxQWo2dGk3RUhBVjVsNWRZMlA3?=
 =?utf-8?B?MWMwRnAxd09SSUU4aTk2YjlPMWFZa2FIdHlYdVpCUnFIekFwajVOcXNhN3lz?=
 =?utf-8?B?dUlFTXlpYkt2YjZBbXJ4WEczUWtWbmN1b05TY0ZvbVlxNUloOEUySitiZWd1?=
 =?utf-8?B?M0tBVytXU1FlQi83RnY2V2ZIQW9ndVBwaFRGV1NTRURpb1BiZmg2YUhXNkl3?=
 =?utf-8?B?ZnZNN0d0dlFENm4xZlNaVTJNdGpydDNreTZkUUNDWnJ3TzNLUFV4RWg0WWto?=
 =?utf-8?B?dlFaMmdoQ05HQThmaGlraEZKQ0QyQ1NBYy85K0FWZ2loK05YaVY0eDl0alpQ?=
 =?utf-8?B?TlJiVFBCM21aYi9aNWtqMVVQMU9oQnJPWjBSczhpWTROWEtsY2xQWE9lM0k3?=
 =?utf-8?B?cGNSYjUzNW8yLy9jSG4zSWZzdDVzbVlZVjZxeVoxcUlRL0g3ZmtNQkJlZFZn?=
 =?utf-8?B?dlpFYVhPZW56Q3dHR05ac0NkbjhHZEo2LzQ1QmRuMEM1NU9HaUE0M2JDVnBi?=
 =?utf-8?B?bFVKM2dXWmpCK3ZiWlVKSDhDQi96ZEdVVGZteFZ6VDVuK0Y4WjRlNFVxckUz?=
 =?utf-8?Q?dl2P6WofnPmeY0r9bf+MfV8O9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474aa94d-07d7-464b-b38a-08dde0c65dd6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:14.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyAf2DRxPUif1meV+Z4c55SLwzDGOb9dWrlROa3/B6RD8Pg3KXhFRHct8whBWZ/FDxsdDWWovXK0uXOPlsPfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

This started out as an effort to add some new features hinging on the
VEND1_GLOBAL_CFG_* registers, but I quickly started to notice that the
Aquantia PHY driver has a large code base, but individual PHYs only
implement arbitrary subsets of it.

The table below lists the PHYs known to me to have the
VEND1_GLOBAL_CFG_* registers.

 PHY       Access from            Access from
           aqr107_read_rate()     aqr113c_fill_interface_modes()
 ------------------------------------------------------------------
 AQR107    y                      n
 AQCS109   y                      n
 AQR111    y                      n
 AQR111B0  y                      n
 AQR112    y                      n
 AQR412    y                      n
 AQR113    y                      y
 AQR113C   y                      y
 AQR813    y                      n
 AQR114C   y                      n
 AQR115C   y                      y

Maybe you're wondering, after reading this, why don't more Aquantia PHYs
populate phydev->possible_interfaces based on the registers that they
are known to have? And why do AQR114C and AQR115C, PHYs from the same
generation, just having different max speeds, differ in this behaviour?
And why does AQR813, the 8-port variant of AQR113, not call
aqr113c_config_init(), but aqr107_config_init()?

I did wonder, and I don't know either, but I suspect it has to do with
developers not wanting to break what they can't test, and only touching
what they are interested in. Multiplied at a large enough scale, this
tends to result in unmaintainable code.

The tendency might also be encouraged by the slightly strange and
inconsistent naming scheme in this driver.

The set proposes a naming scheme based on generations, and feature
inheritance from Gen X to Gen X+1. This helps fill in missing
software functionalities where the hardware feature should be present.
I had to put a hard stop at 15 patches, so I've picked the more
meaningful functions to consolidate, rather than going through the
entire driver. Depending on review feedback, I can do more or I can
stop.

Furthermore, the set adds generation-appropriate support for two more
PHY IDs: AQR412 and AQR115, and fixes the improper reporting of AQR412C
as AQR412.

The changes were tested on AQR107, AQR112, AQR412C and AQR115.

Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Robert Marko <robimarko@gmail.com>
Cc: Paweł Owoc <frut3k7@gmail.com>
Cc: Sean Anderson <sean.anderson@seco.com>

Camelia Groza (1):
  net: phy: aquantia: add support for AQR115

Vladimir Oltean (14):
  net: phy: aquantia: rename AQR412 to AQR412C and add real AQR412
  net: phy: aquantia: merge aqr113c_fill_interface_modes() into
    aqr107_fill_interface_modes()
  net: phy: aquantia: reorder AQR113C PMD Global Transmit Disable bit
    clearing with supported_interfaces
  net: phy: aquantia: rename some aqr107 functions according to
    generation
  net: phy: aquantia: fill supported_interfaces for all
    aqr_gen2_config_init() callers
  net: phy: aquantia: save a local shadow of GLOBAL_CFG register values
  net: phy: aquantia: remove handling for
    get_rate_matching(PHY_INTERFACE_MODE_NA)
  net: phy: aquantia: use cached GLOBAL_CFG registers in
    aqr107_read_rate()
  net: phy: aquantia: merge and rename aqr105_read_status() and
    aqr107_read_status()
  net: phy: aquantia: call aqr_gen2_fill_interface_modes() for AQCS109
  net: phy: aquantia: call aqr_gen3_config_init() for AQR112 and
    AQR412(C)
  net: phy: aquantia: reimplement aqcs109_config_init() as
    aqr_gen2_config_init()
  net: phy: aquantia: rename aqr113c_config_init() to
    aqr_gen4_config_init()
  net: phy: aquantia: promote AQR813 and AQR114C to
    aqr_gen4_config_init()

 drivers/net/phy/aquantia/aquantia.h      |  28 ++
 drivers/net/phy/aquantia/aquantia_main.c | 531 +++++++++++------------
 2 files changed, 289 insertions(+), 270 deletions(-)

-- 
2.34.1


