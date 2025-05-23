Return-Path: <netdev+bounces-193148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599D1AC2A97
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21E4189C702
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF1191F7F;
	Fri, 23 May 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="oQ1lSSsU";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="GWedFTN6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADB7E1;
	Fri, 23 May 2025 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029781; cv=fail; b=gmlNNdFY8v9n7Ql6WHAi1lbX+Mpsqx3R15X2T/hmnlOmOtO8B0oYFbHqQs4gvErdpeSrIJCLCbwmuqUQIs4wXy3ONGz2erUaCOpgUige3uXbKEJTKlFsPhcBENKYQNAB+faJLT/AFC5ml63mwyRYE4/Mzrw7vXR4XjXjogX0d/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029781; c=relaxed/simple;
	bh=jTBmKnrADGF4D/wUI9MW/gNnKL/uBupkJExKuU1D4w4=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=ej8YekLXyA/dzLp/jqQw4StOLnBz0E1LzTOoR0JeXZt6cN+9UcjxndaKNyAAInWeJy64Vr+ubyA9pinP68Yc0la2hyUorR5t508bMnn5fQ5QX8710ytO/vUn2Y+Ua2lwo6SLaCxvjAc2crwH/Un90hJVEYxlHyVUtlO8zZ9n4zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=oQ1lSSsU; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=GWedFTN6; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NDnIrA017241;
	Fri, 23 May 2025 14:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=UJtx8AZ5bILF/UCMYKXU6Qxm52SvQxavR7/2EfU1Hnw=; b=oQ1lSSsUXF8K
	MVeW2qJISxKWfv7Xl6w1nDJpfV8Y2yuE42guPcVwaNuphhTQ1DQtWIc3g4EY0kqT
	lAj2DLraqTUoQFTWVMfk/vWXi+0JJ0xvBLOgPfOrUKcqN8tcxaan01SO7QtdkHzb
	q5+Kx1JxId7OzhaDf2SYLCL0oVHVC1W5MS790XflMo72L9X8kRNxgimg4YrsX8kk
	dgcQ7k8mur2iecs8wdVPoV0Bmt/0u+i+nCiAOpz1B6/oSr/vwXd9rC1CiQqqe7nE
	xE5YW19I0AxVMg2uJopKqM1JcE1DA028RAI0NLJD0k4a5SrlMyNwXV6z1tmPohwG
	YvwqeauqBQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2109.outbound.protection.outlook.com [40.107.94.109])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46sn66mvb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 14:49:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbRuTWCRhnXrBDTPGZOJMFRU76zKGByT8j0J/W4ZUhGtSdGqetPVLQtDJKUA3XKHwIrmKZIYvYa928XaqnEeUUQzIO22hGNZ1bYt7NqkOzl5x+XzKPppDYLNTIloL9EGVur9zp0563yzjRDm8vLbqn/LMDjtQY78OaayEtk6m08Gb8jCVoRxnHnDbGokVWW/zB5ACSYyRc/y91aksPpHDDgNIzy6m6sgkLXGub6lFzzK3FRUxYhpdFa8kXLH7ezs6gV3jNmUPzUZqbtLp5ixzWrnnH0OAtk2jZAcmcO/RdCePRXY6xx0P2gLpFGN1gab3MI6MHjYjM3FsSkJtZmOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJtx8AZ5bILF/UCMYKXU6Qxm52SvQxavR7/2EfU1Hnw=;
 b=BlMd88gE8aS+b14xv4UE8cee8No4KzSfs0+bvfliAzizvU8gYcXUg9fY+By1jynJQQdxJLsuswvRnUfw1AzGDtfsNZdCrxBcCiwjsWM2oY6kQ2qJPCT124hHPSAEZYzGh3vYGl7reiS01hXduF01lyWlK1vAURaa5QRN9rpPnkkSWMyoujFiy7RpGiR+aaksUemBqIewbJxawxwlwPEqfotqhSNY2HCDFYaxFjFAjzZbt8978Nx2zMWXvxfB/zPMgGspVIEwFsZRfAQqBzKnS389stGRxTsbXT+vFEmPkCNlzR8HTtLwl5my+eS1eWLp70TKAVTbkmme/MwjFbVHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJtx8AZ5bILF/UCMYKXU6Qxm52SvQxavR7/2EfU1Hnw=;
 b=GWedFTN6ahgfiV11JQ+sNleFl1no/8XohIan4tr7nC4UtY/63+Q6A165mbo+ary56pYy5gv7i9X1TOX+SRzzD9sfmDn9KRzFdT9b+iLTtgwSMxuc6adyZJx63sG1kL5pWxq3XSEyDSLO8znLbQTt11fFwOGgKwDQH+ytfeF6agI=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by SN7PR11MB7591.namprd11.prod.outlook.com (2603:10b6:806:32b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 19:49:09 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 19:49:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 May 2025 15:49:05 -0400
Message-Id: <DA3STV21NQE0.23SODSDP37DI7@silabs.com>
From: =?utf-8?q?Damien_Ri=C3=A9gel?= <damien.riegel@silabs.com>
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
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
To: "Alex Elder" <elder@ieee.org>, "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.20.1
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <65cc6196-7ebe-453f-8148-ecb93e5b69fd@ieee.org>
In-Reply-To: <65cc6196-7ebe-453f-8148-ecb93e5b69fd@ieee.org>
X-ClientProxiedBy: YQBPR0101CA0324.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::28) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|SN7PR11MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 33926442-3635-40e7-e49f-08dd9a32e267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUNNMk5IandiMi83TVlSWWdRVXZ3ZEFNb3dFNUE2RGYwaXZMV3ZWNjVSb1Jj?=
 =?utf-8?B?YU0yZ1BPVXdnZnFmejZETTQzU2Z6TkpMK2Z1enAwaE1OUzZwamoyY29Wdkcy?=
 =?utf-8?B?OURZZzFwT1RJL1l3WjhtMTFEZHFZVGR0c3g3WTRjTnJKcTNEV0pvaDlVU0Rm?=
 =?utf-8?B?VUxucWZXNDYzbloyb3hOUlk4N1JqQnRXVnlGNG9vbjExVW04SkxkaEo4M1A0?=
 =?utf-8?B?Tm5waEE1Z0dDY2lhWmV0WVc3OXhjMzM5ZVpjOHplNlg4UnBoM2FPZUxSMGh6?=
 =?utf-8?B?U0dnME9qTmZHMnNKczZKWW4ycFozbHhaYjltK2NBMWhySFlTalVRZjB5SFAx?=
 =?utf-8?B?QzhOS05nSVRUaWoxQ2VYc1lJNkVDVGgzZDVxWkM3TC9EL29kMHJJOElIcXVD?=
 =?utf-8?B?ek5UUVNNRThaWEp0K08zVmh5RjI1bkRDazR6QjdIRDZXVnhuK1lGcWVCc2pL?=
 =?utf-8?B?MzBGK0VlTjlCNWJqNldZSkxHYlg5VUJjeXE2V3ZNQTIyRHBCYjByQlQ5Uk5V?=
 =?utf-8?B?bGFncEVMNG9mQUF0OGpsQ3Y5dXllaDErcHk2ME45ckEwd09EcFZDd0FPVkRD?=
 =?utf-8?B?ZUluVzg5a2lzaHVFTDVmaFZ0UWxIN1RJSERjQXRYUWo1L0drMjEwbkhSb1VC?=
 =?utf-8?B?VlR5ZDM5a1QxK0hDZEZMb1htdWdHcVFUZWFXRmc0cEJHWjk4NXZqUkxWSDFM?=
 =?utf-8?B?aVlrQVV5Y0Iwbjc4dDFiU0l1ak55cXFML2IyVUlaa0NCSVliS2dIWXo1OW1J?=
 =?utf-8?B?KzFtamNqODd3OFIxZjVRQU1EYlJwTkhrYmVDeXhNMExqZzlTNFY0MkhsU1Nm?=
 =?utf-8?B?ZHNYa2YzeFQ3RWhoV0VzcTBieDNKNGtrOWkvV2ZoRVJOLzI1eWFrMVpMOGp3?=
 =?utf-8?B?NldPV0w0b0VScGU5TkdKRisxK3JGRXVKS2xzU0dVdWYxUUhCRG5EUmhHbFJs?=
 =?utf-8?B?aEM0UThRZHpwc2hCZVJ6ZnIwZ0tBc2hvQ1p1ZlVtbXVwYno4NzM0NlBULzAz?=
 =?utf-8?B?RUUzSWpHeW1CZng1TVVySDN5RUtZemdlcFM1cEhCbSs1K2pLTWJOcmdTeFB2?=
 =?utf-8?B?SzBEc0ZlNURoOVUxWGhnODl6QkxrWC9kQjF6bzlFNEFzc2FYaFpNNTg0S1Ba?=
 =?utf-8?B?a3VPYXNTWFJ5Y2ErMEIyRUo2VjFvMjl1K1hkQkZ5OElDZXhmeUZNcWlTMFZw?=
 =?utf-8?B?dFpPd1ZFQVMxcTJrbERodVcwcDlEWVJENXZBc1Q3eGlwcGRkemo4RkVJZllX?=
 =?utf-8?B?bXhQWDJHc0pKemxhT0MvODlESCtRS1pKM1VYRXBpNVd6OXJYZ2tMZE5XVGkv?=
 =?utf-8?B?UCtVSDFsSzZTT2t3Zk5sT1lueDl1VVVic2VrbHhXekR6ZXZrWmk5ZVcxTGhu?=
 =?utf-8?B?L01SMm82UGttUVF2eXNYVUJtVlRUd2kzeXVVQjlLamNtdlBwQ2laTXJUUW1Z?=
 =?utf-8?B?SmozUTRkczNnbXdYNWpWQnA4eDNHK2xLNkhscm5keWtsNmNzS0drZmFROGVF?=
 =?utf-8?B?YW1lOVhuUHg2WjVBZitDcUxmZkg1bzh0aWQ5cjV5SWxTWkhucTZvUUQ4SzJB?=
 =?utf-8?B?U3BVd2lHbm5rNTByd0dkajVEK0ZtdFhnM044dzJzVFgvd1JQVjZRR1FKdU5F?=
 =?utf-8?B?L1U2VHNsMGtESThQc0RCU0E3UXZvakE0WUI2d1pyRHdRRWpkN0VjckI5dkRP?=
 =?utf-8?B?V1pBRktuamMrUWZIQlFVOVREUTd4SUQzZFA1ZFloc0pnT0RSSFozZ2pmd1pZ?=
 =?utf-8?B?Y04vanVqYURJZVZSaDJHbno4ODhmUjRHNHBqU1l6alU0Q3BxcUNQRkZjR25t?=
 =?utf-8?Q?9/m14o7TAAwdQVLVVeGj0HYXzdF1kAy0yG1v8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0V0VWdpcDJFNGFtT3JsMEVyMDRtWGJOL2ZsdUh3Ti9IQ1piRjdXMzQzVVNK?=
 =?utf-8?B?ajZERkRwQjdQS0RiZDQwNUlra2xEM3JXRS93RkpkcU53QWx2MGJEZm43a2ZB?=
 =?utf-8?B?M1B2UWs2ZFVTbnRWRjY3bG0xRWtiUmsyZEVYdGNSeGFlVVFmM3BtOEQyallH?=
 =?utf-8?B?Q1JwWHhpWWg4Nk9RK2NoZk5UN051a25QaklNMmo3UXhlK0ZJOC9KbS93Ujds?=
 =?utf-8?B?TWxwQ0dFWDdvYUhoOGVDNjRiY0o0cUx2d0VZZ0RwT3dCNUE4emxrU1lJUjVK?=
 =?utf-8?B?VHZ6QkVXRFRLM1psMEc5NEdqd1FKaWYxQ2JIcmRCRGxqbXVYNE1UZkt0cWlh?=
 =?utf-8?B?SVFheEdaNjNqTmh6SzFzWGdaNS9NUWFqMU4xaEFQTTIwZjVPVER3Q05ZRHdQ?=
 =?utf-8?B?elQ4R3NJTGxJY1N0ZWhIOGdhVXRTSTc2bGtVMG5ZdGVMSWNROGVldjBXaVFZ?=
 =?utf-8?B?SXJCK0x4eDZ3b3Z6N251MUt1OC9nU00yS2FIdWdmdm5IQytGOHJpYUo0VmYz?=
 =?utf-8?B?cEtpVStnaERIOEJIdkduc2c2a3NjbVdIQUREOWZlZDNueWV4SjFwVTVMNVNo?=
 =?utf-8?B?UjdqL09QSW8rN0xKSzNqUjZsME4vZEZrck5xRmtKcmZIcDl2aEJMelRqSGx0?=
 =?utf-8?B?UExQN2srMDdhWnlleXk5R2k1ZkRHdmlzbWRjenlvcFczdWtwMUkxZEtvRE5p?=
 =?utf-8?B?eU9Zc2hHd3lXNHBJaCsyQmtHdy9vSThlR1BrbXZ2QVlpbGY4MWQ5NzBMb0Ex?=
 =?utf-8?B?MHQxZ2hSRlowQ0N1Sm8reXpQM25ncjRMSEFXVElHWFhRd1FXZHZiNUpmem80?=
 =?utf-8?B?TXpwd01QU3lHOWZJUnhSazRpZ1l2aHVqbmYwSEdCWU1MOStJOXRyZU5PeG9Y?=
 =?utf-8?B?KzhlVmJMVXpIZVh2cERNeElSVVFBNlZ4UEtsZE5rTG9XcEMrYzdaMHNmUTM3?=
 =?utf-8?B?VnhIMHBSQThqck9LenMrMHJzRGtkY1JKMzZoS1lFblc1YnNsVy9LMGx3eW1C?=
 =?utf-8?B?cGpjeU4xTm4wb3VJYlF3WjNaYVJ6NysvV1RPRVJlclBIN054aDZoVjlDYVpj?=
 =?utf-8?B?aWswSVk2Skp3Z1NKRHYxeHhtWkxTVFRQOEFITlNZY3ZyYmt2NFNubmtzdGFU?=
 =?utf-8?B?Zm0xQ1BkS1VTVHRQclZjOGZudmJNRW9LbHJQV3ZaU0c2TStEdFFHbFdYM1Ar?=
 =?utf-8?B?UktMTFV0aTZDb2pSMW1VQVJDMm5jdVgyOWFveUhmRkNuMXNMR0lJdDk5L0Ja?=
 =?utf-8?B?dHRCMncyTEl3allnblRyb2JaekpRdGcvQzMwdFk3VmJnSUpRdVI2OE5xdkR5?=
 =?utf-8?B?b1QzRmYrTHRKcGVDcnUvbWpnQW9SS3hqMnVBbUFzbkNqUkZXcmI2clI5L2tJ?=
 =?utf-8?B?RmpBWmhXczZURWsxQ3h2b2UwTFRCUlJHM3NmZ21Mem43RVVoR0ZLQkJNSm0w?=
 =?utf-8?B?QW5LbnpoaGlEQ2g1VThEb3lOaHdtZWUvcG93cXpwTHNFUlhEQ3FoRy9NZCt4?=
 =?utf-8?B?ZENoRDdZbU8wWGxtclRYUWo3QWNmVXY5TzliMWtVQzZwYU5zR2dHck42MUpD?=
 =?utf-8?B?M3UvVnlMTHFXS0ZhYXN2S1ozNGt6Y1FjeVMwY1ZZRFJ6anZpZFgvbkQxZWVt?=
 =?utf-8?B?Z2h5Z21aMmVUSUt0TmNMRzdvKzlWejg1Ri9Mb0w4MFZqWnc5SVdORXlqZ09a?=
 =?utf-8?B?SFlGSDR3eUFwRUU0RW92OHlRSHkrTmhqUVpUd04wMTBQSzFGbE9iY1Y0K2V0?=
 =?utf-8?B?cmdYbmlhakY1NnZBT29EVGY2WDFBSExqbjZwZFc0bnpaT1hWTjFrUTUzVGtI?=
 =?utf-8?B?SDJRbmZyRjR1YkNKVnZoWTJBeS9STzRPVE5RRVpsMklReFpRRnhhNGNBZGtC?=
 =?utf-8?B?ek5vTS9YdHVrMzVwS3YvcXZxY2o2b245bEJMa0FvRDgvK3F0WExucmxTRUhm?=
 =?utf-8?B?aCs0TkVnZHA2aHJ0TFVFWFZnVWVqMVVvYlZ4R3NJZXZoUlRtbGdVVitUOGFY?=
 =?utf-8?B?OUV1aTJTU2pFOFBkQktZM2lTQnZZYVVEY01pRHNBd25zSVRzRE9IQU05ODBO?=
 =?utf-8?B?OHFBazZJd0tWaE55THRQUFpWSVUzL3ZMV0cwNU1Gd3BMS1NmZVVPckljZmdz?=
 =?utf-8?Q?Ps13lwVW5y4T1xXN5eWFfdz5z?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33926442-3635-40e7-e49f-08dd9a32e267
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 19:49:09.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZhKmhgK18d9vN78+WE4Za3bmkmYu4lLd58RLWYONbLqd1yo+j+mOm4VQiMBBv0YiPJ6eWOY5kgbMK9g3I1PZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7591
X-Proofpoint-ORIG-GUID: Y_MCLbZtEKemD-zcsH_gRb0NoHoqAnX8
X-Authority-Analysis: v=2.4 cv=JI07s9Kb c=1 sm=1 tr=0 ts=6830d139 cx=c_pps a=Aw7NL8YgY1wPWxdbGT6CAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2Fbpa9VpAAAA:8 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=Af58r-0oYm23b-L28WEA:9 a=QEXdDO2ut3YA:10 a=AsRvB5IyE59LPD4syVNT:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE4MSBTYWx0ZWRfX/msHtV5ZpqMU YbTqrKlcJ+E7+PiJYXowtq/O9TSzc/Mc6tFkIfpRFW7qrrhQg2npzPlNjdvNQkVuw6Jha5phtXR 1Ocp2Wzd3zkj+sV1L+UmrQJ2dqLQVP4hkIXS0EM+E1MILXea4T6h43+5J6zX6HMZFlGoxxRV8FV
 OpOurvpc1JNutJ5pLE3GX95+nUtoYTjpL85F/ECRUoybRwEXTUCA3lL/jAhlhh6tAWFPgC0tzH8 vR8FQnhsg932v8quM1K8QlaXXCZb5GwojGLYf7uVk/ZK9txLsKqYNH9ptR+rsvrx4Syq2n6YWxA nzsAHN4fwShyajXB1CFhecs+8nQ7SP10KrNifUpk+2al/ue7ikGJPbMV4SopMh4wvV7/NbiVLYM
 n8BJ2/tATQ+E8yLoxqasHJ/7ZpLnDSuvNswnvaFrLVSZW8lIEzY0gflX6P2Zxfidj2JeyuUr
X-Proofpoint-GUID: Y_MCLbZtEKemD-zcsH_gRb0NoHoqAnX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505230181

On Wed May 21, 2025 at 10:46 PM EDT, Alex Elder wrote:
> On 5/14/25 5:52 PM, Damien Ri=C3=A9gel wrote:
>> On Tue May 13, 2025 at 5:53 PM EDT, Andrew Lunn wrote:
>>> On Tue, May 13, 2025 at 05:15:20PM -0400, Damien Ri=C3=A9gel wrote:
>>>> On Mon May 12, 2025 at 1:07 PM EDT, Andrew Lunn wrote:
>>>>> On Sun, May 11, 2025 at 09:27:33PM -0400, Damien Ri=C3=A9gel wrote:
>>>>>> Hi,
>>>>>>
>>>>>>
>>>>>> This patchset brings initial support for Silicon Labs CPC protocol,
>>>>>> standing for Co-Processor Communication. This protocol is used by th=
e
>>>>>> EFR32 Series [1]. These devices offer a variety for radio protocols,
>>>>>> such as Bluetooth, Z-Wave, Zigbee [2].
>>>>>
>>>>> Before we get too deep into the details of the patches, please could
>>>>> you do a compare/contrast to Greybus.
>>>>
>>>> Thank you for the prompt feedback on the RFC. We took a look at Greybu=
s
>>>> in the past and it didn't seem to fit our needs. One of the main use
>>>> case that drove the development of CPC was to support WiFi (in
>>>> coexistence with other radio stacks) over SDIO, and get the maximum
>>>> throughput possible. We concluded that to achieve this we would need
>>>> packet aggregation, as sending one frame at a time over SDIO is
>>>> wasteful, and managing Radio Co-Processor available buffers, as sendin=
g
>>>> frames that the RCP is not able to process would degrade performance.
>>>>
>>>> Greybus don't seem to offer these capabilities. It seems to be more
>>>> geared towards implementing RPC, where the host would send a command,
>>>> and then wait for the device to execute it and to respond. For Greybus=
'
>>>> protocols that implement some "streaming" features like audio or video
>>>> capture, the data streams go to an I2S or CSI interface, but it doesn'=
t
>>>> seem to go through a CPort. So it seems to act as a backbone to connec=
t
>>>> CPorts together, but high-throughput transfers happen on other types o=
f
>>>> links. CPC is more about moving data over a physical link, guaranteein=
g
>>>> ordered delivery and avoiding unnecessary transmissions if remote
>>>> doesn't have the resources, it's much lower level than Greybus.
>>>
>>> As is said, i don't know Greybus too well. I hope its Maintainers can
>>> comment on this.
>>>
>>>>> Also, this patch adds Bluetooth, you talk about Z-Wave and Zigbee. Bu=
t
>>>>> the EFR32 is a general purpose SoC, with I2C, SPI, PWM, UART. Greybus
>>>>> has support for these, although the code is current in staging. But
>>>>> for staging code, it is actually pretty good.
>>>>
>>>> I agree with you that the EFR32 is a general purpose SoC and exposing
>>>> all available peripherals would be great, but most customers buy it as
>>>> an RCP module with one or more radio stacks enabled, and that's the
>>>> situation we're trying to address. Maybe I introduced a framework with
>>>> custom bus, drivers and endpoints where it was unnecessary, the goal i=
s
>>>> not to be super generic but only to support coexistence of our radio
>>>> stacks.
>>>
>>> This leads to my next problem.
>>>
>>> https://www.nordicsemi.com/-/media/Software-and-other-downloads/Product=
-Briefs/nRF5340-SoC-PB.pdf
>>> Nordic Semiconductor has what appears to be a similar device.
>>>
>>> https://www.microchip.com/en-us/products/wireless-connectivity/bluetoot=
h-low-energy/microcontrollers
>>> Microchip has a similar device as well.
>>>
>>> https://www.ti.com/product/CC2674R10
>>> TI has a similar device.
>>>
>>> And maybe there are others?
>>>
>>> Are we going to get a Silabs CPC, a Nordic CPC, a Microchip CPC, a TI
>>> CPC, and an ACME CPC?
>>>
>>> How do we end up with one implementation?
>>>
>>> Maybe Greybus does not currently support your streaming use case too
>>> well, but it is at least vendor neutral. Can it be extended for
>>> streaming?
>>
>> I get the sentiment that we don't want every single vendor to push their
>> own protocols that are ever so slightly different. To be honest, I don't
>> know if Greybus can be extended for that use case, or if it's something
>> they are interested in supporting. I've subscribed to greybus-dev so
>> hopefully my email will get through this time (previous one is pending
>> approval).
>
> Greybus was designed for a particular platform, but the intention
> was to make it extensible.  It can be extended with new protocols,
> and I don't think anyone is opposed to that.
>
>> Unfortunately, we're deep down the CPC road, especially on the firmware
>> side. Blame on me for not sending the RFC sooner and getting feedback
>> earlier, but if we have to massively change our course of action we need
>> some degree of confidence that this is a viable alternative for
>> achieving high-throughput for WiFi over SDIO. I would really value any
>> input from the Greybus folks on this.
>
> I kind of assumed this.  I'm sure Andrew's message was not that
> welcome for that reason, but he's right about trying to agree on
> something in common if possible.  If Greybus can solve all your
> problems, the maintainers will support the code being modified
> to support what's needed.
>
> (To be clear, I don't assume Greybus will solve all your problems.
> For example, UniPro provides a reliable transport, so that's what
> Greybus currently expects.)

I don't really know about UniPro and I'm learning about it as the
discussion goes, but one of the point listed on Wikipedia is
"reliability - data errors detected and correctable via retransmission"

This is where CPC could come in, probably with a different name and a
reduced scope, as a way to implement reliable transmission over UART,
SPI, SDIO, by ensuring data errors are detected and packets
retransmitted if necessary, and be limited to that.

What's missing for us in Greybus, as discussed in a subthread, is
asynchronous operations to fit better with the network stack, but I
think that could easily be added.

