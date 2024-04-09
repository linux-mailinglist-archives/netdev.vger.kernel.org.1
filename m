Return-Path: <netdev+bounces-85988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58489D33F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0533FB23A8F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8B762F8;
	Tue,  9 Apr 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="CiCY5JE9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2092.outbound.protection.outlook.com [40.107.212.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCE7BB11
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648060; cv=fail; b=p+W9FweCJYWI8bQqcvhCFg+RSypjvPws/f+We7+v6KVEN0o8HVjhF+CE3nd+jp4X2HlzKcUIIWwSoh0fkHIarzoxNH5wB5Bc3Z/SZCJRubJJC1lmexrhtDN2Ggds3meg7nQb9Fh8eBiweJ59T8dFu6H9hr4UfDzxq8AfqziKUWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648060; c=relaxed/simple;
	bh=ijfsxa1VDarcmd/HzK1VeusKXFaGPG8UXkCURcV+EiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qymYawg0c3dtjVWRjX+3FWU6zTMg7iTNe6rEDxdCHDrDXA1nnAAYeOsDMJ8X4O9LGEVcwa/C4NZqwnpuJtTN1p/GXXg1yaJPouKICg3UOaeA8Ksl9Fc+lTvI7FWAYHQqF8L8nq/3/Smj/HImrcrXhAxlSKfbDYydtA8VOmVPC3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=CiCY5JE9; arc=fail smtp.client-ip=40.107.212.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2mcPOxKeZPArHsjR+GJMwZ7SHk303mOHvhNdxlD4PyTVB8eTBurEJl9DYCtTpM/N36oNREC5aQjsuo39GLjBsTd96lec8RCV2jRSd/+bd4CeDX/RKvSK9jpQ44ZGeSTF2eJAzLa7RKydiho+FdJh5q0EZrfMxe7pF9vF+jTWh7STNpsZy2Jukz6pIWltvXQbAvbUx2SXsdlVLaDfFLGeoe6H9mTvWbXhdoxGhx1zELJ2ezQEVf7Rr3tAVxyYxX1KPHR6ueS5UWBnxP0q9QEkUmSrOSU2FighCBqr922lAmXt1lLbAomnhiPr85MmT1pzpsnqZ41HMIGh0ggGmfoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOKvGCm2WLrT2soqHRj8YzodB+2z485WZWnMEdXflMQ=;
 b=HMjhAtaPrzQ6SheFSP7R04MQDSEAk/oQ7HsdUoSgVXtt5QFXwWFpJuU95ZPws29vqldua1JV401byRsHtxXnS40vrlq6irx8Ry4OskGBoGVdGjfo6TNIoxaIUdHn68wI2Qob51jt6DUy+UrqxwZJaIfHAEwdbYT0sBpfBjILiIShgJ5D1xeQZfTymnsnG4Tsjpj9LaOnWt01VS05ZUMQ3zPehtM+qdboeMyWn6WNrIU6LSVZCdDmtQ0msC+5zSj7awe/hQANtJ1v9NTHIoUqxTMarcivjBnB6gMaAqFNp8E0lnFFYRIlQkhTXfSPp/gIyAHoxFSaap6YQ+WmW5YadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOKvGCm2WLrT2soqHRj8YzodB+2z485WZWnMEdXflMQ=;
 b=CiCY5JE9hKBtYo611DCHZvkcipkmSSorRuw4g6vwpc+U77yQ0uX76YIz1HvC1v+vxfdNOsyIu/tcVRQr77+Na2s9zqPE/MpCqFiBm+eM8HdHvYR5lV5/Ef5E1iAh19+loUCSqVEzh6gFfk87ayksvV6oIICdxTuoqL8U+gZkfvM=
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MW3PR13MB3930.namprd13.prod.outlook.com (2603:10b6:303:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 07:34:16 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 07:34:16 +0000
Date: Tue, 9 Apr 2024 09:33:10 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v4 3/4] dim: introduce a specific dim profile
 for better latency
Message-ID: <ZhTvNpGDNUMCJ4Az@LouisNoVo>
References: <20240405081547.20676-1-louis.peens@corigine.com>
 <20240405081547.20676-4-louis.peens@corigine.com>
 <20240408195535.0c3a6f1d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408195535.0c3a6f1d@kernel.org>
X-ClientProxiedBy: JN2P275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::32)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|MW3PR13MB3930:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	37FiYcIEfUOyOeLQSkLCvxLrlHpn3pug4SA0cIDlZ7NxsYQFIRhIalFSC7DpxPL1sCT+O157go/vgnqZVNTqkNARxqprLL8/jSaKliiaqS8Qt7ilMqNjUS5ebJRuYk7fCLK284UEW2MpAfztGp6IbxUhvhZ7XSj52M7YP3AlRImU+zxjNaeWtE0abNrRmPJFtlKZTr3GKrer5U+QswlgY0euz03+nYFZNw8hik/hX3AkVj4/Fi1FDp9K/foX+38B9fActl5FJRI+gAL9XmLaRmfqGI6YA8fxDofUb54+kzAfX+fZdynubuI9IMnioD2oRXxq92i8RwlY9WtAL9n6lB4tm3GPDhKBSRV62EhX/gFa7FlQFjGXXkUZFnHDKUzS6DF8OwcnmqIV8vXdxdeh1dirWGf/WDvydovXOBm4PUA00cBS82ZY1vX7SEOIDUizkYhqc2Su3U/GEmEG0bB69M+intjQEhMh+nLPZvJbLZ/MsLKGifYEPU7IW0FZN5e0aop2fbtq0zPGaWLhViQMShA8N5zGHXKbWA4qgI5yNyaLsR3I8AaiTFLn0PrCh00T1w3Ayvf//55OdCwDDjS8lMzZvwRlZBTaFpGEqYbJDrqB3lbcNuX0zH6m9Dy1OXsVOIER6nnsDXx97MtDSItUoYIGBIqhb3QdIwm2oyl30rA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vKLEsHtHYNvRpu091I8+zMbm5rxswmTwkSMASt2FkZ7iJ7JUAQw0VtpP0j5u?=
 =?us-ascii?Q?G1osEtZFWTSl8wcl56gBJB7A/gXV0wBIpNr6Khkj9RMCfGusCoze87cXgZok?=
 =?us-ascii?Q?W1cnh17KGQfAQ3Hb6FQdOx68ibYg1Cq1jGDn3yXPYtBTzM674YAvuvu5e4pu?=
 =?us-ascii?Q?foALu4P2d8mCXm7qYbDCr8i01B4p+KbLfvcR4ckcqrNx9AA2NlI3ziv7If+x?=
 =?us-ascii?Q?L2lXoohKz6xPheve32UzNPcCmZ0R2TmTJtO3P27GR6By6dHL5Eznzgu++vEh?=
 =?us-ascii?Q?ZDKg2bAxa95unQfKkAUYq9VbwGY6qO7MwffHoZDo5tFzXI6zQ42Zn4Foqs85?=
 =?us-ascii?Q?YYkOEYASA9nMzdALw5UadEC/4Crt02jBrHtBdDgxkv0jZyVppLMtfBw4Zspl?=
 =?us-ascii?Q?pabGT2lVxFDzTqegfTEYhhml0z5Gbe2K9q7uBJlYwqIgHouwUoRq5Q5TmjAz?=
 =?us-ascii?Q?emi2Rq5+QU4HCKbfRy5Eq+rtt8Lk6hqixjqKUYiOgCaKJXSQQ69LASgb4L2U?=
 =?us-ascii?Q?bkAEUpMTUI2mjomdby0OyRqu4ggSvz9bwklDgXznT8BbL+qvls64AqaDyOT0?=
 =?us-ascii?Q?55uT7OgnRNlNCIHAVDhj1dGEoEuwVv0htKA+lHusrbWAVUQNM8eD+H7XfAEh?=
 =?us-ascii?Q?tQgmuORxO1IM+oQcfUDRiDmt9710tz8QVLPZpZ4Lx3p5ph7jA2MWcX1PecAA?=
 =?us-ascii?Q?Tpekzwn/32cOJXdACO9Z7S/ZnvPw+sreD6h0oDYfZu6K+C3Jzji8Hm/Savvv?=
 =?us-ascii?Q?OHnBvL5+akkcbQQTbNYgUUmhA8X3Tbv09Uqr7ys5DH1PmZVlUINKl2UL0jRx?=
 =?us-ascii?Q?QwcTJmKmFSv4aqAuNFzLrX2AZZ/4IK2TSUeTztAdNGQ4ICysB5QmnQxb80qF?=
 =?us-ascii?Q?129OEfZBKGbmZErpN5df5bUCOOIsmHReGvDOgtbmOKGaeq8PVvN/9NGuvNTC?=
 =?us-ascii?Q?aESCFxkaR1Qmvzty2HrS3PQcYiLMSt03or/4GuNeqiTkH4QJGk+YoZIpeq8n?=
 =?us-ascii?Q?+ry+ihx03Coksiyvj1vRcsqvEHajqC/05x6L8GKgu0U0q6DPhOhSu0CWNOhn?=
 =?us-ascii?Q?0CFKBom5rkzbbyoEsTSKQA3OJhgDBWGIMx3ibbvjP1Vaoe6NNgT5vdgv9DWz?=
 =?us-ascii?Q?ZqGKQC/60pZGaUhRHzEBdNr9P0U4Epreyg9LxLAmXmT5AcF7/2ohh2789TwL?=
 =?us-ascii?Q?/QZje8CV7aSWhH1cQZkZFXPgKE5Vs8yzotuIY+ZIIduxVcxV3Hz1Rzz/1CEX?=
 =?us-ascii?Q?LRyOuTsek99sjo4BodBQsotN2m4/YaY1aULmtsrmwxQA2Ozw/nWI6I8YHwxi?=
 =?us-ascii?Q?rHJ7Efb7P0VZe0wrCf/I+DsaXXV6fPf9n6yju5TYmrMjriWmRdqUZ6VKq+yl?=
 =?us-ascii?Q?jKw6PY0DSnF6Ae4P3MQo9tgzjz3qsZDKXEg1w/Di4xlYUFiW/DSsxtPxDOud?=
 =?us-ascii?Q?SGL/1xbtgbIeOwgKbspVmhcZ7pdI0EvlRvMFA0lkm6+kDWJE6iWI+I5kqwVq?=
 =?us-ascii?Q?kU9zbmxm3BPFEVN1MIosRnPSq/D0TvO72N0GSBPy7jPVWf9937qqjODrQYQe?=
 =?us-ascii?Q?g5hgAXRT5RQde1z8d5GUsp9Hx5w3vd7hfYVchih96FTSK0inkKJ9jSBsLamp?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a872cb-d974-49ff-e627-08dc586775f4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 07:34:16.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyUMw5vrpu52l+hD+hh6tzKmAIFrPdPVQ+nvdOqRLd+ahBL/EtP2CkZ3CosX/k3WfbzwQVVtX2nsS18SugdtOt8YeaMxsF6JloMIKwMwYao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3930

On Mon, Apr 08, 2024 at 07:55:35PM -0700, Jakub Kicinski wrote:
> On Fri,  5 Apr 2024 10:15:46 +0200 Louis Peens wrote:
> > From: Fei Qin <fei.qin@corigine.com>
> > 
> > The current profile is not well-adaptive to NFP NICs in
> > terms of latency, so introduce a specific profile for better
> > latency.
> 
> Let's drop the dim patches for now, please.
> Adding random profiles to shared code doesn't look great and Heng Qi 
> is re-working DIM to make it more configurable:
> https://lore.kernel.org/all/1712547870-112976-2-git-send-email-hengqi@linux.alibaba.com/
I nice, this looks like the kind of thing that was missing, will take a
closer look. And also drop the dim patches. Thanks.

