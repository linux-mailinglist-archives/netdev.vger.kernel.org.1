Return-Path: <netdev+bounces-186036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8207CA9CD89
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19029C19BA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01128E5F2;
	Fri, 25 Apr 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iECMh2a/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FD13633F
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596055; cv=fail; b=lsjaPioRBOV4bMlpPsCcuHgJYtQZe0ZGNx0md8zvzAKsYlRQKzk6Xj2qVPqOGsiQNLn++pUqV0JVlFMSTXY4aT1q07Vmvlx/gsJsSH+9zZbuGzLsPVxg90p93oSj3TSHFA9foG6546oMCkt/Q/FnUfJ82nC9VBmB6jyFDeWpNQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596055; c=relaxed/simple;
	bh=BfAxo3efxyfGjTm+pe4h392LMCg0HShwAQoIE6QjA/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DuGonYcODCiM+V1BSwtFxrA3DcUWaQxQosYvQRM5CqUdBVI/RYuw04KDBcimgIke3NW2Myi2e881A4sLuzXnjMccGURdEeGhGsLGzE/Vy7Z+imiQKSRUp38l7ayrc/paw0wzYK0RK8bCEPz7iMCbnAbzjX5BH7TQQZGtnEWgqCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iECMh2a/; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKDadDi6BeLQMgA7UG70MoLBT+Qs6ihFJ8+FTo3b07X1yuCodm+DlNyKZPm/te61HLISwp+pBNgAoiqLx4mw6jjQy3LQmBQVDfuTMgvC7/EgsIs4FiTSK10La22R5sIhAS0Vm/QaooDWjB40bUtkuxGaaSQn+WjyZGqdq6LGptwq4TtSEanNxKP+xrK6M4FzrO/CxcoseWO5TZPdSLMSuzV64Raqm7Uuw0VlDiop8BEwC3jHU7BjycVAxC2XUsl6C17R8rRgjF/vpDafJLZVDGyyi3H9NEptaVHAODQFY3qyLWCY9/3Iz60b9svPw9MjC4p0KKWR2/dxfSO/1MIl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YFFBCTAbeWtlzKeFSmqhK8ZsE0yioMOn1VtVH5Fn8w=;
 b=Y9KWdaHC02qXIKkdrEojGy1tyI4n4TaTJG6RhSfU1y8XW5dpHZzrYEeUG/eXVldg9IPPv8tfjKzBFRwNtIqoH2rKH7a+GgiiGNykrPOB9wlNp6QNQz8MqGofI+OFUgfwshSOhZ40DlQi99VI0v9pudaJqITEWT6ecc7SzEP12HNDrj1B7bK3BjSnZHp0YzfIiYX2phpkAsX9ln+d+p7M4qKWk7dLf4ugRnjD0/k9qK9BawPcdDlidWLUB4c9fQ+Fpf6TQID44hux26+jgznsXbKBd5SswUD4HT7yKbVl1ULf5W5hYy7EzNiNmLujqVeoIgVOroN1TLJmaU84Wm2PpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YFFBCTAbeWtlzKeFSmqhK8ZsE0yioMOn1VtVH5Fn8w=;
 b=iECMh2a/BfqitMlMgNyGEY1cbMcFx4R7r74zjicVOk+F71SigPcvMlVU1wPSxQye5I3bpr4eRwbKytTafDG1ztatrR2zMe4SCNPGXXICHbezDEPCpsHwAFX/CamNWsOtKEmJa81EagXCl7WQEaTEmVcook3/eekyIaCCYMLZnM72fSDCL2TItMQjG43puBggtpeWOKxF1lkn7Ks/K+7y+oaq6zmmjLstOs2f0dP9RoxjPs34pbvl2GmguqsA3I1Zz9xdYJbpqXkwQc23ogtqIUImG8lSiKepStv6FgdW3ZGJU6etTUz6QghZF5SKh/9XCoThx9PWKReQtdW8fRg+Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 15:47:27 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 15:47:27 +0000
Date: Fri, 25 Apr 2025 18:47:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	horms@kernel.org, kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 3/3] selftests/net: test tcp connection load
 balancing
Message-ID: <aAuuhIYrLBNNhtJg@shredder>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
 <20250424143549.669426-4-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424143549.669426-4-willemdebruijn.kernel@gmail.com>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cf139e-d3c3-4eb0-b00a-08dd84107acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+YDfJnlP9jnAeebX5blYlFkH87eaw6orls3nsgDDEWYO5xR3CDCcCHN5PUZ?=
 =?us-ascii?Q?bQIvOeEtyd0tEVzSy/t3eF0v+jEJqn4zXd+ClucchM+1Byv4PzLyRRHlAhXf?=
 =?us-ascii?Q?GGynBTIvXkmYJF0pEq/PFeCMH8hH8GLX1G5u2NbdKMqCfnUeP1NveC1wYpOJ?=
 =?us-ascii?Q?CPaxIc78K4TY0241ICutuZfS7MVp+masH439A7E09scTUDXfF5Ctm5mhYfru?=
 =?us-ascii?Q?dQ7UPiPLnuhYomVMdqglvAmCKOGLHKCT9JqHiX6OO+z08/YECryIUSfVRUDW?=
 =?us-ascii?Q?N8/BhuoxuMXNY0ZtWZer4HZHQFgxe4iSFcboOQxgCMbmr0wMhldVO5TwgeSC?=
 =?us-ascii?Q?qOZpAB3tUdAs05tyWd/m8PWUpbQWhj4NE3XqblxFKyEiBrrTzQlzoJWPEBas?=
 =?us-ascii?Q?5JoEH27AjblEXplN3aqE24CHZB8YfPfvD6b5rndQgeucsykOjpNLk70F9QJY?=
 =?us-ascii?Q?OXcteWn34c0FyC6HOEckFEgBNNriI0nmTy/k0vjvOlMRR3OcFYZzi8nlbjgs?=
 =?us-ascii?Q?jJvvwoHZmuYDhPLnDvqwrRqG5ze8Kv3yPPqiNgmT4Es0PL4uY6qS/h5sWazt?=
 =?us-ascii?Q?6l2d9ylFb3hSFCOicVioRgaw/Dru09eVxdJcoWVbX/D6UMM04/tM2/ZWGIlR?=
 =?us-ascii?Q?ZUGjpbCQKaQNPTlJkbbwF4eYJinTg+TjRl35+0BHLbM9dgNv3wD0EjNy3nb8?=
 =?us-ascii?Q?/LnKgFHY0GFo8GQAb3BgiDZieFpV3dr//3Iy+rL1rsGwlyllYIv/bSdAeAnQ?=
 =?us-ascii?Q?YXz2C2B1VAxFiXH1sY8R+uNeVD3RuR74ZNDXuD0YVMl6TaM6sYGnU4YVP31U?=
 =?us-ascii?Q?97eaLhp4pgDyLJ6j58fJLxcwfe5DPzX0Qc9gxITHiNstECHWWa5wFhy+5TOw?=
 =?us-ascii?Q?z/F1gtdv2P4AnKK9UO0kou3or3vUCiRyWqOqi7Yj9ItdmAZUwjBuzAPEXl8z?=
 =?us-ascii?Q?g/bO0uIk8SmeNyTQa8fRuwWZTwTM/iR1OwzL4Zhlz79wqDi2XJwPl8SkAk1D?=
 =?us-ascii?Q?qKh/RCCCmS43P45VzZT1EyBCcoVzS/UIzeg/rj9JTfy4abolHjkLr04wLrT9?=
 =?us-ascii?Q?pCovkwEGBL631uON2TB1TB/TRAiTN1B3TBE6xwBZMOIb6XXsH9UpuL8hMcvy?=
 =?us-ascii?Q?8RPvu1jDSWXLUOiGkhWaRx+ceQD3kV8MxRPCSnNoTY5qEWRHIP1/OhqxP9Ja?=
 =?us-ascii?Q?TnrRWvwppqJy4Yecqw3OFK0Ye1RuV9OaapRRNtxdtZ/UVHskk4S3d9if0r20?=
 =?us-ascii?Q?pmrdjKaAv31xHlMUedZvM0Nw+SErkJZFL6+IbfjXHdRYJF33d0HAofD6b5ry?=
 =?us-ascii?Q?svx5w/BsaBX95U093e4mWdkk/V/lgr9PBfflLVJVrSYMVMkRd3FASjBU460n?=
 =?us-ascii?Q?mfQ2GqQx98GH0y+4IosnP6WtTae3Vg7z1zJXheokpt7wzDbnarZyHf5X0+L2?=
 =?us-ascii?Q?CNiH0i5yzJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dR8tBYUF/2DCWQfiLubMFveeLbaNEaLVPG/C0wOW7yJMOn7Kssv8Aq7RjXQC?=
 =?us-ascii?Q?lhwFMlzfs9hPffDyUqjsMZs8jL1wAfEHVdVZaIHjhx8TNg0tr+YrKD7wruY+?=
 =?us-ascii?Q?Aq7gBiWE0+518O19YJAzuL2doeoqJGV611Q9bbglTXQ5kCNo8ebEgeZdBvGC?=
 =?us-ascii?Q?vg0KqJ398kf0TiVlgM6QH2NtGq4NsC//t9a3lLE0JKfz66xXcTCvu62/u1dK?=
 =?us-ascii?Q?Gkg9kGrugqYJjJFRYtlGT0RNRtUgBEYu26EVlN7voul9I1W3pgRjI/NPve6x?=
 =?us-ascii?Q?dNWw3VfGEkn3aQ8cyHiOEUmR0KqMsOzTFFQxTMaSvs0xdpNUScIMDUx+waxI?=
 =?us-ascii?Q?4WaKMdGE6HxxigTwMVG+0M1OqOE8CmQ50Bxe774MUoYwSoISrsP69rELjvpI?=
 =?us-ascii?Q?WaSGJUhXs5CAqWvfhqo74SPD1GJJ5ZG8F/A4tclUaz40g+Dp85j4/Yoqhx4y?=
 =?us-ascii?Q?s4GsN615iZTQZS7ZVdKpfylN9CvXQSvlHmLtN0LmYudgm8KoK4SFYoSTWlYo?=
 =?us-ascii?Q?yEyvFQUZImNi9Xa9r+f3ui9sAstygvQkplfaqMCAGqC/Ss6DavbORRkpUMAX?=
 =?us-ascii?Q?PwpU73tpopZ2u3YfIyViD6qKIfczsrjPJN77CN2M2TgF9h4XESk8pz8LwQj5?=
 =?us-ascii?Q?fesG19M2C2I1bmUy414jYze47uevcTGn7vKna9MIq370Nt9F76BOPArOC29p?=
 =?us-ascii?Q?UaONcG7D5GSr7MncxwQjgujn5O5/r9krff9lF9CKY6tElimWSHdJY8YYpZEy?=
 =?us-ascii?Q?Pg61Ihmm+Aei6zsDwxvVE+bT3IqVuUmzu/9pwnBcQTqrIrv9/nbFUMVqQ2So?=
 =?us-ascii?Q?IrkGCLud1wLbfMii5C5PJgnu/nMj0kG+m4nWXVJqOPKCWJFXn8/Fz2hSGT7e?=
 =?us-ascii?Q?N72FD86NyeDTtuIMjyLYAhAkRSEEvGZp/IOzc9XL7MxnNyJdnpNSOklH6g3Y?=
 =?us-ascii?Q?3OrARBxH70fVWrE8mTTfeilfcYAGZuM1eu12clvpxmZhaBnT+KBUngxoaMN5?=
 =?us-ascii?Q?xFd7NV+78wWxWujb7/89ocyYcJ1V54jw3WgtnIQMtT0NiBgk+tO++VFA6E0S?=
 =?us-ascii?Q?z9tv6Ql3p8nAQ8y2tNoOB2JNEZMOOJHHzafV9J58MDGOSooNdWKMbJj1lgCh?=
 =?us-ascii?Q?GJC8px63y/jAiYbnlqZ3M6Cf6qi/Z6ZV2ow/ediXvnCpd2KN8uPvMiz3DvG4?=
 =?us-ascii?Q?yh2Zq0Aza4Zd2iRSQ7dnnLhz3W3NmtuPFoFLBCIn+URQHtcsLyyN8Br2LFGa?=
 =?us-ascii?Q?6W1LQ6FRGs6+VAtzAvjDB0S01zvClMN8eDM2/APTOjiDajQNRjB+tMJ7YviM?=
 =?us-ascii?Q?4GhbwxRepCBkYEo7F7M+O7qEyU8WQ0V4O8L5rW8hSI3ZxFPZzqWt8Y708cBv?=
 =?us-ascii?Q?C/Wj850a5S76F78iEo/GgWTR56lmVhOuMdWhKYIvbsa3dWE19wBi5tuUcW1c?=
 =?us-ascii?Q?lP0QyGpZ+LVF+7q1WH+t/mhNoFoT6SjkHPv+KxoSHAh4DU/r5fda65lI2UiG?=
 =?us-ascii?Q?trfVT7xscxndxR0qZedfVJWX0hSO3dYUAgMMKmYSPIaO7hb0wWF+9T8J9pyW?=
 =?us-ascii?Q?ByND/IyBJXoFB1OdK7U3CbvYshqff9dhNfC+jqw9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cf139e-d3c3-4eb0-b00a-08dd84107acb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:47:27.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y17o/6lLxwpvy5LfJfM4gm1vT6B1jh3yYtfIlZh3Ofs3a+uhwHVWipiyfCfovWKwCkA39U9xSVPwpHCsS6WKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

On Thu, Apr 24, 2025 at 10:35:20AM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Verify that TCP connections use both routes when connecting multiple
> times to a remote service over a two nexthop multipath route.
> 
> Use socat to create the connections. Use tc prio + tc filter to
> count routes taken, counting SYN packets across the two egress
> devices. Also verify that the saddr matches that of the device.
> 
> To avoid flaky tests when testing inherently randomized behavior,
> set a low bar and pass if even a single SYN is observed on each
> device.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

> 
> ---
> 
> v1->v2
>   - match also on saddr, not only SYN
>   - move from fib_nexthops.sh to fib_tests.sh
>       - move generic "count packets on dev" to lib.sh
>   - switch from netcat to socat, as different netcats go around

Thanks!

