Return-Path: <netdev+bounces-91004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE6E8B0E20
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B7F1C215F7
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F815F41C;
	Wed, 24 Apr 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P3yIPzc9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E915DBA5
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972497; cv=fail; b=ejNBmKysUiy1Af+nwhLV0l1yjouMYggHyLFtb0/Bz2FjNS/6qph2sRcrFYH8bTMv+GPVTTwpP4Nv33zWOwkOTg5WfsK1IjLuC6lON6kCP8Ot6asy4Ag18OlUz0qCmlHQGIBr9RuCj9Bz28dXPdzc1UAMDVOFQGbC0U3OgN9IcUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972497; c=relaxed/simple;
	bh=eaiTQtXdpbNCDNcKQ/Ydl5Wj109pA+Qo/RtM9bWOskE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5jxLE39EDpxO6PrWebai3Nx3bQHJLqrMy4spebumEokmIbOJ+W5BFoBHX497OwlyMT3ThCMBSVzVph7q8DwEc+pVeXS9NgCm9OCPRmAbSSo8w7QWeowUeVgRp4YyQdp4T2w/hwVmSFfbUsloiwlhNjg8RKc8avQF1KujSmTThM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P3yIPzc9; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvztfwdMMWKqweksZQvL3LKNhmg/VhG14nfsRnIYD/q+eJkHk4QwWVOUCCWJg/5i5MVtWpnH9zIyiYRVYkh2gB795+LhiSLvenYd57y4hkIRjWdDnmevyZkK2pNaxo/qCup0jd8qENbY6VT8CdEZvTmNpsl/LWXWktk9YcbeErc8b8D+Fm4HY5ZingQVCzMH9s6Vb0gn6OwA3xu5I6yhQvP1N8cGJkCEH6b3o+5ZUWZjF9s4SvqnhhOVGbO3qAWtUkMeTU8p2p6RKuEIniEPNl2WsOcZEFlixAwSjUiUC/bpWoU3jSKp41eexO44MdN78be2TAzk8dkHTsOAXk5VOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUflIUHPF/pseI6QkcTGS7brzIDllXI0SLfUOD51fwc=;
 b=VPHi6pJ4jB/NSE9B/EI/9k+FfRslAmsaE4dHfcVLU866zpjGpWNoA15ZGszKXkMk7aTb/YDoWdPpQBTzAuy8usb8s+nTO5lFW8SM3ouPNrvZ9GooVDjBKkE8ZAhvsZLTcqI5tJoXIAvsPrhR3SZUr/9t/I52/j3TdlykT3GPwB3pZBpPf51qUu5Rhl8qMVtoq0Qup1LuvYXWglfmAl6uMZy0iKP0AouOEin7XNriGD89xBWxZx4qmxA6Jm55D10OcqLXQBtztlrs6ogs8o7BG4D/75dYlor6e6pbddsfc0y5aF9+ubN4JTgudaAC2P8vkATLHZjuuCT/c0soQLsCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUflIUHPF/pseI6QkcTGS7brzIDllXI0SLfUOD51fwc=;
 b=P3yIPzc9g3jJ/Em18NU05X+srSCq26isP844ohiyru3uPd0aGmvv9EzWJE1P3dMKX9rqNNTXwU8UKmI3c/hAoxJQe1cB8EwApVP5caOa/ApBdCgxK1P4kxds3FGWntmPspofDTHjpzPu9xW1AlFR6HS5tKz//g9r9m51eOyNo3Lvbqfo9q+sGnC7xF22EnRWqHSnb+9HpOYYm2RvaAaEf95GLyKFTD1y/Eeur7rNaSPUBAmysoJRxBDlbbdY37IX94eUEdJoYLvx1HSAmqpogM8RBWXD5edwxChuuAv/X0jilDzR62XK+o2/TSy8PrfcBDkBohHb0S1kCzGokYa4iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:28:12 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e%3]) with mapi id 15.20.7519.023; Wed, 24 Apr 2024
 15:28:12 +0000
Date: Wed, 24 Apr 2024 11:28:11 -0400
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v6 3/5] selftests: forwarding: add
 check_driver() helper
Message-ID: <ZiklCxBC_d_Ssqjm@f4>
References: <20240424104049.3935572-1-jiri@resnulli.us>
 <20240424104049.3935572-4-jiri@resnulli.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424104049.3935572-4-jiri@resnulli.us>
X-ClientProxiedBy: YQZPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::15) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: beaaafd6-0b6c-4d56-b9ba-08dc64732775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gI/Xz9IrK2riMCa75cjhe00GjLhfB3zdiONpa0WiCfUj0W96txjnME8ibPeW?=
 =?us-ascii?Q?Bad4t/Wyw1k+y1i02S1wUEdM4cjL8bF9osnGvYSzdlsruLzqQc7WBIXjWbIK?=
 =?us-ascii?Q?dAfuqVYb4WlcIp5J+AouFlC13lIEgrXBN+1MsH/rB1xnLQegkTcezBrfQ0vz?=
 =?us-ascii?Q?dTOC+nNlzJ0yFpuN9W8v+rWMzccTDY5PvTEZ5wff69eAB9g/TwATQJCk72NE?=
 =?us-ascii?Q?17jGxi9XUANTsKhFTF5II7Li6unoXFkm3qFVInHYcHcjOEggt4738OlhOsp5?=
 =?us-ascii?Q?YVIi3aZrVP+O9W3FmTFnEl71/w+a2+xBO86zZs7EfLrKr4PYT4+A08sYRPhE?=
 =?us-ascii?Q?EE0IoxD/qFy7UoryaAHw8CdGqFJxhVntLTQQQXnwk9nmo3bz0cimy6knp6d8?=
 =?us-ascii?Q?RQmFn/g+mChKJY5FRt/2pPMMfeY6m3Hopi8Qf1uoIywziYbOCZyk36UoSG2e?=
 =?us-ascii?Q?Bx1roo1xjrS5nR/RVGOyuCyyZQGyF4wFQ/66pBic3xkFFcwY0glhacXLfZEz?=
 =?us-ascii?Q?XNzw1ukbXNGRlepOjJm3e6EO1nbvIXTuCEv2WkSDVbOVtgMl+0mP129oY3Q8?=
 =?us-ascii?Q?LaXy9SztjIAWnZpk7BQd7kFHoElziqnm6agBN9thfahVMahhy1c885TEnzyu?=
 =?us-ascii?Q?4L6YNvoIidkp0uEnJ7BLDF8lg7g2lTOtbqC0CgugnF6XpaZdKZ2uoxtfDtVk?=
 =?us-ascii?Q?NuvF3EJG4CTBzShL7oz66Klo/HlBHoqaf859VhYo3N22K2ihmUQkBf19os4s?=
 =?us-ascii?Q?VX9RhYa/shoNjvuGgAzdWULlXoBVMhphih0APXufSxnbpE87g6jezPUdp3xB?=
 =?us-ascii?Q?BzDQuWADc+3xSCV3UgZYBJk/nRFMTt7V3Wcge2H3VTZOvZXbpxyahXfRdTha?=
 =?us-ascii?Q?HkEZLDQJWcfe5WXeyy5A+3P330psAcR33R0cwC7SXSyXLhqWHIv9SOAa5C0a?=
 =?us-ascii?Q?/rhbHxrdTeavHhUDw4ETI+9lAPD17VmkXL0lif52vuCoMkn2VxS7wLL80dzW?=
 =?us-ascii?Q?534FMAKoMnBc6axDLFP8XzV48bvPe7JO+8TT+h0i9gKaed2Yilp3uNkNb3Mj?=
 =?us-ascii?Q?NazWFL/bpK19J7Ob9xbe6DqLPeOEKH7NJqGBMXFiIo9G5WfdsS/RNVNp3Bqn?=
 =?us-ascii?Q?E4EIkoAeL51yySyZSZBET0T5U8cZcjQtExlmP4ciyD0SSatLtxaI9TAGFiuK?=
 =?us-ascii?Q?78kqaA1s9suWbXLnUiWeS4faBl7FneznbQXChNA3FChSSODhjvC02pgbRlvn?=
 =?us-ascii?Q?CdVaToqI756HEc3cst1InCr1EUK2DqntB7tH3h9NtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Fjq6GJcg30yw6Kw+ResXDvhD0clmY1u5l/siFv9tf07x2TSGH5ID+a47LCv?=
 =?us-ascii?Q?CGCrWlvS7kOUmLoOx/qXSBqKYja1ggGo78eGBlP9t/GGghUpGFQDXlVCjKA1?=
 =?us-ascii?Q?bjsXl6YKiZ9/a2GJvscjo1tsLNK7GJraKSeIs0aDxi9tYwHCwpDlOZClTuBC?=
 =?us-ascii?Q?0dYl1VwQa+FK4S0KOD7k5Oi+4MvXsF/lIVLhurl0q/Jp6xLnotbjPgDepM4s?=
 =?us-ascii?Q?QsZf4EReMtrTbI3SUjQooZ+WxdipMwgLYhMM+Zm5+Ugsjf50Kd4OYQ3zSrhp?=
 =?us-ascii?Q?AmZy3JMFW7l+K7eD5j8lvFrupAGntwyxdUrRJWHa2RklDdqBCiFyFQ3pBIyM?=
 =?us-ascii?Q?Hq7FEVLRMp27+PWdQwD+Z526RJgdX6LWW93JaLB3wPiNWjB1VQwPflbd/mq5?=
 =?us-ascii?Q?mJf/yDo7YtHl6k/rJLyC4nO303qM4cusbs68HTVK0i3NfE+rIiWOQLMN7MzH?=
 =?us-ascii?Q?m089ZC0O0NseTuXlglSM3KfDxCnXDE6pa3IoC2V5NAPE9uf8CeDg/Rmc8KzQ?=
 =?us-ascii?Q?HzksVsiSLjOAQZ1uAz5mhRgfsYFBBQmtT1t/7pNjpZSue1+6wyLnuNEgG1KB?=
 =?us-ascii?Q?CWNgcEp6ZYk68niDmTlPbE0bzaQ+CEF7soONwFKiRu4/z6s+1ibBWFMhWTL/?=
 =?us-ascii?Q?GFtaeFfrzqOfVWCiUDuCn8LKufHxs2ynKEdu9ZavRgLWOAVURX2SRgbF3h03?=
 =?us-ascii?Q?LHJunfl6blFWO+huO2LCmqZ8Gd8P4y2KOIoISREp6m4h3zJp4FTAE+inLY/g?=
 =?us-ascii?Q?2lWDyeMuokSK/pGYtZjiX77mufOgl1obop2xySkg4F8S4f8S5DYtY8WN52ns?=
 =?us-ascii?Q?+XVOmQw69IFKDNJ8EE2GytiGChutF0QxmXJb8tKdlTV+IAPAi7/CKXvjJIsM?=
 =?us-ascii?Q?9vH1tzVX1ndEOhry6O8IDbPdE5KWuhMAVVoah4/C1LbQxVuFp1tHRGKfWiUn?=
 =?us-ascii?Q?ns5A9bOFAL8/7O4QTu19luPovjzknkbfXhlAhu1Zkty9uhZhLgJTjJz+kexN?=
 =?us-ascii?Q?WAFpHX9RECqSf6z5VR+a9pskAPHPrA8b42AsVlgFVmvuvFIOgBudfhMTtNHZ?=
 =?us-ascii?Q?WIjywS+vFjVdEf/Y0VXgBTHWvyjzSCVEanhqHgPoQ4EOAobEvJGYQ0lR45R3?=
 =?us-ascii?Q?QnPS+hDNGjtD0QYv3Nfq18gB+vWcNOiRmEcvCmv4O0o6Gn2NQXllSDFIOdrq?=
 =?us-ascii?Q?/PmsMll3+upIspLUYbFrfkY7mWawACe9Nj+1+9eY19lsKvbIYoMz154WQoWm?=
 =?us-ascii?Q?aDACq3i4I1T3cMNTFA7Av0K3WpVlZd2krMh6MW4vhdh6ScpXG9sau4mRRX2v?=
 =?us-ascii?Q?QE/N+ypCxAyrVCE4szxh3vmBnb6SPr35TMkmY/I/m5povmLN/x7Y8b1t4vxT?=
 =?us-ascii?Q?rKZbGxDYf7iI4uEKWvvKAZ69poZZsvQjQY3zu74OPoOZU8fNkt12L0F8WtwM?=
 =?us-ascii?Q?1XarvFWQ7AiEdJ9xkLCTy0XLrvhoCIBauGByitzJ34oG1x5saZMdS/f/pm1Y?=
 =?us-ascii?Q?z5Klrok1sTFjmvUhXfAWiHXfsnIVyywUk/SpUUsv08Ud8k+Zb4En7o2lPr0P?=
 =?us-ascii?Q?dup7/7CGPMqENFdYa08gcrqH1mH7XsR/Z/NzZ9Or?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beaaafd6-0b6c-4d56-b9ba-08dc64732775
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:28:12.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+aBx7iwDDEQnYJSn73kUt9BAQGVNSgwwjhG7QH7sRVnvmdxeXI1fa1vhhGcVPOeS4BAC1RAFNLI3vwlYHUgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

On 2024-04-24 12:40 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a helper to be used to check if the netdevice is backed by specified
> driver.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---

Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>

