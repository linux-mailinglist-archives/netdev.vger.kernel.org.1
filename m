Return-Path: <netdev+bounces-161480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE2CA21C84
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B62164608
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D671B4141;
	Wed, 29 Jan 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+eB32Wr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2A1B5EA4
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151599; cv=fail; b=S5oog1vglU0arlu+jRC0xlwXnTeQAIKSG4AAOx/3p4WTbyejfeNx18dwVQW3zoQFnFLQbW0ECbN5sq7AGwZ6386FKnaQtKQJW7scWXr4S2/VmOBpHq/9QiaEJeSuCmGGo1z+tpF72jfgDyqIu655r2jEDw+T0Aioyidnc8kJPr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151599; c=relaxed/simple;
	bh=2HuKOFJqlcszMZ8qTxOdAL0mzJbITW2tA1YBbPdwGxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TEZzn0VXoAlXbYMtu1POyzsTQ5mTyWKyAeoZW7T5UrNW3IfAdE5Ukwdqk3rPNP/sBgOXn3ZPqcNF3tv/4olcKjBXm5unY0JQAHQQiUW66Z28LYkwgT9Mh80okua2y4HFh+RqNPBPC75BlvjqBaMx9prKe1VCcXWcONSZ2Vxw9bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+eB32Wr; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ih1zo65XTBDdS0Fpjzksqcef9erYoB63NxRjQz31vojmMGCEurRYKxp/7wufNgQso3sRy0lJBsSv7EIYUko+kYw2Px6nkIoVGrGT3q7TNi0dP9L7kypMhzcBvZDjpv65Ygb7IBSNwx1FBhvWHF+Jv2qROnBh0IfcZ1Y6nVI04ra86Z9m99c9/5org2Dz0s+0ZjjUEgCZvTPDj/h2bNJFDCPfcxtnvJcdQrvfpBinmlEg/rTaatlB5ynMW9aCVLlVFbKzSPQe022Euw75HmoJF64hYSnYO0g+tE6uy3to0PI9fIIisic2Din0eT36z81U1ohhG/vWh21PawIBgo/dIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HuKOFJqlcszMZ8qTxOdAL0mzJbITW2tA1YBbPdwGxs=;
 b=YXRjw6Ja4s8YOfVI+59KLRH6Q1Te49xwCPYNRQ1z0sXIIA7c019OwcSvtxnwAE3ZDhsGa2R+8qQAi6vVLfY/8T/vHw28FzSRmRnTTCd0HKfkkYpc/EHsIhWowbCT1G0/YnIdToSv035/3T9XNTnEo8iH2WgqdfK9dRiir2sxoZ8drRLbLcAm6kUr2AxMN0wTWtjEvlnWwfzNYxge7Hht8114itBX10roEtxaqiCgJofSB0yTGTSqsKl5FZNfLj2/8jCHi+HDsINeI7M5TCsSbDEfRYroqi4nJ6cIYwNvcL/PuMvXylsZn5jvMLxeyi0/oUlglk2ZR7Dj0JUsyq9+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HuKOFJqlcszMZ8qTxOdAL0mzJbITW2tA1YBbPdwGxs=;
 b=t+eB32WrsBtC/zV6b4/VBcoJwnC0bLwQw/RJjwfXYfL+p45/XPtJFYROk7PqSE0iEzNn1X2yL2MjrEE8DfNDvFporFMJWb0fHpgOZsnyBhU0biqUwak2t30IHxC2aYD0MAlt3zb2VG6JkwPouuAuMumkqeMkAeo70ggVeoUKFSQY86vZ4v9yyKqgLPPiZvAVNzYWnCQ/Hg045RtfyenqjIC9QWZRXkPA2ZNTthMkqeX+EhaPJGSXFhrHmplj9U8dqMMAj43ROSov6tzJjQyBF1PYkjjH5H6sQOEWV8mRL602G6aTe7Wa0ypyB6fqjjiXV1Y9p/UVrGqs4l31YezBVA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 29 Jan
 2025 11:53:14 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 11:53:14 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Topic: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Index: AQHbb+l5fdqqldfRAUu+2iXPDyW3KrMrEMQAgAEdyvCAAWcnAIAAEvmQ
Date: Wed, 29 Jan 2025 11:53:14 +0000
Message-ID:
 <DM6PR12MB45160F2C04E1644F8384BBACD8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-10-danieller@nvidia.com>
 <20250127121606.0c9ace12@kernel.org>
 <DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <87ed0lq43y.fsf@nvidia.com>
In-Reply-To: <87ed0lq43y.fsf@nvidia.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DS0PR12MB6629:EE_
x-ms-office365-filtering-correlation-id: bc4c9d59-09b5-4c67-fecf-08dd405b8330
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkRwSXIwQXo3NmY2U1lRd0V4Z0FrSExGek16bUY3UUNZVHlVdXBkMkdETkVw?=
 =?utf-8?B?V09uM3F3dEd2b1ROQi9Zd08vbW01eHZua1gxY0cvRElvWFk5dGc2czFpQU5E?=
 =?utf-8?B?dUNqZDh1UHZEYjF2VXdtby9vWUZKclBCei9QK0N1K2xvWXd6YVlnSmVJcGxq?=
 =?utf-8?B?akpRbFl0MmtTS21ZbWFwUXZvekNkM2pNdDB1dVBPUEV1L3NRNVJHTFl6Wlpn?=
 =?utf-8?B?R3I1bm54UUQ0N2FVeHBZNzFDbVNTdGpCYVBhbDcvR3hiTHJxdkRUM2Zrb2FE?=
 =?utf-8?B?c29vV09ZcVBWZ0tJS3o1ZGFkRDBGdHpXY2xUR29EeFlOcjRjRlFBcXEzbmdw?=
 =?utf-8?B?UGZPZThITXhqRUVRTjF6V1pibXhISzc4U1NHK3k2aHdiQ29EemNwSXdaMGJa?=
 =?utf-8?B?N3RqREZXYnRwc0xzcnljWk1FeUgxM3dDcFhPS1F1QUcweFJYZnBPR2I4MWRU?=
 =?utf-8?B?SlJiUnZXZndtL2ZDNVpOcTQ2VUF1ZDV6RFdlQ0lneGFKVkdKQzNBM0ErUCtK?=
 =?utf-8?B?QXRaUXdCMGg3TzB5RUJpaVM1NVVKb3llWk9WU3Z2Z3JGK3Y4cnFPQ1N0K1p1?=
 =?utf-8?B?cG5aNlZLQ3l6bFgrOHFCQmxsa0p0dU96ZWI1SWRSZXNramloYlh6SGpEWUVK?=
 =?utf-8?B?UHgvS2M2RGl0ZXUrK3puUXNsNEk5V2tBZGxaU3lpS2hFS2tnOFJlOHFDQmha?=
 =?utf-8?B?ZWsvN3pnamp3N0RmWkUyMDBYa0lqbFV0aTIxZDJPdkkwZmFIdUNJeUswTXQ1?=
 =?utf-8?B?NFNGUm9PZ3dFZmNheVFNTUVhS3A0ZCtXempydW1ia2p3QUJabXprUEE2a3hn?=
 =?utf-8?B?TlRNcE1UeTJDYkdQQUZPSkk0TEg5YnNQVEUwdzBGSkxoanZJbk0wK2xJSXg5?=
 =?utf-8?B?Yitndjd1TWdYSzV3SXNWVUNOT2xYaXowT3g5by90UGIwUW9BenhIRjFLVm5j?=
 =?utf-8?B?THh5djMvRmRnSGNWNjVxOS8xOEtoQVpDZGFjMDl4TVh3ck52Nk1id1N3VzFC?=
 =?utf-8?B?S2RuVzBmWk9nb1ppL2dSUVdjQjl2YmhGTEJjUTBwRjVuUGprcllYaVgvaVBN?=
 =?utf-8?B?azhheGZVUEVFWi9rUmpGVzROTTJBbWRzUDhxNVl3YUEwdjllcmRBWXorelpN?=
 =?utf-8?B?Y0w0d0RJQzdrVTZaVlVYckRxK1lPNjhrbkJFWlZUZEV2SHE0T3M4Y09WbjNv?=
 =?utf-8?B?TXJJOUE0OEgySDNiR0QvR3NodkRrcGdFNEVrMmJ0ek5FT2lsYjdRYnYzT2g2?=
 =?utf-8?B?QkNoM3c2RlhkaHFtRkVkK0xwbXBoREYvVDlBQ0RhSDB0WXRQcS8yOXdSQzdG?=
 =?utf-8?B?UXhpN01NZjVnUzJ0QStaeisrdStsNGhFNmc2YzZVNUxKZU1HdXFndmJQNmJU?=
 =?utf-8?B?QkQxdEo0eTNsNE1JWDV0VExMZXhFMlk4MmNDdUt5M1MrTVRaa2tKSW5Lb2JR?=
 =?utf-8?B?bVFETE5MOW9vVUN1Y0dOblFRNUQzWEpPKzJsRlh2K1Y5OVMvTHpiRWVQeHJR?=
 =?utf-8?B?QVUrMUhqbTE3Nm1mY09WSnQzRDVLaysrMjMxMlkxZUp3ak9USTlsbDNwbWF0?=
 =?utf-8?B?dmZ0QllrbjRpdUk1anJkeWMyTDZzdmkvODQwdFdEUW5xMURMZm5IUExKU3BI?=
 =?utf-8?B?NHZNU0E4NHFWQXNtNnF6KzVHWVIxM2lMWlhOZjNDTmFGN2toL3FrUlZicFVL?=
 =?utf-8?B?bUxSVGRFeW9JelY3K2lsT0VobTBZTHNKMnJET3BxMDIwQi82MXlYOTJ2Vy9m?=
 =?utf-8?B?eFYxd210ZlpSK1FrR1RoQ3gxVys4MTZ3S3FUQWJRTXFKeDVFM29ZZGVzY2xS?=
 =?utf-8?B?THNQTXRyRnBUbEZrdzVvT0VGTmloQ3BMUjd5MitRN05CVjFmU2tiUWYxSVBF?=
 =?utf-8?B?N2p2V2lVRmN6TXJJZHJlYUJwR1lMUE9Oamt6RFY1c0dFclJZd2ZmR1RTV2p4?=
 =?utf-8?Q?iY26aHnnSANUT4nQp+89JrDXmDIl8F/S?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFRMaXpkVUZsUWhhcUErWVZ1RmVzZ2NWYVhMWjYvdm0rNjRVMWROU3FZVFdN?=
 =?utf-8?B?dEtxOWdsQXdHbFdMT3pvVjcrbjl5ZDVkcElETmE1MWNPdWM4Y1IzR1VVWWN3?=
 =?utf-8?B?RVdWakVYdnppSVlNSXBNcmd4dnBIdXdQU3JQeHRRWkx3SDJjVHhKZy9Dend6?=
 =?utf-8?B?SjFwWCtwZHlqVzdwbnBQc1ZFcnhQSnZBZE0xN0R3YTVKeklKL0hlREVIbGdO?=
 =?utf-8?B?REVabUFjN09TTFBHRUVMWVl2eFdhcGZyUGw3czN0NjQzeHBzdStRK3orZUY4?=
 =?utf-8?B?VEkzNHVDVEdIdjNDQ1p5MGpMbWEvUFlwSGg4YW4vcVd0TUdveTJ0K3FESE4v?=
 =?utf-8?B?U2c1cFYwNmxQcUQ4Wk1maDJydmRpZlBUUU1MZDJDUUZRRzh1aG9TRmVKRksy?=
 =?utf-8?B?WkdzQVNNQW5JMTZyZGZWQWVyT044S1o0MGVZYUVkSFIvV2RQQ3M5RzVoc0xL?=
 =?utf-8?B?VjV5Ui94SG1uU1hZOHhxNTkrWHhNVDBHbFMwMkFVRUVCSjVWYlFWSWxnQ1pG?=
 =?utf-8?B?Y1dKMnQxWHdvb0FIWUEvTTBPSDhVdXNqWU5zVXBxT1FFb29QUnFEa1lQSjhQ?=
 =?utf-8?B?K3lMVkdrZWliTDQzSnJBcUtMOXdsYTZpNVdXeVhGZGJiaXQwTFBDcDh6cUtv?=
 =?utf-8?B?SXJkQlJWMUpuc0hoSHhhV0pOaEN1ZVZnVzJEU0NFN2tIZnoxYVRsUGhSMWxG?=
 =?utf-8?B?RDhMRGw4SGZ6dHdHZjNWMGFnQzVXSFFFWFVMZkVCQ2RHdTN5QWdVWDJRN2FW?=
 =?utf-8?B?T1BHSkJhMnh4ZnlHaFNHRTRPNGFXajVacmMxZEVmM0E3ZlA2U0FUMEp4amN6?=
 =?utf-8?B?Ulg0S0svM2xXOElGRVRhbHUvQVljOG5kQ2xmejl6L0VtbHBmclF3eXkwVU44?=
 =?utf-8?B?bytlMjNlM1EwYjZNYjlDelFBT1hlYlN3VlJHMFl3eGJ0RjZFWHRiYS8yaGg0?=
 =?utf-8?B?dGtxM2Rkc2pCNlFOZndsd1RReHBoNUhzeHNzNHM4RThnVTBDUWNNMGREZlBv?=
 =?utf-8?B?NnZnVnA2R2xNTW85Yk5nQ0xFVmZ0QmdrU2dlVTNWSHJHbW9XalJPMXBuNWtJ?=
 =?utf-8?B?TnI4UldoaVY4dXp5MlFra29xRlhNaTE1VytDZWY2Y3FvbTN6cy9wMVhZZENl?=
 =?utf-8?B?VHBoNHpyMnBmNnFwODZFVE9udExYbDlmRStXTXhxeVp4L3R5c0F6cUUwcGhY?=
 =?utf-8?B?VFIycDYxR084dVNCek9kMFBOdVRuOCsrdkptT1lVWk83ckhmR0JuNUR6SThr?=
 =?utf-8?B?Mm8xdzJVc2hETC8rSFJQNG1sQk55ZldhUVlXWXpoOGNvUytrZFV0SSt3c1Y2?=
 =?utf-8?B?dU8zTGp3dXo2YitqeVcvbFpVaHJyWlkyZDFlN2hqUkFObTRyWFJDckFFdTdt?=
 =?utf-8?B?Y1JHZGZqZnFRZW1PN1B0NEhmeUJrMXpGSHhUU3ExeU9XUjRkWWJEdlJEQ3Jm?=
 =?utf-8?B?SmkrVUVUL2VBY3JnaERSc1p1eFAvWjhzOURJdWdXeTU5eUh2djAwZVUwYUVl?=
 =?utf-8?B?NGF3dkFCUldIRFl2dEJQRm1NYXJXRkhNSHlnMTZNZ00ySXdBc0VoSndBdlVB?=
 =?utf-8?B?blUwKzYzRTVWS2FUYTcyT3VoUUFXakhIUEUwNG5GcDl3VEZOTHNVUVQ4ZHZK?=
 =?utf-8?B?Qi91aFdxVFcxbVZxMUV6eGlXcm9XOENBSyt6Y0g5NDFqbzNjaFJaMFNTc3pF?=
 =?utf-8?B?azUydVR2eEVHMHpZU282bFZ0dnFOeXlvbmk1YTFrSjZnSDYvZS81OXJIdkE2?=
 =?utf-8?B?N0JFRjE3M3Q3M1FYNFVjVC94L0MrUmN4TDVZRldENTZyWVpqUlVUL3VCYXBN?=
 =?utf-8?B?RUt6eGlORUxSNEJCUFd2M0RGU3pWWnNyS3ZFcWFxcWZaM2tBd1BEUytscWd0?=
 =?utf-8?B?eHZ5ckFBb01PdG45SXp1RHU0R2JINmd1L01FSDhLd3N2MHc4ZSszRm8wK1Ba?=
 =?utf-8?B?SXN4WWVGUmQydEM1eUNBZ2IvOTNmL0V5djJvR2MrN3lFN2QvYjdpYnVCOWhM?=
 =?utf-8?B?VjNmcTVxcjJOaEdvbjNUQjdwTDlXZXZiOFpnY21CMkpnWUhMcW85Q1NscmZB?=
 =?utf-8?B?VUVLcEo3M2s0aG15RzdsTXNvSTJzQUpGb3kwM1RTcXA5S0cvL21FR002Y2tS?=
 =?utf-8?Q?XQmw6Vf+nfAXzy/7s+uWWhHXG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4c9d59-09b5-4c67-fecf-08dd405b8330
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 11:53:14.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvIbyITBJ6BOfT01VTdJusbvT3Iz4cgI9fcWVhArV+CuPd/1gR1IqtrVtHFZkf2J3w3MZU+aUvOxvWOEFkDeig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ciBNYWNoYXRhIDxw
ZXRybUBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDI5IEphbnVhcnkgMjAyNSAxMjo0
NA0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gQ2M6IEph
a3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0K
PiBta3ViZWNla0BzdXNlLmN6OyBtYXR0QHRyYXZlcnNlLmNvbS5hdTsgZGFuaWVsLnphaGthQGdt
YWlsLmNvbTsgQW1pdA0KPiBDb2hlbiA8YW1jb2hlbkBudmlkaWEuY29tPjsgTkJVLW1seHN3IDxO
QlUtDQo+IG1seHN3QGV4Y2hhbmdlLm52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
ZXRodG9vbC1uZXh0IDA5LzE0XSBxc2ZwOiBBZGQgSlNPTiBvdXRwdXQgaGFuZGxpbmcgdG8gLS0N
Cj4gbW9kdWxlLWluZm8gaW4gU0ZGODYzNiBtb2R1bGVzDQo+IA0KPiANCj4gRGFuaWVsbGUgUmF0
c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBGcm9tOiBKYWt1YiBL
aWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiA+Pg0KPiA+PiBPbiBTdW4sIDI2IEphbiAyMDI1
IDEzOjU2OjMwICswMjAwIERhbmllbGxlIFJhdHNvbiB3cm90ZToNCj4gPj4gPiArCQlvcGVuX2pz
b25fb2JqZWN0KCJleHRlbmRlZF9pZGVudGlmaWVyIik7DQo+ID4+ID4gKwkJcHJpbnRfaW50KFBS
SU5UX0pTT04sICJ2YWx1ZSIsICIweCUwMngiLA0KPiA+PiA+ICsJCQkgIG1hcC0+cGFnZV8wMGhb
U0ZGODYzNl9FWFRfSURfT0ZGU0VUXSk7DQo+ID4+DQo+ID4+IEhtLCB3aHkgaGV4IGhlcmU/DQo+
ID4+IFByaW9yaXR5IGZvciBKU09OIG91dHB1dCBpcyB0byBtYWtlIGl0IGVhc3kgdG8gaGFuZGxl
IGluIGNvZGUsIHJhdGhlcg0KPiA+PiB0aGFuIGVhc3kgdG8gcmVhZC4gSGV4IHN0cmluZ3MgbmVl
ZCBleHRyYSBtYW51YWwgZGVjb2RpbmcsIG5vPw0KPiA+DQo+ID4gSSBrZXB0IHRoZSBzYW1lIGNv
bnZlbnRpb24gYXMgaW4gdGhlIHJlZ3VsYXIgb3V0cHV0Lg0KPiA+DQo+ID4gQW5kIGFzIGFncmVl
ZCBpbiBEYW5pZWwncyBkZXNpZ24gdGhvc2UgaGV4IGZpZWxkcyByZW1haW4gaGV4IGZpZWxkcyBh
bmQgYXJlDQo+IGZvbGxvd2VkIGJ5IGEgZGVzY3JpcHRpb24gZmllbGQuDQo+ID4NCj4gPiBEbyB5
b3UgdGhpbmsgb3RoZXJ3aXNlPw0KPiANCj4gUmVndWxhciBvdXRwdXQgaXMgZm9yIGh1bWFuIGNv
bnN1bXB0aW9uLCBKU09OIGlzIGZvciBtYWNoaW5lIGNvbnN1bXB0aW9uLg0KPiBJTUhPIGl0IG1h
a2VzIHNlbnNlIHRvIHJlYXNvbmFibHkgZGl2ZXJnZSBhbmQgdXNlIHRoZSAiY29ycmVjdCIgSlNP
TiB0eXBlDQo+IHdoZXJlIGF2YWlsYWJsZSwgZXZlbiBpZiB0aGUgaHVtYW4tcmVhZGFibGUgb3V0
cHV0IGlzIGRpZmZlcmVudC4gU28gbnVtYmVycw0KPiBzaG91bGQgSU1ITyBiZSBudW1iZXJzLCB0
cnVlIC8gZmFsc2UsIHllcyAvIG5vLCBvZmYgLyBvbiBldGMuIHNob3VsZCBwcm9iYWJseQ0KPiBi
ZSBib29sZWFucywgYXJyYXlzIHNob3VsZCBiZSBhcnJheXMsIGV0Yy4NCg0KT2ssIGZvciBib3Ro
IG9mIHlvdSwgd2lsbCB1c2UgaW50cyBpbnN0ZWFkIG9mIGluIEpTT04gb3V0cHV0Lg0K

