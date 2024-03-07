Return-Path: <netdev+bounces-78445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3AB87522B
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99191F22575
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB871E896;
	Thu,  7 Mar 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LUcw/g+t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAB161
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822733; cv=fail; b=hf8lH7EpcRudQtH6kqk2xl0ptQ77mDhu6EDilZHJS8FAP4foMWclpJZVuMkMZN6QGsxXurbJvGcdjihnTOOerdPmWquog2i6Yoyoy3/gXR0BGi7XRpdwTw1JNJiCiCUNkynae4JL/wGV8FNUscvFxHwjo8PKhn62ZrJaUjixSwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822733; c=relaxed/simple;
	bh=TxihjeoujljpLplSLgBGu46f8BGml6HgNM6ZVjE0yq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QUo0FJRgmoXOa0rrYOIt2X8pcANXOlqJuUxlM4oeslI02VLNc9SezW5/gqVGqCPryDgDxchACbY0G7k5Y6OXemF+mcvV64BkyWAJ2SsNad3J9qjTmaSC6+kn2DEvlbjmcVaA7INRoirTRq7IMXApwlSsEUjajuX0h4Bkq+NBzbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LUcw/g+t; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTYDB6TSpaWz7xjoZZpK3IYrtjfzTwNf9HDHe1iPT8q9KMtbwNxAmC6guF2BA3LH3L0qeLbdevFYgRb3rSWJ3HXmFBOu6S3k7fnppi9IGNvl12rhi3hmDoUQRt0zEgwEBHqEVg9aWSP5NprCHak5bU0DKlOqRAH3HFJ0Q9nV6XUt568EheVhh2VyliRZuKM8NaGlPcAlh85xyu7vDzs4ziomA0NuQiS+fw7UTObIc9gctrv2EU9T5CU0P6auSrJrP03DLR7p9oROB7wrAzbucqTLdof0RKQYvqWitfVlOmzIF4GtSI7xHbjP6DhY4tCYQfUdYwbSk6ZK4nVGtf79MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBY+aGpaR8bur8jgsK+EwouR2O/J2o5kWSsWPqezh8o=;
 b=OwcOE8x8/jT85JbLTU2ORqBlYOebswG8gDK9mF83shfFn6UY313bUDf+mX4I+b3+RcIK0Ar1T6shQy3869cHYGtOBF55Qzkyx6OSUkRxRPWHEqC+gnLykYuJ239CNc4/aSoTV08MiYNNZdiuXe1WsL9pFZvqxHBuWVUuh/c1NC7f/brmmTeL8bcYdXLioF4ybJd+juAukS4CXobS9LdoAxqZ5AJxlnIdqfoTDZcab4i2InCuqKTbbAydjxZF9hDSbJ+GCZ51KJkwx9sFQ81Fl1Q4Dgbxf7bdK4YLNjI7jxWyhLY3fYESaD8Z/10JXfyozasWQlwjBvoV+jEa0XNQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBY+aGpaR8bur8jgsK+EwouR2O/J2o5kWSsWPqezh8o=;
 b=LUcw/g+tu9bBSEXlszLylzfM8hDbGII1+IATDfjEH0XonCHV/zxHBP22myAwkBBfQX/R59cTuYyyBnB8Ib+mXetBg+z+G2lo/toecWnsm6JDCk04nHEFGoKUY5/RVuA8+KsBoMfUo4qkgBdA38NPycYT874T4RCQOsmFxzSXwI9E2yj2zdjKBECrEZSV7gWL2LiwqL5CJ5D0AzcJ7ZjPh6S8KDxu7D2/8eERLqDTiRrGhYZUxum0YbdQ2TADtrkliQlYW4O2iJWTbHTD91Pz6+jNDpZzVHqoHzcVaYnfY231xuV/kUIIMj2gfP8rJ8b+sVnP7+DKPjmFuPQLvqEOPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 14:45:28 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 14:45:28 +0000
Date: Thu, 7 Mar 2024 16:45:23 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] netlink: let core handle error cases in dump
 operations
Message-ID: <ZenTA2GFstEzJttq@shredder>
References: <20240306102426.245689-1-edumazet@google.com>
 <20240307093530.GI281974@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307093530.GI281974@kernel.org>
X-ClientProxiedBy: LO2P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::16) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: adacc806-a00e-4483-7217-08dc3eb53b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AjeF0Km99lzN9gMxXd95CeMNv4w6XUMJ27b2/iKv0nLMDZ/S68rgulZsEmYKysZa6ySBw8ATTxe793Omkzrv3TGMsLa5ZptuCid1Wy9I4sj6KPdNb2IM3DucmXGnv6SXc6cT6H7bSAAervoQvfjKg0N3BuX5Ub+PBKZPp4105utieqfugcFL6kkwLMlQFBbOE0AyGPlAzpVdiG12A32tnhrw+eGa2nboTWCh/01VeF4zYaHCf/eij1I1gkTrtqkJNnHkFrAkPGgAgzWahv+KkufvWoDKzKQpPkSHiBdQsFCB3hIXq5XoNXVDDc9nF7mcfOaOh9daIbrrLNAIvvNoqRcCnJrspK3dHtHAGj2xwrg5CnEmqURe25U5VVOmjV332y1zDMhGoPgQihywPDCp3DG2Azlb2OiL45OV4jNwaOGHMYyfoZP4862fQ8Lkz4Zm71Eb1BFyXPMCbIrvEH1DYE9r35iD42LybHvKxmsuLW1H/2jvMTqtudno8/AvKCnq6tma5g07JXPh7YiddExMLsx9IytCpmybQY4/WD49+FsYg7yQPwHSyIY1YLugl93wt2uXLv9CkuIrWKM/FgS1Om80fBrGpoUhg9Ivpglw2xmK87FliNO57a4c9FtiVBcCgmlwfoZFbtTS8wcVR2WVc+rgfuIi0b0iE8gEQzitKMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HouluamBpGV1qhEpsUDvmVAuBYIQEjVrosx3214Wgy8AE7vJsHwUVdnUXYRN?=
 =?us-ascii?Q?Sl/Pzp5O1+azojQh8Oe9KN8u0Xv+ar/+QqfdyHdDigwncAJ1LaAAQCDCTrW0?=
 =?us-ascii?Q?z93G2jpc6tc8H5vKqIKp7m7+lChAIcBnuRCyFTb47jOhG/oBb2k/1voeOQMl?=
 =?us-ascii?Q?pFfLT2pZxl9yY4F0kRLY3xTOmiVbPqYgLsr6VLJDARXkvIhjs+qaSRm0gfbE?=
 =?us-ascii?Q?MXnyuUtTuQ/gSElblZteQaalAo2W81C/zxeYcqWB8xAQTYnrFF0FypNmuP03?=
 =?us-ascii?Q?sqlF60QdVVkANgPw7A2PekBFZFQecGGZZWAukahdONetd3wOPfmS6/JDPoYs?=
 =?us-ascii?Q?uAuWj+/slwG8GaLoN7ZBJ0agTKYGds0Bh4Ku19Yqj29DrUrvVK5VqBvcars/?=
 =?us-ascii?Q?YCi10KfzIrvGSalzD90rH0iweKxYwiW5n5aFl7CJ4bmPqyA1ALO1f/mW+2yz?=
 =?us-ascii?Q?xZRSsWCgHA3D48OR2M5qxsPsn22MKO7o1Ozfi2KUIizqJq8l+aIVYnyd0fMt?=
 =?us-ascii?Q?TuhylCSu0bevNp1Q5yGEH4xysDPkiu0DrYdG+Ob6WNDNZRlfmjd8ANdzPJZF?=
 =?us-ascii?Q?UjP4z3nYP68mFwAT8iK9HEi6lUYeHHMwzDvNRN8df0fKM/F7pKg5b+9ReAFq?=
 =?us-ascii?Q?muk55AtjG+h83uP4jU1w/veXUaZTc4j/XQZxpyZqdTINBIB9gSGBOa1kK4b6?=
 =?us-ascii?Q?1FodOOBdJ59NX0bbogkAQGtgF14tZ7XL1e/uRGQB0a10iZmwayPHMoPbFwPV?=
 =?us-ascii?Q?32WvwnTFgLwMhEBSYG0Kth4UEYGxHvlweWxcqVT35+4DgMYrhxh8rqZEmPkG?=
 =?us-ascii?Q?CNAecvqy85Eanr6ZUxg3gQtPx7YpPng41DNc4xnONT2znKKRRbVT8vJqCZF6?=
 =?us-ascii?Q?m8GQhjNOlEYQuBQSHjxSOGim+4lfTqhPyJ7wPZoeKMBqrNNtWqm32RhkBKvC?=
 =?us-ascii?Q?+UCvl4TjIn3AiRws+we3i8r5fGrcgKghpvLkvwlK+Fyjqqe5RYk/V1NET74w?=
 =?us-ascii?Q?kvzkQzFI75LvrR0P8YQb41NX/yQ8KX4nWb8pX4BmZIXl33TUohe/OaKQVd9E?=
 =?us-ascii?Q?q7gnPUlJUyDEIA/yk7RBWQXUnbzwIOiQRouV+Fe0dQwXZeY6LRGueA4mDdJr?=
 =?us-ascii?Q?7F7dLFGVO61B10d39sUf5dpwdXi2hJkblS4qHd+Hi0GKb72Shpy9akmdG++V?=
 =?us-ascii?Q?oaEwstfetil2zA9RSAkK1bTV8V0kWHSEXJWQVUE/dNrDePUaGY52BSXhiqIi?=
 =?us-ascii?Q?1XeJEzSLdbUhx6Bjv2jE5lPHwgDbyuKTdUPa0SKLdNDGo5FWLlHzUvsEDWyJ?=
 =?us-ascii?Q?vS4o8Bo6NFmqbhJLBD5HQxyTkMrguVIMDR96GELlothZVk4Jm/8AQ8jhKVgt?=
 =?us-ascii?Q?5aMCvGENJWIVUG5YPFqMgKisWtStyajOqYRnPrczQBA7WUU8abcIRB6Aaf91?=
 =?us-ascii?Q?i4XQQ2qNLwESGMuRhPuz99D8rD5/V1g6UR78YrwjVuwZ6m4gnxk+/sFHkYOn?=
 =?us-ascii?Q?00K2ScLmX2nUvbkfxTu63L+zVNJ7gO4hPdxIhCre7z9LRghMdq1FiHxADSE2?=
 =?us-ascii?Q?MSiTYWOnIyg0rTE9huptgVhspbBbtS8kI7goby4o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adacc806-a00e-4483-7217-08dc3eb53b27
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 14:45:28.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQXFH+OikRcRewzbdE1AqkWF05/YP1ekirXBzMFrLtR7AROWH/g9qaAWvDXiJrcgXnRQ9PIgChYTT2LTvOnm1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366

On Thu, Mar 07, 2024 at 09:35:30AM +0000, Simon Horman wrote:
> + Ido Schimmel, David Ahern
> 
> On Wed, Mar 06, 2024 at 10:24:26AM +0000, Eric Dumazet wrote:
> > After commit b5a899154aa9 ("netlink: handle EMSGSIZE errors
> > in the core"), we can remove some code that was not 100 % correct
> > anyway.
> > 
> > Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

