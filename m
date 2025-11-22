Return-Path: <netdev+bounces-241006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F7C7D660
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BDA6351951
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662FF2C11FE;
	Sat, 22 Nov 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DpIY1NqK"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0239B2641CA;
	Sat, 22 Nov 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840047; cv=fail; b=AtPfBjfoTyJZvf/XVuq1bs9lLZ5cNzDu4MmrupnldFoFPBwMHNSrqMAPv6koQaBRINhB7Di5BRPjXtmvfbE5HvIS5HtBR/uxUKZAaB0grBBIccvoGzkk6pbv7EhKzSqw82rNf/0vi4udggsslNj87F+Vytb0AMFcnqqpivSyLxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840047; c=relaxed/simple;
	bh=X+K2s2nNpqVJym5QCus2oB43cVG6GTZSXKYKLI17ASY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ph1rTSy/9sbreLXrJaYAPT18grH/FDi610HNFS45GrmF7fNI0Ikk9ySDAfejVvZ/kEkSbAYr04aA/Dbo+lYyNHpHvLQJI3Z3jfZ0qiUMkUYtZse+L7obSs6prX4v8ID23C2YSAdJ2OoJH1pw/555zAsYP60FjQ2P34p88B9+ixE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DpIY1NqK; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDmMvyHpeqV6zoYcGDPO2iAP1Z3OerzISu8VOQp1tczoi9Cq+vXSreOiPp4PXEvlrNqq4XRm9PaohrB7HOfgUYWwadUI2mEkCdb9C936LPOJcsEHgbZCOtAqqit/8cSub5arBEKGdSB9Q54t0FbmaqilQyw7DsJaQaKGxqUvAMf3z/nl5jjRKcDpbpP8S88fHggK5uDEQUqIAKdt8Zw5iAsIVeWTB5nzUWjI2Tybm5TVXnfiS8oo/lW+H1lRQIebhu4XmKPPKjmuLG67fWdlX5THtaZhL/a4RlgCzZrIJPZ/5z/n+Z1/HOViBMuvuVmfDDJwh/bczP4IYQpzwWb4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pFdE7Ni958DET8hD73qoOqlpG5Gc+gD72GrriJOiuE=;
 b=F7shiF1Z1aUaon6xZlZUr4Z97VzCHtTQXKclKu/8C+zKf7NHfBfhYDobYAd2OPH/lc/9ghZOzCbzo29ArUXWWpGdYcqydFgwWdMB5D5MedLzzcFEOAifG0iRzW8Io7jA6ZoZLYke4oD77Qpbb4ticRdje2myYoIRD7AyzZ1QhCnLRVWJKQG/RaRsHqYCDoWYQgF/jADdgNwwqfH+Hy2ZwNDb0ThwpBmJbMmLX+qcno5bpszZaaXo03AHMUWyPlyt4XLCa93/Adh8j2HXuaX4AeFkg/NeqlisoG1M2naNkFn+vkHsXZluZbCKTdaLKFkw2GSGlpKd9WvMmmpKQfe5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pFdE7Ni958DET8hD73qoOqlpG5Gc+gD72GrriJOiuE=;
 b=DpIY1NqKW4pULDlv+w2inRFJuM0jicqmyLz4bE0WZi2YlyKXOomq+8sLvn2A2T/FNQHKt+PzCOb7IYaihK/ll9knl3bW5TYTwvA5aK1hSvhlyvEQVpoYlVXod4PQ8c6Dco+mNKIKipW0u83134q7UQoWAlXjkImEI2VZ1drp8dtLOf4gW4V2h9lH1F5eWJMt6TA9XB4Wr+hvrp98eHJlHqMI8aE0KxQ3YmCBhePtlU0hgXlSLENvxD9IqAqdlJHrpMbX8lD8zf3vgWpZS25uFcDt9Ci18ydV2hePFVMevWweNXHkRatz4AYCyH13wwC0KdnYZmjOkLc9ONBFWOkQ5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:33:58 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:33:58 +0000
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
Subject: [PATCH net-next 1/9] dt-bindings: phy: rename transmit-amplitude.yaml to phy-common-props.yaml
Date: Sat, 22 Nov 2025 21:33:33 +0200
Message-Id: <20251122193341.332324-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e9ab40ea-2568-46ae-4b14-08de29fe14ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXlFM3NTQ3REdlJCV3BrYnl1aVc3NUN0bExLZnkxaS91REovWGNrMlVTeHh6?=
 =?utf-8?B?NDk4L1N5WVRPaFczMzN2S1Bsa1pkK3c3QzNTcm9tTldwU2YrNnJsSjJYK3Ey?=
 =?utf-8?B?UGQyMGV5ZmlhaXI1SlQ5RVl3TWJ6WmZ2RUFSVUk3NFlLa1VuMFJEaEZOSlJQ?=
 =?utf-8?B?dm92eGFMYmJ6T2N5WTB2S3d4d2MvRUlLakwwUWZVYm5odW82RHNPZkNNblJY?=
 =?utf-8?B?V3NCUE5OV1ZTTkxKcEltb2toVWhBQURxTFlKQ01QRGFNZ1NyMGFYWEVNNXNL?=
 =?utf-8?B?Q1ZYeEtrVWFVRDhsRnNRVU9hWkJNYjRhUnFFaGt1K0JqTm5YZ25FS1RuYTBj?=
 =?utf-8?B?elN3a1VrM3VxU05iZlZaS01pRkxoRlk2WWlvVkVRTzJ2d2NNdDRHVVR2Tldu?=
 =?utf-8?B?NDMxMEgrVmRsOS9ZaEtSalIycEZYRUwwRFpKM1ZIUDhDaHhPV1hMRVRBRmxL?=
 =?utf-8?B?YUUzcTE3akRFQVZBWGFJQ2R2eGRIbFd6SlpCMDlyYzloYkVCS3RvcTdpbTdq?=
 =?utf-8?B?MUswdWU3dmxvbHBqR0xkNVR0RERLTC9UMW9QSFBXZ1JRRHdWRlRJTktodlE1?=
 =?utf-8?B?RnJ6Z29rYkZqclpNMzA2RktjcmV5NzZaaUtmRDh4bUZhRG5tTmVDU1dOZm53?=
 =?utf-8?B?UHdNMWliblpEL2U2VlVhNmpNZXFOSFN2akRzb0JsbFcrTlVZa1E0aURSaWRN?=
 =?utf-8?B?blNCaStWN1RjcnR6RW1BcDZOVWJzdVk0Z0c5UVc3TDUyTTMxMTZUeU5UT3JY?=
 =?utf-8?B?bE5ZRXVIK2d4NVIxbW4rSHZKSTRCVmJYOGNVdGhtdW9GcUlMMEdsYTZpRmpu?=
 =?utf-8?B?TllibnVFQnd1Yi9GT0k3NXZranRHTzk1WExFVzVHNlZ0Q0hXQldTeEp5cXB4?=
 =?utf-8?B?aDdKUkNuTEFiV2FCQU1sdWlxS3RrZlpFcms2a3ZJN1RIajM2RXgxa1o3QjRV?=
 =?utf-8?B?RTVtUDFiRjROeGRZS21tM0xDaHpJWFFXTk5GREF1Y2xtWDliRkhVQjlOS2hs?=
 =?utf-8?B?S0Z0cEd1c1ZnYzhKbFdaeDdvN0VUT0lrZGlacFcxdEVWQjFxUDNkMWx5ZCs3?=
 =?utf-8?B?V29lYTR5S0RQblBXdno5c2JaYVh2d3R6LytsYU54aDdkNmtyR1h5ZXh1S3A2?=
 =?utf-8?B?UkpwS0thY3FsNHA4dzM4QUlnYXhsdFpSOThTOEpNWmkvR0pYakRkT1owVVpI?=
 =?utf-8?B?dm5xR3NWci8xa0p0QllUSWxOREdHaUhmd21tYUplQ2NVUVZEc1k5OWFsZmxx?=
 =?utf-8?B?L0xKTWs5aU1GMG1oTkpCdk5KTWl0dGYrNGlpRGw2OTJISG9NakpibnhSaENW?=
 =?utf-8?B?S1ZRdm92SEkrS0djK256bmpMOENVOEI4QVFHak9RNlVSWWZOZmJza0VUK3lz?=
 =?utf-8?B?a0tXdjFLWGR1d2U4aDkvYVkxS0d0cHZENjJvaEVEcjVxa0xVTHFpc3ZzSk1q?=
 =?utf-8?B?eHBxTlhVOWsxRDJMT1g3MXVWN3hINWU2dVF3N0FiZjhpc2svaU5lSm0yWTdZ?=
 =?utf-8?B?THRFMnl0Y0RUWjZ0cldmWDlWVWJEbU9CQTNENkRJdytVQjlPLzBsSkVuUkxC?=
 =?utf-8?B?SUJXaS9za0tWWGdlNU8ydXorYnNoV25jNEJuaTF2M2ltcWtqTkhDaDB5bWR1?=
 =?utf-8?B?MU9vT3diMzNhZ1NOanZxZ2kraGo4ZVlUTFR5Y05iWEVSOWx6T0FzZGdpTzd3?=
 =?utf-8?B?ODd2OUtKbTh1M25Dck9NUWRCUFcxOXJEZlVuanFNZlA2VHZobjVWSmFiUDcv?=
 =?utf-8?B?YUtnaDh4R3l1a2k3R3lXVDl0OS96ZzRlZWpsSW82Qy8vT2VUaXkzTTFmR1pi?=
 =?utf-8?B?RE5QTFc3blp2bFYzeUpiUHB4S3I4Q04rbFpSRW9BU2lUN1VabzFkRlgyWTlr?=
 =?utf-8?B?ZisyeTVDaDRjQXBOYWdldDlGUDdNOEN1YnVrUXNXS3luaEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnN2emxlU1ZqbnZtSmcyWDBZOUZTV2Y4WUs0M3E3SUR6SjVVUWpuVjhzVlU5?=
 =?utf-8?B?NmRuR2ZCQldvQndxaXB2ZFc5T085SWg2d1FjdjhrQ0RGK1pXZXVuWnByZkw0?=
 =?utf-8?B?UmFXUTVicmxTbFVnU0VleWwvanMxMi8wNHhZaldWNDlFTUVWWG9aVEx4MjdM?=
 =?utf-8?B?YURKLzFXSFVCNER6aGk4SG4zNEtIdjRMY2ZZS2JkNWo2VUR1cU9EbEY0SmJJ?=
 =?utf-8?B?a2I5L05pTmV3ck1tRkVsSytiY0I2RjlXSTVCMlJJcHZhd0gxQ2lQUStySFN6?=
 =?utf-8?B?a3MvMk9DOWl1U2szS1czNzFQV3ZuV1dSM243a01CL2VxSFNDdnU0WDZwZkU2?=
 =?utf-8?B?dmdaMVEraGRhVkhLbGdHdy85SFRIektWb0JyRHQ5M2x0R0J5Vmo0QWE1YS9P?=
 =?utf-8?B?V2ZPL29xL0dhVFR0bWxUNTFldU9WYzYyZkJ2bVd6QWJnNXBMM3o2ZFJKM1Rj?=
 =?utf-8?B?QlBCdWRPTWZhaTRYUXlKRXMwaE5XT3p5N0lTS0I0RzlETHkvVThWbmhvOUZS?=
 =?utf-8?B?cU9KYmRmWGpLS0tsb3dneEZ5Uk5kVkswaFdleVBGV3djTFNpNlZQQ2xUTlpi?=
 =?utf-8?B?dmw1UkRBVmxwQzVWWmVta1Z0TlZDY2ZsRDJ0RXNjUCtQNTZvSFNGZXJVY3lp?=
 =?utf-8?B?ZFNWbnUyQlJaL1VPZWlwUkoxeTkvVSt4OHJ4Z0NFUTRqczNDbGxwbWs1QjNE?=
 =?utf-8?B?clJ3WFpDWmN4SWZMdUNEdlhFRW1EcW1xWXpBSXlYUm5rTTFlMXNvWnF2T3hw?=
 =?utf-8?B?d0JPbS9KUnhhQXYyeUVQdVd4ZVRmVktFS2F5b3QvWi9LdGRuVXhWT1hUUVRt?=
 =?utf-8?B?R1NhRCtERUE4NjBEMksrcUJYdFJEOUhzOEpQMWtXWUM1YTBwdVg2dVRUbXFG?=
 =?utf-8?B?U3dNVjlFZVdkK3NCazEzZjFUVXprU3UxbEVXWEhoMTE0K1B5OFZQYkRjUEZx?=
 =?utf-8?B?dnVTS2RYc2ttcEd1YzJzbzVzQ3JVcmlDeG1tUTlBa1hqZk0zMXllSVg3Rm1s?=
 =?utf-8?B?T0J1V3hOTkZUY1VoZ0ZCcjlEVGwxZ0s3bjJPdHZDSTloL3dsRjhvQjAwRGsr?=
 =?utf-8?B?RHNhVUJUSmpqUXZjUVMxRlIzbFVXSUR4dzg0L3MzSjdJZnpIakR6eUdCVWsw?=
 =?utf-8?B?V2diOFk2a2YvSGE5dVdSbytReWpYTmVTVk1ySmJuTTdObUc0blFSdTdVL1VF?=
 =?utf-8?B?NnVCKzNMSSttbjVacllwZjhKQ3NSbW9LdExWM2MwVVVMd2pYZGNGUHNHUEVn?=
 =?utf-8?B?dW1BSjBvRzNZM1lIeWRpc0loY09pSmw0MkdEOFRlQ0haZ093R0gwTjhvV24v?=
 =?utf-8?B?dnBkQ0RJOTJia0FDUytONzNwS1liUXVncUFKbERKWFJUeTN1K3ZvaDBHT0dr?=
 =?utf-8?B?UkVtMkQzNkFXbVpSeUVvcnhQYkFXcmxkR0pHeWVFbXJBM3ZGcnpkZjJaRTZR?=
 =?utf-8?B?TEpiQW4rVGxyTklRL1g4bG56YWprcHZaMVl1Y1lwNHY5NkJ1amEyc1AyUGlZ?=
 =?utf-8?B?U1gwcVZ4b29PaFloakI2Z0RBL21XNWR6cG1ZSlhSQlRTN0pCeXk0OVVmdGRN?=
 =?utf-8?B?bHNkbUtXb3l2SDhKRkZIb2RFZHV0MTZGWjFBVGs2VGdNNDVUTEFWbWU4UUk3?=
 =?utf-8?B?b3JnbW1LVWJVQWY3c21pK1hKQkVKcE1YNWs3eUpNVGVYVG16akhMYUZBNDJZ?=
 =?utf-8?B?MWhETGhRMmEyRVg5RW4zS21QcHBoaHBzR01OUW9TKzVaT2twUVEwZ0V2M1Vr?=
 =?utf-8?B?bHUwSnlLbEhiaGdZRHZkcG5HZmZ2Y3VKcW5UeFJrQ2RLdmZQQmNibDVQMXF6?=
 =?utf-8?B?UWZIU1lZYk8rMExhVWJXbHcySTJ4M3B5ZVRWaHZ2QW16TndTOXY5TkxXVjZj?=
 =?utf-8?B?djd1c2FUTFdsRk8zQkhlVEUxMUJOUFFsSGtSWEhyWTdwRDNIVVRGcE53elY5?=
 =?utf-8?B?YmhHR1gwdXZZVks3d25GNzlLQm11RDNlcUg5UGxROForZisyL28vY1RTa05T?=
 =?utf-8?B?TlI0SWgvUXZoQVdPVE53K0xPSDdjd3FHNEl1dGJucXRTN0JvR0xGZ0t2SlZw?=
 =?utf-8?B?cHRDdHQxTzBqWFpnZThEQjYrUzZNaHB3STBveUZEc05SbDloZHBxakNZd09F?=
 =?utf-8?B?S2g1dWZnemVKeDE5WFBmQ0xkeHN6cWJnQ0tKM3V6UzRKNy92d090c2pHUGIv?=
 =?utf-8?Q?MhEaU9ff+9/D1556iQGFHk4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ab40ea-2568-46ae-4b14-08de29fe14ac
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:33:58.0594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMk5FGpSD9cU2/vB0AFW2ZLR0khdGsIr2mnqjxKtmyuumu6easMu8VKaFcwYFuRT7AtfDvetPRuw1jqBeN2ASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

I would like to add more properties similar to tx-p2p-microvolt, and I
don't think it makes sense to create one schema for each such property
(transmit-amplitude.yaml, lane-polarity.yaml, transmit-equalization.yaml
etc).

Instead, let's rename to phy-common-props.yaml, which makes it a more
adequate host schema for all the above properties.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../{transmit-amplitude.yaml => phy-common-props.yaml}    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/phy/{transmit-amplitude.yaml => phy-common-props.yaml} (90%)

diff --git a/Documentation/devicetree/bindings/phy/transmit-amplitude.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
similarity index 90%
rename from Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
rename to Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 617f3c0b3dfb..255205ac09cd 100644
--- a/Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/transmit-amplitude.yaml#
+$id: http://devicetree.org/schemas/phy/phy-common-props.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common PHY and network PCS transmit amplitude property
+title: Common PHY and network PCS properties
 
 description:
-  Binding describing the peak-to-peak transmit amplitude for common PHYs
-  and network PCSes.
+  Common PHY and network PCS properties, such as peak-to-peak transmit
+  amplitude.
 
 maintainers:
   - Marek Behún <kabel@kernel.org>
-- 
2.34.1


