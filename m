Return-Path: <netdev+bounces-261217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBJQJ6f+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB911A23E8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 512773000E0D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C1392834;
	Thu, 26 Feb 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ICaLfeCv"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E8392809;
	Thu, 26 Feb 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092901; cv=fail; b=FKJ5dakXPlUezFMobqSJnpaxP+loVuAqLos0oqzbRvSfjVwKaE0c2iwdmCPpPzdMgxkCJ6UWkt/xNXkc8J7SGIXqk7eWHhrXKGej+Kx1ViLl7fJOTbvkkM/T9ma9fcrqwixQvAWm518gFEcJkeZ//sl3wNgNksFTMrnTOwB7f3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092901; c=relaxed/simple;
	bh=z+57HIIsA55vrVIFk571rvGqxBYClTO5F6JE9LfEPyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WaAMrh6pPA6b4H8vt0xVOAkAUmpKoL2Q0rwUE3TVaRHZfPOXILAaMQxF3LFn3s7QnEFFANLPI60y6p0uDYOpXmU7e4ohT0RtwEwAVbLXcb/b50sez48GBNAwNlVF6Se0YXQgu9FZShyVmZ57YLnxxxxwyReIsteL2KNeheAX4t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ICaLfeCv; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIh+LHbSOp1XeJ4Axh/BwrfNzNQmotwD70D73XXutJWkUuC7QQ+kymTp/cgeG0iYpDBWFGgpcfXitEhH85hscH1ae+TI+f3TeLWM6YJcybo8kNRBXMMhybLfnu8dJgTU1c15atKR4fmP4HdbWnGWlV0gjc7JJgGlMe7hliXkYLj/BKaxXB48UZPlhvFEfV/pBGhUiifdFxdDm6/pXgmrSRNODT1B50LvIdu8YJB0grpfnwjh47VGPSoElDN9ijlVHjJ7dIe8PQwUMx9nNJKcpdyV+4ByspAp/osttYOUUwI2Z9b3mQCHyc699lx3PO8ULWaW+vl762GHWzR7krdXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69CUdYqDgatz7b0lOQQi9ZtWllMfKO23ISGNNZLRGmU=;
 b=VoQ3vMNroLMYq2r7kVH2xt5Y2E4EQPd00o/gQkBZgshx/Lvcs74KlbcScUcOidQQnBR/jqqU12qdWI0TSzQyzBbR+eYeZgeIJCfRDsPgef+bwjWWcBafQzEI+CQmXhJRmOS00qXaSF6/bI6oz8QPmGivdqhISpDWxws9zFDXnp0E4eZc1FyL1BEolTp+tvQhP6b6IClyVHA8S/ueiLAEbuHugox+t8aTwmQRIaNm40jFQgRVGdw15NQXY3giuupt5+QcbN83tdu7jQjLFoWYhcfVQOc/CRyc8oG2s+0vaxewWvJhdtnd0F3PVOb5UUNj90sUtGlfINukM2ufGi8Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69CUdYqDgatz7b0lOQQi9ZtWllMfKO23ISGNNZLRGmU=;
 b=ICaLfeCvSFumgjuYGysj7RCj0Y9Dr0GyaJPWx4Bfb4ThYi+yjkROv6y0bEOVNl+yc/9B+839Lpq4lfRGzq7FcK/uHkDiBt00omJHiNq1ywEMf7Gzhi3xk5HcYNTgfU/qgrBTOF2vbd7OwXjQxK/I7AIwHDgnCUN6uwNBv1oC4QZ3GvOublJlhSeFfKO8akig98JqrNmo4A4g3BA2m/bijsXLGwakI71N5wn45pqDrACgz9QdxO8TA7g5+wXCtzyZ3oD6anrlFmqTRYiap7fkkBJ+ViyZ1aQje8cGolURlMWMYy+Fy4hLRxD3vgpsZ2tuGBrD1H8mMnlrZSMcy7knSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:01:37 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:01:37 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@gmail.com,
	petrm@nvidia.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH bpf-next 6/9] bpf: fib_lookup: Honor oif in IPv6 output route lookups
Date: Thu, 26 Feb 2026 10:00:00 +0200
Message-ID: <20260226080003.524935-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
References: <20260226080003.524935-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b84b6c-6e1e-43a3-0ee7-08de750d4428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	X+ZzqKJvYMnqbLCVsqlipWfn83NHlsaYuwqJlThW8GaAH7Cd+KJuyn99uRDjL31JCqbhg47KFl7lYrrJddFrzjQXQyXfCTjejnmHqdrZbvtJCFXa+hjnvBQW69ulm0h67HkFfDfeqTNFH1K6vw55vZi60yaV/8QG0FGxdlSdTXMBcex/H6XJVJ9+UpW0j6YWTXZF8QjuRdyhhF0l/5s6CgbzElPTxurQ85RJPNmLfd2GdbmyQ8aPWkPu9lNG7VEc9Mb+xmm7r30ah8FqOALPrHaLY+30MmdPjlHWE+VN/CoOfu7BsED9JaWd+mdb+lf43rzXZ7k9oBs3L2jlFbxeA3TVuaR5HUoW5/CwVYai9sb/BkA+joA8eOtjiaF7b4T2FruXO8CYnnFrXqNfFSk6ADjcf5gD40fnySddiW7VjxeU40hRTrZk94yRXeJ/ZjvphEbmZH/JswRQydzd848zHwawyBcMwvxP2wZD/YSImbIuHeCGHBHGZj2zP0FP4dnEfyq7umPs6MsQ300GOoIZ5apobZYi5/S1YveTAP3+2QmeZUKdMVAKiMAtezuAeh9+L0ZxAHTmV9aNmG7HLcwAwWQhzaB9SxJg5taFrbZbwl5akG/9XI2RJ9V75y1sFZ7M7RLA0cEHF5x6bk3oMimmst9NP1NZSN4pGHGyhUM2t7PE3xKhDCWRQSob/eqrxNzCFAux4v/jTWzjrVwTwRF75iBvUCUrA1EBtyBDtFinPIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kai5FpoYyZXK5miw2XcniOCaQ2dZlu7Q52rs9d7P6iHKEYV+LvERGvSB4GsC?=
 =?us-ascii?Q?UVeM6jjJTsD2z5YRtC5Tan9LIZ+8K1XTtmTC65Ou/wzZtUdZZ1haHSPkVChr?=
 =?us-ascii?Q?7w0PPcUebtEZG+F1m8WIm+rbM8yaNOpmP8RDav0kSi+2tHKsmpt9r54PWRkp?=
 =?us-ascii?Q?zPpk80rIVIg+gaoYy10THcj0O6iYxc/8AOMdeWLUS5Y7a3DrT+VIznyU3SfM?=
 =?us-ascii?Q?lKSSEE+fg/ymXuOpvHKYmoDy12gORX4JjCJTA//a3N7KAm1um08KBgEnXjJP?=
 =?us-ascii?Q?BBciH0K1Vzo/aKeLaeSCdgf/BZOZPy/Iq+GQCOi7kXbB0mPOhHluwmJTdwwZ?=
 =?us-ascii?Q?6frpEwZu1u2EvO6djg8A0ycKHrEJX54HcbFXC+FVUCJ4WpoOvWqbv9xXRGO1?=
 =?us-ascii?Q?b9WVtmFV8u87/PPilgcuGiOUGnz9E4kl+UZGF3QlJvmUPs0Pv4vwhCtjDu0q?=
 =?us-ascii?Q?n5q/5f8as1LnaPA/7E8Hntau/v5Iq81MiG+dUZrDBqEjL+G9YUMldAzMaYbW?=
 =?us-ascii?Q?K+bVtf2UfH7lZpMZyhyXC/8fFxkkvFDAkngtYNeJkytcz+2ykMQeisll361+?=
 =?us-ascii?Q?NXQ5pC9/BOqJuNLlLe8JZC9hKvNgaHIxVxT9dt2raRFBOE73+0W6NYpu6GcP?=
 =?us-ascii?Q?r1VhfLItwKYOtoIa+PoLPjgHIU+wONITgfccpZDSJn6WyOFboKOPzgoplh20?=
 =?us-ascii?Q?iPHdpWjrkyqLsR0OHauFeGm8S11TJEHiRGWZluZFIEjAbdmfwMc6xtdPRMF/?=
 =?us-ascii?Q?jPMA5S8bvtJdxLQ0J6Po3acHkY4/v2L3PZbdF4veME3xgpWMVxnt4o3rzoE+?=
 =?us-ascii?Q?ZCLi6o1Cn/7++f5Zblayq1/3lWyaO9SM7zloQFXqqOocoReL260SuzuBooLm?=
 =?us-ascii?Q?4IV2z3r31Cnbsqpy5t2kFi7+EL9OHu3XrvcQaavfQ1ifcv4FsI/AdCmVInoe?=
 =?us-ascii?Q?yCP5N2GNmV18nzbRSXdsb1DF8CgQkUh+ybnKwsLEf/3qw4MsjPzMCjK189CV?=
 =?us-ascii?Q?Z0lz6kOdsQK3JaGvKeAOcXDRzhnLpxi2Bdo5EyeE9PVMKDZLHjlOhGV7hwnq?=
 =?us-ascii?Q?VkPW/almrhrLZBr8VFuCus3sXrOaWIfrLSeFcxYThGEc5wnjTCSaJFMgRNSL?=
 =?us-ascii?Q?NPMjwIPoGm4rXXtzYxEMEM97h2KKCkqKVanOc3XVjDmyOJ9QDx5Fq/GpYe1M?=
 =?us-ascii?Q?Hw2LHNUaJZfTpQPlFvZg45tv3EtN1RwaHVjBgOHuTxoGjlkliAwFYByH93P4?=
 =?us-ascii?Q?rf5FPBFRm8DujE+68WB52VuB3fXhO+SF/B/oRg/vrzHLKV72NVpg3x+fb+bw?=
 =?us-ascii?Q?mWiLtxq2u+QINS687Bta/EiSdsUeP4n1cEZdb5ck+1L/hg8DxgIamof2nhf9?=
 =?us-ascii?Q?F0eRqgQvED1vaNtK6nAKXIosbBT7xj6Gdk8/D8rtygrag6dkLhG1yofnChih?=
 =?us-ascii?Q?Gz/+kk4/yrxd8jE1Gv62S17QCglIFsfUhaPBju1vP4J2CXpnPiDRJuHLEgRK?=
 =?us-ascii?Q?aXxUmPST+3xzDIhHAnIpS0dBR/WCTQFtsxsUbH08Ryvn/mH0ZJdNlAB0GKHy?=
 =?us-ascii?Q?hGvAOEPLmvOeOepImE/YIJwV3gHLDFFJjM4nSlWYL4MdGCMzp5IGYqV4Su1C?=
 =?us-ascii?Q?+gaEMtG9MD4GaXV4n4bvNR64jB3Unw4DXrFTPwa/tGIHIhIrYGJhhp79ICr8?=
 =?us-ascii?Q?LaFeCYUGCpCjm9kfjCyhWr9qm/beG/zy0iEKK1q/jkhlxaPdbkh5RJWc7qIL?=
 =?us-ascii?Q?sjyctLILtw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b84b6c-6e1e-43a3-0ee7-08de750d4428
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:01:37.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA5uQz3e6edLWn2f1ganHcKSffGEzJPqZqAau5kg3z0ohyvkrsUILjVlpDLZ9/0myKVGOsg7Pbf5y5yNwwIJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261217-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 2DB911A23E8
X-Rspamd-Action: no action

Currently, output route lookups behave differently between IPv4 and IPv6
when performed via the bpf_fib_lookup() helper with the
BPF_FIB_LOOKUP_OUTPUT flag.

IPv4 honors the oif and resolves the most specific route whose nexthop
device matches the oif. If no such route exists, an error is returned.

On the other hand, IPv6 simply resolves the most specific route, even if
its nexthop device does not match the specified oif.

Fix this by setting the RT6_LOOKUP_F_IFACE flag when performing an
output route lookup, so that a device mismatch will be considered a
fatal error.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0d5d5a17acb2..e92552b139b1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6255,6 +6255,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (flags & BPF_FIB_LOOKUP_OUTPUT) {
 		fl6.flowi6_iif = 1;
 		oif = fl6.flowi6_oif = params->ifindex;
+		strict = RT6_LOOKUP_F_IFACE;
 	} else {
 		oif = fl6.flowi6_iif = params->ifindex;
 		fl6.flowi6_oif = 0;
-- 
2.53.0


