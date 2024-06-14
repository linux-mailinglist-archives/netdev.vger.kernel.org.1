Return-Path: <netdev+bounces-103730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9117790937E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDA0288AF8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40C1ABCD9;
	Fri, 14 Jun 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jm+USOXb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2080.outbound.protection.outlook.com [40.107.249.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC561ABCBE;
	Fri, 14 Jun 2024 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718397247; cv=fail; b=P2d1imOj8SgMplzu2Fyerjsu4ZJ5vftXRpS+fptQxhe11Hime7nc5Odsai97tkA1UeRyhEMRoAcrCQUTPkBEd03Kt9hp1v8MUSC7275pLNt+SQ69gwJDA9GS+6phDUdKyOJhaWc274D071t4SJRW10sDoPQ7Dd88kEIatqv9y6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718397247; c=relaxed/simple;
	bh=PYixBxTg8e/FLGAuUo00iiStzHXBVdtj7NLq+ndjjzs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SrUZNb/T2ubnpzcECuHXESfGZ9fsAq0Rj/TyhQK7u9Hf38XhG3dmomz3KFWAhtJdac7Y6jFogvE1vN4tFXVBwDXsVe6Um7DXv7hiZmvvjRYx2cVaq1adTQePcxMAaAmC87Uo/CjgWhvIPryo+/hNzYLJ1f2U2RNO8l6K0cQGWLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jm+USOXb; arc=fail smtp.client-ip=40.107.249.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW8xZ/7WXCgEjNXbdTQRK+VTek6j18R7RxyztgF8onPC6RHKfwezCzAqBoi99xTs8FjhQzkw77XTIQv5T9/SmJBIEOT8W6c989qsDFarFz4IBVakXW1xF73FEypcJrVrbyouy5DOJYG2cUQp0aFuuKlqGyW3Leue7Ur8aeNrfjQnjJFDuSaAljcB3THjmxygOzJlMhGTRou3SygZelaksWo9NS8rOgM1ASNS+l41D9YnxyzH9FEQ5hUBedcqc7d60itz/HwWIhuczrgbRgHn1/GshxmwnnHvopSU2+9mMWJTC0gtgO0/twOt3eel9a72lRJW4R88h54/Qif3Bo/OSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd2ZIo9d/STbx95ZAO66aJEpqZ5DhXuiNjVDs8jEqN4=;
 b=IlH287bN3LN8/O81bq5avTAhbMVOV6w3tGdGUtIhlTTEQ/qDAUHfuRlAblZKXSkOziJ++jSsCB+6T/RHCjB9IXBuKP4UOscUWVQS0knkRZai+RR2ZOR8MHl5gn9eswO9EZx6nm/eJhOzxTypTcjVlmYozb7w4po0kJJI7Dkw0Ntefek/cb5J87CYooEZB9SwhpIcK9Y3hc9BHnCZYX54kCq6GRtJEbCbAKoxhZcYe89KX4QlvhSQVjNvDTRakPCB7JNwhnb570NrTaSD+FSqr3Ktk5LawOtkHZJLEKqgDvwsPxSzEoYMNfcvxFNyYpyXBxBQeVC4tcVAIjQJsPOlnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd2ZIo9d/STbx95ZAO66aJEpqZ5DhXuiNjVDs8jEqN4=;
 b=jm+USOXbneEAI1kbf0bPr6jXiXFJ8/7f3XYpPOnQSmuLNZcKEipJkVeVCpPcd8Z3aarOmzJcf86SUa4ggg6wAITNbOBUAyjAJR5husHzjmVHmk+px0UkNY8TENG9NeYRiWL5usFjDDaYa/1LtelIsne+NT6/1AdELfWwZkbqZ1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10203.eurprd04.prod.outlook.com (2603:10a6:150:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 20:34:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 20:34:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 16:33:29 -0400
Subject: [PATCH 2/2] dt-bindings: net: Convert fsl-fman to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-ls_fman-v1-2-cb33c96dc799@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718397228; l=35183;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PYixBxTg8e/FLGAuUo00iiStzHXBVdtj7NLq+ndjjzs=;
 b=vvcXf7ztvT1/pEaN5S983OMbMpn8dKjPVLrZhj+N4vlUkG4Vhio2Q7403BhfTXNR7kg2+gk1h
 V9XQ/hE/XEQCYsdPQDLSWkM5qSEiooWaean3emA0fCUmkRtolT95Ujp
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
X-MS-Office365-Filtering-Correlation-Id: f4682770-1e70-4b5b-24e9-08dc8cb152f8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|366013|52116011|376011|7416011|1800799021|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z2pJcmNGaTAvc09uRHp0QUg0MTYraHBRa1dIQ2t2RFpTUmZsUTcrWkpLQUNs?=
 =?utf-8?B?MHRER0U5Wm53UGpYdXR6d3RiWSttU0NqUHhFRkxRYlc4RWJ2d3FnWTJlaG84?=
 =?utf-8?B?bnRFUHI3NHZpYVJkNERQZkVwOTN0c0tELzFDaVlmdkFtZDZGejdRZFh5UWla?=
 =?utf-8?B?RDlQZWIydFAwN3RvYjE5NW01NlFLZkF5NldKdk50Ny91SkJXblAzUnUvMWxW?=
 =?utf-8?B?U3F0Z0hFRlpyVnhNWVphWnRITy81bGUvTDNNREtmeWo2aGZFbW9ybGpCcDJ5?=
 =?utf-8?B?U3FWT1BkTHhreU5aaCs3K21pZk42UVJWNjhvOC9GRGJWWkdRRjhwaEJtVDll?=
 =?utf-8?B?amRCa1FoMWk2dVdEU1U5RlVWejdQMC9MWWRabzBxcDZDelJ6cWQzeGpCZ2pw?=
 =?utf-8?B?eHpDNXoyYzBqSkpiNWVLNVFQWlJKVVhaSFRPV05oRkJWOGFEYy9WTnBjd3Zk?=
 =?utf-8?B?UUxjRFV6ME1zUE9EMldKREZFSlRmdVFDTHpseDdRVWdScXNYMmw2bm04OEFG?=
 =?utf-8?B?OC9GcWNIVHk2R3lZSHNsNGRRMTB1MmNjQkdqUUpDeXVFU2ZLNko0TWVvRllv?=
 =?utf-8?B?c1hxRko5Mm9MOEpsay9LYmlMMGhzcDlySkZrMnU2dTFkc0N5UDlVaW5qRGdU?=
 =?utf-8?B?Uml3bFRCM3dheTFOU2F3WUFBYkMreTlRWjFZd1daNjdGVWVGNmtzaksxNWgy?=
 =?utf-8?B?M2hQMWRwaGlpZ3lrSElhTUZIKzlpOW42czlHQ00wWlZJYU8zUXU3VWVtSDk1?=
 =?utf-8?B?QjVIWDBtdzBZOEZDR3BQQWMwYlhnTVFhQ3huWVY2M2t1b1hMemtlbzBVVldX?=
 =?utf-8?B?cVJVYlBYWmpvL2ZpTkNNRWkya2RPb1VMRDFDeVpCTnN5MmMxZzI4UktxL3Y5?=
 =?utf-8?B?NXROampCZElPSEMxOGxTUGRLYkd1UlV1TXRtZHhVT212eHA4VC9Cd21vNnNm?=
 =?utf-8?B?Wi9OKytlejVJRVhVM2cvaDlMZHU3ZW41N2pDMDdQYmlHY285dHlDblhJU01n?=
 =?utf-8?B?UVdLc3ZxWDZJLzhVdVlPcUtOd3RBRXBMOEM5elJzcDRSbEdKTXBDS0ZxWnN3?=
 =?utf-8?B?b2xrTjY4UlQ5Q3lWdlFCNVJHMWZtZkJ6b3ZTajdGeEN6SHZZWVVGVFpJK2tx?=
 =?utf-8?B?citzMEdRWVBiQWpUL2lRU1VsK0JxdUN2bUxMc0tQWWZ1UmF4eHAxSWI5L2FL?=
 =?utf-8?B?WkhNVENTMTZTblZqdnNpMm04Mys2SFN4VWdCdDdIdVRJZkxDZ2x1NkUwVGpo?=
 =?utf-8?B?bGlJZ0d4SlVZUlRaYWl5VC95RVBjdm1lR2xHSlBwU2U3bUpVRVZxWUFFeXd3?=
 =?utf-8?B?MWd0SWsyTUZ3ZnZxUlZqQTRVdzUrRk9vLzA5SncvMWkvc0g4NUNuMHdxSWxW?=
 =?utf-8?B?UTBVWTR4aWNNVjV5MWhHWnFqQThQSUVYbkx6czkra0xEKytZQURRSjQvVnZl?=
 =?utf-8?B?UHBaY1N3VlcrVXQ2UkNhNlEzOGlPaWhSYkgyNUxtTmdRL3d4ZVBsV1BNUFRv?=
 =?utf-8?B?eWtQWkk0RXhtUDRrdjZxdVMzMjVKYVRHMkpoRFVNdkhjL3J5UkRIR2M0TUlu?=
 =?utf-8?B?d2I2Rk1yek1FQTBRdU9XSmdpOXVDaDdzd2xCdWxCNVpuSXZTcUI3OVQwaFRo?=
 =?utf-8?B?dGgzTjhaUUhuU25LS3NxWitHbzhTS2FkL2dyTVlaOWN1ZGRrSStOZWtRdzlP?=
 =?utf-8?B?N0wwdTk4RnVUbytMQjFxRWpneUxvUHlIdUpsOGhZWE9JTFVScWZ3dHRsWi9X?=
 =?utf-8?B?Zkd5K1dkQXRGVWZUbW1sUEo3Q1NtU2FoQkFtVGgyWVl1ZVFCRHR4RDROalZ2?=
 =?utf-8?B?UVdHWVFjcm9Bb0x2UlduZz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(7416011)(1800799021)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T2lsRm5WT2Ixd3YvbTVIMUF1MlZVMDR0Z0xNaThYWldmR0FndG52a2h2NjdR?=
 =?utf-8?B?QXBzdGRiN1kvMzJnSjZLOFFFemFHdFRHYTVpZnpEaTNnWkw4VUsyTkdTUVVl?=
 =?utf-8?B?QWlGWis0YThYS1JRSG13aG5wR3E2bmlQVVpBZmo4WE5LanlLK2xyOEdUUjZR?=
 =?utf-8?B?ZWFBUUpCYlBCK2tlWk0rMVpDeGh0V2RZK0JVYlNvb1lhNi84SjdLb2VyUWNX?=
 =?utf-8?B?UjJzUzdoNlFlNitWV1dGWVdWcldtL0lKaFNpdU5zQVNuN0wrK3pIOWdGRGc3?=
 =?utf-8?B?SGo0MUFKY2toNVRFQnhSNFdTMnVOaGhSaDVtVUdJeWV5VEtidFJyWTI4UHph?=
 =?utf-8?B?eGRIclVlZkdzbmZUUzZHYjV6bjA2MTRzV2h1ZDdTYVlmRURTeHNpN0grY293?=
 =?utf-8?B?bmxMZW44aVRiV1NwR0d6SW5sWDcrbzBsbXp5dFJESk5ocmJDVnRSajZNOVZE?=
 =?utf-8?B?Q1dxMEU3OXpIK3M3R3B5Nld0ZGdQUTVmMktTMXJwTXJYZnpYM1NQbmxQOFc4?=
 =?utf-8?B?NnkvOUNHdU9kOVhXTjRKSWw4UXZRTHpwR1NrNzQ5TEFJazdZZWRXdTRjM3Zq?=
 =?utf-8?B?TUdud0NwVDBXMXp5bTBJaHJoeVlXUjhSeXU0NlZxNlhmTmgzQ1pGMHlxMHlW?=
 =?utf-8?B?MmZ6d2pJUWlaSUlDWW95UzNoeE91SUowWVNRditpbkN2NFgwZnBUK1hqcXNX?=
 =?utf-8?B?TEVNUFp6Qmw2bHJ6TERzcDdMeFE1UWlsdlpxeVQrcnh2VGZ4b2VLSGMwRHVW?=
 =?utf-8?B?aDQvRktLTzB6NHptK3FReFpuZTZyc3RXQ3UyQytXWlFsMmVkTzZxaTBFRFQ0?=
 =?utf-8?B?REprMUdjOFZsSXZxQlY4YjliZVdQaEpYNHZ6SmlUV0Y3Y3NHbGlaR2JKM1Rq?=
 =?utf-8?B?WG9EME53aDVMMGFjUWt2QURaL0tkd3M3aTE5SDdwWXJUWFhBRjI0ZXpCVHdj?=
 =?utf-8?B?NnhLMDlzT0dJQ0d0THp3anZhTXdWby9Sd0VYVWMrN1VIMVRyUUZhVlB4SzJK?=
 =?utf-8?B?bFQzUXJ6LzM1VnlOa0pEM09URzMyVm4vSWpoZkNoTGFCNzFWTXVNY1I4ZmhG?=
 =?utf-8?B?OTZjdjM3Zmc3cTVjT1I5dWROeGRnQTYybGRuNzhJb3pNelM3LzY0Q2d1aHVD?=
 =?utf-8?B?TTF1bGdOVDRGOWJPYmFQdlFPZnMrSWNXcWRhQTUwd0Y2Z0ZTSW5EUC9nOWFo?=
 =?utf-8?B?bUtFZnhtdzBadnFRN01SZTBRZG1JeDZiTEhxQkU0dDkwQWFmVERRN01QV3R4?=
 =?utf-8?B?d3daNmZ1ZUI0eWZUc0NzclBmSDlRMUszUGpMK1pWUzRkcnprd25EZyswaEpO?=
 =?utf-8?B?TTYrSDdMcW84TzVheW1ybGlTSDhqMmZqczl5MFAzUEhrSmpPNDVzaTdxZzdZ?=
 =?utf-8?B?LzhDQlJ3aFV1V1g1M1BjT2cxNnNiejJYWnZWL1poWno0a0U4UnZiV2pCNVVS?=
 =?utf-8?B?SU1Ib1BiYXJ5cW9RZ3RMOUJCSHJuR2JpejZkOUswZkRtUi9ZRmMxMUdDZGtL?=
 =?utf-8?B?SkVVbUxVY201OUVNU25OVFJ6QjdyaXlzdjF2QVMrZ2RNZGsvcE40M3MzSE1H?=
 =?utf-8?B?MTRGRmYwVmVmNmd0RHluMmE5ajlPN00rU0RRYU8zbjdyVmk4NExyZUVCbTJi?=
 =?utf-8?B?WHlxQTUvNy9rZHVJd1BJOFdsZU1jZUd0NmhUNE0yY05qTndCWXRtYjQ0NVll?=
 =?utf-8?B?b0ZjY0U5UURFSVZDdHFxTFFXWGxYNkZRZHVOVHNhUUh1WS9HTThMMjVnM3VD?=
 =?utf-8?B?ZHdDeExHMmxwNmZuRTVWenZMVktheFM1bkFjbUpXYVBDZ2Zuem5kOVQrM1Ny?=
 =?utf-8?B?T1l6NTJUMFZFdUxQNGtTckFKaEkrNGV0SzFEbHJFcmpJc2NCRGZ4UU9BeHNW?=
 =?utf-8?B?SWZZbzlFZ0ROdU9PdnlJVEhLazRDOUtUMTVISC9wVExZNTlHSGExanlaVXZY?=
 =?utf-8?B?T2N6NG5UcUlES21KbHk3N2FxUUluMGJiNkJHc0oweTY1YkpYeFkvbUJLYU5v?=
 =?utf-8?B?d3plaHRzUitrV0tmRHEvY1oycEpxQ2ZPVldLSE1LNWRyanNyNnNPTkpDSklM?=
 =?utf-8?B?RjRBUmtaRmtGNVk2YUNZZ1hLOWdrQTFKUVkwSFRQaDVUUEFEWmlacGZMd0c4?=
 =?utf-8?Q?RnmwSAqVL6fMRywW+dcoO+GjE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4682770-1e70-4b5b-24e9-08dc8cb152f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 20:34:00.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSmTbeckjpIr/xgBJbYaQtUK9MWvsJfFjBzzb6BbW9ztcYQG9jKW5+/P8gQs1ueMicR96WbvL3EPLJ1Y4igtjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10203

Convert fsl-fman from txt to yaml format and split it fsl,fman.yam,
fsl,fman-port.yaml, fsl-muram.yaml, fsl-mdio.yaml.

Addition changes:
fsl,fman.yaml:
  - Fixed interrupts in example
  - Fixed ethernet@e8000 miss } in example
  - ptp-timer add label in example
  - Ref to new fsl,fman*.yaml
  - Reorder property in example

fsl,fman-mdio:
  - Add little-endian property
  - Add ref to mdio.yaml
  - Remove suppress-preamble
  - Add #address-cells and #size-cells in example

fsl-muram.yaml:
  - Add reg property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/net/fsl,fman-mdio.yaml     | 130 +++++
 .../devicetree/bindings/net/fsl,fman-muram.yaml    |  42 ++
 .../devicetree/bindings/net/fsl,fman-port.yaml     |  86 ++++
 .../devicetree/bindings/net/fsl,fman.yaml          | 335 +++++++++++++
 Documentation/devicetree/bindings/net/fsl-fman.txt | 548 ---------------------
 5 files changed, 593 insertions(+), 548 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,fman-mdio.yaml
new file mode 100644
index 0000000000000..e056b270733a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,fman-mdio.yaml
@@ -0,0 +1,130 @@
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
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specifies the external MDC frequency, in Hertz, to
+      be used. Requires that the input clock is specified in the
+      "clocks" property. See also: mdio.yaml.
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
index 0000000000000..035b949b316c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,fman-muram.yaml
@@ -0,0 +1,42 @@
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
+  ranges: true
+
+required:
+  - compatible
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    muram@0 {
+        compatible = "fsl,fman-muram";
+        ranges = <0 0x000000 0x0 0x28000>;
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl,fman-port.yaml b/Documentation/devicetree/bindings/net/fsl,fman-port.yaml
new file mode 100644
index 0000000000000..7e69cf02bd024
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,fman-port.yaml
@@ -0,0 +1,86 @@
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
+    port@88000 {
+        cell-index = <0x8>;
+        compatible = "fsl,fman-v2-port-rx";
+        reg = <0x88000 0x1000>;
+    };
+
+    port@81000 {
+        cell-index = <0x1>;
+        compatible = "fsl,fman-v2-port-oh";
+        reg = <0x81000 0x1000>;
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
new file mode 100644
index 0000000000000..dfd403f9a7c9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
@@ -0,0 +1,335 @@
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
+  "#address-cells": true
+
+  "#size-cells": true
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
+  '^ptp\-timer@[a-f0-9]+$':
+    $ref: /schemas/ptp/ptp-qoriq.yaml
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
+    fman@400000 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        cell-index = <1>;
+        compatible = "fsl,fman";
+        ranges = <0 0x400000 0x100000>;
+        reg = <0x400000 0x100000>;
+        clocks = <&fman_clk>;
+        clock-names = "fmanclk";
+        interrupts = <96 2>,
+                     <16 2>;
+        fsl,qman-channel-range = <0x40 0xc>;
+
+        muram@0 {
+            compatible = "fsl,fman-muram";
+            reg = <0x0 0x28000>;
+            ranges = <0x0 0x0 0x1000 0x1000>;
+        };
+
+        port@81000 {
+            cell-index = <1>;
+            compatible = "fsl,fman-v2-port-oh";
+            reg = <0x81000 0x1000>;
+        };
+
+        port@82000 {
+            cell-index = <2>;
+            compatible = "fsl,fman-v2-port-oh";
+            reg = <0x82000 0x1000>;
+        };
+
+        port@83000 {
+            cell-index = <3>;
+            compatible = "fsl,fman-v2-port-oh";
+            reg = <0x83000 0x1000>;
+        };
+
+        port@84000 {
+            cell-index = <4>;
+            compatible = "fsl,fman-v2-port-oh";
+            reg = <0x84000 0x1000>;
+        };
+
+        port@85000 {
+            cell-index = <5>;
+            compatible = "fsl,fman-v2-port-oh";
+            reg = <0x85000 0x1000>;
+        };
+
+        port@86000 {
+            cell-index = <6>;
+            compatible = "fsl,fman-v2-port-oh";
+            reg = <0x86000 0x1000>;
+        };
+
+        fman1_rx_0x8: port@88000 {
+            cell-index = <0x8>;
+            compatible = "fsl,fman-v2-port-rx";
+            reg = <0x88000 0x1000>;
+        };
+
+        fman1_rx_0x9: port@89000 {
+            cell-index = <0x9>;
+            compatible = "fsl,fman-v2-port-rx";
+            reg = <0x89000 0x1000>;
+        };
+
+        fman1_rx_0xa: port@8a000 {
+            cell-index = <0xa>;
+            compatible = "fsl,fman-v2-port-rx";
+            reg = <0x8a000 0x1000>;
+        };
+
+        fman1_rx_0xb: port@8b000 {
+            cell-index = <0xb>;
+            compatible = "fsl,fman-v2-port-rx";
+            reg = <0x8b000 0x1000>;
+        };
+
+        fman1_rx_0xc: port@8c000 {
+            cell-index = <0xc>;
+            compatible = "fsl,fman-v2-port-rx";
+            reg = <0x8c000 0x1000>;
+        };
+
+        fman1_rx_0x10: port@90000 {
+            cell-index = <0x10>;
+            compatible = "fsl,fman-v2-port-rx";
+            reg = <0x90000 0x1000>;
+        };
+
+        fman1_tx_0x28: port@a8000 {
+            cell-index = <0x28>;
+            compatible = "fsl,fman-v2-port-tx";
+            reg = <0xa8000 0x1000>;
+        };
+
+        fman1_tx_0x29: port@a9000 {
+            cell-index = <0x29>;
+            compatible = "fsl,fman-v2-port-tx";
+            reg = <0xa9000 0x1000>;
+        };
+
+        fman1_tx_0x2a: port@aa000 {
+            cell-index = <0x2a>;
+            compatible = "fsl,fman-v2-port-tx";
+            reg = <0xaa000 0x1000>;
+        };
+
+        fman1_tx_0x2b: port@ab000 {
+            cell-index = <0x2b>;
+            compatible = "fsl,fman-v2-port-tx";
+            reg = <0xab000 0x1000>;
+        };
+
+        fman1_tx_0x2c: port@ac0000 {
+            cell-index = <0x2c>;
+            compatible = "fsl,fman-v2-port-tx";
+            reg = <0xac000 0x1000>;
+        };
+
+        fman1_tx_0x30: port@b0000 {
+            cell-index = <0x30>;
+            compatible = "fsl,fman-v2-port-tx";
+            reg = <0xb0000 0x1000>;
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
+        ethernet@e2000 {
+            compatible = "fsl,fman-dtsec";
+            reg = <0xe2000 0x1000>;
+            cell-index = <1>;
+            ptp-timer = <&ptp_timer>;
+            fsl,fman-ports = <&fman1_rx_0x9 &fman1_tx_0x29>;
+            tbi-handle = <&tbi6>;
+        };
+
+        ethernet@e4000 {
+            compatible = "fsl,fman-dtsec";
+            reg = <0xe4000 0x1000>;
+            cell-index = <2>;
+            ptp-timer = <&ptp_timer>;
+            fsl,fman-ports = <&fman1_rx_0xa &fman1_tx_0x2a>;
+            tbi-handle = <&tbi7>;
+        };
+
+        ethernet@e6000 {
+            compatible = "fsl,fman-dtsec";
+            reg = <0xe6000 0x1000>;
+            cell-index = <3>;
+            ptp-timer = <&ptp_timer>;
+            fsl,fman-ports = <&fman1_rx_0xb &fman1_tx_0x2b>;
+            tbi-handle = <&tbi8>;
+        };
+
+        ethernet@e8000 {
+            compatible = "fsl,fman-dtsec";
+            reg = <0xf0000 0x1000>;
+            cell-index = <4>;
+            ptp-timer = <&ptp_timer>;
+            fsl,fman-ports = <&fman1_rx_0xc &fman1_tx_0x2c>;
+            tbi-handle = <&tbi9>;
+        };
+
+        ethernet@f0000 {
+            compatible = "fsl,fman-xgec";
+            reg = <0xf0000 0x1000>;
+            ptp-timer = <&ptp_timer>;
+            cell-index = <8>;
+            fsl,fman-ports = <&fman1_rx_0x10 &fman1_tx_0x30>;
+        };
+
+        ptp_timer: ptp-timer@fe000 {
+            compatible = "fsl,fman-ptp-timer";
+            reg = <0xfe000 0x1000>;
+            interrupts = <12 0x8>, <13 0x8>;
+        };
+
+        mdio@f1000 {
+            compatible = "fsl,fman-xmdio";
+            reg = <0xf1000 0x1000>;
+            interrupts = <101 2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl-fman.txt b/Documentation/devicetree/bindings/net/fsl-fman.txt
deleted file mode 100644
index bda4b41af0748..0000000000000
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
-Refer to Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
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

-- 
2.34.1


