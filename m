Return-Path: <netdev+bounces-272664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJazI5vdxmkoPQUAu9opvQ
	(envelope-from <netdev+bounces-272664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:42:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEAA34A4EA
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B849305FFC9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7D37EFED;
	Fri, 27 Mar 2026 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pE8YAzn9"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7930383C77;
	Fri, 27 Mar 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640210; cv=fail; b=IE5h7eS94AdPjqv1yaEBnJDpdsh1g6SLlYNJVUgGhjsKxPUPVFqz3K8s2yrsOK83i4gdGOWL1aYHteXTUy4lCwwgBZU6KQxZkrT4n66pQ0JZeVciYVZci0a5uu+TYu18dNFaKd6Z4JFWouGLxB5srVNCxFBH71KcZSYGsQoHYZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640210; c=relaxed/simple;
	bh=J3Et0Bhr2Eh9IVqpUnaYvzBlDO+NFTQjemoS/WOC6GA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=B4UTqIKpbAR3/4AS5va6PIn/pikBF/NsDklJuCYZrpwPgJ5+K34cZsmlgv5ADTjjo2SpPQlawH5VdJAxOMF/0o6hThD+XLjQa+6Nk/0mJDiU4iCL0Ca7sI41groy9jQ/P4u2/yOq5onDUP7a6NCgKjXBsalpbIzjlx+Zu9pNins=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pE8YAzn9; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs7jPWA89GRqyinBCSh9f9FGFKn16SaQ4RLVIXj615/GJJXXhBANxWEp+spwwTs1eq5sz1P/OAdF3AASxalV9KH1XFWFmWLUqj+Mcpf1/H5fYkNzqgmEGNYbnE4nHzcJ72tqzc7OjPVi/BnUCYzdsultw7xs6otY0TnoWLPPd7YcoQJ5pK4k9NzLEZrLWeo/W3h1cadSkJl54fZ8L2iRzUm+mbWasJbjIBSPHWkjEBuDUo1HVU6gjFy8CLz3bjy4mHGj0XnNjO6xHL/tnpVN52TS0B054XwpS9j/A9RSNufKMuMwYEG3fTLsGvO1fdQuFvVah0CHUUzSCPDaKtIK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eZUTHZhBJEeUm+zecjWolgL9ueqAOSWyDO4KP93o+Q=;
 b=XLVReTjorPZjQI2ay2FjQFLVxoXoSupg/43JJ5PBnFYURxlFivwU8Ulu9tmTO7uHmBy/UFnfsHqiLmBNKL51fKezqZqaQVCcLh6ixbUomkawu0wPBAJd/r8Oqs4EqbLg8gX2kOm52im3wbezPHdoPmzS9oB26VnJfBZtxzVasowMVQe8sUqgT3t2Rl0rZdmJhiH4OjkhcctBf0aT7Co33XJzhPclNd8TN9/gf+9rCzZl69ZL5iiDj92OPmJRtDRFlBGMgfgbnvKmxr0bbe3QNpUMYppqpzrcG4JMAmxHlIkZnunQOhJu4/aV/R/5KEEU6Wg2UHxa7UOInJX7BH+cjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eZUTHZhBJEeUm+zecjWolgL9ueqAOSWyDO4KP93o+Q=;
 b=pE8YAzn9BZo/8VNu+xEacESh0y4pknZMWdba9TZRiDrWhpRbL4yxbXHAMQl1rLJmj3I2YyuduuTgieMlh1eVPYgJDrhxjh+KM3z/3PnIxo/Jo8pLXQXVS96ji1i3z0pigjCtG1xN1c4ODZ4A/esM5HdxZcVSuUaFCF28hiR+U7c=
Received: from PH7PR17CA0049.namprd17.prod.outlook.com (2603:10b6:510:325::26)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 19:36:39 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::32) by PH7PR17CA0049.outlook.office365.com
 (2603:10b6:510:325::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 19:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 19:36:38 +0000
Received: from [10.31.193.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 14:36:37 -0500
Message-ID: <40f6ebb4-383c-4526-a526-c405a1c702ea@amd.com>
Date: Fri, 27 Mar 2026 14:36:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v24 06/11] cxl/hdm: Add support for getting region from
 committed decoder
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: e024f1ce-8c8d-42c5-fbf8-08de8c382a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RCYGtibqScYc4gaKmzCd8k/wgGtqBsAeEzzxHR6TJHd6SoXCDbVC7AR1jBZB7p2zy24EdhdGrp3lA/cQitgbvrx2AVvuw8Tk3QaZ0EvQcYSsf0fbJPgV8ec0u6RQzhuVbsJlDLiDKGSxuAtRVWlf3uzxHzRJD3pMFKZT0PutyWdgQwMV+AeqgJIBtGAkRWEegtdtkaUIEA1F1afHmLJx6sxgFotG3v6dzXGq0LB0cczOXzJw6fSzZN7Ac7bCJ6oO/TUKKvo3BnUA5LfLyTXftEO0BUfNOY+hN9jcdyfpA1tNJWB10Y6W7gSOoBKPR0tGzyMBLRDc3ECXzpPEJwYyH8A+iefthiPh6KAKsXtEUeE6YxxP0WujdlKFID3rC5Z0mKGJ/r8bgEq68n5Ax8Vz9BYlLaSNd/1nVZhizux2fnw/Tx4GSQZl31D/mq0rWP8E1rcq4gvrfrxhTxPekomUsw0z791tmOQT6u5KekJFPwzJYSrtwQUwSfZACDK/vkkTgqBgm75zYqcBh9IdNbpc73aAbeee5ODxc44W6eTrtC6kOUixdmRxgrOx3iWkUSni13UTF5SsMVLZ73ms41sRFbH1vG/owJJeP+n97ExQQTzVQPq5ybPeQE1MKm/QxtLUph7xTv3Agc8eRNivZls4EHFEuZbNdx9anYocG724jsYCjTSS7ZRaSUUlmsfYmQluN7xmdjmWkPUvV81cZoaCweKAngJqRJ8dduGHIuFhY7rLKOdfsLiSG+E7IGLDqBgyEynqxkcOHt2OuowQzZr0VA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0jKdtRZ4tY1cj0Ix2+B3FN7t2rUg+iBHwLVr7CqLG8LfQHxWp6g/R3wLE9SsoevgD+FsO0huM6bF+X9adXK6T2Ma8RlfyCpc/5ka5ezT/Mz5miGKZtK27A+B8JwhXCNhC4tKMjSJtrTAldvda51WKabTBeT9XFUwEkRjVk8dqdfdgfXB9eoPFhNvpeagyHs8/awdtU1XAR/RslN7Si1lsbfCUzHzZL7JcVFxysAd19dbgo9moGNwair5eBIwFmL4eNLgkkQ8ztxtqS7KjtvePtTRDZ1w2gj99Ly8Y9oMDAY7B7ho7zRm6R0M6L2qHlOp0HeQi5Q4FoW/uaTzfxoohwIla3p/pm3UCRjFd37170P35gBCRYbqwJAFeaJNfGIL6/aPNm+mOLCipNrlSFaltqYVLEaMP1VI8yjiOtRs1sTppEdJ5EcQcRKZC+RSW3gA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 19:36:38.9900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e024f1ce-8c8d-42c5-fbf8-08de8c382a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272664-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: ECEAA34A4EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/2026 6:31 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type2 device configured by the BIOS can already have its HDM
> committed. Add a cxl_get_committed_decoder() function for cheking
> so after memdev creation. A CXL region should have been created
> during memdev initialization, therefore a Type2 driver can ask for
> such a region for working with the HPA. If the HDM is not committed,
> a Type2 driver will create the region after obtaining proper HPA
> and DPA space.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  3 +++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c222e98ae736..006be88efaa5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_committed_endpoint_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	return cxled->cxld.id == port->hdm_end;
> +}

I am still not convinced this is the right check. I have two reasons:

1. I would be surprised if just always taking the last endpoint decoder is what we want here.
There's no guarantee that the last endpoint decoder is programmed to match the range, which is only
now an issue since you're not looking at uncommitted decoders anymore. Suggestion below...

2. I'm sure it's possible, but I'm not aware of any case (outside of interleaving) that there
would be multiple endpoint decoders above a singular port. So, it may be that the whole check is
overkill and we can just cast the endpoint port into the endpoint decoder and be done with it.
If the rest of the set hasn't changed from v23, interleaving is still broken. At that point,
I'd say ditch the interleaving support for now and we can complicate all of this later.

Suggestion: If you don't want to abandon interleaving or I'm wrong about the topology, checking
if the decoder is committed by checking the HDM decoder registers directly is probably the
correct way to do this.

That gets you *a* decoder, but I'm not sure it's the right one. Getting the right one would require
checking the resource attached to the decoder and verifying it matches the HPA range expected by
the accelerator and/or region. I don't know if we expect the accelerator to know the HPA range
at this point, in which case this is pretty easy. I have an inkling of what to do otherwise, but
I'd need time to think it through.
> +
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +
> +	if (!endpoint)
> +		return NULL;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
> +				      find_committed_endpoint_decoder);
> +
> +	if (!cxled_dev)
> +		return NULL;
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +	*cxlr = cxled->cxld.region;

I think the region type should be set already at this point, so I'd check it's set to
CXL_DECODER_DEVMEM here as a sanity check.

> +
> +	put_device(cxled_dev);
> +	return cxled;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
> +
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 10a9b8fa2f6b..2a61138e2a73 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -231,4 +231,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>  int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  				       const struct cxl_memdev_attach *attach);
> +struct cxl_region;
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr);
>  #endif /* __CXL_CXL_H__ */


