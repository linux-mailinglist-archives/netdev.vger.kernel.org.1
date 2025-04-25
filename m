Return-Path: <netdev+bounces-186028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F3A9CC90
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49FD1BA104D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF5276023;
	Fri, 25 Apr 2025 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qE5C4pss"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02B27510D
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594110; cv=fail; b=nd6JlD2VFgVVFrRpby7YICT/qLuSd5opacsJIfD8hnXX7aNwuTPizT2puR077EfBlRqtbDw6uNMYRnlCsxU9JXD+KuizdzKTmJOEZJGfLmdQkX3c3QAsBLOVo8mJSPslmReej7VpwvXfL22/j2j33onqUFPBhByYnpc9mQ+4jLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594110; c=relaxed/simple;
	bh=IAqZsqgSeGOtUs6fQH6Ujok9fZwf6rnaJbvTKgTbWvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iugtwOk9QEayW7xeSlnj9caiKScQI1YM5stAuapizQs3eQSEkoGRCUUKzGM5DKonH9c4dnfOzlnJqAGIQvBNcT+CbNmZ0/kdI6rD2G/Xg2bPBL7jT9sBZJhGC2t3OUaOJ53bbJyV5Lvp4o36jBgWA+g99KSbZZ3Ft62jgzuilEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qE5C4pss; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs+nU88onmrlcVXEldBSpWIwRKNf8oVFf5zs0iH+HOCUAvEHqHCJf8h921L7WB70rHLYsFRA2F1V3Vl4OoOUjRUUs8MwcggCatJSoQGjFcbdRb9Z/zCmkfFulmKhWO7F2avQBdlPnx6yxUx6qaHSYpYqOH5mFS0vmZdNpX1JIFXxL+Wy3+WX1Fk+ssqZVamkm9jBoNNnAawMePFi4Ikzt2i8oLzZrBi3ekxhNbCna1/8HQ+nRdngbhG1NGOco9Jqj+rVrva5F9XHlH9PIcnaVDE72h7pQ4vbmfbXb1pwySssubzB6mCkuxpQqiCb6Q8ayaAPTDXmJGeMGf2NVfV2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkAI0PCWG8S6djPj1ylo7w2IuPXl4T3MrHCTfRhKngw=;
 b=RvCKX/8lp7edOzSIWQHJ7QnBIgB+55f4U8mWSKXoLOjrY2FcdGMn+mtUiCwvpaJBpmg9cvFlrEpxdYs5c2WL6CndWP1d6ekAGYBzibdN5rKSPldtWwXA/kT3cm3joSeQLPxG1WJepZqogRkZXlJsxFQXcZwEAmQvBNUcUwWjCyZQNjdjmcB7xjqInZBRljkqs+h8WXuIePfWgNIHGShK8ssVbOu+uunPEbGhqTxhjnjL56qU/pDIksDiGXltZnMJ5q+DTODOZdji4DPC/cspEm9IkojstkKuGTgDLreuJyZm9kyTfBNQIsFuuS7FR7PXYAwPk6cHsXLZS0MWBmXPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkAI0PCWG8S6djPj1ylo7w2IuPXl4T3MrHCTfRhKngw=;
 b=qE5C4pssZDjB1cV1PzomgpOdYM6I3knMvcqDvI5s6qyXhNMgAq2Fhn9shP6X53zipUlMaOdvHe/TP/+U9zirbAYYuGHOUWWRU16CiryQ0PQAk010MVG/umHFdPV8/P5Fb9tlDkSRuAZMx/ybCmwpfuJuOe80EuwHO5Z8rIvmVjt+iwPUNVCH8+6QoYbfsiCO9AdBFlndqUQHEflyYVw+3FVROUXPLgURaNlj1nN/0WunaNvcVJrKLToHYFeTieB2iCOawsC0ZRHu5Yre1+CC3v63Kr6ZC40IH3ezyAWWT2bjVsDbjk7QUEzrU4GsAbE2v+jKaf7cbtlfJA4s+1tRqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 15:15:04 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 15:15:04 +0000
Date: Fri, 25 Apr 2025 18:14:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	horms@kernel.org, kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 2/3] ip: load balance tcp connections to
 single dst addr and port
Message-ID: <aAum7Wj5rRuwzGUp@shredder>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
 <20250424143549.669426-3-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424143549.669426-3-willemdebruijn.kernel@gmail.com>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f4dede-49e0-4219-d3fb-08dd840bf46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RiY6K1qfArCMt8iTc3JAf6ttW2pUopB4mKhGzM7yLMKPlWVDBF3Ufbcpt1CO?=
 =?us-ascii?Q?P/wumMwducQS/NfXNpzwOf3abr6dWz5Xh3FyNHWD1wjKK3+Qry7ZJT7duO7o?=
 =?us-ascii?Q?DJQ/bcA8L1wdFbDpVszxcffc1cE1OTjr3SMHz1g3oHO7ks7VA3O/gFZSLtCp?=
 =?us-ascii?Q?7Z7B9bvmrWwo31J9XnWjYUmJ5HCYK8B+BQQE0xFYhshkCE9Un1VQPISWV9Gi?=
 =?us-ascii?Q?DMGWycfEAj7aX9YX1hpoTQnarUorjBaGmSBH7QuPGR9Ed0W13zSQ0u79NrZ3?=
 =?us-ascii?Q?WHAB4Rn3xmAW+s1dpuGfC45TBvC9ztxkm4Zo0YOt18CsQDV4SIv8NfVqWtM8?=
 =?us-ascii?Q?HB0YQjLr0nP7u/kqo1MeYR4xJSkZQo3tTYONROK/pcuwqZXsRN+KaEKkc4ja?=
 =?us-ascii?Q?jbpe/KkCUqz9j//ywIJ4I2/cf3JjnMWVYAtwIg5qWWUUE/8eSGaPtY4VuAcc?=
 =?us-ascii?Q?Q58LfEg15IabXnSV9/k4y64maWx1GBGRLCJ+shdz3exco0jfQuVztzG8l0+c?=
 =?us-ascii?Q?sXLznHeYIq4hXKcr4YqncYg/hugfvCilm+n7HsvhsNhLh6xGf1RTJ+8jWXq0?=
 =?us-ascii?Q?6Y/SJCntYYHNYG2HNTZGP0swwKuhDG9ImCtv9dKygt2utx/+4B/xIPB5OdOM?=
 =?us-ascii?Q?bqNP5L5op+MwKNGfA33a2/IXCLfa9tuagWTCGnN79Ux4tz8PW32E1z7RikRq?=
 =?us-ascii?Q?It8YQy04oCleRIVusSFot5ZpxGDotnLStE/Z7LnmVvqyrRTSBbtz1opQz+xc?=
 =?us-ascii?Q?7dmD/bOYfpK3a8vk8DuxAy5vDduc1+NmJvAdqr/bLR/OHdfCEZoWmZhU89DW?=
 =?us-ascii?Q?mDOgHSlnPRg/4QvwK0Cwp72JiBWoCZpQ3kmN4AWejCrYAPLAoeFtevO9O23w?=
 =?us-ascii?Q?v2/oNZI/eJ5nF623V3QpzlhdXyr2i2HR5ZWs1EYhQRYL0Fl2sMLO0bf8o96L?=
 =?us-ascii?Q?lSPecDOEQTqEYqh+t9li0owKqSmUjTyzFZkpXARM5obmdhkCMd1WkhSJneCh?=
 =?us-ascii?Q?6dceIlXttEh/ZF8rXFl1bUkSMOKSjtcV1YBh02ACzO4mk5/2rt04Znm4in8s?=
 =?us-ascii?Q?XiedsisWST9fPYPSeecUMEYw+KfGLrPZL2QyzfJ3VhS3kFuMrfTgAXpwVC1U?=
 =?us-ascii?Q?WCR4BQkSzYIqlbiyJUKoX3S2KOxlM/sGgL+DZvf+G+PibCTd1wIAwxMFAxir?=
 =?us-ascii?Q?7YKz15ARAd6YIGYPa3I2ZdEPhVfRZXWOOTjF0fYca5qZvETA1W9YHcc26V5u?=
 =?us-ascii?Q?8tb/hZGi/TOHPaEeBjG56abPo4bbyPYUkQyl8OSaO9lONOVLnRNxPQvxZxuF?=
 =?us-ascii?Q?WltxeAQ3t+ieF52x37UNOR9kOYiU0N1NSLZpIg+NfQHRHwA+zviQvJrunCBZ?=
 =?us-ascii?Q?mlofCJNTZ5mTQAr2p97l8jBTiAqLLIun5LHeLrYPtQ3bnF3ZsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKQE2NPlhSax5ORwM9DKILpYQy7g2xbZ1hUtTH/68kukC7dCxRPIaIh7a1sC?=
 =?us-ascii?Q?moEzNDySaThyymtxtEBIMSLJNMG6cPjmt9JYuPXKb1DpxZocVOANosR+hgCV?=
 =?us-ascii?Q?BbLnqVF2X+f83RKDcJnTsPPmz8pXSBsC71vEesCCsCSVYDSPUonvVXNT1dmy?=
 =?us-ascii?Q?7esq5lIaVmi1vQJaUTsSkOdBIs/Z0kxlCbdLpNPszhbB8D36PNuoEn+4q1cC?=
 =?us-ascii?Q?O/YrSwX2b5bUnA2RSG54LOechK44bDj/nAIPex/Lm/IBjZzLVnuRLL4mGuW8?=
 =?us-ascii?Q?kkLKSpvkk2IIbXXom48gGrHLu+DDksVqphCKKa4QCD+LZmSYcO3uAU6TeCHV?=
 =?us-ascii?Q?Q88VQH8aBiA9NroHzRk0wY3+HFJRebWqk/pSZL89k5S7K7E9Pnzy5g88haoF?=
 =?us-ascii?Q?uneFJvuCjZXTdgqhpu0mdfKjZtk5pbd3ghnWJgOlUaXWMtROADyN9OfeFuwD?=
 =?us-ascii?Q?3aceJF/4yA73xx8+WMYCX8XLFLazkc3IttNSw7mrBKGBjyUuzXrk3h4GO2Wv?=
 =?us-ascii?Q?mPlYhLQzBVdiNsspWDxgtvVa+ROke9lo2hLAVH3I17FNxZKRxzwPloyBXd0O?=
 =?us-ascii?Q?EO2fosnXY42bF+sM7LKN65nzJcR3dWLy8TWQ29+7CvupqWc+9gPs66no2tP9?=
 =?us-ascii?Q?bwzaVoz47GJ9U+kdxVLobtvqVMj9n1g/QuuvjGkAdeRRZEdxhvhLfx073cBe?=
 =?us-ascii?Q?m7S08Rm+J+RZGzKo9vdrZb0oW6lbxNnM4x3RGfwXHXHwIdyOH2WUeJfJY11s?=
 =?us-ascii?Q?wJC9P1BumDE5qfgQzfCg1M5EWg76PHPgCgLv8dZi7xTfhZxTqTVxtO7vZqeQ?=
 =?us-ascii?Q?xkh07lIxn0/6n87vw6aR2cj8TqkRU+t6kbvdIHjbYMJT+h3Oy3806JMcWXhg?=
 =?us-ascii?Q?6gJhs+mlvWD6376pkWrRp/s92wvbD34Y/3Q2dPEbFS0CF/Oq5WoXSsEnrNxP?=
 =?us-ascii?Q?zQL1sqTSBSvhlUEDJ8PBV1YJbvUGmVo4O9XYllopHAkEVV/W8IHQ0IIBYekN?=
 =?us-ascii?Q?TS6jdxvGl0gGKzeh+5ZQTG3ZP1lwf0C1sXjlykzgqT5RnS465qaSAsJ04ufT?=
 =?us-ascii?Q?0HtQPOoG4mTyb2KezX/TI4k9CWH7QceZsyTCPdF56q18WGyVvQzya0Oy5ULt?=
 =?us-ascii?Q?iZmxheXckaiTS+1r/ZAZlWfafi7aLpcbzzjybNgid+OzbeGRKJq/0cxwwOhq?=
 =?us-ascii?Q?WAeF356Tu91AG9+SV7DEs5aR5ChSudtT2VMY2tTRT90/3e0TR+CnIz0oBeAb?=
 =?us-ascii?Q?Rj418uQPxwW5NKnNGFKaKF9tO0Gsjo9a7ijIbLhr67/1mQM7vFsGOt9Pog9J?=
 =?us-ascii?Q?HCRnXygP4ol+Btu/t0ARf1KabP/bOf4r/QYw6KfsYeNdqA2PBTs+JpInS3Go?=
 =?us-ascii?Q?dZShA5lM/o2+0cYdGp/h8C3Zpl16kNbZetq+fyIaYk+FBGhrPWN3pXta14U8?=
 =?us-ascii?Q?QrtP3dGhlh1aCWSCyvLICmGudjZmuYeW/Owc09KZrM7iYFwLU3GajFO+cy6M?=
 =?us-ascii?Q?8v1Gup+Unht+4w+/z8V1nb2BKIUNs7eBtmle+h9kcjPEPqY2DuR7jjcoBEyU?=
 =?us-ascii?Q?72D3KfUgRvY4Nd3B6VkI+rFgg4WF5ZxqxCrL3yno?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f4dede-49e0-4219-d3fb-08dd840bf46d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:15:04.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGlt71A/RHpi0J3clJpkcypOz5lDJN7AThQCID7dLqVU963XumlF7QyvNW5wHsEpTV1P5N7SEB45CMRGpmKm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595

On Thu, Apr 24, 2025 at 10:35:19AM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Load balance new TCP connections across nexthops also when they
> connect to the same service at a single remote address and port.
> 
> This affects only port-based multipath hashing:
> fib_multipath_hash_policy 1 or 3.
> 
> Local connections must choose both a source address and port when
> connecting to a remote service, in ip_route_connect. This
> "chicken-and-egg problem" (commit 2d7192d6cbab ("ipv4: Sanitize and
> simplify ip_route_{connect,newports}()")) is resolved by first
> selecting a source address, by looking up a route using the zero
> wildcard source port and address.
> 
> As a result multiple connections to the same destination address and
> port have no entropy in fib_multipath_hash.
> 
> This is not a problem when forwarding, as skb-based hashing has a
> 4-tuple. Nor when establishing UDP connections, as autobind there
> selects a port before reaching ip_route_connect.
> 
> Load balance also TCP, by using a random port in fib_multipath_hash.
> Port assignment in inet_hash_connect is not atomic with
> ip_route_connect. Thus ports are unpredictable, effectively random.
> 
> Implementation details:
> 
> Do not actually pass a random fl4_sport, as that affects not only
> hashing, but routing more broadly, and can match a source port based
> policy route, which existing wildcard port 0 will not. Instead,
> define a new wildcard flowi flag that is used only for hashing.
> 
> Selecting a random source is equivalent to just selecting a random
> hash entirely. But for code clarity, follow the normal 4-tuple hash
> process and only update this field.
> 
> fib_multipath_hash can be reached with zero sport from other code
> paths, so explicitly pass this flowi flag, rather than trying to infer
> this case in the function itself.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

