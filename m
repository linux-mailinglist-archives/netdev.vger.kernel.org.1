Return-Path: <netdev+bounces-260777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFiADfejnmlPWgQAu9opvQ
	(envelope-from <netdev+bounces-260777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:25:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A41D1935ED
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974523055623
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE0D2BCF46;
	Wed, 25 Feb 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="YGsepo17"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C6381AF;
	Wed, 25 Feb 2026 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772003657; cv=fail; b=OXMyhBMc7dNzVAtZjwvJf95uhHUcyPHNaamSFTruoH0EEEH2VPR9uof42JHAxLAQVDFsM3Z/YydJLMonUkpRZyW7yLOEpL8ylKiZpYGoG+YQBG7crjt9ndouETRAR3ku4KNwP5KoRFAFCQhp72gdXBwevLAftfIUekEVbWFxpbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772003657; c=relaxed/simple;
	bh=ijvgEUDInRgtbIO+9ldhSre/cAMCdbYY0WQL5cF9JtE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cZdWg+VN1z5sjePMh4p8ISS+r7oBLPjoDlBcpOmwWB9Yy8KQy9KvDiE9WPZuLWNT0biIWaXC77YPIvuxNAtLBV6bfcAYq+xWUY+VpXknAwlMWfSUCuPuFxRr4NUzcf/A0aGVA2OC9EyzgTYU8aOLXibtErua7TGI2CZAn+pqtE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=YGsepo17; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 61P3qx6f4126220;
	Wed, 25 Feb 2026 07:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=g/LXpifXlYXtZ8b91t6VFf
	pImpsHO2gtFkZo4Sq6EA4=; b=YGsepo17PD+BE6GtFrSC7rB6po43hJbeK4Xsfe
	spF8mHhlzU1+te1XCt0USTpSMS3EX5ElkcUaVWq+ddsFXQy6nyMAAckOPzlz+tHx
	S6RzJ7G3tkBBpznhTx3QRW9/ct6BzD5AOOFdCIcOyipad1/JcQhUDgz8NLODyg8O
	l7k5A5IKmaepxV9PDZcc4o2lY9b7QP0Ns8nc/o/gbAYKkVeeQUYVVIIpkVGPZXg/
	q06gmxFV0YwMsVNPSjsFnZgPZ8WYmel1jlooZ+M+UHCboTBgTi7Z2UFIqb2U9TqZ
	hBu/2QKvANKoQ1a8DBCRoJtrb1YX/2Pu2hiVAke6WXWL3Qow==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4cf63yf8w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 07:12:55 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 61P744iA001376;
	Wed, 25 Feb 2026 02:12:54 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4chtw78g6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 02:12:54 -0500 (EST)
Received: from ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Feb 2026 23:12:54 -0800
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Feb 2026 23:12:53 -0800
Received: from PH0PR07CU006.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 24 Feb 2026 23:12:53 -0800
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by SA1PR17MB5106.namprd17.prod.outlook.com (2603:10b6:806:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 07:12:50 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 07:12:50 +0000
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
Thread-Index: AQHcoY0hZ/LRms+hDEmNprgx5i7bw7WMFwyAgAbyIIA=
Date: Wed, 25 Feb 2026 07:12:50 +0000
Message-ID: <7C8018C7-B0E2-435F-B155-60F29BCF5018@akamai.com>
References: <20260219104710.1490304-1-nhudson@akamai.com>
 <20260219104710.1490304-2-nhudson@akamai.com>
 <willemdebruijn.kernel.5766d0a10c73@gmail.com>
In-Reply-To: <willemdebruijn.kernel.5766d0a10c73@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|SA1PR17MB5106:EE_
x-ms-office365-filtering-correlation-id: b920303b-177f-4d3f-b61f-08de743d4973
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|10070799003|366016|1800799024|376014|7416014|38070700021|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?aVU5Q0FhSjhEKzltaDJ1OVEyZGlrL29mKytoWkphR0JOVTVLdzRGMEgrdTVu?=
 =?utf-8?B?YmRFcyt6WGdUNXcrUG5wdzY5TWxDdFZyVUg4TnRKL1lyeThDTkJiaFU0eXEz?=
 =?utf-8?B?Zko2R0pMclJpNVoxZnJoK2MzTk1kQUQ5Y0NqbnVYU21nam1DL2lHL3lmNkxG?=
 =?utf-8?B?N0Z6UUdyMVFpSkNLazF0azV4L1RlQ3g0eUdhdHBlVDNoSUowVUVvYTV6K2Q2?=
 =?utf-8?B?TGNMdC9zOStaWDE3T1gzcEpCcnJmNUZ6OE1yM2J2eklXS1NBZFVNMTB6NlM0?=
 =?utf-8?B?aytMTlZUWXVLT29vL1lMa0RCWTZkKzBYdWpyRjRjcHBEQ2wxV3Q4Vm9KcmN3?=
 =?utf-8?B?Q25ScXI1eEx0eFpiRVBsNmJNK1VaZjJrMHVQaWtKY0ZMc29QUUM5ejFxSWd5?=
 =?utf-8?B?RWVvZTBkdktoYUFQVEpTeERIQXpnaGRjbVUwSnpOSWVwSGxPMVNTR3QwOU1W?=
 =?utf-8?B?MGdGS3ZTdjBjM0dsKzRpajRSMGhnRzR1OUYxV2hidWcvSUJ4V2RIVHBUSnhw?=
 =?utf-8?B?UUlOSENmamhhZkhrU0h2SVlKd3JvUFUraGhiV2Q0cmM2elpyVDJSaUd2QXZK?=
 =?utf-8?B?a2FKeDNuMURJM3lwcW1FcWd2d1B2aEVGY2hYTXlEUzIvVEh0cVlRZUNoMGxl?=
 =?utf-8?B?azRNSGhHTGo4ZGxYSC8yM3l1b1JLUkR4MGpVWUczc0l2QTlVUnlRRjRQaVVw?=
 =?utf-8?B?VEZYRjhGUEV2c0FQamd2Z3ExM055V0RoZS8xcXl2NVo1U3FEb3grVUhHR21B?=
 =?utf-8?B?TzlxbzdhQmN5ZWJqNXA2RisxSmNvWUw0WUM4UE0ya0YzN0d4NE0yc3IzZEtQ?=
 =?utf-8?B?YmxnVlRva1RRZGhCdXFaVnl2L2JkcXJrcUNRY2ZpSmg5bkorQUNlQmI3eS81?=
 =?utf-8?B?NnE0eWE3azhpb0xJQ2tNaWdkRUo1TDhlMlppdVpjK2lPWXVOeUFmYkM1eXZt?=
 =?utf-8?B?M2ZOakNTUUx0OEhFVXB1K3RsM3dpN2t2aFVYaWR6a3dESHRtSUY2SzJaMVBi?=
 =?utf-8?B?RTdRbGdCL1orem0zWFJ1OEtsTnJpTjEyRkpGNnYyQUlSZHF1cndDUlBOY0pL?=
 =?utf-8?B?ZDRwaVVoM0lHVjVTd3YrcW5ERU80SXlrL2RUd2VTcWlPN3pXSlFXMlM1L3FW?=
 =?utf-8?B?YlJFMzh3bit2WkxBR29rZmhiQWd1RFBKTzdZNzNKZjZRKzJ3a2dRMUI1WHkx?=
 =?utf-8?B?RDlhbkNLdEp1TVREc2xPSG9LYUw1M0pKaFhVN245cTVDY0ZuamRMRmNkODMx?=
 =?utf-8?B?K1FLZ2hDcEpCMlZmbVdMc0FPNHFZZjl2YjBVb2FabllxUXFpb1hsOXFwN0dY?=
 =?utf-8?B?RjZ2amZKejl0RnRNWWhmbU0vUzlrOUE1SHltVDhqM0E0SmJVWEd5cWowSWpv?=
 =?utf-8?B?b2VPMFFrZ0pyUWxCbk9ka0EzZWQ0K3JkUWJFOG5CNjhoL21rbWJrNmUzUFBO?=
 =?utf-8?B?VC9FWlBuNVAzTU5wNG9MSTFUK2VwRmp6QUtiT2J5RHBTQjJlbTVZZnc0OFY0?=
 =?utf-8?B?d0NWS25GVVhnZTB4anlyWjkzWFNZTm00blA0WnY5NFc2cTBNWWVHcDFsWElv?=
 =?utf-8?B?WWNweHl5czVyOFc3TWdJQlVvOGhRRkhJRlo2enlqWVc2ZHM4cm94c2RPL0Zz?=
 =?utf-8?B?bmN0SGM2cDhCb0hMVGNBcHo5YjNyV1dEbkRWM2RXdVEzNUdsdWpYUWdKY0Fp?=
 =?utf-8?B?eWhYRUlBb1RJdmxGeE4xRDJZZjNDd2tBbWpqdjVUWHVpS21OOFA0YXQ1WGhJ?=
 =?utf-8?B?UFB3QVJxaFhubVRUc01xWkRZOXZGeEQrbFBGMHhlUmh4d0ZvY2w4V3BOamFo?=
 =?utf-8?B?cXBETkV1YVpobGFNeStRbGd2cUtvSDl4OEpZaE9HZDNDSE1zRTByUTh1aHdG?=
 =?utf-8?B?WjIyZWpyVWlLTUtSa0U3dzZ6dDBTRXVsZ1h6cEp1WXByNzFxRi9zb0thT0VO?=
 =?utf-8?B?cDZ4NTlBTkMwejlDZ2NVZEpLRzdkcUFCQ05BdzNWOHNyUDZWVjlBTXJHU1dB?=
 =?utf-8?B?RnFqaURwdS9LREMrNlFHWkc5dmFoaThlS2kvY05VV2VjMEcwNkNSWFhQaTZ5?=
 =?utf-8?B?SlBUaUUxcDloZ0Z3a1JwbWE5bHlqejlxUjU2SGxSakZjTGZwbkFYYTBuUStK?=
 =?utf-8?B?RjVjOWZzS0RNWW9BY0h0Ym9WQ25tK0RkM2gvaG9LcGVaVmwvOGNJTDhQR3lX?=
 =?utf-8?Q?YKAyPxmYrBMupBSEdYq8CF0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(10070799003)(366016)(1800799024)(376014)(7416014)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk9kWDIvOVR0aEl5VEtDWndILy9HUHZvMUVKejdyeXJ2RFZGN0ZjOHFHNXhM?=
 =?utf-8?B?a1ByenhuN0NjNmxKYUJ5dlZyZ1VSNiswRVFXUHU3dCtEMXh0dXdIYnRZQ3RJ?=
 =?utf-8?B?Tjd0N3ZwMzZId2pJWU5iY2g5NitBYXpWbzg5RlNETklKY3dSMUdVMTVWb1dL?=
 =?utf-8?B?bWRSSTk4aDRxdEEzZVdaMlZMSzNjTzRZZHJSOXpRc2hGbEtKRWZJK2FuV0tS?=
 =?utf-8?B?d3p2RTNNSUNmUFlSb0g2ZFJNcERkQkdFUWo3UHJGWjRNNDg0SlJxMHdtY2xp?=
 =?utf-8?B?Y3ZSb08rUHF4a2VHU3dzNjNObzl0cmxBSVovWE5ITlpjMURtdzIxd0U4Wkhj?=
 =?utf-8?B?K0UrNGpzaFdYZzZibFpXYTk4VER1cS9GYzBOMDVZelpVQ1RHVG9qUXZ3OVhk?=
 =?utf-8?B?OWZaaFl1MHFGTGtjZk1oVmVtaEp2QWlKV2t1VGhIMlhRYVFFYkI2MFFGdWJz?=
 =?utf-8?B?bnhqWW1xQUYyVjBGeGNrQjhHRFJhenFhbERNNVVEUkQ3dERnT2Qvc24xWUFi?=
 =?utf-8?B?WE15ZGZ0Y2JaMlV2bC9WL3ByK3hYQWlnVFEybEN0R203cGdwTEVaM2tZSWsy?=
 =?utf-8?B?azRjTG9heEJ2Z3ZwNXNEVFI0VXhYNTF3bVFPMS9ZMkhBYWpnbmJVSTdXTG9F?=
 =?utf-8?B?T1A5MHdRVStMa2Z4QTFBOTJ5WGhmZVIrR1hqMFRhb1ZaYjV1dGE5dUEyUzdt?=
 =?utf-8?B?eHYydWlZd1JMUjRxbkkyYXFxQndvUjc4QnFhbVJqN0FiL0REdzMrMzQ4Wk4v?=
 =?utf-8?B?eGEvSXRubXI3MzFvcTdhR29tWG5ualV3RitoL2hwV3BvNU1hdjVqdnJjNnIz?=
 =?utf-8?B?NFVXa2pUN3JTTW12Y3NVaHdxc2lISUlySnFCc3NUdnFheC8wSW1lM0pnUG1E?=
 =?utf-8?B?RWlJSEI5SUpXU2U0SS9IeTJWN0E2K2FNK2RkRHZqeGszUUpnRS8rTUtZNlBx?=
 =?utf-8?B?K1A3TjBUY29RZXlkVHdXdS9JM0svdHN1R1EreEJWcHowUjlpZGJvd0ovV2NS?=
 =?utf-8?B?RE5kRWl5ME92TTRScy9ObkNjbTJmZ1dPeVhEU2VnajV1clBWRXRuMTEySGNB?=
 =?utf-8?B?V2wxVDJ6SER1VXdhZmVCcWJ1TCtWTWp0SXRsdFlOdkJYeUNJYVBlcHVZekpX?=
 =?utf-8?B?M1cxRndRd0JpZHZsbW9BOStZa0hOWHRRQ05Xdk8vL2JzbXR0NUIvUGZ4Y09K?=
 =?utf-8?B?cXgwS0NWcTc5emJPdmpZcW9PN2NaMk5lVlZtYjVnbVhSd3l5blgyanpQck5F?=
 =?utf-8?B?OWovTldyZ25IM3dXSzFDT2g4VEMrNjVVZXRqR2VhMVhiUXZKWFBTZTFldlNk?=
 =?utf-8?B?ZjhTMmNwbkRuZmpPdVFOSndYZHFMV0dWMTVLMEJkYjBlN25WTU5JZWRhM2t2?=
 =?utf-8?B?YXpoQ2RKaExEdlNYVHlzdzk0b0I2S29kSkpPQWZRSjRiZzVSZHRxV2o1Zmgv?=
 =?utf-8?B?WUFJWkl6TURNc1hJQnBGVUtVTjI3N2l4L2F2bmJ2Y1lyckF5emtqTURXcytu?=
 =?utf-8?B?L1F4Z2Zqb2pVaUc0ZWplTWhXYWdMM0h0b0FOVmlOZnVWaE5pRlA5bEdWQkdj?=
 =?utf-8?B?ajlkWkpnUm1BYW0vanNvRzJXWGtMQ2VlaHhhd2pIMHZ4bFJxSWg0bHZrTjNR?=
 =?utf-8?B?Q2FVcytGRGk3WDQwUjhlQnRTUTd2VFhHSHlRcHkwem5vSlZtanZQZVhKTkZk?=
 =?utf-8?B?MXAzeTdPZEMwbExrTWw4aTk2NVI5bGh5WUlzNlpiZWlWT0pMSEtxb0hTcmlP?=
 =?utf-8?B?akhibVZKekFBZnpCVi9XckM2dTFzMmpwelFpbGZPaml5SnhXNjkwclRLSmc5?=
 =?utf-8?B?dXJQN0NnejIrN3ZQUTJDQnJGL2pzcys4a01BREtMcjRwL015dUU1aWFFKzJ6?=
 =?utf-8?B?WnprQ29JdlVlbWtXZWNkTDhwb0dVN2VNWEh1c1NyajQ2b0FsUmZXbG9WLzRu?=
 =?utf-8?B?TzFFckRlQmU5NlJoWEF0MzFZZDE0NHRFb1BLbE1EK2NHMnJGQlpGZHcwT2FT?=
 =?utf-8?B?SFJzem5XQUN0ZWJMblNTN0hNSmRsRHVYOEtWdmxtbWN4cEdoVmVoTXNLWTI4?=
 =?utf-8?B?R3ZWMkJxYTVVWHI3ajJlaVRZaTJ4aWV3MnJBeDN3aW1MSUdoYjUxMys5ZTFH?=
 =?utf-8?B?dzV5c3BVTHpBUUY5elBJQTNYTjFDaFE4aHRiS015QXc5Y1ZVVDEvNGZZOU5w?=
 =?utf-8?B?OUJ4aFppN0MrNmZxNzNiWWMwL3h6Njkra1RiOU9ZeXNpSUZIY2k0RzlvbjF3?=
 =?utf-8?B?Y256TUNXY1E2d0s5WEVnMEN6WkMvUDlHa1FwVE05M2l1Mk5vWDIrejlpcnUx?=
 =?utf-8?B?cHhzVmZvRi85TTUvWWJES3RqRFFiYi9XbDdSRHNzbXYyTSt6ZDlBSmZnallw?=
 =?utf-8?Q?DRijfLxhVckp4K7egM67nghPLyedgJhLODQJ0rOBZ2af2?=
x-ms-exchange-antispam-messagedata-1: Nrbi+IQ41jfafw==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1fL8+0KbZhgckGzfh9GEaL9gbXZf/h1An8YC1Kmm6wBg004A/dT07hOmlXYRgD6+L9IPGYjB26WyiSiPcUgFvApFxdit5Z0P7lPsjZ49SLyOwwXALjIe1Lydwu8/USAgsS5rcrSz8DnlfY9qNqPjYZnyLQD0oAkk77DK5HrO6/+rf8i4Cy0yTUlbCwin89kxNjF6BPDT42B4G+2Y6O7Bj4EGcKgGGcYya7AwJ3OZOcq104W5VJUhiC6ZL6d4U6a2leNIBLXCtC15iiUKxK9c2I3M/0eHdsacoovup2zjC1jtraO/GWckQZx7n6nzC+nP2wKWrQHd+HcAMl1JLtYkA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J+7Ncw7AJQuectsRgBClagco1FYUb+rO9BmfzGTMHY=;
 b=iwpfkVXcl0uHdXAghlj9H3eX3WsAreSY1ahxv4aNgYspQuzWg8WevvLNC/jCO6fQEwEm5Z5rG/mg+CZ1KVJwSnzVi7mzdPXOto5RXeNyRJx7orCxgraYinn2ySthxslpxmrm9sDeU1DZOVXuG0TDeM4jM0ML3iCbsEdWYyiZS1emxX5VQJvQZYBPElIZm+C0SCF1vpnET2cLN1Tx8wL3Tur7RDC16lZ5FAOtOPm8UegDl5TgjmFhPcgvIq6FPjIVCrqP1JV+8nZTZ6fA2BOA9bhXgUqvsiaxpKtkyCihNbyFXPWZT1rSFuB8mpOuI/v0cxqzwA8mhgidnRjclMIdcQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: b920303b-177f-4d3f-b61f-08de743d4973
x-ms-exchange-crosstenant-originalarrivaltime: 25 Feb 2026 07:12:50.6729 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: FJCudRaMh71gJrOhwva0kwHY62U/zP9ttuVSOJvNEIVvZoAzCjsqKtj4NjJwEkFWdIgf3s6k3oMvw8RwYehizQ==
x-ms-exchange-transport-crosstenantheadersstamped: SA1PR17MB5106
Content-Type: multipart/signed;
	boundary="Apple-Mail=_9C4AE783-0867-4BC8-9178-78D39D4E445C";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2602130000 definitions=main-2602250068
X-Authority-Analysis: v=2.4 cv=McFhep/f c=1 sm=1 tr=0 ts=699ea0f8 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=d4nn1RXdvEacMIURMw2s:22
 a=pGLkceISAAAA:8 a=X7Ea-ya5AAAA:8 a=bHQCwWNakyMPefPRpW0A:9 a=QEXdDO2ut3YA:10
 a=wqFnSJPP-FBafd8uH9cA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-GUID: KbRRaYKZ5lyOU5__DaiqtSl2-0ysw23G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA2OCBTYWx0ZWRfX3hZkf5NWPU9F
 aeYi9GPpQpi3ILGdbbl6BPuyrKSQS7bxy/KdmgSor8FR3IyAtIZESsIHDIec0ZVkT7c7oo9Bntz
 cK2vCGwz2Heh/pmeLz+o0gncIfXW/rOfUElhrpXk8hDRZOJqXHA/elwR78rD7PYtlqPUpDkOFAQ
 ikD9nhS7tcOGO6sJlGdHbLh3SWoQr2RwE+O+iqpWh5qmUR93IaTYu8MqRraTANx2nhO0KzhzE1N
 YEp1cVM+bGVGruAJ3YqK1/NzlCj8Iku5ih1tUYkYrtf5rHqBDp4OM0FhLicgg/W58z2HSKfweQV
 ZWWXwO76FyuUztg27Z1dCztf4f5K3rZcXwj00dYehrx36XptvmZ1bymLHjLAQ27wclSt575xkO2
 8F+ofT9Y5YbFIwBHiTMJ0/mS/2ww7jytNJMfNZTHWE5meOAaKXVzb8XH3w7Ng+xd9ePueRsuh/B
 PsFO22TgFuJnBJz6yiA==
X-Proofpoint-ORIG-GUID: KbRRaYKZ5lyOU5__DaiqtSl2-0ysw23G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2602130000 definitions=main-2602250068
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-260777-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:mid,akamai.com:dkim,akamai.com:email]
X-Rspamd-Queue-Id: 8A41D1935ED
X-Rspamd-Action: no action

--Apple-Mail=_9C4AE783-0867-4BC8-9178-78D39D4E445C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 20 Feb 2026, at 21:08, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Nick Hudson wrote:
>> Enable BPF programs to properly handle GSO state when decapsulating
>> tunneled packets by adding selective GSO flag clearing and a trusted
>> mode for GSO handling.
>>=20
>> New decapsulation flags:
>>=20
>> - BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
>>  (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
>> - BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
>>  (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
>> - BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
>>  IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
>> - BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
>>  IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
>> - BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
>>  SKB_GSO_DODGY when the BPF program is trusted and modifications
>>  are known to be valid
>>=20
>> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
>> renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
>> Run Everywhere) lookups in BPF programs.
>>=20
>> By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
>> gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses this
>> for trusted programs that guarantee GSO correctness.
>>=20
>> Usage example (decapsulating UDP tunnel with IPv4 inner packet):
>>  bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
>>                      BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
>>                      BPF_F_ADJ_ROOM_DECAP_L4_UDP);
>=20
> This patch is doing to much in one patch.

Sure, I=E2=80=99ll split it up.

>=20
> Also not convinced of the need for the NO_DODGY flag.

The reason for NO_DODGY is that, without it, the egress interface will =
see the
SKB_GSO_DODGY flag. In our use case, we want to avoid marking the egress =
tap as
NETIF_F_GSO_ROBUST, so the skb will fail skb_gso_ok() with SKB_GSO_DODGY =
set.
When skb_gso_ok() fails, validate_xmit_skb() calls skb_gso_segment().

>=20
>> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Josh Hunt <johunt@akamai.com>
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>> ---
>> include/uapi/linux/bpf.h       | 45 +++++++++++++++++++--
>> net/core/filter.c              | 73 =
++++++++++++++++++++++++++++------
>> tools/include/uapi/linux/bpf.h | 45 +++++++++++++++++++--
>> 3 files changed, 145 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index c8d400b7680a..0cb24ab70af7 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3010,8 +3010,42 @@ union bpf_attr {
>>  *
>>  * * **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>>  *  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
>> - *  Indicate the new IP header version after decapsulating the outer
>> - *  IP header. Used when the inner and outer IP versions are =
different.
>> + *  Indicate the new IP header version after decapsulating the
>> + *  outer IP header. Used when the inner and outer IP versions
>> + *  are different. These flags only trigger a protocol change
>> + *  without clearing any tunnel-specific GSO flags.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
>> + *  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
>> + *  when decapsulating a GRE tunnel.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
>> + *  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
>> + *  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
>> + *  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when =
decapsulating
>> + *  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or =
IPv6-in-IPv4).
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
>> + *  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
>> + *  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
>> + *  or IPv4-in-IPv6).
>> + *
>> + * When using the decapsulation flags above, the skb->encapsulation
>> + * flag is automatically cleared if all tunnel-specific GSO flags
>> + * (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
>> + * SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
>> + * removed from the packet. This handles cases where all tunnel
>> + * layers have been decapsulated.
>> + *
>> + * * **BPF_F_ADJ_ROOM_NO_DODGY**:
>> + *  Do not mark the packet as dodgy (untrusted) and preserve
>> + *  the existing gso_segs count. By default, packet modifications
>> + *  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
>> + *  revalidation. This flag is useful when decapsulating the
>> + *  tunnel, the BPF program is trusted, and the modifications
>> + *  are known to be valid.
>>  *
>>  * A call to this helper is susceptible to change the underlying
>>  * packet buffer. Therefore, at load time, all checks on pointers
>> @@ -6209,7 +6243,7 @@ enum {
>> };
>>=20
>> /* BPF_FUNC_skb_adjust_room flags. */
>> -enum {
>> +enum bpf_adj_room_flags {
>> BPF_F_ADJ_ROOM_FIXED_GSO =3D (1ULL << 0),
>> BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 =3D (1ULL << 1),
>> BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 =3D (1ULL << 2),
>> @@ -6219,6 +6253,11 @@ enum {
>> BPF_F_ADJ_ROOM_ENCAP_L2_ETH =3D (1ULL << 6),
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV4 =3D (1ULL << 7),
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV6 =3D (1ULL << 8),
>> + BPF_F_ADJ_ROOM_DECAP_L4_GRE =3D (1ULL << 9),
>> + BPF_F_ADJ_ROOM_DECAP_L4_UDP =3D (1ULL << 10),
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP4 =3D (1ULL << 11),
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP6 =3D (1ULL << 12),
>> + BPF_F_ADJ_ROOM_NO_DODGY =3D (1ULL << 13),
>> };
>>=20
>> enum {
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index ba019ded773d..681dd53ab841 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3484,14 +3484,28 @@ static u32 bpf_skb_net_base_len(const struct =
sk_buff *skb)
>> #define BPF_F_ADJ_ROOM_DECAP_L3_MASK (BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | =
\
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>>=20
>> -#define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
>> - BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>> +#define BPF_F_ADJ_ROOM_DECAP_L4_MASK (BPF_F_ADJ_ROOM_DECAP_L4_UDP | =
\
>> + BPF_F_ADJ_ROOM_DECAP_L4_GRE)
>> +
>> +#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK (BPF_F_ADJ_ROOM_DECAP_IPXIP4 =
| \
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP6)
>> +
>> +#define BPF_F_ADJ_ROOM_ENCAP_MASK (BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>> BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>> BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>> BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
>> BPF_F_ADJ_ROOM_ENCAP_L2( \
>> -  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
>> - BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> +  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>> +
>> +#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>> +
>> +#define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
>> + BPF_F_ADJ_ROOM_ENCAP_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_MASK | \
>> + BPF_F_ADJ_ROOM_NO_CSUM_RESET | \
>> + BPF_F_ADJ_ROOM_NO_DODGY)
>>=20
>> static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 =
len_diff,
>>    u64 flags)
>> @@ -3503,6 +3517,10 @@ static int bpf_skb_net_grow(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> unsigned int gso_type =3D SKB_GSO_DODGY;
>> int ret;
>>=20
>> + if (unlikely(flags & (BPF_F_ADJ_ROOM_DECAP_MASK |
>> +      BPF_F_ADJ_ROOM_NO_DODGY)))
>> + return -EINVAL;
>> +
>> if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
>> /* udp gso_size delineates datagrams, only allow if fixed */
>> if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
>> @@ -3588,8 +3606,10 @@ static int bpf_skb_net_grow(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> if (skb_is_gso(skb)) {
>> struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>>=20
>> - /* Header must be checked, and gso_segs recomputed. */
>> + /* Add tunnel GSO type flags as appropriate. */
>> shinfo->gso_type |=3D gso_type;
>> +
>> + /* Header must be checked, and gso_segs recomputed. */
>> shinfo->gso_segs =3D 0;
>>=20
>> /* Due to header growth, MSS needs to be downgraded.
>> @@ -3610,11 +3630,14 @@ static int bpf_skb_net_grow(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 =
len_diff,
>>      u64 flags)
>> {
>> + bool no_dodgy =3D flags & BPF_F_ADJ_ROOM_NO_DODGY;
>> int ret;
>>=20
>> if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
>>       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
>> -       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>> +       BPF_F_ADJ_ROOM_DECAP_MASK |
>> +       BPF_F_ADJ_ROOM_NO_CSUM_RESET |
>> +       BPF_F_ADJ_ROOM_NO_DODGY)))
>> return -EINVAL;
>>=20
>> if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
>> @@ -3647,9 +3670,36 @@ static int bpf_skb_net_shrink(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>> skb_increase_gso_size(shinfo, len_diff);
>>=20
>> - /* Header must be checked, and gso_segs recomputed. */
>> - shinfo->gso_type |=3D SKB_GSO_DODGY;
>> - shinfo->gso_segs =3D 0;
>> + /* Selective GSO flag clearing based on decap type.
>> + * Only clear the flags for the tunnel layer being removed.
>> + */
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
>> + shinfo->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL |
>> +      SKB_GSO_UDP_TUNNEL_CSUM);
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
>> + shinfo->gso_type &=3D ~(SKB_GSO_GRE |
>> +      SKB_GSO_GRE_CSUM);
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
>> + shinfo->gso_type &=3D ~SKB_GSO_IPXIP4;
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
>> + shinfo->gso_type &=3D ~SKB_GSO_IPXIP6;
>> +
>=20
> Probably check that the flags were set in the first place.

Not sure it matters, but I can add this.

>=20
> And perhaps that length_diff >=3D the minimum length that would match
> tunnel header removal.
>=20
> Basically, maximize guard rails against misuse.

Will add.


>> + /* Clear encapsulation flag only when no tunnel GSO flags remain */
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
>> + if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
>> +  SKB_GSO_UDP_TUNNEL_CSUM |
>> +  SKB_GSO_GRE |
>> +  SKB_GSO_GRE_CSUM |
>> +  SKB_GSO_IPXIP4 |
>> +  SKB_GSO_IPXIP6)))
>> + skb->encapsulation =3D 0;
>> + }
>> +
>> + /* NO_DODGY: preserve gso_segs, don't mark as dodgy. */
>> + if (!no_dodgy) {
>> + shinfo->gso_type |=3D SKB_GSO_DODGY;
>> + shinfo->gso_segs =3D 0;
>> + }
>> }
>>=20
>> return 0;
>> @@ -3709,8 +3759,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff =
*, skb, s32, len_diff,
>> u32 off;
>> int ret;
>>=20
>> - if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
>> -       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>> + if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
>> return -EINVAL;
>> if (unlikely(len_diff_abs > 0xfffU))
>> return -EFAULT;
>> @@ -3729,7 +3778,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff =
*, skb, s32, len_diff,
>> return -ENOTSUPP;
>> }
>>=20
>> - if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
>> if (!shrink)
>> return -EINVAL;
>>=20
>> diff --git a/tools/include/uapi/linux/bpf.h =
b/tools/include/uapi/linux/bpf.h
>> index 5e38b4887de6..664bc8438186 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -3010,8 +3010,42 @@ union bpf_attr {
>>  *
>>  * * **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>>  *  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
>> - *  Indicate the new IP header version after decapsulating the outer
>> - *  IP header. Used when the inner and outer IP versions are =
different.
>> + *  Indicate the new IP header version after decapsulating the
>> + *  outer IP header. Used when the inner and outer IP versions
>> + *  are different. These flags only trigger a protocol change
>> + *  without clearing any tunnel-specific GSO flags.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
>> + *  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
>> + *  when decapsulating a GRE tunnel.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
>> + *  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
>> + *  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
>> + *  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when =
decapsulating
>> + *  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or =
IPv6-in-IPv4).
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
>> + *  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
>> + *  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
>> + *  or IPv4-in-IPv6).
>> + *
>> + * When using the decapsulation flags above, the skb->encapsulation
>> + * flag is automatically cleared if all tunnel-specific GSO flags
>> + * (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
>> + * SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
>> + * removed from the packet. This handles cases where all tunnel
>> + * layers have been decapsulated.
>> + *
>> + * * **BPF_F_ADJ_ROOM_NO_DODGY**:
>> + *  Do not mark the packet as dodgy (untrusted) and preserve
>> + *  the existing gso_segs count. By default, packet modifications
>> + *  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
>> + *  revalidation. This flag is useful when decapsulating the
>> + *  tunnel, the BPF program is trusted, and the modifications
>> + *  are known to be valid.
>>  *
>>  * A call to this helper is susceptible to change the underlying
>>  * packet buffer. Therefore, at load time, all checks on pointers
>> @@ -6209,7 +6243,7 @@ enum {
>> };
>>=20
>> /* BPF_FUNC_skb_adjust_room flags. */
>> -enum {
>> +enum bpf_adj_room_flags {
>> BPF_F_ADJ_ROOM_FIXED_GSO =3D (1ULL << 0),
>> BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 =3D (1ULL << 1),
>> BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 =3D (1ULL << 2),
>> @@ -6219,6 +6253,11 @@ enum {
>> BPF_F_ADJ_ROOM_ENCAP_L2_ETH =3D (1ULL << 6),
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV4 =3D (1ULL << 7),
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV6 =3D (1ULL << 8),
>> + BPF_F_ADJ_ROOM_DECAP_L4_GRE =3D (1ULL << 9),
>> + BPF_F_ADJ_ROOM_DECAP_L4_UDP =3D (1ULL << 10),
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP4 =3D (1ULL << 11),
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP6 =3D (1ULL << 12),
>> + BPF_F_ADJ_ROOM_NO_DODGY =3D (1ULL << 13),
>> };
>>=20
>> enum {
>> --=20
>> 2.34.1
>>=20
>=20
>=20
>=20


--Apple-Mail=_9C4AE783-0867-4BC8-9178-78D39D4E445C
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
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMjI1MDcxMjQ1
WjAvBgkqhkiG9w0BCQQxIgQgIakSb4GBETKYPmrPEwv2poSUA4nFJEmNNgknpfxgPwEwDQYJKoZI
hvcNAQELBQAEggEADqXNn7ujt6SAGNINIJeyAAxGP2CaJzMwYbu9tnILNWQ1073++zi1F5WgY5QO
id/67yCU9ETXJaHTrfuOYsJHbCSrZLNB2NhZd2eXPSAsu0YHVi7z+XXoYCkEnwooHk173V6ZXp5z
nzdkrxSmwGtW0ik9wSG8oYdx/+Xaq3p/YVTwykFQdAV2GjDirPceTkI6g/i99Wk6deumGDhPQVwd
mp6tg0uF5YebxwXRJPj53PnrCNGucVYbZFeWnxLyMB6QooGkNfAD5mVe5Lz+yYLh7UXp9QmWlzYM
M58wejEmzRxZ5MIQjhQSb+4jQK6JsrESWEhyL5gY99w1q1npVfbPQgAAAAAAAA==

--Apple-Mail=_9C4AE783-0867-4BC8-9178-78D39D4E445C--

