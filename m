Return-Path: <netdev+bounces-232585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F63C06CCB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E2B19A843D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE12472B5;
	Fri, 24 Oct 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utgKe+cz"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36962494ED
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317474; cv=fail; b=HSxYpj7BmyomTYl2J6TZbGENcm//1tePxZrTNLCHXxnb9H7IQdhY9dbODX3ogaj49Ku99S0Hytbxvp+R8aytC8P/ASNpPhT5oSSgGlpNbAbjh0JHYZB6iZeaCFSn1YtGFM63mb0HnecPYfO9Jw+geeZO+Dl8cd0p62dBzPjx6sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317474; c=relaxed/simple;
	bh=T6zfR/yDhfzxn0RAGwYVX+Rd8Pen14leyfI8N/j09bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qyOWVuHZjV3DMAigc4NI6dFCOeiFhq3mQdH8uD9rbzDpBEyuIPGZ13uUKAxkiPMTO9WMZIuOKAvJjdwgyLzSB+XfJGR4oKcAmWceHvkM6ayhDQ2wEGMfaujaOsiautjQCfIeMlYLbn2oIOsQ/WaTUGpLx96bJUjGUTM/S8UQmDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utgKe+cz; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0QlIsKN6lTB7z191ABcKqS4RpMnVvU2prKsoSp7KG5Y5Qh4NpKlejK6BMJeP0LigAqFyEBgYntzH6zw5w0n7SxZsKpjjISBdZrJRu09dKuPq9nCkeCJweafh6wp6hsW2Q0hB6qYRC25za9NWAa2+KS48pZ0CLnnNLzM3Mnq06sUVh2SNFPSUhqHdJ9qcv2TGvcVJ+xr3ZrCW8HoNosWs5R3M5UT/72Kcg5SSrrTxSw8JWWYkgnsJ5HeSfK0D9EKIMVvw5uS0qQXSFobkuicUz2b8ftqqIlY8ZEuLXMFoovZvU12dnSi/FMXv389o3dMVEqnrL3a/rjiAQRbATIqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csHqOFMYhy5gBW4AMOdIDdCLKA/1xetcEl82r7Hnu00=;
 b=ec0G3UCmYL/jqzNwDWR/n7oVc8mjVCm5FwXN4M9Nk7CAiQ2SGCewB4wg2I4H1wp/XF94fMNJXV3obH5Avhh9Qfdr+TkuKzIXjt+Y4uUc3KLdDgVgpuymY7ykhsi/aetrdj/cT5fY7aKyo13aenpIXfbMLDkbBVeRjM0SIa98gotMESAvitX323ByMH1+5XNP24E4dSuwuaT0htdSD4s2TkYm9/slL7rp68t0t05VVME8LsGmNXeKGZN26/zp2dWUNJi58WRxO9QAEsEAksKVTDkmLo0yT4AoqONxrm/t8K4wPftb3MfnmB5XtbA3qEvtvebKvViF4bo7BMnfGoK3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csHqOFMYhy5gBW4AMOdIDdCLKA/1xetcEl82r7Hnu00=;
 b=utgKe+czyNrFhElURhKLA6nwEB4PNH9RLZkcFXaG4qkpp3Zu+j96loNz1tHDa76Zc10cZ8brL+AIStYAtgfXUP9Tx1gUR+jIh3zgz8qiJJfEtozmeWaU9F6iQr++dZNGDSxYNqVqhIYMf/LfnAWSK8r4OBuxoTS+D+9EaCD1La1PDEaCpHAkg1iEgvbF4n5+zihcgltNHNK9RFsOXmxqmKufayxqjN/fTgIGGqJabJ+vc/29zYq4Fu52Tw2byyCwQPII7EulCJqpoAYjuzif54/s1f+OLbCVrFSqj9meBSuCHmeneQyne22kg5e3n3jCXG8cCZd0XfLFHYwxh1FUjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 14:51:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 14:51:08 +0000
Date: Fri, 24 Oct 2025 17:50:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
	petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net,
	fw@strlen.de, ishaangandhi@gmail.com, rbonica@juniper.net,
	tom@herbertland.com
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <aPuSUBv7speAmnRf@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022062635.007f508b@kernel.org>
 <aPjjFeSFT0hlItHf@shredder>
 <20251022081004.72b6d3cc@kernel.org>
 <aPj5u_jSFPc5xOfg@shredder>
 <20251022173843.3df955a4@kernel.org>
 <20251023184857.1c8c94f1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023184857.1c8c94f1@kernel.org>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 82673319-60c6-4f20-1fe5-08de130cc3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YV1AXKWEhSb/or0Qd9btWJsPxgDvUNR/m/6ujJQ2TbXYpKn+8HE+mOrH8LtU?=
 =?us-ascii?Q?Ma/9wQzJ07By42RwuiR/aBwK3o1Fu/qIQy6poHBanUx3KN1SqNaF7v+QVmWp?=
 =?us-ascii?Q?piOPEhF2Jp2H8hY6fGmmx6q+AkJtDcMaePOSWCrhTvADYRbE7lbjiWjJ6r9e?=
 =?us-ascii?Q?oo6S5je9NEIm08zSniH6TdBvJBRlLQVUMV6J5VXoEzcH62szZcLKQ6ltN4jR?=
 =?us-ascii?Q?AfUbQXbJxnz0+pb3JGKK+q/DgIrRdZ2NUJZV877ee6xvQQBvofWPXVEMxN+W?=
 =?us-ascii?Q?XI/5HPImNgpsNeIxo/HzjWrVWEh/p4O72HzKrkiEMxjm7Nz9daSmuahQBehS?=
 =?us-ascii?Q?+5uPn8NJmjZxWdo3oahK/6z+3Ba/phjn8SLq6OohIDUpNPWoutJqyDT62/na?=
 =?us-ascii?Q?9Xud7Rn7SvNN9Qjd73uiDm/lVMimfYGSLvDB2emgkfuKoQ4bAmoJNKngZeYY?=
 =?us-ascii?Q?PLp26rBR1nO8qTtc4rnCCdsFtDQpSdeZqaO8fGK3zJLR9gS+jTNoFa5QB8HQ?=
 =?us-ascii?Q?GkrIQwKtYhbxes53Ow70j/dauILj+J8DuelIM+BN5PPH7QEkufz7sDyBZ46M?=
 =?us-ascii?Q?k3Mz2qhMzDDnJ58P5lzWkSjoHZZM+Kx4/1O3u5OjZxzjltWVd+OUI0wiYMWs?=
 =?us-ascii?Q?2p5yL3zeIPxxYNu9O7X1FmlURw8lXutZUl0PxZlEK8oYZ9kaPFh1dKsSSqtd?=
 =?us-ascii?Q?E83bWMSnOhO+qb7RFEpcsUgKqrsR6ZlAtNgPOxJT1pEC6TnqVzsl+j8FHkSW?=
 =?us-ascii?Q?st4xVOsJBnVv7/PJGos36sewyIKkXIrjZuvtFbgAy3XOxa0ShegzHIXrFd4s?=
 =?us-ascii?Q?p4G/miGms7iVw7/dz2ChzCagpCVPjPK5SK+f8l3JfZeCLw/wnQ1tqSmNJQou?=
 =?us-ascii?Q?3Ev5/QAsbYTkHpwArDnH0HmyKNkh+XBBOR4neYecegLC6SFzzJch4GeZzxvy?=
 =?us-ascii?Q?eylvg9ezP7Gt05hrzzX7AVNVgTdqUnKACyIpK5BPPVWNXMqwQK12iT9da1/o?=
 =?us-ascii?Q?Brq5rb2N8JU4zLGKC9B524xNebRFuiJMmR8hd2n87Xa7Sh9eHvIxArWGaDUb?=
 =?us-ascii?Q?dDLt+LdmbYEwdwjEgoMkItoAz5kS/1SS8n3G8MqUYKZ4sk4heZEPo7Z4IhYD?=
 =?us-ascii?Q?vFyW77STZY7WS2kOWEN9DlsNAM7Kr8BxqwLuuM3HEwD1/irVm+9Pgt2mD74h?=
 =?us-ascii?Q?CkEM48MzG+/xFqH/uJSyh4TohcJXkwlRM9NmBY2LXEqY/000aFwqga7Cu9+/?=
 =?us-ascii?Q?s+kWJbHtiXee9JUVAlPyMFjcBJLcPPLj2wpcAc5A62SCSXwNxJEPKvoXky3C?=
 =?us-ascii?Q?SGs2HVx0XccuKyVRMaONqIoymMIw7s2pHIMfp+fsEHwb5TSrW8gXghDXN6sj?=
 =?us-ascii?Q?OeJw/sWN70iPNgNDCAH3voesVdo7pOD9u2q27VDwm7x09iBUtoB7BHbBybBg?=
 =?us-ascii?Q?yB3kBqjI1f1Fe38cVuXCvq9qOnk0KHNV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WKrqLGSDD550T/JoCWtvUDInqrqOf5hqRzWHLjvbAC7oRq5DwRPS79Cab7Au?=
 =?us-ascii?Q?fcm/xyb17QsKTitWD0jLvtTm3xk7Wis/5LWCeAosa0Me8p6ygAp9rU/tC/rB?=
 =?us-ascii?Q?vBbuxXXiKtth5Ek9f4pKe288t842KFH2UxaUmC2MspjGMGsBWLDXqBch/8t5?=
 =?us-ascii?Q?WhZLDqopoieJ+jFojnCCG1MHzM3VKkYbqSZjdl5hu1yqPz+QcU64Vmk7weyu?=
 =?us-ascii?Q?+2avEfRWZtsQM0tZMDMETliPsdGmqGOBSyIGtyAqYIXKavctd2WIJVIckEje?=
 =?us-ascii?Q?mgmaOXKYMaIhUWQdjA5WZovknMcIYhKgrUeLcsBO1LjKNZ6YLH7eaDbbsHU7?=
 =?us-ascii?Q?asANKDx8InBeBohfbEFs4NK9rEaiAIivqBjnoq9xq0kslkaubxoCLKQEYKnt?=
 =?us-ascii?Q?M6GIgojRgcJz24pcxq/K+0+EbAFEwwMqaci3Ll+hTe2IOeuDVMYrdTSJ8AHe?=
 =?us-ascii?Q?YP35LBQPKmWdC86vTp4IOuqmJ5D+gVTnlyShOLXR7teSHAEuZstx8JWAKPI6?=
 =?us-ascii?Q?PMvBDhloEttGv7sAzVFXrKzOI+uwWA4iUwuTIL1+g+jl4syDqQYw8sMknoIa?=
 =?us-ascii?Q?CbAecWvUn/oB5HJ93jCrReYKE+Obonwn3jBXhpFpxGv3d2VERj6VnQl+lEwN?=
 =?us-ascii?Q?bFRf4rxV1eFoMVVrj6tdDsRk5yWa2NEjuFDN9ADxYwfgW6O41cZlShmXSC+g?=
 =?us-ascii?Q?tI/U3uFKs+JZDjV1WGnytPmJY+gO9TB8uBb8g2cOJq3x3aTqUB89+NlScWUU?=
 =?us-ascii?Q?6oTyObWZwAaHDdFvb7385xBF44CiEWvctd6dbITCcyGzTLxPdNNPeWMY+c00?=
 =?us-ascii?Q?wRKNSDMIGO00wb7h7eDaPRvTctDM7mtJXIl05fKZ/OLdfA+ykdz2rWV59WxZ?=
 =?us-ascii?Q?xjXA49QyfgpBsjU5+odBxa+Kq/tEfsCvJ0e7FeKXxxLzLJnowJ0LRFP3zCC8?=
 =?us-ascii?Q?X/JIUVunIFGDQYBesWXlKZ4Qlhc2O1jyQMmMP1+TFB0fmSSRdFLLIeU36bWN?=
 =?us-ascii?Q?AFC8fAs8t6/mkfIwVAWHdrehZdCF61ROlejXCC8fHRAOFWxWuqDFmUyKIGXZ?=
 =?us-ascii?Q?qjBjBw5U7efUY+lacCl5BDcRA8grOokGGRGLrxUvynnBfIRYH2hyVvcRXe7V?=
 =?us-ascii?Q?lKMrpIVogniNP9xnFyllUkhnL9Lhv7h8AjTSDH46t58RevGZ4+m2LB6dN8WS?=
 =?us-ascii?Q?2ECqdjnuKzvUWMRHSaWAnEO4NPjJzFGDeOA3gimd2xzqEScyO0/XD/QGVxlB?=
 =?us-ascii?Q?5PEvApbzbfHuahG5VZ9ZcC+MJN06GEFMdqklx0hbRazG/bCkBz5gFBP90RQI?=
 =?us-ascii?Q?3Rjep8c77NRTCWvVd0jGSTPk7jO7/IafqRylQHh8JLkmO7DtWpTPMcuH/dEt?=
 =?us-ascii?Q?WKZs0u1EmZCxB32OIltfqScmEyOO8+xuV5BXIFwMDocS8d3SAsuvj1BQGf0R?=
 =?us-ascii?Q?tUBLd99eOP2Wxczv9JjPH04Nm/Tye0nXTcNoac0hYKRyS+yPzJxG+N6HPouh?=
 =?us-ascii?Q?WI9RMtz/dFb1tAhrsjaC2ypsO2a4GtXXPLlnVng2qNpCdOjJEnpFcI7CyhTH?=
 =?us-ascii?Q?h6QtPwj2vTmTm9ruTEGbfU58xQaxVoQgwaRJ5Jyq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82673319-60c6-4f20-1fe5-08de130cc3e7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 14:51:08.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZK19Sex2oPLpixrobOye+6VHb26+qnGSbYV269XcgFWnfnoP6zPifu+NCfb0TVqBfJKkeAJA8D67cku5KAzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995

On Thu, Oct 23, 2025 at 06:48:57PM -0700, Jakub Kicinski wrote:
> On Wed, 22 Oct 2025 17:38:43 -0700 Jakub Kicinski wrote:
> > On Wed, 22 Oct 2025 18:35:23 +0300 Ido Schimmel wrote:
> > > I will change the test to require at least version 2.1.5. Can you please
> > > update traceroute in the CI and see if it helps?  
> > 
> > Will do but I'm a little behind on everything, so it may be tomorrow 
> > or even Friday. So ignore NIPA for now, worse case we'll follow up.
> 
> Updated now, next run should have it updated.

Thanks!

> Current one has traceroute updated but not traceroute6
> https://netdev-3.bots.linux.dev/vmksft-net/results/354402/27-traceroute-sh/stdout
> 
> This doesn't sound related to the traceroute version tho:
> 
> # 34.51 [+6.48] TEST: IPv4 traceroute with ICMP extensions                          [FAIL]
> # 34.51 [+0.00] Unsupported sysctl value was not rejected

Hmm, which sysctl version do you have?

I have:

$ sysctl --version
sysctl from procps-ng 4.0.4

I just compiled 3.3.17 and I get:

# /home/idosch/tmp/procps-v3.3.17/sysctl -wq net.ipv4.icmp_errors_extension_mask=0x80
sysctl: setting key "net.ipv4.icmp_errors_extension_mask": Invalid argument
# echo $?
0

Which can explain the failure.

Please let me know if that's the issue and if you want me to replace
this with:

echo 0x80 > /proc/sys/net/ipv4/icmp_errors_extension_mask

