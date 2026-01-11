Return-Path: <netdev+bounces-248804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B447DD0ED2A
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8B293019864
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057133C190;
	Sun, 11 Jan 2026 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LGqwwYfv"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5252833B6E9
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133377; cv=fail; b=KO284BKJrdTR8MS+957T5vitLkBu5MDWcfaca1n1h7TDcDVuoPiHW2M+/y4GOQb8L6s669327n9BEOsjZLnh73R5eqR/wLdncrQ8pGqIloNsrDiA09wks0Ir4fFN1el0ZCmahDpk/rC2f6j6+x5jUNh09+ul5eVV8eq32BNtoi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133377; c=relaxed/simple;
	bh=UnOtxOd1TjGlWF5sf1ryT262bTipMNuR6Dm4kWghX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVggke5jsIlXZuf8uoESgbsPYjcUytoeygCKzXP8ocrCe5rkP70sdVgj86kkblbXhrKxPnYc98CmdOrnGSgxoKcMXTAXsbCL/9AYg9eODa/3/KyScCH9r8KIJXLnA7/4TTW661lM7qcdQvvaMkL0+7tIjio/ntNndQNAcJrSZFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LGqwwYfv; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9bojZwKDG6M5svAdjH8lrdbEYsItfRHLIxXqZyjBNp4rlY1ND5DFwI/7VdVF09M7IgmprabQFzNKQH7nDJ72XFOpFi4wMnl50Xh5HkUUH16KKLQpZTIWaEZ4vW2a9eRG6p8D85DvXqVPmsSmpZnGG2v0ZigsWGtmeVS2zn7nniMCOPp+yBwdQpsULFZjy1hoM5fLWx4QGVhYbmnrSvSelNP7u5kA37RvAHAdfTZ/tlBEQaLcK2/MrdgArysXsksZY7WyE+KJyUPD6DxlaCR8d9aKohSeiGuO2vf0tQsgPwkQtywxrdbM3x99+87XNZ9VkpkUs1stO7QKj9lFXWfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxZuLwsDJovEQkDbeM9YNxGa+P6nF+FWFsoNbzERQr0=;
 b=d7KeBfUY7uNci53mfFxpJixZB4ygFvZ6G9P14zBG/xWkJG8D4swBdHAERAkbOZOd6/Kru45CZn/FHF38QC0Al9IKlDMfyolf/X6GcBKs+AUqnEm2c71ocRLn/GMmjWcWi6cwiPH+EbniEMO2wvV4JpBzsQHJgrToEbxGY5AGrDRaZpcM/0p8QKvU0YYs8GTKcxmooRgF9Ia9dHt+gaD9MhAtOztAo6T+/kTpUskiW7TvCYIT9Gpkh1xha9JR5V8MkTv+AthvcVVINgDpuzH/tOnhbez2uhkc9HJX2HydK4XFW28IcVl1H3K+r4zLZfvisf7qAuE+cOqe1/LxKQFXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxZuLwsDJovEQkDbeM9YNxGa+P6nF+FWFsoNbzERQr0=;
 b=LGqwwYfvaavYwF/wQDksYgSZ3xcb3HS0VVi+xibPS9UffOg9IaHcu77gxqibtMeYPpnBiE3+WNhV9+7AsAsLRT6x4m66V3B9qDqLeFVx98dgx2X5uNGQIwUjKwhmhrlVtkdBRCtS6Nd4DVJjjfCGIrqYpfFlP/fWoxNAktAa/bMki8zwl7eDPNsdUdE8dfMd9TWdA28lRJrAlQIjakTkXTDW/Q4QE0GO1O17LsW98/17TjGxaoTCgWdMHVr0m590RdpbOJeEtJNqJH1HMxh3RZdyZbaNZ1SrLhjQZjRFvRrCLAdsPenKx1jximWPJvE/vcE+7nVdF5EfbyvcMr+3IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 12:09:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 12:09:33 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/5] selftests: fib-onlink: Add test cases for nexthop device mismatch
Date: Sun, 11 Jan 2026 14:08:13 +0200
Message-ID: <20260111120813.159799-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111120813.159799-1-idosch@nvidia.com>
References: <20260111120813.159799-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cb6d76-1eff-4611-5dda-08de510a482f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHBmiTKqg+bAUelO7pNCtgiDKg8TlpfqHQk5IFykz/tyifOhSphszUda2Dx9?=
 =?us-ascii?Q?raqbbNUK51w7KhJOm5A0IUox1F9I9AKOtbcVgvANjqnGuMsX8oHSnKJ3U+Vu?=
 =?us-ascii?Q?HI3kFoqU/D7467jWqbbmTBCT9l28UwEqKFyP7KrCdnMSwaVeKkauf6MoxjbI?=
 =?us-ascii?Q?1VtIJGuKZ3syC8nwxpMVA/rgJ/nw3E86AjoyEYt+MXy0Fd1DGXyxP1E6FpMe?=
 =?us-ascii?Q?TMbjyHjKtsQw2IpXBiLwmwFoZ+dQ+9m9rswY1iEE4boqFLNvbkq51tFn9j8V?=
 =?us-ascii?Q?3/aF2cb1fpX2iehXTirWrmZQ2Xewmt7lw23zrDsH7TLSbm2gUpQL0PlK9ErK?=
 =?us-ascii?Q?Q5Ftd45T6Dcq0DHp3QoiYU7PzS6FAej2CNFtTKuPtQXLc8y7momPOA6FuOV4?=
 =?us-ascii?Q?YaEAmEE6TIgQBa0Q5PRtvZHU0RmY6z81UYGcjcvYfnlViTzZLrQKXGmY6J+g?=
 =?us-ascii?Q?VhuPqRDuyG3VKO4nH/+Ufs38gRFGLDs1NQ9kxKIV0v86Qi4cxc0a+1ArXJNL?=
 =?us-ascii?Q?6n0oADji5Ws/uaqy1TEqn6yrld6VXmw672cIFg7MkLrLB/5XD14V6xUq7t09?=
 =?us-ascii?Q?EOJ9738Fu8MjeebR6RnnLkVddMc5+r5YcAd1NLW/oONbhCzJFTOjF9izQU+w?=
 =?us-ascii?Q?vmCb1ekbRe62+HUdhT1F1xuuAFHOYbO2gToBrdQec1Ux5CG/aOT0dzoeDYCU?=
 =?us-ascii?Q?blQfN7/s0G7lim5Wej4NtYJrbNyV7lSt0wnR5ot8ux5psHv5KFwEP1spqn0a?=
 =?us-ascii?Q?i71ad+6CxR+EGOpOnvj5pPv/OJe0mSdyFL/F33u9f3csoXF7Di4IsZXUvrvQ?=
 =?us-ascii?Q?t+XzgT1T7pE5u3Mo88DazfW32KsLFX5g1I2YcRF3Dp83TTolJYTAaTfM0bzm?=
 =?us-ascii?Q?vzvcw5d08Cprh+0woPW895V71UAiPIwElgOgBRUmYA/8st4zDC54horWCdBQ?=
 =?us-ascii?Q?Y7/IlF9kXJ9Rr7sK1rgk7vjNnrjzq9oqYEzrwzXp18RCwj1u1FBo96en4gNt?=
 =?us-ascii?Q?cP4lT6gKUyPj5IjQaUJw/ycg+jqT1bU1egWc5rCtCOQyo6eDyZFdZqFPgRNy?=
 =?us-ascii?Q?WPFNyv2rCGRZ+uUxL8NmRIkDcXdf5RgzHOx4ccVUJw6DaImTwSAbqe6pqq41?=
 =?us-ascii?Q?qkHVKjV4/iK73XvZVQsja50w4GZvQ0g2nkTY77WfqQLj9p43dqqlg6zI66VZ?=
 =?us-ascii?Q?qNX39gcFzlDxY9JMyoXFm+bkxjyaI4tdAVepl0MauU23XcOmOHt24QPl8ow6?=
 =?us-ascii?Q?280ruXiFrKSlitQ9hP+2nQWvIRno12z3l9drLiZmYPEJNG/Yk0WVOjW+ufA1?=
 =?us-ascii?Q?eOroiRmmJrLE3gkuCBRMG+b5JTphBfIjGV34iZy3WDANeHT8i2WtwOsj2la9?=
 =?us-ascii?Q?535Q21ysZXEgXF6Tq7vWGImTQd5ilvdwN/rWdSIFaUWHAG1AUor2OR0Le9/1?=
 =?us-ascii?Q?xOH6xtm8YF3s20kUaNp3vcVSEPSI2amr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0S+utVWEyFyKaJ2UtNEBmf5mHNCAD9Dg0mX8RruyBeWJt7gB9HJuXtVbC2/+?=
 =?us-ascii?Q?Lpmd3DKab9OHNZFVhxN/wwbabNUK3kzXqGOTTDlKp/oGIhTX6WQNY5IX4P7B?=
 =?us-ascii?Q?HVPhbsLqGFH9HvcIzM12t6ecjJQbmVhF038wrQ6xwehJbPu1AXnDc03KJc5R?=
 =?us-ascii?Q?O7oDZpT3WrC64ENmPQ4ncZvJZEi9Mg9Sk2n0Wk5a1hdo8ymvUnWtAKMD4QVT?=
 =?us-ascii?Q?iwneyfW24jT1iQnw+1zzlMhwSm7wcvkDfYb6fPepP3pa+IMuut/codxNMSMR?=
 =?us-ascii?Q?zZwnA7Q8YzchKI512cQztrLdFeT+sa7N10StLWZv362+1FL8+uPEwNpoSYJi?=
 =?us-ascii?Q?FynLchxUFTrtlNhVtwMFFdyz5BZbdF0fj2n46ul1ZRcm5hdX3QDImVFmix3r?=
 =?us-ascii?Q?5/7OSzPYhu6EwrEAZyp/IbeaQqK9sl4P3ZTDCD77NGKqfJpvVRXk/rqhqmmM?=
 =?us-ascii?Q?E/mMmsEVhGKHGYKZCFp4QXDURsqK+/jBpuHa1zNisp4VmgdrVF4HA/iC9FUO?=
 =?us-ascii?Q?x99pS4Y8Vym4kWJN/WzRZJagoK6zX1HbjaJkIwXw0FLaPnQ5k/0INb0pOG/A?=
 =?us-ascii?Q?5lCo1CvI8bK+4nEKA2RLhhAVrgJB7P7xdGvFDHGDJ1fciepO/HcxXs+GV9GW?=
 =?us-ascii?Q?ne39hZPs4dUPPCbO/6ykJq5/Os3B3vfmPZV7Y7rKoFecOV6jk50wSNNvp2a+?=
 =?us-ascii?Q?H25BrADjFlfUR+0dMYhgiI8B9nIt2Ks23/Z+XhtfUMldeCpNs2nO9iue9Ty2?=
 =?us-ascii?Q?8T6NhO9btoEdKul2rgBTHsmPF6JeZWZzuE05xAS9TDGEA/QQ/8rsezPUgIoy?=
 =?us-ascii?Q?qxaPMBfu1pKzPmg1mTv2mZjOyAwP/GTXSOtUE4UAWrt2jc6zZfqMleX0QGCo?=
 =?us-ascii?Q?hWi1aYqm/+SpK9JgBWqk1hmCboiuu13bBwtzjMYythWMb3vuIUUabxVLussp?=
 =?us-ascii?Q?4woiQP0FFf2zWyJR1SQcdUlPrSaK88YzTXH/h0ZISF1EA7NZZvXLxdWsojUr?=
 =?us-ascii?Q?PrdKC+ALW+1DKbq3DWQLSTHymeQxpSf9xEHeJnfgT4ZmHiPjaO5dYCdF635S?=
 =?us-ascii?Q?5oe5mi4zrqw/RL0dkL2bsudmWIsJCKAaCCv37f5s/JFlpE2BDNSFwMmstSRm?=
 =?us-ascii?Q?WyUt0/eJFdMd7kRPYO7Xf6qg27WsRpftzZgVdDWpQa+pfz+NdsHX5/EdcXmy?=
 =?us-ascii?Q?V77zI6aVUZh1jHbId1LK2L/p3AUbhNLO0niD7GLW/q3g+wEVHcmb/gdfolmY?=
 =?us-ascii?Q?+EcZbmwq4+BN8LLhCrdumn0ZQO38o8sNiPIfhIxOSpqsnlhPbJ8Vm/K8FTuU?=
 =?us-ascii?Q?cV9RG5KtXjJkz5Mlaf7TwlygB/JWr4TZ6TTmYIYN0r5rZaCofXWspta7LW2w?=
 =?us-ascii?Q?CzjqaYxYM3WDuSVTpYNh6czlYnJnQRZqPzPiMVYvfxH4U+FKRnY/+AGfjP4I?=
 =?us-ascii?Q?BP3aimacdq62SmA8FEOMkp55toppB7kpnlrO+9U/+IZug8T20HlQUxDqAhsU?=
 =?us-ascii?Q?bsLALOUhbYTlqlFPrMgEY7Wxb+6zx7zRMMqhybmGHOpVai4cT1gsviRSS06K?=
 =?us-ascii?Q?Lw9K9u1k7T8PiQuhc1cPyVDK6RiTF1UXmQ2tISg3STst/e7+JdWtyqrEKn04?=
 =?us-ascii?Q?DVemeUjFkX40zvyjaxmSINQRRryw4TT3Yz85p1oL0PQn9SAlk/MDj0uPmb8X?=
 =?us-ascii?Q?FG5DzkmM0NewBGAdoTrmD6RspehNQiiQGmgtQH8X7NkmjuBP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cb6d76-1eff-4611-5dda-08de510a482f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 12:09:33.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cjy8ivuB+Wb0Qmp74/Xr/JrsIeMmxK9y51PVgtifm4uSaHNYgSROGB09y73jo0J3XGb6fCqCWS0CVLDxSSY6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B

Add test cases that verify that when the "onlink" keyword is specified,
both address families (with and without VRF) accept routes with a
gateway address that is reachable via a different interface than the one
specified.

Output without "ipv6: Allow for nexthop device mismatch with "onlink"":

 # ./fib-onlink-tests.sh | grep mismatch
 TEST: nexthop device mismatch                             [ OK ]
 TEST: nexthop device mismatch                             [ OK ]
 TEST: nexthop device mismatch                             [FAIL]
 TEST: nexthop device mismatch                             [FAIL]

Output with "ipv6: Allow for nexthop device mismatch with "onlink"":

 # ./fib-onlink-tests.sh | grep mismatch
 TEST: nexthop device mismatch                             [ OK ]
 TEST: nexthop device mismatch                             [ OK ]
 TEST: nexthop device mismatch                             [ OK ]
 TEST: nexthop device mismatch                             [ OK ]

That is, the IPv4 tests were always passing, but the IPv6 ones only pass
after the specified patch.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index 7a0fd7a91e4e..b5773ac8847d 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -271,11 +271,15 @@ valid_onlink_ipv4()
 
 	run_ip 254 ${TEST_NET4[1]}.1 ${CONGW[1]} ${NETIFS[p1]} 0 "unicast connected"
 	run_ip 254 ${TEST_NET4[1]}.2 ${RECGW4[1]} ${NETIFS[p1]} 0 "unicast recursive"
+	run_ip 254 ${TEST_NET4[1]}.9 ${CONGW[1]} ${NETIFS[p3]} 0 \
+		"nexthop device mismatch"
 
 	log_subsection "VRF ${VRF}"
 
 	run_ip ${VRF_TABLE} ${TEST_NET4[2]}.1 ${CONGW[3]} ${NETIFS[p5]} 0 "unicast connected"
 	run_ip ${VRF_TABLE} ${TEST_NET4[2]}.2 ${RECGW4[2]} ${NETIFS[p5]} 0 "unicast recursive"
+	run_ip ${VRF_TABLE} ${TEST_NET4[2]}.10 ${CONGW[3]} ${NETIFS[p7]} 0 \
+		"nexthop device mismatch"
 
 	log_subsection "VRF device, PBR table"
 
@@ -366,12 +370,16 @@ valid_onlink_ipv6()
 	run_ip6 254 ${TEST_NET6[1]}::1 ${V6ADDRS[p1]/::*}::64 ${NETIFS[p1]} 0 "unicast connected"
 	run_ip6 254 ${TEST_NET6[1]}::2 ${RECGW6[1]} ${NETIFS[p1]} 0 "unicast recursive"
 	run_ip6 254 ${TEST_NET6[1]}::3 ::ffff:${TEST_NET4IN6[1]} ${NETIFS[p1]} 0 "v4-mapped"
+	run_ip6 254 ${TEST_NET6[1]}::a ${V6ADDRS[p1]/::*}::64 ${NETIFS[p3]} 0 \
+		"nexthop device mismatch"
 
 	log_subsection "VRF ${VRF}"
 
 	run_ip6 ${VRF_TABLE} ${TEST_NET6[2]}::1 ${V6ADDRS[p5]/::*}::64 ${NETIFS[p5]} 0 "unicast connected"
 	run_ip6 ${VRF_TABLE} ${TEST_NET6[2]}::2 ${RECGW6[2]} ${NETIFS[p5]} 0 "unicast recursive"
 	run_ip6 ${VRF_TABLE} ${TEST_NET6[2]}::3 ::ffff:${TEST_NET4IN6[2]} ${NETIFS[p5]} 0 "v4-mapped"
+	run_ip6 ${VRF_TABLE} ${TEST_NET6[2]}::b ${V6ADDRS[p5]/::*}::64 \
+		${NETIFS[p7]} 0 "nexthop device mismatch"
 
 	log_subsection "VRF device, PBR table"
 
-- 
2.52.0


