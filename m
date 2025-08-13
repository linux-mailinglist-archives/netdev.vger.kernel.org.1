Return-Path: <netdev+bounces-213437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879ACB24F66
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F895C77DD
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B8288534;
	Wed, 13 Aug 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HV41icqb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DD246796;
	Wed, 13 Aug 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101091; cv=fail; b=hgMF58SQGVHGKMDSGQbR9EYhLSIazWQFoKZ3FlPWBH6DqAgrQpoAIo7unaV9Qtvoz9AL3C+VUykXzkoxg6AQbDcx6eRUjKEyLYxyeAG6V3nPqOtwxUFuKOYh3IS1WWYRZ7WVVfBiY/dZt2X8JIrtXFkBHNPavSIkiUdCD/ifz+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101091; c=relaxed/simple;
	bh=+pwhOBeL2/vs1j/TzU0LmvQrI3rJSihsuonYx7Ovtdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJMgd5Icf1heslPUHIR3FexlRB8Zcr3XJSWJarRwDavHn+a/APnzVC4pQ1K8fC03LZULFnv1ZIfUuay+vAFdaY+Z3BxbrAJcIPdlo/R9gru0rZb/R6OidVLDLXldLMqQkbVJGTqOeTT/9xmVpsrzc6wn+8903ZiEa31/ZMdC7cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HV41icqb; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqnerqkNCL9Aaj131WMe2O4rs2/LG9SkQ5ZNSa8ZFw+am8Yxt6eiSCL1mOfmBD2VYBYQLJeIPgjR1I+R7wHVyk9qAg4Db3ZaFV2wkaqTqyysgZG7aLkQ2iUKcj4fSiDxDnD7f9oTZ+VbVfN8N5SfunuxxD2K6wULTiMuvZrrDW0pfYLazIwfmYWWiLv2QW8sP1biribs4eQp2J+x1rfYGhNscEg3RDbMRsGkGhgo8HCt3Uprk27Ido/8FhojP0+Fa5sneG6AZQ8U8JxdqxBu5AeV+JaMj6XqcZa/cFeBqxR+Zl3elfBzViwz2W3K+r7M7jEXFJh7gRqOgUHKbadeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vddVk6HLGh2Q4zrqCU62VHqRLCrQo6Su+LQJ0aKjVs=;
 b=qQTEMEx0Dar1QSDdJW9ZVkcPsvA9QjKw5ZRSWiD3D6hOBlEVhpNlFeWpixaPPEvmCigd+BY86g+8BKPHz1DaPrpfni3OgaYu5KpAtExvl/Rc++fhrVQwME6RRC2X7tQzrH3XeYDqCHnb8a3CJLTt6G38ZxJcD344WKkwtZaxnmwGrF5hgRZNBwB2kGVb4x0FpjFUZsvRhfbn7yU8QJVT7GS2QhlFjLTXjjU2tuOnOUzbM1DPtDCEVgl93lp8qDaoNADXplYQjF2SYh7k/B43W0k5FOHX0JVAWLRLhXJn+E5DU3MlSlDxI8hGj0o3Cf6qHZvn8ycqsaCRoQOidqtUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vddVk6HLGh2Q4zrqCU62VHqRLCrQo6Su+LQJ0aKjVs=;
 b=HV41icqbJCXeK4gWmFLFPUsbQH4M1srvfhaCdrjYJM6HZMfuxIt2G3GDJtlpO3FdpUZijG06M5H6MAJv1MG0W6NKfqj9162VJCiQdMfWBEfeGIpuNVWXuctwbr4Va/4WzostWAKAeb/AhU1A8GTAWL5hvCFU2Ye0I5DvYXkkTMeZ6V+aj6HIDtt5sVelSzV/ZBNuGM3JREOz3TFEPfKylHHU2xIG35YfWnQGBOp2tI0oBwVODEur70N5WmavGKkzjF7fts96X9k8eonpE+tucd1t/hQLoDvxoW60iZKrZhncO12Ds7vDZBZ+lVGLbp5Ei/LrcHYwu2jhOWHyfai+8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 16:04:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 16:04:46 +0000
Date: Wed, 13 Aug 2025 19:04:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, andrew+netdev@lunn.ch,
	daniel@iogearbox.net, davem@davemloft.net, donald.hunter@gmail.com,
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org,
	jacob.e.keller@intel.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@kernel.org,
	menglong8.dong@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
	petrm@nvidia.com, razor@blackwall.org, shuah@kernel.org
Subject: Re: [PATCH net-next v5 2/5] net: vxlan: add netlink option to bind
 vxlan sockets to local addresses
Message-ID: <aJy3la53tn3mS3Jc@shredder>
References: <20250812125155.3808-3-richardbgobert@gmail.com>
 <20250813062904.109300-1-kuniyu@google.com>
 <799c2171-7b41-4202-9ea4-e28952f81a65@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <799c2171-7b41-4202-9ea4-e28952f81a65@gmail.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 633af1e3-2ecd-4d1f-340e-08ddda831f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qAFC0JUpjZ1hu+eqV1BvaJvYdcU97zd3o6xIElAo809xfoeEtZJ8SrwRgX7V?=
 =?us-ascii?Q?t2FXG0JtIzDrFTu9sErrAv0edKFMt2gc00Vca5GtF8aHdxerXjUJTPeDqV3T?=
 =?us-ascii?Q?PIr2wOat/amRHxKVWtdDunaEdZx4Z+8BFx03YCV7TusaBVqnK1jHjz1/bmw5?=
 =?us-ascii?Q?WDp+Wk5D32RdugD45ZE4iwcTxHmZik93xp1iDwUMIxL/10lbY86UvZ/RXXyB?=
 =?us-ascii?Q?fvrh9JyXp93DnhnRnZgulFNpORgMEWCZpaYZ80Su6FX0drbAsw/s0PPmM95k?=
 =?us-ascii?Q?6vQJL88Pqhn0SJoPqT9tVFcbZgiMWUE60RvzRzarrkXDMuaO+tOYa0J1nBry?=
 =?us-ascii?Q?DJJ0zyrhIF0TXs8qGUmcJHD8iytnNFHhcwKmJUnv6mCYN7QwLkHfQyfSw5z4?=
 =?us-ascii?Q?+lBxUhQ9MxDaiT891Ct0IZ/HsgxlAgjxe0O/vro/K1eDv3omOaY1la59HPus?=
 =?us-ascii?Q?VJ8rbtAozXI1KoQhWiTKixc3bn8kimXSJ325HOE9ya//M2xwZ6CVfABfGyNJ?=
 =?us-ascii?Q?PXBMqL2S9nWNxMHbgMkvZdwUXZuB18YjCl1mVsfYwTyKQjHjfW9oeD4Pz3Mo?=
 =?us-ascii?Q?5DBdwKcrDHmnrqYF8mkINrQT0u8D4rh5mzBDsjDdfeG5dEG46s33nGYfKuvl?=
 =?us-ascii?Q?qJA+jfDIOT+GQXOO1srvVk3FgGr8WB2FN2Pgz4Odap3yiwldjXwJicoOlhmJ?=
 =?us-ascii?Q?XnrA8FOr+UhXTUR3EexZzZPQcX1jndSt9NcovZpebjCjweW2KiSk5OPsIhEe?=
 =?us-ascii?Q?l1c/dudp5o9NhsLXwMvZxijrMOfug+DutmzCRb2JbdVFN6bWB1fwuZZltVJM?=
 =?us-ascii?Q?z6K3KXK54c4ZrzCGvDLUSEY4EFFiHMIpzFMXaTqNv/kku301d1FrDzW0nl0Q?=
 =?us-ascii?Q?PTlzUWV6rQkW4d+l/UiVo1DuXLid3OgqjJZmwk5jAXdMjCyBuSyy3sN5juOs?=
 =?us-ascii?Q?1Wpd/+cm9gLh7+OTtctw5E34F7gUhdVDYc64yMfkId6Qkmccd6KbpAWvtioS?=
 =?us-ascii?Q?Gy++0b9I9pdZUMQ5YaaHdiwczcgLeOl8pXMPrgCzMsd5U2YHQXV87gaZj+N4?=
 =?us-ascii?Q?YkmfmcdIZXgpXeeEweEBD3ui0guQcillVszaToVTB8zHJLshU5yHnnkc1Goq?=
 =?us-ascii?Q?yCCp+KgpSUUrtvoVBnMEv9b9HHtK+yDd9B8As91AAqaswLVt0A6xHwzwHoVc?=
 =?us-ascii?Q?UYvaudgpITfMr8xCerNSx+aAzsgqEMfysq3WZ5mqCcJEnlHf78xYMCHPqQOU?=
 =?us-ascii?Q?IUpbe2OPk8FB/AgrtxF1pfBcl8O4VByMn1oIFOAO/WXjL/WPkGSlDFvnxFRx?=
 =?us-ascii?Q?RQfJ9+/Ub8SKHJ1JVwWVLZgivfqzAojLh7Wt7nS4PxnAJuZjp3OG2Ft4moDV?=
 =?us-ascii?Q?W0N0OVN3ZNrUjAJygB6Wfom709k0SXbhZxV4m2pLI04DLwCMvrPiqBF6rANs?=
 =?us-ascii?Q?ho2TlwioV0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIrHQdzL2RYcvd4iPEnReL0Lh/s2kPQhOj0n9TPna68+kwwH2P73FqSBINmx?=
 =?us-ascii?Q?+Cr35lpAQu1A6SnS9lZWSEIYkBVLq6CUl/3VzMslc16NOiAhrSOJ43+BYEHm?=
 =?us-ascii?Q?hmNHoGQv8qDLbOJ+9H9JDyloLSXI3+bDElQsgr+HSb6DrLYkCig2YDwHAwrd?=
 =?us-ascii?Q?lXqD2QkBABLp0aj+EsDN/8/RzyzEj0ovm9JLFAArCoinBtMPv7WRECStzmoC?=
 =?us-ascii?Q?ckuKyRy8nINyqWz1hNKEwb+jpP2dV84NoR88uEwabUuWi5KMp/UmmFJwcL8w?=
 =?us-ascii?Q?tZdnLZwkS7lbSwh1HvYzSEd2RcOaKWWn3gUgE76Sk/x/ierS7JzYtv7gvwMB?=
 =?us-ascii?Q?ThvdIRMVNhB5y+nZVqyzp3+JLAG0AlFkL/Jq3RHLSHptBtVxYPQ1OK4nDcqw?=
 =?us-ascii?Q?QsYvyBtr5GlI+0Il/prBad7heGBZHN+NBocX4G+o7oAcdl6CiOS7QpRkpMbk?=
 =?us-ascii?Q?iz+4rjiA6OUpa/6koTHhtS+XJYUfrZNRenXrKBiVQfaZTLePFbJCyPIBYtzt?=
 =?us-ascii?Q?pmL06wffiyWCIT80lHe4pAlWz0Ck7pAps4qUDX3BIXODBY6+ChvlzB5EihZ7?=
 =?us-ascii?Q?H3Rj/wo7dR7tELohAMnzM7R4f/5E8A0++CLWOCzJ88+4V1MoCIPrH+y/IZan?=
 =?us-ascii?Q?FQ8yA+HTwfr8S8Kka0QNzD5G6PUEwEJDks/PRfk5xulmhHcxFE4IJtxwkuxA?=
 =?us-ascii?Q?wZq5RVT+Gcs/1in4CReR7jq/nNpqLsouZHYxOSHpWr7K6PJTrVvpFPTmLzq1?=
 =?us-ascii?Q?wXzRzNZ/qLJtS/+KEedARPNsXj/tsbQrsoJCSIZrcSX2ys8DjIdl9SjOuwxV?=
 =?us-ascii?Q?1kkcm+d9k4JFY6Dl3pAeYUtWt0EOc/ybRBw8Dq+pKeSuKCNVox8Tk7amy/rI?=
 =?us-ascii?Q?9OE4/47pDKh1wOssUis/F12dDk5LzDhKTyGJN203aMiK+1GqbbXc/VJWy00v?=
 =?us-ascii?Q?UzzcOi/G3YbVsHi71RKlLxW0jIaONPqR+PaxM/MP3pE09354dIeeJZbG9z28?=
 =?us-ascii?Q?lJaW8l1vvzJy2aknIudNudGtzGUvrUqrxROq3so0SiVKUwfw1L/O2hDGhBE6?=
 =?us-ascii?Q?jg6UonaRWE6fSseRGVpZOPi9pi7R3+0Bb80o1aNVPPpErdUTehRAhoU2l8w6?=
 =?us-ascii?Q?haoHb0iQpc7rKA8Ak+irl/7GENGmOhr6/pBu/CDx21ZBARYTlQEgomLTf7Xr?=
 =?us-ascii?Q?T0yIW/tmJMINMmt+LaO4RkT6vAYXi9roGYM1DBvVQQK15cwJpUjDH766syx6?=
 =?us-ascii?Q?MiQxB3OrK+k6crcOIvFH6EdLPcS+t3vxnjxvQmjAUIXLkeC50cn5MPdDEjlI?=
 =?us-ascii?Q?At9AU3JJP8ga8yyzWDAOb1UcKqrgJZ07iUNUA7Wm2ArPnaFx+9UmyZuNsQ5K?=
 =?us-ascii?Q?Gzm7MuwNf9+8THgamGnpbLFN8b9Guq400+ArysBNC1z1AfP48Tby5GrD2ey+?=
 =?us-ascii?Q?VFDS3BIPgafv24BoyE84c0CV0K9KR8NYlGioKaErWJSt6HSEsX9IC6rRYsSE?=
 =?us-ascii?Q?Z993dpuklKwmKNqk7vPzO4X5CyhmNw7uO1F7KsJeNd3ndsZKl06NqYyg/wiD?=
 =?us-ascii?Q?/kvMGDuolj6lGVDbbkkwhIfitqBzHaAoE+6bT9Nv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633af1e3-2ecd-4d1f-340e-08ddda831f61
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 16:04:46.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq199D9dfjPNilsTXNRKrVN0dfxKmhAGG1OYoerSNZSBD29LDCztBXAyR/5xOnrQCzr3WrhkSVW80DDBKlvAKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395

On Wed, Aug 13, 2025 at 05:46:44PM +0200, Richard Gobert wrote:
> Kuniyuki Iwashima wrote:
> > From: Richard Gobert <richardbgobert@gmail.com>
> >> @@ -4044,15 +4045,37 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
> >>  		conf->vni = vni;
> >>  	}
> >>  
> >> +	if (data[IFLA_VXLAN_LOCALBIND]) {
> >> +		if (changelink) {
> >> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCALBIND], "Cannot rebind locally");
> >> +			return -EOPNOTSUPP;
> >> +		}
> > 
> > Are these two "if" necessary ?
> 
> Creating a vxlan interface without localbind then adding localbind won't
> result in the socket being rebound. I might implement this in the future,
> but for simplicity, I didn't implement this yet.

I think Kuniyuki meant that you can just call vxlan_nl2flag() without
those two "if"s because the function is a NO-OP when the attribute is
not present and it will also fail the changelink operation.

> 
> > 
> > 
> >> +
> >> +		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LOCALBIND,
> >> +				    VXLAN_F_LOCALBIND, changelink,
> >> +				    false, extack);
> >> +		if (err)
> >> +			return err;
> >> +	}
> >> +

