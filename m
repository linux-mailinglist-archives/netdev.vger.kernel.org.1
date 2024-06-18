Return-Path: <netdev+bounces-104360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B297F90C43E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11081F22817
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5513113AD29;
	Tue, 18 Jun 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="esqGbWnG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDCD13AD05
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693776; cv=fail; b=UQOK5BRJIWhkLaLTJHqF6AUJhxpBBhUbop5aStZtqspVayf8dmT+20LiJbTlZJx++JaW5J/PjQ6ecm0BVH/2mzeyI0VhhS35LLr2AuwYxm9op2aK187q6Cv5Z49heUgqr+bf6kFZvxnxhmZ/6FyY2jXgX16VD2d37TmHf96tknU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693776; c=relaxed/simple;
	bh=CFGs/oKERsKf++CCDP+zsLvFB9RMZg8COtJNwnCMlFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=POcBD8fuv6AXeyt+UyyMdQHsTnS/enR1XAe0kI2PlvTKcdLpw4KxPnNW1uUofWCMZ8OOp+3b0GlpkpdBJ/hpV2IM4ttRSOViDufFEFxzY7HjnFeOvHwH8uYdsGLhd74cdGo8F2n8wGzbVsnKzHE1bnbzJITBvIbBTl9VYFFZ1fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=esqGbWnG; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1G97kjzzbosyeFFRXhNC9aCHPOw3emrElrEELaJnJ9xSIuVW/JI+pT0h3KjtJTXyHyIRCMbQVWY2zpWVbgZ4qlTpbn6GwQs7FXxFgPRrJZsfKcVS98N0iUwXdUXPHEmI3KxIphBxsnbpnc+bB5SnvsBnh9c9OMooEwRFhOgYa9nOpwbQ/p9DeXWElAjckqeLjfKmNWz0W3b8jArDfXebb0cz2+c81RKttPEaGClWst/TYBUfx/lTftQsUL572GkE93E9IvhBpd9/GD1kv9jVmjXx4HcsMeC0gi//32eOYOPjXWBiPQFAbfTzAQBTynJNsdjh+emMa/qpji/nviUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BLI2qM++jZsoiOENEEcg9BWg4SN2La1WmSXhcHiFKw=;
 b=TFt1Tj0R4a+EtQj1yqArHu2QWur06NE4vrSLJWI5cYDXMkfhgR95yPiXGVjlA5sezxrsnyurPc0QBFcEOZgtBk5c1bYM0ZjLOyBDCGmxcZVAf+P6TlIL4YhlxOFP0BDjUPXwhLmy1qQSk5o8Yx+mwAiH+Q0zvAy82atlyOLRqQ6L/KRUO1qwvCJpVin5RzfjR/NV8ztcZFF+kjg9UK/0iUEZHESJePcMNCU5PTh+god/mJgMQ+3sgttoySTXvhePE++wAPmiKCkJiQanTYyc04Ue52cPeFwmWPcWMUMaWn6BuLfkXhcFbh5lPKtyAA9IdB2z2kBjuyC7KXAMbBkLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BLI2qM++jZsoiOENEEcg9BWg4SN2La1WmSXhcHiFKw=;
 b=esqGbWnGbtlM+y9hXNt8h7Ox7LNKZybYH3VL5L3dneTo+NU4BdD+e7XT3hbq+BDG6vgNFPzIZZA8cnGZke3LbEAeaWTvFr3R/FpJ8hyWbankpIHvcnAKVHOA/bx9X/UxSr8fGtPCQDvlMQC6h2hpnb9yPZAakQBZgcEzDr8U/EMIWF08MWHaBjJY2kmGVhAzKhRpINXzgvmJxmtM6T1nbjqD3u77kE6cysCUkrKb9ed/k66BmntA6nxURs8rY/kyb0QWUlS9mCCspCN7G7fVjwcpATtNnfjwk8d/6fdSFBwxU6nGk5BsBA6P/Ldl8v2Dw06Jm0g1MGFdYA7CHKpxhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 06:56:08 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 06:56:08 +0000
Date: Tue, 18 Jun 2024 09:55:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, mlxsw@nvidia.com,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vadim Pasternak <vadimp@nvidia.com>
Subject: Re: [PATCH net 2/3] mlxsw: core_thermal: Fix driver initialization
 failure
Message-ID: <ZnEvdxPSQFSq8mDZ@shredder.mtl.com>
References: <cover.1718641468.git.petrm@nvidia.com>
 <daab03a50e29278ae1e19a00a23b4f73a9124883.1718641468.git.petrm@nvidia.com>
 <d3c8f29c-22ca-4ece-8beb-ed14587bcaf0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3c8f29c-22ca-4ece-8beb-ed14587bcaf0@intel.com>
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e4183c-b799-471d-c552-08dc8f63badc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJVVmQwG0a+Oe1SnvPARLV3EjsMjkt1r6SL9aTP7ZrwC0cKwJfii+eGC34IX?=
 =?us-ascii?Q?qeyBlukbKHjYGNWaNaoCu7ykpdH9XoWkDfjGqjxTCthHnP/+fn2YIRSzug+N?=
 =?us-ascii?Q?BTvX6jMASM5Bl1Q8nAcCJrfTRa6CvHpPgqGXV5Z/FmlRIWQPDtDt0AGLNeo4?=
 =?us-ascii?Q?UDusVodcD5WiIkGpRsTqi0zP+7F3ppn+HU+WRylrxoggeVz8a2ZJJ/0NLVa+?=
 =?us-ascii?Q?AHsEzvrKRJpfTsRWSRMAquGnHiB9rOcoHZc6bD3SrXegg1LTZSATyndfSw8J?=
 =?us-ascii?Q?ZX/TFiTR5CR38hFZ+TWF4yU7PXBq+mzs6vOc7k+08uAwo8FsFu6a6pPnbZ4R?=
 =?us-ascii?Q?RNL2RlyWSMX1Zv0CZ4lAZ2SwGQMElMvWoPid+oZ3WHXCRUYtJu5RokILSy27?=
 =?us-ascii?Q?PZnaimaeB1P4LDESm4mq3TnEcLdBSKHUtyICQjYghBgW/vJ2Mq62dwbSm3LQ?=
 =?us-ascii?Q?U3x9tOkGoPwuE3DPQLEsts8Z4XVIQeRItubR8TLGi7eaaIvLPc/vbKVF4+Vz?=
 =?us-ascii?Q?QuPizmHrDW63GzIb5WxEKFDqyFnqE3ju0VSe72F7MaKDHGkVAsyNcXh6rP/p?=
 =?us-ascii?Q?RoV+U1WhzHV7i9HwaK3Wy7vjmZxNvGdLnDLhUCE+I6v/XhrhAG4Mt3IfUOeB?=
 =?us-ascii?Q?2bJ2w7QJA0/BBAZWFR+N5Kl3BWt+I7JxRoJ0PsfXCs7e48S9rxT9AsWaEkso?=
 =?us-ascii?Q?l1YLAY2cfsY0e7+B4xWf1coAhT8KrcOX+VOW94j2nUeWsdEqRDLr53npnEkA?=
 =?us-ascii?Q?0AvloB42h4TVi1XyF9vlPgHHSNJcKHul7D+XnDZlG57+IeN8YLDZTzvYJHT9?=
 =?us-ascii?Q?ro3LikK5t3aqzJvp2SQZhfp2ve7i5roFiWBVLsGSZNZKrQItyaP+ZFFhne0E?=
 =?us-ascii?Q?u001LMq1M/S8j275S5zNiVvH+3DwmuX2KCn0VkakICM7qg5J6o4DXk22Y6Qy?=
 =?us-ascii?Q?ixAF4RGKb4Yn4I5fiHCZpO9zo6R39genkQlg1xe6wcuDV56ppvq/E4Td7wyq?=
 =?us-ascii?Q?izYpVq8RAISkBTcRpoIDDKv5y71abuKPRWrPyQhE+205vYIHooLZuA5J0bGy?=
 =?us-ascii?Q?SXyjQRAFVPzC2WW/48turCYOU/zppWjMKXmuOtkJU/ekUCWTrx4j7HK8b7v2?=
 =?us-ascii?Q?pJd4AmuiBKNfA5FCyqQ1qzTectQegL5aJZvZtQuU/yriWOIN3RfYvpMv8SNF?=
 =?us-ascii?Q?RMH0ESGw1FGw3qM6kOS7V1tYcnnTt5TMSMHey51aAAT3BVia1TPEsKZbnK/b?=
 =?us-ascii?Q?8qquqjUDrGS2IXm2rjBv9IuSVIiP+pR7JkmaF3xav/czBddmmT6SaluBLcov?=
 =?us-ascii?Q?+N+cFNHxVeuyqnNosBzeIBUM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMnl/55d8bc0qXMIW8+OGcrnkJYqjibj3owxjwPs5YlMM5qjMPzXm1ZCwHOO?=
 =?us-ascii?Q?SjDbuWgLdKZ1J7izguTMHPmznUqluzXiBUe2eIpZ2JQdDYjrV+laM0xdIw9F?=
 =?us-ascii?Q?qQMS4WL+wPICjtzJDpki4gxndr6z2TYUS77kCd+oNnyzcnfzgf1bActYF2dz?=
 =?us-ascii?Q?wxfWX3z+lTJIJzS2XVcWI19o6t+QMtbnDzyYU/Q0DCu/XXuZ47K1Xv20kmqS?=
 =?us-ascii?Q?GefJtmkY5mKkcq2EHryR+A7LLVjpf8+by1FE+1GGMbKra7feuHLGO4pE5T4y?=
 =?us-ascii?Q?BBw2OlH6NcyNCrqHgJD0V9hNa2IpzeFjHvapvLCLAoUinWJstVdMV2whFW6t?=
 =?us-ascii?Q?U11UG5PDiKO+umQo6qOmvaBXnhLvvgBTykPTWJIV/8jsP/xB3unpCtuQzfyG?=
 =?us-ascii?Q?r/r/O2nbIU9ZbIVuCgOktxJ6MaaTxHz1V6FfB0NF45hoVVqCzQYcfnkkeU+n?=
 =?us-ascii?Q?fFP25pV0ySeWIDr9fBMWkY394XfwcCiURZR5BHhATJQV5jn7xIrDK/BPPc9p?=
 =?us-ascii?Q?CFGr6wJn8drr4Ae64PG4rXPv34TmMNhmygFZClxEd+qyTix5WsiHRSIWx7hM?=
 =?us-ascii?Q?OqshdcweVkduT7WWj2u4SaNvGV9UF7wWnuS9ygsEo63ebIpkqu9wP/fBB4lD?=
 =?us-ascii?Q?C33a3+kcchJl0bxyKabnIodizwPLQijmIKhQ5fBFCBu+HO1+sIgCAgn3v9pk?=
 =?us-ascii?Q?6TkNyxyY312S9SexN0nJ+PBjBRnRxweioI/6s0KdmczEqNo2DZO5U319mKML?=
 =?us-ascii?Q?jk9I5mIXCRzGDWMPEJHQ8csgy42HEvBkZyhvOE2sfZ4ZvIH5wR4XCCOJXbsP?=
 =?us-ascii?Q?vVJi6AJSfCPmtjhkqQEm+HvowOgM5CaqIwo9nfceoVol+pZRqf1BMYdRUQL5?=
 =?us-ascii?Q?KU3Hafp9/w3hNRP5BlZDkIcT8MSoRt35Yj1S+rx0hcJQWWzZj1d0iDIG1316?=
 =?us-ascii?Q?2b5ThI+G46XFgiKPb00KXVJHLgPrvwnCyCLHGuvXUEGWNLE6dvy+nFJrsRhy?=
 =?us-ascii?Q?8np1LJMUhajZh040f3cKeOnXv/JijDBfRX93ZePXcJvvb9p3c5n+IcoMNg9T?=
 =?us-ascii?Q?/OQKOonnfCn6lmdBhiFnaM5G2RwuqGwifVu9lFktkCQu9je0MpJxLK9GRmnF?=
 =?us-ascii?Q?qKXYFd7913MvYc3CTwUug1zME1PylYMSMA13j1DaKMR1Zq++zbsvtk05zlYX?=
 =?us-ascii?Q?Qfe9R0AfMMY3DKVQIWp5ZuSZ4+VKSYfZ0RFXd/sTPrRIgrtU8PYM0xIQwFNb?=
 =?us-ascii?Q?lpsUtQWaaoEDkkkfEjgSqd0ItbsZp604bU3Wjs5g2Y8bBWVcmSKYcSOOHFIx?=
 =?us-ascii?Q?J1w1vs5htI0yixaxJFe5V43xFMbC8+wO3Z8IDj9gRV5pdw0HX3GrrDi0W2pV?=
 =?us-ascii?Q?Iww42N1qjqrnTqltehQzGho34+UNxNqttrQL3dT+SgjLq1UGAC995YaoDENy?=
 =?us-ascii?Q?MDH6MaQif6kCfgvnJjEwZmyZHl6p2/uIlMO7cQO/ii3G4BgvvV1UfvqnX8he?=
 =?us-ascii?Q?rym05UnmlxO5H/go/zIfB9u71jltIo5oQm43IB/vEIu4QZNG/cdXmsSkCeh8?=
 =?us-ascii?Q?2q5TFCk9VR602HZr4Datn1hbw8PJDjq8JSJtxcJX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e4183c-b799-471d-c552-08dc8f63badc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:56:08.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaShjEB3l1r1HUQTnB5eTYU56wolfiDODzyCa1CLxZejYBLFFOH9YQ5GGc7Wy5tVHNDHeYEeCh+yan5ABgx/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

On Mon, Jun 17, 2024 at 09:53:59PM +0200, Wysocki, Rafael J wrote:
> On 6/17/2024 6:56 PM, Petr Machata wrote:
> > From: Ido Schimmel <idosch@nvidia.com>
> > 
> > Commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to
> > thermal_debug_cdev_add()") changed the thermal core to read the current
> > state of the cooling device as part of the cooling device's
> > registration. This is incompatible with the current implementation of
> > the cooling device operations in mlxsw, leading to initialization
> > failure with errors such as:
> > 
> > mlxsw_spectrum 0000:01:00.0: Failed to register cooling device
> > mlxsw_spectrum 0000:01:00.0: cannot register bus device
> 
> Is this still a problem after
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=thermal&id=1af89dedc8a58006d8e385b1e0d2cd24df8a3b69
> 
> which has been merged into 6.10-rc4?

No, cooling device registration does not fail after your patch.

However, I think it's still worth merging my patch since without it the
driver does not provide a valid initial state which should not happen.

Are you OK with us dropping this patch from v2 and targeting it instead
at net-next (with an updated commit message)?

Thanks

