Return-Path: <netdev+bounces-269353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JP4Jr2xu2k8mgIAu9opvQ
	(envelope-from <netdev+bounces-269353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:20:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D232C7C31
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB6E33033A8B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50601367F54;
	Thu, 19 Mar 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="DiMxKHWs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2C21CC5A;
	Thu, 19 Mar 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908304; cv=fail; b=jTWid9iKoq+nDNNqtZfekuZppwRKM59OpKgbLoMum9xxAMhkeVHWBtU0q20np0NEAMVU5AwIKMndTD+fGwpYo9InyADLjWKgxtdtOnwZNpaYxX17Y65Z+Uisfc9VoXG4jHqg5zwRLGwailgKGFYfjYOFbJ2RTg4S+gbAgGGbqiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908304; c=relaxed/simple;
	bh=vtYY372EPVyzy2e42xFKIMIwiT5dZ96uIfV3Lo4lGJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pDh9Dl+bmgtfQPjTGPlLYIUXS7qYn76wYGPjG+bUpEo3SzHOpcow1IW/x6VEf3voa+1N8cMU1e3QHJ559+7GBszseoxl6lUMQd2uN8u+zu5Yah1Vmv+zXJVuPC19LBayDryKWjZV/BSiJfWdQTpnz5DoubrhrdQzgMeOUEl/0o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=fail smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=DiMxKHWs; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62J5u5aQ1089269;
	Thu, 19 Mar 2026 08:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=wcez/An+/fo7yHKeglJBTG
	Hm/dOqTrEIFPfDZ08kx5s=; b=DiMxKHWso4dP+svrGLWgPI+WxL/REg45JaFebd
	+u54Jgl/nfNoJa9NEOWcrEzh9ySuilbxBXMFnVTfg3jKCUbMra0vo63F4TnFMVNz
	JDYUKQyZ6dLF82o56pxVahVwM1gU1+r7S2zwwaNZJ+rRkhUcmjfSGbDK1Ewe0i5n
	MrdjDEJpVbqyGaSWbG4HZcnLUQIFTT7YgSkTz7u1y8c/49eYtZC+Y8vP9VUaAsEZ
	fxkjGc8Bdrqy35dEzS9Yn1yvmXq598VMoZI1JgbrZikN3HPgIqWotWRfyBpZaz7d
	XGgyhlt7qIOmv1pMXrbGQb1xTxQPH/n+IS+B7L/RF/fJTWPQ==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4cw0yceua0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:17:46 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62J84G45020121;
	Thu, 19 Mar 2026 04:17:46 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.201])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 4cw30xbn4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 04:17:45 -0400 (EDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Mar 2026 01:17:45 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 19 Mar 2026 03:17:45 -0500
Received: from DM2PR0701CU001.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 19 Mar 2026 03:17:45 -0500
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by DM6PR17MB3818.namprd17.prod.outlook.com (2603:10b6:5:22c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Thu, 19 Mar
 2026 08:17:13 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55%2]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 08:17:13 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "Tottenham, Max" <mtottenh@akamai.com>,
        "Glasgall,
 Anna" <aglasgal@akamai.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
Thread-Topic: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
Thread-Index: AQHctt07v3rmA5GaA0m7mwuIUZ9nP7W0tq8AgADNGwA=
Date: Thu, 19 Mar 2026 08:17:13 +0000
Message-ID: <03A3369E-0F7B-4708-92B9-B335A6F86976@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
 <willemdebruijn.kernel.26b750d5f8926@gmail.com>
In-Reply-To: <willemdebruijn.kernel.26b750d5f8926@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|DM6PR17MB3818:EE_
x-ms-office365-filtering-correlation-id: 4f354a46-bf28-40d3-16ae-08de858fecb6
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|6049299003|4053099003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: wJFuzPcJyl2v50WxcPHom2d7i5veUsBmiRfDMrXNVmbPqt726uxTujogo9vTtwjqNvYY7XrejejB3YnXpIEc6CsNS/jHZfVn1YIYhxb76YtY9aagKDC+y0CVA0tXd9s0BHJYA9ri7RJR/MS7CbNylENjfQHeYf0ubPkUMdHlH8j4LRFUx575rYzXn1bv5j8cl9K2Dk2ehN2G9GRCkxq7DVVll3csP2NacUJ3vF5yYnVbBzktAAlgodr8lC6C2wDN++Cb4ukXaXOzSpmgezn2yNGl371oaqEAg9s9w0Kdo7JqvJ+zuGIEenw9QayLTz6e2fYT416V5T/bjA5EIqXKW4fN22IaakPw92oPw3mr3jZ2+NLy+U5vrnjYEVNpMbpO1X4Z+bIS697ZmB6UxG4+70NxFKdY+6tgusj9TMCn4tpucUJTx7OuWmbSS96VTLGQhN4HuuYIt6SKm/ijgrH62OGY2EMC9fgkP+xYWwBfS6Eo9NltCyKRO2LLv+oqP0aphDHo/IjxjlcszaQkXnbQ1s9iYx8+WeIgHh4paHYvmn6RP6dUAcZyqC1YrV6fYd0mLB5bL22GqilfqQqlWE6RSGQuS2i2/ENcKY/My80uJAwRdtKxQEln2ieO6P83HiZsGBurInXTdO22ZlsokLD0Ukn9R+0kPW2g7x/6Tgy1q+ReLlr0KxqbWpcHQBMsr7d7YAtpVHzwy9bUHTAG+gVN1cDq8TcZ7fh3VWzAjGeBRbuPYhhNPKzQu7YpJXz9VK12Gnqe7neklNnKO6/wCBkM52yeh+bLvJ57qrXLuU9xUQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(6049299003)(4053099003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H9dgIc0C48qNcqBO6Axx6BMSBcWLxty2fEZ/5wkzPwd4rQ7QVTo1cP2ql1+y?=
 =?us-ascii?Q?2h9jFHC1COupDC94e7bg5lpUaYt1CQavGxnD5FYgPDwSzFPtcx/PdDumVHmV?=
 =?us-ascii?Q?zh1T3l2/WUqogcJUktT8gY7XZT/cMhv5TjlkOUwxeClIjJOMMRQGvD/sIzeD?=
 =?us-ascii?Q?RcPtHzur0FaowPVuj9FcoiO8nP0pnhjw58C6unyinjISCykgLT0NCRk6kshX?=
 =?us-ascii?Q?yLtc3gRPgE1RymD9rbvAuFquvCYDxaQE9dWVx8NHzhYBpXSYLVPpPdbz2QKv?=
 =?us-ascii?Q?q4oG+SlnlYGaHtm/IpBlzUEq34cg/Xx06Ruxb00npNV6NmOd92KAH8qMgG0P?=
 =?us-ascii?Q?NtZsHj0UKs913d6PbURIgmdj857ZcVWi7L5Hjrl3vtjecLZkqsZCrC8nK87t?=
 =?us-ascii?Q?1xGbecyVXfdKshNK4fMok4rUoHNO0UThnORSdFgBOc0mAnsT061XN5eyPNi5?=
 =?us-ascii?Q?2778YAOa3sC8yswcyeBL0tSJsZp4zhxNmtZ0nWUH52pDNs5EEGZhQGIrn2e8?=
 =?us-ascii?Q?P+U2Sn8Q9hdj5Vz5quOxEFwxsBsSwh1GEfHxcaRtsWhjJt4nqpbHgLZwbOT+?=
 =?us-ascii?Q?tJB3ujIKxdvenyS6oNXaftNDDBfgs+TgIFSIecoZ4E5s4I5Chr+gxbXY6sRU?=
 =?us-ascii?Q?nuCaiKmQpcM7XsqMQa7N/zl4uH0QGkGJPvPd1w569IEXYRjmnD99ovZAjpLc?=
 =?us-ascii?Q?YChrXas5V1QwmOSm8ujBlboUGH2TpqiasUHFNaLsIKLn4y0ZZ4hDHNvmaxAb?=
 =?us-ascii?Q?V0EEyIPHBoAVNp8kFdjx+m8I+r6onKhZ6KRI54hnQAyks9pU9ClTs79IQ9c1?=
 =?us-ascii?Q?xxnjww5/rak9V3AYxwZuH3/nPsXkjQjT4oJ4915UJ2fss//vekVpsmV0fJ4Z?=
 =?us-ascii?Q?K3kELWvYTQxiEdABDBhCVgOH+C2SFMasPHA114wIRTX3nmZMLJGujyWmEjU/?=
 =?us-ascii?Q?L0PQxaYWeCUbOigM5MlPf5j5FysZ7BONsFDaMK2zrmme4QqQ5N6sGIZjXbZb?=
 =?us-ascii?Q?EoAI8ukubkKkL4olZbNxBzLLMi5NnCp3DOtUQT3sPh0XfHgFILeHLxVk7S0R?=
 =?us-ascii?Q?59BT8UkDvaGBL+sdBQ1LB04vn85jIFKTvKVFFst2bCnjoXlrzR808YWVJOod?=
 =?us-ascii?Q?KavG+QZPIqdAxZHCuYAPqJSVjMLeGloUJ3AMgNnETPBlot0BhjmHLKo+gS3I?=
 =?us-ascii?Q?fYebKX4pDHgQFvuMLMGD9NB2/DPnvlppOD02p//IHzy58gj346UlojuLTSbX?=
 =?us-ascii?Q?XK/BdbV0b/thqou7/iH9fJplIgAOXKb13Fx6Q75mdyG9OhzgnE43jFdj5By9?=
 =?us-ascii?Q?L/fGGAnu+4lNPTREtNQKS/9nZsx9C5ZWbVYP7LWpsr/WKokKCJS47wXcU5NG?=
 =?us-ascii?Q?+TEPOYG8mNQTTkb+XmTOiA1T27qJLXhDL23mvh4yTLuDl093H3dyfee+PvFA?=
 =?us-ascii?Q?sRElTNlnlQfLXr0sGo9PS1bZIkP8nsK2XLI3fHFhcVGkR8Cu5GJLQA7rSJSi?=
 =?us-ascii?Q?529A89fGTDiZHCDlYsERVA6wSC1dWOYoNi6Z8G4Uvhot4hHuHX+DUNNesTb3?=
 =?us-ascii?Q?QSvQ6M/8uzbzZeFpWl8DvTUeLSpVInqfT3HT5IDrcxYshnSXYueWYRO2HZol?=
 =?us-ascii?Q?YCgzJZvZ0JKs0Nd5KAkjJ6NZg/hJ7LJfujC/6DcHLCRwWByAusn9V3vHCpdv?=
 =?us-ascii?Q?WQ0qHw8Ku9XNy6Ei55Ooi/Ph9lk43I79sF6SxadTHIRxjm/OxOVfNS7XdMxg?=
 =?us-ascii?Q?xQkmbpOXMw=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT2ojpmeyE3wDXtjQL073wGAdTmPlIN71CVII19NhGZGMD/IZgtsIlH8xNE1fB5hy7rYLEW64A9hDVsg8o/OstNFOk4cquZ1yPPMpdL9Mxcvi0YC10vFljcKZWeRmfr8Uleap93lerZCNvkllHJs0Meo+rURiRgXe/4ZHfzX6uiZbao//lIpVefsKgI+f0OQn4reHm61skm2COPINcOsHkMLtCo4w5vBCaiywAhQrI/sshA9aU6F3/aPAWECFi1fYsLYTsC6tZckM9tdJ2zkQ9zqAjNxCtGMC8b3A1lmXUJzNSQfs97DVsFeTGhIMScovoxeuPhOWmBGaoqmBOcGQQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWR/4nCXe22Lmz4coo5Sr+Dz0c9tzWZTiyGyW3knvz0=;
 b=uhO8sFgnQmjvW9ALF/ffOlSaAxkswChx+f7qXzi6J7b8byBtar3FR97oZnkQ/3sKgZepKpsNdR31V59cssv0hynmZrF7M9iunSLwijVn/U0QNja22/MjcEypSq2MDVeLzE5W8NlItXtqbomBJSmZ8tqtxvnBmLMWGA3KsB1BewEit7E8WnBgebJa6nqA22kqbwFf60VnhCegrmH9AMAZPnEKkWu7Oo0553E3ZWGvWt4AdhcdlI1vt8jcE4HEwapFn3IMvWoSK3ylqy2s0LLCiwPlmnf2XrXS+nidCxzTWr0bkF38ZZ9b1HSX6ul74IHfYX2eMr/NwO1WLLwFPVUVwQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: b7B7xmao3irnsEIIhlA3RUmNCHmKC5Bnbi3bVpwaeJkiFYP3tYyEXyy9QmOygFaQBUJyMM9Y6pQIb3Z4G4kh/ZMAYHMrfyPBvpStaB8b8wH9lnqTkoAEZCpRpUSxbIc1rz69Wo28RVMeqQTRqwjONSOat3laGqa2QYwZSssJnqwt3USA/pVc6LrYiOoBSd9/tmWJ03IWlCyS9QpOp/MieVTcVM6aUxzzcsmFW5dFQgFp5dM5BjxOl5Nu1Kqp6X9wk6HqaR5ZznqGxCZT+bsjyoasWwGF7rVZlHHhUCnooJ9m34ozQOH1R+p7ds059Ewb6v3Lponnp8iggOxeMzpJzw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 4f354a46-bf28-40d3-16ae-08de858fecb6
x-ms-exchange-crosstenant-originalarrivaltime: 19 Mar 2026 08:17:13.0098 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: j1dBmKYV7ZWsvOLf/zB0Nl7JMiF7jQAR24yhsCdfrXDsct/X7z4fHYUnLCoXSa/4Fznvv6HLqzez/h7TqDdUSw==
x-ms-exchange-transport-crosstenantheadersstamped: DM6PR17MB3818
Content-Type: multipart/signed;
	boundary="Apple-Mail=_1F9CEBE0-5FD1-4948-8EB6-37EC7B2E14C6";
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
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603190063
X-Proofpoint-GUID: PvXOWPbPHXinZRmoUOYbRQcIOdRvz6_J
X-Authority-Analysis: v=2.4 cv=SMlykuvH c=1 sm=1 tr=0 ts=69bbb12c cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=8P__5Em-pwOPtXrf4HJ0:22
 a=pGLkceISAAAA:8 a=X7Ea-ya5AAAA:8 a=GDUu3hGwCwJtD1gqHboA:9 a=CjuIK1q_8ugA:10
 a=wqFnSJPP-FBafd8uH9cA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-ORIG-GUID: PvXOWPbPHXinZRmoUOYbRQcIOdRvz6_J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA2NSBTYWx0ZWRfX8VWDRPf+/hzq
 raMudOTqC3qUdYMgfKTayDRVKlMl8C+8o3UDe8AGCfWlzKunNfTsO1IXBWmENZLG7eoLNxQ9AYo
 vlqsJNWjLoMOAiZE0RBZ3F813GE23gCOdIdzN8cBrc6SNz/kUQ2HBeWrHoO7B2gNBSnx8X2Adyo
 RgXbhlyQjlztqQXf46SOYm+ms50nMc13Xql/OhcbBY0vIrPycdTniba42SWrbSKnNqG9eq66fdb
 ddVDAFbMAUveV5WZm2TSxIhn8IguOsERBIM0/YZ92qiRW70/xsI4q6tQFAPf7pS8OlU/zvPY/aV
 TykGqbXqTy8WEREevyyiZj/YY83X01ad6CD/rjFk8/QHzK511M5jZPLctbAPdyt9uL/o4CPGxDG
 AxFgZfKh4PrbAePRzqQg9QB3qwrHr13T+YDRJzy3DpcnVS9PyjvHDAowMJVpWzTrdNDBlgNNR/l
 eFszuGHkScGU65kXDpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603190065
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269353-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:dkim,akamai.com:email,akamai.com:mid]
X-Rspamd-Queue-Id: F3D232C7C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_1F9CEBE0-5FD1-4948-8EB6-37EC7B2E14C6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 18 Mar 2026, at 20:02, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Nick Hudson wrote:
>> Add checks to require shrink-only decap, reject conflicting decap =
flag
>> combinations, and verify removed length is sufficient for claimed =
header
>> decapsulation.
>>=20
>> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>> ---
>> net/core/filter.c | 47 =
+++++++++++++++++++++++++++++++++++++----------
>> 1 file changed, 37 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 7c2871b40fe4..47aec44a9cd3 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -56,6 +56,7 @@
>> #include <net/sock_reuseport.h>
>> #include <net/busy_poll.h>
>> #include <net/tcp.h>
>> +#include <net/gre.h>
>> #include <net/xfrm.h>
>> #include <net/udp.h>
>> #include <linux/bpf_trace.h>
>> @@ -3496,7 +3497,9 @@ static u32 bpf_skb_net_base_len(const struct =
sk_buff *skb)
>> BPF_F_ADJ_ROOM_ENCAP_L2( \
>>  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>>=20
>> -#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> +#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>>=20
>> #define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
>> BPF_F_ADJ_ROOM_ENCAP_MASK | \
>> @@ -3743,20 +3746,44 @@ BPF_CALL_4(bpf_skb_adjust_room, struct =
sk_buff *, skb, s32, len_diff,
>> return -ENOTSUPP;
>> }
>>=20
>> - if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
>> + u32 len_decap_min =3D 0;
>> +
>> if (!shrink)
>> return -EINVAL;
>>=20
>> - switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
>> - case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
>> + /* Reject mutually exclusive decap flag pairs. */
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) =3D=3D
>> +    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> + return -EINVAL;
>> +
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) =3D=3D
>> +    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
>> + return -EINVAL;
>> +
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) =3D=3D
>> +    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>> + return -EINVAL;
>> +
>> + /* Reject mutually exclusive decap tunnel type flags. */
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
>> +    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
>> + return -EINVAL;
>> +
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
>> + len_decap_min +=3D sizeof(struct udphdr);
>> +
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
>> + len_decap_min +=3D sizeof(struct gre_base_hdr);
>> +
>> + if (len_diff_abs < len_decap_min)
>> + return -EINVAL;
>=20
> Should this test come after the below IP flags?

Should it?

Seems to me it can bail early without having to check the IP flags. =
len_decap_min vs len_min.

What am I missing?

>=20
>> +
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
>> len_min =3D sizeof(struct iphdr);
>> - break;
>> - case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
>> +
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>> len_min =3D sizeof(struct ipv6hdr);
>> - break;
>> - default:
>> - return -EINVAL;
>> - }
>> }
>>=20
>> len_cur =3D skb->len - skb_network_offset(skb);
>> --=20
>> 2.34.1
>>=20
>=20
>=20


--Apple-Mail=_1F9CEBE0-5FD1-4948-8EB6-37EC7B2E14C6
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
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMzE5MDgxNzAw
WjAvBgkqhkiG9w0BCQQxIgQgj+CgOo8UYjOsZ7z3oVCv35+2hgma47L5AcJ0zIkjN7kwDQYJKoZI
hvcNAQELBQAEggEAJkLsoKyQfyA/qe7qfwtbpTIgDO4JBtgWpKMOHbojUeXK7sOlwx47z/NVp4cm
jBijWbf93QDNeI+v4pgnsCJoOnXkXdOIni+rZY+xa4KjKvKMJgJhiHDZuNPY357OsLsOLIK7ACLA
3RCycT5CmAccc3M2lFqa6YlKFmNbKnpW1ux3qboK89istel3ZYGiO/zGxXPUOJ8EqJu9Fb1SfuC5
PgiXOajN++0+rd+n6tzZZKSaQzla7cWUIbQLVpO4mrrqb/FtNp+TY0j51Ix400h9XctsoHC7VA+q
VwsY8YQwgXm+osBFL4psrxxi9nHHI3YHOVoDhrmxhOoPPzg4Iqv0eAAAAAAAAA==

--Apple-Mail=_1F9CEBE0-5FD1-4948-8EB6-37EC7B2E14C6--

