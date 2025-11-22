Return-Path: <netdev+bounces-241007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86204C7D65D
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400863A97D3
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1782C3250;
	Sat, 22 Nov 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cqj73uJD"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA02C158E;
	Sat, 22 Nov 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840049; cv=fail; b=RluBSHwtiTLiT+tvyRCv3QaipTMEy/t8YEv1pPKkRh/7hLPtos1AxMp132/0B/ije3oN4ia22ci8hWZb15vCad3Krnia+5WcnUjCmd0bKQAdzFYm3HZwDKTUVT/uerN9WhYgMujof67Q+CDKdMIOfGs1/oFTpKITnUdod5+gNTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840049; c=relaxed/simple;
	bh=cmp3L/XKXZRQnaQhCu+zoR8JbdLnUPWmQFqnNzvOyNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLk4iAMaAF+ow8xU7HBHPZIsVSbx3ungfG22DDjJVw1gjYPZVYCVjzeDMAaB6J2yaVSKbABBvW4jgZTkWMpnSyleHYq9kJOIdpn/hMrYDo5RTRdREmpFqwQ9FORFxJPLHxY9U+6z6TX+clZa7owTnzY9SOHV12CxZGtlxPQANaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cqj73uJD; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CERt2CnJEC5Ydl3k0kvB4368D1XElsIkod1+sAXGmkbIHkaNTyP3bV3tI/4sTWJVB6ae77Zx3Jyj3E4arkamWhmWPhR4vuWpyRtrc2AEez+cuzlRhxZ/Wu+7Ff5ooXoGcGK8MRc3hObieq0dM+yRkYl6ciAx99EqJU59ldubA8bNugz1uGWFE+GQzHD0pezJ6lSLNoefmsrrwkNAZa+clqT/05Z1jhNBGP5dpqTq5Qv2Bt+Ya0R4VaauqxA2MgREFiqZkcUaP2fNgSze/qbZj+zwBV3dpsMl5wQGbxcuDi0+/CDH27TRoJR91I483ShZOTklXrR3N/ZAGZ0CVvQNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC/ZMv1bNjW/zf8GrihDCoLrK0spQbT0h6SSzN1TQog=;
 b=vI2rOZML1y1mvfEpCcWZlQHz3eOoP2GEgPn2Bhy/fOOas2ENJgyfuX8CMuTKv/AXmI4kIHus8CS4WIfSMcqGKhMcvKKMBrwxD7k+x5h1d9hPU9YBMnbVx8oQYICG61Tqt5sHIdtAK7YV7uT8i8A0M+swi2Ex+EDwm13vy9bwZaklbotcmyId3ijLzIB8yKTyZviGnE0DY/pA4hs/PpRIuIykQDGAew0daeWoVRQ+OYQ8WYNU9RALG8BaWw37LQDTwaHIgExoAcWOt+o/xcbHpJ+9gj0MCCT+SiJAHNPnOORaJXmROckYziETzYQbdL6wQHz2ozSp8Z1s+TezPGBMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC/ZMv1bNjW/zf8GrihDCoLrK0spQbT0h6SSzN1TQog=;
 b=cqj73uJD5XFSvSQlRwwcLfCuaKABpyteyMj9q/n04CnRMmr2W0r9P4VGYG7oOOcu8/nvFniiw5UzRQuM9HvMP5chQjLQIUaT/KQEg4iDSKhgceigtCbm8kZfrdPWUdkAVK4IkJgMhulmwpcjj41j3KOuQGFMP2K/pZoFx8eBh2LQbRD3czk9GnKNw62+L9qwpLkM+0RXiAhEPzb2q7kCQTI827F+NMJPAie3FBdThgi6EzD0E9IlxYcqvMTDFj4oKVr2LMn87Yqh03HnJXHDbq0IODfIMWAoS8sWroUkVcDyOThXmdfD6r8V9yeawRSuCViNd+lXDrKaelz27/dTxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:33:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:33:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH net-next 2/9] dt-bindings: phy-common-props: create a reusable "protocol-names" definition
Date: Sat, 22 Nov 2025 21:33:34 +0200
Message-Id: <20251122193341.332324-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f7c517-1761-41d8-e39a-08de29fe15cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm8vbVdUMXkrQU1mYTM1QU5OaEt6ZTJ0Yi81SUVlTUhVUDFSTWNQWS9ObWhF?=
 =?utf-8?B?aG5ibER5TU5nakpMSE9pMjA3RW1LR1dzdm1KejY0ck0wdHh6T1dsallGTjlu?=
 =?utf-8?B?QW5tMDFOdFIrRVVVMkZuQ3ZaZWdrTERaYnhxOEQ1Vmo3NUVNQ1R0RjNNU2ZU?=
 =?utf-8?B?eDRuWCswdTBac1RFbU5tS2htVWFydTlaNmZZVGxYZjJ6NHFVeURCd0cweWg1?=
 =?utf-8?B?dWFIQmk0NGIwd1dKQW5Sa2xLdWliSWc3M2JXU2pCdkQ4VHVNTXVENHppM0Za?=
 =?utf-8?B?NzFlWVBvTlE3bzBzbzgzT3NuZDBxY1ZvVGV4SnFsYmVvNDFnM1F4clRDaGFE?=
 =?utf-8?B?Sm5sTy83MkplcXpub1Q3MnBKYno3bnVrZHdLbUpGQzNPN1VvMUVLaHY5UHE3?=
 =?utf-8?B?MnRLdndkaW1CVU1sVkl2Q3QxQ3oreEpSVXlZdElIajZpRlVKRHJ1UEF5QzFk?=
 =?utf-8?B?L2x3VTlreW5PdGh1UXcyV2pDT0JZZmlyZ1NTNkVGQTBkcHE0akZFWEovNmNZ?=
 =?utf-8?B?aGJNeDhWZ25KYzBvL0ZTN1NlS25MNEQ0bDEyNFZDTzFVR2RZU0VjZ213d2tk?=
 =?utf-8?B?alRvMXRYUGFRSFRnZkpvYkVwWEltamQ4a1lrajhrOG5PQmRmZ3lXVkRLTy9K?=
 =?utf-8?B?UUFIOTdSQTMvMkNXd2tpTlJTcDNvSGNZZkRsVzV3Z0VsWXljOHNnWEROMWg5?=
 =?utf-8?B?OTFqbDg2YkJSZnpwdUdac3dnL3dXakNSSGkrTG05eTJocDRoSm1FcnpwYVZq?=
 =?utf-8?B?NTN3UG40VlZVWFdaWW94VFl3Q1YvaXBYOC9TOXpRS1hoOUUxOWo5K1R5RjJW?=
 =?utf-8?B?VTE3QUs2RCs0YWtSNURSTUU3R2l6WkVmV29IWXJKWkFOaGFaSVY5amxUMWFQ?=
 =?utf-8?B?bk5yc2ZBY0hYc2d1aXdWay9UZnZmRkxnQ2YzRlBwUXBPT05vZVBNQ3IyMndP?=
 =?utf-8?B?NUFVRmt6UGIxMGpmK0ticFBSU2VlR2lyNUJCd0ZxN3B0WE1saExpaG9HZGxy?=
 =?utf-8?B?UzZLSHp6THlCRkpuNVZtR3JEQzdNamZ6M3FpWmRha1VMUElZSmJCTUJLaHBn?=
 =?utf-8?B?MFQvemJOY1BzOEgzZnd3L0w4bVYySWloQ09SMnRMVXkvem04bS9FSjYyT094?=
 =?utf-8?B?cXBxRHJwNHB5Q2I0MzE5dG1tYzY2RlFJZU93clZSc0JPVHQ1NkEraDZPN251?=
 =?utf-8?B?ZE9Qc21kbmUvUFVpTXBlNTkwWWxlTXlXRVV6SGl0L1l5bUZ2QW00SGdNenln?=
 =?utf-8?B?ajJwandhRXdFaTJlVGNKWnl5OEhlWlZvaXI3aUFkWCs3NEhMRUM5U1NCTExW?=
 =?utf-8?B?alErcm9LOGxZOTRnd0N2czRUS1MvWS9QSWZ1dzFpZWVOUDZySzNySU1XWm5H?=
 =?utf-8?B?QWNISm9ZWG5oaHNsbkdGeStXRytDdGFBbFVoR1J2WVZtYVVSbXpuMjJVeS9w?=
 =?utf-8?B?SFVwY0FPbTBORk1QN0I3ZXNJQmdsNkM4VHZmelZ0N3ZJRDZEZXZleXhwNDJt?=
 =?utf-8?B?ZG41U0Z4elFKbkRjYk12OUlabHN6U0ZBYWpuS1c0VDZJc2JUSUZQTnVxa1Rw?=
 =?utf-8?B?OXNYQk42QlZ0NEJtMmp1VVUxRk02SVlrbEIwalkrZUV3SEJucGtmeUVYbUJ1?=
 =?utf-8?B?VE54UEcrdnB2allWMThyMjBmU1g2aGZXcUhvQ0IwVUJwUGpEWGhXd0JYNU5x?=
 =?utf-8?B?ZXg5VGV0TTJ4eHQ5anlhUUMxREYxNlU5MVVXZzhMYnQzRVNhOFhPN0FORTRJ?=
 =?utf-8?B?dWJHbDMzMlZLSjJQYmp1OFNBcDI1c3FGNStTd3FxQTFZMVFCNFFiUURzQkxr?=
 =?utf-8?B?MmdEa3FsS2NRcGNVdUFSUGJLRmQ4YzUzMEhCdTBucEdYQUJ3S0JZOUxKME4r?=
 =?utf-8?B?WHZEVHRMR0plZSswREt3Uk4xZzNYSmx6bGJ2WHl3VklDYkJHM1N2N2VwV1lx?=
 =?utf-8?Q?WsmTHs/Pv/DstxTeP0oUIiXJqlmXen4U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWplWDFRZDEvYUg3RVJ1cWh2YmZKMmd6eVJrUzcxRDFzZjh3bGpteld1WFBl?=
 =?utf-8?B?WDJ2VkVBMW5ZTGxNTzJSWk9pZ3BWR002Zi9Kampmeks5c1Q1b1V0YUU3L1gz?=
 =?utf-8?B?UldsRWZuWmdFaUdkNy9XUnYvekFJeDU0Tyt5ei9XSnQ5WUxYVjQ0Q2tzd21F?=
 =?utf-8?B?QVIwZWtSay9meDlURTlMV2U1S2xLbnptTHFFaE16UjczYjJTVVNXclZ2ekpt?=
 =?utf-8?B?eTRZekMxc0Y4YVZoV3U2NlNIV054MHhDL0hPVFR3OENJNDFReHdDWTBvL1A1?=
 =?utf-8?B?RllBdWpSaHUvbXJaQzhkQm00NTJIWjFiUDhEdmpGckVJYzFXYkltQ1lrVUNz?=
 =?utf-8?B?UWFCQi93SjJicTdZejNLaDJ0NmdTRUlXYkpoSFk4QTEyNHVqS3RvMGhQRjY3?=
 =?utf-8?B?VVp2YXVBSTVRTlRPRjNwUVA2YWl0WDBlOTFYaW5Sem1ldHZ4WnBGVk93eEhm?=
 =?utf-8?B?cFY2L2hnTXZjUVdiUDVwbnpJZ1ZKUGpKQXF1SEk5RFZRZ0U2WEk3MUFkbXdw?=
 =?utf-8?B?Uk5BcldERlJETElpOEExOTAwa0VUSjRZTzlENnYwUUgxSjNzRWd1dnBrdE4r?=
 =?utf-8?B?dXFvcFdINnZLMDJxVDdhWDR2dXNwV3ZpTkpQVGRXdStqRTNZaVhNN0Qvb1cy?=
 =?utf-8?B?WjYyM1FVZEUvYnB2b1pCK05vWFJqem9taldaa3B0OEJhcXRWK2tZTndlZ1N5?=
 =?utf-8?B?NkZpYWswMkFkVUVKdFc2MUgzbTdUWHhtZFFjWXJoODJMNm1xSEdrRkhZa1By?=
 =?utf-8?B?R1JmWFIweFdyN0xsMGNrRURoSUthdUJMZDgyN1RQSmJrS0hvMWJIWFk0OUNl?=
 =?utf-8?B?VVhkbzZRS0psMWlqa1VtVmxBc0lWYTlBWUVhNzh4T1BkMDUyYnBCSHBaSWhr?=
 =?utf-8?B?amcycllaRElJci9SdlJPRFJyVVVlRGNRd2ZRSHBEVmZyMzMwN1lmZ1VjWGZl?=
 =?utf-8?B?aG84aFNMdHcybElhck5YMm8wNEVUYnk3ejRGYTB0NjBjNllLSFJ1WVdLWjZJ?=
 =?utf-8?B?VUY2bzRENlNBeTR1bzN6S2NjOTVUeUZGWmxsN3hLWTEyT2E3SWMrbVFPSlJ6?=
 =?utf-8?B?ZjNUUjNGZFMxQXdxLysvNGJXUjVEM01ONlhnL1V5cHk3MTJNZG1CeDdyRlpL?=
 =?utf-8?B?b3kyb3JPNS9keDNCV3c4bVlBaThBL09tZDNGT0dFWXVQSXV0VVRNOEJCYUo4?=
 =?utf-8?B?Vml1eVVBZVI1Q0U2c09UUmFKa1BjOFB0Vk9WRTZGOXRMS201d3NVUjZ1U25O?=
 =?utf-8?B?ZXcvRkhvdFRqK3RuTXNvb3JRSnk3ZXhHbVFkNlF6UHV3dkdLQk41bDNJS3hR?=
 =?utf-8?B?aVdYdjY2NWtDNlBydE82aitrcmZxZCtyN3BXS1pPbElMcC9lUHQ2U1hIMGJx?=
 =?utf-8?B?TE9heUVFMnZUNE5vNGVZaFJ2ZnBrYTJkbXV1UVgvcWs3TmlJVXA5WURBR1dU?=
 =?utf-8?B?V1BTRytEdmR0MlAvU3FQUmpzdldiOG9wRDM3R2MwY0FzUm5ubEl0MzdIa3lx?=
 =?utf-8?B?cUlpV2Vhb2htU1hreE9sM2lmekZHSnhsMThNT3o4Y1liN2cyUFNuUmZTWnc2?=
 =?utf-8?B?WDYyVXhPdVFscjBtMmtUMEpwcVl4UkMySXIwejkrTUU1WXdxdDhHTkhTa3Fz?=
 =?utf-8?B?Q1E0OTRLR1pPVE9UYWxTcTlzNzdUK3FYRWRVbVBmNExaREp5SjU5SnRkY3RT?=
 =?utf-8?B?TCtSU0FwT1NoTHU2Q3lmTmc1OUxuY2x3VDZaV1VzWnE1aEkrZTNtRld6Y1FQ?=
 =?utf-8?B?My9USDJReDN2T2JWd2RBNkRpa3NzUnBLTE1BUUF0RzlpRjZCbjdEajFwNE5r?=
 =?utf-8?B?R1NjNTdVbGx0TkI2K3Nkc09kdmxBM1ZFV1ZVZldRM1RNcWNiM3VNUENLSGRt?=
 =?utf-8?B?S2dSenhkakIxdVlDMTRlNW50QUZWRzVOZWtDZnB1c1pvRmIxQ3N3bVorUVAx?=
 =?utf-8?B?T09ZVlVmb2F0R2UxalFzNml0eFpiQit3dzZiOFZWa3JqSXVBdlp4WC82MFMx?=
 =?utf-8?B?QlRyYTRRQ0wzRUF5Q2dtemR1RG1NQUoyQUw1RzBQVkVmUTZ0cHR0U2U5MnRo?=
 =?utf-8?B?L1FSaVlEYndRam1MSmxrWjlOODgySkZqQVhneG16Q3NiSlE2NkJjdVVFUHM0?=
 =?utf-8?B?QTlLcE1VcmRlQkVsbkM3aDdkaE1ma3pLQUJ5TFlKYyt1QmJGV3lTZVErWWVs?=
 =?utf-8?Q?Ax9hRcJWtuqlCtRG7jQrB/8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f7c517-1761-41d8-e39a-08de29fe15cb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:33:59.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4ar3aX0pFz8af38iADLW5yPZ33YpWeRVO5fyZMQtiDGxuGcoLIB4RLpfNkiq1wzqf4lwdCoi9QUTHxOpnbfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Other properties also need to be defined per protocol than just
tx-p2p-microvolt-names. Create a common definition to avoid copying a 55
line property.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../bindings/phy/phy-common-props.yaml        | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-common-props.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 255205ac09cd..775f4dfe3cc3 100644
--- a/Documentation/devicetree/bindings/phy/phy-common-props.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -13,22 +13,12 @@ description:
 maintainers:
   - Marek Behún <kabel@kernel.org>
 
-properties:
-  tx-p2p-microvolt:
+$defs:
+  protocol-names:
     description:
-      Transmit amplitude voltages in microvolts, peak-to-peak. If this property
-      contains multiple values for various PHY modes, the
-      'tx-p2p-microvolt-names' property must be provided and contain
-      corresponding mode names.
-
-  tx-p2p-microvolt-names:
-    description: |
-      Names of the modes corresponding to voltages in the 'tx-p2p-microvolt'
-      property. Required only if multiple voltages are provided.
-
-      If a value of 'default' is provided, the system should use it for any PHY
-      mode that is otherwise not defined here. If 'default' is not provided, the
-      system should use manufacturer default value.
+      Names of the PHY modes. If a value of 'default' is provided, the system
+      should use it for any PHY mode that is otherwise not defined here. If
+      'default' is not provided, the system should use manufacturer default value.
     minItems: 1
     maxItems: 16
     items:
@@ -89,6 +79,20 @@ properties:
         - mipi-dphy-univ
         - mipi-dphy-v2.5-univ
 
+properties:
+  tx-p2p-microvolt:
+    description:
+      Transmit amplitude voltages in microvolts, peak-to-peak. If this property
+      contains multiple values for various PHY modes, the
+      'tx-p2p-microvolt-names' property must be provided and contain
+      corresponding mode names.
+
+  tx-p2p-microvolt-names:
+    description:
+      Names of the modes corresponding to voltages in the 'tx-p2p-microvolt'
+      property. Required only if multiple voltages are provided.
+    $ref: "#/$defs/protocol-names"
+
 dependencies:
   tx-p2p-microvolt-names: [ tx-p2p-microvolt ]
 
-- 
2.34.1


