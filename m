Return-Path: <netdev+bounces-64759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D11E837231
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3884B22EE5
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CCC3A8F9;
	Mon, 22 Jan 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="adz3Xybl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237533FB26
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946958; cv=fail; b=md3iaTLQKX1B8Uw2OBEguPDX+YOhzbqEcysV+dMuuD0kqZBfjSJhEi8qhQO6Htx1k8/lZUs+eQkSJfV0g+3P7zIXI4Yvf6AU+fzmZiriy63eU0+PEhIUKyuhzJGH1c8+ar/rKX0HMPms/frVs2pBjiSuvrpqJJDdYTpZp76yaXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946958; c=relaxed/simple;
	bh=8AZY3YlgiA9kH2v5rBiG4w8vICpqvwJwhbxgp+C2jBk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=hp+zfI8vl1z6lvLjmE5/SmyG6vaa7G6loJgdBRdUaR5NMi+aPNXFObOYxh3COKP5i0y6e9cYG1KFPGvq4XSJksQMIdKsNCDk+kQEdMkaAHbCQ1Q6qW6P7MV9VIelkhNZ3kySvgvAGQWNEPHz+gQi6sE9z1oWdSYkXpFjBSA7mIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=adz3Xybl; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBsE2RQnEYjS5WFdIkPlkhvJWhTfT0DUMLwjpb7adFsyadexxWaFHRvPtBgyteGNigosqYJ+aZ/GdiHf31+Etd/UUsESSiDg9nkm2zf/PZQtbEBLOgRrxOqNdhf034jQf7pcLs9tK9nCJrmzU1KjZw8LrlpCqHzS/TuBU3uF51GRhnaCNbP2/vCaPZ+/B616xwUp2GQj5Rck3GIzIguEyf70pM9e84Kv2M9WnPHhY6hqrb9SWKQb7UdzmFOZlBhV9953a8H2dsuA960WV02z+hSyZG+QPsZ1z8piFhE9oXVg1d6ZemJOSlvfKcPzHY1054zEbx4x9uprpAz8EG9m2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AZY3YlgiA9kH2v5rBiG4w8vICpqvwJwhbxgp+C2jBk=;
 b=RemdiYgu06HFsn869Ny8on8UZXiHXEDUbGS7sNhb0wCa+ts0MUDEccl/+42vcznm+mGDpCcibH9FngjmIFhvQ8kkmOBQoOVQDFcZMoK41eQZK4KFqkLzcGWrSPrcwMqmROih4n1Cg2Zd1v90Z4rXn1wQ79mPrJixXGRU2/Q8Vf8akuwXuREcbHTqUGrzQlnwBzzIM9sTSw/Pw8egn7A4SD4mmJ5uMIP00m7pCD+twzmt63L+TVzcHK7j993fuVCP8YPBJJj2eld+08cUWPD++DQTTAvWEsrY8fEelfYP3MM175OOXvGeaLWHJFjRh7OLsOVTnqXIBExU7uzcPdMk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AZY3YlgiA9kH2v5rBiG4w8vICpqvwJwhbxgp+C2jBk=;
 b=adz3XyblKELtBYAHjTVt7+dl2ky3Jq3CAC1ivOjW1gYTd3171TeiVxHdgDwkL0SOWbS76WiBw6fSKaZu6hz2H3seN+ClgYNIX9Yia+NH2TTvZ+85H2NsvXu2hwpybEeVyqoyA/mt3ubp1dHJBVRlssNM6kP/MQ54Kfk68ehJxLBeZnq+fueYyqH8WvQ7MT+CXPwv0dH6X6dmeN5erQoDwzjuSeuTuMvj990KztZuYoYORmFUYfTOz3E+lcUpgx9hsoB67iBXUlYIzBeZB1WSSJrrmLCy+mNLvbOiKkQnZ9I/oYpBvlJ0WHsuaPtzYTiFRemJ2ZwEHG7IOssmwdp5Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 18:09:14 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 18:09:14 +0000
References: <20240118191811.50271-1-rrameshbabu@nvidia.com>
 <20240118191811.50271-2-rrameshbabu@nvidia.com> <Zazj5KI7BZPnLoc2@hog>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, "David
 S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v2 2/2] net: macsec: Only require headroom/tailroom
 from offload implementer if .mdo_insert_tx_tag is implemented
Date: Mon, 22 Jan 2024 10:06:58 -0800
In-reply-to: <Zazj5KI7BZPnLoc2@hog>
Message-ID: <87le8hgrzq.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fab78ff-4206-41cb-d528-08dc1b753dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7j1rQ90uR9SEJhkMQbuRIKj50R3RdyKbEbj4MbjT1LvyafvArLUv9N05JmtRmP8pZmoWGHoKnaIhTMC5gKWMFrs7GXHU9IrFwZsYAVBHA4VNnQTZUf6+2rZMbN7ByWthGP3fXik7jnsz3PXOKd5Naelp1n6hPeJKw/0L+W5VJb4qpL5HAyCiQpEIXA8ivYt8FMOHWbVHUZYsaztEIyiOLzW6x/sffeC7q2N4GirQBVnIiDefd8RyLBecb9dU5y6KSPotDchW3o9JmMrQpF+KzGF41SGQXE06zmp8lWqsJWepZbjpBlyShXLTkIorM5sS4lbtsKmGe0503xT/6nD9wY0euoIr0HQTIrcZzqh+RXvc6FEKo70Hn3qMIuKA/wdY8X3E6BQgQIisDHqFi2YjjT101d8aM8YKYT/NgdEL1VeiPTHif+3nuc15sCFh7WzQLoIAeI3ZFv3Z1tShfyoXVQpdvxzANvv4TOaVTIL7eNNZxhem6Tt554gf6qVr22h55Zyv764MxXbN0wX8xLbIQVagm+AfdJjv4Zutl/3RTnP0hUYXfjC35yeoI9f22Cby2zHmmxbeqp9vOHaT1HLt+mQ9KNjClMaifnFy04nlX05eu9yJJyogdWzyiF+RU5RBjBzuby3TQDgymJ2n+ZOBew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(36756003)(86362001)(26005)(2616005)(66946007)(8676002)(6486002)(66556008)(478600001)(966005)(8936002)(6666004)(316002)(6506007)(6512007)(66476007)(54906003)(6916009)(83380400001)(2906002)(4326008)(41300700001)(5660300002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wgvcoJ7+ykXeK6fBbD1J/TX8/Y7Q0DId1L7mMJnnyE2zHBYkRB/CpjZ2LP3g?=
 =?us-ascii?Q?E0g7BsFAsPL8l6LpuRPADcT2Ud0vUyhdGqySt6ttO8ISChrPevjNa1WG5fSc?=
 =?us-ascii?Q?AWvd/DaBerOtDAeL/NX/imMslGp5wSOmhNisTxCK+kZAdaNxFn7T0HVP54N8?=
 =?us-ascii?Q?PtJA6zEL8RBFdtCV3eaB279CJDE6aRu3xWZM+2Kqq4KLCV92XyDtaYzC2YHc?=
 =?us-ascii?Q?wzPYgD5hzgbozXdcsK0gaUZVDRM80rDmKXba5pTozXSM00soY/flM6CKSa+t?=
 =?us-ascii?Q?jRHNh+G2J+qmcNb0So4tAG6m8AfDKtGgjkdbFAhBPainHhXRoFM2/zZFV5Fu?=
 =?us-ascii?Q?9zD9yvPepQyi5xc0iXUcU3zpe2QmzrSPG17k4Xo3HbjrryT4D6kOTDj3RpTN?=
 =?us-ascii?Q?XxnV85h7h7Z+39P4Vzesirs4gghRtYyrQNI5cFFMyMseTpUYW0gjEr88lFVb?=
 =?us-ascii?Q?ImSTpZlnePSm94K1c2ePd4dfAIpJYDlPgDEQQTLY4NbcamOMTeH1TN9jdsmu?=
 =?us-ascii?Q?3RBcTUtU9yQHPl7cz3MNRCvSVwuMZ295pKBuVaOjK6Lgzj8fxHGCRNlRLQG8?=
 =?us-ascii?Q?7Q7QaD4yVmNe6Xd5RhKRk0Bob+8/WjG6vk8QCLCZO8WWLr6K9O2U3u0VlZ8M?=
 =?us-ascii?Q?Z/DfYGGi1juY4x/f7+2vc15TAn/4FdW6ly5C07aX9ztL9rG2qJvaA/YXsfk6?=
 =?us-ascii?Q?ov+tLnBxJP0unnEIZLG9acR5n37+IapG/OSeM02x79Pk7UycrZQ29unk4HFv?=
 =?us-ascii?Q?iLeJYmN1N+tWIjcuo+YZEh1SARXs23SyHQhAJGO0jBAMYrlkdSv6xu5kLLza?=
 =?us-ascii?Q?h0RqZhEB9xgbIrwJ0sFQyne23c7z6Sl0Yk9uibHfNCm64kuVboUq8o4iAlo+?=
 =?us-ascii?Q?gwrDTvRMkW6Btxjebaak8uSk5Zwj1BKkUg0vpauCFyGzbrHlgFY+3xEmxN2L?=
 =?us-ascii?Q?z+z5zF7d34rO1yfhXDzebnORVjd9WxBywQXak1aPTksaKBLKnXjQHVFBRGHw?=
 =?us-ascii?Q?vxeyPZG45gQvzkER3xX6R+Pb4Qt2KJu0SMXbxoJh8naUdba3PswiEjgKvyeQ?=
 =?us-ascii?Q?nDrOmSFBj53+gNOlMpHf5NRPwJ6eNiKKUJ1lk2UFWyhbpNhGFxzQZWhJ71z4?=
 =?us-ascii?Q?t7VakPzivXCM8T8YXTUXDmNxbrkDLlzrNlSqovKN6YQhtNXhonOHR4fEG+Xx?=
 =?us-ascii?Q?Dh8c8eV1+PSUyfsnqSr5WOAzn9Z9imtoZiRoYuyoAbCwonq+gsT7USowzGNT?=
 =?us-ascii?Q?11P6AYCwPaE7LGwvx3L6V4P5qm4leWlylwMn2+cn2YpSjwOOl5RR8rq406ni?=
 =?us-ascii?Q?prPkuCM/GJYlyL1V2RE/MhA0kKfp3+JeMRM9bgKCSOiq0H8uXyyeH0SNbJOQ?=
 =?us-ascii?Q?LsPYcH8uMEzI5vEOdH7tTw918/nxJzjZaKd+Q9WjY9sXkFGW5rdvLNEKOpmJ?=
 =?us-ascii?Q?eWimcJrIlGPsoD8VMv+EP9wad+1oh+OInc1oc96WTB3sG8lniWrF4AOtc/st?=
 =?us-ascii?Q?PLeFEqqmYXFNpMg//yEFzG4cJVEZChEYjVT53AEixVHqaTLtqVFMEtwJMLrE?=
 =?us-ascii?Q?FafDJjNYY2SDmLIxDWtWa1sdsQwjwPzjjg7OsWoQ40LIXwY1VBVmEx4AhQ5o?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fab78ff-4206-41cb-d528-08dc1b753dd9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 18:09:14.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vl9bNXEBUXm5tGpgiv31XMcEW5Ogu3X+h6zBoZGqhqn/KY+axbXBhwU8lyC4ciRwOj2v2QTIZmY1P3aFi/mrxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

On Sun, 21 Jan, 2024 10:29:08 +0100 Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2024-01-18, 11:18:07 -0800, Rahul Rameshbabu wrote:
>> A number of MACsec offload implementers do not implement
>> .mdo_insert_tx_tag. These implementers also do not specify the needed
>> headroom/tailroom and depend on the default in the core MACsec stack.
>
> FWIW, I had the same concern when Radu submitted these changes, and he
> answered that the extra room was only needed for SW, not for offload:
> https://lore.kernel.org/all/a5ef22bc-2457-5eef-7cff-529711c5c242@oss.nxp.com/

Thanks, this conversation was helpful.

>
> I'm not really objecting to this patch, but is it fixing a bug? If so,
> it would be useful to describe the problem you're seeing in the commit
> message for this change.

It isn't. I was not sure if other drivers depended on the default
headroom/tailroom set by the MACsec stack.

>
> Does your driver require the default headroom/tailroom?
>

mlx5 does not. I am very open to dropping this patch in the series.

--
Thanks,

Rahul Rameshbabu

