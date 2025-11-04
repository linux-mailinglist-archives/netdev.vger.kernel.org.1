Return-Path: <netdev+bounces-235464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30EC3109E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E7A3A874D
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF244257AC6;
	Tue,  4 Nov 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Iqq/EbUn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="izYy2rBy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E92EB841
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260261; cv=fail; b=kkfa//cL/kmIdnD0eRDZEtjJrSe7EWEd9wahvKZaX+T31Ma7OODKCF83vd7WYTQcoB871rd+KOSaemuu6MDAy2ZNKL8dKTs1fhYT8/wvllbu7NTSgK/CD/SFqAo3bb7lGb+FRck2GeUgBBuQ0BIJhuCE1Uupb0byxJYpv1wcrDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260261; c=relaxed/simple;
	bh=JR6QBP2jxJYhzzI6kE2vnk4LWh0/gykke9qPZDp1/qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bd4gUGJDbMP+QZmqxGL7/U21p/FcQxkKbIF+73BMyP/hF4vQHbQUJRprVM/cGEvPemkUAvq9ABrqHLMdVlL9AkzVyY3/esarCdLA2fZ1TTJ46vnkughhJ0yQXx6dFSu38thPUlQaSCfk0qOD8I8oOmQnxUYK/uB7aR2p2YDquQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=Iqq/EbUn; dkim=fail (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=izYy2rBy reason="signature verification failed"; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4AlBkW3937354;
	Tue, 4 Nov 2025 12:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=bm7eEp0ArkZzTuQTJuVvD1
	RssRGxOWdGcG5/3mJ5j8M=; b=Iqq/EbUn6FeSw8C4CSATECLLwI4D0rSRLp28XM
	TxHjghrMg2CD4loipT8Z7SlscioVj9vaFTBxQ3wQIRgLavYVPZu0hYy01Ywe9Xxu
	eSjCazg42vzCeJwkyH8u/9HiTVeCkbbT7aBLGFCqD/0c7D+oIjsnCvFKknKxcznG
	j8hWK77leRhccqNyBvHyJjD5M2QqWzb4Lkid52tgtJ8b1FgARnnok3L4xXJFtWEv
	skpNUjaK/F2NpTMqBICOzO8wUH6MsqKG4UkTjlWfH9WZxncvOVXs7pDoAAl47IGD
	9+Tt2cStC9BCnzWuW5KfeKgoxTRa4tfhlDtNApqqOqGTzUww==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4a5ar512vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 12:44:10 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5A48LS2K026010;
	Tue, 4 Nov 2025 07:44:09 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.40])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 4a5dhvus82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 07:44:09 -0500
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 04:44:09 -0800
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 07:44:09 -0500
Received: from BN1PR07CU003.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 07:44:08 -0500
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by SJ0PR17MB4709.namprd17.prod.outlook.com (2603:10b6:a03:376::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 12:44:06 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 12:44:06 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Other use cases for skb_attempt_defer_free [was Re:
 skb_attempt_defer_free and reference counting]
Thread-Topic: Other use cases for skb_attempt_defer_free [was Re:
 skb_attempt_defer_free and reference counting]
Thread-Index: AQHcTYi0qy1lZKCr4EqWs+0cd3biQA==
Date: Tue, 4 Nov 2025 12:44:05 +0000
Message-ID: <16E07575-7B31-4C00-B8B6-28B09B0D4A94@akamai.com>
References: <E3B93E31-3C03-4DAF-A9ED-69523A82E583@akamai.com>
 <CANn89iJQ_Hx_T7N6LPr2Qt-_O2KZ3GPgWFtywJBvjjTQvGwy2Q@mail.gmail.com>
 <6C80F51E-F1AA-4FC8-B278-C73CAE2AA1F4@akamai.com>
In-Reply-To: <6C80F51E-F1AA-4FC8-B278-C73CAE2AA1F4@akamai.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|SJ0PR17MB4709:EE_
x-ms-office365-filtering-correlation-id: 9b7c0a62-b006-42a4-d375-08de1b9fd759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|4053099003|7053199007|4013099003|8096899003;
x-microsoft-antispam-message-info: =?utf-8?B?SC9ycVprWmxqUFVEMi9qcEQ2T282K0JpUmdSWGhESnhwM2F6V2xDMyttN1VT?=
 =?utf-8?B?WDFzMWVmQzZaaWhKbWpDbXJ4eXhnY2xnZWVmS2FNNjdMVnN6bmNzbE1iV0di?=
 =?utf-8?B?bzYyM2xBTzVxK1RxNmFsbk8xK1Y4LzRJczVxUkp4WlFhT2M5ek85M2VSaVBr?=
 =?utf-8?B?eXllV3FxbGtBdnl1ZHExeENlZ2RJSk5VbjY0RVo0bzhjcnhWdVZsUVB6MmNG?=
 =?utf-8?B?bTV0eFM2K2hhT0I5NXNycWttVkRiM09oWS8yRVVDRnFMREtDSmxXMTBreFBU?=
 =?utf-8?B?M1pLaFRTaThaU2ZQbzQ3Y3dST1pZeEZwVVJ3K0hFVHJZMlFDSjZ4V2xIWHlT?=
 =?utf-8?B?SWtkWmlmRDJiWE4rNldNVlFIYk9PZkUycHZQcytCM3ArcTVpZFhSYnh2a3hG?=
 =?utf-8?B?LzAraFNaUWsvZGxVa2Nyd0ZYUE5KUVRzRGQ4SkNqV2NjNGN2VEk0aHZUN1pB?=
 =?utf-8?B?MW5BbVFMeU9md1hYbmJkcVk3NEpsRHJ2VXlXVEhNRU5aandWWkZIUW9XanNG?=
 =?utf-8?B?QTNJUjhxNTRsZGFXSnBxOUo4T0RmL1JUUHpNYnNKRlJ4YmFyZzdzN1pHVnpm?=
 =?utf-8?B?MDBMc3E1SHh1WUVpenYvMmtBWDVkbEpLRUo4NzJTaFlYV29aRVNYcHIrUVhs?=
 =?utf-8?B?MUUxV1pKREN0enVLVml1emx4dXFqcGRQWlpydnVOZS9KL3FDVWxLOWh4ZzVh?=
 =?utf-8?B?UkxNb09kM25ZRVMwamVOQnlzYlZVUUF1TDRIUE52UXZLMml0MGRNMWp4QXNX?=
 =?utf-8?B?SXZqQm9kdEFxd0NKSzh6TWx5RHg4U3lMZTQ2RExTZzZPV3pVYW5ZNFZXdDEv?=
 =?utf-8?B?WXpqZDNnSFlXRWRGWHVPdEQyY3pKS1VadlVsYTEyVGk1TStrMGxXMTB2c0Fy?=
 =?utf-8?B?dnlsWk91T0tEYTNGbllnMHdRcFBrNzJuNEZHdmhKdG0zempIc2Z6bEJ5WFlN?=
 =?utf-8?B?cTM2YVpGUDlyc2dJVzJ5TlBsbVBheGxoL0ZRZjlodi8rNGtyWmt6NlBUZGJ4?=
 =?utf-8?B?MVcxL3RSR0RoMCtVT2pwZUNjTkpGVVZ6eDhqYzNjOEpmamNGZjlPTUw5bUpF?=
 =?utf-8?B?TUs3RzNZNzlzSUhaL0NWTkFWVHpXcDluV2pDMjV5MFE4bjlrTng1Umc5WFd6?=
 =?utf-8?B?SG9UdERKOXZFT1dIQ1FEWjlKTis5dW5lYlUxTkhGRXlxQi9mSUJRaUVQWTZZ?=
 =?utf-8?B?ZHJnWXVkS3I5MHdJTGZ5YTRodDFXRldackMwWTBiUEx1QjliL0RGNnBCV2pt?=
 =?utf-8?B?Y1FEalU5U0RqajZEZjdYSjk1VVFyZzNyNE9zMVF5M1N5OVZPT2pEZjV2K2ZK?=
 =?utf-8?B?SWtTcUtBWXlscnJieDdLNGFDNWNZMjQwdUpENi9nSnBrT25uY3VxbU1qZHZi?=
 =?utf-8?B?ZEgzUE5paTlxOTB0ZEVVUEprUVYzZnBkcGRSeDRhRXlqMWQwZUNPTTYrazVn?=
 =?utf-8?B?b0JlQ3BLcVZvY1lxT3lxZ3pJa2VaSUV5ckZXUUFCL0FDM3V1S2NGYWtwdlJH?=
 =?utf-8?B?TWU1VEJxWitQTzM4Y0MxOUI1cEVaQnB1cDY3dnFSWmduM1pOT0RiM0lRN285?=
 =?utf-8?B?cmU0c2FlNTVrSHEzcUFWeS85YXVMaGUrZzBIUkFna1dXMW52VUhFWEFiZ2F2?=
 =?utf-8?B?L3pNK2dySHMxc0JpMktSTElLVFJXR3lTaDdWWDhlS1h5akdtbXhUMUtKd1Yy?=
 =?utf-8?B?Sm1wQ0dPVUI1Mm93SzlZZnJKUTNkZXQ3Y2szRlhSWGRoeVpwMzZ0enZrbCtG?=
 =?utf-8?B?WTVaTVQ2Z09CeHYrMzRJcjhLbTZJVDBjN3JzSGRUSkI3dlBaNlE2czZUbmtm?=
 =?utf-8?B?RGtEc1FCKy9QQ0hZWWk5cWNBTEtpekc0Nm11MmlkaDlLeXBlbTFWTlhTWU0w?=
 =?utf-8?B?QVF6RGx0dEhYUUNTM3gwTXBJNmd3U01iVnozaU5JRmlGdXlZUmdPVnpmZEIr?=
 =?utf-8?B?YkJTcjRhQVNmZWYrYkFJc3NLUzlERk04eW95YWppS0ZhMUZINVhhcExsRk9Y?=
 =?utf-8?B?Yy9wWmJ6SkRhYUJCUit1NE8xYzBXWDBFWXlxU1pDdkxhM2lQS3FWSkhIV1V4?=
 =?utf-8?Q?8fqHsk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(4053099003)(7053199007)(4013099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UldralRTMDY1a2xhdHFvL2tRY3gwdW9JTjd1Mkt3YzVDcnV2RklSclRHSmxR?=
 =?utf-8?B?Smg2eGJ6YlBTREphbXN6L29nUURRMC9ybFdYVFc5YTlPZTdUL0FnZnNwY2tr?=
 =?utf-8?B?Rm5UNS9tY1Y2N3RaSnBlNmdjNjNaNkhCUzFFQnRnUzZrL0dNdDM5c0FjNEpl?=
 =?utf-8?B?c2ZjTk1mU2JkWWhScnl2Yk91UnNNNnVFb1pTMTdSMHNLaUkxTW1MU0ZrY3Qx?=
 =?utf-8?B?RE02YWEyQ0lTQVE2NHg1bmVVdlhiWVU2Wjd3dG52T29QaGhNMGUvSWlEWlR6?=
 =?utf-8?B?VDMvTHAyaDVlUlMxVHVLKzRzcWxhQlRJNkpEMExuU2pMM0F1UGJ1N2x5TUds?=
 =?utf-8?B?bDI0bVJvZWdiRXdQV3FtU2F6SVU4c0NNWkVSMWNkQm1Ub25aR083S3VlVnox?=
 =?utf-8?B?WXpsV0dXVHZPZUtLRkdrT3JTYlRxek92eVkwY3hwMGxxakxtR0ZxQVl4YlZO?=
 =?utf-8?B?Y3BVV09oSVdURlRGOXpCeTdrb1lqZ1FLUGVGeEVyczcxQjYyWWxuNXU1MTU1?=
 =?utf-8?B?clJMLzdkVW41SWUyRVdpUzFJdGFyWDdsd3V5NmN4OU5vb3pwNHNKbUJUSXEx?=
 =?utf-8?B?YmxwTnEwSzhveFJaVjZSV0xvN0tLZWNpYjk3dklzTzBGVDhGc1dma1pmZWF4?=
 =?utf-8?B?Nlh5cHFFb3JtUzBmZVhXeUpCLytTc3dES3grdndOSXI0TDdpZE55Zy90Yjg0?=
 =?utf-8?B?cVBNSE5YSzUzSHhhZW9ubmJVOTlPeitBZWwrdVVPd0NQb0lDZndGcFNtdzMw?=
 =?utf-8?B?aWl0eUtqQXEzRm9zaEVUaGtCQWtsdDNjUGJoNGdKL2JDcmxiaXV6SGhoZklj?=
 =?utf-8?B?WmJObkt2aHAyVmI3NC9IMmdFSlArbE5Hc1IvL1NGQ0dyaitZcGo4SVRFM1Mw?=
 =?utf-8?B?REVzRXJLZjIzNmlaWUJIMGdVV1FRa3VWdktEUk1ZK0gzS1NJSitmMzV6VUd6?=
 =?utf-8?B?ZUtsWVBTVU83bjUzZXRXL010TTV2ZkoxWDRvdEcrSlBQVEJCSHVYSEh2a01W?=
 =?utf-8?B?MzZlVjRtTEtJenhEVkFtMUVOM3k1Ync2aDdRdjh3YUI2RUQrK3E3N2Y2M2R5?=
 =?utf-8?B?S3h5Y2FmVUp5WnpWZzBkREs3ejg2MlozdmpEYUk2Q0JkL0VEZTVuMG1aS2dO?=
 =?utf-8?B?aU5XYzV2VFRyMEJEUlFTRUpiMzlvOUYrc2R4L3RvUExGZm1BaGwzSGkxeHo4?=
 =?utf-8?B?TkJvSkpRaGhHZDVTRFNkdmNzYTFTOHhTK04wdXlrR09OSERlbTZ1dWR2R3cz?=
 =?utf-8?B?aHhHSHM2eTZ1ck5BelkyTE1Gb0xGQU1aZXArZFV4VmI3Q0FmbE1CZ1RnOTUy?=
 =?utf-8?B?d1NyRnZmV2V1ZG9jV01YVko4SFZFUkk5OGxDdEF2eGZXaUtNQ2RjWnllYmc3?=
 =?utf-8?B?WUNKS29VKzBHcVBMZ2tlU1ZQY3Z1TThXY2plTDlRT2puZFZJMzNWY3daNW84?=
 =?utf-8?B?aFFWL0hWRzBHOXUrNUhBL1dSNXVNTU9taWNZdEN1dm8wcXI4QkVmY3QraTJP?=
 =?utf-8?B?ek5sR2MxRWFxdndCVVlQdEhqZVVpb2ZoRTNyMWI1ZUhRcTJ3c1VJZXlEcmN4?=
 =?utf-8?B?azlWQmd6QkJ1ZXFleTdOVWhNUmJhSG9CbU14MkIvdnQ1aFZPS1BEQWdCTW1M?=
 =?utf-8?B?RWwzK0Faem1yeTVhQXllN1ZnUktHZ3UyaTNZNTJmSlBnc1JTMEZtcEtKZWs1?=
 =?utf-8?B?VDIyVmp3SW1zZ0x6ZkxRUE8xSGttYzl5TjRmenFCTEhSRnRxTlRiU3VEblhu?=
 =?utf-8?B?U1h1K3dDa3hPZmRLa21iUnVLMG9hajgwdnNabkJwVVEvYXdteXR0UU41WllS?=
 =?utf-8?B?cDBlSkl3alo4dTd2dDRHQWdTWG5iOHkwa0lBZVk3d1liY3lrVG1TakcrQ1VT?=
 =?utf-8?B?NTNhb1crZmhWRHYrRnJLenNWcjN6UFY4blkrL25SUjM4NVhLdVhUakVsY2Jh?=
 =?utf-8?B?M2MwdG1GY1pJeTZZeHNOZXY2bjQ5MGJpTit6UFAwTy9uWGpIZXNHQzI5a3NQ?=
 =?utf-8?B?a0VSTHYzV2lSRDIxVTVQTUprN241UXZyd1NhRFVSbk5MbVlDVGYrS3dBRkZu?=
 =?utf-8?B?ZmV0cnQ2eVdzK081OXNVRU5UQ3V3OWlnQU1nTXhkczcvQlR0QVJXTXBTZ0Uv?=
 =?utf-8?B?b0NWdGJFb0YrbWNmS011b1dNemFobE9GS0I5UUJMQ3NHaWdVcmRhRVpMS1A2?=
 =?utf-8?Q?/W8MgKft2YSKvP0IZ8O0OoBUh6AOJA2v1egG4O07wCT/?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v559A+p/OM0kFQ0LFxers1mLrmoZuHi5gde7atqT1pdzvNMbPderaoktuLVacVEZNCUzbzEPxkXHKIkZFLMoPkU6lyRC2MYRAVuyBW6Grx+B2jE98XW2GXzgwSPkOAzz6uAmS3UKZkTOyUAZRXSSjj4qHIT8+QxiHg5iQah5YpXfqct8YILr3X00KtqobL5Z6LlVx1qE7fHbi62i+jJ4fuq3idyCPDzsdz6jLQ+JeSjzBmWhSCv7vex62diTzt01M9o0xz78KDRw/Uf2ZXoiMR9DNHDgFNPEYGZGLKW/O3ZNm8DqR1tCLbRjhUz9dj07nJbjMWg94ypYcWLidfLUtA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt+Y+5FGwADKuagZmNS1m0P5Lxg5aXG0kcTfZM5U8Ts=;
 b=SQVWA7hLEjHCxNUTFJB3hhk4SasMFaxJ/35DfmHnnGq7lCoVBKJ740f8t5WBCiYVqXS3j4gQIYsk6e/4vJq5k+vPboS1hBM3YkXZWBkVSEwW22AVORRhnBL/orkrE5iqHVqAVrUt7FObOwArMcpz2C5R4j5Wq+X0hXNMxz1ufiYxTtVP73sAJ1kWmMfKhZ/8zthCyw03r/6cQCrrSH5VmLyy4D6AnasZwDQWZRFEuxRFW2yH9Mj/vW/aFdo+xeKcvqYsrIzxPSKj3cPI4rCQZA7GdjSEhs5VxnyVjYj7b3dQOZeI5MJolaROp7UUvcw7TqmKaQfo49bknJslfUW+pw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt+Y+5FGwADKuagZmNS1m0P5Lxg5aXG0kcTfZM5U8Ts=;
 b=izYy2rBya//ot7yKVSNpUJSfX+TUv9Tk629+sxBD0nlxX+2CDO9S1gi4JZMqjJr7xWOoE/tr/HJZm9BTozK4ku/6BMUHhYcZscVDh+1s3BR67I44xR6N7OQa4UjVGTQsiTTbzb3N1YoMHo3ccq/HmHnKQDd0aRmagxkwSt6fz14=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 9b7c0a62-b006-42a4-d375-08de1b9fd759
x-ms-exchange-crosstenant-originalarrivaltime: 04 Nov 2025 12:44:05.9538 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: PxOhtt017f1SmOLNtbVjDbC7L0Z/veniiS2gsld0egL8Wle+EnhRYKVNe9IvWFWNtGaqOyzj0fqJqqSd/W9RGA==
x-ms-exchange-transport-crosstenantheadersstamped: SJ0PR17MB4709
Content-Type: multipart/signed;
	boundary="Apple-Mail=_A7655DA5-5B45-4B10-9C3D-8E926D1581C2";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwNSBTYWx0ZWRfXyGxsVs4jM8jI
 C+zH7a7ZWPDm1eNBKAYtLicHS8i3Zmiv3QS4sUowIrcZoq81q2gc7VMLX6ZnaZnnDJkZo6G17Dn
 l2wJ5mA7zng/ZqA8tujM62Frg/CIIuYJRAK82u40CcTOROnu8vWgp5PEknlAHU8zDzukEbnnTO8
 fbzyefs7rjsCoDhhKQ36lkvVc0AHM8VfYwVYzvZw9lu/AfjxqqnFb86q2d/iatJwFd2QURJ+6ro
 DquLGejyC3ZkqzP70AH8GdzQzU6z2oeKf86EVb+lNK45h82cy2lrxU4huf6pTohn0pg9oI1vMBw
 Avd0DnINYDsxLq/Ov86vbNkFfZBUZkBM8XtKGbA2Uox1EJDmxh9Wx5ANgD6F0BuALJnTZ4JFQJA
 r7J6D+Hz0MjWgD7GVGxvOmN1BUanqA==
X-Proofpoint-GUID: o_JHOCBDKYtP10JxETc8MGkCMncMDzd2
X-Authority-Analysis: v=2.4 cv=AZq83nXG c=1 sm=1 tr=0 ts=6909f51b cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=jrL3TOae4v8FXyPy-ZkA:9 a=QEXdDO2ut3YA:10 a=Mc_Z4L-H5MGh63v2uLoA:9
 a=4HXLIJf4S1_o53w_:21 a=_W_S_7VecoQA:10 a=wqFnSJPP-FBafd8uH9cA:9
 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10 a=HhbK4dLum7pmb74im6QT:22
 a=kppHIGQHXtZhPLBrNlmB:22
X-Proofpoint-ORIG-GUID: o_JHOCBDKYtP10JxETc8MGkCMncMDzd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040105

--Apple-Mail=_A7655DA5-5B45-4B10-9C3D-8E926D1581C2
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_DB8CAA65-6B4B-4EF2-99F5-BF050188518A"


--Apple-Mail=_DB8CAA65-6B4B-4EF2-99F5-BF050188518A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Eric,

Any thoughts / insights on the patch below?

It really improves performance of a vhost-net / tap setup for Rx =
packets.

Thanks,
Nick
=20

> On 31 Oct 2025, at 14:02, Hudson, Nick <nhudson@akamai.com> wrote:
>=20
>=20
>=20
>> On 31 Oct 2025, at 11:43, Eric Dumazet <edumazet@google.com> wrote:
>>=20
>> !-------------------------------------------------------------------|
>> This Message Is =46rom an External Sender
>> This message came from outside your organization.
>> |-------------------------------------------------------------------!
>>=20
>> On Fri, Oct 31, 2025 at 4:04=E2=80=AFAM Hudson, Nick =
<nhudson@akamai.com> wrote:
>>>=20
>>> Hi,
>>>=20
>>> I=E2=80=99ve been looking at using skb_attempt_defer_free and had a =
question about the skb reference counting.
>>>=20
>>> The existing reference release for any skb handed to =
skb_attempt_defer_free is done in skb_defer_free_flush (via =
napi_consume_skb). However, it seems to me that calling =
skb_attempt_defer_free on the same skb to drop the multiple references =
is problematic as, if the defer_list isn=E2=80=99t serviced between the =
calls, the list gets corrupted. That is, the skb can=E2=80=99t appear on =
the list twice.
>>>=20
>>> Would it be possible to move the reference count drop into =
skb_attempt_defer_free and only add the skb to the list on last =
reference drop?
>>=20
>> We do not plan using this helper for arbitrary skbs, but ones fully
>> owned by TCP and UDP receive paths.
>=20
> Interesting.=20
>=20
> This patch has shown to give a performance benefit and I=E2=80=99m =
curious if it problematic in any way.
>=20
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index fae1a0ab36bd..59ffac9afdad 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2251,7 +2251,7 @@ static ssize_t tun_do_read(struct tun_struct =
*tun, struct tun_file *tfile,
>                if (unlikely(ret < 0))
>                        kfree_skb(skb);
>                else
> -                       consume_skb(skb);
> +                       skb_attempt_defer_free(skb);
>        }
>=20
>        return ret;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index f220306731da..525b2a2698c6 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7167,6 +7167,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>        if (unlikely(kick))
>                kick_defer_list_purge(sd, cpu);
> }
> +EXPORT_SYMBOL(skb_attempt_defer_free);
>=20
> static void skb_splice_csum_page(struct sk_buff *skb, struct page =
*page,
>=20
>=20
>=20
>>=20
>> skb_share_check() must have been called before reaching them.
>>=20
>> In any case using skb->next could be problematic with shared skb.
>=20
> OK, so the assumption is skb->users is already 1. Perhaps there is an =
optimisation in skb_defer_free_flush if that is the case?


--Apple-Mail=_DB8CAA65-6B4B-4EF2-99F5-BF050188518A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><div =
dir=3D"auto" style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">Hi Eric,<div><br></div><div>Any =
thoughts / insights on the patch below?</div><div><br></div><div>It =
really improves performance of a vhost-net / tap setup for Rx =
packets.</div><div><br></div><div>Thanks,</div><div>Nick</div><div>&nbsp;<=
br id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 31 Oct 2025, at 14:02, Hudson, Nick =
&lt;nhudson@akamai.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;">On 31 Oct 2025, at 11:43, Eric Dumazet =
&lt;edumazet@google.com&gt; =
wrote:<br><br>!-----------------------------------------------------------=
--------|<br>This Message Is =46rom an External Sender<br>This message =
came from outside your =
organization.<br>|--------------------------------------------------------=
-----------!<br><br>On Fri, Oct 31, 2025 at 4:04=E2=80=AFAM Hudson, Nick =
&lt;nhudson@akamai.com&gt; wrote:<br><blockquote =
type=3D"cite"><br>Hi,<br><br>I=E2=80=99ve been looking at using =
skb_attempt_defer_free and had a question about the skb reference =
counting.<br><br>The existing reference release for any skb handed to =
skb_attempt_defer_free is done in skb_defer_free_flush (via =
napi_consume_skb). However, it seems to me that calling =
skb_attempt_defer_free on the same skb to drop the multiple references =
is problematic as, if the defer_list isn=E2=80=99t serviced between the =
calls, the list gets corrupted. That is, the skb can=E2=80=99t appear on =
the list twice.<br><br>Would it be possible to move the reference count =
drop into skb_attempt_defer_free and only add the skb to the list on =
last reference drop?<br></blockquote><br>We do not plan using this =
helper for arbitrary skbs, but ones fully<br>owned by TCP and UDP =
receive paths.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">Interesting.<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">This patch has shown to give a performance =
benefit and I=E2=80=99m curious if it problematic in any way.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">diff --git a/drivers/net/tun.c =
b/drivers/net/tun.c</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">index =
fae1a0ab36bd..59ffac9afdad 100644</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">--- =
a/drivers/net/tun.c</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">+++ =
b/drivers/net/tun.c</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">@@ =
-2251,7 +2251,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, =
struct tun_file *tfile,</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (unlikely(ret &lt; 0))</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;kfree_skb(skb);</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;consume_skb(skb)=
;</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;skb_attempt_defe=
r_free(skb);</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">diff --git =
a/net/core/skbuff.c b/net/core/skbuff.c</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">index =
f220306731da..525b2a2698c6 100644</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">--- =
a/net/core/skbuff.c</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">+++ =
b/net/core/skbuff.c</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">@@ =
-7167,6 +7167,7 @@ nodefer: &nbsp;kfree_skb_napi_cache(skb);</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(unlikely(kick))</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kick_defer_list_purge(sd, cpu);</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">}</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">+EXPORT_SYMBOL(skb_attempt_defer_free);</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">static void skb_splice_csum_page(struct =
sk_buff *skb, struct page *page,</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br>skb_share_check() must have been called =
before reaching them.<br><br>In any case using skb-&gt;next could be =
problematic with shared skb.<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">OK, so =
the assumption is skb-&gt;users is already 1. Perhaps there is an =
optimisation in skb_defer_free_flush if that is the =
case?</span></div></blockquote></div><br></div></div></body></html>=

--Apple-Mail=_DB8CAA65-6B4B-4EF2-99F5-BF050188518A--

--Apple-Mail=_A7655DA5-5B45-4B10-9C3D-8E926D1581C2
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCdAw
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJzCCBMyg
AwIBAgITFwALNmsig7+wwzUCkAABAAs2azAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyMDEwNDUz
N1oXDTI3MDgyMDEwNDUzN1owUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1lMOTEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAw+xt0nZCcrD8rAKNpeal0GTIwS1cfPfIQXZHKRSOrSlcW9LIeOG4
E9u4ABGfGw+zChN5wtTeySgvvxE1SIwW13aoAscxyAPaS0VuEJGA6lUVsA2o+y/VD7q9pKIZj7X2
OxHykVWBjXBpRcR9XFZ5PV2N60Z2UBlwSdbiVp0KBXzreWMBXnHKkjCSdnbVuvOj3ESrN706h3ff
5Ce7grWg7UWARnS/Jck1QAEDqIHLSxJ3FhgbJZBt6Bqgp28EqkP+dQxzp//vnUDIwxBzpSICAMsk
d9I0nsdVvHV0evJSjqDgLF9gw7/4jjjQGW/ugHBytYSBEjDFuB0HOat0va8SjQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUWgue6rVjEAcBSPcAqJXWGxAZi9gwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0kAMEYCIQDg4lvtCdYN
NSoA7BrmrnhzqPrsFhQejDMGHCeY7ECV5AIhAOV93F+CcxakPdapxskTdtiTYz7dbj7AVto5kQkB
66NEMYIB6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAV
BgNVBAMTDkFrYW1haUNsaWVudENBAhMXAAs2ayKDv7DDNQKQAAEACzZrMA0GCWCGSAFlAwQCAQUA
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTA0MTI0MzU1
WjAvBgkqhkiG9w0BCQQxIgQgs+hv4Gn+rl2qlHXZhAx2dNsb+7t7CXgwcam89LkCN3cwDQYJKoZI
hvcNAQELBQAEggEAqguITpJNt98EZgHLL3Wc3W36+Hdj2zA3PWk9i8KtSJOf+MubTVUPf7oNVasd
BxEAGAWe0tofD1cfyjjVbwP9uhsoo1DCDCLU9biLM2IqE2IP/y2lJm1KEA+65mjWPrrxTGzFDILW
Q1veaOFt6YLy0M7K0cirCJY+/+TuPlbGgOAIE+ysDDGC8ZCxkCx8Lu8B3hRDlCSMQa2bFVyIBwiC
GWsWGLWc7R0A1jBbl5bgidbHVagMKi48ZmjX8QREW88mj0GWZuhX+3VoEMuSLFKMVyMex7xVvBQd
Mzukac9uN6A5gGe4+E77/qIyHec4A+a61D4suusMdL4B8paTLn/3tAAAAAAAAA==

--Apple-Mail=_A7655DA5-5B45-4B10-9C3D-8E926D1581C2--

