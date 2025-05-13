Return-Path: <netdev+bounces-190255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE5AB5E4F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C73986761A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D81E7C02;
	Tue, 13 May 2025 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="elEKzdIl";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="QeLbYnxS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E219E967;
	Tue, 13 May 2025 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170952; cv=fail; b=h/Qq4wLiBYt8SfS0wZJAmyZS/fe8YdoCJp0KwaS2Gv3vJOyo90GuoZzc807bzVAXuaMBFWixfNS+4yT5R+q3iRq0YvVN18bqP5LfrAnreohSVhlx8MGH+uxWr1BKTcX40wilpGR6P1smwajYGb0mX99PrZoJr+clpMLX3c/q/kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170952; c=relaxed/simple;
	bh=q2pT6KMUR9ZRRXqvNBA2vTIXKIRWwkJpq7Bcai10q84=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=qRCJcDeZFVccw6N5VDygZEA4sLVA1TNkJaFLjIB0POd2OqPcd5uHeyQ0bZeojtnH97BJw7Tqo3pzZAQF2PapCFhq1Ihtndufgt0lFIPsfcTmnwPLCqBNTV5hDAEr8lusNgCcKFx/l5Y6jexNPbsG9rw0QZ+L9nRwNaQ9PtnoNL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=elEKzdIl; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=QeLbYnxS; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIRRCx013350;
	Tue, 13 May 2025 16:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=q2pT6KMUR9ZRRXqvNBA2vTIXKIRWwkJpq7Bcai10q84=; b=elEKzdIlV3Jf
	655dXwnJIK6esVIhdZyaolRU/0ZymNWwR3inHT1abDFRab8gKdGO8UVe6IcI4KZY
	UiPYadNzpPEqs7qc7vPa5pjHX9P7Ih8BCPOzeqy4UPxUn6ElLT3HLERSZVAiCjKo
	xWs4dfGQS2xvw4ylDOZIax6OuEtQOY/NVLWK897RZkn8eVrUamOQktT/7Tcx2U/o
	BVZKAOK8eIdB/qM01RoyukWKJldhZ6tscj0bgwhxPs7Euapkn/5Z+TBLkhD0I1Vl
	6d9XJSX8gmlfyOF2MckA5dOsbdMH0Z5L2/N1yXr8aGFB9sNMKU6mg5gl4wClFczw
	CiIwejuvGg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46mbch898h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 16:15:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHzKFvAXHRCP7+oqO57roFViITUPONosZPhiPTRYaBiCyEO4YAeGRy9qPve8J4aTn4ZglXrCuJysTnwKjYTlkyFnwb7CcrENNGIJd0nDB4WMuT9vYOSPpw/6OACFxALTeGAGhHUFf89GKe5x8ojZQ6txwwASoMlIWSfzaAtic+FZdOc6M3TX+TqePm1ePwDM8U/z2eaEks+Xscp739yD61+hOXPYl7H4oUARbzH18QIitGCdMgi5UotYX3QhGO2AzwjRy1tCYnmZyyMuhAhWhP1lp8Mrt7bOYNqoWmO2e1mR8vZOXWRyw6nqkmUagnKjyCd7TgI98iZMQrkuAIgT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2pT6KMUR9ZRRXqvNBA2vTIXKIRWwkJpq7Bcai10q84=;
 b=D2iezyQb2d8hRpebedEIYn+bzI2ux43005oZkgu/80MSI5JgHpxlsFlLj1fMCwVV0psAZdbsekjaU0M8bJm215A3mr7DXQ+pLTM5GiNDptjtKKveCaUi10R0KVhkHXvvEkCFDKSuY7vlwDxdwqXoD2I8nQmsxw8JtLnSfzZQlaucZY2IGlD+SnkBtylbrblr0VST3+ubzGtmU3OZ/c6ILcS7RV53V47/fxXMGHFaHdE/kCWzNtmDuSeB2X12nUEp5fhVPlnJW4CwGPLX/gO978VO1AQP9rmC/kS0EhqT8oVgE6DLO+2CvvX6/9iot1X1bFtx6Qg20QLqKRrgY4og+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2pT6KMUR9ZRRXqvNBA2vTIXKIRWwkJpq7Bcai10q84=;
 b=QeLbYnxSRDN/LpEiniYMNbOLigfbmUY0omeR3lCkzJV+K0+gLwXpDdU3My0eV8n2Qr1vJkrAyY17y8sB4SN19T98l6SYVahSRyNPS0jFeO0gyHNWVXpyPQXsur8n9/58O5+qWE8Sf1lYGr9qDFcqAMcOhBj2ZjE8uUlzfIBHVtg=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 21:15:22 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Tue, 13 May 2025
 21:15:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:15:20 -0400
Message-Id: <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
From: =?utf-8?q?Damien_Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
        "Rob
 Herring" <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Silicon Labs Kernel Team"
 <linux-devel@silabs.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Johan
 Hovold" <johan@kernel.org>,
        "Alex Elder" <elder@kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <greybus-dev@lists.linaro.org>
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
X-Mailer: aerc 0.20.1
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
In-Reply-To: <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
X-ClientProxiedBy: YQBPR0101CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::19) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|DS7PR11MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ee4432-412b-4c8f-59b6-08dd926345a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXVVZFdPRktMRnlabThJU0RTNjFwaXpYTHgwL1pFbnc0WGhqYXh6QWI5Ulpj?=
 =?utf-8?B?dU1Rd2lHSDJEWUlnRWh5N0lNMW5MZTZrMWlQRStoemgraXZ5YlRCWjFZYzB3?=
 =?utf-8?B?L1B2S09zZG1hNmlZVGlDTmNwMzhvV05WZm9zUXRLak5oN3RhQWJwRkVrVjA5?=
 =?utf-8?B?NmhTeWF2bTBSRE9DbFB1NnZJaGVYZjMxYjA5MlE4NDZWNjRhUWNsOXZZOEdW?=
 =?utf-8?B?R3BsMXVqY00zK3g4THZHRWRCdnhHd1dvWG1NWktLY0NodkFnc1NLWGkwak5Z?=
 =?utf-8?B?OUtrbzNVa3VvRWZpSE1EN3VOaE5Oa09keFY2ZXZMY1V5TWxlUjI4RW5EVnlR?=
 =?utf-8?B?TCtWV2cwSzIvazAweDRxU3VOSlE3OEYxRlNtWm11Q25UNGJZVHkrcGRWZ2Zs?=
 =?utf-8?B?c3A3VU4wS0pVUGRzU1dtZ1p5VEticUlKZ0N5NGpOSm1yV2hobXlQUXBKYmpj?=
 =?utf-8?B?NDJ4cGpHMlAwdGdCaUtJNHpPdUx3MUU3LzRjZVpQRm5nWUsxOWlqTWM0T2N4?=
 =?utf-8?B?d0hCdVkydFB1UnZBMXNHVTd5SCtRd2lqV1pqeGJKSmU1d1RmSWVKQzdmUkNR?=
 =?utf-8?B?RE5YY1RUN0Z6VG5HVWs0N1FMUU5oNlRJUU9zNXIwUHU5RVRxQmVKZllxTGo1?=
 =?utf-8?B?R083ajRockFraDNCWGZ2WUczWnlJTTkxbTNsTW55TkwyL0M2bVptdDVaMUMz?=
 =?utf-8?B?Q2dORHlTOWNlS1JPYlR4NmZxK3F0cFltbzM1dzg4YWJnaXhBOU5ONmVkWVQ2?=
 =?utf-8?B?S3lwaDlnRzZNTXNiK3JQenorTjVKdEZZTGRGd0ZDOStJeW4vTEV0NnVkdCtL?=
 =?utf-8?B?YWNQbEVZYUF4WXFJcVJBQXBMNVhLQWhBR29HdEVwZVU0cWlDTjVxYXBQWUdm?=
 =?utf-8?B?MlQ5STd2ODFCRHExY3pneXNGY05iRFRNSXEzaitlbmhvUE5NRjdtbzBicFNO?=
 =?utf-8?B?eTlxSlJvWW04TEwvWXhLNUFpeWdSREtOWlBwVVY5SlVzQVNCU2hFYWhacXdw?=
 =?utf-8?B?QURYUElKRUpCSml2OHBZLzdRTnZ2aUljTElSRm5JTlN0cFN1aVBJdjNIQ3R2?=
 =?utf-8?B?Q2VudWZHb2o4eWc1aWZRZzZyZm5HYmRyTFBib2lxV3ZTOG50dU5kMTdJdmtI?=
 =?utf-8?B?djhMQjZZRmorVGxUVU4zd1NDZldhZWhpODE4c0ROOWN2c1dlWm12MEE3djJN?=
 =?utf-8?B?N2JTMHk0OTYxSUlOSUFvZmtjYU5CdmlUSnRjVjcweTlPYzYxTWRQQy9zZWZP?=
 =?utf-8?B?eHBBd3hCVHpLNkVrODNHYmN0TjdLcGhGVUR1TE5yY28wQjVpdDVRcDQwUGQ4?=
 =?utf-8?B?bVp4dndLOWtDQVBBQlhGSDlvdDZkVWI5eVdsOGlXUExzVitxM0pmREI3Nksv?=
 =?utf-8?B?bTRFMzBLdVhpbk9WOVhWMS9SWHpmemVLOU1nc05rcVdISW0wR2QydG5oQzFl?=
 =?utf-8?B?b0Nlcys2RmUxR2cxRjBwbXFNSGJmODZGcVFOOVAzR0krL3d4ZTdxWW5DWjZ6?=
 =?utf-8?B?dDZ3eHdvakw5b2V5RlZMVVhlOHVBVExZR3o0UTJJQXRVZWxPcDRwNFRrQWV4?=
 =?utf-8?B?WklqQVB5K1lVRnZDRWg5aURDT0JNc01hcU4wbVVBc1EycEJjb0pRaXQ2a284?=
 =?utf-8?B?TGhKNkxCSTZiaTl1Y1k0aEVDQ3U2RUkvdEhVam9YTnMzeUNKZWNRd1hwRVZy?=
 =?utf-8?B?U3I3V21WcmVoRUlRNElybGJWY1RZSUZ1TS9ndENQQ0ppekdtVC9HWSs0cnlF?=
 =?utf-8?B?VFZEU2JIS1dMWGhaT3hvSXlrdHg3Z1M1eXR5cVVyR3J5WEo4QW9UaDNwbStX?=
 =?utf-8?B?RDFXOFVycndaVUgzSlVjSGxWSWhKYm9ROWRYVlhFd083Z3NGbmVEaXllODhL?=
 =?utf-8?B?d01PTlNrUUU2aWxWdFUyTEVPNHQrY3htemJxWXVOcHVTOXRlYXFvRXlOZUxs?=
 =?utf-8?Q?kmo8gcUTv9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmdYV29TZHpFdEExOS82THBlOXRJWDZLVzBZV2xZeWVIMUVzNEY5dW1ybE1n?=
 =?utf-8?B?c2tjK2hEWjZuM0ZoRmJaaXVEeXI5QVc0Y3lBU1pYdUQ2U25yTnhoNGdhRlli?=
 =?utf-8?B?TlJ0Tm5NOXFXM041SEwzZUtJUGdiVCsyZ0dZWUZOL3ovUE1YUVpZRit6Wmw3?=
 =?utf-8?B?VStkR3F0dWNxM3Nwd1hKelk2TVJjdmdobThqaERuMVE5UnpYU0pNZHNDWEJa?=
 =?utf-8?B?dStGUUpvcHB5L2greHV2b2VsWjl2dUtmNy9KdlQwMmVTUWRYWXI0TFVNVDhv?=
 =?utf-8?B?SDZ4OVl0OU5FNWZpeDJYZThpaE5abE5kTytXakNqZUtMR3VHaUk3TFF4ZThU?=
 =?utf-8?B?VFV6UEsvdUhFZ2RLU1NQcndjSCs1QzRGRU90MHoycGJGMVZmeFJKS3MzM2pX?=
 =?utf-8?B?RHRwZzM0WFBuVmdDMm1jTERVdmN5UytIUUppWHlrQkpJc0t2czNzYkYxRmhQ?=
 =?utf-8?B?SHlkcDJlTFRYb0dNVFBPZ3hnVXBraklCcENKSUJJdnIxS2tmMUZQeE1qWEtn?=
 =?utf-8?B?Q3R3US8rREN5WTNyS0FKT0krOG5GYkdNcndsclJqTHVqNDUvMThrREx4T3o0?=
 =?utf-8?B?dTVPcld4WGVYSUI0QmJQSS82bWpFcC91cXA5YWVLRDZ4SnlZdUV2TTZaZXNv?=
 =?utf-8?B?NnVqN0xWeWttN1NkeXllYWQxWEcvNlpVNzhWTzg0ZTBtd2NWaGx3UnhuamJN?=
 =?utf-8?B?NGh0TUUyL2ZmT2d4L1krdDFXU3EzTG9qT0E5Y0E4Y2dqa0JxWXkrN09xMEg5?=
 =?utf-8?B?TUFhNjJ6ZWQxWU9BellacmRwVDlFZ2kxUzQrSXNjVG5GOGh1Umxaa1dFK25j?=
 =?utf-8?B?dWpaUElvZjdOZEhJNjkrN0oyNDJVRCt5NHZ6U3dtY2Y2UTdRVXJldXdrNmVl?=
 =?utf-8?B?SEd0Umt3OUlwT3RHeGdMOHRwYUpyenVyTXU2eWRTZFREcEJseGQvaGZDN1Zs?=
 =?utf-8?B?OWNNaHVzdHRQWlZPanN6c0lTZGkwK2tSQWRldHF1SGVjWXdUaE5nREJNenRw?=
 =?utf-8?B?alBXU0xnZkNXNVRYYkpFYjArMUEwNjVEcjd4aE5FcU9MSThqanErRUZQNUxQ?=
 =?utf-8?B?dlFwZno0dmJ2WlBmU2JyWEhSaDJJTGcyaUcxTmJjby84MXMwaVdsQTFnTXpr?=
 =?utf-8?B?enh2Y3pNLzJNSDMrV3lVQzVrVUtQdEpBWks2Nm5Bb0VVb1g1elBQOURPUHpr?=
 =?utf-8?B?b21SUmF5TXdzQlloUmFWWEZtaU8wK3Z6aUZBZ2ZnQzdGYjJldjlNYVRBckxx?=
 =?utf-8?B?UGxtYUtlWDZqYTJxWFRYaGpjdUwvYjJHRnlRbUhMejN5S2J1aW1jbXN1WW9J?=
 =?utf-8?B?L3dHSDBuQzNHQUU3NGU0OEsvZU1RWjVSdUx6ZktyaXlWOTJJVVloa0l5Zlk5?=
 =?utf-8?B?TS9SenhFY1EvMkxGbitZakdidDM2WTRQcldSVFJ0WTN1WW13SmJKK0ttVXow?=
 =?utf-8?B?NnkzbDBneGZBdnZxV25RVG1vbE5OU1g3ajRNVkpzM2pwUFVWNjl6dVJpNEQz?=
 =?utf-8?B?SllKNk5kaXVUa05Rd0M1WHZsNTFlb3dGQkhOY2hvS1lDbkRsSzJCRlJmS2Z6?=
 =?utf-8?B?OEl6OUZ6L3FrMGttUUJHeE5Ubkd1VHhYUDBxaXh5eE5Qc2RFbmEyZlVGb2d0?=
 =?utf-8?B?TlJocGZZeEwzZzdpRUd0SzJ1TXBNV3Z1ellPaVhaeDRucTJBakp4S0RpRkZt?=
 =?utf-8?B?WEYzd1hpOHhsbUpyV0g4L25jQWFRZzZNOEJGVW1RdC9PNzFTYW1TZldOcEJE?=
 =?utf-8?B?cHJ1T3Bzek8yR21ZZHNvUnViNC9TRzNzMCtvWDc0YXdpNlJOWnJ1dm9kL3VC?=
 =?utf-8?B?RU12d0tZNmFaaWE2N1FjaksyNzY3dUhFVkJ2a3NLV3U5TTF2QnhkS0pzYkFJ?=
 =?utf-8?B?TFNpWjBWdENrbm45NVRHVHVDNVowN0Y5alNjRXdpT1I5TGJPdFlNcDhQdnFW?=
 =?utf-8?B?U3loSjhTTWFLR0l2dkVwNUpxNTZkMEpWTFQzR1lkWmE4MlAvUUJSMVoxdFB1?=
 =?utf-8?B?VS9lMkhJalQwbDlmYWhGWlh6VWVKWEJ0M2NjM3R3NmNpK2NVMDEwYmRTNzBn?=
 =?utf-8?B?Nm15VE9BSHV2OHJTTEc5S3JUenZzZ0ZseEVzbFMzWlFlcGZuWGJiN0R6U2hP?=
 =?utf-8?Q?XYnCf0Ex1q7Rm12SuWkMspO3W?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ee4432-412b-4c8f-59b6-08dd926345a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 21:15:22.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prOwgZSd6IX7DCUMHE7FXAHxjJTGItTuSrfExvaOOaKQ5l8sO+5oh0pP+UxXuWVT73InqN0R3lS22vdrC7g8Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-Authority-Analysis: v=2.4 cv=F/NXdrhN c=1 sm=1 tr=0 ts=6823b66e cx=c_pps a=H8RDR50mQ1szzU+C1Tr1+Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=tr85UTSX1UzFzyFzRZ0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CtMVSIA_O8c_P78LbwuM9uJ2DWxm23P5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDIwMSBTYWx0ZWRfX2mgom7gh95E0 B83y1wBGwNTD+NDc+ah9tPoPcnOC3qxMY2aW4hlAseXLGv9hFsuHPQOfFF92Sq9fITaGEfclcZz yi6VnN/8DnrpQUGXDzfKOXLUM6Rk/S1AbWZDa49FrtFn1VROV3gKAoJJT4CCRNcSM7yC4ASXW+q
 8uwZrruL3KMzIiLYL6+jrJ7U+IN6ovTViUK0efpG9MkP7xnOmyWOsxitqFce/8kbXH7IyjsDzjH rYnMOirgS2o7GytfwtT0N7GyMNsok5X4UIQmmEUVLR7TGJjlOdsg0IILUh3sHqEljhG9ZIxN55j V/xU08aDjJGoJKitSrHSMwKMNPY+GtUI7ekAgYD22DJym/nP1SJr9nhH/Ui5c8CoqmNt7Mdyu12
 Z1rHshkzuvK4FBrNJUsat6A4tvryxOeLDU125ekcmk4spOjNqQl0JEcFlYTID5u1sq3fTiCW
X-Proofpoint-GUID: CtMVSIA_O8c_P78LbwuM9uJ2DWxm23P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505130201

On Mon May 12, 2025 at 1:07 PM EDT, Andrew Lunn wrote:
> On Sun, May 11, 2025 at 09:27:33PM -0400, Damien Ri=C3=A9gel wrote:
>> Hi,
>>
>>
>> This patchset brings initial support for Silicon Labs CPC protocol,
>> standing for Co-Processor Communication. This protocol is used by the
>> EFR32 Series [1]. These devices offer a variety for radio protocols,
>> such as Bluetooth, Z-Wave, Zigbee [2].
>
> Before we get too deep into the details of the patches, please could
> you do a compare/contrast to Greybus.

Thank you for the prompt feedback on the RFC. We took a look at Greybus
in the past and it didn't seem to fit our needs. One of the main use
case that drove the development of CPC was to support WiFi (in
coexistence with other radio stacks) over SDIO, and get the maximum
throughput possible. We concluded that to achieve this we would need
packet aggregation, as sending one frame at a time over SDIO is
wasteful, and managing Radio Co-Processor available buffers, as sending
frames that the RCP is not able to process would degrade performance.

Greybus don't seem to offer these capabilities. It seems to be more
geared towards implementing RPC, where the host would send a command,
and then wait for the device to execute it and to respond. For Greybus'
protocols that implement some "streaming" features like audio or video
capture, the data streams go to an I2S or CSI interface, but it doesn't
seem to go through a CPort. So it seems to act as a backbone to connect
CPorts together, but high-throughput transfers happen on other types of
links. CPC is more about moving data over a physical link, guaranteeing
ordered delivery and avoiding unnecessary transmissions if remote
doesn't have the resources, it's much lower level than Greybus.

> Also, this patch adds Bluetooth, you talk about Z-Wave and Zigbee. But
> the EFR32 is a general purpose SoC, with I2C, SPI, PWM, UART. Greybus
> has support for these, although the code is current in staging. But
> for staging code, it is actually pretty good.

I agree with you that the EFR32 is a general purpose SoC and exposing
all available peripherals would be great, but most customers buy it as
an RCP module with one or more radio stacks enabled, and that's the
situation we're trying to address. Maybe I introduced a framework with
custom bus, drivers and endpoints where it was unnecessary, the goal is
not to be super generic but only to support coexistence of our radio
stacks.

