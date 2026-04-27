Return-Path: <netdev+bounces-281221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN1fGcn77mlT2gAAu9opvQ
	(envelope-from <netdev+bounces-281221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA37146D67B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BE043003514
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59C36AB5B;
	Mon, 27 Apr 2026 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zbnd+KEF"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39D3659F7
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269702; cv=fail; b=vE5wyHK3B5bzppnrIrMtCvbo95QTKZ92KAXgndix9/X/TSjZ4WHm+WhdheFSHULM6nEEVZrt43zVJL2bTc9uJ2QXC4xgxjiplU4Yg+Wyw9oT13CTB8Gg3DIPhLMQWe2X2lvQfSJy3S8Tiq2/j6oHt3JJWN7Ix1tj2SIB828phtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269702; c=relaxed/simple;
	bh=hySY8b4NjXZTbkkqxG5+vTtrNTBUGhSmWwX2NO3pAaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iEA0gT5614G2jpLcqjH9GwtRVNBdjoa4GQkJH1BDZXBolJdH+MHPYZxw6ZsuivH4RvjgtSfgfzYSQg7ln0hoemEQsDCvrph7fVYjOrujNG+3UPDCPqz5AAZCD65Ba+Arg8DEaMmwITKvaT3TIsSIJQT1x2YuKYP322dBLw425HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zbnd+KEF; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+IpvxtI5hVGjB9UQBrz+mVtvSDbf9HOL3DJqxhY9zoGDELp7m6FZE6rhOAXH/mKdjo7Rr5eLQLOs9jVjgDxrURm9I+SGpZh0vzRSwyL4RG0NvltqUO55jSmxEA9tH1BgbXBQd+JELl5gvuhmM6VbO6Im/AeBTb2MtRs/Z6ZIR4Jnqy0Owoi+ye2mz3Lxj3VKsKijevPdl5FZAaM1FD9RbE7tI5Y/a+qzv8xUHc7Pn0iiDVPZihOwCTX3wYMa7VwUUS7zdCveJGWotlcmO8MAxOWhQqr0/GLlNOo/IYjHmGhcKufZ7KfSFxG5wBv4RTKJS86duXQ8DFHpZcsIgLBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFSmiLr3FixojyHrXIgnct3ywYtW2fihhVW2gFx6O10=;
 b=R6fUmEYBV5qD1jrFwkSNkiGomW7+kfW/dAYsuH646wiYDPyLz5plPJ++5jj3KIOyNMKeu7lT7z3YZFPJc5ODwX3+Yk6B/nl0AbwNxiK+CgSJ7NeqhSEuFuqPdk/VFfyvFqCw7Z1BGiRLuPTQNgzmpHEO9PIr91ZXSJkGTqIyQ0v4Jhko3jvP2ixc+rT4ip0BwiRlA3aB4vLzSYqm2db96antleYlOhY5YcL5D3hUC1LiyAlzHN3kRHxbSWnVTPfEwzVY2Wku9HKUqImeXlUT+FiX8HEuF+xAzAbrhqem5JzYxf2Do9rc4k0AYybV5MCbu5uODAwZmv0xBqE0tEdK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFSmiLr3FixojyHrXIgnct3ywYtW2fihhVW2gFx6O10=;
 b=Zbnd+KEFPoVj4BaSKhWMBN32kWjzRVD4Rp91whCnRV4TX3ULhO0bhqNMal3Kwy4Vj4Z8GTBnNJf/0l+usFWEw/CTXFiGMgsHLi6DZKtFcHDxmEc3p1/u39oE/+kbBLKuKWqCNCjMmRLgL56Cin9QwLiFwPEBObVNDnc0veElwbtbKJeWkQIwaFQxxzyBtGFBwlIeY0AD64eUGwaWXJKpje4WhgQQ3iQ/S9Vk4DFHhR4GAljXL6zCrYpIhMlj2J9bV1JDzxRn5SswTtrzY/9CB7R6cfP30uDLRZhcusBymoklvH4yBhxSNuUliKrdfH1xhRLZMYQ70RFpmMpPSEbYOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:01:37 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:01:37 +0000
Date: Mon, 27 Apr 2026 09:01:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, tom@herbertland.com,
	kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: Implement limits on extension header parsing
Message-ID: <20260427060127.GA263748@shredder>
References: <20260425075521.736328-1-daniel@iogearbox.net>
 <b50025ba-c59d-4575-a790-fdaf0a48961d@gmail.com>
 <90c7de29-2641-413d-9d5f-5eb323cf875c@iogearbox.net>
 <20260426131714.GA180947@shredder>
 <dca69fa4-2284-4251-a569-8b26ab9fca07@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca69fa4-2284-4251-a569-8b26ab9fca07@gmail.com>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c726f9-a30d-4206-598b-08dea422712e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iYT9XMSjKSRKpDTvyopnJWoYlEXNGL4nOKDdqaph6acUXjTHlIRbL2EF+XLIGHptxkhvMgiltvUFH/s9jR2pWsjx+LeJXp0NiFJh5n5Uu9GBqPbZrsc+cdvqqKNgLG3fjoAz3lUJ2QEk2nse70sHpbo7YodE1X7mQgfof5ywLf96lFNJQ3nMSN4yJbcLP1tX3Cybc7TA+HxdR6m+srJ/9QabCsfv35/iVfLXlyuSY1fJUegC+HQBvgrtX4iL47SgquR2waDCBYM2iX8wZRu0ottbQHtXVL6ey4lOy4OstrQXikiJ81TVtOVBI0+ULR5TjkCS6UxEipL8MpdEUE5/cC47rE2u4dr+pc0eTElmUPapT0fxgzAhqHo5I/Asm/flINfJE/QudNnfv5wQ6ugwrQVQEgpVNH+miWjKnlqEZKrBU08v2Gtu/rvEVaYE+Som88GxLbMKo74dWDYV5wm+7CUfDQo851nRvk/NBC3RqQuGXDKFZokoN98j6+q80y4ZAc9OD+evphv747CHC3RT7iwG5OlzSdx7uiZOm6kkwlacssZrPRRqUOzfChZfkUjOJkhblAww0Y9kpQhf3D5KL1499SyRmSrxROTqIOJA0dxxWGbm88ENA3+vtiPjdR6zI7I75Xm1r78OkSDXVJuG3lK4lDU954/nJVRsqmrBI3tngweIuTiwQyqlgqyrsdAf2i6QzhhVPV16sZBxta7YhB52McaBObl0UyG1F00cg/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tf99MF2WeBTSO2uL2r21iKHiIgPbTz4MaF/g5Xlcl7l6oRs6giG01/H9iQ3G?=
 =?us-ascii?Q?ZgzjX4cCBiWK36GmXM//G8NSPm2040URxDVi5dJbx3ID+29y6tRlEgd8onif?=
 =?us-ascii?Q?TzF/t0L0Ntd61krUVaOoTKOkOgXPV+SdAj+obonnG3p/QmYPFmbaBNYgCKkS?=
 =?us-ascii?Q?4f1oQRd832XZkqC2EKMoIm20yl22ClH+Ewpe4jtk17ecs30pWJP4tpnf0+bM?=
 =?us-ascii?Q?/j3pomXg5CXmqXmNm/BUlVnVdUgSBE3QVIMV9a7YEWDmgI15MxYXc69n0anO?=
 =?us-ascii?Q?neAgenApNka+MqqNkCms8rmaq7e+a4DSFdMwr/Qyng81E/6EIRpOF1P1rXhK?=
 =?us-ascii?Q?1W1YQLD55KGndHVnWIUGCQVmYvWS/HNmadrGUAHhmkctRnMoU9E8wujdM4yc?=
 =?us-ascii?Q?OLljXToc0pcwhM2Q1E1RjmAYN5T5olp9vjpPU7H9oh28nuPjVIhbXskPUmtA?=
 =?us-ascii?Q?vX+5C0OSZf9IgH5BZz82TlLLDyKhwzzuwEb54pkz/wZ+4IQJPRskxi/UToDO?=
 =?us-ascii?Q?/9Z5Y2PbhXwExmh7VpYKNFtmdTYtJ34h3Qn8PifzBTuFApZ3qFrr5gQZc79y?=
 =?us-ascii?Q?q0B6xAKG9wcTtnN0JFBv36OB95yLWMhPXrRioWVrL86Sjj1EMwcMgCyL2bXx?=
 =?us-ascii?Q?9ThggPwV1hw8kP67AqtdQUsDxMKrsHFNMrffda+smQt5iDUdFusmDaOVUSJ5?=
 =?us-ascii?Q?o4Fzf7DUB1qwSfAEKh1PKQ4kpS1y+ryfA18KES+9z+wFoxoDfVjg5UvphTnI?=
 =?us-ascii?Q?t1+Sj7ba4wXCEnCkV04bzOG9sSmYpNq51kD9et7A2d3WTEG1pOPu9iaBoWNm?=
 =?us-ascii?Q?JD+O+jPikEwY5Jq7f7DCVOl1H64XYsJ7HmpKP4mMAT2Zu2bAOJ53XGdi/k6i?=
 =?us-ascii?Q?T/cDYsk6ss1v6bbbd9/wecWEZHd7ccVeDT4hojVead4TMZRMrOgxm2nhU5q+?=
 =?us-ascii?Q?dDNtYeRcjIJyOraOEZIMIZEGN1Ft2YltnpaaIYJLYjvLoGemFJCcXem2cSDT?=
 =?us-ascii?Q?jVBjsuDRh+vLgLfGiYdZd9BwA0eb/w0mIJVOAFnp+vDaObZ4HRwa5zv2Jo9Z?=
 =?us-ascii?Q?ZWoqzWhp+qPT24ni8EwM6QkjSaM4AVidkGoJbRnu9NWn7R9LUoWs8MFM5vRZ?=
 =?us-ascii?Q?GtxkGi3+pCHsvkewXjV43tU6cCKdf4nVUMXoK1MNTQGjmHlrk2HQA/3rZiCu?=
 =?us-ascii?Q?aWb/FJEBFOGZXktzsaHz1Pz3AnyW5haiIjOBsyEZ0a96zMaeDnGR/zpv4YQf?=
 =?us-ascii?Q?MRgOtSFZaGmB/hhradUMoWTMSO1QrrOVdyUbNNwHAAeRYlgEvx/5vJsIGoX/?=
 =?us-ascii?Q?YRzWs9G5U4b1o2qOr5cRZvK6gw6Z3SLLqgvennBlaXo9o9wQmMUZjeeF3L+v?=
 =?us-ascii?Q?vB1XBwClm0skXzN4wHSHA8vTJGLd64poiafDFDaxGVINt3ePcC8PI6hJdt9E?=
 =?us-ascii?Q?htKP0918oUTqhUwH6GgnhU+RFeyq8al5dQL+uVFQi5y4d0+0i9kPtJq6zZ0L?=
 =?us-ascii?Q?4ZXHZ16DsMKQnLUZPOQ6PsbPwIvTBIiFQHkzwJtigQhiMf5w2CsBPD2jmdgX?=
 =?us-ascii?Q?oe6PHmxGIdl/CZzyYAPab9MyayzXGjcbAKkVbeX6Z9nwXwqeSj6voRxcOsLq?=
 =?us-ascii?Q?zjdSMLYeOxULkKmuertZRUphgtnNKyb4tfnemXOZKXw7u21bvJgNuTOuZo54?=
 =?us-ascii?Q?xq7xhpyz4HjhpqhO976SJ1bwl1feUd75FGCzcQy3Omv39/tW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c726f9-a30d-4206-598b-08dea422712e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:01:36.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWN4C9Wwny7Tryo2tLA5Dkl0TpjYywp9B0xQMNmWzotZ0l3pYD8X789rbPQKIN/Vrtq877e+yjSOl3vjaKjbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
X-Rspamd-Queue-Id: CA37146D67B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281221-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[iogearbox.net,herbertland.com,kernel.org,google.com,gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sun, Apr 26, 2026 at 05:47:38PM +0200, Justin Iurman wrote:
> Ido, Daniel,
> 
> As I said, my vote would definitely go to the solution without a sysctl for
> the very reason Ido mentioned. Note that an upper bound of 32 is kind of
> unrealistic, although super (SUPER!) safe. Sending more than 8 Extension
> Headers (assuming a different type for each) is not standard behavior and
> would make you non-RFC-compliant anyway. But I'm happy with 32, as long as
> we don't define a sysctl for that.

OK, so given that:

1. 32 is super safe and solves the issue.

2. We will likely have to maintain a sysctl forever.

3. A sysctl has the potential to be incompatible with the upcoming
"enforce_ext_hdr_order" sysctl.

I believe we can just go with the simplest solution of hard coding 32 as
a limit and drop the sysctl.

