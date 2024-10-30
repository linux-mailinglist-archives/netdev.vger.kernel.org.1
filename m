Return-Path: <netdev+bounces-140512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6E9B6AC1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3FF1F260F5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30D121B44E;
	Wed, 30 Oct 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D4LtNYha"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C21FEFA1
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308416; cv=fail; b=X7jZzdfAyYvqz9QRBkYjMFyUHhPVF90KY710hCX347bUzOYARVPbM3Yn0jNz6zhkA/zxqD5oV3M1YwZhW+UP7s737nM6h3ngiDW82hXiw5Rd/3ddrnL2NgXzG4XfyMxr+UmO+rg8kjcXlbvOqyC+gAdg4YvTQE7ARCh+7AHRHok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308416; c=relaxed/simple;
	bh=LtkhRXqtetsB7ZEw6HW5+idhW6EbIx4ZhlLzOGwY6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbIuJpFGy0YwsEHVgrjUS8KaLrlHHg3iP6+29oNFOEIKbyiCF8TTSgZQsq1jAYCUymbcceQzrOFwk3fT/+IITDuk+ppP71ggQ+gvEOfRZgLrscrSxWQ0ry+ynd7s5LARK+Z4OutVX84urEXhmqX2p3ppi87L30r91M92RfVd4Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D4LtNYha; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEUKZt4jlJI0wFVQjKEiIoJ4CTStb4piEaHYHWV9c2o4ICFawzNjOMJNXjdmNi9wt541GwHZSNoiEVePdNSYWCpHbaiFySshRT9PDMuSGjvfeADtETQhe7EOMoAwGKQabhRAEt3ZT/fwm/HI5swBNniImdgUs+ftilnHpIhklfwtnnQVVGQMaj4pi3LKvfkeYSoQ6NZl4GVuRg45h0556sdlCMcfBvK0pf6G+/D2lczc9g9ZeCJKH6B9hVGPFl2HAllEatg6EE2fiBVd8W4g7IpZxI8WoVxDr81qjuzCgfyOkcGl1Ovr3/HGpCrNX2TyawrOteBlqF+g+d66M+HDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbMCdnHfMa5T8ctCM2vyllMzHIG98dsuhvHQELqhUvk=;
 b=aEhmcKTmjOG+cQ+UoiCKE8PxvwfUDH6P3uVrewX5ZmvYKMZ0qw4J2wFz+7kIwNCfurTaH7axmOqy2m0vINpzqZKgXMrKme4OJhlFLQR98RKBqISsk/ZLEPv44QgKfFS2f+e3Q4b6PkCGt51jcY7FZ5VAs4iZ8V7KCALm6eJM9QaYSoVzwXFhA+f+5zQb5BfrjZTgqbFD/ulhNCBoTM/iwJ9rWAgo2Zcl1WRleWZGKQvhcjwjno2fnnxh6l2i/EcqENZq5Gka1mebKCJ3Fuud9rbi/Ff86Ruf78N4TtGLSQ230/nsQuJyWKjsQT6nWa7sqLPYXTUH0Mi+OS3VZK7hpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbMCdnHfMa5T8ctCM2vyllMzHIG98dsuhvHQELqhUvk=;
 b=D4LtNYhasTIdmVMND4NezgX5mTkuZj4UF/QZ1QlcJ3RE11z9ziSpqJhJRzvNsUeGbZtU95ph0KZQkRnX9xAx/XYXMJMuD9QqK3BcZku7WdOSH8q9jtmX2dkni2m64XkQT0P1nuq5J8BWjqG8aKfyPPWW+aytFOGZJdqzy8Z5pmKMVvuRPEXxo4jRjJgGzFg4noTH/Y9ji2zQpLrTW9GSxTsgI1u+wgiP/aaQPg9ZEKpSGBJ7RXCZnu1lzlml2zUpEwsKsPeakeTaH7OVBuq1fR3e9pQ+IGTedrvH9CreEkfwJBLmdxIXrYgHV+E9gBfYMeYO4PLNSYB0+JSMB46cMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 17:13:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 17:13:30 +0000
Date: Wed, 30 Oct 2024 19:13:19 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next] ipvlan: Prepare ipvlan_process_v4_outbound() to
 future .flowi4_tos conversion.
Message-ID: <ZyJpL9yUXkTcek0B@shredder.mtl.com>
References: <f48335504a05b3587e0081a9b4511e0761571ca5.1730292157.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48335504a05b3587e0081a9b4511e0761571ca5.1730292157.git.gnault@redhat.com>
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 018239ef-e50c-420c-38a7-08dcf9062d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzU1YyiyzWxFEXNTMxuzsDHEIdMtfisjMOhqQf1hJmN2CPTHFRS+f8GyrjOG?=
 =?us-ascii?Q?Ix5nHWtTmpBkkJZuYGLzmAIxLKC5lJHa2FicmS9CpfzcHMqm9v/q2q9WRPRa?=
 =?us-ascii?Q?6dNUEOmt3vuU2WWB7e2nnX5HEQKHBSng/f14FbBOurEc3v9FKdiATXgWVLxu?=
 =?us-ascii?Q?2vTvAgiZZrEeUOyRIgjwKjBSxSxsl+dk4GKbtpIkHhimkSCXJHabiUAmkcdH?=
 =?us-ascii?Q?cUt367tgSVY+VoPHV87zuabn/7i1EAuI7ncUjWE02opUC/wBcX12+09xTnFV?=
 =?us-ascii?Q?V3eCZk9Ygl4PdwxhnWpV6NdUJ3HqsRXrZo2TiYMX4raVCkzALYprfhCSTSoP?=
 =?us-ascii?Q?6RFAJhO1WBK1QBn0SQvL6WfRNZjuzCW5hnUTK4ytoCiv4pibj9deX26bOZIV?=
 =?us-ascii?Q?IhlDmM1vEolHEPPHUlkV0yYynxvcyOKAW+yISMcZCpg3W+bMZJfQWR4UAE5x?=
 =?us-ascii?Q?mYUbaQaoRxt6fuaIquAdZZraQr1sosFLDTxTBNViTL8xKQeug4oMqcxNaGDI?=
 =?us-ascii?Q?t2YwhjH4lMHRliUu6ZZv/LnchBuMcRUcGFpYE7tmIJUs1jIA4bbjxbHEbHxn?=
 =?us-ascii?Q?y/fXs6exqgKbiYeEvlgIHxQJlcZxzVjBcQIC3AaMx+a+MDEi9QGy77TDD+Si?=
 =?us-ascii?Q?V+9VlKQoWemWqsD0ZXAi34K3SP+jz8cgjgOEaTAGzqBqRDBBJf9BoTUCCFbG?=
 =?us-ascii?Q?IAeT9L9O3S/F6Yb6IUs+3fs4nuNRGmJALgWbj+m6554Adgw3DeXKpzeldvHH?=
 =?us-ascii?Q?Aqkz4zjWl7dm4Nd7nMeR/hjmJft0fpcuXSGRp5BvvcggAE5hTENPRKNXqSej?=
 =?us-ascii?Q?nj8QI10oSblwjORZELfkGF6YTSZpgAYcKrE8fcJy+7yL5TD1RBZNVLHTkkQ8?=
 =?us-ascii?Q?BJ4x2uv5wzLv1RhrnMsKE+smwIbi7dqj+NgEcEv2TbumRo+uFNRRsZTEJPP5?=
 =?us-ascii?Q?nw59kG1UIM13euiKV6hY3K8r61QIyKeora7/EvGlc0WDwIb3+UCLpKgzGusX?=
 =?us-ascii?Q?uLQGlf8Vm0j6A79DdTCQ5gqMz8ZXTFcFbyLczpbWJYgGixBiGdoegBTAILzW?=
 =?us-ascii?Q?j2k0Ue/h45QMtaBG0ECftpykY8AjS/sb6G4TxZNJQT8jle39oCEFsjJDFABw?=
 =?us-ascii?Q?LKbqHtoMcRAFwCK0BcRzc3T6naH98AvdwtPxGVvKLo0K1XsdyWt5S4KNRGcM?=
 =?us-ascii?Q?VUPL3Y3DD++2Flt7Pzer074lKgQ8QKb25hcxtf5mvpqHxOf0fHCzwg5mm17T?=
 =?us-ascii?Q?Gs0j87ExPFvqrAfU/+tuRY0MlpC9D3xIcF4Vrk99TMepf49wxE9BxA3YuXXJ?=
 =?us-ascii?Q?sODTfX2idUsl+kZJZiZYHW0G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ym8FFf8TwQruTy3OYhSTQAr4f1kp4PrJSCLnhuFrr3HxPBlURyo/NBShjph?=
 =?us-ascii?Q?OS3wjqPLyJbueKX0mGFLtQVuaBLjt7qbf1DauhijSe/ZKzmnf/F+ayhzRMpq?=
 =?us-ascii?Q?6UxJXlHoPVHdCJ4K8A6i36TyLvSWRwKfSHUNFK8WqbUD+bPeXkd+GQfXVHPR?=
 =?us-ascii?Q?LyTBFsM6etjOa1Rw3rH/atdePEpqr+Utc/Xpi3aw9y0VWOpqw8X7KwUGFUrv?=
 =?us-ascii?Q?bm3O7SjkqkwN2+qSUCnNk5yWC5EvqJxoud7k1UmXOdJhMCtqGcCmMEPs8/Ls?=
 =?us-ascii?Q?6EQRUJ3jU/K2LmOLVZf8wk0nok1kmCezZXZje/i8JONgG93vuP0ThOJJKxHy?=
 =?us-ascii?Q?idO4OAjngT2nb18v19dU1Groaescke5oSTrZEmpvb+0/tsaQwLlC5s9vA52I?=
 =?us-ascii?Q?hzwREUAT5+DRVbyV99E7tQiJsIaikHtRPvNlmv0gX42ltKhYkRCtChHvVU1K?=
 =?us-ascii?Q?dZiqgKGvpHYSCLb858dzDnuDY0+0JnjFAwNL0d0wnoMcPRrhoAOInwIuAokg?=
 =?us-ascii?Q?+lNH2tAG49T5J6qC/aLlj+X1U8PxvpebFDak09n+6vZu71hTaKI79HbMHvCt?=
 =?us-ascii?Q?dMc++rCoI7ogYYqVhmyAXPpfXpWTUpR/7q4OMIwMzY4Q3rt7n4jcY1bc+gz3?=
 =?us-ascii?Q?HgbfNFF2MJmeRZV7o9gJ//UHnvdXZty9IMsNrvRw2AyiM3mGJ0IojCFRsGoa?=
 =?us-ascii?Q?9OH9mFZIQeNC8S+QH9vD2cfnfLEQw+v6Dblvxn2x4teXrKc7rhJ0v9S1u+Ly?=
 =?us-ascii?Q?Vg2DtSj1bTpzEPFTS1fhk4xMoQWhnhRL3w8gG2L7nYSw/V8lmYNiwZ5yD44/?=
 =?us-ascii?Q?/kMgojJkdxUqREpd2ZDp4Ba8utO/jkgGvDaBw3ElYAWeANLuS8UV5cizN6lg?=
 =?us-ascii?Q?P8nbzOnXZgeNLU3FAwKOkF7AtPRO7aB1cD/qlrPVVfohwP/V16N9pMLXfLZ0?=
 =?us-ascii?Q?5HvU71Aoab8+KWcgKthfl0K4ETTbFHxxJotS+qHh3bj4N+DhUfhb4Pxjgrgs?=
 =?us-ascii?Q?GfA5Qyfr43iaM02Y9BPlvDf4mAAur9P/UhIJYY4xxhGCQmTcGXlLq89D40+p?=
 =?us-ascii?Q?HLi5pv9Oz20IrjkhAy6t2Uw10Cr1OGEoWtsxgqEARdfe/AIMDnz7szXDnfkv?=
 =?us-ascii?Q?X9KImEoYZLYRgddftO7SsmyJ6qWarhy4DC198x9yNyymEsAzqjKnl/L+NT1s?=
 =?us-ascii?Q?/rO9PaAR1gmbylqht7/16njCYKZzEz44OJWFC3vx8vnNtCd92JmBpdmI+5Gx?=
 =?us-ascii?Q?SfvAMfLYWIFKt/vC+IpXfp/wnD7Ao93hsGrtrGzVhpP/AEKSOWJdbFgHPirf?=
 =?us-ascii?Q?t5n1yv/hsm/79MukW5I0DWL0bqpfCtx4HguwOv2C3XyqrBRvEYYy+/r9FQXb?=
 =?us-ascii?Q?McWKN+ikZUqQvdjSziD0WzDuaOtXDGBzzJ9rq1yGvIysFNHRk7NqlQSaStiN?=
 =?us-ascii?Q?dKtD4yZjXDlz9bGUfz+ZUKa4JkVhUD14HAjwTec06CXBEnDK0KIygT0c9K68?=
 =?us-ascii?Q?2BodYo4Vlaj1C7KYX7KTEcd5+LM7YjXNT1Z1CzFctaGP2E9eFvX2KnEQg+gu?=
 =?us-ascii?Q?ASe9kfMRbim5nbc4knIdYsAB05prqXyGmPuba7hA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018239ef-e50c-420c-38a7-08dcf9062d6d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 17:13:30.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lW+nt5/p2aMh4FzpmCvmDGXQJmFQwe/BCIi4nUhYJwSry0xOkfVzznke/ziQetwEsYkYoozgGwyqrneZqrFENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060

On Wed, Oct 30, 2024 at 01:43:11PM +0100, Guillaume Nault wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

