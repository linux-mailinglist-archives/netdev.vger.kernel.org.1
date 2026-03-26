Return-Path: <netdev+bounces-272158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAP4DzFnxWkn+AQAu9opvQ
	(envelope-from <netdev+bounces-272158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:04:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0235338DEA
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88E7C3025134
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A6421893;
	Thu, 26 Mar 2026 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="JU54KaBu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2662421890;
	Thu, 26 Mar 2026 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544672; cv=fail; b=ml4QqtNjrYZECrtiMNBoh04nwlXRoHL0+I3WmP83thLdGxz5OGr+HQGZyyt9+jlqWCkETIqeqQkPX5hnuR+53DC3qMJKrAubSzP2eDEjEzMEVEa8nDAs+D/zoGS67EaUeFzXudc+nJ3bdlXB6wKpzw8gyEVP9WVBIAYJh0I87+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544672; c=relaxed/simple;
	bh=DET0PG42jMJI4IgnimUotMd3BOU8vb8tnQ95maw5kDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AB/pAEetmeI7Wflg3et6YeTf61Wthw4ueavpBLW+KhL0OlyplVCo7fNgbIlS9h3p/G8zyvvWV6V5WCuswXR4Hcr45mcEp4xv5yQ5OmDL+X1IuLSw5HzfTGz5qYICUFflVdD6XkPHXAWHZTm+p+bJHsttQMJWWlDLy6qX4217Yu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=fail smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=JU54KaBu; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62QH2gSx1589983;
	Thu, 26 Mar 2026 17:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=LbsGeXQw7hEVt8nmfr6QOa
	UfORfN82fy1RylNkvI07o=; b=JU54KaBuv2+vV3Nq7qhVC+PmzK7BZEj8Ga08KU
	n7z1JzEVZkVgHYsuUm/hsbCYA8nruvfNBdmu+9XGj+LMQqpxli2yt5TpkBDuBWRL
	TEs/qvQ+92ugAZfld0SFuuGtJm2KTY4x9bM/nP82+tLG2iQhns1eft0Ee1R780pb
	mTH3IH8LB8xBJpSWEra3laevuBMC6B84g018bIA9W39QL3LLGz7xD4+2ewYBu5RQ
	MNswqrMNCs4PBHmr1oLuoCWx16KK7xhZzVG/sQvlhZY7ro44PqfE/hJWnQXOI5Up
	xTM2UfzO0VSrxYvNYGHBf/8fDGG0lZIHLmYCGfG1qwQNOKYg==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4d58uh003m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 17:02:54 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62QGYoS5026923;
	Thu, 26 Mar 2026 10:02:53 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.22])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4d1sa76y3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 10:02:53 -0700 (PDT)
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 26 Mar 2026 13:02:52 -0400
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 26 Mar 2026 13:02:52 -0400
Received: from BL0PR07CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 26 Mar 2026 13:02:52 -0400
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by SA6PR17MB7297.namprd17.prod.outlook.com (2603:10b6:806:41f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Thu, 26 Mar
 2026 17:02:44 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55%2]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 17:02:43 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "Tottenham, Max"
	<mtottenh@akamai.com>,
        "Glasgall, Anna" <aglasgal@akamai.com>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and encap
 validation
Thread-Topic: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and
 encap validation
Thread-Index: AQHctt0l6pGf9lNykEmZPNpQGND27bW+BesAgAMRBYA=
Date: Thu, 26 Mar 2026 17:02:41 +0000
Message-ID: <9E9BE3BD-1640-49E7-8801-130945073B24@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-4-nhudson@akamai.com>
 <f0f271ae-4d4c-4d52-8670-a14204da437d@linux.dev>
In-Reply-To: <f0f271ae-4d4c-4d52-8670-a14204da437d@linux.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|SA6PR17MB7297:EE_
x-ms-office365-filtering-correlation-id: 9b132b17-319a-4ed8-e38a-08de8b597f62
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|1800799024|7416014|376014|10070799003|366016|4053099003|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: iGQXseVMLqaXCVQRhWwnk4Hpcd4fyspa52fhphpBvS8lsRyPQjRpxyK4gzSUBXYQKClbLjiV8PABl/eNTiIxAl/JUeIv5AqnuCmOiMlxseUGbTsV344Ndq1hBdJg+0e5+akvBygz6YUXg+xPlN1Ff6CKKgaaokP81dhJsdSZ7AfgLZrGDREwn0negi9GQdkdAst6SGF9MbSy6TT2YPzYUgnc6aJZS/66WiG4oNkQ3v7FON16ZMcE2kFmcYCdmYsKoK57xLeCqQPQhJWBgi8Gqkixx+kutqbgDQ46UComwTlB1Rk2UhztnG83aKiT2Nr3EynDMNtp09n887vmznJSD8CFnmTT3IolvMq/vSIHwkqUxlaLK/tgcfzCiylxYTNyOqHDpai6W9eQhcMGTDcGmm6ZWGdhQDiaWTezNTpkfpwnH/eQhAPx4hf8komi0Fc8fbTsUElUGrPDLnDTQwIMvJWvQ3U0BIMaBrR2cKknmA9j9LkMU6wwQbfO3m9mtjQ7CP1IEAyufrO7DOXQlTu+2nJszndwSYMICiRP0VAlwPR8iwBWxh8shCl0lemW08Jc1LonWi2hVH1kmQCFfu2mT8P1hSYcVDWD7AgZ6H4F34kkp+oCe7aikpcTMHJamcVTZA8pM4+jFdfcBBI8EIGYY3W5b72D6KqKhdoiM2MoWuzNm9yOtU4h6eliFqMvwjVmoIfcRcJZJ2OjonZFSeuwr9Bd32npOW70SF6+OKatzqtQ1wztGAGMURff5HgXa4im+KNwqKE99rXcboW0WiZhZ/3VKYhVi5zhB5Jma1zSLPs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(7416014)(376014)(10070799003)(366016)(4053099003)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVo0RUhHV3ZGdFdmckF4aktHT0lNLzJWVmExTzUyL1NSa1BXdjFUSXQ1SDBo?=
 =?utf-8?B?TVRPa1dqN04wK1J5b1BuMlMwaFpib0ZBak9aN216eGhNcDJScE1JQnovZGlQ?=
 =?utf-8?B?cXVLK3NrTWtTMExFKzFzMVZLQ0FYS0VjU0F0Qzc1SHgvSEc2Z0RPK2ZzMHZQ?=
 =?utf-8?B?cmlVbC9jMytVZVp5THJYQVhvandoVm0rWGgyZklhOUV0OEg1bDVQN1VTbTNE?=
 =?utf-8?B?cFBTMmhvdFZpbkxBcU4xQmpoL0x4WDBhUUM3bmFydjg4cGNKTk5BcHArdk5i?=
 =?utf-8?B?a0FPcFpqSTdLT25hcC9vMW5YdE9vRzFacytVVW55NEx5eHVwWUIyUHdyMXJa?=
 =?utf-8?B?NU8vQXdPS3laZHU0SzdNRmhwV2kvZzI1VENNOHFjQUoyaHhQT05NclB4VHRv?=
 =?utf-8?B?SnVpeGF2Zkx3dWU1VWpCcnBWaDdObmRoMEpyTVVsbVN4SDNXWHlzeVpVYlFj?=
 =?utf-8?B?UlNZR2FWZCtsb0x0dmhqTFgzUGJZaGFRbVl0UnJlQ2I4Z2pWYXF5RjlBaUg3?=
 =?utf-8?B?U3lTdUJ2cmJVTERNVHNCYnZzNlFJdXBtUnVkVTByNU5pYmN6MVVxNHhjY3JF?=
 =?utf-8?B?bEhCWVQxOXl5c25hYXN1ZzFmcVhYc0FPaHdUSlhFN2JWNTRYaURZNVVmWjZr?=
 =?utf-8?B?TGxja3U5T0dtMUNVSXl0RzhDY2pYbGJndjE5bVlkbklvc1MvZU9qYTZLWWRE?=
 =?utf-8?B?ZU9vSjNTM25PdTl5bHN3cDV6SENHQ0lyVWRuN2lVWmJCV1pmQjduYlF3ZUp5?=
 =?utf-8?B?S29ubnNmZ1Z1dExyaTJjRXVJaFVqQUpxNkIyc1lreW94K0tZZUZNL2xtZndR?=
 =?utf-8?B?Y1RXZzlWYk1wZ3JCL0MvcGZLeVJ5WFVFUmxMK2c4bFI4ZDlITFo1UCtSRmdo?=
 =?utf-8?B?ajJtNUcvY3FqRmJGV0h4clhFMmFVZlpESzM2Tldjd01ZL2JSbEtVR3Fuanh5?=
 =?utf-8?B?RDN5MGtUazhUaW12Vkl3VUlSNDZhQ1FuWUwva01DVEUyclMyZ0I3ZHQrMEFx?=
 =?utf-8?B?dm1OWG9Ud2pnQ3pLTm1vWVZOOE5GMEVEcUFSL0RRbGJhbmU2ZXV3Ry9VSUhz?=
 =?utf-8?B?ZVdHaWk0ejBNYjcwdkpPQkZFS3RVT3M1MGkrMFFxT2N2NDgxK0NOdHBDcGtQ?=
 =?utf-8?B?QUJiMkxyb1BGcEhPclFrVFl6MmZOWmNSK3VXT1d4TFd4Z3haUzMxZTBrQXBn?=
 =?utf-8?B?TFNGK1IxUTFodFphN3lJSW5TbHRsRjlGM1RZWSsxeGE5TVozSFdnUTFoNzZR?=
 =?utf-8?B?eHlzKzBKUWpodzYzdEc5SkZhbG5DblltVDhITTE2MDBWYmIrMzFyMk5LWkxt?=
 =?utf-8?B?QnR5bjVKVGVHNmJueE1lSE9IZExJRXpGRU4wY3k3a0tPQTFDYTc2YlpoR0R6?=
 =?utf-8?B?ZDdNajhpckNoRUQ1V0tnNFZGa1M5Q2Q5dEl4OUYvTXZUbldoNlMzS3Z6Z2Uz?=
 =?utf-8?B?OFVlSEEyV29aQ2JUUUpOTlFSUmJyU1Q3MjVXOGtmZXhEUUtvOXd0dzFrbDJZ?=
 =?utf-8?B?UHBHNTZCMWJKMVVrRUlWUVpHSThqbE40bnFieFhhNGVNaXd6QUVnSU5ldTdT?=
 =?utf-8?B?WEZNdERXQVU0VWhTRURlMnhoYm1VU3M0dTlVUlZEQnAveS9NckZlL3A5aG1m?=
 =?utf-8?B?dDRlVFpsb1FGNXJuNVFjWm5GeFlhRis4b2pOa0hZTnBiMVZaUHdUY3hSUUlQ?=
 =?utf-8?B?ckE2ME1BR0JVVnM4cVE5WVVvNEUwaElFT0t2T25mRmtEa2FZVk5ISEZKNGM4?=
 =?utf-8?B?N2N5K3RBQkMwRkNHUnd0VzhmM0hNUVRaRGNqdFRDa3BCK3ZuWlVxMkRCT2dh?=
 =?utf-8?B?SlBpYmpkczNVbGlaRlBlYTJFNndOUTcvMEp1ZHY5eDJTbXplVzZ3SmsvVDdN?=
 =?utf-8?B?VmdNam1FQjBxQ0NMNjNiT3ZGMHZ3REhIMVpEa1NWTTlXUko1dC9DQjZTamMz?=
 =?utf-8?B?MWFPVFRHbENpUDlmcy9rSE5FVDlhN0Y3cmtiV1JSUWJSSk9INHZCWGpIYzdu?=
 =?utf-8?B?Vkp3YXVjaEw3SDhQK2ozU3QzV2UyU2UrTFB0MmpvbXd1UlFwMTdCdmZlUTBD?=
 =?utf-8?B?OThOTnd4Qis0YnVhVWY5UERuN1JDZTVYdnF6Smp0YnZsZkczL2F6TUFJZisx?=
 =?utf-8?B?cUYwcklCcFFrRDZqYTVFT1J0YzgvUXJuazJhQkhVb3VYRzc4R0RvdndWMHRN?=
 =?utf-8?B?N3pGNWRyZUVrbFVSVzF5SWxGSlVkNVQ2M2xvUmFpVnpldXc3WXY5U3BqaUFN?=
 =?utf-8?B?MmxjRUUyRTQyR2Q0dW94cGpwNUluaEozNC96amVRZHI2dlRJTzdtTExNWmtE?=
 =?utf-8?B?emJ3bkNaazFhT05WdEc4RU9oLzk4R1hFcXJBSmFtaUVvc2JpcWhMOXRBVlJY?=
 =?utf-8?Q?5c/iwgvE68UzQvebKG0u6QnCnhsp6d2V04gDxmB59Pwsb?=
x-ms-exchange-antispam-messagedata-1: uf2yYDgP6IcIuA==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar4nWB1BVh293zBlPQ+38fQHX6veNrtMYlRPRYzJci4C0hRLfb6Omgx/5Xe9uEPYGfHESbGgrP9AwkobOe7vxjuLhM1bvYJh+jBA4ewNzlVu6Iohbyz86V+mql9Ly/SQggxW7eqo3Xtq7QAHlxttF7c/f33+o6HEdRZOk2pBegGnJG9Nub1zHdcnETGx4EdCj8ygMVd/AFlIYrVnIWH/Oak0FHb73pJa8e3gB5k0tL+PHIaSFpPqgUqrU/e+m3FAbwF4phcky6ud4kFCaOmXN/xIx10epJvS1vjQ0iStMMlBMEknM1hyY60rXq/WdcH/uSjzCKXLh0BeByx1eyg0Fw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDQjtxPzXKJD/EfINCzh2C/U/Cnl5mUVMBrIwpqOlaM=;
 b=g3QFYb3hsOdxipqQPh+1llhjDqijZRCct+XkbaJuS+l9SN7bvbdSTjgeYuNr4kH0zREwyUGSBEHQjOt/rix6oV7YWEsINE5OLCrCIj/SckeRBysmE7hoXqLMyVu0R6atAGcytVbdH2M+4xTC/WcOA5NJ96A5TxcNa0Te2A56tD46t8cHEFZEwZFJfgGIV69lnA76jYa00U6RettuMKUm2+OuREqYSnZ8COzlDzxRhbDoYMBKB/7yuSvEYk3z4NewQwVdbPcRpKfiuJzR6m8vyXOmM07Lh9+OC5gTAib9NoIC8dGPPwQZbGTsjOOdDP6vtu2I3CX1mPvK/gnZQG84Cw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: AVltMwkCPmxrBO9GoF6ucseSfhFw4/Z7wDUIMLjgeKkylfmAT0AkVU2TCMPVsv2MieRVpVBFRAeAF05bPm2L50HM7qRYH+/MujWdzU0/9LXAGfIVyKezwGw4cltY6EhMeAMu4sXjHmnMvgFMlZkbDjuc229RzEbP6TmY4y5gu7KiXRsv7JCK53Pav6haGlUgts/odSWuRnJFNhgAP/C97eJ69laOZot2DMDRRP3SJ4nqgCMy+MD5tNWhxfzP34acZydGtCfdxuoL/YFvf6qCMnwsU5iT0ReMtvpnWghpzLbIjlAKj3e2owuXY9CgjONV0U+rmk9lzLA3DAYg8A91yw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 9b132b17-319a-4ed8-e38a-08de8b597f62
x-ms-exchange-crosstenant-originalarrivaltime: 26 Mar 2026 17:02:41.6133 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 9H8KntGq1gm5TMaXV8QaJjfCtS+RAFO2XxKZY6zmVJQ5xVeFljI4dkWsUFVbTY9Fwg+HqP+QYr0Z5Z33oJBP1g==
x-ms-exchange-transport-crosstenantheadersstamped: SA6PR17MB7297
Content-Type: multipart/signed;
	boundary="Apple-Mail=_B734A43A-C374-4DE6-BE8A-9C3DA3B96D18";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2603050001 definitions=main-2603260118
X-Authority-Analysis: v=2.4 cv=K+ES2SWI c=1 sm=1 tr=0 ts=69c566bf cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=d4nn1RXdvEacMIURMw2s:22
 a=X7Ea-ya5AAAA:8 a=j1LZ3Z_piOpW3ZEyAFIA:9 a=QEXdDO2ut3YA:10
 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMSBTYWx0ZWRfX+ZLkCgGJtgXn
 EpkJla8z2vwihAg/JezAGINkb0XYkJUhFW3vNs27h0wPPFkE2NMpBjq9YjpRoBocLrm6OAgioT/
 P/bJSFoSATR4LHbtKJ1DbZxdoryzvh8uCTGchVvx/eL6Cs3Zn0vl8SLE9VAa8hGOKalZbxnQHxI
 K32ozFieemWEvnMPAdUjjeS+7qS9+vQFhhoWkQZfTZ1r/UkFqA8a4jFXW+0URfIEzi7ATI0PV32
 uj6oplfH0EmEMrGn/PqrxjHpEJ4Wsq3/K7ApepmqGoCpdL0PV2716+4Eb2RIELoMB/xJ+zcHIje
 XKsc09cKnirtIsNIGxRsh9TXcfFpWeaihAi3Bxr+I7Va4iWyNWACWLbvHpCZOB9IKlBGx/rih0N
 e39wGNSz12tucLAdG3Cy56jeQrg5DJTej/XGjiS3rv37lNG0TdAsslMKBfwelfCtmMn+InZDLXg
 uaJlitqPbiEKrjGcUaA==
X-Proofpoint-GUID: 11mpZ7RJi3GYwOwCCatEZDfNOTI9DV-y
X-Proofpoint-ORIG-GUID: 11mpZ7RJi3GYwOwCCatEZDfNOTI9DV-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603260121
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272158-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,akamai.com:dkim,akamai.com:email,akamai.com:mid]
X-Rspamd-Queue-Id: D0235338DEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_B734A43A-C374-4DE6-BE8A-9C3DA3B96D18
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 24, 2026, at 6:12=E2=80=AFPM, Martin KaFai Lau =
<martin.lau@linux.dev> wrote:
>=20
> !-------------------------------------------------------------------|
> This Message Is =46rom an External Sender
> This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> On 3/18/26 6:42 AM, Nick Hudson wrote:
>> Introduce helper masks for bpf_skb_adjust_room() flags to simplify
>> validation logic:
>> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
>> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
>> - BPF_F_ADJ_ROOM_ENCAP_MASK
>> - BPF_F_ADJ_ROOM_DECAP_MASK
>> Add flag validation to bpf_skb_net_grow() to reject invalid encap
>> flags early. Refactor existing validation checks in =
bpf_skb_net_shrink()
>> and bpf_skb_adjust_room() to use the new masks (no behavior change).
>> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>> ---
>>  net/core/filter.c | 31 +++++++++++++++++++++++--------
>>  1 file changed, 23 insertions(+), 8 deletions(-)
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 0d5d5a17acb2..7c2871b40fe4 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3483,14 +3483,25 @@ static u32 bpf_skb_net_base_len(const struct =
sk_buff *skb)
>>  #define BPF_F_ADJ_ROOM_DECAP_L3_MASK (BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | =
\
>>    BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>>  -#define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
>> -  BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>> +#define BPF_F_ADJ_ROOM_DECAP_L4_MASK (BPF_F_ADJ_ROOM_DECAP_L4_UDP | =
\
>> +  BPF_F_ADJ_ROOM_DECAP_L4_GRE)
>> +
>> +#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK (BPF_F_ADJ_ROOM_DECAP_IPXIP4 =
| \
>> +  BPF_F_ADJ_ROOM_DECAP_IPXIP6)
>> +
>> +#define BPF_F_ADJ_ROOM_ENCAP_MASK (BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>>    BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>>    BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>>    BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
>>    BPF_F_ADJ_ROOM_ENCAP_L2( \
>> -   BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
>> -  BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> +   BPF_ADJ_ROOM_ENCAP_L2_MASK))
>> +
>> +#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> +
>> +#define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
>> +  BPF_F_ADJ_ROOM_ENCAP_MASK | \
>> +  BPF_F_ADJ_ROOM_DECAP_MASK | \
>> +  BPF_F_ADJ_ROOM_NO_CSUM_RESET)
>=20
> The patch does two things: refactoring of existing macros =
(BPF_F_ADJ_ROOM_ENCAP_MASK, BPF_F_ADJ_ROOM_DECAP_MASK) and new additions =
(BPF_F_ADJ_ROOM_DECAP_L4_MASK, BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) that =
depend on the new flags from the UAPI changes in patch 2.
>=20
> The refactoring does not depend on the new UAPI flags and could be a =
separate patch placed earlier in the series. That way a reviewer can =
verify it is a no-op without the new flag additions getting in
> the way. The (BPF_F_ADJ_ROOM_DECAP_L4_MASK, =
BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) can be introduced together in patch 4 =
when it is first used.

OK, will split further.

>=20
>>    static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 =
len_diff,
>>       u64 flags)
>> @@ -3502,6 +3513,11 @@ static int bpf_skb_net_grow(struct sk_buff =
*skb, u32 off, u32 len_diff,
>>   unsigned int gso_type =3D SKB_GSO_DODGY;
>>   int ret;
>>  + if (unlikely(flags & ~(BPF_F_ADJ_ROOM_ENCAP_MASK |
>> +        BPF_F_ADJ_ROOM_NO_CSUM_RESET |
>> +        BPF_F_ADJ_ROOM_FIXED_GSO)))
>=20
> Under which case this new check will be hit?

If a user supplies +ve len_diff and attempts to pass a DECAP flag.

The commit message had

    Add flag validation to bpf_skb_net_grow() to reject invalid encap
    flags early.

>=20
>> + return -EINVAL;
>> +
>>   if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
>>   /* udp gso_size delineates datagrams, only allow if fixed */
>>   if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
>> @@ -3611,8 +3627,8 @@ static int bpf_skb_net_shrink(struct sk_buff =
*skb, u32 off, u32 len_diff,
>>  {
>>   int ret;
>>  - if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
>> -        BPF_F_ADJ_ROOM_DECAP_L3_MASK |
>> + if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
>> +        BPF_F_ADJ_ROOM_FIXED_GSO |
>>          BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>>   return -EINVAL;
>>  @@ -3708,8 +3724,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff =
*, skb, s32, len_diff,
>>   u32 off;
>>   int ret;
>>  - if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
>> -        BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>> + if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
>>   return -EINVAL;
>>   if (unlikely(len_diff_abs > 0xfffU))
>>   return -EFAULT;



--Apple-Mail=_B734A43A-C374-4DE6-BE8A-9C3DA3B96D18
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCc8w
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
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJjCCBMyg
AwIBAgITFwALeewU5YRKbvcMWwABAAt57DAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI2MDMyMDEzNDgw
MloXDTI4MDMxOTEzNDgwMlowUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1FIVDEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAx+gvYqVaQAmc/yNlMv3t5CK6FN7++3ZChJpOElnFyZWj3h+VwSqN
5WD4VQn5DL515KovgCiv63DeQ1NuXNu3XKKeakHyssixhIL2hqjlPFnsrwXJ2R9B9hAGIiOBy2rK
Var+w87AFUZ70jsZlI70IBnJOYsPYnZRmXBytTxVWk9V7Nnh10RuUfkZE2Ry+P18Z7glHYoQeksi
hz/9uqRUEqt23qDYBR1J7bB+SSW5A3LmoTEugWYzayxb9iM0vVleEHqeuN5nihGn8Y7nIrs5sIo8
6AG2Bjl0O2VgWWVfqhl9IMQlx1ZxHAicuMvDN49LD1yMkqx+LeBLboiFQQ0MVQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUD8PIZa7GFc+oX4RLtUq8oUrOL/IwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
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
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIBZ79THtRc/r
DXpg8rSeL4tPy9/eLjXnJvYW5Ek2SUJ8AiEA5j0Wa0K9P2Vumn7N4F5MpbHW2t/kxsdwUu2Vzp6S
5BUxggHpMIIB5QIBATBTMDwxITAfBgNVBAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEXMBUG
A1UEAxMOQWthbWFpQ2xpZW50Q0ECExcAC3nsFOWESm73DFsAAQALeewwDQYJYIZIAWUDBAIBBQCg
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMjYxNzAyMzFa
MC8GCSqGSIb3DQEJBDEiBCDeWHkiUEPPEmhsj4fCbZs5Tt6fIuBcAdYXQVb9rBRCYTANBgkqhkiG
9w0BAQsFAASCAQCP3CYcZSxFYBgZlNV7CUn5C+8mfhynHHLM7oCb9pe7xsTtnPE5fnZThJwQpBaa
L+Ho6Eq331daFJQlY9stTMVX6slMD8kEpUF3NC1jymggWRj6j6AiNHVu+O6j1ABYjzhefmtxMCBP
32sncZH0f//pPX5fcW1L9+1BqqCe4jtkOgAMbIVv2HFULSkGUMq5GgGhlunv56v7lxTfxJcfJt0s
fqXAgvXSCwNtIRx2iDzH9Lc1PX+UVqZQ0wTeiEL7qplUClF6ksgvhtpRgoKNbG60TzDRy1kg++kZ
WnShOgiMzZisPwn2Tq/uWbi+Pn9A8xRE0YfEuJrx0F3KK1EhZEo6AAAAAAAA

--Apple-Mail=_B734A43A-C374-4DE6-BE8A-9C3DA3B96D18--

