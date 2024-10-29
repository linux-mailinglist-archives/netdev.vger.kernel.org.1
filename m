Return-Path: <netdev+bounces-139781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615409B411D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0F3283113
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0D1FCF60;
	Tue, 29 Oct 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GQQV8vxK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C0376;
	Tue, 29 Oct 2024 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173179; cv=fail; b=qn9DbQpuGtjxyInnGd51qU1v1XnIeMk0DSnp4AYwPlaz1w2EJrhZHkldBJlfFttpETXlV85q+j8d+J0XjpztB8DVejlXQ+DxAwsmaT13VSbOxctHEME6QyaiZ2L9JRcxzAK/HZLE1DQX+vndakh9H4WXsrK0rg5l+5kepl5kqZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173179; c=relaxed/simple;
	bh=DWEFdIgKk/7aKyTEwdMGAC+gjqpBVKIvZgqC+EnmPuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ybcc0q8LuhtVnU2wM96G1SczXf1RFCrOUo9f2AYcZ88vuXSH8UYZypG3BSPZMCg+MzF2iAa9Hq9IU04XdSkZ8PcCJhYVsB+EinwTtUguL79V/uNR9DfbfJsz7ZytJ/RPJHMIGVIOPxR1hQQoRfPj6myfb1MPiXoR3EeVPBElSUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GQQV8vxK; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQPClN5T6TIYC4/cEBPkeYa2Aks28HOSbXrlFgn/byoUgOrD68DbBzVoav0VZwZZo5asPkjX8Z0SYRN8YKNF1r/8xLd+DWwxy3VQaY7KOZ6v5F3xhL3jAh8XMb7ETDu6VYOtOeazeeHX4pvB8z4qYMK+yCxoA3Uxd5rvNJ8fA3OhMNlgOSqJwwcm3zF+DZwBJbg+tLKn+YnwjvTnw0qZjyh7n2l9bWvSUsFwNCjkq75F88pjA3B4p3pY8Y2FpnedYSACv0+swE7fE5hK0R1Sz/zQatAnIcMnO8RvE/QD/48ZCF/MwbKHXkJ2CvVfNRWIrB7xLVeheK7i/zEnSDjFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWEFdIgKk/7aKyTEwdMGAC+gjqpBVKIvZgqC+EnmPuk=;
 b=E0VYO24GoP3V54M+0DUj69uxE5VlfdDlieJ+L0tTdjidVRFxjRhSrTE7bZm1xxARUJQaAJ//wUsIRH7SEQxLNQRKVIpM+hxIn8h1MUw/aNt28wnKjiMj44u5My7upEjiZJ0yw8nLrBL9mS+LOb91GLXYysBGHzsh682jJxNqEel3eFtXgoTRGlIXOJHhZDnJNyJtuID4mt8eS3PRXi6635M3uPEf3PyBrI3XwgkasPeFBhuJvB7v8R0jgHAVxTmkttiVXGv5TAD/b2xgEHrFie/ry+rrSqFB/eQUsISTZrE0UAh838GFsnuJNtJ4SHnlMGUE6aBerN/8XP7BJdyqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWEFdIgKk/7aKyTEwdMGAC+gjqpBVKIvZgqC+EnmPuk=;
 b=GQQV8vxKCNRD9XbRIwCM13jqUDov647h31ZPls/nPEloIZlACvqmYk9+S5ueOanR7DBjKJiTa39k+uRw+P9+r5RyV5BjRd7RBf/fsOkzFmkfEFuE6IPhb3BJe8Ni3d7w29UO8juK3AIX5UnR0d7Lf97ogzXSv/FUiQBzZvh8/x41sRohZyZafo8JmLtAdw/eUOAjBJZ19iKSOUUaGDeL9ab+T+Pj77YzocOJftMrIogCenxddEXdJHGNm8CCGUH+lnoFeX4AyG7B0iQM69tb2DE4GELD6HASOnlt3LD3xoTalv0IvaOX3cRG9oPBZJ/OToU/O9ixs8WFPL8eJ6iNNA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CO1PR11MB4897.namprd11.prod.outlook.com (2603:10b6:303:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 03:39:33 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 03:39:33 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <robh+dt@kernel.org>, <pabeni@redhat.com>,
	<o.rempel@pengutronix.de>, <edumazet@google.com>, <f.fainelli@gmail.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <kuba@kernel.org>
CC: <linux@armlinux.org.uk>, <kernel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 5/5] net: dsa: microchip: add support for side
 MDIO interface in LAN937x
Thread-Topic: [PATCH net-next v1 5/5] net: dsa: microchip: add support for
 side MDIO interface in LAN937x
Thread-Index: AQHbJ3FVGzBs378aC0G4iTQjWvDQ3bKdGkWA
Date: Tue, 29 Oct 2024 03:39:33 +0000
Message-ID: <6eeb92d0791a1c0c77d57c74c85990d1cdeb355d.camel@microchip.com>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
	 <20241026063538.2506143-6-o.rempel@pengutronix.de>
In-Reply-To: <20241026063538.2506143-6-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CO1PR11MB4897:EE_
x-ms-office365-filtering-correlation-id: b58911d4-f2a4-49e7-0353-08dcf7cb4d86
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjZESjkzYWNiWjg2cFlFOEt5M3V3VXUzbW9TTFI5U2FiQzNNcjVlQng3aXdN?=
 =?utf-8?B?d3NGZG02a0ZQUDdyRlpseXhlTTc5cFNmVGwyYUhFSElxQmhhK2V3WnhUQmdv?=
 =?utf-8?B?T1lzTU8vcytMQWpxVWFCOUNyRDFIdHFuWGQ0TWZDSmpqMUUzYVMxaW1vSTJM?=
 =?utf-8?B?amt6MTV4Z0FGVjNqMEpDMDFVeGdoZ25SRXNIV1ViMWRjbHJnTXg3R2F6bzF2?=
 =?utf-8?B?d2wzOFZCZ0JMaTN2cWYwaFFDejZmM2hFK0VXSi9zdUFoM3lFRTMxSWhROGFJ?=
 =?utf-8?B?c2dkSkl6N21GUHl4b2h2WWhNSmNwb2V2RFZwbVg4M2pBUUUrVUVWYTBHeDVX?=
 =?utf-8?B?UW9qV0ZOS1EwZ0pFbjIwdlFvQ2hJMzhRMnhOZHJRdWhhM2UyWERjRnpjV3Jv?=
 =?utf-8?B?RVRyMm1oRkQ0UWQvb3J6QzFKZUU1NGpPVVJGSVVJTXd5bFVrMC9DbnJBR2tE?=
 =?utf-8?B?UzFHcUZCMFREUE9hUTUxNERncXFGVTlJUzNITFc5b09oY2c3TUtqVFEzWnZu?=
 =?utf-8?B?WUtUQXhMN0poNzlhTzgzd3pwM3BiZWh6c2F5SDh0UGg2Uy9QZ3FWM1BuZG0x?=
 =?utf-8?B?RVJFUkJBU0FwSkVIUVpuS3VyZklVWHd3Y1o0OFJveEwwSUJRRjJGQjNmQTlY?=
 =?utf-8?B?RFJLOSs0UzdwVjROVXpRS0F2RnZsVEgrNDMxNS9ud1c3NWIwYVlSZ0VuTldL?=
 =?utf-8?B?VUJLTW15S2JPSm1TQ1VjdmRYcGJEK3VtdnpvMGN2eVg4ejgxN05zd29Bd0Nv?=
 =?utf-8?B?SUVSOTcrUDFwSXo4WmNKeVFwbXhWTldGZW1NL0xFa0ZPZ05zQkhEQWgvOVN5?=
 =?utf-8?B?cmFzWUVwRjFwdTVRVXk4cHFBWGI2UGZaZnQwYTh1UEdhb2dTaUVlZ08rajJI?=
 =?utf-8?B?T3NVSVhaODh5bDAwQitEN2l6L2RiU3I5aWU0RTFlVGVrNUhIaUFLd1dPS3V0?=
 =?utf-8?B?REJsUXpLVDF3d2xiWXBjN3NiV0hJSFk3cEZGSm9rOVBtUmR6aEVPQWIwTkpy?=
 =?utf-8?B?aisrTkJhYnQrSjhOeDczK1N2RHgvT210Q2FrWTZlcTk4c2tBNjZyVlZIMnla?=
 =?utf-8?B?YTNCcUc2Umw3a1RaUVpOZXdxN1pGOGZCYjhvM0IvZU55L2ZnUWREZXczQ1RK?=
 =?utf-8?B?L2FLREFvak14NWJDRHlReEhGN1JlN1VIbnZlZFFlckNTVUNGVStjS1g5UTdC?=
 =?utf-8?B?UVAyL1Q3KzVVYjc4N1RQYXNjSEJuTTRmU1BGR2I0b1ZvUG9yQ0ljanlUU2ZY?=
 =?utf-8?B?cVh3R3hZVWpnTDNMT3ZzUzBNVm84MEtlaWE2UDllQmRGaDVuT3VtTnFJL1Nr?=
 =?utf-8?B?VGUyT0xXenlpOERSL0I0NWxMblFrbFcrblh0a1NyS0h0cjQ2SGxlSEQ4WmV0?=
 =?utf-8?B?UVdPWXl2Rnp2allMRTY1aFNhdzMzaDlDTUR3eU9VN3VaRlYzWVRPOFhuSHZw?=
 =?utf-8?B?L3dJM0lIVnhNM3Rnby81TWRtdGFwOU9WN05PMnQrM2dDbkRiUmRDWFJta3lX?=
 =?utf-8?B?M0VwOHVLcUVOdlR1cSs5SzBPeXJvaGQ0V2VjOGJ2TlozNjZ6eW1HZG1maEJN?=
 =?utf-8?B?U2VhbndoZEZhdVMrUHBnTUxhRUJWcC9aN3VxMmRtdldtMnp0c1czSWxGUGRU?=
 =?utf-8?B?ZUUycUJPWVYxOWE3N1dyZHVDUlpaaVY0aXpqR201Qlh4NFNjR2NvODErWjJF?=
 =?utf-8?B?dFdVdWpwQWtRWFZTOGtzY0N5MzRZbzdiZE4xWlpEemo3R0V3dEEyQm1WRU1n?=
 =?utf-8?B?VWdNNlhLOXkxQTV6M0NjdzZFeXNBdTB3UjNJTGJKYks0akdrTTdyQ3psUmQy?=
 =?utf-8?B?cUhiVVVPT1JKRGh1Mk42SVBHQmw0eE1sK0VZeUNBeVNIaGV4anhDdVlGRDIx?=
 =?utf-8?Q?56MjE3ULMCL3F?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU5JU3RwZUlTdWEvQkU2em4xWUN2bExDTXZEOTVqdXZmWGo2bTk5bkkyQklp?=
 =?utf-8?B?cExqRTFZUG9vbjNBRXREVThkL2pzaUtvSkNJZitrOUVyNjYzWkVPVC9PTVUw?=
 =?utf-8?B?SmdxMkh0YW9FRzhDK0pnWEV2WitFTVJxeVc4aXo4SWYvZHFTZXFLZUFoUC9D?=
 =?utf-8?B?T3BJR0hoYWRTUG41dmQrZm5QR2JpNG5QL0NWOUpJa2ZwWUE4RUNPR3FjaFlK?=
 =?utf-8?B?MmpnLzJhOFJqcnFwN0J2QXc0Z3dYVGlRaWJUbDJPUTE0TDFtOFhHNnMxNTVa?=
 =?utf-8?B?Rnp6b2FrZ0pGWjMwNkZxTnh6UFkzYWZFaUdBOVNuTGsvOFZFOUYyMHkzT0x6?=
 =?utf-8?B?bVJNRVVVaEJlbGFIWEtpWE04Si9ETDBTNjdER05kN29uV2FsZmZ3aFM4RkZx?=
 =?utf-8?B?Q1M4NmFtMmhCOWFyNUFORHZ4VjFyVGdFUmQ4ZXBHL1Rqck1GMCtjM2Z4cXE5?=
 =?utf-8?B?R05tV3pMazBldWk0YTd2NEF5bU5oS3N5eEt6amViRzVzM2tFTDdRYldvMUhM?=
 =?utf-8?B?NXZlM2g1Q0FJZ2VyQzNQTmtZbVFiYTZwUEMyNUdqUEtEa2tVUE9IdC9RY1dJ?=
 =?utf-8?B?MlNPNkdwOUdUZ0lLTDM3SFl6YWFPSktMSXhJdElKaTBBYTBacm13ZjFHaVlF?=
 =?utf-8?B?K01YNTdHRWViNFBWblcvdjQydnZwZFdHMkxuT1N2M1ZUbnl1QVZEU25PUVFL?=
 =?utf-8?B?Zkp6MHVrVlY2SFJ1eTFYQmZySVVUdFdtWEIwc0R4ZEwrQStBNWYxc0dtTXQw?=
 =?utf-8?B?Z0dJWTRHQVhnUkR2YmNIcDlQU1hrS21TTzlRbTA2THdQMlg3aUgrYnBkeDhO?=
 =?utf-8?B?b2NBTWNzL2JQQUJmakdtd1lzaldZZDE2akdWN1J3YklxQVZpQmZaMk9iT1RQ?=
 =?utf-8?B?QmNGZVNhb2pZRlgxQ2lyQ2VzWklLVEpZR25QYVBMVURhTUxFSStCU1dlblZr?=
 =?utf-8?B?WHlLWWNadVFLQkNmV21HTkZoTkdxVEZuYXkxWDRaSEFHU1J5ZXFDM3pTTlc4?=
 =?utf-8?B?elpjYXQzL0hlcDd4ODZZa1daYnhoQTBCd1NrbUREakFUSGNEZE95MVBoVGxk?=
 =?utf-8?B?aEhqVWlrT1VjeThmRm5udTd1RDU1SHAxWDF6RHVBbTZTclV6aXZGL0o3Lzk0?=
 =?utf-8?B?bHJyWHpFNWdxWWdoclk5bmE5Q2tORlBaekQ1OWNLUU9uUlg3TVJXVFRCZkMx?=
 =?utf-8?B?WHdwUmVaeVVxaUwrMU1xT3AzVXNVbldUaFFZR3FzMGhRa0R3Y1BBR3d0VEFV?=
 =?utf-8?B?dUpTM1k0bEtUWllub205T1FoK0Y0bnBReXVnZlV5WUNTMldjRkM0SHh5NDkv?=
 =?utf-8?B?R1lNNmpmT2szbFhMK01WUExGVzNNbFBDaWhKeVl1Q3pxMHdLMXRmK1NSZ1ho?=
 =?utf-8?B?UUJEd3l6MTV3b2g5ZDdHOWNLa0VGK1NQK0d2MzZtWlgwUC8yK3pXdk9YK1Ar?=
 =?utf-8?B?RDNvaU1tREhoa3Zna0R5RlBHVHdRYlR0U3c2Njc4ajFZSTdGNkZseVdyL3dP?=
 =?utf-8?B?ek5YTmlkdVdhSUt6RDZBQWFpRkZVMEp6eUROMEdIdVhsczVnZmpOUlVmSUF4?=
 =?utf-8?B?cVgvUWlLVEJ6UW1FeEdBYUZoRkxmTE9xcmxPZXNtdlpnRXdPWitIVVNRbUVU?=
 =?utf-8?B?V0x0MHBxYlF6c0dHV3doUTVDWXJGRGlHQWVSclNCNk8wYVdmRjg3bkpFTDFQ?=
 =?utf-8?B?Z0JXZjN0WnBNRjZpMUpuMFdQeXNiM2NKTnFMN2p2bFYrZEdlMmRoRTRpenhC?=
 =?utf-8?B?eW9NNDNiaUV0MUljeTQ4KzNPb1g5SXhDdW5uTHJWb1RuRDBycEM2M21ja0sr?=
 =?utf-8?B?cjRwaVhSS1NOcHhWOHdGLy9lQkVMYUVVdG1YOU8xdG1KZy9wdDJ6VFl5M2Z0?=
 =?utf-8?B?Wmo5MDBpMGNtWTV4WnN5NlZyaXFvcllBMlJCZ0czZ3lJdWxGRXZJay9YZ09N?=
 =?utf-8?B?WVg1Ty9JbUFiMjlQTmtDS2FmcktCV2R2R1Fja0ZockFCQzBnSkttbzNvQUZJ?=
 =?utf-8?B?aURHVHhGK3RWOU44dktmVjVCVElDZGNSZnY5cUhRUnQzYk5oT082SDZKUDhF?=
 =?utf-8?B?S1FDRTRtOE1GamNVeDgxNFI1V3QwNEdKbHpMMkhKL09KWjRlOTI4eGp0bXAx?=
 =?utf-8?B?ZzkralZHTHdKV3d3ck93MzRBeHE4Y1RuOVRyRlhjdlVtWHFYZlZSbmE5RGN4?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86638537D31B96479708609909379E50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58911d4-f2a4-49e7-0353-08dcf7cb4d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 03:39:33.0238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUStp49ehX2g2KQTm4ZpDe1EGjnAKc1Ip6DyDMbM2v+KRgVnM+BEpt5xnex0rRWEXJajrWxL83Syn2qVr3Rq4RI02cJF2ywW6m3Z2+rk3Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4897

SGkgT2xla3NpaiwNCg0KT24gU2F0LCAyMDI0LTEwLTI2IGF0IDA4OjM1ICswMjAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9sYW45Mzd4X21haW4u
Yw0KPiBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAvbGFuOTM3eF9tYWluLmMNCj4gaW5kZXgg
ODI0ZDkzMDlhM2QzNS4uN2RmZDIxZDBkMjg0MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZHNhL21pY3JvY2hpcC9sYW45Mzd4X21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbWlj
cm9jaGlwL2xhbjkzN3hfbWFpbi5jDQo+IEBAIC0xOCw2ICsxOCw0NyBAQA0KPiAgI2luY2x1ZGUg
Imtzejk0NzcuaCINCj4gICNpbmNsdWRlICJsYW45Mzd4LmgiDQo+IA0KPiArc3RhdGljIGNvbnN0
IHU4IGxhbjkzNzBfcGh5X2FkZHJbXSA9IHsNCj4gKyAgICAgICBbMF0gPSAyLCAvKiBQb3J0IDEs
IFQxIEFGRTAgKi8NCj4gKyAgICAgICBbMV0gPSAzLCAvKiBQb3J0IDIsIFQxIEFGRTEgKi8NCj4g
KyAgICAgICBbMl0gPSA1LCAvKiBQb3J0IDMsIFQxIEFGRTMgKi8NCj4gKyAgICAgICBbM10gPSA2
LCAvKiBQb3J0IDQsIFQxIEFGRTQgKi8NCj4gKyAgICAgICBbNF0gPSBVOF9NQVgsIC8qIFBvcnQg
NSwgUkdNSUkgMiAqLw0KPiArfTsNCj4gKw0KDQpJcyBpdCBpbnRlbnRpb25hbCB0byBub3QgdG8g
YWRkIHN1cHBvcnQgZm9yIGxhbjkzNzEgdmFyaWFudCBzd2l0Y2g/DQoNCj4gK3N0YXRpYyBjb25z
dCB1OCBsYW45MzcyX3BoeV9hZGRyW10gPSB7DQo+ICsgICAgICAgWzBdID0gMiwgLyogUG9ydCAx
LCBUMSBBRkUwICovDQo+ICsgICAgICAgWzFdID0gMywgLyogUG9ydCAyLCBUMSBBRkUxICovDQo+
ICsgICAgICAgWzJdID0gNSwgLyogUG9ydCAzLCBUMSBBRkUzICovDQo+ICsgICAgICAgWzNdID0g
OCwgLyogUG9ydCA0LCBUWCBQSFkgKi8NCj4gKyAgICAgICBbNF0gPSBVOF9NQVgsIC8qIFBvcnQg
NSwgUkdNSUkgMiAqLw0KPiArICAgICAgIFs1XSA9IFU4X01BWCwgLyogUG9ydCA2LCBSR01JSSAx
ICovDQo+ICsgICAgICAgWzZdID0gNiwgLyogUG9ydCA3LCBUMSBBRkU0ICovDQo+ICsgICAgICAg
WzddID0gNCwgLyogUG9ydCA4LCBUMSBBRkUyICovDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29u
c3QgdTggbGFuOTM3M19waHlfYWRkcltdID0gew0KPiArICAgICAgIFswXSA9IDIsIC8qIFBvcnQg
MSwgVDEgQUZFMCAqLw0KPiArICAgICAgIFsxXSA9IDMsIC8qIFBvcnQgMiwgVDEgQUZFMSAqLw0K
PiArICAgICAgIFsyXSA9IDUsIC8qIFBvcnQgMywgVDEgQUZFMyAqLw0KPiArICAgICAgIFszXSA9
IFU4X01BWCwgLyogUG9ydCA0LCBTR01JSSAqLw0KPiArICAgICAgIFs0XSA9IFU4X01BWCwgLyog
UG9ydCA1LCBSR01JSSAyICovDQo+ICsgICAgICAgWzVdID0gVThfTUFYLCAvKiBQb3J0IDYsIFJH
TUlJIDEgKi8NCj4gKyAgICAgICBbNl0gPSA2LCAvKiBQb3J0IDcsIFQxIEFGRTQgKi8NCj4gKyAg
ICAgICBbN10gPSA0LCAvKiBQb3J0IDgsIFQxIEFGRTIgKi8NCj4gK307DQo+ICsNCj4gK3N0YXRp
YyBjb25zdCB1OCBsYW45Mzc0X3BoeV9hZGRyW10gPSB7DQo+ICsgICAgICAgWzBdID0gMiwgLyog
UG9ydCAxLCBUMSBBRkUwICovDQo+ICsgICAgICAgWzFdID0gMywgLyogUG9ydCAyLCBUMSBBRkUx
ICovDQo+ICsgICAgICAgWzJdID0gNSwgLyogUG9ydCAzLCBUMSBBRkUzICovDQo+ICsgICAgICAg
WzNdID0gNywgLyogUG9ydCA0LCBUMSBBRkU1ICovDQo+ICsgICAgICAgWzRdID0gVThfTUFYLCAv
KiBQb3J0IDUsIFJHTUlJIDIgKi8NCj4gKyAgICAgICBbNV0gPSBVOF9NQVgsIC8qIFBvcnQgNiwg
UkdNSUkgMSAqLw0KPiArICAgICAgIFs2XSA9IDYsIC8qIFBvcnQgNywgVDEgQUZFNCAqLw0KPiAr
ICAgICAgIFs3XSA9IDQsIC8qIFBvcnQgOCwgVDEgQUZFMiAqLw0KPiArfTsNCj4gKw0KPiAgc3Rh
dGljIGludCBsYW45Mzd4X2NmZyhzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCB1MzIgYWRkciwgdTgg
Yml0cywNCj4gYm9vbCBzZXQpDQo+ICB7DQo+ICAgICAgICAgcmV0dXJuIHJlZ21hcF91cGRhdGVf
Yml0cyhrc3pfcmVnbWFwXzgoZGV2KSwgYWRkciwgYml0cywgc2V0DQo+ID8gYml0cyA6IDApOw0K
PiBAQCAtMzAsMjQgKzcxLDk3IEBAIHN0YXRpYyBpbnQgbGFuOTM3eF9wb3J0X2NmZyhzdHJ1Y3Qg
a3N6X2RldmljZQ0KPiAqZGV2LCBpbnQgcG9ydCwgaW50IG9mZnNldCwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJpdHMsIHNldCA/IGJpdHMgOiAwKTsNCj4gIH0NCj4gDQo+
IA0KPiAyLjM5LjUNCj4gDQo=

