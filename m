Return-Path: <netdev+bounces-81339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF1887485
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 22:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8372838F0
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69880059;
	Fri, 22 Mar 2024 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eW6uLznW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E976F1D
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143870; cv=fail; b=hAePgK15/IqrGwP5G3yIiYHsto73Wt1cvZc8mATDoh/WRmdZ8BrGUpUp+iE8crb+B49e49H+Uqcx3kKJL2c4iHhr2SNH09uqh9BAONU0jWCr2RMwvzcBKyq/I83xPy2oNjIobc4x2k72GDHuv/Xj9qzDg4NXiFhJPjeIEGlhtPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143870; c=relaxed/simple;
	bh=1bDX7vu5AO90jd5AewIYFzZFnkKlM3B4kcwb3/oFshY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lpow4onIMZGzYjKojE4oTpC0pur3MQ0JFgvIuc6bVU77f82flmO3Lx6g7Q+B8X6c1+uMlDPFzFk5M3foemo53ewvUzgphWHgtZvNC7fWhuYF4ks67qAQFn48sjcGkrIHSrKrgULJ6gY2xmb+kvtKzNYRV4OrXtqu43Y3wbw7mQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eW6uLznW; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMx1qHt2kLkESQQ/5VkyDPDESisHYrcd4drHm4XoGP6jO9YU7VI4a2Qgz7YrroyxSHyx1SxqEkhqfk+w6AIHkAc2f7MjbRdlpgISEHagV0XcKSs82v3mpto/Z+G8xL5T4LEzHv7HwFKUyWtUJVcqUx5t23PGAuQkx4L1nZbBP6cT9ZGutOq4fGofgvgZE4p5O8jGRLYlCrI0sYDyVkeT+VRye4c5VpRkvr4VtiuIuATqXp4CymlWyLj03cmBnWtR8WujrA0IdZuYs6rMxgaZkIcrkRkUgbjFKErBfMSU+Jw+QSplWw+mt/VICmnTGm1tZoLhoL2n1xVIjN16BCc6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqQIEaPMSD7rwHDHPm3t1fPFov61vmzXilCzzxo/yAo=;
 b=kCx7HelaEoJkVAue2TorVs32g0O/hDBE+36nPvE5K15dEXcTZXo4A5FthYLwdgMFGi0wpare4lfKEA/7ltYmzwAthP2dyabCYrvnS4+kedCSnxPznH+gZL0kmlU4JQVWR5SE7STbVrzsgV1sRFZNhaFA/Rau7kXNi72D1s78SVBrXPoT+SL5f9Mr7zMSXoaXvzc0G557Ho36BWhlGmnNzMQqubuMQ9eWgYP8N1jluhjpgtUWdSA0HoVib+ZulkV/Apjy7Sp7JDUXe3eLN+1tqf30lymjk9J+vs1zgh3MCsy8Q2jNLX9aMYhIHqopWj7cbxgdlpgtFshFLxdafcfkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqQIEaPMSD7rwHDHPm3t1fPFov61vmzXilCzzxo/yAo=;
 b=eW6uLznWwzF/rJpHTbqdICruC5dpN2vqrGv8PI5OLdy3vKZlcg2AjOl0FRhRUEY+XVRQylz6S9Nhara5ODr0fmMZ5kzxRM1p5enhs38Yc9eNRVJ9T0+R5S+j6fz8HJUVyfx3OeKEb9wKZm/AgQB8jOAwxIcmhK+3Vo2Leb+/QCMhvVcg1rH1jTUnR3flAujnNtOSBEFPnCnPn4k3bU4MBDne8Ci3ybF5t7Gx09paWjEMPx0QdgjdfyXdb/myXeGzGkMijDtKlsyi7EPbGjEMvxzS8U/eYtVcM+BLqmr4I7BRkz/QbHonLi4ayv4fnNvL2D9NjUpBSPxJFaLcf8BalA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 21:44:25 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 21:44:25 +0000
Date: Fri, 22 Mar 2024 18:44:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240322214423.GL159172@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322135826.1c4655e2@kernel.org>
X-ClientProxiedBy: MN2PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:208:239::10) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e446fa-9817-458a-2a2d-08dc4ab93dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4EumzkBatmYmpjtr0eFyjkqHP9NIHujERsttytXAfjMh2Q/0BVhnuI28bfZAbNMeYiHhNc7MpvQ6DqWsnnPxnL9w3vObq2wTGRYhskYFelKrN/ra2n66TYqqFrduQ2WFbGFCN8t08nNem7I8BgGTUtPVxBlvJRF5WhFo2SxdYYhPS4mZRfcT6C2iINxgcDvgkRZS1zrurqQiIV9kdY0HROYXaAzG3PZmdnZBTaXIWrt0BLE5CiVHmxXxHlJljQt3+/sDG4KDeLkGpxi5juXBTqJZdYzacJr638WjjkYbnrNk5uhgiqtQAzp6AFqMdTrs10UFpfKm1nj4M/SAtDzTT6jDcZ5PZlDDYCvb1bTcuIQLEhnVEDUOV/6O6LGcEmBtOL1gejXoXXPr3Abu8FwoMjEm4GHzjOp4KRtaFmPM1enufNn7/6MoawJ8Qk4xYofIrwtRA+m42vYcUKV7ToiRjXy62Gg9kLWsGD89Mc74qCCa6kyFxKdw4LrVgb5FnU+p0/BZJyJgnroxeQ8lO7PM7i+ycnVbKALpwFYN1ihkhqm2MAk2uWLTVzBBg2cDYNNSwz/h4e1znAzU0ssEuVc8KPN2JtExeh81/XBFSOxco16idpwwOtCWExRAtd+oMCjKPE855CEZA+K+Vgz0GEnLK/CBW9mCxRZSop0eQHA+EKY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nfuWKoSmhVkorNJNDq/27IdMN82SUcq+CBlICtBAvmGXMlR7tX5+42IvNmlr?=
 =?us-ascii?Q?WIhdHoF8YI+uxOiYa4ll+5Jgm+/jweWl1nRCIF4Dubfh8flIXnRLCd5wha7D?=
 =?us-ascii?Q?665vj6O7pUo/OKMcqN4oX5biWvm0y17nntCG/S9ej4UJmIqgB49fk47p8pyG?=
 =?us-ascii?Q?0npsBcFH7m4OffD9vG762VdwyGuW88GVAuvksqUkrAX757NDe5gZDibpPHZA?=
 =?us-ascii?Q?PX+//auYNje7ZTFQHgHG6dNJqyjRCRXW9vnr3GdhScQrbIZP8VQT5h1PNokf?=
 =?us-ascii?Q?PJp4BuYlmnvgdV6K5yCi2+LwGvhog+63J4qGcHt5TQ5P4Hw/uqwVaXYGMH/Z?=
 =?us-ascii?Q?O3Sy2AjrT1McBtZcZm/awFyZmvBY+A7/X7VN71UtilkZuPQW6GhnBA/VLc5b?=
 =?us-ascii?Q?ijHMa47sKJs+ky1QA5L/+Of2VxOgUuXl1c2Aeo4+WZaXRvpjinT9LHNkqQae?=
 =?us-ascii?Q?YgJ6SBx0ON4x/LAXWHX08d4kiKD9amt8sHGsma+sICszv3ItYwQTmlTOscI4?=
 =?us-ascii?Q?xPisyCF43vo6yYv0X0XU36IrlkcIgXvd5y50G2Xi5jj1+htSq3IUKEUZu+5c?=
 =?us-ascii?Q?+qunZg1+y4q6KKgh9qjyw8DoGjXZ2lcVSbv2Khv0XtvHh2l/KflYzIz3Bj9e?=
 =?us-ascii?Q?oc7AByU4UAN0bheFsKna1iyQ7+J34sUVp0kY7dfPkKFuP5ty/zrCmJ5jQ9TJ?=
 =?us-ascii?Q?BRiui1Rh5uirNm+E1U58RmjKpsR2dYwIeVE9QNMOGwPo1Zzm9i+5VwyWaY/i?=
 =?us-ascii?Q?Ub9iR+Pz4VCFIYrBUZjO5aOL2Kg839DV5nOmsmmd0xN1RJggfL24+0UOveg0?=
 =?us-ascii?Q?zlgJUkD6TctBZbK6p4GEc8wxJGT6GCnllIr0YZGag0EpC5KD0FwG7vtKI+vr?=
 =?us-ascii?Q?l2554V3IsFcf9J8zzhDXthWdCp9O2yCBEWChTBkOYKYlo/mNne9TDurfF9ES?=
 =?us-ascii?Q?WcluhoT7SFL3kWkSjIy/4kFd8XeyrfMqcVJVQsV80m5psmIqAr9WNiHIkkHb?=
 =?us-ascii?Q?fNY9cYIxQUFEDLo8v1jsiacPQVpzvwE2Q9HzzcBmMhSL0uvxeUAUsY+2sPQ3?=
 =?us-ascii?Q?58RbmI0bSom6dWfuy+rjThXiZTBNre3eItFHwYcvBbbjx246SCvlQThhNXq/?=
 =?us-ascii?Q?RJvgpTbHLjd5ELIQMdVb/Ao1wvc7yo8+iml/l29EP+0jhuElCCg/eaqxYA1a?=
 =?us-ascii?Q?B79vlpzOFpxy82LVKdWlfMXf9PYO9/3YnTMsFo1246ypLCzPUiZzIuXoYjMO?=
 =?us-ascii?Q?r3KAWHCVrs4Do3xM+P9cl3T+SKpBgv2ule1lSym+FoxnkhdL2xzYr9IGdBGi?=
 =?us-ascii?Q?6kxH4148S5/ttIkp7oeaEwo2lcmY7xkQqiyp5b6lgSdXIPQ7PLxXCYckoZFO?=
 =?us-ascii?Q?PoUR77sdO28539xti4R0JaLAwQl1nFSvI2NB9eq7lFSRX1PlEBmQYY95FEgs?=
 =?us-ascii?Q?ij62Pm3WVPwl0EUl73JkmPz+VuVsjsaWvt2132D2yc3F7Wr0HleK932/3flF?=
 =?us-ascii?Q?9u/ignefp0sT0pFxxEaGCBiX/MrMbvwa0+e1Tofr5dnJBzu/GHsR18tL8t8m?=
 =?us-ascii?Q?8viKR5RHA/YE8H5ipLJ/0ptiiVwjfcoxbdP/zCmo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e446fa-9817-458a-2a2d-08dc4ab93dd5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 21:44:25.0096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsTjXlHkbuXX/JD4KIxUgCHQV3RbUonc4W2xZGBGRiquD4S7Hpobq/UxVdzsRfch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657

On Fri, Mar 22, 2024 at 01:58:26PM -0700, Jakub Kicinski wrote:
> On Fri, 22 Mar 2024 11:46:27 -0400 Andy Gospodarek wrote:
> > > > It's the middle of the merge window, not much we can actually do and
> > > > this patch series itself couldn't be applied as-is, so it's hard to see
> > > > what could have happened on my end...
> > > 
> > > The proposal was sent a week before the end of the last development
> > > cycle, and I believe the intent was to motivate discussion around a
> > > concrete proposal to converge on an acceptable solution before sending
> > > patches.
> > > 
> > > On your end, what would be helpful is either a simple yes this seems
> > > reasonable or no you don't like it for reasons X, Y, and Z.
> > 
> > Well said, David.
> > 
> > I would totally support doing something like this in a fairly generic
> > way that could be leveraged/instantiated by drivers that will allow
> > communication/inspection of hardware blocks in the datapath.  There are
> > lots of different ways this could go, so feedback on this would help get
> > us all moving in the right direction.
> 
> The more I learn, the more I am convinced that the technical
> justifications here are just smoke and mirrors.

Let's see some evidence of this then, point to some sillicon devices
in the multibillion gate space that don't have complex FW built into
their design?

> The main motivation for nVidia, Broadcom, (and Enfabrica?) being to
> hide as much as possible of what you consider your proprietary
> advantage in the "AI gold rush".

Despite all of those having built devices like this well before the
"AI gold rush" and it being a general overall design principle for the
industry because, yes, the silicon technology available actually
demands it.

It is not to say you couldn't do otherwise, it is just simply too
expensive.

> RDMA is what it is but I really hate how you're trying to pretend
> that it's is somehow an inherent need of advanced technology and
> we need to lower the openness standards for all of the kernel.

Open hardware has never been an "openness standard" for the kernel.

Jason

