Return-Path: <netdev+bounces-238619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E9C5C05D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3611C359A0F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBD32FE045;
	Fri, 14 Nov 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b6blZ9ZX"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202242F530E;
	Fri, 14 Nov 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109505; cv=fail; b=ah5hK+4d51/geF0a2KpAHTiZ1pYppuLO4thI7Kq/Ls/wWR7zz+GEgFJcvS+2/SoPzb+xya4RmZ+HTcxoTyiCM8CWNSZiOrUc5dn7/2T0b+l7YfXewdmV/gaH3i3u8u+n+kHn4FgEltglHjKkVxR5E2aI2xU4YEclJIyBcM/bWCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109505; c=relaxed/simple;
	bh=j3Jp8WqiNCEWegcTlaIHMZgFfl87Kbf6LID7SGGCed4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nn9fDclJ7Jpre3gv72mePtfNbIFDWaGJDxbzPDPM0qRlvGXrnPV9a/S9MY2mEiy/xjXtmwjj5AlPYgQIf4DWYSGgyya0RU/EbEZ3a02G1x+KJdNXVKrXgFyHLnDblKjMT9ZipKX7jcUWzdX5qCxun/djn3HFZJTqr/OK4RWcs8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b6blZ9ZX; arc=fail smtp.client-ip=40.107.200.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOroQY2TJ4a/6QaWuqNeEqc/3SpeDpqMWrdQWk9/OCzQU8fwXjI53GoyFK/A4mziHK7zsyr/4Kw3Q/kUGEPyds6PxfJ35lA19nP7Sxe3c8JGBV24MpG6SJXuKKNwiWBFsstxUFdZFNH52HL3EKySo3V88fPPyMu87WY+/I1ds4DTNAcE8PaVMqd5dqGu2I2lQHb9/fx/8m5vpVKjIJUOpWpU4cUDTgKd1sp4Qu0IWmzcLn/NfzXPpLKNpzvKbXsH46dG0gFWerM373X2QWY231SZzBLe/Y/QlQYC6FZSz5JLsSoC0U7s9HcI9tKc6Bcrh/y0lMmv2a2lxB5J2OvCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3Jp8WqiNCEWegcTlaIHMZgFfl87Kbf6LID7SGGCed4=;
 b=xO/C/OwxoCfrbrGeCDRs2h3KgxZwOBXIQqQ4hQcND2Lxls9HKTD6zwcWmD8Kph9OAimtF7gHUKwtNJIfIY45JX1uHoQXhXEjDhDWc5Zwv/T4iO9nDgswb3IbL2zUTnYf8NGp67AOBG5dHWj6kkbeayATNcHfLVdf/V0/qORbWZkXXZOpikSlrIgz+UuT/mQHdQQyYEBY2rgy5fN6jOn+sXP1+bf1TsT2By+0h9I38Zxh0T9eMVtizFrE+9iZ7aaFHdMV4J6aBhBASh7eg+UdAUUKGihGFYR14y/UbQBYxfKRAhhNZGi0NnhYc3mmHASOC366J+hkLxL+CERTiBPJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Jp8WqiNCEWegcTlaIHMZgFfl87Kbf6LID7SGGCed4=;
 b=b6blZ9ZXLGpBtWaL/ErOVBzJU1r7L/2K4OGq0Uar6x/O+CQ1AIMR+IsNndsZ+S1CNYfWrBZa6gySoJfEYGOsnyQ3WgJ3hToTutLuw/onFWWX5YzBg3O0EJ8Kmp+BGvCBJGQcJZ+IG/4GMvzQT2UyQfHtGca/49r08UHGB1VXu4Sn1u0a3J9ZDRYbet4BG2/2FMVUBGRWPBnQvb+llkGVcN/RuLR3scNM86ZseqTt7BoVe5vda/zwu2ygZNbWvfVlG3NoAlars52aSMsxjAiiJ+PjKnHqyKAcO6ucyrtp0JEoXZtyZNwOQLMKJeeyk7PYeJGChcyeY9rkLD6RX3eR0w==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CY5PR11MB6536.namprd11.prod.outlook.com (2603:10b6:930:40::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 08:37:08 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 08:37:08 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <piergiorgio.beruto@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support
 for OATC14 10Base-T1S PHYs
Thread-Topic: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support
 for OATC14 10Base-T1S PHYs
Thread-Index: AQHcVJP+UJpYoKf3DEe3CA5/YgnL/LTwyEWAgAESS4A=
Date: Fri, 14 Nov 2025 08:37:08 +0000
Message-ID: <479bd561-3bc2-44fd-8bab-ecd3e62f9c3e@microchip.com>
References: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
 <20251113115206.140339-2-parthiban.veerasooran@microchip.com>
 <f6acd8db-4512-4f5d-a8cc-0cc522573db5@lunn.ch>
In-Reply-To: <f6acd8db-4512-4f5d-a8cc-0cc522573db5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CY5PR11MB6536:EE_
x-ms-office365-filtering-correlation-id: 255f3b9e-3aca-4ed0-66f7-08de2358ff4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tk8xYTFtUVNOU2NGemppM2o4VnVNL0h0QXFaMjdUcE5PKzlVRmVrWW1xblA0?=
 =?utf-8?B?TkVqa2pGV3B3cHhNVGJQYkRYOFE2WkI4R2VzSDJnQkpiTFQxTS9DaTExOEpN?=
 =?utf-8?B?K1Y4UFpUalBjYWhVTEYwRkdiaVRzYm53QU8vL3NRWllwdHZ0K0VJZWt3N2Vo?=
 =?utf-8?B?V1ZDWFNlNGFBbXRIK0lCeUdVTVBMZ014SFpCbmZhS0dDUmdGZ3pWNU40V01G?=
 =?utf-8?B?dXkvVEFCWGxQMnEyQW4wOXFESkNWWEp3aHE1cjJMOW4wNWdZMGNiM04zTzIz?=
 =?utf-8?B?YzdUc1ZGM3VPcWRSV3hnSDZaUU52bWhZL0h5bndIQkw3TmcvdFQ2TVBLY1BL?=
 =?utf-8?B?MmdWd0tydFdDZ0t5ZHc4dGV6WEI2WnhYbEs3U2hDdzl0U0VjbTA1NG9sbFBW?=
 =?utf-8?B?QnYzOGx1ZytpSUErSlJoNTRmMktYdjBQa0RxWjdUekM5bllxTk9vdWx3THBI?=
 =?utf-8?B?eHhibWc3OEtSSlZFRjkzaWdkNGtISVY5U2hYWjUzUGo5WVV6ZjdFNGczeDJ1?=
 =?utf-8?B?UGN1eFVFd1V5NCs1cG9sMk52ZGtHcUdYWVdENjI0MlJZU2JXVjN4YS9CUUw4?=
 =?utf-8?B?Nk5PTHdFVkMrNElLb1I3SGE4b2lmc0hoenZuMlMxWmNhV3RMRUdxYkw0VHBD?=
 =?utf-8?B?amEwSXVpZSttRXF3OURJZEhHR1lVcUY3c3JocXdRbXRRTVNRaUhtWCt4Y1RM?=
 =?utf-8?B?NWQwaWswUk1FZi9iYWRlcE5uSU83UDJLdzBNamgyRks3NVdYcEllTFRUYWc2?=
 =?utf-8?B?RVJOclpmYi9EQUoyMnpQNFhRanlnWVVTVE50ZVZ5dk5jYnRtTStpVWIwL3RR?=
 =?utf-8?B?MEgyYU9UWkUxbHJSNzVrRUF1SFVVdG1DRVpQWE5vaHJRTGtKbzNUYmwrT0gy?=
 =?utf-8?B?cVFvczF2YS92NHdpUzJZSG5ody9MMTNtZDdmSzI0RXFEYlp3dkZNMnYwZVFh?=
 =?utf-8?B?a2sxUnJIcG5mNGUybnY1Z1N1WWlIbWw0Y3hvUUNEYU5PdDkvZ0NuSEJVNlZM?=
 =?utf-8?B?UUQ5aFBRRU1OTkxVR0h3enFiRzNrcTZkMUcxeWkyaEt2WEhiaTJ6cGNvL3lh?=
 =?utf-8?B?WnhVaitGRUxCcVdOTUU3NEo5WDlDbXdna1V4RmQrTHhzTW5mNk03RlNqUWxO?=
 =?utf-8?B?YXFRSXQvSlJEa1VMY29DQytNVndubnQzN1l1K0RpaVh4U2ViRG5TSyt3SUZh?=
 =?utf-8?B?cVM4b3hWcExiL2pNTWZ0NzNKR0IzODBGSS9EZElYaCtsS3plaDZsTHhxbVcx?=
 =?utf-8?B?RWE4c2pOMnU5K2lHak9PQ205RzZBaXFKTWRWcWNRY0dkT0tpSGpmWWZ2QVV2?=
 =?utf-8?B?ejhpNlE2QnJNUjk0bU0rejkyQk05aHNkWXB4aG9iaUZSSjVlWHJIOHVUUnl4?=
 =?utf-8?B?U0dMSis0UEN0TEYzOWdHVzZzT0hOT3UxS0c2aE1RRGJiZkFSOTBFcXlBS2Rx?=
 =?utf-8?B?cExQZzdEWnNacmpYeWdiL2tIaCs0TERsbnRWd0pwZklnUlhDWDAwZzRwUkJZ?=
 =?utf-8?B?YjNESFR6d3FhVzVVTXF5aWEyZmt1UDZYQ3hUWnNoTC80UjBQV3QyWXlNT1pY?=
 =?utf-8?B?SktBOVdwdmxoRmJmZnRPSjhFV2VsL2x1ZEhMUVVCL1BNWUI0UFdkQU9VdjRn?=
 =?utf-8?B?Y3A4WUVBaU4xbUorZlFqbjdnMGFBd1c1QU9CSHRMWmQrUDBWVVZVSkE2TUJx?=
 =?utf-8?B?R3FvYXd3ZFEwaElJRW9LQkZnVlNKM2R3b3BSWVI2YVZLSmI4L2dwa3hOYjFR?=
 =?utf-8?B?YWM5b3JiNTQxZXZSbzdxaWRkNEdhbWpHeUZ4V05rSy91WXBaSWFQUklzUTdk?=
 =?utf-8?B?WFg4ejE1dURHd3pPVURtOTNld0FYdmE1aFdkZ1dpZGZ1MWt6SzhVRXNCY0w3?=
 =?utf-8?B?aXJQdTNSdWxzSlo1TnRFVmg0UjFEamxuSm15V1c3ZWpGZkhXZHVoNVFybDdm?=
 =?utf-8?B?SUpnajMwbnVreWRoMmpLVGtUcENObU0zSklaSWQ2bER4WFlVLzFBelJXYmVq?=
 =?utf-8?B?dzBHSzlJUnNkUHI3dmh6S1FOKzFWNEhqdHRJeG1WYzlhdmExREtEckNJcFEz?=
 =?utf-8?Q?LvDEzR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmVQMitGUFlvZEdzR3ZtcjNObm9YdG42K2MwOXZYMklMNFBmU1BKK2svRXVT?=
 =?utf-8?B?ZWRPMDRPdUpVem1oU1B4TUxseGtlb1ZML1lLNjVZOVdhc3hKZEwxdHV6TVVj?=
 =?utf-8?B?OTZHU3R1cU53OThsTnptOXo4QlNkbXB2QWpZd0NiYjYrU2pKQjFEVUdFd0tS?=
 =?utf-8?B?cHlpOEVqY0dKQ0x3c2NkN0VnR0ZMVUxmL01CcHpTRkh1UXNJNzZBcGYwWUpC?=
 =?utf-8?B?YjFnUGQrcWcybTZXMXcwNGp4N0RNTWtJaUJleGx5SVdZNnhIeitMamtmQ2tz?=
 =?utf-8?B?Ym9qRlZKbkFTbEdOWVMvQ2pSL0w1N0VYdVBxcXZPSFI1N0FmeElMVjluZk5Q?=
 =?utf-8?B?clVyQjVrSXVpcTM5U09kUDdlRFdZSlBuL2JwRlIvRTVEL25MTTZlSUFTcEc4?=
 =?utf-8?B?N2xnWVd4SnoyRitwWTBlek5IYlJDbDFTL3JYU0diNlJMVzNYNW94NWlIYnlM?=
 =?utf-8?B?TEVvWDRQay9YWEpRaWhMc3QzS0tkdVNEVTU4dUNjemZLWE9FK1dFNUZyUFBT?=
 =?utf-8?B?RlFZb1loVHF0UDMrWFR5bXVuWFdSdFJ5V0dsUmFRWFNvSDdVTGp2T1BqQnox?=
 =?utf-8?B?dzZmWFlrTlVaZlhWbkhWZTRoaW5qWTZGNmsyTktSQzVYeXpqY2xHcUd1Wi9G?=
 =?utf-8?B?ZHZsN1hkeXFBS0w2dXFmVWVnY012aVF5VkVqNHYyTzZ1Nkp0SGFSaTU3blJu?=
 =?utf-8?B?eW9PRFNLejBnL2ZyK2lzNi93TEtBQlllS0MxZzJ1WG4xVGJwY3ZmOEhmMjI0?=
 =?utf-8?B?TXE0ZjBBMUlWbkVNc1ppOWVHcjJUaitQUnd0T0IvZ3c1bWtLREFpK2FUcTFY?=
 =?utf-8?B?MW1rc1BRcE9ZbloyWFBkNEJTelZ4Z3haME4xeHNUbEhPM1JVNncydXBwVCtX?=
 =?utf-8?B?T0tQZ1BCNDdqYkxPdENtWWJDRXp4bmZNd2FjTFhWK3BoeDlzVnpKRWtqZW9l?=
 =?utf-8?B?cCtraUxLemNYMDYyczIrNEhuODlFQ21pU3B6cFdhd0F4UE1DdlYrdnYySGhU?=
 =?utf-8?B?ei9SdVU4Qjcra0tUVTdTYXduMU16QjJEZUxyVzlMNXV2S1ZKVzNtb3NySita?=
 =?utf-8?B?OHNFdVRpOXV0V29aNHFQMlJPejBEYzhyR3d0eTUxZWdMVXNsaDluY010d2U1?=
 =?utf-8?B?UGhaYTUrcnRXWUhSQ2hpTGFkUDMrU3VVcHFFZUFFVkRJS3QyemhLeVdIMDZ5?=
 =?utf-8?B?TkN5L1hXVkk4TW0ra2N0cVkvYUF4dWVHcThLdFZtZFpCN3FkbjQybmNFYTk2?=
 =?utf-8?B?R3o1M3NLbHFUdWdPamlxeVZhUUxnejFRWngzK3VmME9hV1o0ZVBlamJVN3l4?=
 =?utf-8?B?WVpFMFBxdERLZlJkZHljRG9QV1BSQmM1ZnM4dDZwZW1oaFoxd01VcHlEd2NS?=
 =?utf-8?B?VTAwTnE2aDlnOHk0WFRqRVVwVVljSmRITjZtSzFKWEtQS0lzTUp0WVZyaDFL?=
 =?utf-8?B?cGtiYzgxbk14MDBuR09WQTV4TjJOK2x1b2Vxb2xJUzNaWEJHZE5VdnFsOEJM?=
 =?utf-8?B?aE5MeE5lSnRPQklnT1BuclZ2QzQ0M0lGY28zRExRNnFDN05xeHZiY2RVTVhB?=
 =?utf-8?B?bjhCNWlCLzVZNkNodDhmTmhxM3M1S09XQUhFK3VrTHpuUXVkc0Z2L2czdzQ2?=
 =?utf-8?B?SElXckJLNXFzZklXZkttOVVRNFIwdFpJUTVBV0ZINTVHZXhBeWZmVlY2bW1v?=
 =?utf-8?B?VnQybEFGMnl1NDRXL3ZFN1NVRWc3WHBIVk45MGNVNVJCM0tWSFA2QUoxK1U5?=
 =?utf-8?B?R2Frd0dNZ0pjdndOT1IwQ0FrZmNUK1RtclJnN29UcndjVGw3QVF6Ymc1RDhT?=
 =?utf-8?B?UEN4SVVRYUl6dFE5OVNmSFJ4WnRIRjl6dTUrM2RWbTcvSVI5MWFoRTJSaDFy?=
 =?utf-8?B?UHF3dXUyMzM0NHVlYWxFMVVsVk84V282UjBHWTlQOGZzQzFzRlR1aEhHQUIv?=
 =?utf-8?B?Q1NiUTlWTlFHa2NvdGFsK1BrbHpJY20zZUNidXVxQ3VoT2xsR0YzSUhUZHNB?=
 =?utf-8?B?VDhDRzB0QTZEdm93cmJ5SDdVZGF4UWpmdm12UEZYenRrQWsrRVczWTZOOVNo?=
 =?utf-8?B?NTVWRkJDYlFiR01rQ0dSWUZmbG9NRUhTVDdZblNmQld3RWNKemFSb2R4RFBh?=
 =?utf-8?B?bm9adGlMZlVZeWR6a0U3Z05WTjVnUzdmK1JFd3kxK3h5NllxdmVFanFxSUdr?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88C41FE1DA38BD4BACCF1A65D65799BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255f3b9e-3aca-4ed0-66f7-08de2358ff4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 08:37:08.0144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3HRlEcazTwHMI8D3ulDztMf2Vtnf8qz46gz4WncyrD2a04rjZHzexUy28FqK61v4ymPVQJpGdNJNIQ+2KfeFBVYiwxV0edMJDuIM2EPCMof4pKec6RbGDJtU3hjkI5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6536

SGkgQW5kcmV3LA0KDQpPbiAxMy8xMS8yNSA5OjQ1IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKy8qKg0KPj4gKyAqIGdl
bnBoeV9jNDVfb2F0YzE0X2dldF9zcWkgLSBHZXQgU2lnbmFsIFF1YWxpdHkgSW5kaWNhdG9yIChT
UUkpIGZyb20gYW4gT0FUQzE0DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEwQmFz
ZS1UMVMgUEhZDQo+PiArICogQHBoeWRldjogcG9pbnRlciB0byB0aGUgUEhZIGRldmljZSBzdHJ1
Y3R1cmUNCj4+ICsgKg0KPj4gKyAqIFJlYWRzIHRoZSBTUUkgb3IgU1FJKyB2YWx1ZSBmcm9tIGFu
IE9BVEMxNC1jb21wYXRpYmxlIDEwQmFzZS1UMVMgUEhZLiBJZiBTUUkrDQo+PiArICogY2FwYWJp
bGl0eSBpcyBzdXBwb3J0ZWQsIHRoZSBmdW5jdGlvbiByZXR1cm5zIHRoZSBleHRlbmRlZCBTUUkr
IHZhbHVlOw0KPj4gKyAqIG90aGVyd2lzZSwgaXQgcmV0dXJucyB0aGUgYmFzaWMgU1FJIHZhbHVl
Lg0KPj4gKyAqDQo+PiArICogUmV0dXJuOg0KPj4gKyAqICogUG9zaXRpdmUgU1FJL1NRSSsgdmFs
dWUgb24gc3VjY2Vzcw0KPj4gKyAqICogMCBpZiBTUUkgdXBkYXRlIGlzIG5vdCBhdmFpbGFibGUN
Cj4gDQo+IEkgdGhvdWdodCAwIHJlcHJlc2VudGVkIGEgdmVyeSBiYWQgbGluaz8gSG93IGlzIHRo
ZSBjYWxsIHN1cHBvc2VkIHRvDQo+IGtub3cgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBhIGJhZCBs
aW5rLCBhbmQgbm8gbmV3IHZhbHVlLCB0cnkgYWdhaW4NCj4gbGF0ZXI/DQpZZXMsIHlvdSBhcmUg
cmlnaHQuIEEgdmFsdWUgb2YgMCByZXByZXNlbnRzIHZlcnkgcG9vciBTUUkuIFRoYW5rIHlvdSBm
b3IgDQpwb2ludGluZyBvdXQgdGhlIG5lZWQgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiBiYWQgU1FJ
IGFuZCDigJhubyB1cGRhdGXigJkgDQp2YWx1ZXMuIEFueXdheSwgYXMgcGVyIHlvdXIgY29tbWVu
dCBiZWxvdywgdGhpcyBjb2RlIHdpbGwgYmUgcmVtb3ZlZCANCnNpbmNlIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gY2hlY2sgdGhlIHVwZGF0ZSBzdGF0dXMuDQo+IA0KPiBJIGhhZCBhIHZlcnkgcXVpY2sg
bG9vayBhdCB0aGUgc3RhbmRhcmQuIEFsbCB0aGF0IHVwZGF0ZSBzZWVtcyB0bw0KPiBpbmRpY2F0
ZSBpcyB0aGF0IHZhbHVlIGhhcyBiZWVuIHVwZGF0ZWQgc2luY2UgdGhlIGxhc3QgcG9sbCBvZiB0
aGF0DQo+IGJpdC4gVGhlcmUgaXMgbm8gaW5kaWNhdGlvbiB5b3UgY2Fubm90IHJlYWQgdGhlICdv
bGQnIFNRSSB2YWx1ZSBpZg0KPiB0aGVyZSBoYXMgbm90IGJlZW4gYW4gdXBkYXRlLiBTbyBpIHRo
aW5rIHlvdSBzaG91bGQgYWx3YXlzIHJldHVybiBhbg0KPiBTUUkgdmFsdWUsIGlmIGl0IGlzIGlm
ICdvbGQnLg0KWWVzLCBJIGFncmVlLiBJIHdpbGwgdXBkYXRlIHRoZSBjb2RlIHNvIHRoYXQgdGhl
IHJlcG9ydGVkIFNRSSB2YWx1ZSBpcyANCnJldHVybmVkIHJlZ2FyZGxlc3Mgb2YgdGhlIHVwZGF0
ZSBzdGF0dXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gDQo+PiArICAgICAvKiBSZWFkIFNRSSBj
YXBhYmlsaXR5ICovDQo+PiArICAgICByZXQgPSBwaHlfcmVhZF9tbWQocGh5ZGV2LCBNRElPX01N
RF9WRU5EMiwgTURJT19PQVRDMTRfQURGQ0FQKTsNCj4+ICsgICAgIGlmIChyZXQgPCAwKQ0KPj4g
KyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gSSB3b3VuZGVyIGlmIHRoaXMgc2hvdWxk
IGJlIGNhY2hlZCBzb21ld2hlcmUuIFlvdSBkb24ndCBleHBlY3QgaXQgdG8NCj4gY2hhbmdlLg0K
SWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgZG8geW91IG1lYW4gdG8gc3RvcmUgdGhlIGNhcGFi
aWxpdHkgZGV0YWlscyANCmluIHRoZSBwaHlkZXYgc3RydWN0dXJlIHdoZW4gZ2VucGh5X2M0NV9v
YXRjMTRfZ2V0X3NxaV9tYXgoKSBpcyBjYWxsZWQsIA0KYW5kIHRoZW4gdXNlIHRoZW0gaW4gdGhl
IGdlbnBoeV9jNDVfb2F0YzE0X2dldF9zcWkoKSBmdW5jdGlvbj8NCg0KSW4gdGhhdCBjYXNlLCBJ
IG1heSBuZWVkIHRvIGludHJvZHVjZSBuZXcgcGFyYW1ldGVycyBpbiB0aGUgcGh5ZGV2IA0Kc3Ry
dWN0dXJlLiBEbyB5b3UgdGhpbmsgaW50cm9kdWNpbmcgbmV3IHBhcmFtZXRlcnMgaW4gdGhlIHBo
eWRldiANCnN0cnVjdHVyZSBpcyBzdGlsbCBuZWNlc3NhcnkgZm9yIHRoaXM/DQoNCkJlc3QgcmVn
YXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCg0K

