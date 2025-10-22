Return-Path: <netdev+bounces-231660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC845BFC2DF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD613B4879
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F2B17D2;
	Wed, 22 Oct 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/rj4ybt"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7CA26ED20;
	Wed, 22 Oct 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139105; cv=fail; b=qrrC78W5huqavJH8W9G9pN4X9A3AW8Irm9dPpXyp1CFiriyMJ0gwaR7mPgqaRFDWvYRIAarZyu0ueiDOczzEld4miexYQ1EkfJQfzhg+rhOKIsAs8DEB4jsYCASgIks2S4PPk1YU2BbeApTSFoE8CvhAdjbhefCB65diXyB7UbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139105; c=relaxed/simple;
	bh=qGlE19uP9qKwciWjxoolNkGDMyK4/+t4+rkhm3y+NvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UH4HSn6izH+Q8Jusu+T1OeSLrNolRWIAS7zLnh7Oii0cztLSOl8BW/TONf9G+oYw9HUU32JgbIGVBxf1bCd6Cd/pNpbl1Fw3B4oms8TpuhNKtvQEq607bjtTCVUgg9e1POnkNrnBUTBlo2mZHEWIu42RjQktwJau1P3xoo86XjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/rj4ybt; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTWeq3vDrJmHHkfTfmrw84HesOcxqZZik5uZBEuwmfSw2F0+yAJQSxkHzQ0nwD6CsRKwKZld2uCTGwE6gDsrtBbUBpVaIrv4MUyvVRBsm66Mo8UBbcu13gQ/vTWIYz0V4EzzjvPmdH4GH/hT43NzSUdk3uFvKkXjbz0Hi29mEM3qA3mKBm9ipt2q5vIT7YghlFJ7baciGYW+TfQPziQONqroFNAJzhfcH9IKpTskwN1ARlkuMokQ2LYK7g69KX1fuJXyMz0nJTRJ9IxsNXmmWRo9lqyoNXStpq5CwTND9JQ/7RAXhRNQYM0oo5L37nRpHG4EsZsvvnPyYBkAaKDI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fJ0XSZal7lAbaBh9Q+ywcFSEIXRzwv1mcRH7OVYsrY=;
 b=FsPUi1fYGEIh+ctt2l2NnmiZIdi442safEt65sYtJdkpVwpJClvyzYC4F4nEzHZ3Jcnp0kNE9H+sMsH8AxdPJX6r7gbZJSEkrTupXywn4+DncN/4cibnJzWo+kYVbZ68D2uE4fPI25i21qqqH/HL65HAeBN70iDN1OnRk23x/z4pfKXeOj0P7nTq1ZGL8sn8bqI1CrYJMviLru66HfZ/mEfUb4GNEoUposLqS+ivrbmTk2E+DYKGv3ai4WneUQYMLVXpLjxiFtUaDXO06Y+JLLlMlvGlt/OQSvm2i744B0OTEMLcc6iuRYuJujPa12veb8Sxb3TQJM1jCzSy7JTrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fJ0XSZal7lAbaBh9Q+ywcFSEIXRzwv1mcRH7OVYsrY=;
 b=O/rj4ybt23Was54rSpu8Uc7xMf7uXMo48AfSQ1HzCYGuBVH7cOXbWuusxKsGuK4A5hrmhMSLGuMsoE6PFJuG8itZTv2gbSZUL85JVk8iNKIo5UriO9KtjEijrMqnH+LdVTzyYCdipP8g3XbEIdipRkNkQqMFOsVrUsZx/fXs1/VDkzeor0se1cHDCa7dpiCUjzW/v+V/9m+we6yPkujmCnR99SZRksn+YDJf1EXe3rHsLoa/heI3gYgEvx+bWDgDovLJLe3sJj1MxVZqPO0mDxX53Hmy+ktBdnydFAcZPXdV/35M2bgaMF3BZXwC7HLXm6aCYJeF/UjOiH95senUhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:18:16 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 13:18:15 +0000
Date: Wed, 22 Oct 2025 13:17:43 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>, 
	Willem de Bruijn <willemb@google.com>, Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
Message-ID: <avwfxfpogp7u7ef5wqrfkqsgvzmnytxblwul7e53eaje3zyqyc@7wvlrocyre6j>
References: <cover.1760364551.git.asml.silence@gmail.com>
 <20251013105446.3efcb1b3@kernel.org>
 <CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com>
 <20251014184119.3ba2dd70@kernel.org>
 <CAHS8izOnzxbSuW5=aiTAUja7D2ARgtR13qYWr-bXNYSCvm5Bbg@mail.gmail.com>
 <20251016184031.66c92962@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016184031.66c92962@kernel.org>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 099e4189-9829-4ccc-6498-08de116d7563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lom7AjxFaKA7R5ViVvJ9DpaxcICRf4cd2HY/9JiFw97USYNpJFgvD1SvMeBw?=
 =?us-ascii?Q?NKHOzl5Ftlm9be0Qvi4tEGxcRIE/lBU6k44GvPfQzN/s8a4RPfCERH5K2C07?=
 =?us-ascii?Q?KckQoz/5wWNyQ/YC9JplYeU1YPmFBod9mi9g3iDVjHRRDyvdHeYJ4huECovz?=
 =?us-ascii?Q?0w4qG43IgVZxUXyp5x8CvYlNIIjNBMsPvwiA+9xGnPKGtzj+EuwBUjv/YkAO?=
 =?us-ascii?Q?v57/DdFJB3g1t15djBQIc3/FAqVeMNIhAqsIlWUXCTRoo9ZIcz8lpdIBtV2a?=
 =?us-ascii?Q?DJt+dkdV84hweThA/CprmERKElrtV/6IpvLLSixdEKEHH0JtpytcqgpCDrUd?=
 =?us-ascii?Q?5VOln0XfaMLMb22kdt8xat0xVQf+RE/ZsNbhGUZSOg23L3KjDaLUmhgnTgNT?=
 =?us-ascii?Q?WNWhjLD+T7Bmu862pfalvMjdMl5tiqfLbWt23O6f1uhjFqNjQc5wOytgnFcj?=
 =?us-ascii?Q?JloEkr6pJvxs1ngE+PcU7BA1K33gw5b+w+0AtPKE8KdZEUdF85r7SWwbU9Nw?=
 =?us-ascii?Q?0VIWLJqUHehr6EYvsn/aKtlsHS/J80XcHPid9j9EdWPe6Jb6XXMyvK4RYLWU?=
 =?us-ascii?Q?PBSAcknlS0dAyZAycQBUKvXYcuFA06I0rPnQQq8L4CuUyOLgdCkwrXXBu1OU?=
 =?us-ascii?Q?H1TE1Jcz9sn2egxGn8fEaPJI22E9OxQLDJIIwO/7foFwkXcZvIoAKSZItMwS?=
 =?us-ascii?Q?1nG7xyEv02CeUDJ6JpM18L7vdpKsnrG+KdNSEWS7VSulP1/i1sKOGM+uEn6b?=
 =?us-ascii?Q?keslnCXFqKEvpBlJlVy8a/+Zt72NUfZnY6W1ORLTJKpOTWoQchU1lD08g4v3?=
 =?us-ascii?Q?RQjM5xM4bmbzcfE0w7cRxi8U9E1HYG77F8ARt0TJKkuQRMoT2aR8QJekY5CQ?=
 =?us-ascii?Q?X2AYmTitKFBM5mkMluhC8DaQo/E9LOc8nxFTwp0C13vvQrfhtoAlpcfpz6Ws?=
 =?us-ascii?Q?yjomAN6LIUt8iZGJw9aVvnRf8z//AtiMlxtO9DrQkctq1VfKjh+TZ6U5OQUV?=
 =?us-ascii?Q?a7KuAOWU8B7/uaYw83YQGSc2IzLEYNh8eIwgiR6WSvMTB2mMTMJyc7svqW3Z?=
 =?us-ascii?Q?yHwEF9IH3LfcLCK7Z63uRoMhYdrQKYOmS8U3bhTUzogvHRt/cXtYhROz1xYR?=
 =?us-ascii?Q?87LNKo8jwmwPdhnhKzs4iCpB9XfY9LxkQkFDpVcfy8EsCdGQLRf4vaWPO4GW?=
 =?us-ascii?Q?5SJliyJe7Flx9cIpI/UEh/TUjHoOJH20igD4Ab1CxWJBa0IK42EkacYuK2v+?=
 =?us-ascii?Q?W3J2fl8eI4TjYO6KTEkdWWj1gYG585JIUqt6Ul5rvlY6AWlGn7gu170g/q9C?=
 =?us-ascii?Q?VKK77fm1V3OmLNSiunWcGWV6wuQF+Z9xljVYE7XAfdqCcMaP+plLUZuQ79R1?=
 =?us-ascii?Q?iKUvDZS/sK7Xgq4+mrNLfC3R6fn+fHIKlmOnf+Gi+CueAEIPn1+qq+0hLPCW?=
 =?us-ascii?Q?+xK5zBk0dmAA3Yt510TOLCRZemsLOLkN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wJ7rKwJiEc6UYk1/qiL8ukgDfFv1Cclu36IsiL93fwECTg4r7W7W6d7Nq5Yo?=
 =?us-ascii?Q?KhLLCgrNZbIucYi53ljROGXmFjezWVtyKgLwiOs/EiY7ZU0akZErMMb/+9lE?=
 =?us-ascii?Q?TgUnuVcCAq3d0uo/eeIP2x7RRbCQofJS5lk5tYDTumVU/37CX0AL34yXk+2i?=
 =?us-ascii?Q?io2tcPBdfRN9z6KA+mfiQauh0A3PiJ8vOrWkoV7xog0D6k1kn+1guuTV//bo?=
 =?us-ascii?Q?cnMZ6fLHicDhwnWobCa4uYP/HIcmIpgSIjkK7oqqVFJAwthp/8vcajQBY6/2?=
 =?us-ascii?Q?ZLASRh27zAs3amvablbDTHI3WG9d3t5MDPnxc/69jtKqgHb5jHnBY4f6nQuw?=
 =?us-ascii?Q?NcpxWdV9hxa1s6uoaF4tbd+FsGq1z6DzRaK3nwBfaPxaxkT3Tgwk3NbWPYAb?=
 =?us-ascii?Q?OkBmZfgtRTzpeAtwWJVGtlqycP+W3vRt9jGmDxl/AF483N2yNvU98PbvYCnh?=
 =?us-ascii?Q?GgQa490qWa5kIhwJEkG/cU4JCuRw5dUycj51NtYyNa7rqz5yrBpXWtFTQhE3?=
 =?us-ascii?Q?60ixw0JkPs3g05Ss/GLlnF9VWTDRX4zZ3fdThFDmC8xAyJXvjVQknOumD8rI?=
 =?us-ascii?Q?RrehvHWx2fKh4xZM1LPRrKaujdYYuaA+yuPRdzMk9/sDly20hmSF48yKJbnf?=
 =?us-ascii?Q?Hi3TOQEj36OucqRp92T3KmUdxyMpc7VjNZLSofIBxJx2uRmagPtxsAldbFas?=
 =?us-ascii?Q?firmM+kHzLwN4YvYjX+qdxezF1wVIBA+K9G6eV46KMGXFamG7XPFhqD5JjBg?=
 =?us-ascii?Q?uSclweZAvEOzrULT3rEKLCM+4eoRim5jN8AuAkmg2CjUTMqU0aioQXA5LHfF?=
 =?us-ascii?Q?Iu9wlb1U9ztzpDx7c6NKz87pVqsQx/BpDgOm0JpSFOzu5yS6n+KXHuro/co9?=
 =?us-ascii?Q?279iDVsQ64b4+l1cYZgrXEek9jIOou3auvOx5AWXRolGWBB7Z6kv2QGkLHFE?=
 =?us-ascii?Q?yp0NmebmOVPSd2QT3KTC+BdvU4Ecqw9fzIk51XXSCagDrv4bqgx+SlpWf/NP?=
 =?us-ascii?Q?5fm7ZrPetjEBOZ1kLAJKdQm24Tz7RiHy9nY2xEAasIyylOMinze+YqMvgx+N?=
 =?us-ascii?Q?qk5HkHtC3bZEMOMMMivtHtZj39f1MW72SxzMthWQvU3BwUOHfikeUOyOWdOU?=
 =?us-ascii?Q?R3PWWbu95+P/8vcqxU0MvO4QzXzqA1TJiL60KjL6icmy8gNQP5/Mn+CIkrXe?=
 =?us-ascii?Q?vO90CK0Jllv8ivbutjGDzilT3H2GY2Wa8f3tdk8ONqsp/YT8e3fhSPWjVAt+?=
 =?us-ascii?Q?h5qJzJzQ3XqFdi/FdVdGzBY+iDE9gLLqpJF0jQiE9nMOcnq3p0VoEDyD1j5N?=
 =?us-ascii?Q?1z8PQdSyshlsZBIFRRLfz5FCXNaB0ZxauBZDfc3WN3eQQSfUC5lRSjX/ctRR?=
 =?us-ascii?Q?9rc4rhPEOGzHhURQ9chVsHxOAF+BzWMg6qhjtCPHWwqy+twuqmAsVd0pkGy+?=
 =?us-ascii?Q?sIP4BkeP2b7VHpBa5sX9WBbGfuz0xAIgpgnZ+PAOggvz1IZfWR4I+h6q92oG?=
 =?us-ascii?Q?IOiPPRpWs9NPBxWTbIve4uEvddvcxg7slimXfvLTSVE8jLL21tIf6BFnQOeM?=
 =?us-ascii?Q?4SKbuhBlpZS1/Vp51Z2oKXJUXmt+7U/G0gFqFcJb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099e4189-9829-4ccc-6498-08de116d7563
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:18:15.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftPE2Wkf8BvGdxeTS3NvnfcqVP5/gnS3M+OYWocWcpOfgRIIebAZnYLIrghtSAlx54RPVl9SICT3EuWXW9YwzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691

Sorry for the late reply, I didn't see the discussion here.

On Thu, Oct 16, 2025 at 06:40:31PM -0700, Jakub Kicinski wrote:
> On Wed, 15 Oct 2025 10:44:19 -0700 Mina Almasry wrote:
> > I think what you're saying is what I was trying to say, but you said
> > it more eloquently and genetically correct. I'm not familiar with the
> > GRO packing you're referring to so. I just assumed the 'buffer sizes
> > actually posted to the NIC' are the 'buffer sizes we end up seeing in
> > the skb frags'.
> 
> I don't think that code path exists today, buffers posted are frags
> in the skb. But that's easily fixable.
> 
> > I guess what I'm trying to say in a different way, is: there are lots
> > of buffer sizes in the rx path, AFAICT, at least:
> > 
> > 1. The size of the allocated netmems from the pp.
> > 2. The size of the buffers posted to the NIC (which will be different
> > from #1 if the page_pool_fragment_netmem or some other trick like
> > hns3).
> > 3. The size of the frags that end up in the skb (which will be
> > different from #2 for GRO/other things I don't fully understand).
> > 
> > ...and I'm not sure what rx-buf-len should actually configure. My
> > thinking is that it probably should configure #3, since that is what
> > the user cares about, I agree with that.
> > 
> > IIRC when I last looked at this a few weeks ago, I think as written
> > this patch series makes rx-buf-len actually configure #1.
> 
> #1 or #2. #1 for otx2. For the RFC bnxt implementation they were
> equivalent. But hns3's reading would be that it's #2.
> 
> From user PoV neither #1 nor #2 is particularly meaningful.
> Assuming driver can fragment - #1 only configures memory accounting
> blocks. #2 configures buffers passed to the HW, but some HW can pack
> payloads into a single buf to save memory. Which means that if previous
> frame was small and ate some of a page, subsequent large frame of
> size M may not fit into a single buf of size X, even if M < X.
> 
> So I think the full set of parameters we should define would be
> what you defined as #1 and #2. And on top of that we need some kind of
> min alignment enforcement. David Wei mentioned that one of his main use
> cases is ZC of a buffer which is then sent to storage, which has strict
> alignment requirements. And some NICs will internally fragment the
> page.. Maybe let's define the expected device behavior..
> 
> Device models
> =============
> Assume we receive 2 5kB packets, "x" means bytes from first packet,
> "y" means bytes from the second packet.
> 
> A. Basic-scatter
> ----------------
> Packet uses one or more buffers, so 1:n mapping between packets and
> buffers.
>                        unused space
>                       v
>  1kB      [xx] [xx] [x ] [yy] [yy] [y ]
> 16kB      [xxxxx            ] [yyyyy             ]
> 
> B. Multi-packet
> ---------------
> The configurations above are still possible, but we can configure 
> the device to place multiple packets in a large page:
>  
>                  unused space
>                 v
> 16kB, 2kB [xxxxx |yyyyy |...] [..................]
>       ^
>       alignment / stride
> 
> We can probably assume that this model always comes with alignment
> cause DMA'ing frames at odd offsets is a bad idea. And also note
> that packets smaller that alignment can get scattered to multiple
> bufs.
> 
> C. Multi-packet HW-GRO
> ----------------------
> For completeness, I guess. We need a third packet here. Assume x-packet
> and z-packet are from the same flow and GRO session, y-packet is not.
> (Good?) HW-GRO gives us out of order placement and hopefully in this
> case we do want to pack:
> 
> 16kB, 2kB [xxxxxzzzzz |.......] [xxxxx.............]
>                      ^
>       alignment / stride
> 
                                   ^^^^^
                                   is this y?

Not sure I understand this last representation: if x and z are 5kB
packets each and the stride size is 2kB, they should occupy 5 strides:

16kB, 2kB [xx|xx|xz|zz|zz|.......] [yy|yy|y |............]

I think I understand the point, just making sure that I got it straight.
Did I?

> 
> End of sidebar. I think / hope these are all practical buffer layouts
> we need to care about.
> 
> 
> What does user care about? Presumably three things:
>  a) efficiency of memory use (larger pages == more chance of low fill)
>  b) max size of a buffer (larger buffer = fewer iovecs to pass around)
>  c) alignment
> I don't think we can make these map 1:1 to any of the knobs we discussed
> at the start. (b) is really neither #1 (if driver fragments) nor #2 (if
> SW GRO can glue back together).
> 
> We could simply let the user control #1 - basically user control
> overrides the places where driver would previously use PAGE_SIZE.
> I think this is what Stan suggested long ago as well.
>
> But I wonder if user still needs to know #2 (rx-buf-len) because
> practically speaking, setting page size >4x the size of rx-buf-len
> is likely a lot more fragmentation for little extra aggregation.. ?
So how would rx-buf-len be configured then? Who gets to decide if not the
user: the driver or the kernel?

I don't understand what you mean by "setting page size >4x the size of
rx-buf-len". I thought it was the other way around: rx-buf-len is an
order of page size. Or am I stuck in the mindset of the old proposal?

> Tho, admittedly I think user only needs to know max-rx-buf-len
> not necessarily set it.
> 
> The last knob is alignment / reuse. For allowing multiple packets in
> one buffer we probably need to distinguish these cases to cater to
> sufficiently clever adapters:
>  - previous and next packets are from the same flow and
>    - within one GRO session
>    - previous had PSH set (or closed the GRO for another reason,
>      this is to allow realigning the buffer on GRO session close)
>   or
>    - the device doesn't know further distinctions / HW-GRO
>  - previous and next are from different flows
> And the actions (for each case separately) are one of:
>  - no reuse allowed (release buffer = -1?)
>  - reuse but must align (align to = N)
>  - reuse don't align (pack = 0)
> 
I am assuming that different HW will support a subset of these
actions and/or they will apply differently in each case (hence the 4
knobs?).

For example, in mlx5 the actions would work only for the second case
(at the end of a GRO session).

> So to restate do we need:
>  - "page order" control
>  - max-rx-buf-len
>  - 4 alignment knobs?
>
We do need at least 1 alignment knob.

> Corner cases
> ============
> I. Non-power of 2 buffer sizes
> ------------------------------
> Looks like multiple devices are limited by width of length fields,
> making max buffer size something like 32kB - 1 or 64kB - 1.
> Should we allow applications to configure the buffer to 
> 
>     power of 2 - alignment 
> 
> ? It will probably annoy the page pool code a bit. I guess for now
> we should just make sure that uAPI doesn't bake in the idea that
> buffers are always power of 2.
What if the hardware uses a log scheme to represent the buffer
length? Then it would still need to align down to the next power of 2?

> 
> II. Fractional page sizes
> -------------------------
> If the HW has max-rx-buf-len of 16k or 32k, and PAGE_SIZE is 64k
> should we support hunking devmem/iouring into less than a PAGE_SIZE?

Thanks,
Dragos

