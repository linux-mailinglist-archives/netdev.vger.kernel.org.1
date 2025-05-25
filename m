Return-Path: <netdev+bounces-193276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26921AC35EF
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 19:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D35170DA3
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676A2192E1;
	Sun, 25 May 2025 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rdvSKDFY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7B1F9F51;
	Sun, 25 May 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193972; cv=fail; b=LqkPRXJhDl7cRsrUZt45mpYKE4gwK5ubCLKgvYB1R7/qceTFutnJKEKJRMRh0K2mqiN/BMIa4hiUT5egrVKT5XS+deIE3TAN6Sf5YDyNoiGWv0SE8Gorg6rEBOAA+X0ofSZIHQkVUK/0ivlwgwEsaSp1v6fKyZ9mWD4q6ZlxGlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193972; c=relaxed/simple;
	bh=zKStkSi1YT/GVt2+GfZgZdz7pujWPVb0T7OKZY6LvmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UMtqa8Xopgz2ZNLGaGdQdVAOavy8xJ3VFunbFneRQ9nhG2PvCMWSwyLqLGso9l5RJfeqMLzHJt5l1tAeh/IYlJ+AuBxezwDzX32WseTG9DwmbM/tUmF87TqAaN0yfyzxh4OxsUkuxA1hddFsUirY3YjuHouUr9A/UGvV6bQcBlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rdvSKDFY; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5igTTTQk2bNmr+iHSY665enfitiylXe9cTwk09wiS6kVhJqNk9dq0dHIqrKrQoeBQfW865Y+nJz3CM+mJgm3JGJUfvuRlXP2rHVUPqHMI/XmjMXhY+QBf/VfPYxdZ1JbMI/bOf5M/FtLPWcqlpEVJNF3JvxEVs/bAQ848l/MAhJNKkN4YLAdGvUkIaa+xzqxL+TbFOLHMtfoF8qWgfxEGjM3sd1aP4eUZo0qICCR8fxoBALhbsEMx7G7WRoeS9w/4FyzHuzXhShccWVWVfOQm1uNnfFVORxj7yBgWeko3uOTrmerfW2SLe62TKVCSKssEhadXUekNEgi913h7GW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6dXUarvqn5TvniOjA2Qd0GYeaxL212BO3mDEzNPiW8=;
 b=p14dS68IhpvYcsx7vBEFarjmuNxVXIV2fOqRGlGO2M5LJgz+Z9cdN1Wv2JvzJIo61Ns4mOv/VqokZ66DUs5Oq7QCQw89CIHGPrA4W32mewDb8xjsJp+kkpxs9/VX/LMj3tZaFBJaq/XzsDYlu/3nwuaMVKqDu99oHl3lWAZ7wWzvtQT+8e0pg1dzz2Pfk1Jh4prk2EzDMYFFirJYzU3OK4BgCfu2Mpu73Qr2BcJ/muMQT56A/k+uab+OZwmoT4JXAQDcC+yuZnfuGRKYIb3sNqlEzANnJqxdExxeAhBklD/ilBrybcNzbcuPja4gyicGbOXL+/MYpcbo7v+9xCy9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6dXUarvqn5TvniOjA2Qd0GYeaxL212BO3mDEzNPiW8=;
 b=rdvSKDFYmHzdzyUgGo4YGjqeqcInQxewdcCVVecMNlYY5weBT3UAQvk0QP5crl3GSudoGR/GzslTvxTIBqS1bL/mwc2HHOTq0eLWEsqCNFg/GNZqDlorqyPx4ihikHtGj6Byp90hVRtga1OkXgt31Axg7RWPjxfeQJ3Nnd1w11IU9IuTCq0YZ3plWPLjF/3dHQbXFEnODSly5Ps6BKh5jgDSy6VxzHuswG497wsOfCNMtC0W1dZcEmGI5znIdDhgnEPcgsmTEf8m7+oVJi0e0HsEJC5ureOKEkrjKa0bSSXJBzYJUMt9LspMWVgrmt+ZK6S5GHkD7CHaaijgJ9WLwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Sun, 25 May
 2025 17:26:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8769.019; Sun, 25 May 2025
 17:26:06 +0000
Date: Sun, 25 May 2025 20:25:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: core_thermal: Constify struct
 thermal_zone_device_ops
Message-ID: <aDNSpM3WGN7W6Xuh@shredder>
References: <4516676973f5adc1cdb76db1691c0f98b6fa6614.1748164348.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4516676973f5adc1cdb76db1691c0f98b6fa6614.1748164348.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: e04fcc0f-7b2b-46ea-0c64-08dd9bb13b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VzNC3H0eGjEsL4f9ldRtMeAfEbzkIpvDJAwViDWo5lK3yJHsSq6f5u77qgwZ?=
 =?us-ascii?Q?ODlSwfwTKsrcTX9eIb2oe64xD5ZORhvGO4vjAv5jgWIOgR+bCc3tOWm/OWKs?=
 =?us-ascii?Q?d63c8/fN7F2dzUz15I7wTc6u9am23lPgF+UurlHucLl2mlKX6NqvYdJ0iY9M?=
 =?us-ascii?Q?rvZ4haAk8sWRk4NWV6NG00yH1zHnEvgf/y3zqM6zIwcJq3pNyDRUwG+6N7Ic?=
 =?us-ascii?Q?97Rg9GHxE9SUcyhtpH6ITLDJv/N38Gp0juGRSDb6++mkM5qwJ8azIKOwiBD0?=
 =?us-ascii?Q?I4WFgsz+j9YMJgKE1VNUZpqeYwg1uIICYpkKPUJv6pBMwcz91I6YPrp7l6R8?=
 =?us-ascii?Q?14MJpfhqSt3VL6/RDmFTK69CLI5sKJI3jBgEwdAqqE6FsMcDDVft9n4/3BtB?=
 =?us-ascii?Q?jdYUoYaqwKKuw8moY3NGq6A39V3RxxBYhh7QGVbswvLw7Io2VbmIqo3AL7LS?=
 =?us-ascii?Q?0eeScHjiIvrv62E+jLF/2fP+smejKjgb7HNzwFwZz60d2Yq73MYQKmCzcXGg?=
 =?us-ascii?Q?7szBy3DfqR7okfqBGfWyagFx3VgLNw+flKpOasCh/vSXMTmlpqJhWwJC9T9E?=
 =?us-ascii?Q?9XOjM7j0xxG6diE82X1Njo7FNtryin8Vo5kuVHMdAYash4QdKKhwpcfNj8i4?=
 =?us-ascii?Q?zK33GbYBbPzwv+pUE9qlJkRgsqXoY6utVsCXNBHw6/tHkkoT7NgfnMrwZXCg?=
 =?us-ascii?Q?D3s+wyiFTQu5Iv+XKQioxuK0e8VY6OhjTe2FvglTJB44AvLLB+5VY72boYPe?=
 =?us-ascii?Q?Tng6KjXz+qVIx8wcs1mSzNbE4cH7lQbbbcYkWF+bGYm24McgETrlElWMJSL/?=
 =?us-ascii?Q?rQw2NC5M3mw3ooDmelQ08H7Jo736O0msjijilAHd0yEBs1jZ71Xa7gtzIOET?=
 =?us-ascii?Q?liOql7vcvHt8nQ3zI+M8cT8s5UR1B+gVXH3kfF9nfWLrEFVm+5lONJU0z4Y5?=
 =?us-ascii?Q?63LbKq82uZTOL7PHx89YhbBAQ8P5ZE6JzJ/W09f0LKK2L8gbB7rA0rQZAwzF?=
 =?us-ascii?Q?7tXz8gzFgvSwX+5eoi3XO3Ap5n0qX3akNhCpM6b+c23eebrEW9fLnBl9hYI0?=
 =?us-ascii?Q?JwkHmcJ+tmhHyqDHgfduEgA3q3FiE0f2HnBgNdKtS1+emVPpyacADpIU4pcd?=
 =?us-ascii?Q?wqZSfWKagcdueliq0MzL5JyKxU5DsmUnps9SA8SfiY1d6TfbO3hmVXIwQxV9?=
 =?us-ascii?Q?vMBYC/h5h5I8ze4Ps2DGmlpzDc8jBTwURjqDDV6xLOxfJwZqLqjbitwTcu8d?=
 =?us-ascii?Q?DeQPgM5PNAsVx2mWOKx7i3kfIi7NB1IwsESRlh3DcLCdgkcwetmMUk/TA92B?=
 =?us-ascii?Q?N07kGW1Rma67w/c9pCMVTI1pZ6Wjkns82zaJZpaAqfDTfC15NdkQ0+mTi1nm?=
 =?us-ascii?Q?dgicj3D65KBWUeV+5BL5LDocdZSUuXaEzfp7cDOwGgb0U6negi52lWOxYIu3?=
 =?us-ascii?Q?u2Ax4lekTgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?53rRMDoORwXZnaxfldOF1exSv97n7mAXXJpXFh/MVpxRqv9UVgmmr3lx/ZDn?=
 =?us-ascii?Q?QJQCAE0U1P7mEPy96dp09/hPunV8/lkWBHoz2RNIYlns+cJAox5/A4Hs7bd8?=
 =?us-ascii?Q?PGyiqQ92ty3O2A1fuh7ok0Xla1Gswh8d98J0xlqPWEHqqO4iZTR02xIjm2kg?=
 =?us-ascii?Q?x+z33rpB+5UWFUICTYX6aLoEcQGFeCXEVLusQpCQ1+PTH0+TU7A6EHPtVb74?=
 =?us-ascii?Q?v4B5uBPIBsnlBXsCUK1LBPqUHo5LzjLrWeLAMqu7YqjUU0THN680zMfuiC2V?=
 =?us-ascii?Q?aEGlSsB6bielnSgmeAHPr9hbL1Q7BH7CnoovP37lwVkbsc3tKBCjTP7MUYQi?=
 =?us-ascii?Q?tRoMCZn+Rxm2doHpe3zHKe55As8OPu0/3IC35EluM0i6hImj250UrI++4JYT?=
 =?us-ascii?Q?CFPif8PkeOQPNzoUWLbBxNefwfD0PBZTnfMxKV92XSFAS5PBcpWBd6VDJrbU?=
 =?us-ascii?Q?HpokY4VSdXvsUxAcYMWX06A07kdn2MLYSRq220SNhK7ZHnT6L/H5vfN7OrJF?=
 =?us-ascii?Q?wj0tVUW6/oK9H13j8QVDDk1so8k1/R/WVMTovnY3/Fvfhd2ZDjvXwoe3lz8M?=
 =?us-ascii?Q?KxlaIQU+hITApwot1GdAh951inhGWf7pmHyByEneYCy1m7wqlZyyHfx0+eLM?=
 =?us-ascii?Q?GRNVycOY3DuW6Px/JhcAP/AI7HcRW4Ek1KhIycu0utlTzoSHPv3bdDGjIX3k?=
 =?us-ascii?Q?jbzaBSg2N3T4W6EHCgRENGfdYhyQ5nXAAq8P+3i7zLEkJhYTK6JYq8M1O07f?=
 =?us-ascii?Q?/xw1xc2CWm2cFSdSbp1BI3mejeTqmqURp94XfwJB316JCfEZN0pVQCUvrXXM?=
 =?us-ascii?Q?ijQrBjIBDzRUo92vxu0bWXqrXlMnWr758iM85ozMnKW/jfuJ7CD/30l3XMoB?=
 =?us-ascii?Q?eN901nscslKfN7fPNnPr8us9lhpHyn75T/LJ44EVUFVuYcyy0v57/gNhP2fU?=
 =?us-ascii?Q?IJ5oMca3s7AufeYWdfYPUvQX1wK6KpxcuVu3L6OzsL4uU660/ufnsI/msiAf?=
 =?us-ascii?Q?GGep2SPMuvcqFjNs8zh/3wy7gMJoEjWOvKGBdGN1sJJHtgyycQVxg/yRVAX5?=
 =?us-ascii?Q?ApkR2Zfr0mtllWJB7Rc8AKDOzq1U4d3ZNDMa59IBpw2duSr3c7bZIiphEy2X?=
 =?us-ascii?Q?P2mw/dpDWrBFd/UArM8DU3aDAx4nzu7c+Tl9GdbvT/Vt2dOaYP5n6pVUWdIk?=
 =?us-ascii?Q?SDSIraZ5YnT7QZIjXnuyS7TA9ZyJPwzlzt0ksEjM/32h+LUvm+XM34lKIfqE?=
 =?us-ascii?Q?P3FXP6aWGDi/66xFFZvhbHR2P1O9uKzG0YF4siumLevjrZU7bAycEZfyjkAw?=
 =?us-ascii?Q?Ayq0sIvBEO7/5yCYeFo/tDDJXZwuXL0XqV/lqhR172P2z4x1codA7I/kqqEA?=
 =?us-ascii?Q?7erwc7a5aAHSwNvmNF8WHqRi3yMYbn3YpbZhWktyXaPfCvPzYuZm06alzTUy?=
 =?us-ascii?Q?t2lV4qJziN2VvpRf0SoOxWnWB2lIOdMtZ9ntbKOpdxoa2sdfy7GgMBRu42YC?=
 =?us-ascii?Q?I/ufNcGTI95kBpc/vm4PBJYqcN5t7RsOP8tD7vIeOWlezQLtN6kytVvRkghx?=
 =?us-ascii?Q?m2/kM6m0XhP3VAXRgl7Fup39de7pbOH/3MLN7G0X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04fcc0f-7b2b-46ea-0c64-08dd9bb13b82
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 17:26:06.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7tomj+4fVq6J5WkZkArZYdgl8csIJwUQ3k4yBoOR2jpyuBOo+gLNGYbZ3h7CVrXCzgOh2/GNqZOtEpVBIDOkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895

On Sun, May 25, 2025 at 11:13:17AM +0200, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> While at it, also constify a struct thermal_zone_params.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   24899	   8036	      0	  32935	   80a7	drivers/net/ethernet/mellanox/mlxsw/core_thermal.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   25379	   7556	      0	  32935	   80a7	drivers/net/ethernet/mellanox/mlxsw/core_thermal.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

