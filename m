Return-Path: <netdev+bounces-141292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDC9BA5EC
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7626B1C2086A
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015116DEB3;
	Sun,  3 Nov 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ND3Rx3hK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F45A31
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730644055; cv=fail; b=lRpGf2tftEijgnVJ07Wvxlq2YXEHPqHW4zWtnp+mhSzJ6bYCKuAVoQQqEIrzdUHIR5xfPr84i2asfkPjeYVIOCa4oBOABeLYAUSQUGudo1iJwejEyaSlnBn+6O/KXnRCO7rg0Y6BNV6b6sQQIORoZJrebLv2ILIKu7Z+8hZc1/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730644055; c=relaxed/simple;
	bh=LypT7Nx7f9qAmeCVh1ktIMD9RFy5qc1PsXG/7D7dZXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZpbnZ3529heNuaYdaTq9uXhWtNUY449sbfJCoUwsQaPJqxsfVmYs8vsdS0VHLApt+OW0dyXIY0KAdlFylTbAq+QnssWcPBYcV5ZwhYvkIiJSzn1I5qH8OhVvmmqK/saYFwaAZHQAZd0TAKA1nlQzO9iwi28KbIui4Vh5rB9vN9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ND3Rx3hK; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbv3ts9G3zlOJzlB05S57sNO7v5hn10rS+yYNuBlJgJ1sdfmQGNrU1Cq7z3i/yB+xPv9XMLXn/703RUH5C277Z6arGXhWtfkYKkJS3DBAgsRgmTCdCoKWYjcdDIQFyFXzpxdDFfkQRvATIP572w6KmxmkRIxLpWIxqdcoONTtOGUPrmJlzjyTfaxhStSYSSxe9bikmSiTYwup4/00+buHsg1P+U06C9wYrdf6rn9Rp8rccXGA2ytinGsZEsV3wDeCxT4kb3kCDIq0+bOsuH/b56U5gxCARTzf5MHO6b8QxjYBFvEOqFbOe8GxCFauCDM5FtnvvGET+Lu7ZdvDY4utQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyOEttnm1URuBiVzojgqL1imyyShnBTjx3Z/jtW/mmA=;
 b=gxpY0D/ovq6fRojTxwigDhNOWaY4rprMJvXqFN/PsMRyREyJ/QeDlfyKlKX4p7QmMRJy9IHJTBfG46G7wlj4/2DT1EGJDsDpgro/VTokoA6/OIJF1Hqn+7YsUZBNVtoB1jP/57W9TtK6dNnaN1oCwIKc0sLUlsdfdZLDLlU/EwVhCqickvMAfQDgjdpmsWVEuTGwTFV2LzE02lGY9u/S0h4kq8lQT3mbbUOrm2YyYkcVA75c9wU2q4IgcO9qxcCpxWar+SDga5Qfu0RwaAvoveYkaE8xEq4UMoTh1/FC+kicQWWOJpsX5ydKD53C5Ifsc8hEwLua5TiTs6IU0P+tZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyOEttnm1URuBiVzojgqL1imyyShnBTjx3Z/jtW/mmA=;
 b=ND3Rx3hKfCzzRycEznzxBbivsSqrIE5ghzmNDOPeLn2rHtg+W3KTUU06EIqoZ7rnPLMCV4qfQmrMniYL+L30OFj4rja0sPS+g9zFoGOQvLf5Kd8pqtx+YxX7WGyB7WCvdcR7SaZpbHFJhzGoI6t1kUqphE0zJZE81+bGxjOjI6K1bHQgS/GVqMTzsnxKVRY0EtGuPm55iklio7EQpTFroKsMvdlv8qCujSenZA+myI0neL5IO6OvhQk4gM95urdgpDflsUM2A/pI/j+XDDiIAh6P3KBpFT53de9BaTMYH+t0uQF+hbTNSsyTfZJtvNabyC1+0mqB2VaxGjsItEnQ2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Sun, 3 Nov
 2024 14:25:45 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8093.027; Sun, 3 Nov 2024
 14:25:45 +0000
Date: Sun, 3 Nov 2024 16:25:26 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v2 3/4] xfrm: Convert xfrm_dst_lookup() to
 dscp_t.
Message-ID: <ZyeH1mDjIvrLTYv-@shredder>
References: <cover.1730387416.git.gnault@redhat.com>
 <59943ded04c396d73b926ea1544c8e051aebe364.1730387416.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59943ded04c396d73b926ea1544c8e051aebe364.1730387416.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P123CA0371.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fe1b94-59e0-46b6-e51f-08dcfc13673f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?irhIvrF0oEp2cMNOulPzemaNGM4xKyGMOP1o4EqRY+ZkpfYjypE6qnR8w7Vf?=
 =?us-ascii?Q?xkF6HLwiTrEGY2+YKIQSlUFVbRsM8NkrnTezcPnqMt4cEggNTL1JGi+RpiOW?=
 =?us-ascii?Q?mORr4Fdwlzf3ffhfUVtP3IfwdSksEDXuUVVagBowhV/HfY+M3T+6HLyfXLN+?=
 =?us-ascii?Q?OuBFg4tmR762fMsLAhhsfSfG5cOe7gnRil3tvVrhA3/mTVxmbnr/vDx8XZRT?=
 =?us-ascii?Q?fDrTqsoHkYdyL1T9kCUaSZvuxuaUbpiwpYtI4i9Zw+6g6A0rWhHVjDzKenz7?=
 =?us-ascii?Q?XRlw8Q3FqlvR33mWFNp/H/OJBI7TJp8W1Ss44u7/1b+i0MO3zIKbxIXIgejr?=
 =?us-ascii?Q?p5ip5Ps361+vZ+6xmyOFfZ9bvuAsNIPUJ3c8YAZgOrW0CkfZThXyuSjqAasI?=
 =?us-ascii?Q?JNJeqc+NMDerr4tsiYABRnej/ksbUhgypBApmUVYdwaEVk5yNj7rV9JAv999?=
 =?us-ascii?Q?aybA2rsRif/ELHESfalSU8uc2YyUz1BC9Nv8aAbjvb8bSld4wpZB1iYy8tyn?=
 =?us-ascii?Q?iVFgqBSYq9NcGdUrn+L5M1Tz410AbacHd57ioFCNFH813gVYI3MyC+tTFwHe?=
 =?us-ascii?Q?GJAB0y+tFutKM/004mRDi773mwnVvzotOG3QyBtglQPt9t1NWkWk9tkXebME?=
 =?us-ascii?Q?N0anxabI5PPDgXW/Yvx8oHGZuZRAaCwKERrUwhZa/VplFqpZwynm+MJgM5bu?=
 =?us-ascii?Q?f9OM3CO27kPNRMf3hwMPNB5aeB3H4Uvgh1e9aH6XoD6tD21DbYiokeBwluN2?=
 =?us-ascii?Q?wiyGSnff/3HoNluQD1UZVpxoTL4mqWTA2SYWNzUK9W+NgOT+EriJeitFDl92?=
 =?us-ascii?Q?dZ+4iSs21MqeYeRg7VZq/TIEw/gU6MIEnZQtRzXKT2ABSxIw2MUAO/fDPdtm?=
 =?us-ascii?Q?jcyC5g7ODUhHsRafiwr0cBF7Fa9UPorE8K7CJHb9EWPKMg4IeKVrQhWWMrUn?=
 =?us-ascii?Q?wiw1Snrvys13v/7GWl7B3ObrkaASdC89BYuSoL6MzOTxuwA+hkwqN0W8KUBg?=
 =?us-ascii?Q?eepZlntoct0WE7MlwaKcX2yywvrA7e2+wujKgDVQx9cDlJi3LY23IGvjj35P?=
 =?us-ascii?Q?6oGNLM6kSe9Xh6twJXF/8jb9zlkf7JRpYuT2lWoo6L41gx1nYMiTsPOHjIG6?=
 =?us-ascii?Q?dxxsNv2NFXe1mpmiMPXWuMtsXDHeAnWVlfgYXdiK9TrUUhRf7/CWI6uT6y/a?=
 =?us-ascii?Q?XQyyojjSsQ8SPMPh/6nSEGqHhJQ+uXxJD/BVO/ZgEYjTiwJeUhtIATnhV4W0?=
 =?us-ascii?Q?gWfjN7BEf69cJnf27LmEsQchGmOkIPsmKHksa42HdDlw5mSz2V+YeX2W7dDa?=
 =?us-ascii?Q?9HKuRVdIKp+z/4notmz/VOCn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/lR/nfuShrDjmPD3zTMvswzC8F7q5F9aKcbWFJ8HJc8CYR8FccW8zVqfrk8?=
 =?us-ascii?Q?GE70flXjoqWzbkr1/Om8r5DnGWZdUxqudmTP4Arudqs9ariWMxE53t6KKRcX?=
 =?us-ascii?Q?xUQ2izC+FrCbdMaHRmWzJAgHogUgf6eEXeAE1uNCcDOoMnHBhCYNh70VwbqQ?=
 =?us-ascii?Q?8XyrQQQ7m78DSv3o518/ASZUfjRmsRi9AAwbJPln6YZMkvtJox+VM0HW2UEM?=
 =?us-ascii?Q?my3Ph8U9PP/xZ6MTmZjmzhlEjc0TtzONqbRA2n1kQC6ePYs/Tbm1JFZ+pKxU?=
 =?us-ascii?Q?rwyxzzmMILaYDlobfvTRkc8BCiXhTiVWpdCQAwNyfyKtyFYYmBeAM3HixmBN?=
 =?us-ascii?Q?sgIpncuwPZRjbsLxqZUmuOcOVeQP1Mjc+wqWNSsqGD6AMjYe6Wd70oZSirHV?=
 =?us-ascii?Q?tRBk3fdMYGMzklf1OeVKsKYc7mUS3yDy5t+tTO1m3BcvqcIwZH9K4l9qNCAj?=
 =?us-ascii?Q?eHu6Gbocl7UsUtKK12d0g8qjfYygt7I2UhqQoGR5eu8yGJP8+UPEvfD3qU62?=
 =?us-ascii?Q?95hLA1Mkw82pvaQbys2KBefonK4pTmduFSKIZDIEvr8UjBkagy05N7g5qGE7?=
 =?us-ascii?Q?2K+NZQed8A2nZD2HfFedvWG01n9KdI4469wLjFQN/0f8xwGCS/e/6++HTXOw?=
 =?us-ascii?Q?2EF0TE2I7F6NK182bryzVLnMTAwW40VRTTDecm4iUw+89gQ+8cITBwofFLLr?=
 =?us-ascii?Q?HM55DnM6tbIF9YH8N2isJ6H5B/4LP4btI9DFvz3YIOhJfMKa5p9tcrj9SS/G?=
 =?us-ascii?Q?UkG9oFh3J+ng7i0vAzfkBJs1kIQsUJBmbf3zeMIgVF/qbEP3R6HUz0E8nHjn?=
 =?us-ascii?Q?DESUmbZnJznFvzX9YVy+WVi9M/cX2vpczOACeA9T0EN3TK/UzS81nYnfyefG?=
 =?us-ascii?Q?dj4ArgcvRhChVgPd200fuCy9pVeuCuUkaOhslPWpTCVX1WYfaVHDS7zH8c1S?=
 =?us-ascii?Q?jYZE4zed5zvu1B/FmMmyg5lEiwgbMp8AFO2HYSUq4XObsRUm8zeOa06tdKNp?=
 =?us-ascii?Q?jURYFzefKd2CDDkJKV80jlGuU0RwNTBib0IIsKWwUl7TBcdGbl0YLm80cEM8?=
 =?us-ascii?Q?2HKHLbPKkDQEC5PsZ4Fr0ixrpaAKP+tsU1VQiX3k+UZPgCd4PKO8THxhx+qF?=
 =?us-ascii?Q?M1XySa80VGww8TDgWt5dXZuF8vA8c3kVVqRSVvqcmDJSd1NXUsxoDma59uQE?=
 =?us-ascii?Q?UmYLADLrvuhix5Q71ZO4M2J+JxFgpBkXIXgQvJp16MKr2Dhr+XFdquxJAPiQ?=
 =?us-ascii?Q?hnuR1I4GMHIjv4fTKMrukPoAmsFJeZDzHavD0ErVrWour/9xoFo/Pb0wEKer?=
 =?us-ascii?Q?bb8aRDeADhweiRWTUzD1FGt9tcIc/dCrbBjfx33sqeG8chygaCRUBXS49zau?=
 =?us-ascii?Q?tZjy+MBkAxffHWYC+jQ+a8xFwSs0hN+oWRI4+mtqMRbx3/EgvOp/KAmVm0N0?=
 =?us-ascii?Q?s+fKlTszfxZ4w8SlLVEq587bdfahgyOL3cN8V5SMdzB1cx7H5JVBfzDWSHYb?=
 =?us-ascii?Q?132kO7uiiBT2r/7SFbRXbjDE44OhltfQ5RW+W3UXZabZiruNRMYcw4w5df1s?=
 =?us-ascii?Q?Jx0QPn+72OViGYpR1cFejJmrxCSfJrDCXyQehh4F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fe1b94-59e0-46b6-e51f-08dcfc13673f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 14:25:45.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUr7EiVmDrH98soCVkniFoyRK1/jdS0WKpWG/6fX1TQI5d7gWxL2N40hU41qcxrUj93U2BLay9aJD3GB2xakWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

On Thu, Oct 31, 2024 at 04:52:49PM +0100, Guillaume Nault wrote:
> Pass a dscp_t variable to xfrm_dst_lookup(), instead of an int, to
> prevent accidental setting of ECN bits in ->flowi4_tos.
> 
> Only xfrm_bundle_create() actually calls xfrm_dst_lookup(). Since it
> already has a dscp_t variable to pass as parameter, we only need to
> remove the inet_dscp_to_dsfield() conversion.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

