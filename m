Return-Path: <netdev+bounces-103728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE5909372
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5877A2888CF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17A1A38DD;
	Fri, 14 Jun 2024 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IW7pMZLm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4618410D;
	Fri, 14 Jun 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718397239; cv=fail; b=DadW077u+QT1yg/u6et1jUMtQ6NAPwm6FrTBKafLaRShdwdRmnizwvHHkQWs2U7W1zA8w8pxOY0bS/h1cD2cPH+8uaCct/Hf3yaNOTcNaMhLIFi0nEYNWKoWyfS40orqqzQc4dnV0hIMNLZVfNlcilXn9jOXotRx8PXGDPwe1yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718397239; c=relaxed/simple;
	bh=8nDTcNcR4+75wd5pIcMpZrurG6WlnHMDAX5by4YIlDE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=P97tzvEvqMtbY62JemBUsFrZHlaPa+PD3f/HiimO6UXUHnhi4i5wfnCyl1PVSDuiiVjDz5lPga6kLQZPw0EmaANL7SwFub1FkWUf2DCMAFZ5yRmOMtwz1SbXc2yFypZn2nqdlrJb2g/3kUlhF8ldQLK5GFsAlLf5ee2Bn+ZUTAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IW7pMZLm; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtKj7w7NoaR0gJkwV5oHATxnpWvyYyYjy5lAzkJ+xPIO9Nax9kWdZXXrnGmwUmyjPK6GHwJKttioLlQ2gTzKRpJ3voGhuqhuzzuFtef3Gk1WNamZ5toB4NuTFiB1oBoSfP1B85tuAToLVMcs5aAooBn5HvMzTdwAYS33CNr/21rrkU77jhOydWZF0Kq381mhkJsmDPRtNnsUJA1VlX4h8M22ykXLpGCiYYr/C+tNUq9FVFZkD5iTsizq1SKewXZ2A+Z6szo3hM0E1wvxLs2SezLpgkAwrKp5KSpX+S80Tu7iubBNR0B92w+EmypEU7KYOn8DjEIJ4w1KPTL37e9D7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhvB16d8BTl0cbi2x7vjUV7k3ZSdbMrZVw36Lc/ZKMA=;
 b=Kc/L0PaIH/YUPrN7uLZZJ+RlniO5MefFu0kwwAbwBv7sKXATF4Z/8EA/xjrySK99wpAGV+iIY4Bz/e7rNb5NU/C1NNn6DHDuaquciaJR/pN21+eFiXL0kaiRshl1GWIWqfx7TnZKCvxKNbDKR07UYclWwga5SZC1Uwn3CNxR+37H2tg6Yow34fc2KAOnrm+mbhBCgU/FpMbxYb1W5pZ595saGiNpnGqiVQxOvHyuQ5gzfSl06VHz6QvmLsdNT6nt1OQN7g1v46jQ0bD9CaFbmfxzM5oOzkczWsDfJGq6S2Wos0QPA8wQpI8mKSa4wH2yOt5WLH5w7s7xyZSvPCkm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhvB16d8BTl0cbi2x7vjUV7k3ZSdbMrZVw36Lc/ZKMA=;
 b=IW7pMZLmHKrzyuoEKT7w6OZ6dEAVWASlRUDk6YVcdugoZLh9bNnNcXVeR5gvHDRV2eShX8eiyVWL8aZZ3enpTEqvbBDJjFv6HCYmdbHlaeyS/NNH92zktAD7zsSc1aKmXZAyu/FYiExUu5AerSlGtQDM3lxSScj7F6uNerWG8Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10203.eurprd04.prod.outlook.com (2603:10a6:150:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 20:33:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 20:33:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] dt-bindings: net: Convert fsl,fman related file to
 yaml format
Date: Fri, 14 Jun 2024 16:33:27 -0400
Message-Id: <20240614-ls_fman-v1-0-cb33c96dc799@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABepbGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MT3Zzi+LTcxDzdVINEcwPT5JTkNCNLJaDqgqLUtMwKsEnRsbW1ACN
 zp49ZAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718397228; l=3175;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8nDTcNcR4+75wd5pIcMpZrurG6WlnHMDAX5by4YIlDE=;
 b=fun/qCNqFTgZpztOEqkZ3CqTruSdsbJHE0GBTQkEzL2I+tJlM6+Pwq41muM90gR7KQkMkqMwf
 SljS/FxNyGAAMnNpK8jHTDhipZ7TRgpiwX5DpFUohxbSn2hcTrgWqoe
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
X-MS-Office365-Filtering-Correlation-Id: b75b6d3c-e245-4991-fcca-08dc8cb14e1c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|366013|52116011|376011|7416011|1800799021|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RzlyZ0hJNUNFVVNSemxuTndsZUFTd0NWb2FzOHRKbC9Wd29nS2ZNNlUrSC9N?=
 =?utf-8?B?dXlobVdXQmg0aWdKVUVlaDZhWlVnWlJsbVhGZWZlSHp2R0puRjU3cXdGTzhI?=
 =?utf-8?B?OEpQVFJSZkd3elN1RzlnM0c1Y20wZkhFSVhBbFp1dzFnN2NVK2Q5elg3MlRo?=
 =?utf-8?B?WVpaT3JDek5UZVFNTStFR2pjYitJTkNKa0Q5WWk4Sng5cVRCN2o4T0pOV3Iz?=
 =?utf-8?B?SDFaZGtKalY1bDBnQVhsbXNHWUd5L1Foelc4TTVSbDJMbWhFb1hBTlF5ZlhZ?=
 =?utf-8?B?M2NWU2wxYTFyWE9rS3k2cnJGVnBlMVFmYzkwR0pvVHUvdmtBSk5UUCtkQ1gz?=
 =?utf-8?B?OGxrbnhYY0RjMlAvMG9kSEU3K3RHSnU5QnAwdmJETGVoRDZvN2dtZEVHOG9n?=
 =?utf-8?B?M0Y4d3lTdldGZjRRLzcvT0laWWppL1NuMW1PNC9KRlZzRUZNVmg4NGZwLzFK?=
 =?utf-8?B?NDNyNjhiNmN4OS9kNUZnRlJnOWxQM2NDVHBtZHNkSEMvSFBNWXZVT1FBS1Na?=
 =?utf-8?B?ako2VXd2SHIwZGlRdVVQOHJ0TERLa0RkbVllY0ozcHFkTU9XZzU0bnI0T2pn?=
 =?utf-8?B?OWFTdWZvT1RRQ1o5SzliWFUwUGo3QnhRYzNrQzdiK1VaQlFmK2UvZ1Q5L3lM?=
 =?utf-8?B?RDBSUWl6c2xtMHhjUlpzWTNGMDlDUFZ6UThOWmh6NEMxNUVRRnRUK2dVc2FQ?=
 =?utf-8?B?ZTVabXdFVG5Tbm9UdlZXYVEzZnRyNXh5ZGNRWUR5QVJrMSt3QXJLSlNIaFk1?=
 =?utf-8?B?aVhMcEMvaldMeXZmK2I4VU92Vy8xTU9BbUcvRTN0OU9kWFE2bEJkUkljRnRs?=
 =?utf-8?B?dUdCV0EyeGFZTkRYQkNETnBvKy91dGZBL0FCeE1jSXZLSHJ6Uk9KZFlzT3ll?=
 =?utf-8?B?YTZiTStsUlp2UVFxVWI2OVlGMHg2bFV1OURUM0NyTjhidVpNbm1IakVQamVH?=
 =?utf-8?B?TGNUZmV0R2NkSktBTW8wVFBJZHZmTW1XZWpaRkk5akVsdkxJU1JvSEMwN0d5?=
 =?utf-8?B?Q3czL3JadDhLd3BYcXNwSzA1OE96eDlPZmwxTWEzNXFwS25MRVFwNThsTCtL?=
 =?utf-8?B?YlVQZkVmMlp0MGFqQTlkQTdNNHkyMzFmNlVCYmZWbjNuL2ttcjdBVXpwazBE?=
 =?utf-8?B?VitKRGhOQmtvVzNWaW56eVd6TjBDdllia2IwVTBhenV6QWkyZXg4d2cvWEU4?=
 =?utf-8?B?MU1vbGhWT2RpOHR4anNMTmozT2lNZmZOWTVMOU1qT0Q0UkpHMUpEWGR3ZnlX?=
 =?utf-8?B?enIrTlJlbmZ1VEpGRGxndS9yVnNqdm8zcWt1UHMzbDVkcTZHNHNwOUs1QVpv?=
 =?utf-8?B?YnpmV1h1QitzSXE3Rlh6MzltUzJMdTNaMEpXL1BvYmcxcWRaZys2elEzckM5?=
 =?utf-8?B?SUVtckxncHVXcVVvS3NyVnU3VjYrd0U5bTFjdUdEY3c0NUhuU3c0bGxNWnBo?=
 =?utf-8?B?dG42VjNTNWNXRXJOT1ZKOElxV3JPZE1SbXlxZVh2L0dkYkg2alluZ2o0TlVt?=
 =?utf-8?B?dlZaVWlFUXZmS0RBcFdoeWdiRXhzd2ozSnI5ajRCL21aR0VBMm1tWFAyNHEv?=
 =?utf-8?B?RWllYlNzd2Z6eU0rWUtwejF0Mk9NdjdDajk0ZXF3QS8xRlIzeXFUQldNL1Z6?=
 =?utf-8?B?YldaUURTamdKNmRHSmpGTHBscVF2L25jSDhYcnZ0UEZQM0cwbGdQSWhVdTFC?=
 =?utf-8?B?bjA4bFA3SmtLTnQ0SW1BS3J4N0FFazVXcmtHMDlsd2crMDhjWkgwTXlwa3ov?=
 =?utf-8?B?bFpzRmEzRjJzcWhEWmZGTWJYZE14SkQxNysyMXFQdGEzL0JVMjh4ejhseUhN?=
 =?utf-8?B?eUtYczJZTHlGdmYwVklYRTMwY0MyUUhzb0FWS3BmWXAzazh5STRwS0IyUk9U?=
 =?utf-8?Q?JQygSc0qs4qmr?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(7416011)(1800799021)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Nm1ObGNacTZWeC9BbkZFc3o4RWFxMFBETUxQRHFJVmNtZ1RBMkVWdm12dHQv?=
 =?utf-8?B?NmJhcEpwT2lHL2ZqQjRCZWRQbmV4SWV3TEkzZmNEcnhqVS9mZER1NlhvWFB3?=
 =?utf-8?B?c0VUT01mNm9nZi9NR21BNFFVbmtKby8renFnemROdGJOTmFkL1JDMjQ3NDFW?=
 =?utf-8?B?bE1ZejJtejU1bVdqaWEwdjQyMHV3TG1tNi95N0FwL0RGSXhDSWVKMEFlVTA1?=
 =?utf-8?B?OWpmV2M0REYxTVVqSlN4dWNNREExb2ZpeVpUWHo1WGJmWWlKNlE4SVhOSFFl?=
 =?utf-8?B?RWlzSnlhb0ZwM3dnOVl6TFFpQ1g4cjlUQ2UvWndGMWRQRjIrT3ZBbWxGMVpo?=
 =?utf-8?B?eEZJUGZXckJvekhJNFllLzR1NTdqMDVVa1IrQlUxRjdsV3hjUDRlSmxRenRM?=
 =?utf-8?B?SkdaKzdLcUEwUGEydFI2TkJhSWFQK3dLRUxHMmw1OFFmaElzaHAycTF3TnRv?=
 =?utf-8?B?MmgwRUJlVDJKcUF1RDlIbStiYTg4WEk2d1ZoQ01lbmppRnp0QnZuTWRzcGNU?=
 =?utf-8?B?QitvcVRndDE3SytCcy8yM0pCYktucTlva09QRStyYVZBeWtYcnRUeXh6MGho?=
 =?utf-8?B?am11TlRkM3MzSHp5Y3E5V0JVdWplMCtKbWREeXp6Uk43Y2tTeWFVeWtOVUdm?=
 =?utf-8?B?T1VkbnFybXBDN3V0L3lXSFUycmhtQlVFZVNSeldHSFJGamZ5K2wxai95Qml0?=
 =?utf-8?B?SXdHZW5FVUxVNEc5RVRzc01taWFJTDNrYjhyd21MR3ZaY0RXditDOGFjM2to?=
 =?utf-8?B?dEdpODUwNkFHZ084c2c2WEZDSTNwSlVFbm1oZGN4SHJvWTdrRVc4b3hZN0RO?=
 =?utf-8?B?NDZudHh2OU1qd0pBRUJKZkt3eWVheXZveDFKNjF4ZVdEdnVVWHh5OTNWemVv?=
 =?utf-8?B?Y3Z3a2wrbENZNlkxak5nMHlhN2dvcmwwRGxLRGxSMnVJL3NBM0pOcVFGRkhR?=
 =?utf-8?B?REZuL0JIeGsvTGNrSFdCMVp6VXc5d2V4YnpuTXJJaXc0WlRoeUR6dGhoYzJ5?=
 =?utf-8?B?RiszRGlra3BKS0Rma0crZGgzc0F3SkFGd3UraEhXT0tOOUxHWVdrU2p5WFU4?=
 =?utf-8?B?K0hqRG9YWDFjcG9BT3JCME9Zb3M2UFlRUVRUN1NDRHEzMWx1Mm1uVlFPc2hR?=
 =?utf-8?B?M1BFVFN0OGVGVktGcG9YVmpQOTlsS1JnT0lIaGdFL1hxL09qMDYybWdoRFpM?=
 =?utf-8?B?NXp0MUJHbllRTk51Qk9vS08rRysvU0I5MmgveEoyTW16UGxoMDFpaXRVZXFK?=
 =?utf-8?B?eTVVaTRCMHpPMGNzejk4NVJRR2lEZDF0OEh3YlpHZ0VnNENWUTRxOUlwUkEy?=
 =?utf-8?B?eWJQb21hQlhwbDczc2g3eStEeDBzSnZuOHdPQUpmSTE3V2MxeXNlK0ZSY0VC?=
 =?utf-8?B?UGJYeW1BaCtLeU8zanVMQkpoY1EvRmRrcWIxRmhKc1lrSThoaVBkalF2RlhV?=
 =?utf-8?B?eG8yV21SM284R1gyd29tZm9iTUJ2T0hiZFA2VlBudEpuQU91Q3g2eXFUUHFh?=
 =?utf-8?B?U0lTbzVKckFhS2kwY2xwSTl6SlhLNU5HTVlvbTlmMXZkMzJTRENpYncwWktL?=
 =?utf-8?B?QjBHVFR2dHowYTMxOWY4ekROVkk0L21mYjN3WXFrS3pPRnM3bERvZHppUy9z?=
 =?utf-8?B?QWVPS3IvUEZsNGdMV0NDcjllbTJJYzV4OTVhazRZQ24wM0NRMlYwYmFucWhK?=
 =?utf-8?B?Y1VHQ05LT2NzSlI0dWUwVG10UjlUZ0o0cEN4SHliRkxzanh6QTRsSWJTVGdy?=
 =?utf-8?B?UnFlWHllTjNyWTVhRlpmTXdxZGpmMTJDWVBxOGZadVY4SmpOQlVkS2RCaWk2?=
 =?utf-8?B?ZHplRUx6cUNXUXRsMzcvTFh3UHI3RHVrd0JLblZrUWhCVm5VVDFZNWpHME5q?=
 =?utf-8?B?WE1ya0pLWVpiRnRnQkpBNHJPQzRUdFN5YXEwUDFZeUxBdVdHWWlMaEhReFhu?=
 =?utf-8?B?NjZRZktRU3JHMzRicHdlR0swb28yeHNxWmtDeWZER3VhTjdDR2swSGp5R0w3?=
 =?utf-8?B?N2lPSlpCZnB2Y3F6SGhLUmRFY0p4eWlnbVdwUU8xYlczNTFURzRSazdBVEFk?=
 =?utf-8?B?aUs2RHdGUGF4VjhjRnc5TVB3b1VLUkNFS2VVWHAxczVLQ0hpVnYwaFRUd1pv?=
 =?utf-8?Q?ERcgF7qbJ3xrWkDVg51eNmpOs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75b6d3c-e245-4991-fcca-08dc8cb14e1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 20:33:52.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meotz5PASFPfoD2DCpXmkv2teJN4ScEtFYHjFeN/ATv78LJDkQivEXdylhV7VqusSTS2DzwR3dyYJSoq0uxHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10203

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
Frank Li (2):
      dt-bindings: ptp: Convert ptp-qoirq to yaml format
      dt-bindings: net: Convert fsl-fman to yaml

 .../devicetree/bindings/net/fsl,fman-mdio.yaml     | 130 +++++
 .../devicetree/bindings/net/fsl,fman-muram.yaml    |  42 ++
 .../devicetree/bindings/net/fsl,fman-port.yaml     |  86 ++++
 .../devicetree/bindings/net/fsl,fman.yaml          | 335 +++++++++++++
 Documentation/devicetree/bindings/net/fsl-fman.txt | 548 ---------------------
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |  87 ----
 .../devicetree/bindings/ptp/ptp-qoriq.yaml         | 148 ++++++
 7 files changed, 741 insertions(+), 635 deletions(-)
---
base-commit: 03d44168cbd7fc57d5de56a3730427db758fc7f6
change-id: 20240614-ls_fman-e0a705cdcf29

Best regards,
---
Frank Li <Frank.Li@nxp.com>


