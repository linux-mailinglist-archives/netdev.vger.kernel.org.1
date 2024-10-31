Return-Path: <netdev+bounces-140644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A89B762C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFAA1F22751
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EFA12C526;
	Thu, 31 Oct 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/MbVWN9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5E7E59A;
	Thu, 31 Oct 2024 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362632; cv=fail; b=bkNdC1kjClsPUSv2F00JgZxygzBwJkQItZYjPNxEE+95EPMWaGMVmvtHuPsdWf53Ga/z3NQ8xULrLOsdoYQ6qr4H1PxA4ZsvRB4TM7cQoki6gvG6AAi8hUfXEZ9JyECd4xmlXmau6gSlMBI1Gei4nGfH4kNUlZd1JCYGClY37lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362632; c=relaxed/simple;
	bh=3GHWXl8BhgS2D9zYiqUcQKkv50iOkMtieOzQoUvDT88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e2LGh83iPu6xjXZgggFsp5ndCztPBNMsGj2HVCAFHa/VG4mUBg2XApmOhopvU+pbMe7ZfEMIQQJ4RsWlbgaknIMm+LGQqZUVYvK+7cdmaNWgsU+x7OSe5f6UTIQ+JogQitH39TUmrV/L88oPFFRSw99lcGcjB37CB7mGAeF/+I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/MbVWN9; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VphsOYEZ1OkL8oOaPXXAFV5Y5OdDz3fZuCxPYEuOlfe9r7VtR6wuHkLbK2fP9B9Q9yzF/ynveN4iOCuyT4iFPm4aCVf5uCwieok8DCMoKvTRZN3lDGap7fn0y49g6VhOF25r/aLaMEAS95x2WXrB3SCyZU1fvBkO/0dpLkLPCguVTMh/JDe31A1ZaPPjKxJv7hxLhEjlScNNJ5jcR3NTNaiaFrFqpGOZWQngYVkT6HruswQazgMzEkHP1UlmtM5LdWfLiDdSVgYa/5eC9Ma1EhBlNOUWy9nG7xnNKWq2fXwDC/uj1EilYQt9LgSlYAHXq/KhJjNv3BgQcl/6O8hwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKZESUHXJK7SLLgWYziVrVsFno6CY+Q+bKsB+2CEp18=;
 b=phL7u7620ue7qqT3u+qKWn1+igr128xL/xX1FQex3NQC8fzGNblrrRlvyTxsVHv5vdAIwBjixzbxnACzDTtkDzKhU2i296qWdnmScl3EV++/VdyhpPu7YlOQUd1xoWx9QNE0bUjuSlJTrHD4/BrbBhtmIB+TOeqvVG1IEzVRJU2z+V2pgZrVL8GumFu6dtsZ5qLeLB7hgZxvk+fNxbPuedJh9r+h9/qvMYTSxzrS2YPvWsEJGaff6qMNuCxe3pe7hk2+ahgt/WKM5XdT1T7JN1poo19j+QIykrUVOvUV6p2oG8oke7WEge8rhHFwYnZJGdIcT1To1PIo2w1eQ1CYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKZESUHXJK7SLLgWYziVrVsFno6CY+Q+bKsB+2CEp18=;
 b=M/MbVWN9QmYFSx07eQ8XxXBOVhMXCJtWPRVmKC17WCU5PMUFYbmBD6c+DlZhg2EIxYpDNmrG9vSFeP6z5etU+p7xh5YecGLguwkHwb3djdPqAx94S31hNSy7oXPywdcxFp67BR3wfWIsGzaqfOYOtZiPcNBUPchwDaWAGkggLfGHCwvMfDLud4z7g6TWXK5DghbRI9n4Duhva9+yEM8KYgGKOHUEPOKgBRBolYwkDu9vPSx8o8Ne5qhYHEagzjJmOOSJoYw3GtV8Bgt1V7sKJ0NJFPUgz3cNZ6/vMxWzTEC7CuDjnubInr14y8Hs3gnIixR3pu1pJwI+KIEmFMqdgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 08:17:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 08:17:07 +0000
Date: Thu, 31 Oct 2024 10:16:54 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next] net: mellanox: use ethtool string helpers
Message-ID: <ZyM89m3W3rAmDD9E@shredder.mtl.com>
References: <20241030205824.9061-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030205824.9061-1-rosenp@gmail.com>
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba77b43-b19a-465c-f25e-08dcf98468c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v1BfJgQLnPL75fdw5xq2ur7KwtOAgEZQEVeGJ2gbWs3SOfXNKmH7RBUoysso?=
 =?us-ascii?Q?3p8P8aNUCzHjZBPLyobW7Q6/i2i0zdKyHp78rLzd7gzN4i+CEq5gnUDl1WIS?=
 =?us-ascii?Q?UPfSklR4lSTM7az1XtYxv2QeQemk4b+VFV9NVVC6tPNHCwALDpt7YcEEYqq4?=
 =?us-ascii?Q?PsN/42iAJi4cdYpwggWBIDTkJ9+ClTOXbmBwYYERY/N5kkYfaHm7YkMP79Fh?=
 =?us-ascii?Q?MUX1Tf3mU7nTaMbTQ3Dc/Sa0LKAauS98MKX85OZakOlSr1fTtce5+3Bq5zJE?=
 =?us-ascii?Q?DKu+mGzn2tqMq1CLLoPNrWTUTLJFXHc0UFtqLuFdMgT5yZpte7ZxfTrGnWXs?=
 =?us-ascii?Q?d1n0iyia94VvOgmv1iEfuS79NCjQ+lPac8B+VS5ebl83zfPpcn6G+GQeCrVX?=
 =?us-ascii?Q?AommjFAFhnynxMYUHIKsJEOT0RDTVEgXS5qowvmFY9850m5z+3+OaIgrhCG1?=
 =?us-ascii?Q?HE99MV6/buvTZ0onykRBbrjcxs4Q5gm2+7dZLIvrjVXErSnVGIRCn4gvEJmq?=
 =?us-ascii?Q?FIIDkQkfgo4RHgbY1aSXt3Ly3KWxCKiIA/RgWHlNFKMN8RSZJIzH8ngsmF4U?=
 =?us-ascii?Q?Szpvt0LCzmSH+wb1DQzVgHHhzaNdK1Hgiy8SHb5UghPV7HFumOrFwHp1MvYC?=
 =?us-ascii?Q?/yUbqVeIJtP16E4lVSqwJAQOKeonrg2yKm0yz3fWD6rrBj8A+nUHiKbiyb+U?=
 =?us-ascii?Q?TxgVD3e+OWdgZQMvJSybo9fDwmTOs9c5CgI30ucRpxqTtG5mz1nz/Pr6XPP0?=
 =?us-ascii?Q?7q02lfVIMiRI6jGVZCWl5y7TBfULWl/obZHS2aZ/b7XRUzMp8TwFswzXGCaN?=
 =?us-ascii?Q?dXsCRratCGNciIwMrbApL0nfduPiWHPWe5bm9l9lUmtfH1Dy+AdbEydOOd/3?=
 =?us-ascii?Q?LenbFqZjdI39m7piBDFXhdApyVHBTUkGY8YQANMm2WqXG6KfIliTdGHkR9UV?=
 =?us-ascii?Q?csBVdG0IAi93V6saDfgweXEPt4vcS5HsTNqlg2eTI+5bslY2JxI1ibfI39jc?=
 =?us-ascii?Q?czbaeSqO6Jgme8zHTRqSNWa+2ArfivtDYwa24e7ycOz4tHrPg/j+sgu7QLUy?=
 =?us-ascii?Q?QnaEWU+HSwJ82wKqywnM1uV+J3UV+iNEUDb629NVfyf4oqIAK9CkX6h+Z3uV?=
 =?us-ascii?Q?2iWvC/qsiicPFtBJUotWyxMQs+bR9CN4OqgIUrVpIBrCfvaxzDS4jFWdzx2D?=
 =?us-ascii?Q?4mxK1iZlKCuVgMuIWHPqUAV0HQiCR+pExWmlz4icsCRn6zmpRICjVw4ICsbe?=
 =?us-ascii?Q?f0E3DwxDVYTQ1bNxeyYaEL37u6ePUOfxDbzYvr8N5KVfiLJ4v79yMEPr5oi3?=
 =?us-ascii?Q?M8WI2mBvHYalmESHVInL4uzk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ey1TRJZ38gMqCo+HtHMWvPx+8Hicx6mHnO2ucyB64SmhESSOvfKslk6vz2z?=
 =?us-ascii?Q?rDYpGVgLuZSCRpJ9Ut4OW6o5JRRPPQtHwDljLJD82qWz5yK3Y1ck1hr/k4xy?=
 =?us-ascii?Q?TB0DLP0J3sdth9L0W2l/dMPW8neS5ABbjjjcBVYMsrc3jFKbuOgDNUQdyV6v?=
 =?us-ascii?Q?bEciVIGWb0OMoIQIBi0aZkiJ/tYkE3j1BYaRe/xRgGDVy91Ab216sFar/0fC?=
 =?us-ascii?Q?rK0U9mdK+GaeanYHsZbRaOssQd5bSSRL9J8fSgqPtfA/rMnFGvfb5VEZ3QtE?=
 =?us-ascii?Q?995UZgmVsYtnEAnsDq2bIjmiQBC08Ll/osxYAybKce1/D5ZZZD/u4kzmxr1j?=
 =?us-ascii?Q?eXsx2pkCZVJ1+ay0/sB+44X1Uh/LZBpwjKlC9hZDLsGagW1vF5teIU6PTgCx?=
 =?us-ascii?Q?oewWa5lIX46vW8SS3qPnOERBy1jCyLE7CmXHOTQawZjhurv2JylYsxplJuL/?=
 =?us-ascii?Q?sbX0dyVd1YwCiPWuPjW7sM6+CiWd+E3mRGsFUoxX+ZseohNvWwpeE5lKejv7?=
 =?us-ascii?Q?qOfWiCuPmQrccGQ6afHERRST9uqd2VNpgZfsxBGiHd9NolTcCHQ/JST9xQt+?=
 =?us-ascii?Q?Lygulk4xux0G2vhxlGHezecsDzBfLdcDSpssvJNDgIXmMj8W9+Pi2PQTLgUs?=
 =?us-ascii?Q?jEgs8AhF7Vjrfj+V9NvjN87JUwdkZv2Xpc0tX8nBRhAg8ekvIpvQsE1tfYpv?=
 =?us-ascii?Q?v1Kt0x8uWgCC+LiXBux6EGJbTMPdSytV2vCSsk5pZST2N6SLuBqyea7YFFyt?=
 =?us-ascii?Q?m5q2dR1tHcXlrE6BCImgwOAXbBb+mu5ZpEj9odgEsfV86arGpXVZPjIMloEt?=
 =?us-ascii?Q?a21f0hMHk7pKlVRUmwFNj0hM35FHMXQuXbxDXmhwFN1IeeyvEleIavQT4a8U?=
 =?us-ascii?Q?idbF++XSZ7qsXb/+4qY4fTWzZGfNb/9ldQ9/rb++YeNC7wQmHWWzwjNDuj1P?=
 =?us-ascii?Q?T+5OZAMxwYZKSHuFDH3/ua65zNe7l+YlhJOZOAYn/+sQTSv19N8shDIbTm0Q?=
 =?us-ascii?Q?4hIhqKyAhKpk+1NknFy61AU4slLOxQp1eXT1nC5S/RzkejIpcMIP/NN/LVUH?=
 =?us-ascii?Q?TOrLydR3LUBHu1bXLObPYJT9YY7kV1hjIGTh02pGUpfmDldh3b6vFdt0m3O3?=
 =?us-ascii?Q?GUMrUM3SbOZe6gLteAXQUxRIgqM7B8vw1LLGc+XAH+HQFM3npPeZtpwYQlWo?=
 =?us-ascii?Q?81kYntBfPw0Ms7DWvQii36uEw7vu6uVDUa0ty8LQLgZk0IRSrUV+ABO/Dy8M?=
 =?us-ascii?Q?EnuogeWZpHYnwWsCKl2A0xfLnECvR6pwYeXlL/d4rFRXIwatvdN7cjiPeJIR?=
 =?us-ascii?Q?5N1ktbfHD+7QF5r4JcMfHQgT3eElq6xEKTo5orVwTItTusbeWDqizGzZfMzQ?=
 =?us-ascii?Q?ipQPendTJbDk4Cv2XCzJ167PVjNeQIzw7zsLsmUzivJ6IT9Z6ijj/A9urLGe?=
 =?us-ascii?Q?6EfldJhQxXXG/mJImcEW01Gq/qrZBdnY11M3XM7+cjEfe1kEgmg8pSrBhuK2?=
 =?us-ascii?Q?2ATI1ngLabXOKdDQAJ6ZWpqWnejTp4Ip2JxbgMWxlB1IbCYzEfJlDr7xdcoM?=
 =?us-ascii?Q?QeD9YjT+KAIa7iPIqQwaDbt4ju5Gd+HNnNNG/Lqb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba77b43-b19a-465c-f25e-08dcf98468c6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 08:17:06.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSNQKN6UCZYzlkPOozHSVducq91z9WHvf4AURvWbjEUpLUUAEpLtUyYb4rQsOASCjyQPEcfeDz/SUTB8wu8YEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411

On Wed, Oct 30, 2024 at 01:58:24PM -0700, Rosen Penev wrote:
> These are the preferred way to copy ethtool strings.
> 
> Avoids incrementing pointers all over the place.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

