Return-Path: <netdev+bounces-254680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NjWFtcve2n2CAIAu9opvQ
	(envelope-from <netdev+bounces-254680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:00:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39DAE509
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACF02300D317
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1806A37F8C1;
	Thu, 29 Jan 2026 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aaiImjav"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39037E2F4;
	Thu, 29 Jan 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680848; cv=fail; b=pstU7kqZa5aK6eA7ryd61LoRC3GhEL7evhC6MYau4Wh5hV63L17dQrqFbmoQ6hG+niq63i4Uu833odpLFuwagSR5qHOXMNlnVjKMc+T5X12wz3ROfYE4qq1xPlUpoUZZRmS1OP3QLFlIXK1C2WSJpRL3Mv6T+doxhL67poz5Xrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680848; c=relaxed/simple;
	bh=4jqMk6/R/GjFZsAHI9z0oz641NfrgvPgB6mo9lZP4hk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zkr6cv7rNha9p9bllV5R/Ym6T7pJycBUcrweG831PVEvqGq3NOKtQjh8oCry1FmDbQDUz6D5S2g/20x+FQoZTlorVC5tm61+K/8R8CKqGPsRwQj/IyoAsFnYAJB1Mo9If6HQ3W4HVVYhb7CNPyk8F+JCWmjweaUkMrJxqrHqIgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aaiImjav; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfEhU+CuhCPXSWzyCPwN5a6nQJ09lVNQ6CcrgmlRiNPJYK5XE4PQs136iZZykwcewsFTteb/tyw/S/H7dG77IEBnJ1OvbCeXCimkTJHIy/8ujMZGev9v/Lv09WHdrw/eoySqsWGfwtndvk5vwDRf12X+zlrKjfY86EMH7MnbsuICztrO0PzvR4G1XasF4wu648y4NAztsR1PA10WUPMB5cchmHDydptxY9LZWnk99J0HbRMRAdJzuBj9gNZiGZKsaJQnjIHPe68xd320+YibAHWRh4Crk5GQTmolujuO+1wTDPfGAl31SPLSOhukrz+gIh9TsIqjJJFH0ad1YNR68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jqMk6/R/GjFZsAHI9z0oz641NfrgvPgB6mo9lZP4hk=;
 b=zBD4+vQckabOO94EDWs+wzM2iOI1vzVR4TZRXNmMEZyewoYSAg4+DpqP+a4mIzB/klamTr4ks6zjjCKvJ4DXSldAxgqz/2id/MZzUpTm/LRjOz1UoBQeqJb66+64aYIaOT8Qz/PIJ4AWmIS4Oz/bpzMBg7YX4Oc6zPieq94tmENxjX39DFptsD296ID0BKO2X61SyBffR9vgRJPBHyq2F3MRBPMyaMU0HcimF+zHwdoj4y7xkAR57b8lZGshSHotiAuMO/53UBOzW7mTzSuBv1r0CcKSc5sZuWCZapjK6lPWBbsz+eMlM4vay0UEpr6inokFYIqHOYXpCpso8oecSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jqMk6/R/GjFZsAHI9z0oz641NfrgvPgB6mo9lZP4hk=;
 b=aaiImjavDtdwnTm9FFrGMpqa46gDs9/gswF/t2fqzYbr2Ii0vofSpeuF/8L2OJbsLQ/UOTj/IC2czQrBOA3RuYrp9eI7Nz2FWmCP1F8kNETMGmujqnF1/Yznyq5fwquOecFJvIrvlx2nWxTxw1Ds3kO4HrKfTyOpbdHD8JgJ4isQSxdo1dc5E/agVpU3wsVChkpE110fNfyHMkzTKQCFLK5oON3Y186Y9qqATgsTv7TyBiE5/mBfBPfNNk/3selat9QuCZJzUgsQlUhNAkImwfxD2Cv1IjdwF37UTJ5KkbyZ8FtYnB+fqREsoUCqFs+GX2YfrduwLZyoV4iJSFJnZQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 10:00:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:00:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>, xiaolei.wang
	<xiaolei.wang@windriver.com>, "quic_abchauha@quicinc.com"
	<quic_abchauha@quicinc.com>, "quic_sarohasa@quicinc.com"
	<quic_sarohasa@quicinc.com>
Subject: RE: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
Thread-Topic: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Thread-Index: AQHcjrC8X7fZpJnZe024lfTnDwQHCbVo4MQAgAADeqA=
Date: Thu, 29 Jan 2026 10:00:37 +0000
Message-ID:
 <PAXPR04MB85100B7C2C6738CEA80C3C7D889EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <7df10272-a06b-4509-ab8a-519d43944424@bootlin.com>
In-Reply-To: <7df10272-a06b-4509-ab8a-519d43944424@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9964:EE_
x-ms-office365-filtering-correlation-id: 6f16c441-0ea3-4b55-7bfb-08de5f1d408b
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rm4vZkxvRmFNVVVMK2U0Y0dBdnVJdkd1NDJ4Q3NBd0tUTkVCQjRSMGN6YlNt?=
 =?utf-8?B?MjVqdWlrdVZ4VjVNUFFYcEY5WnlzY1dxYnF6cktKdU5mVmszQkV0REhrNDRr?=
 =?utf-8?B?b1NGNlRoemx2TWQ0QlhEdGkxTHJWSFJtYTFJd3ZhM054K3dqejBkZnZWUTNF?=
 =?utf-8?B?UDdmb3gwczB0QWVkdjBVQ25Temx3SEh2RjJzaGZhVS9vZnJLMkYvejhqeDFJ?=
 =?utf-8?B?Y1laRkFrZ0dTVXpRMXZJblRsbjBlbzRCOEhUT2hLL3JZeWRHU29VM09aM0JW?=
 =?utf-8?B?TGJkcnJKRTdhMjk3UDVzWERxbDQzOU10ZTlQNEhodzVnL1RMVEZWUVprMWZF?=
 =?utf-8?B?b2ZCS1BtNzQ2TVRGNVN0V09QWWo2YzRlQndYV2FpVm44enhNMW1JVW1VRHJU?=
 =?utf-8?B?RHFNNGNpdVZsblgrRmFkR0RTQjFkU1lLcm1veElTK28waU5EZVNGUklwbmFV?=
 =?utf-8?B?d3dHcGYva1o5V1dURGR1S0R3Y1hFbXVjS2JiNmIvQnB0dXQvR2JIUFl0RTR2?=
 =?utf-8?B?SG9sNnNlTThSZnNrTXV0cjY0bjdIOXZkZ2gycHFMN1Njai9DaFVDeGJKRnQw?=
 =?utf-8?B?UHFhMSsybGdaa09yRTA0S0VWZGNmckVWVXFqVVNoVGxaVlFnOVY1ZVZ6RDI2?=
 =?utf-8?B?ZWtGekVpNEdGNmtGK0ZCYnRDOVdZRUk4Vm5IaG5PU21rSzZYYlRzamVlVUpV?=
 =?utf-8?B?NjlDRUlCSjYvaDVNWnVCNEhub2M1S3QrK3Y2RHNNRkd0UE9PYmZ0ZTQzZTBB?=
 =?utf-8?B?c0tuVmRwOXFFYlJBZTlBdXFrSTdXT2hMdG9iV2dvLzlCRUVET01tQTN6T09M?=
 =?utf-8?B?aHVrVGlrblJQVzFLY3lJUmt3ZGg1bkl3aWoxSzhpQVRsdktNUTJhR1RHSXZC?=
 =?utf-8?B?YXZnYmN5QnFocEFzS3kwK2d5MFNuNUhTNG9hMERqNVdQOEUweHE2VjRJTFd5?=
 =?utf-8?B?WmY4SmhLY2p1TXpRb0VQVTFWQzJ6eEJmYm1PZ2Y4V0NCck9tMGpzK3VjdnpS?=
 =?utf-8?B?d2tTaFgyNkZMem1HUDMva3IxajNja3g0ZVZ5Y3BPOVd1czNQR3VxQkl3WERm?=
 =?utf-8?B?U3VhTHJONHZTS2FZQVdIN21TLy91Yk0wOUdmb1E4bi9yUXRaVzdaVm8xOHo0?=
 =?utf-8?B?ZmMrRkJJQktPQkNzbFFmMFBWTGp2MmdvSVJ3MnljRlBpZ2VrVHR1aDc4L3pE?=
 =?utf-8?B?TUZiTkp5NW51czBia1IxR0FkYVpCWjNwdG9jbmNqTS9pTDBIOVRxSW1lME1W?=
 =?utf-8?B?WGwxUnFDSmt6dE04ZGx6Zjk3c1hNK3pmQVVZRS94SnMzVzljaEl0WVJOZUpB?=
 =?utf-8?B?Q3dzSUtVNEpjV3g3L1p1L2s3MUhqV0pJVVIwM3pXQ1B6b1VnT3NSMVo4MGYx?=
 =?utf-8?B?TUpubjVyZEhoMWFnUnNRNlQwTGE4cFVGMlpTZEpTQnVrcEZhdnIwVENqN0c5?=
 =?utf-8?B?RFhCTUxHdnVlcGJWVlVRMnNJRVpzZkd4NXJBckx2Z0lRSEJkeWJXT282Ykdl?=
 =?utf-8?B?czRVNlpWSVVxR3FkeG5XU2hqKzZMRko2UGsrZjNTT1o1eW9pbzRIbDM1QXFG?=
 =?utf-8?B?MDUySHN6aWRkZm5HdEJzNHRTcWFpc2VuUXdLd1ladDZxK3lsdzRIQ0xlSDIw?=
 =?utf-8?B?QVVWM1p4VHYxODlnMEFYL0tvOWJ6VUtjM3FqR2RDTldJak9DL01QSEVLSGZu?=
 =?utf-8?B?UWRZYjkxdDNtcTdhT29RblBJWVBHRGVZUzlCS2hRNjByOEg0YmtEcnoyQTFS?=
 =?utf-8?B?OWN5R1VlZG5nOEh0T1loSFZmMW12dnpKQ1hJamt0MXlPeWxndmVnOGJEd0FZ?=
 =?utf-8?B?NFgrMjN3RThKMlV5WDF0VUdMeDZQRFhIWGlQVVhoWGRYSzhMRVJGcCswczFL?=
 =?utf-8?B?OC9YTEVoc1U0NlQzai81Z0hyZkU4bU0xTDNmM1lFaTBKZmtsVU00Z21LeG5o?=
 =?utf-8?B?ZlNpampJZ2dvNm5hcitES1JyS0dpbUNrWDgrUHAwb0F1MTZwZlp3eU5RMkoz?=
 =?utf-8?B?THZqaUlDdHYrSE5zZmQ1MGNHWVQwY3VsdnAzeldyaFpqMWJTOFMrek1BVXA5?=
 =?utf-8?B?bi8rdmNBSzRMYldWKzRSTVRwTU5LMHgxQWhEN1hwSEpXOGhHc2ZnbDk4SUNE?=
 =?utf-8?B?bVBYdld2aEc5RWthSUdRdTFQY0R1YlNUZ2hmZlZXKzFRYUQ4SnphUzhUMDJC?=
 =?utf-8?Q?t5rIemGXNE0Z2tQDTHk/t6Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1hZUnJKOUlYOEw5OXRrSnl6WklaU1BtY1FvUHhDSjdqMEZZeDlNeUF5amlL?=
 =?utf-8?B?elU3Mjh6VkhDNlRpaWN4MkRpMStKL1JkZ2RhelBqZE9GSjlsZi9ZYWtieks3?=
 =?utf-8?B?dTIvLy90aVJCZGNyS21qUVljU1hIaFdrQlFiTUw3b2xPS05yZGRKMG9xU2p5?=
 =?utf-8?B?clZyOGtYZ0poUDdWTmxFekVNRzVaQXJ4RUxLTWpvZlJLYVkrSnhuVS9EOTZU?=
 =?utf-8?B?Z0tCMHFhZ2NsTzNTSnlXeUQvWEUways5RjVObUNhb1haWFQ4VmhOT1BaVVVl?=
 =?utf-8?B?Q3N0ck82VW52QTBOMlBheFlCMFl1aGVCcVVTOWxXTC9Hc0N5MUJQVTBwRTBQ?=
 =?utf-8?B?YzQ4bm4wa1RHVmRTNXFFOXp3VTF6bVE2UmZ5cE9QbW5Edmd3bFhZL0djdUpW?=
 =?utf-8?B?VnVxYlNIdzA2VExFd2ZTWEw4U0Znc1RNZC84dUlySUJ4MEVZelR4M1N3dDVG?=
 =?utf-8?B?NmhScUU1b3J2Wk9rOHBUTWQxRVdydlhsbGZjS3NPdjgvOWZZb3Z0RkhMU09D?=
 =?utf-8?B?Zi90dmU0ZmZNek0rUWNkMEU1MlJmRzVwM0lBOWNKbmJaYThjQkNFeTFLL0py?=
 =?utf-8?B?WmVxR0tHdlBLK1BKSDJlNGhQeGFDUS82dUc3QXVsTi9CQk9aZmJHWXFFNmEz?=
 =?utf-8?B?cWVVVWtWUkpCWjBuVWhobzRvUEtwc2ZITjd5YytLbUluQVFuOUFqSVlaNmw2?=
 =?utf-8?B?SE1zcTliczd5RVJuaW1OSUltS3lwbzdaZ1BOUmo0ZUdUUVBJL0ZxNkthbjRS?=
 =?utf-8?B?YzBUODlLSW8rV2NvbzErZytHRUhLbWUwTDdMcSs2Z0lRd3FvYXRJNnZRSFRD?=
 =?utf-8?B?d2J3bUROZVFyZ24wQ1Y1UlBLUmxra2ZZdDhUczZGWjdvTXdTaHY2WFlJbWs0?=
 =?utf-8?B?ZEFWZzIvalIxRjRBeDdrZm9xNkRwT2pTN242dGF0Qm85enFlNXpmTWZBeEFK?=
 =?utf-8?B?VUFEU3poMXVEUlJvdUh0dTJGUGl5M2gzSThiS1crRkdNTnd5T1JSRVR0dTBh?=
 =?utf-8?B?NC9FeXhZK1Jmam0ybWRWanpPU1BNaTlvZXcvaHdyZ1d4MFJTMFpXZnNNOVFv?=
 =?utf-8?B?d09Qb3hRaGpaQWFDZEdQMU5QSHFTb3psdUVkZGJFRHFaYmJMK0JJNHVCQXlz?=
 =?utf-8?B?SFkvUFkzdDZxWFNIOEUxeWtXUEd5aFpmVWFZSFNrSmVXVEJUd3hTR0F1dVhu?=
 =?utf-8?B?RVpVVm5RL0tvSy9hWW12VzR4RXM2SS95V21sdUFvaXRSY0tuUHN3Tm9OL0h4?=
 =?utf-8?B?cHhWNzFZMGF5UTduREdCbVd0V2tKM0t5T1llZS82MXcyeVpWM2xtdnpDRG1r?=
 =?utf-8?B?K0UyR3RhdGE3bkoxQXZrb0FxNGdEMXU5VytvRGpWRWszajlCYkU2c0xMMVdi?=
 =?utf-8?B?U1A3RFZOb1hORWc4dW5IRGdIckJkNUhoMDI2dVBwRDlEdUdBNFVtV3U5WWdQ?=
 =?utf-8?B?RGhKMkRLTWpoQ0FmR0YyeDIySGtEaCtOSFE0YXl0bGhsRmdFY2p3U0ZuKzdM?=
 =?utf-8?B?R2ZtUE8vSDBaR0lCYXBqeHZyZGJINkRCdDNTalE3ZS9PcktpQXIrSndNaVZM?=
 =?utf-8?B?SjhPU2cxK2F3SmJjTnRMMytSMUVVdTlSWm9UUTlFdmN4YTkzc0g5bVp2OFNz?=
 =?utf-8?B?dVJWMVl2Ui9RZStzZnFUbFhhZ1hnNXJPTlgvS0hhaWV2dDdwSkZ2WGh0Sld5?=
 =?utf-8?B?N0FEeUJsVlFyMW9sdkJuWGFHZXZxK28rcEhWYjczK2ltLzJqSHc0eFB5TXMx?=
 =?utf-8?B?U3NGaVQ0VkRPYy80NHlKNXVwM2hLSGdmM3lidTFMVjd0MExsRytuV0VycDV5?=
 =?utf-8?B?RkFLYktxSFdKS3RnZEF5b2VBWUo2MzQyTklPS1RQVG9rZ0JnYi92Ry9JVzEr?=
 =?utf-8?B?RkMzZ0ZhcVV6LytSUkZzYmthUUR0WTNLc25LWEVzZEk1SlpFSWRmUFJ6eDB2?=
 =?utf-8?B?NzVqaEZZZFpNQTk0MVhXVHR3R2NNMDhBOXMyNVZ6NUNJNjJMaDhMTXVuLzk1?=
 =?utf-8?B?UU0wR0t1eElsbjIwSTF3OXV2emlpV0RpYmxPcTMxSUF2ZDZDVVg1VHZ3Qmw1?=
 =?utf-8?B?cWJ1dWRlOHdIK3dxLzA1b3EvbXhCSjZReUQrVldwQUltV2gvdUZmWTBXVith?=
 =?utf-8?B?WFhXb1p4ZTJLNUh6ZGtvVW94QS9FK20zRURDYWV0M3E5Mmh3TS91cm9YaFRC?=
 =?utf-8?B?a0lxSnhQRXFRWGFPcmd6NlF3OUhpTmU0djE2V2tsT1Fyb0JTYVUwQm9GQUNW?=
 =?utf-8?B?YnNaNmhFTmcvcEM3OW1SR2dCM3JOMWtxMHNqVi9DUFZ1VjJjV0xTY2RCWWJN?=
 =?utf-8?Q?5nb4Kjk/BcWkseYRqb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f16c441-0ea3-4b55-7bfb-08de5f1d408b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 10:00:37.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsbnU190GGcuWkDyq99G1NZ0iTaVBNNRRqqGmrWm6FaHzHQ4JuJ2m1j1jjJNibS9FX5N47Go7aWho4Qm8DrMxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254680-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[nxp.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,quicinc.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: EF39DAE509
X-Rspamd-Action: no action

PiA+IEBAIC0xNzY4LDEyICsxNzY4LDIxIEBAIGludCBwaHlfYXR0YWNoX2RpcmVjdChzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LA0KPiBzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LA0KPiA+DQo+ID4g
IAkvKioNCj4gPiAgCSAqIElmIHRoZSBleHRlcm5hbCBwaHkgdXNlZCBieSBjdXJyZW50IG1hYyBp
bnRlcmZhY2UgaXMgbWFuYWdlZCBieQ0KPiA+IC0JICogYW5vdGhlciBtYWMgaW50ZXJmYWNlLCBz
byB3ZSBzaG91bGQgY3JlYXRlIGEgZGV2aWNlIGxpbmsgYmV0d2Vlbg0KPiA+IC0JICogcGh5IGRl
diBhbmQgbWFjIGRldi4NCj4gPiArCSAqIGFub3RoZXIgTURJTyBjb250cm9sbGVyLCB3aGljaCBt
ZWFucyB0aGF0IHRoZSBNQUMgYW5kIE1ESU8gYXJlDQo+ID4gKwkgKiBzZXBhcmF0ZWQgZGV2aWNl
cywgdGhlbiB3ZSBzaG91bGQgY3JlYXRlIGEgZGV2aWNlIGxpbmsgYmV0d2Vlbg0KPiA+ICsJICog
dGhlIE1BQyBkZXZpY2UgYW5kIHRoZSBNRElPIGRldmljZS4NCj4gPiAgCSAqLw0KPiANCj4gSSB3
YXMgY29uZnVzZWQgYnkgdGhlIHVzZSBvZiB0aGUgIk1ESU8gZGV2aWNlIiB0ZXJtaW5vbG9neSBo
ZXJlLCB3aGljaA0KPiByZWZlcnMgdG8gYSBkZXZpY2Ugc2l0dGluZyBvbiBhbiBtZGlvIGJ1cywg
c3VjaCBhcyBhIFBIWS4gSSB0aGluayB0aG91Z2gNCj4gdGhhdCB3aGF0IHlvdSBhY3R1YWxseSBy
ZWZlciB0byBpcyB0aGUgTURJTyBjb250cm9sbGVyIGl0c2VsZiwgcmlnaHQgPw0KDQpZZXMsIHlv
dSBhcmUgcmlnaHQsIEkgd2FzIHJlZmVycmluZyB0byB0aGUgTURJTyBjb250cm9sbGVyLg0KDQo+
IA0KPiA+IC0JaWYgKGRldiAmJiBwaHlkZXYtPm1kaW8uYnVzLT5wYXJlbnQgJiYgZGV2LT5kZXYu
cGFyZW50ICE9DQo+IHBoeWRldi0+bWRpby5idXMtPnBhcmVudCkNCj4gPiAtCQlwaHlkZXYtPmRl
dmxpbmsgPSBkZXZpY2VfbGlua19hZGQoZGV2LT5kZXYucGFyZW50LA0KPiAmcGh5ZGV2LT5tZGlv
LmRldiwNCj4gPiAtCQkJCQkJICBETF9GTEFHX1BNX1JVTlRJTUUgfA0KPiBETF9GTEFHX1NUQVRF
TEVTUyk7DQo+ID4gKwlpZiAoZGV2ICYmIHBoeWRldi0+bWRpby5idXMtPnBhcmVudCAmJg0KPiA+
ICsJICAgIGRldi0+ZGV2LnBhcmVudCAhPSBwaHlkZXYtPm1kaW8uYnVzLT5wYXJlbnQpIHsNCj4g
PiArCQlpZiAoIWRldmljZV9saW5rX2FkZChkZXYtPmRldi5wYXJlbnQsIHBoeWRldi0+bWRpby5i
dXMtPnBhcmVudCwNCj4gPiArCQkJCSAgICAgRExfRkxBR19QTV9SVU5USU1FIHwNCj4gPiArCQkJ
CSAgICAgRExfRkxBR19BVVRPUkVNT1ZFX1NVUFBMSUVSKSkgew0KPiANCj4gRG9uJ3Qgd2UgaGF2
ZSB0aGUgc2FtZSBwcm9ibGVtIHdpdGggU0ZQID8gVGhlIHN0cnVjdCBtaWlfYnVzIGZvciBTRlAN
Cj4gUEhZcyBhbHNvIGNvbXBsZXRlbHkgZGlzYXBwZWFycyB3aGVuIHlvdSByZW1vdmUgdGhlIG1v
ZHVsZS4NCg0KU29ycnksIEknbSBub3QgZmFtaWxpYXIgd2l0aCBTRlAgYW5kIEkgZG8gbm90IGhh
dmUgYSBib2FyZCB3aXRoIFNQRg0KbW9kdWxlLiBTbyBJJ20gbm90IHN1cmUgd2hldGhlciB0aGUg
TURJTyBidXMgd2lsbCBiZSByZW1vdmVkIGlmDQp0aGUgU0ZQIG1vZHVsZSBpcyB1bnBsdWdnZWQu
IEJ1dCBpZiB0aGUgbXVsdGlwbGUgU1BGIG1vZHVsZXMgc2hhcmUNCnRoZSBzYW1lIE1ESU8gY29u
dHJvbGxlciwgdW5wbHVnZ2luZyBvbmUgU0ZQIG1vZHVsZSB3aWxsIGNhdXNlIHRoZQ0KTURJTyBi
dXMgdG8gYmUgcmVtb3ZlZC4gV29uJ3QgdGhpcyBjYXVzZSB0aGUgb3RoZXIgU0ZQIG1vZHVsZXMg
dG8NCnN0b3Agd29ya2luZz8NCg0KPiANCj4gVGhhdCBiZWluZyBzYWlkLCBJIHJhbiBzb21lIHRl
c3RzIHdpdGggU0ZQIGFuZCB0aGlzIHBhdGNoLCBhbmQgdGhlDQo+IG5ldGRldiBhY3R1YWxseSBk
aWRuJ3QgZGlzc2FwZWFyIHVuZGVyIG15IGZlZXQuDQo+IA0KPiBJJ20gYSB0b3RhbCBub29iIHdp
dGggZndfZGV2bGluaywgYnV0IEkgY2FuIHNlZSB0aGVyZSBzZWVtcyB0byBhbHJlYWR5DQo+IGJl
IGEgbGluayBiZXR3ZWVuIE1BQyBkZXZpY2VzIGFuZCB0aGUgYXNzb2NpYXRlZCBTRlAgYnVzIDoN
Cj4gDQo+IG9uIGN5Y2xvbmUgViA6DQo+IA0KPiAjIGxzIC9zeXMvY2xhc3MvZGV2bGluaw0KPiAg
Wy4uLl0NCj4gcGxhdGZvcm06c2ZwLS1wbGF0Zm9ybTpmZjcwMjAwMC5ldGhlcm5ldA0KPiANCj4g
b24gbWFjY2hpYXRvYmluIDoNCj4gDQo+ICMgbHMgL3N5cy9jbGFzcy9kZXZsaW5rDQo+ICBbLi4u
XQ0KPiBwbGF0Zm9ybTpzZnAtZXRoMy0tcGxhdGZvcm06ZjQwMDAwMDAuZXRoZXJuZXQNCj4gDQo+
IFNvIEkgZ3Vlc3MgdGhpcyBpcyB3aGF0J3MgcHJldmVudGluZyB0aGUgbmV0ZGV2IGZyb20gZ29p
bmcgYXdheS4NCj4gDQo+IE5vdywgdGhlc2Ugc2VlbXMgdG8gYmUgYXV0b21hZ2ljYWxseSBwb3B1
bGF0ZWQgYmFzZWQgb24gRFQsIGJ1dCBJIGRvbid0DQo+IGtub3cgaWYgaXQgYWxzbyB3b3JrcyB3
aXRoIG5vbi1EVCBwbGF0Zm9ybXMuIElmIHRoaXMgaXMgRFQtc3BlY2lmaWMsDQo+IHRoZW4gSSBn
dWVzcyB3ZSBzdGlsbCBjYW4ndCB1c2UgRExfRkxBR19BVVRPUkVNT1ZFX1NVUFBMSUVSLg0KPiAN
Cg0KUHJldmlvdXNseSwgd2hlbiBTb3Jhc2ggYXR0ZW1wdGVkIHRvIGFkZA0KRExfRkxBR19BVVRP
UkVNT1ZFX1NVUFBMSUVSIHRvIHRoZSBkZXZsaW5rIGJldHdlZW4gdGhlIE1BQw0KY29udHJvbGxl
ciBhbmQgdGhlIFBIWSwgeW91IHJlcG9ydGVkIHRoYXQgdW5wbHVnZ2luZyB0aGUgUEhZIHdvdWxk
DQpjYXVzZSB0aGUgTUFDIHRvIGJlIHJlbW92ZWQgYXMgd2VsbCwgcmVzdWx0aW5nIGluIHN5c3Rl
bSBoYW5ncy4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW14LzIwMjUwNzA0MTQyMTM4LjNm
MWE0ZWMxQGZlZG9yYS5ob21lLw0KDQpJZiB5b3VyIGd1ZXNzIGlzIGNvcnJlY3QsIHJlbW92aW5n
IHRoZSBTUEYgbW9kdWxlIHdpbGwgY2F1c2UgdGhlDQpNRElPIGJ1cyB0byBiZSByZW1vdmVkLCB0
aGVuIEkgdGhpbmsgdGhlIE1BQyBkcml2ZXIgc2hvdWxkIGFsc28NCmJlIHJlbW92ZWQuIFRoZXJl
Zm9yZSwgYmFzZWQgb24gdGhpcyBwYXRjaCwgeW91IHNob3VsZCBiZSBhYmxlDQp0byByZXByb2R1
Y2UgdGhlIHNhbWUgcHJvYmxlbSBjYXVzZWQgYnkgdGhlIFNvcmFzaCdzIHBhdGNoLg0KSG93ZXZl
ciwgeW91ciBjdXJyZW50IHJlc3VsdHMgc2VlbSBkaWZmZXJlbnQgZnJvbSBiZWZvcmUuIFBlcmhh
cHMNCnRoZSBNRElPIGJ1cyB3YXMgbm90IHJlbW92ZWQgYWxvbmcgd2l0aCB0aGUgU0ZQIG1vZHVs
ZS4NCg0K

