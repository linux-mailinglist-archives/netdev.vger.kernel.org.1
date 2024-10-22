Return-Path: <netdev+bounces-137862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A250C9AA234
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D553B2155E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C343819CC32;
	Tue, 22 Oct 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+wPcXV7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FD45945
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600641; cv=fail; b=ChOWmi8IDxx5WasAEILttmD5mwttpRj8nj83sQQ3LnY6aIlLorRhkAiPXFzryguSRIwSJAOrvSQHvR2TknD2MFkqUlNx3giLLy4DBCHONs0VLpuBm0WA0lZ3KcNqIFXNGGQf5lp5Xi0HbD6FFM7ktKFS+AL9tQG7JxwvcdCDnV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600641; c=relaxed/simple;
	bh=CgReYVAfSq9+CaOqB6Opg7BFhr5uSoqax2vQILOey0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHFqxONYfM02BHG3xWSyokrmt5xsvkxlJmixsuDU0VlOVFtr8DV44kTA2vbWpDsyXmiVXbHTxT2NpPMI6CL8O9/lLhT93ZjwYjADswwWmt+doqv9AhkbbR7feG0+uXdQugjIiFXgaYOtqyDXxq+GzZIDhU9me2hNxSfPMwBKaWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+wPcXV7; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI9YJWRu7qCIZQ9Or15YA2Kx3cfUt/stM8Kfdj7TbSOK7U9fwZthS9kQaOWxcPRuYkAjPUG9TDsR1azCQGrsfJRBgQSqwbvdnaKtK8474X0/7DxpsZt75byVZQMlTtwaoXc5IR64DDHwOis/XrgrX+x0fWfv+bZKX4SltNUV74DdPnYmBayxdPXariRhNkvGRDsfpdrAOUkWJ000+qiC+GAjddTSWG7sg/tqVzJT8m14W1KHwx8yTsMNwD4+5Z+9KPKzgtg67tUj7fsGKW/5lpZSjdRcrilAcGo7Phc8g5IJ7YL/htv080Q12i6LAijHbpsA0xO3ew6Wvxk0m8CeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gThjYTOPBYh4H9l7tOKaK2akySjAogQS5TnGi8ivFYw=;
 b=K2++OZgZGuqfevfwSYJhpY0dTbEd88lhEq3FZuadp122l9VPnesIPyn98REweQa2vcKTmdmY/yTwJ25lbgBtPASsHlLJZIT5HbjrLYjDb23ESFT8lxcnJYQ54IYPUVubiOWQ9tIuZJnOgWhqEbpi+DOpK70cPU2EiFs8uvTzPs1kyvOaphr2xP6oSKYbmuORT8t0vOIGX39Uq1gAQkzhb09nj5FY8EKu8qySl2J5lKMwYAfH27u9T7SGFxi3Cbb1K5KbzyIZ+dKG1BZZBEiz1EXGOuU5D1+tLpphK1/5uu/Tslld7G+o4gvSbjNNe2tu3dEqTByE0fb/qE1Mbxc1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gThjYTOPBYh4H9l7tOKaK2akySjAogQS5TnGi8ivFYw=;
 b=o+wPcXV726TxFE1stY8cea79qe8glr/hjdGBnlCuVzhRqHVqkU2FIJ6kzocLBOHjiAdS8eoVkbBh3NcIY7BglwaSxr+BqXXGqgdaobO6oQ+y9m3y3eb5Dy50VzRhldR8WHjRZSpuO2DNYXjoEUIQQiSFx9Mb8YMWZKdPOYFEHQUSpRZgiyx9e85XFy89nQpyODZfDK9jTKWS8Vt87C9hXlx8R/5NTJONM991kyl0ub6iOuC2nhPN0HS+5aXt+UklGVio0n3o4hteumFVmF0yG5eqjpuerxYIQWP2OgBULscHoAP8v1gTF1bZUoFgnGXRrHOw8a4lprEhWM1ggz5nAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 12:37:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 12:37:16 +0000
Date: Tue, 22 Oct 2024 15:37:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 3/4] ipv4: Prepare ipmr_rt_fib_lookup() to
 future .flowi4_tos conversion.
Message-ID: <ZxeccacZcsABrgxt@shredder.mtl.com>
References: <cover.1729530028.git.gnault@redhat.com>
 <462402a097260357a7aba80228612305f230b6a9.1729530028.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462402a097260357a7aba80228612305f230b6a9.1729530028.git.gnault@redhat.com>
X-ClientProxiedBy: LO6P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 9271225b-6508-4de1-3db9-08dcf29642ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iHKSX/BBpH3BgZOmCHLU4zBdihpn6QR1vSv6Kx4Jd6O1foa0Mn/tSslQRoyL?=
 =?us-ascii?Q?BxeIMZIw0NIGhGM7tiW3Lw6hTHDvD9PcYtamXZ0jDMA3ovYdLTMiCLMrgZzo?=
 =?us-ascii?Q?WswKlaJyYbzhgICQ7G4xzUU/zjwqofjj66Wp8teeEme0Vy1LhkPvpf2HqZMK?=
 =?us-ascii?Q?qZrIK2uWJAT/p//QdTD2G+LhM/+vpGn1c/FFF+d2ZH8spU4sw1cO1usBwTNe?=
 =?us-ascii?Q?NFOqWArjkNs5hW2yRc/mGtMQFJrmcrl4firjUagurS4WN2s90dC25HG4k9Gp?=
 =?us-ascii?Q?ONEcggv6DO8oIw66GAKY46pLUnPMxNzz9Pmhub6852goBEKwi/0PMjVT/hiB?=
 =?us-ascii?Q?ZsEm6rHSi2vsweIIGg+P9nLkDFSNNi5S9Br4AliYz5KCwiGRip2OxxcatF6w?=
 =?us-ascii?Q?VOqPNLRhKGTBsLz2UIj0+E3fTs3gcORTny2wLFmJGciLcPoOUiHwrcfjoSxX?=
 =?us-ascii?Q?XNE8K8h5P4PIIgcWA4CUWWjdK2JX3nsuMw9Sh02k/K5wjeTNK7QwSasng9Wr?=
 =?us-ascii?Q?qYqBPwPsth/tR7Unz+rPJbVqWPfN4p+sjbD6RgQi+vz3BuBzM/pomS41qm7G?=
 =?us-ascii?Q?FBKpRhiGh28TRb8w2LFArmuW7IstlOrxut/gNQt3nQsv2E51Ywr+U3IUF/of?=
 =?us-ascii?Q?14SxB8dFg1gpvaXavdhxMtVEaT/uG60HcIxkqDaBQZeDdWrhx9EKdzxw4UB0?=
 =?us-ascii?Q?xEjXJjfgXxNADrc5qgSVTcWwjQG0rXDSHWeHzHyq8XqiSu2gLsfw/AO3AESI?=
 =?us-ascii?Q?R/SAfYq4Oip6jKnRJBV9m+cMw2z6pBGhmnAEr1jGUjCQ30nVsG47NghqQTB5?=
 =?us-ascii?Q?ZZn7dnlAU0mrQq7ralAVZeTwWKrcQKMBGzYbMc+KbgLJWQ/3hUgdw13dhqKS?=
 =?us-ascii?Q?p1eq57fFqjRwhhm/g76tXSdBfqv+PcOYXM/w0oy/DXXf4ENx95rJddPlWoNX?=
 =?us-ascii?Q?Kd+julyPeePDRhobhhsVqU7DqrngGx1o1kA6vrOZgYNTRUm8doBWD5M8VHqz?=
 =?us-ascii?Q?cPDGqr6jtLWYyAl6dSn5MPOCm+T0AMXZl7vGucKoko+Xyt8dUYTY57QynE86?=
 =?us-ascii?Q?gzIV4bMxfOq44ryP4eC3TW1TLcrjipSnucaGBNHiaailTRqObUQ7Ax9wTQEP?=
 =?us-ascii?Q?6O4XXQHdUepKjkzNa3dzazvUpgTBtdvtG5r9FSUcNTLJIxQyUGkhEFnh9x4c?=
 =?us-ascii?Q?MOUFxK5/BrfbhFiq/6B6hf4Ax1p48nZqMlqdNlB3bt5QXejy0BbGJ9X5mrgI?=
 =?us-ascii?Q?2Rh9jevP8t35F0pujVW2tyi9F8i2cgAVEqTCHMtpwMf8fB3qMK8z7wRb/qpk?=
 =?us-ascii?Q?8rygoM73t3YvRnjapE0x2jok?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqI0U2w8Pm0q0GdQxdaMsbpXDIekKIN20GNPU/KEI3HeLLAT02QPn+QmbZCi?=
 =?us-ascii?Q?MrrL+Zuekn2ig7rGXzR618B12vXY8zwKaeRc7HPtfVyL3H8N9tiHcbF8sozK?=
 =?us-ascii?Q?oS6eczs5N3stcg2kMsgtDd580nSkQjEzNvgS9DqG5nqSTE7oTLDk5NGwrpbh?=
 =?us-ascii?Q?q9rf6u/UsqhcmiYVtYXwww1vlfrNmYto46C0hASosxopQrnDugSPVAsbN9ax?=
 =?us-ascii?Q?YDZwYxIddYy6d5ckN/J+42Ydy2XRtyd4MH5poR70skHAzKdux+Vqjv8PyBh2?=
 =?us-ascii?Q?70C1NGGtaJnp2vSp8cslqUxOxK38XLS163Hg4DNjuuj6dCpOc8eN8/TfB3BJ?=
 =?us-ascii?Q?mPrT7wVJGl+xYjCOAi0Fm1z9MvIjWwCRQQaFKhtjGOX0CyIaffqoiMvomo8q?=
 =?us-ascii?Q?Qwx0w8qeEpi32ES1/zkc/fYTija00ZObPiy5z6WVrlWjDoor31qZ+O+PkhgB?=
 =?us-ascii?Q?xCorAEbihjQ+tC74px460RRPMCZxOZfiUjxsn4abTe44TMSCebaMoUqWwf54?=
 =?us-ascii?Q?D6/qfRjF15BnKSvV01pGxEbKnei3jkdtBt644ajt/4xGKtB/2u3RO4zgVHrU?=
 =?us-ascii?Q?vBbyKRwirEl2ZeGMZxVlpo0TnKtdgplFJpq26LwZKrTcRXDzhvEpgVQn0XH5?=
 =?us-ascii?Q?WpzLHEgs+gGJBIAApysVL+fjjWsD+5yuAG602On+FUYSKnUHxChIyYyM1jZf?=
 =?us-ascii?Q?K/Fhfjqrjpu7F46H2beLM6CnD3uKFPyMXufxGYQUIuggmVywzdkKszotuLN0?=
 =?us-ascii?Q?6S7hTgUa5nb/PNt06TyQGuHgo8EQ/g/YZr3SPbxDCkDdzt/PiBdkBtWXCexm?=
 =?us-ascii?Q?qOi8Z2tghPuZ/imczg6vll/wH9y8PGbp6Yh5oNTyylzmOdr7CNsxVUJ35YBE?=
 =?us-ascii?Q?ZK6C3eqFSXeySrzo8swfH1ntXbJJ8OqdMqk8dCAEEL0HW7W7Zyl4pxctvIAH?=
 =?us-ascii?Q?1fLOUWpSZM8JV2VhyFoKQRlKmFeh8vDYRLE9ds4b07sU8p9l9o1K+SvzuOLY?=
 =?us-ascii?Q?bmYbX0XrFV7wJiMVcGmlaxGPjdcDeoo7IsPqh4Xayv1yaF0PrwPuEePNWGC3?=
 =?us-ascii?Q?CamB9BQlNNJvg60RVggKjzDciECLcHLFp0rJEDpul8UnrQeZgL/ooFEbSxMF?=
 =?us-ascii?Q?wcO+0njEKJZpqrS0iTd+WfSIyyvQuT7iIfI1vM8YQKdFr/qSGLZuOBimEcpT?=
 =?us-ascii?Q?kFmGAZR2CpoIl3/j7UvujNF44U8KFXuPg8n4VYBlAlkgpd1+zg62oWw6urVN?=
 =?us-ascii?Q?oqNgFFm0ureeSxDfvselNHouX/RtJELxkxo8BwwQH4JGW+nt3IDspbQDpL+r?=
 =?us-ascii?Q?RYBfNgnNsfUAp/mN3xMp48Bqj3PkLoN27XUasARb7F+6iOib25pNLcdSHfSZ?=
 =?us-ascii?Q?43v09i8mdj0PBYwj1bm6zu4o48QlZ/bsXnH2B3wk2aT4+uXJyL4V4mgjqSwS?=
 =?us-ascii?Q?0EdGbqWO7n7zjsxS0J7zyDnmFjXqkXIOGViAPGJJXgqoydR2JDttLVPXX89G?=
 =?us-ascii?Q?+TZllZEjcLvJEyR6tCSOqWEWadGKX05jY2IEwwcA3b6J24MuKewQ0BYT2Ddg?=
 =?us-ascii?Q?HoJoG2upTTy2n1vBBzC6CWCA99zFhqHfzBo4T/0I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9271225b-6508-4de1-3db9-08dcf29642ff
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:37:16.3717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUv4Y5HDPrXcyXvb/46BEFSaT/aLJtteX7cBVp1Nev6iWrl7lFooxHPAx9mL/p4XonC2t2mSZBMp3wHDKyXyoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

On Tue, Oct 22, 2024 at 11:48:15AM +0200, Guillaume Nault wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

