Return-Path: <netdev+bounces-162142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04504A25E0B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83813AB912
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39411FBE9C;
	Mon,  3 Feb 2025 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ivI5Q82q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550823774
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594702; cv=fail; b=pOoiVDSrSuhcgnBQqYZ/m0X+WcgngSl+KoKVuLwr+oGAGrwqa64PHNbAO8js/8reyZFsZpqXBUUteGaozj5xog16AXwtg0d/pV2fFgU6qa+xjWJEfg7xBzaNSc5AjXylodZz0iVbdiWAJ6nX496ODdL5LzPHxfa8KsBIytAV/1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594702; c=relaxed/simple;
	bh=4WqCabxTHiwIkRsMFL913RqY4uCrulkgxhrqpvGsYd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VXoMIOduFkeIKXNuLzoFk4NNt4QV9ANGH2vMQofZIoTEn1PabmnllCKW8A44qw8jVZy1nTk5SrKa9VGbZG8Gsa+6U62BPs6gdRiyJxsxXIRcc42ZkU6MCVmoSNsQwKBEqsfPFLr6NWLYKimkIk+v8A9v1Qi3wUzgrZoAsaQ3tnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ivI5Q82q; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHyd817Ho3WNfbnZNmCWJPpnP2vWCDlXDoW5fD+eBEOFBd2uzPxlcs3onQ9uB+Uzn/IWD0h/RF3QtHjMq6CUmiZ1ACcLJ799Z3LobQPffBsG8aph2u23JXASu0BEoxej9Bn9Du9ZxJKsmMRsYCIunqFYCHladXQN3P+c+llbgI3YLF5SReH9x0N8RrRtF+LhExcF0bJ2lZkcQEYuJ4bO7zjdzeh1qBCnGgvGnNE1MlzJXnIWddWwU8UF9goNlIVBTfarhkGq7mSEwpt0SHaPitYsoQSk2PezDXS0eO1Uy6OXZirmRBnrih/QKIkK52XxCetXp4HADFRyd7JyC/cWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WqCabxTHiwIkRsMFL913RqY4uCrulkgxhrqpvGsYd8=;
 b=B91/QWPu7VY04W7I71xMhoId8rVSwINRxauaPqHKDd9BUkms1khcZ96t5tiKc5ga0y2ZIRhAMk/7eLmND+IHmG40jNxtEvlc4hkecjKwNTUFCWXakxLY+Ip9yIxC4yMwHfC+rLERzP9l3vADtgN9AJEz+f2bKqxfJiXk1/OXVCd0jnIYVQ+pyVqgeN/hZ4WzpA0wqSTM1Kwa6RSqfBDeUFlffpSIFKbth1fuGMFf+cykyMQ0yaxX/Gus60S5seFry5EKFIEkuSF/7vDPAfupmiztV+U9vWmtqHOPNo9eDadei+T6nMKY0PKrLpqGAtfmrOH7DEwDveDETWC7tUJHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WqCabxTHiwIkRsMFL913RqY4uCrulkgxhrqpvGsYd8=;
 b=ivI5Q82qkZPJXQspsYeuEgobIr9lP/gql6EUv2Ptu9me8PA8yFT/yWBKMKJyb/Ye4Z/QbBDljBZ0VcEQsuRcld/u+iB4zTpz6W8X2f6sKDPA21WBrGWeY8ghoVeDPlMrthZ9b6UoLFOmHG+1LlyrCwNETpfZU3h6x7qtY6fVcm5BAHirPAbaGXw+auAYKAE62ikg8I1FkmqgGKXc6yGxVZ+0wdXPvN5qdsfsLA3t8ioQpbh5qowJni62nFJz0l4XBrXJnBxWL3MMk9gmsVcqr5ncmyl6ViOrOtQDSExl3gHYWIk4Iugyr/nchaG01EZTKsF/skGtLPxrYH7infktFA==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 14:58:12 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 14:58:12 +0000
From: <Woojung.Huh@microchip.com>
To: <frieder.schrempf@kontron.de>, <lukma@denx.de>
CC: <andrew@lunn.ch>, <netdev@vger.kernel.org>, <Tristram.Ha@microchip.com>
Subject: RE: KSZ9477 HSR Offloading
Thread-Topic: KSZ9477 HSR Offloading
Thread-Index:
 AQHbcZ/V7BrTHsAdqUafWk3/ZoT41LMsd0oAgADjJgCAAArSgIAANkeAgAAFAwCAACgGgIAANNSAgAAc85CAAOiAgIAAXJhwgAX6CoCAAFhmAIAAAfnQ
Date: Mon, 3 Feb 2025 14:58:12 +0000
Message-ID:
 <BL0PR11MB2913B949D05B9BB73108A5FFE7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
 <BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203103113.27e3060a@wsk>
 <1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
In-Reply-To: <1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SA2PR11MB5002:EE_
x-ms-office365-filtering-correlation-id: ac1afae7-632a-4547-5070-08dd44632e33
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bE1wYjU3a1pyMGpvNGVGZ0VxV1pESmVrZm9sdDJ5Z2R0NU1laUFZc1RZUnFh?=
 =?utf-8?B?azZLSFA3QnF1R054Ti8wV3NYdFI2bnJpTnk2U2VOSU1jZndNTmpvZytscEY1?=
 =?utf-8?B?bndONWVSbkJoR2RIaUJXVCtQczY1b3NqdGFxVU1nNndQL08wYmREMGVKenQ4?=
 =?utf-8?B?amhhVVUwb0tRK3RZYmpVRWtpQWZ6T0RhbmpjNi9KMHl0QjFaWTJUbitaV3A0?=
 =?utf-8?B?OExvOFJvdXZHT1ZpTWYyWnhxdkJHMStZd3RZN0lMOVFhMnVJTVJvRytqMktC?=
 =?utf-8?B?YmVjUk9WaUNzK3d3dkh0R005NEZNcEh3THJBeHUyTzk1OERVd3FXdmszMWpn?=
 =?utf-8?B?dlBxSnFDeWNYR2R1VnMzbmJrMW5tYmkwN2pHNnZFZDB1U0RmcVlKZDRyanlV?=
 =?utf-8?B?VkxVajY0d1F3czRndmxFK3N0cHE3R3V2UGo5YUhsdjhiakpaUmdqVzhja25H?=
 =?utf-8?B?OTlPMFZCZk45VmFGZkRmeU43S2RYeUJTbVBnODBqaHZVdzdyRFA4Qk9ySUFX?=
 =?utf-8?B?UDgydlR5dWhKbE9CWk5WMzlrZ3hPWjNmZmJ4encrR3FrSGwyVVp3UkJmL2J2?=
 =?utf-8?B?ajBlR2hSS3Zoekx6SzBnYzB3WDZvMzVnMTNuenYxOE1EWmc5UGxMZTRBdmox?=
 =?utf-8?B?WHl0ZW5UOVM0Q3lsTEJlSStSQWFPOFZnQ3ljZHdoMmduSE96akpkelpSczVp?=
 =?utf-8?B?eTlKUGlYak1KeWtnRWlPTUxJNSs3anVPb1VvWWp3eFBkWFAvSXJJbU9hdnhu?=
 =?utf-8?B?TDRTd1hUMnFPSVdZL1dBaHd1RTQwMjIwOTFEUWppbE81OTNFOU9zejhUc2Fw?=
 =?utf-8?B?MHVKZ0hBQmsvQWVOaU0rSTcvZVo3VDBFallKdXJVeHJvekRuOGZISHZ2ZnlV?=
 =?utf-8?B?T1dqaFJSdUp5d0hXTkxyZExkY01nSVIrS3l5TTUvVzl5OUpjaEdHa3FxNkJU?=
 =?utf-8?B?K1lLbWgyNjRSNVdxTHAyb3ZzeVJMbzVqNzhHRFpYS00weGkzbUE5Y01tcFIv?=
 =?utf-8?B?N3I0R3Y2djlvNk40ZWlQMXlGaFZqTTNUMGJ4NXQwTDlKT0VMMnlMVEIwSlJC?=
 =?utf-8?B?azB3eUlHcGJlWklTL0hZRTdDUGRiNmtscm4zL25hWnRoRzkyelM2cCtTb3lt?=
 =?utf-8?B?UDN3Vk0reFVWaEE5dFZQdG9OZStHVTJOZ2I4QUo1aVA1TXdNMUpWOXlURVZw?=
 =?utf-8?B?YVlYRmg3M25MbzBYc1lrczY4MmtMUjR0czVYWENPSVZiYk9OV1J5VnE3c3Ax?=
 =?utf-8?B?aDJXVjNNemNWaS9iZDdkK1RZeXRRYkx4MnRwb3RiY25kOWF0TGtxUXZWTUd4?=
 =?utf-8?B?UWFDSUl4ZkVma2xUcnpweS9DbnZObElHeGlwMlN5UWtFeUtDcTZwcE9vYjly?=
 =?utf-8?B?Qlo5V1M1VSt3OVFabkpDN3ZXamhadzM4S3VMRzJzRVFyRW5Fc2ZmWU80cFVS?=
 =?utf-8?B?NU9hNTk5WDVkc08vRExwa0Jnb0M0RGd5b3FkMmIrVVB3cFE0V3FZWk5sZXd1?=
 =?utf-8?B?NmRzcENpYXgyZFFwVjd3M3NNbi80UFFvcVFEeGtZSStkQU9Kd3E2VlRyQ2da?=
 =?utf-8?B?aTJqeVZDT0F1djRiVE56OTYxcC81TnU0bFdaTVNuWDNFRVJaZ2NmVFNJbzdM?=
 =?utf-8?B?OVl6eHFEZmxwOWVjOVpUcDAvcjVROExqbGNsUG1saW1Vb0sxcW83ZFJ5dGYr?=
 =?utf-8?B?cTh4TlBucnd4UUt5bitNTHhyaEpTZXZrQTRJd2VVbWxJSHluWW5Lc1M0OEF4?=
 =?utf-8?B?dXBXcUZjbFhFeVVtTEtjSzlhMkkwQ083cnU4M1UxRHA4WEpIYkJKVjBsWkJZ?=
 =?utf-8?B?MFRiRExGTTl4b2t1b3NrbXhmSEVUYStRUHJuRDVLWE0xcGNldkVuZTlGS09U?=
 =?utf-8?B?MmlUYVdzNFM1d3E2cmp0Z09NMmFkNUVMY25QRGZENFNSYVE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1RjNnM1cWpQVVFDS2hXT1lhL0RjbzRjcHp2MkN3clhUUmFkbFRjNE1FOSto?=
 =?utf-8?B?MWoyUmpXcjlzYUIxQnNERG5Bc2g2emsrY05WWXo2b3hYcWRORHd6S0R6aG1t?=
 =?utf-8?B?alUwQUZKMGt5TlBXN3h5ZkZkMTU1MHMzOU16cDhQY3pKOFk2TnF2aHBrengx?=
 =?utf-8?B?QVVQM2tVQml0R2ZlcitNR1hLcUVaUnpKbkdxMU0vRXZTY3RSZTlCblg3MUpJ?=
 =?utf-8?B?QmhqbSticHpwRytWbkZYZlg4Yk8wMkhHZjJMNXhnV29uOEdrdmpXeW0xNXcw?=
 =?utf-8?B?N21YTlZOdm1XY1I0OSs0cFo4VXI5c084TlpVNlZjelI3QzVYTG1WeFJndk9M?=
 =?utf-8?B?ai82L2tabUV4RklRd0ZGWHhvODlEQmNiWENORGhGcVZwdWFjM2xEeUxaVCtF?=
 =?utf-8?B?NzloZVFGNnNrbk9wMGFEeTN3K2YrWlM3QnBlNFhQRFc3VlgrQ1dVRE9rZldz?=
 =?utf-8?B?ZUFRYkh3UXU1a2cyVmxZSHFjZWZSa25aL0JtTkdwUEwzeXpNSVJpWjZkRENP?=
 =?utf-8?B?ZUE2Y29KRjFQUzdreWpRbG9hY0RvSGVvQWZLWFhweElDUGZvZm1iOU9najdY?=
 =?utf-8?B?ZEZadktWTFpZc3llc0pCMU9VemRpMHFYbDlQQVJEQ2srYjNHYjF0MWZsdHFJ?=
 =?utf-8?B?elNoV3ZSNEhXdGxXUWQyVnliOUNZczVwWXlHaUdpRFh6MGRPcStQUnBXZENn?=
 =?utf-8?B?RHA0WEZ1Yld5NEEwZEJXWDV4KzkwYlJ1ZTNrVDhieDVrcHRybTE4ZEx6dmNa?=
 =?utf-8?B?SUhZWmZXZ2t6WThPc2Nkd1Q1ZW8xTFFza1pleExFQUJkMFBKSGVDemdTbFVO?=
 =?utf-8?B?UmE4WHJWb2JtNXdocHR2MFA1QldLMW9TRktZak8xdDhpMmdHQk5rRmN2WFVH?=
 =?utf-8?B?MTRxNkhnU1pHNGxJb2k5ME9rRlNLS1RTVVZtc2ovUmdQM2NrNzVXNEZOa3Yy?=
 =?utf-8?B?YVVocG5zRTZjY1BBSHRMVTVXODZxUUJaZXd1a3Vpcmo0eUxSOGkvdmNJTEhP?=
 =?utf-8?B?d0x4eXJXdzdOOGJkblhocjVaL1NVdnlWNE9yOGZZYzRPNmhGYTB6SnFFSEl1?=
 =?utf-8?B?S3lGRS9zTEdDMmZLYjRzQXpzZkd4eFREbXVIMk5oQ2JqR1lBNnc1MTBkL1FZ?=
 =?utf-8?B?QjFoZkJZei92VE82ZXp0RUNrZDZ1SmpKMWhWMldaSDBCWFd2MkZ6RVlKdm8v?=
 =?utf-8?B?clR5QzAzSUIvZDhSWDJkMUpzekNZbm1yVExxajNFSGdONWhUd3c3cGpseTJS?=
 =?utf-8?B?NmIvU2wzM1VaU2NUenlVN0NXTURWeStnMkozbld0WUpkRXY5dk5FbkJiNXI3?=
 =?utf-8?B?clJZQjQ3aHNkVGplOXFkVndYTTNHUmg4a3hkOU9jcS9Ic3RQeXZlSjBFM0g0?=
 =?utf-8?B?d0UxTjNnRS9lSEk0eVhzMkpQOS9nNGV6K0hYdXB4Y3hiWE9SR25qS1hvbThL?=
 =?utf-8?B?V1NPSCs5b1B3NDFINC9PSmRyZmZQODNRRzBYSExTNExhQ3pvZG5WNzlFSGZw?=
 =?utf-8?B?TVdvWnduTDNITnNOTHRqaW1qM0t5bUcvQ2czR1EvNnZuc1ZHSnpkMEtMY3BW?=
 =?utf-8?B?OHNIbHpyNU45bzZUc1VESnZud2V3MjZSMTYxQy8vUVE2UVpxQU82UnJKa0Qv?=
 =?utf-8?B?bTU2dGlHZzNESWRhRy9RRjdIR3FaOEFnMDFoREhxZnQ2TVVTSFEyRmxRQ21r?=
 =?utf-8?B?SFRMM0NzY243V0ZhRU9hbThoWE1jeGMwZlFiQ1I0cW5YYVc4T0lRdG84VW4x?=
 =?utf-8?B?NXlCQXhmRy85aFJUUi9pZFJuaE5QWXJhVFcyTFNqSkZ3ZFNBRlVVc2tQRVR3?=
 =?utf-8?B?bldUYzZ6anVFeGFMRWZPZDJpRXNPR01tUWRYTkduR2JiOTVUZFVlL3hSS3RO?=
 =?utf-8?B?S0lobTZKaGRUakxNUXNOUmFvK0dwdS9WVnV4VXN0YVV6emNiSmFsV1YxVFJj?=
 =?utf-8?B?WDNUeHp0cmFwa0RIZWZBbTVRMTEreWMzaGJPS2ovbCtraFZFMGY0ME0zQlZK?=
 =?utf-8?B?SjZLRnlmM2RGT3RWeXJqQkx4U2pXajBsV0FhMkRxRjU2Z1h6Rzg1Mmk0SlRE?=
 =?utf-8?B?Q0Q5bGppRkVUTTdUOFYrSUtEWU5SSWxyb3pHMDNQQ21iOUgyUGtONVhwdEp4?=
 =?utf-8?Q?xKINDYAi9mujXhxZ90j5Q9U+c?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1afae7-632a-4547-5070-08dd44632e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 14:58:12.3763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZByAEG2Tspo6qqd0PyMqWb2OQnnzDHtJbqq2QCQDphUT0QoWesQkANCslwaCYfu5AZkiniDHVlKZP58Y9lrwGOqyG9UySHj8JRXCPdNlso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002

SGkgTHVrYXN6ICYgRnJpZWRlciwNCg0KT29wcyEgTXkgYmFkLiBJIGNvbmZ1c2VkIHRoYXQgTHVr
YXN6IHdhcyBmaWxlZCBhIGNhc2Ugb3JpZ2luYWxseS4gTW9uZGF5IGJyYWluLWZyZWV6ZS4gOigN
Cg0KWWVzLCBpdCBpcyBub3QgYSBwdWJsaWMgbGluayBhbmQgcGVyLXVzZXIgY2FzZS4gU28sIG9u
bHkgRnJpZWRlciBjYW4gc2VlIGl0Lg0KSXQgbWF5IGJlIGFibGUgZm9yIHlvdSB3aGVuIEZyaWVk
ZXIgYWRkcyB5b3UgYXMgYSB0ZWFtLiAoTm90IHRlc3RlZCBwZXJzb25hbGx5IHRob3VnaCkNCg0K
VGhhbmtzDQpXb29qdW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
RnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPiBTZW50OiBN
b25kYXksIEZlYnJ1YXJ5IDMsIDIwMjUgOTo0OCBBTQ0KPiBUbzogTHVrYXN6IE1hamV3c2tpIDxs
dWttYUBkZW54LmRlPjsgV29vanVuZyBIdWggLSBDMjE2OTkNCj4gPFdvb2p1bmcuSHVoQG1pY3Jv
Y2hpcC5jb20+DQo+IENjOiBhbmRyZXdAbHVubi5jaDsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
VHJpc3RyYW0gSGEgLSBDMjQyNjgNCj4gPFRyaXN0cmFtLkhhQG1pY3JvY2hpcC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBLU1o5NDc3IEhTUiBPZmZsb2FkaW5nDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDAzLjAyLjI1IDEwOjMxIEFNLCBMdWthc3og
TWFqZXdza2kgd3JvdGU6DQo+ID4gSGkgV29vanVuZywNCj4gPg0KPiA+PiBISSBGcmllZGVyLA0K
PiA+Pg0KPiA+PiBUaGFua3MgZm9yIHRoZSBsaW5rLiBJIHJlbWluZGVkIHRoZSBzdXBwb3J0IHRl
YW0gdGhpcyB0aWNrZXQuDQo+ID4+IFBsZWFzZSB3YWl0IHJlc3BvbnNlIGluIHRoZSB0aWNrZXQu
IEhvcGUgd2UgY2FuIGdldCB0aGUgc29sdXRpb24gZm9yDQo+ID4+IHlvdS4NCj4gPj4NCj4gPj4g
VGhhbmtzLg0KPiA+PiBXb29qdW5nDQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250
cm9uLmRlPg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMzAsIDIwMjUgMzo0NCBBTQ0K
PiA+Pj4gVG86IFdvb2p1bmcgSHVoIC0gQzIxNjk5IDxXb29qdW5nLkh1aEBtaWNyb2NoaXAuY29t
Pg0KPiA+Pj4gQ2M6IGFuZHJld0BsdW5uLmNoOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsdWtt
YUBkZW54LmRlOyBUcmlzdHJhbQ0KPiA+Pj4gSGEgLSBDMjQyNjggPFRyaXN0cmFtLkhhQG1pY3Jv
Y2hpcC5jb20+DQo+ID4+PiBTdWJqZWN0OiBSZTogS1NaOTQ3NyBIU1IgT2ZmbG9hZGluZw0KPiA+
Pj4NCj4gPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91DQo+ID4+PiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gPj4+
DQo+ID4+PiBIaSBXb29qdW5nLA0KPiA+Pj4NCj4gPj4+IE9uIDI5LjAxLjI1IDc6NTcgUE0sIFdv
b2p1bmcuSHVoQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+ID4+Pj4gW1NpZSBlcmhhbHRlbiBuaWNo
dCBow6R1ZmlnIEUtTWFpbHMgdm9uIHdvb2p1bmcuaHVoQG1pY3JvY2hpcC5jb20uDQo+ID4+Pj4g
V2VpdGVyZQ0KPiA+Pj4gSW5mb3JtYXRpb25lbiwgd2FydW0gZGllcyB3aWNodGlnIGlzdCwgZmlu
ZGVuIFNpZSB1bnRlcg0KPiA+Pj4gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uIF0NCj4gPj4+Pg0KPiA+Pj4+IEhpIEZyaWVkZXIsDQo+ID4+Pj4NCj4gPj4+PiBD
YW4geW91IHBsZWFzZSBjcmVhdGUgYSB0aWNrZXQgYXQgTWljcm9jaGlwJ3Mgc2l0ZSBhbmQgc2hh
cmUgaXQNCj4gPj4+PiB3aXRoIG1lPw0KPiA+Pj4NCj4gPj4+IFN1cmUsIGhlcmUgaXMgdGhlIGxp
bms6DQo+ID4+PiBodHRwczovL21pY3JvY2hpcC5teS5zaXRlLmNvbS9zL2Nhc2UvNTAwVjQwMDAw
MEtRaTF0SUFELw0KPiA+DQo+ID4gSXMgdGhlIGxpbmsgY29ycmVjdD8NCj4gPg0KPiA+IFdoZW4g
SSBsb2dpbiBpbnRvIG1pY3JvY2hpcC5teS5zaXRlLmNvbSBJIGRvbid0IHNlZSB0aGlzICJjYXNl
IiBjcmVhdGVkDQo+ID4gZm9yIEtTWjk0NzcuDQo+IA0KPiBUaGUgbGluayB3b3JrcyBmb3IgbWUu
IE1heWJlIHlvdSBjYW4ndCBzZWUgdGhlIHRpY2tldCBhcyB5b3UgaGF2ZSBubw0KPiBwZXJtaXNz
aW9ucz8gSSBhZGRlZCB5b3UgYXMgInRlYW0gbWVtYmVyIiB0byB0aGUgY2FzZSB3aXRoIHlvdXIg
RGVueA0KPiBlbWFpbCBhZGRyZXNzLiBJZiB5b3UgYWxyZWFkeSBoYXZlIGFuIGFjY291bnQgb24g
YSBkaWZmZXJlbnQgZW1haWwsIGxldA0KPiBtZSBrbm93IGFuZCBJIGNhbiBjaGFuZ2UgdGhlIGFk
ZHJlc3MuDQoNCg==

