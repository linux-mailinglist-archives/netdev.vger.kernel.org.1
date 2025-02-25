Return-Path: <netdev+bounces-169465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83384A440F1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425F47A765B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B38268FF8;
	Tue, 25 Feb 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eSG0JGpK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF73A1DB
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490459; cv=fail; b=qU0vHEsFYPYG/+NqTp8bEZnl5C6GkzT9TCU+hhrb5v90IbubGNYmPNVs5XVr0ykH1i7JoBXo+6wZ3K2ZYgNSX3ejRvxJ2OS55S9h5n+6sauD5vrNuQZIoXyNGwBUOxB6MZvSO9oxFp5dlosWoeW2FWcs09d4GZYd/y2tWm5bm8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490459; c=relaxed/simple;
	bh=LsNSU2TsSu/kEUEEXa1YoH9VzDwJ3WW/fUjShhD48Sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=d68ney3Qf48RfdnRMXa0nU+KMmW958rUyhzUXhJ6pOKgvyY2Pbe5n/la2N3tf2ZfJVYpLIJJPjMshDH/zA7R1HkTBM+rS0MDYZvWRpvI1x2PIhrBIAYQ60yWVicsMGfrE5IeWp1D0Z5hWetpCB8fTIVVdqUy3LdS2XqPfbYua40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eSG0JGpK; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUwZgoXevgmXvNxGfYHd6z6Qro+uaJaVUXVQArfTbcuMnzY461O6tn8UbMMVppwvzuarW3cFELFsyYlogty/+PfeuM830gMKtnseDAyMO3JA0ZU6Ixu/29uhq3djs9MgLvYKsw8XzeO4fLlpgYsn7Ssx60zxyg0UeAoVrAbmgukDjt6qrXtH7FUomoYdfMSW3te9EI7mCYi7hSDRbLOPOy5viw9LxFki/uZVrflpAcDzLwKzDiz5wHX4WjrJmzOxvM36XwG94EYCorSCLk7n7po8Ccd0D6F/JbcNPefxXYJo2nzNmW8WPQNWcEeXZnOmcMFLu1ijw83M2/RfdWAARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DHSQvVRp1oJoLHfY6X1Z1RwM3+WSunzkvu1IfdcFRU=;
 b=l1V9lT3XPz6N9kLy+i8mdHrxeI3LL1Sh5iOY+y90pQRdWUZExqqm89RlCnuIXgftD7pTv42W1yimLl/2U8nA+avUdMwV1cG0ZKapEJ7CZoXJS+fSdI61sdh3oYdpuNA5o/XbqMJgrZs4O7m/ZAJ8RiXtHKkoqSPz2ioURMsS25r+9IJbkYtM8pSJpuimWrFW4JsZqhL6N2cWhE/f+y3WXs1w2IuovqOFtd76+8jbd2fLYFr7Cdp0R+UNtzHjJdp3rGjs9I9l/r36T472pKrjYs7KTAAhx4fG2KEnQv9RkrswnDlels0rcVhTY2jCPfTCd5l/g9knUTCrJRMUEttx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DHSQvVRp1oJoLHfY6X1Z1RwM3+WSunzkvu1IfdcFRU=;
 b=eSG0JGpKPlvIj0Wx3yy1lrCQ3Jd0Z/4n/Q0zLxZPBUp1+X3TrgaR0efYBZ1fio2bQmz8SuNzZIeQhki6CCsihJAF73f58fUe8S/fwtxqCKB1vaeWIc81LNmLMj+lFgQTW01LCuhI4z4SLeUmNMs/wPX5SMCmFM6lbcL4yLx/FKPMTEeSfuGflvjXkkelK+yaJhIj2/TqQKWEfq7fQcDZyGH1DahtNRrHcFeBKmpbx28CpyJNyHC6h/AIjNbLEdaK15ANGp7MFzexMyUl2+xjjQTs0q9PeJ2muV1zQBjeQH4hRTnrl3W+6q1SAmcS4amNUflQSlnaXEZYgxQZSWFUZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 13:34:13 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:34:13 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v26 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <9d381da6-cef7-431e-be82-fd2888fc480a@redhat.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
 <20250221095225.2159-2-aaptel@nvidia.com>
 <9d381da6-cef7-431e-be82-fd2888fc480a@redhat.com>
Date: Tue, 25 Feb 2025 15:34:09 +0200
Message-ID: <253seo2ywq6.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0150.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8c018e-0a2f-43fd-2fd0-08dd55a1178f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+S2y46XNM2VEwGfA513muazdv/oWBY8TguALCQxAsHxIuxiaHxvqUt+91dFP?=
 =?us-ascii?Q?Hn7yA9sYdXWDjjcsMiN6MquVASwOk4eBX70kyil/TJB9RUQ5LkzE7/Wor6jd?=
 =?us-ascii?Q?gUP1aezXMYn/geP470c3bo8dDw1Y7hJPPq6xsDw64HuaPOh3UO5VrvzytmLS?=
 =?us-ascii?Q?nYdRg0Xun5U5Jm5TKZrzmdhjjckXOaGNYRVlSb03j1k2BvWBhtcIVA9GTr7y?=
 =?us-ascii?Q?Kp3431sEIF3/7fo+dNaiJOx2EScJ7ka2asvgmOoQyV3Cp93Cc8qxexO8WL3f?=
 =?us-ascii?Q?ApgXC8GcpWhgmFesZmIfVgKPPnhUezOIh8JfVy2JQ4EgJhVPouKVCvo/M/2t?=
 =?us-ascii?Q?/uxtJqQAcvCcwTV9ua98AleexZENOWRzoycqNLTbLXlLXpU5tlBxhduPiBKT?=
 =?us-ascii?Q?bTStYiKYlXUOVrYXTlTMCwtCQnlo+WPbF4wzQYuCDtc4Ffpyto+seT+gdx02?=
 =?us-ascii?Q?zDtJAGApR4pe6YSIu2TSfDpPrjSCCggjlLotfV9rkuFRY+YDabEPC1bXqTQt?=
 =?us-ascii?Q?DLxiRHvC1D0WPHFXtTxst/BipOyScHWUgajRj7+0YV3A6g9ljNZKeMuDC+Ik?=
 =?us-ascii?Q?/K+un/Hy2LkKDw5Yn2GCH8v4uD/hL7vMcaF/9RXvjKdd2RvGqtUrmuS00Ifr?=
 =?us-ascii?Q?Huu469G5IiFKw+3QaMSxm+r3ER5DG9z38+fFhRsKimTHtWg3La2dUcWjJaWz?=
 =?us-ascii?Q?ncIQUh22sKeiIWRnX7q0h/J+Ni0LGYoPv1tk5b5pNWv4szsKPGcXqGfiEeSq?=
 =?us-ascii?Q?HhBZCIrIPpo7ViCu8siGlsWCeaJNzYkGwOFgl8ac4lb7hmLMP/pST5BKPn5s?=
 =?us-ascii?Q?ryBQql3u6BiLPSPTXRmvbkB4HfHxUVor84/4kWJg7SoG2eEaIMfCDNDJv300?=
 =?us-ascii?Q?zRorWq7bRzfHWGvMhUMkc14PPIddBa1ZxMU7gBbGmIrQZCAW3q77GxQJdpnA?=
 =?us-ascii?Q?u8fgWgipXOD4pJsXGTx+7LRb1BfTEje0/5e9WbdfWPThfqtlGkFm61x56/gx?=
 =?us-ascii?Q?1Wbc0EKigATaowfm0+Z8TgJ/pk0pFKX6I852CtSinzIxSRdTomCW6TCkuKXe?=
 =?us-ascii?Q?7yooAyvW5U8tbQGw6pcTJn7rb2KecOGc8UdRyMYbcbBglM5VY8r0azkDMOGA?=
 =?us-ascii?Q?aQ/sstFkDeg1og0ag6EfSozCjEqI+yPY1hKFIl+tsu/Pe7W+Q0TFMPVqDvnM?=
 =?us-ascii?Q?DjOb0Vet0FvkPkX6eiy0nihI8QbcvwMB3aS3Vn4tMAF+x9BEo+lA/l6FiCfZ?=
 =?us-ascii?Q?B5vpM0kDPZ71+CMKqVL8X8WC7VzGqZG0s93aDAJD14/KvfKAiJz497EvxuJ3?=
 =?us-ascii?Q?EvQ1fyHfZ7xXzeQHxFBwpfxSbWDO3KgTGs5UEX6eEK7XzO5dJfzJpfVwYlF0?=
 =?us-ascii?Q?vJwuY6WhfEAkd5boWohHHaC1ZBW/+m5jlC67JAztzuOD4OHB8RTVl2D19K2b?=
 =?us-ascii?Q?LC26JDfhDzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l3xbMKJNK6V6sbiFpLLLT7rCcVcycTRiJkFgyHtBevWZP6wdXUozeG8DzYjb?=
 =?us-ascii?Q?/S9sZ/EsEugwV15SkYeu3xhQcqUCoymodFPTzmbVVj/POKQyU5CYpEjBnsET?=
 =?us-ascii?Q?vSnvWEPmdyYjJY+c7BSQkKVaOyucOEv93bHLKfJuwONhnOYwHHFEVJnR2rzt?=
 =?us-ascii?Q?J5VyZA0OLqYUx+VER15A4dtVyRb+lApwCSU0SWX2fqoW391AZlY+gZgieJcd?=
 =?us-ascii?Q?dFgNIYaKsXDJ3ntwdKZYQ8heln+xzcWt90vaGqKUxMutRkY7UVN0zr1bKNeQ?=
 =?us-ascii?Q?WNjlUkr0ygJdGzcAd6XhAWqg2qRqt9PwGdzDilI1j7rnpTfhi5FpmzGdd1YH?=
 =?us-ascii?Q?yjT2c/isHD2NsVeqH1KhkSOaEE46aSz3gxsHbXbWz7wpMqSoxOdgT+vPFro3?=
 =?us-ascii?Q?DzoEkhianq7BzorMf9QhH/zcgemI21Sxg+pQshDlrUADRdI4NdjYIkeZ7RlP?=
 =?us-ascii?Q?1SQiQIt2gik4IiDWWGM25rgvlbjEFkxEoQLG6ardEn37+LgkYpw0zcOdrjZa?=
 =?us-ascii?Q?FwWj+cXlPC+925X6ZeNCm04sxsnV1+jlrC3ZKaIIjkU6yu8oroy7+lx8EFnh?=
 =?us-ascii?Q?DzS5mGU8AzoK16phdeKJyx3ZYOO9WCVPBwI4tPW8f8MQbq/pxC3AD9NvMEb1?=
 =?us-ascii?Q?gbj0qKqPc//Rt/UDgaU9LE/AlUWziBMsRf0bGBwwZNA4i86FigORUnDgaDar?=
 =?us-ascii?Q?50H7EiGir5duaywmU9riW3poRLHd29opxIiF2fTbCTqm/lKE2l1v6SEItTqH?=
 =?us-ascii?Q?AiBCKvQBMwPOq+v2bth5TWweTdSValkEnA64m0Kta0YehP1QiEAJK5Zdeh0z?=
 =?us-ascii?Q?x816k0aYnhjeKC44FJKSq/Npjon+IXNKqPm5VxqzoatMuJ3mjEntDuD3ykc7?=
 =?us-ascii?Q?EowGO9XYUUA8D568lWIoqila1EqwFGtzakGpTlm/Zd88151CRv0DjiQd2uY1?=
 =?us-ascii?Q?lJnHG8RjFnOv4tVlQ3R7oG+MfEOVaOCZrpdivI2DR4QOjbj/UvxlY3ufPJ8W?=
 =?us-ascii?Q?IivJjJ4ViQRQtGiA9gbWJPsZowynBBdSompf3t07nKzWC6VWR9EKO3IoLX7b?=
 =?us-ascii?Q?IRaWnbYiZOnJyv8FelDmmQL/4SdowDPUpqPl/8FzXiP/8QQBRQ9+IqrLORgJ?=
 =?us-ascii?Q?kC4BWqlDDWLI3OvEuJUbTbbGxmy87prHDEkCbyevc51RrLAZaH3FEiWjGTg7?=
 =?us-ascii?Q?PcJ1m40RaDEO5ZjYhOdWf5YrOvyfQ1sAzObQa6WRUEjwrAlgEW7GWfxFqobm?=
 =?us-ascii?Q?ZpdfER7lyxE5ZpdVOpprZH8eg1lqVM2V/Cy9Gve5mKNdXljlPVAPmQk/1quM?=
 =?us-ascii?Q?RJ+0DgAdIVg+Uznlra7fcGAzbrFW+eFVS54lxQiw37riCnwY9k5wwsd9BkQG?=
 =?us-ascii?Q?8uJ63RSjc5NWJVR84ABEMcLwn7k6HpECYVK+md17V8NjeS8OCaT+m3c5CKuv?=
 =?us-ascii?Q?4SlcQZBTGDq8paqk4DdjCe/HHECpP8/clhH2sxDUfnjsCE3tg0V1hVMYQahV?=
 =?us-ascii?Q?qByLH4d7toekb19RkbbH/Pq8lAzT4gZazd3hDodon4s6Vh76yFiSYzNGAjab?=
 =?us-ascii?Q?Vu9fnU7r0kYAN8oajQYhEb8qA9LJZD6iZmxzxCdK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8c018e-0a2f-43fd-2fd0-08dd55a1178f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:34:13.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJtdqfMNcjFnxRHIvtbQgFtnwNIH5Agm9j2rVW4jFH923S0WeA9JViJDVz1dw8TCaWzN7L4AMGX0QyUbXmet9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

Paolo Abeni <pabeni@redhat.com> writes:
>> +     /* put in ulp_ddp_sk_del() */
>> +     dev_hold(netdev);
>
> You should use netdev_hold()/netdev_put() instead, with a paired reftracker.

Ok, we will pass the tracker as argument.

>>       flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>>       flush |= skb_cmp_decrypted(p, skb);
>> +     flush |= skb_is_ulp_crc(p) != skb_is_ulp_crc(skb);
>
> Possibly a `skb_cmp_ulp_crc()` helper would be cleaner.

Sure, we will make a skb_cmp_ulp_crc() helper.

Thanks

