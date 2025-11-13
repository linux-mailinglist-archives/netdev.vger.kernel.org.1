Return-Path: <netdev+bounces-238495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EDCC59B39
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1573BC861
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858531A072;
	Thu, 13 Nov 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q2WR4TwK"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964322FDC20;
	Thu, 13 Nov 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061332; cv=fail; b=K0cvmRBWxnivR9ZtStTHkhSfGulgtcfH3RkwomWyrdErp8t8nO8HFKXaq1BxXKxjaPHu7v12jUE6SOI/Hgjg9tcYUcPTLR/yyceaCRVkioddwvQhdfcylRIcDGYiqe3FncmprlToOQkzg5RMFMJ8LSBAaq4v/bxg9dc3KEL2uHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061332; c=relaxed/simple;
	bh=7RmSSlhkTOyDhfJ2FWvdKSBJSyZeZwxYFsGLzCTVu+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdF9q4fJX+qYlUhzFNqKpxfcRT3WqUyFwARw3OddxM2SsyYeVwcMUgqLtLMXJ1gThWJudPZ4/lLfZfWGdeEkwX7fmajie35Ta8XBsslZ+4efzfqDcDS4sFCkw0YuulBqGrc6L0/GVMi62P/YCt/Isz+PmI01Zj0twSPkkC/2wcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q2WR4TwK; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlfQcDPQEQjEMmo1fZ8hWxnDAkz/AnlBt0cokgx2DFdifDmutrVNl4wg8dqCOVh/WAdT061WkKybi/JjhkVutHVwXK5EOx+4OnNlRTDaClh0F6ERZidmXgHW5wV7NbUgqGbvNlNnv2pRrEL7PU0vSVO56Gwb9soqoMjOoSU5Au59yVDuktMXLSuPrsAqG4QWSnfBhkzgCtwzP8aUd+qnhYB/yJSmKM+7qan9QYZtdGmQWoU2CEqcMrwCPNVgFEvHuCaJQlLNEWx3q+nAArLt2xMnkC6JTlqXWTONzVFlXJ3l6PYFgL6hizZWw5Z1oyMEFtzLkUcPcqgCTpJ3ix85ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpsyGLAojMNpdcceZn425Mwaoyq3wAx2vBZqZKaFalQ=;
 b=G6GfmmDOQatiYcBb3r0eodmlrgYnCXp+PnOthgI8YvyeTp74aDkFNDewlZ7YJvoIQGLNI5uWf7UDEtBeBSEI/rYUXwWMglsIrecoWM3Q/PfVWcEKa3ejCpPhMOtDnw06Ai1fDQiynp5gM6MKaRz18AV4ZCU+kDHZYqnx/Ws/1UC8+00WAUdE3aYT1swkqalABd7wC1P8q0YhxnZ6+pXwIJYBybi/C4RN6JYWLuQCqLiuXb2T4Sm594dPEFVI3fGG4ox/jI5bXcVmrT+m3jQqCtsVDoLwbAu0DP+zMm0BvOrUynyIbF2TnL5XMFHibfQ7vVAIG0dhN3+aIy+NHy/Ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpsyGLAojMNpdcceZn425Mwaoyq3wAx2vBZqZKaFalQ=;
 b=q2WR4TwKdg/Dpp0rdBZYsq7M14wfAWryb496j32qrSp++7sC7w5o7ujyDT15bP+CoyWCdJ6Ost1uZrZ1mcVIhmCtPH2jQR7VkN/rR3xjHLRwxyTYf81W8VVvL7u7+6EkZX+4YUQyTJdqMHRhsyNM5XjOs+43zaQnq2PT1qHvImcUsdPwqAsmizgGDjYxNZ+DTcCVktR5b5yUEvagiHaVSkEODZ7N1PdwWq7Ub052B8cY+8v8CjpeZIMJg8lOMKcKSjx8aiTV3/++Jjpr57NsyPAs76Qr8I9bJBc/J4zZd8yg5etP5Q55KBfFZlHP0SdwQxml3kkXJygFwvzxYkRUxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 19:15:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 19:15:24 +0000
Date: Thu, 13 Nov 2025 21:15:14 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: mlxsw: linecards: fix missing error check in
 mlxsw_linecard_devlink_info_get()
Message-ID: <aRYuQpOqe6FOM7CI@shredder>
References: <20251113161922.813828-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113161922.813828-1-Pavel.Zhigulin@kaspersky.com>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0fff98-517a-4c68-56cc-08de22e8ff34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hy6E2hXWxsQuPhwvSlDG4I35H9yVh5BfNct13iESKRI9FDmLvn64g5nu+QWU?=
 =?us-ascii?Q?OnhSwTy+G555vyLRkQuLMNTL4fRnd/yJwLEhuX0yqaoG3blx9yePNf0Chk/w?=
 =?us-ascii?Q?7K8Z+bWHGMppmLdpxO7LOKgpeEL/8zdBtc8HcrfqWElQuGEYbdSrRMZTxEqb?=
 =?us-ascii?Q?3vmuApUtA6yI7YAPZiebDrygdEErFJ638usB78bPJz04Ad2oBLpFUy3Ga5gk?=
 =?us-ascii?Q?Zaa8Jci3iTGfoQimjtwJpiWW+jux32xFiWp1r5JHwBFVutB2+GsnMUFg54Nv?=
 =?us-ascii?Q?fqgYO9LZsxFZ8ZPQKAQoPMxuSsTPTWD7ahPfm9KhO1YyXiTkPdaIoirb1dQw?=
 =?us-ascii?Q?ByH3/8e6Ah+PsL5reBIQmEQC+ZF56sCc7q/XY//bjh5iI2ETQAeECpmzBWym?=
 =?us-ascii?Q?u5re+HkvLuKJ8pDaZc20QH5ZNDS+IGwaGsMgwA3Gn7+9ZBabO8Y2j5bEOxR7?=
 =?us-ascii?Q?TG/nTDLUASXRTeeliJQAJQCH9OdhVjIUxdhWH1Yv3QhOSLPkCj+Z2L7aJixH?=
 =?us-ascii?Q?Ms44QlRlSNudII1HF0D62GSgrhyqiNL3SM0N01aB7vOlZd6ibgnJ7SdaWbbh?=
 =?us-ascii?Q?zxTMZuBfWb0XvzuXPmmF4uPvoVSBrZNuAbZ6i4+ilkgI0pqUX8LtucqmJl5D?=
 =?us-ascii?Q?TpwooIL0fVsStQnlWTgw18sGwqCNpDDBsD6OJNQpMLyqRvICpybUEuFlSI/l?=
 =?us-ascii?Q?JxmfCAHpZLky+eKunIpOoSXVwrd8yx0RHvd2MdENOLf0Xgc+N0zIYkhW8QrE?=
 =?us-ascii?Q?7o7yPw8sBPU4lak1gpfGXsDOmUjVnG8D7zvFu8G0u/ls9tfMWbXgpe4AeITu?=
 =?us-ascii?Q?QQQWXKcN78zZ5U7vXghYIzdbcgNSFwF+zcwmsrBL1R6Nzs4Mt9C/ppNvFdaW?=
 =?us-ascii?Q?H69m6xvpdUPke3xViAnXa1sXtiWuh0TCEWzOmFZkfzIiVaOqKXbHg33m+ont?=
 =?us-ascii?Q?HI+7kovsbeUHnaWFsqD1C+RGPICfWy6JtPen2WF3fL/i4vGtrDPWQWQihC5Y?=
 =?us-ascii?Q?JawyaVhT1NYJIjnSmeiI2yym0HsYHp7vyQuUHO4Z/OW6JbAaKOKR8VnqvQPl?=
 =?us-ascii?Q?/RCwUVSET3ffb1BJMarwjbiGrW2KEYdOrwn58d/g4/58tJtwnipHUFEVuCwC?=
 =?us-ascii?Q?zYk1QmixBTPM+S0hCFS/DdegGxQDnRp0LLPoRpTjbZ283VYBvlkrBf3HnW/G?=
 =?us-ascii?Q?HMfkH7uX3wtCsxRqvrK237lVhiXf1wkqoy9FXDxvQuJiCCNdYbcuU+P2ykGN?=
 =?us-ascii?Q?bM2wS9vre4PG0uVoI1OKBq2i0ELBs7I5CwAeK6Q1x0zTLqOIa1wzS5dwIyXx?=
 =?us-ascii?Q?C2invNSU4ihevEAJbcW/O5MmbKRrWd9D23rEdx1v5hDJlDc4emU0vXJ+e0JZ?=
 =?us-ascii?Q?fVKJWVV0pIKZB8WnesCFdN/wzhndnRhsLCOEOffSVJfDYdTbU6ZI/dCWwSby?=
 =?us-ascii?Q?Bfr1NWamdw8GqsFYb0LBHFjkNJDha+qY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nYpd7LvUOgukm+Ietw0BOpn8eNP6r6zPQYen2fGNmQW7gAPIo6qpBogj4Zkm?=
 =?us-ascii?Q?X/lagBn9lJ8efycr5oSZzekhEv4Dk9rRTysbReRq923hWwgreLamG6Ovk8qk?=
 =?us-ascii?Q?pQnO+hvFuP5zBqz+4uRFmwG5E4pj3DCBM3nZQXdhQuiv+3o9SF+5FUZyeIax?=
 =?us-ascii?Q?2ielIe+Vhsn6EdyLT8NoPZZB9odSRfoUI9erkMTLOBw5vHO6i5CqBHncvcq9?=
 =?us-ascii?Q?rtkSkBRSd68qyN8Injg9+nBuPjhqU987JsvnwdNMtyoP0V549948CrT8FEj7?=
 =?us-ascii?Q?jp+Eha9lqyuYBW58Q6JdiWB+0/2dDzvXdH1s+0KkbIMA+XY40/xes2TawqzY?=
 =?us-ascii?Q?qx52IQcrWxVNVjd/BgRGpnRVc1Iyq8r9lp+grTEcl/qwry3K353mF0mjqS5n?=
 =?us-ascii?Q?9wl1zMd4y3rn8IPGQ7ppLQajk4Qcqsd28GjdWEe6MbqjwpnZ1Nv3m58gvp5J?=
 =?us-ascii?Q?yURX2XPq9W+iCuy0bFwQI9GmLXfehUE2QilcjzaMY8EiZaiLA+F+mJNah2aQ?=
 =?us-ascii?Q?9znucXpPYQ7pR/ernYQxEg/mSTbwothqkpA8hq7c7uT8Kj4gkJBVKiwWfkVW?=
 =?us-ascii?Q?ho6vmOFNAHXPoXdEWTymZkNbMXmfRiHDSzGq/IeGBM5qmU/OlDfP7blU/z9S?=
 =?us-ascii?Q?Za+cPLA2v/WhK2CKU/wJfzx5g2uf4u1Kj6Q1rXvEEHcHDKbW0Uc7G6FJKwPo?=
 =?us-ascii?Q?sehSX2nNNnU66QpvpTHbDWG3P3Jjpsx8/HvW9IHWxWqYM8LsBpEARokqE53x?=
 =?us-ascii?Q?fgeCODmZVIBVcEYdoA66FIxGKA91HBv/RSF/LyK/gbLTrSReKOp2MJ8ktHN9?=
 =?us-ascii?Q?0VVIs3dLJeLAxzuyM7qi49YXaS5/RLo2348A0ZTBZ/kkb6EaACyT6A+rDu+4?=
 =?us-ascii?Q?ix03ejucOLAEu8K5lgGAHfLaTiNQ7rA1S20YG7e20+N7f49ExFu1B4c+0vJF?=
 =?us-ascii?Q?wFdXNhcOH3YbMlRm42ZwdVjNnPLmb/0Ufn5TPbJZmytuqfllEhgHkPxjmsuK?=
 =?us-ascii?Q?bfLPWEmHJbqQg7rI3sPejP+GiYcl6xVMlCcyyyQNKts6B/g2LZFmgP1hlB75?=
 =?us-ascii?Q?2YUuIiRnqRyN3upLg+L4vnW2h+PiJQ85XvnKeZaSsC2nWIxg+XTe1EtNW/J3?=
 =?us-ascii?Q?raxGkucvLp99UYl6lqJcpmLbMebMjwjUQ7vWw7qmw8CMUyh3ae0sjleJ5cCW?=
 =?us-ascii?Q?o0nrfL8eXiszT72k/uo8gR0puAyrN71rUV84cdXtamuVYPsWavarr3pvECXz?=
 =?us-ascii?Q?VJ9ryy5v4eaNvrBHWLPLmtYFPer1OrFsfXSTX0Uh0KWSthrPtiEzqQJEvxPG?=
 =?us-ascii?Q?4vAPghto6/rHyAIWZw3zIKtWD0uRDxo3ZVVerPwPANcb1AlE5IQtjAUlZHWx?=
 =?us-ascii?Q?5RZ1/uHj2t2VgU4PmBKrZMiSxwsLJ9qVgIMEu8CFIfTCVOW4vmdodQ9/VdoJ?=
 =?us-ascii?Q?CsBadMrr6ur0M6FpgVL0kvBfuPJLOxjxFXVE+f2rIWQGm+Npr99d0KkmfJbf?=
 =?us-ascii?Q?sRDt3ckoEcv3/a/yUhL1SVS0TRGvisd7YwgnUxLcAffMj2RAFu3FyThdz8+2?=
 =?us-ascii?Q?jgxyIp8j00SgGkdcXcyoiSXoRP47dbNNcZWkNBFy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0fff98-517a-4c68-56cc-08de22e8ff34
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 19:15:24.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3PRn/IXwdhbaT9qMsGhnkC2hv+5pQ5sqRqIybWy4fAq2yofRAUA+Cq2Aqdu1TXoMQLmbFR6bWAWND4ky8jvSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975

On Thu, Nov 13, 2025 at 07:19:21PM +0300, Pavel Zhigulin wrote:
> The call to devlink_info_version_fixed_put() in
> mlxsw_linecard_devlink_info_get() did not check for errors,
> although it is checked everywhere in the code.
> 
> Add missed 'err' check to the mlxsw_linecard_devlink_info_get()
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 3fc0c51905fb ("mlxsw: core_linecards: Expose device PSID over device info")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

