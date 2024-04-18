Return-Path: <netdev+bounces-89383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405618AA297
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10251F21B29
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D01717AD9F;
	Thu, 18 Apr 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ThSVyCTm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475D6A00E
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467761; cv=fail; b=jhLfKuOxOPOPoKlFhwALpwFj3eDIcOeM5es7+GYh5kg3L3o/bpjLepm/5rWoMzWVILTELILR82E2TSgUOUFSVavmuUWYj1dVArUQs/iODGEGvfj97OMSImV2lFIxgNFValGqD/Bbe6SFVBWYnJt2f+H7cMIXOlVnXofeVg45Jh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467761; c=relaxed/simple;
	bh=jW8jtNVJ9xnsb73rstSE/XaZt7qc7sIygRYrfmJYIMs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=p7atQz8RjjYG31c1JD+cSHtOehll3G60OEhGDTJYDO/5sUgrcMBRl5dJFUC12OY/dwQZULBM8XO3daYoekfVLfSTHLX22BqU/2T7xNZUoKaPglZ1sOmMA1xPsRuMUBkw2MfQfaxH01Z4WWID8JCIb/XxdW8RA2XoMFJMiF/yiZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ThSVyCTm; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OueQdZ8pMxJaL4wYKJYmkDXTh60oySHGDYv5430WxFHRVy5LB28BMSv8WxZdTVNjE4YPhsW9PL5SJR12r4h4o9wfKc0FuAa8EtzkA4EMa56fjgrsdo14GHDDXOJw14mRlBFX9GKKOYo3r+gSkIxSSJEVhSDSHmX7aUhFvTQFZcghTnLLNJr1XzZN9SasydqB/kQ73Ja3Nug7915sF5lYOmm8pqOvwhm+6BT3/PfBLLtnFm2wFd9b3BnzW/pOujkSdyhgMMT8LENwqntzld+fMT9w9wSFRZXyefqzRRoT7v+SVRp1+5QXv0hGOJKM7Zyw62xIzlnjSmpSS3y5tObPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNKb57odsL32BeGDfsWNFynKNhIrVwSKr7l4BzxRlDE=;
 b=Uq4sxSv6qE4cWROgY/TwWBygDfdyNsI/r3PlmOMv4CNUH7AlTUVm4vWKGe9V/+xGn9MltMRz8RfNvApEMU/MbNppVafiETe7XUBzInOHXXZEJK1ILeyLGYCmAuw5+ycf3G4BFWJ1WjGjDPrKZxhK9fnaadkeVkjb2R6hQoF1CMCBLukICAfzqwD6ot/1W64qPo9jSX8BHyvS1icn3T5jEjymLuqUUfy99Pi5dLBlGRjwYQe140CW1KSd9EkHmbuoOpDZfmtXNAvExV1X59b0Z6D1pO+OsOQ7T7uwwk0ieolg4Ikd0RX+fiFOnWyus6+HQPE3S6VNw3cfhI5XnqjJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNKb57odsL32BeGDfsWNFynKNhIrVwSKr7l4BzxRlDE=;
 b=ThSVyCTmByTCSrVEEaGXKa6sEfKpLqSXZn2qSWvFdK4/WqyCFNTwcAt56b53xqLoaX2UL4dthJrko52gK/Ih0EEu6tPaYJ6qXHOQ/cyneRsQNipagVMtZNw6F/XVdeD8P4oIr3z+4cuH99CDEO+f19ogph1PU4STOnZ51N4fxd70WG5cpwxB/OuG6ec/jB9WJ6YVA0SigCpPVYaCbI6/NeJEmNWuQytP/uaI0a8ZFcFn1ZN1atu8KfOtbh/MpZGzoSBHj5RJMBcjJtYFfWWNWOCL159j1V1zslmrCDKfzBebDNfOA/gCg+SBHU/6MVbWGPRwlqO0mP3SSmnBwudW5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 19:15:56 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 19:15:56 +0000
References: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
 <20240418052500.50678-5-mateusz.polchlopek@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 horms@kernel.org, anthony.l.nguyen@intel.com, Jacob Keller
 <jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 04/12] iavf: add support
 for negotiating flexible RXDID format
Date: Thu, 18 Apr 2024 12:11:01 -0700
In-reply-to: <20240418052500.50678-5-mateusz.polchlopek@intel.com>
Message-ID: <871q72fpn8.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: b509e8fb-c066-4297-a50b-08dc5fdbf95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FXzsXoIxvGQVeBUEjBXT3+/p6syC4lIW0ukFfJ2bKXHKhn4FdMNk7A90MuHMQEbYBWrZ7NlOcFEsFtREWRkTpLzqKzxAG/3wNVmUP0YPiTja2Z13Yg9Okhalh2cp5NxFtF9zkd7ORliycmqhpYvNPICwpKanSLKNJmmUdl2g0i5Arv25QHAP3C9HQBsIAugV9ytUpUqzSmIzk5IjpwYCcsTloGrWtJ7IA0+ol7lIeH8br7ZB0SObBB26Tkx61abxSEnqw/gRFgGvkukIXLNYEOTHIfX0RHzM7G1OLbevJ2Iu+ooynWpZpArZYYRUsayFyBxjRnGpKoWe/srka1LDzh0wy8aj+P2s+EZxb29QUaTv7lzrH6px8DsLgmv+k9NXB912z7ThYBDD5BkTgatuS1FITuS8o25Z3mymEZ8JOuL5HT3bFB9YhBOgLNeNKooNTJPsbFEUvi1gW7IHk9VZEopZruZqpGYwFCIjWxpW8KLzECpmGRsg6gULty4XP6GJol0F5QZT3B+zBv1EnUx5MNmgvK28hBL7DLcb9KSZ4ehG8PJdM+zc2vnI6EzhGB26dckrbLNhnhDndiZG9nSjq345Vv7U4juv+Iui1uvV/4JjNi7+VpRmIgYWVaHmKfaWw3MnfC/3MzmheoLKsK3Rju5rUFU2XXd8PLm76qhlecg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vpGQ/AZc4PzqVFy8NEl2yL9IxdLbXIr8vhN2p0dB5RBjOaycEwNCaNtu+zvz?=
 =?us-ascii?Q?8zMxPOCxbukIisu6kNgMpYVLmRHa+BqYZGqoi83nfDyHqGs62dEjvVwjSqWV?=
 =?us-ascii?Q?gSEbVST3z8j1mdwQ0cphZpaKq64+kV3DB2cSXHC3jCjpXlHzJtwAadMXo/Vv?=
 =?us-ascii?Q?actCTJQlL8zUjFaSfWtap642puy6dfbkFxJRGi8YtyygslD7plyVKitDwVP5?=
 =?us-ascii?Q?0TaAcQr/UeOFVJd9MFstNEC0uOv6iFqvU2uJ5I0O8s3W7xu2XHcTEn4oH63y?=
 =?us-ascii?Q?H4iTnkawjf1G9fceY3Y0UKS7t6/PhmMEvYNKnpW2ACLpFaZGLUk21uaqC59e?=
 =?us-ascii?Q?S0/j805lYv912+cPZ67Tte/p8SwbEBk/gKHNv0vHtn2UZFKdm+hPEc1LmE9i?=
 =?us-ascii?Q?QykU0ayp3rA7Fhgb2Vpc80tsvCMv9ulbSzVuBo19Wat4r4PROBUBEiAqRXC1?=
 =?us-ascii?Q?4BlAZC3F2rgLg6x7cNDEQFOFeuB98eOOB8tt/qY/owIL4XB8z7YtVSSUE3KN?=
 =?us-ascii?Q?u1L+oW8lig/Kcjefp37jZLjgKsdvObkMyrHwPhlfcR7n3hERRPXAKoKUraNM?=
 =?us-ascii?Q?+1EPgWrziX0TzwcjKAi/5MrymCNTJmfptcmtBs/icg62Z8Ipi7HZ5HFYMZOj?=
 =?us-ascii?Q?escibfw2SY520XlyChfH+6UZXyuTk2PmNJX4zrWNS5iI/QUEOJr72k1MTsEx?=
 =?us-ascii?Q?7kyBREZOFX86yh2GHLPLS3crQUP/lz1SkEaX+UH1Q5UyX0NU0nZRC2LWtHGo?=
 =?us-ascii?Q?PQyZ4GlizmZ5Iy0BszWuG8dBOVib22BqZMmPu4WaG8uTY9CJXt3Ch+OdhZ3w?=
 =?us-ascii?Q?qcprmBb+b19kC/UiA1hM0QDqMDJOp5klev3sXp1Cn0OczCF5RxZY0Z1N3Nq7?=
 =?us-ascii?Q?KZZXLwXfpC3x8TIIW2RLdmbYa347IBcLlB+z28JmIHo9iP7kDiYGYhg2P1GQ?=
 =?us-ascii?Q?FQb3LliKgRhGA7E0sU8Z0vs3YL/RgCgRzymd+4ZUJrV0lEiKKH37YYQP27oj?=
 =?us-ascii?Q?4j4GYn6R7bzT2J/6aLf672njzUKyEjNTaH53lIPqiJD3ZSjLss2+WRTrMCef?=
 =?us-ascii?Q?beeyEYmtVKAOk7JJ1MCnTLjHZzRuiA5EkG8/WplWLOQj9RcoMxH/tPz3Bru/?=
 =?us-ascii?Q?kyuNJSHf7tVk26INCYtufabiV7iV0C6Yum5waG1OWJ7C/a2JQ2RsTFbEpxUq?=
 =?us-ascii?Q?pzbrttyR+qptw68ukQTf+9uirl0iY69M0/jvHdrgarcJZi4BVH+icur4SRgv?=
 =?us-ascii?Q?WsthPElH9XSf6lK2EsxfLKFgZ5SErDnzvGw7+0q1g8OJnyEnQHPxTfod8LZ2?=
 =?us-ascii?Q?Eu6pl+ciFeI66DxZaVBFaj1KeI8MRlW6NIrJNO96EYGJ2/beyLDIjW2za2Pc?=
 =?us-ascii?Q?UVwkI9tEgfd8M8OoYWeYbBHCaIGxxLr1EJs8El7Sujg7DbhcY5PFx9URldwq?=
 =?us-ascii?Q?d5YZa+sNfm99c5EdPLRON/k/aZoSZcJFpP1vAMYNbylhEMnKBeZwhvBkEaxq?=
 =?us-ascii?Q?bj8LhwVExAJRk34XOb826cawwMK9OUo63Ei+tFn/SV6jWbi1TZcAb0DDgYdx?=
 =?us-ascii?Q?sjWapXIWCHpIISjyVsXAsbtD+hCEEcq54p2vO/fOXox6ToQv8FFnmYwpm69/?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b509e8fb-c066-4297-a50b-08dc5fdbf95f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 19:15:56.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15DWaxNncrQX3HGQ62qNB3Tipe504HU6qjyzKUU/BCB82ZC84431+qj1VTN6vFBT/2y3mORyv1XIdHt/TcgexA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443


On Thu, 18 Apr, 2024 01:24:52 -0400 Mateusz Polchlopek <mateusz.polchlopek@intel.com> wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Enable support for VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC, to enable the VF
> driver the ability to determine what Rx descriptor formats are
> available. This requires sending an additional message during
> initialization and reset, the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS. This
> operation requests the supported Rx descriptor IDs available from the
> PF.
>
> This is treated the same way that VLAN V2 capabilities are handled. Add
> a new set of extended capability flags, used to process send and receipt
> of the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS message.
>
> This ensures we finish negotiating for the supported descriptor formats
> prior to beginning configuration of receive queues.
>
> This change stores the supported format bitmap into the iavf_adapter
> structure. Additionally, if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is enabled
> by the PF, we need to make sure that the Rx queue configuration
> specifies the format.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
<snip>
> @@ -2586,6 +2623,67 @@ static void iavf_init_recv_offload_vlan_v2_caps(struct iavf_adapter *adapter)
>  	iavf_change_state(adapter, __IAVF_INIT_FAILED);
>  }
>  
> +/**
> + * iavf_init_send_supported_rxdids - part of querying for supported RXDID
> + * formats
> + * @adapter: board private structure
> + *
> + * Function processes send of the request for supported RXDIDs to the PF.
> + * Must clear IAVF_EXTENDED_CAP_RECV_RXDID if the message is not sent, e.g.
> + * due to the PF not negotiating VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC.
> + */
> +static void iavf_init_send_supported_rxdids(struct iavf_adapter *adapter)
> +{
> +	int ret;
> +
> +	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_RXDID));
> +
> +	ret = iavf_send_vf_supported_rxdids_msg(adapter);
> +	if (ret && ret == -EOPNOTSUPP) {

Isn't this redundant? The condition can just be "ret == -EOPNOTSUPP"?

> +		/* PF does not support VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC. In this
> +		 * case, we did not send the capability exchange message and
> +		 * do not expect a response.
> +		 */
> +		adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RXDID;
> +	}
> +
> +	/* We sent the message, so move on to the next step */
> +	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_SEND_RXDID;
> +}
> +
<snip>

--
Thanks,

Rahul Rameshbabu

