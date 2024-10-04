Return-Path: <netdev+bounces-132013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC3990239
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736032847E3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20B157494;
	Fri,  4 Oct 2024 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jANZuSZJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E51B157487
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042144; cv=fail; b=fWQkr0XVpKUNManOg7xPWlY6CSaTK8vRvGkD1tXqUjePJSapq8LYFDylO0BglS+HClFX+RvAmvXSXTaBbER9q7a5jllF4D3XLdasUpc+tQWV45caO8MfJh4OVlPhTOYBTZhcYVLH2dCQJqlr1lOp/dPc17+v45rxn+duhL6rL5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042144; c=relaxed/simple;
	bh=th2lBwkuVKZxlvZZORO554fr+KXlBbXTEMYDcto0Ubc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+aFJXZStBbM1rUpl3iGJ/Zbla7zE0WOJckv66MUFIwb6npmPJOw1G1irS83tjn4b545REYYHVLrAsGAlLJa7ET+70aaCG8Dv/Ic6U0TvOCzyCSNc+VVM0wUWCnW7CjMJDl5XqJCxzU4gTcwSKft7PzVC/2wjzjKeshrAPz5lT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jANZuSZJ; arc=fail smtp.client-ip=40.107.247.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVeqLSisEpWEyKhDlm7X8iFuYbez5HxOXlRgufdsXddXVZkKsZq0CZ/c9oYu0VP+NuEoQDgl9IQBOkcxNlzC4iR76kM3XZOX3KVraZdcyKgSkg+0B5XxX/dKfehFz7a9naL71O8fvoq8dddKz/Hpe6Q1EqBE6ZnqYTtptpThsTXS7oqKEPuP2tzBP/YrQ+FdUv0Gc0MMiZWitSkN3ve5rHFRZanTgnCrHY7cxPcikhE88omSUlEdmZ+t+M5jR+F9CoN6IOvzG0nO+QxxRwr6oWuvMUtjTPHtoSPoGzs0IpmPQNJugwKxBvwxiz+wHtxY7N/CCI/MR961EpIe3AJ4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th2lBwkuVKZxlvZZORO554fr+KXlBbXTEMYDcto0Ubc=;
 b=iUgj4PZXBD2JF72KRQkEIoa076VpvsYKM8Gglp+h0a+iVjSLvm3SKXv0mQsLNryIZPiqfLXds9kfG5/ejiYt9yT89OGMKBKmN2NoNuCA4AQhLm7ACqdavUuZIPgkj5DGV0EZpEZLZutAsyjsuar1XRzTx0bvpSt03CxJFP2evUL5ki0RXyIdAgSEaDQLE3bX+M0/uYyQhNYfci1nBFtJSS1wvqzJ++4zSne194pf3zm6plTcUdnPVQafHS1J4ZBr1dI1pNJLlFNs15xUnUhW9DojghYVF1p0ndOXob6+Glg11pDEa0GRzdQiiG45scEIgiJ+19JNYY+1WUzcrBKW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th2lBwkuVKZxlvZZORO554fr+KXlBbXTEMYDcto0Ubc=;
 b=jANZuSZJdXHua1x7GSOhxyZShqOT9InIsIuzwVErLOuyse0T2sF3qYW1hU4zRmfVI8VxHcvEleE3VZfvrIVrBYzR6VLG/Ay05/0i+7uy6JzLaLz21r2tJKgaSDD+ExBs3cHiUxq3bjsPeNziwIkqOjVgPsPHr0yRar4Vt67ga29kRHXBXfmV6A/YRyAOKpSPUPWlLcLwWAgI/jIXpU5OtlZzUH7s0PPPRUjROXbStyfDi5c5k/mKgDX0PhIwonhuIoAH8q1JEiae/MD3jJBuJeEUldP5H3HX2FF9KNtiS7enGTemZXFQ91CIb1WlsyzcUA2vj8ejvi1fpgbtPP+Eug==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB5PR10MB7872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Fri, 4 Oct
 2024 11:42:18 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.8048.007; Fri, 4 Oct 2024
 11:42:18 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "agust@denx.de" <agust@denx.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH net v3] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Thread-Topic: [PATCH net v3] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Thread-Index: AQHbFjxUS1Hq6akyG0yGwOnVLCd5Y7J2YQsAgAAXaYA=
Date: Fri, 4 Oct 2024 11:42:18 +0000
Message-ID: <a0a25186fb532668d27243a7743a078fe855d1db.camel@siemens.com>
References: <20241004090332.3252564-1-alexander.sverdlin@siemens.com>
	 <20241004101830.4z3lhux6i5nki62o@skbuf>
In-Reply-To: <20241004101830.4z3lhux6i5nki62o@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB5PR10MB7872:EE_
x-ms-office365-filtering-correlation-id: 7b0b49d8-4689-48a7-d6a3-08dce46999df
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3pmS0VMSGJ4Ymo1KzRGNk0ybHJ5TjFPT3d0WXhRMUs1amhpQkdRQXExVStC?=
 =?utf-8?B?MExVZWwreGJ1L3B3UFBuWVhKK3I4bEI5cGFkZXpCU0pSenFmQ2hPOVYrYnQr?=
 =?utf-8?B?MDFLWmtJd0Q1UkF3V3k4aGZCeVphNFZ1SFlkSzl5K1d3MlFSbjRBdy9zempF?=
 =?utf-8?B?a0h6RFcvbElXdUQrY0VrcFNMblBkSXR3ZVdOMnI4VE5YVHBzaG9BMUhWOG4v?=
 =?utf-8?B?ek9ZSEt6UTUwTTFOWlZ2RjVzbGF3Y1lWcm9XNFh2NXdPbDVZR3MyemVjYkNO?=
 =?utf-8?B?VE53cEtyNmx3V05FajBwU3pJblFjZllKWVRiKzJXbDBaV1NBeEdrSzJsRDN5?=
 =?utf-8?B?Z3NiZ3JtdlNDUDQyaXpvSWtvRXYxZFhMTFF4WFYxYUE0eDFHVW8yN1gyZFZk?=
 =?utf-8?B?bVdpK09DeXovcmVYRVZ3VEZFNE13U05TOEN2RFJGdXhSVGxkcWJHZk02eFk0?=
 =?utf-8?B?YVowSW4wSitoL29KMHVjOXR3NEtZYnd0cyswNGlhVWU1dkpPeUJTa0doK0FP?=
 =?utf-8?B?MWUrN1B0RzlucGFCQ2dDMUF4Z3UyUXEwRFN3cW5hTHRRazZzRjJGTmNtVmRW?=
 =?utf-8?B?cGJaNUhFc3ovaW03ZzlEVUJwTXZmdjlpU1NabzZiSFNHSzhkWHF0VE9RdFQ3?=
 =?utf-8?B?QTNES0ZTYW5PdDBmZjVMZWU1TmFqTEFtVzRLUjZEdkptTlJSL3VtRVBQZ2I2?=
 =?utf-8?B?cVU3TS9udkVLdVp3NlRCZld3MUU3aVhsa1AzZjNxRDZGbFdJdGp4QTR0NmRT?=
 =?utf-8?B?SnEydlNLUWpDNTVNenora1FSUzdMMVlDc05ucno0NGFzdU05NllHSGNrL1g1?=
 =?utf-8?B?aUJEMGV6Y0VtM3BzVCs1My81aU1vVXI4MFN0T0FlUFBucm1IbDhjd0dzaFU3?=
 =?utf-8?B?Nk1pSU9uUDJMZkN5NkFDem1UU1M4U2h1bWVYdjlYL0JjTXc0VEgvQ2RpcXFl?=
 =?utf-8?B?ZWdJTllRbFVjaFQrSkpzbUQ3bmdGdDhsWGhZdEZtRDNkcG1DYmpoSUgrVG1v?=
 =?utf-8?B?WFZtekVZY0VNL2g3ZjQ5MllRZVVvVCtPemp4SEVuNHhoWmZ6YlBIdmJGWVBx?=
 =?utf-8?B?REJIQVRWK1huOUdkK3VPNW9ZanU3U0MzcXA5UUJ5VFlUQXpTVER2R1dLL2I1?=
 =?utf-8?B?NS9jN3VLOGhLMENtVWxYZzA3YVJsNjV0UDVTQXJQT1B2TUhXVUN0Z0NnYjFa?=
 =?utf-8?B?OEJLSDZmZC9rV2ZlZ0hFK3liaXlQaUZNWlhLRGVBM2N5ZSsxRURMM2ExOTY0?=
 =?utf-8?B?Mk84UTI0a2dzQXYzU0dYVzJJRXNQTHowcXgzYndQaGM3OXV1QzA5cXMvd2ZT?=
 =?utf-8?B?dUhvVXZuems1OUNwL0I4UURNNkgxaVlSbTJrdG1pelNZRllUL241S3J5eGhR?=
 =?utf-8?B?SHN6aUtJTElNVkFtRFczc3VjbXZad0FFb1FLV25hWVpydDBvQStpSXZ5dTFh?=
 =?utf-8?B?U2pYSkZZR1dYazljRnE3THNBQjlvSjEyZFlGdUg3bitGVnlPTmV5K3NsT08z?=
 =?utf-8?B?NDFTTUhlMThNZVQrWWF2UjE5T3VkNnc1NWlUYXNIcEZFemEzaDcvTUtKNjhv?=
 =?utf-8?B?d3FvWUdMNzl5Yi9qekRUQXd5OTRIcFlBQ3JRK0hDUzhmcUlnaUdkdlAvWkxC?=
 =?utf-8?B?ZTBMcC9rVk9GdXFDOW9McE5GazRwcEVSbkNyRk8wZVkvMExzYmRHV011UVpY?=
 =?utf-8?B?NkNEUnZvYkM4N3ZDNXB1Z0xxRG1vY1NYTk1SR3o4Y0VXQWxiYnVyZlNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejVUMnRmcnFqVEdvU2hyaVNtZk9hMzdiZERQS2twemdtR1VNSVlUTWdWVnlr?=
 =?utf-8?B?aHloVXlhV3IrRTU0TERNa0Y5WnpmU242MS9MSjJnSGtLMDhGb1k5LzlDbS9U?=
 =?utf-8?B?UWd0RGpyQnYyT002SEFlU1pMMEJkZHoyaDlHREZ2K0pGVlRWSmJjWTROaVZH?=
 =?utf-8?B?ZHhYbmNlZGRrd2o1cEFYZXo2bjA1WTNHVFJHRGs1Si9zV2UyRDkyWVUvclVk?=
 =?utf-8?B?KzlQd1cxaUpWaE5sQzJwNi84TVBTYWtlVk0rVlBpaWNkY0g5T3ZlTHptYzlt?=
 =?utf-8?B?S05zSFdVVktXZ1JjaElpWlVXUjVKKzhNOHFwZHdXdXF4SlN0QTdBdy9aRnU1?=
 =?utf-8?B?eTJBWXZrTFJVa0F4ejZkWDNaSFZZaDJqMXpEaEVsK29YVFdvMGJoaDF5ZHBs?=
 =?utf-8?B?UGxkNVNteHBMK0NlS2N5WE1FWHBmSHhtRWN5NVYyQkRlTzF0YTJLRXl0cGF1?=
 =?utf-8?B?RFlPdXIza0RhRWxlUDE4V1c0S3Mwd3ZNN3RyWkJqRWtCWk1idHpHeDVJTWQr?=
 =?utf-8?B?dkZYTzFhNlJkazdEbFYwSHNwc0txRDFQYjBBajg3WGNMd2t3TWF2cFpPRjVL?=
 =?utf-8?B?a2sxMENhYUUwclZja1Fjb24rOUZpU3hubmt0Ty9pb1J1TFdGTWtvS1BRWmc2?=
 =?utf-8?B?NG9QVitNaU5uOVFVWk0yQzFFVzRhUHJXS1JZbCtkUGVOV0tlRVdmZ2s3MXFN?=
 =?utf-8?B?eUpweHBEZkhEWktlcHFpUjd1RXJmU2I4WEhGSlhsNzdXNndqRmxjL2dJMWNI?=
 =?utf-8?B?S1ViS3M2QWVWWEFuR3JYN2xRbDNMandoRU4vdU11TWFTd0RiT092ZmhqUUNT?=
 =?utf-8?B?LzdITy9PNjc1R3phaEVqMk5xU2dYTVBOSGIrQ0RRMlQzekxhUCtnVnY2UHlR?=
 =?utf-8?B?QnJlN3ZEOFFBdCt5T09EZzFjZFpGUHE3dHpBVXVaU3drTXFkeVhteFRhSWVt?=
 =?utf-8?B?aGxVYWxlRlNtVE5BWTY2Zmx2d2p2YkhwSW9Qa1pvZ2owVXhMcCt5eEEyZWtz?=
 =?utf-8?B?cXcvOWN2c1ZFK29NbTMxRVRzbWNySGxkT203WjNuZ0J3c3ltOXhSODNqY1VF?=
 =?utf-8?B?ZW5mYlJIQzMwYS9aa2hiYWEwK0pDZThDSEZOZCtSVCt0WjlPZktpMU5PQlg3?=
 =?utf-8?B?VVhNbmsyTlg1akVyYWlMTjBMWkwvVUR4MFRVZXFVcmZuOVI3bUwyUllmY0k4?=
 =?utf-8?B?SWNSTjdNUUhGTHo5eVdhVk1YWGZOUjNWRzRCRWJnY1lWbEZoOWtBNEF4bU1t?=
 =?utf-8?B?bVlFYTY0Q05ISmtJMjgzSmt5NW1SYnlGR29NTFp4STdoMHhOTllYa0x4VlF5?=
 =?utf-8?B?YjB6Q1BZTWRzd1RpNjBxejZSdlRFVDBnbC8xanZEYmJVS0dObGNPTlAxQTcw?=
 =?utf-8?B?elBrOW1ZeVVVVGZxYnl0VFlmNmZjQ0RXNWxoVVFBZ0cyNmNySzlya2x3Mm41?=
 =?utf-8?B?STJCdmNqR21SMzF1SDZ0MEJZa21Pamp1WXd3bjVMUHViUzltRFVOdGUwTERZ?=
 =?utf-8?B?cHczTjVwMm1iZjh2QkVybmcwK3h5dXptUko1SDBpUHFMV1JxVXFEVFNrdFQr?=
 =?utf-8?B?VEU2eGw3TXRwWEF6WURFNVRSS1dONTg2SnZqMFhLeitnZ1hicmZKVllWM0Jp?=
 =?utf-8?B?SWxmT1ZuOWVhYW16Mm5hdlBCRHgvbHhOL2F0TGhYNVRPMVJSVkZ3Nk96SDJD?=
 =?utf-8?B?OGVKS2ZBeUQ3U1krMHZLc3pyRmpvTzY4VUFtaE1ZWDhibVZkanZkQlc1MmlE?=
 =?utf-8?B?K2Z1RWxpVEx4UmNOZ0dOWnJzTmxDRXAvUUNwYkpoT1VKNHFHUkhiVEgzUmht?=
 =?utf-8?B?WHJXYjNqbWZWL3BWMDd2VVYxV0QybUlsbis0eExYUFdjRWtKT1RqNFA0NHF2?=
 =?utf-8?B?M1VWMldZOFBDb1JqbWZvNmQxM0VwSkdHQ0s0QlBCdjMwbEpGWm9zY3p4THN3?=
 =?utf-8?B?VXhFMm1LOVhHbXVrdFBKTEw0N3FUczE1dEJ0NkRvSm1WQU94STNRSGU0OHNH?=
 =?utf-8?B?QTRadzNwUlc5WUJsSnJ3VEtWOWxvaHFMaFpDSE1nK2JZZXArNXdDMjcycW9R?=
 =?utf-8?B?dEpUNHhqSmhZSFBYdXNDZk1xcWZFY2htS1ZETVRCTUg5L0hOckNnZm96SEtI?=
 =?utf-8?B?eXVaKzZQNlBwQUhqQmMvWHBvR0N3blpOOEp2eWY3c21xMExFMHBnZjAxRDBZ?=
 =?utf-8?Q?VRU/b3ldLnzj0mR1JqgqWUE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23D5C45EC9CD174099F965151D71E790@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0b49d8-4689-48a7-d6a3-08dce46999df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 11:42:18.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA1EHh4Va6NVq/j9nRSw78i/6xqptkgelMti6Zr9n9dQj/X7FxEJatJ/nzBGPBq7/8lgE2R9+cBDNFLr6JM4eq0wcmo0T1Z23HPsoL/+AOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7872

SGkgVmxhZGltaXIhDQoNCk9uIEZyaSwgMjAyNC0xMC0wNCBhdCAxMzoxOCArMDMwMCwgVmxhZGlt
aXIgT2x0ZWFuIHdyb3RlOg0KPiA+ICsJaWYgKHJlYWRfcG9sbF90aW1lb3V0KGxhbjkzMDNfcmVh
ZCwgcmV0LA0KPiA+ICsJCQnCoMKgwqDCoMKgICFyZXQgJiYgcmVnICYgTEFOOTMwM19IV19DRkdf
UkVBRFksDQo+ID4gKwkJCcKgwqDCoMKgwqAgMjAwMDAsIDYwMDAwMDAsIGZhbHNlLA0KPiA+ICsJ
CQnCoMKgwqDCoMKgIGNoaXAtPnJlZ21hcCwgTEFOOTMwM19IV19DRkcsICZyZWcpKSB7DQo+ID4g
KwkJZGV2X2VycihjaGlwLT5kZXYsICJIV19DRkcgbm90IHJlYWR5OiAweCUwOHhcbiIsIHJlZyk7
DQo+ID4gKwkJcmV0dXJuIC1FVElNRURPVVQ7DQo+IA0KPiBQbGVhc2U6DQo+IA0KPiAJaW50IHJl
dCwgZXJyOw0KPiANCj4gCWVyciA9IHJlYWRfcG9sbF90aW1lb3V0KCk7DQo+IAlpZiAoZXJyKQ0K
PiAJCXJldCA9IGVycjsNCj4gCWlmIChyZXQpIHsNCj4gCQlkZXZfZXJyKGNoaXAtPmRldiwgImZh
aWxlZCB0byByZWFkIEhXX0NGRyByZWc6ICVwZVxuIiwNCj4gCQkJRVJSX1BUUihyZXQpKTsNCj4g
CQlyZXR1cm4gcmV0Ow0KPiAJfQ0KPiANCj4gTm8gaGFyZGNvZGluZyBvZiAtRVRJTUVET1VUIGVp
dGhlci4NCg0KSSd2ZSByZW1vdmVkIHRoZSBoYXJkY29kZWQgLUVUSU1FRE9VVCBpbiB0aGUgdjQs
IGJ1dCByZXRhaW5lZCBkaWZmZXJlbnQNCmVycm9yIG1lc3NhZ2VzLCBiZWNhdXNlIEkgYmVsaWV2
ZSwgaW5kaXZpZHVhbCByZWFkIGVycm9ycyBjb3VsZCBiZSBtb3JlDQppbmZvcm1hdGl2ZSB0aGFu
IGdlbmVyaWMgLUVUSU1FRE9VVCwgaW5jbHVkaW5nLCBtYXliZSBldmVuIHRoZSBhY3R1YWwNCnJl
Z2lzdGVyIHZhbHVlLg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3
LnNpZW1lbnMuY29tDQo=

