Return-Path: <netdev+bounces-279310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NYOHm0n4mkY2QAAu9opvQ
	(envelope-from <netdev+bounces-279310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:28:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1541B379
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C66483051AAC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892F3859EB;
	Fri, 17 Apr 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="jqWKle6N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242038C2B5;
	Fri, 17 Apr 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776428865; cv=fail; b=Tc/5Lq5Yfda0zueHz9Cm+sQ6mu/gBsjarW/AbcB6Fxt6BKjLYsiRLNklTQmrsmF+IYdGXdu83cY1WE6AK4v1J7j/dFsGy9dEdtcfGizDTyU723gfsPRicocSKbVZyKDsz5IOQD1/B/gGXNtYrLX3NVTKnxyBQ9vjoFhk+Gh+JCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776428865; c=relaxed/simple;
	bh=Q613DSIqji2Vh73Mzt99NrnssK+WgDIIMvjZQeJuv4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DzTTc98OZTWyMTSz4GTZGQg54jR4y2Bb5SX9n1qj6lXvMdJw/A7+iYGD53iMlee3237oK7fgnd4Pb0DcSQLbZN2d4auA9x+3d1zw5V3Ghl2julmM9+qlognjKpOR8I8HvvAF0dJb1DWul52NF6b2et4Iz+y9lka0bqNU91LbvYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=jqWKle6N; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 63H7qLGn3757023;
	Fri, 17 Apr 2026 13:27:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=3v55MbL8Pxqqma6MX5Wsap
	fhGHVK6C6IqCI81VU7930=; b=jqWKle6NfAVSn+oCvthyHm7XX6pgjaAo0bCb1c
	ZVIin1sS7oySa92pP6XgrK19IAk0lPJOT842hla5o6kHzwvfVs/sciDA6I8rp5Lj
	NYjWFn5Wdm+7uv2TMGunIpLShDgEKfNE5/Oyj672SxBAMHvZAuO/nc+TPWtCNWuj
	FOrcSoTJI1xg71rPiee7AIDzUGMfD5D8lJm9qhUF01wGG8h60MMNvT6d/gr2boV0
	AN84n0kGBBArRTwk4zdzcaCq9T86aJW+Mrr5JLZigvZ/+Ahie+2s7ug9mm7zC6D4
	vfnIpuQzEnF41jaa9oatjtWbi9odwBNy5t50iPrlWgXQaYsA==
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4dg177f6gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 13:27:08 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
	by prod-mail-ppoint4.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63HCBkoh017429;
	Fri, 17 Apr 2026 08:27:07 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 4dj2vqq31c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 08:27:07 -0400 (EDT)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Apr 2026 05:27:07 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 05:27:07 -0700
Received: from CY3PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 07:27:07 -0500
Received: from IA1PR17MB6075.namprd17.prod.outlook.com (2603:10b6:208:3ad::12)
 by IA1PR17MB6974.namprd17.prod.outlook.com (2603:10b6:208:455::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:27:05 +0000
Received: from IA1PR17MB6075.namprd17.prod.outlook.com
 ([fe80::51e3:f458:da2a:4433]) by IA1PR17MB6075.namprd17.prod.outlook.com
 ([fe80::51e3:f458:da2a:4433%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:27:05 +0000
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
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Thread-Topic: [PATCH bpf-next v4 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Thread-Index: AQHczXZouD6mHnxM+U2/pNPxWW3fYbXhny2AgAGQ2QA=
Date: Fri, 17 Apr 2026 12:27:04 +0000
Message-ID: <A27A27DC-7421-4FF5-AEF1-B1BA384639FE@akamai.com>
References: <20260416075514.927101-1-nhudson@akamai.com>
 <20260416075514.927101-6-nhudson@akamai.com>
 <willemdebruijn.kernel.30d031033dc61@gmail.com>
In-Reply-To: <willemdebruijn.kernel.30d031033dc61@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR17MB6075:EE_|IA1PR17MB6974:EE_
x-ms-office365-filtering-correlation-id: 7bdd4b19-f9ef-460a-a9e9-08de9c7ca27e
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|10070799003|1800799024|7416014|366016|376014|22082099003|56012099003|18002099003|38070700021|4053099003;
x-microsoft-antispam-message-info: OtB9nRKW6aDR5r/NkpJZYjUY447S1/knZMFQzwRGUL6/bwLHwyidXexqMoflpQnGO5+04HctTPnzZAOV2bVsv0bNwdaS8nPwh3w9xk6TbbB1GI8nTUq8me1+BiPApzxk6ZfVAvQnU0pSl55Mamdr2c/Jk9bLVH6W0/OWNeXFC6QNiSMwH+Fkl9eIx/ryhZv7zRxNbsYWK2/MmfKxbX1xHIa4sAloJeXaTRhQd1IgiRpr8U84ul+RUw6P4QhPjWDb2XqhWTvPLCs4HKqYFSGiNAcntY26z4+cvKpBhJErPJuRydh0zLaHfItYo7pbw3GX/6UzDfvEKDyM+E4E8h0OopmS+OTO2ziaw+szllODUjuwjqc7OAjfLWdPN3bSOvpYLjUf0MzoIvG7gFsVXWhP1By940C0TSV03zKlKC+BAc02mKQbUaN0sblWOnWcf7u6LvAPavgT3nSmd2/pIcLae+p9u1l5FNoYb3lh8Jn1vVLP3EXhg3p7C1qeUjM8Dj/TuS6NA45kUpgjbpfIhemEUZtAr99Gpjjg9xvCRecEum9gbrESAdJD3mbkBGBnmUzMEmyGWrS590crqfllh6xxvxLPXjbhmz2ACRuu0O1xmjrZ+E1ojVL0G783ZLZg9T+2uBNu3/CxP0QXI368q5DEQTxvAn7METaO6BMmIoZL0zpw7t22WfFOpHJXmj6g2OINPN9ZTxWuwCXG+CqhBMXyM1tZZLkku9+ArAo4zbDgFaZ06gAhTumUOfRynrvzRfTci7rpQaOYrUag1BaplEjSJjX83uHT1WGm3Lgi3cI6WQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR17MB6075.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(10070799003)(1800799024)(7416014)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3pocVlLYTRzL3Q2TmZBNFdTT2thTkpkYTlzSXhKaWxPL20xSG4vTWpHbVc1?=
 =?utf-8?B?RFRXaHRzTTBEYlI4bWRzcUl2OXN2M1JlZVlhWnZkTml0bnNPaXNIa0o0d0tQ?=
 =?utf-8?B?dE9NcTNkN05IOSt3WFhzRDc2cEplSHJwaEd0aGlIa2pJMS93TkJCczhzRjJN?=
 =?utf-8?B?L3U0ZzlGcWdWZFRIV3JMQzlLNXFEMDh2ZzZmY3RUVVRGbW9Wd3YweU8zSWVY?=
 =?utf-8?B?Y0lQK3BwTVlMNTBLMC9TQk0zKzl2L2lSMWxPQzNORWNuOHA3U3ZrVjQyaE5n?=
 =?utf-8?B?QVdYVjVVTlJranhUaDdJa1BMTDRFd1Yya0ZLREkxRVhHUmVFOUgvK21tMGVK?=
 =?utf-8?B?cFhRSmoxRUFjZ0djUWhBNk42YVRadDNGcUxWaU0rbUF5YTFhS0g3WlRXZXQz?=
 =?utf-8?B?L2REWjUxR2FudUd5NFg1MDdkNnVqRjFUcFMvTDZGaUROMDcwaHh3Z3JHL1RK?=
 =?utf-8?B?bGJIK0drR0piaGxkRGZGYTF2YnNFSklSUTVrNXIzdUM1NERITHNFOWIwRGtG?=
 =?utf-8?B?Ui9MUW4xS3hybnFlcHBnL0taZmMrclNBWGVWZXgzbitnbGxPUzJSbWdQVk5n?=
 =?utf-8?B?TW5hYnNwcWlJL2pZR3Y5b2ZOelg4WlBmbXI5dmhXQS9Ib0F4VGdqZTRBR0VQ?=
 =?utf-8?B?ek1GMDZISDZPQ2thQUl2cENOMjdiM21qN3JHK3poUDZibFR0VmtVZXlUMkVE?=
 =?utf-8?B?aW9FbUFWR3UwUk5IM0Y2dlBXUzNpdHpuY0l6MXdBRlBKNnJmUmhCaHBYLzFS?=
 =?utf-8?B?MTdkUUFKY3VpSlQyeTc2UHdwZ2RYTTB5L3RtNnJMdkxRRmtpQ2hDcVBzK1hY?=
 =?utf-8?B?ZVU4Y3NZTnN0R1hWVFN4YjR4Z1N1Ui90ME1WUm5oMGY3dnZPazZOeUNnb202?=
 =?utf-8?B?MnViRGpNL0pmSGZuN2hTTzZ0ZlBGK1c3RTRjU2haTW1kQndyRms2QnV3NjNj?=
 =?utf-8?B?Yjk4UkZHQWZrdTlFeDNjK2ZoNTdYaGpkcStXOUJ6WDNEYjhlQVZkM09tYU9V?=
 =?utf-8?B?dk5McVhlQkh1ZGlRaUNWLzlsK0xBL1c0Q0c1M3hpdjdxaHFMbkZSQmc0bHNu?=
 =?utf-8?B?MnBOYjdvUGdEYjJMdVRjWnRMUHRsenhYWDBwdStRckhnazdrams3azA3SHhn?=
 =?utf-8?B?OTVwK2tmOFUySHR1UTFoZlFTZHhUL0RlZTU2Ly9JVFRGVDNsZUtUY1pZZHdG?=
 =?utf-8?B?d05PK1AwMVlPUDhiYVR1enhQU3cyMVFaQnJ1YllGOE9ySFppZkJKSVZZOWVU?=
 =?utf-8?B?WjFNanhFOThRdDFpMUU3WW9qQTZWV0syNVBPbCs1R1liNk5pN1dHUkpsY0p6?=
 =?utf-8?B?SmRydmJoOU04SkQ3UTg0VGZ2NXRsUFFlQ0FnandvQzZXbnIwaHZrZmlkRURK?=
 =?utf-8?B?clNaWDBldTJxRUlPV2NiNmZBWUo4bGs1Mzg0YjJuWm1wY0hoTndUdVlkNmdD?=
 =?utf-8?B?ZlErVTFnd0xlWnlpQUVCRjB6TGNkbFZFLzVwRURCRkloSlVZb1hNWVgwbHZs?=
 =?utf-8?B?THBOcHMvSzlvb2l2UnQ4WVgyWjQ3eVBLZGp3NzZ4TjNKMjJGQTR2U0MvcmdF?=
 =?utf-8?B?cC81dElKU2JCMXY1TkJQUjVwQkNwdVQ5QndWcy9kcVR2cVc2MncxdE5XNVRw?=
 =?utf-8?B?MmI1SmtXbEN6NVMzRzFLdXcyZnlUYmFoK0ZOUEhLeFlGSjdsck5sOXFrVFZF?=
 =?utf-8?B?ZUlXUE4zUkZLVG82Y0ZacmVzeEhTcFN5ZktiMUV3TjNHQW15Unc3S21qM2hK?=
 =?utf-8?B?dWdhbjBjcUlJcHhBTndQZ29zZmdFQm5jYUNtazBsOHIyM2RVVmwwekFnWnps?=
 =?utf-8?B?eUF3MlZUb21xaHB0NjhSZElGUUxtWklaeEZoNVVFRTlhTTdxV3BlQ3VrNGdh?=
 =?utf-8?B?cEE4aGEzN3dCNTNqMHAwU21kMmJDaGNqRGVWYkRqbG8vS2UyeEhlUWtxMDZC?=
 =?utf-8?B?dnZGMUFyM1RHZEJWRWlmS3dFK0o2bkU4UTRtTUo3VjNrN3VtM21zbUlySDdS?=
 =?utf-8?B?ZWNQd1cyT2p5Mk9hMVVUaHhTVnBmaGpQbWo3Ukl5bXpJSnJ4NTAwdU96OExs?=
 =?utf-8?B?RnRqc1JaSXRmRGU1ZGxGMDVkdU5vUmh3VWoybllLWGpKbjk5VlNQTFNzdW04?=
 =?utf-8?B?ZDNCeHMxQ05VQlNMNnFGb3hnT1R5eUlhbWdJMDArOUlJQmZSZHNPeVNrMzRs?=
 =?utf-8?B?Uy84ZHNRNTlDSG12MkY1TUZnL20yQmwvMzVlak1JUmFSOUlVRG9yS2xCR1Fk?=
 =?utf-8?B?SzBDcStrWk1FbTdjczFqZnVBYjNreDlNMXZjckxLNjQ3ZTRKTmdkemZhL2R2?=
 =?utf-8?B?V0hqV0ZzMkZJUEYzNVdnWndld09HRktzdDFIL2hKRlgxRkJ3by9BSS95VzFy?=
 =?utf-8?Q?Ylpai7wuNW+DU8SlGmfi4iOSSyhFuwKBWe40kovAZsPwZ?=
x-ms-exchange-antispam-messagedata-1: cnrXFw30Pz4lrw==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjAfuAMQ570PXBhG+q9q9wcdRAdd2VfriwUuWmxUaknwbW6/WH+CH9MsUedS9CriXmLp+0PFX7VWIWrDgqvckgsVF7j/WV/KpucMo3RsKb39cf1ncxZ52hA78prMES/yw8nLIDy/OxSg3hKvvNgKSUnuKayssiPYgOwuGfiyQRT2IaZPzR8RV3NPiVrfMQmh0TWv4s2Xb3MSvaQlbjVrScFZ7eZk3qVRMToe2IQ3yOPdYvbSym6s12Etlrr2mI9dWdg9yiFj3O2Hn9Jtca+o5GWlGAQl4oq+/hoznNHmjOxuTrX9enrfpE51Gy9KfLP0ck/aa/ApdzmD5HpRI+9qfg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8sTrv7Arhm+grcWGAwvPbxQrJZDGrndLuAlmgQFwwQ=;
 b=Ow3ws8LidON8PrLyVMWAJt2glf3IeVo3942EPAGA5MNZhqQQ5TIDtf1tBZZdmHE2dXvEPUfrcsAhrTvfeNjoud2+qGgks3gh45OFKBh9NL584CdrKpFATFUjSpkwf9/gNuBBkN1clb+wTElVK5Vj/RNy9om7u4jQDGz+3I2TmInBszvUTGKRq0ex9/eSjFV7tlzGkt06QN8FT5/eEdzrd353b/tTUiCptn39OXemjhfdHSwnUiF2fqgJno4o68wiNHlVDHBLYYdM/k7+U07zCnOESyKlOpUEj+Ut8GPFsxKC9ev7C7OOR4yfYc1KSSaqTS1PWOkeKduIceG7WWFPXg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: j+MnmnfvRn5wrQBBEr3eHSof1a2K2WXV/JORZlmK0/nAOjEE5QS6qj6K11LwmHCgRSZWyAG2t5JJlHV8t/oOjQ2rcyYcYRYM/O/i54g2CqyfbagA969+ukRI4Cyq4Hn6zg/1YQTjlj5oiKTQBfTuohxF6t0P8N2Jy8xlFvCjvFalfBnh8oRzPHBzwN5W2K8xtykSvs6NFv7E+ZX63DUnB+rJP0HakUqeYa8tHrRwraNF2j9qrWFH+fahZhX+buqfYkkGC0CsXCWuO/jsgWs2Vh8esTilQVZVaNVXvhYGfI2atMQivm0kF3vcGt/TfgRtfY+sdKFKrLv9mfnNmzHVEw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: IA1PR17MB6075.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 7bdd4b19-f9ef-460a-a9e9-08de9c7ca27e
x-ms-exchange-crosstenant-originalarrivaltime: 17 Apr 2026 12:27:04.9040 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: an6F4jq4TQFolEOT8HahW/vCTNeIAJGg69L0l+TARsOE2hUuRFT3rwQ5xs/KGe8f/UTdkmJh7C4kgnlrrLGS5Q==
x-ms-exchange-transport-crosstenantheadersstamped: IA1PR17MB6974
Content-Type: multipart/signed;
	boundary="Apple-Mail=_AEEFA70F-9158-4FFB-AFB3-A4C25B6170BC";
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
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604170123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyNSBTYWx0ZWRfX2TOjF7wzM5Td
 WDridX2l4snUu715Pn/RW79j1sHuUnHtxHJG0J8G8ZQBlHxeDA6hLd75qD7CkT0Gfl7haUzWVTQ
 SKsHVN0+poFEOSaeFj4YGV38SqTTJ8MIWYXSYuJ3yZwbSVzuiOsn1zNGR4X1m9mEyU8pIatg1+k
 fVLQyKnafcuXq+6PScqZIQX65ZqYK4ab6eJZirFIRFb1YmDD5trGBmzW0YUlU1tWhyXit1cGNMB
 H4/vKGW36T4FGWxjq7dqNAreKxqi94gY9FIKpksjIpy7Z3YJdbyf175H09sn9dlt0krg8OXswlK
 0Jm+ELCZL/c0Iw8klE3lYSKeoLveDocwWO27hdkTz5IQkNVtnVAsf/32Hd1YPACbi8m3h403f+y
 LPb2j5nv5A563C3GT4NubERCNDDUbQPmg5k/fstTyIf1KDCkvLs9nPctSQByPcSEze4ZJmHO1Fy
 nz3Rwf8JAxsv7bThUlQ==
X-Authority-Analysis: v=2.4 cv=f8V4wuyM c=1 sm=1 tr=0 ts=69e2271d cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=KDzEjHMMTas96-nIEKpj:22
 a=pGLkceISAAAA:8 a=X7Ea-ya5AAAA:8 a=H_hYkFPg1GdPk6Ld2e8A:9 a=QEXdDO2ut3YA:10
 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-ORIG-GUID: UNHfB_tjwA6cUpr3DcVArNk1aPWhcfWt
X-Proofpoint-GUID: UNHfB_tjwA6cUpr3DcVArNk1aPWhcfWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170125
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
	TAGGED_FROM(0.00)[bounces-279310-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,linux.dev,akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,redhat.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email,akamai.com:dkim,akamai.com:mid]
X-Rspamd-Queue-Id: EAE1541B379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_AEEFA70F-9158-4FFB-AFB3-A4C25B6170BC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Apr 16, 2026, at 1:32=E2=80=AFPM, Willem de Bruijn =
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
>> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}
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
>> If UDP decap is performed, clear encap_hdr_csum and remcsum_offload.
>>=20
>> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>> ---
>> net/core/filter.c | 38 ++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 38 insertions(+)
>>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 7f8d43420afb..e113ae2f3f14 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3667,6 +3667,44 @@ static int bpf_skb_net_shrink(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>> 			skb_increase_gso_size(shinfo, len_diff);
>>=20
>> +		/* Selective GSO flag clearing based on decap type.
>> +		 * Only clear the flags for the tunnel layer being =
removed.
>> +		 */
>> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
>> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
>> +					 SKB_GSO_UDP_TUNNEL_CSUM)))
>> +			shinfo->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL |
>> +					      SKB_GSO_UDP_TUNNEL_CSUM);
>> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
>> +		    (shinfo->gso_type & (SKB_GSO_GRE | =
SKB_GSO_GRE_CSUM)))
>> +			shinfo->gso_type &=3D ~(SKB_GSO_GRE |
>> +					      SKB_GSO_GRE_CSUM);
>> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
>> +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
>> +			shinfo->gso_type &=3D ~SKB_GSO_IPXIP4;
>> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
>> +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
>> +			shinfo->gso_type &=3D ~SKB_GSO_IPXIP6;
>> +
>> +		/* Clear encapsulation flag only when no tunnel GSO =
flags remain */
>> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
>> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
>> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
>> +						  =
SKB_GSO_UDP_TUNNEL_CSUM |
>> +						  SKB_GSO_GRE |
>> +						  SKB_GSO_GRE_CSUM |
>> +						  SKB_GSO_IPXIP4 |
>> +						  SKB_GSO_IPXIP6 |
>> +						  SKB_GSO_ESP)))
>> +				if (skb->encapsulation)
>> +					skb->encapsulation =3D 0;
>> +
>> +			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
>> +				skb->encap_hdr_csum =3D 0;
>=20
> This field is not used with UDP_L4.
>=20
> Similar to remcsum, I'd ignore it entirely in this series.

Will drop from the series. Sorry for getting confused here.

>=20
>> +				skb->remcsum_offload =3D 0;
>=20
> Why still include remote checksum handling?


Because I misunderstood your last email - will drop.

Thanks,
Nick=

--Apple-Mail=_AEEFA70F-9158-4FFB-AFB3-A4C25B6170BC
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
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTcxMjI2NTRa
MC8GCSqGSIb3DQEJBDEiBCAneNTZaIgetk+D+WYYG5oH069wGPpVOU81+n5Rw48GeTANBgkqhkiG
9w0BAQsFAASCAQBRITlcZfzIjorcCAa0lzg7BS62yhRT0kxZbmgrbj+JEHAfdn6Y9je1UgeJLONu
z31b3ql1jvsraO2nWy1WxF5Wjwe8UoG8oBicVA64P5GNq1/MqLlcUkjcn4jJMGdhuo5qkJiAQzgn
EDnjwyAz/rGhOLSG8D7XTrZRSpLcumDtVJrqfI+9xAue40CXN+zXLMq3TPLIz1a4ekmcLae9TzHm
HjEjgN9GtZxyDXfLcrytrUsHz4e6UQXiIQJCkKdjwyYWN+B/3exqjFJEdD5N3WV78EwI8ObtLU6k
M2K8tAT8M9+Zal8AOTBr7cZpwLehU+K5qceiYa/QF47YgQzEhGYXAAAAAAAA

--Apple-Mail=_AEEFA70F-9158-4FFB-AFB3-A4C25B6170BC--

