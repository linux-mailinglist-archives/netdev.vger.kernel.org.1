Return-Path: <netdev+bounces-89381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CB8AA285
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57261F221DA
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C917AD67;
	Thu, 18 Apr 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QS5XliN+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23717AD78
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467259; cv=fail; b=Qdj4cfvGDm/iZu0kYXNWVOVoNo9xXUwFVY1106/2Xo50nekQxPtYmbMzjY6UtFZhB/BiC/mXBMMTPpPt3OuLMPqls3Kz+EkN+8ycUHYM8k2TB2cNQXGVV6zfE6bvQ5RAFdolIw0EoNFl7gqxhIP4sVSRFCPNA2vmHvVklsu1zMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467259; c=relaxed/simple;
	bh=ynmooIUB1sSB2JfyJt/1uJOs29Nhjdq16eUpXz/L6KI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=StLR9/JoePIbUEdo6pZl0AYg8FYSsfCJRqOdDLoE8syEtHrcZRDvmm5JYepq7wliesJA4Lwo+tmbHbaDclQTP69fY1oZlqYTKks5Cpy97ZUjzDtk5CndgrE8/f7cF26Dm8z5A83Fu44uV5FjmfXNwaSb7ccRHD3r+9zn0y3EQ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QS5XliN+; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihlizmMgp0agQlvI++4KB8pQbNtDPBZDmjIBkRZxJmoteb8EToJ9KvILeQkTlec/6XtXexRzgDLw+TSP7ARc23ULjPUErb7WjNItqGpbcZZHZ5HJ/ehLTyzzZuNW2O0YxlHBqN+jA0giOvGO7nWR89wcbFtuzfXSBMZYSHsaGll6sVm3LFMlzVfwRU6I/Y8RQg7aZQmlruSS2QJ1IOQtcAn53YdAatIdMcmyJoYRuNv0KfF8ApFx+rMs8U4O4sxTjSRUlh60JtpMSEuH/RBBcIsVZUaMAprj4esxCDKqBRXM4HbY6491baBghYJODsmRTmOe6HpdMvu2lgzzW/CzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynmooIUB1sSB2JfyJt/1uJOs29Nhjdq16eUpXz/L6KI=;
 b=RSuRb/E7gu0XXG4PGQBecMKv9vfe4Y+EsXLTgWTUR/a+n3beE9kmGvM91TeRwtEbo6U5QghOi+fM/roeorunOMlaiUhvVvFl2eHqKJn0lKsmhzF6Of1cEufI3+27KCLVagCSuZkuH6DL87ILB2QKhDOWmXuGV8LtDSE5ncp+2fFhaYj13Y1xRyB21jidGO2WtypAUBwOZgUqon/XMSxt1oX0vzudNqAZVXMLNJ6B//BQGCZIAW1vW1xnPhBpD20Q1qIVktR4tVJDAnFzlOKhl2/HnVRLUK1zbelOEo+LRXdZYPZ+W22gx5fnKto5JOHl5wMn7ndC0zjECMMZ2aCjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynmooIUB1sSB2JfyJt/1uJOs29Nhjdq16eUpXz/L6KI=;
 b=QS5XliN+fbLO0/JCLFKzq08qd44hEzs5iV2FO/JRJ1iRFip8TjnWIpRaALj1yeLyLODzkr0kcFJuz2YzAQQmPblvkFTET5MKjJeWmA5xRtZ3dsgIyL/0p+z/rdqa1m1wdRBW49F+AQpLf7yz7F/xZAESS2ueW7DC0b/d3x8tCX2hiLN/mI/Cy60BGzXWs19At3VuAi7G3n4AlIrnhyu+IxIFjSq8Qf/kYc0Z1rIEK8svdb07Vb5jxRoqRM/HVs8PM7tIz5vzHu3i6J4xXfzeS395qkIdT9LTM1frCe2Jtk3vPEk/w7dYQVOgVfbw03fVA7vtl7LKryo7vX9EnkKTSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 19:07:34 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 19:07:31 +0000
References: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
 <20240418052500.50678-4-mateusz.polchlopek@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 horms@kernel.org, anthony.l.nguyen@intel.com, Jacob Keller
 <jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 03/12] virtchnl: add
 enumeration for the rxdid format
Date: Thu, 18 Apr 2024 12:05:13 -0700
In-reply-to: <20240418052500.50678-4-mateusz.polchlopek@intel.com>
Message-ID: <875xwefq1a.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: d47b1ac9-0488-41b3-13f8-08dc5fdacc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	83hPZeUdLI1IRPSg273wM7Wljd8IiaIyWEL0kPgzxxGsUtw7wJpcNUFO6zPoVHPEK1Xs+EFGWcKalYiE7bwmTpneq9eI7tqdCZnU9ffWZLfGsvQJxkksz4uhbXeYdn82EiKj0wag2OPskG0gILsDo4LoNPqajOYiangv6tuZfw5/jaaMVE0YXlsq2X8dU8gseF3h5Q2oB1gSeid7ZRGejZFjCGX73UCBHHQnxfUDW9H7E6pn5qeGq1L2hJCUtxGfmlWlnLPv9LQJHv89lrb5ZLN1xC7jzZYorqH/G9spimKJZ/QW5EvCKvKURu6Su3iXLy+6QBvNUso8NDsjg9wQ11CeMmvGcjDgYX8bqgnDyS025sX6SLDc2TaT32E1JiOWEUazC8KIcG4+dIePY2IXbnu0EH0NicnpFLAl22eMPlFCjL+itLa9SGriFhDwqms8tYLy843EQSOrYv+GABulygHLb22UmtidjaglPdHfNc6XcfcR6BEF+zeGb1nnRHrr4fI8z4Li5ufcx1b9SwWUl3C0jxKKXvh2uuxDhzvFsTtAbVKn1Hcbw6T8XEC1aDttt8+NmBxFaSXYLeyjxQLO8vRUnOnVqnN594OmIv7PuzuiiGY+luZ1ZL3MPRK3Zl9TJPXeKvrshAtbww84qrZS2sOb5nw3KiF7EHQuw1VW0H8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vAQVPfrUdtPQiTWbUAUSj/PRGd0r7wgMWI8SYTJeqRza/wiBVz0rTnuqvWFr?=
 =?us-ascii?Q?FvSMrW2f7l4ZdE2MReuAvbCZ37V6baLPKnqT14v4qomQujo/nUBK3k/iqrR+?=
 =?us-ascii?Q?edKyftjrKdOB+gRMg/4CaVTDLKUME7W35BT402o7eY+vAVDx8Q2SJ2VUg1jc?=
 =?us-ascii?Q?3j7VCGbygB9BC1oOqYQJ+hg+qoalto+qqvsWZtlBY5NkoWr8ISv0UJ9G8cE8?=
 =?us-ascii?Q?orbFi+cWlJyTbny0CJjocLp0FkkX1OIngUQANZmJ0cNnYQLqHNoURJzOMzlW?=
 =?us-ascii?Q?gK3anWKAHW8G97zlou1GLMmO5odpa0uyK8hlmYAJI9gXDTTtZY4wPrDbS1tZ?=
 =?us-ascii?Q?kQopydBYJw4+/pMFuLpd9ipkzGJaPzDpxD3PEvx5GSDXP97RKS73bLrXJx0/?=
 =?us-ascii?Q?cDVZGHC0Loo3QPoE1ctXRkVuH7w9pGML8Ibsgi1JQeTcCYLHf9sBG1CpvO9j?=
 =?us-ascii?Q?MW6z2JPOWuwDO5mC6CuqByoghU2/QiYROFx68QJPXjTmm7OFCd45o1flqI/d?=
 =?us-ascii?Q?jqiNMD+j5fI/i9dKJMK4uewjT+vbO7iWjjVpVvJPvzEBfnj5ZNYsROPfO3PG?=
 =?us-ascii?Q?xoDWFxm/50rhhRmkyXYjcI0cvrhw9C00116rgzBXAZcRI/m/ul6KT0sgTg2B?=
 =?us-ascii?Q?H4Ew5LkNR9H4P2i7cXWD0bpPJIHGim7VwUh5/E6EndVo7ne968IYPihcKavP?=
 =?us-ascii?Q?pSxPN5qpb8HjmuZk04YICZ9FSoJCjTLMRg6dUY1VMIGR6mUq0ql1C0dVfH9N?=
 =?us-ascii?Q?hxWLrrVNAldMXwZDyVUNxdr8dvtWDyR+YeaPIQEF4FoqlclVa2O3iO9BhOXN?=
 =?us-ascii?Q?RMIpgkakapIHngNr1K6lgHgUvN5v+uW8qfcsdJpyuuP7CaEbWjS+I9/k1TcE?=
 =?us-ascii?Q?B5NuFaumZ3cM60Tm+krZb5vErA3xJnW8W9LMfnYsRxu4cIgDUHAZsEeCo0XO?=
 =?us-ascii?Q?IKoLxiJ4EnN1xjrLKjbLUSKraf8TNF/hWtN57IGxU640qge8rben5bTGoDsb?=
 =?us-ascii?Q?JShNpU41S98ZyRv1HleBvNNL5DyufHNXwhE1Gi3yMVfw43LDlrpE8+UAvBcA?=
 =?us-ascii?Q?V7gmidDE0HTbKOgGfMBEfV8vFIzNlWaUXQb6j8E1BFmCIHd3caA/9qSQGPtr?=
 =?us-ascii?Q?sN83ba3NJm5ooIGUTAqKdR0TBibcQFfIiyTu601hbotouiVrJD8zZKKSHOS6?=
 =?us-ascii?Q?1qJXuvAyzD6nSUjqW/5Ju2RYQL9Rc8rndVQdooD1+wafYt9tDA93YPGc8fQ2?=
 =?us-ascii?Q?Dtot419PxknBHYJ2fcpJ1VzH75hM968B6DCTLmKHPgdjEcHvB9YRzgxN8MRI?=
 =?us-ascii?Q?VXcPl/YP83cyFAD+XLKk8GAdX+BlwE1pUbzAXYU5Qkq5kVmJZ9TqkTaVw0JV?=
 =?us-ascii?Q?lkG8NJu0MDnH8tZkJ8unLDRdCM3r8mtkgMIuH30wKfqHXdOKSZuby+2j6IKS?=
 =?us-ascii?Q?ifyWfXBadGG0lnGYFv4CughXljpagZGFT8jhIe9OyRR3QKtK11m66U/pPkuE?=
 =?us-ascii?Q?FSqTpwWSWLx+j4X+lEeO6/hX6wtkDnGim27rzeWC7d2WEWcFbIfLHYlY2S6G?=
 =?us-ascii?Q?JaO6kHOeCRket4wXQx788wFX8KfjwG712m3tk5Vkq6N2iSUsRYwj42kchRWS?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47b1ac9-0488-41b3-13f8-08dc5fdacc14
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 19:07:31.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fIayrTDshpXd1FmmuB+TG9vGNzsql3FeejYE0ll+kjXHMX8lHu514MoQtAi/FDnhctefTksZVNitS/jDo7Qpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527


On Thu, 18 Apr, 2024 01:24:51 -0400 Mateusz Polchlopek <mateusz.polchlopek@intel.com> wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Support for allowing VF to negotiate the descriptor format requires that
> the VF specify which descriptor format to use when requesting Rx queues.
> The VF is supposed to request the set of supported formats via the new
> VIRTCHNL_OP_GET_SUPPORTED_RXDIDS, and then set one of the supported
> formats in the rxdid field of the virtchnl_rxq_info structure.
>
> The virtchnl.h header does not provide an enumeration of the format
> values. The existing implementations in the PF directly use the values
> from the DDP package.
>
> Make the formats explicit by defining an enumeration of the RXDIDs.
> Provide an enumeration for the values as well as the bit positions as
> returned by the supported_rxdids data from the
> VIRTCHNL_OP_GET_SUPPORTED_RXDIDS.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

