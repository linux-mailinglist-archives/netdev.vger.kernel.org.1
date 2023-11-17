Return-Path: <netdev+bounces-48696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993D7EF46C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0BEB20837
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE236B08;
	Fri, 17 Nov 2023 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="jzmYDxNt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2111.outbound.protection.outlook.com [40.107.223.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0AD4E;
	Fri, 17 Nov 2023 06:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCr3X/+Gprp6MP9s/6X8sWDM6YOI2DqSzZ0ekC6t7TkH7hrLU/fkxRQiFuqZ/mRdu70BHxaqy/bNu5a3fb7E3DkQ6pvkhRdbFWl+Nmy9/qOAsmSMSAE/ZIBhUkZzcegJzwP39DkxVhzWhjSsb1Hp/DS5ducDJ98iF6bQQbDmfHF3oIz1B1c2BG0TnhYNp7UoLGuzlAEO4YoOXZCGwTAfEqglIhhSgoIW333QU9Jz9+oNhOCL8GDqh1UFeIv0RFluf+QuLiChqUH6WRhWinSJK8+KO8YsSJnhbSF9uNmrIymtJtQgk1iCMOBlNTYzmaFSdUlG8IZUXj20FYmVxUu8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh1+oW13LsJeGHg8h14RNlZl2PzXat/l8RPBJmr1IdY=;
 b=lFSDoRy79Gj4qMXZgrgKYeQ2TRbxBeuVzt0Sdy+TF4mHiEnPMRtHadqrgXLwIzw/azScBQuKOKjshRJ+dJAQ1rFz5bDfF7dsENQUbuCug56Jq/zCLUQnE9X9gytJJyVc+N3IGFP6MUpgJmN7TRkcVgH4KflErPafoQYP+vumKyy71ceN0l6V4s++KBtFI07kwfJXOpTDCnOYFS6250Qo0VoShmbGol3Cul4yZqZWhULvp7W1jJyAHpPwOND/6DM5bwVQdBuriDLlI5AVpHwBjKxepk8OB3sVACQIatVXRpLwoUj3PVAYnX9pIg/7ZNnA2JqCBjXjfxiUu6bkpqOGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh1+oW13LsJeGHg8h14RNlZl2PzXat/l8RPBJmr1IdY=;
 b=jzmYDxNtkj1GB+6ND37899u0QknGu8GmG35HzpAygX81YJR9Wsw4h+hWFyTeLIPITNrV4HiqlOFD6NVfm0dQPK5pAaD+7cpahkd98FfnyZcz8l5xUDQ/YL09hIl+Ps6q2FQEsktQbx0FK/hKX5bwlhaaDLG1eh3kM1RG7A4nG1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by BY3PR13MB4994.namprd13.prod.outlook.com (2603:10b6:a03:357::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 14:27:28 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 14:27:28 +0000
Date: Fri, 17 Nov 2023 16:27:17 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Denis Arefev <arefev@swemel.ru>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfp: flower: Added pointer check and continue.
Message-ID: <ZVd4RYURdHLL+F2h@LouisNoVo>
References: <20231117125701.58927-1-arefev@swemel.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117125701.58927-1-arefev@swemel.ru>
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|BY3PR13MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: a94540e7-97fb-4e99-05b8-08dbe779539b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Z0bFYqzBmDpX81cNK3LDe5DeY65r1oWfWovmSqju5gPHQsl+T8AKGLXpqP3Waj3intWW+zFeXV8f5F1YHtvoRq/XwUoIhLu4qDevcimT6RCcbeYC6b3RMceVpcN7YcZUw8+SHBwpWUx+t5E9B1RI8y3Xd+Qbu6EB0IvdlGSJh2cIeVrlNi5kNnaJngUSOck4JxWb2lCk1RMghgu/dzsc0p7Ur3afqTiPwX4Y6lTrpGLzBQ6wwKgTTeNHA8vjdmEgGYtEKs6tgoVHRmLWqX7NNHou2FRfVq78fJr5Bv2YwjNUwzbjkO9WQkdfGyn2ICgk77Vg/NXqbjLC3pDnC8/ceIL5XaxK0Jgigs4JwGI/uXgpV1NFUMeEinQHH02TLUhokO4XjQ7m1q3smw2a1sy9Aq/IqDKMIth0h37b9dC1Jm01ZnMd1e/sIUOYJX7Bt0KQzWywLrAzxq+Ca4P1zY2I0EPiCsPcoihMDDU3RXY+Ie/BgQGUbXUPcLIYHbHrMIUze8u7At6wE6p9pVCKYhgeAlAFcPoEujuGLLneZDsIvlra8qathIM2qhIWdcGwYf4VVH571mj07xj0gfNWB5F6DI4Nb+NUh4AFd8vWFDRrN+fVhBeIEoLPpyvM5KCYLJG+eSbL4UPmsDCNr5YZCRehbaAiIYBme1PsZleGBvX7Rs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39840400004)(366004)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66946007)(6486002)(54906003)(66556008)(6916009)(66476007)(316002)(478600001)(8936002)(4326008)(8676002)(6666004)(6506007)(6512007)(44832011)(9686003)(41300700001)(86362001)(83380400001)(33716001)(5660300002)(38100700002)(26005)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y8O1pscKI5GbfD8zs9upvFQyezXHeASKH0LWjoTUHEU+NbM9Xa57fEu7b+aj?=
 =?us-ascii?Q?Sx4PsPdazRB0wmTKCiAcUgtEyIylnFLctu8sf7gdsGj1mE+r6Cran/8FeEsx?=
 =?us-ascii?Q?QhLC1Bf350ihH+hH2WrD4qbx8QIvjgdCnxtzkYqw+Us3Wqc+fhlGQiu414Vd?=
 =?us-ascii?Q?zvBxtpRXCM28SmZW61EkZ8QRJ9uRDyEcuUJT5NNrlA+6qZ12NmWSoyegqBlk?=
 =?us-ascii?Q?LiwEYyFkLW8GqsK7cCT4bpVqsjCU11nsOMr9gpc0z0m2Yq/PHQ0jDWnZIM2f?=
 =?us-ascii?Q?Qw9MnUWWrdQtcT5zqbbVmILl778ivHQWwyKZbnhMaX82thU6ApeTD+TYvJF2?=
 =?us-ascii?Q?c15E+digZA7kOEnpXwVd6tMFI1GEbn/nXl3mzXzmKFchn2gdzBYwJVrMuP21?=
 =?us-ascii?Q?ogc1vNzE5Et/2rNweX8cM03CiTjvK143pm5cUiHWA8bKmqDtD+JQXdUlgyWb?=
 =?us-ascii?Q?EiLQ53TnJajdvk0psKv1sdIgcUWYhzHtFn1+oAGdT1EFTGbcQZvF0q1g0+fA?=
 =?us-ascii?Q?86+D5Xuc5QSF00pVs9uN0Gc5o4z1p2yHZ6SC14PQ9mk2AlmYkTWE/qmgILQr?=
 =?us-ascii?Q?O7+S3Mi6nnH20uwP0XRbt9FgM8mJ2kqRu0vcLj8ZAWuCoiNJ7dT3Qo+3LIxs?=
 =?us-ascii?Q?3NGVNgZ+atYUmJiV2ojce5m0Kq5cyY1fFsYTB3hgkPF27exA4zPoPM2914m7?=
 =?us-ascii?Q?lDbc1xV1mT/nR3/nh6TKw81FAt2ot60YQp9QrUL4zWZfHUvayZb9O8W4GB16?=
 =?us-ascii?Q?78cT3jLNePfwsffQL38ECBbLCXlMtqO0QkF2W3Pp7Syw94ceiAjD1FYav+wf?=
 =?us-ascii?Q?MRdLr0ayHWxZ8RLc01P3wahclCsVf/YDR63JuXnpRWb/FXyj9pAv2zEwM/iv?=
 =?us-ascii?Q?gBnuQVkKI5y/ble5Gst4zDGvJVP60nPj5aB5JD5hxw7zXNqM8HhYBZl4gCCm?=
 =?us-ascii?Q?tJuhaZba9RNqPEEBBUHiL8TwYrxcYcTF+WlGX12yY5GuonuDi+gdik1sAJw5?=
 =?us-ascii?Q?Xyy+6CkiN9VFYIxW4U0l+snDblQzcdQ/THvPJM3Ep7e8S+BhbVPwbpiUH379?=
 =?us-ascii?Q?NAXJEZ6L6cjRORz9H1r+DpPYR8mxFNPI/L9nCmVr95Jo4TcPBYf9veCNqC1n?=
 =?us-ascii?Q?gXyYg0Xzx5lzBYtKmRpOKlsQI8xJTFaW56G7Q6gn3XrFSet+6a+svh3KRsZa?=
 =?us-ascii?Q?tr6fSWRRccRpjkdFgdCV9pTnYR+IbCfv8RFI6awxEc3NDLsFhzHKL3uAsXuw?=
 =?us-ascii?Q?gvByu0lyLTgGsyTIfrtE6jmL7wtrke5E/wCGiwqeWNBYjGhjLN6mir3lsFup?=
 =?us-ascii?Q?3LbHe6lq6moHb7mQX+1SWvg4tgF6WUB5fbMnmbwA4nIAb+AHznAnDJhCEOfq?=
 =?us-ascii?Q?sQWGqDBk8QHa3cNZmBPv2FBKXbLlvbyKow0zDY9NdzNq8G1GFFUUmuQAtdBf?=
 =?us-ascii?Q?RABSm5vKJ0L0ecBaOCc0Hbeavt+FhFA90U3PRQa9vi5aw7JLXPZ9fR2hIk8q?=
 =?us-ascii?Q?J2j+CzVUWoYPJj5+gnAWTtCzCzy16ivUfuQ+sUfBZf9BlrtGcuXuFIlxbvr2?=
 =?us-ascii?Q?aiLQPEPB0zsQTaP9i2tWu1YCqyZR/r2Mbu+V6K8kpPGxpo5Zm6C3FO6Ylt+B?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94540e7-97fb-4e99-05b8-08dbe779539b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 14:27:28.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ATifGmkNhDgQUytDuiiRKS0XmyZOZIOgl4sPrWs5rJG834TuyoLG9Q+oWmu1nsy18pGikqHOfJd4zViJZucPAH/pS8v/8eelerGVelGTiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4994

On Fri, Nov 17, 2023 at 03:57:01PM +0300, Denis Arefev wrote:
> 
> Return value of a function 'kmalloc_array' is dereferenced at
> lag_conf.c without checking for null, but it is usually
> checked for this function.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
> index 88d6d992e7d0..8cc6cce73283 100644
> --- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
> +++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
> @@ -339,6 +339,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
>                 acti_netdevs = kmalloc_array(entry->slave_cnt,
>                                              sizeof(*acti_netdevs), GFP_KERNEL);
> 
> +               if (!acti_netdevs) {
> +                       schedule_delayed_work(&lag->work, NFP_FL_LAG_DELAY);
> +                       continue;
> +               }
> +
Thanks for reporting this Denis, it definitely seems to be an oversight.
Would you mind adding a 'nfp_flower_cmsg_warn' here as well, so that
this case does not go undetected? Maybe something like "cannot
allocate memory for group processing" can work.

>                 /* Include sanity check in the loop. It may be that a bond has
>                  * changed between processing the last notification and the
>                  * work queue triggering. If the number of slaves has changed
> --
> 2.25.1
> 

