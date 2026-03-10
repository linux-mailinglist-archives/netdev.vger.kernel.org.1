Return-Path: <netdev+bounces-266239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA20Di9OsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:00:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C4F2552E9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFB8F304E765
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845F63C199F;
	Tue, 10 Mar 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="XnMAwpZq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB038AC65;
	Tue, 10 Mar 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160031; cv=fail; b=T47Pb5nzJnaYumMX6SeIQP0DVHoXFr5VHqHXoEGnLQ9skbTmDpaRZTKl+N0YVGo8tbaL+GCY8uVhSnwKbm1S830BwSGxrosRIwUK2l880UrhbAY5nsnOorApxOP+/KLglhD+tuCzLwWxtJmYekHvhRE91Zt5yB4ULXp/uwvWzIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160031; c=relaxed/simple;
	bh=/O6z0j/HsUBE2IA4zScpabr5BmmCH/0abwoonWcv1OA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVaK5f6G0ct2F4y9DdKcB0SCZswKXTZVBAHyY1XLHVeCsxNR5aqoA/O1lrm7ZJZCz9kwxHoO7hlyxRNtE3mlya92BgTkConxJuWSzqzZiKsyBMvAhea5QOcCU9r+HMql2YXKhUR4ZUa2bRZ5HVl+wW8ATkUc/f1TDSZab8r0kEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=XnMAwpZq; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62A9MWZ52064705;
	Tue, 10 Mar 2026 16:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=ClD9vv8//eOBDF6MhIzWX+
	blcwMCQJpqTuL5zZDMisU=; b=XnMAwpZqAkQKrM2BZDnNML7SDTEpDTuBqUGryG
	bUTFuXhcHa9Zkxzp3dzbYz/me1dOuk5ria62l0NQljPiz8XfRZRker4ovYp9DGnL
	6JGITVczILQBh+vZst727NCeTfMDGBNcDn584p1UW3AvaxeKrsReR2661iSnb/FZ
	yo8EOVFOUqa2aGSOaBOqc+L7JKzfNI86mzx89G89Wu50gg+TDdRbuZ2/XIUchfDO
	u9MnyMzeNDy2HjXrOo8gM16Qs2dxMedoc390sJJ5l2IPGuntnzY5X4rYZ8nhddtM
	9iCtwa+bJA+k6twVf4gZL5a4jMbP443wGok8yukgokNyei9Q==
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4crx7tch77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 16:26:13 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
	by prod-mail-ppoint4.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62AGIxsr022679;
	Tue, 10 Mar 2026 12:26:12 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.221])
	by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 4crg801sh7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 12:26:12 -0400 (EDT)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 10 Mar 2026 09:26:11 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 10 Mar 2026 09:26:11 -0700
Received: from SJ0PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 10 Mar 2026 11:26:11 -0500
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by DM4PR17MB6087.namprd17.prod.outlook.com (2603:10b6:8:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 16:26:08 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 16:26:07 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "Glasgall, Anna" <aglasgal@akamai.com>,
        "Tottenham, Max"
	<mtottenh@akamai.com>,
        "Hunt, Joshua" <johunt@akamai.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jason Xing <kerneljasonxing@gmail.com>,
        Willem de Bruijn
	<willemb@google.com>,
        Paul Chaignon <paul.chaignon@gmail.com>,
        "Mykyta
 Yatsenko" <yatsenko@meta.com>,
        Tao Chen <chen.dylane@linux.dev>,
        "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>,
        Anton Protopopov
	<a.s.protopopov@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] bpf: Add tunnel decapsulation and GSO state
 updates per new flags
Thread-Topic: [RFC PATCH 1/1] bpf: Add tunnel decapsulation and GSO state
 updates per new flags
Thread-Index: AQHcoY0hZ/LRms+hDEmNprgx5i7bw7WMFwyAgAbyIICAAI8qgIAUebWA
Date: Tue, 10 Mar 2026 16:26:07 +0000
Message-ID: <58BD9063-C619-45C4-AB60-CCA40E391A52@akamai.com>
References: <20260219104710.1490304-1-nhudson@akamai.com>
 <20260219104710.1490304-2-nhudson@akamai.com>
 <willemdebruijn.kernel.5766d0a10c73@gmail.com>
 <7C8018C7-B0E2-435F-B155-60F29BCF5018@akamai.com>
 <willemdebruijn.kernel.7c6e5a81afba@gmail.com>
In-Reply-To: <willemdebruijn.kernel.7c6e5a81afba@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|DM4PR17MB6087:EE_
x-ms-office365-filtering-correlation-id: a99d62cf-9a5b-453c-fe28-08de7ec1bbc7
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|6049299003|7416014|1800799024|18002099003|56012099003|22082099003|4053099003|38070700021;
x-microsoft-antispam-message-info: 9CYLspH4m9Bh7lsIsniMc/X4CiVAtlfIgPCrQadiaopkkiEmDDPHyMS/tUnwKPy5v3ZdbsNWUlYYdr2aiOq3AKMvuvaOFU0LLml739Hp4syb5cgtnModTPBr5mbz3yvSu8nbe6wEBxqVb9tegUeSz81ZZvXR2XjqwSH2Tdt1i0kc5uPn3iBk5IZZnOWdyXXMh/vINJcuq95qoASON6vnT1sZ39cNfkaQ5lXaN+OQGKpL26fKs2J7tXzYkYL/Xz6hE7wgb0OPqAjZH31AMc+prTgTASv5RSW7TylB3ShKG7CsUG9JoDH8mtoKJil/3ZuUN7lW1T4mJOD3GdeGrOuJhpSgu2W94cenMrJCBve/In6tzewg9nDW5wcSW2Z2qREYY0sMmjsptpDQ7mzsrHe3GVz+ExmNRUMANUC9RZMi/6G7ej2OaGLO2l8Eqd/pZXF54hj4ynK6AeXqX58IT9ATGv/axjblzjeSg8vrBahKu/XM/BkX94Bn0fzLRlBQ0Q3b7Q07724Kj7TqPs+B4U2CWlDpwjlOfVptWVEDdicPy1dGIBsfjOoEW6GB7mf6ZtXKyzVRnj+bBMYyOUj+ypDDs/zLHwj6RVfiOIV/YTCru4nDfLRg38wvUAoDIJ+eA6O1bmVCHHmgOfdDOdnwFcocANcCDOE2CWrikgTeUoB2iBEe6uCZw0HXBZii08HA6y48VUMCE16tCVj4pxs01DiSQo0siTsWpgBvtzzUAKEdNg9cTIJ8j4U5Sl+m38MLUqNh36a0vpAZvpXzigDAsjXh/8NZhLM3bgSxkbsvSZdNxdk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(6049299003)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDJZU2Joc29HZ1VvTTNEcXc4dVM0RVBPN1J5MWhCZE4yeG9McWRBUzI0Zy96?=
 =?utf-8?B?YktITjdxTTh0Ti9mT0ZybVZ3UUk5UE12L1B1bklLWWdXL3UrcmdqcC9yTlJG?=
 =?utf-8?B?TVZ1c0k1Ly9qL2lvWGF3Wko2aDRLOFR2ckswTWFHS08rMlVoUHovWTVLa1Zj?=
 =?utf-8?B?UXhSa0ZCQ0ZaNXhyaWk3YW9CMStKK0svNEJ0K3VlcUw2RU9EZnQ1THF0Wktp?=
 =?utf-8?B?S3VpOFVzcUdLRDVPRnYweWs0aFZlS3d2VWtuZklmWVhwMnl3ZktKSnl6UzNE?=
 =?utf-8?B?dWtkcVF6SUM0SEMrWUl6WDAzQ3VZQWlrakdycGQrK0pDbmFUV0NpNjBUTWoz?=
 =?utf-8?B?RHJBemtOYzR4SDRVTHVrbk9GdXl5NDY3SkVXZjA3OEcydkFrMklQem52L0M3?=
 =?utf-8?B?VUNMQ1pOWFFQZ1JLY3lzWmlMQkNWZ0FjeVg3NURscVpjMU43ajFrOGJRTHUx?=
 =?utf-8?B?c1Z3cHBjdll3ZnF2L0ZjUnB6UmRubVNkM2oveHVYanRITW8xSXBXUURkZFI5?=
 =?utf-8?B?NlJJMmNCWXAxMStRL1RpWlJLRnFSUDdxemh1MHNtWEN2V0k5N3pWaGZPYVdJ?=
 =?utf-8?B?UU9mSEZvZmNUanNCR0t6VmxUamIvd1QxL0xuc1ZMR2gxdS9Icmgvb21Ma1ZS?=
 =?utf-8?B?L1hhd1hjcllrZ3JieGt5QllHbjRXYUorVlBVZTRnUE5qM1JCbUVEa2FtVi9C?=
 =?utf-8?B?c2J5dmRZbHJ6Y0l5M1Q1LytNWm50YzFQd2RTZHBQL3ovZVpJa3U3ajFQblpV?=
 =?utf-8?B?TjR4eXo3OGxENmptNjZTRmxKOExlOWF5akZHRUY1NEVEa3dDdjNhNU9mSmc2?=
 =?utf-8?B?WXJVVnpqc2EwOVlwNUsrckQvZEdhQ2dsSENBRWZMaWVtNkVvWXZmNFBwb2hl?=
 =?utf-8?B?bk0wNFlOdmlxWE1YY0VhNTlkTEp6KzhtZW5QZzdXZlhpS2VJQ0lZakx0YmJ0?=
 =?utf-8?B?L0JCY3VFMmZxcTBSUys3eUM4VkZoVG8zWGhsNjl2eTBhTUs2bFF1Z1Z2Ry9o?=
 =?utf-8?B?LzgzOTNRQWg0T2pyZmZQS3RyR25kaWs1YXZtUllLUC96c3FTVVl6eVEzbktC?=
 =?utf-8?B?d2w0Q0xYQ3RvbzhZbmRQNmd1Wml3RWI2eExUZ0lBd2RvTTAzV2kycFluNlNl?=
 =?utf-8?B?U3Q2YlBIYTcva3FrSzVOMnhYWGkyajl3TXhnellabzdXV3FXbEdQelFqemZn?=
 =?utf-8?B?MklLRlRGbnc1eDBBRXM5ekc2cGx5RWtqR09uc0F6NkVQMkJYd2hqMFkxTTR2?=
 =?utf-8?B?ejhvYW53c2FXdXdZSDhPeVg4QVF1ZThzQkhTWmZFYlFMRFJKajl4TjROaklx?=
 =?utf-8?B?anU4dFJLZG9RTlZWckVUMC8xZmxvTFBoa0FHQnFpWDZWZDVlTmVlRU9xTjFL?=
 =?utf-8?B?UnFTbVhVWkVjOFVsMVlpcVVoMjNRTE1VaXZBTGVFQUlESExyWWo3Ny9KTFJk?=
 =?utf-8?B?dElXbUsxTXhzVjJsVUhIN20vQmcwRnpGYjAweU5GYnpuaUV5TE1Pc2htY0VK?=
 =?utf-8?B?Z1V3WTEvakpyMjVNbGVET2FJRlB0akhQVmN3d0ZYWGVFbVdjZG8vYndpOVhv?=
 =?utf-8?B?UXJZQlg5RXllajBJS1NQQkZ6OUNDZ2hPd21wQUI3NENhQVpVUVh6TXNtaUYw?=
 =?utf-8?B?NmtOakZsQUtHYkgyMEZPZEJNL2lhSU1LUE4zaW1uK1VVTzUzdzhEVDlIM0My?=
 =?utf-8?B?Q1NBL0gyMkhBMUhIZ3pvY3Vmc0lmOU9pcThGV2xnbGMvRXVYTW9KQVkxTHBP?=
 =?utf-8?B?UlZ2bWVVcTFtVmJwTkcwK1VtYkNBSEZDOWpGUEttLytOa0NVYlB5MkVGWC9M?=
 =?utf-8?B?eUo3UnhSak40UUZDUVZKY2VTTTQ2c2ROb0Q0MDVWbG54OGF1TDhXdmpJOXRM?=
 =?utf-8?B?UjRjMVVqWUVKNXZTQUhLMTRVR3N4OTduVjZONWEvMEM2RkNHbUlQU29LSGov?=
 =?utf-8?B?RWVmcjNQTWxjdW1WUnFHdWxMQ0dKS1RYR1ZIWHoxUEIxVEZFSG9IcUtIZW1r?=
 =?utf-8?B?Q3NjanJQZU1ZZktIUldXYWZlR1hXVDRtSFRTNGVjTU10Q29sZmZ5TjRrenVO?=
 =?utf-8?B?VkEzQWZXZVZvSkt4VFdVNDV1Mk90TzBZaTZzbTBZaXlZR2ttU0E4dXRnM1J3?=
 =?utf-8?B?ZllDQVh1Mk9KQmhTdkViRDlHTFprcjRLOUo5cWJhaDgyYU9iMXNPNDRuVnBV?=
 =?utf-8?B?TG44eFFucVJnVUNlUTdiTCszRlR5RTZOYzRTYzZVS1ZnbjlOdW5sU3cvTjJm?=
 =?utf-8?B?MERwMGJlRzZmYjhGaXBrZXBaaWVLd3ZtMjhuQW11eEo0Mnl0WS8yK0dXK2p2?=
 =?utf-8?B?cU9sQXdOUWVneU1lL2gvZVV2d1dCN2tCSndOOHVydEh5RkVLVDNUcXZyZnJJ?=
 =?utf-8?Q?meMmPYxlIrb9d+40GslMepZtjsLxqKL1DPfNMvl4G414Z?=
x-ms-exchange-antispam-messagedata-1: C983y8VSM7be/A==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKesfXSUGk3N393LMoHW3Ikee/yqj1ox9Eavr9PAAf5s4zjtQK31/okZv1aC74SleNVjofgCZXuCJay4EmRhkvqc0qemNJOn/53QSue3wvroXPPUp/n1ejMr1m4MdJcNin9IRQQ34nYAlauTd+eFiq5vqwYsuZxGz8oxiHVqwR4ZfVN/1E0h5rzhcjYenv2Nsk34JdKrW60t1yDE0yRNGDRUpwo+uuIox3I7D0S0EoM2d2iQUSFyiFR+9C4kSBT7xWBEeZ//1JSwSfR3YbtDUhvLyfJlrEncnq6I28y9g8ZcONQXWz0Fdx+mw0lL82Y4BzjGzhfviY4lG9sVa4ADhQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/Jg/+osaDUOCmYn5yBYF2ACT19uceRN42Fj13I0ebk=;
 b=JOhsjfsB2Z1Wmc4u6PM54rNTLNWKmeBMt+iE3MsXhfFhhxA/7hyhCjxl5Er1Jkz4kTMAoP4d3bcxkvlTiE2EPN3noQrw5QeJ8631Vjw4p+GtciSwGYvmba6BEc25Yl/sxdpwnrDXGpxtlejmevyNdza7aHUy+4S043eVGkd236JdIyuPiWFMVOCZ7ArAG9d0P9pD7oLQIwZAm2lMWinzLRjKTMDs91SaCwH+bfq5xZZBXUiz3lSZbLl2B07O3hobdVEOEByooKuA8XH0WLMI6CgzVtbDlCZkw59NfO5tDHknLMGUKTr8bIBvzOVF4gi1jOhRcKh4FtaMo3xepob8Qw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: r9d1pZ3laFn+iFhn4VYnmf1lpAth7ylFaMKlar5W7ku8C1mNO/7iJL1w4G72ZrDqtWtNaYIfpMaL4icom9jbpScibSkGHgv55TTnAfHDnBHhdfQjT/AQsk2jQtTd/uXGDk/2Tn5CNCMdBtzxC0stznI9rLLvdkeQuH9PfZ4oaTa7FVgNk2WIoEtxUKB0YZjiIjHzEX0zCrRPB43NtVixp3JQDez7+UF6WVbjR1n2DA+lmpKsAsOWFVGc1IoYE2AE1l/wsDvwFWpOGDhcyIhLWkteHfmBwG1DN12IDNv2WbmYQsC1rlsKqm47SFCIcoZT9ehTtx9dIacEAaEAeo2WGQ==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: a99d62cf-9a5b-453c-fe28-08de7ec1bbc7
x-ms-exchange-crosstenant-originalarrivaltime: 10 Mar 2026 16:26:07.7217 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: jpSRlXCGwr9+ODpAnNR1idZEkAKnyqv4kpZAeCtKU4oJz4Q0WpCPGp89AjzX9ognYhAA7HobFXSqtESVW5pIpg==
x-ms-exchange-transport-crosstenantheadersstamped: DM4PR17MB6087
Content-Type: multipart/signed;
	boundary="Apple-Mail=_7C5D9BDB-04E1-4212-8E7E-B05A8E9440AE";
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
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2602130000 definitions=main-2603100141
X-Authority-Analysis: v=2.4 cv=KJ1XzVFo c=1 sm=1 tr=0 ts=69b04626 cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=TTBIr9FR-UdC54aaq7Eb:22
 a=pGLkceISAAAA:8 a=GIb3RfCIgReAMcZLj84A:9 a=QEXdDO2ut3YA:10
 a=wqFnSJPP-FBafd8uH9cA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-GUID: QL9pJIR58QZg39tnZlDAtlrGdv664VpZ
X-Proofpoint-ORIG-GUID: QL9pJIR58QZg39tnZlDAtlrGdv664VpZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE0MiBTYWx0ZWRfXzDlCFHE39BwF
 HEoC/8E0cgj37TGW1wCs3vU1gV3ocEx/wtAneAuOPdjLND48svx2QWZR7fBe0+TEM+wW3EcXM3J
 qaF2ZgoQWBJBcu/QeASQ1iyYYcHW/ToibomtwRmKK4LxtFIpHInID3BKblTop0FKewsmlkjN+6U
 GzME98+AOsnD8Zqg3E0AINepN+VirnvoHxzeYuly0D9yme54O/u/cEYSpw73xk67WjLCS59YBse
 I90E7sRksZQwymLdbw2LMjQPDKzIfMgy3Sha1Klbt2Wlazf9Vfg3kOuaaRV2P77rFWygfl9txwJ
 DM+0gut0f5AY/Qm+a/jaH7e0xqPhyR3vzZcHFmGuWrm4FSwwWcFopiG6b2kBwoTKzp36f5Qj0ph
 hEA2i+S+zoC2I+XTJ/Z2NxFJZxQ7UFtiBqwYSalJuzOER0V/ADEZdFgQn2SQJZ18zaZOUfNTIxS
 19wCI0yR0/eXNxfkVRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603100142
X-Rspamd-Queue-Id: 67C4F2552E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266239-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,meta.com,distanz.ch,vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

--Apple-Mail=_7C5D9BDB-04E1-4212-8E7E-B05A8E9440AE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 25 Feb 2026, at 15:45, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Hudson, Nick wrote:
>>=20
>>=20
>>> On 20 Feb 2026, at 21:08, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>>>=20
>>> =
!-------------------------------------------------------------------|
>>> This Message Is =46rom an External Sender
>>> This message came from outside your organization.
>>> =
|-------------------------------------------------------------------!
>>>=20
>>> Nick Hudson wrote:
>>>> Enable BPF programs to properly handle GSO state when decapsulating
>>>> tunneled packets by adding selective GSO flag clearing and a =
trusted
>>>> mode for GSO handling.
>>>>=20
>>>> New decapsulation flags:
>>>>=20
>>>> - BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
>>>> (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
>>>> - BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
>>>> (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
>>>> - BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
>>>> IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
>>>> - BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
>>>> IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
>>>> - BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
>>>> SKB_GSO_DODGY when the BPF program is trusted and modifications
>>>> are known to be valid
>>>>=20
>>>> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
>>>> renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
>>>> Run Everywhere) lookups in BPF programs.
>>>>=20
>>>> By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
>>>> gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses =
this
>>>> for trusted programs that guarantee GSO correctness.
>>>>=20
>>>> Usage example (decapsulating UDP tunnel with IPv4 inner packet):
>>>> bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
>>>>                     BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
>>>>                     BPF_F_ADJ_ROOM_DECAP_L4_UDP);
>>>=20
>>> This patch is doing to much in one patch.
>>=20
>> Sure, I=E2=80=99ll split it up.
>>=20
>>>=20
>>> Also not convinced of the need for the NO_DODGY flag.
>>=20
>> The reason for NO_DODGY is that, without it, the egress interface =
will see the
>> SKB_GSO_DODGY flag. In our use case, we want to avoid marking the =
egress tap as
>> NETIF_F_GSO_ROBUST, so the skb will fail skb_gso_ok() with =
SKB_GSO_DODGY set.
>> When skb_gso_ok() fails, validate_xmit_skb() calls skb_gso_segment().
>=20
> I understand why you might want it. But the dodgy check has long been
> there for a reason: becauses these transformations are not blindly
> accepted by the kernel. This use case does not change that.

The defence I came up with here is...

    - setting NETIF_F_GSO_ROBUST for the tun/tap device, as it is a =
device level property, affects both host to guest and guest to host. the =
former is trusted. the latter is not. therefore this is not an option.
    - the host to guest direction is fully trusted
        - Physical NIC driver is trusted (kernel driver, =
hardware-validated GSO)
        - BPF program is trusted (privileged, CAP_BPF, verified by =
kernel)
        - Decapsulation is trusted operation for BPF code authors
        - Bridge + TAP is internal kernel forwarding

Would protecting its use with a sysctl make it acceptable? (If it =
isn=E2=80=99t still)



--Apple-Mail=_7C5D9BDB-04E1-4212-8E7E-B05A8E9440AE
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
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMzEwMTYyNTU3
WjAvBgkqhkiG9w0BCQQxIgQgqvCLlu7L7/Wh11k/aGmy9M/fKAxWTrov6J2B3Y005oEwDQYJKoZI
hvcNAQELBQAEggEAv0u/q/NJPIctZe7gd7GR5msF6R7aB11iuLIq7Z65ZCftgXUo4EH400rDg0rC
TRD5jlvFpnTVc0L3lhzE9MJPLntBDYH1OWFb8JK48fr5Pu6bysr0vHeqdOfZiWXBxXiAnQV7aBZP
Is/R9VXeGHa1LkUUevBwvZTZR6Z7r/ITjSOPMo0gIrgO+8rY6lMSvtxfUM5hA2JweZNJhdM3TsH9
FOdnTRyyFdEziJPGcwQstLbKun3drFlrKCSgcUM8+Byq7cF6emmck3LxzKEvl30UKqxlYBETCLZ/
vmdPI0FY1vxQ0JaZ7we4T+vEHLAewXtXjQI1V2EBEjlDq0sx554bMwAAAAAAAA==

--Apple-Mail=_7C5D9BDB-04E1-4212-8E7E-B05A8E9440AE--

