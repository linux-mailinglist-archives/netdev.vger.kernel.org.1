Return-Path: <netdev+bounces-164149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084BA2CBE9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E37167C75
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD151B3955;
	Fri,  7 Feb 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y3qAKmcI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CC2A1D8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953988; cv=fail; b=FhKfEH6o646PbHptSl35UIH+NNBQQkBvLbf52RUu/6ackGY2QlyagMKHPsgA6cXDNgf2jwaJZl4KHXbntCFpYr+5EEEHYH1htTuv6lfUpK/wdi6Y0ZIffXxCjXXWf9WBHvWzJqM/3Funnd1fnutDD+3GNsZqi/UW904y/0Ms3oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953988; c=relaxed/simple;
	bh=1vqDcfrPUnmw6nLnB6jn9hjxUSU8JFdtTx1QiLgEqVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KX+oT+BXIAuWN5xOfT0nVXHdDE8vVtwdewgL5k1JBj2SofD6UigUyK4eo2Qu3rbACyPh2Q+I/1al21eji7b0eDVEwLKkt+Gke/dvNp8mk0MXCXK16vD+Vfk7GyRTu124/v380tkE5hzph1e+vMi+C/n6Qw4/FfG/oN4hEEsX7I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y3qAKmcI; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+8sz6ZwJI0BtHf0XPa3pQKcFKZLbI/VRu2FkhmugpCmHbPmt0btRiTWfolgShDYTNJIo86rHy6ItnSP1eXcqsMXBdWT/Hj7p9zYIVwdMsKKFQI0MlQH1GZh3BE+qnR8ijJCnEh/zxK2qwtspP5CXfN6KPxvglCJL1wMFZNMPGAptZM8DETkqRA4pJXHzjED4WmX4ND7eZp4bdc3M6G8nApWwgHi/eiAmHYqxdgMB5USOaKLxVbAJbkTwtqIcQXoRYoChDih4ZLCv1rGY/mv4wddUpuuUIM8yBuF/KN9YSlfaeT+rsaTQUqRh0b+TE6yllJXqP/EQx4iBg6SvMxXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vqDcfrPUnmw6nLnB6jn9hjxUSU8JFdtTx1QiLgEqVc=;
 b=qibZbxyb8OVCGnqcBLfBr0hpTFW/la2a5Vmwmsdq4V/MS2K+lEpEflwvM/8UWJ+5deozwPkMduNANrU+SMoPkvlV6+Fw/IJlqLHzYZbJBdTZLjV1V9/0ZVJZIK+pF0r2E8kENtlzyJtHeoBuNEH5mKGjfQAlPnrryePWdwJDSLIxRK5YwgYmZMQ8rWIzl7OQ/mfYBW6lFlIQwraEBvl9/gHH6gHZYd2osGM6l8AvzvWV08OXEc9W/upeIot9w6zSMVPUjVZROoR2OyIzY85SC5hJ8kZRmsGFta86G5iPZl180NYRbknXc2qFvGCs+Dw0pJfBizh7KPq9kc/6MoVAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vqDcfrPUnmw6nLnB6jn9hjxUSU8JFdtTx1QiLgEqVc=;
 b=y3qAKmcIxcki8RAGUyloeX6UsRfcU4wxgntJTrWZtGypS7+u+3MwyX61CotGInMvFNur1BSZ8wDRKCc4Y02NyldO/aCpQITBwIWNBw7y1+0sotU0kXC9QozWfdNAPWkeW1qtGIkMc6ob7tzYbVlZDl9P2bLxnc7CSe5uzF9yofakydwu36M7y34n3SpfW9rMwTHhSPxI44StDGL+nS7pqpt7/3D+mFhdau0cE+BEgH7zyCqYolpr7YZUTb1eceAajFNJCILLoVyzJBnOZeP01GdkzZHsnJO2O1QmglG43gYyI3xzLOVqmMgM/ta2UgosxoEnDmVlRm4rUKV6oSvNIQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 18:46:25 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 18:46:24 +0000
From: <Tristram.Ha@microchip.com>
To: <rmk+kernel@armlinux.org.uk>
CC: <olteanv@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 2/4] net: xpcs: add SGMII mode setting
Thread-Topic: [PATCH RFC net-next 2/4] net: xpcs: add SGMII mode setting
Thread-Index: AQHbd9HJ+6xRdhFvek6UHRIthURjDrM8MVtQ
Date: Fri, 7 Feb 2025 18:46:24 +0000
Message-ID:
 <DM3PR11MB873689D00EDF038BE43F0351ECF12@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <E1tffRJ-003Z5i-4s@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tffRJ-003Z5i-4s@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: 27bc59fb-cca4-4c09-b248-08dd47a7b931
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHJJVlg3U0w2RkRlSmxKeGl2ME1MamY4YUdiVFp6TzU4b0c0UHBWbG80SXlh?=
 =?utf-8?B?NDdhN3gxZzVmNTdGNHJUVFlVOGJwL210MXRIeFZKRnZQT1lqb1c0STVYOThw?=
 =?utf-8?B?Qy93aXFCamlQeXhuNUJMNU8rT0RzdUNvVGFZaTNpVVNLbU5XRE4xeGJYZG1Q?=
 =?utf-8?B?SGI0RVNtRkIyMWthZ0FOS2pCTEJIUlYvb3dlaGdrc3o3bDg2TUR6V3o3OTNu?=
 =?utf-8?B?ai9qOGY3UEV6Y0c5VStidWlKK29udjRlaVk0RWRySDRWbzZwMVlKQ2EzWU5i?=
 =?utf-8?B?TW0wVEt3WVl6MVVIVTBFaldPdVRxSm1MRWlBYTNVK3BwRFpmTUlRcC9heWdN?=
 =?utf-8?B?SVJidU9OaXNUWkJuMjBUcGg3T3kzZWJscTlOMjZ2azZFdTl6bmZoeDZXMjJX?=
 =?utf-8?B?VWNwcGloVENYSWpLSXFMdDFOQlkwaTFZVWpicTZJMXMvUG5ITmZzblZDa0hs?=
 =?utf-8?B?UDhQYy95ZlJoY1lUNHFWOFArZUNVYmhUK2lPY3pEQ2xQODNzQU1iRGROanlh?=
 =?utf-8?B?b25qQWVRT0lMREQ0UThSN0NFZWJUU0FCY0dLaGpFVjRhVEY3c2JFT2JYTTdL?=
 =?utf-8?B?Q1RxaG4rK0srNXVhdlhRbG5pbnVPS1FsakZ1TXVRc1RXemhSUTFRQUVvMU13?=
 =?utf-8?B?cW5YSVhGK2xwMEh4NUF2aTBoS2NIMjAvUDZxSzJGNGhBQWwvZWNVTjF2a0U5?=
 =?utf-8?B?aUo3N1VmMDJoV2htSE03b0dkbjRZK3BNVllaZUs0b2gyUVVHL2loTmNEY3FI?=
 =?utf-8?B?SzI5c0hOSlFwcUtUNFd1MHdsSllzTFE5c2x6VG8yei9SN2Z3ME5Nd2l3cm5G?=
 =?utf-8?B?cnIyNDA0YzU2eXJxczdhM0wzUGoxM1VhSENJMnoxUlkxWjZjTWtwOFZGL3lS?=
 =?utf-8?B?Sjc2T29YaldMbmRYVXUyWmM1UmNsMjBMMkVtc0xHU3BFOUoxeHNtM1hvNVM5?=
 =?utf-8?B?M2RGa1JqUzJkc2hsaU9DR3plUlVGdXh5cCtRZUpiTW5GMDZCcGFXUCt2SThq?=
 =?utf-8?B?VnpQLzNzbklrcU9xdmNuZWxPTm5oQk1oU2E4Q2pWMnpETE9qZnk3QkZ0V0FI?=
 =?utf-8?B?STdRYVpmTzR2MWVDOHA5MnVyTnppck1BSXlSYXNnZk1ZMHAxdVFjRzVUdG05?=
 =?utf-8?B?dlYyb3UxOXpWQlJxUCt0MEluSHR0YzdKR0tOV2hPa0l2NHoyaUtEVERTWmpj?=
 =?utf-8?B?QzJySUR4U24zWFY1UldUdWdVWVB1NVFWL2w5TVBTdzFZS0xyUVRUdGp2d2VT?=
 =?utf-8?B?eGl0SklNU1pOYTAyaTBOSjBGL3U1R002bTlrQlVaUXdmUnpYOXBrYVpmUlIy?=
 =?utf-8?B?T3JiRHRzNVBDc0MveUFEMzQ4WDlYRVk0Y3htZXZjU056UHFQYjY3Qk1lbG94?=
 =?utf-8?B?eVFETTlGNlpDS3VVRDJhMEVoN1JadXo2SkRzdU1NUFlRQkE5RmJJamlaMkhZ?=
 =?utf-8?B?ellYN0FyTkJMTEhwSTZDRnB0MEtweDNKVmJWM0tuNS96YUlsN09maHVZblE2?=
 =?utf-8?B?VHVJSjk1THZTMThKWmR4UUFIMDNxUWh5dXN0S3JqcU5SR0NHeUtCUzJUK01q?=
 =?utf-8?B?QWVjSnhlZTBhYjBmUGlVSWkvdlJabXEvRU9LUndEOVN5azBhY0x2bU05S0NQ?=
 =?utf-8?B?OFlFZUNsUWJNUGVSS0JEcVFvUUtGUnhTT1FFQzVUSnNWbFJaQ2p3NDlxa2Iv?=
 =?utf-8?B?ME9mM2JuNGU1OU1KUzNBSmRnNERCTlVEbG1yRlZwQ0d5K25SeVR6UlBydXVm?=
 =?utf-8?B?K2pYNFFWcFdUeWtDKzdFV3kvY01Nb0FMV2hJOXJkREZJS1ZTajgyUUtVRDR6?=
 =?utf-8?B?MWJGbndvNmMyMDdYLy9OVThZVmRBdTB5RkdCTTZGcWptUUN0RGpETHdwU2FM?=
 =?utf-8?B?Nis4QUV5eC9wT2VIQ2Y5UTFUd3N2dysvUGhTRE5OQnRSQWJITnNVSGZmaGVh?=
 =?utf-8?Q?R6QaMQcQUlejVs5etpcuzchfeQGU8PWO?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGJxbTgrOEdtSUpFNm4wUTE0eTVhSGNITEdDOTJ3czN6NWx0T1Vqa0UrOWll?=
 =?utf-8?B?Q0lIZkUzWVFnZ0xjZHBpelpzT1lDSmJPQTd5V1ZxVHJ1UG1CNGlpeGtKNk5k?=
 =?utf-8?B?L1U4WllnVmJibzVYWGhvYVRCNEFBY2V4d0FUem9vQVptUWpWcWpjeHNUQ3gz?=
 =?utf-8?B?WTZVRlIvTllhbXFzekVJc2NCV0dDRHgwY0RCaFhhU01DNjhScWpqd3UwZ0Zz?=
 =?utf-8?B?NjUrelFsT2J6eElaMnlXYStrZ09ZeG1wS0s1NkwvQWRQVlVVRHdVcUd4em5G?=
 =?utf-8?B?TlRQL2JSc0UyNmlUK2J4Yk9pMnhRWnJseE5nSlBFUmhjWERiL3FaUC9hQU1Z?=
 =?utf-8?B?Z1lOZzRCSEVGcGxEOGFLSnUyTlEvNmZWZGtRWmlxamNOUC93NjBoOFBBQVZo?=
 =?utf-8?B?Mk9wWmxHMktydHd6NUN2MzhmYVRZN3QrZTYvWnFON1E3TzYvb0V0a0w3djIy?=
 =?utf-8?B?SHkrd1JWNzlyN0lmT1hTYXBoV0I3VmUrcWtvUFV6M3FuV1hDL3kyaUFDSnBY?=
 =?utf-8?B?RjEweVlHY2p1eVlmenlpaEwyZ2tDODdFT29FWEpDWEVQempwL2dsUGxWUit2?=
 =?utf-8?B?dUNndzI4Q3phcHN0UGFnWlRpSjVBYnV6SjBGZGVuVnN3aXRBVHB4c3E4L1M4?=
 =?utf-8?B?R3phZHR2Q2JNSGRmY29IRVFLL3BhN1Irc05VQXFGREdhWk5nTWJJMkpyT1Vt?=
 =?utf-8?B?YUZKUGxHQ0hoYjJiR2xFL0VrMm9rWUN4VFRoYmhhQ2QwdG1NV3dlcW1JWWxt?=
 =?utf-8?B?OStKbUdETE5ld3VxT1EvRTExMG56YkJjTnVMZ1Rud05qMndnQm00NHBwODVz?=
 =?utf-8?B?MFRReHZ6ZENTQml4WW1CWUpQT0NpM2QyV1ZlL015RmtMSXQyU1BTWjhVZGNQ?=
 =?utf-8?B?N1pCeis2aGRHSklRUXpoQVpMeENCc1gzZlNteVpqTWtUR1RhaysxRHUzdVBT?=
 =?utf-8?B?b2dBVVJvQVNKaktHaVRtK3FMMk1sL0dTZEhka2Q2N0h2eTErb1hETEw4MXBw?=
 =?utf-8?B?NFZqWGE4UUcwRmFRaDBkZXl3Rmh5ZHVreW1vYzNEc3pVNGlmdXBhU01tWm1o?=
 =?utf-8?B?UnpCa2tUVVBIY0pIVWpkb0Yvc1o5WXVFWElxa0x4T01FOExDWk1VRXE3M3VU?=
 =?utf-8?B?U3RhWmg1bE9aanp0b2ZSQ1hFVjN0eXg5ZGJ6R0xvVWp3MXV2MzZOMis3RDhy?=
 =?utf-8?B?bHphNkg5di8yVUJyMUtSOGxuUUEvWjBtUkpjMHZ3NnBUWlliaXVPVkp5S3J5?=
 =?utf-8?B?MUJINFRxdDR6TXI1K3N5b0tqbDMzbDN2TU02QWhSNHRRejhIRkM1bnpqNnd3?=
 =?utf-8?B?Y0N1TEpLM0FBci9MOVdxYWpORm9HbVViMnh0QTNXQzVmcGFQOXBqbjRBVm9X?=
 =?utf-8?B?TWJqSklKQzRFSTJlTUVGV0tJb0dnVm51UnBybFJnYStEWnYxd1JmbjFheUF5?=
 =?utf-8?B?VExsSVFNc0cvY1c1eWNveXB1RTRPZnJPSjU1NjRzRm9BRDhZL3lqeW9WZ2Zm?=
 =?utf-8?B?emRPTENaS012YnhCQXgyeEwwekNDNC9lVG52UHRiTEFsUVBBU293TldMWXVl?=
 =?utf-8?B?c3pXOVBZQkZMTjNVYzNVa3FjUjRwb0svVWRpam9xM1VxVWY2ZThXMU9vaHhE?=
 =?utf-8?B?S1k3dWk1dFc5NUVkT3RQZlhGVW0xdmRCOXZaYlRSOFpMQ0NseEtIK2hNT2dD?=
 =?utf-8?B?eEhzaEpuQTZGYUFFZzJmdUExU3I0Vk14K2N5UzVjUUQyZDhtOTRlL1MvZ1A3?=
 =?utf-8?B?cTlxWFd1N0UwQ2JNZHFBWkVVSkRxMnNZV3dUdjdiUFhRNGxzdXcrOC9QUEty?=
 =?utf-8?B?ck5IcmxuRUt2Yks4Ny9CVDZXNVFYVGRKanVKdmhuT0U1RXZ5VFZ1eDNWeVpn?=
 =?utf-8?B?UTFNZXZ3a3hOcmJYM0lhVE1RZHY4UjZrNHBGQXFFTkdmNmFYTXZqdVNHYlZ3?=
 =?utf-8?B?SStFcXYxdFBreVRQODQ5L2hnRUdaald2Z3Qwdy9WZ2lpL3A4NzY4UmJybWJG?=
 =?utf-8?B?ajJrQW5teWhpbUwyRk9uWFN1Z3RSY0dyU3ZLQThtaGl6QVBKbjFodHc3UGtV?=
 =?utf-8?B?SURPUHdjamxNWUIrVktiNUNMUlRkRkVETGlEamVZZ1UrN0hiWFJuWHlZWGE3?=
 =?utf-8?Q?U/0w7Dtvq4UV/afr+KzAGIqof?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc59fb-cca4-4c09-b248-08dd47a7b931
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 18:46:24.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4Wx6SGFebbhEdjbiv0767OMT8HtGkzebiL+uwtPSjozQjyYvagS0YWWN16NyNno/SAHinMQju5g0Hmi70lO4v0GS4BnO3AZVYOlhdC0kNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPHJta0Bh
cm1saW51eC5vcmcudWs+IE9uIEJlaGFsZiBPZiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkNCj4gU2Vu
dDogV2VkbmVzZGF5LCBGZWJydWFyeSA1LCAyMDI1IDU6MjggQU0NCj4gVG86IFRyaXN0cmFtIEhh
IC0gQzI0MjY4IDxUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tPg0KPiBDYzogVmxhZGltaXIgT2x0
ZWFuIDxvbHRlYW52QGdtYWlsLmNvbT47IFVOR0xpbnV4RHJpdmVyDQo+IDxVTkdMaW51eERyaXZl
ckBtaWNyb2NoaXAuY29tPjsgV29vanVuZyBIdWggLSBDMjE2OTkNCj4gPFdvb2p1bmcuSHVoQG1p
Y3JvY2hpcC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBIZWluZXIgS2FsbHdl
aXQNCj4gPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0
LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIFJGQyBuZXQt
bmV4dCAyLzRdIG5ldDogeHBjczogYWRkIFNHTUlJIG1vZGUgc2V0dGluZw0KPiANCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudA0KPiBpcyBzYWZlDQo+IA0KPiBBZGQgU0dNSUkgbW9kZSBzZXR0
aW5nIHdoaWNoIGNvbmZpZ3VyZXMgd2hldGhlciBYUENTIGltbWl0YXRlcyB0aGUgTUFDDQo+IGVu
ZCBvZiB0aGUgbGluayBvciB0aGUgUEhZIGVuZCwgYW5kIGluIHRoZSBsYXR0ZXIgY2FzZSwgd2hl
cmUgdGhlIGRhdGENCj4gZm9yIGdlbmVyYXRpbmcgdGhlIGxpbmsncyBjb25maWd1cmF0aW9uIHdv
cmQgY29tZXMgZnJvbS4gVGhpcyB0aWVzIHVwDQo+IGFsbCB0aGUgcmVnaXN0ZXIgYml0cyBuZWNl
c3NhcnkgdG8gY29uZmlndXJlIHRoaXMgbW9kZSBpbnRvIG9uZQ0KPiBjb250cm9sLg0KPiANCj4g
U2V0IHRoaXMgdG8gUEhZX0hXIG1vZGUgZm9yIFRYR0JFLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UnVzc2VsbCBLaW5nIChPcmFjbGUpIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC9wY3MvcGNzLXhwY3MuYyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0N
Cj4gIGRyaXZlcnMvbmV0L3Bjcy9wY3MteHBjcy5oIHwgMTQgKysrKysrKysrKysrKysNCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9wY3MvcGNzLXhwY3MuYyBiL2RyaXZlcnMvbmV0L3Bjcy9w
Y3MteHBjcy5jDQo+IGluZGV4IDEyYTNkNWE4MGI0NS4uOWQ1NGMwNGVmNmVlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9wY3MvcGNzLXhwY3MuYw0KPiArKysgYi9kcml2ZXJzL25ldC9wY3Mv
cGNzLXhwY3MuYw0KPiBAQCAtNzA2LDEyICs3MDYsMTAgQEAgc3RhdGljIGludCB4cGNzX2NvbmZp
Z19hbmVnX2MzN19zZ21paShzdHJ1Y3QgZHdfeHBjcw0KPiAqeHBjcywNCj4gICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgaWYgKHhwY3MtPmluZm8ucG1h
ID09IFdYX1RYR0JFX1hQQ1NfUE1BXzEwR19JRCkgew0KPiAtICAgICAgICAgICAgICAgLyogSGFy
ZHdhcmUgcmVxdWlyZXMgaXQgdG8gYmUgUEhZIHNpZGUgU0dNSUkgKi8NCj4gLSAgICAgICAgICAg
ICAgIHR4X2NvbmYgPSBEV19WUl9NSUlfVFhfQ09ORklHX1BIWV9TSURFX1NHTUlJOw0KPiAtICAg
ICAgIH0gZWxzZSB7DQo+ICsgICAgICAgaWYgKHhwY3MtPnNnbWlpX21vZGUgPT0gRFdfWFBDU19T
R01JSV9NT0RFX01BQykNCj4gICAgICAgICAgICAgICAgIHR4X2NvbmYgPSBEV19WUl9NSUlfVFhf
Q09ORklHX01BQ19TSURFX1NHTUlJOw0KPiAtICAgICAgIH0NCj4gKyAgICAgICBlbHNlDQo+ICsg
ICAgICAgICAgICAgICB0eF9jb25mID0gRFdfVlJfTUlJX1RYX0NPTkZJR19QSFlfU0lERV9TR01J
STsNCj4gDQo+ICAgICAgICAgdmFsIHw9IEZJRUxEX1BSRVAoRFdfVlJfTUlJX1RYX0NPTkZJR19N
QVNLLCB0eF9jb25mKTsNCj4gDQo+IEBAIC03MjIsMTIgKzcyMCwxNiBAQCBzdGF0aWMgaW50IHhw
Y3NfY29uZmlnX2FuZWdfYzM3X3NnbWlpKHN0cnVjdCBkd194cGNzDQo+ICp4cGNzLA0KPiAgICAg
ICAgIHZhbCA9IDA7DQo+ICAgICAgICAgbWFzayA9IERXX1ZSX01JSV9ESUdfQ1RSTDFfMkc1X0VO
IHwNCj4gRFdfVlJfTUlJX0RJR19DVFJMMV9NQUNfQVVUT19TVzsNCj4gDQo+IC0gICAgICAgaWYg
KG5lZ19tb2RlID09IFBIWUxJTktfUENTX05FR19JTkJBTkRfRU5BQkxFRCkNCj4gLSAgICAgICAg
ICAgICAgIHZhbCA9IERXX1ZSX01JSV9ESUdfQ1RSTDFfTUFDX0FVVE9fU1c7DQo+ICsgICAgICAg
c3dpdGNoICh4cGNzLT5zZ21paV9tb2RlKSB7DQo+ICsgICAgICAgY2FzZSBEV19YUENTX1NHTUlJ
X01PREVfTUFDOg0KPiArICAgICAgICAgICAgICAgaWYgKG5lZ19tb2RlID09IFBIWUxJTktfUENT
X05FR19JTkJBTkRfRU5BQkxFRCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgdmFsID0gRFdf
VlJfTUlJX0RJR19DVFJMMV9NQUNfQVVUT19TVzsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0K
PiANCj4gLSAgICAgICBpZiAoeHBjcy0+aW5mby5wbWEgPT0gV1hfVFhHQkVfWFBDU19QTUFfMTBH
X0lEKSB7DQo+ICsgICAgICAgY2FzZSBEV19YUENTX1NHTUlJX01PREVfUEhZX0hXOg0KPiAgICAg
ICAgICAgICAgICAgbWFzayB8PSBEV19WUl9NSUlfRElHX0NUUkwxX1BIWV9NT0RFX0NUUkw7DQo+
ICAgICAgICAgICAgICAgICB2YWwgfD0gRFdfVlJfTUlJX0RJR19DVFJMMV9QSFlfTU9ERV9DVFJM
Ow0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICBy
ZXQgPSB4cGNzX21vZGlmeSh4cGNzLCBNRElPX01NRF9WRU5EMiwgRFdfVlJfTUlJX0RJR19DVFJM
MSwgbWFzaywNCj4gdmFsKTsNCj4gQEAgLTE0NjIsNiArMTQ2NCw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
ZHdfeHBjcyAqeHBjc19jcmVhdGUoc3RydWN0IG1kaW9fZGV2aWNlDQo+ICptZGlvZGV2KQ0KPiAg
ICAgICAgIGlmICh4cGNzLT5pbmZvLnBtYSA9PSBXWF9UWEdCRV9YUENTX1BNQV8xMEdfSUQpIHsN
Cj4gICAgICAgICAgICAgICAgIHhwY3MtPnBjcy5wb2xsID0gZmFsc2U7DQo+ICAgICAgICAgICAg
ICAgICB4cGNzLT5zZ21paV8xMF8xMDBfOGJpdCA9IERXX1hQQ1NfU0dNSUlfMTBfMTAwXzhCSVQ7
DQo+ICsgICAgICAgICAgICAgICB4cGNzLT5zZ21paV9tb2RlID0gRFdfWFBDU19TR01JSV9NT0RF
X1BIWV9IVzsNCj4gICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgeHBjcy0+bmVl
ZF9yZXNldCA9IHRydWU7DQo+ICAgICAgICAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
cGNzL3Bjcy14cGNzLmggYi9kcml2ZXJzL25ldC9wY3MvcGNzLXhwY3MuaA0KPiBpbmRleCA0ZDUz
Y2NmOTE3ZjMuLjg5MmI4NTQyNTc4NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGNzL3Bj
cy14cGNzLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvcGNzL3Bjcy14cGNzLmgNCj4gQEAgLTEyMCw2
ICsxMjAsMTkgQEAgZW51bSBkd194cGNzX3NnbWlpXzEwXzEwMCB7DQo+ICAgICAgICAgRFdfWFBD
U19TR01JSV8xMF8xMDBfOEJJVA0KPiAgfTsNCj4gDQo+ICsvKiBUaGUgU0dNSUkgbW9kZToNCj4g
KyAqIERXX1hQQ1NfU0dNSUlfTU9ERV9NQUM6IHRoZSBYUENTIGFjdHMgYXMgYSBNQUMsIHJlYWRp
bmcgYW5kDQo+IGFja25vd2xlZGdpbmcNCj4gKyAqIHRoZSBjb25maWcgd29yZC4NCj4gKyAqDQo+
ICsgKiBEV19YUENTX1NHTUlJX01PREVfUEhZX0hXOiB0aGUgWFBDUyBhY3RzIGFzIGEgUEhZLCBk
ZXJpdmluZyB0aGUgdHhfY29uZmlnDQo+ICsgKiBiaXRzIDE1IChsaW5rKSwgMTIgKGR1cGxleCkg
YW5kIDExOjEwIChzcGVlZCkgZnJvbSBoYXJkd2FyZSBpbnB1dHMgdG8gdGhlDQo+ICsgKiBYUENT
Lg0KPiArICovDQo+ICtlbnVtIGR3X3hwY3Nfc2dtaWlfbW9kZSB7DQo+ICsgICAgICAgRFdfWFBD
U19TR01JSV9NT0RFX01BQywgICAgICAgICAvKiBYUENTIGlzIE1BQyBvbiBTR01JSSAqLw0KPiAr
ICAgICAgIERXX1hQQ1NfU0dNSUlfTU9ERV9QSFlfSFcsICAgICAgLyogWFBDUyBpcyBQSFksIHR4
X2NvbmZpZyBmcm9tIGh3ICovDQo+ICt9Ow0KPiArDQo+ICBzdHJ1Y3QgZHdfeHBjcyB7DQo+ICAg
ICAgICAgc3RydWN0IGR3X3hwY3NfaW5mbyBpbmZvOw0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCBk
d194cGNzX2Rlc2MgKmRlc2M7DQo+IEBAIC0xMzAsNiArMTQzLDcgQEAgc3RydWN0IGR3X3hwY3Mg
ew0KPiAgICAgICAgIGJvb2wgbmVlZF9yZXNldDsNCj4gICAgICAgICAvKiBXaWR0aCBvZiB0aGUg
TUlJIE1BQy9YUENTIGludGVyZmFjZSBpbiAxMDBNIGFuZCAxME0gbW9kZXMgKi8NCj4gICAgICAg
ICBlbnVtIGR3X3hwY3Nfc2dtaWlfMTBfMTAwIHNnbWlpXzEwXzEwMF84Yml0Ow0KPiArICAgICAg
IGVudW0gZHdfeHBjc19zZ21paV9tb2RlIHNnbWlpX21vZGU7DQo+ICB9Ow0KPiANCj4gIGludCB4
cGNzX3JlYWQoc3RydWN0IGR3X3hwY3MgKnhwY3MsIGludCBkZXYsIHUzMiByZWcpOw0KPiAtLQ0K
DQpUZXN0ZWQtYnk6IFRyaXN0cmFtIEhhIDx0cmlzdHJhbS5oYUBtaWNyb2NoaXAuY29tPg0KDQo=

