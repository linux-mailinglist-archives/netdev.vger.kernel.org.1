Return-Path: <netdev+bounces-108855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7209260A8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5AA1C2282F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A3A17625B;
	Wed,  3 Jul 2024 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qcowcmpD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3216DEAC
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010435; cv=fail; b=LrE4Gp4myaDLxdu0eA4+IBAogsYPVoWhxEDgU+ttqNQy9pv+U1C6B6HrRLVLCgtspHDUXqKLEzqnTdsjLJM6iZszNkI5b5j7qfZQUV5fu4sqAEE5z4pCOBlTBdLVUiml4Sl5uj19mkg137NIXAoWXGYGcem4buRzIjLne5xpWPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010435; c=relaxed/simple;
	bh=jDT7B6SisL+StABeTp1tRCHrXUg5CNSyQQDLn9RvLFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ib/n4ayob9V3iaEp+nlVSaaVUtI6PA5xDsyY68E34tIXFhHd00j2BtprPnhhCcyAt7euqWXt12vVYTOt9XaX0qu/hbxh3ozG3kp8VaooJSWi8z/y7ZyZUBS2TyqbW1Kvx/33msPToJy+UW0pFSiGaSLiJIqXwvJsz38nXK78CHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qcowcmpD; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cyguj6cpR8g06CYYUXPLuHMbbp4kyGVUacbRTTGq59hUGH9iQlVB1H6DJETKHyCT7Xbeb7w5Szu/Jkjql6C1UtzOyLN1FRZ7u/Qqq/q3f4VWj1nVyzU9O08XURChNhMinXJPYgzipRpl2/e98HSHRtUrZN891ybBhmKmLo1PxrSHqw2+8Kqse7gSdEOdPKQNtGC5tVQJ6W09Mj6SXzOkgqE5RMTXwQsoy7xVAyEQZRt4N73pGZnQCooON4ZpPwGnChLTp2k0dAJJjWm/TTqKgxYiR1PMB/UJXO6I36blKvnpBm2Qfz1mZIYx3TyxE97E88AnGxBSOn2IQxlYNWRwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEU33x5S24eBpvVRdiekguPN3pxQ6ENqvIWldmiEfok=;
 b=TItSicubWkXAqhT6JuUyKRr1zr7qhgjLYKetjeBkIwS8dm6yVS1C+edDLvweU9GvVZW08siSNQ+Z7fQ5ff4/jAn8h7B+mx3Jc0I/4xLjqza+ySeNl+uPtIi1ZA/1lqkVO/SabACYwM47c1opKy4skSJ+m32lGkN44oCt6l/zKWAxEjrP1mnUdoQv6Wn0KTAtLfjQi3WPAPkfNmnq9exLHOOIivrU7m0Pv9OfDU7ZJyI5rcdofhg2bWTbSvExlHQ+qKvLgU9BNHWNqw9uF1pYCCNWV/N4zBZ6UcDtohGaKZcpj9knB1xKsrHjQ4v2OytnHvClHCNigLXkYXUI+rmPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEU33x5S24eBpvVRdiekguPN3pxQ6ENqvIWldmiEfok=;
 b=qcowcmpDAr/q6XA77UD7PK7AHYmfZWOGQC/VsB4918mpUyfP+FYLYsE2IfpktCnyRGGz32x4MrM1YcLvJ2gy+vi1a2c5btGaYTGBjMO6fGwbhjndybQdXSxTYlJ2xW2UkZbR+O5a83EkCKRhqaF+hfu9OtUcflyv7WebLdRSaiFFdhz1C5/crxV4guwo9VM4ZIs4JoOjIjdUuxDOsbkG2bnw8ymLmx6MkFOXjpQXpGYDQ1zroJkhKbV1mbfDA4EpCbIbKujjdoEHqzbWHLrHEkq0gFA9BWSn4UOWeFS4ba3WyaosOt/oVDG0fgG2lHTRQYmWbe/ayfF5t2MbGDGuOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 12:40:27 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7719.036; Wed, 3 Jul 2024
 12:40:27 +0000
Date: Wed, 3 Jul 2024 15:40:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Petr Machata <petrm@nvidia.com>, mlxsw@nvidia.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] mlxsw: Warn about invalid accesses to array
 fields
Message-ID: <ZoVGqJVBWUVNtsrc@shredder.lan>
References: <cover.1719849427.git.petrm@nvidia.com>
 <eeccc1f38f905a39687e8b4afd8655faa18fffba.1719849427.git.petrm@nvidia.com>
 <7ab9435f-e43d-4580-b7d3-18a69f231252@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab9435f-e43d-4580-b7d3-18a69f231252@intel.com>
X-ClientProxiedBy: LO4P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::17) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 4839a0de-ec7b-420c-3f13-08dc9b5d513f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9eya+mB8MlpjsSSmM1404qc9clEC46w47mWRxE3FZRWggzOU80uCeJSRiZvW?=
 =?us-ascii?Q?jXCF+MMDOcYPc9E3/P32ExB8ssTBZhF5TDOfp46+VSp86nRvdz0ZkG1Pt2Yt?=
 =?us-ascii?Q?0ISWNRVFHjXf4aT+p0IwfIS/OCGcpN7HDrQfoONxyqNtplaGVkkr5a58cZm8?=
 =?us-ascii?Q?wysQQttVhUIMSZLC7R7L4sc13meoctuIFonvrc9XJQO8RPooqb4GyPza7DZC?=
 =?us-ascii?Q?X8aMF8naQmeK4cb/oft2IXC36SohQT2LUnY9T3cj4ji8dlbynyaUKswq+em5?=
 =?us-ascii?Q?e6aLxYcvaHb/r2zMRw73Lc2v4Kl0uflaH7Mi9rsuTACHUCTlb5RIRCK6/Vpg?=
 =?us-ascii?Q?SbVuIX9G7jHC4Fwd2ScYGfNaRIfrpVRklj2TPcmjn715oNTsuTgfZq6SIHco?=
 =?us-ascii?Q?wExVr4ZdFfSa0vsCzYEFXD2f9CnmXAtHzimpj4KiYOJFrnmJBQkCk6UJlVYJ?=
 =?us-ascii?Q?7iaTLg7WKetVZufqlEokQ7SFQME41P8bhc57z2T5bd8N2qP5A3edSiiRGU+R?=
 =?us-ascii?Q?aFVb7JkR9+pEYTawuM5TcP5ajJYmhPqONndR2n7lD5+aQXjL4Sead+MnvAM0?=
 =?us-ascii?Q?/7pI076K1iUYu2ufvAhnGyzx0SjTg2T2kqxtjrl2nT62sMGfFRdZmZt0BfBV?=
 =?us-ascii?Q?mVY5HR3mp6L3A+XRU5VRTRVcoqRwsFXsTlLyB73FW8cc35xA9X1MU0GlvLdi?=
 =?us-ascii?Q?b4h6E8Ks0nAzZ6HI01X2lviFFr2U9R9zH/j4XlmsfTmU4D9bvavSsdYF0w+O?=
 =?us-ascii?Q?bOvy/VPDRDqyVHyn/cFHIXL3+Yc/36ndFyzQ1DdTJJdCjCHDnK1+sa24QD8c?=
 =?us-ascii?Q?M2mRYdJPKG/G6g3NLc4ip4IkcWBfVumN2KVHEQeMkJDYhXautsLGf1wjB6BY?=
 =?us-ascii?Q?4K5p8mLKZFGwjvSL4fNMs1CCwOLBshDZQliqzLnMApm1fmvCIa7k2dKLCeNx?=
 =?us-ascii?Q?6cr0+anyZDwspdX+LovLlQJEqDCl1D+AJTy2oTmbuYQs+m7WrZOsHnJTxO1J?=
 =?us-ascii?Q?levS2KlXJ5388ONrzSCDO6ZqsODoYVR2Hpy9pJ9xEUIu9k83NSmpAkmRbelA?=
 =?us-ascii?Q?UoDdaSi0MbsDSdK1G9fdnhkXmZMTSq+3S1UWv8ACXFYd1NtBk/3MDc+Nzk0H?=
 =?us-ascii?Q?KT4JxZS8d4lFCpvfDSqq03MWLC2TKcpBjNPlWjRqTRSj143lyWiO0LEw8LSj?=
 =?us-ascii?Q?m3FCXmRIl6kC563QqM1B0UIHf3QSA4zfHpRBsJlKXvUJuDxgmAu9cG+sA2ex?=
 =?us-ascii?Q?CAVD6ZlX2T2nDsqydMT7FCygTMGEN7A9T8Av53EEWCKp+xpB+FvBnGFKnBvJ?=
 =?us-ascii?Q?orWrd/uKNvxEoUC9wRpgkcR5O2gXNHpByLbASWEgVrQYsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TE05WXaJBwAuVi0wSRnpIwWKlcac8Udpyj9Cb6eeSDgE/Hk09wxBM3C6Av3A?=
 =?us-ascii?Q?d95MhkrnwQsd/AK8EMQxvjAq2IWl+bMN5mjhIVQpC94LcGf1cPycKVjBgQUI?=
 =?us-ascii?Q?0VcwPU/QKK7Mdk65WJhJ3t0LxLtkFnN7bxg2UQu2jEQOnXuu1kqP4mDbkIKQ?=
 =?us-ascii?Q?VTZqsoKcyikcYSMTqSJD3aaSb/Ovf4RV3WzQ7n9gmhBbpGGVj6EN1jjkx7rC?=
 =?us-ascii?Q?JkdWC4lkiysaZI2r3Z5tWZ9qp8IXYOxHIjrRdUTtcovqLSKXARQqrheLNGsb?=
 =?us-ascii?Q?I3w8+K1ACbs/V6dZq7v6c3Pp6hgbX6gYvHf6Ss16KkQJAEdG+GfsA4Hqkhyv?=
 =?us-ascii?Q?oXx4lCu+t7oVj9myCwgCOMXFF5WKiPbLc+FT7TY1gk/QAyRg0R+gPM+8+gEs?=
 =?us-ascii?Q?iMXEj/hC7hmqCu0xAZGivwjqas8BdDIABDKb7SkCvYSciJkg0bAAkmJgRYZ8?=
 =?us-ascii?Q?aosb7cvjxibenSoS6XmYDZW8DTQTQ1NGDaLA/Yz5qrVx2c04rlIEwYsofHo0?=
 =?us-ascii?Q?Akqb1YMacz8KiH8W32sovpsw+I63Cs6y9bn5vpwyXZrFuHvur1YV/DjXd5Wn?=
 =?us-ascii?Q?edax/hNNfJpdyj/8NC4zNzSq5lIlr0owc4dgYUF3foRRm7cATFV7AuwBJ6xe?=
 =?us-ascii?Q?HkTxg7rVsEfAV6ief/4EoqMfwW3eMEOCST7IjX7ZMr00Z+zi8bYasOs8UU8P?=
 =?us-ascii?Q?E4YCcXR/puaJVLTedpygiuAqEZ3RXhgJZlFQ4OYQYTLxv2J+9UDhuRWgqGzH?=
 =?us-ascii?Q?xwhpP6AhOdDfEu0prIs5ZKEiLJM1yWrdsXxiE5xTKztz2JuWpg+YojlSPJbx?=
 =?us-ascii?Q?6pRnGyRVyIpMaBzViEEqyohBtXPFKrhlgd711XeA5+rWOeXXY7cTEPg718gR?=
 =?us-ascii?Q?qAnIf222e29zsOs4F4CdP7rPXHDYC+1JJSx2nAsHTztfadcU3SXf1f4AajD8?=
 =?us-ascii?Q?pfBFJIVVFkwCRP85BApJaORmbtt/P8i4Ib4OxUcZkmZf6m6c8t6I1BCQKCkB?=
 =?us-ascii?Q?0LFBuphJBQ12/+KhWnRnaf4EcbHWVFzCI4qqyVjweFF/bvgW4mBWCxknFpHS?=
 =?us-ascii?Q?w4hN6jYgEJogaAv2r2jodAmCvngBI7o9mEEq5FKW/WggODGzYukSR6ytsDSB?=
 =?us-ascii?Q?pmKw387jAubS2VeJsGXBMFRlGyfo/B23FNTFUVTqCye8xpfOlLgd/P8bU3vx?=
 =?us-ascii?Q?sgs1jZZg4QXwnkOdZ2RsGxXemyHXZlcPW/ZuWqC4Nq0NcOv/v+yC7BJ19Lq/?=
 =?us-ascii?Q?7dPi0oMtzT8E+kGLoBvP9gsxdiIJv5rHv6Og4HEu4BNPJtCHB9Kw/3kLLiLy?=
 =?us-ascii?Q?ZKe+liewVD66uXcqxbWQqecLg5n24fPMeWeLDPG9VGHCby0o3/G45U3gtE8g?=
 =?us-ascii?Q?0nW/EM4VGUdpk7UTFKrjwr5KZchloHVdY3VwlkpCjqwfXVYdEn86wJ3tBpT2?=
 =?us-ascii?Q?fpcgsTud4ajRjSo4zKz/xO+aTE7Ouihi3efYuiVYg/Bj4JyrZiYfuYQUcwvt?=
 =?us-ascii?Q?cpN+PMjFsoLGCqCm/Y9ik7fVKiBzno+zW0s8sPH+KIt0y7yDvnKEmY+n23zv?=
 =?us-ascii?Q?KSWG3O3n3PlYoSg3rsmSoOu7Do3dXZvZ1xZDDfo7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4839a0de-ec7b-420c-3f13-08dc9b5d513f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 12:40:27.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uXHTdXkxr+XluCmM/uy16dGjE7o3KcqLRPNPWz6RDWxn+HlYE4yJksIOjSqidPbRHkBJyYrNJxPcPWnDtlqfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

On Tue, Jul 02, 2024 at 09:08:17AM +0200, Przemek Kitszel wrote:
> On 7/1/24 18:41, Petr Machata wrote:
> > A forgotten or buggy variable initialization can cause out-of-bounds access
> > to a register or other item array field. For an overflow, such access would
> > mangle adjacent parts of the register payload. For an underflow, due to all
> > variables being unsigned, the access would likely trample unrelated memory.
> > Since neither is correct, replace these accesses with accesses at the index
> > of 0, and warn about the issue.
> 
> That is not correct either, but indeed better.
> 
> > 
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Signed-off-by: Petr Machata <petrm@nvidia.com>
> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlxsw/item.h | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/item.h b/drivers/net/ethernet/mellanox/mlxsw/item.h
> > index cfafbeb42586..9f7133735760 100644
> > --- a/drivers/net/ethernet/mellanox/mlxsw/item.h
> > +++ b/drivers/net/ethernet/mellanox/mlxsw/item.h
> > @@ -218,6 +218,8 @@ __mlxsw_item_bit_array_offset(const struct mlxsw_item *item,
> >   	}
> >   	max_index = (item->size.bytes << 3) / item->element_size - 1;
> > +	if (WARN_ON(index > max_index))
> > +		index = 0;
> 
> you have BUG*() calls just above those lines :(
> anyway, WARN_ON_ONCE(), and perhaps you need to print some additional
> data to finally fix this?

The trace should be enough, but more info can be added:

diff --git a/drivers/net/ethernet/mellanox/mlxsw/item.h b/drivers/net/ethernet/mellanox/mlxsw/item.h
index 9f7133735760..a619a0736bd1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/item.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/item.h
@@ -218,7 +218,9 @@ __mlxsw_item_bit_array_offset(const struct mlxsw_item *item,
        }
 
        max_index = (item->size.bytes << 3) / item->element_size - 1;
-       if (WARN_ON(index > max_index))
+       if (WARN_ONCE(index > max_index,
+                     "name=%s,index=%u,max_index=%u\n", item->name, index,
+                     max_index))
                index = 0;
        be_index = max_index - index;
        offset = be_index * item->element_size >> 3;

Will leave it to Petr to decide what he wants to include there.

> 
> >   	be_index = max_index - index;
> >   	offset = be_index * item->element_size >> 3;
> >   	in_byte_index  = index % (BITS_PER_BYTE / item->element_size);
> 

