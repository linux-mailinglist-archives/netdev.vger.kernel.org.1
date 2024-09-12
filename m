Return-Path: <netdev+bounces-127832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F68976C3F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD321F225BA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F41AD276;
	Thu, 12 Sep 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tJPnpbx6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E518890E;
	Thu, 12 Sep 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151709; cv=fail; b=A2bWyBXbwz3gbFay95tTse8sAJQtLrvarZ73hl3C2TS4QrA3rs1mhyv+1pKHhqTnWLfeZwGLOcR5Did4Vh+33vRSxOCbYwh8atbTu2PUef8MDLofDq7rI7uvMLCCwqAjSU5l29wsD524C7kKskvCD3lnID5fzW/Sn95uAJTkB3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151709; c=relaxed/simple;
	bh=QjLcxHrv1lYZEVVKfFHzgQsB+PEQAeo5ngRtxnwvkdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZNUYfrnapCuFvn4LBasTrIZabowfpI2xR4cLFqwBPnvTvlxgMvwYsLEp7K+e6UeUmJyfgurEGLkXmhWOiPsFB9Drfl0zqFkISjx4gZlIJBDpIQyqlhoj9wOirn3Hw6qPt/00aXCEaSWyNZmUxdm7To3EUnz/rDmF4SarvV5d00Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tJPnpbx6; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnHe5tYEepKyaYJJLzupIKjoHsAm0ZnAGfvOx5Nik/ZnpUHuv0JTrTlD8sJfS6f+z+QvPHyq84u9PHnUfAFKzG2PfsvYZ0iFgKUmStDSM+2oXfLiVqm1an3tqtA/eu/W55cSWnbQWr9mvwvgumRzIpzTqDugZeCwBbe9P5BqVDRRO7e05ZisbTz38nytzx3bWiWs7aVsJo6Fegknlat0HBat17mqT+3rJhveV7xzjLUpJxVaL3sRLIacIfqIy2KCof451nZVe2A+ds6sOA3mHnIqoeZ+UVisZwOfiSx+E/mzQxHS7OrkBl6aC3jtkGe0xX4/oLZtshxyobnEv15sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjLcxHrv1lYZEVVKfFHzgQsB+PEQAeo5ngRtxnwvkdw=;
 b=vT2lSv0oaS+bR0Y+j8cPUTfRFQP+awKCwKEUoMakj/LbfIWRZ7AgZfhRnDsCO2amkQEUaexeIMpA8nW85pRqKZMb4lI6yXsRhSUl9Mg4DM1d0QR4fFBsqWPYPe2lt55jL6KjH50gKhqy9BpGxf/kjJihLmIbUp/4p1FAAE+yknsgfVaSDBLTjEAkpVr1foq0dDqcIlfQXxmulcV1dtQ1lbTLJtR38qHD+wKne8SM+vfb4iLJOnFoSrkBAhhpw5162eX9CT78C7wWqLrd7pdV1LNPs16pmaAwNhKMWXbe5Hqhe9R4Gs42gm+vPSOvkn1NxMMRej1uPAldyd5AglanrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjLcxHrv1lYZEVVKfFHzgQsB+PEQAeo5ngRtxnwvkdw=;
 b=tJPnpbx6WGTNEnhNYMxlY1SLqKN7x1lULw96SdqNpSiVJERVcOBJn8S3Dr9356l80j3v46f0z8TtGL0prG6joN+uwSc6TpbrWVr6zU4DT7PwFDKKOumbcFL5cU/qx4XLHGnuHHmlRra8czxxGs3/VHE/oYxiDt20xNciHaoQKFs=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 14:35:02 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7939.017; Thu, 12 Sep 2024
 14:35:02 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
CC: Andy Chiu <andy.chiu@sifive.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>, Ariane
 Keller <ariane.keller@tik.ee.ethz.ch>, Daniel Borkmann
	<daniel@iogearbox.net>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
	<michal.simek@amd.com>
Subject: RE: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Thread-Topic: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Thread-Index: AQHbAw1QlhWoNsDZ7EOtVdYAw5Ers7JSJksQgAIUXACAAABxYA==
Date: Thu, 12 Sep 2024 14:35:01 +0000
Message-ID:
 <MN0PR12MB59535B22AA0E0CA115E94202B7642@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240909230908.1319982-1-sean.anderson@linux.dev>
 <MN0PR12MB5953E38D1EEBF3F83172E2EEB79B2@MN0PR12MB5953.namprd12.prod.outlook.com>
 <b26be717-a67e-4ee1-9393-3de6147b9c2e@linux.dev>
In-Reply-To: <b26be717-a67e-4ee1-9393-3de6147b9c2e@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB6740:EE_
x-ms-office365-filtering-correlation-id: edd78008-d938-4416-5509-08dcd33815fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGJIQ3JyeVNJV0xBMndKL2hRN0U1K1QyWEdzM3Q2ZlA4V2l4SlZXL0ZkaUYx?=
 =?utf-8?B?SHJOTy9SMHJLWHU4b01hYUFmQVZyaXlEeWE1SjZLVmNwQkp0MGxIY1dnWFN0?=
 =?utf-8?B?Zlo2QWFVUG5oa3c5Z1dGTkVzb05qODJzTGFTYVpHSXM1U0hnQjIvNzhaNlB2?=
 =?utf-8?B?T1hVNkhrYXlneVJ6OStLZjFOZlZsUUFYZHBqOXgrTTVKZ1lMQ0JiUjBEM3dH?=
 =?utf-8?B?L1RTN3VwR1JjTkZOL2JRdDd4Z2ZYaUhsRDRKMkR0NHFZL0x5bmRBQ25HUFY2?=
 =?utf-8?B?dGpHM0NKUUxGL1VmM0pPOGEybFo4c3JQVzZYSUI5UHVWSkxPVG5QN0s0RUdi?=
 =?utf-8?B?VzZTdGpUekRFTDhLeXlFZngrcUdUMlpVR0pDa3VOeTlCYzV4bmh4TFRSa3hn?=
 =?utf-8?B?cm5TWmRQWk1SR2Q0aVNLODZVWGp0c3NPR3NzZzVuUFRiUXJIS3Bvanp5Y0lF?=
 =?utf-8?B?eHM2MjFveFN6SEw1V0tZdWlpWmY0dy9YUVRWaFVNeUVCQmx0SHpPN3VhYWJn?=
 =?utf-8?B?R1BDaUhsaGw0UkJlSFJESVUwWXRCS1Y5Nnk4dDRlTVdlYS9UeFVEVDZ2NjFx?=
 =?utf-8?B?WWlPZUlzcE16RXQwRWZWSDUweUdicGlGai92V1BpYnM0eEV6emYvNGVkYVdj?=
 =?utf-8?B?Qk01OExKUSs5UHVVYzNCcWZtWVJ4ZDNieWZ3MjF5dFEzUmJ2WW5aOFNuc0lY?=
 =?utf-8?B?NzNMdkkvek16K1VYRnhRVW1zd3BGSElUbkhRYjdOQ2FPVzdYYno4TGw4OWZ2?=
 =?utf-8?B?QVd1dG9qYTM5NGk1TjNrU2hreVM4blJlWmRVOUdFL3JFT08rQ3hYSk43WS9D?=
 =?utf-8?B?ZndveUpsQytqVUpBdTF0b3czQlpoSW9UeG95TFJQTUUrWFhkZEZaSFVQWmVh?=
 =?utf-8?B?SzdhUWwxVmJmYmJaY3RLU0kzK0tMTG1qVzVSdjVtNFNWMmwwbU41Y0RmL1ow?=
 =?utf-8?B?NDA5eTc1bFU5NDcybUxvRU5zUlJUazM5bzd0dHdSNkQyaWtmK1IrTE16b1h2?=
 =?utf-8?B?QUhrZWV3UDFKUU5QYnFzczZvVkIrd0tnSHZWVVZJNUxvSEFmcXVwZlJ2eUJG?=
 =?utf-8?B?cVNjaXVQa3hDZmdiMk4zM3EwK0R4eWFOMGdRYWJyTStrbnVORkEzYlIvUXpE?=
 =?utf-8?B?Y0JQL3ZHc1ArN1UwRSt3YUkxVTJUOXcvY0p5c0RzQlZORDI3SVFLbzZOaFBh?=
 =?utf-8?B?RFFmTG1VaHJYSTdZRm9RcVZIanFKc1JTcSt0MkJNLzd4a3U1UVFESkF1cEJ6?=
 =?utf-8?B?SWhIY0xucCs0YjRlK0MxT0UwL0tFOVlOV20zbXVBdjl2bG5qNytvdUh0M2RP?=
 =?utf-8?B?TS85VHVGdjN3anFHQ2N3R3FnZW5uVFo1RTVMWktZaExGVFlTd1ZxMFZHalRn?=
 =?utf-8?B?NDlMVXFIb1FnekFCSjZsUzFDM2t6ZVBScEY4L252U3ZHSTZLc2l6VHRwNlcx?=
 =?utf-8?B?SHkxWEF5UlF0bjZ3c1kvamQySnphSmZoZWVISStNYmdPKzI0d29sVGVHZi9T?=
 =?utf-8?B?bEpZVzY5cUx0aDVSQ0xIcjltSU8vc2JrVGUyU1pKaDRsWDFiUlZvQzlBL09a?=
 =?utf-8?B?Tm5sZC9HQjVPdkdtbnA2Mlh6VCtvQ05TUnZUWTRXWlRZdTFnNWNuTkpiT1pv?=
 =?utf-8?B?NXRqZmx6T2NrR1BVTG5IY2M5L3gvemxRVVAzVUh5OEpxeGUxcEpWclYvcW81?=
 =?utf-8?B?MkJGQVR1dW5obzRqN1hrUDlqOXdBT3NIdFY0cG5xOW04b2t5bDRGRFExeTBs?=
 =?utf-8?B?dFVHWEFKTUNHNjdaUmJjazM2bjNwSW9JQU1OK3JDcjZ6Nm9GdWxydm5yTlAz?=
 =?utf-8?B?REtNN2xuTkN4dGlMa01qT2JrSG5SVTV3c0k4TFVZTmdYd2hZUVZ3UkNzOUc0?=
 =?utf-8?B?VW9vTlB5c1dpTWszaWJtYkx1VUNyZEtNZThiL0VBZXo0eGdGTWcvSjZQNjBD?=
 =?utf-8?Q?V1A6l+5cUq8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sk85bU5KY29jTTNPVzV4cVYvOTR5YklkQXAydHQ5ekJkUnFsdlh3R1l3UlhT?=
 =?utf-8?B?UkM1TkZmQ2NMY0ZmVk1uQkVWck5yQXcwelFqeERvVGVDOTNMaE5RSGxFajBp?=
 =?utf-8?B?Ni9XZGFKa2N6V0ttSHRDajg4ZlBxa3JuMzYwS2VXdkl0ZWZvNnpyTS9aMU1z?=
 =?utf-8?B?UDJ1T0lwYk96MFBTUjk1Q1pCRkVnSmhIWjlERUFZbDJZSlRUV0NTcnlMYzF0?=
 =?utf-8?B?RDVwVlJ2ZXdaaVZpUENiL0J6QWwwVEx4eXZrTlNHRlcrczlBa3oxYW5VVmFr?=
 =?utf-8?B?dzlEZklIRGc1WW5ZdC9CakRwVGk4cGFXOGk2eUxFWXUyY2JGTzg4YUprNWph?=
 =?utf-8?B?a2tqeFFNYlk2MHY5T0puSEdDVTBXY3V4akxPUUlEY0hPV2R5QTRpb2kvemNh?=
 =?utf-8?B?MEhjd3VIUmxMLzdyMXlCdEhPL0xxWWwyNjJqckVqU1NvMWpYVVJGQVQzbi9r?=
 =?utf-8?B?VGk2YVZmZzNhQTkxcithcDVoLytrcGp6L1NjM1NVTnBmMjdVYitZcHdxZC9s?=
 =?utf-8?B?M0NpdTgrdDg1MWxRSTBhbm54bjhtdXdoeiswTVUzY0pqSWRiaWtVdkRpZmlM?=
 =?utf-8?B?WUxaMjA0SnZxZUhlR3AyajV1WHVJK3dRK0hqTVovaTRmQmlJWHkyK3diQndL?=
 =?utf-8?B?Tm02RXZJZ29VR3dKbUtkM0NHeDh0SVFjRk1Id0VqREdEY0RMRk5Ec2cra3Y4?=
 =?utf-8?B?aThTN01seGtPM1Y4SDN6V01SN2t0VVRLL2JsQTZsdERkaysxREptUlh2STRM?=
 =?utf-8?B?WXdYWUZkWWd4VFJ4bTVZVGIyYlJCQ2IxZUdSREZJaXdHQjVBaFBSQ3dUVm1N?=
 =?utf-8?B?QUZjbXZvRGlRbHI2eGZWcnZScndEeFA1cVprcmZkNW9mTXl3ZXNaNW9qaExH?=
 =?utf-8?B?VWg5dE5Hdk52aFJyaW1TelRwZ3dxTWlUWElOUnYvMVZoSm1mNEk4RE44MWV1?=
 =?utf-8?B?TGNKamZmd1MzVFpxOWo0bmpaNSthTjQ4cnE1ZGprVDI5Z2VBZUR3T0QydnVy?=
 =?utf-8?B?eTRUZzRYN0ZzdXErU1BKTjI4WXk2RFBJR0VyUE1rSHA4WVRma1A0dGFpMVly?=
 =?utf-8?B?TUR6WGowV2tkK2g2YVdycUY4bHdBejlMeEljZ2xheWJDL1NyajV0Q0xxa1Bp?=
 =?utf-8?B?Z0ZYL1NXbTZBS3FYY3R4VEFlbXpORUU2dFpTc21VTXlqd2dTK05pWktpWnBp?=
 =?utf-8?B?dVQ0TTd3c1ZHM242Znh1SjltcTR3ZTZHV1BKZkhwVVU0VlA4OTZDYVlVTWNj?=
 =?utf-8?B?U0xYc0E4N1BHeUFaMlhiOGFLL0pmQTlHWmJRQnhQWmpPdXVJWUtVZ1Y3eVU5?=
 =?utf-8?B?SHRFUStYZUlsbXNEWWtaRmFILzB6eEQxNndoMUVzQ0g1aWRLYzgrUURNa1l2?=
 =?utf-8?B?R2pkYzdzZk1ITDU1OTdjTXJBMk4zVGlleSswdEJ3VWwzblM0cVN5ZjhDdW41?=
 =?utf-8?B?dEhBdnJNbE5tcEpoVVpaZ0FwWXNXVVBmaE1hK254ZnAxaUZPNWhzOGtHc3VQ?=
 =?utf-8?B?RjZvWitXVmp2SDhuUEJqOFphZEY1Yk9FU2JQUFFuOTFJTTRVQXNQb2dqMEc5?=
 =?utf-8?B?dzFWSmxGNERTbE83MndoM2RYZi9pQysxV0U1M2NNbFFTY1Eyc0F4T1RmNnFi?=
 =?utf-8?B?cFZuTnlYc0VQbUp5TXN0dWVLTDNsVzhZL3IrTVdxWVd3dFJsaFcyQ3FSN2RU?=
 =?utf-8?B?WHJ4WkYySXNvMXRodHJ6VktGVkIwYk1KUmY3MnpBd2V0QWpwZ2NCbnBCZ0d0?=
 =?utf-8?B?UTNhTjdFRThaQS9tKzJpUDlnZEdXbXkwUXZPMGZ1dTBSQzlvTXNYZFBrb2h4?=
 =?utf-8?B?TWZPZ1RCSnBwVHZDOTA1cEtBVWpzWlBIUzRZa0x1akozSEMwVFB0RUxDZHpq?=
 =?utf-8?B?SkdLOTZNYmZCTDZxcytSak1zVlVKaG5taVowM0NuNTBlWFE5SzNQcGhkUUlW?=
 =?utf-8?B?b2Z2OHJ5cHBZMmIxZzZ6Z1RIOFV4RVNMMnBJcmh5T2FnTE5TMHRQOUx6eXJx?=
 =?utf-8?B?Zk1DWFA3ejBrcURSQ0N4WENtSXFBRFVnRzlmWmhDdlNxT0hPeFB1WkE2blV1?=
 =?utf-8?B?T1Bza3B2YnJnUms5Y2dWbFJRT3lLeXVwZGZONVd5a0ZXL1IxTVVwWkJTbDdy?=
 =?utf-8?Q?Jmus=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd78008-d938-4416-5509-08dcd33815fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 14:35:02.0098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjzvVNrAixLgwCmp6rEqOKvRNpHE0KFarkw4E18qPPEg2WHwpra73AJlDIyQFY6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFuIEFuZGVyc29uIDxzZWFu
LmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxMiwgMjAy
NCA4OjAxIFBNDQo+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNoeWFtLnBhbmRl
eUBhbWQuY29tPjsgRGF2aWQgUyAuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVy
aWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpDQo+IDxrdWJh
QGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOw0KPiBHdXB0YSwgU3VyYWogPFN1cmFqLkd1cHRhMkBhbWQuY29tPjsgS2F0
YWthbSwgSGFyaW5pDQo+IDxoYXJpbmkua2F0YWthbUBhbWQuY29tPg0KPiBDYzogQW5keSBDaGl1
IDxhbmR5LmNoaXVAc2lmaXZlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNp
bW9uDQo+IEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47IEFyaWFuZSBLZWxsZXIgPGFyaWFuZS5r
ZWxsZXJAdGlrLmVlLmV0aHouY2g+OyBEYW5pZWwNCj4gQm9ya21hbm4gPGRhbmllbEBpb2dlYXJi
b3gubmV0PjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBTaW1laywNCj4g
TWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQg
djJdIG5ldDogeGlsaW54OiBheGllbmV0OiBGaXggSVJRIGNvYWxlc2NpbmcgcGFja2V0IGNvdW50
DQo+IG92ZXJmbG93DQo+IA0KPiBPbiA5LzExLzI0IDAzOjAxLCBQYW5kZXksIFJhZGhleSBTaHlh
bSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogU2Vh
biBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+DQo+ID4+IFNlbnQ6IFR1ZXNkYXks
IFNlcHRlbWJlciAxMCwgMjAyNCA0OjM5IEFNDQo+ID4+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlh
bSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPjsgRGF2aWQgUyAuDQo+ID4+IE1pbGxlciA8
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47
DQo+ID4+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+Ow0KPiA+PiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBB
bmR5IENoaXUgPGFuZHkuY2hpdUBzaWZpdmUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgU2ltb24NCj4gPj4gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPjsgQXJpYW5lIEtlbGxl
ciA8YXJpYW5lLmtlbGxlckB0aWsuZWUuZXRoei5jaD47DQo+ID4+IERhbmllbCBCb3JrbWFubiA8
ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBsaW51eC1hcm0tDQo+ID4+IGtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IFNlYW4NCj4g
Pj4gQW5kZXJzb24gPHNlYW4uYW5kZXJzb25AbGludXguZGV2Pg0KPiA+PiBTdWJqZWN0OiBbUEFU
Q0ggbmV0IHYyXSBuZXQ6IHhpbGlueDogYXhpZW5ldDogRml4IElSUSBjb2FsZXNjaW5nIHBhY2tl
dCBjb3VudA0KPiA+PiBvdmVyZmxvdw0KPiA+Pg0KPiA+PiBJZiBjb2FsZWNlX2NvdW50IGlzIGdy
ZWF0ZXIgdGhhbiAyNTUgaXQgd2lsbCBub3QgZml0IGluIHRoZSByZWdpc3RlciBhbmQNCj4gPj4g
d2lsbCBvdmVyZmxvdy4gVGhpcyBjYW4gYmUgcmVwcm9kdWNlZCBieSBydW5uaW5nDQo+ID4+DQo+
ID4+ICAgICAjIGV0aHRvb2wgLUMgZXRoWCByeC1mcmFtZXMgMjU2DQo+ID4+DQo+ID4+IHdoaWNo
IHdpbGwgcmVzdWx0IGluIGEgdGltZW91dCBvZiAwdXMgaW5zdGVhZC4gRml4IHRoaXMgYnkgY2xh
bXBpbmcgdGhlDQo+ID4+IGNvdW50cyB0byB0aGUgbWF4aW11bSB2YWx1ZS4NCj4gPiBBZnRlciB0
aGlzIGZpeCAtIHdoYXQgaXMgby9wIHdlIGdldCBvbiByeC1mcmFtZXMgcmVhZD8gSSB0aGluayBz
aWxlbnQgY2xhbXBpbmcgaXMgbm90IGENCj4gZ3JlYXQNCj4gPiBpZGVhIGFuZCB1c2VyIHdvbid0
IGtub3cgYWJvdXQgaXQuICBPbmUgYWx0ZXJuYXRpdmUgaXMgdG8gYWRkIGNoZWNrIGluIHNldF9j
b2FsZXNjDQo+ID4gY291bnQgZm9yIHZhbGlkIHJhbmdlPyAoU2ltaWxhciB0byBheGllbmV0X2V0
aHRvb2xzX3NldF9yaW5ncGFyYW0gc28gdGhhdCB1c2VyIGlzDQo+IG5vdGlmaWVkDQo+ID4gZm9y
IGluY29ycmVjdCByYW5nZSkNCj4gDQo+IFRoZSB2YWx1ZSByZXBvcnRlZCB3aWxsIGJlIHVuY2xh
bXBlZC4gSW4gWzFdIEkgaW1wcm92ZSB0aGUgZHJpdmVyIHRvDQo+IHJldHVybiB0aGUgYWN0dWFs
IChjbGFtcGVkKSB2YWx1ZS4NCj4gDQo+IFJlbWVtYmVyIHRoYXQgd2l0aG91dCB0aGlzIGNvbW1p
dCwgd2UgaGF2ZSBzaWxlbnQgd3JhcGFyb3VuZCBpbnN0ZWFkLiBJDQo+IHRoaW5rIGNsYW1waW5n
IGlzIG11Y2ggZnJpZW5kbGllciwgc2luY2UgeW91IGF0IGxlYXN0IGdldCBzb21ldGhpbmcNCj4g
Y2xvc2UgdG8gdGhlIHJ4LWZyYW1lcyB2YWx1ZSwgaW5zdGVhZCBvZiB6ZXJvIQ0KPiANCj4gVGhp
cyBjb21taXQgaXMganVzdCBhIGZpeCBmb3IgdGhlIG92ZXJmbG93IGlzc3VlLiBUbyBlbnN1cmUg
aXQgaXMNCj4gYXBwcm9wcmlhdGUgZm9yIGJhY2twb3J0aW5nIEkgaGF2ZSBvbWl0dGVkIGFueSBv
dGhlcg0KPiBjaGFuZ2VzL2ltcHJvdmVtZW50cy4NCg0KQnV0IHRoZSBwb2ludCBpcyB0aGUgZml4
IGFsc28gY2FuIGJlIHRvIGF2b2lkIHNldHRpbmcgY29hbGVzY2UgY291bnQgDQp0byBpbnZhbGlk
IChvciBub3Qgc3VwcG9ydGVkIHJhbmdlKSB2YWx1ZSAtIGxpa2UgZG9uZSBpbiBleGlzdGluZyAN
CmF4aWVuZXRfZXRodG9vbHNfc2V0X3JpbmdwYXJhbSgpIGltcGxlbWVudGF0aW9uLg0KDQpBbmQg
d2UgZG9uJ3QgY2xhbXAgb24gZXZlcnkgZG1hX3N0YXJ0KCkuDQoNCj4gDQo+IC0tU2Vhbg0KPiAN
Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI0MDkwOTIzNTIwOC4xMzMx
MDY1LTYtDQo+IHNlYW4uYW5kZXJzb25AbGludXguZGV2Lw0KPiANCj4gPj4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogU2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+DQo+ID4+IEZp
eGVzOiA4YTNiN2EyNTJkY2EgKCJkcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbng6IGFkZGVkIFhp
bGlueCBBWEkgRXRoZXJuZXQNCj4gPj4gZHJpdmVyIikNCj4gPj4gLS0tDQo+ID4+DQo+ID4+IENo
YW5nZXMgaW4gdjI6DQo+ID4+IC0gVXNlIEZJRUxEX01BWCB0byBleHRyYWN0IHRoZSBtYXggdmFs
dWUgZnJvbSB0aGUgbWFzaw0KPiA+PiAtIEV4cGFuZCB0aGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCBh
biBleGFtcGxlIG9uIGhvdyB0byByZXByb2R1Y2UgdGhpcw0KPiA+PiAgIGlzc3VlDQo+ID4+DQo+
ID4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXQuaCAgICAgIHwg
NSArKy0tLQ0KPiA+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0
X21haW4uYyB8IDggKysrKysrLS0NCj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0LmgNCj4gPj4gYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC94aWxpbngveGlsaW54X2F4aWVuZXQuaA0KPiA+PiBpbmRleCAxMjIzZmNjMWE4ZGEuLjU0
ZGI2OTg5MzU2NSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54
L3hpbGlueF9heGllbmV0LmgNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54
L3hpbGlueF9heGllbmV0LmgNCj4gPj4gQEAgLTEwOSwxMSArMTA5LDEwIEBADQo+ID4+ICAjZGVm
aW5lIFhBWElETUFfQkRfQ1RSTF9UWEVPRl9NQVNLCTB4MDQwMDAwMDAgLyogTGFzdCB0eCBwYWNr
ZXQNCj4gPj4gKi8NCj4gPj4gICNkZWZpbmUgWEFYSURNQV9CRF9DVFJMX0FMTF9NQVNLCTB4MEMw
MDAwMDAgLyogQWxsIGNvbnRyb2wgYml0cw0KPiA+PiAqLw0KPiA+Pg0KPiA+PiAtI2RlZmluZSBY
QVhJRE1BX0RFTEFZX01BU0sJCTB4RkYwMDAwMDAgLyogRGVsYXkgdGltZW91dA0KPiA+PiBjb3Vu
dGVyICovDQo+ID4+IC0jZGVmaW5lIFhBWElETUFfQ09BTEVTQ0VfTUFTSwkJMHgwMEZGMDAwMCAv
KiBDb2FsZXNjZQ0KPiA+PiBjb3VudGVyICovDQo+ID4+ICsjZGVmaW5lIFhBWElETUFfREVMQVlf
TUFTSwkJKCh1MzIpMHhGRjAwMDAwMCkgLyogRGVsYXkNCj4gPj4gdGltZW91dCBjb3VudGVyICov
DQo+ID4NCj4gPiBBZGRpbmcgdHlwZWNhc3QgaGVyZSBsb29rcyBvZGQuIEFueSByZWFzb24gZm9y
IGl0Pw0KPiA+IElmIG5lZWRlZCB3ZSBkbyBpdCBpbiBzcGVjaWZpYyBjYXNlIHdoZXJlIGl0IGlz
IHJlcXVpcmVkLg0KPiA+DQo+ID4+ICsjZGVmaW5lIFhBWElETUFfQ09BTEVTQ0VfTUFTSwkJKCh1
MzIpMHgwMEZGMDAwMCkgLyoNCj4gPj4gQ29hbGVzY2UgY291bnRlciAqLw0KPiA+Pg0KPiA+PiAg
I2RlZmluZSBYQVhJRE1BX0RFTEFZX1NISUZUCQkyNA0KPiA+PiAtI2RlZmluZSBYQVhJRE1BX0NP
QUxFU0NFX1NISUZUCQkxNg0KPiA+Pg0KPiA+PiAgI2RlZmluZSBYQVhJRE1BX0lSUV9JT0NfTUFT
SwkJMHgwMDAwMTAwMCAvKiBDb21wbGV0aW9uDQo+ID4+IGludHIgKi8NCj4gPj4gICNkZWZpbmUg
WEFYSURNQV9JUlFfREVMQVlfTUFTSwkJMHgwMDAwMjAwMCAvKiBEZWxheQ0KPiA+PiBpbnRlcnJ1
cHQgKi8NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxp
bnhfYXhpZW5ldF9tYWluLmMNCj4gPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGls
aW54X2F4aWVuZXRfbWFpbi5jDQo+ID4+IGluZGV4IDllYjMwMGZjMzU5MC4uODliNjM2OTUyOTNk
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4
aWVuZXRfbWFpbi5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxp
bnhfYXhpZW5ldF9tYWluLmMNCj4gPj4gQEAgLTI1Miw3ICsyNTIsOSBAQCBzdGF0aWMgdTMyIGF4
aWVuZXRfdXNlY190b190aW1lcihzdHJ1Y3QgYXhpZW5ldF9sb2NhbA0KPiA+PiAqbHAsIHUzMiBj
b2FsZXNjZV91c2VjKQ0KPiA+PiAgc3RhdGljIHZvaWQgYXhpZW5ldF9kbWFfc3RhcnQoc3RydWN0
IGF4aWVuZXRfbG9jYWwgKmxwKQ0KPiA+PiAgew0KPiA+PiAgCS8qIFN0YXJ0IHVwZGF0aW5nIHRo
ZSBSeCBjaGFubmVsIGNvbnRyb2wgcmVnaXN0ZXIgKi8NCj4gPj4gLQlscC0+cnhfZG1hX2NyID0g
KGxwLT5jb2FsZXNjZV9jb3VudF9yeCA8PA0KPiA+PiBYQVhJRE1BX0NPQUxFU0NFX1NISUZUKSB8
DQo+ID4+ICsJbHAtPnJ4X2RtYV9jciA9IEZJRUxEX1BSRVAoWEFYSURNQV9DT0FMRVNDRV9NQVNL
LA0KPiA+PiArCQkJCSAgIG1pbihscC0+Y29hbGVzY2VfY291bnRfcngsDQo+ID4+ICsNCj4gPj4g
RklFTERfTUFYKFhBWElETUFfQ09BTEVTQ0VfTUFTSykpKSB8DQo+ID4+ICAJCQlYQVhJRE1BX0lS
UV9JT0NfTUFTSyB8DQo+ID4+IFhBWElETUFfSVJRX0VSUk9SX01BU0s7DQo+ID4+ICAJLyogT25s
eSBzZXQgaW50ZXJydXB0IGRlbGF5IHRpbWVyIGlmIG5vdCBnZW5lcmF0aW5nIGFuIGludGVycnVw
dCBvbg0KPiA+PiAgCSAqIHRoZSBmaXJzdCBSWCBwYWNrZXQuIE90aGVyd2lzZSBsZWF2ZSBhdCAw
IHRvIGRpc2FibGUgZGVsYXkgaW50ZXJydXB0Lg0KPiA+PiBAQCAtMjY0LDcgKzI2Niw5IEBAIHN0
YXRpYyB2b2lkIGF4aWVuZXRfZG1hX3N0YXJ0KHN0cnVjdCBheGllbmV0X2xvY2FsDQo+ID4+ICps
cCkNCj4gPj4gIAlheGllbmV0X2RtYV9vdXQzMihscCwgWEFYSURNQV9SWF9DUl9PRkZTRVQsIGxw
LT5yeF9kbWFfY3IpOw0KPiA+Pg0KPiA+PiAgCS8qIFN0YXJ0IHVwZGF0aW5nIHRoZSBUeCBjaGFu
bmVsIGNvbnRyb2wgcmVnaXN0ZXIgKi8NCj4gPj4gLQlscC0+dHhfZG1hX2NyID0gKGxwLT5jb2Fs
ZXNjZV9jb3VudF90eCA8PA0KPiA+PiBYQVhJRE1BX0NPQUxFU0NFX1NISUZUKSB8DQo+ID4+ICsJ
bHAtPnR4X2RtYV9jciA9IEZJRUxEX1BSRVAoWEFYSURNQV9DT0FMRVNDRV9NQVNLLA0KPiA+PiAr
CQkJCSAgIG1pbihscC0+Y29hbGVzY2VfY291bnRfdHgsDQo+ID4+ICsNCj4gPj4gRklFTERfTUFY
KFhBWElETUFfQ09BTEVTQ0VfTUFTSykpKSB8DQo+ID4+ICAJCQlYQVhJRE1BX0lSUV9JT0NfTUFT
SyB8DQo+ID4+IFhBWElETUFfSVJRX0VSUk9SX01BU0s7DQo+ID4+ICAJLyogT25seSBzZXQgaW50
ZXJydXB0IGRlbGF5IHRpbWVyIGlmIG5vdCBnZW5lcmF0aW5nIGFuIGludGVycnVwdCBvbg0KPiA+
PiAgCSAqIHRoZSBmaXJzdCBUWCBwYWNrZXQuIE90aGVyd2lzZSBsZWF2ZSBhdCAwIHRvIGRpc2Fi
bGUgZGVsYXkgaW50ZXJydXB0Lg0KPiA+PiAtLQ0KPiA+PiAyLjM1LjEuMTMyMC5nYzQ1MjY5NTM4
Ny5kaXJ0eQ0KPiA+DQo=

