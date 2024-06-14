Return-Path: <netdev+bounces-103729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AED90937B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11711C23C26
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143F91AB8E3;
	Fri, 14 Jun 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NAqAAEHX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63EB1A3BA4;
	Fri, 14 Jun 2024 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718397242; cv=fail; b=n2kSyP4IZnCgZgDXxzHaZz/docImQENdyA2HqM+X+gl1D/5M2gkoOgLZ/Zq33DNPEZNJuB9PJ78jagMGwrYtm8moVw582ml0Alkv9HkMN8tuhJqgCewThAUUXDKfu5UyIJ2Jj88rh6bSx6piD3cE3fAiglyvX3SF8RAQ+pnbQj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718397242; c=relaxed/simple;
	bh=3yzx5KB6n4OILjTp07AvcZIPyV99PC+9xzy776acipo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qrriiU68xlccKNjD1mjbiY7SGhjYAjTcEMsXfbYBIdspU9prUOv28QjHStz3vEzV3LnclrgTyX4f0fIdHpwjg4Vjhe9BU1Ba1lqtyaRHRZPtM0ztQz/crIgNHSjCCKf0Yl0h+8SpAKUcy3WSxKO9XjqSiMgA/c3xb1LKtrabA4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NAqAAEHX; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f18TiFcORjDsJDEwPZNhY4d8oA0w4/i+kHmGCW5qHIEbi9tgFSxlhmBkM5gPCZ5byLqOefcXe/1NBByJr9Qhy9vtpTRI/c9Jt8SC5T0oF+jCVKsjrXMJ6vHirLnZvVCTAF7+fVWQ3d8Ix8pPqKvowr4XuYAGY3JvXolNI2InlRdwlTdYPrjSbk6BXNQI0Lw4dol22x7zsyhZndNh0zP48F0yDgRVEIBnhJn/Mc98X6hJdnJEdCx2Coyuu5zsVpMlVYaTNOr8cMrqiVPSt4CvmOY3FpIKNJxk1gBDze4iRHQy6hxadITNuUVzPs/UUW9OZynL7HS+YtkR6EchCTopkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNCnDvOZiynOQkexZckOiKB/6PApXtbHWh27jeRreDU=;
 b=TMlq2ESUbU5+OPnL2pQn+ymLqkXK5j4WF8Sr4518LnLSHLstgSzO6zCHUkAFtRPHODygIvJ7OSh4HS/aYQNEwcegovh8lFX4uK8yvGlewEn4/L7ShABNYFDnk2mh065T9TWV2zMXXDmamr54nTZEjG0Rq54DpJcP4JeFFKHq4LxHM0L9V5fTvdcFK4+D5gU5CjZhFBg83neJrh4u8n+AkYKXl4LTham1ij7zjN/TKBvKA5BehjlpNG0Ewdkl0kYkT76fZjiyoLrRxL+ZavdnZWpD2gGqvc1ntyc6KqGG9juEAMtcS3YMoSNGEFSrdqhav1Set5W4GWnzaX4kPfJxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNCnDvOZiynOQkexZckOiKB/6PApXtbHWh27jeRreDU=;
 b=NAqAAEHXY5vEAUDHpC7veFI85wF903+dtlEUAdue1SN5DTiR7MeVE0DfpattyyeGYmx+fTZhZGQokARNaDAqbN1joi/Jo+TAgp/jeDXxoLQQoUJDyLY8aCmEDUc8RNxL3Q/2fAv0Wjp9SaiL3KSVQHGhUd/BpSUN1lkrGIim+EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10203.eurprd04.prod.outlook.com (2603:10a6:150:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 20:33:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 20:33:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 16:33:28 -0400
Subject: [PATCH 1/2] dt-bindings: ptp: Convert ptp-qoirq to yaml format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-ls_fman-v1-1-cb33c96dc799@nxp.com>
References: <20240614-ls_fman-v1-0-cb33c96dc799@nxp.com>
In-Reply-To: <20240614-ls_fman-v1-0-cb33c96dc799@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718397228; l=9765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3yzx5KB6n4OILjTp07AvcZIPyV99PC+9xzy776acipo=;
 b=fx6F9GGJozFhkuxIT4P5wAy3wbp3ux0w5sA9GREA689tQhP3VoyF5Gs2sHIPEpyuP1ryO2cym
 MWdBsPZ+SwyAjMkFUrdrE8rtb04dhxFjbukGfyzPzkhnuQekz+6gPI7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10203:EE_
X-MS-Office365-Filtering-Correlation-Id: d337a676-1616-4360-1caf-08dc8cb15087
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|366013|52116011|376011|7416011|1800799021|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UVdqNTM4N0UxMUhuZFZ4Q2xnbExSR2VuZnJQc3BBeE0zQWQ5M082LzNVeGVM?=
 =?utf-8?B?b21aQkJmaVZmS01Ia3B2VGhKTTBHNjZIQnJpQ2pxZFgyQ3dSN1dXSlBkNTRS?=
 =?utf-8?B?ejRoZDZNVi9VcTF1OXVUdDlWemNvYUhWVlQveEdDUXM1T1UwV1pJNzJtSUpr?=
 =?utf-8?B?eUtROVp6a1RzR1B6M2gyZ21DNTN6Ylp1M08xd3dQTmd4YjJveUdUaVJXaE5t?=
 =?utf-8?B?RkJoM3NTcUNuTnpUNnhtNGQwUmpaNjJibDFpZTJVOG9BQTZzZnUvQ0FrczBR?=
 =?utf-8?B?SW95b3hNbWtDNitEZE5Xb2VuS3pkeDBiamlqV0pYd2tjSmZ6S2lweFRwZWlV?=
 =?utf-8?B?ZzhtSk5GVHU2RUhxYmNJQlBLdW5OT3MwUm5NYzZydnpQYUNsRGZoQTJlb1Rq?=
 =?utf-8?B?MlNZRnV0VXRWMExZdTg2aG5XRXdRWW15cWViS0ZOMnpBUlo1cGJ2S1dmN1d0?=
 =?utf-8?B?TVB5NXNBZWx5MzdXcndFWWZyT0tqRm02SWdOdEl1WTZIRFJ0QmE3UTU5WUU1?=
 =?utf-8?B?MUc1bk9KZnF1TGlmekdlQWllREFLSHhaaXIzbXhLVnNsSXI5cGVPV093VFg4?=
 =?utf-8?B?aWhuWTJFZURvWG5nWkR0RkF2WXluQ2FlaDR0YnBWVFhmdjZ5WXJyUTA2RXJJ?=
 =?utf-8?B?S2tuQzQ3aTR6M1FUTFhJKytOSjdQRXo0c1loWEY2Z0xNNUpWK1V0b1FuaVlw?=
 =?utf-8?B?L3kvK21rVWN3Q1k3ZVJUa05tTy85TEYxK0czNGlLNnp1a3E2TFJNMTVZYXJU?=
 =?utf-8?B?OUN2N004dXRJK2FuNTR1UERnakxlSVkzcWY2SllhTDFYQVJ6cnVJcmdBOENh?=
 =?utf-8?B?dkg3SnVtYTJRby9ja0hhNjVaS204MUZrMFdoeWFvbG9JT2lhelRhcm5IWmF0?=
 =?utf-8?B?YWlaWjV2M2RvcklDaFViVXNYcXNLTkFCWXVhOUtRL3RPbkMwVlg2U0JQVW55?=
 =?utf-8?B?YWRVMjdhT0JZeVFYWm9wM2o2K2pBZm9WYmpMY3J6YUVvVUtvaGhVemlwOHpY?=
 =?utf-8?B?Zml4c3IyNElZditaTXE0RlduWE5BRC9BbXpTd0R2czNiak1XczdtQ3M0c0E2?=
 =?utf-8?B?SjlVYlltZ3k1b0Q1SkRyN3RKOGxOaGNNM1Z4ZFF4dFE3b05SRm1tL0RMK29V?=
 =?utf-8?B?Ykd0Nk81M28xV0hLcXJCVkV4SklOZ2RhMXVtNGNRQWhpclZpek1laVN3RGdy?=
 =?utf-8?B?Qk50cjd2SlZQSnlQREpTdVNpeUlEc25HWlRTSzJtKzZmU2tRWFdqZzM0S09q?=
 =?utf-8?B?Nm9OTzc5RUdvZVBQeWowc2k0RlFseE9Nbi9BZlJhOHRJUkVFemc3Ylg0UmFT?=
 =?utf-8?B?RzM4OGFBZERyNGdrNXQ0YzhWeVphemh4KytqNGpiWUoycjFrMlV2eHVqNWF0?=
 =?utf-8?B?ZkFERXprRVRpam83dTZGU09Ec09vZVdzeWdYZ1NkOEh3VmZQWVc3VVhYTit0?=
 =?utf-8?B?UjdiZWpub01rQU1aLzVlU1ZPdGxoVjVqUmljTHJVL09heGpEMzh1S0E0eHNv?=
 =?utf-8?B?b1gyS2tVNCtuY250OGU5akJXOFc5K3RocXR5dmp2eGgyOC9XNDJFL1NJNTl5?=
 =?utf-8?B?V0NxVWFuWnVvVVZERjhqNDdiaHlUemt6dFpwUGthRDRuOWovWDR6elFScW9q?=
 =?utf-8?B?RW44cE1DU1NBK3Iza0FYRjliNVpsZC83WnhkdSs1Z3lrdWNkRk1MQTlqQ2Ru?=
 =?utf-8?B?ZEFkZXlwZEdPcEU2NEJsT3lPZ0pEWUMrbmlpOHRDdVpSellhZEtjejNUcmdw?=
 =?utf-8?Q?/tPmvHDuY+0i1aEzc9PlwxGy33M0I7p0TvDqQm8?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(7416011)(1800799021)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L1B4WmU3RCs3Z251cysxNUpwbUFsS1QyajIzU05tV3VRZEdHME83dWExVVA4?=
 =?utf-8?B?NWVtQUx4S3dwcVEzTmVhNmFUTm0yUVdjeVpxOGtTeVVTdXdvS1Zub08wZytF?=
 =?utf-8?B?U1F5cDNHU21uZFNoU2lILysvUU9oV0VTakZrdlRPbzhuaHNsNEFBV245dWI1?=
 =?utf-8?B?MFA2cGVLbnFhMmtKbXYxUGRsN2RqQ3RnR1dERlhJUWNVUXBBaFdqcWZEOCtu?=
 =?utf-8?B?QWtlODdra1hwSUsxbVBnNEQxY0x3N2RyZ3Y2VFR1TVcxb0FmbmZVUXdWZVVK?=
 =?utf-8?B?WEhlMVpNT04ybXI0aGxmM1hBVTdXSmpNM2lKNmVOWUdYODN1K0I2NzNpYmxB?=
 =?utf-8?B?MTBValg3SEJnbGNDT0dTVTROOUwrREkzWWxnWEJuZmJxZlZMM0FnTXo5VDBo?=
 =?utf-8?B?YmlNdklrLzNzUCtwU0wzMDg0ZERIUnVYa0lNcGtNQ1A0UUNteHN1Ym04clRU?=
 =?utf-8?B?Y0xLOER6bW1TZC9sWjQrM3phK012MWtDTkZxYm9IQUdmR2RmNDRDMU9CbG55?=
 =?utf-8?B?WU4xRXRva2xMQSt0VEdNMFFSdldIY3h0L0ZkZ2FFcGRhdEJ2WmswVlptamRN?=
 =?utf-8?B?NWpYVHNTQXE3Z01ZVExBcHlCQkpIejZJbitmOUxQeUJ5TWJSZWs2SXN5LzR0?=
 =?utf-8?B?UzFiT0p4NWZRWW81R2Q4OG9RdXRNcVZ6bUtRc1NNVWc2c2Z6UDVOem5jQzV1?=
 =?utf-8?B?S3lwQ0M1WWRDUmt1YU5WVGFIYWJOQ3hOdFdvZjJBeE45T0p5Qm5wZ1R1aXhS?=
 =?utf-8?B?SE55R0VaTjdQNUpoU3d5ZGI3Tll4ZERkWWlSMXhwcmxyWnB3RW5JcUVnemgx?=
 =?utf-8?B?SDVHVGI0cEtZQVBDaGN6MzNOaTdoTjFXU3dvVHVnUEN6Q1NDS3JqSXQxRHpr?=
 =?utf-8?B?YzMyc3FIZjQ0VDArVk5vUkRGcWN1TmFzQWNySnZHMGhTb3doWDc3YUF6TkdL?=
 =?utf-8?B?eDBORHZWU3dSU0R3aHdwR3o3K2hnWldOa1dwcnFhcTFMMzZKVDlHZDFPWnlH?=
 =?utf-8?B?WkZJbWxUZVZXZ251Ym1DY3gwY0FaNGRpTHpmNXcvRzlzNjhHd0pPK1ZTR2ZK?=
 =?utf-8?B?U0xRWncyRVBoY1lCYjU2OXl0bDhJbFR3MW1ubmF0aWdVR01Bb3lGalo1WHZR?=
 =?utf-8?B?M083TXhHNVN2WTM4YlFpZWpnVjdUZmo1N2lObkJZMDJlaG5pS3Vsbmt6c2p5?=
 =?utf-8?B?cUo2eFdVdHZNM2QyRlljejBnTVVHY2xEN3E5dm9XVzZZSnlrbExtVkZJV3Ry?=
 =?utf-8?B?Vm40aEhGWkt0SVJUQjI0aXg5bEVybzZDVHBVS3dETDVXVC80S1Y3eDI2YnZ3?=
 =?utf-8?B?WkFJZ1o0bWgrRmZMWjRYNGhDZzBWT3lIMU9WSUdzbWxBSklhaHgwOTlrMzJ0?=
 =?utf-8?B?MUxhQ1IrZUttSWIxdU9MWmJZWVQ0L0paNGYvZnlyZ0hkWHAvam1jU3VPdHFO?=
 =?utf-8?B?OW1NaEV4bjJJcU5ycHlnRjFWWVc0WTFiSk51em1TU0RxZlNEL1RNV0RkRnFE?=
 =?utf-8?B?aytUYSszYmdRbTFEZXorWDVUendUQ0NJWnY0UHZHUEcrc2R4L0lRNEozY1dF?=
 =?utf-8?B?ZkdRMkh5ZXBJT0xvbEROZG5qclFON0lQQWw0NTR5SUF3M0xkb21ZN2NYWDRy?=
 =?utf-8?B?Yi80dEUvU2lueXo0Y0RiSmVzSXJuenplbWp3K3pPUnN3L05uZDJDRTQ3NG9Q?=
 =?utf-8?B?aUxKTXlQYi9veE5IMWFpdWVUQ1BpN00rTUp1VkhDR0w2amFyUDNJdmd3TUla?=
 =?utf-8?B?N1J2ZjQ2amxMaEZQK2Z3YnNuQTRYRGNjMUZFcHdSNnc5dDN0VjRYblNwbXpz?=
 =?utf-8?B?WCtneW5sZXBRSGk1NmdkYmhGaXB1aFVEYXU3VUE0UU4wUTdjSmZLRTh6dWp1?=
 =?utf-8?B?UFdrVDFMRm4rRXNFajY4NDVVWlV2aTBsWDFJL2FHY2xFMlA3bktkN01NdEhW?=
 =?utf-8?B?NDcvTmhpNlpWd0ErTWo3a1ZOaER2V2tNSytnQkFoZDIwcytrS1JGcXpxc1J4?=
 =?utf-8?B?a0h3VGdseWlpL1JJSTFkaFVtTUJzVW5ucjZ4c1NzbFBsQnJKb3YyN0RoVXNG?=
 =?utf-8?B?TXlDTHlnam1TN1VlN0N2eWp0ZlVyTVB6dUFDdnQvWVFxZmxlTEw4aWk3TGJj?=
 =?utf-8?Q?/JIqhdDswhp57IdMoNE0/4Kw2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d337a676-1616-4360-1caf-08dc8cb15087
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 20:33:56.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueO+5vL1H9tcfh4PsjytrKy+D8wFEIAdf6XHZ82/AdYM8EaxKsCIP2m1Cv5IPRRZimwj2Kbm6+bFxwN69gBhpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10203

Convert ptp-qoirq from txt to yaml format.

Additional change:
- Fixed example interrupts proptery to match the least 2 interrupts
requirement.
- Move Reference clock context under clk,sel.
- Interrupts is not required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |  87 ------------
 .../devicetree/bindings/ptp/ptp-qoriq.yaml         | 148 +++++++++++++++++++++
 2 files changed, 148 insertions(+), 87 deletions(-)

diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
deleted file mode 100644
index 743eda754e65c..0000000000000
--- a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+++ /dev/null
@@ -1,87 +0,0 @@
-* Freescale QorIQ 1588 timer based PTP clock
-
-General Properties:
-
-  - compatible   Should be "fsl,etsec-ptp" for eTSEC
-                 Should be "fsl,fman-ptp-timer" for DPAA FMan
-                 Should be "fsl,dpaa2-ptp" for DPAA2
-                 Should be "fsl,enetc-ptp" for ENETC
-  - reg          Offset and length of the register set for the device
-  - interrupts   There should be at least two interrupts. Some devices
-                 have as many as four PTP related interrupts.
-
-Clock Properties:
-
-  - fsl,cksel        Timer reference clock source.
-  - fsl,tclk-period  Timer reference clock period in nanoseconds.
-  - fsl,tmr-prsc     Prescaler, divides the output clock.
-  - fsl,tmr-add      Frequency compensation value.
-  - fsl,tmr-fiper1   Fixed interval period pulse generator.
-  - fsl,tmr-fiper2   Fixed interval period pulse generator.
-  - fsl,tmr-fiper3   Fixed interval period pulse generator.
-                     Supported only on DPAA2 and ENETC hardware.
-  - fsl,max-adj      Maximum frequency adjustment in parts per billion.
-  - fsl,extts-fifo   The presence of this property indicates hardware
-		     support for the external trigger stamp FIFO.
-  - little-endian    The presence of this property indicates the 1588 timer
-		     IP block is little-endian mode. The default endian mode
-		     is big-endian.
-
-  These properties set the operational parameters for the PTP
-  clock. You must choose these carefully for the clock to work right.
-  Here is how to figure good values:
-
-  TimerOsc     = selected reference clock   MHz
-  tclk_period  = desired clock period       nanoseconds
-  NominalFreq  = 1000 / tclk_period         MHz
-  FreqDivRatio = TimerOsc / NominalFreq     (must be greater that 1.0)
-  tmr_add      = ceil(2^32 / FreqDivRatio)
-  OutputClock  = NominalFreq / tmr_prsc     MHz
-  PulseWidth   = 1 / OutputClock            microseconds
-  FiperFreq1   = desired frequency in Hz
-  FiperDiv1    = 1000000 * OutputClock / FiperFreq1
-  tmr_fiper1   = tmr_prsc * tclk_period * FiperDiv1 - tclk_period
-  max_adj      = 1000000000 * (FreqDivRatio - 1.0) - 1
-
-  The calculation for tmr_fiper2 is the same as for tmr_fiper1. The
-  driver expects that tmr_fiper1 will be correctly set to produce a 1
-  Pulse Per Second (PPS) signal, since this will be offered to the PPS
-  subsystem to synchronize the Linux clock.
-
-  Reference clock source is determined by the value, which is holded
-  in CKSEL bits in TMR_CTRL register. "fsl,cksel" property keeps the
-  value, which will be directly written in those bits, that is why,
-  according to reference manual, the next clock sources can be used:
-
-  For eTSEC,
-  <0> - external high precision timer reference clock (TSEC_TMR_CLK
-        input is used for this purpose);
-  <1> - eTSEC system clock;
-  <2> - eTSEC1 transmit clock;
-  <3> - RTC clock input.
-
-  For DPAA FMan,
-  <0> - external high precision timer reference clock (TMR_1588_CLK)
-  <1> - MAC system clock (1/2 FMan clock)
-  <2> - reserved
-  <3> - RTC clock oscillator
-
-  When this attribute is not used, the IEEE 1588 timer reference clock
-  will use the eTSEC system clock (for Gianfar) or the MAC system
-  clock (for DPAA).
-
-Example:
-
-	ptp_clock@24e00 {
-		compatible = "fsl,etsec-ptp";
-		reg = <0x24E00 0xB0>;
-		interrupts = <12 0x8 13 0x8>;
-		interrupt-parent = < &ipic >;
-		fsl,cksel       = <1>;
-		fsl,tclk-period = <10>;
-		fsl,tmr-prsc    = <100>;
-		fsl,tmr-add     = <0x999999A4>;
-		fsl,tmr-fiper1  = <0x3B9AC9F6>;
-		fsl,tmr-fiper2  = <0x00018696>;
-		fsl,max-adj     = <659999998>;
-	};
diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.yaml b/Documentation/devicetree/bindings/ptp/ptp-qoriq.yaml
new file mode 100644
index 0000000000000..585e8bffd90c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/ptp-qoriq.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/ptp-qoriq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale QorIQ 1588 timer based PTP clock
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,etsec-ptp
+      - fsl,fman-ptp-timer
+      - fsl,dpaa2-ptp
+      - fsl,enetc-ptp
+    description: |
+      Should be "fsl,etsec-ptp" for eTSEC
+      Should be "fsl,fman-ptp-timer" for DPAA FMan
+      Should be "fsl,dpaa2-ptp" for DPAA2
+      Should be "fsl,enetc-ptp" for ENETC
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 4
+
+  clocks:
+    maxItems: 1
+
+  fsl,cksel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Timer reference clock source.
+
+      Reference clock source is determined by the value, which is holded
+      in CKSEL bits in TMR_CTRL register. "fsl,cksel" property keeps the
+      value, which will be directly written in those bits, that is why,
+      according to reference manual, the next clock sources can be used:
+
+      For eTSEC,
+      <0> - external high precision timer reference clock (TSEC_TMR_CLK
+            input is used for this purpose);
+      <1> - eTSEC system clock;
+      <2> - eTSEC1 transmit clock;
+      <3> - RTC clock input.
+
+      For DPAA FMan,
+      <0> - external high precision timer reference clock (TMR_1588_CLK)
+      <1> - MAC system clock (1/2 FMan clock)
+      <2> - reserved
+      <3> - RTC clock oscillator
+
+  fsl,tclk-period:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Timer reference clock period in nanoseconds.
+
+  fsl,tmr-prsc:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Prescaler, divides the output clock.
+
+  fsl,tmr-add:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Frequency compensation value.
+
+  fsl,tmr-fiper1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Fixed interval period pulse generator.
+
+  fsl,tmr-fiper2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Fixed interval period pulse generator.
+
+  fsl,tmr-fiper3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Fixed interval period pulse generator.
+      Supported only on DPAA2 and ENETC hardware.
+
+  fsl,max-adj:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Maximum frequency adjustment in parts per billion.
+
+      These properties set the operational parameters for the PTP
+      clock. You must choose these carefully for the clock to work right.
+      Here is how to figure good values:
+
+      TimerOsc     = selected reference clock   MHz
+      tclk_period  = desired clock period       nanoseconds
+      NominalFreq  = 1000 / tclk_period         MHz
+      FreqDivRatio = TimerOsc / NominalFreq     (must be greater that 1.0)
+      tmr_add      = ceil(2^32 / FreqDivRatio)
+      OutputClock  = NominalFreq / tmr_prsc     MHz
+      PulseWidth   = 1 / OutputClock            microseconds
+      FiperFreq1   = desired frequency in Hz
+      FiperDiv1    = 1000000 * OutputClock / FiperFreq1
+      tmr_fiper1   = tmr_prsc * tclk_period * FiperDiv1 - tclk_period
+      max_adj      = 1000000000 * (FreqDivRatio - 1.0) - 1
+
+      The calculation for tmr_fiper2 is the same as for tmr_fiper1. The
+      driver expects that tmr_fiper1 will be correctly set to produce a 1
+      Pulse Per Second (PPS) signal, since this will be offered to the PPS
+      subsystem to synchronize the Linux clock.
+
+      When this attribute is not used, the IEEE 1588 timer reference clock
+      will use the eTSEC system clock (for Gianfar) or the MAC system
+      clock (for DPAA).
+
+  fsl,extts-fifo:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates hardware
+      support for the external trigger stamp FIFO
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The presence of this property indicates the 1588 timer
+      support for the external trigger stamp FIFO.
+      IP block is little-endian mode. The default endian mode
+      is big-endian.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ptp_clock@24e00 {
+        compatible = "fsl,etsec-ptp";
+        reg = <0x24E00 0xB0>;
+        interrupts = <12 0x8>, <13 0x8>;
+        interrupt-parent = <&ipic>;
+        fsl,cksel       = <1>;
+        fsl,tclk-period = <10>;
+        fsl,tmr-prsc    = <100>;
+        fsl,tmr-add     = <0x999999A4>;
+        fsl,tmr-fiper1  = <0x3B9AC9F6>;
+        fsl,tmr-fiper2  = <0x00018696>;
+        fsl,max-adj     = <659999998>;
+    };

-- 
2.34.1


