Return-Path: <netdev+bounces-195233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF8ACEEBA
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619DA189B185
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19511FFC6D;
	Thu,  5 Jun 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OKr0Tk3q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704E158535
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749124508; cv=fail; b=jbAOKA8ZFd3tJu9uuk+mvOq3vyOVNCsrKHRoiHep9uPqUsQKu2E7g3NN0jpN89VmioauZCPNz1xYwlac8BinA0lsEQnwSkU4BAHKbP4+oBWwHS+B6sjUD39GhjUeKJcfPgWilklcipvxroichYQJlHjnh5ZfOeheXL6Nnt57tzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749124508; c=relaxed/simple;
	bh=LtV1zsSSHqXvCxynltOwFnx85aRP3qq70gB20UpBRXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=mnhoHFg4It0YtTar65D4EKvTwjR4DeoU5dobEUwXpE19G5pxIY5c9FANg/S9hZaCTqj9lF1+8PFnV3uFRuQtSaFxx7QtL4jWJMkEuObgl7Oka/KZ1PsVbba8kvunJTWX8ru3O7p/dakW1p5rdIAGCgMQ+sMpR2tSOgDvMHimaOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OKr0Tk3q; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQN+WV2aLnnt6Ghmg3ym5kXAXlxVbpV69i0K4oR/k8BEEJNzs1PI6b/S/+VeHk7OW4ZZxrLvdUduG2oe8gtS06VJB50Ha/AjklLlfmxenZoeDX1oYHthvcKbtfgFbzevuOtqAD7d8OQGOnpTfLpWBRFPlrqaZD1IbRP4mYEdJXsP8ny5+LYQ99TuDOQU7O+XwrDh43dY93qAj96GacCdjPxreagMmXn5EPlNBxctNcbV/Mf3NJsM9nvvYqZ2s6/yayFy5ouP5KvtrnRxRtSB/lzy6Yx16EwDVDranWPhng1Hkjila1T1f4buHg8fpUKz9IIPoX6X5NJLa+nZ9HLyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GInW5Z7N+/b/8kNsKJV3P+k9xu8Wkpa7ekAZ9wuI2DY=;
 b=J0s1OwzHG2JvAqPOBanM5Btl8KXSEhKCV4ykVaO3SXnkLq+CXxcDS+UaosEDaG3HsWv/RruXBWCMN7axoEVL3SR8015h5iK3KsWc/J4cYD9h6OAZyrBjlzyz+sJxAo3L6kCYrMA3B05ATP47NSYiJXu6DU+yoWeUuRlQshTtI9Ggx5DDK7dglY5gq2txbCjdwicuTCTDJBHKifV58v6Y4lfK1KY9sWG7sLC80F13lCtHgld7KWaEuascNNiV+qe3nZ+jE77YE3n5hCBejnbwW014a/X+V7+i77haO4DOovBQ3ilnvY8qHdkdi/Tau/D2ULHRWx+cVfl0NI9VMtl8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GInW5Z7N+/b/8kNsKJV3P+k9xu8Wkpa7ekAZ9wuI2DY=;
 b=OKr0Tk3qwLQ/DLIVPJd/HdjRHxyW/Z4b9E8yN1aXWVKdidAXQshfhNwFWjU/h4h+mtKpsAng9LYX8CFvqh5SPl3UabMpkFiRkFckbaJJxuBcJB7hnHM5P42f4XvkH1fQtnEfWFAyPn9wYNaAMkeL6KXvDpvuTjvPkFdhv3nxKfTztK/EveSVOmxJ7Ci3JAoNG7wHWUoRjx1MnyE0BYMQU0cGYuq0DgOM/vycb0cUjGzzNk18z4Txlc31V6JY5rQ7tLIUDGyn6n2/ltb00r1dy5TSe1VpQht/tf3oNH7vtHVslf2tJEEQ2e2lfGF+GQy/rMmxRdyrNHrFHEKLOWBREg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 5 Jun
 2025 11:55:03 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 11:55:03 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org, Boris
 Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <CANn89iJ6HROtg3m3z8Ac61e0Ex5HvgOTNavfG_W0j97B0XMZkw@mail.gmail.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
 <2537c2gzk6x.fsf@nvidia.com>
 <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
 <2531psgzo2n.fsf@nvidia.com> <253y0u7y9cj.fsf@nvidia.com>
 <CANn89iJ6HROtg3m3z8Ac61e0Ex5HvgOTNavfG_W0j97B0XMZkw@mail.gmail.com>
Date: Thu, 05 Jun 2025 14:54:54 +0300
Message-ID: <253v7paxv1t.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: fafee095-e920-4cb8-d63d-08dda427ceb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0LRNUJpSUmkAIcWOYyhE2hGDFmmjvDtCKU2LAp8Em2CrqeolVRWL8ZIFuuho?=
 =?us-ascii?Q?NwFaSXMTbd+jyotnyVr4LceuzioBLU2b9BECRZgIEHpRR1sBXGroKPSLji/N?=
 =?us-ascii?Q?C696gDtjMrM8hFqHPLKuD+qyvdAE+UdvD3cn1SR3O9ZzCdPDvTyVD5RvcdkN?=
 =?us-ascii?Q?wa+SuKZxe6hOJ6BaAWuwc9WXSH7BrpI6VId167Ecw+cMwk5v19Qz/NKwQcIF?=
 =?us-ascii?Q?ZgmUPvismxrjPUj61w1MtKCPWOc/DHPdCMozd+pOmQ67JRNvCqnyzfylbXNp?=
 =?us-ascii?Q?gqSTEZLxKC1MxsPZZb5keJy3kp86Plmr/dQNB5YOhtfQ+Ia87NiwdbKScH2F?=
 =?us-ascii?Q?4O4ONCMmpuf8JDnoDzdiRMBIR1YnqMumYRB5kmpOeVi8rKtBoxQnA3H+U64D?=
 =?us-ascii?Q?SwB3twYe0DXr207+ybo4VzDro01ViFN5qacMgbUQ1rGZ0c+XVU/zlx+zesSD?=
 =?us-ascii?Q?dg0IuCCXgCzx4Lgrqxjc21eDXxWRz9zo2yHR4y7NfLYjgGhDuiMhTpfzFJQm?=
 =?us-ascii?Q?DwPyS3Ew/gD+BE51TN0IPKHxEarl7wAYMg7fBAu3aLUK/r4epBjXIC15xHQ5?=
 =?us-ascii?Q?BkLNpp8xf+vkYEFTCzzZDfp4IkuNLl3F3qf5KMW/NKx9zjUUjs4HBGSalJWo?=
 =?us-ascii?Q?I+w9dsc/MFpui+MNM25bSf8L9SNc+Pl1MJfpTl1NiCeLHTUYzJh0sip4oALT?=
 =?us-ascii?Q?vWcUfW1lg1dGCZDLxHuwxdzqmhw6DYPjwqdH1QngF8Bh3DIbQpH/CnGvdv7+?=
 =?us-ascii?Q?aNdNSnQA66RznjnS8UL6vauEnUKSQHze1VtAP8HYbheUPeSdsaYrEY3Euzcz?=
 =?us-ascii?Q?GLlu9JGGcEO0Uz7u5yXYswemzpnXyb8Sk8nQzHY4k9SrvhGoKDCHQkQwMlvk?=
 =?us-ascii?Q?a8p7KEZQn1aTh9TexFaDJfTmUOaOmC38727NuRFnl6l0rUssgWGC43NA24d+?=
 =?us-ascii?Q?4iw+hjKvaCPxfPLo39gsnfN+s6lAHNtpL0M60lvXUjCnJcmn6qCVbwoxjQPe?=
 =?us-ascii?Q?opIPThAYGpurfdP8z2Tg4U4Wn9RK+Eke0qM4uQGkbv9NGembKn62AqmspIOe?=
 =?us-ascii?Q?FGdzkwVMeu/NNxK3A1U+Hl8zJMy+Xo7byBF5gbcprOxR74vNmSMDM821V8Gl?=
 =?us-ascii?Q?slIqQfyrILgnHNHIoPtfKjwiTQk2GCRRTxW9WbfV7wdA3Ytg/sPLaP2FVirx?=
 =?us-ascii?Q?VMVryEl5qenrTwkEiVlsiTWOHjqJyow/RU+T6Z2P0+KG4GDo1tc5IuxJOHLp?=
 =?us-ascii?Q?odwqRv4a0iBcR10XC1SdOkBjK6e0FX39jlNcbQvNiXdrJwovmoFYu8LPRs06?=
 =?us-ascii?Q?gPHAF2BWqFGPmsaGLo6Y2Y/Bo2K/IRuMiQdCrfG88sUEtX0/Ls+uofBbvtS2?=
 =?us-ascii?Q?egE7BCRJvL2F5yu8UjRKSrEg7OuHHPLe7dJnD6Sv1BiLwlNzC9zlsZbA7z4Y?=
 =?us-ascii?Q?8Pto/LKpn9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A4bjPOoOk3WmxsCjO8czWMI+6D1hyzBW+zoSnj1bihiaZpR4YkSl9EkOTw8k?=
 =?us-ascii?Q?W1Lu/86H6dgb/zsyOMqnEttZJGmMVm7NUTqOWFghpQf4V4zav3Sa5f8A5j9i?=
 =?us-ascii?Q?karkcI+zFgtI6CTM6fOfiaGnUReRimxgJNz0IEGbDZqGau9iw6scnTt61ZcF?=
 =?us-ascii?Q?uN8Ze25xI/QEtB+KN7F5q3EbFb1wcU8YfzIlmknNzECVXykKnhOoNUV6Mazx?=
 =?us-ascii?Q?v8kEboESi46FprezLdGkrdvSdpB1j5xiACONKUy7MlgpxDnSpeN9L9ZTdeoA?=
 =?us-ascii?Q?Z3G8Eqo9igfMLru4QJ0qi/O0fvmFdUhFTJVPd8KlixtUJRMfReUAB8OZU4Lz?=
 =?us-ascii?Q?m2mdD+LUQyikmlqVtL5OS/HKrLM685ht3gPJxfcO/loYQFwMvLjaq0xn92og?=
 =?us-ascii?Q?w4757lNP+2SEnK68IQ4/ffnwx6anyz1pqIx/26WqnltAzxEqe/5oCv95yxxC?=
 =?us-ascii?Q?TPOm/RbbzkTxO17rf+/WA/WwkEmlzKm+sm5GHt/9XZOr4rNbv15oe10varNO?=
 =?us-ascii?Q?U2I5zUWSTnwDjcdOrye6QQ5z5RLicsk30Kg65cRHJpKW2B6CoL5YHsYhsBgV?=
 =?us-ascii?Q?b9BEkBDkDB+1stlmHRm3rZAN93sNoUl7g0lfMqLg4JcsyUBH9fX4LB990NJ1?=
 =?us-ascii?Q?Cet2W2VfNFHQ41Z+Nt+QitaFu5mrbF1JK2SbFRUD+TipnGlqXos/n7neKyIi?=
 =?us-ascii?Q?jhqPdZVyzyrQNDknjb+GxZxO78Kd8tdcRW029Kg8vduZPAmm9pEoFJB6HzXG?=
 =?us-ascii?Q?iCV23JgLPSIatBibjJHak+allJAlTkzhm2OLxBQMXxez6c2PA4dG50ZStx8H?=
 =?us-ascii?Q?s3W3rlls6edyFGuyQohTIm1HwXKyZg6lVrqMT99CdD73rXJVO62Xrgq8Zj+X?=
 =?us-ascii?Q?+umpIwCfir7SXPPNlD+EF0AXApmX/8lPWOwf82N/GhQOeWgKHv17q2RYpqqm?=
 =?us-ascii?Q?XsIMR+5uQJNnhCaNybY4CN7d2re/7SRrfHYjn+Lsw1pSoF1cv67rAP5cCAHx?=
 =?us-ascii?Q?v6x/WdttOASyohzr/roH6UZugozVw8IFG1fA1al2C0a30cYInoIRpsJ62KrS?=
 =?us-ascii?Q?jUA9IfhAdMLxNsJF/+L+jo9ihtou6kOVE7mByoN9OMROoyV/GPGVCEbw656x?=
 =?us-ascii?Q?wsAMrCMGR8mFq1G1/O5Hx/9qQZq0EHlAXy80F/zScwlibEhMbOX64eKlJs90?=
 =?us-ascii?Q?HyM7zae28lgHDsN95Faes59jgtmb/aRZUTbD89MxdIGPBw8VsDchtNRKrZ9m?=
 =?us-ascii?Q?cGwLfsn0CYIIycPZiTmKL3mJbSwpSVgdjxDEm1SjMCJPMhxdamUkhnqAxbPk?=
 =?us-ascii?Q?7bno2RAPIkYCY1r4nQaHbgI5ftg3q8LQ8/FzX7Npn1RX+mTlHS/WxzPLgcc2?=
 =?us-ascii?Q?okpGU3tHB8GN6qOTG4Q36Pl5x0QWYc+I9zeR5GHFhuodC5lqLdCf0HeQ9mPJ?=
 =?us-ascii?Q?T9lUbvUV1/kWXzRqoI2BSPKXZ0EW6WErLlKbuj74cH6hSJRtFM5D3uncaraU?=
 =?us-ascii?Q?tCKOGX/7wPVtLyd+dkpmNWqZulCK/szrmeZJO3oroARWdNsdb6J8eErTg+5u?=
 =?us-ascii?Q?Nv8XLUi6nMdJsWc0fR9u8mK3cAxxPhQH5Au1V3ID?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafee095-e920-4cb8-d63d-08dda427ceb5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 11:55:03.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MS30hgIxOUCmcT7LDM49h0dY/2V8g/W50VaIoR9AkxQO0Kgi4uUCdqG9iOI3UHsbA6lb2UniLFN3m2GS2JZwOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

Eric Dumazet <edumazet@google.com> writes:
> Adding one bit in all skbs for such a narrow case is not very convincing to me.
>
> I would prefer a disable/enable bit in the receiving socket, or a
> global static key.

We can move the bit to the socket, within the sock_read_rx cacheline group:


--- a/include/net/sock.h                          
+++ b/include/net/sock.h                          
@@ -420,7 +420,7 @@ struct sock {                 
 #endif                                           
        u8                      sk_userlocks;     
        int                     sk_rcvbuf;        
-                                                 
+       bool                    sk_no_condense;   
        struct sk_filter __rcu  *sk_filter;       
        union {                                   
                struct socket_wq __rcu  *sk_wq;


And then check for it in skb_condense().
We are still evaluating it but it looks fine for us.
Would that work for you?

Thanks

