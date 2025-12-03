Return-Path: <netdev+bounces-243403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C73FC9F091
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 14:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A22364E0471
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547914B950;
	Wed,  3 Dec 2025 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="c1afVpD0"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7712D1F1;
	Wed,  3 Dec 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764766926; cv=fail; b=LseuuJ9GHkWsk+REYpuMHbWpzdGldLE3S8QoITs2aI/Kq9J67BCSlxUq6mVpJ74C94bfOwJW/VOn6Fh+pMI7vS3h7+X2VUh4n22v8QcNhvHOePHY4JkLqA6MfTin1EwCFSGtMhqbO/UGsj6m+litl96Caf12QTqW5TY1og3aRMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764766926; c=relaxed/simple;
	bh=wqQWiqsiuVetmclRGfyKOqhDlMkO+Nf0u/7DM9MG9rg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u3FwIjdaXW5AJouALMyBsu/FgP46CYPpPTWYXATADu0ygpl83OL6uzJwkCQLWfkPGEq0SJ3bjXHvYdKDu/3OIBHVhpfPYLF3lEonWfLW5p3CVcZ/w/cIfCwZ+WFuSFmu3dnJupRLZXA7PrSWcnBpcbOGOKoEJY1BoHMpKCN207E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=c1afVpD0; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzl2rP/ti0MH4cAy9eeDNP/99IJJpCmaz3tMBh/NYIknzah7hhCWu0WerRfChlW++z/SmH5kSbNs6UWstccoHo9aQbsY0FrdfjFW4HRHSiXj8zEuvqDWEQB6KnPVBWX5y06PsAZtASCJCKyJMpJbYwO6IwxTnJbsVvPgPUQvKvV8PBWEVU0YhQZa4u4a06C64AqqaHcDGd2l4+kMDilbu53BdoiC8q7Y+RdxkRw28CqPj3g4faAe/zT+7NBNXdmOL+xqokBYQUje9yHWfsbX9hlEVKDyKN5wl8J+dQF0cetVZdIx+TU4Z/1JzEyaLrLdF7x/xWF3FYg54aV0pCNJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqQWiqsiuVetmclRGfyKOqhDlMkO+Nf0u/7DM9MG9rg=;
 b=o08AVks5uBbvPA/joC7GteHlbNwnwCHXswjd0P9x6d9BFITcZBUOCuTYlApZFOCdjwnLgVw8Ag+F7kS+C/5mhwI8p+qREMCRyVxAxa1B4wnOVJ0tNB9BGVV4LQ2BKnvkEqzuDC0I2FbhlxveAW8LKomyV7g24/ZsKahhZMRnO1gViiEHGIx6RKs2tS6Iwz1cp0IUeverySP2QnMDbzd8iZpal7Pmjnji9Fl0n0nhR/HtQ/HLMBkPjlM1yvIuin9vHEujavgj+douI5rIqfPuTZy18cq3ccWiYKdBX9417ZcKOn7W2uIkzewqzFrhH9SKS92GfpRrtaLvB0WrZ4FTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqQWiqsiuVetmclRGfyKOqhDlMkO+Nf0u/7DM9MG9rg=;
 b=c1afVpD026Y0b/i02vxmDJ45iqwCkdlir1f8DneALLO3PtR6qyEmFm9kIJzjNci007eMNDTZBS3U37ZB0BgU/gwVl3mv3wMpjiD1LcVVufbKeeZ91OM5oBHxCCIYchCHLAJHMZnJZihKKxIJxaLJQRS0f59gUDkR2AJPPZAxs8c=
Received: from VI0PR02MB10631.eurprd02.prod.outlook.com
 (2603:10a6:800:206::14) by AM9PR02MB6946.eurprd02.prod.outlook.com
 (2603:10a6:20b:266::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:01:58 +0000
Received: from VI0PR02MB10631.eurprd02.prod.outlook.com
 ([fe80::7f57:534c:1bc8:2ef0]) by VI0PR02MB10631.eurprd02.prod.outlook.com
 ([fe80::7f57:534c:1bc8:2ef0%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 13:01:58 +0000
From: Ivan Galkin <Ivan.Galkin@axis.com>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"michael@fossekall.de" <michael@fossekall.de>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "olek2@wp.pl" <olek2@wp.pl>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Thread-Topic: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Thread-Index: AQHcZDkpMh1hBoOYfEa+e69ycVqb47UP4ZEA
Date: Wed, 3 Dec 2025 13:01:58 +0000
Message-ID: <37d89648fddf1d597e6be0c541cbc93cb3b42e24.camel@axis.com>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
	 <20251130005843.234656-3-marek.vasut@mailbox.org>
	 <20251203094224.jelvaizfq7h6jzke@skbuf>
In-Reply-To: <20251203094224.jelvaizfq7h6jzke@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR02MB10631:EE_|AM9PR02MB6946:EE_
x-ms-office365-filtering-correlation-id: cc0d74ec-8efb-4af2-b836-08de326c24c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXJiYnBXNXgvM041SDlIb1NYTzBIcDFKMVhZWjVseUN6QlJBcnhXSWs1MW9j?=
 =?utf-8?B?cUovOUpKbmFiVXdPa1VnRE9UYnlnSW9TUnl1Y1dLM1dCcW1LSm5wU1p1OFlF?=
 =?utf-8?B?VllGMkhoajg0VmdERGNMaElKb3FCNEhlV3dEa05EQVNaMVJBYzh6UnhmczFs?=
 =?utf-8?B?RG9sTmdHSkdpamlaVko2b0lVMEk1Ty9IWG9sd1FRY1AxejNvRUZQQW5BREJC?=
 =?utf-8?B?MGxmQlVMbEZ0NWVHS0xSV2RsU1IyeUJIR01aU3lnZm92bm9KaGdNa25yT0hS?=
 =?utf-8?B?WHpmUTFUUXJVVWs1cHE2S3ZFTDF5cnBac1lkeUJZcnNaZWYyUFZzVElzcDRR?=
 =?utf-8?B?WTkzbVNQRUYyMTBWbkZyN0R2T1pHa0ViYS9yMTNPK1BwL2xFN1N2Rmp6VCt4?=
 =?utf-8?B?ZTlCRThkM2NoeUNDakM0TEh1Mm9TR2Z1aW4wb1U1cWMzTlU2ekQ1N0ZGTU9F?=
 =?utf-8?B?MktSK00vS1lGQVQ5YnRuTStjZkJScCtkd1pGYmZhZXZWVGgvUmFQSFFLcWxX?=
 =?utf-8?B?dTdINVNiZ2VaM2E0SUp0K0tLUmpnZnlLUHFnVW1oWWxGekQzTWdxS1Y4aHRN?=
 =?utf-8?B?WkJwV3hhNDVrR1dKbEg5QlZieHdaVC9kR1FUVXhmM0lYcVg3NjlteUlrY1hO?=
 =?utf-8?B?dUpOZ1UxcXIwVHNqaVVYR1Z4UTRjTTRZczhydkVXQ1JnWkJhR0JSbCswalpZ?=
 =?utf-8?B?cFBPSy84cXltU3JlemNEdFN4OWJOdlc0Wmt5Vll2dHkrUlE4VmR3TVNMWEkx?=
 =?utf-8?B?R1ZaL3BnM3ZHaFNaR045MGNCVzlOMitiWGpXZVJMSkJWRWZ3a1UyRzJBZis5?=
 =?utf-8?B?dCtvckZqZFUrUXIrNWt0MGFIMzZzWkFTWGRMcHlNVFIrQVcrckZJMnFsVGE1?=
 =?utf-8?B?VHRGTmxlTWM5K2lmTEVDcmU2RlAwOTJMWlcrdGo1NnI3RVhPK0c0czdyb1dL?=
 =?utf-8?B?clNKMnB4Z0VzNS9YNVBTVmcyeXV0N0k0djJmUnJxRitqdXZTVnZHWVRBcUVz?=
 =?utf-8?B?Y04wenIwdDE3cnB2a2o3NjdTN3ExaEtBZUdQTlZubDZFTnJTcUUwUlBMZ29o?=
 =?utf-8?B?UjU4Zjc3VlVZRm9mT0NpVjZoR0huVDJCY3BabTVhMEdXNy9IaDA4Tys3RUZs?=
 =?utf-8?B?Z2w0OGsydUx2SHZibmFFT3dEdmNUd0RRY2NzbzlVMS90dk1jVkVhODNNeWtK?=
 =?utf-8?B?bmdBcnF6RGVJbGR5aGVJMVJXWVFDZGQvK3EyU1p0bEpwYXFTUjdBRGx3cnNn?=
 =?utf-8?B?T2ZqMXBUd0txOEJHV3EyWWZmK3A0MnUxcTI1ckJPK2grYm1SQVJEVFJCWWFh?=
 =?utf-8?B?WVBVK3BoYWxVWTZLdjlZR3o4L3YwQXVrVWV3ZlA2Y21ueWE2WE5makgwaU1N?=
 =?utf-8?B?WDNwcVoxL2ZVTDB4dGFXaG5BdHVqOWJFaWZUWDk5VUV4UzdacUZWREVJejFH?=
 =?utf-8?B?eE9qVDU4UUNSRmk2MnlPaE5JN1ZweHpTRmtIRS9HUEZ0NU4wMVZ1dSs4T1F1?=
 =?utf-8?B?Z3V5dGV2a3Rwd3l6TU9WNC8xOHJLVDIyUjZoS2IxZDBUaDZRTGJ1dCtSNHo2?=
 =?utf-8?B?K1ZDNGtMeUxkMTlmSUlKK1FnemlndWRRWExQMXh6czV0UVFhZUNVZ2ZJVE12?=
 =?utf-8?B?VUNkOURFTG9CWFlBNTFIblo4Ly9UQlpKOGVpdWw5UHVLVTZkemJVOEFHZlpM?=
 =?utf-8?B?VzRCU210UDVqRU5RVWdkQTRBTGkvMEYrSGt4TDZsOTJRY3dnVE5wb24yMkJP?=
 =?utf-8?B?R0NNbHNYeVp3VXp4dDlPZktMR1l6Q09WT1U3Zy8yNHB2Q2VPcFBLSlhmS0lG?=
 =?utf-8?B?cFIzb21abmxCd2FHdE5ZWlo1ZE5Xc1ZnYXByc01PbWJ3Ri9zVzlrVVJxUHFT?=
 =?utf-8?B?T2pzNGdyQ1F0cTNvb00vcmhBWmFCRTJjZGtGVDJnZldlcWJqbmJLS2ZjL3pa?=
 =?utf-8?B?d1JEN2orb05VK3JLbjQ1NlZBdTRzNEswcERtblJXKzNVUFRrZ2p4SnUvbGZC?=
 =?utf-8?B?VE1WZVhCM21vYURzd3hKdExSZnZpQnlabXdXRk9JOE91ZThHNDkwSWJyREFs?=
 =?utf-8?Q?5WUvGP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10631.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?am95cWhIM0Q5eVpCeWJWemY0T0lqemhJYXc0UHovWVFabHBja2RsNWVsS1JL?=
 =?utf-8?B?OWhaME1DMG05ZzhmcEpnSTlrVjRSdVA5UGFmTXpIV09xQmd3NWpQUCtVRFRi?=
 =?utf-8?B?K2xLOEVVeHBMTzJRZVVRZUdqdHZheUQxU0o0OUpzOUtCTmxHUUFJNENlU3F0?=
 =?utf-8?B?a0lQOEpDYW54bHhiSWVCUjJBcnplVjcvQWNMbkM0ak56M2tZREd0QzhYbWpy?=
 =?utf-8?B?Q0NOeUpDazlqRlZhNitDcGRiNmZCZ2JBNjE1WGtYL29JaVkzNTlFZktPMElK?=
 =?utf-8?B?azhsTUt3eGdPVVpsOVY5V2VwSlhNeVR6ZUVJdmVLdGo3SnBod2lBODlaVHlQ?=
 =?utf-8?B?dzRZYm95cWV0elMvUGlVQmtUQzNwUGdHSXpwZzcwdjJ1Wjd6TWEvMFFFdnQ3?=
 =?utf-8?B?QkFkcWpERHpHaldTc0t4andEWHdRV1YrNzczTVByV21HeUJ5cHUzOWNGakFQ?=
 =?utf-8?B?T1g4K216NzlwcDRYRUsyZnB3aEc2K1czWnozNXo1OUxuT1YvYjdqMkZEL3BL?=
 =?utf-8?B?SzZxd3lsZGluNDRCSEtDb1YxN2RtMkdTT2pnajRSVzIxbnQxUDdOeTNJL0J5?=
 =?utf-8?B?MFJYeWJUZFpObHk3WWhxQ2c2NSs2UFZZamx6Wk14NWpjODlJY0Z5UGV6NlVO?=
 =?utf-8?B?UWtHc003OXpNeXRNUGlNSmRhczFuOUZONFZvVGgwNXdzL1hhandYbTg2eWtU?=
 =?utf-8?B?L2hPRnJzcXVmcW00dzJVVXFmYWV3eWRPbk43ZlUrczZ3WDJsb25rWWxFb3dD?=
 =?utf-8?B?b2VpUXgzUnprZXJ4Y1QyL1RGZVE4WnU5cG04UjBzMjBNbERqdHJDWXlaYzNH?=
 =?utf-8?B?NTdhVk5iMlFqcXRZeTlnMm4rZVVYaWRVS3pBYm9YZ3BQNDVpdDVBUkVUdkZt?=
 =?utf-8?B?RFZLRXdmZVE4S2VKTlFIMFUyOStYRjdMSy94ZlNsNHpwaUVRMUlRejFJWUZX?=
 =?utf-8?B?anlZOXErZTRLS1BvTkJwZ3h0Y0NGK29OYjQrN05UM2lYSlMxbDFuM2JiVlBi?=
 =?utf-8?B?Q09TOFhJWi9pajRNRXE1Q1FWdEMzbDJQLzArRW5GTnJOUmFWa0NVd0pDK2FU?=
 =?utf-8?B?ZGY2enpFa3ROMlhIVGpteFRsMnRQdVNHNGVXQ25sTElQdjdNemI5b1FKSG5s?=
 =?utf-8?B?WUlMK284aHFHLzBEZ29FeVVYeGhRSEY1VmYxMmhwQkFkeDkwR2lyY3lpZ1lJ?=
 =?utf-8?B?VDJaY1VMZ0JGM2U0TEV2b3d4b1VZU2l3cXEwOU9qNDdGN0x0VERTL3VZajh6?=
 =?utf-8?B?eU9WQ0VQdlFEMDRKMWNxS0FhQ0dVSXNDemRpbXpWYnVBMG96YzhBYkw3QVdI?=
 =?utf-8?B?UFh1T0VlbmMrRFBaOW5kSThkelJucWpWOHU2QnVLL0Z5MFU2VzZpam5DNmFH?=
 =?utf-8?B?UHZtRWplOWtFSGh4SWZuZWlSQUdXUjNLV2NCZ1FUTGR6UzE4VFdRUWF2UVRk?=
 =?utf-8?B?NXlPN2dCU1N3aGtadnZSM3V2VlFoaXNIQUNzcU44aXFoTEk5MFIwSHJNRjZn?=
 =?utf-8?B?SmFDY3BqcDBHUjFQL0YxM3A2SVYyWnJoa291MEt1cEx0UWVQeVJyQzlOSThj?=
 =?utf-8?B?RTVLTGIyN0h2QzNmaSt0RExwaDRJUWsxWDF5VFNzbHA3dnhsSWpTcUQySWJO?=
 =?utf-8?B?dW8zWU5ZVk5UT28yN0J5ZVh2MmtVZ1gxLzBFaU1WbG10VlNrQWpKcy9NUXZ4?=
 =?utf-8?B?QVU3RjJ3UkVUMHZJSUF6TFRoNW8xWEpTRlRHMlVVczJVUml5bVJwcHh6Ryt5?=
 =?utf-8?B?N1hRSjlaZXh5SERQYnpuN1M5OVNNUUhpaVY3MDg0NXFJek50TkdVNVpyTEkz?=
 =?utf-8?B?TmhTRGVpdXorMXM5RGxrRGJBM2lBaTVaMmc1d0ZqTUpZcm5oNWdlcUNLOHU2?=
 =?utf-8?B?U0xBWHdseVk2OTkzME42K2pPSEk5UjVZT3JpS3M5MjJuTjlFSkNxNG1Fd2Y0?=
 =?utf-8?B?RnR5cmE3NFdLalVvT01SME1ZeHZsM0lUcFhZNWdubklsakFqMUFiK0lTWTUr?=
 =?utf-8?B?ZGtLUk9kVGw3UmppVTJoRFBNNU5YUWhxblludnZFQWlxWXo0ekpwelBPL1pD?=
 =?utf-8?B?eTd6bXB4L0hDamE1aEZ4L3BONzM5QWtQNlN0L1crN0MzRWx6aDluWVNxRzR2?=
 =?utf-8?Q?pMRSiH9dWZV4+8uI2rxRQDoXB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B3A223773A924482168BBDE239DEFB@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10631.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0d74ec-8efb-4af2-b836-08de326c24c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 13:01:58.5455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzbQZL3ZV71J4rzr0wkW1du7cTT+6ibEz0d2tmd+mT+q0ixrqu1895spmK5ocWlc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6946

T24gV2VkLCAyMDI1LTEyLTAzIGF0IDExOjQyICswMjAwLCBWbGFkaW1pciBPbHRlYW4gd3JvdGU6
Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB2bGFkaW1pci5vbHRlYW5AbnhwLmNv
bS4gTGVhcm4gd2h5Cj4gdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5B
Ym91dFNlbmRlcklkZW50aWZpY2F0aW9uwqBdCj4gCj4gT24gU3VuLCBOb3YgMzAsIDIwMjUgYXQg
MDE6NTg6MzRBTSArMDEwMCwgTWFyZWsgVmFzdXQgd3JvdGU6Cj4gPiBBZGQgc3VwcG9ydCBmb3Ig
c3ByZWFkIHNwZWN0cnVtIGNsb2NraW5nIChTU0MpIG9uIFJUTDgyMTFGKEQpKEkpLQo+ID4gQ0cs
Cj4gPiBSVEw4MjExRlMoSSkoLVZTKS1DRywgUlRMODIxMUZHKEkpKC1WUyktQ0cgUEhZcy4gVGhl
IGltcGxlbWVudGF0aW9uCj4gPiBmb2xsb3dzIEVNSSBpbXByb3ZlbWVudCBhcHBsaWNhdGlvbiBu
b3RlIFJldi4gMS4yIGZvciB0aGVzZSBQSFlzLgo+ID4gCj4gPiBUaGUgY3VycmVudCBpbXBsZW1l
bnRhdGlvbiBlbmFibGVzIFNTQyBmb3IgYm90aCBSWEMgYW5kIFNZU0NMSwo+ID4gY2xvY2sKPiA+
IHNpZ25hbHMuIEludHJvZHVjZSBuZXcgRFQgcHJvcGVydHkgJ3JlYWx0ZWssc3NjLWVuYWJsZScg
dG8gZW5hYmxlCj4gPiB0aGUKPiA+IFNTQyBtb2RlLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
YXJlayBWYXN1dCA8bWFyZWsudmFzdXRAbWFpbGJveC5vcmc+Cj4gPiAtLS0KPiA+IENjOiAiRGF2
aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KPiA+IENjOiBBbGVrc2FuZGVyIEph
biBCYWprb3dza2kgPG9sZWsyQHdwLnBsPgo+ID4gQ2M6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVu
bi5jaD4KPiA+IENjOiBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Cj4gPiBDYzog
RXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPgo+ID4gQ2M6IEZsb3JpYW4gRmFpbmVs
bGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPgo+ID4gQ2M6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3
ZWl0MUBnbWFpbC5jb20+Cj4gPiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4K
PiA+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+Cj4gPiBDYzog
TWljaGFlbCBLbGVpbiA8bWljaGFlbEBmb3NzZWthbGwuZGU+Cj4gPiBDYzogUGFvbG8gQWJlbmkg
PHBhYmVuaUByZWRoYXQuY29tPgo+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
Cj4gPiBDYzogUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+Cj4gPiBDYzogVmxh
ZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4KPiA+IENjOiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZwo+ID4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcKPiA+IC0tLQo+
ID4gwqBkcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYyB8IDQ3Cj4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9u
cygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRl
a19tYWluLmMKPiA+IGIvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMKPiA+
IGluZGV4IDY3ZWNmM2Q0YWYyYjEuLmIxYjQ4OTM2ZDY0MjIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2
ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYwo+ID4gKysrIGIvZHJpdmVycy9uZXQv
cGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMKPiA+IEBAIC03NCwxMSArNzQsMTcgQEAKPiA+IAo+
ID4gwqAjZGVmaW5lIFJUTDgyMTFGX1BIWUNSMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MTkKPiA+IMKgI2RlZmluZSBSVEw4
MjExRl9DTEtPVVRfRU7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJ
VCgwKQo+ID4gKyNkZWZpbmUgUlRMODIxMUZfU1lTQ0xLX1NTQ19FTsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEJJVCgzKQo+ID4gwqAjZGVmaW5lIFJUTDgyMTFGX1BIWUNSMl9QSFlf
RUVFX0VOQUJMRcKgwqDCoMKgwqDCoMKgwqAgQklUKDUpCj4gPiAKPiA+IMKgI2RlZmluZSBSVEw4
MjExRl9JTlNSX1BBR0XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4
YTQzCj4gPiDCoCNkZWZpbmUgUlRMODIxMUZfSU5TUsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MWQKPiA+IAo+ID4gKy8qIFJUTDgyMTFGIFNTQyBz
ZXR0aW5ncyAqLwo+ID4gKyNkZWZpbmUgUlRMODIxMUZfU1NDX1BBR0XCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjNDQKPiA+ICsjZGVmaW5lIFJUTDgyMTFGX1NT
Q19SWEPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEzCj4g
PiArI2RlZmluZSBSVEw4MjExRl9TU0NfU1lTQ0xLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMHgxNwo+ID4gKwo+ID4gwqAvKiBSVEw4MjExRiBMRUQgY29uZmlndXJhdGlv
biAqLwo+ID4gwqAjZGVmaW5lIFJUTDgyMTFGX0xFRENSX1BBR0XCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAweGQwNAo+ID4gwqAjZGVmaW5lIFJUTDgyMTFGX0xFRENSwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MTAKPiA+IEBA
IC0yMDMsNiArMjA5LDcgQEAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwo+ID4gwqBzdHJ1Y3QgcnRs
ODIxeF9wcml2IHsKPiA+IMKgwqDCoMKgwqDCoMKgIGJvb2wgZW5hYmxlX2FsZHBzOwo+ID4gwqDC
oMKgwqDCoMKgwqAgYm9vbCBkaXNhYmxlX2Nsa19vdXQ7Cj4gPiArwqDCoMKgwqDCoMKgIGJvb2wg
ZW5hYmxlX3NzYzsKPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBjbGsgKmNsazsKPiA+IMKgwqDC
oMKgwqDCoMKgIC8qIHJ0bDgyMTFmICovCj4gPiDCoMKgwqDCoMKgwqDCoCB1MTYgaW5lcjsKPiA+
IEBAIC0yNjYsNiArMjczLDggQEAgc3RhdGljIGludCBydGw4MjF4X3Byb2JlKHN0cnVjdCBwaHlf
ZGV2aWNlCj4gPiAqcGh5ZGV2KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAicmVhbHRlayxhbGRwcy0KPiA+IGVuYWJsZSIpOwo+ID4gwqDCoMKgwqDCoMKg
wqAgcHJpdi0+ZGlzYWJsZV9jbGtfb3V0ID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKGRldi0+b2Zf
bm9kZSwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAKPiA+ICJyZWFsdGVrLGNsa291dC1kaXNhYmxlIik7Cj4gPiArwqDCoMKgwqDCoMKgIHByaXYt
PmVuYWJsZV9zc2MgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LT5vZl9ub2RlLAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInJlYWx0ZWssc3NjLQo+ID4gZW5h
YmxlIik7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIHBoeWRldi0+cHJpdiA9IHByaXY7Cj4gPiAK
PiA+IEBAIC03MDAsNiArNzA5LDM3IEBAIHN0YXRpYyBpbnQgcnRsODIxMWZfY29uZmlnX3BoeV9l
ZWUoc3RydWN0Cj4gPiBwaHlfZGV2aWNlICpwaHlkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSVEw4MjExRl9QSFlD
UjJfUEhZX0VFRV9FTkFCTEUsIDApOwo+ID4gwqB9Cj4gPiAKPiA+ICtzdGF0aWMgaW50IHJ0bDgy
MTFmX2NvbmZpZ19zc2Moc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikKPiA+ICt7Cj4gPiArwqDC
oMKgwqDCoMKgIHN0cnVjdCBydGw4MjF4X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7Cj4gPiAr
wqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwaHlkZXYtPm1kaW8uZGV2Owo+ID4g
K8KgwqDCoMKgwqDCoCBpbnQgcmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCAvKiBUaGUgdmFs
dWUgaXMgcHJlc2VydmVkIGlmIHRoZSBkZXZpY2UgdHJlZSBwcm9wZXJ0eSBpcwo+ID4gYWJzZW50
ICovCj4gPiArwqDCoMKgwqDCoMKgIGlmICghcHJpdi0+ZW5hYmxlX3NzYykKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCAv
KiBSVEw4MjExRlZEIGhhcyBubyBQSFlDUjIgcmVnaXN0ZXIgKi8KPiA+ICvCoMKgwqDCoMKgwqAg
aWYgKHBoeWRldi0+ZHJ2LT5waHlfaWQgPT0gUlRMXzgyMTFGVkRfUEhZSUQpCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiAKPiBJdmFuLCBkbyB5b3VyIGNvbnZl
cnNhdGlvbnMgd2l0aCBSZWFsdGVrIHN1cHBvcnQgc3VnZ2VzdCB0aGF0IHRoZSBWRkQKPiBQSFkg
dmFyaWFudCBhbHNvIHN1cHBvcnRzIHRoZSBzcHJlYWQgc3BlY3RydW0gY2xvY2sgYml0cyBjb25m
aWd1cmVkCj4gaGVyZQo+IGluIFJUTDgyMTFGX1BIWUNSMj8KPiAKPiAKPiAKCkZyb20gd2hhdCBJ
IGxlYXJuZWQgZnJvbSBSZWFsdGVrLCB0aGUgc3RhdGVtZW50IGFib3V0IFJUTDgyMTFGKEQpKEkp
LQpWRC1DRyBub3QgaGF2aW5nIFBIWUNSMiAoUGFnZSAweGE0MyBBZGRyZXNzIDB4MTkpIGlzIGlu
Y29ycmVjdC4gVGhpcwpyZWdpc3RlciBkb2VzIGV4aXN0IGFuZCBtYW5hZ2VzIG5lYXJseSBpZGVu
dGljYWwgY29uZmlndXJhdGlvbnMgYXMgdGhlCnJlc3Qgb2YgdGhlIFJUTDgyMTFGIHNlcmllcywg
d2l0aCB0aGUgZXhjZXB0aW9uIG9mIHRoZSBDTEtPVVQKY29uZmlndXJhdGlvbiwgd2hpY2ggaGFz
IGJlZW4gcmVsb2NhdGVkIHRvIGEgZGlmZmVyZW50IGNvbnRyb2wKcmVnaXN0ZXIuIE1hcmVrLCB5
b3UgY2FuIHJlYWQgYWJvdXQgbXkgZmluZGluZ3MgaGVyZQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9uZXRkZXYvMjAyNTEyMDItcGh5X2VlZS12MS0xLWZlMGJmNmFiM2RmMEBheGlzLmNvbS8KClVu
Zm9ydHVuYXRlbHkgSSBkb24ndCBoYXZlIHRoZSBjb21wbGV0ZSBkZXNjcmlwdGlvbiBvZiBQSFlD
UjIgb24gdGhpcwpwYXJ0aWN1bGFyIFBIWS4gSSB3aWxsIHJlYWNoIG91dCB0byBSZWFsdGVrIHJl
Z2FyZGluZyBTU0MgYW5kIHByb3ZpZGUKYW4gdXBkYXRlIG9uY2UgSSBoYXZlIG1vcmUgaW5mb3Jt
YXRpb24uCg==

