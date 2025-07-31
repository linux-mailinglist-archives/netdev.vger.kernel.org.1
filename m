Return-Path: <netdev+bounces-211196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3951B171C4
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B867A93BC
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E92C159E;
	Thu, 31 Jul 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UG3vz46Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFC230BC9;
	Thu, 31 Jul 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967275; cv=fail; b=eWic+Kcqqu5eDlVBdMfuNB2XpYhG+5Wx9s2sdgktzR978ez/8EG9siGKcMlEMtemKa2SWAQKiZQ0AkJPkIP4mbF4+j7PwnCmOKxHfVlY7FYVtaYp7fxpCrCzZqL3LgrDCHMKevstaXSCsB1ajfyyllSaO6qrh2KOnABPeC1A+aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967275; c=relaxed/simple;
	bh=NUa4+q10QvXEbrT4dwitIrzmpF6SwPcr7AW1oN8ewmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lsxEUGH1d7bfekYVqzAyDI8t9Hn7iAAPX1bxvMkBcx2PmVF7t8aE/ADA+nIHBBqcu1EOmWnsa51oGh9Kh3wp0K05trnHgvmBgNpkF86LWKEZsUyZr8xXLQyH/pIT3SiJzR0a/iO1UMMqaQOnLJ4mcDRSXBdba9/6LsM6JtH9nZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UG3vz46Y; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2mWBzPo6yJ437RUOUvfv1Ptv2wd70PAvBmoe1l0/52+VDJ9/E5SnYCm8kVglxMCUx8PklosEnvk79t/R1+T0MkRQs7lsXp96Kmnr23tqu0AHS8UbCjLcUIrnaV/tq/U6dzeqcwkMq+OTSaYoN6x7j6zHZm93HZkD/w8wANBISMt3kXaPpK7c2R4a4mt0a/X1IWJK985QCFTCra9h5167QKol1anjfxrDwv+NblZNfwSaYwaZdAH2i0NMYFNSvAux3jjzYjRlp4r7hCnZ/vEJdQ0MdWQ8D4Ni9TqvBgsA9BmOA2J6W6/93RXEf4pIf7+eyC70bnRweVGK6ghFTWvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUa4+q10QvXEbrT4dwitIrzmpF6SwPcr7AW1oN8ewmU=;
 b=diGSVtNerq9bVhQ/s9KJ0BzPagK2VwXFbT2PKfuCzf4EB6Xp1h+6rESd704eqn7denEcbbuIm5b1RrqERYTXpEarkGuwc9t0ESIciDfY9uIRWBKI3a96T9Em0Fx012OgvkB8f9wyA6v49gwDp7XzyIvZuZ5ud5wuBSMoGwebzUmMlAlVRxxIYgiYGaUluOYIp1Q3u3kdpIAwhYVzJ0yJ5u/WirweOhnXJdsT2yhGQKD7mnwDAZ5h7Kah5BMMgxjL9WrkHVGYEYLai6d7tcuIXuEZYMG+Hm+6WYLRO35xiz8uN8KjjkHhBtIi6h2XDyIag8dJJI1dTXfazFbp/mmRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUa4+q10QvXEbrT4dwitIrzmpF6SwPcr7AW1oN8ewmU=;
 b=UG3vz46YxnZrZBEfEpfNtzQvSSfXKRHj7/1aHiSQI/OXmplY9nBTtAPozqEKvPAUWoT9bEjZFqilVS6MtF+gA0El2bLyI9FqcSRPE9ZedvjWB2DbF/9IZPNv0VbiHQQCrTcY9JaTTn/wgVhq7yi8/usBwPrSpl1XuYvA1XwhxcRTVuNPiJiH3BRQOttFE+OCKd7uQBSDIWR9WE07kTU7Ez9/NgRCxIcL0XXoczO1A0c0KHHMCzGy4TTnFovK7EDtaCRHzkALRTVzbLozTI38l+rpA1xu2UvwB+UnSQL6odz8cOpbb0oAQtY7DKhJrFUbY/LNiLlXsCGkPLeV2kQvkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 13:07:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 13:07:49 +0000
Date: Thu, 31 Jul 2025 16:07:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/4] net: add local address bind support to
 vxlan and geneve
Message-ID: <aItqm7jTgIGvAXYk@shredder>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
 <aHz2Y6Be3G4_P7ZM@shredder>
 <d1f9e74d-0a69-095d-f5e8-f28f13d44e1b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f9e74d-0a69-095d-f5e8-f28f13d44e1b@gmail.com>
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f563ed-fc3f-48b8-bc5f-08ddd0334012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qrwp+J6dFab+PTtiUiC//C+dkklAIVJjlxyCWOZkJY154DDMElXvxCvCNYBM?=
 =?us-ascii?Q?zTmFVncJXaY4YiR6VPsKJ63C02RJz0Lc34cQVH4/fx4WtHsbKNQaEdt25nqF?=
 =?us-ascii?Q?nvghqeOYUwUgJbaIBBMuLenq20oVkWZNrXm0R6kJ2Ui9VkvS3dqPaT5DiZiO?=
 =?us-ascii?Q?/H5P2v2SQchIyq8FZTbxpqa2z15hRVccCZNJvkR9lUb51+KFfVNxgO0CPdJ/?=
 =?us-ascii?Q?bzE8D8WFyegvSB/shVvkTDUxjl8zkOGU05eJUhQAxc/7l9gnu05Om8k/VoMA?=
 =?us-ascii?Q?l/GV1A4MwO5K305d5CeHWp4utJbIv/Zzi55JL50y1Bg9CwjJLhoPjKcjopDr?=
 =?us-ascii?Q?i6wI0nyCm5tEIkwsE8eP082HT1JNlIZupwRrn3ijyI5W1Iw2pvh8MxLUhnif?=
 =?us-ascii?Q?hjIiH+8FGkp8crx3ghssaqtVy73AVVubFtSus4vtMjnfAWlKfZrNhCzUxz8Q?=
 =?us-ascii?Q?/whcWzdpZiRPrWVRtbwIJIBgz2PUJ2cgQMdddef6Ys4uJndBGH7tbQdvMcos?=
 =?us-ascii?Q?APLGQpE+I1Ipvs+UAriDE4B6sbtQqxFoKNN807QJdwsovC0j8u+1LBgzifCg?=
 =?us-ascii?Q?EFT77oxZnYoYl/Im5enLV7wixastDictHavFtQ+jyQWalagpNFSQgVKjm1X5?=
 =?us-ascii?Q?4eCw5km26RT/xfdYZB2B6v9rElk82KWdlWPKmoFsN7B1wk5EA+P5+wZ8AbFn?=
 =?us-ascii?Q?MwN92BtmYf0tS6Ggr9TjFKTvDAIlMxiqgN8e93gt3OARZmpKqDkF4iodFT66?=
 =?us-ascii?Q?kJytnFgpoIzr9Ju0hrbQ4sg4OpDMmenL8C1ohuTgMr4SypJZidYGvpt05efS?=
 =?us-ascii?Q?sUt9zzXH/RasT/bbOZO16CEigyo/FwhPWZMCbnKjNxtRbURWyf/vGc8omrg0?=
 =?us-ascii?Q?cCltmN8VzmX3KkOrirBgFOdPwAQWfMvDZMofbUthCxiYzQLyeUGEcglq95Bd?=
 =?us-ascii?Q?utKxKYnHonWaGzQvGfsmaWXGC0+9nyGeqD9tXQId6hcxsv8j+0FGxFrKuXcH?=
 =?us-ascii?Q?lZF1cfpGCOhQ02EsQc92uu8LjBoXni3m1UebTXCP39vC1+EuJaJaJ3QfMQLU?=
 =?us-ascii?Q?A+uJC4CnOGWlqLwxH4Va78oCb3zM26Oab08P9AY2Dmg9fDJpxVREidDDsIfP?=
 =?us-ascii?Q?3C8cy0PU9kvT13eGkLXlIewuCEFn2J0v2+DY0mjBgRSnKZlzBdGzI8Wf8OXI?=
 =?us-ascii?Q?t4xEmp/cW7vXg58szV07S9DlSGdoGTofUb4z81ZpLZMIyr6T+oSofwfi73oA?=
 =?us-ascii?Q?vak3JvJ/wkL+M2O9Qeo5nOIqr/Xb+idlUhYQM/Yf05nHc2sPfM3GEDS2n5lh?=
 =?us-ascii?Q?tjf0i8OWhp0kEKixMKjSfijDBfggWlDyrnA6NBAfy8M25VCdD0WFg3PvRCNn?=
 =?us-ascii?Q?bbjygN466fr5o0KJxixFl/uZJ/u4z2Gww5PwbC4gZEPxU+mRzXRHZ5Zgbuei?=
 =?us-ascii?Q?Nti0aL4Ao+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IdmD6Ecj8F4RRWfAlfmg+1bwaG49h8sC/dIf/rR2sDuBQBGifkEWtpwb53RE?=
 =?us-ascii?Q?f59c71RlHIcg6XHFo5F/LJrrv10yqUNwwJYXgz/+jUSBzPmnAMPKLUrvlXWS?=
 =?us-ascii?Q?Io+GUMdfBswgNoqFUSfHvMkBEqPimyVxfFWMDOAGgjyHHjdwc8tmKslTd3L/?=
 =?us-ascii?Q?ur5WpQeF16/07WdqnXCnCEwxaiDx5AwOdb6fSNkQH3KXcxSPbZl45ZOTkNGP?=
 =?us-ascii?Q?azo/yjwD/yzWZLjrSjeJR6KmVoNX2SZwAdk2qPZo1+cZX0wjLypTJiiKkyER?=
 =?us-ascii?Q?VgGpb9nJ6++Hvj8PtTdkChx+S1/HAEmNslF6iL5+SWml2sBltrLhMk997FQ0?=
 =?us-ascii?Q?RbD7L+FI1SLKFWT++RWLx9eXvtxiVGFym9yTpbDHLpJd2Cu08TEsvbjXo/AB?=
 =?us-ascii?Q?ajcrCEfR8Sd/zrudQLIicSfvd5Rim8AzU2mSQcTLY66RYq4bwnwfr4duVADp?=
 =?us-ascii?Q?QSRMkdCbtEeM9GOf6T83eC1Lf95pIlRTDLSsq2/VlCkSYijTIfznOgYe7oyA?=
 =?us-ascii?Q?c4NrMdQv/TSo5P35dn0+A9ii9r6EqoOSfXkDLBwbbkwIWACBPKlnf+8+JBFP?=
 =?us-ascii?Q?S2fIGy+VOaj8sAlYDeIcfKzF/smn9Bc4up1I1cuV1M/lIY2xFJzId+jcG58n?=
 =?us-ascii?Q?Z2mCTffSH5s3U+G5nczr9C8H2T5nUhE5d7DG6OqFSNLnw8V39r+eAwNf6jQr?=
 =?us-ascii?Q?gQoXTxyJhj7RySPK8EuKa9RFfWciLuhf5q2ZNd5ixU/OnpMNXFKOK0dQ4mnG?=
 =?us-ascii?Q?F2BHz4RUENK9HeY1yr06WpD1XmBf0zHoDSzvI5M8S7qsVii4CgOogMaOcj2A?=
 =?us-ascii?Q?4cQcWoGjuhqwG4Dq9ZyIQ/eSJktKj5/mjaL8Jtpr54+UgYhvUCD8fucY3T4d?=
 =?us-ascii?Q?Tnte9uhJmJ60Y/Mbm4kaFtkfW0lP2iwxMuB3J+PfPmdbSEzoi6AnJItBeH+c?=
 =?us-ascii?Q?ZIg3YeI0lEl3OQzXJsIOtKu8sHSTpTn5GO2ukx/VJVnS2Lv0XxRRG49gWyU1?=
 =?us-ascii?Q?NCQL7pGCkr03O4NQ3YwTgX7RnEBrKPMno/5FIoHWJFvPpaVPLvGL7WMy7Q5N?=
 =?us-ascii?Q?zXmdoC4pjao4Z7D4PMoSsUT5A2fZ3LrEg4TuiJr/NMZDyaN5MXmmbl8skEGl?=
 =?us-ascii?Q?cHqLkok6wquaEs/JXkp9cXSazobiclS5oQHcmCOQNy7pBmDn8Qy44DQc0uQI?=
 =?us-ascii?Q?f3dcA/gOntE/jEwj0xQYlu12mDkuu83+4R0i8MB0+pBlKvd3Qb4VnkX8I4my?=
 =?us-ascii?Q?T1UHU/3IP34/pidailxs7eRU2teBh83AwMR2IAH3KjmWYIdRx/sR0J4g3e+F?=
 =?us-ascii?Q?foujOebseqC8YEZEtoZ2hscY5DMF6RLvkXXLGTBQsx6355Mw4//xLqK+5HjS?=
 =?us-ascii?Q?sPuJhGObvBsgLK6HyYEbhvUPNPPo+lGfVhkt2I4ATXRwj2+f+v78GEPVPBMu?=
 =?us-ascii?Q?CtdLGsGFbOSqwHHmrpQszGM3pOch0sA4APzuSOO/anWclGYzswmIpUDCpQE3?=
 =?us-ascii?Q?fBmjL3u32yKQQ3MQ3h3xyZzCBD51KejugxQg1qxvrPczaj7ZB44m20TO89Od?=
 =?us-ascii?Q?DY6fBU/bGViuzFMnvw9rL9lv0cibeOKbQrYqzhyo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f563ed-fc3f-48b8-bc5f-08ddd0334012
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 13:07:49.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzoZlo2z2Vr5sHNQFxFp8ZKI+nuUZGfx6wOVYAaVI9dJZ5ZUW0QPWnpP4wIIIXTrCM+JWflbw5ykRstLs3P/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

On Thu, Jul 31, 2025 at 02:05:06PM +0200, Richard Gobert wrote:
> Do you think adding a new test that verifies that the localbind option
> works would be sufficient?

Yes. My request was to add a selftest that verifies that the new option
works as expected. I usually test both good and bad flows (flows that I
expect to fail) and both control path and data path operations.

