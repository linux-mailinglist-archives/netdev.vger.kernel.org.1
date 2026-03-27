Return-Path: <netdev+bounces-272666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKG1H9PdxmkoPQUAu9opvQ
	(envelope-from <netdev+bounces-272666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:43:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA61434A511
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67112306825A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475DA3890E7;
	Fri, 27 Mar 2026 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bhVoj0DZ"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D237F742;
	Fri, 27 Mar 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640227; cv=fail; b=a0SUsCmuGYklErd4hbppv6XEXnR0DZbUXMidfzOwfC/ip/gbJDjSKsOQijT2qUpysMHuWS8wL2Ou8Bbgqlf6NJmhR+8TI4J2+iphAmLLZ4CN7ZdXyLiy9y2edalCDpb6MQk4nZG68y+wpbdP4o0y7CnQ/qtyI4311wYdmJfeonA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640227; c=relaxed/simple;
	bh=/30KfLQwKGrKqPU7WT/dxLVghbdVmeboLQ1BU9zqkO8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=L2Y4B84BZkDy3L9RWlvGFiCjaVCZAal53E7nAYV2GTFRlqgD/HiY+yVS74PekQTdSdMBNxd+dskqFLRsZnv+3yAiTQz1gVicaiZR7VEedL5YyHVXUyaAu35A5zKDGuRoEEwyN1d3xSiyGz88QFeOuhruGQnRnQctDk7CLMc3AFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bhVoj0DZ; arc=fail smtp.client-ip=40.107.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNtcaUZw+696ojOnuLKZpdO5ulFZmBGjp0kzD2NUMis+vtVxuQ3n/zZdokqvTJ688pN07k6vJaGu+VpM6gyn5Kxl7rgYzpQiPS9Bs+K6hdabAS6+z82jD9cSoyKzolcu9b8kr20Ts3Vu1P3idz1tjyiAnAVIMUbLdgoLZLcX8YC4yWOFwgkxUQacgDKrcn940cXijm/Z0sl98w/dgx3Pnjh5IDrSp7d2tnNEPKOeEzLHvYI7ivJRi6BRi/L8vGHElKDL2X6yp9jBz3tctAj5tyAUfHxSBmaFMESuB0VSlHyzpc5P1QZxJlXkM06wKvuwONLeiCMWJGY76QfMR7fKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwFwKFBW0FgVr8TQU5eDiYzlsi9SqI3Lhyclak8q7g4=;
 b=NN8iitAW4WWIbAZsYLcvAJcrE+wpsDzAP8Qfg+DfDaL7yuOow4vq7dBxHbtKW3jMwTsxNHtIGUlvFNRcuS+uGcIRI8u2etK57aIKUex7gQH65WdMDh58nSZuy5vITAOqrPnXumEOLWEaxg5g6o3nrMtDOtc9PSMspi8dN9XxH9wZC3BKYXS8uWcbo+IibNjpOqdIx61Yx2whKCwkH1bF794RP23uxj39eqlEqSm4NzVLx5OMvh0Bz0Hqp9j7+V7SsYypL3md8kN1B8k2I5nPmst0E9d5EzDxqZ7P0lDRLcc4Nj7PAERCUdnm+ir9TkUM18DsfwipqU6zTUd9MebsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwFwKFBW0FgVr8TQU5eDiYzlsi9SqI3Lhyclak8q7g4=;
 b=bhVoj0DZ1F8jXkoDQQpVL7Sp7aA9AZ3febHWU5q764OPdlTBZwmG0qlCl6VKa9F2EkXlcw3D4Rr6ZVAT7YQ7HyIUVxNqfVYshstL6se+5cIgZx4leVLBJoi0S6SP6k6d0x169TzcsHrFs/3Ilw4vPi0S/T0tVjgivLxIA9Tt3Sk=
Received: from SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::20)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 19:36:55 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::78) by SA9P223CA0015.outlook.office365.com
 (2603:10b6:806:26::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 19:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 19:36:55 +0000
Received: from [10.31.193.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 14:36:54 -0500
Message-ID: <54f54f8f-e3ab-4070-a26c-1bbb6490493c@amd.com>
Date: Fri, 27 Mar 2026 14:36:53 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v24 08/11] cxl: Export function for unwinding cxl by
 accelerators
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-9-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260323113117.2352709-9-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 27eea9a7-2201-4a4a-dacd-08de8c38342b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D02psBzui0fVBgKGm3pbdYGEl8vzZGry2jlwG909QeMaraIpLkBkJILrm7w5O8KZxcIkCrHF/NBCQ3IjlOMp2bfOPx9JcYzsT5paDbrp/4yis0qCONAMdjbDbnMsPepay9kUkKsdx8v3ENaYt2aw2tNqhGrsxoDI0Yt4+WNnTznbv+6I+Fhs0bK8q28kEAvDZ9Tk+bwOFUaMNiPWOaMxF8LOTi0sv4ViytTAw5NxoBeQJax4Sm4I6aKTPS8QAuURqCcOfIrdwxPSF1zyItwFUnBnR4t1sWP7cC13n07ct3mS3M73nPuF8/mhRIMYyJINB4tQ9VIPngP4IDTG4UGyiM9dPtpxV8AmlGH7DRwB+fq0+aI9FDg+ikPGNMjc6PtLqh7KD+pIDGREanBEQFeOFdwITFIwiPbvXi8Adnqc4/48ovwt1kFhadwW0tny8mfVs20iTp3XqUCqwUyBoOfdT9J5Da4ooYXqTdlE8+5Mtt6kT5EXSDFI3JmSiES+WaMCbIicyXDnscc6T85QtjWI1GcoPoKpLmpBcptvOktosjK8cyy8jQLH0NhFoZDCkwW769OhjKGwizkvao/3ui+/wnL0Ka/fgT2NfCuzf/ZQWUy02/YJatiIRVypk646AxsactwpQelclrbK0xjHhMcyFqW0HfCsGSsFdal7sCAOuBqM5Sc4OKG7vugHOoOlppdQqb7KxdKQMzAWIkIjbOu4S+7hThFqEfvBlc0orYvJvaAC99fGG37RvgjLLS0b4NaeihIZQWnQeQlfN2tP2+HjBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FCkNhkyT/5tKLn3mTLz2/Li9ZFOASwA3h7xsFn2mJWA1ClX5Wpig6qxZqBvKsv6yCpPs8IBfiNXl5DA5JH3FpjmYJ+8nWgwoGKW7m3DR8AnibvEdQ9/5QiOvaEZJS7E8hsa/mmksW/Xk/vpC5XcVKxQPT/1/NqKK62MH24agyVgE0UHDkdytwn+xw8SmCXJN46n04Ipxk4d/ggurJlZvdkPb54dWM3QFam1trNz+Oo+VyKCihz/GYVMS5MWU/+xU8KHpDtACo4F0OQoHpAWtL2EB4WbzMGas3TpSe9KfN3frTRMGx/QzlTtWPJVqXxmjLMmLSLbQMpIH8+Vmx/362JzzKJg9q478vWT0+cRPqYzdTN4HLWQNodCwKUlu1/4cX3qGvhr/eT8ScI4X3u0JJec0sWraTuhRQNOfGEm7QpS5HVWEwXZtxMQ81LW+Ungn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 19:36:55.3908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eea9a7-2201-4a4a-dacd-08de8c38342b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272666-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA61434A511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/2026 6:31 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add cxl_unregister_region() to the accelerator driver API
> for a clean exit.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 17 ++++++++++++-----
>  include/cxl/cxl.h         |  1 +
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9c3ba911d865..8bb53a095290 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2468,9 +2468,8 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>  	return container_of(dev, struct cxl_region, dev);
>  }
>  
> -static void unregister_region(void *_cxlr)
> +void cxl_unregister_region(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr = _cxlr;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i;
>  
> @@ -2489,6 +2488,14 @@ static void unregister_region(void *_cxlr)
>  	cxl_region_iomem_release(cxlr);
>  	put_device(&cxlr->dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");
> +
> +static void __unregister_region(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +
> +	return cxl_unregister_region(cxlr);
> +}

After taking another look, I have another possible solution: Leave cxl_unregister_region() as-is and
remove this wrapper function, but only register it below when the decoder type is HOSTONLYMEM
(with the below devm_release_action() calls updated accordingly). Then you'd add a disclaimer
that the accelerator driver should call cxl_unregister_region() during it's cleanup to cxl_get_committed_decoder().

I'm not sure that works out better than just letting the CXL core clean up the region and not touching it in
the accelerator driver though. I could see the above approach causing some region lifetime issues, but I'm
not well versed enough on that to actually know what they'd be :/.

Thanks,
Ben

>  
>  static struct lock_class_key cxl_region_key;
>  
> @@ -2642,7 +2649,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> +	rc = devm_add_action_or_reset(port->uport_dev, __unregister_region, cxlr);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> @@ -2797,7 +2804,7 @@ static ssize_t delete_region_store(struct device *dev,
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +	devm_release_action(port->uport_dev, __unregister_region, cxlr);
>  	put_device(&cxlr->dev);
>  
>  	return len;
> @@ -3963,7 +3970,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	rc = __construct_region(cxlr, ctx);
>  	if (rc) {
> -		devm_release_action(port->uport_dev, unregister_region, cxlr);
> +		devm_release_action(port->uport_dev, __unregister_region, cxlr);
>  		return ERR_PTR(rc);
>  	}
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 122b3331469d..b8cdc604480a 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -236,4 +236,5 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>  						       struct cxl_region **cxlr);
>  struct range;
>  int cxl_get_region_range(struct cxl_region *region, struct range *range);
> +void cxl_unregister_region(struct cxl_region *cxlr);
>  #endif /* __CXL_CXL_H__ */


