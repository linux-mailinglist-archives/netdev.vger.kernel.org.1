Return-Path: <netdev+bounces-218662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3F6B3DCC7
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420E81884488
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F71E00A0;
	Mon,  1 Sep 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+Hw00X9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B362F0670;
	Mon,  1 Sep 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716046; cv=fail; b=DCoyoVbAgQgeZHJhQ5Bmqkbdm/ksQs97cNINGdnTtvl3SY2jBiqi/Sm9ZmPbet6Rw9lwLUZKY0Vk7umNZsbbgeX1nRk667ffQU6eKsXSac1SVCN9bFtGRRjdC8VbJgle5fLfHPk3DRlMDph8iQul/og+bPthnEDwrtfeUK9MPgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716046; c=relaxed/simple;
	bh=pqUG3wSxYKAk0hAGc7hkOz7ZtYNZPHcZ1jCsIS9RSXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1TDVhOhTTO5MhrHW+SlheFe9/SwM7A6xje0Wq2bNsXcCh3OgNr7NIsxUemJOICjjr0l6oSH4O474AyA+lRcJZBTie1R5hpZcFgOJiR5Pcd0ARBcLJCHfkGBaTvPrPpEoyY6gmXDkJREMj+/DdqttPbkFB1BTr6xtD6tDG8EH5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+Hw00X9; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/9WfRXcoZ6MDIvalFO+mmU26zqDn++js4/nPfly/vj4yCx6HwYnmPq/UvrfnoexpmikAnW+huK/p0WcFLz15hAcQzqEwI6yatSiwhXzgCZ0IEFhT9ZUwIwZiwLRE56+RCjm8FqpRjxHHNCuaiZnKAz+xtXC//+TJDVJJc+d+1Cgu3GbbHUjsE+ekTH8/j2LkbhfWUY/tYdEGhn2xvXn4AeDlD5cC2CucIIM44LRwJAWzvTrlJE0UGhr+dZnulKpRwTjB8MCn0gqbm2Zd8lhUX5McqeHI9X1SpcMhEnSOx0aQ+0PVRJrF4K1AYPvJeNr7/rxVHsFgzeXqZi9hpYWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+0YRanMaVrZkBHmXyFsKoA8c5uhSJoEg2ntqsEdrQw=;
 b=iywCnlh0j0sTLop+5CP3LUDClrjjM9rzne2yZTgiIHMvzpa7CjGEQtc0MZ5OvHoE61ekxQpxEQ7IOd7oomYdXk0PQppD5tI8mcOM7v+q7wpL6jNvdRdPkQda3mYm8evCvAZrcNKSaE6zuwagyW9cVAb2RE5mFelnjGusfWO00OH09kM4NzpBv00MGGANrmE7CQ4JFURdDYwmfsyP7ZPFHF2s97JvDECc3/zeQj/opCcoGlTpqGJZ030QJNnsrn9JerD81fZjRZoPNDQhNqcp6ax0Ol3/ErE+fbAt9Q6W4lEPiEsGHGRF7tIw/y7CDrrn0LZoY6K6XRLmyKMtsz4XkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+0YRanMaVrZkBHmXyFsKoA8c5uhSJoEg2ntqsEdrQw=;
 b=Z+Hw00X9lKcOUKG6+ErSezrdC9hJnBdd6HKCNIikWhBiOVwKopX4z+9FqXvOxTAAkHZStHnRtbuvIK2J21Yj83TCaJ/7bxchr/81Ewzm3kUI5fIOusqxrOZ1+91vrcLtUGvUDNVQhzEt3//nbFZXubq611BZL7SDjRbs3UH4j+WUYsD9VISPtcX3VmUD9BToLOh0QqwKIfD/2gH4J+hSCamATnvvFKv4s3GkN9aOZTtEMpDlRNSXz4YfvdCrSk9CDoDbEdCTVDaP1lA7wNT7l1qZxznRxzV5EFxWiIZ7vvOK6xybCtvAUujlQ3olOr0Hr/8dgUeOqQ76S2ifqGtx/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 08:40:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 08:40:41 +0000
Date: Mon, 1 Sep 2025 11:40:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	paul@paul-moore.com, dsahern@kernel.org, petrm@nvidia.com,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] ipv4: icmp: Fix source IP derivation in
 presence of VRFs
Message-ID: <aLVb-ujDn_KhOt4V@shredder>
References: <20250901083027.183468-1-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 18641d0b-38eb-4fd2-3b57-08dde9333bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgTFtaSiRaCx+HP3q91fXL9pHFf5EWH0N0B7RCLQImEnXwXTBuISbW43aWj2?=
 =?us-ascii?Q?jglTd7hqSvqYsbDGSXf3igHujc97+orsPvSYiroM+qSB7Vs3LoPWRtZBGdBe?=
 =?us-ascii?Q?7AMTMIzBIXTS/PDJu/GQNXJkJs8utIyKq4jJ8Nqw2ncjuih+MBchrhBJVlv+?=
 =?us-ascii?Q?Z3HEjI1gJnJyfHZPO69sPlbLnCkIs95y+5SbCPRHVXthGehegYMUuNth5SMR?=
 =?us-ascii?Q?pdfwyoOemyxCv4rrOKacUnWf5/hEPl3OXKEADcRPebaTRQIFoYkQdMPiVVp5?=
 =?us-ascii?Q?0HftX+8mtX6p/lBbYiik60A5HGokBqd2IKsvh3pAlougBzx517ewnAA86kWj?=
 =?us-ascii?Q?fVArAnTLfQGsoabst8MlV+KvPfCK8h3uXX00kiJNCVFvqZBlBOc/lqMD9/MC?=
 =?us-ascii?Q?iVW8k4zjLDpndPCX5Hx9TObdDmRa178pVZu8/pMPcSBHaXAKb63ia59pwoVD?=
 =?us-ascii?Q?qWEESXrvPRuXWYAPpSkTuoRiPJ63GF3THOV0+mkyvZBdGb18jLfK0spPY8/g?=
 =?us-ascii?Q?w7Vxl5HZRwGw5m8C/7wX2wM/T7kmzOv2jQ+GiXRsIM9zn8XjRkkccTF8h8NQ?=
 =?us-ascii?Q?0ZmSy9HINQfvPeW+/QsfEuJ9C6wNjWzix43C+WaKGdEi0AEhJ4x/t/hTiXJO?=
 =?us-ascii?Q?R6N/VO93qKuU61HW1d1+OzigtaqefRiAXpHLkFdnftLKKfOJjkbyRuIct0x0?=
 =?us-ascii?Q?fCN/Giuhr1fzvLSVhOxUj6+XRIp0vQunRTJR42j9On2qlHIMxy60Bls14QiZ?=
 =?us-ascii?Q?o2+PwqU6YfoVx6PsH0s4BQgmH2Nim5KTcDlISH/KqdrPYGbNfm1TGFwb6YNh?=
 =?us-ascii?Q?viWL4nDkXxspvfIRaW2h3nc6gHymB+WtLMwfShsCmmQbPrKMfDYRryXK57WQ?=
 =?us-ascii?Q?Qy505K8OBSfgXtWdawI2Hio4AQC7149Zth4nx5bg0bUa6ZSgidU8/aVt9GbD?=
 =?us-ascii?Q?OFzYHjv3HxIs8UzoP4X7d/qxQNmmk9gmn2HtVujqDL2FJWMekgVn0lMyhVfT?=
 =?us-ascii?Q?zno8iHJQwVG6UNiwFFWj4zMBLENZeNv3l+bdY235C63FYi3v1DtIhb+/aOMy?=
 =?us-ascii?Q?5CDMJbAZzr6s5VZCAoXnZse36rvynp8ZATT8p63aMTupbio66cOKWgI1pf2u?=
 =?us-ascii?Q?atwo/trCSGSjg4UJk3a4moiVl24OCjfFq7bu5acSFeBJSaq3PlKjsulppsO/?=
 =?us-ascii?Q?/nwbOrW6/Upv4ggwB+JRxFLemPAt7ImyRWA86gHBWwjU6pTTBYr37WOpzUFR?=
 =?us-ascii?Q?Ukac+hy+2vU3uwBmYijKvIPCcFgiqgkM0qP3ungxHHVvHFu3v3rwq9AO0Ngd?=
 =?us-ascii?Q?ULayVX4oHrppEowxaagFPT0n3pUBw9mpOegNtayxXvhuXfspCDUqBE26ddWV?=
 =?us-ascii?Q?NAtkpk4V6aRnAc/nvBoeo9TXg5xfnRNnLrYKh1u0LcBLOa2cF3Lb7Wsve3Ft?=
 =?us-ascii?Q?ZSsefOqnYvo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0yBVIgvVml9svgAXEl6vDZOEA2mKNjkumod7Vx+BUJht+mF2Tf+5IrCDuGm6?=
 =?us-ascii?Q?eAOyaOthXDfF/jaYqG10vMk7gqzCxz37m9s/Y79oP8CcyYvKbXOYDVCaCu4O?=
 =?us-ascii?Q?GtkosGVZlsP4v4Dj9ZjZuzFcKo6SZ1LqMYT2NAUt3zfLe6JzKMzeZkRKPoGv?=
 =?us-ascii?Q?m9ASvJu18vgKBZlSEkgyhoXTg0ho1UQ0UeCm+tm+lBA9PCqSG/YLKRBecp0Z?=
 =?us-ascii?Q?EyCe/SW2jByeZYDzFFfOftzDJn7s8oX+ZLqMxoMciu3wVpeQrmbw9FjWBNfX?=
 =?us-ascii?Q?Vh/VG1NCCU7Z+ZBIW7IBTeJBcjlKjsAbCh9BJ0AQjnCq7X8TFWGZ3g8Czy7U?=
 =?us-ascii?Q?tmufmyr+bwtLzQt2icoVk+9L3ZqL5ofUQ6gRCOA2h5dZwfIMLWI/KUQHVjtX?=
 =?us-ascii?Q?eQoPFKjw7F3Aj2TvxjF0uR7dW61Jp9B3gg70N0pl41lWUEtCvWFQz+X4Xbkz?=
 =?us-ascii?Q?7ZSKHRxmbWPGLcpXg+wmFVh/v20vm2WHVUMT5+L25maai8gONFKSJfWlGcIr?=
 =?us-ascii?Q?K4GLnKflIrhCKhuzcl3E/U6fr76fOLhc2/YZ4fANdm2LtRbxDu9kvDiAmf0z?=
 =?us-ascii?Q?KTeuZS2Zpo5QyYchFS8MK5eBgHJINN6gAY++29LDYhg1vqq5aBEYsThyChzK?=
 =?us-ascii?Q?wImgUiK7/89JNHdHDCs1pKVQfTVqAFv4WrILZOxaPVdWTifovSdHpPaKBFOu?=
 =?us-ascii?Q?LDzHMLjHJr7YPOv3qBGy+WGa249CdCPbhoLPCiI0uLAUfM3T+1AE8DxrLDsw?=
 =?us-ascii?Q?rWl389cY6TkGCbiD+RO9WZhA4xff/YXJeKWVg8Wjg7Eoy+fSxihLiABY0U0z?=
 =?us-ascii?Q?E0JpL2ddqDCHRbJ7O3F5Hm7aojAq9W506UiQo4CZMJLg9HKnebeHVrcMvufE?=
 =?us-ascii?Q?I+aH5xljOJdQUwzxzIYr8RATWyQ/IWaN0spAuOZ1+UYar9tTqZP8wjaO5cqG?=
 =?us-ascii?Q?YNpAlUMR7Y+JidGWc/CV+ILePi9WNF1VRdwP5RvgWoAZ4gzpG+q94L3CdtWp?=
 =?us-ascii?Q?l7WOn3PakO+N5hHFGj9JhQiPCJFdiXXYshUcQz0+5Vrkkr/DZmoUByBfoUXn?=
 =?us-ascii?Q?fGBhsQpqwo9+o+LmHbCyDmocleNosz7YWYNsOm/lBzN6WPwFIEDGo+GPTzNw?=
 =?us-ascii?Q?ZOLYMXhiPWUdAxDjrRTbGGcEg3+TzioFkckezlyzxWZfU6iGoTbbaXnlV+45?=
 =?us-ascii?Q?RhSQ1oVW5W4B7EnAbspTvFCoACqk67kML8DjKBgKPetD7uvKaL6d1viIrAD+?=
 =?us-ascii?Q?wX/GbyDlE1obzYGWwgyK2oiZ9Uo5vBDhWTuQgbjdFBKFNmi8ugBO7W/m8EEG?=
 =?us-ascii?Q?X1JYC1ZO4j74J2Qio6HleMEXw+g9eD1EHMWtAkuVmq+UPusmk9z0kOqZkxca?=
 =?us-ascii?Q?EQJUou/2zL7xTAPEPrbrjquvzv6hduBIePzjWdqU3szymnnQu359kC0TfQXF?=
 =?us-ascii?Q?q8Eibdp0ppShdqTATA4xSTeoJ1mT8g1VkIg6ItjD+zl/9BbkvLZrGY7C5EIe?=
 =?us-ascii?Q?aq4m95EPEJgubQ5axGxmNFECJOb8bR00UoZZ1DnuzAxJ1qbTxkWzWE2B0Dpy?=
 =?us-ascii?Q?jqbDFJS1ynMDsyNIniMhyHoHos3yYC8ktjC0pLNu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18641d0b-38eb-4fd2-3b57-08dde9333bad
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:40:41.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryWfYh+HfBX+wne+6K43VlEKVgu6cC7XO1GBWF94SdoIGeQHFL3pBCnT9siokluS3KSVvOMMMNx//w0h1ScCWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606

On Mon, Sep 01, 2025 at 11:30:19AM +0300, Ido Schimmel wrote:
> Align IPv4 with IPv6 and in the presence of VRFs generate ICMP error
> messages with a source IP that is derived from the receiving interface
> and not from its VRF master. This is especially important when the error
> messages are "Time Exceeded" messages as it means that utilities like
> traceroute will show an incorrect packet path.
> 
> Patches #1-#2 are preparations.
> 
> Patch #3 is the actual change.
> 
> Patches #4-#7 make small improvements in the existing traceroute test.
> 
> Patch #8 extends the traceroute test with VRF test cases for both IPv4
> and IPv6.

Jakub / Paolo, patch #2 is going to conflict with the following net
patch:

https://lore.kernel.org/all/20250828091435.161962-1-fabian@blaese.de/

Resolution is below. Please let me know if you prefer that I repost next
week in order to avoid the conflict.

@@ -799,15 +800,16 @@ EXPORT_SYMBOL(__icmp_send);
 void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
        struct sk_buff *cloned_skb = NULL;
-       struct ip_options opts = { 0 };
        enum ip_conntrack_info ctinfo;
        enum ip_conntrack_dir dir;
+       struct inet_skb_parm parm;
        struct nf_conn *ct;
        __be32 orig_ip;
 
+       memset(&parm, 0, sizeof(parm));
        ct = nf_ct_get(skb_in, &ctinfo);
        if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
-               __icmp_send(skb_in, type, code, info, &opts);
+               __icmp_send(skb_in, type, code, info, &parm);
                return;
        }
 
@@ -823,7 +825,7 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
        orig_ip = ip_hdr(skb_in)->saddr;
        dir = CTINFO2DIR(ctinfo);
        ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
-       __icmp_send(skb_in, type, code, info, &opts);
+       __icmp_send(skb_in, type, code, info, &parm);
        ip_hdr(skb_in)->saddr = orig_ip;
 out:
        consume_skb(cloned_skb);


