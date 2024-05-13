Return-Path: <netdev+bounces-95832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBBC8C39D0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E4A1F21080
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B6AD49;
	Mon, 13 May 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WoOykfw8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B457494;
	Mon, 13 May 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715563318; cv=fail; b=ewD1f8g3g2lhxjEo1ec+AWPhsyYXdu21J2mFrzarv27GnniI0nFnt3oX0Tna2DZtOyN8Ahzs6bj6RgeYrxl/6/5qk2tSXBh6GFZDWa0MMGxQaD/SLhh/mXPhTSTgJaJKOt03IPUrsURkjeRWZlRtu7xv06zHY3Acxg8voKUOX6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715563318; c=relaxed/simple;
	bh=l4zaL+KtHADNLhMortfw3+frv6ZlM+j/VXvuL37NIag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QXkz4ad+yd/cmVyNp0r84ufzRH6bvqPL5IQImgjCZMcp7IySNPZqe+GoVuNp63y05f6QrcKqwR9ycMDYEKFtUsHn3oOjo2xcImNj9UZQmZeklmM8WUEvK/K9o2XoI3PGmA5ngjUu34Xa8DxJZjV/YGgu4QsiTrIaKgGgM+g8AUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WoOykfw8; arc=fail smtp.client-ip=40.107.15.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ycl6YqmkGXvhgMYC+CKsFE+W8UReKTMiwUovoGPqfAFsRXbZY21687Sl9N+S6ONV/1iCa73G4Y/JvVhqgRF3cAHBjiaRR2Dl+SeKNyO5MmtqtBev8IKj1RDmHOeOwnyKqUiex5nnY9HaOKb+q128Nzf+qwAX940tgr2NtWa4POMTI6tfFuNiN/59tZoMAeL8jqditYMleOzSHYdOwYOGO7Qrtt7J5CXiTve+mlJXK0Zryo2w5beU2RhARKw5wGG8iMOKhZuNOc/N6nwTJbPZyw8ijE3f45l+gZv35QjWtS9a2fKADUYv1kR5afC4xRwl67mTyQlDagLFNYnmvyHyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4zaL+KtHADNLhMortfw3+frv6ZlM+j/VXvuL37NIag=;
 b=MF6KC/pWiXT3qh7kLq5b2o6PpEYgacWTf114cl6libfvVNCMpbvh2oTQdWz6bNI/38D3RMo+5ZQw0UhqQQsS1A/Uq/slQRZaTsgAqB+552Zhy7WpQznugUjBNKCvLiPbirLVbS0aSFCKBf1gHc6kFruNtw8zJaXPutekNGu8MwllMKmrLLFxJ9ophj+wWj5TBGwUjIXexMmwGrO9aFhDSIxYF8VkK19wZ4xsUym5kUO3Lwi238yKjhznNh7iOKNnxmmH5zNn15jhSO8aAMXO9esgxSprtpP0/FWok9GvtEu0qios05U+TAPLx2VDB2qEVQoiNQTHUowdJdWc8Grcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4zaL+KtHADNLhMortfw3+frv6ZlM+j/VXvuL37NIag=;
 b=WoOykfw8yc3IZ9xn3RKuk6PQyfFHPjmAdS/C7rlOJqTep3zs6zeJ5duS1246RcD8j7pZxT0Tyc0j0LmOcdeDSS5zh0BLe0OZmDufgTwjgSD9c18hwr9nS6b/JBwi2JOxFVOss89SgfzItOxbGqJjMAfhI+2TT85lkxBwhb0xpXs=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7214.eurprd04.prod.outlook.com (2603:10a6:800:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 01:21:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 01:21:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next] net: fec: Convert fec driver to use lock
 guards
Thread-Topic: [PATCH v2 net-next] net: fec: Convert fec driver to use lock
 guards
Thread-Index: AQHao1E3Rn7FvRcfoU2u3mKYC6d4drGSGLaAgAJIEQA=
Date: Mon, 13 May 2024 01:21:52 +0000
Message-ID:
 <PAXPR04MB85100FF5080EA3C8E093C39988E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240511030229.628287-1-wei.fang@nxp.com>
 <b96822ea-4373-415d-8397-d8bc5da88120@lunn.ch>
In-Reply-To: <b96822ea-4373-415d-8397-d8bc5da88120@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VE1PR04MB7214:EE_
x-ms-office365-filtering-correlation-id: 5a5fa138-3658-421b-e0b0-08dc72eb1215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?alo5U3hTenVPVXNFbGdTeUV5aDBTMU1pa0ZTcDV6eTk2clpYd2E1L0dZWEkw?=
 =?gb2312?B?MWUyZWl3V3o4dXZLeEFJTEVQZXd1U1d4Ull5Ymk5MXpJZ3RVZnM3MDFkQUp5?=
 =?gb2312?B?dHROb3QwbU5KZS92ZHZPbHdGZU5ic2N3OHNUVWlVV0NKNVdpd2x0ck43Z1hv?=
 =?gb2312?B?ZVNqSnQ0eFF3aFN3aEdBcktrWjZ2TkxGY2NPYW5RK0xwY1hVMTZHVTlXZURB?=
 =?gb2312?B?S2FMM3lRQms1ZS9zQU1waGs0MXlaci8xRkkvWjl1TDV4MzBMNzdXaTYyZ2I0?=
 =?gb2312?B?T010WE9YOFR0ZkJhRVcwNnkrN2RUWjZzSE9rS3dFUzNKcjNGejBqNzQ2ZFM2?=
 =?gb2312?B?cVgyRXZTZkdvMnhRcVVPMEpKSFVORUxLdEhXS0tOanN1aFNlVDRYSWdaZ0k0?=
 =?gb2312?B?Q3hGWjFrMENFZkh5Q2w1VjRzR214TlN0WC9SR1M0cnZKVXQ2L0RaY3FOVkEx?=
 =?gb2312?B?WFN4MmUxTmJGdDZnWkl3R3k1QlFJT2RIM2N1cHlKODhMWHA2LzR0azlKNU9s?=
 =?gb2312?B?cGRHcjdWMjUvVzlNMUxWQzZReUZZdlFCdFVYSXhvbis0bHY3bVl3MkdrbEFj?=
 =?gb2312?B?QUoyaGVXQ1RUOUlySXVyMWEyUldmeGtnMXk3RkYxM0U2SnFIMHRRUzNnWi9I?=
 =?gb2312?B?QmJ3eCtSUTdYeDlrRW1sUVBiN2dBWWlLbncrUkxMbmtuclBGS2JmWUdOYm9R?=
 =?gb2312?B?M3A3dVZzVXFYMTdZVW1ka2VuRkE1MEY0RTA0UXAzMko0QVo0NUwwQWVpVUlm?=
 =?gb2312?B?ZXAyNFhYR0ljWG95aUw3eDBqWmVIRzE2ZC9YVkZhV1l2UkZIS0JXc01Ja1Fr?=
 =?gb2312?B?ZDZ1WG10UmZKQzRvdlVnYmQ1bS9ENjZIazkyamhEM0RXZVZldjNpdUpxKzhu?=
 =?gb2312?B?VnlHd0E2aFlqZHUzQ0dqd0phenA3cThkZlY5WVRkR2dESjFkblU0dXJXMWl0?=
 =?gb2312?B?S25ybXAvakpwTWlORFVPYzE2TGpEODhjalZlRFNKeDUyb29VZlVYNDIrdERB?=
 =?gb2312?B?WE11MXplam41MzBuWFNCR2JmSFVXS0Z3cTNNaVVsZWVYUjNON2ZwRkJ3WnBF?=
 =?gb2312?B?bWJBOG5udDIrTzhHcGdMOUNqN01iZisrZUl4L1Y0Ynk1ZDUzUG1tUVppNENH?=
 =?gb2312?B?S01vYkhWZURDUitrRXY2WUF3UUJ3eDFKVHVTdFloTVN6VGQwdGt1cXhSaVlW?=
 =?gb2312?B?ZmR4TkJKRHQrc09XRWpicHQ2TEVxQjhqQ21oWm5yQnhaWHFqK21ITW1JZ3ly?=
 =?gb2312?B?RnFRSUl1MGlpc0JERTBoTEcwVXgreVdiTkZNbkhKS0NNVWVkZ1lOcFdvU1Ni?=
 =?gb2312?B?ODRYMC81M0RTUnd1RHNDWGRSaFNCZnVIdzU5N1hwaUJ3RngzU3JIQTBKOTJX?=
 =?gb2312?B?Kzlwa012NnVxd2VjSEZIZWYva2FxdmIyVHR5TmdFeTJKYndVcnVSeGZnQzU4?=
 =?gb2312?B?dmptclpaam5ESjJCTExodTY4RC9yWjZ5dHF3R3RXOG50Z0tIUW9OTHBsUjFG?=
 =?gb2312?B?a1JkeTR0emFPdVBkRWJhRGtyYkJhRWpEVjk1TjZZOHNXS3QwVjFTRzdxNmFM?=
 =?gb2312?B?VThpckJxa2FRc0lscmVMbDlFV1dMVEJJSkFVVVB0VU1jTlZUMUV4NlRHUjQx?=
 =?gb2312?B?M3cweWlza0pFNVduYXRSZ0QxWDRDbnNKc2ZqTjVabzMxYnVEbkljeWJlMnJy?=
 =?gb2312?B?VkxjODlmT3VEenFiTkZKdTByUWYvZk9QZU9mbzNMcEU5N0xZS3hyWkRGQ3By?=
 =?gb2312?B?TWozRTZzZjhFazRSNFhMN1lTbk1xTWd1VnBhQkpuZUJRcEpmbStnekFnVGhI?=
 =?gb2312?B?bWk4NkNiTkJlS3I3bGRFZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aGFLTEVCRmQ5bmhrZm1OS0ZsRmk0dkRvV3VRc3laa0ZUWHZuK3hJVWc4b3Mx?=
 =?gb2312?B?WWhaQ1B4Q0JDWkpSbVZta2Z1a0YzQVA4dUxjbFJoeDJTN2JGK29vNGYwc2R3?=
 =?gb2312?B?ZDJZKytkUWRqWkx2b0VNSXR0WU1OeW5mQU9RVzRmaHRicUxnRTE3cVZodXRS?=
 =?gb2312?B?Nk1LdlFXL1lJdTRPRXV2cDA2bWk2NWFsVkFCdmRUVDhLVFlTQXQ3a1JOaldp?=
 =?gb2312?B?UGVZQWx1V0c5bndyVEZGdCtlUTVGY2NzZHpXMGVueHkyU2Q3TFI4RUFnZ0FL?=
 =?gb2312?B?Z08rRVNUcEk0RGV6dmczdTNGWlJraXZrV1g0Tmcybmw0TUpxQU1aTUdCcnpG?=
 =?gb2312?B?dTdISW5IYUwrQ1MrZ2V3bjBCaFlNaTlRRllKNXNSV1MzZ3ZBRTFWNVRzUjla?=
 =?gb2312?B?dU9oRTFnQnhLVnlEb0pHNU9GbXI0UFI3dUxLQVlBY1hzd1dIUGM0aTUxT1Za?=
 =?gb2312?B?WTRYT2ZTNVU3Q2M0aTJlWEp3L3NOU2IweG82VWlTVHJjaHZPYUkrQlJ1Wkdp?=
 =?gb2312?B?SHJVbzljVW5YNGkzNUxGVllTdXFOU2RQSkpXUSs4a1RMeExNWnR1Vk82UVhp?=
 =?gb2312?B?bXcvWXhRTnVHM1hZY2hJK2YzeGhUVFNHU0Fnem5nRkk3S0IwMCtXbTlFdTVI?=
 =?gb2312?B?YWVFaGdBUCttaUdld29lVDJnOVI4NlhJQXd2V3p1V3VMNGZvNko5d3dJU1ZC?=
 =?gb2312?B?a1hERFl2UWc3eVU4L21PcGJ0bDVRTzRHYTZrSEFRaXlZRnhNd2Vrdnd6Nnhh?=
 =?gb2312?B?dU5jNy82cHkxUGdXK3JBSWc4UjZtOW83M1lwQlBZTHpLVlNGUnZNSG90OXBM?=
 =?gb2312?B?YWFQOGZKa21nb09WOE5oV3UxMXBsYmpzeGNlSTZNdmsrdlNXemVjZEFrYVJv?=
 =?gb2312?B?WWVpSGhLSmRDbnRZZ2xxN1RwNzNRZHJ6dUlqSGhTUE1oNjBteEI1ZTNhUzky?=
 =?gb2312?B?THJYVzBQNHdWRXJFeTcxa2haWk1KS0hvd3BpdGEzZzZIVFgrWmlEMVBHSHIz?=
 =?gb2312?B?TmRGKzZ5OW9VYzUxVUt5ZkhVMkloQ1VhQ3B4WnVHaUVZZkdxN2lPUjVvTkJM?=
 =?gb2312?B?NkZUdm1zZmVqWStjeU5rQTVxaEQ4N2tMODRtc1JyeDFIL3NmRTBHNmVtT2gz?=
 =?gb2312?B?cGV3aTBqeG1XMWNpNi9IeTVxNk52dnF6ZGpQYzhtYUk5dGFPVk13NmMwZGZ0?=
 =?gb2312?B?dkx4YnhsY0tyUUhNVzVNRnFLeFh0eUNWanVCcW9LZmgrRk5vd1FvYlpERGpY?=
 =?gb2312?B?THBGS2tobVM0LzBOOXNGaHROb2xxWjNKaU5iTFQva2Roa3F3eHpyRXZOWEJm?=
 =?gb2312?B?OVE5MktwR3c4SXdBdTM4SGsyZ0h2VitiNFR6dFJnZjc2ZkQ4aHQrcFpEdHJk?=
 =?gb2312?B?Z2RTRjJMdkQycXM4dUp1dGU0c1V5TnRtUmx2SEFHNWJEYjRZWWlCOVZVTjBN?=
 =?gb2312?B?ajZnM3FHcTRQMUdvbXFNODgwZC9obG1ZYmViU2Z5TmpDZGU1cElIQjgzRDQx?=
 =?gb2312?B?N1htT2JvK0pmM2o3WlRzaHJtOVhmYUxHQ0pyYzdiOTNXMFI2TEhST2JSbWRo?=
 =?gb2312?B?cFRCMWJXSzVWcE05QXZQQ2FXQmpKdmpIQWRuYlI1NUdMeWRNT2k3ZUNocjhq?=
 =?gb2312?B?Y3pIQXZhSFdrdXhHbFRCK0FKRlBPL1VNWWc1clZnNHFYcmlWWFJxNGVGc1NH?=
 =?gb2312?B?aU5oRnJCWUp2OWFSUXJaRUpldzF1OFhCc2NSb2VsNkZ4WEJwOThOc09tV1pu?=
 =?gb2312?B?YlBMZmVvOXUyYWFwR1ZnYjA3d09EVkp2N21Pc3drTjVUNUgvSWU0R2VxYXBq?=
 =?gb2312?B?N1dpZW9qMHNxMGNSeEpKYUkwUkJJZlkxV3d5eHUzYkQ3eWZTcm05RXFvbEQ5?=
 =?gb2312?B?MHR3dG1aMEw1Y3RBWlJIT3AzNTF1Vlc4OWlTWEhaMjBVaFowWTBBUEI5L3ph?=
 =?gb2312?B?WnFhNGFkOHZrOHdLdGxxOTI1WVptZDRpUmhOdzdLbGVRTjcwUUNSa2VXcEhZ?=
 =?gb2312?B?dDQyUGgxN2pHRFhzL0Y0S05HSTlqSmJKcXpaRDZJZGJMYWN1YUNhVlJuNmFO?=
 =?gb2312?B?RHF5NkN3b3hOYUp2YUlCNG9TYkN1bTU4Szh1M3dEQzJHckxIRVpuSWZiRG95?=
 =?gb2312?Q?yQ08=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5fa138-3658-421b-e0b0-08dc72eb1215
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 01:21:52.5486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMi4LJEUKWOdDKrTWR1gqBBEqQbWXhek8OwP2qbalvcoe9JHz9X/fTYGdmWIbrI4jzgMPMeVVcKTolVE4KIyQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7214

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jXUwjExyNUgMjI6MzANCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgU2hlbndlaSBX
YW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcNCj4gPHhpYW9uaW5nLndhbmdA
bnhwLmNvbT47IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsNCj4gbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIG5ldC1uZXh0XSBuZXQ6IGZlYzogQ29udmVydCBmZWMg
ZHJpdmVyIHRvIHVzZSBsb2NrIGd1YXJkcw0KPiANCj4gT24gU2F0LCBNYXkgMTEsIDIwMjQgYXQg
MTE6MDI6MjlBTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gVGhlIFNjb3BlLWJhc2VkIHJl
c291cmNlIG1hbmFnZW1lbnQgbWVjaGFuaXNtIGhhcyBiZWVuIGludHJvZHVjZWQNCj4gaW50bw0K
PiA+IGtlcm5lbCBzaW5jZSB0aGUgY29tbWl0IDU0ZGE2YTA5MjQzMSAoImxvY2tpbmc6IEludHJv
ZHVjZSBfX2NsZWFudXAoKQ0KPiA+IGJhc2VkIGluZnJhc3RydWN0dXJlIikuIFRoZSBtZWNoYW5p
c20gbGV2ZXJhZ2VzIHRoZSAnY2xlYW51cCcNCj4gPiBhdHRyaWJ1dGUgcHJvdmlkZWQgYnkgR0ND
IGFuZCBDbGFuZywgd2hpY2ggYWxsb3dzIHJlc291cmNlcyB0byBiZQ0KPiA+IGF1dG9tYXRpY2Fs
bHkgcmVsZWFzZWQgd2hlbiB0aGV5IGdvIG91dCBvZiBzY29wZS4NCj4gPiBUaGVyZWZvcmUsIGNv
bnZlcnQgdGhlIGZlYyBkcml2ZXIgdG8gdXNlIGd1YXJkKCkgYW5kIHNjb3BlZF9ndWFyZCgpDQo+
ID4gZGVmaW5lZCBpbiBsaW51eC9jbGVhbnVwLmggdG8gYXV0b21hdGUgbG9jayBsaWZldGltZSBj
b250cm9sIGluIHRoZQ0KPiA+IGZlYyBkcml2ZXIuDQo+IA0KPiBTb3JyeSwgaXQgaGFzIGJlZW4g
ZGVjaWRlZCBmb3IgbmV0ZGV2IHdlIGRvbid0IHdhbnQgdGhlc2Ugc29ydCBvZiBjb252ZXJzaW9u
cywNCj4gYXQgbGVhc3Qgbm90IHlldC4gVGhlIG1haW4gd29ycnkgaXMgYmFja3BvcnRpbmcgZml4
ZXMuIEl0IGlzIGxpa2VseSBzdWNoIGJjYWtwb3J0cw0KPiBhcmUgZ29pbmcgdG8gYmUgaGFyZGVy
LCBhbmQgYWxzbyBtb3JlIGVycm9yIHByb25lLCBzaW5jZSB0aGUgY29udGV4dCBpcyBxdWl0ZQ0K
PiBkaWZmZXJlbnQuDQo+IA0KPiBJZiBkb25lIGNvcnJlY3RseSwgc2NvcGVkX2d1YXJkKCkge30g
Y291bGQgYmUgdXNlZnVsLCBhbmQgYXZvaWQgaXNzdWVzLiBTbyB3ZSBhcmUNCj4gTy5LLiB3aXRo
IHRoYXQgaW4gbmV3IGNvZGUuIFRoYXQgd2lsbCBhbHNvIGFsbG93IHVzIHRvIGdldCBzb21lIGV4
cGVyaWVuY2Ugd2l0aA0KPiBpdCBvdmVyIHRoZSBuZXh0IGZldyB5ZWFycy4gTWF5YmUgd2Ugd2ls
bCB0aGVuIHJlLWV2YWx1YXRlIHRoaXMgZGVjaXNpb24gYWJvdXQNCj4gY29udmVydGluZyBleGlz
dGluZyBjb2RlLg0KPiANCk9rYXksIGl0J3MgZmluZSwgdGhhbmtzLg0KPiANCg==

