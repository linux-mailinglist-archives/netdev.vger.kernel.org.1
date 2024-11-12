Return-Path: <netdev+bounces-143996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5649C5098
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AD41F22EF9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05D420B804;
	Tue, 12 Nov 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1nq7Ih1F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9220B80B;
	Tue, 12 Nov 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400067; cv=fail; b=Ps31lrNGhwR6oqduoq/AYyAfeFc8TaJOwnxoDCS2AHgIrRieIW1DjEBezv9blQQe0WxZ4WuZIvbZyVFkCK6zkzQnRTcP/EW8/3xPTAZmnNEGqXgsjAO7Du2OU+1vBVaMUPS7eNnN8QIIDAc7nifm2Vf5feDwZthQiV5OLiHR9iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400067; c=relaxed/simple;
	bh=QNh1LQdSU7EEPG/rgQTYwx3yo1t/uWbK1X+RmSEGR3c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNfk0bwzNAlBf3rlvDHCNqyGfw+PkWzLQTV+BzZZMlXix+dMVEbUNlkYJ5h8hvAq+DyWIm3eTf8EABh3Qf2CwGwGIhgZTAbrFyAksZIDRN/YPVD1woEAOIg7HEwyAxN3irtodVYg+9ryX+g0pyVYFbUPwQnGXOdmQFP05d4r/2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1nq7Ih1F; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAvZJsBtjni9+D2CCNL2SxuKEQM2cJLqg2+ORsWjdf1OFng2KrjDcn3QY8/BIEprTEJ8CkoFT3N8yPXF856xWIj8j3+SlmM4ZdPqFPd+M3F38RLGw7vPoobf76INXn3MCW7G7B43EgqjdXGWaXAa5nZTYcOQC+U1tV8aRwXB0eP5Btap44IQfoGh6rC0erpwXp5tvugnt3ZKCuLcj0Xqk6CuIPs4wtKAbEfnQ9geLjm8phl29sLz5Q0iX43HGBFGrIeu8E8H5PVoviX+koTxPNX3rYxfq7pq2BErK7/tubn9fIIFrM3TIedgh6GSLTyKgFO6ZCLR/6dtEIO6Pq19iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNh1LQdSU7EEPG/rgQTYwx3yo1t/uWbK1X+RmSEGR3c=;
 b=RoKYXMtMTiQRecuNojwko+XRWrXn4COMQtLZfZ/K7akwkTlvS1/BMUW4UnKouo1giODX02XM8t/QewrdL/xxIKCW5FR2wzEn+69cctg0zVcaW0Pm/tchfsRuszJTI1RYURwP1OyvA3Se9RlPNf7RsB3HkLMXAscrDZaErL24n0i7MeF5Ot4ITvsIsHNR4AeziqUxDV9EqSKR5AFeP/q5nza/wOidwlHPXwAi07DlWD9CCAxTCzuIW0iJ8HnBqitR4CJ2LxdWOMrcBKAUoBtEuLTXHr7/G8ngep5zjOJvg70V7ffoY2OaeM5/nwZeBC+uJxO7iST9qZfsgy4c0ZWGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNh1LQdSU7EEPG/rgQTYwx3yo1t/uWbK1X+RmSEGR3c=;
 b=1nq7Ih1FKA3ntP96MIxNhl1oemy/ErH2NyHIge/LezbKWbYgWTvk5mAJKc0xsLDI90Pms+ddl89Um8jkFoE9p1jPRf4Nv+D3tXXVM8rWjOhzLeBxkjOLrhn1B3qI4ZqHm+9x7lakkEojr8eKcqwgzB9HVEKR9QqOL4yLXUAl+XBs2Es7+Hn4I5EQk5pvVR8JuE84seGFnKt0LSt7ZioXFHEdlqbYcTXYrsTW/jPVYsotaUuie6ngLSCDKLuvzp/jHUgHz63YdYlAsViq8Bj1zkrziW8BOjPgAZ0W7UwNpoVPB2mYa2b8cO+SaCqxgQ7V9Gng1kLfvbQz1UuOz9qaHg==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 08:27:42 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 08:27:41 +0000
From: <Divya.Koppera@microchip.com>
To: <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>,
	<Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>
Subject: RE: [PATCH net-next v2 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
Thread-Topic: [PATCH net-next v2 2/5] net: phy: microchip_ptp : Add ptp
 library for Microchip phys
Thread-Index: AQHbNDl9boBjEFE09E+Q4ty+aEss87KyFmaAgAE6CWA=
Date: Tue, 12 Nov 2024 08:27:40 +0000
Message-ID:
 <CO1PR11MB47717F2BB311C7F40B5B388AE2592@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241111125833.13143-1-divya.koppera@microchip.com>
 <20241111125833.13143-3-divya.koppera@microchip.com>
 <e9312a77-80fa-4915-b2a9-2dcbfcf581a4@linux.dev>
In-Reply-To: <e9312a77-80fa-4915-b2a9-2dcbfcf581a4@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: vadim.fedorenko@linux.dev
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|MN6PR11MB8196:EE_
x-ms-office365-filtering-correlation-id: 9f5d2ef6-dd6a-4c51-4bba-08dd02f3dfbf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rkw5Wm4wNlJJeFhmaS9UdTBRd1BITWZMNXdXQldLWGU5YU85dDBEUnI1V21a?=
 =?utf-8?B?V3ZGYjEwczFUTlFPM1BoeWwxWHh6UVFYRmRHcXlHOXc2ZHQvVFpmYzhGZlVL?=
 =?utf-8?B?U3lDTmhCSjZ3UVNxZzIrYktkQmE5SENxdTV6VEZ1MUFyeTl4cVFGLzNXUG1K?=
 =?utf-8?B?OVRscmVqSlh6M3dMMjV2Qnpob2hsaldYRE40NzIyTi9vRVFHdE91bGttd3NV?=
 =?utf-8?B?YVlHKzlEUDBISytUT29oWDVLTjNvV2lQK2ZtNE1PK1UwRllPeHh2WmRVL1B5?=
 =?utf-8?B?bkhpamZaemhNQWpST28vMC9xTnNZcmVJeFd1UklDNmhKOWdqaGlweEhLNDhK?=
 =?utf-8?B?VVl0NHZOSXdmRGNHb3MxSVNvbG10OXNzSDVKdE9vVVhKTVl5dUQrb01vVFNU?=
 =?utf-8?B?Q1Y1YVpUaElKaUdiZHloTUp2cEJiY0JkTEo3TFhVU3RnWTR5ODFlVENHUjNX?=
 =?utf-8?B?WTFOaGRZQ3MzdEZaS2NqRlVDdldlTnRiL01YZ2tRbDZJelh5djFiNFYyeWlW?=
 =?utf-8?B?SXp2NXhHckpXa3gzdWwzMHE3R3VHdkxmOWhFcFJwckZ6WkorUDZNVnN1WjJn?=
 =?utf-8?B?TThWVlg5NmpwTHZTTGlJWTROaVY4U3YrVlRVb1pLN0UvZktJWFRmTS9qTURt?=
 =?utf-8?B?WHl6MHZ1Sk5GWUF0WE9YcWRDYXV5M3RvRDFMa0xJZ2ptWmJmc2VrSVF2bmx5?=
 =?utf-8?B?VUdRWVdxS0xmcVlMb2J6VnZGMHdqVVh1V3hZckRoMFZka2RCcm9MVHhXQWpw?=
 =?utf-8?B?bC82NWpnU3VmR3JDVkhrb2pmeTFnSndqTzhDTkZZaERteUdnUDN1NldUVnFh?=
 =?utf-8?B?R3V0ZmxTQUNnQy9OZHowNzh5R1VIaGFnb05OOTl2TXcxYUVwWnhNTytYQkpa?=
 =?utf-8?B?WUIwUlZESGRPTmRETFhYYjZmOHorOU9OdlJZTEpnMndvSnRpYmdqcThlU05j?=
 =?utf-8?B?bkd4ZmdVSk9uS3ZoWDJudzFrNVdUNGtUczVMeVg5WEtZQ1NvM3dyZlRsczAw?=
 =?utf-8?B?T3c0WURackpBSlFSRXVoQWpnelBSMWRWM1A4U0JsNVV5YmhaQWlJS2ovQ3Qw?=
 =?utf-8?B?emNWVStoRnIxU1RBZER4U045bjE4azdDTW5xUG0xeFhweVVyL3cydFVRbWxi?=
 =?utf-8?B?WUNZSi9sN3VJOVl5VE4wbVlpTVB5Q21oNWFuOFJaT0QrNHdnMmZ5c1Q3bHlF?=
 =?utf-8?B?R2srZ05lSHAxaTV3eWJtVUd1aHBjUEVBV2M4NXVLYUhGZDN3WUZLTkJxdW1E?=
 =?utf-8?B?UmJQSGtabVlyOHpKMk1XWE1qaXNISzlHRnV1OTF4cFdaMURuVTF6OEhFNlN1?=
 =?utf-8?B?enBtU1RTd2dzeXVWL1QrRGN4L1l0YW84M3ZBc2tlWkRidk1yVk82Z0lpWWtD?=
 =?utf-8?B?WmEzQmo0N2hXcm0zUXpFcHN1RllwanBVUTRoSkZMRHJ2RDV6ays0UzNUZGtV?=
 =?utf-8?B?cEdsY0xlTkgzU0dxcVA5OGVZU1M1OTFRV1BidUpOQmh6NVd6aDVJVnI4Mlhr?=
 =?utf-8?B?TFdUYXVmbGpnWWNsZlh2VjRFaVFhM3pCN0plbm8vdS8zb2FMZExwOWo2Z2pW?=
 =?utf-8?B?ckRLeU8rMERDalRRS1k2T2RKRkxvblFzREY4WkpyQURpOE50dnppZHVSN3Bn?=
 =?utf-8?B?enM3Qi9IYk9iTEJEbDVvczMzN3dNeVJhMFA5Q2lPVG5KaURvZEZBTXNDOEx4?=
 =?utf-8?B?aGFLaG5FdllnUlB3RzQ0VTREaWNUQVh3bVFoUER1UWxTcnpSUEU2aHBPMGV1?=
 =?utf-8?B?SDZsN2ZsV1FTMTV5eVVkOE1UVmdERHlmWGJqcC9oTzJQOGxBTmJFVDJqblk3?=
 =?utf-8?B?Z1NBL3hQRTZ0TTlTTG02cERMSW5lTUU1OFFHZUo1ZnBqRjg0VWhxSGtWcmty?=
 =?utf-8?Q?4tjcoY68lt3nN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3dLTnRpa1M1T2NUcTBuK2FzNGpUcHRiUTU5a0lRQ292MG5KVW5Baks0dVoz?=
 =?utf-8?B?YllUQkZOSEtqZ0dGbXVpY2sxSGtsQ1k2RVh0U1dCYmxNYXBHVG9lVngwbGRl?=
 =?utf-8?B?aXA4YkhzRm1VbTlzS2dLd3E2VDk0ZFF3S25OUjUvNDlKc2pHVDRuK052ZWlP?=
 =?utf-8?B?RFVPdVhHaEdJaUREYWpDUnBmQVNXQUt5aUJlSytCMEg5OVlDUjlYYVhyZmhI?=
 =?utf-8?B?NFhhNmtsSDh4MkRHK1ZUU0xyN2E2Tnc3TFdNczdHUHFNSVJleXlSeFljcHA5?=
 =?utf-8?B?SHN6cDhVZm5EdHl0bXZTbWx3REtiOExKUmxNemw2a2luUVpjSFUya2I0aVJr?=
 =?utf-8?B?U29XZC9rZkY1MTVta0NnTXJVSU1BNmFJS2k1TmhOVHlKNEZrWEtZaEFRRUwr?=
 =?utf-8?B?UzdXMjJhZ0VzQ25qZlhUbHMvZTNHYjgwZmtMOGc3MXlyOTBEWHpZS0t6M3ow?=
 =?utf-8?B?K2wyTnNOaWpqN0wrNVQxaUd6NWFYR2JDaEpmaVBKUktDRFBRRTNyTTBrbzkz?=
 =?utf-8?B?TjZzeGtQOEloMWM4eTlpUEc1OUIzRmQyUnA2TW94QTVrbCtXKytpNmJkZlZp?=
 =?utf-8?B?eHpmcUoxU0dmWkJYRlcyVE9vc0VVNjFCKzBOb1g5TGhyOFJQRG8xRXJ1VlZv?=
 =?utf-8?B?K0doOU9VcSs1Z2ZaYTRBL1N2QUdZYk1pVm9YUmxiWGh2YmVERVRZZWEvbUxB?=
 =?utf-8?B?eERTaW5sTDY1Nmg2SUk2emE3TGxueVpJSWFNdHBMSUpFNnQyaFdHTEZPNWhD?=
 =?utf-8?B?QW1VQlJoL0JHdWN1NmtjL2d3YnVIeVpTWGJuUHZuSzd4OWFEQkJGdEtRa2Vk?=
 =?utf-8?B?WjAvOUJ4clVid1BGL3J5UUJGTTFCMzhDakt3UXJhWm1heDNpN3p0VVJHWTlp?=
 =?utf-8?B?cVpjRkhGZFVpSmhZV1UvS2JwRy8zb2dlWFZ6YkRNVWJiRndjT29md1MySWYy?=
 =?utf-8?B?WkpydHpsa251d1F6bDlGQ1ZJVUxpT3hLU0RnQ29HZE13UUxXeEl4N0FSVEJN?=
 =?utf-8?B?NDE3UVEyeTFGc1JyWTJtcDhSUjIyYjkrWm11N2tzYWNwUm1abWNITWNheWlM?=
 =?utf-8?B?UFZRaCt4a1BqL1kzSnhiWFU4YjdTODNpK0QwaFRteUxTblVpc3Q4eG04bUpt?=
 =?utf-8?B?QkxHVVFraW9EcGYzZmxTMmRENDBRTnBJeWp1aURFWWNWODVZWDVuNlJudlMx?=
 =?utf-8?B?WmRpanB1RjJtRUlZQTVZRVRGaUZ5NU9VRy9OVTJBN25iUm1BY0REdzlldjZS?=
 =?utf-8?B?Q1d1Y0IxYURVSzFzN1lhVUEyNkRhVzZiOE1OVzhGMm45WUN5d2t1blhodkRs?=
 =?utf-8?B?ZFo2TW9pMXBDV1FnM0MrTitLb0FEOG9kaFJPb29NeDhQN0dsZ3RFbkQ5MXZz?=
 =?utf-8?B?WVJvM0lnRWNzdkhUcGdsVGlGSGk3R3BIRVRqNktycnFQWDVKemtndm94aUhi?=
 =?utf-8?B?c3F5Z2hrYk1KdWE1NzNoZUdVZG1tSmc1dmdzYi93bDAyd2MvKzR0WnlQNnNL?=
 =?utf-8?B?dklwM3NPTW81K29BQTJmQk8yZnlhVlpNU0hSM1REWENPUWdhV1prVmMxVGRy?=
 =?utf-8?B?RFppejEyR1pUWGs2cDFFSjNhamt4K2RzSjFnWGw1L1dqbW1VMDR4NCtZQ3dZ?=
 =?utf-8?B?V1FHTTd5eUNhU2pGazNkVWQ3RTduemhMR1lVSEkwVnozWUtnclVwZjJ5THdu?=
 =?utf-8?B?cEtieTZCeFBBVHgzTjJkSjFTR20zRnhMTG1yTW53R0ZCaUNFT1BDOVd5d2My?=
 =?utf-8?B?dHpWUGVLaSs2dGpDeXdGM3JFcmpKL3VQQUs0S0hsVExzajdxNy9udS9LMGpt?=
 =?utf-8?B?OXNFUTVydlhOb3hnK1I0SVc0SHJ6SWNzUzBENzA3SDJUTEFSdmJBRktaR3g1?=
 =?utf-8?B?MGVpYTFELytvNXpwVzF5QzB2TXBqVDdMNFZ0YzNrbTRqd2NVL0diT01tanpN?=
 =?utf-8?B?YzdRV2ZVOXhMeTVncXhkeHo3aG1MRjJNOXdpUVllVUdpK2tWeElnQTNpT092?=
 =?utf-8?B?SStOWlhOdjJqTGxQOGtlbENXQlhCMjBzcFZ0REtlZXdtRTdFSjBLanJBNTVz?=
 =?utf-8?B?TGhoekkvSHVvbXpFVVJycTVMM29Yam5SSTJ6Uk1HVHJKcnlGckRsbjZ2eXFp?=
 =?utf-8?B?bFdmaUZZeWkvaWNaTlhYVzJ4R3NXcW5rVXprazZ1dTYxSzJVMXg5SDdrQThx?=
 =?utf-8?B?L3c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5d2ef6-dd6a-4c51-4bba-08dd02f3dfbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 08:27:41.0125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3lKMMHYR3DNfehr/awcbNguomUU2UuknfWUUSZW0yrhBdvmu1bR09kSijaVvmXd+ZyHnVQyrp3w4/MJ/gN9MMpPXhISUrqe0OjRtDRYOGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196

SGkgQFZhZGltIEZlZG9yZW5rbywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBWYWRpbSBGZWRvcmVua28gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+DQo+IFNlbnQ6
IE1vbmRheSwgTm92ZW1iZXIgMTEsIDIwMjQgNzoxMiBQTQ0KPiBUbzogRGl2eWEgS29wcGVyYSAt
IEkzMDQ4MSA8RGl2eWEuS29wcGVyYUBtaWNyb2NoaXAuY29tPjsNCj4gYW5kcmV3QGx1bm4uY2g7
IEFydW4gUmFtYWRvc3MgLSBJMTc3NjkNCj4gPEFydW4uUmFtYWRvc3NAbWljcm9jaGlwLmNvbT47
IFVOR0xpbnV4RHJpdmVyDQo+IDxVTkdMaW51eERyaXZlckBtaWNyb2NoaXAuY29tPjsgaGthbGx3
ZWl0MUBnbWFpbC5jb207DQo+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVk
aGF0LmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IG5ldC1uZXh0IHYyIDIvNV0gbmV0OiBwaHk6IG1pY3JvY2hpcF9wdHAgOiBBZGQgcHRwIGxpYnJh
cnkNCj4gZm9yIE1pY3JvY2hpcCBwaHlzDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250
ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDExLzExLzIwMjQgMTI6NTgsIERpdnlhIEtvcHBlcmEgd3Jv
dGU6DQo+ID4gQWRkIHB0cCBsaWJyYXJ5IGZvciBNaWNyb2NoaXAgcGh5cw0KPiA+IDEtc3RlcCBh
bmQgMi1zdGVwIG1vZGVzIGFyZSBzdXBwb3J0ZWQsIG92ZXIgRXRoZXJuZXQgYW5kIFVEUChpcHY0
LA0KPiA+IGlwdjYpDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEaXZ5YSBLb3BwZXJhIDxkaXZ5
YS5rb3BwZXJhQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gdjEgLT4gdjINCj4gPiAtIFJl
bW92ZWQgcmVkdW5kYW50IG1lbXNldHMNCj4gPiAtIE1vdmVkIHRvIHN0YW5kYXJkIGNvbXBhcmlz
aW9uIHRoYW4gbWVtY21wIGZvciB1MTYNCj4gPiAtIEZpeGVkIHNwYXJzZS9zbWF0Y2ggd2Fybmlu
Z3MgcmVwb3J0ZWQgYnkga2VybmVsIHRlc3Qgcm9ib3QNCj4gPiAtIEFkZGVkIHNwaW5sb2NrIHRv
IHNoYXJlZCBjb2RlDQo+ID4gLSBNb3ZlZCByZWR1bmRhbnQgcGFydCBvZiBjb2RlIG91dCBvZiBz
cGlubG9jayBwcm90ZWN0ZWQgYXJlYQ0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvcGh5L21p
Y3JvY2hpcF9wdHAuYyB8IDk5OA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDk5OCBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcF9wdHAuYw0KPiANCj4gWy4uc25pcC4u
XQ0KPiANCj4gPiArc3RhdGljIHN0cnVjdCBtY2hwX3B0cF9yeF90cyAqbWNocF9wdHBfZ2V0X3J4
X3RzKHN0cnVjdA0KPiA+ICttY2hwX3B0cF9jbG9jayAqcHRwX2Nsb2NrKSB7DQo+ID4gKyAgICAg
c3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiA9IHB0cF9jbG9jay0+cGh5ZGV2Ow0KPiA+ICsgICAg
IHN0cnVjdCBtY2hwX3B0cF9yeF90cyAqcnhfdHMgPSBOVUxMOw0KPiA+ICsgICAgIHUzMiBzZWMs
IG5zZWM7DQo+ID4gKyAgICAgaW50IHJjOw0KPiA+ICsNCj4gPiArICAgICByYyA9IHBoeV9yZWFk
X21tZChwaHlkZXYsIFBUUF9NTUQocHRwX2Nsb2NrKSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBNQ0hQX1BUUF9SWF9JTkdSRVNTX05TX0hJKEJBU0VfUE9SVChwdHBfY2xvY2spKSk7DQo+
ID4gKyAgICAgaWYgKHJjIDwgMCkNCj4gPiArICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ID4g
KyAgICAgaWYgKCEocmMgJiBNQ0hQX1BUUF9SWF9JTkdSRVNTX05TX0hJX1RTX1ZBTElEKSkgew0K
PiA+ICsgICAgICAgICAgICAgcGh5ZGV2X2VycihwaHlkZXYsICJSWCBUaW1lc3RhbXAgaXMgbm90
IHZhbGlkIVxuIik7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiA+ICsgICAgIH0N
Cj4gPiArICAgICBuc2VjID0gKHJjICYgR0VOTUFTSygxMywgMCkpIDw8IDE2Ow0KPiA+ICsNCj4g
PiArICAgICByYyA9IHBoeV9yZWFkX21tZChwaHlkZXYsIFBUUF9NTUQocHRwX2Nsb2NrKSwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBNQ0hQX1BUUF9SWF9JTkdSRVNTX05TX0xPKEJBU0Vf
UE9SVChwdHBfY2xvY2spKSk7DQo+ID4gKyAgICAgaWYgKHJjIDwgMCkNCj4gPiArICAgICAgICAg
ICAgIGdvdG8gZXJyb3I7DQo+ID4gKyAgICAgbnNlYyB8PSByYzsNCj4gPiArDQo+ID4gKyAgICAg
cmMgPSBwaHlfcmVhZF9tbWQocGh5ZGV2LCBQVFBfTU1EKHB0cF9jbG9jayksDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgTUNIUF9QVFBfUlhfSU5HUkVTU19TRUNfSEkoQkFTRV9QT1JUKHB0
cF9jbG9jaykpKTsNCj4gPiArICAgICBpZiAocmMgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgZ290
byBlcnJvcjsNCj4gPiArICAgICBzZWMgPSByYyA8PCAxNjsNCj4gPiArDQo+ID4gKyAgICAgcmMg
PSBwaHlfcmVhZF9tbWQocGh5ZGV2LCBQVFBfTU1EKHB0cF9jbG9jayksDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgTUNIUF9QVFBfUlhfSU5HUkVTU19TRUNfTE8oQkFTRV9QT1JUKHB0cF9j
bG9jaykpKTsNCj4gPiArICAgICBpZiAocmMgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgZ290byBl
cnJvcjsNCj4gPiArICAgICBzZWMgfD0gcmM7DQo+ID4gKw0KPiA+ICsgICAgIHJjID0gcGh5X3Jl
YWRfbW1kKHBoeWRldiwgUFRQX01NRChwdHBfY2xvY2spLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIE1DSFBfUFRQX1JYX01TR19IRUFERVIyKEJBU0VfUE9SVChwdHBfY2xvY2spKSk7DQo+
ID4gKyAgICAgaWYgKHJjIDwgMCkNCj4gPiArICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ID4g
Kw0KPiA+ICsgICAgIHJ4X3RzID0ga3phbGxvYyhzaXplb2YoKnJ4X3RzKSwgR0ZQX0tFUk5FTCk7
DQo+IA0KPiBJIHRoaW5rIEkndmUgYXNrZWQgaXQgYWxyZWFkeSwgYnV0IHdoeSB6ZXJvIG91dCBu
ZXcgYWxsb2NhdGlvbiwgd2hpY2ggd2lsbCBiZSBmdWxseQ0KPiByZS13cml0dGVuIGJ5IHRoZSBu
ZXh0IGluc3RydWN0aW9ucz8gRGlkIHlvdSBmaW5kIGFueSBwcm9ibGVtcz8NCj4gDQoNClllcywg
Y2hlY2tlZCB3aXRoIGRpZmZlcmVudCB0aGluZyBhbmQgZmFjZWQgaXNzdWUuIFNvIHJldmVydGVk
IGNoYW5nZS4gQnV0IG5vdyByZXBsYWNlZCB3aXRoIGttYWxsb2MgYW5kIG5vdCBzZWVuIGFueSBp
c3N1ZXMuDQpXaWxsIHNlbmQgbmV3IHJldmlzaW9uIHdpdGggdGhpcyBjaGFuZ2UuDQoNClRoYW5r
cywNCkRpdnlhDQoNCj4gPiArICAgICBpZiAoIXJ4X3RzKQ0KPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIE5VTEw7DQo+ID4gKw0KPiA+ICsgICAgIHJ4X3RzLT5zZWNvbmRzID0gc2VjOw0KPiA+ICsg
ICAgIHJ4X3RzLT5uc2VjID0gbnNlYzsNCj4gPiArICAgICByeF90cy0+c2VxX2lkID0gcmM7DQo+
ID4gKw0KPiA+ICtlcnJvcjoNCj4gPiArICAgICByZXR1cm4gcnhfdHM7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyB2b2lkIG1jaHBfcHRwX3Byb2Nlc3NfcnhfdHMoc3RydWN0IG1jaHBfcHRw
X2Nsb2NrICpwdHBfY2xvY2spDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgcGh5X2RldmljZSAq
cGh5ZGV2ID0gcHRwX2Nsb2NrLT5waHlkZXY7DQo+ID4gKyAgICAgaW50IGNhcHM7DQo+ID4gKw0K
PiA+ICsgICAgIGRvIHsNCj4gPiArICAgICAgICAgICAgIHN0cnVjdCBtY2hwX3B0cF9yeF90cyAq
cnhfdHM7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgcnhfdHMgPSBtY2hwX3B0cF9nZXRfcnhf
dHMocHRwX2Nsb2NrKTsNCj4gPiArICAgICAgICAgICAgIGlmIChyeF90cykNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgbWNocF9wdHBfbWF0Y2hfcnhfdHMocHRwX2Nsb2NrLCByeF90cyk7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgY2FwcyA9IHBoeV9yZWFkX21tZChwaHlkZXYsIFBUUF9N
TUQocHRwX2Nsb2NrKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUNI
UF9QVFBfQ0FQX0lORk8oQkFTRV9QT1JUKHB0cF9jbG9jaykpKTsNCj4gPiArICAgICAgICAgICAg
IGlmIChjYXBzIDwgMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsg
ICAgIH0gd2hpbGUgKE1DSFBfUFRQX1JYX1RTX0NOVChjYXBzKSA+IDApOyB9DQo+ID4gKw0K

