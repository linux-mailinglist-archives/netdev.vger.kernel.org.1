Return-Path: <netdev+bounces-72994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA385A94F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91323281CD5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE64C405D3;
	Mon, 19 Feb 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+5z/tns"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9323B9
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361469; cv=fail; b=Sg42sPCy9h90d5uFyng974lM/pOZmcPRv/bevdTUnmot9ktwdaR5Qj6RxY5PnOW9ICwfPKbCYqMF+WW1Eg2JcFPafiAZZVA+NAVSW0kZBpROBEZJ+lWLppYfv7TPjkAPTmiwJQIR+23/1NzTXZ/+GwLn40GSvXNnmMZ7riYuA8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361469; c=relaxed/simple;
	bh=DdvHWyqNG2Xsp+VGSELoJurGRuG0r368KHP9tzrQAl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LNhCWQowO/XLAfIM+ZEa1rRWFIidY4ZSRmUbECG94GSIFhLzc6EgC1/avMkPwbcTdNYb7PiJTuXF9TIXUvHFiGS9dzE4t9os15+t8dDR7AsouzP6YSeFKJY6xNLShrUUyuWUr8kJixgb/UT325+bW/M8h4ztupNRq3AQqtTm9VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+5z/tns; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC8JG8uzBAT0CzsiRgR/Z1HR/ZOZwWWP8laIfgMp/LcsLAtVx/WiFAh6T3ZsOzPIos/skFjAPFhctlxWNm+3mkByfhYpv0istKXo+wjYFHHTXxrC4xs1JTEWSwmw8CjRpYp9xs5BKsghONTjJwbTxtJBrPWL5YRuowTCB9rfXZzo0G9bHPmPuYSeIjJbiEd9GTBkR8Ojuc67lRmggdk47T2h8/LHyqQn0qVV6KPup4uaROhX2i8EwV7A+Rx2k4N87yBhAJVJ8WfOA28P5+OqCHjaE21bvgi4sdFiXFPqn6l7Qw1yPxw8j0jaIcabytqjplcc6QxP8kJ/fZEUDKNJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJougZ7KBJhwz6x81/U9cpTIJQabAfs9iJrEFUlvOIs=;
 b=fIYQNmcgUKDfHcViOTjlcd4IYeyHSjCjpOnLP1/EADssvx413yLD5HOpv0khUjW3YZHWaK/8+xjUTPcTBu7e8hysoNytVCA4+rQ6bBI2DpZxLUdPDZQx0+2fesk96DjHNuIriNCSDw1G5u40q6dq4GKVCbMiNO4Ba30q+82VobddoUMP49HZ9Jnb7XGsNf9BVmre5SmHDpFCzGbuJc7fjtRsVqKBbEw+0L7/kf5g+8zVKMA7OkxF7swvWbfdb16gOy7jtjJQhI/lhO5HT1vg2rvbXTjRyB6dId9oyuMokr+jlKWxISeCsSdlhEp7dddboZAF0ckMvsFMHs7RRDi8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJougZ7KBJhwz6x81/U9cpTIJQabAfs9iJrEFUlvOIs=;
 b=G+5z/tnsPX9sBjP9ZnF4Ktq7ygXCXxVafdaGtgSl3rkhirRlK2X9CnOkidKrgq+bMFNnfNbkUswg+9jdLVU3wuzan5ljg7AjVpF3BhPfQOkMRQagmvLnC3wvaKddplwsPtUf/58xADiaVOM7DYmkz0HWCQ/APTfx1l3rdzxJSUvUEObx/kv9VCm3Sz1MXg0zKCHDK45qxoidv+lezj2hAVC6kdWydOK6LlULlxYi9AuOOZe38FZkh5Wwgew27yeM1NCwvsY16yFGkhlRRkIKlRxo5c8dxfte73MOL/j1dg7cUoGZwQHvDVYvjVAvj/P4XLen5r3UcnLgR/5ZR3TUBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 16:51:02 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::ed06:4cd7:5422:5724]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::ed06:4cd7:5422:5724%5]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 16:51:02 +0000
Date: Mon, 19 Feb 2024 18:50:58 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] gre_multipath_nh_res takes forever
Message-ID: <ZdOG8oxNu5gOImDd@shredder>
References: <20240215095005.7d680faa@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215095005.7d680faa@kernel.org>
X-ClientProxiedBy: LO2P265CA0497.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::22) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ca450e-b4e3-419a-26a3-08dc316af477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FXpaQfrsrqUZhw/ZLgE5hG83hwmXm4kWmbYw8rcmnG1eIFG4J8xY7n1eekSosqCq3oSijY414zekd4hOjsKPNoCW3MUkZE5LDcNxjjs+uJn4qVdqJ94J1zCFnQqJ9AhtqT85ahqanuZK9exANRD9Td4HiyDRzXqBMsJd26TUUybhLPJNWKNkC9npAwr3wNi1r1YbqHJVD2T77e27cDz53lAXT+kyrDkqu6pHlEuLGalx3fWn/yiC3RWKDDBI+7fepPTLvNrElmZ0oG8PU8d2cCwK3pUbxMhnfKESnrhnlaVEckODF94AK410Hgz8lqoHuop9fUiI6RYyrCjK7ugXG1Ljku8qZHVo6m92fs4cgE+M3h49IoimUh0zeIoO/OiuP4yCkREl9OZ7y2sUIWnBxdoN4KwTRjiWYk6jwBkuK5xVD1m6nY7JgC+jZW9VfwbI13OODxN1aJaPeZLM5lPP1rDppZvpKXM+xhUUwDvmgEDDYMQpRnqmFhS/XTn8V8NG+n4lazUhM/BNAJBY4J1Ii3pQS1Iu1cksTNu9yUD2P2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOfIFL5mxzMuQVoU1o8fH+Owndz8mAuICBsiV/z/4HIhtzW8KeVdSyX64lkO?=
 =?us-ascii?Q?uvzsmh9ntnA8pJm0zfJe0zHKmWy75DdWSkrxIzwi0WQ1F8L6xwTOrHHhFzqt?=
 =?us-ascii?Q?uU8BFFmmkrhNM87UXMMJEFwGMjpnyXQwuQxC57X+nBDFRxGRy//WrHqTr2/n?=
 =?us-ascii?Q?yT9Ofs/Vp2/1g8gdik9QtmM3szswms0rUQVv77Nj2g+Yxnilwkd3kmP7Y9To?=
 =?us-ascii?Q?aBM3gcZWASfs59de4Lz5/BySeayM33mX+j/biEMN+n9KeChQAppaUqP2Rn3J?=
 =?us-ascii?Q?LqoKCe1r//My0Rlf4pgVGRY95yLDlia0yxVVd8hBSVGB9d4KBL+imK1lW5/2?=
 =?us-ascii?Q?hkRHjSDxmvjFeV5NGLIyJX5JVBNqa2PJuPh47lKgwhlvysXU8xw+3voYtJcq?=
 =?us-ascii?Q?DXf6y8iOKKIj35+WNVbU2Eu/yHmb22JFGVMK1c7yRXTO7wI1BMQ0o2ZMacd3?=
 =?us-ascii?Q?zHzvMHeEzUnsV3fwKmiuhc5FiQHfpzxqNmBBCrJEI7jmFnQQgglDxu4BrtMZ?=
 =?us-ascii?Q?S8ehF5fJUaWyofLySMIc1kPg93K8U/fevBxHrHn4bRMQGCMDt+XsmTaJAFKl?=
 =?us-ascii?Q?NNeNl4HTDlohO8vxuc3sSOK9WHJZwE0a9TN2/v5JKJeifSZoCPBzSSj0eyeR?=
 =?us-ascii?Q?NfaNGzRlTwaNZPkNTbqFw0pqNOoSqWCf2BQgVB51/GKvkGrBvn3QshobdtPg?=
 =?us-ascii?Q?4HyAwLiGw1lE2ZM0gIVO7k8hHq4K2nerT7RVdNMpzrMOpT4dO3gJsL5nR/dH?=
 =?us-ascii?Q?jIw5WiPEgMuv5AbqI/uo080uQjVSK7DtO77NnF/9sSpLLdmBenSjutvDEzRh?=
 =?us-ascii?Q?8OSZ5BKz3Y9QB04BJIlXQ0Ul7nLkCi83G84uvel5o5tU7FMeUgLdwctDUNd8?=
 =?us-ascii?Q?taUSKwB7bU7umHP+PiMbTImynmglO7tDyTf/UavmL3yWJGGAvhvoytH/GA+s?=
 =?us-ascii?Q?urhDr+Wq+f8UJzQzFWQjZ4S6rGxWAqkX6Z2I0JpMmL7ZRmYrPbyZWQPYUIvs?=
 =?us-ascii?Q?qAv4AQiuY/YJHmNytpVD2Hm3lCxINWsSHU5JRW1/6uJkAClMsI5oV5dFriIm?=
 =?us-ascii?Q?plmdyIEY2TVQWZVo+2/Orl5pKEPoV+t0e4x75QKpzpucdqdLATxYO7O4vE8H?=
 =?us-ascii?Q?3PSoMAM8qqvQ8TYNryPJbGwA43XWuB4dS1kKcLxmkNX1LVaYx6jsh9lAS902?=
 =?us-ascii?Q?zaLxx7UDGDb4d0MWMEmlD9ZdWT2bao4mrZV5x/++CaveX9/0e4AJGy1waNEL?=
 =?us-ascii?Q?Cp83chKe0KRNWMgCk70Lsq+1iQQHCeYl4UocXhHKV+9isav7txMrgAFG6Y25?=
 =?us-ascii?Q?bTwwbvHEcY1texbyx3X6j23o/nN/CXhlG02u2MVrJxNlgCGjto0jzrYx5uSv?=
 =?us-ascii?Q?lz55fx5+KimwyALQSaq+8HLR1UU/4lO495HK7r1tos0oGM9Yzr1t7a1PS82G?=
 =?us-ascii?Q?JV5/DDgKc3/R6Fuxz2KF1PFAVxWiY7aNj5I9lBHEpIQdEzVcqEph7rEbVC3m?=
 =?us-ascii?Q?aVGX23T33nnVeuXWivRdQN5xhG3EdRKJRcqy9zGthe3Vf7YeBxEXOnsEDYzC?=
 =?us-ascii?Q?Td9nN9Mj7oHZD0uU69RSupGXUGfSU1Z3bdxbeCEt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ca450e-b4e3-419a-26a3-08dc316af477
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 16:51:01.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnbkgJ87OVaz9DlZ00mLeRpRzgiFFlWX84wU6f3XU2WbnrZVYFZtlGTPVTAEf34652EoWpnvlBLmpTcUI3BSGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152

Hi,

On Thu, Feb 15, 2024 at 09:50:05AM -0800, Jakub Kicinski wrote:
> Hi!
> 
> I bumped the timeouts for forwarding tests with kernel debug enabled
> yesterday, and gre_multipath_nh_res still doesn't finish even tho it
> runs for close to 3 hours. On a non-debug kernel it takes around 30min.
> 
> You probably have a better idea how to address this than me, but it
> seems to time out on the IPv6 tests - I wonder if using mausezahn 
> instead of ping for IPv6 would help a bit?

Converted from ping6 to mausezahn, but the test was still relatively
slow because of the 1msec delay we pass the mausezahn. After converting
to mausezahn and removing the delay the runtime dropped from ~350
seconds to ~15 seconds on my system.

I think I will parametrize the delay for platforms that might need it,
but default it to 0 as it's not needed with veth. The same change is
needed in other tests. Will submit it together with Petr's selftest
changes.

