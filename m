Return-Path: <netdev+bounces-250150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A801ED24533
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FF743092238
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759B33DEEB;
	Thu, 15 Jan 2026 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pTNRkhj1"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B23570AF
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477856; cv=fail; b=Rp3/Kuyliw70thJ4Dt05AKSH1D/6JeUBw64gF5Dmi+QFafuyHaOBgwhgWxiLgVJQwZDEGPYMN0ZGcgGpm23TvjrtOq5kezPqCxTNsvQHODCLvSFFiODRIn/rIxE0XowFAlzf9Uhc2MjNPyuI8YykDNuZQ9o7PsXdREJFw0rIlSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477856; c=relaxed/simple;
	bh=BKhps9tM5uPWf3DsF9fYeAZsmSvs+JyxhcAf+wnlEoY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cW2+N7gmEhoF7WvndWVsHp3wP3OdxLc+t8/MNNRkkK0RhaASV3xtfB9M823sQIwa+Qyf410T4su1fO8R1Dkq8edRSz0e2l5b36v1E4N9++mbY+JREe+a2Rnin5KyHSJJT6JkZQUUK7wbzX7Eg6CDOew0WhXqfzpU6KVx0VFF9GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pTNRkhj1; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGlx9L9aatl/YwgFuDsNnoLpYmla6y9l5H6Ul9NzoXZZ3eTDa2i/tcvUOf0UFRCnJ2GDtlm32T8OLigrbmqEf96YZcS3DxKVH/rh2MpRwG3OaX4SGXW9Pjc9wQ88gpGZvQhyYMLlZXzBqyzm6nr6JWkKI1/opPdd4Fc6PEriJBmBJizZARGROXT8pHXxpx0w7IeQfS8z4vmE+i1rqyYSObmoen0Iu4OQKc9YK8TaoA92oJmc8lYxHtvjpHuhkUfs0eKbuQEUFoXxsCFjJ8w84qv+jiqzTniUU4GblrQRKQOsiMkrNZFHpBx3ut2Y4OHAr1wMd1N/oR5I5axkiRLaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPWfwS1+vYGPY8o4HAOVT0c6td2SJNqWgMQpE49yzoQ=;
 b=XrwvRiu1PGQIVth48jhUyt0NG29vefUFTLTn76luHEI73Mk+YQwhO/0iAcIIe177r0QGLLnsdlpJZQ8CxpTOBe5NLQQX8aSa3QpglX8uDKeONwN3txbGMLg7hyazsYfWR5FAk5oQMTQPZ/ughg1CnjP+Dff2tLNr0L9AHVc7n1F8hdOsAe7Er1fZ3NWHHTr1U/D2y9+otFou19Od6K2Lb9ZPNuHH+PDDlr3ziiJ6sP9wKpiVgUY7sh1q+aVTC85nAT2BdV543/+0ISHl5ELhX8K+EgGOyUZxvylVhIhD0u/ptAOJ9X9Z8RLn90bkkNGXe1EAQO5ddO3ZecD8t52bYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPWfwS1+vYGPY8o4HAOVT0c6td2SJNqWgMQpE49yzoQ=;
 b=pTNRkhj1nMgrD4R9kyQ4fkmd0ZykK5p6csWdHID9erAwKDfrtyBG+WAj4asvNuzC2B057Zryw2XQI6/0fq50HavY7KhxH2jER1W0SXS5+wsMW5eA5YyORgQbdLFM6pB7r49Ab5u6Fi/DtpOBNE/t/Bi5eLMVc9rowcRhsqVQvJcCjT9hg7k6DDhFiLor4bEmsZtLIAk+QMws6LzJw1rzO6H1FGZZz1NDYmbbTYSpvZEtGqUdhlCZ3ciC0GoNZf+PSR44v7vwXcHPrlsIPyWlXNwhmlx2WFdqxx1o9rS3hz9l9Pn+Oinjs25g3Y4cXIvlNoKf3Yyum3rrd4KUex6GGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 11:50:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 11:50:51 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@kernel.org,
	jiri@nvidia.com,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2] devlink: Fix resource show output
Date: Thu, 15 Jan 2026 13:50:04 +0200
Message-ID: <20260115115004.863685-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7bdbeb-9763-4417-cb87-08de542c54ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOlwH5fFrE2Q4V0BYerU10obL4zyIxdWWT/IG/RwWQnBxtUt8pzdhvC7kwJC?=
 =?us-ascii?Q?48efh+aPunfju7U73MY7m0HfhGbCTQRnH0lE8VOO4wUxMHqdbbmnkcLzu3sD?=
 =?us-ascii?Q?rCbx8bau4EbqSMHELGVNVQ3BDtbKa9WL3ZdvD0Ksdrqg3Z3JBXNRpOX41Lq9?=
 =?us-ascii?Q?iKAxfO9R1OjZUy+MgG69YyU+PztVKCrqKRkywxIN/J017xqcX29YXAMGLJT3?=
 =?us-ascii?Q?qWcIToteQp/NdP+8CROYG1pBuMRbRcIMBA8oR3l/iReKXidV5g6/Pg9SYpYh?=
 =?us-ascii?Q?XWVGBLmXxzx3bRoIM6CImCRTsFZyQDCu/KaruBzAP2nJLXYEHX83Bi/I+zK/?=
 =?us-ascii?Q?4t0XArVlEhn6j+b5oETOhfkASC91WngUop7iRAkv+hPhkqSJtrN3HaA+a3ZD?=
 =?us-ascii?Q?HNvZuL1NeSyx8DUhgdW8OsBBi9MdsxZluKh+H1izYJvOwlMpt886D0/dNl7O?=
 =?us-ascii?Q?gwSy+n9eP9VYBxHlxcs1VWQ1LrgOvMAkdl3oy5Mhy0rWCDaofTtamfd/FpCc?=
 =?us-ascii?Q?UY81+vlTc029X0KUQLmi027wlqOUzs8Ax0QMwUIDb44Y5PcJMOZ9NNfocnVk?=
 =?us-ascii?Q?W9Oe+/vVhQDt3o12ZzRpUuJ8JC1/xEmIw5YCPLiboLr4PE30fc4YDDvEYFz1?=
 =?us-ascii?Q?bqPh7s3eUvNWrXP/7nKs087gw6vGIGpZOv3bB3EzBRXJDplQWkWigkz87Q/7?=
 =?us-ascii?Q?GKZt8m4IvYucI+m5DfpGoCrMbuEDb6Gdsa/9A/j2Oho2ApABfSWCcxkrKl7S?=
 =?us-ascii?Q?qyskKZvIuVMygQ6tM67lC++bE8dV25i/r6jG/so7QFq3sgUUv1p/gKcKnU+V?=
 =?us-ascii?Q?p6oG/aQpjUXn+Pj573d9RrQf7LwmUufGUQIIAS4DkIM45/hX7xu2lZGD6+dV?=
 =?us-ascii?Q?Rq2kXZx6bfCWYizKWdvZ35xpbTbVQ3aJqhLxfvNeeqHkjIdRnblGejc5ViBw?=
 =?us-ascii?Q?hOvFFc894uyyy3/dz1ILtiT3X9X1bfhXZsjwmhN7EBWwBdIR0vMvty/BiLfL?=
 =?us-ascii?Q?kaW2/+VQ0mer3ZXkhEzW+A+n9+flsS13TmhTi9RX2pcG0kSfv7ZArQYv5zhD?=
 =?us-ascii?Q?0obs1taAWisnf1eQx9EpMtFHc4mLD3jknKGhkxXKQc716rxVSAk0kzX8C9nj?=
 =?us-ascii?Q?m0ZbONYYWqKDZHg2wjqN8qWtkopyKd5ZYF4Udisy6bbNqE2+fLIMGGtlNMOY?=
 =?us-ascii?Q?svTAXzcjwGPAFZuJRQKBeRv0+LsfXAj94w/wItxWhQaV11vMwZm3FOVqVAD3?=
 =?us-ascii?Q?WBVEX8KItV4v3f3XmyOmRFEZ9hmHlclybs6nPc0/I/4O+q1AR/LWwIE1MHsi?=
 =?us-ascii?Q?90tdF9LW4A4+HJ2R/65ppEqnXQ9AxXw9gHxjl1BbMr2HAPQiJw6MghIUvxdC?=
 =?us-ascii?Q?FUqWU/YcTWsHNo4O+CwqRbkttB3Pjr7ZvIe8WQZfuTbVt/whitQgZgtWcNnJ?=
 =?us-ascii?Q?nwEpOdVJCi3z3aj7Zl+3Cvk4gwuXhQXNeEC91Ot9W2mk4CvUP3HJN4sL2INX?=
 =?us-ascii?Q?bkcXp4kGtz8ToFguVWBqxsOs4Wx5btYoYKazy9WgdUFF4rCFzp0ahxt5qNO4?=
 =?us-ascii?Q?y1azoPTaa31ZfHdY54s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDo27ZmzHX4cQTBV+QU/pQNPbh/qDOaaBMAxPZi2GPgMtpKzDC0umouVwwv3?=
 =?us-ascii?Q?68S++nlZXhedHF4/DYQ1y7ZIJl+Dx4tJw8zs3B6gbu83sJQ1d+bvv8331BKc?=
 =?us-ascii?Q?WsR2Li1uxQsxl+Bh6DbuBhAefOozwAnNjHGIClFWOIshSogT+f4y1O8vShxa?=
 =?us-ascii?Q?L/NQU76Un4vm00nSVIrv9xVRVttDUx7kyBtAx//CYe8fhRgoUyg4CepObbXe?=
 =?us-ascii?Q?lLCMh9pkryResZtCGC07ZEIeTQ5q9Drmw3RSNsZFBbfM8//ohzFRK40y7mz0?=
 =?us-ascii?Q?z36vgeyV9XGHnbHHplSUvNLd6NGLytzYMKwHwP2Pxr8bMXEjvftq8cV9KkCo?=
 =?us-ascii?Q?eHFRnX07YUuEjAt6xMerbCdczOcejgZ5jFONDEgnnJUKdY7jezlsHnT8gmVg?=
 =?us-ascii?Q?npJI3rPpICtg42kxwkiUt1XhpJuYiG5FrBvN730BWQlMy1SCp+VsFBVAnDQ2?=
 =?us-ascii?Q?MpU8R891xP4I3AbLyNDsS06IXe3bpFpLzGsp1AufBu7cv5S6o1p1IhViuAqu?=
 =?us-ascii?Q?NA3It0lTqi/6dUcaSAYZozk4k/AQnVvZjgHLbEyqVrhp0moUBuFqo031M1+e?=
 =?us-ascii?Q?hVnZCRRcINJhkqCeYqz3j0pwheU1WwlXt6NHp4pPZkk1fzsVtq4bQUxIhb8B?=
 =?us-ascii?Q?tA5VqfxinJvuNiY35AVe6jBg9mk1vQJ0fjco4fZc3LlJM++JNS9POrmvPsP5?=
 =?us-ascii?Q?jm6mug4fiNgWl76ae4zSOn7iEwpaakBXJJJI2koRphzH+CojLSJH6JxIlbmJ?=
 =?us-ascii?Q?C6sx10UoNDgmp6q2u+6NUFM6Zv7MPu0iu7SivpmEeoyKovhbjTwLs2iV8uYC?=
 =?us-ascii?Q?1rMcIwfgtuIMVMt65up1f4hO221OIzH2KI/Z1bgkit490eLBVxLVRehCX0IZ?=
 =?us-ascii?Q?bSviG3xSn7/n/4kQfw8JqyJ2iTdoiiJbykf6lUFOukXjbednAjARUz7vXecw?=
 =?us-ascii?Q?0FUM2X05XpqdRnh9QshMn4KpZ4DJmfPM3Avch0CDtRNaNMDJIGJGDSMjIDnz?=
 =?us-ascii?Q?Xer7LMWflY6ECoUd6A8r+9j61KUK7f1mY/LVcXE7FFi+2UWTtxFR0oQnIRN4?=
 =?us-ascii?Q?7PP4e8E4k5D6bYzVOGC34NqLB1WskYuCBDOGftkiadGCw6s2bURynyCscigz?=
 =?us-ascii?Q?k7LuRFzRI+Wq9JHCokf1N+1vot1WFrHuOKIX/lMU7n4glLzi+7e8lbqjpBKG?=
 =?us-ascii?Q?uzqta5VjyD5TrNBxp0+uORsttrmNmHjvgAgkJDClkzgW2PR+x4rjyEN4QEM9?=
 =?us-ascii?Q?kdBI1yO+k8fZKaNCXqlDr79ATObyHhF4PNh0Pqiu/RGxgeqeWA474smELr3a?=
 =?us-ascii?Q?YukcA5YVIPnN5baN8ueOTfSdrqLtBX9s5DRpyPE8vb5DKl3l8Qt5LYAn0rnq?=
 =?us-ascii?Q?Yd+yB46S5Eeozf4BwGSWLC37wfdKkMENvuO/V1yhG1JH9Hdn03deTNyyByXl?=
 =?us-ascii?Q?PE0dyQU+RyeiptpxIDS1GZTSOJuDpgiWBLVrQB6xht8+BDDG6O8noExB65bb?=
 =?us-ascii?Q?k+7O4R9h3n3CzA7EKWOgFIxO2hmmbsEi/sCc5UkRaj2nSEVz2lkMFwuN1vc8?=
 =?us-ascii?Q?OSuvK9bYIfJ6WvqZIPVLkc+gUQcI5laj9/67NgP0F5f8aUwE+dAu8T2ckqcr?=
 =?us-ascii?Q?fzcUgEl8CYF+vG23Zcxn5cFd/bck708wWA24Ab/Mc/blEv/ciCzOxlFT8eF6?=
 =?us-ascii?Q?2IGqjEtZ69QkKS6beRPgR5+t2SYvoo/EUKHGaoYuRi1Zh9MOczto9tD/yHC0?=
 =?us-ascii?Q?6p3Y4FcZ+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7bdbeb-9763-4417-cb87-08de542c54ea
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 11:50:51.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMGjhTyCwNZ6F+lRc5F41cotqENshYVYNmUVbIo5lWWBExqfq/2j0VTsBDmKyGCpwgUZpkyxdAzJJqq4cSR69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753

When the user asks to show device resources, devlink first queries the
device's dpipe tables so that it will be able to show the association
between resources and dpipe tables.

In this flow, 'ctx->resources' is always NULL as resources have yet to
be retrieved. As a result, the dpipe tables are not associated with a
resource identifier and the resource show command does not show any
dpipe tables:

$ devlink resource show pci/0000:03:00.0
pci/0000:03:00.0:
  name kvd size 258048 unit entry dpipe_tables none
    resources:
      name linear size 98304 occ 1 unit entry size_min 0 size_max 159744 size_gran 128 dpipe_tables none
        resources:
          name singles size 16384 occ 1 unit entry size_min 0 size_max 159744 size_gran 1 dpipe_tables none
          name chunks size 49152 occ 0 unit entry size_min 0 size_max 159744 size_gran 32 dpipe_tables none
          name large_chunks size 32768 occ 0 unit entry size_min 0 size_max 159744 size_gran 512 dpipe_tables none
      name hash_double size 65408 unit entry size_min 32768 size_max 192512 size_gran 128 dpipe_tables none
      name hash_single size 94336 unit entry size_min 65536 size_max 225280 size_gran 128 dpipe_tables none
  name span_agents size 3 occ 0 unit entry dpipe_tables none
  name counters size 32766 occ 4 unit entry dpipe_tables none
    resources:
      name rif size 8192 occ 0 unit entry dpipe_tables none
      name flow size 24574 occ 4 unit entry dpipe_tables none
  name global_policers size 1000 unit entry dpipe_tables none
    resources:
      name single_rate_policers size 968 occ 0 unit entry dpipe_tables none
  name rif_mac_profiles size 1 occ 0 unit entry dpipe_tables none
  name rifs size 1000 occ 1 unit entry dpipe_tables none
  name port_range_registers size 16 occ 0 unit entry dpipe_tables none
  name physical_ports size 64 occ 32 unit entry dpipe_tables none

Fix by moving the check against 'ctx->resources' to the place where it
is actually used. Output after the fix:

$ devlink resource show pci/0000:03:00.0
pci/0000:03:00.0:
  name kvd size 258048 unit entry dpipe_tables none
    resources:
      name linear size 98304 occ 1 unit entry size_min 0 size_max 159744 size_gran 128
        dpipe_tables:
          table_name mlxsw_adj
        resources:
          name singles size 16384 occ 1 unit entry size_min 0 size_max 159744 size_gran 1 dpipe_tables none
          name chunks size 49152 occ 0 unit entry size_min 0 size_max 159744 size_gran 32 dpipe_tables none
          name large_chunks size 32768 occ 0 unit entry size_min 0 size_max 159744 size_gran 512 dpipe_tables none
      name hash_double size 65408 unit entry size_min 32768 size_max 192512 size_gran 128
        dpipe_tables:
          table_name mlxsw_host6
      name hash_single size 94336 unit entry size_min 65536 size_max 225280 size_gran 128
        dpipe_tables:
          table_name mlxsw_host4
  name span_agents size 3 occ 0 unit entry dpipe_tables none
  name counters size 32766 occ 4 unit entry dpipe_tables none
    resources:
      name rif size 8192 occ 0 unit entry dpipe_tables none
      name flow size 24574 occ 4 unit entry dpipe_tables none
  name global_policers size 1000 unit entry dpipe_tables none
    resources:
      name single_rate_policers size 968 occ 0 unit entry dpipe_tables none
  name rif_mac_profiles size 1 occ 0 unit entry dpipe_tables none
  name rifs size 1000 occ 1 unit entry dpipe_tables none
  name port_range_registers size 16 occ 0 unit entry dpipe_tables none
  name physical_ports size 64 occ 32 unit entry dpipe_tables none

Fixes: 0e7e1819453c ("devlink: relax dpipe table show dependency on resources")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 devlink/devlink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index b95fd348007c..0b3bf197e6f2 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -8088,8 +8088,7 @@ static int dpipe_table_show(struct dpipe_ctx *ctx, struct nlattr *nl)
 	size = mnl_attr_get_u32(nla_table[DEVLINK_ATTR_DPIPE_TABLE_SIZE]);
 	counters_enabled = !!mnl_attr_get_u8(nla_table[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED]);
 
-	resource_valid = nla_table[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID] &&
-			 ctx->resources;
+	resource_valid = !!nla_table[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID];
 	if (resource_valid) {
 		table->resource_id = mnl_attr_get_u64(nla_table[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID]);
 		table->resource_valid = true;
@@ -8104,7 +8103,7 @@ static int dpipe_table_show(struct dpipe_ctx *ctx, struct nlattr *nl)
 	print_uint(PRINT_ANY, "size", " size %u", size);
 	print_bool(PRINT_ANY, "counters_enabled", " counters_enabled %s", counters_enabled);
 
-	if (resource_valid) {
+	if (resource_valid && ctx->resources) {
 		resource_units = mnl_attr_get_u32(nla_table[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_UNITS]);
 		resource_path_print(ctx->dl, ctx->resources,
 				    table->resource_id);
-- 
2.52.0


