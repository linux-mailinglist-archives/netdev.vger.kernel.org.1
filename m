Return-Path: <netdev+bounces-105441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4D91128E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD87F282F50
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130E1BBBD7;
	Thu, 20 Jun 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="D3hAWICU";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="gTX6HeKC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F41BB687;
	Thu, 20 Jun 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913013; cv=fail; b=n69JkvxA3kx0FfTgNIbo1aURYSTGuiQXdqQOijXHhrfGuUb17VPOlDMtFRp3IfL+zJhtXKIe9ZGAMDMWw/cvPsxJ4f+RTcSvbqgx7PPJuz0MbErA0/osoCBLd/F7qf3r4flCOWyCZuOoYXdblSTxZQCgSGT74W29Mq/74SapUJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913013; c=relaxed/simple;
	bh=glUIa/X9l2c4aOv3x6ORLWMVZQVIGtt0a8fetJFYdvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tlOPNXpcNCVqTqKXu6PdfNtAMxn5Aj8ZvTEYwGWKR/XYo04pLPyCeO4qTKtWqkLHTDjGGDRu7UXlI+7C/1oG+iFbZQ4OJDMdcckS/f5/LM/CWRufLIDYYdWAiEFNo+UE64aVtvuyTxDs1q/koBrqJc+7JfKsaIHbsxpVn0Zt2Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=D3hAWICU; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=gTX6HeKC; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KJnZ3T029087;
	Thu, 20 Jun 2024 12:49:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=glUIa/X9l2c4aOv3x6ORLWMVZQVIGtt0a8fetJFYd
	vU=; b=D3hAWICUDReJgIb8bd7lnkYVMOpcnsVpmF4Vwnd4FwZhKxmdjSNcAHRj8
	EwCIcJeJVIk6mYxb/uz1QUwA4WvOv0FCZoz158akT42EtlIR+zkVOUWeAKJsVA3M
	Aw+pFFWwT/PLMq9GSCgvBnBNCSK9MwIGgCeD9nFUFIU+PDIuTpGF+R7xYJUqjekj
	Prf4ICsKCFaM7BGPNHmVXMq2jOUUsts7LIVOPMvniBI5f6zAR/KADLikIBBHtr44
	xJUo49Hv0OI7Et68OnfxthRR85S93jOo+XZqpwuEY80tOR4X2oMmzMMnAYvliGo8
	0k6LhAht62jVxBKFT+uLn7t/4bsfA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3yvrkxgacq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 12:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi3gb5FQzmILYgoUSBX5pRpQJSVStKoJeIcmWga6HJsibTwoJChJgKoCwwwcWfUAMFl2jEdcg3F4LyndByaBFVtI2CFTqx70aXJeFxKoiDd2j6nlxoGCGaO9NyhysaEey5imqF6wkykA8TLAwJJxS/Ltb0c6s5EvfU995l8ADCr1HAbqd5iurIvddIy80adKgIzg2BvrAy1hTUV50YOIS48fUsoHVSdd31cGO7yVtq5ksfkh47OjBzTd9bE/Gtw5uqeL14h8OUxksMcZ55dOjPtfUNRLVGFN8liWRPWx3Fgl1IkKi+tlDCHC7J25jQy1l+y57ijloOkC/5QYd2UBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glUIa/X9l2c4aOv3x6ORLWMVZQVIGtt0a8fetJFYdvU=;
 b=HIjONU2jobKQS1YNhpcWAmAIFk7C4AWGCZFrNz2YSP2FvlZpGyMQOvjLoKSa+tj1BlZTuDf/m1zFjEWUwqFN3MuSQeI+UpUeUHmICkcYwFAlFGfrBF/oqxAGiDD/Ru9+p/SUJu8DFDh/s1v7t7bf7tNeUvBEQVpSxjiMB1FoxQkIn8nbqoZDtg0q+/0LxNVU0SP07qFqsknZWK39ClJ9Fa+2i+twuTTl3wGh7Izn3FsUwFLc5qGu+sPOnYY8ridKzUGz0myPN5opL9UryZlykMpUw05iVDRD3eZ4X9kHHvduVjr5L5my/9jv46y53Xs1DhFKKaCRjAUflI+dhVD9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glUIa/X9l2c4aOv3x6ORLWMVZQVIGtt0a8fetJFYdvU=;
 b=gTX6HeKC07kUNnchoTONeE/7low1zXinFCdc9vAj5CH5UU3MgWY/ZtI1A8in95U1vmYmJtIlsoRl5FBus24FVc3NNryx2lLGxCgT+E2R2CgCuTqdj2sKJ9x4WRuKKQci0YAqXl905T1s/ccB7PG5ZtAB59/gmVzrruIDePG2qQEk9gQ1kuEQYgm8E58IPW8tFFxVpS8lGnjhYhrGje3dDz9kQbWZpQcSzjZcr2yMow/gg0jEv+gwJv1Wqk/A6QzqwEZfKPG8WhmvY86E5VahXe1RZ293VkFGrGn1sfDVsY1dtXoB4CAK77zXd7yBkfrOk0G8eSqWngvBvEG0FGWi9Q==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SA0PR02MB7419.namprd02.prod.outlook.com
 (2603:10b6:806:ea::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 19:49:45 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7698.019; Thu, 20 Jun 2024
 19:49:45 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Christian Benvenuti
	<benve@cisco.com>,
        Satish Kharat <satishkh@cisco.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
Subject: Re: [PATCH] enic: add ethtool get_channel support
Thread-Topic: [PATCH] enic: add ethtool get_channel support
Thread-Index: AQHawZcrbaLWefPNP0aAi0Gu7Ms7PbHNs7oAgAAFRICAAg6kAIABSyOA
Date: Thu, 20 Jun 2024 19:49:45 +0000
Message-ID: <0201165C-1677-4525-A38B-4DB1E6F6AB68@nutanix.com>
References: <20240618160146.3900470-1-jon@nutanix.com>
 <51a446e5-e5c5-433d-96fd-e0e23d560b08@intel.com>
 <2CB61A20-4055-49AF-A941-AF5376687244@nutanix.com>
 <20240619170424.5592d6f6@kernel.org>
In-Reply-To: <20240619170424.5592d6f6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SA0PR02MB7419:EE_
x-ms-office365-filtering-correlation-id: 312f758f-a7c3-4509-2e5f-08dc916222ed
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|1800799021|7416011|376011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U3ZTdE5xOE1GazN2VkZMOUFJMWVlS25zZEhqMXFNNGFBVWl0c3FOQTdmejRU?=
 =?utf-8?B?WXFva0RsSVdkUTVFS29ETHpOTjN3SEJFNk9BTlZvNTRjS1I0Wllkb3FUQW9n?=
 =?utf-8?B?Wjg3UThnR3ozSGtXdDRYeWZHMjFWLy9RUDZ0VVV2L3JtSEVqTzBUdGxPQ2d6?=
 =?utf-8?B?TjN3ZHFHeFBwZVpyT0RlRnpQSStsOHhmcW5TYVlWUXNsZUc4a1NDQ2VPSjZC?=
 =?utf-8?B?UXFuT2UwWGhiRmsyV2lhZWl3QWlWOFRpMkp2emVIemw3Wm1iNVhuY2Q5Nkkx?=
 =?utf-8?B?ODlhai9KcWZqOXl0TmhqK1NFdmtxZHJzeGhmUHVqanFYM0MxQVA1cjBsdUdR?=
 =?utf-8?B?aGVHQXMwU3VHL3hSemNtY3VtSmtmNGdkNG1abDFiblBqQ1ZhRzNuUGNQc3R6?=
 =?utf-8?B?Q0tTdWpWR0FDK3BYNEE2N1BKZ0J0aUFHbWh2REhadS9Qa212MEt4bjVObXA2?=
 =?utf-8?B?dGZuSzZOV2hwMmhuN08zczNqdGE5ZlR1SHFNamgzanVCb2huR3B3TEZFM0cz?=
 =?utf-8?B?YWp0T3dWSXVYZjVMbHAzSkl1NHlnaFZEUHlmcDJPdFlqd3dBREdIZmN6ZGVC?=
 =?utf-8?B?WUw1Q1EvOExJdmliYysrR1J4MmNFSE5lNUo2Wmh6UU5lK1pKR1JTOFpIQk55?=
 =?utf-8?B?bnBIWHpsV2FIcUlBcGNYNEZXYm1yb0hGeWFWQlB5c2Z0bHhBZ01CRGtBei9y?=
 =?utf-8?B?M25yUVlOcTNtaWMvblRtL0RsZTQxbXFxUk1DV3BPV3BzZW9penhlYWVMSWRr?=
 =?utf-8?B?RGZuZFpOOUtNUmV0S1BmZDFBMkRiVlJKT2U0M3FhblR0Y2lhQXprQ1dtUHF5?=
 =?utf-8?B?UEZoc2FBMXQ1RWlBNVNsWWNDOHBMVnd5ajZZdGh3UGZjc1FTaTFha3BXNXdY?=
 =?utf-8?B?V2lRZUtnZi9HdHBWSEhyLzBWR2tpQ1ZuclpyaHBHcVFBTGpwaUJPcFJJdUVx?=
 =?utf-8?B?RWErMXdOYWlkSkk1endpUElMeXAzNnh3OGpBNzRSU3VyOFFBdjFOQ3M3S2dL?=
 =?utf-8?B?V3c3dTVSSlZzNit2OTNzTENQV2R3T2c0YXFrVTlMQTN5UHA0WndJcW5WUm5z?=
 =?utf-8?B?aHozTUJIQnJNRVpSL2VReVVVNFpFUGRxajhzQ1g0M1hqaWU3UmNLM3lpbURw?=
 =?utf-8?B?L3JzM0F0YVhSa1ZHR0FqeHMvVlRhNXAzMGFCaWF4UGE5N1NqNzEyajdzV1NF?=
 =?utf-8?B?VDR0eklpNzRRUitkRytiQi8zRWU0UEd0UmJCUzVaOUowZUN4M3dlOHVvSVFs?=
 =?utf-8?B?ODJHRnZOK01Bbzk5c0paVlRCN2lYVnNwM0svd2JOdW9DUUtTMmJ4VlpEcDFK?=
 =?utf-8?B?UEh1bnJaWWlnZWR6OFdYS1RVRW9jRnNieHpsa0h0UmJiRWx1QktBZE5oK3Mx?=
 =?utf-8?B?WlBGRCtBTUFHeVQ4Q2k0QTBnSlVKUmNHcVAvUEtsRFV0azRPVlhmVXVlV2xR?=
 =?utf-8?B?ZWc5WGN6eDE0bzkvcHdLVlJxN0d0cXNqZlBBVU5WWjRKL3NqM2o0NmtoRjB4?=
 =?utf-8?B?ZFpYdzlma3hnbmV1TEQwc3U3REptWlc1dEtEblMzQnBsSHZVR2ZxT1ZWSlNL?=
 =?utf-8?B?SFg4WXdMWjFzS1JhQUNFZ2QwT1ZLOTJ2TnlSdEpYclppeVl1Nk1UR0lhZ3BP?=
 =?utf-8?B?OUNBUEhMY05Qc1pORjNzYzdtNnA4dm0yeFdKUENrdUpyWFBQYWpEV0dnUGZk?=
 =?utf-8?B?bXp5Z1duV1dRejEwT25uRDlOUVFGRG5TUU5lajhhcTF1T1h0TTRyWDV4K3ZZ?=
 =?utf-8?B?SXhhblZWRG5WVnluelhnS25ncmZGeFlNeHNZVDVxMEhGTmRIM1Z1T3BrK0My?=
 =?utf-8?Q?Ns4gmdszyXXzI2v8knE7xpjOLUkYQphlMnwb8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a1YyZUdCZmdnVkNDT1ppbnc5VXl4N1pvZm40aTJHeDFxUkNleTYvVC9HbzNy?=
 =?utf-8?B?c2xoQXVmNjd6WXFtWjNIbFk1QTVSL0JzTlg1RXdXb1VOMjJNaitXV0RYN0dj?=
 =?utf-8?B?alpTWDl0OEx3ZWg3eDQyejJLTGwwME13U0h2MXhtOHFhQXRTMEVkYXVTcXEv?=
 =?utf-8?B?OHFYNVpSN2J3aENQSEFKR1ZlTUhST2llTTh5dklSVnlNUWQ3UGFoSlRCZW9y?=
 =?utf-8?B?cWNYTXdReWpNaXNjcVhmdUVBb0ZwamNsT0t4bnc1ZXBaU09wSGtKc0I1ZElL?=
 =?utf-8?B?Z2gvRmcwMUVmQ29YZWlOcndpNUxnQytOT2o4cFBDL0hORmc3OWg2MWZOekZ1?=
 =?utf-8?B?UjlkS0dkdHVRR3piRFgwaHlUbXpsZGxlUjFETUVIT1NjQXJZWFJoSFdSTnl1?=
 =?utf-8?B?Q0xtQVIydm1VaDk1aGNvbVc3bGgxaytBaDFNamozUFEwbEx5NGNDZEx0SjJs?=
 =?utf-8?B?cVQvRzc2Z0d4Nml0MmN0UGYxa2hOTy9Mdnh6NkhQa1Q0ZEl6VUFUOU0vR1h2?=
 =?utf-8?B?Y1dLR1loNkw2Y05CeG1hWlJNWFozdnE2Z2ptTzZVUWJiUHVDTTdsd3FScmRL?=
 =?utf-8?B?UTdjVG1SbWpuM0FhWG9waWpVRkFrWGdkb01qdGpRUlpsbXRnL004V2JBVDRv?=
 =?utf-8?B?elJSQTloVFFuLzhqSTJYZlpub3p5S0hLU1cyRkQ5dFg1ZXQ2NFU3cTB3UGdU?=
 =?utf-8?B?czNKM3J2Tm50UkU3KzMwZzd1dEtqR2pRTXlNYlZHQWc5YURVSlo2V3lIYnFO?=
 =?utf-8?B?emlRRUIrcjBaNDNINVdRelg3TFV2ZXRjL05DVXBQaHExTjN1VXk0eE5sbXAw?=
 =?utf-8?B?U0NObkx5MUJMUXpMUFRYeG9PRzZCajBuekxNNWlQd0QvN2w1RTU0Zlp5a2RX?=
 =?utf-8?B?Q1UxRU5SK0d4RExhelhzRjRSODNqSHErcHNnU0UyeFp1YlVKUjN6TkxicmtR?=
 =?utf-8?B?SHBQdXZScU1PUTNGVWkxQ0Y4VmVoeEtiUkRrMzdGZEwxcFM2SjlZTXJPSUZY?=
 =?utf-8?B?VWJDSnZJZWdhQldtNG5nK0M0SlhNTCszbWhPZXNxMXEwdG5FMUZFVEtEbCtk?=
 =?utf-8?B?aXlNNVo3S0lpQW0rN1VVTEg4dE8ycEtmb0RwTXBIS05pT05mK2lmSWU2cTgw?=
 =?utf-8?B?WGhzWUNuYngrZ05tM2ZQUkphWkRIUHUraXNjR29EWGU2eDFvdnhlMlVOc0E3?=
 =?utf-8?B?WGM1TjJVMGVnaitjMlNyTU5SRnNpU05BQkpsUnFsQzE3VDcxQVZXUkZaRE9K?=
 =?utf-8?B?enFBdGF1RFlaRzIwQS9jdUNCQWxCenA4dTd1TU9BbUZId1VYMGJkdEwvb1h2?=
 =?utf-8?B?eGgzRnd6N0tZczQzUHRUMDRkNlR4Ty9uY2ZIWEdVMDhkMW9tUWtleTFRTm8y?=
 =?utf-8?B?SEVqM0JYVE1raHJldkFFdDhxMkxFa2swSkVLVlNJckgyUHA0T3pLRHIvWlFa?=
 =?utf-8?B?MTVSbW1vUkVTelA5YmVLaEV3YmEzUGQyM3V4WlRKQXRUaGJlbUJlY2ErMkJt?=
 =?utf-8?B?WEdVckpycUNESkp4SENNSzJHQXZFV0JxZG42L01Xd3duTlBHWVEzSEFxYllN?=
 =?utf-8?B?Z09EZ0RBRmRLS0ppQktXRG5sREVzMFRGaWthNHV3R21lYW9CRzQ5YW1ybEtj?=
 =?utf-8?B?RnhCaWFFV051Q0tlNzdzUGY0ci9FSDUyMU9WNzBvdk9rZzBKbzlUdXd0Nklv?=
 =?utf-8?B?MHZLcFlMdjNETGY5NXUwREdlR1NiS0ZTWFVwVGxTdFdwNDVwM3VycENIMDUw?=
 =?utf-8?B?MllQeCtDVDVPYkhmYXJoOC8rK3pwQ203aktzeDF5Z1p6czN4SDhXM29zZHpv?=
 =?utf-8?B?NXgvMmVZV1FBOFNnU0tPM3ZNNkVJcE5heW9QOEkycm9oamUxRFdNSEptQXF0?=
 =?utf-8?B?U0lPNk1ROGh6VHI5VlowWG00cklsR01vL0FQT2F0RjhkOTJ4Qk5zZmR0TThv?=
 =?utf-8?B?akI1eUVOVU9wY21TU2FxTWJiZ0czeGJGdkpwVmhDL0ViNldZdU54d0dKc3R1?=
 =?utf-8?B?QmtoRURYVWtkTGlzQXpBZ0k3N0xmYjluR1FHcy9DeEd0ZElLVUZNSEFWMWxj?=
 =?utf-8?B?OHEvZlNYMW94T1lYWlBnYUFDM0Q0dWRrcVoyTTBva3hTS2NUYVF2YzZxWGxL?=
 =?utf-8?B?U3h0L3MvamMxdGl5Q1Z1U2dJS2o3RDVRN2JxelprNUdLZXp2bGE2TGM4aW5j?=
 =?utf-8?B?Tys1RUdJUjZKajloTTFhWVlxTTh6MG4zVDNoc3dZOWJ4REZrb2J2ajQ4dXJ3?=
 =?utf-8?B?dlNwdnRyUUpNbEY4ZktLY28vd09BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <388C562B6B21144B8B7561C77C23BF06@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312f758f-a7c3-4509-2e5f-08dc916222ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 19:49:45.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wElFQEOt/Sz68TI5M7YL0YZtRijv7LLds2kmW/kOevAH+PjrYDDBesuAGQDkYsEcEgEqU+ZnsP4iVFvRPTlHCff65epIIGj8BxBmrHRIMMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7419
X-Proofpoint-ORIG-GUID: y9DnWHe2KPBo7moM8Y9doFSNfQz1K3yP
X-Proofpoint-GUID: y9DnWHe2KPBo7moM8Y9doFSNfQz1K3yP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSnVuIDE5LCAyMDI0LCBhdCA4OjA04oCvUE0sIEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAxOCBKdW4gMjAyNCAxNjozOTo0MCAr
MDAwMCBKb24gS29obGVyIHdyb3RlOg0KPj4gTG9va2luZyB0aHJvdWdoIGhvdyBvdGhlciBkcml2
ZXJzIGRvIHRoaXMsIEkgZGlkbuKAmXQgZ2V0IGEgc2Vuc2UgdGhhdA0KPj4gYW55IG90aGVyIGRy
aXZlcnMgd2VyZSBzdGFja2luZyByeF9jb3VudCArIGNvbWJpbmVkX2NvdW50IHRvZ2V0aGVyLg0K
Pj4gDQo+PiBBbHNvLCBlbmljIGFuZCB0aGUgdW5kZXJseWluZyBDaXNjbyBWSUMgaGFyZHdhcmUg
YXBwZWFycyB0byBiZSANCj4+IGZhaXJseSBzcGVjaWZpYyB0aGF0IHRoZSBxdWV1ZXMgdGhleSBw
cm92aXNpb24gYXQgdGhlIGhhcmR3YXJlIGxldmVsIGFyZQ0KPj4gZWl0aGVyIFJYIG9yIFRYIGFu
ZCBub3QgYSB1bmlmaWVkIHJpbmcgb3Igc29tZXRoaW5nIHRvIHRoYXQgZWZmZWN0Lg0KPj4gDQo+
PiBJIHRvb2sgdGhhdCB0byBtZWFuIHRoYXQgd2Ugd291bGQgbmV2ZXIgY2FsbCBhbnl0aGluZyDi
gJhjb21iaW5lZOKAmSBpbg0KPj4gdGhlIGNvbnRleHQgb2YgdGhpcyBkcml2ZXIuDQo+IA0KPiBj
aGFubmVsIGlzIGEgYml0IG9mIGFuIG9sZCB0ZXJtLCB0aGluayBhYm91dCBpbnRlcnJ1cHRzIG1v
cmUgdGhhbg0KPiBxdWV1ZXMuIGV0aHRvb2wgbWFuIHBhZ2UgaGFzIHRoZSBtb3N0IGluZm9ybWF0
aXZlIGRlc2NyaXB0aW9uLg0KDQpUaGFua3MgZm9yIHRoZSBwb2ludGVyIG9uIG1hbiBldGh0b29s
IC0gb25lIHF1ZXN0aW9uLCBQcnplbWVrIGhhZA0KYnJvdWdodCB1cCBhIGdvb2QgcG9pbnQgdGhh
dCBldGh0b29sIHVhcGkgc2F5cyB0aGF0IGNvbWJpbmVkIHF1ZXVlcw0KdmFsaWQgdmFsdWVzIHN0
YXJ0IGF0IDE7IGhvd2V2ZXIsIEkgZG9u4oCZdCBzZWUgYW55dGhpbmcgdGhhdCBlbmZvcmNlcyB0
aGF0DQpwb2ludCBpbiB0aGUgY29kZSBvciB0aGUgbWFuIHBhZ2UuDQoNClNob3VsZCBJIGp1c3Qg
b21pdCB0aGF0IGNvbXBsZXRlbHkgZnJvbSB0aGUgY2hhbmdlLCBzaW5jZSB0aGUgZmllbGRzDQph
cmUgemVybyBpbml0aWFsaXplZCBhbnlob3c/DQoNCj4gDQo+IExvb2tpbmcgYXQgdGhpcyBkcml2
ZXIsIHNwZWNpZmljYWxseSBlbmljX2Rldl9pbml0KCkgSSdkIHZlbnR1cmUNCj4gc29tZXRoaW5n
IGFsb25nIHRoZSBsaW5lcyBvZjoNCj4gDQo+IHN3aXRjaCAodm5pY19kZXZfZ2V0X2ludHJfbW9k
ZShlbmljLT52ZGV2KSkgeyANCj4gZGVmYXVsdDoNCj4gY2hhbm5lbHMtPmNvbWJpbmVkID0gMTsN
Cj4gYnJlYWs7ICAgICAgICAgICAgICAgIA0KPiBjYXNlIFZOSUNfREVWX0lOVFJfTU9ERV9NU0lY
OiANCj4gY2hhbm5lbHMtPnJ4X2NvdW50ID0gZW5pYy0+cnFfY291bnQ7DQo+IGNoYW5uZWxzLT50
eF9jb3VudCA9IGVuaWMtPndxX2NvdW50Ow0KPiBicmVhazsNCj4gICAgICAgIH0NCj4gDQo+IFBs
ZWFzZSBub3QgdGhhdCB5b3UgZG9uJ3QgaGF2ZSB0byB6ZXJvIG91dCB1bnVzZWQgZmllbGRzLCB0
aGV5IGNvbWUNCj4gemVyby1pbml0aWxpemVkLg0KDQpPayB0aGFua3MsIEnigJlsbCBzZWUgd2hh
dCBJIGNhbiBjb29rIHVwIGluIGEgVjIgcGF0Y2guIA0KDQo+IC0tIA0KPiBwdy1ib3Q6IGNyDQoN
Cg==

