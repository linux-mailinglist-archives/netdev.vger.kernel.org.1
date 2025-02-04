Return-Path: <netdev+bounces-162494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212AA270BE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1962A1610DD
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC820CCD7;
	Tue,  4 Feb 2025 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KsbDvY/L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1220B1EC
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670332; cv=fail; b=iUbTe4jth4ZTrUgfwJ8wqgJAAji7CaByixmZH0IT84fSjuXjANO8LwCzT7tpYLPYsQ1rd8om5BT5oO//LcSQ6U6FMztM7iGIU9ME//RLeW4D+9b2Dc+sVWhZy5W5cdcJ8A3dfcGz7MlABLQe9Us5aHvK0RCy2/+UpAgW1KFqmMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670332; c=relaxed/simple;
	bh=Il6JyZ/dTXB0/pqEuslX4hltgbqUZaxsTAWOjp2fxqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJKGxh8tfGrY0HF/w02xzGsKhOYEaj2jIfgDNiqb61cHTiuyGq8BmuTXOh/fao0G+3DYa4PzkthpMnQ1H+zdY6L4Vx1/E/MSkYnSMeSzpuPqbtnaryDTg6pjAIX/Pphnh0vkfLLkMQi4zwkRG2QvHMWS7Ig64ULm9gyVJPF90fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KsbDvY/L; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHsY4lOzlsRk8an6/vyO+VDjDTVX9YqZdZiK3j3IbL6DlFz3Y7HXntjhe1+Q3gYkkFOTHoI3TkHfnXXvp72uXbAoLKQmT0VSQLdQeMpP6IC9D1q9285cd3PuMQRJ+9Vs5eKATiMabQUCZClNYRef8PYnP7/SrjcmbDIMt0MCGYHLIisIL67AyhstrU29Xk/F69GuD/j2vYrSyVO8fdy7uMsho9/sIxVE0XzQEIGNfNjMOD7YH+pnUXv+pvzh56WsH+5JbS3Cz1oM6ttmn74CmoesHWltG7gNL72Vuc7qXXVR4WrRbQHhhOhqT2YK6EvO2qrCZqK4M1WdMlFhZg2pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFwHjCQmbQk6l9DnEz2RwrEtjUJhX76YsWpP1/m+ODY=;
 b=LqbXsvPepXQx0gvPF7jtmT8RRIVjZSgFwB1ihrM9qJR+M7n0HMLZHrBjcrC3dg4Fqh/B3RarxuU8sjtqZ0pPV5NOhPqgBs2ptzJhuxeu2Az1gls9h7ylgWZkYrwufq2HgSRifnTrq1oGGxSeRMxYmFKwigPpSLiCjwfNgXZLmb+1X9CSAyU7ChWc7RHKTVcoL1AcMzw8rS+u05lrj+Hq1ejgtCRcvlxnXsFLfU51TUEAv3wtP7fceTm5YiV1g8/QE5wNFhLZda6cCMQFGQK6jRMWCYw42csJVAHNCzDqGX/gcbwVrzthuU671IglpJDItEcczteBSAQR6dtElvy2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFwHjCQmbQk6l9DnEz2RwrEtjUJhX76YsWpP1/m+ODY=;
 b=KsbDvY/LMTEuebAyfitvAUPLnhvPmt5EMn72VEbbKzA1yb+KDtoY3wM8NycGjVn9PdjyuIOFNyR59TK4S+tZmLElTovwZJlV+tm3vfWROzdYt5vyc1uSVhpPGNozGqDXlRKtJc2BObGTDCImBOahHwdEHAEudIeRMPF+10PDFjiu22uG0VoThMaPwhre87rf8mCMIhXj19Q9rut1bq5mMVFjRUzmjGprR0wI7/T9ue+lVOvLjqRPohCfB12GAS3m5xmHRbwoNVLEvhdFQq9hu5/j4RdwCzF5tuJmfy08gc7u6ElItk5Ki4/1qu6RdOXmpDnpz4Q/z52Kw7ZbEtdNVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 11:58:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8398.020; Tue, 4 Feb 2025
 11:58:48 +0000
Date: Tue, 4 Feb 2025 13:58:35 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yong Wang <yongwang@nvidia.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Nikhil Dhar <ndhar@nvidia.com>
Subject: Re: netdev: operstate UNKNOWN for loopback and other devices?
Message-ID: <Z6IA60rfe1oNxlYz@shredder>
References: <FF839E2F-B2FB-4FBB-850C-CDB62AD0D05E@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF839E2F-B2FB-4FBB-850C-CDB62AD0D05E@nvidia.com>
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1be188-cb03-44af-0400-08dd4513486f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uwnUxbMOPkpAEYznuwTMXP1SwEU9KOlo3uQAI0QV8OyfbbgS56wJObKnmY6?=
 =?us-ascii?Q?bAxIkapRYwdmDJAs+SK/tCX8CHN+vuk2Wj/XrMj5iLeh8N4Q1dKiTcx2wMpG?=
 =?us-ascii?Q?a/svXrixIch81sAFKes+naVRLIJh85zpFz/Neo9AzXGYDa428gj92c+5vjJZ?=
 =?us-ascii?Q?kCHEPdgz292UpBfiXzGAc8CkTfLha/2pVrZKYIUmppbJLUMyXIx595AEj4Lv?=
 =?us-ascii?Q?H+bnxLhV9YX7Jd3WQ+dizfqor1AjnoOyY088hTTT88EUb/IOfySy37AFmAjX?=
 =?us-ascii?Q?ERPhzwb707/da4QwvsuQydFto5QinFrm8k1yHueCvng1bk12k9z2BJYxRpE4?=
 =?us-ascii?Q?czOSLhMWN+gplSLXursUWOrzZ4pN2kLlT00nQQxj3pOiRdJp5GbnFLbdrrCd?=
 =?us-ascii?Q?JJME6v/6kD5cbvt1f2d8n8Z/UCk/QPly3vRAH/QBb0et6mp5PRFPqKGqEK2X?=
 =?us-ascii?Q?byJk4zkVysQbFU/aeayVVsfy8IfhTC9Wq9Zp/kGkzdM7/MuQBlNksAqYqkAR?=
 =?us-ascii?Q?vz9UwAS7VxgblMz9utMvBNMLyGFT7KD409QnZs31CIfYy4vpsddw5jjvcrBq?=
 =?us-ascii?Q?saC57esBPVDcpjNqYCb8b5k0ST8v7wytFvDY/bTHwEDV6lArezHQ3d8Ys/FU?=
 =?us-ascii?Q?ty9UveKLAaiP7W3ZLCEWCF8/tULAjAJAWfHf/L8pvZWWgmvoSrZAXs3N9ooc?=
 =?us-ascii?Q?EKAZPe7irCyVABGAAZ4FUZ0P64UCj5TuexA9K4HVO6Wi5TEeX5oOqoVScK7w?=
 =?us-ascii?Q?fcyI5m7Q4ZQTm2RHjE6kmua543eoFXyz/1Tnjn0MghlLWV1VjcWDkpxR+B6u?=
 =?us-ascii?Q?55tqZLQDE9wQsp/qFoi/dylw3uqgWsI9Utn7OGelrO8wogZmTA61XEbkhAyR?=
 =?us-ascii?Q?OKi1kSdNp3ih2FT8Z6UfulQ6Q3ONzbV8d2vkH44cS0kkXGZ4Y3fPX4t0Ka3H?=
 =?us-ascii?Q?VsTCCos7g7n4bL66oo9bhRVKlSo+vXYG2s98U5ZTqYwpXFYoFb1CZ/TzbcWX?=
 =?us-ascii?Q?4lkC4QhkCLSXn9DAJrEifLZrnpu6tYWQxQpZoZnEaNNiZs3MHG6a+fj5Fd2H?=
 =?us-ascii?Q?sRdrfs81DI99FAlsE2uZLNPNpFtuNlAr71YBxg+ZkRlWbN1igBOSLUmGQHt8?=
 =?us-ascii?Q?nZubJgo9kT98ZYuuIidvJYe6INGcaDcPCrkKr2VvDvNNpBt34VHJLUt3n3WS?=
 =?us-ascii?Q?CbOORVLDh5wMEywLt54chJ27kafn3hrDNfuePB/ekUVHf2SDhzxONrQfNRvd?=
 =?us-ascii?Q?e+nhJwuJS37F4a9Z+bsOb1RHGg1k/ixwqhrrgRVZ9LNQoF4rdDWs9qxH6EKm?=
 =?us-ascii?Q?eXyPlgHq58CKNf4vp61/bNo3fjHXCO7LVqEseWnV5L4806ZQ/i074hV5/k0E?=
 =?us-ascii?Q?NWGAmOHHBbzG6fsTPH8hAgWQZWl0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tLdAKHqYr9HegDKQdNloxHGBFi+FDGLL2GD9Ts6ZGjC/S4yTfnsSul+6cg2f?=
 =?us-ascii?Q?ncIyTpdSmAOkd1GEDfng57HpkJkxcuipJ71VNWBY0qSluXLg7e7iP7whVCfj?=
 =?us-ascii?Q?5CDOjwdj3LRj744tAy8eT0f7d5L3KcZQf/I3YmMsr/tVfsqBezyntgH6unmJ?=
 =?us-ascii?Q?fyFcIOgA8+5qT9Oi73PQ3XCIFVLv5hJbu41ajWUP+krU91Mz1iOB4Tse2V44?=
 =?us-ascii?Q?DzQ7XUcrJ8/f21j0fxe9LdmWBXhmZEbSDkH+FmCD1eBvoe2jKrmBXwVoEKfA?=
 =?us-ascii?Q?9g8BriIGXg+uu776hbD4W3QkoHddQHjudbcl3b8Hvn48NcfK12Yy7n2kfkLn?=
 =?us-ascii?Q?HIIzs1wg8t6fpeyQW4kfGFzysLIst7t+9vzcuAcGfMXUCrOXodQD6lodf7aM?=
 =?us-ascii?Q?cy2YcxZBbV/H3i2nU6G3w6fdGoPKN+N5DRKRx8m3mXkvB7FIGtM3St/Rx1Kw?=
 =?us-ascii?Q?iAsKMVt5zW+t2amV305oKwRBCXASi6qVSgIeKqKcuPbx1aE61XHDdFUQmlYk?=
 =?us-ascii?Q?MSIl8rv01GlByDYkCFQLWc1U9yakVFb1kcDt9V6sVSdnIXuo5XDIUCUPOMFE?=
 =?us-ascii?Q?M7utD2fvbaeVk3aM2Rj8DK+YufKdkCdfQUl0kgOTxnh/GM4iQ+4yf9BTiKRy?=
 =?us-ascii?Q?c69Ym0cpka6Fa9X+9jTrUNAAwg9dko02qSx0jJVdxMzB3BWko+7lg7+S83Lg?=
 =?us-ascii?Q?BiMcT5q8Har8rYdki5p6UA7tmZtUxT2ZMG8DhfC8z92kAdxx2udGo1QFKze6?=
 =?us-ascii?Q?zygxuj063k82Qtc0qiG2nCx8M2uDUljtmMetZwDRejCaQeWg87Rk+TEaY1Vp?=
 =?us-ascii?Q?jFsQ+vVIn6inZ5J/yUOKzSP1qtQkEP8veDQ8MdRGYGmwIILQK26fueHyoqaA?=
 =?us-ascii?Q?CkWmgzTWxc0qjy6z03vizpFqH3lwqZi/vi6q9ztxoYlQVmNISpKFYTTCll/N?=
 =?us-ascii?Q?nOngxeEepWgO9PXuyEoxaagG6xMt4zosHLWAhf9wHWX1UIrRrQIPmbM01/HZ?=
 =?us-ascii?Q?57MaDNA9ZDy4wWEUk5QNCezMD6HcXDUfwTqjvBRI5pZuIYYW2B1Q7P+McUP8?=
 =?us-ascii?Q?+bEBnOj23Yp1JW3Nj4YQq4U083Hg/3fbcbW2VwRumVKNg+p893EH/3wyEr0J?=
 =?us-ascii?Q?qryCfXbTwm45GUztR1xUJlASwemYontafKHyh2A2hnc1+Xs8bzfXthnw1y7n?=
 =?us-ascii?Q?LIjpzGCc3azmR5hF/Rbb10g0zfBJMqwkF05EGsp0UnzflsjBGJ2VHBwo31b9?=
 =?us-ascii?Q?l1Ctt0Qvo2/AXKjuKldqF1AwuBTOvL9Rj9rPA6+0/TAsRr88biQvsv69uibr?=
 =?us-ascii?Q?N68lYSnkAxNPnGzTqXtip9iCxdXyrzsPQlNlksdknMzjA1uhs/urutS7lpiz?=
 =?us-ascii?Q?orVTawtR0Zs9v/NNyyfFRNsvil5h/6ULcXCCsRybtBBE+Fg/lZiUdEsdwM6f?=
 =?us-ascii?Q?UOwmVikegY3cltuL0Zw1BcFSP0GsX2U1EKLq5hz87cem2M1zedCCKKJOz62V?=
 =?us-ascii?Q?3g3TyWs7mUI2BEi8az4TgeyngRoQLZP+lN35Uo+EDY2zySx1n6XwZzfisGy1?=
 =?us-ascii?Q?gzNh9Tf0lqhSnx5gP2gs6Xo2Zqaq494RFjfb1NHa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1be188-cb03-44af-0400-08dd4513486f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:58:48.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dOX9XdF/2bgLjnUlfkKCujQ7nlCWhPaLveprNTCnTZ6TLI8I9GE8wxgn4tkhGTmakp8LWrXLFpsbT0s0Ux7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418

On Mon, Feb 03, 2025 at 09:17:08PM +0200, Yong Wang wrote:
> 
> On Wed, 20 Nov 2024 09:08:32 -0800
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> 
> >On Tue, 19 Nov 2024 19:23:53 -0800
> >Jakub Kicinski <kuba@kernel.org> wrote:
> >
> >> On Tue, 19 Nov 2024 15:37:03 -0800 Stephen Hemminger wrote:
> >> > It looks like loopback and other software devices never get the operstate
> >> > set correctly. Not a serious problem, but it is incorrect.
> >> > 
> >> > For example:
> >> > $ ip -br link
> >> > lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
> >> > 
> >> > tap0             UNKNOWN        ca:ff:ed:bf:96:a0 <BROADCAST,PROMISC,UP,LOWER_UP> 
> >> > tap1             UNKNOWN        36:f5:16:d1:4c:15 <BROADCAST,PROMISC,UP,LOWER_UP> 
> >> > 
> >> > For wireless and ethernet devices kernel reports UP and DOWN correctly.
> >> > 
> >> > Looks like some missing bits in dev_open but not sure exactly where.  
> >> 
> >> I thought it means the driver doesn't have any notion of the carrier,
> >> IOW the carrier will never go down. Basically those drivers don't
> >> call netif_carrier_{on,off}() at all, and rely on carrier being on
> >> by default at netdev registration.
> >
> >Tap device does have concept of pseudo carrier. If application has file descriptor
> >open it reports carrier, if the device is present but application has not opened
> >it then carrier is reported down.
> >
> 
> The UNKNOWN operstate sometimes is misleading, for loopback device, the fix seems 
> simple, we can just set 'dev->operstate = IF_OPER_UP' in its initialization function

This comes from the VRF driver which is the only driver I found that
does that:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b87ab6b8e517563be372b69bdabd96c672458547

> or add ndo_open handler to call netif_carrier_no, as discussed in thread at
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=754987#89.

I don't see a lot of value in changing this ancient behavior, but I
don't think the loopback device should be singled out either. Otherwise,
some time from now someone will complain about a different device.

