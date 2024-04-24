Return-Path: <netdev+bounces-91059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527388B130C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 21:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D570D1F2651B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734401BF40;
	Wed, 24 Apr 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TqownZyK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1C1BF2F
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985202; cv=fail; b=cMtVNt+9oZFPADEWeT9ub47K/e24OCATXOf3y2J4Xytv4DU4gQuBxUu3NOtbLOSJwkus8Oh0sK5Nul/OVW0SNgnGtcmk5XBEOtjhfu0HHqNeC6hCR0IuURo3XkRm1ClRNr1vSA3p77k9a8iDfNJQ1DZmhAwkfd1G4gshsCs6I54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985202; c=relaxed/simple;
	bh=gGjHJXOb9v8jFJU0Uxel8j09RAEgCn0GAbxaVabizg0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=vAkelNAk+Hi13Oz4eRdtinyXKnuseUHH1s/kqfUwihmOsiZmgeZ37H6HOHvoMNM4AjlLFdN/gahYVUcOuflz4j0exrauyqjfJc3sDJMvt7rY6GDe+qG/EcfyJN8ONJCVzPARi/EAY1YHlG5TjABmXBC3yp18lddBIQXl19z5bOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TqownZyK; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlAdwqV5oKpfbZFvLMx67uaaxExS1jzYmmhjpPcP8utlhvjRakfutncESzmvEsLFVg7A2i2YGZQxugvWGJOSUjwu0wvkEM4Qor6JLpZz7I+Ro5XCMTPIv0S1mqwFnp32XHWvWTbopwaHl9hk5iwlLR2ACk81azTHth/Dd5QhEdiZ8FHubSZiEUBhczx61KIyqFQwmBHUI+tHUAT2xM+ju996cEZn82GGU3oPoBV/rr88+q+DpMKAPi01aAxOe5yGwBVZV2gxpj90LDiEGpOVZcz32D01jAHHpTSLg4/99N3UuFWeO8uXayS2quXzgqXyr/ySMygRtMaWjhR/ustO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXZSGCJxaNPkykNaEU2Jko9AmQ/rKJve5NmzPFEauFQ=;
 b=SNCk6I4afm6z2lvDkPLrqmU1ROyO4cHOxMzPZgGNT8hHdNWxXcrSLbdL0TvNylxYO/Ghe742VCejnnUEkuHYP5jzKyNA2phys/SValpXhRF52XQLtR8KMEG+2bx5Pbl5FkAS4OhGP8N/cO98GFr6GmgbgwihIH0KQ/l3R7NAzYEhkSfxnsSYKmeGpIJQbh8YHknpMSKkwB/BwRfmwjPosRwUAq14IyhWhXbt5EwYCMNrNg0U+gnjCPLma2s67TRAcVbFqdCyUo7yUOb+VxfpnE8vZIb2BROyDH11SQa7B9p5O778WHxIDUMwtUsF/zyhP7DOuGQM66+xPfQZq9++aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXZSGCJxaNPkykNaEU2Jko9AmQ/rKJve5NmzPFEauFQ=;
 b=TqownZyK9PQQjeSoScsAGf0wKUbule3nD7oXFRT0DKqwZNm6xfqNm4MBq5LfXB3uLf/iO8LrTRF+hz8AUE0knJofCBW9ClN8O5UlBLQEmUU2IFuDAcB8qPn02RRWNwoPA27eVjMg9Ljb5/o4qDoG6TNhsGmyFbTt2PlBFfwiEwj7px5Iy+BRH7ppwEV/VgCzIbtKLnIOtoQAaphUE2Kc8D2dOM/d+4bZZdrTYeKrIg2QXFLmcSNNHnNSRiIDEvtBSKIcg+HYNMU2r3/+JcArduGp2Tof3ofdohHRUMMTONZXN4vqLbHSQ07A2keGAsCOawmuSJU9fmIc8CDqBvQ8UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 18:59:55 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 18:59:54 +0000
References: <20240417203836.113377-1-rrameshbabu@nvidia.com>
 <171338943006.32225.7031146712000724574.git-patchwork-notify@kernel.org>
 <ig5425idiwrshunkl5mw3nkb7w6pewsy3e7tbsewio4qnnj2au@vqr4ivgh67iv>
 <87edb3w56g.fsf@nvidia.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, patchwork-bot+netdevbpf@kernel.org,
 netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 jacob.e.keller@intel.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, gal@nvidia.com,
 tariqt@nvidia.com, saeedm@nvidia.com, cjubran@nvidia.com,
 cratiu@nvidia.com, wintera@linux.ibm.com
Subject: Re: [PATCH ethtool-next v2 0/2] Userspace code for ethtool HW TS
 statistics
Date: Wed, 24 Apr 2024 11:58:48 -0700
In-reply-to: <87edb3w56g.fsf@nvidia.com>
Message-ID: <87plue8u3a.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: f52624c7-a692-4e38-eb3b-08dc6490ba12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KFtJ45rw10XwuZfk0K9au3zFEY6GePQOKdUEhfctxfZuIDxZ8/V4Encr4ns?=
 =?us-ascii?Q?S2V2seuIhWTPlfvgH/6cOdiBRC4iwsT12sV8TaNB321PtHcEmw4/8+V+PHuE?=
 =?us-ascii?Q?sLPom5mDVquRsk+b8aFEBgVb/We8qTYiSMeo0A57R1JW/zr5q6xng8SrVqO/?=
 =?us-ascii?Q?MrG00NOMwaaab6F3c0V3a4TT+/m8pyIOJc5HViutaQFc/r2sOeoYIpssOKmh?=
 =?us-ascii?Q?2bMBeJSetP4lmgFMa9odr6d9rbOOMPAIshM+EKSudiL7rRzcRDqbdyFqLGqU?=
 =?us-ascii?Q?6f8k2B2Yav7lpaijGwKRvEzbfB4MRAe9FR9EZNmT8Sr+wf0ZmBRYrrC7LGt4?=
 =?us-ascii?Q?vQyajTWftZ19ignEigu9uxvjd7+3JRgAWa76qfXswzVPHXuoipL9AYDl54TI?=
 =?us-ascii?Q?YlKNekoM6KzBSjRVOYEDtyD7PX/kNqSDxV6njacvAFvGUEKkxgNle7KMuRuw?=
 =?us-ascii?Q?AIOOAnnIWWOpLUxTEpevvso68icrxNi5Nbl6Z/xykme2xbebyJI0i9cTQKsO?=
 =?us-ascii?Q?v7Xd0jNeStSqyD0mPMBbvFeLW3xrlKUesxEBUGzJjrhKCRzcCzeKzl6Tj1km?=
 =?us-ascii?Q?xtnYg3ohG3j+/iBAQXs2QZmS1YEPlBmepv8cuIZo0MCCS80PLCC2vQ2/nX7Z?=
 =?us-ascii?Q?pIxPqi2vfTkkSJY86tU7lvSGt90tTaRCk6VloPrOkfs0VnLdJjvwWlgFWNyp?=
 =?us-ascii?Q?vatWnIFA6sGbfvW+ksoWIhnSqQHfsSaZI/8/56YsysX5R0Z2Y8CM3du765Br?=
 =?us-ascii?Q?s9dWB+gDYe9ZDvPUB21jeCWtDKCOootmkmYOyIaizUHAOmXvpKIIfCBMqASw?=
 =?us-ascii?Q?vkFdFE7ShV0y4T/Gv5aJ7Yvn/dVbabLZVpUrDsdgXk0mI7Z8uHl9mGFQP3wt?=
 =?us-ascii?Q?ygU+p2c7fTo4X/vwZP+tjc2cxqwH9h+ICkbgTejdCEEEwJJJdtlU9d+2LZEj?=
 =?us-ascii?Q?C1yKb+y96wsARTQD3pl7jOPx80tPzj4PvXjofEIbTZ4E8W3iHDSAMiBSZuhl?=
 =?us-ascii?Q?tgM6B36Nmtqm31yxTTvFo4cN36jkXmU5CA0iG5HuB85nry2whTK2ZpJHXbgh?=
 =?us-ascii?Q?I1R0kl26bNGu3TZMNj2rj86D/4DxE1x5CglLaOD3oSA8E6+7TpwW9YXP4H79?=
 =?us-ascii?Q?Ym/fHa+Fgrm/xVrdhXxg7VX5oiua//ASzCnw2Oepweqi+OzUd645p8KT1CpE?=
 =?us-ascii?Q?EC2L9e55hnWQEODrUgiDDRmvwR3uZnG7oLjaofUW9BD+xyF3wHm+EuaD/teh?=
 =?us-ascii?Q?Q/AbA3b4BOBKa8Pieo9Rpp5+wvU33Vr/OwLCtQIxKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDMm81+QZ3/4EJ5WVQxSU2oQvfJcTKpdqZJQ0gifvDe1BUfn0wtaAoE2MmSH?=
 =?us-ascii?Q?QNBmeR7uT+Z4vFEpOlm/Bl85/S70InSL3U/f/kxuTGoo+fv2Q3FGD2QZUc4m?=
 =?us-ascii?Q?BTTbjDGrcb8ELf8qGn/EXLIGQ+R3b7+gI5tkula7jNw/SwSygUa2rzrkQ1T1?=
 =?us-ascii?Q?6HqW6+w65qEtoY0gBjM/g9HIh3bItb+ratscP2REcF1zi+siSlGUEM1Aycpi?=
 =?us-ascii?Q?UJIooWNHiHtcQLpaPc6I+8EkcsiifwCGbEPSU6edx9HX2U45+duV4UZSWR7Q?=
 =?us-ascii?Q?3D3uuWv9npuvQ3nTNKqG7o/XyKwWWk94hChq2gSmp1iS7fmrnZzMmXpD9bUD?=
 =?us-ascii?Q?X8+3Ey1s3d3qVlxTEZcqmmoA6xW8iMwQeZdd5kYVgUwc0EqAiHzUxmC4GwlF?=
 =?us-ascii?Q?QiNOftHMVHOLnfytK8DYdSqj0SVvDADA6s8HU2r+hxKsSC7/uN9cGCK9WZM9?=
 =?us-ascii?Q?v4gPbdEtpbw4IbtbrmTf/WOaQYHy5Lt+X7P7lXpIOMxrMpSS/cVsgjNYsVHP?=
 =?us-ascii?Q?xHNjkmOMxxTEvNga2epIgrO42Ri7APT8YuimekRqf8/a/TIVuHRjkoFXDziJ?=
 =?us-ascii?Q?BepF2xznSvw2Upwb+JbBWJ+wJIOV25iZBfY4TyVfCj55SNtGDBfNg3sooS5n?=
 =?us-ascii?Q?c/03821OPWKtNd7g4iP08PYLf9eXxL7O7VpoiKP/czM39og/yizNyjpLFprI?=
 =?us-ascii?Q?jF5Fy4DMB1uTRHh1QALIgE/ohwQI8mT0dMSQFrP00mrWB2vUM7mNZIUMtygs?=
 =?us-ascii?Q?EKNtG5PR0gNRRYUdcW+U4Pc89VCNm1Snm5/3GuKPM4oYo1Dxd0GWutx6plCX?=
 =?us-ascii?Q?Gfj3CYUFNmRhajmG5Ze5+GdYdv3i0kwvq2Up+lls2niYMhaOEP/2WYhd230M?=
 =?us-ascii?Q?LgRW6JhQslPzQmC4+FF3AsUd7yVbr36wBCwZe5TeYMkhNAdSESBgfYVZqxeE?=
 =?us-ascii?Q?OJPS6vbjxM2Q7nbfIsEJOGB7TEJeZj3OFHhUG2Y7HRhquITeqywzQMT6We8I?=
 =?us-ascii?Q?SisqpADALO2sJ1wkFllDmceZPEz+87BEKlj9c+js/ai9cJswhkQoGCsYBnv0?=
 =?us-ascii?Q?8Cus1R9Rq+jujLuExdbxnwnJl5QvPzdlU5Arjoe44Crb2GoV14iFeRYNm2cT?=
 =?us-ascii?Q?7y7wseDiqLhliICEeXrEsEMtrdrFzOujwyziD3qUFQ8xgvd7XLKLryMzXyml?=
 =?us-ascii?Q?PhpGTP950eDjpzq8aYCccVkjppLUDCS3Sdy6t2nZgKN75n5t7H9yMxOBcgXk?=
 =?us-ascii?Q?XjIidNieckeQ+9CbkqXAQQ025G3J327MDl9n5M8JEWKXsvjrgXtazB8IsjqA?=
 =?us-ascii?Q?Yk1/AqJH7LY+q45naHAOwScLoDgi6esi9dJ0KKRHu9jZXKc6yI2BnJsO6DrT?=
 =?us-ascii?Q?Owk32NmNRuh4wzikYNEJtcaZxVrcg03c1hlftcVjHL67vMzl8LcLshDKpFUK?=
 =?us-ascii?Q?nZTN8/wu65bTFZ04XMXu3gyWUtaFNJY4dUI3luYmsc1MT/NkhjBTkoQlOut/?=
 =?us-ascii?Q?SqML/bJqQJFbg76JnJupY0VNFTY4E1KvdbH1YalffU5mMwio7g7U/Zhdr3bD?=
 =?us-ascii?Q?XpRF3wHOllcYN85Y6HEhAop1+ydlb2sji0eoHerQeuh9jlfqRuo1rZ88YNJn?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52624c7-a692-4e38-eb3b-08dc6490ba12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 18:59:54.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AG5qYcMIdNvob33hA/T0vHlOibpCjjBOvyl8yD5e6Su2MWytKqHBkSBCzzwWA3U86B1N2ynrcCIykWn8VjkBgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364

On Wed, 17 Apr, 2024 23:32:45 -0700 Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> On Thu, 18 Apr, 2024 08:30:48 +0200 Michal Kubecek <mkubecek@suse.cz> wrote:
>> [[PGP Signed Part:Undecided]]
>> On Wed, Apr 17, 2024 at 09:30:30PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
>>> Hello:
>>> 
>>> This series was applied to ethtool/ethtool.git (next)
>>> by Michal Kubecek <mkubecek@suse.cz>:
>>> 
>>> On Wed, 17 Apr 2024 13:38:27 -0700 you wrote:
>>> > Adds support for querying statistics related to tsinfo if the kernel supports
>>> > such statistics.
>>> > 
>>> > Changes:
>>> >   v1->v2:
>>> >     - Updated UAPI header copy to be based on a valid commit in the
>>> >       net-next tree. Thanks Alexandra Winter <wintera@linux.ibm.com> for
>>> >       the catch.
>>> >     - Refactored logic based on a suggestion from Jakub Kicinski
>>> >       <kuba@kernel.org>.
>>> > 
>>> > [...]
>>> 
>>> Here is the summary with links:
>>>   - [ethtool-next,v2,1/2] update UAPI header copies
>>>     https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=d324940988f3
>>>   - [ethtool-next,v2,2/2] netlink: tsinfo: add statistics support
>>>     (no matching commit)
>>
>> Looks like the patchwork bot got a bit confused here. I accidentally
>> updated the UAPI header copies to the same mainline commit yesterday
>> which was probably identified as accepting the first patch. But the
>> second (i.e. the important one) is still in the queue.
>
> I saw this but was not sure it was intentional. Good to know it was
> pw-bot hiccup.

Following up since I noticed these commits have not landed in next
recently.

  https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/log/?h=next

--
Thanks,

Rahul Rameshbabu

