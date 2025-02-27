Return-Path: <netdev+bounces-170342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C46A4847B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3510117A0D7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9101C07E6;
	Thu, 27 Feb 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ehl1KWKz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B51C1F12;
	Thu, 27 Feb 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672104; cv=fail; b=mwwW12Ix+MLQXqVAHXWS6JRh82BjROo/ggYi3Yd0hRI7dHmhtbgaa1b831H3D8oRWdR8q2GmO33HUAGMuT9oyKbadp3Cl0Gu3m2PiOhvFDrlTYKYjYqOuB5R3aGm9Wml7QciQgBjmY2GPHImB2ILtinNb6JUJ2mK4h6GHbuk+io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672104; c=relaxed/simple;
	bh=T9zrsyUNtUyiKS8TzG6HPmP8BfBWAQnfck+Itfm5CWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BI8xIzmTkGqEdj5Z6SP/TniIbmFkQi1q4Kz/AlirpQSjet2kzCd70DVJCprxR/nrBUjdgv+zIMZQ72E9QCA0R3TqfKnRS/kerfIYJy2xvOQmGf6nH4asBg5bnzlghpKrKGHAwA7YE3FnRCBf2l0CF1k2Gb8GrTfGGVJfBVcxOEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ehl1KWKz; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCVu15tTDktosbvq6BRThk+jZ9SzeDFpJdijF94PzD4GOrbcFGaNoGmXGM6Z0wIev6H7roIZcRhAM4FExQkIwSF1HQHGlYfvLRCFBTqVsWKePKDUjGQ4e/Ns4esuxYYhpQ77ovui6TBiXubxKoDd+AwyUu0XeqkjT1TGd0CVG8nq3yg9QHfHGLT0KVAwBNa7BU+WQW+qxmzBzJthdF53TOyJa8e8A1djcYAKc+QjhQRqxqflG9M6T7MxpZh4cCxigxs+1cdLW/d/Cq2lnMOhoIkq/f5WJHxVZ7LP3GI/6+AC3FpPClClFDvYuzxVsbl0UrF/2oyOHsJoQS+AK5oQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKFccNKLk6bXrLGVs03QGGShzGfrL3dftPZIgxLf04I=;
 b=snUxI5eWrUJ4OJjK01yTKyZoVDQAM76mlrfvfB+HCwAcvlrWNNp7+mEfX/S0j+PjJgP5feRdnAvJ/9OTC/aVlqulfEvhPSfw3IN6VUl3RqQbbxTtnibmvySRjxUofEexfyiT8GhUvdO/bR3f8z2eMwXECtFKbVIA29DTK6CirUPuqebjLxnqY9M/j/J1QfyNCMO36GNLUbCZwkIXzMQFGhkA5GUYK/hKe6sR876YOuf4MmovHqIGIjDtjPpssA8qOILz+wg5GUcxKIFNEtsR76W0zGjSzEbnLoPqyjEsWauu2wRzt4kOX/+Z8HeBvlyCIKmA2h9EIWauKbjahuxtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKFccNKLk6bXrLGVs03QGGShzGfrL3dftPZIgxLf04I=;
 b=ehl1KWKzdsrV+Ksaj731xebE8XqB3qaKnMSUVQGtRY4VtXZ+4VqHs8NedvJXJloRYb7YmU8Wr4bW6mRofwZjh6Ekjfb5k+dI1n9MdKHmmeNBgTDcx5m/s9h30XEUXZ/3wytzmHfs7WgePaPS4BALlMcdhlM0QEJY+17LxNpKQ12pYbrWq/nEEWOS6tEr+zKYjNQAAufAousqns6eJbjw3I+5ZB5YymPkx3Yk6Jky1PSEUfn4HTO7QJM+U2HqYb8inNbg8ysFHvohLn77zETvCS6xrTkgJGVUDNKJF0MUruIPYeVl6G8TB+7+l6oit0NwzVlliPB6cExL07x2sGCoUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by DU6PR04MB11229.eurprd04.prod.outlook.com (2603:10a6:10:5c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Thu, 27 Feb
 2025 16:01:36 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:01:36 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 3/3] net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata
Date: Thu, 27 Feb 2025 18:00:56 +0200
Message-ID: <20250227160057.2385803-4-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::7) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|DU6PR04MB11229:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2fba4d-8038-4a7b-87bf-08dd5748031d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUMvZ3dWU1IwRVU2YUxiV3ZRZFg5WkRHMytOLzNEQVU0RFhyOHgzcWdiYXB2?=
 =?utf-8?B?VmVoN3lFSGhWZE9nUlpoV09HNEF1YWg5K0tLQlp0K1o1SnRFZzJWMXl4eExC?=
 =?utf-8?B?eXM4T0toazJyTHRlQUh2T05qOWF4R1NXQk9wbzYxQ3Y5ZE15WjRCOUNFcWZy?=
 =?utf-8?B?dVIwL1VDZmZZYVlNQnltekFDM0dBdmE4M3hZek9iRzltZUhLWXVJa3pYOERL?=
 =?utf-8?B?dm0yc09xRllxZjArRkdEaVdYRnRQN2U0cENwR0VmQ2ZPcDdGcUlGTndCWUx3?=
 =?utf-8?B?Q2lYZE80NmlYaXpUaE5ZeUgvNmlKMzFDQnhxK2NEVnZsTmtpcjFYS3lzY0JE?=
 =?utf-8?B?Y3hBZGV6WkhkM1BwRkJUbEswT1lxZ1psQWF2dUFidVluTVl5OWRxdEJ6ZXg4?=
 =?utf-8?B?cVBhcVhnOGg2WlpPQmt2ZGdjVUlTQi90NEEzMWZwS01mSVlsRGFnd2pBSTA2?=
 =?utf-8?B?bTB0Y05SaU5OazB0NXh3OGFORmlXM3M5OWpBTHU0VmxjY2FVbUVueXNGY2JE?=
 =?utf-8?B?a2FoQjZCaGhUTC9WYnBtaGVsdWVpSFFwOXNZc1I3bTJFd0xQL1lDMWk5cldO?=
 =?utf-8?B?cXhpRmd6aW9RVjFZb0FQOHllSjhxZk9BSVIyY0YySkVJb0VyOW9LUGNlUmZE?=
 =?utf-8?B?NnJ4SlZJSmNGNnpYa0dYaUVFSkoyQitsa283VklRNHR6eERUckRTYXAvV1U5?=
 =?utf-8?B?QVRJV0V4dzBUNGM1U1o4QW1PbUVpZ3Fsb0VVd2lrbjUyQ05RNE16cVdHZGZU?=
 =?utf-8?B?bDZMTG1FaWhGNTNhWkdLOVJUc3FoQzhyRFIycVkvREhYQ0dVY0hlR0xaRG9w?=
 =?utf-8?B?bi9wYXlNb1k0cEpHb0w1UUFPM0pJb1UzSytHanlnbWZXWStmemd0ZUlTUCtn?=
 =?utf-8?B?aHNhUWNvTDVzakZnNXQ4RzV4REJVVmJVOFJmeW5BNVV4dWxhTU5ZZ3JpQUZQ?=
 =?utf-8?B?SnNuTnBzTWVtUGR4aDcwUERieTUrNnczeUhENUtWNnVlUUlrbEJiVE8xcm9B?=
 =?utf-8?B?Zmpxd2JUdXgyYXFVOTBWU3Rlc2RSMkF3Qk1mMzdqeEIvK2JhNXgvcEJFZGNG?=
 =?utf-8?B?UG5QQ1RkUEhoRXVyaXFZdGxMY3dMdjR3UmFqVUFMazhxTXpVMzdkMGFHOFM5?=
 =?utf-8?B?Q2xyak9rNTRVQURpS3ltb3hUUEIzWUVGdXdlL1pGWHRwVTlCRmQ1YXNjVmZ1?=
 =?utf-8?B?U1hlWlBUNkJSdThMOE5ydEdsV1I3TXFGaGFERERnYlZGY3FiTUVmMngzZEl5?=
 =?utf-8?B?QUFkaXJJL3ZZdkdtSGMxb1VkRW5LMDZxdnB5QjVVVUxXVlV3SHREcjJHcmpi?=
 =?utf-8?B?ZSs4NDE1TjRGTjhzSEtqYk9tTkhBY0dYWmpKMGdqbUNHZkM3MzIvcjRuZ3hN?=
 =?utf-8?B?K2lxWWJrbEEvY0M3bGRPb0lOZHVTSCtHUFVRRGVYdk4yNGM5NGI1Y205bytT?=
 =?utf-8?B?djVnM0QyeDJMckRyc25JalVpVjhKUEk5b1A0UHBWK2tmdkZ0bGZiQTAwbktH?=
 =?utf-8?B?VDJNMjZjY3d4blIxaWpWcFAxaFJnejBHd1NRMVB5U2tLY3k0T1RWRHJyNG5Z?=
 =?utf-8?B?SHM3VUNLWDBZZnd1RStvTnoyNzBWa0pFbHdjZGpKZmx3OFR4c044TzRhQjVC?=
 =?utf-8?B?R0VnZDkyREFscFdtMWFnd3l6dnoxWDJOY2pDc0lwMWNvekJyUytvSGVubVR0?=
 =?utf-8?B?MG1ialZRdExQTlZGM1ltcUU5azF0N3J2RE9KbEN4bWVKZmpZRXdORlJQZGVu?=
 =?utf-8?B?OUxveHdETEd6RmxxUWh3cjIyL1ZlOUtrQmZYVDJHdHErL3htVjNIYmR3YUxG?=
 =?utf-8?B?eG5pQ21JZTQvZThhaldFcnhZcFc2bHpQb2tFcktpNE5IUEZCQklzV2x3Nk0w?=
 =?utf-8?Q?+/5D8x8O55+jP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2JHRy9LWnV4SXRmZWJ0Q2IzbU01NkdxcnZCc3FNcitUWGQ5ajhDd2NBNk8r?=
 =?utf-8?B?M04wRElFV3JXbGdWOTFtT0c1WmxyTmQwMHZzdThaQng4S21PWjJPeGlCTk9S?=
 =?utf-8?B?SmgvVDNZN0F4OTVQNHk1ZjNIa1hKdUFTalBubEhGSjJtc0RJOFo1T2pHcy9P?=
 =?utf-8?B?a2ZmMU1DbklHbFlOd3orR2RYMURwZ2xVOXBDWC8wVTIzUVRFZjBpdHRzYWR2?=
 =?utf-8?B?RUlycVNMemNaaDIrT0R2QWRiY3BpV3M1NENtSWtuM21SbkVxbU9CejhwL1pj?=
 =?utf-8?B?eWpYdXF2VzE3U3R1NVpKbzk2ZVorNXcvRW9qUEhQLzcrRVMrWTdpUi8wQjY4?=
 =?utf-8?B?QWo5d0hzd2R3UEZZQjFWdWxNMlg2S1V5Qm0yaEl0YmVyNG5kTlBJY2w5SEkz?=
 =?utf-8?B?V0VRNWhjaDNyYTRtdGJ1YUJPbzBFSjdEZWIwUW1TMmRwaXRFV1FRc3I5Y3RG?=
 =?utf-8?B?YWNQNUkwdFF0c2djZmdEYSt5T0J2SjZuLzdlZmgwMFUrK1FkM3FxTUQ4QStW?=
 =?utf-8?B?eHkxbjVyeXp3M0hkYldxOGlPWWJ2RFgyMGlXSUNRWmFXZnhJRXlxTEMzbnF2?=
 =?utf-8?B?Rm9vUUxXNDZpanlpeTdsbTZsMUZUZ2JGNDN5NDZyaSthb0tXUDZQRXFhUHNC?=
 =?utf-8?B?Y2FJQlcxd2RmSVFLTEdidDdKT05LYXdsblFKcjJubUdYaTU1N0d1K2piUHlV?=
 =?utf-8?B?TEY5aVVBdXBTUVJKV1ZZdEhKVC9ITTNrSG5na2h2bGpUNEt3b0VNdEVxUWFW?=
 =?utf-8?B?UGV2L2ZDc3dybTFLVUhmWW1Fc2ZKMDRkY1VBZVFZUG1EQkUyMVRDNzZZSHhy?=
 =?utf-8?B?aGkxYWdIN2RJbHBMOWVWelVVcFRUZWl5Ry9jbVMvSzYvWUt6MS9ScS9BQ2Jk?=
 =?utf-8?B?S2NDdGo5N3pCRi9BQ1hkTGpQNk5CaTdwaXQvczBzWFM5V2dtaTRzTkJZRVps?=
 =?utf-8?B?SzJPWDRsM3VZNGh4Rm9raEt4VlhpTFlSbGY4Q3JYYmdaSFl0Z0FLczRnQWtC?=
 =?utf-8?B?U2Z0emZmVXVZWXlyZ1pGWW9tdFY1MDZQbHV4L1BTUGorb0JRN3RtYWFMc3dP?=
 =?utf-8?B?QXNwSUN3Qm1rdzd0eDFlMjA1bHVqYVQ4QXlQdG9sbmdwL1J6Nzd3Q2R5bG8y?=
 =?utf-8?B?cXhHcC9RUzN1NmlJUFdJaldZY0NYUHBJeWwrRTRHUDh5bDdyaVg4UmF3NEI5?=
 =?utf-8?B?anFVTVdzMUJaeW5xcnpYemRIVk0xRG5OWjlyUzBUcE93V21aTEs4QXNnci9M?=
 =?utf-8?B?UlhKTTVWRzZrUVFIcnJRNy8wMjhwUlVLbXdGdGNUUU00Q2k0WkVzYVh5Zkk0?=
 =?utf-8?B?SDMwY2FsNU1ZYmlZTitSQWd2ZFlkdzVQTUVBUDFRcHZYU2JvbGd3ZWswdXVN?=
 =?utf-8?B?RjBsRzRpcFlFeFRQWGtuc1c3bVBKS2ZObzJFTzNSRHdNckg0SmF2QzFDam5W?=
 =?utf-8?B?RWdDdXpXSUlwYWpGazNvVVpjd0hBQ3NrRElCWmc4ckZzMDRSc0taQWxJaEcy?=
 =?utf-8?B?c2doTG00bEgxeHorNUNLZlpOMmdJVGtMM29QcEVZcU45dFI0WllDYTJ0djV4?=
 =?utf-8?B?M0ZDTVdQRHV4dVZuTm1qZ1gxZmlPd3dyMFFuVTFxQllYRlp6cmx3QXZCSWpF?=
 =?utf-8?B?K0I0SG1jY09sM1dja0lzQmRITHdIemlOcy96VWxkUTN5YnV6QWZOTi9TeFBL?=
 =?utf-8?B?MFVSc3ZjRCtQSFFqQmdSWVEvbEJsbnMrT1FjV2hiNFZXU0JwamNBbFRwWjhl?=
 =?utf-8?B?VXBkaGc2c2Rid1VSdWVPak9hZEMvYUt5OURTYWpBM1pPU2ZJT0s1cWxrL1VR?=
 =?utf-8?B?YWlhVGluMDFLUXhXMW82d1owNHdMRXFMcnU3OU5GbEpyTkFyT1JiZEVseFh6?=
 =?utf-8?B?T0FscStBUnQ0dzFNM25YMGZsd0hrbDV5VTNib0wybElSamZwZ0dNVDJHb0kr?=
 =?utf-8?B?SGw3NHUxUHZIU1gvRHhSL3loYUtVeXo3NFhiMllRcUJtalovczEvSlh2TWhL?=
 =?utf-8?B?K2o1NnlobUNhQmJ6TDBqbmhENnpNN3pOVUJqNWozWEpBMTZ4cENOMzhJc3BP?=
 =?utf-8?B?VzdvMTBJS2YwbElvYzA2V0pzd0xnTEtJSVEyK3E2dXpUalN6djhtUXNjTUFK?=
 =?utf-8?Q?9c8YVMJwmU2tjUmRy+qTJTVEt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2fba4d-8038-4a7b-87bf-08dd5748031d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:01:35.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RoHLYvEjsytdGm3lOVP3AqNiSKJIRzz06sqLZ42kI7Smdggi37iviHdkh/HqsqDDJfVHaXzeubxn36og8FiiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11229

TJA1120B/TJA1121B can achieve a stable operation of SGMII after
a startup event by putting the SGMII PCS into power down mode and
restart afterwards.

It is necessary to put the SGMII PCS into power down mode and back up.

Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 2607289b4cd3..d1de99bb3954 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -116,6 +116,9 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SGMII_BASIC_CONTROL	0xB000
+#define SGMII_LPM			BIT(11)
+
 #define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
 #define EXTENDED_CNT_EN			BIT(15)
 #define VEND1_MONITOR_STATUS		0xAC80
@@ -1600,11 +1603,11 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
-/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 & 3.2 */
 static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 {
+	bool macsec_ability, sgmii_ability;
 	int silicon_version, sample_type;
-	bool macsec_ability;
 	int phy_abilities;
 	int ret = 0;
 
@@ -1621,6 +1624,7 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
 				     VEND1_PORT_ABILITIES);
 	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	sgmii_ability = !!(phy_abilities & SGMII_ABILITY);
 	if ((!macsec_ability && silicon_version == 2) ||
 	    (macsec_ability && silicon_version == 1)) {
 		/* TJA1120/TJA1121 PHY configuration errata workaround.
@@ -1641,6 +1645,18 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+
+		if (sgmii_ability) {
+			/* TJA1120B/TJA1121B SGMII PCS restart errata workaround.
+			 * Put SGMII PCS into power down mode and back up.
+			 */
+			phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 VEND1_SGMII_BASIC_CONTROL,
+					 SGMII_LPM);
+			phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					   VEND1_SGMII_BASIC_CONTROL,
+					   SGMII_LPM);
+		}
 	}
 }
 
-- 
2.48.1


