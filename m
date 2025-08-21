Return-Path: <netdev+bounces-215698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B40B2FE6D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057861BA51C3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247933768D;
	Thu, 21 Aug 2025 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZVi4hKZ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165C322A11;
	Thu, 21 Aug 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789702; cv=fail; b=Qs5KzToMc4HOqaY3QakRRn+oq3atklbCUY1xfkdiPoiX4NYmqYAhtI59vGMv0EqdQHy+Mxtg6jdTfuXZlrXL8FPbUn2aBOdv5R3IKl74S3jdLXXB/DVXbkZagGmZxW5nhvHdhoRt2fjIgdwrqnMLxM5cVTWycBeR+pX5EJ06lHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789702; c=relaxed/simple;
	bh=F8We0BrM1XYocInBMFt5Jc9vXcPWdr0wlvJUwaDpitk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+sD19vD5fkEKmpNRHHkJMPOuCrheoWqmI7GciFXnvXnbFuAKyugqVp3RyHRm5fH1HxBM2Wjd5WUnO2VT2qvXmDeE+pmom3RkdNdPheY1OimlVmKa4kTd9kj5AIUS7kL0cWD3SiEOjfMmKpgzUEPfxkqf//smh8jQ57t4nx0U2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hZVi4hKZ; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbwtL4bVrGf++pk064TXrVLi4VCaFNZ1VS7f5SttqZ/exNua4JdLb41mvnfiD9EGI8tBqzglpiA8HWn87RYlYl1i0xgdQHS8V+1IRkA5zl8iORV6OhnVHolzK2KeCp38VnmVB8QMF1aqNoSjeUUx1cndNL5G9remypUJME+mYT0dLD7teejS+l/H3TWtLSYrgouIDHNRHzMUIiwD9e65WzryhIQOESSMk+eOPr3AZ8tjqMmXcfZprEFrDPX2j/VbYR2DY0EAI7JMpCGYBGSAM0WllR2xP9CTaJ+5NzC61g2vLsWaDG88rLrld4U54CBmkETGJEJS1KJb+IgDPyjsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLrJnbDway1d4RexMDsbrPUsXlV1blRWqrZ6d0yur3Y=;
 b=tFo4zrPGPKDEAofCUfSy0KYXtkCN8MtN2G5KXJyPlap0FeULDOYC5q5BsLVZvAj2YCVNDxCkqoBzfM8z950I6+/sf5UdSjywxZIEaqjCJWYsGvO141NOAQPFqnDMLZs1cdQhmxPnKTV8kB5IxPGwtAnjkSQz/EQaon8BxCucFCo3D0Kv2Ucr1ewbFr49bpIIge5KhfZY1h30sNfYFRKnvpkAP50KUdikKDs7SPBn6so1vnU0pQ0bgMnXSyqUwERZEmeH2nqodyXruWhE4FfSBXkr5XxbJXOjl+rpNHLkh6jJ+w/Z/3cFuTGFF2MhmSLzziKx1Ku1f0XakzUgy6kx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLrJnbDway1d4RexMDsbrPUsXlV1blRWqrZ6d0yur3Y=;
 b=hZVi4hKZMQsyZIP70th08RPIaK74HBl40Fg8dbxmsRhXqBLa57NPhvPxup/ZfCXOHDVswFUnbROtvPetw88uBP7bAqcITZFTivuXToJU+FoICvUkmY2wZxyypD5uBvIYFE+gPFwrnB6x6j5bAsWYMimagIdVU+D4sptXeiJQ6LhGOFF/ZTdn4d+h11OzdzZ5B+oZYSj9lfWRecxG/fZubtAvvcP2yuTSv2vtPMJgxPVQ0IMtF2cQ0CP+vAWjThIcLWFzUPt7Frc3gBwITV4Quz821ViXZmAzBiK4d0J0Lz0pRg0EgU1TGVu98dUEcJK7P9W4NJ7gBLcJ5WBbpiTbVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:30 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:30 +0000
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
Subject: [PATCH net-next 14/15] net: phy: aquantia: promote AQR813 and AQR114C to aqr_gen4_config_init()
Date: Thu, 21 Aug 2025 18:20:21 +0300
Message-Id: <20250821152022.1065237-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45ec4400-ec5b-49e8-760c-08dde0c6678a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d2U0MWxBdWFFWVk4RjZZdUV4SDBwdC9ibUpnVlJMWlQrUGJOeVlhbFNuV3Ju?=
 =?utf-8?B?N3hva2h0eFEyQTVaVkh3UjB5RDVEUnloeFRRNlRxMkZFQjdZdW1OWmM3Zms5?=
 =?utf-8?B?L3o1bXFmc0ZBb3BKZHFacjE4V2dCeml2TkZiMnEyanBiTTRjNHpRc1c2Snht?=
 =?utf-8?B?aW10a05xRGZGbEliS2U0dlRvM0xMNVVFcnhLeWV1ckJpYlJQdzNSVXpjb3U2?=
 =?utf-8?B?SW9ycGRYUjlDL01uemp3Sm9SdXNSK0tlclRsQ3B1Y0xtazZuME1qenVyYnlI?=
 =?utf-8?B?Ly9Fc01QRWlmK2tKKzhmZzZrU1A3Y3A0dlhOY3hMYkJzdnRsOG1RMWdRdU5o?=
 =?utf-8?B?TEVCVDRlbTc4eVcyOEdCVmRXZHdRYXpaUHE1T0YyNjVxVCtEMFJ5UjR3b2xI?=
 =?utf-8?B?S3FTY2lnVFdpSlZoMlVMb1hRMFN5aGZRSUwzUjBTRVpuTFlrbkJOeWcxbDdZ?=
 =?utf-8?B?NFZpejZsWEptQkRsT1pOVEZxZW40cGJwNys2R09ON1EvdWM5cDgycXBxamhB?=
 =?utf-8?B?RFZnR2pWTzVsaTB6cllaTlZ5Uy8zeTdLUWlLQ2xlTk42QmtjVjNhWklkTmkw?=
 =?utf-8?B?cWRjbmdmeXppeWo3SVcydW96TUUybU1rSjVxWUhBY3lKbmJvc05sWjVuWTB6?=
 =?utf-8?B?Ullsa1lPdUVYV2c1cFpZT1cxbU9mV3JqOHZVMHZSY0pTaGRIV0Q1ZmVyMTF1?=
 =?utf-8?B?cUhqNHNsT0tUQnpJNnBLUk00a3MvZUo4Mks5WWhUUXIxV1Nrd0xHN1V0M2Rl?=
 =?utf-8?B?MHQ2TFhRUy8wV3AxMjZTQ0F2S3RQWTdza2lxa3lCLzNyK0cyc2NidlVlMHlt?=
 =?utf-8?B?MjB5Qkp6VHYvMWZXcXZYOGVPRUcwaTE3T2Y4SEdGNE5sVnFWcXYxNTk4ZnJR?=
 =?utf-8?B?d0E5eEhnTEFMT2owN2Y1T3o0eS90R21penZITVd5NUpoVEVCNUJJZE1oSk5W?=
 =?utf-8?B?NnlhZ2ppTUNyaVh6dXJialErN3Jpc2dnMjRzY1RrWmY1RVFaTGIwODg0N2th?=
 =?utf-8?B?bFFyL3Evb2pwTGhXdHJhd3k2MGFPaGgxeHpzWU5LV1l2ZSsybGpqQkQra2ZV?=
 =?utf-8?B?RzJlMncvU3JtQXJXUFBQSUM3Z2w0ZWMxaVpCSW9McUYxM0I3K1l0UDIzTXRk?=
 =?utf-8?B?NVZJdndTRjFEaS9LdU10a2FRc25pMm1zM1krTkNpQjNJa0ltQzBLaWlzR1kv?=
 =?utf-8?B?MThrWmd6MTY3Z0w3S25JQURTTUlWZDg0TCt6bUMwU09IaThIcVBsNnhzdTVq?=
 =?utf-8?B?VjN3amlpdnhtUFozb1M3c21Jb29SUHlsRzR0YmxkRE8wL09zQkh4QzF0VEJT?=
 =?utf-8?B?ZVUrRlZSTDl0RzN1MDZVWWlKaUlXOFR3bDkzUHAvcHp1UHRQMUpWdUNieWw5?=
 =?utf-8?B?bWdHdG51c3NmeXl1UUFCMzJpbmM0SkcxNjJvbUNxSkVuejVJencrRk9KL0Fq?=
 =?utf-8?B?QnBlVWpwOHdVK2xkc3piOEpWdDl3VW0xaWJETXNTRW5wM1hGdlcvcEozeHRZ?=
 =?utf-8?B?M0RRZG9VQ2c2T21rU041bVlFcG9UZDgzVDFoT1BlRnB6cnF1SWRHMTJuUkdz?=
 =?utf-8?B?bWdSTEI1SzlLNUJwMnJMWnYxSldBcWovK3IvMzZUY05EK2Q4RWtRNGUzNVdZ?=
 =?utf-8?B?cTRubEVnbStCRjlVWTdvUElvUll2c0tUcys5dFRwVDNCTzVxWXhBOUJJd3pY?=
 =?utf-8?B?U0hjQnZ4VnZ4cjRQbzgrbXdyaDJmSmlMV05Ncm0xeGE0YktQUnUyUjA5azRt?=
 =?utf-8?B?RXVZejI5TGFqclA2bWdnQm5HZndwK3QxZWYvMytKMExYc1VXSk1LSkxCTEdO?=
 =?utf-8?B?SkVlUXozVHpzR292U2Y5WGVnTHJhdGRxcXlPdGhuREhXandMQ0ZxN1oxV3p3?=
 =?utf-8?B?VTVKQng2WXM2L1RmMlYzNDZnQ0hsbUt3ZjVxdHdwVk1pQmI0L2JVdE5tZzNi?=
 =?utf-8?B?eEljN1cxc3B0OHZaNEtVRFhkU29WZkRUcXVBWFJzSWRoa1FNeDY2WkFCbTlO?=
 =?utf-8?B?THFRRlV5TUJ3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M0NhR25wOGlWTHJTeUF6MUM2UTJsdTQ0NzJqZElqVEVoemFxcnhYQ3RuZ1Zu?=
 =?utf-8?B?djFJWFlBWEJQRWNSVzhDSytScFRrNmhnWDZZTXBRcXhVdmlPS0tMRWlRMDBQ?=
 =?utf-8?B?V3FHNmRFQ0RMc2Z4MUNRaTUvU2hOeFZhc0lDK0JpSGhCQWkwbkFScVhxbkxw?=
 =?utf-8?B?YTdTeVVTNEQ3Vk9RSkFaekZhZXVLYmMxL2JIVEZiUG1ZSC9tc1QwTTFoS0Ri?=
 =?utf-8?B?Uzc0T3Y5aHBXeTN1aTI3SVk4MWNCU1V4bXJXWUR6WjFBbU5VVFdGSmZTdWxq?=
 =?utf-8?B?L2lyY0tkZ2cwWlg5K2tDOUVNMXB5RmkyWk1BZm5HVlZjblM4OWNIeEZtUnEx?=
 =?utf-8?B?dE56dUZwQmNwZVh1dHdLblp1a1AwcFplazc2dVA2b01KT1Z1citQZGZmU3RU?=
 =?utf-8?B?a3VwbEZ2TzVubGtaR3BCaXlOTnhGWmxtLzNDMFpoajNvY2FOeGFsM1RySlFl?=
 =?utf-8?B?SmZQa2FYWkNENzNCZk0ySktBdXlacU9jMVRCV0wremcvei9nMlJ2QUU5TkFh?=
 =?utf-8?B?YVFpeUlrMGp3eHl3czA3S1dXRG1Wak0xK3VKNFhjbExjT01Kd0x5dFBrb2dx?=
 =?utf-8?B?c2xtNVVJUTZyK1doZDhPY0hodDFPRmdNYmxpRjU4QXczVUluS2QwdGxqY3Vv?=
 =?utf-8?B?dWxqNXZDZ0gwZVpiaW5vT1BoSUVuVkJleVFlSUxnSUJJTzZydDhwMGNxcGV6?=
 =?utf-8?B?d01HNXJ1eGFoRkdzdUI0NVR2c0FZT2xxcDNOQkxKWGFONkwvUmtGTHlabEkv?=
 =?utf-8?B?M0JiS3hUekZRYUJ4cXVRSmxKWUZsdUUzbS9kdGpWL3ROdVg0Z1I3cTh5dHBI?=
 =?utf-8?B?aDRvVUplaTE1RlNFRmR6ZS9hU0FqTjJvY2Q5Z3ZnMzVGeGk2VFg4c1Btc0dU?=
 =?utf-8?B?RWR6UldxRzRqZVNUV2g1cW9OVG5zRjlsbEZZSGhIa3VEV3pEZ2JibnpNU0VR?=
 =?utf-8?B?ZEdZRmRpODQ4bVl3UHhxSEppWXdRVy9QZFhKQVI2Y1pvR1pPdjQrQVdjaS9i?=
 =?utf-8?B?eU1lcFg1bTR1cllpemdpbStCTEtjZjdFMWpNSHVRRHoxQzA0N0RwKy96cDBr?=
 =?utf-8?B?SElhQUNHVHVheHowZlF6M2ZWNjIwMmFLbnNsd1VJc0R6QityazYvenFyaVJu?=
 =?utf-8?B?bkFBS2ZSd2VGVTZQN01lM1VDWkhZN1lMS09YZHF1cHNnRlpoR3NqWldVeDNs?=
 =?utf-8?B?OWxXRXhBTjEvVEkxek1DR2hmdzdyRVFvQ3R6bFVDREZ3K0JqejBZSXFiSW03?=
 =?utf-8?B?ek9zNU9rcDlXd0VGMVROczNUbVVhMjR1eG1YbVRlNXUwR28yNUg4Y3VQK2pN?=
 =?utf-8?B?cHp1ZGxMd1dJclZwbDlkTjJ1MHJENHdvZmpyS0IyTnQ4dHFSZXJLbU9ubU1Q?=
 =?utf-8?B?Zm93RFFNYVhLTEtkU21IVE9kS01QVFRSNG5MTWc4MkkvVnMyK3RGMytGQjdU?=
 =?utf-8?B?eVBTY0Z6djhCSTlGZ2EyeXlBVzNwNE0vNlBESWFGNWpBaHQyNS9EWHpOT0Fy?=
 =?utf-8?B?L09OeE8zWXZQTDYwRmZHY1lHTHE3anJzZXo4ZjZGa3RIVHprbCtPaFZtaVlq?=
 =?utf-8?B?WkpFNEtOMlVsK3FLWFZPUFlFczlIQUhOMnE1QmFHQzFrdmRMWU1NM3NUNGNJ?=
 =?utf-8?B?NWFSejJ5NXhGRTd6cW5IaXEvVmZJWXZLSHlTdE1NVExkeDhUODIvRFdSb05S?=
 =?utf-8?B?NDhrOEh1RC84TXBrNXpVMUVaV3B4Ti91S2hZaUVPRnFWdExOUFRvSTI0b0Jr?=
 =?utf-8?B?MEhlM3VMeGdsbzdZRCtQbWdrTVBpRVRINStmbkQzOVFnbEIxYWVZRlg0c2tH?=
 =?utf-8?B?U2RSQWplYUZqOUxISFpxM3ZLN3QvSzQvQVpGTWE0OVpSaHo4VkMvZGw5SllW?=
 =?utf-8?B?RXRPNnlDM3hJSmVUSC9SUjZtRnhFazNma29ERXhqdG1CekhiNllDM0JVODg4?=
 =?utf-8?B?L1F5VXlTdE5laWNaV1NTc0V5RnA5dWt2ZDV0Y1ViM3lqYll0cDRwVzVFVnZI?=
 =?utf-8?B?eEhZVno4SVJtdVNWMUhFaDBLSHQrTUx1cC9FR3ZLd2dXSTcvcVV6eVdhcWhj?=
 =?utf-8?B?NW9jUnVvUmFUM2hYR2JGRUJ3VE5kUGRKK1JYanhSdFZNbG9CRFRiM3drMHJ3?=
 =?utf-8?Q?JayACh525HWBjk2tavvcDWakW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ec4400-ec5b-49e8-760c-08dde0c6678a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:30.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqjW676wGoEWFXXMIzSsI32dnknP8YChH0JSNcpkKfnnlG61IeqX6bi8ZP9DpzCCR8Lak3vcjp5/rrgKilCooQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

I'm not sure whether there is any similar real-life problem on AQR813
and AQR114C as were seen on the PHYs that these commit were written for:
- a7f3abcf6357 ("net: phy: aquantia: only poll GLOBAL_CFG regs on
  aqr113, aqr113c and aqr115c")
- bed90b06b681 ("net: phy: aquantia: clear PMD Global Transmit Disable
  bit during init")

but the inconsistency in handling between PHYs of the same generation is
striking. Apart from different firmware builds with different
provisioning, the only difference between these PHYs should be the max
link speed and/or the number of ports.

Let's try and see if there's any problem if all PHYs from the same
generation use the same config_init() method.

Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Robert Marko <robimarko@gmail.com>
Cc: Paweł Owoc <frut3k7@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index eb4409fdad34..dd83205a8869 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1324,7 +1324,7 @@ static struct phy_driver aqr_driver[] = {
 	.name           = "Aquantia AQR114C",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
-	.config_init    = aqr_gen2_config_init,
+	.config_init    = aqr_gen4_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1374,7 +1374,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR813",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
-	.config_init	= aqr_gen2_config_init,
+	.config_init	= aqr_gen4_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-- 
2.34.1


