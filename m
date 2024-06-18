Return-Path: <netdev+bounces-104666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E9090DEB8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7AAB21227
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2517E8FB;
	Tue, 18 Jun 2024 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jVznaIrr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4717965E;
	Tue, 18 Jun 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747650; cv=fail; b=ThhBmE3IwJG8R0AuUeD8tBXd3LukOwrZ+m7WupzS1mDVGsqD536rnusxg10QiqFUEimC0nM+XwBFvfjyu1I/uTXhngB0xu2u5/YYoqmPlxWB5a+HWQrxqQbM9HqLZ9EV/ZW2jfZVK+e4J+/rQUYlTlcgOEZYhRitEUAwZmCOSZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747650; c=relaxed/simple;
	bh=Y5/KBGMk+WRBcIC5T9I51afG2yh3TT/11viQklEwQ+s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=B9wvwWaE3qmGR4pxsrHIezfWfKgZH3jQ2pnJa+11rvdvsxgti4UTBzV2CBLpAa3eatIkh4s1mBA5reppKwg+alnmbg8SXnOLqLgdDWkbPNKIU/070kD8wGxeBqhKQypwIJoMKTk8lrOoyaaHWiHY0+Lq6M/wR6zvSMUvUuW8zJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jVznaIrr; arc=fail smtp.client-ip=40.107.104.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkIkVovCf7mjS1L3v6mk6/bl1OHtdL3kxWoyZPlZjA1F+4BPCXwLPFjzC4uF9n2FRGNbKfd05A8Bs3y6Uli69UneHklN5dcrIydtulaj0SSwjaPYvFOWSywCgq4PhRlu183T4vRG3HV3BhYjkPTP5V69RDlVtt6hE7p7eUzEoXDxxRk1Yk6huFI/zh/EwCM8dbEUY68eecN9CeOAfwXIR2bt8/WR2r7jHUSgGqDyTZIV7cbjfjdbnYxY+6kpYgSRj+jjZuuj1Lwx5+A/dYuMpzi2XvRKHdaag58Rl4jHxFHciaYHBek8tL5coHv3LFCNPc8X6yNs3lUpBxgFfR0X6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yggZghhXqEgGuDrPsZl/hJfRxtivcSMNWqkW+YgjJBc=;
 b=a225XVXbwo7q+Uw1ccy3XBim+m51r1vS5Yj9gRCL8jdGLo959oFZ4CanUr9Fx5otxM5nBwZa4GmvwlCjD9o88ubNMsn6UPYB3Rba5I+Awe6SF//l9VLgVBmKgvQqembTF8W+FJ2ynECvfq9uZawlVaOv7Ip3ISNQ1qYQaIOHieW2AnMvrFlXXUWDr6b2o+hRMYHogrlcTLNDO+k4oIQBWTuYwiz1U7jQ24Gwzwy/lyBSa8QxzcymWkaX9HMbms1/A+V/umwBUuTpHDWvMfzsYYa1NYc+MZB6K6g++yF1MtbS1kkhfUroD/BRGpLay/0iLd4N9dpet/38PzTNL4Wcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yggZghhXqEgGuDrPsZl/hJfRxtivcSMNWqkW+YgjJBc=;
 b=jVznaIrr+x6ft9Vtuaa9R5VJDVCERD2DM5zXpllOjAheJWNcLFNW/pkzl4a7NIskps2GQBY4JiouSl0IpwKUwQiwdxXgofB+/BWE1g9RZMu7eGAbzjzhvORQvDJewH3g+zSszz93uKPVz7youZjpgyTyJb+gSPwpela7Y3Ka/S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11008.eurprd04.prod.outlook.com (2603:10a6:10:58d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 21:54:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:54:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/2] dt-bindings: net: Convert fsl,fman related file to
 yaml format
Date: Tue, 18 Jun 2024 17:53:44 -0400
Message-Id: <20240618-ls_fman-v2-0-f00a82623d8e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOgBcmYC/2XMQQrDIBCF4auEWdeiJk2wq9yjhGLHsREaDVokJ
 Xj32my7/B+Pb4dE0VGCa7NDpOySC76GPDWAs/ZPYs7UBsllx3vRsVe620V7RlwP/IIGrVRQ32s
 k67ZDuk21Z5feIX4OOIvf+m9kwTjDR9ui6g0OSo1+W88YFphKKV94j2SInAAAAA==
To: Yangbo Lu <yangbo.lu@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Madalin Bucur <madalin.bucur@nxp.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718747639; l=3418;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Y5/KBGMk+WRBcIC5T9I51afG2yh3TT/11viQklEwQ+s=;
 b=bVL+UL8yPb1piG9ZHQUSQ9yIokkF/AexBSmER5Tckwyo8Y+AE4RAj6LyUCNXZjyhLtdSGKdak
 R6fdk6ZpvIcDEjEwXHRW4dJU4xgwipQ/pc5QVO5W6LMwR5GN4VA4r25
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11008:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cc8bad-b2ac-4a85-f482-08dc8fe12b05
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|366013|376011|52116011|1800799021|7416011|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TnZWUFB0d3ExL1lXTVhoLzB3VFNBcXJvVU1GUmk5aGcvL2pOREdqNjBrdXBT?=
 =?utf-8?B?My95VDVEK3c4Qm1YUUVTY1pJQXpPelRnQTdScnZLWWpBWE53WEx0ZVh5ZFFn?=
 =?utf-8?B?aFJESXVnSG80dkZBcnFLSUJoTEwyeHZ5SjRweHJYaTl0dW1LRC9aak5EMGVP?=
 =?utf-8?B?UWFEMnZFaHNZRTJXMXRXQ0R0RHNPSkZtUjliSlZyd2lMQ3RrcGRtVVo2VFZI?=
 =?utf-8?B?NXpXTHNJeGFtckZ2Kzl2U2NpejdhS1F5Ukt1S0hRcnNvdzh6RS93bHFicGFV?=
 =?utf-8?B?SWdHQmlqcHlOQ2QzN1NiWmxCNkRQNUVVdVhCejF2MzFXM2lNcU95R0FrOVNu?=
 =?utf-8?B?VXR4dXoyaFlkQllxVWRhU203a3dxYmczYVRKcmdjbVBTK1J5Nkcxa3FIcGEr?=
 =?utf-8?B?S3A1end4NWg2TXBBVFJ5eTg3NWNabHhvY0JJWDVSTktOT1UyQ1RvdTBiVS9a?=
 =?utf-8?B?MDRZY3BCZ3B1ejR4TlA0WlRoTTBaMGlRQjBRU1lGVDhpelNrSHJ3Ujloa2s0?=
 =?utf-8?B?MXZlK1piQlZuZHBBVFYyNFh1Vzc3RkhScGRsWjZlOE1mNVMzU0JVT3hEWG1r?=
 =?utf-8?B?bDFwdUROQWoxRDV5WTdvSHcxa0x0cDcvUURXcXhSNVVzalNnQ1g3SElOeFAw?=
 =?utf-8?B?b2xwYjRYM2dLV0FGd0FkREE5bkkxR204M25qc093eDAyR1ZwRC8vZGtWWXNK?=
 =?utf-8?B?RFhMR3pzbmw2UFJBY0FkUnlBYTRVUjZZeFFFbHdiOWY1YzdScU1CcVdpNXNH?=
 =?utf-8?B?b1pRWndmTERWME1Oa1JIRDdKSXhqenRZek1mY0tnU0VRVThWOWFMUUY4UmpY?=
 =?utf-8?B?VEgyMDFnU3JyZ1N2Smt5eXR5WWlsbDVHOWQ0VEl2dGdsc1ltYTM4ZGZqUWEx?=
 =?utf-8?B?bE5kNFFqL1VNZndpOStZbWt5Si9BUjlNZnl6V0pTSDBkalZEMjUydlNxUnpP?=
 =?utf-8?B?SEZ3UjdMZFZ4eTZmemt1K1lhcXlMaWQ0eXhKWWtLc1RhcVY3U1E2ayt6WmQx?=
 =?utf-8?B?OGZlRTIxb2xaNFJhaGU2Wk53NTZIVEpIZWVyVkFNcTJoZi9wRHVJSkZRbmZP?=
 =?utf-8?B?TFg5ampBK1NWWEZyUlVBRnhlb3B6RzJGMmN4M3J2MngxVU9aU0xoOUJSRGFn?=
 =?utf-8?B?OTN2NUI3R2dpRDY5V1NuVVozMDVkdDIzSlR4dHR6QXdxSlEycHJreEI0Rytm?=
 =?utf-8?B?UTZoM09QdGNEVzRhSEtDbll2ZXZ6cGNrc09vM1dORUx6cDV2cGlHbzdWSEJE?=
 =?utf-8?B?TUd4YnhrbFVtenVXamQrNGRWK3V2R1JianNvbFJJN1J2Q2tBaUhwekx4NnNR?=
 =?utf-8?B?bW1XV2RKTjdZc2VQdFdabnNldktyMFpZcDZRbFlkT3J4V3c2Y2trWHY5ZXNW?=
 =?utf-8?B?cG5CZlNxcXNVNVl6dVZJc3k1WmV4QUFXSFM4M09DYzFyYVY1OUVGVVJ1M0hQ?=
 =?utf-8?B?V2RrZ2NEQTh4WW9YK05KUFR3a0dQRW5zNVNiNDZrSU40MVM2anpuNGtmM0NM?=
 =?utf-8?B?dm5TR2ZneWNyYVpOdEtEZWEyR2lNV3E3bDI4WlhuZjRITTJyRUZWL2J1ZE94?=
 =?utf-8?B?QXN4RWZSVHAzbVJOOXNJKzhhbWdNTTIxTHZXNGJXb0xmZXl3OU9mcmJSdldt?=
 =?utf-8?B?YTZGUG9uaHBHb3JMK0diWUdiN1laUDFQRk1iTlN3aTV3LytYS1ZFZXpMMDJ6?=
 =?utf-8?B?V3BsOGxpRXRPUG5aQjBabnpmdnh6M2dCVmkycHhLR2NIZmNsSmUyWlNhaEhL?=
 =?utf-8?B?aTJQNWZqUlhONWNGUHlKQmgxWUw4Y3Q4d2RHRlZqdXZNOExjb2twU2lYUEll?=
 =?utf-8?B?TXBSNU5QNjAwMUlwVWJUUT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(52116011)(1800799021)(7416011)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T2xqTktENWhVRmMxek5TaW1YQ2tBeWJpZjVIT0QrRkl1VXFGMnF0N2FKOVF6?=
 =?utf-8?B?bU5CblJmdElhSjd0NlhWeExoSGtCZFMwR0JYRHBza1hlYy9XNit6SFZqVUR4?=
 =?utf-8?B?SndpMUdxWjFLRFRqSkVqV2lVdER1VU1NWGNBVHllWFVzK0xYeFdBSWFHVjFG?=
 =?utf-8?B?MG1yVklNeE5Cc2E4OWRrcWVLOTMvSG1XRms4dUtDYzdLSWtZOVNtTmd1YVph?=
 =?utf-8?B?RlJGMzk2cEl2UlRqalFJdGtwSnREa0VrMnRJeXcwajVvOVZBTW4rOUcvNmh6?=
 =?utf-8?B?L1RWQmVlZjlKWUw2Um5EdHVmbnJ1alRvVzFmM3l4UEwwK1cwYlJpUDRmbFFy?=
 =?utf-8?B?SlNPL1BqdmdjVDFjQnFOcWZjN3lTMDJzQ0p4bGMvdXZVL2NTcWFNVHFJMzNs?=
 =?utf-8?B?cnFxamEybE5vUXd6eURPU2ZzVEExT1ROTFJPcVJuTjFKeCsvbGI2K2szUTdE?=
 =?utf-8?B?dVByQjR4OFJnMzZ6MG5GVHVHMUVOTWN3RGZicWVoR3RmOFB4UGN2Z2tZZGNs?=
 =?utf-8?B?T2YvSmxCamhxQkdrRXA5UWlndzdWcU1YaDRkcXh4a0ZHR0pmbHJCV2VYT216?=
 =?utf-8?B?THRIMEhSSHQ1V1lZZ2Y4YlRXRXZHZE0yOExudSsxWW5RbHBSRFRZc2FudkY1?=
 =?utf-8?B?blB1OHp5Z1lrc1o4aC9WY0ZMZ3dBem5lMW0xdnp6dWliV2dqVXk2Wmc3R0pW?=
 =?utf-8?B?TnZRR2JGazA0dWdkdUZFa2hTK1gwVSsvSDVkWXhDU0FEY3ZyWjhLMGM5UitX?=
 =?utf-8?B?elFvK01kcE5NZ0pMbUxZR1VPbTJOUnRjZ1RETFZEZzd6M3BwOXoxSm94YW0x?=
 =?utf-8?B?QTh6Vm9Cd1AvWnJSUGZFSWZieDhTTklNRVZsUDdxd2xPd25ZVUpUelBVc1BE?=
 =?utf-8?B?TDdORXd0cmNXeUtRTEVLSEc0VkZDbFNwRXduS0NTZVRpVDAwaEorQ3EvcGZh?=
 =?utf-8?B?NGxwKzlleWZKUkpVYlVSUmRnTUJlL1VFT3FBUHJ6OXFJWkJSTkwvZ2hUV2o2?=
 =?utf-8?B?VDJnV1dKd3RRQnBlTzlXT09jVjNWMUhHanphV0QveGJ4eUVkdUFqUzd6bDQx?=
 =?utf-8?B?eTcvVG1OTjFnQlpUSCtHTlJWRTJKS2thRk1MUlVGemtwK09ORFRZd2RYdjJL?=
 =?utf-8?B?cW9kaVczWldMZFFGYUdEYmVTbnRnc2o2dk93L1NjTEhoUHRlRUYyL0g2WGVx?=
 =?utf-8?B?eDBWWkhnRUlaVXI4b25qTEY3blNzdkNaTmpnalR1OUpGNU9OVGlDWFBDV2Z3?=
 =?utf-8?B?WTcraW9OUjQ3Z3pVVkFGRkZBQ2tGZVNEN2swbWRKZ0xqdXhwblRnczgwMG5y?=
 =?utf-8?B?VW5aTHhqZ2FvMjZVYm93dWFNV1VFWldqYWg0bG9XcStYUlhmSUl6NVUvZHV1?=
 =?utf-8?B?WGhzTXVjbFNFVkU0aU5Wb3ZXbTN6bEJKZVlhelAxZ2pTUWNoOGZxejYvbDdU?=
 =?utf-8?B?QWl6bjdQVVJDYmZGOG53UVNEUExsNGZzVVF1RHJzYnJ5dFJrWEFiTWJsWjFD?=
 =?utf-8?B?QmlhNmdiekVIand2dXZELzNNUXhJUHlBcFd0YVRrS2R4ZjNPRWNETHh3SDJN?=
 =?utf-8?B?aFF0ZmU2eTEyUTRhQlJXZDlDMUM0QjFmOEhtK08rNEJ4bkxhMUEwZHBNSDVL?=
 =?utf-8?B?cVpnNjR6Z1grTzFtdGVmV3cvWUxxbk1za2tPQ3dpbXhTdVlIMXo4VUtxK3JB?=
 =?utf-8?B?Y1h4NE83M3RsNU1ZWXkwMjJ3aFhoMlBSUnRaaU5vSElBZzRwWTNGOVJsU3dl?=
 =?utf-8?B?SngwNWp6S0NJYjFtV0xZZHJGWElkaTFoVW1IdWZrSEhVR2RWM3VYb0UyZGps?=
 =?utf-8?B?QVhWN1B4QUdaRmFNcWsrRmUwaHNMaUdqWjlnalNwZVlqWmREelVldTRFdVZy?=
 =?utf-8?B?M1doSElTeTNQVDNuVndoYVhTZzJDN05tN3VFMWtCc2ZockI0OWxWZEVkWDNZ?=
 =?utf-8?B?VkpzendjZms5SEd3clFuMnFxQlo0OURMNE85YTRUNVdkZmcrUGFwbkpVSVJ1?=
 =?utf-8?B?NHMwUHBDdlRyVlJNNzFtSFpLOEpNT1d3djh1QlBaSDk4RUdZTkNMbEthekhO?=
 =?utf-8?B?cE5PNEFiKzExYXROWDVYbXNlUml6WEFJd1Mzek54MmZiWWVQZG1Dayt6WXk5?=
 =?utf-8?Q?6IaCKCULRqMz3HOoCjH0Fkl8o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cc8bad-b2ac-4a85-f482-08dc8fe12b05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:54:03.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpU2wtOuXvRBx6M7S8yAGzSu3wlr9AL2WMWCmuc/mav0LLWBsuFcvDTTGKyk92Kr3Ji/S7yYjMILg2EaxB1DBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11008

Passed dt_binding_check
Run dt_binding_check: fsl,fman-mdio.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/fsl,fman-mdio.example.dts
  DTC_CHK Documentation/devicetree/bindings/net/fsl,fman-mdio.example.dtb
Run dt_binding_check: fsl,fman-muram.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/fsl,fman-muram.example.dts
  DTC_CHK Documentation/devicetree/bindings/net/fsl,fman-muram.example.dtb
Run dt_binding_check: fsl,fman-port.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/fsl,fman-port.example.dts
  DTC_CHK Documentation/devicetree/bindings/net/fsl,fman-port.example.dtb
Run dt_binding_check: fsl,fman.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/net/fsl,fman.example.dts
  DTC_CHK Documentation/devicetree/bindings/net/fsl,fman.example.dtb
Run dt_binding_check: ptp-qoriq.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/ptp/ptp-qoriq.example.dts
  DTC_CHK Documentation/devicetree/bindings/ptp/ptp-qoriq.example.dtb

To: Yangbo Lu <yangbo.lu@nxp.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Madalin Bucur <madalin.bucur@nxp.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240614-ls_fman-v1-0-cb33c96dc799@nxp.com

---
Frank Li (2):
      dt-bindings: ptp: Convert ptp-qoirq to yaml format
      dt-bindings: net: Convert fsl-fman to yaml

 .../devicetree/bindings/net/fsl,fman-mdio.yaml     | 123 +++++
 .../devicetree/bindings/net/fsl,fman-muram.yaml    |  40 ++
 .../devicetree/bindings/net/fsl,fman-port.yaml     |  75 +++
 .../devicetree/bindings/net/fsl,fman.yaml          | 204 ++++++++
 Documentation/devicetree/bindings/net/fsl-fman.txt | 548 ---------------------
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |   2 +-
 Documentation/devicetree/bindings/ptp/fsl,ptp.yaml | 144 ++++++
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |  87 ----
 MAINTAINERS                                        |   4 +-
 9 files changed, 589 insertions(+), 638 deletions(-)
---
base-commit: d68948a900ea2e75266bbfee45fc2265c65687fa
change-id: 20240614-ls_fman-e0a705cdcf29

Best regards,
---
Frank Li <Frank.Li@nxp.com>


