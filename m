Return-Path: <netdev+bounces-175136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08722A63701
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 19:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EB3188D97B
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3341A2547;
	Sun, 16 Mar 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rFOj6rPd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B51607A4
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742150085; cv=fail; b=e5UmUYBpbHurmnJZiGtXh8onL5y4FuMLx2EUyHzE88C8sEoO+Mbz4wB+azk+oTJiWpOkB+SfGXwANEmHyFMhCTFIGYt771lCat7O/ZWrULlCK+csxD2JogBkHe0D0Cme24p/MglL6BE92sfXc2IC4Qqsg3MOZpMrFhM1aFWFyBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742150085; c=relaxed/simple;
	bh=DvhU2U4rGIG501R4FJm1z9XCFs+ZyZrk7f8qzWjNWSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EINzycHR6pZinUQHwP21rYFK0YloLJyQHmFRG26LDHrc2I/Cyx8+JnhfAF2clt46vZW7bSOYLD8H6XzKGezI8hcUWvHrCgVJ8rMZ9BHdn9qEEevAjveYpqsR8MzbzbZPKeKv8Tae4ffrRXPam2RsFk/DVNO5t8fxtgOAoSmcBsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFOj6rPd; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwgov3zoqHoszY5F8NVhPeyYsaD/PHJIEj7yjwCh9dyWaqd6U39D0/F53UExWh0N+bfkESmKrsCDp1BYLjgFJ/Vf1ngUiaY6EZvZXOlta875Buq1X8uqyXak/81EZE2dKJ+35b8DGICVjp2eRoZX/XUexPsL9G2BsZpJRIbr+5Mels5tJYkeKVRfiwD5hQucEK4085XlIn98SImKU0t7LvnXuQ/xmXWko7KLG6YfBpnmapwJKvCByo9DgFbWsdV3MG+LWhWBfJqzdkWxalkaAZhP6M0Wq7FiuU1clD4yNUDIiAC3NTUSbkUcp7GHUSfJYnB0OPdpOjIHREJ3t6HncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ7pZBd0a1DwlEvYXGryw7H2Sq+RjYgToNstEYAu3CE=;
 b=bm3o8UVeRdJE/gZJs6HmZkgl4TR+g+vnMIzT5eomXb8k60cynGgJYhB/JTn7JMDanR72O/GJpM079t3bB1SWPTsRZ2oFprzOTv62zUe92Y1UpOusdcWNlmE1B0ORg/p5g1qFOjusjLzV+QBP3XMSHs/MsBNE3WGQOROtryv/AmbTTU152w1mje/rxwVkqZ13J2Rg3lCGOc7tOWtfvEvVTQpImP+GLoWguOLp2dRrsWg6EpFbVh2gq4V81wWxNl7ZByWRICF72dIJipO5v9P0HIzVGgNFO0UzEbwSULSbFAvjiF3HdVw6xKMclb+xjVDgdaojnjBBVU4XW2pH14gTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ7pZBd0a1DwlEvYXGryw7H2Sq+RjYgToNstEYAu3CE=;
 b=rFOj6rPdgi2rxn5t5irY27To2jbQCYQOgawW5xWq1kI/aJpbToNKCvlB9l7H/xl/xscJXUv2hrC0OxjYnvp/4qAlT6ZGE5wNxbOVzTzj/yEw0Slaee3JabvCitj35HnjCwnVwRHN18BAtP+E3r5BtlAaG9NGyqRro9IfGddbuF4cPfdTHG+1JOPtpxhKYSrDJAGEZWk0nhXCctVX8ng6Pz/agggyXsT7PwUT29UbpFeAU+aQs2upPACiirnRh04BMD1GI6T+UGp1wpemr7EoZnw1xh8BgiVkZEwSWyhvMQkdoDYWZFuB4wz3yaxxAFV3f6yfs0xwEMbQY1t2S9dD6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 18:34:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8534.031; Sun, 16 Mar 2025
 18:34:41 +0000
Date: Sun, 16 Mar 2025 20:34:31 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@idosch.org, pabeni@redhat.com,
	kuba@kernel.org, bridge@lists.linux.dev, davem@davemloft.net
Subject: Re: [PATCH net-next] MAINTAINERS: update bridge entry
Message-ID: <Z9cZt_OtSD4ltNyd@shredder>
References: <20250314100631.40999-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314100631.40999-1-razor@blackwall.org>
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c7b0cd-9ab6-4ec9-1164-08dd64b93701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jrhp/XTHEbmrHzR54+G2gYFk0+RJ0azJkb1eENknFiIr2cm1u4nF5a7hgPx8?=
 =?us-ascii?Q?Z8dMOSTzvsXtVtlHW7qcfNUF1gPnADlmODbeyg6CPLnRCdTaHX+8WpqQRrA9?=
 =?us-ascii?Q?uksAOWj8n3+yfxbYAdefv7bSZ7GA5qnBnoRulRXAp5hVSdbKoDj1nohqr5TX?=
 =?us-ascii?Q?eFqoz26rIxPrOBZocDMBjVqOPaB+WCOG4kqBoer62eV3Ajqa875eRUx1ZRkH?=
 =?us-ascii?Q?E/A3Hy2PEcbjH75l8Hhby5smUkKVKK9O1qiwZfPYQT6mb4B0+oSeMsIaL1gj?=
 =?us-ascii?Q?9gzZzu3ioWgIcm6EpiI4htapOmON8ZHwxw0fymBNn9QU/3IBSWzPIA0QwBue?=
 =?us-ascii?Q?SPUboqhiui3ilkLDOm1uUboKcm6VVhYp1D790itFxH77b7xcQ9gXQ3lbAhWY?=
 =?us-ascii?Q?lNCZxgTVp8yulwZZCQTg0vWICYOp9M1SbFWIdfya3Nv1UlE5tMo0jT20jxog?=
 =?us-ascii?Q?lLuwW4kWkubMaXsJuDBMefE0yx0vq+GONZH0xAwmEWpIMV+mDSdYOWodL9DG?=
 =?us-ascii?Q?igDmM3O+qBrVqj6wWNOcW/j1qGAhvtCVV9Jo8pvLe4x7sgtfkyX+jK7Q8RXI?=
 =?us-ascii?Q?fHdUgGfqRtFrTL4yzqhjHaO9WF55A/ey2E2P1swMUYoVdpAsDQKMAJxp42xa?=
 =?us-ascii?Q?DrB4rcInprwFXaBi63/jxMayu/cYM41y1RU09/6QhiyUOV1Zx+hgSNntWYmp?=
 =?us-ascii?Q?vL2oKM7fbAsI+9j5oIojDN+c3OTrP0rBU/AUUmJ2by0BLDtJ1Xg4YHxOgeos?=
 =?us-ascii?Q?EUn0amn8E+BpYyYPpJHVmWBI+S6+D3oyV+YubRcaIpwPR6l27q4oK5uMYF5F?=
 =?us-ascii?Q?N/Uh8JET2gBSF2s+R54ttBkknGaY3A5gyryJfVQpc93DC0ZtGm4uFUclODFg?=
 =?us-ascii?Q?5FQcYd79+A2xn/CR/sVlgZ0iMdF39A0qMvQKf9+9Bhgj4uchylhzqQVI9WoA?=
 =?us-ascii?Q?zlk2TcfcMKhCpfU1645CCtCGRrfTTKwbe2lI0mDTVjInV4vda+zVv74hQDB4?=
 =?us-ascii?Q?tbpwkLtIjFV0g+4VLlXHaqIMt5jaR4w4105cakOxc25gCdULJJQq8ywdtkSj?=
 =?us-ascii?Q?CHJyZuMqyIkJKZYsjJymdmd7YBLpc1AtuG5hNfz5/kkKjbR9i8G/mS/pokuU?=
 =?us-ascii?Q?v0h45CobbrDmNjYqv/L4e++h17n5ie5b58UjO12xTWahSN2l4FIZAHhsbO2R?=
 =?us-ascii?Q?Ic5bDKRdSWSRPje556wVqKel8jd75KC9sBuVPpVZRb4X+watVg3tFTTQ/DWO?=
 =?us-ascii?Q?36c1+9ikD13U+wiBKWLqUPSMVEV9oAlMzkytVno8o960q8VnqmZ7jnuCmddw?=
 =?us-ascii?Q?bVgTSF9aFryVszLaHaqlr/hD+fIWEElanwM16Xx6vBhzU9D18n+aM4lqfyWV?=
 =?us-ascii?Q?uJfFjbxY0FgvFeXQO9nQCxrXLvwa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wRRuudLVnnyJ0qfY4qa1uyykKUMnTP0Oe+/Y36+/zDXQfGSOCJWfAoZk1vfm?=
 =?us-ascii?Q?tWpvFv/9Ar5XE0pkI6z6V/3Ut90H71smkWwPLPhyttFyd4/4qYbQFiGG8qV7?=
 =?us-ascii?Q?ohahoTKjSd4GpVPvoI/beP+LWoq/z/b6jGb8ZlL/HwddyxiEBza0UNXP2/MY?=
 =?us-ascii?Q?Tx3+6bgTO14EwsbmurSNU6Uil5SuenXy5qdbzvafo5hKPwViXQBP6e2MsPYv?=
 =?us-ascii?Q?1hoe5itPjbfeWRX79iv4FvW7nNnkCbfTKWxFU5ivYJcAdOsIUjoYLoPsyjxg?=
 =?us-ascii?Q?lAQJh9cs0hO6avnnKXXaQ+OylQc+7hrMF/LWn9MLcmbApvak0qCNoh3VsIGv?=
 =?us-ascii?Q?xqYzmcHjfiQ8Ow22Z5cHM35kKZS7ekLmPw7WPrn6oaJqnLYzKdyYYYfLFTIk?=
 =?us-ascii?Q?wOHU8gbRuMw27pYI95MGGYfK2QfGEW9kNX1vFw7TzgHJqnK0gv5Jn3EvWA/N?=
 =?us-ascii?Q?6B3kP+rezfpQ12IuFq756yCIJ+iI1bzpSjeQaAw2DHoby16EFPpgjngIPpSB?=
 =?us-ascii?Q?2fJZ0NpAEnavNnZ9k6x2BnUzDN92z1g6CzL3x2yLjsUw2s4VCcfDNP7ZwvTs?=
 =?us-ascii?Q?mRGDbY8YcxZdanoATPyEioBHQl5VFtRkUuMSzWqLqPpRt4w4Xz8ZddrIlQtw?=
 =?us-ascii?Q?NKyqFm5MUyLdYgJ5d4pjjlROQZW+SUDp39uSU7wDIFv9NpxLMvaHcnNF1dXy?=
 =?us-ascii?Q?iN7Rq0UHh/P5LRjuLmHZjbBd5QfQNzEdxlh8FwlQ+kkhwo/KCwnvZf5F+Ja9?=
 =?us-ascii?Q?bD62IeuAxcDWJWSgX++nnRDclNAYkzsg6cwtcgUI1xeucroUXi0RzPDnjU1+?=
 =?us-ascii?Q?1jvT4nEon4FpupoX8YhVWENL5eoVjJfGYD0ThMk05/CGLvzpZmiN1Q1PALFS?=
 =?us-ascii?Q?iE18Ksg0Kuxa5+253Ld4sQHFycFnxkB8Vlf3TJwYHkzL6pvMoto/oOYK72Tk?=
 =?us-ascii?Q?yLaLONIAMYOB0jHDhajYXScDB7VoDJVdLnsGi85SB8g6IXPNN+CO+iNwVrXb?=
 =?us-ascii?Q?QbxeQ9iYMp0/HsZp+Py5uROLC/TypP/1WlFUPcynWvk3plEZHY9kVsY3zaj7?=
 =?us-ascii?Q?aUimBOibHKhjp1MyVF8T9vbDMG9ZzNhmTY7a6yephSjekirM3Eprhmu/Lews?=
 =?us-ascii?Q?TFPQkwYy1uIiKpb62svHXOafPr68Az5pQldDdd5E2sSve8Vi0U3zdXQTHjaS?=
 =?us-ascii?Q?Z/wwm2MkXoKZ0++95KzMywIEExW2KxVwUGNa9FwDufBf8wLOH/YAwbOy7Wj9?=
 =?us-ascii?Q?ndhfyCc2mK6/MXjRZ2Vqr3ifeo+Zf/UPkG8Dqa2voFzWK5oFMlBaYDtanFPy?=
 =?us-ascii?Q?dsNo+qwaoVBNYBwVe3teMFJZF9zLe4hiL1/D9ChqN65goMQS3cVDqhcdc6/3?=
 =?us-ascii?Q?ONJrGgzDRParwHT5bgX2QNxMT/IeGIveazFr1KUm+3/y3girI76530vL7ky2?=
 =?us-ascii?Q?pQ28psl7QEvhDs7eGlBrVIPbL5BlTgjpqfcjoI/SFBhSRyagDvLohbAI0SoE?=
 =?us-ascii?Q?FIOeICC6ZH00wKAeMk5c5jox7BoWU3hQHkWie0i4WQ4HkYlSzhVLAACZrpOf?=
 =?us-ascii?Q?70z0S/Bo1E4SUgF0NfHR8ibdlsc1hxsH7gNqPjgT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c7b0cd-9ab6-4ec9-1164-08dd64b93701
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 18:34:41.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb11/rrv/d37+JEs5CYrhPWg36uoGx2Eisp+JKsZc2c+65MUMOrxSikbgpdQDrld8DU0SfUaz1Z/vfYJQu2SHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896

On Fri, Mar 14, 2025 at 12:06:31PM +0200, Nikolay Aleksandrov wrote:
> Roopa has decided to withdraw as a bridge maintainer and Ido has agreed to
> step up and co-maintain the bridge with me. He has been very helpful in
> bridge patch reviews and has contributed a lot to the bridge over the
> years. Add an entry for Roopa to CREDITS and also add bridge's headers
> to its MAINTAINERS entry.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

