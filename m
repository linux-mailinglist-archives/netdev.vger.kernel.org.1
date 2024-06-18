Return-Path: <netdev+bounces-104670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76FF90DEBF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7692815A1
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2618188CBF;
	Tue, 18 Jun 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PiERpuY3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C181849F9;
	Tue, 18 Jun 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747656; cv=fail; b=UBgazvhcYea+FSrvngoL/BNctCAoIr9A8wbMJ8Bu3McwygL/A3yJVcBcM1WhyCbGCyVtVKfRjhezGgFCSwaClaGFW4tzdfTeygQT807B6TMXeRvEg8VCJgp3TItI9MPBxo1+wYNDcndGYnnwB8DFViNJ3f0fEwDKpuhwJ9gRATU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747656; c=relaxed/simple;
	bh=y+AGv642+cjvVIlm1YYGdrJXgyEzPHH4My0jZF3TceM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lzi01MWWR/HTFITdQqPHDfWMvGbRwqQGYx9KoXjXbtvMx9+mTsRKMfpwKJN7h2URTrpLp9oxBK7fpPfL35f78c3k1y+/3EI6JDW3j+mWI7pSwkIfFTieGSKU7iX10LhK/T9pu8VAcuvfI+gDssopn8MhszuOOFcvxevO5Wj5V6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PiERpuY3; arc=fail smtp.client-ip=40.107.104.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZUrO8U/GUp1/LkcF1yHY9tepfM8M9/CzLvPy51g81G1Ddv2bEvKx2TkMizqUWgr8OSNx+atAZ/gpDGdaq/0nRWuY6GXOamQWrw30G0ayyD8Tn0EE3L4iMFjJS97LyEKRA9KaoccUO+wW2X4bhYsJw5XvBxvwx8VB1qjJbu6J0AqVDBQ5Lt3AHIQswc08BQwtbLMSAkRLNMdV3xnUmGcWIUvWpTAr/OJBi9nKPdw1Ysy0yA7dc8KwNQyCVT8tOUlhkPD4vUpxNpvXsWtvnLZ9s8NwbQ6kYDP3x7+rqtU8sPfvZlz67hrOO/42EFPW9SDSw1cx/ab0XdgM9pxX4VbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K/evLQlTA+kCcmXthRa4tT32k7EbFByQpMvdjulQd8=;
 b=Z9n5d6nBWGByYZ7jfOUHIjGHQpTnSLFGP6wYClGeemzLnLPV9ReDZeTka0HYbeRTDFwnVjwAMipEowtzzk9EV/vg/Tsfi+Mq9f9YFqPAlxkw3AwX4TxY/NnChW+P+CYOoTpcHkKo5BiBSbMSU3G0JylGA7qdYFqc8ld+jcPqMxTHYwXyJSwhyb8SQAWANiWjk0CGqeTlCEZcUHgbug7kIFQTSDU3/C+TZTG3q+CJgJ6yftbly902r0Vbe8TBPqx4r4iZeOjX/6w0UpVVh6hswMuy+X1aVWeYxMAqlD9w3f84mZqWvhKzMln8mZapqNVDtlA7WxtgvpNwK0FSru08IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K/evLQlTA+kCcmXthRa4tT32k7EbFByQpMvdjulQd8=;
 b=PiERpuY3CJq9sYRLDJxN1yNGgQIn8cIfwqnw0y2EC0My3uT1h39tDau+LtrVMGpevEN+Yx8rusvcvtUv3CRgTKOCN00rfmKV4eyXp5CZx5R7G8brt4sBqUJ+M2jYtVWDvfJaB+hYJDmGBa8MTTveY9r92PLf95kMzoLg1AFVwT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11008.eurprd04.prod.outlook.com (2603:10a6:10:58d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 21:54:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:54:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 18 Jun 2024 17:53:46 -0400
Subject: [PATCH v2 2/2] dt-bindings: net: Convert fsl-fman to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-ls_fman-v2-2-f00a82623d8e@nxp.com>
References: <20240618-ls_fman-v2-0-f00a82623d8e@nxp.com>
In-Reply-To: <20240618-ls_fman-v2-0-f00a82623d8e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718747639; l=31822;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y+AGv642+cjvVIlm1YYGdrJXgyEzPHH4My0jZF3TceM=;
 b=8D3fFwftBWTGd/ITgJRU2pBvnzvJpmVPKiXTPzS7l00WGt83IJ3FhuOO8fgnFxsxCnROfV01y
 28ehjRgbWg3DeINaBSPa2VnxDkCCJQKg5L526n8huFWBciFWJCZqDMW
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
X-MS-Office365-Filtering-Correlation-Id: f76b1992-e377-4b5a-60f3-08dc8fe12f94
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|366013|376011|52116011|1800799021|7416011|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UEhCU1F1U21OaXFpYkMxdmtIbkRCWDF2U1UvV0R2b3o0bmxBVVZpS0YyL2pl?=
 =?utf-8?B?MWQzTUVCQVdrYWR6cmVHRVRyd0t6QVNPOFFnMGVHMjc3TGVCenpsdlFMSFdJ?=
 =?utf-8?B?V2pDNXhpWEw2ODFuMDZOME95T0JKWmVPb1NKU2xORWgvQzAzSmlWYlVrdWZx?=
 =?utf-8?B?T0ZIdUJxOERadVgzdEk5SE9tbXNsZ1ZOM3gwWTFzYTZGMVpzT3U3UE9MTE9W?=
 =?utf-8?B?ck96N2tTUlprTGRnNXR4b20ybEIzTDFhUVpCU1FnbHJ5d3ZWa0JDY0VkY0c0?=
 =?utf-8?B?cVVxOCtubTlHRU03MmdlM2Rhem5TclFnNUJDbXdJT0tna3ZrQUt6VnlxUUlp?=
 =?utf-8?B?alpCNDNoclI5dTJFL3dxMWhGRXJDOFRYb0lldG01VGtBQXNIM2dmbG5kVDkv?=
 =?utf-8?B?ZjRoZ1ZORmpHN2pIdHFPZnRieFlNNnMyNzVKN3gzV3ZvQVZZNzlVNkVtTGlt?=
 =?utf-8?B?ZlQ4cVNrTlNPQTdSbUt1RFhFN01RTVJORWlWbjVWMVBQcGQrTVZDWm5vZkhL?=
 =?utf-8?B?dlZwNytYc3pBUlo5VnUwZlpXNkZxV2tkaUp2Tm5WaDVjV1hRR2ZVeUlZVlNL?=
 =?utf-8?B?dHhITUMyMEdjRHVQQ0QwWkhqdnRKdlM2NkMvcDN4RDZobTFyV2VKRGxSTjdJ?=
 =?utf-8?B?dWluZmF1V3ZyVENSRjZHa3M2a1hqM3A0Q2ZrOTFuNXQzU3hGaDkxMk95ZWpT?=
 =?utf-8?B?ekZvSWIrTXlRU2wxd2xMckVidFBHMXl5anJmY1I4U09JZGlYV1NGTlJrZkZs?=
 =?utf-8?B?aHFWbUpNbjIzdkhQaUg4WUkraUdNaFNLWjRHYXNRd3djT2o4Ti8rWDNpeDZZ?=
 =?utf-8?B?dDRmaUdBaHd0eEVrdXpRT1FyL1Y3dytkVHc1WWN0RzZzR3drQkpYa285VFdT?=
 =?utf-8?B?R05oTGF0ajdiVU1yWTloZVdWMnJLSFl0NTgyVHN1enhGVXlSckUwNjFCbEZD?=
 =?utf-8?B?ck9xclRFb3NNV0dZWGV3bE9Gc1BrOWhyenhyZU8rMjJlR2piR3ZWdHA5VGND?=
 =?utf-8?B?elA1VzZJdjhQS1IrdmxuaVJZQVY4NFQzb0pvVFJYT0RpTm4wUlBDeFYrcEJR?=
 =?utf-8?B?Qjd2YzdCNEZLcjFqNTFqNSt5ZlFzSEZEN0llZ1VORWp1VVBEbTZJRnBGaUs4?=
 =?utf-8?B?eVF4dHZBV1JLVUR2THZMOG03SVEwaE80VkJ1ZW04c1pMVDZjaTNyRVNSNVBu?=
 =?utf-8?B?OUdzMVBzRlFSL1pzZzdYWnpwbFViUDZHeThZMHhwU2tsSUZ0QU9STWI3LzZz?=
 =?utf-8?B?UVFNOHczYWRWajJ2V0JNYkZJSnFhOEtUUDN3aUNEbEozRmxnY0dKakJMYmdr?=
 =?utf-8?B?WTNqaEVobTFPWTVHby9xNStSMEJLakxVWTJmb09kcEpxSzVhdHlUczZrNWRM?=
 =?utf-8?B?VUpIaHRZSmRiTG04TkdxVTEyZFlpUjFTNmFnUVZEM1RycERVNkJuZHdBWEdT?=
 =?utf-8?B?SVh5aGNEMmdBZzkwM1J4M3lqZ0NQb3cxRzM3aVo1QkdTZFdEa25mSHozMGw1?=
 =?utf-8?B?SUFkc25CeVJrbXFRRnRjMjkxaGcvNzFKeXd3V042WDNCQWdlR3JaOEl2akpp?=
 =?utf-8?B?UzFWVjZ4QVlrVktTL1Jvb0tHRlpQbVRMRzVpOTBJM2Z6TkhQc3RDemxjdGV2?=
 =?utf-8?B?b2F0b0poK3RjRjgyeEpPU1lhV1RsRHF6eDFIVy9CdnJ5Mytzek12eWtDMGtR?=
 =?utf-8?B?OGsxVm1QYjFJdjBTQ0dsUXJHQnN0RFVHb0ZqdzA3ZDZOb1NJVitubHFxWUUy?=
 =?utf-8?B?Qy9MZWRIeUxPR0pmOTFoNG1jS3RRdlg0K0NZbzVzd0dmRnZYbTU5ZkVnMjBH?=
 =?utf-8?B?eXZaUUlKbGVSQjIrUUdDdz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(52116011)(1800799021)(7416011)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SUdFS3VDa2NHeHZvU3ZmUW4zd0M2UFUyY1dJQWw0TFRsSEV0T1p1QU5xakkw?=
 =?utf-8?B?bmhjT2FIVVRoK0s0SmZvcUV4M1Q1MENmc0x3QzVVOC94U3VUckxOTHlGWVA0?=
 =?utf-8?B?Ulo1b1Y2ZW40dEo4UHNtRDVEOWx2NENGZlZrMWFZSG53UnBIeFBIU3VnbFg1?=
 =?utf-8?B?Qjl4OFQ3US9EMUVVZTF2L1hsWUtXc2FENzJlNlV4ZkZNUjVYblBaOWZzUWc4?=
 =?utf-8?B?OTFDdnRhOVd0WGRERVVqOXBzN2VPYVF6dnAyNHVEK24vUHBkRElwMDVKZE9k?=
 =?utf-8?B?cFhUL1BSdjREZ2VzdjVNcXUyUm9EODNQOXFpNzd6aC8vZ0UrY3VXOUFEUlEz?=
 =?utf-8?B?cVAxKy80QW9zQnRVeUtWVitWY0hYWWJ3VVZ3MHZnMXprYjZNWnpHakdlZGpv?=
 =?utf-8?B?YmJSQXdLRlZsdkhES201b0YwWFQ4MXFROE9NODVvbjJjTHRSbWR3bFBvL21T?=
 =?utf-8?B?Y1pCR3h6VUF3ckZOZURHbmRQcUprSkptVVpPQ3A2SmJaUTNqd25WeXpMZFR4?=
 =?utf-8?B?YnNkOEc5clZsN0ZKSUVpZHdOQ1BxMytmNTJTNSsyRHg2bFFPNVhjekJIWk84?=
 =?utf-8?B?UHI0R096UloveFhaTmxmTExRRGgyZHFGY2hCMzRseVVQc05mczY3b1UzVTg5?=
 =?utf-8?B?Z0VobXN2TG1vMDhwTXJ3RXJBQnRNVTRRZFBjaWFyNXd1OFhmN3ZtaVg2QllR?=
 =?utf-8?B?cjVLZUI2SHMxZUdNZ1ZnTThvd3A2d2lLdWVVRXRRTnBIWENNWHI4TWJrN3FS?=
 =?utf-8?B?MGFBS2cwTVQvSmxVZWhaV042Q2tRSU5JRmhMUlJuZHVDSEozVU5kYk5yckhS?=
 =?utf-8?B?NEJDNjl3Qk5WS1VXZGdLOFhNeFhmMjcwNnc2KytHU09KdzBPK3hOSnlSTDlr?=
 =?utf-8?B?eSs1WGoycXA4MjdQYzhJVnJDOGxzSWZKUEUxYjlSK1ZaUktGNlVoMVc4aXFw?=
 =?utf-8?B?dU4vVFNXS3ZYSCs5bG13bDRXMm9CR0IrczAzSmRCK050b3BCczZMczhyVlEw?=
 =?utf-8?B?UzFIOWh1YzV0bXdrMDZCdHRlaG00eUpnRm1qc0IyNVVEVGNoTmdwSFdYSXQ4?=
 =?utf-8?B?S2U5QUhmbGxVUms2YTlPd2xmL1VVTitOUWt2cHk5anVJVnlGMFdvdmR3Tmlv?=
 =?utf-8?B?OGYyWjRPRCtGdStVZjNhTC90NXlIeCt3Y2Z5YmIxYndPSXVpckVqTlZmeUtq?=
 =?utf-8?B?M0o4cFNndlNPeUVHb2ZhYStScFpSWHVxNnFwdU1BK2NuMTN5T3dqNUcrT2gr?=
 =?utf-8?B?ZWRMS3pyUEJqMHRRVUEwN0dpTG9ibjdkelVhWFV4cjZBa0RRY3kxNVpsM29i?=
 =?utf-8?B?b1dkUmJ6R1g1dllwek4ySmo5WFplNW1NUzFOaVhld25kdmtSaWhjazRPZU4r?=
 =?utf-8?B?S1Y2bHVOUXc3bG4wTmZVNXI1Y1A3UGxUZWplM0psVWp0L0Fkc3RqUU9yckh1?=
 =?utf-8?B?RGR6ODVSeFMvTUhNMUhoQ3V4WCtJd3NFSXNneG41dGtQQkpjTlozL1R6RFRF?=
 =?utf-8?B?R3RWVWVONXg0T3hsWTh4V0p0RGlicm1MdlJwSTgzbitJY1ZmVmQwdWhLbitv?=
 =?utf-8?B?UnE0NEdUN1BWb2o1aXhvZnNqVlU3ZGhwcER5ajZlSTd5clhsaWNQd2JzL0VZ?=
 =?utf-8?B?SGp0Q0FmUkppeHpvVzdmNVA2REJTZFdBRlpNTkErTklPRWdvWTNEWDBESG11?=
 =?utf-8?B?TXk2dTlTWG9QQTRlS2ZIU3hwOURndzY4ZFhqdFRHaFYxRys0ZFMyOUgyNy9y?=
 =?utf-8?B?TE5Hcy9hUXpIVlRQZzRGUFczVnAvNEhSMTZCN2s5eWVuVzZrSTNHdkM0eHlX?=
 =?utf-8?B?THV1Lzl6Y2xUZVZLaXZ3a2wyWnZ5R3FkTkJXb1IwWXlSQnhnY0Z4dDg2QjMr?=
 =?utf-8?B?S2doNzJkTmlvMFczcStUNkxnZElSMk91N1hkQUxpTEJaNjZuWkVWUTVmQW1U?=
 =?utf-8?B?OG90RDZCMEJqZ0RlT211cXlkUVQ3OS8vOTRobjRsWVEzTm5iSU9UY21RQTNW?=
 =?utf-8?B?bFZobUtIMERtNXFpbk03aXFWQmlscVFiTzBSaEpyTWdaWHAvdEoyd3BPS0tM?=
 =?utf-8?B?bTVGbDZaQjBOYnI1bDg2WkN6Z0RESjlocVNYVlNtdHZFL2xUZlZOcC9ENjFR?=
 =?utf-8?Q?Y6mIwP1ywAnnXYEYme5J2x2/v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76b1992-e377-4b5a-60f3-08dc8fe12f94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:54:11.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOblCrtdBY+km20kuVAVa2qD+/ITFqgVTHGhIrXWWFicTnWmsLlJcb+d0Ym5DKWdhIru1Aa08aMbJk7nGNDweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11008

Convert fsl-fman from txt to yaml format and split it fsl,fman.yam,
fsl,fman-port.yaml, fsl-muram.yaml, fsl-mdio.yaml.

Addition changes:
fsl,fman.yaml:
  - Fixed interrupts in example.
  - Fixed ethernet@e8000 miss } in example.
  - ptp-timer add label in example.
  - Ref to new fsl,fman*.yaml.
  - Reorder property in example.
  - Keep only one example.
  - Add const for #address-cells and #size-cells.
  - Use defined interrupt type.
  - ptp example use node name phc.

fsl,fman-port:
  - Keep only one example.

fsl,fman-mdio:
  - Add little-endian property.
  - Add ref to mdio.yaml.
  - Remove suppress-preamble.
  - Add #address-cells and #size-cells in example.
  - Remove clock-frequency, which already describe in mmio.yaml.

fsl,muram.yaml:
  - Add reg property.
  - Remove range property.
  - Use reg instead of range in example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>

---
Change from v1 to v2
- Fix make refcheckdocs warning.
- remove ranges in fsl,muram.yaml and all examples.
- Only keep one example
- Add const for #address-cells and #size-cells.
- Compatible is always the first property. reg follows, third ranges.
- Using define interrupt type
---
 .../devicetree/bindings/net/fsl,fman-mdio.yaml     | 123 +++++
 .../devicetree/bindings/net/fsl,fman-muram.yaml    |  40 ++
 .../devicetree/bindings/net/fsl,fman-port.yaml     |  75 +++
 .../devicetree/bindings/net/fsl,fman.yaml          | 204 ++++++++
 Documentation/devicetree/bindings/net/fsl-fman.txt | 548 ---------------------
 MAINTAINERS                                        |   2 +-
 6 files changed, 443 insertions(+), 549 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,fman-mdio.yaml
new file mode 100644
index 0000000000000..6b2c0aa407a23
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,fman-mdio.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,fman-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Frame Manager MDIO Device
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: FMan MDIO Node.
+  The MDIO is a bus to which the PHY devices are connected.
+
+properties:
+  compatible:
+    enum:
+      - fsl,fman-mdio
+      - fsl,fman-xmdio
+      - fsl,fman-memac-mdio
+    description:
+      Must include "fsl,fman-mdio" for 1 Gb/s MDIO from FMan v2.
+      Must include "fsl,fman-xmdio" for 10 Gb/s MDIO from FMan v2.
+      Must include "fsl,fman-memac-mdio" for 1/10 Gb/s MDIO from
+      FMan v3.
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: A reference to the input clock of the controller
+          from which the MDC frequency is derived.
+
+  interrupts:
+    maxItems: 1
+
+  fsl,fman-internal-mdio:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Fman has internal MDIO for internal PCS(Physical
+      Coding Sublayer) PHYs and external MDIO for external PHYs.
+      The settings and programming routines for internal/external
+      MDIO are different. Must be included for internal MDIO.
+
+  fsl,erratum-a009885:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Indicates the presence of the A009885
+      erratum describing that the contents of MDIO_DATA may
+      become corrupt unless it is read within 16 MDC cycles
+      of MDIO_CFG[BSY] being cleared, when performing an
+      MDIO read operation.
+
+  fsl,erratum-a011043:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates the presence of the A011043 erratum
+      describing that the MDIO_CFG[MDIO_RD_ER] bit may be falsely
+      set when reading internal PCS registers. MDIO reads to
+      internal PCS registers may result in having the
+      MDIO_CFG[MDIO_RD_ER] bit set, even when there is no error and
+      read data (MDIO_DATA[MDIO_DATA]) is correct.
+      Software may get false read error when reading internal
+      PCS registers through MDIO. As a workaround, all internal
+      MDIO accesses should ignore the MDIO_CFG[MDIO_RD_ER] bit.
+
+      For internal PHY device on internal mdio bus, a PHY node should be created.
+      See the definition of the PHY node in booting-without-of.txt for an
+      example of how to define a PHY (Internal PHY has no interrupt line).
+      - For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY.
+      - For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is PCS PHY.
+        The PCS PHY address should correspond to the value of the appropriate
+        MDEV_PORT.
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      IP block is little-endian mode. The default endian mode is big-endian.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: mdio.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio@f1000 {
+        compatible = "fsl,fman-xmdio";
+        reg = <0xf1000 0x1000>;
+        interrupts = <101 2 0 0>;
+    };
+
+  - |
+    mdio@e3120 {
+        compatible = "fsl,fman-mdio";
+        reg = <0xe3120 0xee0>;
+        fsl,fman-internal-mdio;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tbi-phy@8 {
+            reg = <0x8>;
+            device_type = "tbi-phy";
+        };
+    };
+
+  - |
+    mdio@f1000 {
+        compatible = "fsl,fman-memac-mdio";
+        reg = <0xf1000 0x1000>;
+        fsl,fman-internal-mdio;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pcsphy6: ethernet-phy@0 {
+            reg = <0x0>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/net/fsl,fman-muram.yaml b/Documentation/devicetree/bindings/net/fsl,fman-muram.yaml
new file mode 100644
index 0000000000000..aa71acc7fa5b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,fman-muram.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,fman-muram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Frame Manager MURAM Device
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  FMan Internal memory - shared between all the FMan modules.
+  It contains data structures that are common and written to or read by
+  the modules.
+
+  FMan internal memory is split into the following parts:
+    Packet buffering (Tx/Rx FIFOs)
+    Frames internal context
+
+properties:
+  compatible:
+    enum:
+      - fsl,fman-muram
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    muram@0 {
+        compatible = "fsl,fman-muram";
+        reg = <0x0 0x28000>;
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl,fman-port.yaml b/Documentation/devicetree/bindings/net/fsl,fman-port.yaml
new file mode 100644
index 0000000000000..9de445307830d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,fman-port.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,fman-port.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Frame Manager Port Device
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The Frame Manager (FMan) supports several types of hardware ports:
+    Ethernet receiver (RX)
+    Ethernet transmitter (TX)
+    Offline/Host command (O/H)
+
+properties:
+  compatible:
+    enum:
+      - fsl,fman-v2-port-oh
+      - fsl,fman-v2-port-rx
+      - fsl,fman-v2-port-tx
+      - fsl,fman-v3-port-oh
+      - fsl,fman-v3-port-rx
+      - fsl,fman-v3-port-tx
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specifies the hardware port id.
+      Each hardware port on the FMan has its own hardware PortID.
+      Super set of all hardware Port IDs available at FMan Reference
+      Manual under "FMan Hardware Ports in Freescale Devices" table.
+
+      Each hardware port is assigned a 4KB, port-specific page in
+      the FMan hardware port memory region (which is part of the
+      FMan memory map). The first 4 KB in the FMan hardware ports
+      memory region is used for what are called common registers.
+      The subsequent 63 4KB pages are allocated to the hardware
+      ports.
+      The page of a specific port is determined by the cell-index.
+
+  reg:
+    items:
+      - description: There is one reg region describing the port
+          configuration registers.
+
+  fsl,fman-10g-port:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: The default port rate is 1G.
+      If this property exists, the port is s 10G port.
+
+  fsl,fman-best-effort-port:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: The default port rate is 1G.
+      Can be defined only if 10G-support is set.
+      This property marks a best-effort 10G port (10G port that
+      may not be capable of line rate).
+
+required:
+  - compatible
+  - reg
+  - cell-index
+
+additionalProperties: false
+
+examples:
+  - |
+    port@a8000 {
+        compatible = "fsl,fman-v2-port-tx";
+        reg = <0xa8000 0x1000>;
+        cell-index = <0x28>;
+    };
+
diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
new file mode 100644
index 0000000000000..7908f67413dea
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,fman.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Frame Manager Device
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  Due to the fact that the FMan is an aggregation of sub-engines (ports, MACs,
+  etc.) the FMan node will have child nodes for each of them.
+
+properties:
+  compatible:
+    enum:
+      - fsl,fman
+    description:
+      FMan version can be determined via FM_IP_REV_1 register in the
+      FMan block. The offset is 0xc4 from the beginning of the
+      Frame Processing Manager memory map (0xc3000 from the
+      beginning of the FMan node).
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specifies the index of the FMan unit.
+
+      The cell-index value may be used by the SoC, to identify the
+      FMan unit in the SoC memory map. In the table below,
+      there's a description of the cell-index use in each SoC:
+
+      - P1023:
+      register[bit]      FMan unit  cell-index
+      ============================================================
+      DEVDISR[1]      1    0
+
+      - P2041, P3041, P4080 P5020, P5040:
+      register[bit]      FMan unit  cell-index
+      ============================================================
+      DCFG_DEVDISR2[6]    1    0
+      DCFG_DEVDISR2[14]    2    1
+        (Second FM available only in P4080 and P5040)
+
+      - B4860, T1040, T2080, T4240:
+      register[bit]      FMan unit  cell-index
+      ============================================================
+      DCFG_CCSR_DEVDISR2[24]    1    0
+      DCFG_CCSR_DEVDISR2[25]    2    1
+        (Second FM available only in T4240)
+
+      DEVDISR, DCFG_DEVDISR2 and DCFG_CCSR_DEVDISR2 are located in
+      the specific SoC "Device Configuration/Pin Control" Memory
+      Map.
+
+  reg:
+    items:
+      - description: BMI configuration registers.
+      - description: QMI configuration registers.
+      - description: DMA configuration registers.
+      - description: FPM configuration registers.
+      - description: FMan controller configuration registers.
+    minItems: 1
+
+  ranges: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: fmanclk
+
+  interrupts:
+    items:
+      - description: The first element is associated with the event interrupts.
+      - description: the second element is associated with the error interrupts.
+
+  fsl,qman-channel-range:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Specifies the range of the available dedicated
+      channels in the FMan. The first cell specifies the beginning
+      of the range and the second cell specifies the number of
+      channels
+    items:
+      - description: The first cell specifies the beginning of the range.
+      - description: |
+          The second cell specifies the number of channels.
+          Further information available at:
+          "Work Queue (WQ) Channel Assignments in the QMan" section
+          in DPAA Reference Manual.
+
+  fsl,qman:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: See soc/fsl/qman.txt
+
+  fsl,bman:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: See soc/fsl/bman.txt
+
+  fsl,erratum-a050385:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: A boolean property. Indicates the presence of the
+      erratum A050385 which indicates that DMA transactions that are
+      split can result in a FMan lock.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  '^muram@[a-f0-9]+$':
+    $ref: fsl,fman-muram.yaml
+
+  '^port@[a-f0-9]+$':
+    $ref: fsl,fman-port.yaml
+
+  '^ethernet@[a-f0-9]+$':
+    $ref: fsl,fman-dtsec.yaml
+
+  '^mdio@[a-f0-9]+$':
+    $ref: fsl,fman-mdio.yaml
+
+  '^phc@[a-f0-9]+$':
+    $ref: /schemas/ptp/fsl,ptp.yaml
+
+required:
+  - compatible
+  - cell-index
+  - reg
+  - ranges
+  - clocks
+  - clock-names
+  - interrupts
+  - fsl,qman-channel-range
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    fman@400000 {
+        compatible = "fsl,fman";
+        reg = <0x400000 0x100000>;
+        ranges = <0 0x400000 0x100000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        cell-index = <1>;
+        clocks = <&fman_clk>;
+        clock-names = "fmanclk";
+        interrupts = <96 IRQ_TYPE_EDGE_FALLING>,
+                     <16 IRQ_TYPE_EDGE_FALLING>;
+        fsl,qman-channel-range = <0x40 0xc>;
+
+        muram@0 {
+            compatible = "fsl,fman-muram";
+            reg = <0x0 0x28000>;
+        };
+
+        port@81000 {
+            cell-index = <1>;
+            compatible = "fsl,fman-v2-port-oh";
+            reg = <0x81000 0x1000>;
+        };
+
+        fman1_rx_0x8: port@88000 {
+            cell-index = <0x8>;
+            compatible = "fsl,fman-v2-port-rx";
+            reg = <0x88000 0x1000>;
+        };
+
+        fman1_tx_0x28: port@a8000 {
+            cell-index = <0x28>;
+            compatible = "fsl,fman-v2-port-tx";
+            reg = <0xa8000 0x1000>;
+        };
+
+        ethernet@e0000 {
+            compatible = "fsl,fman-dtsec";
+            cell-index = <0>;
+            reg = <0xe0000 0x1000>;
+            ptp-timer = <&ptp_timer>;
+            fsl,fman-ports = <&fman1_rx_0x8 &fman1_tx_0x28>;
+            tbi-handle = <&tbi5>;
+        };
+
+        ptp_timer: phc@fe000 {
+            compatible = "fsl,fman-ptp-timer";
+            reg = <0xfe000 0x1000>;
+            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        };
+
+        mdio@f1000 {
+            compatible = "fsl,fman-xmdio";
+            reg = <0xf1000 0x1000>;
+            interrupts = <101 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl-fman.txt b/Documentation/devicetree/bindings/net/fsl-fman.txt
deleted file mode 100644
index 5e02b4b286f67..0000000000000
--- a/Documentation/devicetree/bindings/net/fsl-fman.txt
+++ /dev/null
@@ -1,548 +0,0 @@
-=============================================================================
-Freescale Frame Manager Device Bindings
-
-CONTENTS
-  - FMan Node
-  - FMan Port Node
-  - FMan MURAM Node
-  - FMan dTSEC/XGEC/mEMAC Node
-  - FMan IEEE 1588 Node
-  - FMan MDIO Node
-  - Example
-
-=============================================================================
-FMan Node
-
-DESCRIPTION
-
-Due to the fact that the FMan is an aggregation of sub-engines (ports, MACs,
-etc.) the FMan node will have child nodes for each of them.
-
-PROPERTIES
-
-- compatible
-		Usage: required
-		Value type: <stringlist>
-		Definition: Must include "fsl,fman"
-		FMan version can be determined via FM_IP_REV_1 register in the
-		FMan block. The offset is 0xc4 from the beginning of the
-		Frame Processing Manager memory map (0xc3000 from the
-		beginning of the FMan node).
-
-- cell-index
-		Usage: required
-		Value type: <u32>
-		Definition: Specifies the index of the FMan unit.
-
-		The cell-index value may be used by the SoC, to identify the
-		FMan unit in the SoC memory map. In the table below,
-		there's a description of the cell-index use in each SoC:
-
-		- P1023:
-		register[bit]			FMan unit	cell-index
-		============================================================
-		DEVDISR[1]			1		0
-
-		- P2041, P3041, P4080 P5020, P5040:
-		register[bit]			FMan unit	cell-index
-		============================================================
-		DCFG_DEVDISR2[6]		1		0
-		DCFG_DEVDISR2[14]		2		1
-			(Second FM available only in P4080 and P5040)
-
-		- B4860, T1040, T2080, T4240:
-		register[bit]			FMan unit	cell-index
-		============================================================
-		DCFG_CCSR_DEVDISR2[24]		1		0
-		DCFG_CCSR_DEVDISR2[25]		2		1
-			(Second FM available only in T4240)
-
-		DEVDISR, DCFG_DEVDISR2 and DCFG_CCSR_DEVDISR2 are located in
-		the specific SoC "Device Configuration/Pin Control" Memory
-		Map.
-
-- reg
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: A standard property. Specifies the offset of the
-		following configuration registers:
-		- BMI configuration registers.
-		- QMI configuration registers.
-		- DMA configuration registers.
-		- FPM configuration registers.
-		- FMan controller configuration registers.
-
-- ranges
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: A standard property.
-
-- clocks
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: phandle for the fman input clock.
-
-- clock-names
-		usage: required
-		Value type: <stringlist>
-		Definition: "fmanclk" for the fman input clock.
-
-- interrupts
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: A pair of IRQs are specified in this property.
-		The first element is associated with the event interrupts and
-		the second element is associated with the error interrupts.
-
-- fsl,qman-channel-range
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: Specifies the range of the available dedicated
-		channels in the FMan. The first cell specifies the beginning
-		of the range and the second cell specifies the number of
-		channels.
-		Further information available at:
-		"Work Queue (WQ) Channel Assignments in the QMan" section
-		in DPAA Reference Manual.
-
-- fsl,qman
-- fsl,bman
-		Usage: required
-		Definition: See soc/fsl/qman.txt and soc/fsl/bman.txt
-
-- fsl,erratum-a050385
-		Usage: optional
-		Value type: boolean
-		Definition: A boolean property. Indicates the presence of the
-		erratum A050385 which indicates that DMA transactions that are
-		split can result in a FMan lock.
-
-=============================================================================
-FMan MURAM Node
-
-DESCRIPTION
-
-FMan Internal memory - shared between all the FMan modules.
-It contains data structures that are common and written to or read by
-the modules.
-FMan internal memory is split into the following parts:
-	Packet buffering (Tx/Rx FIFOs)
-	Frames internal context
-
-PROPERTIES
-
-- compatible
-		Usage: required
-		Value type: <stringlist>
-		Definition: Must include "fsl,fman-muram"
-
-- ranges
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: A standard property.
-		Specifies the multi-user memory offset and the size within
-		the FMan.
-
-EXAMPLE
-
-muram@0 {
-	compatible = "fsl,fman-muram";
-	ranges = <0 0x000000 0x28000>;
-};
-
-=============================================================================
-FMan Port Node
-
-DESCRIPTION
-
-The Frame Manager (FMan) supports several types of hardware ports:
-	Ethernet receiver (RX)
-	Ethernet transmitter (TX)
-	Offline/Host command (O/H)
-
-PROPERTIES
-
-- compatible
-		Usage: required
-		Value type: <stringlist>
-		Definition: A standard property.
-		Must include one of the following:
-			- "fsl,fman-v2-port-oh" for FManV2 OH ports
-			- "fsl,fman-v2-port-rx" for FManV2 RX ports
-			- "fsl,fman-v2-port-tx" for FManV2 TX ports
-			- "fsl,fman-v3-port-oh" for FManV3 OH ports
-			- "fsl,fman-v3-port-rx" for FManV3 RX ports
-			- "fsl,fman-v3-port-tx" for FManV3 TX ports
-
-- cell-index
-		Usage: required
-		Value type: <u32>
-		Definition: Specifies the hardware port id.
-		Each hardware port on the FMan has its own hardware PortID.
-		Super set of all hardware Port IDs available at FMan Reference
-		Manual under "FMan Hardware Ports in Freescale Devices" table.
-
-		Each hardware port is assigned a 4KB, port-specific page in
-		the FMan hardware port memory region (which is part of the
-		FMan memory map). The first 4 KB in the FMan hardware ports
-		memory region is used for what are called common registers.
-		The subsequent 63 4KB pages are allocated to the hardware
-		ports.
-		The page of a specific port is determined by the cell-index.
-
-- reg
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: There is one reg region describing the port
-		configuration registers.
-
-- fsl,fman-10g-port
-		Usage: optional
-		Value type: boolean
-		Definition: The default port rate is 1G.
-		If this property exists, the port is s 10G port.
-
-- fsl,fman-best-effort-port
-		Usage: optional
-		Value type: boolean
-		Definition: Can be defined only if 10G-support is set.
-		This property marks a best-effort 10G port (10G port that
-		may not be capable of line rate).
-
-EXAMPLE
-
-port@a8000 {
-	cell-index = <0x28>;
-	compatible = "fsl,fman-v2-port-tx";
-	reg = <0xa8000 0x1000>;
-};
-
-port@88000 {
-	cell-index = <0x8>;
-	compatible = "fsl,fman-v2-port-rx";
-	reg = <0x88000 0x1000>;
-};
-
-port@81000 {
-	cell-index = <0x1>;
-	compatible = "fsl,fman-v2-port-oh";
-	reg = <0x81000 0x1000>;
-};
-
-=============================================================================
-FMan dTSEC/XGEC/mEMAC Node
-
-Refer to Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
-
-============================================================================
-FMan IEEE 1588 Node
-
-Refer to Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
-
-=============================================================================
-FMan MDIO Node
-
-DESCRIPTION
-
-The MDIO is a bus to which the PHY devices are connected.
-
-PROPERTIES
-
-- compatible
-		Usage: required
-		Value type: <stringlist>
-		Definition: A standard property.
-		Must include "fsl,fman-mdio" for 1 Gb/s MDIO from FMan v2.
-		Must include "fsl,fman-xmdio" for 10 Gb/s MDIO from FMan v2.
-		Must include "fsl,fman-memac-mdio" for 1/10 Gb/s MDIO from
-		FMan v3.
-
-- reg
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: A standard property.
-
-- clocks
-		Usage: optional
-		Value type: <phandle>
-		Definition: A reference to the input clock of the controller
-		from which the MDC frequency is derived.
-
-- clock-frequency
-		Usage: optional
-		Value type: <u32>
-		Definition: Specifies the external MDC frequency, in Hertz, to
-		be used. Requires that the input clock is specified in the
-		"clocks" property. See also: mdio.yaml.
-
-- suppress-preamble
-		Usage: optional
-		Value type: <boolean>
-		Definition: Disable generation of preamble bits. See also:
-		mdio.yaml.
-
-- interrupts
-		Usage: required for external MDIO
-		Value type: <prop-encoded-array>
-		Definition: Event interrupt of external MDIO controller.
-
-- fsl,fman-internal-mdio
-		Usage: required for internal MDIO
-		Value type: boolean
-		Definition: Fman has internal MDIO for internal PCS(Physical
-		Coding Sublayer) PHYs and external MDIO for external PHYs.
-		The settings and programming routines for internal/external
-		MDIO are different. Must be included for internal MDIO.
-
-- fsl,erratum-a009885
-		Usage: optional
-		Value type: <boolean>
-		Definition: Indicates the presence of the A009885
-		erratum describing that the contents of MDIO_DATA may
-		become corrupt unless it is read within 16 MDC cycles
-		of MDIO_CFG[BSY] being cleared, when performing an
-		MDIO read operation.
-
-- fsl,erratum-a011043
-		Usage: optional
-		Value type: <boolean>
-		Definition: Indicates the presence of the A011043 erratum
-		describing that the MDIO_CFG[MDIO_RD_ER] bit may be falsely
-		set when reading internal PCS registers. MDIO reads to
-		internal PCS registers may result in having the
-		MDIO_CFG[MDIO_RD_ER] bit set, even when there is no error and
-		read data (MDIO_DATA[MDIO_DATA]) is correct.
-		Software may get false read error when reading internal
-		PCS registers through MDIO. As a workaround, all internal
-		MDIO accesses should ignore the MDIO_CFG[MDIO_RD_ER] bit.
-
-For internal PHY device on internal mdio bus, a PHY node should be created.
-See the definition of the PHY node in booting-without-of.txt for an
-example of how to define a PHY (Internal PHY has no interrupt line).
-- For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY.
-- For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is PCS PHY.
-  The PCS PHY address should correspond to the value of the appropriate
-  MDEV_PORT.
-
-EXAMPLE
-
-Example for FMan v2 external MDIO:
-
-mdio@f1000 {
-	compatible = "fsl,fman-xmdio";
-	reg = <0xf1000 0x1000>;
-	interrupts = <101 2 0 0>;
-};
-
-Example for FMan v2 internal MDIO:
-
-mdio@e3120 {
-	compatible = "fsl,fman-mdio";
-	reg = <0xe3120 0xee0>;
-	fsl,fman-internal-mdio;
-
-	tbi1: tbi-phy@8 {
-		reg = <0x8>;
-		device_type = "tbi-phy";
-	};
-};
-
-Example for FMan v3 internal MDIO:
-
-mdio@f1000 {
-	compatible = "fsl,fman-memac-mdio";
-	reg = <0xf1000 0x1000>;
-	fsl,fman-internal-mdio;
-
-	pcsphy6: ethernet-phy@0 {
-		reg = <0x0>;
-	};
-};
-
-=============================================================================
-Example
-
-fman@400000 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	cell-index = <1>;
-	compatible = "fsl,fman"
-	ranges = <0 0x400000 0x100000>;
-	reg = <0x400000 0x100000>;
-	clocks = <&fman_clk>;
-	clock-names = "fmanclk";
-	interrupts = <
-		96 2 0 0
-		16 2 1 1>;
-	fsl,qman-channel-range = <0x40 0xc>;
-
-	muram@0 {
-		compatible = "fsl,fman-muram";
-		reg = <0x0 0x28000>;
-	};
-
-	port@81000 {
-		cell-index = <1>;
-		compatible = "fsl,fman-v2-port-oh";
-		reg = <0x81000 0x1000>;
-	};
-
-	port@82000 {
-		cell-index = <2>;
-		compatible = "fsl,fman-v2-port-oh";
-		reg = <0x82000 0x1000>;
-	};
-
-	port@83000 {
-		cell-index = <3>;
-		compatible = "fsl,fman-v2-port-oh";
-		reg = <0x83000 0x1000>;
-	};
-
-	port@84000 {
-		cell-index = <4>;
-		compatible = "fsl,fman-v2-port-oh";
-		reg = <0x84000 0x1000>;
-	};
-
-	port@85000 {
-		cell-index = <5>;
-		compatible = "fsl,fman-v2-port-oh";
-		reg = <0x85000 0x1000>;
-	};
-
-	port@86000 {
-		cell-index = <6>;
-		compatible = "fsl,fman-v2-port-oh";
-		reg = <0x86000 0x1000>;
-	};
-
-	fman1_rx_0x8: port@88000 {
-		cell-index = <0x8>;
-		compatible = "fsl,fman-v2-port-rx";
-		reg = <0x88000 0x1000>;
-	};
-
-	fman1_rx_0x9: port@89000 {
-		cell-index = <0x9>;
-		compatible = "fsl,fman-v2-port-rx";
-		reg = <0x89000 0x1000>;
-	};
-
-	fman1_rx_0xa: port@8a000 {
-		cell-index = <0xa>;
-		compatible = "fsl,fman-v2-port-rx";
-		reg = <0x8a000 0x1000>;
-	};
-
-	fman1_rx_0xb: port@8b000 {
-		cell-index = <0xb>;
-		compatible = "fsl,fman-v2-port-rx";
-		reg = <0x8b000 0x1000>;
-	};
-
-	fman1_rx_0xc: port@8c000 {
-		cell-index = <0xc>;
-		compatible = "fsl,fman-v2-port-rx";
-		reg = <0x8c000 0x1000>;
-	};
-
-	fman1_rx_0x10: port@90000 {
-		cell-index = <0x10>;
-		compatible = "fsl,fman-v2-port-rx";
-		reg = <0x90000 0x1000>;
-	};
-
-	fman1_tx_0x28: port@a8000 {
-		cell-index = <0x28>;
-		compatible = "fsl,fman-v2-port-tx";
-		reg = <0xa8000 0x1000>;
-	};
-
-	fman1_tx_0x29: port@a9000 {
-		cell-index = <0x29>;
-		compatible = "fsl,fman-v2-port-tx";
-		reg = <0xa9000 0x1000>;
-	};
-
-	fman1_tx_0x2a: port@aa000 {
-		cell-index = <0x2a>;
-		compatible = "fsl,fman-v2-port-tx";
-		reg = <0xaa000 0x1000>;
-	};
-
-	fman1_tx_0x2b: port@ab000 {
-		cell-index = <0x2b>;
-		compatible = "fsl,fman-v2-port-tx";
-		reg = <0xab000 0x1000>;
-	};
-
-	fman1_tx_0x2c: port@ac0000 {
-		cell-index = <0x2c>;
-		compatible = "fsl,fman-v2-port-tx";
-		reg = <0xac000 0x1000>;
-	};
-
-	fman1_tx_0x30: port@b0000 {
-		cell-index = <0x30>;
-		compatible = "fsl,fman-v2-port-tx";
-		reg = <0xb0000 0x1000>;
-	};
-
-	ethernet@e0000 {
-		compatible = "fsl,fman-dtsec";
-		cell-index = <0>;
-		reg = <0xe0000 0x1000>;
-		fsl,fman-ports = <&fman1_rx_0x8 &fman1_tx_0x28>;
-		tbi-handle = <&tbi5>;
-	};
-
-	ethernet@e2000 {
-		compatible = "fsl,fman-dtsec";
-		cell-index = <1>;
-		reg = <0xe2000 0x1000>;
-		fsl,fman-ports = <&fman1_rx_0x9 &fman1_tx_0x29>;
-		tbi-handle = <&tbi6>;
-	};
-
-	ethernet@e4000 {
-		compatible = "fsl,fman-dtsec";
-		cell-index = <2>;
-		reg = <0xe4000 0x1000>;
-		fsl,fman-ports = <&fman1_rx_0xa &fman1_tx_0x2a>;
-		tbi-handle = <&tbi7>;
-	};
-
-	ethernet@e6000 {
-		compatible = "fsl,fman-dtsec";
-		cell-index = <3>;
-		reg = <0xe6000 0x1000>;
-		fsl,fman-ports = <&fman1_rx_0xb &fman1_tx_0x2b>;
-		tbi-handle = <&tbi8>;
-	};
-
-	ethernet@e8000 {
-		compatible = "fsl,fman-dtsec";
-		cell-index = <4>;
-		reg = <0xf0000 0x1000>;
-		fsl,fman-ports = <&fman1_rx_0xc &fman1_tx_0x2c>;
-		tbi-handle = <&tbi9>;
-
-	ethernet@f0000 {
-		cell-index = <8>;
-		compatible = "fsl,fman-xgec";
-		reg = <0xf0000 0x1000>;
-		fsl,fman-ports = <&fman1_rx_0x10 &fman1_tx_0x30>;
-	};
-
-	ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
-
-	mdio@f1000 {
-		compatible = "fsl,fman-xmdio";
-		reg = <0xf1000 0x1000>;
-		interrupts = <101 2 0 0>;
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 322e89b13c843..7204a81b86930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8862,7 +8862,7 @@ M:	Madalin Bucur <madalin.bucur@nxp.com>
 R:	Sean Anderson <sean.anderson@seco.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/fsl-fman.txt
+F:	Documentation/devicetree/bindings/net/fsl-fman.yaml
 F:	drivers/net/ethernet/freescale/fman
 
 FREESCALE QORIQ PTP CLOCK DRIVER

-- 
2.34.1


