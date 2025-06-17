Return-Path: <netdev+bounces-198665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B016ADCFF9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70CA172424
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005DB2EF645;
	Tue, 17 Jun 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Ro6JSRe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E82EF642
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170585; cv=fail; b=aN40qHBvk2AGiKBNOB/dT/2/hjxmdsAyh+6Gl8PWzraTKLcBS0nNS7js+kOhsQhKyT01TFCulWh87gFYik/MAmRWvvAhvg0gbRu+mPIRuJUALa8aJNR4dicrKh9wz6k/o/MpxPuGc0LJJHrGx5YMdiDogTNWbz0MijDdzMJUt34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170585; c=relaxed/simple;
	bh=o7lUveni9IHFXQ0Vc4fJNVjECEHP8rjJHhWF05rb/u4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UomlfKFC88XXQPQ5628IWHdw156yKmgafvNLiD+j6rZMM5n51M830pL9X8Adq47UW99ZWncULOGCphb6lN3f/6db4+OBMgc7Qnlt7l4d6Et3WQbhNOixGpc5eJheJLARI8yaRlnEyTfMKultqGUbaar3SxEvEFj93dOjL5iJxM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Ro6JSRe; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/T3dxcR5GSSquq1RvVZwUvPoZx0OK5yHX+w8vT8JAKy4q3a1nnWLWu4wN2cmoSyAf5JKMaMqDygkDnvbl8b79LpntLMDA7xOOkXsLrUmBYikAPcjjszMfBS9vzz4SBlJIjFQ5ErLYdgcfXvfLOb1Bo4KR4t9k+MAzSiojY8XB3xxFYSR/F02B/Cb3IbGGtEhSqcn428eVLg4REHo+x+bXKZEN0Pew8QDUiQMKD1WHfgNq5aFW88OxmySaQ7acwxNx3DJwCm/fqdDCy86rC8Je0mzPK15ZXuUlcJ9+6mCjd8KqRg9gxBPJvo3vL5q5BUYSzd0Y/+r+vg0s3NttPd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7lUveni9IHFXQ0Vc4fJNVjECEHP8rjJHhWF05rb/u4=;
 b=BkHFxGISDjNR8l8thL3eC8YobdsvewrmYmxu//rKhgcOn0T/oCCLfHi0KRdKnh0+8uPPSbdprFzSzSElPHc1RZO8q2lni97CqJXeYHK91FP+g7W1lr/EhTG+VBIgmpLshjn5gjZoHE3xLvMhCrwAwg+l7jM26HVn5X05lv3QgM26KuTzP11Q7VFFi129ehiagr8GPNARxiLKcR/ibojhveYSPbXIOQVA15Khqyxz4CYCNwPgoxZ9DBpCrtVhK3InPTAnR6qIBkkTuWfYGRRGh0G+e4YPGOu7sI1iwlmPSHeScoIdpGsqaufAEh04LzFVU1wWABhL27ECoGqBS+5+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7lUveni9IHFXQ0Vc4fJNVjECEHP8rjJHhWF05rb/u4=;
 b=5Ro6JSReI6tmtlmedM831Qe0Oite4irw95n4hpy2ZpUHqnRbNhp3PT+oQDm5eGFD0aUK3XpykF4rtZCMeL1+27bPuEWc4VO2AWYljV1+4NtEDmaF1Q0bZjdTTtWQez4kZlvs9zlmswYr7MORy9MD+nP1j/7zMjpIoSQt4Tw31gE=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 14:29:40 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 14:29:40 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"jedrzej.jagielski@intel.com" <jedrzej.jagielski@intel.com>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Bharath R <bharath.r@intel.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [REGRESSION] ixgbe broken after devlink support patch
Thread-Topic: [REGRESSION] ixgbe broken after devlink support patch
Thread-Index: Adve9gZxdo+gRUk1T32Pw8JoiNgJPAAcFyoAAAsm1KA=
Date: Tue, 17 Jun 2025 14:29:40 +0000
Message-ID:
 <LV3PR12MB9265653CF3481A750615D00B9473A@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB92658474624CCF60220157199470A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <59faaf3b-d75d-4405-a7bb-a137918617e3@intel.com>
In-Reply-To: <59faaf3b-d75d-4405-a7bb-a137918617e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-17T14:20:36.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|BY5PR12MB4067:EE_
x-ms-office365-filtering-correlation-id: 086bf659-c6a2-4217-edd8-08ddadab6512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFNSNUR4LzBUREtkK0xsUmo3KytrMFhBaVl6S3MrMURpQVRoMGVZUXFPTzhp?=
 =?utf-8?B?a1lMbkxldm1BWTBuWit5VERxNlk0UG41SEM1NjZVTWRvbjlIWXdHRU5pVDFT?=
 =?utf-8?B?VW5uK282WTF2c29QTlVRNitGcWQ3V3dORFREK0dUQ1M1ZkY4VjE4S0h4dVN5?=
 =?utf-8?B?V0cwYXViR21PelpHbThKR3d0RXhYQlJRZGREOFBPbm9sZHU5VkczbE9aTkhM?=
 =?utf-8?B?VU9hVEhyajFxek9vTzFLdFJXNWkxZW03MHJGa2RjZ2Ztdm5JUWJWQzBURkVv?=
 =?utf-8?B?V3BUcXV6cFhsaEFmbHJHbWp4TmZwRDYzMlFsMG1ibEJPT2xudDNXT0l4Z21m?=
 =?utf-8?B?UWxMa3Z5bWNVZmhQMU1kMmw2bmJhQnY3KzhjMmxORGFuQ0hYQkJBd3M4TWhG?=
 =?utf-8?B?bS9DTkhlcUdBUHViT2xXVU9HNTA5NTBROE1DaDBpWVNqSys2NFhHSkVncHBD?=
 =?utf-8?B?eDJNMUNZM2RnRkdveTRiS1I1b0ppYUM4eXJkZWxsSjJnMG5FUnk0M0FoeVJ3?=
 =?utf-8?B?bXpITmZ2dTdwbkJ6bzVHRDhqdUFVNUtGNTkvbjZ3N0JCR1Y0WjlFcHR4SkZw?=
 =?utf-8?B?dXg2d3JEeDNCWXRDM2RjWWVZdFNOcUFoYWtNWmt3c3hlQXo5SkhSS1BkMWQ2?=
 =?utf-8?B?S1VsZzlWMUlxZ3VqZ01Ed2R6cHhob0FsR2N4Vk8zNXpRTmZaS09kS2VCdHBN?=
 =?utf-8?B?RXBIb1J6dXovRGoyMGlYVTdmclRBSFFuY2VnL0Nxb1MwY2l2bW50bXhGZDNQ?=
 =?utf-8?B?TE5iOVJlMCtzUnNqVXlTV2Y4R2VuSlp2UmZoQ3VUTGgrcmsxMUlzVDVsdGIv?=
 =?utf-8?B?b3VrYURmWW9uM3k1N1RIeWdOMHdmT0ROQzFIdHNkN3hNRGRIUmZiVlpCU0VS?=
 =?utf-8?B?bUJKb2xrei8zaGtGZm01a2MzaU9vdlhoVXRKbGNzV0t4TUk5UDl1US9QQVp5?=
 =?utf-8?B?QkVwMzBLeVM1QS8rNXZpS3YxMTJ6UmZrUGdrUDY0S2R1Y1NZS1FacUFwQ21Z?=
 =?utf-8?B?cktwUmRjZ2ltVVJGSDhlM3Zqdk8wWnRIRVBIS0tjcEZSWlhsa0I0QmxORWt3?=
 =?utf-8?B?Q1U4QW5rVC9MSjNUeFJ5a0U0Sm1oK3MrcFFrVkZYc2xDWmROY0ZYK241dERx?=
 =?utf-8?B?YXdiV1VydVp3WEZ1WVF4cTYrb1NpcWlzMVpORUNLamF3VXB5SEttdS90ZUJ0?=
 =?utf-8?B?OFpjNE4rZnZzVzRuQlF4LzYyUVNoSHhJcUZQTmRacmhXSFNrejhBbWRZVEdW?=
 =?utf-8?B?Y1ZMWE9IengxZWgyVGlaOURFTFdPRkg2TEFvQllvekNGS0UzOGpyY3hVQWpN?=
 =?utf-8?B?V20vejNsbnNRQmw0UTViZE9xdXc5ME9iMWprbkc3MWNWRkRsK0JZMjdqMUFQ?=
 =?utf-8?B?STRsWXRROC9uYmYycjhBTXF5NDNjcHljeHBmbjcxUnF4RUxTNGRqM1JqWG9R?=
 =?utf-8?B?a1puK0JEUEhVT1pzZDVJaDB3R3Z4T0RWT1lRSzhHamlncEZUUVhoK2NtRGg5?=
 =?utf-8?B?OTNNY051V2s4UmdEdE9CenpWVkRXOHNoS21INWhFb1ErbGRlQ0VveHRkTjI1?=
 =?utf-8?B?Z1M4R2ZnL0s3NTlyVnNPZ1h0bDROSEU1YmhCZG1FcmorNndnVlptcHI4dEtN?=
 =?utf-8?B?Wk54NVVlMnA0dWZHMDlnVDlJOWw0Z3FwSERGd0ZGblQrZDF5Y2VuRndNZkxh?=
 =?utf-8?B?aERkUHdnSjJxU21XbEtRcU9FRE13cEZQTVVud2d3ckRzVjFJZkVnSkRITzZZ?=
 =?utf-8?B?WHJwOU5vQmxhTTRoeVpVTG1CaWdSMzUxdEN3OUZDSlJVRC9PZHNlVVU4cXI5?=
 =?utf-8?B?STRXaCtJZDA0dE1IQkgxcUVPWStkOGNrSVVMcVZOR3R1U0VDaGhuY3ZUS0tr?=
 =?utf-8?B?bkNvckRpTFFlU25wYkFYa3RwaCtEeUl6bmVhZzE1MzFuK2xkZlhYQUw4UExw?=
 =?utf-8?Q?aXiUzGfBBaQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUMySkJrVTVWMHVZckVFS2ZuZHdsZVZ1NGFPajlCelRVZ05WTzZNaTJyUVRs?=
 =?utf-8?B?eCt5WVIxd05ualFFREc0MkFLRkhvL3R4MlA5cnZCRGRoQmtEeklkN0Y4NldI?=
 =?utf-8?B?SGxNR0Y1TEJBcWpYS2RjMFdFOUJmYmtkeVZIK3dTQVFIM2dJSGY4WEJScTlO?=
 =?utf-8?B?UjNQVm9Nd0VCRk9GV0xlOERKcTN0cUJoOXNaYTR3bUxqSHZ6TWw1QkdXMVZ3?=
 =?utf-8?B?SWFJNEVrV3JsdmdjZWtnS1BpUEN2QXc0aWJnbEZKYXgxc3lKaWllWVBwM2I2?=
 =?utf-8?B?Mys2akJKNW1CNWRMYUprajkyR2tZUTVFZzhoMU55eXVIcmZaS01uTzA1dnIw?=
 =?utf-8?B?ZzBXZnZtK01DQmw5K280SzBmWHJFOWliMGw0VjNFYytOTVVMWTFaMVE2aGVn?=
 =?utf-8?B?Tk9FelVwU2N5Mks5cEJZMzRSUXg4a3phUHBrNTFTL1R2VWQzVWRoYXpJZHNn?=
 =?utf-8?B?SFVTY3pZUVphQ0g2ZXU3NXhuVjJwOWNLeGpEc2M5VVhGWGNTR3l1N1hLNmFw?=
 =?utf-8?B?VkZlVVg2cHBnUW4vNzB1NVFDTGFiRXZxTThGbGIrQTFOZTJneFplMStjTVJY?=
 =?utf-8?B?LzR2VllCUzIrakFFenNxdDJ0RUJVaFBBaWJxcitpUGdoNXNvNHVVQ3djZG40?=
 =?utf-8?B?di9BTmdzekdRYWhwZlc3elUzeDZZLzVVT1ZRSWpTdXlneHlkRW5HdkRuZjQ2?=
 =?utf-8?B?U0c2YmtvWFRXUFNoMzRSbE5DdlhsVWZzeXdSQmpLaG9EUVNJUmM0c2oremlh?=
 =?utf-8?B?NjBFcm4vdktqVG1rNnFmZGNjZmtCeHpGNWh0RUw0Vi94MjhJeXdnV1ZoY1VH?=
 =?utf-8?B?N0xpZFU2QVk4c3h6MXZLRkd1aG1vTktJNG9USEV0a1AySUtBOHBCRkFBSDlI?=
 =?utf-8?B?NXJraVRmbVdHVTFMMFBQem1OdzFlNGVDSlV5S3hDdGo0RmR4YjRuZDlydXU0?=
 =?utf-8?B?MU5Db29uUXl0TVNwL3NXcXFzYUlNWGFDYVNNeFRiRGo2MzdFa2NONVBIVnNP?=
 =?utf-8?B?dmM1TDVoMTZxWGFUemNzeUp4eUpEMFdPMGNrd3F3QkJlS0ZCZmZGZjlYQ1cy?=
 =?utf-8?B?N0FzcGJackJrREdRSU1NaU1DRTJNUFgrL0VkZTR6QnNYaHRuemwycjAyYUtY?=
 =?utf-8?B?TGs0ZzRxWEZ0RnlsRTZKSXVnTkNvNU9PbXVZcTlGNHJYTkVMSDNKVlNQVkNZ?=
 =?utf-8?B?NisrOEFEaEUzdEk0U0FnTmlnMFJVYkRqbFhqR0hnUWxkYlVuRUtkMHpMK3Iw?=
 =?utf-8?B?SVhVa1dYczJzWWNNdTNjcjZJYnZtY2Z3d3J3MXFGQTdRT1pzWjFaSjdVOFpn?=
 =?utf-8?B?TlUxTzFwOU1ndUtaUlY2VnVNNloxcC9IUkFzVHFpTjIweEcwbnBRWCtjYW9h?=
 =?utf-8?B?M1llc2luSjkrVEJNMDJ6NWl5YkwwWlo2bWpOaStOVHR1TlhaN0JUdkxRZlZH?=
 =?utf-8?B?c3hMYnVIWitjeVNiTzhHam5uUW5hZzlyU1ExdWxDQnVLMVYvV3F5NVA2M2dz?=
 =?utf-8?B?NTh1eE54K3NrSkwxbHE2ZDkrTmVsN1V4UHQ4Y1VNSG5JU1RWc1RSdzIzT0xI?=
 =?utf-8?B?VGxwS0FMdVRpS2RKcU0vaGNEN2lVZFdhL1hqRm5WUGxmWUxvK1lyMUlOWkJi?=
 =?utf-8?B?Sk1kbXpzcnozZ3VxYUl6ZUN2SDdGUTNYajhRR3RBUGVrUng0T01MSFkwOWp2?=
 =?utf-8?B?WXlVcmY5eThVdElmSUZBaS9QNUpkSTM4TUpIalZhRjRoM2htQzNnZnJscmRn?=
 =?utf-8?B?T3c4ZzNZWTJZem51MjVlVENYeTY0d2djZEs0ZFo2alJ6dlhTUWhZcklVMElI?=
 =?utf-8?B?Nzk2aFpqdDRmanlKVFIxUHFDZkNtM3JiYmYvNG1LWVlJcjNuQjkxc2FVaW1l?=
 =?utf-8?B?OUFIb2tHb1FMY0xqbVhmeStxdlRDdFNXODc2bFRJUDJxVXMyZktKVWozeDZB?=
 =?utf-8?B?WnVXZERiUjJJUWRSR1MwSnJKUzNBeVNwRHhaUmYwQlNYVXV0c09zZEdiTWFZ?=
 =?utf-8?B?TURxQnhvd1ZNT0o4N1VJWlNCeTlrelM2TlVLZmRwVCtkVEJ6alhaYmY3NjE5?=
 =?utf-8?B?OFZpN3Fzdk9EMWpwOXNuc2Jja2RKQy9aaHlmMGM4TUlyUWJvM21yeWhpQUtI?=
 =?utf-8?Q?AvZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086bf659-c6a2-4217-edd8-08ddadab6512
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 14:29:40.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmeHtHChul3wqcGSY0ArXcAHI68lJ4fVlo5xjYjw+VggKUAxogbNem/IbloIPLk9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQcnplbWVrIEtpdHN6ZWwg
PHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTcs
IDIwMjUgNDowMSBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+
OyBqZWRyemVqLmphZ2llbHNraUBpbnRlbC5jb20NCj4gQ2M6IGFudGhvbnkubC5uZ3V5ZW5AaW50
ZWwuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBob3Jtc0BrZXJuZWwub3JnOw0KPiBNYXRl
dXN6IFBvbGNobG9wZWsgPG1hdGV1c3oucG9sY2hsb3Bla0BpbnRlbC5jb20+OyBCaGFyYXRoIFIN
Cj4gPGJoYXJhdGguckBpbnRlbC5jb20+OyByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY7IGlu
dGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JFR1JF
U1NJT05dIGl4Z2JlIGJyb2tlbiBhZnRlciBkZXZsaW5rIHN1cHBvcnQgcGF0Y2gNCj4NCj4gQ2F1
dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVz
ZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxp
bmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiA2LzE2LzI1IDIxOjQyLCBLYXBsYW4sIERh
dmlkIHdyb3RlOg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlz
dHJpYnV0aW9uIE9ubHldDQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+IE15ICJFdGhlcm5ldCBjb250
cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBFdGhlcm5ldCBDb250cm9sbGVyIDEwRyBYNTUwVCAo
cmV2IDAxKSINCj4gZGV2aWNlIHN0b3BwZWQgd29ya2luZyBvbiByZWNlbnQga2VybmVsIGJ1aWxk
cyAoZmFpbHMgdG8gc2hvdyB1cCBpbiAnaWZjb25maWcnIG9yIHRvIGdldA0KPiBhbiBJUCBhZGRy
ZXNzKS4gIEkgYmlzZWN0ZWQgdGhlIGZhaWx1cmUgZG93biB0byB0aGUgZm9sbG93aW5nIGNvbW1p
dDoNCj4gPg0KPiA+IGNvbW1pdCBhMDI4NTIzNmFiOTNmZGZkZDEwMDhhZmFhMDQ1NjFkMTQyZDZj
Mjc2IChIRUFELCByZWZzL2Jpc2VjdC9iYWQpDQo+ID4gQXV0aG9yOiBKZWRyemVqIEphZ2llbHNr
aSA8amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29tPg0KPiA+IERhdGU6ICAgVGh1IEFwciAxMCAx
NDo1OTo1NiAyMDI1ICswMjAwDQo+ID4NCj4gPiAgICAgIGl4Z2JlOiBhZGQgaW5pdGlhbCBkZXZs
aW5rIHN1cHBvcnQNCj4NCj4gWy4uXQ0KPg0KPiA+IE5vcm1hbGx5LCB0aGUgZGV2aWNlIGlzIGdp
dmVuIGEgbmFtZSBsaWtlIGVucDE5NHMwZjAgYW5kIGNvbm5lY3RzIHRvIHRoZSB3aXJlZA0KPiBu
ZXR3b3JrLg0KPg0KPiBub3cgdGhlIG5hbWUgaXMgbGlrZWx5IHRvIGJlIGRpZmZlcmVudCwgcGxl
YXNlIHNlZSB0aGlzIHRocmVhZDoNCj4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjUvNC8yNC8x
NzUwDQo+DQo+IElzIGl0IHBvc3NpYmxlIHRoYXQgeW91ciBuZXR3b3JrIHNldHVwIHNjcmlwdCBo
YXMgc29tZSBwYXJ0IG9mIGludGVyZmFjZQ0KPiBkaXNjb3ZlcnkgaGFyZGNvZGVkPw0KPg0KDQpU
aGFua3MgZm9yIHRoZSBwb2ludGVyLCB0aGF0IHNlZW1lZCB0byBiZSB0aGUgaXNzdWUuICBJIHdh
cyBydW5uaW5nIFVidW50dSAyMi4wNC41IExUUyBhbmQgSSBoYWQgdG8gZWRpdCAvZXRjL25ldHBs
YW4vMDEtbmV0Y2ZnLnlhbWwgdG8gYWRkIHRoZSBuZXcgbmFtZSAod2hpY2ggd2FzIHRoZSBvbGQg
bmFtZSB3aXRoICducDAnIGF0IHRoZSBlbmQpIGFuZCBlbmFibGUgZGhjcCBmb3IgaXQuDQoNClRo
aXMgaXMgYSB2ZXJ5IHVuZm9ydHVuYXRlIHJlZ3Jlc3Npb24gYXMgYWxsIEkgZGlkIHdhcyB1cGRh
dGUgbXkga2VybmVsIGFuZCB0aGVuIG15IHN5c3RlbSBkcm9wcGVkIG9mZmxpbmUuICBJdCB0b29r
IG1hbnkgaG91cnMgb2YgZGVidWdnaW5nIHRvIGRldGVybWluZSB3aGF0IHdhcyBoYXBwZW5pbmcg
YW5kIHRoZW4gaGFkIHRvIGxvZyBpbiBsb2NhbGx5IHRvIGZpeCBpdC4gIFRoZXJlIHdlcmUgbm8g
bWVzc2FnZXMgaW4gZG1lc2cgdGhhdCBJIGNvdWxkIGZpbmQgdGhhdCBnYXZlIGFueSBjbHVlIGFz
IHRvIHdoYXQgaGFwcGVuZWQgb3Igd2hlcmUgdG8gbG9vay4NCg0KUGVyIGh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2FkbWluLWd1aWRlL3JlcG9ydGluZy1yZWdyZXNzaW9u
cy5odG1sLCB0byBtZSB0aGlzIGNsZWFybHkgcXVhbGlmaWVzIGFzIGEgcmVncmVzc2lvbiBiZWNh
dXNlIGluIG5vIHdheSB3YXMgSSBwcmVwYXJlZCBmb3IgbXkgc3lzdGVtIHRvIHJhbmRvbWx5IGRy
b3Agb2ZmbGluZSBqdXN0IGJlY2F1c2UgSSB1cGRhdGVkIHRoZSBrZXJuZWwuDQoNCi0tRGF2aWQg
S2FwbGFuDQo=

