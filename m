Return-Path: <netdev+bounces-153826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646999F9C94
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E3B169D23
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B70C22655D;
	Fri, 20 Dec 2024 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KAt0TQ0y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198322144B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732372; cv=fail; b=jDceUKdpfuidYlzObD4/m3FDJEf9SF0dgT1476xDdfLhxc3F9UqZ12epl+2ih1jQGavJf2JBcUw9JCwUFLiGgvJTiqKKn4avNQ5GS3wsQCYnwR06gK4hl/qfb59DT3tJKE72OkkJ/ynxC3g3Y2ryP0146hQrPOKNWRtIJ0jFv84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732372; c=relaxed/simple;
	bh=2IgCVYI63eJTZDx+r7YaPdsNbbEyihr0h1H8XqVFKgU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bCyblbzzDZMNGmlVhJkBH/QH3MHyRGWcytZ6h7Bw5qAcEshHk6UFMqTi+m/2e/oDK7N9M9ePE4b/ugvthdV5kwPtLdJexAFzWBratQdQE0uBs42nDLts7VD6AUejwpF3wVtbRj8yJKxladWFScuEXDu9ZSVJEtiekfE+w6/Jcz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KAt0TQ0y; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AN7OozU/zrJsFdqSunqtNy1JFa0pmHEg1pyZ10xTUaFpV64Z9zG0IXWpu+63Cl79CVG/SxpfG6N8dGQaMeq4c8TCb/n77YTgYuGkGEkYAxkUFP0XECGOnPbYhyEj2fLpSxkNXMlGoztJDpvt/9u41AY/yAK7x7dRFjxmOdbCZ8Xq8clD4/r0sQgBu08EWXSkpNLMyNWBfAznR6mzqmExRP9eMVL8A52GS6kJAelLe7TEXT6lZLBsyf47V0MU4QDzA+NJFX+c1MOyHEjTuTQxkPTk/HsHCOub3UmosD81txg+p0VC0wQiYnYIwVqT+14wG9WGlIJbcJDdpsW/EfPCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SIe2shUR0AkEwe3dEOp1/EdVfa6BCxPePY6hrl7qBM=;
 b=y+j/9mR8SpuvgS7SFSEi+M7rihepcOVKKl4BhBUcPVnq5ahrX2ZSi+cz19P5SsqoLqBXtKj0WWkq9d1ew2vIOf2EtowF92y5ql8h+kpdtxHtuCGUWYWQY+MUKRW2VhIvkcxeSkfORkTxZ1klFpFnwLQ8VQ7zXKA7ZRNooTRmkEL/CqLCR1NZGYsnk4F88ptdCIzOpei7Wr5eKSdRq3rbCZZz4bjpOG2W+0UV2A/2qL6AtK8GdYmbe31SKc1PCB1dsP17bLFpol06yDO+wpNPRPO2Xt8OsMnnQr6lpvkA6abNczJhyzJhtqGdZsYAtCvmJM2Hgcy1rZfAC44hptz4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SIe2shUR0AkEwe3dEOp1/EdVfa6BCxPePY6hrl7qBM=;
 b=KAt0TQ0ywv99CBQyH4TFCvJJx0Nt4Y1uR7DGuEGzoFqaHmE8bja72zyBeQEGiUWO40La2QfPpFcU1LtycKCKiIOHd3RNE28b0jQcCue4lW16v228HAGRMDqFrCg6wkKRwXS/rIAr5d5Dc+qMZEYxYVJN6MJqPWm9GY8Eh+AMieHH1He0KDCBFVdls3BjFN0bD7g59IS9LiL17iLYYdhXOb6gHuMe61cgjVU5f1GmZseFACA2q4D/UT0v4grMMsttGawrY8ox4o87t7wftw/YYEt9b1MK/MpukBJ6Rsas5G/CelZvDieWvSTLGVFBpNou5HoUdoDxU50vqJtX80JSbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 22:06:07 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 22:06:06 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	nmiyar@nvidia.com
Subject: [PATCH net-next 0/2] bridge: multicast: per vlan query improvement when port or vlan state changes 
Date: Fri, 20 Dec 2024 14:06:02 -0800
Message-Id: <20241220220604.1430728-1-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To CH2PR12MB4858.namprd12.prod.outlook.com
 (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 767b3a09-54e9-4a66-65d1-08dd21428080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GPi0JGoe0QAsUWNiSHd6jaHZKBpwPh2zx7QLDKWJLJOY0oIEKtH73UFARByp?=
 =?us-ascii?Q?9VUn0q516qCkC5Tg4F5mCHAw4YE7YPQwF+w+ElemRaUv7AI5ebj5m2672ppm?=
 =?us-ascii?Q?R77Ip7yRGLIbd7Ifo/OP7ttUThcP1za1+RYexfc44A9KIY0nuiPMnWKZR/lC?=
 =?us-ascii?Q?AipvX1faQ84ubuaJlXzDKrAjsMRhG55wM7hD/NApSLdhzljLG1QIy1Bq2w2V?=
 =?us-ascii?Q?+9HkConOWtm79RwsbYCA59bSZ6HTjsoHlSkRAXjEV1DWzCrOkm+sCc8eUxQs?=
 =?us-ascii?Q?BKmoVQiVCITsg9DzpV/RtywVvrAekWyKjFUflL3UBgmO7aD1xPn7hvfO3HIx?=
 =?us-ascii?Q?bjyNs9UpmMYPwdel/P5vJkojMchAoqHDCFjPqEXaa13iiRHg7gW3QCHlClUa?=
 =?us-ascii?Q?DuP98rEKqqcwwZvn0SyglBNsMuSlinOyMzGmjBX4J7dIzNSoxCoQS6+vOvSW?=
 =?us-ascii?Q?ZdAAu4p5A/hqSXlrXDnsTNy+IXFypXY5v4sK6s8AGF5VoOnt0obScQGR6NJQ?=
 =?us-ascii?Q?94nuEfGRwENlcg3Xl6gM2d1gTeEzMsUypY3BxnVaJF4TmtFa2hla/rtwAJnm?=
 =?us-ascii?Q?JjqD6kSdKDjmn2roFPojt9WuKCtQSrdcD2axtaroqcT8cfCOrWvJaxqfIYdY?=
 =?us-ascii?Q?enqGurTCdVLZob0HwkYORmAMt+oh2gIKMWYceY66f0/FzNZmNaucyjuqZsY7?=
 =?us-ascii?Q?B6+WjFpHC9SrgKbv1kqugP7pH8OX5dhAgIOG/aUzo8qiW+YPts3KCFdOTftN?=
 =?us-ascii?Q?Wn8bNMDm4w24jPa/mGQRjkbdObGvjBDuHAV3X6hrc3WMvDzFMi3ziAeOThE6?=
 =?us-ascii?Q?Dj6q8E7It8ahKROF/OJpVwzPvwbHkbgHgnHimDt99K/n/OYej9scrYf8st6v?=
 =?us-ascii?Q?KttF0AuRJiaiqeD5nPvHfkzB05KoqAH0b+EwhvNWJ6XLYXslp57A6DAxQ1Tk?=
 =?us-ascii?Q?DOnU6lAlUpklcQHn6AOPGeVYlOslsmyZ0bFN86ilQpG5IPGS05xtqKH8kVZ3?=
 =?us-ascii?Q?S1l4XbDUK7j/j4GNjNJ+wUJ2nn/9NKZl72I4E8oYL+KS1azIUIYCnBO9Di1k?=
 =?us-ascii?Q?IB6U6DAPOD1fg1MQ8jRAZwnTQ/rnP4RmGpvTNDI0vNTpnLBSnQcBBT+E5oWU?=
 =?us-ascii?Q?YwD/vlL/jFoEjEiQccuOm7fjdfY9SFUFO/hUutAZ0bV+uyhCs6BdfPKEHu98?=
 =?us-ascii?Q?mckDtZKkgVmB2VxZBKLOCTBrpquuUPVO8gEh9bHxxsh/1yYhrDyzDyyd+ulN?=
 =?us-ascii?Q?Qptw0cUVBAA50gTU+98wWhOf3B5zjAdhdhYBjHrT/mNLvMPzKH//KMOtSr6M?=
 =?us-ascii?Q?xnGP80qkV/GqT14FSINwyGhhhhiLe7PuloyXw7TcpPUc7MIBD56G9bbpJLzJ?=
 =?us-ascii?Q?xkHMYPtV9DGJtS721r9fUxFD3VC8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d456GDIUycl3jTQqgpwd0VK7iNPnk8tuZXgXTusGFWi49Qlv5HRXkRVc5pPZ?=
 =?us-ascii?Q?Epwd8My2IsSRoCbsP0Oof/Bvss9uTKl+dfcTnZ4VZgVT2u1Kv8ZzMxIF/Pst?=
 =?us-ascii?Q?Rrp3R/aVFNvaTpEbUNdI4lLlcMRHfTALX/uwF6ok5dJtfpGAqm5YhPudBUsP?=
 =?us-ascii?Q?U/i5mj5W36c5nYe/mQzQ6UZzjPrzYjj8D7kqBztmpXpwsUlFGPVy+GmxqLyU?=
 =?us-ascii?Q?cdJ5gr/JgGb5xYUUBJ2KVoJSa6tJMVvHIta5J5b48tdSnU89vfd3KfJIThAE?=
 =?us-ascii?Q?vGi6nF3VR6QjIvQPOFBGs2kJ16+QK19e/lCyngfsyRvGpi9/x/7rMOHZYNW7?=
 =?us-ascii?Q?0hw/OcMuzf5uboqvtJmogg9U4ctpYdzi7Gu62Udg0SNFoor7mbpqeNMJ8s0U?=
 =?us-ascii?Q?4zBMODui94Z6VvcdmuNTqWmitvic4lP2vphgY2wtZ4fzM2+nQ5GkmtLPXTUH?=
 =?us-ascii?Q?8M4PoJ0PD160j0+5SOQbiRH0OeXe1cs+Flq0rTh/lfmzS9aKjH34IgPhbAOn?=
 =?us-ascii?Q?Wci8BsYHeFRKE4v/mO1T5wosvOhuBBtxk0VufQhmnE6XQ99v+wMYSgGoLgTZ?=
 =?us-ascii?Q?mFgrEzysPi0H/CyaHO/6bNjkVwCE7Q0qAjxIu0U3TwqFRJzxo8H14/ksubCb?=
 =?us-ascii?Q?BFzAuml/nmIJ7BjbAtuYgxsIrjvJ3t0ItWclB+Fb40Vwdt3jhDx/GPeQVcQ0?=
 =?us-ascii?Q?SYXZKM03Z23AOokU8/S5g6xjUS4kHXGah33wUnhDrsOeQoO+0zCIv2+pm8vH?=
 =?us-ascii?Q?Y172ySXoiEnnuPKmKescIE6L8doo1FCSJC5NBxnNjH4r/ftDpfCYCWx3g1f7?=
 =?us-ascii?Q?hS23BHB+XVMYtmM5yB4OBkh21jr/uy/Jd6HpIotLGJy1QJ9P4YrVz9f/gNVy?=
 =?us-ascii?Q?pUvQaCOmzcUc1ojQdeSd3k+5Huz+vu4pzUuM/H7JMFViH+6vS2NJsqyqzSFp?=
 =?us-ascii?Q?7gx4jf8/Y72gm0Bh19ygb/C340mPVcXvgzVEytWDYeXi04gwMIuzz9akbeOu?=
 =?us-ascii?Q?3ZlXvRU4nW5zbsu68uitXFDzBMMoU2UHsxCIq+Pp3v4oIltzxKBJYJOF9AK+?=
 =?us-ascii?Q?JXewZNHu7T1lZK8OU309smVmDqw7nPFePn5DHWe9hKZVU8NgtHZJFIFQjY9F?=
 =?us-ascii?Q?qk5faSKzBx01A8JOepQl4mjReljpA9j+yBFC9t5vEhJ5aFpG4UrnIAfya6hE?=
 =?us-ascii?Q?TG8ztzofkN8gVtWL8WBhK+kERLm6196b6G6eZX6Y/oRdtWhQ4W/yIz/TESeF?=
 =?us-ascii?Q?Bll+Zy7RRN7Rt18rSCkS0JBNSV0jeDqs4lgbPYCWkhgwz4QFWAOGWcfJOdW+?=
 =?us-ascii?Q?oTF4EoqZjQkViayDXh8Yz73MPzXNrUNqTXlLBh/BaUYjO9Ya/ZsVoZvc3cL2?=
 =?us-ascii?Q?o4qPJPjAhQQOpOqf7n0mBWMURV5vsqobvPhzthkRuQtCsm3c+260ERPlXwJX?=
 =?us-ascii?Q?FZs2C48brQ64m6ezU8IyvphwV9CMwYIp+YITTk1rY+whlzarrp+8azPMuKmv?=
 =?us-ascii?Q?hyk1dfLOfwJua0bltaIuxiRrN328DsqVKg5AnpTbGrspXFNt853gjZibtBAD?=
 =?us-ascii?Q?wS9MLokFhXfhXPZGO2sbw0a29CQFqp31RVFufscl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767b3a09-54e9-4a66-65d1-08dd21428080
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 22:06:06.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvvhmzfYjWA9vAXZu1omf/uhMShCVXeH8XwbOfPu7cMCS/37qAOJVazh6EZDY3OIveJ8Pu7/zY6BYFN9CUweXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

The current implementation of br_multicast_enable_port() only operates on
port's multicast context, which doesn't take into account in case of vlan
snooping, one downside is the port's igmp query timer will NOT resume when
port state gets changed from BR_STATE_BLOCKING to BR_STATE_FORWARDING etc.

Such code flow will briefly look like:
1.vlan snooping 
  --> br_multicast_port_query_expired with per vlan port_mcast_ctx
  --> port in BR_STATE_BLOCKING state --> then one-shot timer discontinued

The port state could be changed by STP daemon or kernel STP, taking mstpd
as example:

2.mstpd --> netlink_sendmsg --> br_setlink --> br_set_port_state with non 
  blocking states, i.e. BR_STATE_LEARNING or BR_STATE_FORWARDING
  --> br_port_state_selection --> br_multicast_enable_port
  --> enable multicast with port's multicast_ctx

Here for per vlan query, the port_mcast_ctx of each vlan should be used
instead of port's multicast_ctx. The first patch corrects such behavior.

Similarly, vlan state could also impact multicast behavior, the 2nd patch
adds function to update the corresponding multicast context when vlan state
changes.


Yong Wang (2):
  net: bridge: multicast: re-implement port multicast enable/disable
    functions
  net: bridge: multicast: update multicast contex when vlan state gets
    changed

 net/bridge/br_mst.c       |  4 +-
 net/bridge/br_multicast.c | 96 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_private.h   | 10 +++-
 3 files changed, 99 insertions(+), 11 deletions(-)


base-commit: 3272040790eb4b6cafe6c30ec05049e9599ec456
-- 
2.34.1


