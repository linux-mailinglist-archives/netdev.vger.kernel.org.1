Return-Path: <netdev+bounces-272138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCujFeJhxWlM9wQAu9opvQ
	(envelope-from <netdev+bounces-272138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:42:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3C3389BF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0214312A746
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09B039B94D;
	Thu, 26 Mar 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GGCCv3yG"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D888401485;
	Thu, 26 Mar 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542622; cv=fail; b=j123TAX15NmXB3sEL2FH3HnpzO47UplC1UTdxyOLJZ7lvt72RTwszQJoRJAgd7eSKbHNCyJNKKbx0RByFc08lGZflfSQiArCpudtwfYU+0Re5SFanZUdsjLKkBJodgxfBbXa39LT+xWWwpapqNOKkV6hHGW5PhAaSF+Kr3YVD5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542622; c=relaxed/simple;
	bh=1+EK5QTZd0WqXmfRQUQLKQqLjWt+RCReCFgDaEvdl/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FeDpoeLWeBO//NJpGvkpamGsJa8QzLuiR2HJqv01PS43uYbXk8uEu2NStKg8C/EPGYpf49RK4vsttsofWrq8oVCPN0X0AsAinLuD0cn/V8Th86ql+svtaoq5lOjsjPZl7yQwgimOBYzNq1AY+tjN16B/1Kk5/AkQ4anZcGijn1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GGCCv3yG; arc=fail smtp.client-ip=52.101.46.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu0kv7/exB/zaMbMWsC/Pa91yIQZQXBdVgffXIJ/fnhKCb+2179DIzCSXkBwLnRtFPfhCcMZOwm6s8CtxnPtTjOqvVUSeyMwGZRIvd6cH63V+/8NPUi7FDYqzjq+eA+bhGCvw8BCmpiPMWxiBWNjLH7jfyl6B9yuZydekpgG96rTLtpRQV+okSeUhXEKNNeUTQFa6NIrbsGCJrQ7fGg+iyg6sVw7B6qgwcogFuEV88NJaeC6pVdLrBAwJ2w50z31vQtVud36YXjDddAw2rWMuEJxZTobXiiE/kKvx16XEqW8t4RfqUGNyYn6b0ZqdpMrFZYNo3D379/ZlGRl5ipR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDdr/lxhyjGHQ9wLzOuB/n/EqmZi+ARVXihIqbRVd+g=;
 b=tlwexwMNdx6fz4Wz5eQT2fCxNiPbIvMS27af2l/Rb9evElpEQSnLVJrqenpn795gXCc4PpKhsgELeGhd5HcbJaXJ1RJ+H3Qm+H3TQak6dwsjRMASGYRM9Yj16NnV6rojOhPcX04pvoQFpxpR7QZY/UXjD5dnVbhtIE9dOu0RQHh7pvTmIEcVDPzk+7IFCbUZMBZQUhbEDeurfvTQO/UzE094sTLnVNVtKHPRIR094bMS2bn72gOj6H8X7enakrpQoPLVZv+ZnoAjrcO22x0ZC5HDSfJ8GnpxT89Wx3cGPGwLy6S4r4Eau7P4yjbeChI+hiEKE3OPXXLVR2wl5uz4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDdr/lxhyjGHQ9wLzOuB/n/EqmZi+ARVXihIqbRVd+g=;
 b=GGCCv3yG66FnkoJsPiLwAsdwLzuOJR2/05g2lhEUjG0qOismdiWEuOG8vzgbNAwN8L6NJkY8wRGq2WwiCNwd+Bk0OCUop462dkhnJnvBjRYxR1hxpJb5s7VSXkSfa9jS7ti1xdG1NHiRM/2xUojMJi9Pq9EjFmgeUnPThiyLVxPSKXDBNwgCFdL+KWdlRNEACuY4Avr1RMZjQ+StDmOmn6vDlKWXelzFp2WGua4ZEWqxHr9/iJiZ8/Un5mH0rltfrFAON027i3jm7fLYIkJg5ao9mDrLjZb5eSfNMdcNcgm3635rt5KqXVZqMZLFVHEyC+r9pXvAnJhFynhLDjVc4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 16:30:17 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 16:30:16 +0000
Date: Thu, 26 Mar 2026 18:30:07 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yang Yang <n05ec@lzu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, razor@blackwall.org, andrew+netdev@lunn.ch,
	horms@kernel.org, florian.fainelli@broadcom.com,
	roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
	netdev@vger.kernel.org, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org, yifanwucs@gmail.com,
	tomapufckgml@gmail.com, tanyuan98@outlook.com, bird@lzu.edu.cn
Subject: Re: [PATCH net 2/3] bridge: br_nd_send: validate ND option lengths
Message-ID: <20260326163007.GB1051615@shredder>
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-3-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326034441.2037420-3-n05ec@lzu.edu.cn>
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: ba02ee84-01a3-4d5e-d562-08de8b54f66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JFOVgWVcFx9lZ7E9K0mgH3PuEe5LKagXpRc1MkR9Ez4SJiJmmWSSvvW1hG48PAx+wbKJXGQ6PlArscEdtM8+uyZBXuts8GShFxnazgd0GjeVGkFGJ+k82qDXY45Ly9pM3O1A89WqaOuNhlI9zKd5ZVf5CJ0i7fjIbEhjR0aim4c9rjMX4UcAmlLlpZcxTWiPxEIvn8kZoMF8+UnMI8ppkSthjTMMp8NJM0eUQD+8CJp04CfoJqLYDZEhsdYTpx7efziNmrM4tg/tbRzDZ9tgFuaj8ePW6yW1XJabd7yfReoCGDzSVkAe+Ct7UsaTz9hxhzlwha++y3MQpgRwIop1kRIEeXEVJVff3GgI5YHthLqmWVMWN6jTemSR2iNgiSzEjsdjsbhlML0kZeNypOMCJad1dSiO5nBPUWAXXErcft8pJUOzV1B60Ca72jkq1ONpWv6hqbC5Mx468nF3UhZ7JYyiGXrjy4AI9mvuIS2o1J9VSov9qYWSYigCo7XBj4YAeOnmety8djsEswMZ358lC3CMhLKi0+kL4CfdlrW+Pudb6nlrizwvUX3Vw1692m0GhtK5X/5u1O9xJBrwFw9YnbfwP4ygWZuy8uZXsp12Y1EHwacze+lT657W9ae84ya4meKlJub+64uLr1W4IlAnxCraTuwWI1yy1NAGkvYmcfThQMEfwPYILefUN89ezDK6rXWjcLexpKihPT+k717DTzw+S8qOmFGmL2X7ELf9Btw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZaItyUp6JN7pEz3qQLVvxTr8+aSKJNVau7GtCSfk9+gp2o99b8B8ueMOtwia?=
 =?us-ascii?Q?w2mJiw7nUKV8HgsubZ9un5WK5JMT6Z952nZ5pZg2d70AtdKsbUf1VffRywWS?=
 =?us-ascii?Q?AEG/3SDTlKP6i0cBxwist3IG0byzqi93OPiC8hcLuLzuDhYKARAwpBazHxd7?=
 =?us-ascii?Q?xY2EI/dBhRnM2ZfvNsat4m9hSbD42pAY4G/jRlNYC9ZXt6nrTI0TAhJ2a5l4?=
 =?us-ascii?Q?HVCBBnR6zOaHu/dtIrc0tmxcDEy0kaEUD+2jT6kWh0w55JVZWCeHec8JaFQs?=
 =?us-ascii?Q?8jTRYojf4N70wmEy1Gez720hsWraH8raipgOzPEsDD3Plr8vBLIn5G69sI5n?=
 =?us-ascii?Q?UMbt37yh8jqzMc+c7N2eLQdbiMRJ0fk/ghAPy0LfhWB/3bXGTMhRdDajWG4Y?=
 =?us-ascii?Q?V7FeS8Z2g9uOvszNuRw+CmbaWoa3raLVV27+0L7Q/OksoCwk6FLdkFktMsBE?=
 =?us-ascii?Q?8RDZdWlAAtFgJTMS/ggO1vJgq7iSEFEcwOn7erGkmdPc/Xa4Q74bHzk7VJrH?=
 =?us-ascii?Q?tA3thxyiWAfJgtEAgw66U3oAXMVwg1aYI9MPEa3ZuxSJuVv5VDHZFQNB0mTd?=
 =?us-ascii?Q?/SXFd3fHB+P5QpOG71htc1px+2dCHjC+4ttQOiUejWN5bwJ/vyvgIVRsARqq?=
 =?us-ascii?Q?H7p2PKUC+3DHwPbRpz438DHuc6CqtBxgup4Dg9udQ8IXYJXHIudV83f8Usww?=
 =?us-ascii?Q?Du5KQQK0oMuw1EkQRzQxqpuvHNytutw7KOwjOnJP6iIrPS4Fjs0aYL4h2jn7?=
 =?us-ascii?Q?GbJVjwJjDJC9Tdke3GddbbsuUm5XVLP/fzK2dT0pISMRP75rYDP89W53Yx1d?=
 =?us-ascii?Q?EF+eCPjw3gVh8uyxPmOalWcYMKf8/s1W8l9iV/0gZopLRpexAaxvY7nXzkN2?=
 =?us-ascii?Q?zgKZfB93yXGLJzf6RIwWvKDbqGDaQ/QLL2grZyZfV+3/B4j9l2Vb48eN+JDo?=
 =?us-ascii?Q?+2BpyvVTid2bNZPLNx5hreG386G8rtlXU+2BjsH32PPdMPTHu/XidBjzXWkl?=
 =?us-ascii?Q?ynM+ECuyFDRswFp5RQiG3ja6e7w43U3vJa1TV05uPGUmzmksv0xqCdfdnRjG?=
 =?us-ascii?Q?tsNJFJizWq2H3rU9J2N7k/AGq8kwBiLXSuEt9VUnsPWNwqIZC+CFPmWaIHCp?=
 =?us-ascii?Q?JLSp+vImkEKEignR8NXdWIHQ6svgxV7kXRCe9f82npkpYZzFtyGZGzdvS6iq?=
 =?us-ascii?Q?S5aTTISMpR9QC+kXIZ/mNwhj3e2FJz2C4et1T959wDSKc7v3C3s7Pz2bqy/G?=
 =?us-ascii?Q?zmMZ20gj74TdM+qMECVdXeF0RAp/3vvKQfP83rZr+4ep1jza2sPCHQpadgWK?=
 =?us-ascii?Q?3l+BiYmwF938/TaNul5ffqtJAi02Avo9HqYryexuA7S5xSzbI0+N8WvQJGe0?=
 =?us-ascii?Q?PtBv6TG89Aza8QQuXf0KtGsP8BCo3CpxFJLIMDU5FgDq7Z+W9ZChFcuRPFMN?=
 =?us-ascii?Q?Qv0PAmWnywsjHzeWKK7hOvkybpGzYHESkW7fIBIQ5/ukgjfLdWp0NzBmnjLG?=
 =?us-ascii?Q?0waQgtG2ZiMP29QZEhP/U+YlRbiHGO4W3RK9k2PVHxQQHcrWu1ljUK/YDL6l?=
 =?us-ascii?Q?f2Pt1O5PuUoV/S2ArLD1aiRCE2952XV2Uyhzrwu6UPuQFcSsfB/yt7RVOj26?=
 =?us-ascii?Q?ADmvEuXZV3BLmPRfTntvq6mbnjAGtGH/+kRws22ve+XPrzmKUtoz91NzdezA?=
 =?us-ascii?Q?F+zcqhmkizMMCtMfO+QjeJpmuzx/nN8OkNloCcglBulL1lCNMZ0NmBtKsU75?=
 =?us-ascii?Q?E3gXLbDVIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba02ee84-01a3-4d5e-d562-08de8b54f66c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:30:16.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ay74EEX6oPPm6LBcuyI64xW0mjZV7Lfh9N9Veo8N4LzIvf8p+0U3IKlrFiHUMSathHFstXLc3/SDRoN0jjWJhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,lunn.ch,broadcom.com,cumulusnetworks.com,us.ibm.com,tipi-net.de,vger.kernel.org,lists.linux.dev,gmail.com,outlook.com,lzu.edu.cn];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,Nvidia.com:dkim,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 6DF3C3389BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 03:44:40AM +0000, Yang Yang wrote:
> br_nd_send() walks ND options according to option-provided lengths.
> A malformed option can make the parser advance beyond the computed
> option span or use a too-short source LLADDR option payload.
> 
> Validate option lengths against the remaining NS option area before
> advancing, and only read source LLADDR when the option is large enough
> for an Ethernet address.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Cc: stable@vger.kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

The AI review [1] is correct that the length check for the
ND_OPT_SOURCE_LL_ADDR option is not strictly necessary, but it makes it
clear that the access is valid and it's harmless.

The other comment is about another existing issue in the code, but it's
less severe and shouldn't delay this patch.

[1] https://sashiko.dev/#/patchset/20260326034441.2037420-1-n05ec%40lzu.edu.cn

