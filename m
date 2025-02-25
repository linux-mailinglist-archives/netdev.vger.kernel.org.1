Return-Path: <netdev+bounces-169303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D6A434F5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 07:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066CA16554E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B42B2561D6;
	Tue, 25 Feb 2025 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="DIQKTBw2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500014B080;
	Tue, 25 Feb 2025 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740463968; cv=fail; b=sQ652YQYIOhzDAISQvYySAUe4OGOVxF26IDZw1VE74m0+CPXqCWeVGqvfaNfvHCjZOqP5lJYjZwGbsE/CXQacLQ2Z0pyR+ZbK+2PQMx17qEIk1Df8X9smQh2Ojl4xLnN9CzL6G/gHVdS8z79CE5Lpy79nxuiFXeFGYrC9DISO7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740463968; c=relaxed/simple;
	bh=vC7HUtKp4GxIV+LTsDhYdMwBczS6p+X2/nwGxix07p4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j29rEmaat1qcNg5fUqCvMGMuxJk1IP7JxRvBZcys0Vf8qmOUAqgQFuHaCkOuATrOCLRDBV99PtCM4mCjsYVG/ofb4zTOnd2ymuT9q2OlseFl06c67Y1Z9rD+Py7uaV/ukLFdT+ZIkWvxgxR6/m5/gqbkAsD2aN2r5h63cVSyVp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=DIQKTBw2; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONUk3R004970;
	Mon, 24 Feb 2025 22:12:37 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4512gh8rpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 22:12:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYOMAh9ggoz/PZ3JU0r1wqqgvRXLv79gwqRjERhcj0WqulZxb92ttgKMHeBnzKfuD4EgnooXb28vEXUoBp2yNrwTX7+qYKb88Wp7ynwKqltMleVbb9sJL7Na9eT4ZMILT447dZX33SCUD+G1d0Cl56tTQuLFNDXZ/FiSchuHElTHoJW0GxNHmfG0dNkuBdSuYv7cDRiOx6ddAYpcuEmc4b4erbHKeQHVSob0J/QZIhNnEBX0asgVbtr+x/AiUxlC7cvoHXIMF+0FYOJKoR9WXzTdTqU8WZ2Itp20ztnYr3FBdlerFqu+hYxi+nEpjJeyFUdJf7CcF5PI2GrGw8I18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC7HUtKp4GxIV+LTsDhYdMwBczS6p+X2/nwGxix07p4=;
 b=Df5lstytXmpsGyCzxCnWvzpoDlKlocYC41zpCZRf5JXcZ6Duu0o4zc2vPGjuQrzSQZeY7W5yQj+5W8spvp8ddP/scsBfryAVUlE8OQqDI8iindphL7sD1bpzHmw2+PpRswF1pLKJ1e/F087LbS0v9znJSg21cn+dQsRRowTCcv+/Es1yMKpPYcoGN3Pl8NNq4bLq23ZxXXY/T5I8TB3KTMZ/h2woVbfptbv0KHdSM7RsvKupzkmhfwH9pMUnLjrSoKNoLobz+iIs6xtR0m5toAChO9dHEMVpq3omFaD8NRs/zXnbaijiXQkLEYOftGiyegWgYLfZBSsgOFEowk8cEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC7HUtKp4GxIV+LTsDhYdMwBczS6p+X2/nwGxix07p4=;
 b=DIQKTBw2Ctl3tcSPCfTxHSxQbfObjDkPXyW3/Hrn2MnqsRfqSMDfHgjbkeFPp/PwbYQhohlaDC2u76uKnSj24+2cLmuJ5SeQh/fRIvBfVvxTp2MMHXOevX6GEOGnfsoe3oLaReRe9eYClNrIN98eAxTbp5buJPISUit0unRBdcg=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by PH0PR18MB3958.namprd18.prod.outlook.com (2603:10b6:510:2b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:12:32 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 06:12:32 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v10 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
Thread-Topic: [net-next PATCH v10 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
Thread-Index: AQHbh0xBbZHt8yYQC0iyYs/WAEy6+Q==
Date: Tue, 25 Feb 2025 06:12:32 +0000
Message-ID:
 <BY3PR18MB470765FAF7160544D7032C0FA0C32@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20250217085257.173652-1-saikrishnag@marvell.com>
 <20250217085257.173652-4-saikrishnag@marvell.com>
 <1a053f30-4a13-4199-bf1f-40b729b4a146@redhat.com>
In-Reply-To: <1a053f30-4a13-4199-bf1f-40b729b4a146@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|PH0PR18MB3958:EE_
x-ms-office365-filtering-correlation-id: a949698e-1543-433b-f8ad-08dd55636426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0lGdW5JUE5NZ1VFNlppMk9tYzdSOHh3djBuTWpLd3h1TDRlWXFtK2tiRWls?=
 =?utf-8?B?cDV5N3h2dkwra1REY3oyRFJEK1VOZ2ZlYVVkNUZRdEN2NThCUExZczJibEtQ?=
 =?utf-8?B?c1FHM1dBZUV6eFhvUGZiZjBicC9BSnU5S3ZBb2VEYks0RlM2TjJTSFhpYlA2?=
 =?utf-8?B?bGw4MjI4OWRtLytZMnVEOW9QODJrMFl2N3FnYkx0SllIek03TkJoOE9IT0M5?=
 =?utf-8?B?YW5UTmZDUmJvWGtsdHh1cE1rRFVDTUFLMlYxenp6UllBWkhmTnNVZzZUbTN6?=
 =?utf-8?B?ZFRaSDQ0bms1TUtyNkgzcnBBeUVkM3BsREZ0d3NzMlZVZGkzZUEwSlo2Vys5?=
 =?utf-8?B?ZHFWby9tdXZJRjlKZGx1a21YWERKcUJ5T2k0M0ZTcTRsTDRSYXNjNk9tVFpr?=
 =?utf-8?B?cGpxYkVFbmFkVERsazN3Szd3YnZvVTBhSi9EZzNlUzFNSmJMV0FQcnMzVVVP?=
 =?utf-8?B?c2FTczlHcnVnNWhRWHJ4OFhPMjZMMGFYd1dsdiswb0VBd3ZwSlZTWXQ5NzUx?=
 =?utf-8?B?UlY4N0RYVm1GLzJYS0g3djRJM0dUdEhBL3UyaFM4WDdpYmJJaG90VDRQaTJa?=
 =?utf-8?B?Q3VDNGRVMVhFZi9aV2VhMjJGa2ZnYUZJN05pdFZIbTFKRjdoeUs2dFR6bG5j?=
 =?utf-8?B?enhDV2RqY1JmZFY1VnBVYU5COUQzSG5iekJWRFU4bkl1ZVVteUF2UVBaa0Qz?=
 =?utf-8?B?WkN5WkFZNXNaUU5TK3V5c3VXaEdmMlIrTjJGajVoQWlndWVxTHNhSnBuWGhP?=
 =?utf-8?B?bnV2U0k5b0ZVcnlkeDMvSWo5ZUtZbDkxSlBCSUQzaUxTdkRBdDFIRGJDYUtj?=
 =?utf-8?B?YVBoM0dqZ3hnaWhNRU9EM1A1WWpuaWk3dGhFM29DdmJ1VXBkREgyUlpEQ2xJ?=
 =?utf-8?B?ZzdiNlhPMEN5QzB3VkI0T3lBY3dRTXFEWXEyNUd0RW5GRGtOZVgwcUZ1THFJ?=
 =?utf-8?B?MTUzMElQZnlKZjBEWUo5aHdON1llTjNjL3hNZU5sQXlZaUVxL2ZoQVRRb1p3?=
 =?utf-8?B?RDJZc05LcnIrMUtJRzZkUk0wMmVCaVZzdjlOVnJIMW45a2Vha1VnK05WM0ZZ?=
 =?utf-8?B?cDBRbkNNY3FxUWxzTVZvSzVTYTR3OTNXSW5uMzhPbHIyeXFvVEN5K3N3WmxF?=
 =?utf-8?B?ZVVEU1FLdXkzWE5SWUJIWEtpV3dkSzFEczROMm9TZjE2NXZ4MTRRdUcyUUZz?=
 =?utf-8?B?a2Fad25VNzRwZW51ZGxCSk5aREh5T2wvVFZXM09XVitlNzdHUE1NUDBKWDI1?=
 =?utf-8?B?aEFjd2p4c0wwY3pFVnhVK2pDNXRvYkhUMXBhVHV3b2dSamg5ajlweHYycVpJ?=
 =?utf-8?B?bFFWNGZGYTNEaVVPdmdndS9GR0ZWMDRYUDFqVGlXSlA2RnQ5WHZXNUpsNkg2?=
 =?utf-8?B?ajM3ODBwMTNIcC95aTBnTkJoMmhvYnFmMWhVaXh3cWIzR3RkcXE0YnR4UU9K?=
 =?utf-8?B?akJXNFR0MHo2aHVSTzRVQnkrOVJHWjlZMExPOXFIRHZjbk94dXZYdVNDSWNm?=
 =?utf-8?B?RU9zWWFUaUJ0akhVdjUxSkFCL1JQY2tJa2x2dVhkUWhLN0xpdUNYcU5xbEJV?=
 =?utf-8?B?VnAxRkZxQ09Qc0JybjBBM3F1VUJBbGF4TWdSSEdsZHZoWUdDSFZyQTMrV0tS?=
 =?utf-8?B?TzVzT3cwZTljZlFUdnB4VVpTVW5zbXJxTmhmWkNBSm1qTDI5N0UxZVJDalFM?=
 =?utf-8?B?ZWltbDlDcll2VHhlWjdFTWJWR1lLTjRTUHBXT2dkbk4waVFPM09hdFJvTFRW?=
 =?utf-8?B?ejQyVjdTaEx2Mk1xMFliUXJUZC82NnI2eVFaQVB6TlBDWFZma0p4eDRpMFFz?=
 =?utf-8?B?OStSaVdDa21DSkViNTgzVmRkV3AyOXExT2hOVHFFb3RXMXQzdStDa0orODUr?=
 =?utf-8?B?T0hTVHgxNkVuS3dHa0dncThDM1Z2MTVTNlZBcUN6ZmlWOU9MaUgyRWswTFVL?=
 =?utf-8?B?cnVmUTNrUlJERW40N3F4Z29xcGM1OHJWY2JsY2FicWErNWlEZGR4VXJBSDFa?=
 =?utf-8?B?dFdvbWUvWkFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bm5FeGdJNWFzeFB2Ym96dm0zQWZqT2pXTDduNy9mRVMzMG9LOCtYTHgvV2Nk?=
 =?utf-8?B?dFh6cFhaZWh5dm93K01VRUJzYUxEK0ltM1VEN3crbVNsYm0wU2Z5eWQwNERQ?=
 =?utf-8?B?ZlZKZysrOExFV21EbVBxY0tTZzl4T2RvWTZHZndtUCtKdTdmOGdBWkUydW14?=
 =?utf-8?B?ZnV0UUg5TDI2YlEvdHFqK3VmNjE4Ri9kK0NZdUpMbVJLNzRCK0owdVZNWjdY?=
 =?utf-8?B?YWxlRjJ6aERIK3ErVElLK3l0eFFMbjdlNjlpOGMrMWRYZytGS2pnOFVHK0Qr?=
 =?utf-8?B?L2QzWG5wNUVaaTNNNXVaemF4a05TR0dpTWtrRHJWbXlTSkp4SlBrNk9zMktl?=
 =?utf-8?B?ZkRKVjdYQy9abkNmbkRVRWhydU9vbm1pbEVxSnhKZnpmeUVOazNJZG5rM2FY?=
 =?utf-8?B?Q3BOYkppMTAwUzhrU1pwdVlEOFJWNzNnS0FVVlRrNnpucGZMUFA4TWFuc1Fu?=
 =?utf-8?B?bWlQckJmNmgzK0dBTTh6T290L2s4Ky9NRE9leXUvdVRhY1NZSlJWVGE1NlVW?=
 =?utf-8?B?TmRycWlMdE5FSmx1ZlZHRCtLSGFGRmVkUDZzaVZZYk9NQTZRK2VDbjRZSWVu?=
 =?utf-8?B?SWttcWdBMDk5MC9vRTgzRW9lNDd1Mi9lTmliNm5jNThSSVA5RGRCTjN5VWo3?=
 =?utf-8?B?NVVIeUM4SDRPNUJCY1l2S3J2bUE5S3d1N2xTSlhWUGdsSzh6bVl4a3hXYnhU?=
 =?utf-8?B?QXptUVIzcFN2YnBJd0dwU1BjM3BxN1hpYWhnZ01wTGxLNUV3U21hSzhBY0lo?=
 =?utf-8?B?UWxENDROQmN2am5tR1lkYXpiR3FlNXZ2aFY1bXBiRFJBdGw4S29PZHVnazhp?=
 =?utf-8?B?NTFzZE9UZHh1aTJ4NU5HSVJZUGNQbXN5K0ZCN1plU05Wang1dmZLbkpPa3Bu?=
 =?utf-8?B?VTVDTm1IWFEwcEZ2ODErbmpqRHREMzRGN013RmovMEZYWldab1YweWQzcElS?=
 =?utf-8?B?bk42WGQwWWtFRWhjNW0zUEYyLzdreElDRzZrdHdYdmM1c2NaZm1QMUNrbGlz?=
 =?utf-8?B?ZHVUZGI1V3JScmVzYllKVm94S1AzeVNBTW1Ta1B2RG9OOXhPeTdsU0ZVcmk0?=
 =?utf-8?B?Nk93eFRPayttaUM0RFMzSUREb1dUUUlOeHdoYzJZV3FWRVRWRjFWNFVLUG9S?=
 =?utf-8?B?bU5oSU16RER5Y2dSY01GTUdjWExhMFJzZjEwSlBpdURQc3gvd3I1M1dGNDBp?=
 =?utf-8?B?QTlpdDhiNjB5RTlNcnJkK1lwZXFCM2VKZG5mZ2U1YW1YUWxncGhlVXVrakND?=
 =?utf-8?B?Y2x1UjFjVUtVNFpVSUxsN2x2dzFUMjBXcy9IdU1vMk5nZDZ1QzVPc2tHQ09v?=
 =?utf-8?B?NGoyQ0RHL0FoQ1Vqd3hNNGxTNWhDbGNJdCtMK1lsc1RlSHNhdEtJOUFubW15?=
 =?utf-8?B?MUdudDVONk5leEpHN2xRYWhVbkpNdEc1eFBINUdZZDg3MGl1emd3NGtPQVZT?=
 =?utf-8?B?S0dpQS93RmtVY1NCUWxRR2tKY0dSTnIvTHU4ME5UN3JwbEtaSi9ST1hBKzJ1?=
 =?utf-8?B?bjNBOHhVMVAySHR2TExpWW5uemNhNVh6SENLRmNCOHplaU5UZC82VGgvTlhV?=
 =?utf-8?B?TnpVczkvOXo5Q1E4aHNqMFc0emtsYjJMSEdLdi8rR09XUHRZYWVCQjZKdlFD?=
 =?utf-8?B?c00yN3ZpYmg2MzhTVWlzemd4bkZxQzNtdFRoYnY2MkJtSktPQy92akgxV0tr?=
 =?utf-8?B?YWx6dG9vblJsSkVnTldHM29GQ1BGS1dCRVB5emxoRUNLMHlyRVZuL1U0bWQz?=
 =?utf-8?B?N2FRMytkMlVMRVQvVkRzSk1pRWlXZ1dLSXNOUkxSU2I3TGJ6c3hhNk01M0tB?=
 =?utf-8?B?TkJOSDc1VVZ2VlN1cTdERTlsdHJOVlJ4NGdackZBQzhaVVYwK0xkVTV3WXZi?=
 =?utf-8?B?R0xyK0Ziekd1TXVsZkNEK0x1TFhqcVdqQWMxLytROG9LK29WbDlqSXN6OUMr?=
 =?utf-8?B?Ly9NWnZmYTBzYWF1SFQ0QXE1ZEppdVFPOGdvbTdiU0lzRmFncTFBcGZVYlc1?=
 =?utf-8?B?QnNjN0Vzb2hwTU1zSnlCN01WVUJQd1RjeTFyNVR1ajY0NDg5YWVPSk8xbEFR?=
 =?utf-8?B?cU52TjNjOU9DNktuRm5lNHJJTU9qblZZRWpZaGdyVnNtdk5Vc01mWThzcUw0?=
 =?utf-8?Q?4daa8X7qTltis9v0eGMxLOEXi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a949698e-1543-433b-f8ad-08dd55636426
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 06:12:32.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oSdoBsEl30uASb71GxgXaPIIXxQ/rDVFWKhWZWfZ1ZOsit+IJ682PUJ59EHIAAkoVDJbI5wYnAzviJuJCUL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3958
X-Proofpoint-GUID: zZF8qBUMy_ICigSI6Blje0ibehRHigAh
X-Authority-Analysis: v=2.4 cv=FLrhx/os c=1 sm=1 tr=0 ts=67bd5f54 cx=c_pps a=BUR/PSeFfUFfX8a0VQYRdg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=LfCKemM-NgIMvtPINUUA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: zZF8qBUMy_ICigSI6Blje0ibehRHigAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMCwgMjAyNSA1OjI5IFBN
DQo+IFRvOiBTYWkgS3Jpc2huYSBHYWp1bGEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPjsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgU3VuaWwgS292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47DQo+IEdlZXRo
YXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+OyBMaW51IENoZXJpYW4NCj4gPGxj
aGVyaWFuQG1hcnZlbGwuY29tPjsgSmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47IEhh
cmlwcmFzYWQgS2VsYW0NCj4gPGhrZWxhbUBtYXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5kZWVw
IEJoYXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsg
a2FsZXNoLWFuYWtrdXIucHVyYXlpbEBicm9hZGNvbS5jb20NCj4gU3ViamVjdDogUmU6IFtuZXQt
bmV4dCBQQVRDSCB2MTAgMy82XSBvY3Rlb250eDItYWY6IENOMjBrIG1ib3gNCj4gdG8gc3VwcG9y
dCBBRiBSRVEvQUNLIGZ1bmN0aW9uYWxpdHkNCj4gDQo+IE9uIDIvMTcvMjUgOTrigIo1MiBBTSwg
U2FpIEtyaXNobmEgd3JvdGU6ID4gVGhpcyBpbXBsZW1lbnRhdGlvbiB1c2VzIHNlcGFyYXRlDQo+
IHRyaWdnZXIgaW50ZXJydXB0cyBmb3IgcmVxdWVzdCwgPiByZXNwb25zZSBNQk9YIG1lc3NhZ2Vz
IGFnYWluc3QgdXNpbmcgdHJpZ2dlcg0KPiBtZXNzYWdlIGRhdGEgaW4gQ04xMEsuID4gVGhpcyBw
YXRjaCBhZGRzIHN1cHBvcnQgZm9yIGJhc2ljIG1ib3gNCj4gaW1wbGVtZW50YXRpb24NCj4gT24g
Mi8xNy8yNSA5OjUyIEFNLCBTYWkgS3Jpc2huYSB3cm90ZToNCj4gPiBUaGlzIGltcGxlbWVudGF0
aW9uIHVzZXMgc2VwYXJhdGUgdHJpZ2dlciBpbnRlcnJ1cHRzIGZvciByZXF1ZXN0LA0KPiA+IHJl
c3BvbnNlIE1CT1ggbWVzc2FnZXMgYWdhaW5zdCB1c2luZyB0cmlnZ2VyIG1lc3NhZ2UgZGF0YSBp
biBDTjEwSy4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgYmFzaWMgbWJveCBpbXBs
ZW1lbnRhdGlvbiBmb3IgQ04yMEsgZnJvbQ0KPiA+IEFGIHNpZGUuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNhaSBLcmlzaG5hIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL2FwaS5o
IHwgICA4ICsNCj4gPiAgLi4uL21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL21ib3hfaW5pdC5j
ICAgIHwgMjE1DQo+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAuLi4vZXRoZXJuZXQvbWFydmVs
bC9vY3Rlb250eDIvYWYvY24yMGsvcmVnLmggfCAgMTcgKysNCj4gPiAgLi4uL21hcnZlbGwvb2N0
ZW9udHgyL2FmL2NuMjBrL3N0cnVjdC5oICAgICAgIHwgIDI1ICsrDQo+ID4gIC4uLi9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvbWJveC5jICB8ICA4MyArKysrKystDQo+ID4gIC4u
Li9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvbWJveC5oICB8ICAgMSArDQo+ID4g
IC4uLi9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmMgICB8ICA2OSArKysr
LS0NCj4gPiAgLi4uL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnUuaCAgIHwg
IDE2ICstDQo+ID4gIC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uYyAgICAg
ICB8ICAxMCArLQ0KPiA+ICAuLi4vZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJf
cGYuYyAgfCAgIDkgKy0NCj4gPiAgMTAgZmlsZXMgY2hhbmdlZCwgNDIwIGluc2VydGlvbnMoKyks
IDMzIGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvY24yMGsvc3RydWN0LmgNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9jbjIway9h
cGkuaA0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvY24y
MGsvYXBpLmgNCj4gPiBpbmRleCBiNTdiZDM4MTgxYWEuLjk0MzZhNGE0ZDgxNSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9jbjIway9h
cGkuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2Fm
L2NuMjBrL2FwaS5oDQo+ID4gQEAgLTE1LDggKzE1LDE2IEBAIHN0cnVjdCBuZ19ydnUgew0KPiA+
ICAJc3RydWN0IHFtZW0gICAgICAgICAgICAgKnBmX21ib3hfYWRkcjsNCj4gPiAgfTsNCj4gPg0K
PiA+ICtzdHJ1Y3QgcnZ1Ow0KPiA+ICsNCj4gDQo+IEEgZmV3IGxpbmVzIGFib3ZlIHRoZSBoZWFk
ZXIgZmlsZSBydnUuaCBpcyBpbmNsdWRlZCwgdGhlIGZvcndhcmQgZGVjbGFyYXJpb25zDQo+IHNo
b3VsZCBub3QgYmUgbmVlZGVkLi4uDQo+IA0KPiA+ICAvKiBNYm94IHJlbGF0ZWQgQVBJcyAqLw0K
PiA+ICBpbnQgY24yMGtfcnZ1X21ib3hfaW5pdChzdHJ1Y3QgcnZ1ICpydnUsIGludCB0eXBlLCBp
bnQgbnVtKTsNCj4gDQo+IC4uLiBvdGhlcndpc2UgdGhpcyBsaW5lIHdpbGwgZ2l2ZSB3YXJucyBp
biB0aGUgcHJldmlvdXMgcGF0Y2guDQpBY2ssIHdpbGwgc3VibWl0IHYxMSB3aXRoIHVwZGF0ZXMu
DQo+IA0KPiBbLi4uXQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jDQo+ID4gaW5kZXggOWYxNDVjNTQwMjUzLi5h
Y2Q5ZTFjYTZkMmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVs
bC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMNCj4gPiBAQCAtNTk3LDggKzU5Nyw3IEBA
IHN0YXRpYyBpbnQgb3R4Ml9wZnZmX21ib3hfaW5pdChzdHJ1Y3Qgb3R4Ml9uaWMgKnBmLA0KPiBp
bnQgbnVtdmZzKQ0KPiA+ICAJCWJhc2UgPSBwY2lfcmVzb3VyY2Vfc3RhcnQocGYtPnBkZXYsIFBD
SV9NQk9YX0JBUl9OVU0pICsNCj4gPiAgCQkgICAgICAgTUJPWF9TSVpFOw0KPiA+ICAJZWxzZQ0K
PiA+IC0JCWJhc2UgPSByZWFkcSgodm9pZCBfX2lvbWVtICopKCh1NjQpcGYtPnJlZ19iYXNlICsN
Cj4gPiAtCQkJCQkgICAgICBSVlVfUEZfVkZfQkFSNF9BRERSKSk7DQo+ID4gKwkJYmFzZSA9IHJl
YWRxKChwZi0+cmVnX2Jhc2UgKyBSVlVfUEZfVkZfQkFSNF9BRERSKSk7DQo+ID4NCj4gPiAgCWh3
YmFzZSA9IGlvcmVtYXBfd2MoYmFzZSwgTUJPWF9TSVpFICogcGYtPnRvdGFsX3Zmcyk7DQo+ID4g
IAlpZiAoIWh3YmFzZSkgew0KPiA+IEBAIC02NDcsNyArNjQ2LDcgQEAgc3RhdGljIHZvaWQgb3R4
Ml9wZnZmX21ib3hfZGVzdHJveShzdHJ1Y3Qgb3R4Ml9uaWMNCj4gKnBmKQ0KPiA+ICAJfQ0KPiA+
DQo+ID4gIAlpZiAobWJveC0+bWJveC5od2Jhc2UpDQo+ID4gLQkJaW91bm1hcChtYm94LT5tYm94
Lmh3YmFzZSk7DQo+ID4gKwkJaW91bm1hcCgodm9pZCBfX2lvbWVtICopbWJveC0+bWJveC5od2Jh
c2UpOw0KPiA+DQo+ID4gIAlvdHgyX21ib3hfZGVzdHJveSgmbWJveC0+bWJveCk7DQo+ID4gIH0N
Cj4gPiBAQCAtMTMxMiw3ICsxMzExLDcgQEAgc3RhdGljIGlycXJldHVybl90IG90eDJfcV9pbnRy
X2hhbmRsZXIoaW50IGlycSwNCj4gPiB2b2lkICpkYXRhKQ0KPiA+DQo+ID4gIAkvKiBDUSAqLw0K
PiA+ICAJZm9yIChxaWR4ID0gMDsgcWlkeCA8IHBmLT5xc2V0LmNxX2NudDsgcWlkeCsrKSB7DQo+
ID4gLQkJcHRyID0gb3R4Ml9nZXRfcmVnYWRkcihwZiwgTklYX0xGX0NRX09QX0lOVCk7DQo+ID4g
KwkJcHRyID0gKF9fZm9yY2UgdTY0ICopb3R4Ml9nZXRfcmVnYWRkcihwZiwNCj4gTklYX0xGX0NR
X09QX0lOVCk7DQo+ID4gIAkJdmFsID0gb3R4Ml9hdG9taWM2NF9hZGQoKHFpZHggPDwgNDQpLCBw
dHIpOw0KPiA+DQo+ID4gIAkJb3R4Ml93cml0ZTY0KHBmLCBOSVhfTEZfQ1FfT1BfSU5ULCAocWlk
eCA8PCA0NCkgfCBAQCAtDQo+IDEzNTEsNw0KPiA+ICsxMzUwLDcgQEAgc3RhdGljIGlycXJldHVy
bl90IG90eDJfcV9pbnRyX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGF0YSkNCj4gPiAgCQkgKiB0
aGVzZSBhcmUgZmF0YWwgZXJyb3JzLg0KPiA+ICAJCSAqLw0KPiA+DQo+ID4gLQkJcHRyID0gb3R4
Ml9nZXRfcmVnYWRkcihwZiwgTklYX0xGX1NRX09QX0lOVCk7DQo+ID4gKwkJcHRyID0gKF9fZm9y
Y2UgdTY0ICopb3R4Ml9nZXRfcmVnYWRkcihwZiwNCj4gTklYX0xGX1NRX09QX0lOVCk7DQo+ID4g
IAkJdmFsID0gb3R4Ml9hdG9taWM2NF9hZGQoKHFpZHggPDwgNDQpLCBwdHIpOw0KPiA+ICAJCW90
eDJfd3JpdGU2NChwZiwgTklYX0xGX1NRX09QX0lOVCwgKHFpZHggPDwgNDQpIHwNCj4gPiAgCQkJ
ICAgICAodmFsICYgTklYX1NRSU5UX0JJVFMpKTsNCj4gDQo+IEFsbCB0aGUgY2hhbmdlcyBoZXJl
IGxvb2tzIHVucmVsYXRlZC4gSSBndWVzcyB0aGV5IGZpeCBjb21waWxlIHdhcm5pbmdzLg0KPiBT
aG91bGQgZ28gaW50byBhIHNlcGFyYXRlIHBhdGNoLCBlYXJsaWVyIGluIHRoZSBzZXJpZXMuDQpB
Y2ssIHdpbGwgc3VibWl0IHYxMSB3aXRoIHVwZGF0ZXMgb3IgcG9zdCBzZXBhcmF0ZWx5Lg0KPiAN
Cj4gL1ANCg0K

