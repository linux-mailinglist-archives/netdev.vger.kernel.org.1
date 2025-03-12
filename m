Return-Path: <netdev+bounces-174298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C538BA5E31F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462E93A58C7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20423F369;
	Wed, 12 Mar 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WpdCmFbm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF001DED52
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801827; cv=fail; b=hLDletA59ZAgGV0uVATRuLg0hoO4fPBUms4j5KWRvwuJ1MZErghg7wy6tDEMtY1GuMzTX8mD5jUdDr1izE5VPhOzI7Knr7fg4TfKoH/42nltTgd50nUmU0sRwZiX7r2MjhX86mZN5SNRnd4yOs5rFj7w9ziKoSr3RCb/RUIxLtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801827; c=relaxed/simple;
	bh=FC9pUxjth36dcslumndf6fywdieOXwn46dBnk0yQbp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lVDDQTPNw0v+Of1E2TrL36U6hO2clhpcm5Vc0bYaQCVxjbjE5Y3qbEf23wR24gus1mdzTGHYyvaD2PVlH2744GzkXL+4zMKCia7+13q5eAcRNVJSeRYlJHfr7XBcZComdpHdcMyS9vDgR7LIPJB69O7u5W1B7/aANhZ1MIsdxrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WpdCmFbm; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRdDtPmc+WE5v0nkZFO4nTdAHJv+7F2DZF0iU4+dQz4fk0doHz7sLRqmRajbVAyU6BU40dwsjxOzAXs0dH3VcMJlaUvrWUOR5LT62NVdrWS4B9JXtJpX9jGkYhW2tftrZrhWatYpKSLUXA7L3sStPah0wJHcx22FToj7tNUIaZDbzNIAkiXjppGua6YzN05inM1agFypmQJvbxx7phlC461ToXCkKS2/nQgREpgHOLZrVOU4GwOShb2VOtLhPgIKzpIFRCn0wqWLXyACBh0QKSunikZIuPvWP8MlSuM6tpYel5cAq2EUS+2usnsNGaAZupFfJl8khVQZClLE98wtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tnPJrpYB7sOyI6sxbyErQgyu6SISEfuXniKrcgcd0E=;
 b=aF3YdAjdOT4ESpw9wXuyfzsBfCtczgqB4OoUYQZ9aeaoOCVWzntc8yqt70HAf22nW4s4xzQh7M+fFz+Mn6I60LehTqXjkDR6Wa5Ml0csq4/I9tHb1P+aXMI9cTS+30T+mBWKm68C6Z/paDOhR95VDS8hELEfmAmz7D2DjUXKTofjooJg97nYxm5pvf4ONn+o7VGPGrwMkc+6Ezd/QuekI/iycPoW3sOclc8UgvyPkiWxp7xjI7VsYUOr0C21j0gvjFyZ+tlzf4Avx52yByZ/YlQBAjnmXWOwxEp/CRrX5dJtB3olzjwGsmtHP/yxOrmsXEUmul34c1Zdmiz8DGCf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tnPJrpYB7sOyI6sxbyErQgyu6SISEfuXniKrcgcd0E=;
 b=WpdCmFbmUYUQtIO6ymk8uzd1F9UNH+kSUD3/obeTWJgMBUbnLReHCrxCHcHG+ncLQF4VOt3pW81/aCokk+UouUDhpTCatpmtg8u+pE75CT0oqVN0e/mwaF69Ihed02f/6R2koFLW1ixxV6Y8gKXEgaTvTVbOE6UF5CDu1IznVHO5n1jbOajeVUilSkueg6wpL9wbVjnaPbe+tvRHFXahSiSRK8iKe3fwbBtWxjPv1RnSpPy91dR3rso/aUUN0Tiiu67O4ccuVaisYW8Pve8lpz63qvUm4tV+YsRg1yJrgLXJffssxt9OuHI9xSgABucLfU66PDGbj2APRRjuJ71K9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 17:50:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 17:50:22 +0000
Date: Wed, 12 Mar 2025 19:50:11 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: amcohen@nvidia.com, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, ivecera@redhat.com, jiri@resnulli.us,
	kuba@kernel.org, netdev@vger.kernel.org, olteanv@gmail.com,
	pabeni@redhat.com, petrm@nvidia.com, tobias@waldekranz.com
Subject: Re: [PATCH net] net: switchdev: Convert blocking notification chain
 to a raw one
Message-ID: <Z9HJUx4mnGKLBZMn@shredder>
References: <20250310061737.GA4159220@kernel.org>
 <20250311081418.12713-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311081418.12713-1-kuniyu@amazon.com>
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 514b936f-38cd-4fbd-e0e4-08dd618e5c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MRlBvAvL/EroqFMnoNpylUsIFR9v2mtQli24nmvaUglweszUvDTRd3RGJczu?=
 =?us-ascii?Q?4yKwqqb4XJCqmKvqHJeYqgnw469tQ1E5qxxdR/0PXQ8ywonsa6cQrAUyEHrq?=
 =?us-ascii?Q?GQGJ3ma4ml3T7uyRwnYXw5rbrPXZlPNxbuerr5kaVSUuE+fyImDyHIIkgdj5?=
 =?us-ascii?Q?d6hXMYCeVNzNylJSmKBK3de/r8ha9hdwBRVQBYNIHJDVj7k163bIMSStqKVo?=
 =?us-ascii?Q?8MgTc6FHGp3JyNuLNacsEQO59SXBrlOByrPgdVcW3+VL4Fs9cjQFmU1CBSzw?=
 =?us-ascii?Q?JsyWh5t4XrtVAM3F7/zawFVKzFH29gN4/7WV6z7xiInEbNn4DFCtUmTb6gFN?=
 =?us-ascii?Q?OwbuyUTG3Opnh35kP3yB1RwtTTXeetwFms8bqVvaMCot/YlK56IkWfYrf5dg?=
 =?us-ascii?Q?4NL8P20J7Wtzkc1rcr72WnziJXAE0XPGc5JxFKhwWzniKHGmquGVTQmRO+pI?=
 =?us-ascii?Q?Qg6xGjIqimp+PJ4uOkqdI99JDbTBYZw2rjlSrDc7yHhOufrize7Tt/6RXTEP?=
 =?us-ascii?Q?CdR1gDl1cCkujUlSuE0jqfQ+PBwwynXdGHN4iUJTQPqpAAVTQ3qZX08lJ9hT?=
 =?us-ascii?Q?rpeZhE4ikdHp9ZcnQurpkPpMD18mtV8ovHZgYaopdswWynRxxypk3G7gDmCL?=
 =?us-ascii?Q?K0zfWUD5i3hK7KIrtkStHBJ8Qh4GRKwfbQ5JvoQz1c4CJixKUZ1oWzjB6r0w?=
 =?us-ascii?Q?73z1WSIpwyQ9WhvePEi0nqnMF1UECS4brgHh2E5ha67OE0Qy+keoOBXjsfdT?=
 =?us-ascii?Q?A3beLO6kkmYfeLZ+DQNZ33oprdC7LBGX2gT86hC9VyU4f04CR2Y2d5/0T4XY?=
 =?us-ascii?Q?tZHH489bQWTKhsyZ5oXYkeHNzymIKk6e+MDbDjCdr2nwX/uXog1HYw5fxqK0?=
 =?us-ascii?Q?fqD7777LMjMujl+gmBj+Horf2ryETSIwUEk9Olcyt7CS/LENY0S07xy/haCh?=
 =?us-ascii?Q?/Rk/er9tFZ1hCKP8PCyFMC3IeI1K08l0Pu5AGZw+1zLE9sgRVPSmnLNWP7hc?=
 =?us-ascii?Q?BRKPxgv7Bp33qx0/5It4Jla4Js7YlNQFnDBDA9+HRbvXSESvzRiRv4ml5CVX?=
 =?us-ascii?Q?KPvd/uIf/XE3IjkrIBQmoKIJ5AiAYDgIQq5SbuFgaHgLBdP9a60Xgvgu5u/f?=
 =?us-ascii?Q?n7oPJo1kpKAhT65BBF4/aD3kO8WmwueNINNzgUBDqAiMAC38HQkjUr1i+R7+?=
 =?us-ascii?Q?XdSwURow8vY8mhCo441f1dgwV/R3GmXfXHvbxn0XZ9FPlAJ5QIKEKE/ZfLjD?=
 =?us-ascii?Q?K9rQAeGqB1RjdKNbQt5nCaEshynQsDvSnkYFGshdT3Tmi38x0vC5VF8MCcgw?=
 =?us-ascii?Q?kIPyqQPMeIw5p5Y5DdXnzgIgBMUDCxFTQHCZxIjlfgAuLVPx2EtNipxHAkDO?=
 =?us-ascii?Q?ermsaEpSD15gmrJX1NI5UCROGmv3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5KyTw3mKKQlJqr3Eya4/UXCAzIj74xw1nIN+3w4I2+0OrBmhopAHxH8SB9U5?=
 =?us-ascii?Q?2U+mfrY06nUy7mDQgXH4Rj3zSFOG+DTC8tHZtf6APLu8jKJqMwy0ng2itP4+?=
 =?us-ascii?Q?rPYmifKqOXBrMlo8YvSRXaeJ/22YckzgC49kU0cNrOjBHuu7F+KcA/gNhH9y?=
 =?us-ascii?Q?r61/CF4WFvqH9CH5LQ6/iIafhY5AxbWn89v6Dk4k5Jbnu5b/+acKGPcNDIph?=
 =?us-ascii?Q?TseB1iT/nTwvh7dE+CYKGQUb9s48hOfhLe7SEEOYP4fvTQDj4qWxManK/eJj?=
 =?us-ascii?Q?e/gRGqNZX5nOP19AelxQk6DZFZLR0eBoHMgK21+vu1UFbJikJAOQL7mMHwPk?=
 =?us-ascii?Q?Xyi9hSqERpbvCd4GAzgtF2gwrXW9D5iEb7Zz58DxAXpgSRp3AC3ItxbcvPmq?=
 =?us-ascii?Q?tZa4Z7GzxYGcasS5Y34ANzyXKDHk+OYZqvCgznu2pKBXnTfQXp8DQ1z04pK1?=
 =?us-ascii?Q?NUYhBQZBorWQM6y5cXajjyYAo32lcwd0F9/7zfzfVOIcWIoJSY/4mPZhhNw2?=
 =?us-ascii?Q?EnqOICNbloS5rvani2+GNS3adb+TsHVwqgalLvpRKFakYlyv6XueNIfaZz4N?=
 =?us-ascii?Q?z9JIjaLkXFm9up0QoGCglDhe9yuuShpQjKMkXJ6U5vvARDFKOJRfGcbCyTXf?=
 =?us-ascii?Q?Box6krH54rTidapiDvCVsyyfCJXPgCcHkX8vMKr4eeYbK8imsBy309WZDDTV?=
 =?us-ascii?Q?g86r2NUJtS9s/N7gTLwZ5Fcgu/6LCAN477cIfdz6n8t7fJdvroUY9mIRk5Ye?=
 =?us-ascii?Q?/aCV93FY9i1t6h4GEFf65OqccDP7kBgVWN3eOevzgwrC1a+JWvrmbPpgNVcP?=
 =?us-ascii?Q?Gsw7kWwRBvgsmcQWOYI4R21n9aMhOFMCGEAcNaW9cFQYByCMVQi+AOtndys/?=
 =?us-ascii?Q?zWOADje1N5cBFJmrfdjTw7eknWi3okytB+c3+QHJFGnVPbvhb8QzDBJXIIJ1?=
 =?us-ascii?Q?dQBhepX+kqdZX8Jj9hBiB1L98jcmf8RoLm+7tIn9ToESKuiZidFFxprmiW8d?=
 =?us-ascii?Q?GCI9LkPuzu6twtKhYW+0bGZhaw8r20L0DB3npVTqa1UMEOSmNfNkrptOX1dd?=
 =?us-ascii?Q?OKj/Bg8ogiC4U6zW6iNkdj7Zw1MjvXJbLUNsSONhuReHQVv2WwSQblQOzOT8?=
 =?us-ascii?Q?oNdJ3DL77Trfl4q5AvCWnlTw5PdkitNkz4icyzWz6XSz2WXs0zE/OrzOy9OY?=
 =?us-ascii?Q?Zq+qAZnDb/yQEnTm5jtT6FDPsUZdSNj3/4mfAaSeJfaM/jyQ6/55NBmAAwdX?=
 =?us-ascii?Q?J/ww3TwXHHa5ZGq+kDORX3z4CixQkX7IEEe13XC4O2dE2hX5iFWZCP0t0htm?=
 =?us-ascii?Q?hfVrrYdBQSaVZKryvA2SjPzn1XUMdTPa1c3GdFrILP+600yAJGWV9oklyJt+?=
 =?us-ascii?Q?9Kuun/s70DHPPCoTUJOjrU+C8MGoKcdsGcb+DHvqZi5MFSk9vzcqMKaMihd9?=
 =?us-ascii?Q?fSrM3B8WlSDVeXcasCkEdG4YcWBA+EvL/3RBrwdEm85Mt/RF3Rv1zIF6kB3R?=
 =?us-ascii?Q?vuTuSqJjnB+77bpn7KwFIn+LIpoMt05bFS/xoz3MhNup8ZzoOoH31us9AFhK?=
 =?us-ascii?Q?FhwEK1Gb/Qd0Ug9gX3RQgUfVNKQ5yXIqlyPqCBX2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514b936f-38cd-4fbd-e0e4-08dd618e5c63
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 17:50:22.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4HnXN6yY0h87iNfIC5+S5BWJuOs5x1B0qC44mmVrpS3IwKf7+MlNzyc/NxSdk49GxEO7NplPhKRQMMcGUliAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

On Tue, Mar 11, 2025 at 01:12:50AM -0700, Kuniyuki Iwashima wrote:
> From: Simon Horman <horms@kernel.org>
> > As you may be aware there is quite some activity to reduce the reliance on
> > RTNL. However, as the events in question are already protected by RTNL
> > I think the approach you have taken here is entirely reasonable.
> 
> It would be appreicated if Amit you can post a follow-up patch against
> net-next.git to convert the rtnl_lock() to another lock or rtnl_net_lock().

We're obviously aware of the RTNL related work and we thought about
making these notification chains (atomic and blocking) per-netns, but
it's not something that can be submitted as a fix.

I will look into it, but there are some listeners that I'm not sure how
to convert. I can register them with "&init_net" for RFC. Hopefully the
relevant maintainers will be able to help with that.

Note that we will need to keep ASSERT_RTNL() in
call_switchdev_blocking_notifiers() until all the callers are converted
to per-netns RTNL.

