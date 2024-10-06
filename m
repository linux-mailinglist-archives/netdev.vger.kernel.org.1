Return-Path: <netdev+bounces-132483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938B991D56
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1AC1C20CB2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F471714B0;
	Sun,  6 Oct 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BB/GMAJU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4062C18C;
	Sun,  6 Oct 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728204109; cv=fail; b=Gqkt/W+H6s1oLqvpZaLpckiy1lDJtKTKjewof0btHnXISsQ5ixJCXJBHKbOHBnNN5hMaeZ0xfYNBZW0HmRSPWs/FhmruqOlNLUJ/2fYD4YJtoEBCgtVEkWI6BBAEDR55U3AybuWVbrYcoB/Ju1PS4Lp2B2UWCcydimvo1p4OWcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728204109; c=relaxed/simple;
	bh=dAFgtEx4Fc1tPgpIPRkc9DYNU5hqnJ+OOSM9oMsaFp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tf2cML8GV9QH62xzXJkGwgDf9Zu/IVdptm0cHwYVhGIx6O/c5KTvpOMySgwNtP5CX2H+3XO/I5NKhDSHI97EjfqqZLXGzU5xbm3p2eRezbA4Rj2VJCUPXddNQl9iZL93N3Jm8p0GxKPvfjuYN9A5qTRnLV0u0Oefh00oWIn/sCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BB/GMAJU; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFO22MhIZyzCgZvgyvmu3SkuRQkHE2S3rXxTEBXOgerYv2NrNNf7K2GdYf0gFisPtUU0oM3BdinwFj1PcQEsMy1y1hTYyxlicI3cKKNVhMfdOWfqEgF8ZTKHnXmziB68uKr2kPrlPlAHDnLDgWeFA9wwcS47uESMYzxD3xH6gY/c/OY47jmAQCDT3wwi40Jx+MeRggVJxbq42VN9RGcwI80eqQQ17unKSE575BEoSUVg7FdSQ6uq+Ip4TQinmMT7ulFDUD5fXopwLq8TWypufESxZ3qdwLkKOTfBYFBkvxuozM5bh6H3iGXZ+7zPRD6QzPY9PN3PUQC2geRjXgXWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayqDiWRTR4UE1CNoocD7O4BovjOXPSk82EO46vX/gpY=;
 b=TZ+jiOxIbvpUViQkOal13lsxNow5JSQ04VPPDRVFx9EtAJB1GXYGMeYK5hb6FzvoucJurNIWo418MO3w+KMTqEBu50Nq6P4OiacElAr0GpafnEYXRQ6toMnUObFlYckJpGKKnn1HFxj4z2AeLpItIzMSgpTNOBe2UZ7jp7SsQyUhMU3b/ST17noi4tc14/99E8W5iQuakUKisxwfETUTSVrag4i+i2yNli4PGEqrpd9hggNRkiUBuOY5BHNW3U58IViswZdsPGzctuC/Yw4UdNJ9pVCKtujFDHxYUwJFtJXfxb/Wed5DiPSSyHqT7ReoNpbm4GifSU3OKbvUGuyVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayqDiWRTR4UE1CNoocD7O4BovjOXPSk82EO46vX/gpY=;
 b=BB/GMAJUNAPp26V2JhBPNYkS1eWdzrus00dX2ixh5jB83oCmkAh0F7q5HSfpik4SHt9sw1BS86+WMwRr8lIh29LvEcdYP2E8tNjGDmN1PGFYJLnHgs0z8MdrM5UNjs9eawLN/bzz7g0gRWRNMmF1ghza7W4NiOr+HB7Um+vM9M76PqzGViueAT6DjCFbqw7/fsSvxPaEhGHXmCcw/wl5vReqc0PNZzRyRqIBvfHr7rlUarRScEE2EzM2WV+e1Nm33Ti6OWEi5JNBZX07gau0nun21JGGZgaKUGb2DTbffKbEIucgL9kRbauSIxIgc2R5EBly/WHbQQKHRO4k8Qs4AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Sun, 6 Oct
 2024 08:41:44 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8026.017; Sun, 6 Oct 2024
 08:41:44 +0000
Date: Sun, 6 Oct 2024 11:41:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum_acl_flex_keys: Constify struct
 mlxsw_afk_element_inst
Message-ID: <ZwJNPaCiV2kyj1xp@shredder.mtl.com>
References: <8ccfc7bfb2365dcee5b03c81ebe061a927d6da2e.1727541677.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ccfc7bfb2365dcee5b03c81ebe061a927d6da2e.1727541677.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 9717b88c-14ad-4174-ee16-08dce5e2b524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJu1CKoEnTWzu794BDTMVvyAQZangFL45sqbt6LJ3pzngpV1rlJuxxLnQlXR?=
 =?us-ascii?Q?fINUw6GhLDv7Ug8uzymTgGZYrb0w9IEHRM2qM8fWmENiU590ju1MSD/EZn3t?=
 =?us-ascii?Q?Ici36So3OKf/J0jzLgMSx9QC+ErxsE6yqAL5toxt5UU6FQJk49C6h/Hzq8Qd?=
 =?us-ascii?Q?iYOnXlWA+P+kv6JdlhJxmCeXTdd0BdxNRMIPRkLxoRZP8eLEkgEoisYw5aEp?=
 =?us-ascii?Q?JkbFDKhHLHPOoZ6G666Z6aTLwcN/C71b/FiNGeKK6zjrpG6gK1BqmVRRpPmp?=
 =?us-ascii?Q?5Z3JgJEU+/DRc+1tk7CjOn8TIyViCCFdOooatl+S8fUJjJZbTTEkKx4d4lvg?=
 =?us-ascii?Q?UgDBHLztgwQipsC17/x5e55xT2CM2/384nVblQmd9ATYszqIy1c+ojlqlF/s?=
 =?us-ascii?Q?oP0c1rzKX25jl+1UI3XnWoVv8vpAg5Wqc0jPe+xSNAm9UZF+2jZ/Zm5XKVDm?=
 =?us-ascii?Q?QmCDYFgp8ZhExkF8V/NAju80L9EOCjs3zkHERd8KIwMWRBKIOHulZEj1s3MZ?=
 =?us-ascii?Q?2ptokEy3wyLdS9Xx4sxWLKbXu/tt9Rb66vad4NtZ0bZPmb8rO5fI2fSWZNod?=
 =?us-ascii?Q?dIlMqu8Vhhe4gB/QPNCO36rwQai+S7j/nl0My9L2N27G+5F6mfrme6XwitRZ?=
 =?us-ascii?Q?8OBxNUV6qeYPiM9HoX02/ssUITUKuXYRdJILx7NGVo5mFJ5NCBpKOflFjVZk?=
 =?us-ascii?Q?IUqhaDOZms3jg4LV8hdgod1cbubxg/W9VoC1tGf3izwBxGakkvIDlFDUky+b?=
 =?us-ascii?Q?RaeXppT4+9rfjdIsDjE8yNibCjQULx4wZi9qvtSELcMGi0NO7uB0hE/ILHh5?=
 =?us-ascii?Q?7YKII1xBOyuV+cYAagHusopMco4uKNBp0rAKjogoomxUCwS2mVpoNKPScm6Y?=
 =?us-ascii?Q?FY1hIrV4QEF31zNA4cx2Rsqzc1qnVem9tRFvb46unJIWYgUJI8HDNzS9nH2b?=
 =?us-ascii?Q?5p8leVbUH/Qmz/8uwXGIVpvfpg+7O1SI/QgiFJm9iBipcZlWZyoeR7tEuKb1?=
 =?us-ascii?Q?1zhPTGUw3hQxU12a0mCJJylwscImh4Ntl3rMEExmIXkv3mHSh/5dw8ZhiT0L?=
 =?us-ascii?Q?OPYZ5DxktIRQRZQShHUqCPdq++DT2YJO7Q/Ias8p7JdOmIKhkR8tpjOpKcha?=
 =?us-ascii?Q?ugCcyhcsKZAt8zWlG5r5dqB0QZgqoiSzAo5HzT+El7noQAw9H4oetyc2bY01?=
 =?us-ascii?Q?l54qeGmBwG0DU+cOIZgTc/ZSI6CE6T2lzO7JaxkBDoj22BM8Si7aZBxJlBxG?=
 =?us-ascii?Q?CwQcv/eIOqkNnjDQ9B6/effM/9xidrLdT1ZE62YtQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8FOXdD/SKJwndKrrla9fE8WCWgiZVfgvNlkmT4gRxQAP84nlLU85s1gVs6b?=
 =?us-ascii?Q?TmBl/x99ev/Vte6sMxLq9QIcepanpdNk/iFHLbLOSqh4ABif02kZTFILFVcy?=
 =?us-ascii?Q?WMJWnUq5lIFpXk3lJGFNXGiztJZYstBHBtW2PuOAylk6Jz1MvGGxJnUDZYx3?=
 =?us-ascii?Q?cvdzq6ufgLlmJIgMmbwTbezFrhUOA8YHxHmLsEwYEAoM7TU+VSM9OI8ZgYOd?=
 =?us-ascii?Q?ARLpTjV+qBAbovnoiI1o55lX24xhmE8q3JPwVZrMmfcYTp7wYXK4e50hGdT6?=
 =?us-ascii?Q?iz2FxENV78w59MkJpR1CaqFbgseXrYVDa8rhN390baBSxC5dZK81ws+gdPH2?=
 =?us-ascii?Q?MHa6wWcVbCrRx4oMQomf7Oyd2jFJTYjhEFujwgstmfw5OZ7SDcFoILqBAgSP?=
 =?us-ascii?Q?ZqlqIqK6KgM1NSsj5HCrI6442yYRpSGJlV+MnG7+8khq6Qb9ekuoCXfGPQVE?=
 =?us-ascii?Q?Kx+81B1nrGDyQt9PZ8qS3B+rho9q5xIKjlYdrie438I2wO7eQ/+laBzsJL1E?=
 =?us-ascii?Q?Ys7XUcMKG21hRh9S7BDo7205FE6DlSjpq++McKSVy5XJKL0n8iCHistAENa0?=
 =?us-ascii?Q?axsqNOQFebSHcboT0muUK3VGsZVStx1NvrdqM3cW2w+rkYQE2Df0ks5kS6uu?=
 =?us-ascii?Q?ylXsG72Du2ZNRny9Z2oDrHnkZzYpgWB0EZGWpgCb7IZs8IHXY62PMQ6i1+t1?=
 =?us-ascii?Q?ezzm1a3FitDf8p7md26lZ2R5MJwY1H1f7r46gWbhQT4st+WXNS9Aac+gsqMB?=
 =?us-ascii?Q?a2dKNrt8N8U7d9Uqm5xD7bNMIGSatpw2Gek4LoT7Vhq9WFIBhEmrYWnsccRL?=
 =?us-ascii?Q?UkLy+O45iUtvsB1KwUSThaOiTBuueCVrUDuSnlQJUVLSMcup9H51yJf2vesq?=
 =?us-ascii?Q?GNUnT2l69adk4ZTU5m4Vkryet6csQKwbG1hmbrbmeLJU/tjnBui5B+YidDCR?=
 =?us-ascii?Q?ZOiUj9mDgoNIauxMytaOowRi+WchDrr0Ck8Qs2mGI//+0EVu25CHG43eWv9o?=
 =?us-ascii?Q?wI9oKCMMtyLU/W3bAPK3bn8xo7vFNbYs+tLQGfuEqSwdQkdtah0DTA5RWGOq?=
 =?us-ascii?Q?Ve9225sjOx+4ljzKl6R3UQXEsjLuvpgpxJkq8DffI6syKG2R4mPmtEJoJ4By?=
 =?us-ascii?Q?0KucUED+uw97FB7L+p+ERw1ZS2UUc8vnlujSOJQIv74ARmAYajAcqk9Gorfv?=
 =?us-ascii?Q?5q7Fu3GcfUKbTZgTfZBJ8HPhzRqXkY0m5ZtjN0RxxFNKMAo51rOgwpEElwHs?=
 =?us-ascii?Q?LsqzHw9E+gBWoIZRcfkYtUJTrM1t1UJfpf9+XYe3F9k3mUqR28fXvs7CL/a1?=
 =?us-ascii?Q?JxuN4+AxQdi3zsv8a3yP3J7hiTWTBBIjpwzW0dHjnBrEOse2YluGOXFFErAS?=
 =?us-ascii?Q?QSNbfguJc0b8SQHK+DhnTUSEQF/4QeY0PxFR/DluuJz6CfHAeDiZBjHQMWA3?=
 =?us-ascii?Q?0QyMQo7jMKbb8ZVxGGyap+/CwxMu991me0SPJfDhBqOUT93f7wq5lQ7NN4Q8?=
 =?us-ascii?Q?/zyJsLjTjncXuFif8BpF0Vb7w7ZhNq0Nt9zPfvIHiNLaPoCqdtD7GYtBKqqA?=
 =?us-ascii?Q?aNXsZOveRT7t4R+n6y3oStK6b1SvwqaATSYXtD4Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9717b88c-14ad-4174-ee16-08dce5e2b524
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 08:41:44.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwzu7k6C6JL2chMyKYwryoODhZ/HYSjjZYaWEOW2l74IPoCavlnaDm9QLgmJrH1OObRajgyU1jfjMJppLURsTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

On Fri, Oct 04, 2024 at 07:26:05AM +0200, Christophe JAILLET wrote:
> 'struct mlxsw_afk_element_inst' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security.
> 
> Update a few functions and struct mlxsw_afk_block accordingly.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    4278	   4032	      0	   8310	   2076	drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    7934	    352	      0	   8286	   205e	drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

