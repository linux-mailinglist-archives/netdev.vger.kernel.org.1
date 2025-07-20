Return-Path: <netdev+bounces-208429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30208B0B653
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F59217B07D
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF91E0DD8;
	Sun, 20 Jul 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YDc3IUVG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBD7482;
	Sun, 20 Jul 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753020040; cv=fail; b=Zp1ugROClKhP+Txdl+C/JeBmtn77QYp/zGmDnIWprXqQ3izwO1yNB/36FZ3n1gLUxIG2mYuvqUeJk4SRszIXGMJWgE6Jrxpk7sA7rRxz3tu0Ys2EZ5K+o4O9s2k27MJ/UvceseS8j/DNVGk7fwo4G6lmuYdmEtXWI8eIdrHwktc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753020040; c=relaxed/simple;
	bh=nKFKQpqeMZ7S9FDSRKIiV/Jakl6r4GiUYjXSY6iK74w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZgjSfsrn176i0SDEEgo9HHhe0tqfzTSJPKvuBfIBZNmyFcHudU4463hTQXp9doFhXP7zBehb2UuOO07H01QfQ/E3jHpQo1bsa1qJKa9S0gPytK5fQxzYavECGH/klQvNa25dKTHBct3Nlf50vxSw10FD5EAALgGAdjvp3H+RiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDc3IUVG; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR6K/TjVh1Creo7WkLBIvDoefvMSQes6BbsgE7peZq9JeMra5jaseWXbPtE8McI8GZmH5SIw8G1p69G11swzerfGQd7KilYctN4vNNN+a2uh1sHWJbVZx5JwyMzLULTTo046WudspXd+n1uqLOmjyswoaXjJVFQYS2zdW5r7ADN+2TmXRXeXr9qGcpNSPwcaKl/OLFshT2EaQOCn8P6BbmZ5qzEzsnIwkJiCvbSIYokJ3x0VwQ2HzEBcKT1uSEo94xcigG1Zb9vKTNvDheQXGeQ4GoF5Zk785FIorJboXxgOBiJwcM1JBD4kKLRMyF6xSJ3N0IXMvT06Odd59e8g/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKFKQpqeMZ7S9FDSRKIiV/Jakl6r4GiUYjXSY6iK74w=;
 b=aS15lv3sKI7Z3SnWLffeR65x+nWzWDxzMsHyjU+HncRxK31MK3Jy578kN77D9pFtKWMjREe725GD6Td+adf8AKs376AUpw7ml2HJoS16ldNH6FCKs+LwdcJprACJJKbV/j/COIBYrwOww72AEUaaIwQKx0Eyt1kdyEt3vvpQ70M3KEiNJQJ1CNOZGt34iXN+A5EW6UOa+mKE349jRgzrpkZy6uInttVXlCFJD5cdhKCcdkUPbcOjdUpkZ7nIMbKExEs1IngLLcnqLcGOI/uvTnzOJswkKAS6C6fI37XE0SkYdnoA0WzAGUXTtwL51/WKC2yKtz8Q9SN6VO2ytkARjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKFKQpqeMZ7S9FDSRKIiV/Jakl6r4GiUYjXSY6iK74w=;
 b=YDc3IUVGVsCIaTYyUjFDCY8WaFhinZXJILlURof8iEQgoLFSPx6ijcoDufSmBtCw63HWt0hJ2PFawBiEnhS2NlUW43gwVUlZdhONV1yl2BW4XARWVebFzPXIKbQZ7hJW+vZTs7giqUx6MGJNZFheAbw+SebXZ9u1Puye8Dw5ZNDnq1fkEs6WSBdYsdHqxH54eqdQLRAfZkfWd3JRim8kk2DWVDLLobVrBg6DaesOIlRUotfjjRw4tyIItmNu5BxDqShzQNZ6Jyf3VNzybc76U1G/ybX78AbB9gcy3rkj07GK5EegI17synFiqL5B0kNpEwTl+GlhYyz+BbSvO1+hcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Sun, 20 Jul
 2025 14:00:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8943.029; Sun, 20 Jul 2025
 14:00:29 +0000
Date: Sun, 20 Jul 2025 17:00:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/4] net: add local address bind support to
 vxlan and geneve
Message-ID: <aHz2Y6Be3G4_P7ZM@shredder>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115412.11424-1-richardbgobert@gmail.com>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e449cb0-f834-4dd8-79ea-08ddc795c91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MCfkNhyqTOGD/zJa3WUPuf0yTt8lJ619UMO2t00zfHEFY0uQClBE56beyY0U?=
 =?us-ascii?Q?RN5IhS5AMA1YKwMsSJuARzJm+QuCF0AguRTSPxZ9NeArwb+hcCv+w7UeVsPe?=
 =?us-ascii?Q?NhitBRcxO4rnRXV+wKQbsI48jamO7wGlcQOSmnjH6ErZstf0U+bm1o5na75q?=
 =?us-ascii?Q?ewGAkvbhff485n9ca1HdXK1UEwAwpjraB9pwS0sdaExOS5BNsm3+oRy1FMOo?=
 =?us-ascii?Q?mvIrXLwyOfLqxAC+DvRCkEKemNiupB5DXfOh6txfvG2zk2us8i1MbUyqRaI+?=
 =?us-ascii?Q?euV2xBPNPSVnzQQb3pCR9Mc0+bSnrruLehens0eKG8u3Yg/FmhwVLf2KP6wB?=
 =?us-ascii?Q?mdXQKZ6Yc1nl3Jn8h3Xubz03/CUpA9Aq/LaZI4KEiJctxRhVxmkoWmwfeuVU?=
 =?us-ascii?Q?AepPMLtya7Qks70sZXmDBw9a+UIQytjTtv3y6Ipz1W1WDGbtD/q+/5165OaM?=
 =?us-ascii?Q?L9HhkH2P6IpVmD5N99pdluInzo/unbn8tx6oxdmbFHFELIfMb4CuBw2TgHOV?=
 =?us-ascii?Q?3TqpUr2ckHJ4H0NJDDEFkEYwH9vTuxNu/IqPVxaNPDK9WqrkI47PqXSXmQlj?=
 =?us-ascii?Q?+UqZuyoQnNiRij5bSRo8Kt1ifmObiSCTKl1l2GuuW4sa1i+lR0qgSkJoElKP?=
 =?us-ascii?Q?EEY6hXw0ms5XyHNq33Wg1i4hdqglagNAsXypFv3RX5wWNp+bb8XP2xIKjbVt?=
 =?us-ascii?Q?Ma9v2vt1w+cxDMnanE3Pct/BO6XtPQhXic7S2ammEZvxiLS00dPjzE8GVa7X?=
 =?us-ascii?Q?Qj5SvTiB9Lj8s/jl0MSfb/m3sxOBr1v8t26fCBO/zzIV6TIxPfWFlgNi797R?=
 =?us-ascii?Q?lWqsZ/dp7+Kg7R7NXGwd5r00/fJHFbGteLRV+0vfFpuqK38sW4oClbMGLo45?=
 =?us-ascii?Q?L11SH491xBjmU1GcE9ML5f/yiO7sbG/nA2Ha/cnwlVXSZO6vwTHtHOh5h5sz?=
 =?us-ascii?Q?+sDlIIGTcH41L+ju4JC+UTwOtmposDV6WeB53699quw7nueNeIVYF6wZBXl0?=
 =?us-ascii?Q?WQRBBl1w+Zoa+uB6ohODvtE1HhDCfLoZFSKNPIWgrjHujcE60zVRYuYvw5WQ?=
 =?us-ascii?Q?SZ9yDiOALLcP4SYkOsYDzdW0JF/HLfiymzCIqlhKNQ18FyU/yhJH39ZSwuqT?=
 =?us-ascii?Q?IjV0eUXNWJN4MfU/jarV0qMJWJLxrPw/CdmcCIXbe8+sYDuGC1W/MzvKzOEZ?=
 =?us-ascii?Q?U42FBxxQBWOlKc9CCGsKQT3PDEoacO03LdD2VIfFQr3Ler9tyAuI8QFmlI/j?=
 =?us-ascii?Q?DP3HfCN8MkzIgtVGoHkbq3PbPb+24YKqAhqBVeZSCZ+q/eqXyw7OGQ0pdrQV?=
 =?us-ascii?Q?3EbNxBtPKTufndXIwwsaAdnRhJ6SHvcqJ+WZptZ+VmFhtwpEaXYw3FA572q+?=
 =?us-ascii?Q?JUsqEvx+yEQh/jbY8xjrT587GlYEqJtL8n0R0NBiMz41PlI5CnKo5IBR2KwG?=
 =?us-ascii?Q?cVUZn/rQ4XQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zBcrcv+mQjYHxHXTt3PwJSIbow0HDr69DUwkYgkmzTzqi+JwaTHthE/3ygm0?=
 =?us-ascii?Q?3oWgWVQMGicetGougJBPZj/hI4DZLvNBDEDq8U5fsA4AbmAmLuFwEmaYzpG0?=
 =?us-ascii?Q?K2vkMGeoJAriuIOWbprZHvadfafyKEufrDy0FeoV870ywrGwPieBpWPuPcew?=
 =?us-ascii?Q?8uOgPLWWPn8FC1o+mHh0oP12hmaOyh705UmN/N42YSnvviGSUm5353m8Igw5?=
 =?us-ascii?Q?JeAIp616+yQr1CCgPLwXGOCCsh8TbJtXv1jS6WNKZ4BcsjKnRCzD/gviPH0m?=
 =?us-ascii?Q?koOOEjhrOi56J5TjI7iMaGTNAXrLTAfIao9MUdwDF1oqILBnTxc7zFNhdEtW?=
 =?us-ascii?Q?MIDipPAiXm9woF5gv/4v7rdvzoJxTLlku5hj8eSl2UvpFI7EVVR0HqBTmVvx?=
 =?us-ascii?Q?ERS4Z+TzNxOQhk7puaE+JplvcO3NVsRWnSz4DyDzgNVhnOKI90Tcudu/mfLo?=
 =?us-ascii?Q?pYpc8zr3edl2M2JK9Gs+ncVL8nOrN2hTlFJdVGUdcIIfykmTyDINw15qi4Zv?=
 =?us-ascii?Q?gq6ieuHbltomFyMxM+tlCn1ibrWHW2+5o9mtVkC8Hli/xhrNilwiHuOsXTBA?=
 =?us-ascii?Q?p3VyxwRwfwXF8Z9prW4Y+ayBDYGiJkjbL6C/4hnUlneJXnB/NS58YyJGIfrP?=
 =?us-ascii?Q?eHYliQmpqe7//FM1XlMfhK9HVTIe4xJFog0f25xbTuhTah9JdcP7Viu5/vVI?=
 =?us-ascii?Q?UYsH09vIliCPjUFpnRAXRHVvep0omezJ+SoBH1Ajx7B3ag8tvGpqMQ+sPcvf?=
 =?us-ascii?Q?gE9qQuf0zWPVWrzhjVucbObfMZ2JSmduQ9y0cxJeEdpJ6OQ+l9/DTWhBV30B?=
 =?us-ascii?Q?+mMk0+DRDRKaKmFBXFpWtLvfRpIKBfTiecrEUD/9mkHJNDAns98LEd7GY+Z7?=
 =?us-ascii?Q?B+o3trsomByfF2cR+ZdJkonPuWG+WRgVGgRMt3vf51YYwEwein0FekJky1Jr?=
 =?us-ascii?Q?ArsxkLK5/R+de+zZKPnOXMOe6772pYL00bFOOl+bP1L4lLQD12mlFCiEJNv2?=
 =?us-ascii?Q?qUucV3GOe5Nf859hamvdh0nbDNxVb1M1irjogpWrCIGtmDoU8MLBl6+zj/pN?=
 =?us-ascii?Q?W+dc4jjEorIiYf7l8+OqqeMsE17VU1Ug3q9ztT7VdTn0vEmoS+EClmpNOYcZ?=
 =?us-ascii?Q?vyyQWWsHu+RD8WVPjaAD/NFan0KrcRGwYlv0tbZ3b96WzJJcMSVF9ivYeuVC?=
 =?us-ascii?Q?B0PDKsr3cIkUT3f/wJIGwxphDsHVUcXCrWKWQysbW7xRLWsSKpjUjIzne7tX?=
 =?us-ascii?Q?vfNkYvTHi1rcD2yEfXsoIhDxaPAdaYUOLOjDQ2BySK4AqcoJqiVYPfCRX57Z?=
 =?us-ascii?Q?dOgSSIjFhDQAnwirr4BFMOLyE71uKZKU6Vs9fBA+zvTck8KO+QB9VA45lIe6?=
 =?us-ascii?Q?kll+d/0g1/4K/wE9bl2CzaBc1dvBJUA4biKKeziKyFcP99fWE2is/31jbCst?=
 =?us-ascii?Q?CsHcyol+PaPTSmgHqaWMEFri+7RKlEBpLlIIf82VTXYW6S2hudhU3/sh/tvi?=
 =?us-ascii?Q?o4+quqZ769NaUKK9v3GRj2HDdcAE/VC4e+khxsFa5d7l32/Zu0s+xFFWct4l?=
 =?us-ascii?Q?8mKkIM/xyQRnUsux74r0G8TV+fXS8G31sEpMPPV+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e449cb0-f834-4dd8-79ea-08ddc795c91c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 14:00:29.6462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2G0cT+1vqHCO9t0hUZktVvXEo0KO2a0kJ30PZ1gu32VpgV6KDt+XuKM2Y1o5XEznczLCbzbRpoIYemvd7PQpwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

On Thu, Jul 17, 2025 at 01:54:08PM +0200, Richard Gobert wrote:
> This series adds local address bind support to both vxlan
> and geneve sockets.

A few comments:

1. Binding the VXLAN socket to the local address does break
functionality. Run the VXLAN selftests in tools/testing/selftests/net/
and you will see failures. IOW, you cannot change the default behavior.
You might not need the first patch if the new behavior is opt-in rather
than opt-out.

2. Please add a selftest for the new functionality. See the existing
VXLAN selftests for reference. There is no need to wait for the iproute2
patch to be accepted. You can have a check to skip the test if iproute2
does not have the required functionality.

3. The cover letter should explain the motivation for these patches.
Currently it only explains what the patches do.

