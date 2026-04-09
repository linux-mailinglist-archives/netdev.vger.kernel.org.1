Return-Path: <netdev+bounces-276900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIDKNyJs12myNggAu9opvQ
	(envelope-from <netdev+bounces-276900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:06:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4C93C8306
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DEEE3057629
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0F3A875D;
	Thu,  9 Apr 2026 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="jrqYdpWG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCA3A874F;
	Thu,  9 Apr 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725451; cv=fail; b=rQCrf4tKuFRuelY5FriChO5d0oOS9sQjcMpgvn6XHJ1txKlcE4tv9913I/pjblhwIRte8HPc7k4dq1G65F6oRvrovkwwzbhbD3dOsPmRfW6k/boTBwN5gFkRWfgw/3Wxxl/Xx1TztKsS2ChWeHBls4qvbOfzSMlEF4365xJiClk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725451; c=relaxed/simple;
	bh=5vpFD6u7cPVNmI7jNgOBzrJb5C2Kda7XHWuJtblRnG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJw99htrJOCF7tm5Axe9Y77MriYGqQ852qSujDPmCOCcQfw0cpD8Jre3En2h0Nica+fGnSz3tI3KfsaUzNjn6Nm4WA1192ryEh6zde2t3nHs/AmIO+yhYJ6CCCmam4YDLMqromkvgVfBWiS+tvCmkl6exv55XmLxAGGG9UReewo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=jrqYdpWG; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 6394netO1881292;
	Thu, 9 Apr 2026 10:03:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=9aMyVzBYUhjLttyiBPrGPv
	86ONXGZu3nVcbnsUGkzrI=; b=jrqYdpWGIMcwcybK6qfb5kezrakp5fwUe27YfG
	S1+cAVYfNnZ4FytlJAkEi1LC24aDxCCbOwnYnISrXjedVRW/wrztzXHzybqwnlRA
	uDUeT7hRFI29ecbJRnMgCkYjptLzC8bAIfma7LAnuazTB/iRcBTLgvgwohQROTMb
	VgSJ0t1en6GpmzqM3TwPlLKVoxblNNsyWnpPwAYp2CtX/EedQ1GNePgiWb1+zABW
	nhcA4r6JBpWkdIGZPwAENYMTb66QNmrSzd82cTmDT8gP/LUvAMZFbyzIWS8mFD8z
	GUgFcX+39/eapgFhqgDbgtVeGLgnlw/ityM8ne671BsGM+3Q==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 4ddy1e5631-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 10:03:24 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 6398oXKM027488;
	Thu, 9 Apr 2026 05:03:23 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4dcmekd5gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 05:03:23 -0400 (EDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 02:03:23 -0700
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Apr 2026 04:03:22 -0500
Received: from CO1PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Apr 2026 02:03:22 -0700
Received: from IA1PR17MB6075.namprd17.prod.outlook.com (2603:10b6:208:3ad::12)
 by SA3PR17MB6779.namprd17.prod.outlook.com (2603:10b6:806:2fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 09:03:19 +0000
Received: from IA1PR17MB6075.namprd17.prod.outlook.com
 ([fe80::51e3:f458:da2a:4433]) by IA1PR17MB6075.namprd17.prod.outlook.com
 ([fe80::51e3:f458:da2a:4433%6]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 09:03:19 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        "Martin
 KaFai Lau" <martin.lau@linux.dev>,
        "Tottenham, Max" <mtottenh@akamai.com>,
        "Glasgall, Anna" <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi
	<memxor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Thread-Topic: [PATCH bpf-next v3 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Thread-Index: AQHcxnxaNRaXz2tQb0WkQbmybTOBNbXVRq6AgAErtwA=
Date: Thu, 9 Apr 2026 09:03:19 +0000
Message-ID: <C160C986-057B-470F-9490-0B06C844B1B8@akamai.com>
References: <20260407105005.1639815-1-nhudson@akamai.com>
 <20260407105005.1639815-6-nhudson@akamai.com>
 <willemdebruijn.kernel.245c592e6d270@gmail.com>
In-Reply-To: <willemdebruijn.kernel.245c592e6d270@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR17MB6075:EE_|SA3PR17MB6779:EE_
x-ms-office365-filtering-correlation-id: 25d9213d-81b0-41b6-837c-08de9616d84d
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|6049299003|376014|7416014|10070799003|4053099003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: wPsUHbdc7P/GKazEG+JGmLFx9w4+0SjfeAk3Tc49mXc02dp0brR2qKjyhNKz//7NCDNbVY6fQ7FqfFZpAu8/Z9IexINBkcX8JGIcCYQdupq9osh7uSnl9mgqLcwxBfuyeKoYNmMxB/RadVYo77LcM6+oykQMqOmXB2976zcwfWjV6ly86q6jeNz8F2uuCRZE46Vt+2APeYSaIfckP5ZYqn5kIaNctpkD7068ZwLyYp4hWZdgxqcKzm46tX1zVoZGL/ADUIXk/RQ0zZo61TU/T2XvzsJfDlZAEI6SvCj3VtRusz87NcYizmlLvLS9l42/lLG6+l6q4jzLtJGrN9cDfHCZu0WqcTKZVT7u+asE3KMevnmZxbo1Wv4eAKhVCj6Hqy+xO52M4jFIbPf796rZv4iVh9eswBbXWwYXytWhwFUyuRbFLAh1xpMWi/icYNjdz6WQN9uvxm1T66ATwEx1TwhO0dKLKXW3azvW5DGdWR9QkrXXO8DAP5vUN4M0FC3kgeO9H+YMRTo3Ee3d33sckeLVNYeAEuNPaYqtsc1a8QK3VK/lLSMDALwhhPxz+N78UebywPvI0VcF51pE4/aAlDoEGhm+wP0Ws/D2vOd1aKkvrNGmX/WB8emM6LBwJQwJ2DvZyXkHhIkurBIdk4rBcezAH6KS3PB1jX4RbwxmF7+HeA2WZfSXo5iq3J17DBvU2xD2uEAdxobLwQAvS4/ZDK9t3xBAaobB/DRcIbFkHYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR17MB6075.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(6049299003)(376014)(7416014)(10070799003)(4053099003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlRQT04xaW5hTGNnYitvZlZLcnJJaUs2cE8zSlJwVXNGSzFmbzY2Tjh1SkU3?=
 =?utf-8?B?SkxqYytjdVNDYmtmNzJWVTZBUlpNdWQzKzdOd2RnMEdvektJZ05VQ1VBQk44?=
 =?utf-8?B?SmRlQWtndHdpQjJmMjBCRUJGWHNRTWNXK3N1Q1RkYWt1a09hYmhCMjFkc3Z5?=
 =?utf-8?B?R0xYR25jY3RWMitFK0t6eGt4UjcvdTZwQ0o2eTlNTDRlUjlFZHBqVk9KUGpW?=
 =?utf-8?B?YmdBeFFvNndLZklJRnBFdGVyUXcycVNRREk0dS9IbjRDQkpDT0MwZ3pXY2dG?=
 =?utf-8?B?N0xvd3hqenJpcy9DTHl6NHk5cXpUN3pjczFTWS9VdTVIMi9JeTUwVFc5UjFC?=
 =?utf-8?B?ZzlHYlNFU3FrMlVXN2k2TFZORWR2QVhQeG9MVGJ0Q2JleHNPOUNPRWxNTzRF?=
 =?utf-8?B?bmJkQThOdGNCZVRKK0xvV1lRTkVXVzE5bWJyL3d2SHo1RHNFUE51djNKcUxt?=
 =?utf-8?B?dUhyS1ZyVXlXdTBYWEFOdU1URnBMRUxqSVlzdkZ2YWtHSmxhdkxhakczWnRF?=
 =?utf-8?B?a3lIQ1dxMXllL0lXRmRVK1hDdFAxS2xhT1owTU55Z0VHUHgxRkY0WXdIc2pZ?=
 =?utf-8?B?d0hsSzRoMndWcUxtYjNFVURqZ1Y5bHJoSUMrWkwwMGc4RDBNZlkzazhTMGpO?=
 =?utf-8?B?b2tENlRzQi8wS0t4VmQwVjlFRDdQQmh1VFg2TGtENm5qcy9EK0FwamxzWEN4?=
 =?utf-8?B?M0VwTE0rZzB1OG80ZkdiRCtIRzlmM0JkRFdYa1pjSldkaE9HZXRST1oveW5h?=
 =?utf-8?B?a0JSdE0ycmF3My9MSkZiTlk4OXZhR1l2SVNTenFyRTlxUmV0TmloeFFiQ3o4?=
 =?utf-8?B?YUUxdXo2VkswWlNZeUphMW43N2VlK3hJUmxqdW90Nno2cENmTkxzc3owcmZJ?=
 =?utf-8?B?Ui9oTGNlSVdvVUZ3R3o2TTlPZVlENU9MQ1R2NkJ4T2QxVTlBdElrWEJOOTJT?=
 =?utf-8?B?UzRha21IZXVjckt6SWt3OHFySXdzc1RqUGs1bFdjVTU0UGx0RnVZcGg2S2wz?=
 =?utf-8?B?TkhMZ3UwL2R1TElCbThNVlBoa1NGQnEvVlo0Vys4cloyUDlBdnBmdDlYQ3Fh?=
 =?utf-8?B?MHhyaXRNdWFNTmNCbEpaSHkvcFZNQWhUZXFqRHA1eTIvQWsyY0dNMEoxQ0Fk?=
 =?utf-8?B?TEVqUGVvYmJCaERQZHl1d3gzVjZNKy9TY3ZCbzFYb1BHQnFaUWJOcWFtOUwv?=
 =?utf-8?B?c1NYM1kvR0szbTZpQTFDOUhRZ3hVZzNHbHZaOW1VbEpoRnc3dW1EVXYzSDQx?=
 =?utf-8?B?RkltRm1OcHFCT2N4OGxwbkdlZytpdEE1SGVyRlAvdEs5N3o3M3FZRmh1R2wz?=
 =?utf-8?B?N1dBcWdBNWdIZWJTQjFScDIzbXI1U1k0d1REWlo5MDcwRkEzZ0N2Y2RPOHY3?=
 =?utf-8?B?a3BSOSsyejBmdGZGS0NJQVRDdGQ2eU5aMDVndm0vQlpEN2pYdUE5SWtidDV1?=
 =?utf-8?B?dUVFRzZreGxMZVBJUjd5dG53SHE4enhPcEFxS3FoZUtRWk1lQ2xMRFI2Smho?=
 =?utf-8?B?MHgwd2VpNWFSWlJuQXBjV1dxb1dFUTRsbm9BQUlqYm40OFBFUDdaRlp2VnFw?=
 =?utf-8?B?VS9HelJ1ZVdaUTN3VEUvYlZtYTN0WkxMbTdhbVlrR0F6bi9BZWpablptOUFS?=
 =?utf-8?B?QnFxRENUQ1NWa2pYcHEwZURsZEt2dkN5TG8vZUZxR0tIWldhU2tXUHkxRDBo?=
 =?utf-8?B?RTlTOGo1MFVBSGRWaG9LYTZOTWtGWU43NzdSemVvd2JNb2p2c2d6NWw1a2J3?=
 =?utf-8?B?eCsrbFNoV3k3eHNJVVc1OVh1VW5acWJvaXBLZVlNbXpsVFhtU1pCbVQ5TXNr?=
 =?utf-8?B?V0R3VEhqbFR5MWt0QWc3OXFzV2ZDSlBRTHI3ODU2RkRHRlhBVWdEWTBJaFor?=
 =?utf-8?B?TUZPckhsRnU4Nlh2RldVNENuWVhENmFZdmtXUWRGeGtZelB3Qjh2d0djWDNh?=
 =?utf-8?B?citVMFJnQ2lLZjdxNitRaG4vbE5ma3J5Y0ZhUm9iTjhHQXF4Y3NabDBXSytZ?=
 =?utf-8?B?UGZPVXdWRktoc05RS1FDcEFrZGUvRXlIU1AxT3JLZ0VkN0liM2RnZHZwZ3Fw?=
 =?utf-8?B?UXNaemYzaDcxcUdQR0pPcm55eUZaOGNkQVJHYkhpSXJ2Qm5Ock1iWWRqUytl?=
 =?utf-8?B?Q0tNeXpnZ2ZMR0trVk9xQXBpYytUcHgwUFFoOTZBWmJURU9jNVh5S21NWHBU?=
 =?utf-8?B?WDh3ZWN5a01adG1tbnBadloxS0svNGQwd05zMmVadG1HaVF1UnFmMVJqajhX?=
 =?utf-8?B?K1V2M2pzS1R4T29PTjZuaUVER05ZZmQzbVlVNDczQ1JtVTl6NlgyaTlKZndE?=
 =?utf-8?B?UWJmMXk5MEF3eFF0N01LTndhcFlLbWxoZUZqZUVnTXB6azh6L1RLaktRU2V4?=
 =?utf-8?Q?gR8OcbXkqW0u8v6fEgWE6OaEQVGJx7p1KpQbRvtsKaxJd?=
x-ms-exchange-antispam-messagedata-1: KbYzzw51QkawKw==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLZUtx/qqG6XkokIed273yfgihukxmobqJXbQy0JffXkls0c0t+5HSJoMiD4wKmr3I7pyJLXmhU1SLsRKsG2sFVaj8Yq+ZHl1jB96jna52qinNQY0z4pKdTICOWH181WM/nUlYWiSy4nNg1ClXPOBH6DBNcyU1+hcv7VDuj1k46fiZNqu8EKxk+2Xq9ty0ABBoDcgF9BJncZtsjFrkzw9lzUlH0DWsaCbO0BpO/59fmN2FmwjTNDHkIyCQNn3taJl2hGf/HJ0aWmCtXFEHI41G4tOJR9nAkvBC0M3ryC7veUe4D6r7ZYhuJR+S3CINpoGg3he+q/t0yt4gYKafeKVw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTaBCdoApF9TBxBTuKqwU9NWkZ86OA2jmQgVLwjqSaU=;
 b=sZQF4tfFzpHlnZozZcKGsubFnY4250eI8ArGuHKB90Am60c/JNM/RYKcZuAd8NUK6HYo9X5Mn0tpke2NfsLsGbgRRhbbpCmTqu70SNAclMNO/hT/mT5sAuPc5Tk0ylKhCNaFfB192YVnAinDChbg/KVCK69zxQuJjKIqvow76fozm6To1vlXkpiAKVFfN2F1CcxbT6TE+XLiP3P60Dm1p6Ecus709rtFDgNSlFixtF75lrba3ycVhpKRBgTqj1CU4M3T9MEl3Qdtmt+d+85wvnpUD1Xj0S/IFsDKIBTKmO1BiVaXuRybfTQt5cxOs/38GFQ9TyksmKUtfUC6W8yqPw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: ZEBCQguRVJXlvp6g6T57dzxksITB1cG8vKn4cgZUcPPxCmNG01fiOMtQM4leWyIwwWpP+ma9OP8pJYyJzAVEqA4wkAZ1AEVQmLw1baHKtgn5lvnvfZR8HfJQ0224eMvDCM1P4T3X30z8D1nhcLbSU5+4jldCa0c4VqZEkHbtcb6DZyHn8nfbu/k91JeD9cRha8lTpZMxmn7ph0/gKtFGr3nMWoYa4Qb1TkAGgSL/YFVbd5EFoofIVR2rmtr8X4fmnK9CXvyDat+2yI8VP2kT9D/1LUXDftL6G3brjkjfCM+9ptGILmPxfTccvmjsAHS8LC5Ph9B51eMa/Bgasvv1YA==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: IA1PR17MB6075.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 25d9213d-81b0-41b6-837c-08de9616d84d
x-ms-exchange-crosstenant-originalarrivaltime: 09 Apr 2026 09:03:19.5372 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 65LxA6/K3VwDC7+Ha1c0PRaWjyDEXqPPCR1TQ/P+Cve2A3tP7svQXwY7xxp/Jo7XoRrVbcNXv0qU9DKggHCbCw==
x-ms-exchange-transport-crosstenantheadersstamped: SA3PR17MB6779
Content-Type: multipart/signed;
	boundary="Apple-Mail=_2D260660-5EB4-48F9-90ED-ABDF2ABF5270";
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
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604010000 definitions=main-2604090078
X-Proofpoint-GUID: 00bQVeMK4qY1QHhBjthT6ioZZZdrVETs
X-Proofpoint-ORIG-GUID: 00bQVeMK4qY1QHhBjthT6ioZZZdrVETs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA3OCBTYWx0ZWRfX/Ryt4sD1a5mM
 bY/yUOkzLhgQE0y1U+LgeERIT2PTjMFsjZfJLk3T1bHS92EVIyDrK+cURJbJyYMTA/eGOwVKgKb
 JjowN17unXbh1Xj0maniXBzZXPWJ40aNVdZ4hDS0Zmp0fSUriuAM+EI+fVrcLaPOrBFabGahkDD
 t4M/7C2MRZNwEmbQ2DLdXOZI4+ZOc8NJAw0Se/BQDcAicLqFCXpqkGwOF77IEcOv0q/2HhnIWZ+
 ujuh7JHc3AFJJL6WgsCqYR/lXl8BtTaCCaV36oT45RDPjmjwJQCyQ+Yc3s7iTaHYwgZRwl9Jl35
 spnH1IsBEsSZo3epJ5N1LK+BAbbD8yMtsJUfojmMJRB/PgJg9CcRu55MNwXNeu2cV3UcypiEGSe
 7aGbSYanciY1CulP35ZTiS6mRFywuHuIHzPZWMcDcdK0UAJtZLtLJWMH+V74BGjYvT16coVP6AO
 96sZ0j+nLNZCE7+8NNg==
X-Authority-Analysis: v=2.4 cv=Nu3htcdJ c=1 sm=1 tr=0 ts=69d76b5d cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=b_klpNw0ThsyXe4YF18s:22
 a=c92rfblmAAAA:8 a=X7Ea-ya5AAAA:8 a=pGLkceISAAAA:8 a=H_hYkFPg1GdPk6Ld2e8A:9
 a=QEXdDO2ut3YA:10 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10
 a=30ssDGKg3p0A:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604090078
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276900-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,linux.dev,akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,redhat.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 4C4C93C8306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_2D260660-5EB4-48F9-90ED-ABDF2ABF5270
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Apr 8, 2026, at 4:10=E2=80=AFPM, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Nick Hudson wrote:
>> On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
>> according to the decapsulation flags:
>>=20
>> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}, and
>>                                     SKB_GSO_TUNNEL_REMCSUM
>> - BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
>> - BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
>> - BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6
>>=20
>> When all tunnel-related GSO bits are cleared, also clear
>> skb->encapsulation.
>>=20
>> Handle the ESP inside a UDP tunnel case where encapsulation should =
remain
>> set.
>>=20
>> If UDP decap is performed and GSO state removed then reset =
encap_hdr_csum, and
>> remcsum_offload.
>>=20
>> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>> ---
>> net/core/filter.c | 40 ++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 40 insertions(+)
>>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 7f8d43420afb..04059d07d368 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3667,6 +3667,46 @@ static int bpf_skb_net_shrink(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>> skb_increase_gso_size(shinfo, len_diff);
>>=20
>> + /* Selective GSO flag clearing based on decap type.
>> + * Only clear the flags for the tunnel layer being removed.
>> + */
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
>> +    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
>> + SKB_GSO_UDP_TUNNEL_CSUM |
>> + SKB_GSO_TUNNEL_REMCSUM)))
>> + shinfo->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL |
>> +      SKB_GSO_UDP_TUNNEL_CSUM |
>> +      SKB_GSO_TUNNEL_REMCSUM);
>=20
> REMCSUM was previously not included in the series.

Yeah, I was trying to address

=
https://sashiko.dev/#/patchset/20260318134242.2725749-1-nhudson%40akamai.c=
om?part=3D5


>=20
> It is a non-obvious and rare enough feature that I would exclude it,
> or move it to a separate patch.

I=E2=80=99m happy to drop it.


>=20
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
>> +    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
>> + shinfo->gso_type &=3D ~(SKB_GSO_GRE |
>> +      SKB_GSO_GRE_CSUM);
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
>> +    (shinfo->gso_type & SKB_GSO_IPXIP4))
>> + shinfo->gso_type &=3D ~SKB_GSO_IPXIP4;
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
>> +    (shinfo->gso_type & SKB_GSO_IPXIP6))
>> + shinfo->gso_type &=3D ~SKB_GSO_IPXIP6;
>> +
>> + /* Clear encapsulation flag only when no tunnel GSO flags remain */
>> + if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
>> +     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
>> + if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
>> +  SKB_GSO_UDP_TUNNEL_CSUM |
>> +  SKB_GSO_GRE |
>> +  SKB_GSO_GRE_CSUM |
>> +  SKB_GSO_IPXIP4 |
>> +  SKB_GSO_IPXIP6 |
>> +  SKB_GSO_ESP)))
>> + if (skb->encapsulation)
>> + skb->encapsulation =3D 0;
>> +
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
>> + skb->encap_hdr_csum =3D !!(shinfo->gso_type & =
SKB_GSO_UDP_TUNNEL_CSUM);
>=20
> Since the flag is never set, only possibly cleared: just clear this =
field when clearing the flag?
>=20
> It appears that this is only used for deprecated UFO anyway.
>=20
>> + skb->remcsum_offload =3D !!(shinfo->gso_type & =
SKB_GSO_TUNNEL_REMCSUM);
>=20
> Always zero?

Yeah, I=E2=80=99ll fix these up in v4

Thanks.


--Apple-Mail=_2D260660-5EB4-48F9-90ED-ABDF2ABF5270
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
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MDkwOTAzMDla
MC8GCSqGSIb3DQEJBDEiBCCxeuH4iBHlbm6Ed3LvgV4Zq1jziF0GrfSqYNuTzyIZlzANBgkqhkiG
9w0BAQsFAASCAQAoj0vac4z9Y4tw4a4G3ULRa6H1YntZyuI19nc7XjPJ3//PsbK07g2b4atJMNZF
K1FLeJ3TPSZl4C3WNXtfpmQGau6ob0v1moqswQuHxysXbwSwAJ9IfXgT7AY0izB8GB4pBT8SITi2
AE5pZwWVlEui/Dssm818ISOGg+m/M1f0mfVjotde38hFEleET1+7OnpwT+CKwnjyS3mhG6a8V5e4
i1VQypjBBv1OcUXzTHP0Qg/BT/LtaRsdKBt47vvKsZjOUgvDwVCPacY6fBM5hRA8WL9erCUJleXs
b0u9YcnhkEExhYdLtdVPYXKle78yW+aLdtQwBYs9T6yv92hU6jPdAAAAAAAA

--Apple-Mail=_2D260660-5EB4-48F9-90ED-ABDF2ABF5270--

