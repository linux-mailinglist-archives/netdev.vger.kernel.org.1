Return-Path: <netdev+bounces-274980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOfJBWGUz2nmxQYAu9opvQ
	(envelope-from <netdev+bounces-274980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:20:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 754A43933CD
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2C00301751F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932F3A6B7F;
	Fri,  3 Apr 2026 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BwkhbEXl"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAC2DB7BD;
	Fri,  3 Apr 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211599; cv=fail; b=FRqJBYhILR1DDeXPDVqkZF32OIb/0POwnZGydEaGmxUT1qEl25z8Pid/5CUdqmQEhzKKyKqH/jN253Q9izNpy26gQGH4L82Gl6JMaKqL0lZVZPfJGmWfNv2q3S3pJ0QvMvEIUMZ5OVLRs6wgMcZ2ultid9E+h4VV0hbb5BPk5vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211599; c=relaxed/simple;
	bh=Rf4kFVUOGSB7DDEB+cULqBDz8WzHKhWVytv0+XzSHoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nH5myvflFGUTm1OoAuoOFvzLzJOOhFoloK7Ypa+qXOSat1PaSfCmImwFOG2X29pB7cDyN7/aiJXKVQ7IepLZn84YtMdZymE89pOH/hZqSLcZA4fXNAeTPXTg87dpae+XAqk2ZxxKE9+qbcdgVwBL16BTnRWJmt+db3+aHE7Bux4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BwkhbEXl; arc=fail smtp.client-ip=40.93.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+ZGMBn15QH3r0jCmWX2TzhxASl20W0y0MHmWHgkFvovw483axE9aHzD4/hhLT2Ht5PgPLvBZ5IeyKeJ29o1U9gUy/uzdGgs+6srXcQz8g8eD3Vsc3CShtmLKeGLx1xY06rylRHN/G2TztjtfJnTUXsv3cY3vG8oTryagR3YGpKAWzSEmr+ojq3jgMlu40UCj5JwjAfYAZXDkbgjW2CUzGDLdApslFKBzao7jsge+3YFycnT4J8KuNVyJ3HTlefSt7ZGVIpcDElYf07iselcTEOoz+6D6SpZR6ohfrSHp06bKKuSjb/qTZtMeHDZj2jamKJyG52ACXWmlcSBMSyDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhTwgkLVzHdt+RwA8qI7SUy6fWNJyjBzkIWsjZybz8k=;
 b=iYQ6ItWMuz3WZDKr14dBrLEe3a2dKKjqk+aEwonsuB2Mc5m6S3O/gSzUbxP/mw3P+2PyfWwJI/ipm+Jiq6AkfnXCPkiO9cU0SqtkfGZ6owtYtK9wXrtW1zxAaRV7K7enhe2TXODAhfMC1xdSk8UhQXivDIY8I1D6i1QjihQ2JMtdQDindNYxdZu6GZUfBQjhoCsrzArV18K3Y2qcZdbcARfcL0QLIocCpRSkpX3k8gxSqPVmw+IsL9eWKfEmDkdiloZquY+dVC/KpQU49jjGGx+e9zyJDPDVDidqImf0FVoH97dAK8cZup2asviRJogZFOusyFsXoMp+Ia9di+6vxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhTwgkLVzHdt+RwA8qI7SUy6fWNJyjBzkIWsjZybz8k=;
 b=BwkhbEXlDw3jwXBD2g1Umninrx9WxnPny/coTh0x9LmnLo2MvzzagUu9q9kK674SfXgSk5Ypff08Tb0P1iWnEWc4tDFDHA4nVG7ZWSzs7Bk7NYaX8dZb64rGNKDi+tL3EftPb+tYLJQSBXRmb0o5BwsX+M8TlRZR5ynx2wc5yzujC+paiAdihFxicivIHJlMogoZVCEeAef2F1lbt0DUVYbOAOgmZHvpNVab0f9AGDoTWqe8RA4eSpXFAU14hgpamzEv0FEtx9CmDXJ3dyLqo5/Sgb1MQAaC7553KnIhDdBat+CqqTIW5Thg61rGSlJY/Vj9nAVGnQRrttie1mblAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 10:19:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 10:19:53 +0000
Date: Fri, 3 Apr 2026 13:19:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] selftests: net: bridge: add tests for
 igmpv3 MRC and QQIC validation
Message-ID: <20260403101944.GA66518@shredder>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
 <20260330191611.16929-6-royujjal@gmail.com>
 <20260331141347.GA1637150@shredder>
 <CAE2MWkn3gPc1kBwy2p7r5bx6QozMStM0N6oEutT7g7GnJrKteA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2MWkn3gPc1kBwy2p7r5bx6QozMStM0N6oEutT7g7GnJrKteA@mail.gmail.com>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a88ef9-1d53-4259-c6c6-08de916a8bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dfN9VlYksDY9vS1SIEcERN5HHo8qqgMItg1oWLKOzp7MWul/EJrWWZb0VrTWFlDEM0DupKy+NDCkZ5qy5who6xqf8D5FJ/GQxD0E9zpWPcZ8EB5zsvGstvjNyNTahYXx5Yg5Q0mCi9v2G4f+c+1aap3D2UyYutbQEDTPUM81N4zd8AQMIX2dl/fdZo9e2k5L4kd84n6N89aXA44AK5HWEItVIYUTAthbSmeokYG/vrkhDu9MLLHK7YwdlmxYHrrfwg719usrbTuy+/EHc7JfN3cW4n+AQNuJUMavoXPbHKkABREvqrKDdFyxDTldHX1pClhUkSBYEd10vYbBXGirgm15hx/GX1OnTxtg0BGveciadJp4U4M2tiwUiOpvWVvoR9CRZ4DuM/Y/0ke7Cx51xpNilUUo8oevEjirILTnj91QVz04xSxuX7XTFYR0pz3rBScbv6lHpusGr4pR9n1ovHkW0KJC/TgEELbCCzabNTAfeUIJu1YMabkS9V5ugW8f5CSoVodiOk2yFl3Ao+BpePpDVPi4NTOC0nzW7ibMERhsuKPiFziuTdZ1aUd8XuXxLRa3ULKcbyys2R0qYM0LkS73RUTtUbEuUyO2YxGat66wdFidHHPEtApdSc9b+XhFYBA85eR65ewAf55XwxWiG4r+4CEBmqtqbKOdmU3vcR/ZsQQZTCea5vuDXgmfHqRkFMoA/cEx60mQdavU0hU2Z5ldGGTZxFidw1eT+p7P60c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEl1KzFUcDl2R0M2dFgxWnE1dmpEbGU2ZlRVUXpVOU45dWJYelZnT0pZL2VO?=
 =?utf-8?B?b1pWaGVYVmdYd1U1RFRMYm11RTVPME9GZE5CMnVibGRwRUpLaXFlRnc1Zi81?=
 =?utf-8?B?T3FGRXRRZUxwSSt1cWNSQm5oWm96RUNoeStWckwzZkR0ZzFrWUFUN0l4b2Vj?=
 =?utf-8?B?R1JESTZHcjBRQ1J0YWdkaHRnY0s4d0pBVTFyYmpKTVZnOWlFQkdMT05NUnd5?=
 =?utf-8?B?VmI0eUJzWkw1ZDBpRTFWUDBMZ2NnUUdlVzlzWmwxWWRzamxnbnRBdXhuVEJl?=
 =?utf-8?B?SktrRXBZYUkxdUZtcTl0NTFZa3BnNjdsZldVYW9XK2RiYzhMYmVJdTZ2K2VC?=
 =?utf-8?B?cXQwb2tNT21BSi94VEQyMG9xT1RrWUhUaERzOTFrbnJhU2ZoSWxYMDJQRlRy?=
 =?utf-8?B?aWJ5U0FNM0hqeHZqZzNOQ1JnOGUxWVkwSTE5dExDR3BQaXc0bWxIVVhSdlZ5?=
 =?utf-8?B?QTEwa0lleFBYcDhqTW4yRGw1c2NZMlQ2STVibWh6RjVFL0ZwY2lWZFlDTEE1?=
 =?utf-8?B?NkE0Z1B5YksyNmY4MER1NFBjOXRyWTJ2T1VPYlI5VmgwZ3lYa0wyVi96TEw1?=
 =?utf-8?B?Wkkzck5PSy85Mk81SXBMQmo5M3poMHFzVXo4UURPZ1BNL1VCTGcyL0JGenZQ?=
 =?utf-8?B?K2hNR0FkUFJ4Y2dlZ0REV05nSVFrdVIwcGhUSTQwZm5tRk5vZ1FIMWFIZjVx?=
 =?utf-8?B?KzJIcFR1dlpVL0xSTVIxME5GNHlVT1ZlVkNaU0kraEVDY3ZTTnk3N1VSczNa?=
 =?utf-8?B?ckM1ajc4MTBwZitFWURwQm5BYVdVbUJZTzFkR2VsTEZraUxGQU0vaEc2ZkYy?=
 =?utf-8?B?bVJ1RHRkSU1qWG1uMkpOKzkvY00xaWJXeFYzbGdnSXRSREE0Y0kyNUtJU28x?=
 =?utf-8?B?RzNUaXhDZkRlUWIzWjRFOGs2MVF4OFRWNXl5b1FCNFpwT0IvcjI3ZS9HeUhn?=
 =?utf-8?B?SzEvSFRMMXN3MFFtSDVEQWdJc2g2S2RhaWpPVHljOWZDMFVJdmRQdDlBaXJp?=
 =?utf-8?B?WjJ3T3ZMcDE5U2ZwaXBkR29RQXU4WVZzVnVOTXlkME5LUFFTRDg0aHQ4R3B5?=
 =?utf-8?B?OGdCWkFYVnhHVkZQbnM5OXF6YjhzY01HeENxemF6ZlJOZEFMbGVyMm0yTGRI?=
 =?utf-8?B?NUtQVnNFb0pyd0JtdithUXhqa3hOY2xyVXRlRWVCNmkvcDM1T1BTUjBtQjVq?=
 =?utf-8?B?elc5eXJ0STQ3V0ZjMUI2MlJTYTh2RXJmYThNN1FRVlI2TkZTVVFWU1dEMkFw?=
 =?utf-8?B?eGJYczkzU254S0oza1BadGUvN25WemVOdWtvUzFMbldVaFcxVy9oOXhTeFdG?=
 =?utf-8?B?MmpjeGhFYzZxTzl2NGdldER6NlM0Ri9oVlZVNGpvQmhPOFlSSU93QW1CMEti?=
 =?utf-8?B?Q2N3L3ZJTk9WMjdQcnU2OTVsTWs2Wmg2ODliWld3d3N4NmFBeXErZklBdWdo?=
 =?utf-8?B?Tk15TEp3bUNvMDdYNVUzSUdqWmxCUkRWVG5iWjFoSi9Ya1ZnSkxJVzN5bHhZ?=
 =?utf-8?B?eW9VYTNRNHA4Z1RvVXBIVjRMdzRGcWlTNkFsZWg2ZXhUUVFFWXp1SE1zeU9a?=
 =?utf-8?B?QUJraUJTN3ozT2I5L2FKSFVESm9mbTlOd2hhQnZOaEFrdVhJYnlWVnZiR3p5?=
 =?utf-8?B?K2lLMlQweHBuQ083V1BCNHAxYkgzZlo3akJHbkgvVEFtVE0yWGFIT1FzQVB3?=
 =?utf-8?B?QjRXcTdqemdnbzFQS1RjRm5pRE5ITjhaK1VlV1FydmE2NEtSRE9ON2ZKc2g5?=
 =?utf-8?B?Z2NqSjIzSHRsZXhWOHRQUUhkZW1MRTFyTmd5OXcxK3N0RUJZN0FuL09DU2pH?=
 =?utf-8?B?M3E2QWN0MElNR3FFaXpJZ0pXUVJjR0tHR3E2R2pDV3JYV3VVRDJwYlhPcWZN?=
 =?utf-8?B?R09PWUFJUkphZ2VZWWtpUHdCalM5ZFArcDUwY1BicFVTZUVTZ1Q5QXRYa2xB?=
 =?utf-8?B?Znd4cTU3YUNCMlJ6ME5LVHc1QmI0Y2U0Z0tScm1nc25GQmpib3JmMHNmVTVL?=
 =?utf-8?B?TjFXTDlTN1o0M2x2SmVwanlZY2ViT1o2UWptRG1iR2FKS3dsc0ZrZFpwMGRo?=
 =?utf-8?B?VEtvM0xrdWNXaVhlWEVXYm9rUGhQL3JXMEhjR01tREk3QzdtK2Y3S2xKTjdm?=
 =?utf-8?B?RDIyYmZrZnJsalh6cDVKQnI4QWN4YzhpaUJVWDJyNXlIaGlnSWQ5N1Q0NWti?=
 =?utf-8?B?ZXU1Y2xMQkU4Z1JwSUxvdDR2N3lqbERrVkZWb2pGd0RYUWtPc3BNdnNYaG9X?=
 =?utf-8?B?TEpqallaZk1qdFJONTQ0MmNaVTNHemFLOUliSHV4ZXRPYkZja3RzYlY4elo2?=
 =?utf-8?B?T21jTVFhajBlUlZuRzI3L2YwWHlEZW5DMUVUVkx1QnFCVUFDc25ydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a88ef9-1d53-4259-c6c6-08de916a8bcf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:19:53.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBFSu4KP8mVkMhnCcy0K+P4WkgcfCVY8jXBAMtjCqCyF6EBnfVgPcF4ML2eWvi6kyxTwrIIr54hs2afs5DbJfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274980-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_vlan_mcast.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 754A43933CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 01:20:49PM +0530, Ujjal Roy wrote:
> On Tue, Mar 31, 2026 at 7:44 PM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > On Mon, Mar 30, 2026 at 07:16:11PM +0000, Ujjal Roy wrote:
> > > Add bridge selftests that configure IGMPv3 parameters and validate the
> > > resulting Query packet fields for Max Resp Code (MRC) and Querier Query
> > > Interval Code (QQIC).
> > >
> > > This also adds helper binary to encode floating-point exponential fields.
> > >
> > > Future extensions may cover corresponding IPv6 cases.
> >
> > Please cover both IGMPv3 and MLDv2 since the patchset touches both. You
> > can add the MLDv2 tests in bridge_mld.sh.
> >
> > Also, I think you can simplify the test by simply matching on the
> > expected values of MRC and QQIC using tc-u32.
> >
> > For both IGMPv3 and MLDv2 please test both:
> >
> > * MRC and QQIC in linear range.
> > * MRC and QQIC in non-linear range.
> >
> > And please make sure the new test cases don't add new shellcheck
> > warnings / errors or it will fail in the CI. You can ignore existing
> > ones.
> 
> I will upgrade the existing test cases in file bridge_vlan_mcast.sh
> instead of the previous file (bridge_igmp/mld.sh).

Is there a reason to place them in bridge_vlan_mcast.sh given they are
not specific to the per-VLAN multicast context? bridge_{igmp,mld}.sh
looks like a better fit.

> 
> I have some doubts on test case logs reporting. Below are the logs
> without my patchset. API used vlmc_query_intvl_test() and
> vlmc_query_response_intvl_test().
> TEST: Vlan mcast_query_interval global option default value         [ OK ]
> TEST: Vlan 10 mcast_query_interval option changed to 200            [ OK ]
> TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
> TEST: Vlan 10 mcast_query_response_interval option changed to 200   [ OK ]
> 
> I am expecting some suggestions from the logs below. And are these
> covers both IGMPv3 and MLDv2 for QQIC and MRC?
> Actually mcast_query_interval=QQIC and
> mcast_query_response_interval=MRC we already know.

Not sure what you are asking. My request was to have test cases for both
MRC and QQIC, for both IGMPv3 and MLDv2.

> 
> TEST: Vlan mcast_query_interval global option default value         [ OK ]
> TEST: Vlan 10 mcast_query_interval option changed to 200            [ OK ]
> TEST: Vlan 10 mcast_query_interval number of IGMPv2 general query   [
> OK ] -> old case added log
> TEST: Vlan 10 mcast_query_interval option changed to 6000           [ OK ]
> TEST: Vlan 10 mcast_query_interval in IGMPv3 is 60                  [ OK ]
> TEST: Vlan 10 mcast_query_interval in MLDv2 is 60                   [ OK ]
> TEST: Vlan 10 mcast_query_interval option changed to 16000          [ OK ]
> TEST: Vlan 10 mcast_query_interval in IGMPv3 is 160                 [ OK ]
> TEST: Vlan 10 mcast_query_interval in MLDv2 is 160                  [ OK ]
> TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
> TEST: Vlan 10 mcast_query_response_interval option changed to 600   [ OK ]
> TEST: Vlan 10 mcast_query_response_interval in IGMPv3 is 60         [ OK ]
> TEST: Vlan 10 mcast_query_response_interval option changed to 1600   [ OK ]
> TEST: Vlan 10 mcast_query_response_interval in IGMPv3 is 160        [ OK ]
> TEST: Vlan 10 mcast_query_response_interval option changed to 3000   [ OK ]
> TEST: Vlan 10 mcast_query_response_interval in MLDv2 is 30000       [ OK ]
> TEST: Vlan 10 mcast_query_response_interval option changed to 6000   [ OK ]
> TEST: Vlan 10 mcast_query_response_interval in MLDv2 is 60000       [ OK ]
> 
> Or is it better to name them properly instead of mcast option names, like below?
> 
> Vlan 10 mcast_query_interval:
> TEST: Number of tagged IGMPv2 general query                         [ OK ]
> TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
> TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
> TEST: MLDv2 QQIC linear value 60                                    [ OK ]
> TEST: MLDv2 QQIC non linear value 160                               [ OK ]

I find the latter clearer.

