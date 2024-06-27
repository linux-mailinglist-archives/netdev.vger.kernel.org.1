Return-Path: <netdev+bounces-107495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F344C91B2F8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAC6B2366E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABF1A2FB7;
	Thu, 27 Jun 2024 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="R0qTe18F"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C413E04F
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532419; cv=fail; b=mPSxE2i8kBpnzCclqm32FFEDh4mP9jEmK9usIHKVNsBCb/KqFZQ4p0yvCE4nI6Z9eY9hbWHDYk3FradDtl3gTYPT6UsftchAozCcpPgs72T9msba4Dxt00PXcd11nCvnxBz3QRFBZ9vod8MXj748ihr0rNQWuRLJSt1t77C/sJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532419; c=relaxed/simple;
	bh=HojZeE1kRMSsEFRS49En1LU7PEBB6WAxDX4xXbghzRo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVP5b9F4Bvkz0edr7KD3JSqG8LDPB5B68kKhuDuVjiVuaORXhfdl+Q8DKMD0eWY6R3hv4BHCe+UbPbtVR7dSZyVcUtxle3OO9zqtZ6hSQgpJFhFhDi2hJpg+3UEfzi3tUUiv1XQzfstGK1LY/iwBoTLbLBqA/37MdPCJy+tEMfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=R0qTe18F; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFRuDT007683
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=LdlZbCbvg
	Xk6Ker6B+emQerttpQuTYADnUsehPhTIdo=; b=R0qTe18FuKjIpOFFh59dPnyX+
	Md63SNdFVjOxbLCZe+uVJHqaTjZwOalTEDGal+csfAax3mSfbWKnYVeCnjwnbxrB
	w7o57r2MbMFCccZJx6mFyWfF+A0YVjqZ9Gijf+3ipScGeawg5PXBsfNnebJ/Qpu+
	dJxwS325IVkh9jAEkP+MCGLUCUstBbmNUktbae+b5kmZUHlxRNTSrQBe6VszO+Ad
	V+qKdIMLGu436ZUFZo1TAzzNzYq/bDB6x78ibDqY9+Ezmi8OLRFAJa27SvZsWe0P
	7IJNzcf8+P06PGDhdb2cVXYoYTtZYpc8Hpg+3sDYnpir1tVGQ8B5UFMgMsr/Q==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 401ar9u5kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:53:35 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E932B800273
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:53:34 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Jun 2024 11:53:24 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Jun 2024 11:53:23 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 27 Jun 2024 11:53:23 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Jun 2024 23:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXoem+enmvCTu+/R8j/JUXlHqFTtNFFhc9b96avB2r3WIy8y3BqQiiPb7i9INXt8JiSD2DOIzuj1djuWVBZXyNY/Zx9+pZfw+xCyvxTrxMq9BS10k+Pel+5KPkNHN+W2klJdqte2DtJKxDNZ+5Kq/WsNTRkwxxxaNUlWnTT6JEl3GiREpt0gOWAoVJeSLsfUym5Q5EG7Dpwl1IxgOJLjWetl/lTIFZPbEOSlIc8q9XcWl3E4gEbvEZiXo0VI/At7RUAoNVkI1c1Bocv6DLX0N/pZBVUOp6K+/vZ97O/uYqg+Tf1Q/Mv5zEMfTZ2W7ueJEYsrXxOtLupq6W8S0XjO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf8RLnX7f61UZUz5xzGrKWEa+eb4sI/qr8sCVbBp+lo=;
 b=FekfRoUWexIpqcqfDYFDNDDKnMaTGVcpRBXv11DDheMy9Y3fVQquIxEWvSbyXBro6LIxJS+zZPqr7lCFN0xqIpQQeGZBSu46s/IgDcI6YS/y6+b+mjduy4kzQW0CPuPlL6ybBatnXN85yMDQwhCjJ/JcOn3eXWFvWf0WlhRVqkP/HMZ2FW4eJzobVS473nX8ZkK1WepZ2RkFytiRw0sVJPdP28zOQ+zNrNrygajHNd8yB1IcvPhS21QvDTJ81XU+ywthRWL8uxnuhjO6P5LcjRXCMRATh+R67fzqAyHxjN2yjseNMoVPKodPA6DaSay5jwLUdmaCLYZoOokli/1Xgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by MW4PR84MB2260.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 27 Jun
 2024 23:53:21 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 23:53:21 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Wrong nexthop selection with two default routers where only one is
 REACHABLE
Thread-Topic: Wrong nexthop selection with two default routers where only one
 is REACHABLE
Thread-Index: AdrI3Ac1b2vGLJ7ISKW1gwaXZUwZkAAD/a/A
Date: Thu, 27 Jun 2024 23:53:21 +0000
Message-ID: <SJ0PR84MB20881BEC4AC4703A84425045D8D72@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB20888BE1E39FC9536CDC3BCAD8D72@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <SJ0PR84MB20888BE1E39FC9536CDC3BCAD8D72@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|MW4PR84MB2260:EE_
x-ms-office365-filtering-correlation-id: c3dccc7c-63a5-43be-5f65-08dc9704535e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3xhIH87FX6HLaGWZO/gVFNwJYJkyCUOZCGBM4t1vybPojXjGpn/ByXzWCH?=
 =?iso-8859-1?Q?TyTb35Vy0AL4aGqvm6erz1JucGj25Vpwzs37yCQc2QmuEr3v23ybU+fqfc?=
 =?iso-8859-1?Q?9UFodjd8oVxDp/u6+LrV4PnhR6dIDU6fPu+5KS7WXF5WwPb+LyjEenkg6Q?=
 =?iso-8859-1?Q?1ZkwHgKYUh2DVAQruzIqV3o3EHUM6talOPKgGYSg4Ne5NsJeXU/KiVPPg1?=
 =?iso-8859-1?Q?AYNb+VrUMytl+eCaS5lHCn8eg1mRvt7Wh3gfCt0vLgJs2c69CTGcEkyJ5N?=
 =?iso-8859-1?Q?WqaPNFg5tO0T0j/+rsdE/178TeJMlv9wq/V79xNMTcWtxEuFNz5ReUyEY2?=
 =?iso-8859-1?Q?R30xvn2V8Ap1fkU5FHuZIX8EBIrl1cQ90kj1eEjjhmqG8s7Td2KMtMwJnH?=
 =?iso-8859-1?Q?BoEF8JBApoTR331wLNaH+tcX+5bmiNu/w5ULzffAdNkhC2IQ6oN21Uvo0z?=
 =?iso-8859-1?Q?Dw5g3AXi5kY1/RDYj2YP4P+KA1VWRf1LIBWVJJ0umYOF39LLE4NgHlSp3O?=
 =?iso-8859-1?Q?F100BPgIKLB37aOd3E7nhpefZ+J5pXuXcHqelf5A8zV2tgIKSvBt1MNAJz?=
 =?iso-8859-1?Q?gxErbj10P4I270BRwYa5Mc6rXfWTO5/YHh/BIyw5tXnKFwwnbCbP+EMGd7?=
 =?iso-8859-1?Q?jzrUjZjeXc6X6yLKZ0VwIWV1ExrMfC91rlZvOzXx3oZmqK5SQdJL4NIjp/?=
 =?iso-8859-1?Q?oP2w6kDOj1UR/yBL1XS/TFWAjFzZb40TsBoD+hTJT0o3Zp09NL2A3v01uE?=
 =?iso-8859-1?Q?0J9Q4B1hVbaCi06XkJEupUPwcfqdCe1d3GD/5Mervj43pt86LjqNK4iOaC?=
 =?iso-8859-1?Q?9/o0KUzFZag8rSGcev8dl0OeiEQGHbKERabCVmIFZMJH7BeTKzuyQ5sRKn?=
 =?iso-8859-1?Q?8R0XFG/AgLO81ugizNtddl5bv84ftBZvGZLy4HGv5tqYVQbqfej++WUs/K?=
 =?iso-8859-1?Q?jHLP/IHhYAIqZBtwBGWnuB+WZsOuyBxAfBg3YcK2B1xxCcqJxRwHicq9U8?=
 =?iso-8859-1?Q?XYbinMv9R/JsXBeBci9VnWw0Wv1HANrBsKXeOMo7pZo2x3oY57wl6nP/h2?=
 =?iso-8859-1?Q?lfFb1K+UIBQUWUc8fWyhWo1UdBDKpTTVAF6RFK67vMkr9D2UkK2hTjmEtq?=
 =?iso-8859-1?Q?TSKtzRqCLk+IHuu0GB+pMTnik6ZqZVLdMnEKY4brMjK7+j7PgnLYmh/dVF?=
 =?iso-8859-1?Q?9Hfv20EzrK/cvvKyM38g/xXgOCjXb5FUTAKNSLp7Gar0JJmwPLwWqipoA5?=
 =?iso-8859-1?Q?rD5w9x49442rD4w5dnOiFU60nFJPr1hv1Z8bsIFTASbjumQfFLIDia+991?=
 =?iso-8859-1?Q?557gUn9vznoTtwxVuIIJc8L8eEpc8HCtN3St/aplNh6Fdz6BqpIhvcGKyo?=
 =?iso-8859-1?Q?1z1fkX2zqSkiOLFF3tAJ6yKA/DKgvPCwsbAlSPzl3CNHmepVW9Qgs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eZziT4MFh7Lq87+hGfIhOpZRQQofQ9tyG0/nnLOcecvsbOYURTtIbyycKW?=
 =?iso-8859-1?Q?9/ZKx1BgDwuPG7KCkJiq6OGURvxYFrO5Dq3gvKJWpySLx4uO0pVfPXqzqk?=
 =?iso-8859-1?Q?+2zp90dUAsE18PF1zLGT2815zyE2wduKE8U1vk1ICCZnCgmJT6i1xU85cv?=
 =?iso-8859-1?Q?xsDvUYjBvlIOm6HMpYOCLKA1kE6WKoMuppy2b9IqBOHMryIp1grOR8wkE+?=
 =?iso-8859-1?Q?GfXdipwZuec9MlyD6o0FDABC00eFifzycSvQbXGwbcH3i4VOCYpHg0d3N6?=
 =?iso-8859-1?Q?EhokLtwnWLcTcF9AGK+cwuQASGnQv/kCrn/AZnOqkmt7MZCSjBZJ+/UHRr?=
 =?iso-8859-1?Q?bc3aJ361ELWKeWpC1C1pZXL4AdruM8i3fpIP6N4fOaKf38nkjels8pfZDh?=
 =?iso-8859-1?Q?nbN6ueaNdYl7JaOgGHqLK9ioqx1b+6/0xwHeswE1b3KsFshTi1IR+3SVfq?=
 =?iso-8859-1?Q?qtoWLOAyTMCGCy6RwqyK8yC3DcztbJhL+OLv6b7dC6lSPBuBqoFMoEIH1b?=
 =?iso-8859-1?Q?WioYgQMmX/IpHksCQQNuURy8wnDucsMiF+sDy1aJ8JXzdesXtC/SeWqXzQ?=
 =?iso-8859-1?Q?juq+ew7ycvRAc3L8ifa4OfDoBJzH/qUzXgReIAmvoYBVOlY00CpCijzNcM?=
 =?iso-8859-1?Q?n8PZxs4IRwCT+Z2Jg1PJM0/75dse17MiKdguO5ctdZhO4DwEPQPZpB+nPa?=
 =?iso-8859-1?Q?S3AGMPwuEZNMJ4oFL+n7t9rMceIm2fsny/lrMHJ3GJoHPkmUu/tOaVHU+i?=
 =?iso-8859-1?Q?m4QFzVC7TxghgkeQa9ZiMcjK0RD47ZMiLSXq19I5gvoEPEHU22BNTDPN0T?=
 =?iso-8859-1?Q?tPSao2dse5POf7i5KaEGmp5b2HEdm/xTFkROd+zoesvwNHeFSE4hdq3giQ?=
 =?iso-8859-1?Q?RG5a0KYUt/cAKP3fp6EWnvN4BoebiLYc6kZ7l+fhnczb8NXawfUwXz5C6r?=
 =?iso-8859-1?Q?+pA7EBYkO7a/kEXGhEbPOi49cU+PO0G+6FYjXuvg5J5X39H7SuIhXM0piO?=
 =?iso-8859-1?Q?XSZ5nbprKoKvUwOqvM9k33wvnglVLQF9lzyA5JDcoPXhuVhw/TKYjALT5I?=
 =?iso-8859-1?Q?/GkqY+N8sKQ8xh9We1iKKCSewtASZW6ZGa8ZmWB8d3cY87JtsV91upYxRA?=
 =?iso-8859-1?Q?O++iiYUN+UMZ/EZqxbqUaL2R7sYND4w26EVRQGRiouqAuXJSXspowMnhxg?=
 =?iso-8859-1?Q?zlxn28lPxMUNX1RBBWpnneYR/m3GybC5otc8ap4wdlxa/b/EVwRUPMgMbt?=
 =?iso-8859-1?Q?EoJxNkqm89Bb6lzQ4ZmffxjXOPq13bSYBMs4W5p581OspcsoZbQSI5Csyo?=
 =?iso-8859-1?Q?1Bczy+L8w7TtehtP+6j1Su2Nxe9cr7gbEDov6s7B+jBusPYjdB/PtFuLGZ?=
 =?iso-8859-1?Q?eAiwz8b7RJW+QSXBVJCxalA5MSALQaAtSCEsofFfOAgpnQxZ90WO0AyJ7j?=
 =?iso-8859-1?Q?W9wA/0nIVDDhvliaIjp7Pr7NPDRhC4JUe8d8mBIbCuVLs02aCz+iwj04jm?=
 =?iso-8859-1?Q?Kmg80u4QASA+n9ScvNYgxdwZrMtQ/MJCtzoojvCuku6Hsmp9itu/i4tl3y?=
 =?iso-8859-1?Q?CgsUTpRuRuBtpS94yWwHLKJjQ+HjHPjdhVFqQqCD6afL3IKKStE/b9y24g?=
 =?iso-8859-1?Q?z6mRv1OFudkiUlHOQZGfex5JB1pcY2a5G4?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dccc7c-63a5-43be-5f65-08dc9704535e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 23:53:21.3805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sirCOFpUbJymgwWxX8ZGvqa8Z7XIP3TJ9XQKn08woQgbMRTL+MUKR2sMDB0h0nmf5cZBn89wdoxqxTMrLfCt2iCXnKoVTg8RitWMx3WZn3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB2260
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: zlQzmptHSx7nPga8MKAmpYOV_9e7LfO7
X-Proofpoint-GUID: zlQzmptHSx7nPga8MKAmpYOV_9e7LfO7
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270177

Hi,

This appears to be a bug in Linux kernel networking. This was observed on a=
 fresh install of Ubuntu 24.04, with Linux 6.8.0-36-generic.

* PROBLEM
In the network diagram below, I have two default routers (TR1 and TR2). The=
 HUT has two neighbor cache entries: TR1=3DREACHABLE and TR2=3DINCOMPLETE.?=
 When I ping the host (HUT) from a remote test node (TN2) via TR1, the HUT =
sends a NS for TR2 when it should have replied directly via TR1.? This brea=
ks communication and violates IPv6 Logo compliance.

??????????? TN2
???????????? |
??? +--------+--------+
??? |???????????????? |
?? TR1?????????????? TR2
(REACHABLE)????? (INCOMPLETE)
??? |???????????????? |
??? +--------+--------+
???????????? |
??????????? HUT

The RFC for Neighbor Discovery describes the policy for selecting routes fr=
om the Default Router List. The relevant bullet is extracted below.

https://datatracker.ietf.org/doc/html/rfc4861#section-6.3.6
 | The policy for selecting routers from the Default Router List is as
 | follows:
 |
 | 1) Routers that are reachable or probably reachable (i.e., in any
?|?? state other than INCOMPLETE) SHOULD be preferred over routers
?|?? whose reachability is unknown or suspect (i.e., in the
?|?? INCOMPLETE state, or for which no Neighbor Cache entry exists).
?|?? Further implementation hints on default router selection when
?|?? multiple equivalent routers are available are discussed in
?|?? [[LD-SHRE](https://datatracker.ietf.org/doc/html/rfc4861#ref-LD-SHRE)].

* REPRODUCER
This condition is created by configuring two routers under systemd-networkd=
, either by having each router send an RA, or statically configuring one ro=
uter at a time. I show the steps for the static configuration below.

Assuming you have an interface named "enp0s9" and you're using systemd-netw=
orkd as the network manager:

1. Configure the Host (HUT) with one router (TR1)
$ networkctl cat 10-enp0s9.network
# /etc/systemd/network/10-enp0s9.network
[Match]
Name=3Denp0s9

[Link]
RequiredForOnline=3Dno

[Network]
Description=3D"Internal Network: Private VM-to-VM IPv6 interface"
DHCP=3Dno
LLDP=3Dno
EmitLLDP=3Dno


# /etc/systemd/network/10-enp0s9.network.d/address.conf
[Network]
Address=3D2001:2:0:1000:a00:27ff:fe5f:f72d/64


# /etc/systemd/network/10-enp0s9.network.d/route-1060.conf
[Route]
Gateway=3Dfe80::200:10ff:fe10:1060
GatewayOnLink=3Dtrue

2. Start or reload the configuration
$ sudo networkctl reload
$ sudo networkctl reconfigure enp0s9
$ ip -6 r
2001:2:0:1000::/64 dev enp0s9 proto kernel metric 256 pref medium
fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default via fe80::200:10ff:fe10:1060 dev enp0s9 proto static metric 1024 on=
link pref medium

3. Flush and Monitor the neighbor cache
    $ sudo ip -6 neigh flush all; ip -6 -ts monitor neigh
   =20
4. From TN1, ping HUT via TR1 - the HUT's NCE is updated to REACHABLE
[2024-06-28T08:13:27.617674] fe80::200:10ff:fe10:1060 dev enp0s9 lladdr 00:=
00:10:10:10:60 router REACHABLE

NOTE: tcpdump shows the expected protocol exchange.

5. Configure the Host (HUT) with a 2nd router (TR2)
$ cat /etc/systemd/network/10-enp0s9.network.d/route-1061.conf=20
[Route]
Gateway=3Dfe80::200:10ff:fe10:1061
GatewayOnLink=3Dtrue
$ sudo networkctl reload
$ sudo networkctl reconfigure enp0s9
$ ip -6 r
2001:2:0:1000::/64 dev enp0s9 proto kernel metric 256 pref medium
fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default proto static metric 1024 pref medium
???? nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1=20
???? nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1

6. Start monitoring traffic with tcpdump/WireShark

7. From TN1, ping HUT via TR1
a. An echo reply is never received
b. The protocol exchange shows the HUT sends a NS for TR2 (which is NOT REA=
CHABLE) when it should have sent an echo-reply via TR1 (which is REACHABLE).

* OBSERVATIONS
1. When NOT using systemd-network and each router sends an RA, the kernel b=
ehaves correctly.
2. The routing table looks different, depending on whether the kernel adds =
the route or systemd-networkd adds the route. E.g.

    a. Kernel adds two separate "default route" entries (systemd-networkd i=
s stopped)
$ ip -6 route
<deleted lines>
default via fe80::200:10ff:fe10:1060 proto ra metric 1024 expires 39sec hop=
limit 64 pref medium
default via fe80::200:10ff:fe10:1061 proto ra metric 1024 expires 44sec hop=
limit 64 pref medium

    b. Systemd-networkd adds one "default route" with two nexthop options (=
systemd-networkd is running)
$ ip -6 route
<deleted lines>
default proto ra metric 1024 expires 589sec pref medium
?nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
?nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1

* TCPDUMP
For completeness, here is the annotated output from tcpdump.

$ tcpdump -r ~/v6LC_2_2_11-bug-report-summary.pcapng -t -n --number -e
reading from file /home/matt/v6LC_2_2_11-bug-report-summary.pcapng, link-ty=
pe EN10MB (Ethernet), snapshot length 262144

?? ?# Step 4:? TN1(1181) pings HUT(f72d) via TR1(1060)
??? 1? 00:00:10:10:10:60 > 08:00:27:5f:f7:2d, ethertype IPv6 (0x86dd), leng=
th 70: 2001:2:0:1001:200:10ff:fe10:1181 > 2001:2:0:1000:a00:27ff:fe5f:f72d:=
 ICMP6, echo request, id 0, seq 0, length 16
??? 2? 08:00:27:5f:f7:2d > 33:33:ff:10:10:60, ethertype IPv6 (0x86dd), leng=
th 86: 2001:2:0:1000:a00:27ff:fe5f:f72d > ff02::1:ff10:1060: ICMP6, neighbo=
r solicitation, who has fe80::200:10ff:fe10:1060, length 32
??? 3? 00:00:10:10:10:60 > 08:00:27:5f:f7:2d, ethertype IPv6 (0x86dd), leng=
th 86: fe80::200:10ff:fe10:1060 > fe80::a00:27ff:fe5f:f72d: ICMP6, neighbor=
 advertisement, tgt is fe80::200:10ff:fe10:1060, length 32
??? 4? 08:00:27:5f:f7:2d > 00:00:10:10:10:60, ethertype IPv6 (0x86dd), leng=
th 70: 2001:2:0:1000:a00:27ff:fe5f:f72d > 2001:2:0:1001:200:10ff:fe10:1181:=
 ICMP6, echo reply, id 0, seq 0, length 16

??? # HUT has replied to TN1 via TR1.? NCE for TR1=3DREACHABLE

??? # Step 5: Now configure TR2=20
????# Step 7: ??TN1(1181) pings HUT(f72d) via TR1(1060)
??? 5? 00:00:10:10:10:60 > 08:00:27:5f:f7:2d, ethertype IPv6 (0x86dd), leng=
th 70: 2001:2:0:1001:200:10ff:fe10:1181 > 2001:2:0:1000:a00:27ff:fe5f:f72d:=
 ICMP6, echo request, id 0, seq 0, length 16

??? # HUT creates an NCE for TR2=3DINCOMPLETE

?? ?# HUT incorrectly sends NS for TR2(1061) when it should have sent echo-=
reply via TR1(1060)
??? 6? 08:00:27:5f:f7:2d > 33:33:ff:10:10:61, ethertype IPv6 (0x86dd), leng=
th 86: 2001:2:0:1000:a00:27ff:fe5f:f72d > ff02::1:ff10:1061: ICMP6, neighbo=
r solicitation, who has fe80::200:10ff:fe10:1061, length 32
??? 7? 08:00:27:5f:f7:2d > 33:33:ff:10:10:61, ethertype IPv6 (0x86dd), leng=
th 86: 2001:2:0:1000:a00:27ff:fe5f:f72d > ff02::1:ff10:1061: ICMP6, neighbo=
r solicitation, who has fe80::200:10ff:fe10:1061, length 32
??? 8? 08:00:27:5f:f7:2d > 33:33:ff:10:10:61, ethertype IPv6 (0x86dd), leng=
th 86: 2001:2:0:1000:a00:27ff:fe5f:f72d > ff02::1:ff10:1061: ICMP6, neighbo=
r solicitation, who has fe80::200:10ff:fe10:1061, length 32

Regards,
Matt.


