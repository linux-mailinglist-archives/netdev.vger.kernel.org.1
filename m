Return-Path: <netdev+bounces-87759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ADA8A471C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 04:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064EC1F20F89
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3355E134A5;
	Mon, 15 Apr 2024 02:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DDZCo2br";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GizDKFIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDEA5695
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149527; cv=fail; b=SyMe6AmO/X9jJO6RlLoCo5Lpy7YwFnAgH6Z30eWoQ9PP9QH4HfGxBrIenzsu8jfWFK3wyydDF3kfD5aqV7nfJMaDMs3enbAxwHm++dUPBIZvY+6XKWLNIXi3ngnTvqx8YQH6Ta+eLYOfwbhiXpslq/DQ5yRxAJlrKT9BKtzo2EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149527; c=relaxed/simple;
	bh=SdGRKHb/9Bf8pphwhxytfORwNeu0e9Gqb2DXYMmiJQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jk6DMebXVNvjz5YfP9vVkx/XpkoZybADQW5sDWPCdk8DJMIYNb5acEE9hgO0Kq/3LZx4KtAzllEXHjZzTQoHKlMImb8RpPO089ehO9NSLpDYSChDMPRV1Y3E9IBbDgI1ovuQzlaSyokOH/rodO5HLsFf2Vleq4CS80pYaAInyGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DDZCo2br; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GizDKFIQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43F20Iav005045;
	Mon, 15 Apr 2024 02:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8RBFUn+QUCNqNfBlwaS+yz7SJ9csyhQtBuUg0n9bzRY=;
 b=DDZCo2brguUGAEX/YkIjLlaW3ij9DoTx6lXOn8QNTsCj3G/ohySzusCLOr7bD8Uvjbyf
 7n0f/4QyvJeQ6Ixxy0iAb+2+f9qzQusK4+n4XIZw+g+74cmpWvlJL6LOcBHf4oXHUWnU
 rroDMWyT/9Ssqayb3BhyaAD5RAi9WBDQW7zsxsHvH1ky0yzw7zOCVvy1BdtojiP0xZp5
 mDtWV/rXXz8vtNBbsyEi3X47JyA3W2tpxujNIztRhs64ERWEkKJBRox6lJbc1NnDBG8W
 weMz7ltEVhrxDpCwbttELJJH3cI0dj+5aRLzR9G9Vx2/MwYA8bk6DK1OmFWGtIlkf16U YQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2hrdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 02:26:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43F0GPP8021593;
	Mon, 15 Apr 2024 02:26:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggbdtkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 02:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeMyH8r1WoaVOkw3wo24ecGOh70XfBzF6t7wYSQs/X+7xPBJJNpXewJLvxa5tNpfisZAZEZZDDMzxNp+OfctE8swhETjJsmCLKIQh4dXEBnaWfAo3OnYEmwr0uyBf6MCCq6Rhg5mcyKj558SCpyN3yJ4mXNjWkzUsp1aWnBNqtnKWt1M12ETIaHkVHtL4wcPy8fabdOS9ZC67fWWeN+Zu6GhNB1d1N02LcmW+ryLAW0cqGaOle75z0V3Jo8c43ydXORtZ3l/9e8z03WyduJa8VtPzXcQ9+TmpPGzco2vvmLpulQuyyMBCaNGo7Yj+Bi3AQB+vB5LCtwVmN8bCgCLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RBFUn+QUCNqNfBlwaS+yz7SJ9csyhQtBuUg0n9bzRY=;
 b=BcSliUg85UntlH7620vycGIe98F/A88NFC2Q3gl4XUgf5QJzlW/XIhQ+Se5KsheLXVLIOCD07+qkCOu3fny8bFPuJijxcF5mGD2Xa8YZ8qRmRhVVhhKvz/iFvZJN1l2M2Ly657bdloizdTctmhM1s0oggEvzl0nqSH+eVEOrlXUrEwF0Ayb/WX3f7bbRyoByQWzCpUn7C7bH9+HD4t8kweuxB/D/zlugETjkDmlwuXYSjOoZkQTpjYo4O3el1MVNFBtH4IUi8IGsyGHg5fH1OqseAyd0bCC47w/RiK2HMvCkUbhAnnNN/6FcdCVpLX1+Jc/0+cv6tHaGekM6R8XyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RBFUn+QUCNqNfBlwaS+yz7SJ9csyhQtBuUg0n9bzRY=;
 b=GizDKFIQzVo+TGTFwmIJ7KGEV6zJ7TNAdgvqqn8aWlLpTi9HgBxZMQiJFltdeWtn0ZnNvDkPhEFEYU1JHYph5stEA0Bxld7dpgWdkJzF/+dMwVgqvNstl/w891CbwLqr3FY54DkC2JkxvOmsecKS2URU64dJzyIPNEphWIAPPrk=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by LV3PR10MB7748.namprd10.prod.outlook.com (2603:10b6:408:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 15 Apr
 2024 02:26:13 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%4]) with mapi id 15.20.7409.053; Mon, 15 Apr 2024
 02:26:12 +0000
Message-ID: <acd7dda5-0e80-4bda-b484-55515aac8fd8@oracle.com>
Date: Sun, 14 Apr 2024 19:26:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 1/2] af_unix: Call manage_oob() for every skb in
 unix_stream_read_generic().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20240410171016.7621-1-kuniyu@amazon.com>
 <20240410171016.7621-2-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240410171016.7621-2-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::6) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|LV3PR10MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b2fa7c-4942-4808-a923-08dc5cf36b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NlzadLZgH8r1HwjGaZbYoUZu392v/CVBsFjG+MF2xcKWyjaW9HzasF0wUKlQPmYDX7m1P/apq0S+heuHQCQVHdpNiAUV6aIFHYwKIQXXHe3EGUPApoJ/87Tv0ofRUxw1Zsy4SHPt9VJpT8YZ3hKkGwlb1pZVYr59syhisWyc6y9kyMiIpOlStHzn7iitroPaVBup1+qmabsfy/le/l/NGIHvii7s0Jw49FyeMPfVaPtW8OfB//d5xrXF1EfMPEGTnAsvexPOxXA79/4O7rs+ErRNjeryBFWl5vwifysBz+aYzouUu9kTPbQeJ8LUeBCYscyBPF3hxSNdcaBZnlgp9G5WL3Eflt14lCavwCklbWGCYJQFOay7MEURa9Fxq3JdzQheYXLWscV1Rw9dIo0SjUL53tmDoAzYHbJNAE4AiFlrTiy1qpKB/585rIgKqCZbHxzvmRAVgRZclTrroUUcJai5/N7vhEC1KmPPUSso0deFgA1l+UMez2xJkwcEXyQmk45JHUcrl0nEKyKEoNPCnHt1Fs8NaAKttPWQfc27UTyfK5QtYsmACrofyRXAV+0Xe2jtXBBieysYgXgjedRGI0Ejcubq7Y1dDqFjSPuoQpwzBb/jl6uznc2mz/JFJDrFlLl99b6bfdcwP+SCBpbj2YIGGi/ht0COsdgUNdautZc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGhYN0h4dE5lckc4TGxGSDNEdEhkNzZaNXNnTzJRSERmMXVCZnRwYkp4WHB4?=
 =?utf-8?B?M0hTUHcrNVZaY3lmQ1Z0VXg4SCtONWdVYXNPNlcwUzRuOWN0VDBIZDhSL2or?=
 =?utf-8?B?c2ZzZWVDcmViMHJkWldOWW5SQjhxLzgxblpDc3JRRThQYVBkb1Y0bmpIdEFu?=
 =?utf-8?B?Um5rN3NrVk4yUytWa24xcFFZRGJQWHVsOStJUWFoNmoyTVljdEJYMS9wdkhj?=
 =?utf-8?B?SjYzemhjd0Vock9yS21GemQ1Q3A1RURPSFBwc09TaUtERkdnRmpvSVRTcCta?=
 =?utf-8?B?RDl3Nm91Q3N1aFN1NzBiMzBRd29hdWlUdzc5RjBuTkNXcXl2Z2N0SFFEYjJO?=
 =?utf-8?B?aWNBdnFhazRwWFpMRTdGQzhvLzJkRlBhaHF0WWMzRWVOakRCZnRrOFc4ai85?=
 =?utf-8?B?VVBnbnpyRnMyZVZDRmMzU2dCNzlidWcvbkRDYzB5THV4NWVuTTdYT1c3Nm1D?=
 =?utf-8?B?NlRzK3I5Tkw2dmNyYStkS0RuOGJKK2lyMDhXbmVpWC9BMlE5ZE9vMmdjbEtK?=
 =?utf-8?B?MDM3ZkR0ZmdyalhVZHBEbXFSUmZLNXVEUFFLOThiOTNqL0x4cFh5ZWV0ZlQr?=
 =?utf-8?B?RlRvcjFXa2w3SE9ETExpWVQ4NUVWOGVHZFU4aUlJQlRnbHpUMkk2b1lKNTZY?=
 =?utf-8?B?dHVyU25NbmYxaFNnZ2thWHRxUEwyUVdmWFZxc1h1STJkQTJiUzRXZ2dneW56?=
 =?utf-8?B?TFlWS1EvenF3NmM0VjhnVG5Cd20wU1ZLRjJ5RC9sWFBrRzViYzVaZUpoL1FR?=
 =?utf-8?B?UndHQmkrZmtGK3lvOEVuMVpDYk1XbEpzVU5IbGpPUVJ5OWhPUXBwOU1HbktU?=
 =?utf-8?B?Q3lydmhZQnhiSUdBQjhzRnIwdnFldHVFZ1pXdHNUZW4rR1FrSTA5WCtxbGNv?=
 =?utf-8?B?ZWhVUjJtdjJvQ0ZVbGpoa1NnTldtdVZGNlFhWjIydFZBUEMrNzBIUVd0N2ZV?=
 =?utf-8?B?cDB6WEVnS0xyQzQvRk9RRjJyQ1dRVXB1aEZLRDV2SzE3WlNxa3lra3VzNjQ2?=
 =?utf-8?B?SEphYjY2NWRESXVHOHlGeG02aDdKV2pmQlUzaVRKLzhTS3VwSU5ESnpmL0VO?=
 =?utf-8?B?bjJlYlVFMjRzY0JCWXd6RlgySlJLM2xOUkFFUHMyWXJCNmRlRmo1Z0h5VG5k?=
 =?utf-8?B?YzRLV3A4ZDNVWVFKRGsxMEcrNFJUSlB3bFVKN2lnUzE2Y3RkSE9lNTFHdkJ6?=
 =?utf-8?B?VSttRjlOT1JwbDk2V3ZYaklWOEVVOGNrYng0MWxkdUlBU2lWNlVubU9uMzYw?=
 =?utf-8?B?aEJmaHl1ZjhDclo2RC91QkcwSFdmblF3NnY4Nm5BV085NFRWcHZlNnNLcDEw?=
 =?utf-8?B?RGlUdXphZDdoaDBZZVA3RDkzdDVuRlJGajJPSHI1ZTgwY1lBcUJrTEh2ZFFh?=
 =?utf-8?B?SGNRRVU3MlFnMU8wS0lxUkltanI4bWZPa3BjbHQ3dVJjODgrRGJGRU5IREtL?=
 =?utf-8?B?eWtERWhpNFFHQlFYQzRRa2RMUXUxQjlZOW11SFRFcWtqNUhNMjRacmk1U25G?=
 =?utf-8?B?SERMbzBZajBEeWN2UGdGYVdUWk9lbjFoOHhLaWNETVd3Zk03VzhjR3UrN1dy?=
 =?utf-8?B?QWZuNHptOFhDbjVRRndxaEhQb2kxaklSczV2NkRsSEJpby9lU3dMNHBVV25r?=
 =?utf-8?B?UVRndDVpSXZZbTAydzF0bTBWMTFJT3dEZU0zQkEyZGRzM29TU2kwYzd2QWJV?=
 =?utf-8?B?RjdoZzA5VzEzWW5NSFM2a2dMaXltYlZMeVE4YWdORC90WkhwWGtzQmtIZytV?=
 =?utf-8?B?dFBFNUQ4VVJ4aDhVaWU4VG1tYWZRYWEwekswbjRBY0FIZTNoSTQ2bnlxWm92?=
 =?utf-8?B?VStwakRNTG9peUhVUlRFZjkvcXZyZUplMjAvS016UmFjQURua2dBUkYvV2pl?=
 =?utf-8?B?L0J4aE9lQnNxR2RtYm9Xa3hPNVhSMUs2Yzg4anppUVlUUEhILzRuZXVPQWtW?=
 =?utf-8?B?dE8wcUJxbzlLczZLMzVwVVZnT2xlMVpkeHp6M01ENkpLaUNGd0g0eVB2UjVV?=
 =?utf-8?B?bDZaYmJhSDRJQkpmaFV1SGN6U0oycVlFRm1YVzZ0bjc0aTIvM0REbHRrNXFx?=
 =?utf-8?B?eXlPMEZwU0VwLzJuK21abXRHdys2cHJ1Sk1GVkNGNU5hQU44QUJUSURQcElp?=
 =?utf-8?Q?Adi08oRlIkbgX2bp/lUjHtfEq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fcQb6ztRkFYujex2ziTPmfvCNEeV9ceWHoE2/LTNMgAucdlEJ0JwJDW/Dj/KZuYwLNPjmab+OfPUTLT6Oa1cvnwzEi60zbm5HNWlaTlOfJi6gwS8Ov7nUhYmexifIDPNzBKVSQUaEMQMKTsI8bFVv/FHQqg3MbY25GSp+eRtxfdny69t/+N7oZ6nvlq/ZfudHcswYzYobAwkWtcdg5jAWwOErkM5yvPMLUgeEjLeHOuh+uxzteRNfpDX9drIIniqA2L7AbMhApsSV0+EvgAFgCWq/zIGmFicl892uTsYh1+he4VPZkVRwY+1Hkn5H+Ht6Qh3762en6EWSFgz4QRjIPT1m5TMrS9+CcVPgFIPIHBNE57Ssq/hdHQjNIVaQnPzedb9AsFMaUqDncePNmzgkWRPKq5HOwy+mEG2Y3xR7U6ub1drStpGT1YUeu1Hv3zvahmJk5qA/4OghcJojY4plFAenVZISJV4xZiP0moBPcI027Mik9kHL5nCcxzJz/pn52PXji9SXbyW0v4tsOEH//NqKMY85WEnKfvLw8RYdBLK5QM56X5zRp78o7ApY3RwUboZCU0/bJUjvAYX3mYXAPA04iI3Fk0VQz+hq7joLQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b2fa7c-4942-4808-a923-08dc5cf36b3d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:26:12.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C+JYBxVHpmPzDveTMgkjJEyaqFFeZVZK7gpHGqpWUGG4HAkdR/Gr6l0dktO5zlxSCP5J0Y3KV2lyQdMZoUkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_01,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150015
X-Proofpoint-ORIG-GUID: xPlxduEK8KcqRaFR_TVPjWlA4NnAw3hJ
X-Proofpoint-GUID: xPlxduEK8KcqRaFR_TVPjWlA4NnAw3hJ



On 4/10/24 10:10, Kuniyuki Iwashima wrote:
> When we call recv() for AF_UNIX socket, we first peek one skb and
> calls manage_oob() to check if the skb is sent with MSG_OOB.
> 
> However, when we fetch the next (and the following) skb, manage_oob()
> is not called now, leading a wrong behaviour.
> 
> Let's say a socket send()s "hello" with MSG_OOB and the peer tries
> to recv() 5 bytes with MSG_PEEK.  Here, we should get only "hell"
> without 'o', but actually not:
> 
>    >>> from socket import *
>    >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>    >>> c1.send(b'hello', MSG_OOB)
>    5
>    >>> c2.recv(5, MSG_PEEK)
>    b'hello'
> 
> The first skb fills 4 bytes, and the next skb is peeked but not
> properly checked by manage_oob().
> 
> Let's move up the again label to call manage_oob() for evry skb.
> 
> With this patch:
> 
>    >>> from socket import *
>    >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>    >>> c1.send(b'hello', MSG_OOB)
>    5
>    >>> c2.recv(5, MSG_PEEK)
>    b'hell'
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/unix/af_unix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index d032eb5fa6df..f297320438bf 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2741,6 +2741,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>   		last = skb = skb_peek(&sk->sk_receive_queue);
>   		last_len = last ? last->len : 0;
>   
> +again:
>   #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>   		if (skb) {
>   			skb = manage_oob(skb, sk, flags, copied);
> @@ -2752,7 +2753,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>   			}
>   		}
>   #endif
> -again:
>   		if (skb == NULL) {
>   			if (copied >= target)
>   				goto unlock;

Looks Good.

Reviewed-by: Rao shoaib <rao.shoaib@oracle.com>

Shoaib


