Return-Path: <netdev+bounces-259441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BwqE1/5lmn4swIAu9opvQ
	(envelope-from <netdev+bounces-259441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:51:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46915E6D9
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279FF3013264
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8726E3033CF;
	Thu, 19 Feb 2026 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bS0JtW61"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D02D948D;
	Thu, 19 Feb 2026 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501916; cv=fail; b=AKcUrBySM4Fvi9chyZAVz6aw7nRxAVuvydVGHxBQNUCXt0I2RY/DpG5DjXukFdef4oEyzAC4ZbOAWys1i0pQqEoyw8U2EX2ydmTN5bnaWrk4jmwY9ZeLk3kuby66Q0NPewIxiBJP4ONQmSpDl7xFaR7FSEe5qeCr8NSIGlbzyxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501916; c=relaxed/simple;
	bh=od4DPI3TuUqckPfqa90ak9ZILx8sHm7mMmGbXD5w7sw=;
	h=From:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4VveiKawPR7olSCIkdjf+zecwBJavOWNUkh3Yimvw9u6hO5FFpqp6fmu9ZRG9aqNG2K31msqHqvhm9jt+v0KOVNInbCzVn/WyZpr1OfEb8Q3cgmZqga3FFzX6dap+vIRI6oZE3gMtr7eZy0RS9RVnY6vOxubd0sMAHN1UQjKrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=bS0JtW61; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 61JAA2ch1422831;
	Thu, 19 Feb 2026 11:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject; s=jan2016.eng; bh=qDgRZqcWusFTsgTBTUQTlC+k4
	/PbB+jQxEKXrKj23vM=; b=bS0JtW611pl6adYbQOx4Jdg4O8JtY8XRtZJJeJOiC
	Mj5YwimIx1tgNJTGP4DxFH3h2ZKFlUqRTaoZvpgYvFw62uIkNg0WjTjg5t6FlnwZ
	rIV8P2EW2vKx3cv0xrPQPv/Csnu10JY9fWZE5fNRjdeZXUhKtwFDFTX7kXLOJi6O
	ieMLBKf9FxLkYjOUX78LWg1iTb8GMlTatX9yrU50YNeajLELj+EylAJFbWxxB/xe
	zB9D+EO4cnE5DC3yuZGIkI469dI+gGQ8m1O7zB6e/Q3B312XvafLTakXP4lSo9nI
	ZMb974VfCmW5Gom18LH/pTFc/Dw9JVg6tZwDk5AgROPxg==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4cdgkd55rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:50:51 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 61JBmrNw029655;
	Thu, 19 Feb 2026 06:50:50 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4cdgj5x8wt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 06:50:50 -0500 (EST)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Feb 2026 03:50:49 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 19 Feb 2026 03:50:49 -0800
Received: from PH0PR07CU006.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 19 Feb 2026 05:50:48 -0600
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by DS0PR17MB6984.namprd17.prod.outlook.com (2603:10b6:8:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 11:50:38 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 11:50:38 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
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
Thread-Index: AQHcoY0hZ/LRms+hDEmNprgx5i7bw7WJ6MaA
Date: Thu, 19 Feb 2026 11:50:37 +0000
Message-ID: <789D0313-ED17-4DAA-B66F-754654B8EE16@akamai.com>
References: <20260219104710.1490304-1-nhudson@akamai.com>
 <20260219104710.1490304-2-nhudson@akamai.com>
In-Reply-To: <20260219104710.1490304-2-nhudson@akamai.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|DS0PR17MB6984:EE_
x-ms-office365-filtering-correlation-id: ba9dd930-9e2c-4c6d-df8c-08de6fad195e
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|366016|376014|7416014|10070799003|1800799024|38070700021|4053099003;
x-microsoft-antispam-message-info: =?us-ascii?Q?ew2muWqIqlubfh9FjkWIC3M2v3M+Ddg9pY3SS7a6ZXGFFXVEfttnE2BpfG30?=
 =?us-ascii?Q?hotdeMM7zYolmhEJyVtZMd7WRlMyIPgA7MPNs6xDau6QIt/dkSQqb671tdGU?=
 =?us-ascii?Q?dzx4dAlfTPL/LD4okTNxdRQ6wZ/B259BaSTRnxPzeA999k4ahEAWskcc8imc?=
 =?us-ascii?Q?MjYOkhLbwQPEJX2OHb0tzTQ6/F/ly2Q43f2OwaJ1aYkFnX1OCEHVUyEBdZ1i?=
 =?us-ascii?Q?6ZeYO8SPsZBl5af9zjG+n6kGde14B/elWnXP5REHynZ7kCxODtFKBa47yCl3?=
 =?us-ascii?Q?M4IyyJZK9PBmk/iKO66LJRM+BLPvBB7Nxu++/AhmVedICsmyVhU9zpiPkpox?=
 =?us-ascii?Q?7PvrwR8jfY9gcuWUP3xII3anZXhxTJhncrQPuxhnMMKdU38e5ZKmzQopzooX?=
 =?us-ascii?Q?8hdMadQw3R6Ece609osTKnX54RzgnAUVwBFiSRdBZ3MaQrf3rarh3z1gFFyw?=
 =?us-ascii?Q?sbGB21VZLNkzuSSHlhGdYTnCJl8d0wn4zN4xMdt+o8Lsg1QHfPWjocRR67PZ?=
 =?us-ascii?Q?yxDlK6S5pa5YugXjyhLCPSZDtbJLWObltBsEzalxZHlytvqCu/w7Zgu4fgKW?=
 =?us-ascii?Q?x7PAJZkajByP6Svf98jcFeZWmvP7N8TdlvHkKj8znLcO+kR217DECwj6URHr?=
 =?us-ascii?Q?JqZ62G/IEOI2tnXJ4+dKqOjs4QyJczjfmgMTFIBmsqqebHXHnkxs761T4xaZ?=
 =?us-ascii?Q?X8XA3iLReZzv0qVArtXK7Pk0l8+as6GNMgJkkKpteQZcJdEWOkDI1YZgjMXx?=
 =?us-ascii?Q?SbF+p+Xd9rD2E5iy7xJSQ7cbApMTEhDT0v52GfBeFyBVGnir2YYtda9RnIuQ?=
 =?us-ascii?Q?OXkzDNrGhtlWsoLFJRpPOmtk5X3X3i7c01xOvHfyj+TTjm0+Xg0r/rItUfaA?=
 =?us-ascii?Q?3pI98icePfCSHJriUXF+OAJ6EhgIjl8ZA/db8jYbp1P0ToVMfEO8s4QWXeqB?=
 =?us-ascii?Q?UXsZ5z5atZY/Y6YUD2A/cBL6uwpW60JkzAEtWXRhikERl5i4Kq7YzPuPiZHn?=
 =?us-ascii?Q?2UrjFxbwf2n/fLEL8t/CYAM7A3t+42DXvafhQkKB5GVDX/Rl7lEq5GCh9MWJ?=
 =?us-ascii?Q?u9fWUKMRS1AVattJCN1BTb2gbhk7rO2Cxlo1ul2+VMlSahH/pENa0lcXt5h1?=
 =?us-ascii?Q?tQ7NjSQjd9HJ1I1gRAPuVG5gXaD1OUQRv+YduPBLB9WiJ6ElZ5EHkUMf235V?=
 =?us-ascii?Q?U8z6ulUdGw6K3Fkq70D+tT4j20wqhKurAeLa+TGlTXFxtj0EkJKYTbvv05Ii?=
 =?us-ascii?Q?cQQD+t93FpkszmtA6eSzMpqha4rqS/MCJjwc4A3yUqW/WRlMxXWaXMOpDaMx?=
 =?us-ascii?Q?6RoHJHUBaWdyHJf5VOYcLkfyn6Y+9R+8jXFrqQcj3BqPv09WtOL8AfNcdknb?=
 =?us-ascii?Q?e6FlG7IvZ8XHUJfzNX9SP9/j8Q9N7bHXJJWdKvZT8T30fYRSVE5vdPisy5NE?=
 =?us-ascii?Q?rz77CNN4IpHynIHy7ldXQTu4/FBe2pXuxizXRUHIIcCcBinaD6MB/N+Z9KZ2?=
 =?us-ascii?Q?q3sSPw4dxa70SvuTwEk+UjLuE1asx/3mkV8D88C6J2dgIEICeonCPW2pMZcB?=
 =?us-ascii?Q?7T3QTBRpx+EtxYsGBecOdLWC8sS5it/Kl8C4VtejbGvFPT+WS9rGVYcm9EJp?=
 =?us-ascii?Q?Z/ydFfYfm56BJ3glrcp9X7Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(376014)(7416014)(10070799003)(1800799024)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jwcpcA28rdBB52ltiiFSLB3PFqcmktmOcaObCMpXHOjZoEvFuAhvav97Gzzd?=
 =?us-ascii?Q?Sy6oHTAwEr5Y6pXmJ/MnoN0YSklYRFBlGZ1sB26LwvjvS15Yy/5a0ie6DTpE?=
 =?us-ascii?Q?GWvMi3m2kqzyYDgUyNsLGgNXCBCo/XA+L63585Em9s/Iq6a2jh53parVRXKO?=
 =?us-ascii?Q?Dl0vejLCoymld2XHoEzDpW0X9R45WTNUYhlVa2BBw+uL7iE1X+MRRGE+w9rS?=
 =?us-ascii?Q?aGtTPcZZ5tinwbTHxAOapCgabXqlQHbG0DchfRVkMH0s6k4nioAbqaghfbr/?=
 =?us-ascii?Q?R2sAvE0R1g7NULLeYwOphCJkxnqsQ55j5uWeEk/wf9cNxyT0oqYjMcagqI1a?=
 =?us-ascii?Q?XxPSA6GeyyaZd3myrE5AWPuEjGk2lfVaWsUbjT2JdDL2nThdZFMFzVYuTj0H?=
 =?us-ascii?Q?ztd8aloxGdfdTVOV6NSHLOl9nbjGcRC9yjBUWgLXIakqZ9iTOjEfMW8QqhNO?=
 =?us-ascii?Q?AAIC9D8fycdfXogCj5nkTQoV+BBEr572kjzUI9BPDNb6qFaOiRs8yc8kVl3k?=
 =?us-ascii?Q?GQoWZhGdxWpaWpHIM+smMMsrFfKXhlzr35GUnvZrSA+grnpZUhHPbz9kEemF?=
 =?us-ascii?Q?NcISVzn5+KoxEqpLcgBWV9DGQBKSs2MsvRdbQU8Y3B436Whee7Cd1k9VtP6D?=
 =?us-ascii?Q?mTX6QVJ+w0yR9Ih7IUJfxEiIGWX2uBSclG9Y+daurSJlLwsg92+9wKrwclRM?=
 =?us-ascii?Q?jTZVnDe27iONqHO9wqUvMBXfpuiIzsbVG7uKOdc+A5Hne76Nb4OH0q7+ncl+?=
 =?us-ascii?Q?tiIsUoChF7RuBIYLNTWFGURQlwi8rx5DXrbzySvz3pZ4o8A0QhcXVTvlz+w0?=
 =?us-ascii?Q?q2hVx5rP+lljFfINn2aDf3lIh6SpsLYmE2M2KWeDIJeMtfINIZghJP7BOBht?=
 =?us-ascii?Q?aag+Blx5GGE6iDjPtqwG2mcSRkAskroc4pOLc9RJK3pwI9NSrjIT27L7Vcio?=
 =?us-ascii?Q?yJ3NqIuSMX/pmsLThdrqwMM6hcY7CeO24PGzPcUsatr2DQXhQjoXq7W5P19h?=
 =?us-ascii?Q?/OJFEYDXeEiG+g8Lmby9BWOZKwIvyWznCWxISX94QwiwGPfsuipKa6yi4QLp?=
 =?us-ascii?Q?DAb3TT/E1iDsFbLO7vPSkOSLJ27iIOPMWAmMvyWKGiFW5MyEPJfJwAY/Ms5E?=
 =?us-ascii?Q?huv8IeFdG3i0KNogyvTz8Sti9RksE72CSvHjIF8XvGpPM2DvTGCaVHG1N+Kv?=
 =?us-ascii?Q?2NMqVm94j0FvQvrRmuh2yNEWSpK2F3WInPmpmDnYKsFEFhoeKjCR3mvzfHbO?=
 =?us-ascii?Q?D+xSRcDfpA+f7S8rh4l/SOR6TzTmidTD8QmTakLJF1HxKIbNCrcVTp+h/4Qa?=
 =?us-ascii?Q?wfT3aWGIPjfvaIIgYpyXTPCg/0IH6vTWpOTC8iBJ/PluHf5r/D8fvpL48Lof?=
 =?us-ascii?Q?iXzHGkIApaFhY8PGo5hJez89mdCdE+KE+1OC9q2z2C9HRrpl/NfGjO0BzcnR?=
 =?us-ascii?Q?YLWDVXUU2xHSdmsqZ8fxfzftm2WxCDJqcl/wnRpfYVUag0E7hpfJMHr6j+KO?=
 =?us-ascii?Q?FFp1eKZd9KGOPHPSVG8QN8QRx6cHXpq6U5AvJDqfKR4NAuHlep3e3VrRTZCL?=
 =?us-ascii?Q?cdJlcvohc9v9jpC2jSicy74YNkz0Dur5TSmz3XHpi7LzJrK+Af3EpashT5QY?=
 =?us-ascii?Q?n3zfuAT4WXpTHgIYjKFe5q9w3BWM609GrjUGWEfq0+GFz1ZecIX3r02Yu3pZ?=
 =?us-ascii?Q?2MQ2UCSk+Qrrk/jDKdAUBUCwmuofP9c0WbTZDvV7g1AR0bORfIqnkPbRXCvC?=
 =?us-ascii?Q?fyiKJXP5prYU6+F3LBbCsa/eoEYqDhDoTz39+W18I+sSAfUCy3CUVlozEtXg?=
x-ms-exchange-antispam-messagedata-1: uH+NZZmBLZqVzw==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN0AD1qApkelJzhU2+UeBZi32t5S6pgbLNQqzPOIKCj71m8u+HlHrQ0OiUr1U9I4p/5R70pIwk1nMixqj+hszMdsqsULfXPbElY1HQUR4fWhRhWzdJchjFedIKKT3Mt9ZgnP8AvV2hO62Y1mxoQPWsSvOGUrYdDdlUvykJDgEj/i3L91qVed/l+TiD9HMz+1CEG3mbbDyz887BK2k/MlIH4Q/IAFokdkHKgCSmGtEZUoQqgcUFY/wiKinboPSxb0UIHfFtwatUsWK3BV1p6OjjLahWdIXWwy5bwski0UrEh9KQ9thHmMIf+8tDhA7wuWhvzmq8xJKrJxP1m2tkwSmg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCszBgZbfkjtjY5/8w2D+YGCMgJxNAPPWoXNMIhuFSY=;
 b=xluxKiRzZ536NbJKUONdjKphR7umJvMQqIT9zv73pCxe52ZbWgbvf1QtMuhsBzQ40aKWZmG6PviS2Rgok7Gzs/SecLeg1c9XKz6zZrw9pJCXI5HFig8TJ0T/GBCcM4bIpNzvWv2LctmwmgDJUXuaEeSNfU4/MyaM/Nlv9YXKRfqCHva1r44yPwOf2G3HUYN40N0l77f+T5a73CXIeTM9P1TaO+FdTdI+vb9vuE+c56pXdJHrKfDMyRToZAe1kfNbDG2+/QSEhJifhli7AeFYTGd7dgZ54z5biRrNpJFqrpjwoBu9OJF4yLjIa5wuCFpiGfOHn89l3CTnks+JIqnkAg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: ba9dd930-9e2c-4c6d-df8c-08de6fad195e
x-ms-exchange-crosstenant-originalarrivaltime: 19 Feb 2026 11:50:37.8299 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 8Aa/oicwycNN4Ws/U/QrDpL8Utq01uAd13xdysttTQmcDCiq2Y4JRnAvAjDAtyniLqfqPj9eu5+16Wynh+pr/A==
x-ms-exchange-transport-crosstenantheadersstamped: DS0PR17MB6984
Content-Type: multipart/signed;
	boundary="Apple-Mail=_EAF65E0C-F700-4A67-AE64-E5934A133FF5";
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
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2602130000 definitions=main-2602190108
X-Authority-Analysis: v=2.4 cv=OfmVzxTY c=1 sm=1 tr=0 ts=6996f91c cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=9cW_t1CCXrUA:10 a=xqWC_Br6kY4A:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=X7Ea-ya5AAAA:8 a=hS5sWhnxYhlpVAkMqwUA:9
 a=CjuIK1q_8ugA:10 a=wqFnSJPP-FBafd8uH9cA:9 a=ZVk8-NSrHBgA:10
 a=30ssDGKg3p0A:10
X-Proofpoint-GUID: 28CCYjeF6MeyAFKJwWEa-WhZieNSaYp3
X-Proofpoint-ORIG-GUID: 28CCYjeF6MeyAFKJwWEa-WhZieNSaYp3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEwOCBTYWx0ZWRfX/2Kw86Gp+Qln
 9SYe9ceiSFcELrNkRc+2yJzXmH9xpgqH2nemsFJCrL4qNwCLh7xO8OZajVhIxLwLkqCqvtUXaB/
 0bDsn6vaijnrhkpYq0MES56BmPJx1BVU3aWRMXqor/GGlVkxONzpQzvhsBlonH3Q/s+Tx8uqpNy
 tSe+r3b2Tj00OvdF6t16C9CxPz24cb+V+KRQQo7fWWV40v5eOQrrohjzIIGoRAvT9EkGVS65vsF
 1AgD3Vc1eyo/RzxNlcbz1KpFLrXpCmxCSyTzUJh+sEjALO/X+zJpn1i2QSP3eoacvb5CpXQoP5g
 CeWpO9e3jJEHItfEL7M5W9veyXOnDxevHiq/IgenRTdj/gz+sAtFoCDBP3rexzLbK5VWlSLUxZs
 uxbaPx77gUwf+PMNQ5fEQU5T3TE0+tz7mv1JgyZc/izfgXfIPbjxyBKLQE/rSqsHNXXWGa2ePqI
 LgLAr/Zb5EawpBBob/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.24 / 15.00];
	SIGNED_SMIME(-2.00)[];
	MISSING_TO(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259441-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[akamai.com:+];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,meta.com,distanz.ch,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:mid,akamai.com:dkim,akamai.com:email]
X-Rspamd-Queue-Id: 9A46915E6D9
X-Rspamd-Action: no action

--Apple-Mail=_EAF65E0C-F700-4A67-AE64-E5934A133FF5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

[still learning git send-email]

This was supposed to be sent with this:


Our use case involves a BPF program that removes VXLAN headers from
packets that are subsequently forwarded via a tap interface. The new
flags allow the BPF program to strip the tunnel header and selectively
clear the tunnel-specific GSO state. This allows larget packets to be
forwarded without segmentation through the (non-robust) tap interface
for the decapsulated packets.



> On 19 Feb 2026, at 10:47, Nick Hudson <nhudson@akamai.com> wrote:
>=20
> Enable BPF programs to properly handle GSO state when decapsulating
> tunneled packets by adding selective GSO flag clearing and a trusted
> mode for GSO handling.
>=20
> New decapsulation flags:
>=20
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
>  (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
>  (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
>  IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
>  IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
> - BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
>  SKB_GSO_DODGY when the BPF program is trusted and modifications
>  are known to be valid
>=20
> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
> Run Everywhere) lookups in BPF programs.
>=20
> By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
> gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses this
> for trusted programs that guarantee GSO correctness.
>=20
> Usage example (decapsulating UDP tunnel with IPv4 inner packet):
>  bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
>                      BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
>                      BPF_F_ADJ_ROOM_DECAP_L4_UDP);
>=20
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
> include/uapi/linux/bpf.h       | 45 +++++++++++++++++++--
> net/core/filter.c              | 73 ++++++++++++++++++++++++++++------
> tools/include/uapi/linux/bpf.h | 45 +++++++++++++++++++--
> 3 files changed, 145 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c8d400b7680a..0cb24ab70af7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3010,8 +3010,42 @@ union bpf_attr {
>  *
>  * * **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>  *  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
> - *  Indicate the new IP header version after decapsulating the outer
> - *  IP header. Used when the inner and outer IP versions are =
different.
> + *  Indicate the new IP header version after decapsulating the
> + *  outer IP header. Used when the inner and outer IP versions
> + *  are different. These flags only trigger a protocol change
> + *  without clearing any tunnel-specific GSO flags.
> + *
> + * * **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
> + *  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
> + *  when decapsulating a GRE tunnel.
> + *
> + * * **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
> + *  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
> + *  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
> + *
> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
> + *  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when =
decapsulating
> + *  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or =
IPv6-in-IPv4).
> + *
> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
> + *  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
> + *  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
> + *  or IPv4-in-IPv6).
> + *
> + * When using the decapsulation flags above, the skb->encapsulation
> + * flag is automatically cleared if all tunnel-specific GSO flags
> + * (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
> + * SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
> + * removed from the packet. This handles cases where all tunnel
> + * layers have been decapsulated.
> + *
> + * * **BPF_F_ADJ_ROOM_NO_DODGY**:
> + *  Do not mark the packet as dodgy (untrusted) and preserve
> + *  the existing gso_segs count. By default, packet modifications
> + *  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
> + *  revalidation. This flag is useful when decapsulating the
> + *  tunnel, the BPF program is trusted, and the modifications
> + *  are known to be valid.
>  *
>  * A call to this helper is susceptible to change the underlying
>  * packet buffer. Therefore, at load time, all checks on pointers
> @@ -6209,7 +6243,7 @@ enum {
> };
>=20
> /* BPF_FUNC_skb_adjust_room flags. */
> -enum {
> +enum bpf_adj_room_flags {
> BPF_F_ADJ_ROOM_FIXED_GSO =3D (1ULL << 0),
> BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 =3D (1ULL << 1),
> BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 =3D (1ULL << 2),
> @@ -6219,6 +6253,11 @@ enum {
> BPF_F_ADJ_ROOM_ENCAP_L2_ETH =3D (1ULL << 6),
> BPF_F_ADJ_ROOM_DECAP_L3_IPV4 =3D (1ULL << 7),
> BPF_F_ADJ_ROOM_DECAP_L3_IPV6 =3D (1ULL << 8),
> + BPF_F_ADJ_ROOM_DECAP_L4_GRE =3D (1ULL << 9),
> + BPF_F_ADJ_ROOM_DECAP_L4_UDP =3D (1ULL << 10),
> + BPF_F_ADJ_ROOM_DECAP_IPXIP4 =3D (1ULL << 11),
> + BPF_F_ADJ_ROOM_DECAP_IPXIP6 =3D (1ULL << 12),
> + BPF_F_ADJ_ROOM_NO_DODGY =3D (1ULL << 13),
> };
>=20
> enum {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ba019ded773d..681dd53ab841 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3484,14 +3484,28 @@ static u32 bpf_skb_net_base_len(const struct =
sk_buff *skb)
> #define BPF_F_ADJ_ROOM_DECAP_L3_MASK (BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
> BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>=20
> -#define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
> - BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
> +#define BPF_F_ADJ_ROOM_DECAP_L4_MASK (BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
> + BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +
> +#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK (BPF_F_ADJ_ROOM_DECAP_IPXIP4 =
| \
> + BPF_F_ADJ_ROOM_DECAP_IPXIP6)
> +
> +#define BPF_F_ADJ_ROOM_ENCAP_MASK (BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
> BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
> BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
> BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
> BPF_F_ADJ_ROOM_ENCAP_L2( \
> -  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
> - BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +  BPF_ADJ_ROOM_ENCAP_L2_MASK))
> +
> +#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
> + BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
> + BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> +
> +#define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
> + BPF_F_ADJ_ROOM_ENCAP_MASK | \
> + BPF_F_ADJ_ROOM_DECAP_MASK | \
> + BPF_F_ADJ_ROOM_NO_CSUM_RESET | \
> + BPF_F_ADJ_ROOM_NO_DODGY)
>=20
> static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 =
len_diff,
>    u64 flags)
> @@ -3503,6 +3517,10 @@ static int bpf_skb_net_grow(struct sk_buff =
*skb, u32 off, u32 len_diff,
> unsigned int gso_type =3D SKB_GSO_DODGY;
> int ret;
>=20
> + if (unlikely(flags & (BPF_F_ADJ_ROOM_DECAP_MASK |
> +      BPF_F_ADJ_ROOM_NO_DODGY)))
> + return -EINVAL;
> +
> if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
> /* udp gso_size delineates datagrams, only allow if fixed */
> if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
> @@ -3588,8 +3606,10 @@ static int bpf_skb_net_grow(struct sk_buff =
*skb, u32 off, u32 len_diff,
> if (skb_is_gso(skb)) {
> struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>=20
> - /* Header must be checked, and gso_segs recomputed. */
> + /* Add tunnel GSO type flags as appropriate. */
> shinfo->gso_type |=3D gso_type;
> +
> + /* Header must be checked, and gso_segs recomputed. */
> shinfo->gso_segs =3D 0;
>=20
> /* Due to header growth, MSS needs to be downgraded.
> @@ -3610,11 +3630,14 @@ static int bpf_skb_net_grow(struct sk_buff =
*skb, u32 off, u32 len_diff,
> static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 =
len_diff,
>      u64 flags)
> {
> + bool no_dodgy =3D flags & BPF_F_ADJ_ROOM_NO_DODGY;
> int ret;
>=20
> if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
>       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
> -       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
> +       BPF_F_ADJ_ROOM_DECAP_MASK |
> +       BPF_F_ADJ_ROOM_NO_CSUM_RESET |
> +       BPF_F_ADJ_ROOM_NO_DODGY)))
> return -EINVAL;
>=20
> if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
> @@ -3647,9 +3670,36 @@ static int bpf_skb_net_shrink(struct sk_buff =
*skb, u32 off, u32 len_diff,
> if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
> skb_increase_gso_size(shinfo, len_diff);
>=20
> - /* Header must be checked, and gso_segs recomputed. */
> - shinfo->gso_type |=3D SKB_GSO_DODGY;
> - shinfo->gso_segs =3D 0;
> + /* Selective GSO flag clearing based on decap type.
> + * Only clear the flags for the tunnel layer being removed.
> + */
> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> + shinfo->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL |
> +      SKB_GSO_UDP_TUNNEL_CSUM);
> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> + shinfo->gso_type &=3D ~(SKB_GSO_GRE |
> +      SKB_GSO_GRE_CSUM);
> + if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
> + shinfo->gso_type &=3D ~SKB_GSO_IPXIP4;
> + if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
> + shinfo->gso_type &=3D ~SKB_GSO_IPXIP6;
> +
> + /* Clear encapsulation flag only when no tunnel GSO flags remain */
> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> + if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +  SKB_GSO_UDP_TUNNEL_CSUM |
> +  SKB_GSO_GRE |
> +  SKB_GSO_GRE_CSUM |
> +  SKB_GSO_IPXIP4 |
> +  SKB_GSO_IPXIP6)))
> + skb->encapsulation =3D 0;
> + }
> +
> + /* NO_DODGY: preserve gso_segs, don't mark as dodgy. */
> + if (!no_dodgy) {
> + shinfo->gso_type |=3D SKB_GSO_DODGY;
> + shinfo->gso_segs =3D 0;
> + }
> }
>=20
> return 0;
> @@ -3709,8 +3759,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff =
*, skb, s32, len_diff,
> u32 off;
> int ret;
>=20
> - if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
> -       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
> + if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
> return -EINVAL;
> if (unlikely(len_diff_abs > 0xfffU))
> return -EFAULT;
> @@ -3729,7 +3778,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff =
*, skb, s32, len_diff,
> return -ENOTSUPP;
> }
>=20
> - if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> if (!shrink)
> return -EINVAL;
>=20
> diff --git a/tools/include/uapi/linux/bpf.h =
b/tools/include/uapi/linux/bpf.h
> index 5e38b4887de6..664bc8438186 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3010,8 +3010,42 @@ union bpf_attr {
>  *
>  * * **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>  *  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
> - *  Indicate the new IP header version after decapsulating the outer
> - *  IP header. Used when the inner and outer IP versions are =
different.
> + *  Indicate the new IP header version after decapsulating the
> + *  outer IP header. Used when the inner and outer IP versions
> + *  are different. These flags only trigger a protocol change
> + *  without clearing any tunnel-specific GSO flags.
> + *
> + * * **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
> + *  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
> + *  when decapsulating a GRE tunnel.
> + *
> + * * **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
> + *  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
> + *  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
> + *
> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
> + *  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when =
decapsulating
> + *  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or =
IPv6-in-IPv4).
> + *
> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
> + *  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
> + *  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
> + *  or IPv4-in-IPv6).
> + *
> + * When using the decapsulation flags above, the skb->encapsulation
> + * flag is automatically cleared if all tunnel-specific GSO flags
> + * (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
> + * SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
> + * removed from the packet. This handles cases where all tunnel
> + * layers have been decapsulated.
> + *
> + * * **BPF_F_ADJ_ROOM_NO_DODGY**:
> + *  Do not mark the packet as dodgy (untrusted) and preserve
> + *  the existing gso_segs count. By default, packet modifications
> + *  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
> + *  revalidation. This flag is useful when decapsulating the
> + *  tunnel, the BPF program is trusted, and the modifications
> + *  are known to be valid.
>  *
>  * A call to this helper is susceptible to change the underlying
>  * packet buffer. Therefore, at load time, all checks on pointers
> @@ -6209,7 +6243,7 @@ enum {
> };
>=20
> /* BPF_FUNC_skb_adjust_room flags. */
> -enum {
> +enum bpf_adj_room_flags {
> BPF_F_ADJ_ROOM_FIXED_GSO =3D (1ULL << 0),
> BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 =3D (1ULL << 1),
> BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 =3D (1ULL << 2),
> @@ -6219,6 +6253,11 @@ enum {
> BPF_F_ADJ_ROOM_ENCAP_L2_ETH =3D (1ULL << 6),
> BPF_F_ADJ_ROOM_DECAP_L3_IPV4 =3D (1ULL << 7),
> BPF_F_ADJ_ROOM_DECAP_L3_IPV6 =3D (1ULL << 8),
> + BPF_F_ADJ_ROOM_DECAP_L4_GRE =3D (1ULL << 9),
> + BPF_F_ADJ_ROOM_DECAP_L4_UDP =3D (1ULL << 10),
> + BPF_F_ADJ_ROOM_DECAP_IPXIP4 =3D (1ULL << 11),
> + BPF_F_ADJ_ROOM_DECAP_IPXIP6 =3D (1ULL << 12),
> + BPF_F_ADJ_ROOM_NO_DODGY =3D (1ULL << 13),
> };
>=20
> enum {
> --=20
> 2.34.1
>=20


--Apple-Mail=_EAF65E0C-F700-4A67-AE64-E5934A133FF5
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
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMjE5MTE1MDI3
WjAvBgkqhkiG9w0BCQQxIgQgMMnumrvK1UAJjtHYFPI6QnFy2MMfJ2uMD51hpl6Uy0gwDQYJKoZI
hvcNAQELBQAEggEAFWGoMZzFTBn4YuhnOblZPb6HtVnM5c4AsHAWI/GK3EQmdLqUFsYpiSEqV59c
DpavG9ItAKfG7fI8Zbojg8jN4SH7+KgtjQtpM0rdv5dpkEWSHA4saMbIiSkUrLmk8to3z5kDHfaM
iSLBk5wtBvaWsOBl7BDFkaW5dIo8POr9fARPpSysJ6XjSg3IeY4JJp4epkQgcZ3FM9pof3zXnnI5
Zo07lFEGuXtDK5GXevgwfMLED5HXFlJaPq2lcUOBpUFnpkjjJ1Ml208z7XhqcN17LGqrF7RecGYU
jCp35yA2vMAQ7Doo4uUFQqacyYEnErQaKv/yUAsmhXvA2RM7vDCOhwAAAAAAAA==

--Apple-Mail=_EAF65E0C-F700-4A67-AE64-E5934A133FF5--

