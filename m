Return-Path: <netdev+bounces-202924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB11AEFB7C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F833A6BBE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9A27E7D8;
	Tue,  1 Jul 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2MhA+Ub"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C727E047
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378225; cv=fail; b=DOf8tBJXQD0lQBzPzd77fx2eWd+xQ5GDre9xBcZwq3uiww4graGor/OgmtdgjcYShqEoxvAyctdjmaPEKCNuFP1fDdW740eELCjhAPFCMXtN3XoqE6L22WJCGS6o3IY5gDyOk/JC0u+r/5HVmknl77cjBYqMxgtSs4tt8+CFhJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378225; c=relaxed/simple;
	bh=Du+2369K3zjJXUYWaSnmvqCcTnFQEPHqR5Ss2Bg3Xck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=mDw26F+aMGZryzQrywACVRZNDwrJbPkMslJGeo2EEcoFA1yoReBZ0DukzU1LGS9YQArfI0uHWVder5GkbH6ec7G711fU3l5VRJxy7LdVclqFzeyRV8q0DqlkUNsW9Nma/eizuUx7ZY4g9O+XsbHkD7oFe3LM2NkFTS+FAYQpgBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2MhA+Ub; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXrNw7JDTZ8JT3z0Efw3HEIfRdrTR0vQ5LyRtaE//CYV4J1I+cztn5bO4zaff57kEb7VqOKfRLsqAGM5jIZrk3rMHypXLsXxmFML3a+UoR4LDhmq2bl1phtxNyWMjU8i0AdyVti7FHv6xfkVu8V2Bfjoyzvg5Chh4DvzFvYggBhQB2fVqH4jnFXTvCAXZhmdBab5jqE/JSJwINO6AVWDOWQPNShBAcv9VKiWWi17F+PM0ZJt7MIdd+FMTQDE0Pd4kKkhAw7arT/VEGZZDV6jYNuNfJb0eQE9BWsJQebBD6ZdbUB2Kc08lHiCFzau+OuljyPbxnUDElJwzr2QC8/xuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZODv+jnSIE5++o+X/YITclKXlfTcBKuWaC31hQfGls=;
 b=DtvpLL/xgtkmGOxw0yzyVqS750i4nQQozSnN7/IctImZF790Is4Sj+Bag2ftFNf5zMFOevWnPp14kHPV4cQYjFNi71qFpoQZsnMOTa+wymHDjScBlMmXDc6AbAOc8220jcgn6TuvUM7YDjeI7C1jgI0tBAYBcY4lTjrxqAoMRiPbi/dV+vU86JjGlt7qbQPoPeABTik7cNFAvscF1dTSl984/K55IfxjWtvL3fRmboh8ZPUTWOF9y/35BFvqd0Y5fHL4va2E0myPzR+vJQ50nryOeJLAlZHu6lKIBAfwS+dsOpvT974tYdORLqq9dERCDGzFhT7/jtTCh41PrQo6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZODv+jnSIE5++o+X/YITclKXlfTcBKuWaC31hQfGls=;
 b=h2MhA+UbSGXzhhoYRFnolJwrptolQcdYD7sIOV6xVTD8CwyDEqEWh6BVEpFyaATA7ji54PGKi6erLAueLKxWGflBOCsrPsU5Ylc16yxFZpLp0cH5GNOM3xoN+Cd/lcduaLGDZ2OHwJ3CIgRmXH+p+kRa+/8IvMjOvuWUSG45yo/z+L0yZXutBR/f0RorLeaARWA8GIuLvM/+L5tL5zrfh4cFLoVPbKLnR6hv4qIDUli7ngrkDzfkfL1rescKdBNrQgnD1EJpGN5Dgt/0uM+inGsKywtbRxs5rjpleLPby07wRbvn//3oIjp7sidyOKkYNIjUINetg0Pvupj9Xt3IsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 1 Jul
 2025 13:57:00 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 13:57:00 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH v29 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
In-Reply-To: <20250701125008.GP41770@horms.kernel.org>
References: <20250630140737.28662-1-aaptel@nvidia.com>
 <20250630140737.28662-3-aaptel@nvidia.com>
 <20250701125008.GP41770@horms.kernel.org>
Date: Tue, 01 Jul 2025 16:56:56 +0300
Message-ID: <2535xgc3tg7.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: e12fb444-ca36-41ee-1c03-08ddb8a726b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bwEdUhGuw9iqp789nzZC9XosISVcZtOVQhyI5aDuZOOUvui3G0WGkUapb7Ow?=
 =?us-ascii?Q?5HFue+mutoTos1UmL6zK+JOU9jGUjx1RXzZHUcNfKZj5OPD9ruEEyKsJkCY3?=
 =?us-ascii?Q?ce8WdHrke/WgrQlytokkzznXHkp9YOPdxrlM5ErXouFEtXpPPUpuRbyAFEUQ?=
 =?us-ascii?Q?SIwk/i8WGFZJD/n9XdlZK7tFjCWd8rPcKgdshh9eKtSVCj7wEX3u9T3RrLhv?=
 =?us-ascii?Q?3P53m5gSSRCS3HymBbDegcMus66M8inUq81MzHvQ+hKg9SzD6aV0j5LPSkjp?=
 =?us-ascii?Q?yjviQT6J+8PbmFCQ5q/fuf+JKBK8Moi7zfY3PWG0YqHIXuAQD+5QjT2iB9Yp?=
 =?us-ascii?Q?MFq/KotpXxHweIAfsm3IwLVVj9Y9iQQpEtjpa0pgnBIBXILEHMAKuTNLvVsh?=
 =?us-ascii?Q?0PyCYs/d2am9DOLQXqbf5x+Gy4CgadNK0qwXyVIsXpy1xWwvIiYq0I188FLG?=
 =?us-ascii?Q?4d0kkSBtoXFadMayewskYiP7TeBQqHDlND82uaA2pPS2h/qKcMvkz4EqQZMU?=
 =?us-ascii?Q?Mfr2fbKGWguaCNSwYFUKCPKAfgPSLT0UZzr4xboFljpd5DDpyouLTbzddHRE?=
 =?us-ascii?Q?YjlVFPZG0GjPTf6yHZSi49XC1sJuQpVFq3UbjAjyk5f9OOV9YhT4mGBRUBJT?=
 =?us-ascii?Q?a5jR+CpW+nm30AlPyx78mZCicpNtSdWQTfPar6XV6m6KCMUOGOrUcD5DlamH?=
 =?us-ascii?Q?ENJA+9aLJ33nGAIdBxEX1h2QdSetbyuaGm8AvdfkT+wW/XSu2SZX3/W7WZ8o?=
 =?us-ascii?Q?LA+P/UEHdamN0LKvgNaYWjI3htVAKUOtN2OHziQxQMrLTw2EgbTg7HxvQyWQ?=
 =?us-ascii?Q?sjXGKKK/mMJvh2P86ZUX1VerBGtmBw1KwIBpctdofoF7zwVxZ6gqxnpQn5kZ?=
 =?us-ascii?Q?g6VwNPI9HePHJRCpjAjRCrXMOHku486HYms4zUUISYPLbclt9oUkEQOyBne5?=
 =?us-ascii?Q?p8m/MUBIEgE6W2xPZAMQJDQmE5A/d4VuGzGCkIxtznWFlctTCkKFCqhYvRBE?=
 =?us-ascii?Q?vUogYCvioGTCntlyk8ZQTa6hUuBmtUr2WlDBe4uBkUz3UzZnADpBMHVZU7Bo?=
 =?us-ascii?Q?fBIZHVS1HTQDIxW3tlqEzgE19fL4Hqs0qrkw/0qswYTxgBPwDAr0XRXY5bqC?=
 =?us-ascii?Q?lrv4iJKLMhU/S62owGIlFfflHUpfNMRyhK0Gch+4ufVAlKMFVBhD3YZ4zn7P?=
 =?us-ascii?Q?qxKS8HWWYriicnx73HQa/ZvKoM6zSMeUR7WiSXWA0SEHDN4VnADqWaN1e3WF?=
 =?us-ascii?Q?FzZNTbbh2sQRZivkIycetmyMWGptwne/pIGtE6amHLBAUyMJDpxBFSWc+Gku?=
 =?us-ascii?Q?eKFn7tJD7KhrphMJUjA4LCuU74chF58GPrwSxSGupX3/eqzQs6XqmQ+7Dl+t?=
 =?us-ascii?Q?fFCZqNrSRt212+Gbemc/qdvpoRV1qaY9aBm9qTkBb4nrtbwaZKs8XljA+b3p?=
 =?us-ascii?Q?aiGrDOJLuJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M23EP1Qk+lbqatwfal2RQAPDkcOCGHo3IJtCGCNftyv/3Sbi6AbqHmrDt4ff?=
 =?us-ascii?Q?UlsR/lVTY0wCKk71CRRfMaq+7T5Xua7nM4zTKMH3V5sg5U9JqJxrfpF7WmiX?=
 =?us-ascii?Q?7YYiu1qZ0XqqLkb0BP/ucKSaXhIoKj78IqTNN7DN72hk7wTc/EZFynBL8OKf?=
 =?us-ascii?Q?RErXuzqaa/2cguWPjnBX0i+nsMdggYRoedlKeUhBG/9leQLZ9BsjN/ceuICB?=
 =?us-ascii?Q?QazA3nZVPuTsDOTpuEx616R9oYbn3LTqUGI5GhuXk4RIHLZGoEBxE/b6679V?=
 =?us-ascii?Q?iUy8NIOYCy/zl7iR8lqw+EH7/YlCAIpO7F7S6sCEKrwJKvHP/9/+Ez44W8yf?=
 =?us-ascii?Q?+TqHdUlcZP4ipYlb6BiAaAW3n+ZJTEXojXZsXAfdImh6i3+XtdCQkljKMuB6?=
 =?us-ascii?Q?gBLZf+c67MGzYxQh1/gSx9lnGkI7lxBCVqHSV5YioJdtcNAw1yLW5yEKZ52j?=
 =?us-ascii?Q?RUHh/paIdnldE7jZYjmzh9USGV1XQnA6SBdWylxq1/L2aYpOTwH/UWkWiLHV?=
 =?us-ascii?Q?35j70yzCzMqAgnlZA2Dnr6hD+wC0RH3I66Ht3Cdo+BXEoD08vDBq6bNvTtHV?=
 =?us-ascii?Q?y2kLuqBHBeAZhTBMPRzpfDgVxoOQFObtRLDwolxM33lHI+nlIJ2/MQETIwqs?=
 =?us-ascii?Q?qRITvd6/yY6xA6res78VSzpS/L3rijRdevgWVaxNPLVqAbl3eUCmGzsIksPT?=
 =?us-ascii?Q?pb3xPR5+bku7NSSa7HTOaeZGFa00JrII3QZs+5NTO/LyJLYrwAyTC8qBjULM?=
 =?us-ascii?Q?oWhkrXCuP0gp8XOmIowKPxUDBTgAgCOfBJ3bsbLp/ayujbJTXKUJGEuzDdCY?=
 =?us-ascii?Q?VVC1PRC+SUVNE8SZr4MoQcKupPx+knWDviZfKd1qg6v/N8S+UIZIHcE6lK/q?=
 =?us-ascii?Q?0BoHgxzo2EKym5xq11BKHkXKKBVTF4Ld4ji7ugbcmYsjgJLy754bVluKrFCW?=
 =?us-ascii?Q?K8uW3UAuSjFojUg8pOSm3tK4Q6wncJ8ytSIB+aMJz4va9Nfp/UW+KdwUN42x?=
 =?us-ascii?Q?15r5u65AbleUG2vsZYIb+haHLcAPhrDJRO6/lWAAubi2Q7GnQc6oUHtPi6XX?=
 =?us-ascii?Q?ToVvpk0tWkOHPvuQnZcj5O+tfPGKf+Ll3pC++RZ/iGENu3VpBCJ/EkEs/bKO?=
 =?us-ascii?Q?DH3A/BXuXox+fm9BHDdCI81CxOYJ0aNK7drBYkOUpq62tCFr2Wgst/wx1E/J?=
 =?us-ascii?Q?eToGuD0vI0HfBYHfab/QLhTZEZIY+0Nnz7tXt3fWtdwW4oX0de3KhyeFQ+6q?=
 =?us-ascii?Q?0kzSsL3oAjCvco6maz2XyOVLO97gTNWGC5aJzOiEMLraOOvwSn6JTHqSua/h?=
 =?us-ascii?Q?a2GKwwu9W/FzNbjiBflHuqMmVWzKC9v3kmT3mkOjNVB+HKouTFtX6HT65172?=
 =?us-ascii?Q?KFo8baGW7ESIrnQMA59g/m0NyvftJ9QONYqU/x2ge1M6mhyT7496E3hXhZaZ?=
 =?us-ascii?Q?bUW/oVQWZ9FumrPJA7vt5ryDpvRy8UAIhLmpFgO8Vwa89Yuqq5o/cxJWqJgA?=
 =?us-ascii?Q?eSwQLjaVSH+dashtvQlpC0BZSIzB4ecG5mqTzwOz+/oDv+rzWyA4Aj4bRM/u?=
 =?us-ascii?Q?YZNZEGuXe23eMzqa56sDKoW6CH2yVgMKPvI+Oi4H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12fb444-ca36-41ee-1c03-08ddb8a726b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:57:00.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLhtEcDVJ4snhAZMnGFvhZOLl22l+u+NStB3Ru5pnv2SK0ftWM57OLLhshSxIxOcHHa0crWoWX6YIKaCTC2iOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322

Simon Horman <horms@kernel.org> writes:
>> +name: ulp_ddp
>
> I think that the name needs to avoid using '_' ('-' seems ok)
> in order for make -C tools/net/ynl/ to run successfully
> on current net-next.

>> +        name: wanted_mask
>
> Likewise here.
>
>> +            - wanted_mask
>
> And correspondingly, here.
>

Sure, we will replace the _ with -.

Thanks

