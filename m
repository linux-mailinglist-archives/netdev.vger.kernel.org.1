Return-Path: <netdev+bounces-149165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81019E4A29
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA68016807A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E02B9B7;
	Wed,  4 Dec 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KUaQM9hN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595C165EFC
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733356339; cv=fail; b=tH7yb86OKShWaCAZJ0iGI50f7ye8PrmZiCBNBsjiXglHHpLj/r/tMhHFHW267h0a5hPTYwN0HhnKfWH5xX+rCqcbnVqpcL/ViMbwVCzKwhQTsWIeS4tRPXg8bnXzRdmjsVudy18Fob/XLQqAISVCC/laAH5KVEwsaH8ZxiSWUrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733356339; c=relaxed/simple;
	bh=rYxRYwHGlb0IoqqjRqJpX2HxKKQPfQFRaTfDbFtueVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wj+yNGZN2EAjaB77DAnbMm94rH/eoumPz04kCx1Mbj763j+4LM3VIdtX+i0C+E4y1dhP3BVbVALe1jx+SO306pnv6slDmDJ3yH7PNZQheCMQJ9BEnbmT2i8eFTHyKJcylFWzkVQkMkt3fAccnVAvMHxanUPe1s0T9uKWdnt47FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KUaQM9hN; arc=fail smtp.client-ip=40.107.104.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7eOmwZxKQsbW725sLcx629DhoVqiDPACDVdNFJVu4aCZO2nziXtYP6t/4DCtNrvCTkbVC9PDbAn7pjMbhqDXFWXW6y8P3oZNd/iOwSJ2WDctkB9Vj59hf3a95rfsqQcVlCzFnhdsmvIHafgGOxLebUfNwuiR0uBYG/BGk1Ts+NmOBbwOA5Zk9ivEc5SVIbG5KSCfAOgy7vdTjoCiyNiLTMOSptumcJfHG2lauif9vod/GdxT3MJFOd7WPM4wnDNhodo8Zt5VMkwYs8HHYNxAKA3DewZAu2EbHkLI/nBkypHaURf0d479b177jCLrifCN7U/vdhMnPzfQnpJaWGMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH+q7QCSXtgh2+K/6eH8kicCWJvu4LT/9UodJSk8lmE=;
 b=Gio6fuUvXvm3f/lM7HDDXIhhbIRcvxzF6qAUuUISEYzIArB9M/xxFqaj3VVx578EtToj4zdFgn/9fimY4ZVoTztQ4wJ56KbuD7quLah8h9BNO5pLztRo1OMRLUN/qhSeEkJO6FoDZi2bih/M0bkESC+Nkl+VNqx2wM/g2AQT1CFicGtqvBkBsOeU5wVOl4ll3kM5szhSRHSI/UGunDyDaRv5Lrd0FrlD3CRxumsNf2Z4WwpE+KN99Bc0I1Ny07wgoeVa67gezsgwXz7XRuZqBka17guiPF9k/MlfDMeffR0/z2pvJ1Wz70VlamUoDzEyLJ/D+94MLjPwY7gbV1P/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH+q7QCSXtgh2+K/6eH8kicCWJvu4LT/9UodJSk8lmE=;
 b=KUaQM9hNqWg7MFG3c/rLwfGxuxEMdfzH19RWhpb9w9F1sVg4El9jEHKPp1tjjr7aexaqAHQZkUUQ7Up8YzlAm1VemBUnx3YKCc+7A55lBKlEJ6z+zSxzrGmyy6RzSJxC1j2xTy1Rxp+FmgfYJSkUFMOscl8Sd+3NzM0nd4OCAaLuv1+0w0qx3KEdBxJqpvjgLs2XN934nEpevpSRqPqYTUFeWuwUL/ChGcGoiTUEjUjUJKvieLdOpdLLwgNPmWU5+0DmHEGPD3c2duYp8HBAbbg3DLvxueM9Uos5JwUVADS+X8N9uO9mLDijdOTuFMI5PJXm/FrQ411oRn0klMfhRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 23:52:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:52:12 +0000
Date: Thu, 5 Dec 2024 01:52:09 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241204235209.v4xjweehhp5knbew@skbuf>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
 <20241204171215.hb5v74kebekwhca4@skbuf>
 <998519c0-a03f-4190-a090-f8ada78ea376@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998519c0-a03f-4190-a090-f8ada78ea376@intel.com>
X-ClientProxiedBy: VI1PR09CA0167.eurprd09.prod.outlook.com
 (2603:10a6:800:120::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: e04914c1-0e29-47c7-f00c-08dd14beac89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wvt3to+mNwvJMyN3rNEk7fpPFl+/rG7pRooRQfNKywmfndhZFJZHz6VIntfY?=
 =?us-ascii?Q?SfHVNiSE57IvDrVoqw9ZdIVekncZzjv8wqOkag+rnh34UqTYJW0IGWkNqkvk?=
 =?us-ascii?Q?RcyalTwmpki5u6zVO6VZ71DUS+9OL/LLmTyRMzXPtE5WI/mshhd5/VhjN6fH?=
 =?us-ascii?Q?sEJKE8Gc7HFjKMeDmlk8jLzwwYafH1S4HaItvEEVme9aJag8zV7PmZGSnKu2?=
 =?us-ascii?Q?fU/D1WDlZ18JKM1mSyIUMFTu82+Nf95agBgq7YPmMIC1kGYdf2/NnmeDgW3o?=
 =?us-ascii?Q?IssxDzJNpAtIPj6SSZj7aBarZYVbBZJFA8JfwsaZhGiP/IQN3Xps4XpjtzKG?=
 =?us-ascii?Q?SzSEL6+rvXFbi6nVQDNBcD2ZcUT86cStnYZhdgVf2+NB8U/QSFTKv5WoU0ax?=
 =?us-ascii?Q?cxiWMU4oBXYIOKqyyS6wdbhLJL2uqYsXzpz9i847zw1GHF0NRHmEJyh2HIIY?=
 =?us-ascii?Q?aZvffHqfxbLhEFLSSEfSj4JTTXuQ4sz065eiVDb06h5nBc2jYgiSqPGbPE4O?=
 =?us-ascii?Q?koi0eMMntEuWB9fOIfIW+wwAmrlIydsZUdk0sQixeaR5V7aI6j7L6mwE5KaP?=
 =?us-ascii?Q?nTD7uM/eZ5UiChfZ7mBGX9IqOb5hrH+WJwt5nlq040y/Cm+YvgHi6Fu2wWjt?=
 =?us-ascii?Q?m2xY8KE6QkWlhW3+Ic1PV/1Ly1kR/LNfcgmPp2jQtNEsS4TfJYifL/osGdkx?=
 =?us-ascii?Q?0CqPBZOzJxVAUSA/FU00n/uCS1VC5i3ytwsx6xGrcJmZETtm2tRg6ubCrmuG?=
 =?us-ascii?Q?9w3uKVHT1S+agyvQCOUweecEBtpKQjf/jfpitlUE78xFmDTiTBWA4vMNCuPm?=
 =?us-ascii?Q?1ZMFiV+z3EuhCpug6sRVfTgK5mGSWea2FiBE3dRXOq8c7O2M1JMKHxbf9tCU?=
 =?us-ascii?Q?tB24zirsW6EDbIggRGQu85jgXHLsqdr8OEUaoJqcGNKs1Qtqkh8sRljrxewB?=
 =?us-ascii?Q?sM82fL0syKxumuqjfWJXVZVawvCPsEKX4ba9Ll9GwFE5m+p9J2kfzfcSyp1t?=
 =?us-ascii?Q?FIAn4bqL/o2EC/Oneo+5Jzeq/ndvx1Gbb1UpagcEraciLVi5Fx910WGU6Pnz?=
 =?us-ascii?Q?MbxYvGTkjTUfeRjmtbCmQFDWG/z3f5gewb3E46Cc9n8SXMCl9WXE1giODuuE?=
 =?us-ascii?Q?opZ+XfwvKE2T3EL7tJL9HcJq1EVogd+oe1hKd30zYzmJuI11i4f8TdxmzZE9?=
 =?us-ascii?Q?xCB1FUqQeYEzZIna1GLaLO/GHUpwwcwBP5F2oCIHm2+/8k2L8jn3BPdhkj8N?=
 =?us-ascii?Q?bSc8tZYazo0F6cnbxTb7+X6r+RUMPHXGgGM2+m/3OEbmh5lbaybeNVbyzKGj?=
 =?us-ascii?Q?Gd+pLc2we1L0GYrMnIF+0vG+/aLa1xkEXZMKCJ1LnWZW3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uKZuZ9w8H0YBcBJoO6M2kUx5wjHgoJmjA8rfWPlhrDAPhcC82RrZNOsVEeYm?=
 =?us-ascii?Q?WJG8Gl3KwSkoZ1gYQAGjMT0kJwVzZJm9FEHJrNctz6mFwvqhah8lyzOuPgkW?=
 =?us-ascii?Q?XS3L/x51I/F1l23SeNrliHb79HuFywEou9Y9yURmDE595MvElVNSkB4Dy1XB?=
 =?us-ascii?Q?Zmzk91eb7Zu+OQgOv7v70SL1o9TtC7vqiEMZXF2mLOiVfstEWW/sYWcQiJHc?=
 =?us-ascii?Q?01ge9NiU4+Y+SgPHsS0tgu+7M00t7MWxj2mPBY1QvBXZFSxwhWXj9+or5a0n?=
 =?us-ascii?Q?3dQbn1kyH0EboZJQnvjeP7bkQtBsNVcHDA0GmOk/0DxW/mZSaIuv7JsH9s64?=
 =?us-ascii?Q?ByiAWJKWgA2j9LYA9bK/aLgA4JcofY+uUUxS15J/QfToyGG4EMdTq5A15ZKl?=
 =?us-ascii?Q?7BkshLxlaDOmZfWhVOajZA0UHkoO3iT4A4cz/o1CYHKmQeiixmjDJUd5tA11?=
 =?us-ascii?Q?zu6w+QAmP6xn+VvPPhnMnE6W3LAu4MGgL/0DXAj055tYBRpKiram6KftrJI4?=
 =?us-ascii?Q?sj/I7HQ9rDHMYcVK2vP/c3ToJE7gk11v2h/nqr8yChSk83oNsaAXaAN/uVgE?=
 =?us-ascii?Q?s6LTO784afu/4gGnOj/5mYQnWHi2Z9Ig5FPLGF9pBQokjYvIZFtN/R6uydOP?=
 =?us-ascii?Q?vQRY9U/eovW725jBSr5BjqUuMJxmqtCJ7lW0t/AJZjCvJxWUuBPaPIcvSc+i?=
 =?us-ascii?Q?Pl8OX3grcf4aKAjW+xS/t53Kj4MXwHKCB14r9F6vTggUePCdASCru4ScrH4j?=
 =?us-ascii?Q?IliQhFr1ERGuIRvDz92g/9X6TZ/CrxMEfexLG9m5T/1n66N24cW0KbYTIHFh?=
 =?us-ascii?Q?oJhb/O+GNmO3CMYIn/0I/nHCPz7KI/FNNH+Os9WSrxlM4PU9n6v7bAW+UJT9?=
 =?us-ascii?Q?gWl1TiylqUi3tqATfWwrkBPsRHP169wi96hbeORn1jBAcavCJRX0oqYcPlv5?=
 =?us-ascii?Q?tDxsDkaMYx6clDf5PjzM/kNVBYXXp/BBpCbhFbt1Ss93vW4mnOLw6cpvCsb5?=
 =?us-ascii?Q?NK+6V4Nf0lYlAuVO2ziaoYRf12UsRkuAuB0jnbbs4PeqCmts4IfHOG69yEX+?=
 =?us-ascii?Q?ry+VDfAcBBPs8CC77w7mjCH6Ho1QzLv0/TzW33gfZ3k0+uU1ysaNG4FP4OyX?=
 =?us-ascii?Q?NyQ5/uj99QSzy3oJ14lGebjU9WJjPHEDID0SVLENFPo+szLHS8FgVdC6IE/H?=
 =?us-ascii?Q?eYJdPyxIg3i2/JM5M/4IerT9cIkIqH8/pw1iBvKVi/YF04C48Z2aXFKsnw2a?=
 =?us-ascii?Q?xEA1JPmWH0DVLsX+zuI/DlrV+qsrOsb0e/a0EhA/3+XB0pQOYhhuchpFFV1h?=
 =?us-ascii?Q?slIoQyJunltUrK9UMPzo98UBTVlILlb/2VA/gB+235r/ygDt2YgoFlcg3cM2?=
 =?us-ascii?Q?qAT88HJ3qRVLkqR16+x0VUo8ncODFYYyoCvuZOz7k+qy1SMFFYeIV/HYqb9N?=
 =?us-ascii?Q?ZIA+zNSpb1FRS0faLAsfbZ+x3Q1OdrOwF//uX03p+Ym3ZHdiry3fp8R/TYvg?=
 =?us-ascii?Q?hpx5EfO66hkaZP84yhd0VsLe62KCki4TVJb02fOK57A4goEKBRXQcJsDfBXO?=
 =?us-ascii?Q?Rdy14zLubHDVYH7HlpzpTi7N5zmNn6UvVxkdX9WKaiBJqEouXZx01g/e6f5h?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04914c1-0e29-47c7-f00c-08dd14beac89
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:52:12.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OkbozafyI2cr4/x9CqVnnjrxGSjT7UW/N23jFzD9OzSyi5ZhFPibzR59e0ilqKghxMPUQdqSLzBiAY/MI7xgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938

On Wed, Dec 04, 2024 at 03:24:59PM -0800, Jacob Keller wrote:
> On 12/4/2024 9:12 AM, Vladimir Oltean wrote:
> > And there's one more thing I tried, which mostly worked. That was to
> > express CHECK_PACKED_FIELDS_N in terms of CHECK_PACKED_FIELDS_N-1.
> > This further reduced the auto-generated code size from 1478 lines to 302
> > lines, which I think is appealing.
> > 
> 
> I figured it out! There are two key issues involved:
> 
> > diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
> > index fabbb741c9a8..bac85c04ef20 100644
> > --- a/scripts/gen_packed_field_checks.c
> > +++ b/scripts/gen_packed_field_checks.c
> > @@ -10,9 +10,10 @@ int main(int argc, char **argv)
> >  	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
> >  		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);
> >  
> > -		for (int j = 0; j < i; j++)
> > -			printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", j);
> > +		if (i != 1)
> > +			printf("\tCHECK_PACKED_FIELDS_%d(fields); \\\n", i - 1);
> >  
> > +		printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", i);
> 
> This needs to be i - 1, since arrays are 0-indexed, so this code expands
> to checking the wrong value.
> 
> CHECK_PACKED_FIELDS_1 needs to become
> 
> CHECK_PACKED_FIELD(fields, 0)
> 
> but this code makes it:
> 
> CHECK_PACKED_FIELD(fields, 1)
> 
> Thus, all the array definitions are off-by-one, leading to the last one
> being out-of-bounds.

ah :-/

I should have paid more attention, sorry.

> >  		printf("})\n\n");
> >  	}
> >  
> > 
> > The problem is that, for some reason, it introduces this sparse warning:
> > 
> > ../lib/packing_test.c:436:9: warning: invalid access past the end of 'test_fields' (24 24)
> > ../lib/packing_test.c:448:9: warning: invalid access past the end of 'test_fields' (24 24)
> > 
> > Nobody accesses past element 6 (ARRAY_SIZE) of test_fields[]. I ran the
> 
> The array size is 6, but we try to access element 6 which is one past
> the array... good old off-by-one error :)
> 
> There is one further complication which is that the nested statement
> expressions ({ ... }) for each CHECK_PACKED_FIELD_N eventually make GCC
> confused, as it doesn't seem to keep track of the types very well.

I only tested with clang which didn't complain, sorry.

> I fixed that by changing the individual CHECK_PACKED_FIELD_N to be
> non-statement expressions, and then wrapping their calls in the
> builtin_choose_expr() with ({ ... }), which prevents us from creating
> too many expression layers for GCC. It actually results in identical
> code being evaluated as with the old version but now with a constant
> scaling of the text size: 2 lines per additional check.

Yeah, I think that was the logical next development step. By doing this now,
I think you just saved an extra patch iteration, thanks.

> Of course the complexity scales linearly, but that means our text size
> no longer scales with O(n*log(n)) but just as O(N).

Well, technically, the number of lines of code required, in "naive" form,
for overlap checking of arrays up to length N should be N*(N+1)/2, which
"grows quicker" than N*log(N).

But I don't think we can talk about algorithmic complexity here (big O
notation), which stays the same (linear) in both ways of expressing the
same thing.

> Its fantastic improvement, thanks for the suggestion. I'll have v9 out
> with these improvements soon.

And thanks for staying online with this effort for more than an entire
kernel development cycle! Looking forward to v9.

